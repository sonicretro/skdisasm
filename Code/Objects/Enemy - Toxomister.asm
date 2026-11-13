; ---------------------------------------------------------------------------

Obj_Toxomister:
		jsr	(Obj_WaitOffscreen).l
		lea	ObjDat_Toxomister(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#locK_8FD76,(a0)
		bset	#6,render_flags(a0)
		move.w	#1,mainspr_childsprites(a0)
		lea	sub2_x_pos(a0),a1
		move.w	x_pos(a0),(a1)+
		move.w	y_pos(a0),d0
		moveq	#$18,d1
		btst	#1,render_flags(a0)
		beq.s	locK_8FD6A
		neg.w	d1

locK_8FD6A:
		add.w	d1,d0
		move.w	d0,(a1)+
		move.w	#0,(a1)+
		bsr.w	subK_8FF72

locK_8FD76:
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		beq.s	locK_8FD96
		move.l	#locK_8FDA0,(a0)
		move.w	#$1F,$2E(a0)
		move.l	#locK_8FDB0,$34(a0)

locK_8FD96:
		bsr.w	subK_8FF5A
		jmp	(Sprite_CheckDeleteTouch).l
; ---------------------------------------------------------------------------

locK_8FDA0:
		bsr.w	subK_8FF5A
		jsr	(Obj_Wait).l
		jmp	(Sprite_CheckDeleteTouch).l
; ---------------------------------------------------------------------------

locK_8FDB0:
		move.l	#locK_8FD76,(a0)
		bra.w	subK_8FF72
; ---------------------------------------------------------------------------

locK_8FDBA:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	offK_8FDCE(pc,d0.w),d1
		jsr	offK_8FDCE(pc,d1.w)
		jmp	(Child_AddToTouchList).l
; ---------------------------------------------------------------------------
offK_8FDCE:
		dc.w locK_8FDD8-offK_8FDCE
		dc.w locK_8FE06-offK_8FDCE
		dc.w locK_8FE26-offK_8FDCE
		dc.w locK_8FE06-offK_8FDCE
		dc.w locK_8FE50-offK_8FDCE
; ---------------------------------------------------------------------------

locK_8FDD8:
		lea	wordK_9003A(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.b	#$D8,collision_flags(a0)
		move.b	#$18,y_radius(a0)
		move.w	#$6F,$2E(a0)
		move.l	#locK_8FE10,$34(a0)
		lea	ChildObjDat_90048(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

locK_8FE06:
		bsr.w	subK_8FF8C
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

locK_8FE10:
		move.b	#4,routine(a0)
		move.w	#$40,y_vel(a0)
		move.l	#locK_8FE36,$34(a0)

locretK_8FE24:
		rts
; ---------------------------------------------------------------------------

locK_8FE26:
		bsr.w	subK_8FF8C
		jsr	(MoveSprite2).l
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

locK_8FE36:
		move.b	#6,routine(a0)
		clr.w	y_vel(a0)
		move.w	#$7F,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		rts
; ---------------------------------------------------------------------------

locK_8FE50:
		movea.w	$44(a0),a1
		cmpi.b	#9,anim(a1)
		beq.s	locK_8FE82
		jsr	(Check_LRControllerShake).l
		bne.s	locK_8FE88
		movea.w	$44(a0),a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		bsr.w	subK_8FFE0
		jsr	(sub_881FE).l
		beq.w	locretK_8FE24

locK_8FE82:
		bset	#2,$38(a0)

locK_8FE88:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

locK_8FE8E:
		lea	wordK_9003A(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#locK_8FEC8,(a0)
		move.l	#byteK_90074,$30(a0)
		move.b	subtype(a0),d0
		subi.b	#$C,d0
		neg.b	d0
		move.b	d0,subtype(a0)
		lsl.b	#2,d0
		move.b	d0,$2F(a0)
		move.l	#locK_8FED4,$34(a0)
		jmp	(Child_CheckParent).l
; ---------------------------------------------------------------------------

locK_8FEC8:
		jsr	(Obj_Wait).l
		jmp	(Child_CheckParent).l
; ---------------------------------------------------------------------------

locK_8FED4:
		move.l	#locK_8FEDC,(a0)
		rts
; ---------------------------------------------------------------------------

locK_8FEDC:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	locK_8FF12
		jsr	(Refresh_ChildPosition).l
		jsr	(Animate_Raw).l
		btst	#0,(V_int_run_count+3).w
		sne	d0
		btst	#0,subtype(a0)
		beq.s	locK_8FF06
		not.b	d0

locK_8FF06:
		tst.b	d0
		bne.w	locretK_8FE24
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_8FF12:
		clr.w	x_vel(a0)
		btst	#2,$38(a1)
		beq.s	locK_8FF22
		bsr.w	locK_90002

locK_8FF22:
		clr.w	y_vel(a0)
		move.l	#locK_8FF42,(a0)
		move.l	#byteK_90085,$30(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		jmp	(Sprite_CheckDeleteXY).l
; ---------------------------------------------------------------------------

locK_8FF42:
		addi.w	#-$10,y_vel(a0)
		jsr	(MoveSprite2).l
		jsr	(Animate_Raw).l
		jmp	(Sprite_CheckDeleteXY).l

; =============== S U B R O U T I N E =======================================


subK_8FF5A:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#7,d0
		bne.w	locretK_8FE24
		jsr	(Find_SonicTails).l
		jmp	(Change_FlipX).l
; End of function subK_8FF5A


; =============== S U B R O U T I N E =======================================


subK_8FF72:
		moveq	#signextendB(sfx_EnemyBreath),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_90040(pc),a2
		jsr	(CreateChild10_NormalAdjusted).l
		bne.s	locretK_8FF8A
		move.w	a1,$44(a0)

locretK_8FF8A:
		rts
; End of function subK_8FF72


; =============== S U B R O U T I N E =======================================


subK_8FF8C:
		move.b	collision_property(a0),d0
		beq.w	locretK_8FE24
		clr.b	collision_property(a0)
		andi.w	#3,d0
		lsl.w	#2,d0
		lea	wordK_8FFD4-4(pc,d0.w),a1
		movea.w	(a1)+,a2
		cmpi.b	#2,anim(a2)
		beq.w	locretK_8FE24
		btst	#Status_BublShield,status_secondary(a2)
		bne.w	locretK_8FE24
		move.w	a2,$44(a0)
		movea.w	(a1)+,a2
		move.w	a2,$3E(a0)
		move.w	(a2),$3A(a0)
		move.b	#8,routine(a0)
		move.w	#60-1,$2E(a0)
		rts
; End of function subK_8FF8C

; ---------------------------------------------------------------------------
wordK_8FFD4:
		dc.w  Player_1, Ctrl_1
		dc.w  Player_2, Ctrl_2
		dc.w  Player_1, Ctrl_1

; =============== S U B R O U T I N E =======================================


subK_8FFE0:
		move.w	x_vel(a1),d0
		asr.w	#3,d0
		sub.w	d0,x_vel(a1)
		moveq	#ground_vel,d0
		btst	#Status_InAir,status(a1)
		beq.s	locK_8FFF6
		moveq	#y_vel,d0

locK_8FFF6:
		move.w	(a1,d0.w),d1
		asr.w	#3,d1
		sub.w	d1,(a1,d0.w)
		rts
; End of function subK_8FFE0

; ---------------------------------------------------------------------------

locK_90002:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	wordK_90020(pc,d0.w),d0
		movea.w	$44(a1),a2
		btst	#0,render_flags(a2)
		bne.s	locK_9001A
		neg.w	d0

locK_9001A:
		move.w	d0,x_vel(a0)
		rts
; ---------------------------------------------------------------------------
wordK_90020:
		dc.w   $100,  $180,  $200,  $180,  $100,  $200,  $180
ObjDat_Toxomister:
		dc.l Map_Toxomister
		dc.w make_art_tile(ArtTile_Toxomister,1,1)
		dc.w   $280
		dc.b    8,   8,   1, $18
wordK_9003A:
		dc.w      0
		dc.b    8,   8,   2,   0
ChildObjDat_90040:
		dc.w 1-1
		dc.l locK_8FDBA
		dc.b  -$C,   8
ChildObjDat_90048:
		dc.w 7-1
		dc.l locK_8FE8E
		dc.b  -$C,   4
		dc.l locK_8FE8E
		dc.b   $C,   4
		dc.l locK_8FE8E
		dc.b   -8,  -4
		dc.l locK_8FE8E
		dc.b    8,  -4
		dc.l locK_8FE8E
		dc.b    0,  -4
		dc.l locK_8FE8E
		dc.b   -4,   4
		dc.l locK_8FE8E
		dc.b    4,   4
byteK_90074:
		dc.b    7,   2,   3,   4,   5,   6,   7, $F8
		dc.b    9,   7,   6,   5,   4,   5,   6,   7, $FC
byteK_90085:
		dc.b    7,   7,   6,   5,   4,   3,   2, $F4
		even
Map_Toxomister:
		include "General/Sprites/Toxomister/Map - Toxomister.asm"