; ---------------------------------------------------------------------------

FBZ1_ScreenInit:
		cmpi.w	#$180,(Player_1+x_pos).w
		blo.s	locK_52412
		move.w	-8(a3),d0
		subq.w	#5,d0
		movea.w	$34(a3),a1		; $680 Y
		movea.w	$48(a3),a5		; $900 Y
		moveq	#3-1,d1

locK_52404:
		move.l	(a5)+,(a1)+		; Copy the "indoors" beginning part
		move.b	(a5)+,(a1)+
		adda.w	d0,a1
		adda.w	d0,a5
		dbf	d1,locK_52404
		bra.s	locK_5241C
; ---------------------------------------------------------------------------

locK_52412:
		move.w	#$18,(Events_bg+$00).w		; If player is < $180 X
		st	(Events_bg+$02).w

locK_5241C:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

FBZ1_ScreenEvent:
		cmpi.b	#6,(Player_1+routine).w
		blo.s	locK_5242E
		rts							; Don't do any special events while Sonic is dying
; ---------------------------------------------------------------------------

locK_5242E:
		lea	FBZ1_LayoutModRange(pc),a1
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		move.w	(Events_bg+$00).w,d2
		jmp	FBZ1_ScreenEvent_Index(pc,d2.w)
; ---------------------------------------------------------------------------

FBZ1_ScreenEvent_Index:
		bra.w	FBZ1SE_Normal
; ---------------------------------------------------------------------------
		bra.w	FBZ1SE_LayoutMod1
; ---------------------------------------------------------------------------
		bra.w	FBZ1SE_LayoutMod2
; ---------------------------------------------------------------------------
		bra.w	FBZ1SE_LayoutMod3
; ---------------------------------------------------------------------------
		bra.w	FBZ1SE_LayoutMod4
; ---------------------------------------------------------------------------
		bra.w	FBZ1SE_LayoutMod5
; ---------------------------------------------------------------------------
		bra.w	FBZ1SE_LayoutMod6	; Beginning of stage
; ---------------------------------------------------------------------------

FBZ1SE_Normal:
		moveq	#4,d2
		moveq	#6-1,d3

locK_52462:
		lea	(a1),a5					; Check layout mod ranges
		cmp.w	(a5)+,d0
		blo.s	locK_5247A
		cmp.w	(a5)+,d0
		bhi.s	locK_5247A
		cmp.w	(a5)+,d1
		blo.s	locK_5247A
		cmp.w	(a5)+,d1
		bhi.s	locK_5247A
		move.w	d2,(Events_bg+$00).w
		bra.s	locK_52482
; ---------------------------------------------------------------------------

locK_5247A:
		addq.w	#8,a1
		addq.w	#4,d2
		dbf	d3,locK_52462

locK_52482:
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

FBZ1SE_LayoutMod1:
		jsr	FBZ1Screen_CheckInRange(pc)		; Make sure Sonic is still in range
		tst.w	(Events_bg+$02).w
		bne.s	locK_524AA
		cmpi.w	#$B00,d0		; If indoors, check if Sonic is in right half of ranged area
		bhs.s	locK_524A0		; If so, branch
		cmpi.w	#$70A,d0		; Otherwise, check if Sonic has gone far enough to the right
		bls.w	locK_52828
		bra.s	locK_524D4
; ---------------------------------------------------------------------------

locK_524A0:
		cmpi.w	#$A0E,d1		; If to the right of ranged area, instead check if Sonic has gone low enough
		bls.w	locK_52828
		bra.s	locK_524D4
; ---------------------------------------------------------------------------

locK_524AA:
		cmpi.w	#$B00,d0		; If outdoors, check if Sonic is in right half of ranged area
		bhs.s	locK_524BA		; If so, branch
		cmpi.w	#$6F6,d0		; Otherwise, check if Sonic has gone far enough to the left
		bls.s	locK_524C2
		bra.w	locK_52828
; ---------------------------------------------------------------------------

locK_524BA:
		cmpi.w	#$9F2,d1		; If to the right of ranged area, instead check if Sonic has gone high enough
		bhi.w	locK_52828

locK_524C2:
		clr.w	(Events_bg+$02).w	; In either case, go outdoors->indoors
		movea.w	(a3),a5
		lea	$60(a5),a5
		movea.w	(a3),a6
		lea	$64(a6),a6
		bra.s	locK_524E8
; ---------------------------------------------------------------------------

locK_524D4:
		st	(Events_bg+$02).w		; Go indoors->outdoors
		movea.w	$18(a3),a5
		lea	$60(a5),a5			; First source is at $300 Y, $3000 X
		movea.w	$14(a3),a6
		lea	$64(a6),a6			; Second source is at $280 Y, $3200 X (both of these are technically out of range)

locK_524E8:
		movea.w	$48(a3),a1
		lea	$C(a1),a1			; First destination is $900 Y, $600 X
		move.w	-8(a3),d0
		subq.w	#4,d0			; Width of four tiles
		moveq	#6-1,d1			; Height of 6 tiles

locK_524F8:
		move.l	(a5)+,(a1)+		; Copy over layout
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,locK_524F8
		movea.w	$48(a3),a1
		lea	$1A(a1),a1			; Second destination is $900 Y, $D00 X
		move.w	-8(a3),d0
		subq.w	#6,d0			; Width of 6 tiles
		moveq	#4-1,d1			; Height of 4 tiles

locK_52512:
		move.l	(a6)+,(a1)+
		move.w	(a6)+,(a1)+		; Copy over layout
		adda.w	d0,a6
		adda.w	d0,a1
		dbf	d1,locK_52512
		jmp	Refresh_PlaneScreenDirect(pc)	; Refresh screen
; ---------------------------------------------------------------------------

FBZ1SE_LayoutMod2:
		lea	8(a1),a1			; The following layout mods all basically work identically to the above with modifications in positioning, etc.
		jsr	FBZ1Screen_CheckInRange(pc)		; I'll leave it as an exercise to the reader to get the specifics of each routine :)
		tst.w	(Events_bg+$02).w
		bne.s	locK_5254A
		cmpi.w	#$C80,d0
		bhs.s	locK_52540
		cmpi.w	#$1F2,d1
		bhs.w	locK_52828
		bra.s	locK_52574
; ---------------------------------------------------------------------------

locK_52540:
		cmpi.w	#$108A,d0
		bls.w	locK_52828
		bra.s	locK_52574
; ---------------------------------------------------------------------------

locK_5254A:
		cmpi.w	#$C80,d0
		bhs.s	locK_5255A
		cmpi.w	#$20E,d1
		bhs.s	locK_52562
		bra.w	locK_52828
; ---------------------------------------------------------------------------

locK_5255A:
		cmpi.w	#$1076,d0
		bhi.w	locK_52828

locK_52562:
		clr.w	(Events_bg+$02).w
		movea.w	(a3),a5
		lea	$6C(a5),a5
		movea.w	(a3),a6
		lea	$76(a6),a6
		bra.s	locK_52588
; ---------------------------------------------------------------------------

locK_52574:
		st	(Events_bg+$02).w
		movea.w	$14(a3),a5
		lea	$6C(a5),a5
		movea.w	$10(a3),a6
		lea	$76(a6),a6

locK_52588:
		movea.w	8(a3),a1
		lea	$E(a1),a1
		move.w	-8(a3),d0
		subi.w	#$A,d0
		moveq	#4-1,d1

locK_5259A:
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		move.w	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,locK_5259A
		movea.w	$C(a3),a1
		lea	$1C(a1),a1
		move.w	-8(a3),d0
		subi.w	#$C,d0
		moveq	#3-1,d1

