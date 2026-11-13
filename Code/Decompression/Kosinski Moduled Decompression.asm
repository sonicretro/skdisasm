; ---------------------------------------------------------------------------
; Adds a Kosinski Moduled archive to the module queue
; Inputs:
; a1 = address of the archive
; d2 = destination in VRAM
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Queue_Kos_Module:
		lea	(Kos_module_queue).w,a2
		tst.l	(a2)	; is the first slot free?
		beq.s	Process_Kos_Module_Queue_Init	; if it is, branch
		addq.w	#6,a2	; otherwise, check next slot

.findFreeSlot:
		tst.l	(a2)
		beq.s	.freeSlotFound
		addq.w	#6,a2
		bra.s	.findFreeSlot
; ---------------------------------------------------------------------------

.freeSlotFound:
		move.l	a1,(a2)+	; store source address
		move.w	d2,(a2)+	; store destination VRAM address
		rts
; End of function Queue_Kos_Module

; ---------------------------------------------------------------------------
; Initializes processing of the first module on the queue
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Process_Kos_Module_Queue_Init:
		; Leftover Lava Reef graphics in the Sonic 3 prototype show
		; that placeholder tiles are placed right at offset $8000.
		; It's possible that those tiles were only meant to be visible
		; in development tools (to highlight which areas have not been
		; replaced with proper graphics), but not in-game, which would
		; explain why the following check exists. However, no such
		; placeholder tiles exist in the final build of Sonic 3 or
		; Sonic & Knuckles, so the check doesn't really have a purpose
		; anymore and can safely be removed.

		move.w	(a1)+,d3	; get uncompressed size
		cmpi.w	#$A000,d3	; does this data contain placeholder tiles? (prototype leftover)
		bne.s	+		; if not, branch
		move.w	#$8000,d3	; don't load the placeholder tiles

+
		lsr.w	#1,d3
		move.w	d3,d0
		rol.w	#5,d0
		andi.w	#$1F,d0	; get number of complete modules
		move.b	d0,(Kos_modules_left).w
		andi.l	#$7FF,d3	; get size of last module in words
		bne.s	+	; branch if it's non-zero
		subq.b	#1,(Kos_modules_left).w	; otherwise decrement the number of modules
		move.l	#$800,d3	; and take the size of the last module to be $800 words

+
		move.w	d3,(Kos_last_module_size).w
		move.w	d2,(Kos_module_destination).w
		move.l	a1,(Kos_module_queue).w
		addq.b	#1,(Kos_modules_left).w	; store total number of modules
		rts
; End of function Process_Kos_Module_Queue_Init

; ---------------------------------------------------------------------------
; Processes the first module on the queue
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Process_Kos_Module_Queue:
		tst.b	(Kos_modules_left).w
		bne.s	.modulesLeft

.done:
		rts
; ---------------------------------------------------------------------------

.modulesLeft:
		bmi.s	.decompressionStarted
		cmpi.w	#4,(Kos_decomp_queue_count).w
		bhs.s	.done	; branch if the Kosinski decompression queue is full
		movea.l	(Kos_module_queue).w,a1
		lea	(Kos_decomp_buffer).w,a2
		bsr.w	Queue_Kos	; add current module to decompression queue
		ori.b	#$80,(Kos_modules_left).w	; and set bit to signify decompression in progress
		rts
; ---------------------------------------------------------------------------

.decompressionStarted:
		tst.w	(Kos_decomp_queue_count).w
		bne.s	.done	; branch if the decompression isn't complete

		; otherwise, DMA the decompressed data to VRAM
		andi.b	#$7F,(Kos_modules_left).w
		move.l	#$800,d3
		subq.b	#1,(Kos_modules_left).w
		bne.s	+	; branch if it isn't the last module
		move.w	(Kos_last_module_size).w,d3

+
		move.w	(Kos_module_destination).w,d2
		move.w	d2,d0
		add.w	d3,d0
		add.w	d3,d0
		move.w	d0,(Kos_module_destination).w	; set new destination
		move.l	(Kos_module_queue).w,d0
		move.l	(Kos_decomp_queue).w,d1
		sub.l	d1,d0
		andi.l	#$F,d0
		add.l	d0,d1	; round to the nearest $10 boundary
		move.l	d1,(Kos_module_queue).w	; and set new source
		move.l	#Kos_decomp_buffer,d1
		andi.l	#$FFFFFF,d1
		jsr	(Add_To_DMA_Queue).l
		tst.b	(Kos_modules_left).w
		bne.s	+	; return if this wasn't the last module
		lea	(Kos_module_queue).w,a0
		lea	(Kos_module_queue+6).w,a1
		move.l	(a1)+,(a0)+	; otherwise, shift all entries up
		move.w	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.w	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.w	(a1)+,(a0)+
		move.l	#0,(a0)+	; and mark the last slot as free
		move.w	#0,(a0)+
		move.l	(Kos_module_queue).w,d0
		beq.s	+	; return if the queue is now empty
		movea.l	d0,a1
		move.w	(Kos_module_destination).w,d2
		jmp	(Process_Kos_Module_Queue_Init).l

+
		rts
; End of function Process_Kos_Module_Queue

; ---------------------------------------------------------------------------
; Adds Kosinski-compressed data to the decompression queue
; Inputs:
; a1 = compressed data address
; a2 = decompression destination in RAM
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Queue_Kos:
		move.w	(Kos_decomp_queue_count).w,d0
		lsl.w	#3,d0
		lea	(Kos_decomp_queue).w,a3
		move.l	a1,(a3,d0.w)	; store source
		move.l	a2,4(a3,d0.w)	; store destination
		addq.w	#1,(Kos_decomp_queue_count).w
		rts
