; ---------------------------------------------------------------------------

Title_Screen:
		moveq	#signextendB(cmd_FadeOut),d0
		bsr.w	Play_Music			; Fade music if any is playing
	if ~~Sonic3_Alone
		clr.w	(Kos_decomp_queue_count).w
		clearRAM	Kos_decomp_stored_registers,(Kos_decomp_module_end-Kos_decomp_stored_registers)	; Clear FFFF10-FFFF7B
	endif
		bsr.w	Clear_Nem_Queue
	if ~~Sonic3_Alone
		clr.w	(Current_zone_and_act).w		; Clear zone/act index
	endif
		bsr.w	Pal_FadeToBlack		; Fade out
		move	#$2700,sr
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)			; Command $8004 - Disable HInt, HV Counter
		move.w	#$8230,(a6)			; Command $8230 - Nametable A at $C000
		move.w	#$8407,(a6)			; Command $8407 - Nametable B at $E000
	if Sonic3_Alone
		move.w	#$9011,(a6)			; Command $9011 - 64x64 cell nametable area
	else
		move.w	#$9001,(a6)			; Command $9001 - 64x32 cell nametable area
	endif
		move.w	#$9200,(a6)			; Command $9200 - Window V position at default
		move.w	#$8B03,(a6)			; Command $8B03 - Vscroll full, HScroll line-based
		move.w	#$8700,(a6)			; Command $8700 - BG color is Pal 0 Color 0
		clr.b	(Water_full_screen_flag).w
	if ~~Sonic3_Alone
		clr.b	(Water_flag).w		; Both water flags cleared
	endif
		move.w	#$8C81,(a6)			; Command $8C81 - 40cell screen size, no interlacing, no s/h
		bsr.w	Clear_DisplayData
		clearRAM	Sprite_table_input,(Sprite_table_input_end-Sprite_table_input)		; Clear object display array
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)	; Clear SST array
		clearRAM	Tails_CPU_interact,(Sprite_table-Tails_CPU_interact)	; Clear active play variables
		clearRAM	Camera_RAM,(Camera_RAM_end-Camera_RAM)	; Clear play positional values
		jsr	(Init_SpriteTable).l		; Initialize the sprite table
		clearRAM	Normal_palette,(Stack_contents-Normal_palette)	; Clear main palette
	if Sonic3_Alone
		move.b	#0,(Last_star_post_hit).w
		move.b	#0,(Special_bonus_entry_flag).w
		move.w	#0,(Debug_placement_mode).w
		move.w	#0,(Demo_mode_flag).w
		move.w	#0,(Palette_cycle_counter1).w
		move.w	#0,(Competition_mode).w		; Clear Competition mode
		move.b	#0,(Level_started_flag).w
		move.b	#0,(Debug_mode_flag).w
		move.w	#0,(Competition_mode).w		; Clear Competition mode again?
		move.w	#0,(Level_select_cheat_counter).w
		move.w	#0,(Debug_mode_cheat_counter).w
	else
		moveq	#0,d0
		move.b	d0,(Last_star_post_hit).w
		move.b	d0,(Special_bonus_entry_flag).w
		move.w	d0,(Debug_placement_mode).w
		move.w	d0,(Demo_mode_flag).w
		move.w	d0,(Palette_cycle_counter1).w
		move.w	d0,(Competition_mode).w		; Clear Competition mode
		move.b	d0,(Level_started_flag).w
		move.b	d0,(Debug_mode_flag).w
		move.w	d0,(Competition_mode).w		; Clear Competition mode again?
		move.w	d0,(Level_select_cheat_counter).w
		move.w	d0,(Debug_mode_cheat_counter).w
		move.b	d0,(Blue_spheres_stage_flag).w
	endif
		move.w	#(6*60)-1,(Demo_timer).w		; Wait on title screen for six seconds
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w	; Clear DMA queue
	if ~~Sonic3_Alone
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
		tst.w	(SK_alone_flag).w
		bne.w	SK_Alone_Title_Screen
	endif
		lea	(ArtKos_S3TitleSonic1).l,a0	;S3DATA
		lea	(RAM_start).l,a1
		bsr.w	Kos_Decomp
		move.w	a1,d3
		lsr.w	#1,d3
	if Sonic3_Alone
		move.l	#RAM_start,d1
		move.w	#tiles_to_bytes($000),d2
		andi.l	#$FFFFFF,d1
	else
		move.l	#RAM_start&$FFFFFF,d1
		move.w	#tiles_to_bytes($000),d2
	endif
		jsr	(Add_To_DMA_Queue).l		; DMA Sega logo+Sonic art data 1 to $0 in VRAM
		lea	(RAM_start+$8000).w,a1
		lea	(MapEni_S3TitleSonic1).l,a0	;S3DATA
		move.w	#make_art_tile($000,0,0),d0
		bsr.w	Eni_Decomp			; Decompress Enigma mappings
	if ~~Sonic3_Alone
		tst.b	(Graphics_flags).w
		bmi.s	locK_3F7E
		moveq	#0,d0
		move.l	d0,(RAM_start+$83AC).w		; Hide trademark symbol if the console is Japanese

locK_3F7E:
	endif
		lea	(RAM_start+$8000).w,a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table,VRAM,WRITE),d0
		moveq	#40-1,d1
		moveq	#28-1,d2
		jsr	(Plane_Map_To_VRAM).l		; Copy screen mappings to VRAM
		lea	(Pal_TitleSonic1).l,a0
		lea	(Target_palette).w,a1
		moveq	#bytesToLcnt(Target_palette_line_2-Target_palette),d0
