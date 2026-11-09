; ---------------------------------------------------------------------------

Obj_LBZFinalBoss2:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	LBZFinalBoss2_Index(pc,d0.w),d1
		jsr	LBZFinalBoss2_Index(pc,d1.w)
		jsr	(subK_74FD2).l
	if Sonic3_Alone
		jmp	Draw_And_Touch_Sprite(pc)
	else
		jmp	(Draw_And_Touch_Sprite).l
	endif
; ---------------------------------------------------------------------------
LBZFinalBoss2_Index:
		dc.w locK_742A8-LBZFinalBoss2_Index
	if Sonic3_Alone
		dc.w loc3_50D28-LBZFinalBoss2_Index
	else
		dc.w locK_7430E-LBZFinalBoss2_Index
	endif
		dc.w locK_7430E-LBZFinalBoss2_Index
		dc.w locK_7432A-LBZFinalBoss2_Index
		dc.w locK_7430E-LBZFinalBoss2_Index
		dc.w locK_743CE-LBZFinalBoss2_Index
		dc.w locK_74412-LBZFinalBoss2_Index
		dc.w locK_74442-LBZFinalBoss2_Index
		dc.w locK_74456-LBZFinalBoss2_Index
		dc.w locK_7447A-LBZFinalBoss2_Index
		dc.w locK_744A4-LBZFinalBoss2_Index
		dc.w locK_744E4-LBZFinalBoss2_Index
		dc.w locK_744FC-LBZFinalBoss2_Index
		dc.w locK_74528-LBZFinalBoss2_Index
		dc.w locK_74542-LBZFinalBoss2_Index
		dc.w locK_7455C-LBZFinalBoss2_Index
		dc.w locK_74576-LBZFinalBoss2_Index
		dc.w locK_745A2-LBZFinalBoss2_Index
		dc.w locK_745E2-LBZFinalBoss2_Index
		dc.w locK_74618-LBZFinalBoss2_Index
		dc.w locK_7463A-LBZFinalBoss2_Index
		dc.w locK_746C8-LBZFinalBoss2_Index
; ---------------------------------------------------------------------------
; loc3_50CEE:
locK_742A8:
		lea	ObjDat_LBZFinalBoss2(pc),a1
	if Sonic3_Alone
		jsr	SetUp_ObjAttributes(pc)
	else
		jsr	(SetUp_ObjAttributes).l
	endif
		move.b	#8,collision_property(a0)
		bset	#3,$38(a0)
		st	(Disable_death_plane).w
	if ~~Sonic3_Alone
		move.w	(Camera_X_pos).w,d0
		addi.w	#$A0,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$50,d0
		move.w	d0,y_pos(a0)
		move.w	#$59,$2E(a0)
		move.l	#locK_74314,$34(a0)
	endif
		lea	Pal_LBZFinalBoss2(pc),a1
	if Sonic3_Alone
		jsr	PalLoad_Line1(pc)
	else
		jsr	(PalLoad_Line1).l
	endif
		lea	(ArtKosM_LBZFinalBoss2).l,a1
		move.w	#tiles_to_bytes(ArtTile_LBZFinalBoss2),d2
		jsr	(Queue_Kos_Module).l
		lea	(Child1_MakeRoboHead4).l,a2
	if Sonic3_Alone
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------

loc3_50D28:
		subq.w	#1,y_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$40,d0
		cmp.w	y_pos(a0),d0
		bcc.s	loc3_50D3C
		rts
; ---------------------------------------------------------------------------

loc3_50D3C:
		move.b	#4,routine(a0)
		move.w	#$9F,$2E(a0)
		move.l	#locK_74314,$34(a0)
		jsr	(AllocateObject).l
		bne.s	loc3_50D64
		move.l	#Obj_Song_Fade_Transition,(a1)
		move.b	#mus_FinalBoss,subtype(a1)

loc3_50D64:
		jsr	(AllocateObject).l
		bne.s	locret3_50D72
		move.l	#loc3_517FE,(a1)

locret3_50D72:
		rts
	else
		jmp	(CreateChild1_Normal).l
	endif
; ---------------------------------------------------------------------------
; loc3_50D74:
locK_7430E:
	if Sonic3_Alone
		jmp	Obj_Wait(pc)
	else
		jmp	(Obj_Wait).l
	endif
; ---------------------------------------------------------------------------
; loc_50D78:
locK_74314:
		move.b	#6,routine(a0)
		move.b	#8,mapping_frame(a0)
		lea	ChildObjDat_75122(pc),a2
	if Sonic3_Alone
		jmp	CreateChild1_Normal(pc)
	else
		jmp	(CreateChild1_Normal).l
	endif
; ---------------------------------------------------------------------------
; loc3_50D8C:
locK_7432A:
	if Sonic3_Alone
		jsr	MoveSprite_LightGravity(pc)
	else
		jsr	(MoveSprite_LightGravity).l
	endif
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$120,d0
		cmp.w	y_pos(a0),d0
		blo.s	locK_74340
		rts
