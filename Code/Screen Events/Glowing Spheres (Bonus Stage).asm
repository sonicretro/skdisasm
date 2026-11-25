; ---------------------------------------------------------------------------

Pachinko_ScreenInit:
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

Pachinko_ScreenEvent:
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

Pachinko_BackgroundInit:
		jsr	Pachinko_BGScroll(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

Pachinko_BackgroundEvent:
		jsr	Pachinko_BGScroll(pc)
		jsr	(DrawBGAsYouMove).l
		jmp	(PlainDeformation).l

; =============== S U B R O U T I N E =======================================


Pachinko_BGScroll:
		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#3,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$A0,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#2,d1
		add.l	d1,d0
		swap	d0
		addi.w	#$60,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; End of function Pachinko_BGScroll