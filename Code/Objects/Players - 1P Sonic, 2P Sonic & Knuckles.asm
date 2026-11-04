; ---------------------------------------------------------------------------

Obj_Sonic2P:
		cmpa.w	#Player_1,a0
		bne.s	locK_105F2
		lea	(Max_speed).w,a4
		lea	(Distance_from_top).w,a5
		lea	(Dust).w,a6
		move.b	(Player_2+character_id).w,d0
		cmp.b	character_id(a0),d0
		bne.s	locK_105E6
		bchg	#3,render_flags(a0)
; loc3_116FE:
locK_105E6:
		tst.w	(Debug_placement_mode).w
		beq.s	locK_1060E
		jmp	(DebugMode).l
; ---------------------------------------------------------------------------
; loc3_1170A:
locK_105F2:
		lea	(Max_speed_P2).w,a4
		lea	(Distance_from_top_P2).w,a5
		lea	(Dust_P2).w,a6
		move.b	(Player_1+character_id).w,d0
		cmp.b	character_id(a0),d0
		bne.s	locK_1060E
		bchg	#4,render_flags(a0)
; loc3_11726:
locK_1060E:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Sonic2P_Index(pc,d0.w),d1
		jmp	Sonic2P_Index(pc,d1.w)
; ---------------------------------------------------------------------------

Sonic2P_Index:
		dc.w locK_10628-Sonic2P_Index
		dc.w locK_10740-Sonic2P_Index
		dc.w locK_122BE-Sonic2P_Index
		dc.w locK_12390-Sonic2P_Index
		dc.w locK_1257C-Sonic2P_Index
		dc.w locK_12590-Sonic2P_Index
; ---------------------------------------------------------------------------
; loc3_11740:
locK_10628:
		addq.b	#2,routine(a0)
		move.b	#$B,y_radius(a0)
		move.b	#5,x_radius(a0)
		move.b	#$B,default_y_radius(a0)
		move.b	#5,default_x_radius(a0)
		move.w	#$100,priority(a0)
		move.b	#$C,width_pixels(a0)
		move.b	#$C,height_pixels(a0)
		move.b	#4,render_flags(a0)
		lea	(Character_Speeds).l,a1
		moveq	#0,d0
		move.b	character_id(a0),d0
		lsl.w	#3,d0
		lea	(a1,d0.w),a1
		move.w	(a1)+,Max_speed-Max_speed(a4)
		move.w	(a1)+,Acceleration-Max_speed(a4)
		move.w	(a1)+,Deceleration-Max_speed(a4)
		tst.b	(Last_star_post_hit).w
		bne.w	locK_10724
		move.b	#$C,top_solid_bit(a0)
		move.b	#$D,lrb_solid_bit(a0)
		cmpa.w	#Player_1,a0
		bne.s	locK_106DC
		move.w	#make_art_tile(ArtTile_Player_1,0,0),art_tile(a0)
		move.l	#Map_Sonic2P,mappings(a0)
		tst.b	character_id(a0)
		beq.s	locK_106B4
		move.l	#Map_Knuckles2P,mappings(a0)
		addi.w	#palette_line_1,art_tile(a0)
; loc3_116CC:
locK_106B4:
		cmpi.b	#$12,(Current_zone).w
		bne.s	locK_106C2
		ori.w	#high_priority,art_tile(a0)
; loc3_117DA:
locK_106C2:
		move.w	x_pos(a0),(Saved_X_pos).w
		move.w	y_pos(a0),(Saved_Y_pos).w
		move.w	art_tile(a0),(Saved_art_tile).w
		move.w	top_solid_bit(a0),(Saved_solid_bits).w
		bra.s	locK_10724
; ---------------------------------------------------------------------------
; loc3_117F4:
locK_106DC:
		move.w	#make_art_tile(ArtTile_Player_2,0,0),art_tile(a0)
		move.l	#Map_Sonic2P,mappings(a0)
		tst.b	character_id(a0)
		beq.s	locK_106FE
		move.l	#Map_Knuckles2P,mappings(a0)
		addi.w	#palette_line_1,art_tile(a0)
; loc3_11816:
locK_106FE:
		cmpi.b	#$12,(Current_zone).w
		bne.s	locK_1070C
		ori.w	#high_priority,art_tile(a0)
; loc3_11824:
locK_1070C:
		move.w	x_pos(a0),(Saved2_X_pos).w
		move.w	y_pos(a0),(Saved2_Y_pos).w
		move.w	art_tile(a0),(Saved2_art_tile).w
		move.w	top_solid_bit(a0),(Saved2_solid_bits).w
; loc3_1183C:
locK_10724:
		move.b	#0,flips_remaining(a0)
		move.b	#4,flip_speed(a0)
		move.b	#0,(Super_Sonic_Knux_flag).w
		move.b	#30,air_left(a0)
		bsr.w	Reset_Player_Position_Array
; loc3_11858:
locK_10740:
		tst.w	(Debug_mode_flag).w
		beq.s	locK_10760
		cmpa.w	#Player_1,a0
		bne.s	locK_10760
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	locK_10760
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------
; loc3_11878:
locK_10760:
		cmpa.w	#Player_1,a0
		bne.s	locK_10774
		tst.b	(Ctrl_1_locked).w
		bne.s	locK_10780
		move.w	(Ctrl_1).w,(Ctrl_1_logical).w
		bra.s	locK_10780
; ---------------------------------------------------------------------------
; loc3_1188C:
locK_10774:
		tst.b	(Ctrl_2_locked).w
		bne.s	locK_10780
		move.w	(Ctrl_2).w,(Ctrl_1_logical).w
; loc3_11898:
locK_10780:
		bsr.w	Sonic_Display
		btst	#0,object_control(a0)
		bne.s	locK_1079E
		moveq	#0,d0
		move.b	status(a0),d0
		andi.w	#6,d0
		move.w	offK_107EE(pc,d0.w),d1
		jsr	offK_107EE(pc,d1.w)
; loc3_118B6:
locK_1079E:
		cmpi.w	#-$100,(Camera_min_Y_pos).w
		bne.s	locK_107AE
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)
; loc3_118C6:
locK_107AE:
		move.w	(Screen_X_wrap_value).w,d0
		and.w	d0,x_pos(a0)
		addi.w	#$400,x_pos(a0)
		bsr.w	Sonic_RecordPos
		move.b	(Primary_Angle).w,next_tilt(a0)
		move.b	(Secondary_Angle).w,tilt(a0)
		btst	#1,object_control(a0)
		bne.s	locK_107DC
		bsr.w	Animate_SonicKnuckles_2P
		bsr.w	SonicKnuckles2P_Load_PLC
; loc3_118F4:
locK_107DC:
		move.b	object_control(a0),d0
		andi.b	#$A0,d0
		bne.s	locretK_107EC
		jsr	(TouchResponse_CompetitionMode).l
; locret3_11904:
locretK_107EC:
		rts
; ---------------------------------------------------------------------------
; off3_11906:
offK_107EE:
		dc.w locK_107F6-offK_107EE
		dc.w locK_10868-offK_107EE
		dc.w locK_10896-offK_107EE
		dc.w locK_108B8-offK_107EE
; ---------------------------------------------------------------------------
; loc3_1190E:
locK_107F6:
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		bne.s	locK_10844
		cmpi.b	#$A,anim(a0)
		beq.s	locretK_10866
		cmpi.b	#$B,anim(a0)
		beq.s	locretK_10866
		cmpi.b	#5,anim(a0)
		bne.s	locK_10844
		cmpi.b	#$1E,anim_frame(a0)
		blo.s	locK_10844
		bsr.w	Player_SlopeResist
		move.b	(Ctrl_1_logical).w,d0
		andi.b	#button_up_mask|button_down_mask|button_left_mask|button_right_mask|button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	locK_1085E
		move.b	#$A,anim(a0)
		cmpi.b	#$AC,anim_frame(a0)
		blo.s	locK_1085E
		move.b	#$B,anim(a0)
		bra.s	locK_1085E
; ---------------------------------------------------------------------------
; loc3_1195C:
locK_10844:
		bsr.w	subK_1094C
		bsr.w	Sonic_Jump
		bsr.w	Player_SlopeResist
		bsr.w	Sonic_Move
		bsr.w	subK_108E6
		jsr	(MoveSprite2).l
; loc3_11976:
locK_1085E:
		bsr.w	Player_AnglePos
		bsr.w	Player_SlopeRepel
; locret3_1197E:
locretK_10866:
		rts
; ---------------------------------------------------------------------------
; loc3_11980:
locK_10868:
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_ChgJumpDir
		jsr	(MoveSprite).l
		btst	#Status_Underwater,status(a0)
		beq.s	locK_10884
		subi.w	#$28,y_vel(a0)
; loc3_1199C:
locK_10884:
		bsr.w	Player_JumpAngle
		movem.l	a4-a6,-(sp)
		bsr.w	SonicKnux_DoLevelCollision
		movem.l	(sp)+,a4-a6
		rts
; ---------------------------------------------------------------------------
; loc3_119AE:
locK_10896:
		tst.b	spin_dash_flag(a0)
		bne.s	locK_108A0
		bsr.w	Sonic_Jump
; loc3_119B8:
locK_108A0:
		bsr.w	Player_RollRepel
		bsr.w	Sonic_RollSpeed
		jsr	(MoveSprite2).l
		bsr.w	Player_AnglePos
		bsr.w	Player_SlopeRepel
		rts
; ---------------------------------------------------------------------------
; loc3_119D0:
locK_108B8:
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_ChgJumpDir
		jsr	(MoveSprite).l
		btst	#Status_Underwater,status(a0)
		beq.s	locK_108D4
		subi.w	#$28,y_vel(a0)
; loc3_119EC:
locK_108D4:
		bsr.w	Player_JumpAngle
		movem.l	a4-a6,-(sp)
		bsr.w	SonicKnux_DoLevelCollision
		movem.l	(sp)+,a4-a6
		rts

; =============== S U B R O U T I N E =======================================

; sub3_119FE:
subK_108E6:
		tst.b	status_secondary(a0)
		bmi.s	locretK_1090C
		move.w	ground_vel(a0),d0
		bpl.s	locK_108F4
		neg.w	d0
; loc3_11A0C:
locK_108F4:
		cmpi.w	#$80,d0
		blo.s	locretK_1090C
		move.b	(Ctrl_1_logical).w,d0
		andi.b	#button_left_mask|button_right_mask,d0
		bne.s	locretK_1090C
		btst	#button_down,(Ctrl_1_held_logical).w
		bne.s	locK_1090E
; locret3_11A24:
locretK_1090C:
		rts
; ---------------------------------------------------------------------------
; loc3_11A26:
locK_1090E:
		btst	#Status_Roll,status(a0)
		beq.s	locK_10918
		rts
; ---------------------------------------------------------------------------
; loc3_11A30:
locK_10918:
		bset	#Status_Roll,status(a0)
		move.b	#7,y_radius(a0)
		move.b	#3,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#4,y_pos(a0)
		move.w	#sfx_Roll,d0
		jsr	(Play_SFX).l
		tst.w	ground_vel(a0)
		bne.s	locretK_1094A
		move.w	#$200,ground_vel(a0)
; locret3_11A62:
locretK_1094A:
		rts
; End of function subK_108E6


; =============== S U B R O U T I N E =======================================

; sub3_11A64:
subK_1094C:
		tst.b	spin_dash_flag(a0)
		bne.s	locK_10998
		cmpi.b	#8,anim(a0)
		bne.s	locretK_10996
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locretK_10996
		move.b	#9,anim(a0)
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addq.l	#4,sp
		move.b	#1,spin_dash_flag(a0)
		move.w	#0,spin_dash_counter(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	locK_10992
		move.b	#2,anim(a6)
; loc3_11AAA:
locK_10992:
		bsr.w	Player_AnglePos
; locret3_11AAE:
locretK_10996:
		rts
; ---------------------------------------------------------------------------
; loc3_11AB0:
locK_10998:
		move.b	(Ctrl_1_logical).w,d0
		btst	#button_down,d0
		bne.w	locK_10A38
		move.b	#7,y_radius(a0)
		move.b	#3,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#4,y_pos(a0)
		move.b	#0,spin_dash_flag(a0)
		moveq	#0,d0
		move.b	spin_dash_counter(a0),d0
		add.w	d0,d0
		move.w	wordK_10A14(pc,d0.w),ground_vel(a0)
	if Sonic3_Alone
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	loc3_11AF2
		move.w	wordK_10A26(pc,d0.w),ground_vel(a0)

loc3_11AF2:
	endif
		move.w	ground_vel(a0),d0
		subi.w	#$800,d0
		add.w	d0,d0
		andi.w	#$1F00,d0
		neg.w	d0
		addi.w	#$2000,d0
		lea	(H_scroll_frame_offset).w,a1
		cmpa.w	#Player_1,a0
		beq.s	locK_109F0
		lea	(H_scroll_frame_offset_P2).w,a1
; loc3_11B14:
locK_109F0:
		move.w	d0,(a1)
		btst	#Status_Facing,status(a0)
		beq.s	locK_109FE
		neg.w	ground_vel(a0)
; loc3_11B22:
locK_109FE:
		bset	#Status_Roll,status(a0)
		move.b	#0,anim(a6)
		moveq	#signextendB(sfx_Dash),d0
		jsr	(Play_SFX).l
		bra.s	locK_10A80
; ---------------------------------------------------------------------------
; word3_11B38:
wordK_10A14:
		dc.w   $800
		dc.w   $880
		dc.w   $900
		dc.w   $980
		dc.w   $A00
		dc.w   $A80
		dc.w   $B00
		dc.w   $B80
		dc.w   $C00
; word3_11B4A:
wordK_10A26:
		dc.w   $B00
		dc.w   $B80
		dc.w   $C00
		dc.w   $C80
		dc.w   $D00
		dc.w   $D80
		dc.w   $E00
		dc.w   $E80
		dc.w   $F00
; ---------------------------------------------------------------------------
; loc3_11B5C:
locK_10A38:
		tst.w	spin_dash_counter(a0)
		beq.s	locK_10A50
		move.w	spin_dash_counter(a0),d0
		lsr.w	#5,d0
		sub.w	d0,spin_dash_counter(a0)
		bcc.s	locK_10A50
		move.w	#0,spin_dash_counter(a0)
; loc3_11B74:
locK_10A50:
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locK_10A80
		move.w	#9<<8,anim(a0)	; and prev_anim
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addi.w	#$200,spin_dash_counter(a0)
		cmpi.w	#$800,spin_dash_counter(a0)
		blo.s	locK_10A80
		move.w	#$800,spin_dash_counter(a0)
; loc3_11BA4:
locK_10A80:
		addq.l	#4,sp
		cmpi.w	#$60,(a5)
		beq.s	locK_10A8E
		bcc.s	locK_10A8C
		addq.w	#4,(a5)
; loc3_11BB0:
locK_10A8C:
		subq.w	#2,(a5)
; loc3_11BB2:
locK_10A8E:
		bsr.w	Player_AnglePos
		rts
; End of function subK_1094C

; ---------------------------------------------------------------------------

Obj_Sonic:
		; Load some addresses into registers
		; This is done to allow some subroutines to be
		; shared with Tails/Knuckles.
		lea	(Max_speed).w,a4
		lea	(Distance_from_top).w,a5
		lea	(Dust).w,a6

		tst.w	(Debug_placement_mode).w
		beq.s	Sonic_Normal

		; Debug only code
		cmpi.b	#1,(Debug_placement_type).w	; Is Sonic in debug object placement mode?
		beq.s	JmpTo_DebugMode			; If so, skip to debug mode routine
		; By this point, we're assuming you're in frame cycling mode
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	locK_10ABC
		move.w	#0,(Debug_placement_mode).w	; Leave debug mode

locK_10ABC:
		addq.b	#1,mapping_frame(a0)		; Next frame
	if Sonic3_Alone
		cmpi.b	#$D9,mapping_frame(a0)		; Have we reached the end of Sonic's frames?
	else
		cmpi.b	#$FB,mapping_frame(a0)		; Have we reached the end of Sonic's frames?
	endif
		blo.s	locK_10ACE
		move.b	#0,mapping_frame(a0)		; If so, reset to Sonic's first frame

locK_10ACE:
		bsr.w	Sonic_Load_PLC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

JmpTo_DebugMode:
		jmp	(DebugMode).l
; ---------------------------------------------------------------------------

Sonic_Normal:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Sonic_Index(pc,d0.w),d1
		jmp	Sonic_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Sonic_Index:
		dc.w Sonic_Init-Sonic_Index	;  0
		dc.w Sonic_Control-Sonic_Index	;  2
		dc.w locK_122BE-Sonic_Index	;  4
		dc.w locK_12390-Sonic_Index	;  6
		dc.w locK_1257C-Sonic_Index	;  8
		dc.w locK_12590-Sonic_Index	; $A
		dc.w locK_125AC-Sonic_Index	; $C
