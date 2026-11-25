; ---------------------------------------------------------------------------

Obj_MonkeyDude:
		jsr	Obj_WaitOffscreen(pc)
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	MonkeyDude_Index(pc,d0.w),d1
		jsr	MonkeyDude_Index(pc,d1.w)
		jmp	Sprite_CheckDeleteTouch(pc)
; ---------------------------------------------------------------------------
MonkeyDude_Index:
		dc.w locK_87172-MonkeyDude_Index
		dc.w locK_871BC-MonkeyDude_Index
		dc.w locK_871DA-MonkeyDude_Index
; ---------------------------------------------------------------------------
; loc3_54F6E:
locK_87172:
		lea	ObjDat_MonkeyDude(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#2,d0
		move.b	d0,subtype(a0)
		lsr.w	#1,d0
		move.b	d0,$39(a0)
		move.l	#byteK_876B4,$30(a0)
		move.w	#60-1,$2E(a0)
		move.l	#locK_871C2,$34(a0)
		btst	#0,render_flags(a0)
		bne.w	locK_871B4
		lea	ChildObjDat_87680(pc),a2
		jmp	CreateChild4_LinkListRepeated(pc)
; ---------------------------------------------------------------------------
; loc3_54FB0:
locK_871B4:
		lea	ChildObjDat_87686(pc),a2
		jmp	CreateChild4_LinkListRepeated(pc)
; ---------------------------------------------------------------------------
; loc3_54FB8:
locK_871BC:
	if Sonic3_Alone
		jmp	(loc_53CD6).l
	else
		jmp	(loc_85652).l
	endif
; ---------------------------------------------------------------------------
; loc3_54FBE:
locK_871C2:
		move.b	#4,routine(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		move.l	#byteK_876B8,$30(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_54FD6:
locK_871DA:
		jsr	Animate_RawMultiDelay(pc)
		tst.w	d2
		beq.s	locretK_87202
		btst	#2,$38(a0)
		bne.s	locK_87204
		cmpi.b	#0,mapping_frame(a0)
		bne.s	locretK_87202
		addq.w	#8,y_pos(a0)
		subq.b	#1,$39(a0)
		cmpi.b	#1,$39(a0)
		beq.s	locK_87218
; locret3_54FFE:
locretK_87202:
		rts
; ---------------------------------------------------------------------------
; loc3_55000:
locK_87204:
		cmpi.b	#2,mapping_frame(a0)
		bne.s	locretK_87202
		subq.b	#1,$39(a0)
		beq.s	locK_87218
		subq.w	#8,y_pos(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_55014:
locK_87218:
		move.b	#2,routine(a0)
		move.b	subtype(a0),$39(a0)
		bchg	#2,$38(a0)
		move.w	#60-1,$2E(a0)
		move.l	#byteK_876B4,$30(a0)
		move.b	#0,mapping_frame(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_55044:
locK_87248:
		bset	#3,$38(a0)
; loc3_5504A:
locK_8724E:
		lea	wordK_87666(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		clr.b	routine(a0)
		move.b	subtype(a0),d0
		add.b	d0,d0
		move.b	d0,$3B(a0)
		move.b	d0,$3A(a0)
		tst.b	subtype(a0)
		bne.s	locK_87292
		move.l	#locK_872CC,(a0)
		moveq	#$E,d0
		btst	#3,$38(a0)
		bne.s	locK_87280
		neg.w	d0
; loc3_5507C:
locK_87280:
		add.w	d0,x_pos(a0)
		subq.w	#2,y_pos(a0)
		move.w	y_pos(a0),$3E(a0)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------
; loc3_5508E:
locK_87292:
		cmpi.b	#8,subtype(a0)
		beq.s	locK_872A4
		move.l	#locK_8741C,(a0)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------
; loc3_550A0:
locK_872A4:
		move.l	#locK_8744C,(a0)
		move.b	#6,mapping_frame(a0)
		movea.w	parent3(a0),a1
		movea.w	parent3(a1),a1
		move.w	a1,$3E(a0)
		movea.w	parent3(a1),a1
		movea.w	parent3(a1),a1
		move.w	a1,$44(a0)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------
; loc3_550C8:
locK_872CC:
		bsr.w	subK_87500
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	offK_872E2(pc,d0.w),d1
		jsr	offK_872E2(pc,d1.w)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------
; off3_550DE:
offK_872E2:
		dc.w locK_872EE-offK_872E2
		dc.w locK_8732A-offK_872E2
		dc.w locK_87382-offK_872E2
		dc.w locK_873B4-offK_872E2
		dc.w locK_873EA-offK_872E2
		dc.w locK_87330-offK_872E2
; ---------------------------------------------------------------------------
; loc3_550EA:
locK_872EE:
		move.b	$3C(a0),d0
		btst	#3,$38(a0)
		beq.s	locK_87308
		addq.b	#4,d0
		cmpi.b	#$80,d0
		bhs.s	locK_87316
		move.b	d0,$3C(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_55104:
locK_87308:
		subq.b	#4,d0
		cmpi.b	#$80,d0
		bls.s	locK_87316
		move.b	d0,$3C(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_55112:
locK_87316:
		move.b	#2,routine(a0)
; loc3_55118:
locK_8731C:
		bsr.w	subK_87638
		move.l	#locK_87370,$34(a0)
; locret3_55124:
locretK_87328:
		rts
; ---------------------------------------------------------------------------
; loc3_55126:
locK_8732A:
		bsr.w	subK_87524
		beq.s	locK_87374
; loc3_5512C:
locK_87330:
		btst	#3,$38(a0)
		beq.s	locK_8734E
		move.b	$41(a0),d1
		bsr.w	subK_87540
		subi.b	#$20,d0
		cmpi.b	#$60,d0
		bhs.s	locK_87360
		bra.w	locK_8736C
; ---------------------------------------------------------------------------
; loc3_5514A:
locK_8734E:
		move.b	$41(a0),d1
		bsr.w	subK_87540
		subi.b	#$80,d0
		cmpi.b	#$60,d0
		blo.s	locK_8736C
; loc3_5515C:
locK_87360:
		neg.w	$40(a0)
		move.b	$41(a0),d1
		bsr.w	subK_87540
; loc3_55168:
locK_8736C:
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------
; loc3_5516C:
locK_87370:
		bra.w	subK_87638
; ---------------------------------------------------------------------------
; loc3_55170:
locK_87374:
		move.b	#4,routine(a0)
		bset	#1,$38(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_5517E:
locK_87382:
		btst	#3,$38(a0)
		beq.s	locK_87398
		moveq	#4,d1
		bsr.w	subK_87540
		cmpi.b	#-$40,d0
		bhs.s	locK_873A6
		rts
; ---------------------------------------------------------------------------
; loc3_55194:
locK_87398:
		moveq	#-4,d1
		bsr.w	subK_87540
		cmpi.b	#$40,d0
		bls.s	locK_873A6
		rts
; ---------------------------------------------------------------------------
; loc3_551A2:
locK_873A6:
		move.b	#6,routine(a0)
		bset	#2,$38(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_551B0:
locK_873B4:
		btst	#3,$38(a0)
		beq.s	locK_873CA
		moveq	#-8,d1
		bsr.w	subK_87540
		moveq	#$60,d1
		cmp.b	d1,d0
		bls.s	locK_873D8
		rts
; ---------------------------------------------------------------------------
; loc3_551C6:
locK_873CA:
		moveq	#8,d1
		bsr.w	subK_87540
		moveq	#-$60,d1
		cmp.b	d1,d0
		bhs.s	locK_873D8
		rts
; ---------------------------------------------------------------------------
; loc3_551D4:
locK_873D8:
		move.b	#8,routine(a0)
		move.b	d1,$3C(a0)
		bclr	#1,$38(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_551E6:
locK_873EA:
		btst	#3,$38(a0)
		bne.s	locK_87400
		moveq	#-2,d1
		bsr.w	subK_87540
		moveq	#-$80,d1
		cmp.b	d1,d0
		bls.s	locK_8740E
		rts
; ---------------------------------------------------------------------------
; loc3_551FC:
locK_87400:
		moveq	#2,d1
		bsr.w	subK_87540
		moveq	#-$80,d1
		cmp.b	d1,d0
		bhs.s	locK_8740E
		rts
; ---------------------------------------------------------------------------
; loc3_5520A:
locK_8740E:
		move.b	#$A,routine(a0)
		move.b	d1,$3C(a0)
		bra.w	locK_8731C
; ---------------------------------------------------------------------------
; loc3_55218:
locK_8741C:
		bsr.w	subK_87518
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	offK_87432(pc,d0.w),d1
		jsr	offK_87432(pc,d1.w)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------
; off3_5522E:
offK_87432:
		dc.w locK_87438-offK_87432
		dc.w locK_87442-offK_87432
		dc.w locK_8743E-offK_87432
; ---------------------------------------------------------------------------
; loc3_55234:
locK_87438:
		moveq	#2,d1
		bsr.w	subK_8756A
; loc3_5523A:
locK_8743E:
		bra.w	locK_8754C
; ---------------------------------------------------------------------------
; loc3_5523E:
locK_87442:
		moveq	#4,d1
		bsr.w	subK_87592
		bra.w	locK_8754C
; ---------------------------------------------------------------------------
; loc3_55248:
locK_8744C:
		bsr.w	subK_87518
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	offK_87462(pc,d0.w),d1
		jsr	offK_87462(pc,d1.w)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------
; off3_5525E:
offK_87462:
		dc.w locK_87468-offK_87462
		dc.w locK_87472-offK_87462
		dc.w locK_8746E-offK_87462
; ---------------------------------------------------------------------------
; loc3_55264:
locK_87468:
		moveq	#2,d1
		bsr.w	subK_8756A
; loc3_5526A:
locK_8746E:
		bra.w	locK_8754C
; ---------------------------------------------------------------------------
; loc3_5526E:
locK_87472:
		bsr.w	subK_875B4
		moveq	#4,d1
		bsr.w	subK_87592
		bra.w	locK_8754C
; ---------------------------------------------------------------------------
; loc3_5527C:
locK_87480:
		lea	wordK_8766C(pc),a1
		jsr	SetUp_ObjAttributes2(pc)
		move.l	#locK_874B6,(a0)
		move.l	#byteK_876BD,$30(a0)
		move.l	#locK_874CA,$34(a0)
		move.b	#8,y_radius(a0)
		move.w	#-$200,x_vel(a0)
		move.w	#-$400,y_vel(a0)
		jmp	(Sprite_CheckDeleteTouch3).l
; ---------------------------------------------------------------------------
; loc3_552B2:
locK_874B6:
		jsr	(MoveSprite_LightGravity).l
		jsr	Animate_RawMultiDelay(pc)
		jsr	ObjHitFloor_DoRoutine(pc)
		jmp	(Sprite_CheckDeleteTouch3).l
; ---------------------------------------------------------------------------
; loc3_552C6:
locK_874CA:
		move.l	#locK_874D2,(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_552CE:
locK_874D2:
		jmp	(Sprite_CheckDeleteTouch3).l
; ---------------------------------------------------------------------------
		; unused
		movea.w	parent3(a0),a1
		move.b	render_flags(a1),d0
		btst	#3,$38(a0)
		beq.s	locK_874EC
		bchg	#0,d0
; loc3_552E8:
locK_874EC:
		move.w	#$200,priority(a0)
		btst	#0,d0
		beq.s	locretK_874FE
		move.w	#$300,priority(a0)
; locret3_552FA:
locretK_874FE:
		rts

; =============== S U B R O U T I N E =======================================

; sub3_552FC:
subK_87500:
		movea.w	parent3(a0),a1
		move.w	y_pos(a1),d0
		subq.w	#2,d0
		tst.b	mapping_frame(a1)
		beq.s	locK_87512
		subq.w	#2,d0
; loc3_5530E:
locK_87512:
		move.w	d0,y_pos(a0)
		rts
; End of function subK_87500


; =============== S U B R O U T I N E =======================================

; sub3_55314:
subK_87518:
		movea.w	parent3(a0),a1
		move.w	priority(a1),priority(a0)
		rts
; End of function subK_87518


; =============== S U B R O U T I N E =======================================

; sub3_55320:
subK_87524:
		jsr	Find_SonicTails(pc)
		cmpi.w	#$80,d2
		bhs.s	locK_8753C
		btst	#3,$38(a0)
		beq.s	locK_87538
		subq.w	#2,d0
; loc3_55334:
locK_87538:
		tst.w	d0
		rts
; ---------------------------------------------------------------------------
; loc3_55338:
locK_8753C:
		moveq	#1,d4
		rts
; End of function subK_87524


; =============== S U B R O U T I N E =======================================

; sub3_5533C:
subK_87540:
		move.b	$3C(a0),d0
		add.b	d1,d0
		move.b	d0,$3C(a0)
		rts
; End of function subK_87540

; ---------------------------------------------------------------------------
; loc3_55348:
locK_8754C:
		subq.b	#1,$3B(a0)
		bne.s	locK_87562
		move.b	$3A(a0),$3B(a0)
		movea.w	parent3(a0),a1
		move.b	$3C(a1),$3C(a0)
; loc3_5535E:
locK_87562:
		moveq	#5,d2
		jsr	MoveSprite_CircularSimple(pc)
		rts

; =============== S U B R O U T I N E =======================================

; sub3_55366:
subK_8756A:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		beq.s	locretK_87590
		move.b	d1,routine(a0)
		bset	#1,$38(a0)
		move.b	$3A(a0),d0
		lsr.b	#1,d0
		move.b	d0,$3A(a0)
		move.b	#1,$3B(a0)
; locret3_5538C:
locretK_87590:
		rts
; End of function subK_8756A


; =============== S U B R O U T I N E =======================================

; sub3_5538E:
subK_87592:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	locretK_875B2
		move.b	d1,routine(a0)
		move.b	$3A(a0),d0
		add.b	d0,d0
		move.b	d0,$3A(a0)
		move.b	#1,$3B(a0)
; locret3_553AE:
locretK_875B2:
		rts
; End of function subK_87592


; =============== S U B R O U T I N E =======================================

; sub3_553B0:
subK_875B4:
		btst	#3,$38(a0)
		beq.s	locK_875E0
		btst	#0,$38(a0)
		bne.w	locretK_87328
		movea.w	$44(a0),a1
		btst	#2,$38(a1)
		beq.s	locretK_875DE
		movea.w	$3E(a0),a1
		cmpi.b	#-$7C,$3C(a1)
		blo.s	locK_8760A
; locret3_553DA:
locretK_875DE:
		rts
; ---------------------------------------------------------------------------
; loc3_553DC:
locK_875E0:
		btst	#0,$38(a0)
		bne.w	locretK_87328
		movea.w	$44(a0),a1
		btst	#2,$38(a1)
		beq.s	locretK_875DE
		movea.w	$3E(a0),a1
		cmpi.b	#$7C,$3C(a1)
		blo.w	locretK_87328
		move.w	#make_art_tile(ArtTile_MonkeyDude,1,0),art_tile(a0)
; loc3_55406:
locK_8760A:
		bset	#0,$38(a0)
		move.b	#4,mapping_frame(a0)
		moveq	#signextendB(sfx_MissileThrow),d0
		jsr	(Play_SFX).l
		lea	(ChildObjDat_8769C).l,a2
		jsr	CreateChild2_Complex(pc)
		bne.s	locretK_875DE
		btst	#3,$38(a0)
		beq.s	locretK_875DE
		neg.w	x_vel(a1)
		rts
; End of function subK_875B4


; =============== S U B R O U T I N E =======================================

; sub3_55434:
subK_87638:
		jsr	(Random_Number).l
		move.w	(RNG_seed).w,d0
		moveq	#1,d1
		btst	#0,d0
		beq.s	locK_8764C
		neg.w	d1
; loc3_55448:
locK_8764C:
		move.w	d1,$40(a0)
		andi.w	#$3C,d0
		move.w	d0,$2E(a0)
		rts
; End of function subK_87638

; ---------------------------------------------------------------------------
ObjDat_MonkeyDude:
		dc.l Map_MonkeyDude
		dc.w make_art_tile(ArtTile_MonkeyDude,1,0)
		dc.w   $280
		dc.b  $20, $20,   0,  $B
; word3_55462:
wordK_87666:
		dc.w   $300
		dc.b    4,   4,   3,   0
; word3_55468:
wordK_8766C:
		dc.w make_art_tile(ArtTile_MonkeyDude,1,1)
		dc.w   $280
		dc.b  $20, $20,   6,  $B

ObjDat3_87674:
		dc.l Map_MonkeyDude
		dc.w make_art_tile(ArtTile_MonkeyDude,0,0)
		dc.w   $280
		dc.b  $20, $20,   6, $98

ChildObjDat_87680:
		dc.w 5-1
		dc.l locK_8724E

ChildObjDat_87686:
		dc.w 5-1
		dc.l locK_87248
		dc.w 1-1
		dc.l locK_8724E
		dc.b    0,   8
		dc.w 1-1
		dc.l locK_87480
		dc.b    0,   0

ChildObjDat_8769C:
		dc.w 1-1
	if Sonic3_Alone
		dc.l loc_54B46
	else
		dc.l loc_86D4A
	endif
		dc.l ObjDat3_87674
		dc.l 0
		dc.l MoveSprite_LightGravity
		dc.b    0,   0
		dc.w  -$200, -$400
; byte3_554B0:
byteK_876B4:
		dc.b    7,   0,   1, $FC
; byte3_554B4:
byteK_876B8:
		dc.b    0,   7
		dc.b    2,   7
		dc.b  $FC
; byte3_554B9:
byteK_876BD:
		dc.b    8,  $F
		dc.b    8,  $F
		dc.b    9,  $F
		dc.b   $A,  $F
		dc.b  $F8, .jump-byteK_876BD

.jump:
		dc.b    6, $7E
		dc.b  $FC
		even