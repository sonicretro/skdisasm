
; =============== S U B R O U T I N E =======================================


Obj_Spring:
		move.l	#Map_Spring,mappings(a0)
		move.w	#make_art_tile(ArtTile_SpikesSprings+$10,0,0),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$200,priority(a0)
		move.w	x_pos(a0),$32(a0)
		move.w	y_pos(a0),$34(a0)
		move.b	subtype(a0),d0
		lsr.w	#3,d0
		andi.w	#$E,d0
		move.w	Spring_Index(pc,d0.w),d0
		jmp	Spring_Index(pc,d0.w)
; End of function Obj_Spring

; ---------------------------------------------------------------------------

Spring_Index:
		dc.w Spring_Up-Spring_Index
		dc.w Spring_Horizontal-Spring_Index
		dc.w Spring_Down-Spring_Index
		dc.w Spring_UpDiag-Spring_Index
		dc.w Spring_DownDiag-Spring_Index

; =============== S U B R O U T I N E =======================================

; sub3_21426:
subK_22D54:
		move.l	#Map_Spring,mappings(a0)
		move.w	#make_art_tile(ArtTile_SpikesSprings+$10,0,0),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$200,priority(a0)
		move.w	x_pos(a0),$32(a0)
		move.w	y_pos(a0),$34(a0)
		move.b	subtype(a0),d0
		lsr.w	#3,d0
		andi.w	#$E,d0
		move.w	offK_22DA0(pc,d0.w),d0
		jsr	offK_22DA0(pc,d0.w)
		move.w	#-$800,$30(a0)
		rts
; End of function subK_22D54

; ---------------------------------------------------------------------------
; off3_21472:
offK_22DA0:
		dc.w Spring_Up-offK_22DA0
		dc.w Spring_Horizontal-offK_22DA0
		dc.w Spring_Down-offK_22DA0
		dc.w Spring_Horizontal-offK_22DA0
		dc.w Spring_Up-offK_22DA0
		dc.w Spring_Down-offK_22DA0
		dc.w Spring_Up-offK_22DA0
		dc.w Spring_Down-offK_22DA0
; ---------------------------------------------------------------------------

Spring_Horizontal:
		move.b	#2,anim(a0)
		move.b	#3,mapping_frame(a0)
		move.w	#make_art_tile(ArtTile_SpikesSprings+$20,0,0),art_tile(a0)
		move.b	#8,width_pixels(a0)
		move.l	#Obj_Spring_Horizontal,(a0)
		tst.w	(Competition_mode).w
		beq.w	Spring_Common
		move.l	#Map_2PSpring,mappings(a0)
		move.w	#make_art_tile(ArtTile_2PArt_1,0,0),art_tile(a0)
		move.l	#Obj_2PSpring_Horizontal,(a0)
		bra.w	Spring_Common
; ---------------------------------------------------------------------------

Spring_Down:
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		bne.w	locK_22E96
		bset	#1,status(a0)

locK_22DFC:
	endif
		move.b	#6,mapping_frame(a0)
	if Sonic3_Alone
		bset	#1,status(a0)
	endif
		move.l	#Obj_Spring_Down,(a0)
		tst.w	(Competition_mode).w
		beq.w	Spring_Common
		move.l	#Obj_2PSpring_Down,(a0)
		move.l	#Map_2PSpring,mappings(a0)
		move.w	#make_art_tile(ArtTile_2PArt_2,0,0),art_tile(a0)
		bra.w	Spring_Common
; ---------------------------------------------------------------------------

Spring_UpDiag:
		move.b	#4,anim(a0)
		move.b	#7,mapping_frame(a0)
		move.w	#make_art_tile(ArtTile_DiagonalSpring,0,0),art_tile(a0)
		cmpi.b	#2,(Current_zone).w
	if Sonic3_Alone
		bne.s	locK_22E50
	else
		beq.s	locK_22E4A
		cmpi.b	#7,(Current_zone).w
		bne.s	locK_22E50

locK_22E4A:
	endif
		move.w	#make_art_tile(ArtTile_MGZMHZDiagonalSpring,0,0),art_tile(a0)

locK_22E50:
		move.l	#Obj_Spring_UpDiag,(a0)
		bra.s	Spring_Common
; ---------------------------------------------------------------------------

Spring_DownDiag:
		move.b	#4,anim(a0)
		move.b	#$A,mapping_frame(a0)
		move.w	#make_art_tile(ArtTile_DiagonalSpring,0,0),art_tile(a0)
		cmpi.b	#2,(Current_zone).w
	if Sonic3_Alone
		bne.s	locK_22E80
	else
		beq.s	locK_22E7A
		cmpi.b	#7,(Current_zone).w
		bne.s	locK_22E80

locK_22E7A:
	endif
		move.w	#make_art_tile(ArtTile_MGZMHZDiagonalSpring,0,0),art_tile(a0)

locK_22E80:
		bset	#1,status(a0)
		move.l	#Obj_Spring_DownDiag,(a0)
		bra.s	Spring_Common
; ---------------------------------------------------------------------------

Spring_Up:
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		bne.w	locK_22DFC

locK_22E96:
	endif
		move.l	#Obj_Spring_Up,(a0)
		tst.w	(Competition_mode).w
		beq.s	Spring_Common
		move.l	#Obj_2PSpring_Up,(a0)
		move.l	#Map_2PSpring,mappings(a0)
		move.w	#make_art_tile(ArtTile_2PArt_2,0,0),art_tile(a0)
		cmpi.b	#$12,(Current_zone).w
		bne.s	Spring_Common
		ori.w	#high_priority,art_tile(a0)

