; ---------------------------------------------------------------------------

Obj_Cluckoid:
		jsr	(Obj_WaitOffscreen).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Cluckoid_Index(pc,d0.w),d1
		jsr	Cluckoid_Index(pc,d1.w)
		lea	DPLCPtr_Cluckoid(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Sprite_CheckDeleteTouchSlotted).l
; ---------------------------------------------------------------------------
Cluckoid_Index:
		dc.w locK_8E1AA-Cluckoid_Index
		dc.w locK_8E1BE-Cluckoid_Index
		dc.w locK_8E1E2-Cluckoid_Index
		dc.w locK_8E21A-Cluckoid_Index
; ---------------------------------------------------------------------------

locK_8E1AA:
		lea	ObjSlot_Cluckoid(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		lea	ChildObjDat_8E402(pc),a2
		jmp	(CreateChild10_NormalAdjusted).l
; ---------------------------------------------------------------------------

locK_8E1BE:
		jsr	(Find_SonicTails).l
		cmpi.w	#$80,d2
		bhs.s	locretK_8E1D0
		cmpi.w	#$40,d3
		blo.s	locK_8E1D2

locretK_8E1D0:
		rts
; ---------------------------------------------------------------------------

locK_8E1D2:
		move.b	#4,routine(a0)
		move.l	#locK_8E20C,$34(a0)
		rts
; ---------------------------------------------------------------------------

locK_8E1E2:
		cmpi.b	#7,mapping_frame(a0)
		blo.s	locK_8E202
		bset	#7,$38(a0)
		bne.s	locK_8E1FA
		moveq	#signextendB(sfx_EnemyBreath),d0
		jsr	(Play_SFX).l

locK_8E1FA:
		bsr.w	subK_8E37C
		bsr.w	subK_8E2D4

locK_8E202:
		lea	byteK_8E418(pc),a1
		jmp	(Animate_RawNoSSTMultiDelay).l
; ---------------------------------------------------------------------------

locK_8E20C:
		move.b	#6,routine(a0)
		move.w	#$60,$2E(a0)
		rts
; ---------------------------------------------------------------------------

locK_8E21A:
		subq.w	#1,$2E(a0)
		bmi.s	locK_8E222
		rts
; ---------------------------------------------------------------------------

locK_8E222:
		move.b	#2,routine(a0)
		move.b	#0,mapping_frame(a0)
		bclr	#7,$38(a0)

locretK_8E234:
		rts
; ---------------------------------------------------------------------------

locK_8E236:
		lea	ObjDat3_8E3F6(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#locK_8E250,(a0)
		bsr.w	subK_8E2EA
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_8E250:
		tst.b	render_flags(a0)
		bpl.s	locK_8E2B8
		moveq	#0,d1
		move.w	x_vel(a0),d0
		add.w	$40(a0),d0
		cmpi.w	#-$80,d0
		blt.s	locK_8E274
		cmpi.w	#$80,d0
		bgt.s	locK_8E274
		bset	#0,d1
		bra.w	locK_8E278
; ---------------------------------------------------------------------------

locK_8E274:
		move.w	d0,x_vel(a0)

locK_8E278:
		move.w	y_vel(a0),d0
		addi.w	#8,d0
		bmi.s	locK_8E290
		cmpi.w	#$80,d0
		blt.s	locK_8E290
		bset	#1,d1
		bra.w	locK_8E294
; ---------------------------------------------------------------------------

locK_8E290:
		move.w	d0,y_vel(a0)

locK_8E294:
		cmpi.b	#3,d1
		bne.s	locK_8E2A6
		move.l	#loc_3DBE0,(a0)
		move.w	#2,$34(a0)

locK_8E2A6:
		jsr	(sub_3DC3A).l
		jsr	(MoveSprite2).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_8E2B8:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locK_8E2BE:
		lea	ObjDat3_8E3EA(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#locK_8E2CE,(a0)

locK_8E2CE:
		jmp	(Child_Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


subK_8E2D4:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#7,d0
		bne.w	locretK_8E234
		lea	ChildObjDat_8E40A(pc),a2
		jmp	(CreateChild6_Simple).l
; End of function subK_8E2D4


; =============== S U B R O U T I N E =======================================


subK_8E2EA:
		jsr	(Random_Number).l
		movea.w	parent3(a0),a1
		move.w	d0,d1
		moveq	#0,d2
		move.b	subtype(a1),d2
		lsl.w	#5,d2
		lea	wordK_8E438(pc),a2
		adda.w	d2,a2
		andi.w	#$1C,d1
		adda.w	d1,a2
		move.w	(a2)+,d2
		move.w	(a2)+,d3
		beq.s	locK_8E35C
		andi.w	#6,d0
		move.w	wordK_8E364(pc,d0.w),d0
		move.w	#-$20,d4
		btst	#0,render_flags(a1)
		bne.s	locK_8E330
		bset	#0,render_flags(a0)
		neg.w	d0
		neg.w	d2
		neg.w	d4

locK_8E330:
		move.w	d0,x_vel(a0)
		add.w	d2,x_pos(a0)
		add.w	d3,y_pos(a0)
		move.w	d4,$40(a0)
		swap	d0
		moveq	#0,d2
		tst.w	d0
		bpl.s	locK_8E34A
		moveq	#4,d2

locK_8E34A:
		andi.w	#6,d0
		move.w	wordK_8E36C(pc,d0.w),y_vel(a0)
		move.l	offK_8E374(pc,d2.w),mappings(a0)
		rts
; ---------------------------------------------------------------------------

locK_8E35C:
		addq.w	#4,sp
		jmp	(Delete_Current_Sprite).l
; End of function subK_8E2EA

; ---------------------------------------------------------------------------
wordK_8E364:
		dc.w   $600,  $700,  $800,  $900
wordK_8E36C:
		dc.w  -$180, -$200, -$280, -$300
offK_8E374:
		dc.l Map_MHZPollen
		dc.l Map_MHZBigLeaves

; =============== S U B R O U T I N E =======================================


subK_8E37C:
		lea	(Player_1).w,a1
		bsr.w	subK_8E388
		lea	(Player_2).w,a1
; End of function subK_8E37C


; =============== S U B R O U T I N E =======================================


subK_8E388:
		cmpi.b	#8,anim(a1)
		beq.s	locretK_8E3D6
		tst.b	spin_dash_flag(a1)
		bne.s	locretK_8E3D6
		tst.b	object_control(a1)
		bne.s	locretK_8E3D6
		jsr	(Find_OtherObject).l
		cmpi.w	#$100,d2
		bhs.s	locretK_8E3D6
		cmpi.w	#$40,d3
		bhs.s	locretK_8E3D6
		move.w	d0,d4
		btst	#0,render_flags(a0)
		bne.s	locK_8E3BA
		subq.w	#2,d4

locK_8E3BA:
		tst.w	d4
		beq.s	locretK_8E3D6
		lsr.w	#4,d2
		andi.w	#$F,d2
		subi.w	#$F,d2
		neg.w	d2
		addq.w	#1,d2
		tst.w	d0
		bne.s	locK_8E3D2
		neg.w	d2

locK_8E3D2:
		add.w	d2,x_pos(a1)

locretK_8E3D6:
		rts
; End of function subK_8E388

; ---------------------------------------------------------------------------
ObjSlot_Cluckoid:
		dc.w 2-1
		dc.w make_art_tile(ArtTile_Cluckoid,1,1)
		dc.w    $11,     2
		dc.l Map_Cluckoid
		dc.w   $280
		dc.b  $14, $10,   0, $1A
ObjDat3_8E3EA:
		dc.l Map_CluckoidArrow
		dc.w make_art_tile(ArtTile_Cluckoid+$22,1,1)
		dc.w   $280
		dc.b  $10,  $C,   0,   0
ObjDat3_8E3F6:
		dc.l Map_MHZPollen
		dc.w make_art_tile(ArtTile_MHZMisc+$1C,3,1)
		dc.w      0
		dc.b    8,   8,   0,   0
ChildObjDat_8E402:
		dc.w 1-1
		dc.l locK_8E2BE
		dc.b    0, $1C
ChildObjDat_8E40A:
		dc.w 1-1
		dc.l locK_8E236
DPLCPtr_Cluckoid:
		dc.l ArtUnc_Cluckoid
		dc.l DPLC_Cluckoid
byteK_8E418:
		dc.b    0,   7
		dc.b    1,   7
		dc.b    2,   7
		dc.b    3,   7
		dc.b    4, $2F
		dc.b    5,   2
		dc.b    6,   2
		dc.b    7,   2
		dc.b    8,   2
		dc.b    9,   7
		dc.b   $A,   7
		dc.b   $B,   7
		dc.b   $C,   7
		dc.b   $D, $1F
		dc.b    0,  $F
		dc.b  $F4
		even
wordK_8E438:
		dc.w    $10,   $28
		dc.w    $20,   $28
		dc.w    $30,   $28
		dc.w    $40,   $28
		dc.w    $50,   $28
		dc.w    $60,   $28
		dc.w    $70,   $28
		dc.w    $80,   $28
		dc.w    $10,   $28
		dc.w    $18,   $28
		dc.w    $30,   $48
		dc.w    $40,   $48
		dc.w    $50,   $48
		dc.w    $60,   $48
		dc.w    $70,   $48
		dc.w    $80,   $48
		dc.w    $10,   $28
		dc.w    $14,   $28
		dc.w    $18,   $28
		dc.w    $1C,   $28
		dc.w    $20,   $28
		dc.w      0,     0
		dc.w      0,     0
		dc.w      0,     0
		dc.w    $10,   $28
		dc.w    $18,   $28
		dc.w    $20,   $28
		dc.w    $30,   $48
		dc.w    $40,   $48
		dc.w    $50,   $48
		dc.w    $60,   $48
		dc.w    $80,   $68
DPLC_Cluckoid:
		include "General/Sprites/Cluckoid/DPLC - Cluckoid.asm"
Map_CluckoidArrow:
		include "General/Sprites/Cluckoid/Map - Cluckoid Arrow.asm"
Map_Cluckoid:
		include "General/Sprites/Cluckoid/Map - Cluckoid.asm"