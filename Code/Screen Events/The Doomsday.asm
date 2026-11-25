; ---------------------------------------------------------------------------

DDZ_BackgroundInit:
		clr.w	(HScroll_table).w
		jsr	subK_596EA(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		moveq	#0,d1
		jsr	(Refresh_PlaneFull).l
		bra.s	locK_596BC
; ---------------------------------------------------------------------------

DDZ_BackgroundEvent:
		jsr	subK_596EA(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l

locK_596BC:
		lea	DDZ_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		lea	(H_scroll_buffer).w,a1
		move.w	(_unkEE98).w,d3
		move.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	#$E0-1,d1
		jsr	(ApplyDeformation2).l
		move.w	(_unkEE9C).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp
		rts

; =============== S U B R O U T I N E =======================================


subK_596EA:
		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Events_bg+$06).w,d0
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		asr.l	#3,d1
		moveq	#5,d2
		lea	(HScroll_table+$00E).w,a1

locK_59708:
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		dbf	d2,locK_59708
		rts
; End of function subK_596EA

; ---------------------------------------------------------------------------

DDZ_BGDeformArray:
		dc.w    $B0,   $10,     8,     8,   $18,   $38, $7FFF