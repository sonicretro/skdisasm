
; =============== S U B R O U T I N E =======================================


MenuScreenTextToRAM:
		moveq	#0,d1
		move.b	(a1)+,d1

.loop:
		move.b	(a1)+,d0
		move.w	d0,(a2)+
		dbf	d1,.loop
		rts
; End of function MenuScreenTextToRAM

; ---------------------------------------------------------------------------

; leftover from Sonic 2
MenuScreen_Options:
		lea	(RAM_start).l,a1
		lea	(MapEni_S2Options).l,a0
		move.w	#make_art_tile(ArtTile_S2MenuBox,0,0),d0
		bsr.w	Eni_Decomp
		lea	(RAM_start+$160).l,a1
		lea	(MapEni_S2Options).l,a0
		move.w	#make_art_tile(ArtTile_S2MenuBox,1,0),d0
		bsr.w	Eni_Decomp
		clr.b	(Options_menu_box).w
		bsr.w	OptionScreen_DrawSelected
		addq.b	#1,(Options_menu_box).w
		bsr.w	OptionScreen_DrawUnselected
		addq.b	#1,(Options_menu_box).w
		bsr.w	OptionScreen_DrawUnselected
		clr.b	(Options_menu_box).w
		clr.b	(Level_started_flag).w
		clr.w	(Anim_Counters).w
		lea	(AniPLC_SONICMILES).l,a2
		jsr	(AnimateTiles_DoAniPLC).l
		moveq	#PalID_S2Menu,d0
		bsr.w	LoadPalette
		moveq	#signextendB(mus_DataSelect),d0
		bsr.w	Play_Music
		clr.w	(Competition_mode).w
		clr.l	(Camera_X_pos).w
		clr.l	(Camera_Y_pos).w
		clr.w	(Level_select_cheat_counter).w
		clr.w	(Debug_mode_cheat_counter).w
		move.b	#VInt_ID_16,(V_int_routine).w
		bsr.w	Wait_VSync
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		bsr.w	Pal_FadeFromBlack

OptionScreen_Main:
		move.b	#VInt_ID_16,(V_int_routine).w
		bsr.w	Wait_VSync
		move	#$2700,sr
		bsr.w	OptionScreen_DrawUnselected
		bsr.w	OptionScreen_Controls
		bsr.w	OptionScreen_DrawSelected
		move	#$2300,sr
		lea	(AniPLC_SONICMILES).l,a2
		jsr	(AnimateTiles_DoAniPLC).l
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		andi.b	#button_start_mask,d0
		bne.s	OptionScreen_Select
		bra.w	OptionScreen_Main
; ---------------------------------------------------------------------------

OptionScreen_Select:
		move.b	(Options_menu_box).w,d0
		bne.s	OptionScreen_Select_Not1P
		moveq	#0,d0
		move.w	d0,(Competition_mode).w
		move.w	d0,(Competition_settings).w
		move.w	d0,(Current_zone_and_act).w
		move.w	d0,(Apparent_zone_and_act).w
		move.w	d0,(Saved_zone_and_act).w
		move.b	#GameMode_Level,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

OptionScreen_Select_Not1P:
		subq.b	#1,d0
		bne.s	OptionScreen_Select_Other
		moveq	#1,d0
		move.w	d0,(Competition_mode).w
		move.w	d0,(Competition_settings).w
		move.b	#GameMode_2PLevelSelect,(Game_mode).w
		move.b	#0,(Current_zone_2P).w
		move.w	#0,(Player_mode).w
		rts
; ---------------------------------------------------------------------------

OptionScreen_Select_Other:
		move.b	#GameMode_SegaScreen,(Game_mode).w
		rts

; =============== S U B R O U T I N E =======================================


OptionScreen_Controls:
		moveq	#0,d2
		move.b	(Options_menu_box).w,d2
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		btst	#button_up,d0
		beq.s	loc3_6686
		subq.b	#1,d2
		bcc.s	loc3_6686
		move.b	#2,d2

loc3_6686:
		btst	#button_down,d0
		beq.s	loc3_6696
		addq.b	#1,d2
		cmpi.b	#3,d2
		bcs.s	loc3_6696
		moveq	#0,d2

loc3_6696:
		move.b	d2,(Options_menu_box).w
		lsl.w	#2,d2
		move.b	OptionScreen_Choices(pc,d2.w),d3
		movea.l	OptionScreen_Choices(pc,d2.w),a1
		move.w	(a1),d2
		btst	#button_left,d0
		beq.s	loc3_66B2
		subq.b	#1,d2
		bcc.s	loc3_66B2
		move.b	d3,d2

loc3_66B2:
		btst	#button_right,d0
		beq.s	loc3_66C0
		addq.b	#1,d2
		cmp.b	d3,d2
		bls.s	loc3_66C0
		moveq	#0,d2

loc3_66C0:
		btst	#button_A,d0
		beq.s	loc3_66D0
		addi.b	#$10,d2
		cmp.b	d3,d2
		bls.s	loc3_66D0
		moveq	#0,d2

loc3_66D0:
		move.w	d2,(a1)
		cmpi.b	#2,(Options_menu_box).w
		bne.s	locret3_66FE
		andi.w	#button_B_mask|button_C_mask,d0
		beq.s	locret3_66FE
		move.w	(Sound_test_sound).w,d0
		bsr.w	Play_Music
		lea	(S2LevelSelectCodeDat).l,a0
		lea	(S2ContinueCodeDat).l,a2
		lea	(Level_select_flag).w,a1
		moveq	#0,d2
		bsr.w	CheckCheats

locret3_66FE:
		rts
; End of function OptionScreen_Controls

