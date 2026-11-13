; ---------------------------------------------------------------------------

Obj_Skorp:
		jsr	(Obj_WaitOffscreen).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Skorp_Index(pc,d0.w),d1
		jsr	Skorp_Index(pc,d1.w)
		jmp	(Sprite_CheckDeleteTouch).l
; ---------------------------------------------------------------------------
Skorp_Index:
		dc.w locK_8E670-Skorp_Index
		dc.w locK_8E6B8-Skorp_Index
		dc.w locK_8E732-Skorp_Index
; ---------------------------------------------------------------------------

locK_8E670:
		lea	ObjDat_Skorp(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#$B,y_radius(a0)
		move.l	#locK_8E706,$34(a0)
		move.w	#-$80,d0
		btst	#0,render_flags(a0)
		beq.s	locK_8E696
		neg.w	d0

locK_8E696:
		move.w	d0,x_vel(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		subq.w	#1,d0
		move.w	d0,$2E(a0)
		add.w	d0,d0
		addq.w	#1,d0
		move.w	d0,$3A(a0)
		lea	ChildObjDat_8EA5A(pc),a2
		jmp	(CreateChild4_LinkListRepeated).l
; ---------------------------------------------------------------------------

locK_8E6B8:
		lea	(Player_1).w,a1
		jsr	(Find_OtherObject).l
		btst	#0,render_flags(a0)
		sne	d4
		tst.w	d0
		beq.s	locK_8E6D0
		not.b	d4

locK_8E6D0:
		tst.b	d4
		bne.s	locK_8E6E6
		cmpi.w	#$20,d2
		blo.s	locK_8E6E6
		cmpi.w	#$80,d2
		bhs.s	locK_8E6E6
		cmpi.w	#$28,d3
		blo.s	locK_8E718

locK_8E6E6:
		lea	byteK_8EA60(pc),a1
		jsr	(Animate_RawNoSST).l
		jsr	(MoveSprite2).l
		jsr	(ObjHitFloor2_DoRoutine).l
		bne.w	locretK_8E716
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

locK_8E706:
		neg.w	x_vel(a0)
		bchg	#0,render_flags(a0)
		move.w	$3A(a0),$2E(a0)

locretK_8E716:
		rts
; ---------------------------------------------------------------------------

locK_8E718:
		move.b	#4,routine(a0)
		bset	#1,$38(a0)
		move.w	x_pos(a1),$3E(a0)
		move.w	y_pos(a1),$40(a0)
		rts
; ---------------------------------------------------------------------------

locK_8E732:
		btst	#1,$38(a0)
		beq.s	locK_8E73C
		rts
; ---------------------------------------------------------------------------

locK_8E73C:
		move.b	#2,routine(a0)
		rts
; ---------------------------------------------------------------------------

locK_8E744:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	offK_8E778(pc,d0.w),d1
		jsr	offK_8E778(pc,d1.w)
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		bne.s	locK_8E772
		cmpi.b	#$A,subtype(a0)
		bne.s	locK_8E76C
		jsr	(Add_SpriteToCollisionResponseList).l

locK_8E76C:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_8E772:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------
offK_8E778:
		dc.w locK_8E78C-offK_8E778
		dc.w locK_8E7D4-offK_8E778
		dc.w locK_8E828-offK_8E778
		dc.w locK_8E868-offK_8E778
		dc.w locK_8E88C-offK_8E778
		dc.w locK_8E8C4-offK_8E778
		dc.w locK_8E8BE-offK_8E778
		dc.w locK_8E8BE-offK_8E778
		dc.w locK_8E918-offK_8E778
		dc.w locK_8E958-offK_8E778
; ---------------------------------------------------------------------------

locK_8E78C:
		lea	wordK_8EA54(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		movea.w	parent3(a0),a1
		move.b	subtype(a0),d0
		bne.s	locK_8E7B2
		move.b	#8,child_dx(a0)
		move.b	#-$10,child_dy(a0)
		move.w	parent3(a0),$44(a1)

locK_8E7B2:
		move.w	$44(a1),$44(a0)
		cmpi.b	#$A,d0
		bne.s	locK_8E7D0
		move.b	#4,mapping_frame(a0)
		move.w	#$100,priority(a0)
		move.b	#$87,collision_flags(a0)

locK_8E7D0:
		bsr.w	subK_8E982

locK_8E7D4:
		jsr	(Change_FlipXUseParent).l
		tst.b	subtype(a0)
		beq.s	locK_8E7F8
		movea.w	$44(a0),a1
		btst	#1,$38(a1)
		bne.s	locK_8E80E
		bsr.w	subK_8EA1C
		moveq	#5,d2
		jmp	(MoveSprite_CircularSimpleCheckFlip).l
; ---------------------------------------------------------------------------

locK_8E7F8:
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	parent3(a0),a1
		moveq	#0,d0
		move.b	mapping_frame(a1),d0
		sub.w	d0,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

locK_8E80E:
		move.b	#4,routine(a0)
		move.l	#locK_8E87C,$34(a0)
		movea.w	$44(a0),a1
		andi.b	#$F3,$38(a1)
		rts
; ---------------------------------------------------------------------------

locK_8E828:
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#1,d0
		move.b	byteK_8E862(pc,d0.w),d1
		move.b	$3C(a0),d2
		subq.b	#8,d2
		cmp.b	d1,d2
		bhi.s	locK_8E856
		move.b	#6,routine(a0)
		move.b	d1,d2
		cmpi.b	#5,d0
		bne.s	locK_8E856
		movea.w	$44(a0),a1
		bset	#3,$38(a1)

locK_8E856:
		move.b	d2,$3C(a0)
		moveq	#5,d2
		jmp	(MoveSprite_CircularSimpleCheckFlip).l
; ---------------------------------------------------------------------------
byteK_8E862:
		dc.b    0, $68, $58, $48, $38, $38
		even
; ---------------------------------------------------------------------------

locK_8E868:
		movea.w	$44(a0),a1
		btst	#3,$38(a1)
		bne.s	locK_8E876
		rts
; ---------------------------------------------------------------------------

locK_8E876:
		movea.l	$34(a0),a1
		jmp	(a1)
; ---------------------------------------------------------------------------

locK_8E87C:
		move.b	#8,routine(a0)
		rts
; ---------------------------------------------------------------------------

locK_8E884:
		move.b	#$10,routine(a0)
		rts
; ---------------------------------------------------------------------------

locK_8E88C:
		move.b	$3C(a0),d0
		addi.b	#$10,d0
		bpl.s	locK_8E8B2
		move.b	#$C,routine(a0)
		move.w	#$F,$2E(a0)
		move.l	#locK_8E8CA,$34(a0)
		bsr.w	subK_8E9A4
		move.b	#$80,d0

locK_8E8B2:
		move.b	d0,$3C(a0)
		moveq	#5,d2
		jmp	(MoveSprite_CircularSimpleCheckFlip).l
; ---------------------------------------------------------------------------

locK_8E8BE:
		jsr	(MoveSprite2).l

locK_8E8C4:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

locK_8E8CA:
		move.b	#$A,routine(a0)
		move.w	#$F,$2E(a0)
		move.l	#locK_8E8E0,$34(a0)
		rts
; ---------------------------------------------------------------------------

locK_8E8E0:
		move.b	#$E,routine(a0)
		neg.w	x_vel(a0)
		neg.w	y_vel(a0)
		move.w	#$F,$2E(a0)
		move.l	#locK_8E8FE,$34(a0)
		rts
; ---------------------------------------------------------------------------

locK_8E8FE:
		move.b	#4,routine(a0)
		move.l	#locK_8E884,$34(a0)
		movea.w	$44(a0),a1
		bclr	#3,$38(a1)
		rts
; ---------------------------------------------------------------------------

locK_8E918:
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#1,d0
		move.b	byteK_8E952(pc,d0.w),d1
		move.b	$3C(a0),d2
		addq.b	#8,d2
		cmp.b	d1,d2
		blo.s	locK_8E946
		move.b	#$12,routine(a0)
		move.b	d1,d2
		cmpi.b	#5,d0
		bne.s	locK_8E946
		movea.w	$44(a0),a1
		bset	#2,$38(a1)

locK_8E946:
		move.b	d2,$3C(a0)
		moveq	#5,d2
		jmp	(MoveSprite_CircularSimpleCheckFlip).l
; ---------------------------------------------------------------------------
byteK_8E952:
		dc.b    0, $90, $A0, $B0, $B8, $C0
		even
; ---------------------------------------------------------------------------

locK_8E958:
		movea.w	$44(a0),a1
		btst	#2,$38(a1)
		bne.s	locK_8E966
		rts
; ---------------------------------------------------------------------------

locK_8E966:
		move.b	#2,routine(a0)
		movea.w	$44(a0),a1
		bclr	#1,$38(a1)
		clr.b	$3B(a0)
		bclr	#0,$38(a0)
		rts

; =============== S U B R O U T I N E =======================================


subK_8E982:
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.b	#1,d0
		move.b	byteK_8E992(pc,d0.w),$3C(a0)
		rts
; End of function subK_8E982

; ---------------------------------------------------------------------------
byteK_8E992:
		dc.b    0, $90, $A0, $B0, $B8, $C0
		even
; ---------------------------------------------------------------------------
		; unused
		move.b	subtype(a0),d0
		lsr.b	#1,d0
		move.b	d0,$2E(a0)
		rts

; =============== S U B R O U T I N E =======================================


subK_8E9A4:
		movea.w	$44(a0),a1
		move.w	$3E(a1),d0
		sub.w	x_pos(a0),d0
		smi	d2
		bpl.s	locK_8E9B6
		neg.w	d0

locK_8E9B6:
		move.w	$40(a1),d1
		sub.w	y_pos(a0),d1
		smi	d3
		bpl.s	locK_8E9C4
		neg.w	d1

locK_8E9C4:
		moveq	#0,d4
		move.b	subtype(a0),d4
		move.w	offK_8E9D2(pc,d4.w),d4
		jmp	offK_8E9D2(pc,d4.w)
; End of function subK_8E9A4

; ---------------------------------------------------------------------------
offK_8E9D2:
		dc.w locK_8E9DE-offK_8E9D2
		dc.w locK_8E9DE-offK_8E9D2
		dc.w locK_8E9E6-offK_8E9D2
		dc.w locK_8E9EE-offK_8E9D2
		dc.w locK_8E9F6-offK_8E9D2
		dc.w locK_8EA02-offK_8E9D2
; ---------------------------------------------------------------------------

locK_8E9DE:
		move.w	#$3333,d4
		bra.w	locK_8E9FA
; ---------------------------------------------------------------------------

locK_8E9E6:
		move.w	#$6666,d4
		bra.w	locK_8E9FA
; ---------------------------------------------------------------------------

locK_8E9EE:
		move.w	#$9999,d4
		bra.w	locK_8E9FA
; ---------------------------------------------------------------------------

locK_8E9F6:
		move.w	#$CCCC,d4

locK_8E9FA:
		mulu.w	d4,d0
		swap	d0
		mulu.w	d4,d1
		swap	d1

locK_8EA02:
		asl.w	#4,d0
		tst.b	d2
		beq.s	locK_8EA0A
		neg.w	d0

locK_8EA0A:
		move.w	d0,x_vel(a0)
		asl.w	#4,d1
		tst.b	d3
		beq.s	locK_8EA16
		neg.w	d1

locK_8EA16:
		move.w	d1,y_vel(a0)
		rts

; =============== S U B R O U T I N E =======================================


subK_8EA1C:
		subq.b	#1,$3B(a0)
		bpl.s	locK_8EA2E
		move.b	#$10,$3B(a0)
		bchg	#0,$38(a0)

locK_8EA2E:
		btst	#0,$3B(a0)
		bne.s	locretK_8EA46
		moveq	#1,d0
		btst	#0,$38(a0)
		bne.s	locK_8EA42
		neg.w	d0

locK_8EA42:
		add.b	d0,$3C(a0)

locretK_8EA46:
		rts
; End of function subK_8EA1C

; ---------------------------------------------------------------------------
ObjDat_Skorp:
		dc.l Map_Skorp
		dc.w make_art_tile(ArtTile_Skorp,1,0)
		dc.w   $180
		dc.b  $10, $14,   0,   6
wordK_8EA54:
		dc.w   $180
		dc.b  $10, $14,   3,   0
ChildObjDat_8EA5A:
		dc.w 6-1
		dc.l locK_8E744
byteK_8EA60:
		dc.b    9,   1,   0,   1,   2, $FC
		even