; ---------------------------------------------------------------------------
; loc3_50DA0:
locK_74340:
		bset	#7,art_tile(a0)
		clr.w	y_vel(a0)
		move.b	#$F,$28(a0)
		bchg	#0,render_flags(a0)
		lea	ChildObjDat_7513C(pc),a2
	if Sonic3_Alone
		jsr	CreateChild1_Normal(pc)
	else
		jsr	(CreateChild1_Normal).l
	endif
; loc3_50DBE:
locK_74360:
		move.b	#8,routine(a0)
		move.w	#$7F,$2E(a0)
		move.l	#locK_74376,$34(a0)
; locret3_50DD2:
locretK_74374:
		rts
; ---------------------------------------------------------------------------
; loc3_50DD4:
locK_74376:
		bchg	#0,render_flags(a0)
		move.b	$39(a0),d0
		addq.b	#1,$39(a0)
	if Sonic3_Alone
		btst	#1,d0
	else
		btst	#2,d0
	endif
		bne.s	locK_743AE
		move.b	#$A,routine(a0)
		bclr	#3,$38(a0)
		bclr	#2,$38(a0)
		move.w	#$AF,$2E(a0)
		move.l	#locK_74360,$34(a0)
		bra.w	locK_74F24
; ---------------------------------------------------------------------------
; loc3_50E0C:
locK_743AE:
		move.b	#$C,routine(a0)
		clr.b	$39(a0)
		clr.w	y_vel(a0)
		move.l	#locK_74428,$34(a0)
		move.w	(Camera_Y_pos).w,y_pos(a0)
		bra.w	locK_74F82
; ---------------------------------------------------------------------------
; loc3_50E2C:
locK_743CE:
		move.w	$3A(a0),d0
		move.w	offK_743E6(pc,d0.w),d0
		jsr	offK_743E6(pc,d0.w)
		jsr	(MoveSprite2).l
	if Sonic3_Alone
		jmp	Obj_Wait(pc)
	else
		jmp	(Obj_Wait).l
	endif
; ---------------------------------------------------------------------------
; off3_50E42:
offK_743E6:
		dc.w locretK_743F4-offK_743E6
		dc.w locK_743F0-offK_743E6
		dc.w locK_743F6-offK_743E6
		dc.w locretK_743F4-offK_743E6
		dc.w locK_7440C-offK_743E6
; ---------------------------------------------------------------------------
; loc3_50E4C:
locK_743F0:
		subq.w	#4,y_vel(a0)
; locret3_50E50:
locretK_743F4:
		rts
; ---------------------------------------------------------------------------
; loc3_50E52:
locK_743F6:
		move.w	y_vel(a0),d0
		add.w	$3C(a0),d0
		move.w	d0,y_vel(a0)
		bne.s	locretK_7440A
		move.w	#2,$3C(a0)
; locret3_50E66:
locretK_7440A:
		rts
; ---------------------------------------------------------------------------
; loc3_50E68:
locK_7440C:
		subq.w	#4,y_pos(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_50E6E:
locK_74412:
		moveq	#$50,d1
		move.w	#$F0,d2
		bsr.w	subK_74FA8
		jsr	(MoveSprite2).l
	if Sonic3_Alone
		jmp	Obj_Wait(pc)
	else
		jmp	(Obj_Wait).l
	endif
; ---------------------------------------------------------------------------
; loc3_50E82:
locK_74428:
		move.b	#$E,routine(a0)
		clr.w	x_vel(a0)
		move.w	#$1F,$2E(a0)
		move.l	#locK_74448,$34(a0)
		rts
; ---------------------------------------------------------------------------
; loc_50E9C:
locK_74442:
	if Sonic3_Alone
		jmp	Obj_Wait(pc)
	else
		jmp	(Obj_Wait).l
	endif
; ---------------------------------------------------------------------------
; loc3_50EA0:
locK_74448:
		move.b	#$10,routine(a0)
		bset	#3,$38(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_50EAE:
locK_74456:
	if Sonic3_Alone
		jsr	MoveSprite_LightGravity(pc)
	else
		jsr	(MoveSprite_LightGravity).l
	endif
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$C0,d0
		cmp.w	y_pos(a0),d0
		blo.s	locK_7446C
		rts
; ---------------------------------------------------------------------------
; loc3_50EC2:
locK_7446C:
		move.b	#$12,routine(a0)
		bset	#2,$38(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_50ED0:
locK_7447A:
		addi.w	#-$80,y_vel(a0)
		jsr	(MoveSprite2).l
		tst.w	y_vel(a0)
		bpl.s	locretK_7449A
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$E0,d0
		cmp.w	y_pos(a0),d0
		bhs.s	locK_7449C
; locret3_50EF0:
locretK_7449A:
		rts
; ---------------------------------------------------------------------------
; loc3_50EF2:
locK_7449C:
		move.b	#$14,routine(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_50EFA:
