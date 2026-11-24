
; ---------------------------------------------------------------------------

Obj_Tails2P:
		cmpa.w	#Player_1,a0
		bne.s	locK_13130
		lea	(Max_speed).w,a4
		lea	(Distance_from_top).w,a5
		lea	(Dust).w,a6
		move.b	(Player_2+character_id).w,d0
		cmp.b	character_id(a0),d0
		bne.s	locK_13124
		bchg	#3,render_flags(a0)
; loc3_13E7A:
locK_13124:
		tst.w	(Debug_placement_mode).w
		beq.s	locK_1314C
		jmp	(DebugMode).l
; ---------------------------------------------------------------------------
; loc3_13E86:
locK_13130:
		lea	(Max_speed_P2).w,a4
		lea	(Distance_from_top_P2).w,a5
		lea	(Dust_P2).w,a6
		move.b	(Player_1+character_id).w,d0
		cmp.b	character_id(a0),d0
		bne.s	locK_1314C
		bchg	#4,render_flags(a0)
; loc3_13EA2:
locK_1314C:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Tails2P_Index(pc,d0.w),d1
		jmp	Tails2P_Index(pc,d1.w)
; ---------------------------------------------------------------------------

Tails2P_Index:
		dc.w locK_13166-Tails2P_Index
		dc.w locK_13274-Tails2P_Index
		dc.w locK_1569C-Tails2P_Index
		dc.w locK_1578E-Tails2P_Index
		dc.w locK_157E0-Tails2P_Index
		dc.w locK_157F4-Tails2P_Index
; ---------------------------------------------------------------------------
; loc3_13EBC:
locK_13166:
		addq.b	#2,routine(a0)
		move.b	#$B,y_radius(a0)
		move.b	#5,x_radius(a0)
		move.b	#$B,default_y_radius(a0)
		move.b	#5,default_x_radius(a0)
		move.l	#Map_Tails2P,mappings(a0)
		move.w	#$100,priority(a0)
		move.b	#$C,width_pixels(a0)
		move.b	#$C,height_pixels(a0)
		move.b	#$84,render_flags(a0)
		move.b	#1,character_id(a0)
		lea	(Character_Speeds).l,a1
		moveq	#0,d0
		move.b	character_id(a0),d0
		lsl.w	#3,d0
		lea	(a1,d0.w),a1
		move.w	(a1)+,Max_speed_P2-Max_speed_P2(a4)
		move.w	(a1)+,Acceleration_P2-Max_speed_P2(a4)
		move.w	(a1)+,Deceleration_P2-Max_speed_P2(a4)
		tst.b	(Last_star_post_hit).w
		bne.w	locK_13250
		move.b	#$C,top_solid_bit(a0)
		move.b	#$D,lrb_solid_bit(a0)
		cmpa.w	#Player_1,a0
		bne.s	locK_13218
		move.w	#make_art_tile(ArtTile_Player_1,0,0),art_tile(a0)
		cmpi.b	#$12,(Current_zone).w
		bne.s	locK_131F2
		ori.w	#high_priority,art_tile(a0)
; loc3_13F48:
locK_131F2:
		move.w	x_pos(a0),(Saved_X_pos).w
		move.w	y_pos(a0),(Saved_Y_pos).w
		move.w	art_tile(a0),(Saved_art_tile).w
		move.w	top_solid_bit(a0),(Saved_solid_bits).w
		move.l	#Obj_Tails2P_Tail,(Tails_tails_2P).w
		move.w	a0,(Tails_tails_2P+$30).w
		bra.s	locK_13250
; ---------------------------------------------------------------------------
; loc3_13F6E:
locK_13218:
		move.w	#make_art_tile(ArtTile_Player_2,0,0),art_tile(a0)
		cmpi.b	#$12,(Current_zone).w
		bne.s	locK_1322C
		ori.w	#high_priority,art_tile(a0)
; loc3_13F82:
locK_1322C:
		move.w	x_pos(a0),(Saved2_X_pos).w
		move.w	y_pos(a0),(Saved2_Y_pos).w
		move.w	art_tile(a0),(Saved2_art_tile).w
		move.w	top_solid_bit(a0),(Saved2_solid_bits).w
		move.l	#Obj_Tails2P_Tail,(Tails_tails).w
		move.w	a0,(Tails_tails+$30).w
; loc3_13F82:
locK_13250:
		move.b	#0,flips_remaining(a0)
		move.b	#4,flip_speed(a0)
		move.b	#30,air_left(a0)
		move.w	#0,(Tails_CPU_routine).w
		move.w	#10*60,(Tails_CPU_idle_timer).w
		move.w	#0,(Tails_CPU_flight_timer).w
; loc3_13FCA:
locK_13274:
		tst.w	(Debug_mode_flag).w
		beq.s	locK_13294
		cmpa.w	#Player_1,a0
		bne.s	locK_13294
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	locK_13294
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------
; loc3_13FEA:
locK_13294:
		cmpa.w	#Player_1,a0
		bne.s	locK_132B4
		move.w	(Ctrl_1_logical).w,(Ctrl_2_logical).w
		tst.b	(Ctrl_1_locked).w
		bne.s	locK_132C0
		move.w	(Ctrl_1).w,(Ctrl_2_logical).w
		move.w	(Ctrl_1).w,(Ctrl_1_logical).w
		bra.s	locK_132C0
; ---------------------------------------------------------------------------
; loc3_1400A:
locK_132B4:
		tst.b	(Ctrl_2_locked).w
		bne.s	locK_132C0
		move.w	(Ctrl_2).w,(Ctrl_2_logical).w
; loc3_14016:
locK_132C0:
		bsr.w	Tails_Display
		btst	#0,object_control(a0)
		bne.s	locK_132DE
		moveq	#0,d0
		move.b	status(a0),d0
		andi.w	#6,d0
		move.w	offK_1332E(pc,d0.w),d1
		jsr	offK_1332E(pc,d1.w)
; loc3_14034:
locK_132DE:
		cmpi.w	#-$100,(Camera_min_Y_pos).w
		bne.s	locK_132EE
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)
; loc3_14044:
locK_132EE:
		move.w	(Screen_X_wrap_value).w,d0
		and.w	d0,x_pos(a0)
		addi.w	#$400,x_pos(a0)
		bsr.w	Sonic_RecordPos
		move.b	(Primary_Angle).w,next_tilt(a0)
		move.b	(Secondary_Angle).w,tilt(a0)
		btst	#1,object_control(a0)
		bne.s	locK_1331C
		bsr.w	Animate_Tails2P
		bsr.w	Tails2P_Load_PLC
; loc3_14072:
locK_1331C:
		move.b	object_control(a0),d0
		andi.b	#$A0,d0
		bne.s	locretK_1332C
		jsr	(TouchResponse_CompetitionMode).l
; locret3_14082:
locretK_1332C:
		rts
; ---------------------------------------------------------------------------
; off3_14084:
offK_1332E:
		dc.w locK_13336-offK_1332E
		dc.w locK_1335A-offK_1332E
		dc.w locK_1346A-offK_1332E
		dc.w locK_1348C-offK_1332E
; ---------------------------------------------------------------------------
; loc3_1408C:
locK_13336:
		bsr.w	subK_13520
		bsr.w	Tails_Jump
	if Sonic3_Alone
		bsr.w	Tails_SlopeResist
	else
		bsr.w	Player_SlopeResist
	endif
		bsr.w	Tails_InputAcceleration_Path
		bsr.w	subK_134BA
		jsr	(MoveSprite2).l
		bsr.w	Player_AnglePos
	if Sonic3_Alone
		bsr.w	Tails_SlopeRepel
	else
		bsr.w	Player_SlopeRepel
	endif
		rts
; ---------------------------------------------------------------------------
; loc3_140B0:
locK_1335A:
		tst.b	double_jump_flag(a0)
		bne.s	locK_1338E
		bsr.w	Tails_JumpHeight
		bsr.w	Tails_InputAcceleration_Freespace
		jsr	(MoveSprite).l
		btst	#Status_Underwater,status(a0)
		beq.s	locK_1337C
		subi.w	#$28,y_vel(a0)
; loc3_140D2:
locK_1337C:
	if Sonic3_Alone
		bsr.w	Tails_JumpAngle
	else
		bsr.w	Player_JumpAngle
	endif
		movem.l	a4-a6,-(sp)
		bsr.w	Tails_DoLevelCollision
		movem.l	(sp)+,a4-a6
		rts
; ---------------------------------------------------------------------------
; loc3_140E4:
locK_1338E:
		bsr.w	subK_133AE
		bsr.w	Tails_InputAcceleration_Freespace
		jsr	(MoveSprite2).l
	if Sonic3_Alone
		bsr.w	Tails_JumpAngle
	else
		bsr.w	Player_JumpAngle
	endif
		movem.l	a4-a6,-(sp)
		bsr.w	Tails_DoLevelCollision
		movem.l	(sp)+,a4-a6
		rts

; =============== S U B R O U T I N E =======================================

; sub3_14104:
subK_133AE:
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#1,d0
		beq.s	locK_133C2
		tst.b	double_jump_property(a0)
		beq.s	locK_133C2
		subq.b	#1,double_jump_property(a0)
; loc3_14118:
locK_133C2:
		cmpi.b	#1,double_jump_flag(a0)
		beq.s	locK_133EC
		cmpi.w	#-$100,y_vel(a0)
		blt.s	locK_133E4
		subi.w	#$20,y_vel(a0)
		addq.b	#1,double_jump_flag(a0)
		cmpi.b	#$20,double_jump_flag(a0)
		bne.s	locK_133EA
; loc3_1413A:
locK_133E4:
		move.b	#1,double_jump_flag(a0)
; loc3_14140:
locK_133EA:
		bra.s	locK_1341E
; ---------------------------------------------------------------------------
; loc3_14142:
locK_133EC:
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	locK_13418
		cmpi.w	#-$100,y_vel(a0)
		blt.s	locK_13418
		tst.b	double_jump_property(a0)
		beq.s	locK_13418
		btst	#Status_Underwater,status(a0)
		beq.s	locK_13412
		tst.b	(Flying_carrying_Sonic_flag).w
		bne.s	locK_13418
; loc3_14168:
locK_13412:
		move.b	#2,double_jump_flag(a0)
; loc3_1416E:
locK_13418:
		addi.w	#8,y_vel(a0)
; loc3_14174:
locK_1341E:
		move.w	(Camera_min_Y_pos).w,d0
		addi.w	#$10,d0
		cmp.w	y_pos(a0),d0
		blt.s	locK_13438
		tst.w	y_vel(a0)
		bpl.s	locK_13438
		move.w	#0,y_vel(a0)
; loc3_1418E:
locK_13438:
		tst.b	double_jump_property(a0)
		bne.s	locK_13454
		move.b	(Level_frame_counter+1).w,d0
		addq.b	#8,d0
		andi.b	#$F,d0
		bne.s	locretK_13452
		moveq	#signextendB(sfx_FlyTired),d0
		jsr	(Play_SFX).l
; locret3_141A8:
locretK_13452:
		rts
; ---------------------------------------------------------------------------
; loc3_141AA:
locK_13454:
		move.b	(Level_frame_counter+1).w,d0
		addq.b	#8,d0
		andi.b	#$F,d0
		bne.s	locretK_13468
		moveq	#signextendB(sfx_Flying),d0
		jsr	(Play_SFX).l
; locret3_141BE:
locretK_13468:
		rts
; End of function subK_133AE

; ---------------------------------------------------------------------------
; loc3_141C0:
locK_1346A:
		tst.b	spin_dash_flag(a0)
		bne.s	locK_13474
		bsr.w	Tails_Jump
; loc3_141CA:
locK_13474:
	if Sonic3_Alone
		bsr.w	Tails_RollRepel
	else
		bsr.w	Player_RollRepel
	endif
		bsr.w	Tails_RollSpeed
		jsr	(MoveSprite2).l
		bsr.w	Player_AnglePos
	if Sonic3_Alone
		bsr.w	Tails_SlopeRepel
	else
		bsr.w	Player_SlopeRepel
	endif
		rts
; ---------------------------------------------------------------------------
; loc3_141E2:
locK_1348C:
		bsr.w	Tails_JumpHeight
		bsr.w	Tails_InputAcceleration_Freespace
		jsr	(MoveSprite).l
		btst	#Status_Underwater,status(a0)
		beq.s	locK_134A8
		subi.w	#$28,y_vel(a0)
; loc3_141FE:
locK_134A8:
	if Sonic3_Alone
		bsr.w	Tails_JumpAngle
	else
		bsr.w	Player_JumpAngle
	endif
		movem.l	a4-a6,-(sp)
		bsr.w	Tails_DoLevelCollision
		movem.l	(sp)+,a4-a6
		rts

; =============== S U B R O U T I N E =======================================

; sub3_14210:
subK_134BA:
		tst.b	status_secondary(a0)
		bmi.s	locretK_134E0
		move.w	ground_vel(a0),d0
		bpl.s	locK_134C8
		neg.w	d0
; loc3_1421E:
locK_134C8:
		cmpi.w	#$80,d0
		blo.s	locretK_134E0
		move.b	(Ctrl_2_held_logical).w,d0
		andi.b	#button_left_mask|button_right_mask,d0
		bne.s	locretK_134E0
		btst	#button_down,(Ctrl_2_held_logical).w
		bne.s	locK_134E2
; locret3_14236:
locretK_134E0:
		rts
; ---------------------------------------------------------------------------
; loc3_14238:
locK_134E2:
		btst	#Status_Roll,status(a0)
		beq.s	locK_134EC
		rts
; ---------------------------------------------------------------------------
; loc3_14242:
locK_134EC:
		bset	#Status_Roll,status(a0)
		move.b	#7,y_radius(a0)
		move.b	#3,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#4,y_pos(a0)
		move.w	#sfx_Roll,d0
		jsr	(Play_SFX).l
		tst.w	ground_vel(a0)
		bne.s	locretK_1351E
		move.w	#$200,ground_vel(a0)
; locret3_14274:
locretK_1351E:
		rts
; End of function subK_134BA


; =============== S U B R O U T I N E =======================================

; sub3_14276:
subK_13520:
		tst.b	spin_dash_flag(a0)
		bne.s	locK_13570
		cmpi.b	#8,anim(a0)
		bne.s	locretK_1356E
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locretK_1356E
		move.b	#9,anim(a0)
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addq.l	#4,sp
		move.b	#1,spin_dash_flag(a0)
		move.w	#0,spin_dash_counter(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	locK_13566
		move.b	#2,anim(a6)
; loc3_142BC:
locK_13566:
		bsr.w	Tails_Check_Screen_Boundaries
		bsr.w	Player_AnglePos
; locret3_142C4:
locretK_1356E:
		rts
; ---------------------------------------------------------------------------
; loc3_142C6:
locK_13570:
		move.b	(Ctrl_2_held_logical).w,d0
		btst	#button_down,d0
		bne.w	locK_13600
		move.b	#7,y_radius(a0)
		move.b	#3,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#4,y_pos(a0)
		move.b	#0,spin_dash_flag(a0)
		moveq	#0,d0
		move.b	spin_dash_counter(a0),d0
		add.w	d0,d0
		move.w	wordK_135EE(pc,d0.w),ground_vel(a0)
		move.w	ground_vel(a0),d0
		subi.w	#$800,d0
		add.w	d0,d0
		andi.w	#$1F00,d0
		neg.w	d0
		addi.w	#$2000,d0
		lea	(H_scroll_frame_offset).w,a1
		cmpa.w	#Player_1,a0
		beq.s	locK_135C8
		lea	(H_scroll_frame_offset_P2).w,a1
; loc3_1431E:
locK_135C8:
		move.w	d0,(a1)
		btst	#Status_Facing,status(a0)
		beq.s	locK_135D6
		neg.w	ground_vel(a0)
; loc3_1432C:
locK_135D6:
		bset	#Status_Roll,status(a0)
		move.b	#0,anim(a6)
		move.w	#signextendB(sfx_Dash),d0
		jsr	(Play_SFX).l
		bra.s	locK_13648
; ---------------------------------------------------------------------------
; word3_14344:
wordK_135EE:
		dc.w   $800
		dc.w   $880
		dc.w   $900
		dc.w   $980
		dc.w   $A00
		dc.w   $A80
		dc.w   $B00
		dc.w   $B80
		dc.w   $C00
; ---------------------------------------------------------------------------
; loc3_14356:
locK_13600:
		tst.w	spin_dash_counter(a0)
		beq.s	locK_13618
		move.w	spin_dash_counter(a0),d0
		lsr.w	#5,d0
		sub.w	d0,spin_dash_counter(a0)
		bcc.s	locK_13618
		move.w	#0,spin_dash_counter(a0)
; loc3_1436E:
locK_13618:
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locK_13648
		move.w	#9<<8,anim(a0)	; and prev_anim
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addi.w	#$200,spin_dash_counter(a0)
		cmpi.w	#$800,spin_dash_counter(a0)
		blo.s	locK_13648
		move.w	#$800,spin_dash_counter(a0)
; loc3_1439E:
locK_13648:
		addq.l	#4,sp
		cmpi.w	#$60,(a5)
		beq.s	locK_13656
		bcc.s	locK_13654
		addq.w	#4,(a5)
; loc3_143AA:
locK_13654:
		subq.w	#2,(a5)
; loc3_143AC:
locK_13656:
		bsr.w	Player_AnglePos
		rts
; End of function subK_13520

; ---------------------------------------------------------------------------

Obj_Tails:
		lea	(Max_speed_P2).w,a4
		lea	(Distance_from_top_P2).w,a5
		lea	(Dust_P2).w,a6
		cmpi.w	#2,(Player_mode).w
		bne.s	Tails_Normal
		tst.w	(Debug_placement_mode).w
		beq.s	Tails_Normal
		cmpi.b	#1,(Debug_placement_type).w
		beq.s	locK_136A8
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	locK_1368C
		move.w	#0,(Debug_placement_mode).w
; loc3_143E2:
locK_1368C:
		addq.b	#1,mapping_frame(a0)
	if Sonic3_Alone
		cmpi.b	#$D1,mapping_frame(a0)
	else
		cmpi.b	#$FB,mapping_frame(a0)
	endif
		blo.s	locK_1369E
		move.b	#0,mapping_frame(a0)
; loc3_143F4:
locK_1369E:
		bsr.w	Tails_Load_PLC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_143FE:
locK_136A8:
		jmp	(DebugMode).l
; ---------------------------------------------------------------------------

Tails_Normal:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Tails_Index(pc,d0.w),d1
		jmp	Tails_Index(pc,d1.w)
; ---------------------------------------------------------------------------

