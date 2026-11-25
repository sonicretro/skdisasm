
; =============== S U B R O U T I N E =======================================


Handle_Onscreen_Water_Height:
		tst.b	(Water_flag).w    
		beq.w	locK_6C9C
		tst.b	(Deform_lock).w
		bne.s	locK_6C52
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	locK_6C52
		bsr.w	subK_6F4A
		bsr.w	DynamicWaterHeight
; loc3_50FC:
locK_6C52:
		clr.b	(Water_full_screen_flag).w
		moveq	#0,d0
		add.w	(Mean_water_level).w,d0
		move.w	d0,(Water_level).w
		cmpi.w	#$100,(Current_zone_and_act).w
		bne.s	locK_6C70
		cmpi.w	#$900,(Camera_X_pos).w
		blo.s	locK_6C86
; loc3_511A:
locK_6C70:
		move.w	(Water_level).w,d0
		sub.w	(Camera_Y_pos).w,d0
		beq.s	locK_6C80
		bcc.s	locK_6C8E
		tst.w	d0
		bpl.s	locK_6C8E
; loc3_512A:
locK_6C80:
		move.b	#1,(Water_full_screen_flag).w
; loc3_5130:
locK_6C86:
		move.b	#-1,(H_int_counter).w
		rts
; ---------------------------------------------------------------------------
; loc3_5138:
locK_6C8E:
		cmpi.w	#$DF,d0
		blo.s	locK_6C98
		move.w	#$FF,d0
; loc3_5142:
locK_6C98:
		move.b	d0,(H_int_counter).w
; loc3_5146:
locK_6C9C:
		bsr.w	subK_714E
		rts
; End of function Handle_Onscreen_Water_Height

; ---------------------------------------------------------------------------
		; unused
		clr.b	(Water_full_screen_flag).w
		move.w	(Mean_water_level).w,(Water_level).w
		move.l	#HInt3,(H_int_addr).w
		cmpi.w	#$1000,(V_blank_cycles).w
		blo.s	locK_6CC4
		move.l	#HInt4,(H_int_addr).w
; loc3_516E:
locK_6CC4:
		move.w	(Water_level).w,d0
		sub.w	(Camera_Y_pos).w,d0
		beq.s	locK_6CDC
		bcc.s	locK_6D18
		tst.w	d0
		bpl.s	locK_6D18
		addi.w	#$1E0,d0
		beq.s	locK_6CDC
		bcs.s	locK_6CEA
; loc3_5186:
locK_6CDC:
		move.b	#1,(Water_full_screen_flag).w
		move.b	#-1,(H_int_counter).w
		rts
; ---------------------------------------------------------------------------
; loc3_5194:
locK_6CEA:
		cmpi.w	#$DF,d0
		blo.s	locK_6CF4
		move.w	#$FF,d0
; loc3_519E:
locK_6CF4:
		move.b	d0,(H_int_counter).w
		move.b	#1,(Water_full_screen_flag).w
		move.l	#HInt5,(H_int_addr).w
		cmpi.w	#$1000,(V_blank_cycles).w
		blo.s	locK_6D16
		move.l	#HInt6,(H_int_addr).w
; loc3_51C0:
locK_6D16:
		bra.s	locK_6D26
; ---------------------------------------------------------------------------
; loc3_51C2:
locK_6D18:
		cmpi.w	#$DF,d0
		blo.s	locK_6D22
		move.w	#$FF,d0
; loc3_51CC:
locK_6D22:
		move.b	d0,(H_int_counter).w
; loc3_51D0:
locK_6D26:
		bsr.w	subK_714E
		rts
; ---------------------------------------------------------------------------

StartingWaterHeights:
		binclude "Levels/Misc/StartingWaterHeights.bin"
		even

; =============== S U B R O U T I N E =======================================


DynamicWaterHeight:
		moveq	#0,d0
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#6,d0
		andi.w	#$FFFE,d0
		move.w	DynamicWaterHeight_Index(pc,d0.w),d0
		jsr	DynamicWaterHeight_Index(pc,d0.w)
		moveq	#0,d1
		move.b	(Water_speed).w,d1
		move.w	(Target_water_level).w,d0
		sub.w	(Mean_water_level).w,d0
		beq.s	locretK_6D9A
		bcc.s	locK_6D96
		neg.w	d1
