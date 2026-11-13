; ---------------------------------------------------------------------------

Obj_Rhinobot:
		jsr	(Obj_WaitOffscreen).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Rhinobot_Index(pc,d0.w),d1
		jsr	Rhinobot_Index(pc,d1.w)
		lea	DPLCPtr_AIZRhinobot(pc),a2
		jsr	Perform_DPLC(pc)
		jmp	Sprite_CheckDeleteTouchSlotted(pc)
; ---------------------------------------------------------------------------
Rhinobot_Index:
		dc.w locK_86E7E-Rhinobot_Index
		dc.w locK_86EC4-Rhinobot_Index
		dc.w locK_86EEA-Rhinobot_Index
		dc.w locK_86EEE-Rhinobot_Index
; ---------------------------------------------------------------------------
; loc3_54C7A:
locK_86E7E:
		lea	ObjSlot_Rhinobot(pc),a1
		jsr	SetUp_ObjAttributesSlotted(pc)
		move.b	#8,x_radius(a0)
		move.b	#$10,y_radius(a0)
		move.w	#-$10,d0
		move.w	#-$300,d1
		btst	#0,render_flags(a0)
		beq.s	locK_86EB2
		neg.w	d0
		neg.w	d1
		bset	#3,$38(a0)
		bset	#2,$38(a0)
; loc3_54CAE:
locK_86EB2:
		move.w	d0,$40(a0)
		move.w	d1,$3E(a0)
		move.l	#locK_86F40,$34(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_54CC0:
locK_86EC4:
		lea	locK_86F92(pc),a3
		bsr.w	subK_870A4
		lea	locK_86F74(pc),a3
		bsr.w	subK_870CA
		move.w	$40(a0),d0
		add.w	d0,x_vel(a0)
		jsr	(MoveSprite2).l
		bsr.w	subK_86FF8
		bra.w	locK_8701C
; ---------------------------------------------------------------------------
; loc3_54CE6:
locK_86EEA:
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------
; loc3_54CEA:
locK_86EEE:
		lea	locK_86FE8(pc),a3
		bsr.w	subK_870CA
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------
; loc3_54CF8:
locK_86EFC:
		cmpi.w	#1,(Current_zone_and_act).w
		beq.s	locK_86F26
		jsr	Refresh_ChildPositionAdjusted(pc)
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	offK_86F22(pc,d0.w),d1
		jsr	offK_86F22(pc,d1.w)
		lea	DPLCPtr_AIZRhinobot(pc),a2
		jsr	Perform_DPLC(pc)
		jmp	Child_Remember_Draw_Sprite(pc)
; ---------------------------------------------------------------------------
; off3_54D1E:
offK_86F22:
		dc.w locK_86F2C-offK_86F22
		dc.w locK_86F3C-offK_86F22
; ---------------------------------------------------------------------------
; loc3_54D22:
locK_86F26:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
; loc3_54D28:
locK_86F2C:
		lea	ObjSlot_87110(pc),a1
		jsr	SetUp_ObjAttributesSlotted(pc)
		move.l	#Go_Delete_SpriteSlotted3,$34(a0)
; loc3_54D38:
locK_86F3C:
		jmp	Animate_Raw(pc)
