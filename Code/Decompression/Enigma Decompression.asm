; ---------------------------------------------------------------------------
; Enigma decompression subroutine
; Inputs:
; a0 = compressed data location
; a1 = destination (in RAM)
; d0 = starting art tile
; See http://www.segaretro.org/Enigma_compression for format description
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Eni_Decomp:
		movem.l	d0-d7/a1-a5,-(sp)
		movea.w	d0,a3	; store starting art tile
		move.b	(a0)+,d0
		ext.w	d0
		movea.w	d0,a5	; store number of bits in inline copy value
		move.b	(a0)+,d4
		lsl.b	#3,d4	; store PCCVH flags bitfield
		movea.w	(a0)+,a2
		adda.w	a3,a2	; store incremental copy word
		movea.w	(a0)+,a4
		adda.w	a3,a4	; store literal copy word
		move.b	(a0)+,d5
		asl.w	#8,d5
		move.b	(a0)+,d5	; get first word in format list
		moveq	#$10,d6		; initial shift value

Eni_Decomp_Loop:
		moveq	#7,d0	; assume a format list entry is 7 bits
		move.w	d6,d7
		sub.w	d0,d7
		move.w	d5,d1
		lsr.w	d7,d1
		andi.w	#$7F,d1	; get format list entry
		move.w	d1,d2	; and copy it
		cmpi.w	#$40,d1	; is the high bit of the entry set?
		bhs.s	+
		moveq	#6,d0	; if it isn't, the entry is actually 6 bits
		lsr.w	#1,d2

+
		bsr.w	Eni_Decomp_FetchByte
		andi.w	#$F,d2	; get repeat count
		lsr.w	#4,d1
		add.w	d1,d1
		jmp	Eni_Decomp_Index(pc,d1.w)
; ---------------------------------------------------------------------------

Eni_Decomp_00:
		move.w	a2,(a1)+	; copy incremental copy word
		addq.w	#1,a2	; increment it
		dbf	d2,Eni_Decomp_00	; repeat
		bra.s	Eni_Decomp_Loop
; ---------------------------------------------------------------------------

Eni_Decomp_01:
		move.w	a4,(a1)+	; copy literal copy word
		dbf	d2,Eni_Decomp_01	; repeat
		bra.s	Eni_Decomp_Loop
; ---------------------------------------------------------------------------

Eni_Decomp_100:
		bsr.w	Eni_Decomp_FetchInlineValue

.loop:
		move.w	d1,(a1)+	; copy inline value
		dbf	d2,.loop	; repeat
		bra.s	Eni_Decomp_Loop
; ---------------------------------------------------------------------------

Eni_Decomp_101:
		bsr.w	Eni_Decomp_FetchInlineValue

.loop:
		move.w	d1,(a1)+	; copy inline value
		addq.w	#1,d1	; increment
		dbf	d2,.loop	; repeat
		bra.s	Eni_Decomp_Loop
; ---------------------------------------------------------------------------

Eni_Decomp_110:
		bsr.w	Eni_Decomp_FetchInlineValue

.loop:
		move.w	d1,(a1)+	; copy inline value
		subq.w	#1,d1	; decrement
		dbf	d2,.loop	; repeat
		bra.s	Eni_Decomp_Loop
; ---------------------------------------------------------------------------

Eni_Decomp_111:
		cmpi.w	#$F,d2
		beq.s	Eni_Decomp_Done

.loop:
		bsr.w	Eni_Decomp_FetchInlineValue	; fetch new inline value
		move.w	d1,(a1)+	; copy it
		dbf	d2,.loop	; and repeat
		bra.s	Eni_Decomp_Loop
; ---------------------------------------------------------------------------

Eni_Decomp_Index:
		bra.s	Eni_Decomp_00
; ---------------------------------------------------------------------------
		bra.s	Eni_Decomp_00
; ---------------------------------------------------------------------------
		bra.s	Eni_Decomp_01
; ---------------------------------------------------------------------------
		bra.s	Eni_Decomp_01
; ---------------------------------------------------------------------------
		bra.s	Eni_Decomp_100
; ---------------------------------------------------------------------------
		bra.s	Eni_Decomp_101
; ---------------------------------------------------------------------------
		bra.s	Eni_Decomp_110
; ---------------------------------------------------------------------------
		bra.s	Eni_Decomp_111
; ---------------------------------------------------------------------------

Eni_Decomp_Done:
		subq.w	#1,a0	; go back by one byte
		cmpi.w	#$10,d6
		bne.s	+
		subq.w	#1,a0	; and another one if needed