Spring_Common:
		move.b	subtype(a0),d0
		andi.w	#2,d0
		move.w	wordK_22EF0(pc,d0.w),$30(a0)
		btst	#1,d0
		beq.s	locretK_22EEE
		move.l	#Map_Spring2,mappings(a0)
		tst.w	(Competition_mode).w
		beq.s	locretK_22EEE
		move.l	#Map_Spring3,mappings(a0)
; locret3_215A0:
locretK_22EEE:
		rts
; ---------------------------------------------------------------------------
; word3_215A2:
wordK_22EF0:
		dc.w -$1000
		dc.w  -$A00
; ---------------------------------------------------------------------------

Obj_Spring_Up:
		move.w	#$1B,d1
		move.w	#8,d2
		move.w	#$10,d3
		move.w	x_pos(a0),d4
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.w	SolidObjectFull2_1P
		btst	#p1_standing_bit,status(a0)
		beq.s	locK_22F1C
		bsr.s	subK_22F98
; loc3_215CE:
locK_22F1C:
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		bsr.w	SolidObjectFull2_1P
		btst	#p2_standing_bit,status(a0)
		beq.s	locK_22F34
		bsr.s	subK_22F98
; loc3_215E6:
locK_22F34:
		lea	(Ani_Spring).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

Obj_2PSpring_Up:
		move.w	#$13,d1
		move.w	#8,d2
		move.w	#$10,d3
		move.w	x_pos(a0),d4
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.w	SolidObjectFull2_1P
		btst	#p1_standing_bit,status(a0)
		beq.s	locK_22F6E
		bsr.s	subK_22F98
; loc3_21620:
locK_22F6E:
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		bsr.w	SolidObjectFull2_1P
		btst	#p2_standing_bit,status(a0)
		beq.s	locK_22F86
		bsr.s	subK_22F98
; loc3_21638:
locK_22F86:
		lea	(Ani_Spring).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================

; sub3_2164A:
subK_22F98:
		move.w	#1<<8,anim(a0)	; and prev_anim
		addq.w	#8,y_pos(a1)
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_22FAE
		subi.w	#2*8,y_pos(a1)

locK_22FAE:
	endif
		move.w	$30(a0),y_vel(a1)
		bset	#Status_InAir,status(a1)
		bclr	#Status_OnObj,status(a1)
		clr.b	jumping(a1)
		clr.b	spin_dash_flag(a1)
		move.b	#$10,anim(a1)
		move.b	#2,routine(a1)
		move.b	subtype(a0),d0
		bpl.s	locK_22FE0
		move.w	#0,x_vel(a1)
; loc3_21686:
locK_22FE0:
		btst	#0,d0
		beq.s	locK_23020
		move.w	#1,ground_vel(a1)
		move.b	#1,flip_angle(a1)
		move.b	#0,anim(a1)
		move.b	#0,flips_remaining(a1)
		move.b	#4,flip_speed(a1)
		btst	#1,d0
		bne.s	locK_23010
		move.b	#1,flips_remaining(a1)
; loc3_216B6:
locK_23010:
		btst	#Status_Facing,status(a1)
		beq.s	locK_23020
		neg.b	flip_angle(a1)
		neg.w	ground_vel(a1)
; loc3_216C6:
locK_23020:
		andi.b	#$C,d0
		cmpi.b	#4,d0
		bne.s	locK_23036
		move.b	#$C,top_solid_bit(a1)
		move.b	#$D,lrb_solid_bit(a1)
; loc3_216DC:
locK_23036:
		cmpi.b	#8,d0
		bne.s	locK_23048
		move.b	#$E,top_solid_bit(a1)
		move.b	#$F,lrb_solid_bit(a1)
; loc3_216EE:
locK_23048:
		moveq	#signextendB(sfx_Spring),d0
		jmp	(Play_SFX).l
; End of function subK_22F98

; ---------------------------------------------------------------------------

Obj_Spring_Horizontal:
		move.w	#$13,d1
		move.w	#$E,d2
		move.w	#$F,d3
		move.w	x_pos(a0),d4
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.w	SolidObjectFull2_1P
		swap	d6
		andi.w	#1,d6
		beq.s	locK_23092
		move.b	status(a0),d1
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bcs.s	locK_23088
		eori.b	#1,d1
; loc3_2172E:
locK_23088:
		andi.b	#1,d1
		bne.s	locK_23092
		bsr.w	subK_23190
; loc3_21738:
locK_23092:
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		bsr.w	SolidObjectFull2_1P
		swap	d6
		andi.w	#2,d6
		beq.s	locK_230C4
		move.b	status(a0),d1
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bcs.s	locK_230BA
		eori.b	#1,d1
; loc3_21760:
locK_230BA:
		andi.b	#1,d1
		bne.s	locK_230C4
		bsr.w	subK_23190
; loc3_2176A:
locK_230C4:
		bsr.w	subK_2326C
		lea	(Ani_Spring).l,a1
		jsr	(Animate_Sprite).l
		move.w	$32(a0),d0
		jmp	(Sprite_OnScreen_Test2).l
; ---------------------------------------------------------------------------

Obj_2PSpring_Horizontal:
		move.w	#$F,d1
		move.w	#$C,d2
		move.w	#$D,d3
		move.w	x_pos(a0),d4
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.w	SolidObjectFull2_1P
		swap	d6
		andi.w	#1,d6
		beq.s	locK_2311E
		move.b	status(a0),d1
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bcs.s	locK_23116
		eori.b	#1,d1
; loc3_217BC:
locK_23116:
		andi.b	#1,d1
		bne.s	locK_2311E
		bsr.s	subK_23160
; loc3_217C4:
locK_2311E:
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		bsr.w	SolidObjectFull2_1P
		swap	d6
		andi.w	#2,d6
		beq.s	locK_2314E
		move.b	status(a0),d1
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bcs.s	locK_23146
		eori.b	#1,d1