locK_525BA:
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		adda.w	d0,a6
		adda.w	d0,a1
		dbf	d1,locK_525BA
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

FBZ1SE_LayoutMod3:
		lea	$10(a1),a1
		jsr	FBZ1Screen_CheckInRange(pc)
		tst.w	(Events_bg+$02).w
		bne.s	locK_525F4
		cmpi.w	#$1880,d0
		bhs.s	locK_525EA
		cmpi.w	#$158A,d0
		bls.w	locK_52828
		bra.s	locK_52622
; ---------------------------------------------------------------------------

locK_525EA:
		cmpi.w	#$A0E,d1
		bls.w	locK_52828
		bra.s	locK_52622
; ---------------------------------------------------------------------------

locK_525F4:
		cmpi.w	#$1880,d0
		bhs.s	locK_52604
		cmpi.w	#$1576,d0
		bls.s	locK_5260C
		bra.w	locK_52828
; ---------------------------------------------------------------------------

locK_52604:
		cmpi.w	#$9F2,d1
		bhi.w	locK_52828

locK_5260C:
		clr.w	(Events_bg+$02).w
		movea.w	$34(a3),a5
		lea	$60(a5),a5
		movea.w	$28(a3),a6
		lea	$66(a6),a6
		bra.s	locK_52636
; ---------------------------------------------------------------------------

locK_52622:
		st	(Events_bg+$02).w
		movea.w	$44(a3),a5
		lea	$60(a5),a5
		movea.w	$3C(a3),a6
		lea	$66(a6),a6

locK_52636:
		movea.w	$48(a3),a1
		lea	$28(a1),a1
		move.w	-8(a3),d0
		subq.w	#6,d0
		moveq	#4-1,d1

locK_52646:
		move.l	(a5)+,(a1)+
		move.w	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,locK_52646
		movea.w	$48(a3),a1
		lea	$34(a1),a1
		move.w	-8(a3),d0
		subq.w	#6,d0
		moveq	#4-1,d1

locK_52662:
		move.l	(a6)+,(a1)+
		move.w	(a6)+,(a1)+
		adda.w	d0,a6
		adda.w	d0,a1
		dbf	d1,locK_52662
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

FBZ1SE_LayoutMod4:
		lea	$18(a1),a1
		jsr	FBZ1Screen_CheckInRange(pc)
		tst.w	(Events_bg+$02).w
		bne.s	locK_526A0
		cmpi.w	#$208A,d0
		bhs.s	locK_526D6
		cmpi.w	#$1D80,d0
		bhs.s	locK_52696
		cmpi.w	#$1C0A,d0
		bls.w	locK_52828
		bra.s	locK_526D6
; ---------------------------------------------------------------------------

locK_52696:
		cmpi.w	#$F2,d1
		bhs.w	locK_52828
		bra.s	locK_526D6
; ---------------------------------------------------------------------------

locK_526A0:
		cmpi.w	#$1D80,d0
		bhs.s	locK_526B0
		cmpi.w	#$1BF6,d0
		bls.s	locK_526C0
		bra.w	locK_52828
; ---------------------------------------------------------------------------

locK_526B0:
		cmpi.w	#$10E,d1
		bls.w	locK_52828
		cmpi.w	#$2076,d0
		bhs.w	locK_52828

locK_526C0:
		clr.w	(Events_bg+$02).w
		movea.w	$28(a3),a5
		lea	$6E(a5),a5
		movea.w	$28(a3),a6
		lea	$76(a6),a6
		bra.s	locK_526EA
; ---------------------------------------------------------------------------

locK_526D6:
		st	(Events_bg+$02).w
		movea.w	$3C(a3),a5
		lea	$6E(a5),a5
		movea.w	$3C(a3),a6
		lea	$76(a6),a6

locK_526EA:
		movea.w	(a3),a1
		lea	$36(a1),a1
		move.w	-8(a3),d0
		subq.w	#8,d0
		moveq	#4-1,d1

locK_526F8:
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,locK_526F8
		movea.w	(a3),a1
		lea	$3E(a1),a1
		move.w	-8(a3),d0
		subi.w	#$12,d0
		moveq	#5-1,d1

locK_52714:
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.w	(a6)+,(a1)+
		adda.w	d0,a6
		adda.w	d0,a1
		dbf	d1,locK_52714
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

FBZ1SE_LayoutMod5:
		lea	$20(a1),a1
		jsr	FBZ1Screen_CheckInRange(pc)
		cmpi.w	#$2100,d0
		blo.s	locK_52740
		cmpi.w	#$2600,d0
		bls.w	locK_52828

locK_52740:
		tst.w	(Events_bg+$02).w
		bne.s	locK_52750
		cmpi.w	#$172,d1
		bhs.w	locK_52828
		bra.s	locK_5276E
; ---------------------------------------------------------------------------

locK_52750:
		cmpi.w	#$18E,d1
		blo.w	locK_52828
		clr.w	(Events_bg+$02).w
		movea.w	$28(a3),a5
		lea	$6E(a5),a5
		movea.w	$28(a3),a6
		lea	$76(a6),a6
		bra.s	locK_52782
; ---------------------------------------------------------------------------

locK_5276E:
		st	(Events_bg+$02).w
		movea.w	$3C(a3),a5
		lea	$6E(a5),a5
		movea.w	$3C(a3),a6
		lea	$76(a6),a6

locK_52782:
		movea.w	(a3),a1
		lea	$36(a1),a1
		move.w	-8(a3),d0
		subq.w	#8,d0
		moveq	#4-1,d1

locK_52790:
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,locK_52790
		movea.w	(a3),a1
		lea	$3E(a1),a1
		move.w	-8(a3),d0
		subi.w	#$12,d0
		moveq	#5-1,d1

locK_527AC:
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.w	(a6)+,(a1)+
		adda.w	d0,a6
		adda.w	d0,a1
		dbf	d1,locK_527AC
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

FBZ1SE_LayoutMod6:
		lea	$28(a1),a1			; Get the last layout change range
		jsr	FBZ1Screen_CheckInRange(pc)	; Ensure player is still in specified range
		tst.w	(Events_bg+$02).w
		bne.s	locK_527DA
		cmpi.w	#$70E,d1		; If "indoors", check if Sonic is below given point
		bls.w	locK_52828		; If not, don't do anything
		bra.s	locK_527EC
; ---------------------------------------------------------------------------

locK_527DA:
		cmpi.w	#$6F2,d1		; If "outdoors" flag is set, check if Sonic is above point given
		bhi.w	locK_52828		; If not, don't do anything
		clr.w	(Events_bg+$02).w	; Make Sonic "indoors"
		movea.w	$48(a3),a5		; Perform layout copy of indoor tiles
		bra.s	locK_527F4
; ---------------------------------------------------------------------------

locK_527EC:
		st	(Events_bg+$02).w		; Make Sonic "outdoors"
		movea.w	$54(a3),a5		; Perform layout copy of outdoor tiles

locK_527F4:
		movea.w	$34(a3),a1
		move.w	-8(a3),d0
		subq.w	#5,d0
		moveq	#3-1,d1

locK_52800:
		move.l	(a5)+,(a1)+
		move.b	(a5)+,(a1)+		; Perform layout copy
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,locK_52800
		jmp	Refresh_PlaneScreenDirect(pc)	; Redraw screen directly

; =============== S U B R O U T I N E =======================================


