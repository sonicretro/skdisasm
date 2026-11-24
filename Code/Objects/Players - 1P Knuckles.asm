; ---------------------------------------------------------------------------

Obj_Knuckles:
		lea	(Max_speed).w,a4
		lea	(Distance_from_top).w,a5
		lea	(Dust).w,a6
		tst.w	(Debug_placement_mode).w
		beq.s	Knuckles_Normal
		cmpi.b	#1,(Debug_placement_type).w
		beq.s	locK_16488
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	locK_1646C
		move.w	#0,(Debug_placement_mode).w

locK_1646C:
		addq.b	#1,mapping_frame(a0)
		cmpi.b	#$FB,mapping_frame(a0)
		blo.s	locK_1647E
		move.b	#0,mapping_frame(a0)

locK_1647E:
		bsr.w	Knuckles_Load_PLC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_16488:
		jmp	(DebugMode).l
; ---------------------------------------------------------------------------

Knuckles_Normal:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Knuckles_Index(pc,d0.w),d1
		jmp	Knuckles_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Knuckles_Index:
		dc.w Knuckles_Init-Knuckles_Index
		dc.w Knuckles_Control-Knuckles_Index
		dc.w locK_17BB6-Knuckles_Index
		dc.w locK_17C88-Knuckles_Index
		dc.w locK_17CBA-Knuckles_Index
		dc.w locK_17CCE-Knuckles_Index
		dc.w locK_17CEA-Knuckles_Index
; ---------------------------------------------------------------------------

Knuckles_Init:
		addq.b	#2,routine(a0)
		move.b	#$13,y_radius(a0)
		move.b	#9,x_radius(a0)
		move.b	#$13,default_y_radius(a0)
		move.b	#9,default_x_radius(a0)
		move.l	#Map_Knuckles,mappings(a0)
		move.w	#$100,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#4,render_flags(a0)
		move.b	#2,character_id(a0)
		move.w	#$600,Max_speed-Max_speed(a4)
		move.w	#$C,Acceleration-Max_speed(a4)
		move.w	#$80,Deceleration-Max_speed(a4)
		tst.b	(Last_star_post_hit).w
		bne.s	Knuckles_Init_Continued
		move.w	#make_art_tile(ArtTile_Player_1,0,0),art_tile(a0)
		move.b	#$C,top_solid_bit(a0)
		move.b	#$D,lrb_solid_bit(a0)
		cmpi.b	#2,(Special_bonus_entry_flag).w
		beq.s	Knuckles_Init_Continued
		move.w	x_pos(a0),(Saved_X_pos).w
		move.w	y_pos(a0),(Saved_Y_pos).w
		move.w	art_tile(a0),(Saved_art_tile).w
		move.w	top_solid_bit(a0),(Saved_solid_bits).w

Knuckles_Init_Continued:
		move.b	#0,flips_remaining(a0)
		move.b	#4,flip_speed(a0)
		move.b	#0,(Super_Sonic_Knux_flag).w
		move.b	#30,air_left(a0)
		subi.w	#$20,x_pos(a0)
		addi.w	#4,y_pos(a0)
		jsr	(Reset_Player_Position_Array).l
		addi.w	#$20,x_pos(a0)
		subi.w	#4,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

Knuckles_Control:
		tst.w	(Debug_mode_flag).w
		beq.s	locK_165A2
		bclr	#button_A,(Ctrl_1_pressed).w
		beq.s	locK_16580
		eori.b	#1,(Reverse_gravity_flag).w

locK_16580:
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	locK_165A2
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		btst	#button_C,(Ctrl_1_held).w
		beq.s	locretK_165A0
		move.w	#2,(Debug_placement_mode).w

locretK_165A0:
		rts
; ---------------------------------------------------------------------------

locK_165A2:
		tst.b	(Ctrl_1_locked).w
		bne.s	locK_165AE
		move.w	(Ctrl_1).w,(Ctrl_1_logical).w

locK_165AE:
		btst	#0,object_control(a0)
		beq.s	locK_165BE
		move.b	#0,double_jump_flag(a0)
		bra.s	locK_165D8
; ---------------------------------------------------------------------------

locK_165BE:
		movem.l	a4-a6,-(sp)
		moveq	#0,d0
		move.b	status(a0),d0
		andi.w	#6,d0
		move.w	Knux_Modes(pc,d0.w),d1
		jsr	Knux_Modes(pc,d1.w)
		movem.l	(sp)+,a4-a6

locK_165D8:
		cmpi.w	#-$100,(Camera_min_Y_pos).w
		bne.s	locK_165E8
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)

locK_165E8:
		bsr.s	Knuckles_Display
		bsr.w	SonicKnux_SuperHyper
		bsr.w	Sonic_RecordPos
		bsr.w	Knuckles_Water
		move.b	(Primary_Angle).w,next_tilt(a0)
		move.b	(Secondary_Angle).w,tilt(a0)
		tst.b	(WindTunnel_flag).w
		beq.s	locK_16614
		tst.b	anim(a0)
		bne.s	locK_16614
		move.b	prev_anim(a0),anim(a0)

locK_16614:
		btst	#1,object_control(a0)
		bne.s	locK_16630
		bsr.w	Animate_Knuckles
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_1662C
		eori.b	#2,render_flags(a0)

locK_1662C:
		bsr.w	Knuckles_Load_PLC

locK_16630:
		move.b	object_control(a0),d0
		andi.b	#$A0,d0
		bne.s	locretK_16640
		jsr	(TouchResponse).l

locretK_16640:
		rts
; ---------------------------------------------------------------------------
Knux_Modes:
		dc.w Knux_Stand_Path-Knux_Modes
		dc.w Knux_Stand_Freespace-Knux_Modes
		dc.w Knux_Spin_Path-Knux_Modes
		dc.w Knux_Spin_Freespace-Knux_Modes

; =============== S U B R O U T I N E =======================================


Knuckles_Display:
		move.b	invulnerability_timer(a0),d0
		beq.s	locK_16658
		subq.b	#1,invulnerability_timer(a0)
		lsr.b	#3,d0
		bcc.s	locK_1665E

locK_16658:
		jsr	(Draw_Sprite).l

locK_1665E:
		btst	#Status_Invincible,status_secondary(a0)
		beq.s	locK_1669A
		tst.b	invincibility_timer(a0)
		beq.s	locK_1669A
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0
		bne.s	locK_1669A
		subq.b	#1,invincibility_timer(a0)
		bne.s	locK_1669A
		tst.b	(Boss_flag).w
		bne.s	locK_16694
		cmpi.b	#12,air_left(a0)
		blo.s	locK_16694
		move.w	(Current_music).w,d0
		jsr	(Play_Music).l

locK_16694:
		bclr	#Status_Invincible,status_secondary(a0)

locK_1669A:
		btst	#Status_SpeedShoes,status_secondary(a0)
		beq.s	locretK_166EC
		tst.b	speed_shoes_timer(a0)
		beq.s	locretK_166EC
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0
		bne.s	locretK_166EC
		subq.b	#1,speed_shoes_timer(a0)
		bne.s	locretK_166EC
		move.w	#$600,Max_speed-Max_speed(a4)
		move.w	#$C,Acceleration-Max_speed(a4)
		move.w	#$80,Deceleration-Max_speed(a4)
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	locK_166DE
		move.w	#$800,Max_speed-Max_speed(a4)
		move.w	#$18,Acceleration-Max_speed(a4)
		move.w	#$C0,Deceleration-Max_speed(a4)

locK_166DE:
		bclr	#Status_SpeedShoes,status_secondary(a0)
		moveq	#0,d0
		jmp	(Change_Music_Tempo).l
; ---------------------------------------------------------------------------

locretK_166EC:
		rts
; End of function Knuckles_Display


; =============== S U B R O U T I N E =======================================


Knuckles_Water:
		tst.b	(Water_flag).w
		bne.s	locK_166F6

locretK_166F4:
		rts
; ---------------------------------------------------------------------------

locK_166F6:
		move.w	(Water_level).w,d0
		cmp.w	y_pos(a0),d0
		bge.s	locK_1676E
		bset	#Status_Underwater,status(a0)
		bne.s	locretK_166F4
		addq.b	#1,(Water_entered_counter).w
		movea.l	a0,a1
		bsr.w	Player_ResetAirTimer
		move.l	#Obj_AirCountdown,(Breathing_bubbles).w
		move.b	#$81,(Breathing_bubbles+subtype).w
		move.l	a0,(Breathing_bubbles+$40).w
		move.w	#$300,Max_speed-Max_speed(a4)
		move.w	#6,Acceleration-Max_speed(a4)
		move.w	#$40,Deceleration-Max_speed(a4)
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	locK_1674A
		move.w	#$400,Max_speed-Max_speed(a4)
		move.w	#$C,Acceleration-Max_speed(a4)
		move.w	#$60,Deceleration-Max_speed(a4)

locK_1674A:
		tst.b	object_control(a0)
		bne.s	locretK_166F4
		asr	x_vel(a0)
		asr	y_vel(a0)
		asr	y_vel(a0)
		beq.s	locretK_166F4
		move.w	#1<<8,anim(a6)	; and prev_anim
		move.w	#sfx_Splash,d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

locK_1676E:
		bclr	#Status_Underwater,status(a0)
		beq.w	locretK_166F4
		addq.b	#1,(Water_entered_counter).w
		movea.l	a0,a1
		bsr.w	Player_ResetAirTimer
		move.w	#$600,Max_speed-Max_speed(a4)
		move.w	#$C,Acceleration-Max_speed(a4)
		move.w	#$80,Deceleration-Max_speed(a4)
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	locK_167A8
		move.w	#$800,Max_speed-Max_speed(a4)
		move.w	#$18,Acceleration-Max_speed(a4)
		move.w	#$C0,Deceleration-Max_speed(a4)

locK_167A8:
		cmpi.b	#4,routine(a0)
		beq.s	locK_167C4
		tst.b	object_control(a0)
		bne.s	locK_167C4
		move.w	y_vel(a0),d0
		cmpi.w	#-$400,d0
		blt.s	locK_167C4
		asl	y_vel(a0)

locK_167C4:
		cmpi.b	#$1C,anim(a0)
		beq.w	locretK_166F4
		tst.w	y_vel(a0)
		beq.w	locretK_166F4
		move.w	#1<<8,anim(a6)	; and prev_anim
		cmpi.w	#-$1000,y_vel(a0)
		bgt.s	locK_167EA
		move.w	#-$1000,y_vel(a0)

