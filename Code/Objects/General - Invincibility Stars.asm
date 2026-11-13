; ---------------------------------------------------------------------------
; off3_1756E:
offK_187DE:
		dc.l byteK_189ED
		dc.b    0,  $B
		dc.l byteK_18A02
		dc.b  $16,  $D
		dc.l byteK_18A1B
		dc.b  $2C,  $D
; ---------------------------------------------------------------------------

Obj_Invincibility:
		move.l	#ArtUnc_Invincibility,d1
		move.w	#tiles_to_bytes(ArtTile_Shield),d2
		move.w	#(ArtUnc_Invincibility_end-ArtUnc_Invincibility)/2,d3
		jsr	(Add_To_DMA_Queue).l
		moveq	#0,d2
		lea	offK_187DE-6(pc),a2
		lea	(a0),a1
		moveq	#4-1,d1
; loc3_1759E:
locK_1880E:
		move.l	#Obj_188E8,(a1)
		move.l	#Map_Invincibility,mappings(a1)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a1)
		move.w	#$80,priority(a1)
		move.b	#4,render_flags(a1)
		bset	#6,render_flags(a1)
		move.b	#$10,width_pixels(a1)
		move.w	#2,mainspr_childsprites(a1)
		move.w	parent(a0),parent(a1)
		move.b	d2,$36(a1)
		addq.w	#1,d2
		move.l	(a2)+,$30(a1)
		move.w	(a2)+,$34(a1)
		lea	next_object(a1),a1
		dbf	d1,locK_1880E
		move.l	#locK_18868,(a0)
		move.b	#4,$34(a0)
; loc3_175F8:
locK_18868:
		tst.b	(Super_Sonic_Knux_flag).w
		bne.w	Delete_Current_Sprite
	if ~~Sonic3_Alone
		tst.b	(Super_Tails_flag).w
		bne.w	Delete_Current_Sprite
	endif
		movea.w	parent(a0),a1
		btst	#Status_Invincible,status_secondary(a1)
		beq.w	Delete_Current_Sprite
		move.w	x_pos(a1),d0
		move.w	d0,x_pos(a0)
		move.w	y_pos(a1),d1
		move.w	d1,y_pos(a0)
		lea	sub2_x_pos(a0),a2
		lea	byteK_189E0(pc),a3
		moveq	#0,d5
; loc3_17628:
locK_188A0:
		move.w	$38(a0),d2
		move.b	(a3,d2.w),d5
		bpl.s	locK_188B0
		clr.w	$38(a0)
		bra.s	locK_188A0
; ---------------------------------------------------------------------------
; loc3_17638:
locK_188B0:
		addq.w	#1,$38(a0)
		lea	byteK_189A0(pc),a6
		move.b	$34(a0),d6
		jsr	sub_1898A(pc)
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		move.w	d5,(a2)+
		addi.w	#$20,d6
		jsr	sub_1898A(pc)
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		move.w	d5,(a2)+
		moveq	#$12,d0
		btst	#Status_Facing,status(a1)
		beq.s	locK_188E0
		neg.w	d0
; loc3_17668:
locK_188E0:
		add.b	d0,$34(a0)
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------
; Obj_17670:
Obj_188E8:
		tst.b	(Super_Sonic_Knux_flag).w
		bne.w	Delete_Current_Sprite
	if ~~Sonic3_Alone
		tst.b	(Super_Tails_flag).w
		bne.w	Delete_Current_Sprite
	endif
		movea.w	parent(a0),a1
		btst	#Status_Invincible,status_secondary(a1)
		beq.w	Delete_Current_Sprite
		lea	(Pos_table_index).w,a5
		lea	(Pos_table).w,a6
		move.b	$36(a0),d1
		lsl.b	#2,d1
		move.w	d1,d2
		add.w	d1,d1
		add.w	d2,d1
		move.w	(a5),d0
		sub.b	d1,d0
		lea	(a6,d0.w),a2
		move.w	(a2)+,d0
		move.w	(a2)+,d1
		move.w	d0,x_pos(a0)
		move.w	d1,y_pos(a0)
		lea	sub2_x_pos(a0),a2
		movea.l	$30(a0),a3
; loc3_176B6:
locK_18936:
		move.w	$38(a0),d2
		move.b	(a3,d2.w),d5
		bpl.s	locK_18946
		clr.w	$38(a0)
		bra.s	locK_18936
; ---------------------------------------------------------------------------
; loc3_176C6:
locK_18946:
		swap	d5
		add.b	$35(a0),d2
		move.b	(a3,d2.w),d5
		addq.w	#1,$38(a0)
		lea	byteK_189A0(pc),a6
		move.b	$34(a0),d6
		jsr	sub_1898A(pc)
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		move.w	d5,(a2)+
		addi.w	#$20,d6
		swap	d5
		jsr	sub_1898A(pc)
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		move.w	d5,(a2)+
		moveq	#2,d0
		btst	#Status_Facing,status(a1)
		beq.s	locK_18982
		neg.w	d0
; loc3_17702:
locK_18982:
		add.b	d0,$34(a0)
		bra.w	Draw_Sprite

; =============== S U B R O U T I N E =======================================

; sub3_1770A:
sub_1898A:
		andi.w	#$3E,d6
		move.b	(a6,d6.w),d2
		move.b	1(a6,d6.w),d3
		ext.w	d2
		ext.w	d3
		add.w	d0,d2
		add.w	d1,d3
		rts
; End of function sub_1898A

; ---------------------------------------------------------------------------
; byte3_17720:
byteK_189A0:
		dc.b   $F,   0
		dc.b   $F,   3
		dc.b   $E,   6
		dc.b   $D,   8
		dc.b   $B,  $B
		dc.b    8,  $D
		dc.b    6,  $E
		dc.b    3,  $F
		dc.b    0, $10
		dc.b   -4,  $F
		dc.b   -7,  $E
		dc.b   -9,  $D
		dc.b  -$C,  $B
		dc.b  -$E,   8
		dc.b  -$F,   6
		dc.b -$10,   3
		dc.b -$10,   0
		dc.b -$10,  -4
		dc.b  -$F,  -7
		dc.b  -$E,  -9
		dc.b  -$C, -$C
		dc.b   -9, -$E
		dc.b   -7, -$F
		dc.b   -4,-$10
		dc.b   -1,-$10
		dc.b    3,-$10
		dc.b    6, -$F
		dc.b    8, -$E
		dc.b   $B, -$C
		dc.b   $D,  -9
		dc.b   $E,  -7
		dc.b   $F,  -4
; byte3_17760:
byteK_189E0:
		dc.b    8,   5,   7,   6,   6,   7,   5,   8,   6,   7,   7,   6, $FF
; byte3_1776D:
byteK_189ED:
		dc.b    8,   7,   6,   5,   4,   3,   4,   5,   6,   7, $FF,   3,   4,   5,   6,   7,   8,   7,   6,   5
		dc.b    4
; byte3_17782:
byteK_18A02:
		dc.b    8,   7,   6,   5,   4,   3,   2,   3,   4,   5,   6,   7, $FF,   2,   3,   4,   5,   6,   7,   8
		dc.b    7,   6,   5,   4,   3
; byte3_1779B:
byteK_18A1B:
		dc.b    7,   6,   5,   4,   3,   2,   1,   2,   3,   4,   5,   6, $FF,   1,   2,   3,   4,   5,   6,   7
		dc.b    6,   5,   4,   3,   2
		even