; loc3_36AE:
locK_3F9E:
		move.l	(a0)+,(a1)+				; Fill 2 palette lines with title screen data
		dbf	d0,locK_3F9E
		move.w	#4*60,(Demo_timer).w
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l			; Turn the display on
		bsr.w	Pal_FadeFromBlack		; Fade in to logo
		moveq	#signextendB(cmd_SEGA),d0
		bsr.w	Play_Music
		move.w	#3*60,(Demo_timer).w		; Set to wait for 3 seconds

Wait_Sega:
		move.b	#VInt_ID_14,(V_int_routine).w
		bsr.w	Wait_VSync				; Wait for SEGA sound
		move.b	(Ctrl_1_pressed).w,d0
	if Sonic3_Alone
		or.b	(Ctrl_2_pressed).w,d0
	endif
		andi.b	#button_start_mask,d0
		bne.w	locK_3FE4				; If start was pressed, skip ahead
		tst.w	(Demo_timer).w
		bne.s	Wait_Sega
; loc3_36F8:
locK_3FE4:
		moveq	#signextendB(cmd_StopSEGA),d0
		bsr.w	Play_Music				; Stop SEGA sound
		lea	(Pal_Title).l,a1
; loc3_3704:
locK_3FF0:
		move.b	#VInt_ID_2,(V_int_routine).w
		bsr.w	Wait_VSync
		lea	(Normal_palette).w,a2
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		move.w	(a1)+,(a2)+
		tst.w	-$E(a1)					; Wait for BG color to turn to black
		bne.s	locK_3FF0
		clr.w	(_unkF660).w
		clr.w	(_unkF662).w
		move.b	#-1,(Title_anim_buffer).w
		move.b	#0,(Title_anim_delay).w
		move.w	#1,(Title_anim_frame).w		; Set initial variables for Sonic animation page flipping
		moveq	#1,d0
		bsr.w	TitleSonic_LoadFrame
		move.w	#15*60,(Demo_timer).w		; Set to wait 15 seconds (900 frames in NTSC)
	if ~~Sonic3_Alone
		btst	#6,(Graphics_flags).w
		beq.s	locK_4040
		move.w	#15*50,(Demo_timer).w		; Set to wait 15 seconds (750 frames in PAL)

locK_4040:
	endif
		lea	(ArtKos_S3TitleSonic8).l,a1
		lea	(RAM_start).l,a2
		jsr	(Queue_Kos).l				; Queue frame 8 of data into a2 since frame 1 is already in VRAM
		moveq	#signextendB(mus_TitleScreen),d0
		bsr.w	Play_Music				; Start playing the title screen music

Wait_Title:
		move.b	#VInt_ID_4,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		bsr.w	Wait_VSync
		bsr.w	Iterate_TitleSonicFrame
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		bsr.w	Process_Nem_Queue_Init
	if Sonic3_Alone
		bsr.w	S3_Level_Select_Code
	endif
		move.b	(Ctrl_1_pressed).w,d0
	if Sonic3_Alone
		or.b	(Ctrl_2_pressed).w,d0
	endif
		andi.b	#button_start_mask,d0
		bne.w	locK_4090			; If start was pressed, skip straight to title
		cmpi.w	#$C,(Title_anim_frame).w
		blo.s	Wait_Title		; If last frame was reached, don't repeat
; loc3_379E:
locK_4090:
		move.w	#$C,(Title_anim_frame).w
		lea	(Normal_palette).w,a1
		moveq	#bytesToWcnt(Normal_palette_end-Normal_palette),d1
; loc3_37AA:
locK_409C:
		move.w	#$EEE,(a1)+
		dbf	d1,locK_409C				; Flash palette white
		move.b	#3,(Title_anim_delay).w
		move.b	#VInt_ID_4,(V_int_routine).w
		bsr.w	Wait_VSync
		lea	(ArtKos_S3TitleSonicD).l,a0	;S3DATA
		lea	(RAM_start).l,a1
		bsr.w	Kos_Decomp
		move.w	a1,d3
		lsr.w	#1,d3
		move.l	#RAM_start,d1
		move.w	#tiles_to_bytes($000),d2
		andi.l	#$FFFFFF,d1
		jsr	(Add_To_DMA_Queue).l		; Load Sonic art frame 14
		lea	(Level_layout_header).w,a1
		lea	(MapEni_S3TitleSonicD).l,a0
		move.w	#make_art_tile($000,0,1),d0
		bsr.w	Eni_Decomp
		lea	(Level_layout_header).w,a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table,VRAM,WRITE),d0
		moveq	#40-1,d1
		moveq	#28-1,d2
		jsr	(Plane_Map_To_VRAM).l		; Load Sonic mapping frame 14 to $C000 VRAM
		lea	(Level_layout_header).w,a1
		lea	(MapEni_S3TitleBg).l,a0
		move.w	#make_art_tile($000,2,0),d0
		bsr.w	Eni_Decomp
		lea	(Level_layout_header).w,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table,VRAM,WRITE),d0
		moveq	#40-1,d1
		moveq	#28-1,d2
		jsr	(Plane_Map_To_VRAM).l		; Load S3K Title BG to $E000 VRAM
		move.b	#VInt_ID_4,(V_int_routine).w
		bsr.w	Wait_VSync
		lea	(Pal_TitleSonicD).l,a0		; Title palette
		lea	(Target_palette).w,a1
		moveq	#bytesToLcnt(Target_palette_end-Target_palette),d0
