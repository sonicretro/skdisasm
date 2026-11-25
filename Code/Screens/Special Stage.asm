; ---------------------------------------------------------------------------

SpecialStage:
		moveq	#signextendB(cmd_Stop),d0
		bsr.w	Play_Music
	if ~~Sonic3_Alone
		clr.w	(Kos_decomp_queue_count).w
		clearRAM	Kos_decomp_stored_registers,(Kos_decomp_module_end-Kos_decomp_stored_registers)
	endif
		bsr.w	Clear_Nem_Queue
		bsr.w	Pal_FadeToWhite
		move	#$2700,sr
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$9001,(a6)
		move.w	#$9200,(a6)
		move.w	#$8B00,(a6)
		move.w	#$8720,(a6)
		clr.b	(Water_full_screen_flag).w
		move.w	#$8C81,(a6)
		bsr.w	Clear_DisplayData
		clearRAM	Sprite_table_input,(Sprite_table_input_end-Sprite_table_input)
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
	if Sonic3_Alone
		clearRAM	Stat_table,(Pos_table-Stat_table)
	else
		clearRAM	Oscillating_table,(AIZ_vine_angle-Oscillating_table)
		clearRAM	Stat_table,(Pos_table-Stat_table)
		moveq	#0,d0
		move.l	d0,(LRZ_rocks_addr_front).w
		move.l	d0,(LRZ_rocks_addr_back).w
	endif
		jsr	(Init_SpriteTable).l
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		lea	(Pal_SStage_Main).l,a1
		lea	(Target_palette).w,a2
		move.w	#bytesToWcnt(Target_palette_end-Target_palette),d0
; loc3_7546:
locK_8284:
		move.w	(a1)+,(a2)+
		dbf	d0,locK_8284
	if ~~Sonic3_Alone
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_82A6
		lea	(Pal_SStage_Knux).l,a1
		lea	(Target_palette+$10).w,a2
		move.w	#bytesToWcnt($10),d0

locK_82A0:
		move.w	(a1)+,(a2)+
		dbf	d0,locK_82A0

locK_82A6:
	endif
		move.l	#vdpComm(tiles_to_bytes($000),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageLayout).l,a0
		bsr.w	Nem_Decomp
	if Sonic3_Alone
		lea	(MapUnc_SStageLayout).l,a1
	else
		bsr.w	subK_85B0
		lea	(RAM_start+$5500).l,a1
		lea	(MapEni_SStageLayout).l,a0
		move.w	#make_art_tile($000,0,0),d0
		bsr.w	Eni_Decomp
		lea	(RAM_start+$5500).l,a1
	endif
		move.l	#vdpComm(VRAM_Plane_A_Name_Table,VRAM,WRITE),d0
		moveq	#40-1,d1
		moveq	#28-1,d2
		jsr	(Plane_Map_To_VRAM).l
		move.l	#vdpComm(tiles_to_bytes(ArtTile_SStage_Sphere),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageSphere).l,a0
		bsr.w	Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes(ArtTile_SStage_Ring),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageRing).l,a0
		bsr.w	Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes(ArtTile_SStage_BG),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageBG).l,a0
		bsr.w	Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes(ArtTile_SStage_GetBlueSpheres),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_GetBlueSpheres).l,a0
		bsr.w	Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes(ArtTile_SStage_GetBlueSpheres+$199),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_GBSArrow).l,a0
		bsr.w	Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes(ArtTile_SStage_Digits),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageDigits).l,a0
		bsr.w	Nem_Decomp
		lea	(ArtNem_SStageDigits).l,a0
		lea	(H_scroll_buffer+$20).w,a4
		bsr.w	Nem_Decomp_To_RAM
		move.l	#vdpComm(tiles_to_bytes(ArtTile_SStage_Icons),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageIcons).l,a0
		bsr.w	Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes(ArtTile_SStage_Shadow),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageShadow).l,a0
		bsr.w	Nem_Decomp
		lea	(MapUnc_SSNum000).l,a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$084,VRAM,WRITE),d0
		moveq	#8-1,d1
		moveq	#3-1,d2
		jsr	(Plane_Map_To_VRAM).l
		lea	(MapUnc_SSNum000).l,a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$0BC,VRAM,WRITE),d0
		moveq	#8-1,d1
		moveq	#3-1,d2
		jsr	(Plane_Map_To_VRAM).l
		lea	(RAM_start).l,a1
		lea	(MapEni_SStageBG).l,a0
		move.w	#make_art_tile(ArtTile_SStage_BG,2,0),d0
		bsr.w	Eni_Decomp
		lea	(RAM_start).l,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table,VRAM,WRITE),d0
		moveq	#64-1,d1
		moveq	#32-1,d2
		jsr	(Plane_Map_To_VRAM).l
	if Sonic3_Alone
		lea	(SStageLayoutPtrs).l,a2
		tst.b	(Debug_cheat_flag).w
		beq.s	loc3_7692
		move.w	(Sound_test_sound).w,d0
		btst	#button_A,(Ctrl_1_held).w
		bne.s	loc3_76B6

loc3_7692:
		moveq	#0,d0
		move.b	(Current_special_stage).w,d0
		cmpi.w	#7,(Chaos_emerald_count).w
		bcc.s	loc3_76B6
		lea	(Collected_emeralds_array).w,a1

loc3_76A4:
		tst.b	(a1,d0.w)
		beq.s	loc3_76B6
		addq.w	#1,d0
		cmpi.w	#7,d0
		bcs.s	loc3_76A4
		moveq	#0,d0
		bra.s	loc3_76A4
; ---------------------------------------------------------------------------

loc3_76B6:
		andi.w	#7,d0
		move.b	d0,(Current_special_stage).w
		move.w	d0,d1
		lsl.w	#2,d0
		movea.l	(a2,d0.w),a2
		lea	(Level_layout_header).w,a3
		move.w	#bytesToLcnt($400),d0

loc3_76CE:
		move.l	(a2)+,(a3)+
		dbf	d0,loc3_76CE
		move.w	(a2)+,(Special_stage_angle).w
		move.w	(a2)+,(Special_stage_X_pos).w
		move.w	(a2)+,(Special_stage_Y_pos).w
		move.w	(a2)+,(Special_stage_rings_left).w
		lsl.w	#4,d1
		lea	(SS_Pal_Map_Ptrs).l,a1
		lea	(Target_palette).w,a2
		movea.l	4(a1,d1.w),a1
		move.l	a1,(Special_stage_palette_addr).w
		move.l	(a1)+,$70(a2)
		move.l	(a1)+,$74(a2)
		move.l	(a1)+,$78(a2)
		move.l	(a1)+,$7C(a2)
		move.l	$10(a1),$50(a2)
		move.w	$14(a1),$54(a2)
	else
		lea	(SStageKos_PerspectiveMaps).l,a0
		lea	(RAM_start).l,a1
		bsr.w	Kos_Decomp
	endif
		bsr.w	subK_9EA0
		bsr.w	Load_SSSprite_Mappings
		clr.b	(Level_started_flag).w
		move.b	#$FF,(Special_stage_sphere_HUD_flag).w
		move.b	#$80,(Special_stage_extra_life_flags).w
		move.w	#$1000,(Special_stage_rate).w
		move.w	#30*60,(Special_stage_rate_timer).w
	if ~~Sonic3_Alone
		tst.b	(Blue_spheres_stage_flag).w
		beq.s	locK_842C
		move.w	#45*60,(Special_stage_rate_timer).w

locK_842C:
	endif
		move.w	#0,(Camera_X_pos_copy).w
		move.w	#0,(Camera_Y_pos_copy).w
		move.w	#-1,(Screen_Y_wrap_value).w
		move.l	#Obj_SStage_8FAA,(Player_1).w
	if Sonic3_Alone
		move.l	#Obj_SStage_8380,(Dynamic_object_RAM+object_size).w
		tst.w	(Player_option).w
	else
		tst.w	(Player_mode).w
	endif
		bne.s	locK_8454
		move.l	#Obj_SStage_9212,(Player_2).w
	if Sonic3_Alone
		move.l	#Obj_SStage_83E4,(Dynamic_object_RAM+(object_size*2)).w
	endif
; loc3_7770:
locK_8454:
		move.l	#Obj_SStage_8DF8,(Reserved_object_3).w
		move.l	#Obj_SStage_8E40,(Dynamic_object_RAM).w
		jsr	(Process_Sprites).l
		bsr.w	Animate_SSRings
		bsr.w	Touch_SSSprites
		jsr	(Render_Sprites).l
		jsr	Draw_SSSprites(pc)
		bsr.w	subK_9D5E
		move.b	#1,(Special_stage_fade_timer).w
		move.b	#VInt_ID_1C,(V_int_routine).w
		bsr.w	Wait_VSync
		move.b	#0,(Special_stage_fade_timer).w
		move.w	#$8C89,(VDP_control_port).l
	if ~~Sonic3_Alone
		move.w	#30*60,(Demo_timer).w
		jsr	(GetDemoPtr).l
	endif
		moveq	#signextendB(mus_SpecialStage),d0
		bsr.w	Play_Music
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		bsr.w	Pal_FadeFromWhite
; loc3_77D2:
locK_84C2:
		bsr.w	Pause_Game
		move.b	#VInt_ID_1C,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		bsr.w	Wait_VSync
		addq.w	#1,(Level_frame_counter).w
	if ~~Sonic3_Alone
		jsr	(Demo_PlayRecord).l
	endif
		jsr	(Process_Sprites).l
		bsr.w	Animate_SSRings
		bsr.w	Touch_SSSprites
		jsr	(Render_Sprites).l
		jsr	Draw_SSSprites(pc)
	if ~~Sonic3_Alone
		bsr.w	Draw_SSShadows
	endif
		bsr.w	subK_9D5E
		bsr.w	subK_9B62
		bsr.w	Process_Nem_Queue_Init
		jsr	(Process_Kos_Module_Queue).l
	if Sonic3_Alone
		cmpi.b	#GameMode_SpecialStage3,(Game_mode).w
	else
		tst.w	(Demo_mode_flag).w
		beq.s	locK_851A
		tst.w	(Demo_timer).w
		beq.s	locK_8522

locK_851A:
		cmpi.b	#GameMode_SpecialStage,(Game_mode).w
	endif
		beq.s	locK_84C2

locK_8522:
		tst.w	(Demo_mode_flag).w
		beq.s	locK_852E
		move.b	#GameMode_SegaScreen,(Game_mode).w
; loc3_7828:
locK_852E:
		move.w	#60,(Demo_timer).w
		move.w	#$40-1,(Palette_fade_info).w
		clr.w	(Pal_fade_delay).w
; loc3_7838:
locK_853E:
		move.b	#VInt_ID_1C,(V_int_routine).w
		bsr.w	Wait_VSync
	if ~~Sonic3_Alone
		jsr	(Demo_PlayRecord).l
	endif
		jsr	(Process_Sprites).l
		bsr.w	Animate_SSRings
		bsr.w	Touch_SSSprites
		jsr	(Render_Sprites).l
		jsr	Draw_SSSprites(pc)
		bsr.w	subK_9D5E
		bsr.w	subK_9B62
		bsr.w	Process_Nem_Queue_Init
		jsr	(Process_Kos_Module_Queue).l
		subq.w	#1,(Pal_fade_delay).w
		bpl.s	locK_8588
		move.w	#2,(Pal_fade_delay).w
		bsr.w	Pal_ToWhite
; loc3_787C:
locK_8588:
		tst.w	(Demo_timer).w
		bne.s	locK_853E
	if Sonic3_Alone
		addq.b	#1,(Current_special_stage).w
		cmpi.b	#7,(Current_special_stage).w
		bcs.s	locret3_7894
		move.b	#0,(Current_special_stage).w

locret3_7894:
	endif
		rts
; ---------------------------------------------------------------------------
	if ~~Sonic3_Alone
SSLayoutOffs_RAM:
		dc.l RAM_start+$0000
		dc.l RAM_start+$0408
		dc.l RAM_start+$0810
		dc.l RAM_start+$0C18
		dc.l RAM_start+$1020
		dc.l RAM_start+$1428
		dc.l RAM_start+$1830
		dc.l RAM_start+$1C38

; =============== S U B R O U T I N E =======================================


subK_85B0:
		tst.b	(Blue_spheres_stage_flag).w
		bne.w	locK_86C8
		lea	(SSCompressedLayoutPtrs).l,a0
		movea.l	(a0),a0
		lea	(RAM_start).l,a1
		bsr.w	Kos_Decomp
		lea	(SStageLayoutPtrs).l,a2
		move.b	(Chaos_emerald_count).w,d3
		tst.w	(SK_alone_flag).w
		beq.s	locK_85E4
		lea	(SSLayoutOffs_RAM).l,a2
		moveq	#0,d2
		bra.s	locK_85F4
; ---------------------------------------------------------------------------

locK_85E4:
		move.b	(SK_special_stage_flag).w,d2
		beq.s	locK_85F4
		lea	(SSLayoutOffs_RAM).l,a2
		move.b	(Super_emerald_count).w,d3

locK_85F4:
		tst.b	(Debug_cheat_flag).w
		beq.s	locK_8606
		move.w	(Sound_test_sound).w,d0
		btst	#button_A,(Ctrl_1).w
		bne.s	locK_8630

locK_8606:
		moveq	#0,d0
		move.b	(Current_special_stage).w,d0
		cmpi.b	#7,d3
		bhs.s	locK_8630
		moveq	#5,d1
		lea	(Collected_emeralds_array).w,a1
		add.b	d2,d2

locK_861A:
		cmp.b	(a1,d0.w),d2
		beq.s	locK_8630
		addq.w	#1,d0
		cmpi.w	#7,d0
		blo.s	locK_861A
		moveq	#0,d0
		dbf	d1,locK_861A
		moveq	#7,d0

locK_8630:
		andi.w	#7,d0
		move.b	d0,(Current_special_stage).w
		move.w	d0,d1
		lsl.w	#2,d0
		movea.l	(a2,d0.w),a2
	if Sonic3_Complete=0
		tst.w	(SK_alone_flag).w
		bne.s	locK_8652
		tst.b	(SK_special_stage_flag).w
		bne.s	locK_8652
		adda.l	#LockOnROM_Start,a2