; loc3_5240:
locK_6D96:
		add.w	d1,(Mean_water_level).w
; locret3_5244:
locretK_6D9A:
		rts
; End of function DynamicWaterHeight

; ---------------------------------------------------------------------------

DynamicWaterHeight_Index:
		dc.w DynamicWaterHeight_AIZ1-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_AIZ2-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_HCZ1-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_HCZ2-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_LBZ1-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_LBZ2-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null2-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null2-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null2-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null2-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null2-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null2-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null2-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null2-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null2-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null2-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null2-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null2-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null2-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Ending-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null2-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null2-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null2-DynamicWaterHeight_Index
		dc.w DynamicWaterHeight_Null2-DynamicWaterHeight_Index
; ---------------------------------------------------------------------------

DynamicWaterHeight_AIZ1:
		rts
; ---------------------------------------------------------------------------

DynamicWaterHeight_AIZ2:
	if ~~Sonic3_Alone
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_6DF6
	endif
		cmpi.w	#$820,(Camera_target_max_Y_pos).w
		beq.s	locretK_6E6C
	if ~~Sonic3_Alone
		cmpi.w	#$3B60,(Camera_X_pos).w
		bhs.s	locretK_6E6C

locK_6DF6:
	endif
		cmpi.w	#$2440,(Camera_X_pos).w
		bhs.s	locK_6E14
		cmpi.w	#$618,(Target_water_level).w
		bne.s	locretK_6E6C
		move.w	#$528,(Target_water_level).w
		move.b	#2,(Water_speed).w
		rts
; ---------------------------------------------------------------------------
; loc3_52AE:
locK_6E14:
		tst.b	(Level_trigger_array).w
		bne.s	locK_6E28
		cmpi.w	#$2850,(Camera_X_pos).w
		blo.s	locretK_6E6C
		move.b	#1,(Level_trigger_array).w
; loc3_52C2:
locK_6E28:
		cmpi.w	#$618,(Target_water_level).w
		beq.s	locretK_6E6C
		cmpi.w	#$2900,(Camera_X_pos).w
		bhs.s	locK_6E52
		move.w	#-1,(Screen_shake_flag).w
		jsr	(AllocateObject).l
		bne.s	locK_6E52
		move.l	#Obj_6E6E,(a1)
		move.b	#180,anim_frame_timer(a1)
; loc3_52EC:
locK_6E52:
		lea	(Level_layout_main+$1C).w,a3
		moveq	#4-1,d1
; loc3_52F2:
locK_6E58:
		movea.w	(a3),a1
		move.b	#0,$4E(a1)
		addq.w	#4,a3
		dbf	d1,locK_6E58
		move.w	#$618,(Target_water_level).w
; locret3_5306:
locretK_6E6C:
		rts
; ---------------------------------------------------------------------------

Obj_6E6E:
		subq.b	#1,anim_frame_timer(a0)
		beq.s	locK_6E76
		rts
; ---------------------------------------------------------------------------
; loc3_5310:
locK_6E76:
		move.w	#0,(Screen_shake_flag).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

DynamicWaterHeight_HCZ1:
		lea	(wordK_6E8C).l,a1
	if Sonic3_Alone
		bra.s	locK_6F2C
	else
		bra.w	locK_6F2C
	endif
; ---------------------------------------------------------------------------
; word3_5324:
wordK_6E8C:
		dc.w  $8500,  $900
		dc.w  $8680, $2A00
		dc.w  $8680, $3500
		dc.w  $86A0, $FFFF
; ---------------------------------------------------------------------------

DynamicWaterHeight_HCZ2:
		tst.b	(_unkFAA2).w
		beq.s	locK_6EA4
		rts
; ---------------------------------------------------------------------------
; loc3_533C
locK_6EA4:
		lea	(wordK_6EBA).l,a1
	if ~~Sonic3_Alone
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_6F2C
		lea	(wordK_6EC2).l,a1
	endif
		bra.s	locK_6F2C
