; ---------------------------------------------------------------------------
; locret3_952E:
locretK_A85C:
		rts
; ---------------------------------------------------------------------------

Competition_Menu:
		bsr.w	Pal_FadeToBlack
		move	#$2700,sr
		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Clear_DisplayData).l
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$8730,(a6)
		move.w	#$8B00,(a6)
		move.w	#$8C81,(a6)
		move.w	#$9011,(a6)
	if Sonic3_Alone
		jsr	sub_B512(pc)
	else
		jsr	sub_C02A(pc)
	endif
		clearRAM	Sprite_table_input,(Sprite_table_input_end-Sprite_table_input)
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		clr.w	(Level_frame_counter).w
		cmpi.b	#3,(Competition_menu_selection).w
		blo.s	locK_A8DC
		clr.b	(Competition_menu_selection).w
; loc3_95AE:
locK_A8DC:
		lea	(MapEni_S3MenuBG).l,a0
		lea	(RAM_start).l,a1
		move.w	#make_art_tile(ArtTile_S3MenuBG,3,0),d0
		jsr	(Eni_Decomp).l
		lea	(RAM_start).l,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table,VRAM,WRITE),d0
		moveq	#40-1,d1
		moveq	#28-1,d2
		jsr	(Plane_Map_To_VRAM).l
		lea	(ArtKos_S3MenuBG).l,a0				; Decompress source
		lea	(RAM_start).l,a1				; Decompress destination/Transfer source
		movea.w	#tiles_to_bytes(ArtTile_S3MenuBG),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.l	#locretK_A85C,(_unkEF44_1).w
		move.b	#VInt_ID_1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(ArtKos_CompetitionLevel).l,a0				; Decompress source
		lea	(RAM_start).l,a1					; Decompress destination/Transfer source, used by the next KosArt_To_VDP also
		movea.w	#tiles_to_bytes(ArtTile_Competition_LevSel),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		lea	(ArtKos_CompetitionMode).l,a0				; Decompress source
		movea.w	#tiles_to_bytes(ArtTile_Competition_ModeSel),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.b	#VInt_ID_1E,(V_int_routine).w
		jsr	(Wait_VSync).l
	if Sonic3_Alone
		lea	Pal_Competition1(pc),a0
	else
		lea	(Pal_Competition1).l,a0
	endif
		lea	(Target_palette).w,a1
		moveq	#bytesToLcnt($60),d0
; loc3_963A:
locK_A96A:
		move.l	(a0)+,(a1)+
		dbf	d0,locK_A96A
		lea	(Pal_CompetitionMenuBG).l,a0
		moveq	#bytesToLcnt($20),d0
; loc3_9648:
locK_A978:
		move.l	(a0)+,(a1)+
		dbf	d0,locK_A978
		lea	(Object_RAM).w,a0
		lea	ObjDat_AB48(pc),a1
		move.w	(a1)+,d0
; loc3_9658:
locK_A988:
		move.l	(a1)+,(a0)
		move.w	#make_art_tile(ArtTile_Competition_ModeSel,0,0),art_tile(a0)
		move.l	#Map_CompetitionObject,mappings(a0)
		move.w	(a1)+,x_pos(a0)
		move.w	(a1)+,y_pos(a0)
		move.b	(a1)+,mapping_frame(a0)
		move.b	(a1)+,$2E(a0)
		lea	next_object(a0),a0
		dbf	d0,locK_A988
		jsr	(Init_SpriteTable).l
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		moveq	#signextendB(mus_CompetitionMenu),d0
		jsr	(Play_Music).l
		move.b	#VInt_ID_1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		bsr.w	Pal_FadeFromBlack
; loc3_96B8:
locK_A9E8:
		move.b	#VInt_ID_1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		addq.w	#1,(Level_frame_counter).w
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		move.b	d0,d1
		andi.b	#button_A_mask|button_B_mask|button_C_mask|button_start_mask,d1
		beq.w	locK_AAA6
		btst	#button_B,d1
		bne.s	locK_AA2E
		moveq	#0,d2
		move.b	(Competition_menu_selection).w,d2
		add.w	d2,d2
		jmp	locK_AA28(pc,d2.w)
; ---------------------------------------------------------------------------
; loc3_96F8:
locK_AA28:
		bra.s	locK_AA36
; ---------------------------------------------------------------------------
		bra.s	locK_AA54
; ---------------------------------------------------------------------------
		bra.s	locK_AA74
; ---------------------------------------------------------------------------
; loc3_96FE:
locK_AA2E:
		move.b	#GameMode_TitleScreen,(Game_mode).w
		rts
; ---------------------------------------------------------------------------
; loc3_9706:
locK_AA36:
		clr.b	(Competition_type).w
		move.b	(Competition_menu_items).w,(Competition_items).w
		move.b	(Ctrl_2_pressed).w,d0
		andi.b	#button_A_mask|button_C_mask|button_start_mask,d0
		sne	(Not_ghost_flag).w
		move.b	#GameMode_CompetitionPlayerSelect,(Game_mode).w
		bra.s	locK_AA8E
; ---------------------------------------------------------------------------
; loc3_9724:
locK_AA54:
		move.b	#3,(Competition_type).w
		move.b	(Competition_menu_items).w,(Competition_items).w
		move.b	(Ctrl_2_pressed).w,d0
		andi.b	#button_A_mask|button_C_mask|button_start_mask,d0
		sne	(Not_ghost_flag).w
		move.b	#GameMode_CompetitionLevelSelect,(Game_mode).w
		bra.s	locK_AA8E
; ---------------------------------------------------------------------------
; loc3_9744:
locK_AA74:
		move.b	(Ctrl_1_pressed).w,d2
		andi.w	#button_A_mask|button_C_mask|button_start_mask,d2
		beq.s	locK_AAA6
		move.w	#-1,(Competition_settings).w
		clr.b	(Not_ghost_flag).w
		move.b	#GameMode_CompetitionLevelSelect+$80,(Game_mode).w
; loc3_975E:
locK_AA8E:
		lea	($FF7800).l,a1
		moveq	#0,d0
		moveq	#bytesToLcnt($28),d1
; loc3_9768:
locK_AA98:
		move.l	d0,(a1)+
		dbf	d1,locK_AA98
		moveq	#signextendB(sfx_Starpost),d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------
; loc3_9776:
locK_AAA6:
		moveq	#0,d2
		move.b	(Competition_menu_selection).w,d1
		lsr.w	#1,d0
		bcc.s	locK_AABA
		moveq	#signextendB(sfx_Switch),d2
		subq.b	#1,d1
		bcc.s	locK_AACA
		moveq	#3,d1
		bra.s	locK_AACA
; ---------------------------------------------------------------------------
; loc3_978A:
locK_AABA:
		lsr.w	#1,d0
		bcc.s	locK_AACA
		moveq	#signextendB(sfx_Switch),d2
		addq.b	#1,d1
		cmpi.b	#3,d1
		bls.s	locK_AACA
		moveq	#0,d1
; loc3_979A:
locK_AACA:
		move.b	d1,(Competition_menu_selection).w
		move.w	d2,d0
		beq.s	locK_AAD8
		jsr	(Play_SFX).l
; loc3_97A8:
locK_AAD8:
		bra.w	locK_A9E8
; ---------------------------------------------------------------------------

Obj_Competition_AADC:
		move.b	$2E(a0),d0
		bmi.s	locK_AAFA
		andi.w	#$9FFF,art_tile(a0)
		move.w	#palette_line_1,d1
		cmp.b	(Competition_menu_selection).w,d0
		bne.s	locK_AAF6
		move.w	#palette_line_2,d1
; loc3_97C6:
locK_AAF6:
		or.w	d1,art_tile(a0)
; loc3_97CA:
locK_AAFA:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_Competition_AB00:
		cmpi.b	#1,(Competition_menu_selection).w
		bhi.s	locretK_AB46
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		andi.w	#button_left_mask|button_right_mask,d0
		beq.s	locK_AB26
		tst.b	(Competition_menu_items).w
		seq	(Competition_menu_items).w
		moveq	#signextendB(sfx_Switch),d0
		jsr	(Play_SFX).l
; loc3_97F6:
locK_AB26:
		move.w	#$15C,d0
		tst.b	(Competition_menu_items).w
		beq.s	locK_AB34
		addi.w	#$20,d0
; loc3_9804:
locK_AB34:
		move.w	d0,x_pos(a0)
		btst	#3,(Level_frame_counter+1).w
		beq.s	locretK_AB46
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; locret3_9816:
locretK_AB46:
		rts
; ---------------------------------------------------------------------------

	if Sonic3_Alone
Pal_Competition1:
		binclude "General/Competition Menu/Palettes/1.bin"
		even
	endif

ObjDat_AB48:
		dc.w 7-1
		dc.l Obj_Competition_AADC
		dc.w   $114,   $A0
		dc.b    0,   0
		dc.l Obj_Competition_AADC
		dc.w   $10C,   $C0
		dc.b    1,   1
		dc.l Obj_Competition_AADC
		dc.w   $108,   $E0
		dc.b    2,   2
		dc.l Obj_Competition_AADC
		dc.w   $13C,  $120
		dc.b    3,   3
		dc.l Obj_Competition_AADC
		dc.w   $164,   $B0
		dc.b    4, $FF
		dc.l Obj_Competition_AADC
		dc.w   $184,   $B0
		dc.b    5, $FF
		dc.l Obj_Competition_AB00
		dc.w      0,   $A8
		dc.b    6, $FF

	if Sonic3_Alone
Map_CompetitionObject:
		include "General/Competition Menu/Map - Competition Objects.asm"
	endif
; ---------------------------------------------------------------------------

