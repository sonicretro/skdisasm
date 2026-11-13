; ---------------------------------------------------------------------------

Obj_TitleCard:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	TitleCard_Index(pc,d0.w),d1
		jmp	TitleCard_Index(pc,d1.w)
; ---------------------------------------------------------------------------
TitleCard_Index:
		dc.w Obj_TitleCardInit-TitleCard_Index
		dc.w Obj_TitleCardCreate-TitleCard_Index
		dc.w Obj_TitleCardWait-TitleCard_Index
		dc.w Obj_TitleCardWait2-TitleCard_Index
; ---------------------------------------------------------------------------

Obj_TitleCardInit:
	if ~~Sonic3_Alone
		cmpi.w	#$D01,(Current_zone_and_act).w
		beq.s	locK_2D6C2			; if we're in the ending, don't show title card
	endif
		cmpi.b	#$E,(Current_zone).w
		blo.s	locK_2D6C8			; If in any of the 2P stages, don't show title card
		cmpi.b	#$12,(Current_zone).w
		bhi.s	locK_2D6C8
		st	$44(a0)

locK_2D6C2:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
; loc3_2CA96:
locK_2D6C8:
		lea	(ArtKosM_TitleCardRedAct).l,a1
		move.w	#tiles_to_bytes($500),d2
		jsr	(Queue_Kos_Module).l
	if Sonic3_Alone
		lea	(ArtKosM_TitleCardNum1).l,a1
		tst.b	(Apparent_act).w
		beq.s	locK_2D716
		lea	(ArtKosM_TitleCardNum2).l,a1
	else
		lea	(ArtKosM_TitleCardSKZone).l,a1
		tst.w	(SK_alone_flag).w
		bne.s	locK_2D6EA
		lea	(ArtKosM_TitleCardS3KZone).l,a1

locK_2D6EA:
		move.w	#tiles_to_bytes($510),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_TitleCardNum2).l,a1
		cmpi.w	#$1600,(Current_zone_and_act).w
		beq.s	locK_2D716
		cmpi.w	#$1700,(Current_zone_and_act).w
		beq.s	locK_2D716		; Death Egg Boss and LRZ Boss show act 2
		tst.b	(Apparent_act).w
		bne.s	locK_2D716
		lea	(ArtKosM_TitleCardNum1).l,a1
	endif
; loc3_2CAB8:
locK_2D716:
		move.w	#tiles_to_bytes($53D),d2
		jsr	(Queue_Kos_Module).l
		lea	TitleCard_LevelGfx(pc),a1
	if Sonic3_Alone
		moveq	#0,d0
		move.b	(Apparent_zone).w,d0
	else
		moveq	#9,d0
		cmpi.w	#$1600,(Current_zone_and_act).w	; If in LRZ's boss, set it to Lava Reef's card
		beq.s	locK_2D746
		moveq	#$D,d0
		cmpi.w	#$1601,(Current_zone_and_act).w	; If in Hidden Palace, set it to its card
		beq.s	locK_2D746
		moveq	#$B,d0
		cmpi.w	#$1700,(Current_zone_and_act).w	; If in Death Egg boss, set it to Death Egg's card
		beq.s	locK_2D746
		move.b	(Apparent_zone_and_act).w,d0		; Otherwise, just use current zone

locK_2D746:
	endif
		lsl.w	#2,d0
		movea.l	(a1,d0.w),a1
		move.w	#tiles_to_bytes($54D),d2
		jsr	(Queue_Kos_Module).l
		move.w	#90,$2E(a0)			; Set wait value
		clr.w	$32(a0)
		st	$48(a0)
		addq.b	#2,routine(a0)
		rts
; ---------------------------------------------------------------------------

Obj_TitleCardCreate:
		tst.b	(Kos_modules_left).w
		bne.w	locretK_2D802		; Wait for KosM queue to clear
		jsr	(AllocateObjectAfterCurrent).l
	if Sonic3_Alone
		bne.s	locretK_2D802
	else
		bne.w	locretK_2D802
		cmpi.b	#$16,(Current_zone).w
		beq.s	locK_2D79A
		cmpi.w	#$1700,(Current_zone_and_act).w
		beq.s	locK_2D79A
	endif
		lea	ObjArray_TtlCardBonus(pc),a2
		moveq	#1,d1
		cmpi.b	#$13,(Current_zone).w
		bhs.s	locK_2D7AC

