; ---------------------------------------------------------------------------

LevelMusic_Playlist:
		dc.b mus_AIZ1,		mus_AIZ2	; ANGEL ISLAND ZONE
		dc.b mus_HCZ1,		mus_HCZ2	; HYDROCITY ZONE
		dc.b mus_MGZ1,		mus_MGZ2	; MARBLE GARDEN ZONE
		dc.b mus_CNZ1,		mus_CNZ2	; CARNIVAL NIGHT ZONE
		dc.b mus_FBZ1,		mus_FBZ2	; FLYING BATTERY ZONE
		dc.b mus_ICZ1,		mus_ICZ2	; ICECAP ZONE
		dc.b mus_LBZ1,		mus_LBZ2	; LAUNCH BASE ZONE
		dc.b mus_MHZ1,		mus_MHZ2	; MUSHROOM HILL ZONE
		dc.b mus_SOZ1,		mus_SOZ2	; SANDOPOLIS ZONE
		dc.b mus_LRZ1,		mus_LRZ2	; LAVA REEF ZONE
	if Sonic3_Alone
		; Likely by mistake, Sky Sanctuary 2 uses the music for Death Egg 1,
		; while both acts of Death Egg use the Death Egg 2 music.
		dc.b mus_SSZ,		mus_DEZ1	; SKY SANCTUARY ZONE
		dc.b mus_DEZ2,		mus_DEZ2	; DEATH EGG ZONE
	else
		dc.b mus_SSZ,		mus_SSZ		; SKY SANCTUARY ZONE
		dc.b mus_DEZ1,		mus_DEZ2	; DEATH EGG ZONE
	endif
		dc.b mus_DDZ,		mus_DDZ		; DOOMSDAY ZONE
	if Sonic3_Alone
		dc.b mus_SpecialStage,	mus_SpecialStage; AIZ INTRO & ENDING
	else
		dc.b mus_SpecialStage,	mus_SSZ		; AIZ INTRO & ENDING
	endif
		dc.b mus_ALZ,		mus_ALZ		; AZURE LAKE ZONE
		dc.b mus_BPZ,		mus_BPZ		; BALLOON PARK ZONE
		dc.b mus_DPZ,		mus_DPZ		; DESERT PALACE ZONE
		dc.b mus_CGZ,		mus_CGZ		; CHROME GADGET ZONE
		dc.b mus_EMZ,		mus_EMZ		; ENDLESS MINE ZONE
		dc.b mus_Gumball,	mus_Gumball	; GUMBALL
	if Sonic3_Alone
		dc.b mus_Slots,		mus_Slots	; PACHINKO
		dc.b mus_Gumball,	mus_Gumball	; SLOTS
		dc.b mus_SpecialStage,	mus_SpecialStage; LAVA REEF ZONE BOSS & HIDDEN PALACE ZONE
		dc.b mus_SpecialStage,	mus_SpecialStage; FINAL BOSS & SPECIAL STAGE HUB
	else
		dc.b mus_Pachinko,	mus_Pachinko	; PACHINKO
		dc.b mus_Slots,		mus_Slots	; SLOTS
		dc.b mus_EndBoss,	mus_LRZ2	; LAVA REEF ZONE BOSS & HIDDEN PALACE ZONE
		dc.b mus_DEZ2,		mus_LRZ2	; FINAL BOSS & SPECIAL STAGE HUB
	endif
		even
; ---------------------------------------------------------------------------

Level:
		bset	#7,(Game_mode).w		; Set bit 7 of F600 is indicate that we're loading the level
		tst.w	(Demo_mode_flag).w		; Are we on an ending demo? (Sonic 1 leftover)
		bmi.s	locK_5FC4			; If so, branch (Sonic 1 leftover)
		moveq	#signextendB(cmd_FadeOut),d0		; If a demo
		bsr.w	Play_SFX
; loc3_46C2:
locK_5FC4:
	if ~~Sonic3_Alone
		clr.w	(Ending_running_flag).w
	endif
		clr.w	(Kos_decomp_queue_count).w
		clearRAM	Kos_decomp_stored_registers,(Kos_decomp_module_end-Kos_decomp_stored_registers)	; Clear the KosM bytes
		bsr.w	Clear_Nem_Queue				; Clear PLCs
	if Sonic3_Alone
		bsr.w	Pal_FadeToBlack
	else
		cmpi.w	#$D01,(Current_zone_and_act).w
		beq.s	locK_5FFC
		tst.b	(Respawn_table_keep).w
		beq.s	locK_5FF6
		cmpi.w	#$1701,(Current_zone_and_act).w
		beq.s	locK_5FFC