Competition_LevelSelect:
		bsr.w	Pal_FadeToBlack
		move	#$2700,sr
		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Clear_DisplayData).l
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$8700,(a6)
		move.w	#$8B00,(a6)
		move.w	#$8C89,(a6)
		move.w	#$9011,(a6)
	if Sonic3_Alone
		jsr	sub_B512(pc)
	else
		jsr	sub_C02A(pc)
	endif
		clearRAM	Sprite_table_input,(Sprite_table_input_end-Sprite_table_input)
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		clr.w	(Level_frame_counter).w
		clr.w	(Competition_mode).w
		clr.b	(Level_started_flag).w
		move.w	#-1,(Events_bg+$10).w
		clr.w	(Events_bg+$12).w
		clr.w	(Events_bg+$14).w
		lea	(MapEni_S3MenuBG).l,a0
		lea	(RAM_start).l,a1
		move.w	#make_art_tile(ArtTile_S3MenuBG,0,0),d0
		jsr	(Eni_Decomp).l
		lea	(RAM_start).l,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table,VRAM,WRITE),d0
		moveq	#40-1,d1
		moveq	#28-1,d2
		jsr	(Plane_Map_To_VRAM).l
		lea	(MapEni_CompetitionLevBorder).l,a0
		lea	(RAM_start).l,a1
		move.w	#make_art_tile(ArtTile_Competition_LevSel,0,1),d0
		jsr	(Eni_Decomp).l
		lea	(MapEni_CompetitionLevImage).l,a0
		lea	(RAM_start+$1000).l,a1
		move.w	#make_art_tile(ArtTile_Competition_LevSel,3,1),d0
		jsr	(Eni_Decomp).l
		lea	(MapEni_CompetitionLevName).l,a0
		lea	(RAM_start+$2000).l,a1
		move.w	#make_art_tile(ArtTile_Competition_LevSel,1,1),d0
		jsr	(Eni_Decomp).l
		lea	VRAMDatList_CompetitionLevelSelect(pc),a0
		jsr	Copy_Listed_Data_To_VRAM(pc)
		jsr	subK_AFB2(pc)
		mulu.w	#$48,d0
		move.w	d0,(V_scroll_value).w
		jsr	subK_B006(pc)
		jsr	subK_B036(pc)
		lea	(ArtKos_S3MenuBG).l,a0				; Decompress source
		lea	(RAM_start).l,a1				; Decompress destination/Transfer source
		movea.w	#tiles_to_bytes(ArtTile_S3MenuBG),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.l	#locretK_A85C,(_unkEF44_1).w
		move.b	#VInt_ID_1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(ArtKos_CompetitionLevel).l,a0				; Decompress source
		lea	(RAM_start).l,a1					; Decompress destination/Transfer source, used by the next KosArt_To_VDP also
		movea.w	#tiles_to_bytes(ArtTile_Competition_LevSel),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		lea	(ArtKos_CompetitionPlayer).l,a0				; Decompress source
		movea.w	#tiles_to_bytes(ArtTile_Competition_CharSel),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.b	#VInt_ID_1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(Pal_CompetitionMenuBG).l,a0
		lea	(Target_palette).w,a1
		moveq	#bytesToLcnt(Target_palette_line_2-Target_palette),d0
; loc3_9B70:
locK_AD04:
		move.l	(a0)+,(a1)+
		dbf	d0,locK_AD04
	if Sonic3_Alone
		lea	Pal_Competition2(pc),a0
	else
		lea	(Pal_Competition2).l,a0
	endif
		moveq	#bytesToLcnt(Target_palette_end-Target_palette_line_2),d0
; loc3_9B7C:
locK_AD12:
		move.l	(a0)+,(a1)+
		dbf	d0,locK_AD12
		lea	(Object_RAM).w,a0
		lea	ObjDat_CompetitionMatchRace(pc),a1
		tst.b	(Game_mode).w
		bpl.s	locK_AD2A
		lea	ObjDat_CompetitionTimeAttack(pc),a1
; loc3_9B94:
locK_AD2A:
		move.w	(a1)+,d0
; loc3_9B96:
locK_AD2C:
		move.l	(a1)+,(a0)
		move.l	#Map_CompetitionSelect,mappings(a0)
		move.w	(a1),x_pos(a0)
		move.w	(a1)+,objoff_12(a0)
		move.w	(a1),y_pos(a0)
		move.w	(a1)+,objoff_16(a0)
		move.w	(a1)+,d1
		addi.w	#make_art_tile(ArtTile_Competition_LevSel,0,1),d1
		move.w	d1,art_tile(a0)
		move.b	(a1)+,mapping_frame(a0)
		move.b	(a1)+,$2E(a0)
		lea	next_object(a0),a0
		dbf	d0,locK_AD2C
		moveq	#0,d0
		move.b	(P1_character).w,d0
		mulu.w	#$55,d0
		addi.b	#$40,d0
		move.b	d0,(Reserved_object_3+objoff_2E).w
		tst.b	(Game_mode).w
		bmi.s	locK_AD8A
		moveq	#0,d0
		move.b	(P2_character).w,d0
		mulu.w	#$55,d0
		addi.b	#$40,d0
		move.b	d0,(Dynamic_object_RAM+(object_size*4)+objoff_2E).w
; loc3_9BF4:
locK_AD8A:
		jsr	(Init_SpriteTable).l
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
	if Sonic3_Alone
		jsr	sub_B596(pc)
	else
		jsr	sub_C0AE(pc)
	endif
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		lea	(Dynamic_object_RAM+(object_size*9)).w,a0
		move.l	#locK_AF58,(a0)
		move.l	#Map_CompetitionSelect,mappings(a0)
		addi.w	#make_art_tile(ArtTile_Competition_LevSel,2,1),art_tile(a0)
		move.w	#$B0,x_pos(a0)
		moveq	#signextendB(mus_CompetitionMenu),d0
		jsr	(Play_Music).l
		move.b	#VInt_ID_1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Pal_FadeFromBlack).l
; loc3_9C5C:
locK_ADF2:
		move.b	#VInt_ID_1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		addq.w	#1,(Level_frame_counter).w
		jsr	(Process_Sprites).l
	if Sonic3_Alone
		jsr	sub_B596(pc)
	else
		jsr	sub_C0AE(pc)
	endif
		jsr	(Render_Sprites).l
		move.b	(Events_bg+$12).w,d0
		beq.s	locK_AE1E
		move.b	d0,(Game_mode).w
		rts
; ---------------------------------------------------------------------------
; loc3_9C88:
locK_AE1E:
		move.w	(Events_bg+$10).w,d0
		tst.b	(Not_ghost_flag).w
		bne.s	locK_AE2A
		lsr.w	#8,d0
; loc3_9C94:
locK_AE2A:
		tst.w	d0
		beq.s	locK_AE4A
		move.w	(H_scroll_buffer).w,d0
		beq.s	locK_ADF2
		cmpi.w	#-$58,d0
		bne.s	locK_AE42
		move.l	#locK_AFC8,(_unkEF44_1).w
; loc3_9CAC:
locK_AE42:
		addq.w	#8,d0
		move.w	d0,(H_scroll_buffer).w
		bra.s	locK_ADF2
; ---------------------------------------------------------------------------
; loc3_9CB4:
locK_AE4A:
		cmpi.w	#-$58,(H_scroll_buffer).w
		beq.s	locK_AE58
		subq.w	#8,(H_scroll_buffer).w
		bra.s	locK_ADF2
; ---------------------------------------------------------------------------
; loc3_9CC2:
locK_AE58:
		moveq	#8,d0
		move.w	(Events_bg+$14).w,d1
		beq.s	locK_AE6E
		bpl.s	locK_AE64
		neg.w	d0
; loc3_9CCE:
locK_AE64:
		add.w	d0,(V_scroll_value).w
		sub.w	d0,(Events_bg+$14).w
		bra.s	locK_ADF2
; ---------------------------------------------------------------------------
; loc3_9CD8:
locK_AE6E:
		move.b	(Ctrl_1_pressed).w,d1
		moveq	#0,d2
		tst.b	(Not_ghost_flag).w
		beq.s	locK_AE7E
		move.b	(Ctrl_2_pressed).w,d2
; loc3_9CE8:
locK_AE7E:
		btst	#button_B,d2
		beq.s	locK_AE8C
		sf	(Dynamic_object_RAM+(object_size*4)+objoff_2F).w
		st	(Events_bg+$11).w
; loc3_9CF6:
locK_AE8C:
		btst	#button_B,d1
		beq.s	locK_AE9A
		sf	(Reserved_object_3+objoff_2F).w
		st	(Events_bg+$10).w
; loc3_9D04:
locK_AE9A:
		or.b	d2,d1
		move.b	d1,d2
		andi.w	#3,d2
		beq.s	locK_AEF2
		lea	(Competition_menu_zone).w,a0
		lsr.w	#1,d2
		bcs.s	locK_AED2
		cmpi.b	#4,(a0)
		beq.s	locK_AEF2
		moveq	#signextendB(sfx_Switch),d0
		jsr	(Play_SFX).l
		addq.b	#1,(a0)
		cmpi.b	#4,(a0)
		beq.s	locK_AEF2
		cmpi.b	#1,(a0)
		beq.s	locK_AEF2
		move.w	#$48,(Events_bg+$14).w
		bra.w	locK_ADF2
; ---------------------------------------------------------------------------
; loc3_9D3C:
locK_AED2:
		tst.b	(a0)
		beq.s	locK_AEF2
		moveq	#signextendB(sfx_Switch),d0
		jsr	(Play_SFX).l
		subq.b	#1,(a0)
		beq.s	locK_AEF2
		cmpi.b	#3,(a0)
		beq.s	locK_AEF2
		move.w	#-$48,(Events_bg+$14).w
		bra.w	locK_ADF2
