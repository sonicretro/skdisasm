; ---------------------------------------------------------------------------

Obj_AIZRideVine:
		movea.l	a0,a1
		move.l	#locK_21D28,(a1)
		bsr.w	subK_21D00
		move.b	#$21,mapping_frame(a1)
		move.w	x_pos(a0),d2
		move.w	y_pos(a0),d3
		moveq	#0,d1
		move.b	subtype(a0),d1
		andi.w	#$7F,d1
		lsl.w	#4,d1
		add.w	d2,d1
		move.w	d1,$46(a0)
		moveq	#3,d1
		addq.w	#1,d1
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	locK_21CFE
		move.w	a1,$3E(a0)
		move.l	#locK_21F80,(a1)
		move.w	a0,$3C(a1)
		bra.s	locK_21CD0
; ---------------------------------------------------------------------------
; loc3_200F8:
locK_21CB8:
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	locK_21CFE
		move.l	#locK_22014,(a1)
		move.w	a2,$3C(a1)
		move.w	a1,$3E(a2)
; loc3_20110:
locK_21CD0:
		movea.l	a1,a2
		bsr.s	subK_21D00
		move.w	d2,x_pos(a1)
		move.w	d3,y_pos(a1)
		addi.w	#$10,d3
		addq.w	#1,$36(a0)
		move.w	$36(a0),$36(a1)
		dbf	d1,locK_21CB8
		move.l	#Obj_AIZRideVineHandle,(a1)
		move.b	#$20,mapping_frame(a1)
		move.w	a1,$40(a0)
; loc3_2013E:
locK_21CFE:
		bra.s	locK_21D28

; =============== S U B R O U T I N E =======================================

; sub3_20140:
subK_21D00:
		move.b	#4,render_flags(a1)
		move.b	#8,width_pixels(a1)
		move.b	#8,height_pixels(a1)
		move.w	#$200,priority(a1)
	if Sonic3_Alone
		move.l	#Map_AIZRideVine,mappings(a1)
	else
		move.l	#Map_AIZMHZRideVine,mappings(a1)
	endif
		move.w	#make_art_tile(ArtTile_AIZSwingVine,0,0),art_tile(a1)
		rts
; End of function subK_21D00

; ---------------------------------------------------------------------------
; loc3_20168:
locK_21D28:
		movea.w	$40(a0),a1
		tst.w	$32(a1)
		beq.s	locK_21D48
		move.l	#locK_21D4C,(a0)
		movea.w	$3E(a0),a1
		move.w	#1,$2E(a1)
		move.w	#0,$38(a1)
; loc3_20188:
locK_21D48:
		bra.w	locK_21F38
; ---------------------------------------------------------------------------
; loc3_2018C:
locK_21D4C:
		addi.l	#$80000,x_pos(a0)
		addi.l	#$20000,y_pos(a0)
		move.w	x_pos(a0),d0
		cmp.w	$46(a0),d0
		blo.w	locK_21DEE
		tst.b	subtype(a0)
		bpl.s	locK_21DC2
		move.l	#locK_21DF2,(a0)
		move.w	#$800,x_vel(a0)
		move.w	#$200,y_vel(a0)
		move.l	#Map_AnimatedStillSprites,mappings(a0)
		move.w	#make_art_tile(ArtTile_AIZMisc2,3,0),art_tile(a0)
		move.b	#8,width_pixels(a0)
		move.b	#$C,height_pixels(a0)
		move.b	#0,mapping_frame(a0)
		move.w	#1,anim(a0)
		movea.w	$40(a0),a1
		lea	$32(a1),a2
		tst.b	(a2)
		beq.s	locK_21DB6
		move.b	#$81,(a2)
; loc3_201F6:
locK_21DB6:
		addq.w	#1,a2
		tst.b	(a2)
		beq.s	locK_21DC0
		move.b	#$81,(a2)
; loc3_20200:
locK_21DC0:
		bra.s	locK_21DEE
