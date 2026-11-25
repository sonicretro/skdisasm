; ---------------------------------------------------------------------------

Slots_ScreenInit:
		move.w	#$7FF,(Screen_Y_wrap_value).w
		move.w	#$7F0,(Camera_Y_pos_mask).w
		move.w	#$3C,(Layout_row_index_mask).w
		rts
; ---------------------------------------------------------------------------

Slots_ScreenEvent:
		move.w	(Events_routine_fg).w,d0
		jmp	Slots_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

Slots_ScreenEvent_Index:
		bra.w	locK_597AA
; ---------------------------------------------------------------------------
		bra.w	locK_597E4
; ---------------------------------------------------------------------------

locK_597AA:
		addq.w	#4,(Events_routine_fg).w
		move.w	#$400,d1
		sub.w	(Events_bg+$00).w,d1
		add.w	(Camera_X_pos_copy).w,d1
		move.w	d1,(_unkEE98).w
		andi.w	#$FFF0,d1
		move.w	d1,(_unkEEA0).w
		move.w	#$400,d0
		sub.w	(Events_bg+$02).w,d0
		add.w	(Camera_Y_pos_copy).w,d0
		move.w	d0,(_unkEE9C).w
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(_unkEEA2).w
		jmp	(Refresh_PlaneDirect).l
; ---------------------------------------------------------------------------

locK_597E4:
		moveq	#$20,d1
		move.w	#$400,d0
		sub.w	(Events_bg+$00).w,d0
		add.w	(Camera_X_pos_copy).w,d0
		lea	(_unkEE98).w,a1
		bsr.s	subK_59832
		move.w	#$400,d0
		sub.w	(Events_bg+$02).w,d0
		add.w	(Camera_Y_pos_copy).w,d0
		lea	(_unkEE9C).w,a1
		bsr.s	subK_59832
		lea	(_unkEE98).w,a6
		lea	(_unkEEA0).w,a5
		move.w	(_unkEE9C).w,d1
		moveq	#$F,d6
		jsr	(Draw_TileColumn).l
		lea	(_unkEE9C).w,a6
		lea	(_unkEEA2).w,a5
		move.w	(_unkEE98).w,d1
		moveq	#$15,d6
		jmp	(Draw_TileRow).l

; =============== S U B R O U T I N E =======================================


subK_59832:
		sub.w	(a1),d0
		smi	d2
		bpl.s	locK_5983A
		neg.w	d0

locK_5983A:
		cmp.w	d1,d0
		bls.s	locK_59840
		move.w	d1,d0

locK_59840:
		tst.b	d2
		beq.s	locK_59846
		neg.w	d0

locK_59846:
		add.w	d0,(a1)
		rts
; End of function subK_59832

; ---------------------------------------------------------------------------

Slots_BackgroundInit:
		lea	(HScroll_table).w,a1
		moveq	#$80-1,d0

locK_59850:
		clr.l	(a1)+
		dbf	d0,locK_59850
		moveq	#0,d1
		moveq	#0,d0
		move.l	d0,(Camera_Y_pos_BG_copy).w
		jsr	(Refresh_PlaneFull).l
		jmp	locK_59990(pc)
; ---------------------------------------------------------------------------

Slots_BackgroundEvent:
		move.l	#$400,d0
		tst.w	(SStage_scalar_index_1).w
		bpl.s	locK_59876
		neg.l	d0

locK_59876:
		add.l	(Events_bg+$06).w,d0
		move.l	#$8000,d1
		cmp.l	d1,d0
		bgt.s	locK_5988A
		neg.l	d1
		cmp.l	d1,d0
		bge.s	locK_5988C

locK_5988A:
		move.l	d1,d0

locK_5988C:
		move.l	d0,(Events_bg+$06).w
		add.l	d0,(Camera_Y_pos_BG_copy).w
		andi.w	#$FF,(Camera_Y_pos_BG_copy).w
		lea	($FF1000).l,a0
		move.l	a0,(Plane_buffer_2_addr).w
		clr.w	(a0)
		clr.w	(Events_bg+$04).w
		lea	wordK_599DE(pc),a5
		lea	(HScroll_table+$020).w,a6
		moveq	#8-1,d6