locK_744A4:
		addi.w	#$40,y_vel(a0)
		jsr	(MoveSprite2).l
		tst.w	y_vel(a0)
		bmi.s	locretK_744C4
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$D0,d0
		cmp.w	y_pos(a0),d0
		bls.s	locK_744C6
; locret3_50F1A:
locretK_744C4:
		rts
; ---------------------------------------------------------------------------
; loc3_50F1C:
locK_744C6:
		move.b	#$16,routine(a0)
		move.w	d0,y_pos(a0)
		clr.w	y_vel(a0)
		move.w	#$1F,$2E(a0)
		move.l	#locK_744EA,$34(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_50F3A:
locK_744E4:
	if Sonic3_Alone
		jmp	Obj_Wait(pc)
	else
		jmp	(Obj_Wait).l
	endif
; ---------------------------------------------------------------------------
; loc3_50F3E:
locK_744EA:
		move.b	#$18,routine(a0)
		move.l	#locK_74512,$34(a0)
		bra.w	locK_74F82
; ---------------------------------------------------------------------------
; loc3_50F50:
locK_744FC:
		moveq	#$30,d1
		move.w	#$110,d2
		bsr.w	subK_74FA8
		jsr	(MoveSprite2).l
	if Sonic3_Alone
		jmp	Obj_Wait(pc)
	else
		jmp	(Obj_Wait).l
	endif
; ---------------------------------------------------------------------------
; loc3_50F64:
locK_74512:
		move.b	#$1A,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#locK_7452E,$34(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_50F7A:
locK_74528:
	if Sonic3_Alone
		jmp	Obj_Wait(pc)
	else
		jmp	(Obj_Wait).l
	endif
; ---------------------------------------------------------------------------
; loc_50F7E:
locK_7452E:
		move.b	#$1C,routine(a0)
		move.w	#-$400,y_vel(a0)
		bclr	#3,$38(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_50F92:
locK_74542:
		jsr	(MoveSprite2).l
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$60,d0
		cmp.w	y_pos(a0),d0
		bhs.s	locK_74558
		rts
; ---------------------------------------------------------------------------
; loc3_50FA8:
locK_74558:
		bra.w	locK_74360
; ---------------------------------------------------------------------------
; loc3_50FAC:
locK_7455C:
	if Sonic3_Alone
		jmp	Obj_Wait(pc)
	else
		jmp	(Obj_Wait).l
	endif
; ---------------------------------------------------------------------------
; loc3_50FB0:
locK_74562:
		move.b	#$20,routine(a0)
		move.w	#-$400,y_vel(a0)
		bchg	#1,$39(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_50FC4:
locK_74576:
		jsr	(MoveSprite2).l
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$60,d0
		cmp.w	y_pos(a0),d0
		bhs.s	locK_7458C
		rts
; ---------------------------------------------------------------------------
; loc3_50FDA:
locK_7458C:
		move.b	#$22,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#locK_745A8,$34(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_50FF0:
locK_745A2:
	if Sonic3_Alone
		jmp	Obj_Wait(pc)
	else
		jmp	(Obj_Wait).l
	endif
; ---------------------------------------------------------------------------
; loc3_50FF4:
locK_745A8:
		move.b	#$24,routine(a0)
		movea.w	$44(a0),a1
		clr.b	$3C(a1)
		move.w	(Camera_X_pos).w,d0
		move.w	d0,d1
		addi.w	#$A0,d0
		bclr	#0,render_flags(a0)
		move.w	#$E0,d2
		cmp.w	x_pos(a0),d0
		blo.s	locK_745DA
		bset	#0,render_flags(a0)
		move.w	#$60,d2