; ---------------------------------------------------------------------------
; word3_5344:
wordK_6EBA:
		dc.w   $700, $3E00
		dc.w   $7E0, $FFFF
	if ~~Sonic3_Alone
wordK_6EC2:
		dc.w   $700, $4100
		dc.w  $8360, $FFFF
	endif
; ---------------------------------------------------------------------------

DynamicWaterHeight_Null:
		rts
; ---------------------------------------------------------------------------

DynamicWaterHeight_LBZ1:
		lea	(wordK_6ED4).l,a1
		bra.s	locK_6F2C
; ---------------------------------------------------------------------------
; word3_5356:
wordK_6ED4:
		dc.w  $8B00,  $E00
		dc.w  $8A00, $1980
		dc.w  $8A00, $2340
		dc.w  $8AC8, $2C00
		dc.w  $8FF0, $FFFF
; ---------------------------------------------------------------------------

DynamicWaterHeight_LBZ2:
	if ~~Sonic3_Alone
		cmpi.w	#3,(Player_mode).w
		beq.s	locK_6EF2
		rts
; ---------------------------------------------------------------------------

locK_6EF2:
		tst.b	(_unkF7C2).w
		bne.s	locK_6F00
		lea	(wordK_6F12).l,a1
		bra.s	locK_6F2C
; ---------------------------------------------------------------------------

locK_6F00:
		move.w	(Camera_Y_pos).w,d0
		cmp.w	(Mean_water_level).w,d0
		blo.s	locretK_6F10
		move.w	#$660,(Mean_water_level).w

locretK_6F10:
		rts
; ---------------------------------------------------------------------------

wordK_6F12:
		dc.w  $8FF0,  $D80
		dc.w  $8B20, $FFFF
; ---------------------------------------------------------------------------
	endif

DynamicWaterHeight_Null2:
		rts
; ---------------------------------------------------------------------------

DynamicWaterHeight_Ending:
		cmpi.w	#$1DE0,(Camera_X_pos).w
		blo.s	locretK_6F2A
		move.w	#$510,(Target_water_level).w
; locret3_537A:
locretK_6F2A:
		rts
; ---------------------------------------------------------------------------
; loc3_537C:
locK_6F2C:
		move.w	(Camera_X_pos).w,d0
; loc3_5380:
locK_6F30:
		move.l	(a1)+,d1
		cmp.w	d1,d0
		bhi.s	locK_6F30
		swap	d1
		tst.w	d1
		bpl.s	locK_6F44
		andi.w	#$7FFF,d1
		move.w	d1,(Mean_water_level).w
; loc3_5394:
locK_6F44:
		move.w	d1,(Target_water_level).w
		rts

; =============== S U B R O U T I N E =======================================

; sub3_539A:
subK_6F4A:
		tst.w	(Debug_placement_mode).w
		bne.w	locretK_705A
		cmpi.b	#1,(Current_zone).w
		bne.w	locretK_705A
		cmpi.w	#2,(Player_mode).w
		beq.s	locK_6F82
		lea	(WindTunnel_flag).w,a3
		lea	(Player_1).w,a1
		move.b	(Ctrl_1_held_logical).w,d6
		moveq	#0,d5
		bsr.s	HCZ_WaterTunnels
		addq.w	#1,a3
		lea	(Player_2).w,a1
		move.b	(Ctrl_2_held_logical).w,d6
		moveq	#1,d5
		bra.s	HCZ_WaterTunnels
; ---------------------------------------------------------------------------
; loc3_53D2:
locK_6F82:
		lea	(WindTunnel_flag_P2).w,a3
		lea	(Player_1).w,a1
		move.b	(Ctrl_1_held_logical).w,d6
		moveq	#0,d5
; End of function subK_6F4A


; =============== S U B R O U T I N E =======================================


HCZ_WaterTunnels:
		lea	(HCZ1_WaterTunLocs).l,a2
		tst.b	(Current_act).w
		beq.s	locK_6FA2
		lea	(HCZ2_WaterTunLocs).l,a2