locK_2D79A:
		lea	ObjArray_TtlCard(pc),a2
		moveq	#3,d1
		tst.b	$44(a0)
		beq.s	locK_2D7AC
		lea	ObjArray_TtlCard2(pc),a2
		moveq	#0,d1
; loc3_2CB20:
locK_2D7AC:
		addq.w	#1,$30(a0)
		move.l	(a2)+,(a1)
		move.w	(a2)+,$46(a1)
		move.w	(a2)+,x_pos(a1)
		move.w	(a2)+,y_pos(a1)
		move.b	(a2)+,mapping_frame(a1)
		move.b	(a2)+,width_pixels(a1)
		move.w	(a2)+,d2
		move.b	d2,$28(a1)
		move.b	#$40,render_flags(a1)
		move.l	#Map_TitleCard,mappings(a1)
		move.w	a0,parent2(a1)
		jsr	(CreateNewSprite4).l
		dbne	d1,locK_2D7AC
		tst.b	$3E(a0)
		beq.s	locK_2D7FE
	if Sonic3_Alone
		cmpi.b	#6,(Apparent_zone).w
	else
		cmpi.b	#6,(Current_zone).w
	endif
		bne.s	locK_2D7FE
		moveq	#PLCID_25,d0			; If title card is mid-level and it's in LBZ, load the LBZ 2 misc art
		jsr	(Load_PLC).l
; loc3_2CB72:
locK_2D7FE:
		addq.b	#2,routine(a0)
; locret3_2CB76:
locretK_2D802:
		rts
; ---------------------------------------------------------------------------