locK_5FF6:
		bsr.w	Pal_FadeToBlack			; If any normal level
		bra.s	locK_6000
; ---------------------------------------------------------------------------

locK_5FFC:
		bsr.w	Pal_FadeToWhite			; If level being loaded is the special stage arena or an ending

locK_6000:
	endif
		tst.w	(Demo_mode_flag).w		; Are we on an ending demo? (Sonic 1 leftover)
		bmi.w	locK_60DE			; If so, branch (Sonic 1 leftover)
		move	#$2700,sr
		bsr.w	Clear_DisplayData		; Clear the screen
		move	#$2300,sr
		moveq	#0,d0
		move.w	d0,(Level_frame_counter).w
		tst.b	(Last_star_post_hit).w
		beq.s	locK_6040				; If no starpost was set, branch
		tst.b	(Special_bonus_entry_flag).w
		bne.s	locK_6034				; Otherwise, ensure that the proper level ID is set to account for levels that use multiple ones in an act
		move.w	(Saved_zone_and_act).w,(Current_zone_and_act).w
		move.w	(Saved_apparent_zone_and_act).w,(Apparent_zone_and_act).w
		bra.s	locK_6040
; ---------------------------------------------------------------------------
; loc3_4712:
locK_6034:
		move.w	(Saved2_zone_and_act).w,(Current_zone_and_act).w
		move.w	(Saved2_apparent_zone_and_act).w,(Apparent_zone_and_act).w
; loc3_471E:
locK_6040:
		move.w	(Current_zone_and_act).w,d0

		; Useless code. Player_mode has not been set yet, and level $D00 has the same PLCs as level 0
		bne.s	locK_6058
		cmpi.w	#2,(Player_mode).w		; If level is Angel Island 1
	if Sonic3_Alone
		beq.s	locK_6054
	else
		bhs.s	locK_6054
	endif
		tst.b	(Last_star_post_hit).w			; If character is Sonic
		beq.s	locK_6058				; And no lamppost is set
; loc3_4732:
locK_6054:
		move.w	#$D00,d0				; Set the level ID to skip the intro

locK_6058:
	if ~~Sonic3_Alone
		cmpi.w	#$401,(Current_zone_and_act).w		; If level is Flying Battery 2...
		bne.s	locK_6068
		cmpi.b	#6,(Last_star_post_hit).w		; ...and lamppost is 6 or above (the one before the rising floor at the end)...
		beq.s	locK_6088				; ...don't bother loading level PLCs
	endif
; loc3_4736:
locK_6068:
		ror.b	#1,d0
		lsr.w	#4,d0
		andi.w	#$1F8,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d0,d1
		lea	(LevelLoadBlock).l,a2
		moveq	#0,d0
		move.b	(a2,d1.w),d0			; Get the first PLC number for the level
		beq.s	locK_6088
		bsr.w	Load_PLC
; loc3_4756:
locK_6088:
		bsr.w	LevelLoad_ActiveCharacter
		tst.b	(Last_star_post_hit).w
		bne.w	locK_60B4
		cmpi.w	#0,(Current_zone_and_act).w
		bne.s	locK_60B4
		cmpi.w	#2,(Player_mode).w
	if Sonic3_Alone
		beq.s	locK_60B4
	else
		bhs.s	locK_60B4
	endif
		moveq	#PLCID_01,d0					; If in AIZ intro
		jsr	(Load_PLC_2).l
		moveq	#PLCID_0A,d0
		bsr.w	Load_PLC					; Load the AIZ Intro graphics
		bra.s	locK_60DE
; ---------------------------------------------------------------------------
; loc3_4782:
locK_60B4:
		moveq	#PLCID_06,d0
		tst.w	(Competition_mode).w
		bne.s	locK_60DA
	if ~~Sonic3_Alone
		moveq	#PLCID_05,d0
		cmpi.w	#3,(Player_mode).w
		beq.s	locK_60DA
	endif
		moveq	#PLCID_01,d0
		cmpi.w	#2,(Player_mode).w
		bne.s	locK_60DA
		moveq	#PLCID_07,d0
	if ~~Sonic3_Alone
		; Oddly, Sonic 3 Alone does not have the MILES life graphics.
		tst.b	(Graphics_flags).w
		bmi.s	locK_60DA
		moveq	#PLCID_52,d0
	endif