locK_8652:
	endif
		lea	(SStage_layout_buffer).w,a3
		moveq	#0,d2
		move.w	#bytesToLcnt($100),d0

locK_865C:
		move.l	d2,(a3)+
		dbf	d0,locK_865C
		move.w	#bytesToLcnt($400),d0

locK_8666:
		move.l	(a2)+,(a3)+
		dbf	d0,locK_8666
		move.w	#bytesToLcnt($100),d0

locK_8670:
		move.l	d2,(a3)+
		dbf	d0,locK_8670
		move.w	(a2)+,(Special_stage_angle).w
		move.w	(a2)+,(Special_stage_X_pos).w
		move.w	(a2)+,(Special_stage_Y_pos).w
		move.w	(a2)+,(Special_stage_rings_left).w
		lsl.w	#4,d1
		lea	(SS_Pal_Map_Ptrs).l,a1
		lea	(Target_palette).w,a2
		movea.l	4(a1,d1.w),a1
		tst.w	(SK_alone_flag).w
		bne.s	locK_86A2
		tst.b	(SK_special_stage_flag).w
		beq.s	locK_86A6

locK_86A2:
		lea	$130(a1),a1

locK_86A6:
		move.l	a1,(Special_stage_palette_addr).w
		move.l	(a1)+,$70(a2)
		move.l	(a1)+,$74(a2)
		move.l	(a1)+,$78(a2)
		move.l	(a1)+,$7C(a2)
		move.l	$10(a1),$50(a2)
		move.w	$14(a1),$54(a2)
		rts
; ---------------------------------------------------------------------------

locK_86C8:
		lea	(SSCompressedLayoutPtrs).l,a0
		movea.l	4(a0),a0
		lea	(RAM_start).l,a1
		bsr.w	Kos_Decomp
		lea	(SStage_layout_buffer).w,a3
		moveq	#0,d2
		move.w	#bytesToLcnt($600),d0

locK_86E6:
		move.l	d2,(a3)+
		dbf	d0,locK_86E6
		move.b	#0,(Current_special_stage).w
		move.w	#$4000,(Special_stage_angle).w
		move.w	#$1000,(Special_stage_X_pos).w
		move.w	#$300,(Special_stage_Y_pos).w
		clr.w	(Special_stage_rings_left).w
		clr.w	(Blue_spheres_difficulty).w
		lea	(Blue_spheres_current_stage).w,a4
		lea	wordK_87BA(pc),a1
		moveq	#4-1,d7

locK_8716:
		lea	(RAM_start).l,a2
		move.b	(a4)+,d0
		andi.w	#$7F,d0
		moveq	#0,d1
		move.b	(a2,d0.w),d1
		add.w	d1,(Special_stage_rings_left).w
		lea	$80(a2),a2
		moveq	#0,d1
		move.b	(a2,d0.w),d1
		add.w	d1,(Blue_spheres_difficulty).w
		lea	$80(a2),a2
		lsl.w	#8,d0
		lea	(a2,d0.w),a2
		move.w	(a1)+,d3
		move.w	(a1)+,d4
		move.w	(a1)+,d5
		move.w	(a1)+,d0
		lea	(SStage_layout_buffer+$100).w,a3
		lea	(a3,d0.w),a3
		moveq	#$F,d0

locK_8756:
		move.w	d4,d2
		moveq	#$10-1,d1

locK_875A:
		move.b	(a2,d2.w),(a3)+
		add.w	d3,d2
		dbf	d1,locK_875A
		lea	$10(a3),a3
		add.w	d5,d4
		dbf	d0,locK_8756
		dbf	d7,locK_8716
		moveq	#0,d1
		move.b	(Blue_spheres_current_stage+2).w,d1
		move.w	d1,d2
		andi.w	#7,d1
		lsl.w	#4,d1
		lea	(SS_Pal_Map_Ptrs).l,a1
		lea	(Target_palette).w,a2
		movea.l	4(a1,d1.w),a1
		andi.w	#8,d2
		beq.s	locK_8798
		lea	$130(a1),a1

locK_8798:
		move.l	a1,(Special_stage_palette_addr).w
		move.l	(a1)+,$70(a2)
		move.l	(a1)+,$74(a2)
		move.l	(a1)+,$78(a2)
		move.l	(a1)+,$7C(a2)
		move.l	$10(a1),$50(a2)
		move.w	$14(a1),$54(a2)
		rts
; End of function subK_85B0

; ---------------------------------------------------------------------------
wordK_87BA:
		dc.w      1
		dc.w      0
		dc.w    $10
		dc.w      0
		dc.w  $FFFF
		dc.w     $F
		dc.w    $10
		dc.w    $10
		dc.w      1
		dc.w    $F0
		dc.w  $FFF0
		dc.w   $200
		dc.w  $FFFF
		dc.w    $FF
		dc.w  $FFF0
		dc.w   $210
	endif

; =============== S U B R O U T I N E =======================================


Rotate_SSPal:
		tst.b	(Special_stage_fade_timer).w
		bne.s	locretK_8818
	if Sonic3_Alone
		lea	(SS_Pal_Map_Ptrs).l,a1
	endif
		move.w	(Special_stage_anim_frame).w,d0
		cmpi.w	#$10,d0
		blo.s	locK_87F8
		tst.b	(Special_stage_turning).w
		bpl.s	locretK_8818
		move.b	(Special_stage_palette_frame).w,d0
		andi.w	#$F,d0
; loc3_78BA:
locK_87F8:
		andi.w	#$E,d0
		neg.w	d0
		addi.w	#$10,d0
		movea.l	(Special_stage_palette_addr).w,a1
		lea	(a1,d0.w),a1
		lea	(Normal_palette_line_4+$10).w,a2
		move.w	#bytesToWcnt($10),d0
; loc3_78D4:
locK_8812:
		move.w	(a1)+,(a2)+
		dbf	d0,locK_8812
; locret3_78DA:
locretK_8818:
		rts
; End of function Rotate_SSPal


; =============== S U B R O U T I N E =======================================


Update_SSMap:
		lea	(VDP_data_port).l,a6
		lea	(SS_Pal_Map_Ptrs).l,a1
		move.w	(Special_stage_anim_frame).w,d0
		cmp.b	(Special_stage_prev_anim_frame).w,d0
		beq.s	locK_8876
		move.b	d0,(Special_stage_prev_anim_frame).w
		lsl.w	#3,d0
		movea.l	(a1,d0.w),a3
		lea	$10E(a3),a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$19E,VRAM,WRITE),(VDP_control_port).l	; VRAM write $C19E
		moveq	#$A-1,d1
; loc3_790C:
locK_884A:
		move.w	(a1)+,(a6)
		dbf	d1,locK_884A
		lea	$140(a3),a3
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$200,VRAM,WRITE),d0		; VRAM write $C200
		moveq	#$28-1,d1
		moveq	#$18-1,d2
		move.l	#$80<<16,d4
; loc3_7926:
locK_8864:
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		move.w	d1,d3
; loc3_792C:
locK_886A:
		move.w	(a3)+,(a6)
		dbf	d3,locK_886A
		add.l	d4,d0
		dbf	d2,locK_8864
; loc3_7938:
locK_8876:
		tst.b	(Special_stage_sphere_HUD_flag).w
		beq.s	locK_8890
		move.b	#0,(Special_stage_sphere_HUD_flag).w
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$086,VRAM,WRITE),d0	; VRAM write $C086
		move.w	(Special_stage_spheres_left).w,d1
		bsr.w	Draw_SSNum
; loc3_7952:
locK_8890:
		tst.b	(Special_stage_extra_life_flags).w
		bpl.s	locretK_88B4
		bclr	#7,(Special_stage_extra_life_flags).w
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$0BE,VRAM,WRITE),d0	; VRAM write $C0BE
		move.w	(Special_stage_ring_count).w,d1
	if ~~Sonic3_Alone
		tst.b	(Blue_spheres_stage_flag).w
		beq.s	locK_88B0
		move.w	(Special_stage_rings_left).w,d1

locK_88B0:
	endif
		bsr.w	Draw_SSNum
; locret3_796C:
locretK_88B4:
		rts
; End of function Update_SSMap

; ---------------------------------------------------------------------------

SS_Pal_Map_Ptrs:
	if Sonic3_Alone
		dc.l MapUnc_SStageLayout
		dc.l Pal_SStage_1
		dc.l MapUnc_SStageLayout+$8C0
		dc.l Pal_SStage_1
		dc.l MapUnc_SStageLayout
		dc.l Pal_SStage_2
		dc.l MapUnc_SStageLayout+$8C0
		dc.l Pal_SStage_2
		dc.l MapUnc_SStageLayout
		dc.l Pal_SStage_3
		dc.l MapUnc_SStageLayout+$8C0
		dc.l Pal_SStage_3
		dc.l MapUnc_SStageLayout
		dc.l Pal_SStage_4
		dc.l MapUnc_SStageLayout+$8C0
		dc.l Pal_SStage_4
		dc.l MapUnc_SStageLayout
		dc.l Pal_SStage_5
		dc.l MapUnc_SStageLayout+$8C0
		dc.l Pal_SStage_5
		dc.l MapUnc_SStageLayout
		dc.l Pal_SStage_6
		dc.l MapUnc_SStageLayout+$8C0
		dc.l Pal_SStage_6
		dc.l MapUnc_SStageLayout
		dc.l Pal_SStage_7
		dc.l MapUnc_SStageLayout+$8C0
		dc.l Pal_SStage_7
		dc.l MapUnc_SStageLayout
		dc.l Pal_SStage_8
		dc.l MapUnc_SStageLayout+$8C0
		dc.l Pal_SStage_8
		dc.l MapUnc_SStageLayout+$4600
		dc.l Pal_SStage_1
		dc.l MapUnc_SStageLayout+$3D40
		dc.l Pal_SStage_1
		dc.l MapUnc_SStageLayout+$3480
		dc.l Pal_SStage_1
		dc.l MapUnc_SStageLayout+$2BC0
		dc.l Pal_SStage_1
		dc.l MapUnc_SStageLayout+$2300
		dc.l Pal_SStage_1
		dc.l MapUnc_SStageLayout+$1A40
		dc.l Pal_SStage_1
		dc.l MapUnc_SStageLayout+$1180
		dc.l Pal_SStage_1
Pal_SStage_Main:
		binclude "General/Special Stage/Palettes/Main.bin"
		even
Pal_SStage_1:
		binclude "General/Special Stage/Palettes/3-1.bin"
		even
Pal_SStage_2:
		binclude "General/Special Stage/Palettes/3-2.bin"
		even
Pal_SStage_3:
		binclude "General/Special Stage/Palettes/3-3.bin"
		even
Pal_SStage_4:
		binclude "General/Special Stage/Palettes/3-4.bin"
		even
Pal_SStage_5:
		binclude "General/Special Stage/Palettes/3-5.bin"
		even
Pal_SStage_6:
		binclude "General/Special Stage/Palettes/3-6.bin"
		even
Pal_SStage_7:
		binclude "General/Special Stage/Palettes/3-7.bin"
		even
Pal_SStage_8:
		binclude "General/Special Stage/Palettes/3-8 S3.bin"
		even
	else
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_2
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_2
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_3
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_3
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_4
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_4
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_5
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_5
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_6
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_6
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_7
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_7
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_8
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_8
		dc.l RAM_start+$9B00
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$9240
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$8980
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$80C0
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$7800
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$6F40
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$6680
		dc.l Pal_SStage_3_1
Pal_SStage_Main:
		binclude "General/Special Stage/Palettes/Main.bin"
		even
Pal_SStage_Knux:
		binclude "General/Special Stage/Palettes/Knux Patch.bin"
		even
Pal_SStage_3_1:
		binclude "General/Special Stage/Palettes/3-1.bin"
		even
Pal_SStage_3_2:
		binclude "General/Special Stage/Palettes/3-2.bin"
		even
Pal_SStage_3_3:
		binclude "General/Special Stage/Palettes/3-3.bin"
		even
Pal_SStage_3_4:
		binclude "General/Special Stage/Palettes/3-4.bin"
		even
Pal_SStage_3_5:
		binclude "General/Special Stage/Palettes/3-5.bin"
		even
Pal_SStage_3_6:
		binclude "General/Special Stage/Palettes/3-6.bin"
		even
Pal_SStage_3_7:
		binclude "General/Special Stage/Palettes/3-7.bin"
		even
Pal_SStage_3_8:
		binclude "General/Special Stage/Palettes/3-8.bin"
		even
Pal_SStage_K_1:
		binclude "General/Special Stage/Palettes/K-1.bin"
		even
Pal_SStage_K_2:
		binclude "General/Special Stage/Palettes/K-2.bin"
		even
Pal_SStage_K_3:
		binclude "General/Special Stage/Palettes/K-3.bin"
		even
Pal_SStage_K_4:
		binclude "General/Special Stage/Palettes/K-4.bin"
		even
Pal_SStage_K_5:
		binclude "General/Special Stage/Palettes/K-5.bin"
		even
Pal_SStage_K_6:
		binclude "General/Special Stage/Palettes/K-6.bin"
		even
Pal_SStage_K_7:
		binclude "General/Special Stage/Palettes/K-7.bin"
		even
Pal_SStage_K_8:
		binclude "General/Special Stage/Palettes/K-8.bin"
		even
	endif

; =============== S U B R O U T I N E =======================================


Draw_SSNum:
		lea	(SSNum_Precision).l,a2
		moveq	#3-1,d6
		lea	MapUnc_SSNum(pc),a1
; loc3_7BE2:
locK_8C6A:
		moveq	#0,d2
		move.w	(a2)+,d3
; loc3_7BE6:
locK_8C6E:
		sub.w	d3,d1
		bcs.s	locK_8C76
		addq.w	#1,d2
		bra.s	locK_8C6E
