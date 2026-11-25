; ---------------------------------------------------------------------------

Obj_Butterdroid:
		jsr	(Obj_WaitOffscreen).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Butterdroid_Index(pc,d0.w),d1
		jsr	Butterdroid_Index(pc,d1.w)
		lea	DPLCPtr_Butterdroid(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Sprite_CheckDeleteTouchSlotted).l
; ---------------------------------------------------------------------------
Butterdroid_Index:
		dc.w locK_8E0C6-Butterdroid_Index
		dc.w locK_8E0DA-Butterdroid_Index
; ---------------------------------------------------------------------------

locK_8E0C6:
		lea	ObjSlot_Butterdroid(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		move.l	#AniRaw_Butterdroid,$30(a0)
		rts
; ---------------------------------------------------------------------------

locK_8E0DA:
		jsr	(Find_SonicTails).l
		bclr	#0,render_flags(a0)
		tst.w	d0
		beq.s	locK_8E0F0
		bset	#0,render_flags(a0)

locK_8E0F0:
		move.w	#$100,d0
		move.w	#4,d1
		jsr	(Chase_Object).l
		jsr	(MoveSprite2).l
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------
ObjSlot_Butterdroid:
		dc.w 4-1
		dc.w make_art_tile(ArtTile_Butterdroid,1,1)
		dc.w      9,     0
		dc.l Map_Butterdroid
		dc.w   $280
		dc.b   $C,  $C,   0, $17
DPLCPtr_Butterdroid:
		dc.l ArtUnc_Butterdroid
		dc.l DPLC_Butterdroid
AniRaw_Butterdroid:
		dc.b    7,   0,   1,   2,   3,   4,   3,   2,   1, $FC
		even
Map_Butterdroid:
		include "General/Sprites/Butterdroid/Map - Butterdroid.asm"
DPLC_Butterdroid:
		include "General/Sprites/Butterdroid/DPLC - Butterdroid.asm"