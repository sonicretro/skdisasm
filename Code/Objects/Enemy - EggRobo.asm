; ---------------------------------------------------------------------------

Obj_EggRobo:
		jsr	(Obj_WaitOffscreen).l
		bsr.w	subK_9185E
		movea.l	(a0),a1
		jmp	(a1)
; ---------------------------------------------------------------------------

locK_91526:
		move.b	$40(a0),d0
		subi.b	#3,d0
		cmpi.b	#4,d0
		blo.s	locK_91548
		cmp.b	$41(a0),d0
		beq.s	locK_91548
		move.b	d0,$40(a0)
		move.b	d0,$41(a0)
		jsr	(Perform_Art_Scaling).l

locK_91548:
		move.w	$3C(a0),d0
		subq.w	#1,d0
		move.w	d0,$3C(a0)
		add.w	d0,y_vel(a0)
		bpl.s	locK_9155E
		tst.b	render_flags(a0)
		bpl.s	locK_91570

locK_9155E:
		jsr	(subK_86180).l
		jsr	(subK_8619A).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_91570:
		move.b	subtype(a0),d0
		andi.w	#$F0,d0
		lsr.w	#4,d0
		move.w	(_unkFA82).w,d1
		bset	d0,d1
		move.w	d1,(_unkFA82).w
		lea	(ArtKosM_EggRoboBadnik).l,a1
		move.w	#tiles_to_bytes(ArtTile_EggRoboBadnik),d2
		jsr	(Queue_Kos_Module).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locK_9159A:
		bsr.w	subK_91988
		move.w	$30(a0),$32(a0)
		move.w	y_pos(a0),$30(a0)
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		lea	(Player_1).w,a1
		jsr	(Find_OtherObject).l
		jsr	(Change_FlipX).l
		cmpi.w	#8,d3
		bhi.s	locK_915D8
		move.l	#locK_915DE,(a0)
		bset	#1,$38(a0)

locK_915D8:
		jmp	(Sprite_CheckDeleteTouch).l
; ---------------------------------------------------------------------------

locK_915DE:
		bsr.w	subK_91988
		btst	#1,$38(a0)
		bne.s	locK_915F0
		move.l	#locK_9159A,(a0)

locK_915F0:
		jmp	(Sprite_CheckDeleteTouch).l
; ---------------------------------------------------------------------------