; loc3_384E:
locK_4140:
		move.l	(a0)+,(a1)+
		dbf	d0,locK_4140
		move.l	#vdpComm(tiles_to_bytes(ArtTile_Title_Banner),VRAM,WRITE),(VDP_control_port).l		; to VRAM $A000
		lea	(ArtNem_Title_S3Banner).l,a0
		bsr.w	Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes(ArtTile_Title_Menu),VRAM,WRITE),(VDP_control_port).l		; to VRAM $D000
		lea	(ArtNem_TitleScreenText).l,a0
		bsr.w	Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes(ArtTile_Title_Misc),VRAM,WRITE),(VDP_control_port).l		; to VRAM $8000
		lea	(ArtNem_Title_SonicSprites).l,a0
		bsr.w	Nem_Decomp
	if ~~Sonic3_Alone
		move.l	#vdpComm(tiles_to_bytes(ArtTile_Title_ANDKnuckles),VRAM,WRITE),(VDP_control_port).l	; to VRAM $9800
		lea	(ArtNem_Title_ANDKnuckles).l,a0
		bsr.w	Nem_Decomp
	endif
		move.l	#Obj_TitleBanner,(Player_1).w
		move.l	#Obj_TitleSelection,(Player_2).w
		move.l	#Obj_TitleCopyright,(Dynamic_object_RAM).w
		move.l	#Obj_TitleSonicFinger,(Dynamic_object_RAM+object_size).w
		move.l	#Obj_TitleSonicWink,(Dynamic_object_RAM+(object_size*2)).w
		move.l	#Obj_TitleTailsPlane,(Dynamic_object_RAM+(object_size*3)).w
	if Sonic3_Alone
		moveq	#PLCID_00,d0
		bsr.w	Load_PLC_2
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
	else
		move.l	#Obj_TitleANDKnuckles,(Dynamic_object_RAM+(object_size*4)).w		; Load all applicable title objects
	endif
		move.b	#0,(Title_anim_delay).w
; loc3_38D8:
locK_41D4:
		move.b	#VInt_ID_4,(V_int_routine).w
		bsr.w	Wait_VSync
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		bsr.w	Process_Nem_Queue_Init
		tst.l	(Reserved_object_3).w
		beq.s	locK_41D4			; Don't do anything at all until banner has finished moving
		tst.w	(Demo_timer).w
		beq.w	locK_4278			; If the timer has run out, go do the level demos
		move.b	(Ctrl_1_pressed).w,d0
	if ~~Sonic3_Alone
		or.b	(Ctrl_2_pressed).w,d0
	endif
		andi.b	#button_start_mask,d0
		beq.w	locK_41D4			; Repeat until start has been pressed on either controller
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
		move.l	#5000,(Next_extra_life_score).w
		move.l	#5000,(Next_extra_life_score_P2).w
		moveq	#signextendB(cmd_FadeOut),d0
		bsr.w	Play_SFX			; Fade out the title screen music
		moveq	#0,d0
		move.b	(Title_screen_option).w,d0		; Selection is stored here
		bne.w	locK_4264
		move.b	#GameMode_SaveScreen,(Game_mode).w		; Game Mode 4C is the save select
		rts
; ---------------------------------------------------------------------------
; loc3_3964:
locK_4264:
		subq.b	#1,d0
		bne.s	locK_4270
		move.b	#GameMode_CompetitionMenu,(Game_mode).w		; Game Mode 38 is Competition mode
		rts
; ---------------------------------------------------------------------------
; loc3_3970:
locK_4270:
		move.b	#GameMode_LevelSelect,(Game_mode).w		; Game Mode 28 is the level select
		rts
; ---------------------------------------------------------------------------
; loc3_3878:
locK_4278:
		moveq	#signextendB(cmd_FadeOut),d0
		bsr.w	Play_SFX			; Fade out music
		move.w	(Next_demo_number).w,d0		; Get index of current demo to run
	if ~~Sonic3_Alone
		move.w	d0,(Demo_number).w
	endif
		andi.w	#7,d0
		add.w	d0,d0
	if Sonic3_Alone
		move.w	DemoLevels(pc,d0.w),d0
	else
		; Changed since the original target was moved out-of-range
		lea	DemoLevels(pc),a0
		move.w	(a0,d0.w),d0
	endif
		move.w	d0,(Current_zone_and_act).w		; Load level index to the appropriate variables
		move.w	d0,(Apparent_zone_and_act).w
		move.w	d0,(Saved_zone_and_act).w
	if Sonic3_Alone
		addq.w	#1,(Next_demo_number).w
		cmpi.w	#3,(Next_demo_number).w
		bcs.s	loc3_39AA
		move.w	#0,(Next_demo_number).w

loc3_39AA:
		move.w	#1,(Demo_mode_flag).w
		move.b	#GameMode_Demo,(Game_mode).w	; We're about to perform a level demo
	else
		move.w	(Next_demo_number).w,d1
		addq.w	#1,d1
		tst.w	(SK_alone_flag).w
		bne.s	locK_42C0		; If playing only Sonic & Knuckles, branch
		cmpi.w	#3,d1
		bne.s	locK_42B6
		moveq	#4,d1
		bra.s	locK_42C8
; ---------------------------------------------------------------------------