; loc3_51026:
locK_745DA:
		add.w	d2,d1
		move.w	d1,x_pos(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_5102E:
locK_745E2:
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$88,d0
		cmp.w	y_pos(a0),d0
		bls.s	locK_745F6
		addq.w	#8,y_pos(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_51042:
locK_745F6:
		move.b	#$26,routine(a0)
		bset	#1,$38(a0)
		move.w	#$14,(Screen_shake_flag).w
		move.w	#3,$2E(a0)
		moveq	#signextendB(sfx_BossHitFloor),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------
; loc3_51064:
locK_74618:
		addq.w	#4,y_pos(a0)
		subq.w	#1,$2E(a0)
		bmi.s	locK_74624
		rts
; ---------------------------------------------------------------------------
; loc_51070:
locK_74624:
		move.b	#$28,routine(a0)
		move.w	#7,$2E(a0)
		move.l	#locK_74640,$34(a0)
		rts
; ---------------------------------------------------------------------------
; loc_51086:
locK_7463A:
	if Sonic3_Alone
		jmp	Obj_Wait(pc)
	else
		jmp	(Obj_Wait).l
	endif
; ---------------------------------------------------------------------------
; loc_5108A:
locK_74640:
		move.b	#$2A,routine(a0)
		clr.b	$30(a0)
		subi.w	#$10,y_pos(a0)
		bclr	#1,$38(a0)
		move.w	#$400,d0
		btst	#0,render_flags(a0)
		beq.s	locK_74664
		neg.w	d0
; loc3_510AE:
locK_74664:
		move.w	d0,x_vel(a0)
		move.w	#-$600,y_vel(a0)
		move.w	#$3F,$2E(a0)
	if ~~Sonic3_Alone
		; Sonic 3 Alone didn't check if the player was invincible, which led
		; to Big Arms being capable of hurting Super Sonic. This was fixed in
		; Sonic & Knuckles, alongside IceCap's spike balls.
		btst	#Status_Invincible,(Player_1+status_secondary).w
		bne.s	locK_7468C
	endif
		movea.l	a0,a2
		lea	(Player_1).w,a0
		jsr	(HurtCharacter).l
		movea.l	a2,a0
		rts
; ---------------------------------------------------------------------------
	if ~~Sonic3_Alone
locK_7468C:
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		neg.w	d0
		move.w	d0,x_vel(a1)
		move.w	#-$400,y_vel(a1)
		bset	#Status_InAir,status(a1)
		bclr	#Status_OnObj,status(a1)
		clr.b	jumping(a1)
		clr.b	spin_dash_flag(a1)
		move.b	#2,anim(a1)
		move.b	#2,routine(a1)
		moveq	#signextendB(sfx_Spring),d0
		jmp	(Play_SFX).l
	endif
; ---------------------------------------------------------------------------
; loc3_510CE:
locK_746C8:
		jsr	(MoveSprite).l
		subq.w	#1,$2E(a0)
		bmi.w	locK_74360
		rts
; ---------------------------------------------------------------------------
; loc3_510E3:
locK_746D8:
		move.l	#locK_746F4,(a0)
		move.b	#5,mapping_frame(a0)
		bset	#4,$38(a0)
		lea	ChildObjDat_7515E(pc),a2
	if Sonic3_Alone
		jmp	CreateChild1_Normal(pc)
	else
		jmp	(CreateChild1_Normal).l
	endif
; ---------------------------------------------------------------------------
; loc3_510F8:
locK_746F4:
		move.w	y_pos(a0),d0
	if Sonic3_Alone
		addq.w	#1,d0
		move.w	d0,y_pos(a0)
		move.w	(Camera_Y_pos).w,d1
		addi.w	#$140,d1
		cmp.w	d1,d0
		blo.s	loc3_51142
		move.l	#locK_74768,(a0)
		bclr	#7,render_flags(a0)
		bset	#5,$38(a0)
		move.w	a0,(_unkFAA4).w
		clr.w	(Ctrl_1_logical).w
		st	(Ctrl_1_locked).w
		move.b	#$80,(Player_1+object_control).w
		lea	(ArtKosM_LBZ2DeathEggSmall).l,a1
		move.w	#tiles_to_bytes(ArtTile_LBZ2DeathEggSmall),d2
		jsr	(Queue_Kos_Module).l

loc3_51142:
		jmp	(Draw_Sprite).l
	else
		subq.w	#1,d0
		move.w	d0,y_pos(a0)
		move.w	(Camera_Y_pos).w,d1
		subi.w	#$40,d1
		cmp.w	d1,d0
		blo.s	locK_74710
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_74710:
		move.l	#locK_7473A,(a0)
		bclr	#7,render_flags(a0)
		bset	#5,$38(a0)
		bset	#0,render_flags(a0)
		move.w	(Camera_X_pos).w,d2
		addi.w	#$40,d2
		move.w	d2,x_pos(a0)
		jmp	(loc_694AA).l
; ---------------------------------------------------------------------------

locK_7473A:
		tst.b	(_unkFAA8).w
		bne.w	locretK_74374
		tst.b	(_unkFAA2).w
		beq.w	locretK_74374
		move.l	#locK_74768,(a0)
		jsr	sub_7302E(pc)
		bclr	#7,status(a0)
		jsr	(Restore_PlayerControl).l
		clr.w	(Ctrl_1_logical).w
		st	(Ctrl_1_locked).w
	endif

locK_74768:
		lea	(Player_1).w,a1
	if Sonic3_Alone
		include	"Code/Objects/Boss - Big Arms (Sonic 3).asm"
	else
		; The post-defeat cutscene was completely redone in Sonic 3 & Knuckles due
		; to Big Arms becoming a Knuckles-only boss. Attempting to diff it would
		; be basically pointless.
		include	"Code/Objects/Boss - Big Arms (Sonic 3 & Knuckles).asm"
	endif

; =============== S U B R O U T I N E =======================================

; sub3_51BC8:
subK_74EBC:
		movea.w	parent3(a0),a1
		btst	#7,art_tile(a1)
		beq.s	locretK_74ED4
		bset	#7,art_tile(a0)
		move.l	(sp),(a0)
		move.b	d0,collision_flags(a0)
; locret3_51BE0:
locretK_74ED4:
		rts
; End of function subK_74EBC

; ---------------------------------------------------------------------------
		; unused
		movea.w	$44(a0),a1
		movea.w	parent3(a0),a2
		move.w	x_pos(a1),d0
		moveq	#$10,d2
		btst	#0,render_flags(a2)
		beq.s	locK_74EEE
		neg.w	d2
; loc3_51BFA:
locK_74EEE:
		add.w	d2,d0
		move.w	x_pos(a2),d1
		moveq	#$C,d2
		btst	#0,render_flags(a2)
		beq.s	locK_74F00
		neg.w	d2
; loc3_51C0C:
locK_74F00:
		add.w	d2,d1
		sub.w	d1,d0
		asr.w	#1,d0
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		move.w	y_pos(a1),d0
		subq.w	#4,d0
		move.w	y_pos(a2),d1
		subq.w	#4,d1
		sub.w	d1,d0
		asr.w	#1,d0
		add.w	d0,d1
		move.w	d1,y_pos(a0)
		rts
; ---------------------------------------------------------------------------
; loc_51C30:
locK_74F24:
		jsr	(Random_Number).l
		andi.w	#6,d0
		move.w	d0,$3A(a0)
		move.w	(Camera_X_pos).w,d1
		move.w	#$1A8,d2
		move.w	#-$300,d3
		btst	#0,render_flags(a0)
		beq.s	locK_74F4C
		move.w	#-$68,d2
		neg.w	d3
; loc3_51C58:
locK_74F4C:
		add.w	d2,d1
		move.w	d1,x_pos(a0)
		move.w	d3,x_vel(a0)
		move.w	(Camera_Y_pos).w,d1
		move.w	wordK_74F72(pc,d0.w),d2
		add.w	d1,d2
		move.w	d2,y_pos(a0)
		move.w	wordK_74F7A(pc,d0.w),y_vel(a0)
		move.w	#8,$3C(a0)
		rts
; ---------------------------------------------------------------------------
; word3_51C7E:
wordK_74F72:
		dc.w    $60,   $10,   $A0,   $80
; word3_51C86:
wordK_74F7A:
		dc.w      0,  $200, -$200,     0
; ---------------------------------------------------------------------------
; loc3_51C8E:
locK_74F82:
		move.w	#-$300,d0
		btst	#0,render_flags(a0)
		beq.s	locK_74F90
		neg.w	d0
; loc3_51C9C:
locK_74F90:
		move.w	d0,x_vel(a0)
		jsr	(Random_Number).l
		andi.w	#$7F,d0
		addi.w	#$C0,d0
		move.w	d0,$2E(a0)
		rts

; =============== S U B R O U T I N E =======================================

; sub3_51CB4:
subK_74FA8:
		move.w	(Camera_X_pos).w,d0
		tst.w	x_vel(a0)
		bmi.s	locK_74FBE
		add.w	d2,d0
		cmp.w	x_pos(a0),d0
		bls.s	locK_74FC6
		bra.w	locretK_74FD0
; ---------------------------------------------------------------------------
; loc3_51CCA:
locK_74FBE:
		add.w	d1,d0
		cmp.w	x_pos(a0),d0
		blo.s	locretK_74FD0
; loc3_51CD2:
locK_74FC6:
		bchg	#0,render_flags(a0)
		neg.w	x_vel(a0)
; locret3_51CDC:
locretK_74FD0:
		rts
; End of function subK_74FA8


; =============== S U B R O U T I N E =======================================

; sub3_51CDE:
subK_74FD2:
		cmpi.b	#8,routine(a0)
		blo.s	locretK_75044
		tst.b	collision_flags(a0)
		bne.s	locretK_75044
		move.b	collision_property(a0),d0
		beq.s	locK_75046
		tst.b	$20(a0)
		bne.s	locK_75010
		cmpi.b	#$A,routine(a0)
		bne.s	locK_74FFA
		move.w	#8,$3A(a0)
; loc3_51D06:
locK_74FFA:
		move.b	#$3C,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l
		movea.w	$44(a0),a1
		clr.b	collision_flags(a1)
; loc3_51D1C:
locK_75010:
		bset	#6,status(a0)
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	locK_75024
		addi.w	#2*6,d0
; loc3_51D30:
locK_75024:
		bsr.w	subK_75084
		subq.b	#1,$20(a0)
		bne.s	locretK_75044
		bclr	#6,status(a0)
		move.b	$25(a0),collision_flags(a0)
		movea.w	$44(a0),a1
		move.b	#$AD,collision_flags(a1)

locretK_75044:
		rts
; ---------------------------------------------------------------------------
; loc3_51D52:
locK_75046:
	if Sonic3_Alone
		move.l	#Wait_Draw,(a0)
	else
		move.l	#Wait_FadeToLevelMusic,(a0)
	endif
		move.l	#locK_746D8,$34(a0)
	if Sonic3_Alone
		jsr	BossDefeated_StopTimer(pc)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild1_Normal).l
	else
		jsr	(BossDefeated_StopTimer).l
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
	endif
		bne.s	locK_7506E
		move.b	#4,subtype(a1)
