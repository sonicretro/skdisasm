; ---------------------------------------------------------------------------

JmpTo_HInt:
		jmp	(H_int_jump).w

; ---------------------------------------------------------------------------
; Horizontal interrupt handler for Competition Mode
; ---------------------------------------------------------------------------

HInt:
		tst.w	(H_int_flag).w
		beq.w	HInt_Done
		move.w	#0,(H_int_flag).w
		move.l	a5,-(sp)
		move.l	d0,-(sp)

-
		move.w	(VDP_control_port).l,d0
		andi.w	#4,d0	; is horizontal blanking occurring?
		beq.s	-	; if not, wait until it is

		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l	; blank the display

		; Update V-Scroll.
		move.l	#vdpComm($0000,VSRAM,WRITE),(VDP_control_port).l
		move.l	(V_scroll_value_P2_copy).w,(VDP_data_port).l

		stopZ80
		; Unlike in Sonic 2, the sprite tables are page-flipped in two-player mode.
		; This fixes a race-condition where incomplete sprite tables can be uploaded
		; to the VDP on lag frames, causing corrupted sprites to appear.

		; Upload the front buffer.
		tst.w	(Current_sprite_table_page).w
		beq.s	+
		dma68kToVDP Sprite_table_P2,$F800,Sprite_table_P2_end-Sprite_table_P2,VRAM
		bra.s	++

+
		dma68kToVDP Sprite_table_P2_alternate,$F800,Sprite_table_P2_alternate_end-Sprite_table_P2_alternate,VRAM

+
		startZ80

-
		move.w	(VDP_control_port).l,d0
		andi.w	#4,d0	; is a horizontal blank occurring?
		beq.s	-	; if not, wait
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l	; enable display
		move.l	(sp)+,d0
		movea.l	(sp)+,a5

HInt_Done:
		rte

; ---------------------------------------------------------------------------
; Used for water levels apart from Hydrocity, for uneven water surfaces
; ---------------------------------------------------------------------------

HInt3:
		tst.w	(H_int_flag).w
		beq.s	HInt3_Done
		move.w	#0,(H_int_flag).w
		movem.l	d0-d1/a0-a2,-(sp)

		lea	(VDP_data_port).l,a1
		move.w	#$8AFF,VDP_control_port-VDP_data_port(a1)		; Reset HInt timing
		stopZ80
		movea.l	(Water_palette_data_addr).w,a2
		moveq	#$C,d0
		dbf	d0,*	; waste a few cycles here
		move.w	(a2)+,d1
		move.b	(H_int_counter).w,d0
		subi.b	#200,d0	; is H-int occurring below line 200?
		bcs.s	.transferColors	; if it is, branch
		sub.b	d0,d1
		bcs.s	.skipTransfer

.transferColors:
		move.w	(a2)+,d0
		lea	(Water_palette).w,a0
		adda.w	d0,a0
		addi.w	#$C000,d0
		swap	d0
		move.l	d0,VDP_control_port-VDP_data_port(a1)	; write to CRAM at appropriate address
		move.l	(a0)+,(a1)	; transfer two colors
		move.w	(a0)+,(a1)	; transfer the third color
		nop
		nop
		moveq	#$24,d0
		dbf	d0,*	; waste some cycles
		dbf	d1,.transferColors	; repeat for number of colors

.skipTransfer:
		startZ80
		movem.l	(sp)+,d0-d1/a0-a2
		tst.b	(Do_Updates_in_H_int).w
		bne.s	HInt3_Do_Updates

HInt3_Done:
		rte
; ---------------------------------------------------------------------------

HInt3_Do_Updates:
		clr.b	(Do_Updates_in_H_int).w
		movem.l	d0-a6,-(sp)
		jsr	(Do_Updates).l
		movem.l	(sp)+,d0-a6
		rte

; ---------------------------------------------------------------------------
; Identical to HInt3 except it transfers colors from the above water palette
; Seems to be unused
; ---------------------------------------------------------------------------

HInt5:
		tst.w	(H_int_flag).w		; Seems to be a compliment to HInt 3, but doesn't seem to be used
		beq.s	HInt5_Done
		move.w	#0,(H_int_flag).w
		movem.l	d0-d1/a0-a2,-(sp)

		lea	(VDP_data_port).l,a1
		move.w	#$8AFF,VDP_control_port-VDP_data_port(a1)
		stopZ80
		movea.l	(Water_palette_data_addr).w,a2
		moveq	#$C,d0
		dbf	d0,*

		move.w	(a2)+,d1
		move.b	(H_int_counter).w,d0
		subi.b	#200,d0
		bcs.s	.transferColors
		sub.b	d0,d1
		bcs.s	.skipTransfer

.transferColors:
		move.w	(a2)+,d0
		lea	(Normal_palette).w,a0
		adda.w	d0,a0
		addi.w	#$C000,d0
		swap	d0
		move.l	d0,VDP_control_port-VDP_data_port(a1)
		move.l	(a0)+,(a1)
		move.w	(a0)+,(a1)
		nop
		nop
		moveq	#$24,d0
		dbf	d0,*	; waste some cycles
		dbf	d1,.transferColors