locK_42B6:
		cmpi.w	#7,d1
		blo.s	locK_42C8
		moveq	#0,d1
		bra.s	locK_42C8
; ---------------------------------------------------------------------------
; unused/dead code, since it's not possible to reach the S3K title screen in S&K mode
; Even if were, this sets the next demo to a S3 level, which would crash S&K when played

locK_42C0:
		cmpi.w	#3,d1
		blo.s	locK_42C8
		moveq	#0,d1

locK_42C8:
		move.w	d1,(Next_demo_number).w
		tst.w	d0
		bpl.s	locK_4300			; Branch if we are indeed playing a level
		move.b	#GameMode_SpecialStage,(Game_mode).w	; Do the special stage demo
		move.b	#1,(Current_special_stage).w
		move.b	#1,(SK_special_stage_flag).w
		move.b	#7,(Current_zone).w
		clr.w	(Emerald_counts).w
		clr.l	(Collected_emeralds_array).w
		clr.w	(Collected_emeralds_array+4).w
		clr.b	(Collected_emeralds_array+6).w
		move.b	#2,(Collected_emeralds_array+1).w
		bra.s	locK_4306
; ---------------------------------------------------------------------------

locK_4300:
		move.b	#GameMode_Demo,(Game_mode).w	; We're about to perform a level demo

locK_4306:
		move.w	#1,(Demo_mode_flag).w
	endif
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
		rts
; ---------------------------------------------------------------------------
DemoLevels:
		dc.w      0	; Angel Island
		dc.w   $100	; Hydrocity
		dc.w   $200	; Marble Garden
	if ~~Sonic3_Alone
		dc.w   $700	; Mushroom Hill
		dc.w   $400	; Flying Battery
		dc.w   $800	; Sandopolis
		dc.w  $FFFF
	endif
; ---------------------------------------------------------------------------


TitleAnim_FlipBuffer:
		tst.b	(Title_anim_delay).w
		bne.s	locK_43AC
		move.b	#4-1,(Title_anim_delay).w
		cmpi.w	#$C,(Title_anim_frame).w
		bhs.s	locK_43B2
		move.b	#4-1,(Title_anim_delay).w
		lea	(Target_palette).w,a0
		lea	(Normal_palette).w,a1
		moveq	#bytesToLcnt(Target_palette_line_3-Target_palette),d0
; loc3_3A18:
locK_4376:
		move.l	(a0)+,(a1)+
		dbf	d0,locK_4376
		eori.b	#-1,(Title_anim_buffer).w
		tst.b	(Title_anim_buffer).w
		beq.s	locK_439A
		move.w	#$8406,(VDP_control_port).l		; Nametable B Address $C000
		move.w	#$8230,(VDP_control_port).l		; Nametable A Address $C000
		rts
; ---------------------------------------------------------------------------
; loc3_3A3C:
locK_439A:
		move.w	#$8407,(VDP_control_port).l		; Nametable B Address $E000
		move.w	#$8238,(VDP_control_port).l		; Nametable A Address $E000
		rts
; ---------------------------------------------------------------------------
; loc3_3A4E:
locK_43AC:
		subq.b	#1,(Title_anim_delay).w
		rts
; ---------------------------------------------------------------------------
; loc3_3A54:
locK_43B2:
		lea	(Target_palette).w,a0
		lea	(Normal_palette).w,a1
		moveq	#bytesToLcnt(Target_palette_end-Target_palette),d0
; loc3_3A5E:
locK_43BC:
		move.l	(a0)+,(a1)+
		dbf	d0,locK_43BC
		move.w	#$8407,(VDP_control_port).l		; Nametable B Address $E000
		move.w	#$8230,(VDP_control_port).l		; Nametable A Address $C000
		rts


; =============== S U B R O U T I N E =======================================


Iterate_TitleSonicFrame:
		cmpi.b	#1,(Title_anim_delay).w
		bne.s	locretK_43F0
		move.w	(Title_anim_frame).w,d0
		move.b	SonicFrameIndex(pc,d0.w),d0
		ext.w	d0
		bmi.s	locK_43F2	; if negative, do not load anymore frames
		bsr.w	TitleSonic_LoadFrame
		addq.w	#1,(Title_anim_frame).w
; locret3_3A92:
locretK_43F0:
		rts
; ---------------------------------------------------------------------------
; loc3_3A94:
locK_43F2:
		move.w	#$C,(Title_anim_frame).w
		move.b	#3,(Title_anim_delay).w
	if Sonic3_Alone
		bra.w	locret3_3AB0
	else
		rts
	endif
; ---------------------------------------------------------------------------
SonicFrameIndex:
		dc.b    1,   2,   3,   4,   5,   6,   7,   8,   9,  $A,  $B, $FF
		even
; ---------------------------------------------------------------------------

	if Sonic3_Alone
locret3_3AB0:
		rts
; ---------------------------------------------------------------------------
		; unused
		move.b	(Title_anim_buffer).w,d2
		cmpi.b	#1,d2
		beq.s	locret3_3B0A
		move.w	(V_scroll_amount).w,d0
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,(Camera_Y_pos).w
		move.w	(Camera_Y_pos).w,d0
		move.w	d0,(V_scroll_value).w
		move.b	#0,(Title_anim_buffer).w
		move.w	#$40,d1
		cmpi.w	#0,d0
		blt.s	loc3_3AFC
		bne.s	loc3_3AF2
		cmpi.w	#-$5B,(V_scroll_amount).w
		bne.s	loc3_3AF2
		move.b	#1,(Title_anim_buffer).w
		bra.s	locret3_3B0A
