; ---------------------------------------------------------------------------

AIZ1_ScreenInit:
	if ~~Sonic3_Alone
		jsr	Adjust_AIZ1Chunks(pc)
	endif
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

AIZ1_ScreenEvent:
		jsr	DrawTilesAsYouMove(pc)
		move.w	(Events_fg_4).w,d0
		beq.w	locretK_4F9BE
	if Sonic3_Alone
		cmpi.w	#$2D30,(Camera_X_pos_copy).w	; perform the tree tile manipulation routine when signaled.
	else
		cmpi.w	#$2D30,(Camera_X_pos).w		; perform the tree tile manipulation routine when signaled.
	endif
		bhs.w	AIZ1SE_ChangeChunk1
		cmpi.w	#$39,d0
		bhs.w	AIZ1SE_ChangeChunk1
		cmpi.w	#$34,d0
		blo.s	locK_4F93C
		bsr.w	AIZ1SE_ChangeChunk2
		bra.s	locK_4F952
; ---------------------------------------------------------------------------
; loc3_3AACC:
locK_4F93C:
		cmpi.w	#$24,d0
		blo.s	locK_4F948
		bsr.w	AIZ1SE_ChangeChunk3
		bra.s	locK_4F952
; ---------------------------------------------------------------------------
; loc3_3AAD8:
locK_4F948:
		cmpi.w	#$14,d0
		blo.s	locK_4F952
		bsr.w	AIZ1SE_ChangeChunk4
; loc3_3AAE2:
locK_4F952:
		lea_	AIZ_TreeRevealArray,a6
		btst	#0,d0
		bne.s	locK_4F962
		lea	$10(a6),a6
; loc3_3AAF0:
locK_4F962:
		subq.w	#1,d0
		lsr.w	#1,d0
		move.w	d0,(Events_bg+$00).w
		cmpi.w	#3,d0
		blo.s	locK_4F976
		move.w	#2,(Events_bg+$00).w
; loc3_3AB04:
locK_4F976:
		lsl.w	#4,d0
		neg.w	d0
		addi.w	#$470,d0
; loc3_3AB0C:
locK_4F97E:
		cmp.w	(Camera_Y_pos_rounded).w,d0
		bhs.s	locK_4F994
		lea	$20(a6),a6
		addi.w	#$10,d0
		subq.w	#1,(Events_bg+$00).w
		bpl.s	locK_4F97E
		bra.s	AIZ1SE_ChangeChunk1
; ---------------------------------------------------------------------------
; loc3_3AB22:
locK_4F994:
		move.w	#$2C80,d1
		moveq	#$10,d6
		move.l	a0,-(sp)
		jsr	Setup_TileRowDraw(pc)
		movea.l	(sp)+,a0
		subi.w	#$280,d0
		moveq	#0,d1
		moveq	#$F,d6
	if Sonic3_Alone
		bsr.s	AIZ_TreeReveal
	else
		jsr	(AIZ_TreeReveal).l
	endif
		lea	$10(a6),a6
		addi.w	#$290,d0
		subq.w	#1,(Events_bg+$00).w
		bpl.s	locK_4F97E
; locret3_3AB48:
locretK_4F9BE:
		rts
; ---------------------------------------------------------------------------

AIZ1SE_ChangeChunk1:
		clr.w	(Events_fg_4).w		; When this is run, all chunks have been changed and the routine need not be run anymore
		movea.w	$14(a3),a1
		movea.w	(a3),a5
		move.b	(a5),$59(a1)
		move.b	1(a5),$5A(a1)

; =============== S U B R O U T I N E =======================================


AIZ1SE_ChangeChunk2:
		movea.w	$18(a3),a1
		movea.w	4(a3),a5
		move.b	(a5),$59(a1)
		move.b	1(a5),$5A(a1)
; End of function AIZ1SE_ChangeChunk2


; =============== S U B R O U T I N E =======================================


AIZ1SE_ChangeChunk3:
		movea.w	$1C(a3),a1
		movea.w	8(a3),a5
		move.b	(a5),$59(a1)
		move.b	1(a5),$5A(a1)
; End of function AIZ1SE_ChangeChunk3


; =============== S U B R O U T I N E =======================================


AIZ1SE_ChangeChunk4:
		movea.w	$20(a3),a1
		movea.w	$C(a3),a5
		move.b	(a5),$59(a1)
		move.b	1(a5),$5A(a1)
		rts
; End of function AIZ1SE_ChangeChunk4


; =============== S U B R O U T I N E =======================================

	if Sonic3_Alone
AIZ_TreeReveal:
		asr.w	#4,d1
		move.w	d1,d2
		asr.w	#3,d1
		add.w	d2,d2
		andi.w	#$E,d2
		addq.w	#4,a0
		movea.l	a0,a1
		lea	$40(a0),a0
		jsr	Get_LevelAddrChunkRow(pc)

loc3_3ABAE:
		move.w	(a5,d2.w),d3
		move.w	d3,d4
		andi.w	#$3FF,d3
		lsl.w	#3,d3
		move.l	(a2,d3.w),d5
		move.l	4(a2,d3.w),d3
		btst	#$B,d4
		beq.s	loc3_3ABD6
		eori.l	#$10001000,d5
		eori.l	#$10001000,d3
		exg	d3,d5

loc3_3ABD6:
		btst	#$A,d4
		beq.s	loc3_3ABEC
		eori.l	#$8000800,d5
		eori.l	#$8000800,d3
		swap	d5
		swap	d3

loc3_3ABEC:
		tst.b	(a6)+
		beq.s	loc3_3ABF2
		move.l	d5,(a1)

loc3_3ABF2:
		addq.w	#4,a1
		tst.b	$F(a6)
		beq.s	loc3_3ABFC
		move.l	d3,(a0)

loc3_3ABFC:
		addq.w	#4,a0
		addq.w	#2,d2
		andi.w	#$E,d2
		bne.s	loc3_3AC0C
		addq.w	#1,d1
		jsr	Get_ChunkRow(pc)

loc3_3AC0C:
		dbf	d6,loc3_3ABAE
		clr.w	(a0)
		rts
; End of function AIZ_TreeReveal
	endif

; ---------------------------------------------------------------------------

Obj_AIZ1TreeRevealControl:
		tst.w	$2E(a0)
		beq.s	locK_4FA1E
		tst.w	(Events_fg_4).w
		bne.s	locK_4FA1E
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
; loc3_3AC26:
locK_4FA1E:
		subq.w	#1,$2E(a0)
		move.w	#$480,d0
		sub.w	(Player_1+y_pos).w,d0
		lsr.w	#3,d0
		addq.w	#3,d0
		cmp.w	(Events_fg_4).w,d0
		bhs.s	locK_4FA3C
		btst	#0,$2F(a0)
		beq.s	locretK_4FA40
; loc3_3AC44:
locK_4FA3C:
		addq.w	#1,(Events_fg_4).w
; locret3_3AC48:
locretK_4FA40:
		rts

	if Sonic3_Alone
; ---------------------------------------------------------------------------
AIZ_TreeRevealArray:
		dc.b    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
		dc.b    0,   0,   0,   0,   0,   1,   1,   1,   1,   1,   1,   0,   0,   0,   0,   0
		dc.b    0,   0,   0,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   0,   0,   0
		dc.b    0,   0,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   0,   0
		dc.b    0,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   0
		dc.b    1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1
		dc.b    1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1
		even
	else
; =============== S U B R O U T I N E =======================================


Adjust_AIZ1Chunks:
		cmpi.w	#3,(Player_mode).w
		beq.s	Adjust_AIZ1Chunks2			; Make changes to AIZ's chunk data if playing as Knuckles
		rts
; End of function Adjust_AIZ1Chunks


; =============== S U B R O U T I N E =======================================


