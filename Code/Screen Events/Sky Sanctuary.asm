; ---------------------------------------------------------------------------

SSZ1_ScreenInit:
		tst.b	(Last_star_post_hit).w
		bne.s	locK_57246
		jsr	(AllocateObject).l
		bne.s	locK_57246
		move.l	#Obj_57C1E,(a1)
		move.w	#$100,x_pos(a1)
		move.b	#$6C,$2D(a1)
		st	(Events_bg+$05).w
		move.w	#$200,(Camera_max_X_pos).w
		move.w	#$BC0,d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		moveq	#$60,d0
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d0,(Camera_X_pos).w
		move.w	#$F49,d0
		move.w	d0,(Camera_Y_pos_copy).w
		move.w	d0,(Camera_Y_pos).w
		st	(Scroll_lock).w

locK_57246:
		clr.w	(_unkEE98).w
		clr.w	(_unkEE9C).w
		lea	(HScroll_table+$1F6).w,a1
		lea	(a1),a5
		moveq	#5-1,d0

locK_57256:
		clr.w	(a1)+
		dbf	d0,locK_57256
		lea	wordK_58758(pc),a6
		moveq	#5-1,d1
		jsr	(AllocateObject).l
		bne.s	locK_5728E

locK_5726A:
		move.w	a1,(a5)+
		move.l	#locK_57BB2,(a1)
		move.w	(a6)+,$38(a1)
		move.w	(a6)+,$3A(a1)
		move.w	(a6)+,$40(a1)
		move.w	(a6)+,d2
		move.b	d2,mapping_frame(a1)
		jsr	(CreateNewSprite4).l
		dbne	d1,locK_5726A

locK_5728E:
		jsr	subK_5758A(pc)
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

SSZ1_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	(Events_routine_fg).w,d0
		jmp	SSZ1_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

SSZ1_ScreenEvent_Index:
		bra.w	locK_572BA
; ---------------------------------------------------------------------------
		bra.w	locK_57344
; ---------------------------------------------------------------------------
		bra.w	locK_574B0
; ---------------------------------------------------------------------------

locK_572BA:
		tst.b	(End_of_level_flag).w
		bne.s	locK_572CE
		jsr	subK_575EA(pc)
		jsr	subK_5758A(pc)
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

locK_572CE:
		jsr	(AllocateObject).l
		bne.s	locK_572E2
		move.l	#Obj_57E96,(a1)
		move.w	#$1E,$2E(a1)

locK_572E2:
		lea	(HScroll_table+$E0).w,a1
		lea	$20(a1),a5
		moveq	#$A-1,d0

locK_572EC:
		move.w	#-1,(a1)+
		clr.l	(a5)+
		clr.l	$3C(a5)
		dbf	d0,locK_572EC
		jsr	subK_5750C(pc)
		lea	(HScroll_table+$80).w,a1
		move.w	(Camera_Y_pos_mask).w,d0
		moveq	#$A-1,d1

locK_57308:
		move.w	(a1)+,(a1)
		and.w	d0,(a1)+
		dbf	d1,locK_57308
		jsr	(Restore_PlayerControl).l
		lea	(Player_2).w,a1
		jsr	(Restore_PlayerControl2).l
		st	(Ctrl_1_locked).w
		st	(Ctrl_2_locked).w
		clr.w	(Ctrl_1_logical).w
		clr.w	(Ctrl_2_logical).w
		st	(Scroll_lock).w
		st	(Screen_shake_flag).w
		move.w	#4,(Special_V_int_routine).w
		addq.w	#4,(Events_routine_fg).w
		bra.s	locK_5734E
; ---------------------------------------------------------------------------

locK_57344:
		tst.w	(Events_fg_4).w
		bne.s	locK_57360
		jsr	subK_5750C(pc)

locK_5734E:
		lea	wordK_577B2(pc),a4
		lea	(HScroll_table+$80).w,a5
		moveq	#$F,d6
		moveq	#$A,d5
		jmp	(DrawTilesVDeform).l
; ---------------------------------------------------------------------------

locK_57360:
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(SSZ1_128x128_Custom_Kos).l,a1
		lea	(Chunk_table+$180).l,a2
		jsr	(Queue_Kos).l
		lea	(SSZ1_16x16_Custom_Kos).l,a1
		lea	(Block_table+$B8).w,a2
		jsr	(Queue_Kos).l
		lea	(ArtKosM_SSZ1_Custom).l,a1
		move.w	#tiles_to_bytes($073),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_SSZSpiralRamp).l,a1
		move.w	#tiles_to_bytes(ArtTile_SSZSpiralRamp),d2
		jsr	(Queue_Kos_Module).l
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	-8(a3),d0
		subq.w	#3,d0
		movea.w	(a3),a1
		move.b	#4,(a1,d0.w)
		move.b	#5,1(a1,d0.w)
		move.b	#6,2(a1,d0.w)
		movea.w	4(a3),a1
		move.b	#7,(a1,d0.w)
		move.b	#8,1(a1,d0.w)
		move.b	#9,2(a1,d0.w)
		lea	(Normal_palette_line_2).w,a1
		lea	Pal_SSZDeathEgg(pc),a5
		moveq	#bytesToLcnt($20),d0

locK_573E4:
		move.l	(a5)+,(a1)+
		dbf	d0,locK_573E4
		jsr	subK_574DC(pc)
		move.w	(_unkEEEA).w,d0
		move.w	d0,d1
		andi.w	#$FFF0,d0
		move.w	d0,(_unkEEF2).w
		move.w	(_unkEEEE).w,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(_unkEEF4).w
		st	(_unkEE98).w
		clr.l	(_unkEEF6).w
		clr.w	(_unkEEFA).w
		jsr	(AllocateObject).l
		bne.w	locK_574A0
		move.w	#$5A8,d1
		move.w	#$58C,d2
		move.w	#$554,d3
		moveq	#$A-1,d4

locK_5742C:
		move.l	#locK_58234,(a1)
		move.w	#$1A38,x_pos(a1)
		move.w	d1,y_pos(a1)
		jsr	(CreateNewSprite4).l
		bne.s	locK_574A0
		move.l	#locK_58360,(a1)
		move.w	#$1A80,x_pos(a1)
		move.w	d2,y_pos(a1)
		tst.w	d4
		beq.s	locK_574A0
		jsr	(CreateNewSprite4).l
		bne.s	locK_574A0
		move.l	#locK_582AC,(a1)
		move.w	#$1A48,x_pos(a1)
		move.w	d1,y_pos(a1)
		subi.w	#$38,y_pos(a1)
		jsr	(CreateNewSprite4).l
		bne.s	locK_574A0
		move.l	#locK_581F2,(a1)
		move.w	#$19F8,x_pos(a1)
		move.w	d3,y_pos(a1)
		moveq	#$70,d5
		sub.w	d5,d1
		sub.w	d5,d2
		sub.w	d5,d3
		jsr	(CreateNewSprite4).l
		dbne	d4,locK_5742C

locK_574A0:
		st	(Events_fg_4).w
		move.w	#$C,(Special_V_int_routine).w
		addq.w	#4,(Events_routine_fg).w
		rts
; ---------------------------------------------------------------------------

locK_574B0:
		jsr	subK_574DC(pc)
		lea	(_unkEEEA).w,a6
		lea	(_unkEEF2).w,a5
		move.w	(_unkEEEE).w,d1
		moveq	#$F,d6
		jsr	(Draw_TileColumn).l
		lea	(_unkEEEE).w,a6
		lea	(_unkEEF4).w,a5
		move.w	(_unkEEEA).w,d1
		moveq	#$15,d6
		jmp	(Draw_TileRow).l

; =============== S U B R O U T I N E =======================================


subK_574DC:
		move.w	(Camera_X_pos_copy).w,(_unkEEEA).w
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$110,d0
		asr.w	#2,d0
		move.w	d0,(_unkEEEE).w
		cmpi.w	#$110,(Camera_Y_pos).w
		bne.w	subK_5758A
		addi.l	#$6000,(_unkEEF6).w
		move.w	(_unkEEF6).w,d0
		add.w	d0,(_unkEEEE).w
		bra.s	subK_5758A
; End of function subK_574DC


; =============== S U B R O U T I N E =======================================


subK_5750C:
		lea	(HScroll_table+$80).w,a5
		lea	$60(a5),a6
		move.w	(Camera_Y_pos_copy).w,d0
		moveq	#$A,d1
		moveq	#$A-1,d2

locK_5751C:
		tst.w	(a6)
		beq.s	locK_57526
		bmi.s	locK_57536
		subq.w	#1,(a6)
		bra.s	locK_57536
; ---------------------------------------------------------------------------

locK_57526:
		move.l	$80(a5),d3
		addi.l	#$800,$80(a5)
		sub.l	d3,$C0(a5)

locK_57536:
		move.w	$C0(a5),d3
		add.w	d0,d3
		cmpi.w	#$580,d3
		bhs.s	locK_5754C
		clr.l	$80(a5)
		move.w	#$580,d3
		subq.w	#1,d1

locK_5754C:
		move.w	d3,(a5)
		move.w	d3,-$20(a6)
		addq.w	#4,a5
		addq.w	#2,a6
		dbf	d2,locK_5751C
		movea.w	(_unkFAA4).w,a1
		move.w	$10(a1),d0
		subi.w	#$19A0,d0
		lsr.w	#3,d0
		andi.w	#$FFFC,d0
		lea	(HScroll_table+$140).w,a5
		move.w	#$660,d2
		sub.w	(a5,d0.w),d2
		move.w	d2,$14(a1)
		tst.w	d1
		bne.s	subK_5758A
		st	(Events_fg_4+1).w
		move.l	#Delete_Current_Sprite,(a1)
; End of function subK_5750C


; =============== S U B R O U T I N E =======================================


subK_5758A:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Screen_shake_offset).w,d3
		sub.w	d3,d0
		move.w	d0,d1
		asr.w	#2,d1
		add.w	d1,d0
		move.w	(_unkEE9C).w,d1
		move.w	d1,d2
		asr.w	#2,d2
		add.w	d2,d1
		asr.w	#1,d1
		add.w	d1,d0
		add.w	d3,d0
		move.w	(Camera_X_pos_copy).w,d1
		move.w	d1,d2
		asr.w	#2,d2
		add.w	d2,d1
		lea	(HScroll_table+$1F6).w,a5
		moveq	#5-1,d2

