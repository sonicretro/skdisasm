; ---------------------------------------------------------------------------

LevelSelect_S2Options:
	if ~~Sonic3_Alone
		clr.w	(Current_zone_and_act).w
	endif
		bsr.w	Pal_FadeToBlack
		move	#$2700,sr
		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l
		bsr.w	Clear_DisplayData
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$8230,(a6)
		move.w	#$8700,(a6)
		move.w	#$8C81,(a6)
		move.w	#$9001,(a6)
	if ~~Sonic3_Alone
		move.w	#$8B00,(a6)
	endif
		clearRAM	Sprite_table_input,(Sprite_table_input_end-Sprite_table_input)
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		move.l	#vdpComm(tiles_to_bytes($010),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_S22POptions).l,a0
		bsr.w	Nem_Decomp
	if Sonic3_Alone
		move.l	#vdpComm(tiles_to_bytes(ArtTile_S2MenuBox),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_S2MenuBox).l,a0
		bsr.w	Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes(ArtTile_S2LevelSelectPics),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_S2LevelSelectPics).l,a0
		bsr.w	Nem_Decomp
	endif
		lea	(RAM_start).l,a1
		lea	(MapEni_S22POptions).l,a0
		move.w	#make_art_tile($000,3,0),d0
		bsr.w	Eni_Decomp
		lea	(RAM_start).l,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table,VRAM,WRITE),d0
		moveq	#40-1,d1
		moveq	#28-1,d2
		jsr	(Plane_Map_To_VRAM).l

	if Sonic3_Alone
		cmpi.b	#GameMode_OptionsMenu,(Game_mode).w	; is the game mode id equal to $24?
		beq.w	MenuScreen_Options	; if so, then branch to the options menu (leftover from Sonic 2)
		cmpi.b	#GameMode_LevelSelect,(Game_mode).w	; is the game mode id equal to $28?
		beq.w	MenuScreen_LevelSelect	; if so, then branch to the level select menu

		include	"Code/Screens/2P Level Select (Sonic 2).asm"
		include	"Code/Screens/Options Menu (Sonic 2).asm"
	endif

; ---------------------------------------------------------------------------

MenuScreen_LevelSelect:
	if Sonic3_Alone
		; Load S2's level select plane map here, for the level icon emblem
		lea	(RAM_start).l,a1
		lea	(MapEni_S2LevSel).l,a0
		move.w	#make_art_tile($000,0,0),d0
		bsr.w	Eni_Decomp
	endif

		; Remember that plane map we just decompressed? Yeah, we're deleting that
		lea	(RAM_start).l,a3
	if Sonic3_Alone
		move.w	#bytesToWcnt($320*2),d1
	else
		; Only clear 1600 bytes, in order to preserve the level icon emblem
		move.w	#bytesToWcnt($28*$1C*2),d1	; This is the size of your usual decompressed plane map
	endif

	.clearloop:
		move.w	#0,(a3)+
		dbf	d1,.clearloop

	if Sonic3_Alone
		; Remove the one zone name that wasn't cleared: Oil Ocean
		lea	(RAM_start+planeLocH28(3,$15)).l,a3
		move.w	#bytesToWcnt($20),d1

	.loop:
		move.w	#0,(a3)+
		dbf	d1,.loop
	endif

		; Build new plane map from LevelSelectText and LevSel_MappingOffsets
		save
		codepage	LEVELSELECT	; This is here so we can use '*' instead of '$1A'

		lea	(RAM_start).l,a3
		lea	(LevelSelectText).l,a1
		lea	(LevSel_MappingOffsets).l,a5
		moveq	#0,d0
	if Sonic3_Alone
		move.w	#$F-1,d1		; This is how many entries there are in LevelSelectText
	else
		move.w	#$11-1,d1		; This is how many entries there are in LevelSelectText
	endif

	.writezone:
		move.w	(a5)+,d3	; Get relative address in plane map to write to
		lea	(a3,d3.w),a2	; Get absolute address
		moveq	#0,d2
		move.b	(a1)+,d2	; Get length of string
		move.w	d2,d3		; Store it

	.writeletter:
		move.b	(a1)+,d0	; Get character from string
		;ori.w	#make_art_tile($000,0,0),d0
		move.w	d0,(a2)+	; Send it to plane map
		dbf	d2,.writeletter	; Loop for entire string

		move.w	#$D,d2		; Maximum length of string
		sub.w	d3,d2		; Get remaining space in string
		bcs.s	.stringfull	; If there is none, skip ahead

	.blankloop:
		move.w	#make_art_tile(' ',0,0),(a2)+	; Full the remaining space with blank characters
		dbf	d2,.blankloop

	.stringfull:
		move.w	#make_art_tile('1',0,0),(a2)	; Write (act) '1'
		lea	$28*2(a2),a2	; Next line
		move.w	#make_art_tile('2',0,0),(a2)	; Write (act) '2'
		dbf	d1,.writezone

		; Assuming the last line was the sound test...
		move.w	#make_art_tile(' ',0,0),(a2)	; Get rid of (act) '2'
		lea	-$28*2(a2),a2	; Go back to (act) '1'
		move.w	#make_art_tile('*',0,0),(a2)	; Replace that with '*'

	if ~~Sonic3_Alone
		; Overwrite duplicate LAVA REEF 1/2 with 3/4 (obviously, S3 didn't do this)
		move.w	#make_art_tile('3',0,0),(RAM_start+planeLocH28($25,4)).l
		move.w	#make_art_tile('4',0,0),(RAM_start+planeLocH28($25,5)).l
	endif

		restore

		; Send our built plane map to VRAM
		lea	(RAM_start).l,a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table,VRAM,WRITE),d0
		moveq	#40-1,d1
		moveq	#28-1,d2
		jsr	(Plane_Map_To_VRAM).l

		moveq	#palette_line_0,d3
		bsr.w	LevelSelect_DrawSoundNumber

	if Sonic3_Alone
		lea	(RAM_start+($28*$1C*2)).l,a1	; 2240; after the plane map
		lea	(MapEni_S2LevSelIcon).l,a0
		move.w	#make_art_tile(ArtTile_S2LevelSelectPics,0,0),d0
		bsr.w	Eni_Decomp
		bsr.w	LevelSelect_DrawIcon
	endif

		clr.w	(Player_mode).w
		clr.w	(Results_screen_2P).w
		clr.b	(Level_started_flag).w
		clr.w	(Anim_Counters).w
		lea	(AniPLC_SONICMILES).l,a2
		jsr	(AnimateTiles_DoAniPLC).l
		moveq	#PalID_S2Menu,d0
		bsr.w	LoadPalette
		lea	(Normal_palette_line_3).w,a1
		lea	(Target_palette_line_3).w,a2
		moveq	#bytesToLcnt(Normal_palette_line_4-Normal_palette_line_3),d1
