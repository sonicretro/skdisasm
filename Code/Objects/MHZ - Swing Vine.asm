; ---------------------------------------------------------------------------

Obj_MHZSwingVine:
		movea.l	a0,a1
		move.l	#locK_2267E,(a1)
		bsr.w	subK_22656
		move.b	#$23,mapping_frame(a1)
		move.w	x_pos(a0),d2
		move.w	y_pos(a0),d3
		moveq	#0,d1
		addq.w	#1,d1
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	locK_22654
		move.w	a1,$3E(a0)
		move.l	#locK_2286C,(a1)
		move.w	a0,$3C(a1)
		bra.s	locK_2261A
; ---------------------------------------------------------------------------

locK_22608:
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	locK_22654
		move.w	a2,$3C(a1)
		move.w	a1,$3E(a2)

locK_2261A:
		movea.l	a1,a2
		bsr.s	subK_22656
		move.w	d2,x_pos(a1)
		move.w	d3,y_pos(a1)
		addi.w	#$10,d3
		addq.w	#1,$36(a0)
		move.w	$36(a0),$36(a1)
		dbf	d1,locK_22608
		move.l	#locK_228CC,(a1)
		move.b	#$22,mapping_frame(a1)
		move.w	x_pos(a1),$42(a1)
		move.w	y_pos(a1),$44(a1)
		move.w	a1,$40(a0)

locK_22654:
		bra.s	locK_2267E

; =============== S U B R O U T I N E =======================================


subK_22656:
		move.b	#4,render_flags(a1)
		move.b	#8,width_pixels(a1)
		move.b	#8,height_pixels(a1)
		move.w	#$200,priority(a1)
		move.l	#Map_AIZMHZRideVine,mappings(a1)
		move.w	#make_art_tile(ArtTile_MHZMisc+$10E,0,0),art_tile(a1)
		rts
; End of function subK_22656

; ---------------------------------------------------------------------------

locK_2267E:
		movea.w	$40(a0),a1
		tst.w	$32(a1)
		beq.s	locK_226AC
		bmi.s	locK_22690
		tst.b	$33(a1)
		bpl.s	locK_226AC

locK_22690:
		move.l	#locK_226B0,(a0)
		movea.w	$40(a0),a1
		move.w	#1,$30(a1)
		move.w	#0,angle(a0)
		move.w	#$800,$3A(a0)

locK_226AC:
		bra.w	locK_22824
; ---------------------------------------------------------------------------

locK_226B0:
		movea.w	$40(a0),a1
		move.w	$3A(a0),d0
		move.b	angle(a0),d1
		ext.w	d1
		bpl.s	locK_226C2
		neg.w	d1

locK_226C2:
		add.w	d1,d1
		sub.w	d1,d0
		sub.w	d0,angle(a0)
		move.b	angle(a0),d0
		andi.b	#$F8,d0
		cmpi.b	#$40,d0
		bne.s	locK_226E0
		moveq	#signextendB(sfx_GroundSlide),d0
		jsr	(Play_SFX).l

locK_226E0:
		move.w	#$200,priority(a0)
		tst.w	angle(a0)
		bpl.s	locK_226F2
		move.w	#$280,priority(a0)

locK_226F2:
		tst.b	$32(a1)
		beq.s	locK_2270A
		move.b	#1,(Scroll_force_positions).w
		move.w	x_pos(a0),(Scroll_forced_X_pos).w
		move.w	y_pos(a0),(Scroll_forced_Y_pos).w

locK_2270A:
		tst.w	$32(a1)
		bne.s	locK_22744
		move.b	angle(a0),d0
		addq.b	#8,d0
		cmpi.b	#$10,d0
		bhs.s	locK_22744
		move.l	#locK_22748,(a0)
		move.w	#0,$42(a0)
		move.w	#-$300,$44(a0)
		move.w	#$1000,$38(a0)
		move.w	#0,$2E(a0)
		movea.w	$40(a0),a1
		move.w	#2,$30(a1)

locK_22744:
		bra.w	locK_22824
; ---------------------------------------------------------------------------

locK_22748:
		moveq	#0,d2
		move.b	$38(a0),d2
		move.w	$44(a0),d0
		move.w	#0,d1
		tst.w	$2E(a0)
		bne.s	locK_227AC
		add.w	d2,d0
		move.w	d0,$44(a0)
		add.w	d0,$42(a0)
		cmp.b	$42(a0),d1
		bgt.s	locK_227D6
		asr.w	#4,d0
		sub.w	d0,$44(a0)
		move.w	#1,$2E(a0)
		cmpi.w	#$C00,$38(a0)
		beq.s	locK_22788
		subi.w	#$40,$38(a0)
		bra.s	locK_227D6