locK_167EA:
		move.w	#sfx_Splash,d0
		jmp	(Play_SFX).l
; End of function Knuckles_Water

; ---------------------------------------------------------------------------

Knux_Stand_Path:
		bsr.w	SonicKnux_Spindash
		bsr.w	Knux_Jump
		bsr.w	Player_SlopeResist
		bsr.w	Knux_InputAcceleration_Path
		bsr.w	SonicKnux_Roll
		bsr.w	Player_LevelBound
		jsr	(MoveSprite_TestGravity2).l
		bsr.w	Call_Player_AnglePos
		bsr.w	Player_SlopeRepel
		tst.b	(Background_collision_flag).w
		beq.s	locretK_1684A
		bsr.w	sub_F846
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	locK_1683A
		sub.w	d1,x_pos(a0)

locK_1683A:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locK_16846
		add.w	d1,x_pos(a0)

locK_16846:
		movem.l	(sp)+,a4-a6

locretK_1684A:
		rts
; ---------------------------------------------------------------------------

Knux_Stand_Freespace:
		tst.b	double_jump_flag(a0)
		bne.s	Knux_Glide_Freespace
		bsr.w	Knux_JumpHeight
		bsr.w	Knux_ChgJumpDir
		bsr.w	Player_LevelBound
		jsr	(MoveSprite_TestGravity).l
		btst	#Status_Underwater,status(a0)
		beq.s	locK_16872
		subi.w	#$28,y_vel(a0)

locK_16872:
		bsr.w	Player_JumpAngle
		bsr.w	SonicKnux_DoLevelCollision
		rts
; ---------------------------------------------------------------------------

Knux_Glide_Freespace:
		bsr.w	Knuckles_Move_Glide
		bsr.w	Player_LevelBound
		jsr	(MoveSprite_TestGravity2).l
		bsr.w	Knuckles_Glide

locretK_1688E:
		rts

; =============== S U B R O U T I N E =======================================


Knuckles_Glide:
		move.b	double_jump_flag(a0),d0
		beq.s	locretK_1688E
		cmpi.b	#2,d0
		beq.w	Knuckles_Fall_From_Glide
		cmpi.b	#3,d0
		beq.w	Knuckles_Sliding
		cmpi.b	#4,d0
		beq.w	Knuckles_Wall_Climb
		cmpi.b	#5,d0
		beq.w	Knuckles_Climb_Ledge

		; This function updates 'Gliding_collision_flags'.
		bsr.w	Knux_DoLevelCollision_CheckRet

		btst	#Status_InAir,(Gliding_collision_flags).w
		beq.s	Knux_Gliding_HitFloor

		btst	#Status_Push,(Gliding_collision_flags).w
		bne.w	Knuckles_Gliding_HitWall

		move.b	(Ctrl_1_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		bne.s	.continueGliding

		; The player has let go of the jump button, so exit the gliding state
		; and enter the falling state.
		move.b	#2,double_jump_flag(a0)
		move.b	#$21,anim(a0)
		bclr	#Status_Facing,status(a0)
		tst.w	x_vel(a0)
		bpl.s	.skip1
		bset	#Status_Facing,status(a0)

.skip1:
		; Divide Knuckles' X velocity by 4.
		asr.w	x_vel(a0)
		asr.w	x_vel(a0)

		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)

		rts
; ---------------------------------------------------------------------------
; locK_1690A:
.continueGliding:
		bra.w	Knuckles_Set_Gliding_Animation
; ---------------------------------------------------------------------------

Knux_Gliding_HitFloor:
		bclr	#Status_Facing,status(a0)
		tst.w	x_vel(a0)
		bpl.s	+
		bset	#Status_Facing,status(a0)

+
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	locK_1693E

		move.w	ground_vel(a0),x_vel(a0)
		move.w	#0,y_vel(a0)

		bra.w	Knux_TouchFloor
; ---------------------------------------------------------------------------

locK_1693E:
		move.b	#3,double_jump_flag(a0)
		move.b	#$CC,mapping_frame(a0)
		move.b	#$7F,anim_frame_timer(a0)
		move.b	#0,anim_frame(a0)

		; The drowning countdown uses the dust clouds' VRAM, so don't create
		; dust if Knuckles is drowning.
		cmpi.b	#12,air_left(a0)
		blo.s	+
		; Create dust clouds.
		move.b	#6,routine(a6)
		move.b	#$15,mapping_frame(a6)

+
		rts
; ---------------------------------------------------------------------------

Knuckles_Gliding_HitWall:
		tst.b	(Disable_wall_grab).w
		bmi.w	.fail

		move.b	lrb_solid_bit(a0),d5
		move.b	double_jump_property(a0),d0
		addi.b	#$40,d0
		bpl.s	.right

;.left:
		bset	#Status_Facing,status(a0)

		bsr.w	CheckLeftCeilingDist
		or.w	d0,d1
		bne.s	.checkFloorLeft

		addq.w	#1,x_pos(a0)
		bra.s	.success

.right:
		bclr	#Status_Facing,status(a0)

		bsr.w	CheckRightCeilingDist
		or.w	d0,d1
		bne.w	.checkFloorRight
; locK_169A6:
.success:
		moveq	#signextendB(sfx_Grab),d0

		; If Hyper Knuckles glides into a wall at a high-enough
		; speed, then make the screen shake and harm all enemies
		; on-screen.
		tst.b	(Super_Sonic_Knux_flag).w
		bpl.s	.noQuake

		cmpi.w	#$480,ground_vel(a0)
		blo.s	.noQuake

		move.w	#$14,(Glide_screen_shake).w
		bsr.w	HyperAttackTouchResponse
		moveq	#signextendB(sfx_Thump),d0
; locK_169C2:
.noQuake:
		jsr	(Play_SFX).l
		move.w	#0,ground_vel(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.b	#4,double_jump_flag(a0)
		move.b	#$B7,mapping_frame(a0)
		move.b	#$7F,anim_frame_timer(a0)
		move.b	#0,anim_frame(a0)
		move.b	#3,double_jump_property(a0)
		; 'x_pos+2' holds the X coordinate that Knuckles was at when he first
		; latched onto the wall.
		move.w	x_pos(a0),x_pos+2(a0)
		rts
; ---------------------------------------------------------------------------
; locK_16A00:
.checkFloorLeft:
		; This adds the Y radius to the X coordinate...
		; This appears to be a bug, but, luckily, the X and Y radius are both
		; 10, so this is harmless.
		move.w	x_pos(a0),d3
		move.b	y_radius(a0),d0
		ext.w	d0
		sub.w	d0,d3
		subq.w	#1,d3

		tst.b	(Reverse_gravity_flag).w
		bne.s	.reverseGravity
; locK_16A14:
.checkFloorCommon:
		move.w	y_pos(a0),d2
		subi.w	#11,d2
		jsr	(ChkFloorEdge_Part3).l

		tst.w	d1
		bmi.s	.fail
		cmpi.w	#12,d1
		bhs.s	.fail
		add.w	d1,y_pos(a0)
		bra.w	.success
; ---------------------------------------------------------------------------
; locK_16A34:
.reverseGravity:
		move.w	y_pos(a0),d2
		addi.w	#11,d2
		eori.w	#$F,d2
		jsr	(ChkFloorEdge_ReverseGravity_Part2).l

		tst.w	d1
		bmi.s	.fail
		cmpi.w	#12,d1
		bhs.s	.fail
		sub.w	d1,y_pos(a0)
		bra.w	.success
; ---------------------------------------------------------------------------
; locK_16A58:
.checkFloorRight:
		; This adds the Y radius to the X coordinate...
		; This appears to be a bug, but, luckily, the X and Y radius are both
		; 10, so this is harmless.
		move.w	x_pos(a0),d3
		move.b	y_radius(a0),d0
		ext.w	d0
		add.w	d0,d3
		addq.w	#1,d3

		tst.b	(Reverse_gravity_flag).w
		bne.s	Knuckles_Gliding_HitWall.reverseGravity

		bra.s	.checkFloorCommon
; ---------------------------------------------------------------------------
; locK_16A6E:
.fail:
		move.b	#2,double_jump_flag(a0)
		move.b	#$21,anim(a0)
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
		bset	#Status_InAir,(Gliding_collision_flags).w
		rts
; ---------------------------------------------------------------------------

Knuckles_Fall_From_Glide:
		bsr.w	Knux_ChgJumpDir

		; Apply gravity.
		addi.w	#$38,y_vel(a0)

		; Fall slower when underwater.
		btst	#Status_Underwater,status(a0)
		beq.s	.skip1
		subi.w	#$28,y_vel(a0)

.skip1:
		; This function updates 'Gliding_collision_flags'.
		bsr.w	Knux_DoLevelCollision_CheckRet

		btst	#Status_InAir,(Gliding_collision_flags).w
		bne.s	.return

		; Knuckles has touched the ground.
		move.w	#0,ground_vel(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)

		move.b	y_radius(a0),d0
		sub.b	default_y_radius(a0),d0
		ext.w	d0
		tst.b	(Reverse_gravity_flag).w
		beq.s	.skip2
		neg.w	d0

.skip2:
		add.w	d0,y_pos(a0)

		moveq	#signextendB(sfx_GlideLand),d0
		jsr	(Play_SFX).l

		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	.skip3
		bra.w	Knux_TouchFloor

.skip3:
		bsr.w	Knux_TouchFloor
		move.w	#$F,move_lock(a0)
		move.b	#$23,anim(a0)
; locretK_16B04:
.return:
		rts
; ---------------------------------------------------------------------------