; loc3_696C:
locK_7BE4:
		move.l	(a1),(a2)+
		clr.l	(a1)+
		dbf	d1,locK_7BE4
		moveq	#signextendB(mus_DataSelect),d0
		jsr	(Play_Music).l
		move.w	#(30*60)-1,(Demo_timer).w
		clr.w	(Competition_mode).w
		clr.l	(Camera_X_pos).w
		clr.l	(Camera_Y_pos).w
		clr.l	(Save_pointer).w
	if Sonic3_Alone
		move.w	#(1<<8)|1,(Level_select_flag).w
		move.w	#(1<<8)|1,(Debug_cheat_flag).w
	else
		clr.l	(Collected_special_ring_array).w
		clr.b	(Last_star_post_hit).w
		clr.b	(Special_bonus_entry_flag).w
		clr.b	(Blue_spheres_stage_flag).w
	    if 0
		; Sonic 2 Beta 4 reveals that these were the original instructions.
		; The original source code may have been able to produce debug builds with this enabled.
		move.w	#$101,(Level_select_flag).w
		move.w	#$101,(Debug_mode_flag).w
	    else
		nop
		nop
		nop
		nop
		nop
		nop
	    endif
	endif
		clr.w	(Level_select_cheat_counter).w
		clr.w	(Debug_mode_cheat_counter).w
		move.b	#VInt_ID_16,(V_int_routine).w
		bsr.w	Wait_VSync
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		bsr.w	Pal_FadeFromBlack

LevelSelect_Main:	; routine running during level select
		move.b	#VInt_ID_16,(V_int_routine).w
		bsr.w	Wait_VSync
		move	#$2700,sr
		moveq	#palette_line_0,d3
		bsr.w	LevelSelect_MarkFields
		bsr.w	LevSelControls
		move.w	#palette_line_3,d3
		bsr.w	LevelSelect_MarkFields
	if Sonic3_Alone
		bsr.w	LevelSelect_DrawIcon
	endif
		move	#$2300,sr
		lea	(AniPLC_SONICMILES).l,a2
		jsr	(AnimateTiles_DoAniPLC).l
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		andi.b	#button_start_mask,d0
		bne.s	LevelSelect_PressStart
		bra.w	LevelSelect_Main
; ---------------------------------------------------------------------------

LevelSelect_PressStart:
	if Sonic3_Alone
		move.w	(Level_select_option).w,d0
		add.w	d0,d0
		move.w	LS_Level_Order(pc,d0.w),d0
	else
		tst.w	(SK_alone_flag).w
		beq.s	locK_7CA0
		cmpi.w	#3,(Player_option).w
		bhs.s	locK_7CA0
		move.w	#1,(Player_option).w

locK_7CA0:
		move.w	(Player_option).w,(Player_mode).w
		lea	LS_Level_Order(pc),a1
		move.w	(Level_select_option).w,d0
		add.w	d0,d0
		move.w	(a1,d0.w),d0
	endif
		bmi.w	LevelSelect_Return	; sound test
		cmpi.w	#$5555,d0		; This was used in Sonic 3 for the S&K zones
		beq.w	LevelSelect_Main	; If entry is $5555, don't do anything
	if Sonic3_Alone
		cmpi.w	#$4001,d0			; Is Special Stage 2 selected?
		beq.w	LevelSelect_SpecialStage	; If so, branch
		cmpi.w	#$4000,d0			; Is Special Stage 1 selected?
		bne.w	LevelSelect_StartZone	; If not, branch
		move.b	#GameMode_SpecialStage,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