; ---------------------------------------------------------------------------
; loc3_20202:
locK_21DC2:
		move.l	#locK_21E14,(a0)
		movea.w	$3E(a0),a1
		move.l	#locK_21FE8,(a1)
		move.w	#0,$3A(a1)
		movea.w	$40(a0),a1
		move.w	#1,$30(a1)
		move.w	#0,angle(a0)
		move.w	#$400,$3A(a0)
; loc3_2022E:
locK_21DEE:
		bra.w	locK_21F38
; ---------------------------------------------------------------------------
; loc3_20232:
locK_21DF2:
		jsr	(MoveSprite).l
		tst.b	render_flags(a0)
		bmi.s	locK_21E04
		move.w	#$7FF0,x_pos(a0)
; loc3_20244:
locK_21E04:
		lea	(Ani_AnimatedStillSprites).l,a1
		jsr	(Animate_Sprite).l
		bra.w	locK_21F38
; ---------------------------------------------------------------------------
; loc3_20254:
locK_21E14:
		movea.w	$40(a0),a1
		move.w	$3A(a0),d0
		move.b	angle(a0),d1
		ext.w	d1
		bpl.s	locK_21E26
		neg.w	d1
; loc3_20266:
locK_21E26:
		add.w	d1,d1
		sub.w	d1,d0
		sub.w	d0,angle(a0)
		tst.w	$32(a1)
		bne.s	locK_21E68
		move.b	angle(a0),d0
		addq.b	#8,d0
		cmpi.b	#$10,d0
		bhs.s	locK_21E68
		move.l	#locK_21E6C,(a0)
		move.w	#0,$42(a0)
		move.w	#-$300,$44(a0)
		move.w	#$1000,$38(a0)
		move.w	#0,$2E(a0)
		movea.w	$40(a0),a1
		move.w	#2,$30(a1)
; loc3_202A8:
locK_21E68:
		bra.w	locK_21F38
; ---------------------------------------------------------------------------
; loc3_202AC:
locK_21E6C:
		moveq	#0,d2
		move.b	$38(a0),d2
		move.w	$44(a0),d0
		move.w	#0,d1
		tst.w	$2E(a0)
		bne.s	locK_21EC4
		add.w	d2,d0
		move.w	d0,$44(a0)
		add.w	d0,$42(a0)
		cmp.b	$42(a0),d1
		bgt.s	locK_21EEE
		asr.w	#4,d0
		sub.w	d0,$44(a0)
		move.w	#1,$2E(a0)
		cmpi.w	#$C00,$38(a0)
		beq.s	locK_21EAC
		subi.w	#$40,$38(a0)
		bra.s	locK_21EEE
; ---------------------------------------------------------------------------
; loc3_202EC:
locK_21EAC:
		move.l	#locK_21F0A,(a0)
		move.w	#0,$38(a0)
		movea.w	$40(a0),a1
		move.w	#0,$30(a1)
		bra.s	locK_21EEE
; ---------------------------------------------------------------------------
; loc3_20304:
locK_21EC4:
		sub.w	d2,d0
		move.w	d0,$44(a0)
		add.w	d0,$42(a0)
		cmp.b	$42(a0),d1
		ble.s	locK_21EEE
		asr.w	#4,d0
		sub.w	d0,$44(a0)
		move.w	#0,$2E(a0)
		cmpi.w	#$C00,$38(a0)
		beq.s	locK_21EAC
		subi.w	#$40,$38(a0)
; loc3_2032E:
locK_21EEE:
		move.w	$42(a0),d0
		move.w	d0,angle(a0)
		asr.w	#3,d0
		move.w	d0,$3A(a0)
		movea.w	$3E(a0),a1
		move.w	$3A(a0),$3A(a1)
		bra.w	locK_21F38
; ---------------------------------------------------------------------------
; loc3_2034A:
locK_21F0A:
		move.b	$38(a0),d0
		addi.w	#$200,$38(a0)
		jsr	(GetSineCosine).l
		asl.w	#2,d0
		cmpi.w	#$400,d0
		bne.s	locK_21F26
		move.w	#$3FF,d0
