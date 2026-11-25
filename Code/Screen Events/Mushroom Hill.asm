; ---------------------------------------------------------------------------

MHZ1_ScreenInit:
		clr.w	(Events_bg+$16).w
		clr.b	(_unkF7C1).w
		jsr	subK_54B80(pc)
		tst.w	(SK_alone_flag).w
		beq.s	locK_54B18
		move.b	(Last_star_post_hit).w,d0
		beq.s	locK_54AE0
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_54B18
		subq.b	#1,d0
		bne.s	locK_54B18
		move.w	#$680,d2
		bra.s	locK_54B10
; ---------------------------------------------------------------------------

locK_54AE0:
		move.w	#$560,d2
		move.w	#$948,d3
		cmpi.w	#3,(Player_mode).w
		beq.s	locK_54B08
		lea	(Player_1).w,a1
		move.w	#$718,x_pos(a1)
		move.w	#$62D,y_pos(a1)
		move.w	#$680,d2
		move.w	#$5CD,d3

locK_54B08:
		move.w	d3,(Camera_Y_pos).w
		move.w	d3,(Camera_Y_pos_copy).w

locK_54B10:
		move.w	d2,(Camera_X_pos).w
		move.w	d2,(Camera_X_pos_copy).w

locK_54B18:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

MHZ1_ScreenEvent:
		tst.b	(Events_bg+$00).w
		bne.s	locK_54B7C
		tst.w	(Events_bg+$16).w
		bne.s	locK_54B7C
		jsr	subK_54B80(pc)
		move.w	#$AA0,d0
		cmpi.w	#$4100,(Player_1+x_pos).w
		blo.s	locK_54B40
		move.w	#$710,d0

locK_54B40:
		cmp.w	(Camera_max_Y_pos).w,d0
		beq.s	locK_54B4E
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w

locK_54B4E:
		cmpi.w	#$710,(Camera_Y_pos).w
		blo.s	locK_54B7C
		cmpi.w	#$4298,(Camera_X_pos).w
		blo.s	locK_54B7C
		move.w	#$710,(Camera_min_Y_pos).w
		move.w	#8,(Special_events_routine).w
		st	(Events_bg+$00).w
		jsr	(AllocateObject).l
		bne.s	locK_54B7C
		move.l	#Obj_MHZMiniboss,(a1)

locK_54B7C:
		jmp	DrawTilesAsYouMove(pc)

; =============== S U B R O U T I N E =======================================


subK_54B80:
		move.w	#$680,d0
		tst.w	(SK_alone_flag).w
		bne.s	locK_54B98
		moveq	#0,d0
		cmpi.w	#$580,(Player_1+y_pos).w
		bhs.s	locK_54B98
		move.w	#$C0,d0

locK_54B98:
		cmp.w	(Camera_min_X_pos).w,d0
		beq.s	locretK_54BA2
		move.w	d0,(Camera_min_X_pos).w

locretK_54BA2:
		rts
; End of function subK_54B80

; ---------------------------------------------------------------------------

MHZ1_BackgroundInit:
		move.w	(Camera_X_pos_copy).w,(Events_fg_0).w
		move.w	(Camera_X_pos_copy).w,(Events_fg_1).w
		jsr	MHZ_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