Tails_Index:
		dc.w Tails_Init-Tails_Index
		dc.w Tails_Control-Tails_Index
		dc.w locK_1569C-Tails_Index
		dc.w locK_1578E-Tails_Index
		dc.w locK_157E0-Tails_Index
		dc.w locK_157F4-Tails_Index
		dc.w locK_15810-Tails_Index
; ---------------------------------------------------------------------------

Tails_Init:
		addq.b	#2,routine(a0)
		move.b	#$F,y_radius(a0)
		move.b	#9,x_radius(a0)
		move.b	#$F,default_y_radius(a0)
		move.b	#9,default_x_radius(a0)
		move.l	#Map_Tails,mappings(a0)
		move.w	#$100,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#$84,render_flags(a0)
		move.b	#1,character_id(a0)
		move.w	#$600,Max_speed_P2-Max_speed_P2(a4)
		move.w	#$C,Acceleration_P2-Max_speed_P2(a4)
		move.w	#$80,Deceleration_P2-Max_speed_P2(a4)
		cmpi.w	#2,(Player_mode).w
		bne.s	locK_1375E
		tst.b	(Last_star_post_hit).w
		bne.s	Tails_Init_Continued
		move.w	#make_art_tile(ArtTile_Player_2,0,0),art_tile(a0)
		move.b	#$C,top_solid_bit(a0)
		move.b	#$D,lrb_solid_bit(a0)
		cmpi.b	#2,(Special_bonus_entry_flag).w
		beq.s	Tails_Init_Continued
		move.w	x_pos(a0),(Saved_X_pos).w
		move.w	y_pos(a0),(Saved_Y_pos).w
		move.w	art_tile(a0),(Saved_art_tile).w
		move.w	top_solid_bit(a0),(Saved_solid_bits).w
		bra.s	Tails_Init_Continued
; ---------------------------------------------------------------------------
; loc3_144B4:
locK_1375E:
		move.w	#make_art_tile(ArtTile_Player_2,0,0),art_tile(a0)
		move.w	(Player_1+top_solid_bit).w,top_solid_bit(a0)
		tst.w	(Player_1+art_tile).w
		bpl.s	Tails_Init_Continued
		ori.w	#high_priority,art_tile(a0)

Tails_Init_Continued:
		move.b	#0,flips_remaining(a0)
		move.b	#4,flip_speed(a0)
	if ~~Sonic3_Alone
		move.b	#0,(Super_Tails_flag).w
	endif
		move.b	#30,air_left(a0)
		cmpi.w	#$20,(Tails_CPU_routine).w
		beq.s	locK_137A4
		cmpi.w	#$12,(Tails_CPU_routine).w
		beq.s	locK_137A4
		move.w	#0,(Tails_CPU_routine).w
; loc3_144F4:
locK_137A4:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.w	#0,(Tails_CPU_flight_timer).w
		move.l	#Obj_Tails_Tail,(Tails_tails).w
		move.w	a0,(Tails_tails+$30).w
		move.b	(Last_star_post_hit).w,(Tails_CPU_star_post_flag).w
		rts
; ---------------------------------------------------------------------------

Tails_Control:
		cmpi.w	#2,(Player_mode).w
		bne.s	locK_13808
		tst.w	(Debug_mode_flag).w
		beq.s	locK_13808
	if ~~Sonic3_Alone
		bclr	#button_A,(Ctrl_1_pressed).w
		beq.s	locK_137E0
		eori.b	#1,(Reverse_gravity_flag).w

locK_137E0:
	endif
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	locK_13808
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		btst	#button_C,(Ctrl_1_held).w
		beq.s	locretK_13806
		move.w	#2,(Debug_placement_mode).w
	if ~~Sonic3_Alone
		move.b	#0,anim(a0)
	endif
; locret3_14542:
locretK_13806:
		rts
; ---------------------------------------------------------------------------
; loc3_14544:
locK_13808:
		cmpa.w	#Player_1,a0
		bne.s	locK_13830
		move.w	(Ctrl_1_logical).w,(Ctrl_2_logical).w
		tst.b	(Ctrl_1_locked).w
		bne.s	locK_1384A
		move.w	(Ctrl_1).w,(Ctrl_2_logical).w
		move.w	(Ctrl_1).w,(Ctrl_1_logical).w
		cmpi.w	#$1A,(Tails_CPU_routine).w
		bhs.s	locK_13840
		bra.s	locK_1384A
; ---------------------------------------------------------------------------
; loc3_1456C:
locK_13830:
		tst.b	(Ctrl_2_locked).w
	if Sonic3_Alone
		bne.s	locK_1384A
	else
		beq.s	locK_1383A
		bpl.s	locK_13840
		bra.s	locK_1384A
; ---------------------------------------------------------------------------

locK_1383A:
	endif
		move.w	(Ctrl_2).w,(Ctrl_2_logical).w
; loc3_14578:
locK_13840:
		tst.w	(Competition_mode).w
		bne.s	locK_1384A
		bsr.w	Tails_CPU_Control
; loc3_14582:
locK_1384A:
		btst	#0,object_control(a0)
		beq.s	locK_13872
		move.b	#0,double_jump_flag(a0)
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	locK_1388C
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#Status_InAir,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w
		bra.s	locK_1388C
; ---------------------------------------------------------------------------
; loc3_145AA:
locK_13872:
		movem.l	a4-a6,-(sp)
		moveq	#0,d0
		move.b	status(a0),d0
		andi.w	#6,d0
		move.w	Tails_Modes(pc,d0.w),d1
		jsr	Tails_Modes(pc,d1.w)
		movem.l	(sp)+,a4-a6
; loc3_145C4:
locK_1388C:
		cmpi.w	#-$100,(Camera_min_Y_pos).w
		bne.s	locK_1389C
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)
; loc3_145D4:
locK_1389C:
		bsr.s	Tails_Display
	if ~~Sonic3_Alone
		bsr.w	Tails_Super
	endif
		bsr.w	Sonic_RecordPos
		bsr.w	Tails_Water
		move.b	(Primary_Angle).w,next_tilt(a0)
		move.b	(Secondary_Angle).w,tilt(a0)
		tst.b	(WindTunnel_flag_P2).w
		beq.s	locK_138C8
		tst.b	anim(a0)
		bne.s	locK_138C8
		move.b	prev_anim(a0),anim(a0)
; loc3_145FC:
locK_138C8:
		btst	#1,object_control(a0)
		bne.s	locK_138E4
		bsr.w	Animate_Tails
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_138E0
		eori.b	#2,render_flags(a0)

locK_138E0:
	endif
		bsr.w	Tails_Load_PLC
; loc3_1460C:
locK_138E4:
		move.b	object_control(a0),d0
		andi.b	#$A0,d0
		bne.s	locretK_138F4
		jsr	(TouchResponse).l
; locret3_1461C:
locretK_138F4:
		rts
; ---------------------------------------------------------------------------

Tails_Modes:
		dc.w Tails_Stand_Path-Tails_Modes
		dc.w Tails_Stand_Freespace-Tails_Modes
		dc.w Tails_Spin_Path-Tails_Modes
		dc.w Tails_Spin_Freespace-Tails_Modes
; ---------------------------------------------------------------------------

Tails_Display:
		move.b	invulnerability_timer(a0),d0
		beq.s	locK_1390C
		subq.b	#1,invulnerability_timer(a0)
		lsr.b	#3,d0
		bcc.s	locK_13912
; loc3_14634:
locK_1390C:
		jsr	(Draw_Sprite).l
; loc3_1463A:
locK_13912:
		btst	#Status_Invincible,status_secondary(a0)
		beq.s	locK_1394E
		tst.b	invincibility_timer(a0)
		beq.s	locK_1394E
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0
		bne.s	locK_1394E
		subq.b	#1,invincibility_timer(a0)
		bne.s	locK_1394E
		tst.b	(Boss_flag).w
		bne.s	locK_13948
		cmpi.b	#12,air_left(a0)
		blo.s	locK_13948
		move.w	(Current_music).w,d0
		jsr	(Play_Music).l
; loc3_14670:
locK_13948:
		bclr	#Status_Invincible,status_secondary(a0)
; loc3_14676:
locK_1394E:
		btst	#Status_SpeedShoes,status_secondary(a0)
		beq.s	locretK_139A6
		tst.b	speed_shoes_timer(a0)
		beq.s	locretK_139A6
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0
		bne.s	locretK_139A6
		subq.b	#1,speed_shoes_timer(a0)
		bne.s	locretK_139A6
		tst.w	(Competition_mode).w
		bne.s	locK_139A8
		move.w	#$600,Max_speed_P2-Max_speed_P2(a4)
		move.w	#$C,Acceleration_P2-Max_speed_P2(a4)
		move.w	#$80,Deceleration_P2-Max_speed_P2(a4)
	if ~~Sonic3_Alone
		tst.b	(Super_Tails_flag).w
		beq.s	locK_13998
		move.w	#$800,Max_speed_P2-Max_speed_P2(a4)
		move.w	#$18,Acceleration_P2-Max_speed_P2(a4)
		move.w	#$C0,Deceleration_P2-Max_speed_P2(a4)

locK_13998:
	endif
		bclr	#Status_SpeedShoes,status_secondary(a0)
		moveq	#0,d0
		jmp	(Change_Music_Tempo).l
; ---------------------------------------------------------------------------
; locret3_146B8:
locretK_139A6:
		rts
; ---------------------------------------------------------------------------
; loc3_146BA:
locK_139A8:
		lea	(Character_Speeds).l,a1
		moveq	#0,d0
		move.b	character_id(a0),d0
		lsl.w	#3,d0
		lea	(a1,d0.w),a1
		move.w	(a1)+,Max_speed_P2-Max_speed_P2(a4)
		move.w	(a1)+,Acceleration_P2-Max_speed_P2(a4)
		move.w	(a1)+,Deceleration_P2-Max_speed_P2(a4)
		bclr	#Status_SpeedShoes,status_secondary(a0)
		rts

; =============== S U B R O U T I N E =======================================


Tails_CPU_Control:
	if Sonic3_Alone
		move.b	(Ctrl_2_held).w,d0
	else
		move.b	(Ctrl_2_held_logical).w,d0
	endif
		andi.b	#button_up_mask|button_down_mask|button_left_mask|button_right_mask|button_B_mask|button_C_mask|button_A_mask,d0
		beq.s	locK_139DC
		move.w	#10*60,(Tails_CPU_idle_timer).w
; loc3_145EE:
locK_139DC:
		lea	(Player_1).w,a1
		move.w	(Tails_CPU_routine).w,d0
		move.w	Tails_CPU_Control_Index(pc,d0.w),d0
		jmp	Tails_CPU_Control_Index(pc,d0.w)
; End of function Tails_CPU_Control

; ---------------------------------------------------------------------------
Tails_CPU_Control_Index:
		dc.w locK_13A10-Tails_CPU_Control_Index
		dc.w Tails_Catch_Up_Flying-Tails_CPU_Control_Index
		dc.w Tails_FlySwim_Unknown-Tails_CPU_Control_Index
		dc.w locK_13D4A-Tails_CPU_Control_Index
		dc.w locK_13F40-Tails_CPU_Control_Index
		dc.w locretK_13FC0-Tails_CPU_Control_Index
		dc.w locK_13FC2-Tails_CPU_Control_Index
		dc.w locK_13FFA-Tails_CPU_Control_Index
		dc.w locK_1408A-Tails_CPU_Control_Index
		dc.w locK_140C6-Tails_CPU_Control_Index
		dc.w locK_140CE-Tails_CPU_Control_Index
		dc.w locK_14106-Tails_CPU_Control_Index
		dc.w locK_1414C-Tails_CPU_Control_Index
		dc.w locK_141F2-Tails_CPU_Control_Index
		dc.w locK_1421C-Tails_CPU_Control_Index
		dc.w locK_14254-Tails_CPU_Control_Index
		dc.w locK_1425C-Tails_CPU_Control_Index
		dc.w locK_14286-Tails_CPU_Control_Index
; ---------------------------------------------------------------------------
; loc3_14722:
locK_13A10:
		tst.b	(Tails_CPU_star_post_flag).w
		bne.w	locK_13AF4
		cmpi.w	#0,(Current_zone_and_act).w
		bne.s	locK_13A32
		bsr.w	subK_13ECA
		move.w	#$A,(Tails_CPU_routine).w
		move.b	#$83,object_control(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_14744:
locK_13A32:
		cmpi.w	#$100,(Current_zone_and_act).w
		beq.w	locK_13B12
		cmpi.w	#$200,(Current_zone_and_act).w
		beq.w	locK_13B12
		cmpi.w	#$300,(Current_zone_and_act).w
		bne.s	locK_13A74
	if ~~Sonic3_Alone
		move.w	#$18,x_pos(a0)
		move.w	#$600,y_pos(a0)

locK_13A5A:
	endif
		move.w	#0,(Tails_CPU_idle_timer).w
		move.w	#0,(Tails_CPU_flight_timer).w
		move.b	#2,status(a0)
	if Sonic3_Alone
		move.w	#$18,x_pos(a0)
		move.w	#$600,y_pos(a0)
	endif
		move.w	#$C,(Tails_CPU_routine).w
		rts
; ---------------------------------------------------------------------------
; loc3_14786:
locK_13A74:
		cmpi.w	#$500,(Current_zone_and_act).w
		bne.s	locK_13A8E
		bsr.w	subK_13ECA
		move.w	#$A,(Tails_CPU_routine).w
		move.b	#$83,object_control(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_147A0:
locK_13A8E:
		cmpi.w	#$600,(Current_zone_and_act).w
	if Sonic3_Alone
		beq.s	locK_13B12
	else
		beq.w	locK_13B12
		cmpi.w	#$700,(Current_zone_and_act).w
		bne.s	locK_13AB4
		tst.w	(SK_alone_flag).w
		bne.s	locK_13AB4
		move.w	#$D8,x_pos(a0)
		move.w	#$500,y_pos(a0)
		bra.s	locK_13A5A
; ---------------------------------------------------------------------------

locK_13AB4:
		cmpi.w	#$800,(Current_zone_and_act).w
		beq.w	locK_13B18
		cmpi.w	#$900,(Current_zone_and_act).w
		beq.w	locK_13B12
		cmpi.w	#$A00,(Current_zone_and_act).w
		bne.s	locK_13AE2
		bsr.w	subK_13ECA
		move.w	#$A,(Tails_CPU_routine).w
		move.b	#$83,object_control(a0)
		rts
; ---------------------------------------------------------------------------

locK_13AE2:
		cmpi.w	#$1600,(Current_zone_and_act).w
		beq.w	locK_13B12
		cmpi.b	#$17,(Current_zone).w
		beq.s	locK_13B18
	endif
; loc3_147A8:
locK_13AF4:
		move.b	#0,anim(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		move.b	#0,status(a0)
; loc3_147C6:
locK_13B12:
	if Sonic3_Alone
		move.w	#6,(Tails_CPU_routine).w
		move.b	#0,object_control(a0)
		move.w	#0,(Tails_CPU_flight_timer).w
	else
		move.b	#0,object_control(a0)

locK_13B18:
		move.w	#6,(Tails_CPU_routine).w
		move.w	#0,(Tails_CPU_flight_timer).w
	endif
		rts
; ---------------------------------------------------------------------------