; ---------------------------------------------------------------------------
; loc3_54D3C:
locK_86F40:
		bchg	#2,$38(a0)
		move.l	#locK_86F58,$34(a0)
		neg.w	$40(a0)
		neg.w	$3E(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_54D54:
locK_86F58:
		bchg	#3,$38(a0)
		bchg	#0,render_flags(a0)
		bclr	#1,$38(a0)
		move.l	#locK_86F40,$34(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_54D70:
locK_86F74:
		bclr	#2,$38(a0)
		btst	#3,$38(a0)
		bne.s	locK_86F88
		bset	#2,$38(a0)
; loc3_54D84:
locK_86F88:
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		bra.s	locK_86F58
; ---------------------------------------------------------------------------
; loc3_54D8E:
locK_86F92:
		move.b	#4,routine(a0)
		move.b	#0,mapping_frame(a0)
		move.w	#$20,$2E(a0)
		move.l	#locK_86FCE,$34(a0)
		bset	#1,$38(a0)
		moveq	#signextendB(sfx_Blast),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_8712A(pc),a2
		jsr	CreateChild1_Normal(pc)
		bne.s	locretK_86FCC
		move.l	#byteK_8714A,$30(a1)
; locret3_54DC8:
locretK_86FCC:
		rts
; ---------------------------------------------------------------------------
; loc3_54DCA:
locK_86FCE:
		move.b	#6,routine(a0)
		move.w	#$400,d0
		btst	#3,$38(a0)
		bne.s	locK_86FE2
		neg.w	d0
; loc3_54DDE:
locK_86FE2:
		move.w	d0,x_vel(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_54DE4:
locK_86FE8:
		move.b	#2,routine(a0)
		move.b	#0,mapping_frame(a0)
		bra.w	locK_86F74

; =============== S U B R O U T I N E =======================================

; sub3_54DF4:
subK_86FF8:
		move.w	x_vel(a0),d0
		beq.s	locK_87016
		btst	#2,$38(a0)
		beq.s	locK_8700E
		cmp.w	$3E(a0),d0
		bge.s	locK_87016
		rts
; ---------------------------------------------------------------------------
; loc3_54E0A:
locK_8700E:
		cmp.w	$3E(a0),d0
		ble.s	locK_87016
		rts
; ---------------------------------------------------------------------------
; loc3_54E12:
locK_87016:
		movea.l	$34(a0),a1
		jmp	(a1)
; End of function subK_86FF8

; ---------------------------------------------------------------------------
; loc3_54E18:
locK_8701C:
		moveq	#0,d1
		btst	#3,$38(a0)
		beq.s	locK_87054
		btst	#2,$38(a0)
		beq.s	locK_8703C
		cmpi.w	#$80,x_vel(a0)
		bgt.s	locK_8707E
		moveq	#1,d1
		bra.w	locK_8707E
; ---------------------------------------------------------------------------
; loc3_54E38:
locK_8703C:
		moveq	#1,d1
		cmpi.w	#$280,x_vel(a0)
		bgt.s	locK_8707E
		moveq	#2,d1
		bset	#1,$38(a0)
		beq.s	locK_87084
		bra.w	locK_8707E
; ---------------------------------------------------------------------------
; loc3_54E50:
locK_87054:
		btst	#2,$38(a0)
		bne.s	locK_8706A
		cmpi.w	#-$80,x_vel(a0)
		ble.s	locK_8707E
		moveq	#1,d1
		bra.w	locK_8707E
; ---------------------------------------------------------------------------
; loc3_54E66:
locK_8706A:
		moveq	#1,d1
		cmpi.w	#-$280,x_vel(a0)
		ble.s	locK_8707E
		moveq	#2,d1
		bset	#1,$38(a0)
		beq.s	locK_87084
; loc3_54E7A:
locK_8707E:
		move.b	d1,mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_54E80:
locK_87084:
		move.b	d1,mapping_frame(a0)
		moveq	#signextendB(sfx_Blast),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_87122(pc),a2
		jsr	CreateChild1_Normal(pc)
		bne.s	locretK_870A2
		move.l	#byteK_8713A,$30(a1)
; locret3_54E9E:
locretK_870A2:
		rts

; =============== S U B R O U T I N E =======================================

; sub3_54EA0:
subK_870A4:
		jsr	Find_SonicTails(pc)
		cmpi.w	#$20,d3
		bhi.s	locretK_870C2
		cmpi.w	#$60,d2
		bhi.s	locretK_870C2
		btst	#3,$38(a0)
		bne.s	locK_870BE
		subq.w	#2,d0
; loc3_54EBA:
locK_870BE:
		tst.w	d0
		bne.s	locK_870C4
; locret3_54EBE:
locretK_870C2:
		rts
; ---------------------------------------------------------------------------
; loc3_54EC0:
locK_870C4:
		jsr	(a3)
		addq.w	#4,sp
		rts
; End of function subK_870A4


; =============== S U B R O U T I N E =======================================

; sub3_54EC6:
subK_870CA:
		moveq	#4,d0
		btst	#3,$38(a0)
		bne.s	locK_870D6
		neg.w	d0
; loc3_54ED2:
locK_870D6:
		move.w	x_pos(a0),d3
		add.w	d0,d3
		move.l	a3,-(sp)
		jsr	(ObjCheckFloorDist2).l
		movea.l	(sp)+,a3
		cmpi.w	#-1,d1
		blt.s	locK_870F8
		cmpi.w	#$C,d1
		bge.s	locK_870F8
		add.w	d1,y_pos(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_54EF4:
locK_870F8:
		jsr	(a3)
		addq.w	#4,sp
		rts
; End of function subK_870CA

; ---------------------------------------------------------------------------
ObjSlot_Rhinobot:
		dc.w 2-1
		dc.w make_art_tile(ArtTile_Rhinobot,1,0)
		dc.w    $15,     0
		dc.l Map_Rhinobot
		dc.w   $280
		dc.b  $14, $10,   0,  $B
ObjSlot_87110:
		dc.w 2-1
		dc.w make_art_tile(ArtTile_Rhinobot-$B6,0,0)
		dc.w      6,     2
		dc.l Map_Rhinobot
		dc.w   $200
		dc.b   $C,   8,   4,   0
ChildObjDat_87122:
		dc.w 1-1
		dc.l locK_86EFC
		dc.b   $C,   8
ChildObjDat_8712A:
		dc.w 1-1
		dc.l locK_86EFC
		dc.b  $10,   8
DPLCPtr_AIZRhinobot:
		dc.l ArtUnc_AIZRhinobot
		dc.l DPLC_Rhinobot
; byte3_54F36:
byteK_8713A:
		dc.b    2,   4,   4,   5,   6,   7,   4,   5,   6,   7,   4,   5,   6,   7, $F4
		even
; byte3_54F46:
byteK_8714A:
		dc.b    2,   4,   4,   5,   6,   7,   4,   5,   6,   7, $F4
		even