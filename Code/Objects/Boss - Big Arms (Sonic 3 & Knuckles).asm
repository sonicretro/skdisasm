		move.w	#(button_right_mask<<8)|button_right_mask,d0
		move.w	(Camera_X_pos).w,d1
		addi.w	#$50,d1
		sub.w	x_pos(a1),d1
		bcc.s	locK_74784
		move.w	#(button_left_mask<<8)|button_left_mask,d0
		neg.w	d1

locK_74784:
		move.w	d0,(Ctrl_1_logical).w
		cmpi.w	#8,d1
		bhs.w	locretK_74374
		move.l	#locK_747D6,(a0)
		clr.w	(Ctrl_1_logical).w
		bset	#0,render_flags(a1)
		bset	#Status_Facing,status(a1)
		jsr	(Stop_Object).l
		moveq	#PLCID_71,d0
		jsr	(Load_PLC).l
		lea	(ArtKosM_EggRoboHead).l,a1
		move.w	#tiles_to_bytes(ArtTile_RobotnikShip),d2
		jsr	(Queue_Kos_Module).l
		bclr	#5,$38(a0)
		lea	(Child1_MakeRoboHead4).l,a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

locK_747D6:
		move.w	#(button_up_mask<<8)|button_up_mask,(Ctrl_1_logical).w
		move.w	y_pos(a0),d0
		addq.w	#1,d0
		move.w	(Camera_Y_pos).w,d1
		addi.w	#$40,d1
		cmp.w	d1,d0
		bhs.s	locK_747F8
		move.w	d0,y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_747F8:
		move.l	#locK_7481C,(a0)
		move.w	#$200,x_vel(a0)
		jsr	(Swing_Setup1).l
		lea	(Child1_MakeRoboShipFlame).l,a2
		jsr	(CreateChild1_Normal).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_7481C:
		move.w	#(button_up_mask<<8)|button_up_mask,(Ctrl_1_logical).w
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		move.w	x_pos(a0),d0
		lea	(Player_1).w,a1
		bclr	#0,render_flags(a1)
		bclr	#Status_Facing,status(a1)
		cmp.w	x_pos(a1),d0
		bhs.s	locK_74854
		bset	#0,render_flags(a1)
		bset	#Status_Facing,status(a1)

locK_74854:
		move.w	(Camera_X_pos).w,d1
		addi.w	#$A0,d1
		cmp.w	d1,d0
		bhs.s	locK_74866
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_74866:
		move.w	d0,x_pos(a0)
		move.l	#locK_74894,(a0)
		move.w	#$1F,$2E(a0)
		move.l	#locK_748A0,$34(a0)
		bclr	#3,$38(a0)
		lea	ChildObjDat_7517E(pc),a2
		jsr	(CreateChild1_Normal).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_74894:
		jsr	(Obj_Wait).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_748A0:
		move.l	#locK_748AE,(a0)
		move.w	#$400,x_vel(a0)
		rts
; ---------------------------------------------------------------------------

locK_748AE:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		move.w	x_pos(a0),d0
		move.w	(Camera_X_pos).w,d1
		addi.w	#$1C0,d1
		cmp.w	d1,d0
		bhs.s	locK_748D0
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_748D0:
		move.l	#locK_748F4,(a0)
		bset	#6,status(a0)
		bset	#4,$38(a0)
		bset	#5,$38(a0)
		clr.b	(Boss_flag).w
		bclr	#7,render_flags(a0)
		rts
; ---------------------------------------------------------------------------

locK_748F4:
		btst	#3,$38(a0)
		beq.s	locretK_74908
		move.l	#locK_7490A,(a0)
		move.w	#(button_right_mask<<8)|button_right_mask,(Ctrl_1_logical).w

locretK_74908:
		rts
; ---------------------------------------------------------------------------