; ---------------------------------------------------------------------------

Sonic_Init:	; Routine 0
		addq.b	#2,routine(a0)		; => Sonic_Control
		move.b	#$13,y_radius(a0)	; this sets Sonic's collision height (2*pixels)
		move.b	#9,x_radius(a0)
		move.b	#$13,default_y_radius(a0)
		move.b	#9,default_x_radius(a0)
		move.l	#Map_Sonic,mappings(a0)
		move.w	#$100,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#4,render_flags(a0)
		move.b	#0,character_id(a0)
		move.w	#$600,Max_speed-Max_speed(a4)
		move.w	#$C,Acceleration-Max_speed(a4)
		move.w	#$80,Deceleration-Max_speed(a4)
		tst.b	(Last_star_post_hit).w
		bne.s	Sonic_Init_Continued
		; only happens when not starting at a checkpoint:
		move.w	#make_art_tile(ArtTile_Player_1,0,0),art_tile(a0)
		move.b	#$C,top_solid_bit(a0)
		move.b	#$D,lrb_solid_bit(a0)
		cmpi.b	#2,(Special_bonus_entry_flag).w
		beq.s	Sonic_Init_Continued
		; only happens when not starting at a Special Stage ring:
		move.w	x_pos(a0),(Saved_X_pos).w
		move.w	y_pos(a0),(Saved_Y_pos).w
		move.w	art_tile(a0),(Saved_art_tile).w
		move.w	top_solid_bit(a0),(Saved_solid_bits).w

Sonic_Init_Continued:
		move.b	#0,flips_remaining(a0)
		move.b	#4,flip_speed(a0)
		move.b	#0,(Super_Sonic_Knux_flag).w
		move.b	#30,air_left(a0)
		subi.w	#$20,x_pos(a0)
		addi.w	#4,y_pos(a0)
		bsr.w	Reset_Player_Position_Array
		addi.w	#$20,x_pos(a0)
		subi.w	#4,y_pos(a0)
		rts

; ---------------------------------------------------------------------------
; Normal state for Sonic
; ---------------------------------------------------------------------------

Sonic_Control:	; Routine 2
		tst.w	(Debug_mode_flag).w		; is debug cheat enabled?
		beq.s	locK_10BF0			; if not, branch
	if ~~Sonic3_Alone
		bclr	#button_A,(Ctrl_1_pressed).w	; is button A pressed?
		beq.s	locK_10BCE			; if not, branch
		eori.b	#1,(Reverse_gravity_flag).w	; toggle reverse gravity

locK_10BCE:
	endif
		btst	#button_B,(Ctrl_1_pressed).w	; is button B pressed?
		beq.s	locK_10BF0			; if not, branch
		move.w	#1,(Debug_placement_mode).w	; change Sonic into a ring/item
		clr.b	(Ctrl_1_locked).w		; unlock control
		btst	#button_C,(Ctrl_1_held).w	; was button C held before pressing B?
		beq.s	locretK_10BEE			; if not, branch
		move.w	#2,(Debug_placement_mode).w	; enter animation cycle mode
; loc3_11D04:
locretK_10BEE:
		rts
; ---------------------------------------------------------------------------
; loc3_11D06:
locK_10BF0:
		tst.b	(Ctrl_1_locked).w		; are controls locked?
		bne.s	locK_10BFC			; if yes, branch
		move.w	(Ctrl_1).w,(Ctrl_1_logical).w	; copy new held buttons, to enable joypad control
; loc3_11D12:
locK_10BFC:
		btst	#0,object_control(a0)	; is Sonic interacting with another object that holds him in place or controls his movement somehow?
		beq.s	locK_10C0C		; if yes, branch to skip Sonic's control
		move.b	#0,double_jump_flag(a0)	; enable double jump
		bra.s	locK_10C26
; ---------------------------------------------------------------------------
; loc3_11D22:
locK_10C0C:
		movem.l	a4-a6,-(sp)
		moveq	#0,d0
		move.b	status(a0),d0
		andi.w	#6,d0
		move.w	Sonic_Modes(pc,d0.w),d1
		jsr	Sonic_Modes(pc,d1.w)	; run Sonic's movement control code
		movem.l	(sp)+,a4-a6
; loc3_11D3C:
locK_10C26:
		cmpi.w	#-$100,(Camera_min_Y_pos).w	; is vertical wrapping enabled?
		bne.s	locK_10C36			; if not, branch
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)			; perform wrapping of Sonic's y position
; loc3_11D4C:
locK_10C36:
		bsr.s	Sonic_Display
		bsr.w	SonicKnux_SuperHyper
		bsr.w	Sonic_RecordPos
		bsr.w	Sonic_Water
		move.b	(Primary_Angle).w,next_tilt(a0)
		move.b	(Secondary_Angle).w,tilt(a0)
		tst.b	(WindTunnel_flag).w
		beq.s	locK_10C62
		tst.b	anim(a0)
		bne.s	locK_10C62
		move.b	prev_anim(a0),anim(a0)
; loc3_11D78:
locK_10C62:
		btst	#1,object_control(a0)
		bne.s	locK_10C7E
		bsr.w	Animate_Sonic
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_10C7A
		eori.b	#2,render_flags(a0)

locK_10C7A:
	endif
		bsr.w	Sonic_Load_PLC
; loc3_11D88:
locK_10C7E:
		move.b	object_control(a0),d0
		andi.b	#$A0,d0
		bne.s	locretK_10C8E
		jsr	(TouchResponse).l
; locret3_11D98:
locretK_10C8E:
		rts
; ---------------------------------------------------------------------------
; secondary states under state Sonic_Control
Sonic_Modes:
		dc.w Sonic_MdNormal-Sonic_Modes
		dc.w Sonic_MdAir-Sonic_Modes
		dc.w Sonic_MdRoll-Sonic_Modes
		dc.w Sonic_MdJump-Sonic_Modes

; =============== S U B R O U T I N E =======================================


Sonic_Display:
		move.b	invulnerability_timer(a0),d0
		beq.s	locK_10CA6
		subq.b	#1,invulnerability_timer(a0)
		lsr.b	#3,d0
		bcc.s	Sonic_ChkInvin
; loc3_11DB0:
locK_10CA6:
		jsr	(Draw_Sprite).l

Sonic_ChkInvin:	; Checks if invincibility has expired and disables it if it has.
		btst	#Status_Invincible,status_secondary(a0)
		beq.s	Sonic_ChkShoes
		tst.b	invincibility_timer(a0)
		beq.s	Sonic_ChkShoes	; If there wasn't any time left, that means we're in Super/Hyper mode
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0
		bne.s	Sonic_ChkShoes
		subq.b	#1,invincibility_timer(a0)	; reduce invincibility_timer only on every 8th frame
		bne.s	Sonic_ChkShoes			; if time is still left, branch
		tst.b	(Boss_flag).w		; Don't change music if in a boss fight
		bne.s	Sonic_RmvInvin
		cmpi.b	#12,air_left(a0)	; Don't change music if drowning
		blo.s	Sonic_RmvInvin
		move.w	(Current_music).w,d0
		jsr	(Play_Music).l		; stop playing invincibility theme and resume normal level music

Sonic_RmvInvin:
		bclr	#Status_Invincible,status_secondary(a0)

Sonic_ChkShoes:	; Checks if Speed Shoes have expired and disables them if they have.
		btst	#Status_SpeedShoes,status_secondary(a0)	; does Sonic have speed shoes?
		beq.s	Sonic_ExitChk				; if so, branch
		tst.b	speed_shoes_timer(a0)
		beq.s	Sonic_ExitChk
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0
		bne.s	Sonic_ExitChk
		subq.b	#1,speed_shoes_timer(a0)	; reduce speed_shoes_timer only on every 8th frame
		bne.s	Sonic_ExitChk
		tst.w	(Competition_mode).w		; is this Competition mode?
		bne.s	Sonic_ChkShoesCompetition	; if so, branch
		move.w	#$600,Max_speed-Max_speed(a4)		; set Max_speed
		move.w	#$C,Acceleration-Max_speed(a4)		; set Acceleration
		move.w	#$80,Deceleration-Max_speed(a4)		; set Deceleration
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	locK_10D32	; if Super/Hyper, set different values
		move.w	#$A00,Max_speed-Max_speed(a4)		; set Max_speed
		move.w	#$30,Acceleration-Max_speed(a4)		; set Acceleration
		move.w	#$100,Deceleration-Max_speed(a4)	; set Deceleration
; loc3_11E3C:
locK_10D32:
		bclr	#Status_SpeedShoes,status_secondary(a0)
		moveq	#0,d0		; Slow down tempo
		jmp	(Change_Music_Tempo).l
; ---------------------------------------------------------------------------

Sonic_ExitChk:
		rts
; ---------------------------------------------------------------------------

Sonic_ChkShoesCompetition:
		lea	(Character_Speeds).l,a1
		moveq	#0,d0
		move.b	character_id(a0),d0
		lsl.w	#3,d0
		lea	(a1,d0.w),a1
		move.w	(a1)+,Max_speed-Max_speed(a4)
		move.w	(a1)+,Acceleration-Max_speed(a4)
		move.w	(a1)+,Deceleration-Max_speed(a4)
		bclr	#Status_SpeedShoes,status_secondary(a0)
		rts
; End of function Sonic_Display

; ---------------------------------------------------------------------------
; Subroutine to record Sonic's previous positions for invincibility stars
; and input/status flags for Tails' AI to follow
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Sonic_RecordPos:
		tst.w	(Competition_mode).w		; are we in Competition mode?
		bne.s	Sonic_RecordPosCompetition	; if so, branch
		cmpa.w	#Player_1,a0			; is Sonic the sidekick?
		bne.s	locretK_10D9E			; if so, branch
		move.w	(Pos_table_index).w,d0
		lea	(Pos_table).w,a1
		lea	(a1,d0.w),a1
		move.w	x_pos(a0),(a1)+			; write location to pos_table
		move.w	y_pos(a0),(a1)+
		addq.b	#4,(Pos_table_index+1).w	; increment index as the post-increments did a1
		lea	(Stat_table).w,a1
		lea	(a1,d0.w),a1
		move.w	(Ctrl_1_logical).w,(a1)+
	if Sonic3_Alone
		move.w	status(a0),(a1)+
	else
		move.b	status(a0),(a1)+
		move.b	art_tile(a0),(a1)+
	endif
; locret3_11EA4:
locretK_10D9E:
		rts
; ---------------------------------------------------------------------------

Sonic_RecordPosCompetition:
		cmpa.w	#Player_1,a0			; is object player 1?
		bne.s	Sonic_RecordPosCompetitionP2	; if not, branch
		move.w	(Pos_table_index).w,d0
		lea	(Pos_table).w,a1
		lea	(a1,d0.w),a1
		move.w	x_pos(a0),(a1)+			; write location to pos_table
		move.w	y_pos(a0),(a1)+
		addq.b	#4,(Pos_table_index+1).w	; increment index as the post-increments did a1
		rts
; ---------------------------------------------------------------------------

Sonic_RecordPosCompetitionP2:
		move.w	(Pos_table_index_P2).w,d0
		lea	(Pos_table_P2).w,a1
		lea	(a1,d0.w),a1
		move.w	x_pos(a0),(a1)+			; write location to pos_table
		move.w	y_pos(a0),(a1)+
		addq.b	#4,(Pos_table_index_P2+1).w	; increment index as the post-increments did a1
		rts
; End of function Sonic_RecordPos


; =============== S U B R O U T I N E =======================================


Reset_Player_Position_Array:
		cmpa.w	#Player_1,a0			; is object player 1?
		bne.s	Reset_Player_Position_ArrayP2	; if not, branch
		lea	(Pos_table).w,a1
		lea	(Pos_table_P2).w,a2
		move.w	#bytesToLcnt(Pos_table_end-Pos_table),d0

.loop:
		move.w	x_pos(a0),(a1)+			; write location to pos_table
		move.w	y_pos(a0),(a1)+
		move.l	#0,(a2)+
		dbf	d0,.loop
		move.w	#0,(Pos_table_index).w

Reset_Player_Position_ArrayP2:
		tst.w	(Competition_mode).w	; are we in Competition mode?
		beq.s	.return		; if not, branch
		lea	(Pos_table_P2).w,a1
		move.w	#bytesToLcnt(Pos_table_P2_end-Pos_table_P2),d0

.loop:
		move.w	x_pos(a0),(a1)+
		move.w	y_pos(a0),(a1)+
		dbf	d0,.loop
		move.w	#0,(Pos_table_index_P2).w

.return:
		rts
; End of function Reset_Player_Position_Array

; ---------------------------------------------------------------------------
; Subroutine for Sonic when he's underwater
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Sonic_Water:
		tst.b	(Water_flag).w	; does level have water?
		bne.s	Sonic_InWater	; if yes, branch
; locret3_11F32:
locretK_10E2C:
		rts
; ---------------------------------------------------------------------------

Sonic_InWater:
		move.w	(Water_level).w,d0
		cmp.w	y_pos(a0),d0	; is Sonic above the water?
		bge.s	Sonic_OutWater	; if yes, branch

		bset	#Status_Underwater,status(a0)	; set underwater flag
		bne.s	locretK_10E2C	; if already underwater, branch

		addq.b	#1,(Water_entered_counter).w
		movea.l	a0,a1
		bsr.w	Player_ResetAirTimer
		move.l	#Obj_AirCountdown,(Breathing_bubbles).w	; load Sonic's breathing bubbles
		move.b	#$81,(Breathing_bubbles+subtype).w
		move.l	a0,(Breathing_bubbles+objoff_40).w
		move.w	#$300,Max_speed-Max_speed(a4)
		move.w	#6,Acceleration-Max_speed(a4)
		move.w	#$40,Deceleration-Max_speed(a4)
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	locK_10E82		; if Super/Hyper, set different values
		move.w	#$500,Max_speed-Max_speed(a4)
		move.w	#$18,Acceleration-Max_speed(a4)
		move.w	#$80,Deceleration-Max_speed(a4)
; loc3_11F88:
locK_10E82:
		tst.b	object_control(a0)
		bne.s	locretK_10E2C
		asr	x_vel(a0)
		asr	y_vel(a0)		; memory operands can only be shifted one bit at a time
		asr	y_vel(a0)
		beq.s	locretK_10E2C
		move.w	#1<<8,anim(a6)		; splash animation, write 1 to anim and clear prev_anim
		move.w	#sfx_Splash,d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

Sonic_OutWater:
		bclr	#Status_Underwater,status(a0)	; unset underwater flag
		beq.w	locretK_10E2C			; if already above water, branch
		addq.b	#1,(Water_entered_counter).w

		movea.l	a0,a1
		bsr.w	Player_ResetAirTimer
		move.w	#$600,Max_speed-Max_speed(a4)
		move.w	#$C,Acceleration-Max_speed(a4)
		move.w	#$80,Deceleration-Max_speed(a4)
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	locK_10EE0	; if Super/Hyper, set different values
		move.w	#$A00,Max_speed-Max_speed(a4)
		move.w	#$30,Acceleration-Max_speed(a4)
		move.w	#$100,Deceleration-Max_speed(a4)
; loc3_11FE6:
locK_10EE0:
		cmpi.b	#4,routine(a0)	; is Sonic falling back from getting hurt?
		beq.s	locK_10EFC	; if yes, branch
		tst.b	object_control(a0)
		bne.s	locK_10EFC
		move.w	y_vel(a0),d0
		cmpi.w	#-$400,d0
		blt.s	locK_10EFC
		asl	y_vel(a0)
; loc3_12002:
locK_10EFC:
		cmpi.b	#$1C,anim(a0)	; is Sonic in his 'blank' animation?
		beq.w	locretK_10E2C	; if so, branch
		tst.w	y_vel(a0)
		beq.w	locretK_10E2C
		move.w	#1<<8,anim(a6)	; splash animation, write 1 to anim and clear prev_anim
		cmpi.w	#-$1000,y_vel(a0)
		bgt.s	locK_10F22
		move.w	#-$1000,y_vel(a0)	; limit upward y velocity exiting the water
; loc3_12028:
locK_10F22:
		move.w	#sfx_Splash,d0
		jmp	(Play_SFX).l
; End of function Sonic_Water

; ---------------------------------------------------------------------------
; Start of subroutine Obj01_MdNormal
; Called if Sonic is neither airborne nor rolling this frame
; ---------------------------------------------------------------------------