Adjust_AIZ1Chunks2:
		lea	(Target_palette_line_4+$10).w,a1
		lea	wordK_4FAE4(pc),a5
		move.l	(a5)+,(a1)+
		move.l	(a5),(a1)
		lea	($FF4C70).l,a1
		bsr.s	subK_4FAD8
		lea	($FF4CF0).l,a1
		bsr.s	subK_4FAD8
		lea	($FF4D70).l,a1
		bsr.s	subK_4FAD8
		lea	($FF52F0).l,a1
		bsr.s	subK_4FAD8
		lea	($FF4980).l,a1
		bsr.s	subK_4FAD8
		lea	($FF4D80).l,a1
		bsr.s	subK_4FAD8
		lea	($FF3420).l,a1
		bsr.s	subK_4FAD8
		move.w	#$402,(a1)+
		moveq	#6-1,d1
		bsr.s	subK_4FADA
		move.w	#2,(a1)
		lea	($FF3FA0).l,a1
		bsr.s	subK_4FAD8
		addq.w	#4,a1
		move.w	#$C,(a1)+
		move.w	#$406,(a1)+
		move.w	#$4B,(a1)+
		move.w	#$4B,(a1)+
		move.w	#$40A,2(a1)
		lea	($FF5820).l,a1
		move.w	#$40B,(a1)+
		moveq	#6-1,d1
		bsr.s	subK_4FADA
		addq.w	#6,a1
		move.w	#$C,(a1)+
		move.w	#$406,(a1)+
		moveq	#2-1,d1
		bra.s	subK_4FADA
; End of function Adjust_AIZ1Chunks2


; =============== S U B R O U T I N E =======================================


subK_4FAD8:
		moveq	#8-1,d1
; End of function subK_4FAD8


; =============== S U B R O U T I N E =======================================


subK_4FADA:
		moveq	#$4B,d0

locK_4FADC:
		move.w	d0,(a1)+
		dbf	d1,locK_4FADC
		rts
; End of function subK_4FADA

; ---------------------------------------------------------------------------
wordK_4FAE4:
		dc.w   $EE4,  $EA6,  $E62
wordK_4FAEA:
		dc.w   $E40
	endif
; ---------------------------------------------------------------------------

AIZ1_BackgroundInit:
	if Sonic3_Alone
		cmpi.w	#$1300,(Camera_X_pos_copy).w
	else
		cmpi.w	#$1300,(Camera_X_pos).w
	endif
		bhs.s	locK_4FB1C
		lea	(HScroll_table).w,a1			; Intro deformation
		moveq	#bytesToLcnt($28),d0
; loc3_3ACC8:
locK_4FAFA:
		clr.l	(a1)+
		dbf	d0,locK_4FAFA
		jsr_	AIZ1_IntroDeform
		jsr	Reset_TileOffsetPositionEff(pc)
		jsr	Refresh_PlaneFull(pc)
		lea_	AIZ1_IntroDeformArray,a4
		lea	(HScroll_table+$028).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------
; loc3_3ACE6:
locK_4FB1C:
		move.w	#8,(Events_routine_bg).w			; If not in the intro
		jsr_	AIZ1_Deform
		jsr	Reset_TileOffsetPositionEff(pc)
		clr.l	(HScroll_table).w
		move.w	d2,(HScroll_table+$006).w
		lea_	AIZ1_BGDrawArray,a4
		lea	(HScroll_table).w,a5
		jsr	Refresh_PlaneTileDeform(pc)
		jmp_	AIZ1_ApplyDeformWater
; ---------------------------------------------------------------------------

AIZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	AIZ1_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

AIZ1_BackgroundEvent_Index:
		bra.w	AIZ1BGE_Intro
; ---------------------------------------------------------------------------
		bra.w	AIZ1BGE_NormalRefresh
; ---------------------------------------------------------------------------
		bra.w	AIZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	AIZ1BGE_FireTransition
; ---------------------------------------------------------------------------
		bra.w	AIZ1BGE_FireRefresh
; ---------------------------------------------------------------------------
		bra.w	AIZ1BGE_Finish
; ---------------------------------------------------------------------------

AIZ1BGE_Intro:
		tst.w	(Events_fg_5).w
		beq.s	locK_4FBA4
		tst.w	(Kos_decomp_queue_count).w
		bne.w	locK_4FBA4
		clr.w	(Events_fg_5).w
		jsr_	AIZ1_Deform							; Set up normal deformation when intro is over
		jsr	Reset_TileOffsetPositionEff(pc)
		clr.l	(HScroll_table).w
		move.w	d2,(HScroll_table+$006).w
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w				; Next routine
		bra.s	locK_4FBD0
; ---------------------------------------------------------------------------
; loc3_3AD66:
locK_4FBA4:
		jsr_	AIZ1_IntroDeform
		lea_	AIZ1_IntroDrawArray,a4
		lea	(HScroll_table).w,a5
		moveq	#$20,d6
		moveq	#$A,d5
		jsr	Draw_BG(pc)
		lea_	AIZ1_IntroDeformArray,a4
		lea	(HScroll_table+$028).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

AIZ1BGE_NormalRefresh:
		jsr_	AIZ1_Deform
; loc3_3AD8A:
locK_4FBD0:
		lea_	AIZ1_BGDrawArray,a4
		lea	(HScroll_table-$04).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d1
		jsr	Draw_PlaneVertBottomUpComplex(pc)
		bpl.s	locK_4FBF6
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_4FBF6
; ---------------------------------------------------------------------------

AIZ1BGE_Normal:
		tst.w	(Events_fg_5).w
		bne.s	AIZ1_AIZ2_Transition		; Wait for signal to start level transition
		jsr_	AIZ1_Deform
; loc3_3ADAC:
locK_4FBF6:
		lea_	AIZ1_BGDrawArray,a4
		lea	(HScroll_table).w,a5
		moveq	#$20,d6
		moveq	#2,d5
		jsr	Draw_BG(pc)
		jmp_	AIZ1_ApplyDeformWater
; ---------------------------------------------------------------------------

AIZ1_AIZ2_Transition:
		clr.w	(Events_fg_5).w
		lea	(Normal_palette_line_4+$2).w,a1
		move.l	#$4E006E,(a1)+
		move.l	#$AE00CE,(a1)+
		move.l	#$2EE0AEE,(a1)
		move.l	#$200000,(Camera_Y_pos_BG_copy).w
		move.w	#$10,(Camera_Y_pos_BG_rounded).w
		move.w	#$68,(Events_bg+$00).w
		move.w	#4,(Special_V_int_routine).w
		addq.w	#4,(Events_routine_bg).w

AIZ1BGE_FireTransition:
		tst.w	(Events_bg+$02).w
		bne.s	locK_4FC6E
	if ~~Sonic3_Alone
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	locK_4FC74
	endif
		move.w	(Events_bg+$00).w,d0
		swap	d0
		clr.w	d0
		sub.l	(Camera_Y_pos_BG_copy).w,d0
		asr.l	#5,d0
		add.l	d0,(Camera_Y_pos_BG_copy).w
		cmpi.l	#$1400,d0
		bhs.s	locK_4FC74
; loc3_3AE18:
locK_4FC6E:
		jsr_	AIZ1_FireRise
; loc3_3AE1C:
locK_4FC74:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	#$1000,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		cmpi.w	#$190,(Camera_Y_pos_BG_copy).w
		blo.w	locK_4FD22
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(AIZ2_128x128_Kos).l,a1
		lea	(RAM_start).l,a2
		jsr	(Queue_Kos).l
		lea	(AIZ2_16x16_Primary_Kos).l,a1
		lea	(Block_table).w,a2
		jsr	(Queue_Kos).l
		lea	(AIZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$AB8).w,a2
		jsr	(Queue_Kos).l
		lea	(AIZ2_8x8_Primary_KosM).l,a1
		move.w	#tiles_to_bytes($000),d2
		jsr	(Queue_Kos_Module).l
		lea	(AIZ2_8x8_Secondary_KosM).l,a1
		move.w	#tiles_to_bytes($1FC),d2
		jsr	(Queue_Kos_Module).l
		lea	(PLC_SpikesSprings).l,a1
		jsr	(Load_PLC_Raw).l
		movem.l	(sp)+,d7-a0/a2-a3
		jsr	(AllocateObject).l
		bne.s	locK_4FD10
		move.l	#Obj_AIZTransitionFloor,(a1)
		move.w	#$2FB0,x_pos(a1)
		move.w	#$3A0,y_pos(a1)
; loc3_3AEB8:
locK_4FD10:
		move.w	#$F0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_4FD32
; ---------------------------------------------------------------------------
; loc3_3AECA:
locK_4FD22:
		jsr_	AIZTrans_WavyFlame
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

AIZ1BGE_FireRefresh:
		jsr_	AIZ1_FireRise
