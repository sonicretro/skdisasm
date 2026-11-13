; ===========================================================================
; ---------------------------------------------------------------------------
; Nemesis decompression subroutine, decompresses art directly to VRAM
; Inputs:
; a0 = art address
; a VDP command to write to the destination VRAM address must be issued
; before calling this routine
; See http://www.segaretro.org/Nemesis_compression for format description
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Nem_Decomp:
		movem.l	d0-a1/a3-a5,-(sp)
		lea	(Nem_PCD_WriteRowToVDP).l,a3
		lea	(VDP_data_port).l,a4	; write all rows to the VDP data port
		bra.s	Nem_Decomp_Main

; ---------------------------------------------------------------------------
; Nemesis decompression subroutine, decompresses art to RAM
; Inputs:
; a0 = art address
; a4 = destination RAM address
; ---------------------------------------------------------------------------


Nem_Decomp_To_RAM:
		movem.l	d0-a1/a3-a5,-(sp)
		lea	(Nem_PCD_WriteRowToRAM).l,a3

; ---------------------------------------------------------------------------
; Main Nemesis decompression subroutine
; ---------------------------------------------------------------------------


Nem_Decomp_Main:
		lea	(Nem_code_table).w,a1
		move.w	(a0)+,d2	; get number of patterns
		lsl.w	#1,d2
		bcc.s	+	; branch if the sign bit isn't set
		adda.w	#Nem_PCD_WriteRowToVDP_XOR-Nem_PCD_WriteRowToVDP,a3	; otherwise the file uses XOR mode

+
		lsl.w	#2,d2	; get number of 8-pixel rows in the uncompressed data
		movea.w	d2,a5	; and store it in a5 because there aren't any spare data registers
		moveq	#8,d3	; 8 pixels in a pattern row
		moveq	#0,d2
		moveq	#0,d4
		bsr.w	Nem_Build_Code_Table
		move.b	(a0)+,d5	; get first byte of compressed data
		asl.w	#8,d5	; shift up by a byte
		move.b	(a0)+,d5	; get second byte of compressed data
		move.w	#$10,d6	; set initial shift value
		bsr.s	Nem_Process_Compressed_Data
		movem.l	(sp)+,d0-a1/a3-a5
		rts

; ---------------------------------------------------------------------------
; Part of the Nemesis decompressor, processes the actual compressed data
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================

; PCD is used throughout this subroutine as an initialism for Process_Compressed_Data
Nem_Process_Compressed_Data:
		move.w	d6,d7
		subq.w	#8,d7	; get shift value
		move.w	d5,d1
		lsr.w	d7,d1	; shift so that high bit of the code is in bit position 7
		cmpi.b	#%11111100,d1	; are the high 6 bits set?
		bhs.s	Nem_PCD_InlineData	; if they are, it signifies inline data
		andi.w	#$FF,d1
		add.w	d1,d1
		move.b	(a1,d1.w),d0	; get the length of the code in bits
		ext.w	d0
		sub.w	d0,d6	; subtract from shift value so that the next code is read next time around
		cmpi.w	#9,d6	; does a new byte need to be read?
		bhs.s	+	; if not, branch
		addq.w	#8,d6
		asl.w	#8,d5
		move.b	(a0)+,d5	; read next byte

+
		move.b	1(a1,d1.w),d1
		move.w	d1,d0
		andi.w	#$F,d1	; get palette index for pixel
		andi.w	#$F0,d0

Nem_PCD_GetRepeatCount:
		lsr.w	#4,d0	; get repeat count

Nem_PCD_WritePixel:
		lsl.l	#4,d4	; shift up by a nybble
		or.b	d1,d4	; write pixel
		subq.w	#1,d3	; has an entire 8-pixel row been written?
		bne.s	Nem_PCD_WritePixel_Loop	; if not, loop
		jmp	(a3)	; otherwise, write the row to its destination
; ---------------------------------------------------------------------------

Nem_PCD_NewRow:
		moveq	#0,d4	; reset row
		moveq	#8,d3	; reset nybble counter

Nem_PCD_WritePixel_Loop:
		dbf	d0,Nem_PCD_WritePixel
		bra.s	Nem_Process_Compressed_Data
; ---------------------------------------------------------------------------

Nem_PCD_InlineData:
		subq.w	#6,d6	; 6 bits needed to signal inline data
		cmpi.w	#9,d6
		bhs.s	+
		addq.w	#8,d6
		asl.w	#8,d5
		move.b	(a0)+,d5