Tails_Catch_Up_Flying:
		move.b	(Ctrl_2_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask|button_start_mask,d0
		bne.s	locK_13B50
		move.w	(Level_frame_counter).w,d0
		andi.w	#$3F,d0
		bne.w	locretK_13BF6
		tst.b	object_control(a1)
	if Sonic3_Alone
		bne.w	locretK_13BF6
		move.b	status(a1),d0
		andi.b	#$92,d0
	else
		bmi.w	locretK_13BF6
		move.b	status(a1),d0
		andi.b	#$80,d0
	endif
		bne.w	locretK_13BF6
; loc3_14804:
locK_13B50:
		move.w	#4,(Tails_CPU_routine).w
		move.w	x_pos(a1),d0
		move.w	d0,x_pos(a0)
		move.w	d0,(Tails_CPU_target_X).w
		move.w	y_pos(a1),d0
		move.w	d0,(Tails_CPU_target_Y).w
		subi.w	#$C0,d0
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_13B78
		addi.w	#2*$C0,d0

locK_13B78:
	endif
		move.w	d0,y_pos(a0)
		ori.w	#high_priority,art_tile(a0)
		move.w	#$100,priority(a0)
		moveq	#0,d0
		move.w	d0,x_vel(a0)
		move.w	d0,y_vel(a0)
		move.w	d0,ground_vel(a0)
		move.b	d0,flip_type(a0)
		move.b	d0,double_jump_flag(a0)
		move.b	#2,status(a0)
		move.b	#30,air_left(a0)
		move.b	#$81,object_control(a0)
		move.b	d0,flips_remaining(a0)
		move.b	d0,flip_speed(a0)
		move.w	d0,move_lock(a0)
		move.b	d0,invulnerability_timer(a0)
		move.b	d0,invincibility_timer(a0)
		move.b	d0,speed_shoes_timer(a0)
		move.b	d0,status_tertiary(a0)
		move.b	d0,scroll_delay_counter(a0)
		move.w	d0,next_tilt(a0)	; and tilt
		move.b	d0,stick_to_convex(a0)
		move.b	d0,spin_dash_flag(a0)
		move.b	d0,spin_dash_flag(a0)
		move.w	d0,spin_dash_counter(a0)
		move.b	d0,jumping(a0)
		move.b	d0,$41(a0)
		move.b	#(8*60)/2,double_jump_property(a0)
		bsr.w	Tails_Set_Flying_Animation
; locret3_148A0:
locretK_13BF6:
		rts
; ---------------------------------------------------------------------------

Tails_FlySwim_Unknown:
		tst.b	render_flags(a0)
		bmi.s	locK_13C3A
		addq.w	#1,(Tails_CPU_flight_timer).w
		cmpi.w	#5*60,(Tails_CPU_flight_timer).w
		blo.s	locK_13C50
		move.w	#0,(Tails_CPU_flight_timer).w
		move.w	#2,(Tails_CPU_routine).w
		move.b	#$81,object_control(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.w	#0,x_pos(a0)
		move.w	#0,y_pos(a0)
		move.b	#(8*60)/2,double_jump_property(a0)
		bsr.w	Tails_Set_Flying_Animation
		rts
; ---------------------------------------------------------------------------
; loc3_148E4:
locK_13C3A:
		move.b	#(8*60)/2,double_jump_property(a0)
		ori.b	#1<<Status_InAir,status(a0)
		bsr.w	Tails_Set_Flying_Animation
		move.w	#0,(Tails_CPU_flight_timer).w
; loc3_148FA:
locK_13C50:
		lea	(Pos_table).w,a2
		move.w	#$10,d2
		lsl.b	#2,d2
		addq.b	#4,d2
		move.w	(Pos_table_index).w,d3
		sub.b	d2,d3
		move.w	(a2,d3.w),(Tails_CPU_target_X).w
		move.w	2(a2,d3.w),(Tails_CPU_target_Y).w
	if Sonic3_Alone
		bsr.w	Tails_Set_Flying_Animation
	endif
		move.w	x_pos(a0),d0
		sub.w	(Tails_CPU_target_X).w,d0
		beq.s	locK_13CBE
		move.w	d0,d2
		bpl.s	locK_13C7E
		neg.w	d2
; loc3_1492C:
locK_13C7E:
		lsr.w	#4,d2
		cmpi.w	#$C,d2
		blo.s	locK_13C88
		moveq	#$C,d2
; loc3_14936:
locK_13C88:
		move.b	x_vel(a1),d1
		bpl.s	locK_13C90
		neg.b	d1
; loc3_1493E:
locK_13C90:
		add.b	d1,d2
		addq.w	#1,d2
		tst.w	d0
		bmi.s	locK_13CAA
		bset	#Status_Facing,status(a0)
		cmp.w	d0,d2
		blo.s	locK_13CA6
		move.w	d0,d2
		moveq	#0,d0

locK_13CA6:
		neg.w	d2
		bra.s	locK_13CBA
; ---------------------------------------------------------------------------
; loc3_14958:
locK_13CAA:
		bclr	#Status_Facing,status(a0)
		neg.w	d0
		cmp.w	d0,d2
		blo.s	locK_13CBA
		move.b	d0,d2
		moveq	#0,d0
; loc3_14968:
locK_13CBA:
		add.w	d2,x_pos(a0)
; loc3_1496C:
locK_13CBE:
		moveq	#1,d2
		move.w	y_pos(a0),d1
		sub.w	(Tails_CPU_target_Y).w,d1
		beq.s	locK_13CD2
		bmi.s	locK_13CCE
		neg.w	d2
; loc3_1497C:
locK_13CCE:
		add.w	d2,y_pos(a0)
; loc3_14980:
locK_13CD2:
		lea	(Stat_table).w,a2
		move.b	2(a2,d3.w),d2
	if Sonic3_Alone
		andi.b	#$92,d2
		bne.s	locret3_149E6
		or.w	d0,d1
		bne.s	locret3_149E6
	else
		andi.b	#$80,d2
		bne.s	locK_13D42
		or.w	d0,d1
		bne.s	locK_13D42
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	locK_13D42
	endif
		move.w	#6,(Tails_CPU_routine).w
		move.b	#0,object_control(a0)
		move.b	#0,anim(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		andi.b	#1<<Status_Underwater,status(a0)
		ori.b	#1<<Status_InAir,status(a0)
		move.w	#0,move_lock(a0)
		andi.w	#drawing_mask,art_tile(a0)
		tst.b	art_tile(a1)
		bpl.s	locK_13D34
		ori.w	#high_priority,art_tile(a0)
; loc3_149DA:
locK_13D34:
		move.b	top_solid_bit(a1),top_solid_bit(a0)
		move.b	lrb_solid_bit(a1),lrb_solid_bit(a0)

locret3_149E6:
		rts
; ---------------------------------------------------------------------------
	if ~~Sonic3_Alone
locK_13D42:
		move.b	#$81,object_control(a0)
		rts
	endif
; ---------------------------------------------------------------------------
; loc3_149E8:
locK_13D4A:
		cmpi.b	#6,(Player_1+routine).w
		blo.s	locK_13D78
		move.w	#4,(Tails_CPU_routine).w
		move.b	#0,spin_dash_flag(a0)
		move.w	#0,spin_dash_counter(a0)
		move.b	#$81,object_control(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.b	#$20,anim(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_14A16:
locK_13D78:
		bsr.w	subK_13EFC
		tst.w	(Tails_CPU_idle_timer).w
		bne.w	locK_13EBE
		tst.b	object_control(a0)
		bmi.w	locK_13EBE
		tst.b	status_tertiary(a1)
		bmi.w	locK_13EBE
		tst.w	move_lock(a0)
		beq.s	locK_13DA6
		tst.w	ground_vel(a0)
		bne.s	locK_13DA6
		move.w	#8,(Tails_CPU_routine).w
; loc3_14A44:
locK_13DA6:
		lea	(Pos_table).w,a2
		move.w	#$10,d1
		lsl.b	#2,d1
		addq.b	#4,d1
		move.w	(Pos_table_index).w,d0
		sub.b	d1,d0
		move.w	(a2,d0.w),d2
		btst	#Status_OnObj,status(a1)
		bne.s	locK_13DD0
		cmpi.w	#$400,ground_vel(a1)
		bge.s	locK_13DD0
		subi.w	#$20,d2
; loc3_14A6E:
locK_13DD0:
		move.w	2(a2,d0.w),d3
		lea	(Stat_table).w,a2
		move.w	(a2,d0.w),d1
		move.b	2(a2,d0.w),d4
		move.w	d1,d0
		btst	#Status_Push,status(a0)
		beq.s	locK_13DF2
		btst	#5,d4
		beq.w	locK_13E9C
; loc3_14A90:
locK_13DF2:
		sub.w	x_pos(a0),d2
		beq.s	locK_13E50
		bpl.s	locK_13E26
		neg.w	d2
		cmpi.w	#$30,d2
		blo.s	locK_13E0A
		andi.w	#$F3F3,d1
		ori.w	#$404,d1
; loc3_14AA8:
locK_13E0A:
		tst.w	ground_vel(a0)
		beq.s	locK_13E64
		btst	#Status_Facing,status(a0)
		beq.s	locK_13E64
	if ~~Sonic3_Alone
		btst	#0,object_control(a0)
		bne.s	locK_13E64
	endif
		subq.w	#1,x_pos(a0)
		bra.s	locK_13E64
; ---------------------------------------------------------------------------
; loc3_14ABC:
locK_13E26:
		cmpi.w	#$30,d2
		blo.s	locK_13E34
		andi.w	#$F3F3,d1
		ori.w	#$808,d1
; loc3_14ACA:
locK_13E34:
		tst.w	ground_vel(a0)
		beq.s	locK_13E64
		btst	#Status_Facing,status(a0)
		bne.s	locK_13E64
	if ~~Sonic3_Alone
		btst	#0,object_control(a0)
		bne.s	locK_13E64
	endif
		addq.w	#1,x_pos(a0)
		bra.s	locK_13E64
; ---------------------------------------------------------------------------
; loc3_14ADE:
locK_13E50:
		bclr	#Status_Facing,status(a0)
		move.b	d4,d0
		andi.b	#1,d0
		beq.s	locK_13E64
		bset	#Status_Facing,status(a0)
; loc3_14AF2:
locK_13E64:
		tst.b	(Tails_CPU_auto_jump_flag).w
		beq.s	locK_13E7C
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|0,d1
		btst	#Status_InAir,status(a0)
		bne.s	locK_13EB8
		move.b	#0,(Tails_CPU_auto_jump_flag).w
; loc3_14B0A:
locK_13E7C:
		move.w	(Level_frame_counter).w,d0
		andi.w	#$FF,d0
		beq.s	locK_13E8C
		cmpi.w	#$40,d2
		bhs.s	locK_13EB8
; loc3_14B1A:
locK_13E8C:
		sub.w	y_pos(a0),d3
		beq.s	locK_13EB8
		bpl.s	locK_13EB8
		neg.w	d3
		cmpi.w	#$20,d3
		blo.s	locK_13EB8
; loc3_14B2A:
locK_13E9C:
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#$3F,d0
		bne.s	locK_13EB8
		cmpi.b	#8,anim(a0)
		beq.s	locK_13EB8
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),d1
		move.b	#1,(Tails_CPU_auto_jump_flag).w
; loc3_14B46:
locK_13EB8:
		move.w	d1,(Ctrl_2_logical).w
		rts
; ---------------------------------------------------------------------------
; loc3_14B4C:
locK_13EBE:
		tst.w	(Tails_CPU_idle_timer).w
		beq.s	locretK_13EC8
		subq.w	#1,(Tails_CPU_idle_timer).w
; locret3_14B56:
locretK_13EC8:
		rts

; =============== S U B R O U T I N E =======================================

; sub3_14B58:
subK_13ECA:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.w	#0,(Tails_CPU_flight_timer).w
		move.w	#2,(Tails_CPU_routine).w
		move.b	#$81,object_control(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.w	#$7F00,x_pos(a0)
		move.w	#0,y_pos(a0)
		move.b	#0,double_jump_flag(a0)
		rts
; End of function subK_13ECA


; =============== S U B R O U T I N E =======================================

; sub3_14B8A:
subK_13EFC:
		tst.b	render_flags(a0)
		bmi.s	locK_13F28
		btst	#Status_OnObj,status(a0)
		beq.s	locK_13F18
		moveq	#0,d0
		movea.w	interact(a0),a3
		move.w	(Tails_CPU_interact).w,d0
		cmp.w	(a3),d0
		bne.s	locK_13F24
; loc3_14BA6:
locK_13F18:
		addq.w	#1,(Tails_CPU_flight_timer).w
		cmpi.w	#5*60,(Tails_CPU_flight_timer).w
		blo.s	locK_13F2E
; loc3_14BB2:
locK_13F24:
		bra.w	subK_13ECA
; ---------------------------------------------------------------------------
; loc3_14BB6:
locK_13F28:
		move.w	#0,(Tails_CPU_flight_timer).w
; loc3_14BBC:
locK_13F2E:
	if ~~Sonic3_Alone
		btst	#Status_OnObj,status(a0)
		beq.s	locretK_13F3E
	endif
		movea.w	interact(a0),a3
		move.w	(a3),(Tails_CPU_interact).w

locretK_13F3E:
		rts
; End of function subK_13EFC

; ---------------------------------------------------------------------------
; loc3_14BC6:
locK_13F40:
		bsr.w	subK_13EFC
		tst.w	(Tails_CPU_idle_timer).w
		bne.w	locretK_13FBE
		tst.w	move_lock(a0)
		bne.s	locretK_13FBE
		tst.b	spin_dash_flag(a0)
		bne.s	locK_13F94
		tst.w	ground_vel(a0)
		bne.s	locretK_13FBE
		bclr	#Status_Facing,status(a0)
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bcs.s	locK_13F74
		bset	#Status_Facing,status(a0)
; loc3_14BFA:
locK_13F74:
		move.w	#(button_down_mask<<8)|button_down_mask,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#$7F,d0
		beq.s	locK_13FA4
		cmpi.b	#8,anim(a0)
		bne.s	locretK_13FBE
		move.w	#((button_A_mask|button_B_mask|button_C_mask|button_down_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask|button_down_mask),(Ctrl_2_logical).w
		rts
; ---------------------------------------------------------------------------
; loc3_14C1A:
locK_13F94:
		move.w	#(button_down_mask<<8)|button_down_mask,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#$7F,d0
		bne.s	locK_13FB2
; loc3_14C2A:
locK_13FA4:
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		move.w	#6,(Tails_CPU_routine).w
		rts
; ---------------------------------------------------------------------------
; loc3_14C38:
locK_13FB2:
		andi.b	#$1F,d0
		bne.s	locretK_13FBE
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w
; locret3_14C44:
locretK_13FBE:
		rts
; ---------------------------------------------------------------------------
; locret3_14C46:
locretK_13FC0:
		rts
; ---------------------------------------------------------------------------
; loc3_14C48:
locK_13FC2:
		move.b	#1,double_jump_flag(a0)
		move.b	#(8*60)/2,double_jump_property(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.w	#$100,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		lea	(Player_1).w,a1
		bsr.w	subK_1459E
		move.b	#1,(Flying_carrying_Sonic_flag).w
		move.w	#$E,(Tails_CPU_routine).w
; loc3_14C80:
locK_13FFA:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.w	#0,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#$1F,d0
		bne.s	locK_14016
		ori.w	#(button_right_mask<<8)|button_right_mask,(Ctrl_2_logical).w
; loc3_14C9C:
locK_14016:
		lea	(Flying_carrying_Sonic_flag).w,a2
		lea	(Player_1).w,a1
		btst	#Status_InAir,status(a1)
		bne.s	locK_14082
		move.w	#6,(Tails_CPU_routine).w
		move.b	#0,object_control(a0)
		move.b	#0,anim(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.w	#0,move_lock(a0)
		andi.w	#drawing_mask,art_tile(a0)
		tst.b	art_tile(a1)
		bpl.s	locK_14068
		ori.w	#high_priority,art_tile(a0)
; loc3_14CEE:
locK_14068:
		move.b	top_solid_bit(a1),top_solid_bit(a0)
		move.b	lrb_solid_bit(a1),lrb_solid_bit(a0)
		cmpi.w	#1,(Player_mode).w
		bne.s	locK_14082
		move.w	#$10,(Tails_CPU_routine).w
; loc3_14D08:
locK_14082:
		move.w	(Ctrl_1).w,d0
		bra.w	Tails_Carry_Sonic
; ---------------------------------------------------------------------------
; loc3_14D10:
locK_1408A:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.b	#(8*60)/2,double_jump_property(a0)
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#$F,d0
		bne.s	locK_140AC
		ori.w	#((button_A_mask|button_B_mask|button_C_mask|button_right_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask|button_right_mask),(Ctrl_2_logical).w
; locret3_14D32:
locK_140AC:
		tst.b	render_flags(a0)
		bmi.s	locretK_140C4
	if Sonic3_Alone
		move.w	#$7F00,x_pos(a0)
		move.w	#0,y_pos(a0)
	else
		moveq	#0,d0
		move.l	d0,(a0)
		move.w	d0,x_pos(a0)
		move.w	d0,y_pos(a0)
	endif
		move.w	#$A,(Tails_CPU_routine).w
; locret3_14D4A:
locretK_140C4:
		rts
; ---------------------------------------------------------------------------
; loc3_14D4C:
locK_140C6:
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		rts
; ---------------------------------------------------------------------------
; loc3_14D54:
locK_140CE:
		move.b	#1,double_jump_flag(a0)
		move.b	#(8*60)/2,double_jump_property(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		lea	(Player_1).w,a1
		bsr.w	subK_1459E
		move.b	#1,(Flying_carrying_Sonic_flag).w
		move.w	#$16,(Tails_CPU_routine).w
; loc3_14D8C:
locK_14106:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.b	#(8*60)/2,double_jump_property(a0)
		move.w	#0,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0
		bne.s	locK_14128
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w
; loc3_14DAE:
locK_14128:
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$90,d0
		cmp.w	y_pos(a0),d0
		blo.s	locK_1413C
		move.w	#$18,(Tails_CPU_routine).w
; loc3_14DC2:
locK_1413C:
		lea	(Flying_carrying_Sonic_flag).w,a2
		lea	(Player_1).w,a1
		move.w	(Ctrl_1).w,d0
		bra.w	Tails_Carry_Sonic
; ---------------------------------------------------------------------------
; loc3_14DD2:
locK_1414C:
		move.b	#(8*60)/2,double_jump_property(a0)
		tst.w	(Tails_CPU_idle_timer).w
		beq.s	locK_14164
		tst.b	(Flying_carrying_Sonic_flag).w
		bne.w	locK_141E2
		bra.w	locK_142E2
; ---------------------------------------------------------------------------
; loc3_14DEA:
locK_14164:
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.w	locK_142E2
		clr.b	(_unkFAAC).w
		btst	#button_down,(Ctrl_1_held).w
		beq.s	locK_14198
		addq.b	#1,(Tails_CPU_auto_fly_timer).w
		cmpi.b	#$C0,(Tails_CPU_auto_fly_timer).w
		blo.s	locK_141D2
		move.b	#0,(Tails_CPU_auto_fly_timer).w
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w
		bra.s	locK_141D2
; ---------------------------------------------------------------------------
; loc3_14E1E:
locK_14198:
		btst	#button_up,(Ctrl_1_held).w
		beq.s	locK_141BA
		addq.b	#1,(Tails_CPU_auto_fly_timer).w
		cmpi.b	#$20,(Tails_CPU_auto_fly_timer).w
		blo.s	locK_141D2
		move.b	#0,(Tails_CPU_auto_fly_timer).w
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w
		bra.s	locK_141D2
; ---------------------------------------------------------------------------
; loc3_14E40:
locK_141BA:
		addq.b	#1,(Tails_CPU_auto_fly_timer).w
		cmpi.b	#$58,(Tails_CPU_auto_fly_timer).w
		blo.s	locK_141D2
		move.b	#0,(Tails_CPU_auto_fly_timer).w
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w
; loc3_14E58:
locK_141D2:
		move.b	(Ctrl_1_held).w,d0
		andi.b	#button_left_mask|button_right_mask,d0
		or.b	(Ctrl_2_held_logical).w,d0
		move.b	d0,(Ctrl_2_logical).w
; loc3_14E68:
locK_141E2:
		lea	(Flying_carrying_Sonic_flag).w,a2
		lea	(Player_1).w,a1
		move.w	(Ctrl_1).w,d0
		bra.w	Tails_Carry_Sonic
; ---------------------------------------------------------------------------
; loc3_14E78:
locK_141F2:
		move.b	#1,double_jump_flag(a0)
		move.b	#(8*60)/2,double_jump_property(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		move.w	#$1C,(Tails_CPU_routine).w
; loc3_14EA2:
locK_1421C:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.b	#(8*60)/2,double_jump_property(a0)
		move.w	#0,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0
		bne.s	locK_1423E
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w
; loc3_14EC4:
locK_1423E:
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$90,d0
		cmp.w	y_pos(a0),d0
		blo.s	locretK_14252
		move.w	#$1E,(Tails_CPU_routine).w
; locret3_14ED8:
locretK_14252:
		rts
; ---------------------------------------------------------------------------
; loc3_14EDA:
locK_14254:
		move.b	#(8*60)/2,double_jump_property(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_14EE2:
locK_1425C:
		move.b	#1,double_jump_flag(a0)
		move.b	#(8*60)/2,double_jump_property(a0)
		move.b	#2,status(a0)
		move.w	#$100,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		move.w	#$22,(Tails_CPU_routine).w
; loc3_14F0C:
locK_14286:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#$1F,d0
		bne.s	locK_142A2
		ori.w	#(button_right_mask<<8)|button_right_mask,(Ctrl_2_logical).w