; ---------------------------------------------------------------------------
; loc3_7BEE:
locK_8C76:
		add.w	d3,d1
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		add.w	d2,d2
		add.w	d2,d2
		lea	(a1,d2.w),a3
		move.l	(a3),(a6)
		addi.l	#$80<<16,d0
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		move.l	$28(a3),(a6)
		addi.l	#$80<<16,d0
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		move.l	$50(a3),(a6)
		subi.l	#$FC<<16,d0
		dbf	d6,locK_8C6A
		rts
; End of function Draw_SSNum

; ---------------------------------------------------------------------------

SSNum_Precision:
		dc.w 100
		dc.w 10
		dc.w 1
MapUnc_SSNum:
		binclude "General/Special Stage/Uncompressed Map/HUD Numbers.bin"
		even
MapUnc_SSNum000:
		binclude "General/Special Stage/Uncompressed Map/HUD.bin"
		even

; =============== S U B R O U T I N E =======================================

; Create_New_Sprite2:
AllocateObjectAfterCurrent_SpecialStage:
		movea.l	a0,a1
		move.w	#Object_RAM_end-object_size,d0
		sub.w	a0,d0
		lsr.w	#6,d0
		move.b	.lookup(pc,d0.w),d0
		bmi.s	.return

.loop:
		lea	next_object(a1),a1
		tst.l	(a1)
		dbeq	d0,.loop

.return:
		rts

.lookup:
.a		set	Object_RAM-object_size*2	; Oddly, this does too many object slots.
.b		set	Object_RAM_end-object_size
.c		set	.b				; begin from bottom of array and decrease backwards
		; There's a mistake here: this division should be rounded up,
		; otherwise the first object slot might not get an entry.
		; In this case, the aforementioned surplus entries counteract this problem.
		rept	(.b-.a)/$40			; repeat for all slots, minus exception
.c		set	.c-$40				; address for previous $40 (also skip last part)
		dc.b	(.b-.c-1)/object_size-1		; write possible slots according to object_size division + hack + dbf hack
		endm
		even
; End of function AllocateObjectAfterCurrent_SpecialStage

; ---------------------------------------------------------------------------

Obj_SStage_8DF8:
		move.b	#$80,width_pixels(a0)
		move.b	#$80,height_pixels(a0)
		move.w	#0,priority(a0)
		move.l	#Map_SSIcons,mappings(a0)
		move.w	#make_art_tile(ArtTile_SStage_Icons,2,1),art_tile(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$94,y_pos(a0)
		move.l	#locK_8E2A,(a0)
; loc3_7DA2:
locK_8E2A:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Map_SSIcons:
		include "General/Special Stage/Map - Icons.asm"
; ---------------------------------------------------------------------------

Obj_SStage_8E40:
		jsr	(AllocateObjectAfterCurrent_SpecialStage).l
		bne.w	locK_8E5C
		move.l	#locK_8E5C,(a1)
		bset	#0,status(a1)
		move.b	#1,mapping_frame(a1)
; loc3_7DD4:
locK_8E5C:
		move.b	#$80,width_pixels(a0)
		move.b	#$80,height_pixels(a0)
		move.w	#0,priority(a0)
		move.l	#Map_GetBlueSpheres,mappings(a0)
		move.w	#make_art_tile(ArtTile_SStage_GetBlueSpheres,1,1),art_tile(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$E8,y_pos(a0)
		move.w	#3*60,$32(a0)
		move.l	#locK_8E94,(a0)
; loc3_7E0C:
locK_8E94:
		tst.w	$32(a0)
		beq.s	locK_8EA4
		subq.w	#1,$32(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_7E1C:
locK_8EA4:
		cmpi.w	#$C0,$30(a0)
		blo.s	locK_8ECA
		move.l	#locK_8EEC,(a0)
		addq.b	#2,mapping_frame(a0)
		tst.w	(Special_stage_velocity).w
		bne.s	locK_8ED0
		move.b	#1,(Special_stage_advancing).w
	if ~~Sonic3_Alone
		move.b	#1,(Special_stage_started).w
	endif
		bra.s	locK_8ED0
; ---------------------------------------------------------------------------
; loc3_7E3C:
locK_8ECA:
		addi.w	#$10,$30(a0)
; loc3_7E42:
locK_8ED0:
		move.w	$30(a0),d0
		btst	#0,status(a0)
		bne.s	locK_8EDE
		neg.w	d0
; loc3_7E50:
locK_8EDE:
		addi.w	#$120,d0
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_7E5E:
locK_8EEC:
		tst.w	(Special_stage_rings_left).w
		beq.s	locK_8EF4
		rts
; ---------------------------------------------------------------------------
; loc3_7E66:
locK_8EF4:
		subi.w	#$10,$30(a0)
		bne.s	locK_8F08
		move.l	#locK_8F24,(a0)
		move.w	#180,$32(a0)
; loc3_7E7A:
locK_8F08:
		move.w	$30(a0),d0
		btst	#0,status(a0)
		bne.s	locK_8F16
		neg.w	d0
; loc3_7E88:
locK_8F16:
		addi.w	#$120,d0
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_7E96:
locK_8F24:
		tst.w	$32(a0)
		beq.s	locK_8F34
		subq.w	#1,$32(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_7EA6:
locK_8F34:
		cmpi.w	#$C0,$30(a0)
		bhs.s	locK_8F42
		addi.w	#$10,$30(a0)
; loc3_7EB4:
locK_8F42:
		move.w	$30(a0),d0
		btst	#0,status(a0)
		bne.s	locK_8F50
		neg.w	d0
; loc3_7EC2:
locK_8F50:
		addi.w	#$120,d0
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Map_GetBlueSpheres:
		include "General/Special Stage/Map - Get Blue Spheres.asm"
; ---------------------------------------------------------------------------

Obj_SStage_8FAA:
		move.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$200,priority(a0)
		move.l	#Map_SStageSonic,mappings(a0)
		move.w	#make_art_tile(ArtTile_SStage_Player1,0,1),art_tile(a0)
	if Sonic3_Alone
		cmpi.w	#2,(Player_option).w
	else
		cmpi.w	#2,(Player_mode).w
	endif
		bne.s	locK_8FFA
		move.l	#Map_SStageTails,mappings(a0)
		move.w	#make_art_tile(ArtTile_SStage_Player2,1,1),art_tile(a0)
		jsr	(AllocateObjectAfterCurrent_SpecialStage).l
		bne.w	locK_8FFA
		move.l	#Obj_SStage_9444,(a1)
		move.w	a0,$3E(a1)
; loc3_7F6C:
locK_8FFA:
	if ~~Sonic3_Alone
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_9010
		move.l	#Map_SStageKnuckles,mappings(a0)
		move.w	#make_art_tile(ArtTile_SStage_Player1,0,1),art_tile(a0)

locK_9010:
	endif
		move.w	#$A0,$30(a0)
		move.w	#$70,$32(a0)
		move.w	#0,$34(a0)
		move.w	#$F800,$36(a0)
		move.w	#0,$38(a0)
		bsr.w	subK_950C
		move.b	#$FF,$3A(a0)
		move.l	#locK_903E,(a0)
; loc3_7F9A:
locK_903E:
		tst.w	(Special_stage_rate_timer).w
		beq.s	locK_907E
		subq.w	#1,(Special_stage_rate_timer).w
		bne.s	locK_907E
		move.w	#30*60,(Special_stage_rate_timer).w
	if ~~Sonic3_Alone
		tst.b	(Blue_spheres_stage_flag).w
		beq.s	locK_905C
		move.w	#45*60,(Special_stage_rate_timer).w

locK_905C:
	endif
		cmpi.w	#$2000,(Special_stage_rate).w
		beq.s	locK_907E
		addi.w	#$400,(Special_stage_rate).w
		move.b	(Special_stage_rate).w,d0
		subi.b	#$20,d0
		neg.b	d0
		add.b	d0,d0
		addq.b	#8,d0
		jsr	(Change_Music_Tempo).l
; loc3_7FCE:
locK_907E:
		bsr.w	subK_9580
		moveq	#$C,d0
		move.w	(Special_stage_velocity).w,d1
		beq.s	locK_90A8
		asr.w	#5,d1
		add.w	d1,anim_frame_timer(a0)
		moveq	#0,d0
		move.b	anim_frame_timer(a0),d0
		bpl.s	locK_909E
		addi.b	#$C,d0
		bra.s	locK_90A8
; ---------------------------------------------------------------------------
; loc3_7FEE:
locK_909E:
		cmpi.b	#$C,d0
		blo.s	locK_90A8
		subi.b	#$C,d0
; loc3_7FF8:
locK_90A8:
		move.b	d0,anim_frame_timer(a0)
		lea	(byteK_91E8).l,a1
		tst.b	(Special_stage_jumping).w
		bpl.s	locK_90CC
		lea	(byteK_91F6).l,a1
		move.w	(Special_stage_velocity).w,d1
		bne.s	locK_90CC
		move.b	(Level_frame_counter+1).w,d0
		andi.w	#3,d0
; loc3_801C:
locK_90CC:
		move.b	(a1,d0.w),mapping_frame(a0)
		tst.b	(Special_stage_clear_routine).w
		bne.s	locK_90EE
		move.w	(Ctrl_1).w,d0
		andi.w	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	locK_90EE
		tst.b	(Special_stage_jumping).w
		bmi.s	locK_90EE
		move.b	#1,(Special_stage_jumping).w
; loc3_803E:
locK_90EE:
		move.b	(Special_stage_angle).w,d0
		andi.b	#$3F,d0
		bne.w	locK_9152
		cmpi.b	#1,(Special_stage_jumping).w
		bne.s	locK_911E
		move.l	#-$100000,$40(a0)
		move.b	#$80,(Special_stage_jumping).w
		move.b	#0,(Special_stage_turning).w
		moveq	#signextendB(sfx_Jump),d0
		jsr	(Play_SFX).l
; loc3_806E:
locK_911E:
		tst.b	(Special_stage_jumping).w
		bpl.s	locK_9152
		move.l	$3C(a0),d0
		add.l	$40(a0),d0
		bmi.s	locK_9138
		moveq	#0,d0
		move.l	d0,$40(a0)
		move.b	d0,(Special_stage_jumping).w
; loc3_8088:
locK_9138:
		move.w	(Special_stage_rate).w,d1
		ext.l	d1
		lsl.l	#4,d1
		add.l	d1,$40(a0)
		move.l	d0,$3C(a0)
		swap	d0
		addi.w	#-$800,d0
		move.w	d0,$36(a0)
; loc3_80A2:
locK_9152:
		bsr.w	subK_950C
		bsr.w	subK_953E
		jsr	(Draw_Sprite).l
		lea	(PLC_SStageSonic).l,a2
		move.l	#ArtUnc_SStageSonic,d6
		move.w	#tiles_to_bytes(ArtTile_SStage_Player1),d4
	if Sonic3_Alone
		cmpi.w	#2,(Player_option).w
	else
		cmpi.w	#2,(Player_mode).w
	endif
		bne.s	locK_918A
		lea	(PLC_SStageTails).l,a2
		move.l	#ArtUnc_SStageTails,d6
		move.w	#tiles_to_bytes(ArtTile_SStage_Player2),d4
	if ~~Sonic3_Alone
		bra.s	SStage_PLCLoad_91A2
; ---------------------------------------------------------------------------
	endif
; loc3_80D8:
locK_918A:
	if ~~Sonic3_Alone
		cmpi.w	#3,(Player_mode).w
		bne.s	SStage_PLCLoad_91A2
		lea	(PLC_SStageKnuckles).l,a2
		move.l	#ArtUnc_SStageKnuckles,d6
		move.w	#tiles_to_bytes(ArtTile_SStage_Player1),d4
	endif

SStage_PLCLoad_91A2:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		cmp.b	$3A(a0),d0
		beq.s	locretK_91E6
		move.b	d0,$3A(a0)
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locretK_91E6
; loc3_80F4:
locK_91BE:
		moveq	#0,d1
		move.w	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		add.l	d6,d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		dbf	d5,locK_91BE

locretK_91E6:
		rts
; ---------------------------------------------------------------------------
; byte3_811E:
byteK_91E8:
		dc.b    2,   6,   7,   8,   7,   6,   2,   3,   4,   5,   4,   3,   1,   0
; byte3_812C:
byteK_91F6:
		dc.b    9,  $B,  $A,  $B,   9,  $B,  $A,  $B,   9,  $B,  $A,  $B,  $B,   0
; byte3_813A:
byteK_9204:
		dc.b    9,  $A,  $B,   9,  $A,  $B,   9,  $A,  $B,   9,  $A,  $B,  $B,   0
		even
; ---------------------------------------------------------------------------

Obj_SStage_9212:
		move.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$180,priority(a0)
		move.l	#Map_SStageTails,mappings(a0)
		move.w	#make_art_tile(ArtTile_SStage_Player2,1,1),art_tile(a0)
		move.w	#$A0,$30(a0)
		move.w	#$70,$32(a0)
		move.w	#0,$34(a0)
		move.w	#-$800,$36(a0)
		move.w	#-$20,$38(a0)
		move.b	#$FF,$3A(a0)
		bsr.w	subK_93E2
		jsr	(AllocateObjectAfterCurrent_SpecialStage).l
		bne.w	locK_9274
		move.l	#Obj_SStage_9444,(a1)
		move.w	a0,$3E(a1)
; loc3_81AA"
locK_9274:
		move.l	#locK_927A,(a0)
; loc3_81B0:
locK_927A:
		moveq	#$C,d0
		move.w	(Special_stage_velocity).w,d1
		beq.s	locK_92A0
		asr.w	#5,d1
		add.w	d1,anim_frame_timer(a0)
		moveq	#0,d0
		move.b	anim_frame_timer(a0),d0
		bpl.s	locK_9296
		addi.b	#$C,d0
		bra.s	locK_92A0
; ---------------------------------------------------------------------------
; loc3_81CC:
locK_9296:
		cmpi.b	#$C,d0
		blo.s	locK_92A0
		subi.b	#$C,d0
; loc3_81D6:
locK_92A0:
		move.b	d0,anim_frame_timer(a0)
		lea	(byteK_91E8).l,a1
		tst.b	(Special_stage_jumping_P2).w
		beq.s	locK_92C4
		lea	(byteK_9204).l,a1
		move.w	(Special_stage_velocity).w,d1
		bne.s	locK_92C4
		move.b	(Level_frame_counter+1).w,d0
		andi.w	#3,d0