Knuckles_Sliding:
		move.b	(Ctrl_1_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	.getUp

		tst.w	x_vel(a0)
		bpl.s	.goingRight

;.goingLeft:
		addi.w	#$20,x_vel(a0)
		bmi.s	.continueSliding2

		bra.s	.getUp
; ---------------------------------------------------------------------------
; locK_16B20:
.continueSliding2:
		bra.s	.continueSliding
; ---------------------------------------------------------------------------
; locK_16B22:
.goingRight:
		subi.w	#$20,x_vel(a0)
		bpl.s	.continueSliding
; locK_16B2A:
.getUp:
		move.w	#0,ground_vel(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)

		move.b	y_radius(a0),d0
		sub.b	default_y_radius(a0),d0
		ext.w	d0
		tst.b	(Reverse_gravity_flag).w
		beq.s	.skip1
		neg.w	d0

.skip1:
		add.w	d0,y_pos(a0)

		bsr.w	Knux_TouchFloor

		move.w	#$F,move_lock(a0)
		move.b	#$22,anim(a0)

		rts
; ---------------------------------------------------------------------------
; locK_16B64:
.continueSliding:
		bsr.w	Knux_DoLevelCollision_CheckRet

		; Get distance from floor in 'd1', and angle of floor in 'd3'.
		bsr.w	subK_11FD6

		; If the distance from the floor is suddenly really high, then
		; Knuckles must have slid off a ledge, so make him enter his falling
		; state.
		cmpi.w	#14,d1
		bge.s	.fail

		tst.b	(Reverse_gravity_flag).w
		beq.s	.skip2
		neg.w	d1

.skip2:
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)

		; Play the sliding sound every 8 frames.
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0
		bne.s	.skip3

		moveq	#signextendB(sfx_GroundSlide),d0
		jsr	(Play_SFX).l
.skip3:
		rts
; ---------------------------------------------------------------------------
; locK_16B96:
.fail:
		move.b	#2,double_jump_flag(a0)
		move.b	#$21,anim(a0)

		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)

		bset	#Status_InAir,(Gliding_collision_flags).w
		rts
; ---------------------------------------------------------------------------

Knuckles_Wall_Climb:
		tst.b	(Disable_wall_grab).w
		bmi.w	Knuckles_LetGoOfWall

		; If Knuckles' X coordinate is no longer the same as when he first
		; latched onto the wall, then detach him from the wall. This is
		; probably intended to detach Knuckles from the wall if something
		; physically pushes him away from it.
		move.w	x_pos(a0),d0
		cmp.w	x_pos+2(a0),d0
		bne.w	Knuckles_LetGoOfWall

		; If an object is now carrying Knuckles, then detach him from the
		; wall.
		btst	#Status_OnObj,status(a0)
		bne.w	Knuckles_LetGoOfWall

		move.w	#0,ground_vel(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)

		move.l	(Primary_collision_addr).w,(Collision_addr).w
		cmpi.b	#$D,lrb_solid_bit(a0)
		beq.s	+
		move.l	(Secondary_collision_addr).w,(Collision_addr).w
+
		move.b	lrb_solid_bit(a0),d5

		moveq	#0,d1	; Climbing animation delta: make the animation pause.

		btst	#button_up,(Ctrl_1_logical).w
		beq.w	.notClimbingUp

;.climbingUp:
		tst.b	(Reverse_gravity_flag).w
		bne.w	.climbingUp_ReverseGravity

		; Get Knuckles' distance from the wall in 'd1'.
		move.w	y_pos(a0),d2
		subi.w	#11,d2
		bsr.w	GetDistanceFromWall

		; If the wall is far away from Knuckles, then we must have reached a
		; ledge, so make Knuckles climb up onto it.
		cmpi.w	#4,d1
		bge.w	Knuckles_ClimbUp

		; If Knuckles has encountered a small dip in the wall, then make him
		; stop.
		tst.w	d1
		bne.w	.notMoving

		; Get Knuckles' distance from the ceiling in 'd1'.
		move.b	lrb_solid_bit(a0),d5
		move.w	y_pos(a0),d2
		subq.w	#8,d2
		move.w	x_pos(a0),d3
		bsr.w	CheckCeilingDist_WithRadius

		; Check if Knuckles has room above him.
		tst.w	d1
		bpl.s	.moveUp

		; Knuckles is bumping into the ceiling, so push him out.
		sub.w	d1,y_pos(a0)

		moveq	#1,d1	; Climbing animation delta: make the animation play forwards.
		bra.w	.finishMoving
; ---------------------------------------------------------------------------
; locK_16C4C:
.moveUp:
		subq.w	#1,y_pos(a0)

		; Super Knuckles and Hyper Knuckles climb walls faster.
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	.notSuperOrHyper1
		subq.w	#1,y_pos(a0)

.notSuperOrHyper1:
		moveq	#1,d1	; Climbing animation delta: make the animation play forwards.

		; Don't let Knuckles climb through the level's upper boundary.
		move.w	(Camera_min_Y_pos).w,d0

		; If the level wraps vertically, then don't bother with any of this.
		cmpi.w	#-$100,d0
		beq.w	.finishMoving

		; Check if Knuckles is over the level's top boundary.
		addi.w	#16,d0
		cmp.w	y_pos(a0),d0
		ble.w	.finishMoving

		; Knuckles is climbing over the level's top boundary: push him back
		; down.
		move.w	d0,y_pos(a0)
		bra.w	.finishMoving
; ---------------------------------------------------------------------------
; locK_16C7C:
.climbingDown_ReverseGravity:
		; Knuckles is climbing down.

		; ...I'm not sure what this code is for.
		cmpi.b	#$BD,mapping_frame(a0)
		bne.s	.skip3
		move.b	#$B7,mapping_frame(a0)
		subq.w	#3,y_pos(a0)
		subq.w	#3,x_pos(a0)
		btst	#Status_Facing,status(a0)
		beq.s	.skip3
		addq.w	#3*2,x_pos(a0)

.skip3:
		; Get Knuckles' distance from the wall in 'd1'.
		move.w	y_pos(a0),d2
		subi.w	#11,d2
		bsr.w	GetDistanceFromWall

		; If Knuckles is no longer against the wall (he has climbed off the
		; bottom of it) then make him let go.
		tst.w	d1
		bne.w	Knuckles_LetGoOfWall

		; Get Knuckles' distance from the floor in 'd1'.
		move.b	top_solid_bit(a0),d5
		move.w	y_pos(a0),d2
		subi.w	#9,d2
		move.w	x_pos(a0),d3
		bsr.w	CheckCeilingDist_WithRadius

		; Check if Knuckles has room below him.
		tst.w	d1
		bpl.s	.moveDown_ReverseGravity

		; Knuckles has reached the floor.
		sub.w	d1,y_pos(a0)
		move.b	(Primary_Angle).w,d0
		addi.b	#$40,d0
		neg.b	d0
		subi.b	#$40,d0
		move.b	d0,angle(a0)

		move.w	#0,ground_vel(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)

		bsr.w	Knux_TouchFloor

		move.b	#5,anim(a0)

		rts
; ---------------------------------------------------------------------------
; locK_16CFC:
.moveDown_ReverseGravity:
		subq.w	#1,y_pos(a0)

		; Super Knuckles and Hyper Knuckles climb walls faster.
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	.notSuperOrHyper2
		subq.w	#1,y_pos(a0)

.notSuperOrHyper2:
		moveq	#-1,d1	; Climbing animation delta: make the animation play backwards.
		bra.w	.finishMoving
; ---------------------------------------------------------------------------
; locK_16D10:
.notClimbingUp:
		btst	#button_down,(Ctrl_1_logical).w
		beq.w	.finishMoving

;.climbingDown:
		tst.b	(Reverse_gravity_flag).w
		bne.w	.climbingDown_ReverseGravity

		; ...I'm not sure what this code is for.
		cmpi.b	#$BD,mapping_frame(a0)
		bne.s	.skip4
		move.b	#$B7,mapping_frame(a0)
		addq.w	#3,y_pos(a0)
		subq.w	#3,x_pos(a0)
		btst	#Status_Facing,status(a0)
		beq.s	.skip4
		addq.w	#3*2,x_pos(a0)

.skip4:
		; Get Knuckles' distance from the wall in 'd1'.
		move.w	y_pos(a0),d2
		addi.w	#11,d2
		bsr.w	GetDistanceFromWall

		; If Knuckles is no longer against the wall (he has climbed off the
		; bottom of it) then make him let go.
		tst.w	d1
		bne.w	Knuckles_LetGoOfWall

		; Get Knuckles' distance from the floor in 'd1'.
		move.b	top_solid_bit(a0),d5
		move.w	y_pos(a0),d2
		addi.w	#9,d2
		move.w	x_pos(a0),d3
		bsr.w	sub_F828

		; Check if Knuckles has room below him.
		tst.w	d1
		bpl.s	.moveDown
; locK_16D6E:
.reachedFloor:
		; Knuckles has reached the floor.
		add.w	d1,y_pos(a0)
		move.b	(Primary_Angle).w,angle(a0)

		move.w	#0,ground_vel(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)

		bsr.w	Knux_TouchFloor

		move.b	#5,anim(a0)

		rts
; ---------------------------------------------------------------------------
; locK_16D96:
.moveDown:
		addq.w	#1,y_pos(a0)

		; Super Knuckles and Hyper Knuckles climb walls faster.
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	.notSuperOrHyper3
		addq.w	#1,y_pos(a0)

.notSuperOrHyper3:
		moveq	#-1,d1	; Climbing animation delta: make the animation play backwards.
		bra.s	.finishMoving
; ---------------------------------------------------------------------------
; locK_16DA8:
.climbingUp_ReverseGravity:
		; Get Knuckles' distance from the wall in 'd1'.
		move.w	y_pos(a0),d2
		addi.w	#11,d2
		bsr.w	GetDistanceFromWall

		; If the wall is far away from Knuckles, then we must have reached a
		; ledge, so make Knuckles climb up onto it.
		cmpi.w	#4,d1
		bge.w	Knuckles_ClimbUp

		; If Knuckles has encountered a small dip in the wall, then make him
		; stop.
		tst.w	d1
		bne.w	.notMoving

		; Get Knuckles' distance from the ceiling in 'd1'.
		move.b	lrb_solid_bit(a0),d5
		move.w	y_pos(a0),d2
		addq.w	#8,d2
		move.w	x_pos(a0),d3
		bsr.w	sub_F828

		; Check if Knuckles has room above him.
		tst.w	d1
		bpl.s	.moveUp_ReverseGravity

		; Knuckles is bumping into the ceiling, so push him out.
		add.w	d1,y_pos(a0)

		moveq	#1,d1	; Climbing animation delta: make the animation play forwards.
		bra.w	.finishMoving
; ---------------------------------------------------------------------------
; locK_16DE2:
.moveUp_ReverseGravity:
		addq.w	#1,y_pos(a0)

		; Super Knuckles and Hyper Knuckles climb walls faster.
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	.notSuperOrHyper4
		addq.w	#1,y_pos(a0)

