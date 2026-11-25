; ---------------------------------------------------------------------------

Ending_ScreenInit:
		jsr	(AllocateObject).l
		bne.s	locK_5AAB0
		move.l	#Obj_5D86A,(a1)

locK_5AAB0:
		st	(Ending_running_flag).w
		st	(Scroll_lock).w
		move.b	#3,(Player_1+object_control).w
		move.l	#$2000000,d0
		move.l	d0,(Camera_X_pos).w
		move.l	d0,(Camera_X_pos_copy).w
		move.l	d0,(Camera_Y_pos).w
		move.l	d0,(Camera_Y_pos_copy).w
		clr.l	(_unkEE98).w
		clr.l	(_unkEE9C).w
		move.w	#$2B4,(Events_bg+$02).w
		jsr	subK_5B11C(pc)
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

Ending_ScreenEvent:
		move.w	(Events_routine_fg).w,d0
		jmp	Ending_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

Ending_ScreenEvent_Index:
		bra.w	locK_5AB36
; ---------------------------------------------------------------------------
		bra.w	locK_5AB58
; ---------------------------------------------------------------------------
		bra.w	locK_5AB6E
; ---------------------------------------------------------------------------
		bra.w	locK_5ABBC
; ---------------------------------------------------------------------------
		bra.w	locK_5AC70
; ---------------------------------------------------------------------------
		bra.w	locK_5ACFC
; ---------------------------------------------------------------------------
		bra.w	locK_5AD16
; ---------------------------------------------------------------------------
		bra.w	locK_5AD30
; ---------------------------------------------------------------------------
		bra.w	locK_5AD56
; ---------------------------------------------------------------------------
		bra.w	locK_5AD8E
; ---------------------------------------------------------------------------
		bra.w	locK_5AE0A
; ---------------------------------------------------------------------------
		bra.w	locK_5AE76
; ---------------------------------------------------------------------------
		bra.w	locK_5AE90
; ---------------------------------------------------------------------------
		bra.w	locK_5AEA8
; ---------------------------------------------------------------------------
		bra.w	locK_5AED4
; ---------------------------------------------------------------------------

locK_5AB36:
		tst.w	(Events_fg_4).w
		beq.w	locK_5AEE4
		clr.w	(Events_fg_4).w
		move.w	(_unkEE98).w,(Events_bg+$00).w
		jsr	subK_5AEEA(pc)
		jsr	(Reset_TileOffsetPositionActual).l
		addq.w	#4,(Events_routine_fg).w
		bra.s	locK_5AB62
; ---------------------------------------------------------------------------

locK_5AB58:
		tst.w	(Events_fg_4).w
		bne.s	locK_5AB66
		jsr	subK_5AEEA(pc)

locK_5AB62:
		bra.w	locK_5AEE4
; ---------------------------------------------------------------------------

locK_5AB66:
		clr.w	(Events_fg_4).w
		addq.w	#4,(Events_routine_fg).w

locK_5AB6E:
		jsr	subK_5AEEA(pc)
		cmpi.b	#7,(Chaos_emerald_count).w
		blo.s	locK_5AB96
		moveq	#0,d0
		move.w	(Events_bg+$06).w,d0
		addi.w	#$10,d0
		cmpi.w	#$8000,d0
		blo.s	locK_5AB8E
		move.w	#$8000,d0

locK_5AB8E:
		move.w	d0,(Events_bg+$06).w
		sub.l	d0,(Events_bg+$02).w

locK_5AB96:
		tst.w	(Events_fg_4).w
		beq.w	locK_5AEE4
		clr.w	(Events_fg_4).w
		move.w	#$40-1,(Palette_fade_info).w
		move.w	#$15,(Events_bg+$08).w
		st	(Palette_fade_timer).w
		st	(Palette_cycle_counters+$00).w
		addq.w	#4,(Events_routine_fg).w
		bra.s	locK_5ABC0
; ---------------------------------------------------------------------------

locK_5ABBC:
		jsr	subK_5AEEA(pc)

locK_5ABC0:
		move.l	a0,-(sp)
		jsr	(Pal_ToBlack).l
		movea.l	(sp)+,a0
		subq.w	#1,(Events_bg+$08).w
		bpl.w	locK_5AEE4
		clearRAM	Sprite_table_input,(Sprite_table_input_end-Sprite_table_input)
		clearRAM	Player_2,(Kos_decomp_buffer-Player_2)-2
		cmpi.b	#7,(Super_emerald_count).w
		bhs.s	locK_5AC04
		move.w	#$24,(Events_routine_fg).w
		bra.w	locK_5ADC0
; ---------------------------------------------------------------------------

locK_5AC04:
		jsr	(AllocateObject).l
		bne.s	locK_5AC12
		move.l	#Obj_5DFEE,(a1)

locK_5AC12:
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(AIZ1_128x128_Kos).l,a1
		lea	(RAM_start).l,a2
		jsr	(Queue_Kos).l
		lea	(AIZ1_16x16_Primary_Kos).l,a1
		lea	(Block_table).w,a2
		jsr	(Queue_Kos).l
		lea	(AIZ1_16x16_MainLevel_Kos).l,a1
		lea	(Block_table+$268).w,a2
		jsr	(Queue_Kos).l
		lea	(AIZ1_8x8_Primary_KosM).l,a1
		move.w	#tiles_to_bytes($000),d2
		jsr	(Queue_Kos_Module).l
		lea	(AIZ1_8x8_MainLevel_KosM).l,a1
		move.w	#tiles_to_bytes($0BE),d2
		jsr	(Queue_Kos_Module).l
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(Events_routine_fg).w

locK_5AC70:
		tst.b	(Kos_modules_left).w
		bne.w	locK_5AEE4
		movem.l	d7-a0/a2-a3,-(sp)
		clr.w	(Current_zone_and_act).w
		move.b	#1,(Last_star_post_hit).w
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		move.w	#$D01,(Current_zone_and_act).w
		clr.b	(Last_star_post_hit).w
		moveq	#PalID_SonicTails,d0
		jsr	(LoadPalette).l
		moveq	#PalID_AIZ,d0
		jsr	(LoadPalette).l
		lea	(Pal_SSZ2+$20).l,a1
		lea	(Target_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

locK_5ACB8:
		move.l	(a1)+,(a2)+
		dbf	d6,locK_5ACB8
		jsr	(Adjust_AIZ1Chunks2).l
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$1EB8,d0
		move.w	d0,(Camera_X_pos).w
		move.w	d0,(Camera_X_pos_copy).w
		move.w	#$1E0,d0
		move.w	d0,(Camera_Y_pos).w
		move.w	d0,(Camera_Y_pos_copy).w
		jsr	(Reset_TileOffsetPositionActual).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_fg).w

locK_5ACFC:
		move.w	(Camera_X_pos_copy).w,d1
		move.w	(Camera_Y_pos_copy).w,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.w	locK_5AEE4
		addq.w	#4,(Events_routine_bg).w
		addq.w	#4,(Events_routine_fg).w

locK_5AD16:
		cmpi.w	#$10,(Events_routine_bg).w
		blo.w	locK_5AEE4
		move.w	#$40-1,(Palette_fade_info).w
		move.w	#$15,(Events_bg+$08).w
		addq.w	#4,(Events_routine_fg).w

locK_5AD30:
		move.l	a0,-(sp)
		jsr	(Pal_FromBlack).l
		movea.l	(sp)+,a0
		subq.w	#1,(Events_bg+$08).w
		bpl.w	locK_5AEE4
		clr.w	(Palette_fade_timer).w
		clr.b	(Palette_cycle_counters+$00).w
		clr.w	(Palette_cycle_counter1).w
		clr.w	(Palette_cycle_counter0).w
		addq.w	#4,(Events_routine_fg).w

locK_5AD56:
		tst.w	(Events_fg_4).w
		bne.s	locK_5AD72
		addi.l	#$1000,(Events_bg+$0A).w
		move.l	a0,-(sp)
		jsr	(AnPal_AIZ1).l
		movea.l	(sp)+,a0
		bra.w	locK_5AEE4
; ---------------------------------------------------------------------------

locK_5AD72:
		clr.w	(Events_fg_4).w
		move.w	#$40-1,(Palette_fade_info).w
		move.w	#$15,(Events_bg+$08).w
		st	(Palette_fade_timer).w
		st	(Palette_cycle_counters+$00).w
		addq.w	#4,(Events_routine_fg).w