; loc3_81FA:
locK_92C4:
		move.b	(a1,d0.w),mapping_frame(a0)
	if ~~Sonic3_Alone
		bsr.w	subK_9402
		cmpi.b	#5,$44(a0)
		bne.s	locK_9304
		tst.b	(Special_stage_clear_routine).w
		bne.s	locK_9304
		tst.b	(Special_stage_jumping_P2).w
		bmi.s	locK_9304
		move.b	(Special_stage_angle).w,d0
		andi.b	#$3F,d0
		bne.w	locK_9304
		move.l	#$FFE80000,$40(a0)
		move.b	#$81,(Special_stage_jumping_P2).w
		moveq	#signextendB(sfx_Spring),d0
		jsr	(Play_SFX).l

locK_9304:
	endif
		bsr.w	subK_937C
		andi.w	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	locK_932A
		tst.b	(Special_stage_jumping_P2).w
		bne.s	locK_932A
		move.l	#$FFF00000,$40(a0)
	if Sonic3_Alone
		move.b	#1,(Special_stage_jumping_P2).w
	else
		move.b	#$80,(Special_stage_jumping_P2).w
	endif
		moveq	#signextendB(sfx_Jump),d0
		jsr	(Play_SFX).l
; loc3_8226:
locK_932A:
	if ~~Sonic3_Alone
		tst.b	(Special_stage_jumping_P2).w
		bpl.s	locK_935E
	endif
		move.l	$3C(a0),d0
		add.l	$40(a0),d0
		bmi.s	locK_9344
		moveq	#0,d0
		move.l	d0,$40(a0)
		move.b	d0,(Special_stage_jumping_P2).w
; loc3_823A:
locK_9344:
		move.w	(Special_stage_rate).w,d1
		ext.l	d1
		lsl.l	#4,d1
		add.l	d1,$40(a0)
		move.l	d0,$3C(a0)
		swap	d0
		addi.w	#-$800,d0
		move.w	d0,$36(a0)

locK_935E:
		bsr.w	subK_953E
		jsr	(Draw_Sprite).l
		lea	(PLC_SStageTails).l,a2
		move.l	#ArtUnc_SStageTails,d6
		move.w	#tiles_to_bytes(ArtTile_SStage_Player2),d4
		bra.w	SStage_PLCLoad_91A2

; =============== S U B R O U T I N E =======================================

; sub3_8272:
subK_937C:
		move.w	(Pos_table_index).w,d0
		lea	(Pos_table).w,a1
		lea	(a1,d0.w),a1
		move.w	(Ctrl_1).w,(a1)
		move.b	(Special_stage_jumping).w,2(a1)
		addq.b	#4,(Pos_table_index+1).w
		move.b	(Ctrl_2_held).w,d0
		andi.b	#button_up_mask|button_down_mask|button_left_mask|button_right_mask|button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	locK_93A6
		move.w	#600,(Tails_CPU_idle_timer).w
; loc3_829C:
locK_93A6:
		tst.w	(Tails_CPU_idle_timer).w
		beq.s	locK_93B6
		subq.w	#1,(Tails_CPU_idle_timer).w
		move.w	(Ctrl_2).w,d0
		rts
; ---------------------------------------------------------------------------
; loc3_82AC:
locK_93B6:
		lea	(Pos_table).w,a1
	if Sonic3_Alone
		move.w	#8,d1
		lsl.b	#2,d1
		addq.b	#4,d1
	else
		move.w	#4,d1
		lsl.b	#2,d1
	endif
		move.w	(Pos_table_index).w,d0
		sub.b	d1,d0
	if Sonic3_Alone
		move.b	2(a1,d0.w),d1
	else
		move.b	2(a1,d0.w),d2
		subq.b	#4,d0
		move.b	2(a1,d0.w),d1
	endif
		moveq	#0,d0
	if ~~Sonic3_Alone
		cmpi.b	#-$7F,d2
		beq.s	locretK_93E0
	endif
		tst.b	d1
		bpl.s	locretK_93E0
		move.w	#$70,d0
; locret3_82CC:
locretK_93E0:
		rts
; End of function subK_937C


; =============== S U B R O U T I N E =======================================

; sub3_82CE:
subK_93E2:
		lea	(Pos_table).w,a2
		move.w	#bytesToLcnt(Pos_table_end-Pos_table),d0
; loc3_82D6:
locK_93EA:
		move.l	#0,(a2)+
		dbf	d0,locK_93EA
		move.w	#0,(Pos_table_index).w
		move.w	#0,(Tails_CPU_idle_timer).w
		rts
; End of function subK_93E2

	if ~~Sonic3_Alone
; =============== S U B R O U T I N E =======================================


subK_9402:
		lea	(SStage_layout_buffer+$100).w,a1
		move.w	(Special_stage_X_pos).w,d0
		addi.w	#$80,d0
		lsr.w	#8,d0
		andi.w	#$1F,d0
		move.w	(Special_stage_Y_pos).w,d1
		addi.w	#$80,d1
		lsr.w	#8,d1
		andi.w	#$1F,d1
		lsl.w	#5,d1
		or.b	d0,d1
		lea	(a1,d1.w),a1
		lea	$44(a0),a2
		move.b	1(a2),(a2)
		move.b	2(a2),1(a2)
		move.b	3(a2),2(a2)
		move.b	(a1),3(a2)
		rts
; End of function subK_9402
	endif

; ---------------------------------------------------------------------------

Obj_SStage_9444:
		move.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$100,priority(a0)
		move.l	#Map_SStageTailstails,mappings(a0)
		move.w	#make_art_tile(ArtTile_SStage_Player2_Tail,1,1),art_tile(a0)
		move.w	#$A0,$30(a0)
		move.w	#$70,$32(a0)
		move.b	#-1,$3A(a0)
		move.b	#1,mapping_frame(a0)
		move.l	#locK_9488,(a0)
; loc3_8332:
locK_9488:
		movea.w	$3E(a0),a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		move.w	#$2AAA,d0
		move.w	(Special_stage_velocity).w,d1
		bmi.s	locK_94A4
		add.w	d1,d0
; loc3_834E:
locK_94A4:
		add.w	d0,anim_frame_timer(a0)
		bcc.s	locK_94BC
		move.b	mapping_frame(a0),d0
		addq.b	#1,d0
		cmpi.b	#$F,d0
		blo.s	locK_94B8
		moveq	#1,d0
; loc3_8362:
locK_94B8:
		move.b	d0,mapping_frame(a0)
; loc3_8366:
locK_94BC:
		jsr	(Draw_Sprite).l
		lea	(PLC_SStageTailstails).l,a2
		move.l	#ArtUnc_SStageTailstails,d6
		move.w	#tiles_to_bytes(ArtTile_SStage_Player2_Tail),d4
		bra.w	SStage_PLCLoad_91A2

	if Sonic3_Alone
; ---------------------------------------------------------------------------

Obj_SStage_8380:
		move.w	#0,$34(a0)
		move.w	#$F800,$36(a0)
		move.w	#0,$38(a0)

loc3_8392:
		move.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$380,priority(a0)
		move.l	#Map_SStageShadow,mappings(a0)
		move.w	#make_art_tile(ArtTile_SStage_Shadow,3,1),art_tile(a0)
		move.w	#$A0,$30(a0)
		move.w	#$70,$32(a0)
		move.b	#-1,$3A(a0)
		bsr.w	subK_953E
		move.l	#loc3_83D6,(a0)
		rts
; ---------------------------------------------------------------------------

loc3_83D6:
		tst.b	(Special_stage_fade_timer).w
		beq.s	loc3_83DE
		rts
; ---------------------------------------------------------------------------

loc3_83DE:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_SStage_83E4:
		move.w	#0,$34(a0)
		move.w	#$F800,$36(a0)
		move.w	#$FFE0,$38(a0)
		bra.s	loc3_8392
; ---------------------------------------------------------------------------

Map_SStageShadow:
		include "General/Special Stage/Map - Shadow.asm"
	else
; =============== S U B R O U T I N E =======================================


Draw_SSShadows:
		lea	(wordK_94FC).l,a3
		move.w	(a3)+,(a6)+
		move.b	(a3)+,(a6)+
		addq.w	#1,a3
		addq.w	#1,a6
		move.w	(a3)+,(a6)+
		move.w	(a3)+,(a6)+
		tst.w	(Player_mode).w
		bne.s	locretK_94FA
		move.w	(a3)+,(a6)+
		move.b	(a3)+,(a6)+
		addq.w	#1,a3
		addq.w	#1,a6
		move.w	(a3)+,(a6)+
		move.w	(a3)+,(a6)+

locretK_94FA:
		rts
; End of function Draw_SSShadows

; ---------------------------------------------------------------------------
wordK_94FC:
		dc.w $116, $F0A, make_art_tile(ArtTile_SStage_Shadow,3,1), $110
		dc.w $127, $F0B, make_art_tile(ArtTile_SStage_Shadow,3,1), $110
	endif

; =============== S U B R O U T I N E =======================================

; sub3_8402:
subK_950C:
		move.w	(SStage_scalar_index_2).w,d0
		lea	(SStage_scalar_result_2).w,a1
		bsr.w	GetScalars2
		move.w	(SStage_scalar_index_1).w,d0
		lea	(SStage_scalar_result_1).w,a1
		bsr.w	GetScalars2
		move.w	(SStage_scalar_index_0).w,d0
		lea	(SStage_scalar_result_0).w,a1
		bsr.w	GetScalars2
		move.w	#$E0,d0
		lea	(SStage_scalar_result_3).w,a1
		bsr.w	GetScalars2
		rts
; End of function subK_950C


; =============== S U B R O U T I N E =======================================

; sub3_8434:
subK_953E:
		move.w	$34(a0),d1
		move.w	$36(a0),d2
		move.w	$38(a0),d0
		bsr.w	subK_A1DC
		bsr.w	subK_A1B2
		bsr.w	subK_A188
		addi.w	#$100,d0
		addi.w	#$980,d2
		bsr.w	subK_A206
		ext.l	d1
		lsl.l	#8,d1
		divs.w	d0,d1
		ext.l	d2
		lsl.l	#8,d2
		divs.w	d0,d2
		add.w	$30(a0),d1
		move.w	d1,x_pos(a0)
		add.w	$32(a0),d2
		move.w	d2,y_pos(a0)
		rts
; End of function subK_953E


; =============== S U B R O U T I N E =======================================

; sub3_8476:
subK_9580:
		tst.b	(Special_stage_fade_timer).w
		beq.s	locK_95AE
		cmpi.b	#$61,(Special_stage_fade_timer).w
		bhs.s	locK_959A
		moveq	#8,d1
		add.b	d1,(Special_stage_angle).w
		addq.b	#1,(Special_stage_fade_timer).w
		rts
; ---------------------------------------------------------------------------
; loc3_8490:
locK_959A:
		move.w	(Special_stage_X_pos).w,d0
		or.w	(Special_stage_Y_pos).w,d0
		andi.w	#$E0,d0
		beq.s	locK_95AE
		move.b	#0,(Special_stage_fade_timer).w
; loc3_84A4:
locK_95AE:
		move.w	(Special_stage_X_pos).w,d3
		btst	#6,(Special_stage_angle).w
		bne.s	locK_95BE
		move.w	(Special_stage_Y_pos).w,d3
; loc3_84B4:
locK_95BE:
		moveq	#0,d2
		move.b	(Special_stage_turning).w,d1
		beq.s	locK_95F4
		andi.w	#$E0,d3
		bne.s	locK_95F4
		tst.b	(Special_stage_jumping).w
		bmi.s	locK_9600
		add.b	d1,(Special_stage_angle).w
		move.b	(Special_stage_angle).w,d0
		andi.b	#$3F,d0
		bne.w	locretK_972C
		move.b	#0,(Special_stage_turning).w
	if Sonic3_Alone
		move.b	#0,(Special_stage_bumper_lock).w
	endif
		tst.w	(Special_stage_velocity).w
		beq.s	locK_95F4
		move.b	#1,(Special_stage_turn_lock).w
; loc3_84F0:
locK_95F4:
		andi.w	#$E0,d3
		beq.s	locK_9600
		move.b	#0,(Special_stage_turn_lock).w
; loc3_84FC:
locK_9600:
		move.b	(Ctrl_1).w,d1
		move.w	(Special_stage_velocity).w,d2
		tst.b	(Special_stage_clear_routine).w
		bne.w	locK_96FA
		tst.b	(Special_stage_bumper_lock).w
		bne.s	locK_9658
		btst	#button_up,d1
		beq.s	locK_9628
		move.b	#1,(Special_stage_advancing).w
	if ~~Sonic3_Alone
		move.b	#1,(Special_stage_started).w
	endif
; loc3_851E:
locK_9628:
		tst.b	(Special_stage_advancing).w
	if Sonic3_Alone
		beq.s	locK_9658
	else
		bne.s	locK_964A
		tst.b	(Special_stage_started).w
		beq.s	locK_9658
		tst.w	d2
		bpl.s	locK_964A
		move.w	(Special_stage_rate).w,d3
		neg.w	d3
		subi.w	#$200,d2
		cmp.w	d3,d2
		bgt.s	locK_9658
		move.w	d3,d2
		bra.s	locK_9658
; ---------------------------------------------------------------------------

locK_964A:
	endif
		move.w	(Special_stage_rate).w,d3
		addi.w	#$200,d2
		cmp.w	d3,d2
		blt.s	locK_9658
		move.w	d3,d2
; loc3_8532:
locK_9658:
		tst.b	(Special_stage_turn_lock).w
		bne.s	locK_9676
		btst	#button_left,d1
		beq.s	locK_966A
		move.b	#4,(Special_stage_turning).w
; loc3_8544:
locK_966A:
		btst	#button_right,d1
		beq.s	locK_9676
		move.b	#-4,(Special_stage_turning).w