; loc3_14F29"
locK_142A2:
		btst	#Status_InAir,status(a0)
		bne.s	locretK_142E0
		move.w	#6,(Tails_CPU_routine).w
		move.b	#0,object_control(a0)
		move.b	#0,anim(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.w	#0,move_lock(a0)
		andi.w	#drawing_mask,art_tile(a0)
; locret3_14F66:
locretK_142E0:
		rts
; ---------------------------------------------------------------------------
; loc3_14F68:
locK_142E2:
		tst.b	(_unkFAAC).w
		bne.s	locK_14362
		lea	(Player_1).w,a1
		tst.b	render_flags(a1)
		bpl.s	locK_14330
		tst.w	(Tails_CPU_idle_timer).w
		bne.w	locK_143AA
		cmpi.w	#$300,y_vel(a1)
		bge.s	locK_14330
		move.w	#0,x_vel(a0)
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		cmpi.w	#$200,y_vel(a0)
		bge.s	locK_14328
		addq.b	#1,(Tails_CPU_auto_fly_timer).w
		cmpi.b	#$58,(Tails_CPU_auto_fly_timer).w
		blo.s	locK_1432E
		move.b	#0,(Tails_CPU_auto_fly_timer).w
; loc3_14EAE:
locK_14328:
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w
; loc3_14FB4:
locK_1432E:
		bra.s	locK_143AA
; ---------------------------------------------------------------------------
; loc3_14FB6:
locK_14330:
		st	(_unkFAAC).w
		move.w	y_pos(a1),d1
		sub.w	y_pos(a0),d1
		bpl.s	locK_14340
		neg.w	d1
; loc3_14FC6:
locK_14340:
		lsr.w	#2,d1
		move.w	d1,d2
		lsr.w	#1,d2
		add.w	d2,d1
		move.w	d1,(Camera_stored_min_X_pos).w
		move.w	x_pos(a1),d1
		sub.w	x_pos(a0),d1
		bpl.s	locK_14358
		neg.w	d1
; loc3_14FDE:
locK_14358:
		lsr.w	#2,d1
		move.w	d1,(Camera_stored_max_X_pos).w
		bra.w	locK_143AA
; ---------------------------------------------------------------------------
; loc3_14FE8:
locK_14362:
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		lea	(Player_1).w,a1
		move.w	x_pos(a0),d0
		move.w	y_pos(a0),d1
		subi.w	#$10,d1
		move.w	(Camera_stored_max_X_pos).w,d2
		bclr	#Status_Facing,status(a0)
		cmp.w	x_pos(a1),d0
		blo.s	locK_14390
		bset	#Status_Facing,status(a0)
		neg.w	d2
; loc3_15016:
locK_14390:
		add.w	d2,x_vel(a0)
		cmp.w	y_pos(a1),d1
		bhs.s	locK_143AA
		move.w	(Camera_stored_min_X_pos).w,d2
		cmp.w	y_pos(a1),d1
		blo.s	locK_143A6
		neg.w	d2
; loc3_1502C:
locK_143A6:
		add.w	d2,y_vel(a0)
; loc3_15030:
locK_143AA:
		lea	(Flying_carrying_Sonic_flag).w,a2
		lea	(Player_1).w,a1
		move.w	(Ctrl_1).w,d0
		bra.w	Tails_Carry_Sonic

; =============== S U B R O U T I N E =======================================


Tails_Carry_Sonic:
		tst.b	(a2)
		beq.w	locK_14534
		cmpi.b	#4,routine(a1)
		bhs.w	locK_14466
		btst	#Status_InAir,status(a1)
		beq.w	locK_1445A
		move.w	(_unkF744).w,d1
		cmp.w	x_vel(a1),d1
		bne.s	locK_1445A
		move.w	(_unkF74C).w,d1
		cmp.w	y_vel(a1),d1
		bne.s	locK_14460
		tst.b	object_control(a1)
		bmi.s	locK_1446A
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locK_14474
		clr.b	object_control(a1)
		clr.b	(a2)
		move.b	#$12,1(a2)
		andi.w	#(button_up_mask|button_down_mask|button_left_mask|button_right_mask)<<8,d0
		beq.w	locK_14410
		move.b	#$3C,1(a2)
; loc3_15096:
locK_14410:
		btst	#button_left+8,d0
		beq.s	locK_1441C
		move.w	#-$200,x_vel(a1)
; loc3_150A2:
locK_1441C:
		btst	#button_right+8,d0
		beq.s	locK_14428
		move.w	#$200,x_vel(a1)
; loc3_150AE:
locK_14428:
		move.w	#-$380,y_vel(a1)
		bset	#Status_InAir,status(a1)
		move.b	#1,jumping(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		move.b	#2,anim(a1)
		bset	#Status_Roll,status(a1)
		bclr	#Status_RollJump,status(a1)
		rts
; ---------------------------------------------------------------------------
; loc3_150E0:
locK_1445A:
		move.w	#-$100,y_vel(a1)
; loc3_150E6:
locK_14460:
		move.b	#0,jumping(a1)
; loc3_150EC:
locK_14466:
		clr.b	object_control(a1)
; loc3_150F0:
locK_1446A:
		clr.b	(a2)
		move.b	#$3C,1(a2)
		rts
; ---------------------------------------------------------------------------
; loc3_150FA:
locK_14474:
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		addi.w	#$1C,y_pos(a1)
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_14492
		subi.w	#2*$1C,y_pos(a1)

locK_14492:
	endif
		andi.b	#$FC,render_flags(a1)
		andi.b	#$FE,status(a1)
		move.b	status(a0),d0
		andi.b	#1,d0
		or.b	d0,render_flags(a1)
		or.b	d0,status(a1)
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_144BA
		eori.b	#2,render_flags(a1)