; loc3_217EC:
locK_23146:
		andi.b	#1,d1
		bne.s	locK_2314E
		bsr.s	subK_23160
; loc3_217F4:
locK_2314E:
		lea	(Ani_Spring).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================

; sub3_21806:
subK_23160:
		move.w	#3<<8,anim(a0)	; and prev_anim
		move.w	$30(a0),x_vel(a1)
		addq.w	#4,x_pos(a1)
		bset	#Status_Facing,status(a1)
		btst	#0,status(a0)
		bne.s	locK_2318E
		bclr	#Status_Facing,status(a1)
		subi.w	#2*4,x_pos(a1)
		neg.w	x_vel(a1)
; loc3_21834:
locK_2318E:
		bra.s	locK_231BE
; End of function subK_23160


; =============== S U B R O U T I N E =======================================

; sub3_21836:
subK_23190:
		move.w	#3<<8,anim(a0)	; and prev_anim
		move.w	$30(a0),x_vel(a1)
		addq.w	#8,x_pos(a1)
		bset	#Status_Facing,status(a1)
		btst	#0,status(a0)
		bne.s	locK_231BE
		bclr	#Status_Facing,status(a1)
		subi.w	#2*8,x_pos(a1)
		neg.w	x_vel(a1)
; loc3_21864:
locK_231BE:
		move.w	#$F,$32(a1)
		move.w	x_vel(a1),ground_vel(a1)
		btst	#Status_Roll,status(a1)
		bne.s	locK_231D8
		move.b	#0,anim(a1)
; loc3_2187E:
locK_231D8:
		move.b	subtype(a0),d0
		bpl.s	locK_231E4
		move.w	#0,y_vel(a1)
; loc3_2188A:
locK_231E4:
		btst	#0,d0
		beq.s	locK_23224
		move.w	#1,ground_vel(a1)
		move.b	#1,flip_angle(a1)
		move.b	#0,anim(a1)
		move.b	#1,flips_remaining(a1)
		move.b	#8,flip_speed(a1)
		btst	#1,d0
		bne.s	locK_23214
		move.b	#3,flips_remaining(a1)
; loc3_218BA:
locK_23214:
		btst	#Status_Facing,status(a1)
		beq.s	locK_23224
		neg.b	flip_angle(a1)
		neg.w	ground_vel(a1)
; loc3_218CA:
locK_23224:
		andi.b	#$C,d0
		cmpi.b	#4,d0
		bne.s	locK_2323A
		move.b	#$C,top_solid_bit(a1)
		move.b	#$D,lrb_solid_bit(a1)
; loc3_218E0:
locK_2323A:
		cmpi.b	#8,d0
		bne.s	locK_2324C
		move.b	#$E,top_solid_bit(a1)
		move.b	#$F,lrb_solid_bit(a1)
; loc_218F2:
locK_2324C:
		bclr	#p1_pushing_bit,status(a0)
		bclr	#p2_pushing_bit,status(a0)
		bclr	#Status_Push,status(a1)
	if ~~Sonic3_Alone
		move.b	#0,double_jump_flag(a1)
	endif
		moveq	#signextendB(sfx_Spring),d0
		jmp	(Play_SFX).l
; End of function subK_23190


; =============== S U B R O U T I N E =======================================

; sub3_2190C:
subK_2326C:
		cmpi.b	#3,anim(a0)
		beq.w	locretK_23324
		move.w	x_pos(a0),d0
		move.w	d0,d1
		addi.w	#$28,d1
		btst	#0,status(a0)
		beq.s	locK_2328E
		move.w	d0,d1
		subi.w	#$28,d0
; loc3_2192E:
locK_2328E:
		move.w	y_pos(a0),d2
		move.w	d2,d3
		subi.w	#$18,d2
		addi.w	#$18,d3
		lea	(Player_1).w,a1
		btst	#Status_InAir,status(a1)
		bne.s	locK_232E2
		move.w	ground_vel(a1),d4
		btst	#0,status(a0)
		beq.s	locK_232B6
		neg.w	d4
; loc3_21956:
locK_232B6:
		tst.w	d4
		bmi.s	locK_232E2
		move.w	x_pos(a1),d4
		cmp.w	d0,d4
		blo.w	locK_232E2
		cmp.w	d1,d4
		bhs.w	locK_232E2
		move.w	y_pos(a1),d4
		cmp.w	d2,d4
		blo.w	locK_232E2
		cmp.w	d3,d4
		bhs.w	locK_232E2
		move.w	d0,-(sp)
		bsr.w	subK_23190
		move.w	(sp)+,d0
; loc3_21982:
locK_232E2:
		lea	(Player_2).w,a1
		btst	#Status_InAir,status(a1)
		bne.s	locretK_23324
		move.w	ground_vel(a1),d4
		btst	#0,status(a0)
		beq.s	locK_232FC
		neg.w	d4
; loc3_2199C:
locK_232FC:
		tst.w	d4
		bmi.s	locretK_23324
		move.w	x_pos(a1),d4
		cmp.w	d0,d4
		blo.w	locretK_23324
		cmp.w	d1,d4
		bhs.w	locretK_23324
		move.w	y_pos(a1),d4
		cmp.w	d2,d4
		blo.w	locretK_23324
		cmp.w	d3,d4
		bhs.w	locretK_23324
		bsr.w	subK_23190
; locret3_219C4:
locretK_23324:
		rts
; End of function subK_2326C

; ---------------------------------------------------------------------------

Obj_Spring_Down:
		move.w	#$1B,d1
		move.w	#8,d2
		move.w	#9,d3
		move.w	x_pos(a0),d4
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.w	SolidObjectFull2_1P
		cmpi.w	#-2,d4
		bne.s	locK_2334C
		bsr.s	subK_233CA