; loc3_51D78:
locK_7506E:
		tst.b	$30(a0)
	if FixBugs
		beq.s	locK_7507A
	else
		; Bug: this branch is inverted, freeing the player if they're _not_ being held
		bne.s	locK_7507A
	endif
	if Sonic3_Alone
		jsr	Restore_PlayerControl(pc)
; loc3_51D82:
locK_7507A:
		jmp	(SaveGame).l
	else
		jsr	(Restore_PlayerControl).l
; loc3_51D82:
locK_7507A:
		lea	ChildObjDat_75186(pc),a2
		jmp	(CreateChild1_Normal).l
	endif
; End of function subK_74FD2


; =============== S U B R O U T I N E =======================================

; sub3_51D88:
subK_75084:
		lea	wordK_75092(pc),a1
		lea	wordK_7509E(pc,d0.w),a2
	if Sonic3_Alone
		jmp	CopyWordData_6(pc)
	else
		jmp	(CopyWordData_6).l
	endif
; End of function subK_75084

; ---------------------------------------------------------------------------
wordK_75092:
		dc.w Normal_palette_line_2+$08, Normal_palette_line_2+$0E, Normal_palette_line_2+$10
		dc.w Normal_palette_line_2+$18, Normal_palette_line_2+$1A, Normal_palette_line_2+$1C