; End of function Queue_Kos

; ---------------------------------------------------------------------------
; Checks if V-int occurred in the middle of Kosinski queue processing
; and stores the location from which processing is to resume if it did
; ---------------------------------------------------------------------------


Set_Kos_Bookmark:
		tst.w	(Kos_decomp_queue_count).w
		bpl.s	.return	; branch if decompression wasn't in progress
		move.l	$42(sp),d0	; check address V-int is supposed to rte to
		cmpi.l	#Process_Kos_Queue_Main,d0
		blo.s	.return
		cmpi.l	#Process_Kos_Queue_Done,d0
		bhs.s	.return
		move.l	$42(sp),(Kos_decomp_bookmark).w
		move.l	#Backup_Kos_Registers,$42(sp)	; force V-int to rte here instead if needed

.return:
		rts

; ---------------------------------------------------------------------------
; Processes the first entry in the Kosinski decompression queue
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Process_Kos_Queue:
		tst.w	(Kos_decomp_queue_count).w
		beq.w	Process_Kos_Queue_Done
		bmi.w	Restore_Kos_Bookmark	; branch if decompression was interrupted by V-int

Process_Kos_Queue_Main:
		ori.w	#$8000,(Kos_decomp_queue_count).w	; set sign bit to signify decompression in progress
		movea.l	(Kos_decomp_queue).w,a0
		movea.l	(Kos_decomp_destination).w,a1

		; what follows is identical to the normal Kosinski decompressor except for using Kos_description_field instead of the stack
		lea	(Kos_description_field).w,a2
		move.b	(a0)+,1(a2)
		move.b	(a0)+,(a2)
		move.w	(a2),d5
		moveq	#$F,d4

Process_Kos_Queue_Loop:
		lsr.w	#1,d5
		move	sr,d6
		dbf	d4,Process_Kos_Queue_ChkBit
		move.b	(a0)+,1(a2)
		move.b	(a0)+,(a2)
		move.w	(a2),d5
		moveq	#$F,d4

Process_Kos_Queue_ChkBit:
		move	d6,ccr
		bcc.s	Process_Kos_Queue_RLE
		move.b	(a0)+,(a1)+
		bra.s	Process_Kos_Queue_Loop
; ---------------------------------------------------------------------------

Process_Kos_Queue_RLE:
		moveq	#0,d3
		lsr.w	#1,d5
		move	sr,d6
		dbf	d4,Process_Kos_Queue_ChkBit2
		move.b	(a0)+,1(a2)
		move.b	(a0)+,(a2)
		move.w	(a2),d5
		moveq	#$F,d4

Process_Kos_Queue_ChkBit2:
		move	d6,ccr
		bcs.s	Process_Kos_Queue_SeparateRLE
		lsr.w	#1,d5
		dbf	d4,+
		move.b	(a0)+,1(a2)
		move.b	(a0)+,(a2)
		move.w	(a2),d5
		moveq	#$F,d4

+
		roxl.w	#1,d3
		lsr.w	#1,d5
		dbf	d4,+
		move.b	(a0)+,1(a2)
		move.b	(a0)+,(a2)
		move.w	(a2),d5
		moveq	#$F,d4

+
		roxl.w	#1,d3
		addq.w	#1,d3
		moveq	#-1,d2
		move.b	(a0)+,d2
		bra.s	Process_Kos_Queue_RLELoop
; ---------------------------------------------------------------------------

Process_Kos_Queue_SeparateRLE:
		move.b	(a0)+,d0
		move.b	(a0)+,d1
		moveq	#-1,d2
		move.b	d1,d2
		lsl.w	#5,d2
		move.b	d0,d2
		andi.w	#7,d1
		beq.s	Process_Kos_Queue_SeparateRLE2
		move.b	d1,d3
		addq.w	#1,d3

Process_Kos_Queue_RLELoop:
		move.b	(a1,d2.w),d0
		move.b	d0,(a1)+
		dbf	d3,Process_Kos_Queue_RLELoop
		bra.s	Process_Kos_Queue_Loop
; ---------------------------------------------------------------------------

Process_Kos_Queue_SeparateRLE2:
		move.b	(a0)+,d1
		beq.s	Process_Kos_Queue_EndReached
		cmpi.b	#1,d1
		beq.w	Process_Kos_Queue_Loop
		move.b	d1,d3
		bra.s	Process_Kos_Queue_RLELoop
; ---------------------------------------------------------------------------

Process_Kos_Queue_EndReached:
		move.l	a0,(Kos_decomp_queue).w
		move.l	a1,(Kos_decomp_destination).w
		andi.w	#$7FFF,(Kos_decomp_queue_count).w	; clear decompression in progress bit
		subq.w	#1,(Kos_decomp_queue_count).w
		beq.s	Process_Kos_Queue_Done	; branch if there aren't any entries remaining in the queue
		lea	(Kos_decomp_queue).w,a0
		lea	(Kos_decomp_queue+8).w,a1	; otherwise, shift all entries up
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+

Process_Kos_Queue_Done:
		rts
; ---------------------------------------------------------------------------

Restore_Kos_Bookmark:
		movem.l	(Kos_decomp_stored_registers).w,d0-d6/a0-a2
		move.l	(Kos_decomp_bookmark).w,-(sp)
		move.w	(Kos_decomp_stored_SR).w,-(sp)
		rte
; ---------------------------------------------------------------------------

Backup_Kos_Registers:
		move	sr,(Kos_decomp_stored_SR).w
		movem.l	d0-d6/a0-a2,(Kos_decomp_stored_registers).w
		rts