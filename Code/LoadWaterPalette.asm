
; =============== S U B R O U T I N E =======================================


CheckLevelForWater:
	if Sonic3_Alone
		cmpi.b	#0,(Current_zone).w
		beq.s	locK_78F2
	else
		cmpi.w	#0,(Current_zone_and_act).w
		beq.s	locK_78F2
		cmpi.w	#1,(Current_zone_and_act).w
		bne.s	locK_78B2
		cmpi.w	#1,(Apparent_zone_and_act).w
		bne.s	locK_78F2
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_78F2

locK_78B2:
	endif
		cmpi.b	#1,(Current_zone).w
		beq.s	locK_78F2
		cmpi.w	#$301,(Current_zone_and_act).w
	if Sonic3_Alone
		beq.s	locK_78F2
	else
		bne.s	locK_78CA
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_78F2

locK_78CA:
	endif
		cmpi.w	#$501,(Current_zone_and_act).w
		beq.s	locK_78F2
		cmpi.w	#$601,(Current_zone_and_act).w
	if Sonic3_Alone
		bne.s	loc3_5ED4
	else
		beq.s	locK_78F2
		move.w	#$1000,d0
		move.w	d0,(Water_level).w
		move.w	d0,(Mean_water_level).w
		move.w	d0,(Target_water_level).w
		move.b	#0,(Water_flag).w
		rts
; ---------------------------------------------------------------------------
	endif
; loc3_5EC8:
locK_78F2:
		move.b	#1,(Water_flag).w
		move.w	#0,(Competition_mode).w

loc3_5ED4:
		tst.b	(Water_flag).w
		beq.s	LoadWaterPalette
		move.w	#$4EF9,(H_int_jump).w
		move.l	#HInt2,(H_int_addr).w
		cmpi.b	#1,(Current_zone).w
		beq.s	locK_7932
		move.l	#HInt3,(H_int_addr).w
		cmpi.w	#$1000,(V_blank_cycles).w
		blo.s	locK_7932
		move.l	#HInt4,(H_int_addr).w
; loc3_5F08:
locK_7932:
		move.l	#WaterTransition_AIZ1,(Water_palette_data_addr).w
		moveq	#0,d0
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#6,d0
		andi.w	#$FFFE,d0
		lea	(StartingWaterHeights).l,a1
		move.w	(a1,d0.w),d0
		move.w	d0,(Water_level).w
		move.w	d0,(Mean_water_level).w
		move.w	d0,(Target_water_level).w
		clr.b	(Water_entered_counter).w
		clr.b	(Water_full_screen_flag).w
		move.b	#1,(Water_speed).w
; End of function CheckLevelForWater


; =============== S U B R O U T I N E =======================================


LoadWaterPalette:
		tst.b	(Water_flag).w
		beq.w	locretK_7A20
		moveq	#PalID_AIZ_Water,d0
		cmpi.w	#0,(Current_zone_and_act).w
		beq.w	locK_7A00
		moveq	#PalID_AIZ2_Water,d0
		move.l	#WaterTransition_AIZ2,(Water_palette_data_addr).w
		cmpi.w	#1,(Current_zone_and_act).w
		beq.s	locK_7A00
		moveq	#PalID_HCZ1_Water,d0
		move.l	#WaterTransition_HCZLBZ1,(Water_palette_data_addr).w
		cmpi.w	#$100,(Current_zone_and_act).w
		beq.s	locK_7A00
		moveq	#PalID_HCZ2_Water,d0
		move.l	#WaterTransition_HCZLBZ1,(Water_palette_data_addr).w
		cmpi.w	#$101,(Current_zone_and_act).w
		beq.s	locK_7A00
		moveq	#PalID_CNZ_Water,d0
		move.l	#WaterTransition_CNZ2ICZ2,(Water_palette_data_addr).w
		cmpi.w	#$301,(Current_zone_and_act).w
		beq.s	locK_7A00
		moveq	#PalID_ICZ2_Water,d0
		move.l	#WaterTransition_CNZ2ICZ2,(Water_palette_data_addr).w
		cmpi.w	#$501,(Current_zone_and_act).w
		beq.s	locK_7A00
		moveq	#PalID_LBZ_Water,d0
		move.l	#WaterTransition_HCZLBZ1,(Water_palette_data_addr).w
		cmpi.w	#$600,(Current_zone_and_act).w
		beq.s	locK_7A00
		moveq	#PalID_LBZ2_Water,d0
		move.l	#WaterTransition_LBZ2,(Water_palette_data_addr).w
		cmpi.w	#$601,(Current_zone_and_act).w
		beq.s	locK_7A00
		nop

locK_7A00:
		move.w	d0,d1
		bsr.w	LoadPalette2
		move.w	d1,d0
		bsr.w	LoadPalette2_Immediate
		tst.b	(Last_star_post_hit).w
		beq.s	locK_7A18
		move.b	(Saved_water_full_screen_flag).w,(Water_full_screen_flag).w

locK_7A18:
	if ~~Sonic3_Alone
		cmpi.w	#3,(Player_mode).w
		beq.s	locK_7A22
	endif
; locret3_5FEE:
locretK_7A20:
		rts
; End of function LoadWaterPalette

	if ~~Sonic3_Alone
; ---------------------------------------------------------------------------

locK_7A22:
		moveq	#0,d0
		move.b	(Current_zone).w,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		add.w	d0,d0
		lea	Pal_WaterKnux(pc,d0.w),a1
		move.l	(a1),(Water_palette+$4).w
		move.w	4(a1),(Water_palette+$8).w
		move.l	(a1),(Target_water_palette+$4).w
		move.w	4(a1),(Target_water_palette+$8).w
		rts
; ---------------------------------------------------------------------------

Pal_WaterKnux:
		binclude "Levels/Misc/Palettes/Water Knuckles Patch.bin"
		even
	endif