; ---------------------------------------------------------------------------
; loc3_9D5C:
locK_AEF2:
		andi.w	#$E0,d1
		beq.w	locK_ADF2
		moveq	#signextendB(sfx_Starpost),d0
		jsr	(Play_SFX).l
		moveq	#0,d0
		move.b	(Competition_menu_zone).w,d0
		move.b	Comp_ZoneList(pc,d0.w),(Current_zone).w
		clr.b	(Current_act).w
	if Sonic3_Alone
		jsr	sub_B5EC(pc)
	else
		jsr	sub_C104(pc)
	endif
		move.b	#GameMode_Level,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

Comp_ZoneList:
		dc.b   $E
		dc.b   $F
		dc.b  $11
		dc.b  $10
		dc.b  $12
		dc.b  $FF
; ---------------------------------------------------------------------------

Obj_Competition_ZoneSelect:
		cmpi.w	#-$58,(H_scroll_buffer).w
		bne.s	locretK_AF56
		tst.w	(Events_bg+$14).w
		bne.s	locretK_AF56
		moveq	#0,d0
		move.b	(Competition_menu_zone).w,d0
		mulu.w	#$48,d0
		addi.w	#$AC,d0
		sub.w	(V_scroll_value).w,d0
		move.w	d0,y_pos(a0)
		btst	#3,(Level_frame_counter+1).w
		beq.s	locretK_AF56
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; locret3_9DC0:
locretK_AF56:
		rts
; ---------------------------------------------------------------------------
; loc3_9DC2:
locK_AF58:
		cmpi.w	#-$58,(H_scroll_buffer).w
		bne.s	locK_AF9E
		tst.w	(Events_bg+$14).w
		bne.s	locK_AF9E
		moveq	#0,d0
		move.b	(Competition_menu_zone).w,d0
		mulu.w	#$48,d0
		addi.w	#$A8,d0
		sub.w	(V_scroll_value).w,d0
		move.w	d0,y_pos(a0)
		move.b	(Competition_menu_zone).w,d0
		addq.b	#6,d0
		move.b	d0,mapping_frame(a0)
		jsr	(Draw_Sprite).l
		moveq	#0,d0
		move.b	(Competition_menu_zone).w,d0
		lsl.w	#5,d0
	if Sonic3_Alone
		lea	Pal_Competition4(pc),a1
	else
		lea	(Pal_Competition4).l,a1
	endif
		adda.w	d0,a1
		bra.s	locK_AFA4
; ---------------------------------------------------------------------------
; loc3_9E06:
locK_AF9E:
	if Sonic3_Alone
		lea	Pal_Competition3(pc),a1
	else
		lea	(Pal_Competition3).l,a1
	endif
; loc3_9E0A:
locK_AFA4:
		lea	(Normal_palette_line_3).w,a2
		moveq	#bytesToLcnt(Normal_palette_line_4-Normal_palette_line_3),d0
; loc3_9E10:
locK_AFAA:
		move.l	(a1)+,(a2)+
		dbf	d0,locK_AFAA
		rts

; =============== S U B R O U T I N E =======================================

; sub3_9E18:
subK_AFB2:
		moveq	#0,d0
		move.b	(Competition_menu_zone).w,d0
		subq.w	#1,d0
		bcc.s	locK_AFBE
		moveq	#0,d0
; loc3_9E24:
locK_AFBE:
		cmpi.w	#2,d0
		bls.s	locretK_AFC6
		moveq	#2,d0
; locret3_9E2C:
locretK_AFC6:
		rts
; End of function subK_AFB2

; ---------------------------------------------------------------------------
; loc3_9E2E:
locK_AFC8:
		move.l	#locretK_A85C,(_unkEF44_1).w
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$204,VRAM,WRITE),d0
		lea	(VDP_data_port).l,a6
		move.l	#$80008000,d1
		move.w	#$8F80,VDP_control_port-VDP_data_port(a6)
		moveq	#9-1,d2
; loc3_9E50:
locK_AFEA:
		moveq	#$13-1,d3
		move.l	d0,VDP_control_port-VDP_data_port(a6)
; loc3_9E56:
locK_AFF0:
		move.l	d1,(a6)
		dbf	d3,locK_AFF0
		addi.l	#2<<16,d0
		dbf	d2,locK_AFEA
		move.w	#$8F02,VDP_control_port-VDP_data_port(a6)

; =============== S U B R O U T I N E =======================================

; sub3_9E6C:
subK_B006:
		bsr.s	subK_AFB2
		mulu.w	#$48,d0
		addi.w	#$20,d0
		lsl.w	#4,d0
		addi.w	#VRAM_Plane_A_Name_Table+$004,d0
		move.w	d0,d7
		tst.b	(Game_mode).w
		bmi.s	locK_B02E
	if Sonic3_Alone
		jsr	sub_B534(pc)
	else
		jsr	sub_C04C(pc)
	endif
		move.w	d7,d0
		addi.w	#$600,d0
	if Sonic3_Alone
		jmp	sub_B534(pc)
	else
		jmp	sub_C04C(pc)
	endif
; ---------------------------------------------------------------------------
		; unused
		rts
; ---------------------------------------------------------------------------
; loc3_9E94:
locK_B02E:
		addi.w	#$300,d0
	if Sonic3_Alone
		jmp	sub_B534(pc)
	else
		jmp	sub_C04C(pc)
	endif
; End of function subK_B006


; =============== S U B R O U T I N E =======================================

; sub3_9E9C:
subK_B036:
		move.w	#VRAM_Plane_A_Name_Table+$2D2,d7
		move.l	(Competition_saved_data).w,d6
		bsr.s	subK_B066
		addi.w	#$480,d7
		move.l	(Competition_saved_data+$10).w,d6
		bsr.s	subK_B066
		addi.w	#$480,d7
		move.l	(Competition_saved_data+$30).w,d6
		bsr.s	subK_B066
		addi.w	#$480,d7
		move.l	(Competition_saved_data+$20).w,d6
		bsr.s	subK_B066
		addi.w	#$480,d7
		move.l	(Competition_saved_data+$40).w,d6
; End of function subK_B036


; =============== S U B R O U T I N E =======================================

; sub3_9ECC:
subK_B066:
		moveq	#0,d5
		lsl.l	#8,d6
		moveq	#2,d3
; loc3_9ED2:
locK_B06C:
		rol.l	#8,d6
		moveq	#0,d0
		move.b	d6,d0
		jsr	(LevResults_GetDecimalScore).l
		move.b	d1,d5
		lsl.l	#8,d5
		dbf	d3,locK_B06C
		lea	(Plane_buffer).w,a1
	if Sonic3_Alone
		lea	MapUnc_CompetitionNumbers(pc),a2
	else
		lea	(MapUnc_CompetitionNumbers).l,a2
	endif
		moveq	#0,d0
		bsr.s	subK_B0C2
		st	d0
		bsr.s	subK_B0C2
		moveq	#$A,d1
		bsr.s	subK_B0D4
		bsr.s	subK_B0C2
		bsr.s	subK_B0C2
		moveq	#$B,d1
		bsr.s	subK_B0D4
		bsr.s	subK_B0C2
		bsr.s	subK_B0C2
		lea	(Plane_buffer).w,a1
; sub3_9F0A:
subK_B0A6:
		move.w	d7,d0
		swap	d0
		clr.w	d0
		swap	d0
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap	d0
		moveq	#8-1,d1
		moveq	#2-1,d2
		jmp	(Plane_Map_To_VRAM).l
; End of function subK_B066


; =============== S U B R O U T I N E =======================================

; sub3_9F26:
subK_B0C2:
		rol.l	#4,d5
		move.w	d5,d1
		andi.w	#$F,d1
		bne.s	subK_B0D4
		tst.w	d0
		bne.s	subK_B0D4
		moveq	#$C,d1
		st	d0
; End of function subK_B0C2


; =============== S U B R O U T I N E =======================================

; sub3_9F38:
subK_B0D4:
		add.w	d1,d1
		add.w	d1,d1
		move.w	(a2,d1.w),(a1)+
		move.w	2(a2,d1.w),$E(a1)
		rts
; End of function subK_B0D4


; =============== S U B R O U T I N E =======================================

; sub3_9F48:
subK_B0E4:
	if Sonic3_Alone
		lea	(byte_373E4).l,a1
	else
		lea	(byte_37E52).l,a1
	endif
		moveq	#0,d0
		move.b	d6,d0
		move.b	(a1,d0.w),d6
		rts
; End of function subK_B0E4

; ---------------------------------------------------------------------------