.notSuperOrHyper4:
		moveq	#1,d1	; Climbing animation delta: make the animation play forwards.

		; Don't let Knuckles climb through the level's upper boundary.

		; If the level wraps vertically, then don't bother with any of this.
		cmpi.w	#-$100,(Camera_min_Y_pos).w
		beq.w	.finishMoving

		; Check if Knuckles is over the level's top boundary.
		move.w	(Camera_max_Y_pos).w,d0
		addi.w	#$D0,d0
		cmp.w	y_pos(a0),d0
		bge.w	.finishMoving

		; Knuckles is climbing over the level's top boundary: push him back
		; down.
		move.w	d0,y_pos(a0)
; locK_16E10:
.finishMoving:
		; This block of code was not here in KiS2.
		; This code detaches Knuckles from the wall if there is
		; ground directly below him. Note that this code specifically
		; does not run if the player is holding up or down: this is
		; because similar code already runs if either of those
		; buttons are being held. Presumably, this check was added so
		; that Knuckles would properly detach from the wall if a
		; rising floor (think Marble Garden Zone Act 2) came up from
		; under him. With that said, KiS2 lacks this logic, and yet
		; Knuckles seems to detach from the wall in Hill Top Zone's
		; rising wall section just fine, so I'm not sure whether this
		; code was ever actually needed in the first place.
		move.b	(Ctrl_1_held_logical).w,d0
		andi.b	#button_up_mask|button_down_mask,d0
		bne.s	.isMovingUpOrDown

		; Get Knuckles' distance from the floor in 'd1'.
		move.b	top_solid_bit(a0),d5
		move.w	y_pos(a0),d2
		addi.w	#9,d2
		move.w	x_pos(a0),d3
	if FixBugs
		; move d1 to the stack pointer to fix the bug where Knuckles
		; resets to his first frame when the player is not holding up or down.
		move.w	d1,-(sp)
	endif
		bsr.w	sub_F828

	if FixBugs
		; move sub_F828's return value to a register that we don't need
		move.w	d1,d0

		; move the original d1 value from stack back to d1.
		move.w	(sp)+,d1

		; Check if Knuckles has room below him.
		tst.w	d0
	else
		; Bug: 'd1' has been overwritten by 'sub_F828', but the code
		; after this needs it for updating Knuckles' animation. This
		; bug is the reason why Knuckles resets to his first climbing
		; frame when the player is not holding up or down.

		; Check if Knuckles has room below him.
		tst.w	d1
	endif
		bmi.w	.reachedFloor

.isMovingUpOrDown:
		; If Knuckles has not moved, skip this.
		tst.w	d1
		beq.s	.notMoving

		; Only animate every 4 frames.
		subq.b	#1,double_jump_property(a0)
		bpl.s	.notMoving
		move.b	#3,double_jump_property(a0)

		; Add delta to animation frame.
		add.b	mapping_frame(a0),d1

	; Make the animation loop.
		cmpi.b	#$B7,d1
		bhs.s	.noLoop1
		move.b	#$BC,d1

.noLoop1:
		cmpi.b	#$BC,d1
		bls.s	.noLoop2
		move.b	#$B7,d1

.noLoop2:
		; Apply the frame.
		move.b	d1,mapping_frame(a0)
; locK_16E60:
.notMoving:
		move.b	#$20,anim_frame_timer(a0)
		move.b	#0,anim_frame(a0)

		move.w	(Ctrl_1_logical).w,d0
		andi.w	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	.hasNotJumped

		; Knuckles has jumped off the wall.
		move.w	#-$380,y_vel(a0)
		move.w	#$400,x_vel(a0)

		bchg	#Status_Facing,status(a0)
		bne.s	.goingRight
		neg.w	x_vel(a0)

.goingRight:
		bset	#Status_InAir,status(a0)
		move.b	#1,jumping(a0)

		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)

		move.b	#2,anim(a0)
		bset	#Status_Roll,status(a0)
		move.b	#0,double_jump_flag(a0)
; locretK_16EB8:
.hasNotJumped:
		rts
; ---------------------------------------------------------------------------
; locK_16EBA:
Knuckles_ClimbUp:
		move.b	#5,double_jump_flag(a0)

		cmpi.b	#$BD,mapping_frame(a0)
		beq.s	+

		move.b	#0,double_jump_property(a0)
		bsr.s	Knuckles_DoLedgeClimbingAnimation
+
		rts
; ---------------------------------------------------------------------------
; locK_16ED2:
Knuckles_LetGoOfWall:
		move.b	#2,double_jump_flag(a0)

		move.w	#($21<<8)|$21,anim(a0)	; and prev_anim
		move.b	#$CB,mapping_frame(a0)
		move.b	#7,anim_frame_timer(a0)
		move.b	#1,anim_frame(a0)

		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)

		rts
; End of function Knuckles_Glide


; =============== S U B R O U T I N E =======================================

; subK_16EFE:
Knuckles_DoLedgeClimbingAnimation:
		moveq	#0,d0
		move.b	double_jump_property(a0),d0
		lea	Knuckles_ClimbLedge_Frames(pc,d0.w),a1

		move.b	(a1)+,mapping_frame(a0)

		move.b	(a1)+,d0
		ext.w	d0
		btst	#Status_Facing,status(a0)
		beq.s	+
		neg.w	d0

+
		add.w	d0,x_pos(a0)

		move.b	(a1)+,d1
		ext.w	d1
		tst.b	(Reverse_gravity_flag).w
		beq.s	+
		neg.w	d1

+
		add.w	d1,y_pos(a0)

		move.b	(a1)+,anim_frame_timer(a0)

		addq.b	#4,double_jump_property(a0)
		move.b	#0,anim_frame(a0)
		rts
; End of function Knuckles_DoLedgeClimbingAnimation

; ---------------------------------------------------------------------------
; Strangely, the last frame uses frame $D2. It will never be seen, however,
; because it is immediately overwritten by Knuckles' waiting animation.

Knuckles_ClimbLedge_Frames:
	; mapping_frame, x_pos, y_pos, anim_frame_timer
	dc.b  $BD,    3,   -3,    6
	dc.b  $BE,    8,  -10,    6
	dc.b  $BF,   -8,  -12,    6
	dc.b  $D2,    8,   -5,    6
Knuckles_ClimbLedge_Frames_End:

; =============== S U B R O U T I N E =======================================

; subK_16F4E:
GetDistanceFromWall:
		move.b	lrb_solid_bit(a0),d5
		btst	#Status_Facing,status(a0)
		bne.s	.facingLeft

;.facingRight:
		move.w	x_pos(a0),d3
		bra.w	loc_FAA4
; ---------------------------------------------------------------------------
; locK_16F62:
.facingLeft:
		move.w	x_pos(a0),d3
		subq.w	#1,d3
		bra.w	loc_FDC8
; End of function GetDistanceFromWall

; ---------------------------------------------------------------------------

Knuckles_Climb_Ledge:
		tst.b	anim_frame_timer(a0)
		bne.s	locretK_16FA6

		bsr.w	Knuckles_DoLedgeClimbingAnimation

		; Have we reached the end of the ledge-climbing animation?
		cmpi.b	#Knuckles_ClimbLedge_Frames_End-Knuckles_ClimbLedge_Frames,double_jump_property(a0)
		bne.s	locretK_16FA6

		; Yes.
		move.w	#0,ground_vel(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)

		btst	#Status_Facing,status(a0)
		beq.s	+
		subq.w	#1,x_pos(a0)
+
		bsr.w	Knux_TouchFloor
		move.b	#5,anim(a0)

locretK_16FA6:
		rts

; =============== S U B R O U T I N E =======================================


Knuckles_Set_Gliding_Animation:
		move.b	#$20,anim_frame_timer(a0)
		move.b	#0,anim_frame(a0)
		move.w	#($20<<8)|$20,anim(a0)	; and prev_anim
		bclr	#Status_Push,status(a0)
		bclr	#Status_Facing,status(a0)

		; Update Knuckles' frame, depending on where he's facing.
		moveq	#0,d0
		move.b	double_jump_property(a0),d0
		addi.b	#$10,d0
		lsr.w	#5,d0
		move.b	RawAni_Knuckles_GlideTurn(pc,d0.w),d1
		move.b	d1,mapping_frame(a0)
		cmpi.b	#$C4,d1
		bne.s	+
		bset	#Status_Facing,status(a0)
		move.b	#$C0,mapping_frame(a0)

+
		rts
; End of function Knuckles_Set_Gliding_Animation

; ---------------------------------------------------------------------------
RawAni_Knuckles_GlideTurn:
		dc.b  $C0
		dc.b  $C1
		dc.b  $C2
		dc.b  $C3
		dc.b  $C4
		dc.b  $C3
		dc.b  $C2
		dc.b  $C1
		even

; =============== S U B R O U T I N E =======================================


Knuckles_Move_Glide:
		cmpi.b	#1,double_jump_flag(a0)
		bne.w	.doNotKillspeed

		move.w	ground_vel(a0),d0
		cmpi.w	#$400,d0
		bhs.s	.mediumSpeed

;.lowSpeed:
		; Increase Knuckles' speed.
		addq.w	#8,d0
		bra.s	.applySpeed
; ---------------------------------------------------------------------------
; locK_1700E:
.mediumSpeed:
		; If Knuckles is at his speed limit, then don't increase his speed.
		cmpi.w	#$1800,d0
		bhs.s	.applySpeed

		; If Knuckles is turning, then don't increase his speed either.
		move.b	double_jump_property(a0),d1
		andi.b	#$7F,d1
		bne.s	.applySpeed

		; Increase Knuckles' speed.
		addq.w	#4,d0

		; Super Knuckles and Hyper Knuckles glide faster.
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	.applySpeed
		addq.w	#8,d0
; locK_17028:
.applySpeed:
		move.w	d0,ground_vel(a0)

		move.b	double_jump_property(a0),d0
		btst	#button_left,(Ctrl_1_logical).w
		beq.s	.notHoldingLeft

;.holdingLeft:
		; Playing is holding left.
		cmpi.b	#$80,d0
		beq.s	.notHoldingLeft
		tst.b	d0
		bpl.s	.doNotNegate1
		neg.b	d0

.doNotNegate1:
		addq.b	#2,d0
		bra.s	.setNewTurningValue