Sonic_MdNormal:
		bsr.w	SonicKnux_Spindash
		bsr.w	Sonic_Jump
		bsr.w	Player_SlopeResist
		bsr.w	Sonic_Move
		bsr.w	SonicKnux_Roll
		bsr.w	Player_LevelBound
	if Sonic3_Alone
		jsr	(MoveSprite2).l
		bsr.w	Player_AnglePos
	else
		jsr	(MoveSprite_TestGravity2).l
		bsr.w	Call_Player_AnglePos
	endif
		bsr.w	Player_SlopeRepel
		tst.b	(Background_collision_flag).w
		beq.s	locretK_10F82
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
		bpl.s	locK_10F72
		sub.w	d1,x_pos(a0)

locK_10F72:
	if Sonic3_Alone
; locret3_1207C:
locretK_10F82:
		rts
	else
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locK_10F7E
		add.w	d1,x_pos(a0)

locK_10F7E:
		movem.l	(sp)+,a4-a6

; locret3_1207C:
locretK_10F82:
		rts

; =============== S U B R O U T I N E =======================================


Call_Player_AnglePos:
		tst.b	(Reverse_gravity_flag).w
		beq.w	Player_AnglePos
		move.b	angle(a0),d0
		addi.b	#$40,d0
		neg.b	d0
		subi.b	#$40,d0
		move.b	d0,angle(a0)
		bsr.w	Player_AnglePos
		move.b	angle(a0),d0
		addi.b	#$40,d0
		neg.b	d0
		subi.b	#$40,d0
		move.b	d0,angle(a0)
		rts
; End of function Call_Player_AnglePos
	endif

; ---------------------------------------------------------------------------
; Start of subroutine Sonic_MdAir
; Called if Sonic is airborne, but not in a ball (thus, probably not jumping)

Sonic_MdAir:
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_ChgJumpDir
		bsr.w	Player_LevelBound
	if Sonic3_Alone
		jsr	(MoveSprite).l
	else
		jsr	(MoveSprite_TestGravity).l
	endif
		btst	#Status_Underwater,status(a0)	; is Sonic underwater?
		beq.s	locK_10FD6			; if not, branch
		subi.w	#$28,y_vel(a0)			; reduce gravity by $28 ($38-$28=$10)
; loc3_1209E:
locK_10FD6:
		bsr.w	Player_JumpAngle
		bsr.w	SonicKnux_DoLevelCollision
		rts
; ---------------------------------------------------------------------------
; Start of subroutine Sonic_MdRoll
; Called if Sonic is in a ball, but not airborne (thus, probably rolling)

Sonic_MdRoll:
		tst.b	spin_dash_flag(a0)
		bne.s	locK_10FEA
		bsr.w	Sonic_Jump

locK_10FEA:
		bsr.w	Player_RollRepel
		bsr.w	Sonic_RollSpeed
		bsr.w	Player_LevelBound
	if Sonic3_Alone
		jsr	(MoveSprite2).l
		bsr.w	Player_AnglePos
	else
		jsr	(MoveSprite_TestGravity2).l
		bsr.w	Call_Player_AnglePos
	endif
		bsr.w	Player_SlopeRepel
		tst.b	(Background_collision_flag).w
		beq.s	locretK_11034
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
		bpl.s	locK_11024
		sub.w	d1,x_pos(a0)

locK_11024:
	if ~~Sonic3_Alone
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locK_11030
		add.w	d1,x_pos(a0)

locK_11030:
		movem.l	(sp)+,a4-a6
	endif
; locret3_120F0:
locretK_11034:
		rts
; ---------------------------------------------------------------------------
; Start of subroutine Sonic_MdJump
; Called if Sonic is in a ball and airborne (he could be jumping but not necessarily)
; Notes: This is identical to Sonic_MdAir, at least at this outer level.
;        Why they gave it a separate copy of the code, I don't know.

Sonic_MdJump:
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_ChgJumpDir
		bsr.w	Player_LevelBound
	if Sonic3_Alone
		jsr	(MoveSprite).l
	else
		jsr	(MoveSprite_TestGravity).l
	endif
		btst	#Status_Underwater,status(a0)	; is Sonic underwater?
		beq.s	locK_11056			; if not, branch
		subi.w	#$28,y_vel(a0)			; reduce gravity by $28 ($38-$28=$10)
; loc3_12112:
locK_11056:
		bsr.w	Player_JumpAngle
		bsr.w	SonicKnux_DoLevelCollision
		rts

; ---------------------------------------------------------------------------
; Subroutine to make Sonic walk/run
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Sonic_Move:
		move.w	Max_speed-Max_speed(a4),d6	; set Max_speed
		move.w	Acceleration-Max_speed(a4),d5	; set Acceleration
		move.w	Deceleration-Max_speed(a4),d4	; set Deceleration
		tst.b	status_secondary(a0)	; is bit 7 set? (Infinite inertia)
		bmi.w	locK_11332		; if so, branch
		tst.w	move_lock(a0)
		bne.w	locK_112EA
		btst	#button_left,(Ctrl_1_held_logical).w	; is left being pressed?
		beq.s	Sonic_NotLeft			; if not, branch
		bsr.w	subK_113F6

Sonic_NotLeft:
		btst	#button_right,(Ctrl_1_held_logical).w	; is right being pressed?
		beq.s	Sonic_NotRight				; if not, branch
		bsr.w	subK_11482

Sonic_NotRight:
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0		; is Sonic on a slope?
		bne.w	locK_112EA	; if yes, branch
		tst.w	ground_vel(a0)	; is Sonic moving?
		bne.w	locK_112EA	; if yes, branch
		bclr	#Status_Push,status(a0)
		move.b	#5,anim(a0)	; use standing animation
		btst	#Status_OnObj,status(a0)
		beq.w	Sonic_Balance
		movea.w	interact(a0),a1	; load interacting object's RAM space
		tst.b	status(a1)	; is status bit 7 set? (unused?)
		bmi.w	locK_11276	; if so, branch

		; Calculations to determine where on the object Sonic is, and make him balance accordingly
		moveq	#0,d1			; Clear d1
		move.b	width_pixels(a1),d1	; Load interacting object's width into d1
		move.w	d1,d2			; Move to d2 for separate calculations
		add.w	d2,d2			; Double object width, converting it to X pos' units of measurement
		subq.w	#2,d2			; Subtract 2: This is the margin for 'on edge'
		add.w	x_pos(a0),d1		; Add Sonic's X position to object width
		sub.w	x_pos(a1),d1		; Subtract object's X position from width+Sonic's X pos, giving you Sonic's distance from left edge of object
		tst.b	(Super_Sonic_Knux_flag).w	; is Sonic Super/Hyper?
		bne.w	SuperSonic_Balance		; if so, branch
		cmpi.w	#2,d1		; is Sonic within two units of object's left edge?
		blt.s	Sonic_BalanceOnObjLeft	; if so, branch
		cmp.w	d2,d1
		bge.s	Sonic_BalanceOnObjRight	; if Sonic is within two units of object's right edge, branch (Realistically, it checks this, and BEYOND the right edge of the object)
		bra.w	locK_11276	; if Sonic is more than 2 units from both edges, branch
; ---------------------------------------------------------------------------

SuperSonic_Balance:
		cmpi.w	#2,d1		; is Sonic within two units of object's left edge?
		blt.w	locK_11268	; if so, branch
		cmp.w	d2,d1
		bge.w	locK_11258	; if Sonic is within two units of object's right edge, branch (Realistically, it checks this, and BEYOND the right edge of the object)
		bra.w	locK_11276	; if Sonic is more than 2 units from both edges, branch
; ---------------------------------------------------------------------------
; balancing checks for when you're on the right edge of an object

Sonic_BalanceOnObjRight:
		btst	#Status_Facing,status(a0)	; is Sonic facing right?
		bne.s	locK_11128			; if so, branch
		move.b	#6,anim(a0)	; Balance animation 1
		addq.w	#6,d2		; extend balance range
		cmp.w	d2,d1		; is Sonic within (two units before and) four units past the right edge?
		blt.w	locK_112EA	; if so, branch
		move.b	#$C,anim(a0)	; if REALLY close to the edge, use different animation (Balance animation 2)
		bra.w	locK_112EA
; loc3_121E4:
locK_11128:
		; Somewhat dummied out/redundant code from Sonic 2
		; Originally, Sonic displayed different animations for each direction faced
		; But now, Sonic uses only the one set of animations no matter what, making the check pointless, and the code redundant
		bclr	#Status_Facing,status(a0)
		move.b	#6,anim(a0)	; Balance animation 1
		addq.w	#6,d2		; extend balance range
		cmp.w	d2,d1		; is Sonic within (two units before and) four units past the right edge?
		blt.w	locK_112EA	; if so, branch
		move.b	#$C,anim(a0)	; if REALLY close to the edge, use different animation (Balance animation 2)
		bra.w	locK_112EA
; ---------------------------------------------------------------------------

Sonic_BalanceOnObjLeft:
		btst	#Status_Facing,status(a0)	; is Sonic facing right?
		beq.s	locK_11166
		move.b	#6,anim(a0)	; Balance animation 1
		cmpi.w	#-4,d1		; is Sonic within (two units before and) four units past the left edge?
		bge.w	locK_112EA	; if so branch (instruction signed to match)
		move.b	#$C,anim(a0)	; if REALLY close to the edge, use different animation (Balance animation 2)
		bra.w	locK_112EA
; loc_12222:
locK_11166:
		; Somewhat dummied out/redundant code from Sonic 2
		; Originally, Sonic displayed different animations for each direction faced
		; But now, Sonic uses only the one set of animations no matter what, making the check pointless, and the code redundant
		bset	#Status_Facing,status(a0)	; is Sonic facing right?
		move.b	#6,anim(a0)	; Balance animation 1
		cmpi.w	#-4,d1		; is Sonic within (two units before and) four units past the left edge?
		bge.w	locK_112EA	; if so branch (instruction signed to match)
		move.b	#$C,anim(a0)	; if REALLY close to the edge, use different animation (Balance animation 2)
		bra.w	locK_112EA
; ---------------------------------------------------------------------------
; balancing checks for when you're on the edge of part of the level

Sonic_Balance:
	if Sonic3_Alone
		jsr	(ChkFloorEdge).l
	else
		move.w	x_pos(a0),d3
		bsr.w	ChooseChkFloorEdge
	endif
		cmpi.w	#$C,d1
		blt.w	locK_11276
		tst.b	(Super_Sonic_Knux_flag).w	; is Sonic Super/Hyper?
		bne.w	locK_11250			; if so, branch
		cmpi.b	#3,next_tilt(a0)
		bne.s	locK_111F6
		btst	#Status_Facing,status(a0)
		bne.s	locK_111CE
		move.b	#6,anim(a0)
		move.w	x_pos(a0),d3
		subq.w	#6,d3
	if Sonic3_Alone
		jsr	(ChkFloorEdge_Part2).l
	else
		bsr.w	ChooseChkFloorEdge
	endif
		cmpi.w	#$C,d1
		blt.w	locK_112EA
		move.b	#$C,anim(a0)
		bra.w	locK_112EA
		; on right edge but facing left:
; loc3_1228A:
locK_111CE:
		; Somewhat dummied out/redundant code from Sonic 2
		; Originally, Sonic displayed different animations for each direction faced
		; But now, Sonic uses only the one set of animations no matter what, making the check pointless, and the code redundant
		bclr	#Status_Facing,status(a0)
		move.b	#6,anim(a0)
		move.w	x_pos(a0),d3
		subq.w	#6,d3
	if Sonic3_Alone
		jsr	(ChkFloorEdge_Part2).l
	else
		bsr.w	ChooseChkFloorEdge
	endif
		cmpi.w	#$C,d1
		blt.w	locK_112EA
		move.b	#$C,anim(a0)
		bra.w	locK_112EA
; ---------------------------------------------------------------------------
; loc3_122B4:
locK_111F6:
		cmpi.b	#3,tilt(a0)
		bne.s	locK_11276
		btst	#Status_Facing,status(a0)
		beq.s	locK_11228
		move.b	#6,anim(a0)
		move.w	x_pos(a0),d3
		addq.w	#6,d3
	if Sonic3_Alone
		jsr	(ChkFloorEdge_Part2).l
	else
		bsr.w	ChooseChkFloorEdge
	endif
		cmpi.w	#$C,d1
		blt.w	locK_112EA
		move.b	#$C,anim(a0)
		bra.w	locK_112EA
; ---------------------------------------------------------------------------
; loc3_122E8:
locK_11228:
		bset	#Status_Facing,status(a0)
		move.b	#6,anim(a0)
		move.w	x_pos(a0),d3
		addq.w	#6,d3
	if Sonic3_Alone
		jsr	(ChkFloorEdge_Part2).l
	else
		bsr.w	ChooseChkFloorEdge
	endif
		cmpi.w	#$C,d1
		blt.w	locK_112EA
		move.b	#$C,anim(a0)
		bra.w	locK_112EA
; ---------------------------------------------------------------------------
; loc3_12312:
locK_11250:
		cmpi.b	#3,next_tilt(a0)
		bne.s	locK_11260
; loc3_1231A:
locK_11258:
		bclr	#Status_Facing,status(a0)
		bra.s	locK_1126E
; ---------------------------------------------------------------------------
; loc3_12322:
locK_11260:
		cmpi.b	#3,tilt(a0)
		bne.s	locK_11276
; loc3_1232A:
locK_11268:
		bset	#Status_Facing,status(a0)
; loc3_12330:
locK_1126E:
		move.b	#6,anim(a0)
		bra.s	locK_112EA
; ---------------------------------------------------------------------------
; loc3_12338:
locK_11276:
	if Sonic3_Alone
		btst	#button_up,(Ctrl_1_held_logical).w
		beq.s	locK_112B0
		move.b	#7,anim(a0)
		addq.b	#1,scroll_delay_counter(a0)
		cmpi.b	#120,scroll_delay_counter(a0)
		blo.s	locK_112F0
		move.b	#120,scroll_delay_counter(a0)
		cmpi.w	#$C8,(a5)
	else
		btst	#button_down,(Ctrl_1_logical).w
		beq.s	locK_112B0
		move.b	#8,anim(a0)
		addq.b	#1,scroll_delay_counter(a0)
		cmpi.b	#120,scroll_delay_counter(a0)
		blo.s	locK_112F0
		move.b	#120,scroll_delay_counter(a0)
		tst.b	(Reverse_gravity_flag).w
		bne.s	locK_112A6
		cmpi.w	#8,(a5)
		beq.s	locK_112FC
		subq.w	#2,(a5)
		bra.s	locK_112FC
; ---------------------------------------------------------------------------

locK_112A6:
		cmpi.w	#$D8,(a5)
	endif
		beq.s	locK_112FC
		addq.w	#2,(a5)
		bra.s	locK_112FC
; ---------------------------------------------------------------------------
; loc3_12338:
locK_112B0:
	if Sonic3_Alone
		btst	#button_down,(Ctrl_1_held_logical).w
		beq.s	locK_112EA
		move.b	#8,anim(a0)
		addq.b	#1,scroll_delay_counter(a0)
		cmpi.b	#120,scroll_delay_counter(a0)
		bcs.s	locK_112F0
		move.b	#120,scroll_delay_counter(a0)
		cmpi.w	#8,(a5)
	else
		btst	#button_up,(Ctrl_1_held_logical).w
		beq.s	locK_112EA
		move.b	#7,anim(a0)
		addq.b	#1,scroll_delay_counter(a0)
		cmpi.b	#120,scroll_delay_counter(a0)
		blo.s	locK_112F0
		move.b	#120,scroll_delay_counter(a0)
		tst.b	(Reverse_gravity_flag).w
		bne.s	locK_112E0
		cmpi.w	#$C8,(a5)
		beq.s	locK_112FC
		addq.w	#2,(a5)
		bra.s	locK_112FC
; ---------------------------------------------------------------------------

locK_112E0:
		cmpi.w	#$18,(a5)
	endif
		beq.s	locK_112FC
		subq.w	#2,(a5)
		bra.s	locK_112FC
; ---------------------------------------------------------------------------
; loc3_1238C:
locK_112EA:
		move.b	#0,scroll_delay_counter(a0)
; loc3_12392:
locK_112F0:
		cmpi.w	#$60,(a5)
		beq.s	locK_112FC
		bcc.s	locK_112FA
		addq.w	#4,(a5)
; loc3_1239C:
locK_112FA:
		subq.w	#2,(a5)
; loc3_1239E:
locK_112FC:
		tst.b	(Super_Sonic_Knux_flag).w
	if Sonic3_Alone
		beq.w	locK_11306
	else
		beq.s	locK_11306
	endif
		move.w	#$C,d5