; ---------------------------------------------------------------------------

locK_22788:
		move.l	#locK_2267E,(a0)
		move.w	#0,$38(a0)
		movea.w	$40(a0),a1
		move.w	#0,$30(a1)
		move.w	x_pos(a1),$42(a1)
		move.w	y_pos(a1),$44(a1)
		bra.s	locK_227D6
; ---------------------------------------------------------------------------

locK_227AC:
		sub.w	d2,d0
		move.w	d0,$44(a0)
		add.w	d0,$42(a0)
		cmp.b	$42(a0),d1
		ble.s	locK_227D6
		asr.w	#4,d0
		sub.w	d0,$44(a0)
		move.w	#0,$2E(a0)
		cmpi.w	#$C00,$38(a0)
		beq.s	locK_22788
		subi.w	#$40,$38(a0)

locK_227D6:
		move.w	$42(a0),d0
		move.w	d0,angle(a0)
		move.w	#$200,priority(a0)
		tst.w	angle(a0)
		bpl.s	locK_227F0
		move.w	#$280,priority(a0)

locK_227F0:
		asr.w	#3,d0
		move.w	d0,$3A(a0)
		movea.w	$3E(a0),a1
		move.w	$3A(a0),$3A(a1)
		movea.w	$40(a0),a1
		tst.w	$32(a1)
		beq.s	locK_22824
		bmi.s	locK_22812
		tst.b	$33(a1)
		bpl.s	locK_22824

locK_22812:
		move.l	#locK_226B0,(a0)
		move.w	#1,$30(a1)
		move.w	#$800,$3A(a0)

locK_22824:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	locK_2283E
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_2283E:
		move.w	$36(a0),d2
		subq.w	#1,d2
		bcs.s	locK_2285A
		movea.w	$3E(a0),a2

locK_2284A:
		movea.l	a2,a1
		movea.w	$3E(a1),a2
		jsr	(Delete_Referenced_Sprite).l
		dbf	d2,locK_2284A

locK_2285A:
		move.w	respawn_addr(a0),d0
		beq.s	locK_22866
		movea.w	d0,a2
		bclr	#7,(a2)

locK_22866:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locK_2286C:
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

; =============== S U B R O U T I N E =======================================


subK_22898:
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
; End of function subK_22898

; ---------------------------------------------------------------------------

locK_228CC:
		move.w	x_pos(a0),d4
		move.w	y_pos(a0),d5
		bsr.w	subK_22898
		cmp.w	x_pos(a0),d4
		beq.s	locK_228E2
		move.w	d4,$42(a0)

locK_228E2:
		cmp.w	y_pos(a0),d5
		beq.s	locK_228EC
		move.w	d5,$44(a0)

locK_228EC:
		lea	$32(a0),a2
		lea	(Player_1).w,a1
		move.w	(Ctrl_1_logical).w,d0
		bsr.s	locK_2291A
		lea	(Player_2).w,a1
		addq.w	#1,a2
		move.w	(Ctrl_2_logical).w,d0
		bsr.s	locK_2291A
		tst.w	$32(a0)
		beq.s	locK_22912
		tst.w	$30(a0)
		bne.s	locretK_22918

locK_22912:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locretK_22918:
		rts
; ---------------------------------------------------------------------------

locK_2291A:
		tst.b	(a2)
		beq.w	locK_22AF8
		tst.b	render_flags(a1)
		bpl.w	locK_229E4
		cmpi.b	#4,routine(a1)
		bhs.w	locK_229E4
		tst.w	(Debug_placement_mode).w
		bne.w	locK_229E4
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locK_229F2
		clr.b	object_control(a1)
		clr.b	(a2)
		cmpi.w	#1,$30(a0)
		beq.s	locK_229B6
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
		beq.s	locK_2297E
		move.w	#-$200,x_vel(a1)

locK_2297E:
		btst	#button_right+8,d0
		beq.s	locK_2298A
		move.w	#$200,x_vel(a1)

locK_2298A:
		addi.w	#-$380,y_vel(a1)

locK_22990:
		bset	#Status_InAir,status(a1)
		move.b	#1,$40(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		move.b	#2,anim(a1)
		bset	#Status_Roll,status(a1)
		rts
; ---------------------------------------------------------------------------