LevelSelect_SpecialStage:
		move.b	#GameMode_SpecialStage3,(Game_mode).w
		rts
; ---------------------------------------------------------------------------
		; unused leftover from Sonic 2
		move.b	#GameMode_SpecialStage_S2,(Game_mode).w
		clr.w	(Current_zone_and_act).w
		clr.w	(Apparent_zone_and_act).w
		clr.w	(Saved_zone_and_act).w
		move.b	#3,(Life_count).w
		move.b	#3,(Life_count_P2).w
		moveq	#0,d0
		move.w	d0,(Ring_count).w
		move.l	d0,(Timer).w
		move.l	d0,(Score).w
		move.w	d0,(Ring_count_P2).w
		move.l	d0,(Timer_P2).w
		move.l	d0,(Score_P2).w
		move.l	#5000,(Next_extra_life_score).w
		move.l	#5000,(Next_extra_life_score_P2).w
		move.w	(Player_option).w,(Player_mode).w
		rts
	else
		move.b	#3,(Life_count).w
		move.b	#0,(SK_special_stage_flag).w
		cmpi.w	#$4000,d0			; Is Special Stage 1 selected?
		beq.w	LevelSelect_SpecialStageCheck	; If so, branch
		cmpi.w	#$4001,d0			; Is Special Stage 2 selected?
		bne.w	LevelSelect_CheckKnuckles	; If not, branch
		move.b	#1,(SK_special_stage_flag).w

LevelSelect_SpecialStage:
		move.b	#GameMode_SpecialStage,(Game_mode).w
		tst.w	(SK_alone_flag).w
		beq.s	locretK_7D12
		cmpi.w	#$400,(Current_zone_and_act).w
		beq.s	locretK_7D12
		cmpi.w	#$700,(Current_zone_and_act).w
		bhs.s	locretK_7D12
		move.w	#$700,d0
		move.w	d0,(Current_zone_and_act).w
		move.w	d0,(Apparent_zone_and_act).w
		move.w	d0,(Saved_zone_and_act).w
		move.w	d0,(Saved_apparent_zone_and_act).w

locretK_7D12:
		rts
; ---------------------------------------------------------------------------

LevelSelect_SpecialStageCheck:
		tst.w	(SK_alone_flag).w
		beq.s	LevelSelect_SpecialStage
		move.b	#1,(SK_special_stage_flag).w
		bra.s	LevelSelect_SpecialStage
	endif
; ---------------------------------------------------------------------------
LS_Level_Order:
		dc.w     0	; AIZ act 1
		dc.w     1	; AIZ act 2
		dc.w  $100	; HCZ act 1
		dc.w  $101	; HCZ act 2
		dc.w  $200	; MGZ act 1
		dc.w  $201	; MGZ act 2
		dc.w  $300	; CNZ act 1
		dc.w  $301	; CNZ act 2
	if Sonic3_Alone
		dc.w $5555	; FBZ act 1 (disabled)
		dc.w $5555	; FBZ act 2 (disabled)
	endif
		dc.w  $500	; ICZ act 1
		dc.w  $501	; ICZ act 2
		dc.w  $600	; LBZ act 1
		dc.w  $601	; LBZ act 2
	if Sonic3_Alone
		dc.w $5555	; MHZ act 1 (disabled)
		dc.w $5555	; MHZ act 2 (disabled)
		dc.w $5555	; SOZ act 1 (disabled)
		dc.w $5555	; SOZ act 2 (disabled)
		dc.w  $E00	; ALZ
		dc.w  $F00	; BPZ
		dc.w $1000	; DPZ
		dc.w $1100	; CGZ
		dc.w $1200	; EMZ
		dc.w $1300	; 2P VS (Bonus Stage)
		dc.w $5555	; Bonus Stage (disabled)
		dc.w $5555	; Bonus Stage (disabled)
	else
		dc.w  $700	; MHZ act 1
		dc.w  $701	; MHZ act 2
		dc.w  $400	; FBZ act 1
		dc.w  $401	; FBZ act 2
		dc.w  $800	; SOZ act 1
		dc.w  $801	; SOZ act 2
		dc.w  $900	; LRZ act 1
		dc.w  $901	; LRZ act 2
		dc.w $1600	; LRZ act 3
		dc.w $1601	; LRZ act 4
		dc.w  $A00	; SSZ act 1
		dc.w  $A01	; SSZ act 2
		dc.w  $B00	; DEZ act 1
		dc.w  $B01	; DEZ act 2
		dc.w  $C00	; DDZ act 1
		dc.w $1700	; DDZ act 2
		dc.w $1400	; Bonus Stage 1
		dc.w $1500	; Bonus Stage 2
	endif
		dc.w $4000	; Special Stage 1
		dc.w $4001	; Special Stage 2
		dc.w $FFFF	; Sound Test
; ---------------------------------------------------------------------------

LevelSelect_Return:
		move.b	#GameMode_SegaScreen,(Game_mode).w
		rts