; loc3_219EC:
locK_2334C:
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		bsr.w	SolidObjectFull2_1P
		cmpi.w	#-2,d4
		bne.s	locK_23362
		bsr.s	subK_233CA
; loc3_21A02:
locK_23362:
		lea	(Ani_Spring).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

Obj_2PSpring_Down:
		move.w	#$13,d1
		move.w	#8,d2
		move.w	#9,d3
		move.w	x_pos(a0),d4
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.w	SolidObjectFull2_1P
		cmpi.w	#-2,d4
		bne.s	locK_2339E
		subq.w	#4,y_pos(a1)
		bsr.s	locK_233DA
; loc3_21A3E:
locK_2339E:
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		bsr.w	SolidObjectFull2_1P
		cmpi.w	#-2,d4
		bne.s	locK_233B8
		subq.w	#4,y_pos(a1)
		bsr.s	locK_233DA
; loc3_21A58:
locK_233B8:
		lea	(Ani_Spring).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================

; sub3_21A6A:
subK_233CA:
		subq.w	#8,y_pos(a1)
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_233DA
		addi.w	#2*8,y_pos(a1)
	endif

locK_233DA:
		move.w	#1<<8,anim(a0)	; and prev_anim
		move.w	$30(a0),y_vel(a1)
		neg.w	y_vel(a1)
		cmpi.w	#$1000,y_vel(a1)
		bne.s	locK_233F8
		move.w	#$D00,y_vel(a1)
; loc3_21A8C:
locK_233F8:
		move.b	subtype(a0),d0
		bpl.s	locK_23404
		move.w	#0,x_vel(a1)
; loc3_21A98:
locK_23404:
		btst	#0,d0
		beq.s	locK_23444
		move.w	#1,ground_vel(a1)
		move.b	#1,flip_angle(a1)
		move.b	#0,anim(a1)
		move.b	#0,flips_remaining(a1)
		move.b	#4,flip_speed(a1)
		btst	#1,d0
		bne.s	locK_23434
		move.b	#1,flips_remaining(a1)
; loc3_21AC8:
locK_23434:
		btst	#Status_Facing,status(a1)
		beq.s	locK_23444
		neg.b	flip_angle(a1)
		neg.w	ground_vel(a1)
; loc3_21AD8:
locK_23444:
		andi.b	#$C,d0
		cmpi.b	#4,d0
		bne.s	locK_2345A
		move.b	#$C,top_solid_bit(a1)
		move.b	#$D,lrb_solid_bit(a1)
; loc3_21AEE:
locK_2345A:
		cmpi.b	#8,d0
		bne.s	locK_2346C
		move.b	#$E,top_solid_bit(a1)
		move.b	#$F,lrb_solid_bit(a1)
; loc3_21B00:
locK_2346C:
		bset	#Status_InAir,status(a1)
		bclr	#Status_OnObj,status(a1)
		clr.b	jumping(a1)
		move.b	#2,routine(a1)
	if ~~Sonic3_Alone
		move.b	#0,double_jump_flag(a1)
	endif
		moveq	#signextendB(sfx_Spring),d0
		jmp	(Play_SFX).l
; End of function subK_233CA

; ---------------------------------------------------------------------------

Obj_Spring_UpDiag:
		move.w	#$1B,d1
		move.w	#$10,d2
		move.w	x_pos(a0),d4
		lea	byteK_236EA(pc),a2
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.w	SolidObject_Always_SingleCharacter
		btst	#p1_standing_bit,status(a0)
		beq.s	locK_234B8
		bsr.s	subK_234E6
; loc3_21B46:
locK_234B8:
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		bsr.w	SolidObject_Always_SingleCharacter
		btst	#p2_standing_bit,status(a0)
		beq.s	locK_234D0
		bsr.s	subK_234E6
; loc3_21B5E:
locK_234D0:
		lea	(Ani_Spring).l,a1
		jsr	(Animate_Sprite).l
		move.w	$32(a0),d0
		jmp	(Sprite_OnScreen_Test2).l

; =============== S U B R O U T I N E =======================================

; sub3_21B74:
subK_234E6:
		btst	#0,status(a0)
		bne.s	locK_234FC
		move.w	x_pos(a0),d0
		subq.w	#4,d0
		cmp.w	x_pos(a1),d0
		blo.s	locK_2350A
		rts
; ---------------------------------------------------------------------------
; locc3_21B8A:
locK_234FC:
		move.w	x_pos(a0),d0
		addq.w	#4,d0
		cmp.w	x_pos(a1),d0
		bhs.s	locK_2350A
		rts
; ---------------------------------------------------------------------------
; loc3_21B98:
locK_2350A:
		move.w	#5<<8,anim(a0)	; and prev_anim
		move.w	$30(a0),y_vel(a1)
		move.w	$30(a0),x_vel(a1)
		addq.w	#6,y_pos(a1)
		addq.w	#6,x_pos(a1)
		bset	#Status_Facing,status(a1)
		btst	#0,status(a0)
		bne.s	locK_23542
		bclr	#Status_Facing,status(a1)
		subi.w	#2*6,x_pos(a1)
		neg.w	x_vel(a1)
; loc3_21BD0:
locK_23542:
		bset	#Status_InAir,status(a1)
		bclr	#Status_OnObj,status(a1)
		clr.b	jumping(a1)
		move.b	#$10,anim(a1)
		move.b	#2,routine(a1)
		move.b	subtype(a0),d0
		btst	#0,d0
		beq.s	locK_235A2
		move.w	#1,ground_vel(a1)
		move.b	#1,flip_angle(a1)
		move.b	#0,anim(a1)
		move.b	#1,flips_remaining(a1)
		move.b	#8,flip_speed(a1)
		btst	#1,d0
		bne.s	locK_23592
		move.b	#3,flips_remaining(a1)