FBZ1Screen_CheckInRange:
		cmp.w	(a1)+,d0
		blo.s	locK_52822
		cmp.w	(a1)+,d0
		bhi.s	locK_52822
		cmp.w	(a1)+,d1
		blo.s	locK_52822
		cmp.w	(a1)+,d1
		bhi.s	locK_52822
		rts
; ---------------------------------------------------------------------------

locK_52822:
		addq.w	#4,sp
		clr.w	(Events_bg+$00).w

locK_52828:
		jmp	DrawTilesAsYouMove(pc)
; End of function FBZ1Screen_CheckInRange

; ---------------------------------------------------------------------------
FBZ1_LayoutModRange:
		dc.w   $400,  $F00,  $880,  $A80
		dc.w   $880, $1100,  $180,  $300
		dc.w  $1400, $1B80,  $900,  $B00
		dc.w  $1A80, $2100,   $80,  $200
		dc.w  $2080, $2680,  $100,  $280
		dc.w      0,  $180,  $580,  $780
; ---------------------------------------------------------------------------

FBZ1_BackgroundInit:
		jsr	(AllocateObject).l
		bne.s	locK_5286A
		move.l	#Obj_FBZOutdoorBGMotion,(a1)

locK_5286A:
		cmpi.w	#$180,(Player_1+x_pos).w
		bhs.s	locK_528A4
		st	(Events_bg+$04).w		; if player is at start, then he's outside. Set outdoors flag
		lea	Pal_FBZBGOutdoors(pc),a1
		lea	(Target_palette_line_4+$4).w,a5
		move.l	(a1)+,(a5)+		; Change to outdoor palette
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		jsr	FBZ_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		move.w	#$200,d1		; Outdoor BG is $200 pixels right of indoor BG
		moveq	#0,d0
		jsr	Refresh_PlaneFull(pc)
		lea	FBZ_OutBGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

locK_528A4:
		jsr	FBZ_Deform(pc)		; Indoors
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	FBZ_InBGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

FBZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	FBZ1_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

FBZ1_BackgroundEvent_Index:
		bra.w	FBZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	FBZ1BGE_ChangeTopDown
; ---------------------------------------------------------------------------
		bra.w	FBZ1BGE_ChangeBottomUp
; ---------------------------------------------------------------------------
		bra.w	FBZ1BGE_ChangeLeftRight
; ---------------------------------------------------------------------------
		bra.w	FBZ1BGE_ChangeRightLeft
; ---------------------------------------------------------------------------

FBZ1BGE_ChangeTopDown:
		jsr	FBZ1_CheckBGChange(pc)

locK_528DE:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		tst.w	(Events_bg+$04).w
		beq.s	locK_528F0
		move.w	#$200,d1
		moveq	#0,d2

locK_528F0:
		jsr	Draw_PlaneVertTopDown(pc)
		bpl.w	FBZ1BGE_GoDeform
		clr.w	(Events_routine_bg).w
		bra.w	FBZ1BGE_GoDeform
; ---------------------------------------------------------------------------

FBZ1BGE_ChangeBottomUp:
		jsr	FBZ1_CheckBGChange(pc)

locK_52904:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		tst.w	(Events_bg+$04).w
		beq.s	locK_52916
		move.w	#$200,d1
		moveq	#0,d2

locK_52916:
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.w	FBZ1BGE_GoDeform
		clr.w	(Events_routine_bg).w
		bra.w	FBZ1BGE_GoDeform
; ---------------------------------------------------------------------------

FBZ1BGE_ChangeLeftRight:
		jsr	FBZ1_CheckBGChange(pc)

locK_5292A:
		move.w	(Camera_Y_pos_BG_copy).w,d1
		moveq	#0,d2
		tst.w	(Events_bg+$04).w
		beq.s	locK_5293C
		moveq	#0,d1
		move.w	#$200,d2

locK_5293C:
		jsr	Draw_PlaneHorzLeftToRight(pc)
		bpl.w	FBZ1BGE_GoDeform
		clr.w	(Events_routine_bg).w
		bra.w	FBZ1BGE_GoDeform
; ---------------------------------------------------------------------------

FBZ1BGE_ChangeRightLeft:
		jsr	FBZ1_CheckBGChange(pc)

locK_52950:
		move.w	(Camera_Y_pos_BG_copy).w,d1
		moveq	#0,d2
		tst.w	(Events_bg+$04).w
		beq.s	locK_52962
		moveq	#0,d1
		move.w	#$200,d2

locK_52962:
		jsr	Draw_PlaneHorzRightToLeft(pc)
		bpl.w	FBZ1BGE_GoDeform
		clr.w	(Events_routine_bg).w
		bra.w	FBZ1BGE_GoDeform
; ---------------------------------------------------------------------------

FBZ1BGE_Normal:
		tst.w	(Events_fg_5).w
		beq.s	locK_529EE
		clr.w	(Events_fg_5).w		; Check for transition flag
		movem.l	d7-a0/a2-a3,-(sp)
		moveq	#PLCID_1C,d0
		jsr	(Load_PLC).l
		move.w	#$401,(Current_zone_and_act).w
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(Respawn_table_keep).w
		jsr	Clear_Switches(pc)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		moveq	#PalID_FBZ2,d0
		jsr	(LoadPalette_Immediate).l
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$2E00,d0
		moveq	#0,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d0,(Player_2+x_pos).w
		jsr	Offset_ObjectsDuringTransition(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w
		jsr	Reset_TileOffsetPositionActual(pc)
		jsr	FBZ_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		bra.s	FBZ1BGE_GoDeform
; ---------------------------------------------------------------------------

locK_529EE:
		cmpi.b	#6,(Player_1+routine).w
		blo.s	locK_529F8
		rts						; Don't do special events if Sonic is dying
; ---------------------------------------------------------------------------

locK_529F8:
		jsr	FBZ1_CheckBGChange(pc)

FBZ1BGE_GoDeform:
		move.w	(Events_bg+$04).w,d1
		beq.s	locK_52A06
		move.w	#$200,d1

locK_52A06:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	FBZ_InBGDeformArray(pc),a4
		tst.w	(Events_bg+$04).w
		beq.s	locK_52A22
		lea	FBZ_OutBGDeformArray(pc),a4

locK_52A22:
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)

; =============== S U B R O U T I N E =======================================


FBZ_Deform:
		tst.w	(Events_bg+$04).w
		bne.s	locK_52A70
		move.w	(Camera_Y_pos_copy).w,d0	; Indoors
		asr.w	#1,d0
		move.w	d0,d1
		asr.w	#5,d1
		sub.w	d1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w	; Effective BG Y is slightly below half speed of normal BG Y
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		lea	(HScroll_table).w,a1
		lea	FBZ_InBGDeformIndex(pc),a5
		moveq	#0,d2

locK_52A56:
		move.b	(a5)+,d3
		bmi.s	locretK_52A6E
		ext.w	d3
		swap	d0

locK_52A5E:
		move.b	(a5)+,d2
		move.w	d0,(a1,d2.w)
		dbf	d3,locK_52A5E
		swap	d0
		add.l	d1,d0
		bra.s	locK_52A56
; ---------------------------------------------------------------------------

locretK_52A6E:
		rts
; ---------------------------------------------------------------------------

locK_52A70:
		moveq	#$16,d0				; Outdoors
		add.w	(Events_bg+$08).w,d0	; Add offset of bobbing motion to 16
		move.w	d0,(Camera_Y_pos_BG_copy).w
		lea	(HScroll_table).w,a1
		lea	FBZ_OutBGDeformIndex(pc),a5
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		asr.l	#1,d1
		move.l	(HScroll_table+$1FC).w,d2	; Get cloud movement speed
		addi.l	#$E00,(HScroll_table+$1FC).w
		moveq	#9-1,d3