; loc3_4796:
locK_60DA:
		bsr.w	Load_PLC
; loc3_479A:
locK_60DE:
		clearRAM	Sprite_table_input,(Sprite_table_input_end-Sprite_table_input)
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clearRAM	Lag_frame_count,(Nem_decomp_queue-Lag_frame_count)
		clearRAM	Tails_CPU_interact,(Sprite_table-Tails_CPU_interact)
		clearRAM	Oscillating_table,(AIZ_vine_angle-Oscillating_table)
		clearRAM	_unkFA80,(DMA_queue-_unkFA80)
		jsr	(Init_SpriteTable).l
		lea	(VDP_control_port).l,a6
		move.w	#$8B03,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$857C,(a6)
		move.w	#$9001,(a6)
		move.w	#$8004,(a6)
		move.w	#$9200,(a6)
		move.w	#$8720,(a6)
		move.w	#$8C81,(a6)
	if Sonic3_Alone
		tst.b	(Debug_cheat_flag).w
		beq.s	locK_6182
		btst	#button_C,(Ctrl_1_held).w
		beq.s	loc3_483C
		move.w	#$8C89,(a6)

loc3_483C:
	else
		; No Dark Mode. I'm sad now.
		tst.b	(Debug_cheat_flag).w
		beq.s	locK_6182
	endif
		btst	#button_A,(Ctrl_1).w
		beq.s	locK_6182
		move.b	#1,(Debug_mode_flag).w
; loc3_484A:
locK_6182:
		move.w	#$8AFF,(H_int_counter_command).w
		tst.w	(Competition_mode).w
		beq.s	locK_61BE
		move.w	#$4EF9,(H_int_jump).w
		move.l	#HInt,(H_int_addr).w
		move.w	#$8014,(a6)
		move.w	#$8220,(a6)
		move.w	#$8405,(a6)
		move.w	#$8A6B,(H_int_counter_command).w
		move.w	#$9003,(a6)
		cmpi.b	#$F,(Current_zone).w
		bne.s	locK_61BE
		move.w	#$9011,(a6)
; loc3_4886:
locK_61BE:
		move.w	(H_int_counter_command).w,(a6)
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		moveq	#PalID_SonicTails,d0
	if ~~Sonic3_Alone
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_61DA
		moveq	#PalID_Knuckles,d0

locK_61DA:
	endif
		bsr.w	LoadPalette_Immediate
		bsr.w	CheckLevelForWater
		clearRAM	Water_palette_line_2,(Water_palette_end-Water_palette_line_2)
		tst.b	(Water_flag).w
		beq.s	locK_61FC
		move.w	#$8014,(a6)
; loc3_48BA:
locK_61FC:
		tst.w	(Demo_mode_flag).w		; Are we on an ending demo? (Sonic 1 leftover)
		bmi.w	locK_6310			; If so, branch (Sonic 1 leftover)
		moveq	#0,d0
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#7,d0
		lea	(LevelMusic_Playlist).l,a1
		move.b	(a1,d0.w),d0
	if ~~Sonic3_Alone
		; This was added in an attempt to fix the AIZ2 music playing
		; when returning from a Special Stage/Bonus Stage in AIZ1's
		; second half, but it doesn't work very well.
		cmpi.w	#1,(Current_zone_and_act).w
		bne.s	locK_622A
		cmpi.b	#3,(Last_star_post_hit).w
		bne.s	locK_622A
		moveq	#signextendB(mus_AIZ1),d0

locK_622A:
		cmpi.w	#$700,(Current_zone_and_act).w
		bne.s	locK_6248
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_6248
		tst.w	(SK_alone_flag).w
		beq.s	locK_6248
		tst.b	(Last_star_post_hit).w
		bne.s	locK_6248
		moveq	#signextendB(mus_Knuckles),d0