; ---------------------------------------------------------------------------

loc3_3AF2:
		move.b	#-1,(Title_anim_buffer).w
		move.w	#-$40,d1

loc3_3AFC:
		add.w	d1,(V_scroll_amount).w
		cmp.b	(Title_anim_buffer).w,d2
		beq.s	locret3_3B0A
		asr	(V_scroll_amount).w

locret3_3B0A:
		rts
	endif

; =============== S U B R O U T I N E =======================================


TitleSonic_LoadFrame:
		move.w	d0,d7
		add.w	d0,d0
		add.w	d0,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		lea	(TitleSonic_Frames).l,a2
		lea	(a2,d0.w),a2
		move.w	#$2C60,d3
		move.l	(a2)+,d0				; Art data
		cmpi.w	#7,d7
		beq.s	locK_4446
		bcs.s	locK_4466
		andi.l	#$FFFFFF,d0
		movea.l	d0,a0
		lea	(RAM_start).l,a1
		bsr.w	Kos_Decomp
		move.w	a1,d3
		lsr.w	#1,d3
; loc3_3B46:
locK_4446:
		move.l	#RAM_start,d1
		move.w	#0,d2
		tst.b	(Title_anim_buffer).w		; FFFFBC toggles on and off so that each animation frame could alternate locations for a sort of makeshift double-buffering
		beq.s	locK_445A
		move.w	#tiles_to_bytes(ArtTile_Title_Buffer),d2
; loc3_3B5A:
locK_445A:
		andi.l	#$FFFFFF,d1
		jsr	(Add_To_DMA_Queue).l
; loc3_3B66:
locK_4466:
		movea.l	(a2)+,a0			; Palette data address
		lea	(Target_palette).w,a1
		moveq	#bytesToLcnt(Target_palette_line_3-Target_palette),d0
; loc3_3B6E:
locK_446E:
		move.l	(a0)+,(a1)+
		dbf	d0,locK_446E
		tst.b	(Title_anim_buffer).w
		bne.s	locK_44B8
		lea	(RAM_start+$8000).w,a1			; Buffer 1
		movea.l	(a2)+,a0				; Enigma Mappings
		move.w	#make_art_tile($000,0,0),d0
		bsr.w	Eni_Decomp
	if ~~Sonic3_Alone
		cmpi.w	#7,d7
		bhs.s	locK_449A
		tst.b	(Graphics_flags).w
		bmi.s	locK_449A
		moveq	#0,d0
		move.l	d0,(RAM_start+$83AC).w

locK_449A:
	endif
		move	#$2700,sr
		lea	(RAM_start+$8000).w,a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table,VRAM,WRITE),d0	; to $C000 in VRAM, Nametable A
		moveq	#40-1,d1
		moveq	#28-1,d2
		jsr	(Plane_Map_To_VRAM).l
		move	#$2300,sr
		rts
; ---------------------------------------------------------------------------
; loc3_3BA6:
locK_44B8:
		lea	(RAM_start+$8000).w,a1			; Buffer 2
		movea.l	(a2)+,a0				; Enigma Mappings
		move.w	#make_art_tile(ArtTile_Title_Buffer,0,0),d0
		cmpi.w	#7,d7
		bhs.s	locK_44CC
		move.w	#make_art_tile($000,0,0),d0
; loc3_3BBA:
locK_44CC:
		bsr.w	Eni_Decomp
	if ~~Sonic3_Alone
		cmpi.w	#7,d7
		bhs.s	locK_44E2
		tst.b	(Graphics_flags).w
		bmi.s	locK_44E2
		moveq	#0,d0
		move.l	d0,(RAM_start+$83AC).w

locK_44E2:
	endif
		move	#$2700,sr
		lea	(RAM_start+$8000).w,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table,VRAM,WRITE),d0	; to $E000 in VRAM Nametable B
		moveq	#40-1,d1
		moveq	#28-1,d2
		jsr	(Plane_Map_To_VRAM).l
		move	#$2300,sr
		rts
; End of function TitleSonic_LoadFrame

; ---------------------------------------------------------------------------
TitleSonic_Frames:
		dc.l ArtKos_S3TitleSonic1				;S3DATA
		dc.l Pal_TitleSonic1
		dc.l MapEni_S3TitleSonic1				;S3DATA
		dc.l ArtKos_S3TitleSonic1				;S3DATA
		dc.l Pal_TitleSonic2
		dc.l MapEni_S3TitleSonic2				;S3DATA
		dc.l ArtKos_S3TitleSonic1				;S3DATA
		dc.l Pal_TitleSonic3
		dc.l MapEni_S3TitleSonic3				;S3DATA
		dc.l ArtKos_S3TitleSonic1				;S3DATA
		dc.l Pal_TitleSonic4
		dc.l MapEni_S3TitleSonic4				;S3DATA
		dc.l ArtKos_S3TitleSonic1				;S3DATA
		dc.l Pal_TitleSonic5
		dc.l MapEni_S3TitleSonic5				;S3DATA
		dc.l ArtKos_S3TitleSonic1				;S3DATA
		dc.l Pal_TitleSonic6
		dc.l MapEni_S3TitleSonic6				;S3DATA
		dc.l ArtKos_S3TitleSonic1				;S3DATA
		dc.l Pal_TitleSonic7
		dc.l MapEni_S3TitleSonic7				;S3DATA
		dc.l ArtKos_S3TitleSonic8				;S3DATA
		dc.l Pal_TitleSonic8
		dc.l MapEni_S3TitleSonic8				;S3DATA
		dc.l ArtKos_S3TitleSonic9				;S3DATA
		dc.l Pal_TitleSonic9
		dc.l MapEni_S3TitleSonic9				;S3DATA
		dc.l ArtKos_S3TitleSonicA				;S3DATA
		dc.l Pal_TitleSonicA
		dc.l MapEni_S3TitleSonicA				;S3DATA
		dc.l ArtKos_S3TitleSonicB				;S3DATA
		dc.l Pal_TitleSonicB
		dc.l MapEni_S3TitleSonicB				;S3DATA
		dc.l ArtKos_S3TitleSonicC				;S3DATA
		dc.l Pal_TitleSonicC
		dc.l MapEni_S3TitleSonicC				;S3DATA
		dc.l ArtKos_S3TitleSonicD				;S3DATA
		dc.l Pal_TitleSonicD
		dc.l MapEni_S3TitleSonicD				;S3DATA
