; ---------------------------------------------------------------------------
; Adds pattern load requests to the Nemesis decompression queue
; Input: d0 = ID of the PLC to load
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Load_PLC:
		movem.l	a1-a2,-(sp)
		lea	(Offs_PLC).l,a1
		add.w	d0,d0
		move.w	(a1,d0.w),d0
		lea	(a1,d0.w),a1
		lea	(Nem_decomp_queue).w,a2

.findFreeSlot:
		tst.l	(a2)	; is the current slot in the queue free?
		beq.s	.getPieceCount	; if it is, branch
		addq.w	#6,a2	; otherwise check the next slot
		bra.s	.findFreeSlot
; ---------------------------------------------------------------------------

.getPieceCount:
		move.w	(a1)+,d0
		bmi.s	.done

.queuePieces:
		move.l	(a1)+,(a2)+	; store compressed data location
		move.w	(a1)+,(a2)+	; store destination in VRAM
		dbf	d0,.queuePieces

.done:
		movem.l	(sp)+,a1-a2
		rts
; End of function Load_PLC

; ---------------------------------------------------------------------------
; Loads a raw PLC from ROM
; Input: a1 = address of the PLC
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Load_PLC_Raw:
		lea	(Nem_decomp_queue).w,a2

.findFreeSlot:
		tst.l	(a2)
		beq.s	.getPieceCount
		addq.w	#6,a2
		bra.s	.findFreeSlot
; ---------------------------------------------------------------------------

.getPieceCount:
		move.w	(a1)+,d0
		bmi.s	.done

.queuePieces:
		move.l	(a1)+,(a2)+
		move.w	(a1)+,(a2)+
		dbf	d0,.queuePieces

.done:
		rts
; End of function Load_PLC_Raw

; ---------------------------------------------------------------------------
; Adds pattern load requests to the Nemesis decompression queue
; Differs from Load_PLC in that it clears the queue before loading
; Input: d0 = ID of the PLC to load
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Load_PLC_2:
		movem.l	a1-a2,-(sp)		; This differs from Load_PLC in that it overrides any PLCs already in the queue
		lea	(Offs_PLC).l,a1
		add.w	d0,d0
		move.w	(a1,d0.w),d0
		lea	(a1,d0.w),a1
		bsr.s	Clear_Nem_Queue
		lea	(Nem_decomp_queue).w,a2
		move.w	(a1)+,d0
		bmi.s	.done

.queuePieces:
		move.l	(a1)+,(a2)+
		move.w	(a1)+,(a2)+
		dbf	d0,.queuePieces

.done:
		movem.l	(sp)+,a1-a2
		rts
; End of function Load_PLC_2

; ---------------------------------------------------------------------------
; Clears the Nemesis decompression queue and its associated variables
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Clear_Nem_Queue:
		lea	(Nem_decomp_queue).w,a2
		moveq	#bytesToLcnt($80),d0	; clear till the end of Nem_decomp_vars

.loop:
		clr.l	(a2)+
		dbf	d0,.loop
		rts
; End of function Clear_Nem_Queue

; ---------------------------------------------------------------------------
; Initializes Nemesis decompression queue processing
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Process_Nem_Queue_Init:
		tst.l	(Nem_decomp_queue).w
		beq.s	++	; return if the queue is empty
		tst.w	(Nem_patterns_left).w
		bne.s	++	; return if processing of a previous piece is still going on
		movea.l	(Nem_decomp_queue).w,a0
		lea	(Nem_PCD_WriteRowToVDP).l,a3
		nop
		lea	(Nem_code_table).w,a1
		move.w	(a0)+,d2
		bpl.s	+
		adda.w	#Nem_PCD_WriteRowToVDP_XOR-Nem_PCD_WriteRowToVDP,a3

+
		andi.w	#$7FFF,d2
		bsr.w	Nem_Build_Code_Table
		move.b	(a0)+,d5
		asl.w	#8,d5
		move.b	(a0)+,d5
		moveq	#$10,d6
		moveq	#0,d0
		move.l	a0,(Nem_decomp_queue).w
		move.l	a3,(Nem_decomp_vars).w
		move.l	d0,(Nem_repeat_count).w
		move.l	d0,(Nem_palette_index).w
		move.l	d0,(Nem_previous_row).w
		move.l	d5,(Nem_data_word).w
		move.l	d6,(Nem_shift_value).w
		move.w	d2,(Nem_patterns_left).w

+
		rts
; End of function Process_Nem_Queue_Init