; loc3_3AED6:
locK_4FD32:
		lea	(Level_layout_main).w,a3
		move.w	#VRAM_Plane_A_Name_Table,d7
		move.w	#$180,d1
		moveq	#0,d2
		jsr	Draw_PlaneVertBottomUp(pc)	; Refresh main plane
		bpl.s	locK_4FD52
		addq.w	#2,a3
		move.w	#VRAM_Plane_B_Name_Table,d7
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_4FD62
; ---------------------------------------------------------------------------
; loc3_3AEF6:
locK_4FD52:
		jsr_	AIZTrans_WavyFlame
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

AIZ1BGE_Finish:
		jsr_	AIZ1_FireRise
; loc3_3AF02:
locK_4FD62:
		tst.b	(Kos_modules_left).w
		bne.w	locK_4FE2E		; Wait for the art to be loaded
		move.w	#1,(Current_zone_and_act).w	; Officially change this to act 2
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(Respawn_table_keep).w
		jsr	Clear_Switches(pc)
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		jsr	(CheckLevelForWater).l
		moveq	#PalID_AIZFire,d0
		jsr	(LoadPalette_Immediate).l
		movem.l	(sp)+,d7-a0/a2-a3
	if ~~Sonic3_Alone
		jsr	Adjust_AIZ2Layout(pc)
	endif
		lea	(Normal_palette_line_4+$2).w,a1
		move.l	#$4E006E,(a1)+
		move.l	#$AE00CE,(a1)+
		move.l	#$2EE0AEE,(a1)
		move.w	#$2F00,d0
		move.w	#$80,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d1,(Player_1+y_pos).w
		sub.w	d0,(Player_2+x_pos).w
		sub.w	d1,(Player_2+y_pos).w
	if ~~Sonic3_Alone
		jsr	Offset_SomeObjectsDuringTransition(pc)
	endif
		sub.w	d0,(Camera_X_pos).w
		sub.w	d1,(Camera_Y_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d1,(Camera_Y_pos_copy).w		; Offset objects and camera positions
		move.l	#$100010,d0
	if Sonic3_Alone
		move.l	#$260,d1
		move.l	d0,(Camera_min_X_pos).w
		move.l	d0,(Camera_target_min_X_pos).w
		move.l	d1,(Camera_min_Y_pos).w
		move.l	d1,(Camera_target_min_Y_pos).w
	else
		move.l	d0,(Camera_min_X_pos).w
		move.l	#$260,d0
		move.l	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
	endif
		move.w	(Camera_X_pos_copy).w,(Events_fg_0).w
		move.w	(Camera_X_pos_copy).w,(Events_fg_1).w
		jsr	Reset_TileOffsetPositionActual(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		clr.w	(Events_routine_bg).w
; loc3_3AFCA:
locK_4FE2E:
		jsr_	AIZTrans_WavyFlame
		jmp	PlainDeformation(pc)

	if Sonic3_Alone
; =============== S U B R O U T I N E =======================================


AIZ1_IntroDeform:
		move.w	(Camera_Y_pos_copy).w,(Camera_Y_pos_BG_copy).w
		move.w	(Events_fg_1).w,d0
		bmi.s	loc3_3AFE2
		move.w	(Camera_X_pos_copy).w,d0

loc3_3AFE2:
		asr.w	#1,d0
		lea	(HScroll_table+$028).w,a1
		cmpi.w	#$580,d0
		blt.s	loc3_3AFF8
		moveq	#$25-1,d1

loc3_3AFF0:
		move.w	d0,(a1)+
		dbf	d1,loc3_3AFF0
		bra.s	loc3_3B018
; ---------------------------------------------------------------------------

loc3_3AFF8:
		move.w	d0,(a1)+
		subi.w	#$580,d0
		swap	d0
		clr.w	d0
		move.l	d0,d1
		asr.l	#5,d1
		moveq	#$24-1,d2

loc3_3B008:
		add.l	d1,d0
		move.l	d0,d3
		swap	d3
		addi.w	#$580,d3
		move.w	d3,(a1)+
		dbf	d2,loc3_3B008

loc3_3B018:
		lea	(HScroll_table+$028).w,a1
		lea	(HScroll_table).w,a5
		move.w	(a1)+,d0
		bpl.s	loc3_3B026
		moveq	#0,d0

loc3_3B026:
		move.w	d0,(a5)
		addq.w	#4,a5
		moveq	#9-1,d0

loc3_3B02C:
		move.w	(a1),d1
		bpl.s	loc3_3B032
		moveq	#0,d1

loc3_3B032:
		move.w	d1,(a5)
		addq.w	#8,a1
		addq.w	#4,a5
		dbf	d0,loc3_3B02C
		rts
; End of function AIZ1_IntroDeform


; =============== S U B R O U T I N E =======================================


AIZ1_Deform:
		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$1300,d0
		swap	d0
		clr.w	d0
		asr.l	#5,d0
		move.l	d0,d2
		add.l	d0,d0
		move.l	d0,d1
		lsl.l	#3,d0
		sub.l	d1,d0
		lea	(HScroll_table+$030).w,a1
		swap	d0
		move.w	d0,(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,-$2C(a1)
		move.w	d0,2(a1)
		move.w	d0,$A(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,4(a1)
		move.w	d0,8(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,6(a1)
		lea	(HScroll_table+$016).w,a1
		move.l	d2,d0
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		move.l	(HScroll_table+$03C).w,d3
		addi.l	#$2000,(HScroll_table+$03C).w
		asr.l	#1,d0
		moveq	#5,d1

loc3_3B0AE:
		add.l	d3,d0
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		add.l	d2,d0
		dbf	d1,loc3_3B0AE
		lea	(HScroll_table+$016).w,a1
		move.l	d2,d0
		asr.l	#3,d2
		moveq	#$C,d1

loc3_3B0C6:
		add.l	d2,d0
		swap	d0
		move.w	d0,(a1)+
		swap	d0
		dbf	d1,loc3_3B0C6
		rts
; End of function AIZ1_Deform

; ---------------------------------------------------------------------------

AIZ1_ApplyDeformWater:
		lea	AIZ1_DeformArray(pc),a4
		lea	(HScroll_table+$008).w,a5
		move.w	(Water_level).w,d1
		sub.w	(Camera_Y_pos_copy).w,d1
		cmpi.w	#$E0,d1
		blt.s	loc3_3B0EE
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

loc3_3B0EE:
		subq.w	#1,d1
		jsr	ApplyDeformation3(pc)
		move.l	a1,-(sp)
		lea	(HScroll_table+$040).w,a1
		lea	AIZ1_WaterFGDeformDelta(pc),a6
		move.w	(Water_level).w,d0
		subi.w	#$DE,d1
		neg.w	d1
		move.w	(Level_frame_counter).w,d2
		add.w	d0,d2
		add.w	d0,d2
		andi.w	#$7E,d2
		adda.w	d2,a6
		move.w	(Camera_X_pos_copy).w,d6
		neg.w	d6
		jsr	MakeFGDeformArray(pc)
		movea.l	(sp)+,a1
		lea	(HScroll_table+$040).w,a2
		lea	AIZ1_DeformArray(pc),a4
		lea	(HScroll_table+$008).w,a5
		lea	AIZ1_WaterBGDeformDelta(pc),a6
		move.w	(Water_level).w,d0
		sub.w	(Camera_Y_pos_copy).w,d0
		add.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	(Level_frame_counter).w,d2
		asr.w	#1,d2
		add.w	d0,d2
		add.w	d0,d2
		andi.w	#$7E,d2
		adda.w	d2,a6
		jmp	ApplyFGandBGDeformation(pc)

; =============== S U B R O U T I N E =======================================


AIZ1_FireRise:
		cmpi.b	#6,(Player_1+routine).w
		bcc.s	locret3_3B178
		moveq	#0,d0
		move.w	(Events_bg+$02).w,d0
		addi.w	#$280,d0
		cmpi.w	#$A000,d0
		bcs.s	loc3_3B16E
		move.w	#$A000,d0

loc3_3B16E:
		move.w	d0,(Events_bg+$02).w
		lsl.l	#4,d0
		add.l	d0,(Camera_Y_pos_BG_copy).w

locret3_3B178:
		rts
; End of function AIZ1_FireRise


; =============== S U B R O U T I N E =======================================


AIZTrans_WavyFlame:
		cmpi.b	#6,(Player_1+routine).w
		bcc.s	locret3_3B1C4
		addq.w	#6,(_unkEE8E).w
		move.w	(_unkEE8E).w,d0
		andi.w	#$60,d0
		addi.w	#$1000,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		lea	(Vscroll_buffer).w,a1
		lea	AIZ_FlameVScroll(pc),a5
		move.w	(Camera_Y_pos_copy).w,d0
		swap	d0
		move.w	(Camera_Y_pos_BG_copy).w,d1
		move.w	(Level_frame_counter).w,d2
		asr.w	#2,d2
		moveq	#$14-1,d3

loc3_3B1B0:
		addq.w	#2,d2
		andi.w	#$F,d2
		move.b	(a5,d2.w),d0
		ext.w	d0
		add.w	d1,d0
		move.l	d0,(a1)+
		dbf	d3,loc3_3B1B0

locret3_3B1C4:
		rts
; End of function AIZTrans_WavyFlame
	endif

; ---------------------------------------------------------------------------

Obj_AIZTransitionFloor:
		tst.b	(Current_act).w
		beq.s	locK_4FE4A
	if Sonic3_Alone
		move.w	#$7F00,x_pos(a0)
	else
		move.w	#$7FFF,x_pos(a0)
	endif
		move.l	#Delete_Current_Sprite,(a0)
; loc3_3B1D8:
locK_4FE4A:
	if Sonic3_Alone
		move.b	#$A0,width_pixels(a0)
		bset	#7,status(a0)
		move.w	#$A0+$B,d1
		moveq	#$10,d2
		moveq	#$10,d3
		move.w	x_pos(a0),d4
		jmp	(SolidObjectFull2).l
; ---------------------------------------------------------------------------
AIZ1_IntroDrawArray:
		dc.w   $3E0,    $10,    $10,    $10,    $10,    $10,    $10,    $10,    $10, $7FFF
AIZ1_IntroDeformArray:
		dc.w   $3E0,     4,     4,     4,     4,     4,     4,     4,     4
		dc.w      4,     4,     4,     4,     4,     4,     4,     4,     4
		dc.w      4,     4,     4,     4,     4,     4,     4,     4,     4
		dc.w      4,     4,     4,     4,     4,     4,     4,     4,     4, $7FFF
AIZ1_BGDrawArray:
		dc.w   $220, $7FFF
AIZ1_DeformArray:
		dc.w    $D0,   $20,   $30,   $30,   $10,   $10,   $10, $800D,    $F,     6,    $E,   $50,   $20, $7FFF
AIZ_FlameVScroll:
		dc.b    0,  -1,  -2,  -5,  -8, -$A, -$D, -$E, -$F, -$E, -$D, -$A,  -7,  -5,  -2,  -1
		even
	else
		move.b	#$10,height_pixels(a0)
		bset	#7,status(a0)
		move.w	#$A0,d1
		moveq	#$10,d2
		moveq	#$10,d3
		move.w	x_pos(a0),d4
		jmp	(SolidObjectTop).l

; =============== S U B R O U T I N E =======================================


Adjust_AIZ2Layout:
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_4FECC
		move.w	#$5B,($FF1020).l		; Only do this if playing as Knuckles
		lea	($FF3420).l,a1
		moveq	#8-1,d1
		bsr.s	subK_4FF00
		move.w	#$CAE,(a1)+
		moveq	#6-1,d1
		bsr.s	subK_4FF00
		move.w	#$8AE,(a1)
		lea	($FF3FA0).l,a1
		moveq	#8-1,d1
		bsr.s	subK_4FF00
		addq.w	#4,a1
		move.w	#$4B6,(a1)+
		move.w	#$4CC,(a1)+
		move.w	#$5B,(a1)+
		move.w	#$5B,(a1)+
		move.w	#$4B7,2(a1)
		lea	($FF5822).l,a1
		moveq	#6-1,d1
		bsr.s	subK_4FF00
		addq.w	#6,a1
		move.w	#$4B6,(a1)+
		move.w	#$4CC,(a1)+
		move.w	#$5B,(a1)+
		move.w	#$5B,(a1)

locK_4FECC:
		movea.w	(Level_layout_main+$0C).w,a1
		movea.w	(Level_layout_main+$40).w,a5
		move.b	$7F(a1),$63(a5)
		movea.w	(Level_layout_main+$0A).w,a1
		movea.w	(Level_layout_main+$1E).w,a5
		bsr.s	subK_4FEF6
		movea.w	(Level_layout_main+$0E).w,a1
		movea.w	(Level_layout_main+$22).w,a5
		bsr.s	subK_4FEF6
		movea.w	(Level_layout_main+$12).w,a1
		movea.w	(Level_layout_main+$26).w,a5
; End of function Adjust_AIZ2Layout


; =============== S U B R O U T I N E =======================================


subK_4FEF6:
		moveq	#4-1,d0

.loop:
		move.b	(a1)+,(a5)+
		dbf	d0,.loop
		rts
; End of function subK_4FEF6


; =============== S U B R O U T I N E =======================================


subK_4FF00:
		moveq	#$5B,d0

.loop:
		move.w	d0,(a1)+
		dbf	d1,.loop
		rts
; End of function subK_4FF00
	endif

; ---------------------------------------------------------------------------

AIZ2_ScreenInit:
	if ~~Sonic3_Alone
		jsr	Adjust_AIZ2Layout(pc)
	endif
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

AIZ2_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	(Events_routine_fg).w,d0
		jmp	AIZ2_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

AIZ2_ScreenEvent_Index:
		bra.w	AIZ2SE_Normal
; ---------------------------------------------------------------------------
		bra.w	AIZ2SE_ShipRefresh
; ---------------------------------------------------------------------------
		bra.w	AIZ2SE_ShipDraw
; ---------------------------------------------------------------------------
		bra.w	AIZ2SE_EndRefresh
; ---------------------------------------------------------------------------
		bra.w	AIZ2SE_End
; ---------------------------------------------------------------------------

AIZ2SE_Normal:
		tst.w	(Events_fg_4).w
		beq.w	DrawTilesAsYouMove		; Keep drawing as usual while flag isn't set
		clr.w	(Events_fg_4).w
		move.w	#$180,(Draw_delayed_position).w		; Set up redraw memory
		move.w	#5,(Draw_delayed_rowcount).w
		clr.l	(HScroll_table+$1F8).w
		move.w	(Camera_X_pos_copy).w,d0
		andi.w	#$FFF0,d0
		subi.w	#$10,d0
		move.w	d0,(HScroll_table+$1FE).w
	if Sonic3_Alone
		move.b	#1,(Scroll_lock).w			; Camera doesn't follow Sonic
	else
		st	(Scroll_lock).w				; Camera doesn't follow Sonic
	endif
		move.w	#4,(Special_events_routine).w
		addq.w	#4,(Events_routine_fg).w		; Set speed of automatic movement

AIZ2SE_ShipRefresh:
		move.w	#$4380,d1
		move.w	(Camera_Y_pos_copy).w,d2
		subi.w	#$10,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.w	locK_4FFF0
		move.w	#$4020,d0
		move.w	d0,(HScroll_table+$1F6).w
		move.w	d0,(_unkEE98).w
		clr.w	(_unkEE98+2).w			; Set up secondary BG camera X
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$8F0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(_unkEE9C).w
		move.w	d0,(_unkEEA2).w		; Set up secondary BG camera Y
		jsr	(AllocateObject).l
		bne.s	locK_4FFBA
		move.l	#Obj_AIZBattleship,(a1)	; Start battleship sequence
; loc3_3B332:
locK_4FFBA:
		st	(Events_bg+$04).w
		move.l	#HInt7,(H_int_addr).w	; HInt is needed to change Y scroll value to proper amount mid-draw
		clr.b	(Water_flag).w
		move.b	#$40,(H_int_counter).w		; Set HInt position
		addq.w	#4,(Events_routine_fg).w

AIZ2SE_ShipDraw:
		tst.w	(Events_fg_4).w
		bne.s	locK_50008				; Branch when battleship has gone off-screen
		lea	AIZ2SE_BGShipDrawArray2(pc),a4
		lea	(HScroll_table+$1F4).w,a6
		move.w	(_unkEE98).w,(a6)
		moveq	#2,d5
		move.w	(_unkEEA2).w,d6
		jsr	Draw_BGNoVert(pc)
; loc3_3B368:
locK_4FFF0:
		lea	AIZ2SE_BGShipDrawArray1(pc),a4
		lea	(HScroll_table+$1F8).w,a6
		move.w	(Camera_X_pos_copy).w,4(a6)
		moveq	#2,d5
		move.w	(Camera_Y_pos_rounded).w,d6
		jmp	Draw_BGNoVert(pc)
; ---------------------------------------------------------------------------
; loc3_3B380:
locK_50008:
		clr.w	(Events_fg_4).w
		move.w	#$170,(Draw_delayed_position).w
		move.w	#4,(Draw_delayed_rowcount).w		;Set redraw memory
		addq.w	#4,(Events_routine_fg).w

AIZ2SE_EndRefresh:
		move.w	#$4380,d1
		move.w	(Camera_Y_pos_copy).w,d2
		subi.w	#$10,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	locK_4FFF0
		move.w	(Camera_X_pos_copy).w,d0
		andi.w	#$FFF0,d0
		subi.w	#$10,d0
		move.w	d0,(Camera_X_pos_rounded).w
		move.w	#$46C0,(Events_bg+$02).w		; Set level X start to 46C0
		clr.w	(Events_bg+$04).w
		move.b	#-1,(H_int_counter).w
		addq.w	#4,(Events_routine_fg).w

AIZ2SE_End:
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

HInt7:
		move.w	#$8AFF,(VDP_control_port).l
		move.l	#vdpComm($0000,VSRAM,WRITE),(VDP_control_port).l
		move.w	(Camera_Y_pos_copy).w,(VDP_data_port).l
		rte
; ---------------------------------------------------------------------------
AIZ2SE_BGShipDrawArray1:
		dc.w   $180
		dc.w  $7FFF
AIZ2SE_BGShipDrawArray2:
		dc.w   $A80
		dc.w  $7FFF
; ---------------------------------------------------------------------------

AIZ2_BackgroundInit:
		move.w	(Camera_X_pos_copy).w,(Events_fg_0).w
		move.w	(Camera_X_pos_copy).w,(Events_fg_1).w
		move.w	#$C,(Events_routine_bg).w
	if Sonic3_Alone
		cmpi.w	#$3E80,(Camera_X_pos_copy).w
	else
		cmpi.w	#$3E80,(Camera_X_pos).w
	endif
		blo.s	locK_500A0
		move.w	#$14,(Events_routine_bg).w
		move.w	#$4440,(Events_bg+$02).w
; loc3_3B418:
locK_500A0:
		jsr_	AIZ2_Deform
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		jmp_	AIZ2_ApplyDeform
; ---------------------------------------------------------------------------

AIZ2_BackgroundEvent:
		lea	(Events_fg_0).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		move.w	#$100,d2
		move.w	#$200,d3
		jsr	Adjust_BGDuringLoop(pc)
		move.w	(Events_routine_bg).w,d0
		jmp	AIZ2_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

AIZ2_BackgroundEvent_Index:
		bra.w	AIZ2BGE_FireRedraw
; ---------------------------------------------------------------------------
		bra.w	AIZ2BGE_WaitFire
; ---------------------------------------------------------------------------
		bra.w	AIZ2BGE_BGRedraw
; ---------------------------------------------------------------------------
		bra.w	AIZ2BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	AIZ2BGE_ShipRefresh
; ---------------------------------------------------------------------------
		bra.w	AIZ2BGE_ShipMove
; ---------------------------------------------------------------------------

AIZ2BGE_FireRedraw:
		lea	(Level_layout_main).w,a3
		move.w	#VRAM_Plane_A_Name_Table,d7
		move.w	(Camera_X_pos_copy).w,d1
		move.w	(Camera_Y_pos_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bmi.s	locK_50110
		jsr_	AIZ1_FireRise
		jsr_	AIZTrans_WavyFlame
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------
; loc3_3B480:
locK_50110:
		addq.w	#2,a3
		move.w	#VRAM_Plane_B_Name_Table,d7
		clr.w	(Events_bg+$00).w
		addq.w	#4,(Events_routine_bg).w

AIZ2BGE_WaitFire:
		jsr_	AIZ1_FireRise
		jsr_	AIZTrans_WavyFlame
		tst.w	(Events_bg+$00).w
		bne.s	locK_50160
		move.w	(Camera_Y_pos_BG_copy).w,d0
		andi.w	#$7F,d0
		cmpi.w	#$20,d0
		blo.s	locK_50144
		cmpi.w	#$30,d0
		blo.s	locK_50148
; loc3_3B4B0:
locK_50144:
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------
; loc3_3B4B4:
locK_50148:
		addi.w	#$180,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		and.w	(Camera_Y_pos_mask).w,d0
		subi.w	#$10,d0
		move.w	d0,(Camera_Y_pos_BG_rounded).w
		st	(Events_bg+$00).w
; loc3_3B4CC:
locK_50160:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	#$200,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		cmpi.w	#$310,(Camera_Y_pos_BG_copy).w
		blo.s	locK_501D6			; If fire hasn't subsided, branch
		movem.l	d7-a0/a2-a3,-(sp)
		moveq	#PLCID_0C,d0
		jsr	(Load_PLC).l
		jsr	(LoadEnemyArt).l
		movem.l	(sp)+,d7-a0/a2-a3
		lea	(Normal_palette_line_4+$2).w,a1
		move.l	#$8EE00AA,(a1)+
		move.l	#$8E004E,(a1)+
		move.l	#$2E000C,(a1)
		move.w	#$6000,d0
		move.w	d0,(Camera_max_X_pos).w
	if Sonic3_Alone
		move.w	d0,(Camera_target_max_X_pos).w
	endif
		jsr_	AIZ2_Deform
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w		; Set up Effective BG Y location for screen redraw
		move.w	#$F,(Draw_delayed_rowcount).w		; Set up redraw count
		move.w	#$C,(Special_V_int_routine).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_50204
; ---------------------------------------------------------------------------
; loc3_3B544:
locK_501D6:
		jsr_	AIZ2_ApplyDeform
		lea	(H_scroll_buffer+2).w,a1
		move.w	(Camera_X_pos_BG_copy).w,d0	; Cancel out background deformation since we're still in the open field
		neg.w	d0
		moveq	#bytesToLcnt(224),d1
; loc3_3B554:
locK_501E8:
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		dbf	d1,locK_501E8
		rts
; ---------------------------------------------------------------------------

AIZ2BGE_BGRedraw:
		jsr_	AIZ2_Deform
; loc3_3B56E:
locK_50204:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	locK_50260
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_50260
; ---------------------------------------------------------------------------

AIZ2BGE_Normal:
		jsr_	AIZ2_Deform
		tst.w	(Events_fg_5).w
		beq.s	locK_50260
		clr.w	(Events_fg_5).w
		move.w	#$A8,d0
	if Sonic3_Alone
		cmpi.w	#$400,(Camera_Y_pos_copy).w
	else
		cmpi.w	#$400,(Camera_Y_pos).w
	endif
		blo.s	locK_50236
		move.w	#-$198,d0
; loc3_3B59E:
locK_50236:
		move.w	d0,(Events_bg+$16).w
		add.w	d0,(Camera_Y_pos_BG_copy).w
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		move.w	#$4440,(Events_bg+$02).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_50280
; ---------------------------------------------------------------------------
; loc3_3B5C8:
locK_50260:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		jsr_	AIZ2_ApplyDeform
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

AIZ2BGE_ShipRefresh:
		jsr_	AIZ2_Deform
;  loc3_3B5E4:
locK_50280:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	locK_50298
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_50298
; ---------------------------------------------------------------------------

AIZ2BGE_ShipMove:
		jsr_	AIZ2_Deform
; loc3_3B5FA:
locK_50298:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		jsr_	AIZ2_ApplyDeform
		tst.w	(Events_bg+$04).w
		beq.s	locK_502C2
		move.w	(_unkEE9C).w,(V_scroll_value).w		; Use effective camera position rather than actual camera position
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp		; Skip last part of ScreenEvents
; loc3_3B622:
locK_502C2:
		jmp	ShakeScreen_Setup(pc)

	if Sonic3_Alone
; =============== S U B R O U T I N E =======================================


AIZ2_Deform:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Screen_shake_offset).w,d1
		sub.w	d1,d0
		asr.w	#1,d0
		add.w	d1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		cmpi.w	#$10,(Events_routine_bg).w
		bcs.s	loc3_3B648
		move.w	(Events_bg+$16).w,d0
		add.w	d0,(Camera_Y_pos_BG_copy).w

loc3_3B648:
		move.w	(Events_fg_1).w,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#5,d1
		move.l	d1,d2
		add.l	d1,d1
		add.l	d2,d1
		lea	(HScroll_table+$1C0).w,a1
		lea	AIZ2_BGDeformMake(pc),a5
		moveq	#0,d2

loc3_3B666:
		move.b	(a5)+,d3
		bmi.s	locret3_3B67E
		ext.w	d3
		swap	d0

loc3_3B66E:
		move.b	(a5)+,d2
		move.w	d0,(a1,d2.w)
		dbf	d3,loc3_3B66E
		swap	d0
		add.l	d1,d0
		bra.s	loc3_3B666
; ---------------------------------------------------------------------------

locret3_3B67E:
		rts
; End of function AIZ2_Deform


; =============== S U B R O U T I N E =======================================


AIZ2_ApplyDeform:
		lea	(HScroll_table).w,a1
		lea	AIZ2_SOZ1_LRZ3_FGDeformDelta(pc),a6
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	#$DF,d1
		move.w	(Level_frame_counter).w,d2
		add.w	d0,d2
		add.w	d0,d2
		moveq	#$3E,d3
		move.w	(Camera_X_pos_copy).w,d6
		neg.w	d6
		move.w	(Water_level).w,d4
		sub.w	d0,d4
		bls.s	loc3_3B6CA			; If completely underwater, only do water deformation
		cmp.w	d1,d4
		bhi.s	loc3_3B6D0			; If water isn't showing at all, only do non-water deformation
		move.w	d4,d1				; Otherwise, just do both
		subq.w	#1,d1
		and.w	d3,d2
		adda.w	d2,a6
		jsr	MakeFGDeformArray(pc)
		move.w	(Water_level).w,d0
		subi.w	#$DE,d1
		neg.w	d1
		move.w	(Level_frame_counter).w,d2
		add.w	d0,d2
		add.w	d0,d2

loc3_3B6CA:
		lea	AIZ1_WaterFGDeformDelta(pc),a6
		moveq	#$7E,d3

loc3_3B6D0:
		and.w	d3,d2
		adda.w	d2,a6
		jsr	MakeFGDeformArray(pc)
		lea	(H_scroll_buffer).w,a1
		lea	(HScroll_table).w,a2
		lea	AIZ2_BGDeformArray(pc),a4
		lea	(HScroll_table+$1C0).w,a5
		lea	AIZ2_ALZ_BGDeformDelta(pc),a6
		move.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	#$DF,d1
		move.w	(Level_frame_counter).w,d2
		asr.w	#1,d2
		add.w	d0,d2
		add.w	d0,d2
		moveq	#$3E,d3
		move.w	(Water_level).w,d4
		sub.w	(Camera_Y_pos_copy).w,d4
		bls.s	loc3_3B73E			; Same as above, if completely underwater only apply water deformation
		cmp.w	d1,d4
		bhi.s	loc3_3B744			; Same as above, if no water is showing, only do above-ground deformation
		move.w	d4,d1				; Otherwise, just do both
		subq.w	#1,d1
		and.w	d3,d2
		adda.w	d2,a6
		jsr	ApplyFGandBGDeformation(pc)
		lea	AIZ2_BGDeformArray(pc),a4
		lea	(HScroll_table+$1C0).w,a5
		move.w	(Water_level).w,d0
		sub.w	(Camera_Y_pos_copy).w,d0
		add.w	(Camera_Y_pos_BG_copy).w,d0
		subi.w	#$DE,d1
		neg.w	d1
		move.w	(Level_frame_counter).w,d2
		asr.w	#1,d2
		add.w	d0,d2
		add.w	d0,d2

loc3_3B73E:
		lea	AIZ1_WaterBGDeformDelta(pc),a6
		moveq	#$7E,d3

loc3_3B744:
		and.w	d3,d2
		adda.w	d2,a6
		jsr	ApplyFGandBGDeformation(pc)
		tst.w	(Events_bg+$04).w
		beq.s	locret3_3B772
		lea	(H_scroll_buffer).w,a1		; This is for what I assume to be the flying battleship sequence.
		move.w	(_unkEE98).w,d0			; Nullifies the top 8 tiles worth of FG waviness for this effect
		neg.w	d0						; And replaces it with position data from the second BG camera.
		moveq	#bytesToLcnt($40),d1

loc3_3B75E:
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		dbf	d1,loc3_3B75E

locret3_3B772:
		rts
; End of function AIZ2_ApplyDeform
	endif

; ---------------------------------------------------------------------------

AIZ2_DoShipLoop:
		clr.w	(Level_repeat_offset).w
		move.w	(Camera_X_pos).w,d0
		addq.w	#4,d0
		cmp.w	(Events_bg+$02).w,d0
		blo.s	locK_502FA
		move.w	#$200,d1			; Do loop
		move.w	d1,(Level_repeat_offset).w
		sub.w	d1,(Player_1+x_pos).w
		sub.w	d1,(Player_2+x_pos).w	; Subtract $200 from X position of Sonic and Tails
		sub.w	d1,d0
		move.w	d0,d1
		andi.w	#$FFF0,d1
		subi.w	#$10,d1
		move.w	d1,(Camera_X_pos_rounded).w
		move.w	d1,(HScroll_table+$1FE).w
; loc3_3B7A8:
locK_502FA:
		move.w	d0,(Camera_X_pos).w
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w	; Set all the camera/start positions
	if Sonic3_Alone
		addi.w	#$18,d0
		cmp.w	(Player_1+x_pos).w,d0
		bls.s	locK_5033A
		move.w	d0,(Player_1+x_pos).w		; Make sure Sonic stays on-screen
		move.w	#$400,(Player_1+ground_vel).w	; Set his running velocity to $400 if the left of screen is hit
		bra.s	locretK_50348
	else
		move.w	d0,d1
		lea	(Player_1).w,a1
		bsr.s	subK_50318
		move.w	d1,d0
		lea	(Player_2).w,a1

; =============== S U B R O U T I N E =======================================


subK_50318:
		cmpi.b	#5,anim(a1)
		bne.s	locK_50324
		clr.b	anim(a1)			; If Sonic is standing, set him to the running animation

locK_50324:
		addi.w	#$18,d0
		cmp.w	x_pos(a1),d0
		bls.s	locK_5033A
		move.w	d0,x_pos(a1)			; Make sure Sonic stays on-screen
		move.w	#$400,ground_vel(a1)		; Set his running velocity to $400 if the left of screen is hit
		bra.s	locretK_50348
	endif
; ---------------------------------------------------------------------------
; loc3_3B7CE:
locK_5033A:
		addi.w	#$88,d0
	if Sonic3_Alone
		cmp.w	(Player_1+x_pos).w,d0
		bhi.s	locretK_50348
		move.w	d0,(Player_1+x_pos).w		; Make sure Sonic can't go past a certain point to the right
	else
		cmp.w	x_pos(a1),d0
		bhi.s	locretK_50348
		move.w	d0,x_pos(a1)			; Make sure Sonic can't go past a certain point to the right
	endif
; locret3_3B7DC:
locretK_50348:
		rts
; End of function subK_50318

; ---------------------------------------------------------------------------

Obj_AIZBattleship:
		move.l	#Obj_AIZBattleshipMain,(a0)
		move.l	#AIZBattleship_BombScript,$2E(a0)
		move.w	#$1A4,$32(a0)
		move.w	#$3FBC,d1
		moveq	#2-1,d2
; loc3_3B7F8:
locK_50364:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locK_5037E
		move.l	#Obj_BattleshipPropeller,(a1)	; Create two propellers, one at the front and one in the back
		move.w	d1,$2E(a1)
		move.w	#$3DCC,d1
		dbf	d2,locK_50364
; loc3_3B812:
locK_5037E:
		lea	(Normal_palette_line_2).w,a1
		lea_	Pal_AIZBattleship,a5
		moveq	#bytesToLcnt($20),d0
; loc3_3B81C:
locK_5038A:
		move.l	(a5)+,(a1)+
		dbf	d0,locK_5038A

Obj_AIZBattleshipMain:
		subi.l	#$8800,(_unkEE98).w
		move.w	(_unkEE98).w,d0
		cmpi.w	#$3CDC,d0
		bpl.s	locK_503BC
		move.l	#Obj_AIZ2BossSmall,(a0)
		st	(Events_fg_4).w				; Set for the next screen event
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locretK_503BA
		move.l	#Obj_AIZ2MakeTree,(a1)
; locret3_3B84C:
locretK_503BA:
		rts
; ---------------------------------------------------------------------------
; loc3_3B84E:
locK_503BC:
		move.w	d0,d1
		subi.w	#$3D5C,d0
		bpl.s	locK_503D2
		neg.w	d0					; Move upwards as the battleship goes offscreen
		asr.w	#1,d0
		add.w	(_unkEEA2).w,d0
		move.w	d0,(_unkEE9C).w
		bra.s	locK_503EA
; ---------------------------------------------------------------------------
; loc3_3B864:
locK_503D2:
		asr.w	#2,d1			; Continue bobbing up and down
		andi.w	#$F,d1
		lea_	AIZBattleShip_BobbingMotion,a1
		move.b	(a1,d1.w),d1
		add.w	(_unkEEA2).w,d1
		move.w	d1,(_unkEE9C).w	; Get the bobbing motion delta, apply it to the second camera Y
; loc3_3B87A:
locK_503EA:
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	locK_503FE
		moveq	#signextendB(sfx_LargeShip),d0			; Replay the battleship flying sound every 16th frame
		jsr	(Play_SFX).l
; loc3_3B88E:
locK_503FE:
		subq.w	#1,$32(a0)			; Wait for delay to finish
		bcc.s	locretK_50424
		movea.l	$2E(a0),a2
		move.w	(a2)+,$32(a0)		; Get the first word of the bomb script as the new delay
		bmi.s	locretK_50424
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locretK_50424
		move.l	#Obj_AIZShipBomb,(a1)		; Create a new bomb
		move.w	(a2)+,$2E(a1)		; Put the X position into $2E so it can be translated
		move.l	a2,$2E(a0)			; Update the script position
; locret3_3B8B4:
locretK_50424:
		rts
; ---------------------------------------------------------------------------

Obj_BattleshipPropeller:
		move.l	#Obj_BattleshipPropellerMain,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$20,height_pixels(a0)
		move.b	#8,width_pixels(a0)
		move.w	#$80,priority(a0)
		move.w	#make_art_tile(ArtTile_AIZ2Bombership,0,0),art_tile(a0)
		move.l	#Map_AIZShipPropeller,mappings(a0)
		move.w	#$A71,$30(a0)

Obj_BattleshipPropellerMain:
		cmpi.w	#$C,(Events_routine_fg).w
		bne.s	locK_50466
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
; loc3_3B8F6:
locK_50466:
		lea_	Ani_AIZShipPropeller,a1
		jsr	(Animate_Sprite).l
		jsr	Translate_Camera2ObjPosition(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_AIZShipBomb:
		move.l	#Obj_AIZShipBombMain,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$18,width_pixels(a0)
		move.w	#$80,priority(a0)
		move.w	#make_art_tile(ArtTile_AIZ2Bombership,0,0),art_tile(a0)
		move.l	#Map_AIZ2BombExplode,mappings(a0)
		move.b	#$10,y_radius(a0)
		move.w	#$A60,$30(a0)
		move.w	#6,$32(a0)

Obj_AIZShipBombMain:
		moveq	#0,d0
		move.b	routine(a0),d0
		jmp	AIZShipBomb_Index(pc,d0.w)
; ---------------------------------------------------------------------------

AIZShipBomb_Index:
		bra.w	AIZShipBomb_ReadyDrop
; ---------------------------------------------------------------------------
		bra.w	AIZShipBomb_Delay
; ---------------------------------------------------------------------------
		bra.w	AIZShipBomb_Drop
; ---------------------------------------------------------------------------

AIZShipBomb_ReadyDrop:
		addq.w	#2,$30(a0)
		cmpi.w	#$A80,$30(a0)		; Put bomb into position before delay
		blo.s	locK_504EE
		addq.b	#4,routine(a0)
		bra.s	locK_504EE
; ---------------------------------------------------------------------------

AIZShipBomb_Delay:
		subq.w	#1,$32(a0)
		bne.s	locK_504EE
		addq.b	#4,routine(a0)
		moveq	#signextendB(sfx_MissileThrow),d0
		jsr	(Play_SFX).l		; Play the drop sound after the delay
; loc3_3B97C:
locK_504EE:
		jsr	Translate_Camera2ObjPosition(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

AIZShipBomb_Drop:
		move.l	y_pos(a0),d0
		add.l	y_vel(a0),d0
		move.l	d0,y_pos(a0)			; Drop bomb downwards
		addi.l	#$2000,y_vel(a0)		; Increase acceleration
		swap	d0
		jsr	Translate_Camera2ObjX(pc)
		jsr	(Draw_Sprite).l
		jsr	(ObjCheckFloorDist).l
		cmpi.w	#-8,d1
		bgt.s	locretK_50578
		move.w	#$10,(Screen_shake_flag).w	; If touching the floor, set up a timed screen shake
		moveq	#signextendB(sfx_MissileExplode),d0
		jsr	(Play_SFX).l		; Play the bomb explosion sound
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locK_50572
		lea_	AIZBombExplodeDat,a2
		moveq	#8-1,d1
; loc3_3B9CE:
locK_50542:
		move.l	#Obj_AIZBombExplosion,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.w	(a2)+,d2
		add.w	d2,x_pos(a1)
		move.w	(a2)+,d2
		add.w	d2,y_pos(a1)
		move.w	(a2)+,anim(a1)
		move.w	(a2)+,$2E(a1)
		jsr	(CreateNewSprite4).l
		dbne	d1,locK_50542
; loc3_3B9FE:
locK_50572:
		move.l	#Delete_Current_Sprite,(a0)		; Delete the bomb sprite
; locret3_3BA04:
locretK_50578:
		rts

; =============== S U B R O U T I N E =======================================


Translate_Camera2ObjPosition:
		move.w	$30(a0),d0
		sub.w	(_unkEE9C).w,d0
		add.w	(Camera_Y_pos_copy).w,d0

Translate_Camera2ObjX:
		sub.w	(Screen_shake_last_offset).w,d0
		add.w	(Screen_shake_offset).w,d0
		move.w	d0,y_pos(a0)
		move.w	$2E(a0),d0
		sub.w	(_unkEE98).w,d0
		add.w	(Camera_X_pos_copy).w,d0
		move.w	d0,x_pos(a0)
		rts
; End of function Translate_Camera2ObjPosition

; ---------------------------------------------------------------------------

Obj_AIZBombExplosion:
		move.w	(Level_repeat_offset).w,d0
		sub.w	d0,x_pos(a0)
		subq.w	#1,$2E(a0)
		bmi.s	locK_505B4
		rts
; ---------------------------------------------------------------------------
; loc3_3BA40:
locK_505B4:
		move.l	#Obj_AIZBombExplosionAnim,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$20,width_pixels(a0)
		move.w	#make_art_tile(ArtTile_AIZ2Bombership,0,0),art_tile(a0)
		move.l	#Map_AIZ2BombExplode,mappings(a0)
		move.b	#$8B,collision_flags(a0)
		bra.s	locK_505E4
; ---------------------------------------------------------------------------

Obj_AIZBombExplosionAnim:
		move.w	(Level_repeat_offset).w,d0
		sub.w	d0,x_pos(a0)
; loc3_3BA70:
locK_505E4:
		lea_	Ani_AIZ2BombExplode,a1
		jsr	(Animate_SpriteIrregularDelay).l
		tst.b	routine(a0)
		beq.s	locK_505FC
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
; loc3_3BA86:
locK_505FC:
		moveq	#4,d0
		add.b	anim(a0),d0
		cmp.b	mapping_frame(a0),d0
		bls.s	locK_5060E
		jsr	(Add_SpriteToCollisionResponseList).l
; loc3_3BA98:
locK_5060E:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_AIZ2MakeTree:
	if Sonic3_Alone
		cmpi.w	#$44D0,(Camera_X_pos_copy).w
	else
		cmpi.w	#$44D0,(Camera_X_pos).w
	endif
		bhs.s	locK_5061E
		rts
; ---------------------------------------------------------------------------
; loc3_3BAA8:
locK_5061E:
		move.l	#locK_50632,(a0)
		move.w	(Events_fg_1).w,$2E(a0)
		move.l	#AIZMakeTreeScript,$30(a0)
; loc3_3BABC:
locK_50632:
		movea.l	$30(a0),a2
		tst.w	(a2)
		bpl.s	locK_50640
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
; loc3_3BACA:
locK_50640:
		move.w	(Events_fg_1).w,d0
		sub.w	$2E(a0),d0
		cmp.w	(a2)+,d0
		blo.s	locretK_50662
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locretK_50662
		move.l	#Obj_AIZ2BGTree,(a1)
		move.w	(a2)+,8(a1)
		move.l	a2,$30(a0)
; locret3_3BAEC:
locretK_50662:
		rts
; ---------------------------------------------------------------------------

Obj_AIZ2BGTree:
		move.l	#Obj_AIZ2BGTreeMove,(a0)
		move.w	#make_art_tile(ArtTile_AIZBackgroundTree,0,0),art_tile(a0)
		move.l	#Map_AIZ2BGTree,mappings(a0)
		move.w	#$E9,y_pos(a0)
		move.w	#$1C0,$2E(a0)
		move.w	(Events_fg_1).w,$30(a0)

Obj_AIZ2BGTreeMove:
	if Sonic3_Alone
		cmpi.w	#$4880,(Camera_X_pos_copy).w
	else
		cmpi.w	#$4880,(Camera_X_pos).w
	endif
		blo.s	locK_50698
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
; loc3_3BB22:
locK_50698:
		move.w	(Events_fg_1).w,d0
		sub.w	$30(a0),d0
		move.w	d0,d1
		asr.w	#2,d0
		sub.w	d0,d1
		move.w	$2E(a0),d0
		sub.w	d1,d0
		move.w	d0,x_pos(a0)
		cmpi.w	#$1C0,d0
		bhs.s	locretK_506BC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; locret3_3BB46:
locretK_506BC:
		rts
; ---------------------------------------------------------------------------

Obj_AIZ2BossSmall:
		move.l	#Obj_AIZ2BossSmallMain,(a0)
		move.w	#$300,priority(a0)
		move.w	#make_art_tile(ArtTile_AIZ2Bombership,0,0),art_tile(a0)
		move.l	#Map_AIZ2BossSmall,mappings(a0)
		move.w	#$30,x_pos(a0)
		move.w	#$D8,y_pos(a0)
		move.w	#5,x_vel(a0)
		clr.w	$2E(a0)
		lea	(Normal_palette_line_2+$2).w,a1
		lea_	Pal_AIZBossSmall,a5
		moveq	#bytesToLcnt($1C),d0
; loc3_3BB82:
locK_506FA:
		move.l	(a5)+,(a1)+
		dbf	d0,locK_506FA

Obj_AIZ2BossSmallMain:
		tst.b	$2E(a0)
		bne.s	locK_50712
	if Sonic3_Alone
		cmpi.w	#$4670,(Camera_X_pos_copy).w
	else
		cmpi.w	#$4670,(Camera_X_pos).w
	endif
		blo.s	locretK_5077C
		st	$2E(a0)
; loc3_3BB9A:
locK_50712:
		cmpi.w	#$240,x_pos(a0)
		blo.s	locK_50732
		clr.b	(Scroll_lock).w
		clr.w	(Special_events_routine).w
		clr.w	(Level_repeat_offset).w			; Stop repeating scrolling section
		move.w	#$6000,(Camera_max_X_pos).w	; Change level size
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
; loc3_3BBBA:
locK_50732:
		move.l	x_pos(a0),d0
		move.l	x_vel(a0),d1		; Move Robotnik
		add.l	d1,d0
		move.l	d0,x_pos(a0)
		tst.b	$2F(a0)
		bne.s	locK_50758
		subi.l	#$E80,d1		; Phase 1: Slow down until moving slightly to the left
		cmpi.l	#-$10000,d1
		sle	$2F(a0)
		bra.s	locK_5075E
; ---------------------------------------------------------------------------
; loc3_3BBE0:
locK_50758:
		addi.l	#$E80,d1		; Phase 2: Speed up till moving off screen
; loc3_3BBE6:
locK_5075E:
		move.l	d1,x_vel(a0)
		jsr	(Draw_Sprite).l
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	locretK_5077C
		moveq	#signextendB(sfx_RobotnikSiren),d0		; Every sixteenth frame, play alarm sound
		jsr	(Play_SFX).l
; locret3_3BC04:
locretK_5077C:
		rts
; ---------------------------------------------------------------------------
	if Sonic3_Alone
AIZ2_BGDeformArray:
		dc.w    $10,   $20,   $38,   $58,   $28,   $40,   $38,   $18,   $18,   $90,   $48,   $10,   $18
		dc.w    $20,   $38,   $58,   $28,   $40,   $38,   $18,   $18,   $90,   $48,   $10, $7FFF

AIZ2_BGDeformMake:
		dc.b  2-1, $12, $2A
		dc.b  4-1, $10, $14, $28, $2C
		dc.b  4-1,  $E, $16, $26, $2E
		dc.b  5-1,   0,  $C, $18, $24, $30
		dc.b  4-1,   2,  $A, $1A, $22
		dc.b  4-1,   4,   8, $1C, $20
		dc.b  2-1,   6, $1E
		dc.b  $FF
		even
	endif

AIZ2_SOZ1_LRZ3_FGDeformDelta:
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0

AIZ2_ALZ_BGDeformDelta:
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2

	if Sonic3_Alone
Pal_AIZBattleship:
		binclude "Levels/AIZ/Palettes/Battleship.bin"
		even
Pal_AIZBossSmall:
		binclude "Levels/AIZ/Palettes/Boss Small.bin"
		even

AIZBattleShip_BobbingMotion:
		dc.b    4,   4,   3,   3,   2,   1,   1,   0,   0,   0,   1,   1,   2,   3,   3,   4
		even

AIZBattleship_BombScript:
		dc.w    $20, $3F5C
		dc.w    $20, $3F2C
		dc.w    $20, $3F5C
		dc.w    $20, $3F2C
		dc.w    $20, $3F5C
		dc.w    $38, $3F2C
		dc.w    $20, $3EDC
		dc.w    $20, $3EAC
		dc.w    $20, $3EDC
		dc.w    $20, $3EAC
		dc.w    $20, $3EDC
		dc.w    $38, $3EAC
		dc.w    $20, $3E5C
		dc.w    $20, $3E2C
		dc.w    $20, $3E5C
		dc.w    $20, $3E2C
		dc.w    $20, $3E5C
		dc.w    $38, $3E2C
		dc.w    $40, $3DEC
		dc.w    $40, $3DEC
		dc.w    $40, $3DEC
		dc.w  $FFFF

AIZBombExplodeDat:
		dc.w      0,  -$3C, (0<<8)|0,    $A ; X offset, Y offset, animation number, animation delay
		dc.w      0,   -$C, (1<<8)|1,     9
		dc.w     -4,  -$34, (0<<8)|0,     8
		dc.w     $C,    -4, (1<<8)|1,     7
		dc.w    -$C,    -4, (1<<8)|1,     5
		dc.w      8,  -$24, (0<<8)|0,     4
		dc.w     -8,  -$1C, (0<<8)|0,     2
		dc.w      0,   -$C, (0<<8)|0,     0

AIZMakeTreeScript:
		dc.w      0,  $280
		dc.w    $32,  $380
		dc.w    $8E,  $280
		dc.w   $103,  $380
		dc.w   $179,  $280
		dc.w   $1C6,  $380
		dc.w   $233,  $280
		dc.w   $2A0,  $380
		dc.w   $30A,  $280
		dc.w   $37C,  $380
		dc.w   $3C7,  $280
		dc.w   $401,  $380
		dc.w   $439,  $280
		dc.w   $46E,  $380
		dc.w   $4CA,  $280
		dc.w   $50C,  $380
		dc.w   $557,  $280
		dc.w  $FFFF

Map_AIZShipPropeller:
		include "Levels/AIZ/Misc Object Data/Map - Act 2 Ship Propeller.asm"
Ani_AIZShipPropeller:
		include "Levels/AIZ/Misc Object Data/Anim - Act 2 Ship Propeller.asm"
Map_AIZ2BombExplode:
		include "Levels/AIZ/Misc Object Data/Map - Act 2 Bomb Explosion.asm"
Ani_AIZ2BombExplode:
		include "Levels/AIZ/Misc Object Data/Anim - Act 2 Bomb Explosion.asm"
Map_AIZ2BGTree:
		include "Levels/AIZ/Misc Object Data/Map - Act 2 Background Tree.asm"
Map_AIZ2BossSmall:
		include "Levels/AIZ/Misc Object Data/Map - Act 2 Boss Small.asm"
	endif