; ---------------------------------------------------------------------------
	if ~~Sonic3_Alone
LevelSelect_CheckKnuckles:
		tst.w	(Debug_cheat_flag).w
		bne.s	locK_7DBA
		cmpi.w	#3,(Player_mode).w		; Are we Knuckles?
		bne.s	LevelSelect_CheckSonicTails	; If not, branch
		cmpi.w	#$A00,d0			; Is SSZ act 1 selected?
		beq.s	LevelSelect_DenySelection	; If so, branch and deny entry
		cmpi.w	#$C00,d0			; Is DDZ act 1 selected?
		beq.s	LevelSelect_DenySelection	; If so, branch and deny entry
		cmpi.w	#$1600,d0			; Is LRZ act 3 selected?
		beq.s	LevelSelect_DenySelection	; If so, branch and deny entry
		cmpi.w	#$1700,d0			; Is DDZ act 2 selected?
		bne.s	LevelSelect_CheckSonicTails	; If not, branch


LevelSelect_DenySelection:
		moveq	#signextendB(sfx_Error),d0			; Play error buzzer sound
		jsr	(Play_SFX).l
		bra.w	LevelSelect_Main
; ---------------------------------------------------------------------------

LevelSelect_CheckSonicTails:
		cmpi.w	#3,(Player_mode).w		; Are we Knuckles (any character with an ID of 3+)?
		bhs.s	locK_7DAC			; If so, branch
		cmpi.w	#$A01,d0			; Is SSZ act 2 selected?
		beq.s	LevelSelect_DenySelection	; If so, branch and deny entry

locK_7DAC:
		cmpi.w	#2,(Player_mode).w		; Are we Tails?
		bne.s	locK_7DBA			; If not, branch
		cmpi.w	#$C00,d0			; Is DDZ act 1 selected?
		beq.s	LevelSelect_DenySelection	; If so, branch and deny entry

locK_7DBA:
		tst.w	(SK_alone_flag).w	; Are we playing S3K and not S&K?
		beq.s	LevelSelect_StartZone	; If so, branch
		; This here stops you from accessing S3 zones in S&K
		move.w	d0,d1			; Load selection
		move.b	#0,d1			; Eliminate act byte, leaving only the zone
		cmpi.w	#$400,d1		; Is FBZ selected?
		beq.s	LevelSelect_StartZone	; If so, branch
		cmpi.w	#$700,d1		; Is any other S&K zone selected?
		bhs.s	LevelSelect_StartZone	; If so, branch
		move.w	#$700,d0		; If any S3 zone is selected, force it to be MHZ
	endif

LevelSelect_StartZone:
		andi.w	#$3FFF,d0
		move.w	d0,(Current_zone_and_act).w
		move.w	d0,(Apparent_zone_and_act).w
		move.w	d0,(Saved_zone_and_act).w
	if (Sonic3_Alone=0)|(FixBugs=1)
		; Sonic 3 Alone fails to set the saved apparent zone and act. This causes the "Doilus Stage" bug found in the level select when entering a Bonus Stage.
		; This can also be affected by checkpoints as well when returning to the level select from different zones.
		; This bug was fixed in Sonic & Knuckles since the 0517 Prototype.
		move.w	d0,(Saved_apparent_zone_and_act).w
	endif
	if ~~Sonic3_Alone
		move.w	#$1000,d0
		move.w	d0,(Saved_camera_max_Y_pos).w
		move.w	d0,(Saved2_camera_max_Y_pos).w
	endif
		move.b	#GameMode_Level,(Game_mode).w
		move.b	#3,(Life_count).w
		move.b	#3,(Life_count_P2).w
		moveq	#0,d0
		move.w	d0,(Ring_count).w
		move.l	d0,(Timer).w
		move.l	d0,(Score).w
		move.w	d0,(Ring_count_P2).w
		move.l	d0,(Timer_P2).w
		move.l	d0,(Score_P2).w
		move.b	d0,(Continue_count).w
	if ~~Sonic3_Alone
		move.w	d0,(Demo_mode_flag).w
	endif
		move.l	#5000,(Next_extra_life_score).w
		move.l	#5000,(Next_extra_life_score_P2).w
		moveq	#signextendB(cmd_FadeOut),d0
		jsr	(Play_SFX).l
		moveq	#0,d0
		move.w	d0,(Competition_settings).w
		move.w	d0,(Competition_mode).w
		cmpi.b	#$E,(Current_zone).w
		blo.s	locretK_7E62
		cmpi.b	#$13,(Current_zone).w
		bhs.s	locretK_7E62
		move.w	#1,(Competition_mode).w
; locret3_6B48:
locretK_7E62:
		rts

; =============== S U B R O U T I N E =======================================


LevSelControls:
		move.b	(Ctrl_1_pressed).w,d1
		andi.b	#button_up_mask|button_down_mask,d1
		bne.s	locK_7E74	; up/down pressed
		subq.w	#1,(Level_select_repeat).w
		bpl.s	LevSelControls_CheckLR