; loc3_20366:
locK_21F26:
		move.w	d0,angle(a0)
		move.w	d0,$3A(a0)
		movea.w	$3E(a0),a1
		move.w	$3A(a0),$3A(a1)
; loc3_20378:
locK_21F38:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	locK_21F52
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_20392:
locK_21F52:
		move.w	$36(a0),d2
		subq.w	#1,d2
		bcs.s	locK_21F6E
		movea.w	$3E(a0),a2
; loc3_2039E:
locK_21F5E:
		movea.l	a2,a1
		movea.w	$3E(a1),a2
		jsr	(Delete_Referenced_Sprite).l
		dbf	d2,locK_21F5E
; loc3_203AE:
locK_21F6E:
		move.w	respawn_addr(a0),d0
		beq.s	locK_21F7A
		movea.w	d0,a2
		bclr	#7,(a2)
; loc3_203BA:
locK_21F7A:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
; loc3_203C0:
locK_21F80:
		tst.w	$2E(a0)
		bne.s	locK_21FA8
		move.b	$38(a0),d0
		addi.w	#$200,$38(a0)
		jsr	(GetSineCosine).l
		asl.w	#2,d0
		cmpi.w	#$400,d0
		bne.s	locK_21FA2
		move.w	#$3FF,d0
; loc3_203E2:
locK_21FA2:
		move.w	d0,$3A(a0)
		bra.s	locK_21FBE
; ---------------------------------------------------------------------------
; loc3_203E8:
locK_21FA8:
		move.b	$38(a0),d0
		addi.w	#$100,$38(a0)
		jsr	(GetSineCosine).l
		asl.w	#3,d0
		move.w	d0,$3A(a0)
; loc3_203FE:
locK_21FBE:
		move.w	$3A(a0),d0
		move.w	d0,angle(a0)
		move.b	angle(a0),d0
		addq.b	#4,d0
		lsr.b	#3,d0
		move.b	d0,mapping_frame(a0)
		movea.w	$3C(a0),a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_20428:
locK_21FE8:
		movea.w	$3C(a0),a1
		move.w	angle(a1),angle(a0)
		move.b	angle(a0),d0
		addq.b	#4,d0
		lsr.b	#3,d0
		move.b	d0,mapping_frame(a0)
		movea.w	$3C(a0),a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_20454:
locK_22014:
		movea.w	$3C(a0),a1
		move.w	$3A(a1),$3A(a0)
		move.w	angle(a1),d0
		add.w	$3A(a0),d0
		move.w	d0,angle(a0)
		move.b	angle(a0),d0
		addq.b	#4,d0
		lsr.b	#3,d0
		move.b	d0,mapping_frame(a0)
		bsr.w	subK_22040
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================

; sub3_20480:
subK_22040:
		movea.w	$3C(a0),a1
		move.b	angle(a1),d0
		addq.b	#4,d0
		andi.b	#$F8,d0
		jsr	(GetSineCosine).l
		neg.w	d0
		addi.w	#8,d0
		addi.w	#8,d1
		asr.w	#4,d0
		asr.w	#4,d1
		add.w	x_pos(a1),d0
		move.w	d0,x_pos(a0)
		add.w	y_pos(a1),d1
		move.w	d1,y_pos(a0)
		rts
; End of function subK_22040

; ---------------------------------------------------------------------------

Obj_AIZRideVineHandle:
		move.w	x_pos(a0),d4
		move.w	y_pos(a0),d5
		bsr.w	subK_22040
		cmp.w	x_pos(a0),d4
		beq.s	locK_2208A
		move.w	d4,$42(a0)
; loc3_204CA:
locK_2208A:
		cmp.w	y_pos(a0),d5
		beq.s	locK_22094
		move.w	d5,$44(a0)