; loc3_8550:
locK_9676:
		move.w	d2,(Special_stage_velocity).w
		tst.b	(Special_stage_bumper_lock).w
		beq.s	locK_96FA
		move.w	(Special_stage_X_pos).w,d0
		btst	#6,(Special_stage_angle).w
		bne.s	locK_9690
		move.w	(Special_stage_Y_pos).w,d0
; loc3_856A:
locK_9690:
		andi.w	#$E0,d0
		bne.s	locK_96D4
		move.w	(Special_stage_X_pos).w,d0
		addi.w	#$80,d0
		lsr.w	#8,d0
		andi.w	#$1F,d0
		move.w	(Special_stage_Y_pos).w,d1
		addi.w	#$80,d1
		lsr.w	#8,d1
		andi.w	#$1F,d1
		lsl.w	#5,d1
		or.b	d0,d1
		cmp.w	(Special_stage_interact).w,d1
		beq.s	locK_96D4
		move.b	#0,(Special_stage_bumper_lock).w
		move.w	(Special_stage_rate).w,d2
		tst.w	(Special_stage_velocity).w
		bmi.s	locK_96CE
		neg.w	d2
; loc3_85A8:
locK_96CE:
		move.w	d2,(Special_stage_velocity).w
		rts
; ---------------------------------------------------------------------------
; loc3_85AE:
locK_96D4:
		move.w	(Special_stage_velocity).w,d2
		bne.s	locK_96F8
		move.b	#0,(Special_stage_bumper_lock).w
		move.b	#1,(Special_stage_advancing).w
		move.w	(Special_stage_rate).w,d2
		tst.w	(Special_stage_velocity).w
		bmi.s	locK_96F2
		neg.w	d2
; loc3_85CC:
locK_96F2:
		move.w	d2,(Special_stage_velocity).w
		bra.s	locK_96FA
; ---------------------------------------------------------------------------
; loc3_85D2:
locK_96F8:
		neg.w	d2
; loc3_85D4:
locK_96FA:
	if ~~Sonic3_Alone
		cmpi.b	#$81,(Special_stage_jumping).w
		bne.s	locK_9704
		add.w	d2,d2

locK_9704:
	endif
		move.b	(Special_stage_angle).w,d0
		jsr	(GetSineCosine).l
		muls.w	d2,d0
		muls.w	d2,d1
		swap	d0
		sub.w	d0,(Special_stage_X_pos).w
		swap	d1
		sub.w	d1,(Special_stage_Y_pos).w
		tst.b	(Special_stage_jumping).w
		bmi.s	locretK_972C
		tst.b	(Special_stage_clear_routine).w
		bne.s	locretK_972C
		bsr.s	subK_972E
; locret3_85FC:
locretK_972C:
		rts
; End of function subK_9580


; =============== S U B R O U T I N E =======================================

; sub3_85FE:
subK_972E:
	if Sonic3_Alone
		lea	(Level_layout_header).w,a1
	else
		lea	(SStage_layout_buffer+$100).w,a1
	endif
		move.w	(Special_stage_X_pos).w,d0
		addi.w	#$80,d0
		lsr.w	#8,d0
		andi.w	#$1F,d0
		move.w	(Special_stage_Y_pos).w,d1
		addi.w	#$80,d1
		lsr.w	#8,d1
		andi.w	#$1F,d1
		lsl.w	#5,d1
		or.b	d0,d1
		lea	(a1,d1.w),a1
		move.b	(a1),d2
		beq.w	locretK_98AE
		cmpi.b	#1,d2
		bne.s	locK_97AA
		move.w	(Special_stage_X_pos).w,d0
		or.w	(Special_stage_Y_pos).w,d0
		andi.w	#$E0,d0
		bne.s	locretK_97A8
		tst.b	(Special_stage_fade_timer).w
		bne.s	locretK_97A8
		move.b	#1,(Special_stage_fade_timer).w
		move.b	#GameMode_SpecialStageResults,(Game_mode).w
	if ~~Sonic3_Alone
		tst.b	(Blue_spheres_stage_flag).w
		beq.s	locK_978E
		move.b	#GameMode_BlueSpheresTitle,(Game_mode).w

locK_978E:
	endif
		tst.b	(Special_bonus_entry_flag).w
		beq.s	locK_97A0
		move.w	(Saved2_zone_and_act).w,(Current_zone_and_act).w
		ori.b	#$80,(Last_star_post_hit).w
; loc3_8664:
locK_97A0:
		moveq	#signextendB(sfx_Goal),d0
		jsr	(Play_SFX).l
; locret3_866C:
locretK_97A8:
		rts
; ---------------------------------------------------------------------------
; loc3_866E:
locK_97AA:
		cmpi.b	#2,d2
		bne.s	locK_97C8
		bsr.w	Find_SStageCollisionResponseSlot
		bne.s	locK_97BE
		move.b	#2,(a2)
		move.l	a1,4(a2)
; loc3_8682:
locK_97BE:
		moveq	#signextendB(sfx_BlueSphere),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------
; loc3_868C:
locK_97C8:
		cmpi.b	#3,d2
		bne.s	locK_97EE
		tst.b	(Special_stage_bumper_lock).w
		bne.s	locK_97EE
		move.w	d1,(Special_stage_interact).w
		move.b	#1,(Special_stage_bumper_lock).w
		move.b	#0,(Special_stage_advancing).w
		moveq	#signextendB(sfx_Bumper),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

locK_97EE:
	if ~~Sonic3_Alone
		cmpi.b	#5,d2
		bne.s	locK_9822
		tst.b	(Special_stage_clear_routine).w
		bne.s	locK_9822
		tst.b	(Special_stage_jumping).w
		bmi.s	locK_9822
		move.b	(Special_stage_angle).w,d0
		andi.b	#$3F,d0
		bne.w	locK_9822
		move.l	#$FFE80000,$40(a0)
		move.b	#$81,(Special_stage_jumping).w
		moveq	#signextendB(sfx_Spring),d0
		jsr	(Play_SFX).l

locK_9822:
	endif
		cmpi.b	#4,d2
	if Sonic3_Alone
		bne.s	locretK_98AE
	else
		bne.w	locretK_98AE
	endif
		bsr.w	Find_SStageCollisionResponseSlot
		bne.s	locK_9838
		move.b	#1,(a2)
		move.l	a1,4(a2)
; loc3_86C6:
locK_9838:
	if ~~Sonic3_Alone
		tst.w	(Special_stage_rings_left).w
		beq.s	locK_984C
	endif
		subq.w	#1,(Special_stage_rings_left).w
		bne.s	locK_984C
		moveq	#signextendB(sfx_Perfect),d0
		jsr	(Play_Music).l
; loc3_86D4:
locK_984C:
		addi.w	#1,(Special_stage_ring_count).w
		bset	#7,(Special_stage_extra_life_flags).w
	if ~~Sonic3_Alone
		moveq	#signextendB(sfx_RingRight),d0
		tst.b	(Blue_spheres_stage_flag).w
		bne.s	locK_98A6
	endif
		cmpi.w	#50,(Special_stage_ring_count).w
		blo.s	locK_987E
		bset	#0,(Special_stage_extra_life_flags).w
		bne.s	locK_987E
		addq.b	#1,(Continue_count).w
		move.w	#signextendB(sfx_Continue),d0
		jmp	(Play_Music).l
; ---------------------------------------------------------------------------
; loc3_86FE:
locK_987E:
		moveq	#signextendB(sfx_RingRight),d0
		cmpi.w	#100,(Special_stage_ring_count).w
		blo.s	locK_98A6
		bset	#1,(Special_stage_extra_life_flags).w
		beq.s	locK_98A0
		cmpi.w	#200,(Special_stage_ring_count).w
		blo.s	locK_98A6
		bset	#2,(Special_stage_extra_life_flags).w
		bne.s	locK_98A6
; loc3_8720:
locK_98A0:
		addq.b	#1,(Life_count).w
		moveq	#signextendB(sfx_RingLoss),d0
; loc3_8726:
locK_98A6:
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------
; locret3_872E:
locretK_98AE:
		rts
; End of function subK_972E

; ---------------------------------------------------------------------------
; word3_8730:
wordK_98B0:
		dc.w    $18
		dc.w      6
		dc.w      1
		dc.w    $1F
		dc.w  $FFFF
		dc.w    $1F
		dc.w      0
		dc.w      0
		dc.w      8
		dc.w      6
		dc.w  $FFFF
		dc.w    $1F
		dc.w  $FFFF
		dc.w    $1F
		dc.w      0
		dc.w      0
		dc.w      8
		dc.w    $1A
		dc.w  $FFFF
		dc.w    $1F
		dc.w      1
		dc.w    $1F
		dc.w      0
		dc.w      0
		dc.w    $18
		dc.w    $1A
		dc.w      1
		dc.w    $1F
		dc.w      1
		dc.w    $1F
		dc.w      0
		dc.w      0

; =============== S U B R O U T I N E =======================================


Draw_SSSprites:
		move.b	(Special_stage_angle).w,d0
		andi.w	#$C0,d0
		lsr.w	#2,d0
		lea	wordK_98B0(pc,d0.w),a5
		moveq	#0,d1
		move.b	(Special_stage_X_pos).w,d1
		move.w	(Special_stage_X_pos).w,d0
		addi.w	#$100,d0
		move.w	(Special_stage_Y_pos).w,d2
		andi.w	#$100,d2
		add.w	d2,d0
		btst	#6,(Special_stage_angle).w
		bne.s	locK_9930
		move.b	(Special_stage_Y_pos).w,d1
		move.w	(Special_stage_Y_pos).w,d0
		move.w	(Special_stage_X_pos).w,d2
		andi.w	#$100,d2
		add.w	d2,d0
; loc3_87B0:
locK_9930:
		tst.b	(Special_stage_angle).w
		bmi.s	locK_9946
		neg.w	d0
		addi.w	#$1F,d0
		move.w	d0,d2
		andi.w	#$E0,d2
		beq.s	locK_9946
		addq.b	#1,d1
; loc3_87C6:
locK_9946:
		andi.w	#$1E0,d0
		lsr.w	#5,d0
		move.w	d0,(Special_stage_anim_frame).w
		move.b	d0,(Special_stage_palette_frame).w
		move.b	(Special_stage_angle).w,d0
		andi.w	#$38,d0
		beq.s	locK_9968
		lsr.w	#3,d0
		addi.w	#$F,d0
		move.w	d0,(Special_stage_anim_frame).w
; loc3_87E8:
locK_9968:
		lea	(Draw_SSSprite_Normal).l,a0
		tst.w	(Special_stage_clear_timer).w
		beq.s	locK_997A
		lea	(Draw_SSSprite_FlyAway).l,a0
; loc3_87FA:
locK_997A:
		btst	#6,(Special_stage_angle).w
		bne.w	locK_9A3C
		move.w	2(a5),d5
		add.w	d1,d5
		and.w	$A(a5),d5
		move.w	(Special_stage_anim_frame).w,d0
		add.w	d0,d0
		add.w	d0,d0
	if Sonic3_Alone
		lea	(SStage_PerspectiveMapPtrs).l,a1
		movea.l	(a1,d0.w),a1
		lea	(Level_layout_header).w,a2
	else
		lea	(RAM_start).l,a1
		movea.l	(a1,d0.w),a1
		lea	(SStage_layout_buffer+$100).w,a2
	endif
		lea	(SStage_extra_sprites).w,a4
		lea	(Sprite_table).w,a6
		moveq	#80-1,d7
		moveq	#0,d6
		move.b	(Sprites_drawn).w,d6
		sub.b	d6,d7
		lsl.w	#3,d6
		adda.w	d6,a6
		moveq	#$10-1,d2
; loc3_883C:
locK_99BC:
		move.w	(a5),d4
		moveq	#0,d0
		move.b	(Special_stage_X_pos).w,d0
		add.w	d0,d4
		and.w	6(a5),d4
		moveq	#$F-1,d3
; loc3_884C:
locK_99CC:
		move.w	d5,d0
		lsl.w	#5,d0
		or.b	d4,d0
		move.b	(a2,d0.w),d0
		beq.s	locK_9A20
		move.w	(a1),d1
		andi.w	#$7C,d1
		beq.s	locK_9A20
		lsr.w	#2,d1
		subq.w	#6,d1
		cmpi.w	#$10,d1
		bhs.s	locK_9A20
		add.w	d1,d1
		andi.w	#$FF,d0
		lsl.w	#3,d0
		movea.l	(a4,d0.w),a3
		move.w	4(a4,d0.w),d6
		cmpi.w	#$54,(a1)
		blo.s	locK_9A04
		andi.w	#$7FFF,d6
; loc3_8884:
locK_9A04:
		move.w	6(a4,d0.w),d0
		add.w	d0,d0
		bcc.s	locK_9A0E
		moveq	#0,d1
; loc3_888E:
locK_9A0E:
		add.w	d0,d1
		adda.w	(a3,d1.w),a3
		move.w	(a3)+,d1
		subq.w	#1,d1
		bmi.s	locK_9A20
		jsr	(a0)
		tst.w	d7
		bmi.s	locretK_9A3A
; loc3_88A0:
locK_9A20:
		addq.w	#6,a1
		add.w	4(a5),d4
		and.w	6(a5),d4
		dbf	d3,locK_99CC
		add.w	8(a5),d5
		and.w	$A(a5),d5
		dbf	d2,locK_99BC
; locret3_88BA:
locretK_9A3A:
		rts
; ---------------------------------------------------------------------------
; loc3_88BC:
locK_9A3C:
		move.w	2(a5),d5
		add.w	d1,d5
		and.w	$A(a5),d5
		move.w	(Special_stage_anim_frame).w,d0
		add.w	d0,d0
		add.w	d0,d0
	if Sonic3_Alone
		lea	(SStage_PerspectiveMapPtrs).l,a1
		movea.l	(a1,d0.w),a1
		lea	(Level_layout_header).w,a2
	else
		lea	(RAM_start).l,a1
		movea.l	(a1,d0.w),a1
		lea	(SStage_layout_buffer+$100).w,a2
	endif
		lea	(SStage_extra_sprites).w,a4
		lea	(Sprite_table).w,a6
		moveq	#80-1,d7
		moveq	#0,d6
		move.b	(Sprites_drawn).w,d6
		sub.b	d6,d7
		lsl.w	#3,d6
		adda.w	d6,a6
		moveq	#$10-1,d2
