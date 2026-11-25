; ---------------------------------------------------------------------------

LRZ3_ScreenInit:
		clr.w	(Camera_max_X_pos).w
		lea	(Player_1).w,a1
		cmpi.w	#$480,x_pos(a1)
		blo.s	locK_59AF8
		lea	(Target_palette_line_2).w,a1
		lea	(Pal_LRZBossFire).l,a5
		moveq	#bytesToLcnt($60),d0

locK_59A9A:
		move.l	(a5)+,(a1)+
		dbf	d0,locK_59A9A

.offset :=	Stack_contents-(Target_palette_line_4+$20)
		move.w	#$9C0,.offset+$10(a1)
		move.w	#$36C,.offset+$14(a1)
		move.w	#$920,d0
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d0,(Camera_X_pos).w
		clr.w	(Camera_X_pos+2).w
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w
		move.w	#$2F0,d0
		move.w	d0,(Camera_Y_pos_copy).w
		move.w	d0,(Camera_Y_pos).w
		clr.w	(Camera_Y_pos+2).w
		move.w	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		move.w	#$14,(Special_events_routine).w
		move.w	#$10,(Events_bg+$00).w
		move.w	#$2D,(Events_bg+$02).w
		move.w	#$C,(Events_routine_fg).w

locK_59AF8:
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

LRZ3_ScreenEvent:
		move.w	(Events_routine_fg).w,d0
		jmp	LRZ3_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

LRZ3_ScreenEvent_Index:
		bra.w	locK_59B1C
; ---------------------------------------------------------------------------
		bra.w	locK_59B46
; ---------------------------------------------------------------------------
		bra.w	locK_59B88
; ---------------------------------------------------------------------------
		bra.w	locK_59BA4
; ---------------------------------------------------------------------------

locK_59B1C:
		move.w	(Act3_ring_count).w,d0
		beq.s	locK_59B30
		clr.w	(Act3_ring_count).w
		move.w	d0,(Ring_count).w
		move.b	#1,(Update_HUD_ring_count).w

locK_59B30:
		move.l	(Act3_timer).w,d0
		beq.s	locK_59B42
		clr.l	(Act3_timer).w
		move.l	d0,(Timer).w
		st	(Update_HUD_timer).w

locK_59B42:
		addq.w	#4,(Events_routine_fg).w

locK_59B46:
		move.b	#1,(Update_HUD_life_count).w
		tst.w	(Events_fg_4).w
		beq.s	locK_59B78
		clr.w	(Events_fg_4).w
		movea.w	$24(a3),a1
		move.b	#$16,(a1)+
		move.b	#$15,(a1)+
		move.b	#$16,(a1)+
		move.b	#$15,(a1)+
		move.b	#$16,(a1)
		addq.w	#4,(Events_routine_fg).w
		jmp	(Refresh_PlaneScreenDirect).l
; ---------------------------------------------------------------------------

locK_59B78:
		move.w	(Camera_Y_pos).w,d0
		cmp.w	(Camera_max_Y_pos).w,d0
		bne.s	locK_59BA4
		move.w	d0,(Camera_min_Y_pos).w
		bra.s	locK_59BA4
; ---------------------------------------------------------------------------

locK_59B88:
		tst.w	(Events_fg_4).w
		beq.s	locK_59BA4
		clr.w	(Events_fg_4).w
		clr.w	(Camera_X_pos+2).w
		clr.w	(Camera_Y_pos+2).w
		move.w	#$14,(Special_events_routine).w
		addq.w	#4,(Events_routine_fg).w

locK_59BA4:
		move.w	(Events_bg+$0C).w,d1
		beq.s	locK_59BF4
		move.w	d1,d3
		lsr.w	#7,d3
		move.w	(Events_bg+$0E).w,d0
		move.w	d0,d2
		lsr.w	#5,d2
		andi.w	#$FFFC,d2
		movea.w	(a3,d2.w),a1
		move.b	#$17,(a1,d3.w)
		move.b	#$17,1(a1,d3.w)
		moveq	#-$80,d2
		and.w	d2,d0
		and.w	d2,d1
		moveq	#$30,d2
		add.w	d2,d0
		add.w	d2,d1
		moveq	#$A,d6
		moveq	#5-1,d2