; ---------------------------------------------------------------------------
; locK_17048:
.notHoldingLeft:
		btst	#button_right,(Ctrl_1_logical).w
		beq.s	.notHoldingRight

;.holdingRight:
		; Playing is holding right.
		tst.b	d0
		beq.s	.notHoldingRight
		bmi.s	.doNotNegate2
		neg.b	d0

.doNotNegate2:
		addq.b	#2,d0
		bra.s	.setNewTurningValue
; ---------------------------------------------------------------------------
; locK_1705C:
.notHoldingRight:
		move.b	d0,d1
		andi.b	#$7F,d1
		beq.s	.setNewTurningValue
		addq.b	#2,d0
; locK_17066:
.setNewTurningValue:
		move.b	d0,double_jump_property(a0)

		move.b	double_jump_property(a0),d0
		jsr	(GetSineCosine).l
		muls.w	ground_vel(a0),d1
		asr.l	#8,d1
		move.w	d1,x_vel(a0)

		; Is Knuckles is falling at a high speed, then create a parachute
		; effect, where gliding makes Knuckles fall slower.
		cmpi.w	#$80,y_vel(a0)
		blt.s	.fallingSlow
		subi.w	#$20,y_vel(a0)
		bra.s	.fallingFast
; ---------------------------------------------------------------------------
; locK_1708E:
.fallingSlow:
		; Apply gravity.
		addi.w	#$20,y_vel(a0)
; locK_17094:
.fallingFast:
		; If Knuckles is above the level's top boundary, then kill his
		; horizontal speed.
		move.w	(Camera_min_Y_pos).w,d0
		cmpi.w	#-$100,d0
		beq.w	.doNotKillspeed

		addi.w	#$10,d0
		cmp.w	y_pos(a0),d0
		ble.w	.doNotKillspeed

		asr.w	x_vel(a0)
		asr.w	ground_vel(a0)
; locK_170B4:
.doNotKillspeed:
		cmpi.w	#$60,(a5)
		beq.s	.doNotModifyBias
		bhs.s	.goUp
		addq.w	#2*2,(a5)

.goUp:
		subq.w	#2,(a5)
; locretK_170C0:
.doNotModifyBias:
		rts
; End of function Knuckles_Move_Glide

; ---------------------------------------------------------------------------

Knux_Spin_Path:
		tst.b	spin_dash_flag(a0)
		bne.s	locK_170CC
		bsr.w	Knux_Jump

locK_170CC:
		bsr.w	Player_RollRepel
		bsr.w	Knux_RollSpeed
		bsr.w	Player_LevelBound
		jsr	(MoveSprite_TestGravity2).l
		bsr.w	Call_Player_AnglePos
		bsr.w	Player_SlopeRepel
		tst.b	(Background_collision_flag).w
		beq.s	locretK_17116
		bsr.w	sub_F846
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	locK_17106
		sub.w	d1,x_pos(a0)

locK_17106:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locK_17112
		add.w	d1,x_pos(a0)

locK_17112:
		movem.l	(sp)+,a4-a6

locretK_17116:
		rts
; ---------------------------------------------------------------------------

Knux_Spin_Freespace:
		bsr.w	Knux_JumpHeight
		bsr.w	Knux_ChgJumpDir
		bsr.w	Player_LevelBound
		jsr	(MoveSprite_TestGravity).l
		btst	#Status_Underwater,status(a0)
		beq.s	locK_17138
		subi.w	#$28,y_vel(a0)

locK_17138:
		bsr.w	Player_JumpAngle
		bsr.w	SonicKnux_DoLevelCollision
		rts

; =============== S U B R O U T I N E =======================================


Knux_InputAcceleration_Path:
		move.w	Max_speed-Max_speed(a4),d6
		move.w	Acceleration-Max_speed(a4),d5
		move.w	Deceleration-Max_speed(a4),d4
		tst.b	status_secondary(a0)
		bmi.w	locK_17364
		tst.w	move_lock(a0)
		bne.w	locK_1731C
		btst	#button_left,(Ctrl_1_held_logical).w
		beq.s	locK_17168
		bsr.w	subK_17428

locK_17168:
		btst	#button_right,(Ctrl_1_held_logical).w
		beq.s	locK_17174
		bsr.w	subK_174B4

locK_17174:
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.w	locK_1731C
		tst.w	ground_vel(a0)
		bne.w	locK_1731C
		bclr	#Status_Push,status(a0)
		move.b	#5,anim(a0)
		btst	#Status_OnObj,status(a0)
		beq.w	locK_1722C
		movea.w	interact(a0),a1
		tst.b	status(a1)
		bmi.w	locK_172A8
		moveq	#0,d1
		move.b	width_pixels(a1),d1
		move.w	d1,d2
		add.w	d2,d2
		subq.w	#2,d2
		add.w	x_pos(a0),d1
		sub.w	x_pos(a1),d1
		cmpi.w	#2,d1
		blt.s	locK_171FE
		cmp.w	d2,d1
		bge.s	locK_171D0
		bra.w	locK_172A8
; ---------------------------------------------------------------------------

locK_171D0:
		btst	#Status_Facing,status(a0)
		bne.s	locK_171E2
		move.b	#6,anim(a0)
		bra.w	locK_1731C
; ---------------------------------------------------------------------------

locK_171E2:
		bclr	#Status_Facing,status(a0)
		move.b	#0,anim_frame_timer(a0)
		move.b	#4,anim_frame(a0)
		move.w	#(6<<8)|6,anim(a0)	; and prev_anim
		bra.w	locK_1731C
; ---------------------------------------------------------------------------

locK_171FE:
		btst	#Status_Facing,status(a0)
		beq.s	locK_17210
		move.b	#6,anim(a0)
		bra.w	locK_1731C
; ---------------------------------------------------------------------------

locK_17210:
		bset	#Status_Facing,status(a0)
		move.b	#0,anim_frame_timer(a0)
		move.b	#4,anim_frame(a0)
		move.w	#(6<<8)|6,anim(a0)	; and prev_anim
		bra.w	locK_1731C
; ---------------------------------------------------------------------------

locK_1722C:
		move.w	x_pos(a0),d3
		bsr.w	ChooseChkFloorEdge
		cmpi.w	#$C,d1
		blt.w	locK_172A8
		cmpi.b	#3,next_tilt(a0)
		bne.s	locK_17272
		btst	#Status_Facing,status(a0)
		bne.s	locK_17256
		move.b	#6,anim(a0)
		bra.w	locK_1731C
; ---------------------------------------------------------------------------

locK_17256:
		bclr	#Status_Facing,status(a0)
		move.b	#0,anim_frame_timer(a0)
		move.b	#4,anim_frame(a0)
		move.w	#(6<<8)|6,anim(a0)	; and prev_anim
		bra.w	locK_1731C
; ---------------------------------------------------------------------------

locK_17272:
		cmpi.b	#3,tilt(a0)
		bne.s	locK_172A8
		btst	#Status_Facing,status(a0)
		beq.s	locK_1728C
		move.b	#6,anim(a0)
		bra.w	locK_1731C
; ---------------------------------------------------------------------------

locK_1728C:
		bset	#Status_Facing,status(a0)
		move.b	#0,anim_frame_timer(a0)
		move.b	#4,anim_frame(a0)
		move.w	#(6<<8)|6,anim(a0)	; and prev_anim
		bra.w	locK_1731C
; ---------------------------------------------------------------------------

locK_172A8:
		btst	#button_down,(Ctrl_1_held_logical).w
		beq.s	locK_172E2
		move.b	#8,anim(a0)
		addq.b	#1,scroll_delay_counter(a0)
		cmpi.b	#2*60,scroll_delay_counter(a0)
		blo.s	locK_17322
		move.b	#2*60,scroll_delay_counter(a0)
		tst.b	(Reverse_gravity_flag).w
		bne.s	locK_172D8
		cmpi.w	#8,(a5)
		beq.s	locK_1732E
		subq.w	#2,(a5)
		bra.s	locK_1732E
; ---------------------------------------------------------------------------

locK_172D8:
		cmpi.w	#$D8,(a5)
		beq.s	locK_1732E
		addq.w	#2,(a5)
		bra.s	locK_1732E
; ---------------------------------------------------------------------------

locK_172E2:
		btst	#button_up,(Ctrl_1_logical).w
		beq.s	locK_1731C
		move.b	#7,anim(a0)
		addq.b	#1,scroll_delay_counter(a0)
		cmpi.b	#2*60,scroll_delay_counter(a0)
		blo.s	locK_17322
		move.b	#2*60,scroll_delay_counter(a0)
		tst.b	(Reverse_gravity_flag).w
		bne.s	locK_17312
		cmpi.w	#$C8,(a5)
		beq.s	locK_1732E
		addq.w	#2,(a5)
		bra.s	locK_1732E
; ---------------------------------------------------------------------------

locK_17312:
		cmpi.w	#$18,(a5)
		beq.s	locK_1732E
		subq.w	#2,(a5)
		bra.s	locK_1732E
; ---------------------------------------------------------------------------

locK_1731C:
		move.b	#0,scroll_delay_counter(a0)

locK_17322:
		cmpi.w	#$60,(a5)
		beq.s	locK_1732E
		bcc.s	locK_1732C
		addq.w	#4,(a5)

locK_1732C:
		subq.w	#2,(a5)

locK_1732E:
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	locK_17338
		move.w	#$C,d5

locK_17338:
		move.b	(Ctrl_1_logical).w,d0
		andi.b	#button_left_mask|button_right_mask,d0
		bne.s	locK_17364
		move.w	ground_vel(a0),d0
		beq.s	locK_17364
		bmi.s	locK_17358
		sub.w	d5,d0
		bcc.s	locK_17352
		move.w	#0,d0

locK_17352:
		move.w	d0,ground_vel(a0)
		bra.s	locK_17364
; ---------------------------------------------------------------------------

locK_17358:
		add.w	d5,d0
		bcc.s	locK_17360
		move.w	#0,d0

locK_17360:
		move.w	d0,ground_vel(a0)

locK_17364:
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	ground_vel(a0),d1
		asr.l	#8,d1
		move.w	d1,x_vel(a0)
		muls.w	ground_vel(a0),d0
		asr.l	#8,d0
		move.w	d0,y_vel(a0)