; loc3_204D4:
locK_22094:
		lea	$32(a0),a2
		lea	(Player_1).w,a1
		move.w	(Ctrl_1_logical).w,d0
		bsr.s	subK_220C2
		lea	(Player_2).w,a1
		addq.w	#1,a2
		move.w	(Ctrl_2_logical).w,d0
		bsr.s	subK_220C2
		tst.w	$32(a0)
		beq.s	locK_220BA
		tst.w	$30(a0)
		bne.s	locretK_220C0
; loc3_204FA:
locK_220BA:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; locret3_20500:
locretK_220C0:
		rts

; =============== S U B R O U T I N E =======================================

; sub3_20502:
subK_220C2:
		tst.b	(a2)
		beq.w	locK_222F4
		bmi.w	locK_2217E
		tst.b	render_flags(a1)
		bpl.w	locK_22190
		cmpi.b	#4,routine(a1)
		bhs.w	locK_22190
	if Sonic3_Alone
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
	else
		move.b	d0,d1
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d1
	endif
		beq.w	locK_221EC
		clr.b	object_control(a1)
		clr.b	(a2)
		cmpi.w	#1,$30(a0)
		beq.s	locK_2215C
		move.w	x_pos(a0),d1
		sub.w	$42(a0),d1
		asl.w	#7,d1
		move.w	d1,x_vel(a1)
		move.w	y_pos(a0),d1
		sub.w	$44(a0),d1
		asl.w	#7,d1
		move.w	d1,y_vel(a1)
		move.b	#$3C,2(a2)
		btst	#button_left+8,d0
		beq.s	locK_22124
		move.w	#-$200,x_vel(a1)
; loc3_20562:
locK_22124:
		btst	#button_right+8,d0
		beq.s	locK_22130
		move.w	#$200,x_vel(a1)
; loc3_2056E:
locK_22130:
		addi.w	#-$380,y_vel(a1)
; loc3_20574:
locK_22136:
		bset	#Status_InAir,status(a1)
		move.b	#1,jumping(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		move.b	#2,anim(a1)
		bset	#Status_Roll,status(a1)
		rts
; ---------------------------------------------------------------------------
; loc3_2059A:
locK_2215C:
		move.b	#$3C,2(a2)
		movea.w	$3C(a0),a3
		move.b	angle(a3),d0
		jsr	(GetSineCosine).l
		asl.w	#3,d1
		move.w	d1,x_vel(a1)
		asl.w	#3,d0
		move.w	d0,y_vel(a1)
		bra.s	locK_22136
; ---------------------------------------------------------------------------
; loc3_205BC:
locK_2217E:
		move.w	#$300,x_vel(a1)
		move.w	#$200,y_vel(a1)
		bset	#Status_InAir,status(a1)
; loc3_205CE:
locK_22190:
		clr.b	object_control(a1)
		clr.b	(a2)
		move.b	#$3C,2(a2)
		rts
; End of function subK_220C2


	if ~~Sonic3_Alone
; =============== S U B R O U T I N E =======================================


subK_2219E:
		cmpa.w	#Player_1,a1
		bne.s	locretK_221E0
		tst.b	d0
		beq.s	locretK_221E0
		moveq	#0,d1
		move.b	$25(a0),d1
		cmp.b	byteK_221E2(pc,d1.w),d0
		bne.s	locK_221DA
		addq.b	#1,$25(a0)
		move.b	byteK_221E2+1(pc,d1.w),d1
		bne.s	locretK_221E0

		moveq	#0,d1				; what the fuck
		subi.w	#-Level_select_flag,d1
		movea.w	d1,a4

		moveq	#1,d1
		move.b	d1,(a4)
		move.b	d1,Slow_motion_flag-Level_select_flag(a4)
		move.w	d0,d1
		moveq	#signextendB(sfx_RingRight),d0
		jsr	(Play_SFX).l
		move.w	d1,d0

locK_221DA:
		move.b	#0,$25(a0)

locretK_221E0:
		rts
; End of function subK_2219E