; loc3_53F2:
locK_6FA2:
		move.w	(a2)+,d2
; loc3_53F4:
locK_6FA4:
		move.w	x_pos(a1),d0
		cmp.w	(a2),d0
		blo.w	locK_7046
		cmp.w	4(a2),d0
		bhs.w	locK_7046
		move.w	y_pos(a1),d1
		cmp.w	2(a2),d1
		blo.w	locK_7046
		cmp.w	6(a2),d1
		bhs.s	locK_7046
		cmpi.b	#4,routine(a1)
		bhs.w	locK_7058
		btst	d5,(_unkF7C7).w
		bne.s	locretK_702E
		tst.b	object_control(a1)
		bne.s	locK_7058
		move.b	#1,(a3)
		move.w	8(a2),d0
		move.w	d0,x_vel(a1)
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,x_pos(a1)
		move.w	$A(a2),d1
		move.w	d1,y_vel(a1)
		ext.l	d1
		lsl.l	#8,d1
		add.l	d1,y_pos(a1)
		move.b	#$F,anim(a1)
		bset	#Status_InAir,status(a1)
	if ~~Sonic3_Alone
		move.b	#0,double_jump_flag(a1)
	endif
		tst.b	$C(a2)
		bne.s	locK_7030
		btst	#button_up,d6
		beq.s	locK_7024
		subq.w	#1,y_pos(a1)
; loc3_546E:
locK_7024:
		btst	#button_down,d6
		beq.s	locretK_702E
		addq.w	#1,y_pos(a1)
; locret3_5478:
locretK_702E:
		rts
; ---------------------------------------------------------------------------
; loc3_547A:
locK_7030:
		btst	#button_left,d6
		beq.s	locK_703A
		subq.w	#1,x_pos(a1)
; loc3_5484:
locK_703A:
		btst	#button_right,d6
		beq.s	locretK_7044
		addq.w	#1,x_pos(a1)
; locret3_548E:
locretK_7044:
		rts
; ---------------------------------------------------------------------------
; loc3_5490:
locK_7046:
		adda.w	#$E,a2
		dbf	d2,locK_6FA4
		tst.b	(a3)
		beq.s	locretK_705A
		move.b	#$1A,anim(a1)
; loc3_54A2:
locK_7058:
		clr.b	(a3)
; locret3_54A4:
locretK_705A:
		rts
; End of function HCZ_WaterTunnels

; ---------------------------------------------------------------------------
HCZ1_WaterTunLocs:
		dc.w $F-1
		dc.w   $380,  $580,  $5A0,  $5C0,  $3F0,  -$20,     0	; Min X, Min Y, Max X, Max Y, X Velo, Y Velo, Player can influence which axis flag (Set = X, Clear = Y)
		dc.w   $5A0,  $560,  $A80,  $5C0,  $3F0,  -$10,     0
		dc.w  $1400,  $A80, $15A0,  $AC0,  $400,     0,     0
		dc.w  $15A0,  $A40, $1960,  $AC0,  $400,  -$40,     0
		dc.w  $1990,  $780, $19E0,  $7F0,     0, -$400,  $100
		dc.w  $1990,  $7F0, $19F0,  $878, -$140, -$400,  $100
		dc.w  $1990,  $878, $19F0,  $8FD,  $140, -$400,  $100
		dc.w  $1990,  $8FD, $19F0,  $978, -$140, -$400,  $100
		dc.w  $1990,  $978, $19F0,  $A10,  $100, -$400,  $100
		dc.w  $1960,  $A10, $19D0,  $A80,  $300, -$280,  $100
		dc.w  $2B00,  $800, $2C20,  $840,  $400,     0,     0
		dc.w  $2C20,  $7C0, $2EE0,  $840,  $400,  -$40,     0
		dc.w  $2EE0,  $790, $2F50,  $800,  $300, -$300,  $100
		dc.w  $2F00,  $700, $2F70,  $790,  $100, -$400,  $100
		dc.w  $2F30,  $680, $2F70,  $700,     0, -$400,  $100