; loc3_123AA:
locK_11306:
		move.b	(Ctrl_1_held_logical).w,d0
		andi.b	#button_left_mask|button_right_mask,d0
		bne.s	locK_11332
		move.w	ground_vel(a0),d0
		beq.s	locK_11332
		bmi.s	locK_11326
		sub.w	d5,d0
		bcc.s	locK_11320
		move.w	#0,d0
; loc3_123C4:
locK_11320:
		move.w	d0,ground_vel(a0)
		bra.s	locK_11332
; ---------------------------------------------------------------------------
; loc3_123CA:
locK_11326:
		add.w	d5,d0
		bcc.s	locK_1132E
		move.w	#0,d0
; loc3_123D2:
locK_1132E:
		move.w	d0,ground_vel(a0)
; loc3_123D6:
locK_11332:
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	ground_vel(a0),d1
		asr.l	#8,d1
		move.w	d1,x_vel(a0)
		muls.w	ground_vel(a0),d0
		asr.l	#8,d0
		move.w	d0,y_vel(a0)
; loc3_123F4:
locK_11350:
		btst	#6,object_control(a0)
		bne.w	locretK_113F4
	if ~~Sonic3_Alone
		; This was added to S&K to prevent an issue where Sonic could run through walls
		; if he is upside-down, or moving on a wall if his angle is exactly $80. This issue
		; can be seen in S3 alone's Carnival Night Zone if you jump onto a curved ceiling.
		move.b	angle(a0),d0
		andi.b	#$3F,d0
		beq.s	locK_11370
	endif
		move.b	angle(a0),d0
		addi.b	#$40,d0
	if Sonic3_Alone
		bmi.s	locretK_113F4
	else
		bmi.w	locretK_113F4
	endif

locK_11370:
		move.b	#$40,d1
		tst.w	ground_vel(a0)
		beq.s	locretK_113F4
		bmi.s	locK_1137E
		neg.w	d1
; loc3_12416:
locK_1137E:
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
		bpl.s	locretK_113F4
		asl.w	#8,d1
	if ~~Sonic3_Alone
		cmpi.b	#8,(Current_zone).w
		bne.s	locK_113A0
		tst.b	d0
		bpl.s	locK_113A0
		subq.b	#1,d0

locK_113A0:
	endif
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	locK_113F0
		cmpi.b	#$40,d0
		beq.s	locK_113D6
		cmpi.b	#$80,d0
		beq.s	locK_113D0
		add.w	d1,x_vel(a0)
		move.w	#0,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		bne.s	locretK_113CE
		bset	#Status_Push,status(a0)
; locret3_12458:
locretK_113CE:
		rts
; ---------------------------------------------------------------------------
; loc3_1245A:
locK_113D0:
		sub.w	d1,y_vel(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_12460:
locK_113D6:
		sub.w	d1,x_vel(a0)
		move.w	#0,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		beq.s	locretK_113CE
		bset	#Status_Push,status(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_1247A:
locK_113F0:
		add.w	d1,y_vel(a0)
; locret3_1247E:
locretK_113F4:
		rts
; End of function Sonic_Move


; =============== S U B R O U T I N E =======================================

; sub3_12480:
subK_113F6:
		move.w	ground_vel(a0),d0
		beq.s	locK_113FE
		bpl.s	locK_11430
; loc3_12488:
locK_113FE:
		bset	#Status_Facing,status(a0)
		bne.s	locK_11412
		bclr	#Status_Push,status(a0)
		move.b	#1,prev_anim(a0)
; loc3_1249C:
locK_11412:
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	locK_11424
		add.w	d5,d0
		cmp.w	d1,d0
		ble.s	locK_11424
		move.w	d1,d0
; loc3_124AE:
locK_11424:
		move.w	d0,ground_vel(a0)
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_124BA:
locK_11430:
		sub.w	d4,d0
		bcc.s	locK_11438
		move.w	#-$80,d0
; loc3_124C2:
locK_11438:
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
		bne.s	locretK_11480
		cmpi.w	#$400,d0
		blt.s	locretK_11480
		tst.b	flip_type(a0)
		bmi.s	locretK_11480
		move.w	#sfx_Skid,d0
		jsr	(Play_SFX).l
		move.b	#$D,anim(a0)
		bclr	#Status_Facing,status(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	locretK_11480
		move.b	#6,routine(a6)
		move.b	#$15,mapping_frame(a6)
; locret3_1250A:
locretK_11480:
		rts
; End of function subK_113F6


; =============== S U B R O U T I N E =======================================

; sub3_1250C:
subK_11482:
		move.w	ground_vel(a0),d0
		bmi.s	locK_114B6
		bclr	#Status_Facing,status(a0)
		beq.s	locK_1149C
		bclr	#Status_Push,status(a0)
		move.b	#1,prev_anim(a0)
; loc3_12526:
locK_1149C:
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	locK_114AA
		sub.w	d5,d0
		cmp.w	d6,d0
		bge.s	locK_114AA
		move.w	d6,d0
; loc3_12534:
locK_114AA:
		move.w	d0,ground_vel(a0)
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_12540:
locK_114B6:
		add.w	d4,d0
		bcc.s	locK_114BE
		move.w	#$80,d0
; loc3_12548:
locK_114BE:
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
		bne.s	locretK_11506
		cmpi.w	#-$400,d0
		bgt.s	locretK_11506
		tst.b	flip_type(a0)
		bmi.s	locretK_11506
		move.w	#sfx_Skid,d0
		jsr	(Play_SFX).l
		move.b	#$D,anim(a0)
		bset	#Status_Facing,status(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	locretK_11506
		move.b	#6,routine(a6)
		move.b	#$15,mapping_frame(a6)
; locret3_12590:
locretK_11506:
		rts
; End of function subK_11482


; =============== S U B R O U T I N E =======================================


Sonic_RollSpeed:
		move.w	Max_speed-Max_speed(a4),d6
		asl.w	#1,d6
		move.w	Acceleration-Max_speed(a4),d5
		asr.w	#1,d5
	if ~~Sonic3_Alone
		; This was added in Sonic & Knuckles, likely since rolling would cause
		; him to decelerate unusually fast due to the above code.
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	locK_1151C
		move.w	#6,d5

locK_1151C:
	endif
		move.w	#$20,d4
		tst.b	spin_dash_flag(a0)
		bmi.w	locK_115C6
		tst.b	status_secondary(a0)
		bmi.w	locK_115C6
		tst.w	move_lock(a0)
		bne.s	locK_1154E
		btst	#button_left,(Ctrl_1_logical).w
		beq.s	locK_11542
		bsr.w	subK_11608
; loc3_125C2:
locK_11542:
		btst	#button_right,(Ctrl_1_logical).w
		beq.s	locK_1154E
		bsr.w	subK_1162C
; loc3_125CE:
locK_1154E:
		move.w	ground_vel(a0),d0
		beq.s	locK_11570
		bmi.s	locK_11564
		sub.w	d5,d0
		bcc.s	locK_1155E
		move.w	#0,d0
; loc3_125DE:
locK_1155E:
		move.w	d0,ground_vel(a0)
		bra.s	locK_11570
; ---------------------------------------------------------------------------
; loc3_125E4:
locK_11564:
		add.w	d5,d0
		bcc.s	locK_1156C
		move.w	#0,d0
; loc3_125EC:
locK_1156C:
		move.w	d0,ground_vel(a0)
; loc3_125F0:
locK_11570:
	if Sonic3_Alone
		tst.w	ground_vel(a0)
		bne.s	locK_115C6
	else
		move.w	ground_vel(a0),d0
		bpl.s	locK_11578
		neg.w	d0

locK_11578:
		cmpi.w	#$80,d0
		bhs.s	locK_115C6
	endif
		tst.b	spin_dash_flag(a0)
		bne.s	locK_115B4
		bclr	#Status_Roll,status(a0)
		move.b	y_radius(a0),d0
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
		move.b	#5,anim(a0)
		sub.b	default_y_radius(a0),d0
		ext.w	d0
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_115AE
		neg.w	d0

locK_115AE:
	endif
		add.w	d0,y_pos(a0)
		bra.s	locK_115C6
; ---------------------------------------------------------------------------
; loc3_12624:
locK_115B4:
		move.w	#$400,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		beq.s	locK_115C6
		neg.w	ground_vel(a0)
; loc3_12636:
locK_115C6:
		cmpi.w	#$60,(a5)
		beq.s	locK_115D2
		bcc.s	locK_115D0
		addq.w	#4,(a5)
; loc3_12640:
locK_115D0:
		subq.w	#2,(a5)
; loc3_12642:
locK_115D2:
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	ground_vel(a0),d0
		asr.l	#8,d0
		move.w	d0,y_vel(a0)
		muls.w	ground_vel(a0),d1
		asr.l	#8,d1
		cmpi.w	#$1000,d1
		ble.s	locK_115F6
		move.w	#$1000,d1
; loc3_12666:
locK_115F6:
		cmpi.w	#-$1000,d1
		bge.s	locK_11600
		move.w	#-$1000,d1
; loc3_12670:
locK_11600:
		move.w	d1,x_vel(a0)
		bra.w	locK_11350
; End of function Sonic_RollSpeed


; =============== S U B R O U T I N E =======================================

; sub3_12678:
subK_11608:
		move.w	ground_vel(a0),d0
		beq.s	locK_11610
		bpl.s	locK_1161E
; loc3_12680:
locK_11610:
		bset	#Status_Facing,status(a0)
		move.b	#2,anim(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_1268E:
locK_1161E:
		sub.w	d4,d0
		bcc.s	locK_11626
		move.w	#-$80,d0
; loc3_12696:
locK_11626:
		move.w	d0,ground_vel(a0)
		rts
; End of function subK_11608


; =============== S U B R O U T I N E =======================================

; sub3_1269C:
subK_1162C:
		move.w	ground_vel(a0),d0
		bmi.s	locK_11640
		bclr	#Status_Facing,status(a0)
		move.b	#2,anim(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_126B0:
locK_11640:
		add.w	d4,d0
		bcc.s	locK_11648
		move.w	#$80,d0
; loc3_126B8:
locK_11648:
		move.w	d0,ground_vel(a0)
		rts
; End of function subK_1162C

; ---------------------------------------------------------------------------
; Subroutine for moving Sonic left or right when he's in the air
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Sonic_ChgJumpDir:
		move.w	Max_speed-Max_speed(a4),d6
		move.w	Acceleration-Max_speed(a4),d5
		asl.w	#1,d5
		btst	#Status_RollJump,status(a0)		; did Sonic jump from rolling?
		bne.s	Sonic_Jump_ResetScr	; if yes, branch to skip midair control
		move.w	x_vel(a0),d0
		btst	#button_left,(Ctrl_1_held_logical).w
		beq.s	locK_11682	; if not holding left, branch

		bset	#Status_Facing,status(a0)
		sub.w	d5,d0	; add acceleration to the left
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0	; compare new speed with top speed
		bgt.s	locK_11682	; if new speed is less than the maximum, branch
		add.w	d5,d0		; remove this frame's acceleration change
		cmp.w	d1,d0		; compare speed with top speed
		ble.s	locK_11682	; if speed was already greater than the maximum, branch
		move.w	d1,d0
; loc3_126F2:
locK_11682:
		btst	#button_right,(Ctrl_1_held_logical).w
		beq.s	locK_1169E	; if not holding right, branch

		bclr	#Status_Facing,status(a0)
		add.w	d5,d0	; accelerate right in the air
		cmp.w	d6,d0	; compare new speed with top speed
		blt.s	locK_1169E	; if new speed is less than the maximum, branch
		sub.w	d5,d0		; remove this frame's acceleration change
		cmp.w	d6,d0		; compare speed with top speed
		bge.s	locK_1169E	; if speed was already greater than the maximum, branch
		move.w	d6,d0
; loc3_1270E:
locK_1169E:
		move.w	d0,x_vel(a0)

Sonic_Jump_ResetScr:
		cmpi.w	#$60,(a5)	; is screen in its default position?
		beq.s	Sonic_JumpPeakDecelerate	; if yes, branch
		bhs.s	locK_116AC	; depending on the sign of the difference,
		addq.w	#4,(a5)		; either add 2
; loc3_1271C:
locK_116AC:
		subq.w	#2,(a5)		; or subtract 2

Sonic_JumpPeakDecelerate:
		cmpi.w	#-$400,y_vel(a0)	; is Sonic moving faster than -$400 upwards?
		blo.s	locretK_116DC		; if yes, return
		move.w	x_vel(a0),d0
		move.w	d0,d1
		asr.w	#5,d1		; d1 = x_velocity / 32
		beq.s	locretK_116DC	; return if d1 is 0
		bmi.s	Sonic_JumpPeakDecelerateLeft	; branch if moving left

		sub.w	d1,d0	; reduce x velocity by d1
		bcc.s	locK_116CA
		move.w	#0,d0
; loc3_1273A:
locK_116CA:
		move.w	d0,x_vel(a0)
		rts
; ---------------------------------------------------------------------------

Sonic_JumpPeakDecelerateLeft:
		sub.w	d1,d0	; reduce x velocity by d1
		bcs.s	locK_116D8
		move.w	#0,d0
; loc3_12748:
locK_116D8:
		move.w	d0,x_vel(a0)
; locret3_1274C:
locretK_116DC:
		rts
; End of function Sonic_ChgJumpDir


; ---------------------------------------------------------------------------
; Subroutine to prevent Sonic from leaving the boundaries of a level
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Player_LevelBound:
		move.l	x_pos(a0),d1
		move.w	x_vel(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d1
		swap	d1
		move.w	(Camera_min_X_pos).w,d0
		addi.w	#$10,d0
		cmp.w	d1,d0			; has Sonic touched the left boundary?
		bhi.s	Player_Boundary_Sides	; if yes, branch
		move.w	(Camera_max_X_pos).w,d0
		addi.w	#$128,d0
		cmp.w	d1,d0
	if Sonic3_Alone
		bls.s	Player_Boundary_Sides
	else
		blo.s	Player_Boundary_Sides
	endif

Player_Boundary_CheckBottom:
		tst.b	(Disable_death_plane).w
		bne.s	locretK_11720
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		bne.s	locK_11722
	endif
		move.w	(Camera_max_Y_pos).w,d0
		addi.w	#$E0,d0
		cmp.w	y_pos(a0),d0		; has Sonic touched the bottom boundary?
		blt.s	Player_Boundary_Bottom	; if yes, branch
; locret3_1278A:
locretK_11720:
		rts
; ---------------------------------------------------------------------------
	if ~~Sonic3_Alone
locK_11722:
		move.w	(Camera_min_Y_pos).w,d0
		cmp.w	y_pos(a0),d0
		blt.s	locretK_11720
	endif

Player_Boundary_Bottom:
		jmp	(Kill_Character).l
; ---------------------------------------------------------------------------

Player_Boundary_Sides:
		move.w	d0,x_pos(a0)
		move.w	#0,2+x_pos(a0)	; subpixel x
		move.w	#0,x_vel(a0)
		move.w	#0,ground_vel(a0)
		bra.s	Player_Boundary_CheckBottom
; End of function Player_LevelBound


; =============== S U B R O U T I N E =======================================


SonicKnux_Roll:
		tst.b	status_secondary(a0)
		bmi.s	locretK_1177E
	if ~~Sonic3_Alone
		move.b	(Ctrl_1_held_logical).w,d0
		andi.b	#button_left_mask|button_right_mask,d0	; is left/right being pressed?
		bne.s	locretK_1177E	; if yes, branch
		btst	#button_down,(Ctrl_1_logical).w	; is down being pressed?
		beq.s	Player_ChkWalk			; if not, branch
	endif
		move.w	ground_vel(a0),d0
		bpl.s	locK_1176A
		neg.w	d0
; loc3_127B8:
locK_1176A:
	if Sonic3_Alone
		cmpi.w	#$80,d0		; is Sonic moving at $80 speed or faster?
		blo.s	locretK_1177E		; if so, branch
		move.b	(Ctrl_1_held_logical).w,d0
		andi.b	#button_left_mask|button_right_mask,d0	; is left/right being pressed?
		bne.s	locretK_1177E	; if yes, branch
		btst	#button_down,(Ctrl_1_held_logical).w	; is down being pressed?
		bne.s	Player_ChkRoll			; if not, branch
	else
		cmpi.w	#$100,d0		; is Sonic moving at $100 speed or faster?
		bhs.s	Player_ChkRoll		; if so, branch
		btst	#Status_OnObj,status(a0)
		bne.s	locretK_1177E
		move.b	#8,anim(a0)	; enter ducking animation
	endif

; locret3_127D0:
locretK_1177E:
		rts
; ---------------------------------------------------------------------------
	if ~~Sonic3_Alone
Player_ChkWalk:
		cmpi.b	#8,anim(a0)	; is Sonic ducking?
		bne.s	locretK_1177E
		move.b	#0,anim(a0)	; if so, enter walking animation
		rts
	endif
; ---------------------------------------------------------------------------

Player_ChkRoll:
		btst	#Status_Roll,status(a0)	; is Sonic already rolling?
		beq.s	Player_DoRoll	; if not, branch
		rts
; ---------------------------------------------------------------------------

Player_DoRoll:
		bset	#Status_Roll,status(a0)
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)	; enter roll animation
		addq.w	#5,y_pos(a0)
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_117C2
		subi.w	#2*5,y_pos(a0)

locK_117C2:
	endif
		move.w	#sfx_Roll,d0
		jsr	(Play_SFX).l
		tst.w	ground_vel(a0)
		bne.s	locretK_117D8
		move.w	#$200,ground_vel(a0)
; locret3_1280E:
locretK_117D8:
		rts
; End of function SonicKnux_Roll


; ---------------------------------------------------------------------------
; Subroutine allowing Sonic to jump
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Sonic_Jump:
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0	; is A, B or C pressed?
		beq.w	locretK_118B2	; if not, return
		moveq	#0,d0
		move.b	angle(a0),d0
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_117FC
		addi.b	#$40,d0
		neg.b	d0
		subi.b	#$40,d0

locK_117FC:
	endif
		addi.b	#$80,d0
		movem.l	a4-a6,-(sp)
		bsr.w	CalcRoomOverHead
		movem.l	(sp)+,a4-a6
		cmpi.w	#6,d1			; does Sonic have enough room to jump?
		blt.w	locretK_118B2		; if not, branch
		move.w	#$680,d2
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	locK_11822
		move.w	#$800,d2	; set higher jump speed if super
; loc3_12848:
locK_11822:
		btst	#Status_Underwater,status(a0)	; Test if underwater
		beq.s	locK_1182E
		move.w	#$380,d2	; set lower jump speed if under
; loc3_12854:
locK_1182E:
		moveq	#0,d0
		move.b	angle(a0),d0
		subi.b	#$40,d0
		jsr	(GetSineCosine).l
		muls.w	d2,d1
		asr.l	#8,d1
		add.w	d1,x_vel(a0)	; make Sonic jump (in X... this adds nothing on level ground)
		muls.w	d2,d0
		asr.l	#8,d0
		add.w	d0,y_vel(a0)	; make Sonic jump (in Y)
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
		bne.s	Sonic_RollJump
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)	; use "jumping" animation
		bset	#Status_Roll,status(a0)
		move.b	y_radius(a0),d0
		sub.b	default_y_radius(a0),d0
		ext.w	d0
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_118AE
		neg.w	d0

