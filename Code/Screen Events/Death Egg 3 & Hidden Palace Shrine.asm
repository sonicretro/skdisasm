; ---------------------------------------------------------------------------

DEZ3_ScreenInit:
		clr.w	(Events_bg+$10).w
		st	(Events_bg+$12).w
		jsr	subK_5A79E(pc)
		move.w	(a3),d0
		move.w	d0,$10(a3)
		move.w	d0,$12(a3)
		move.w	d0,$7C(a3)
		move.w	d0,$7E(a3)
		lea	(Level_layout_main+$02).w,a3
		move.w	#VRAM_Plane_B_Name_Table,d7
		lea	(Level_layout_header).w,a1
		move.w	(a1),d0
		mulu.w	4(a1),d0
		move.w	2(a1),d1
		mulu.w	6(a1),d1
		add.w	d1,d0
		addi.w	#$88,d0
		adda.w	d0,a1
		move.w	#$1000-1,d1
		sub.w	d0,d1

locK_5A3FA:
		clr.b	(a1)+
		dbf	d1,locK_5A3FA
		jsr	(AllocateObject).l
		bne.s	locK_5A442
		move.l	#Obj_5A7C8,(a1)
		jsr	(CreateNewSprite4).l
		bne.s	locK_5A442
		move.l	#Obj_5A8E6,(a1)
		jsr	(CreateNewSprite4).l
		bne.s	locK_5A442
		move.l	#Obj_DEZ3_Boss,(a1)
		move.w	#$3C0,d0
		move.w	#$F8,d1
		move.w	d0,$10(a1)
		move.w	d1,$14(a1)
		move.w	d0,(Events_bg+$02).w
		move.w	d1,(Events_bg+$04).w

locK_5A442:
		move.w	#$6C0,(Events_bg+$00).w
		st	(Scroll_lock).w
		move.w	#$80,d0
		move.w	d0,(Camera_X_pos).w
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d0,(Events_bg+$16).w
		jsr	subK_5A508(pc)
		jsr	(Reset_TileOffsetPositionActual).l
		lea	(HScroll_table).w,a1
		clr.l	(a1)+
		move.w	(a1)+,(a1)
		andi.w	#$FFF0,(a1)+
		clr.w	(a1)
		lea	DEZ3_BGDrawArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	(Refresh_PlaneTileDeform).l
; ---------------------------------------------------------------------------

DEZ3_ScreenEvent:
		lea	(Level_layout_main+$02).w,a3
		move.w	#VRAM_Plane_B_Name_Table,d7
		move.w	(Events_routine_fg).w,d0
		jmp	DEZ3_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

DEZ3_ScreenEvent_Index:
		bra.w	locK_5A49A
; ---------------------------------------------------------------------------
		bra.w	locK_5A4C4
; ---------------------------------------------------------------------------

locK_5A49A:
		move.w	(Act3_ring_count).w,d0
		beq.s	locK_5A4AE
		clr.w	(Act3_ring_count).w
		move.w	d0,(Ring_count).w
		move.b	#1,(Update_HUD_ring_count).w

locK_5A4AE:
		move.l	(Act3_timer).w,d0
		beq.s	locK_5A4C0
		clr.l	(Act3_timer).w
		move.l	d0,(Timer).w
		st	(Update_HUD_timer).w

locK_5A4C0:
		addq.w	#4,(Events_routine_fg).w

locK_5A4C4:
		jsr	subK_5A508(pc)
		lea	DEZ3_BGDrawArray(pc),a4
		lea	(HScroll_table).w,a6
		moveq	#2,d5
		move.w	(Camera_Y_pos_rounded).w,d6
		jsr	(Draw_BGNoVert).l
		move.w	(Events_bg+$06).w,d1
		beq.s	locretK_5A506
		clr.w	(Events_bg+$06).w
		move.w	#$1E0,d0
		and.w	d0,d1
		moveq	#2,d6
		moveq	#2-1,d2

locK_5A4F0:
		movem.w	d0-d2/d6,-(sp)
		jsr	(Setup_TileRowDraw).l
		movem.w	(sp)+,d0-d2/d6
		addi.w	#$10,d0
		dbf	d2,locK_5A4F0

locretK_5A506:
		rts

; =============== S U B R O U T I N E =======================================