locK_575BA:
		move.w	(a5)+,d3
		beq.s	locK_575E4
		movea.w	d3,a6
		move.w	$38(a6),d3
		sub.w	d0,d3
		andi.w	#$FF,d3
		addi.w	#$70,d3
		move.w	d3,$14(a6)
		move.w	$3A(a6),d3
		sub.w	d1,d3
		andi.w	#$1FF,d3
		addi.w	#$50,d3
		move.w	d3,$10(a6)

locK_575E4:
		dbf	d2,locK_575BA
		rts
; End of function subK_5758A


; =============== S U B R O U T I N E =======================================


subK_575EA:
		tst.b	(Events_bg+$06).w
		bne.w	locretK_57788
		cmpi.w	#$19A0,(Camera_X_pos).w
		blo.s	locK_5761C
		cmpi.w	#$680,(Player_1+y_pos).w
		bhs.s	locK_5761C
		move.w	#$19A0,(Camera_min_X_pos).w
		move.w	#$5C0,d0
		move.w	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		st	(Events_bg+$06).w
		bra.w	locretK_57788
; ---------------------------------------------------------------------------

locK_5761C:
		tst.b	(Events_bg+$05).w
		bne.w	locretK_57788
		move.b	(Events_bg+$01).w,d0
		or.b	(Events_bg+$03).w,d0
		bne.s	locK_57686
		move.w	(Camera_Y_pos).w,d0
		cmpi.w	#$100,d0
		blo.s	locK_57674
		cmpi.w	#$E00,d0
		bhs.s	locK_57674
		lea	wordK_5778A(pc),a1
		move.w	(Player_1+x_pos).w,d1

locK_57646:
		cmp.w	(a1)+,d1
		blo.s	locK_5764E
		addq.w	#2,a1
		bra.s	locK_57646
; ---------------------------------------------------------------------------

locK_5764E:
		move.w	(a1),d2
		cmp.w	d0,d2
		bhi.s	locK_57658
		move.w	d2,(Camera_min_Y_pos).w

locK_57658:
		lea	wordK_5779A(pc),a1

locK_5765C:
		cmp.w	(a1)+,d1
		blo.s	locK_57664
		addq.w	#2,a1
		bra.s	locK_5765C
; ---------------------------------------------------------------------------

locK_57664:
		move.w	(a1),d2
		cmp.w	d0,d2
		blo.s	locK_57686
		move.w	d2,(Camera_max_Y_pos).w
		move.w	d2,(Camera_target_max_Y_pos).w
		bra.s	locK_57686
; ---------------------------------------------------------------------------

locK_57674:
		move.w	#-$100,(Camera_min_Y_pos).w
		move.w	#$1000,d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w

locK_57686:
		move.w	(Player_1+y_pos).w,d0
		cmpi.w	#$440,d0
		blo.s	locK_5770C
		cmpi.w	#$880,d0
		bhs.w	locK_5777E
		tst.b	(Events_bg+$00).w
		bmi.w	locK_5777E
		bne.w	locretK_57788
		tst.b	(Events_bg+$01).w
		bne.s	locK_576E8
		move.w	#$160,(Camera_min_X_pos).w
		move.w	#$19A0,(Camera_max_X_pos).w
		cmpi.w	#$7C0,d0
		blo.w	locretK_57788
		cmpi.w	#$160,(Camera_X_pos).w
		bne.w	locretK_57788
		btst	#1,(Player_1+status).w
		bne.w	locretK_57788
		move.w	#$160,(Camera_max_X_pos).w
		move.w	#$7C0,d0
		move.w	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		st	(Events_bg+$01).w

locK_576E8:
		cmpi.w	#$7C0,(Camera_Y_pos).w
		bne.w	locretK_57788
		jsr	(AllocateObject).l
		bne.s	locK_5770A
		move.l	#Obj_SSZGHZBoss,(a1)
		st	(Events_bg+$05).w
		move.w	#$7F00,(Events_bg+$00).w

locK_5770A:
		bra.s	locretK_57788
; ---------------------------------------------------------------------------

locK_5770C:
		tst.b	(Events_bg+$02).w
		bmi.s	locK_5777E
		bne.s	locretK_57788
		tst.b	(Events_bg+$03).w
		bne.s	locK_5775C
		move.w	#$1660,(Camera_max_X_pos).w
		moveq	#0,d1
		tst.w	(Events_bg+$00).w
		bne.s	locK_5772C
		move.w	#$160,d1

locK_5772C:
		move.w	d1,(Camera_min_X_pos).w
		cmpi.w	#$420,d0
		blo.s	locretK_57788
		cmpi.w	#$1660,(Camera_X_pos).w
		bne.s	locretK_57788
		btst	#1,(Player_1+status).w
		bne.s	locretK_57788
		move.w	#$1660,(Camera_min_X_pos).w
		move.w	#$380,d0
		move.w	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		st	(Events_bg+$03).w

locK_5775C:
		cmpi.w	#$380,(Camera_Y_pos).w
		bne.s	locretK_57788
		jsr	(AllocateObject).l
		bne.s	locK_5777C
		move.l	#Obj_SSZMTZBoss,(a1)
		st	(Events_bg+$05).w
		move.w	#$7F00,(Events_bg+$02).w

locK_5777C:
		bra.s	locretK_57788
; ---------------------------------------------------------------------------

locK_5777E:
		clr.w	(Camera_min_X_pos).w
		move.w	#$19A0,(Camera_max_X_pos).w

locretK_57788:
		rts
; End of function subK_575EA

; ---------------------------------------------------------------------------
wordK_5778A:
		dc.w   $EE0,  $D00
		dc.w  $11E0,  $CC0
		dc.w  $1340,  $B20
		dc.w  $7FFF,     0
wordK_5779A:
		dc.w   $640,  $C60
		dc.w   $880,  $CA0
		dc.w  $1200,  $C60
		dc.w  $1380,  $A80
		dc.w  $13C0,  $660
		dc.w  $7FFF,  $3E0
wordK_577B2:
		dc.w  $19C0
		dc.w    $20
		dc.w    $20
		dc.w    $20
		dc.w    $20
		dc.w    $20
		dc.w    $20
		dc.w    $20
		dc.w    $20
		dc.w  $7FFF
wordK_577C6:
		dc.w      0,     9
		dc.w     $C,     6
		dc.w      3,    $C
		dc.w      0,     9
		dc.w     $C,     3
Pal_SSZDeathEgg:
		binclude "Levels/SSZ/Palettes/Death Egg.bin"
		even
; ---------------------------------------------------------------------------

SSZ1_BackgroundInit:
		clr.w	(Events_bg+$10).w
		jsr	(AllocateObject).l
		bne.s	locK_57840
		move.l	#locK_57B6A,(a1)
		lea	wordK_5853E(pc),a5
		move.w	(a5)+,d1

locK_57812:
		jsr	(CreateNewSprite4).l
		bne.s	locK_57840
		move.l	#locK_57B8E,(a1)
		move.w	(a5)+,d2
		move.b	d2,render_flags(a1)
		move.b	#$80,height_pixels(a1)
		move.w	(a5)+,x_pos(a1)
		move.w	(a5)+,y_vel(a1)
		move.w	(a5)+,$2E(a1)
		move.l	(a5)+,$30(a1)
		dbf	d1,locK_57812

locK_57840:
		move.w	(Camera_Y_pos).w,d0
		and.w	(Screen_Y_wrap_value).w,d0
		cmpi.w	#$800,d0
		blo.s	locK_57854
		cmpi.w	#$F00,d0
		blo.s	locK_5786A