Obj_TitleCardWait:
		tst.w	$34(a0)
		beq.s	locK_2D810
		clr.w	$34(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_2CB84:
locK_2D810:
		tst.w	$3E(a0)
		beq.s	locK_2D84C
		clr.l	(Timer).w			; If using in-level title card
		clr.w	(Ring_count).w			; Reset HUD rings and timer
		clr.w	(Total_ring_count).w		; Reset number of collected rings
		clr.b	(Extra_life_flags).w		; Reset extra life ring flag
		clr.l	(Timer_P2).w
		clr.w	(Ring_count_P2).w		; Reset actual rings and timer values
		clr.w	(Total_ring_count_P2).w
		st	(Update_HUD_timer).w
		st	(Update_HUD_ring_count).w	; Start updating timer and rings again
		move.b	#30,(Player_1+air_left).w
		move.b	#30,(Player_2+air_left).w	; Reset air
		jsr	(Restore_LevelMusic).l		; Play music
; loc3_2CBC0:
locK_2D84C:
		clr.w	$48(a0)
		addq.b	#2,routine(a0)
		rts
; ---------------------------------------------------------------------------

Obj_TitleCardWait2:
		tst.w	$2E(a0)
		beq.s	locK_2D862
		subq.w	#1,$2E(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_2CBD6:
locK_2D862:
		tst.w	$30(a0)
		beq.s	locK_2D86E
		addq.w	#1,$32(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_2CBE2:
locK_2D86E:
		tst.b	$44(a0)
		bne.s	locK_2D8DC
	if ~~Sonic3_Alone
		cmpi.w	#$801,(Current_zone_and_act).w
		bne.s	locK_2D88A
		jsr	(AllocateObject).l
		bne.s	locK_2D88A
		move.l	#Hyudoro,(a1)	; If new level is Sandopolis 2, then load the ghosts

locK_2D88A:
		cmpi.b	#$16,(Current_zone).w
		beq.s	locK_2D8A2
		cmpi.w	#$1700,(Current_zone_and_act).w
		beq.s	locK_2D8A2
	endif
		cmpi.b	#$13,(Current_zone).w
		bhs.s	locK_2D8DC

locK_2D8A2:
		tst.w	$3E(a0)
		beq.s	locK_2D8AE
		st	(End_of_level_flag).w	; If in-level, set end of title card flag. No need to reload PLCs
		bra.s	locK_2D8CA
; ---------------------------------------------------------------------------
; loc3_2CBFC:
locK_2D8AE:
	if ~~Sonic3_Alone
		cmpi.b	#$C,(Current_zone).w
		beq.s	locK_2D8DC
		cmpi.w	#$1700,(Current_zone_and_act).w
		beq.s	locK_2D8DC
	endif
		lea	(PLC_SpikesSprings).l,a1	; Reload spikes in all but DEZ boss and Doomsday
		jsr	(Load_PLC_Raw).l
; loc3_2CC08:
locK_2D8CA:
	if ~~Sonic3_Alone
		cmpi.w	#$1700,(Current_zone_and_act).w
		beq.s	locK_2D8DC
	endif
		jsr	LoadEnemyArt(pc)		; Load animals and enemies in all but DEZ boss
		jsr	(PLCLoad_AnimalsAndExplosion).l
; loc3_2CC12:
locK_2D8DC:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_TitleCardRedBanner:
		movea.w	parent2(a0),a1
		move.w	$32(a1),d0
		beq.s	locK_2D90A
		tst.b	render_flags(a0)
		bmi.s	locK_2D8FC
		subq.w	#1,$30(a1)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
; loc3_2CC32:
locK_2D8FC:
		cmp.b	$28(a0),d0
		blo.s	locK_2D920
		subi.w	#$20,y_pos(a0)
		bra.s	locK_2D920
; ---------------------------------------------------------------------------
; loc3_2CC40:
locK_2D90A:
		move.w	y_pos(a0),d0
		cmp.w	$46(a0),d0
		beq.s	locK_2D920
		addi.w	#$10,d0
		move.w	d0,y_pos(a0)
		st	$34(a1)
; loc3_2CC56:
locK_2D920:
		move.b	#$70,height_pixels(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_TitleCardName:
		move.b	(Apparent_zone).w,d0
		add.b	d0,mapping_frame(a0)
	if ~~Sonic3_Alone
		moveq	#$D,d0
		cmpi.w	#$1600,(Current_zone_and_act).w
		beq.s	locK_2D952
		moveq	#$11,d0
		cmpi.w	#$1601,(Current_zone_and_act).w
		beq.s	locK_2D952
		moveq	#$F,d0
		cmpi.w	#$1700,(Current_zone_and_act).w
		bne.s	locK_2D956

locK_2D952:
		move.b	d0,mapping_frame(a0)

locK_2D956:
	endif
		move.l	#Obj_TitleCardElement,(a0)

Obj_TitleCardElement:
		movea.w	parent2(a0),a1
		move.w	$32(a1),d0
		beq.s	locK_2D984
		tst.b	render_flags(a0)
		bmi.s	locK_2D976
		subq.w	#1,$30(a1)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
; loc3_2CC8A:
locK_2D976:
		cmp.b	$28(a0),d0
		blo.s	locK_2D99A
		addi.w	#$20,x_pos(a0)
		bra.s	locK_2D99A
; ---------------------------------------------------------------------------
; loc3_2CC98:
locK_2D984:
		move.w	x_pos(a0),d0
		cmp.w	$46(a0),d0
		beq.s	locK_2D99A
		subi.w	#$10,d0
		move.w	d0,x_pos(a0)
		st	$34(a1)
; loc3_2CCAE:
locK_2D99A:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_TitleCardAct:
		move.l	#Obj_TitleCardElement,(a0)
	if Sonic3_Alone
		move.b	(Apparent_zone).w,d0
		cmpi.b	#$A,d0
		beq.s	locK_2D9BE
		cmpi.b	#$C,d0
		bne.s	Obj_TitleCardElement
	else
		cmpi.b	#$A,(Current_zone).w
		beq.s	locK_2D9BE
		cmpi.b	#$C,(Current_zone).w
		beq.s	locK_2D9BE
		cmpi.w	#$1601,(Current_zone_and_act).w
		bne.s	Obj_TitleCardElement
	endif
; loc3_2CCCA:
locK_2D9BE:
		movea.w	parent2(a0),a1		; Sky Sanctuary, Doomsday, and Hidden Palace do not have act numbers
		subq.w	#1,$30(a1)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_TitleCardElement2:
		clr.b	render_flags(a0)	; I'm not entirely sure what this is used for
		movea.w	parent2(a0),a1
		move.w	$32(a1),d0
		beq.s	locK_2D9FA
		cmpi.w	#$20C,x_pos(a0)
		blo.s	locK_2D9EC
		subq.w	#1,$30(a1)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
; loc3_2CCF8:
locK_2D9EC:
		cmp.b	$28(a0),d0
		blo.s	locK_2DA10
		addi.w	#$20,x_pos(a0)
		bra.s	locK_2DA10
; ---------------------------------------------------------------------------
; loc3_2CD06:
locK_2D9FA:
		move.w	x_pos(a0),d0
		cmp.w	$46(a0),d0
		beq.s	locK_2DA10
		subi.w	#$10,d0
		move.w	d0,x_pos(a0)
		st	$34(a1)
; loc3_2CD1C:
locK_2DA10:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
TitleCard_LevelGfx:
		dc.l ArtKosM_AIZTitleCard
		dc.l ArtKosM_HCZTitleCard
		dc.l ArtKosM_MGZTitleCard
		dc.l ArtKosM_CNZTitleCard
		dc.l ArtKosM_FBZTitleCard
		dc.l ArtKosM_ICZTitleCard
		dc.l ArtKosM_LBZTitleCard
	if Sonic3_Alone
		; All Sonic & Knuckles title cards had their graphics data
		; removed. Sonic 3 1103 pointed to LBZ here.
		dc.l ArtKosM_AIZTitleCard
		dc.l ArtKosM_AIZTitleCard
		dc.l ArtKosM_AIZTitleCard
		dc.l ArtKosM_AIZTitleCard
		dc.l ArtKosM_AIZTitleCard
		dc.l ArtKosM_AIZTitleCard
		dc.l ArtKosM_AIZTitleCard
	else
		dc.l ArtKosM_MHZTitleCard
		dc.l ArtKosM_SOZTitleCard
		dc.l ArtKosM_LRZTitleCard
		dc.l ArtKosM_SSZTitleCard
		dc.l ArtKosM_DEZTitleCard
		dc.l ArtKosM_DDZTitleCard
		dc.l ArtKosM_HPZTitleCard
	endif
		dc.l ArtKosM_ALZTitleCard
		dc.l ArtKosM_BPZTitleCard
		dc.l ArtKosM_CGZTitleCard
		dc.l ArtKosM_DPZTitleCard
		dc.l ArtKosM_EMZTitleCard
		dc.l ArtKosM_BonusTitleCard
		dc.l ArtKosM_BonusTitleCard
		dc.l ArtKosM_BonusTitleCard
ObjArray_TtlCard:
		dc.l Obj_TitleCardName
		dc.w   $120
		dc.w   $260
		dc.w    $E0
		dc.b    4
		dc.b  $80
		dc.w      3
		dc.l Obj_TitleCardElement
		dc.w   $17C
		dc.w   $2FC
		dc.w   $100
		dc.b    3
		dc.b  $24
		dc.w      5
		dc.l Obj_TitleCardAct
		dc.w   $184
		dc.w   $344
		dc.w   $120
		dc.b    2
		dc.b  $1C
		dc.w      7
		dc.l Obj_TitleCardRedBanner
		dc.w    $C0
		dc.w    $E0
		dc.w    $10
		dc.b    1
		dc.b    0
		dc.w      1
ObjArray_TtlCard2:
		dc.l Obj_TitleCardElement2
		dc.w   $15C
		dc.w   $21C
		dc.w    $BC
		dc.b  $12
		dc.b  $80
		dc.w      1
ObjArray_TtlCardBonus:
		dc.l Obj_TitleCardElement
		dc.w    $C8
		dc.w   $188
		dc.w    $E8
		dc.b  $13
		dc.b  $80
		dc.w      1
		dc.l Obj_TitleCardElement
		dc.w   $128
		dc.w   $1E8
		dc.w    $E8
		dc.b  $14
		dc.b  $80
		dc.w      1