locK_59BDA:
		movem.w	d0-d2/d6,-(sp)
		jsr	(Setup_TileRowDraw).l
		movem.w	(sp)+,d0-d2/d6
		addi.w	#$10,d0
		dbf	d2,locK_59BDA
		clr.w	(Events_bg+$0C).w

locK_59BF4:
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

LRZ3_BackgroundInit:
		jsr	(AllocateObject).l
		bne.s	locK_59C08
		move.l	#Obj_59FC4,(a1)

locK_59C08:
		lea	(HScroll_table).w,a1
		move.l	#$600050,d0
		moveq	#$14-1,d1

locK_59C14:
		move.l	d0,(a1)+
		dbf	d1,locK_59C14
		lea	(HScroll_table+$100).w,a1
		move.l	#$30303030,d0
		moveq	#$30-1,d1

locK_59C26:
		move.l	d0,(a1)+
		dbf	d1,locK_59C26
		move.w	(a3),$7C(a3)
		jsr	subK_59D82(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		jmp	subK_59DDE(pc)
; ---------------------------------------------------------------------------

LRZ3_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	LRZ3_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

LRZ3_BackgroundEvent_Index:
		bra.w	locK_59C60
; ---------------------------------------------------------------------------
		bra.w	locK_59C8C
; ---------------------------------------------------------------------------
		bra.w	locK_59D02
; ---------------------------------------------------------------------------
		bra.w	locK_59D24
; ---------------------------------------------------------------------------
		bra.w	locK_59D74
; ---------------------------------------------------------------------------

locK_59C60:
		cmpi.w	#$500,(Camera_Y_pos).w
		blo.s	locK_59C6E
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_59C8C
; ---------------------------------------------------------------------------

locK_59C6E:
		jsr	subK_59D82(pc)

locK_59C72:
		jsr	(DrawBGAsYouMove).l
		move.w	(Events_bg+$04).w,d0
		beq.s	locK_59C88
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	(Events_bg+$06).w,(Camera_Y_pos_BG_copy).w

locK_59C88:
		jmp	subK_59DDE(pc)
; ---------------------------------------------------------------------------

locK_59C8C:
		cmpi.w	#$500,(Camera_Y_pos).w
		blo.s	locK_59CD8
		cmpi.w	#$A00,(Camera_X_pos).w
		bne.s	locK_59CCA
		move.w	(Camera_Y_pos).w,d0
		cmp.w	(Camera_max_Y_pos).w,d0
		bne.s	locK_59CCA
		move.w	#$A00,(Camera_max_X_pos).w
		move.w	d0,(Camera_min_Y_pos).w
		jsr	(AllocateObject).l
		bne.s	locK_59CBE
		move.l	#Obj_LRZEndBoss,(a1)

locK_59CBE:
		move.w	#4,(Special_V_int_routine).w
		addq.w	#8,(Events_routine_bg).w
		bra.s	locK_59D24
; ---------------------------------------------------------------------------

locK_59CCA:
		jsr	subK_59DA2(pc)
		jsr	(DrawBGAsYouMove).l
		jmp	subK_59DDE(pc)
; ---------------------------------------------------------------------------

locK_59CD8:
		move.w	(Camera_X_pos_BG_copy).w,(Events_bg+$04).w
		move.w	(Camera_Y_pos_BG_copy).w,(Events_bg+$06).w
		jsr	subK_59D82(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_59D06
; ---------------------------------------------------------------------------

locK_59D02:
		jsr	subK_59D82(pc)

locK_59D06:
		move.w	(Camera_X_pos_BG_copy).w,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	(Draw_PlaneVertTopDown).l
		bpl.w	locK_59C72
		clr.w	(Events_bg+$04).w
		clr.w	(Events_routine_bg).w
		bra.w	locK_59C72
; ---------------------------------------------------------------------------

locK_59D24:
		tst.w	(Events_fg_5).w
		beq.s	locK_59D30
		tst.w	(Events_bg+$0A).w
		beq.s	locK_59D66

locK_59D30:
		jsr	subK_59DBC(pc)
		lea	wordK_5A106(pc),a4
		lea	(HScroll_table).w,a5
		moveq	#$F,d6
		moveq	#$14,d5
		jsr	(DrawTilesVDeform2).l
		jsr	subK_59DDE(pc)
		lea	(Vscroll_buffer).w,a1
		lea	(HScroll_table).w,a5
		move.w	(Camera_Y_pos_copy).w,d0
		swap	d0
		moveq	#$14-1,d1

locK_59D5A:
		move.w	(a5),d0
		move.l	d0,(a1)+
		addq.w	#4,a5
		dbf	d1,locK_59D5A
		rts
; ---------------------------------------------------------------------------

locK_59D66:
		clr.w	(Events_fg_5).w
		move.w	#$C,(Special_V_int_routine).w
		addq.w	#4,(Events_routine_bg).w

locK_59D74:
		jsr	subK_59DA2(pc)
		jsr	(DrawBGAsYouMove).l
		jmp	subK_59DDE(pc)

; =============== S U B R O U T I N E =======================================


subK_59D82:
		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#4,d0
		addi.w	#$10,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		asr.w	#4,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		asr.w	#1,d0
		move.w	d0,(Events_bg+$12).w
		rts
; End of function subK_59D82


; =============== S U B R O U T I N E =======================================


subK_59DA2:
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$700,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$500,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		rts
; End of function subK_59DA2


; =============== S U B R O U T I N E =======================================


subK_59DBC:
		bsr.s	subK_59DA2
		lea	(HScroll_table).w,a1
		lea	$113(a1),a5
		moveq	#$30,d1
		moveq	#$14-1,d2

locK_59DCA:
		moveq	#0,d3
		move.b	(a5),d3
		sub.w	d1,d3
		add.w	d0,d3
		move.w	d3,(a1)
		addq.w	#4,a1
		addq.w	#8,a5
		dbf	d2,locK_59DCA
		rts
; End of function subK_59DBC


; =============== S U B R O U T I N E =======================================


subK_59DDE:
		tst.b	(End_of_level_flag).w
		bne.s	locK_59DF2
		tst.b	(_unkFACD).w
		bne.s	locK_59DF2
		cmpi.w	#8,(Events_routine_fg).w
		bhs.s	locK_59DF8

locK_59DF2:
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

locK_59DF8:
		lea	(H_scroll_buffer).w,a1
		lea	(AIZ2_SOZ1_LRZ3_FGDeformDelta).l,a5
		lea	(a5),a6
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Level_frame_counter).w,d1
		add.w	d1,d1
		add.w	d1,d0
		andi.w	#$3E,d0
		adda.w	d0,a5
		move.w	(Camera_Y_pos_BG_copy).w,d0
		asr.w	#1,d1
		add.w	d1,d0
		andi.w	#$3E,d0
		adda.w	d0,a6
		move.w	(Camera_X_pos_copy).w,d0
		neg.w	d0
		move.w	(Camera_X_pos_BG_copy).w,d1
		neg.w	d1
		move.w	#$E0-1,d2

locK_59E34:
		move.w	(a5)+,d3
		add.w	d0,d3
		move.w	d3,(a1)+
		move.w	(a6)+,d3
		add.w	d1,d3
		move.w	d3,(a1)+
		dbf	d2,locK_59E34
		rts
; End of function subK_59DDE

; ---------------------------------------------------------------------------

locK_59E46:
		tst.w	(Events_bg+$02).w
		beq.s	locK_59E52
		subq.w	#1,(Events_bg+$02).w
		rts
; ---------------------------------------------------------------------------

locK_59E52:
		st	(Scroll_lock).w
		move.w	(Events_bg+$00).w,d0
		jmp	locK_59E5E(pc,d0.w)
; ---------------------------------------------------------------------------

locK_59E5E:
		bra.w	locK_59E7A
; ---------------------------------------------------------------------------
		bra.w	locK_59E90
; ---------------------------------------------------------------------------
		bra.w	locK_59EA8
; ---------------------------------------------------------------------------
		bra.w	locK_59EBE
; ---------------------------------------------------------------------------
		bra.w	locK_59ED4
; ---------------------------------------------------------------------------
		bra.w	locK_59EE8
; ---------------------------------------------------------------------------
		bra.w	locK_59F00
; ---------------------------------------------------------------------------

locK_59E7A:
		move.l	#$20000,d2
		moveq	#0,d1
		cmpi.w	#$410,(Camera_X_pos).w
		blo.w	locK_59F3C
		addq.w	#4,(Events_bg+$00).w

locK_59E90:
		move.l	#$16A00,d2
		move.l	d2,d1
		neg.l	d1
		cmpi.w	#$330,(Camera_Y_pos).w
		bhi.w	locK_59F3C
		addq.w	#4,(Events_bg+$00).w

locK_59EA8:
		move.l	#$20000,d2
		moveq	#0,d1
		cmpi.w	#$650,(Camera_X_pos).w
		blo.w	locK_59F3C
		addq.w	#4,(Events_bg+$00).w

locK_59EBE:
		move.l	#$16A00,d2
		move.l	d2,d1
		neg.l	d1
		cmpi.w	#$2F0,(Camera_Y_pos).w
		bhi.s	locK_59F3C
		addq.w	#4,(Events_bg+$00).w

locK_59ED4:
		move.l	#$20000,d2
		moveq	#0,d1
		cmpi.w	#$910,(Camera_X_pos).w
		blo.s	locK_59F3C
		addq.w	#4,(Events_bg+$00).w

locK_59EE8:
		move.l	#$1D900,d2
		move.l	#$C400,d1
		cmpi.w	#$320,(Camera_Y_pos).w
		blo.s	locK_59F3C
		addq.w	#4,(Events_bg+$00).w

locK_59F00:
		move.l	#$20000,d2
		moveq	#0,d1
		cmpi.w	#$BBF,(Camera_X_pos).w
		blo.s	locK_59F3C
		moveq	#0,d2
		cmpi.w	#$C50,(Player_1+x_pos).w
		blo.s	locK_59F3C
		move.w	#$A00,(Camera_min_X_pos).w
		move.w	#$BC0,(Camera_max_X_pos).w
		move.w	#$560,d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		clr.b	(Scroll_lock).w
		clr.w	(Special_events_routine).w
		rts
; ---------------------------------------------------------------------------

locK_59F3C:
		add.l	d1,(Camera_Y_pos).w
		move.w	(Camera_Y_pos).w,d1
		move.w	d1,(Camera_Y_pos).w
		move.w	d1,(Camera_Y_pos_copy).w
		move.w	d1,(Camera_min_Y_pos).w
		move.w	d1,(Camera_max_Y_pos).w
		move.w	d1,(Camera_target_max_Y_pos).w
		add.l	d2,(Camera_X_pos).w
		move.w	(Camera_X_pos).w,d0
		move.w	d0,(Camera_X_pos).w
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w
		movem.w	d0/d2,-(sp)
		lea	(Player_1).w,a1
		bsr.s	subK_59F82
		movem.w	(sp)+,d0/d2
		lea	(Player_2).w,a1

; =============== S U B R O U T I N E =======================================


subK_59F82:
		cmpi.b	#5,anim(a1)
		bne.s	locK_59F8E
		clr.b	anim(a1)

locK_59F8E:
		addi.w	#$10,d0
		cmp.w	x_pos(a1),d0
		bls.s	locK_59FB4
		btst	#Status_Push,status(a1)
		beq.s	locK_59FA8
		lea	(a1),a0
		jmp	(Kill_Character).l
; ---------------------------------------------------------------------------

locK_59FA8:
		move.w	d0,x_pos(a1)
		asr.l	#8,d2
		move.w	d2,ground_vel(a1)
		bra.s	locretK_59FC2
; ---------------------------------------------------------------------------

locK_59FB4:
		addi.w	#$110,d0
		cmp.w	x_pos(a1),d0
		bhi.s	locretK_59FC2
		move.w	d0,x_pos(a1)

locretK_59FC2:
		rts
; End of function subK_59F82

; ---------------------------------------------------------------------------

Obj_59FC4:
		move.l	#locK_59FDC,(a0)
		move.b	#$C0,height_pixels(a0)
		move.w	#$640,y_pos(a0)
		bset	#7,status(a0)

locK_59FDC:
		cmpi.w	#$C,(Events_routine_bg).w
		bne.w	locK_5A07A
		move.w	(Events_bg+$0A).w,d0
		tst.b	(Events_bg+$09).w
		beq.s	locK_59FFA
		cmpi.w	#$80,d0
		bhs.s	locK_5A000
		addq.w	#1,d0
		bra.s	locK_5A000
; ---------------------------------------------------------------------------

locK_59FFA:
		tst.w	d0
		beq.s	locK_5A000
		subq.w	#1,d0

locK_5A000:
		move.w	d0,(Events_bg+$0A).w
		swap	d0
		clr.w	d0
		asr.l	#8,d0
		move.w	d0,d1
		swap	d0
		moveq	#$30,d2
		moveq	#0,d3
		move.w	#$B0-1,d4
		tst.b	(Events_bg+$08).w
		bne.s	locK_5A040
		lea	(HScroll_table+$110).w,a1

locK_5A020:
		move.b	d2,(a1)+
		add.w	d1,d3
		addx.w	d0,d2
		dbf	d4,locK_5A020
		moveq	#$30,d2
		moveq	#0,d3
		moveq	#$10-1,d4
		lea	(HScroll_table+$110).w,a1

locK_5A034:
		sub.w	d1,d3
		subx.w	d0,d2
		move.b	d2,-(a1)
		dbf	d4,locK_5A034
		bra.s	locK_5A062
; ---------------------------------------------------------------------------

locK_5A040:
		lea	(HScroll_table+$1B0).w,a1

locK_5A044:
		move.b	d2,-(a1)
		add.w	d1,d3
		addx.w	d0,d2
		dbf	d4,locK_5A044
		moveq	#$30,d2
		moveq	#0,d3
		moveq	#$10-1,d4
		lea	(HScroll_table+$1B0).w,a1

locK_5A058:
		sub.w	d1,d3
		subx.w	d0,d2
		move.b	d2,(a1)+
		dbf	d4,locK_5A058

locK_5A062:
		move.w	#$A0,d1
		lea	(HScroll_table+$110).w,a2
		move.w	#$AA0,d4
		move.w	d4,x_pos(a0)
		jsr	(SolidObjectTopSloped2).l
		bra.s	locK_5A094
; ---------------------------------------------------------------------------

locK_5A07A:
		move.w	#$180,d1
		move.w	#$40,d2
		move.w	#$30,d3
		move.w	#$B80,d4
		move.w	d4,x_pos(a0)
		jsr	(SolidObjectTop).l

locK_5A094:
		move.w	(Events_bg+$0A).w,d0
		swap	d0
		clr.w	d0
		lsr.l	#7,d0
		move.l	d0,d1
		lsr.l	#1,d1
		add.l	d1,d0
		tst.b	(Events_bg+$08).w
		bne.s	locK_5A0AC
		neg.l	d0

locK_5A0AC:
		move.l	d0,(Events_bg+$14).w
		btst	#p1_standing_bit,status(a0)
		beq.s	locK_5A0DE
		lea	(Player_1).w,a1
		tst.b	(End_of_level_flag).w
		bne.s	locK_5A0D6
		btst	#Status_FireShield,status_secondary(a1)
		bne.s	locK_5A0D6
		tst.b	(_unkFACD).w
		bne.s	locK_5A0D6
		jsr	(Touch_HurtSpikes).l

locK_5A0D6:
		move.l	(Events_bg+$14).w,d0
		add.l	d0,x_pos(a1)

locK_5A0DE:
		btst	#p2_standing_bit,status(a0)
		beq.s	locretK_5A104
		lea	(Player_2).w,a1
		tst.b	(End_of_level_flag).w
		bne.s	locK_5A0FC
		tst.b	(_unkFACD).w
		bne.s	locK_5A0FC
		jsr	(Touch_HurtSpikes).l

locK_5A0FC:
		move.l	(Events_bg+$14).w,d0
		add.l	d0,x_pos(a1)

locretK_5A104:
		rts
; ---------------------------------------------------------------------------

wordK_5A106:
		dc.w   $310,   $10,   $10,   $10,   $10,   $10,   $10,   $10,   $10,   $10
		dc.w    $10,   $10,   $10,   $10,   $10,   $10,   $10,   $10,   $10, $7FFF
; ---------------------------------------------------------------------------

HPZ_ScreenInit:
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_5A13E
		move.w	#$AA0,(Camera_max_X_pos).w
		bra.s	locK_5A14C
; ---------------------------------------------------------------------------

locK_5A13E:
		cmpi.w	#$480,(Player_1+y_pos).w
		bhs.s	locK_5A14C
		move.w	#$AA0,(Camera_min_X_pos).w

locK_5A14C:
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

HPZ_ScreenEvent:
		tst.w	(Events_bg+$00).w
		bne.s	locK_5A176
		tst.w	(Palette_fade_timer).w
		bne.s	locK_5A176
		jsr	(AllocateObject).l
		bne.s	locK_5A172
		move.l	#Obj_HPZPaletteControl,(a1)

locK_5A172:
		st	(Events_bg+$00).w

locK_5A176:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		tst.w	(Events_fg_4).w
		beq.s	locK_5A19E
		clr.w	(Events_fg_4).w
		movea.w	$1C(a3),a1
		move.b	#$61,$30(a1)
		move.b	#$61,$31(a1)
		jmp	(Refresh_PlaneScreenDirect).l
; ---------------------------------------------------------------------------

locK_5A19E:
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

HPZ_BackgroundInit:
		move.w	$14(a3),$18(a3)
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_5A1C2
		movea.w	4(a3),a1
		move.b	#$8E,3(a1)
		move.b	#$8F,4(a1)

locK_5A1C2:
		cmpi.w	#$EC0,(Player_1+x_pos).w
		bhs.s	locK_5A1D0
		jsr	subK_5A32C(pc)
		bra.s	locK_5A1DA
; ---------------------------------------------------------------------------

locK_5A1D0:
		move.w	#8,(Events_routine_bg).w
		jsr	subK_5A334(pc)

locK_5A1DA:
		jsr	(Reset_TileOffsetPositionEff).l
		lea	(HScroll_table).w,a1
		move.w	(a1)+,(a1)
		andi.w	#$FFF0,(a1)+
		move.w	(a1)+,(a1)
		andi.w	#$FFF0,(a1)
		lea	HPZ_BGDrawArray(pc),a4
		lea	(HScroll_table).w,a5
		jsr	(Refresh_PlaneTileDeform).l
		lea	HPZ_BGDeformArray(pc),a4
		lea	(HScroll_table+$008).w,a5
		jmp	(ApplyDeformation).l
; ---------------------------------------------------------------------------

HPZ_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	HPZ_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

HPZ_BackgroundEvent_Index:
		bra.w	locK_5A224
; ---------------------------------------------------------------------------
		bra.w	locK_5A288
; ---------------------------------------------------------------------------
		bra.w	locK_5A2A6
; ---------------------------------------------------------------------------
		bra.w	locK_5A30A
; ---------------------------------------------------------------------------

locK_5A224:
		cmpi.w	#$EC0,(Player_1+x_pos).w
		blo.s	locK_5A25E
		jsr	subK_5A334(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		lea	(HScroll_table).w,a1
		move.w	(a1)+,(a1)
		andi.w	#$FFF0,(a1)+
		move.w	(a1)+,(a1)
		andi.w	#$FFF0,(a1)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_5A28C
; ---------------------------------------------------------------------------

locK_5A25E:
		jsr	subK_5A32C(pc)

locK_5A262:
		lea	HPZ_BGDrawArray(pc),a4
		lea	(HScroll_table).w,a5
		moveq	#$20,d6
		moveq	#2,d5
		jsr	(Draw_BG).l
		lea	HPZ_BGDeformArray(pc),a4
		lea	(HScroll_table+$008).w,a5
		jsr	(ApplyDeformation).l
		jmp	(ShakeScreen_Setup).l
; ---------------------------------------------------------------------------

locK_5A288:
		jsr	subK_5A334(pc)

locK_5A28C:
		lea	HPZ_BGDrawArray(pc),a4
		lea	(HScroll_table-$04).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d1
		jsr	(Draw_PlaneVertBottomUpComplex).l
		bpl.s	locK_5A2E4
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_5A2E4
; ---------------------------------------------------------------------------

locK_5A2A6:
		cmpi.w	#$EC0,(Player_1+x_pos).w
		bhs.s	locK_5A2E0
		jsr	subK_5A32C(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		lea	(HScroll_table).w,a1
		move.w	(a1)+,(a1)
		andi.w	#$FFF0,(a1)+
		move.w	(a1)+,(a1)
		andi.w	#$FFF0,(a1)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_5A30E
; ---------------------------------------------------------------------------

locK_5A2E0:
		jsr	subK_5A334(pc)

locK_5A2E4:
		lea	HPZ_BGDrawArray(pc),a4
		lea	(HScroll_table).w,a5
		moveq	#$20,d6
		moveq	#2,d5
		jsr	(Draw_BG).l
		lea	HPZ_BGDeformArray(pc),a4
		lea	(HScroll_table+$008).w,a5
		jsr	(ApplyDeformation).l
		jmp	(ShakeScreen_Setup).l
; ---------------------------------------------------------------------------

locK_5A30A:
		jsr	subK_5A32C(pc)

locK_5A30E:
		lea	HPZ_BGDrawArray(pc),a4
		lea	(HScroll_table-$04).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d1
		jsr	(Draw_PlaneVertBottomUpComplex).l
		bpl.w	locK_5A262
		clr.w	(Events_routine_bg).w
		bra.w	locK_5A262

; =============== S U B R O U T I N E =======================================


subK_5A32C:
		move.w	#$348,d2
		moveq	#0,d3
		bra.s	locK_5A33C
; End of function subK_5A32C


; =============== S U B R O U T I N E =======================================


subK_5A334:
		move.w	#$E00,d2
		move.w	#$700,d3

locK_5A33C:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Screen_shake_offset).w,d4
		sub.w	d4,d0
		add.w	d3,d0
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		add.l	d0,d0
		add.l	d1,d0
		swap	d0
		add.w	d4,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		sub.w	d2,d0
		swap	d0
		clr.w	d0
		move.l	d0,d2
		asr.l	#4,d0
		move.l	d0,d1
		add.l	d0,d0
		add.l	d1,d0
		swap	d0
		move.w	d0,(HScroll_table).w
		move.w	d0,(HScroll_table+$008).w
		lea	(HScroll_table+$01C).w,a1
		move.l	d2,d0
		asr.l	#2,d2
		sub.l	d2,d0
		asr.l	#2,d2
		moveq	#9-1,d1

locK_5A388:
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d2,d0
		dbf	d1,locK_5A388
		move.w	(HScroll_table+$01A).w,(HScroll_table+$004).w
		rts
; End of function subK_5A334

; ---------------------------------------------------------------------------

HPZ_BGDrawArray:
		dc.w   $200, $7FFF

HPZ_BGDeformArray:
		dc.w   $198,     8,     4,     4,     8,     8,   $10,     8,   $30, $7FFF