locK_17382:
		btst	#6,object_control(a0)
		bne.w	locretK_17426
		move.b	angle(a0),d0
		andi.b	#$3F,d0
		beq.s	locK_173A2
		move.b	angle(a0),d0
		addi.b	#$40,d0
		bmi.w	locretK_17426

locK_173A2:
		move.b	#$40,d1
		tst.w	ground_vel(a0)
		beq.s	locretK_17426
		bmi.s	locK_173B0
		neg.w	d1

locK_173B0:
		move.b	angle(a0),d0
		add.b	d1,d0
		move.w	d0,-(sp)
		bsr.w	sub_F61C
		move.w	(sp)+,d0
		tst.w	d1
		bpl.s	locretK_17426
		asl.w	#8,d1
		cmpi.b	#8,(Current_zone).w
		bne.s	locK_173D2
		tst.b	d0
		bpl.s	locK_173D2
		subq.b	#1,d0

locK_173D2:
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	locK_17422
		cmpi.b	#$40,d0
		beq.s	locK_17408
		cmpi.b	#$80,d0
		beq.s	locK_17402
		add.w	d1,x_vel(a0)
		move.w	#0,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		bne.s	locretK_17400
		bset	#Status_Push,status(a0)

locretK_17400:
		rts
; ---------------------------------------------------------------------------

locK_17402:
		sub.w	d1,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

locK_17408:
		sub.w	d1,x_vel(a0)
		move.w	#0,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		beq.s	locretK_17400
		bset	#Status_Push,status(a0)
		rts
; ---------------------------------------------------------------------------

locK_17422:
		add.w	d1,y_vel(a0)

locretK_17426:
		rts
; End of function Knux_InputAcceleration_Path


; =============== S U B R O U T I N E =======================================


subK_17428:
		move.w	ground_vel(a0),d0
		beq.s	locK_17430
		bpl.s	locK_17462

locK_17430:
		bset	#Status_Facing,status(a0)
		bne.s	locK_17444
		bclr	#Status_Push,status(a0)
		move.b	#1,prev_anim(a0)

locK_17444:
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	locK_17456
		add.w	d5,d0
		cmp.w	d1,d0
		ble.s	locK_17456
		move.w	d1,d0

locK_17456:
		move.w	d0,ground_vel(a0)
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------

locK_17462:
		sub.w	d4,d0
		bcc.s	locK_1746A
		move.w	#-$80,d0

locK_1746A:
		move.w	d0,ground_vel(a0)
	if FixBugs
		move.b	angle(a0),d1
		addi.b	#$20,d1
		andi.b	#$C0,d1
	else
		; These three instructions partially overwrite the inertia value in
		; 'd0'! This causes the character to trigger their skidding
		; animation at different speeds depending on whether they're going
		; right or left. To fix this, make these instructions use 'd1'
		; instead.
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
	endif
		bne.s	locretK_174B2
		cmpi.w	#$400,d0
		blt.s	locretK_174B2
		tst.b	flip_type(a0)
		bmi.s	locretK_174B2
		move.w	#sfx_Skid,d0
		jsr	(Play_SFX).l
		move.b	#$D,anim(a0)
		bclr	#Status_Facing,status(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	locretK_174B2
		move.b	#6,routine(a6)
		move.b	#$15,mapping_frame(a6)

locretK_174B2:
		rts
; End of function subK_17428


; =============== S U B R O U T I N E =======================================


subK_174B4:
		move.w	ground_vel(a0),d0
		bmi.s	locK_174E8
		bclr	#Status_Facing,status(a0)
		beq.s	locK_174CE
		bclr	#Status_Push,status(a0)
		move.b	#1,prev_anim(a0)

locK_174CE:
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	locK_174DC
		sub.w	d5,d0
		cmp.w	d6,d0
		bge.s	locK_174DC
		move.w	d6,d0

locK_174DC:
		move.w	d0,ground_vel(a0)
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------

locK_174E8:
		add.w	d4,d0
		bcc.s	locK_174F0
		move.w	#$80,d0

locK_174F0:
		move.w	d0,ground_vel(a0)
	if FixBugs
		move.b	angle(a0),d1
		addi.b	#$20,d1
		andi.b	#$C0,d1
	else
		; These three instructions partially overwrite the inertia value in
		; 'd0'! This causes the character to trigger their skidding
		; animation at different speeds depending on whether they're going
		; right or left. To fix this, make these instructions use 'd1'
		; instead.
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
	endif
		bne.s	locretK_17538
		cmpi.w	#-$400,d0
		bgt.s	locretK_17538
		tst.b	flip_type(a0)
		bmi.s	locretK_17538
		move.w	#sfx_Skid,d0
		jsr	(Play_SFX).l
		move.b	#$D,anim(a0)
		bset	#Status_Facing,status(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	locretK_17538
		move.b	#6,routine(a6)
		move.b	#$15,mapping_frame(a6)

locretK_17538:
		rts
; End of function subK_174B4


; =============== S U B R O U T I N E =======================================


Knux_RollSpeed:
		move.w	Max_speed-Max_speed(a4),d6
		asl.w	#1,d6
		move.w	Acceleration-Max_speed(a4),d5
		asr.w	#1,d5
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	locK_1754E
		move.w	#6,d5

locK_1754E:
		move.w	#$20,d4
		tst.b	spin_dash_flag(a0)
		bmi.w	locK_175F8
		tst.b	status_secondary(a0)
		bmi.w	locK_175F8
		tst.w	move_lock(a0)
		bne.s	locK_17580
		btst	#button_left,(Ctrl_1_held_logical).w
		beq.s	locK_17574
		bsr.w	subK_1763A

locK_17574:
		btst	#button_right,(Ctrl_1_held_logical).w
		beq.s	locK_17580
		bsr.w	subK_1765E

locK_17580:
		move.w	ground_vel(a0),d0
		beq.s	locK_175A2
		bmi.s	locK_17596
		sub.w	d5,d0
		bcc.s	locK_17590
		move.w	#0,d0

locK_17590:
		move.w	d0,ground_vel(a0)
		bra.s	locK_175A2
; ---------------------------------------------------------------------------

locK_17596:
		add.w	d5,d0
		bcc.s	locK_1759E
		move.w	#0,d0

locK_1759E:
		move.w	d0,ground_vel(a0)

locK_175A2:
		move.w	ground_vel(a0),d0
		bpl.s	locK_175AA
		neg.w	d0

locK_175AA:
		cmpi.w	#$80,d0
		bhs.s	locK_175F8
		tst.b	spin_dash_flag(a0)
		bne.s	locK_175E6
		bclr	#Status_Roll,status(a0)
		move.b	y_radius(a0),d0
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
		move.b	#5,anim(a0)
		sub.b	default_y_radius(a0),d0
		ext.w	d0
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_175E0
		neg.w	d0

locK_175E0:
		add.w	d0,y_pos(a0)
		bra.s	locK_175F8
; ---------------------------------------------------------------------------

locK_175E6:
		move.w	#$400,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		beq.s	locK_175F8
		neg.w	ground_vel(a0)

locK_175F8:
		cmpi.w	#$60,(a5)
		beq.s	locK_17604
		bcc.s	locK_17602
		addq.w	#4,(a5)

locK_17602:
		subq.w	#2,(a5)

locK_17604:
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	ground_vel(a0),d0
		asr.l	#8,d0
		move.w	d0,y_vel(a0)
		muls.w	ground_vel(a0),d1
		asr.l	#8,d1
		cmpi.w	#$1000,d1
		ble.s	locK_17628
		move.w	#$1000,d1

locK_17628:
		cmpi.w	#-$1000,d1
		bge.s	locK_17632
		move.w	#-$1000,d1

locK_17632:
		move.w	d1,x_vel(a0)
		bra.w	locK_17382
; End of function Knux_RollSpeed


; =============== S U B R O U T I N E =======================================


subK_1763A:
		move.w	ground_vel(a0),d0
		beq.s	locK_17642
		bpl.s	locK_17650

locK_17642:
		bset	#Status_Facing,status(a0)
		move.b	#2,anim(a0)
		rts
; ---------------------------------------------------------------------------

locK_17650:
		sub.w	d4,d0
		bcc.s	locK_17658
		move.w	#-$80,d0

locK_17658:
		move.w	d0,ground_vel(a0)
		rts
; End of function subK_1763A


; =============== S U B R O U T I N E =======================================


subK_1765E:
		move.w	ground_vel(a0),d0
		bmi.s	locK_17672
		bclr	#Status_Facing,status(a0)
		move.b	#2,anim(a0)
		rts
; ---------------------------------------------------------------------------

locK_17672:
		add.w	d4,d0
		bcc.s	locK_1767A
		move.w	#$80,d0

locK_1767A:
		move.w	d0,ground_vel(a0)
		rts
; End of function subK_1765E


; =============== S U B R O U T I N E =======================================

; subK_17680:
Knux_ChgJumpDir:
		move.w	Max_speed-Max_speed(a4),d6
		move.w	Acceleration-Max_speed(a4),d5
		asl.w	#1,d5
		btst	#Status_RollJump,status(a0)
		bne.s	locK_176D4
		move.w	x_vel(a0),d0
		btst	#button_left,(Ctrl_1_held_logical).w
		beq.s	locK_176B4
		bset	#Status_Facing,status(a0)
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	locK_176B4
		add.w	d5,d0
		cmp.w	d1,d0
		ble.s	locK_176B4
		move.w	d1,d0

locK_176B4:
		btst	#button_right,(Ctrl_1_held_logical).w
		beq.s	locK_176D0
		bclr	#Status_Facing,status(a0)
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	locK_176D0
		sub.w	d5,d0
		cmp.w	d6,d0
		bge.s	locK_176D0
		move.w	d6,d0

locK_176D0:
		move.w	d0,x_vel(a0)

locK_176D4:
		cmpi.w	#$60,(a5)
		beq.s	locK_176E0
		bcc.s	locK_176DE
		addq.w	#4,(a5)

locK_176DE:
		subq.w	#2,(a5)

locK_176E0:
		cmpi.w	#-$400,y_vel(a0)
		blo.s	locretK_1770E
		move.w	x_vel(a0),d0
		move.w	d0,d1
		asr.w	#5,d1
		beq.s	locretK_1770E
		bmi.s	locK_17702
		sub.w	d1,d0
		bcc.s	locK_176FC
		move.w	#0,d0