; loc3_21C20:
locK_23592:
		btst	#Status_Facing,status(a1)
		beq.s	locK_235A2
		neg.b	flip_angle(a1)
		neg.w	ground_vel(a1)
; loc3_21C30:
locK_235A2:
		andi.b	#$C,d0
		cmpi.b	#4,d0
		bne.s	locK_235B8
		move.b	#$C,top_solid_bit(a1)
		move.b	#$D,lrb_solid_bit(a1)
; loc3_21C46:
locK_235B8:
		cmpi.b	#8,d0
		bne.s	locK_235CA
		move.b	#$E,top_solid_bit(a1)
		move.b	#$F,lrb_solid_bit(a1)
; loc3_21C58:
locK_235CA:
		moveq	#signextendB(sfx_Spring),d0
		jmp	(Play_SFX).l
; End of function subK_234E6

; ---------------------------------------------------------------------------

Obj_Spring_DownDiag:
		move.w	#$1B,d1
		move.w	#$10,d2
		move.w	x_pos(a0),d4
		lea	byteK_23706(pc),a2
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.w	SolidObject_Always_SingleCharacter
		cmpi.w	#-2,d4
		bne.s	locK_235F8
		bsr.s	subK_23624
; loc3_21C86:
locK_235F8:
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		bsr.w	SolidObject_Always_SingleCharacter
		cmpi.w	#-2,d4
		bne.s	locK_2360E
		bsr.s	subK_23624
; loc3_21C9C:
locK_2360E:
		lea	(Ani_Spring).l,a1
		jsr	(Animate_Sprite).l
		move.w	$32(a0),d0
		jmp	(Sprite_OnScreen_Test2).l

; =============== S U B R O U T I N E =======================================

; sub3_21CB2:
subK_23624:
		move.w	#5<<8,anim(a0)	; and prev_anim
		move.w	$30(a0),y_vel(a1)
		neg.w	y_vel(a1)
		move.w	$30(a0),x_vel(a1)
		subq.w	#6,y_pos(a1)
		addq.w	#6,x_pos(a1)
		bset	#Status_Facing,status(a1)
		btst	#0,status(a0)
		bne.s	locK_23660
		bclr	#Status_Facing,status(a1)
		subi.w	#2*6,x_pos(a1)
		neg.w	x_vel(a1)
; loc3_21CEE:
locK_23660:
		bset	#Status_InAir,status(a1)
		bclr	#Status_OnObj,status(a1)
		clr.b	jumping(a1)
		move.b	#2,routine(a1)
		move.b	subtype(a0),d0
		btst	#0,d0
		beq.s	locK_236BA
		move.w	#1,ground_vel(a1)
		move.b	#1,flip_angle(a1)
		move.b	#0,anim(a1)
		move.b	#1,flips_remaining(a1)
		move.b	#8,flip_speed(a1)
		btst	#1,d0
		bne.s	locK_236AA
		move.b	#3,flips_remaining(a1)
; loc3_21D38:
locK_236AA:
		btst	#Status_Facing,status(a1)
		beq.s	locK_236BA
		neg.b	flip_angle(a1)
		neg.w	ground_vel(a1)
; loc3_21D48:
locK_236BA:
		andi.b	#$C,d0
		cmpi.b	#4,d0
		bne.s	locK_236D0
		move.b	#$C,top_solid_bit(a1)
		move.b	#$D,lrb_solid_bit(a1)
; loc3_21D5E:
locK_236D0:
		cmpi.b	#8,d0
		bne.s	locK_236E2
		move.b	#$E,top_solid_bit(a1)
		move.b	#$F,lrb_solid_bit(a1)
; loc3_21D70:
locK_236E2:
		moveq	#signextendB(sfx_Spring),d0
		jmp	(Play_SFX).l
; End of function subK_23624

; ---------------------------------------------------------------------------
; byte3_21D78:
byteK_236EA:
		dc.b  $10
		dc.b  $10
		dc.b  $10
		dc.b  $10
		dc.b  $10
		dc.b  $10
		dc.b  $10
		dc.b  $10
		dc.b  $10
		dc.b  $10
		dc.b  $10
		dc.b  $10
		dc.b   $E
		dc.b   $C
		dc.b   $A
		dc.b    8
		dc.b    6
		dc.b    4
		dc.b    2
		dc.b    0
		dc.b   -2
		dc.b   -4
		dc.b   -4
		dc.b   -4
		dc.b   -4
		dc.b   -4
		dc.b   -4
		dc.b   -4
; byte3_21D94:
byteK_23706:
		dc.b  -$C
		dc.b -$10
		dc.b -$10
		dc.b -$10
		dc.b -$10
		dc.b -$10
		dc.b -$10
		dc.b -$10
		dc.b -$10
		dc.b -$10
		dc.b -$10
		dc.b -$10
		dc.b  -$E
		dc.b  -$C
		dc.b  -$A
		dc.b   -8
		dc.b   -6
		dc.b   -4
		dc.b   -2
		dc.b    0
		dc.b    2
		dc.b    4
		dc.b    4
		dc.b    4
		dc.b    4
		dc.b    4
		dc.b    4
		dc.b    4
		even

Ani_Spring:
		include "General/Sprites/Level Misc/Anim - Spring.asm"
Map_Spring:
		include "General/Sprites/Level Misc/Map - Spring.asm"
Map_2PSpring:
		include "General/Sprites/Level Misc/Map - 2P Spring.asm"
; ---------------------------------------------------------------------------