locK_915F6:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#$F,d0
		bne.s	locK_91648
		tst.b	render_flags(a0)
		bpl.s	locK_91648
		lea	ChildObjDat_919E6(pc),a2
		jsr	(CreateChild6_Simple).l
		subq.b	#1,$39(a0)
		bpl.s	locK_91648
		move.l	#locK_9164E,(a0)
		lea	ObjDat3_919A6(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bclr	#7,art_tile(a0)
		move.w	#-$300,d0
		btst	#0,render_flags(a0)
		beq.s	locK_9163A
		neg.w	d0

locK_9163A:
		move.w	d0,x_vel(a0)
		lea	ChildObjDat_919D0(pc),a2
		jsr	(CreateChild1_Normal).l

locK_91648:
		jmp	(Sprite_CheckDeleteTouch).l
; ---------------------------------------------------------------------------

locK_9164E:
		bsr.w	subK_91988
		addi.w	#-$10,y_vel(a0)
		jsr	(MoveSprite2).l
		move.w	y_vel(a0),d0
		cmpi.w	#-$200,d0
		bgt.s	locK_91678
		move.l	#locK_9167E,(a0)
		clr.w	x_vel(a0)
		bset	#7,art_tile(a0)

locK_91678:
		jmp	(Sprite_CheckDeleteTouch).l
; ---------------------------------------------------------------------------

locK_9167E:
		bsr.w	subK_91988
		addi.w	#$20,y_vel(a0)
		jsr	(MoveSprite2).l
		move.w	y_vel(a0),d0
		cmpi.w	#$100,d0
		blt.s	locK_916A2
		move.l	#locK_9159A,(a0)
		bsr.w	subK_918E2

locK_916A2:
		jmp	(Sprite_CheckDeleteTouch).l
; ---------------------------------------------------------------------------

locK_916A8:
		lea	wordK_919BE(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		movea.w	parent3(a0),a1
		btst	#2,render_flags(a1)
		bne.s	locK_916C4
		bclr	#2,render_flags(a0)

locK_916C4:
		move.l	#locK_916CC,(a0)
		rts
; ---------------------------------------------------------------------------

locK_916CC:
		jsr	(Refresh_ChildPositionAdjusted).l
		moveq	#6,d0
		move.w	y_vel(a1),d1
		bmi.s	locK_916E4
		moveq	#5,d0
		cmpi.w	#$20,d1
		blo.s	locK_916E4
		moveq	#4,d0

locK_916E4:
		move.b	d0,mapping_frame(a0)
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_916EE:
		lea	wordK_919C4(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		movea.w	parent3(a0),a1
		btst	#2,render_flags(a1)
		bne.s	locK_9170A
		bclr	#2,render_flags(a0)

locK_9170A:
		move.l	#locK_91712,(a0)
		rts
; ---------------------------------------------------------------------------

locK_91712:
		bsr.w	subK_91930
		btst	#1,$38(a1)
		beq.s	locK_91734
		move.l	#locK_9173A,(a0)
		move.w	#$5F,$2E(a0)
		lea	ChildObjDat_919DE(pc),a2
		jsr	(CreateChild10_NormalAdjusted).l

locK_91734:
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_9173A:
		subq.w	#1,$2E(a0)
		bpl.s	locK_91750
		move.l	#locK_91712,(a0)
		movea.w	parent3(a0),a1
		bclr	#1,$38(a1)

locK_91750:
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_91756:
		lea	wordK_919CA(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#locK_9176C,(a0)
		move.w	#$1F,$2E(a0)

locK_9176C:
		moveq	#0,d0
		btst	#0,(V_int_run_count+3).w
		beq.s	locK_91778
		moveq	#7,d0

locK_91778:
		move.b	d0,mapping_frame(a0)
		subq.w	#1,$2E(a0)
		bpl.s	locK_917AE
		move.l	#locK_917B4,(a0)
		move.b	#7,mapping_frame(a0)
		move.b	#$9C,collision_flags(a0)
		move.w	#-$800,d0
		btst	#0,render_flags(a0)
		beq.s	locK_917A2
		neg.w	d0

locK_917A2:
		move.w	d0,x_vel(a0)
		moveq	#signextendB(sfx_Laser),d0
		jsr	(Play_SFX).l

locK_917AE:
		jmp	(Child_DrawTouch_Sprite).l
; ---------------------------------------------------------------------------

locK_917B4:
		jsr	(MoveSprite2).l
		jmp	(Sprite_CheckDeleteTouch).l
; ---------------------------------------------------------------------------

locK_917C0:
		move.l	#Obj_Animal,(a0)
		addq.b	#2,routine(a0)
		jsr	(Random_Number).l
		move.w	#make_art_tile(ArtTile_Animals1,0,0),art_tile(a0)
		andi.w	#1,d0
		beq.s	locK_917E2
		move.w	#make_art_tile(ArtTile_Animals2,0,0),art_tile(a0)

locK_917E2:
		move.b	d0,$30(a0)
		lsl.w	#3,d0
		lea	(word_2C7EA).l,a1
		adda.w	d0,a1
		move.w	(a1)+,d1
		movea.w	parent3(a0),a2
		btst	#0,render_flags(a2)
		beq.s	locK_91800
		neg.w	d1

locK_91800:
		move.w	d1,x_vel(a0)
		move.w	(a1)+,$34(a0)
		move.l	(a1)+,mappings(a0)
		swap	d0
		andi.w	#$1FF,d0
		cmpi.w	#$100,d0
		bhs.s	locK_9181C
		move.w	#$100,d0

locK_9181C:
		neg.w	d0
		move.w	d0,y_vel(a0)
		move.b	#$C,y_radius(a0)
		move.b	#4,render_flags(a0)
		bset	#0,render_flags(a0)
		move.w	#$300,priority(a0)
		move.b	#8,width_pixels(a0)
		move.b	#7,anim_frame_timer(a0)
		move.b	#1,mapping_frame(a0)
		move.b	$30(a0),d0
		add.b	d0,d0
		addq.b	#4,d0
		move.b	d0,routine(a0)
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


subK_9185E:
		move.b	subtype(a0),d0
		andi.w	#$F,d0
		move.w	offK_9186E(pc,d0.w),d0
		jmp	offK_9186E(pc,d0.w)
; End of function subK_9185E

; ---------------------------------------------------------------------------
offK_9186E:
		dc.w locK_91874-offK_9186E
		dc.w locK_918C4-offK_9186E
		dc.w locK_918FC-offK_9186E
; ---------------------------------------------------------------------------

locK_91874:
		lea	ObjDat3_9199A(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#locK_91526,(a0)
		move.w	#-$6000,$3A(a0)
		move.w	#-$80,d0
		btst	#0,render_flags(a0)
		bne.s	locK_91898
		neg.w	d0

locK_91898:
		move.w	d0,x_vel(a0)
		move.w	x_pos(a0),$30(a0)
		move.w	y_pos(a0),$34(a0)
		move.b	#$7F,$40(a0)
		move.l	#ArtScaled_EggRoboFly,$42(a0)
		btst	#0,render_flags(a0)
		move.w	#$180,y_vel(a0)

locretK_918C2:
		rts
; ---------------------------------------------------------------------------

locK_918C4:
		bsr.w	subK_91914
		lea	ObjDat3_919A6(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#locK_9159A,(a0)
		lea	ChildObjDat_919D0(pc),a2
		jsr	(CreateChild1_Normal).l

; =============== S U B R O U T I N E =======================================


subK_918E2:
		move.w	#$100,d0
		move.w	d0,$3E(a0)
		move.w	d0,y_vel(a0)
		move.w	#8,$40(a0)
		bclr	#0,$38(a0)
		rts
; End of function subK_918E2

; ---------------------------------------------------------------------------

locK_918FC:
		lea	ObjDat3_919B2(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#locK_915F6,(a0)
		move.b	#4,$39(a0)
		rts

; =============== S U B R O U T I N E =======================================


subK_91914:
		move.b	subtype(a0),d0
		andi.w	#$F0,d0
		lsr.w	#4,d0
		move.w	(_unkFA82).w,d1
		btst	d0,d1
		bne.w	locretK_918C2
		addq.w	#8,sp
		jmp	(loc_85088).l
; End of function subK_91914


; =============== S U B R O U T I N E =======================================


subK_91930:
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),d0
		move.b	child_dx(a0),d1
		ext.w	d1
		bclr	#0,render_flags(a0)
		btst	#0,render_flags(a1)
		beq.s	locK_91954
		neg.w	d1
		bset	#0,render_flags(a0)

locK_91954:
		add.w	d1,d0
		move.w	d0,x_pos(a0)
		move.w	$32(a1),d0
		bne.s	locK_91964
		move.w	y_pos(a1),d0

locK_91964:
		move.b	child_dy(a0),d1
		ext.w	d1
		bclr	#1,render_flags(a0)
		btst	#1,render_flags(a1)
		beq.s	locK_91980
		neg.w	d1
		bset	#1,render_flags(a0)

locK_91980:
		add.w	d1,d0
		move.w	d0,y_pos(a0)
		rts
; End of function subK_91930


; =============== S U B R O U T I N E =======================================


subK_91988:
		moveq	#1,d0
		btst	#0,(V_int_run_count+3).w
		beq.s	locK_91994
		moveq	#3,d0

locK_91994:
		move.b	d0,mapping_frame(a0)
		rts
; End of function subK_91988

; ---------------------------------------------------------------------------
ObjDat3_9199A:
		dc.l Map_ScaledArt
		dc.w make_art_tile(ArtTile_EggRoboFlyScaled,1,1)
		dc.w   $280
		dc.b  $20, $20,   0,   0
ObjDat3_919A6:
		dc.l Map_EggRobo
		dc.w make_art_tile(ArtTile_EggRoboBadnik,0,1)
		dc.w   $280
		dc.b  $14, $18,   1,   6
ObjDat3_919B2:
		dc.l Map_EggRobo
		dc.w make_art_tile(ArtTile_EggRoboBadnik,0,1)
		dc.w   $280
		dc.b    4,   4,   0,   0
wordK_919BE:
		dc.w   $280
		dc.b   $C, $10,   6,   0
wordK_919C4:
		dc.w   $280
		dc.b  $10,  $C,   2,   0
wordK_919CA:
		dc.w   $280
		dc.b  $20,   4,   7,   0
ChildObjDat_919D0:
		dc.w 2-1
		dc.l locK_916A8
		dc.b  -$C, $1C
		dc.l locK_916EE
		dc.b -$1C,  -4
ChildObjDat_919DE:
		dc.w 1-1
		dc.l locK_91756
		dc.b   $B,  -4
ChildObjDat_919E6:
		dc.w 1-1
		dc.l locK_917C0