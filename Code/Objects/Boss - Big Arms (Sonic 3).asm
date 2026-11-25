		btst	#Status_InAir,status(a1)
		bne.s	locret_51178
		move.w	(Camera_X_pos).w,d0
		addi.w	#$A0,d0
		sub.w	x_pos(a1),d0
		scs	d2
		bpl.s	loc3_51166
		neg.w	d0

loc3_51166:
		cmpi.w	#4,d0
		blo.s	loc3_5117A
		moveq	#button_right,d1
		tst.b	d2
		beq.s	loc3_51174
		moveq	#button_left,d1

loc3_51174:
		bset	d1,(Ctrl_1_held_logical).w

locret_51178:
		rts
; ---------------------------------------------------------------------------

loc3_5117A:
		move.l	#locret_511CC,(a0)
		clr.b	(_unkFA88).w
		clr.w	ground_vel(a1)
		clr.w	x_vel(a1)
		clr.w	y_vel(a1)
		bclr	#0,render_flags(a1)
		bclr	#Status_Facing,status(a1)
		move.w	#(button_up_mask<<8)|button_up_mask,(Ctrl_1_logical).w
		st	(Ctrl_1_locked).w
		jsr	(AllocateObject).l
		bne.s	loc3_511C4
		move.l	#loc3_5182E,(a1)
		lea	(Player_1).w,a2
		move.w	x_pos(a2),x_pos(a1)
		move.w	y_pos(a2),y_pos(a1)

loc3_511C4:
		lea	ChildObjDat_52010(pc),a2
		jmp	CreateChild6_Simple(pc)
; ---------------------------------------------------------------------------

locret_511CC:
		rts
; ---------------------------------------------------------------------------