+
		move.w	a0,d0
		lsr.w	#1,d0
		bcc.s	+
		addq.w	#1,a0	; make sure it's an even address

+
		movem.l	(sp)+,d0-d7/a1-a5
		rts
; End of function Eni_Decomp

; ---------------------------------------------------------------------------
; Part of the Enigma decompressor
; Fetches an inline copy value and stores it in d1
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Eni_Decomp_FetchInlineValue:
		move.w	a3,d3	; copy starting art tile
		move.b	d4,d1	; copy PCCVH bitfield
		add.b	d1,d1	; is the priority bit set?
		bcc.s	+	; if not, branch
		subq.w	#1,d6
		btst	d6,d5	; is the priority bit set in the inline render flags?
		beq.s	+	; if not, branch
		ori.w	#high_priority,d3	; otherwise set priority bit in art tile

+
		add.b	d1,d1	; is the high palette line bit set?
		bcc.s	+	; if not, branch
		subq.w	#1,d6
		btst	d6,d5
		beq.s	+
		addi.w	#palette_line_2,d3

+
		add.b	d1,d1	; is the low palette line bit set?
		bcc.s	+	; if not, branch
		subq.w	#1,d6
		btst	d6,d5
		beq.s	+
		addi.w	#palette_line_1,d3

+
		add.b	d1,d1	; is the vertical flip flag set?
		bcc.s	+	; if not, branch
		subq.w	#1,d6
		btst	d6,d5
		beq.s	+
		ori.w	#$1000,d3

+
		add.b	d1,d1	; is the horizontal flip flag set?
		bcc.s	+	; if not, branch
		subq.w	#1,d6
		btst	d6,d5
		beq.s	+
		ori.w	#$800,d3

+
		move.w	d5,d1
		move.w	d6,d7
		sub.w	a5,d7	; subtract length in bits of inline copy value
		bcc.s	.enoughBits	; branch if a new word doesn't need to be read
		move.w	d7,d6
		addi.w	#$10,d6
		neg.w	d7	; calculate bit deficit
		lsl.w	d7,d1	; and make space for that many bits
		move.b	(a0),d5	; get next byte
		rol.b	d7,d5	; and rotate the required bits into the lowest positions
		add.w	d7,d7
		and.w	Eni_Decomp_Masks-2(pc,d7.w),d5
		add.w	d5,d1	; combine upper bits with lower bits

.maskValue:
		move.w	a5,d0	; get length in bits of inline copy value
		add.w	d0,d0
		and.w	Eni_Decomp_Masks-2(pc,d0.w),d1	; mask value appropriately
		add.w	d3,d1	; add starting art tile
		move.b	(a0)+,d5
		lsl.w	#8,d5
		move.b	(a0)+,d5	; get next word
		rts
; ---------------------------------------------------------------------------

.enoughBits:
		beq.s	.justEnough	; if the word has been exactly exhausted, branch
		lsr.w	d7,d1	; get inline copy value
		move.w	a5,d0
		add.w	d0,d0
		and.w	Eni_Decomp_Masks-2(pc,d0.w),d1	; and mask it appropriately
		add.w	d3,d1	; add starting art tile
		move.w	a5,d0
		bra.s	Eni_Decomp_FetchByte
; ---------------------------------------------------------------------------

.justEnough:
		moveq	#$10,d6	; reset shift value
		bra.s	.maskValue
; End of function Eni_Decomp_FetchInlineValue

; ---------------------------------------------------------------------------
Eni_Decomp_Masks:
		dc.w     1
		dc.w     3
		dc.w     7
		dc.w    $F
		dc.w   $1F
		dc.w   $3F
		dc.w   $7F
		dc.w   $FF
		dc.w  $1FF
		dc.w  $3FF
		dc.w  $7FF
		dc.w  $FFF
		dc.w $1FFF
		dc.w $3FFF
		dc.w $7FFF
		dc.w $FFFF
; ---------------------------------------------------------------------------
; Part of the Enigma decompressor, fetches the next byte if needed
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Eni_Decomp_FetchByte:
		sub.w	d0,d6	; subtract length of current entry from shift value so that next entry is read next time around
		cmpi.w	#9,d6	; does a new byte need to be read?
		bhs.s	+	; if not, branch
		addq.w	#8,d6
		asl.w	#8,d5
		move.b	(a0)+,d5

+
		rts
; End of function Eni_Decomp_FetchByte