Pal_Title:
		binclude "General/Title/Palettes/S3.bin"
		even
Pal_TitleSonic1:
		binclude "General/Title/Palettes/S3 Sonic 1.bin"
		even
Pal_TitleSonic2:
		binclude "General/Title/Palettes/S3 Sonic 2.bin"
		even
Pal_TitleSonic3:
		binclude "General/Title/Palettes/S3 Sonic 3.bin"
		even
Pal_TitleSonic4:
		binclude "General/Title/Palettes/S3 Sonic 4.bin"
		even
Pal_TitleSonic5:
		binclude "General/Title/Palettes/S3 Sonic 5.bin"
		even
Pal_TitleSonic6:
		binclude "General/Title/Palettes/S3 Sonic 6.bin"
		even
Pal_TitleSonic7:
		binclude "General/Title/Palettes/S3 Sonic 7.bin"
		even
Pal_TitleSonic8:
		binclude "General/Title/Palettes/S3 Sonic 8.bin"
		even
Pal_TitleSonic9:
		binclude "General/Title/Palettes/S3 Sonic 9.bin"
		even
Pal_TitleSonicA:
		binclude "General/Title/Palettes/S3 Sonic A.bin"
		even
Pal_TitleSonicB:
		binclude "General/Title/Palettes/S3 Sonic B.bin"
		even
Pal_TitleSonicC:
		binclude "General/Title/Palettes/S3 Sonic C.bin"
		even
Pal_TitleSonicD:
		binclude "General/Title/Palettes/S3 Sonic D.bin"
		even
; ---------------------------------------------------------------------------

Obj_TitleBanner:
		move.l	#Map_S3TitleBanner,mappings(a0)
		move.w	#make_art_tile(ArtTile_Title_Banner,3,1),art_tile(a0)	; Origin at $A000
		move.w	#$80,priority(a0)
		move.b	#$80,width_pixels(a0)
		move.b	#$40,height_pixels(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$F0,y_pos(a0)
		move.w	#$400,y_vel(a0)
		move.l	#$FFA00000,$30(a0)
		move.l	#Obj_TitleBanner_Main,(a0)

Obj_TitleBanner_Main:
		move.b	$34(a0),d2
		move.w	y_vel(a0),d0
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,$30(a0)
		move.w	$30(a0),d0
		move.b	#0,$34(a0)
		move.w	#$40,d1
		cmpi.w	#0,d0
		blt.s	locK_48B4
		bne.s	locK_48AA
		cmpi.w	#-$5B,y_vel(a0)
		bne.s	locK_48AA
		move.l	#Obj_TitleBanner_Display,(a0)
		move.l	#Obj_TitleTM,(Reserved_object_3).w
		bra.s	locK_48C2
; ---------------------------------------------------------------------------
; loc3_3F86:
locK_48AA:
		move.b	#-1,$34(a0)
		move.w	#-$40,d1
; loc3_3F90:
locK_48B4:
		add.w	d1,y_vel(a0)
		cmp.b	$34(a0),d2
		beq.s	locK_48C2
		asr	y_vel(a0)
; loc3_3F9E:
locK_48C2:
		move.w	$30(a0),d0
		neg.w	d0
	if Sonic3_Alone
		addi.w	#$F0,d0
	else
		addi.w	#$D4,d0
	endif
		move.w	d0,y_pos(a0)
	if ~~Sonic3_Alone
		cmpi.w	#$10,(V_scroll_value).w		; Raise title screen Y position to make room for the &KNUCKLES
		beq.s	Obj_TitleBanner_Display
		addq.w	#1,(V_scroll_value).w
	endif

Obj_TitleBanner_Display:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locK_48F2
		move.b	#9,anim_frame_timer(a0)
		addq.b	#4,anim_frame(a0)
		andi.b	#$1C,anim_frame(a0)
; loc3_3FC2:
locK_48F2:
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		move.l	Pal_TitleWaterRot(pc,d0.w),(Target_palette_line_3+$1A).w
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Pal_TitleWaterRot:
		binclude "General/Title/Palettes/S3 Water Anim.bin"
		even
; ---------------------------------------------------------------------------