locK_229B6:
		move.b	#$3C,2(a2)
		movea.w	$3C(a0),a3
		move.b	angle(a3),d0
		jsr	(GetSineCosine).l
		asl.w	#2,d1
		move.w	d1,d2
		asl.w	#1,d1
		add.w	d2,d1
		move.w	d1,x_vel(a1)
		asl.w	#2,d0
		move.w	d0,d2
		asl.w	#1,d0
		add.w	d2,d0
		move.w	d0,y_vel(a1)
		bra.s	locK_22990
; ---------------------------------------------------------------------------

locK_229E4:
		clr.b	$2E(a1)
		clr.b	(a2)
		move.b	#$3C,2(a2)
		rts
; ---------------------------------------------------------------------------

locK_229F2:
		tst.w	$30(a0)
		bne.s	locK_22A5C
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		addi.w	#$14,y_pos(a1)
		movea.w	$3C(a0),a3
		moveq	#0,d0
		move.b	angle(a3),d0
		btst	#Status_Facing,status(a1)
		beq.s	locK_22A1E
		neg.b	d0

locK_22A1E:
		addq.b	#8,d0
		lsr.w	#4,d0
		move.b	byteK_22A4C(pc,d0.w),mapping_frame(a1)

locK_22A28:
		move.b	status(a1),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a1)
		or.b	d1,render_flags(a1)
		moveq	#0,d0
		move.b	mapping_frame(a1),d0
		move.l	a2,-(sp)
		jsr	(Perform_Player_DPLC).l
		movea.l	(sp)+,a2
		rts
; ---------------------------------------------------------------------------
byteK_22A4C:
		dc.b  $91, $91, $90, $90, $90, $90, $90, $90, $92, $92, $92, $92, $92, $92, $91, $91
		even
; ---------------------------------------------------------------------------

locK_22A5C:
		movea.w	$3C(a0),a3
		moveq	#0,d0
		move.b	angle(a3),d0
		btst	#Status_Facing,status(a1)
		beq.s	locK_22A70
		neg.b	d0

locK_22A70:
		addi.b	#$10,d0
		lsr.w	#5,d0
		add.w	d0,d0
		move.b	byteK_22AD8(pc,d0.w),mapping_frame(a1)
		move.b	#0,anim(a1)
		andi.w	#$FFFE,d0
		move.b	byteK_22AD8+$10(pc,d0.w),d2
		move.b	byteK_22AE9(pc,d0.w),d3
		ext.w	d2
		ext.w	d3
		btst	#Status_Facing,status(a1)
		beq.s	locK_22A9E
		neg.w	d2

locK_22A9E:
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
		bra.w	locK_22A28
; ---------------------------------------------------------------------------
byteK_22AD8:
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
		dc.b    0
byteK_22AE9:
		dc.b  $18
		dc.b -$12
		dc.b  $13
		dc.b -$18
		dc.b    0
		dc.b -$12
		dc.b -$13
		dc.b    0
		dc.b -$18
		dc.b  $12
		dc.b -$13
		dc.b  $18
		dc.b    0
		dc.b  $12
		dc.b  $13
		even
; ---------------------------------------------------------------------------

locK_22AF8:
		tst.b	2(a2)
		beq.s	locK_22B06
		subq.b	#1,2(a2)
		bne.w	locretK_22B9C

locK_22B06:
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		addi.w	#$10,d0
		cmpi.w	#$20,d0
		bhs.w	locretK_22B9C
		move.w	y_pos(a1),d1
		sub.w	y_pos(a0),d1
		cmpi.w	#$28,d1
		bhs.w	locretK_22B9C
		move.w	x_vel(a1),d0
		cmpi.w	#$400,d0
		bge.s	locK_22B3C
		cmpi.w	#$18,d1
		bhs.w	locretK_22B9C

locK_22B3C:
		tst.b	object_control(a1)
		bne.s	locretK_22B9C
		cmpi.b	#4,routine(a1)
		bhs.s	locretK_22B9C
		tst.w	(Debug_placement_mode).w
		bne.s	locretK_22B9C
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
		cmpi.w	#$400,d0
		blt.s	locK_22B3C
		move.b	#$81,(a2)
		moveq	#signextendB(sfx_Grab),d0
		jsr	(Play_SFX).l

locretK_22B9C:
		rts
; ---------------------------------------------------------------------------
Map_AIZMHZRideVine:
		include "Levels/AIZ/Misc Object Data/Map - (&MHZ) Ride Vine.asm"