locK_52A9E:
		move.w	(a5)+,d4
		add.l	d2,d0
		swap	d0
		move.w	d0,(a1,d4.w)
		swap	d0
		add.l	d1,d0
		dbf	d3,locK_52A9E
		rts
; End of function FBZ_Deform


; =============== S U B R O U T I N E =======================================


FBZ1_CheckBGChange:
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		move.w	(Events_bg+$00).w,d2	; The BG change events are synced with the layout mod events in screen events. Each numbered routine
		jmp	FBZ1_CheckBGChange_Index(pc,d2.w)		; here corresponds with the same layoutmod number in FBZ1_ScreenEvents
; End of function FBZ1_CheckBGChange

; ---------------------------------------------------------------------------

FBZ1_CheckBGChange_Index:
		bra.w	FBZ_Deform		; If no event, then just do business as usual
; ---------------------------------------------------------------------------
		bra.w	FBZ1_BGChange1
; ---------------------------------------------------------------------------
		bra.w	FBZ1_BGChange2
; ---------------------------------------------------------------------------
		bra.w	FBZ1_BGChange3
; ---------------------------------------------------------------------------
		bra.w	FBZ1_BGChange4
; ---------------------------------------------------------------------------
		bra.w	FBZ1_BGChange5
; ---------------------------------------------------------------------------
		bra.w	FBZ1_BGChange6
; ---------------------------------------------------------------------------

FBZ1_BGChange1:
		tst.w	(Events_bg+$04).w
		bne.s	locK_52AFE
		cmpi.w	#$B00,d0		; If indoors
		bhs.s	locK_52AF4
		cmpi.w	#$9C0,d1
		blo.w	FBZ_Deform
		bra.s	locK_52B22
; ---------------------------------------------------------------------------

locK_52AF4:
		cmpi.w	#$900,d1
		blo.w	FBZ_Deform
		bra.s	locK_52B22
; ---------------------------------------------------------------------------

locK_52AFE:
		cmpi.w	#$B00,d0		; If outdoors
		bhs.s	locK_52B0E
		cmpi.w	#$9C0,d1
		bhi.w	FBZ_Deform
		bra.s	locK_52B16
; ---------------------------------------------------------------------------

locK_52B0E:
		cmpi.w	#$900,d1
		bhi.w	FBZ_Deform

locK_52B16:
		clr.w	(Events_bg+$04).w
		moveq	#4,d0
		moveq	#0,d6
		bra.w	FBZ_BGChangeGoIn
; ---------------------------------------------------------------------------

locK_52B22:
		st	(Events_bg+$04).w
		moveq	#8,d0
		move.w	#$F0,d6
		bra.w	FBZ_BGChangeGoOut
; ---------------------------------------------------------------------------

FBZ1_BGChange2:
		tst.w	(Events_bg+$04).w
		bne.s	locK_52B50
		cmpi.w	#$C80,d0
		bhs.s	locK_52B46
		cmpi.w	#$2C0,d1
		bhi.w	FBZ_Deform
		bra.s	locK_52B76
; ---------------------------------------------------------------------------

locK_52B46:
		cmpi.w	#$240,d1
		bhi.w	FBZ_Deform
		bra.s	locK_52B76
; ---------------------------------------------------------------------------

locK_52B50:
		cmpi.w	#$C80,d0
		bhs.s	locK_52B60
		cmpi.w	#$2C0,d1
		blo.w	FBZ_Deform
		bra.s	locK_52B68
; ---------------------------------------------------------------------------

locK_52B60:
		cmpi.w	#$240,d1
		blo.w	FBZ_Deform

locK_52B68:
		clr.w	(Events_bg+$04).w
		moveq	#8,d0
		move.w	#$F0,d6
		bra.w	FBZ_BGChangeGoIn
; ---------------------------------------------------------------------------

locK_52B76:
		st	(Events_bg+$04).w
		moveq	#4,d0
		moveq	#0,d6
		bra.w	FBZ_BGChangeGoOut
; ---------------------------------------------------------------------------

FBZ1_BGChange3:
		tst.w	(Events_bg+$04).w
		bne.s	locK_52BA2
		cmpi.w	#$1880,d0
		bhs.s	locK_52B98
		cmpi.w	#$9C0,d1
		blo.w	FBZ_Deform
		bra.s	locK_52BC6
; ---------------------------------------------------------------------------

locK_52B98:
		cmpi.w	#$940,d1
		blo.w	FBZ_Deform
		bra.s	locK_52BC6
; ---------------------------------------------------------------------------

locK_52BA2:
		cmpi.w	#$1880,d0
		bhs.s	locK_52BB2
		cmpi.w	#$9C0,d1
		bhi.w	FBZ_Deform
		bra.s	locK_52BBA
; ---------------------------------------------------------------------------

locK_52BB2:
		cmpi.w	#$940,d1
		bhi.w	FBZ_Deform

locK_52BBA:
		clr.w	(Events_bg+$04).w
		moveq	#4,d0
		moveq	#0,d6
		bra.w	FBZ_BGChangeGoIn
; ---------------------------------------------------------------------------

locK_52BC6:
		st	(Events_bg+$04).w
		moveq	#8,d0
		move.w	#$F0,d6
		bra.w	FBZ_BGChangeGoOut
; ---------------------------------------------------------------------------

FBZ1_BGChange4:
		cmpi.w	#$100,d1
		blo.s	locK_52C0C
		tst.w	(Events_bg+$04).w
		bne.s	locK_52BEA
		cmpi.w	#$1C0,d1
		bhi.w	FBZ_Deform
		bra.s	locK_52C00
; ---------------------------------------------------------------------------

locK_52BEA:
		cmpi.w	#$1C0,d1
		blo.w	FBZ_Deform
		clr.w	(Events_bg+$04).w
		moveq	#8,d0
		move.w	#$F0,d6
		bra.w	FBZ_BGChangeGoIn
; ---------------------------------------------------------------------------

locK_52C00:
		st	(Events_bg+$04).w
		moveq	#4,d0
		moveq	#0,d6
		bra.w	FBZ_BGChangeGoOut
; ---------------------------------------------------------------------------

locK_52C0C:
		tst.w	(Events_bg+$04).w
		bne.s	locK_52C1C
		cmpi.w	#$1B00,d0
		blo.w	FBZ_Deform
		bra.s	locK_52C2E
; ---------------------------------------------------------------------------

locK_52C1C:
		cmpi.w	#$1B00,d0
		bhi.w	FBZ_Deform
		clr.w	(Events_bg+$04).w
		moveq	#$C,d0
		moveq	#0,d6
		bra.s	locK_52C3E
; ---------------------------------------------------------------------------

locK_52C2E:
		st	(Events_bg+$04).w
		moveq	#$10,d0
		move.w	#$3F0,d6
		lea	Pal_FBZBGOutdoors(pc),a1
		bra.s	locK_52C42
; ---------------------------------------------------------------------------

locK_52C3E:
		lea	Pal_FBZBGIndoors(pc),a1		; Special case for going left/right rather than up/down

locK_52C42:
		lea	(Normal_palette_line_4+$4).w,a5
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.w	d0,(Events_routine_bg).w
		jsr	FBZ_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		move.w	d6,(Draw_delayed_position).w
		move.w	#$1F,(Draw_delayed_rowcount).w
		addq.w	#4,sp
		cmpi.w	#$C,(Events_routine_bg).w
		beq.w	locK_5292A
		bra.w	locK_52950