HCZ2_WaterTunLocs:
		dc.w 2-1
		dc.w  $3980,  $800, $3AA0,  $840,  $400,     0,     0
		dc.w  $3AA0,  $7C0, $3F00,  $840,  $400,  -$40,     0

; =============== S U B R O U T I N E =======================================

; sub3_5598:
subK_714E:
		cmpi.w	#$101,(Current_zone_and_act).w
		beq.s	locK_716A
		cmpi.w	#$500,(Current_zone_and_act).w
		beq.s	locK_71D2
	if ~~Sonic3_Alone
		cmpi.b	#8,(Current_zone).w
		beq.w	locK_72FA
	endif
		rts
; ---------------------------------------------------------------------------
; loc3_55AA:
locK_716A:
		lea	(Player_1).w,a1
		move.b	(Ctrl_1_held_logical).w,d2
		bsr.s	subK_717C
		lea	(Player_2).w,a1
		move.b	(Ctrl_2_held_logical).w,d2
; End of function subK_714E


; =============== S U B R O U T I N E =======================================

; sub3_55BC:
subK_717C:
		btst	#Status_InAir,status(a1)
		bne.s	locK_71B8
		cmpi.b	#$C,top_solid_bit(a1)
		beq.s	locK_71B8
		lea	(Level_layout_header).w,a2
		move.w	y_pos(a1),d0
		lsr.w	#5,d0
		and.w	(Layout_row_index_mask).w,d0
		move.w	8(a2,d0.w),d0
		move.w	x_pos(a1),d1
		lsr.w	#7,d1
		add.w	d1,d0
		movea.w	d0,a2
		move.b	(a2),d0
		lea	byteK_7498(pc),a2
		moveq	#(byteK_7498-byteK_748E)-1,d1
; loc3_55F0:
locK_71B0:
		cmp.b	-(a2),d0
		dbeq	d1,locK_71B0
		beq.s	locK_71CC
; loc3_55F8:
locK_71B8:
		tst.b	status_secondary(a1)
		bpl.s	locretK_71CA
		move.w	#5,move_lock(a1)
		andi.b	#$7F,status_secondary(a1)
; locret3_560A:
locretK_71CA:
		rts
; ---------------------------------------------------------------------------
; loc3_560C:
locK_71CC:
		moveq	#-8,d0
		bra.w	locK_723E
; End of function subK_717C

; ---------------------------------------------------------------------------
; loc3_5612:
locK_71D2:
		lea	(Player_1).w,a1
		move.b	(Ctrl_1_held_logical).w,d2
		bsr.s	subK_71E4
		lea	(Player_2).w,a1
		move.b	(Ctrl_2_held_logical).w,d2

; =============== S U B R O U T I N E =======================================

; sub3_5624:
subK_71E4:
		btst	#Status_InAir,status(a1)
		bne.s	locK_7220
		btst	#Status_OnObj,status(a1)
		bne.s	locK_7220
		lea	(Level_layout_header).w,a2
		move.w	y_pos(a1),d0
		lsr.w	#5,d0
		and.w	(Layout_row_index_mask).w,d0
		move.w	8(a2,d0.w),d0
		move.w	x_pos(a1),d1
		lsr.w	#7,d1
		add.w	d1,d0
		movea.w	d0,a2
		move.b	(a2),d0
	if Sonic3_Alone
		lea	WaterTransition_AIZ1(pc),a2
		moveq	#(WaterTransition_AIZ1-byteK_7498)-1,d1
	else
		lea	byteK_74A2(pc),a2
		moveq	#(byteK_74A2-byteK_7498)-1,d1
	endif
; loc3_5658:
locK_7218:
		cmp.b	-(a2),d0
		dbeq	d1,locK_7218
		beq.s	locK_7234
; loc3_5660:
locK_7220:
		tst.b	status_secondary(a1)
		bpl.s	locretK_7232
		move.w	#5,move_lock(a1)
		andi.b	#$7F,status_secondary(a1)
; locret3_5672:
locretK_7232:
		rts