locK_118AE:
	endif
		sub.w	d0,y_pos(a0)
; locret3_128D0:
locretK_118B2:
		rts
; ---------------------------------------------------------------------------

Sonic_RollJump:
		bset	#Status_RollJump,status(a0)	; set the rolling+jumping flag
		rts
; End of function Sonic_Jump


; =============== S U B R O U T I N E =======================================

Sonic_JumpHeight:
		tst.b	jumping(a0)	; is Sonic jumping?
		beq.s	Sonic_UpVelCap	; if not, branch

		move.w	#-$400,d1
		btst	#Status_Underwater,status(a0)	; is Sonic underwater?
		beq.s	locK_118D2			; if not, branch
		move.w	#-$200,d1			; Underwater-specific
; loc3_128F0:
locK_118D2:
		cmp.w	y_vel(a0),d1		; is y speed greater than 4? (2 if underwater)
		ble.w	Sonic_ShieldMoves	; if not, branch
		move.b	(Ctrl_1_held_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0	; are buttons A, B or C being pressed?
		bne.s	locretK_118E8		; if yes, branch
		move.w	d1,y_vel(a0)		; cap jump height
; locret3_12906:
locretK_118E8:
		rts
; ---------------------------------------------------------------------------

Sonic_UpVelCap:
		tst.b	spin_dash_flag(a0)	; is Sonic charging his spin dash?
		bne.s	locretK_118FE		; if yes, branch
		cmpi.w	#-$FC0,y_vel(a0)	; is Sonic's Y speed faster (less than) than -15.75 (-$FC0)?
		bge.s	locretK_118FE		; if not, branch
		move.w	#-$FC0,y_vel(a0)	; cap upward speed
; locret3_1291C:
locretK_118FE:
		rts
; ---------------------------------------------------------------------------

Sonic_ShieldMoves:
		tst.b	double_jump_flag(a0)		; is Sonic currently performing a double jump?
		bne.w	locretK_11A14			; if yes, branch
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0	; are buttons A, B, or C being pressed?
		beq.w	locretK_11A14			; if not, branch
		bclr	#Status_RollJump,status(a0)
		tst.b	(Super_Sonic_Knux_flag).w	; check Super-state
		beq.s	Sonic_FireShield		; if not in a super-state, branch
	if ~~Sonic3_Alone
		bmi.w	Sonic_HyperDash			; if Hyper, branch
	endif
		move.b	#1,double_jump_flag(a0)
		rts
; ---------------------------------------------------------------------------

Sonic_FireShield:
		btst	#Status_Invincible,status_secondary(a0)	; first, does Sonic have invincibility?
		bne.w	locretK_11A14				; if yes, branch
		btst	#Status_FireShield,status_secondary(a0)	; does Sonic have a Fire Shield?
		beq.s	Sonic_LightningShield			; if not, branch
		move.b	#1,(Shield+anim).w
		move.b	#1,double_jump_flag(a0)
		move.w	#$800,d0
		btst	#Status_Facing,status(a0)		; is Sonic facing left?
		beq.s	locK_11958				; if not, branch
		neg.w	d0					; reverse speed value, moving Sonic left
; loc3_12972:
locK_11958:
		move.w	d0,x_vel(a0)		; apply velocity...
		move.w	d0,ground_vel(a0)	; ...both ground and air
		move.w	#0,y_vel(a0)		; kill y-velocity
		move.w	#$2000,(H_scroll_frame_offset).w
		bsr.w	Reset_Player_Position_Array
		move.w	#sfx_FireAttack,d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

Sonic_LightningShield:
		btst	#Status_LtngShield,status_secondary(a0)	; does Sonic have a Lightning Shield?
		beq.s	Sonic_BubbleShield			; if not, branch
		move.b	#1,(Shield+anim).w
		move.b	#1,double_jump_flag(a0)
		move.w	#-$580,y_vel(a0)	; bounce Sonic up, creating the double jump effect
		clr.b	jumping(a0)
		move.w	#sfx_ElectricAttack,d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

Sonic_BubbleShield:
		btst	#Status_BublShield,status_secondary(a0)	; does Sonic have a Bubble Shield?
		beq.s	Sonic_CheckTransform			; if not, branch
		move.b	#1,(Shield+anim).w
		move.b	#1,double_jump_flag(a0)
		move.w	#0,x_vel(a0)		; halt horizontal speed...
		move.w	#0,ground_vel(a0)	; ...both ground and air
		move.w	#$800,y_vel(a0)		; force Sonic down
		move.w	#sfx_BubbleAttack,d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------
; Code that transforms Sonic into Super/Hyper Sonic
; if he has enough rings and emeralds
; ---------------------------------------------------------------------------

Sonic_CheckTransform:
	if Sonic3_Alone
		cmpi.w	#7,(Chaos_emerald_count).w	; does Sonic have all 7 Chaos Emeralds?
		blo.s	Sonic_InstaShield		; if not, branch
	else
		cmpi.b	#7,(Super_emerald_count).w	; does Sonic have all 7 Super Emeralds?
		bhs.s	locK_119E8			; if yes, branch
		cmpi.b	#7,(Chaos_emerald_count).w	; does Sonic have all 7 Chaos Emeralds?
		blo.s	Sonic_InstaShield		; if not, branch
		tst.b	(Emeralds_converted_flag).w
		bne.s	Sonic_InstaShield

locK_119E8:
	endif
		cmpi.w	#50,(Ring_count).w	; does Sonic have at least 50 rings?
		blo.s	Sonic_InstaShield	; if not, perform Insta-Shield
		tst.b	(Update_HUD_timer).w
		bne.s	Sonic_Transform

Sonic_InstaShield:
		btst	#Status_Shield,status_secondary(a0)	; does Sonic have an S2 shield? (the elementals were already filtered out at this point)
		bne.s	locretK_11A14				; if yes, branch
		move.b	#1,(Shield+anim).w
		move.b	#1,double_jump_flag(a0)
		move.w	#sfx_InstaAttack,d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------
; locret3_12A20:
locretK_11A14:
		rts
; ---------------------------------------------------------------------------

Sonic_Transform:
		move.b	#1,(Super_palette_status).w	; set Super/Hyper palette status to 'fading'
		move.b	#$F,(Palette_timer).w
	if Sonic3_Alone
		move.b	#1,(Super_Sonic_Knux_flag).w		; set flag to Super Sonic
	endif
		move.w	#60,(Super_frame_count).w
		move.l	#Map_SuperSonic,mappings(a0)
		move.b	#$81,object_control(a0)
		move.b	#$1F,anim(a0)				; enter 'transformation' animation
	if Sonic3_Alone
		move.l	#Obj_SuperSonic_Stars,(Super_stars).w	; load Super Stars object
	else
		cmpi.b	#7,(Super_emerald_count).w		; does Sonic have all 7 Super Emeralds?
		blo.s	.super					; if not, turn Super

		move.b	#-1,(Super_Sonic_Knux_flag).w		; set flag to Hyper Sonic
		move.l	#Obj_HyperSonic_Stars,(Invincibility_stars).w	; load Hyper Stars object
		move.l	#Obj_HyperSonicKnux_Trail,(Super_stars).w	; load After-Images object
		bra.s	.continued
; ---------------------------------------------------------------------------

	.super:
		move.b	#1,(Super_Sonic_Knux_flag).w		; set flag to Super Sonic
		move.l	#Obj_SuperSonicKnux_Stars,(Super_stars).w	; load Super Stars object
	endif

	.continued:
		move.w	#$A00,Max_speed-Max_speed(a4)
		move.w	#$30,Acceleration-Max_speed(a4)
		move.w	#$100,Deceleration-Max_speed(a4)
		move.b	#0,invincibility_timer(a0)
		bset	#Status_Invincible,status_secondary(a0)
	if Sonic3_Alone
		move.w	#signextendB(sfx_SuperTransform),d0
		jsr	(Play_SFX).l
		move.w	#signextendB(mus_Invincibility),d0		; play invincibility theme
		jmp	(Play_Music).l
	else
		moveq	#signextendB(sfx_SuperTransform),d0
		jsr	(Play_SFX).l
		moveq	#signextendB(mus_Invincibility),d0		; play invincibility theme
		jmp	(Play_Music).l
	endif
; ---------------------------------------------------------------------------
	if ~~Sonic3_Alone
Sonic_HyperDash:
		bsr.w	HyperAttackTouchResponse
		move.w	#$2000,(H_scroll_frame_offset).w
		bsr.w	Reset_Player_Position_Array
		move.b	#1,double_jump_flag(a0)
		move.b	#1,(Invincibility_stars+anim).w	; This causes the screen flash, and sparks to come out of Sonic
		moveq	#signextendB(sfx_Dash),d0
		jsr	(Play_SFX).l
		move.b	(Ctrl_1_logical).w,d0
		andi.w	#button_up_mask|button_down_mask|button_left_mask|button_right_mask,d0	; Get D-pad input
		beq.s	.noInput
		; Any values totaling $B or above are produced by holding
		; both opposing directions on the D-pad, which is invalid
		cmpi.b	#$B,d0
		bhs.s	.noInput
		lsl.w	#2,d0
		lea	Sonic_HyperDash_Velocities-4(pc,d0.w),a1
		move.w	(a1)+,d0
		move.w	d0,x_vel(a0)
		move.w	d0,ground_vel(a0)
		move.w	(a1)+,d0
		move.w	d0,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

	.noInput:
		; If there's no directional input, we just dash forward
		move.w	#$800,d0	; Go right...
		btst	#Status_Facing,status(a0)	; ...unless Sonic is facing left...
		beq.s	.applySpeeds
		neg.w	d0		; ...in which case, go left

	.applySpeeds:
		move.w	d0,x_vel(a0)
		move.w	d0,ground_vel(a0)
		move.w	#0,y_vel(a0)
		rts
; End of function Sonic_JumpHeight

; ---------------------------------------------------------------------------
Sonic_HyperDash_Velocities:
		dc.w      0, -$800	; up
		dc.w      0,  $800	; down
		dc.w      0,     0	; up + down (shouldn't happen)
		dc.w  -$800,     0	; left
		dc.w  -$800, -$800	; left + up
		dc.w  -$800,  $800	; left + down
		dc.w      0,     0	; left + up + down (shouldn't happen)
		dc.w   $800,     0	; right
		dc.w   $800, -$800	; right + up
		dc.w   $800,  $800	; right + down
		; Everything after this would be bad button combinations
; ---------------------------------------------------------------------------

Tails_Super:
		tst.b	(Super_Tails_flag).w
		beq.w	SonicKnux_SuperHyper.return
		bra.s	SonicKnux_SuperHyper.continued
	endif

; =============== S U B R O U T I N E =======================================


SonicKnux_SuperHyper:
		tst.b	(Super_Sonic_Knux_flag).w
		beq.w	.return		; If not Super/Hyper, return

	.continued:
		tst.b	(Update_HUD_timer).w	; Level over?
		beq.s	.revertToNormal
		subq.w	#1,(Super_frame_count).w
	if FixBugs
		bhi.w	.return
	else
		; Bug: This should be a 'bhi'; currently counts down 61 frames
		bpl.w	.return
	endif
		move.w	#60,(Super_frame_count).w
		tst.w	(Ring_count).w
		beq.s	.revertToNormal	; If rings depleted, return to normal
		; This checks if the ring counter needs to be blanked
		; for example, this ticks '10' down to ' 9' instead of '19' (yes, this does happen)
		ori.b	#1,(Update_HUD_ring_count).w	; Update ring counter
		cmpi.w	#1,(Ring_count).w
		beq.s	.resetHUD
		cmpi.w	#10,(Ring_count).w
		beq.s	.resetHUD
		cmpi.w	#100,(Ring_count).w
		bne.s	.updateHUD

	.resetHUD:
		ori.b	#$80,(Update_HUD_ring_count).w	; Re-init ring counter

	.updateHUD:
		subq.w	#1,(Ring_count).w
		bne.s	.return	; If rings aren't depleted, we're done here
		; If rings depleted, return to normal

	.revertToNormal:
		move.b	#2,(Super_palette_status).w
		move.w	#$1E,(Palette_frame).w
		move.b	#0,(Super_Sonic_Knux_flag).w
	if ~~Sonic3_Alone
		move.b	#0,(Super_Tails_flag).w
	endif
		move.b	#-1,(Player_prev_frame).w
	if ~~Sonic3_Alone
		tst.b	character_id(a0)	; Is this Sonic?
		bne.s	.notSonic
	endif
		move.l	#Map_Sonic,mappings(a0)	; If so, load Sonic's normal mappings (was using Super/Hyper mappings)

	.notSonic:
		move.b	#1,prev_anim(a0)
		move.b	#1,invincibility_timer(a0)
		move.w	#$600,Max_speed-Max_speed(a4)
		move.w	#$C,Acceleration-Max_speed(a4)
		move.w	#$80,Deceleration-Max_speed(a4)
		btst	#Status_Underwater,status(a0)
		beq.s	.return
		; If underwater, apply corrected speed/acceleration/deceleration
		move.w	#$300,Max_speed-Max_speed(a4)
		move.w	#6,Acceleration-Max_speed(a4)
		move.w	#$40,Deceleration-Max_speed(a4)

	.return:
		rts
; End of function SonicKnux_SuperHyper


; =============== S U B R O U T I N E =======================================


SonicKnux_Spindash:
		tst.b	spin_dash_flag(a0)
		bne.s	locK_11C5E
		cmpi.b	#8,anim(a0)
		bne.s	locretK_11C5C
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locretK_11C5C
		move.b	#9,anim(a0)
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addq.l	#4,sp
		move.b	#1,spin_dash_flag(a0)
		move.w	#0,spin_dash_counter(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	locK_11C24
		move.b	#2,anim(a6)
; loc3_12B6E:
locK_11C24:
		bsr.w	Player_LevelBound
	if Sonic3_Alone
		bsr.w	Player_AnglePos
	else
		bsr.w	Call_Player_AnglePos
	endif
		tst.b	(Background_collision_flag).w
		beq.s	locretK_11C5C
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
		bpl.s	locK_11C4C
		sub.w	d1,x_pos(a0)

locK_11C4C:
	if ~~Sonic3_Alone
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locK_11C58
		add.w	d1,x_pos(a0)

locK_11C58:
		movem.l	(sp)+,a4-a6
	endif

; locret_12B9A:
locretK_11C5C:
		rts
; ---------------------------------------------------------------------------
; loc3_12B9C:
locK_11C5E:
		move.b	(Ctrl_1_held_logical).w,d0
		btst	#button_down,d0
		bne.w	locK_11D16
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#5,y_pos(a0)
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_11C8C
		subi.w	#5*2,y_pos(a0)

locK_11C8C:
	endif
		move.b	#0,spin_dash_flag(a0)
		moveq	#0,d0
		move.b	spin_dash_counter(a0),d0
		add.w	d0,d0
		move.w	wordK_11CF2(pc,d0.w),ground_vel(a0)
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	locK_11CAC
		move.w	wordK_11D04(pc,d0.w),ground_vel(a0)
; loc3_12BDE:
locK_11CAC:
		move.w	ground_vel(a0),d0
		subi.w	#$800,d0
		add.w	d0,d0
		andi.w	#$1F00,d0
		neg.w	d0
		addi.w	#$2000,d0
		lea	(H_scroll_frame_offset).w,a1
		cmpa.w	#Player_1,a0
		beq.s	locK_11CCE
		lea	(H_scroll_frame_offset_P2).w,a1
; loc3_12C00:
locK_11CCE:
		move.w	d0,(a1)
		btst	#Status_Facing,status(a0)
		beq.s	locK_11CDC
		neg.w	ground_vel(a0)
; loc3_12C0E:
locK_11CDC:
		bset	#Status_Roll,status(a0)
		move.b	#0,anim(a6)
		moveq	#signextendB(sfx_Dash),d0
		jsr	(Play_SFX).l
		bra.s	locK_11D5E
; ---------------------------------------------------------------------------
; word3_12C24:
wordK_11CF2:
		dc.w   $800
		dc.w   $880
		dc.w   $900
		dc.w   $980
		dc.w   $A00
		dc.w   $A80
		dc.w   $B00
		dc.w   $B80
		dc.w   $C00
; word3_12C36:
wordK_11D04:
		dc.w   $B00
		dc.w   $B80
		dc.w   $C00
		dc.w   $C80
		dc.w   $D00
		dc.w   $D80
		dc.w   $E00
		dc.w   $E80
		dc.w   $F00
; ---------------------------------------------------------------------------
; loc3_12C48:
locK_11D16:
		tst.w	spin_dash_counter(a0)
		beq.s	locK_11D2E
		move.w	spin_dash_counter(a0),d0
		lsr.w	#5,d0
		sub.w	d0,spin_dash_counter(a0)
		bcc.s	locK_11D2E
		move.w	#0,spin_dash_counter(a0)
; loc3_12C60:
locK_11D2E:
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locK_11D5E
		move.w	#9<<8,anim(a0)	; and prev_anim
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addi.w	#$200,spin_dash_counter(a0)
		cmpi.w	#$800,spin_dash_counter(a0)
		blo.s	locK_11D5E
		move.w	#$800,spin_dash_counter(a0)
; loc3_12C90:
locK_11D5E:
		addq.l	#4,sp
		cmpi.w	#$60,(a5)
		beq.s	locK_11D6C
		bcc.s	locK_11D6A
		addq.w	#4,(a5)
; loc3_12C9C:
locK_11D6A:
		subq.w	#2,(a5)
; loc3_12C9E:
locK_11D6C:
		bsr.w	Player_LevelBound
	if Sonic3_Alone
		bsr.w	Player_AnglePos
	else
		bsr.w	Call_Player_AnglePos
	endif
		tst.b	(Background_collision_flag).w
		beq.s	locretK_11DA4
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
		bpl.s	locK_11D94
		sub.w	d1,x_pos(a0)

locK_11D94:
	if ~~Sonic3_Alone
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locK_11DA0
		add.w	d1,x_pos(a0)

locK_11DA0:
		movem.l	(sp)+,a4-a6
	endif

; locret3_12CCA:
locretK_11DA4:
		rts
; End of function SonicKnux_Spindash


; ---------------------------------------------------------------------------
; Subroutine to slow Sonic walking up a slope
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Player_SlopeResist:
		move.b	angle(a0),d0
		addi.b	#$60,d0
		cmpi.b	#-$40,d0
		bhs.s	locretK_11DDA
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	#$20,d0
		asr.l	#8,d0
		tst.w	ground_vel(a0)
		beq.s	locK_11DDC
		bmi.s	locK_11DD6
		tst.w	d0
		beq.s	locretK_11DD4
		add.w	d0,ground_vel(a0)
; locret3_12CFA:
locretK_11DD4:
		rts
; ---------------------------------------------------------------------------
; loc3_12CFC:
locK_11DD6:
		add.w	d0,ground_vel(a0)
; locret3_12D00:
locretK_11DDA:
		rts
; ---------------------------------------------------------------------------
; loc3_12D02:
locK_11DDC:
		move.w	d0,d1
		bpl.s	locK_11DE2
		neg.w	d1
; loc3_12D08:
locK_11DE2:
		cmpi.w	#$D,d1
		blo.s	locretK_11DDA
		add.w	d0,ground_vel(a0)
		rts
; End of function Player_SlopeResist

; ---------------------------------------------------------------------------
; Subroutine to push Sonic down a slope while he's rolling
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Player_RollRepel:
		move.b	angle(a0),d0
		addi.b	#$60,d0
		cmpi.b	#-$40,d0
		bhs.s	locretK_11E28
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	#$50,d0
		asr.l	#8,d0
		tst.w	ground_vel(a0)
		bmi.s	locK_11E1E
		tst.w	d0
		bpl.s	locK_11E18
		asr.l	#2,d0
; loc3_12D4E:
locK_11E18:
		add.w	d0,ground_vel(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_12D44:
locK_11E1E:
		tst.w	d0
		bmi.s	locK_11E24
		asr.l	#2,d0
; loc3_12D4A:
locK_11E24:
		add.w	d0,ground_vel(a0)
; locret3_12D4E:
locretK_11E28:
		rts
; End of function Player_RollRepel


; ---------------------------------------------------------------------------
; Subroutine to push Sonic down a slope
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Player_SlopeRepel:
		nop
		tst.b	stick_to_convex(a0)
		bne.s	locretK_11E6E
		tst.w	move_lock(a0)
		bne.s	locK_11E86
		move.b	angle(a0),d0
		addi.b	#$18,d0
		cmpi.b	#$30,d0
		blo.s	locretK_11E6E
		move.w	ground_vel(a0),d0
		bpl.s	locK_11E4E
		neg.w	d0
; loc3_12D74:
locK_11E4E:
		cmpi.w	#$280,d0
		bhs.s	locretK_11E6E
		move.w	#30,move_lock(a0)
		move.b	angle(a0),d0
		addi.b	#$30,d0
		cmpi.b	#$60,d0
		blo.s	locK_11E70
		bset	#Status_InAir,status(a0)
; locret3_12D94:
locretK_11E6E:
		rts
; ---------------------------------------------------------------------------
; loc3_12D96:
locK_11E70:
		cmpi.b	#$30,d0
		blo.s	locK_11E7E
		addi.w	#$80,ground_vel(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_12DA4:
locK_11E7E:
		subi.w	#$80,ground_vel(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_12DAC:
locK_11E86:
		subq.w	#1,move_lock(a0)
		rts
; End of function Player_SlopeRepel


; ---------------------------------------------------------------------------
; Subroutine to return Sonic's angle to 0 as he jumps
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Player_JumpAngle:
		move.b	angle(a0),d0	; get Sonic's angle
		beq.s	Player_JumpFlip	; if already 0, branch
		bpl.s	locK_11E9C	; if higher than 0, branch

		addq.b	#2,d0		; increase angle
		bcc.s	locK_11E9A
		moveq	#0,d0
; loc3_12DC0:
locK_11E9A:
		bra.s	Player_JumpAngleSet
; ---------------------------------------------------------------------------
; loc3_12DC2:
locK_11E9C:
		subq.b	#2,d0		; decrease angle
		bcc.s	Player_JumpAngleSet
		moveq	#0,d0

Player_JumpAngleSet:
		move.b	d0,angle(a0)
; End of function Player_JumpAngle
	; continue straight to Player_JumpFlip

; ---------------------------------------------------------------------------
; Updates Sonic's secondary angle if he's tumbling
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Player_JumpFlip:
		move.b	flip_angle(a0),d0
		beq.s	locretK_11EEA
		tst.w	ground_vel(a0)
		bmi.s	Player_JumpLeftFlip

Player_JumpRightFlip:
		move.b	flip_speed(a0),d1
		add.b	d1,d0
		bcc.s	locK_11EC8
		subq.b	#1,flips_remaining(a0)
		bcc.s	locK_11EC8
		move.b	#0,flips_remaining(a0)
		moveq	#0,d0
; loc3_12DEE:
locK_11EC8:
		bra.s	Player_JumpFlipSet
; ---------------------------------------------------------------------------

Player_JumpLeftFlip:
		tst.b	flip_type(a0)
		bmi.s	Player_JumpRightFlip
		move.b	flip_speed(a0),d1
		sub.b	d1,d0
		bcc.s	Player_JumpFlipSet
		subq.b	#1,flips_remaining(a0)
		bcc.s	Player_JumpFlipSet
		move.b	#0,flips_remaining(a0)
		moveq	#0,d0

Player_JumpFlipSet:
		move.b	d0,flip_angle(a0)
; locret3_12E10:
locretK_11EEA:
		rts
; End of function Player_JumpAngle


; ---------------------------------------------------------------------------
; Subroutine for Sonic to interact with the floor and walls when he's in the air
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


SonicKnux_DoLevelCollision:
		move.l	(Primary_collision_addr).w,(Collision_addr).w
		cmpi.b	#$C,top_solid_bit(a0)
		beq.s	locK_11F00
		move.l	(Secondary_collision_addr).w,(Collision_addr).w
; loc3_12E26:
locK_11F00:
		move.b	lrb_solid_bit(a0),d5
		move.w	x_vel(a0),d1
		move.w	y_vel(a0),d2
		jsr	(GetArcTan).l
		subi.b	#$20,d0
		andi.b	#$C0,d0
		cmpi.b	#$40,d0
		beq.w	Player_HitLeftWall
		cmpi.b	#$80,d0
		beq.w	Player_HitCeilingAndWalls
		cmpi.b	#$C0,d0
		beq.w	locK_12102
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	locK_11F44
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)	; stop Sonic since he hit a wall

locK_11F44:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locK_11F56
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)	; stop Sonic since he hit a wall
; loc3_12E7C:
locK_11F56:
	if Sonic3_Alone
		bsr.w	Sonic_CheckFloor
	else
		bsr.w	subK_11FD6
	endif
		tst.w	d1
		bpl.s	locretK_11FD4
		move.b	y_vel(a0),d2
		addq.b	#8,d2
		neg.b	d2
		cmp.b	d2,d1
		bge.s	locK_11F6E
		cmp.b	d2,d0
		blt.s	locretK_11FD4
; loc3_12E94:
locK_11F6E:
	if Sonic3_Alone
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
	else
		move.b	d3,angle(a0)
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_11F7A
		neg.w	d1

locK_11F7A:
		add.w	d1,y_pos(a0)
	endif
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	locK_11FAE
		move.b	d3,d0
		addi.b	#$10,d0
		andi.b	#$20,d0
		beq.s	locK_11F9C
		asr	y_vel(a0)
		bra.s	locK_11FC2
; ---------------------------------------------------------------------------
; loc3_12EBA:
locK_11F9C:
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)
		bsr.w	Player_TouchFloor_Check_Spindash
		rts
; ---------------------------------------------------------------------------
; loc3_12ECC:
locK_11FAE:
		move.w	#0,x_vel(a0)	; stop Sonic since he hit a wall
		cmpi.w	#$FC0,y_vel(a0)
		ble.s	locK_11FC2
		move.w	#$FC0,y_vel(a0)
; loc3_12EE0:
locK_11FC2:
		bsr.w	Player_TouchFloor_Check_Spindash
		move.w	y_vel(a0),ground_vel(a0)
		tst.b	d3
		bpl.s	locretK_11FD4
		neg.w	ground_vel(a0)
; locret3_12EF2:
locretK_11FD4:
		rts
; End of function SonicKnux_DoLevelCollision


	if ~~Sonic3_Alone
; =============== S U B R O U T I N E =======================================


subK_11FD6:
		tst.b	(Reverse_gravity_flag).w
		beq.w	Sonic_CheckFloor
		bsr.w	Sonic_CheckCeiling
		addi.b	#$40,d3
		neg.b	d3
		subi.b	#$40,d3
		rts
; End of function subK_11FD6


; =============== S U B R O U T I N E =======================================


subK_11FEE:
		tst.b	(Reverse_gravity_flag).w
		beq.w	Sonic_CheckCeiling
		bsr.w	Sonic_CheckFloor
		addi.b	#$40,d3
		neg.b	d3
		subi.b	#$40,d3
		rts
; End of function subK_11FEE


; =============== S U B R O U T I N E =======================================


ChooseChkFloorEdge:
		tst.b	(Reverse_gravity_flag).w
		beq.w	ChkFloorEdge_Part2
		bra.w	ChkFloorEdge_ReverseGravity
; End of function ChooseChkFloorEdge
	endif

; ---------------------------------------------------------------------------

Player_HitLeftWall:
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	Player_HitCeiling	; branch if distance is positive (not inside wall)
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)	; stop Sonic since he hit a wall
		move.w	y_vel(a0),ground_vel(a0)

