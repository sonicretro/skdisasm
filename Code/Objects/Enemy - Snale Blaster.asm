; No, that file name isn't a typo, that really was how it was spelled in the
; Sonic 3 U.S. manual. Sonic Jam corrected this, however.

; ---------------------------------------------------------------------------

Obj_SnaleBlaster:
		jsr	(Obj_WaitOffscreen).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	SnaleBlaster_Index(pc,d0.w),d1
		jsr	SnaleBlaster_Index(pc,d1.w)
		jmp	Sprite_CheckDeleteTouch(pc)
; ---------------------------------------------------------------------------
SnaleBlaster_Index:
		dc.w locK_8BFD4-SnaleBlaster_Index
		dc.w locK_8BFF2-SnaleBlaster_Index
		dc.w locK_8C026-SnaleBlaster_Index
		dc.w locK_8C052-SnaleBlaster_Index
		dc.w locK_8C0AA-SnaleBlaster_Index
		dc.w locK_8C0D4-SnaleBlaster_Index
		dc.w locK_8C0F4-SnaleBlaster_Index
; ---------------------------------------------------------------------------
; loc3_5976C:
locK_8BFD4:
		lea	ObjDat_SnaleBlaster(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.w	#$20,$2E(a0)
		move.l	#locK_8C00E,$34(a0)
		lea	ChildObjDat_8C28A(pc),a2
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------
; loc3_5978A:
locK_8BFF2:
		move.b	#$1A,collision_flags(a0)
		clr.b	collision_property(a0)
		btst	#1,$38(a0)
		bne.s	locK_8C00A
		move.b	#$7F,collision_property(a0)
; loc3_597A2:
locK_8C00A:
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------
; loc3_597A6:
locK_8C00E:
		move.b	#4,routine(a0)
		move.l	#byteK_8C2B6,$30(a0)
		move.l	#locK_8C030,$34(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_597BE:
locK_8C026:
		move.b	#$1A,collision_flags(a0)
		jmp	Animate_Raw(pc)
; ---------------------------------------------------------------------------
; loc3_597C8:
locK_8C030:
		move.w	#-2,$40(a0)
		move.l	#byteK_8C2C0,$30(a0)
; loc3_597D6:
locK_8C03E:
		move.b	#6,routine(a0)
		move.b	#2,$39(a0)
		bclr	#1,$38(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_597EA:
locK_8C052:
		move.b	#$1A,collision_flags(a0)
		move.b	#$7F,collision_property(a0)
		bsr.w	subK_8C23C
		jsr	Animate_RawMultiDelay(pc)
		tst.w	d2
		beq.s	locretK_8C088
		moveq	#3,d0
		tst.w	$40(a0)
		bmi.s	locK_8C074
		moveq	#4,d0
; loc3_5980C:
locK_8C074:
		cmp.b	mapping_frame(a0),d0
		bne.s	locretK_8C088
		move.w	$40(a0),d0
		add.w	d0,y_pos(a0)
		subq.b	#1,$39(a0)
		bmi.s	locK_8C08A
; locret3_59820:
locretK_8C088:
		rts
; ---------------------------------------------------------------------------
; loc3_59822:
locK_8C08A:
		move.b	#2,routine(a0)
		move.w	#$90,$2E(a0)
		bset	#1,$38(a0)
		move.l	#locK_8C03E,$34(a0)
		neg.w	$40(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_59842:
locK_8C0AA:
		move.b	#$7F,collision_property(a0)
		subq.b	#1,mapping_frame(a0)
		beq.s	locK_8C0B8
		rts
; ---------------------------------------------------------------------------
; loc3_59850:
locK_8C0B8:
		move.b	#$A,routine(a0)
		move.b	#$7F,collision_property(a0)
		move.w	#60-1,$2E(a0)
		move.l	#locK_8C0DE,$34(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_5986C:
locK_8C0D4:
		move.b	#$7F,collision_property(a0)
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------
; loc3_59876:
locK_8C0DE:
		move.b	#$C,routine(a0)
		move.w	#$F,$2E(a0)
		move.l	#locK_8C0F8,$34(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_5988C:
locK_8C0F4:
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------
; loc3_59890:
locK_8C0F8:
		move.b	#$1A,collision_flags(a0)
		move.b	#$7F,collision_property(a0)
		move.w	#2,$2E(a0)
		addq.b	#1,mapping_frame(a0)
		cmpi.b	#3,mapping_frame(a0)
		blo.s	locretK_8C11C
		move.b	#6,routine(a0)
; locret3_598B4:
locretK_8C11C:
		rts
; ---------------------------------------------------------------------------
; loc3_598B6:
locK_8C11E:
		jsr	Refresh_ChildPositionAdjusted(pc)
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	offK_8C134(pc,d0.w),d1
		jsr	offK_8C134(pc,d1.w)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------
; off3_598CC:
offK_8C134:
		dc.w locK_8C13A-offK_8C134
		dc.w locK_8C144-offK_8C134
		dc.w Animate_RawMultiDelay-offK_8C134
; ---------------------------------------------------------------------------
; loc3_598D2:
locK_8C13A:
		lea	wordK_8C272(pc),a1
	if Sonic3_Alone
		jmp	SetUp_ObjAttributes3(pc)
	else
		jmp	(SetUp_ObjAttributes3).l
	endif
; ---------------------------------------------------------------------------
; loc3_598DA:
locK_8C144:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	locK_8C152
		rts
; ---------------------------------------------------------------------------
; loc3_598E8:
locK_8C152:
		move.b	#4,routine(a0)
		move.l	#byteK_8C2C5,$30(a0)
		move.l	#locK_8C16A,$34(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_59900:
locK_8C16A:
		move.b	#2,routine(a0)
		movea.w	parent3(a0),a1
		bclr	#1,$38(a1)
		rts
; ---------------------------------------------------------------------------
; loc3_59912:
locK_8C17C:
		jsr	Refresh_ChildPositionAdjusted(pc)
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	offK_8C192(pc,d0.w),d1
		jsr	offK_8C192(pc,d1.w)
		jmp	Child_DrawTouch_Sprite(pc)
; ---------------------------------------------------------------------------
; off3_59928:
offK_8C192:
		dc.w locK_8C19A-offK_8C192
		dc.w locK_8C1A4-offK_8C192
		dc.w locK_8C1D8-offK_8C192
		dc.w locK_8C226-offK_8C192
; ---------------------------------------------------------------------------
; loc3_59930:
locK_8C19A:
		lea	wordK_8C278(pc),a1
	if Sonic3_Alone
		jmp	SetUp_ObjAttributes3(pc)
	else
		jmp	(SetUp_ObjAttributes3).l
	endif
; ---------------------------------------------------------------------------
; loc3_59938:
locK_8C1A4:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	locK_8C1B2
		rts
; ---------------------------------------------------------------------------
; loc3_59946:
locK_8C1B2:
		move.b	#4,routine(a0)
		move.l	#byteK_8C2D0,$30(a0)
		tst.b	subtype(a0)
		beq.s	locK_8C1CE
		move.l	#byteK_8C2D9,$30(a0)
; loc3_59962:
locK_8C1CE:
		move.l	#locK_8C21E,$34(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_5996C:
locK_8C1D8:
		jsr	Animate_RawMultiDelay(pc)
		tst.w	d2
		beq.s	locretK_8C21C
		bmi.s	locretK_8C21C
		cmpi.b	#4,anim_frame(a0)
		bne.s	locretK_8C21C
		tst.b	render_flags(a0)
		bpl.s	locretK_8C21C
		moveq	#signextendB(sfx_Projectile),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_8C29E(pc),a2
	if Sonic3_Alone
		jsr	CreateChild2_Complex(pc)
	else
		jsr	(CreateChild2_Complex).l
	endif
		movea.w	parent3(a0),a2
		btst	#0,render_flags(a2)
		beq.s	locK_8C212
		neg.w	x_vel(a1)
; loc3_599A4:
locK_8C212:
		tst.b	subtype(a0)
		beq.s	locretK_8C21C
		neg.w	y_vel(a1)
; locret3_599AE:
locretK_8C21C:
		rts
; ---------------------------------------------------------------------------
; loc3_599B0:
locK_8C21E:
		move.b	#6,routine(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_599B8:
locK_8C226:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		beq.s	locK_8C234
		rts
; ---------------------------------------------------------------------------
; loc3_599C6:
locK_8C234:
		move.b	#2,routine(a0)
		rts

; =============== S U B R O U T I N E =======================================

; sub3_599CE:
subK_8C23C:
		jsr	Find_SonicTails(pc)
		cmpi.w	#$30,d2
		bhs.s	locretK_8C254
		cmpi.w	#$30,d3
		bhs.s	locretK_8C254
		cmpi.b	#2,anim(a1)
		beq.s	locK_8C256
; locret3_599E6:
locretK_8C254:
		rts
; ---------------------------------------------------------------------------
; loc3_599E8:
locK_8C256:
		move.b	#8,routine(a0)
		move.b	#3,mapping_frame(a0)
		addq.w	#4,sp
		rts
; End of function subK_8C23C

; ---------------------------------------------------------------------------
ObjDat_SnaleBlaster:
		dc.l Map_SnaleBlaster
		dc.w make_art_tile(ArtTile_SnaleBlaster,1,0)
		dc.w   $200
		dc.b  $10, $10,   0,  $B
; word3_59A14:
wordK_8C272:
		dc.w   $180
		dc.b    4,  $C,   5,   0
; word3_59A1A:
wordK_8C278:
		dc.w   $200
		dc.b    4,   4,   7,   0
ObjDat3_8C27E:
		dc.l Map_SnaleBlaster
		dc.w make_art_tile(ArtTile_SnaleBlaster,0,1)
		dc.w   $200
		dc.b    4,   4,   9, $98
ChildObjDat_8C28A:
		dc.w 3-1
		dc.l locK_8C17C
		dc.b   -8,   0
		dc.l locK_8C17C
		dc.b   -8,   7
		dc.l locK_8C11E
		dc.b   -8,   4
ChildObjDat_8C29E:
		dc.w 1-1
	if Sonic3_Alone
		dc.l loc_54B46
	else
		dc.l loc_86D4A
	endif
		dc.l ObjDat3_8C27E
		dc.l 0
		dc.l MoveSprite2
		dc.b    0,   0
		dc.w  -$200, -$100
; byte3_59A48:
byteK_8C2B6:
		dc.b    5,   0,   1,   2,   3,   4,   4,   4,   4, $F4
; byte3_59A52:
byteK_8C2C0:
		dc.b    4,  $F
		dc.b    3,  $F
		dc.b  $FC
; byte3_59A57:
byteK_8C2C5:
		dc.b    5,   2
		dc.b    6,   2
		dc.b   $A, $5F
		dc.b    6,   2
		dc.b    5,   2
		dc.b  $F4
; byte3_59A62:
byteK_8C2D0:
		dc.b    7,   2
		dc.b    7, $1F
		dc.b    8,   3
		dc.b    7,   0
		dc.b  $F4
; byte3_59A6B:
byteK_8C2D9:
		dc.b    7,   2
		dc.b    7, $2F
		dc.b    8,   3
		dc.b    7,   0
		dc.b  $F4
		even