; ---------------------------------------------------------------------------
; loc3_5674:
locK_7234:
		lea	(byteK_74A2).l,a2
		move.b	(a2,d1.w),d0
; loc3_567E:
locK_723E:
		beq.s	locK_728A
		move.b	ground_vel(a1),d1
		tst.b	d0
		bpl.s	locK_7254
		cmp.b	d0,d1
		ble.s	locK_725E
		subi.w	#$40,ground_vel(a1)
		bra.s	locK_725E
; ---------------------------------------------------------------------------
; loc3_5694:
locK_7254:
		cmp.b	d0,d1
		bge.s	locK_725E
		addi.w	#$40,ground_vel(a1)
; loc3_569E:
locK_725E:
		bclr	#Status_Facing,status(a1)
		tst.b	d1
		bpl.s	locK_726E
		bset	#Status_Facing,status(a1)
; loc3_56AE:
locK_726E:
		move.b	#$1B,anim(a1)
		cmpi.b	#5,(Current_zone).w
		bne.s	locK_7282
		move.b	#$19,anim(a1)
; loc3_56C2:
locK_7282:
		ori.b	#$80,status_secondary(a1)
		rts
; ---------------------------------------------------------------------------
; loc3_56CA:
locK_728A:
		move.w	#4,d1
		move.w	ground_vel(a1),d0
		btst	#button_left,d2
		beq.s	locK_72AC
		move.b	#0,anim(a1)
		bset	#Status_Facing,status(a1)
		sub.w	d1,d0
		tst.w	d0
		bpl.s	locK_72AC
		sub.w	d1,d0
; loc3_56EC:
locK_72AC:
		btst	#button_right,d2
		beq.s	locK_72C6
		move.b	#0,anim(a1)
		bclr	#Status_Facing,status(a1)
		add.w	d1,d0
		tst.w	d0
		bmi.s	locK_72C6
		add.w	d1,d0
; loc3_5706:
locK_72C6:
		move.w	#4,d1
		tst.w	d0
		beq.s	locK_72EE
		bmi.s	locK_72E0
		sub.w	d1,d0
		bhi.s	locK_72DE
		move.w	#0,d0
		move.b	#5,anim(a1)
; loc3_571E:
locK_72DE:
		bra.s	locK_72EE
; ---------------------------------------------------------------------------
; loc3_5720:
locK_72E0:
		add.w	d1,d0
		bhi.s	locK_72EE
		move.w	#0,d0
		move.b	#5,anim(a1)
; loc3_572E:
locK_72EE:
		move.w	d0,ground_vel(a1)
		ori.b	#$80,status_secondary(a1)
		rts
; End of function subK_71E4

	if ~~Sonic3_Alone
; ---------------------------------------------------------------------------

locK_72FA:
		lea	(Player_1).w,a1
		move.b	(Ctrl_1_logical).w,d2
		bsr.s	subK_730C
		lea	(Player_2).w,a1
		move.b	(Ctrl_2_logical).w,d2

; =============== S U B R O U T I N E =======================================


subK_730C:
		btst	#Status_InAir,status(a1)
		bne.s	locK_734A
		btst	#Status_OnObj,status(a1)
		bne.s	locK_734A
		lea	(Level_layout_header).w,a2
		moveq	#$14,d0
		add.w	y_pos(a1),d0
		lsr.w	#5,d0
		and.w	(Layout_row_index_mask).w,d0
		move.w	8(a2,d0.w),d0
		move.w	x_pos(a1),d1
		lsr.w	#7,d1
		add.w	d1,d0
		movea.w	d0,a2
		move.b	(a2),d0
		lea	byteK_74BD(pc),a2
		moveq	#(byteK_74BD-byteK_74AC)-1,d1

locK_7342:
		cmp.b	-(a2),d0
		dbeq	d1,locK_7342
		beq.s	locK_7384

locK_734A:
		tst.b	status_secondary(a1)
		bpl.s	locretK_7382
		move.w	#5,move_lock(a1)
		andi.b	#$7F,status_secondary(a1)
		btst	#Status_InAir,status(a1)
		bne.s	locretK_7382
		move.b	default_y_radius(a1),y_radius(a1)
		move.b	default_x_radius(a1),x_radius(a1)
		bclr	#Status_Roll,status(a1)
		bclr	#Status_RollJump,status(a1)
		move.b	#0,anim(a1)