VRAMDatList_CompetitionLevelSelect:
		dc.w $19-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$0098,  27-1, 9-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$0518,  27-1, 9-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$0998,  27-1, 9-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$0E18,  27-1, 9-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$1298,  27-1, 9-1
		dc.l RAM_start+$1180
		dc.w VRAM_Plane_A_Name_Table+$011A,   8-1, 6-1
		dc.l RAM_start+$1120
		dc.w VRAM_Plane_A_Name_Table+$059A,   8-1, 6-1
		dc.l RAM_start+$1000
		dc.w VRAM_Plane_A_Name_Table+$0A1A,   8-1, 6-1
		dc.l RAM_start+$1060
		dc.w VRAM_Plane_A_Name_Table+$0E9A,   8-1, 6-1
		dc.l RAM_start+$10C0
		dc.w VRAM_Plane_A_Name_Table+$131A,   8-1, 6-1
		dc.l RAM_start+$2000
		dc.w VRAM_Plane_A_Name_Table+$01AC,  15-1, 5-1
		dc.l RAM_start+$2258
		dc.w VRAM_Plane_A_Name_Table+$062C,  15-1, 5-1
		dc.l RAM_start+$2096
		dc.w VRAM_Plane_A_Name_Table+$0AAC,  15-1, 5-1
		dc.l RAM_start+$21C2
		dc.w VRAM_Plane_A_Name_Table+$0F2C,  15-1, 5-1
		dc.l RAM_start+$212C
		dc.w VRAM_Plane_A_Name_Table+$13AC,  15-1, 5-1
		dc.l MapUnc_CompetitionTimeBorder
		dc.w VRAM_Plane_A_Name_Table+$00CE,  12-1, 9-1
		dc.l MapUnc_CompetitionTimeBorder
		dc.w VRAM_Plane_A_Name_Table+$054E,  12-1, 9-1
		dc.l MapUnc_CompetitionTimeBorder
		dc.w VRAM_Plane_A_Name_Table+$09CE,  12-1, 9-1
		dc.l MapUnc_CompetitionTimeBorder
		dc.w VRAM_Plane_A_Name_Table+$0E4E,  12-1, 9-1
		dc.l MapUnc_CompetitionTimeBorder
		dc.w VRAM_Plane_A_Name_Table+$12CE,  12-1, 9-1
		dc.l MapUnc_CompetitionBESTTIME
		dc.w VRAM_Plane_A_Name_Table+$01D0,   9-1, 2-1
		dc.l MapUnc_CompetitionBESTTIME
		dc.w VRAM_Plane_A_Name_Table+$0650,   9-1, 2-1
		dc.l MapUnc_CompetitionBESTTIME
		dc.w VRAM_Plane_A_Name_Table+$0AD0,   9-1, 2-1
		dc.l MapUnc_CompetitionBESTTIME
		dc.w VRAM_Plane_A_Name_Table+$0F50,   9-1, 2-1
		dc.l MapUnc_CompetitionBESTTIME
		dc.w VRAM_Plane_A_Name_Table+$13D0,   9-1, 2-1

ObjDat_CompetitionMatchRace:
		dc.w $C-1
		dc.l Obj_Competition_ZoneSelect
		dc.w    $F4,     0, palette_line_0
		dc.b    2,   0
		dc.l Obj_Competition_StaticSprite
		dc.w    $B0,   $A9, palette_line_1
		dc.b    3,   0
		dc.l Obj_Competition_1PSelect
		dc.w    $B5,   $C1, palette_line_0
		dc.b    0,   0
		dc.l Obj_CompetitionPlayerSprite
		dc.w    $B5,   $D5, palette_line_0
		dc.b    0,   0
		dc.l Obj_CompetitionPlayerSprite
		dc.w    $B5,   $D5, palette_line_0
		dc.b    2,   1
		dc.l Obj_CompetitionPlayerSprite
		dc.w    $B5,   $D5, palette_line_0
		dc.b    1,   2
		dc.l Obj_Competition_StaticSprite
		dc.w    $B2,  $109, palette_line_1
		dc.b    4,   0
		dc.l Obj_Competition_2PSelect
		dc.w    $B5,  $121, palette_line_0
		dc.b    0,   0
		dc.l Obj_CompetitionPlayerSprite2P
		dc.w    $B5,  $135, palette_line_0
		dc.b    0,   0
		dc.l Obj_CompetitionPlayerSprite2P
		dc.w    $B5,  $135, palette_line_0
		dc.b    2,   1
		dc.l Obj_CompetitionPlayerSprite2P
		dc.w    $B5,  $135, palette_line_0
		dc.b    1,   2
		dc.l Obj_Competition_PRESSSTART
		dc.w    $B1,  $126, palette_line_1
		dc.b    5,   0

ObjDat_CompetitionTimeAttack:
		dc.w 6-1
		dc.l Obj_Competition_ZoneSelect
		dc.w    $F4,   $30, palette_line_0
		dc.b    2,   0
		dc.l Obj_Competition_StaticSprite
		dc.w    $B0,     0, palette_line_1
		dc.b    3,   0
		dc.l Obj_Competition_1PSelect
		dc.w    $B5,   $F1, palette_line_0
		dc.b    0,   0
		dc.l Obj_CompetitionPlayerSprite
		dc.w    $B5,  $101, palette_line_0
		dc.b    0,   0
		dc.l Obj_CompetitionPlayerSprite
		dc.w    $B5,  $101, palette_line_0
		dc.b    2,   1
		dc.l Obj_CompetitionPlayerSprite
		dc.w    $B5,  $101, palette_line_0
		dc.b    1,   2

	if Sonic3_Alone
MapUnc_CompetitionNumbers:
		binclude "General/Competition Menu/Uncompressed Map/Numbers.bin"
		even
	endif
; ---------------------------------------------------------------------------

Competition_PlayerSelect:
		jsr	(Pal_FadeToBlack).l
		move	#$2700,sr
		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Clear_DisplayData).l
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$8700,(a6)
		move.w	#$8B00,(a6)
		move.w	#$8C89,(a6)
		move.w	#$9011,(a6)
	if Sonic3_Alone
		jsr	sub_B512(pc)
	else
		jsr	sub_C02A(pc)
	endif
		move.w	#VRAM_Plane_A_Name_Table+$220,d0
	if Sonic3_Alone
		jsr	sub_B534(pc)
	else
		jsr	sub_C04C(pc)
	endif
		move.w	#VRAM_Plane_A_Name_Table+$820,d0
	if Sonic3_Alone
		jsr	sub_B534(pc)
	else
		jsr	sub_C04C(pc)
	endif
		clearRAM	Sprite_table_input,(Sprite_table_input_end-Sprite_table_input)
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		clr.w	(Level_frame_counter).w
		move.w	#-1,(Events_bg+$10).w
		clr.w	(Events_bg+$12).w
		lea	(MapEni_S3MenuBG).l,a0
		lea	(RAM_start).l,a1
		move.w	#make_art_tile(ArtTile_S3MenuBG,0,0),d0
		jsr	(Eni_Decomp).l
		lea	(RAM_start).l,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table,VRAM,WRITE),d0
		moveq	#40-1,d1
		moveq	#28-1,d2
		jsr	(Plane_Map_To_VRAM).l
		lea	(ArtKos_S3MenuBG).l,a0				; Decompress source
		lea	(RAM_start).l,a1				; Decompress destination/Transfer source
		movea.w	#tiles_to_bytes(ArtTile_S3MenuBG),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.l	#locretK_A85C,(_unkEF44_1).w
		move.b	#VInt_ID_1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(ArtKos_CompetitionLevel).l,a0				; Decompress source
		lea	(RAM_start).l,a1					; Decompress destination/Transfer source, used by the next KosArt_To_VDP also
		movea.w	#tiles_to_bytes(ArtTile_Competition_LevSel),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		lea	(ArtKos_CompetitionPlayer).l,a0				; Decompress source
		movea.w	#tiles_to_bytes(ArtTile_Competition_CharSel),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.b	#VInt_ID_1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(Pal_CompetitionMenuBG).l,a0
		lea	(Target_palette).w,a1
		moveq	#bytesToLcnt(Target_palette_line_2-Target_palette),d0
; loc3_A280:
locK_B3E8:
		move.l	(a0)+,(a1)+
		dbf	d0,locK_B3E8
	if Sonic3_Alone
		lea	Pal_Competition2(pc),a0
	else
		lea	(Pal_Competition2).l,a0
	endif
		moveq	#bytesToLcnt(Target_palette_end-Target_palette_line_2),d0
; loc3_A28C:
locK_B3F6:
		move.l	(a0)+,(a1)+
		dbf	d0,locK_B3F6
		lea	(Player_2).w,a0
		lea	ObjDat_B6C8(pc),a1
		move.w	(a1)+,d0
; loc3_A29C:
locK_B406:
		move.l	(a1)+,(a0)
		move.l	#Map_CompetitionSelect,mappings(a0)
		move.w	(a1),x_pos(a0)
		move.w	(a1)+,objoff_12(a0)
		move.w	(a1),y_pos(a0)
		move.w	(a1)+,objoff_16(a0)
		move.w	(a1)+,d1
		addi.w	#make_art_tile(ArtTile_Competition_LevSel,0,1),d1
		move.w	d1,art_tile(a0)
		move.b	(a1)+,mapping_frame(a0)
		move.b	(a1)+,$2E(a0)
		lea	next_object(a0),a0
		dbf	d0,locK_B406
		moveq	#0,d0
		move.b	(P1_character).w,d0
		mulu.w	#$55,d0
		addi.b	#$40,d0
		move.b	d0,(Reserved_object_3+objoff_2E).w
		moveq	#0,d0
		move.b	(P2_character).w,d0
		mulu.w	#$55,d0
		addi.b	#$40,d0
		move.b	d0,(Dynamic_object_RAM+(object_size*4)+objoff_2E).w
		jsr	(Init_SpriteTable).l
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
	if Sonic3_Alone
		jsr	sub_B596(pc)
	else
		jsr	sub_C0AE(pc)
	endif
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		moveq	#signextendB(mus_CompetitionMenu),d0
		jsr	(Play_Music).l
		move.b	#VInt_ID_1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Pal_FadeFromBlack).l
; loc3_A33E:
locK_B4A8:
		move.b	#VInt_ID_1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		addq.w	#1,(Level_frame_counter).w
		jsr	(Process_Sprites).l
	if Sonic3_Alone
		jsr	sub_B596(pc)
	else
		jsr	sub_C0AE(pc)
	endif
		jsr	(Render_Sprites).l
		move.b	(Events_bg+$12).w,d0
		beq.s	locK_B4D4
		move.b	d0,(Game_mode).w
		rts
