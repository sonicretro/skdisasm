; ---------------------------------------------------------------------------

Obj_EndSign:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	EndSign_Index(pc,d0.w),d1
		jsr	EndSign_Index(pc,d1.w)
		lea	PLCPtr_EndSigns(pc),a2
		jsr	Perform_DPLC(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
EndSign_Index:
		dc.w Obj_EndSignInit-EndSign_Index
		dc.w Obj_EndSignFall-EndSign_Index
		dc.w Obj_EndSignLanded-EndSign_Index
		dc.w Obj_EndSignResults-EndSign_Index
		dc.w Obj_EndSignAfter-EndSign_Index
; ---------------------------------------------------------------------------

Obj_EndSignInit:
		lea	ObjSlot_EndSigns(pc),a1
		jsr	SetUp_ObjAttributesSlotted(pc)
	if ~~Sonic3_Alone
		btst	#7,(Player_1+art_tile).w
		beq.s	locK_837EE
		bset	#7,art_tile(a0)			; Signs have same priority as Sonic

locK_837EE:
	endif
		move.w	a0,(Signpost_addr).w	; Put RAM address here for use by hidden monitor object
		move.b	#$18,x_radius(a0)
		move.b	#$1E,y_radius(a0)
		move.l	#AniRaw_EndSigns1,$30(a0)
	if Sonic3_Alone
		cmpi.b	#6,(Current_zone).w
		bne.s	locK_83816
		move.w	#$3EC0,x_pos(a0)
	else
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_83816
		move.l	#AniRaw_EndSigns2,$30(a0)
	endif
; loc3_523FA:
locK_83816:
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$20,d0
		move.w	d0,y_pos(a0)			; Place vertical position at top of screen
		moveq	#signextendB(sfx_Signpost),d0
		jsr	(Play_SFX).l
		lea	Child1_EndSignStub(pc),a2	; Make the little stub at the bottom of the signpost
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------

Obj_EndSignFall:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#3,d0
		bne.s	locK_83844
		lea	Child6_EndSignSparkle(pc),a2	; Create a signpost sparkle every 4 frames
		jsr	CreateChild6_Simple(pc)
; loc3_52428:
locK_83844:
		bsr.w	EndSign_CheckPlayerHit
		addi.w	#$C,y_vel(a0)
		jsr	(MoveSprite2).l					; Move downward
		bsr.w	EndSign_CheckWall
		jsr	Animate_Raw(pc)
		move.w	(Camera_Y_pos).w,d0
	if Sonic3_Alone
		cmpi.b	#6,(Current_zone).w
		bne.s	loc3_52450
		addi.w	#$60,d0

loc3_52450:
	else
		addi.w	#$50,d0
	endif
		cmp.w	y_pos(a0),d0
		bhi.s	locretK_838BC		; Ensure that signpost can't land if too far up the screen itself
		tst.w	y_vel(a0)
		bmi.s	locretK_838BC		; And also when the signpost is still moving up
	if ~~Sonic3_Alone
		cmpi.b	#8,(Current_zone).w
		bne.s	locK_8389C
		moveq	#0,d0				; Special code for handling the landing on Sandopolis 1's sand
		cmpi.w	#$4210,x_pos(a0)
		blo.s	locK_83884
		moveq	#2,d0

locK_83884:
		cmp.w	$3E(a0),d0
		beq.s	locK_83894
		move.w	d0,$3E(a0)
		move.w	word_838BE(pc,d0.w),priority(a0)

locK_83894:
		cmpi.w	#$9F2,y_pos(a0)
		bhs.s	locK_838AA

locK_8389C:
	endif
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.s	locretK_838BC
		add.w	d1,y_pos(a0)

locK_838AA:
		move.b	#4,routine(a0)			; If signpost has landed
		bset	#0,$38(a0)
		move.w	#$40,$2E(a0)
; locret3_5247C:
locretK_838BC:
		rts
; ---------------------------------------------------------------------------
	if ~~Sonic3_Alone
word_838BE:
		dc.w   $180,  $300
	endif
; ---------------------------------------------------------------------------

Obj_EndSignLanded:
		btst	#0,$38(a0)
		beq.s	locK_838FA
		jsr	Animate_Raw(pc)
		subq.w	#1,$2E(a0)			; Keep animating while landing for X amount of frames
		bmi.s	locK_838D6
		rts
; ---------------------------------------------------------------------------
; loc3_52492:
locK_838D6:
		move.b	#6,routine(a0)
	if ~~Sonic3_Alone
		st	(_unkFABE).w
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)			; Null velocity
	endif
		moveq	#0,d0
		move.b	(Player_mode+1).w,d0	; Get current character "mode"
		move.b	FrameArray_EndSign(pc,d0.w),mapping_frame(a0)
		st	(Ctrl_2_locked).w		; Null Sonic's input
		rts