Obj_TitleTM:
		move.l	#Map_S3TitleBanner,mappings(a0)		;S3DATA
		move.w	#make_art_tile(ArtTile_Title_Banner,3,1),art_tile(a0)	; Start at $A000
		move.w	#$188,x_pos(a0)
	if Sonic3_Alone
		move.w	#$108,y_pos(a0)
	else
		move.w	#$EC,y_pos(a0)
	endif
		move.w	#$80,priority(a0)
		move.b	#$C,width_pixels(a0)
		move.b	#4,height_pixels(a0)
		move.b	#1,mapping_frame(a0)
		move.l	#Obj_TitleTM_Display,(a0)

Obj_TitleTM_Display:
	if Sonic3_Alone
		jmp	(Draw_Sprite).l
	else
		tst.b	(Graphics_flags).w
		bpl.s	locretK_4968
		jmp	(Draw_Sprite).l

locretK_4968:
		rts
; ---------------------------------------------------------------------------

Obj_TitleANDKnuckles:
		move.l	#Map_TitleANDKnuckles,mappings(a0)
		move.w	#make_art_tile(ArtTile_Title_ANDKnuckles,3,1),art_tile(a0)	; Start at $9800
		move.w	#$120,x_pos(a0)
		move.w	#$108,y_pos(a0)
		move.w	#$80,priority(a0)
		move.b	#$54,width_pixels(a0)
		move.b	#$C,height_pixels(a0)
		move.l	#Obj_TitleANDKnuckles_Display,(a0)

Obj_TitleANDKnuckles_Display:
		move.w	(Player_1+y_pos).w,d0
		addi.w	#$5C,d0
		move.w	d0,y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Map_TitleANDKnuckles:
		include "General/Title/Map - S3 ANDKnuckles.asm"
	endif
; ---------------------------------------------------------------------------

; Dead code
OldDebugCode:
		lea	(OldDebugCodeDat).l,a1
		move.w	(Debug_mode_cheat_counter).w,d0
		adda.w	d0,a1
		move.b	(Ctrl_1_pressed_title).w,d0
		andi.b	#button_up_mask|button_down_mask|button_left_mask|button_right_mask|button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	locretK_4A10
		move.b	(Ctrl_1_held_title).w,d0
		cmp.b	(a1),d0
		bne.s	locK_4A0A
		addq.w	#1,(Debug_mode_cheat_counter).w
		tst.b	1(a1)
		bne.s	locretK_4A10
		move.w	#(1<<8)|1,(Debug_cheat_flag).w
		moveq	#signextendB(sfx_RingLoss),d0
		bsr.w	Play_SFX
; loc3_4066:
locK_4A0A:
		move.w	#0,(Debug_mode_cheat_counter).w
; locret3_406C:
locretK_4A10:
		rts
; ---------------------------------------------------------------------------
OldDebugCodeDat:
		dc.b button_C_mask
		dc.b button_C_mask|button_B_mask
		dc.b button_C_mask|button_B_mask|button_A_mask
		dc.b button_B_mask
		dc.b button_B_mask|button_A_mask
		dc.b button_B_mask|button_A_mask|button_C_mask
		dc.b button_A_mask
		dc.b button_A_mask|button_C_mask
		dc.b button_A_mask|button_C_mask|button_B_mask
		dc.b button_A_mask|button_C_mask|button_B_mask|button_up_mask
		dc.b button_A_mask|button_C_mask|button_B_mask|button_down_mask
		dc.b 0
		even
; ---------------------------------------------------------------------------

Obj_TitleCopyright:
		move.l	#Map_TitleScreenText,mappings(a0)
		move.w	#make_art_tile(ArtTile_Title_Menu,3,1),art_tile(a0)	; Start at $D000 VRAM
		move.w	#$158,x_pos(a0)
		move.w	#$14C,y_pos(a0)
		move.w	#$80,priority(a0)
		move.b	#$C,width_pixels(a0)
		move.b	#4,height_pixels(a0)
		move.b	#3,mapping_frame(a0)
		move.l	#Obj_TitleCopyright_Display,(a0)

Obj_TitleCopyright_Display:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_TitleSelection:
		move.w	#$F0,x_pos(a0)
		move.w	#$140,y_pos(a0)
		move.l	#Map_TitleScreenText,mappings(a0)
		move.w	#make_art_tile(ArtTile_Title_Menu,2,1),art_tile(a0)	; Start at $D000 VRAM
		andi.b	#1,(Title_screen_option).w
		move.b	(Title_screen_option).w,mapping_frame(a0)
		move.l	#Obj_TitleSelection_Main,(a0)

Obj_TitleSelection_Main:
		moveq	#0,d2
		move.b	(Title_screen_option).w,d2
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		btst	#button_up,d0
		beq.s	locK_4AAE
		subq.b	#1,d2
		bcc.s	locK_4AAE
		move.b	#2,d2
		tst.b	(Level_select_flag).w		; If level select is on, maximum choices are 3
		bne.s	locK_4AAE
		move.b	#1,d2
; loc3_410A:
locK_4AAE:
		btst	#button_down,d0
		beq.s	locK_4AC8
		addq.b	#1,d2
		tst.b	(Level_select_flag).w		; See above
		bne.s	locK_4AC0
		andi.b	#1,d2
; loc3_411C:
locK_4AC0:
		cmpi.b	#3,d2
		blo.s	locK_4AC8
		moveq	#0,d2
; loc3_4124:
locK_4AC8:
		move.b	d2,mapping_frame(a0)
		move.b	d2,(Title_screen_option).w
		andi.b	#3,d0
		beq.s	locK_4ADE
		moveq	#signextendB(sfx_Switch),d0
		jsr	(Play_SFX).l		; Only play sound if selection was changed
