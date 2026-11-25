; ---------------------------------------------------------------------------

SOZ1_ScreenInit:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

SOZ1_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

SOZ1_BackgroundInit:
		move.w	(a3),$1C(a3)
		movea.w	$18(a3),a1
		move.b	#$FD,$D(a1)
		jsr	subK_55D56(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	(Refresh_PlaneFull).l
		jmp	locK_55DF2(pc)
; ---------------------------------------------------------------------------

SOZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	SOZ1_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

SOZ1_BackgroundEvent_Index:
		bra.w	locK_55A9A
; ---------------------------------------------------------------------------
		bra.w	locK_55B04
; ---------------------------------------------------------------------------
		bra.w	locK_55B70
; ---------------------------------------------------------------------------
		bra.w	locK_55BCE
; ---------------------------------------------------------------------------
		bra.w	locK_55C26
; ---------------------------------------------------------------------------
		bra.w	locK_55C84
; ---------------------------------------------------------------------------

locK_55A9A:
		tst.w	(Events_fg_5).w
		beq.s	locK_55ACE
		clr.w	(Events_fg_5).w
		move.w	#-8,(_unkEE9C).w
		st	(Screen_shake_flag).w
		jsr	subK_55DB6(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_55B08
; ---------------------------------------------------------------------------

locK_55ACE:
		move.w	#$B20,d0
		cmpi.w	#$4000,(Player_1+x_pos).w
		blo.s	locK_55ADE
		move.w	#$960,d0

locK_55ADE:
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		jsr	subK_55E96(pc)
		jsr	subK_55D56(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l
		jmp	locK_55DF2(pc)
; ---------------------------------------------------------------------------

locK_55B04:
		jsr	subK_55DB6(pc)

locK_55B08:
		move.w	(Camera_X_pos_BG_copy).w,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.w	locK_55BA2
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(SOZ1_16x16_Custom_Kos).l,a1
		lea	(Block_table+$EA0).w,a2
		jsr	(Queue_Kos).l
		lea	(ArtKosM_SOZ1_Custom).l,a1
		move.w	#tiles_to_bytes($315),d2
		jsr	(Queue_Kos_Module).l
		movem.l	(sp)+,d7-a0/a2-a3
		jsr	(AllocateObject).l
		bne.s	locK_55B6A
		move.l	#locK_55F48,(a1)
		jsr	(CreateNewSprite4).l
		bne.s	locK_55B6A
		move.l	#locK_55F98,(a1)
		jsr	(CreateNewSprite4).l
		bne.s	locK_55B6A
		move.l	#locK_55FDA,(a1)

locK_55B6A:
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_55BA2
; ---------------------------------------------------------------------------

locK_55B70:
		cmpi.w	#$55,(Events_fg_5).w
		bne.s	locK_55B9E
		move.w	#$4378,d0
		cmp.w	(Player_1+x_pos).w,d0
		bhi.s	locK_55B9E
		cmpi.w	#$9A8,(Player_1+y_pos).w
		blo.s	locK_55B9E
		tst.w	(Player_mode).w
		bne.s	locK_55BB4
		cmp.w	(Player_2+x_pos).w,d0
		blo.s	locK_55BB4
		cmpi.w	#$9A8,(Player_2+y_pos).w
		bhs.s	locK_55BB4

locK_55B9E:
		jsr	subK_55D94(pc)

locK_55BA2:
		jsr	(DrawBGAsYouMove).l
		jsr	subK_55EBE(pc)
		jsr	subK_55E4C(pc)
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

locK_55BB4:
		move.w	#$10-1,(Palette_fade_info).w
		move.w	#$15,(Events_bg+$04).w
		move.w	#$10,(Events_bg+$06).w
		st	(Palette_fade_timer).w
		addq.w	#4,(Events_routine_bg).w

locK_55BCE:
		tst.w	(Events_bg+$06).w
		beq.s	locK_55BE0
		subq.w	#1,(Events_bg+$06).w
		bne.s	locK_55BFE
		st	(Events_bg+$02).w
		bra.s	locK_55BFE
; ---------------------------------------------------------------------------

locK_55BE0:
		tst.w	(Events_bg+$02).w
		bne.s	locK_55BFE
		btst	#0,(Level_frame_counter+1).w
		beq.s	locK_55BFE
		move.l	a0,-(sp)
		jsr	(Pal_ToBlack).l
		movea.l	(sp)+,a0
		subq.w	#1,(Events_bg+$04).w
		bmi.s	locK_55C10

locK_55BFE:
		jsr	subK_55D94(pc)
		jsr	(DrawBGAsYouMove).l
		jsr	subK_55EBE(pc)
		jmp	subK_55E4C(pc)
; ---------------------------------------------------------------------------


locK_55C10:
		move.w	#$4020-1,(Palette_fade_info).w
		move.w	#$15,(Events_bg+$04).w
		move.w	#8,(Events_bg+$06).w
		addq.w	#4,(Events_routine_bg).w

locK_55C26:
		tst.w	(Events_bg+$06).w
		beq.s	locK_55C32
		subq.w	#1,(Events_bg+$06).w
		bra.s	locK_55C4A
; ---------------------------------------------------------------------------

locK_55C32:
		btst	#0,(Level_frame_counter+1).w
		beq.s	locK_55C4A
		move.l	a0,-(sp)
		jsr	(Pal_ToBlack).l
		movea.l	(sp)+,a0
		subq.w	#1,(Events_bg+$04).w
		bmi.s	locK_55C4E

locK_55C4A:
		jmp	subK_55E4C(pc)
; ---------------------------------------------------------------------------

locK_55C4E:
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(SOZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$EA0).w,a2
		jsr	(Queue_Kos).l
		lea	(ArtKosM_SOZ2_Secondary).l,a1
		move.w	#tiles_to_bytes($315),d2
		jsr	(Queue_Kos_Module).l
		moveq	#PLCID_2C,d0
		jsr	(Load_PLC).l
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(Events_routine_bg).w
		rts
; ---------------------------------------------------------------------------

locK_55C84:
		tst.b	(Kos_modules_left).w
		bne.w	locretK_55D54
		move.w	#$801,(Current_zone_and_act).w
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(Respawn_table_keep).w
		jsr	Clear_Switches(pc)
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		moveq	#PalID_SonicTails,d0
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_55CC6
		moveq	#PalID_Knuckles,d0

locK_55CC6:
		jsr	(LoadPalette).l
		moveq	#PalID_SOZ2,d0
		jsr	(LoadPalette).l
		moveq	#PalID_SOZ2,d0
		jsr	(LoadPalette_Immediate).l
		movem.l	(sp)+,d7-a0/a2-a3
		jsr	subK_55EFC(pc)
		lea	(Normal_palette_line_3).w,a1
		moveq	#bytesToLcnt($40),d0

locK_55CEA:
		clr.l	(a1)+
		dbf	d0,locK_55CEA
		move.w	(Player_1+x_pos).w,d2
		sub.w	(Player_2+x_pos).w,d2
		move.w	(Player_1+y_pos).w,d3
		sub.w	(Player_2+y_pos).w,d3
		move.w	#$140,d0
		move.w	#$3AC,d1
		move.w	d0,(Player_1+x_pos).w
		move.w	d1,(Player_1+y_pos).w
		sub.w	d2,d0
		sub.w	d3,d1
		move.w	d0,(Player_2+x_pos).w
		move.w	d1,(Player_2+y_pos).w
		move.w	#$A0,d0
		move.w	#$34C,d1
		move.w	d0,(Camera_X_pos).w
		move.w	d1,(Camera_Y_pos).w
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d1,(Camera_Y_pos_copy).w
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w
		move.w	d1,(Camera_min_Y_pos).w
		move.w	d1,(Camera_max_Y_pos).w
		move.w	d1,(Camera_target_max_Y_pos).w
		clr.l	(Events_bg+$02).w
		clr.w	(Events_fg_5).w
		clr.w	(Events_routine_bg).w

locretK_55D54:
		rts

; =============== S U B R O U T I N E =======================================


subK_55D56:
		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#4,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		asr.l	#1,d1
		swap	d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		swap	d0
		swap	d1
		move.w	d1,(Events_bg+$10).w
		swap	d1
		asr.l	#1,d1
		lea	(HScroll_table).w,a1
		moveq	#7-1,d2

locK_55D86:
		swap	d0
		move.w	d0,(a1)+
		swap	d0
		add.l	d1,d0
		dbf	d2,locK_55D86
		rts
; End of function subK_55D56


; =============== S U B R O U T I N E =======================================


subK_55D94:
		tst.w	(Screen_shake_flag).w
		bpl.s	subK_55DB6
		move.w	(Level_frame_counter).w,d0
		andi.w	#3,d0
		beq.s	subK_55DB6
		addq.w	#1,(_unkEE9C).w
		cmpi.w	#$280,(_unkEE9C).w
		blt.s	subK_55DB6
		move.w	#8,(Screen_shake_flag).w
; End of function subK_55D94


; =============== S U B R O U T I N E =======================================


subK_55DB6:
		tst.w	(Screen_shake_flag).w
		bpl.s	locK_55DD0
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	locK_55DD0
		moveq	#signextendB(sfx_Rumble2),d0
		jsr	(Play_SFX).l

locK_55DD0:
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$900,d0
		add.w	(_unkEE9C).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$3CD0,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	d0,(Events_bg+$10).w
		rts
; End of function subK_55DB6

; ---------------------------------------------------------------------------

locK_55DF2:
		lea	(HScroll_table+$010).w,a1
		lea	AIZ2_SOZ1_LRZ3_FGDeformDelta(pc),a6
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	#$DF,d1
		move.w	(Level_frame_counter).w,d2
		asr.w	#1,d2
		add.w	d0,d2
		add.w	d0,d2
		andi.w	#$3E,d2
		adda.w	d2,a6
		move.w	(Camera_X_pos_copy).w,d6
		neg.w	d6
		jsr	MakeFGDeformArray(pc)
		lea	(H_scroll_buffer).w,a1
		lea	(HScroll_table+$010).w,a2
		lea	wordK_560DC(pc),a4
		lea	(HScroll_table).w,a5
		lea	AIZ2_SOZ1_LRZ3_FGDeformDelta(pc),a6
		move.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	#$DF,d1
		move.w	(Level_frame_counter).w,d2
		asr.w	#1,d2
		add.w	d0,d2
		add.w	d0,d2
		andi.w	#$3E,d2
		adda.w	d2,a6
		jmp	ApplyFGandBGDeformation(pc)

; =============== S U B R O U T I N E =======================================


subK_55E4C:
		lea	(H_scroll_buffer).w,a1
		lea	AIZ2_SOZ1_LRZ3_FGDeformDelta(pc),a6
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Level_frame_counter).w,d1
		asr.w	#1,d1
		add.w	d0,d1
		add.w	d0,d1
		andi.w	#$3E,d1
		adda.w	d1,a6
		move.w	(Camera_X_pos_copy).w,d0
		neg.w	d0
		move.w	(Camera_X_pos_BG_copy).w,d1
		neg.w	d1
		move.w	#$70-1,d2

locK_55E78:
		move.w	(a6)+,d3
		move.w	d3,d4
		add.w	d0,d3
		add.w	d1,d4
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		move.w	(a6)+,d3
		move.w	d3,d4
		add.w	d0,d3
		add.w	d1,d4
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		dbf	d2,locK_55E78
		rts
; End of function subK_55E4C


; =============== S U B R O U T I N E =======================================


subK_55E96:
		move.w	(Camera_max_Y_pos).w,d0
		cmpi.w	#$960,d0
		bne.s	locretK_55EBC
		cmp.w	(Camera_Y_pos).w,d0
		bhi.s	locretK_55EBC
		move.w	d0,(Camera_min_Y_pos).w
		cmpi.w	#$4310,(Camera_X_pos).w
		blo.s	locretK_55EBC
		move.w	#$4180,(Camera_min_X_pos).w
		st	(Events_fg_5).w

locretK_55EBC:
		rts
; End of function subK_55E96


; =============== S U B R O U T I N E =======================================


subK_55EBE:
		move.w	(Events_bg+$00).w,d0
		beq.s	locretK_55EFA
		clr.w	(Events_bg+$00).w
		movea.w	$18(a3),a1
		move.b	d0,$D(a1)
		cmpi.w	#$540,(Camera_X_pos_BG_copy).w
		blo.s	locretK_55EFA
		move.w	#$6A0,d1
		move.w	#$320,d0
		moveq	#5,d6
		moveq	#6-1,d2

locK_55EE4:
		movem.w	d0-d2/d6,-(sp)
		jsr	(Setup_TileRowDraw).l
		movem.w	(sp)+,d0-d2/d6
		addi.w	#$10,d0
		dbf	d2,locK_55EE4

locretK_55EFA:
		rts
; End of function subK_55EBE


; =============== S U B R O U T I N E =======================================


subK_55EFC:
		lea	(Normal_palette_line_3+$2).w,a1
		lea	(Target_palette_line_3+$2).w,a5
		lea	wordK_560EA(pc),a6
		moveq	#$B-1,d0

locK_55F0A:
		move.w	(a6),(a1)+
		move.w	(a6)+,(a5)+
		dbf	d0,locK_55F0A
		lea	(Normal_palette_line_4+$2).w,a1
		lea	(Target_palette_line_4+$2).w,a5
		lea	wordK_56100(pc),a6
		moveq	#$F-1,d0

locK_55F20:
		move.w	(a6),(a1)+
		move.w	(a6)+,(a5)+
		dbf	d0,locK_55F20
		move.b	#5,(SOZ_darkness_level).w
		move.w	#(30*60)-1,(Palette_cycle_counter1).w
		move.b	#0,(Palette_cycle_counters+$00).w
		move.w	#4,(Palette_cycle_counters+$06).w
		move.w	#$D0,(Palette_cycle_counters+$02).w
		rts
; End of function subK_55EFC

; ---------------------------------------------------------------------------

locK_55F48:
		moveq	#0,d0
		move.b	routine(a0),d0
		jmp	locK_55F52(pc,d0.w)
; ---------------------------------------------------------------------------

locK_55F52:
		bra.w	locK_55F5E
; ---------------------------------------------------------------------------
		bra.w	locK_55F6E
; ---------------------------------------------------------------------------
		bra.w	locK_55F7C
; ---------------------------------------------------------------------------

locK_55F5E:
		tst.w	(Screen_shake_flag).w
		bne.s	locretK_55F96
		move.w	#60,$2E(a0)
		addq.b	#4,routine(a0)

locK_55F6E:
		subq.w	#1,$2E(a0)
		bne.s	locretK_55F96
		st	(Events_bg+$02).w
		addq.b	#4,routine(a0)

locK_55F7C:
		tst.w	(Events_bg+$02).w
		bne.s	locretK_55F96
		jsr	(AllocateObject).l
		bne.s	locK_55F90
		move.l	#Obj_SOZMiniboss,(a1)

locK_55F90:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locretK_55F96:
		rts
; ---------------------------------------------------------------------------

locK_55F98:
		move.l	#locK_55FBE,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$24,width_pixels(a0)
		move.w	#$200,priority(a0)
		move.l	#Map_SOZ1EndDoor,mappings(a0)
		move.w	#$A00,y_pos(a0)

locK_55FBE:
		tst.b	(Current_act).w
		beq.s	locK_55FCA
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locK_55FCA:
		move.w	(Camera_X_pos).w,x_pos(a0)
		st	(Spritemask_flag).w
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_55FDA:
		move.l	#locK_56012,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$24,width_pixels(a0)
		move.w	#$380,priority(a0)
		move.w	#make_art_tile($029,2,1),art_tile(a0)
		move.l	#Map_SOZ1EndDoor,mappings(a0)
		move.w	#$439C,x_vel(a0)
		move.w	#$9D4,y_vel(a0)
		move.b	#1,mapping_frame(a0)

locK_56012:
		bclr	#7,render_flags(a0)
		tst.w	(Events_bg+$02).w
		bne.s	locK_56020
		rts
; ---------------------------------------------------------------------------

locK_56020:
		moveq	#signextendB(sfx_DoorOpen),d0
		jsr	(Play_SFX).l
		move.w	#$F6,(Events_bg+$00).w
		move.l	#locK_56034,(a0)

locK_56034:
		moveq	#1,d0
		bsr.s	subK_560A2
		cmpi.w	#$58,$2E(a0)
		blo.s	locK_56050
		move.w	#$58,$2E(a0)
		clr.w	(Events_bg+$02).w
		move.l	#locK_56056,(a0)

locK_56050:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_56056:
		tst.b	(Current_act).w
		beq.s	locK_56062
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locK_56062:
		bclr	#7,render_flags(a0)
		tst.w	(Events_bg+$02).w
		bne.s	locK_56070
		rts
; ---------------------------------------------------------------------------

locK_56070:
		moveq	#signextendB(sfx_DoorOpen),d0
		jsr	(Play_SFX).l
		move.l	#locK_5607E,(a0)

locK_5607E:
		moveq	#-1,d0
		bsr.s	subK_560A2
		tst.w	$2E(a0)
		bpl.s	locK_5609C
		clr.w	$2E(a0)
		move.w	#$FD,(Events_bg+$00).w
		clr.w	(Events_bg+$02).w
		move.l	#locK_56012,(a0)

locK_5609C:
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


subK_560A2:
		move.w	(Level_frame_counter).w,d1
		andi.w	#3,d1
		bne.s	locK_560AE
		add.w	d0,d0

locK_560AE:
		add.w	d0,$2E(a0)
		move.w	$1A(a0),d0
		add.w	$2E(a0),d0
		move.w	d0,y_pos(a0)
		lea	ScreenShakeArray2(pc),a1
		move.w	$2E(a0),d0
		andi.w	#$3F,d0
		move.b	(a1,d0.w),d0
		andi.w	#1,d0
		add.w	$18(a0),d0
		move.w	d0,x_pos(a0)
		rts
; End of function subK_560A2

; ---------------------------------------------------------------------------
wordK_560DC:
		dc.w   $110,     8,     8,     8,     8,     8, $7FFF
wordK_560EA:
		dc.w   $C46,  $824,  $804,  $402,  $202,  $200,     0,  $422,  $402,  $200,   $40
wordK_56100:
		dc.w   $6AE,  $664,  $422,  $402,  $200,     0,     0,  $EEE,  $466,  $224,     0,   $46,  $6EE,  $48C,  $26A
Map_SOZ1EndDoor:
		include "Levels/SOZ/Misc Object Data/Map - Act 1 End Door.asm"
; ---------------------------------------------------------------------------

SOZ2_ScreenInit:
		move.w	#$7FF,(Screen_Y_wrap_value).w
		move.w	#$7F0,(Camera_Y_pos_mask).w
		move.w	#$3C,(Layout_row_index_mask).w
		move.w	#8,(Events_routine_fg).w
		cmpi.w	#$4E80,(Player_1+x_pos).w
		blo.s	locK_561B0
		jsr	subK_5622C(pc)

locK_561B0:
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

SOZ2_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	(Events_routine_fg).w,d0
		jmp	SOZ2_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

SOZ2_ScreenEvent_Index:
		bra.w	locK_561D8
; ---------------------------------------------------------------------------
		bra.w	locK_56206
; ---------------------------------------------------------------------------
		bra.w	locK_5621A
; ---------------------------------------------------------------------------

locK_561D8:
		move.w	#$7FF,(Screen_Y_wrap_value).w
		move.w	#$7F0,(Camera_Y_pos_mask).w
		move.w	#$3C,(Layout_row_index_mask).w
		jsr	(Reset_TileOffsetPositionActual).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_fg).w

locK_56206:
		move.w	(Camera_X_pos_copy).w,d1
		move.w	(Camera_Y_pos_copy).w,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	locK_5621A
		addq.w	#4,(Events_routine_fg).w

locK_5621A:
		tst.w	(Events_fg_4).w
		beq.s	locK_56226
		clr.w	(Events_fg_4).w
		bsr.s	subK_5622C

locK_56226:
		jmp	(DrawTilesAsYouMove).l

; =============== S U B R O U T I N E =======================================


subK_5622C:
		movea.w	$1C(a3),a1
		lea	$AB(a1),a5
		lea	$95(a1),a1
		move.b	(a5)+,(a1)+
		move.b	(a5)+,(a1)+
		move.b	(a5)+,(a1)+
		move.b	(a5)+,(a1)+
		movea.w	$28(a3),a1
		lea	$AB(a1),a5
		lea	$8C(a1),a1
		move.w	-8(a3),d0
		subi.w	#9,d0
		moveq	#4-1,d1

locK_56256:
		moveq	#8,d2

locK_56258:
		move.b	(a5)+,(a1)+
		dbf	d2,locK_56258
		adda.w	d0,a1
		adda.w	d0,a5
		dbf	d1,locK_56256
		rts
; End of function subK_5622C

; ---------------------------------------------------------------------------

SOZ2_BackgroundInit:
		jsr	subK_5697E(pc)
		moveq	#$10,d0
		cmpi.w	#$2980,(Player_1+x_pos).w
		blo.s	locK_56278
		moveq	#$20,d0

locK_56278:
		move.w	d0,(Events_routine_bg).w
		jsr	subK_566D2(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		moveq	#0,d1
		jsr	(Refresh_PlaneFull).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

SOZ2_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	SOZ2_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

SOZ2_BackgroundEvent_Index:
		bra.w	locK_562D0	; $00
; ---------------------------------------------------------------------------
		bra.w	locK_56300	; $04
; ---------------------------------------------------------------------------
		bra.w	locK_56324	; $08
; ---------------------------------------------------------------------------
		bra.w	locK_56366	; $0C
; ---------------------------------------------------------------------------
		bra.w	locK_563A6	; $10
; ---------------------------------------------------------------------------
		bra.w	locK_5641C	; $14	Rising sand #1
; ---------------------------------------------------------------------------
		bra.w	locK_5645E	; $18	Rising sand #2
; ---------------------------------------------------------------------------
		bra.w	locK_564B8	; $1C
; ---------------------------------------------------------------------------
		bra.w	locK_564D4	; $20
; ---------------------------------------------------------------------------
		bra.w	locK_565C6	; $24
; ---------------------------------------------------------------------------
		bra.w	locK_565DE	; $28
; ---------------------------------------------------------------------------
		bra.w	locK_56676	; $2C
; ---------------------------------------------------------------------------
		bra.w	locK_566A4	; $30
; ---------------------------------------------------------------------------

locK_562D0:
		cmpi.w	#8,(Events_routine_fg).w
		blo.s	locretK_562FE
		jsr	subK_5697E(pc)
		jsr	subK_566D2(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_56304
; ---------------------------------------------------------------------------

locretK_562FE:
		rts
; ---------------------------------------------------------------------------

locK_56300:
		jsr	subK_566D2(pc)

locK_56304:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.w	locK_563C0
		move.w	#$10-1,(Palette_fade_info).w
		move.w	#$15,(Events_bg+$00).w
		addq.w	#4,(Events_routine_bg).w

locK_56324:
		btst	#0,(Level_frame_counter+1).w
		beq.s	locK_563A6
		cmpi.w	#5,(Events_bg+$00).w
		bne.s	locK_56346
		jsr	(AllocateObject).l
		bne.s	locK_56346
		move.l	#Obj_TitleCard,(a1)
		st	$3E(a1)

locK_56346:
		move.l	a0,-(sp)
		jsr	(Pal_FromBlack).l
		movea.l	(sp)+,a0
		subq.w	#1,(Events_bg+$00).w
		bpl.s	locK_563A6
		move.w	#$4020-1,(Palette_fade_info).w
		move.w	#$15,(Events_bg+$00).w
		addq.w	#4,(Events_routine_bg).w

locK_56366:
		btst	#0,(Level_frame_counter+1).w
		beq.s	locK_563A6
		move.l	a0,-(sp)
		jsr	(Pal_FromBlack).l
		movea.l	(sp)+,a0
		subq.w	#1,(Events_bg+$00).w
		bpl.s	locK_563A6
		move.l	#$6000,d0
		move.l	d0,(Camera_min_X_pos).w
		move.l	d0,(Camera_target_min_X_pos).w
		move.l	#-$FFF800,d0
		move.l	d0,(Camera_min_Y_pos).w
		move.l	d0,(Camera_target_min_Y_pos).w
		clr.w	(Palette_fade_timer).w
		clr.w	(Ctrl_1_locked).w
		addq.w	#4,(Events_routine_bg).w

locK_563A6:
		jsr	subK_5699A(pc)
		beq.s	locK_563B6
		move.w	#$18,(Events_routine_bg).w
		bra.w	locK_56484
; ---------------------------------------------------------------------------

locK_563B6:
		tst.w	(Events_fg_5).w
		bne.s	locK_563D8
		jsr	subK_566D2(pc)

locK_563C0:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

locK_563D8:
		clr.w	(Events_fg_5).w
		addq.w	#4,(Events_routine_bg).w
		moveq	#0,d0
		move.w	#$80,d0
		cmpi.w	#$400,(Player_1+y_pos).w
		blo.s	locK_563F6
		addq.w	#4,(Events_routine_bg).w
		move.w	#$3E0,d0

locK_563F6:
		swap	d0
		move.l	d0,(_unkEE9C).w
		jsr	subK_566E8(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		subi.w	#$10,(Camera_Y_pos_BG_rounded).w
		move.w	#$10,(Special_events_routine).w
		cmpi.w	#$14,(Events_routine_bg).w
		beq.s	locK_56440
		bra.s	locK_56474
; ---------------------------------------------------------------------------

locK_5641C:
		jsr	subK_5699A(pc)
		beq.s	locK_5642A
		move.w	#$18,(Events_routine_bg).w
		bra.s	locK_56484
; ---------------------------------------------------------------------------

locK_5642A:
		tst.w	(Events_fg_5).w
		bne.s	locK_56450
		cmpi.w	#$400,(_unkEE9C).w
		blo.s	locK_5643C
		clr.w	(Special_events_routine).w

locK_5643C:
		jsr	subK_566E8(pc)

locK_56440:
		jsr	(DrawBGAsYouMove).l
		jsr	(PlainDeformation).l
		jmp	Go_CheckPlayerRelease(pc)
; ---------------------------------------------------------------------------

locK_56450:
		clr.w	(Events_fg_5).w
		move.w	#$10,(Special_events_routine).w
		addq.w	#4,(Events_routine_bg).w

locK_5645E:
		jsr	subK_5699A(pc)
		bne.s	locK_56484
		cmpi.w	#$A00,(_unkEE9C).w
		blo.s	locK_56470
		clr.w	(Special_events_routine).w

locK_56470:
		jsr	subK_566E8(pc)

locK_56474:
		jsr	(DrawBGAsYouMove).l
		jsr	(PlainDeformation).l
		jmp	Go_CheckPlayerRelease(pc)
; ---------------------------------------------------------------------------

locK_56484:
		move.w	(Camera_X_pos_BG_copy).w,(Events_bg+$02).w
		move.w	(Camera_Y_pos_BG_copy).w,(Events_bg+$04).w
		jsr	subK_566D2(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		move.w	#$1F0,(Draw_delayed_position).w
		move.w	#$1F,(Draw_delayed_rowcount).w
		clr.w	(Events_fg_5).w
		clr.w	(Special_events_routine).w
		clr.b	(Background_collision_flag).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_564BC
; ---------------------------------------------------------------------------

locK_564B8:
		jsr	subK_566D2(pc)

locK_564BC:
		move.w	(Camera_Y_pos_BG_copy).w,d1
		moveq	#0,d2
		jsr	(Draw_PlaneHorzRightToLeft).l
		bpl.s	locK_564E8
		clr.w	(Events_bg+$02).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_564E8
; ---------------------------------------------------------------------------

locK_564D4:
		cmpi.w	#$5000,(Player_1+x_pos).w
		blo.s	locK_564E4
		cmpi.w	#$500,(Camera_Y_pos).w
		bhs.s	locK_56510

locK_564E4:
		jsr	subK_566D2(pc)

locK_564E8:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l
		move.w	(Events_bg+$02).w,d0
		beq.s	locK_5650A
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	(Events_bg+$04).w,(Camera_Y_pos_BG_copy).w

locK_5650A:
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

locK_56510:
		move.w	#$5250,(Events_bg+$0C).w
		move.w	#$6D8,(Events_bg+$0E).w
		movea.w	(a3),a1
		move.w	-8(a3),d0
		subq.w	#4,d0
		moveq	#0,d1
		moveq	#$10-1,d2

locK_56528:
		moveq	#4-1,d3

locK_5652A:
		move.b	(a1),4(a1)
		move.b	d1,(a1)+
		dbf	d3,locK_5652A
		adda.w	d0,a1
		dbf	d2,locK_56528
		lea	(HScroll_table).w,a1
		moveq	#$80-1,d2

locK_56540:
		move.l	d1,(a1)+
		dbf	d2,locK_56540
		jsr	subK_56706(pc)
		lea	(HScroll_table).w,a1
		moveq	#$D-1,d0

locK_56550:
		move.w	(a1)+,(a1)
		andi.w	#$FFF0,(a1)+
		dbf	d0,locK_56550
		move.w	#$500,(Camera_min_Y_pos).w
		move.w	#$680,d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		move.w	#$5140,(Camera_max_X_pos).w
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(SOZ2_16x16_Custom_Kos).l,a1
		lea	(Block_table+$EA0).w,a2
		jsr	(Queue_Kos).l
		lea	(ArtKosM_SOZ2_Custom).l,a1
		move.w	#tiles_to_bytes($315),d2
		jsr	(Queue_Kos_Module).l
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$7FFF,(Palette_cycle_counter1).w
		move.b	#0,(SOZ_darkness_level).w
		move.w	(Palette_cycle_counters+$06).w,d0
		neg.b	d0
		move.b	d0,(Palette_cycle_counters+$00).w
		move.w	#0,(Palette_cycle_counters+$08).w
		move.b	#$7F,(Anim_Counters).w
		jsr	subK_56A12(pc)
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_565F4
; ---------------------------------------------------------------------------

locK_565C6:
		move.w	(Camera_Y_pos_copy).w,d0
		cmp.w	(Camera_min_Y_pos).w,d0
		beq.s	locK_565D4
		move.w	d0,(Camera_min_Y_pos).w

locK_565D4:
		cmp.w	(Camera_max_Y_pos).w,d0
		bne.s	locK_565DE
		addq.w	#4,(Events_routine_bg).w

locK_565DE:
		move.w	#$7FFF,(Palette_cycle_counter1).w
		move.b	#$7F,(Anim_Counters).w
		tst.w	(Events_fg_5).w
		bmi.s	locK_5661A
		jsr	subK_56706(pc)

locK_565F4:
		lea	SOZ2_BGDrawArray(pc),a4
		lea	(HScroll_table).w,a5
		moveq	#$20,d6
		moveq	#$D,d5
		jsr	(Draw_BG).l
		lea	SOZ2_BGDrawArray(pc),a4
		lea	(HScroll_table+$100).w,a5
		jsr	(ApplyDeformation).l
		jmp	(ShakeScreen_Setup).l
; ---------------------------------------------------------------------------

locK_5661A:
		move.w	(Camera_X_pos_BG_copy).w,d0
		subi.w	#$100,d0
		move.w	d0,(Events_bg+$02).w
		jsr	subK_56964(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(SOZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$EA0).w,a2
		jsr	(Queue_Kos).l
		lea	(ArtKosM_SOZ2_Secondary).l,a1
		move.w	#tiles_to_bytes($315),d2
		jsr	(Queue_Kos_Module).l
		moveq	#PalID_SOZ2,d0
		jsr	(LoadPalette_Immediate).l
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(Events_routine_bg).w

locK_56676:
		tst.b	(Kos_modules_left).w
		bne.s	locK_566BC
		jsr	subK_56964(pc)
		move.w	#$200,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	locK_566A8
		clr.w	(Events_bg+$02).w
		move.w	#$52C0,(Camera_max_X_pos).w
		clr.b	(Anim_Counters).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_566A8
; ---------------------------------------------------------------------------

locK_566A4:
		jsr	subK_56964(pc)

locK_566A8:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	#$200,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l

locK_566BC:
		move.w	(Events_bg+$02).w,d0
		beq.s	locK_566C6
		move.w	d0,(Camera_X_pos_BG_copy).w

locK_566C6:
		jsr	(PlainDeformation).l
		jmp	(ShakeScreen_Setup).l

; =============== S U B R O U T I N E =======================================


subK_566D2:
		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		asr.w	#1,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; End of function subK_566D2


; =============== S U B R O U T I N E =======================================


subK_566E8:
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$2E0,d0
		add.w	(_unkEE9C).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$1930,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; End of function subK_566E8


; =============== S U B R O U T I N E =======================================


subK_56706:
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$250,d0
		move.w	#$6D8,d1
		sub.w	(Events_bg+$0E).w,d1
		add.w	d1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$4010,d0
		move.w	#$5250,d1
		sub.w	(Events_bg+$0C).w,d1
		add.w	d1,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		cmpi.b	#6,(Player_1+routine).w
		bhs.w	locK_56936
		move.w	(Events_bg+$08).w,d0
		jmp	locK_56744(pc,d0.w)
; ---------------------------------------------------------------------------

locK_56744:
		bra.w	locK_5675C
; ---------------------------------------------------------------------------
		bra.w	locK_5678A
; ---------------------------------------------------------------------------
		bra.w	locK_567B0
; ---------------------------------------------------------------------------
		bra.w	locK_5680A
; ---------------------------------------------------------------------------
		bra.w	locK_5687C
; ---------------------------------------------------------------------------
		bra.w	locK_56904
; ---------------------------------------------------------------------------

locK_5675C:
		jsr	locK_568DE(pc)
		tst.w	(Events_bg+$0A).w
		beq.w	locK_56936
		lea	(HScroll_table+$134).w,a1
		moveq	#-1,d0
		moveq	#9-1,d1

locK_56770:
		move.w	d0,-(a1)
		subq.w	#1,d0
		dbf	d1,locK_56770
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l
		move.w	#3,(Events_bg+$06).w
		addq.w	#4,(Events_bg+$08).w

locK_5678A:
		jsr	locK_568DE(pc)
		subq.w	#1,(Events_bg+$06).w
		bpl.w	locK_56936
		lea	(HScroll_table+$134).w,a1
		moveq	#-1,d0
		moveq	#9-1,d1

locK_5679E:
		move.w	d0,-(a1)
		subq.w	#2,d0
		dbf	d1,locK_5679E
		move.w	#8,(Events_bg+$06).w
		addq.w	#4,(Events_bg+$08).w

locK_567B0:
		jsr	locK_568DE(pc)
		subq.w	#1,(Events_bg+$06).w
		bpl.w	locK_56936
		lea	(HScroll_table+$184).w,a1
		lea	$3E(a1),a5
		lea	wordK_56AE2(pc),a6
		move.w	(Events_bg+$0A).w,d0
		sub.w	(Camera_Y_pos_copy).w,d0
		add.w	(Camera_Y_pos_BG_copy).w,d0
		subi.w	#$440,d0
		bcc.s	locK_567DC
		moveq	#0,d0

locK_567DC:
		lsr.w	#3,d0
		andi.w	#$FFFE,d0
		cmpi.w	#$10,d0
		bls.s	locK_567EA
		moveq	#$10,d0

locK_567EA:
		suba.w	d0,a6
		moveq	#9-1,d1

locK_567EE:
		move.l	#$80000,(a1)+
		move.w	(a6)+,(a5)+
		dbf	d1,locK_567EE
		clr.w	(Events_bg+$00).w
		moveq	#signextendB(sfx_Collapse),d0
		jsr	(Play_SFX).l
		addq.w	#4,(Events_bg+$08).w

locK_5680A:
		jsr	locK_568DE(pc)
		lea	(HScroll_table+$144).w,a1
		lea	$40(a1),a5
		lea	$3E(a5),a6
		moveq	#9,d0
		moveq	#9-1,d1

locK_5681E:
		tst.b	(a6)
		beq.s	locK_5682C
		bpl.s	locK_56828
		subq.w	#1,d0
		bra.s	locK_5683A
; ---------------------------------------------------------------------------

locK_56828:
		subq.b	#1,(a6)
		bra.s	locK_5683A
; ---------------------------------------------------------------------------

locK_5682C:
		move.l	(a5),d2
		sub.l	d2,(a1)
		subi.l	#$2800,(a5)
		bpl.s	locK_5683A
		st	(a6)

locK_5683A:
		addq.w	#4,a1
		addq.w	#4,a5
		addq.w	#2,a6
		dbf	d1,locK_5681E
		tst.w	d0
		beq.s	locK_56868
		cmpi.w	#9,d0
		beq.w	locK_56936
		tst.w	(Events_bg+$00).w
		bne.w	locK_56936
		moveq	#signextendB(sfx_BossRecovery),d0
		jsr	(Play_SFX).l
		st	(Events_bg+$00).w
		bra.w	locK_56936
; ---------------------------------------------------------------------------

locK_56868:
		lea	(HScroll_table+$122).w,a1
		moveq	#9-1,d1

locK_5686E:
		clr.w	(a1)+
		dbf	d1,locK_5686E
		clr.w	(Events_bg+$06).w
		addq.w	#4,(Events_bg+$08).w

locK_5687C:
		jsr	locK_568DE(pc)
		tst.w	(Events_bg+$06).w
		beq.s	locK_5689A
		subq.w	#1,(Events_bg+$06).w
		bne.w	locK_56936
		clr.w	(Events_bg+$0A).w
		clr.w	(Events_bg+$08).w
		bra.w	locK_56936
; ---------------------------------------------------------------------------

locK_5689A:
		lea	(HScroll_table+$144).w,a1
		lea	$40(a1),a5
		lea	$3F(a5),a6
		moveq	#9,d0
		moveq	#9-1,d1

locK_568AA:
		tst.b	(a6)
		beq.s	locK_568B8
		bpl.s	locK_568B4
		subq.w	#1,d0
		bra.s	locK_568C8
; ---------------------------------------------------------------------------

locK_568B4:
		subq.b	#1,(a6)
		bra.s	locK_568C8
; ---------------------------------------------------------------------------

locK_568B8:
		move.l	(a5),d2
		subi.l	#$2800,(a5)
		sub.l	d2,(a1)
		bmi.s	locK_568C8
		clr.l	(a1)
		st	(a6)

locK_568C8:
		addq.w	#4,a1
		addq.w	#4,a5
		addq.w	#2,a6
		dbf	d1,locK_568AA
		tst.w	d0
		bne.s	locK_56936
		move.w	#$F,(Events_bg+$06).w
		bra.s	locK_56936
; ---------------------------------------------------------------------------

locK_568DE:
		tst.w	(Events_fg_5).w
		bne.s	locK_568E6
		rts
; ---------------------------------------------------------------------------

locK_568E6:
		lea	(HScroll_table+$1C2).w,a1
		moveq	#0,d0
		moveq	#$C-1,d1

locK_568EE:
		move.w	d0,(a1)+
		addq.w	#5,d0
		dbf	d1,locK_568EE
		move.w	#$5140,(Camera_max_X_pos).w
		move.w	#$14,(Events_bg+$08).w
		addq.w	#4,sp

locK_56904:
		lea	(HScroll_table+$144).w,a1
		lea	$7E(a1),a5
		moveq	#$C,d0
		moveq	#$C-1,d1

locK_56910:
		tst.w	(a5)
		beq.s	locK_56918
		subq.w	#1,(a5)
		bra.s	locK_56926
; ---------------------------------------------------------------------------

locK_56918:
		subq.w	#5,(a1)
		cmpi.w	#-$100,(a1)
		bgt.s	locK_56926
		move.w	#-$100,(a1)
		subq.w	#1,d0

locK_56926:
		addq.w	#4,a1
		addq.w	#2,a5
		dbf	d1,locK_56910
		tst.w	d0
		bne.s	locK_56936
		st	(Events_fg_5).w

locK_56936:
		move.l	a0,-(sp)
		lea	(HScroll_table).w,a0
		lea	$100(a0),a1
		lea	$20(a1),a5
		lea	$20(a5),a6
		move.w	(Camera_X_pos_BG_copy).w,d0
		moveq	#$D-1,d1

locK_5694E:
		move.w	(a5)+,d2
		add.w	(a6),d2
		add.w	d0,d2
		move.w	d2,(a0)
		move.w	d2,(a1)+
		addq.w	#4,a0
		addq.w	#4,a6
		dbf	d1,locK_5694E
		movea.l	(sp)+,a0
		rts
; End of function subK_56706


; =============== S U B R O U T I N E =======================================


subK_56964:
		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		asr.w	#1,d0
		addi.w	#$200,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; End of function subK_56964


; =============== S U B R O U T I N E =======================================


subK_5697E:
		movea.w	$38(a3),a5
		movea.w	$3C(a3),a6
		lea	$17(a5),a5
		lea	$17(a6),a6
		moveq	#$A-1,d0

locK_56990:
		clr.b	(a5)+
		clr.b	(a6)+
		dbf	d0,locK_56990
		rts
; End of function subK_5697E


; =============== S U B R O U T I N E =======================================


subK_5699A:
		cmpi.w	#$2A00,(Player_1+x_pos).w
		blo.s	locK_569B6
		move.w	(Player_1+y_pos).w,d0
		cmpi.w	#$140,d0
		blo.s	locK_569B6
		cmpi.w	#$180,d0
		bhi.s	locK_569B6
		moveq	#-1,d0
		rts
; ---------------------------------------------------------------------------

locK_569B6:
		moveq	#0,d0
		rts
; End of function subK_5699A

; ---------------------------------------------------------------------------

locK_569BA:
		st	(Background_collision_flag).w
		addi.l	#$A000,(_unkEE9C).w
		move.w	#$2E0,d0
		add.w	(_unkEE9C).w,d0
		neg.w	d0
		move.w	d0,(Camera_Y_diff).w
		move.w	#$1930,(Camera_X_diff).w
		rts
; ---------------------------------------------------------------------------

Go_CheckPlayerRelease:
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(Player_1).w,a1
		btst	#Status_OnObj,status(a1)
		beq.s	locK_569F6
		movea.w	interact(a1),a0
		jsr	(CheckPlayerReleaseFromObj).l

locK_569F6:
		lea	(Player_2).w,a1
		btst	#Status_OnObj,status(a1)
		beq.s	locK_56A0C
		movea.w	interact(a1),a0
		jsr	(CheckPlayerReleaseFromObj).l

locK_56A0C:
		movem.l	(sp)+,d7-a0/a2-a3
		rts

; =============== S U B R O U T I N E =======================================


subK_56A12:
		jsr	(AllocateObject).l
		bne.s	locretK_56A32
		move.l	#locK_56A34,d1
		moveq	#8-1,d2

locK_56A22:
		move.l	d1,(a1)
		move.w	d2,subtype(a1)
		jsr	(CreateNewSprite4).l
		dbne	d2,locK_56A22

locretK_56A32:
		rts
; End of function subK_56A12

; ---------------------------------------------------------------------------

locK_56A34:
		move.b	#$40,width_pixels(a0)
		bset	#7,status(a0)
		move.w	subtype(a0),d0
		lsl.w	#4,d0
		addi.w	#$458,d0
		sub.w	(Camera_Y_pos_BG_copy).w,d0
		add.w	(Camera_Y_pos_copy).w,d0
		move.w	d0,y_pos(a0)
		move.w	subtype(a0),d0
		add.w	d0,d0
		lea	wordK_56AF4(pc),a1
		move.w	(a1,d0.w),d4
		add.w	d0,d0
		lea	(HScroll_table+$008).w,a1
		sub.w	(a1,d0.w),d4
		add.w	(Camera_X_pos_copy).w,d4
		cmpi.w	#$10,(Events_bg+$08).w
		beq.s	locK_56A7E
		move.w	#$7FFF,d4

locK_56A7E:
		move.w	d4,x_pos(a0)
		moveq	#$4B,d1
		moveq	#8,d2
		moveq	#8,d3
		jsr	(SolidObjectFull2).l
		move.w	#-$300,d0
		lea	(Player_1).w,a1
		btst	#$10,d6
		beq.s	locK_56AA4
		move.w	d0,x_vel(a1)
		move.w	d0,y_vel(a1)

locK_56AA4:
		lea	(Player_2).w,a1
		btst	#$11,d6
		beq.s	locretK_56AB6
		move.w	d0,x_vel(a1)
		move.w	d0,y_vel(a1)

locretK_56AB6:
		rts
; ---------------------------------------------------------------------------
SOZ2_BGDrawArray:
		dc.w   $440,   $10,   $10,   $10,   $10,   $10,   $10,   $10,   $10,   $10,   $10,   $10, $7FFF
		dc.w  $1800
		dc.w  $1502
		dc.w  $1204
		dc.w  $0F06
		dc.w  $0C08
		dc.w  $090A
		dc.w  $060C
		dc.w  $030E
wordK_56AE2:
		dc.w  $0010
		dc.w  $030E
		dc.w  $060C
		dc.w  $090A
		dc.w  $0C08
		dc.w  $0F06
		dc.w  $1204
		dc.w  $1502
		dc.w  $1800
wordK_56AF4:
		dc.w  $1268
		dc.w  $1260
		dc.w  $1260
		dc.w  $125C
		dc.w  $1254
		dc.w  $1248
		dc.w  $1248
		dc.w  $1248