subK_5A508:
		moveq	#$20,d0
		add.w	(Screen_shake_offset).w,d0
		move.w	d0,(Camera_Y_pos_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		move.w	d0,(HScroll_table+$00A).w
		andi.w	#$1FF,d0
		move.w	d0,(HScroll_table+$004).w
		rts
; End of function subK_5A508

; ---------------------------------------------------------------------------
DEZ3_BGDrawArray:
		dc.w    $E0, $7FFF
; ---------------------------------------------------------------------------

DEZ3_BackgroundInit:
		lea	(Level_layout_main).w,a3
		move.w	#VRAM_Plane_A_Name_Table,d7
		jsr	subK_5A76C(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		bra.w	locK_5A734
; ---------------------------------------------------------------------------

DEZ3_BackgroundEvent:
		lea	(Level_layout_main).w,a3
		move.w	#VRAM_Plane_A_Name_Table,d7
		jsr	subK_5A76C(pc)
		move.w	(Events_routine_bg).w,d0
		jmp	DEZ3_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

DEZ3_BackgroundEvent_Index:
		bra.w	locK_5A57C
; ---------------------------------------------------------------------------
		bra.w	locK_5A5B0
; ---------------------------------------------------------------------------
		bra.w	locK_5A5E0
; ---------------------------------------------------------------------------
		bra.w	locK_5A606
; ---------------------------------------------------------------------------
		bra.w	locK_5A61A
; ---------------------------------------------------------------------------
		bra.w	locK_5A662
; ---------------------------------------------------------------------------
		bra.w	locK_5A676
; ---------------------------------------------------------------------------
		bra.w	locK_5A71A
; ---------------------------------------------------------------------------
		bra.w	locK_5A72E
; ---------------------------------------------------------------------------

locK_5A57C:
		move.b	#1,(Update_HUD_life_count).w
		tst.w	(Events_fg_5).w
		beq.w	locK_5A72E
		clr.w	(Events_fg_5).w
		movea.w	8(a3),a1
		move.b	#$1A,$D(a1)
		move.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	(Camera_X_pos_BG_copy).w,d1
		moveq	#$15,d6
		jsr	(Refresh_PlaneDirect).l
		addq.w	#4,(Events_routine_bg).w
		bra.w	locK_5A734
; ---------------------------------------------------------------------------

locK_5A5B0:
		tst.w	(Screen_shake_flag).w
		beq.w	locK_5A72E
		jsr	(AllocateObject).l
		bne.s	locK_5A5DC
		move.l	#Obj_5A922,(a1)
		move.w	#$13,$2E(a1)
		move.w	#$2D0,$30(a1)
		move.w	#$2C0,(Events_bg+$16).w
		addq.w	#4,(Events_routine_bg).w

locK_5A5DC:
		bra.w	locK_5A72E
; ---------------------------------------------------------------------------

locK_5A5E0:
		cmpi.w	#$6C0,(Events_bg+$00).w
		beq.w	locK_5A72E
		jsr	(Reset_TileOffsetPositionEff).l
		move.w	#$F0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		move.w	(_unkEE8E).w,(Events_bg+$0C).w
		addq.w	#4,(Events_routine_bg).w

locK_5A606:
		moveq	#0,d1
		moveq	#0,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	locK_5A61A
		clr.w	(Events_bg+$0C).w
		addq.w	#4,(Events_routine_bg).w

locK_5A61A:
		cmpi.w	#$2C0,(Events_bg+$00).w
		beq.w	locK_5A72E
		jsr	(Reset_TileOffsetPositionEff).l
		move.w	#$F0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		move.w	(_unkEE8E).w,(Events_bg+$0C).w
		jsr	(AllocateObject).l
		bne.s	locK_5A65E
		move.l	#Obj_5A94C,(a1)
		move.w	(Camera_X_pos_copy).w,d0
		andi.w	#$FFE0,d0
		move.w	d0,(Events_bg+$16).w
		subi.w	#$10,d0
		move.w	d0,$30(a1)

locK_5A65E:
		addq.w	#4,(Events_routine_bg).w

locK_5A662:
		moveq	#0,d1
		moveq	#0,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	locK_5A676
		clr.w	(Events_bg+$0C).w
		addq.w	#4,(Events_routine_bg).w

locK_5A676:
		tst.w	(Events_bg+$00).w
		beq.w	locK_5A6FE
		jsr	subK_5A79E(pc)
		tst.w	(Events_fg_5).w
		beq.w	locK_5A72E
		clr.w	(Events_fg_5).w
		move.w	(Events_bg+$0A).w,d0
		jmp	locK_5A696(pc,d0.w)
; ---------------------------------------------------------------------------

locK_5A696:
		bra.s	locK_5A69E
; ---------------------------------------------------------------------------
		bra.s	locK_5A6A4
; ---------------------------------------------------------------------------
		bra.s	locK_5A69E
; ---------------------------------------------------------------------------
		bra.s	locK_5A6AA
; ---------------------------------------------------------------------------

locK_5A69E:
		move.w	#$603,d0
		bra.s	locK_5A6B4
; ---------------------------------------------------------------------------

locK_5A6A4:
		move.w	#$903,d0
		bra.s	locK_5A6B4
; ---------------------------------------------------------------------------

locK_5A6AA:
		move.w	#$807,d0
		move.w	#-2,(Events_bg+$0A).w

locK_5A6B4:
		addq.w	#2,(Events_bg+$0A).w
		movea.w	8(a3),a1
		move.b	d0,$E(a1)
		lsr.w	#8,d0
		movea.w	$C(a3),a1
		move.b	d0,$E(a1)
		move.w	#$700,d1
		move.w	#$160,d0
		moveq	#8,d6
		moveq	#9,d2
		move.w	(Camera_Y_pos_BG_copy).w,d3
		andi.w	#$FFF0,d3
		addi.w	#$E0,d3

locK_5A6E2:
		movem.w	d0-d3/d6,-(sp)
		jsr	(Setup_TileRowDraw).l
		movem.w	(sp)+,d0-d3/d6
		addi.w	#$10,d0
		cmp.w	d3,d0
		bhi.s	locK_5A6FC
		dbf	d2,locK_5A6E2

locK_5A6FC:
		bra.s	locK_5A72E
; ---------------------------------------------------------------------------

locK_5A6FE:
		jsr	(Reset_TileOffsetPositionEff).l
		move.w	#$F0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		move.w	(_unkEE8E).w,(Events_bg+$0C).w
		addq.w	#4,(Events_routine_bg).w

locK_5A71A:
		moveq	#0,d1
		moveq	#0,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	locK_5A72E
		clr.w	(Events_bg+$0C).w
		addq.w	#4,(Events_routine_bg).w

locK_5A72E:
		jsr	(DrawBGAsYouMove).l

locK_5A734:
		lea	DEZ3_BGDrawArray(pc),a4
		lea	(HScroll_table+$008).w,a5
		lea	(H_scroll_buffer).w,a1
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Events_bg+$0C).w,d3
		bne.s	locK_5A74E
		move.w	(Camera_X_pos_BG_copy).w,d3

locK_5A74E:
		move.w	#$E0-1,d1
		jsr	(ApplyDeformation2).l
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp
		jmp	(ShakeScreen_Setup).l

; =============== S U B R O U T I N E =======================================


subK_5A76C:
		move.w	(Camera_X_pos_BG_copy).w,(_unkEE8E).w
		tst.w	(Events_bg+$00).w
		bne.s	locK_5A77C
		moveq	#0,d0
		bra.s	locK_5A788
; ---------------------------------------------------------------------------

locK_5A77C:
		move.w	(Camera_X_pos_copy).w,d0
		sub.w	(Events_bg+$02).w,d0
		add.w	(Events_bg+$00).w,d0

locK_5A788:
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	(Camera_Y_pos_copy).w,d0
		sub.w	(Events_bg+$04).w,d0
		addi.w	#$180,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		rts
; End of function subK_5A76C


; =============== S U B R O U T I N E =======================================


subK_5A79E:
		moveq	#0,d1
		move.w	(Events_bg+$10).w,d1
		cmp.w	(Events_bg+$12).w,d1
		beq.s	locretK_5A7C6
		move.w	d1,(Events_bg+$12).w
		addq.w	#2,d1
		lsl.w	#2,d1
		addi.l	#ArtUnc_DEZFBLaser,d1
		move.w	#tiles_to_bytes($208),d2
		move.w	#$40,d3
		jsr	(Add_To_DMA_Queue).l

locretK_5A7C6:
		rts
; End of function subK_5A79E

; ---------------------------------------------------------------------------

Obj_5A7C8:
		move.l	#locK_5A7EC,(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$130,x_pos(a0)
		move.w	#$F0,y_pos(a0)
		bset	#7,status(a0)
		move.w	#$80,$2E(a0)

locK_5A7EC:
		cmpi.b	#$17,(Current_zone).w
		beq.s	locK_5A7FA
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locK_5A7FA:
		move.w	(Events_bg+$08).w,d1
		beq.s	locK_5A83C
		clr.w	(Events_bg+$08).w
		cmp.w	(Events_bg+$16).w,d1
		blo.s	locK_5A83C
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locK_5A82C
		move.l	#Obj_5A872,(a1)
		move.w	d1,x_pos(a1)
		move.w	$2E(a0),d2
		subi.w	#$20,d2
		cmp.w	d1,d2
		bhi.s	locK_5A82C
		move.w	d1,(Events_bg+$06).w

locK_5A82C:
		moveq	#$20,d0
		add.w	d0,(Events_bg+$16).w
		cmp.w	$2E(a0),d1
		blo.s	locK_5A83C
		add.w	d0,x_pos(a0)

locK_5A83C:
		moveq	#-$20,d1
		move.w	(Camera_X_pos_copy).w,d0
		andi.w	#$FFE0,d0
		move.w	$2E(a0),d2
		cmp.w	d2,d0
		beq.s	locK_5A860
		bcs.s	locK_5A858
		cmp.w	(Events_bg+$16).w,d2
		blo.s	locK_5A85C
		neg.w	d1

locK_5A858:
		add.w	d1,x_pos(a0)

locK_5A85C:
		move.w	d0,$2E(a0)

locK_5A860:
		move.w	#$B0,d1
		moveq	#$10,d2
		moveq	#$10,d3
		move.w	x_pos(a0),d4
		jmp	(SolidObjectTop).l
; ---------------------------------------------------------------------------

Obj_5A872:
		move.l	#locK_5A8B2,(a0)
		move.b	#$84,render_flags(a0)
		move.b	#$10,height_pixels(a0)
		move.b	#$C,width_pixels(a0)
		move.w	#$80,priority(a0)
		move.w	#make_art_tile($001,2,1),art_tile(a0)
		move.l	#Map_DEZ3Blocks,mappings(a0)
		move.w	#$F0,y_pos(a0)
		move.w	x_pos(a0),d0
		andi.w	#$60,d0
		lsr.w	#5,d0
		move.b	d0,mapping_frame(a0)

locK_5A8B2:
		tst.b	render_flags(a0)
		bmi.s	locK_5A8C4
		move.w	(Camera_X_pos_coarse_back).w,d0
		addi.w	#$400,d0
		move.w	d0,x_pos(a0)

locK_5A8C4:
		jsr	(MoveSprite2).l
		addi.w	#$1A,y_vel(a0)
		moveq	#$10,d1
		moveq	#$10,d2
		moveq	#$10,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

Obj_5A8E6:
		move.l	#locK_5A904,(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$40,x_pos(a0)
		move.w	#$F0,y_pos(a0)
		bset	#7,status(a0)

locK_5A904:
		cmpi.w	#$6C0,(Events_bg+$00).w
		beq.s	locK_5A912
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locK_5A912:
		moveq	#$40,d1
		moveq	#$10,d2
		moveq	#$10,d3
		move.w	x_pos(a0),d4
		jmp	(SolidObjectTop).l
; ---------------------------------------------------------------------------

Obj_5A922:
		subq.w	#1,$32(a0)
		bpl.s	locretK_5A94A
		move.w	#$10-1,$32(a0)
		move.w	$30(a0),(Events_bg+$08).w
		addi.w	#$20,$30(a0)
		subq.w	#1,$2E(a0)
		bne.s	locretK_5A94A
		clr.w	(Screen_shake_flag).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locretK_5A94A:
		rts
; ---------------------------------------------------------------------------

Obj_5A94C:
		cmpi.b	#$17,(Current_zone).w
		beq.s	locK_5A95A
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locK_5A95A:
		tst.w	(Events_bg+$00).w
		bne.s	locK_5A97C
		move.w	(Camera_X_pos_copy).w,d0
		addi.w	#$9C,d0
		cmp.w	$30(a0),d0
		blo.s	locretK_5A9AA
		move.w	$30(a0),(Events_bg+$08).w
		addi.w	#$20,$30(a0)
		bra.s	locretK_5A9AA
; ---------------------------------------------------------------------------

locK_5A97C:
		cmpi.w	#$110,(Events_bg+$04).w
		bhs.s	locretK_5A9AA
		subq.w	#1,$32(a0)
		bpl.s	locretK_5A9AA
		move.w	(Events_bg+$02).w,d0
		addi.w	#$90,d0
		cmp.w	$30(a0),d0
		blo.s	locretK_5A9AA
		move.w	$30(a0),(Events_bg+$08).w
		addi.w	#$20,$30(a0)
		move.w	#$D,$32(a0)

locretK_5A9AA:
		rts
; ---------------------------------------------------------------------------
Map_DEZ3Blocks:
		include "Levels/DEZ/Misc Object Data/Map - Act 3 Blocks.asm"
; ---------------------------------------------------------------------------

HPZS_ScreenInit:
		tst.b	(Chaos_emerald_count).w
		beq.s	locK_5AA14
		move.b	(Current_special_stage).w,d0
		ori.b	#$80,d0
		move.b	d0,(HPZ_current_special_stage).w

locK_5AA14:
		movea.w	$10(a3),a1
		clr.b	$29(a1)
		clr.b	$2B(a1)
		movea.w	$14(a3),a1
		clr.b	$29(a1)
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

HPZS_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

HPZS_BackgroundInit:
		jsr	subK_5A334(pc)
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

HPZS_BackgroundEvent:
		jsr	subK_5A334(pc)
		lea	HPZ_BGDrawArray(pc),a4
		lea	(HScroll_table).w,a5
		moveq	#$20,d6
		moveq	#2,d5
		jsr	(Draw_BG).l
		lea	HPZ_BGDeformArray(pc),a4
		lea	(HScroll_table+$008).w,a5
		jsr	(ApplyDeformation).l
		jmp	(ShakeScreen_Setup).l