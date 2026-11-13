; ---------------------------------------------------------------------------

Obj_Fireworm:
		jsr	(Obj_WaitOffscreen).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Fireworm_Index(pc,d0.w),d1
		jsr	Fireworm_Index(pc,d1.w)
		jmp	(Sprite_CheckDelete).l
; ---------------------------------------------------------------------------
Fireworm_Index:
		dc.w locK_8F770-Fireworm_Index
		dc.w locK_8F77A-Fireworm_Index
		dc.w locretK_8F7A2-Fireworm_Index
; ---------------------------------------------------------------------------

locK_8F770:
		lea	ObjDat3_8F9DE(pc),a1
		jmp	(SetUp_ObjAttributes).l
; ---------------------------------------------------------------------------

locK_8F77A:
		jsr	(Find_SonicTails).l
		cmpi.w	#$80,d2
		blo.s	locK_8F788
		rts
; ---------------------------------------------------------------------------

locK_8F788:
		move.b	#4,routine(a0)
		lea	ChildObjDat_8FA0E(pc),a2
		jsr	(CreateChild1_Normal).l
		bne.s	locretK_8F7A0
		move.b	subtype(a0),subtype(a1)

locretK_8F7A0:
		rts
; ---------------------------------------------------------------------------

locretK_8F7A2:
		rts
; ---------------------------------------------------------------------------

locK_8F7A4:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	offK_8F7E0(pc,d0.w),d1
		jsr	offK_8F7E0(pc,d1.w)
		lea	DPLCPtr_Fireworm(pc),a2
		jsr	(Perform_DPLC).l
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	locK_8F7DA
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_8F7DA:
		jmp	(Go_Delete_SpriteSlotted2).l
; ---------------------------------------------------------------------------
offK_8F7E0:
		dc.w locK_8F7EA-offK_8F7E0
		dc.w locK_8F7F4-offK_8F7E0
		dc.w locK_8F812-offK_8F7E0
		dc.w locK_8F862-offK_8F7E0
		dc.w locK_8F89A-offK_8F7E0
; ---------------------------------------------------------------------------