; ---------------------------------------------------------------------------

FBZ1_BGChange5:
		tst.w	(Events_bg+$04).w
		bne.s	locK_52C84
		cmpi.w	#$240,d1
		bhi.w	FBZ_Deform
		bra.s	locK_52C98
; ---------------------------------------------------------------------------

locK_52C84:
		cmpi.w	#$240,d1
		blo.w	FBZ_Deform
		clr.w	(Events_bg+$04).w
		moveq	#8,d0
		move.w	#$F0,d6
		bra.s	FBZ_BGChangeGoIn
; ---------------------------------------------------------------------------

locK_52C98:
		st	(Events_bg+$04).w
		moveq	#4,d0
		moveq	#0,d6
		bra.s	FBZ_BGChangeGoOut
; ---------------------------------------------------------------------------

FBZ1_BGChange6:
		tst.w	(Events_bg+$04).w
		bne.s	locK_52CB2
		cmpi.w	#$640,d1
		blo.w	FBZ_Deform
		bra.s	locK_52CC4
; ---------------------------------------------------------------------------

locK_52CB2:
		cmpi.w	#$640,d1
		bhi.w	FBZ_Deform
		clr.w	(Events_bg+$04).w
		moveq	#4,d0
		moveq	#0,d6
		bra.s	FBZ_BGChangeGoIn
; ---------------------------------------------------------------------------

locK_52CC4:
		st	(Events_bg+$04).w
		moveq	#8,d0
		move.w	#$F0,d6

FBZ_BGChangeGoOut:
		lea	Pal_FBZBGOutdoors(pc),a1
		bra.s	locK_52CD8
; ---------------------------------------------------------------------------

FBZ_BGChangeGoIn:
		lea	Pal_FBZBGIndoors(pc),a1

locK_52CD8:
		lea	(Normal_palette_line_4+$4).w,a5
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+			; Modify the palette as needed
		move.w	d0,(Events_routine_bg).w	; Set the appropriate BG event to handle the change
		jsr	FBZ_Deform(pc)			; Do deformation as normal
		jsr	Reset_TileOffsetPositionEff(pc)
		add.w	d6,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,sp				; Finish here without doing anything else
		cmpi.w	#4,(Events_routine_bg).w
		beq.w	locK_528DE
		bra.w	locK_52904
; ---------------------------------------------------------------------------

Obj_FBZOutdoorBGMotion:
		move.l	#$2800,d0			; Uses built-in bobbing motion function to move BG up and down
		move.l	#$80,d1
		jsr	(Gradual_SwingOffset).l
		move.w	d0,(Events_bg+$08).w
		rts
; ---------------------------------------------------------------------------
FBZ_InBGDeformArray:
		dc.w    $80
		dc.w    $40
		dc.w    $20
		dc.w      8
		dc.w      8
		dc.w      8
		dc.w      8
		dc.w    $28
		dc.w    $30
		dc.w      8
		dc.w      4
		dc.w      4
		dc.w    $B8
		dc.w    $30
		dc.w    $10
		dc.w    $10
		dc.w    $30
		dc.w    $28
		dc.w    $18
		dc.w    $10
		dc.w    $30
		dc.w    $30
		dc.w    $10
		dc.w    $10
		dc.w    $30
		dc.w    $28
		dc.w    $18
		dc.w    $10
		dc.w    $B0
		dc.w    $30
		dc.w    $28
		dc.w    $40
		dc.w    $18
		dc.w    $30
		dc.w  $7FFF
FBZ_OutBGDeformArray:
		dc.w    $30
		dc.w    $20
		dc.w    $30
		dc.w    $10
		dc.w    $10
		dc.w    $10
		dc.w    $10
		dc.w    $10
		dc.w  $7FFF
FBZ_InBGDeformIndex:
		dc.b  1-1,  $C
		dc.b  2-1,  $A, $16
		dc.b $B-1,   8, $14, $18, $1C, $20, $24, $28, $2C, $30, $34, $38
		dc.b  3-1,   6, $12, $3E
		dc.b  1-1, $46
		dc.b  8-1,   4, $10, $1E, $26, $2E, $36, $3A, $40
		dc.b  4-1,  $E, $22, $32, $3C
		dc.b  2-1,   0, $44
		dc.b  4-1,   2, $1A, $2A, $42
		dc.b  $FF
		even
FBZ_OutBGDeformIndex:
		dc.w     $E
		dc.w      2
		dc.w     $A
		dc.w      6
		dc.w     $C
		dc.w      4
		dc.w      8
		dc.w      0
		dc.w    $10
Pal_FBZBGIndoors:
		binclude "Levels/FBZ/Palettes/FBZ BG Indoors.bin"
		even
Pal_FBZBGOutdoors:
		binclude "Levels/FBZ/Palettes/FBZ BG Outdoors.bin"
		even
; ---------------------------------------------------------------------------

FBZ2_ScreenInit:
		move.w	#$2C40,d0
		cmp.w	(Camera_X_pos).w,d0
		bhi.s	locK_52E2C
		move.w	#4,(Events_routine_fg).w	; If screen X is past subboss battle, change screen event
		move.w	d0,(Camera_min_X_pos).w
		jsr	SetUp_FBZ2BossEvent(pc)
		clr.l	(_unkEE98).w
		clr.l	(_unkEE9C).w		; Clear BG camera offset
		move.w	#VRAM_Plane_B_Name_Table,d7
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(ArtKosM_FBZCloud).l,a1
		move.w	#tiles_to_bytes(ArtTile_FBZCloud),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_FBZBossPillar).l,a1
		move.w	#tiles_to_bytes(ArtTile_FBZBossPillar),d2
		jsr	(Queue_Kos_Module).l	; Load boss event graphics
		movem.l	(sp)+,d7-a0/a2-a3

locK_52E2C:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

FBZ2_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	(Events_routine_fg).w,d0
		jmp	FBZ2_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

FBZ2_ScreenEvent_Index:
		bra.w	FBZ2SE_Normal
; ---------------------------------------------------------------------------
		bra.w	FBZ2SE_BossEvent
; ---------------------------------------------------------------------------
		bra.w	FBZ2SE_BossEventRefresh
; ---------------------------------------------------------------------------
		bra.w	FBZ2SE_BossEventEnd
; ---------------------------------------------------------------------------

FBZ2SE_Normal:
		cmpi.b	#6,(Player_1+routine).w
		blo.s	locK_52E5E
		rts
; ---------------------------------------------------------------------------

locK_52E5E:
		lea	FBZ2_LayoutModRange(pc),a1		; Only one layout mod this time around
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		move.w	(Events_bg+$00).w,d2
		jmp	locK_52E72(pc,d2.w)
; ---------------------------------------------------------------------------

locK_52E72:
		bra.w	FBZ2_NoLayoutMod
; ---------------------------------------------------------------------------
		bra.w	FBZ2_LayoutMod1
; ---------------------------------------------------------------------------

FBZ2_NoLayoutMod:
		cmp.w	(a1)+,d0
		blo.s	locK_52E90
		cmp.w	(a1)+,d0
		bhi.s	locK_52E90
		cmp.w	(a1)+,d1
		blo.s	locK_52E90
		cmp.w	(a1)+,d1
		bhi.s	locK_52E90
		move.w	#4,(Events_bg+$00).w