locK_6248:
	endif
		move.w	d0,(Current_music).w
		bsr.w	Play_Music
		tst.w	(Current_zone_and_act).w
		bne.s	locK_6268
	if Sonic3_Alone
		cmpi.w	#2,(Player_mode).w
		beq.s	locK_6268
		tst.b	(Last_star_post_hit).w
		beq.s	locK_62FE
; loc3_48F2:
locK_6268:
		cmpi.b	#$15,(Current_zone).w
		bhi.s	locK_62FE
		move.l	#Obj_TitleCard,(Dynamic_object_RAM+(object_size*5)).w

loc_4902:
	else
		cmpi.w	#2,(Player_mode).w
		bhs.s	locK_62B6
		tst.b	(Last_star_post_hit).w
		beq.w	locK_62FE
		bra.s	locK_62B6
; ---------------------------------------------------------------------------
; loc3_48F2:
locK_6268:
		cmpi.w	#$700,(Current_zone_and_act).w
		bne.s	locK_62B6
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_62B6
		tst.w	(SK_alone_flag).w
		beq.s	locK_62B6
		tst.b	(Last_star_post_hit).w
		bne.s	locK_62B6
		move	#$2700,sr
		move.l	#vdpComm(tiles_to_bytes(ArtTile_Animals1),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_Squirrel).l,a0
		jsr	(Nem_Decomp).l
		move.l	#vdpComm(tiles_to_bytes(ArtTile_Animals2),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_Chicken).l,a0
		jsr	(Nem_Decomp).l
		bra.s	locK_62FE
; ---------------------------------------------------------------------------

locK_62B6:
		cmpi.w	#$1701,(Current_zone_and_act).w
		beq.s	locK_62FE
		tst.b	(Act3_flag).w
		bne.s	locK_62FE
		move.l	#Obj_TitleCard,(Dynamic_object_RAM+(object_size*5)).w
	endif
; loc3_4902:
locK_62CC:
		move.b	#VInt_ID_C,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		bsr.w	Wait_VSync
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		bsr.w	Process_Nem_Queue_Init
		jsr	(Process_Kos_Module_Queue).l
		tst.w	(Dynamic_object_RAM+(object_size*5)+objoff_48).w
		bne.s	locK_62CC
		tst.l	(Nem_decomp_queue).w
		bne.s	locK_62CC
; loc3_4934:
locK_62FE:
	if ~~Sonic3_Alone
		clr.b	(Act3_flag).w
	endif
		move	#$2700,sr
		jsr	(HUD_DrawInitial).l
		move	#$2300,sr
; loc3_4942:
locK_6310:
		moveq	#PalID_SonicTails,d0
		bsr.w	LoadPalette
		jsr	(Get_LevelSizeStart).l
		jsr	(DeformBgLayer).l
		bsr.w	LoadLevelLoadBlock
		jsr	(LoadLevelLoadBlock2).l
		move	#$2700,sr
		jsr	(j_LevelSetup).l
		move	#$2300,sr
		jsr	(Animate_Init).l
	if Sonic3_Alone
		; While the code had been removed at this point, this branch was
		; STILL present. It was finally removed in Sonic 3 & Knuckles.
		jsr	(ConvertCollisionArray).l
	endif
		bsr.w	LoadSolids
		bsr.w	Handle_Onscreen_Water_Height
		move.w	(Ctrl_2).w,(_unkFF7C).w
		move.w	#0,(Ctrl_1_logical).w
		move.w	#0,(Ctrl_2_logical).w
		move.w	#0,(Ctrl_1).w
		move.w	#0,(Ctrl_2).w
		move.b	#1,(Ctrl_1_locked).w
		move.b	#1,(Ctrl_2_locked).w
		move.b	#0,(Level_started_flag).w
		tst.b	(Water_flag).w
		beq.s	locK_63A4
		cmpi.b	#1,(Current_zone).w		; Is current zone Hydrocity?
		beq.s	locK_638E			; If so, branch
		cmpi.b	#1,(Current_zone).w		; Is current zone Hydrocity?
		bne.s	locK_63A4			; If not, branch
; loc3_49C6:
locK_638E:
		move.l	#Obj_HCZWaveSplash,(Wave_Splash).w
		move.l	#Obj_HCZWaterSplash,(Dynamic_object_RAM+(object_size*2)).w
		move.b	#1,(Dynamic_object_RAM+(object_size*2)+subtype).w

