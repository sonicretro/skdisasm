; ---------------------------------------------------------------------------

Obj_Flybot767:
		jsr	(Obj_WaitOffscreen).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Flybot767_Index(pc,d0.w),d1
		jsr	Flybot767_Index(pc,d1.w)
		lea	DPLCPtr_Flybot767(pc),a2
		jsr	Perform_DPLC(pc)
		jmp	(Sprite_CheckDeleteTouchSlotted).l
; ---------------------------------------------------------------------------
Flybot767_Index:
		dc.w locK_8C994-Flybot767_Index
		dc.w locK_8C9B2-Flybot767_Index
		dc.w locK_8CA16-Flybot767_Index
		dc.w locK_8CA60-Flybot767_Index
		dc.w locK_8CA96-Flybot767_Index
		dc.w locK_8CADA-Flybot767_Index
; ---------------------------------------------------------------------------
; loc3_5A108:
locK_8C994:
		lea	ObjSlot_Flybot767(pc),a1
		jsr	SetUp_ObjAttributesSlotted(pc)
		move.l	#byteK_8CB2A,$30(a0)
		move.b	#0,child_dx(a0)
		move.b	#-$40,child_dy(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_5A126:
locK_8C9B2:
		lea	(Player_1).w,a1
		move.w	#$200,d0
		moveq	#$10,d1
		jsr	Chase_ObjectXOnly(pc)
		move.w	#$100,d0
		moveq	#$10,d1
		jsr	Chase_ObjectYOnly(pc)
		jsr	(MoveSprite2).l
		lea	(Player_1).w,a1
		jsr	Find_OtherObject(pc)
		tst.w	d1
		beq.s	locK_8C9E2
		cmpi.w	#$60,d2
		blo.s	locK_8C9EC
; loc3_5A156:
locK_8C9E2:
		jsr	Change_FlipXWithVelocity(pc)
	if Sonic3_Alone
		jmp	Animate_Raw(pc)
	else
		jmp	(Animate_Raw).l
	endif
; ---------------------------------------------------------------------------
; loc3_5A15E:
locK_8C9EC:
		move.b	#4,routine(a0)
		clr.w	y_vel(a0)
		move.w	y_pos(a0),$44(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		move.l	#byteK_8CB36,$30(a0)
		move.l	#locK_8CA22,$34(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_5A188:
locK_8CA16:
		jsr	(MoveSprite2).l
	if Sonic3_Alone
		jmp	Animate_Raw(pc)
	else
		jmp	(Animate_Raw).l
	endif
; ---------------------------------------------------------------------------
; loc3_5A192:
locK_8CA22:
		move.b	#6,routine(a0)
		lea	(Player_1).w,a1
		jsr	Find_OtherObject(pc)
		move.w	#$200,d1
		bset	#0,render_flags(a0)
		tst.w	d0
		bne.s	locK_8CA46
		neg.w	d1
		bclr	#0,render_flags(a0)
; loc3_5A1B6:
locK_8CA46:
		move.w	d1,x_vel(a0)
		move.l	#byteK_8CB3F,$30(a0)
		move.w	#$200,y_vel(a0)
		move.w	#$20,$2E(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_5A1D0:
locK_8CA60:
		jsr	(MoveSprite2).l
		subq.w	#1,$2E(a0)
		bpl.s	locK_8CA74
		jsr	Find_SonicTails(pc)
		tst.w	d1
		beq.s	locK_8CA7A
; loc3_5A1E4:
locK_8CA74:
	if Sonic3_Alone
		jmp	Animate_Raw(pc)
	else
		jmp	(Animate_Raw).l
	endif
; ---------------------------------------------------------------------------
; loc3_5A1E8:
locK_8CA7A:
		move.b	#8,routine(a0)
		move.l	#byteK_8CB4B,$30(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		neg.w	y_vel(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_5A204:
locK_8CA96:
		jsr	(MoveSprite2).l
		move.w	y_pos(a0),d0
		cmp.w	$44(a0),d0
		blo.s	locK_8CAAC
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------
; loc3_5A21A:
locK_8CAAC:
		move.b	#$A,routine(a0)
		move.l	#byteK_8CB2A,$30(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		move.w	#$1F,$2E(a0)
		move.l	#locK_8CB08,$34(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_5A248:
locK_8CADA:
		lea	(Player_1).w,a1
		move.w	#$200,d0
		moveq	#$10,d1
		jsr	Chase_ObjectXOnly(pc)
		move.w	#$100,d0
		moveq	#$10,d1
		jsr	Chase_ObjectYOnly(pc)
		jsr	(MoveSprite2).l
		jsr	Change_FlipXWithVelocity(pc)
	if Sonic3_Alone
		jsr	Animate_Raw(pc)
		jmp	Obj_Wait(pc)
	else
		jsr	(Animate_Raw).l
		jmp	(Obj_Wait).l
	endif
; ---------------------------------------------------------------------------
; loc3_5A272:
locK_8CB08:
		move.b	#2,routine(a0)
		rts
; ---------------------------------------------------------------------------
ObjSlot_Flybot767:
		dc.w 3-1
		dc.w make_art_tile(ArtTile_Flybot767,1,1)
		dc.w     $C,     0
		dc.l Map_Flybot767
		dc.w   $280
		dc.b  $10, $10,   0, $1A
DPLCPtr_Flybot767:
		dc.l ArtUnc_Flybot767
		dc.l DPLC_Flybot767
; byte3_5A294:
byteK_8CB2A:
		dc.b    4,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9, $FC
; byte3_5A2A0:
byteK_8CB36:
		dc.b    2,  $A,  $A,  $B,  $C,  $D,  $E,  $F, $F4
; byte3_5A2A9:
byteK_8CB3F:
		dc.b    3, $10, $10, $11, $12, $13
		dc.b  $F8, .jump-byteK_8CB3F

.jump:
		dc.b    3, $13, $13, $FC
; byte3_5A2B5:
byteK_8CB4B:
		dc.b    3,  $A,  $A, $14
		dc.b  $F8, .jump-byteK_8CB4B

.jump:
		dc.b    3, $14, $14, $FC
		even