locK_5AD8E:
		move.l	a0,-(sp)
		jsr	(Pal_ToBlack).l
		movea.l	(sp)+,a0
		subq.w	#1,(Events_bg+$08).w
		bpl.w	locK_5AEE4
		clearRAM	Sprite_table_input,(Sprite_table_input_end-Sprite_table_input)
		clearRAM	Player_2,(Kos_decomp_buffer-Player_2)-2

locK_5ADC0:
		jsr	(AllocateObject).l
		bne.s	locK_5ADCE
		move.l	#Obj_Ending,(a1)

locK_5ADCE:
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(SSZ2_128x128_Kos).l,a1
		lea	(RAM_start).l,a2
		jsr	(Queue_Kos).l
		lea	(SSZ2_16x16_Kos).l,a1
		lea	(Block_table).w,a2
		jsr	(Queue_Kos).l
		lea	(ArtKosM_SSZ2).l,a1
		moveq	#tiles_to_bytes($000),d2
		jsr	(Queue_Kos_Module).l
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(Events_routine_fg).w

locK_5AE0A:
		tst.b	(Kos_modules_left).w
		bne.w	locK_5AEE4
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		moveq	#PalID_SonicTails,d0
		jsr	(LoadPalette).l
		lea	(Pal_Ending1).l,a1
		lea	(Target_palette_line_2).w,a5
		moveq	#bytesToLcnt($60),d0

locK_5AE36:
		move.l	(a1)+,(a5)+
		dbf	d0,locK_5AE36
		jsr	subK_5B11C(pc)
		movem.l	(sp)+,d7-a0/a2-a3
		move.l	#$2000000,d0
		move.l	d0,(Camera_X_pos).w
		move.l	d0,(Camera_X_pos_copy).w
		move.l	d0,(Camera_Y_pos).w
		move.l	d0,(Camera_Y_pos_copy).w
		jsr	(Reset_TileOffsetPositionActual).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_fg).w

locK_5AE76:
		move.w	(Camera_X_pos_copy).w,d1
		move.w	(Camera_Y_pos_copy).w,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	locK_5AEE4
		move.w	#$14,(Events_routine_bg).w
		addq.w	#4,(Events_routine_fg).w

locK_5AE90:
		cmpi.w	#4,(Events_routine_bg).w
		bhi.s	locK_5AEE4
		move.w	#$40-1,(Palette_fade_info).w
		move.w	#$15,(Events_bg+$08).w
		addq.w	#4,(Events_routine_fg).w

locK_5AEA8:
		move.l	a0,-(sp)
		jsr	(Pal_FromBlack).l
		movea.l	(sp)+,a0
		subq.w	#1,(Events_bg+$08).w
		bpl.s	locK_5AEE4
		clr.w	(Palette_fade_timer).w
		clr.b	(Palette_cycle_counters+$00).w
		clr.w	(Palette_cycle_counter1).w
		clr.w	(Palette_cycle_counter0).w
		clr.l	(Camera_Y_pos).w
		clr.l	(Camera_Y_pos_copy).w
		addq.w	#4,(Events_routine_fg).w

locK_5AED4:
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(subK_5B18E).l
		movem.l	(sp)+,d7-a0/a2-a3
		rts
; ---------------------------------------------------------------------------

locK_5AEE4:
		jmp	(DrawTilesAsYouMove).l

; =============== S U B R O U T I N E =======================================


subK_5AEEA:
		move.w	(_unkEE98).w,d0
		sub.w	(Events_bg+$00).w,d0
		addi.w	#$140,d0
		move.w	d0,(Camera_X_pos_copy).w
		move.w	(_unkEE9C).w,d0
		sub.w	(Events_bg+$02).w,d0
		move.w	d0,(Camera_Y_pos_copy).w
		rts
; End of function subK_5AEEA

; ---------------------------------------------------------------------------

