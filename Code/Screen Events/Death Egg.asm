; ---------------------------------------------------------------------------

DEZ1_ScreenInit:
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

DEZ1_ScreenEvent:
		tst.w	(Events_fg_4).w
		beq.s	locK_59378
		clr.w	(Events_fg_4).w
		movea.w	$14(a3),a1
		move.b	#$BD,$6E(a1)
		jmp	(Refresh_PlaneScreenDirect).l
; ---------------------------------------------------------------------------

locK_59378:
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

DEZ1_BackgroundInit:
		clr.w	(Camera_X_pos_BG_copy).w
		clr.w	(Camera_Y_pos_BG_copy).w
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

DEZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	DEZ1_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

DEZ1_BackgroundEvent_Index:
		bra.w	locK_593A8
; ---------------------------------------------------------------------------
		bra.w	locK_593EC
; ---------------------------------------------------------------------------

locK_593A8:
		tst.w	(Events_fg_5).w
		beq.s	locK_593E6
		clr.w	(Events_fg_5).w
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(DEZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$15E0).w,a2
		jsr	(Queue_Kos).l
		lea	(ArtKosM_DEZ2_Secondary).l,a1
		move.w	#tiles_to_bytes($292),d2
		jsr	(Queue_Kos_Module).l
		moveq	#PLCID_38,d0
		jsr	(Load_PLC).l
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(Events_routine_bg).w

locK_593E6:
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

locK_593EC:
		tst.b	(Kos_modules_left).w
		bne.w	locK_59488
		move.w	#$B01,(Current_zone_and_act).w
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(Respawn_table_keep).w
		jsr	(Clear_Switches).l
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		lea	(Normal_palette_line_3).w,a0
		lea	(Pal_DEZ2+$20).l,a1
		moveq	#bytesToLcnt($40),d0