locretK_7382:
		rts
; ---------------------------------------------------------------------------

locK_7384:
		add.w	d1,d1
		lea	(byteK_74BD).l,a2
		move.b	(a2,d1.w),d0
		move.b	1(a2,d1.w),d1
		bne.w	locK_7448

locK_7398:
		move.b	ground_vel(a1),d1
		tst.b	d0
		bpl.s	locK_73C8
		cmp.b	d0,d1
		ble.s	locK_73EE
		subi.w	#$40,ground_vel(a1)
		tst.b	status_secondary(a1)
		bmi.s	locK_73EE
		tst.w	ground_vel(a1)
		bmi.s	locK_73EE
		asr	ground_vel(a1)
		cmpi.b	#-8,d0
		bne.s	locK_73EE
		move.w	#0,ground_vel(a1)
		bra.s	locK_73EE
; ---------------------------------------------------------------------------

locK_73C8:
		cmp.b	d0,d1
		bge.s	locK_73EE
		addi.w	#$40,ground_vel(a1)
		tst.b	status_secondary(a1)
		bmi.s	locK_73EE
		tst.w	ground_vel(a1)
		bpl.s	locK_73EE
		asr	ground_vel(a1)
		cmpi.b	#8,d0
		bne.s	locK_73EE
		move.w	#0,ground_vel(a1)

locK_73EE:
		tst.b	d1
		beq.s	locK_7402
		bclr	#Status_Facing,status(a1)
		tst.b	d1
		bpl.s	locK_7402
		bset	#Status_Facing,status(a1)