Ending_BackgroundInit:
		jsr	subK_5B092(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		move.w	#$200,d1
		jsr	(Refresh_PlaneFull).l
		lea	Ending_BGDeformArray1(pc),a4
		lea	(HScroll_table+$004).w,a5
		jmp	(ApplyDeformation).l
; ---------------------------------------------------------------------------

Ending_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	Ending_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

Ending_BackgroundEvent_Index:
		bra.w	locK_5AF4E
; ---------------------------------------------------------------------------
		bra.w	locK_5AF84
; ---------------------------------------------------------------------------
		bra.w	locK_5AFC4
; ---------------------------------------------------------------------------
		bra.w	locK_5AFF0
; ---------------------------------------------------------------------------
		bra.w	locK_5B012
; ---------------------------------------------------------------------------
		bra.w	locK_5B03A
; ---------------------------------------------------------------------------
		bra.w	locK_5B072
; ---------------------------------------------------------------------------

locK_5AF4E:
		tst.w	(Events_fg_5).w
		bne.s	locK_5AF5A
		jsr	subK_5B092(pc)
		bra.s	locK_5AF88
; ---------------------------------------------------------------------------

locK_5AF5A:
		clr.w	(Events_fg_5).w
		lea	(Pal_Ending1).l,a1
		lea	(Normal_palette_line_2).w,a5
		moveq	#bytesToLcnt($60),d0

locK_5AF6A:
		move.l	(a1)+,(a5)+
		dbf	d0,locK_5AF6A
		jsr	subK_5B116(pc)
		move.w	#$220,d0
		move.w	d0,(_unkEE9C).w
		move.w	d0,(Camera_Y_pos_BG_rounded).w
		addq.w	#4,(Events_routine_bg).w

locK_5AF84:
		jsr	subK_5B0A8(pc)

locK_5AF88:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	#$200,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l
		lea	Ending_BGDeformArray1(pc),a4
		tst.w	(Events_routine_bg).w
		beq.s	locK_5AFAA
		lea	Ending_BGDeformArray2(pc),a4

locK_5AFAA:
		lea	(HScroll_table+$004).w,a5
		jsr	(ApplyDeformation).l
		lea	subK_592EE(pc),a1
		tst.w	(Events_routine_bg).w
		beq.s	locK_5AFC2
		lea	subK_5928C(pc),a1

locK_5AFC2:
		jmp	(a1)
; ---------------------------------------------------------------------------

locK_5AFC4:
		jsr	(AIZ1_Deform).l
		jsr	(Reset_TileOffsetPositionEff).l
		clr.l	(HScroll_table).w
		move.w	d2,(HScroll_table+$006).w
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_5AFF6
; ---------------------------------------------------------------------------

locK_5AFF0:
		jsr	(AIZ1_Deform).l

locK_5AFF6:
		lea	(AIZ1_BGDrawArray).l,a4
		lea	(HScroll_table-$04).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d1
		jsr	(Draw_PlaneVertBottomUpComplex).l
		bpl.s	locK_5B020
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_5B020
; ---------------------------------------------------------------------------

locK_5B012:
		jsr	(AIZ1_Deform).l
		move.w	(Events_bg+$0A).w,d0
		sub.w	d0,(Camera_Y_pos_BG_copy).w

locK_5B020:
		lea	(AIZ1_BGDrawArray).l,a4
		lea	(HScroll_table).w,a5
		moveq	#$20,d6
		moveq	#2,d5
		jsr	(Draw_BG).l
		jmp	(AIZ1_ApplyDeformWater).l
; ---------------------------------------------------------------------------

locK_5B03A:
		movea.w	$1C(a3),a1
		addq.w	#4,a1
		move.b	#$1A,(a1)+
		move.b	#$1B,(a1)+
		move.b	#$1A,(a1)+
		move.b	#$1B,(a1)+
		jsr	subK_5B0A8(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_5B076
; ---------------------------------------------------------------------------

locK_5B072:
		jsr	subK_5B0A8(pc)

locK_5B076:
		move.w	#$200,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.w	locK_5AF88
		move.w	#4,(Events_routine_bg).w
		bpl.w	locK_5AF88

; =============== S U B R O U T I N E =======================================


subK_5B092:
		move.w	(_unkEE9C).w,d0
		cmpi.w	#$120,d0
		bls.s	locK_5B0A0
		move.w	#$120,d0

locK_5B0A0:
		move.w	d0,(Camera_Y_pos_BG_copy).w
		jmp	locK_58D44(pc)
; End of function subK_5B092


; =============== S U B R O U T I N E =======================================


subK_5B0A8:
		move.w	(_unkEE9C).w,(Camera_Y_pos_BG_copy).w
		move.w	(_unkEE98).w,d0
		swap	d0
		clr.w	d0
		move.l	d0,d1
		asr.l	#4,d1
		lea	(HScroll_table).w,a1
		add.l	(a1),d1
		addi.l	#$800,(a1)+
		lea	$10(a1),a1
		moveq	#$20-1,d2

locK_5B0CC:
		swap	d0
		move.w	d0,(a1)+
		move.w	d0,(a1)+
		move.w	d0,(a1)+
		move.w	d0,(a1)+
		swap	d0
		add.l	d1,d0
		dbf	d2,locK_5B0CC
		lea	(HScroll_table+$014).w,a1
		move.w	(a1),d0
		move.w	d0,-4(a1)
		move.w	d0,-$C(a1)
		move.w	8(a1),d0
		move.w	d0,-8(a1)
		move.w	$10(a1),d0
		move.w	d0,-2(a1)
		move.w	$18(a1),d0
		move.w	d0,-$E(a1)
		move.w	$20(a1),d0
		move.w	d0,-$A(a1)
		move.w	$28(a1),d0
		move.w	d0,-6(a1)
		rts
; End of function subK_5B0A8


; =============== S U B R O U T I N E =======================================


subK_5B116:
		lea	(Normal_palette_line_2).w,a6
		bra.s	locK_5B120
; End of function subK_5B116


; =============== S U B R O U T I N E =======================================


subK_5B11C:
		lea	(Target_palette_line_2).w,a6

locK_5B120:
		lea	(Target_palette_line_2).w,a5
		lea	Pal_5B16E(pc),a1
		moveq	#bytesToLcnt($20),d0

locK_5B12A:
		move.l	(a1),(a5)+
		move.l	(a1)+,(a6)+
		dbf	d0,locK_5B12A
		lea	(Pal_SSZ2+$20).l,a1
		moveq	#bytesToLcnt($20),d0

locK_5B13A:
		move.l	(a1),(a5)+
		move.l	(a1)+,(a6)+
		dbf	d0,locK_5B13A
		rts
; End of function subK_5B11C

; ---------------------------------------------------------------------------
Ending_BGDeformArray1:
		dc.w    $A0
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
Ending_BGDeformArray2:
		dc.w   $300
		dc.w    $24
		dc.w      4
		dc.w    $14
		dc.w      4
		dc.w    $1C
		dc.w      4
		dc.w    $20
		dc.w  $8080
		dc.w  $7FFF
Pal_5B16E:
		binclude "General/Ending/Palettes/Sky.bin"
		even

; =============== S U B R O U T I N E =======================================


subK_5B18E:
		move.w	(_unkFA86).w,d0
		move.w	off_5B19A(pc,d0.w),d0
		jmp	off_5B19A(pc,d0.w)
; End of function subK_5B18E

; ---------------------------------------------------------------------------
off_5B19A:
		dc.w locK_5B1A2-off_5B19A
		dc.w locK_5B1F4-off_5B19A
		dc.w locK_5B204-off_5B19A
		dc.w locretK_5B2D4-off_5B19A
; ---------------------------------------------------------------------------

locK_5B1A2:
		addq.w	#2,(_unkFA86).w
		clr.b	(_unkFACC).w
		clr.l	(Camera_Y_pos).w
		clr.l	(V_scroll_value).w
		clr.w	(_unkFAAE).w
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_5B1D2
		jsr	(AllocateObject).l
		bne.s	locK_5B1D2
		move.l	#Obj_Song_Fade_Transition,(a1)
		move.b	#mus_CreditsK,subtype(a1)

locK_5B1D2:
		bsr.w	subK_5B514
		move.w	#$EEE,(Normal_palette+$2).w
		move.w	#$EE,(Normal_palette_line_2+$2).w
		lea	PLC_SKCredits(pc),a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------
PLC_SKCredits: plrlistheader
		plreq ArtTile_Ending_CreditsText, ArtNem_CreditsText
PLC_SKCredits_End
; ---------------------------------------------------------------------------

locK_5B1F4:
		subq.w	#1,(_unkF660).w
		bpl.s	locretK_5B202
		addq.w	#2,(_unkFA86).w
		bsr.w	subK_5B42A

locretK_5B202:
		rts
; ---------------------------------------------------------------------------

locK_5B204:
		move.l	(Camera_Y_pos).w,d0
		move.l	d0,d1
		add.l	(_unkFAC8).w,d0
		move.l	d0,(Camera_Y_pos).w
		swap	d0
		swap	d1
		eor.w	d0,d1
		btst	#4,d1
		beq.s	locretK_5B282
		lsl.w	#4,d0
		addi.w	#$E00,d0
		move.w	d0,d1
		andi.w	#$F00,d1
		bsr.w	subK_5B2D6
		moveq	#0,d2
		tst.w	(SK_alone_flag).w
		beq.s	locK_5B238
		moveq	#8,d2

locK_5B238:
		add.w	(_unkFAAE).w,d2
		movea.l	off_5B284(pc,d2.w),a1
		move.w	(_unkFA84).w,d2
		move.w	(a1,d2.w),d2
		lea	(a1,d2.w),a1
		move.w	(a1)+,d2
		cmpi.w	#-8,d2
		beq.s	locK_5B294
		cmpi.w	#-$C,d2
		beq.s	locK_5B29E
		move.w	d2,d3
		andi.w	#$FF00,d0
		andi.w	#$FF00,d3
		cmp.w	d0,d3
		bne.s	locretK_5B282
		move.w	#make_art_tile(ArtTile_Ending_CreditsText,0,1),d6
		bclr	#0,d2
		beq.s	locK_5B276
		move.w	#make_art_tile(ArtTile_Ending_CreditsText,1,1),d6

locK_5B276:
		andi.w	#$FFE,d2
		bsr.w	subK_5B318
		addq.w	#2,(_unkFA84).w

locretK_5B282:
		rts
; ---------------------------------------------------------------------------
off_5B284:
		dc.l CreditsText_Part1
		dc.l CreditsText_Part2
		dc.l CreditsText_Part1_SK
		dc.l CreditsText_Part2_SK
; ---------------------------------------------------------------------------

locK_5B294:
		addq.w	#4,(_unkFAAE).w
		clr.w	(_unkFA84).w
		rts
; ---------------------------------------------------------------------------

locK_5B29E:
		addq.w	#2,(_unkFA86).w
		clr.l	(Timer).w
		st	(Events_fg_4).w
		st	(_unkFACC).w
		cmpi.w	#3,(Player_mode).w
		beq.s	locK_5B2B8
		rts
; ---------------------------------------------------------------------------

locK_5B2B8:
		tst.b	(_unkFA88).w
		bmi.s	locK_5B2CE
		jsr	(AllocateObject).l
		bne.s	locretK_5B2CC
		move.l	#Obj_5EF68,(a1)

locretK_5B2CC:
		rts
; ---------------------------------------------------------------------------

locK_5B2CE:
		clr.b	(_unkFAB9).w
		rts
; ---------------------------------------------------------------------------

locretK_5B2D4:
		rts

; =============== S U B R O U T I N E =======================================


subK_5B2D6:
		move	#$2700,sr
		lea	(VDP_data_port).l,a6
		move.w	d1,d2
		addi.w	#VRAM_Plane_A_Name_Table,d2
		swap	d2
		clr.w	d2
		swap	d2
		lsl.l	#2,d2
		lsr.w	#2,d2
		ori.w	#$4000,d2
		swap	d2
		move.l	#$80<<16,d3
		moveq	#0,d4
		moveq	#2-1,d5

locK_5B300:
		move.l	d2,VDP_control_port-VDP_data_port(a6)
		moveq	#$28-1,d6

locK_5B306:
		move.w	d4,(a6)
		dbf	d6,locK_5B306
		add.l	d3,d2
		dbf	d5,locK_5B300
		move	#$2300,sr

locretK_5B316:
		rts
; End of function subK_5B2D6


; =============== S U B R O U T I N E =======================================


subK_5B318:
		bsr.w	subK_5B36C
		move	#$2700,sr
		lea	(VDP_data_port).l,a6
		addi.w	#VRAM_Plane_A_Name_Table,d2
		swap	d2
		clr.w	d2
		swap	d2
		lsl.l	#2,d2
		lsr.w	#2,d2
		ori.w	#$4000,d2
		swap	d2
		move.l	d2,d3
		addi.l	#$80<<16,d3
		lea	(Chunk_table+$7000).l,a1
		move.l	d2,VDP_control_port-VDP_data_port(a6)
		subq.w	#1,d0
		move.w	d0,d1

locK_5B350:
		move.w	(a1)+,(a6)
		dbf	d0,locK_5B350
		lea	(Chunk_table+$7080).l,a1
		move.l	d3,VDP_control_port-VDP_data_port(a6)

locK_5B360:
		move.w	(a1)+,(a6)
		dbf	d1,locK_5B360
		move	#$2300,sr
		rts
; End of function subK_5B318


; =============== S U B R O U T I N E =======================================


subK_5B36C:
		lea	(Chunk_table+$7000).l,a2
		lea	(Chunk_table+$7080).l,a3
		moveq	#0,d0

locK_5B37A:
		moveq	#0,d1
		move.b	(a1)+,d1
		beq.s	locretK_5B316
		cmpi.b	#" ",d1
		beq.w	locK_5B420
		cmpi.b	#"?",d1
		beq.w	locK_5B418
		cmpi.b	#"!",d1
		beq.s	locK_5B410
		cmpi.b	#"&",d1
		beq.s	locK_5B408
		cmpi.b	#")",d1
		beq.s	locK_5B400
		cmpi.b	#"(",d1
		beq.s	locK_5B3F8
		cmpi.b	#".",d1
		beq.s	locK_5B3F0
		cmpi.b	#"I",d1
		beq.s	locK_5B3DC
		addq.w	#2,d0
		subi.b	#"A",d1
		lsl.w	#3,d1
		lea	CreditsText_PlaneMap(pc),a4
		adda.w	d1,a4

locK_5B3C2:
		move.w	(a4)+,d5
		add.w	d6,d5
		move.w	d5,(a2)+
		move.w	(a4)+,d5
		add.w	d6,d5
		move.w	d5,(a2)+
		move.w	(a4)+,d5
		add.w	d6,d5
		move.w	d5,(a3)+
		move.w	(a4)+,d5
		add.w	d6,d5
		move.w	d5,(a3)+
		bra.s	locK_5B37A
; ---------------------------------------------------------------------------

locK_5B3DC:
		addq.w	#1,d0
		lea	CreditsText_PlaneMap.LetterI(pc),a4

locK_5B3E2:
		move.w	(a4)+,d5
		add.w	d6,d5
		move.w	d5,(a2)+
		move.w	(a4)+,d5
		add.w	d6,d5
		move.w	d5,(a3)+
		bra.s	locK_5B37A
; ---------------------------------------------------------------------------

locK_5B3F0:
		addq.w	#1,d0
		lea	CreditsText_PlaneMap.Period(pc),a4
		bra.s	locK_5B3E2
; ---------------------------------------------------------------------------

locK_5B3F8:
		addq.w	#1,d0
		lea	CreditsText_PlaneMap.LeftBracket(pc),a4
		bra.s	locK_5B3E2
; ---------------------------------------------------------------------------

locK_5B400:
		addq.w	#1,d0
		lea	CreditsText_PlaneMap.RightBracket(pc),a4
		bra.s	locK_5B3E2
; ---------------------------------------------------------------------------

locK_5B408:
		addq.w	#2,d0
		lea	CreditsText_PlaneMap.Ampersand(pc),a4
		bra.s	locK_5B3C2
; ---------------------------------------------------------------------------

locK_5B410:
		addq.w	#1,d0
		lea	CreditsText_PlaneMap.Exclamation(pc),a4
		bra.s	locK_5B3E2
; ---------------------------------------------------------------------------

locK_5B418:
		addq.w	#2,d0
		lea	CreditsText_PlaneMap.QuestionMark(pc),a4
		bra.s	locK_5B3C2
; ---------------------------------------------------------------------------

locK_5B420:
		addq.w	#1,d0
		clr.w	(a2)+
		clr.w	(a3)+
		bra.w	locK_5B37A
; End of function subK_5B36C


; =============== S U B R O U T I N E =======================================


subK_5B42A:
		lea	(ArtKosM_ANDKnuckles).l,a1
		move.w	#tiles_to_bytes(ArtTile_Ending_ANDKnuckles),d2
		jsr	(Queue_Kos_Module).l
		move.w	(Player_mode).w,d0
		moveq	#0,d1
		andi.w	#3,d0
		subq.w	#2,d0
		bmi.s	locK_5B452
		beq.s	locK_5B44E
		addi.w	#$18,d1

locK_5B44E:
		addi.w	#$18,d1

locK_5B452:
		tst.w	(SK_alone_flag).w
		bne.s	locK_5B45C
		addi.w	#$C,d1

locK_5B45C:
		tst.b	(_unkFA88).w
		bmi.s	locK_5B46C
		beq.s	locK_5B468
		addi.w	#4,d1

locK_5B468:
		addi.w	#4,d1

locK_5B46C:
		movea.l	off_5B472(pc,d1.w),a2
		jmp	(a2)
; End of function subK_5B42A

; ---------------------------------------------------------------------------
off_5B472:
		dc.l locK_5B4C4
		dc.l locK_5B4C4
		dc.l locK_5B4C4
		dc.l subK_5B4E8
		dc.l subK_5B4E8
		dc.l locK_5B4F8
		dc.l subK_5B4E8
		dc.l subK_5B4E8
		dc.l locK_5B4F8
		dc.l subK_5B4E8
		dc.l subK_5B4E8
		dc.l locK_5B4F8
		dc.l locK_5B4C4
		dc.l locK_5B4BA
		dc.l locK_5B4BA
		dc.l subK_5B4E8
		dc.l locK_5B4DE
		dc.l locK_5B4D4
; ---------------------------------------------------------------------------

locK_5B4BA:
		lea	PLC_CreditsKnuxPose(pc),a1
		jsr	(Load_PLC_Raw).l

locK_5B4C4:
		lea	(ArtKosM_SKPoseBanner).l,a1
		move.w	#tiles_to_bytes(ArtTile_Ending_Logo),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

locK_5B4D4:
		lea	PLC_S3EndingGraphics(pc),a1
		jsr	(Load_PLC_Raw).l

locK_5B4DE:
		lea	PLC_CreditsKnuxPose(pc),a1
		jsr	(Load_PLC_Raw).l

; =============== S U B R O U T I N E =======================================


subK_5B4E8:
		lea	(ArtKosM_S3PoseBanner).l,a1
		move.w	#tiles_to_bytes(ArtTile_Ending_Logo),d2
		jmp	(Queue_Kos_Module).l
; End of function subK_5B4E8

; ---------------------------------------------------------------------------

locK_5B4F8:
		bsr.s	subK_5B4E8
		lea	PLC_S3EndingGraphics(pc),a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------
PLC_S3EndingGraphics: plrlistheader
		plreq ArtTile_Ending_S3Sprites, ArtNem_S3EndingGraphics
PLC_S3EndingGraphics_End

PLC_CreditsKnuxPose: plrlistheader
		plreq ArtTile_Ending_KnuxEndPose, ArtNem_KnuxEndPose
PLC_CreditsKnuxPose_End

; =============== S U B R O U T I N E =======================================


subK_5B514:
		moveq	#0,d1
		tst.w	(SK_alone_flag).w
		bne.s	locK_5B520
		addi.w	#$24,d1

locK_5B520:
		btst	#6,(Graphics_flags).w
		beq.s	locK_5B52C
		addi.w	#$12,d1

locK_5B52C:
		move.w	(Player_mode).w,d0
		subq.w	#2,d0
		bmi.s	locK_5B53E
		beq.s	locK_5B53A
		addi.w	#6,d1

locK_5B53A:
		addi.w	#6,d1

locK_5B53E:
		tst.b	(_unkFA88).w
		bmi.s	locK_5B54A
		beq.s	locK_5B548
		addq.w	#2,d1

locK_5B548:
		addq.w	#2,d1

locK_5B54A:
		lea	CreditsText_ScrollSpeed(pc),a1
		moveq	#0,d0
		move.w	(a1,d1.w),d0
		lsl.l	#8,d0
		move.l	d0,(_unkFAC8).w
		lea	CreditsText_ScrollDelay(pc),a1
		move.w	(a1,d1.w),(_unkF660).w
		rts
; End of function subK_5B514

; ---------------------------------------------------------------------------
CreditsText_PlaneMap:
		dc.w      0,  $800,     1,     2	; A
		dc.w      3,     4,     5,     6	; B
		dc.w      7,     8,     9,    $A	; C
		dc.w      3,  $807,    $B,  $809	; D
		dc.w      3,    $C,     5,    $D	; E
		dc.w      3,    $C,    $E,    $F	; F
		dc.w      7,     8,     9,   $10	; G
		dc.w    $11,  $811,    $E, $180B	; H
.LetterI:	dc.w    $11,   $12,     0,     0	; I
		dc.w    $13,  $811,   $14,   $15	; J
		dc.w    $16,   $17,   $18,   $19	; K
		dc.w    $11,   $13,    $B,   $1A	; L
		dc.w    $1B,   $1C,   $1D,   $1E	; M
		dc.w    $1B,  $811,   $1D,   $1F	; N
		dc.w      7,  $807,     9,  $809	; O
		dc.w    $20,   $21,   $22,   $23	; P
		dc.w      7,  $807,     9,   $24	; Q
		dc.w    $20,   $21,   $25,   $26	; R
		dc.w   $821,    $C,   $27,     6	; S
		dc.w    $28,   $29,   $2A,   $2B	; T
		dc.w    $11,  $811,  $815,   $15	; U
		dc.w    $2C,  $82C,   $2D,  $82D	; V
		dc.w    $2E,  $811,   $2F,   $30	; W
		dc.w    $31,  $831,   $32,  $832	; X
		dc.w    $31,   $33,   $2A,   $2B	; Y
		dc.w   $80C,   $34,   $35,   $36	; Z
.Period:	dc.w    $13,   $37			; .
.LeftBracket:	dc.w    $38, $1038			; (
.RightBracket:	dc.w   $838, $1838			; )
.Ampersand:	dc.w    $39,   $3A,   $3B,   $3C	; &
.Exclamation:	dc.w   $812,   $3D			; !
.QuestionMark:	dc.w  $180A,   $3E,   $3F,   $40	; ?
CreditsText_ScrollDelay:
		; S&K NTSC     None  Chaos Emeralds  Super Emeralds
		dc.w      13*60  +0,      11*60 +30,      13*60  +0	; Sonic
		dc.w      12*60 +30,      12*60 +30,      12*60 +30	; Tails (unused)
		dc.w       2*60 +45,       2*60  +0,       2*60  +0	; Knuckles
		; S&K PAL      None  Chaos Emeralds  Super Emeralds
		dc.w      11*50  +0,       8*50 +48,      11*50  +0	; Sonic
		dc.w       1*50 +10,       1*50 +10,       1*50 +10	; Tails (unused)
		dc.w       2*50 +35,       3*50  +0,       2*50  +0	; Knuckles
		; S3K NTSC     None  Chaos Emeralds  Super Emeralds
		dc.w      12*60 +30,      11*60  +0,              0	; Sonic
		dc.w      12*60 +30,      12*60 +30,              0	; Tails
		dc.w       2*60 +45,       2*60  +0,       2*60  +0	; Knuckles
		; S3K PAL      None  Chaos Emeralds  Super Emeralds
		dc.w      10*50 +20,       8*50 +13,              0	; Sonic
		dc.w      10*50 +20,      10*50 +20,              0	; Tails
		dc.w       2*50  +0,       3*50  +0,       3*50  +0	; Knuckles
CreditsText_ScrollSpeed:
		; S&K NTSC     None  Chaos Emeralds  Super Emeralds
		dc.w            $C3,            $C3,            $C3	; Sonic
		dc.w           $100,           $100,           $100	; Tails (unused)
		dc.w            $BD,            $B1,            $B1	; Knuckles
		; S&K PAL      None  Chaos Emeralds  Super Emeralds
		dc.w            $E8,            $E8,           $100	; Sonic
		dc.w           $100,           $100,           $100	; Tails (unused)
		dc.w            $E5,            $D6,           $100	; Knuckles
		; S3K NTSC     None  Chaos Emeralds  Super Emeralds
		dc.w            $CE,            $CE,            $CF	; Sonic
		dc.w            $CE,            $CE,            $CD	; Tails
		dc.w            $C8,            $BC,            $BC	; Knuckles
		; S3K PAL      None  Chaos Emeralds  Super Emeralds
		dc.w            $F5,            $F5,            $FD	; Sonic
		dc.w            $F5,            $F5,            $FB	; Tails
		dc.w            $F2,            $E2,            $E2	; Knuckles
CreditsText_Part1_SK:
		dc.w byteK_5B72E-CreditsText_Part1_SK
		dc.w byteK_5B744-CreditsText_Part1_SK
		dc.w byteK_5B756-CreditsText_Part1_SK
		dc.w byteK_5B76A-CreditsText_Part1_SK
		dc.w byteK_5B77C-CreditsText_Part1_SK
		dc.w byteK_5B78E-CreditsText_Part1_SK
		dc.w byteK_5B7A0-CreditsText_Part1_SK
		dc.w byteK_5B7AC-CreditsText_Part1_SK
		dc.w byteK_5B7B8-CreditsText_Part1_SK
		dc.w byteK_5B7C4-CreditsText_Part1_SK
		dc.w byteK_5B7D8-CreditsText_Part1_SK
		dc.w byteK_5B7EE-CreditsText_Part1_SK
		dc.w byteK_5B802-CreditsText_Part1_SK
		dc.w byteK_5B81A-CreditsText_Part1_SK
		dc.w byteK_5B82E-CreditsText_Part1_SK
		dc.w byteK_5B840-CreditsText_Part1_SK
		dc.w byteK_5B852-CreditsText_Part1_SK
		dc.w byteK_5B85E-CreditsText_Part1_SK
		dc.w byteK_5B874-CreditsText_Part1_SK
		dc.w byteK_5B886-CreditsText_Part1_SK
		dc.w byteK_5B89A-CreditsText_Part1_SK
		dc.w byteK_5B8B0-CreditsText_Part1_SK
		dc.w byteK_5B8C6-CreditsText_Part1_SK
		dc.w byteK_5B8D4-CreditsText_Part1_SK
		dc.w byteK_5B8E4-CreditsText_Part1_SK
		dc.w byteK_5B8F4-CreditsText_Part1_SK
		dc.w byteK_5B908-CreditsText_Part1_SK
		dc.w byteK_5B918-CreditsText_Part1_SK
		dc.w byteK_5B928-CreditsText_Part1_SK
		dc.w byteK_5B938-CreditsText_Part1_SK
		dc.w byteK_5B948-CreditsText_Part1_SK
		dc.w byteK_5B958-CreditsText_Part1_SK
		dc.w byteK_5B96E-CreditsText_Part1_SK
		dc.w byteK_5B982-CreditsText_Part1_SK
		dc.w byteK_5B992-CreditsText_Part1_SK
		dc.w byteK_5B9A2-CreditsText_Part1_SK
byteK_5B72E:	dc.b $F
		dc.b 7
		dc.b "EXECUTIVE PRODUCER",0
		even
byteK_5B744:	dc.b $11
		dc.b $E
		dc.b "HAYAO NAKAYAMA",0
		even
byteK_5B756:	dc.b $21
		dc.b $B
		dc.b "PROJECT MANAGERS",0
		even
byteK_5B76A:	dc.b $23
		dc.b $10
		dc.b "HISASHI SUZUKI",0
		even
byteK_5B77C:	dc.b $24
		dc.b $E
		dc.b "SHINOBU TOYODA",0
		even
byteK_5B78E:	dc.b $25
		dc.b $E
		dc.b "MASAHARU YOSHII",0
		even
byteK_5B7A0:	dc.b $35
		dc.b $19
		dc.b "PRODUCER",0
		even
byteK_5B7AC:	dc.b $37
		dc.b $18
		dc.b "YUJI NAKA",0
		even
byteK_5B7B8:	dc.b $47
		dc.b $1B
		dc.b "DIRECTOR",0
		even
byteK_5B7C4:	dc.b $49
		dc.b 8
		dc.b "HIROKAZU YASUHARA",0
		even
byteK_5B7D8:	dc.b $59
		dc.b 9
		dc.b "LEAD GAME DESIGNER",0
		even
byteK_5B7EE:	dc.b $5B
		dc.b 8
		dc.b "HIROKAZU YASUHARA",0
		even
byteK_5B802:	dc.b $6B
		dc.b 3
		dc.b "SENIOR GAME DESIGNERS",0
		even
byteK_5B81A:	dc.b $6D
		dc.b $A
		dc.b "HISAYOSHI YOSHIDA",0
		even
byteK_5B82E:	dc.b $6E
		dc.b $10
		dc.b "TAKASHI IIZUKA",0
		even
byteK_5B840:	dc.b $7E
		dc.b $B
		dc.b "LEAD PROGRAMMER",0
		even
byteK_5B852:	dc.b $80
		dc.b $18
		dc.b "YUJI NAKA",0
		even
byteK_5B85E:	dc.b $90
		dc.b 7
		dc.b "SENIOR PROGRAMMERS",0
		even
byteK_5B874:	dc.b $92
		dc.b $C
		dc.b "TAKAHIRO HAMANO",0
		even
byteK_5B886:	dc.b $93
		dc.b 8
		dc.b "MASANOBU YAMAMOTO",0
		even
byteK_5B89A:	dc.b $A3
		dc.b 7
		dc.b "CHARACTER DESIGNER",0
		even
byteK_5B8B0:	dc.b $A5
		dc.b 6
		dc.b "TAKASHI THOMAS YUDA",0
		even
byteK_5B8C6:	dc.b $B5
		dc.b $17
		dc.b "C.G. ARTIST",0
		even
byteK_5B8D4:	dc.b $B7
		dc.b $12
		dc.b "KUNITAKE AOKI",0
		even
byteK_5B8E4:	dc.b $C7
		dc.b $13
		dc.b "ENEMY ARTIST",0
		even
byteK_5B8F4:	dc.b $C9
		dc.b $A
		dc.b "SATOSHI YOKOKAWA",0
		even
byteK_5B908:	dc.b $D9
		dc.b $11
		dc.b "SCENE ARTISTS",0
		even
byteK_5B918:	dc.b $DB
		dc.b $12
		dc.b "KUNITAKE AOKI",0
		even
byteK_5B928:	dc.b $DC
		dc.b $14
		dc.b "CHIE YOSHIDA",0
		even
byteK_5B938:	dc.b $DD
		dc.b $12
		dc.b "TSUNEKO AOKI",0
		even
byteK_5B948:	dc.b $DE
		dc.b $10
		dc.b "SHIGERU OKADA",0
		even
byteK_5B958:	dc.b $DF
		dc.b 6
		dc.b "TAKASHI THOMAS YUDA",0
		even
byteK_5B96E:	dc.b $E0
		dc.b $A
		dc.b "SATOSHI YOKOKAWA",0
		even
byteK_5B982:	dc.b $F0
		dc.b $11
		dc.b "ART ASSISTANT",0
		even
byteK_5B992:	dc.b $F2
		dc.b $12
		dc.b "OSAMU OHASHI",0
		even
byteK_5B9A2:	dc.b $FF
		dc.b $F8
CreditsText_Part2_SK:
		dc.w byteK_5B9F6-CreditsText_Part2_SK
		dc.w byteK_5BA08-CreditsText_Part2_SK
		dc.w byteK_5BA1A-CreditsText_Part2_SK
		dc.w byteK_5BA2C-CreditsText_Part2_SK
		dc.w byteK_5BA32-CreditsText_Part2_SK
		dc.w byteK_5BA42-CreditsText_Part2_SK
		dc.w byteK_5BA4A-CreditsText_Part2_SK
		dc.w byteK_5BA5E-CreditsText_Part2_SK
		dc.w byteK_5BA70-CreditsText_Part2_SK
		dc.w byteK_5BA82-CreditsText_Part2_SK
		dc.w byteK_5BA94-CreditsText_Part2_SK
		dc.w byteK_5BAA2-CreditsText_Part2_SK
		dc.w byteK_5BABA-CreditsText_Part2_SK
		dc.w byteK_5BAD2-CreditsText_Part2_SK
		dc.w byteK_5BAE2-CreditsText_Part2_SK
		dc.w byteK_5BAF0-CreditsText_Part2_SK
		dc.w byteK_5BB02-CreditsText_Part2_SK
		dc.w byteK_5BB12-CreditsText_Part2_SK
		dc.w byteK_5BB2A-CreditsText_Part2_SK
		dc.w byteK_5BB3C-CreditsText_Part2_SK
		dc.w byteK_5BB4C-CreditsText_Part2_SK
		dc.w byteK_5BB62-CreditsText_Part2_SK
		dc.w byteK_5BB72-CreditsText_Part2_SK
		dc.w byteK_5BB88-CreditsText_Part2_SK
		dc.w byteK_5BB92-CreditsText_Part2_SK
		dc.w byteK_5BB9E-CreditsText_Part2_SK
		dc.w byteK_5BBAC-CreditsText_Part2_SK
		dc.w byteK_5BBBC-CreditsText_Part2_SK
		dc.w byteK_5BBD4-CreditsText_Part2_SK
		dc.w byteK_5BBE2-CreditsText_Part2_SK
		dc.w byteK_5BBF0-CreditsText_Part2_SK
		dc.w byteK_5BC04-CreditsText_Part2_SK
		dc.w byteK_5BC14-CreditsText_Part2_SK
		dc.w byteK_5BC26-CreditsText_Part2_SK
		dc.w byteK_5BC38-CreditsText_Part2_SK
		dc.w byteK_5BC48-CreditsText_Part2_SK
		dc.w byteK_5BC5C-CreditsText_Part2_SK
		dc.w byteK_5BC6A-CreditsText_Part2_SK
		dc.w byteK_5BC7A-CreditsText_Part2_SK
		dc.w byteK_5BC82-CreditsText_Part2_SK
		dc.w byteK_5BC88-CreditsText_Part2_SK
byteK_5B9F6:	dc.b 2
		dc.b $D
		dc.b "MUSIC COMPOSERS",0
		even
byteK_5BA08:	dc.b 4
		dc.b $E
		dc.b "HOWARD DROSSIN",0
		even
byteK_5BA1A:	dc.b $14
		dc.b $D
		dc.b "SEGA SOUND TEAM",0
		even
byteK_5BA2C:	dc.b $16
		dc.b $24
		dc.b "BO",0
		even
byteK_5BA32:	dc.b $17
		dc.b $12
		dc.b "SACHIO OGAWA",0
		even
byteK_5BA42:	dc.b $18
		dc.b $20
		dc.b "MILPO",0
		even
byteK_5BA4A:	dc.b $19
		dc.b $A
		dc.b "MASARU SETSUMARU",0
		even
byteK_5BA5E:	dc.b $1A
		dc.b $C
		dc.b "TATSUYUKI MAEDA",0
		even
byteK_5BA70:	dc.b $1B
		dc.b $C
		dc.b "TOMONORI SAWADA",0
		even
byteK_5BA82:	dc.b $1C
		dc.b $E
		dc.b "MASAYUKI NAGAO",0
		even
byteK_5BA94:	dc.b $1D
		dc.b $16
		dc.b "JUN SENOUE",0
		even
byteK_5BAA2:	dc.b $2D
		dc.b 3
		dc.b "EXECUTIVE MANAGEMENT",0
		even
byteK_5BABA:	dc.b $2F
		dc.b 6
		dc.b $53
		dc.b "HOUICHIROU IRIMAJIRI",0
		even
byteK_5BAD2:	dc.b $30
		dc.b $12
		dc.b "TOM KALINSKE",0
		even
byteK_5BAE2:	dc.b $31
		dc.b $16
		dc.b "PAUL RIOUX",0
		even
byteK_5BAF0:	dc.b $41
		dc.b $D
		dc.b "PRODUCT MANAGER",0
		even
byteK_5BB02:	dc.b $43
		dc.b $12
		dc.b "PAMELA KELLY",0
		even
byteK_5BB12:	dc.b $53
		dc.b 3
		dc.b "EXECUTIVE COORDINATOR",0
		even
byteK_5BB2A:	dc.b $55
		dc.b $E
		dc.b "MAMORU SHIGETA",0
		even
byteK_5BB3C:	dc.b $56
		dc.b $14
		dc.b "TOMIO TAKAMI",0
		even
byteK_5BB4C:	dc.b $57
		dc.b $A
		dc.b "DIANE A. FORNASIER ",0
		even
byteK_5BB62:	dc.b $58
		dc.b $12
		dc.b "ROGER HECTOR",0
		even
byteK_5BB72:	dc.b $59
		dc.b 4
		dc.b "TAKAHARU UTSUNOMIYA",0
		even
byteK_5BB88:	dc.b $69
		dc.b $1B
		dc.b "TESTERS",0
		even
byteK_5BB92:	dc.b $6B
		dc.b $16
		dc.b "JASON KUO",0
		even
byteK_5BB9E:	dc.b $6C
		dc.b $16
		dc.b "RICK GREER",0
		even
byteK_5BBAC:	dc.b $6D
		dc.b $12
		dc.b "MIKE WILLIAMS",0
		even
byteK_5BBBC:	dc.b $7D
		dc.b 5
		dc.b "SOUND SPECIAL THANKS",0
		even
byteK_5BBD4:	dc.b $7F
		dc.b $16
		dc.b "CUBE CORP.",0
		even
byteK_5BBE2:	dc.b $80
		dc.b $16
		dc.b "OPUS CORP.",0
		even
byteK_5BBF0:	dc.b $81
		dc.b 8
		dc.b "MASANORI NAKAYAMA",0
		even
byteK_5BC04:	dc.b $82
		dc.b $14
		dc.b "(STUDIO WHO)",0
		even
byteK_5BC14:	dc.b $92
		dc.b $F
		dc.b "SPECIAL THANKS",0
		even
byteK_5BC26:	dc.b $94
		dc.b $10
		dc.b "JINA ISHIWATARI",0
		even
byteK_5BC38:	dc.b $95
		dc.b $12
		dc.b "EMI KAWAMURA",0
		even
byteK_5BC48:	dc.b $96
		dc.b 8
		dc.b "DEBORAH MCCRACKEN",0
		even
byteK_5BC5C:	dc.b $97
		dc.b $14
		dc.b "TAKU MAKINO",0
		even
byteK_5BC6A:	dc.b $AB
		dc.b $13
		dc.b "PRESENTED BY",0
		even
byteK_5BC7A:	dc.b $AD
		dc.b $20
		dc.b "SEGA",0
		even
byteK_5BC82:	dc.b $BD
		dc.b $20
		dc.b "  ",0
		even
byteK_5BC88:	dc.b $FF
		dc.b $F4
CreditsText_Part1:
		dc.w byteK_5BCD2-CreditsText_Part1
		dc.w byteK_5BCE8-CreditsText_Part1
		dc.w byteK_5BCFA-CreditsText_Part1
		dc.w byteK_5BD0E-CreditsText_Part1
		dc.w byteK_5BD20-CreditsText_Part1
		dc.w byteK_5BD32-CreditsText_Part1
		dc.w byteK_5BD44-CreditsText_Part1
		dc.w byteK_5BD50-CreditsText_Part1
		dc.w byteK_5BD5C-CreditsText_Part1
		dc.w byteK_5BD68-CreditsText_Part1
		dc.w byteK_5BD7C-CreditsText_Part1
		dc.w byteK_5BD92-CreditsText_Part1
		dc.w byteK_5BDA6-CreditsText_Part1
		dc.w byteK_5BDBE-CreditsText_Part1
		dc.w byteK_5BDD2-CreditsText_Part1
		dc.w byteK_5BDE4-CreditsText_Part1
		dc.w byteK_5BDF6-CreditsText_Part1
		dc.w byteK_5BE02-CreditsText_Part1
		dc.w byteK_5BE18-CreditsText_Part1
		dc.w byteK_5BE2A-CreditsText_Part1
		dc.w byteK_5BE3E-CreditsText_Part1
		dc.w byteK_5BE54-CreditsText_Part1
		dc.w byteK_5BE6A-CreditsText_Part1
		dc.w byteK_5BE78-CreditsText_Part1
		dc.w byteK_5BE88-CreditsText_Part1
		dc.w byteK_5BE98-CreditsText_Part1
		dc.w byteK_5BEAC-CreditsText_Part1
		dc.w byteK_5BEBC-CreditsText_Part1
		dc.w byteK_5BECC-CreditsText_Part1
		dc.w byteK_5BEDC-CreditsText_Part1
		dc.w byteK_5BEEC-CreditsText_Part1
		dc.w byteK_5BEFC-CreditsText_Part1
		dc.w byteK_5BF12-CreditsText_Part1
		dc.w byteK_5BF26-CreditsText_Part1
		dc.w byteK_5BF36-CreditsText_Part1
		dc.w byteK_5BF46-CreditsText_Part1
byteK_5BCD2:	dc.b $F
		dc.b 7
		dc.b "EXECUTIVE PRODUCER",0
		even
byteK_5BCE8:	dc.b $11
		dc.b $E
		dc.b "HAYAO NAKAYAMA",0
		even
byteK_5BCFA:	dc.b $21
		dc.b $B
		dc.b "PROJECT MANAGERS",0
		even
byteK_5BD0E:	dc.b $23
		dc.b $10
		dc.b "HISASHI SUZUKI",0
		even
byteK_5BD20:	dc.b $24
		dc.b $E
		dc.b "SHINOBU TOYODA",0
		even
byteK_5BD32:	dc.b $25
		dc.b $E
		dc.b "MASAHARU YOSHII",0
		even
byteK_5BD44:	dc.b $35
		dc.b $19
		dc.b "PRODUCER",0
		even
byteK_5BD50:	dc.b $37
		dc.b $18
		dc.b "YUJI NAKA",0
		even
byteK_5BD5C:	dc.b $47
		dc.b $1B
		dc.b "DIRECTOR",0
		even
byteK_5BD68:	dc.b $49
		dc.b 8
		dc.b "HIROKAZU YASUHARA",0
		even
byteK_5BD7C:	dc.b $59
		dc.b 9
		dc.b "LEAD GAME DESIGNER",0
		even
byteK_5BD92:	dc.b $5B
		dc.b 8
		dc.b "HIROKAZU YASUHARA",0
		even
byteK_5BDA6:	dc.b $6B
		dc.b 3
		dc.b "SENIOR GAME DESIGNERS",0
		even
byteK_5BDBE:	dc.b $6D
		dc.b $A
		dc.b "HISAYOSHI YOSHIDA",0
		even
byteK_5BDD2:	dc.b $6E
		dc.b $10
		dc.b "TAKASHI IIZUKA",0
		even
byteK_5BDE4:	dc.b $7E
		dc.b $B
		dc.b "LEAD PROGRAMMER",0
		even
byteK_5BDF6:	dc.b $80
		dc.b $18
		dc.b "YUJI NAKA",0
		even
byteK_5BE02:	dc.b $90
		dc.b 7
		dc.b "SENIOR PROGRAMMERS",0
		even
byteK_5BE18:	dc.b $92
		dc.b $C
		dc.b "TAKAHIRO HAMANO",0
		even
byteK_5BE2A:	dc.b $93
		dc.b 8
		dc.b "MASANOBU YAMAMOTO",0
		even
byteK_5BE3E:	dc.b $A3
		dc.b 7
		dc.b "CHARACTER DESIGNER",0
		even
byteK_5BE54:	dc.b $A5
		dc.b 6
		dc.b "TAKASHI THOMAS YUDA",0
		even
byteK_5BE6A:	dc.b $B5
		dc.b $17
		dc.b "C.G. ARTIST",0
		even
byteK_5BE78:	dc.b $B7
		dc.b $12
		dc.b "KUNITAKE AOKI",0
		even
byteK_5BE88:	dc.b $C7
		dc.b $13
		dc.b "ENEMY ARTIST",0
		even
byteK_5BE98:	dc.b $C9
		dc.b $A
		dc.b "SATOSHI YOKOKAWA",0
		even
byteK_5BEAC:	dc.b $D9
		dc.b $11
		dc.b "SCENE ARTISTS",0
		even
byteK_5BEBC:	dc.b $DB
		dc.b $12
		dc.b "KUNITAKE AOKI",0
		even
byteK_5BECC:	dc.b $DC
		dc.b $14
		dc.b "CHIE YOSHIDA",0
		even
byteK_5BEDC:	dc.b $DD
		dc.b $12
		dc.b "TSUNEKO AOKI",0
		even
byteK_5BEEC:	dc.b $DE
		dc.b $10
		dc.b "SHIGERU OKADA",0
		even
byteK_5BEFC:	dc.b $DF
		dc.b 6
		dc.b "TAKASHI THOMAS YUDA",0
		even
byteK_5BF12:	dc.b $E0
		dc.b $A
		dc.b "SATOSHI YOKOKAWA",0
		even
byteK_5BF26:	dc.b $F0
		dc.b $11
		dc.b "ART ASSISTANT",0
		even
byteK_5BF36:	dc.b $F2
		dc.b $12
		dc.b "OSAMU OHASHI",0
		even
byteK_5BF46:	dc.b $FF
		dc.b $F8
CreditsText_Part2:
		dc.w byteK_5BFAE-CreditsText_Part2
		dc.w byteK_5BFC0-CreditsText_Part2
		dc.w byteK_5BFCE-CreditsText_Part2
		dc.w byteK_5BFDE-CreditsText_Part2
		dc.w byteK_5BFEC-CreditsText_Part2
		dc.w byteK_5BFFA-CreditsText_Part2
		dc.w byteK_5C00E-CreditsText_Part2
		dc.w byteK_5C01A-CreditsText_Part2
		dc.w byteK_5C02C-CreditsText_Part2
		dc.w byteK_5C03E-CreditsText_Part2
		dc.w byteK_5C044-CreditsText_Part2
		dc.w byteK_5C054-CreditsText_Part2
		dc.w byteK_5C05C-CreditsText_Part2
		dc.w byteK_5C070-CreditsText_Part2
		dc.w byteK_5C082-CreditsText_Part2
		dc.w byteK_5C094-CreditsText_Part2
		dc.w byteK_5C0A6-CreditsText_Part2
		dc.w byteK_5C0B4-CreditsText_Part2
		dc.w byteK_5C0C8-CreditsText_Part2
		dc.w byteK_5C0D8-CreditsText_Part2
		dc.w byteK_5C0F0-CreditsText_Part2
		dc.w byteK_5C108-CreditsText_Part2
		dc.w byteK_5C118-CreditsText_Part2
		dc.w byteK_5C126-CreditsText_Part2
		dc.w byteK_5C138-CreditsText_Part2
		dc.w byteK_5C148-CreditsText_Part2
		dc.w byteK_5C160-CreditsText_Part2
		dc.w byteK_5C172-CreditsText_Part2
		dc.w byteK_5C182-CreditsText_Part2
		dc.w byteK_5C198-CreditsText_Part2
		dc.w byteK_5C1A8-CreditsText_Part2
		dc.w byteK_5C1BE-CreditsText_Part2
		dc.w byteK_5C1C8-CreditsText_Part2
		dc.w byteK_5C1D4-CreditsText_Part2
		dc.w byteK_5C1E2-CreditsText_Part2
		dc.w byteK_5C1F2-CreditsText_Part2
		dc.w byteK_5C20A-CreditsText_Part2
		dc.w byteK_5C222-CreditsText_Part2
		dc.w byteK_5C22A-CreditsText_Part2
		dc.w byteK_5C238-CreditsText_Part2
		dc.w byteK_5C246-CreditsText_Part2
		dc.w byteK_5C25A-CreditsText_Part2
		dc.w byteK_5C26A-CreditsText_Part2
		dc.w byteK_5C27C-CreditsText_Part2
		dc.w byteK_5C28E-CreditsText_Part2
		dc.w byteK_5C29E-CreditsText_Part2
		dc.w byteK_5C2B2-CreditsText_Part2
		dc.w byteK_5C2C0-CreditsText_Part2
		dc.w byteK_5C2D0-CreditsText_Part2
		dc.w byteK_5C2D8-CreditsText_Part2
		dc.w byteK_5C2DE-CreditsText_Part2
byteK_5BFAE:	dc.b 2
		dc.b $D
		dc.b "MUSIC COMPOSERS",0
		even
byteK_5BFC0:	dc.b 4
		dc.b $16
		dc.b "BRAD BUXER",0
		even
byteK_5BFCE:	dc.b 5
		dc.b $12
		dc.b "BOBBY BROOKS",0
		even
byteK_5BFDE:	dc.b 6
		dc.b $14
		dc.b "DARRYL ROSS",0
		even
byteK_5BFEC:	dc.b 7
		dc.b $14
		dc.b "GEOFF GRACE",0
		even
byteK_5BFFA:	dc.b 8
		dc.b $E
		dc.b "DOUG GRIGSBY III",0
		even
byteK_5C00E:	dc.b 9
		dc.b $1A
		dc.b "SCIROCCO",0
		even
byteK_5C01A:	dc.b $A
		dc.b $E
		dc.b "HOWARD DROSSIN",0
		even
byteK_5C02C:	dc.b $1A
		dc.b $D
		dc.b "SEGA SOUND TEAM",0
		even
byteK_5C03E:	dc.b $1C
		dc.b $24
		dc.b "BO",0
		even
byteK_5C044:	dc.b $1D
		dc.b $12
		dc.b "SACHIO OGAWA",0
		even
byteK_5C054:	dc.b $1E
		dc.b $20
		dc.b "MILPO",0
		even
byteK_5C05C:	dc.b $1F
		dc.b $A
		dc.b "MASARU SETSUMARU",0
		even
byteK_5C070:	dc.b $20
		dc.b $C
		dc.b "TATSUYUKI MAEDA",0
		even
byteK_5C082:	dc.b $21
		dc.b $C
		dc.b "TOMONORI SAWADA",0
		even
byteK_5C094:	dc.b $22
		dc.b $E
		dc.b "MASAYUKI NAGAO",0
		even
byteK_5C0A6:	dc.b $23
		dc.b $16
		dc.b "JUN SENOUE",0
		even
byteK_5C0B4:	dc.b $33
		dc.b 9
		dc.b "SOUND COORDINATOR",0
		even
byteK_5C0C8:	dc.b $35
		dc.b $14
		dc.b "HISAKI NIMIYA",0
		even
byteK_5C0D8:	dc.b $45
		dc.b 3
		dc.b "EXECUTIVE MANAGEMENT",0
		even
byteK_5C0F0:	dc.b $47
		dc.b 6
		dc.b "SHOUICHIROU IRIMAJIRI",0
		even
byteK_5C108:	dc.b $48
		dc.b $12
		dc.b "TOM KALINSKE",0
		even
byteK_5C118:	dc.b $49
		dc.b $16
		dc.b "PAUL RIOUX",0
		even
byteK_5C126:	dc.b $59
		dc.b $D
		dc.b "PRODUCT MANAGER",0
		even
byteK_5C138:	dc.b $5B
		dc.b $12
		dc.b "PAMELA KELLY",0
		even
byteK_5C148:	dc.b $6B
		dc.b 3
		dc.b "EXECUTIVE COORDINATOR",0
		even
byteK_5C160:	dc.b $6D
		dc.b $E
		dc.b "MAMORU SHIGETA",0
		even
byteK_5C172:	dc.b $6E
		dc.b $14
		dc.b "TOMIO TAKAMI",0
		even
byteK_5C182:	dc.b $6F
		dc.b $A
		dc.b "DIANE A. FORNASIER ",0
		even
byteK_5C198:	dc.b $70
		dc.b $12
		dc.b "ROGER HECTOR",0
		even
byteK_5C1A8:	dc.b $71
		dc.b 4
		dc.b "TAKAHARU UTSUNOMIYA",0
		even
byteK_5C1BE:	dc.b $81
		dc.b $1B
		dc.b "TESTERS",0
		even
byteK_5C1C8:	dc.b $83
		dc.b $16
		dc.b "JASON KUO",0
		even
byteK_5C1D4:	dc.b $84
		dc.b $16
		dc.b "RICK GREER",0
		even
byteK_5C1E2:	dc.b $85
		dc.b $12
		dc.b "MIKE WILLIAMS",0
		even
byteK_5C1F2:	dc.b $95
		dc.b 5
		dc.b "SOUND SPECIAL THANKS",0
		even
byteK_5C20A:	dc.b $97
		dc.b 6
		dc.b "MAYUMI NINA SAKAZAKI",0
		even
byteK_5C222:	dc.b $98
		dc.b $20
		dc.b "(MRM)",0
		even
byteK_5C22A:	dc.b $99
		dc.b $16
		dc.b "CUBE CORP.",0
		even
byteK_5C238:	dc.b $9A
		dc.b $16
		dc.b "OPUS CORP.",0
		even
byteK_5C246:	dc.b $9B
		dc.b 8
		dc.b "MASANORI NAKAYAMA",0
		even
byteK_5C25A:	dc.b $9C
		dc.b $14
		dc.b "(STUDIO WHO)",0
		even
byteK_5C26A:	dc.b $AC
		dc.b $F
		dc.b "SPECIAL THANKS",0
		even
byteK_5C27C:	dc.b $AE
		dc.b $10
		dc.b "JINA ISHIWATARI",0
		even
byteK_5C28E:	dc.b $AF
		dc.b $12
		dc.b "EMI KAWAMURA",0
		even
byteK_5C29E:	dc.b $B0
		dc.b 8
		dc.b "DEBORAH MCCRACKEN",0
		even
byteK_5C2B2:	dc.b $B1
		dc.b $14
		dc.b "TAKU MAKINO",0
		even
byteK_5C2C0:	dc.b $C5
		dc.b $13
		dc.b "PRESENTED BY",0
		even
byteK_5C2D0:	dc.b $C7
		dc.b $20
		dc.b "SEGA",0
		even
byteK_5C2D8:	dc.b $D7
		dc.b $20
		dc.b "  ",0
		even
byteK_5C2DE:	dc.b $FF
		dc.b $F4