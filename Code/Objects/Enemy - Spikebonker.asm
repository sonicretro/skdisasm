; ---------------------------------------------------------------------------

Obj_Spikebonker:
		jsr	(Obj_WaitOffscreen).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Spikebonker_Index(pc,d0.w),d1
		jsr	Spikebonker_Index(pc,d1.w)
		jmp	(Sprite_CheckDeleteTouch).l
; ---------------------------------------------------------------------------
Spikebonker_Index:
		dc.w locK_91A0C-Spikebonker_Index
		dc.w locK_91A6A-Spikebonker_Index
		dc.w locK_91AC2-Spikebonker_Index
; ---------------------------------------------------------------------------

locK_91A0C:
		lea	ObjDat_Spikebonker(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.w	#-$80,d0
		btst	#0,render_flags(a0)
		beq.s	locK_91A24
		neg.w	d0

locK_91A24:
		move.w	d0,x_vel(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	d0,d1
		subq.w	#1,d0
		move.w	d0,$2E(a0)
		add.w	d1,d1
		subq.w	#1,d1
		move.w	d1,$3A(a0)
		move.l	#locK_91AB0,$34(a0)
		lea	ChildObjDat_91C2C(pc),a2
		jsr	(CreateChild1_Normal).l
		move.w	#$40,d0
		move.w	d0,$3E(a0)
		move.w	d0,y_vel(a0)
		move.w	#4,$40(a0)
		bclr	#0,$38(a0)
		rts
; ---------------------------------------------------------------------------

locK_91A6A:
		lea	(Player_1).w,a1
		jsr	(Find_OtherObject).l
		cmpi.w	#$60,d2
		bhs.s	locK_91A88
		btst	#0,render_flags(a0)
		beq.s	locK_91A84
		subq.w	#2,d0

locK_91A84:
		tst.w	d0
		beq.s	locK_91A9A

locK_91A88:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

locK_91A9A:
		move.b	#4,routine(a0)
		bset	#3,$38(a0)
		moveq	#signextendB(sfx_Bouncy),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

locK_91AB0:
		neg.w	x_vel(a0)
		bchg	#0,render_flags(a0)
		move.w	$3A(a0),$2E(a0)
		rts
; ---------------------------------------------------------------------------

locK_91AC2:
		btst	#3,$38(a0)
		bne.s	locretK_91AD0
		move.b	#2,routine(a0)

locretK_91AD0:
		rts
; ---------------------------------------------------------------------------

locK_91AD2:
		lea	wordK_91C26(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#locK_91AEC,(a0)
		lea	ChildObjDat_91C34(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

locK_91AEC:
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	$44(a0),a1
		move.b	$3C(a1),d0
		bne.s	locK_91B08
		movea.w	parent3(a0),a2
		btst	#3,$38(a2)
		bne.s	locK_91B14

locK_91B08:
		subq.b	#8,d0
		move.b	d0,$3C(a1)
		jmp	(Child_CheckParent).l
; ---------------------------------------------------------------------------

locK_91B14:
		move.l	#locK_91B3E,(a0)
		moveq	#-4,d0
		btst	#0,render_flags(a0)
		beq.s	locK_91B26
		neg.w	d0

locK_91B26:
		move.w	d0,x_vel(a0)
		move.w	#$1F,$2E(a0)
		move.l	#locK_91B68,$34(a0)
		jmp	(Child_CheckParent).l
; ---------------------------------------------------------------------------

locK_91B3E:
		move.w	x_pos(a0),d0
		add.w	x_vel(a0),d0
		move.w	d0,x_pos(a0)
		jsr	(Obj_Wait).l
		jmp	(Child_CheckParent).l
; ---------------------------------------------------------------------------

locK_91B56:
		move.l	#locK_91AEC,(a0)
		movea.w	parent3(a0),a1
		bclr	#3,$38(a1)
		rts
; ---------------------------------------------------------------------------

locK_91B68:
		move.l	#locK_91B70,(a0)
		rts
; ---------------------------------------------------------------------------

locK_91B70:
		movea.w	$44(a0),a1
		move.b	$3C(a1),d0
		cmpi.b	#$80,d0
		beq.s	locK_91B8A
		subq.b	#8,d0
		move.b	d0,$3C(a1)
		jmp	(Child_CheckParent).l
; ---------------------------------------------------------------------------

locK_91B8A:
		move.l	#locK_91B3E,(a0)
		neg.w	x_vel(a0)
		move.w	#$1F,$2E(a0)
		move.l	#locK_91B56,$34(a0)
		jmp	(Child_CheckParent).l
; ---------------------------------------------------------------------------

locK_91BA8:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	offK_91BBC(pc,d0.w),d1
		jsr	offK_91BBC(pc,d1.w)
		jmp	(Child_DrawTouch_Sprite).l
; ---------------------------------------------------------------------------
offK_91BBC:
		dc.w locK_91BC0-offK_91BBC
		dc.w locK_91BD4-offK_91BBC
; ---------------------------------------------------------------------------

locK_91BC0:
		lea	wordK_91C26(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		movea.w	parent3(a0),a1
		move.w	a0,$44(a1)
		rts
; ---------------------------------------------------------------------------

locK_91BD4:
		move.b	$3C(a0),d0
		bsr.w	subK_91BFA
		move.w	#$200,priority(a0)
		addi.b	#$40,d0
		bpl.s	locK_91BEE
		move.w	#$280,priority(a0)

locK_91BEE:
		lea	(AngleLookup_1).l,a1
		jmp	(MoveSprite_AngleXLookupOffset).l

; =============== S U B R O U T I N E =======================================


subK_91BFA:
		moveq	#0,d1

locK_91BFC:
		lea	byteK_91C0E(pc,d1.w),a1
		cmp.b	(a1)+,d0
		bls.s	locK_91C08
		addq.w	#2,d1
		bra.s	locK_91BFC
; ---------------------------------------------------------------------------

locK_91C08:
		move.b	(a1),mapping_frame(a0)
		rts
; End of function subK_91BFA

; ---------------------------------------------------------------------------
byteK_91C0E:
		dc.b    0,   1
		dc.b  $30,   1
		dc.b  $50,   2
		dc.b  $B0,   3
		dc.b  $D0,   2
		dc.b  $FF,   1
		even
ObjDat_Spikebonker:
		dc.l Map_Spikebonker
		dc.w make_art_tile(ArtTile_Spikebonker,1,1)
		dc.w   $280
		dc.b  $10, $14,   0, $1A
wordK_91C26:
		dc.w   $200
		dc.b  $10, $10,   1, $9A
ChildObjDat_91C2C:
		dc.w 1-1
		dc.l locK_91AD2
		dc.b    0, $14
ChildObjDat_91C34:
		dc.w 1-1
		dc.l locK_91BA8
		dc.b    0,   0