locK_63A4:
	if ~~Sonic3_Alone
		cmpi.b	#7,(Current_zone).w
		bne.s	locK_63B4
		move.l	#Obj_MHZ_Pollen_Spawner,(Dynamic_object_RAM+object_size).w
	endif
; loc3_49DC:
locK_63B4:
		moveq	#0,d0
		tst.b	(Last_star_post_hit).w
		bne.s	locK_6404
		move.w	d0,(Ring_count).w
		move.l	d0,(Timer).w
		move.b	d0,(Extra_life_flags).w
		move.w	d0,(Ring_count_P2).w
		move.l	d0,(Timer_P2).w
	if Sonic3_Alone
		move.b	d0,(Saved2_status_secondary).w
	endif
		move.b	d0,(Saved_status_secondary).w
	if ~~Sonic3_Alone
		cmpi.w	#$1600,(Current_zone_and_act).w
		beq.s	locK_6400
		cmpi.w	#$1700,(Current_zone_and_act).w
		beq.s	locK_6400
		cmpi.w	#$1701,(Current_zone_and_act).w
		beq.s	locK_6404
		cmpi.b	#$16,(Current_zone).w
		bhs.s	locK_63FC
	endif
		cmpi.b	#$13,(Current_zone).w
		bhs.s	locK_6404

	if ~~Sonic3_Alone
locK_63FC:
		move.b	d0,(Saved2_status_secondary).w

locK_6400:
	endif
		move.b	d0,(Respawn_table_keep).w
; loc3_4A0C:
locK_6404:
		move.b	d0,(Time_over_flag).w
		move.w	d0,(Debug_placement_mode).w
		move.w	d0,(Restart_level_flag).w
		move.b	d0,(Teleport_active_timer).w
		move.b	d0,(Teleport_active_flag).w
		move.w	d0,(Total_ring_count).w
		move.w	d0,(Total_ring_count_P2).w
		move.w	d0,(Monitors_broken).w
		move.w	d0,(Monitors_broken_P2).w
		move.w	d0,(Loser_time_left).w
		move.b	d0,(LRZ_rocks_routine).w
	if (Sonic3_Alone=0)|(FixBugs=1)
		move.b	d0,(Super_Sonic_Knux_flag).w
	endif
		bsr.w	OscillateNumInit
		move.b	#1,(Update_HUD_score).w
		move.b	#1,(Update_HUD_ring_count).w
		move.b	#1,(Update_HUD_timer).w
		move.b	#1,(Level_started_flag).w
	if ~~Sonic3_Alone
		cmpi.w	#$D01,(Current_zone_and_act).w
		beq.s	locK_6460
		cmpi.w	#$1701,(Current_zone_and_act).w
		bne.s	locK_6468

locK_6460:
		clr.b	(Update_HUD_timer).w
		clr.b	(Level_started_flag).w

locK_6468:
	endif
		bsr.w	SpawnLevelMainSprites
		jsr	(Load_Sprites).l
		jsr	(Load_Rings).l
	if Sonic3_Alone
		jsr	(S2_SpecialCNZBumpers).l
	endif
		jsr	(Draw_LRZ_Special_Rock_Sprites).l
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		jsr	(Animate_Tiles).l
		move.w	#1800,(Demo_timer).w
	if Sonic3_Alone
		; Remnant from Sonic 1's credits demos.
		tst.w	(Demo_mode_flag).w
		bpl.s	loc3_4AA2
		move.w	#540,(Demo_timer).w
		cmpi.w	#4,(Ending_demo_number).w
		bne.s	loc3_4AA2
		move.w	#510,(Demo_timer).w

loc3_4AA2:
	endif
		bsr.w	LoadWaterPalette
		clearRAM	Water_palette_line_2,(Water_palette_end-Water_palette_line_2)
		move.b	#0,(Ctrl_1_locked).w
		move.b	#0,(Ctrl_2_locked).w
		jsr	GetDemoPtr(pc)
		tst.w	(Competition_mode).w
		bne.w	locK_663A
		tst.w	(Current_zone_and_act).w
		bne.s	locK_64CE
		tst.b	(Last_star_post_hit).w
		beq.s	locK_64DC
; loc3_4ADA:
locK_64CE:
		cmpi.b	#$E,(Current_zone).w
		bhs.s	locK_64DC
		jsr	(PLCLoad_AnimalsAndExplosion).l