loc3_511CE:
		lea	ObjDat3_750C2(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc3_511DC,(a0)

loc3_511DC:
		jsr	Child_GetPriorityOnce(pc)
		jsr	Refresh_ChildPositionAdjusted(pc)
		jmp	Child_Draw_Sprite2(pc)
; ---------------------------------------------------------------------------

loc3_511E8:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off3_511FC(pc,d0.w),d1
		jsr	off3_511FC(pc,d1.w)
		moveq	#$C,d0
		jmp	Child_DrawTouch_Sprite_FlickerMove(pc)
; ---------------------------------------------------------------------------
off3_511FC:
		dc.w loc3_51202-off3_511FC
		dc.w loc3_51226-off3_511FC
		dc.w loc3_5124E-off3_511FC
; ---------------------------------------------------------------------------

loc3_51202:
		lea	ObjDat3_750CE(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		movea.w	parent3(a0),a1
		move.w	a0,$44(a1)
		move.b	#$14,child_dx(a0)
		move.b	#-6,child_dy(a0)
		lea	ChildObjDat_75144(pc),a2
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------

loc3_51226:
		movea.w	parent3(a0),a1
		btst	#7,art_tile(a1)
		beq.s	loc3_51244
		bset	#7,art_tile(a0)
		move.b	#4,routine(a0)
		move.b	#$AD,collision_flags(a0)

loc3_51244:
		lea	(LBZFinalBoss2_CircleLookup).l,a2
		jmp	MoveSprite_CircularLookup(pc)
; ---------------------------------------------------------------------------

loc3_5124E:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.w	locretK_74374
		btst	#2,$38(a1)
		bne.s	loc3_51298
		lea	(Player_1).w,a1
		move.b	$3C(a0),d0
		move.w	y_pos(a0),d1
		sub.w	y_pos(a1),d1
		cmpi.w	#-2,d1
		blt.s	loc3_5128C
		cmpi.w	#2,d1
		ble.s	loc3_51298
		subq.b	#1,d0
		cmpi.b	#-$30,d0
		blt.s	loc3_51298
		bra.w	loc3_51294
; ---------------------------------------------------------------------------

loc3_5128C:
		addq.b	#1,d0
		cmpi.b	#0,d0
		bgt.s	loc3_51298

loc3_51294:
		move.b	d0,$3C(a0)

loc3_51298:
		jsr	Change_FlipXUseParent(pc)
		lea	(LBZFinalBoss2_CircleLookup).l,a2
		jmp	MoveSprite_CircularLookup(pc)
; ---------------------------------------------------------------------------

loc3_512A6:
		lea	wordK_750E0(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc3_512D4,(a0)
		movea.w	parent3(a0),a1
		movea.w	parent3(a1),a2
		move.w	a2,parent3(a0)
		move.w	a1,$44(a0)
		move.w	a1,$44(a0)
		move.b	#$18,child_dx(a0)
		move.b	#-6,child_dy(a0)

loc3_512D4:
		jsr	Child_GetPriorityOnce(pc)
		jsr	Change_FlipXUseParent(pc)
		movea.w	$44(a0),a1
		move.b	$3C(a1),d0
		addi.b	#$14,d0
		move.b	d0,$3C(a0)
		lea	(LBZ2FinalBoss2_CircleLookup2).l,a2
		jsr	MoveSprite_CircularLookup(pc)
		moveq	#$C,d0
		jmp	Child_DrawTouch_Sprite_FlickerMove(pc)
; ---------------------------------------------------------------------------

loc3_512FC:
		lea	wordK_750DA(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		movea.w	parent3(a0),a1
		move.w	parent3(a1),$44(a0)
		move.l	#loc3_51336,(a0)
		move.l	#byteK_75194,$30(a0)
		tst.b	subtype(a0)
		beq.s	loc3_51336
		move.b	#8,mapping_frame(a0)
		move.w	#$180,priority(a0)
		move.l	#byteK_7519C,$30(a0)

loc3_51336:
		jsr	Child_GetPriorityOnce(pc)

loc3_5133A:
		jsr	Refresh_ChildPositionAdjusted(pc)
		jsr	Animate_Raw(pc)
		movea.w	$44(a0),a1
		tst.b	$30(a1)
		beq.s	loc3_51368
		move.l	#loc3_5136E,(a0)
		move.b	#7,mapping_frame(a0)
		tst.b	subtype(a0)
		beq.s	loc3_51368
		move.b	#$B,mapping_frame(a0)
		addq.b	#8,child_dx(a0)

loc3_51368:
		moveq	#$C,d0
		jmp	Child_DrawTouch_Sprite_FlickerMove(pc)
; ---------------------------------------------------------------------------

loc3_5136E:
		jsr	Refresh_ChildPositionAdjusted(pc)
		movea.w	$44(a0),a1
		tst.b	$30(a1)
		bne.s	loc3_5138C
		move.l	#loc3_5133A,(a0)
		tst.b	subtype(a0)
		beq.s	loc3_5138C
		subq.b	#8,child_dx(a0)

loc3_5138C:
		moveq	#$C,d0
		jmp	Child_DrawTouch_Sprite_FlickerMove(pc)
; ---------------------------------------------------------------------------

loc3_51392:
		lea	ObjDat3_750E6(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc3_513A0,(a0)

loc3_513A0:
		jsr	Child_GetPriorityOnce(pc)
		jsr	Refresh_ChildPositionAdjusted(pc)
		jmp	Child_Draw_Sprite2(pc)
; ---------------------------------------------------------------------------

loc3_513AC:
		lea	ObjDat3_750F2(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc3_513BA,(a0)

loc3_513BA:
		move.b	#$9A,d0
		bsr.w	subK_74EBC
		jsr	Refresh_ChildPositionAdjusted(pc)
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc3_513E2
		btst	#0,(V_int_run_count+3).w
		bne.w	locretK_74374
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc3_513E2:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc3_513E8:
		move.l	#loc3_513F4,(a0)
		move.b	#$99,collision_flags(a0)

loc3_513F4:
		jsr	Refresh_ChildPositionAdjusted(pc)
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc3_513E2
		jmp	(Add_SpriteToCollisionResponseList).l
; ---------------------------------------------------------------------------

loc3_5140A:
		move.l	#loc3_5141A,(a0)
		movea.w	parent3(a0),a1
		move.w	parent3(a1),$44(a0)

loc3_5141A:
		jsr	Refresh_ChildPositionAdjusted(pc)
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		bne.s	loc3_5145E
		btst	#3,$38(a1)
		bne.w	locretK_74374
		btst	#6,status(a1)
		bne.w	locretK_74374
		lea	word3_51468(pc),a1
		jsr	(Check_PlayerInRange).l
		tst.w	d0
		beq.s	locret_5145C
		movea.w	d0,a1
		tst.b	invulnerability_timer(a1)
		bne.s	locret_5145C
		cmpi.b	#6,routine(a1)
		blo.s	loc3_51470

locret_5145C:
		rts
; ---------------------------------------------------------------------------

loc3_5145E:
		clr.b	(Player_1+object_control).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
word3_51468:
		dc.w   -$18,   $30,  -$18,   $30
; ---------------------------------------------------------------------------

loc3_51470:
		move.l	#loc3_514B0,(a0)
		movea.w	$44(a0),a1
		st	$30(a1)
		move.b	#$1E,routine(a1)
		move.w	#$40,$2E(a1)
		move.l	#locK_74562,$34(a1)
		lea	(Player_1).w,a1
		move.b	#$81,object_control(a1)
		move.b	#2,anim(a1)
		moveq	#0,d0
		move.w	d0,x_vel(a1)
		move.w	d0,y_vel(a1)
		move.w	d0,ground_vel(a1)

loc3_514B0:
		movea.w	$44(a0),a1
		tst.b	$30(a1)
		beq.s	loc3_514DA
		btst	#7,status(a1)
		bne.w	loc3_513E2
		jsr	Refresh_ChildPositionAdjusted(pc)
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		rts
; ---------------------------------------------------------------------------

loc3_514DA:
		move.l	#loc3_514E6,(a0)
		move.w	#$40,$2E(a0)

loc3_514E6:
		subq.w	#1,$2E(a0)
		bmi.s	loc3_514EE
		rts
; ---------------------------------------------------------------------------

loc3_514EE:
		move.l	#loc3_5141A,(a0)
		rts
; ---------------------------------------------------------------------------

loc3_514F6:
		lea	ObjDat3_750FE(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		jsr	Refresh_ChildPositionAdjusted(pc)
		move.l	#Obj_FlickerMove,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#1,d0
		addi.b	#$D,d0
		move.b	d0,mapping_frame(a0)
		moveq	#0,d0
		jsr	Set_IndexedVelocity(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc3_51524:
		move.l	#loc3_5155A,(a0)
		move.w	#$4430,x_pos(a0)
		move.w	#$728,y_pos(a0)
		move.w	#$1010,$3A(a0)
		move.w	#$200,d0
		tst.b	subtype(a0)
		beq.s	loc3_51548
		neg.w	d0

loc3_51548:
		move.w	d0,x_vel(a0)
		move.w	#$41,$2E(a0)
		move.l	#loc3_51576,$34(a0)

loc3_5155A:
		subq.b	#1,$39(a0)
		bpl.s	loc3_5156C
		move.b	#3,$39(a0)
		jsr	(sub_52850).l

loc3_5156C:
		jsr	(MoveSprite2).l
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc3_51576:
		clr.w	x_vel(a0)
		move.w	#-$200,y_vel(a0)
		move.w	#$57,$2E(a0)
		move.l	#loc3_51590,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc3_51590:
		lea	Child6_CreateBossExplosion(pc),a2
		jsr	CreateChild1_Normal(pc)
		bne.s	loc3_515AC
		move.w	#$4430,x_pos(a1)
		move.w	#$678,y_pos(a1)
		move.b	#$C,subtype(a1)

loc3_515AC:
		tst.b	subtype(a0)
		bne.s	loc3_515DE
		jsr	(AllocateObject).l
		bne.s	loc3_515DE
		move.l	#loc3_515E2,(a1)
		move.w	(Camera_X_pos).w,d0
		addi.w	#$D0,d0
		move.w	d0,x_pos(a1)
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$20,d0
		move.w	d0,y_pos(a1)
		move.w	#5,$3A(a1)

loc3_515DE:
		jmp	Go_Delete_Sprite(pc)
; ---------------------------------------------------------------------------

loc3_515E2:
		subq.w	#1,$2E(a0)
		bpl.s	locret_51618
		addq.b	#1,$39(a0)
		cmpi.b	#8,$39(a0)
		bne.s	loc3_515F8
		st	(Events_fg_5).w

loc3_515F8:
		cmpi.b	#$18,$39(a0)
		bcc.s	loc3_5161A
		move.w	$3A(a0),$2E(a0)
		addq.w	#1,$3A(a0)
		jsr	(AllocateObject).l
		bne.s	locret_51618
		move.l	#loc3_5165C,(a1)

locret_51618:
		rts
; ---------------------------------------------------------------------------

loc3_5161A:
		move.l	#loc3_51626,(a0)
		move.w	#$17F,$2E(a0)

loc3_51626:
		subq.w	#1,$2E(a0)
		bmi.s	loc3_5162E
		rts
; ---------------------------------------------------------------------------

loc3_5162E:
		bset	#0,(_unkFA88).w
		clr.b	$39(a0)
		clr.w	$2E(a0)
		jsr	(AllocateObject).l
		bne.s	loc3_51650
		move.l	#loc3_517FE,(a1)
		move.b	#4,subtype(a1)

loc3_51650:
		lea	ChildObjDat_52016(pc),a2
		jsr	CreateChild1_Normal(pc)
		jmp	Go_Delete_Sprite(pc)
; ---------------------------------------------------------------------------

loc3_5165C:
		lea	ObjDat3_51F6C(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#MoveChkDel,(a0)
		jsr	(Random_Number).l
		andi.w	#7,d0
		move.b	RawAni_5169C(pc,d0.w),mapping_frame(a0)
		swap	d0
		andi.w	#$FF,d0
		move.w	(Camera_X_pos).w,d1
		addi.w	#$20,d1
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$20,d0
		move.w	d0,y_pos(a0)
		rts
; ---------------------------------------------------------------------------
RawAni_5169C:
		dc.b    7,   8,   9,  $A,  $B,   7,   8,   9
		even
; ---------------------------------------------------------------------------

loc3_516A4:
		lea	ObjDat3_51F78(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc3_516FA,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		beq.s	loc3_516C0
		move.l	#loc3_5173E,(a0)

loc3_516C0:
		move.w	word3_516EA(pc,d0.w),y_vel(a0)
		lea	byte3_516DC(pc,d0.w),a1
		move.b	(a1)+,mapping_frame(a0)
		move.b	(a1)+,d0
		or.b	d0,render_flags(a0)
		lea	Pal_LBZEnding(pc),a1
		jmp	PalLoad_Line1(pc)
; ---------------------------------------------------------------------------
byte3_516DC:
		dc.b    0,   0
		dc.b    1,   0
		dc.b    1,   0
		dc.b    2,   0
		dc.b    2,   1
		dc.b    2,   2
		dc.b    2,   3
		even
word3_516EA:
		dc.w    $40
		dc.w    $38
		dc.w    $3C
		dc.w    $40
		dc.w    $44
		dc.w    $48
		dc.w    $4C
		dc.w    $50
; ---------------------------------------------------------------------------

loc3_516FA:
		bsr.w	sub3_5174A
		move.b	(V_int_run_count+3).w,d0
		andi.b	#$F,d0
		bne.s	loc3_51730
		lea	ChildObjDat_52042(pc),a2
		jsr	CreateChild6_Simple(pc)
		jsr	(Random_Number).l
		andi.w	#$1F,d0
		subi.w	#$10,d0
		add.w	d0,x_pos(a1)
		swap	d0
		andi.w	#$1F,d0
		subi.w	#$10,d0
		add.w	d0,y_pos(a1)

loc3_51730:
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$A0,d0
		cmp.w	y_pos(a0),d0
		bcs.s	loc3_51764

loc3_5173E:
		jsr	(MoveSprite2).l
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub3_5174A:
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$80,d0
		cmp.w	y_pos(a0),d0
		bcc.s	locret_51762
		moveq	#signextendB(cmd_FadeOut),d0
		jsr	(Play_Music).l
		move.l	(sp),(a0)

locret_51762:
		rts
; End of function sub3_5174A

; ---------------------------------------------------------------------------

loc3_51764:
		lea	ChildObjDat_5204E(pc),a2
		jsr	CreateChild6_Simple(pc)
		bne.w	locretK_74374
		move.w	a1,$44(a0)
		lea	(Normal_palette).w,a1
		lea	(Target_palette).w,a2
		moveq	#bytesToLcnt($80),d0

loc3_5177E:
		move.l	(a1)+,(a2)+
		dbf	d0,loc3_5177E
		move.l	#loc3_517BA,(a0)
		moveq	#signextendB(sfx_FlamethrowerQuiet),d0
		jsr	(Play_SFX).l
		moveq	#signextendB(mus_Ending),d0
		jsr	(Play_Music).l
		jsr	sub_5439C(pc)
		lsl.w	#2,d0
		movea.l	off3_517AE(pc,d0.w),a1
		move.w	#tiles_to_bytes(ArtTile_Ending_S3EndPose),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------
off3_517AE:
		dc.l ArtKosM_SonicEndPose
		dc.l ArtKosM_TailsEndPose
		dc.l ArtKosM_SuperSonicEndPose
; ---------------------------------------------------------------------------

loc3_517BA:
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		beq.s	loc3_517DE
		clr.b	(Level_started_flag).w
		lea	ChildObjDat_52054(pc),a2
		jsr	CreateChild6_Simple(pc)
		bne.s	loc3_517DE
		move.w	a1,$44(a0)
		move.l	#loc3_517E4,(a0)

loc3_517DE:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc3_517E4:
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		beq.w	locretK_74374
		bset	#1,(_unkFA88).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc3_517FE:
		move.l	#loc3_5182A,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		movea.l	off3_51822(pc,d0.w),a1
		lea	(Palette_rotation_data).w,a2
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		clr.w	(a2)
		move.l	#Go_Delete_Sprite,(Palette_rotation_custom).w
		rts
; ---------------------------------------------------------------------------
off3_51822:
		dc.l PalSPtr_LBZFinalBoss2_FadeIn
		dc.l PalSPtr_LBZFinalBoss2_FadeOut
; ---------------------------------------------------------------------------

loc3_5182A:
		jmp	Run_PalRotationScript(pc)
; ---------------------------------------------------------------------------

loc3_5182E:
		btst	#0,(_unkFA88).w
		beq.w	locretK_74374
		move.l	#loc3_5185A,(a0)
		move.l	#loc3_51868,$34(a0)
		clr.b	(Ctrl_1_locked).w
		lea	(Player_1).w,a1
		move.b	#$53,object_control(a1)
		move.b	#0,anim(a1)

loc3_5185A:
		lea	byte3_52070(pc),a1
		bsr.w	Animate_ExternalPlayerSprite
		jmp	(Player_Load_PLC).l
; ---------------------------------------------------------------------------

loc3_51868:
		move.l	#loc3_5186E,(a0)

loc3_5186E:
		btst	#1,(_unkFA88).w
		beq.w	locretK_74374
		move.l	#loc3_5188E,(a0)
		move.l	#loc3_5189C,$34(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)

loc3_5188E:
		lea	byte3_5207A(pc),a1
		bsr.w	Animate_ExternalPlayerSprite
		jmp	(Player_Load_PLC).l
; ---------------------------------------------------------------------------

loc3_5189C:
		move.l	#loc3_518CE,(a0)
		move.w	#$FF,$2E(a0)
		move.l	#loc3_518E2,$34(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		lea	(Player_1).w,a1
		moveq	#0,d0
		move.b	character_id(a1),d0
		lsl.w	#2,d0
		lea	off3_52090(pc),a2
		move.l	(a2,d0.w),$30(a0)

loc3_518CE:
		movea.l	$30(a0),a1
		bsr.w	Animate_ExternalPlayerSprite
		jsr	(Player_Load_PLC).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc3_518E2:
		move.l	#loc3_518E8,(a0)

loc3_518E8:
		lea	ObjDat3_51FA8(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		lea	(Player_1).w,a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		movea.w	(_unkFAA4).w,a1
		move.l	#Go_Delete_Sprite,(a1)
		jsr	sub_5439C(pc)
		moveq	#0,d1
		subq.w	#1,d0
		beq.s	loc3_51920
		bmi.s	loc3_51922
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	loc3_5191E
		addq.w	#4,d1

loc3_5191E:
		addq.w	#4,d1

loc3_51920:
		addq.w	#4,d1

loc3_51922:
		move.l	off3_5192C(pc,d1.w),(a0)
		move.w	d1,$3A(a0)
		rts
; ---------------------------------------------------------------------------
off3_5192C:
		dc.l loc3_5193C
		dc.l loc3_51994
		dc.l loc3_519B8
		dc.l loc3_51A62
; ---------------------------------------------------------------------------

loc3_5193C:
		move.l	#loc3_5195E,(a0)
		move.w	#6,$2E(a0)
		move.b	#0,mapping_frame(a0)
		subi.w	#$10,y_pos(a0)
		move.b	#0,(Player_1+mapping_frame).w
		bsr.w	sub3_51EB0

loc3_5195E:
		subq.w	#1,$2E(a0)
		bpl.s	loc3_51982
		move.l	#Wait_Draw,(a0)
		addq.b	#1,mapping_frame(a0)
		move.w	#5*60,$2E(a0)
		move.l	#loc3_51988,$34(a0)
		subi.w	#$20,y_pos(a0)

loc3_51982:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc3_51988:
		move.b	#GameMode_S3Credits,(Game_mode).w
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc3_51994:
		move.l	#loc3_5195E,(a0)
		move.w	#4,$2E(a0)
		move.b	#2,mapping_frame(a0)
		subi.w	#$10,y_pos(a0)
		move.b	#0,(Player_1+mapping_frame).w
		bsr.w	sub3_51EB0
		bra.s	loc3_5195E
; ---------------------------------------------------------------------------

loc3_519B8:
		move.l	#loc3_519E0,(a0)
		move.b	#4,mapping_frame(a0)
		move.w	#$100,x_vel(a0)
		move.w	#-$600,y_vel(a0)
		lea	(Player_1).w,a1
		move.b	#$81,object_control(a1)
		move.b	#2,anim(a1)

loc3_519E0:
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		jsr	(MoveSprite).l
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$140,d0
		cmp.w	y_pos(a0),d0
		bcs.s	loc3_51A06
		rts
; ---------------------------------------------------------------------------

loc3_51A06:
		move.l	#loc3_51A34,(a0)
		move.w	(Camera_X_pos).w,d0
		addi.w	#$180,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$C0,d0
		move.w	d0,y_pos(a0)
		move.w	#-$800,x_vel(a0)
		move.w	#-$400,y_vel(a0)
		bra.w	sub3_51EB0
; ---------------------------------------------------------------------------

loc3_51A34:
		jsr	(MoveSprite2).l
		move.w	(Camera_X_pos).w,d0
		addi.w	#$A0,d0
		cmp.w	x_pos(a0),d0
		bcs.s	loc3_51A5C
		move.l	#Wait_Draw,(a0)
		move.w	#3*60,$2E(a0)
		move.l	#loc3_51988,$34(a0)

loc3_51A5C:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc3_51A62:
		move.l	#loc3_51A90,(a0)
		move.b	#4,mapping_frame(a0)
		move.w	#$600,x_vel(a0)
		lea	(Player_1).w,a1
		move.b	#$81,object_control(a1)
		move.b	#0,anim(a1)
		move.w	#$600,x_vel(a1)
		move.w	#$600,ground_vel(a1)

loc3_51A90:
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		jsr	(MoveSprite2).l
		move.w	(Camera_X_pos).w,d0
		addi.w	#$180,d0
		cmp.w	y_pos(a0),d0
		bcs.w	loc3_51A06
		rts
; ---------------------------------------------------------------------------

loc3_51AB8:
		lea	ObjDat3_51F84(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc3_51AE2,(a0)
		move.w	#-$40,y_vel(a0)
		move.w	#$7F,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		lea	ChildObjDat_52048(pc),a2
		jsr	CreateChild6_Simple(pc)

loc3_51AE2:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#3,d0
		bne.s	loc3_51B08
		move.b	$39(a0),d0
		addq.b	#1,d0
		move.b	d0,$39(a0)
		andi.b	#3,d0
		move.b	render_flags(a0),d1
		andi.b	#$FC,d1
		or.b	d0,d1
		move.b	d1,render_flags(a0)

loc3_51B08:
		jsr	(MoveSprite2).l
		jsr	Obj_Wait(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc3_51B18:
		lea	ObjDat3_51F90(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc3_51B3C,(a0)
		move.l	#byteK_751A4,$30(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		move.w	#$40,y_vel(a0)

loc3_51B3C:
		jsr	Animate_Raw(pc)
		jsr	(MoveSprite2).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_LBZ2UnusedRobotnik:
		lea	ObjDat_LBZ2UnusedRobotnik(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc3_51BB6,(a0)
		bset	#0,render_flags(a0)
		move.w	#tiles_to_bytes(ArtTile_LBZFinalBoss2),$3A(a0)
		move.b	#$30,$25(a0)
		move.w	(Camera_X_pos).w,d0
		addi.w	#$60,d0
		move.w	d0,x_pos(a0)
		move.w	d0,$30(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$100,d0
		move.w	d0,y_pos(a0)
		move.w	d0,$34(a0)
		move.w	#$800,x_vel(a0)
		move.w	#-$3C0,y_vel(a0)
		move.b	#4,$40(a0)
		move.l	#ArtScaled_LBZ2UnusedRobotnik,$42(a0)
		move.b	#1,$3E(a0)
		bsr.w	Perform_Art_Scaling
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc3_51BB6:
		bsr.w	sub3_51E3A
		bsr.w	subK_86180
		bsr.w	subK_8619A
		jmp	(Draw_Sprite).l