Obj_RetractingSpring:
		bsr.w	Obj_Spring
		move.b	subtype(a0),d0
		lsr.w	#3,d0
		andi.w	#$E,d0
		move.w	RetractingSpring_Index(pc,d0.w),d1
		jmp	RetractingSpring_Index(pc,d1.w)
; ---------------------------------------------------------------------------

RetractingSpring_Index:
		dc.w locK_23A04-RetractingSpring_Index
		dc.w locK_23A20-RetractingSpring_Index
		dc.w locK_23A3C-RetractingSpring_Index
		dc.w locK_23A58-RetractingSpring_Index
		dc.w locK_23A88-RetractingSpring_Index
; ---------------------------------------------------------------------------
; loc3_22092:
locK_23A04:
		move.l	#locK_23A0A,(a0)
; loc3_22098:
locK_23A0A:
		bsr.w	subK_23AB8
		moveq	#0,d0
		move.b	$36(a0),d0
		add.w	$34(a0),d0
		move.w	d0,y_pos(a0)
		bra.w	Obj_Spring_Up
; ---------------------------------------------------------------------------
; loc3_220AE:
locK_23A20:
		move.l	#locK_23A26,(a0)
; loc3_220B4:
locK_23A26:
		bsr.w	subK_23AB8
		moveq	#0,d0
		move.b	$36(a0),d0
		add.w	$32(a0),d0
		move.w	d0,x_pos(a0)
		bra.w	Obj_Spring_Horizontal
; ---------------------------------------------------------------------------
; loc3_220CA:
locK_23A3C:
		move.l	#locK_23A42,(a0)
; loc3_220D0:
locK_23A42:
		bsr.w	subK_23AB8
		moveq	#0,d0
		move.b	$36(a0),d0
		add.w	$34(a0),d0
		move.w	d0,y_pos(a0)
		bra.w	Obj_Spring_Down
; ---------------------------------------------------------------------------
; loc3_220E6:
locK_23A58:
		move.l	#locK_23A5E,(a0)
; loc3_200EC:
locK_23A5E:
		bsr.w	subK_23AB8
		moveq	#0,d0
		move.b	$36(a0),d0
		move.w	d0,d1
		btst	#0,status(a0)
		bne.s	locK_23A74
		neg.w	d0
; loc3_22102:
locK_23A74:
		add.w	$32(a0),d0
		move.w	d0,x_pos(a0)
		add.w	$34(a0),d1
		move.w	d1,y_pos(a0)
		bra.w	Obj_Spring_UpDiag
; ---------------------------------------------------------------------------
; loc3_22116:
locK_23A88:
		move.l	#locK_23A8E,(a0)
; loc3_2211C:
locK_23A8E:
		bsr.w	subK_23AB8
		moveq	#0,d0
		move.b	$36(a0),d0
		move.w	d0,d1
		btst	#0,status(a0)
		beq.s	locK_23AA4
		neg.w	d0
; loc3_22132:
locK_23AA4:
		add.w	$32(a0),d0
		move.w	d0,x_pos(a0)
		add.w	$34(a0),d1
		move.w	d1,y_pos(a0)
		bra.w	Obj_Spring_DownDiag

; =============== S U B R O U T I N E =======================================

; sub3_22146:
subK_23AB8:
		tst.w	$3A(a0)
		beq.s	locK_23AD4
		subq.w	#1,$3A(a0)
		bne.s	locretK_23B16
		tst.b	render_flags(a0)
		bpl.s	locretK_23B16
		moveq	#signextendB(sfx_SpikeMove),d0
		jsr	(Play_SFX).l
		bra.s	locretK_23B16
; ---------------------------------------------------------------------------
; loc3_22162:
locK_23AD4:
		tst.w	$38(a0)
		beq.s	locK_23AF6
		subi.w	#$800,$36(a0)
		bcc.s	locretK_23B16
		move.w	#0,$36(a0)
		move.w	#0,$38(a0)
		move.w	#60,$3A(a0)
		bra.s	locretK_23B16
; ---------------------------------------------------------------------------
; loc3_22184:
locK_23AF6:
		addi.w	#$800,$36(a0)
		cmpi.w	#$2000,$36(a0)
		blo.s	locretK_23B16
		move.w	#$2000,$36(a0)
		move.w	#1,$38(a0)
		move.w	#60,$3A(a0)
; locret3_221A4:
locretK_23B16:
		rts
; End of function subK_23AB8

; ---------------------------------------------------------------------------
; byte3_221A6:
byteK_23B18:
		dc.b   $C,   8,   0,   1
		dc.b   $C,   8,   0,   0
		dc.b   $C,   8,   0,   1
		dc.b    8,  $C,   1,   0
		dc.b   $C,   8,   2,   1
		dc.b   $C,   8,   3,   1
		dc.b   $C,   8,   2,   1
		dc.b   $C,   8,   3,   1
		even
; ---------------------------------------------------------------------------

Obj_2PRetractingSpring:
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	locK_23C0E
		move.l	#locK_23ED0,(a1)
		move.l	#Map_2PRetractingSpring,mappings(a1)
		move.w	#make_art_tile(ArtTile_2PArt_2,0,0),art_tile(a1)
		cmpi.b	#$12,(Current_zone).w
		bne.s	locK_23B66
		move.l	#Map_2PRetractingSpring_2,mappings(a1)
; loc3_221F4:
locK_23B66:
		move.b	subtype(a0),d0
		move.b	d0,subtype(a1)
		lsr.b	#2,d0
		andi.w	#$1C,d0
		lea	byteK_23B18(pc,d0.w),a2
		move.b	(a2)+,width_pixels(a1)
		move.b	(a2)+,height_pixels(a1)
		move.b	(a2)+,d0
		move.b	d0,mapping_frame(a1)
		bne.s	locK_23B8E
		move.l	#locK_23F2A,(a1)
