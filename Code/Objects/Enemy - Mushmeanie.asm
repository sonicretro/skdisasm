; ---------------------------------------------------------------------------

Obj_Mushmeanie:
		jsr	(Obj_WaitOffscreen).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Mushmeanie_Index(pc,d0.w),d1
		jsr	Mushmeanie_Index(pc,d1.w)
		bsr.w	subK_8DC6E
		jmp	(Sprite_CheckDeleteTouch).l
; ---------------------------------------------------------------------------
Mushmeanie_Index:
		dc.w locK_8DB1E-Mushmeanie_Index
		dc.w locK_8DB3E-Mushmeanie_Index
		dc.w locK_8DB64-Mushmeanie_Index
		dc.w locK_8DB94-Mushmeanie_Index
		dc.w locK_8DBEC-Mushmeanie_Index
; ---------------------------------------------------------------------------

locK_8DB1E:
		lea	ObjDat_Mushmeanie(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#2,$39(a0)
		move.b	#$12,y_radius(a0)
		lea	ChildObjDat_8DCDE(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

locK_8DB3E:
		jsr	(Find_SonicTails).l
		cmpi.w	#$80,d2
		blo.s	locK_8DB4C
		rts
; ---------------------------------------------------------------------------

locK_8DB4C:
		move.b	#4,routine(a0)
		move.l	#byteK_8DCE6,$30(a0)
		move.l	#locK_8DB76,$34(a0)

locretK_8DB62:
		rts
; ---------------------------------------------------------------------------

locK_8DB64:
		jsr	(Animate_RawMultiDelay).l
		tst.w	d2
		bne.s	locK_8DB70
		rts
; ---------------------------------------------------------------------------

locK_8DB70:
		subq.w	#3,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

locK_8DB76:
		move.b	#6,routine(a0)
		move.w	#-$300,y_vel(a0)
		move.l	#locK_8DBD4,$34(a0)
		move.w	#-$100,d4
		jmp	(Set_VelocityXTrackSonic).l
; ---------------------------------------------------------------------------

locK_8DB94:
		jsr	(MoveSprite_LightGravity).l
		tst.w	x_vel(a0)
		bmi.s	locK_8DBAC
		moveq	#8,d3
		jsr	(ObjCheckRightWallDist).l
		bra.w	locK_8DBB4
; ---------------------------------------------------------------------------

locK_8DBAC:
		moveq	#-8,d3
		jsr	(ObjCheckLeftWallDist).l

locK_8DBB4:
		tst.w	d1
		bpl.s	locK_8DBC6
		add.w	d1,x_pos(a0)
		neg.w	x_vel(a0)
		bchg	#0,render_flags(a0)

locK_8DBC6:
		tst.w	y_vel(a0)
		bmi.w	locretK_8DB62
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

locK_8DBD4:
		move.b	#8,routine(a0)
		move.l	#byteK_8DCED,$30(a0)
		move.l	#locK_8DB76,$34(a0)
		rts
; ---------------------------------------------------------------------------

locK_8DBEC:
		jsr	(Animate_RawMultiDelay).l
		tst.w	d2
		bne.s	locK_8DBF8
		rts
; ---------------------------------------------------------------------------

locK_8DBF8:
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		move.w	wordK_8DC08(pc,d0.w),d0
		add.w	d0,y_pos(a0)
		rts
; ---------------------------------------------------------------------------
wordK_8DC08:
		dc.w     -3,     3,     3,    -3,    -3,    -3
; ---------------------------------------------------------------------------

locK_8DC14:
		lea	wordK_8DCD6(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#locK_8DC24,(a0)

locK_8DC24:
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		btst	#6,status(a1)
		bne.s	locK_8DC42
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_8DC42:
		move.l	#locK_8DC62,(a0)
		movea.w	$44(a1),a2
		move.w	#$200,d0
		tst.w	x_vel(a2)
		bmi.s	locK_8DC58
		neg.w	d0

locK_8DC58:
		move.w	d0,x_vel(a0)
		move.w	#-$200,y_vel(a0)

locK_8DC62:
		jsr	(MoveSprite_LightGravity).l
		jmp	(Sprite_CheckDeleteXY).l

; =============== S U B R O U T I N E =======================================


subK_8DC6E:
		tst.b	$20(a0)
		beq.s	locK_8DC80
		subq.b	#1,$20(a0)
		bne.s	locretK_8DCC2
		move.b	#$D7,collision_flags(a0)

locK_8DC80:
		jsr	(Check_PlayerCollision).l
		beq.s	locretK_8DCC2
		jsr	(Check_PlayerAttack).l
		bne.s	locK_8DC9C
		tst.b	invulnerability_timer(a1)
		bne.s	locretK_8DCC2
		jmp	(HurtCharacter_Directly).l
; ---------------------------------------------------------------------------

locK_8DC9C:
		subq.b	#1,$39(a0)
		beq.s	locK_8DCC4
		clr.b	collision_flags(a0)
		clr.b	collision_property(a0)
		move.b	#$20,$20(a0)
		bset	#6,status(a0)
		neg.w	x_vel(a1)
		neg.w	y_vel(a1)
		neg.w	ground_vel(a1)

locretK_8DCC2:
		rts
; ---------------------------------------------------------------------------

locK_8DCC4:
		jmp	(EnemyDefeated).l
; End of function subK_8DC6E

; ---------------------------------------------------------------------------
ObjDat_Mushmeanie:
		dc.l Map_Mushmeanie
		dc.w make_art_tile(ArtTile_Mushmeanie,1,0)
		dc.w   $280
		dc.b    8,   8,   1, $D7
wordK_8DCD6:
		dc.w make_art_tile(ArtTile_Mushmeanie,2,0)
		dc.w   $200
		dc.b   $C,   8,   0,   0
ChildObjDat_8DCDE:
		dc.w 1-1
		dc.l locK_8DC14
		dc.b    0,   0
byteK_8DCE6:
		dc.b    1,   2
		dc.b    2,   2
		dc.b    3,   0
		dc.b  $F4
byteK_8DCED:
		dc.b    3,   2
		dc.b    2,   2
		dc.b    1,   2
		dc.b    2,   2
		dc.b    3,   0
		dc.b  $F4
		even
Map_Mushmeanie:
		include "General/Sprites/Mushmeanie/Map - Mushmeanie.asm"