.skipTransfer:
		startZ80
		movem.l	(sp)+,d0-d1/a0-a2
		tst.b	(Do_Updates_in_H_int).w
		bne.s	HInt5_Do_Updates

HInt5_Done:
		rte
; ---------------------------------------------------------------------------

HInt5_Do_Updates:
		clr.b	(Do_Updates_in_H_int).w
		movem.l	d0-a6,-(sp)
		jsr	(Do_Updates).l
		movem.l	(sp)+,d0-a6
		rte

; ---------------------------------------------------------------------------
; Identical to HInt3, except for faster systems
; ---------------------------------------------------------------------------

HInt4:
		tst.w	(H_int_flag).w
		beq.s	Hint4_Done
		move.w	#0,(H_int_flag).w
		movem.l	d0-d1/a0-a2,-(sp)

		lea	(VDP_data_port).l,a1
		move.w	#$8AFF,VDP_control_port-VDP_data_port(a1)
		stopZ80
		movea.l	(Water_palette_data_addr).w,a2
		moveq	#$1B,d0
		dbf	d0,*

		move.w	(a2)+,d1
		move.b	(H_int_counter).w,d0
		subi.b	#200,d0
		bcs.s	.transferColors
		sub.b	d0,d1
		bcs.s	.skipTransfer

.transferColors:
		move.w	(a2)+,d0
		lea	(Water_palette).w,a0
		adda.w	d0,a0
		addi.w	#$C000,d0
		swap	d0
		move.l	d0,VDP_control_port-VDP_data_port(a1)
		move.l	(a0)+,(a1)
		move.w	(a0)+,(a1)
		nop
		moveq	#$33,d0
		dbf	d0,*	; waste some cycles
		dbf	d1,.transferColors

.skipTransfer:
		startZ80
		movem.l	(sp)+,d0-d1/a0-a2
		tst.b	(Do_Updates_in_H_int).w
		bne.s	HInt4_Do_Updates

Hint4_Done:
		rte
; ---------------------------------------------------------------------------

HInt4_Do_Updates:
		clr.b	(Do_Updates_in_H_int).w
		movem.l	d0-a6,-(sp)
		jsr	(Do_Updates).l
		movem.l	(sp)+,d0-a6
		rte

; ---------------------------------------------------------------------------
; Identical to HInt5, except for faster systems
; ---------------------------------------------------------------------------

HInt6:
		tst.w	(H_int_flag).w
		beq.s	HInt6_Done
		move.w	#0,(H_int_flag).w
		movem.l	d0-d1/a0-a2,-(sp)

		lea	(VDP_data_port).l,a1
		move.w	#$8AFF,VDP_control_port-VDP_data_port(a1)
		stopZ80
		movea.l	(Water_palette_data_addr).w,a2
		moveq	#$1B,d0
		dbf	d0,*

		move.w	(a2)+,d1
		move.b	(H_int_counter).w,d0
		subi.b	#200,d0
		bcs.s	.transferColors
		sub.b	d0,d1
		bcs.s	.skipTransfer

.transferColors:
		move.w	(a2)+,d0
		lea	(Normal_palette).w,a0
		adda.w	d0,a0
		addi.w	#$C000,d0
		swap	d0
		move.l	d0,VDP_control_port-VDP_data_port(a1)
		move.l	(a0)+,(a1)
		move.w	(a0)+,(a1)
		nop
		moveq	#$33,d0
		dbf	d0,*	; waste some cycles
		dbf	d1,.transferColors

.skipTransfer:
		startZ80
		movem.l	(sp)+,d0-d1/a0-a2
		tst.b	(Do_Updates_in_H_int).w
		bne.s	HInt6_Do_Updates

HInt6_Done:
		rte
; ---------------------------------------------------------------------------

HInt6_Do_Updates:
		clr.b	(Do_Updates_in_H_int).w
		movem.l	d0-a6,-(sp)
		jsr	(Do_Updates).l
		movem.l	(sp)+,d0-a6
		rte

; ---------------------------------------------------------------------------
; Copies the entire water palette to CRAM, used only in Hydrocity
; ---------------------------------------------------------------------------

HInt2:
		move	#$2700,sr
		tst.w	(H_int_flag).w
		beq.s	HInt2_Done
		move.w	#0,(H_int_flag).w
		movem.l	a0-a1,-(sp)

		lea	(VDP_data_port).l,a1
		move.w	#$8A00+224-1,VDP_control_port-VDP_data_port(a1)
		lea	(Water_palette).w,a0
		move.l	#vdpComm($0000,CRAM,WRITE),VDP_control_port-VDP_data_port(a1)
	rept 32
		move.l	(a0)+,(a1)
	endm
		movem.l	(sp)+,a0-a1
		tst.b	(Do_Updates_in_H_int).w
		bne.s	HInt2_Do_Updates

HInt2_Done:
		rte
; ---------------------------------------------------------------------------

HInt2_Do_Updates:
		clr.b	(Do_Updates_in_H_int).w
		movem.l	d0-a6,-(sp)
		bsr.w	Do_Updates
		movem.l	(sp)+,d0-a6
		rte