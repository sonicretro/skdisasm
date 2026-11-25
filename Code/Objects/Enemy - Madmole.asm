; ---------------------------------------------------------------------------

Obj_Madmole:
		jsr	(Obj_WaitOffscreen).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Madmole_Index(pc,d0.w),d1
		jsr	Madmole_Index(pc,d1.w)
		bsr.w	subK_8D876
		jmp	(Sprite_CheckDelete).l
; ---------------------------------------------------------------------------
Madmole_Index:
		dc.w locK_8D5A6-Madmole_Index
		dc.w locK_8D5B0-Madmole_Index
		dc.w locK_8D5D4-Madmole_Index
		dc.w locK_8D5F4-Madmole_Index
; ---------------------------------------------------------------------------

locK_8D5A6:
		lea	ObjDat_Madmole(pc),a1
		jmp	(SetUp_ObjAttributes).l
; ---------------------------------------------------------------------------

locK_8D5B0:
		jsr	(Find_SonicTails).l
		cmpi.w	#$A0,d2
		blo.s	locK_8D5BE
		rts
; ---------------------------------------------------------------------------

locK_8D5BE:
		move.b	#4,routine(a0)
		bset	#1,$38(a0)
		lea	ChildObjDat_8D9C0(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

locK_8D5D4:
		btst	#1,$38(a0)
		beq.s	locK_8D5DE
		rts
; ---------------------------------------------------------------------------

locK_8D5DE:
		move.b	#6,routine(a0)
		move.w	#60,$2E(a0)
		move.l	#locK_8D5FA,$34(a0)
		rts
; ---------------------------------------------------------------------------

locK_8D5F4:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

locK_8D5FA:
		move.b	#2,routine(a0)
		rts
; ---------------------------------------------------------------------------

locK_8D602:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	offK_8D616(pc,d0.w),d1
		jsr	offK_8D616(pc,d1.w)
		jmp	(Child_DrawTouch_Sprite).l
; ---------------------------------------------------------------------------
offK_8D616:
		dc.w locK_8D620-offK_8D616
		dc.w locK_8D636-offK_8D616
		dc.w locK_8D656-offK_8D616
		dc.w locK_8D67A-offK_8D616
		dc.w locK_8D6CA-offK_8D616
; ---------------------------------------------------------------------------

locK_8D620:
		lea	wordK_8D9B4(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.w	#-$100,y_vel(a0)
		move.w	#$1F,$2E(a0)

locK_8D636:
		bsr.w	subK_8D886
		jsr	(MoveSprite2).l
		subq.w	#1,$2E(a0)
		bmi.s	locK_8D648
		rts
; ---------------------------------------------------------------------------

locK_8D648:
		move.b	#4,routine(a0)
		move.w	#$1F,$2E(a0)
		rts
; ---------------------------------------------------------------------------

locK_8D656:
		bsr.w	subK_8D886
		subq.w	#1,$2E(a0)
		bmi.s	locK_8D662
		rts
; ---------------------------------------------------------------------------

locK_8D662:
		move.b	#6,routine(a0)
		move.l	#byteK_8D9D8,$30(a0)
		move.l	#locK_8D680,$34(a0)
		rts
; ---------------------------------------------------------------------------

locK_8D67A:
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

locK_8D680:
		move.l	#byteK_8D9DD,$30(a0)
		move.l	#locK_8D6AE,$34(a0)
		moveq	#signextendB(sfx_SpikeMove),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_8D9C8(pc),a2
		btst	#0,render_flags(a0)
		beq.s	locK_8D6A8
		lea	ChildObjDat_8D9D0(pc),a2

locK_8D6A8:
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

locK_8D6AE:
		move.b	#8,routine(a0)
		move.w	#$100,y_vel(a0)
		move.w	#$1F,$2E(a0)
		move.l	#locK_8D6D6,$34(a0)
		rts
; ---------------------------------------------------------------------------

locK_8D6CA:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

locK_8D6D6:
		movea.w	parent3(a0),a1
		bclr	#1,$38(a1)
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

locK_8D6E6:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	offK_8D73C(pc,d0.w),d1
		jsr	offK_8D73C(pc,d1.w)
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	locK_8D724
		move.w	y_pos(a0),d0
		sub.w	(Camera_Y_pos).w,d0
		addi.w	#$80,d0
		cmpi.w	#$200,d0
		bhi.s	locK_8D724
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_8D724:
		move.w	$44(a0),d0
		beq.s	locK_8D736
		movea.w	d0,a1
		bset	#Status_InAir,status(a1)
		clr.b	object_control(a1)

locK_8D736:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------
offK_8D73C:
		dc.w locK_8D746-offK_8D73C
		dc.w locK_8D768-offK_8D73C
		dc.w locK_8D778-offK_8D73C
		dc.w locK_8D79C-offK_8D73C
		dc.w locK_8D7A8-offK_8D73C
; ---------------------------------------------------------------------------

locK_8D746:
		lea	wordK_8D9BA(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.b	#$18,x_radius(a0)
		move.b	#8,y_radius(a0)
		move.l	#byteK_8D9E7,$30(a0)
		bra.w	locK_8D89E
; ---------------------------------------------------------------------------

locK_8D768:
		bsr.w	subK_8D8E6
		jsr	(MoveSprite2).l
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

locK_8D778:
		bsr.w	subK_8D94A
		jsr	(MoveSprite_LightGravity).l
		tst.w	y_vel(a0)
		bmi.s	locK_8D78E
		jsr	(ObjHitFloor_DoRoutine).l

locK_8D78E:
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

locK_8D794:
		move.w	#-$500,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

locK_8D79C:
		jsr	(MoveSprite2).l
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

locK_8D7A8:
		movea.w	$44(a0),a1
		bclr	#0,render_flags(a1)
		tst.w	x_vel(a0)
		bmi.s	locK_8D7BE
		bset	#0,render_flags(a1)

locK_8D7BE:
		tst.b	object_control(a1)
		beq.s	locK_8D83E
		moveq	#8,d1
		move.w	x_pos(a0),d0
		btst	#0,render_flags(a1)
		bne.s	locK_8D7D4
		neg.w	d1

locK_8D7D4:
		add.w	d1,d0
		move.w	d0,x_pos(a1)
		move.w	y_pos(a0),d0
		addi.w	#8,d0
		move.w	d0,y_pos(a1)
		jsr	(MoveSprite_LightGravity).l
		tst.w	x_vel(a0)
		bmi.s	locK_8D800
		move.w	#$18,d3
		jsr	(ObjCheckRightWallDist).l
		bra.w	locK_8D80A
; ---------------------------------------------------------------------------

locK_8D800:
		move.w	#-$18,d3
		jsr	(ObjCheckLeftWallDist).l

locK_8D80A:
		tst.w	d1
		bmi.s	locK_8D820
		tst.w	y_vel(a0)
		bmi.s	locK_8D81A
		jsr	(ObjHitFloor_DoRoutine).l

locK_8D81A:
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

locK_8D820:
		movea.w	$44(a0),a1
		move.w	x_vel(a0),d0
		neg.w	d0
		move.w	d0,x_vel(a1)
		asr.w	#1,d0
		move.w	d0,x_vel(a0)

locK_8D834:
		bset	#Status_InAir,status(a1)
		clr.b	object_control(a1)

locK_8D83E:
		move.b	#6,routine(a0)
		rts
; ---------------------------------------------------------------------------

locK_8D846:
		cmpi.w	#$A00,y_vel(a0)
		bge.s	locK_8D85E
		move.w	#-$500,y_vel(a0)
		moveq	#signextendB(sfx_Flipper),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

locK_8D85E:
		movea.w	$44(a0),a1
		move.w	#-$200,y_vel(a0)
		move.w	#-$300,y_vel(a1)
		move.w	x_vel(a0),x_vel(a1)
		bra.s	locK_8D834

; =============== S U B R O U T I N E =======================================


subK_8D876:
		moveq	#$1F,d1
		moveq	#4,d2
		moveq	#5,d3
		move.w	x_pos(a0),d4
		jmp	(SolidObjectFull).l
; End of function subK_8D876


; =============== S U B R O U T I N E =======================================


subK_8D886:
		jsr	(Find_SonicTails).l
		bclr	#0,render_flags(a0)
		tst.w	d0
		beq.s	locretK_8D89C
		bset	#0,render_flags(a0)

locretK_8D89C:
		rts
; End of function subK_8D886

; ---------------------------------------------------------------------------

locK_8D89E:
		jsr	(Random_Number).l
		moveq	#0,d2
		tst.b	d0
		bpl.s	locK_8D8BA
		addq.w	#4,d2
		move.b	#4,routine(a0)
		move.l	#locK_8D794,$34(a0)

locK_8D8BA:
		lea	wordK_8D8DE(pc,d2.w),a1
		move.w	(a1)+,d0
		movea.w	parent3(a0),a2
		btst	#0,render_flags(a2)
		beq.s	locK_8D8D4
		neg.w	d0
		bset	#0,render_flags(a0)

locK_8D8D4:
		move.w	d0,x_vel(a0)
		move.w	(a1)+,y_vel(a0)
		rts
; ---------------------------------------------------------------------------
wordK_8D8DE:
		dc.w  -$600,     0
		dc.w  -$380,  $200

; =============== S U B R O U T I N E =======================================


subK_8D8E6:
		move.b	collision_property(a0),d0
		beq.w	locretK_8D942
		clr.b	collision_property(a0)
		andi.w	#3,d0
		add.w	d0,d0
		lea	wordK_8D944-2(pc,d0.w),a1
		movea.w	(a1)+,a2
		btst	#Status_Invincible,status_secondary(a2)
		bne.s	locretK_8D942
		tst.b	object_control(a2)
		bne.s	locretK_8D942
		move.w	a2,$44(a0)
		move.b	#6,routine(a0)
		moveq	#signextendB(sfx_Flipper),d0
		jsr	(Play_SFX).l
		move.w	x_vel(a0),d0
		lsl.w	#1,d0
		move.w	d0,x_vel(a2)
		move.w	d0,ground_vel(a2)
		move.w	#-$200,y_vel(a2)
		bset	#Status_InAir,status(a2)
		move.b	#$1A,anim(a2)
		clr.b	spin_dash_flag(a2)

locretK_8D942:
		rts
; End of function subK_8D8E6

; ---------------------------------------------------------------------------
wordK_8D944:
		dc.w Player_1
		dc.w Player_2
		dc.w Player_2

; =============== S U B R O U T I N E =======================================


subK_8D94A:
		move.b	collision_property(a0),d0
		beq.w	locretK_8D9A6
		clr.b	collision_property(a0)
		andi.w	#3,d0
		add.w	d0,d0
		lea	wordK_8D944-2(pc,d0.w),a1
		movea.w	(a1)+,a2
		btst	#Status_Invincible,status_secondary(a2)
		bne.s	locretK_8D9A6
		tst.b	object_control(a2)
		bne.s	locretK_8D9A6
		move.w	a2,$44(a0)
		move.b	#8,routine(a0)
		move.w	#0,priority(a0)
		move.l	#locK_8D846,$34(a0)
		moveq	#signextendB(sfx_Flipper),d0
		jsr	(Play_SFX).l
		bset	#Status_InAir,status(a2)
		move.b	#1,object_control(a2)
		move.b	#$1A,anim(a2)
		clr.b	spin_dash_flag(a2)

locretK_8D9A6:
		rts
; End of function subK_8D94A

; ---------------------------------------------------------------------------
ObjDat_Madmole:
		dc.l Map_Madmole
		dc.w make_art_tile(ArtTile_Madmole,0,0)
		dc.w   $280
		dc.b  $18,   4,  $D,   0
wordK_8D9B4:
		dc.w   $280
		dc.b   $C,  $C,   0,  $B
wordK_8D9BA:
		dc.w   $280
		dc.b    8,   8,   5, $D8
ChildObjDat_8D9C0:
		dc.w 1-1
		dc.l locK_8D602
		dc.b    0, $10
ChildObjDat_8D9C8:
		dc.w 1-1
		dc.l locK_8D6E6
		dc.b  -$E, -$C
ChildObjDat_8D9D0:
		dc.w 1-1
		dc.l locK_8D6E6
		dc.b   $E, -$C
byteK_8D9D8:
		dc.b    2,   0,   1,   2, $F4
byteK_8D9DD:
		dc.b    2,   3,   3,   4,   4,   4,   4,   4,   4, $F4
byteK_8D9E7:
		dc.b    2,   5,   6,   7,   8,   9,  $A,  $B,  $C, $FC
		even
Map_Madmole:
		include "General/Sprites/Madmole/Map - Madmole.asm"