locK_57854:
		jsr	subK_579F0(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

locK_5786A:
		move.w	#8,(Events_routine_bg).w
		jsr	subK_57A60(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		move.w	#$1C00,d1
		jsr	(Refresh_PlaneFull).l
		lea	SSZ1_BGDeformArray(pc),a4
		lea	(HScroll_table+$004).w,a5
		jmp	(ApplyDeformation).l
; ---------------------------------------------------------------------------

SSZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	SSZ1_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

SSZ1_BackgroundEvent_Index:
		bra.w	locK_578AA
; ---------------------------------------------------------------------------
		bra.w	locK_57942
; ---------------------------------------------------------------------------
		bra.w	locK_57960
; ---------------------------------------------------------------------------
		bra.w	locK_579D2
; ---------------------------------------------------------------------------

locK_578AA:
		move.w	(Camera_Y_pos).w,d0
		and.w	(Screen_Y_wrap_value).w,d0
		cmpi.w	#$800,d0
		blo.s	locK_578EC
		cmpi.w	#$F00,d0
		bhs.s	locK_578EC
		move.w	(Camera_X_pos_BG_copy).w,(Events_bg+$0C).w
		move.w	(Camera_Y_pos_BG_copy).w,(Events_bg+$0E).w
		jsr	subK_57A60(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_57946
; ---------------------------------------------------------------------------

locK_578EC:
		jsr	subK_579F0(pc)

locK_578F0:
		jsr	(DrawBGAsYouMove).l
		jsr	(PlainDeformation).l
		jsr	(ShakeScreen_Setup).l
		tst.w	(_unkEE98).w
		bne.s	locK_57916
		lea	wordK_577B2(pc),a4
		lea	(HScroll_table+$0BE).w,a5
		jmp	(Apply_FGVScroll).l
; ---------------------------------------------------------------------------

locK_57916:
		move.w	(_unkEEFA).w,d0
		beq.s	locK_57932
		clr.w	(_unkEEFA).w
		move.w	d0,(a0)+
		move.w	#7,(a0)+
		moveq	#$20-1,d0

locK_57928:
		move.w	#$6061,(a0)+
		dbf	d0,locK_57928
		clr.w	(a0)

locK_57932:
		move.w	(_unkEEEE).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp
		rts
; ---------------------------------------------------------------------------

locK_57942:
		jsr	subK_57A60(pc)

locK_57946:
		move.w	#$1C00,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	locK_5799A
		clr.w	(Events_bg+$0C).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_5799A
; ---------------------------------------------------------------------------

locK_57960:
		move.w	(Camera_Y_pos).w,d0
		and.w	(Screen_Y_wrap_value).w,d0
		cmpi.w	#$800,d0
		blo.s	locK_57974
		cmpi.w	#$F00,d0
		blo.s	locK_57996

locK_57974:
		jsr	subK_579F0(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_579D6
; ---------------------------------------------------------------------------

locK_57996:
		jsr	subK_57A60(pc)

locK_5799A:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	#$1C00,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l
		move.w	(Events_bg+$0C).w,d0
		beq.s	locK_579C4
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	(Events_bg+$0E).w,(Camera_Y_pos_BG_copy).w
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

locK_579C4:
		lea	SSZ1_BGDeformArray(pc),a4
		lea	(HScroll_table+$004).w,a5
		jmp	(ApplyDeformation).l
; ---------------------------------------------------------------------------

locK_579D2:
		jsr	subK_579F0(pc)

locK_579D6:
		move.w	(Camera_X_pos_BG_copy).w,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	(Draw_PlaneVertSingleBottomUp).l
		bpl.w	locK_578F0
		clr.w	(Events_routine_bg).w
		bra.w	locK_578F0

; =============== S U B R O U T I N E =======================================


subK_579F0:
		tst.w	(Events_bg+$10).w
		bne.s	locK_57A30
		cmpi.w	#$1800,(Camera_X_pos).w
		blo.s	locK_57A12
		st	(Events_bg+$10).w
		bsr.s	subK_579F0
		move.w	(Camera_X_pos_BG_copy).w,d0
		andi.w	#$FFF0,d0
		move.w	d0,(Camera_X_pos_BG_rounded).w
		rts
; ---------------------------------------------------------------------------

locK_57A12:
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$160,d0
		add.w	(_unkEE9C).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		addi.w	#$28,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; ---------------------------------------------------------------------------

locK_57A30:
		cmpi.w	#$1800,(Camera_X_pos).w
		bhs.s	locK_57A4C
		clr.w	(Events_bg+$10).w
		bsr.s	subK_579F0
		move.w	(Camera_X_pos_BG_copy).w,d0
		andi.w	#$FFF0,d0
		move.w	d0,(Camera_X_pos_BG_rounded).w
		rts
; ---------------------------------------------------------------------------

locK_57A4C:
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$180,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,(Camera_X_pos_BG_copy).w
		rts
; End of function subK_579F0


; =============== S U B R O U T I N E =======================================


subK_57A60:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(_unkEE9C).w,d1
		asr.w	#1,d1
		add.w	d1,d0
		and.w	(Screen_Y_wrap_value).w,d0
		subi.w	#$800,d0
		asr.w	#1,d0
		addi.w	#$A0,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		lea	(HScroll_table+$004).w,a1
		move.l	-4(a1),d2
		addi.l	#$500,-4(a1)
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#5,d0
		move.l	d0,d1
		asr.l	#1,d0
		add.l	d2,d0
		swap	d0
		move.w	d0,(a1)
		move.w	d0,6(a1)
		move.w	d0,$A(a1)
		move.w	d0,$14(a1)
		swap	d0
		add.l	d2,d1
		add.l	d1,d0
		swap	d0
		move.w	d0,8(a1)
		move.w	d0,$E(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,4(a1)
		move.w	d0,$C(a1)
		move.w	d0,$12(a1)
		move.w	d0,$16(a1)
		move.w	d0,$3A(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,2(a1)
		move.w	d0,$10(a1)
		move.w	d0,$18(a1)
		move.w	d0,$38(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$1A(a1)
		move.w	d0,$36(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$1C(a1)
		move.w	d0,$34(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$1E(a1)
		move.w	d0,$32(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$20(a1)
		move.w	d0,$30(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$22(a1)
		move.w	d0,$2E(a1)
		swap	d0
		add.l	d1,d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$24(a1)
		move.w	d0,$2C(a1)
		swap	d0
		move.l	d1,d2
		asr.l	#1,d2
		add.l	d1,d0
		add.l	d1,d0
		add.l	d2,d0
		swap	d0
		move.w	d0,$26(a1)
		move.w	d0,$2A(a1)
		swap	d0
		add.l	d1,d0
		add.l	d1,d0
		add.l	d2,d0
		swap	d0
		move.w	d0,$28(a1)
		rts
; End of function subK_57A60

; ---------------------------------------------------------------------------

locK_57B6A:
		move.l	#locK_57B76,(a0)
		move.w	#$8000,$30(a0)

locK_57B76:
		move.l	#$8000,d0
		move.l	#$100,d1
		jsr	(Gradual_SwingOffset).l
		move.w	d0,(_unkEE9C).w
		rts
; ---------------------------------------------------------------------------

locK_57B8E:
		bset	#7,status(a0)
		move.w	y_vel(a0),d0
		sub.w	(_unkEE9C).w,d0
		move.w	d0,y_pos(a0)
		move.w	$2E(a0),d1
		movea.l	$30(a0),a2
		move.w	x_pos(a0),d4
		jmp	(SolidObjectTopSloped2).l
; ---------------------------------------------------------------------------

locK_57BB2:
		move.l	#locK_57BF6,(a0)
		move.b	#$40,render_flags(a0)
		move.b	#$10,height_pixels(a0)
		move.b	#$30,width_pixels(a0)
		move.w	#0,priority(a0)
		move.w	#make_art_tile(ArtTile_SSZMisc+$3C,3,1),art_tile(a0)
		move.l	#Map_SSZRoamingClouds,mappings(a0)
		move.w	$38(a0),y_vel(a0)
		jsr	(Random_Number).l
		andi.w	#$FFF,d0
		addi.w	#$C00,d0
		move.w	d0,$30(a0)

locK_57BF6:
		move.l	#$1C00,d0
		move.l	#$80,d1
		jsr	(Gradual_SwingOffset).l
		add.w	y_vel(a0),d0
		move.w	d0,$38(a0)
		move.l	$3E(a0),d0
		sub.l	d0,$3A(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_57C1E:
		jsr	(AllocateObjectAfterCurrent).l
		beq.s	locK_57C28
		rts
; ---------------------------------------------------------------------------

locK_57C28:
		move.l	#locK_57CD2,(a0)
		move.w	#$1000,y_pos(a0)
		move.w	#-$100,$38(a0)
		move.w	a1,$3C(a0)
		move.l	#Obj_TeleporterBeamExpand,(a1)
		move.b	#$44,render_flags(a1)
		move.b	#$80,height_pixels(a1)
		move.b	#$18,width_pixels(a1)
		move.w	#$80,priority(a1)
		move.w	#make_art_tile(ArtTile_SSZMisc+$88,3,1),art_tile(a1)
		move.l	#Map_SSZHPZTeleporter,mappings(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.w	#2,mainspr_childsprites(a1)
		move.w	y_pos(a0),$44(a1)
		subi.w	#$88,$44(a1)
		move.b	#$18,$46(a1)
		move.w	a0,$48(a1)
		tst.b	(Current_act).w
		bne.s	locK_57CAC
		jsr	(CreateNewSprite4).l
		bne.s	locK_57CAC
		move.l	#Obj_57E34,(a1)
		move.w	#$60,subtype(a1)

locK_57CAC:
		st	(Events_bg+$04).w
		lea	(Player_1).w,a1
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$65,d0
		move.w	d0,y_pos(a1)
		move.b	#3,object_control(a1)
		moveq	#0,d0
		move.b	d0,anim(a1)
		move.b	d0,mapping_frame(a1)
		rts
; ---------------------------------------------------------------------------

locK_57CD2:
		jsr	(sub_45866).l
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)
		tst.b	$2D(a0)
		bne.w	locK_57D50
		move.b	#1,object_control(a1)
		move.b	#2,anim(a1)
		bset	#Status_Roll,status(a1)
		move.w	#-1,y_vel(a1)
		move.w	y_pos(a1),d1
		move.w	d1,$3E(a0)
		tst.b	(Current_act).w
		beq.s	locK_57D18
		bset	#7,art_tile(a1)
		bra.s	locK_57D3C
; ---------------------------------------------------------------------------

locK_57D18:
		tst.w	(Player_mode).w
		bne.s	locK_57D3C
		jsr	(CreateNewSprite4).l
		bne.s	locK_57D3C
		move.l	#Obj_57DCC,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	d1,$3E(a1)
		move.w	#$C,subtype(a1)

locK_57D3C:
		clr.b	(Scroll_lock).w
		movea.w	$3C(a0),a1
		st	5(a1)
		move.l	#Obj_57D64,(a0)
		rts
; ---------------------------------------------------------------------------

locK_57D50:
		subi.w	#8,y_pos(a1)
		subq.b	#1,$2D(a0)
		beq.s	locretK_57D62
		subi.w	#8,(Camera_Y_pos).w

locretK_57D62:
		rts
; ---------------------------------------------------------------------------

Obj_57D64:
		jsr	(sub_45866).l
		lea	(Player_1).w,a1
		move.l	#$20000,d0
		move.l	#$800,d1
		jsr	(Gradual_SwingOffset).l
		add.w	$3E(a0),d0
		move.w	d0,y_pos(a1)
		tst.l	$2E(a0)
		bmi.s	locretK_57DA0
		clr.b	object_control(a1)
		clr.b	anim(a1)
		clr.b	(Events_bg+$04).w
		move.l	#locK_57DA2,(a0)

locretK_57DA0:
		rts
; ---------------------------------------------------------------------------

locK_57DA2:
		move.w	(Camera_Y_pos).w,d0
		cmp.w	(Camera_max_Y_pos).w,d0
		bne.s	locK_57DC6
		cmp.w	(Camera_min_Y_pos).w,d0
		beq.s	locK_57DB6
		move.w	d0,(Camera_min_Y_pos).w

locK_57DB6:
		move.w	$3A(a0),d0
		or.b	$38(a0),d0
		bne.s	locK_57DC6
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locK_57DC6:
		jmp	(sub_45866).l
; ---------------------------------------------------------------------------

Obj_57DCC:
		lea	(Player_2).w,a1
		tst.w	subtype(a0)
		beq.s	locK_57DFA
		subq.w	#1,subtype(a0)
		bne.s	locretK_57E32
		move.w	x_pos(a0),x_pos(a1)
		move.b	#1,$2E(a1)
		move.b	#2,anim(a1)
		bset	#Status_Roll,status(a1)
		move.w	#-1,y_vel(a1)

locK_57DFA:
		move.l	#$20000,d0
		move.l	#$800,d1
		jsr	(Gradual_SwingOffset).l
		add.w	$3E(a0),d0
		move.w	d0,y_pos(a1)
		tst.l	$2E(a0)
		bmi.s	locretK_57E32
		clr.b	object_control(a1)
		clr.b	anim(a1)
		clr.w	(Tails_CPU_flight_timer).w
		move.w	#6,(Tails_CPU_routine).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locretK_57E32:
		rts
; ---------------------------------------------------------------------------

Obj_57E34:
		tst.w	subtype(a0)
		beq.s	locK_57E64
		subq.w	#1,subtype(a0)
		bne.s	locretK_57E94
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locretK_57E94
		move.l	#Obj_CutsceneKnuckles,(a1)
		move.w	#$100,x_pos(a1)
		move.b	#$2C,subtype(a1)
		move.w	a1,$20(a0)
		move.w	#$C4E,$3E(a0)

locK_57E64:
		movea.w	$20(a0),a1
		move.l	#$20000,d0
		move.l	#$800,d1
		jsr	(Gradual_SwingOffset).l
		add.w	$3E(a0),d0
		move.w	d0,y_pos(a1)
		tst.l	$2E(a0)
		bmi.s	locretK_57E94
		bset	#0,(_unkFAB8).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locretK_57E94:
		rts
; ---------------------------------------------------------------------------


Obj_57E96:
		cmpi.b	#4,routine(a0)
		bhi.s	locK_57EB0
		move.w	(Level_frame_counter).w,d0
		andi.w	#$F,d0
		bne.s	locK_57EB0
		moveq	#signextendB(sfx_BigRumble),d0
		jsr	(Play_SFX).l

locK_57EB0:
		moveq	#0,d0
		move.b	routine(a0),d0
		jmp	locK_57EBA(pc,d0.w)
; ---------------------------------------------------------------------------

locK_57EBA:
		bra.w	locK_57ECA
; ---------------------------------------------------------------------------
		bra.w	locK_57EDC
; ---------------------------------------------------------------------------
		bra.w	locK_57F18
; ---------------------------------------------------------------------------
		bra.w	locK_57F3E
; ---------------------------------------------------------------------------

locK_57ECA:
		subq.w	#1,$2E(a0)
		bne.w	locretK_57FBE
		move.w	#4,$30(a0)
		addq.b	#4,routine(a0)

locK_57EDC:
		jsr	subK_57FC0(pc)
		cmpi.w	#$600,(Camera_Y_pos).w
		blo.w	locretK_57FBE
		jsr	subK_57FE2(pc)
		cmpi.w	#$60C,(Camera_Y_pos).w
		blo.w	locretK_57FBE
		lea	(HScroll_table+$E0).w,a1
		lea	wordK_577C6(pc),a5
		moveq	#($A/2)-1,d0

locK_57F02:
		move.l	(a5)+,(a1)+
		dbf	d0,locK_57F02
		moveq	#signextendB(sfx_Collapse),d0
		jsr	(Play_SFX).l
		addq.b	#4,routine(a0)
		bra.w	locretK_57FBE
; ---------------------------------------------------------------------------

locK_57F18:
		jsr	subK_57FC0(pc)
		jsr	subK_57FE2(pc)
		cmpi.w	#$640,(Camera_Y_pos).w
		blo.w	locretK_57FBE
		move.w	#$10-1,$2E(a0)
		move.w	#8,$30(a0)
		clr.w	$32(a0)
		addq.b	#4,routine(a0)

locK_57F3E:
		tst.w	(Events_fg_4).w
		bpl.s	locretK_57FBE
		tst.w	$2E(a0)
		beq.s	locK_57F5E
		subq.w	#1,$2E(a0)
		bne.s	locretK_57FBE
		jsr	(AllocateObject).l
		bne.s	locK_57F5E
		move.l	#Obj_583BE,(a1)

locK_57F5E:
		cmpi.w	#$5C0,(Camera_Y_pos).w
		bhs.s	locK_57F7E
		jsr	subK_58048(pc)
		move.w	(Level_frame_counter).w,d0
		addq.w	#8,d0
		andi.w	#$F,d0
		bne.s	locK_57F7E
		moveq	#signextendB(sfx_DeathEggRiseLoud),d0
		jsr	(Play_SFX).l

locK_57F7E:
		move.w	#$500,d0
		moveq	#0,d1
		move.b	$30(a0),d1
		subq.w	#1,d1
		bcs.s	locK_57F94

locK_57F8C:
		subi.w	#$70,d0
		dbf	d1,locK_57F8C

locK_57F94:
		moveq	#0,d1
		move.b	$31(a0),d1
		sub.w	d1,d0
		move.w	(Camera_Y_pos).w,d1
		sub.w	d0,d1
		bcs.s	locretK_57FBE
		cmpi.w	#2,d1
		bls.s	locK_57FAC
		moveq	#2,d1

locK_57FAC:
		sub.w	d1,(Camera_Y_pos).w
		cmpi.w	#$110,(Camera_Y_pos).w
		bhs.s	locretK_57FBE
		move.w	#$110,(Camera_Y_pos).w

locretK_57FBE:
		rts

; =============== S U B R O U T I N E =======================================


subK_57FC0:
		cmpi.w	#$618,(Camera_Y_pos).w
		blo.s	locK_57FD2
		btst	#0,(Level_frame_counter+1).w
		beq.s	locretK_57FE0
		bra.s	locK_57FDC
; ---------------------------------------------------------------------------

locK_57FD2:
		move.w	(Level_frame_counter).w,d0
		andi.w	#3,d0
		beq.s	locretK_57FE0

locK_57FDC:
		addq.w	#1,(Camera_Y_pos).w

locretK_57FE0:
		rts
; End of function subK_57FC0


; =============== S U B R O U T I N E =======================================


subK_57FE2:
		lea	(Player_1).w,a1
		lea	(Ctrl_1_logical).w,a2
		lea	$30(a0),a3
		bsr.s	subK_58002
		tst.w	(Player_mode).w
		bne.s	locretK_58046
		lea	(Player_2).w,a1
		lea	(Ctrl_2_logical).w,a2
		lea	$31(a0),a3
; End of function subK_57FE2


; =============== S U B R O U T I N E =======================================


subK_58002:
		tst.b	object_control(a1)
		bne.s	locretK_58046
		tst.b	(a3)
		bmi.s	locK_58016
		subq.b	#1,(a3)
		bpl.s	locretK_58046
		move.w	#(button_C_mask<<8)|button_C_mask,(a2)
		rts
; ---------------------------------------------------------------------------

locK_58016:
		tst.w	y_vel(a1)
		bmi.s	locK_58034
		move.w	#$7FFF,y_pos(a1)
		andi.b	#$FC,render_flags(a1)
		move.b	#3,object_control(a1)
		clr.b	anim(a1)
		bra.s	locretK_58046
; ---------------------------------------------------------------------------

locK_58034:
		move.w	#$2800,d0
		cmpi.w	#$1A40,x_pos(a1)
		blo.s	locK_58044
		move.w	#$2400,d0

locK_58044:
		move.w	d0,(a2)

locretK_58046:
		rts
; End of function subK_58002


; =============== S U B R O U T I N E =======================================


subK_58048:
		lea	(Player_1).w,a1
		lea	$30(a0),a2
		moveq	#0,d3
		cmpi.w	#2,(Player_mode).w
		bne.s	locK_5805C
		moveq	#-1,d3

locK_5805C:
		bsr.s	subK_5806E
		tst.w	(Player_mode).w
		bne.s	locretK_58046
		lea	(Player_2).w,a1
		lea	$32(a0),a2
		moveq	#-1,d3
; End of function subK_58048


; =============== S U B R O U T I N E =======================================


subK_5806E:
		tst.w	4(a2)
		bne.w	locK_58192
		cmpi.w	#$910,(a2)
		bne.s	locK_580CC
		st	4(a2)
		move.b	#1,object_control(a1)
		bset	#Status_InAir,status(a1)
		move.b	#1,jumping(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		move.b	#2,anim(a1)
		bset	#Status_Roll,status(a1)
		move.w	#$800,ground_vel(a1)
		move.w	#$400,x_vel(a1)
		move.w	#-$680,y_vel(a1)
		clr.w	2+x_pos(a1)
		clr.w	2+y_pos(a1)
		moveq	#signextendB(sfx_Jump),d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

locK_580CC:
		moveq	#0,d0
		move.b	1(a2),d0
		addq.b	#1,d0
		cmpi.b	#$70,d0
		blo.s	locK_580E0
		subi.b	#$70,d0
		addq.b	#1,(a2)

locK_580E0:
		move.b	d0,1(a2)
		lea	byteK_587B4(pc),a6
		move.b	(a6,d0.w),d0
		move.w	d0,d2
		andi.w	#drawing_mask,art_tile(a1)
		addi.b	#$40,d2
		bmi.s	locK_58100
		ori.w	#high_priority,art_tile(a1)

locK_58100:
		jsr	(GetSineCosine).l
		muls.w	#$4C00,d0
		swap	d0
		move.w	#$1A40,x_pos(a1)
		add.w	d0,x_pos(a1)
		muls.w	#$1C00,d1
		swap	d1
		subi.b	#$40,d2
		bpl.s	locK_58128
		neg.w	d1
		subi.w	#$38,d1

locK_58128:
		move.w	#$570,y_pos(a1)
		add.w	d1,y_pos(a1)
		lea	byteK_58824(pc),a6
		moveq	#0,d0
		move.b	1(a2),d0
		move.b	(a6,d0.w),d0
		ext.w	d0
		sub.w	d0,y_pos(a1)
		moveq	#0,d0
		move.b	(a2),d0
		subq.w	#1,d0
		bcs.s	locK_58158

locK_5814E:
		subi.w	#$70,y_pos(a1)
		dbf	d0,locK_5814E

locK_58158:
		tst.w	d3
		beq.s	locK_58170
		addq.w	#4,y_pos(a1)
		move.w	#$100,priority(a1)
		tst.b	d2
		bmi.s	locK_58170
		move.w	#$80,priority(a1)

locK_58170:
		addi.w	#$A,d2
		andi.w	#$FF,d2
		move.w	d2,d0
		add.w	d2,d2
		add.w	d0,d2
		lsr.w	#6,d2
		lea	byteK_587A8(pc),a2
		move.b	(a2,d2.w),d0
		move.b	d0,mapping_frame(a1)
		jmp	(Perform_Player_DPLC).l
; ---------------------------------------------------------------------------

locK_58192:
		tst.w	4(a2)
		bpl.s	locK_581D2
		move.w	x_vel(a1),d0
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,x_pos(a1)
		move.w	y_vel(a1),d0
		addi.w	#$38,y_vel(a1)
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,y_pos(a1)
		tst.w	y_vel(a1)
		bmi.s	locretK_581F0
		move.b	#3,object_control(a1)
		clr.b	mapping_frame(a1)
		clr.b	anim(a1)
		move.w	#3*60,4(a2)
		bra.s	locretK_581F0
; ---------------------------------------------------------------------------

locK_581D2:
		cmpa.w	#Player_1,a1
		bne.s	locretK_581F0
		subq.w	#1,4(a2)
		bne.s	locretK_581F0
		moveq	#signextendB(cmd_FadeOut),d0
		jsr	(Play_Music).l
		move.w	#$B00,d0
		jmp	(StartNewLevel).l
; ---------------------------------------------------------------------------

locretK_581F0:
		rts
; End of function subK_5806E

; ---------------------------------------------------------------------------

locK_581F2:
		move.l	#locK_5821E,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$1C,height_pixels(a0)
		move.w	#$80,priority(a0)
		move.w	#make_art_tile(ArtTile_SSZSpiralRamp,2,1),art_tile(a0)
		move.l	#Map_SSZCollapsingBridge,mappings(a0)
		move.b	#9,mapping_frame(a0)

locK_5821E:
		move.w	y_pos(a0),d0
		subi.w	#$24,d0
		cmp.w	(Player_1+y_pos).w,d0
		bhs.w	locK_583A0
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_58234:
		move.l	#locK_58260,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#$80,priority(a0)
		move.w	#make_art_tile(ArtTile_SSZMisc+$20,2,1),art_tile(a0)
		move.l	#Map_SSZCollapsingBridge,mappings(a0)
		move.b	#6,mapping_frame(a0)

locK_58260:
		move.w	y_pos(a0),d0
		move.b	mapping_frame(a0),d1
		subq.b	#6,d1
		beq.s	locK_58288
		subq.b	#1,d1
		beq.s	locK_5827E
		subi.w	#$2C,d0
		cmp.w	(Player_1+y_pos).w,d0
		blo.s	locK_582A6
		bra.w	locK_583A0
; ---------------------------------------------------------------------------

locK_5827E:
		moveq	#-$20,d1
		moveq	#8,d2
		subi.w	#$24,d0
		bra.s	locK_58290
; ---------------------------------------------------------------------------

locK_58288:
		moveq	#-$40,d1
		moveq	#$10,d2
		subi.w	#$1C,d0

locK_58290:
		cmp.w	(Player_1+y_pos).w,d0
		blo.s	locK_582A6
		addq.b	#1,mapping_frame(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locK_582A6
		moveq	#8,d0
		bra.s	locK_5831E
; ---------------------------------------------------------------------------

locK_582A6:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_582AC:
		move.l	#locK_582D8,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#$200,priority(a0)
		move.w	#make_art_tile(ArtTile_SSZMisc+$20,2,0),art_tile(a0)
		move.l	#Map_SSZCollapsingBridge,mappings(a0)
		move.b	#$B,mapping_frame(a0)

locK_582D8:
		move.w	y_pos(a0),d0
		move.b	mapping_frame(a0),d1
		subi.b	#$B,d1
		beq.s	locK_58302
		subq.b	#1,d1
		beq.s	locK_582F8
		subi.w	#$2C,d0
		cmp.w	(Player_1+y_pos).w,d0
		blo.s	locK_5835A
		bra.w	locK_583A0
; ---------------------------------------------------------------------------

locK_582F8:
		moveq	#$20,d1
		moveq	#8,d2
		subi.w	#$24,d0
		bra.s	locK_5830A
; ---------------------------------------------------------------------------

locK_58302:
		moveq	#$40,d1
		moveq	#$10,d2
		subi.w	#$1C,d0

locK_5830A:
		cmp.w	(Player_1+y_pos).w,d0
		blo.s	locK_5835A
		addq.b	#1,mapping_frame(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locK_5835A
		moveq	#$D,d0

locK_5831E:
		move.l	#locK_583A6,(a1)
		move.b	#$84,render_flags(a1)
		move.b	#$10,height_pixels(a1)
		move.w	priority(a0),priority(a1)
		move.w	art_tile(a0),art_tile(a1)
		move.l	mappings(a0),mappings(a1)
		move.b	d0,mapping_frame(a1)
		move.w	x_pos(a0),x_pos(a1)
		add.w	d1,x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		add.w	d2,y_pos(a1)

locK_5835A:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_58360:
		move.l	#locK_5838C,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$1C,height_pixels(a0)
		move.w	#$100,priority(a0)
		move.w	#make_art_tile(ArtTile_SSZSpiralRamp,2,1),art_tile(a0)
		move.l	#Map_SSZCollapsingBridge,mappings(a0)
		move.b	#$A,mapping_frame(a0)

locK_5838C:
		move.w	y_pos(a0),d0
		subi.w	#$24,d0
		cmp.w	(Player_1+y_pos).w,d0
		bhs.s	locK_583A0
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_583A0:
		move.l	#locK_583A6,(a0)

locK_583A6:
		tst.b	render_flags(a0)
		bmi.s	locK_583B2
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locK_583B2:
		jsr	(MoveSprite).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_583BE:
		tst.w	(_unkEE98).w
		bne.s	locK_583C6
		rts
; ---------------------------------------------------------------------------

locK_583C6:
		move.l	#locK_583D2,(a0)
		move.w	#$870,$2E(a0)

locK_583D2:
		move.w	(Level_frame_counter).w,d0
		andi.w	#$F,d0
		bne.s	locK_583E4
		moveq	#signextendB(sfx_BigRumble),d0
		jsr	(Play_SFX).l

locK_583E4:
		tst.w	$30(a0)
		beq.s	locK_583F2
		subq.w	#1,$30(a0)
		bra.w	locretK_584A0
; ---------------------------------------------------------------------------

locK_583F2:
		move.w	(Player_1+y_pos).w,d0
		cmpi.w	#$4000,d0
		blo.s	locK_58400
		move.w	#$5C0,d0

locK_58400:
		addi.w	#$198,d0
		move.w	$2E(a0),d1
		cmp.w	d1,d0
		bhi.w	locretK_584A0
		move.w	d1,d0
		cmpi.w	#$300,d0
		bhs.s	locK_5841C
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locK_5841C:
		lsl.w	#4,d1
		andi.w	#$F00,d1
		addi.w	#-$2000,d1
		move.w	d1,(_unkEEFA).w
		lea	wordK_58894(pc),a2
		cmpi.w	#$380,d0
		blo.s	locK_58442
		lea	$80(a2),a2
		cmpi.w	#$800,d0
		blo.s	locK_58442
		lea	$80(a2),a2

locK_58442:
		lea	byteK_58A3E(pc),a3
		move.w	$32(a0),d4
		addq.w	#3,$32(a0)
		move.w	d0,d1
		andi.w	#$70,d0
		adda.w	d0,a2
		subi.w	#$178,d1
		move.w	#$1A08,d2
		moveq	#8-1,d3
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locK_58494

locK_58468:
		move.l	#locK_584A2,(a1)
		move.w	(a2)+,art_tile(a1)
		move.w	d2,x_pos(a1)
		move.w	d1,y_pos(a1)
		andi.w	#7,d4
		move.b	(a3,d4.w),$2E(a1)
		addq.w	#1,d4
		addi.w	#$10,d2
		jsr	(CreateNewSprite4).l
		dbne	d3,locK_58468

locK_58494:
		subi.w	#$10,$2E(a0)
		move.w	#7,$30(a0)

locretK_584A0:
		rts
; ---------------------------------------------------------------------------

locK_584A2:
		move.w	art_tile(a0),d0
		bpl.s	locK_584BE
		clr.w	art_tile(a0)
		addq.w	#1,d0
		beq.s	locK_584E4
		move.b	#1,mapping_frame(a0)
		addq.w	#1,d0
		beq.s	locK_584BE
		addq.b	#1,mapping_frame(a0)

locK_584BE:
		move.l	#locK_584DE,(a0)
		move.b	#$84,render_flags(a0)
		move.b	#8,height_pixels(a0)
		move.w	#$180,priority(a0)
		move.l	#Map_SSZSpiralRampPieces,mappings(a0)

locK_584DE:
		tst.b	render_flags(a0)
		bmi.s	locK_584EA

locK_584E4:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locK_584EA:
		tst.b	$2E(a0)
		beq.s	locK_584F6
		subq.b	#1,$2E(a0)
		bra.s	locK_584FC
; ---------------------------------------------------------------------------

locK_584F6:
		jsr	(MoveSprite).l

locK_584FC:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
SSZ1_BGDeformArray:
		dc.w   $1D0
		dc.w    $10
		dc.w      8
		dc.w    $18
		dc.w    $10
		dc.w    $10
		dc.w      8
		dc.w    $28
		dc.w    $10
		dc.w      8
		dc.w      8
		dc.w    $28
		dc.w      8
		dc.w    $20
		dc.w      8
		dc.w      8
		dc.w      8
		dc.w    $10
		dc.w    $18
		dc.w    $20
		dc.w    $40
		dc.w    $20
		dc.w    $18
		dc.w    $10
		dc.w      8
		dc.w      8
		dc.w      8
		dc.w    $20
		dc.w      8
		dc.w  $7FFF
wordK_5853E:
		dc.w $A-1
		dc.w      0,  $C38,   $C0,   $A0
		dc.l byteK_585B8
		dc.w      0,  $E58,  $180,  $180
		dc.l byteK_585B8
		dc.w      0, $13D8,  $200,  $140
		dc.l byteK_58618
		dc.w      0,  $D78,  $2C0,   $E0
		dc.l byteK_58618
		dc.w      1,  $F18,  $2C0,   $C0
		dc.l byteK_58638
		dc.w      1,  $9D8,  $580,  $140
		dc.l byteK_58618
		dc.w      0,  $E18,  $5C0,  $100
		dc.l byteK_58658
		dc.w      0,  $F78,  $6C0,  $120
		dc.l byteK_58638
		dc.w      0,  $498,  $540,   $40
		dc.l byteK_585B8
		dc.w      0,  $618,  $500,   $40
		dc.l byteK_585B8
byteK_585B8:
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21
byteK_58618:
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21
byteK_58638:
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21
byteK_58658:
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $22, $22, $22, $22, $22, $22, $22, $22
		dc.b  $23, $23, $23, $23, $23, $23, $24, $24, $24, $24, $24, $25, $25, $25, $26, $26, $26, $27, $27, $27
		dc.b  $28, $28, $29, $29, $2A, $2A, $2B, $2B, $2C, $2C, $2D, $2D, $2E, $2F, $2F, $30, $31, $31, $32, $33
		dc.b  $33, $34, $35, $36, $37, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41, $42, $43, $44, $45
		dc.b  $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4E, $4F, $50, $51, $52, $53, $53, $53, $54, $55, $55
		dc.b  $56, $56, $57, $58, $58, $59, $59, $5A, $5A, $5A, $5B, $5B, $5C, $5C, $5C, $5D, $5D, $5E, $5E, $5E
		dc.b  $5E, $5F, $5F, $5F, $5F, $60, $60, $60, $60, $60, $60, $61, $61, $61, $61, $61, $61, $61, $61, $61
		dc.b  $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61
		dc.b  $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61
		dc.b  $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61
		dc.b  $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61
		dc.b  $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61
		even
wordK_58758:
		dc.w    $10,   $30, $FE00,     1
		dc.w    $44,  $100, $9E00,     2
		dc.w    $78,   $B0, $E600,     1
		dc.w    $AC,  $1C0, $B600,     2
		dc.w    $D8,  $140, $CE00,     1
Map_SSZRoamingClouds:
		include "Levels/SSZ/Misc Object Data/Map - Roaming Clouds.asm"
byteK_587A8:
		dc.b  $EF, $FA, $F9, $F8, $F7, $F6, $F5, $F4, $F3, $F2, $F1, $F0
byteK_587B4:
		dc.b    0,   2,   5,   7,   9,  $B,  $E, $10, $12, $15, $17, $19, $1B, $1E, $20, $22, $25, $27, $29, $2B
		dc.b  $2E, $30, $32, $35, $37, $39, $3B, $3E, $40, $42, $45, $47, $49, $4B, $4E, $50, $52, $55, $57, $59
		dc.b  $5B, $5E, $60, $62, $65, $67, $69, $6B, $6E, $70, $72, $75, $77, $79, $7B, $7E, $80, $82, $85, $87
		dc.b  $89, $8B, $8E, $90, $92, $95, $97, $99, $9B, $9E, $A0, $A2, $A5, $A7, $A9, $AB, $AE, $B0, $B2, $B5
		dc.b  $B7, $B9, $BB, $BE, $C0, $C2, $C5, $C7, $C9, $CB, $CE, $D0, $D2, $D5, $D7, $D9, $DB, $DE, $E0, $E2
		dc.b  $E5, $E7, $E9, $EB, $EE, $F0, $F2, $F5, $F7, $F9, $FB, $FE
byteK_58824:
		dc.b    3,   3,   4,   5,   6,   6,   7,   7,   8,   8,   8,   8,   7,   7,   7,   7,   7,   6,   5,   4
		dc.b    3,   3,   3,   2,   1,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,  -1,  -1,  -1,  -1,  -2
		dc.b   -2,  -2,  -2,  -2,  -2,  -3,  -3,  -3,  -3,  -2,  -2,  -1,  -1,   0,   0,   2,   3,   4,   5,   6
		dc.b    7,   7,   8,   8,   9,   9,   9,   8,   7,   7,   7,   7,   7,   6,   5,   4,   3,   3,   3,   2
		dc.b    1,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,  -1,  -1,  -1,  -1,  -2,  -2,  -1,  -1,  -1
		dc.b   -1,  -2,  -2,  -2,  -2,  -1,  -1,   0,   0,   0,   1,   3
		even
wordK_58894:
		dc.w  $4000, $4004, $4008, $400C, $480C, $4808, $4804, $4800
		dc.w  $4010, $4014, $4018, $401C, $481C, $4818, $4814, $4810
		dc.w  $4020, $4024, $4028, $402C, $482C, $4828, $4824, $4820
		dc.w  $4020, $4024, $4028, $402C, $482C, $4828, $4824, $4820
		dc.w  $4030, $4034, $4038, $403C, $483C, $4838, $4834, $4830
		dc.w  $4040, $4044, $4048, $404C, $484C, $4848, $4844, $4840
		dc.w  $4020, $4024, $4028, $402C, $482C, $4828, $4824, $4820
		dc.w  $4040, $4044, $4048, $404C, $484C, $4848, $4844, $4840
		dc.w  $4020, $4024, $4028, $402C, $482C, $4828, $4824, $4820
		dc.w  $4040, $4044, $4048, $404C, $484C, $4848, $4844, $4840
		dc.w  $4020, $4024, $4028, $402C, $482C, $4828, $4824, $4820
		dc.w  $4020, $4024, $4028, $402C, $482C, $4828, $4824, $4820
		dc.w  $4030, $4034, $4038, $403C, $483C, $4838, $4834, $4830
		dc.w  $4040, $4044, $4048, $404C, $484C, $4848, $4844, $4840
		dc.w  $4020, $4024, $4028, $402C, $482C, $4828, $4824, $4820
		dc.w  $4040, $4044, $4048, $404C, $484C, $4848, $4844, $4840
		dc.w  $4020, $4024, $4028, $402C, $482C, $4828, $4824, $4820
		dc.w  $4040, $4044, $4048, $404C, $484C, $4848, $4844, $4840
		dc.w  $4020, $4024, $4028, $402C, $482C, $4828, $4824, $4820
		dc.w  $4040, $4044, $4048, $404C, $484C, $4848, $4844, $4840
		dc.w  $4020, $4024, $4028, $402C, $482C, $4828, $4824, $4820
		dc.w  $4040, $4044, $4048, $404C, $484C, $4848, $4844, $4840
		dc.w  $FFFE, $4054, $4058, $405C, $485C, $4858, $4854, $FFFD
		dc.w  $FFFF, $FFFF, $FFFE, $4068, $4868, $FFFD, $FFFF, $FFFF
Map_SSZSpiralRampPieces:
		include "Levels/SSZ/Misc Object Data/Map - Spiral Ramp Pieces.asm"
byteK_58A3E:
		dc.b  $1C
		dc.b    8
		dc.b  $10
		dc.b    0
		dc.b    4
		dc.b  $14
		dc.b  $18
		dc.b   $C
		even
; ---------------------------------------------------------------------------

SSZ2_ScreenInit:
		st	(Palette_cycle_counters+$00).w
		jsr	(AllocateObject).l
		bne.s	locK_58A92
		move.l	#Obj_57C1E,(a1)
		move.w	#$A0,x_pos(a1)
		move.b	#$44,$2D(a1)
		moveq	#0,d1
		move.w	d1,(Camera_X_pos_copy).w
		move.w	d1,(Camera_X_pos).w
		move.w	#$649,d1
		move.w	d1,(Camera_Y_pos_copy).w
		move.w	d1,(Camera_Y_pos).w
		st	(Scroll_lock).w
		jsr	(CreateNewSprite4).l
		bne.s	locK_58A92
		move.l	#locK_59078,(a1)
		move.w	#1,$30(a1)

locK_58A92:
		jsr	(Reset_TileOffsetPositionActual).l
		moveq	#0,d1
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

SSZ2_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	(Events_routine_fg).w,d0
		jmp	SSZ2_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

SSZ2_ScreenEvent_Index:
		bra.w	locK_58ACC
; ---------------------------------------------------------------------------
		bra.w	locK_58AE0
; ---------------------------------------------------------------------------
		bra.w	locK_58B20
; ---------------------------------------------------------------------------
		bra.w	locK_58B7C
; ---------------------------------------------------------------------------
		bra.w	locK_58B9E
; ---------------------------------------------------------------------------
		bra.w	locK_58C42
; ---------------------------------------------------------------------------
		bra.w	locK_58C68
; ---------------------------------------------------------------------------

locK_58ACC:
		move.w	(Camera_min_Y_pos).w,d0
		cmp.w	(Camera_max_Y_pos).w,d0
		bne.w	locK_58C68
		addq.w	#4,(Special_V_int_routine).w
		addq.w	#4,(Events_routine_fg).w

locK_58AE0:
		tst.w	(Events_fg_4).w
		beq.w	locK_58C68
		clr.w	(Events_fg_4).w
		movea.w	$24(a3),a1
		movea.w	$28(a3),a5
		moveq	#4-1,d0

locK_58AF6:
		move.b	#$17,(a1)+
		move.b	#$18,(a1)+
		move.b	#$19,(a5)+
		move.b	#$19,(a5)+
		dbf	d0,locK_58AF6
		move.b	#$17,(a1)
		move.b	#$19,(a5)
		st	(Ending_running_flag).w
		addq.w	#4,(Events_routine_fg).w
		jmp	(Refresh_PlaneFullDirect).l
; ---------------------------------------------------------------------------

locK_58B20:
		tst.w	(Events_fg_4).w
		beq.w	locK_58C68
		bmi.w	locK_58C68
		clr.w	(Events_fg_4).w
		move	#$2700,sr
		lea	(VDP_data_port).l,a6
		move.l	#vdpComm(tiles_to_bytes($7F0),VRAM,WRITE),(VDP_control_port).l
		move.l	#$66666666,d0
		moveq	#bytesToLcnt(tiles_to_bytes($10)),d1

locK_58B4C:
		move.l	d0,(a6)
		dbf	d1,locK_58B4C
		move	#$2300,sr
		jsr	(AllocateObject).l
		bne.s	locK_58B64
		move.l	#locK_591D6,(a1)

locK_58B64:
		move.w	#$1F0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		clr.b	(Palette_cycle_counters+$00).w
		addq.w	#4,(Events_routine_fg).w
		bra.w	locretK_58C7E
; ---------------------------------------------------------------------------

locK_58B7C:
		move.w	#$200,d1
		move.w	#$100,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.w	locretK_58C7E
		clr.w	(Camera_Y_pos_copy).w
		clr.l	(Camera_Y_pos).w
		clr.w	(Camera_X_pos).w
		addq.w	#4,(Events_routine_fg).w

locK_58B9E:
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(subK_5B18E).l
		movem.l	(sp)+,d7-a0/a2-a3
		cmpi.b	#7,(Super_emerald_count).w
		bhs.s	locK_58BBC
		cmpi.b	#7,(Chaos_emerald_count).w
		blo.s	locK_58C1A

locK_58BBC:
		jsr	subK_592EE(pc)
		tst.w	(_unkFAAE).w
		beq.w	locretK_58C7E
		move.w	#$14C0,d0
		tst.w	(SK_alone_flag).w
		bne.s	locK_58BD6
		move.w	#$1660,d0

locK_58BD6:
		cmp.w	(Camera_Y_pos).w,d0
		bne.w	locretK_58C7E
		tst.w	(Events_routine_bg).w
		bne.w	locretK_58C7E
		clr.b	(_unkFAB9).w
		move.w	(Camera_Y_pos_BG_copy).w,d0
		addi.w	#$100,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		clr.w	(Camera_Y_pos_BG_copy+2).w
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Camera_Y_pos_BG_rounded).w
		lea	(Pal_Ending2).l,a1
		lea	(Normal_palette_line_2).w,a5
		moveq	#bytesToLcnt($60),d0

locK_58C0E:
		move.l	(a1)+,(a5)+
		dbf	d0,locK_58C0E
		addq.w	#4,(Events_routine_bg).w
		bra.s	locretK_58C7E
; ---------------------------------------------------------------------------

locK_58C1A:
		tst.w	(Events_fg_4).w
		beq.s	locretK_58C7E
		lea	(Pal_Ending1).l,a1
		lea	(Normal_palette_line_2).w,a5
		moveq	#bytesToLcnt($60),d0

locK_58C2C:
		move.l	(a1)+,(a5)+
		dbf	d0,locK_58C2C
		move.w	#$7F0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_fg).w

locK_58C42:
		moveq	#0,d1
		move.w	#$700,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	locretK_58C7E
		move.w	#$720,d0
		move.w	d0,(Camera_Y_pos_copy).w
		move.w	d0,(Camera_Y_pos).w
		clr.w	(Camera_Y_pos+2).w
		move.w	d0,(Camera_Y_pos_rounded).w
		addq.w	#4,(Events_routine_fg).w

locK_58C68:
		jsr	subK_5928C(pc)
		lea	(Camera_Y_pos_copy).w,a6
		lea	(Camera_Y_pos_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jmp	(Draw_TileRow).l
; ---------------------------------------------------------------------------

locretK_58C7E:
		rts
; ---------------------------------------------------------------------------
wordK_58C80:
		dc.w   $380
		dc.w    $10
		dc.w    $10
		dc.w    $18
		dc.w    $10
		dc.w      8
		dc.w    $10
		dc.w    $10
		dc.w      8
		dc.w    $38
		dc.w    $10
		dc.w    $10
		dc.w    $28
		dc.w      8
		dc.w    $20
		dc.w      8
		dc.w      8
		dc.w      8
		dc.w      8
		dc.w      8
		dc.w    $18
		dc.w    $20
		dc.w    $30
		dc.w      8
		dc.w      8
		dc.w    $10
		dc.w      8
		dc.w    $28
		dc.w    $10
		dc.w    $10
		dc.w    $18
		dc.w    $10
		dc.w      8
		dc.w    $10
		dc.w    $10
		dc.w      8
		dc.w  $7FFF
SSZ2_DeformArray:
		dc.w   $800
		dc.w    $24
		dc.w      4
		dc.w    $14
		dc.w      4
		dc.w    $1C
		dc.w      4
		dc.w    $20
		dc.w  $8080
		dc.w  $7FFF
SSZ2_BGDeformArray:
		dc.w   $120
		dc.w      8
		dc.w      8
		dc.w      4
		dc.w      4
		dc.w      8
		dc.w      8
		dc.w    $18
		dc.w    $10
		dc.w    $10
		dc.w  $7FFF
; ---------------------------------------------------------------------------

SSZ2_BackgroundInit:
		clr.l	(_unkEE9C).w
		jsr	subK_58D3E(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		moveq	#0,d1
		jsr	(Refresh_PlaneFull).l
		jmp	subK_58FBC(pc)
; ---------------------------------------------------------------------------

SSZ2_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	SSZ2_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

SSZ2_BackgroundEvent_Index:
		bra.w	locK_58D1E
; ---------------------------------------------------------------------------
		lea	(Level_layout_main).w,a3

locK_58D1E:
		jsr	subK_58D3E(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l
		jsr	subK_58FBC(pc)
		jmp	(ShakeScreen_Setup).l

; =============== S U B R O U T I N E =======================================


subK_58D3E:
		tst.w	(Events_routine_bg).w
		beq.s	locK_58D6E

locK_58D44:
		lea	(HScroll_table).w,a1
		move.l	(a1),d0
		addi.l	#$8000,(a1)+
		lea	$16(a1),a1
		move.w	#$5E,-(a1)
		clr.w	d0
		move.l	d0,d1
		asr.l	#3,d1
		moveq	#8-1,d2

locK_58D60:
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		dbf	d2,locK_58D60
		rts
; ---------------------------------------------------------------------------

locK_58D6E:
		cmpi.w	#$18,(Events_routine_fg).w
		bhs.w	locK_58F52
		cmpi.w	#$C,(Events_routine_fg).w
		bhs.w	locretK_58F50
		lea	(HScroll_table).w,a1
		move.l	(a1),d2
		addi.l	#$1000,(a1)+
		clr.w	(a1)+
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#5,d0
		move.l	d0,d1
		asr.l	#1,d0
		add.l	d2,d0
		swap	d0
		move.w	d0,(a1)
		move.w	d0,4(a1)
		move.w	d0,8(a1)
		move.w	d0,$10(a1)
		move.w	d0,$36(a1)
		move.w	d0,$3A(a1)
		move.w	d0,$3E(a1)
		move.w	d0,$46(a1)
		swap	d0
		add.l	d2,d1
		add.l	d1,d0
		swap	d0
		move.w	d0,6(a1)
		move.w	d0,$A(a1)
		move.w	d0,$E(a1)
		move.w	d0,$14(a1)
		move.w	d0,$3C(a1)
		move.w	d0,$40(a1)
		move.w	d0,$44(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,2(a1)
		move.w	d0,$C(a1)
		move.w	d0,$16(a1)
		move.w	d0,$34(a1)
		move.w	d0,$38(a1)
		move.w	d0,$42(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$12(a1)
		swap	d0
		lea	$18(a1),a1
		moveq	#9-1,d2

locK_58E14:
		swap	d0
		move.w	d0,(a1)+
		swap	d0
		add.l	d1,d0
		dbf	d2,locK_58E14
		cmpi.w	#4,(Events_routine_fg).w
		bhi.s	locK_58E3A
		lea	(HScroll_table+$02A).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		moveq	#9-1,d1

locK_58E32:
		move.w	d0,(a1)+
		dbf	d1,locK_58E32
		bra.s	locK_58E6E
; ---------------------------------------------------------------------------

locK_58E3A:
		lea	(HScroll_table+$004).w,a1
		move.w	$2A(a1),$2C(a1)
		move.w	$28(a1),d0
		move.w	d0,$2A(a1)
		move.w	d0,$2E(a1)
		move.w	$26(a1),$28(a1)
		move.w	$24(a1),$26(a1)
		move.w	$22(a1),$30(a1)
		move.w	$1E(a1),$32(a1)
		move.w	$1A(a1),$34(a1)

locK_58E6E:
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$320,d0
		sub.w	(_unkEE9C).w,d0
		move.w	(Special_V_int_routine).w,d1
		subq.w	#4,d1
		beq.s	locK_58E88
		subq.w	#4,d1
		beq.s	locK_58E88
		addq.w	#8,d0

locK_58E88:
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	#$5E,(Camera_X_pos_BG_copy).w
		lea	(HScroll_table+$0D0).w,a5
		lea	(a5),a6
		move.w	(Events_bg+$00).w,d0
		smi	d6
		bpl.s	locK_58EA2
		neg.w	d0

locK_58EA2:
		swap	d0
		clr.w	d0
		asr.l	#7,d0
		move.w	d0,d1
		swap	d0
		moveq	#0,d2
		moveq	#0,d3
		moveq	#$40-1,d4
		tst.b	d6
		bne.s	locK_58EC8

locK_58EB6:
		add.w	d1,d3
		addx.w	d0,d2
		move.w	d2,-(a5)
		move.w	d2,d5
		neg.w	d5
		move.w	d5,(a6)+
		dbf	d4,locK_58EB6
		bra.s	locK_58ED8
; ---------------------------------------------------------------------------

locK_58EC8:
		add.w	d1,d3
		addx.w	d0,d2
		move.w	d2,(a6)+
		move.w	d2,d5
		neg.w	d5
		move.w	d5,-(a5)
		dbf	d4,locK_58EC8

locK_58ED8:
		lea	(HScroll_table+$160).w,a5
		lea	(a5),a6
		move.w	(Events_bg+$00).w,d0
		smi	d6
		bpl.s	locK_58EE8
		neg.w	d0

locK_58EE8:
		swap	d0
		clr.w	d0
		asr.l	#3,d0
		move.w	d0,d1
		swap	d0
		moveq	#0,d2
		moveq	#0,d3
		moveq	#8-1,d4
		tst.b	d6
		bne.s	locK_58F0E

locK_58EFC:
		add.w	d1,d3
		addx.w	d0,d2
		move.w	d2,-(a5)
		move.w	d2,d5
		neg.w	d5
		move.w	d5,(a6)+
		dbf	d4,locK_58EFC
		bra.s	locK_58F1E
; ---------------------------------------------------------------------------

locK_58F0E:
		add.w	d1,d3
		addx.w	d0,d2
		move.w	d2,(a6)+
		move.w	d2,d5
		neg.w	d5
		move.w	d5,-(a5)
		dbf	d4,locK_58F0E

locK_58F1E:
		lea	(HScroll_table+$170).w,a1
		lea	(HScroll_table+$140).w,a5
		move.w	(Camera_X_pos_BG_copy).w,d0
		move.w	d0,d1
		andi.w	#$F,d1
		beq.s	locK_58F36
		addi.w	#$10,d0

locK_58F36:
		lsr.w	#3,d0
		andi.w	#$FFFE,d0
		adda.w	d0,a5
		move.w	(Camera_Y_pos_BG_copy).w,d0
		addq.w	#8,d0
		moveq	#$14-1,d1

locK_58F46:
		move.w	(a5)+,d2
		add.w	d0,d2
		move.w	d2,(a1)+
		dbf	d1,locK_58F46

locretK_58F50:
		rts
; ---------------------------------------------------------------------------

locK_58F52:
		lea	(HScroll_table).w,a1
		move.l	(a1),d0
		subi.l	#$10000,(a1)+
		lea	$110(a1),a1
		clr.w	d0
		move.l	d0,d1
		asr.l	#5,d1
		moveq	#$20-1,d2

locK_58F6A:
		swap	d0
		move.w	d0,-(a1)
		move.w	d0,-(a1)
		move.w	d0,-(a1)
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		dbf	d2,locK_58F6A
		move.w	(a1),d0
		neg.w	d0
		move.w	d0,-4(a1)
		move.w	d0,-$C(a1)
		move.w	8(a1),d0
		neg.w	d0
		move.w	d0,-8(a1)
		move.w	$10(a1),d0
		neg.w	d0
		move.w	d0,-2(a1)
		move.w	$18(a1),d0
		neg.w	d0
		move.w	d0,-$E(a1)
		move.w	$20(a1),d0
		neg.w	d0
		move.w	d0,-$A(a1)
		move.w	$28(a1),d0
		neg.w	d0
		move.w	d0,-6(a1)
		rts
; End of function subK_58D3E


; =============== S U B R O U T I N E =======================================


subK_58FBC:
		tst.w	(Events_routine_bg).w
		beq.s	locK_58FD0
		lea	SSZ2_BGDeformArray(pc),a4
		lea	(HScroll_table+$004).w,a5
		jmp	(ApplyDeformation).l
; ---------------------------------------------------------------------------

locK_58FD0:
		cmpi.w	#$18,(Events_routine_fg).w
		bhs.w	locK_5906A
		cmpi.w	#$C,(Events_routine_fg).w
		bhs.w	locK_59064
		lea	wordK_58C80(pc),a4
		lea	(HScroll_table+$004).w,a5
		jsr	(ApplyFGDeformation).l
		lea	(H_scroll_buffer+2).w,a1
		lea	(HScroll_table+$050).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d0
		subi.w	#$100,d0
		bmi.s	locK_59018
		subi.w	#$80,d0
		bpl.s	locK_5904A
		move.w	d0,d1
		neg.w	d0
		addi.w	#$80,d1
		add.w	d1,d1
		adda.w	d1,a5
		bra.s	locK_59036
; ---------------------------------------------------------------------------

locK_59018:
		neg.w	d0
		cmpi.w	#$E0,d0
		bhs.s	locK_5904A
		move.w	d0,d1
		addi.w	#-$E0,d0
		neg.w	d0
		cmpi.w	#$80,d0
		blo.s	locK_59032
		move.w	#$80,d0

locK_59032:
		lsl.w	#2,d1
		adda.w	d1,a1

locK_59036:
		subq.w	#1,d0
		move.w	(Camera_X_pos_BG_copy).w,d1
		neg.w	d1

locK_5903E:
		move.w	(a5)+,d2
		add.w	d1,d2
		move.w	d2,(a1)
		addq.w	#4,a1
		dbf	d0,locK_5903E

locK_5904A:
		lea	(Vscroll_buffer).w,a1
		lea	(HScroll_table+$170).w,a5
		move.w	(Camera_Y_pos_copy).w,d0
		swap	d0
		moveq	#$14-1,d1

locK_5905A:
		move.w	(a5)+,d0
		move.l	d0,(a1)+
		dbf	d1,locK_5905A
		rts
; ---------------------------------------------------------------------------

locK_59064:
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

locK_5906A:
		lea	SSZ2_DeformArray(pc),a4
		lea	(HScroll_table+$004).w,a5
		jmp	(ApplyFGDeformation).l
; End of function subK_58FBC

; ---------------------------------------------------------------------------

locK_59078:
		moveq	#0,d0
		move.b	routine(a0),d0
		jmp	locK_59082(pc,d0.w)
; ---------------------------------------------------------------------------

locK_59082:
		bra.w	locK_5908E
; ---------------------------------------------------------------------------
		bra.w	locK_590E4
; ---------------------------------------------------------------------------
		bra.w	locK_59194
; ---------------------------------------------------------------------------

locK_5908E:
		tst.w	(Special_V_int_routine).w
		beq.w	locretK_591D4
		addi.l	#$11B,(_unkEE9C).w
		move.l	#$2000,d0
		move.l	#$4A,d1
		jsr	(Gradual_SwingOffset).l
		cmp.w	(Events_bg+$00).w,d0
		beq.w	locretK_591D4
		move.w	d0,(Events_bg+$00).w
		bne.w	locretK_591D4
		tst.w	(Events_fg_4).w
		bpl.w	locretK_591D4
		tst.b	$38(a0)
		bne.s	locK_590D6
		st	$38(a0)
		bra.w	locretK_591D4
; ---------------------------------------------------------------------------

locK_590D6:
		clr.w	(Events_fg_4).w
		move.w	#$C,(Special_V_int_routine).w
		addq.b	#4,routine(a0)

locK_590E4:
		cmpi.b	#7,(Super_emerald_count).w
		bhs.s	locK_590F4
		cmpi.b	#7,(Chaos_emerald_count).w
		blo.s	locK_59146

locK_590F4:
		cmpi.w	#$8000,$3C(a0)
		bhs.s	locK_59102
		addi.w	#$20,$3C(a0)

locK_59102:
		move.l	$3A(a0),d0
		sub.l	d0,(_unkEE9C).w
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$318,d0
		sub.w	(_unkEE9C).w,d0
		cmpi.w	#$D0,d0
		beq.s	locK_59124
		bcs.s	locK_59132
		subq.w	#1,(Camera_Y_pos).w
		bra.s	locK_59132
; ---------------------------------------------------------------------------

locK_59124:
		tst.b	$39(a0)
		bne.s	locK_59132
		st	$39(a0)
		st	(_unkFAA9).w

locK_59132:
		cmpi.w	#$2A0,(Camera_Y_pos).w
		bne.w	locretK_591D4
		st	(Events_fg_4+1).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locK_59146:
		cmpi.w	#$8000,$3C(a0)
		bhs.s	locK_59154
		addi.w	#$20,$3C(a0)

locK_59154:
		move.l	$3A(a0),d0
		add.l	d0,(_unkEE9C).w
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$318,d0
		sub.w	(_unkEE9C).w,d0
		cmpi.w	#$D0,d0
		beq.s	locK_59176
		bcc.s	locK_59184
		addq.w	#1,(Camera_Y_pos).w
		bra.s	locK_59184
; ---------------------------------------------------------------------------

locK_59176:
		tst.b	$39(a0)
		bne.s	locK_59184
		st	$39(a0)
		st	(_unkFAA9).w

locK_59184:
		cmpi.w	#$600,(Camera_Y_pos).w
		bne.s	locretK_591D4
		st	(Events_fg_4+1).w
		addq.b	#4,routine(a0)

locK_59194:
		cmpi.w	#$18,(Events_routine_fg).w
		blo.s	locretK_591D4
		move.l	$3A(a0),d0
		add.l	d0,(Camera_Y_pos).w
		move.w	(Camera_Y_pos).w,d0
		cmpi.w	#$7D0,d0
		blo.s	locretK_591D4
		subi.l	#$98,$3A(a0)
		bpl.s	locretK_591D4
		cmpi.w	#$804,(Camera_Y_pos).w
		bne.s	locretK_591D4
		jsr	(AllocateObject).l
		bne.s	locK_591CE
		move.l	#Obj_5EF68,(a1)

locK_591CE:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locretK_591D4:
		rts
; ---------------------------------------------------------------------------

locK_591D6:
		move.l	#locK_59208,(a0)
		move.b	#$40,render_flags(a0)
		move.b	#$40,height_pixels(a0)
		move.w	#$380,priority(a0)
		move.l	#Map_KnuxEndingIslandMask,mappings(a0)
		move.w	#$122,x_pos(a0)
		move.w	#$F0,y_pos(a0)
		move.w	#8,mainspr_childsprites(a0)

locK_59208:
		tst.w	(Events_routine_bg).w
		beq.s	locK_59232
		cmpi.w	#$80,(Camera_Y_pos_BG_copy).w
		bne.s	locK_59218
		bra.s	locK_59220
; ---------------------------------------------------------------------------

locK_59218:
		subi.l	#$6000,(Camera_Y_pos_BG_copy).w

locK_59220:
		move.w	(Camera_Y_pos_BG_copy).w,d0
		subi.w	#$1D0,d0
		neg.w	d0
		addi.w	#$F0,d0
		move.w	d0,y_pos(a0)

locK_59232:
		lea	sub2_x_pos(a0),a1
		move.w	y_pos(a0),d0
		subi.w	#$40,d0
		moveq	#1,d2

locK_59240:
		move.w	#$A2,d1
		moveq	#4-1,d3

locK_59246:
		move.w	d1,(a1)+
		move.w	d0,(a1)+
		addq.w	#2,a1
		addi.w	#$40,d1
		dbf	d3,locK_59246
		addi.w	#$40,d0
		dbf	d2,locK_59240
		cmpi.w	#$18,(Events_routine_fg).w
		bne.s	locK_5926A
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locK_5926A:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Map_KnuxEndingIslandMask:
		include "General/Ending/Map - Knuckles Ending Island Mask.asm"

; =============== S U B R O U T I N E =======================================


subK_5928C:
		tst.b	(Palette_cycle_counters+$00).w
		bne.s	locretK_592BC
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	locretK_592BC
		move.w	#7,(Palette_cycle_counter1).w
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#6,d0
		cmpi.w	#$30,d0
		blo.s	locK_592AC
		moveq	#0,d0

locK_592AC:
		move.w	d0,(Palette_cycle_counter0).w
		move.l	Pal_EndingWater(pc,d0.w),(Normal_palette_line_4+$1A).w
		move.w	Pal_EndingWater+$4(pc,d0.w),(Normal_palette_line_4+$1E).w

locretK_592BC:
		rts
; End of function subK_5928C

; ---------------------------------------------------------------------------
Pal_EndingWater:
		binclude "General/Ending/Palettes/Water Cycle.bin"
		even

; =============== S U B R O U T I N E =======================================


subK_592EE:
		tst.b	(Palette_cycle_counters+$00).w
		bne.s	locretK_59318
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	locretK_59318
		move.w	#3,(Palette_cycle_counter1).w
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#4,d0
		cmpi.w	#$38,d0
		blo.s	locK_5930E
		moveq	#0,d0

locK_5930E:
		move.w	d0,(Palette_cycle_counter0).w
		move.l	wordK_5931A(pc,d0.w),(Normal_palette_line_4+$16).w

locretK_59318:
		rts
; End of function subK_592EE

; ---------------------------------------------------------------------------

wordK_5931A:
		dc.w   $C40,  $400
		dc.w   $E68,  $600
		dc.w   $E80,  $800
		dc.w   $E80,  $800
		dc.w   $EE0,  $A00
		dc.w   $EE0,  $A00
		dc.w   $EE0,  $C00
		dc.w   $C40,  $C00
		dc.w   $E68,  $C00
		dc.w   $E80,  $400
		dc.w   $E80,  $600
		dc.w   $EE0,  $A00
		dc.w   $EA4,  $800
		dc.w   $EA4,  $400