; loc3_6B5A:
locK_7E74:
		move.w	#$B,(Level_select_repeat).w
		move.b	(Ctrl_1).w,d1
		andi.b	#button_up_mask|button_down_mask,d1
		beq.s	LevSelControls_CheckLR	; up/down not pressed, check for left & right
		move.w	(Level_select_option).w,d0
		btst	#button_up,d1
		beq.s	locK_7E94
		subq.w	#1,d0		; decrease by 1
		bcc.s	locK_7E94	; >= 0?
	if Sonic3_Alone
		moveq	#$1C,d0		; set to $1C
	else
		moveq	#$20,d0		; set to $20
	endif
; loc3_6B7A:
locK_7E94:
		btst	#button_down,d1
		beq.s	locK_7EA4
		addq.w	#1,d0		; yes, add 1
	if Sonic3_Alone
		cmpi.w	#$1D,d0
	else
		cmpi.w	#$21,d0
	endif
		blo.s	locK_7EA4	; smaller than $1D/$21?
		moveq	#0,d0		; if not, set to 0
; loc3_6B8A:
locK_7EA4:
		move.w	d0,(Level_select_option).w
		rts
; ---------------------------------------------------------------------------

LevSelControls_CheckLR:
	if Sonic3_Alone
		cmpi.w	#$1C,(Level_select_option).w		; are we in the sound test?
	else
		cmpi.w	#$20,(Level_select_option).w		; are we in the sound test?
	endif
		bne.s	LevSelControls_SwitchSide	; no
		move.w	(Sound_test_sound).w,d0
		move.b	(Ctrl_1_pressed).w,d1
		btst	#button_left,d1
		beq.s	locK_7EC6
		subq.b	#1,d0
		bcc.s	locK_7EC6
		moveq	#0,d0
; loc3_6BAC:
locK_7EC6:
		btst	#button_right,d1
		beq.s	locK_7ED6
		addq.b	#1,d0
		cmpi.w	#$100,d0
		blo.s	locK_7ED6
		moveq	#0,d0
; loc3_6BBC:
locK_7ED6:
		btst	#button_A,d1
		beq.s	locK_7EE4
		addi.b	#$10,d0
		andi.b	#$FF,d0
; loc3_6BCA:
locK_7EE4:
		move.w	d0,(Sound_test_sound).w
		btst	#button_C,d1
		beq.s	locK_7EF8
		move.w	(Sound_test_sound).w,d0
		jsr	(Play_Music).l
	if Sonic3_Alone
		lea	(DebugCodeDat).l,a0
		lea	(AllEmeraldsCodeDat).l,a2
		lea	(Debug_cheat_flag).w,a1
		moveq	#1,d2
		bra.w	CheckCheats
; ---------------------------------------------------------------------------
	endif
; loc3_6BF4:
locK_7EF8:
		btst	#button_B,d1
		beq.s	locretK_7F06
		moveq	#signextendB(cmd_MutePSG),d0
		jsr	(Play_Music).l
; locret3_6C02:
locretK_7F06:
		rts
; ---------------------------------------------------------------------------

LevSelControls_SwitchSide:
		move.b	(Ctrl_1_pressed).w,d1
		andi.b	#button_left_mask|button_right_mask,d1
		beq.s	locK_7F1E
		move.w	(Level_select_option).w,d0
		move.b	LevelSelect_SwitchTable(pc,d0.w),d0
		move.w	d0,(Level_select_option).w
; loc3_6C1A:
locK_7F1E:
		bra.s	LevelSelect_PickCharacterNumber
; ---------------------------------------------------------------------------
		; unused
		rts
; ---------------------------------------------------------------------------
LevelSelect_SwitchTable:
		dc.b $12	; 0
		dc.b $13	; 1
		dc.b $14	; 2
		dc.b $15	; 3
		dc.b $16	; 4
		dc.b $17	; 5
		dc.b $18	; 6
		dc.b $19	; 7
		dc.b $1A	; 8
		dc.b $1B	; 9
		dc.b $1C	; 10
	if Sonic3_Alone
		dc.b $1C	; 11
		dc.b $1C	; 12
		dc.b $1C	; 13
		dc.b $1C	; 14
		dc.b $1C	; 15
		dc.b $1C	; 16
		dc.b $1C	; 17
	else
		dc.b $1D	; 11
		dc.b $1E	; 12
		dc.b $1F	; 13
		dc.b $20	; 14
		dc.b $20	; 15
		dc.b $20	; 16
		dc.b $20	; 17
	endif
		dc.b 0		; 18
		dc.b 1		; 19
		dc.b 2		; 20
		dc.b 3		; 21
		dc.b 4		; 22
		dc.b 5		; 23
		dc.b 6		; 24
		dc.b 7		; 25
		dc.b 8		; 26
		dc.b 9		; 27
		dc.b $A		; 28
		dc.b $B		; 29
	if ~~Sonic3_Alone
		dc.b $C		; 30
		dc.b $D		; 31
		dc.b $E		; 32
		dc.b $F		; 33
		dc.b $10	; 34
		dc.b $11	; 35
	endif
; ---------------------------------------------------------------------------