; ---------------------------------------------------------------------------
; loc3_524AA:
locK_838FA:
		move.b	#2,routine(a0)			; If a hidden monitor was hit, bounce ths signpost again
		move.b	#$20,$20(a0)
		move.w	#-$200,y_vel(a0)
		rts
; ---------------------------------------------------------------------------
FrameArray_EndSign:
		dc.b    0,   0,   1,   2
		even
; ---------------------------------------------------------------------------

Obj_EndSignResults:
		lea	(Player_1).w,a1
		btst	#Status_InAir,status(a1)
		bne.s	locretK_83936		; If player is not standing on the ground, wait until he is
		move.b	#8,routine(a0)
		jsr	Set_PlayerEndingPose(pc)
		jsr	(AllocateObject).l
		bne.s	locretK_83936
		move.l	#Obj_LevelResults,(a1)
; locret3_524E6:
locretK_83936:
		rts
; ---------------------------------------------------------------------------

Obj_EndSignAfter:
	if ~~Sonic3_Alone
		cmpi.b	#$B,(Current_zone).w
		bne.s	locK_8395A
		jsr	(ObjCheckFloorDist).l		; If Death Egg Zone, then check if there's still a floor
		tst.w	d1
		beq.s	locK_83956
		bmi.s	locK_83956
		jsr	(MoveSprite).l		; Move sprite if there's no floor
		bra.w	locK_8395E
; ---------------------------------------------------------------------------

locK_83956:
		add.w	d1,y_pos(a0)

locK_8395A:
		clr.w	y_vel(a0)		; Null vertical velocity

locK_8395E:
	endif
		move.w	x_pos(a0),d0			; Check for whether signpost goes out of range
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	locK_83988
	if ~~Sonic3_Alone
		move.w	y_pos(a0),d0
		sub.w	(Camera_Y_pos).w,d0
		addi.w	#$80,d0
		cmpi.w	#$200,d0
		bhi.s	locK_83988
	endif
		jmp	(Check_TailsEndPose).l
; ---------------------------------------------------------------------------
; loc3_52500:
locK_83988:
		lea	PLC_SpikesSprings(pc),a1
		jsr	(Load_PLC_Raw).l
		jsr	Remove_From_TrackingSlot(pc)
		jmp	Go_Delete_Sprite(pc)
; ---------------------------------------------------------------------------
PLC_SpikesSprings: plrlistheader
		plreq ArtTile_SpikesSprings, ArtNem_SpikesSprings
PLC_SpikesSprings_End
; ---------------------------------------------------------------------------

Obj_SignpostSparkle:
		lea	ObjDat_SignpostSparkle(pc),a1
		jsr	SetUp_ObjAttributes(pc)
	if ~~Sonic3_Alone
		btst	#7,(Player_1+art_tile).w
		beq.s	locK_839B8
		bset	#7,art_tile(a0)