+
		subq.w	#7,d6	; and 7 bits needed for the inline data itself
		move.w	d5,d1
		lsr.w	d6,d1	; shift so that low bit of the code is in bit position 0
		move.w	d1,d0
		andi.w	#$F,d1	; get palette index for pixel
		andi.w	#$70,d0	; high nybble is repeat count for pixel
		cmpi.w	#9,d6
		bhs.s	Nem_PCD_GetRepeatCount
		addq.w	#8,d6
		asl.w	#8,d5
		move.b	(a0)+,d5
		bra.s	Nem_PCD_GetRepeatCount
; ---------------------------------------------------------------------------

Nem_PCD_WriteRowToVDP:
		move.l	d4,(a4)	; write 8-pixel row
		subq.w	#1,a5
		move.w	a5,d4	; have all the 8-pixel rows been written?
		bne.s	Nem_PCD_NewRow	; if not, branch
		rts	; otherwise the decompression is finished
; ---------------------------------------------------------------------------

Nem_PCD_WriteRowToVDP_XOR:
		eor.l	d4,d2	; XOR the previous row by the current row
		move.l	d2,(a4)	; and write the result
		subq.w	#1,a5
		move.w	a5,d4
		bne.s	Nem_PCD_NewRow
		rts
; ---------------------------------------------------------------------------

Nem_PCD_WriteRowToRAM:
		move.l	d4,(a4)+
		subq.w	#1,a5
		move.w	a5,d4
		bne.s	Nem_PCD_NewRow
		rts
; ---------------------------------------------------------------------------

Nem_PCD_WriteRowToRAM_XOR:
		eor.l	d4,d2
		move.l	d2,(a4)+
		subq.w	#1,a5
		move.w	a5,d4
		bne.s	Nem_PCD_NewRow
		rts

; ---------------------------------------------------------------------------
; Part of the Nemesis decompressor, builds the code table (in RAM)
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================

; BCT is used throughout this subroutine as an initialism for Build_Code_Table
Nem_Build_Code_Table:
		move.b	(a0)+,d0	; read first byte

Nem_BCT_ChkEnd:
		cmpi.b	#$FF,d0	; has the end of the code table description been reached?
		bne.s	Nem_BCT_NewPalIndex	; if not, branch
		rts	; otherwise, this subroutine's work is done
; ---------------------------------------------------------------------------

Nem_BCT_NewPalIndex:
		move.w	d0,d7

Nem_BCT_Loop:
		move.b	(a0)+,d0	; read next byte
		cmpi.b	#$80,d0	; sign bit being set signifies a new palette index
		bhs.s	Nem_BCT_ChkEnd	; a bmi could have been used instead of a compare and bcc
		move.b	d0,d1
		andi.w	#$F,d7	; get palette index
		andi.w	#$70,d1	; get repeat count for palette index
		or.w	d1,d7	; combine the two
		andi.w	#$F,d0	; get the length of the code in bits
		move.b	d0,d1
		lsl.w	#8,d1
		or.w	d1,d7	; combine with palette index and repeat count to form code table entry
		moveq	#8,d1
		sub.w	d0,d1	; is the code 8 bits long?
		bne.s	Nem_BCT_ShortCode	; if not, a bit of extra processing is needed
		move.b	(a0)+,d0	; get code
		add.w	d0,d0	; each code gets a word-sized entry in the table
		move.w	d7,(a1,d0.w)	; store the entry for the code
		bra.s	Nem_BCT_Loop	; repeat
; ---------------------------------------------------------------------------

; the Nemesis decompressor uses prefix-free codes (no valid code is a prefix of a longer code)
; e.g. if 10 is a valid 2-bit code, 110 is a valid 3-bit code but 100 isn't
; also, when the actual compressed data is processed the high bit of each code is in bit position 7
; so the code needs to be bit-shifted appropriately over here before being used as a code table index
; additionally, the code needs multiple entries in the table because no masking is done during compressed data processing
; so if 11000 is a valid code then all indices of the form 11000XXX need to have the same entry
Nem_BCT_ShortCode:
		move.b	(a0)+,d0	; get code
		lsl.w	d1,d0	; shift so that high bit is in bit position 7
		add.w	d0,d0	; get index into code table
		moveq	#1,d5
		lsl.w	d1,d5
		subq.w	#1,d5	; d5 = 2^d1 - 1

Nem_BCT_ShortCode_Loop:
		move.w	d7,(a1,d0.w)	; store entry
		addq.w	#2,d0	; increment index
		dbf	d5,Nem_BCT_ShortCode_Loop	; repeat for required number of entries
		bra.s	Nem_BCT_Loop
; End of function Nem_Build_Code_Table