locK_144BA:
	endif
		subq.b	#1,anim_frame_timer(a1)
		bpl.s	locK_144F8
		move.b	#$B,anim_frame_timer(a1)
		moveq	#0,d1
		move.b	anim_frame(a1),d1
		addq.b	#1,anim_frame(a1)
		move.b	AniRaw_Tails_Carry(pc,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	locK_144E4
		move.b	#0,anim_frame(a1)
		move.b	AniRaw_Tails_Carry(pc),d0
; loc3_15152:
locK_144E4:
		move.b	d0,mapping_frame(a1)
		moveq	#0,d0
		move.b	mapping_frame(a1),d0
		move.l	a2,-(sp)
		jsr	(Perform_Player_DPLC).l
		movea.l	(sp)+,a2
; loc3_15166:
locK_144F8:
		move.w	x_vel(a0),(Player_1+x_vel).w
		move.w	x_vel(a0),(_unkF744).w
		move.w	y_vel(a0),(Player_1+y_vel).w
		move.w	y_vel(a0),(_unkF74C).w
		movem.l	d0-a6,-(sp)
		lea	(Player_1).w,a0
		bsr.w	SonicKnux_DoLevelCollision
		movem.l	(sp)+,d0-a6
		rts
; ---------------------------------------------------------------------------

AniRaw_Tails_Carry:
		dc.b  $91, $91, $90, $90, $90, $90, $90, $90, $92, $92, $92, $92, $92, $92, $91, $91, $FF
		even
; ---------------------------------------------------------------------------
; loc3_151A2:
locK_14534:
		tst.b	1(a2)
		beq.s	locK_14542
		subq.b	#1,1(a2)
		bne.w	locretK_1459C
; loc3_151B0:
locK_14542:
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		addi.w	#$10,d0
		cmpi.w	#$20,d0
		bhs.w	locretK_1459C
		move.w	y_pos(a1),d1
		sub.w	y_pos(a0),d1
		subi.w	#$20,d1
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_1456C
		addi.w	#$50,d1

locK_1456C:
	endif
		cmpi.w	#$10,d1
		bhs.w	locretK_1459C
		tst.b	object_control(a1)
		bne.s	locretK_1459C
		cmpi.b	#4,routine(a1)
		bhs.s	locretK_1459C
		tst.w	(Debug_placement_mode).w
		bne.s	locretK_1459C
		tst.b	spin_dash_flag(a1)
		bne.s	locretK_1459C
		bsr.s	subK_1459E
		moveq	#signextendB(sfx_Grab),d0
		jsr	(Play_SFX).l
		move.b	#1,(a2)
; loc3_15200:
locretK_1459C:
		rts
; End of function Tails_Carry_Sonic


; =============== S U B R O U T I N E =======================================

; sub3_15202:
subK_1459E:
		clr.w	x_vel(a1)
		clr.w	y_vel(a1)
		clr.w	ground_vel(a1)
		clr.w	angle(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		addi.w	#$1C,y_pos(a1)
		move.w	#$22<<8,anim(a1)	; and prev_anim
		move.b	#0,anim_frame_timer(a1)
		move.b	#0,anim_frame(a1)
		move.b	#3,object_control(a1)
		bset	#Status_InAir,status(a1)
		bclr	#Status_RollJump,status(a1)
		move.b	#0,spin_dash_flag(a1)
		andi.b	#$FC,render_flags(a1)
		andi.b	#$FE,status(a1)
		move.b	status(a0),d0
		andi.b	#1,d0
		or.b	d0,render_flags(a1)
		or.b	d0,status(a1)
		move.w	x_vel(a0),(_unkF744).w
		move.w	x_vel(a0),x_vel(a1)
		move.w	y_vel(a0),(_unkF74C).w
		move.w	y_vel(a0),y_vel(a1)
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locretK_14630
		subi.w	#$38,y_pos(a1)
		eori.b	#2,render_flags(a1)

locretK_14630:
	endif
		rts
; End of function subK_1459E


; =============== S U B R O U T I N E =======================================


Tails_Water:
		tst.b	(Water_flag).w
		bne.s	locK_1463A
; locret3_1528A:
locretK_14638:
		rts
; ---------------------------------------------------------------------------
; loc3_1528C:
locK_1463A:
		move.w	(Water_level).w,d0
		cmp.w	y_pos(a0),d0
		bge.s	locK_146BA
		bset	#Status_Underwater,status(a0)
		bne.s	locretK_14638
		addq.b	#1,(Water_entered_counter).w
		movea.l	a0,a1
		bsr.w	Player_ResetAirTimer
		move.l	#Obj_AirCountdown,(Breathing_bubbles_P2).w
		move.b	#$81,(Breathing_bubbles_P2+subtype).w
		move.l	a0,(Breathing_bubbles_P2+$40).w
		move.w	#$300,Max_speed-Max_speed(a4)
		move.w	#6,Acceleration-Max_speed(a4)
		move.w	#$40,Deceleration-Max_speed(a4)
	if ~~Sonic3_Alone
		tst.b	(Super_Tails_flag).w
		beq.s	locK_1468E
		move.w	#$400,Max_speed-Max_speed(a4)
		move.w	#$C,Acceleration-Max_speed(a4)
		move.w	#$60,Deceleration-Max_speed(a4)

locK_1468E:
	endif
		cmpi.w	#4,(Tails_CPU_routine).w
		beq.s	locK_1469C
		tst.b	object_control(a0)
		bne.s	locretK_14638
; loc3_152D8:
locK_1469C:
		asr	x_vel(a0)
		asr	y_vel(a0)
		asr	y_vel(a0)
		beq.s	locretK_14638
		move.w	#1<<8,anim(a6)	; and prev_anim
		move.w	#sfx_Splash,d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------
; loc3_152F6:
locK_146BA:
		bclr	#Status_Underwater,status(a0)
	if Sonic3_Alone
		beq.s	locretK_14638
	else
		beq.w	locretK_14638
	endif
		addq.b	#1,(Water_entered_counter).w
		movea.l	a0,a1
		bsr.w	Player_ResetAirTimer
		move.w	#$600,Max_speed-Max_speed(a4)
		move.w	#$C,Acceleration-Max_speed(a4)
		move.w	#$80,Deceleration-Max_speed(a4)
	if ~~Sonic3_Alone
		tst.b	(Super_Tails_flag).w
		beq.s	locK_146F4
		move.w	#$800,Max_speed-Max_speed(a4)
		move.w	#$18,Acceleration-Max_speed(a4)
		move.w	#$C0,Deceleration-Max_speed(a4)

locK_146F4:
	endif
		cmpi.b	#4,routine(a0)
		beq.s	locK_14718
		cmpi.w	#4,(Tails_CPU_routine).w
		beq.s	locK_1470A
		tst.b	object_control(a0)
		bne.s	locK_14718
; loc3_1532E:
locK_1470A:
		move.w	y_vel(a0),d0
		cmpi.w	#-$400,d0
		blt.s	locK_14718
		asl	y_vel(a0)
; loc3_1553C:
locK_14718:
		cmpi.b	#$1C,anim(a0)
		beq.w	locretK_14638
		tst.w	y_vel(a0)
		beq.w	locretK_14638
		move.w	#1<<8,anim(a6)	; and prev_anim
		cmpi.w	#-$1000,y_vel(a0)
		bgt.s	locK_1473E
		move.w	#-$1000,y_vel(a0)
; loc3_15362:
locK_1473E:
		move.w	#sfx_Splash,d0
		jmp	(Play_SFX).l
; End of function Tails_Water

; ---------------------------------------------------------------------------

Tails_Stand_Path:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	locK_14760
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#Status_InAir,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w
; loc3_15384:
locK_14760:
		bsr.w	Tails_Spindash
		bsr.w	Tails_Jump
	if Sonic3_Alone
		bsr.w	Tails_SlopeResist
	else
		bsr.w	Player_SlopeResist
	endif
		bsr.w	Tails_InputAcceleration_Path
		bsr.w	Tails_Roll
		bsr.w	Tails_Check_Screen_Boundaries
	if Sonic3_Alone
		jsr	(MoveSprite2).l
		bsr.w	Player_AnglePos
		bsr.w	Tails_SlopeRepel
	else
		jsr	(MoveSprite_TestGravity2).l
		bsr.w	Call_Player_AnglePos
		bsr.w	Player_SlopeRepel
	endif
		tst.b	(Background_collision_flag).w
		beq.s	locretK_147B6
	if Sonic3_Alone
		bsr.w	sub_10BA2
	else
		bsr.w	sub_F846
	endif
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
	if Sonic3_Alone
		movem.l	(sp)+,a4-a6
	endif
		tst.w	d1
		bpl.s	locK_147A6
		sub.w	d1,x_pos(a0)

locK_147A6:
	if ~~Sonic3_Alone
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locK_147B2
		add.w	d1,x_pos(a0)

locK_147B2:
		movem.l	(sp)+,a4-a6
	endif
; locret3_153CE:
locretK_147B6:
		rts
; ---------------------------------------------------------------------------

Tails_Stand_Freespace:
		tst.b	double_jump_flag(a0)
		bne.s	Tails_FlyingSwimming
		bsr.w	Tails_JumpHeight
		bsr.w	Tails_InputAcceleration_Freespace
		bsr.w	Tails_Check_Screen_Boundaries
	if Sonic3_Alone
		jsr	(MoveSprite).l
	else
		jsr	(MoveSprite_TestGravity).l
	endif
		btst	#Status_Underwater,status(a0)
		beq.s	locK_147DE
		subi.w	#$28,y_vel(a0)
; loc3_153F6:
locK_147DE:
	if Sonic3_Alone
		bsr.w	Tails_JumpAngle
	else
		bsr.w	Player_JumpAngle
	endif
		bsr.w	Tails_DoLevelCollision
		rts
; ---------------------------------------------------------------------------

Tails_FlyingSwimming:
		bsr.w	Tails_Move_FlySwim
		bsr.w	Tails_InputAcceleration_Freespace
		bsr.w	Tails_Check_Screen_Boundaries
	if Sonic3_Alone
		jsr	(MoveSprite2).l
		bsr.w	Tails_JumpAngle
	else
		jsr	(MoveSprite_TestGravity2).l
		bsr.w	Player_JumpAngle
	endif
		movem.l	a4-a6,-(sp)
		bsr.w	Tails_DoLevelCollision
		movem.l	(sp)+,a4-a6
		tst.w	(Player_mode).w
		bne.s	locretK_14820
		lea	(Flying_carrying_Sonic_flag).w,a2
		lea	(Player_1).w,a1
		move.w	(Ctrl_1).w,d0
		bsr.w	Tails_Carry_Sonic
; locret3_15438:
locretK_14820:
		rts

; =============== S U B R O U T I N E =======================================


Tails_Move_FlySwim:
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#1,d0
		beq.s	locK_14836
		tst.b	double_jump_property(a0)
		beq.s	locK_14836
		subq.b	#1,double_jump_property(a0)
; loc3_1544E:
locK_14836:
		cmpi.b	#1,double_jump_flag(a0)
		beq.s	locK_14860
		cmpi.w	#-$100,y_vel(a0)
		blt.s	locK_14858
		subi.w	#$20,y_vel(a0)
		addq.b	#1,double_jump_flag(a0)
		cmpi.b	#$20,double_jump_flag(a0)
		bne.s	locK_1485E
; loc3_15470:
locK_14858:
		move.b	#1,double_jump_flag(a0)
; loc3_15476:
locK_1485E:
		bra.s	locK_14892
; ---------------------------------------------------------------------------
; loc3_15478:
locK_14860:
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	locK_1488C
		cmpi.w	#-$100,y_vel(a0)
		blt.s	locK_1488C
		tst.b	double_jump_property(a0)
		beq.s	locK_1488C
		btst	#Status_Underwater,status(a0)
		beq.s	locK_14886
		tst.b	(Flying_carrying_Sonic_flag).w
		bne.s	locK_1488C
; loc3_1549E:
locK_14886:
		move.b	#2,double_jump_flag(a0)
; loc3_154A4:
locK_1488C:
		addi.w	#8,y_vel(a0)
; loc3_154AA:
locK_14892:
		move.w	(Camera_min_Y_pos).w,d0
		addi.w	#$10,d0
		cmp.w	y_pos(a0),d0
		blt.s	Tails_Set_Flying_Animation
		tst.w	y_vel(a0)
		bpl.s	Tails_Set_Flying_Animation
		move.w	#0,y_vel(a0)
; End of function Tails_Move_FlySwim


; =============== S U B R O U T I N E =======================================


Tails_Set_Flying_Animation:
		btst	#Status_Underwater,status(a0)
		bne.s	locK_14914
		moveq	#$20,d0
		tst.w	(Competition_mode).w
		bne.s	locK_148F4
		tst.w	y_vel(a0)
		bpl.s	locK_148C4
		moveq	#$21,d0
; loc3_154DC:
locK_148C4:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	locK_148CC
		addq.b	#2,d0
; loc3_154E4:
locK_148CC:
		tst.b	double_jump_property(a0)
		bne.s	locK_148F4
		moveq	#$24,d0
		move.b	d0,anim(a0)
		tst.b	render_flags(a0)
		bpl.s	locretK_148F2
		move.b	(Level_frame_counter+1).w,d0
		addq.b	#8,d0
		andi.b	#$F,d0
		bne.s	locretK_148F2
		moveq	#signextendB(sfx_FlyTired),d0
		jsr	(Play_SFX).l
; locret3_1550A:
locretK_148F2:
		rts
; ---------------------------------------------------------------------------
; loc3_1550C:
locK_148F4:
		move.b	d0,anim(a0)
		tst.b	render_flags(a0)
		bpl.s	locretK_14912
		move.b	(Level_frame_counter+1).w,d0
		addq.b	#8,d0
		andi.b	#$F,d0
		bne.s	locretK_14912
		moveq	#signextendB(sfx_Flying),d0
		jsr	(Play_SFX).l
; locret3_1552A:
locretK_14912:
		rts
; ---------------------------------------------------------------------------
; loc3_1552C:
locK_14914:
		moveq	#$25,d0
		tst.w	y_vel(a0)
		bpl.s	locK_1491E
		moveq	#$26,d0
; loc3_15536:
locK_1491E:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	locK_14926
		moveq	#$27,d0
; loc3_1553E:
locK_14926:
		tst.b	double_jump_property(a0)
		bne.s	locK_1492E
		moveq	#$28,d0
; loc3_15546:
locK_1492E:
		move.b	d0,anim(a0)
		rts
; End of function Tails_Set_Flying_Animation

; ---------------------------------------------------------------------------

Tails_Spin_Path:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	locK_1494C
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#Status_InAir,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w
; loc3_15564:
locK_1494C:
		tst.b	spin_dash_flag(a0)
		bne.s	locK_14956
		bsr.w	Tails_Jump
; loc3_1556E:
locK_14956:
	if Sonic3_Alone
		bsr.w	Tails_RollRepel
	else
		bsr.w	Player_RollRepel
	endif
		bsr.w	Tails_RollSpeed
		bsr.w	Tails_Check_Screen_Boundaries
	if Sonic3_Alone
		jsr	(MoveSprite2).l
		bsr.w	Player_AnglePos
		bsr.w	Tails_SlopeRepel
	else
		jsr	(MoveSprite_TestGravity2).l
		bsr.w	Call_Player_AnglePos
		bsr.w	Player_SlopeRepel
	endif
		tst.b	(Background_collision_flag).w
		beq.s	locretK_149A0
	if Sonic3_Alone
		bsr.w	sub_10BA2
	else
		bsr.w	sub_F846
	endif
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
	if Sonic3_Alone
		movem.l	(sp)+,a4-a6
	endif
		tst.w	d1
		bpl.s	locK_14990
		sub.w	d1,x_pos(a0)

locK_14990:
	if ~~Sonic3_Alone
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locK_1499C
		add.w	d1,x_pos(a0)

locK_1499C:
		movem.l	(sp)+,a4-a6
	endif
; locret3_155AC:
locretK_149A0:
		rts
; ---------------------------------------------------------------------------

Tails_Spin_Freespace:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	locK_149BA
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#Status_InAir,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w
; loc3_155C6:
locK_149BA:
		bsr.w	Tails_JumpHeight
		bsr.w	Tails_InputAcceleration_Freespace
		bsr.w	Tails_Check_Screen_Boundaries
	if Sonic3_Alone
		jsr	(MoveSprite).l
	else
		jsr	(MoveSprite_TestGravity).l
	endif
		btst	#Status_Underwater,status(a0)
		beq.s	locK_149DA
		subi.w	#$28,y_vel(a0)
; loc3_155E6:
locK_149DA:
	if Sonic3_Alone
		bsr.w	Tails_JumpAngle
	else
		bsr.w	Player_JumpAngle
	endif
		bsr.w	Tails_DoLevelCollision
		rts

; =============== S U B R O U T I N E =======================================


Tails_InputAcceleration_Path:
		move.w	Max_speed_P2-Max_speed_P2(a4),d6
		move.w	Acceleration_P2-Max_speed_P2(a4),d5
		move.w	Deceleration_P2-Max_speed_P2(a4),d4
		tst.b	status_secondary(a0)
		bmi.w	locK_14B5C
		tst.w	move_lock(a0)
		bne.w	locK_14B14
		btst	#button_left,(Ctrl_2_held_logical).w
		beq.s	locK_14A0A
		bsr.w	subK_14C20
; loc3_15616:
locK_14A0A:
		btst	#button_right,(Ctrl_2_logical).w
		beq.s	locK_14A16
		bsr.w	subK_14CAC
; loc3_15622:
locK_14A16:
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.w	locK_14B14
		tst.w	ground_vel(a0)
		bne.w	locK_14B14
		bclr	#Status_Push,status(a0)
		move.b	#5,anim(a0)
		btst	#Status_OnObj,status(a0)
		beq.s	locK_14A6C
		movea.w	interact(a0),a1
		tst.b	status(a1)
		bmi.s	locK_14AA0
		moveq	#0,d1
		move.b	width_pixels(a1),d1
		move.w	d1,d2
		add.w	d2,d2
		subq.w	#4,d2
		add.w	x_pos(a0),d1
		sub.w	x_pos(a1),d1
		cmpi.w	#4,d1
		blt.s	locK_14A92
		cmp.w	d2,d1
		bge.s	locK_14A82
		bra.s	locK_14AA0
; ---------------------------------------------------------------------------
; loc3_15678:
locK_14A6C:
	if Sonic3_Alone
		jsr	(ChkFloorEdge).l
	else
		move.w	x_pos(a0),d3
		bsr.w	ChooseChkFloorEdge
	endif
		cmpi.w	#$C,d1
		blt.s	locK_14AA0
		cmpi.b	#3,next_tilt(a0)
		bne.s	locK_14A8A
; loc3_1568C:
locK_14A82:
		bclr	#Status_Facing,status(a0)
		bra.s	locK_14A98
; ---------------------------------------------------------------------------
; loc3_15694:
locK_14A8A:
		cmpi.b	#3,tilt(a0)
		bne.s	locK_14AA0
; loc3_1569C:
locK_14A92:
		bset	#Status_Facing,status(a0)
; loc3_156A2:
locK_14A98:
		move.b	#6,anim(a0)
		bra.s	locK_14B14
; ---------------------------------------------------------------------------
; loc3_156D4:
locK_14AA0:
	if Sonic3_Alone
		btst	#button_up,(Ctrl_2_held_logical).w
		beq.s	loc3_156D4
		move.b	#7,anim(a0)
		addq.b	#1,scroll_delay_counter(a0)
		cmpi.b	#2*60,scroll_delay_counter(a0)
		blo.s	locK_14B1A
		move.b	#2*60,scroll_delay_counter(a0)
		cmpi.w	#$C8,(a5)
		beq.s	locK_14B26
		addq.w	#2,(a5)
		bra.s	locK_14B26
; ---------------------------------------------------------------------------

loc3_156D4:
		btst	#button_down,(Ctrl_2_held_logical).w
		beq.s	locK_14B14
		move.b	#8,anim(a0)
		addq.b	#1,scroll_delay_counter(a0)
		cmpi.b	#2*60,scroll_delay_counter(a0)
		blo.s	locK_14B1A
		move.b	#2*60,scroll_delay_counter(a0)
		cmpi.w	#8,(a5)
		beq.s	locK_14B26
		subq.w	#2,(a5)
		bra.s	locK_14B26
	else
		btst	#button_down,(Ctrl_2_held_logical).w
		beq.s	locK_14ADA
		move.b	#8,anim(a0)
		addq.b	#1,scroll_delay_counter(a0)
		cmpi.b	#2*60,scroll_delay_counter(a0)
		blo.s	locK_14B1A
		move.b	#2*60,scroll_delay_counter(a0)
		tst.b	(Reverse_gravity_flag).w
		bne.s	locK_14AD0
		cmpi.w	#8,(a5)
		beq.s	locK_14B26
		subq.w	#2,(a5)
		bra.s	locK_14B26
; ---------------------------------------------------------------------------

locK_14AD0:
		cmpi.w	#$D8,(a5)
		beq.s	locK_14B26
		addq.w	#2,(a5)
		bra.s	locK_14B26
; ---------------------------------------------------------------------------

locK_14ADA:
		btst	#button_up,(Ctrl_2_logical).w
		beq.s	locK_14B14
		move.b	#7,anim(a0)
		addq.b	#1,scroll_delay_counter(a0)
		cmpi.b	#2*60,scroll_delay_counter(a0)
		blo.s	locK_14B1A
		move.b	#2*60,scroll_delay_counter(a0)
		tst.b	(Reverse_gravity_flag).w
		bne.s	locK_14B0A
		cmpi.w	#$C8,(a5)
		beq.s	locK_14B26
		addq.w	#2,(a5)
		bra.s	locK_14B26
; ---------------------------------------------------------------------------

locK_14B0A:
		cmpi.w	#$18,(a5)
		beq.s	locK_14B26
		subq.w	#2,(a5)
		bra.s	locK_14B26
	endif
; ---------------------------------------------------------------------------
; loc3_156FE:
locK_14B14:
		move.b	#0,scroll_delay_counter(a0)
; loc3_15704:
locK_14B1A:
		cmpi.w	#$60,(a5)
		beq.s	locK_14B26
		bcc.s	locK_14B24
		addq.w	#4,(a5)
; loc3_1570E:
locK_14B24:
		subq.w	#2,(a5)
; loc3_15710:
locK_14B26:
	if ~~Sonic3_Alone
		tst.b	(Super_Tails_flag).w
		beq.s	locK_14B30
		move.w	#$C,d5

locK_14B30:
	endif
		move.b	(Ctrl_2_held_logical).w,d0
		andi.b	#button_left_mask|button_right_mask,d0
		bne.s	locK_14B5C
		move.w	ground_vel(a0),d0
		beq.s	locK_14B5C
		bmi.s	locK_14B50
		sub.w	d5,d0
		bcc.s	locK_14B4A
		move.w	#0,d0
; loc3_1572A:
locK_14B4A:
		move.w	d0,ground_vel(a0)
		bra.s	locK_14B5C
; ---------------------------------------------------------------------------
; loc3_15730:
locK_14B50:
		add.w	d5,d0
		bcc.s	locK_14B58
		move.w	#0,d0
; loc3_15738:
locK_14B58:
		move.w	d0,ground_vel(a0)
; loc3_1573C:
locK_14B5C:
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	ground_vel(a0),d1
		asr.l	#8,d1
		move.w	d1,x_vel(a0)
		muls.w	ground_vel(a0),d0
		asr.l	#8,d0
		move.w	d0,y_vel(a0)
; loc3_1575A:
locK_14B7A:
		btst	#6,object_control(a0)
		bne.w	locretK_14C1E
	if ~~Sonic3_Alone
		move.b	angle(a0),d0
		andi.b	#$3F,d0
		beq.s	locK_14B9A
	endif
		move.b	angle(a0),d0
		addi.b	#$40,d0
	if Sonic3_Alone
		bmi.s	locretK_14C1E
	else
		bmi.w	locretK_14C1E

locK_14B9A:
	endif
		move.b	#$40,d1
		tst.w	ground_vel(a0)
		beq.s	locretK_14C1E
		bmi.s	locK_14BA8
		neg.w	d1
; loc3_1577C:
locK_14BA8:
		move.b	angle(a0),d0
		add.b	d1,d0
		move.w	d0,-(sp)
	if Sonic3_Alone
		bsr.w	sub_10980
	else
		bsr.w	sub_F61C
	endif
		move.w	(sp)+,d0
		tst.w	d1
		bpl.s	locretK_14C1E
		asl.w	#8,d1
	if ~~Sonic3_Alone
		cmpi.b	#8,(Current_zone).w
		bne.s	locK_14BCA
		tst.b	d0
		bpl.s	locK_14BCA
		subq.b	#1,d0

locK_14BCA:
	endif
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	locK_14C1A
		cmpi.b	#$40,d0
		beq.s	locK_14C00
		cmpi.b	#$80,d0
		beq.s	locK_14BFA
		add.w	d1,x_vel(a0)
		move.w	#0,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		bne.s	locretK_14BF8
		bset	#Status_Push,status(a0)
; locret3_157BE:
locretK_14BF8:
		rts
; ---------------------------------------------------------------------------
; loc3_157C0:
locK_14BFA:
		sub.w	d1,y_vel(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_157C6:
locK_14C00:
		sub.w	d1,x_vel(a0)
		move.w	#0,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		beq.s	locretK_14BF8
		bset	#Status_Push,status(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_157E0:
locK_14C1A:
		add.w	d1,y_vel(a0)
; locret3_157E4:
locretK_14C1E:
		rts
; End of function Tails_InputAcceleration_Path


; =============== S U B R O U T I N E =======================================

; sub3_157E6:
subK_14C20:
		move.w	ground_vel(a0),d0
		beq.s	locK_14C28
		bpl.s	locK_14C5A
; loc3_157EE:
locK_14C28:
		bset	#Status_Facing,status(a0)
		bne.s	locK_14C3C
		bclr	#Status_Push,status(a0)
		move.b	#1,prev_anim(a0)
; loc3_15802:
locK_14C3C:
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	locK_14C4E
		add.w	d5,d0
		cmp.w	d1,d0
		ble.s	locK_14C4E
		move.w	d1,d0
; loc3_15814:
locK_14C4E:
		move.w	d0,ground_vel(a0)
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_15820:
locK_14C5A:
		sub.w	d4,d0
		bcc.s	locK_14C62
		move.w	#-$80,d0
; loc3_15828:
locK_14C62:
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
		bne.s	locretK_14CAA
		cmpi.w	#$400,d0
		blt.s	locretK_14CAA
		tst.b	flip_type(a0)
		bmi.s	locretK_14CAA
		move.w	#sfx_Skid,d0
		jsr	(Play_SFX).l
		move.b	#$D,anim(a0)
		bclr	#Status_Facing,status(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	locretK_14CAA
		move.b	#6,routine(a6)
		move.b	#$15,mapping_frame(a6)
; locret3_15870:
locretK_14CAA:
		rts
; End of function subK_14C20


; =============== S U B R O U T I N E =======================================

; sub3_15872:
subK_14CAC:
		move.w	ground_vel(a0),d0
		bmi.s	locK_14CE0
		bclr	#Status_Facing,status(a0)
		beq.s	locK_14CC6
		bclr	#Status_Push,status(a0)
		move.b	#1,prev_anim(a0)
; loc3_1588C:
locK_14CC6:
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	locK_14CD4
		sub.w	d5,d0
		cmp.w	d6,d0
		bge.s	locK_14CD4
		move.w	d6,d0
; loc3_1589A:
locK_14CD4:
		move.w	d0,ground_vel(a0)
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_158A6:
locK_14CE0:
		add.w	d4,d0
		bcc.s	locK_14CE8
		move.w	#$80,d0
; loc3_158AE:
locK_14CE8:
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
		bne.s	locretK_14D30
		cmpi.w	#-$400,d0
		bgt.s	locretK_14D30
		tst.b	flip_type(a0)
		bmi.s	locretK_14D30
		move.w	#sfx_Skid,d0
		jsr	(Play_SFX).l
		move.b	#$D,anim(a0)
		bset	#Status_Facing,status(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	locretK_14D30
		move.b	#6,routine(a6)
		move.b	#$15,mapping_frame(a6)
; locret3_158F6:
locretK_14D30:
		rts
; End of function subK_14CAC


; =============== S U B R O U T I N E =======================================


Tails_RollSpeed:
		move.w	Max_speed_P2-Max_speed_P2(a4),d6
		asl.w	#1,d6
		move.w	Acceleration_P2-Max_speed_P2(a4),d5
		asr.w	#1,d5
	if Sonic3_Alone
		; This was how Sonic 1 handled rolling deceleration. It was changed in Sonic 2
		; due to it causing Sonic to decelerate very slowly when underwater, but they
		; forgot to update it for Tails. Whoops.
		move.w	Deceleration_P2-Max_speed_P2(a4),d4
		asr.w	#2,d4
	else
		tst.b	(Super_Tails_flag).w
		beq.s	locK_14D46
		move.w	#6,d5

locK_14D46:
		move.w	#$20,d4
	endif
		tst.b	spin_dash_flag(a0)
		bmi.w	locK_14DF0
		tst.b	status_secondary(a0)
		bmi.w	locK_14DF0
		tst.w	move_lock(a0)
		bne.s	locK_14D78
		btst	#button_left,(Ctrl_2_held_logical).w
		beq.s	locK_14D6C
		bsr.w	subK_14E32
; loc3_1592A:
locK_14D6C:
		btst	#button_right,(Ctrl_2_held_logical).w
		beq.s	locK_14D78
		bsr.w	subK_14E56
; loc3_15936:
locK_14D78:
		move.w	ground_vel(a0),d0
		beq.s	locK_14D9A
		bmi.s	locK_14D8E
		sub.w	d5,d0
		bcc.s	locK_14D88
		move.w	#0,d0
; loc3_15946:
locK_14D88:
		move.w	d0,ground_vel(a0)
		bra.s	locK_14D9A
; ---------------------------------------------------------------------------
; loc3_1594C:
locK_14D8E:
		add.w	d5,d0
		bcc.s	locK_14D96
		move.w	#0,d0
; loc3_15954:
locK_14D96:
		move.w	d0,ground_vel(a0)
; loc3_15958:
locK_14D9A:
	if Sonic3_Alone
		tst.w	ground_vel(a0)
		bne.s	locK_14DF0
	else
		move.w	ground_vel(a0),d0
		bpl.s	locK_14DA2
		neg.w	d0

locK_14DA2:
		cmpi.w	#$80,d0
		bhs.s	locK_14DF0
	endif
		tst.b	spin_dash_flag(a0)
		bne.s	locK_14DDE
		bclr	#Status_Roll,status(a0)
		move.b	y_radius(a0),d0
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
		move.b	#5,anim(a0)
		sub.b	default_y_radius(a0),d0
		ext.w	d0
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_14DD8
		neg.w	d0

locK_14DD8:
	endif
		add.w	d0,y_pos(a0)
		bra.s	locK_14DF0
; ---------------------------------------------------------------------------
; loc3_1598C:
locK_14DDE:
		move.w	#$400,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		beq.s	locK_14DF0
		neg.w	ground_vel(a0)
; loc3_1599E:
locK_14DF0:
		cmpi.w	#$60,(a5)
		beq.s	locK_14DFC
		bcc.s	locK_14DFA
		addq.w	#4,(a5)
; loc3_159A8:
locK_14DFA:
		subq.w	#2,(a5)
; loc3_159AA:
locK_14DFC:
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	ground_vel(a0),d0
		asr.l	#8,d0
		move.w	d0,y_vel(a0)
		muls.w	ground_vel(a0),d1
		asr.l	#8,d1
		cmpi.w	#$1000,d1
		ble.s	locK_14E20
		move.w	#$1000,d1
; loc3_159CE:
locK_14E20:
		cmpi.w	#-$1000,d1
		bge.s	locK_14E2A
		move.w	#-$1000,d1
; loc3_159D8:
locK_14E2A:
		move.w	d1,x_vel(a0)
		bra.w	locK_14B7A
; End of function Tails_RollSpeed


; =============== S U B R O U T I N E =======================================

; sub3_159E0:
subK_14E32:
		move.w	ground_vel(a0),d0
		beq.s	locK_14E3A
		bpl.s	locK_14E48
; loc3_159E8:
locK_14E3A:
		bset	#Status_Facing,status(a0)
		move.b	#2,anim(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_159F6:
locK_14E48:
		sub.w	d4,d0
		bcc.s	locK_14E50
		move.w	#-$80,d0
; loc3_159FE:
locK_14E50:
		move.w	d0,ground_vel(a0)
		rts
; End of function subK_14E32


; =============== S U B R O U T I N E =======================================

; sub3_15A04:
subK_14E56:
		move.w	ground_vel(a0),d0
		bmi.s	locK_14E6A
		bclr	#Status_Facing,status(a0)
		move.b	#2,anim(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_15A18:
locK_14E6A:
		add.w	d4,d0
		bcc.s	locK_14E72
		move.w	#$80,d0
; loc3_15A20:
locK_14E72:
		move.w	d0,ground_vel(a0)
		rts
; End of function subK_14E56


; =============== S U B R O U T I N E =======================================


Tails_InputAcceleration_Freespace:
		move.w	Max_speed_P2-Max_speed_P2(a4),d6
		move.w	Acceleration_P2-Max_speed_P2(a4),d5
		asl.w	#1,d5
		btst	#Status_RollJump,status(a0)
		bne.s	locK_14ECC
		move.w	x_vel(a0),d0
		btst	#button_left,(Ctrl_2_held_logical).w
		beq.s	locK_14EAC
		bset	#Status_Facing,status(a0)
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	locK_14EAC
		add.w	d5,d0
		cmp.w	d1,d0
		ble.s	locK_14EAC
		move.w	d1,d0
; loc3_15A5A:
locK_14EAC:
		btst	#button_right,(Ctrl_2_held_logical).w
		beq.s	locK_14EC8
		bclr	#Status_Facing,status(a0)
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	locK_14EC8
		sub.w	d5,d0
		cmp.w	d6,d0
		bge.s	locK_14EC8
		move.w	d6,d0
; loc3_15A76:
locK_14EC8:
		move.w	d0,x_vel(a0)
; loc3_15A7A:
locK_14ECC:
		cmpi.w	#$60,(a5)
		beq.s	locK_14ED8
		bcc.s	locK_14ED6
		addq.w	#4,(a5)
; loc3_15A84:
locK_14ED6:
		subq.w	#2,(a5)
; loc3_15A86:
locK_14ED8:
		cmpi.w	#-$400,y_vel(a0)
		blo.s	locretK_14F06
		move.w	x_vel(a0),d0
		move.w	d0,d1
		asr.w	#5,d1
		beq.s	locretK_14F06
		bmi.s	locK_14EFA
		sub.w	d1,d0
		bcc.s	locK_14EF4
		move.w	#0,d0
; loc3_15AA2:
locK_14EF4:
		move.w	d0,x_vel(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_15AA8:
locK_14EFA:
		sub.w	d1,d0
		bcs.s	locK_14F02
		move.w	#0,d0
; loc3_15AB0:
locK_14F02:
		move.w	d0,x_vel(a0)
; loc3_15AB4:
locretK_14F06:
		rts
; End of function Tails_InputAcceleration_Freespace


; =============== S U B R O U T I N E =======================================


Tails_Check_Screen_Boundaries:
		move.l	x_pos(a0),d1
		move.w	x_vel(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d1
		swap	d1
		move.w	(Camera_min_X_pos).w,d0
		addi.w	#$10,d0
		cmp.w	d1,d0
		bhi.s	locK_14F5C
		move.w	(Camera_max_X_pos).w,d0
		addi.w	#$128,d0
		cmp.w	d1,d0
	if Sonic3_Alone
		bls.s	locK_14F5C
	else
		blo.s	locK_14F5C
	endif
; loc3_15ADE:
locK_14F30:
		tst.b	(Disable_death_plane).w
		bne.s	locretK_14F4A
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		bne.s	locK_14F4C
	endif
		move.w	(Camera_max_Y_pos).w,d0
		addi.w	#$E0,d0
		cmp.w	y_pos(a0),d0
		blt.s	locK_14F56
; locret3_15AF2:
locretK_14F4A:
		rts
; ---------------------------------------------------------------------------
	if ~~Sonic3_Alone
locK_14F4C:
		move.w	(Camera_min_Y_pos).w,d0
		cmp.w	y_pos(a0),d0
		blt.s	locretK_14F4A
	endif
; loc3_15AF4:
locK_14F56:
		jmp	(Kill_Character).l
; ---------------------------------------------------------------------------
; loc3_15AFA:
locK_14F5C:
		move.w	d0,x_pos(a0)
		move.w	#0,2+x_pos(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,ground_vel(a0)
		bra.s	locK_14F30
; End of function Tails_Check_Screen_Boundaries


; =============== S U B R O U T I N E =======================================


Tails_Roll:
		tst.b	status_secondary(a0)
		bmi.s	locretK_14FA8
	if Sonic3_Alone
		move.w	ground_vel(a0),d0
		bpl.s	loc3_15B20
		neg.w	d0

loc3_15B20:
		cmpi.w	#$80,d0
		bcs.s	locretK_14FA8
	endif
		move.b	(Ctrl_2_held_logical).w,d0
		andi.b	#button_left_mask|button_right_mask,d0
		bne.s	locretK_14FA8
		btst	#button_down,(Ctrl_2_held_logical).w
	if Sonic3_Alone
		bne.s	locK_14FBA
	else
		beq.s	locK_14FAA
		move.w	ground_vel(a0),d0
		bpl.s	locK_14F94
		neg.w	d0

locK_14F94:
		cmpi.w	#$100,d0
		bhs.s	locK_14FBA
		btst	#Status_OnObj,status(a0)
		bne.s	locretK_14FA8
		move.b	#8,anim(a0)
	endif
; locret3_15B38:
locretK_14FA8:
		rts
; ---------------------------------------------------------------------------
	if ~~Sonic3_Alone
locK_14FAA:
		cmpi.b	#8,anim(a0)
		bne.s	locretK_14FA8
		move.b	#0,anim(a0)
		rts
	endif
; ---------------------------------------------------------------------------
; loc3_15B3A:
locK_14FBA:
		btst	#Status_Roll,status(a0)
		beq.s	locK_14FC4
		rts
; ---------------------------------------------------------------------------
; loc3_15B44:
locK_14FC4:
		bset	#Status_Roll,status(a0)
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#1,y_pos(a0)
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_14FEA
		subq.w	#2,y_pos(a0)

locK_14FEA:
	endif
		move.w	#sfx_Roll,d0
		jsr	(Play_SFX).l
		tst.w	ground_vel(a0)
		bne.s	locretK_15000
		move.w	#$200,ground_vel(a0)
; locret3_15B76:
locretK_15000:
		rts
; End of function Tails_Roll


; =============== S U B R O U T I N E =======================================


Tails_Jump:
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locretK_150D0
		moveq	#0,d0
		move.b	angle(a0),d0
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_15024
		addi.b	#$40,d0
		neg.b	d0
		subi.b	#$40,d0

locK_15024:
	endif
		addi.b	#$80,d0
		movem.l	a4-a6,-(sp)
		bsr.w	CalcRoomOverHead
		movem.l	(sp)+,a4-a6
		cmpi.w	#6,d1
		blt.w	locretK_150D0
		move.w	#$680,d2
		btst	#Status_Underwater,status(a0)
		beq.s	locK_1504C
		move.w	#$380,d2
; loc3_15BB2:
locK_1504C:
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
		bne.s	locK_150D2
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)
		bset	#Status_Roll,status(a0)
		move.b	y_radius(a0),d0
		sub.b	default_y_radius(a0),d0
		ext.w	d0
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_150CC
		neg.w	d0

locK_150CC:
	endif
		sub.w	d0,y_pos(a0)
; loc3_15C2E:
locretK_150D0:
		rts
; ---------------------------------------------------------------------------
; loc3_15C30:
locK_150D2:
		bset	#Status_RollJump,status(a0)
		rts
; End of function Tails_Jump


; =============== S U B R O U T I N E =======================================


Tails_JumpHeight:
		tst.b	jumping(a0)
		beq.s	locK_15106
		move.w	#-$400,d1
		btst	#Status_Underwater,status(a0)
		beq.s	locK_150F0
		move.w	#-$200,d1
; loc3_15C4E:
locK_150F0:
		cmp.w	y_vel(a0),d1
		ble.s	Tails_Test_For_Flight
		move.b	(Ctrl_2_held_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		bne.s	locretK_15104
		move.w	d1,y_vel(a0)
; locret3_15C62:
locretK_15104:
		rts
; ---------------------------------------------------------------------------
; loc3_15C64:
locK_15106:
		tst.b	spin_dash_flag(a0)
		bne.s	locretK_1511A
		cmpi.w	#-$FC0,y_vel(a0)
		bge.s	locretK_1511A
		move.w	#-$FC0,y_vel(a0)
; locret3_15C78:
locretK_1511A:
		rts
; ---------------------------------------------------------------------------

Tails_Test_For_Flight:
		tst.b	double_jump_flag(a0)
		bne.w	locretK_151A2
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locretK_151A2
		cmpi.w	#2,(Player_mode).w
	if Sonic3_Alone
		beq.s	locK_1515C
	else
		bne.s	locK_15156
		tst.b	(Super_Tails_flag).w
		bne.s	locK_1515C
		cmpi.b	#7,(Super_emerald_count).w
		blo.s	locK_1515C
		cmpi.w	#50,(Ring_count).w
		blo.s	locK_1515C
		tst.b	(Update_HUD_timer).w
		bne.s	Tails_Transform
		bra.s	locK_1515C
; ---------------------------------------------------------------------------

locK_15156:
	endif
		tst.w	(Tails_CPU_idle_timer).w
		beq.s	locretK_151A2
; loc3_15C9C:
locK_1515C:
		btst	#Status_Roll,status(a0)
		beq.s	locK_1518C
		bclr	#Status_Roll,status(a0)
		move.b	y_radius(a0),d1
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
		sub.b	default_y_radius(a0),d1
		ext.w	d1
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_15188
		neg.w	d0

locK_15188:
	endif
		add.w	d1,y_pos(a0)
; loc3_15CC4:
locK_1518C:
		bclr	#Status_RollJump,status(a0)
		move.b	#1,double_jump_flag(a0)
		move.b	#(8*60)/2,double_jump_property(a0)
		bsr.w	Tails_Set_Flying_Animation
; locret3_15CDA:
locretK_151A2:
		rts
; ---------------------------------------------------------------------------
	if ~~Sonic3_Alone
Tails_Transform:
		move.b	#1,(Super_palette_status).w	; set Super/Hyper palette status to 'fading'
		move.b	#$F,(Palette_timer).w
		move.b	#1,(Super_Tails_flag).w			; set flag to Super Tails
		move.w	#60,(Super_frame_count).w
		move.b	#$81,object_control(a0)
		move.b	#$29,anim(a0)				; enter 'transformation' animation
		move.l	#Obj_SuperTailsBirds,(Invincibility_stars).w	; load Super Flickies object
		move.w	#$800,Max_speed_P2-Max_speed_P2(a4)
		move.w	#$18,Acceleration_P2-Max_speed_P2(a4)
		move.w	#$C0,Deceleration_P2-Max_speed_P2(a4)
		move.b	#0,invincibility_timer(a0)
		bset	#Status_Invincible,status_secondary(a0)
		moveq	#signextendB(sfx_SuperTransform),d0
		jsr	(Play_SFX).l
		moveq	#signextendB(mus_Invincibility),d0		; play invincibility theme
		jmp	(Play_Music).l
	endif
; End of function Tails_JumpHeight


; =============== S U B R O U T I N E =======================================


Tails_Spindash:
		tst.b	spin_dash_flag(a0)
		bne.s	locK_1527C
		cmpi.b	#8,anim(a0)
		bne.s	locretK_1527A
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locretK_1527A
		move.b	#9,anim(a0)
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addq.l	#4,sp
		move.b	#1,spin_dash_flag(a0)
		move.w	#0,spin_dash_counter(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	locK_15242
		move.b	#2,anim(a6)
; loc3_15D22:
locK_15242:
		bsr.w	Tails_Check_Screen_Boundaries
	if Sonic3_Alone
		bsr.w	Player_AnglePos
	else
		bsr.w	Call_Player_AnglePos
	endif
		tst.b	(Background_collision_flag).w
		beq.s	locretK_1527A
	if Sonic3_Alone
		bsr.w	sub_10BA2
	else
		bsr.w	sub_F846
	endif
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
	if Sonic3_Alone
		movem.l	(sp)+,a4-a6
	endif
		tst.w	d1
		bpl.s	locK_1526A
		sub.w	d1,x_pos(a0)

locK_1526A:
	if ~~Sonic3_Alone
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locK_15276
		add.w	d1,x_pos(a0)

locK_15276:
		movem.l	(sp)+,a4-a6
	endif
; locret3_15D4E:
locretK_1527A:
		rts
; ---------------------------------------------------------------------------
; loc3_15D50:
locK_1527C:
		move.b	(Ctrl_2_held_logical).w,d0
		btst	#button_down,d0
		bne.w	locK_15332
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#1,y_pos(a0)
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_152A8
		subq.w	#2,y_pos(a0)

locK_152A8:
	endif
		move.b	#0,spin_dash_flag(a0)
		moveq	#0,d0
		move.b	spin_dash_counter(a0),d0
		add.w	d0,d0
		move.w	wordK_1530E(pc,d0.w),ground_vel(a0)
	if ~~Sonic3_Alone
		tst.b	(Super_Tails_flag).w
		beq.s	locK_152C8
		move.w	wordK_15320(pc,d0.w),ground_vel(a0)

locK_152C8:
	endif
		move.w	ground_vel(a0),d0
		subi.w	#$800,d0
		add.w	d0,d0
		andi.w	#$1F00,d0
		neg.w	d0
		addi.w	#$2000,d0
		lea	(H_scroll_frame_offset).w,a1
		cmpa.w	#Player_1,a0
		beq.s	locK_152EA
		lea	(H_scroll_frame_offset_P2).w,a1
; loc3_15DA8:
locK_152EA:
		move.w	d0,(a1)
		btst	#Status_Facing,status(a0)
		beq.s	locK_152F8
		neg.w	ground_vel(a0)
; loc3_15DB6:
locK_152F8:
		bset	#Status_Roll,status(a0)
		move.b	#0,anim(a6)
	if Sonic3_Alone
		move.w	#signextendB(sfx_Dash),d0
	else
		moveq	#signextendB(sfx_Dash),d0
	endif
		jsr	(Play_SFX).l
		bra.s	locK_1537A
; ---------------------------------------------------------------------------
; word3_15DCE:
wordK_1530E:
		dc.w   $800
		dc.w   $880
		dc.w   $900
		dc.w   $980
		dc.w   $A00
		dc.w   $A80
		dc.w   $B00
		dc.w   $B80
		dc.w   $C00
	if ~~Sonic3_Alone
wordK_15320:
		dc.w   $A00
		dc.w   $A80
		dc.w   $B00
		dc.w   $B80
		dc.w   $C00
		dc.w   $C80
		dc.w   $D00
		dc.w   $D80
		dc.w   $E00
	endif
; ---------------------------------------------------------------------------
; loc3_15DE0:
locK_15332:
		tst.w	spin_dash_counter(a0)
		beq.s	locK_1534A
		move.w	spin_dash_counter(a0),d0
		lsr.w	#5,d0
		sub.w	d0,spin_dash_counter(a0)
		bcc.s	locK_1534A
		move.w	#0,spin_dash_counter(a0)
; loc3_15DF8:
locK_1534A:
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locK_1537A
		move.w	#9<<8,anim(a0)	; and prev_anim
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addi.w	#$200,spin_dash_counter(a0)
		cmpi.w	#$800,spin_dash_counter(a0)
		blo.s	locK_1537A
		move.w	#$800,spin_dash_counter(a0)
; loc3_15E28:
locK_1537A:
		addq.l	#4,sp
		cmpi.w	#$60,(a5)
		beq.s	locK_15388
		bcc.s	locK_15386
		addq.w	#4,(a5)
; loc3_15E34:
locK_15386:
		subq.w	#2,(a5)
; loc3_15E36:
locK_15388:
		bsr.w	Tails_Check_Screen_Boundaries
	if Sonic3_Alone
		bsr.w	Player_AnglePos
	else
		bsr.w	Call_Player_AnglePos
	endif
		tst.b	(Background_collision_flag).w
		beq.s	locretK_153C0
	if Sonic3_Alone
		bsr.w	sub_10BA2
	else
		bsr.w	sub_F846
	endif
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
	if Sonic3_Alone
		movem.l	(sp)+,a4-a6
	endif
		tst.w	d1
		bpl.s	locK_153B0
		sub.w	d1,x_pos(a0)

locK_153B0:
	if ~~Sonic3_Alone
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locK_153BC
		add.w	d1,x_pos(a0)

locK_153BC:
		movem.l	(sp)+,a4-a6
	endif
; locret3_15E62:
locretK_153C0:
		rts
; End of function Tails_Spindash


; =============== S U B R O U T I N E =======================================

	if Sonic3_Alone
Tails_SlopeResist:
		move.b	angle(a0),d0
		addi.b	#$60,d0
		cmpi.b	#-$40,d0
		bcc.s	locret3_15E98
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	#$20,d0
		asr.l	#8,d0
		tst.w	ground_vel(a0)
		beq.s	locret3_15E98
		bmi.s	loc3_15E94
		tst.w	d0
		beq.s	locret3_15E92
		add.w	d0,ground_vel(a0)

locret3_15E92:
		rts
; ---------------------------------------------------------------------------

loc3_15E94:
		add.w	d0,ground_vel(a0)

locret3_15E98:
		rts
; End of function Tails_SlopeResist


; =============== S U B R O U T I N E =======================================


Tails_RollRepel:
		move.b	angle(a0),d0
		addi.b	#$60,d0
		cmpi.b	#-$40,d0
		bcc.s	locret3_15ED4
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	#$50,d0
		asr.l	#8,d0
		tst.w	ground_vel(a0)
		bmi.s	loc3_15ECA
		tst.w	d0
		bpl.s	loc3_15EC4
		asr.l	#2,d0

loc3_15EC4:
		add.w	d0,ground_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc3_15ECA:
		tst.w	d0
		bmi.s	loc3_15ED0
		asr.l	#2,d0

loc3_15ED0:
		add.w	d0,ground_vel(a0)

locret3_15ED4:
		rts
; End of function Tails_RollRepel


; =============== S U B R O U T I N E =======================================


Tails_SlopeRepel:
		nop
		tst.b	stick_to_convex(a0)
		bne.s	locret3_15F10
		tst.w	move_lock(a0)
		bne.s	loc3_15F12
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	locret3_15F10
		move.w	ground_vel(a0),d0
		bpl.s	loc3_15EFA
		neg.w	d0

loc3_15EFA:
		cmpi.w	#$280,d0
		bcc.s	locret3_15F10
		clr.w	ground_vel(a0)
		bset	#Status_InAir,status(a0)
		move.w	#30,move_lock(a0)

locret3_15F10:
		rts
; ---------------------------------------------------------------------------

loc3_15F12:
		subq.w	#1,move_lock(a0)
		rts
; End of function Tails_SlopeRepel


; =============== S U B R O U T I N E =======================================


Tails_JumpAngle:
		move.b	angle(a0),d0
		beq.s	loc3_15F32
		bpl.s	loc3_15F28
		addq.b	#2,d0
		bcc.s	loc3_15F26
		moveq	#0,d0

loc3_15F26:
		bra.s	loc3_15F2E
; ---------------------------------------------------------------------------

loc3_15F28:
		subq.b	#2,d0
		bcc.s	loc3_15F2E
		moveq	#0,d0

loc3_15F2E:
		move.b	d0,angle(a0)

loc3_15F32:
		move.b	flip_angle(a0),d0
		beq.s	locret3_15F76
		tst.w	ground_vel(a0)
		bmi.s	loc3_15F56

loc3_15F3E:
		move.b	flip_speed(a0),d1
		add.b	d1,d0
		bcc.s	loc3_15F54
		subq.b	#1,flips_remaining(a0)
		bcc.s	loc3_15F54
		move.b	#0,flips_remaining(a0)
		moveq	#0,d0

loc3_15F54:
		bra.s	loc3_15F72
; ---------------------------------------------------------------------------

loc3_15F56:
		tst.b	flip_type(a0)
		bmi.s	loc3_15F3E
		move.b	flip_speed(a0),d1
		sub.b	d1,d0
		bcc.s	loc3_15F72
		subq.b	#1,flips_remaining(a0)
		bcc.s	loc3_15F72
		move.b	#0,flips_remaining(a0)
		moveq	#0,d0

loc3_15F72:
		move.b	d0,flip_angle(a0)

locret3_15F76:
		rts
; End of function Tails_JumpAngle
	endif

; =============== S U B R O U T I N E =======================================


Tails_DoLevelCollision:
		move.l	(Primary_collision_addr).w,(Collision_addr).w
		cmpi.b	#$C,top_solid_bit(a0)
		beq.s	locK_153D6
		move.l	(Secondary_collision_addr).w,(Collision_addr).w
; loc3_15F8C:
locK_153D6:
		move.b	lrb_solid_bit(a0),d5
		move.w	x_vel(a0),d1
		move.w	y_vel(a0),d2
		jsr	(GetArcTan).l
		subi.b	#$20,d0
		andi.b	#$C0,d0
		cmpi.b	#$40,d0
		beq.w	locK_154AC
		cmpi.b	#$80,d0
		beq.w	locK_15538
		cmpi.b	#$C0,d0
		beq.w	locK_1559C
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	locK_1541A
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
; loc3_15FD0:
locK_1541A:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locK_1542C
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
; loc3_15FE2:
locK_1542C:
	if Sonic3_Alone
		bsr.w	Sonic_CheckFloor
	else
		bsr.w	subK_11FD6
	endif
		tst.w	d1
		bpl.s	locretK_154AA
		move.b	y_vel(a0),d2
		addq.b	#8,d2
		neg.b	d2
		cmp.b	d2,d1
		bge.s	locK_15444
		cmp.b	d2,d0
		blt.s	locretK_154AA
; loc3_15FFA:
locK_15444:
	if Sonic3_Alone
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
	else
		move.b	d3,angle(a0)
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_15450
		neg.w	d1

locK_15450:
		add.w	d1,y_pos(a0)
	endif
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	locK_15484
		move.b	d3,d0
		addi.b	#$10,d0
		andi.b	#$20,d0
		beq.s	locK_15472
		asr	y_vel(a0)
		bra.s	locK_15498
; ---------------------------------------------------------------------------
; loc3_16020:
locK_15472:
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)
		bsr.w	Tails_TouchFloor_Check_Spindash
		rts
; ---------------------------------------------------------------------------
; loc3_16032:
locK_15484:
		move.w	#0,x_vel(a0)
		cmpi.w	#$FC0,y_vel(a0)
		ble.s	locK_15498
		move.w	#$FC0,y_vel(a0)
; loc3_16046:
locK_15498:
		bsr.w	Tails_TouchFloor_Check_Spindash
		move.w	y_vel(a0),ground_vel(a0)
		tst.b	d3
		bpl.s	locretK_154AA
		neg.w	ground_vel(a0)
; locret3_16058:
locretK_154AA:
		rts
; ---------------------------------------------------------------------------
; loc3_1605A:
locK_154AC:
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	locK_154C4
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
		move.w	y_vel(a0),ground_vel(a0)
; loc3_16072:
locK_154C4:
	if Sonic3_Alone
		bsr.w	Sonic_CheckCeiling
	else
		bsr.w	subK_11FEE
	endif
		tst.w	d1
		bpl.s	locK_15502
		neg.w	d1
		cmpi.w	#$14,d1
		bhs.s	locK_154EE
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_154DC
		neg.w	d1

locK_154DC:
	endif
		add.w	d1,y_pos(a0)
		tst.w	y_vel(a0)
		bpl.s	locretK_154EC
		move.w	#0,y_vel(a0)
; lcoret3_16092:
locretK_154EC:
		rts
; ---------------------------------------------------------------------------
; loc3_16094:
locK_154EE:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locretK_15500
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
; locret3_160A6:
locretK_15500:
		rts
; ---------------------------------------------------------------------------
; loc3_160A8:
locK_15502:
		tst.b	(WindTunnel_flag_P2).w
		bne.s	locK_1550E
		tst.w	y_vel(a0)
		bmi.s	locretK_15536
; loc3_160B4:
locK_1550E:
	if Sonic3_Alone
		bsr.w	Sonic_CheckFloor
	else
		bsr.w	subK_11FD6
	endif
		tst.w	d1
		bpl.s	locretK_15536
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_1551E
		neg.w	d1

locK_1551E:
	endif
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)
		bsr.w	Tails_TouchFloor_Check_Spindash
; locret3_160D4:
locretK_15536:
		rts
; ---------------------------------------------------------------------------
; loc3_160D6:
locK_15538:
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	locK_1554A
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
; loc3_160E8:
locK_1554A:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locK_1555C
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
; loc3_160FA:
locK_1555C:
	if Sonic3_Alone
		bsr.w	Sonic_CheckCeiling
	else
		bsr.w	subK_11FEE
	endif
		tst.w	d1
		bpl.s	locretK_1559A
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_1556C
		neg.w	d1

locK_1556C:
	endif
		sub.w	d1,y_pos(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	locK_15584
		move.w	#0,y_vel(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_1611A:
locK_15584:
		move.b	d3,angle(a0)
		bsr.w	Tails_TouchFloor_Check_Spindash
		move.w	y_vel(a0),ground_vel(a0)
		tst.b	d3
		bpl.s	locretK_1559A
		neg.w	ground_vel(a0)
; locret3_16130:
locretK_1559A:
		rts
; ---------------------------------------------------------------------------
; loc3_16132:
locK_1559C:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locK_155B4
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
		move.w	y_vel(a0),ground_vel(a0)
; loc3_1614A:
locK_155B4:
	if Sonic3_Alone
		bsr.w	Sonic_CheckCeiling
	else
		bsr.w	subK_11FEE
	endif
		tst.w	d1
		bpl.s	locK_155D6
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_155C4
		neg.w	d1

locK_155C4:
	endif
		sub.w	d1,y_pos(a0)
		tst.w	y_vel(a0)
		bpl.s	locretK_155D4
		move.w	#0,y_vel(a0)
; locret3_16162:
locretK_155D4:
		rts
; ---------------------------------------------------------------------------
; loc3_16164:
locK_155D6:
		tst.b	(WindTunnel_flag_P2).w
		bne.s	locK_155E2
		tst.w	y_vel(a0)
		bmi.s	locretK_1560A
; loc3_16170:
locK_155E2:
	if Sonic3_Alone
		bsr.w	Sonic_CheckFloor
	else
		bsr.w	subK_11FD6
	endif
		tst.w	d1
		bpl.s	locretK_1560A
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_155F2
		neg.w	d1

locK_155F2:
	endif
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)
		bsr.w	Tails_TouchFloor_Check_Spindash
; locret3_16190:
locretK_1560A:
		rts
; End of function Tails_DoLevelCollision


; =============== S U B R O U T I N E =======================================


Tails_TouchFloor_Check_Spindash:
		tst.b	spin_dash_flag(a0)
		bne.s	locK_1565E
		move.b	#0,anim(a0)
; End of function Tails_TouchFloor_Check_Spindash


; =============== S U B R O U T I N E =======================================


Tails_TouchFloor:
		move.b	y_radius(a0),d0
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
		btst	#Status_Roll,status(a0)
		beq.s	locK_1565E
		bclr	#Status_Roll,status(a0)
		move.b	#0,anim(a0)
		sub.b	default_y_radius(a0),d0
		ext.w	d0
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_1564A
		neg.w	d0

locK_1564A:
		move.w	d0,-(sp)
		move.b	angle(a0),d0
		addi.b	#$40,d0
		bpl.s	locK_15658
		neg.w	(sp)

locK_15658:
		move.w	(sp)+,d0
	endif
		add.w	d0,y_pos(a0)
; loc3_161CC:
locK_1565E:
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
		rts
; End of function Tails_TouchFloor

; ---------------------------------------------------------------------------
; loc3_1620A:
locK_1569C:
	if ~~Sonic3_Alone
		cmpi.w	#2,(Player_mode).w
		bne.s	locK_156BE
		tst.w	(Debug_mode_flag).w
		beq.s	locK_156BE
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	locK_156BE
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------

locK_156BE:
	endif
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	locK_156D6
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#Status_InAir,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w
; loc3_16222:
locK_156D6:
	if Sonic3_Alone
		jsr	(MoveSprite2).l
	else
		jsr	(MoveSprite_TestGravity2).l
	endif
		addi.w	#$30,y_vel(a0)
		btst	#Status_Underwater,status(a0)
		beq.s	locK_156F0
		subi.w	#$20,y_vel(a0)
; loc3_1623C:
locK_156F0:
		cmpi.w	#-$100,(Camera_min_Y_pos).w
		bne.s	locK_15700
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)
; loc3_1624C:
locK_15700:
		bsr.w	subK_15716
		bsr.w	Tails_Check_Screen_Boundaries
		bsr.w	Sonic_RecordPos
		bsr.w	subK_15842
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================

; sub3_16262:
subK_15716:
		tst.b	(Disable_death_plane).w
		bne.s	locK_15742
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		bne.s	locK_15734
	endif
		move.w	(Camera_max_Y_pos).w,d0
		addi.w	#$E0,d0
		cmp.w	y_pos(a0),d0
		blt.w	locK_15788
	if ~~Sonic3_Alone
		bra.s	locK_15742
; ---------------------------------------------------------------------------

locK_15734:
		move.w	(Camera_min_Y_pos).w,d0
		cmp.w	y_pos(a0),d0
		blt.s	locK_15742
		bra.w	locK_15788
; ---------------------------------------------------------------------------
	endif
; loc3_16278:
locK_15742:
		movem.l	a4-a6,-(sp)
		bsr.w	Tails_DoLevelCollision
		movem.l	(sp)+,a4-a6
		btst	#Status_InAir,status(a0)
		bne.s	locretK_15786
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
; locret3_162BC:
locretK_15786:
		rts
; ---------------------------------------------------------------------------
; loc3_162BE:
locK_15788:
		jmp	(Kill_Character).l
; End of function subK_15716

; ---------------------------------------------------------------------------
; loc3_162C4:
locK_1578E:
	if ~~Sonic3_Alone
		cmpi.w	#2,(Player_mode).w
		bne.s	locK_157B0
		tst.w	(Debug_mode_flag).w
		beq.s	locK_157B0
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	locK_157B0
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------

locK_157B0:
	endif
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	locK_157C8
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#Status_InAir,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w
; loc3_162DC:
locK_157C8:
		bsr.w	subK_123C2
	if Sonic3_Alone
		jsr	(MoveSprite).l
	else
		jsr	(MoveSprite_TestGravity).l
	endif
		bsr.w	Sonic_RecordPos
		bsr.w	subK_15842
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_162F4:
locK_157E0:
		tst.w	$3E(a0)
		beq.s	locretK_157F2
		subq.w	#1,$3E(a0)
		bne.s	locretK_157F2
		move.w	#1,(Restart_level_flag).w
; locret3_16306:
locretK_157F2:
		rts
; ---------------------------------------------------------------------------
; loc3_16308:
locK_157F4:
		tst.w	(H_scroll_amount_P2).w
		bne.s	locK_15806
		tst.w	(V_scroll_amount_P2).w
		bne.s	locK_15806
		move.b	#2,routine(a0)
; loc3_1631A:
locK_15806:
		bsr.w	subK_15842
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_16324:
locK_15810:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	locK_15828
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#Status_InAir,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w
; loc3_1633C:
locK_15828:
	if Sonic3_Alone
		jsr	(MoveSprite2).l
	else
		jsr	(MoveSprite_TestGravity2).l
	endif
		addi.w	#$10,y_vel(a0)
		bsr.w	Sonic_RecordPos
		bsr.w	subK_15842
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================

; sub3_16356:
subK_15842:
		tst.w	(Competition_mode).w
		bne.s	locK_1585A
		bsr.s	Animate_Tails
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_15856
		eori.b	#2,render_flags(a0)

locK_15856:
	endif
		bra.w	Tails_Load_PLC
; ---------------------------------------------------------------------------
; loc3_16362:
locK_1585A:
		bsr.w	Animate_Tails2P
		bra.w	Tails2P_Load_PLC
; End of function subK_15842


; =============== S U B R O U T I N E =======================================


Animate_Tails:
		lea	(AniTails).l,a1

Animate_Tails_Part2:
		moveq	#0,d0
		move.b	anim(a0),d0
		cmp.b	prev_anim(a0),d0
		beq.s	locK_1588A
		move.b	d0,prev_anim(a0)
		move.b	#0,anim_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		bclr	#Status_Push,status(a0)
; loc3_16392:
locK_1588A:
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),d0
		bmi.s	locK_158FA
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locretK_158C8
		move.b	d0,anim_frame_timer(a0)
; End of function Animate_Tails


; =============== S U B R O U T I N E =======================================

; sub3_163B8:
subK_158B0:
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
	if Sonic3_Alone
		cmpi.b	#$F0,d0	
	else
		cmpi.b	#$FC,d0
	endif
		bhs.s	locK_158CA
; loc3_163C8:
locK_158C0:
		move.b	d0,mapping_frame(a0)
		addq.b	#1,anim_frame(a0)
; locret3_163D0:
locretK_158C8:
		rts
; ---------------------------------------------------------------------------
; loc3_163D2:
locK_158CA:
		addq.b	#1,d0
		bne.s	locK_158DA
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
		bra.s	locK_158C0
; ---------------------------------------------------------------------------
; loc3_163E2:
locK_158DA:
		addq.b	#1,d0
		bne.s	locK_158EE
		move.b	2(a1,d1.w),d0
		sub.b	d0,anim_frame(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	locK_158C0
; ---------------------------------------------------------------------------
; loc3_163F6:
locK_158EE:
		addq.b	#1,d0
		bne.s	locretK_158F8
		move.b	2(a1,d1.w),anim(a0)
; locret3_16400:
locretK_158F8:
		rts
; End of function subK_158B0

; ---------------------------------------------------------------------------
; loc3_16402:
locK_158FA:
		addq.b	#1,d0
		bne.w	locK_159C8
		moveq	#0,d0
		tst.b	flip_type(a0)
		bmi.w	Anim_Tumble
		move.b	flip_angle(a0),d0
		bne.w	Anim_Tumble
		moveq	#0,d1
		move.b	angle(a0),d0
		bmi.s	locK_1591E
		beq.s	locK_1591E
		subq.b	#1,d0
; loc3_16426:
locK_1591E:
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	locK_1592A
		not.b	d0
; loc3_16432:
locK_1592A:
		addi.b	#$10,d0
		bpl.s	locK_15932
		moveq	#3,d1
; loc3_1643A:
locK_15932:
		andi.b	#$FC,render_flags(a0)
		eor.b	d1,d2
		or.b	d2,render_flags(a0)
		btst	#Status_Push,status(a0)
		bne.w	locK_15A14
		lsr.b	#4,d0
		andi.b	#6,d0
		move.w	ground_vel(a0),d2
		bpl.s	locK_15956
		neg.w	d2
; loc3_1645E:
locK_15956:
		tst.b	status_secondary(a0)
		bpl.w	locK_15960
		add.w	d2,d2
; loc3_16468:
locK_15960:
		move.b	d0,d3
		add.b	d3,d3
		add.b	d3,d3
		lea	(AniTails00).l,a1
		cmpi.w	#$600,d2
		blo.s	locK_1598A
		lea	(AniTails01).l,a1
		move.b	d0,d3
		add.b	d3,d3
		cmpi.w	#$700,d2
		blo.s	locK_1598A
		lea	(AniTails1F).l,a1
		move.b	d0,d3
; loc3_16492:
locK_1598A:
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	locK_159A4
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
; loc3_164AC:
locK_159A4:
		move.b	d0,mapping_frame(a0)
		add.b	d3,mapping_frame(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locretK_159C6
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	locK_159BC
		moveq	#0,d2
; loc3_164C4:
locK_159BC:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)
; locret3_164CE:
locretK_159C6:
		rts
; ---------------------------------------------------------------------------
; loc3_164D0:
locK_159C8:
	if Sonic3_Alone
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locretK_158C8
	endif
		addq.b	#1,d0
		bne.s	locK_15A3C
	if ~~Sonic3_Alone
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locretK_158C8
	ENDIF
		move.w	ground_vel(a0),d2
		bpl.s	locK_159EE
		neg.w	d2
; loc3_164E4:
locK_159EE:
		lea	(AniTails03).l,a1
		cmpi.w	#$600,d2
		bhs.s	locK_15A00
		lea	(AniTails02).l,a1
; loc3_164F6:
locK_15A00:
		neg.w	d2
		addi.w	#$400,d2
		bpl.s	locK_15A0A
		moveq	#0,d2
; loc3_16500:
locK_15A0A:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
	if Sonic3_Alone
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
	endif
		bra.w	subK_158B0
; ---------------------------------------------------------------------------
; loc3_1651C:
locK_15A14:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locretK_158C8
		move.w	ground_vel(a0),d2
		bmi.s	locK_15A24
		neg.w	d2
; loc3_1652C:
locK_15A24:
		addi.w	#$800,d2
		bpl.s	locK_15A2C
		moveq	#0,d2
; loc3_16534:
locK_15A2C:
		lsr.w	#6,d2
		move.b	d2,anim_frame_timer(a0)
		lea	(AniTails04).l,a1
	if Sonic3_Alone
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
	endif
		bra.w	subK_158B0
; ---------------------------------------------------------------------------
; loc3_16556:
locK_15A3C:
	if ~~Sonic3_Alone
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locretK_158C8
	endif
		move.w	x_vel(a2),d1
		move.w	y_vel(a2),d2
		jsr	(GetArcTan).l
	if ~~Sonic3_Alone
		cmpi.b	#$15,(Current_zone).w
		bne.s	locK_15A5E
		add.b	(Stat_table).w,d0

locK_15A5E:
	endif
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	locK_15A6E
		not.b	d0
		bra.s	locK_15A72
; ---------------------------------------------------------------------------
; loc3_16574:
locK_15A6E:
		addi.b	#$80,d0
; loc3_16578:
locK_15A72:
		addi.b	#$10,d0
		bpl.s	locK_15A7A
		moveq	#3,d1
; loc3_16580:
locK_15A7A:
		andi.b	#$FC,render_flags(a0)
		eor.b	d1,d2
		or.b	d2,render_flags(a0)
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_15A92
		eori.b	#2,render_flags(a0)

locK_15A92:
	endif
		lsr.b	#3,d0
		andi.b	#$C,d0
		move.b	d0,d3
		lea	(AniTails_Tail03).l,a1
		move.b	#3,anim_frame_timer(a0)
		bsr.w	subK_158B0
		add.b	d3,mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------
	if Sonic3_Alone
AniTails:
		include "General/Sprites/Tails/Anim - Tails S3.asm"
	else
AniTails:
		include "General/Sprites/Tails/Anim - Tails.asm"
	endif
; ---------------------------------------------------------------------------

Tails_Tail_Load_PLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		cmp.b	(Player_prev_frame_P2_tail).w,d0
	if Sonic3_Alone
		beq.s	locretK_15CCE
	else
		beq.w	locretK_15CCE
	endif
		move.b	d0,(Player_prev_frame_P2_tail).w
		lea	(PLC_Tails_Tail).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locretK_15CCE
		move.w	#tiles_to_bytes(ArtTile_Player_2_Tail),d4
		move.l	#ArtUnc_Tails_Tail,d6
		bra.s	locK_15CA6

; =============== S U B R O U T I N E =======================================


Tails_Load_PLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0

Tails_Load_PLC2:
		cmp.b	(Player_prev_frame_P2).w,d0
		beq.s	locretK_15CCE
		move.b	d0,(Player_prev_frame_P2).w
		lea	(PLC_Tails).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locretK_15CCE
		move.w	#tiles_to_bytes(ArtTile_Player_2),d4
		move.l	#ArtUnc_Tails,d6
	if ~~Sonic3_Alone
		cmpi.w	#2*$D1,d0
		blo.s	locK_15CA6
		move.l	#ArtUnc_Tails_Extra,d6
	endif
; loc3_16782:
locK_15CA6:
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
		dbf	d5,locK_15CA6
; loc3_167AA:
locretK_15CCE:
		rts
; End of function Tails_Load_PLC


; =============== S U B R O U T I N E =======================================


Animate_Tails2P:
		lea	(AniTails2P).l,a1

Animate_Tails_Tail2P:
		moveq	#0,d0
		move.b	anim(a0),d0
		cmp.b	prev_anim(a0),d0
		beq.s	locK_15CF8
		move.b	d0,prev_anim(a0)
		move.b	#0,anim_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		bclr	#Status_Push,status(a0)
; loc3_167D4:
locK_15CF8:
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),d0
		bmi.s	locK_15D68
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locretK_15D36
		move.b	d0,anim_frame_timer(a0)
; End of function Animate_Tails2P


; =============== S U B R O U T I N E =======================================

; sub3_167FA:
subK_15D1E:
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#$F0,d0
		bhs.s	locK_15D38
; loc3_1680A:
locK_15D2E:
		move.b	d0,mapping_frame(a0)
		addq.b	#1,anim_frame(a0)
; locret3_16812:
locretK_15D36:
		rts
; ---------------------------------------------------------------------------
; loc3_16814:
locK_15D38:
		addq.b	#1,d0
		bne.s	locK_15D48
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
		bra.s	locK_15D2E
; ---------------------------------------------------------------------------
; loc3_16824:
locK_15D48:
		addq.b	#1,d0
		bne.s	locK_15D5C
		move.b	2(a1,d1.w),d0
		sub.b	d0,anim_frame(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	locK_15D2E
; ---------------------------------------------------------------------------
; loc3_16838:
locK_15D5C:
		addq.b	#1,d0
		bne.s	locretK_15D66
		move.b	2(a1,d1.w),anim(a0)
; locret3_16842:
locretK_15D66:
		rts
; End of function subK_15D1E

; ---------------------------------------------------------------------------
; loc3_16844:
locK_15D68:
		addq.b	#1,d0
		bne.w	locK_15E82
		moveq	#0,d0
		move.b	flip_angle(a0),d0
		bne.w	locK_15E1C
		moveq	#0,d1
		move.b	angle(a0),d0
		bmi.s	locK_15D84
		beq.s	locK_15D84
		subq.b	#1,d0
; loc3_16860:
locK_15D84:
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	locK_15D90
		not.b	d0
; loc3_1686C:
locK_15D90:
		addi.b	#$10,d0
		bpl.s	locK_15D98
		moveq	#3,d1
; loc3_16874:
locK_15D98:
		andi.b	#$FC,render_flags(a0)
		eor.b	d1,d2
		or.b	d2,render_flags(a0)
		btst	#Status_Push,status(a0)
		bne.w	locK_15ECE
		lsr.b	#5,d0
		andi.b	#3,d0
		move.w	ground_vel(a0),d2
		bpl.s	locK_15DBC
		neg.w	d2
; loc3_16898:
locK_15DBC:
		tst.b	status_secondary(a0)
		bpl.w	locK_15DC6
		add.w	d2,d2
; loc3_168A2:
locK_15DC6:
		move.b	d0,d3
		lea	(AniTails2P01).l,a1
		cmpi.w	#$600,d2
		bhs.s	locK_15DDC
		lea	(AniTails2P00).l,a1
		add.b	d0,d0
; loc3_168B8:
locK_15DDC:
		add.b	d0,d3
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	locK_15DF8
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
; loc3_168D4:
locK_15DF8:
		move.b	d0,mapping_frame(a0)
		add.b	d3,mapping_frame(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locretK_15E1A
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	locK_15E10
		moveq	#0,d2
; loc3_168EC:
locK_15E10:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)
; locret3_168F6:
locretK_15E1A:
		rts
; ---------------------------------------------------------------------------
; loc3_168F8:
locK_15E1C:
		move.b	flip_angle(a0),d0
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	locK_15E4A
		andi.b	#$FC,render_flags(a0)
		addi.b	#$16,d0
		divu.w	#$2C,d0
		addi.b	#$15,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_16926:
locK_15E4A:
		andi.b	#$FC,render_flags(a0)
		tst.b	flip_type(a0)
		bpl.s	locK_15E62
		ori.b	#1,render_flags(a0)
		addi.b	#$16,d0
		bra.s	locK_15E6E
; ---------------------------------------------------------------------------
; loc3_1693E:
locK_15E62:
		ori.b	#3,render_flags(a0)
		neg.b	d0
		addi.b	#$9A,d0
; loc3_1694A:
locK_15E6E:
		divu.w	#$2C,d0
		addi.b	#$15,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_1695E:
locK_15E82:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locretK_15D36
		addq.b	#1,d0
		bne.s	locK_15F08
		move.w	ground_vel(a0),d2
		bpl.s	locK_15E96
		neg.w	d2
; loc3_16972:
locK_15E96:
		lea	(AniTails2P03).l,a1
		cmpi.w	#$600,d2
		bhs.s	locK_15EA8
		lea	(AniTails2P02).l,a1
; loc3_16984:
locK_15EA8:
		neg.w	d2
		addi.w	#$400,d2
		bpl.s	locK_15EB2
		moveq	#0,d2
; loc3_1698E:
locK_15EB2:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		bra.w	subK_15D1E
; ---------------------------------------------------------------------------
; loc3_169AA:
locK_15ECE:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locretK_15D36
		move.w	ground_vel(a0),d2
		bmi.s	locK_15EDE
		neg.w	d2
; loc3_169BA:
locK_15EDE:
		addi.w	#$800,d2
		bpl.s	locK_15EE6
		moveq	#0,d2
; loc3_169C2:
locK_15EE6:
		lsr.w	#6,d2
		move.b	d2,anim_frame_timer(a0)
		lea	(AniTails2P04).l,a1
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		bra.w	subK_15D1E
; ---------------------------------------------------------------------------
; loc3_169E4:
locK_15F08:
		move.w	x_vel(a2),d1
		move.w	y_vel(a2),d2
		jsr	(GetArcTan).l
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	locK_15F26
		not.b	d0
		bra.s	locK_15F2A
; ---------------------------------------------------------------------------
; loc3_16A02:
locK_15F26:
		addi.b	#$80,d0
; loc3_16A06:
locK_15F2A:
		addi.b	#$10,d0
		bpl.s	locK_15F32
		moveq	#3,d1
; loc3_16A0E:
locK_15F32:
		andi.b	#$FC,render_flags(a0)
		eor.b	d1,d2
		or.b	d2,render_flags(a0)
		lsr.b	#5,d0
		andi.b	#3,d0
		move.b	d0,d3
		add.b	d0,d0
		add.b	d0,d3
		lea	(AniTails2P_Tail03).l,a1
		move.b	#3,anim_frame_timer(a0)
		bsr.w	subK_15D1E
		add.b	d3,mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------

AniTails2P:
		include "General/Sprites/Tails/Anim - Tails 2P.asm"

; =============== S U B R O U T I N E =======================================


Tails2P_Tail_Load_PLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		lea	(DPLC_Tails2P_Tail).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locretK_160A4
		move.l	#ArtUnc_Tails2P_Tail,d6
		move.w	#tiles_to_bytes(ArtTile_Player_2_Tail),d4
		cmpa.w	#Tails_tails,a0
		beq.s	locK_1607C
		move.w	#tiles_to_bytes(ArtTile_Player_1+$10),d4
		bra.s	locK_1607C
; End of function Tails2P_Tail_Load_PLC


; =============== S U B R O U T I N E =======================================


Tails2P_Load_PLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		lea	(PLC_Tails2P).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locretK_160A4
		move.l	#ArtUnc_Tails2P,d6
		move.w	#tiles_to_bytes(ArtTile_Player_1),d4
		cmpa.w	#Player_1,a0
		beq.s	locK_1607C
		move.w	#tiles_to_bytes(ArtTile_Player_2),d4
; loc3_16B58:
locK_1607C:
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
		dbf	d5,locK_1607C
; locret3_16B80:
locretK_160A4:
		rts
; End of function Tails2P_Load_PLC

; ---------------------------------------------------------------------------

Obj_Tails_Tail:
		; Init
		move.l	#Map_Tails_Tail,mappings(a0)
		move.w	#make_art_tile(ArtTile_Player_2_Tail,0,0),art_tile(a0)
		move.w	#$100,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#4,render_flags(a0)
		move.l	#Obj_Tails_Tail_Main,(a0)

Obj_Tails_Tail_Main:
		; Here, several SSTs are inherited from the parent, normally Tails
		movea.w	$30(a0),a2	; Is Parent in S2
		move.b	angle(a2),angle(a0)
		move.b	status(a2),status(a0)
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		move.w	priority(a2),priority(a0)
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	locK_16106
		ori.w	#high_priority,art_tile(a0)
; loc3_16BE2:
locK_16106:
		moveq	#0,d0
		move.b	anim(a2),d0
		btst	#Status_Push,status(a2)
		beq.s	locK_1612C
		tst.b	(WindTunnel_flag_P2).w
		bne.s	locK_1612C
	if ~~Sonic3_Alone
		; This is checking if parent (Tails) is in its pushing animation
		cmpi.b	#$A9,mapping_frame(a2)
		blo.s	locK_1612C
		cmpi.b	#$AC,mapping_frame(a2)
		bhi.s	locK_1612C
	endif
		moveq	#4,d0
; loc3_16BF8:
locK_1612C:
		cmp.b	objoff_34(a0),d0	; Has the input parent anim changed since last check?
		beq.s	locK_1613C		; If not, branch and skip setting a matching Tails' Tails anim
		move.b	d0,objoff_34(a0)	; Store d0 for the above comparison
		move.b	Obj_Tails_Tail_AniSelection(pc,d0.w),anim(a0)	; Load anim relative to parent's
; loc3_16C08:
locK_1613C:
		lea	(AniTails_Tail).l,a1
		bsr.w	Animate_Tails_Part2
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_1615A
		cmpi.b	#3,anim(a0)		; Is this the Directional animation?
		beq.s	locK_1615A		; If so, skip the mirroring
		eori.b	#2,render_flags(a0)	; Reverse the vertical mirror render flag bit (on if off beforehand and vice versa)

locK_1615A:
	endif
		bsr.w	Tails_Tail_Load_PLC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; animation master script table for the tails
; chooses which animation script to run depending on what Tails is doing

Obj_Tails_Tail_AniSelection:
		dc.b 0,0	; TailsAni_Walk,Run	->
		dc.b 3		; TailsAni_Roll		-> Directional
		dc.b 3		; TailsAni_Roll2	-> Directional
		dc.b 9		; TailsAni_Push		-> Pushing
		dc.b 1		; TailsAni_Wait		-> Swish
		dc.b 0		; TailsAni_Balance	-> Blank
		dc.b 2		; TailsAni_LookUp	-> Flick
		dc.b 1		; TailsAni_Duck		-> Swish
		dc.b 7		; TailsAni_Spindash	-> Spindash
		dc.b 0,0,0	; TailsAni_Dummy1,2,3	->
		dc.b 8		; TailsAni_Stop		-> Skidding
		dc.b 0,0	; TailsAni_Float,2	->
		dc.b 0		; TailsAni_Spring	->
		dc.b 0		; TailsAni_Hang		->
		dc.b 0		;
		dc.b 0		; TailsAni_Victory	->
		dc.b $A		; TailsAni_Hang2	-> Hanging
		dc.b 0		; TailsAni_Bubble	->
		dc.b 0,0,0	; TailsAni_Death,2,3	->
		dc.b 0		; TailsAni_Slide2?	->
		dc.b 0,0	; TailsAni_Hurt,Slide	->
		dc.b 0		; TailsAni_Blank	->
		dc.b 0,0	; TailsAni_Dummy4,5	->
		dc.b 0		; TailsAni_HaulAss	->
		dc.b $B,$C	; TailsAni_Fly,2	-> Fly1,2
		dc.b $B		; TailsAni_Carry	-> Fly1
		dc.b $C		; TailsAni_Ascend	-> Fly2
		dc.b $B		; TailsAni_Tired	-> Fly1
		dc.b 0,0	; TailsAni_Swim,2	->
		dc.b 0		; TailsAni_Tired2	->
		dc.b 0		; TailsAni_Tired3	->
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		even

AniTails_Tail:
		include "General/Sprites/Tails/Anim - Tails Tail.asm"
; ---------------------------------------------------------------------------

Obj_Tails2P_Tail:
		move.l	#Map_Tails2P_Tail,mappings(a0)
		move.w	#make_art_tile(ArtTile_Player_2_Tail,0,0),art_tile(a0)
		cmpa.w	#Tails_tails,a0
		beq.s	locK_16214
		move.w	#make_art_tile(ArtTile_Player_1+$10,0,0),art_tile(a0)
; loc3_16CCC:
locK_16214:
		move.w	#$100,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#4,render_flags(a0)
		move.l	#locK_16232,(a0)
; loc3_16CEA:
locK_16232:
		movea.w	$30(a0),a2
		move.b	angle(a2),angle(a0)
		move.b	status(a2),status(a0)
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		move.w	priority(a2),priority(a0)
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	locK_16266
		ori.w	#high_priority,art_tile(a0)
; loc3_16D1E:
locK_16266:
		moveq	#0,d0
		move.b	anim(a2),d0
		btst	#Status_Push,status(a2)
		beq.s	locK_1627C
		cmpi.b	#5,d0
		beq.s	locK_1627C
		moveq	#4,d0
; loc3_16D34:
locK_1627C:
		cmp.b	$34(a0),d0
		beq.s	locK_1628C
		move.b	d0,$34(a0)
		move.b	byteK_162A0(pc,d0.w),anim(a0)
; loc3_16D44:
locK_1628C:
		lea	(AniTails2P_Tail).l,a1
		bsr.w	Animate_Tails_Tail2P
		bsr.w	Tails2P_Tail_Load_PLC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; byte3_16D58:
byteK_162A0:
		dc.b 0,0
		dc.b 3
		dc.b 3
		dc.b 0
		dc.b 1
		dc.b 1
		dc.b 1
		dc.b 1
		dc.b 0
		dc.b 1,1,1
		dc.b 0
		dc.b 0,0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0,0,0
		dc.b 0
		dc.b 0,0
		dc.b 0
		dc.b 0,0
		dc.b 0
		dc.b 0,0
		even

AniTails2P_Tail:
		include "General/Sprites/Tails/Anim - Tails 2P Tail.asm"