; loc3_413A:
locK_4ADE:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_TitleSonicFinger:
		move.l	#Map_TitleSonicAnim,mappings(a0)
		move.w	#make_art_tile(ArtTile_Title_Misc,1,1),art_tile(a0)	; Start at $8000 VRAM
		move.w	#$148,x_pos(a0)
		move.w	#$DC,y_pos(a0)
		move.w	#$180,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$1C,height_pixels(a0)
		move.l	#Obj_TitleSonicFinger_Display,(a0)

Obj_TitleSonicFinger_Display:
	if ~~Sonic3_Alone
		move.w	#$DC,d0
		sub.w	(V_scroll_value).w,d0
		move.w	d0,y_pos(a0)
	endif
		lea	(Ani_TitleSonicFinger).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Ani_TitleSonicFinger:
		include "General/Title/Anim - S3 Sonic Finger.asm"
; ---------------------------------------------------------------------------

Obj_TitleSonicWink:
		move.l	#Map_TitleSonicAnim,mappings(a0)
		move.w	#make_art_tile(ArtTile_Title_Misc,1,1),art_tile(a0)	; Start at $8000 VRAM
		move.w	#$F8,x_pos(a0)
		move.w	#$C8,y_pos(a0)
		move.w	#$180,priority(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.l	#Obj_TitleSonicWink_Display,(a0)

Obj_TitleSonicWink_Display:
	if ~~Sonic3_Alone
		move.w	#$C8,d0
		sub.w	(V_scroll_value).w,d0
		move.w	d0,y_pos(a0)
	endif
		lea	(Ani_TitleSonicWink).l,a1
		jsr	(Animate_SpriteIrregularDelay).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Ani_TitleSonicWink:
		include "General/Title/Anim - S3 Sonic Wink.asm"
; ---------------------------------------------------------------------------

Obj_TitleTailsPlane:
		move.l	#Map_TitleTailsPlane,mappings(a0)
		move.w	#make_art_tile(ArtTile_Title_Misc,3,0),art_tile(a0)	; Start at $8000 VRAM
		move.w	#0,x_pos(a0)
		move.w	#$C0,y_pos(a0)
		move.w	#$380,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		move.l	#Obj_TitleTailsPlane_Main,(a0)

Obj_TitleTailsPlane_Main:
		tst.b	$30(a0)
		bne.s	locK_4C0A
		addq.w	#1,x_pos(a0)
		cmpi.w	#$240,x_pos(a0)
		bne.s	locK_4C08
		move.b	#1,$30(a0)
		bset	#0,status(a0)
		move.w	#$D0,y_pos(a0)
; loc3_424C:
locK_4C08:
		bra.s	locK_4C28
; ---------------------------------------------------------------------------
; loc3_424E:
locK_4C0A:
		subq.w	#1,x_pos(a0)
		cmpi.w	#0,x_pos(a0)
		bne.s	locK_4C28
		move.b	#0,$30(a0)
		bclr	#0,status(a0)
		move.w	#$C0,y_pos(a0)
; loc3_426C:
locK_4C28:
		lea	(Ani_TitleTailsPlane).l,a1
		jsr	(Animate_Sprite).l
	if ~~Sonic3_Alone
		tst.b	render_flags(a0)
		bpl.s	locK_4C3E
		bsr.w	S3_Level_Select_Code

locK_4C3E:
	endif
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Ani_TitleTailsPlane:
		include "General/Title/Anim - S3 Tails Plane.asm"

; =============== S U B R O U T I N E =======================================


S3_Level_Select_Code:
	if ~~Sonic3_Alone
		rts
; ---------------------------------------------------------------------------
		; unused
	endif
		lea	(LSelect3CodeDat).l,a1
		move.w	(Level_select_cheat_counter).w,d0
		adda.w	d0,a1
		move.b	(Ctrl_1_pressed_title).w,d0
		andi.b	#button_up_mask|button_down_mask|button_left_mask|button_right_mask|button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	locret_4C90
		move.b	(Ctrl_1_held_title).w,d0
		cmp.b	(a1),d0
		bne.s	locK_4C8A
		addq.w	#1,(Level_select_cheat_counter).w
		tst.b	1(a1)
		bne.s	locret_4C90
		move.w	#(1<<8)|1,(Level_select_flag).w
		move.w	#(1<<8)|1,(Debug_cheat_flag).w
		moveq	#signextendB(sfx_RingRight),d0
		bsr.w	Play_SFX
; loc3_42C2:
locK_4C8A:
		move.w	#0,(Level_select_cheat_counter).w
; locret3_42C8:
locret_4C90:
		rts
; End of function S3_Level_Select_Code

; ---------------------------------------------------------------------------
LSelect3CodeDat:
		dc.b button_up_mask
		dc.b button_up_mask
		dc.b button_down_mask
		dc.b button_down_mask
		dc.b button_up_mask
		dc.b button_up_mask
		dc.b button_up_mask
		dc.b button_up_mask
		dc.b 0
		even
Map_TitleScreenText:
		include "General/Title/Map - S3 Screen Text.asm"
ArtNem_TitleScreenText:
		binclude "General/Title/Nemesis Art/S3 Screen Text.nem"
		even
Map_TitleSonicAnim:
		include "General/Title/Map - S3 Sonic Anim.asm"
Map_TitleTailsPlane:
		include "General/Title/Map - S3 Tails Plane.asm"