locK_8F7EA:
		lea	ObjSlot_Fireworm(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l

locK_8F7F4:
		move.b	#4,routine(a0)
		move.w	#3,$2E(a0)
		move.l	#locK_8F81E,$34(a0)
		move.w	#-$100,d4
		jmp	(Set_VelocityXTrackSonic).l
; ---------------------------------------------------------------------------

locK_8F812:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

locK_8F81E:
		move.b	#1,mapping_frame(a0)
		lea	ChildObjDat_8FA16(pc),a2
		jsr	(CreateChild1_Normal).l

locK_8F82E:
		move.b	#6,routine(a0)
		move.w	#-$100,$42(a0)
		move.l	#byteK_8FA40,$30(a0)

locK_8F842:
		move.b	#8,$39(a0)
		move.w	#$80,d0
		move.w	d0,$3E(a0)
		move.w	d0,y_vel(a0)
		move.w	#8,$40(a0)
		bclr	#0,$38(a0)
		rts
; ---------------------------------------------------------------------------

locK_8F862:
		jsr	(Swing_UpAndDown_Count).l
		bne.s	locK_8F876
		jsr	(MoveSprite2).l
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

locK_8F876:
		move.b	#8,routine(a0)
		move.w	x_vel(a0),$44(a0)
		move.w	$42(a0),y_vel(a0)
		neg.w	$42(a0)
		clr.w	$2E(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

locK_8F89A:
		lea	byteK_8FA4D(pc),a1
		jsr	(Animate_RawNoSSTMultiDelayFlipX).l
		addq.w	#1,$2E(a0)
		tst.w	$44(a0)
		bmi.s	locK_8F8C6
		move.w	x_vel(a0),d0
		subi.w	#$10,d0
		cmpi.w	#-$100,d0
		ble.s	locK_8F8DE
		move.w	d0,x_vel(a0)
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

locK_8F8C6:
		move.w	x_vel(a0),d0
		addi.w	#$10,d0
		cmpi.w	#$100,d0
		bge.s	locK_8F8DE
		move.w	d0,x_vel(a0)
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

locK_8F8DE:
		move.b	#6,routine(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		bra.w	locK_8F842
; ---------------------------------------------------------------------------

locK_8F8F0:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	offK_8F906(pc,d0.w),d1
		jsr	offK_8F906(pc,d1.w)
		moveq	#0,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------
offK_8F906:
		dc.w locK_8F910-offK_8F906
		dc.w locK_8F948-offK_8F906
		dc.w locK_8F948-offK_8F906
		dc.w locK_8F862-offK_8F906
		dc.w locK_8F89A-offK_8F906
; ---------------------------------------------------------------------------

locK_8F910:
		lea	ObjDat3_8F9FC(pc),a1
		jsr	(SetUp_ObjAttributes).l
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	wordK_8F940(pc,d0.w),$2E(a0)
		move.l	#locK_8F94E,$34(a0)
		movea.w	parent3(a0),a1
		move.w	x_vel(a1),x_vel(a0)
		move.b	render_flags(a1),render_flags(a0)
		rts
; ---------------------------------------------------------------------------
wordK_8F940:
		dc.w     $B,   $16,   $21,   $2C
; ---------------------------------------------------------------------------

locK_8F948:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

locK_8F94E:
		lea	ChildObjDat_8FA30(pc),a2
		jsr	(CreateChild1_Normal).l
		bra.w	locK_8F82E
; ---------------------------------------------------------------------------

locK_8F95C:
		jsr	(Refresh_ChildPositionAdjusted).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	offK_8F976(pc,d0.w),d1
		jsr	offK_8F976(pc,d1.w)
		jmp	(Child_DrawTouch_Sprite).l
; ---------------------------------------------------------------------------
offK_8F976:
		dc.w locK_8F97C-offK_8F976
		dc.w locK_8F99E-offK_8F976
		dc.w locK_8F9C8-offK_8F976
; ---------------------------------------------------------------------------

locK_8F97C:
		lea	wordK_8FA08(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#byteK_8FA56,$30(a0)
		move.l	#locK_8F9A4,$34(a0)
		bset	#4,shield_reaction(a0)
		rts
; ---------------------------------------------------------------------------

locK_8F99E:
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

locK_8F9A4:
		move.b	#4,routine(a0)
		move.b	#7,mapping_frame(a0)
		jsr	(Random_Number).l
		andi.w	#$3F,d0
		move.w	d0,$2E(a0)
		move.l	#locK_8F9CE,$34(a0)
		rts
; ---------------------------------------------------------------------------

locK_8F9C8:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

locK_8F9CE:
		move.b	#2,routine(a0)
		move.l	#locK_8F9A4,$34(a0)
		rts
; ---------------------------------------------------------------------------
ObjDat3_8F9DE:
		dc.l Map_FirewormSegments
		dc.w make_art_tile(ArtTile_FirewormSegments,3,1)
		dc.w   $280
		dc.b   $C,  $C,   0,   0
ObjSlot_Fireworm:
		dc.w 2-1
		dc.w make_art_tile(ArtTile_Fireworm,1,1)
		dc.w      9,     0
		dc.l Map_Fireworm
		dc.w   $180
		dc.b   $C,  $C,   0, $1A
ObjDat3_8F9FC:
		dc.l Map_FirewormSegments
		dc.w make_art_tile(ArtTile_FirewormSegments,1,1)
		dc.w   $200
		dc.b    8,   8,   1, $98
wordK_8FA08:
		dc.w   $180
		dc.b    8,   8,   3, $98
ChildObjDat_8FA0E:
		dc.w 1-1
		dc.l locK_8F7A4
		dc.b    0,  -8
ChildObjDat_8FA16:
		dc.w 4-1
		dc.l locK_8F8F0
		dc.b    0,   0
		dc.l locK_8F8F0
		dc.b    0,   0
		dc.l locK_8F8F0
		dc.b    0,   0
		dc.l locK_8F8F0
		dc.b    0,   0
ChildObjDat_8FA30:
		dc.w 1-1
		dc.l locK_8F95C
		dc.b    0, -$E
DPLCPtr_Fireworm:
		dc.l ArtUnc_Fireworm
		dc.l DPLC_Fireworm
byteK_8FA40:
		dc.b    1,   3
		dc.b    1,   6
		dc.b    2,   8
		dc.b    3,   1
		dc.b  $F8, .jump-byteK_8FA40

.jump:
		dc.b    3, $7F
		dc.b  $FC
byteK_8FA4D:
		dc.b    3,       7
		dc.b    2,       7
		dc.b    2|$40,   7
		dc.b    3,     $7F
		dc.b  $FC
byteK_8FA56:
		dc.b    3,   4,   4,   5,   6, $F4
		even
Map_FirewormSegments:
		include "General/Sprites/Fireworm/Map - Fireworm Segments.asm"
DPLC_Fireworm:
		include "General/Sprites/Fireworm/DPLC - Fireworm.asm"
Map_Fireworm:
		include "General/Sprites/Fireworm/Map - Fireworm.asm"