locK_52E90:
		jsr	DrawTilesAsYouMove(pc)
		cmpi.w	#$2B30,(Camera_X_pos).w
		blo.s	locretK_52EAC
		jsr	SetUp_FBZ2BossEvent(pc)		; If Player passes certain point, set up the boss event
		clr.l	(_unkEE98).w
		clr.l	(_unkEE9C).w
		addq.w	#4,(Events_routine_fg).w

locretK_52EAC:
		rts
; ---------------------------------------------------------------------------

FBZ2_LayoutMod1:
		jsr	FBZ1Screen_CheckInRange(pc)
		cmpi.w	#$E00,d0
		blo.s	locK_52EBE
		cmpi.w	#$1280,d0
		bls.s	locK_52F10

locK_52EBE:
		tst.w	(Events_bg+$02).w
		bne.s	locK_52ECC
		cmpi.w	#$B0E,d1		; If indoors
		bls.s	locK_52F10
		bra.s	locK_52EDE
; ---------------------------------------------------------------------------

locK_52ECC:
		cmpi.w	#$AF2,d1		; If outdoors
		bhi.s	locK_52F10
		clr.w	(Events_bg+$02).w
		movea.w	(a3),a5
		lea	$70(a5),a5
		bra.s	locK_52EEA
; ---------------------------------------------------------------------------

locK_52EDE:
		st	(Events_bg+$02).w
		movea.w	$10(a3),a5
		lea	$70(a5),a5

locK_52EEA:
		movea.w	$50(a3),a1
		lea	$1A(a1),a1
		move.w	-8(a3),d0
		subi.w	#$E,d0		; Width of 14 tiles
		moveq	#4-1,d1		; Height of 4 tiles

locK_52EFC:
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		move.w	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,locK_52EFC
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

locK_52F10:
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

FBZ2SE_BossEvent:
		move.w	#VRAM_Plane_B_Name_Table,d7			; Draw FG tiles on BG plane instead
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

FBZ2SE_BossEventRefresh:
		move.w	#VRAM_Plane_B_Name_Table,d7
		move.w	#$2D00,d1
		moveq	#0,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	FBZ2SE_BossEventEnd
		addq.w	#4,(Events_routine_fg).w

FBZ2SE_BossEventEnd:
		rts

; =============== S U B R O U T I N E =======================================


SetUp_FBZ2BossEvent:
		jsr	(AllocateObject).l
		bne.s	locK_52F7A
		move.l	#Obj_FBZEndBossEventControl,(a1)
		jsr	(CreateNewSprite4).l
		bne.s	locK_52F7A
		move.l	#Obj_FBZBossPillar,(a1)
		lea	(FBZ_cloud_addr).w,a5
		moveq	#0,d1
		moveq	#5-1,d2

locK_52F56:
		move.l	d1,(a5)+		; Reset object addresses for clouds
		dbf	d2,locK_52F56
		lea	(FBZ_cloud_addr).w,a5
		moveq	#$A-1,d1

locK_52F62:
		jsr	(CreateNewSprite4).l
		bne.s	locK_52F7A
		move.w	a1,(a5)+
		move.l	#Obj_FBZCloud,(a1)	; Create cloud objects and place addresses in FFEEEA
		move.w	d1,$2E(a1)
		dbf	d1,locK_52F62

locK_52F7A:
		lea	Pal_FBZBGOutdoors(pc),a1	; Modify palette
		lea	(Normal_palette_line_4+$2).w,a5
		lea	(Target_palette_line_4+$2).w,a6
		move.w	#$EEE,(a5)+
		move.w	#$EEE,(a6)+
		move.l	(a1),(a5)+
		move.l	(a1)+,(a6)+
		move.l	(a1),(a5)+
		move.l	(a1)+,(a6)+
		move.l	(a1),(a5)+
		move.l	(a1)+,(a6)+
		move.l	(a1),(a5)+
		move.l	(a1)+,(a6)+
		rts
; End of function SetUp_FBZ2BossEvent

; ---------------------------------------------------------------------------
FBZ2_LayoutModRange:
		dc.w   $D80, $1300,  $A00,  $B80
; ---------------------------------------------------------------------------

FBZ2_BackgroundInit:
		jsr	(AllocateObject).l
		bne.s	locK_52FB6
		move.l	#Obj_FBZOutdoorBGMotion,(a1)