locK_176FC:
		move.w	d0,x_vel(a0)
		rts
; ---------------------------------------------------------------------------

locK_17702:
		sub.w	d1,d0
		bcs.s	locK_1770A
		move.w	#0,d0

locK_1770A:
		move.w	d0,x_vel(a0)

locretK_1770E:
		rts
; End of function Knux_ChgJumpDir


; =============== S U B R O U T I N E =======================================


Knux_Jump:
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locretK_177E0
		moveq	#0,d0
		move.b	angle(a0),d0
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_17732
		addi.b	#$40,d0
		neg.b	d0
		subi.b	#$40,d0

locK_17732:
		addi.b	#$80,d0
		movem.l	a4-a6,-(sp)
		jsr	(CalcRoomOverHead).l
		movem.l	(sp)+,a4-a6
		cmpi.w	#6,d1
		blt.w	locretK_177E0
		move.w	#$600,d2
		btst	#Status_Underwater,status(a0)
		beq.s	locK_1775C
		move.w	#$300,d2

locK_1775C:
		moveq	#0,d0
		move.b	angle(a0),d0
		subi.b	#$40,d0
		jsr	(GetSineCosine).l
		muls.w	d2,d1
		asr.l	#8,d1
		add.w	d1,x_vel(a0)
		muls.w	d2,d0
		asr.l	#8,d0
		add.w	d0,y_vel(a0)
		bset	#Status_InAir,status(a0)
		bclr	#Status_Push,status(a0)
		addq.l	#4,sp
		move.b	#1,jumping(a0)
		clr.b	stick_to_convex(a0)
		move.w	#sfx_Jump,d0
		jsr	(Play_SFX).l
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
		btst	#Status_Roll,status(a0)
		bne.s	locK_177E2
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)
		bset	#Status_Roll,status(a0)
		move.b	y_radius(a0),d0
		sub.b	default_y_radius(a0),d0
		ext.w	d0
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_177DC
		neg.w	d0

locK_177DC:
		sub.w	d0,y_pos(a0)

locretK_177E0:
		rts
; ---------------------------------------------------------------------------

locK_177E2:
		bset	#Status_RollJump,status(a0)
		rts
; End of function Knux_Jump


; =============== S U B R O U T I N E =======================================


Knux_JumpHeight:
		tst.b	jumping(a0)
		beq.s	locK_17818
		move.w	#-$400,d1
		btst	#Status_Underwater,status(a0)
		beq.s	locK_17800
		move.w	#-$200,d1

locK_17800:
		cmp.w	y_vel(a0),d1
		ble.w	Knux_Test_For_Glide
		move.b	(Ctrl_1_held_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		bne.s	locretK_17816
		move.w	d1,y_vel(a0)

locretK_17816:
		rts
; ---------------------------------------------------------------------------

locK_17818:
		tst.b	spin_dash_flag(a0)
		bne.s	locretK_1782C
		cmpi.w	#-$FC0,y_vel(a0)
		bge.s	locretK_1782C
		move.w	#-$FC0,y_vel(a0)

locretK_1782C:
		rts
; ---------------------------------------------------------------------------

Knux_Test_For_Glide:
		tst.b	double_jump_flag(a0)
		bne.w	locretK_178CC
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locretK_178CC
		tst.b	(Super_Sonic_Knux_flag).w
		bne.s	locK_1786C
		cmpi.b	#7,(Super_emerald_count).w
		bhs.s	locK_1785E
		cmpi.b	#7,(Chaos_emerald_count).w
		blo.s	locK_1786C
		tst.b	(Emeralds_converted_flag).w
		bne.s	locK_1786C

locK_1785E:
		cmpi.w	#50,(Ring_count).w
		blo.s	locK_1786C
		tst.b	(Update_HUD_timer).w
		bne.s	Knux_Transform

locK_1786C:
		bclr	#Status_Roll,status(a0)
		move.b	#$A,y_radius(a0)
		move.b	#$A,x_radius(a0)
		bclr	#Status_RollJump,status(a0)
		move.b	#1,double_jump_flag(a0)
		addi.w	#$200,y_vel(a0)
		bpl.s	locK_17898
		move.w	#0,y_vel(a0)

locK_17898:
		moveq	#0,d1
		move.w	#$400,d0
		move.w	d0,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		beq.s	locK_178AE
		neg.w	d0
		moveq	#-$80,d1

locK_178AE:
		move.w	d0,x_vel(a0)
		move.b	d1,double_jump_property(a0)
		move.w	#0,angle(a0)
		move.b	#0,(Gliding_collision_flags).w
		bset	#Status_InAir,(Gliding_collision_flags).w
		bsr.w	Knuckles_Set_Gliding_Animation

locretK_178CC:
		rts
; ---------------------------------------------------------------------------

Knux_Transform:
		move.b	#1,(Super_palette_status).w	; set Super/Hyper palette status to 'fading'
		move.b	#$F,(Palette_timer).w
		move.w	#60,(Super_frame_count).w
		move.b	#$81,object_control(a0)
		move.b	#$1F,anim(a0)				; enter 'transformation' animation
		cmpi.b	#7,(Super_emerald_count).w		; does Knuckles have all 7 Super Emeralds?
		blo.s	.super					; if not, turn Super

		move.b	#-1,(Super_Sonic_Knux_flag).w		; set flag to Hyper Knuckles
		move.l	#Obj_HyperSonicKnux_Trail,(Super_stars).w	; load After-Images object
		bra.s	.continued
; ---------------------------------------------------------------------------

	.super:
		move.b	#1,(Super_Sonic_Knux_flag).w		; set flag to Super Knuckles
		move.l	#Obj_SuperSonicKnux_Stars,(Super_stars).w	; load Super Stars object

	.continued:
		move.w	#$800,Max_speed-Max_speed(a4)
		move.w	#$18,Acceleration-Max_speed(a4)
		move.w	#$C0,Deceleration-Max_speed(a4)
		move.b	#0,invincibility_timer(a0)
		bset	#Status_Invincible,status_secondary(a0)
		moveq	#signextendB(sfx_SuperTransform),d0
		jsr	(Play_SFX).l
		moveq	#signextendB(mus_Invincibility),d0		; play invincibility theme
		jmp	(Play_Music).l
; End of function Knux_JumpHeight


; =============== S U B R O U T I N E =======================================


Knux_DoLevelCollision_CheckRet:
		move.l	(Primary_collision_addr).w,(Collision_addr).w
		cmpi.b	#$C,top_solid_bit(a0)
		beq.s	locK_17952
		move.l	(Secondary_collision_addr).w,(Collision_addr).w

locK_17952:
		move.b	lrb_solid_bit(a0),d5
		move.w	x_vel(a0),d1
		move.w	y_vel(a0),d2
		jsr	(GetArcTan).l
		subi.b	#$20,d0
		andi.b	#$C0,d0
		cmpi.b	#$40,d0
		beq.w	locK_179DA
		cmpi.b	#$80,d0
		beq.w	locK_17A62
		cmpi.b	#$C0,d0
		beq.w	locK_17AB0
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	locK_1799C
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
		bset	#Status_Push,(Gliding_collision_flags).w

locK_1799C:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locK_179B4
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
		bset	#Status_Push,(Gliding_collision_flags).w

locK_179B4:
		bsr.w	subK_11FD6
		tst.w	d1
		bpl.s	locretK_179D8
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_179C4
		neg.w	d1

locK_179C4:
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		move.w	#0,y_vel(a0)
		bclr	#Status_InAir,(Gliding_collision_flags).w

locretK_179D8:
		rts
; ---------------------------------------------------------------------------

locK_179DA:
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	locK_179F2
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
		bset	#Status_Push,(Gliding_collision_flags).w

locK_179F2:
		bsr.w	subK_11FEE
		tst.w	d1
		bpl.s	locK_17A36
		neg.w	d1
		cmpi.w	#$14,d1
		bhs.s	locK_17A1C
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_17A0A
		neg.w	d1

locK_17A0A:
		add.w	d1,y_pos(a0)
		tst.w	y_vel(a0)
		bpl.s	locretK_17A1A
		move.w	#0,y_vel(a0)

locretK_17A1A:
		rts
; ---------------------------------------------------------------------------

locK_17A1C:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locretK_17A34
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
		bset	#Status_Push,(Gliding_collision_flags).w

locretK_17A34:
		rts
; ---------------------------------------------------------------------------

locK_17A36:
		tst.w	y_vel(a0)
		bmi.s	locretK_17A60
		bsr.w	subK_11FD6
		tst.w	d1
		bpl.s	locretK_17A60
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_17A4C
		neg.w	d1

locK_17A4C:
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		move.w	#0,y_vel(a0)
		bclr	#Status_InAir,(Gliding_collision_flags).w

locretK_17A60:
		rts
; ---------------------------------------------------------------------------

locK_17A62:
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	locK_17A7A
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
		bset	#Status_Push,(Gliding_collision_flags).w

locK_17A7A:
		jsr	(CheckRightWallDist).l
		tst.w	d1
		bpl.s	locK_17A94
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
		bset	#Status_Push,(Gliding_collision_flags).w

locK_17A94:
		bsr.w	subK_11FEE
		tst.w	d1
		bpl.s	locretK_17AAE
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_17AA4
		neg.w	d1

locK_17AA4:
		sub.w	d1,y_pos(a0)
		move.w	#0,y_vel(a0)

locretK_17AAE:
		rts
; ---------------------------------------------------------------------------

locK_17AB0:
		jsr	(CheckRightWallDist).l
		tst.w	d1
		bpl.s	locK_17ACA
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
		bset	#Status_Push,(Gliding_collision_flags).w

locK_17ACA:
		bsr.w	subK_11FEE
		tst.w	d1
		bpl.s	locK_17AEC
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_17ADA
		neg.w	d1

locK_17ADA:
		sub.w	d1,y_pos(a0)
		tst.w	y_vel(a0)
		bpl.s	locretK_17AEA
		move.w	#0,y_vel(a0)

locretK_17AEA:
		rts
; ---------------------------------------------------------------------------

locK_17AEC:
		tst.w	y_vel(a0)
		bmi.s	locretK_17B16
		bsr.w	subK_11FD6
		tst.w	d1
		bpl.s	locretK_17B16
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_17B02
		neg.w	d1

locK_17B02:
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		move.w	#0,y_vel(a0)
		bclr	#Status_InAir,(Gliding_collision_flags).w

locretK_17B16:
		rts
; End of function Knux_DoLevelCollision_CheckRet

; ---------------------------------------------------------------------------
; unused/dead code

Knux_TouchFloor_Check_Spindash:
		tst.b	spin_dash_flag(a0)
		bne.s	locK_17B6A
		move.b	#0,anim(a0)
; End of function Knux_TouchFloor_Check_Spindash


; =============== S U B R O U T I N E =======================================


Knux_TouchFloor:
		move.b	y_radius(a0),d0
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
		btst	#Status_Roll,status(a0)
		beq.s	locK_17B6A
		bclr	#Status_Roll,status(a0)
		move.b	#0,anim(a0)
		sub.b	default_y_radius(a0),d0
		ext.w	d0
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_17B56
		neg.w	d0

locK_17B56:
		move.w	d0,-(sp)
		move.b	angle(a0),d0
		addi.b	#$40,d0
		bpl.s	locK_17B64
		neg.w	(sp)

locK_17B64:
		move.w	(sp)+,d0
		add.w	d0,y_pos(a0)

locK_17B6A:
		bclr	#Status_InAir,status(a0)
		bclr	#Status_Push,status(a0)
		bclr	#Status_RollJump,status(a0)
		move.b	#0,jumping(a0)
		move.w	#0,(Chain_bonus_counter).w
		move.b	#0,flip_angle(a0)
		move.b	#0,flip_type(a0)
		move.b	#0,flips_remaining(a0)
		move.b	#0,scroll_delay_counter(a0)
		move.b	#0,double_jump_flag(a0)
		cmpi.b	#$20,anim(a0)
		blo.s	locretK_17BB4
		move.b	#0,anim(a0)

locretK_17BB4:
		rts
; End of function Knux_TouchFloor

; ---------------------------------------------------------------------------

locK_17BB6:
		tst.w	(Debug_mode_flag).w
		beq.s	locK_17BD0
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	locK_17BD0
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------

locK_17BD0:
		jsr	(MoveSprite_TestGravity2).l
		addi.w	#$30,y_vel(a0)
		btst	#Status_Underwater,status(a0)
		beq.s	locK_17BEA
		subi.w	#$20,y_vel(a0)

locK_17BEA:
		cmpi.w	#-$100,(Camera_min_Y_pos).w
		bne.s	locK_17BFA
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)