Player_HitCeiling:
	if Sonic3_Alone
		bsr.w	Sonic_CheckCeiling
	else
		bsr.w	subK_11FEE
	endif
		tst.w	d1
		bpl.s	locK_12068	; branch if distance is positive (not inside ceiling)
		neg.w	d1
		cmpi.w	#$14,d1
		bhs.s	locK_12054
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_12042
		neg.w	d1

locK_12042:
	endif
		add.w	d1,y_pos(a0)
		tst.w	y_vel(a0)
		bpl.s	locretK_12052
		move.w	#0,y_vel(a0)	; stop Sonic in y since he hit a ceiling
; locret3_12F2C:
locretK_12052:
		rts
; ---------------------------------------------------------------------------
; loc3_12F2E:
locK_12054:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locretK_12066
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
; locret3_12F40:
locretK_12066:
		rts
; ---------------------------------------------------------------------------
; loc3_12F42:
locK_12068:
		tst.b	(WindTunnel_flag).w
		bne.s	locK_12074
		tst.w	y_vel(a0)
		bmi.s	locretK_1209C
; loc3_12F4E:
locK_12074:
	if Sonic3_Alone
		bsr.w	Sonic_CheckFloor
	else
		bsr.w	subK_11FD6
	endif
		tst.w	d1
		bpl.s	locretK_1209C
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_12084
		neg.w	d1

locK_12084:
	endif
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)
		bsr.w	Player_TouchFloor_Check_Spindash
; locret3_12F6E:
locretK_1209C:
		rts
; ---------------------------------------------------------------------------

Player_HitCeilingAndWalls:
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	locK_120B0
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)	; stop Sonic since he hit a wall
; loc3_12F82:
locK_120B0:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locK_120C2
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)	; stop Sonic since he hit a wall
; loc3_12F94:
locK_120C2:
	if Sonic3_Alone
		bsr.w	Sonic_CheckCeiling
	else
		bsr.w	subK_11FEE
	endif
		tst.w	d1
		bpl.s	locretK_12100
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_120D2
		neg.w	d1

locK_120D2:
	endif
		sub.w	d1,y_pos(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	locK_120EA
		move.w	#0,y_vel(a0)	; stop Sonic in y since he hit a ceiling
		rts
; ---------------------------------------------------------------------------
; loc3_12FB4:
locK_120EA:
		move.b	d3,angle(a0)
		bsr.w	Player_TouchFloor_Check_Spindash
		move.w	y_vel(a0),ground_vel(a0)
		tst.b	d3
		bpl.s	locretK_12100
		neg.w	ground_vel(a0)
; locret3_12FCA:
locretK_12100:
		rts
; ---------------------------------------------------------------------------
; loc3_12FCC:
locK_12102:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locK_1211A
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
		move.w	y_vel(a0),ground_vel(a0)
; loc3_12FE4:
locK_1211A:
	if Sonic3_Alone
		bsr.w	Sonic_CheckCeiling
	else
		bsr.w	subK_11FEE
	endif
		tst.w	d1
		bpl.s	locK_1213C
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_1212A
		neg.w	d1

locK_1212A:
	endif
		sub.w	d1,y_pos(a0)
		tst.w	y_vel(a0)
		bpl.s	locretK_1213A
		move.w	#0,y_vel(a0)
; locret3_12FFC:
locretK_1213A:
		rts
; ---------------------------------------------------------------------------
; loc3_12FFE:
locK_1213C:
		tst.b	(WindTunnel_flag).w
		bne.s	locK_12148
		tst.w	y_vel(a0)
		bmi.s	locretK_12170
; loc3_1300A:
locK_12148:
	if Sonic3_Alone
		bsr.w	Sonic_CheckFloor
	else
		bsr.w	subK_11FD6
	endif
		tst.w	d1
		bpl.s	locretK_12170
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_12158
		neg.w	d1

locK_12158:
	endif
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)
		bsr.w	Player_TouchFloor_Check_Spindash