locK_598B4:
		move.l	a5,-(sp)
		move.w	d6,-(sp)
		move.w	(a5),d0
		move.l	2(a5),d1
		add.l	d1,(a6)
		bcc.s	locK_598C6
		add.w	d0,(a6)
		bra.s	locK_598CE
; ---------------------------------------------------------------------------

locK_598C6:
		move.w	(a6),d1
		sub.w	d0,d1
		bcs.s	locK_598D2
		move.w	d1,(a6)

locK_598CE:
		st	$A(a6)

locK_598D2:
		move.w	$A(a5),d5
		beq.s	locK_598E0
		tst.w	(Events_bg+$04).w
		bne.w	locK_59962

locK_598E0:
		subq.w	#1,4(a6)
		bmi.s	locK_598EE
		tst.w	$A(a6)
		beq.s	locK_59962
		bra.s	locK_598F4
; ---------------------------------------------------------------------------

locK_598EE:
		move.w	6(a5),4(a6)

locK_598F4:
		move.w	6(a6),d0
		addq.w	#1,d0
		cmp.w	8(a5),d0
		blo.s	locK_59902
		moveq	#0,d0

locK_59902:
		move.w	d0,6(a6)
		clr.w	$A(a6)
		st	(Events_bg+$04).w
		tst.w	d5
		bne.s	locK_5991A
		move.w	(a5),d0
		add.w	d0,8(a6)
		bra.s	locK_59962
; ---------------------------------------------------------------------------

locK_5991A:
		btst	#0,7(a6)
		beq.s	locK_59926
		add.w	$C(a5),d5

locK_59926:
		moveq	#0,d1
		move.w	(a5),d2
		move.w	6(a6),d3
		subq.w	#1,d3
		bcs.s	locK_59938

locK_59932:
		add.w	d2,d1
		dbf	d3,locK_59932

locK_59938:
		move.w	$10(a5),d0
		move.w	$12(a5),d6
		movem.l	d1/d5-d6/a5,-(sp)
		jsr	(sub_4ECAA).l
		movem.l	(sp)+,d1/d5-d6/a5
		tst.w	$E(a5)
		beq.s	locK_59962
		addi.w	#$10,d0
		addi.w	#$100,d5
		jsr	(sub_4ECAA).l

locK_59962:
		move.w	(sp)+,d6
		movea.l	(sp)+,a5
		lea	$14(a5),a5
		lea	$C(a6),a6
		dbf	d6,locK_598B4
		lea	(HScroll_table).w,a1
		lea	(HScroll_table+$020).w,a5
		moveq	#8-1,d0

locK_5997C:
		move.w	(a5),d1
		add.w	8(a5),d1
		move.w	d1,(a1)+
		move.w	d1,$E(a1)
		lea	$C(a5),a5
		dbf	d0,locK_5997C

locK_59990:
		lea	Slots_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		lea	(H_scroll_buffer).w,a1
		move.w	(_unkEE98).w,d3
		move.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	#$E0-1,d1
		jsr	(ApplyDeformation2).l
		move.w	(_unkEE9C).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp
		rts
; ---------------------------------------------------------------------------

Slots_BGDeformArray:
		dc.w    $20,   $20,   $20,   $20,   $30,   $20,   $10,   $20
		dc.w    $20,   $20,   $20,   $20,   $30,   $20,   $10, $7FFF

wordK_599DE:
		dc.w    $48,     0, $C000,     8,     8, $E000, $FFFE,     1,     0,   $19
		dc.w    $48,     0, $C000,     9,     8, $E200, $FFFE,     1,   $20,   $19
		dc.w    $50,     0, $A000,    $B,   $10, $E400,     0,     1,   $40,   $19
		dc.w    $40,     0, $E000,     4,     8,     0,     0,     0,     0,     0
		dc.w    $40,     1,     0,     3,     8,     0,     0,     0,     0,     0
		dc.w    $48,     0, $C000,    $A,     8, $EB00, $FFFE,     1,   $B0,   $19
		dc.w    $58,     0, $8000,     7,     4, $ED00, $FFFE,     0,   $D0,   $19
		dc.w    $40,     0, $E000,     5,     8,     0,     0,     0,     0,     0