locK_7402:
		move.b	#$19,anim(a1)
		move.b	y_radius(a1),d0
		subi.b	#$E,d0
		ext.w	d0
		add.w	d0,y_pos(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		bclr	#Status_Roll,status(a1)
		bclr	#Status_RollJump,status(a1)
		ori.b	#$80,status_secondary(a1)
		move.b	(V_int_run_count+3).w,d0
		andi.b	#$F,d0
		bne.s	locretK_7446
		moveq	#signextendB(sfx_SlideSkidQuiet),d0
		jsr	(Play_SFX).l

locretK_7446:
		rts
; ---------------------------------------------------------------------------

locK_7448:
		cmpi.b	#1,d1
		bne.s	locK_7462
		move.w	x_pos(a1),d1
		andi.w	#$7F,d1
		cmpi.w	#$40,d1
		blo.w	locK_7398
		bra.w	locK_734A
; ---------------------------------------------------------------------------

locK_7462:
		cmpi.b	#2,d1
		bne.s	locK_747C
		move.w	x_pos(a1),d1
		andi.w	#$7F,d1
		cmpi.w	#$40,d1
		bhs.w	locK_7398
		bra.w	locK_734A
; ---------------------------------------------------------------------------

locK_747C:
		moveq	#-8,d0
		cmpi.b	#$C,top_solid_bit(a1)
		beq.w	locK_7398
		moveq	#8,d0
		bra.w	locK_7398
; End of function subK_730C
	endif

; ---------------------------------------------------------------------------
	if Sonic3_Alone
; byte3_573A:
byteK_74A2:
		dc.b  $F8, $F8,   8,   8, $F4, $F4, $F4,  $C,  $C,  $C
	endif

; byte3_5744:
byteK_748E:
		dc.b  $1C, $72, $83, $84, $8B, $91, $9F, $A0, $A5, $A6

; byte3_574E:
byteK_7498:
		dc.b  $2E, $C6, $33, $C5, $24, $2A, $44, $1F, $27, $2B

	if ~~Sonic3_Alone
; byte3_573A:
byteK_74A2:
		dc.b  $F8, $F8,   8,   8, $F4, $F4, $F4,  $C,  $C,  $C

byteK_74AC:
		dc.b   $F, $13, $14, $15, $16, $17, $35, $6C, $6D, $76
		dc.b  $77, $7E, $7F, $85, $8A, $8C, $90

byteK_74BD:
		dc.b  $F8,   0, $F8,   0, $FA,   1, $FA,   2, $F8,   0, $F8,   0, $F8,   0,   6,   1,   0,   3,   6,   2
		dc.b    8,   0,   8,   0,   8,   0,   8,   0,   8,   0,   0,   3, $F8,   0,   0
	endif
		even
; ---------------------------------------------------------------------------
; Water palette transition tables

; These are used by HInt3 to load the water palette only a small bit at a time,
; this is to space out the CRAM writes to push the VDP dots offscreen.
;
; Each value is an offset into Water_palette.
; From there, 6 bytes, meaning 3 palette entries, are transferred to CRAM.
; ---------------------------------------------------------------------------

WaterTransition_AIZ1: watertransheader
		dc.w      2
		dc.w    $68
		dc.w    $62
		dc.w    $42
		dc.w    $48
		dc.w    $4E
		dc.w    $54
		dc.w      8
		dc.w     $E
		dc.w    $14
		dc.w    $1A
		dc.w    $34
		dc.w    $22
		dc.w    $3A
		dc.w    $2E
		dc.w    $28
WaterTransition_AIZ1_End

WaterTransition_AIZ2: watertransheader
		dc.w    $6E
		dc.w    $68
		dc.w      2
		dc.w    $48
		dc.w    $42
		dc.w    $4E
		dc.w    $5A
		dc.w    $54
		dc.w    $62
		dc.w    $74
		dc.w      8
		dc.w     $E
		dc.w    $14
		dc.w    $1A
		dc.w    $34
		dc.w    $22
		dc.w    $3A
		dc.w    $2E
		dc.w    $28
WaterTransition_AIZ2_End

WaterTransition_CNZ2ICZ2: watertransheader
		dc.w    $6E
		dc.w    $68
		dc.w    $7A
		dc.w    $74
		dc.w    $62
		dc.w      2
		dc.w    $42
		dc.w    $48
		dc.w    $4E
		dc.w    $5A
		dc.w      8
		dc.w     $E
		dc.w    $14
		dc.w    $1A
		dc.w    $34
		dc.w    $22
		dc.w    $3A
		dc.w    $2E
		dc.w    $28
		dc.w    $54
WaterTransition_CNZ2ICZ2_End

; Hydrocity Zone doesn't use this?
WaterTransition_HCZLBZ1: watertransheader
		dc.w      2
		dc.w    $74
		dc.w    $62
		dc.w    $68
		dc.w    $6E
		dc.w    $42
		dc.w    $48
		dc.w    $7A
		dc.w    $5A
		dc.w    $54
		dc.w      8
		dc.w     $E
		dc.w    $14
		dc.w    $1A
		dc.w    $2E
		dc.w    $34
		dc.w    $28
		dc.w    $3A
		dc.w    $22
		dc.w    $4E
WaterTransition_HCZLBZ1_End

WaterTransition_LBZ2: watertransheader
		dc.w      2
		dc.w    $6E
		dc.w    $68
		dc.w    $7A
		dc.w    $62
		dc.w    $74
		dc.w    $42
		dc.w    $48
		dc.w    $5A
		dc.w    $54
		dc.w      8
		dc.w     $E
		dc.w    $14
		dc.w    $1A
		dc.w    $2E
		dc.w    $34
		dc.w    $28
		dc.w    $3A
		dc.w    $22
		dc.w    $4E
WaterTransition_LBZ2_End

; Unknown and unused
WaterTransition_Unk: watertransheader
		dc.w      2
		dc.w      8
		dc.w     $E
		dc.w    $14
		dc.w    $1A
		dc.w    $42
		dc.w    $48
		dc.w    $4E
		dc.w    $54
		dc.w    $5A
		dc.w    $62
		dc.w    $68
		dc.w    $6E
		dc.w    $74
		dc.w    $7A
		dc.w    $22
		dc.w    $28
		dc.w    $2E
		dc.w    $34
		dc.w    $3A
WaterTransition_Unk_End