; loc3_88F4:
locK_9A74:
		move.w	(a5),d4
		moveq	#0,d0
		move.b	(Special_stage_Y_pos).w,d0
		add.w	d0,d4
		and.w	6(a5),d4
		moveq	#$F-1,d3
; loc3_8904:
locK_9A84:
		move.w	d4,d0
		lsl.w	#5,d0
		or.b	d5,d0
		move.b	(a2,d0.w),d0
		beq.s	locK_9AD8
		move.w	(a1),d1
		andi.w	#$7C,d1
		beq.s	locK_9AD8
		lsr.w	#2,d1
		subq.w	#6,d1
		cmpi.w	#$10,d1
		bhs.s	locK_9AD8
		add.w	d1,d1
		andi.w	#$FF,d0
		lsl.w	#3,d0
		movea.l	(a4,d0.w),a3
		move.w	4(a4,d0.w),d6
		cmpi.w	#$54,(a1)
		blo.s	locK_9ABC
		andi.w	#$7FFF,d6
; loc3_893C:
locK_9ABC:
		move.w	6(a4,d0.w),d0
		add.w	d0,d0
		bcc.s	locK_9AC6
		moveq	#0,d1
; loc3_8946:
locK_9AC6:
		add.w	d0,d1
		adda.w	(a3,d1.w),a3
		move.w	(a3)+,d1
		subq.w	#1,d1
		bmi.s	locK_9AD8
		jsr	(a0)
		tst.w	d7
		bmi.s	locretK_9AF2
; loc3_8958:
locK_9AD8:
		addq.w	#6,a1
		add.w	4(a5),d4
		and.w	6(a5),d4
		dbf	d3,locK_9A84
		add.w	8(a5),d5
		and.w	$A(a5),d5
		dbf	d2,locK_9A74
; locret3_8972:
locretK_9AF2:
		rts
; End of function Draw_SSSprites

; ---------------------------------------------------------------------------

Draw_SSSprite_Normal:
		move.b	(a3)+,d0
		ext.w	d0
		add.w	4(a1),d0
		move.w	d0,(a6)+
		move.b	(a3)+,(a6)+
		addq.w	#1,a6
		move.w	(a3)+,d0
		add.w	d6,d0
		move.w	d0,(a6)+
		move.w	(a3)+,d0
		add.w	2(a1),d0
		move.w	d0,(a6)+
		subq.w	#1,d7
		dbmi	d1,Draw_SSSprite_Normal
		rts
; ---------------------------------------------------------------------------

Draw_SSSprite_FlyAway:
		move.b	(a3)+,d0
		ext.w	d0
		add.w	4(a1),d0
		sub.w	(Special_stage_clear_timer).w,d0
		move.w	d0,(a6)+
		move.b	(a3)+,(a6)+
		addq.w	#1,a6
		move.w	(a3)+,d0
		add.w	d6,d0
		move.w	d0,(a6)+
		move.w	(a3)+,d0
		add.w	2(a1),d0
		move.w	d1,-(sp)
		subi.w	#$120,d0
		move.w	(Special_stage_clear_timer).w,d1
		addi.w	#$100,d1
		muls.w	d1,d0
		asr.l	#8,d0
		addi.w	#$120,d0
		cmpi.w	#$1D0,d0
		blo.s	locK_9B56
		move.w	#1,d0
; loc3_89D6:
locK_9B56:
		move.w	(sp)+,d1
		move.w	d0,(a6)+
		subq.w	#1,d7
		dbmi	d1,Draw_SSSprite_FlyAway
		rts

; =============== S U B R O U T I N E =======================================

; sub3_89E2:
subK_9B62:
		move.b	(Special_stage_clear_routine).w,d1
		beq.w	locretK_9D1C
		subq.b	#1,d1
		bne.w	locK_9C5C
		cmpi.w	#$100,(Special_stage_clear_timer).w
		bhs.s	locK_9BA6
		addq.w	#2,(Special_stage_clear_timer).w
		cmpi.w	#2,(Special_stage_clear_timer).w
		bne.s	locK_9B8C
		moveq	#signextendB(sfx_AllSpheres),d0
		jsr	(Play_Music).l
; loc3_8A0C:
locK_9B8C:
		cmpi.w	#$40,(Special_stage_clear_timer).w
		blo.s	locretK_9BA4
		addq.w	#1,(Special_stage_clear_timer).w
		cmpi.w	#$80,(Special_stage_clear_timer).w
		blo.s	locretK_9BA4
		addq.w	#1,(Special_stage_clear_timer).w
; locret3_8A24:
locretK_9BA4:
		rts
; ---------------------------------------------------------------------------
; loc3_8A26:
locK_9BA6:
		addq.b	#1,(Special_stage_clear_routine).w
	if Sonic3_Alone
		lea	(Level_layout_header).w,a1
	else
		lea	(SStage_layout_buffer+$100).w,a1
	endif
		move.w	#bytesToLcnt($400),d0
; loc3_8A32:
locK_9BB2:
		move.l	#0,(a1)+
		dbf	d0,locK_9BB2
		move.b	(Special_stage_angle).w,d0
		jsr	(GetSineCosine).l
		move.w	(Special_stage_X_pos).w,d2
		move.w	(Special_stage_Y_pos).w,d3
		asl.w	#3,d0
		asl.w	#3,d1
		sub.w	d0,d2
		sub.w	d1,d3
	if Sonic3_Alone
		lea	(Level_layout_header).w,a1
	else
		lea	(SStage_layout_buffer+$100).w,a1
	endif
		move.w	d2,d0
		addi.w	#$80,d0
		lsr.w	#8,d0
		andi.w	#$1F,d0
		move.w	d3,d1
		addi.w	#$80,d1
		lsr.w	#8,d1
		andi.w	#$1F,d1
		lsl.w	#5,d1
		or.b	d0,d1
	if Sonic3_Alone
		move.b	#$A,(a1,d1.w)
	else
		move.b	#$B,(a1,d1.w)
		tst.b	(SK_special_stage_flag).w
		beq.s	locK_9C08
		move.b	#$D,(a1,d1.w)

locK_9C08:
	endif
		move.w	d1,(Special_stage_interact).w
		move.w	#$800,(Special_stage_velocity).w
		move.b	#120,(Special_stage_emerald_timer).w
		moveq	#0,d0
		move.b	(Current_special_stage).w,d0
	if ~~Sonic3_Alone
		tst.b	(Blue_spheres_stage_flag).w
		beq.s	locK_9C28
		move.b	(Blue_spheres_current_stage+2).w,d0

locK_9C28:
		andi.w	#7,d0
	endif
		lea	(Pal_SStage_Emeralds).l,a1
		lsl.w	#3,d0
		lea	(a1,d0.w),a1
		lea	(Normal_palette_line_4+$4).w,a2
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		lea	(ArtKosM_SStageChaosEmerald).l,a1
	if ~~Sonic3_Alone
		tst.b	(SK_special_stage_flag).w
		beq.s	locK_9C52
		lea	(ArtKosM_SStageSuperEmerald).l,a1

locK_9C52:
	endif
		move.w	#tiles_to_bytes(ArtTile_SStage_Emerald),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------
; loc3_8AB6:
locK_9C5C:
		subq.b	#1,d1
		bne.s	locK_9C80
		tst.b	(Kos_modules_left).w
		bne.s	locretK_9C7E
		move.w	#0,(Special_stage_clear_timer).w
		subq.b	#1,(Special_stage_emerald_timer).w
		bne.s	locretK_9C7E
		addq.b	#1,(Special_stage_clear_routine).w
		moveq	#signextendB(mus_Emerald),d0
		jsr	(Play_Music).l
; locret3_8AD8:
locretK_9C7E:
		rts
; ---------------------------------------------------------------------------
; loc3_8ADA:
locK_9C80:
		subq.b	#1,d1
	if Sonic3_Alone
		bne.s	locretK_9D1C
	else
		bne.w	locretK_9D1C
	endif
		move.w	(Special_stage_X_pos).w,d0
		addi.w	#$80,d0
		lsr.w	#8,d0
		andi.w	#$1F,d0
		move.w	(Special_stage_Y_pos).w,d1
		addi.w	#$80,d1
		lsr.w	#8,d1
		andi.w	#$1F,d1
		lsl.w	#5,d1
		or.b	d0,d1
		cmp.w	(Special_stage_interact).w,d1
		bne.s	locretK_9D1C
		move.w	(Special_stage_X_pos).w,d0
		or.w	(Special_stage_Y_pos).w,d0
		andi.w	#$E0,d0
		bne.s	locretK_9D1C
	if Sonic3_Alone
		cmpi.w	#7,(Chaos_emerald_count).w
		bhs.s	locK_9CE6
		addq.w	#1,(Chaos_emerald_count).w
	else
		tst.b	(Blue_spheres_stage_flag).w
		bne.s	locK_9CE6
		lea	(Chaos_emerald_count).w,a2
		move.b	(SK_special_stage_flag).w,d2
		beq.s	locK_9CCE
		lea	(Super_emerald_count).w,a2

locK_9CCE:
		cmpi.b	#7,(a2)
		bhs.s	locK_9CE6
		addq.b	#1,(a2)
	endif
		lea	(Collected_emeralds_array).w,a1
		moveq	#0,d0
		move.b	(Current_special_stage).w,d0
	if Sonic3_Alone
		move.b	#1,(a1,d0.w)
	else
		bset	#0,(a1,d0.w)
	endif
; loc3_8B2E:
locK_9CE6:
		addq.b	#1,(Special_stage_clear_routine).w
		move.b	#1,(Special_stage_fade_timer).w
		move.b	#GameMode_SpecialStageResults,(Game_mode).w
	if ~~Sonic3_Alone
		tst.b	(Blue_spheres_stage_flag).w
		beq.s	locK_9D02
		move.b	#GameMode_BlueSpheresResults,(Game_mode).w

locK_9D02:
	endif
		tst.b	(Special_bonus_entry_flag).w
		beq.s	locK_9D14
		move.w	(Saved2_zone_and_act).w,(Current_zone_and_act).w
		ori.b	#$80,(Last_star_post_hit).w
; loc3_8B50:
locK_9D14:
		moveq	#signextendB(sfx_Goal),d0
		jsr	(Play_SFX).l
; locret3_8B58:
locretK_9D1C:
		rts
; End of function subK_9B62

; ---------------------------------------------------------------------------
	if Sonic3_Alone
Pal_SStage_Emeralds:
		binclude "General/Special Stage/Palettes/Emeralds S3.bin"
		even
	else
Pal_SStage_Emeralds:
		binclude "General/Special Stage/Palettes/Emeralds.bin"
		even
	endif

; =============== S U B R O U T I N E =======================================

; sub3_8B9A:
subK_9D5E:
		move.w	(Special_stage_X_pos).w,d0
		sub.w	(Special_stage_prev_X_pos).w,d0
		btst	#6,(Special_stage_angle).w
		bne.s	locK_9D76
		move.w	(Special_stage_Y_pos).w,d0
		sub.w	(Special_stage_prev_Y_pos).w,d0
; loc3_8BB2:
locK_9D76:
		tst.b	(Special_stage_angle).w
		bmi.s	locK_9D7E
		neg.w	d0
; loc3_8BBA:
locK_9D7E:
		asr.w	#2,d0
		add.w	d0,(V_scroll_value_BG).w
		moveq	#0,d1
		move.b	(Special_stage_angle).w,d1
		asl.w	#2,d1
		move.w	d1,(H_scroll_buffer+2).w
		move.w	(Special_stage_X_pos).w,(Special_stage_prev_X_pos).w
		move.w	(Special_stage_Y_pos).w,(Special_stage_prev_Y_pos).w
		rts
; End of function subK_9D5E


; =============== S U B R O U T I N E =======================================


Animate_SSRings:
		lea	(SStage_extra_sprites+$07).w,a1
		subq.b	#1,(Rings_frame_timer).w
		bpl.s	locK_9DC2
		move.b	#7,(Rings_frame_timer).w
		addi.b	#$10,(Rings_frame).w
		cmpi.b	#$30,(Rings_frame).w
		blo.s	locK_9DC2
		move.b	#0,(Rings_frame).w
; loc3_8BFE:
locK_9DC2:
		move.b	(Rings_frame).w,anim(a1)
		rts
; End of function Animate_SSRings


; =============== S U B R O U T I N E =======================================


Find_SStageCollisionResponseSlot:
		lea	(SStage_collision_response_list).w,a2
		move.w	#bytesToXcnt(SStage_blue_sphere_to_ring_queue-SStage_collision_response_list,8),d0
; loc3_8C0E:
locK_9DD2:
		tst.b	(a2)
		beq.s	locretK_9DDC
		addq.w	#8,a2
		dbf	d0,locK_9DD2
; locret3_8C18:
locretK_9DDC:
		rts
; End of function Find_SStageCollisionResponseSlot


; =============== S U B R O U T I N E =======================================


Touch_SSSprites:
		lea	(SStage_collision_response_list).w,a0
		move.w	#bytesToXcnt(SStage_blue_sphere_to_ring_queue-SStage_collision_response_list,8),d7
; loc3_8C22:
locK_9DE6:
		moveq	#0,d0
		move.b	(a0),d0
		beq.s	locK_9DF4
		lsl.w	#2,d0
		movea.l	offK_9DFC-4(pc,d0.w),a1
		jsr	(a1)
; loc3_8C30:
locK_9DF4:
		addq.w	#8,a0
		dbf	d7,locK_9DE6
		rts
; End of function Touch_SSSprites

; ---------------------------------------------------------------------------
; off3_8C38:
offK_9DFC:
		dc.l Touch_SSSprites_Ring
		dc.l Touch_SSSprites_BlueSphere
; ---------------------------------------------------------------------------

Touch_SSSprites_Ring:
		subq.b	#1,2(a0)
		bpl.s	locretK_9E2C
		move.b	#5,2(a0)
		moveq	#0,d0
		move.b	3(a0),d0
		addq.b	#1,3(a0)
		movea.l	4(a0),a1
		move.b	byteK_9E2E(pc,d0.w),d0
		move.b	d0,(a1)
		bne.s	locretK_9E2C
		clr.l	(a0)
		clr.l	4(a0)