; ---------------------------------------------------------------------------
byteK_221E2:
		dc.b button_left_mask
		dc.b button_left_mask
		dc.b button_left_mask
		dc.b button_right_mask
		dc.b button_right_mask
		dc.b button_right_mask
		dc.b button_up_mask
		dc.b button_up_mask
		dc.b button_up_mask
		dc.b 0
		even
	endif
; ---------------------------------------------------------------------------
; loc3_205DC:
locK_221EC:
		tst.w	$30(a0)
		bne.s	locK_22258
	if ~~Sonic3_Alone
		bsr.s	subK_2219E
	endif
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		addi.w	#$14,y_pos(a1)
		movea.w	$3C(a0),a3
		moveq	#0,d0
		move.b	angle(a3),d0
		btst	#Status_Facing,status(a1)
		beq.s	locK_2221A
		neg.b	d0
; loc3_20608:
locK_2221A:
		addq.b	#8,d0
		lsr.w	#4,d0
		move.b	byteK_22248(pc,d0.w),mapping_frame(a1)

locK_22224:
	if ~~Sonic3_Alone
		move.b	status(a1),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a1)
		or.b	d1,render_flags(a1)
	endif
		moveq	#0,d0
		move.b	mapping_frame(a1),d0
		move.l	a2,-(sp)
		jsr	(Perform_Player_DPLC).l
		movea.l	(sp)+,a2
		rts
; ---------------------------------------------------------------------------
; byte3_20624:
byteK_22248:
		dc.b  $91, $91, $90, $90, $90, $90, $90, $90, $92, $92, $92, $92, $92, $92, $91, $91
		even
; ---------------------------------------------------------------------------
; loc3_20634:
locK_22258:
		movea.w	$3C(a0),a3
		moveq	#0,d0
		move.b	angle(a3),d0
		btst	#Status_Facing,status(a1)
		beq.s	locK_2226C
		neg.b	d0
; loc3_20648:
locK_2226C:
		addi.b	#$10,d0
		lsr.w	#5,d0
		add.w	d0,d0
		move.b	byteK_222D4(pc,d0.w),mapping_frame(a1)
		move.b	#0,anim(a1)
		andi.w	#$FFFE,d0
		move.b	byteK_222E4(pc,d0.w),d2
		move.b	byteK_222E4+1(pc,d0.w),d3
		ext.w	d2
		ext.w	d3
		btst	#Status_Facing,status(a1)
		beq.s	locK_2229A
		neg.w	d2
; loc3_20676:
locK_2229A:
		movea.w	$3C(a0),a3
		move.b	angle(a3),d0
		addq.b	#4,d0
		andi.b	#$F8,d0
		jsr	(GetSineCosine).l
		neg.w	d0
		addi.w	#8,d0
		addi.w	#8,d1
		asr.w	#4,d0
		asr.w	#4,d1
		add.w	x_pos(a3),d0
		add.w	d2,d0
		move.w	d0,x_pos(a1)
		add.w	y_pos(a3),d1
		add.w	d3,d1
		move.w	d1,y_pos(a1)
	if Sonic3_Alone
		moveq	#0,d0
		move.b	mapping_frame(a1),d0
		move.l	a2,-(sp)
		jsr	(Perform_Player_DPLC).l
		movea.l	(sp)+,a2
		rts
	else
		bra.w	locK_22224
	endif
; ---------------------------------------------------------------------------
; byte3_206BE:
byteK_222D4:
		dc.b  $78
		dc.b  $78
		dc.b  $7F
		dc.b  $7F
		dc.b  $7E
		dc.b  $7E
		dc.b  $7D
		dc.b  $7D
		dc.b  $7C
		dc.b  $7C
		dc.b  $7B
		dc.b  $7B
		dc.b  $7A
		dc.b  $7A
		dc.b  $79
		dc.b  $79
; byte3_206CE:
byteK_222E4:
		dc.b    0, $18
		dc.b -$12, $13
		dc.b -$18,   0
		dc.b -$12,-$13
		dc.b    0,-$18
		dc.b  $12,-$13
		dc.b  $18,   0
		dc.b  $12, $13
		even