locK_59430:
		move.l	(a1)+,(a0)+
		dbf	d0,locK_59430
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$3600,d0
		move.w	#-$400,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d1,(Player_1+y_pos).w
		sub.w	d0,(Player_2+x_pos).w
		sub.w	d1,(Player_2+y_pos).w
		jsr	(Offset_ObjectsDuringTransition).l
		sub.w	d0,(Camera_X_pos).w
		sub.w	d1,(Camera_Y_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d1,(Camera_Y_pos_copy).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w
		sub.w	d1,(Camera_min_Y_pos).w
		sub.w	d1,(Camera_max_Y_pos).w
		move.w	(Camera_max_Y_pos).w,(Camera_target_max_Y_pos).w
		jsr	(Reset_TileOffsetPositionActual).l
		clr.w	(Events_routine_bg).w

locK_59488:
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

DEZ2_ScreenInit:
		move.w	#4,(Events_routine_fg).w
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

DEZ2_ScreenEvent:
		move.w	(Events_routine_fg).w,d0
		jmp	DEZ2_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

DEZ2_ScreenEvent_Index:
		bra.w	locK_594B4
; ---------------------------------------------------------------------------
		bra.w	locK_594DA
; ---------------------------------------------------------------------------
		bra.w	locK_594F8
; ---------------------------------------------------------------------------

locK_594B4:
		tst.w	(Events_fg_4).w
		beq.s	locK_594F8
		clr.w	(Events_fg_4).w
		movea.w	$38(a3),a1
		addq.w	#1,a1
		move.b	#$D7,(a1)+
		move.b	#$DC,(a1)+
		move.b	#$D7,(a1)
		addq.w	#4,(Events_routine_fg).w
		jmp	(Refresh_PlaneScreenDirect).l
; ---------------------------------------------------------------------------

locK_594DA:
		tst.w	(Events_fg_4).w
		beq.s	locK_594F8
		clr.w	(Events_fg_4).w
		movea.w	$18(a3),a1
		move.b	#$BC,$6B(a1)
		addq.w	#4,(Events_routine_fg).w
		jmp	(Refresh_PlaneScreenDirect).l
; ---------------------------------------------------------------------------

locK_594F8:
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

DEZ2_BackgroundInit:
		move.w	#8,(Events_routine_bg).w
		clr.w	(Camera_X_pos_BG_copy).w
		clr.w	(Camera_Y_pos_BG_copy).w
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

DEZ2_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	DEZ2_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

DEZ2_BackgroundEvent_Index:
		bra.w	locK_59532
; ---------------------------------------------------------------------------
		bra.w	locK_59556
; ---------------------------------------------------------------------------
		bra.w	locK_59566
; ---------------------------------------------------------------------------

locK_59532:
		clr.w	(Camera_X_pos_BG_copy).w
		clr.w	(Camera_Y_pos_BG_copy).w
		jsr	(Reset_TileOffsetPositionEff).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w

locK_59556:
		moveq	#0,d1
		moveq	#0,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	locK_59566
		addq.w	#4,(Events_routine_bg).w

locK_59566:
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

DDZ_ScreenInit:
		jsr	(AllocateObject).l
		bne.s	locK_5957A
		move.l	#loc_81492,(a1)

locK_5957A:
		clr.w	(_unkEE98).w
		clr.w	(_unkEEA0).w
		clr.w	(_unkEE9C).w
		clr.w	(_unkEEA2).w
		moveq	#0,d1
		moveq	#0,d0
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

DDZ_ScreenEvent:
		jsr	subK_59648(pc)
		move.w	(Events_routine_fg).w,d4
		jmp	DDZ_ScreenEvent_Index(pc,d4.w)
; ---------------------------------------------------------------------------

DDZ_ScreenEvent_Index:
		bra.w	locK_595B0
; ---------------------------------------------------------------------------
		bra.w	locK_595C0
; ---------------------------------------------------------------------------
		bra.w	locK_595EE
; ---------------------------------------------------------------------------
		bra.w	locK_59602
; ---------------------------------------------------------------------------

locK_595B0:
		tst.w	(Events_bg+$00).w
		beq.w	locretK_59646
		jsr	subK_59672(pc)
		addq.w	#4,(Events_routine_fg).w

locK_595C0:
		cmpi.w	#$200,(Events_bg+$00).w
		bne.s	locK_595D6
		cmpi.w	#$400,d0
		bhs.s	subK_59614
		cmpi.w	#$220,d1
		bhs.s	subK_59614
		bra.s	locK_5961E
; ---------------------------------------------------------------------------

locK_595D6:
		jsr	subK_59672(pc)
		bsr.s	subK_59614
		move.w	#$F0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_fg).w
		bra.s	locK_595F0
; ---------------------------------------------------------------------------

locK_595EE:
		bsr.s	subK_59614

locK_595F0:
		moveq	#0,d1
		moveq	#0,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	locretK_59646
		addq.w	#4,(Events_routine_fg).w
		bra.s	locretK_59646
; ---------------------------------------------------------------------------

locK_59602:
		cmpi.w	#$400,d0
		blo.s	subK_59614
		cmpi.w	#$800,d0
		bhs.s	subK_59614
		cmpi.w	#$220,d1
		blo.s	locK_5961E

; =============== S U B R O U T I N E =======================================


subK_59614:
		move.w	d2,(_unkEE98).w
		move.w	d3,(_unkEE9C).w
		bra.s	locretK_59646
; ---------------------------------------------------------------------------

locK_5961E:
		lea	(_unkEE98).w,a6
		lea	(_unkEEA0).w,a5
		move.w	(_unkEE9C).w,d1
		moveq	#$F,d6
		jsr	(Draw_TileColumn).l
		lea	(_unkEE9C).w,a6
		lea	(_unkEEA2).w,a5
		move.w	(_unkEE98).w,d1
		moveq	#$15,d6
		jmp	(Draw_TileRow).l
; ---------------------------------------------------------------------------

locretK_59646:
		rts
; End of function subK_59614


; =============== S U B R O U T I N E =======================================


subK_59648:
		move.w	(_unkEE98).w,d2
		move.w	(_unkEE9C).w,d3
		move.w	(Camera_X_pos_copy).w,d0
		sub.w	(Events_bg+$02).w,d0
		add.w	(Events_bg+$00).w,d0
		move.w	d0,(_unkEE98).w
		move.w	(Camera_Y_pos_copy).w,d1
		sub.w	(Events_bg+$04).w,d1
		addi.w	#$100,d1
		move.w	d1,(_unkEE9C).w
		rts
; End of function subK_59648


; =============== S U B R O U T I N E =======================================


subK_59672:
		move.w	(_unkEE98).w,d5
		move.w	d5,d4
		andi.w	#$FFF0,d5
		move.w	d5,(_unkEEA0).w
		move.w	(_unkEE9C).w,d5
		and.w	(Camera_Y_pos_mask).w,d5
		move.w	d5,(_unkEEA2).w
		rts
; End of function subK_59672