; ---------------------------------------------------------------------------
; loc3_A36A:
locK_B4D4:
		move.w	(Events_bg+$10).w,d0
		tst.b	(Not_ghost_flag).w
		bne.s	locK_B4E0
		lsr.w	#8,d0
; loc3_A376:
locK_B4E0:
		tst.w	d0
		bne.s	locK_B4A8
		move.w	#$E00,(Current_zone_and_act).w
	if Sonic3_Alone
		jsr	sub_B5EC(pc)
	else
		jsr	sub_C104(pc)
	endif
		move.b	#GameMode_Level,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

Obj_Competition_StaticSprite:
		move.w	$12(a0),d0
		add.w	(H_scroll_buffer).w,d0
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_Competition_2PSelect:
		lea	(Ctrl_2_pressed).w,a1
		lea	(Events_bg+$11).w,a2
		lea	(P2_character).w,a3
		tst.b	(Not_ghost_flag).w
		bne.s	locK_B538
		tst.w	(Events_bg+$14).w
		bne.s	locK_B526
		tst.b	(a1)
		smi	(Not_ghost_flag).w
; loc3_A3BC:
locK_B526:
		moveq	#0,d0
		bra.w	locK_B638
; ---------------------------------------------------------------------------

Obj_Competition_1PSelect:
		lea	(Ctrl_1_pressed).w,a1
		lea	(Events_bg+$10).w,a2
		lea	(P1_character).w,a3
; loc3_A3CE:
locK_B538:
		tst.w	(H_scroll_buffer).w
		bne.w	locK_B626
		tst.b	$2F(a0)
		beq.s	locK_B558
		btst	#button_B,(a1)
		beq.w	locK_B626
		sf	$2F(a0)
		st	(a2)
		bra.w	locK_B626
; ---------------------------------------------------------------------------
; loc3_A3EE:
locK_B558:
		tst.b	$30(a0)
		bne.s	locK_B5D0
		move.b	(a1),d0
		andi.w	#button_left_mask|button_right_mask,d0
		beq.w	locK_B602
		move.l	d0,-(sp)
		moveq	#signextendB(sfx_GravityTunnel),d0
		jsr	(Play_SFX).l
		move.l	(sp)+,d0
		clr.b	$34(a0)
		move.b	$2E(a0),$35(a0)
		btst	#button_left,d0
		bne.s	locK_B5AC
		move.b	#1,$30(a0)
		move.b	(a3),d0
		addq.b	#1,d0
		cmpi.b	#2,d0
		bls.s	locK_B596
		moveq	#0,d0
; loc3_A42C:
locK_B596:
		move.b	d0,(a3)
		mulu.w	#$55,d0
		bne.s	locK_B5A2
		move.w	#$100,d0
; loc3_A438:
locK_B5A2:
		addi.w	#$40,d0
		move.w	d0,$32(a0)
		bra.s	locK_B5D0
; ---------------------------------------------------------------------------
; loc3_A442:
locK_B5AC:
		move.b	#-1,$30(a0)
		move.b	(a3),d0
		subq.b	#1,d0
		bcc.s	locK_B5BA
		moveq	#2,d0
; loc3_A450:
locK_B5BA:
		move.b	d0,(a3)
		mulu.w	#$55,d0
		cmpi.w	#$80,d0
		blo.s	locK_B5C8
		ext.w	d0
; loc3_A45E:
locK_B5C8:
		addi.w	#$40,d0
		move.w	d0,$32(a0)
; loc3_A466:
locK_B5D0:
		move.w	$34(a0),d0
		move.w	$32(a0),d1
		tst.b	$30(a0)
		bmi.s	locK_B5EC
		addq.w	#5,d0
		cmp.w	d0,d1
		bgt.s	locK_B5F8
		move.w	d1,d0
		clr.b	$30(a0)
		bra.s	locK_B5F8
; ---------------------------------------------------------------------------
; loc3_A482:
locK_B5EC:
		subq.w	#5,d0
		cmp.w	d0,d1
		blt.s	locK_B5F8
		move.w	d1,d0
		clr.b	$30(a0)
; loc3_A48E:
locK_B5F8:
		move.w	d0,$34(a0)
		move.b	d0,$2E(a0)
		bra.s	locK_B626
; ---------------------------------------------------------------------------
; loc3_A498:
locK_B602:
		btst	#button_B,(a1)
		beq.s	locK_B610
		move.b	#$38,(Events_bg+$12).w
		bra.s	locK_B626
; ---------------------------------------------------------------------------
; loc3_A4A6:
locK_B610:
		move.b	(a1),d0
		andi.w	#button_A_mask|button_C_mask|button_start_mask,d0
		beq.s	locK_B626
		st	$2F(a0)
		sf	(a2)
		moveq	#signextendB(sfx_Starpost),d0
		jsr	(Play_SFX).l
; loc3_A4BC:
locK_B626:
		moveq	#1,d0
		tst.b	$2F(a0)
		bne.s	locK_B638
		move.w	(Level_frame_counter).w,d0
		lsr.w	#3,d0
		andi.w	#1,d0
; loc3_A4CE:
locK_B638:
		move.b	d0,mapping_frame(a0)
		move.w	$12(a0),d0
		add.w	(H_scroll_buffer).w,d0
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_CompetitionPlayerSprite2P:
		tst.b	(Not_ghost_flag).w
		bne.s	Obj_CompetitionPlayerSprite
		rts
; ---------------------------------------------------------------------------

Obj_CompetitionPlayerSprite:
		move.l	#Map_CompetitionPlayerSprite,mappings(a0)
		move.w	#make_art_tile(ArtTile_Competition_CharSel,1,0),art_tile(a0)
		moveq	#0,d0
		moveq	#-$55,d1
		moveq	#0,d2
		move.b	$2E(a0),d2
; loc3_A504:
locK_B66E:
		addi.w	#object_size,d0
		addi.w	#$55,d1
		dbf	d2,locK_B66E
		neg.w	d0
		move.b	$2E(a0,d0.w),d0
		add.b	d1,d0
		jsr	(GetSineCosine).l
		asr.w	#4,d1
		add.w	$12(a0),d1
		add.w	(H_scroll_buffer).w,d1
		move.w	d1,x_pos(a0)
		asr.w	#5,d0
		add.w	$16(a0),d0
		move.w	d0,y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_Competition_PRESSSTART:
		tst.b	(Not_ghost_flag).w
		bne.s	locretK_B6C6
		btst	#5,(Level_frame_counter+1).w
		beq.s	locretK_B6C6
		move.w	$12(a0),d0
		add.w	(H_scroll_buffer).w,d0
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; locret3_A55C:
locretK_B6C6:
		rts
; ---------------------------------------------------------------------------
	if Sonic3_Alone
Pal_Competition2:
		binclude "General/Competition Menu/Palettes/2.bin"
		even
Pal_Competition3:
		binclude "General/Competition Menu/Palettes/3.bin"
		even
Pal_Competition4:
		binclude "General/Competition Menu/Palettes/4.bin"
		even
	endif

ObjDat_B6C8:
		dc.w $B-1
		dc.l Obj_Competition_StaticSprite
		dc.w   $120,   $A9, palette_line_1
		dc.b    3,   0
		dc.l Obj_Competition_1PSelect
		dc.w   $125,   $C1, palette_line_0
		dc.b    0,   0
		dc.l Obj_CompetitionPlayerSprite
		dc.w   $125,   $D5, palette_line_0
		dc.b    0,   0
		dc.l Obj_CompetitionPlayerSprite
		dc.w   $125,   $D5, palette_line_0
		dc.b    2,   1
		dc.l Obj_CompetitionPlayerSprite
		dc.w   $125,   $D5, palette_line_0
		dc.b    1,   2
		dc.l Obj_Competition_StaticSprite
		dc.w   $122,  $109, palette_line_1
		dc.b    4,   0
		dc.l Obj_Competition_2PSelect
		dc.w   $125,  $121, palette_line_0
		dc.b    0,   0
		dc.l Obj_CompetitionPlayerSprite2P
		dc.w   $125,  $135, palette_line_0
		dc.b    0,   0
		dc.l Obj_CompetitionPlayerSprite2P
		dc.w   $125,  $135, palette_line_0
		dc.b    2,   1
		dc.l Obj_CompetitionPlayerSprite2P
		dc.w   $125,  $135, palette_line_0
		dc.b    1,   2
		dc.l Obj_Competition_PRESSSTART
		dc.w   $121,  $126, palette_line_1
		dc.b    5,   0

	if Sonic3_Alone
Map_CompetitionSelect:
		include "General/Competition Menu/Map - Competition Select.asm"
	endif
; ---------------------------------------------------------------------------