MHZ1_BackgroundEvent:
		tst.w	(Events_fg_5).w
		beq.w	locK_54C3C
		clr.w	(Events_fg_5).w
		movem.l	d7-a0/a2-a3,-(sp)
		moveq	#PLCID_28,d0
		jsr	(Load_PLC).l
		move.w	#$701,(Current_zone_and_act).w
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(Respawn_table_keep).w
		jsr	Clear_Switches(pc)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$4200,d0
		moveq	#0,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d0,(Player_2+x_pos).w
		jsr	subK_54CF4(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		move.w	(Camera_X_pos_copy).w,(Events_fg_0).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w
		jsr	Reset_TileOffsetPositionActual(pc)
		clr.w	(Special_events_routine).w
		clr.b	(Events_bg+$00).w

locK_54C3C:
		lea	(Events_fg_0).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		move.w	#$100,d2
		move.w	#$200,d3
		jsr	Adjust_BGDuringLoop(pc)
		jsr	MHZ_Deform(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		jmp	PlainDeformation(pc)

; =============== S U B R O U T I N E =======================================


MHZ_Deform:
		move.w	(Camera_Y_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#3,d0
		move.l	d0,d1
		asr.l	#2,d1
		add.l	d1,d0
		swap	d0
		addi.w	#$76,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Events_fg_1).w,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#2,d1
		sub.l	d1,d0
		asr.l	#1,d1
		swap	d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,(Events_bg+$10).w
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,(Events_bg+$12).w
		rts
; End of function MHZ_Deform

; ---------------------------------------------------------------------------

locK_54CB0:
		clr.w	(Level_repeat_offset).w
		move.w	(Camera_X_pos).w,d0
		cmpi.w	#$4400,d0
		blo.s	locK_54CEE
		move.w	#$200,d1
		move.w	d1,(Level_repeat_offset).w
		sub.w	d1,(Player_1+x_pos).w
		sub.w	d1,(Player_2+x_pos).w
		sub.w	d1,d0
		move.w	d0,d1
		andi.w	#$FFF0,d1
		subi.w	#$10,d1
		move.w	d1,(Camera_X_pos_rounded).w
		move.w	d0,(Camera_X_pos).w
		move.w	d0,(Camera_X_pos_copy).w
		move.w	#$4298,d2
		move.w	d2,(Camera_max_X_pos).w

locK_54CEE:
		move.w	d0,(Camera_min_X_pos).w
		rts

; =============== S U B R O U T I N E =======================================


subK_54CF4:
		lea	(Dynamic_object_RAM+object_size).w,a1
		moveq	#((Breathing_bubbles)-(Dynamic_object_RAM+object_size))/object_size-1,d2

locK_54CFA:
		move.l	(a1),d3
		beq.s	locK_54D26
		cmpi.l	#loc_2B962,d3
		bne.s	locK_54D16
		move.l	#Delete_Current_Sprite,(a1)
		move.w	respawn_addr(a1),d3
		beq.s	locK_54D16
		movea.w	d3,a5
		clr.b	(a5)

locK_54D16:
		btst	#2,render_flags(a1)
		beq.s	locK_54D26
		sub.w	d0,x_pos(a1)
		sub.w	d1,y_pos(a1)

locK_54D26:
		lea	next_object(a1),a1
		dbf	d2,locK_54CFA
		rts
; End of function subK_54CF4

; ---------------------------------------------------------------------------

MHZ2_ScreenInit:
		move.w	#4,(Events_routine_fg).w
		clr.w	(Events_bg+$16).w
		st	(_unkF7C1).w
		move.w	(Player_1+x_pos).w,d0
		lea	Pal_MHZ2Gold(pc),a1
		cmpi.w	#$2940,d0
		bhs.s	locK_54D72
		st	(Events_bg+$04).w
		lea	(Pal_MHZ2+$20).l,a1
		cmpi.w	#$9C0,d0
		bhs.s	locK_54D72
		cmpi.w	#$600,(Player_1+y_pos).w
		blo.s	locK_54D72
		clr.b	(Events_bg+$04).w
		clr.b	(_unkF7C1).w
		lea	(Pal_MHZ1+$20).l,a1

locK_54D72:
		lea	(Normal_palette_line_3).w,a5
		lea	(Target_palette_line_3).w,a6
		moveq	#bytesToLcnt($40),d0

locK_54D7C:
		move.l	(a1),(a5)+
		move.l	(a1)+,(a6)+
		dbf	d0,locK_54D7C
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

MHZ2_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_X_pos_copy).w
		move.w	(Events_routine_fg).w,d0
		jmp	MHZ2_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

MHZ2_ScreenEvent_Index:
		bra.w	locK_54DB0
; ---------------------------------------------------------------------------
		bra.w	locK_54DBE
; ---------------------------------------------------------------------------
		bra.w	locK_54E86
; ---------------------------------------------------------------------------
		bra.w	locK_54E9C
; ---------------------------------------------------------------------------
		bra.w	locK_54F64
; ---------------------------------------------------------------------------

locK_54DB0:
		tst.b	(End_of_level_flag).w
		beq.s	locK_54DBA
		addq.w	#4,(Events_routine_fg).w

locK_54DBA:
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

locK_54DBE:
		tst.w	(Events_fg_4).w
		beq.s	locK_54DDC
		clr.w	(Events_fg_4).w
		move.w	#$320,(Draw_delayed_position).w
		move.w	#$A,(Draw_delayed_rowcount).w
		addq.w	#8,(Events_routine_fg).w
		bra.w	locK_54E9C
; ---------------------------------------------------------------------------

locK_54DDC:
		cmpi.w	#$3C90,(Camera_X_pos).w
		blo.s	locK_54E00
		bne.w	locK_54E7E
		move.w	#$3C90,(Camera_min_X_pos).w
		cmpi.w	#$280,(Camera_Y_pos).w
		blo.w	locK_54E7E
		move.w	#$280,(Camera_min_Y_pos).w
		bra.s	locK_54E7E
; ---------------------------------------------------------------------------

locK_54E00:
		move.w	#$620,d0
		cmpi.w	#$380,(Camera_X_pos).w
		blo.s	locK_54E1A
		moveq	#0,d0
		cmpi.w	#$3600,(Camera_X_pos).w
		blo.s	locK_54E1A
		move.w	#$1A8,d0

locK_54E1A:
		cmp.w	(Camera_min_Y_pos).w,d0
		beq.s	locK_54E24
		move.w	d0,(Camera_min_Y_pos).w

locK_54E24:
		cmpi.w	#$3600,(Camera_X_pos).w
		bhs.s	locK_54E4C
		move.w	#$98,d0
		cmpi.w	#$5C0,(Player_1+y_pos).w
		bhs.s	locK_54E3C
		move.w	#$380,d0

locK_54E3C:
		cmp.w	(Camera_min_X_pos).w,d0
		beq.s	locK_54E4C
		tst.w	(Events_bg+$16).w
		bne.s	locK_54E4C
		move.w	d0,(Camera_min_X_pos).w

locK_54E4C:
		move.w	#$9A0,d0
		cmpi.w	#$3A97,(Player_1+x_pos).w
		blo.s	locK_54E70
		move.w	#$280,d0
		cmpi.w	#$3AC0,(Player_1+x_pos).w
		bhs.s	locK_54E70
		cmpi.w	#$300,(Player_1+y_pos).w
		blo.s	locK_54E70
		move.w	#$9A0,d0

locK_54E70:
		cmp.w	(Camera_max_Y_pos).w,d0
		beq.s	locK_54E7E
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w

locK_54E7E:
		bsr.w	subK_55008
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

locK_54E86:
		move.w	(Camera_X_pos_copy).w,(HScroll_table+$004).w
		lea	MHZ2_BGDrawArray1(pc),a4
		lea	(HScroll_table).w,a5
		moveq	#$15,d6
		moveq	#2,d5
		jmp	loc_4EDD8(pc)
; ---------------------------------------------------------------------------

locK_54E9C:
		move.w	#$4280,d1
		move.w	#$280,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.w	locretK_54F62
		move.l	#$400000,(_unkEE98).w
		move.w	#$80,d0
		move.w	d0,(_unkEEA2).w
		move.w	d0,(_unkEE9C).w
		jsr	subK_54F8C(pc)
		lea	(HScroll_table).w,a1
		move.w	(a1)+,d0
		andi.w	#$FFF0,d0
		move.w	d0,(a1)+
		clr.l	(a1)+
		move.w	(a1)+,d0
		andi.w	#$FFF0,d0
		move.w	d0,(a1)+
		lea	(Normal_palette_line_2).w,a1
		lea	Pal_MHZ2Ship(pc),a5
		moveq	#bytesToLcnt($20),d0

locK_54EE4:
		move.l	(a5)+,(a1)+
		dbf	d0,locK_54EE4
		lea	(HScroll_table+$00C).w,a5
		clr.l	(a5)
		jsr	(AllocateObject).l
		bne.s	locK_54F2A
		move.l	#locK_5583E,(a1)
		move.w	#$4C0,$30(a1)
		move.w	#$4000,$3A(a1)
		jsr	(CreateNewSprite4).l
		bne.s	locK_54F2A
		move.l	#locK_55814,(a1)
		move.w	a1,(a5)+
		jsr	(CreateNewSprite4).l
		bne.s	locK_54F2A
		move.l	#locK_55814,(a1)
		move.w	a1,(a5)+

locK_54F2A:
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(ArtKosM_MHZShipPropeller).l,a1
		move.w	#tiles_to_bytes(ArtTile_MHZShipPropeller),d2
		jsr	(Queue_Kos_Module).l
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$4EF9,(H_int_jump).w
		move.l	#HInt7,(H_int_addr).w
		move.b	#$80,(H_int_counter).w
		move.w	#$8014,(VDP_control_port).l
		addq.w	#4,(Events_routine_fg).w

locretK_54F62:
		rts
; ---------------------------------------------------------------------------

locK_54F64:
		jsr	subK_54F8C(pc)
		lea	MHZ2_BGDrawArray3(pc),a4
		lea	(HScroll_table).w,a6
		moveq	#2,d5
		move.w	(_unkEEA2).w,d6
		jsr	Draw_BGNoVert(pc)
		lea	MHZ2_BGDrawArray2(pc),a4
		lea	(HScroll_table+$004).w,a6
		moveq	#2,d5
		move.w	(Camera_Y_pos_rounded).w,d6
		jmp	Draw_BGNoVert(pc)

; =============== S U B R O U T I N E =======================================


subK_54F8C:
		move.w	(Camera_X_pos_copy).w,d0
		move.w	d0,(HScroll_table+$008).w
		addi.w	#$1E0,d0
		add.w	(_unkEE98).w,d0
		move.w	(HScroll_table).w,d2
		move.w	d0,(HScroll_table).w
		move.w	(_unkEE9C).w,d1
		lea	(Player_1).w,a1
		cmpi.b	#$81,object_control(a1)
		bne.s	locK_54FD4
		move.w	#$2DC,d3
		cmpi.w	#3,(Player_mode).w
		beq.s	locK_54FC4
		move.w	#$2CD,d3

locK_54FC4:
		move.w	(Events_bg+$0C).w,d4
		sub.w	d1,d4
		add.w	d4,y_pos(a1)
		sub.w	d0,d2
		add.w	d2,x_pos(a1)

locK_54FD4:
		move.w	d1,(Events_bg+$0C).w
		neg.w	d1
		addi.w	#$158,d1
		lea	(HScroll_table+$00C).w,a1
		move.w	#$46B8,d2
		bsr.s	subK_54FEC
		move.w	#$45B8,d2
; End of function subK_54F8C


; =============== S U B R O U T I N E =======================================


subK_54FEC:
		move.w	(a1)+,d3
		beq.s	locretK_55006
		movea.w	d3,a5
		sub.w	d0,d2
		bcs.s	locretK_55006
		addi.w	#$5C,d2
		andi.w	#$1FF,d2
		move.w	d2,$10(a5)
		move.w	d1,$14(a5)

locretK_55006:
		rts
; End of function subK_54FEC


; =============== S U B R O U T I N E =======================================


subK_55008:
		lea	wordK_5513E(pc),a1
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		moveq	#0,d2
		move.w	#5-1,d3

locK_5501A:
		lea	(a1),a5
		cmp.w	(a5)+,d0
		blo.s	locK_5502C
		cmp.w	(a5)+,d0
		bhi.s	locK_5502C
		cmp.w	(a5)+,d1
		blo.s	locK_5502C
		cmp.w	(a5)+,d1
		blo.s	locK_55038

locK_5502C:
		adda.w	#$A,a1
		addq.w	#4,d2
		dbf	d3,locK_5501A
		rts
; ---------------------------------------------------------------------------

locK_55038:
		jmp	locK_5503C(pc,d2.w)
; End of function subK_55008

; ---------------------------------------------------------------------------

locK_5503C:
		bra.w	locK_55050
; ---------------------------------------------------------------------------
		bra.w	locK_55062
; ---------------------------------------------------------------------------
		bra.w	locK_55074
; ---------------------------------------------------------------------------
		bra.w	locK_55074
; ---------------------------------------------------------------------------
		bra.w	locK_55086
; ---------------------------------------------------------------------------

locK_55050:
		tst.w	(Events_bg+$04).w
		bne.s	locK_5505C
		cmp.w	(a5),d1
		blo.s	locK_55098
		rts
; ---------------------------------------------------------------------------

locK_5505C:
		cmp.w	(a5),d1
		bhs.s	locK_550A8
		rts
; ---------------------------------------------------------------------------

locK_55062:
		tst.w	(Events_bg+$04).w
		bne.s	locK_5506E
		cmp.w	(a5),d0
		bhs.s	locK_55098
		rts
; ---------------------------------------------------------------------------

locK_5506E:
		cmp.w	(a5),d0
		blo.s	locK_550A8
		rts
; ---------------------------------------------------------------------------

locK_55074:
		tst.w	(Events_bg+$04).w
		bne.s	locK_55080
		cmp.w	(a5),d0
		blo.s	locK_55098
		rts
; ---------------------------------------------------------------------------

locK_55080:
		cmp.w	(a5),d0
		bhs.s	locK_550B8
		rts
; ---------------------------------------------------------------------------

locK_55086:
		tst.w	(Events_bg+$04).w
		bne.s	locK_55092
		cmp.w	(a5),d1
		blo.s	locK_55098
		rts
; ---------------------------------------------------------------------------

locK_55092:
		cmp.w	(a5),d1
		bhs.s	locK_550B8
		rts
; ---------------------------------------------------------------------------

locK_55098:
		st	(Events_bg+$04).w
		st	(_unkF7C1).w
		lea	(Pal_MHZ2+$20).l,a1
		bra.s	locK_550C4
; ---------------------------------------------------------------------------

locK_550A8:
		clr.w	(Events_bg+$04).w
		clr.b	(_unkF7C1).w
		lea	(Pal_MHZ1+$20).l,a1
		bra.s	locK_550C4
; ---------------------------------------------------------------------------

locK_550B8:
		clr.w	(Events_bg+$04).w
		st	(_unkF7C1).w
		lea	Pal_MHZ2Gold(pc),a1

locK_550C4:
		lea	(Normal_palette_line_3).w,a5
		moveq	#bytesToLcnt($40),d0

locK_550CA:
		move.l	(a1)+,(a5)+
		dbf	d0,locK_550CA
		rts
; ---------------------------------------------------------------------------
MHZ2_BGDrawArray1:
		dc.w $2B0, $7FFF
MHZ2_BGDrawArray2:
		dc.w $300, $7FFF
MHZ2_BGDrawArray3:
		dc.w $100, $7FFF
Pal_MHZ2Ship:
		binclude "Levels/MHZ/Palettes/Act 2 Ship.bin"
		even
Pal_MHZ2Gold:
		binclude "Levels/MHZ/Palettes/Act 2 Gold.bin"
		even
wordK_5513E:
		dc.w   $420,  $4A0,  $640,  $6C0
		dc.w   $680,  $980,  $A00,  $7C0
		dc.w   $800,  $9C0, $2900, $2980
		dc.w   $280,  $300, $2940, $2B00
		dc.w  $2B80,  $540,  $580, $2B40
		dc.w  $2800, $2980,  $7C0,  $840
		dc.w   $800
; ---------------------------------------------------------------------------

MHZ2_BackgroundInit:
		move.w	(Camera_X_pos_copy).w,(Events_fg_0).w
		move.w	(Camera_X_pos_copy).w,(Events_fg_1).w
		cmpi.w	#$3700,(Player_1+x_pos).w
		blo.s	locK_55198
		cmpi.w	#$500,(Player_1+y_pos).w
		bhs.s	locK_55198
		move.w	#8,(Events_routine_bg).w
		jsr	subK_554B8(pc)
		bra.s	locK_5519C
; ---------------------------------------------------------------------------

locK_55198:
		jsr	MHZ_Deform(pc)

locK_5519C:
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

MHZ2_BackgroundEvent:
		lea	(Events_fg_0).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		move.w	#$100,d2
		move.w	#$200,d3
		jsr	Adjust_BGDuringLoop(pc)
		move.w	(Events_routine_bg).w,d0
		jmp	MHZ2_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

MHZ2_BackgroundEvent_Index:
		bra.w	locK_551EE
; ---------------------------------------------------------------------------
		bra.w	locK_55236
; ---------------------------------------------------------------------------
		bra.w	locK_55250
; ---------------------------------------------------------------------------
		bra.w	locK_552F8
; ---------------------------------------------------------------------------
		bra.w	locK_55312
; ---------------------------------------------------------------------------
		bra.w	locK_553B6
; ---------------------------------------------------------------------------
		bra.w	locK_55424
; ---------------------------------------------------------------------------
		bra.w	locK_5543A
; ---------------------------------------------------------------------------
		bra.w	locK_5545A
; ---------------------------------------------------------------------------
		bra.w	locK_55486
; ---------------------------------------------------------------------------

locK_551EE:
		cmpi.w	#$3700,(Player_1+x_pos).w
		blo.s	locK_5521E
		cmpi.w	#$500,(Player_1+y_pos).w
		bhs.s	locK_5521E
		jsr	subK_554B8(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	locK_5523A
; ---------------------------------------------------------------------------

locK_5521E:
		jsr	MHZ_Deform(pc)

locK_55222:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

locK_55236:
		jsr	subK_554B8(pc)

locK_5523A:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.w	locK_552E4
		addq.w	#4,(Events_routine_bg).w
		bra.w	locK_552E4
; ---------------------------------------------------------------------------

locK_55250:
		cmpi.w	#$500,(Player_1+y_pos).w
		blo.s	locK_5527A
		jsr	MHZ_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.w	locK_552FC
; ---------------------------------------------------------------------------

locK_5527A:
		cmpi.w	#$420,(Player_1+y_pos).w
		bls.s	locK_5528A
		btst	#1,(Player_1+status).w
		bne.s	locK_552E0

locK_5528A:
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(MHZ_Custom_Layout).l,a1
		lea	(Level_layout_header).w,a2
		move.w	#$200-1,d0

locK_5529C:
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		dbf	d0,locK_5529C
		lea	(MHZ_128x128_Custom_Kos).l,a1
		lea	(Chunk_table+$2280).l,a2
		jsr	(Queue_Kos).l
		lea	(MHZ_16x16_Custom_Kos).l,a1
		lea	(Block_table+$B28).w,a2
		jsr	(Queue_Kos).l
		lea	(ArtKosM_MHZ_Custom).l,a1
		move.w	#tiles_to_bytes($222),d2
		jsr	(Queue_Kos_Module).l
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#8,(Events_routine_bg).w
		bra.s	locK_55312
; ---------------------------------------------------------------------------

locK_552E0:
		jsr	subK_554B8(pc)

locK_552E4:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

locK_552F8:
		jsr	MHZ_Deform(pc)

locK_552FC:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.w	locK_55222
		clr.w	(Events_routine_bg).w
		bra.w	locK_55222
; ---------------------------------------------------------------------------

locK_55312:
		tst.b	(Events_bg+$00).w
		bne.s	locK_55380
		cmpi.w	#$3F00,(Camera_X_pos).w
		blo.w	locK_55486
		addq.w	#4,(Events_routine_fg).w
		clr.l	(HScroll_table).w
		move.w	(Camera_X_pos_copy).w,d0
		move.w	d0,(HScroll_table+$004).w
		andi.w	#$FFF0,d0
		move.w	d0,(HScroll_table+$006).w
		move.w	#$1A0,(Draw_delayed_position).w
		move.w	#2,(Draw_delayed_rowcount).w
		st	(Events_bg+$00).w
		lea	wordK_558E8(pc),a1
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_5535A
		lea	$10(a1),a1

locK_5535A:
		move.b	(a1),(Events_bg+$07).w
		st	(Scroll_lock).w
		move.w	#$C,(Special_events_routine).w
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(ArtKosM_MHZEndBossPillar).l,a1
		move.w	#tiles_to_bytes(ArtTile_MHZEndBossPillar),d2
		jsr	(Queue_Kos_Module).l
		movem.l	(sp)+,d7-a0/a2-a3

locK_55380:
		move.w	#$4000,d1
		move.w	#$180,d2
		lea	(Level_layout_main).w,a3
		move.w	#VRAM_Plane_A_Name_Table,d7
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		addq.w	#2,a3
		move.w	#VRAM_Plane_B_Name_Table,d7
		tst.w	(Draw_delayed_rowcount).w
		bpl.w	locK_55486
		move.w	#$80,(Draw_delayed_position).w
		move.w	#2,(Draw_delayed_rowcount).w
		st	(Events_bg+$01).w
		addq.w	#4,(Events_routine_bg).w

locK_553B6:
		move.w	#$200,d1
		move.w	#$80,d2
		jsr	Draw_PlaneVertTopDown(pc)
		bpl.w	locK_55486
		lea	(HScroll_table+$008).w,a5
		clr.l	(a5)
		clr.l	4(a5)
		jsr	(AllocateObject).l
		bne.s	locK_55420
		move.l	#locK_556F8,(a1)
		jsr	(CreateNewSprite4).l
		bne.s	locK_55420
		move.l	#locK_55732,(a1)
		move.w	a1,(a5)+
		moveq	#2,d1

locK_553F0:
		jsr	(CreateNewSprite4).l
		bne.s	locK_55420
		move.l	#locK_5577C,(a1)
		move.w	d1,$2E(a1)
		move.w	a1,(a5)+
		jsr	(CreateNewSprite4).l
		bne.s	locK_55420
		move.l	#locK_5577C,(a1)
		move.w	d1,$2E(a1)
		st	$30(a1)
		move.w	a1,(a5)+
		dbf	d1,locK_553F0

locK_55420:
		addq.w	#4,(Events_routine_bg).w

locK_55424:
		tst.w	(Events_fg_5).w
		bpl.s	locK_55486
		move.w	#$180,(Draw_delayed_position).w
		move.w	#2,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w

locK_5543A:
		moveq	#0,d1
		move.w	#$180,d2
		jsr	Draw_PlaneVertTopDown(pc)
		bpl.s	locK_55486
		clr.b	(Events_bg+$01).w
		move.w	#$280,(Draw_delayed_position).w
		move.w	#2,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w

locK_5545A:
		move.w	#$4080,d1
		move.w	#$280,d2
		lea	(Level_layout_main).w,a3
		move.w	#VRAM_Plane_A_Name_Table,d7
		jsr	Draw_PlaneVertTopDown(pc)
		addq.w	#2,a3
		move.w	#VRAM_Plane_B_Name_Table,d7
		tst.w	(Draw_delayed_rowcount).w
		bpl.s	locK_55486
		clr.b	(Events_bg+$00).w
		clr.w	(Events_routine_fg).w
		addq.w	#4,(Events_routine_bg).w

locK_55486:
		jsr	subK_554B8(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		jsr	subK_5550C(pc)
		cmpi.w	#$10,(Events_routine_fg).w
		bne.s	locK_554B4
		move.w	(_unkEE9C).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp

locK_554B4:
		jmp	ShakeScreen_Setup(pc)

; =============== S U B R O U T I N E =======================================


subK_554B8:
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$280,d0
		swap	d0
		clr.w	d0
		asr.l	#3,d0
		move.l	d0,d1
		asr.l	#2,d1
		add.l	d1,d0
		swap	d0
		addi.w	#$180,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Events_fg_1).w,d0
		move.w	(Screen_shake_offset).w,d2
		sub.w	d2,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#2,d1
		sub.l	d1,d0
		asr.l	#1,d1
		swap	d0
		add.w	d2,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,(Events_bg+$10).w
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,(Events_bg+$12).w
		rts
; End of function subK_554B8


; =============== S U B R O U T I N E =======================================


subK_5550C:
		jsr	PlainDeformation(pc)
		cmpi.w	#$10,(Events_routine_fg).w
		bne.s	locK_55534
		lea	(H_scroll_buffer).w,a1
		move.w	(HScroll_table).w,d0
		neg.w	d0
		moveq	#$40-1,d1

locK_55524:
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		dbf	d1,locK_55524
		bra.w	locretK_5560A
; ---------------------------------------------------------------------------

locK_55534:
		tst.b	(Events_bg+$00).w
		beq.s	locK_55552
		lea	(H_scroll_buffer).w,a1
		move.w	(Camera_X_pos_BG_copy).w,d0
		neg.w	d0
		moveq	#$18-1,d1

locK_55546:
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		dbf	d1,locK_55546

locK_55552:
		tst.b	(Events_bg+$01).w
		beq.w	locretK_5560A
		move.w	(Camera_X_pos).w,d0
		subi.w	#$4180,d0
		cmpi.w	#-$140,d0
		blt.w	locK_555FC
		move.w	d0,d1
		muls.w	#$5600,d1
		add.l	d1,d1
		swap	d1
		sub.w	d1,d0
		subi.w	#$18,d0
		swap	d0
		clr.w	d0
		tst.l	d0
		smi	d3
		bpl.s	locK_55586
		neg.l	d0

locK_55586:
		moveq	#0,d2
		swap	d0
		move.w	d0,d2
		divu.w	#$30,d2
		move.w	d2,d1
		swap	d0
		move.w	d0,d2
		divu.w	#$30,d2
		swap	d1
		move.w	d2,d1
		tst.b	d3
		beq.s	locK_555A4
		neg.l	d1

locK_555A4:
		lea	(H_scroll_buffer+2).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$80,d0
		neg.w	d0
		swap	d0
		clr.w	d0
		moveq	#$30-1,d2

locK_555B8:
		swap	d0
		move.w	d0,(a1)
		swap	d0
		add.l	d1,d0
		addq.w	#4,a1
		dbf	d2,locK_555B8
		lea	(HScroll_table+$008).w,a1
		lea	(H_scroll_buffer+$BE).w,a5
		moveq	#$1C,d0
		moveq	#7-1,d1

locK_555D2:
		move.w	(a1)+,d2
		beq.s	locretK_5560A
		movea.w	d2,a6
		move.w	(a5),d2
		subi.w	#$48,d2
		andi.w	#$1FF,d2
		add.w	(Camera_X_pos).w,d2
		move.w	d2,$10(a6)
		btst	#0,d1
		bne.s	locK_555F6
		suba.w	d0,a5
		addi.w	#$C,d0

locK_555F6:
		dbf	d1,locK_555D2
		bra.s	locretK_5560A
; ---------------------------------------------------------------------------

locK_555FC:
		lea	(H_scroll_buffer+2).w,a1
		moveq	#$30-1,d0

locK_55602:
		clr.w	(a1)
		addq.w	#4,a1
		dbf	d0,locK_55602

locretK_5560A:
		rts
; End of function subK_5550C

; ---------------------------------------------------------------------------

locK_5560C:
		clr.w	(Level_repeat_offset).w
		move.w	(Camera_X_pos).w,d0
		addq.w	#4,d0
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_55620
		addq.w	#1,d0

locK_55620:
		cmpi.w	#$4280,d0
		blo.s	locK_5569A
		tst.w	(Events_fg_5).w
		beq.s	locK_5564A
		st	(Events_fg_5).w
		cmpi.w	#$4420,d0
		blo.s	locK_5569A
		move.w	#$4420,d0
		move.w	#$45A0,(Camera_max_X_pos).w
		st	(Scroll_lock).w
		clr.w	(Special_events_routine).w
		bra.s	locK_5569E
; ---------------------------------------------------------------------------

locK_5564A:
		move.w	#$200,d1
		move.w	d1,(Level_repeat_offset).w
		sub.w	d1,(Player_1+x_pos).w
		sub.w	d1,(Player_2+x_pos).w
		sub.w	d1,d0
		move.w	d0,d1
		andi.w	#$FFF0,d1
		subi.w	#$10,d1
		move.w	d1,(Camera_X_pos_rounded).w
		addq.w	#1,(Events_bg+$08).w
		move.w	(Events_bg+$08).w,d1
		andi.w	#$F,d1
		lea	wordK_558E8(pc),a1
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_55686
		lea	$10(a1),a1

locK_55686:
		move.b	(a1,d1.w),(Events_bg+$07).w
		tst.b	(_unkFAA9).w
		beq.s	locK_5569A
		st	(Events_bg+$0A).w
		clr.b	(_unkFAA9).w

locK_5569A:
		move.w	d0,(Camera_max_X_pos).w

locK_5569E:
		move.w	d0,(Camera_X_pos).w
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,d1
		lea	(Player_1).w,a1
		bsr.s	subK_556B8
		move.w	d1,d0
		lea	(Player_2).w,a1

; =============== S U B R O U T I N E =======================================


subK_556B8:
		cmpi.b	#5,anim(a1)
		bne.s	locK_556C4
		clr.b	anim(a1)

locK_556C4:
		addi.w	#$18,d0
		cmp.w	x_pos(a1),d0
		bls.s	locK_556E8
		move.w	d0,x_pos(a1)
		move.w	#$400,ground_vel(a1)
		cmpi.w	#3,(Player_mode).w
		bne.s	locretK_556F6
		move.w	#$500,ground_vel(a1)
		bra.s	locretK_556F6
; ---------------------------------------------------------------------------

locK_556E8:
		addi.w	#$A8,d0
		cmp.w	x_pos(a1),d0
		bhi.s	locretK_556F6
		move.w	d0,x_pos(a1)

locretK_556F6:
		rts
; End of function subK_556B8

; ---------------------------------------------------------------------------

locK_556F8:
		move.l	#locK_5576A,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#$18,width_pixels(a0)
		move.w	#$80,priority(a0)
		move.w	#make_art_tile(ArtTile_MHZEndBossPillar,3,1),art_tile(a0)
		move.l	#Map_MHZEndBossMisc,mappings(a0)
		move.w	#$4238,x_pos(a0)
		move.w	#$2F0,y_pos(a0)
		bra.s	locK_5576A
; ---------------------------------------------------------------------------

locK_55732:
		move.l	#locK_5576A,(a0)
		move.b	#$44,render_flags(a0)
		move.b	#$80,height_pixels(a0)
		move.b	#$C,width_pixels(a0)
		move.w	#$380,priority(a0)
		move.w	#make_art_tile(ArtTile_MHZEndBossPillar,3,0),art_tile(a0)
		move.l	#Map_MHZEndBossMisc,mappings(a0)
		move.w	#$300,y_pos(a0)
		move.b	#1,mapping_frame(a0)

locK_5576A:
		tst.b	(Events_bg+$01).w
		bne.s	locK_55776
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locK_55776:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_5577C:
		move.l	#locK_557C8,(a0)
		move.b	#$44,render_flags(a0)
		move.b	#$10,height_pixels(a0)
		move.b	#$10,width_pixels(a0)
		move.w	#make_art_tile(ArtTile_MHZEndBossSpikes,1,0),art_tile(a0)
		move.l	#Map_MHZEndBossMisc,mappings(a0)
		move.b	#$8B,collision_flags(a0)
		move.w	#$80,d0
		moveq	#4,d1
		move.w	$2E(a0),d2
		subq.w	#1,d2
		bcs.s	locK_557C0

locK_557B6:
		addi.w	#$80,d0
		subq.w	#1,d1
		dbf	d2,locK_557B6

locK_557C0:
		move.w	d0,priority(a0)
		move.b	d1,mapping_frame(a0)

locK_557C8:
		tst.w	(Events_bg+$0A).w
		bne.s	locK_557D4
		tst.b	(Events_bg+$01).w
		bne.s	locK_557DA

locK_557D4:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locK_557DA:
		move.w	(Events_bg+$06).w,d0
		tst.w	$30(a0)
		beq.s	locK_557EC
		cmpi.w	#4,d0
		bne.s	locretK_55812
		moveq	#0,d0

locK_557EC:
		lsl.w	#2,d0
		add.w	$2E(a0),d0
		add.w	d0,d0
		lea	wordK_558C2(pc),a1
		move.w	(a1,d0.w),y_pos(a0)
		jsr	(Draw_Sprite).l
		cmpi.w	#1,$2E(a0)
		bne.s	locretK_55812
		jmp	(Add_SpriteToCollisionResponseList).l
; ---------------------------------------------------------------------------

locretK_55812:
		rts
; ---------------------------------------------------------------------------

locK_55814:
		move.l	#locK_5582E,(a0)
		move.w	#$380,priority(a0)
		move.w	#make_art_tile(ArtTile_MHZShipPropeller,1,1),art_tile(a0)
		move.l	#Map_MHZEndBossMisc,mappings(a0)

locK_5582E:
		lea	Ani_MHZEndPropellers(pc),a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_5583E:
		addq.b	#1,$3C(a0)
		addi.l	#$C0,$38(a0)
		move.l	$38(a0),d0
		sub.l	d0,(_unkEE98).w
		tst.w	(Events_fg_4).w
		beq.s	locK_55876
		cmpi.l	#$2800,$2E(a0)
		bne.s	locK_55876
		move.w	$32(a0),d0
		move.b	$3C(a0),d1
		andi.w	#3,d1
		bne.s	locK_55888
		addq.w	#1,$32(a0)
		bra.s	locK_55888
; ---------------------------------------------------------------------------

locK_55876:
		move.l	#$2800,d0
		move.l	#$C0,d1
		jsr	(Gradual_SwingOffset).l

locK_55888:
		add.w	(_unkEEA2).w,d0
		addq.w	#5,d0
		move.w	d0,(_unkEE9C).w
		tst.b	(_unkFAA9).w
		bne.s	locK_558AC
		cmpi.w	#-$3E6,(_unkEE98).w
		bgt.s	locK_558AC
		st	(_unkFAA9).w
		st	(Events_fg_4).w
		st	(Scroll_lock).w

locK_558AC:
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	locretK_558C0
		moveq	#signextendB(sfx_LargeShip),d0
		jsr	(Play_SFX).l

locretK_558C0:
		rts
; ---------------------------------------------------------------------------
wordK_558C2:
		dc.w   $336
		dc.w   $334
		dc.w   $333
		dc.w      0
		dc.w   $320
		dc.w   $320
		dc.w   $320
		dc.w      0
		dc.w   $2F6
		dc.w   $2F8
		dc.w   $2FA
		dc.w      0
		dc.w   $2C9
		dc.w   $2CF
		dc.w   $2D4
		dc.w      0
		dc.w   $2C9
		dc.w   $2CF
		dc.w   $2D4
wordK_558E8:
		dc.w   $102
		dc.w      2
		dc.w   $102
		dc.w   $100
		dc.w   $200
		dc.w   $102
		dc.w   $102
		dc.w   $200
		dc.w   $102
		dc.w      3
		dc.w   $104
		dc.w   $200
		dc.w   $401
		dc.w   $304
		dc.w   $200
		dc.w   $402
Map_MHZEndBossMisc:
		include "Levels/MHZ/Misc Object Data/Map - End Boss Misc.asm"
Ani_MHZEndPropellers:
		include "Levels/MHZ/Misc Object Data/Anim - End Propellers.asm"