; loc3_2221C:
locK_23B8E:
		andi.b	#$F0,subtype(a0)
		move.b	(a2)+,d1
		or.b	d1,subtype(a0)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		moveq	#0,d2
		moveq	#0,d3
		cmpi.b	#1,d0
		bne.s	locK_23BC0
		moveq	#$C,d2
		btst	#0,status(a0)
		bne.s	locK_23BBC
		neg.w	d2
; loc3_2224A:
locK_23BBC:
		add.w	d2,x_pos(a1)
; loc3_2224E:
locK_23BC0:
		cmpi.b	#2,d0
		bne.s	locK_23BCC
		moveq	#$B,d3
		add.w	d3,y_pos(a1)
; loc3_2225A:
locK_23BCC:
		cmpi.b	#3,d0
		bne.s	locK_23BD8
		moveq	#-$B,d3
		add.w	d3,y_pos(a1)
; loc3_22266:
locK_23BD8:
		move.w	d2,$30(a1)
		move.w	d3,$32(a1)
		bclr	#1,status(a0)
		beq.s	locK_23BEE
		move.b	#1,$3C(a0)
; loc3_2227C:
locK_23BEE:
		move.b	status(a0),status(a1)
		move.b	render_flags(a0),render_flags(a1)
		ori.b	#4,render_flags(a1)
		move.w	#$200,priority(a1)
		move.w	a0,$3E(a1)
		move.w	a1,$3E(a0)
; loc3_2229C:
locK_23C0E:
		bsr.w	subK_22D54
; loc3_222A0:
locK_23C12:
		move.b	subtype(a0),d0
		lsr.w	#3,d0
		andi.w	#$E,d0
		move.w	offK_23C24(pc,d0.w),d1
		jmp	offK_23C24(pc,d1.w)
; ---------------------------------------------------------------------------
; off3_222B2:
offK_23C24:
		dc.w locK_23C34-offK_23C24
		dc.w locK_23C50-offK_23C24
		dc.w locK_23C6C-offK_23C24
		dc.w locK_23C88-offK_23C24
		dc.w locK_23CA4-offK_23C24
		dc.w locK_23CC0-offK_23C24
		dc.w locK_23CA4-offK_23C24
		dc.w locK_23CC0-offK_23C24
; ---------------------------------------------------------------------------
; loc3_222C2:
locK_23C34:
		move.l	#locK_23C3A,(a0)
; loc3_222C8:
locK_23C3A:
		bsr.w	subK_23CDC
		moveq	#0,d0
		move.b	$36(a0),d0
		add.w	$34(a0),d0
		move.w	d0,y_pos(a0)
		bra.w	Obj_2PSpring_Up
; ---------------------------------------------------------------------------
; loc3_222DE:
locK_23C50:
		move.l	#locK_23C56,(a0)
; loc3_222E4:
locK_23C56:
		bsr.w	subK_23CDC
		moveq	#0,d0
		move.b	$36(a0),d0
		add.w	$32(a0),d0
		move.w	d0,x_pos(a0)
		bra.w	Obj_2PSpring_Horizontal
; ---------------------------------------------------------------------------
; loc3_222FA:
locK_23C6C:
		move.l	#locK_23C72,(a0)
; loc3_22300:
locK_23C72:
		bsr.w	subK_23CDC
		moveq	#0,d0
		move.b	$36(a0),d0
		add.w	$34(a0),d0
		move.w	d0,y_pos(a0)
		bra.w	Obj_2PSpring_Down
; ---------------------------------------------------------------------------
; loc3_22316:
locK_23C88:
		move.l	#locK_23C8E,(a0)
; loc3_2231C:
locK_23C8E:
		bsr.w	subK_23CDC
		moveq	#0,d0
		move.b	$36(a0),d0
		add.w	$34(a0),d0
		move.w	d0,y_pos(a0)
		bra.w	Obj_2PSpring_Horizontal
; ---------------------------------------------------------------------------
; loc3_22332:
locK_23CA4:
		move.l	#locK_23CAA,(a0)
; loc3_22338:
locK_23CAA:
		bsr.w	subK_23CDC
		moveq	#0,d0
		move.b	$36(a0),d0
		add.w	$32(a0),d0
		move.w	d0,x_pos(a0)
		bra.w	Obj_2PSpring_Up
; ---------------------------------------------------------------------------
; loc3_2234E:
locK_23CC0:
		move.l	#locK_23CC6,(a0)
; loc3_22354:
locK_23CC6:
		bsr.w	subK_23CDC
		moveq	#0,d0
		move.b	$36(a0),d0
		add.w	$32(a0),d0
		move.w	d0,x_pos(a0)
		bra.w	Obj_2PSpring_Down

; =============== S U B R O U T I N E =======================================

; sub3_2236A:
subK_23CDC:
		tst.b	subtype(a0)
		bmi.s	locK_23D42
		tst.w	$3A(a0)
		beq.s	locK_23CFE
		subq.w	#1,$3A(a0)
		bne.s	locretK_23D40
		tst.b	render_flags(a0)
		bpl.s	locretK_23D40
		moveq	#signextendB(sfx_SpikeMove),d0
		jsr	(Play_SFX).l
		bra.s	locretK_23D40
; ---------------------------------------------------------------------------
; loc3_2238C:
locK_23CFE:
		tst.w	$38(a0)
		beq.s	locK_23D20
		subi.w	#$800,$36(a0)
		bcc.s	locretK_23D40
		move.w	#0,$36(a0)
		move.w	#0,$38(a0)
		move.w	#60,$3A(a0)
		bra.s	locretK_23D40