; loc3_4AE8:
locK_64DC:
		move.w	#$2030-1,(Palette_fade_info).w
		jsr	(Pal_FillBlack).l
		move.w	#$16,(Palette_fade_timer).w
		move.w	#$16,(Dynamic_object_RAM+(object_size*5)+objoff_2E).w
	if ~~Sonic3_Alone
		move.w	#(button_up_mask|button_down_mask|button_left_mask|button_right_mask|button_B_mask|button_C_mask|button_A_mask)<<8,(Ctrl_1).w
		move.w	#(button_up_mask|button_down_mask|button_left_mask|button_right_mask|button_B_mask|button_C_mask|button_A_mask)<<8,(Ctrl_2).w
	endif
		andi.b	#$7F,(Last_star_post_hit).w
		bclr	#7,(Game_mode).w

LevelLoop:
		bsr.w	Pause_Game
		move.b	#VInt_ID_8,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		bsr.w	Wait_VSync
		addq.w	#1,(Level_frame_counter).w
		bsr.w	Demo_PlayRecord
		jsr	(Animate_Palette).l
		jsr	(SpecialEvents).l
	if ~~Sonic3_Alone
		jsr	(Load_Sprites).l
	endif
		jsr	(Process_Sprites).l
		tst.w	(Restart_level_flag).w
		bne.w	Level
		jsr	(DeformBgLayer).l
		jsr	(ScreenEvents).l
		bsr.w	Handle_Onscreen_Water_Height
	if Sonic3_Alone
		bsr.w	UpdateWaterSurface
	endif
		jsr	(Load_Rings).l
	if ~~Sonic3_Alone
		cmpi.b	#9,(Current_zone).w
		bne.s	Level_NotLRZ
		jsr	(Draw_LRZ_Special_Rock_Sprites).l

Level_NotLRZ:
	endif
		jsr	(Animate_Tiles).l
		bsr.w	Process_Nem_Queue_Init
		jsr	(Process_Kos_Module_Queue).l
		bsr.w	OscillateNumDo
		bsr.w	ChangeRingFrame
		jsr	(Render_Sprites).l
	if Sonic3_Alone
		jsr	(Load_Sprites).l
	else
		cmpi.b	#$15,(Current_zone).w
		bne.s	Level_NotSlots
		jsr	(Slots_RenderLayout).l
		jsr	(Slots_CycleOptions).l

Level_NotSlots:
	endif
		cmpi.b	#GameMode_Demo,(Game_mode).w
		beq.s	DemoMode
		cmpi.b	#GameMode_Level,(Game_mode).w
		beq.w	LevelLoop
		rts
; ---------------------------------------------------------------------------

DemoMode:
		tst.w	(Restart_level_flag).w
		bne.s	locK_65D0
		tst.w	(Demo_timer).w
		beq.s	locK_65D0
		cmpi.b	#GameMode_Demo,(Game_mode).w
		beq.w	LevelLoop
		move.b	#GameMode_SegaScreen,(Game_mode).w
		rts
; ---------------------------------------------------------------------------
; loc3_4BB2:
locK_65D0:
		cmpi.b	#GameMode_Demo,(Game_mode).w
		bne.s	locK_65E0
		move.b	#GameMode_SegaScreen,(Game_mode).w
		rts
; ---------------------------------------------------------------------------
; loc3_4BC2:
locK_65E0:
		move.w	#60,(Demo_timer).w
		move.w	#$40-1,(Palette_fade_info).w
		clr.w	(Pal_fade_delay).w
; loc3_4BD2:
locK_65F0:
		move.b	#VInt_ID_8,(V_int_routine).w
		bsr.w	Wait_VSync
		bsr.w	Demo_PlayRecord
		jsr	(Process_Sprites).l
		jsr	(DeformBgLayer).l
		jsr	(ScreenEvents).l
		jsr	(Render_Sprites).l
		jsr	(Load_Sprites).l
		jsr	(Process_Kos_Module_Queue).l
		subq.w	#1,(Pal_fade_delay).w
		bpl.s	locK_6632
		move.w	#2,(Pal_fade_delay).w
		bsr.w	Pal_ToBlack