LevelSelect_PickCharacterNumber:
	if Sonic3_Alone
		btst	#button_C,(Ctrl_1_pressed).w
		beq.s	loc3_6C56
		addq.b	#1,(P1_character).w
		cmpi.b	#3,(P1_character).w
		blo.s	loc3_6C56
		move.b	#0,(P1_character).w

loc3_6C56:
		btst	#button_C,(Ctrl_2_pressed).w
		beq.s	locretK_7F60
		addq.b	#1,(P2_character).w
		cmpi.b	#3,(P2_character).w
		blo.s	locretK_7F60
		move.b	#0,(P2_character).w
	else
		btst	#button_C,(Ctrl_1_pressed).w
		beq.s	locretK_7F60
		addq.w	#1,(Player_option).w
		cmpi.w	#4,(Player_option).w
		blo.s	locretK_7F60
		move.w	#0,(Player_option).w
	endif
; locret3_6C70:
locretK_7F60:
		rts
; End of function LevSelControls


; =============== S U B R O U T I N E =======================================


LevelSelect_MarkFields:
		lea	(RAM_start).l,a4
		lea	(LevSel_MarkTable).l,a5
		lea	(VDP_data_port).l,a6
		moveq	#0,d0
		move.w	(Level_select_option).w,d0
		lsl.w	#2,d0
		lea	(a5,d0.w),a3
		moveq	#0,d0
		move.b	(a3),d0
		mulu.w	#$28*2,d0
		moveq	#0,d1
		move.b	1(a3),d1
		add.w	d1,d0
		lea	(a4,d0.w),a1
		moveq	#0,d1
		move.b	(a3),d1
		lsl.w	#7,d1
		add.b	1(a3),d1
		addi.w	#VRAM_Plane_A_Name_Table,d1
		lsl.l	#2,d1
		lsr.w	#2,d1
		ori.w	#vdpComm($0000,VRAM,WRITE)>>16,d1
		swap	d1
		move.l	d1,VDP_control_port-VDP_data_port(a6)
		moveq	#$F-1,d2
; loc3_6CC2:
locK_7FB2:
		move.w	(a1)+,d0
		add.w	d3,d0
		move.w	d0,(a6)
		dbf	d2,locK_7FB2
		addq.w	#2,a3
		moveq	#0,d0
		move.b	(a3),d0
		beq.s	locK_7FF6
		mulu.w	#$50,d0
		moveq	#0,d1
		move.b	1(a3),d1
		add.w	d1,d0
		lea	(a4,d0.w),a1
		moveq	#0,d1
		move.b	(a3),d1
		lsl.w	#7,d1
		add.b	1(a3),d1
		addi.w	#VRAM_Plane_A_Name_Table,d1
		lsl.l	#2,d1
		lsr.w	#2,d1
		ori.w	#vdpComm($0000,VRAM,WRITE)>>16,d1
		swap	d1
		move.l	d1,VDP_control_port-VDP_data_port(a6)
		move.w	(a1)+,d0
		add.w	d3,d0
		move.w	d0,(a6)
; loc3_6D06:
locK_7FF6:
	if Sonic3_Alone
		cmpi.w	#$1C,(Level_select_option).w
	else
		cmpi.w	#$20,(Level_select_option).w
	endif
		bne.s	LevelSelect_DrawCharacterNumber
		bra.w	LevelSelect_DrawSoundNumber
; ---------------------------------------------------------------------------

LevelSelect_DrawCharacterNumber:
	if Sonic3_Alone
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$1B8,VRAM,WRITE),(VDP_control_port).l
		move.b	(P1_character).w,d0
		bsr.s	LevelSelect_DrawContinued
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$1C0,VRAM,WRITE),(VDP_control_port).l
		move.b	(P2_character).w,d0
	else
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$19C,VRAM,WRITE),(VDP_control_port).l
		move.w	(Player_option).w,d0
	endif
		bra.s	LevelSelect_DrawContinued
; End of function LevelSelect_MarkFields


; =============== S U B R O U T I N E =======================================


LevelSelect_DrawSoundNumber:
	if Sonic3_Alone
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$846,VRAM,WRITE),(VDP_control_port).l
	else
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$B46,VRAM,WRITE),(VDP_control_port).l
	endif
		move.w	(Sound_test_sound).w,d0

LevelSelect_DrawContinued:
		move.b	d0,d2
		lsr.b	#4,d0
		bsr.s	subK_8028
		move.b	d2,d0
; sub3_6D48:
subK_8028:
		andi.w	#$F,d0
		cmpi.b	#$A,d0
		blo.s	locK_8036
		addi.b	#4,d0
; loc3_6D56:
locK_8036:
		addi.b	#$10,d0
		add.w	d3,d0
		move.w	d0,(a6)
		rts
; End of function LevelSelect_DrawSoundNumber

	if Sonic3_Alone
; =============== S U B R O U T I N E =======================================