; locret3_1302A:
locretK_12170:
		rts

; =============== S U B R O U T I N E =======================================


Player_TouchFloor_Check_Spindash:
		tst.b	spin_dash_flag(a0)
		bne.s	locK_121D8
		move.b	#0,anim(a0)
; End of function Player_TouchFloor_Check_Spindash


; =============== S U B R O U T I N E =======================================


Player_TouchFloor:
	if Sonic3_Alone
		cmpi.l	#Obj_Tails,(a0)
		beq.w	Tails_TouchFloor
	else
		cmpi.b	#1,character_id(a0)
		beq.w	Tails_TouchFloor
		cmpi.b	#2,character_id(a0)
		beq.w	Knux_TouchFloor
	endif

		move.b	y_radius(a0),d0
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
		btst	#Status_Roll,status(a0)
		beq.s	locK_121D8
		bclr	#Status_Roll,status(a0)
		move.b	#0,anim(a0)
		sub.b	default_y_radius(a0),d0
		ext.w	d0
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_121C4
		neg.w	d0

locK_121C4:
		move.w	d0,-(sp)
		move.b	angle(a0),d0
		addi.b	#$40,d0
		bpl.s	locK_121D2
		neg.w	(sp)

locK_121D2:
		move.w	(sp)+,d0
	endif
		add.w	d0,y_pos(a0)
; loc3_13070:
locK_121D8:
		bclr	#Status_InAir,status(a0)
		bclr	#Status_Push,status(a0)
		bclr	#Status_RollJump,status(a0)
		move.b	#0,jumping(a0)
		move.w	#0,(Chain_bonus_counter).w
		move.b	#0,flip_angle(a0)
		move.b	#0,flip_type(a0)
		move.b	#0,flips_remaining(a0)
		move.b	#0,scroll_delay_counter(a0)
		tst.b	double_jump_flag(a0)
		beq.s	locretK_12230
	if ~~Sonic3_Alone
		tst.b	character_id(a0)
		bne.s	locK_1222A
		; Sonic 3 forgot to check for Super Sonic here, allowing him to
		; use the Bubble Shield's bounce.
		tst.b	(Super_Sonic_Knux_flag).w
		bne.s	locK_1222A
	endif
		btst	#Status_BublShield,status_secondary(a0)
		beq.s	locK_1222A
		bsr.s	BubbleShield_Bounce
; loc3_130B6:
locK_1222A:
		move.b	#0,double_jump_flag(a0)
; locret3_130C:
locretK_12230:
		rts
; End of function Player_TouchFloor


; =============== S U B R O U T I N E =======================================


BubbleShield_Bounce:
		movem.l	d1-d2,-(sp)
		move.w	#$780,d2
		btst	#Status_Underwater,status(a0)
		beq.s	locK_12246
		move.w	#$400,d2
; loc3_130D2:
locK_12246:
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
		movem.l	(sp)+,d1-d2
		bset	#Status_InAir,status(a0)
		bclr	#Status_Push,status(a0)
		move.b	#1,jumping(a0)
		clr.b	stick_to_convex(a0)
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)
		bset	#Status_Roll,status(a0)
		move.b	y_radius(a0),d0
		sub.b	default_y_radius(a0),d0
		ext.w	d0
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_122AA
		neg.w	d0

locK_122AA:
	endif
		sub.w	d0,y_pos(a0)
		move.b	#2,(Shield+anim).w
		move.w	#sfx_BubbleAttack,d0
		jmp	(Play_SFX).l
; End of function BubbleShield_Bounce

; ---------------------------------------------------------------------------
; loc3_13142:
locK_122BE:
		tst.w	(Debug_mode_flag).w
		beq.s	locK_122D8
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	locK_122D8
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------
; loc3_1315C:
locK_122D8:
	if Sonic3_Alone
		jsr	(MoveSprite2).l
	else
		jsr	(MoveSprite_TestGravity2).l
	endif
		addi.w	#$30,y_vel(a0)
		btst	#Status_Underwater,status(a0)
		beq.s	locK_122F2
		subi.w	#$20,y_vel(a0)
; loc3_13176:
locK_122F2:
		cmpi.w	#-$100,(Camera_min_Y_pos).w
		bne.s	locK_12302
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)
; loc3_13186:
locK_12302:
		bsr.w	subK_12318
		bsr.w	Player_LevelBound
		bsr.w	Sonic_RecordPos
		bsr.w	subK_125E0
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================

; sub3_1319C:
subK_12318:
		tst.b	(Disable_death_plane).w
		bne.s	locK_12344
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		bne.s	locK_12336
	endif
		move.w	(Camera_max_Y_pos).w,d0
		addi.w	#$E0,d0
		cmp.w	y_pos(a0),d0
		blt.w	locK_1238A
	if ~~Sonic3_Alone
		bra.s	locK_12344
; ---------------------------------------------------------------------------

locK_12336:
		move.w	(Camera_min_Y_pos).w,d0
		cmp.w	y_pos(a0),d0
		blt.s	locK_12344
		bra.w	locK_1238A
; ---------------------------------------------------------------------------
	endif
; loc3_13182:
locK_12344:
		movem.l	a4-a6,-(sp)
		bsr.w	SonicKnux_DoLevelCollision
		movem.l	(sp)+,a4-a6
		btst	#Status_InAir,status(a0)
		bne.s	locretK_12388
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
; locret3_131F6:
locretK_12388:
		rts
; ---------------------------------------------------------------------------
; loc3_131F8:
locK_1238A:
		jmp	(Kill_Character).l
; End of function subK_12318

; ---------------------------------------------------------------------------
; loc3_141FE:
locK_12390:
		tst.w	(Debug_mode_flag).w
		beq.s	locK_123AA
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	locK_123AA
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------
; loc3_13218:
locK_123AA:
		bsr.w	subK_123C2
	if Sonic3_Alone
		jsr	(MoveSprite).l
	else
		jsr	(MoveSprite_TestGravity).l
	endif
		bsr.w	Sonic_RecordPos
		bsr.w	subK_125E0
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================

; sub3_13230:
subK_123C2:
		cmpa.w	#Player_1,a0
		bne.s	locK_123D4
		move.w	(Camera_Y_pos).w,d0
		move.b	#1,(Scroll_lock).w
		bra.s	locK_123DE
; ---------------------------------------------------------------------------
; loc3_13242:
locK_123D4:
		move.w	(Camera_Y_pos).w,d0
		move.b	#1,(Scroll_lock_P2).w
; loc3_1324C:
locK_123DE:
		move.b	#0,spin_dash_flag(a0)
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_123FA
		subi.w	#$10,d0
		cmp.w	y_pos(a0),d0
		bge.w	locK_12410
		bra.w	locretK_124C6
; ---------------------------------------------------------------------------

locK_123FA:
	endif
		addi.w	#$100,d0
		tst.w	(Competition_mode).w
		beq.s	locK_12408
		subi.w	#$70,d0
; loc3_13260:
locK_12408:
		cmp.w	y_pos(a0),d0
		bge.w	locretK_124C6

locK_12410:
		tst.w	(Competition_mode).w
		bne.w	locK_124C8
		cmpi.b	#1,character_id(a0)
		bne.s	locK_12432
		cmpi.w	#2,(Player_mode).w
		beq.s	locK_12432
		move.b	#2,routine(a0)
	if Sonic3_Alone
		bra.w	sub_14B58
	else
		bra.w	sub_13ECA
	endif
; ---------------------------------------------------------------------------
; loc3_1328A:
locK_12432:
		move.b	#8,routine(a0)
		move.w	#60,$3E(a0)
		move.b	#0,(Respawn_table_keep).w
		addq.b	#1,(Update_HUD_life_count).w
		subq.b	#1,(Life_count).w
		bne.s	locK_12498
		move.w	#0,$3E(a0)
		move.l	#Obj_GameOver,(Reserved_object_3).w
		move.l	#Obj_GameOver,(Dynamic_object_RAM).w
		move.b	#0,(Reserved_object_3+mapping_frame).w
		move.b	#1,(Dynamic_object_RAM+mapping_frame).w
		move.w	a0,(Reserved_object_3+objoff_3E).w
		clr.b	(Time_over_flag).w
; loc3_132D0:
locK_12478:
		clr.b	(Update_HUD_timer).w
		clr.b	(Update_HUD_timer_P2).w
		move.b	#8,routine(a0)
		move.w	#mus_GameOver,d0
		jsr	(Play_Music).l
		moveq	#PLCID_03,d0
		jmp	(Load_PLC_2).l
; ---------------------------------------------------------------------------
; loc3_132F0:
locK_12498:
		tst.b	(Time_over_flag).w
		beq.s	locretK_124C6
		move.w	#0,$3E(a0)
		move.l	#Obj_GameOver,(Reserved_object_3).w
		move.l	#Obj_GameOver,(Dynamic_object_RAM).w
		move.b	#2,(Reserved_object_3+mapping_frame).w
		move.b	#3,(Dynamic_object_RAM+mapping_frame).w
		move.w	a0,(Reserved_object_3+objoff_3E).w
		bra.s	locK_12478
; ---------------------------------------------------------------------------
; locret3_1331E:
locretK_124C6:
		rts
; ---------------------------------------------------------------------------
; loc3_13320:
locK_124C8:
		move.b	#2,routine(a0)
		cmpa.w	#Player_1,a0
		bne.s	locK_12502
		move.b	#0,(Scroll_lock).w
		move.w	(Saved_X_pos).w,x_pos(a0)
		move.w	(Saved_Y_pos).w,y_pos(a0)
		move.w	(Saved_art_tile).w,art_tile(a0)
		move.w	(Saved_solid_bits).w,top_solid_bit(a0)
		clr.w	(Ring_count).w
		clr.b	(Extra_life_flags).w
		move.b	#1,(Competition_lap_count_flag).w	; disable the lap count flag, however, later on this value is reset to 0 in Obj_2PGoalMarker
		bra.s	locK_1252A
; ---------------------------------------------------------------------------
; loc3_1335A:
locK_12502:
		move.b	#0,(Scroll_lock_P2).w
		move.w	(Saved2_X_pos).w,x_pos(a0)
		move.w	(Saved2_Y_pos).w,y_pos(a0)
		move.w	(Saved2_art_tile).w,art_tile(a0)
		move.w	(Saved2_solid_bits).w,top_solid_bit(a0)
		clr.w	(Ring_count_P2).w
		move.b	#1,(Competition_lap_count_flag_P2).w	; disable the lap count flag, however, later on this value is reset to 0 in Obj_2PGoalMarker
; loc3_13382:
locK_1252A:
		move.b	#0,object_control(a0)
		move.b	#5,anim(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		move.b	#2,status(a0)
		move.w	#0,move_lock(a0)
		move.w	#0,spin_dash_counter(a0)
		clr.b	speed_shoes_timer(a0)
		lea	(Character_Speeds).l,a1
		moveq	#0,d0
		move.b	character_id(a0),d0
		lsl.w	#3,d0
		lea	(a1,d0.w),a1
		move.w	(a1)+,Max_speed-Max_speed(a4)
		move.w	(a1)+,Acceleration-Max_speed(a4)
		move.w	(a1)+,Deceleration-Max_speed(a4)
		rts
; End of function subK_123C2

; ---------------------------------------------------------------------------
; loc3_133D4:
locK_1257C:
		tst.w	$3E(a0)
		beq.s	locretK_1258E
		subq.w	#1,$3E(a0)
		bne.s	locretK_1258E
		move.w	#1,(Restart_level_flag).w
; locret3_133E6:
locretK_1258E:
		rts
; ---------------------------------------------------------------------------
; loc3_133E8:
locK_12590:
		tst.w	(H_scroll_amount).w
		bne.s	locK_125A2
		tst.w	(V_scroll_amount).w
		bne.s	locK_125A2
		move.b	#2,routine(a0)
; loc3_133FA:
locK_125A2:
		bsr.w	subK_125E0
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_13404:
locK_125AC:
		tst.w	(Debug_mode_flag).w
		beq.s	locK_125C6
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	locK_125C6
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------
; loc3_1341E:
locK_125C6:
	if Sonic3_Alone
		jsr	(MoveSprite2).l
	else
		jsr	(MoveSprite_TestGravity2).l
	endif
		addi.w	#$10,y_vel(a0)
		bsr.w	Sonic_RecordPos
		bsr.w	subK_125E0
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================

; sub3_13438:
subK_125E0:
		tst.w	(Competition_mode).w
		bne.s	locK_125F8
		bsr.s	Animate_Sonic
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_125F4
		eori.b	#2,render_flags(a0)

locK_125F4:
	endif
		bra.w	Sonic_Load_PLC
; ---------------------------------------------------------------------------
; loc3_13444:
locK_125F8:
		bsr.w	Animate_SonicKnuckles_2P
		bra.w	SonicKnuckles2P_Load_PLC
; End of function subK_125E0


; =============== S U B R O U T I N E =======================================


Animate_Sonic:
		lea	(AniSonic).l,a1
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	locK_12612
		lea	(AniSuperSonic).l,a1
; loc3_1345E:
locK_12612:
		moveq	#0,d0
		move.b	anim(a0),d0
		cmp.b	prev_anim(a0),d0
		beq.s	locK_12634
		move.b	d0,prev_anim(a0)
		move.b	#0,anim_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		bclr	#Status_Push,status(a0)
; loc3_13480:
locK_12634:
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),d0
		bmi.s	locK_126A4
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locretK_12672
		move.b	d0,anim_frame_timer(a0)
; loc3_134A6:
locK_1265A:
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#$FC,d0
		bhs.s	locK_12674
; loc3_134B6:
locK_1266A:
		move.b	d0,mapping_frame(a0)
		addq.b	#1,anim_frame(a0)
; locret3_134BE:
locretK_12672:
		rts
; ---------------------------------------------------------------------------
; loc3_134C0:
locK_12674:
		addq.b	#1,d0
		bne.s	locK_12684
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
		bra.s	locK_1266A