; loc3_4C14:
locK_6632:
		tst.w	(Demo_timer).w
		bne.s	locK_65F0
		rts
; ---------------------------------------------------------------------------
; loc3_4C1C:
locK_663A:
		move.w	#0,(_unkFF7E).w
		tst.b	(Debug_cheat_flag).w
		beq.s	locK_665A
		move.b	(_unkFF7C).w,d0
		cmpi.b	#$A0,d0
		bne.s	locK_665A
		move.w	(Sound_test_sound).w,d0
		lsl.w	#8,d0
		move.w	d0,(_unkFF7E).w
; loc3_4C3C:
locK_665A:
		move.w	#$40-1,(Palette_fade_info).w
		jsr	(Pal_FillBlack).l
		move.w	#$16,(Palette_fade_timer).w
		move.w	#0,(_unkFF7C).w
		bclr	#7,(Game_mode).w
; loc3_4C5A:
locK_6678:
		bsr.w	Pause_Game
		move.b	#VInt_ID_8,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		bsr.w	Wait_VSync
		addq.w	#1,(Level_frame_counter).w
		move.w	#4,-(sp)
		bra.s	locK_66DA
; ---------------------------------------------------------------------------
; loc3_4C78:
locK_6696:
		move.w	(_unkFF7E).w,d0
		add.w	d0,(_unkFF7C).w
		bcc.s	locK_66EA
		bsr.w	Pause_Game
		move.w	#$100,(Z80_bus_request).l	; stop the Z80
		bsr.w	Poll_Controllers
		startZ80
		move.w	#0,(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		lea	(Sprite_table_input).w,a5
; loc3_4CAC:
locK_66CA:
		move.w	#0,(a5)
		lea	$80(a5),a5
		cmpa.l	#Sprite_table_input_end,a5
		blo.s	locK_66CA
; loc3_4CBC:
locK_66DA:
		bsr.w	Demo_PlayRecord
		jsr	(Process_Sprites).l
		jsr	(DeformBgLayer).l
; loc3_4CCC:
locK_66EA:
		subq.w	#1,(sp)
		bne.s	locK_6696
		addq.w	#2,sp
		tst.w	(Restart_level_flag).w
		bne.w	Level
		jsr	(ScreenEvents).l
		jsr	(Animate_Tiles).l
		jsr	(Render_Sprites).l
		jsr	(Animate_Palette).l
		bsr.w	Process_Nem_Queue_Init
		jsr	(Process_Kos_Module_Queue).l
		cmpi.b	#GameMode_Demo,(Game_mode).w
		beq.s	locK_672E
		cmpi.b	#GameMode_Level,(Game_mode).w
		beq.w	locK_6678
		rts
; ---------------------------------------------------------------------------
; loc3_4D10:
locK_672E:
		tst.w	(Restart_level_flag).w
		bne.s	locK_674C
		tst.w	(Demo_timer).w
		beq.s	locK_674C
		cmpi.b	#GameMode_Demo,(Game_mode).w
		beq.w	locK_6678
		move.b	#GameMode_SegaScreen,(Game_mode).w
		rts
; ---------------------------------------------------------------------------
; loc3_4D2E:
locK_674C:
		cmpi.b	#GameMode_Demo,(Game_mode).w
		bne.s	locK_675C
		move.b	#GameMode_SegaScreen,(Game_mode).w
		rts
; ---------------------------------------------------------------------------
; loc3_4D3E:
locK_675C:
		move.w	#60,(Demo_timer).w
		move.w	#$40-1,(Palette_fade_info).w
		clr.w	(Pal_fade_delay).w
; loc3_4D4E:
locK_676C:
		move.b	#VInt_ID_8,(V_int_routine).w
		bsr.w	Wait_VSync
		bsr.w	Demo_PlayRecord
		jsr	(Process_Sprites).l
		jsr	(DeformBgLayer).l
		jsr	(ScreenEvents).l
		jsr	(Render_Sprites).l
		jsr	(Load_Sprites).l
		jsr	(Process_Kos_Module_Queue).l
		subq.w	#1,(Pal_fade_delay).w
		bpl.s	locK_67AE
		move.w	#2,(Pal_fade_delay).w
		bsr.w	Pal_ToBlack
; loc3_4D90:
locK_67AE:
		tst.w	(Demo_timer).w
		bne.s	locK_676C
		rts