LevelSelect_DrawIcon:
		move.w	(Level_select_option).w,d0
		lea	(LevSel_IconTable).l,a3
		lea	(a3,d0.w),a3
		lea	(RAM_start+$8C0).l,a1
		moveq	#0,d0
		move.b	(a3),d0
		lsl.w	#3,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		lea	(a1,d0.w),a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$B36,VRAM,WRITE),d0
		moveq	#4-1,d1
		moveq	#3-1,d2
		jsr	(Plane_Map_To_VRAM).l
		lea	(Pal_S2LevelIcons).l,a1
		moveq	#0,d0
		move.b	(a3),d0
		lsl.w	#5,d0
		lea	(a1,d0.w),a1
		lea	(Normal_palette_line_3).w,a2
	if FixBugs
		; When the icon changes, the colors are briefly incorrect. This is
		; because there's a delay between the icon being updated and the
		; colors being updated, due to the colors being uploaded to the VDP
		; during V-Int. To avoid this we can upload the colors ourselves right
		; here.
		; Prepare the VDP for data transfer.
		move.l  #vdpComm(2*16*2,CRAM,WRITE),VDP_control_port-VDP_data_port(a6)
	endif
		moveq	#bytesToLcnt($20),d1

loc3_6DAA:
	if FixBugs
		; Upload colors to the VDP.
		move.l	(a1),(a6)
	endif
		move.l	(a1)+,(a2)+
		dbf	d1,loc3_6DAA
		rts
; End of function LevelSelect_DrawIcon

; ---------------------------------------------------------------------------
LevSel_IconTable:
		dc.b    0,   0
		dc.b    7,   7
		dc.b    8,   8
		dc.b    6,   6
		dc.b    2,   2
		dc.b    5,   5
		dc.b    4,   4
		dc.b    1,   1
		dc.b    9,   9
		dc.b   $A,  $A
		dc.b    3,   3
		dc.b   $B,  $B
		dc.b   $B,  $B
		dc.b   $C,  $C
		dc.b   $E,   0
	endif

LevSel_MarkTable:	; 4 bytes per level select entry
; line primary, 2*column ($E fields), line secondary, 2*column secondary (1 field)
		dc.b    1,   6,   1, $24
		dc.b    1,   6,   2, $24
		dc.b    4,   6,   4, $24
		dc.b    4,   6,   5, $24
		dc.b    7,   6,   7, $24
		dc.b    7,   6,   8, $24
		dc.b   $A,   6,  $A, $24
		dc.b   $A,   6,  $B, $24
		dc.b   $D,   6,  $D, $24
		dc.b   $D,   6,  $E, $24
		dc.b  $10,   6, $10, $24
		dc.b  $10,   6, $11, $24
		dc.b  $13,   6, $13, $24
		dc.b  $13,   6, $14, $24
		dc.b  $16,   6, $16, $24
		dc.b  $16,   6, $17, $24
		dc.b  $19,   6, $19, $24
		dc.b  $19,   6, $1A, $24
; --- second column ---
		dc.b    1, $2C,   1, $4A
		dc.b    1, $2C,   2, $4A
		dc.b    4, $2C,   4, $4A
		dc.b    4, $2C,   5, $4A
		dc.b    7, $2C,   7, $4A
		dc.b    7, $2C,   8, $4A
		dc.b   $A, $2C,  $A, $4A
		dc.b   $A, $2C,  $B, $4A
		dc.b   $D, $2C,  $D, $4A
		dc.b   $D, $2C,  $E, $4A
		dc.b  $10, $2C, $10, $4A
	if ~~Sonic3_Alone
		dc.b  $10, $2C, $11, $4A
		dc.b  $13, $2C, $13, $4A
		dc.b  $13, $2C, $14, $4A
		dc.b  $16, $2C, $16, $4A
	endif

LevSel_MappingOffsets:
		dc.w planeLocH28(3,1)
		dc.w planeLocH28(3,4)
		dc.w planeLocH28(3,7)
		dc.w planeLocH28(3,$A)
		dc.w planeLocH28(3,$D)
		dc.w planeLocH28(3,$10)
		dc.w planeLocH28(3,$13)
		dc.w planeLocH28(3,$16)
		dc.w planeLocH28(3,$19)
		dc.w planeLocH28($16,1)
		dc.w planeLocH28($16,4)
		dc.w planeLocH28($16,7)
		dc.w planeLocH28($16,$A)
		dc.w planeLocH28($16,$D)
		dc.w planeLocH28($16,$10)
		dc.w planeLocH28($16,$13)
	if ~~Sonic3_Alone
		dc.w planeLocH28($16,$16)
	endif

	if Sonic3_Alone
; =============== S U B R O U T I N E =======================================


CheckCheats:
		move.w	(Level_select_cheat_counter).w,d0
		adda.w	d0,a0
		move.w	(Sound_test_sound).w,d0
		cmp.b	(a0),d0
		bne.s	loc3_6E88
		addq.w	#1,(Level_select_cheat_counter).w
		tst.b	1(a0)
		bne.s	loc3_6E8E
		move.w	#(1<<8)|1,(a1)
		moveq	#signextendB(sfx_RingRight),d0
		jsr	(Play_SFX).l

loc3_6E88:
		move.w	#0,(Level_select_cheat_counter).w