locK_52FB6:
		cmpi.w	#$2C40,(Camera_X_pos).w
		blo.s	locK_53002
		move.w	#$10,(Events_routine_bg).w		; If in boss event area, set BG event
		move.w	(a3),d0
		move.w	d0,$70(a3)			; Copy top BG line to bottom BG line (I guess so the scrolling doesn't garble the screen?)
		move.w	d0,$74(a3)
		move.w	d0,$78(a3)
		move.w	d0,$7C(a3)
		st	(Screen_shake_flag).w			; Start shaking
		move.w	#VRAM_Plane_A_Name_Table,d7
		jsr	FBZ2_CloudDeform(pc)	; Deform the cloud sprites
		jsr	Reset_TileOffsetPositionEff(pc)
		jsr	Refresh_PlaneFull(pc)
		jsr	PlainDeformation_Flipped(pc)	; Reverse deformation
		jsr	Get_BGActualEffectiveDiff(pc)
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp
		rts
; ---------------------------------------------------------------------------

locK_53002:
		jsr	FBZ_Deform(pc)			; Normal play
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	FBZ_InBGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

FBZ2_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	FBZ2_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

FBZ2_BackgroundEvent_Index:
		bra.w	FBZ2BGE_Init
; ---------------------------------------------------------------------------
		bra.w	FBZ2BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	FBZ2BGE_ChangeTopDown
; ---------------------------------------------------------------------------
		bra.w	FBZ2BGE_ChangeBottomUp
; ---------------------------------------------------------------------------
		bra.w	FBZ2BGE_BossEvent
; ---------------------------------------------------------------------------

FBZ2BGE_ChangeTopDown:
		jsr	FBZ2_CheckBGChange(pc)

locK_5303C:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		tst.w	(Events_bg+$04).w
		beq.s	locK_5304E
		move.w	#$200,d1
		moveq	#0,d2

locK_5304E:
		jsr	Draw_PlaneVertTopDown(pc)
		bpl.s	locK_530BA
		move.w	#4,(Events_routine_bg).w
		bra.s	locK_530BA
; ---------------------------------------------------------------------------

FBZ2BGE_ChangeBottomUp:
		jsr	FBZ2_CheckBGChange(pc)

locK_53060:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		tst.w	(Events_bg+$04).w
		beq.s	locK_53072
		move.w	#$200,d1
		moveq	#0,d2

locK_53072:
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.s	locK_530BA
		move.w	#4,(Events_routine_bg).w
		bra.s	locK_530BA
; ---------------------------------------------------------------------------

FBZ2BGE_Init:
		move.w	(a3),d0
		move.w	d0,$70(a3)
		move.w	d0,$74(a3)
		move.w	d0,$78(a3)
		move.w	d0,$7C(a3)			; Copy BG lines
		addq.w	#4,(Events_routine_bg).w	; Next BG Event

FBZ2BGE_Normal:
		tst.w	(Events_routine_fg).w
		beq.s	locK_530AC
		jsr	FBZ2_CloudDeform(pc)	; If boss event has started
		jsr	Reset_TileOffsetPositionEff(pc)
		move.w	#$10,(Events_routine_bg).w
		bra.s	locK_530F0
; ---------------------------------------------------------------------------

locK_530AC:
		cmpi.b	#6,(Player_1+routine).w
		blo.s	locK_530B6			; Don't change BG if dying
		rts
; ---------------------------------------------------------------------------

locK_530B6:
		jsr	FBZ2_CheckBGChange(pc)

locK_530BA:
		move.w	(Events_bg+$04).w,d1
		beq.s	locK_530C4
		move.w	#$200,d1

locK_530C4:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	FBZ_InBGDeformArray(pc),a4
		tst.w	(Events_bg+$04).w
		beq.s	locK_530E0
		lea	FBZ_OutBGDeformArray(pc),a4

locK_530E0:
		lea	(HScroll_table).w,a5
		jsr	ApplyDeformation(pc)
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

FBZ2BGE_BossEvent:
		jsr	FBZ2_CloudDeform(pc)

locK_530F0:
		move.w	#VRAM_Plane_A_Name_Table,d7
		jsr	DrawBGAsYouMove(pc)		; Draw BG on plane A
		jsr	PlainDeformation_Flipped(pc)
		jsr	Get_BGActualEffectiveDiff(pc)
		jsr	ShakeScreen_Setup(pc)
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp
		tst.w	(Events_bg+$06).w
		beq.s	locretK_5318A
		clr.w	(Events_bg+$06).w		; If boss has been loaded
		move.w	(_unkEE9C).w,d0
		clr.w	(_unkEE9C).w		; Get final Y offset and clear it
		btst	#Status_InAir,(Player_1+status).w
		beq.s	locK_53134
		add.w	d0,(Player_1+y_pos).w	; If player is not on ground, adjust his Y position properly
		add.w	d0,(Player_2+y_pos).w

locK_53134:
		add.w	d0,(Camera_Y_pos).w
		add.w	d0,(Camera_Y_pos_copy).w
		add.w	d0,(Camera_min_Y_pos).w
		add.w	d0,(Camera_max_Y_pos).w	; Add offset to camera Ys
		move.w	(Camera_max_Y_pos).w,(Camera_target_max_Y_pos).w
		move.w	(_unkEE98).w,d0
		clr.w	(_unkEE98).w
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d0,(Player_2+x_pos).w	; Adjust X position of players
		sub.w	d0,(Camera_X_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w	; and of cameras
		movea.w	(Level_layout_main+$2C).w,a1	; $580 Y of FG
		lea	$5C(a1),a1				; $2D00 X of FG
		move.w	(Level_layout_header).w,d0
		subi.w	#$14,d0
		moveq	#4-1,d1

locK_5317C:
		moveq	#$14-1,d2

locK_5317E:
		clr.b	(a1)+				; Clear large area of FG, probably erasing the copied FG area from the layout mod
		dbf	d2,locK_5317E
		adda.w	d0,a1
		dbf	d1,locK_5317C

locretK_5318A:
		rts

; =============== S U B R O U T I N E =======================================


FBZ2_CloudDeform:
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$300,d0
		add.w	(_unkEE9C).w,d0		; Add camera BG Y to Y event offset
		move.w	d0,(Camera_Y_pos_BG_copy).w		; Make that the effective Y
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$2600,d0
		sub.w	(_unkEE98).w,d0
		move.w	d0,(Camera_X_pos_BG_copy).w		; Do the same with the X values
		lea	(HScroll_table).w,a1
		lea	FBZ2_CloudDeformIndex(pc),a5
		move.w	(Camera_X_pos_BG_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		asr.l	#2,d1
		move.l	(HScroll_table+$1FC).w,d2
		asr.l	#3,d2
		addi.l	#$8000,(HScroll_table+$1FC).w	; Perform cloud movement
		moveq	#$A-1,d3

locK_531D2:
		move.w	(a5)+,d4
		add.l	d2,d0
		swap	d0
		move.w	d0,(a1,d4.w)		; Set up cloud speeds
		swap	d0
		add.l	d1,d0
		dbf	d3,locK_531D2
		lea	(HScroll_table).w,a1
		lea	(FBZ_cloud_addr).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	(Screen_shake_offset).w,d1
		sub.w	d1,d0
		asr.w	#1,d0
		add.w	d1,d0
		neg.w	d0
		add.w	(Events_bg+$08).w,d0	; Get effective Y, add BG motion offset to it
		moveq	#$A-1,d1

locK_53202:
		move.w	(a5)+,d2
		beq.s	locK_5322E
		movea.w	d2,a6			; Load cloud address
		move.w	$30(a6),d3		; Get Y position
		add.w	d0,d3			; Add offset
		andi.w	#$FF,d3
		addi.w	#$74,d3
		move.w	d3,$14(a6)		; Load to actual Y
		move.w	(a1)+,d3
		neg.w	d3
		add.w	$2E(a6),d3
		andi.w	#$1FF,d3
		addi.w	#$54,d3
		move.w	d3,$10(a6)		; Do the same to the X

locK_5322E:
		dbf	d1,locK_53202
		rts
; End of function FBZ2_CloudDeform


; =============== S U B R O U T I N E =======================================


FBZ2_CheckBGChange:
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		move.w	(Events_bg+$00).w,d2		; You know how this goes by now
		jmp	FBZ2_CheckBGChange_Index(pc,d2.w)
; End of function FBZ1_CheckBGChange

; ---------------------------------------------------------------------------

FBZ2_CheckBGChange_Index:
		bra.w	FBZ_Deform
; ---------------------------------------------------------------------------
		tst.w	(Events_bg+$04).w
		bne.s	locK_53258
		cmpi.w	#$A40,d1
		blo.w	FBZ_Deform
		bra.s	locK_5326A
; ---------------------------------------------------------------------------

locK_53258:
		cmpi.w	#$A40,d1
		bhi.w	FBZ_Deform
		clr.w	(Events_bg+$04).w
		moveq	#8,d0
		moveq	#0,d6
		bra.s	locK_5327A
; ---------------------------------------------------------------------------

locK_5326A:
		st	(Events_bg+$04).w
		moveq	#$C,d0
		move.w	#$F0,d6
		lea	Pal_FBZBGOutdoors(pc),a1
		bra.s	locK_5327E
; ---------------------------------------------------------------------------

locK_5327A:
		lea	Pal_FBZBGIndoors(pc),a1

locK_5327E:
		lea	(Normal_palette_line_4+$4).w,a5
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.w	d0,(Events_routine_bg).w
		jsr	FBZ_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		add.w	d6,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,sp
		cmpi.w	#8,(Events_routine_bg).w
		beq.w	locK_5303C
		bra.w	locK_53060
; ---------------------------------------------------------------------------

Obj_FBZEndBossEventControl:
		move.l	#locK_532E0,(a0)
		move.b	#$11,height_pixels(a0)
		bset	#7,status(a0)
		move.w	#$32B8,(Camera_max_X_pos).w		; Set $32B8 as the X end
		move.w	#$3C,d0
		cmpi.w	#2,(Player_mode).w
		bne.s	locK_532DC
		addq.w	#4,d0

locK_532DC:
		move.w	d0,(Camera_min_Y_pos).w		; Set level Y start depending on whether Tails is playing or not. I guess this is because Tails' center point is slightly lower than Sonic's

locK_532E0:
		cmpi.w	#$2E80,(Player_1+x_pos).w
		blo.w	locK_533A4
		move.l	#locK_532F0,(a0)			; If Sonic has passed $2E80 X, start moving the BG

locK_532F0:
		st	(Background_collision_flag).w				; Set BG collision on
		addi.l	#$A000,(_unkEE9C).w
		addi.l	#$7800,(_unkEE98).w	; Move the extra BG camera by a set amount
		cmpi.w	#$5D0,(_unkEE9C).w
		blo.s	locK_5333A
		move.w	#$5D0,(_unkEE9C).w		; When BG has reached end point
		move.w	#$45C,(_unkEE98).w
		clr.b	(Background_collision_flag).w			; Stop BG collision
		move.l	#locK_53322,(a0)

locK_53322:
		move.w	(Camera_min_Y_pos).w,d0
		cmp.w	(Camera_Y_pos).w,d0
		bne.s	locK_5333A
		move.w	d0,(Camera_max_Y_pos).w		; Lock screen when camera has scrolled as high as possible
		move.w	d0,(Camera_target_max_Y_pos).w
		move.l	#locK_5333A,(a0)

locK_5333A:
		cmpi.w	#$280,(Player_1+y_pos).w
		bhs.s	locK_53348
		move.w	(Camera_X_pos).w,(Camera_min_X_pos).w	; If player is above $280 Y then lock screen X as you move

locK_53348:
		move.w	(Camera_min_Y_pos).w,d0
		cmp.w	(Camera_max_Y_pos).w,d0
		bne.s	locK_533A4
		move.w	(Camera_max_X_pos).w,d0
		cmp.w	(Camera_min_X_pos).w,d0
		bne.s	locK_533A4
		move.w	#$F0,(Draw_delayed_position).w		; When the screen is completely locked, start proper Screen Events
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_fg).w		; Next screen event
		move.l	#locK_53372,(a0)

locK_53372:
		cmpi.w	#$C,(Events_routine_fg).w
		bne.s	locK_533A4
		jsr	(AllocateObject).l
		bne.s	locK_53388				; When screen event has finished, load the boss
		move.l	#Obj_FBZEndBoss,(a1)

locK_53388:
		clr.w	(Screen_shake_flag).w			; Stop shaking
		st	(Events_bg+$06).w				; Set variable when boss has loaded
		move.w	#$31C0,d0
		move.w	#$31C0,d4
		move.w	#$690,d1
		move.l	#locK_533A4,(a0)
		bra.s	locK_533B8
; ---------------------------------------------------------------------------

locK_533A4:
		move.w	x_pos(a0),d4
		move.w	#$31C0,d0
		add.w	(_unkEE98).w,d0
		move.w	#$690,d1
		sub.w	(_unkEE9C).w,d1

locK_533B8:
		move.w	d0,x_pos(a0)
		move.w	d1,y_pos(a0)
		move.w	#$4C0,d1
		moveq	#$11,d2
		moveq	#$11,d3
		jmp	(SolidObjectTop).l
; ---------------------------------------------------------------------------

Obj_FBZBossPillar:
		move.l	#Obj_FBZBossPillarMain,(a0)
		move.b	#$44,render_flags(a0)		; Set up boss pillar object
		move.b	#$FF,height_pixels(a0)
		move.b	#$20,width_pixels(a0)
		move.w	#$300,priority(a0)
		move.w	#make_art_tile(ArtTile_FBZBossPillar,2,1),art_tile(a0)
		move.l	#Map_FBZ2Preboss,mappings(a0)
		move.w	#2,mainspr_childsprites(a0)	; 2 sprites

Obj_FBZBossPillarMain:
		move.w	#$2DE0,d4
		add.w	(_unkEE98).w,d4
		move.w	d4,x_pos(a0)			; Move pillar to proper X area
		move.w	d4,d0
		move.w	d4,d1
		subi.w	#$200,d0
		tst.w	$30(a0)
		beq.s	locK_5341E
		addi.w	#$28,d1

locK_5341E:
		move.w	#$580,d5
		sub.w	(_unkEE9C).w,d5	; Get proper Y offset
		move.w	d5,d2
		move.w	d5,d3
		addi.w	#$80,d2
		addi.w	#$100,d3
		clr.w	$30(a0)
		lea	(Player_1).w,a1
		bsr.s	FBZBossPillar_CheckPlayerPos
		lea	(Player_2).w,a1
		bsr.s	FBZBossPillar_CheckPlayerPos
		tst.w	$30(a0)
		beq.s	locK_53456
		cmpi.w	#$40,$2E(a0)	; If player is in range, increase pillar offset
		bhs.s	locK_5346A
		addq.w	#8,$2E(a0)
		bra.s	locK_5346A
; ---------------------------------------------------------------------------

locK_53456:
		tst.w	$2E(a0)
		beq.s	locK_5346A
		subq.w	#8,$2E(a0)		; If player is not in range, decrease pillar offset
		bne.s	locK_5346A
		moveq	#signextendB(sfx_SpikeBalls),d0		; Play sound only when pillar hits ground
		jsr	(Play_SFX).l

locK_5346A:
		sub.w	$2E(a0),d5
		move.w	d5,y_pos(a0)		; Subtract Y from offset and place it in sprite Y
		lea	sub2_x_pos(a0),a1
		addi.w	#$80,d5
		moveq	#1,d0

locK_5347C:
		move.w	d4,(a1)
		move.w	d5,sub2_y_pos-sub2_x_pos(a1)
		subi.w	#$100,d5		; Set the sprite positions of each pillar sprite
		addq.w	#6,a1
		dbf	d0,locK_5347C
		moveq	#$2B,d1
		move.w	#$100,d2
		move.w	#$100,d3
		jsr	(SolidObjectFull).l	; Make it solid
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


FBZBossPillar_CheckPlayerPos:
		move.w	x_pos(a1),d6
		cmp.w	d0,d6
		blt.s	.return
		cmp.w	d1,d6
		bhs.s	.return
		move.w	y_pos(a1),d6
		cmp.w	d2,d6
		blo.s	.return
		cmp.w	d3,d6
		bhs.s	.return
		tst.b	$2E(a1)
		bmi.s	.return
		st	$30(a0)

.return:
		rts
; End of function FBZBossPillar_CheckPlayerPos

; ---------------------------------------------------------------------------

Obj_FBZCloud:
		move.l	#Draw_Sprite,(a0)
		move.b	#$40,render_flags(a0)		; Multisprite routine
		move.b	#$C,height_pixels(a0)
		move.b	#$2C,width_pixels(a0)
		move.w	#$380,priority(a0)
		move.w	#make_art_tile(ArtTile_FBZCloud,3,0),art_tile(a0)
		move.l	#Map_FBZ2Preboss,mappings(a0)
		move.w	$2E(a0),d0
		add.w	d0,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		lea	FBZCloud_PositionFrameData(pc),a1
		adda.w	d0,a1
		move.w	(a1)+,$2E(a0)
		move.w	(a1)+,$30(a0)
		move.w	(a1),d0
		move.b	d0,mapping_frame(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Map_FBZ2Preboss:
		include "Levels/FBZ/Misc Object Data/Map - Act 2 Preboss.asm"
FBZ2_CloudDeformIndex:
		dc.w      4
		dc.w     $E
		dc.w      8
		dc.w    $10
		dc.w      2
		dc.w     $C
		dc.w      6
		dc.w    $12
		dc.w     $A
		dc.w      0
FBZCloud_PositionFrameData:
		dc.w   $1E0,   $EC,     1
		dc.w   $144,   $C8,     2
		dc.w    $60,   $B4,     3
		dc.w    $C4,   $A0,     2
		dc.w   $140,   $84,     1
		dc.w   $1A0,   $6C,     3
		dc.w    $F0,   $54,     1
		dc.w   $160,   $3C,     3
		dc.w    $7C,   $28,     2
		dc.w    $20,    $C,     1