; ---------------------------------------------------------------------------
; loc3_134D0:
locK_12684:
		addq.b	#1,d0
		bne.s	locK_12698
		move.b	2(a1,d1.w),d0
		sub.b	d0,anim_frame(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	locK_1266A
; ---------------------------------------------------------------------------
; loc3_134E4:
locK_12698:
		addq.b	#1,d0
		bne.s	locretK_126A2
		move.b	2(a1,d1.w),anim(a0)
; locret3_134EE:
locretK_126A2:
		rts
; ---------------------------------------------------------------------------
; loc3_134F0:
locK_126A4:
		addq.b	#1,d0
		bne.w	locK_12A2A
		moveq	#0,d0
		tst.b	flip_type(a0)
		bmi.w	Anim_Tumble
		move.b	flip_angle(a0),d0
		bne.w	Anim_Tumble
		moveq	#0,d1
		move.b	angle(a0),d0
		bmi.s	locK_126C8
		beq.s	locK_126C8
		subq.b	#1,d0
; loc3_13514:
locK_126C8:
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	locK_126D4
		not.b	d0
; loc3_13520:
locK_126D4:
		addi.b	#$10,d0
		bpl.s	locK_126DC
		moveq	#3,d1
; loc3_13528:
locK_126DC:
		andi.b	#$FC,render_flags(a0)
		eor.b	d1,d2
		or.b	d2,render_flags(a0)
		btst	#Status_Push,status(a0)
		bne.w	locK_12A72
		lsr.b	#4,d0
		andi.b	#6,d0
		move.w	ground_vel(a0),d2
		bpl.s	locK_12700
		neg.w	d2
; loc3_1354C:
locK_12700:
		tst.b	status_secondary(a0)
		bpl.w	locK_1270A
		add.w	d2,d2
; loc3_13556:
locK_1270A:
		tst.b	(Super_Sonic_Knux_flag).w
		bne.s	locK_12766
		lea	(AniSonic01).l,a1
		cmpi.w	#$600,d2
		bhs.s	locK_12724
		lea	(AniSonic00).l,a1
		add.b	d0,d0
; loc3_13570:
locK_12724:
		add.b	d0,d0
		move.b	d0,d3
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	locK_12742
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
; loc3_1358E:
locK_12742:
		move.b	d0,mapping_frame(a0)
		add.b	d3,mapping_frame(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locretK_12764
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	locK_1275A
		moveq	#0,d2
; loc3_135A6:
locK_1275A:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)
; locret3_135B0:
locretK_12764:
		rts
; ---------------------------------------------------------------------------
; loc3_135B2:
locK_12766:
		lea	(AniSuperSonic01).l,a1
		cmpi.w	#$800,d2
		bhs.s	locK_1277E
		lea	(AniSuperSonic00).l,a1
		add.b	d0,d0
		add.b	d0,d0
		bra.s	locK_12780
; ---------------------------------------------------------------------------
; loc3_135CA:
locK_1277E:
		add.b	d0,d0
; loc3_135CC:
locK_12780:
		move.b	d0,d3
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	locK_1279C
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
; loc3_135E8:
locK_1279C:
		move.b	d0,mapping_frame(a0)
		add.b	d3,mapping_frame(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locretK_127BE
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	locK_127B4
		moveq	#0,d2
; loc3_13600:
locK_127B4:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)
; locret3_1360A:
locretK_127BE:
		rts
; ---------------------------------------------------------------------------
; loc3_1360C: locK_127C0:
Anim_Tumble:
		move.b	flip_type(a0),d1
		andi.w	#$7F,d1
	if Sonic3_Alone
		bne.s	locK_12872
	else
		bne.w	locK_12872
	endif
		move.b	flip_angle(a0),d0
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	Anim_TumbleLeft
		andi.b	#$FC,render_flags(a0)
		tst.b	flip_type(a0)
		bpl.s	locK_12806
	if ~~Sonic3_Alone
		cmpi.b	#$B,(Current_zone).w	; is this DEZ?
		beq.s	locK_1280A		; if so, branch
		cmpi.b	#4,(Current_zone).w	; is this FBZ?
		beq.s	locK_1280A		; if so, branch
	endif
		ori.b	#2,render_flags(a0)
		neg.b	d0
		addi.b	#$8F,d0
		bra.s	locK_1280A
; ---------------------------------------------------------------------------
; loc3_13640:
locK_12806:
		addi.b	#$B,d0
; loc3_13644:
locK_1280A:
		divu.w	#$16,d0
		addi.b	#$31,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

; loc3_13658: locK_1281E:
Anim_TumbleLeft:
		andi.b	#$FC,render_flags(a0)
	if ~~Sonic3_Alone
		tst.b	flip_type(a0)
		bpl.s	locK_1284E
		cmpi.b	#4,(Current_zone).w	; is this FBZ?
		beq.s	locK_12842		; if so, branch
		cmpi.b	#$B,(Current_zone).w	; is this DEZ?
		beq.s	locK_12842		; if so, branch
		cmpi.b	#7,(Current_zone).w	; is this MHZ?
		bne.s	locK_1284E		; if not, branch

locK_12842:
		ori.b	#1,render_flags(a0)
		addi.b	#$B,d0
		bra.s	locK_1285A
; ---------------------------------------------------------------------------

locK_1284E:
	endif
		ori.b	#3,render_flags(a0)
		neg.b	d0
		addi.b	#$8F,d0

locK_1285A:
		divu.w	#$16,d0
		addi.b	#$31,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------
; byte3_1367E:
byteK_1286E:
		dc.b    0, $3D, $49, $49
		even
; ---------------------------------------------------------------------------
; loc3_13682:
locK_12872:
		move.b	byteK_1286E(pc,d1.w),d3
		cmpi.b	#1,d1
		bne.s	locK_128CA
		move.b	flip_angle(a0),d0
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	locK_128A8
		andi.b	#$FC,render_flags(a0)
		addi.b	#-8,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------
; loc_136B8:
locK_128A8:
		andi.b	#$FC,render_flags(a0)
		ori.b	#1,render_flags(a0)
		addi.b	#-8,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_136DA:
locK_128CA:
		cmpi.b	#2,d1
		bne.s	locK_12920
		move.b	flip_angle(a0),d0
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	locK_128FC
		andi.b	#$FC,render_flags(a0)
		addi.b	#$B,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_1370C:
locK_128FC:
		andi.b	#$FC,render_flags(a0)
		ori.b	#3,render_flags(a0)
		neg.b	d0
		addi.b	#$8F,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_13730:
locK_12920:
	if ~~Sonic3_Alone
		cmpi.b	#3,d1
		bne.s	locK_1297C
		move.b	flip_angle(a0),d0
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	locK_1295A
		andi.b	#$FC,render_flags(a0)
		ori.b	#2,render_flags(a0)
		neg.b	d0
		addi.b	#$8F,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

locK_1295A:
		andi.b	#$FC,render_flags(a0)
		ori.b	#1,render_flags(a0)
		addi.b	#$B,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_136DA:
locK_1297C:
		cmpi.b	#4,d1
		bne.s	locK_129F6
		move.b	flip_angle(a0),d0
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	locK_129BC
		andi.b	#$FC,render_flags(a0)
		tst.b	flip_type(a0)
		bpl.s	locK_129A4
		addi.b	#$B,d0
		bra.s	locK_129A8
; ---------------------------------------------------------------------------

locK_129A4:
		addi.b	#$B,d0

locK_129A8:
		divu.w	#$16,d0
		addi.b	#$31,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

locK_129BC:
		andi.b	#$FC,render_flags(a0)
		tst.b	flip_type(a0)
		bpl.s	locK_129D6
		ori.b	#3,render_flags(a0)
		neg.b	d0
		addi.b	#$8F,d0
		bra.s	locK_129E2
; ---------------------------------------------------------------------------
; loc_1370C:
locK_129D6:
		ori.b	#3,render_flags(a0)
		neg.b	d0
		addi.b	#$8F,d0

locK_129E2:
		divu.w	#$16,d0
		addi.b	#$31,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_13730:
locK_129F6:
	endif
		move.b	flip_angle(a0),d0
	if ~~Sonic3_Alone
		andi.b	#$FC,render_flags(a0)
	endif
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
	if Sonic3_Alone
		bne.s	locK_12A12
		andi.b	#$FC,render_flags(a0)
		ori.b	#2,render_flags(a0)
		neg.b	d0
		addi.b	#$8F,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------
	else
		beq.s	locK_12A12
		ori.b	#1,render_flags(a0)
	endif

; loc3_13764:
locK_12A12:
	if Sonic3_Alone
		andi.b	#$FC,render_flags(a0)
		ori.b	#1,render_flags(a0)
	endif
		addi.b	#$B,d0
		divu.w	#$16,d0
	if Sonic3_Alone
		add.b	d3,d0
	else
		addi.b	#$31,d0
	endif
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_13786:
locK_12A2A:
	if ~~Sonic3_Alone
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
	endif
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locretK_12672
		move.w	ground_vel(a0),d2
		bpl.s	locK_12A4C
		neg.w	d2
; loc3_13796:
locK_12A4C:
		lea	(AniSonic03).l,a1
		cmpi.w	#$600,d2
		bhs.s	locK_12A5E
		lea	(AniSonic02).l,a1
; loc3_137A8:
locK_12A5E:
		neg.w	d2
		addi.w	#$400,d2
		bpl.s	locK_12A68
		moveq	#0,d2
; loc3_137B2:
locK_12A68:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
	if Sonic3_Alone
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
	endif
		bra.w	locK_1265A
; ---------------------------------------------------------------------------
; loc3_137CE:
locK_12A72:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locretK_12672
		move.w	ground_vel(a0),d2
		bmi.s	locK_12A82
		neg.w	d2
; loc3_137DE:
locK_12A82:
		addi.w	#$800,d2
		bpl.s	locK_12A8A
		moveq	#0,d2
; loc3_137E6:
locK_12A8A:
		lsr.w	#6,d2
		move.b	d2,anim_frame_timer(a0)
		lea	(AniSonic04).l,a1
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	locK_12AA2
		lea	(AniSuperSonic04).l,a1
; loc3_137FE:
locK_12AA2:
	if Sonic3_Alone
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
	endif
		bra.w	locK_1265A
; End of function Animate_Sonic

; ---------------------------------------------------------------------------
AniSonic:
	if Sonic3_Alone
		include "General/Sprites/Sonic/Anim - Sonic S3.asm"
	else
		include "General/Sprites/Sonic/Anim - Sonic.asm"
	endif

; =============== S U B R O U T I N E =======================================


Sonic_Load_PLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0

Sonic_Load_PLC2:
		cmp.b	(Player_prev_frame).w,d0
		beq.s	locretK_12D20
		move.b	d0,(Player_prev_frame).w
		lea	(PLC_Sonic).l,a2
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	locK_12CD6
		lea	(PLC_SuperSonic).l,a2
; loc3_13A44:
locK_12CD6:
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locretK_12D20
		move.w	#tiles_to_bytes(ArtTile_Player_1),d4
	if ~~Sonic3_Alone
		move.l	#ArtUnc_Sonic,d6
		cmpi.w	#2*$DA,d0
		blo.s	locK_12CF8
		move.l	#ArtUnc_Sonic_Extra,d6
	endif
; loc3_13A54:
locK_12CF8:
		moveq	#0,d1
		move.w	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
	if Sonic3_Alone
		addi.l	#ArtUnc_Sonic,d1
	else
		add.l	d6,d1
	endif
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		dbf	d5,locK_12CF8
; locret_13A80:
locretK_12D20:
		rts
; End of function Sonic_Load_PLC


; =============== S U B R O U T I N E =======================================


Perform_Player_DPLC:
		tst.b	character_id(a1)
		beq.s	Sonic_Load_PLC2
	if Sonic3_Alone
		bra.w	Tails_Load_PLC2
	else
		cmpi.b	#1,character_id(a1)
		beq.w	Tails_Load_PLC2
		bra.w	Knuckles_Load_PLC2
	endif
; End of function Perform_Player_DPLC


; =============== S U B R O U T I N E =======================================


Animate_SonicKnuckles_2P:
		lea	(AniSonic2P).l,a1
		tst.b	character_id(a0)
		beq.s	locK_12D48
		lea	(AniKnuckles2P).l,a1
; loc3_13A9E:
locK_12D48:
		moveq	#0,d0
		move.b	anim(a0),d0
		cmp.b	prev_anim(a0),d0
		beq.s	locK_12D6A
		move.b	d0,prev_anim(a0)
		move.b	#0,anim_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		bclr	#Status_Push,status(a0)
; loc3_13AC0:
locK_12D6A:
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),d0
		bmi.s	locK_12DDA
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locretK_12DA8
		move.b	d0,anim_frame_timer(a0)
; loc3_13AE6:
locK_12D90:
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#$FC,d0
		bhs.s	locK_12DAA
; loc3_13AF6:
locK_12DA0:
		move.b	d0,mapping_frame(a0)
		addq.b	#1,anim_frame(a0)
; locret3_13AFE:
locretK_12DA8:
		rts
; ---------------------------------------------------------------------------
; loc3_13B00:
locK_12DAA:
		addq.b	#1,d0
		bne.s	locK_12DBA
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
		bra.s	locK_12DA0
; ---------------------------------------------------------------------------
; loc3_13B10:
locK_12DBA:
		addq.b	#1,d0
		bne.s	locK_12DCE
		move.b	2(a1,d1.w),d0
		sub.b	d0,anim_frame(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	locK_12DA0
; ---------------------------------------------------------------------------
; loc3_13B24:
locK_12DCE:
		addq.b	#1,d0
		bne.s	locretK_12DD8
		move.b	2(a1,d1.w),anim(a0)
; locret3_13B2E:
locretK_12DD8:
		rts
; ---------------------------------------------------------------------------
; loc3_13B30:
locK_12DDA:
		addq.b	#1,d0
		bne.w	locK_12EF4
		moveq	#0,d0
		move.b	flip_angle(a0),d0
		bne.w	locK_12E8E
		moveq	#0,d1
		move.b	angle(a0),d0
		bmi.s	locK_12DF6
		beq.s	locK_12DF6
		subq.b	#1,d0
; loc3_13B4C:
locK_12DF6:
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	locK_12E02
		not.b	d0
; loc3_13B58:
locK_12E02:
		addi.b	#$10,d0
		bpl.s	locK_12E0A
		moveq	#3,d1
; loc3_13B60:
locK_12E0A:
		andi.b	#$FC,render_flags(a0)
		eor.b	d1,d2
		or.b	d2,render_flags(a0)
		btst	#Status_Push,status(a0)
		bne.w	locK_12F3C
		lsr.b	#5,d0
		andi.b	#3,d0
		move.w	ground_vel(a0),d2
		bpl.s	locK_12E2E
		neg.w	d2
; loc3_13B84:
locK_12E2E:
		tst.b	status_secondary(a0)
		bpl.w	locK_12E38
		add.w	d2,d2
; loc3_13B8E:
locK_12E38:
		move.b	d0,d3
		lea	(AniSonic2P01).l,a1
		cmpi.w	#$600,d2
		bhs.s	locK_12E4E
		lea	(AniSonic2P00).l,a1
		add.b	d0,d0
; loc3_13BA4:
locK_12E4E:
		add.b	d0,d3
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	locK_12E6A
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
; loc3_13BC0:
locK_12E6A:
		move.b	d0,mapping_frame(a0)
		add.b	d3,mapping_frame(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locretK_12E8C
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	locK_12E82
		moveq	#0,d2
; loc3_13BD8:
locK_12E82:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)
; locret3_13BE2:
locretK_12E8C:
		rts
; ---------------------------------------------------------------------------
; loc3_13BE4:
locK_12E8E:
		move.b	flip_angle(a0),d0
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	locK_12EBC
		andi.b	#$FC,render_flags(a0)
		addi.b	#$16,d0
		divu.w	#$2C,d0
		addi.b	#$15,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_13C12:
locK_12EBC:
		andi.b	#$FC,render_flags(a0)
		tst.b	flip_type(a0)
		bpl.s	locK_12ED4
		ori.b	#1,render_flags(a0)
		addi.b	#$16,d0
		bra.s	locK_12EE0
; ---------------------------------------------------------------------------
; loc3_13C2A:
locK_12ED4:
		ori.b	#3,render_flags(a0)
		neg.b	d0
		addi.b	#$9A,d0
; loc3_13C36:
locK_12EE0:
		divu.w	#$2C,d0
		addi.b	#$15,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_13C4A:
locK_12EF4:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locretK_12DA8
		move.w	ground_vel(a0),d2
		bpl.s	locK_12F04
		neg.w	d2
; loc3_13C5A:
locK_12F04:
		lea	(AniSonic2P03).l,a1
		cmpi.w	#$600,d2
		bhs.s	locK_12F16
		lea	(AniSonic2P02).l,a1
; loc3_13C6C:
locK_12F16:
		neg.w	d2
		addi.w	#$400,d2
		bpl.s	locK_12F20
		moveq	#0,d2
; loc3_13C76:
locK_12F20:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		bra.w	locK_12D90
; ---------------------------------------------------------------------------
; loc3_13C92:
locK_12F3C:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locretK_12DA8
		move.w	ground_vel(a0),d2
		bmi.s	locK_12F4C
		neg.w	d2
; loc3_13CA2:
locK_12F4C:
		addi.w	#$800,d2
		bpl.s	locK_12F54
		moveq	#0,d2
; loc3_13CAA:
locK_12F54:
		lsr.w	#6,d2
		lea	(AniSonic2P04).l,a1
		tst.b	character_id(a0)
		beq.s	locK_12F6A
		lea	(AniKnuckles2P04).l,a1
		lsr.w	#2,d2
; loc3_13CC0:
locK_12F6A:
		move.b	d2,anim_frame_timer(a0)
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		bra.w	locK_12D90
; End of function Animate_SonicKnuckles_2P

; ---------------------------------------------------------------------------

AniSonic2P:
		include "General/Sprites/Sonic/Anim - Sonic Knuckles 2P.asm"


; =============== S U B R O U T I N E =======================================


SonicKnuckles2P_Load_PLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		lea	(PLC_Sonic2P).l,a2
		move.l	#ArtUnc_Sonic2P,d6
		tst.b	character_id(a0)
		beq.s	locK_130BE
		lea	(PLC_Knuckles2P).l,a2
		move.l	#ArtUnc_Knuckles2P,d6
; loc3_13E14:
locK_130BE:
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locretK_13100
		move.w	#tiles_to_bytes(ArtTile_Player_1),d4
		cmpa.w	#Player_1,a0
		beq.s	locK_130D8
		move.w	#tiles_to_bytes(ArtTile_Player_2),d4
; loc3_13E2E:
locK_130D8:
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
		dbf	d5,locK_130D8
; locret3_13E56:
locretK_13100:
		rts
; End of function SonicKnuckles2P_Load_PLC