Competition_Results:
		jsr	(Pal_FadeToBlack).l
		move	#$2700,sr
		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Clear_DisplayData).l
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$8700,(a6)
		move.w	#$8B00,(a6)
		move.w	#$8C89,(a6)
		move.w	#$9011,(a6)
	if Sonic3_Alone
		jsr	sub_B512(pc)
	else
		jsr	sub_C02A(pc)
	endif
		move.w	#VRAM_Plane_A_Name_Table+$1AA,d0
	if Sonic3_Alone
		jsr	sub_B534(pc)
	else
		jsr	sub_C04C(pc)
	endif
		move.w	#VRAM_Plane_A_Name_Table+$82A,d0
	if Sonic3_Alone
		jsr	sub_B534(pc)
	else
		jsr	sub_C04C(pc)
	endif
		clearRAM	Sprite_table_input,(Sprite_table_input_end-Sprite_table_input)
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		clr.w	(Level_frame_counter).w
		clr.w	(Competition_mode).w
		clr.b	(Level_started_flag).w
		move.w	#$1E,(Events_bg+$16).w
		lea	(MapEni_S3MenuBG).l,a0
		lea	(RAM_start).l,a1
		move.w	#make_art_tile(ArtTile_S3MenuBG,0,0),d0
		jsr	(Eni_Decomp).l
	if Sonic3_Alone
		lea	MapEni_CompetitionResultsLED(pc),a0
	else
		lea	(MapEni_CompetitionResultsLED).l,a0
	endif
		lea	(RAM_start+$1000).l,a1
		move.w	#make_art_tile(ArtTile_Competition_Results,1,1),d0
		jsr	(Eni_Decomp).l
		lea	VRAMDatList_BBAC(pc),a0
		jsr	Copy_Listed_Data_To_VRAM(pc)
		jsr	subK_BA04(pc)
		lea	(ArtKos_S3MenuBG).l,a0				; Decompress source
		lea	(RAM_start).l,a1				; Decompress destination/Transfer source
		movea.w	#tiles_to_bytes(ArtTile_S3MenuBG),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.l	#locretK_A85C,(_unkEF44_1).w
		move.b	#VInt_ID_1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(ArtKos_CompetitionLevel).l,a0				; Decompress source
		lea	(RAM_start).l,a1					; Decompress destination/Transfer source, used by the next two KosArt_To_VDP also
		movea.w	#tiles_to_bytes(ArtTile_Competition_LevSel),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		lea	(ArtKos_CompetitionResults).l,a0			; Decompress source
		movea.w	#tiles_to_bytes(ArtTile_Competition_Results),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		lea	(ArtKos_CompetitionPlayer).l,a0				; Decompress source
		movea.w	#tiles_to_bytes(ArtTile_Competition_CharSel),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.b	#VInt_ID_1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(Pal_CompetitionMenuBG).l,a0
		lea	(Target_palette).w,a1
		moveq	#bytesToLcnt(Target_palette_line_2-Target_palette),d0
; loc3_AACC:
locK_B888:
		move.l	(a0)+,(a1)+
		dbf	d0,locK_B888
	if Sonic3_Alone
		lea	Pal_Competition2(pc),a0
	else
		lea	(Pal_Competition2).l,a0
	endif
		moveq	#bytesToLcnt(Target_palette_line_4-Target_palette_line_2),d0
; loc3_AAD8:
locK_B896:
		move.l	(a0)+,(a1)+
		dbf	d0,locK_B896
	if Sonic3_Alone
		lea	Pal_CompetitionResults(pc),a0
	else
		lea	(Pal_CompetitionResults).l,a0
	endif
		moveq	#bytesToLcnt(Target_palette_end-Target_palette_line_4),d0
; loc3_AAE4:
locK_B8A4:
		move.l	(a0)+,(a1)+
		dbf	d0,locK_B8A4
		lea	(Object_RAM).w,a0
		lea	ObjDat_BB4A(pc),a1
		move.w	(a1)+,d0
; loc3_AAF4:
locK_B8B4:
		move.l	(a1)+,(a0)
		move.l	#Map_CompetitionSelect,mappings(a0)
		move.w	(a1),x_pos(a0)
		move.w	(a1)+,objoff_12(a0)
		move.w	(a1),y_pos(a0)
		move.w	(a1)+,objoff_16(a0)
		move.w	(a1)+,d1
		addi.w	#make_art_tile(ArtTile_Competition_LevSel,0,1),d1
		move.w	d1,art_tile(a0)
		move.b	(a1)+,mapping_frame(a0)
		move.b	(a1)+,$2E(a0)
		lea	next_object(a0),a0
		dbf	d0,locK_B8B4
		jsr	(Init_SpriteTable).l
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		moveq	#signextendB(mus_Continue),d0
		jsr	(Play_Music).l
		move.b	#VInt_ID_1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Pal_FadeFromBlack).l
; loc3_AB62:
locK_B922:
		move.b	#VInt_ID_1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		addq.w	#1,(Level_frame_counter).w
		move.w	(_unkEEA0).w,d7
		beq.s	locK_B952
		btst	#3,(Level_frame_counter+1).w
		bne.s	locK_B94A
		lea	(Plane_buffer+$20).w,a1
		jsr	subK_B0A6(pc)
		bra.s	locK_B952
; ---------------------------------------------------------------------------
; loc3_AB8A:
locK_B94A:
		move.l	(_unkEE98).w,d6
		jsr	subK_B066(pc)
; loc3_AB92:
locK_B952:
		tst.w	(Events_bg+$16).w
		beq.s	locK_B95E
		subq.w	#1,(Events_bg+$16).w
		bra.s	locK_B996
; ---------------------------------------------------------------------------
; loc3_AB9E:
locK_B95E:
		move.b	(Ctrl_1_pressed).w,d0
		tst.b	(Not_ghost_flag).w
		beq.s	locK_B96C
		or.b	(Ctrl_2_pressed).w,d0
; loc3_ABAC:
locK_B96C:
		move.w	(H_scroll_buffer).w,d1
		beq.s	locK_B97A
		cmpi.w	#$FF78,d1
		beq.s	locK_B988
		bra.s	locK_B980
; ---------------------------------------------------------------------------
; loc3_ABBA:
locK_B97A:
		andi.w	#button_start_mask|button_A_mask|button_C_mask,d0
		beq.s	locK_B996
; loc3_ABC0:
locK_B980:
		subq.w	#8,d1
		move.w	d1,(H_scroll_buffer).w
		bra.s	locK_B996
; ---------------------------------------------------------------------------
; loc3_ABC8:
locK_B988:
		andi.w	#button_start_mask|button_A_mask|button_C_mask,d0
		beq.s	locK_B996
		move.b	#GameMode_CompetitionMenu,(Game_mode).w
		rts
; ---------------------------------------------------------------------------
; loc3_ABD6:
locK_B996:
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		bra.w	locK_B922
; ---------------------------------------------------------------------------

Obj_Competition_B9A6:
		move.l	#Map_CompetitionPlayerSprite,mappings(a0)
		move.w	#make_art_tile(ArtTile_Competition_CharSel,1,1),art_tile(a0)
		move.b	(P1_character).w,d0
		tst.b	$2E(a0)
		beq.s	locK_B9C2
		move.b	(P2_character).w,d0
; loc3_AC02:
locK_B9C2:
		move.b	d0,mapping_frame(a0)
		jmp	Obj_Competition_StaticSprite(pc)
; ---------------------------------------------------------------------------

Obj_Competition_B9CA:
		move.w	#make_art_tile(ArtTile_Competition_Results,1,1),art_tile(a0)
		move.b	(_unkEEA2).w,d0
		move.b	(_unkEEA2+1).w,d1
		tst.b	$2E(a0)
		beq.s	locK_B9E0
		exg	d0,d1
; loc3_AC20:
locK_B9E0:
		moveq	#$D,d2
		cmp.b	d0,d1
		beq.s	locK_B9EC
		bcs.s	locK_B9EA
		addq.w	#1,d2
; loc3_AC2A:
locK_B9EA:
		subq.b	#2,d2
; loc3_AC2C:
locK_B9EC:
		move.b	d2,mapping_frame(a0)
		cmpi.b	#$B,d2
		bne.w	Obj_Competition_StaticSprite
		btst	#3,(Level_frame_counter+1).w
		bne.w	Obj_Competition_StaticSprite
		rts

; =============== S U B R O U T I N E =======================================

; sub3_AC44:
subK_BA04:
		lea	($FF7800).l,a0
		move.w	#$C15A,d7
		jsr	subK_BAEE(pc)
		move.w	#$C7DA,d7
		jsr	subK_BAEE(pc)
		lea	($FF7800).l,a0
		jsr	subK_BB04(pc)
		move.w	#$C65A,d7
		move.l	d6,(_unkEE98).w
		move.w	d7,(_unkEEA0).w
		jsr	subK_B066(pc)
		jsr	subK_BB04(pc)
		move.w	#$CCDA,d7
		cmp.l	(_unkEE98).w,d6
		bhi.s	locK_BA52
		bne.s	locK_BA4A
		clr.w	(_unkEEA0).w
		bra.s	locK_BA52
; ---------------------------------------------------------------------------
; loc3_AC8A:
locK_BA4A:
		move.l	d6,(_unkEE98).w
		move.w	d7,(_unkEEA0).w
; loc3_AC92:
locK_BA52:
		jsr	subK_B066(pc)
		clr.w	(_unkEEA2).w
		lea	($FF7800).l,a0
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$148,VRAM,WRITE),d5
		moveq	#5-1,d7
; loc3_ACA8:
locK_BA68:
	if Sonic3_Alone
		lea	MapUnc_ResultsWin(pc),a1
		lea	MapUnc_ResultsLose(pc),a2
	else
		lea	(MapUnc_ResultsWin).l,a1
		lea	(MapUnc_ResultsLose).l,a2
	endif
		addq.b	#1,(_unkEEA2).w
		move.l	(a0)+,d0
		cmp.l	x_pos(a0),d0
		beq.s	locK_BA8E
		bcs.s	locK_BA9A
		exg	a1,a2
		subq.b	#1,(_unkEEA2).w
		addq.b	#1,(_unkEEA2+1).w
		bra.s	locK_BA9A
; ---------------------------------------------------------------------------
; loc3_ACCA:
locK_BA8E:
	if Sonic3_Alone
		lea	MapUnc_ResultsTie(pc),a1
	else
		lea	(MapUnc_ResultsTie).l,a1
	endif
		movea.l	a1,a2
		subq.b	#1,(_unkEEA2).w