locK_839B8:
	endif
		move.l	#Obj_SignpostSparkleMain,(a0)
		jsr	(Random_Number).l
		andi.w	#$1F,d0
		subi.w	#$10,d0
		add.w	d0,y_pos(a0)			; Random vertical position
		move.w	x_pos(a0),$3A(a0)
		move.w	#$1000,x_vel(a0)
		move.w	#$20,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)

Obj_SignpostSparkleMain:
		move.w	#$400,d0
		move.w	x_pos(a0),d1
		cmp.w	$3A(a0),d1
		blo.s	locK_839FA
		neg.w	d0
; loc3_52564:
locK_839FA:
	if Sonic3_Alone
		move.w	#$80,d1
	else
		move.w	#$280,d1
	endif
		add.w	d0,x_vel(a0)		; Do rotation around sign
		bpl.s	locK_83A08
	if Sonic3_Alone
		move.w	#$180,d1
	else
		move.w	#$380,d1
	endif
; loc3_52572:
locK_83A08:
		move.w	d1,priority(a0)
		jsr	(MoveSprite2).l
		lea	AniRaw_SignpostSparkle(pc),a1
		jsr	Animate_RawNoSST(pc)
		jsr	Obj_Wait(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_SignpostStub:
	if ~~Sonic3_Alone
		lea	ObjDat_SignpostStub(pc),a1
		jsr	SetUp_ObjAttributes(pc)
	endif
		move.l	#Obj_SignpostStubMain,(a0)
	if Sonic3_Alone
		lea	ObjDat_SignpostStub(pc),a1
		jmp	SetUp_ObjAttributes(pc)
	else
		btst	#7,(Player_1+art_tile).w
		beq.s	Obj_SignpostStubMain
		bset	#7,art_tile(a0)
	endif

Obj_SignpostStubMain:
		jsr	Refresh_ChildPosition(pc)
	if ~~Sonic3_Alone
		jsr	(Child_GetPriority).l
	endif
		jmp	(Child_Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


EndSign_CheckPlayerHit:
		tst.b	$20(a0)
		bne.s	locK_83AB8
		lea	EndSign_Range(pc),a1
		jsr	Check_PlayerInRange(pc)
		tst.l	d0
		beq.s	locretK_83ABC		; If neither player is in range, don't do anything
		tst.w	d0				; Is Sonic?
		beq.s	locK_83A6A		; If it's not Sonic, branch

	if FixBugs
		move.l	d0,-(sp)			; Save players address
		bsr.w	subK_83A70
		move.l	(sp)+,d0			; Restore players address
	else
		; Bug: After returning from the subroutine, the address of the characters in d0
		; will be corrupted and the check will not work correctly.
		bsr.w	subK_83A70
	endif
; loc3_525C0:
locK_83A6A:
		swap	d0				; Get Tails address
		tst.w	d0				; Is Tails?
		beq.s	locretK_83ABC		; If it's not Tails, branch
; End of function EndSign_CheckPlayerHit


; =============== S U B R O U T I N E =======================================

; sub3_525C6:
subK_83A70:
		movea.w	d0,a1			; This can be done up to twice depending on who hit the signpost
		cmpi.b	#2,anim(a1)
		bne.s	locretK_83ABC		; only go on if Player is currently jumping
		tst.w	y_vel(a1)
		bpl.s	locretK_83ABC		; And if he's actually moving upwards
		move.b	#$20,$20(a0)		; Set delay for when it checks for the next hit
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bne.s	locK_83A92
		moveq	#8,d0
; loc3_525E8:
locK_83A92:
		lsl.w	#4,d0
		move.w	d0,x_vel(a0)		; Modify strength of X velocity based on how far to the left/right player is
		move.w	#-$200,y_vel(a0)	; New vertical velocity is always the same
		moveq	#signextendB(sfx_Signpost),d0
		jsr	(Play_SFX).l
		lea	Child6_EndSignScore(pc),a2
		jsr	CreateChild6_Simple(pc)
		moveq	#10,d0
		movea.l	a1,a3
		jmp	(HUD_AddToScore).l	; Add 100 points whenever hit
; ---------------------------------------------------------------------------
; loc3_5260E:
locK_83AB8:
		subq.b	#1,$20(a0)
; locret3_52612:
locretK_83ABC:
		rts
; End of function subK_83A70

; ---------------------------------------------------------------------------
EndSign_Range:
		dc.w   -$20,   $40,  -$18,   $30

; =============== S U B R O U T I N E =======================================


EndSign_CheckWall:
		move.w	(Camera_X_pos).w,d0
		tst.w	x_vel(a0)
		bmi.s	locK_83AE8
		addi.w	#$128,d0
		cmp.w	x_pos(a0),d0
		blo.s	locK_83AFE
		moveq	#$20,d3
		jsr	(ObjCheckRightWallDist).l
		tst.w	d1
		bmi.s	locK_83AFE
		rts
; ---------------------------------------------------------------------------
; loc3_5263E:
locK_83AE8:
		addi.w	#$18,d0
		cmp.w	x_pos(a0),d0
		bhi.s	locK_83AFE
		moveq	#-$20,d3
		jsr	(ObjCheckLeftWallDist).l
		tst.w	d1
		bpl.s	locretK_83B02
; loc3_52654:
locK_83AFE:
		neg.w	x_vel(a0)
; locret3_52658:
locretK_83B02:
		rts
; End of function EndSign_CheckWall

; ---------------------------------------------------------------------------
ObjSlot_EndSigns:
		dc.w 1-1
		dc.w make_art_tile(ArtTile_EndSigns,0,0)
		dc.w     $C,     0
		dc.l Map_EndSigns
	if Sonic3_Alone
		dc.w   $100
	else
		dc.w   $300
	endif
		dc.b  $18, $10,   0,   0

ObjDat_SignpostStub:
		dc.l Map_SignpostStub
		dc.w make_art_tile(ArtTile_SignpostStub,0,0)
	if Sonic3_Alone
		dc.w   $100
	else
		dc.w   $300
	endif
		dc.b    4,   8,   0,   0

ObjDat_SignpostSparkle:
		dc.l Map_Ring
		dc.w make_art_tile(ArtTile_Ring,1,0)
	if Sonic3_Alone
		dc.w   $80
	else
		dc.w   $280
	endif
		dc.b    8,   8,   4,   0

Child1_EndSignStub:
		dc.w 1-1
		dc.l Obj_SignpostStub
		dc.b    0, $18

Child6_EndSignSparkle:
		dc.w 1-1
		dc.l Obj_SignpostSparkle

Child6_EndSignScore:
		dc.w 1-1
		dc.l Obj_EnemyScore

PLCPtr_EndSigns:
		dc.l ArtUnc_EndSigns
		dc.l DPLC_EndSigns

	if Sonic3_Alone
AniRaw_EndSigns1:
		dc.b    1,   0,   4,   5,   6,   1,   4,   5,   6,   2,   4,   5,   6,   3,   4,   5,   6, $FC
	else
AniRaw_EndSigns1:
		dc.b    1,   0,   4,   5,   6,   1,   4,   5,   6,   3,   4,   5,   6, $FC

AniRaw_EndSigns2:
		dc.b    1,   1,   4,   5,   6,   2,   4,   5,   6,   3,   4,   5,   6, $FC
	endif

AniRaw_SignpostSparkle:
		dc.b    1,   4,   5,   6,   7, $FC
		even

	if ~~Sonic3_Alone
DPLC_EndSigns:
		include "General/Sprites/Signpost/DPLC - End Signs.asm"
Map_EndSigns:
		include "General/Sprites/Signpost/Map - End Signs.asm"
Map_SignpostStub:
		include "General/Sprites/Signpost/Map - Signpost Stub.asm"
	endif