wordK_7509E:
		dc.w      8,    $A,     4,  $644,  $422,     0
		dc.w   $888,  $666,  $AAA,  $AAA,  $EEE,  $EEE

	if Sonic3_Alone
		include	"Code/Objects (Common)/Perform Art Scaling.asm"

; =============== S U B R O U T I N E =======================================


sub3_51E3A:
		subq.w	#1,$1C(a0)
		bpl.s	loc3_51E62
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.b	#1,d0
		cmpi.b	#6,d0
		bhi.s	loc3_51E80
		move.b	d0,anim_frame(a0)
		add.w	d0,d0
		move.w	word3_51E86(pc,d0.w),$1C(a0)
		add.w	d0,d0
		move.l	off3_51E94(pc,d0.w),$42(a0)

loc3_51E62:
		subq.b	#1,$25(a0)
		bpl.s	locret3_51E7E
		move.b	#4,$25(a0)
		move.b	$40(a0),d0
		addq.b	#1,d0
		bmi.s	locret3_51E7E
		move.b	d0,$40(a0)
		bsr.w	Perform_Art_Scaling

locret3_51E7E:
		rts
; ---------------------------------------------------------------------------

loc3_51E80:
		jmp	(Go_Delete_Sprite).l
; End of function sub3_51E3A

; ---------------------------------------------------------------------------
word3_51E86:
		dc.w    $20
		dc.w    $20
		dc.w    $10
		dc.w      8
		dc.w      8
		dc.w      8
		dc.w   $200
off3_51E94:
		dc.l ArtScaled_LBZ2UnusedRobotnik
		dc.l ArtScaled_LBZ2UnusedRobotnik
		dc.l ArtScaled_LBZ2UnusedRobotnik+$1000
		dc.l ArtScaled_LBZ2UnusedRobotnik+$2000
		dc.l ArtScaled_LBZ2UnusedRobotnik+$3000
		dc.l ArtScaled_LBZ2UnusedRobotnik+$4000
		dc.l ArtScaled_LBZ2UnusedRobotnik+$5000

; =============== S U B R O U T I N E =======================================


sub3_51EB0:
		move.w	$3A(a0),d1
		movea.l	off3_51EC6(pc,d1.w),a1
		lea	(Normal_palette).w,a2
		moveq	#bytesToLcnt($20),d0

loc3_51EBE:
		move.l	(a1)+,(a2)+
		dbf	d0,loc3_51EBE
		rts
; End of function sub3_51EB0

; ---------------------------------------------------------------------------
off3_51EC6:
		dc.l Pal_SonicEndPose
		dc.l Pal_TailsEndPose
		dc.l Pal_SuperSonicEndPose
		dc.l Pal_SuperSonicEndPose

; =============== S U B R O U T I N E =======================================


Animate_ExternalPlayerSprite:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret3_51F10
		lea	(Player_1).w,a2
		move.b	(a1),anim_frame_timer(a0)
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.b	#2,d0
		move.b	d0,anim_frame(a0)
		move.b	1(a1,d0.w),d1
		cmpi.b	#-1,d1
		beq.s	loc3_51F12
		move.b	d1,mapping_frame(a2)
		bclr	#0,render_flags(a2)
		tst.b	2(a1,d0.w)
		beq.s	locret3_51F10
		bset	#0,render_flags(a2)

locret3_51F10:
		rts
; ---------------------------------------------------------------------------

loc3_51F12:
		movea.l	$34(a0),a1
		jmp	(a1)
; End of function Animate_ExternalPlayerSprite
	endif