locK_17BFA:
		bsr.w	subK_17C10
		bsr.w	Player_LevelBound
		bsr.w	Sonic_RecordPos
		bsr.w	subK_17D1E
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


subK_17C10:
		tst.b	(Disable_death_plane).w
		bne.s	locK_17C3C
		tst.b	(Reverse_gravity_flag).w
		bne.s	locK_17C2E
		move.w	(Camera_max_Y_pos).w,d0
		addi.w	#$E0,d0
		cmp.w	y_pos(a0),d0
		blt.w	locK_17C82
		bra.s	locK_17C3C
; ---------------------------------------------------------------------------

locK_17C2E:
		move.w	(Camera_min_Y_pos).w,d0
		cmp.w	y_pos(a0),d0
		blt.s	locK_17C3C
		bra.w	locK_17C82
; ---------------------------------------------------------------------------

locK_17C3C:
		movem.l	a4-a6,-(sp)
		bsr.w	SonicKnux_DoLevelCollision
		movem.l	(sp)+,a4-a6
		btst	#Status_InAir,status(a0)
		bne.s	locretK_17C80
		moveq	#0,d0
		move.w	d0,y_vel(a0)
		move.w	d0,x_vel(a0)
		move.w	d0,ground_vel(a0)
		move.b	d0,object_control(a0)
		move.b	#0,anim(a0)
		move.w	#$100,priority(a0)
		move.b	#2,routine(a0)
		move.b	#2*60,invulnerability_timer(a0)
		move.b	#0,spin_dash_flag(a0)

locretK_17C80:
		rts
; ---------------------------------------------------------------------------

locK_17C82:
		jmp	(Kill_Character).l
; End of function subK_17C10

; ---------------------------------------------------------------------------

locK_17C88:
		tst.w	(Debug_mode_flag).w
		beq.s	locK_17CA2
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	locK_17CA2
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------

locK_17CA2:
		bsr.w	subK_123C2
		jsr	(MoveSprite_TestGravity).l
		bsr.w	Sonic_RecordPos
		bsr.w	subK_17D1E
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_17CBA:
		tst.w	$3E(a0)
		beq.s	locretK_17CCC
		subq.w	#1,$3E(a0)
		bne.s	locretK_17CCC
		move.w	#1,(Restart_level_flag).w

locretK_17CCC:
		rts
; ---------------------------------------------------------------------------

locK_17CCE:
		tst.w	(H_scroll_amount).w
		bne.s	locK_17CE0
		tst.w	(V_scroll_amount).w
		bne.s	locK_17CE0
		move.b	#2,routine(a0)

locK_17CE0:
		bsr.w	subK_17D1E
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_17CEA:
		tst.w	(Debug_mode_flag).w
		beq.s	locK_17D04
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	locK_17D04
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------

locK_17D04:
		jsr	(MoveSprite_TestGravity2).l
		addi.w	#$10,y_vel(a0)
		bsr.w	Sonic_RecordPos
		bsr.w	subK_17D1E
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


subK_17D1E:
		bsr.s	Animate_Knuckles
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_17D2C
		eori.b	#2,render_flags(a0)

locK_17D2C:
		bra.w	Knuckles_Load_PLC
; End of function subK_17D1E


; =============== S U B R O U T I N E =======================================


Animate_Knuckles:
		lea	(AniKnuckles).l,a1
		moveq	#0,d0
		move.b	anim(a0),d0
		cmp.b	prev_anim(a0),d0
		beq.s	locK_17D58
		move.b	d0,prev_anim(a0)
		move.b	#0,anim_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		bclr	#Status_Push,status(a0)

locK_17D58:
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),d0
		bmi.s	locK_17DC8
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locretK_17D96
		move.b	d0,anim_frame_timer(a0)

locK_17D7E:
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#$FC,d0
		bhs.s	locK_17D98

locK_17D8E:
		move.b	d0,mapping_frame(a0)
		addq.b	#1,anim_frame(a0)

locretK_17D96:
		rts
; ---------------------------------------------------------------------------

locK_17D98:
		addq.b	#1,d0
		bne.s	locK_17DA8
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
		bra.s	locK_17D8E
; ---------------------------------------------------------------------------

locK_17DA8:
		addq.b	#1,d0
		bne.s	locK_17DBC
		move.b	2(a1,d1.w),d0
		sub.b	d0,anim_frame(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	locK_17D8E
; ---------------------------------------------------------------------------

locK_17DBC:
		addq.b	#1,d0
		bne.s	locretK_17DC6
		move.b	2(a1,d1.w),anim(a0)

locretK_17DC6:
		rts
; ---------------------------------------------------------------------------

locK_17DC8:
		addq.b	#1,d0
		bne.w	locK_17E84
		moveq	#0,d0
		tst.b	flip_type(a0)
		bmi.w	Anim_Tumble
		move.b	flip_angle(a0),d0
		bne.w	Anim_Tumble
		moveq	#0,d1
		move.b	angle(a0),d0
		bmi.s	locK_17DEC
		beq.s	locK_17DEC
		subq.b	#1,d0

locK_17DEC:
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	locK_17DF8
		not.b	d0

locK_17DF8:
		addi.b	#$10,d0
		bpl.s	locK_17E00
		moveq	#3,d1

locK_17E00:
		andi.b	#$FC,render_flags(a0)
		eor.b	d1,d2
		or.b	d2,render_flags(a0)
		btst	#Status_Push,status(a0)
		bne.w	locK_17ECC
		lsr.b	#4,d0
		andi.b	#6,d0
		move.w	ground_vel(a0),d2
		bpl.s	locK_17E24
		neg.w	d2

locK_17E24:
		tst.b	status_secondary(a0)
		bpl.w	locK_17E2E
		add.w	d2,d2

locK_17E2E:
		lea	(AniKnuckles01).l,a1
		cmpi.w	#$600,d2
		bhs.s	locK_17E42
		lea	(AniKnuckles00).l,a1
		add.b	d0,d0

locK_17E42:
		add.b	d0,d0
		move.b	d0,d3
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	locK_17E60
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0

locK_17E60:
		move.b	d0,mapping_frame(a0)
		add.b	d3,mapping_frame(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locretK_17E82
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	locK_17E78
		moveq	#0,d2

locK_17E78:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)

locretK_17E82:
		rts
; ---------------------------------------------------------------------------

locK_17E84:
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locretK_17D96
		move.w	ground_vel(a0),d2
		bpl.s	locK_17EA6
		neg.w	d2

locK_17EA6:
		lea	(AniKnuckles03).l,a1
		cmpi.w	#$600,d2
		bhs.s	locK_17EB8
		lea	(AniKnuckles02).l,a1

locK_17EB8:
		neg.w	d2
		addi.w	#$400,d2
		bpl.s	locK_17EC2
		moveq	#0,d2

locK_17EC2:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		bra.w	locK_17D7E
; ---------------------------------------------------------------------------

locK_17ECC:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locretK_17D96
		move.w	ground_vel(a0),d2
		bmi.s	locK_17EDC
		neg.w	d2

locK_17EDC:
		addi.w	#$800,d2
		bpl.s	locK_17EE4
		moveq	#0,d2

locK_17EE4:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		lea	(AniKnuckles04).l,a1
		bra.w	locK_17D7E
; End of function Animate_Knuckles

; ---------------------------------------------------------------------------
AniKnuckles:
		include "General/Sprites/Knuckles/Anim - Knuckles.asm"

; =============== S U B R O U T I N E =======================================


Knuckles_Load_PLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0

Knuckles_Load_PLC2:
		cmp.b	(Player_prev_frame).w,d0
		beq.s	locretK_18162
		move.b	d0,(Player_prev_frame).w
		move.w	#tiles_to_bytes(ArtTile_Player_1),d4

locK_18122:
		lea	(PLC_Knuckles).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locretK_18162
		move.l	#ArtUnc_Knux,d6

locK_1813A:
		moveq	#0,d1
		move.w	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		add.l	d6,d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		dbf	d5,locK_1813A

locretK_18162:
		rts
; End of function Knuckles_Load_PLC