; locret3_8C68:
locretK_9E2C:
		rts
; ---------------------------------------------------------------------------
; byte3_8C6A:
byteK_9E2E:
	if Sonic3_Alone
		dc.b    5,   6,   7,   8,   0
	else
		dc.b    6,   7,   8,   9,   0
	endif
		even
; ---------------------------------------------------------------------------

Touch_SSSprites_BlueSphere:
		subq.b	#1,2(a0)
		bpl.s	locretK_9E86
		move.b	#9,2(a0)
		movea.l	4(a0),a1
		cmpi.b	#2,(a1)
		bne.s	locK_9E62
		bsr.w	Decrement_BlueSphere_Count
	if Sonic3_Alone
		move.b	#9,(a1)
	else
		move.b	#$A,(a1)
	endif
		bsr.s	Sphere_To_Rings
		beq.s	locretK_9E60
		move.b	#4,(a1)
		clr.l	(a0)
		clr.l	4(a0)
; locret3_8C9C:
locretK_9E60:
		rts
; ---------------------------------------------------------------------------
; loc3_8C9E:
locK_9E62:
		move.b	#0,2(a0)
		move.w	(Special_stage_X_pos).w,d0
		or.w	(Special_stage_Y_pos).w,d0
		andi.w	#$E0,d0
		beq.s	locretK_9E86
	if Sonic3_Alone
		cmpi.b	#9,(a1)
	else
		cmpi.b	#$A,(a1)
	endif
		bne.s	locK_9E80
		move.b	#1,(a1)
; loc3_8CBC:
locK_9E80:
		clr.l	(a0)
		clr.l	4(a0)
; locret3_8CC2:
locretK_9E86:
		rts

; =============== S U B R O U T I N E =======================================


Decrement_BlueSphere_Count:
		move.w	d0,-(sp)
		move.b	#-1,(Special_stage_sphere_HUD_flag).w	; Set flag to update HUD
		subq.w	#1,(Special_stage_spheres_left).w	; Decrement Count
		bne.s	locK_9E9C				; If Count is 0
		move.b	#1,(Special_stage_clear_routine).w	; Set flag to clear special stage
; loc3_8CD8:
locK_9E9C:
		move.w	(sp)+,d0
		rts
; End of function Decrement_BlueSphere_Count


; =============== S U B R O U T I N E =======================================

; sub3_8CDC:
subK_9EA0:
	if Sonic3_Alone
		lea	(Level_layout_header).w,a3
	else
		lea	(SStage_layout_buffer+$100).w,a3
	endif
		moveq	#0,d1
		move.w	#$400-1,d0
; loc3_8CE6:
locK_9EAA:
		cmpi.b	#2,(a3)+
		bne.s	locK_9EB2
		addq.w	#1,d1
; loc3_8CEE:
locK_9EB2:
		dbf	d0,locK_9EAA
		move.w	d1,(Special_stage_spheres_left).w
		rts
; End of function subK_9EA0


; =============== S U B R O U T I N E =======================================

; Arguments
;	a1: Address of Position in Map
; Mutates:
;	d0-d6/a2-a5
; Returns:
;	d1/CCR: 1 is transformed. 0 otherwise
;
; First Calls Find_Red_Sphere_Loop to:
;	Check if there are and loops of red spheres
;	Turn 1 blue sphere per loop to a ring
;	Add the position of those rings to the ring queue
;
; If the queue is empty, return 0
;
; The use a breath first search algorithm to using the queue
; to fill out each area of blue spheres, turning them into
; rings and adding them to the queue, and updating the HUD.
;
; Lastly check all neighbors of the queue for red spheres
; that can be turning into rings, and do so.
;
; Play the sfx_RingLoss sfx and return 1.
Sphere_To_Rings:
	if Sonic3_Alone
		lea	(Level_layout_header).w,a2
	else
		lea	(SStage_layout_buffer+$100).w,a2
	endif
		move.l	a1,d5
		sub.l	a2,d5						; position index = position address - start address
		bsr.s	Find_Red_Sphere_Loop				; returns ring queue end in a5
		moveq	#0,d6
		move.l	a5,d1						; ring queue end (from Find_Red_Sphere_Loop)
		lea	(SStage_blue_sphere_to_ring_queue).w,a4		; ring queue start
		sub.l	a4,d1						; remaining entries count = end - start
		beq.s	locretK_9F42					; if empty queue, return 0

; For each ring in the queue, find its blue sphere neighbors, then
; turn those blue spheres into rings, and add those positions
; to the queue
Blue_To_Ring_Next_Ring_B:
		move.w	(a4)+,d5					; read ring from queue
		lea	(SStage_8_Directions).l,a3			; load directions table
		move.w	#8-1,d0

Blue_To_Ring_Next_Direction_B:						; Loop[neighbors of ring]
		move.w	(a3)+,d2					; 	get next direction
		add.w	d5,d2						; 	neighbor = ring + direction
	if ~~Sonic3_Alone
		andi.w	#$3FF,d2					; 	truncate to map size
	endif
		cmpi.b	#2,(a2,d2.w)					; 	If the neighbor is Blue
		bne.s	Blue_To_Ring_Continue_B
		bsr.w	Decrement_BlueSphere_Count
		move.b	#4,(a2,d2.w)					;		Change to ring
		move.w	d2,(a5)+					; 		Add to queue
		addq.w	#2,d1						; 		increment remaining entries count

Blue_To_Ring_Continue_B:
		dbf	d0,Blue_To_Ring_Next_Direction_B		; Loop[neighbors of ring]:end
		subq.w	#2,d1						; decrement remaining entries count
		bne.s	Blue_To_Ring_Next_Ring_B			; If more rings in queue, get next ring
		move.l	a5,d1						; reset queue end
		lea	(SStage_blue_sphere_to_ring_queue).w,a4		; reset queue start
		sub.l	a4,d1						; reset remaining entries count
		beq.s	locretK_9F42					; if empty queue (how?), return 0

; For each ring in the queue, find its red sphere neighbors, then
; turn those red spheres into rings
Blue_To_Ring_Next_Ring_R:
		move.w	(a4)+,d5					; read ring from queue
		lea	(SStage_8_Directions).l,a3			; load directions table
		move.w	#8-1,d0

Blue_To_Ring_Next_Direction_R:						; Loop[neighbors of ring]
		move.w	(a3)+,d2					; 	get next direction
		add.w	d5,d2						; 	neighbor = ring + direction
	if ~~Sonic3_Alone
		andi.w	#$3FF,d2					; 	truncate to map size
	endif
		cmpi.b	#1,(a2,d2.w)					; 	If the current neighbor is Red
		bne.s	Blue_To_Ring_Continue_R
		move.b	#4,(a2,d2.w)					; 		Change to ring

Blue_To_Ring_Continue_R:
		dbf	d0,Blue_To_Ring_Next_Direction_R		; Loop[neighbors or ring]:end
		subq.w	#2,d1						; decrement remaining entries count
		bne.s	Blue_To_Ring_Next_Ring_R
		moveq	#signextendB(sfx_RingLoss),d0			; load and play Ring Loss SFX
		jsr	(Play_SFX).l
		moveq	#1,d1						; Return 1
; locret3_8D76:
locretK_9F42:
		rts
; End of function Sphere_To_Rings


; =============== S U B R O U T I N E =======================================

; Arguments
;	d5: Index in Map Of Touched Sphere
;	a2: Address of the Special Stage Map
; Mutates
;	d0-d4/d6/a3-a5
; Returns:
;	a5: 1 past the end of ring queue
;
; First checks if the touched sphere has any blue sphere neighbors,
; while also turning any touched neighbors into red spheres.
; If there are none, return early
;
; Next check if the contiguous vertical and horizontal span
; of spheres and rings starting from the touched sphere is
; at least 3 spheres long each.
; Otherwise, return early
;
; Then use a depth first search traversal algorithm to walk
; a path of red spheres to find valid loops. For each loop
; try to find an enclosed blue sphere. If one is found,
; turn it into a ring, and add its index to the ring queue
; and increment the queue pointer.
Find_Red_Sphere_Loop:
		lea	(SStage_blue_sphere_to_ring_queue).w,a5		; Load special stage map pointer
		lea	(SStage_8_Directions).l,a3			; Load directions pointer
		moveq	#0,d2						; Blue sphere counter
		move.w	#8-1,d0

Red_Loop_Check_Neighbors:						; Loop[neighbors of touched]
		move.w	(a3)+,d1					; 	get next direction
		add.w	d5,d1						; 	neighbor = touched + direction
	if Sonic3_Alone
		cmpi.b	#9,(a2,d1.w)					; 	If neighbor is 9 (TOUCHED)
	else
		andi.w	#$3FF,d1					; 	truncate to map size
		cmpi.b	#$A,(a2,d1.w)					; 	If neighbor is $A (TOUCHED)
	endif
		bne.s	locK_9F6A
		move.b	#1,(a2,d1.w)					;		change to RedSphere
; loc3_8D9A:
locK_9F6A:
		cmpi.b	#2,(a2,d1.w)					; 	If neighbor is Blue
		bne.s	locK_9F74
		addq.w	#1,d2						;		increment count
; loc3_8DA4:
locK_9F74:
		dbf	d0,Red_Loop_Check_Neighbors			; Loop[neighbors of touched]:end
		tst.w	d2						; If there are no blue sphere neighbors
		beq.w	locretK_A076					;	return
		moveq	#0,d2						; Horizontal span length
		move.w	d5,d1						; scanning index
	if ~~Sonic3_Alone
		moveq	#$10-1,d3
	endif

Red_Loop_Count_Horizontal_Left:						; Loop[left until empty (max 16)]
		addq.w	#1,d2						;	increment horizontal span length
		addi.w	#-1,d1						;	move index left
		tst.b	(a2,d1.w)					;	If index is empty (map[index] == 0)
	if Sonic3_Alone
		bne.s	Red_Loop_Count_Horizontal_Left			;		break
	else
		beq.s	locK_9F94					;		break
		dbf	d3,Red_Loop_Count_Horizontal_Left		; Loop[left until empty (max 16)]:end
	endif

locK_9F94:
		move.w	d5,d1						; scanning index
	if ~~Sonic3_Alone
		moveq	#$10-1,d3
	endif

Red_Loop_Count_Horizontal_Right:					; Loop[right until empty (max 16)]
		addq.w	#1,d2						;	increment horizontal span length
		addi.w	#1,d1						;	move index right
		tst.b	(a2,d1.w)					;	If index is empty (map[index] == 0)
	if Sonic3_Alone
		bne.s	Red_Loop_Count_Horizontal_Right			;		break
	else
		beq.s	locK_9FA8					;		break
		dbf	d3,Red_Loop_Count_Horizontal_Right		; Loop[left until empty (max 16)]:end
	endif


locK_9FA8:
		cmpi.w	#4,d2						; If horizontal span is less than 3 (< 4 because touched is double counted)
		blo.w	locretK_A076					; 	then return
		moveq	#0,d2						; Vertical span length
		move.w	d5,d1						; scanning index
	if ~~Sonic3_Alone
		moveq	#$10-1,d3
	endif

Red_Loop_Count_Vertically_Up:						; Loop[up until empty (max 16)]
		addq.w	#1,d2						;	increment vertical span length
		addi.w	#-$20,d1					;	move index up
		tst.b	(a2,d1.w)					;	If index is empty (map[index] == 0)
	if Sonic3_Alone
		bne.s	Red_Loop_Count_Vertically_Up			;		break
	else
		beq.s	locK_9FC6					;		break
		dbf	d3,Red_Loop_Count_Vertically_Up			; Loop[left until empty (max 16)]:end
	endif

locK_9FC6:
		move.w	d5,d1						; scanning index
	if ~~Sonic3_Alone
		moveq	#$10-1,d3
	endif

Red_Loop_Count_Vertically_Down:						; Loop[down until empty (max 16)]
		addq.w	#1,d2						;	increment vertical span length
		addi.w	#$20,d1						;	move index up
		tst.b	(a2,d1.w)					;	If index is empty (map[index] == 0)
	if Sonic3_Alone
		bne.s	Red_Loop_Count_Vertically_Down			;		break
	else
		beq.s	locK_9FDA					;		break
		dbf	d3,Red_Loop_Count_Vertically_Down		; Loop[left until empty (max 16)]:end
	endif


locK_9FDA:
		cmpi.w	#4,d2						; If vertical span is less than 3 (< 4 because touched is double counted)
		blo.w	locretK_A076					; 	then return
		lea	(SStage_red_sphere_dfs_walk_stack).w,a4
		lea	(SStage_4_Directions).l,a3			; Load Directions Pointer
		moveq	#0,d6						; Walk Stack Size
		moveq	#0,d3						; Direction Index Lower Bound
		moveq	#6,d4						; Direction Index
		add.w	d3,d4
		move.w	d5,d0						; Current Walk Position

Red_Loop_Find_Next:
		move.w	(a3,d4.w),d1					; Next Direction = directions[direction index]
		add.w	d0,d1						; Next Candidate = current position + next direction
	if ~~Sonic3_Alone
		andi.w	#$3FF,d1					; truncate to map size
	endif
		move.b	(a2,d1.w),d2					; load map entry at candidate position
	if Sonic3_Alone
		cmpi.b	#$89,d2						; If candidate sphere is $89 (Processed + Touched)
	else
		cmpi.b	#$8A,d2						; If candidate sphere is $8A (Processed + Touched)
	endif
		beq.s	Red_Loop_Processes_Loop				; 	Loop found. Process Loop
		cmpi.b	#1,d2						; If candidate is not a Red Sphere
		bne.s	Red_Loop_Decrement				; 	Decrement direction Index
		cmpi.w	#2,d6						; If walk stack size < 2
		blo.s	Red_Loop_Push_Stack				; 	Push current state to walk stack
		move.w	d1,d2
		sub.w	-6(a4),d2					; Difference between candidate position and position at walk_stack[-2]
		cmpi.w	#-1,d2						; If the difference is one square away in any direction
		beq.s	Red_Loop_Decrement				;	Candidate is not part of the loop. Decrement direction Index
		cmpi.w	#1,d2						; Else Push current state to walk stack
		beq.s	Red_Loop_Decrement
		cmpi.w	#$20,d2						; [S-1] -> [Current]
		beq.s	Red_Loop_Decrement				;   ^          V
		cmpi.w	#-$20,d2					; [S-2]	   [Candidate]
		beq.s	Red_Loop_Decrement