ObjDat_LBZFinalBoss2:
		dc.l Map_RobotnikShip
		dc.w make_art_tile(ArtTile_RobotnikShip,0,0)
		dc.w   $280
		dc.b  $1C, $20,   5,   0
ObjDat3_750C2:
		dc.l Map_LBZFinalBoss2
		dc.w make_art_tile(ArtTile_LBZFinalBoss2,1,0)
		dc.w $200
		dc.b  $28, $28,   0,   0
ObjDat3_750CE:
		dc.l Map_LBZFinalBoss2
		dc.w make_art_tile(ArtTile_LBZFinalBoss2,1,0)
		dc.w   $180
		dc.b  $20, $10,   2,   0
wordK_750DA:
		dc.w    $80
		dc.b  $14, $14,   4,   0
wordK_750E0:
		dc.w   $180
		dc.b    8,   8,   3,   0
ObjDat3_750E6:
		dc.l Map_LBZFinalBoss2
		dc.w make_art_tile(ArtTile_LBZFinalBoss2,1,0)
		dc.w   $300
		dc.b  $14,  $C,   1,   0
ObjDat3_750F2:
		dc.l Map_LBZFinalBoss2
		dc.w make_art_tile(ArtTile_LBZFinalBoss2,0,0)
		dc.w   $300
		dc.b   $C,  $C,  $C,   0
ObjDat3_750FE:
		dc.l Map_LBZFinalBoss2
		dc.w make_art_tile(ArtTile_LBZFinalBoss2,1,1)
		dc.w   $100
		dc.b  $10, $14,  $D,   0
	if Sonic3_Alone
ObjDat3_51F6C:
		dc.l Map_LBZDeathEggSmall
		dc.w make_art_tile(ArtTile_LBZ2DeathEggSmall,2,0)
		dc.w   $300
		dc.b   $C,  $C,   7,   0
ObjDat3_51F78:
		dc.l Map_LBZDeathEggSmall
		dc.w make_art_tile(ArtTile_LBZ2DeathEggSmall,1,0)
		dc.w   $380
		dc.b  $18, $18,   0,   0
ObjDat3_51F84:
		dc.l Map_LBZDeathEggSmall
		dc.w make_art_tile(ArtTile_LBZ2DeathEggSmall,1,0)
		dc.w   $300
		dc.b    4,   4,   3,   0
ObjDat3_51F90:
		dc.l Map_LBZDeathEggSmall
		dc.w make_art_tile(ArtTile_LBZ2DeathEggSmall,1,0)
		dc.w   $300
		dc.b    4,   4,   4,   0
ObjDat_LBZ2UnusedRobotnik:
		dc.l Map_ScaledArt
		dc.w make_art_tile(ArtTile_LBZFinalBoss2,0,0)
		dc.w   $300
		dc.b  $20, $20,   0,   0
ObjDat3_51FA8:
		dc.l Map_SonicTailsEndPoses
		dc.w make_art_tile(ArtTile_Ending_S3EndPose,0,1)
		dc.w   $300
		dc.b  $40, $40,   0,   0
ChildObjDat_75122:
		dc.w 4-1
		dc.l loc3_511E8
		dc.b  $14, $24
		dc.l loc3_511CE
		dc.b   $C,-$14
		dc.l loc3_51392
		dc.b    0,-$18
		dc.l loc3_513AC
		dc.b  $38,-$14
ChildObjDat_7513C:
		dc.w 1-1
		dc.l loc3_513E8
		dc.b    4,-$34
ChildObjDat_75144:
		dc.w 4-1
		dc.l loc3_512FC
		dc.b -$2A,  -2
		dc.l loc3_512FC
		dc.b -$4A,  -2
		dc.l loc3_512A6
		dc.b    0,   0
		dc.l loc3_5140A
		dc.b -$40,  -2
ChildObjDat_7515E:
		dc.w 5-1
		dc.l loc3_514F6
		dc.b  -$C,-$2C
		dc.l loc3_514F6
		dc.b  $14,-$2C
		dc.l loc3_514F6
		dc.b  $2C,-$18
		dc.l loc3_514F6
		dc.b  -$C,  -4
		dc.l loc3_514F6
		dc.b  $14,  -4
ChildObjDat_52010:
		dc.w 2-1
		dc.l loc3_51524
ChildObjDat_52016:
		dc.w 7-1
		dc.l loc3_516A4
		dc.b    0,   0
		dc.l loc3_516A4
		dc.b -$10, $28
		dc.l loc3_516A4
		dc.b -$70,   0
		dc.l loc3_516A4
		dc.b -$48, $28
		dc.l loc3_516A4
		dc.b  $18, $10
		dc.l loc3_516A4
		dc.b -$24,  -8
		dc.l loc3_516A4
		dc.b -$50, $1C
ChildObjDat_52042:
		dc.w 1-1
		dc.l loc3_51AB8
ChildObjDat_52048:
		dc.w 1-1
		dc.l loc3_51B18
ChildObjDat_5204E:
		dc.w 1-1
		dc.l loc_542B8