; ---------------------------------------------------------------------------
OptionScreen_Choices:
		dc.l (3-1)<<24|(Player_option&$FFFFFF)
		dc.l (2-1)<<24|(Two_player_items&$FFFFFF)
		dc.l ($CA-1)<<24|(Sound_test_sound&$FFFFFF)

; =============== S U B R O U T I N E =======================================


OptionScreen_DrawSelected:
		bsr.w	OptionScreen_SelectTextPtr
		moveq	#0,d1
		move.b	(Options_menu_box).w,d1
		lsl.w	#3,d1
		lea	(S2OptScrBoxData).l,a3
		lea	(a3,d1.w),a3
		move.w	#palette_line_3,d0
		lea	(RAM_start+$030).l,a2
		movea.l	(a3)+,a1
		bsr.w	MenuScreenTextToRAM
		lea	(RAM_start+$0B6).l,a2
		moveq	#0,d1
		cmpi.b	#2,(Options_menu_box).w
		beq.s	loc3_6754
		move.b	(Options_menu_box).w,d1
		lsl.w	#2,d1
		lea	OptionScreen_Choices(pc),a1
		movea.l	(a1,d1.w),a1
		move.w	(a1),d1
		lsl.w	#2,d1

loc3_6754:
		movea.l	(a4,d1.w),a1
		bsr.w	MenuScreenTextToRAM
		cmpi.b	#2,(Options_menu_box).w
		bne.s	loc3_676E
		lea	(RAM_start+$0C2).l,a2
		bsr.w	OptionScreen_HexDumpSoundTest

loc3_676E:
		lea	(RAM_start).l,a1
		move.l	(a3)+,d0
		moveq	#22-1,d1
		moveq	#8-1,d2
		bra.w	Plane_Map_To_VRAM
; End of function OptionScreen_DrawSelected


; =============== S U B R O U T I N E =======================================


OptionScreen_DrawUnselected:
		bsr.w	OptionScreen_SelectTextPtr
		moveq	#0,d1
		move.b	(Options_menu_box).w,d1
		lsl.w	#3,d1
		lea	(S2OptScrBoxData).l,a3
		lea	(a3,d1.w),a3
		moveq	#palette_line_0,d0
		lea	(RAM_start+$190).l,a2
		movea.l	(a3)+,a1
		bsr.w	MenuScreenTextToRAM
		lea	(RAM_start+$216).l,a2
		moveq	#0,d1
		cmpi.b	#2,(Options_menu_box).w
		beq.s	loc3_67C4
		move.b	(Options_menu_box).w,d1
		lsl.w	#2,d1
		lea	OptionScreen_Choices(pc),a1
		movea.l	(a1,d1.w),a1
		move.w	(a1),d1
		lsl.w	#2,d1

loc3_67C4:
		movea.l	(a4,d1.w),a1
		bsr.w	MenuScreenTextToRAM
		cmpi.b	#2,(Options_menu_box).w
		bne.s	loc3_67DE
		lea	(RAM_start+$222).l,a2
		bsr.w	OptionScreen_HexDumpSoundTest

loc3_67DE:
		lea	(RAM_start+$160).l,a1
		move.l	(a3)+,d0
		moveq	#22-1,d1
		moveq	#8-1,d2
		bra.w	Plane_Map_To_VRAM
; End of function OptionScreen_DrawUnselected


; =============== S U B R O U T I N E =======================================


OptionScreen_SelectTextPtr:
		lea	(off3_6858).l,a4
		tst.b	(Graphics_flags).w
		bpl.s	loc3_6800
		lea	(off3_6864).l,a4

loc3_6800:
		tst.b	(Options_menu_box).w
		beq.s	loc3_680C
		lea	(off3_6870).l,a4

loc3_680C:
		cmpi.b	#2,(Options_menu_box).w
		bne.s	locret3_681A
		lea	(off3_6878).l,a4

locret3_681A:
		rts
; End of function OptionScreen_SelectTextPtr


; =============== S U B R O U T I N E =======================================


OptionScreen_HexDumpSoundTest:
		move.w	(Sound_test_sound).w,d1
		move.b	d1,d2
		lsr.b	#4,d1
		bsr.s	sub3_6828
		move.b	d2,d1
; End of function OptionScreen_HexDumpSoundTest


; =============== S U B R O U T I N E =======================================


sub3_6828:
		andi.w	#$F,d1
		cmpi.b	#$A,d1
		bcs.s	loc3_6836
		addi.b	#4,d1

loc3_6836:
		addi.b	#$10,d1
		move.b	d1,d0
		move.w	d0,(a2)+
		rts
; End of function sub3_6828

; ---------------------------------------------------------------------------
S2OptScrBoxData:
		dc.l TextOptScr_PlayerSelect
		dc.l vdpComm(VRAM_Plane_A_Name_Table+$192,VRAM,WRITE)
		dc.l TextOptScr_VsModeItems
		dc.l vdpComm(VRAM_Plane_A_Name_Table+$592,VRAM,WRITE)
		dc.l TextOptScr_SoundTest
		dc.l vdpComm(VRAM_Plane_A_Name_Table+$992,VRAM,WRITE)
off3_6858:
		dc.l TextOptScr_SonicAndMiles
		dc.l TextOptScr_SonicAlone
		dc.l TextOptScr_MilesAlone
off3_6864:
		dc.l TextOptScr_SonicAndTails
		dc.l TextOptScr_SonicAlone
		dc.l TextOptScr_TailsAlone
off3_6870:
		dc.l TextOptScr_AllKindsItems
		dc.l TextOptScr_TeleportOnly
off3_6878:
		dc.l TextOptScr_0