Red_Loop_Push_Stack:
		ori.b	#$80,(a2,d0.w)					; Mark current position as being processed
		move.b	d3,(a4)+					; Push direction index to walk stack
		move.b	d4,(a4)+					; Push direction index lower bound to walk stack
		move.w	d0,(a4)+					; Push current position to walk stack
		addq.w	#1,d6						; Increment walk stack size

		; For subsequent steps of a walk, you don't want the next position to consider making a complete
		; 180 degree turn. The following code is used to limit the new position's range of movement directions.
		; It's done by defining the lower bound index as one less than the current direction (looping to index 3 if -1),
		; 	and by defining the upper bound index as two more than the new lower bound,
		;
		; As an example, given that the 4-way direction table is [L, U, R, D, L, U],
		; let's say the direction from current to candidate is Right (index 2).
		; Then the new lower bound index would be 1, and the new upper bound would be 3
		; which is the range [U, R, D], which excludes going LEFT i.e. turning 180 degrees
		;
		; These offsets are multiplied by 2 as each direction is 2 bytes long
		move.w	d4,d3
		subq.w	#2,d3
		andi.w	#6,d3						; lower_bound = (index - 2) & 6
		move.w	#4,d4
		add.w	d3,d4						; index = 4 + lower_bound
		move.w	d1,d0						; current position = candidate position
		bra.s	Red_Loop_Find_Next
; ---------------------------------------------------------------------------

Red_Loop_Decrement:
		subq.w	#2,d4						; Decrement direction index
		cmp.w	d3,d4						; If index >= lower bound,
		bge.s	Red_Loop_Find_Next				; 	check next candidate
									; Else this position is done, pop the stack to get previous

Red_Loop_Pop_Stack:
		moveq	#0,d3
		moveq	#0,d4
		move.w	-(a4),d0					; Pop current position from walk stack
		move.b	-(a4),d4					; Pop direction index from walk stack
		move.b	-(a4),d3					; Pop direction index lower bound from walk stack
		subq.w	#1,d6						; Decrement walk stack size
		bcs.s	locretK_A076					; If walk stack was empty,
									; 	No more loops to find. Return
		andi.b	#$7F,(a2,d0.w)					; Unmark current position as being processed
		subq.w	#2,d4						; Decrement direction index
		cmp.w	d3,d4						; If index >= lower bound,
		bge.s	Red_Loop_Find_Next				; 	check next candidate
		bra.s	Red_Loop_Pop_Stack				; Else this position is done, pop the stack to get previous
; ---------------------------------------------------------------------------
; locret3_8E8A:
locretK_A076:
		rts
; ---------------------------------------------------------------------------

; Once a loop has been detected, this code finds which direction
; is "inside" the loop, and checks if there is a blue sphere
; which would then be turned into a ring, and whose position
; is added to the ring queue.

; To find the "inside" direction, rewalk the red sphere path
; keeping track of the direction of each step.
; Once you find a direction that is different from the initial direction,
; then apply that directional offset to either the touched
; sphere, or the first step of the walk, depending on if the
; touched sphere is at a corner.

;	[R] [R] [R]	[T]<[R] [R]
;	 		 V
;	[T]>[B] [R]	[R]>[B] [R]
;	 V		 V
;	[R] [B] [R]	[R] [B] [R]
;	 V		 V
;	[R]>[R] [R]	[R]>[R] [R]
Red_Loop_Processes_Loop:
	if Sonic3_Alone
		movem.l	d0/d3/d6/a4,-(sp)
		sub.w	d5,d0						; Direction (start -> last walk)
		move.w	d0,d2
		neg.w	d2						; Final Direction of loop (last walk -> start)
	else
		movem.l	d0/d3-d4/d6/a4,-(sp)
		sub.w	d5,d0						; Direction (start -> last walk)
		move.w	d0,d4
		neg.w	d4						; Final Direction of loop (last walk -> start)
	endif
		lea	(SStage_red_sphere_dfs_walk_stack+6).w,a4	; &WalkPath[1].position
	if ~~Sonic3_Alone
		move.w	(a4),d2						; Second Position of Path
		sub.w	d5,d2						; Initial direction
	endif
		move.w	d5,d3						; Walk position head (starts at touched)

Red_Loop_Walk_Forward:
		move.w	(a4)+,d0					; Next step of walk (starts at second)
		addq.w	#2,a4
		sub.w	d3,d0						; Direction from walk position to next step
		cmp.w	d2,d0						; If next direction != initial direction
		bne.s	Red_Loop_Direction_Changed			; 	break
		add.w	d0,d3						; Otherwise move walk position forward
		bra.s	Red_Loop_Walk_Forward
; ---------------------------------------------------------------------------

Red_Loop_Direction_Changed:
	if ~~Sonic3_Alone
									; Corner Check
		cmp.w	d4,d0						; If new direction != final direction
		beq.s	Red_Loop_Blue_Check
		cmp.w	d4,d2						; and initial direction != final direction
		beq.s	Red_Loop_Blue_Check
		add.w	d2,d0						; add initial direction to new direction
	endif

Red_Loop_Blue_Check:
		add.w	d5,d0						; Sphere to check (touched position + new direction)
		cmpi.b	#2,(a2,d0.w)					; If checked sphere is Blue
		beq.s	Red_Loop_Blue_To_Ring				;	Turn into ring
		cmpi.b	#4,(a2,d0.w)					; Else return to DFS walk
		beq.s	Red_Loop_Return_To_DFS
	if Sonic3_Alone
		sub.w	d2,d0						; Move Sphere to check one step opposite of the final direction
		cmpi.b	#2,(a2,d0.w)					; If checked sphere is Blue
		beq.s	Red_Loop_Blue_To_Ring				;	Turn into ring
	endif
		bra.s	Red_Loop_Return_To_DFS
; ---------------------------------------------------------------------------

Red_Loop_Blue_To_Ring:
		bsr.w	Decrement_BlueSphere_Count
		move.b	#4,(a2,d0.w)					; Turn blue sphere into a ring
		move.w	d0,(a5)+					; and add ring position to ring queue

Red_Loop_Return_To_DFS:
	if Sonic3_Alone
		movem.l	(sp)+,d0/d3/d6/a4
	else
		movem.l	(sp)+,d0/d3-d4/d6/a4
	endif
		bra.s	Red_Loop_Decrement
; End of function Find_Red_Sphere_Loop

; ---------------------------------------------------------------------------

SStage_8_Directions:
		dc.w   -$21
		dc.w   -$20
		dc.w   -$1F
		dc.w     -1
		dc.w      1
		dc.w    $1F
		dc.w    $20
		dc.w    $21

SStage_4_Directions:
		dc.w     -1
		dc.w   -$20
		dc.w      1
		dc.w    $20
		dc.w     -1
		dc.w   -$20

; =============== S U B R O U T I N E =======================================


Load_SSSprite_Mappings:
		lea	(SStage_extra_sprites).w,a1
		lea	(MapPtr_A10A).l,a0
		moveq	#bytesToXcnt(MapPtr_A10A_end-MapPtr_A10A,8),d1
; loc3_8F02:
locK_A0F2:
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		dbf	d1,locK_A0F2
		lea	(SStage_collision_response_list).w,a1
		move.w	#bytesToLcnt(SStage_blue_sphere_to_ring_queue-SStage_collision_response_list),d1
; loc3_8F12:
locK_A102:
		clr.l	(a1)+
		dbf	d1,locK_A102
		rts
; End of function Load_SSSprite_Mappings

; ---------------------------------------------------------------------------

MapPtr_A10A:
		dc.l Map_SStageSphere
		dc.w make_art_tile(ArtTile_SStage_Sphere,0,1), $0000
		dc.l Map_SStageSphere
		dc.w make_art_tile(ArtTile_SStage_Sphere,0,1), $0000
		dc.l Map_SStageSphere
		dc.w make_art_tile(ArtTile_SStage_Sphere,2,1), $0000
		dc.l Map_SStageSphere
		dc.w make_art_tile(ArtTile_SStage_Sphere,1,1), $0000
		dc.l Map_SStageRing
		dc.w make_art_tile(ArtTile_SStage_Ring,2,1), $0000
	if ~~Sonic3_Alone
		dc.l Map_SStageSphere
		dc.w make_art_tile(ArtTile_SStage_Sphere,3,1), $0000
	endif
		dc.l Map_SStageRing
		dc.w make_art_tile(ArtTile_SStage_Ring,2,1), $8030
		dc.l Map_SStageRing
		dc.w make_art_tile(ArtTile_SStage_Ring,2,1), $8031
		dc.l Map_SStageRing
		dc.w make_art_tile(ArtTile_SStage_Ring,2,1), $8032
		dc.l Map_SStageRing
		dc.w make_art_tile(ArtTile_SStage_Ring,2,1), $8033
		dc.l Map_SStageSphere
		dc.w make_art_tile(ArtTile_SStage_Sphere,2,1), $0000
		dc.l Map_SStageChaosEmerald
		dc.w make_art_tile(ArtTile_SStage_Ring,3,1), $0000
		dc.l Map_SStageSphere
		dc.w make_art_tile(ArtTile_SStage_Sphere,2,1), $0000
	if Sonic3_Alone
		dc.l Map_SStageSphere
		dc.w make_art_tile(ArtTile_SStage_Sphere,2,1), $0000
	else
		dc.l Map_SStageSuperEmerald
		dc.w make_art_tile(ArtTile_SStage_Ring,3,1), $0000
	endif
MapPtr_A10A_end:

; ---------------------------------------------------------------------------
		; unused
		ext.l	d1
		lsl.l	#8,d1
		divs.w	d0,d1
		ext.l	d2
		lsl.l	#8,d2
		divs.w	d0,d2
		rts

; =============== S U B R O U T I N E =======================================

; sub3_8F90:
subK_A188:
		swap	d0
		move.w	d1,d3
		move.w	d2,d4
		move.w	(SStage_scalar_result_2).w,d0
		muls.w	d0,d3
		muls.w	d0,d4
		move.w	(SStage_scalar_result_2+2).w,d0
		muls.w	d0,d1
		muls.w	d0,d2
		sub.l	d4,d1
		add.l	d1,d1
		add.l	d1,d1
		swap	d1
		add.l	d3,d2
		add.l	d2,d2
		add.l	d2,d2
		swap	d2
		swap	d0
		rts
; End of function subK_A188


; =============== S U B R O U T I N E =======================================

; sub3_8FBA:
subK_A1B2:
		swap	d2
		move.w	d0,d3
		move.w	d1,d4
		move.w	(SStage_scalar_result_1).w,d2
		muls.w	d2,d3
		muls.w	d2,d4
		move.w	(SStage_scalar_result_1+2).w,d2
		muls.w	d2,d0
		muls.w	d2,d1
		sub.l	d4,d0
		add.l	d0,d0
		add.l	d0,d0
		swap	d0
		add.l	d3,d1
		add.l	d1,d1
		add.l	d1,d1
		swap	d1
		swap	d2
		rts
; End of function subK_A1B2


; =============== S U B R O U T I N E =======================================

; sub3_8FE4:
subK_A1DC:
		swap	d1
		move.w	d0,d3
		move.w	d2,d4
		move.w	(SStage_scalar_result_0).w,d1
		muls.w	d1,d3
		muls.w	d1,d4
		move.w	(SStage_scalar_result_0+2).w,d1
		muls.w	d1,d0
		muls.w	d1,d2
		sub.l	d4,d0
		add.l	d0,d0
		add.l	d0,d0
		swap	d0
		add.l	d3,d2
		add.l	d2,d2
		add.l	d2,d2
		swap	d2
		swap	d1
		rts
; End of function subK_A1DC


; =============== S U B R O U T I N E =======================================

; sub3_900E:
subK_A206:
		swap	d1
		move.w	d0,d3
		move.w	d2,d4
		move.w	(SStage_scalar_result_3).w,d1
		muls.w	d1,d3
		muls.w	d1,d4
		move.w	(SStage_scalar_result_3+2).w,d1
		muls.w	d1,d0
		muls.w	d1,d2
		sub.l	d4,d0
		add.l	d0,d0
		add.l	d0,d0
		swap	d0
		add.l	d3,d2
		add.l	d2,d2
		add.l	d2,d2
		swap	d2
		swap	d1
		rts
; End of function subK_A206


	if ~~Sonic3_Alone
; =============== S U B R O U T I N E =======================================


subK_A230:
		add.w	d0,d0
		addi.w	#$80,d0
		andi.w	#$1FE,d0
		move.w	ScalarTable2(pc,d0.w),d1
		subi.w	#$80,d0
		andi.w	#$1FE,d0
		move.w	ScalarTable2(pc,d0.w),d0
		rts
; End of function subK_A230
	endif

; =============== S U B R O U T I N E =======================================


GetScalars2:
		add.w	d0,d0
		andi.w	#$1FE,d0
		move.w	ScalarTable2(pc,d0.w),(a1)+
		addi.w	#$80,d0
		andi.w	#$1FE,d0
		move.w	ScalarTable2(pc,d0.w),(a1)+
		rts
; End of function GetScalars2

; ---------------------------------------------------------------------------
ScalarTable2:
		binclude "General/Special Stage/Scalars.bin"
		even

Map_SStageSphere:
		include "General/Special Stage/Map - Sphere.asm"
Map_SStageRing:
		include "General/Special Stage/Map - Ring.asm"
Map_SStageChaosEmerald:
		include "General/Special Stage/Map - Chaos Emerald.asm"
	if ~~Sonic3_Alone
Map_SStageSuperEmerald:
		include "General/Special Stage/Map - Super Emerald.asm"
	endif