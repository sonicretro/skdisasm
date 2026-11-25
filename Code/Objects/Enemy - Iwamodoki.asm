; ---------------------------------------------------------------------------

Obj_Iwamodoki:
		jsr	(Obj_WaitOffscreen).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Iwamodoki_Index(pc,d0.w),d1
		jsr	Iwamodoki_Index(pc,d1.w)
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	locK_8FB2A
		btst	#7,status(a0)
		bne.s	locK_8FB36
		moveq	#$17,d1
		moveq	#$C,d2
		moveq	#$B,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_8FB2A:
		jsr	(Displace_PlayerOffObject).l
		jmp	(loc_85088).l
; ---------------------------------------------------------------------------

locK_8FB36:
		jmp	(Displace_PlayerOffObject).l
; ---------------------------------------------------------------------------
Iwamodoki_Index:
		dc.w locK_8FB42-Iwamodoki_Index
		dc.w locK_8FB4C-Iwamodoki_Index
		dc.w locK_8FB70-Iwamodoki_Index
; ---------------------------------------------------------------------------

locK_8FB42:
		lea	ObjDat_Iwamodoki(pc),a1
		jmp	(SetUp_ObjAttributes).l
; ---------------------------------------------------------------------------

locK_8FB4C:
		jsr	(Find_SonicTails).l
		cmpi.w	#$40,d2
		bhs.s	locretK_8FB6E
		move.b	#4,routine(a0)
		move.l	#byteK_8FC30,$30(a0)
		move.l	#locK_8FB76,$34(a0)

locretK_8FB6E:
		rts
; ---------------------------------------------------------------------------

locK_8FB70:
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

locK_8FB76:
	if FixBugs
		; This code makes Iwamodoki properly give you 100 points.
		moveq	#10,d0
		jsr	(HUD_AddToScore).l
	else
		; Bug: When Iwamodoki explodes, 100 points is never actually given out.
	endif
		move.l	#Obj_Explosion,(a0)
		bset	#7,status(a0)
		clr.b	routine(a0)
		lea	ChildObjDat_8FBD6(pc),a2
		jmp	(CreateChild2_Complex).l
; ---------------------------------------------------------------------------

locK_8FB90:
		movea.l	$3E(a0),a1
		jsr	(SetUp_ObjAttributes3).l
		bset	#3,shield_reaction(a0)
		move.l	#loc_86D5E,(a0)
		move.b	subtype(a0),d0
		lsr.b	#2,d0
		addq.b	#6,d0
		move.b	d0,mapping_frame(a0)
		jmp	(Sprite_CheckDeleteTouchXY).l
; ---------------------------------------------------------------------------

locK_8FBB8:
		jsr	(MoveSprite).l
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------
ObjDat_Iwamodoki:
		dc.l Map_Iwamodoki
		dc.w make_art_tile(ArtTile_Iwamodoki,0,0)
		dc.w   $280
		dc.b   $C,  $C,   0,   0
wordK_8FBD0:
		dc.w   $280
		dc.b    8,   4,   0, $98
ChildObjDat_8FBD6:
		dc.w 4-1
		dc.l locK_8FB90
		dc.l wordK_8FBD0
		dc.l byteK_8FC8B
		dc.l locK_8FBB8
		dc.b   -4,   4
		dc.w  -$400, -$200
		dc.l locK_8FB90
		dc.l wordK_8FBD0
		dc.l byteK_8FC8B
		dc.l locK_8FBB8
		dc.b    4,   4
		dc.w   $400, -$200
		dc.l locK_8FB90
		dc.l wordK_8FBD0
		dc.l byteK_8FC87
		dc.l locK_8FBB8
		dc.b   -8,  -8
		dc.w  -$200, -$400
		dc.l locK_8FB90
		dc.l wordK_8FBD0
		dc.l byteK_8FC87
		dc.l locK_8FBB8
		dc.b    8,  -8
		dc.w   $200, -$400
byteK_8FC30:
		dc.b    0,   7
		dc.b    1,   7
		dc.b    2,   7
		dc.b    3, $2F
		dc.b    4,   5
		dc.b    3,   5
		dc.b    4,   4
		dc.b    3,   4
		dc.b    4,   3
		dc.b    3,   3
		dc.b    4,   2
		dc.b    3,   2
		dc.b    4,   1
		dc.b    3,   1
		dc.b    4,   0
		dc.b    3,   0
		dc.b    4,   0
		dc.b    3,   0
		dc.b    4,   0
		dc.b    3,   0
		dc.b    4,   0
		dc.b    3,   0
		dc.b    4,   0
		dc.b    3,   0
		dc.b    4,   0
		dc.b    3,   0
		dc.b    4,   0
		dc.b    3,   0
		dc.b    4,   0
		dc.b    3,   0
		dc.b    4,   0
		dc.b    3,   0
		dc.b    4,   0
		dc.b    3,   0
		dc.b    4,   0
		dc.b    3,   0
		dc.b    4,   0
		dc.b    3,   0
		dc.b    4,   0
		dc.b    3,   0
		dc.b    4,   0
		dc.b    3,   0
		dc.b    5, $1F
		dc.b  $F4
byteK_8FC87:
		dc.b    0,   6,   8, $FC
byteK_8FC8B:
		dc.b    0,   7,   9, $FC
		even
Map_Iwamodoki:
		include "General/Sprites/Iwamodoki/Map - Iwamodoki.asm"