; ---------------------------------------------------------------------------
; loc3_206DE:
locK_222F4:
		tst.b	2(a2)
		beq.s	locK_22302
		subq.b	#1,2(a2)
		bne.w	locretK_2237C
; loc3_206EC:
locK_22302:
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		addi.w	#$10,d0
		cmpi.w	#$20,d0
		bhs.w	locretK_2237C
		move.w	y_pos(a1),d1
		sub.w	y_pos(a0),d1
		cmpi.w	#$18,d1
		bhs.w	locretK_2237C
		tst.b	object_control(a1)
		bne.s	locretK_2237C
		cmpi.b	#4,routine(a1)
		bhs.s	locretK_2237C
		tst.w	(Debug_placement_mode).w
		bne.s	locretK_2237C
		clr.w	x_vel(a1)
		clr.w	y_vel(a1)
		clr.w	ground_vel(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		addi.w	#$14,y_pos(a1)
		move.b	#$14,anim(a1)
		move.b	#0,spin_dash_flag(a1)
		move.b	#3,object_control(a1)
		andi.b	#$FD,render_flags(a1)
		move.b	#1,(a2)
		moveq	#signextendB(sfx_Grab),d0
		jsr	(Play_SFX).l
; locret3_20766:
locretK_2237C:
		rts
; ---------------------------------------------------------------------------

Obj_AIZGiantRideVine:
		movea.l	a0,a1
		move.l	#locK_22442,(a1)
		bsr.w	subK_2241A
		move.b	#$21,mapping_frame(a1)
		move.w	x_pos(a0),d2
		move.w	y_pos(a0),d3
		move.b	subtype(a0),d1
		andi.w	#$F,d1
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	locK_22418
		move.w	#-$1B0,$44(a1)
		move.w	#$800,$38(a1)
		move.w	a1,$3E(a0)
		move.l	#locK_2248A,(a1)
		move.w	a0,$3C(a1)
		move.b	subtype(a0),d0
		andi.b	#$F0,d0
		move.b	d0,$42(a1)
		bra.s	locK_223EA
; ---------------------------------------------------------------------------
; loc3_207BC:
locK_223D2:
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	locK_22418
		move.l	#locK_2251E,(a1)
		move.w	a2,$3C(a1)
		move.w	a1,$3E(a2)
; loc3_207D4:
locK_223EA:
		movea.l	a1,a2
		bsr.s	subK_2241A
		move.w	d2,x_pos(a1)
		move.w	d3,y_pos(a1)
		addi.w	#$10,d3
		addq.w	#1,$36(a0)
		move.w	$36(a0),$36(a1)
		dbf	d1,locK_223D2
		move.l	#locK_2257E,(a1)
		move.b	#$20,mapping_frame(a1)
		move.w	a1,$40(a0)
; loc3_20802:
locK_22418:
		bra.s	locK_22442

; =============== S U B R O U T I N E =======================================

; sub3_20804:
subK_2241A:
		move.b	#4,render_flags(a1)
		move.b	#8,width_pixels(a1)
		move.b	#8,height_pixels(a1)
		move.w	#$200,priority(a1)
	if Sonic3_Alone
		move.l	#Map_AIZRideVine,mappings(a1)
	else
		move.l	#Map_AIZMHZRideVine,mappings(a1)
	endif
		move.w	#make_art_tile(ArtTile_AIZSwingVine,0,0),art_tile(a1)
		rts
; End of function subK_2241A

; ---------------------------------------------------------------------------
; loc3_2082C:
locK_22442:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	locK_2245C
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_20846:
locK_2245C:
		move.w	$36(a0),d2
		subq.w	#1,d2
		bcs.s	locK_22478
		movea.w	$3E(a0),a2
; loc3_20852:
locK_22468:
		movea.l	a2,a1
		movea.w	$3E(a1),a2
		jsr	(Delete_Referenced_Sprite).l
		dbf	d2,locK_22468
; loc3_20862:
locK_22478:
		move.w	respawn_addr(a0),d0
		beq.s	locK_22484
		movea.w	d0,a2
		bclr	#7,(a2)
; loc3_2086E:
locK_22484:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
; loc3_20874:
locK_2248A:
		tst.b	(a0)
		bne.s	locK_224BC
		move.b	(AIZ_vine_angle).w,d0
		add.b	$42(a0),d0
		jsr	(GetSineCosine).l
		muls.w	#$2C,d0
		move.w	d0,angle(a0)
		asr.w	#3,d0
		move.w	d0,$3A(a0)
		move.b	angle(a0),d0
		addq.b	#4,d0
		lsr.b	#3,d0
		move.b	d0,mapping_frame(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_208A6:
locK_224BC:
		moveq	#0,d2
		move.b	$38(a0),d2
		move.w	$44(a0),d0
		move.w	#0,d1
		tst.w	$2E(a0)
		bne.s	locK_224E8
		add.w	d2,d0
		move.w	d0,$44(a0)
		add.w	d0,$42(a0)
		cmp.b	$42(a0),d1
		bgt.s	locK_224FE
		move.w	#1,$2E(a0)
		bra.s	locK_224FE
; ---------------------------------------------------------------------------
; loc3_208D2:
locK_224E8:
		sub.w	d2,d0
		move.w	d0,$44(a0)
		add.w	d0,$42(a0)
		cmp.b	$42(a0),d1
		ble.s	locK_224FE
		move.w	#0,$2E(a0)
; loc3_208E8:
locK_224FE:
		move.w	$42(a0),d0
		move.w	d0,angle(a0)
		asr.w	#3,d0
		move.w	d0,$3A(a0)
		move.b	angle(a0),d0
		addq.b	#4,d0
		lsr.b	#3,d0
		move.b	d0,mapping_frame(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_20908:
locK_2251E:
		movea.w	$3C(a0),a1
		move.w	$3A(a1),$3A(a0)
		move.w	angle(a1),d0
		add.w	$3A(a0),d0
		move.w	d0,angle(a0)
		move.b	angle(a0),d0
		addq.b	#4,d0
		lsr.b	#3,d0
		move.b	d0,mapping_frame(a0)
		bsr.w	subK_2254A
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================

; sub3_20934:
subK_2254A:
		movea.w	$3C(a0),a1
		move.b	angle(a1),d0
		addq.b	#4,d0
		andi.b	#$F8,d0
		jsr	(GetSineCosine).l
		neg.w	d0
		addi.w	#8,d0
		addi.w	#8,d1
		asr.w	#4,d0
		asr.w	#4,d1
		add.w	x_pos(a1),d0
		move.w	d0,x_pos(a0)
		add.w	y_pos(a1),d1
		move.w	d1,y_pos(a0)
		rts
; End of function subK_2254A

; ---------------------------------------------------------------------------
; loc3_20968L
locK_2257E:
		move.w	x_pos(a0),d4
		move.w	y_pos(a0),d5
		bsr.w	subK_2254A
		cmp.w	x_pos(a0),d4
		beq.s	locK_22594
		move.w	d4,$42(a0)
; loc3_2097E:
locK_22594:
		cmp.w	y_pos(a0),d5
		beq.s	locK_2259E
		move.w	d5,$44(a0)
; loc3_20988:
locK_2259E:
		lea	$32(a0),a2
		lea	(Player_1).w,a1
		move.w	(Ctrl_1_logical).w,d0
		bsr.w	subK_220C2
		lea	(Player_2).w,a1
		addq.w	#1,a2
		move.w	(Ctrl_2_logical).w,d0
		bsr.w	subK_220C2
		tst.w	$32(a0)
		beq.s	locK_225C8
		tst.w	$30(a0)
		bne.s	locretK_225CE
; loc3_209B2:
locK_225C8:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; locret3_209B8:
locretK_225CE:
		rts
; ---------------------------------------------------------------------------
	if Sonic3_Alone
Map_AIZRideVine:
		include "Levels/AIZ/Misc Object Data/Map - Ride Vine S3.asm"

	endif