; ---------------------------------------------------------------------------
; Processes the first piece on the Nemesis decompression queue
; Decompresses 6 patterns per frame
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Process_Nem_Queue:
		tst.w	(Nem_patterns_left).w
		beq.w	Process_Nem_Queue_Done
		move.w	#6,(Nem_frame_patterns_left).w	; decompress 6 patterns per frame
		moveq	#0,d0
		move.w	(Nem_decomp_destination).w,d0
		addi.w	#6*$20,(Nem_decomp_destination).w	; increment by 6 patterns' worth of data
		bra.s	Process_Nem_Queue_Main
; End of function Process_Nem_Queue

; ---------------------------------------------------------------------------
; Processes the first piece on the Nemesis decompression queue
; Decompresses 3 patterns per frame
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Process_Nem_Queue_2:
		tst.w	(Nem_patterns_left).w
		beq.s	Process_Nem_Queue_Done
		move.w	#3,(Nem_frame_patterns_left).w	; decompress 3 patterns per frame
		moveq	#0,d0
		move.w	(Nem_decomp_destination).w,d0
		addi.w	#3*$20,(Nem_decomp_destination).w	; increment by 3 patterns' worth of data
; End of function Process_Nem_Queue_2

; ---------------------------------------------------------------------------
; Main Nemesis decompression queue processor
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Process_Nem_Queue_Main:
		lea	(VDP_control_port).l,a4
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap	d0	; d0 = VDP command word to write to VRAM destination
		move.l	d0,(a4)
		subq.w	#VDP_control_port-VDP_data_port,a4	; a4 = VDP_data_port
		movea.l	(Nem_decomp_queue).w,a0
		movea.l	(Nem_decomp_vars).w,a3
		move.l	(Nem_repeat_count).w,d0
		move.l	(Nem_palette_index).w,d1
		move.l	(Nem_previous_row).w,d2
		move.l	(Nem_data_word).w,d5
		move.l	(Nem_shift_value).w,d6
		lea	(Nem_code_table).w,a1

Process_Nem_Queue_Loop:
		movea.w	#8,a5	; decompress all 8 rows in a pattern
		bsr.w	Nem_PCD_NewRow
		subq.w	#1,(Nem_patterns_left).w	; have all the patterns been decompressed?
		beq.s	Process_Nem_Queue_ShiftUp	; if yes, shift all other queue entries up
		subq.w	#1,(Nem_frame_patterns_left).w	; has the current frame's worth of patterns been decompressed?
		bne.s	Process_Nem_Queue_Loop	; if not, loop
		move.l	a0,(Nem_decomp_queue).w
		move.l	a3,(Nem_decomp_vars).w
		move.l	d0,(Nem_repeat_count).w
		move.l	d1,(Nem_palette_index).w
		move.l	d2,(Nem_previous_row).w
		move.l	d5,(Nem_data_word).w
		move.l	d6,(Nem_shift_value).w

Process_Nem_Queue_Done:
		rts
; ---------------------------------------------------------------------------

Process_Nem_Queue_ShiftUp:
		lea	(Nem_decomp_queue).w,a0
		moveq	#bytesToLcnt(Nem_decomp_queue_End-Nem_decomp_queue-6),d0

.loop:
		move.l	6(a0),(a0)+
		dbf	d0,.loop

	if FixBugs
		; The above code does not properly 'pop' the 16th PLC entry.
		; Because of this, occupying the 16th slot will cause it to
		; be repeatedly decompressed infinitely.
		; Granted, this could be considered more of an optimization
		; than a bug: treating the 16th entry as a dummy that
		; should never be occupied makes this code unnecessary.
		; Still, the overhead of this code is minimal.
		if (Nem_decomp_queue_End-Nem_decomp_queue-6)&2
		move.w	6(a0),(a0)
		endif

		clr.l	(Nem_decomp_queue_End-6).w
	endif
		rts
; End of function Process_Nem_Queue_Main

; ---------------------------------------------------------------------------
		; unused, leftover from Sonic 1/2
		lea	(Offs_PLC).l,a1
		add.w	d0,d0
		move.w	(a1,d0.w),d0
		lea	(a1,d0.w),a1

; ---------------------------------------------------------------------------
; Loads a raw PLC from the ROM and decompresses it immediately
; Input: a1 = the address of the PLC
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Load_PLC_Immediate:
		move.w	(a1)+,d1

.decompPieces:
		movea.l	(a1)+,a0	; get source address
		moveq	#0,d0
		move.w	(a1)+,d0	; get destination VRAM address
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap	d0	; d0 = VDP command to write to destination
		move.l	d0,(VDP_control_port).l
		bsr.w	Nem_Decomp
		dbf	d1,.decompPieces
		rts
; End of function Load_PLC_Immediate