loc3_6E8E:
		move.w	(Debug_mode_cheat_counter).w,d0
		adda.w	d0,a2
		move.w	(Sound_test_sound).w,d0
		cmp.b	(a2),d0
		bne.s	loc3_6EC8
		addq.w	#1,(Debug_mode_cheat_counter).w
		tst.b	1(a2)
		bne.s	locret3_6ECE
		tst.w	d2
		bne.s	loc3_6EBA
		move.b	#$F,(Continue_count).w
		moveq	#signextendB(mus_Continue),d0
		jsr	(Play_Music).l
		bra.s	loc3_6EC8
; ---------------------------------------------------------------------------

loc3_6EBA:
		move.w	#7,(Chaos_emerald_count).w
		moveq	#signextendB(mus_Emerald),d0
		jsr	(Play_Music).l

loc3_6EC8:
		move.w	#0,(Debug_mode_cheat_counter).w

locret3_6ECE:
		rts
; End of function CheckCheats

; ---------------------------------------------------------------------------
S2LevelSelectCodeDat:
		dc.b  $19, $65,   9, $17,   0
S2ContinueCodeDat:
		dc.b    1,   1,   2,   4,   0
DebugCodeDat:
		dc.b    1,   3,   5,   7,   0
AllEmeraldsCodeDat:
		dc.b    2,   4,   5,   6,   0
TextOptScr_PlayerSelect:
		levselstr "* PLAYER SELECT *"
TextOptScr_SonicAndMiles:
		levselstr "SONIC AND MILES"
TextOptScr_SonicAndTails:
		levselstr "SONIC AND TAILS"
TextOptScr_SonicAlone:
		levselstr "SONIC ALONE    "
TextOptScr_MilesAlone:
		levselstr "MILES ALONE    "
TextOptScr_TailsAlone:
		levselstr "TAILS ALONE    "
TextOptScr_VsModeItems:
		levselstr "* VS MODE ITEMS *"
TextOptScr_AllKindsItems:
		levselstr "ALL KINDS ITEMS"
TextOptScr_TeleportOnly:
		levselstr "TELEPORT ONLY  "
TextOptScr_SoundTest:
		levselstr "*  SOUND TEST   *"
TextOptScr_0:
		levselstr "      00       "
Text2P_EmeraldHill:
		levselstr "EMERALD HILL"
Text2P_MysticCave:
		levselstr " MYSTIC CAVE"
Text2P_CasinoNight:
		levselstr "CASINO NIGHT"
Text2P_SpecialStage:
		levselstr "SPECIAL STAGE"
Text2P_Special:
		levselstr "   SPECIAL  "
Text2P_Zone:
		levselstr "ZONE "
Text2P_Stage:
		levselstr "STAGE"
Text2P_GameOver:
		levselstr "GAME OVER"
Text2P_TimeOver:
		levselstr "TIME OVER"
Text2P_NoGame:
		levselstr "NO GAME"
Text2P_Tied:
		levselstr "TIED"
Text2P_1P:
		levselstr " 1P"
Text2P_2P:
		levselstr " 2P"
Text2P_Blank:
		levselstr "    "
	endif

LevelSelectText:
		levselstr "ANGEL ISLAND"
		levselstr "HYDROCITY"
		levselstr "MARBLE GARDEN"
		levselstr "CARNIVAL NIGHT"
	if Sonic3_Alone
		levselstr "FLYING BATTERY"
	endif
		levselstr "ICECAP"
		levselstr "LAUNCH BASE"
	if Sonic3_Alone
		levselstr "MUSHROOM VALLEY"
		levselstr "SANDOPOLIS"
		levselstr "2P VS"
		levselstr "2P VS"
		levselstr "2P VS"
	else
		levselstr "MUSHROOM HILL"
		levselstr "FLYING BATTERY"
		levselstr "SANDOPOLIS"
		levselstr "LAVA REEF"
		levselstr "LAVA REEF"
		levselstr "SKY SANCTUARY"
		levselstr "DEATHEGG"
		levselstr "THE DOOMSDAY"
	endif
		levselstr "BONUS"
		levselstr "SPECIAL STAGE"
		levselstr "SOUND TEST  *"
		even

	if Sonic3_Alone
Pal_S2LevelIcons:
		binclude "General/S2Menu/Palettes/Level Select Icons.bin"
		even
MapEni_S2LevSel2P:
		binclude "General/S2Menu/Enigma Map/Level Select 2P.eni"
		even
MapEni_S2Options:
		binclude "General/S2Menu/Enigma Map/Options Screen.eni"
		even
MapEni_S2LevSel:
		binclude "General/S2Menu/Enigma Map/Level Select.eni"
		even
MapEni_S2LevSelIcon:
		binclude "General/S2Menu/Enigma Map/Level Select Icons.eni"
		even
	endif

AniPLC_SONICMILES: zoneanimstart
	; Sonic/Miles animated background
	zoneanimdecl  -1, ArtUnc_SONICMILES, $001,  6, $A
		dc.b    0, $C7
		dc.b   $A,   5
		dc.b  $14,   5
		dc.b  $1E, $C7
		dc.b  $14,   5
		dc.b   $A,   5
		even
	zoneanimend