ChildObjDat_52054:
		dc.w 1-1
		dc.l loc_54322
	else
ObjDat3_7510A:
		dc.l Map_LBZFinalBoss1
		dc.w make_art_tile(ArtTile_LBZFinalBoss1,1,1)
		dc.w   $300
		dc.b   $C, $10, $16,   0
ObjDat3_75116:
		dc.l Map_LBZFinalBoss1
		dc.w make_art_tile(ArtTile_LBZFinalBoss1,1,1)
		dc.w   $200
		dc.b  $10,   4, $15,   0
ChildObjDat_75122:
		dc.w 4-1
		dc.l locK_749D0
		dc.b  $14, $24
		dc.l locK_749AE
		dc.b   $C,-$14
		dc.l locK_74B9E
		dc.b    0,-$18
		dc.l locK_74BC0
		dc.b  $38,-$14
ChildObjDat_7513C:
		dc.w 1-1
		dc.l locK_74C00
		dc.b    4,-$34
ChildObjDat_75144:
		dc.w 4-1
		dc.l locK_74AFA
		dc.b -$2A,  -2
		dc.l locK_74AFA
		dc.b -$4A,  -2
		dc.l locK_74A9A
		dc.b    0,   0
		dc.l locK_74C24
		dc.b -$40,  -2
ChildObjDat_7515E:
		dc.w 5-1
		dc.l locK_74D14
		dc.b  -$C,-$2C
		dc.l locK_74D14
		dc.b  $14,-$2C
		dc.l locK_74D14
		dc.b  $2C,-$18
		dc.l locK_74D14
		dc.b  -$C,  -4
		dc.l locK_74D14
		dc.b  $14,  -4
ChildObjDat_7517E:
		dc.w 1-1
		dc.l locK_74D48
		dc.b    0,   8
ChildObjDat_75186:
		dc.w 1-1
		dc.l locK_74E12
		dc.b    0, $10
ChildObjDat_7518E:
		dc.w 1-1
		dc.l locK_74E30
	endif
; byte3_5205A:
byteK_75194:
		dc.b    9,   7,   4,   5,   6,   5,   4, $FC
; byte3_52062:
byteK_7519C:
		dc.b    9,  $B,   8,   9,  $A,   9,   8, $FC
; byte3_5206A:
byteK_751A4:	; used in S3, unused in S3K
		dc.b    2,   4,   4,   5,   6, $F4

	if Sonic3_Alone
byte3_52070:
		dc.b    5, $C4
		dc.b    0, $55
		dc.b    0, $59
		dc.b    1, $5A
		dc.b    1, $FF
byte3_5207A:
		dc.b    7, $5A
		dc.b    1, $5A
		dc.b    1, $5A
		dc.b    1, $5A
		dc.b    1, $59
		dc.b    1, $55
		dc.b    0, $56
		dc.b    0, $57
		dc.b    0, $57
		dc.b    0, $57
		dc.b    0, $FF
off3_52090:
		dc.l byte3_52098
		dc.l byte3_520D2
byte3_52098:
		dc.b   $F, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $FF
byte3_520D2:
		dc.b  $7F, $A6
		dc.b    0, $A6
		dc.b    0, $A6
		dc.b    0, $A6
		dc.b    0, $FF
	endif

Pal_LBZFinalBoss2:
		binclude "Levels/LBZ/Palettes/Final Boss 2.bin"
		even

	if Sonic3_Alone
Pal_LBZEnding:
		binclude "Levels/LBZ/Palettes/Ending.bin"
		even
Pal_SonicEndPose:
		binclude "General/Ending/Palettes/Sonic End Pose.bin"
		even
Pal_TailsEndPose:
		binclude "General/Ending/Palettes/Tails End Pose.bin"
		even
Pal_SuperSonicEndPose:
		binclude "General/Ending/Palettes/S3 Super Sonic End Pose.bin"
		even
Map_SonicTailsEndPoses:
		include "General/Ending/Map - Sonic Tails Ending Poses S3.asm"

PalSPtr_LBZFinalBoss2_FadeIn:
		palscriptptr .header, .data
		dc.w 0
.header	palscripthdr	Normal_palette_line_4+$16, 4, 2-1
.data	palscriptdata	16, $ECE, $E8A, $E48, $E46
	palscriptdata	16, $CAC, $C68, $C46, $A44
	palscriptdata	16, $A88, $A46, $824, $622
	palscriptdata	16, $844, $622, $400, $200
	palscriptrun

PalSPtr_LBZFinalBoss2_FadeOut:
		palscriptptr .header, .data
		dc.w 0
.header	palscripthdr	Normal_palette_line_4+$16, 4, 2-1
.data	palscriptdata	16, $844, $622, $400, $200
	palscriptdata	16, $A88, $A46, $824, $622
	palscriptdata	16, $CAC, $C68, $C46, $A44
	palscriptdata	16, $ECE, $E8A, $E48, $E46
	palscriptrun
	endif