; loc3_ACD4:
locK_BA9A:
		move.l	d5,d0
		moveq	#2-1,d1
		moveq	#2-1,d2
		jsr	(Plane_Map_To_VRAM).l
		movea.l	a2,a1
		move.l	d5,d0
		addi.l	#$680<<16,d0
		moveq	#2-1,d1
		moveq	#2-1,d2
		jsr	(Plane_Map_To_VRAM).l
		addi.l	#$100<<16,d5
		dbf	d7,locK_BA68
		move.w	(_unkEEA0).w,d7
		beq.s	locretK_BAEC
		move.l	(_unkEE98).w,d6
		jsr	subK_B066(pc)
		lea	(Plane_buffer).w,a0
		lea	$20(a0),a1
		moveq	#$10-1,d0
; loc3_AD16:
locK_BADC:
		move.w	(a0)+,d1
		andi.w	#$9FFF,d1
		ori.w	#palette_line_3,d1
		move.w	d1,(a1)+
		dbf	d0,locK_BADC
; locret3_AD26:
locretK_BAEC:
		rts
; End of function subK_BA04


; =============== S U B R O U T I N E =======================================

; sub3_AD28:
subK_BAEE:
		moveq	#5-1,d0
; loc3_AD2A:
locK_BAF0:
		move.w	d0,-(sp)
		move.l	(a0)+,d6
		jsr	subK_B066(pc)
		addi.w	#$100,d7
		move.w	(sp)+,d0
		dbf	d0,locK_BAF0
		rts
; End of function subK_BAEE


; =============== S U B R O U T I N E =======================================

; sub3_AD3E:
subK_BB04:
		clr.l	(_unkEF40_1).w
		moveq	#5-1,d7
; loc3_AD44:
locK_BB0A:
		move.l	(a0)+,d6
		lea	(_unkEF44_2).w,a1
		add.b	d6,-(a1)
		cmpi.b	#100,(a1)
		blo.s	locK_BB20
		subi.b	#100,(a1)
		addq.b	#1,-1(a1)
; loc3_AD5A:
locK_BB20:
		lsr.l	#8,d6
		add.b	d6,-(a1)
		cmpi.b	#60,(a1)
		blo.s	locK_BB32
		subi.b	#60,(a1)
		addq.b	#1,-1(a1)
; loc3_AD6C:
locK_BB32:
		lsr.l	#8,d6
		add.b	d6,-(a1)
		cmpi.b	#100,(a1)
		blo.s	locK_BB40
		move.b	#99,(a1)
; loc3_AD7A:
locK_BB40:
		dbf	d7,locK_BB0A
		move.l	(_unkEF40_1).w,d6
		rts
; End of function subK_BB04

; ---------------------------------------------------------------------------
	if Sonic3_Alone
Pal_CompetitionResults:
		binclude "General/Competition Menu/Palettes/Results.bin"
		even
	endif

ObjDat_BB4A:
		dc.w 8-1
		dc.l Obj_Competition_StaticSprite
		dc.w   $148,   $A1, palette_line_1
		dc.b    3,   0
		dc.l Obj_Competition_StaticSprite
		dc.w   $14D,   $B9, palette_line_0
		dc.b    0,   0
		dc.l Obj_Competition_B9A6
		dc.w   $14D,   $D3, palette_line_0
		dc.b    0,   0
		dc.l Obj_Competition_B9CA
		dc.w    $CC,   $BC, palette_line_0
		dc.b    0,   0
		dc.l Obj_Competition_StaticSprite
		dc.w   $14A,  $109, palette_line_1
		dc.b    4,   0
		dc.l Obj_Competition_StaticSprite
		dc.w   $14D,  $121, palette_line_0
		dc.b    0,   0
		dc.l Obj_Competition_B9A6
		dc.w   $14D,  $13B, palette_line_0
		dc.b    0,   1
		dc.l Obj_Competition_B9CA
		dc.w    $CC,  $124, palette_line_0
		dc.b    0,   1

VRAMDatList_BBAC:
		dc.w 9-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_B_Name_Table+$000,  40-1,  28-1
		dc.l RAM_start+$1000
		dc.w VRAM_Plane_A_Name_Table+$204,  15-1,   6-1
		dc.l RAM_start+$1000
		dc.w VRAM_Plane_A_Name_Table+$884,  15-1,   6-1
		dc.l MapUnc_CompetitionResultsLetters
		dc.w VRAM_Plane_A_Name_Table+$142,   2-1,  10-1
		dc.l MapUnc_CompetitionResultsLetters
		dc.w VRAM_Plane_A_Name_Table+$7C2,   2-1,  10-1
		dc.l MapUnc_CompetitionResultsDividers
		dc.w VRAM_Plane_A_Name_Table+$152,   4-1,  10-1
		dc.l MapUnc_CompetitionResultsDividers
		dc.w VRAM_Plane_A_Name_Table+$7D2,   4-1,  10-1
		dc.l MapUnc_CompetitionResultsTOTAL
		dc.w VRAM_Plane_A_Name_Table+$650,   5-1,   2-1
		dc.l MapUnc_CompetitionResultsTOTAL
		dc.w VRAM_Plane_A_Name_Table+$CD0,   5-1,   2-1

	if Sonic3_Alone
MapEni_CompetitionResultsLED:
		binclude "General/Competition Menu/Enigma Map/Menu.eni"
		even
MapUnc_CompetitionResultsLetters:
		binclude "General/Competition Menu/Uncompressed Map/Results Letters.bin"
		even
MapUnc_CompetitionResultsDividers:
		binclude "General/Competition Menu/Uncompressed Map/Results Dividers.bin"
		even
MapUnc_CompetitionResultsTOTAL:
		binclude "General/Competition Menu/Uncompressed Map/Results TOTAL.bin"
		even
MapUnc_ResultsWin:
		binclude "General/Competition Menu/Uncompressed Map/Results Win.bin"
		even
MapUnc_ResultsLose:
		binclude "General/Competition Menu/Uncompressed Map/Results Lose.bin"
		even
MapUnc_ResultsTie:
		binclude "General/Competition Menu/Uncompressed Map/Results Tie.bin"
		even
	endif
; ---------------------------------------------------------------------------

TimeAttack_Records:
		jsr	(Pal_FadeToBlack).l
		move	#$2700,sr
		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Clear_DisplayData).l
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$8700,(a6)
		move.w	#$8B00,(a6)
		move.w	#$8C89,(a6)
		move.w	#$9011,(a6)
	if Sonic3_Alone
		jsr	sub_B512(pc)
	else
		jsr	sub_C02A(pc)
	endif
		move.w	#VRAM_Plane_A_Name_Table+$1AA,d0
	if Sonic3_Alone
		jsr	sub_B534(pc)
	else
		jsr	sub_C04C(pc)
	endif
		clearRAM	Sprite_table_input,(Sprite_table_input_end-Sprite_table_input)
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		clr.w	(Level_frame_counter).w
		clr.w	(Competition_mode).w
		clr.b	(Level_started_flag).w
		move.w	#$1E,(Events_bg+$16).w
		move.w	#$FF78,(H_scroll_buffer).w
		lea	(MapEni_S3MenuBG).l,a0
		lea	(RAM_start).l,a1
		move.w	#make_art_tile(ArtTile_S3MenuBG,0,0),d0
		jsr	(Eni_Decomp).l
		lea	VRAMDatList_BF96(pc),a0
		jsr	Copy_Listed_Data_To_VRAM(pc)
		moveq	#0,d0
		move.b	(Current_zone).w,d0
		subi.w	#$E,d0
		lsl.w	#2,d0
		lea	CompTimeAttack_LevelNameMaps(pc),a1
		movea.l	(a1,d0.w),a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$826,VRAM,WRITE),d0
		moveq	#13-1,d1
		moveq	#2-1,d2
		jsr	(Plane_Map_To_VRAM).l
		jsr	subK_BEB2(pc)
		move.l	#vdpComm(tiles_to_bytes(ArtTile_Competition_Text),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_ContinueDigits).l,a0
		jsr	(Nem_Decomp).l
		move.l	#vdpComm(tiles_to_bytes(ArtTile_Competition_Text+$14),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_S38x16Font).l,a0
		jsr	(Nem_Decomp).l
		lea	(ArtKos_S3MenuBG).l,a0				; Decompress source
		lea	(RAM_start).l,a1				; Decompress destination/Transfer source
		movea.w	#tiles_to_bytes(ArtTile_S3MenuBG),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.l	#locretK_A85C,(_unkEF44_1).w
		move.b	#VInt_ID_1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(ArtKos_CompetitionLevel).l,a0				; Decompress source
		lea	(RAM_start).l,a1					; Decompress destination/Transfer source, used by the next two KosArt_To_VDP also
		movea.w	#tiles_to_bytes(ArtTile_Competition_LevSel),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		lea	(ArtKos_CompetitionResults).l,a0			; Decompress source
		movea.w	#tiles_to_bytes(ArtTile_Competition_Results),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		lea	(ArtKos_CompetitionPlayer).l,a0				; Decompress source
		movea.w	#tiles_to_bytes(ArtTile_Competition_CharSel),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.b	#VInt_ID_1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(ArtKos_SSResultsGeneral).l,a0
		lea	(RAM_start+$20).l,a1
		jsr	(Kos_Decomp).l
		lea	(ArtKos_SSResultsTKIcons).l,a0
		jsr	(Kos_Decomp).l
		move	#$2700,sr
		move.l	#vdpComm(tiles_to_bytes(ArtTile_Competition_STKIcons),VRAM,WRITE),(VDP_control_port).l
	if Sonic3_Alone
		lea	(RAM_start+$EE0).l,a0
	else
		lea	(RAM_start+$F60).l,a0
	endif
		lea	(VDP_data_port).l,a6
		move.w	#bytesToLcnt(tiles_to_bytes($1B)),d0