; ---------------------------------------------------------------------------
; loc3_223AE:
locK_23D20:
		addi.w	#$800,$36(a0)
		cmpi.w	#$1800,$36(a0)
		blo.s	locretK_23D40
		move.w	#$1800,$36(a0)
		move.w	#1,$38(a0)
		move.w	#60,$3A(a0)
; locret3_223CE:
locretK_23D40:
		rts
; ---------------------------------------------------------------------------
; loc3_223D0:
locK_23D42:
		tst.b	$3C(a0)
		beq.w	locK_23E0C
		tst.w	$3A(a0)
		beq.s	locK_23D62
		subq.w	#1,$3A(a0)
		bne.w	locretK_23E0A
		move.w	#0,$38(a0)
		bra.w	locretK_23E0A
; ---------------------------------------------------------------------------
; loc3_223F0:
locK_23D62:
		tst.w	$38(a0)
		bne.w	locK_23DF0
		tst.w	$36(a0)
		beq.w	locretK_23E0A
		subi.w	#$800,$36(a0)
		bhi.w	locretK_23E0A
		move.w	#0,$36(a0)
		move.b	subtype(a0),d0
		andi.b	#$F0,d0
		cmpi.b	#$E0,d0
		bne.s	locK_23DBC
		addi.w	#$16,y_pos(a0)
		bchg	#1,status(a0)
		bchg	#1,render_flags(a0)
		andi.b	#$F,subtype(a0)
		ori.b	#$F0,subtype(a0)
		move.l	#locK_23C12,(a0)
		movea.w	$3E(a0),a1
		neg.w	$32(a1)
; loc3_2244A:
locK_23DBC:
		cmpi.b	#$F0,d0
		bne.s	locK_23DEE
		subi.w	#$16,y_pos(a0)
		bchg	#1,status(a0)
		bchg	#1,render_flags(a0)
		andi.b	#$F,subtype(a0)
		ori.b	#$E0,subtype(a0)
		move.l	#locK_23C12,(a0)
		movea.w	$3E(a0),a1
		neg.w	$32(a1)
; loc3_2247C:
locK_23DEE:
		bra.s	locretK_23E0A
; ---------------------------------------------------------------------------
; loc3_2247E:
locK_23DF0:
		addi.w	#$800,$36(a0)
		cmpi.w	#$1800,$36(a0)
		blo.s	locretK_23E0A
		move.w	#$1800,$36(a0)
		move.w	#3*60,$3A(a0)
; locret3_22498:
locretK_23E0A:
		rts
; ---------------------------------------------------------------------------
; loc3_2249A:
locK_23E0C:
		tst.w	$3A(a0)
		beq.s	locK_23E24
		subq.w	#1,$3A(a0)
		bne.w	locretK_23ECE
		move.w	#0,$38(a0)
		bra.w	locretK_23ECE
; ---------------------------------------------------------------------------
; loc3_224B2:
locK_23E24:
		tst.w	$38(a0)
		beq.s	locK_23E44
		subi.w	#$800,$36(a0)
		bcc.w	locretK_23ECE
		move.w	#0,$36(a0)
		move.w	#3*60,$3A(a0)
		bra.w	locretK_23ECE
; ---------------------------------------------------------------------------
; loc3_224D2:
locK_23E44:
		cmpi.w	#$1800,$36(a0)
		beq.w	locretK_23ECE
		addi.w	#$800,$36(a0)
		cmpi.w	#$1800,$36(a0)
		blo.s	locretK_23ECE
		move.w	#$1800,$36(a0)
		move.b	subtype(a0),d0
		andi.b	#$F0,d0
		cmpi.b	#$E0,d0
		bne.s	locK_23E9C
		addi.w	#$16,y_pos(a0)
		bchg	#1,status(a0)
		bchg	#1,render_flags(a0)
		andi.b	#$F,subtype(a0)
		ori.b	#$F0,subtype(a0)
		move.l	#locK_23C12,(a0)
		movea.w	$3E(a0),a1
		neg.w	$32(a1)
; loc3_2252A:
locK_23E9C:
		cmpi.b	#$F0,d0
		bne.s	locretK_23ECE
		subi.w	#$16,y_pos(a0)
		bchg	#1,status(a0)
		bchg	#1,render_flags(a0)
		andi.b	#$F,subtype(a0)
		ori.b	#$E0,subtype(a0)
		move.l	#locK_23C12,(a0)
		movea.w	$3E(a0),a1
		neg.w	$32(a1)
; locret3_2255C:
locretK_23ECE:
		rts
; End of function subK_23CDC

; ---------------------------------------------------------------------------
; loc3_2255E:
locK_23ED0:
		movea.w	$3E(a0),a1
		move.w	x_pos(a1),d2
		move.w	y_pos(a1),d3
		add.w	$30(a0),d2
		add.w	$32(a0),d3
		move.w	d2,x_pos(a0)
		move.w	d3,y_pos(a0)
		move.b	subtype(a0),d1
		bpl.s	locK_23F06
		andi.w	#$F,d1
		lea	(Level_trigger_array).w,a3
		tst.b	(a3,d1.w)
		beq.s	locK_23F06
		move.w	#1,$38(a1)
; loc3_22594:
locK_23F06:
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#7,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_225B8:
locK_23F2A:
		move.b	subtype(a0),d1
		bpl.s	locretK_23F48
		andi.w	#$F,d1
		lea	(Level_trigger_array).w,a3
		tst.b	(a3,d1.w)
		beq.s	locretK_23F48
		movea.w	$3E(a0),a1
		move.w	#1,$38(a1)
; locret3_225D6:
locretK_23F48:
		rts
; ---------------------------------------------------------------------------

Map_2PRetractingSpring:
		include "General/Sprites/Level Misc/Map - 2P Retracting Spring.asm"