locK_7490A:
		cmpi.w	#$4510,(Player_1+x_pos).w
		blo.s	locretK_74950
		move.l	#locK_74952,(a0)
		lea	(Player_1).w,a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		move.b	#$83,object_control(a1)
		move.b	#$8C,mapping_frame(a1)
		jsr	(Player_Load_PLC).l
		clr.b	anim_frame(a0)
		move.b	#$A,anim_frame_timer(a0)
		move.w	#$200,x_vel(a0)
		move.w	#-$400,y_vel(a0)

locretK_74950:
		rts
; ---------------------------------------------------------------------------

locK_74952:
		jsr	(MoveSprite_LightGravity).l
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locK_7498E
		move.b	#$A,anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)
		moveq	#signextendB($8C),d0
		btst	#0,anim_frame(a0)
		bne.s	locK_74984
		moveq	#signextendB($8D),d0

locK_74984:
		move.b	d0,mapping_frame(a1)
		jsr	(Player_Load_PLC).l

locK_7498E:
		move.w	(_unkFAB0).w,d0
		addi.w	#$200,d0
		cmp.w	(Player_1+y_pos).w,d0
		bhi.w	locretK_74374
		move.w	#$700,d0
		jsr	(StartNewLevel).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locK_749AE:
		lea	ObjDat3_750C2(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#locK_749BE,(a0)

locK_749BE:
		jsr	(Child_GetPriorityOnce).l
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

locK_749D0:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	offK_749E6(pc,d0.w),d1
		jsr	offK_749E6(pc,d1.w)
		moveq	#$C,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------
offK_749E6:
		dc.w locK_749EC-offK_749E6
		dc.w locK_74A14-offK_749E6
		dc.w locK_74A3E-offK_749E6
; ---------------------------------------------------------------------------

locK_749EC:
		lea	ObjDat3_750CE(pc),a1
		jsr	(SetUp_ObjAttributes).l
		movea.w	parent3(a0),a1
		move.w	a0,$44(a1)
		move.b	#$14,child_dx(a0)
		move.b	#-6,child_dy(a0)
		lea	ChildObjDat_75144(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

locK_74A14:
		movea.w	parent3(a0),a1
		btst	#7,art_tile(a1)
		beq.s	locK_74A32
		bset	#7,art_tile(a0)
		move.b	#4,routine(a0)
		move.b	#$AD,collision_flags(a0)

locK_74A32:
		lea	(LBZFinalBoss2_CircleLookup).l,a2
		jmp	(MoveSprite_CircularLookup).l
; ---------------------------------------------------------------------------

locK_74A3E:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.w	locretK_74374
		btst	#2,$38(a1)
		bne.s	locK_74A88
		lea	(Player_1).w,a1
		move.b	$3C(a0),d0
		move.w	y_pos(a0),d1
		sub.w	y_pos(a1),d1
		cmpi.w	#-2,d1
		blt.s	locK_74A7C
		cmpi.w	#2,d1
		ble.s	locK_74A88
		subq.b	#1,d0
		cmpi.b	#-$30,d0
		blt.s	locK_74A88
		bra.w	locK_74A84
; ---------------------------------------------------------------------------

locK_74A7C:
		addq.b	#1,d0
		cmpi.b	#0,d0
		bgt.s	locK_74A88

locK_74A84:
		move.b	d0,$3C(a0)

locK_74A88:
		jsr	(Change_FlipXUseParent).l
		lea	(LBZFinalBoss2_CircleLookup).l,a2
		jmp	(MoveSprite_CircularLookup).l
; ---------------------------------------------------------------------------

locK_74A9A:
		lea	wordK_750E0(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#locK_74ACA,(a0)
		movea.w	parent3(a0),a1
		movea.w	parent3(a1),a2
		move.w	a2,parent3(a0)
		move.w	a1,$44(a0)
		move.w	a1,$44(a0)
		move.b	#$18,child_dx(a0)
		move.b	#-6,child_dy(a0)

locK_74ACA:
		jsr	(Child_GetPriorityOnce).l
		jsr	(Change_FlipXUseParent).l
		movea.w	$44(a0),a1
		move.b	$3C(a1),d0
		addi.b	#$14,d0
		move.b	d0,$3C(a0)
		lea	(LBZ2FinalBoss2_CircleLookup2).l,a2
		jsr	(MoveSprite_CircularLookup).l
		moveq	#$C,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

locK_74AFA:
		lea	wordK_750DA(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		movea.w	parent3(a0),a1
		move.w	parent3(a1),$44(a0)
		move.l	#locK_74B36,(a0)
		move.l	#byteK_75194,$30(a0)
		tst.b	subtype(a0)
		beq.s	locK_74B36
		move.b	#8,mapping_frame(a0)
		move.w	#$180,priority(a0)
		move.l	#byteK_7519C,$30(a0)

locK_74B36:
		jsr	(Child_GetPriorityOnce).l

locK_74B3C:
		jsr	(Refresh_ChildPositionAdjusted).l
		jsr	(Animate_Raw).l
		movea.w	$44(a0),a1
		tst.b	$30(a1)
		beq.s	locK_74B6E
		move.l	#locK_74B76,(a0)
		move.b	#7,mapping_frame(a0)
		tst.b	subtype(a0)
		beq.s	locK_74B6E
		move.b	#$B,mapping_frame(a0)
		addq.b	#8,child_dx(a0)

locK_74B6E:
		moveq	#$C,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

locK_74B76:
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	$44(a0),a1
		tst.b	$30(a1)
		bne.s	locK_74B96
		move.l	#locK_74B3C,(a0)
		tst.b	subtype(a0)
		beq.s	locK_74B96
		subq.b	#8,child_dx(a0)

locK_74B96:
		moveq	#$C,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

locK_74B9E:
		lea	ObjDat3_750E6(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#locK_74BAE,(a0)

locK_74BAE:
		jsr	(Child_GetPriorityOnce).l
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

locK_74BC0:
		lea	ObjDat3_750F2(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#locK_74BD0,(a0)

locK_74BD0:
		move.b	#$9A,d0
		bsr.w	subK_74EBC
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	locK_74BFA
		btst	#0,(V_int_run_count+3).w
		bne.w	locretK_74374
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_74BFA:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locK_74C00:
		move.l	#locK_74C0C,(a0)
		move.b	#$9C,collision_flags(a0)

locK_74C0C:
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	locK_74BFA
		jmp	(Add_SpriteToCollisionResponseList).l
; ---------------------------------------------------------------------------

locK_74C24:
		move.l	#locK_74C34,(a0)
		movea.w	parent3(a0),a1
		move.w	parent3(a1),$44(a0)

locK_74C34:
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		bne.s	locK_74C7A
		btst	#3,$38(a1)
		bne.w	locretK_74374
		btst	#6,status(a1)
		bne.w	locretK_74374
		lea	wordK_74C84(pc),a1
		jsr	(Check_PlayerInRange).l
		tst.w	d0
		beq.s	locretK_74C78
		movea.w	d0,a1
		tst.b	invulnerability_timer(a1)
		bne.s	locretK_74C78
		cmpi.b	#6,routine(a1)
		blo.s	locK_74C8C

locretK_74C78:
		rts
; ---------------------------------------------------------------------------

locK_74C7A:
		clr.b	(Player_1+object_control).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
wordK_74C84:
		dc.w   -$10,   $20,  -$10,   $20
; ---------------------------------------------------------------------------

locK_74C8C:
		move.l	#locK_74CCC,(a0)
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

locK_74CCC:
		movea.w	$44(a0),a1
		tst.b	$30(a1)
		beq.s	locK_74CF8
		btst	#7,status(a1)
		bne.w	locK_74BFA
		jsr	(Refresh_ChildPositionAdjusted).l
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		rts
; ---------------------------------------------------------------------------

locK_74CF8:
		move.l	#locK_74D04,(a0)
		move.w	#$40,$2E(a0)

locK_74D04:
		subq.w	#1,$2E(a0)
		bmi.s	locK_74D0C
		rts
; ---------------------------------------------------------------------------

locK_74D0C:
		move.l	#locK_74C34,(a0)
		rts
; ---------------------------------------------------------------------------

locK_74D14:
		lea	ObjDat3_750FE(pc),a1
		jsr	(SetUp_ObjAttributes).l
		jsr	(Refresh_ChildPositionAdjusted).l
		move.l	#Obj_FlickerMove,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#1,d0
		addi.b	#$D,d0
		move.b	d0,mapping_frame(a0)
		moveq	#0,d0
		jsr	(Set_IndexedVelocity).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_74D48:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	offK_74D5C(pc,d0.w),d1
		jsr	offK_74D5C(pc,d1.w)
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
offK_74D5C:
		dc.w locK_74D62-offK_74D5C
		dc.w locK_74D7C-offK_74D5C
		dc.w locK_74DEA-offK_74D5C
; ---------------------------------------------------------------------------

locK_74D62:
		lea	ObjDat3_7510A(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#$10,y_radius(a0)
		move.l	#locK_74D90,$34(a0)
		rts
; ---------------------------------------------------------------------------

locK_74D7C:
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.w	locretK_74374
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

locK_74D90:
		move.w	y_vel(a0),d0
		cmpi.w	#$100,d0
		blo.s	locK_74DA4
		asr.w	#1,d0
		neg.w	d0
		move.w	d0,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

locK_74DA4:
		move.l	#locK_74DEA,(a0)
		move.b	#$7F,$39(a0)
		movea.w	parent3(a0),a1
		bset	#3,$38(a1)
		lea	(ChildObjDat_690D8).l,a2
		jsr	(CreateChild1_Normal).l
		move.w	#$1000,d0
		move.w	d0,(Camera_stored_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		move.w	#$6000,(Camera_stored_max_X_pos).w
		move.w	#0,(Camera_stored_min_Y_pos).w
		lea	(Child1_Act2LevelSize).l,a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

locK_74DEA:
		bclr	#7,render_flags(a0)
		move.b	(V_int_run_count+3).w,d0
		andi.b	#3,d0
		bne.w	locretK_74374
		subq.b	#1,$39(a0)
		bmi.s	locK_74E0C
		lea	ChildObjDat_7518E(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

locK_74E0C:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locK_74E12:
		lea	ObjDat3_75116(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#locK_74E24,(a0)
		rts
; ---------------------------------------------------------------------------

locK_74E24:
		jsr	(Refresh_ChildPosition).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

locK_74E30:
		jsr	(Random_Number).l
		andi.w	#$3C,d0
		lea	wordK_74E7C(pc,d0.w),a1
		move.w	(a1)+,x_pos(a0)
		move.w	(a1)+,y_pos(a0)
		move.l	#Obj_Wait,(a0)
		move.w	#$60,$2E(a0)
		move.l	#locK_74E70,$34(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild1_Normal).l
		bne.s	locretK_74E6E
		move.b	#4,subtype(a1)

locretK_74E6E:
		rts
; ---------------------------------------------------------------------------

locK_74E70:
		bset	#5,$38(a0)
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------
wordK_74E7C:
		dc.w  $4310,  $3ED
		dc.w  $4330,  $3F0
		dc.w  $4350,  $3F0
		dc.w  $4370,  $3F0
		dc.w  $4390,  $3F0
		dc.w  $43B0,  $3F0
		dc.w  $43D0,  $3F0
		dc.w  $43F0,  $3F0
		dc.w  $4410,  $3F0
		dc.w  $4430,  $3ED
		dc.w  $4450,  $3E5
		dc.w  $4470,  $3D6
		dc.w  $4490,  $3B8
		dc.w  $44B0,  $3A2
		dc.w  $44D0,  $395
		dc.w  $44F0,  $390