; loc3_B0C2:
locK_BDAA:
		move.l	(a0)+,(a6)
		dbf	d0,locK_BDAA
		lea	(Pal_CompetitionMenuBG).l,a0
		lea	(Target_palette).w,a1
		moveq	#bytesToLcnt(Target_palette_line_2-Target_palette),d0
; loc3_B0D4:
locK_BDBC:
		move.l	(a0)+,(a1)+
		dbf	d0,locK_BDBC
	if Sonic3_Alone
		lea	Pal_Competition2(pc),a0
	else
		lea	(Pal_Competition2).l,a0
	endif
		moveq	#bytesToLcnt(Target_palette_line_4-Target_palette_line_2),d0
; loc3_B0E0:
locK_BDCA:
		move.l	(a0)+,(a1)+
		dbf	d0,locK_BDCA
	if Sonic3_Alone
		lea	Pal_CompetitionTimeAttack(pc),a0
	else
		lea	(Pal_CompetitionTimeAttack).l,a0
	endif
		moveq	#bytesToLcnt(Target_palette_end-Target_palette_line_4),d0
; loc3_B0EC:
locK_BDD8:
		move.l	(a0)+,(a1)+
		dbf	d0,locK_BDD8
		lea	(Object_RAM).w,a0
		lea	ObjDat_BF58(pc),a1
		move.w	(a1)+,d0
; loc3_B0FC:
locK_BDE8:
		move.l	(a1)+,(a0)
		move.l	#Map_CompetitionSelect,mappings(a0)
		move.w	(a1),x_pos(a0)
		move.w	(a1)+,objoff_12(a0)
		move.w	(a1),y_pos(a0)
		move.w	(a1)+,objoff_16(a0)
		move.w	(a1)+,d1
		addi.w	#make_art_tile(ArtTile_Competition_LevSel,0,1),d1
		move.w	d1,art_tile(a0)
		move.b	(a1)+,mapping_frame(a0)
		move.b	(a1)+,$2E(a0)
		lea	next_object(a0),a0
		dbf	d0,locK_BDE8
		jsr	(Init_SpriteTable).l
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		moveq	#signextendB(mus_Continue),d0
		jsr	(Play_Music).l
		move.b	#VInt_ID_1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Pal_FadeFromBlack).l
; loc3_B16A:
locK_BE56:
		move.b	#VInt_ID_1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		addq.w	#1,(Level_frame_counter).w
		move.w	(_unkEEA0).w,d7
		beq.s	locK_BE86
		btst	#3,(Level_frame_counter+1).w
		bne.s	locK_BE7E
		lea	(Plane_buffer+$20).w,a1
		jsr	subK_B0A6(pc)
		bra.s	locK_BE86
; ---------------------------------------------------------------------------
; loc3_B192:
locK_BE7E:
		move.l	(_unkEE98).w,d6
		jsr	subK_B066(pc)
; loc3_B19A:
locK_BE86:
		tst.w	(Events_bg+$16).w
		beq.s	locK_BE92
		subq.w	#1,(Events_bg+$16).w
		bra.s	locK_BEA4
; ---------------------------------------------------------------------------
; loc3_B1A6:
locK_BE92:
		move.b	(Ctrl_1_pressed).w,d0
		andi.w	#button_start_mask|button_A_mask|button_C_mask,d0
		beq.s	locK_BEA4
		move.b	#GameMode_CompetitionLevelSelect+$80,(Game_mode).w
		rts
; ---------------------------------------------------------------------------
; loc3_B1B8:
locK_BEA4:
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		bra.s	locK_BE56

; =============== S U B R O U T I N E =======================================

; sub3_B1C6:
subK_BEB2:
		lea	($FF7828).l,a0
		move.w	#VRAM_Plane_A_Name_Table+$15A,d7
		moveq	#6-1,d0
		jsr	locK_BAF0(pc)
		moveq	#0,d0
		move.b	(Current_zone).w,d0
		subi.w	#$E,d0
		lsl.w	#4,d0
		lea	(Competition_saved_data).w,a0
		adda.w	d0,a0
		move.w	#VRAM_Plane_A_Name_Table+$95A,d7
		move.l	(a0)+,d6
		jsr	subK_B066(pc)
		addi.w	#$180,d7
		move.l	(a0)+,d6
		jsr	subK_B066(pc)
		addi.w	#$180,d7
		move.l	(a0)+,d6
		jsr	subK_B066(pc)
		clr.w	(_unkEEA0).w
		rts
; End of function subK_BEB2

; ---------------------------------------------------------------------------

Obj_Competition_BEF8:
		move.l	#Map_Results,mappings(a0)
	if Sonic3_Alone
		move.w	#make_art_tile(ArtTile_Competition_STKIcons-$77,1,1),art_tile(a0)
	else
		move.w	#make_art_tile(ArtTile_Competition_STKIcons+$263,0,1)|$1800,art_tile(a0)
	endif
		moveq	#0,d0
		move.b	(Current_zone).w,d0
		subi.w	#$E,d0
		lsl.w	#4,d0
		lea	(Competition_saved_data).w,a1
		lea	$C(a1,d0.w),a1
		moveq	#0,d0
		move.b	$2E(a0),d0
		move.b	(a1,d0.w),d0
		cmpi.w	#2,d0
		bne.s	locK_BF30
		addi.w	#palette_line_1,art_tile(a0)
; loc3_B244:
locK_BF30:
		addi.w	#$29,d0
		move.b	d0,mapping_frame(a0)
		move.l	#locK_BF3E,(a0)
; loc3_B252:
locK_BF3E:
		move.b	(Competition_time_attack_new_top_record).w,d0
		cmp.b	$2E(a0),d0
		bne.s	locK_BF50
		btst	#3,(Level_frame_counter+1).w
		beq.s	locretK_BF56
; loc3_B264:
locK_BF50:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; locret3_B26A:
locretK_BF56:
		rts
; ---------------------------------------------------------------------------
	if Sonic3_Alone
Pal_CompetitionTimeAttack:
		binclude "General/Competition Menu/Palettes/Time Attack.bin"
		even
	endif

ObjDat_BF58:
		dc.w 5-1
		dc.l Obj_Competition_StaticSprite
		dc.w   $14D,   $B9, palette_line_0
		dc.b    0,   0
		dc.l Obj_Competition_B9A6
		dc.w   $14D,   $CB, palette_line_0
		dc.b    0,   0
		dc.l Obj_Competition_BEF8
		dc.w   $130,  $120, palette_line_0
		dc.b    0,   0
		dc.l Obj_Competition_BEF8
		dc.w   $130,  $138, palette_line_0
		dc.b    0,   1
		dc.l Obj_Competition_BEF8
		dc.w   $130,  $150, palette_line_0
		dc.b    0,   2

VRAMDatList_BF96:
		dc.w 9-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_B_Name_Table+$000,  40-1,  28-1
		dc.l MapUnc_CompetitionLAPNum
		dc.w VRAM_Plane_A_Name_Table+$144,   5-1,  10-1
		dc.l MapUnc_CompetitionResultsDividers
		dc.w VRAM_Plane_A_Name_Table+$152,   4-1,  10-1
		dc.l MapUnc_CompetitionResultsTOTAL
		dc.w VRAM_Plane_A_Name_Table+$650,   5-1,   2-1
		dc.l MapUnc_CompetitionResultsDividers
		dc.w VRAM_Plane_A_Name_Table+$952,   4-1,   2-1
		dc.l MapUnc_CompetitionResultsDividers
		dc.w VRAM_Plane_A_Name_Table+$AD2,   4-1,   2-1
		dc.l MapUnc_CompetitionResultsDividers
		dc.w VRAM_Plane_A_Name_Table+$C52,   4-1,   2-1
		dc.l MapUnc_CompetitionRECORDS
		dc.w VRAM_Plane_A_Name_Table+$92C,   7-1,   2-1
		dc.l MapUnc_Competition1st2nd3rd
		dc.w VRAM_Plane_A_Name_Table+$944,   3-1,   8-1

	if Sonic3_Alone
MapUnc_CompetitionLAPNum:
		binclude "General/Competition Menu/Uncompressed Map/LAP.bin"
		even
MapUnc_CompetitionRECORDS:
		binclude "General/Competition Menu/Uncompressed Map/RECORDS.bin"
		even
MapUnc_Competition1st2nd3rd:
		binclude "General/Competition Menu/Uncompressed Map/1ST 2ND 3RD.bin"
		even
	endif

CompTimeAttack_LevelNameMaps:
		dc.l MapUnc_CompetitionAZURELAKE
		dc.l MapUnc_CompetitionBALLOONPARK
		dc.l MapUnc_CompetitionDESERTPALACE
		dc.l MapUnc_CompetitionCHROMEGADGET
		dc.l MapUnc_CompetitionENDLESSMINE

	if Sonic3_Alone
MapUnc_CompetitionAZURELAKE:
		binclude "General/Competition Menu/Uncompressed Map/AZURE LAKE.bin"
		even
MapUnc_CompetitionBALLOONPARK:
		binclude "General/Competition Menu/Uncompressed Map/BALLOON PARK.bin"
		even
MapUnc_CompetitionCHROMEGADGET:
		binclude "General/Competition Menu/Uncompressed Map/CHROME GADGET.bin"
		even
MapUnc_CompetitionDESERTPALACE:
		binclude "General/Competition Menu/Uncompressed Map/DESERT PALACE.bin"
		even
MapUnc_CompetitionENDLESSMINE:
		binclude "General/Competition Menu/Uncompressed Map/ENDLESS MINE.bin"
		even
	endif