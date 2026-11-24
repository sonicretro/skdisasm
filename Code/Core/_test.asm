; ---------------------------------------------------------------------------

LevelSetup:
		clr.b	(Background_collision_flag).w
		bclr	#7,(Disable_wall_grab).w
		clr.l	(Plane_double_update_flag).w
		clr.w	(Special_events_routine).w
		clr.l	(Level_repeat_offset).w
		clr.l	(Events_routine_fg).w
		clr.l	(Events_fg_4).w
		clr.w	(Screen_shake_flag).w
		clr.l	(Screen_shake_offset).w
		clr.l	(Plane_buffer_2_addr).w
		clr.l	(Glide_screen_shake).w
		clr.w	(HPZ_special_stage_completed).w
		clr.w	(_unkFAC0).w
		clr.w	(HPZ_current_special_stage).w
		clr.w	(Palette_fade_timer).w
		clr.l	(Events_bg+$00).w
		clr.l	(Events_bg+$04).w
		clr.l	(Events_bg+$08).w
		clr.l	(Events_bg+$0C).w
		move.w	#$FFF,(Screen_Y_wrap_value).w
		move.w	#$FF0,(Camera_Y_pos_mask).w
		move.w	#$7C,(Layout_row_index_mask).w
		move.w	(Camera_X_pos).w,(Camera_X_pos_copy).w
		move.w	(Camera_Y_pos).w,(Camera_Y_pos_copy).w
		lea	(Plane_buffer).w,a0
		lea	(Block_table).w,a2
		lea	(Level_layout_main).w,a3
		move.w	#VRAM_Plane_A_Name_Table,d7
		move.w	(Current_zone_and_act).w,d0
		ror.b	#2,d0
		lsr.w	#3,d0
		movea.l	LevelSetupArray(pc,d0.w),a1
		jsr	(a1)
		addq.w	#2,a3
		move.w	#VRAM_Plane_B_Name_Table,d7
		move.w	(Current_zone_and_act).w,d0
		ror.b	#2,d0
		lsr.w	#3,d0
		movea.l	LevelSetupArray+4(pc,d0.w),a1
		jsr	(a1)
		move.w	(Camera_Y_pos_copy).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		rts

; =============== S U B R O U T I N E =======================================


ScreenEvents:
		move.w	(Camera_X_pos).w,(Camera_X_pos_copy).w
		move.w	(Camera_Y_pos).w,(Camera_Y_pos_copy).w
		jsr	ShakeScreen_BG(pc)
		lea	(Plane_buffer).w,a0
		lea	(Block_table).w,a2
		lea	(Level_layout_main).w,a3
		move.w	#VRAM_Plane_A_Name_Table,d7
		move.w	(Current_zone_and_act).w,d0
		ror.b	#2,d0
		lsr.w	#3,d0
		movea.l	LevelEventArray(pc,d0.w),a1
		jsr	(a1)
		addq.w	#2,a3
		move.w	#VRAM_Plane_B_Name_Table,d7
		move.w	(Current_zone_and_act).w,d0
		ror.b	#2,d0
		lsr.w	#3,d0
		movea.l	LevelEventArray+4(pc,d0.w),a1
		jsr	(a1)
		move.w	(Camera_Y_pos_copy).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		rts
; End of function ScreenEvents

; ---------------------------------------------------------------------------
LevelSetupArray:dc.l	AIZ1_ScreenInit,	AIZ1_BackgroundInit
		dc.l	AIZ2_ScreenInit,	AIZ2_BackgroundInit
LevelEventArray:dc.l	AIZ1_ScreenEvent,	AIZ1_BackgroundEvent
		dc.l	AIZ2_ScreenEvent,	AIZ2_BackgroundEvent
		dc.l	HCZ1_ScreenInit,	HCZ1_BackgroundInit
		dc.l	HCZ2_ScreenInit,	HCZ2_BackgroundInit
		dc.l	HCZ1_ScreenEvent,	HCZ1_BackgroundEvent
		dc.l	HCZ2_ScreenEvent,	HCZ2_BackgroundEvent
		dc.l	MGZ1_ScreenInit,	MGZ1_BackgroundInit
		dc.l	MGZ2_ScreenInit,	MGZ2_BackgroundInit
		dc.l	MGZ1_ScreenEvent,	MGZ1_BackgroundEvent
		dc.l	MGZ2_ScreenEvent,	MGZ2_BackgroundEvent
		dc.l	CNZ1_ScreenInit,	CNZ1_BackgroundInit
		dc.l	CNZ2_ScreenInit,	CNZ2_BackgroundInit
		dc.l	CNZ1_ScreenEvent,	CNZ1_BackgroundEvent
		dc.l	CNZ2_ScreenEvent,	CNZ2_BackgroundEvent
		dc.l	FBZ1_ScreenInit,	FBZ1_BackgroundInit
		dc.l	FBZ2_ScreenInit,	FBZ2_BackgroundInit
		dc.l	FBZ1_ScreenEvent,	FBZ1_BackgroundEvent
		dc.l	FBZ2_ScreenEvent,	FBZ2_BackgroundEvent
		dc.l	ICZ1_ScreenInit,	ICZ1_BackgroundInit
		dc.l	ICZ2_ScreenInit,	ICZ2_BackgroundInit
		dc.l	ICZ1_ScreenEvent,	ICZ1_BackgroundEvent
		dc.l	ICZ2_ScreenEvent,	ICZ2_BackgroundEvent
		dc.l	LBZ1_ScreenInit,	LBZ1_BackgroundInit
		dc.l	LBZ2_ScreenInit,	LBZ2_BackgroundInit
		dc.l	LBZ1_ScreenEvent,	LBZ1_BackgroundEvent
		dc.l	LBZ2_ScreenEvent,	LBZ2_BackgroundEvent
		dc.l	MHZ1_ScreenInit,	MHZ1_BackgroundInit
		dc.l	MHZ2_ScreenInit,	MHZ2_BackgroundInit
		dc.l	MHZ1_ScreenEvent,	MHZ1_BackgroundEvent
		dc.l	MHZ2_ScreenEvent,	MHZ2_BackgroundEvent
		dc.l	SOZ1_ScreenInit,	SOZ1_BackgroundInit
		dc.l	SOZ2_ScreenInit,	SOZ2_BackgroundInit
		dc.l	SOZ1_ScreenEvent,	SOZ1_BackgroundEvent
		dc.l	SOZ2_ScreenEvent,	SOZ2_BackgroundEvent
		dc.l	LRZ1_ScreenInit,	LRZ1_BackgroundInit
		dc.l	LRZ2_ScreenInit,	LRZ2_BackgroundInit
		dc.l	LRZ1_ScreenEvent,	LRZ1_BackgroundEvent
		dc.l	LRZ2_ScreenEvent,	LRZ2_BackgroundEvent
		dc.l	SSZ1_ScreenInit,	SSZ1_BackgroundInit
		dc.l	SSZ2_ScreenInit,	SSZ2_BackgroundInit
		dc.l	SSZ1_ScreenEvent,	SSZ1_BackgroundEvent
		dc.l	SSZ2_ScreenEvent,	SSZ2_BackgroundEvent
		dc.l	DEZ1_ScreenInit,	DEZ1_BackgroundInit
		dc.l	DEZ2_ScreenInit,	DEZ2_BackgroundInit
		dc.l	DEZ1_ScreenEvent,	DEZ1_BackgroundEvent
		dc.l	DEZ2_ScreenEvent,	DEZ2_BackgroundEvent
		dc.l	DDZ_ScreenInit,		DDZ_BackgroundInit
		dc.l	DDZ_ScreenInit,		DDZ_BackgroundInit
		dc.l	DDZ_ScreenEvent,	DDZ_BackgroundEvent
		dc.l	DDZ_ScreenEvent,	DDZ_BackgroundEvent
		dc.l	Ending_ScreenInit,	Ending_BackgroundInit
		dc.l	Ending_ScreenInit,	Ending_BackgroundInit
		dc.l	Ending_ScreenEvent,	Ending_BackgroundEvent
		dc.l	Ending_ScreenEvent,	Ending_BackgroundEvent
		dc.l	Comp_ScreenInit,	ALZ_BackgroundInit
		dc.l	Comp_ScreenInit,	ALZ_BackgroundInit
		dc.l	Comp_ScreenEvent,	ALZ_BackgroundEvent
		dc.l	Comp_ScreenEvent,	ALZ_BackgroundEvent
		dc.l	Comp_ScreenInit,	BPZ_BackgroundInit
		dc.l	Comp_ScreenInit,	BPZ_BackgroundInit
		dc.l	Comp_ScreenEvent,	BPZ_BackgroundEvent
		dc.l	Comp_ScreenEvent,	BPZ_BackgroundEvent
		dc.l	Comp_ScreenInit,	DPZ_BackgroundInit
		dc.l	Comp_ScreenInit,	DPZ_BackgroundInit
		dc.l	Comp_ScreenEvent,	DPZ_BackgroundEvent
		dc.l	Comp_ScreenEvent,	DPZ_BackgroundEvent
		dc.l	Comp_ScreenInit,	CGZ_BackgroundInit
		dc.l	Comp_ScreenInit,	CGZ_BackgroundInit
		dc.l	CGZ_ScreenEvent,	CGZ_BackgroundEvent
		dc.l	CGZ_ScreenEvent,	CGZ_BackgroundEvent
		dc.l	Comp_ScreenInit,	EMZ_BackgroundInit
		dc.l	Comp_ScreenInit,	EMZ_BackgroundInit
		dc.l	Comp_ScreenEvent,	EMZ_BackgroundEvent
		dc.l	Comp_ScreenEvent,	EMZ_BackgroundEvent
		dc.l	Gumball_ScreenInit,	Gumball_BackgroundInit
		dc.l	Gumball_ScreenInit,	Gumball_BackgroundInit
		dc.l	Gumball_ScreenEvent,	Gumball_BackgroundEvent
		dc.l	Gumball_ScreenEvent,	Gumball_BackgroundEvent
		dc.l	Pachinko_ScreenInit,	Pachinko_BackgroundInit
		dc.l	Pachinko_ScreenInit,	Pachinko_BackgroundInit
		dc.l	Pachinko_ScreenEvent,	Pachinko_BackgroundEvent
		dc.l	Pachinko_ScreenEvent,	Pachinko_BackgroundEvent
		dc.l	Slots_ScreenInit,	Slots_BackgroundInit
		dc.l	Slots_ScreenInit,	Slots_BackgroundInit
		dc.l	Slots_ScreenEvent,	Slots_BackgroundEvent
		dc.l	Slots_ScreenEvent,	Slots_BackgroundEvent
		dc.l	LRZ3_ScreenInit,	LRZ3_BackgroundInit
		dc.l	HPZ_ScreenInit,		HPZ_BackgroundInit
		dc.l	LRZ3_ScreenEvent,	LRZ3_BackgroundEvent
		dc.l	HPZ_ScreenEvent,	HPZ_BackgroundEvent
		dc.l	DEZ3_ScreenInit,	DEZ3_BackgroundInit
		dc.l	HPZS_ScreenInit,	HPZS_BackgroundInit
		dc.l	DEZ3_ScreenEvent,	DEZ3_BackgroundEvent
		dc.l	HPZS_ScreenEvent,	HPZS_BackgroundEvent

; =============== S U B R O U T I N E =======================================


VInt_DrawLevel:
		lea	(VDP_data_port).l,a6
		lea	(Plane_buffer).w,a0
		bsr.s	VInt_DrawLevel_2
		move.l	(Plane_buffer_2_addr).w,d0
		beq.s	VInt_DrawLevel_Return
		movea.l	d0,a0
; End of function VInt_DrawLevel


; =============== S U B R O U T I N E =======================================


VInt_DrawLevel_2:
		move.w	(a0),d0
		beq.s	VInt_DrawLevel_Done
		clr.w	(a0)+
		move.w	(a0)+,d1
		bmi.s	VInt_DrawLevel_Col
		move.w	#$8F02,d2		; VRAM increment at 2 bytes (horizontal level write)
		move.w	#$80,d3
		bra.s	VInt_DrawLevel_Draw
; ---------------------------------------------------------------------------

VInt_DrawLevel_Col:
		move.w	#$8F80,d2		; VRAM increment at $80 bytes (vertical level write)
		moveq	#2,d3
		andi.w	#$7FFF,d1

VInt_DrawLevel_Draw:
		move.w	d2,VDP_control_port-VDP_data_port(a6)
		move.w	d0,d2
		move.w	d1,d4
		bsr.s	VInt_VRAMWrite
		move.w	d2,d0
		add.w	d3,d0
		move.w	d4,d1
		bsr.s	VInt_VRAMWrite
		bra.s	VInt_DrawLevel_2
; ---------------------------------------------------------------------------

VInt_DrawLevel_Done:
		move.w	#$8F02,VDP_control_port-VDP_data_port(a6)

VInt_DrawLevel_Return:
		rts
; End of function VInt_DrawLevel_2


; =============== S U B R O U T I N E =======================================


VInt_VRAMWrite:
		swap	d0
		clr.w	d0
		swap	d0
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap	d0
		move.l	d0,VDP_control_port-VDP_data_port(a6)

.loop:
		move.l	(a0)+,(a6)
		dbf	d1,.loop
		rts
; End of function VInt_VRAMWrite


; =============== S U B R O U T I N E =======================================


SpecialVInt_VRAMRead:
		swap	d0
		clr.w	d0
		swap	d0
		lsl.l	#2,d0
		lsr.w	#2,d0
		swap	d0
		move.l	d0,VDP_control_port-VDP_data_port(a6)

.loop:
		move.l	(a6),(a0)+
		dbf	d1,.loop
		rts
; End of function SpecialVInt_VRAMRead


; =============== S U B R O U T I N E =======================================


VInt_DrawLevel_Competition:
		lea	(VDP_data_port).l,a6
		lea	(Plane_buffer).w,a0

loc_4E7E4:
		move.w	(a0),d0
		beq.s	locret_4E7FE
		clr.w	(a0)+
		move.w	(a0)+,d1
		move.w	d0,d2
		move.w	d1,d4
		bsr.s	VInt_VRAMWrite
		move.w	d2,d0
		add.w	(_unkEEB0).w,d0
		move.w	d4,d1
		bsr.s	VInt_VRAMWrite
		bra.s	loc_4E7E4
; ---------------------------------------------------------------------------

locret_4E7FE:
		rts
; End of function VInt_DrawLevel_Competition


; =============== S U B R O U T I N E =======================================


SpecialVInt_Function:
		lea	(VDP_data_port).l,a6
		move.w	(Special_V_int_routine).w,d0
		jmp	SpecialVInt_Array(pc,d0.w)
; End of function SpecialVInt_Function

; ---------------------------------------------------------------------------

SpecialVInt_Array:
		rts					; $00
		nop
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_VScrollOn		; $04
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_VScrollCopy		; $08
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_VScrollOff		; $0C
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_LBZ2WindowCopy	; $10
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_LBZ2ScrollAClear	; $14
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_LBZ2ScrollAClear2	; $18
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_LBZ2WindowClear	; $1C
; ---------------------------------------------------------------------------

SpecialVInt_VScrollOn:
		move.w	#$8B07,VDP_control_port-VDP_data_port(a6)		; Command $8B07 - VScroll cell-based, HScroll line-based
		addq.w	#4,(Special_V_int_routine).w

SpecialVInt_VScrollCopy:
		lea	(Vscroll_buffer).w,a0
		move.l	#vdpComm($0000,VSRAM,WRITE),VDP_control_port-VDP_data_port(a6)
		moveq	#$14-1,d0

.loop:
		move.l	(a0)+,(a6)
		dbf	d0,.loop
		rts
; ---------------------------------------------------------------------------

SpecialVInt_VScrollOff:
		move.w	#$8B03,VDP_control_port-VDP_data_port(a6)		; Command $8B03 - VScroll full, HScroll line-based
		clr.w	(Special_V_int_routine).w
		rts
; ---------------------------------------------------------------------------

SpecialVInt_LBZ2WindowCopy:
		lea	(VRAM_buffer).w,a0		; Used specifically by the Death Egg platform at the end of LBZ2
		move.w	(Draw_delayed_rowcount).w,d0
		addi.w	#$D,d0
		andi.w	#$1F,d0
		lsl.w	#7,d0
		addi.w	#VRAM_Plane_A_Name_Table,d0
		move.w	d0,d2
		addi.w	#$64,d0
		moveq	#7-1,d1
		jsr	SpecialVInt_VRAMRead(pc)	; Grabs the nametable area of the Death Egg platform
		move.w	d2,d0
		moveq	#$19-1,d1
		jsr	SpecialVInt_VRAMRead(pc)
		lea	(VRAM_buffer).w,a0
		move.w	(Draw_delayed_rowcount).w,d0
		lsl.w	#7,d0
		addi.w	#$8000,d0
		moveq	#$20-1,d1
		jsr	VInt_VRAMWrite(pc)			; Copies the pertinent data from scroll A to the window nametable
		subq.w	#1,(Draw_delayed_rowcount).w		; Do this (EECA) number of times
		bpl.s	.return
		addq.w	#4,(Special_V_int_routine).w

.return:
		rts
; ---------------------------------------------------------------------------

SpecialVInt_LBZ2ScrollAClear:
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$900,VRAM,WRITE),(VDP_control_port).l	; VRAM base $C900
		moveq	#0,d0
		moveq	#$60-1,d1

.loop:
		move.l	d0,(a6)				; Clear 6 cell lines from VRAM A for when it scrolls upward
		move.l	d0,(a6)
		dbf	d1,.loop
		move.w	#$8320,VDP_control_port-VDP_data_port(a6)		; VRAM command $8320 - Window at base address $8000
		move.w	#$9285,VDP_control_port-VDP_data_port(a6)		; VRAM command $9285 - Window starts 5 cells down from top
		clr.w	(Special_V_int_routine).w
		rts
; ---------------------------------------------------------------------------

SpecialVInt_LBZ2ScrollAClear2:
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$600,VRAM,WRITE),(VDP_control_port).l	; VRAM base $C600
		moveq	#0,d0
		moveq	#$60-1,d1

.loop:
		move.l	d0,(a6)					; Erase remainder of upper area of VRAM A
		move.l	d0,(a6)
		dbf	d1,.loop
		addq.w	#4,(Special_V_int_routine).w
		rts
; ---------------------------------------------------------------------------

SpecialVInt_LBZ2WindowClear:
		lea	(VRAM_buffer).w,a0
		move.w	#$829C,d0
		moveq	#$19-1,d1
		jsr	SpecialVInt_VRAMRead(pc)
		move.w	#$8280,d0
		moveq	#7-1,d1
		jsr	SpecialVInt_VRAMRead(pc)	; Copy from window data. Luckily, all 6 cell lines are identical so it only needs to be done once
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$900,VRAM,WRITE),(VDP_control_port).l	; VRAM position $C900
		moveq	#6-1,d0

loc_4E90C:
		lea	(VRAM_buffer).w,a0
		moveq	#$10-1,d1

loc_4E912:
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)				; Write cell lines back to Scroll A
		dbf	d1,loc_4E912
		dbf	d0,loc_4E90C
		move.w	#$9200,VDP_control_port-VDP_data_port(a6)			; VRAM command $9200 - Zero out window position
		clr.w	(Special_V_int_routine).w
		rts

; =============== S U B R O U T I N E =======================================


Draw_TileColumn:
		move.w	(a6),d0
		andi.w	#$FFF0,d0
		move.w	(a5),d2
		move.w	d0,(a5)
		move.w	d2,d3
		sub.w	d0,d2
		beq.w	locret_4EAB6
		tst.b	d2
		bpl.s	loc_4E948
		neg.w	d2
		move.w	d3,d0
		addi.w	#$150,d0

loc_4E948:
		andi.w	#$30,d2
		cmpi.w	#$10,d2
		sne	(Plane_double_update_flag).w
		movem.w	d1/d6,-(sp)
		bsr.s	Setup_TileColumnDraw
		movem.w	(sp)+,d1/d6
		tst.b	(Plane_double_update_flag).w
		beq.w	locret_4EAB6
		addi.w	#$10,d0
		bra.s	Setup_TileColumnDraw
; End of function Draw_TileColumn


; =============== S U B R O U T I N E =======================================


Draw_TileColumn2:
		move.w	(a6),d0
		andi.w	#$FFF0,d0
		move.w	(a5),d2
		move.w	d0,(a5)
		move.w	d2,d3
		sub.w	d0,d2
		beq.w	locret_4EAB6
		tst.b	d2
		bpl.s	loc_4E98C
		neg.w	d2
		move.w	d3,d0
		addi.w	#$150,d0
		swap	d1

loc_4E98C:
		andi.w	#$30,d2
		cmpi.w	#$10,d2
		sne	(Plane_double_update_flag).w
		movem.w	d1/d6,-(sp)
		bsr.s	Setup_TileColumnDraw
		movem.w	(sp)+,d1/d6
		tst.b	(Plane_double_update_flag).w
		beq.w	locret_4EAB6
		addi.w	#$10,d0
; End of function Draw_TileColumn2


; =============== S U B R O U T I N E =======================================


Setup_TileColumnDraw:
		move.w	d1,d2
		andi.w	#$70,d2
		move.w	d1,d3
		lsl.w	#4,d3
		andi.w	#$F00,d3
		asr.w	#4,d1
		move.w	d1,d4
		asr.w	#1,d1
		and.w	(Layout_row_index_mask).w,d1
		andi.w	#$F,d4
		moveq	#$10,d5
		sub.w	d4,d5
		move.w	d5,d4
		sub.w	d6,d5
		bmi.s	loc_4E9FC
		move.w	d0,d5
		asr.w	#2,d5
		andi.w	#$7C,d5
		add.w	d7,d5
		add.w	d3,d5
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		bset	#7,-2(a0)
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0
		jsr	Get_LevelChunkColumn(pc)
		bra.s	sub_4EA4A
; ---------------------------------------------------------------------------

loc_4E9FC:
		neg.w	d5
		move.w	d5,-(sp)
		move.w	d0,d5
		asr.w	#2,d5
		andi.w	#$7C,d5
		add.w	d7,d5
		add.w	d3,d5
		move.w	d5,(a0)+
		move.w	d4,d6
		subq.w	#1,d6
		move.w	d6,(a0)+
		bset	#7,-2(a0)
		lea	(a0),a1
		add.w	d4,d4
		add.w	d4,d4
		adda.w	d4,a0
		jsr	Get_LevelChunkColumn(pc)
		bsr.s	sub_4EA4A
		move.w	(sp)+,d6
		move.w	d0,d5
		asr.w	#2,d5
		andi.w	#$7C,d5
		add.w	d7,d5
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		bset	#7,-2(a0)
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0

sub_4EA4A:
		swap	d7

loc_4EA4C:
		move.w	(a5,d2.w),d3
		move.w	d3,d4
		andi.w	#$3FF,d3
		lsl.w	#3,d3
		move.w	(a2,d3.w),d5
		swap	d5
		move.w	4(a2,d3.w),d5
		move.w	6(a2,d3.w),d7
		move.w	2(a2,d3.w),d3
		swap	d3
		move.w	d7,d3
		btst	#$B,d4
		beq.s	loc_4EA84
		eori.l	#$10001000,d5
		eori.l	#$10001000,d3
		swap	d5
		swap	d3

loc_4EA84:
		btst	#$A,d4
		beq.s	loc_4EA98
		eori.l	#$8000800,d5
		eori.l	#$8000800,d3
		exg	d3,d5

loc_4EA98:
		move.l	d5,(a1)+
		move.l	d3,(a0)+
		addi.w	#$10,d2
		andi.w	#$70,d2
		bne.s	loc_4EAAE
		addq.w	#4,d1
		and.w	(Layout_row_index_mask).w,d1
		bsr.s	Get_LevelChunkColumn

loc_4EAAE:
		dbf	d6,loc_4EA4C
		swap	d7
		clr.w	(a0)

locret_4EAB6:
		rts
; End of function Setup_TileColumnDraw


; =============== S U B R O U T I N E =======================================


Get_LevelChunkColumn:
		movea.w	(a3,d1.w),a4
		move.w	d0,d3
		asr.w	#7,d3
		adda.w	d3,a4
		moveq	#-1,d3
		clr.w	d3
		move.b	(a4),d3
		lsl.w	#7,d3
		move.w	d0,d4
		asr.w	#3,d4
		andi.w	#$E,d4
		add.w	d4,d3
		movea.l	d3,a5
		rts
; End of function Get_LevelChunkColumn


; =============== S U B R O U T I N E =======================================


Draw_TileRow:
		move.w	(a6),d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	(a5),d2
		move.w	d0,(a5)
		move.w	d2,d3
		sub.w	d0,d2
		beq.w	locret_4EC46
		tst.b	d2
		bpl.s	loc_4EAFA
		neg.w	d2
		move.w	d3,d0
		addi.w	#$F0,d0
		and.w	(Camera_Y_pos_mask).w,d0

loc_4EAFA:
		andi.w	#$30,d2
		cmpi.w	#$10,d2
		sne.b	(Plane_double_update_flag).w
		movem.w	d1/d6,-(sp)
		bsr.s	Setup_TileRowDraw
		movem.w	(sp)+,d1/d6
		tst.b	(Plane_double_update_flag).w
		beq.w	locret_4EC46
		addi.w	#$10,d0
		and.w	(Camera_Y_pos_mask).w,d0
		bra.s	Setup_TileRowDraw
; End of function Draw_TileRow


; =============== S U B R O U T I N E =======================================


Draw_TileRow2:
		move.w	(a6),d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	(a5),d2
		move.w	d0,(a5)
		move.w	d2,d3
		sub.w	d0,d2
		beq.w	locret_4EC46
		tst.b	d2
		bpl.s	loc_4EB46
		neg.w	d2
		move.w	d3,d0
		addi.w	#$F0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		swap	d1

loc_4EB46:
		andi.w	#$30,d2
		cmpi.w	#$10,d2
		sne	(Plane_double_update_flag).w
		movem.w	d1/d6,-(sp)
		bsr.s	Setup_TileRowDraw
		movem.w	(sp)+,d1/d6
		tst.b	(Plane_double_update_flag).w
		beq.w	locret_4EC46
		addi.w	#$10,d0
		and.w	(Camera_Y_pos_mask).w,d0
; End of function Draw_TileRow2


; =============== S U B R O U T I N E =======================================


Setup_TileRowDraw:
		asr.w	#4,d1
		move.w	d1,d2
		move.w	d1,d4
		asr.w	#3,d1
		add.w	d2,d2
		move.w	d2,d3
		andi.w	#$E,d2
		add.w	d3,d3
		andi.w	#$7C,d3
		andi.w	#$1F,d4
		moveq	#$20,d5
		sub.w	d4,d5
		move.w	d5,d4
		sub.w	d6,d5
		bmi.s	loc_4EBB2
		move.w	d0,d5
		andi.w	#$F0,d5		; If the length of the write can fit without wrapping the nametable
		lsl.w	#4,d5
		add.w	d7,d5
		add.w	d3,d5
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0
		jsr	Get_LevelAddrChunkRow(pc)
		bra.s	loc_4EBF2
; ---------------------------------------------------------------------------

loc_4EBB2:
		neg.w	d5			; If the length of the write wraps over the length of the nametable
		move.w	d5,-(sp)
		move.w	d0,d5
		andi.w	#$F0,d5
		lsl.w	#4,d5
		add.w	d7,d5
		add.w	d3,d5
		move.w	d5,(a0)+
		move.w	d4,d6
		subq.w	#1,d6
		move.w	d6,(a0)+
		lea	(a0),a1
		add.w	d4,d4
		add.w	d4,d4
		adda.w	d4,a0
		bsr.s	Get_LevelAddrChunkRow
		bsr.s	loc_4EBF2
		move.w	(sp)+,d6	; Must place one more write command to account for rollover
		move.w	d0,d5
		andi.w	#$F0,d5
		lsl.w	#4,d5
		add.w	d7,d5
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0

loc_4EBF2:
		move.w	(a5,d2.w),d3
		move.w	d3,d4
		andi.w	#$3FF,d3
		lsl.w	#3,d3
		move.l	(a2,d3.w),d5
		move.l	4(a2,d3.w),d3
		btst	#$B,d4
		beq.s	loc_4EC1A
		eori.l	#$10001000,d5
		eori.l	#$10001000,d3
		exg	d3,d5

loc_4EC1A:
		btst	#$A,d4
		beq.s	loc_4EC30
		eori.l	#$8000800,d5
		eori.l	#$8000800,d3
		swap	d5
		swap	d3

loc_4EC30:
		move.l	d5,(a1)+
		move.l	d3,(a0)+
		addq.w	#2,d2
		andi.w	#$E,d2
		bne.s	loc_4EC40
		addq.w	#1,d1
		bsr.s	Get_ChunkRow

loc_4EC40:
		dbf	d6,loc_4EBF2
		clr.w	(a0)

locret_4EC46:
		rts
; End of function Setup_TileRowDraw

; =============== S U B R O U T I N E =======================================


Get_LevelAddrChunkRow:
		move.w	d0,d3
		asr.w	#5,d3
		and.w	(Layout_row_index_mask).w,d3
		movea.w	(a3,d3.w),a4

Get_ChunkRow:
		moveq	#-1,d3
		clr.w	d3
		move.b	(a4,d1.w),d3
		lsl.w	#7,d3
		move.w	d0,d4
		andi.w	#$70,d4
		add.w	d4,d3
		movea.l	d3,a5
		rts
; End of function Get_LevelAddrChunkRow


; =============== S U B R O U T I N E =======================================


Setup_TileRowDraw_Competition:
		asr.w	#3,d1
		move.w	d1,d2
		asr.w	#4,d1
		andi.w	#$E,d2
		cmpi.w	#$100,(_unkEEB0).w
		beq.s	loc_4EC84
		moveq	#4,d3
		move.w	#$1F80,d4
		bra.s	loc_4EC8A
; ---------------------------------------------------------------------------

loc_4EC84:
		moveq	#5,d3
		move.w	#$1F00,d4

loc_4EC8A:
		move.w	d0,d5
		lsl.w	d3,d5
		and.w	d4,d5
		add.w	d7,d5
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0
		jsr	Get_LevelAddrChunkRow(pc)
		bra.w	loc_4EBF2
; End of function Setup_TileRowDraw_Competition


; =============== S U B R O U T I N E =======================================


sub_4ECAA:
		asr.w	#4,d1
		move.w	d1,d2
		asr.w	#3,d1
		add.w	d2,d2
		andi.w	#$E,d2
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0
		jsr	Get_LevelAddrChunkRow(pc)
		bra.w	loc_4EBF2
; End of function sub_4ECAA


; =============== S U B R O U T I N E =======================================


Refresh_PlaneFull:
		moveq	#$10-1,d2

.loop:
		movem.l	d0-d2/a0,-(sp)
		moveq	#$20,d6
		jsr	Setup_TileRowDraw(pc)
		jsr	VInt_DrawLevel(pc)
		movem.l	(sp)+,d0-d2/a0
		addi.w	#$10,d0
		dbf	d2,.loop
		rts
; End of function Refresh_PlaneFull


; =============== S U B R O U T I N E =======================================


Refresh_PlaneTileDeform:
		move.w	(a4)+,d2
		moveq	#$10-1,d3

loc_4ECF0:
		cmp.w	d2,d0
		bmi.s	loc_4ECFA
		add.w	(a4)+,d2
		addq.w	#4,a5
		bra.s	loc_4ECF0
; ---------------------------------------------------------------------------

loc_4ECFA:
		move.w	(a5),d1
		moveq	#$20,d6
		movem.l	d0/d2-d3/a0/a4-a5,-(sp)
		jsr	Setup_TileRowDraw(pc)
		jsr	VInt_DrawLevel(pc)
		movem.l	(sp)+,d0/d2-d3/a0/a4-a5
		addi.w	#$10,d0
		dbf	d3,loc_4ECF0
		rts
; End of function Refresh_PlaneTileDeform

; ---------------------------------------------------------------------------

Refresh_PlaneDirectVScroll:
		move.w	(a4)+,d2
		moveq	#$20-1,d3

loc_4ED1C:
		cmp.w	d2,d0
		bmi.s	loc_4ED26
		add.w	(a4)+,d2
		addq.w	#4,a5
		bra.s	loc_4ED1C
; ---------------------------------------------------------------------------

loc_4ED26:
		move.w	(a5),d1
		moveq	#$10,d6
		movem.l	d0/d2-d3/a0/a4-a5,-(sp)
		jsr	Setup_TileColumnDraw(pc)
		jsr	VInt_DrawLevel(pc)
		movem.l	(sp)+,d0/d2-d3/a0/a4-a5
		addi.w	#$10,d0
		dbf	d3,loc_4ED1C
		rts
; ---------------------------------------------------------------------------

Refresh_PlaneFull_Competition:
		movem.l	d0-d2/d6/a0,-(sp)
		jsr	Setup_TileRowDraw_Competition(pc)
		jsr	VInt_DrawLevel_Competition(pc)
		movem.l	(sp)+,d0-d2/d6/a0
		addi.w	#$10,d0
		dbf	d2,Refresh_PlaneFull_Competition
		rts
; ---------------------------------------------------------------------------

Refresh_PlaneFullDirect:
		moveq	#$20,d6
		bra.s	Refresh_PlaneDirect2
; ---------------------------------------------------------------------------

Refresh_PlaneScreenDirect:
		moveq	#$15,d6

Refresh_PlaneDirect2:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Camera_X_pos_copy).w,d1

Refresh_PlaneDirect:
		move	#$2700,sr
		moveq	#$F-1,d2

loc_4ED72:
		movem.l	d0-d2/d6/a0,-(sp)		; Redraws the entire plane in one go during 68k execution
		jsr	Setup_TileRowDraw(pc)
		jsr	VInt_DrawLevel(pc)
		movem.l	(sp)+,d0-d2/d6/a0
		addi.w	#$10,d0
		dbf	d2,loc_4ED72
		move	#$2300,sr
		rts

; =============== S U B R O U T I N E =======================================


DrawTilesAsYouMove:
		lea	(Camera_X_pos_copy).w,a6
		lea	(Camera_X_pos_rounded).w,a5
		move.w	(Camera_Y_pos_copy).w,d1
		moveq	#$F,d6
		jsr	Draw_TileColumn(pc)
		lea	(Camera_Y_pos_copy).w,a6
		lea	(Camera_Y_pos_rounded).w,a5
		move.w	(Camera_X_pos_copy).w,d1
		moveq	#$15,d6
		jmp	Draw_TileRow(pc)
; End of function DrawTilesAsYouMove


; =============== S U B R O U T I N E =======================================


DrawBGAsYouMove:
		lea	(Camera_X_pos_BG_copy).w,a6
		lea	(Camera_X_pos_BG_rounded).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d1
		moveq	#$F,d6
		jsr	Draw_TileColumn(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	(Camera_X_pos_BG_copy).w,d1
		moveq	#$15,d6
		jmp	Draw_TileRow(pc)
; End of function DrawBGAsYouMove

; ---------------------------------------------------------------------------

loc_4EDD8:
		movem.l	d5/a4-a5,-(sp)
		lea	(Camera_Y_pos_copy).w,a6
		jsr	Get_DeformDrawPosVert(pc)
		lea	(Camera_Y_pos_rounded).w,a5
		jsr	Draw_TileRow2(pc)
		movem.l	(sp)+,d5/a4/a6
		move.w	(Camera_Y_pos_rounded).w,d6
		bra.s	Draw_BGNoVert

; =============== S U B R O U T I N E =======================================


Draw_BG:
		movem.l	d5/a4-a5,-(sp)
		lea	(Camera_Y_pos_BG_copy).w,a6
		jsr	Get_DeformDrawPosVert(pc)
		lea	(Camera_Y_pos_BG_rounded).w,a5
		jsr	Draw_TileRow2(pc)
		movem.l	(sp)+,d5/a4/a6
		move.w	(Camera_Y_pos_BG_rounded).w,d6
		tst.w	(Camera_Y_pos_BG_copy).w
		bpl.s	Draw_BGNoVert
		move.w	(Camera_Y_pos_BG_copy).w,d6
		andi.w	#$FFF0,d6

Draw_BGNoVert:
		move.w	d6,d1

loc_4EE22:
		sub.w	(a4)+,d6
		bmi.s	loc_4EE32
		move.w	(a6)+,d0
		andi.w	#$FFF0,d0
		move.w	d0,(a6)+
		subq.w	#1,d5
		bra.s	loc_4EE22
; ---------------------------------------------------------------------------

loc_4EE32:
		neg.w	d6
		lsr.w	#4,d6
		moveq	#$F,d4
		sub.w	d6,d4
		bcc.s	loc_4EE40
		moveq	#0,d4
		moveq	#$F,d6

loc_4EE40:
		movem.w	d1/d4-d6,-(sp)
		movem.l	a4/a6,-(sp)
		lea	2(a6),a5
		jsr	Draw_TileColumn(pc)
		movem.l	(sp)+,a4/a6
		movem.w	(sp)+,d1/d4-d6
		addq.w	#4,a6
		tst.w	d4
		beq.s	loc_4EE74
		lsl.w	#4,d6
		add.w	d6,d1
		subq.w	#1,d5
		move.w	(a4)+,d6
		lsr.w	#4,d6
		move.w	d4,d0
		sub.w	d6,d4
		bpl.s	loc_4EE40
		move.w	d0,d6
		moveq	#0,d4
		bra.s	loc_4EE40
; ---------------------------------------------------------------------------

loc_4EE74:
		subq.w	#1,d5
		beq.s	locret_4EE82
		move.w	(a6)+,d0
		andi.w	#$FFF0,d0
		move.w	d0,(a6)+
		bra.s	loc_4EE74
; ---------------------------------------------------------------------------

locret_4EE82:
		rts
; End of function Draw_BG


; =============== S U B R O U T I N E =======================================


Get_DeformDrawPosVert:
		move.w	(a4)+,d2
		move.w	(a6),d0
		bsr.s	sub_4EE8E
		addi.w	#$E0,d0
; End of function Get_DeformDrawPosVert


; =============== S U B R O U T I N E =======================================


sub_4EE8E:
		cmp.w	d2,d0
		bmi.s	loc_4EE98
		add.w	(a4)+,d2
		addq.w	#4,a5
		bra.s	sub_4EE8E
; ---------------------------------------------------------------------------

loc_4EE98:
		move.w	(a5),d1
		swap	d1
		rts
; End of function sub_4EE8E

; ---------------------------------------------------------------------------

DrawTilesVDeform:
		movem.l	d5/a4-a5,-(sp)
		lea	(Camera_X_pos_copy).w,a6
		jsr	Get_XDeformRange(pc)
		lea	(Camera_X_pos_rounded).w,a5
		jsr	Draw_TileColumn2(pc)
		movem.l	(sp)+,d5/a4/a6
		move.w	(Camera_X_pos_rounded).w,d6
		bra.s	loc_4EED8

; ---------------------------------------------------------------------------

DrawTilesVDeform2:
		movem.l	d5/a4-a5,-(sp)
		lea	(Camera_X_pos_BG_copy).w,a6
		jsr	Get_XDeformRange(pc)
		lea	(Camera_X_pos_BG_rounded).w,a5
		jsr	Draw_TileColumn2(pc)
		movem.l	(sp)+,d5/a4/a6
		move.w	(Camera_X_pos_BG_rounded).w,d6

loc_4EED8:
		move.w	d6,d1

loc_4EEDA:
		sub.w	(a4)+,d6
		bcs.s	loc_4EEEA
		move.w	(a6)+,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(a6)+
		subq.w	#1,d5
		bra.s	loc_4EEDA
; ---------------------------------------------------------------------------

loc_4EEEA:
		neg.w	d6
		lsr.w	#4,d6
		moveq	#$15,d4
		sub.w	d6,d4
		bcc.s	loc_4EEF8
		moveq	#0,d4
		moveq	#$15,d6

loc_4EEF8:
		movem.w	d1/d4-d6,-(sp)
		movem.l	a4/a6,-(sp)
		lea	2(a6),a5
		jsr	Draw_TileRow(pc)
		movem.l	(sp)+,a4/a6
		movem.w	(sp)+,d1/d4-d6
		addq.w	#4,a6
		tst.w	d4
		beq.s	loc_4EF2C
		lsl.w	#4,d6
		add.w	d6,d1
		subq.w	#1,d5
		move.w	(a4)+,d6
		lsr.w	#4,d6
		move.w	d4,d0
		sub.w	d6,d4
		bcc.s	loc_4EEF8
		move.w	d0,d6
		moveq	#0,d4
		bra.s	loc_4EEF8
; ---------------------------------------------------------------------------

loc_4EF2C:
		subq.w	#1,d5
		beq.s	locret_4EF3A
		move.w	(a6)+,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(a6)+
		bra.s	loc_4EF2C
; ---------------------------------------------------------------------------

locret_4EF3A:
		rts


; =============== S U B R O U T I N E =======================================


Get_XDeformRange:
		move.w	(a4)+,d2
		move.w	(a6),d0
		bsr.s	sub_4EF46
		addi.w	#$140,d0
; End of function Get_XDeformRange


; =============== S U B R O U T I N E =======================================


sub_4EF46:
		cmp.w	d2,d0
		blo.s	loc_4EF50
		add.w	(a4)+,d2
		addq.w	#4,a5
		bra.s	sub_4EF46
; ---------------------------------------------------------------------------

loc_4EF50:
		move.w	(a5),d1
		swap	d1
		rts
; End of function sub_4EF46


; =============== S U B R O U T I N E =======================================


Draw_PlaneVertBottomUp:
		movem.w	d1-d2,-(sp)
		bsr.s	Draw_PlaneVertSingleBottomUp
		movem.w	(sp)+,d1-d2
		bpl.s	Draw_PlaneVertSingleBottomUp
		rts
; End of function Draw_PlaneVertBottomUp


; =============== S U B R O U T I N E =======================================


Draw_PlaneVertSingleBottomUp:
		and.w	(Camera_Y_pos_mask).w,d2
		move.w	d2,d3
		addi.w	#$F0,d3
		and.w	(Camera_Y_pos_mask).w,d3
		move.w	(Draw_delayed_position).w,d0
		cmp.w	d2,d0
		blo.s	loc_4EF84
		cmp.w	d3,d0
		bhi.s	loc_4EF84
		moveq	#$20,d6
		jsr	Setup_TileRowDraw(pc)

loc_4EF84:
		subi.w	#$10,(Draw_delayed_position).w
		subq.w	#1,(Draw_delayed_rowcount).w
		rts
; End of function Draw_PlaneVertSingleBottomUp


; =============== S U B R O U T I N E =======================================


Draw_PlaneVertTopDown:
		and.w	(Camera_Y_pos_mask).w,d2
		move.w	d2,d3
		addi.w	#$F0,d3
		and.w	(Camera_Y_pos_mask).w,d3
		move.w	(Draw_delayed_position).w,d0
		cmp.w	d2,d0
		blo.s	loc_4EFB0
		cmp.w	d3,d0
		bhi.s	loc_4EFB0
		moveq	#$20,d6
		jsr	Setup_TileRowDraw(pc)

loc_4EFB0:
		addi.w	#$10,(Draw_delayed_position).w
		subq.w	#1,(Draw_delayed_rowcount).w
		rts
; End of function Draw_PlaneVertTopDown


; =============== S U B R O U T I N E =======================================


Draw_PlaneHorzRightToLeft:
		movem.w	d1-d2,-(sp)
		bsr.s	sub_4EFCA
		movem.w	(sp)+,d1-d2
		bpl.s	sub_4EFCA
		rts
; End of function Draw_PlaneHorzRightToLeft


; =============== S U B R O U T I N E =======================================


sub_4EFCA:
		andi.w	#$FFF0,d2
		move.w	d2,d3
		addi.w	#$1F0,d3
		andi.w	#$FFF0,d3
		move.w	(Draw_delayed_position).w,d0
		cmp.w	d2,d0
		blo.s	loc_4EFEA
		cmp.w	d3,d0
		bhi.s	loc_4EFEA
		moveq	#$10,d6
		jsr	Setup_TileColumnDraw(pc)

loc_4EFEA:
		subi.w	#$10,(Draw_delayed_position).w
		subq.w	#1,(Draw_delayed_rowcount).w
		rts
; End of function sub_4EFCA


; =============== S U B R O U T I N E =======================================


Draw_PlaneHorzLeftToRight:
		movem.w	d1-d2,-(sp)
		bsr.s	sub_4F004
		movem.w	(sp)+,d1-d2
		bpl.s	sub_4F004
		rts
; End of function Draw_PlaneHorzLeftToRight


; =============== S U B R O U T I N E =======================================


sub_4F004:
		andi.w	#$FFF0,d2
		move.w	d2,d3
		addi.w	#$1F0,d3
		andi.w	#$FFF0,d3
		move.w	(Draw_delayed_position).w,d0
		cmp.w	d2,d0
		blo.s	loc_4F024
		cmp.w	d3,d0
		bhi.s	loc_4F024
		moveq	#$10,d6
		jsr	Setup_TileColumnDraw(pc)

loc_4F024:
		addi.w	#$10,(Draw_delayed_position).w
		subq.w	#1,(Draw_delayed_rowcount).w
		rts
; End of function sub_4F004


; =============== S U B R O U T I N E =======================================


Draw_PlaneVertBottomUpComplex:
		movem.l	d1/a4-a5,-(sp)
		bsr.s	sub_4F03E
		movem.l	(sp)+,d1/a4-a5
		bpl.s	sub_4F03E
		rts
; End of function Draw_PlaneVertBottomUpComplex


; =============== S U B R O U T I N E =======================================


sub_4F03E:
		and.w	(Camera_Y_pos_mask).w,d1
		move.w	d1,d2
		addi.w	#$F0,d2
		and.w	(Camera_Y_pos_mask).w,d2
		move.w	(Draw_delayed_position).w,d0
		cmp.w	d1,d0
		blo.s	loc_4F066
		cmp.w	d2,d0
		bhi.s	loc_4F066

loc_4F058:
		addq.w	#4,a5
		cmp.w	(a4)+,d0
		bpl.s	loc_4F058
		move.w	(a5),d1
		moveq	#$20,d6
		jsr	Setup_TileRowDraw(pc)

loc_4F066:
		subi.w	#$10,(Draw_delayed_position).w
		subq.w	#1,(Draw_delayed_rowcount).w
		rts
; End of function sub_4F03E


; =============== S U B R O U T I N E =======================================


PlainDeformation:
		lea	(H_scroll_buffer).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		neg.w	d0
		swap	d0
		move.w	(Camera_X_pos_BG_copy).w,d0
		neg.w	d0
		moveq	#bytesToXcnt(H_scroll_buffer_end-H_scroll_buffer,$10),d1

loc_4F086:
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		dbf	d1,loc_4F086
		rts
; End of function PlainDeformation


; =============== S U B R O U T I N E =======================================


PlainDeformation_Flipped:
		lea	(H_scroll_buffer).w,a1
		move.w	(Camera_X_pos_BG_copy).w,d0
		neg.w	d0
		swap	d0
		move.w	(Camera_X_pos_copy).w,d0
		neg.w	d0
		moveq	#bytesToXcnt(H_scroll_buffer_end-H_scroll_buffer,$10),d1

loc_4F0A8:
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		dbf	d1,loc_4F0A8
		rts
; End of function PlainDeformation_Flipped


; =============== S U B R O U T I N E =======================================


MakeFGDeformArray:
		move.w	d1,d0
		lsr.w	#1,d0
		bcc.s	loc_4F0C2

loc_4F0BC:
		move.w	(a6)+,d5
		add.w	d6,d5
		move.w	d5,(a1)+

loc_4F0C2:
		move.w	(a6)+,d5
		add.w	d6,d5
		move.w	d5,(a1)+
		dbf	d0,loc_4F0BC
		rts
; End of function MakeFGDeformArray


; =============== S U B R O U T I N E =======================================


ApplyDeformation:
		move.w	#$E0-1,d1

ApplyDeformation3:
		lea	(H_scroll_buffer).w,a1
		move.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	(Camera_X_pos_copy).w,d3

ApplyDeformation2:
		move.w	(a4)+,d2
		smi	d4
		bpl.s	loc_4F0E8
		andi.w	#$7FFF,d2

loc_4F0E8:
		sub.w	d2,d0
		bmi.s	loc_4F0FA
		addq.w	#2,a5
		tst.b	d4
		beq.s	ApplyDeformation2
		subq.w	#2,a5
		add.w	d2,d2
		adda.w	d2,a5
		bra.s	ApplyDeformation2
; ---------------------------------------------------------------------------

loc_4F0FA:
		tst.b	d4
		beq.s	loc_4F104
		add.w	d0,d2
		add.w	d2,d2
		adda.w	d2,a5

loc_4F104:
		neg.w	d0
		move.w	d1,d2
		sub.w	d0,d2
		bcc.s	loc_4F110
		move.w	d1,d0
		addq.w	#1,d0

loc_4F110:
		neg.w	d3
		swap	d3

loc_4F114:
		subq.w	#1,d0

loc_4F116:
		tst.b	d4
		beq.s	loc_4F130
		lsr.w	#1,d0
		bcc.s	loc_4F124

loc_4F11E:
		move.w	(a5)+,d3
		neg.w	d3
		move.l	d3,(a1)+

loc_4F124:
		move.w	(a5)+,d3
		neg.w	d3
		move.l	d3,(a1)+
		dbf	d0,loc_4F11E
		bra.s	loc_4F140
; ---------------------------------------------------------------------------

loc_4F130:
		move.w	(a5)+,d3
		neg.w	d3
		lsr.w	#1,d0
		bcc.s	loc_4F13A

loc_4F138:
		move.l	d3,(a1)+

loc_4F13A:
		move.l	d3,(a1)+
		dbf	d0,loc_4F138

loc_4F140:
		tst.w	d2
		bmi.s	locret_4F158
		move.w	(a4)+,d0
		smi	d4
		bpl.s	loc_4F14E
		andi.w	#$7FFF,d0

loc_4F14E:
		move.w	d2,d3
		sub.w	d0,d2
		bpl.s	loc_4F114
		move.w	d3,d0
		bra.s	loc_4F116
; ---------------------------------------------------------------------------

locret_4F158:
		rts
; End of function ApplyDeformation


; =============== S U B R O U T I N E =======================================


ApplyFGDeformation:
		move.w	#$DF,d1
		lea	(H_scroll_buffer).w,a1
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Camera_X_pos_BG_copy).w,d3

ApplyFGDeformation2:
		move.w	(a4)+,d2
		smi	d4
		bpl.s	loc_4F174
		andi.w	#$7FFF,d2

loc_4F174:
		sub.w	d2,d0
		bmi.s	loc_4F186
		addq.w	#2,a5
		tst.b	d4
		beq.s	ApplyFGDeformation2
		subq.w	#2,a5
		add.w	d2,d2
		adda.w	d2,a5
		bra.s	ApplyFGDeformation2
; ---------------------------------------------------------------------------

loc_4F186:
		tst.b	d4
		beq.s	loc_4F190
		add.w	d0,d2
		add.w	d2,d2
		adda.w	d2,a5

loc_4F190:
		neg.w	d0
		move.w	d1,d2
		sub.w	d0,d2
		bcc.s	loc_4F19C
		move.w	d1,d0
		addq.w	#1,d0

loc_4F19C:
		neg.w	d3

loc_4F19E:
		subq.w	#1,d0

loc_4F1A0:
		tst.b	d4
		beq.s	loc_4F1C2
		lsr.w	#1,d0
		bcc.s	loc_4F1B2

loc_4F1A8:
		swap	d3
		move.w	(a5)+,d3
		neg.w	d3
		swap	d3
		move.l	d3,(a1)+

loc_4F1B2:
		swap	d3
		move.w	(a5)+,d3
		neg.w	d3
		swap	d3
		move.l	d3,(a1)+
		dbf	d0,loc_4F1A8
		bra.s	loc_4F1D6
; ---------------------------------------------------------------------------

loc_4F1C2:
		swap	d3
		move.w	(a5)+,d3
		neg.w	d3
		swap	d3
		lsr.w	#1,d0
		bcc.s	loc_4F1D0

loc_4F1CE:
		move.l	d3,(a1)+

loc_4F1D0:
		move.l	d3,(a1)+
		dbf	d0,loc_4F1CE

loc_4F1D6:
		tst.w	d2
		bmi.s	locret_4F1EE
		move.w	(a4)+,d0
		smi	d4
		bpl.s	loc_4F1E4
		andi.w	#$7FFF,d0

loc_4F1E4:
		move.w	d2,d1
		sub.w	d0,d2
		bpl.s	loc_4F19E
		move.w	d1,d0
		bra.s	loc_4F1A0
; ---------------------------------------------------------------------------

locret_4F1EE:
		rts
; End of function ApplyFGDeformation

; ---------------------------------------------------------------------------

ApplyFGandBGDeformation:
		swap	d7
		swap	d3

loc_4F1F4:
		move.w	(a4)+,d3
		smi	d7
		bpl.s	loc_4F1FE
		andi.w	#$7FFF,d3

loc_4F1FE:
		sub.w	d3,d0
		bmi.s	loc_4F210
		addq.w	#2,a5
		tst.b	d7
		beq.s	loc_4F1F4
		subq.w	#2,a5
		add.w	d3,d3
		adda.w	d3,a5
		bra.s	loc_4F1F4
; ---------------------------------------------------------------------------

loc_4F210:
		tst.b	d7
		beq.s	loc_4F21A
		add.w	d0,d3
		add.w	d3,d3
		adda.w	d3,a5

loc_4F21A:
		swap	d3
		neg.w	d0
		move.w	d1,d4
		sub.w	d0,d4
		bcc.s	loc_4F228
		move.w	d1,d0
		addq.w	#1,d0

loc_4F228:
		subq.w	#1,d0

loc_4F22A:
		tst.b	d7
		beq.s	loc_4F250
		lsr.w	#1,d0
		bcc.s	loc_4F23E

loc_4F232:
		move.w	(a2)+,d6
		swap	d6
		move.w	(a5)+,d6
		neg.w	d6
		add.w	(a6)+,d6
		move.l	d6,(a1)+

loc_4F23E:
		move.w	(a2)+,d6
		swap	d6
		move.w	(a5)+,d6
		neg.w	d6
		add.w	(a6)+,d6
		move.l	d6,(a1)+
		dbf	d0,loc_4F232
		bra.s	loc_4F270
; ---------------------------------------------------------------------------

loc_4F250:
		move.w	(a5)+,d5
		neg.w	d5
		lsr.w	#1,d0
		bcc.s	loc_4F262

loc_4F258:
		move.w	(a2)+,d6
		swap	d6
		move.w	(a6)+,d6
		add.w	d5,d6
		move.l	d6,(a1)+

loc_4F262:
		move.w	(a2)+,d6
		swap	d6
		move.w	(a6)+,d6
		add.w	d5,d6
		move.l	d6,(a1)+
		dbf	d0,loc_4F258

loc_4F270:
		tst.w	d4
		bmi.s	loc_4F288
		move.w	(a4)+,d0
		smi	d7
		bpl.s	loc_4F27E
		andi.w	#$7FFF,d0

loc_4F27E:
		move.w	d4,d5
		sub.w	d0,d4
		bpl.s	loc_4F228
		move.w	d5,d0
		bra.s	loc_4F22A
; ---------------------------------------------------------------------------

loc_4F288:
		swap	d7
		rts

; =============== S U B R O U T I N E =======================================


Apply_FGVScroll:
		lea	(Vscroll_buffer).w,a1
		move.w	(Camera_Y_pos_BG_copy).w,d1
		move.w	(Camera_X_pos_copy).w,d0
		move.w	d0,d2
		andi.w	#$F,d2
		beq.s	loc_4F2A4
		addi.w	#$10,d0

loc_4F2A4:
		lsr.w	#4,d0

loc_4F2A6:
		addq.w	#2,a5
		move.w	(a4)+,d2
		lsr.w	#4,d2
		sub.w	d2,d0
		bpl.s	loc_4F2A6
		neg.w	d0
		moveq	#$13,d2
		sub.w	d0,d2
		bcc.s	loc_4F2BA
		moveq	#$14,d0

loc_4F2BA:
		subq.w	#1,d0

loc_4F2BC:
		move.w	(a5)+,d3

loc_4F2BE:
		move.w	d3,(a1)+
		move.w	d1,(a1)+
		dbf	d0,loc_4F2BE
		tst.w	d2
		bmi.s	locret_4F2D8
		move.w	(a4)+,d0
		lsr.w	#4,d0
		move.w	d2,d3
		sub.w	d0,d2
		bpl.s	loc_4F2BA
		move.w	d3,d0
		bra.s	loc_4F2BC
; ---------------------------------------------------------------------------

locret_4F2D8:
		rts
; End of function Apply_FGVScroll


; =============== S U B R O U T I N E =======================================


Reset_TileOffsetPositionActual:
		move.w	(Camera_X_pos_copy).w,d0
		move.w	d0,d1
		andi.w	#$FFF0,d0
		move.w	d0,(Camera_X_pos_rounded).w
		move.w	(Camera_Y_pos_copy).w,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Camera_Y_pos_rounded).w
		rts
; End of function Reset_TileOffsetPositionActual


; =============== S U B R O U T I N E =======================================


Reset_TileOffsetPositionEff:
		move.w	(Camera_X_pos_BG_copy).w,d0
		move.w	d0,d1
		andi.w	#$FFF0,d0
		move.w	d0,d2
		move.w	d0,(Camera_X_pos_BG_rounded).w
		move.w	(Camera_Y_pos_BG_copy).w,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Camera_Y_pos_BG_rounded).w
		rts
; End of function Reset_TileOffsetPositionEff


; =============== S U B R O U T I N E =======================================


Update_CameraPositionP2:
		move.w	(Camera_X_pos_P2).w,(Camera_X_pos_P2_copy).w
		move.w	(Camera_Y_pos_P2).w,(Camera_Y_pos_P2_copy).w
		rts
; End of function Update_CameraPositionP2

; ---------------------------------------------------------------------------

Update_VScrollValueP2:
		move.w	(Camera_Y_pos_P2_copy).w,d0
		subi.w	#$70,d0
		move.w	d0,(V_scroll_value_P2).w
		move.w	(Camera_Y_pos_P2_BG_copy).w,d0
		subi.w	#$70,d0
		move.w	d0,(V_scroll_value_BG_P2).w
		rts

; =============== S U B R O U T I N E =======================================


SpecialEvents:
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	locret_4F366
		move.w	(Special_events_routine).w,d0
		movea.l	SpecialEvents_Index(pc,d0.w),a0
		jmp	(a0)
; ---------------------------------------------------------------------------
SpecialEvents_Index:
		dc.l locret_4F366
		dc.l AIZ2_DoShipLoop
		dc.l loc_54CB0
		dc.l loc_5560C
		dc.l loc_569BA
		dc.l loc_59E46
; ---------------------------------------------------------------------------

locret_4F366:
		rts
; End of function SpecialEvents


; =============== S U B R O U T I N E =======================================


Adjust_BGDuringLoop:
		move.w	(a1),d1
		move.w	d0,(a1)+
		sub.w	d1,d0
		bpl.s	loc_4F37C
		neg.w	d0
		cmp.w	d2,d0
		blo.s	loc_4F378
		sub.w	d3,d0

loc_4F378:
		sub.w	d0,(a1)+
		rts
; ---------------------------------------------------------------------------

loc_4F37C:
		cmp.w	d2,d0
		blo.s	loc_4F382
		sub.w	d3,d0

loc_4F382:
		add.w	d0,(a1)+
		rts
; End of function Adjust_BGDuringLoop


; =============== S U B R O U T I N E =======================================


Get_BGActualEffectiveDiff:
		move.w	(Camera_X_pos_copy).w,d0
		sub.w	(Camera_X_pos_BG_copy).w,d0
		move.w	d0,(Camera_X_diff).w
		move.w	(Camera_Y_pos_copy).w,d0
		sub.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	d0,(Camera_Y_diff).w
		rts
; End of function Get_BGActualEffectiveDiff


; =============== S U B R O U T I N E =======================================


Offset_SomeObjectsDuringTransition:
		tst.b	(Super_Tails_flag).w
		bne.s	loc_4F3A8
		rts
; ---------------------------------------------------------------------------

loc_4F3A8:
		lea	(Invincibility_stars).w,a1
		moveq	#4-1,d2
		bra.s	loc_4F3B6
; ---------------------------------------------------------------------------

Offset_ObjectsDuringTransition:
		lea	(Dynamic_object_RAM+object_size).w,a1
		moveq	#((Breathing_bubbles)-(Dynamic_object_RAM+object_size))/object_size-1,d2

loc_4F3B6:
		tst.l	(a1)
		beq.s	loc_4F3CA
		btst	#2,render_flags(a1)
		beq.s	loc_4F3CA
		sub.w	d0,x_pos(a1)
		sub.w	d1,y_pos(a1)

loc_4F3CA:
		lea	next_object(a1),a1
		dbf	d2,loc_4F3B6
		rts
; End of function Offset_SomeObjectsDuringTransition


; =============== S U B R O U T I N E =======================================


ShakeScreen_Setup:
		move.w	(Screen_shake_offset).w,(Screen_shake_last_offset).w
		moveq	#0,d1
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	loc_4F406
		move.w	(Screen_shake_flag).w,d0
		beq.s	loc_4F406
		bmi.s	loc_4F3FA
		subq.w	#1,d0					; If EECC is positive, then it's a timed screen shake
		move.w	d0,(Screen_shake_flag).w
		move.b	ScreenShakeArray(pc,d0.w),d1
		ext.w	d1
		bra.s	loc_4F406
; ---------------------------------------------------------------------------

loc_4F3FA:
		move.w	(Level_frame_counter).w,d0		; If EECC is negative, it's a constant screen shake
		andi.w	#$3F,d0
		move.b	ScreenShakeArray2(pc,d0.w),d1

loc_4F406:
		move.w	d1,(Screen_shake_offset).w
		rts
; End of function ShakeScreen_Setup


; =============== S U B R O U T I N E =======================================


ShakeScreen_BG:
		move.w	(Glide_screen_shake).w,d0
		beq.s	locret_4F422
		subq.w	#1,d0
		move.w	d0,(Glide_screen_shake).w
		move.b	ScreenShakeArray(pc,d0.w),d0
		ext.w	d0
		add.w	d0,(Camera_X_pos_copy).w

locret_4F422:
		rts
; End of function ShakeScreen_BG

; ---------------------------------------------------------------------------
ScreenShakeArray:
		dc.b   1, -1,  1, -1,  2, -2,  2, -2,  3, -3,  3, -3,  4, -4,  4, -4
		dc.b   5, -5,  5, -5
ScreenShakeArray2:
		dc.b   1,  2,  1,  3,  1,  2,  2,  1,  2,  3,  1,  2,  1,  2,  0,  0
		dc.b   2,  0,  3,  2,  2,  3,  2,  2,  1,  3,  0,  0,  1,  0,  1,  3
		dc.b   1,  2,  1,  3,  1,  2,  2,  1,  2,  3,  1,  2,  1,  2,  0,  0
		dc.b   2,  0,  3,  2,  2,  3,  2,  2,  1,  3,  0,  0,  1,  0,  1,  3
		even
AIZ1_WaterFGDeformDelta:
		dc.w   1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0
		dc.w   0,  0,  0,  0,  0,  0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
		dc.w  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,  0,  0,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
		dc.w   1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0
		dc.w   0,  0,  0,  0,  0,  0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
		dc.w  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,  0,  0,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
		dc.w   1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0
		dc.w   0,  0,  0,  0,  0,  0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
		dc.w  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,  0,  0,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
		dc.w   1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0
		dc.w   0,  0,  0,  0,  0,  0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
		dc.w  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,  0,  0,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
		dc.w   1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0
		dc.w   0,  0,  0,  0,  0,  0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
AIZ1_WaterBGDeformDelta:
		dc.w   0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1,  1,  1
		dc.w   1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1
		dc.w   1,  1,  1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1
		dc.w   1,  1,  1,  1,  1,  0, -1, -2, -2, -1,  0,  2,  2,  2,  2,  0
		dc.w   0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1,  1,  1
		dc.w   1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1
LBZ_WaterWaveArray2:
		dc.w   1,  1,  1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1
		dc.w   1,  1,  1,  1,  1,  0, -1, -2, -2, -1,  0,  2,  2,  2,  2,  0
		dc.w   0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1,  1,  1
		dc.w   1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1
		dc.w   1,  1,  1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1
		dc.w   1,  1,  1,  1,  1,  0, -1, -2, -2, -1,  0,  2,  2,  2,  2,  0
		dc.w   0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1,  1,  1
		dc.w   1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1
LBZ_WaterWaveArray:
		dc.w   1,  1,  1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1
		dc.w   1,  1,  1,  1,  1,  0, -1, -2, -2, -1,  0,  2,  2,  2,  2,  0
		dc.w   0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1,  1,  1
		dc.w   1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1

; =============== S U B R O U T I N E =======================================


Clear_Switches:
		lea	(Level_trigger_array).w,a1
		moveq	#bytesToLcnt($20),d0

.loop:
		clr.l	(a1)+
		dbf	d0,.loop
		rts
; End of function Clear_Switches

; ---------------------------------------------------------------------------

AIZ1_ScreenInit:
		jsr	Adjust_AIZ1Chunks(pc)
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

AIZ1_ScreenEvent:
		jsr	DrawTilesAsYouMove(pc)
		move.w	(Events_fg_4).w,d0
		beq.w	locret_4F9BE
		cmpi.w	#$2D30,(Camera_X_pos).w		; perform the tree tile manipulation routine when signaled.
		bhs.w	AIZ1SE_ChangeChunk1
		cmpi.w	#$39,d0
		bhs.w	AIZ1SE_ChangeChunk1
		cmpi.w	#$34,d0
		blo.s	loc_4F93C
		bsr.w	AIZ1SE_ChangeChunk2
		bra.s	loc_4F952
; ---------------------------------------------------------------------------

loc_4F93C:
		cmpi.w	#$24,d0
		blo.s	loc_4F948
		bsr.w	AIZ1SE_ChangeChunk3
		bra.s	loc_4F952
; ---------------------------------------------------------------------------

loc_4F948:
		cmpi.w	#$14,d0
		blo.s	loc_4F952
		bsr.w	AIZ1SE_ChangeChunk4


loc_4F952:
		lea	(AIZ_TreeRevealArray).l,a6
		btst	#0,d0
		bne.s	loc_4F962
		lea	$10(a6),a6

loc_4F962:
		subq.w	#1,d0
		lsr.w	#1,d0
		move.w	d0,(Events_bg+$00).w
		cmpi.w	#3,d0
		blo.s	loc_4F976
		move.w	#2,(Events_bg+$00).w

loc_4F976:
		lsl.w	#4,d0
		neg.w	d0
		addi.w	#$470,d0

loc_4F97E:
		cmp.w	(Camera_Y_pos_rounded).w,d0
		bhs.s	loc_4F994
		lea	$20(a6),a6
		addi.w	#$10,d0
		subq.w	#1,(Events_bg+$00).w
		bpl.s	loc_4F97E
		bra.s	AIZ1SE_ChangeChunk1
; ---------------------------------------------------------------------------

loc_4F994:
		move.w	#$2C80,d1
		moveq	#$10,d6
		move.l	a0,-(sp)
		jsr	Setup_TileRowDraw(pc)
		movea.l	(sp)+,a0
		subi.w	#$280,d0
		moveq	#0,d1
		moveq	#$F,d6
		jsr	(AIZ_TreeReveal).l
		lea	$10(a6),a6
		addi.w	#$290,d0
		subq.w	#1,(Events_bg+$00).w
		bpl.s	loc_4F97E

locret_4F9BE:
		rts
; ---------------------------------------------------------------------------

AIZ1SE_ChangeChunk1:
		clr.w	(Events_fg_4).w		; When this is run, all chunks have been changed and the routine need not be run anymore
		movea.w	$14(a3),a1
		movea.w	(a3),a5
		move.b	(a5),$59(a1)
		move.b	1(a5),$5A(a1)

; =============== S U B R O U T I N E =======================================


AIZ1SE_ChangeChunk2:
		movea.w	$18(a3),a1
		movea.w	4(a3),a5
		move.b	(a5),$59(a1)
		move.b	1(a5),$5A(a1)
; End of function AIZ1SE_ChangeChunk2


; =============== S U B R O U T I N E =======================================


AIZ1SE_ChangeChunk3:
		movea.w	$1C(a3),a1
		movea.w	8(a3),a5
		move.b	(a5),$59(a1)
		move.b	1(a5),$5A(a1)
; End of function AIZ1SE_ChangeChunk3


; =============== S U B R O U T I N E =======================================


AIZ1SE_ChangeChunk4:
		movea.w	$20(a3),a1
		movea.w	$C(a3),a5
		move.b	(a5),$59(a1)
		move.b	1(a5),$5A(a1)
		rts
; End of function AIZ1SE_ChangeChunk4

; ---------------------------------------------------------------------------

Obj_AIZ1TreeRevealControl:
		tst.w	$2E(a0)
		beq.s	loc_4FA1E
		tst.w	(Events_fg_4).w
		bne.s	loc_4FA1E
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_4FA1E:
		subq.w	#1,$2E(a0)
		move.w	#$480,d0
		sub.w	(Player_1+y_pos).w,d0
		lsr.w	#3,d0
		addq.w	#3,d0
		cmp.w	(Events_fg_4).w,d0
		bhs.s	loc_4FA3C
		btst	#0,$2F(a0)
		beq.s	locret_4FA40

loc_4FA3C:
		addq.w	#1,(Events_fg_4).w

locret_4FA40:
		rts

; =============== S U B R O U T I N E =======================================


Adjust_AIZ1Chunks:
		cmpi.w	#3,(Player_mode).w
		beq.s	Adjust_AIZ1Chunks2			; Make changes to AIZ's chunk data if playing as Knuckles
		rts
; End of function Adjust_AIZ1Chunks


; =============== S U B R O U T I N E =======================================


Adjust_AIZ1Chunks2:
		lea	(Target_palette_line_4+$10).w,a1
		lea	word_4FAE4(pc),a5
		move.l	(a5)+,(a1)+
		move.l	(a5),(a1)
		lea	($FF4C70).l,a1
		bsr.s	sub_4FAD8
		lea	($FF4CF0).l,a1
		bsr.s	sub_4FAD8
		lea	($FF4D70).l,a1
		bsr.s	sub_4FAD8
		lea	($FF52F0).l,a1
		bsr.s	sub_4FAD8
		lea	($FF4980).l,a1
		bsr.s	sub_4FAD8
		lea	($FF4D80).l,a1
		bsr.s	sub_4FAD8
		lea	($FF3420).l,a1
		bsr.s	sub_4FAD8
		move.w	#$402,(a1)+
		moveq	#6-1,d1
		bsr.s	sub_4FADA
		move.w	#2,(a1)
		lea	($FF3FA0).l,a1
		bsr.s	sub_4FAD8
		addq.w	#4,a1
		move.w	#$C,(a1)+
		move.w	#$406,(a1)+
		move.w	#$4B,(a1)+
		move.w	#$4B,(a1)+
		move.w	#$40A,2(a1)
		lea	($FF5820).l,a1
		move.w	#$40B,(a1)+
		moveq	#6-1,d1
		bsr.s	sub_4FADA
		addq.w	#6,a1
		move.w	#$C,(a1)+
		move.w	#$406,(a1)+
		moveq	#2-1,d1
		bra.s	sub_4FADA
; End of function Adjust_AIZ1Chunks2


; =============== S U B R O U T I N E =======================================


sub_4FAD8:
		moveq	#8-1,d1
; End of function sub_4FAD8


; =============== S U B R O U T I N E =======================================


sub_4FADA:
		moveq	#$4B,d0

loc_4FADC:
		move.w	d0,(a1)+
		dbf	d1,loc_4FADC
		rts
; End of function sub_4FADA

; ---------------------------------------------------------------------------
word_4FAE4:
		dc.w   $EE4,  $EA6,  $E62
word_4FAEA:
		dc.w   $E40
; ---------------------------------------------------------------------------

AIZ1_BackgroundInit:
		cmpi.w	#$1300,(Camera_X_pos).w
		bhs.s	loc_4FB1C
		lea	(HScroll_table).w,a1			; Intro deformation
		moveq	#bytesToLcnt($28),d0

loc_4FAFA:
		clr.l	(a1)+
		dbf	d0,loc_4FAFA
		jsr	(AIZ1_IntroDeform).l
		jsr	Reset_TileOffsetPositionEff(pc)
		jsr	Refresh_PlaneFull(pc)
		lea	(AIZ1_IntroDeformArray).l,a4
		lea	(HScroll_table+$028).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

loc_4FB1C:
		move.w	#8,(Events_routine_bg).w			; If not in the intro
		jsr	(AIZ1_Deform).l
		jsr	Reset_TileOffsetPositionEff(pc)
		clr.l	(HScroll_table).w
		move.w	d2,(HScroll_table+$006).w
		lea	(AIZ1_BGDrawArray).l,a4
		lea	(HScroll_table).w,a5
		jsr	Refresh_PlaneTileDeform(pc)
		jmp	(AIZ1_ApplyDeformWater).l
; ---------------------------------------------------------------------------

AIZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	AIZ1_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

AIZ1_BackgroundEvent_Index:
		bra.w	AIZ1BGE_Intro
; ---------------------------------------------------------------------------
		bra.w	AIZ1BGE_NormalRefresh
; ---------------------------------------------------------------------------
		bra.w	AIZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	AIZ1BGE_FireTransition
; ---------------------------------------------------------------------------
		bra.w	AIZ1BGE_FireRefresh
; ---------------------------------------------------------------------------
		bra.w	AIZ1BGE_Finish
; ---------------------------------------------------------------------------

AIZ1BGE_Intro:
		tst.w	(Events_fg_5).w
		beq.s	loc_4FBA4
		tst.w	(Kos_decomp_queue_count).w
		bne.w	loc_4FBA4
		clr.w	(Events_fg_5).w
		jsr	(AIZ1_Deform).l							; Set up normal deformation when intro is over
		jsr	Reset_TileOffsetPositionEff(pc)
		clr.l	(HScroll_table).w
		move.w	d2,(HScroll_table+$006).w
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w				; Next routine
		bra.s	loc_4FBD0
; ---------------------------------------------------------------------------

loc_4FBA4:
		jsr	(AIZ1_IntroDeform).l
		lea	(AIZ1_IntroDrawArray).l,a4
		lea	(HScroll_table).w,a5
		moveq	#$20,d6
		moveq	#$A,d5
		jsr	Draw_BG(pc)
		lea	(AIZ1_IntroDeformArray).l,a4
		lea	(HScroll_table+$028).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

AIZ1BGE_NormalRefresh:
		jsr	(AIZ1_Deform).l

loc_4FBD0:
		lea	(AIZ1_BGDrawArray).l,a4
		lea	(HScroll_table-$04).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d1
		jsr	Draw_PlaneVertBottomUpComplex(pc)
		bpl.s	loc_4FBF6
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_4FBF6
; ---------------------------------------------------------------------------

AIZ1BGE_Normal:
		tst.w	(Events_fg_5).w
		bne.s	AIZ1_AIZ2_Transition		; Wait for signal to start level transition
		jsr	(AIZ1_Deform).l

loc_4FBF6:
		lea	(AIZ1_BGDrawArray).l,a4
		lea	(HScroll_table).w,a5
		moveq	#$20,d6
		moveq	#2,d5
		jsr	Draw_BG(pc)
		jmp	(AIZ1_ApplyDeformWater).l
; ---------------------------------------------------------------------------

AIZ1_AIZ2_Transition:
		clr.w	(Events_fg_5).w
		lea	(Normal_palette_line_4+$2).w,a1
		move.l	#$4E006E,(a1)+
		move.l	#$AE00CE,(a1)+
		move.l	#$2EE0AEE,(a1)
		move.l	#$200000,(Camera_Y_pos_BG_copy).w
		move.w	#$10,(Camera_Y_pos_BG_rounded).w
		move.w	#$68,(Events_bg+$00).w
		move.w	#4,(Special_V_int_routine).w
		addq.w	#4,(Events_routine_bg).w

AIZ1BGE_FireTransition:
		tst.w	(Events_bg+$02).w
		bne.s	loc_4FC6E
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	loc_4FC74
		move.w	(Events_bg+$00).w,d0
		swap	d0
		clr.w	d0
		sub.l	(Camera_Y_pos_BG_copy).w,d0
		asr.l	#5,d0
		add.l	d0,(Camera_Y_pos_BG_copy).w
		cmpi.l	#$1400,d0
		bhs.s	loc_4FC74

loc_4FC6E:
		jsr	(AIZ1_FireRise).l

loc_4FC74:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	#$1000,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		cmpi.w	#$190,(Camera_Y_pos_BG_copy).w
		blo.w	loc_4FD22
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(AIZ2_128x128_Kos).l,a1
		lea	(RAM_start).l,a2
		jsr	(Queue_Kos).l
		lea	(AIZ2_16x16_Primary_Kos).l,a1
		lea	(Block_table).w,a2
		jsr	(Queue_Kos).l
		lea	(AIZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$AB8).w,a2
		jsr	(Queue_Kos).l
		lea	(AIZ2_8x8_Primary_KosM).l,a1
		move.w	#tiles_to_bytes($000),d2
		jsr	(Queue_Kos_Module).l
		lea	(AIZ2_8x8_Secondary_KosM).l,a1
		move.w	#tiles_to_bytes($1FC),d2
		jsr	(Queue_Kos_Module).l
		lea	(PLC_SpikesSprings).l,a1
		jsr	(Load_PLC_Raw).l
		movem.l	(sp)+,d7-a0/a2-a3
		jsr	(AllocateObject).l
		bne.s	loc_4FD10
		move.l	#Obj_AIZTransitionFloor,(a1)
		move.w	#$2FB0,x_pos(a1)
		move.w	#$3A0,y_pos(a1)

loc_4FD10:
		move.w	#$F0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_4FD32
; ---------------------------------------------------------------------------

loc_4FD22:
		jsr	(AIZTrans_WavyFlame).l
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

AIZ1BGE_FireRefresh:
		jsr	(AIZ1_FireRise).l

loc_4FD32:
		lea	(Level_layout_main).w,a3
		move.w	#VRAM_Plane_A_Name_Table,d7
		move.w	#$180,d1
		moveq	#0,d2
		jsr	Draw_PlaneVertBottomUp(pc)	; Refresh main plane
		bpl.s	loc_4FD52
		addq.w	#2,a3
		move.w	#VRAM_Plane_B_Name_Table,d7
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_4FD62
; ---------------------------------------------------------------------------

loc_4FD52:
		jsr	(AIZTrans_WavyFlame).l
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

AIZ1BGE_Finish:
		jsr	(AIZ1_FireRise).l

loc_4FD62:
		tst.b	(Kos_modules_left).w
		bne.w	loc_4FE2E		; Wait for the art to be loaded
		move.w	#1,(Current_zone_and_act).w	; Officially change this to act 2
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(Respawn_table_keep).w
		jsr	Clear_Switches(pc)
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		jsr	(CheckLevelForWater).l
		moveq	#PalID_AIZFire,d0
		jsr	(LoadPalette_Immediate).l
		movem.l	(sp)+,d7-a0/a2-a3
		jsr	Adjust_AIZ2Layout(pc)
		lea	(Normal_palette_line_4+$2).w,a1
		move.l	#$4E006E,(a1)+
		move.l	#$AE00CE,(a1)+
		move.l	#$2EE0AEE,(a1)
		move.w	#$2F00,d0
		move.w	#$80,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d1,(Player_1+y_pos).w
		sub.w	d0,(Player_2+x_pos).w
		sub.w	d1,(Player_2+y_pos).w
		jsr	Offset_SomeObjectsDuringTransition(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d1,(Camera_Y_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d1,(Camera_Y_pos_copy).w		; Offset objects and camera positions
		move.l	#$100010,d0
		move.l	d0,(Camera_min_X_pos).w
		move.l	#$260,d0
		move.l	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		move.w	(Camera_X_pos_copy).w,(Events_fg_0).w
		move.w	(Camera_X_pos_copy).w,(Events_fg_1).w
		jsr	Reset_TileOffsetPositionActual(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		clr.w	(Events_routine_bg).w

loc_4FE2E:
		jsr	(AIZTrans_WavyFlame).l
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

Obj_AIZTransitionFloor:
		tst.b	(Current_act).w
		beq.s	loc_4FE4A
		move.w	#$7FFF,x_pos(a0)
		move.l	#Delete_Current_Sprite,(a0)

loc_4FE4A:
		move.b	#$10,height_pixels(a0)
		bset	#7,status(a0)
		move.w	#$A0,d1
		moveq	#$10,d2
		moveq	#$10,d3
		move.w	x_pos(a0),d4
		jmp	(SolidObjectTop).l

; =============== S U B R O U T I N E =======================================


Adjust_AIZ2Layout:
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_4FECC
		move.w	#$5B,($FF1020).l		; Only do this if playing as Knuckles
		lea	($FF3420).l,a1
		moveq	#8-1,d1
		bsr.s	sub_4FF00
		move.w	#$CAE,(a1)+
		moveq	#6-1,d1
		bsr.s	sub_4FF00
		move.w	#$8AE,(a1)
		lea	($FF3FA0).l,a1
		moveq	#8-1,d1
		bsr.s	sub_4FF00
		addq.w	#4,a1
		move.w	#$4B6,(a1)+
		move.w	#$4CC,(a1)+
		move.w	#$5B,(a1)+
		move.w	#$5B,(a1)+
		move.w	#$4B7,2(a1)
		lea	($FF5822).l,a1
		moveq	#6-1,d1
		bsr.s	sub_4FF00
		addq.w	#6,a1
		move.w	#$4B6,(a1)+
		move.w	#$4CC,(a1)+
		move.w	#$5B,(a1)+
		move.w	#$5B,(a1)

loc_4FECC:
		movea.w	(Level_layout_main+$0C).w,a1
		movea.w	(Level_layout_main+$40).w,a5
		move.b	$7F(a1),$63(a5)
		movea.w	(Level_layout_main+$0A).w,a1
		movea.w	(Level_layout_main+$1E).w,a5
		bsr.s	sub_4FEF6
		movea.w	(Level_layout_main+$0E).w,a1
		movea.w	(Level_layout_main+$22).w,a5
		bsr.s	sub_4FEF6
		movea.w	(Level_layout_main+$12).w,a1
		movea.w	(Level_layout_main+$26).w,a5
; End of function Adjust_AIZ2Layout


; =============== S U B R O U T I N E =======================================


sub_4FEF6:
		moveq	#4-1,d0

.loop:
		move.b	(a1)+,(a5)+
		dbf	d0,.loop
		rts
; End of function sub_4FEF6


; =============== S U B R O U T I N E =======================================


sub_4FF00:
		moveq	#$5B,d0

.loop:
		move.w	d0,(a1)+
		dbf	d1,.loop
		rts
; End of function sub_4FF00

; ---------------------------------------------------------------------------

AIZ2_ScreenInit:
		jsr	Adjust_AIZ2Layout(pc)
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

AIZ2_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	(Events_routine_fg).w,d0
		jmp	AIZ2_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

AIZ2_ScreenEvent_Index:
		bra.w	AIZ2SE_Normal
; ---------------------------------------------------------------------------
		bra.w	AIZ2SE_ShipRefresh
; ---------------------------------------------------------------------------
		bra.w	AIZ2SE_ShipDraw
; ---------------------------------------------------------------------------
		bra.w	AIZ2SE_EndRefresh
; ---------------------------------------------------------------------------
		bra.w	AIZ2SE_End
; ---------------------------------------------------------------------------

AIZ2SE_Normal:
		tst.w	(Events_fg_4).w
		beq.w	DrawTilesAsYouMove		; Keep drawing as usual while flag isn't set
		clr.w	(Events_fg_4).w
		move.w	#$180,(Draw_delayed_position).w		; Set up redraw memory
		move.w	#5,(Draw_delayed_rowcount).w
		clr.l	(HScroll_table+$1F8).w
		move.w	(Camera_X_pos_copy).w,d0
		andi.w	#$FFF0,d0
		subi.w	#$10,d0
		move.w	d0,(HScroll_table+$1FE).w
		st	(Scroll_lock).w				; Camera doesn't follow Sonic
		move.w	#4,(Special_events_routine).w
		addq.w	#4,(Events_routine_fg).w		; Set speed of automatic movement

AIZ2SE_ShipRefresh:
		move.w	#$4380,d1
		move.w	(Camera_Y_pos_copy).w,d2
		subi.w	#$10,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.w	loc_4FFF0
		move.w	#$4020,d0
		move.w	d0,(HScroll_table+$1F6).w
		move.w	d0,(_unkEE98).w
		clr.w	(_unkEE98+2).w			; Set up secondary BG camera X
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$8F0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(_unkEE9C).w
		move.w	d0,(_unkEEA2).w		; Set up secondary BG camera Y
		jsr	(AllocateObject).l
		bne.s	loc_4FFBA
		move.l	#Obj_AIZBattleship,(a1)	; Start battleship sequence

loc_4FFBA:
		st	(Events_bg+$04).w
		move.l	#HInt7,(H_int_addr).w	; HInt is needed to change Y scroll value to proper amount mid-draw
		clr.b	(Water_flag).w
		move.b	#$40,(H_int_counter).w		; Set HInt position
		addq.w	#4,(Events_routine_fg).w

AIZ2SE_ShipDraw:
		tst.w	(Events_fg_4).w
		bne.s	loc_50008				; Branch when battleship has gone off-screen
		lea	AIZ2SE_BGShipDrawArray2(pc),a4
		lea	(HScroll_table+$1F4).w,a6
		move.w	(_unkEE98).w,(a6)
		moveq	#2,d5
		move.w	(_unkEEA2).w,d6
		jsr	Draw_BGNoVert(pc)

loc_4FFF0:
		lea	AIZ2SE_BGShipDrawArray1(pc),a4
		lea	(HScroll_table+$1F8).w,a6
		move.w	(Camera_X_pos_copy).w,4(a6)
		moveq	#2,d5
		move.w	(Camera_Y_pos_rounded).w,d6
		jmp	Draw_BGNoVert(pc)
; ---------------------------------------------------------------------------

loc_50008:
		clr.w	(Events_fg_4).w
		move.w	#$170,(Draw_delayed_position).w
		move.w	#4,(Draw_delayed_rowcount).w		;Set redraw memory
		addq.w	#4,(Events_routine_fg).w

AIZ2SE_EndRefresh:
		move.w	#$4380,d1
		move.w	(Camera_Y_pos_copy).w,d2
		subi.w	#$10,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_4FFF0
		move.w	(Camera_X_pos_copy).w,d0
		andi.w	#$FFF0,d0
		subi.w	#$10,d0
		move.w	d0,(Camera_X_pos_rounded).w
		move.w	#$46C0,(Events_bg+$02).w		; Set level X start to 46C0
		clr.w	(Events_bg+$04).w
		move.b	#-1,(H_int_counter).w
		addq.w	#4,(Events_routine_fg).w

AIZ2SE_End:
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

HInt7:
		move.w	#$8AFF,(VDP_control_port).l
		move.l	#vdpComm($0000,VSRAM,WRITE),(VDP_control_port).l
		move.w	(Camera_Y_pos_copy).w,(VDP_data_port).l
		rte
; ---------------------------------------------------------------------------
AIZ2SE_BGShipDrawArray1:
		dc.w   $180
		dc.w  $7FFF
AIZ2SE_BGShipDrawArray2:
		dc.w   $A80
		dc.w  $7FFF
; ---------------------------------------------------------------------------

AIZ2_BackgroundInit:
		move.w	(Camera_X_pos_copy).w,(Events_fg_0).w
		move.w	(Camera_X_pos_copy).w,(Events_fg_1).w
		move.w	#$C,(Events_routine_bg).w
		cmpi.w	#$3E80,(Camera_X_pos).w
		blo.s	loc_500A0
		move.w	#$14,(Events_routine_bg).w
		move.w	#$4440,(Events_bg+$02).w

loc_500A0:
		jsr	(AIZ2_Deform).l
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		jmp	(AIZ2_ApplyDeform).l
; ---------------------------------------------------------------------------

AIZ2_BackgroundEvent:
		lea	(Events_fg_0).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		move.w	#$100,d2
		move.w	#$200,d3
		jsr	Adjust_BGDuringLoop(pc)
		move.w	(Events_routine_bg).w,d0
		jmp	AIZ2_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

AIZ2_BackgroundEvent_Index:
		bra.w	AIZ2BGE_FireRedraw
; ---------------------------------------------------------------------------
		bra.w	AIZ2BGE_WaitFire
; ---------------------------------------------------------------------------
		bra.w	AIZ2BGE_BGRedraw
; ---------------------------------------------------------------------------
		bra.w	AIZ2BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	AIZ2BGE_ShipRefresh
; ---------------------------------------------------------------------------
		bra.w	AIZ2BGE_ShipMove
; ---------------------------------------------------------------------------

AIZ2BGE_FireRedraw:
		lea	(Level_layout_main).w,a3
		move.w	#VRAM_Plane_A_Name_Table,d7
		move.w	(Camera_X_pos_copy).w,d1
		move.w	(Camera_Y_pos_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bmi.s	loc_50110
		jsr	(AIZ1_FireRise).l
		jsr	(AIZTrans_WavyFlame).l
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

loc_50110:
		addq.w	#2,a3
		move.w	#VRAM_Plane_B_Name_Table,d7
		clr.w	(Events_bg+$00).w
		addq.w	#4,(Events_routine_bg).w

AIZ2BGE_WaitFire:
		jsr	(AIZ1_FireRise).l
		jsr	(AIZTrans_WavyFlame).l
		tst.w	(Events_bg+$00).w
		bne.s	loc_50160
		move.w	(Camera_Y_pos_BG_copy).w,d0
		andi.w	#$7F,d0
		cmpi.w	#$20,d0
		blo.s	loc_50144
		cmpi.w	#$30,d0
		blo.s	loc_50148

loc_50144:
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

loc_50148:
		addi.w	#$180,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		and.w	(Camera_Y_pos_mask).w,d0
		subi.w	#$10,d0
		move.w	d0,(Camera_Y_pos_BG_rounded).w
		st	(Events_bg+$00).w

loc_50160:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	#$200,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		cmpi.w	#$310,(Camera_Y_pos_BG_copy).w
		blo.s	loc_501D6			; If fire hasn't subsided, branch
		movem.l	d7-a0/a2-a3,-(sp)
		moveq	#PLCID_0C,d0
		jsr	(Load_PLC).l
		jsr	(LoadEnemyArt).l
		movem.l	(sp)+,d7-a0/a2-a3
		lea	(Normal_palette_line_4+$2).w,a1
		move.l	#$8EE00AA,(a1)+
		move.l	#$8E004E,(a1)+
		move.l	#$2E000C,(a1)
		move.w	#$6000,d0
		move.w	d0,(Camera_max_X_pos).w
		jsr	(AIZ2_Deform).l
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w		; Set up Effective BG Y location for screen redraw
		move.w	#$F,(Draw_delayed_rowcount).w		; Set up redraw count
		move.w	#$C,(Special_V_int_routine).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_50204
; ---------------------------------------------------------------------------

loc_501D6:
		jsr	(AIZ2_ApplyDeform).l
		lea	(H_scroll_buffer+2).w,a1
		move.w	(Camera_X_pos_BG_copy).w,d0	; Cancel out background deformation since we're still in the open field
		neg.w	d0
		moveq	#bytesToLcnt(224),d1

loc_501E8:
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		dbf	d1,loc_501E8
		rts
; ---------------------------------------------------------------------------

AIZ2BGE_BGRedraw:
		jsr	(AIZ2_Deform).l

loc_50204:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_50260
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_50260
; ---------------------------------------------------------------------------

AIZ2BGE_Normal:
		jsr	(AIZ2_Deform).l
		tst.w	(Events_fg_5).w
		beq.s	loc_50260
		clr.w	(Events_fg_5).w
		move.w	#$A8,d0
		cmpi.w	#$400,(Camera_Y_pos).w
		blo.s	loc_50236
		move.w	#-$198,d0

loc_50236:
		move.w	d0,(Events_bg+$16).w
		add.w	d0,(Camera_Y_pos_BG_copy).w
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		move.w	#$4440,(Events_bg+$02).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_50280
; ---------------------------------------------------------------------------

loc_50260:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		jsr	(AIZ2_ApplyDeform).l
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

AIZ2BGE_ShipRefresh:
		jsr	(AIZ2_Deform).l

loc_50280:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_50298
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_50298
; ---------------------------------------------------------------------------

AIZ2BGE_ShipMove:
		jsr	(AIZ2_Deform).l

loc_50298:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		jsr	(AIZ2_ApplyDeform).l
		tst.w	(Events_bg+$04).w
		beq.s	loc_502C2
		move.w	(_unkEE9C).w,(V_scroll_value).w		; Use effective camera position rather than actual camera position
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp		; Skip last part of ScreenEvents

loc_502C2:
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

AIZ2_DoShipLoop:
		clr.w	(Level_repeat_offset).w
		move.w	(Camera_X_pos).w,d0
		addq.w	#4,d0
		cmp.w	(Events_bg+$02).w,d0
		blo.s	loc_502FA
		move.w	#$200,d1			; Do loop
		move.w	d1,(Level_repeat_offset).w
		sub.w	d1,(Player_1+x_pos).w
		sub.w	d1,(Player_2+x_pos).w	; Subtract $200 from X position of Sonic and Tails
		sub.w	d1,d0
		move.w	d0,d1
		andi.w	#$FFF0,d1
		subi.w	#$10,d1
		move.w	d1,(Camera_X_pos_rounded).w
		move.w	d1,(HScroll_table+$1FE).w

loc_502FA:
		move.w	d0,(Camera_X_pos).w
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w	; Set all the camera/start positions
		move.w	d0,d1
		lea	(Player_1).w,a1
		bsr.s	sub_50318
		move.w	d1,d0
		lea	(Player_2).w,a1

; =============== S U B R O U T I N E =======================================


sub_50318:
		cmpi.b	#5,anim(a1)
		bne.s	loc_50324
		clr.b	anim(a1)				; If Sonic is standing, set him to the running animation

loc_50324:
		addi.w	#$18,d0
		cmp.w	x_pos(a1),d0
		bls.s	loc_5033A
		move.w	d0,x_pos(a1)			; Make sure Sonic stays on-screen
		move.w	#$400,ground_vel(a1)		; Set his running velocity to $400 if the left of screen is hit
		bra.s	locret_50348
; ---------------------------------------------------------------------------

loc_5033A:
		addi.w	#$88,d0
		cmp.w	x_pos(a1),d0
		bhi.s	locret_50348
		move.w	d0,x_pos(a1)			; Make sure Sonic can't go past a certain point to the right

locret_50348:
		rts
; End of function sub_50318

; ---------------------------------------------------------------------------

Obj_AIZBattleship:
		move.l	#Obj_AIZBattleshipMain,(a0)
		move.l	#AIZBattleship_BombScript,$2E(a0)
		move.w	#$1A4,$32(a0)
		move.w	#$3FBC,d1
		moveq	#2-1,d2

loc_50364:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_5037E
		move.l	#Obj_BattleshipPropeller,(a1)	; Create two propellers, one at the front and one in the back
		move.w	d1,$2E(a1)
		move.w	#$3DCC,d1
		dbf	d2,loc_50364

loc_5037E:
		lea	(Normal_palette_line_2).w,a1
		lea	(Pal_AIZBattleship).l,a5
		moveq	#bytesToLcnt($20),d0

loc_5038A:
		move.l	(a5)+,(a1)+
		dbf	d0,loc_5038A

Obj_AIZBattleshipMain:
		subi.l	#$8800,(_unkEE98).w
		move.w	(_unkEE98).w,d0
		cmpi.w	#$3CDC,d0
		bpl.s	loc_503BC
		move.l	#Obj_AIZ2BossSmall,(a0)
		st	(Events_fg_4).w				; Set for the next screen event
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_503BA
		move.l	#Obj_AIZ2MakeTree,(a1)

locret_503BA:
		rts
; ---------------------------------------------------------------------------

loc_503BC:
		move.w	d0,d1
		subi.w	#$3D5C,d0
		bpl.s	loc_503D2
		neg.w	d0					; Move upwards as the battleship goes offscreen
		asr.w	#1,d0
		add.w	(_unkEEA2).w,d0
		move.w	d0,(_unkEE9C).w
		bra.s	loc_503EA
; ---------------------------------------------------------------------------

loc_503D2:
		asr.w	#2,d1			; Continue bobbing up and down
		andi.w	#$F,d1
		lea	(AIZBattleShip_BobbingMotion).l,a1
		move.b	(a1,d1.w),d1
		add.w	(_unkEEA2).w,d1
		move.w	d1,(_unkEE9C).w	; Get the bobbing motion delta, apply it to the second camera Y

loc_503EA:
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	loc_503FE
		moveq	#signextendB(sfx_LargeShip),d0			; Replay the battleship flying sound every 16th frame
		jsr	(Play_SFX).l

loc_503FE:
		subq.w	#1,$32(a0)			; Wait for delay to finish
		bcc.s	locret_50424
		movea.l	$2E(a0),a2
		move.w	(a2)+,$32(a0)		; Get the first word of the bomb script as the new delay
		bmi.s	locret_50424
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_50424
		move.l	#Obj_AIZShipBomb,(a1)		; Create a new bomb
		move.w	(a2)+,$2E(a1)		; Put the X position into $2E so it can be translated
		move.l	a2,$2E(a0)			; Update the script position

locret_50424:
		rts
; ---------------------------------------------------------------------------

Obj_BattleshipPropeller:
		move.l	#Obj_BattleshipPropellerMain,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$20,height_pixels(a0)
		move.b	#8,width_pixels(a0)
		move.w	#$80,priority(a0)
		move.w	#make_art_tile(ArtTile_AIZ2Bombership,0,0),art_tile(a0)
		move.l	#Map_AIZShipPropeller,mappings(a0)
		move.w	#$A71,$30(a0)

Obj_BattleshipPropellerMain:
		cmpi.w	#$C,(Events_routine_fg).w
		bne.s	loc_50466
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_50466:
		lea	(Ani_AIZShipPropeller).l,a1
		jsr	(Animate_Sprite).l
		jsr	Translate_Camera2ObjPosition(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_AIZShipBomb:
		move.l	#Obj_AIZShipBombMain,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$18,width_pixels(a0)
		move.w	#$80,priority(a0)
		move.w	#make_art_tile(ArtTile_AIZ2Bombership,0,0),art_tile(a0)
		move.l	#Map_AIZ2BombExplode,mappings(a0)
		move.b	#$10,y_radius(a0)
		move.w	#$A60,$30(a0)
		move.w	#6,$32(a0)

Obj_AIZShipBombMain:
		moveq	#0,d0
		move.b	routine(a0),d0
		jmp	AIZShipBomb_Index(pc,d0.w)
; ---------------------------------------------------------------------------

AIZShipBomb_Index:
		bra.w	AIZShipBomb_ReadyDrop
; ---------------------------------------------------------------------------
		bra.w	AIZShipBomb_Delay
; ---------------------------------------------------------------------------
		bra.w	AIZShipBomb_Drop
; ---------------------------------------------------------------------------

AIZShipBomb_ReadyDrop:
		addq.w	#2,$30(a0)
		cmpi.w	#$A80,$30(a0)		; Put bomb into position before delay
		blo.s	loc_504EE
		addq.b	#4,routine(a0)
		bra.s	loc_504EE
; ---------------------------------------------------------------------------

AIZShipBomb_Delay:
		subq.w	#1,$32(a0)
		bne.s	loc_504EE
		addq.b	#4,routine(a0)
		moveq	#signextendB(sfx_MissileThrow),d0
		jsr	(Play_SFX).l		; Play the drop sound after the delay

loc_504EE:
		jsr	Translate_Camera2ObjPosition(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

AIZShipBomb_Drop:
		move.l	y_pos(a0),d0
		add.l	y_vel(a0),d0
		move.l	d0,y_pos(a0)			; Drop bomb downwards
		addi.l	#$2000,y_vel(a0)		; Increase acceleration
		swap	d0
		jsr	Translate_Camera2ObjX(pc)
		jsr	(Draw_Sprite).l
		jsr	(ObjCheckFloorDist).l
		cmpi.w	#-8,d1
		bgt.s	locret_50578
		move.w	#$10,(Screen_shake_flag).w	; If touching the floor, set up a timed screen shake
		moveq	#signextendB(sfx_MissileExplode),d0
		jsr	(Play_SFX).l		; Play the bomb explosion sound
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_50572
		lea	(AIZBombExplodeDat).l,a2
		moveq	#8-1,d1

loc_50542:
		move.l	#Obj_AIZBombExplosion,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.w	(a2)+,d2
		add.w	d2,x_pos(a1)
		move.w	(a2)+,d2
		add.w	d2,y_pos(a1)
		move.w	(a2)+,anim(a1)
		move.w	(a2)+,$2E(a1)
		jsr	(CreateNewSprite4).l
		dbne	d1,loc_50542

loc_50572:
		move.l	#Delete_Current_Sprite,(a0)		; Delete the bomb sprite

locret_50578:
		rts

; =============== S U B R O U T I N E =======================================


Translate_Camera2ObjPosition:
		move.w	$30(a0),d0
		sub.w	(_unkEE9C).w,d0
		add.w	(Camera_Y_pos_copy).w,d0

Translate_Camera2ObjX:
		sub.w	(Screen_shake_last_offset).w,d0
		add.w	(Screen_shake_offset).w,d0
		move.w	d0,y_pos(a0)
		move.w	$2E(a0),d0
		sub.w	(_unkEE98).w,d0
		add.w	(Camera_X_pos_copy).w,d0
		move.w	d0,x_pos(a0)
		rts
; End of function Translate_Camera2ObjPosition

; ---------------------------------------------------------------------------

Obj_AIZBombExplosion:
		move.w	(Level_repeat_offset).w,d0
		sub.w	d0,x_pos(a0)
		subq.w	#1,$2E(a0)
		bmi.s	loc_505B4
		rts
; ---------------------------------------------------------------------------

loc_505B4:
		move.l	#Obj_AIZBombExplosionAnim,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$20,width_pixels(a0)
		move.w	#make_art_tile(ArtTile_AIZ2Bombership,0,0),art_tile(a0)
		move.l	#Map_AIZ2BombExplode,mappings(a0)
		move.b	#$8B,collision_flags(a0)
		bra.s	loc_505E4
; ---------------------------------------------------------------------------

Obj_AIZBombExplosionAnim:
		move.w	(Level_repeat_offset).w,d0
		sub.w	d0,x_pos(a0)

loc_505E4:
		lea	(Ani_AIZ2BombExplode).l,a1
		jsr	(Animate_SpriteIrregularDelay).l
		tst.b	routine(a0)
		beq.s	loc_505FC
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_505FC:
		moveq	#4,d0
		add.b	anim(a0),d0
		cmp.b	mapping_frame(a0),d0
		bls.s	loc_5060E
		jsr	(Add_SpriteToCollisionResponseList).l

loc_5060E:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_AIZ2MakeTree:
		cmpi.w	#$44D0,(Camera_X_pos).w
		bhs.s	loc_5061E
		rts
; ---------------------------------------------------------------------------

loc_5061E:
		move.l	#loc_50632,(a0)
		move.w	(Events_fg_1).w,$2E(a0)
		move.l	#AIZMakeTreeScript,$30(a0)

loc_50632:
		movea.l	$30(a0),a2
		tst.w	(a2)
		bpl.s	loc_50640
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_50640:
		move.w	(Events_fg_1).w,d0
		sub.w	$2E(a0),d0
		cmp.w	(a2)+,d0
		blo.s	locret_50662
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_50662
		move.l	#Obj_AIZ2BGTree,(a1)
		move.w	(a2)+,8(a1)
		move.l	a2,$30(a0)

locret_50662:
		rts
; ---------------------------------------------------------------------------

Obj_AIZ2BGTree:
		move.l	#Obj_AIZ2BGTreeMove,(a0)
		move.w	#make_art_tile(ArtTile_AIZBackgroundTree,0,0),art_tile(a0)
		move.l	#Map_AIZ2BGTree,mappings(a0)
		move.w	#$E9,y_pos(a0)
		move.w	#$1C0,$2E(a0)
		move.w	(Events_fg_1).w,$30(a0)

Obj_AIZ2BGTreeMove:
		cmpi.w	#$4880,(Camera_X_pos).w
		blo.s	loc_50698
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_50698:
		move.w	(Events_fg_1).w,d0
		sub.w	$30(a0),d0
		move.w	d0,d1
		asr.w	#2,d0
		sub.w	d0,d1
		move.w	$2E(a0),d0
		sub.w	d1,d0
		move.w	d0,x_pos(a0)
		cmpi.w	#$1C0,d0
		bhs.s	locret_506BC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locret_506BC:
		rts
; ---------------------------------------------------------------------------

Obj_AIZ2BossSmall:
		move.l	#Obj_AIZ2BossSmallMain,(a0)
		move.w	#$300,priority(a0)
		move.w	#make_art_tile(ArtTile_AIZ2Bombership,0,0),art_tile(a0)
		move.l	#Map_AIZ2BossSmall,mappings(a0)
		move.w	#$30,x_pos(a0)
		move.w	#$D8,y_pos(a0)
		move.w	#5,x_vel(a0)
		clr.w	$2E(a0)
		lea	(Normal_palette_line_2+$2).w,a1
		lea	(Pal_AIZBossSmall).l,a5
		moveq	#bytesToLcnt($1C),d0

loc_506FA:
		move.l	(a5)+,(a1)+
		dbf	d0,loc_506FA

Obj_AIZ2BossSmallMain:
		tst.b	$2E(a0)
		bne.s	loc_50712
		cmpi.w	#$4670,(Camera_X_pos).w
		blo.s	locret_5077C
		st	$2E(a0)

loc_50712:
		cmpi.w	#$240,x_pos(a0)
		blo.s	loc_50732
		clr.b	(Scroll_lock).w
		clr.w	(Special_events_routine).w
		clr.w	(Level_repeat_offset).w			; Stop repeating scrolling section
		move.w	#$6000,(Camera_max_X_pos).w	; Change level size
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_50732:
		move.l	x_pos(a0),d0
		move.l	x_vel(a0),d1		; Move Robotnik
		add.l	d1,d0
		move.l	d0,x_pos(a0)
		tst.b	$2F(a0)
		bne.s	loc_50758
		subi.l	#$E80,d1		; Phase 1: Slow down until moving slightly to the left
		cmpi.l	#-$10000,d1
		sle	$2F(a0)
		bra.s	loc_5075E
; ---------------------------------------------------------------------------

loc_50758:
		addi.l	#$E80,d1		; Phase 2: Speed up till moving off screen

loc_5075E:
		move.l	d1,x_vel(a0)
		jsr	(Draw_Sprite).l
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	locret_5077C
		moveq	#signextendB(sfx_RobotnikSiren),d0		; Every sixteenth frame, play alarm sound
		jsr	(Play_SFX).l

locret_5077C:
		rts
; ---------------------------------------------------------------------------
AIZ2_SOZ1_LRZ3_FGDeformDelta:
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
AIZ2_ALZ_BGDeformDelta:
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
; ---------------------------------------------------------------------------

HCZ1_ScreenInit:
		clr.w	(Events_bg+$16).w
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

HCZ1_ScreenEvent:
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

HCZ1_BackgroundInit:
		jsr	HCZ1_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		moveq	#$60,d0
		cmp.w	(Events_bg+$10).w,d0
		blt.s	loc_50BAC
		neg.w	d0
		cmp.w	(Events_bg+$10).w,d0
		bgt.s	loc_50BB0

loc_50BAC:
		move.w	d0,(Events_bg+$10).w		; Cap dynamic art reloading value at $60 either way

loc_50BB0:
		lea	(HCZ1_BGDeformArray).l,a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

HCZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	HCZ1_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

HCZ1_BackgroundEvent_Index:
		bra.w	HCZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	HCZ1BGE_DoTransition
; ---------------------------------------------------------------------------

HCZ1BGE_Normal:
		tst.w	(Events_fg_5).w
		beq.s	loc_50C2A
		clr.w	(Events_fg_5).w				; Do transition
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(HCZ2_128x128_Secondary_Kos).l,a1
		lea	(RAM_start+$A00).l,a2
		jsr	(Queue_Kos).l
		lea	(HCZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$558).w,a2
		jsr	(Queue_Kos).l
		lea	(HCZ2_8x8_Secondary_KosM).l,a1	; Load secondary HCZ2 art, blocks, and chunks so as to not compromise current position
		move.w	#tiles_to_bytes($11B),d2
		jsr	(Queue_Kos_Module).l
		moveq	#PLCID_10,d0
		jsr	(Load_PLC).l
		moveq	#PLCID_11,d0
		jsr	(Load_PLC).l					; load HCZ 2 PLCs
		movem.l	(sp)+,d7-a0/a2-a3
		st	(Events_bg+$16).w
		addq.w	#4,(Events_routine_bg).w

loc_50C2A:
		jsr	HCZ1_Deform(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	(HCZ1_BGDeformArray).l,a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

HCZ1BGE_DoTransition:
		tst.b	(Kos_modules_left).w
		bne.w	loc_50CDC			; Don't do anything else until Kos queue has been cleared
		move.w	#$101,(Current_zone_and_act).w	; Change the act
		clr.b	(Dynamic_resize_routine).w		; Reload resize routine counter
		clr.b	(Object_load_routine).w		; Reload sprite manager
		clr.b	(Rings_manager_routine).w		; Reload ring manager
		clr.b	(Boss_flag).w		; Unlock the screen
		clr.b	(Respawn_table_keep).w		; Refresh sprite/ring memory
		jsr	Clear_Switches(pc)
		move.l	#Obj_HCZWaterSplash,(Dynamic_object_RAM+(object_size*2)).w	; Load the splash object
		move.b	#1,(Dynamic_object_RAM+(object_size*2)+subtype).w
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l				; Load HCZ2 layout
		jsr	(LoadSolids).l
		jsr	(CheckLevelForWater).l
		move.w	#$6A0,d0
		move.w	d0,(Water_level).w
		move.w	d0,(Mean_water_level).w
		move.w	d0,(Target_water_level).w	; Set the water up
		moveq	#PalID_HCZ2,d0
		jsr	(LoadPalette_Immediate).l	; Load HCZ2 palette
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$3600,d0
		moveq	#0,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d0,(Player_2+x_pos).w
		jsr	Offset_ObjectsDuringTransition(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w		; Offset objects/camera position by specified amount
		jsr	Reset_TileOffsetPositionActual(pc)
		clr.w	(Events_routine_bg).w

loc_50CDC:
		jsr	HCZ1_Deform(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	(HCZ1_BGDeformArray).l,a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)

; =============== S U B R O U T I N E =======================================


HCZ1_Deform:
		move.w	(Camera_Y_pos_copy).w,d0		; Get the BG camera Y position
		subi.w	#$610,d0				; Get the difference between that and the water line equilibrium point
		move.w	d0,d1
		asr.w	#2,d0
		move.w	d0,d2
		addi.w	#$190,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w		; The effective BG Y is negative when the BG is above the water line, positive when otherwise
		sub.w	d1,d2					; The difference between the effective BG Y and the actual BG Y difference is what's used to calculate how the water line should be drawn
		move.w	d2,(Events_bg+$10).w
		move.w	(Camera_X_pos_copy).w,d0		; Get the camera BG X
		swap	d0
		clr.w	d0
		tst.w	d2
		beq.w	loc_50DDA		; If equilibrium point, branch
		move.l	d0,d1
		move.l	d0,d3			; Set up deformation scroll value
		asr.l	#7,d3
		moveq	#$30-1,d4
		cmpi.w	#-$60,d2
		bgt.s	loc_50D52
		lea	(HScroll_table+$01A).w,a1	; If background is high enough that water line doesn't have to be messed with, just apply the standard formation to it

loc_50D3A:
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		sub.l	d3,d1
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		sub.l	d3,d1
		dbf	d4,loc_50D3A
		bra.w	loc_50DDA		; Then finish it up
; ---------------------------------------------------------------------------

loc_50D52:
		lea	(HScroll_table+$19A).w,a1

loc_50D56:
		swap	d1				; If background camera is lower, then apply water line deformation backwards
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		swap	d1
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		dbf	d4,loc_50D56
		cmpi.w	#$60,d2
		bge.s	loc_50DDA		; If background camera is low enough that water line doesn't need to be messed with, then end it.
		lea	(HScroll_table+$0DA).w,a1	; Otherwise, the fun begins
		lea	(a1),a5
		lea	(HCZ_WaterlineScroll_Data).l,a6
		move.w	d2,d1
		bmi.s	loc_50DAE
		move.w	d1,d3			; If waterline is displayed below water level
		neg.w	d3
		addi.w	#$60,d3
		lsl.w	#5,d3
		adda.w	d3,a6
		add.w	d3,d3
		adda.w	d3,a6			; Set up area of water line scroll data to use based on position
		subq.w	#1,d1
		moveq	#0,d3
		lsr.w	#1,d1
		bcc.s	loc_50DA0

loc_50D98:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),(a1)+

loc_50DA0:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),(a1)+	; Apply scroll data
		dbf	d1,loc_50D98
		bra.s	loc_50DDA
; ---------------------------------------------------------------------------

loc_50DAE:
		move.w	d1,d3			; If waterline is displayed above water level
		addi.w	#$60,d3
		lsl.w	#5,d3
		adda.w	d3,a6
		add.w	d3,d3
		adda.w	d3,a6			; Set up area of water line scroll data to use based on position
		neg.w	d1
		subq.w	#1,d1
		moveq	#0,d3
		lsr.w	#1,d1
		bcc.s	loc_50DCE

loc_50DC6:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),-(a1)

loc_50DCE:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),-(a1)	; Apply scroll data
		dbf	d1,loc_50DC6

loc_50DDA:
		move.l	d0,d1			; Get BG X again
		asr.l	#2,d0
		asr.l	#5,d1
		lea	(HScroll_table).w,a1
		swap	d0
		move.w	d0,(a1)
		move.w	d0,$18(a1)
		move.w	d0,d3
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,2(a1)
		move.w	d0,$16(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,4(a1)
		move.w	d0,$14(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,6(a1)
		move.w	d0,$12(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,8(a1)
		move.w	d0,$10(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,$A(a1)
		move.w	d0,$E(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,$C(a1)
		move.w	d0,$19A(a1)
		move.w	d0,d4
		tst.w	d2
		bpl.s	loc_50E68
		lea	(HScroll_table+$0DA).w,a1	; Water line above water
		moveq	#$30-1,d0

loc_50E4E:
		move.w	d4,(a1)+
		move.w	d4,(a1)+
		dbf	d0,loc_50E4E
		moveq	#$60-1,d0
		add.w	d2,d0
		bmi.s	locret_50E86
		lea	(HScroll_table+$01A).w,a1

loc_50E60:
		move.w	d3,(a1)+
		dbf	d0,loc_50E60
		bra.s	locret_50E86
; ---------------------------------------------------------------------------

loc_50E68:
		lea	(HScroll_table+$01A).w,a1	; Water line below water
		moveq	#$30-1,d0

loc_50E6E:
		move.w	d3,(a1)+
		move.w	d3,(a1)+
		dbf	d0,loc_50E6E
		moveq	#$60-1,d0
		sub.w	d2,d0
		bmi.s	locret_50E86
		lea	(HScroll_table+$19A).w,a1

loc_50E80:
		move.w	d4,-(a1)
		dbf	d0,loc_50E80

locret_50E86:
		rts
; End of function HCZ1_Deform

; ---------------------------------------------------------------------------

HCZ2_ScreenInit:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

HCZ2_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

HCZ2_BackgroundInit:
		cmpi.w	#$C00,(Camera_X_pos).w
		bhs.s	loc_50ED0
		cmpi.w	#$500,(Camera_Y_pos).w
		blo.s	loc_50ED0
		move.w	#4,(Events_routine_bg).w	; Special deformation occurs when camera X is less than $C00 and
		jsr	(AllocateObject).l		; camera Y is greater than $500
		bne.s	loc_50EC0
		move.l	#Obj_HCZ2Wall,(a1)

loc_50EC0:
		jsr	HCZ2_WallMove(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		jsr	Refresh_PlaneFull(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

loc_50ED0:
		move.w	#$10,(Events_routine_bg).w			; Normal deformation
		jsr	HCZ2_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	(HCZ2_BGDeformArray).l,a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

HCZ2_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	HCZ2_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

HCZ2_BackgroundEvent_Index:
		bra.w	HCZ2BGE_WallMoveInit
; ---------------------------------------------------------------------------
		bra.w	HCZ2BGE_WallMove
; ---------------------------------------------------------------------------
		bra.w	HCZ2BGE_NormalTransition
; ---------------------------------------------------------------------------
		bra.w	HCZ2BGE_NormalRefresh
; ---------------------------------------------------------------------------
		bra.w	HCZ2BGE_Normal
; ---------------------------------------------------------------------------

HCZ2BGE_WallMoveInit:
		jsr	(AllocateObject).l
		bne.s	loc_50F1C
		move.l	#Obj_HCZ2Wall,(a1)

loc_50F1C:
		addq.w	#4,(Events_routine_bg).w

HCZ2BGE_WallMove:
		tst.w	(Events_fg_5).w
		bne.s	loc_50F64
		jsr	HCZ2_WallMove(pc)
		jsr	DrawBGAsYouMove(pc)
		jsr	PlainDeformation(pc)
		jsr	ShakeScreen_Setup(pc)
		jsr	Get_BGActualEffectiveDiff(pc)
		clr.b	(Background_collision_flag).w
		move.w	(Player_1+x_pos).w,d0
		cmpi.w	#$3F0,d0
		blo.s	locret_50F62
		cmpi.w	#$C10,d0
		bhs.s	locret_50F62
		move.w	(Player_1+y_pos).w,d0
		cmpi.w	#$600,d0
		blo.s	locret_50F62
		cmpi.w	#$840,d0
		bhs.s	locret_50F62
		st	(Background_collision_flag).w			; Only enable BG tile collision if player is within above parameters

locret_50F62:
		rts
; ---------------------------------------------------------------------------

loc_50F64:
		clr.w	(Events_fg_5).w
		tst.w	(Screen_shake_flag).w
		bpl.s	loc_50F72
		clr.w	(Screen_shake_flag).w		; Disable screen shaking if still constant

loc_50F72:
		clr.b	(Background_collision_flag).w
		move.w	#$F0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w

HCZ2BGE_NormalTransition:
		move.w	#$400,d1
		moveq	#0,d2
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.w	PlainDeformation
		jsr	HCZ2_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_50FB8
; ---------------------------------------------------------------------------

HCZ2BGE_NormalRefresh:
		jsr	HCZ2_Deform(pc)

loc_50FB8:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_50FCE
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_50FCE
; ---------------------------------------------------------------------------

HCZ2BGE_Normal:
		jsr	HCZ2_Deform(pc)

loc_50FCE:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	(HCZ2_BGDeformArray).l,a4
		lea	(HScroll_table).w,a5
		jsr	ApplyDeformation(pc)
		jmp	ShakeScreen_Setup(pc)

; =============== S U B R O U T I N E =======================================


HCZ2_WallMove:
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	loc_51052			; If player is dead, don't bother
		move.l	#$E000,d0
		cmpi.w	#$A88,(Player_1+x_pos).w
		blo.s	loc_5100C
		move.l	#$14000,d0			; Speed up if player has passed the end already

loc_5100C:
		move.w	(Events_bg+$00).w,d1
		beq.s	loc_5102E
		cmpi.w	#-$600,d1
		bgt.s	loc_5103A
		tst.w	(Screen_shake_flag).w		; When wall has travelled $600 pixels
		bpl.s	loc_51052
		move.w	#$E,(Screen_shake_flag).w	; Set screen shake to timed
		moveq	#signextendB(sfx_Crash),d0
		jsr	(Play_SFX).l		; Play final crashing sound
		bra.s	loc_51052
; ---------------------------------------------------------------------------

loc_5102E:
		cmpi.w	#$680,(Player_1+x_pos).w
		blo.s	loc_51052			; If wall hasn't started moving and player hasn't moved far enough, end.
		st	(Screen_shake_flag).w			; Begin constant screen shake movement

loc_5103A:
		sub.l	d0,(Events_bg+$00).w	; Subtract speed from BG X offset
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	loc_51052
		moveq	#signextendB(sfx_Rumble2),d0
		jsr	(Play_SFX).l		; Play the screen shake sound every 16th frame

loc_51052:
		move.w	(Camera_Y_pos_copy).w,d0	; Get BG camera Y
		subi.w	#$500,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w	; Offset it by $500 and put it in effective BG Y
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$200,d0
		add.w	(Events_bg+$00).w,d0
		move.w	d0,(Camera_X_pos_BG_copy).w	; Do the same with the BG Camera X, offsetting it by the wall movement amount
		rts
; End of function HCZ2_WallMove


; =============== S U B R O U T I N E =======================================


HCZ2_Deform:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Screen_shake_offset).w,d1
		sub.w	d1,d0
		asr.w	#2,d0
		add.w	d1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#3,d1
		lea	(HScroll_table).w,a1
		lea	(HCZ2_BGDeformIndex).l,a5
		moveq	#0,d2

loc_5109C:
		move.b	(a5)+,d3
		bmi.s	loc_510B4
		ext.w	d3
		swap	d0

loc_510A4:
		move.b	(a5)+,d2
		move.w	d0,(a1,d2.w)
		dbf	d3,loc_510A4
		swap	d0
		sub.l	d1,d0
		bra.s	loc_5109C
; ---------------------------------------------------------------------------

loc_510B4:
		move.w	$12(a1),d0
		sub.w	$A(a1),d0
		move.w	d0,(Events_bg+$10).w
		move.w	6(a1),d0
		sub.w	$12(a1),d0
		move.w	d0,(Events_bg+$12).w
		move.w	4(a1),d0
		sub.w	$12(a1),d0
		move.w	d0,(Events_bg+$14).w
		rts
; End of function HCZ2_Deform

; ---------------------------------------------------------------------------

Obj_HCZ2Wall:
		cmpi.w	#4,(Events_routine_bg).w
		beq.s	loc_510E8
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_510E8:
		move.w	(Events_bg+$00).w,d4
		neg.w	d4
		addi.w	#$5BE,d4
		move.w	d4,x_pos(a0)
		move.w	#$700,y_pos(a0)
		move.b	#$40,width_pixels(a0)
		bset	#7,status(a0)
		moveq	#$4B,d1
		move.w	#$100,d2
		move.w	#$100,d3
		jmp	(SolidObjectFull2).l
; ---------------------------------------------------------------------------

MGZ1_ScreenInit:
		clr.w	(Events_bg+$16).w
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

MGZ1_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		jsr	Do_ShakeSound(pc)
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

MGZ1_BackgroundInit:
		jsr	(MGZ1_Deform).l
		moveq	#0,d0
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	(MGZ1_BGDeformArray).l,a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

MGZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	MGZ1_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

MGZ1_BackgroundEvent_Index:
		bra.w	MGZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	MGZ1BGE_Transition
; ---------------------------------------------------------------------------

MGZ1BGE_Normal:
		tst.w	(Events_fg_5).w
		beq.s	loc_511B0
		clr.w	(Events_fg_5).w			; Transition time
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(MGZ2_128x128_Secondary_Kos).l,a1
		lea	(RAM_start+$6B00).l,a2
		jsr	(Queue_Kos).l
		lea	(MGZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$C60).w,a2
		jsr	(Queue_Kos).l
		lea	(MGZ2_8x8_Secondary_KosM).l,a1
		move.w	#tiles_to_bytes($252),d2
		jsr	(Queue_Kos_Module).l		; Queue art, blocks and chunks for act 2
		moveq	#PLCID_14,d0
		jsr	(Load_PLC).l					; Load act 2 PLCs
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(Events_routine_bg).w

loc_511B0:
		jsr	(MGZ1_Deform).l					; Pretty self-explanatory to be honest
		lea	(MGZ1_BGDeformArray).l,a4
		lea	(HScroll_table).w,a5
		jsr	ApplyDeformation(pc)
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

MGZ1BGE_Transition:
		tst.b	(Kos_modules_left).w
		bne.w	loc_51268				; Wait for Kos queue to finish
		move.w	#$201,(Current_zone_and_act).w		; Change act
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(Respawn_table_keep).w			; Reset various managers
		jsr	Clear_Switches(pc)
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		moveq	#PalID_MGZ2,d0
		jsr	(LoadPalette_Immediate).l
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$2E00,d0
		move.w	#$600,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d1,(Player_1+y_pos).w
		sub.w	d0,(Player_2+x_pos).w
		sub.w	d1,(Player_2+y_pos).w
		jsr	Offset_ObjectsDuringTransition(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d1,(Camera_Y_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d1,(Camera_Y_pos_copy).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w
		sub.w	d1,(Camera_min_Y_pos).w
		sub.w	d1,(Camera_max_Y_pos).w
		move.w	(Camera_max_Y_pos).w,(Camera_target_max_Y_pos).w
		jsr	Reset_TileOffsetPositionActual(pc)
		clr.l	(Events_bg+$10).w
		clr.w	(Events_bg+$14).w
		clr.w	(_unkEEA2).w
		clr.w	(Events_fg_0).w
		clr.w	(Events_fg_2).w
		clr.w	(Events_routine_bg).w		; Clear flags/values used for BG stuff in act 2

loc_51268:
		jsr	(MGZ1_Deform).l
		lea	(MGZ1_BGDeformArray).l,a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)

; =============== S U B R O U T I N E =======================================


Do_ShakeSound:
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	.return			; If dying, skip this
		tst.w	(Events_bg+$16).w
		bne.s	.return			; If flag is set, skip this
		tst.w	(Screen_shake_flag).w
		bpl.s	.return			; If screen is not shaking continuously, skip this
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	.return
		moveq	#signextendB(sfx_Rumble2),d0
		jsr	(Play_SFX).l

.return:
		rts
; End of function Do_ShakeSound

; ---------------------------------------------------------------------------

MGZ2_ScreenInit:
		clr.l	(Events_bg+$10).w
		clr.l	(Events_bg+$14).w
		clr.w	(Events_fg_0).w
		clr.w	(Events_fg_2).w
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

MGZ2_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		tst.w	(Events_fg_0).w
		beq.s	loc_512D0
		st	(Screen_shake_flag).w		; Turn continuous shaking on

loc_512D0:
		jsr	Do_ShakeSound(pc)
		move.w	(Events_routine_fg).w,d0
		jmp	MGZ2_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

MGZ2_ScreenEvent_Index:
		bra.w	MGZ2SE_Normal
; ---------------------------------------------------------------------------
		bra.w	MGZ2SE_Collapse
; ---------------------------------------------------------------------------
		bra.w	MGZ2SE_MoveBG
; ---------------------------------------------------------------------------

MGZ2SE_Normal:
		tst.w	(Events_fg_4).w
		bne.s	loc_512FA
		jsr	MGZ2_QuakeEvent(pc)
		jsr	MGZ2_ChunkEvent(pc)
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

loc_512FA:
		clr.w	(Events_fg_4).w		; Clear background event
		st	(Events_bg+$16).w
		move.w	#$14,(Screen_shake_flag).w
		addq.w	#4,(Events_routine_fg).w

MGZ2SE_Collapse:
		jsr	MGZ2_LevelCollapse(pc)
		tst.w	(Screen_shake_flag).w
		bmi.s	loc_5131A
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

loc_5131A:
		lea	(MGZ2_FGVScrollArray).l,a4
		lea	(HScroll_table+$100).w,a5
		moveq	#$F,d6
		moveq	#$A,d5
		jmp	DrawTilesVDeform(pc)
; ---------------------------------------------------------------------------

MGZ2SE_MoveBG:
		move.l	(Events_bg+$08).w,d0
		cmpi.l	#$50000,d0
		bhs.s	loc_51342
		addi.l	#$800,d0
		move.l	d0,(Events_bg+$08).w

loc_51342:
		swap	d0
		add.w	d0,(Events_bg+$0C).w	; Apply a movement offset for the BG scrolling during the boss
		jmp	DrawTilesAsYouMove(pc)

; =============== S U B R O U T I N E =======================================


MGZ2_LevelCollapse:
		cmpi.b	#6,(Player_1+routine).w
		bhs.w	locret_514A8		; If dying, don't do anything else
		tst.w	(Screen_shake_flag).w
		bmi.w	loc_5140C			; If shaking continuously, branch
		bne.w	locret_514A8
		movea.w	$38(a3),a1			; Get chunk line at $700 Y
		lea	$79(a1),a1			; Get chunk at $3C80
		move.w	-8(a3),d0			; Get FG level X chunksize
		subq.w	#3,d0
		moveq	#3-1,d1

loc_51372:
		clr.b	(a1)+
		clr.b	(a1)+
		clr.b	(a1)+				; Clear the three main chunks on three lines that comprise the boss battle
		adda.w	d0,a1
		dbf	d1,loc_51372
		lea	(HScroll_table+$102).w,a1
		lea	(HScroll_table+$13C).w,a5
		lea	$28(a5),a6
		move.w	(Camera_Y_pos_copy).w,d0	; Get BG Y camera
		and.w	(Camera_Y_pos_mask).w,d0	; AND it to get tile position
		moveq	#$A-1,d1

loc_51394:
		move.w	d0,(a1)
		addq.w	#4,a1
		clr.l	(a5)+
		clr.l	(a6)+				; Clear scroll values, etc.
		dbf	d1,loc_51394
		jsr	(AllocateObject).l
		bne.s	loc_513FA
		move.w	#$3C90,d1
		move.l	#$5C00790,d2
		move.l	#HScroll_table+$13C,d3
		moveq	#$A-1,d4

loc_513BA:
		move.l	#Obj_MGZ2LevelCollapseSolid,(a1)		; Create solid objects that Sonic can stand on as the level collapses
		move.w	d1,x_pos(a1)
		move.w	d2,$2E(a1)
		move.l	d3,$30(a1)
		swap	d2
		jsr	(CreateNewSprite4).l
		bne.s	loc_513FA
		move.l	#Obj_MGZ2LevelCollapseSolid,(a1)
		move.w	d1,x_pos(a1)
		move.w	d2,$2E(a1)
		move.l	d3,$30(a1)
		addi.w	#$20,d1
		swap	d2
		addq.l	#4,d3
		jsr	(CreateNewSprite4).l
		dbne	d4,loc_513BA

loc_513FA:
		st	(Screen_shake_flag).w		; Turn quake on
		clr.w	(Events_bg+$06).w
		st	(_unkEEA2).w			; Turn on special VScroll VInt function
		move.w	#4,(Special_V_int_routine).w

loc_5140C:
		lea	(HScroll_table+$100).w,a1
		lea	$28(a1),a4
		lea	$14(a4),a5
		lea	(MGZ2_CollapseScrollDelay).l,a6
		move.w	(Events_bg+$06).w,d0
		addq.w	#1,(Events_bg+$06).w
		moveq	#$A,d1
		moveq	#$A-1,d2

loc_5142A:
		cmp.w	(a6)+,d0		; Get scroll delay for each block
		blo.s	loc_51436
		addi.l	#$500,$64(a1)		; Add $500 to Vscroll velocity for this block when not delayed

loc_51436:
		move.l	$64(a1),d3
		add.l	d3,(a5)+		; Add velocity to actual VScroll
		move.w	-4(a5),d3
		cmpi.w	#$2E0,d3
		blo.s	loc_5144C
		move.w	#$2E0,d3		; $2E0 is the maximum scroll
		subq.w	#1,d1			; When maximum scroll is reached, lower amount of "active" scrolling lines

loc_5144C:
		move.w	(Camera_Y_pos_copy).w,d4	; Get BG Y
		sub.w	d3,d4
		move.w	d4,(a4)+
		move.w	d4,(a1)				; Subtract from scroll to get... something
		addq.w	#4,a1
		dbf	d2,loc_5142A			; Repeat until all scrolling parts are off-screen
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	loc_51470
		moveq	#signextendB(sfx_BigRumble),d0	; Play collapsing sound every 16 frames
		jsr	(Play_SFX).l

loc_51470:
		tst.w	d1
		bne.s	locret_514A8			; If scrolling chunks still remain, do nothing
		movea.w	$2C(a3),a1			; Get chunk line at $580 Y
		lea	$79(a1),a1			; Get chunk at $3C80 X
		move.w	-8(a3),d0
		subq.w	#3,d0
		moveq	#2,d1

loc_51484:
		clr.b	(a1)+
		clr.b	(a1)+
		clr.b	(a1)+
		adda.w	d0,a1
		dbf	d1,loc_51484
		clr.w	(Screen_shake_flag).w		; Stop quaking
		clr.l	(Events_bg+$08).w		; Stop special tile drawing
		move.w	(Camera_X_pos_copy).w,(Events_bg+$0C).w
		move.w	#$C,(Special_V_int_routine).w	; Set VScroll VInt routine
		addq.w	#4,(Events_routine_fg).w	; Next screen routine

locret_514A8:
		rts
; End of function MGZ2_LevelCollapse


; =============== S U B R O U T I N E =======================================


MGZ2_QuakeEvent:
		tst.w	(Events_fg_2).w
		beq.s	loc_514D8
		bpl.s	loc_514BE
		tst.l	(Nem_decomp_queue).w
		bne.s	loc_514D8
		move.w	#$FF,(Events_fg_2).w

loc_514BE:
		move.w	(Camera_min_Y_pos).w,d0
		beq.s	loc_514D8
		cmpi.w	#$1E0,d0
		beq.s	loc_514D8
		subq.w	#2,d0
		bcc.s	loc_514D4
		moveq	#0,d0
		move.w	d0,(Events_fg_2).w

loc_514D4:
		move.w	d0,(Camera_min_Y_pos).w

loc_514D8:
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		move.w	(Events_bg+$10).w,d2
		jmp	MGZ2_QuakeEvent_Index(pc,d2.w)
; End of function MGZ2_QuakeEvent

; ---------------------------------------------------------------------------

MGZ2_QuakeEvent_Index:
		bra.w	MGZ2_QuakeEventCheck
; ---------------------------------------------------------------------------
		bra.w	MGZ2_QuakeEvent1
; ---------------------------------------------------------------------------
		bra.w	MGZ2_QuakeEvent2
; ---------------------------------------------------------------------------
		bra.w	MGZ2_QuakeEvent3
; ---------------------------------------------------------------------------
		bra.w	MGZ2_QuakeEvent1Cont
; ---------------------------------------------------------------------------
		bra.w	MGZ2_QuakeEvent2Cont
; ---------------------------------------------------------------------------
		bra.w	MGZ2_QuakeEvent3Cont
; ---------------------------------------------------------------------------

MGZ2_QuakeEventCheck:
		lea	(Events_bg+$12).w,a5		; EEE4-EEE6 are flags to determine whether earthquake event has already completed. There are three
		lea	(MGZ2_QuakeEventArray).l,a1
		moveq	#4,d2
		moveq	#2,d3

loc_51512:
		tst.b	(a5)
		bne.s	loc_51552
		cmp.w	(a1),d0
		blo.s	loc_51552
		cmp.w	2(a1),d0
		bhs.s	loc_51552
		cmp.w	4(a1),d1
		blo.s	loc_51552
		cmp.w	6(a1),d1
		bhs.s	loc_51552
		move.w	d2,(Events_bg+$10).w
		move.w	8(a1),d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		move.w	$A(a1),d0
		cmpi.w	#4,d2
		bne.s	loc_5154C
		move.w	d0,(Camera_max_X_pos).w	; First earthquake event near start of level makes you go right
		rts
; ---------------------------------------------------------------------------

loc_5154C:
		move.w	d0,(Camera_min_X_pos).w	; The other two make you go left
		rts
; ---------------------------------------------------------------------------

loc_51552:
		lea	$C(a1),a1
		addq.w	#1,a5
		addq.w	#4,d2
		dbf	d3,loc_51512
		rts
; ---------------------------------------------------------------------------

MGZ2_QuakeEvent1:
		cmpi.w	#$780,d0
		blo.w	loc_51656		; If player retreats, revert to normal camera movement
		move.w	(Camera_max_X_pos).w,d0
		cmp.w	(Camera_X_pos).w,d0
		bhi.s	locret_515A2		; If camera X hasn't reached level X end, branch
		move.w	d0,(Camera_min_X_pos).w	; Lock the screen
		st	(Events_bg+$12).w			; Set the earthquake flag for this first one
		addi.w	#$C,(Events_bg+$10).w	; Set next quake event routine
		jsr	(AllocateObject).l
		bne.s	locret_515A2
		move.l	#Obj_MGZ2DrillingRobotnik,(a1)
		move.w	#$8E0,x_pos(a1)
		move.w	#$690,y_pos(a1)		; Create drilling Eggman boss sprite
		st	(Screen_shake_flag).w
		st	(Events_fg_0).w			; Start shaking the screen

locret_515A2:
		rts
; ---------------------------------------------------------------------------

MGZ2_QuakeEvent2:
		cmpi.w	#$3200,d0
		blo.s	loc_515B4
		move.w	#$1DF,(Camera_min_Y_pos).w	; If player retreats, reset level height
		bra.w	loc_51656
; ---------------------------------------------------------------------------

loc_515B4:
		move.w	(Camera_max_Y_pos).w,d1
		cmp.w	(Camera_Y_pos).w,d1
		bne.s	loc_515CC
		cmp.w	(Camera_min_Y_pos).w,d1
		beq.s	loc_515CC
		move.w	d1,(Camera_min_Y_pos).w	; Adjust level height during this event
		st	(Events_fg_2+1).w

loc_515CC:
		move.w	(Camera_min_X_pos).w,d0	; If camera X hasn't reached level X start, branch
		cmp.w	(Camera_X_pos).w,d0
		blo.s	locret_5160C
		move.w	d0,(Camera_max_X_pos).w	; Lock the screen
		st	(Events_bg+$13).w			; Set this earthquake flag
		addi.w	#$C,(Events_bg+$10).w	; Set next quake event routine
		jsr	(AllocateObject).l
		bne.s	locret_5160C
		move.l	#Obj_MGZ2DrillingRobotnik,(a1)
		bset	#0,render_flags(a1)
		move.w	#$2FA0,x_pos(a1)
		move.w	#$2D0,y_pos(a1)		; Set Robotnik drilling object
		st	(Screen_shake_flag).w
		st	(Events_fg_0).w			; Start quaking

locret_5160C:
		rts
; ---------------------------------------------------------------------------

MGZ2_QuakeEvent3:
		cmpi.w	#$3480,d0			; Same as above, you know the drill (haha, drill...)
		bhs.s	loc_51656
		move.w	(Camera_min_X_pos).w,d0
		cmp.w	(Camera_X_pos).w,d0
		blo.s	locret_51654
		move.w	d0,(Camera_max_X_pos).w
		st	(Events_bg+$14).w
		addi.w	#$C,(Events_bg+$10).w
		jsr	(AllocateObject).l
		bne.s	locret_51654
		move.l	#Obj_MGZ2DrillingRobotnik,(a1)
		bset	#0,render_flags(a1)
		move.w	#$3300,x_pos(a1)
		move.w	#$790,y_pos(a1)
		st	(Screen_shake_flag).w
		st	(Events_fg_0).w

locret_51654:
		rts
; ---------------------------------------------------------------------------

loc_51656:
		move.w	#$1000,d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		move.l	#$6000,d0
		move.l	d0,(Camera_min_X_pos).w
		clr.w	(Events_bg+$10).w
		rts
; ---------------------------------------------------------------------------

MGZ2_QuakeEvent1Cont:
		cmpi.w	#$980,(Player_1+x_pos).w
		bhs.s	loc_516A2			; Reset level Y end when Sonic has travelled past $980 X
		rts
; ---------------------------------------------------------------------------

MGZ2_QuakeEvent2Cont:
		cmpi.w	#$100,(Player_1+y_pos).w
		bhs.s	locret_51696
		cmpi.w	#$2F80,(Player_1+x_pos).w
		blo.s	locret_51696
		move.w	#$6000,d0
		move.w	d0,(Camera_max_X_pos).w
		bra.s	loc_516A2
; ---------------------------------------------------------------------------

locret_51696:
		rts
; ---------------------------------------------------------------------------

MGZ2_QuakeEvent3Cont:
		cmpi.w	#$3200,(Player_1+x_pos).w
		blo.s	loc_516A2
		rts
; ---------------------------------------------------------------------------

loc_516A2:
		move.w	#$1000,d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		clr.w	(Events_bg+$10).w
		rts

; =============== S U B R O U T I N E =======================================


MGZ2_ChunkEvent:
		move.w	(Events_bg+$04).w,d0
		jmp	MGZ2_ChunkEvent_Index(pc,d0.w)
; End of function MGZ2_ChunkEvent

; ---------------------------------------------------------------------------

MGZ2_ChunkEvent_Index:
		bra.w	MGZ2_ChunkEventCheck
; ---------------------------------------------------------------------------
		bra.w	MGZ2_ChunkEvent1
; ---------------------------------------------------------------------------
		bra.w	MGZ2_ChunkEvent2_3
; ---------------------------------------------------------------------------
		bra.w	MGZ2_ChunkEvent2_3
; ---------------------------------------------------------------------------
		bra.w	MGZ2_ChunkEventReset
; ---------------------------------------------------------------------------
		rts
; ---------------------------------------------------------------------------

MGZ2_ChunkEventCheck:
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		lea	(MGZ2_ChunkEventArray).l,a1
		moveq	#4,d2
		moveq	#3-1,d3

loc_516E4:
		cmp.w	(a1),d0
		blo.s	loc_51706
		cmp.w	2(a1),d0
		bhs.s	loc_51706
		cmp.w	4(a1),d1
		blo.s	loc_51706
		cmp.w	6(a1),d1
		bhs.s	loc_51706
		cmpi.w	#4,d2
		bne.s	loc_51712
		tst.w	(Screen_shake_flag).w
		bmi.s	loc_51712		; Only perform the first layout shift event if screen is continually shaking

loc_51706:
		lea	$C(a1),a1
		addq.w	#4,d2
		dbf	d3,loc_516E4
		rts
; ---------------------------------------------------------------------------

loc_51712:
		move.w	d2,(Events_bg+$04).w
		clr.w	(Events_bg+$06).w
		clr.w	(Events_bg+$08).w
		move.w	8(a1),(Events_bg+$0A).w
		move.w	$A(a1),(Events_bg+$0C).w

MGZ2_ChunkEvent1:
		move.w	(Events_bg+$06).w,d0
		cmpi.w	#$5C,d0
		blo.s	loc_51762
		clr.w	(Screen_shake_flag).w		; Stop shaking when first chunk event is finished
		clr.w	(Events_fg_0).w		; Reset quake event
		clr.w	(Camera_min_X_pos).w		; Reset level height
		move.w	#$10,(Events_bg+$04).w
		rts
; ---------------------------------------------------------------------------

MGZ2_ChunkEvent2_3:
		move.w	(Events_bg+$06).w,d0
		cmpi.w	#$5C,d0
		blo.s	loc_51762
		move.w	#$6000,d0
		move.w	d0,(Camera_max_X_pos).w	; Reset level end X
		move.w	#$14,(Events_bg+$04).w
		rts
; ---------------------------------------------------------------------------

loc_51762:
		subq.w	#1,(Events_bg+$08).w
		bpl.s	locret_517C2
		move.w	#7-1,(Events_bg+$08).w	; Perform the layout change once every seven frames
		move.w	d0,d2
		bsr.s	MGZ2_ModifyChunk
		move.w	(Events_bg+$0A).w,d0
		addi.w	#$80,d0
		sub.w	(Camera_X_pos_copy).w,d0
		bcs.s	locret_517C2
		cmpi.w	#$1C0,d0			; Calculate the X position of the screen redraw
		bhs.s	locret_517C2
		move.w	(Events_bg+$0C).w,d0
		lea	(MGZ2_ScreenRedrawArray).l,a1
		add.w	(a1,d2.w),d0		; Calculate the Y position
		move.w	2(a1,d2.w),d2		; And the number of lines to write

loc_51798:
		move.w	(Camera_Y_pos_copy).w,d3
		and.w	(Camera_Y_pos_mask).w,d3
		cmp.w	d3,d0
		blo.s	loc_517BA
		addi.w	#$F0,d3
		cmp.w	d3,d0
		bhs.s	loc_517BA
		move.w	(Events_bg+$0A).w,d1
		moveq	#8,d6				; Always draw 8 tiles
		swap	d2
		jsr	Setup_TileRowDraw(pc)
		swap	d2

loc_517BA:
		addi.w	#$10,d0
		dbf	d2,loc_51798

locret_517C2:
		rts
; ---------------------------------------------------------------------------

MGZ2_ChunkEventReset:
		cmpi.w	#$2A00,(Player_1+x_pos).w	; When Player has travelled far enough, reset the chunk to its original form
		blo.s	locret_517D4
		clr.w	(Events_bg+$04).w
		moveq	#$5C,d0
		bra.s	MGZ2_ModifyChunk
; ---------------------------------------------------------------------------

locret_517D4:
		rts

; =============== S U B R O U T I N E =======================================


MGZ2_ModifyChunk:
		lea	(MGZ2_ChunkReplaceArray).l,a1
		lea	($FF5880).l,a5
		bsr.s	sub_517EA
		lea	($FF7500).l,a5
; End of function MGZ2_ModifyChunk


; =============== S U B R O U T I N E =======================================


sub_517EA:
		lea	(MGZ2_QuakeChunks).l,a4
		adda.w	(a1,d0.w),a4
		moveq	#8-1,d1

loc_517F6:
		move.l	(a4)+,(a5)+
		move.l	(a4)+,(a5)+
		move.l	(a4)+,(a5)+
		move.l	(a4)+,(a5)+
		dbf	d1,loc_517F6
		addq.w	#2,d0
		move.w	d0,(Events_bg+$06).w
		rts
; End of function sub_517EA

; ---------------------------------------------------------------------------

Obj_MGZ2LevelCollapseSolid:
		cmpi.w	#8,(Events_routine_fg).w
		bne.s	loc_51818
		jmp	(Delete_Current_Sprite).l		; Delete control object when next screen event is in effect
; ---------------------------------------------------------------------------

loc_51818:
		movea.l	$30(a0),a1		; Get vertical scroll position for this block
		move.w	$2E(a0),d0		; Get vertical position
		add.w	(a1),d0			; Add it to scroll value to get final Y position
		move.w	d0,y_pos(a0)
		move.b	#$10,width_pixels(a0)	; Set up width
		bset	#7,status(a0)		; Make it invisible
		moveq	#$1B,d1
		moveq	#$40,d2
		moveq	#$40,d3			; Height, etc.
		move.w	x_pos(a0),d4		; Position
		jmp	(SolidObjectFull2).l
; ---------------------------------------------------------------------------

MGZ2_BackgroundInit:
		jsr	MGZ2_ClearBottomBG(pc)
		move.w	#4,(Events_routine_bg).w	; Use second background event
		clr.w	(_unkEEA2).w		; Clear VScroll routine flag
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		cmpi.w	#$500,d1
		bhs.s	loc_5187E
		cmpi.w	#$3800,d0
		blo.s	loc_518CA
		move.w	#4,(Events_bg+$00).w	; If player is <$500 Y and >$3800 X (Knuckles area presumably)
		move.l	#Obj_MGZ2BGMoveKnux,d1
		cmpi.w	#$3A80,d0
		blo.s	loc_518C0
		move.w	#$220,(Events_bg+$02).w
		bra.s	loc_518CA
; ---------------------------------------------------------------------------

loc_5187E:
		cmpi.w	#$800,d1
		blo.s	loc_518A4
		cmpi.w	#$34C0,d0
		blo.s	loc_518CA
		move.w	#8,(Events_bg+$00).w	; If player is >$800 Y and >$34C0 X
		move.l	#Obj_MGZ2BGMoveSonic,d1
		cmpi.w	#$3800,d0
		blo.s	loc_518C0
		move.w	#$1D0,(Events_bg+$02).w
		bra.s	loc_518CA
; ---------------------------------------------------------------------------

loc_518A4:
		cmpi.w	#$3900,d0
		blo.s	loc_518CA
		move.w	#$C,(Events_bg+$00).w	; If player is >$3900X and inbetween $500 and $800 Y
		move.w	#$1D0,(Events_bg+$02).w
		st	(Events_bg+$0E).w			; Turn off cloud movement
		clr.l	(HScroll_table+$038).w
		bra.s	loc_518CA
; ---------------------------------------------------------------------------

loc_518C0:
		jsr	(AllocateObject).l
		bne.s	loc_518CA
		move.l	d1,(a1)

loc_518CA:
		jsr	(MGZ2_BGDeform).l
		jsr	Reset_TileOffsetPositionEff(pc)
		clr.l	(HScroll_table).w
		move.w	d2,(HScroll_table+$006).w
		lea	(MGZ2_BGDrawArray).l,a4
		lea	(HScroll_table).w,a5
		jsr	Refresh_PlaneTileDeform(pc)
		lea	(MGZ2_BGDeformArray).l,a4
		lea	(HScroll_table+$008).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

MGZ2_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	MGZ2_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

MGZ2_BackgroundEvent_Index:
		bra.w	MGZ2BGE_GoRefresh
; ---------------------------------------------------------------------------
		bra.w	MGZ2BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	MGZ2BGE_Refresh
; ---------------------------------------------------------------------------

MGZ2BGE_GoRefresh:
		jsr	MGZ2_ClearBottomBG(pc)
		clr.l	(HScroll_table).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_51968
; ---------------------------------------------------------------------------

MGZ2BGE_Normal:
		jsr	MGZ2_BGEventTrigger(pc)
		bne.s	loc_51968		; If BG event has triggered, go refresh the BG
		jsr	(MGZ2_BGDeform).l

loc_51926:
		lea	(MGZ2_BGDrawArray).l,a4
		lea	(HScroll_table).w,a5
		moveq	#$20,d6
		moveq	#2,d5
		jsr	Draw_BG(pc)
		lea	(MGZ2_BGDeformArray).l,a4
		lea	(HScroll_table+$008).w,a5
		jsr	ApplyDeformation(pc)
		lea	(MGZ2_FGVScrollArray).l,a4
		lea	(HScroll_table+$126).w,a5
		jsr	Apply_FGVScroll(pc)
		jsr	Get_BGActualEffectiveDiff(pc)
		jsr	ShakeScreen_Setup(pc)
		tst.b	(Background_collision_flag).w
		beq.s	locret_51966
		jmp	Go_CheckPlayerRelease(pc)			; Only do this if BG collision is on
; ---------------------------------------------------------------------------

locret_51966:
		rts
; ---------------------------------------------------------------------------

loc_51968:
		jsr	(MGZ2_BGDeform).l
		jsr	Reset_TileOffsetPositionEff(pc)
		move.w	d2,(HScroll_table+$006).w
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_51994
; ---------------------------------------------------------------------------

MGZ2BGE_Refresh:
		jsr	(MGZ2_BGDeform).l

loc_51994:
		lea	(MGZ2_BGDrawArray).l,a4
		lea	(HScroll_table-$04).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d1
		jsr	Draw_PlaneVertBottomUpComplex(pc)
		bpl.w	loc_51926
		subq.w	#4,(Events_routine_bg).w
		bra.w	loc_51926

; =============== S U B R O U T I N E =======================================


MGZ2_ClearBottomBG:
		move.w	(a3),d0
		addq.w	#8,d0
		move.w	d0,$74(a3)
		move.w	d0,$78(a3)
		move.w	d0,$7C(a3)
		rts
; End of function MGZ2_ClearBottomBG


; =============== S U B R O U T I N E =======================================


MGZ2_BGEventTrigger:
		tst.w	(_unkEEA2).w
		beq.s	loc_519CC
		rts
; ---------------------------------------------------------------------------

loc_519CC:
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		move.w	(Events_bg+$00).w,d2
		jmp	MGZ2_BGEventTrigger_Index(pc,d2.w)
; End of function MGZ2_BGEventTrigger

; ---------------------------------------------------------------------------

MGZ2_BGEventTrigger_Index:
		bra.w	loc_51A6A	; 0 - Normal
; ---------------------------------------------------------------------------
		bra.w	loc_51A3C	; 4 - Knuckles BG Move Event
; ---------------------------------------------------------------------------
		bra.w	loc_51A04	; 8 - Sonic BG Move Event
; ---------------------------------------------------------------------------
		clr.b	(Background_collision_flag).w	; C - After BG Move
		cmpi.w	#$800,d1		; Turn off BG collision
		blo.w	loc_51AB8
		cmpi.w	#$3A40,d0
		blo.w	loc_51AB8		; If Player (Sonic/Tails) is > $800 Y and > $3A40 X, go back to BG event
		move.w	#8,(Events_bg+$00).w
		rts
; ---------------------------------------------------------------------------

loc_51A04:
		st	(Background_collision_flag).w		; Set BG collision on
		cmpi.w	#$800,d1
		bhs.s	loc_51A22
		cmpi.w	#$3900,d0
		blo.w	loc_51AB8
		st	(Events_bg+$0E).w		; If Player < $800 Y and > $3900 X, turn off cloud movement
		clr.l	(HScroll_table+$038).w
		moveq	#$C,d0			; Go to after BG Event trigger
		bra.s	loc_51A34
; ---------------------------------------------------------------------------

loc_51A22:
		cmpi.w	#$900,d1
		bhs.w	loc_51AB8
		cmpi.w	#$34C0,d0
		bhs.w	loc_51AB8		; If player is > $900 Y or > $34C0 X, continue normal deformation
		moveq	#0,d0

loc_51A34:
		move.w	d0,(Events_bg+$00).w	; Otherwise, return to normal BG collision trigger
		moveq	#-1,d0
		rts
; ---------------------------------------------------------------------------

loc_51A3C:
		st	(Background_collision_flag).w		; Set BG collision on
		cmpi.w	#$100,d1
		bhs.s	loc_51A50
		cmpi.w	#$3C00,d0
		blo.s	loc_51A50
		clr.b	(Background_collision_flag).w	; If Player < $100 Y and > $3C00 X, turn off BG collision

loc_51A50:
		cmpi.w	#$80,d1
		blo.s	loc_51AB8
		cmpi.w	#$180,d1
		bhs.s	loc_51AB8
		cmpi.w	#$3800,d0
		bhs.s	loc_51AB8		; If player is < $80 Y and > $180 Y and  > $3800 X, continue deformation
		clr.w	(Events_bg+$00).w	; Otherwise
		moveq	#-1,d0
		rts
; ---------------------------------------------------------------------------

loc_51A6A:
		clr.b	(Background_collision_flag).w
		cmpi.w	#$80,d1
		blo.s	loc_51AB8
		cmpi.w	#$180,d1
		bhs.s	loc_51A8A
		cmpi.w	#$3800,d0
		blo.s	loc_51AB8
		moveq	#4,d0			; If between $80 and $180 Y and > $3800 X, use first BG move
		move.l	#Obj_MGZ2BGMoveKnux,d1
		bra.s	loc_51AA4
; ---------------------------------------------------------------------------

loc_51A8A:
		cmpi.w	#$800,d1
		blo.s	loc_51AB8
		cmpi.w	#$900,d1
		bhs.s	loc_51AB8
		cmpi.w	#$34C0,d0
		blo.s	loc_51AB8
		moveq	#8,d0			; If between $800 and $900 Y and > $34C0 X, use second BG move
		move.l	#Obj_MGZ2BGMoveSonic,d1

loc_51AA4:
		move.w	d0,(Events_bg+$00).w
		clr.w	(Events_bg+$02).w
		jsr	(AllocateObject).l
		bne.s	locret_51AB6
		move.l	d1,(a1)

locret_51AB6:
		rts
; ---------------------------------------------------------------------------

loc_51AB8:
		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------

Obj_MGZ2BGMoveKnux:
		moveq	#4,d0
		move.w	#$400,d1
		move.w	#$38A0,d2
		move.w	#$220,d3
		move.w	#$6000,d4
		bra.s	loc_51AE6
; ---------------------------------------------------------------------------

Obj_MGZ2BGMoveSonic:
		moveq	#8,d0
		move.w	#$A80,d1
		move.w	#$36D0,d2
		move.w	#$1D0,d3
		move.w	#$6000,d4
		st	$38(a0)

loc_51AE6:
		cmp.w	(Events_bg+$00).w,d0
		beq.s	loc_51AF2
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_51AF2:
		cmp.w	(Player_1+y_pos).w,d1
		bhs.s	locret_51AFE
		cmp.w	(Player_1+x_pos).w,d2
		blo.s	loc_51B00

locret_51AFE:
		rts
; ---------------------------------------------------------------------------

loc_51B00:
		move.w	d3,$2E(a0)
		move.w	d4,$32(a0)
		move.w	(Camera_X_pos_copy).w,d0
		move.w	d0,(Camera_min_X_pos).w
		bset	#7,(Disable_wall_grab).w
		move.l	#loc_51B1C,(a0)

loc_51B1C:
		move.w	(Events_bg+$02).w,d0
		cmp.w	$2E(a0),d0			; Wait for BG offset to match given value
		blo.s	loc_51B44
		moveq	#signextendB(sfx_Crash),d0				; Play final crashing sound
		jsr	(Play_SFX).l
		move.w	#$E,(Screen_shake_flag).w	; Do final screen shake
		clr.w	(Events_fg_0).w		; Disable constant screen shaking
		bclr	#7,(Disable_wall_grab).w	; Reenable Knuckles wall grab
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_51B44:
		move.w	(Player_1+x_pos).w,d2
		move.w	(Player_1+y_pos).w,d3
		tst.b	$39(a0)
		beq.s	loc_51B58
		move.w	d0,d1
		addq.w	#1,d1
		bra.s	loc_51B84
; ---------------------------------------------------------------------------

loc_51B58:
		tst.b	$38(a0)
		bne.s	loc_51B6C
		cmpi.w	#$200,d3
		bhs.s	loc_51B76
		cmpi.w	#$3CB0,d2
		blo.s	loc_51B72
		bra.s	loc_51B76
; ---------------------------------------------------------------------------

loc_51B6C:
		cmpi.w	#$3D50,d2	; Second background object check
		blo.s	loc_51B76

loc_51B72:
		st	$39(a0)

loc_51B76:
		move.l	$34(a0),d1
		add.l	$30(a0),d1
		move.l	d1,$34(a0)
		swap	d1

loc_51B84:
		move.w	d1,(Events_bg+$02).w	; Move background offset
		sub.w	d0,d1
		sub.w	d1,(Player_1+y_pos).w
		sub.w	d1,(Player_2+y_pos).w
		rts
; ---------------------------------------------------------------------------

CNZ1_ScreenInit:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

CNZ1_ScreenEvent:
		tst.w	(Events_bg+$06).w
		beq.s	loc_51BAA
		clr.w	(Events_bg+$06).w
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

loc_51BAA:
		jsr	DrawTilesAsYouMove(pc)
		lea	(Events_bg+$00).w,a5
		tst.l	(a5)
		beq.w	locret_51C6A
		move.w	(a5)+,d0			; All this below is for removing chunks from the miniboss arena
		move.w	(a5),d1
		clr.l	-2(a5)
		move.w	d0,d2
		move.w	d1,d3
		asr.w	#3,d2
		move.w	d2,d4
		asr.w	#4,d2
		move.w	d3,d5
		asr.w	#5,d3
		and.w	(Layout_row_index_mask).w,d3
		movea.w	(a3,d3.w),a4
		moveq	#-1,d6
		clr.w	d6
		move.b	(a4,d2.w),d6
		lsl.w	#7,d6
		andi.w	#$C,d4
		andi.w	#$60,d5
		add.w	d4,d6
		add.w	d5,d6
		movea.l	d6,a4
		clr.l	(a4)
		clr.l	$10(a4)		; Clear the necessary parts of the chunks
		asr.w	#2,d0
		andi.w	#$78,d0
		lsl.w	#4,d1
		andi.w	#$E00,d1
		add.w	d1,d0
		add.w	d7,d0
		moveq	#0,d1
		move.w	d0,(a0)+
		move.w	#1,(a0)+
		move.l	d1,(a0)+
		move.l	d1,(a0)+
		move.l	d1,(a0)+
		move.l	d1,(a0)+
		addi.w	#$100,d0
		move.w	d0,(a0)+
		move.w	#1,(a0)+
		move.l	d1,(a0)+
		move.l	d1,(a0)+
		move.l	d1,(a0)+
		move.l	d1,(a0)+		; Add a VRAM write to remove it from the screen
		clr.w	(a0)
		movea.w	$18(a3),a4
		lea	$64(a4),a4			; Level layout $300 Y $3200 X (the boss arena blocks)
		moveq	#0,d1
		clr.w	(Events_bg+$04).w
		moveq	#4-1,d3

loc_51C38:
		lea	(a4),a5
		moveq	#2,d2

loc_51C3C:
		moveq	#-1,d0
		clr.w	d0
		move.b	(a5)+,d0
		lsl.w	#7,d0
		add.w	d1,d0
		movea.l	d0,a6
		tst.l	(a6)+
		bne.s	locret_51C6A
		tst.l	(a6)+
		bne.s	locret_51C6A
		tst.l	(a6)+
		bne.s	locret_51C6A
		tst.l	(a6)
		bne.s	locret_51C6A
		dbf	d2,loc_51C3C
		addi.w	#$20,d1			; Basically, if a line of blocks is completely destroyed, the boss is lowered by $20 pixels to compensate.
		addi.w	#$20,(Events_bg+$04).w
		dbf	d3,loc_51C38

locret_51C6A:
		rts
; ---------------------------------------------------------------------------

CNZ1_BackgroundInit:
		jsr	CNZ1_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	CNZ1_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

CNZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	CNZ1_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

CNZ1_BackgroundEvent_Index:
		bra.w	CNZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	CNZ1BGE_BossStart
; ---------------------------------------------------------------------------
		bra.w	CNZ1BGE_Boss
; ---------------------------------------------------------------------------
		bra.w	CNZ1BGE_AfterBoss
; ---------------------------------------------------------------------------
		bra.w	CNZ1BGE_FGRefresh
; ---------------------------------------------------------------------------
		bra.w	CNZ1BGE_FGRefresh2
; ---------------------------------------------------------------------------
		bra.w	CNZ1BGE_DoTransition
; ---------------------------------------------------------------------------

CNZ1BGE_Normal:
		cmpi.w	#$3000,(Camera_X_pos).w
		blo.s	loc_51CFA
		cmpi.w	#$54C,(Camera_Y_pos).w
		blo.s	loc_51CD2
		move.w	#$700,d0			; This is positional adjustment for Knuckles' path
		sub.w	d0,(Player_1+y_pos).w
		sub.w	d0,(Player_2+y_pos).w
		sub.w	d0,(Camera_Y_pos).w
		sub.w	d0,(Camera_Y_pos_copy).w
		jsr	Reset_TileOffsetPositionActual(pc)

loc_51CD2:
		jsr	CNZ1_BossLevelScroll(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		lea	(Pal_CNZMiniboss).l,a1
		jsr	(PalLoad_Line1).l
		move.w	#$1C0,d0
		move.w	d0,(Camera_min_Y_pos).w	; Change level start Y
		bset	#7,(Disable_wall_grab).w	; Disable wall grabbing for Knuckles
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_51D26
; ---------------------------------------------------------------------------

loc_51CFA:
		jsr	CNZ1_Deform(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	CNZ1_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

CNZ1BGE_BossStart:
		move.w	#$1C0,d0
		jsr	CNZ1_ScrollToYStart(pc)
		jsr	CNZ1_BossLevelScroll(pc)

loc_51D26:
		jsr	DrawBGAsYouMove(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

CNZ1BGE_Boss:
		move.w	#$1C0,d0
		jsr	CNZ1_ScrollToYStart(pc)
		jsr	CNZ1_BossLevelScroll2(pc)
		lea	(Camera_X_pos_BG_copy).w,a6
		lea	(Camera_X_pos_BG_rounded).w,a5
		move.w	#$200,d1
		moveq	#$10,d6
		jsr	Draw_TileColumn(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

CNZ1BGE_AfterBoss:
		move.w	#$1C0,d0
		jsr	CNZ1_ScrollToYStart(pc)
		tst.w	(Events_fg_5).w
		bne.s	loc_51D6E
		jsr	CNZ1_BossLevelScroll2(pc)
		jsr	DrawBGAsYouMove(pc)
		jsr	PlainDeformation(pc)
		jmp	Get_BGActualEffectiveDiff(pc)
; ---------------------------------------------------------------------------

loc_51D6E:
		clr.w	(Events_fg_5).w		; When signaled
		move.w	#$2F0,(Draw_delayed_position).w	; Set refresh position
		move.w	#$F,(Draw_delayed_rowcount).w	; Refresh number
		addq.w	#4,(Events_routine_bg).w

CNZ1BGE_FGRefresh:
		move.w	#$1C0,d0
		jsr	CNZ1_ScrollToYStart(pc)		; Continue scrolling
		move.w	#VRAM_Plane_A_Name_Table,d7
		moveq	#0,d1
		move.w	#$200,d2
		jsr	Draw_PlaneVertSingleBottomUp(pc)	; Refresh the foreground using BG chunks
		bmi.s	loc_51DAE
		move.w	#VRAM_Plane_B_Name_Table,d7
		jsr	CNZ1_BossLevelScroll2(pc)
		jsr	DrawBGAsYouMove(pc)
		jsr	PlainDeformation(pc)
		jmp	Get_BGActualEffectiveDiff(pc)
; ---------------------------------------------------------------------------

loc_51DAE:
		movea.w	$C(a3),a1		; $180 Y of BG
		addq.w	#4,a1			; $200 X of BG
		move.w	-8(a3),d0		; Get X size of BG
		subq.w	#5,d0
		movea.w	$12(a3),a5		; $280 Y of FG
		lea	$63(a5),a5		; $3180 of FG
		move.w	-$A(a3),d1		; Get X size of FG
		subq.w	#5,d1
		moveq	#6-1,d2

loc_51DCA:
		move.b	(a1)+,(a5)+		; Replace 5x5 portion of Foreground with equivalent from BG. Basically,
		move.b	(a1)+,(a5)+		; transferring the actual layout to the FG for use with collision.
		move.b	(a1)+,(a5)+
		move.b	(a1)+,(a5)+
		move.b	(a1)+,(a5)+
		adda.w	d0,a1
		adda.w	d1,a5
		dbf	d2,loc_51DCA
		clr.b	(Background_collision_flag).w	; Turn off BG collision
		clr.w	(Events_bg+$08).w	; Turn off scrolling
		move.w	#$1C0,d0
		add.w	d0,(Player_1+y_pos).w	; Move players and camera to position
		add.w	d0,(Player_2+y_pos).w
		add.w	d0,(Camera_Y_pos).w
		add.w	d0,(Camera_Y_pos_copy).w
		jsr	Reset_TileOffsetPositionActual(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w	; Set up refresh position
		move.w	#$F,(Draw_delayed_rowcount).w	; Refresh amount
		addq.w	#4,(Events_routine_bg).w

CNZ1BGE_FGRefresh2:
		move.w	#$380,d0
		jsr	CNZ1_ScrollToYStart(pc)
		lea	(Level_layout_main).w,a3
		move.w	#VRAM_Plane_A_Name_Table,d7
		move.w	(Camera_X_pos_copy).w,d1
		move.w	(Camera_Y_pos_copy).w,d2
		jsr	Draw_PlaneVertSingleBottomUp(pc)	; Refresh the FG using FG chunks this time
		bmi.s	loc_51E42
		addq.w	#2,a3
		move.w	#VRAM_Plane_B_Name_Table,d7
		jsr	CNZ1_BossLevelScroll2(pc)
		jsr	DrawBGAsYouMove(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

loc_51E42:
		addq.w	#2,a3
		move.w	#VRAM_Plane_B_Name_Table,d7
		jsr	(AllocateObject).l
		bne.s	loc_51E5C
		move.l	#Obj_EndSign,(a1)
		move.w	#$32C0,x_pos(a1)			; Set up the end sign

loc_51E5C:
		addq.w	#4,(Events_routine_bg).w

CNZ1BGE_DoTransition:
		tst.w	(Events_fg_5).w
		beq.w	loc_51F28				; Don't do anything until signpost lands
		clr.w	(Events_fg_5).w
		movem.l	d7-a0/a2-a3,-(sp)
		moveq	#PLCID_18,d0
		jsr	(Load_PLC).l
		moveq	#PLCID_19,d0
		jsr	(Load_PLC).l					; Load CNZ 2 PLCs
		move.w	#$301,(Current_zone_and_act).w		; Change to act 2
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(Respawn_table_keep).w			; Reset various managers
		jsr	Clear_Switches(pc)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		jsr	(CheckLevelForWater).l		; Level stuff, etc.
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_51EC0
		move.w	#$8014,(VDP_control_port).l		; Turn HInt on for water only if not playing as Knuckles

loc_51EC0:
		moveq	#PalID_CNZ2,d0
		jsr	(LoadPalette_Immediate).l	; Load CNZ palette
		movem.l	(sp)+,d7-a0/a2-a3
		bclr	#7,(Disable_wall_grab).w		; Wall gliding is possible again
		move.w	#$3000,d0
		move.w	#-$200,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d1,(Player_1+y_pos).w
		sub.w	d0,(Player_2+x_pos).w
		sub.w	d1,(Player_2+y_pos).w		; Offset object/player positions
		jsr	Offset_ObjectsDuringTransition(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d1,(Camera_Y_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d1,(Camera_Y_pos_copy).w		; Offset camera positions
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w
		sub.w	d1,(Camera_min_Y_pos).w
		sub.w	d1,(Camera_max_Y_pos).w		; Offset level start/ends
		move.w	(Camera_max_Y_pos).w,(Camera_target_max_Y_pos).w
		jsr	Reset_TileOffsetPositionActual(pc)
		move.w	#$2F0,(Draw_delayed_position).w		; Set up refresh
		move.w	#$F,(Draw_delayed_rowcount).w
		clr.w	(Events_routine_bg).w

loc_51F28:
		jsr	CNZ1_BossLevelScroll2(pc)
		jsr	DrawBGAsYouMove(pc)
		jmp	PlainDeformation(pc)

; =============== S U B R O U T I N E =======================================


CNZ1_Deform:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Screen_shake_offset).w,d2
		sub.w	d2,d0
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		asr.l	#1,d1
		add.l	d1,d0
		asr.l	#2,d1
		add.l	d1,d0
		swap	d0
		add.w	d2,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w		; Effective BG Y is about 1/10th (13/128ths to be exact) of camera Y
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#3,d1
		lea	(HScroll_table+$00A).w,a1
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,(Camera_X_pos_BG_copy).w		; Effective BG X is 7/16th speed of normal camera
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,(Events_bg+$10).w		; Dynamic art reload BG speed is 5/16th of normal camera
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		asr.l	#1,d1
		sub.l	d1,d0
		swap	d0
		move.w	d0,-(a1)
		rts
; End of function CNZ1_Deform


; =============== S U B R O U T I N E =======================================


CNZ1_BossLevelScroll:
		cmpi.w	#$1E0,(Camera_Y_pos_BG_copy).w
		blo.s	CNZ1_BossLevelScroll2
		addq.w	#4,(Events_routine_bg).w

CNZ1_BossLevelScroll2:
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$100,d0
		add.w	(Events_bg+$08).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$2F80,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; End of function CNZ1_BossLevelScroll

; ---------------------------------------------------------------------------

Obj_CNZMinibossScrollControl:
		moveq	#0,d0
		move.b	routine(a0),d0
		jmp	CNZMinibossScrollControl_Index(pc,d0.w)
; ---------------------------------------------------------------------------

CNZMinibossScrollControl_Index:
		bra.w	Obj_CNZMinibossScrollInit
; ---------------------------------------------------------------------------
		bra.w	Obj_CNZMinibossScrollMain
; ---------------------------------------------------------------------------
		bra.w	Obj_CNZMinibossScrollWait
; ---------------------------------------------------------------------------
		bra.w	Obj_CNZMinibossScrollSlow
; ---------------------------------------------------------------------------
		bra.w	Obj_CNZMinibossScrollWait2
; ---------------------------------------------------------------------------
		bra.w	Obj_CNZMinibossScrollWait3
; ---------------------------------------------------------------------------

Obj_CNZMinibossScrollInit:
		lea	(Level_layout_main).w,a3
		movea.w	$14(a3),a1			; $280 Y
		move.b	$63(a1),d0			; $3180 X chunk
		suba.w	-8(a3),a1
		move.b	d0,$63(a1)			; Replace FG layout piece
		addq.w	#2,a3
		movea.w	(a3),a1
		move.b	4(a1),d0
		move.w	-8(a3),d1
		adda.w	d1,a1
		move.b	d0,4(a1)
		adda.w	d1,a1
		move.b	d0,4(a1)			; Replace BG layout piece
		addq.b	#4,routine(a0)

Obj_CNZMinibossScrollMain:
		tst.w	(Events_fg_5).w
		bne.s	loc_52042
		move.l	(Events_bg+$0C).w,d0	; Speed up scroll
		cmpi.l	#$40000,d0
		bhs.s	loc_5203C
		addi.l	#$200,d0
		move.l	d0,(Events_bg+$0C).w

loc_5203C:
		add.l	d0,(Events_bg+$08).w	; Set BG scrolling speed
		rts
; ---------------------------------------------------------------------------

loc_52042:
		clr.w	(Events_fg_5).w		; When boss is completed
		addq.b	#4,routine(a0)

Obj_CNZMinibossScrollWait:
		move.w	(Events_bg+$08).w,d0
		andi.w	#$FF,d0
		cmpi.w	#4,d0
		blo.s	loc_52062			; Wait until the offset is a multiple of $100
		move.l	(Events_bg+$0C).w,d0
		add.l	d0,(Events_bg+$08).w
		rts
; ---------------------------------------------------------------------------

loc_52062:
		addq.b	#4,routine(a0)

Obj_CNZMinibossScrollSlow:
		move.l	(Events_bg+$0C).w,d0	; Start slowing down the scrolling
		cmpi.l	#$10000,d0
		bls.s	loc_52082
		subi.l	#$400,d0
		move.l	d0,(Events_bg+$0C).w
		add.l	d0,(Events_bg+$08).w
		rts
; ---------------------------------------------------------------------------

loc_52082:
		addq.b	#4,routine(a0)

Obj_CNZMinibossScrollWait2:
		move.w	(Events_bg+$08).w,d0
		andi.w	#$FF,d0
		cmpi.w	#4,d0
		blo.s	loc_5209E			; Keep going until offset is a multiple of $100 again
		move.l	(Events_bg+$0C).w,d0
		add.l	d0,(Events_bg+$08).w
		rts
; ---------------------------------------------------------------------------

loc_5209E:
		move.w	d0,(Events_bg+$08).w		; Reset scroll offset
		move.w	#$1000,(Camera_target_max_Y_pos).w	; Reset Y end
		st	(Background_collision_flag).w		; BG collision is on
		addq.w	#4,(Events_routine_bg).w		; Next BG Event
		movea.w	(Level_layout_main).w,a1
		lea	$67(a1),a1
		move.w	(Level_layout_header).w,d0
		moveq	#0,d1
		moveq	#6,d2

loc_520C0:
		move.b	d1,(a1)					; Copy top of FG at $3380 downwards
		adda.w	d0,a1
		dbf	d2,loc_520C0
		addq.b	#4,routine(a0)

Obj_CNZMinibossScrollWait3:
		cmpi.w	#$1C0,(Events_bg+$08).w		; Wait till scroll offset is $1C0
		bhs.s	loc_520DE
		move.l	(Events_bg+$0C).w,d0
		add.l	d0,(Events_bg+$08).w
		rts
; ---------------------------------------------------------------------------

loc_520DE:
		st	(Events_fg_5).w				; Set flag to continue next BG event
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


CNZ1_ScrollToYStart:
		move.w	(Camera_Y_pos).w,d1
		cmp.w	d0,d1
		blo.s	loc_520F2
		exg	d0,d1

loc_520F2:
		cmp.w	(Camera_min_Y_pos).w,d1
		bls.s	locret_520FC
		move.w	d1,(Camera_min_Y_pos).w

locret_520FC:
		rts
; End of function CNZ1_ScrollToYStart

; ---------------------------------------------------------------------------
CNZ1_BGDeformArray:
		dc.w    $80,   $30,   $60,   $C0, $7FFF
; ---------------------------------------------------------------------------

CNZ2_ScreenInit:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

CNZ2_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		cmpi.w	#$4600,(Player_1+x_pos).w
		bhs.s	loc_52138			; If player is far enough to the right, skip ahead
		moveq	#0,d0
		cmpi.w	#$940,(Player_1+x_pos).w
		bhs.s	loc_5212E
		move.w	#$580,d0			; If player is still in old boss arena, set the level Y start to $580, otherwise, make it 0 like normal

loc_5212E:
		cmp.w	(Camera_min_Y_pos).w,d0
		beq.s	loc_52138
		move.w	d0,(Camera_min_Y_pos).w

loc_52138:
		tst.w	(Events_bg+$06).w
		beq.s	loc_52146
		clr.w	(Events_bg+$06).w
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

loc_52146:
		move.w	(Events_routine_fg).w,d0
		jmp	CNZ2_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

CNZ2_ScreenEvent_Index:
		bra.w	loc_5215A
; ---------------------------------------------------------------------------
		bra.w	loc_521D2
; ---------------------------------------------------------------------------
		bra.w	CNZ2SE_Normal
; ---------------------------------------------------------------------------

loc_5215A:
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_5216C
		move.w	#8,(Events_routine_fg).w	; If playing as Sonic/Tails, don't do any special screen events
		bra.w	CNZ2SE_Normal
; ---------------------------------------------------------------------------

loc_5216C:
		lea	(Player_1).w,a1		; Only do all this is Knuckles is playing
		cmpi.w	#$4880,x_pos(a1)
		blo.w	CNZ2SE_Normal		; If Knuckles is not past $4880 X, just play normally
		cmpi.w	#$B00,y_pos(a1)
		blo.s	CNZ2SE_Normal		; If Knuckles is not past $B00 Y, play normally
		jsr	(AllocateObject).l
		bne.s	loc_521BE
		move.l	#Obj_CNZTeleporter,(a1)
		jsr	(CreateNewSprite4).l
		bne.s	loc_521BE
		move.l	#Obj_EggCapsule,(a1)
		move.w	#$4980,x_pos(a1)
		move.w	#$A20,y_pos(a1)
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(PLC_EggCapsule).l,a1
		jsr	(Load_PLC_Raw).l
		movem.l	(sp)+,d7-a0/a2-a3

loc_521BE:
		move.w	#$4750,(Camera_min_X_pos).w
		move.w	#$48E0,(Camera_max_X_pos).w
		clr.b	(End_of_level_flag).w
		addq.w	#4,(Events_routine_fg).w

loc_521D2:
		tst.b	(End_of_level_flag).w
		beq.s	CNZ2SE_Normal
		jsr	(AllocateObject).l
		bne.s	CNZ2SE_Normal
		move.l	#Obj_IncLevEndXGradual,(a1)
		move.w	#$49A0,(Camera_stored_max_X_pos).w
		lea	(a2),a6
		jsr	(Restore_LevelMusic).l
		lea	(a6),a2
		jsr	(Restore_PlayerControl).l
		addq.w	#4,(Events_routine_fg).w

CNZ2SE_Normal:
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

CNZ2_BackgroundInit:
		move.w	#8,(Events_routine_bg).w
		jsr	CNZ1_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	CNZ1_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

CNZ2_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	CNZ2_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

CNZ2_BackgroundEvent_Index:
		bra.w	loc_52238
; ---------------------------------------------------------------------------
		bra.w	loc_52266
; ---------------------------------------------------------------------------
		bra.w	loc_5227C
; ---------------------------------------------------------------------------

loc_52238:
		moveq	#0,d1
		move.w	#$200,d2
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.w	PlainDeformation
		jsr	CNZ1_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_5226A
; ---------------------------------------------------------------------------

loc_52266:
		jsr	CNZ1_Deform(pc)

loc_5226A:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.s	loc_52280
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_52280
; ---------------------------------------------------------------------------

loc_5227C:
		jsr	CNZ1_Deform(pc)

loc_52280:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	CNZ1_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jsr	ApplyDeformation(pc)
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

Obj_CNZTeleporter:
		lea	(Player_1).w,a1
		cmpi.w	#$4A38,x_pos(a1)
		blo.s	locret_522FE		; If Knuckles isn't in range, don't bother
		btst	#Status_InAir,status(a1)
		beq.s	loc_522C2
		move.w	#$4A40,d0
		cmp.w	x_pos(a1),d0
		bhi.s	locret_522FE
		move.w	d0,x_pos(a1)			; While jumping, don't allow Knuckles past this point (so he lands on the teleporter)

loc_522C2:
		clr.w	x_vel(a1)
		clr.w	ground_vel(a1)				; Stop Knuckles' momentum
		st	(Ctrl_1_locked).w			; Turn off player control
		clr.w	(Ctrl_1_logical).w		; Clear buttons
		lea	(ArtKosM_CNZTeleport).l,a1
		move.w	#tiles_to_bytes(ArtTile_CNZTeleport),d2
		jsr	(Queue_Kos_Module).l	; Load teleporter graphics
		lea	(Normal_palette_line_2+$2).w,a1
		move.l	#$EEE0EC0,(a1)
		move.w	#$EA2,$E(a1)
		move.w	#$E80,$12(a1)		; Replace applicable palette entries
		move.l	#Obj_CNZTeleporterMain,(a0)

locret_522FE:
		rts
; ---------------------------------------------------------------------------

Obj_CNZTeleporterMain:
		tst.b	(Kos_modules_left).w
		bne.s	locret_52348		; Don't do anything while art is loading
		lea	(Player_1).w,a1
		btst	#Status_InAir,status(a1)
		bne.s	locret_52348		; Wait till Knuckles is not in the air
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_52348
		move.w	a1,$3C(a0)
		move.l	#Obj_TeleporterBeam,(a1)
		move.w	a0,parent2(a1)
		move.w	#$4A40,d0
		move.w	d0,x_pos(a0)
		move.w	d0,x_pos(a1)
		move.w	#$A38,y_pos(a1)		; Set teleporter position/attributes
		moveq	#signextendB(sfx_Charging),d0
		jsr	(Play_SFX).l
		move.l	#loc_5234A,(a0)

locret_52348:
		rts
; ---------------------------------------------------------------------------

loc_5234A:
		lea	(Player_1).w,a1
		movea.w	$3C(a0),a2
		cmpi.b	#8,$46(a2)
		blt.s	locret_523C8
		beq.s	loc_523B6		; Once beam has expanded halfway. On the first frame this happen, set player state
		cmpi.b	#$18,$46(a2)
		bhs.s	loc_5238E
		btst	#0,(Level_frame_counter+1).w
		beq.s	locret_523C8
		subq.w	#1,y_pos(a1)		; Raise player slightly
		btst	#1,(Level_frame_counter+1).w
		beq.s	locret_523C8
		moveq	#1,d1
		move.w	x_pos(a1),d0
		cmp.w	x_pos(a0),d0
		beq.s	locret_523C8
		bcs.s	loc_52388
		neg.w	d1

loc_52388:
		add.w	d1,x_pos(a1)		; Move player X towards center of beam X
		bra.s	locret_523C8
; ---------------------------------------------------------------------------

loc_5238E:
		move.l	#loc_523CA,(a0)	; When beam has expanded all the way
		move.b	#3,object_control(a1)		; Stop player animation
		moveq	#0,d0
		move.w	d0,y_pos(a1)		; Make player disappear!
		move.b	d0,anim(a1)
		move.b	d0,mapping_frame(a1)
		moveq	#signextendB(sfx_Transporter),d0
		jsr	(Play_SFX).l
		st	(Scroll_lock).w
		bra.s	locret_523C8
; ---------------------------------------------------------------------------

loc_523B6:
		move.b	#1,object_control(a1)		; Player under object control
		bset	#Status_Roll,status(a1)		; Set to jumping state
		move.b	#2,anim(a1)		; Rolling animation

locret_523C8:
		rts
; ---------------------------------------------------------------------------

loc_523CA:
		subi.w	#$10,(Camera_Y_pos).w
		cmpi.w	#$780,(Camera_Y_pos).w
		bhs.s	locret_523EA
		moveq	#signextendB(cmd_FadeOut),d0
		jsr	(Play_Music).l
		move.w	#$500,d0		; Start Ice Cap
		jmp	(StartNewLevel).l
; ---------------------------------------------------------------------------

locret_523EA:
		rts
; ---------------------------------------------------------------------------

FBZ1_ScreenInit:
		cmpi.w	#$180,(Player_1+x_pos).w
		blo.s	loc_52412
		move.w	-8(a3),d0
		subq.w	#5,d0
		movea.w	$34(a3),a1		; $680 Y
		movea.w	$48(a3),a5		; $900 Y
		moveq	#3-1,d1

loc_52404:
		move.l	(a5)+,(a1)+		; Copy the "indoors" beginning part
		move.b	(a5)+,(a1)+
		adda.w	d0,a1
		adda.w	d0,a5
		dbf	d1,loc_52404
		bra.s	loc_5241C
; ---------------------------------------------------------------------------

loc_52412:
		move.w	#$18,(Events_bg+$00).w		; If player is < $180 X
		st	(Events_bg+$02).w

loc_5241C:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

FBZ1_ScreenEvent:
		cmpi.b	#6,(Player_1+routine).w
		blo.s	loc_5242E
		rts							; Don't do any special events while Sonic is dying
; ---------------------------------------------------------------------------

loc_5242E:
		lea	FBZ1_LayoutModRange(pc),a1
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		move.w	(Events_bg+$00).w,d2
		jmp	FBZ1_ScreenEvent_Index(pc,d2.w)
; ---------------------------------------------------------------------------

FBZ1_ScreenEvent_Index:
		bra.w	FBZ1SE_Normal
; ---------------------------------------------------------------------------
		bra.w	FBZ1SE_LayoutMod1
; ---------------------------------------------------------------------------
		bra.w	FBZ1SE_LayoutMod2
; ---------------------------------------------------------------------------
		bra.w	FBZ1SE_LayoutMod3
; ---------------------------------------------------------------------------
		bra.w	FBZ1SE_LayoutMod4
; ---------------------------------------------------------------------------
		bra.w	FBZ1SE_LayoutMod5
; ---------------------------------------------------------------------------
		bra.w	FBZ1SE_LayoutMod6	; Beginning of stage
; ---------------------------------------------------------------------------

FBZ1SE_Normal:
		moveq	#4,d2
		moveq	#6-1,d3

loc_52462:
		lea	(a1),a5					; Check layout mod ranges
		cmp.w	(a5)+,d0
		blo.s	loc_5247A
		cmp.w	(a5)+,d0
		bhi.s	loc_5247A
		cmp.w	(a5)+,d1
		blo.s	loc_5247A
		cmp.w	(a5)+,d1
		bhi.s	loc_5247A
		move.w	d2,(Events_bg+$00).w
		bra.s	loc_52482
; ---------------------------------------------------------------------------

loc_5247A:
		addq.w	#8,a1
		addq.w	#4,d2
		dbf	d3,loc_52462

loc_52482:
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

FBZ1SE_LayoutMod1:
		jsr	FBZ1Screen_CheckInRange(pc)		; Make sure Sonic is still in range
		tst.w	(Events_bg+$02).w
		bne.s	loc_524AA
		cmpi.w	#$B00,d0		; If indoors, check if Sonic is in right half of ranged area
		bhs.s	loc_524A0		; If so, branch
		cmpi.w	#$70A,d0		; Otherwise, check if Sonic has gone far enough to the right
		bls.w	loc_52828
		bra.s	loc_524D4
; ---------------------------------------------------------------------------

loc_524A0:
		cmpi.w	#$A0E,d1		; If to the right of ranged area, instead check if Sonic has gone low enough
		bls.w	loc_52828
		bra.s	loc_524D4
; ---------------------------------------------------------------------------

loc_524AA:
		cmpi.w	#$B00,d0		; If outdoors, check if Sonic is in right half of ranged area
		bhs.s	loc_524BA		; If so, branch
		cmpi.w	#$6F6,d0		; Otherwise, check if Sonic has gone far enough to the left
		bls.s	loc_524C2
		bra.w	loc_52828
; ---------------------------------------------------------------------------

loc_524BA:
		cmpi.w	#$9F2,d1		; If to the right of ranged area, instead check if Sonic has gone high enough
		bhi.w	loc_52828

loc_524C2:
		clr.w	(Events_bg+$02).w	; In either case, go outdoors->indoors
		movea.w	(a3),a5
		lea	$60(a5),a5
		movea.w	(a3),a6
		lea	$64(a6),a6
		bra.s	loc_524E8
; ---------------------------------------------------------------------------

loc_524D4:
		st	(Events_bg+$02).w		; Go indoors->outdoors
		movea.w	$18(a3),a5
		lea	$60(a5),a5			; First source is at $300 Y, $3000 X
		movea.w	$14(a3),a6
		lea	$64(a6),a6			; Second source is at $280 Y, $3200 X (both of these are technically out of range)

loc_524E8:
		movea.w	$48(a3),a1
		lea	$C(a1),a1			; First destination is $900 Y, $600 X
		move.w	-8(a3),d0
		subq.w	#4,d0			; Width of four tiles
		moveq	#6-1,d1			; Height of 6 tiles

loc_524F8:
		move.l	(a5)+,(a1)+		; Copy over layout
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_524F8
		movea.w	$48(a3),a1
		lea	$1A(a1),a1			; Second destination is $900 Y, $D00 X
		move.w	-8(a3),d0
		subq.w	#6,d0			; Width of 6 tiles
		moveq	#4-1,d1			; Height of 4 tiles

loc_52512:
		move.l	(a6)+,(a1)+
		move.w	(a6)+,(a1)+		; Copy over layout
		adda.w	d0,a6
		adda.w	d0,a1
		dbf	d1,loc_52512
		jmp	Refresh_PlaneScreenDirect(pc)	; Refresh screen
; ---------------------------------------------------------------------------

FBZ1SE_LayoutMod2:
		lea	8(a1),a1			; The following layout mods all basically work identically to the above with modifications in positioning, etc.
		jsr	FBZ1Screen_CheckInRange(pc)		; I'll leave it as an exercise to the reader to get the specifics of each routine :)
		tst.w	(Events_bg+$02).w
		bne.s	loc_5254A
		cmpi.w	#$C80,d0
		bhs.s	loc_52540
		cmpi.w	#$1F2,d1
		bhs.w	loc_52828
		bra.s	loc_52574
; ---------------------------------------------------------------------------

loc_52540:
		cmpi.w	#$108A,d0
		bls.w	loc_52828
		bra.s	loc_52574
; ---------------------------------------------------------------------------

loc_5254A:
		cmpi.w	#$C80,d0
		bhs.s	loc_5255A
		cmpi.w	#$20E,d1
		bhs.s	loc_52562
		bra.w	loc_52828
; ---------------------------------------------------------------------------

loc_5255A:
		cmpi.w	#$1076,d0
		bhi.w	loc_52828

loc_52562:
		clr.w	(Events_bg+$02).w
		movea.w	(a3),a5
		lea	$6C(a5),a5
		movea.w	(a3),a6
		lea	$76(a6),a6
		bra.s	loc_52588
; ---------------------------------------------------------------------------

loc_52574:
		st	(Events_bg+$02).w
		movea.w	$14(a3),a5
		lea	$6C(a5),a5
		movea.w	$10(a3),a6
		lea	$76(a6),a6

loc_52588:
		movea.w	8(a3),a1
		lea	$E(a1),a1
		move.w	-8(a3),d0
		subi.w	#$A,d0
		moveq	#4-1,d1

loc_5259A:
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		move.w	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_5259A
		movea.w	$C(a3),a1
		lea	$1C(a1),a1
		move.w	-8(a3),d0
		subi.w	#$C,d0
		moveq	#3-1,d1

loc_525BA:
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		adda.w	d0,a6
		adda.w	d0,a1
		dbf	d1,loc_525BA
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

FBZ1SE_LayoutMod3:
		lea	$10(a1),a1
		jsr	FBZ1Screen_CheckInRange(pc)
		tst.w	(Events_bg+$02).w
		bne.s	loc_525F4
		cmpi.w	#$1880,d0
		bhs.s	loc_525EA
		cmpi.w	#$158A,d0
		bls.w	loc_52828
		bra.s	loc_52622
; ---------------------------------------------------------------------------

loc_525EA:
		cmpi.w	#$A0E,d1
		bls.w	loc_52828
		bra.s	loc_52622
; ---------------------------------------------------------------------------

loc_525F4:
		cmpi.w	#$1880,d0
		bhs.s	loc_52604
		cmpi.w	#$1576,d0
		bls.s	loc_5260C
		bra.w	loc_52828
; ---------------------------------------------------------------------------

loc_52604:
		cmpi.w	#$9F2,d1
		bhi.w	loc_52828

loc_5260C:
		clr.w	(Events_bg+$02).w
		movea.w	$34(a3),a5
		lea	$60(a5),a5
		movea.w	$28(a3),a6
		lea	$66(a6),a6
		bra.s	loc_52636
; ---------------------------------------------------------------------------

loc_52622:
		st	(Events_bg+$02).w
		movea.w	$44(a3),a5
		lea	$60(a5),a5
		movea.w	$3C(a3),a6
		lea	$66(a6),a6

loc_52636:
		movea.w	$48(a3),a1
		lea	$28(a1),a1
		move.w	-8(a3),d0
		subq.w	#6,d0
		moveq	#4-1,d1

loc_52646:
		move.l	(a5)+,(a1)+
		move.w	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_52646
		movea.w	$48(a3),a1
		lea	$34(a1),a1
		move.w	-8(a3),d0
		subq.w	#6,d0
		moveq	#4-1,d1

loc_52662:
		move.l	(a6)+,(a1)+
		move.w	(a6)+,(a1)+
		adda.w	d0,a6
		adda.w	d0,a1
		dbf	d1,loc_52662
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

FBZ1SE_LayoutMod4:
		lea	$18(a1),a1
		jsr	FBZ1Screen_CheckInRange(pc)
		tst.w	(Events_bg+$02).w
		bne.s	loc_526A0
		cmpi.w	#$208A,d0
		bhs.s	loc_526D6
		cmpi.w	#$1D80,d0
		bhs.s	loc_52696
		cmpi.w	#$1C0A,d0
		bls.w	loc_52828
		bra.s	loc_526D6
; ---------------------------------------------------------------------------

loc_52696:
		cmpi.w	#$F2,d1
		bhs.w	loc_52828
		bra.s	loc_526D6
; ---------------------------------------------------------------------------

loc_526A0:
		cmpi.w	#$1D80,d0
		bhs.s	loc_526B0
		cmpi.w	#$1BF6,d0
		bls.s	loc_526C0
		bra.w	loc_52828
; ---------------------------------------------------------------------------

loc_526B0:
		cmpi.w	#$10E,d1
		bls.w	loc_52828
		cmpi.w	#$2076,d0
		bhs.w	loc_52828

loc_526C0:
		clr.w	(Events_bg+$02).w
		movea.w	$28(a3),a5
		lea	$6E(a5),a5
		movea.w	$28(a3),a6
		lea	$76(a6),a6
		bra.s	loc_526EA
; ---------------------------------------------------------------------------

loc_526D6:
		st	(Events_bg+$02).w
		movea.w	$3C(a3),a5
		lea	$6E(a5),a5
		movea.w	$3C(a3),a6
		lea	$76(a6),a6

loc_526EA:
		movea.w	(a3),a1
		lea	$36(a1),a1
		move.w	-8(a3),d0
		subq.w	#8,d0
		moveq	#4-1,d1

loc_526F8:
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_526F8
		movea.w	(a3),a1
		lea	$3E(a1),a1
		move.w	-8(a3),d0
		subi.w	#$12,d0
		moveq	#5-1,d1

loc_52714:
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.w	(a6)+,(a1)+
		adda.w	d0,a6
		adda.w	d0,a1
		dbf	d1,loc_52714
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

FBZ1SE_LayoutMod5:
		lea	$20(a1),a1
		jsr	FBZ1Screen_CheckInRange(pc)
		cmpi.w	#$2100,d0
		blo.s	loc_52740
		cmpi.w	#$2600,d0
		bls.w	loc_52828

loc_52740:
		tst.w	(Events_bg+$02).w
		bne.s	loc_52750
		cmpi.w	#$172,d1
		bhs.w	loc_52828
		bra.s	loc_5276E
; ---------------------------------------------------------------------------

loc_52750:
		cmpi.w	#$18E,d1
		blo.w	loc_52828
		clr.w	(Events_bg+$02).w
		movea.w	$28(a3),a5
		lea	$6E(a5),a5
		movea.w	$28(a3),a6
		lea	$76(a6),a6
		bra.s	loc_52782
; ---------------------------------------------------------------------------

loc_5276E:
		st	(Events_bg+$02).w
		movea.w	$3C(a3),a5
		lea	$6E(a5),a5
		movea.w	$3C(a3),a6
		lea	$76(a6),a6

loc_52782:
		movea.w	(a3),a1
		lea	$36(a1),a1
		move.w	-8(a3),d0
		subq.w	#8,d0
		moveq	#4-1,d1

loc_52790:
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_52790
		movea.w	(a3),a1
		lea	$3E(a1),a1
		move.w	-8(a3),d0
		subi.w	#$12,d0
		moveq	#5-1,d1

loc_527AC:
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.w	(a6)+,(a1)+
		adda.w	d0,a6
		adda.w	d0,a1
		dbf	d1,loc_527AC
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

FBZ1SE_LayoutMod6:
		lea	$28(a1),a1			; Get the last layout change range
		jsr	FBZ1Screen_CheckInRange(pc)	; Ensure player is still in specified range
		tst.w	(Events_bg+$02).w
		bne.s	loc_527DA
		cmpi.w	#$70E,d1		; If "indoors", check if Sonic is below given point
		bls.w	loc_52828		; If not, don't do anything
		bra.s	loc_527EC
; ---------------------------------------------------------------------------

loc_527DA:
		cmpi.w	#$6F2,d1		; If "outdoors" flag is set, check if Sonic is above point given
		bhi.w	loc_52828		; If not, don't do anything
		clr.w	(Events_bg+$02).w	; Make Sonic "indoors"
		movea.w	$48(a3),a5		; Perform layout copy of indoor tiles
		bra.s	loc_527F4
; ---------------------------------------------------------------------------

loc_527EC:
		st	(Events_bg+$02).w		; Make Sonic "outdoors"
		movea.w	$54(a3),a5		; Perform layout copy of outdoor tiles

loc_527F4:
		movea.w	$34(a3),a1
		move.w	-8(a3),d0
		subq.w	#5,d0
		moveq	#3-1,d1

loc_52800:
		move.l	(a5)+,(a1)+
		move.b	(a5)+,(a1)+		; Perform layout copy
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_52800
		jmp	Refresh_PlaneScreenDirect(pc)	; Redraw screen directly

; =============== S U B R O U T I N E =======================================


FBZ1Screen_CheckInRange:
		cmp.w	(a1)+,d0
		blo.s	loc_52822
		cmp.w	(a1)+,d0
		bhi.s	loc_52822
		cmp.w	(a1)+,d1
		blo.s	loc_52822
		cmp.w	(a1)+,d1
		bhi.s	loc_52822
		rts
; ---------------------------------------------------------------------------

loc_52822:
		addq.w	#4,sp
		clr.w	(Events_bg+$00).w

loc_52828:
		jmp	DrawTilesAsYouMove(pc)
; End of function FBZ1Screen_CheckInRange

; ---------------------------------------------------------------------------
FBZ1_LayoutModRange:
		dc.w   $400,  $F00,  $880,  $A80
		dc.w   $880, $1100,  $180,  $300
		dc.w  $1400, $1B80,  $900,  $B00
		dc.w  $1A80, $2100,   $80,  $200
		dc.w  $2080, $2680,  $100,  $280
		dc.w      0,  $180,  $580,  $780
; ---------------------------------------------------------------------------

FBZ1_BackgroundInit:
		jsr	(AllocateObject).l
		bne.s	loc_5286A
		move.l	#Obj_FBZOutdoorBGMotion,(a1)

loc_5286A:
		cmpi.w	#$180,(Player_1+x_pos).w
		bhs.s	loc_528A4
		st	(Events_bg+$04).w		; if player is at start, then he's outside. Set outdoors flag
		lea	Pal_FBZBGOutdoors(pc),a1
		lea	(Target_palette_line_4+$4).w,a5
		move.l	(a1)+,(a5)+		; Change to outdoor palette
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		jsr	FBZ_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		move.w	#$200,d1		; Outdoor BG is $200 pixels right of indoor BG
		moveq	#0,d0
		jsr	Refresh_PlaneFull(pc)
		lea	FBZ_OutBGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

loc_528A4:
		jsr	FBZ_Deform(pc)		; Indoors
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	FBZ_InBGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

FBZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	FBZ1_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

FBZ1_BackgroundEvent_Index:
		bra.w	FBZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	FBZ1BGE_ChangeTopDown
; ---------------------------------------------------------------------------
		bra.w	FBZ1BGE_ChangeBottomUp
; ---------------------------------------------------------------------------
		bra.w	FBZ1BGE_ChangeLeftRight
; ---------------------------------------------------------------------------
		bra.w	FBZ1BGE_ChangeRightLeft
; ---------------------------------------------------------------------------

FBZ1BGE_ChangeTopDown:
		jsr	FBZ1_CheckBGChange(pc)

loc_528DE:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		tst.w	(Events_bg+$04).w
		beq.s	loc_528F0
		move.w	#$200,d1
		moveq	#0,d2

loc_528F0:
		jsr	Draw_PlaneVertTopDown(pc)
		bpl.w	FBZ1BGE_GoDeform
		clr.w	(Events_routine_bg).w
		bra.w	FBZ1BGE_GoDeform
; ---------------------------------------------------------------------------

FBZ1BGE_ChangeBottomUp:
		jsr	FBZ1_CheckBGChange(pc)

loc_52904:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		tst.w	(Events_bg+$04).w
		beq.s	loc_52916
		move.w	#$200,d1
		moveq	#0,d2

loc_52916:
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.w	FBZ1BGE_GoDeform
		clr.w	(Events_routine_bg).w
		bra.w	FBZ1BGE_GoDeform
; ---------------------------------------------------------------------------

FBZ1BGE_ChangeLeftRight:
		jsr	FBZ1_CheckBGChange(pc)

loc_5292A:
		move.w	(Camera_Y_pos_BG_copy).w,d1
		moveq	#0,d2
		tst.w	(Events_bg+$04).w
		beq.s	loc_5293C
		moveq	#0,d1
		move.w	#$200,d2

loc_5293C:
		jsr	Draw_PlaneHorzLeftToRight(pc)
		bpl.w	FBZ1BGE_GoDeform
		clr.w	(Events_routine_bg).w
		bra.w	FBZ1BGE_GoDeform
; ---------------------------------------------------------------------------

FBZ1BGE_ChangeRightLeft:
		jsr	FBZ1_CheckBGChange(pc)

loc_52950:
		move.w	(Camera_Y_pos_BG_copy).w,d1
		moveq	#0,d2
		tst.w	(Events_bg+$04).w
		beq.s	loc_52962
		moveq	#0,d1
		move.w	#$200,d2

loc_52962:
		jsr	Draw_PlaneHorzRightToLeft(pc)
		bpl.w	FBZ1BGE_GoDeform
		clr.w	(Events_routine_bg).w
		bra.w	FBZ1BGE_GoDeform
; ---------------------------------------------------------------------------

FBZ1BGE_Normal:
		tst.w	(Events_fg_5).w
		beq.s	loc_529EE
		clr.w	(Events_fg_5).w		; Check for transition flag
		movem.l	d7-a0/a2-a3,-(sp)
		moveq	#PLCID_1C,d0
		jsr	(Load_PLC).l
		move.w	#$401,(Current_zone_and_act).w
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(Respawn_table_keep).w
		jsr	Clear_Switches(pc)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		moveq	#PalID_FBZ2,d0
		jsr	(LoadPalette_Immediate).l
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$2E00,d0
		moveq	#0,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d0,(Player_2+x_pos).w
		jsr	Offset_ObjectsDuringTransition(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w
		jsr	Reset_TileOffsetPositionActual(pc)
		jsr	FBZ_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		bra.s	FBZ1BGE_GoDeform
; ---------------------------------------------------------------------------

loc_529EE:
		cmpi.b	#6,(Player_1+routine).w
		blo.s	loc_529F8
		rts						; Don't do special events if Sonic is dying
; ---------------------------------------------------------------------------

loc_529F8:
		jsr	FBZ1_CheckBGChange(pc)

FBZ1BGE_GoDeform:
		move.w	(Events_bg+$04).w,d1
		beq.s	loc_52A06
		move.w	#$200,d1

loc_52A06:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	FBZ_InBGDeformArray(pc),a4
		tst.w	(Events_bg+$04).w
		beq.s	loc_52A22
		lea	FBZ_OutBGDeformArray(pc),a4

loc_52A22:
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)

; =============== S U B R O U T I N E =======================================


FBZ_Deform:
		tst.w	(Events_bg+$04).w
		bne.s	loc_52A70
		move.w	(Camera_Y_pos_copy).w,d0	; Indoors
		asr.w	#1,d0
		move.w	d0,d1
		asr.w	#5,d1
		sub.w	d1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w	; Effective BG Y is slightly below half speed of normal BG Y
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		lea	(HScroll_table).w,a1
		lea	FBZ_InBGDeformIndex(pc),a5
		moveq	#0,d2

loc_52A56:
		move.b	(a5)+,d3
		bmi.s	locret_52A6E
		ext.w	d3
		swap	d0

loc_52A5E:
		move.b	(a5)+,d2
		move.w	d0,(a1,d2.w)
		dbf	d3,loc_52A5E
		swap	d0
		add.l	d1,d0
		bra.s	loc_52A56
; ---------------------------------------------------------------------------

locret_52A6E:
		rts
; ---------------------------------------------------------------------------

loc_52A70:
		moveq	#$16,d0				; Outdoors
		add.w	(Events_bg+$08).w,d0	; Add offset of bobbing motion to 16
		move.w	d0,(Camera_Y_pos_BG_copy).w
		lea	(HScroll_table).w,a1
		lea	FBZ_OutBGDeformIndex(pc),a5
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		asr.l	#1,d1
		move.l	(HScroll_table+$1FC).w,d2	; Get cloud movement speed
		addi.l	#$E00,(HScroll_table+$1FC).w
		moveq	#9-1,d3

loc_52A9E:
		move.w	(a5)+,d4
		add.l	d2,d0
		swap	d0
		move.w	d0,(a1,d4.w)
		swap	d0
		add.l	d1,d0
		dbf	d3,loc_52A9E
		rts
; End of function FBZ_Deform


; =============== S U B R O U T I N E =======================================


FBZ1_CheckBGChange:
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		move.w	(Events_bg+$00).w,d2	; The BG change events are synced with the layout mod events in screen events. Each numbered routine
		jmp	FBZ1_CheckBGChange_Index(pc,d2.w)		; here corresponds with the same layoutmod number in FBZ1_ScreenEvents
; End of function FBZ1_CheckBGChange

; ---------------------------------------------------------------------------

FBZ1_CheckBGChange_Index:
		bra.w	FBZ_Deform		; If no event, then just do business as usual
; ---------------------------------------------------------------------------
		bra.w	FBZ1_BGChange1
; ---------------------------------------------------------------------------
		bra.w	FBZ1_BGChange2
; ---------------------------------------------------------------------------
		bra.w	FBZ1_BGChange3
; ---------------------------------------------------------------------------
		bra.w	FBZ1_BGChange4
; ---------------------------------------------------------------------------
		bra.w	FBZ1_BGChange5
; ---------------------------------------------------------------------------
		bra.w	FBZ1_BGChange6
; ---------------------------------------------------------------------------

FBZ1_BGChange1:
		tst.w	(Events_bg+$04).w
		bne.s	loc_52AFE
		cmpi.w	#$B00,d0		; If indoors
		bhs.s	loc_52AF4
		cmpi.w	#$9C0,d1
		blo.w	FBZ_Deform
		bra.s	loc_52B22
; ---------------------------------------------------------------------------

loc_52AF4:
		cmpi.w	#$900,d1
		blo.w	FBZ_Deform
		bra.s	loc_52B22
; ---------------------------------------------------------------------------

loc_52AFE:
		cmpi.w	#$B00,d0		; If outdoors
		bhs.s	loc_52B0E
		cmpi.w	#$9C0,d1
		bhi.w	FBZ_Deform
		bra.s	loc_52B16
; ---------------------------------------------------------------------------

loc_52B0E:
		cmpi.w	#$900,d1
		bhi.w	FBZ_Deform

loc_52B16:
		clr.w	(Events_bg+$04).w
		moveq	#4,d0
		moveq	#0,d6
		bra.w	FBZ_BGChangeGoIn
; ---------------------------------------------------------------------------

loc_52B22:
		st	(Events_bg+$04).w
		moveq	#8,d0
		move.w	#$F0,d6
		bra.w	FBZ_BGChangeGoOut
; ---------------------------------------------------------------------------

FBZ1_BGChange2:
		tst.w	(Events_bg+$04).w
		bne.s	loc_52B50
		cmpi.w	#$C80,d0
		bhs.s	loc_52B46
		cmpi.w	#$2C0,d1
		bhi.w	FBZ_Deform
		bra.s	loc_52B76
; ---------------------------------------------------------------------------

loc_52B46:
		cmpi.w	#$240,d1
		bhi.w	FBZ_Deform
		bra.s	loc_52B76
; ---------------------------------------------------------------------------

loc_52B50:
		cmpi.w	#$C80,d0
		bhs.s	loc_52B60
		cmpi.w	#$2C0,d1
		blo.w	FBZ_Deform
		bra.s	loc_52B68
; ---------------------------------------------------------------------------

loc_52B60:
		cmpi.w	#$240,d1
		blo.w	FBZ_Deform

loc_52B68:
		clr.w	(Events_bg+$04).w
		moveq	#8,d0
		move.w	#$F0,d6
		bra.w	FBZ_BGChangeGoIn
; ---------------------------------------------------------------------------

loc_52B76:
		st	(Events_bg+$04).w
		moveq	#4,d0
		moveq	#0,d6
		bra.w	FBZ_BGChangeGoOut
; ---------------------------------------------------------------------------

FBZ1_BGChange3:
		tst.w	(Events_bg+$04).w
		bne.s	loc_52BA2
		cmpi.w	#$1880,d0
		bhs.s	loc_52B98
		cmpi.w	#$9C0,d1
		blo.w	FBZ_Deform
		bra.s	loc_52BC6
; ---------------------------------------------------------------------------

loc_52B98:
		cmpi.w	#$940,d1
		blo.w	FBZ_Deform
		bra.s	loc_52BC6
; ---------------------------------------------------------------------------

loc_52BA2:
		cmpi.w	#$1880,d0
		bhs.s	loc_52BB2
		cmpi.w	#$9C0,d1
		bhi.w	FBZ_Deform
		bra.s	loc_52BBA
; ---------------------------------------------------------------------------

loc_52BB2:
		cmpi.w	#$940,d1
		bhi.w	FBZ_Deform

loc_52BBA:
		clr.w	(Events_bg+$04).w
		moveq	#4,d0
		moveq	#0,d6
		bra.w	FBZ_BGChangeGoIn
; ---------------------------------------------------------------------------

loc_52BC6:
		st	(Events_bg+$04).w
		moveq	#8,d0
		move.w	#$F0,d6
		bra.w	FBZ_BGChangeGoOut
; ---------------------------------------------------------------------------

FBZ1_BGChange4:
		cmpi.w	#$100,d1
		blo.s	loc_52C0C
		tst.w	(Events_bg+$04).w
		bne.s	loc_52BEA
		cmpi.w	#$1C0,d1
		bhi.w	FBZ_Deform
		bra.s	loc_52C00
; ---------------------------------------------------------------------------

loc_52BEA:
		cmpi.w	#$1C0,d1
		blo.w	FBZ_Deform
		clr.w	(Events_bg+$04).w
		moveq	#8,d0
		move.w	#$F0,d6
		bra.w	FBZ_BGChangeGoIn
; ---------------------------------------------------------------------------

loc_52C00:
		st	(Events_bg+$04).w
		moveq	#4,d0
		moveq	#0,d6
		bra.w	FBZ_BGChangeGoOut
; ---------------------------------------------------------------------------

loc_52C0C:
		tst.w	(Events_bg+$04).w
		bne.s	loc_52C1C
		cmpi.w	#$1B00,d0
		blo.w	FBZ_Deform
		bra.s	loc_52C2E
; ---------------------------------------------------------------------------

loc_52C1C:
		cmpi.w	#$1B00,d0
		bhi.w	FBZ_Deform
		clr.w	(Events_bg+$04).w
		moveq	#$C,d0
		moveq	#0,d6
		bra.s	loc_52C3E
; ---------------------------------------------------------------------------

loc_52C2E:
		st	(Events_bg+$04).w
		moveq	#$10,d0
		move.w	#$3F0,d6
		lea	Pal_FBZBGOutdoors(pc),a1
		bra.s	loc_52C42
; ---------------------------------------------------------------------------

loc_52C3E:
		lea	Pal_FBZBGIndoors(pc),a1		; Special case for going left/right rather than up/down

loc_52C42:
		lea	(Normal_palette_line_4+$4).w,a5
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.w	d0,(Events_routine_bg).w
		jsr	FBZ_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		move.w	d6,(Draw_delayed_position).w
		move.w	#$1F,(Draw_delayed_rowcount).w
		addq.w	#4,sp
		cmpi.w	#$C,(Events_routine_bg).w
		beq.w	loc_5292A
		bra.w	loc_52950
; ---------------------------------------------------------------------------

FBZ1_BGChange5:
		tst.w	(Events_bg+$04).w
		bne.s	loc_52C84
		cmpi.w	#$240,d1
		bhi.w	FBZ_Deform
		bra.s	loc_52C98
; ---------------------------------------------------------------------------

loc_52C84:
		cmpi.w	#$240,d1
		blo.w	FBZ_Deform
		clr.w	(Events_bg+$04).w
		moveq	#8,d0
		move.w	#$F0,d6
		bra.s	FBZ_BGChangeGoIn
; ---------------------------------------------------------------------------

loc_52C98:
		st	(Events_bg+$04).w
		moveq	#4,d0
		moveq	#0,d6
		bra.s	FBZ_BGChangeGoOut
; ---------------------------------------------------------------------------

FBZ1_BGChange6:
		tst.w	(Events_bg+$04).w
		bne.s	loc_52CB2
		cmpi.w	#$640,d1
		blo.w	FBZ_Deform
		bra.s	loc_52CC4
; ---------------------------------------------------------------------------

loc_52CB2:
		cmpi.w	#$640,d1
		bhi.w	FBZ_Deform
		clr.w	(Events_bg+$04).w
		moveq	#4,d0
		moveq	#0,d6
		bra.s	FBZ_BGChangeGoIn
; ---------------------------------------------------------------------------

loc_52CC4:
		st	(Events_bg+$04).w
		moveq	#8,d0
		move.w	#$F0,d6

FBZ_BGChangeGoOut:
		lea	Pal_FBZBGOutdoors(pc),a1
		bra.s	loc_52CD8
; ---------------------------------------------------------------------------

FBZ_BGChangeGoIn:
		lea	Pal_FBZBGIndoors(pc),a1

loc_52CD8:
		lea	(Normal_palette_line_4+$4).w,a5
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+			; Modify the palette as needed
		move.w	d0,(Events_routine_bg).w	; Set the appropriate BG event to handle the change
		jsr	FBZ_Deform(pc)			; Do deformation as normal
		jsr	Reset_TileOffsetPositionEff(pc)
		add.w	d6,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,sp				; Finish here without doing anything else
		cmpi.w	#4,(Events_routine_bg).w
		beq.w	loc_528DE
		bra.w	loc_52904
; ---------------------------------------------------------------------------

Obj_FBZOutdoorBGMotion:
		move.l	#$2800,d0			; Uses built-in bobbing motion function to move BG up and down
		move.l	#$80,d1
		jsr	(Gradual_SwingOffset).l
		move.w	d0,(Events_bg+$08).w
		rts
; ---------------------------------------------------------------------------
FBZ_InBGDeformArray:
		dc.w    $80
		dc.w    $40
		dc.w    $20
		dc.w      8
		dc.w      8
		dc.w      8
		dc.w      8
		dc.w    $28
		dc.w    $30
		dc.w      8
		dc.w      4
		dc.w      4
		dc.w    $B8
		dc.w    $30
		dc.w    $10
		dc.w    $10
		dc.w    $30
		dc.w    $28
		dc.w    $18
		dc.w    $10
		dc.w    $30
		dc.w    $30
		dc.w    $10
		dc.w    $10
		dc.w    $30
		dc.w    $28
		dc.w    $18
		dc.w    $10
		dc.w    $B0
		dc.w    $30
		dc.w    $28
		dc.w    $40
		dc.w    $18
		dc.w    $30
		dc.w  $7FFF
FBZ_OutBGDeformArray:
		dc.w    $30
		dc.w    $20
		dc.w    $30
		dc.w    $10
		dc.w    $10
		dc.w    $10
		dc.w    $10
		dc.w    $10
		dc.w  $7FFF
FBZ_InBGDeformIndex:
		dc.b  1-1,  $C
		dc.b  2-1,  $A, $16
		dc.b $B-1,   8, $14, $18, $1C, $20, $24, $28, $2C, $30, $34, $38
		dc.b  3-1,   6, $12, $3E
		dc.b  1-1, $46
		dc.b  8-1,   4, $10, $1E, $26, $2E, $36, $3A, $40
		dc.b  4-1,  $E, $22, $32, $3C
		dc.b  2-1,   0, $44
		dc.b  4-1,   2, $1A, $2A, $42
		dc.b  $FF
		even
FBZ_OutBGDeformIndex:
		dc.w     $E
		dc.w      2
		dc.w     $A
		dc.w      6
		dc.w     $C
		dc.w      4
		dc.w      8
		dc.w      0
		dc.w    $10
Pal_FBZBGIndoors:
		binclude "Levels/FBZ/Palettes/FBZ BG Indoors.bin"
		even
Pal_FBZBGOutdoors:
		binclude "Levels/FBZ/Palettes/FBZ BG Outdoors.bin"
		even
; ---------------------------------------------------------------------------

FBZ2_ScreenInit:
		move.w	#$2C40,d0
		cmp.w	(Camera_X_pos).w,d0
		bhi.s	loc_52E2C
		move.w	#4,(Events_routine_fg).w	; If screen X is past subboss battle, change screen event
		move.w	d0,(Camera_min_X_pos).w
		jsr	SetUp_FBZ2BossEvent(pc)
		clr.l	(_unkEE98).w
		clr.l	(_unkEE9C).w		; Clear BG camera offset
		move.w	#VRAM_Plane_B_Name_Table,d7
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(ArtKosM_FBZCloud).l,a1
		move.w	#tiles_to_bytes(ArtTile_FBZCloud),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_FBZBossPillar).l,a1
		move.w	#tiles_to_bytes(ArtTile_FBZBossPillar),d2
		jsr	(Queue_Kos_Module).l	; Load boss event graphics
		movem.l	(sp)+,d7-a0/a2-a3

loc_52E2C:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

FBZ2_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	(Events_routine_fg).w,d0
		jmp	FBZ2_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

FBZ2_ScreenEvent_Index:
		bra.w	FBZ2SE_Normal
; ---------------------------------------------------------------------------
		bra.w	FBZ2SE_BossEvent
; ---------------------------------------------------------------------------
		bra.w	FBZ2SE_BossEventRefresh
; ---------------------------------------------------------------------------
		bra.w	FBZ2SE_BossEventEnd
; ---------------------------------------------------------------------------

FBZ2SE_Normal:
		cmpi.b	#6,(Player_1+routine).w
		blo.s	loc_52E5E
		rts
; ---------------------------------------------------------------------------

loc_52E5E:
		lea	FBZ2_LayoutModRange(pc),a1		; Only one layout mod this time around
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		move.w	(Events_bg+$00).w,d2
		jmp	loc_52E72(pc,d2.w)
; ---------------------------------------------------------------------------

loc_52E72:
		bra.w	FBZ2_NoLayoutMod
; ---------------------------------------------------------------------------
		bra.w	FBZ2_LayoutMod1
; ---------------------------------------------------------------------------

FBZ2_NoLayoutMod:
		cmp.w	(a1)+,d0
		blo.s	loc_52E90
		cmp.w	(a1)+,d0
		bhi.s	loc_52E90
		cmp.w	(a1)+,d1
		blo.s	loc_52E90
		cmp.w	(a1)+,d1
		bhi.s	loc_52E90
		move.w	#4,(Events_bg+$00).w

loc_52E90:
		jsr	DrawTilesAsYouMove(pc)
		cmpi.w	#$2B30,(Camera_X_pos).w
		blo.s	locret_52EAC
		jsr	SetUp_FBZ2BossEvent(pc)		; If Player passes certain point, set up the boss event
		clr.l	(_unkEE98).w
		clr.l	(_unkEE9C).w
		addq.w	#4,(Events_routine_fg).w

locret_52EAC:
		rts
; ---------------------------------------------------------------------------

FBZ2_LayoutMod1:
		jsr	FBZ1Screen_CheckInRange(pc)
		cmpi.w	#$E00,d0
		blo.s	loc_52EBE
		cmpi.w	#$1280,d0
		bls.s	loc_52F10

loc_52EBE:
		tst.w	(Events_bg+$02).w
		bne.s	loc_52ECC
		cmpi.w	#$B0E,d1		; If indoors
		bls.s	loc_52F10
		bra.s	loc_52EDE
; ---------------------------------------------------------------------------

loc_52ECC:
		cmpi.w	#$AF2,d1		; If outdoors
		bhi.s	loc_52F10
		clr.w	(Events_bg+$02).w
		movea.w	(a3),a5
		lea	$70(a5),a5
		bra.s	loc_52EEA
; ---------------------------------------------------------------------------

loc_52EDE:
		st	(Events_bg+$02).w
		movea.w	$10(a3),a5
		lea	$70(a5),a5

loc_52EEA:
		movea.w	$50(a3),a1
		lea	$1A(a1),a1
		move.w	-8(a3),d0
		subi.w	#$E,d0		; Width of 14 tiles
		moveq	#4-1,d1		; Height of 4 tiles

loc_52EFC:
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		move.w	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_52EFC
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

loc_52F10:
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

FBZ2SE_BossEvent:
		move.w	#VRAM_Plane_B_Name_Table,d7			; Draw FG tiles on BG plane instead
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

FBZ2SE_BossEventRefresh:
		move.w	#VRAM_Plane_B_Name_Table,d7
		move.w	#$2D00,d1
		moveq	#0,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	FBZ2SE_BossEventEnd
		addq.w	#4,(Events_routine_fg).w

FBZ2SE_BossEventEnd:
		rts

; =============== S U B R O U T I N E =======================================


SetUp_FBZ2BossEvent:
		jsr	(AllocateObject).l
		bne.s	loc_52F7A
		move.l	#Obj_FBZEndBossEventControl,(a1)
		jsr	(CreateNewSprite4).l
		bne.s	loc_52F7A
		move.l	#Obj_FBZBossPillar,(a1)
		lea	(FBZ_cloud_addr).w,a5
		moveq	#0,d1
		moveq	#5-1,d2

loc_52F56:
		move.l	d1,(a5)+		; Reset object addresses for clouds
		dbf	d2,loc_52F56
		lea	(FBZ_cloud_addr).w,a5
		moveq	#$A-1,d1

loc_52F62:
		jsr	(CreateNewSprite4).l
		bne.s	loc_52F7A
		move.w	a1,(a5)+
		move.l	#Obj_FBZCloud,(a1)	; Create cloud objects and place addresses in FFEEEA
		move.w	d1,$2E(a1)
		dbf	d1,loc_52F62

loc_52F7A:
		lea	Pal_FBZBGOutdoors(pc),a1	; Modify palette
		lea	(Normal_palette_line_4+$2).w,a5
		lea	(Target_palette_line_4+$2).w,a6
		move.w	#$EEE,(a5)+
		move.w	#$EEE,(a6)+
		move.l	(a1),(a5)+
		move.l	(a1)+,(a6)+
		move.l	(a1),(a5)+
		move.l	(a1)+,(a6)+
		move.l	(a1),(a5)+
		move.l	(a1)+,(a6)+
		move.l	(a1),(a5)+
		move.l	(a1)+,(a6)+
		rts
; End of function SetUp_FBZ2BossEvent

; ---------------------------------------------------------------------------
FBZ2_LayoutModRange:
		dc.w   $D80, $1300,  $A00,  $B80
; ---------------------------------------------------------------------------

FBZ2_BackgroundInit:
		jsr	(AllocateObject).l
		bne.s	loc_52FB6
		move.l	#Obj_FBZOutdoorBGMotion,(a1)

loc_52FB6:
		cmpi.w	#$2C40,(Camera_X_pos).w
		blo.s	loc_53002
		move.w	#$10,(Events_routine_bg).w		; If in boss event area, set BG event
		move.w	(a3),d0
		move.w	d0,$70(a3)			; Copy top BG line to bottom BG line (I guess so the scrolling doesn't garble the screen?)
		move.w	d0,$74(a3)
		move.w	d0,$78(a3)
		move.w	d0,$7C(a3)
		st	(Screen_shake_flag).w			; Start shaking
		move.w	#VRAM_Plane_A_Name_Table,d7
		jsr	FBZ2_CloudDeform(pc)	; Deform the cloud sprites
		jsr	Reset_TileOffsetPositionEff(pc)
		jsr	Refresh_PlaneFull(pc)
		jsr	PlainDeformation_Flipped(pc)	; Reverse deformation
		jsr	Get_BGActualEffectiveDiff(pc)
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp
		rts
; ---------------------------------------------------------------------------

loc_53002:
		jsr	FBZ_Deform(pc)			; Normal play
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	FBZ_InBGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

FBZ2_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	FBZ2_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

FBZ2_BackgroundEvent_Index:
		bra.w	FBZ2BGE_Init
; ---------------------------------------------------------------------------
		bra.w	FBZ2BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	FBZ2BGE_ChangeTopDown
; ---------------------------------------------------------------------------
		bra.w	FBZ2BGE_ChangeBottomUp
; ---------------------------------------------------------------------------
		bra.w	FBZ2BGE_BossEvent
; ---------------------------------------------------------------------------

FBZ2BGE_ChangeTopDown:
		jsr	FBZ2_CheckBGChange(pc)

loc_5303C:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		tst.w	(Events_bg+$04).w
		beq.s	loc_5304E
		move.w	#$200,d1
		moveq	#0,d2

loc_5304E:
		jsr	Draw_PlaneVertTopDown(pc)
		bpl.s	loc_530BA
		move.w	#4,(Events_routine_bg).w
		bra.s	loc_530BA
; ---------------------------------------------------------------------------

FBZ2BGE_ChangeBottomUp:
		jsr	FBZ2_CheckBGChange(pc)

loc_53060:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		tst.w	(Events_bg+$04).w
		beq.s	loc_53072
		move.w	#$200,d1
		moveq	#0,d2

loc_53072:
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.s	loc_530BA
		move.w	#4,(Events_routine_bg).w
		bra.s	loc_530BA
; ---------------------------------------------------------------------------

FBZ2BGE_Init:
		move.w	(a3),d0
		move.w	d0,$70(a3)
		move.w	d0,$74(a3)
		move.w	d0,$78(a3)
		move.w	d0,$7C(a3)			; Copy BG lines
		addq.w	#4,(Events_routine_bg).w	; Next BG Event

FBZ2BGE_Normal:
		tst.w	(Events_routine_fg).w
		beq.s	loc_530AC
		jsr	FBZ2_CloudDeform(pc)	; If boss event has started
		jsr	Reset_TileOffsetPositionEff(pc)
		move.w	#$10,(Events_routine_bg).w
		bra.s	loc_530F0
; ---------------------------------------------------------------------------

loc_530AC:
		cmpi.b	#6,(Player_1+routine).w
		blo.s	loc_530B6			; Don't change BG if dying
		rts
; ---------------------------------------------------------------------------

loc_530B6:
		jsr	FBZ2_CheckBGChange(pc)

loc_530BA:
		move.w	(Events_bg+$04).w,d1
		beq.s	loc_530C4
		move.w	#$200,d1

loc_530C4:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	FBZ_InBGDeformArray(pc),a4
		tst.w	(Events_bg+$04).w
		beq.s	loc_530E0
		lea	FBZ_OutBGDeformArray(pc),a4

loc_530E0:
		lea	(HScroll_table).w,a5
		jsr	ApplyDeformation(pc)
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

FBZ2BGE_BossEvent:
		jsr	FBZ2_CloudDeform(pc)

loc_530F0:
		move.w	#VRAM_Plane_A_Name_Table,d7
		jsr	DrawBGAsYouMove(pc)		; Draw BG on plane A
		jsr	PlainDeformation_Flipped(pc)
		jsr	Get_BGActualEffectiveDiff(pc)
		jsr	ShakeScreen_Setup(pc)
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp
		tst.w	(Events_bg+$06).w
		beq.s	locret_5318A
		clr.w	(Events_bg+$06).w		; If boss has been loaded
		move.w	(_unkEE9C).w,d0
		clr.w	(_unkEE9C).w		; Get final Y offset and clear it
		btst	#Status_InAir,(Player_1+status).w
		beq.s	loc_53134
		add.w	d0,(Player_1+y_pos).w	; If player is not on ground, adjust his Y position properly
		add.w	d0,(Player_2+y_pos).w

loc_53134:
		add.w	d0,(Camera_Y_pos).w
		add.w	d0,(Camera_Y_pos_copy).w
		add.w	d0,(Camera_min_Y_pos).w
		add.w	d0,(Camera_max_Y_pos).w	; Add offset to camera Ys
		move.w	(Camera_max_Y_pos).w,(Camera_target_max_Y_pos).w
		move.w	(_unkEE98).w,d0
		clr.w	(_unkEE98).w
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d0,(Player_2+x_pos).w	; Adjust X position of players
		sub.w	d0,(Camera_X_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w	; and of cameras
		movea.w	(Level_layout_main+$2C).w,a1	; $580 Y of FG
		lea	$5C(a1),a1				; $2D00 X of FG
		move.w	(Level_layout_header).w,d0
		subi.w	#$14,d0
		moveq	#4-1,d1

loc_5317C:
		moveq	#$14-1,d2

loc_5317E:
		clr.b	(a1)+				; Clear large area of FG, probably erasing the copied FG area from the layout mod
		dbf	d2,loc_5317E
		adda.w	d0,a1
		dbf	d1,loc_5317C

locret_5318A:
		rts

; =============== S U B R O U T I N E =======================================


FBZ2_CloudDeform:
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$300,d0
		add.w	(_unkEE9C).w,d0		; Add camera BG Y to Y event offset
		move.w	d0,(Camera_Y_pos_BG_copy).w		; Make that the effective Y
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$2600,d0
		sub.w	(_unkEE98).w,d0
		move.w	d0,(Camera_X_pos_BG_copy).w		; Do the same with the X values
		lea	(HScroll_table).w,a1
		lea	FBZ2_CloudDeformIndex(pc),a5
		move.w	(Camera_X_pos_BG_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		asr.l	#2,d1
		move.l	(HScroll_table+$1FC).w,d2
		asr.l	#3,d2
		addi.l	#$8000,(HScroll_table+$1FC).w	; Perform cloud movement
		moveq	#$A-1,d3

loc_531D2:
		move.w	(a5)+,d4
		add.l	d2,d0
		swap	d0
		move.w	d0,(a1,d4.w)		; Set up cloud speeds
		swap	d0
		add.l	d1,d0
		dbf	d3,loc_531D2
		lea	(HScroll_table).w,a1
		lea	(FBZ_cloud_addr).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	(Screen_shake_offset).w,d1
		sub.w	d1,d0
		asr.w	#1,d0
		add.w	d1,d0
		neg.w	d0
		add.w	(Events_bg+$08).w,d0	; Get effective Y, add BG motion offset to it
		moveq	#$A-1,d1

loc_53202:
		move.w	(a5)+,d2
		beq.s	loc_5322E
		movea.w	d2,a6			; Load cloud address
		move.w	$30(a6),d3		; Get Y position
		add.w	d0,d3			; Add offset
		andi.w	#$FF,d3
		addi.w	#$74,d3
		move.w	d3,$14(a6)		; Load to actual Y
		move.w	(a1)+,d3
		neg.w	d3
		add.w	$2E(a6),d3
		andi.w	#$1FF,d3
		addi.w	#$54,d3
		move.w	d3,$10(a6)		; Do the same to the X

loc_5322E:
		dbf	d1,loc_53202
		rts
; End of function FBZ2_CloudDeform


; =============== S U B R O U T I N E =======================================


FBZ2_CheckBGChange:
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		move.w	(Events_bg+$00).w,d2		; You know how this goes by now
		jmp	FBZ2_CheckBGChange_Index(pc,d2.w)
; End of function FBZ1_CheckBGChange

; ---------------------------------------------------------------------------

FBZ2_CheckBGChange_Index:
		bra.w	FBZ_Deform
; ---------------------------------------------------------------------------
		tst.w	(Events_bg+$04).w
		bne.s	loc_53258
		cmpi.w	#$A40,d1
		blo.w	FBZ_Deform
		bra.s	loc_5326A
; ---------------------------------------------------------------------------

loc_53258:
		cmpi.w	#$A40,d1
		bhi.w	FBZ_Deform
		clr.w	(Events_bg+$04).w
		moveq	#8,d0
		moveq	#0,d6
		bra.s	loc_5327A
; ---------------------------------------------------------------------------

loc_5326A:
		st	(Events_bg+$04).w
		moveq	#$C,d0
		move.w	#$F0,d6
		lea	Pal_FBZBGOutdoors(pc),a1
		bra.s	loc_5327E
; ---------------------------------------------------------------------------

loc_5327A:
		lea	Pal_FBZBGIndoors(pc),a1

loc_5327E:
		lea	(Normal_palette_line_4+$4).w,a5
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.w	d0,(Events_routine_bg).w
		jsr	FBZ_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		add.w	d6,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,sp
		cmpi.w	#8,(Events_routine_bg).w
		beq.w	loc_5303C
		bra.w	loc_53060
; ---------------------------------------------------------------------------

Obj_FBZEndBossEventControl:
		move.l	#loc_532E0,(a0)
		move.b	#$11,height_pixels(a0)
		bset	#7,status(a0)
		move.w	#$32B8,(Camera_max_X_pos).w		; Set $32B8 as the X end
		move.w	#$3C,d0
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_532DC
		addq.w	#4,d0

loc_532DC:
		move.w	d0,(Camera_min_Y_pos).w		; Set level Y start depending on whether Tails is playing or not. I guess this is because Tails' center point is slightly lower than Sonic's

loc_532E0:
		cmpi.w	#$2E80,(Player_1+x_pos).w
		blo.w	loc_533A4
		move.l	#loc_532F0,(a0)			; If Sonic has passed $2E80 X, start moving the BG

loc_532F0:
		st	(Background_collision_flag).w				; Set BG collision on
		addi.l	#$A000,(_unkEE9C).w
		addi.l	#$7800,(_unkEE98).w	; Move the extra BG camera by a set amount
		cmpi.w	#$5D0,(_unkEE9C).w
		blo.s	loc_5333A
		move.w	#$5D0,(_unkEE9C).w		; When BG has reached end point
		move.w	#$45C,(_unkEE98).w
		clr.b	(Background_collision_flag).w			; Stop BG collision
		move.l	#loc_53322,(a0)

loc_53322:
		move.w	(Camera_min_Y_pos).w,d0
		cmp.w	(Camera_Y_pos).w,d0
		bne.s	loc_5333A
		move.w	d0,(Camera_max_Y_pos).w		; Lock screen when camera has scrolled as high as possible
		move.w	d0,(Camera_target_max_Y_pos).w
		move.l	#loc_5333A,(a0)

loc_5333A:
		cmpi.w	#$280,(Player_1+y_pos).w
		bhs.s	loc_53348
		move.w	(Camera_X_pos).w,(Camera_min_X_pos).w	; If player is above $280 Y then lock screen X as you move

loc_53348:
		move.w	(Camera_min_Y_pos).w,d0
		cmp.w	(Camera_max_Y_pos).w,d0
		bne.s	loc_533A4
		move.w	(Camera_max_X_pos).w,d0
		cmp.w	(Camera_min_X_pos).w,d0
		bne.s	loc_533A4
		move.w	#$F0,(Draw_delayed_position).w		; When the screen is completely locked, start proper Screen Events
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_fg).w		; Next screen event
		move.l	#loc_53372,(a0)

loc_53372:
		cmpi.w	#$C,(Events_routine_fg).w
		bne.s	loc_533A4
		jsr	(AllocateObject).l
		bne.s	loc_53388				; When screen event has finished, load the boss
		move.l	#Obj_FBZEndBoss,(a1)

loc_53388:
		clr.w	(Screen_shake_flag).w			; Stop shaking
		st	(Events_bg+$06).w				; Set variable when boss has loaded
		move.w	#$31C0,d0
		move.w	#$31C0,d4
		move.w	#$690,d1
		move.l	#loc_533A4,(a0)
		bra.s	loc_533B8
; ---------------------------------------------------------------------------

loc_533A4:
		move.w	x_pos(a0),d4
		move.w	#$31C0,d0
		add.w	(_unkEE98).w,d0
		move.w	#$690,d1
		sub.w	(_unkEE9C).w,d1

loc_533B8:
		move.w	d0,x_pos(a0)
		move.w	d1,y_pos(a0)
		move.w	#$4C0,d1
		moveq	#$11,d2
		moveq	#$11,d3
		jmp	(SolidObjectTop).l
; ---------------------------------------------------------------------------

Obj_FBZBossPillar:
		move.l	#Obj_FBZBossPillarMain,(a0)
		move.b	#$44,render_flags(a0)		; Set up boss pillar object
		move.b	#$FF,height_pixels(a0)
		move.b	#$20,width_pixels(a0)
		move.w	#$300,priority(a0)
		move.w	#make_art_tile(ArtTile_FBZBossPillar,2,1),art_tile(a0)
		move.l	#Map_FBZ2Preboss,mappings(a0)
		move.w	#2,mainspr_childsprites(a0)	; 2 sprites

Obj_FBZBossPillarMain:
		move.w	#$2DE0,d4
		add.w	(_unkEE98).w,d4
		move.w	d4,x_pos(a0)			; Move pillar to proper X area
		move.w	d4,d0
		move.w	d4,d1
		subi.w	#$200,d0
		tst.w	$30(a0)
		beq.s	loc_5341E
		addi.w	#$28,d1

loc_5341E:
		move.w	#$580,d5
		sub.w	(_unkEE9C).w,d5	; Get proper Y offset
		move.w	d5,d2
		move.w	d5,d3
		addi.w	#$80,d2
		addi.w	#$100,d3
		clr.w	$30(a0)
		lea	(Player_1).w,a1
		bsr.s	FBZBossPillar_CheckPlayerPos
		lea	(Player_2).w,a1
		bsr.s	FBZBossPillar_CheckPlayerPos
		tst.w	$30(a0)
		beq.s	loc_53456
		cmpi.w	#$40,$2E(a0)	; If player is in range, increase pillar offset
		bhs.s	loc_5346A
		addq.w	#8,$2E(a0)
		bra.s	loc_5346A
; ---------------------------------------------------------------------------

loc_53456:
		tst.w	$2E(a0)
		beq.s	loc_5346A
		subq.w	#8,$2E(a0)		; If player is not in range, decrease pillar offset
		bne.s	loc_5346A
		moveq	#signextendB(sfx_SpikeBalls),d0		; Play sound only when pillar hits ground
		jsr	(Play_SFX).l

loc_5346A:
		sub.w	$2E(a0),d5
		move.w	d5,y_pos(a0)		; Subtract Y from offset and place it in sprite Y
		lea	sub2_x_pos(a0),a1
		addi.w	#$80,d5
		moveq	#1,d0

loc_5347C:
		move.w	d4,(a1)
		move.w	d5,sub2_y_pos-sub2_x_pos(a1)
		subi.w	#$100,d5		; Set the sprite positions of each pillar sprite
		addq.w	#6,a1
		dbf	d0,loc_5347C
		moveq	#$2B,d1
		move.w	#$100,d2
		move.w	#$100,d3
		jsr	(SolidObjectFull).l	; Make it solid
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


FBZBossPillar_CheckPlayerPos:
		move.w	x_pos(a1),d6
		cmp.w	d0,d6
		blt.s	.return
		cmp.w	d1,d6
		bhs.s	.return
		move.w	y_pos(a1),d6
		cmp.w	d2,d6
		blo.s	.return
		cmp.w	d3,d6
		bhs.s	.return
		tst.b	$2E(a1)
		bmi.s	.return
		st	$30(a0)

.return:
		rts
; End of function FBZBossPillar_CheckPlayerPos

; ---------------------------------------------------------------------------

Obj_FBZCloud:
		move.l	#Draw_Sprite,(a0)
		move.b	#$40,render_flags(a0)		; Multisprite routine
		move.b	#$C,height_pixels(a0)
		move.b	#$2C,width_pixels(a0)
		move.w	#$380,priority(a0)
		move.w	#make_art_tile(ArtTile_FBZCloud,3,0),art_tile(a0)
		move.l	#Map_FBZ2Preboss,mappings(a0)
		move.w	$2E(a0),d0
		add.w	d0,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		lea	FBZCloud_PositionFrameData(pc),a1
		adda.w	d0,a1
		move.w	(a1)+,$2E(a0)
		move.w	(a1)+,$30(a0)
		move.w	(a1),d0
		move.b	d0,mapping_frame(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Map_FBZ2Preboss:
		include "Levels/FBZ/Misc Object Data/Map - Act 2 Preboss.asm"
FBZ2_CloudDeformIndex:
		dc.w      4
		dc.w     $E
		dc.w      8
		dc.w    $10
		dc.w      2
		dc.w     $C
		dc.w      6
		dc.w    $12
		dc.w     $A
		dc.w      0
FBZCloud_PositionFrameData:
		dc.w   $1E0,   $EC,     1
		dc.w   $144,   $C8,     2
		dc.w    $60,   $B4,     3
		dc.w    $C4,   $A0,     2
		dc.w   $140,   $84,     1
		dc.w   $1A0,   $6C,     3
		dc.w    $F0,   $54,     1
		dc.w   $160,   $3C,     3
		dc.w    $7C,   $28,     2
		dc.w    $20,    $C,     1
; ---------------------------------------------------------------------------

ICZ1_ScreenInit:
		tst.b	(Last_star_post_hit).w
		bne.s	loc_53648			; If not restarting from a lamppost
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_53648			; And we're Knuckles
		jsr	(AllocateObject).l
		bne.s	loc_53648
		move.l	#Obj_ICZTeleporter,(a1)	; Make teleporter object, etc.
		move.w	#$3640,(Player_1+x_pos).w
		move.w	#$660,(Player_1+y_pos).w
		move.w	#$35A0,d0
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d0,(Camera_X_pos).w
		move.w	#$5FB,d0
		move.w	d0,(Camera_Y_pos_copy).w
		move.w	d0,(Camera_Y_pos).w

loc_53648:
		move.w	#$7FF,(Screen_Y_wrap_value).w
		move.w	#$7F0,(Camera_Y_pos_mask).w
		move.w	#$3C,(Layout_row_index_mask).w		; We're in a looping level!
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

ICZ1_ScreenEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	ICZ1_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

ICZ1_ScreenEvent_Index:
		bra.w	ICZ1SE_Init
; ---------------------------------------------------------------------------
		bra.w	ICZ1SE_WaitQuake
; ---------------------------------------------------------------------------
		bra.w	ICZ1SE_Normal
; ---------------------------------------------------------------------------
		bra.w	ICZ1SE_Normal
; ---------------------------------------------------------------------------
		bra.w	ICZ1SE_Normal
; ---------------------------------------------------------------------------
		bra.w	ICZ1SE_Normal
; ---------------------------------------------------------------------------

ICZ1SE_Init:
		tst.w	(Screen_shake_flag).w
		beq.s	loc_53696
		tst.b	(Ctrl_1_locked).w	; If shaking due to hitting the wall, remove player control temporarily
		bne.s	loc_53696
		st	(Ctrl_1_locked).w
		clr.w	(Ctrl_1_logical).w

loc_53696:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_X_pos_copy).w
		bra.s	ICZ1SE_Normal
; ---------------------------------------------------------------------------

ICZ1SE_WaitQuake:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w

ICZ1SE_Normal:
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

ICZ1_BackgroundInit:
		lea	(a3),a1
		moveq	#8-1,d0

loc_536B0:
		move.w	(a1),$20(a1)	; Upper $400 of BG is mirrored in lower $400
		addq.w	#4,a1
		dbf	d0,loc_536B0
		move.w	(Camera_Y_pos_copy).w,(Events_fg_0).w
		move.w	(Camera_Y_pos_copy).w,(Events_fg_1).w		; Camera BG Y is noted in two variables
		cmpi.w	#$3940,(Camera_X_pos).w
		bhs.s	loc_53704
		cmpi.w	#$3580,(Camera_X_pos).w
		blo.s	loc_536DC
		addi.w	#$2800,(Events_fg_1).w		; If past $3580 X, adjust BG camera

loc_536DC:
		clr.w	(Events_bg+$16).w				; No VScrolling when outside
		jsr	(ICZ1_SetIntroPal).l
		jsr	ICZ1_IntroDeform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		move.w	#$1880,d1
		jsr	Refresh_PlaneFull(pc)
		lea	(ICZ1_IntroBGDeformArray).l,a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

loc_53704:
		move.w	#$10,(Events_routine_bg).w		; If past $3940 X, we're indoors already
		st	(Events_bg+$16).w				; Go indoors
		jsr	(ICZ1_SetIndoorPal).l
		jsr	ICZ1_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		jsr	Refresh_PlaneFull(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

ICZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	ICZ1_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

ICZ1_BackgroundEvent_Index:
		bra.w	ICZ1BGE_Intro
; ---------------------------------------------------------------------------
		bra.w	ICZ1BGE_SnowFall
; ---------------------------------------------------------------------------
		bra.w	ICZ1BGE_Refresh
; ---------------------------------------------------------------------------
		bra.w	ICZ1BGE_Refresh2
; ---------------------------------------------------------------------------
		bra.w	ICZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	ICZ1BGE_Transition
; ---------------------------------------------------------------------------

ICZ1BGE_Intro:
		tst.w	(Events_fg_5).w
		beq.s	loc_53780
		clr.w	(Events_fg_5).w		; If flag is set
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_5375C
		addq.w	#4,(Events_routine_bg).w	; Just go to next BG event if playing as Knuckles
		bra.s	loc_53780
; ---------------------------------------------------------------------------

loc_5375C:
		jsr	(AllocateObject).l
		bne.s	loc_5376A
		move.l	#Obj_ICZ1BigSnowPile,(a1)

loc_5376A:
		clr.l	(Events_bg+$00).w
		clr.l	(Events_bg+$04).w		; Clear offsets
		jsr	ICZ1_BigSnowFall(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_537BA
; ---------------------------------------------------------------------------

loc_53780:
		jsr	ICZ1_IntroDeform(pc)		; Deformation is pretty standard during the intro portion
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	#$1880,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	(ICZ1_IntroBGDeformArray).l,a4
		lea	(HScroll_table).w,a5
		jsr	ApplyDeformation(pc)
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

ICZ1BGE_SnowFall:
		tst.w	(Events_fg_5).w
		bne.s	loc_537C6
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_53780	; If Knuckles, skip
		jsr	ICZ1_BigSnowFall(pc)

loc_537BA:
		jsr	DrawBGAsYouMove(pc)
		jsr	PlainDeformation(pc)
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

loc_537C6:
		clr.w	(Events_fg_5).w
		move.w	#$2E0,(Draw_delayed_position).w		; Set BG refresh position
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w

ICZ1BGE_Refresh:
		move.w	#$1880,d1
		move.w	#$200,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.w	PlainDeformation
		jsr	ICZ1_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_5380E
; ---------------------------------------------------------------------------

ICZ1BGE_Refresh2:
		jsr	ICZ1_Deform(pc)

loc_5380E:
		move.w	(Camera_X_pos_BG_copy).w,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_5387E
		st	(Events_bg+$16).w		; Go indoors
		jsr	(ICZ1_SetIndoorPal).l	; Set indoor palette
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_5387E
; ---------------------------------------------------------------------------

ICZ1BGE_Normal:
		cmpi.w	#$6900,(Camera_X_pos).w
		blo.s	loc_5387A
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(ICZ2_128x128_Secondary_Kos).l,a1
		lea	(RAM_start+$A00).l,a2
		jsr	(Queue_Kos).l
		lea	(ICZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$408).w,a2
		jsr	(Queue_Kos).l
		lea	(ICZ2_8x8_Secondary_KosM).l,a1
		move.w	#tiles_to_bytes($122),d2
		jsr	(Queue_Kos_Module).l
		moveq	#PLCID_20,d0
		jsr	(Load_PLC).l
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(Events_routine_bg).w

loc_5387A:
		jsr	ICZ1_Deform(pc)

loc_5387E:
		jsr	DrawBGAsYouMove(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

ICZ1BGE_Transition:
		tst.w	(Kos_decomp_queue_count).w
		bne.w	loc_53938
		move.w	#$501,(Current_zone_and_act).w
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(Respawn_table_keep).w
		jsr	Clear_Switches(pc)
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		jsr	(CheckLevelForWater).l
		move.w	#$8014,(VDP_control_port).l		; Turn on HInt since ICZ2 has water
		moveq	#PalID_ICZ2,d0
		jsr	(LoadPalette_Immediate).l
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$6880,d0
		move.w	#-$100,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d1,(Player_1+y_pos).w
		sub.w	d0,(Player_2+x_pos).w
		sub.w	d1,(Player_2+y_pos).w
		jsr	Offset_ObjectsDuringTransition(pc)
		jsr	Offset_SomeObjectsDuringTransition(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d1,(Camera_Y_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d1,(Camera_Y_pos_copy).w
		move.l	#$7000,d0
		move.l	d0,(Camera_min_X_pos).w
		move.l	#$B20,d0
		move.l	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		move.w	#$FFF,(Screen_Y_wrap_value).w
		move.w	#$FF0,(Camera_Y_pos_mask).w
		move.w	#$7C,(Layout_row_index_mask).w
		jsr	Reset_TileOffsetPositionActual(pc)
		clr.w	(Events_routine_bg).w

loc_53938:
		jsr	ICZ1_Deform(pc)
		jmp	PlainDeformation(pc)

; =============== S U B R O U T I N E =======================================


ICZ1_IntroDeform:
		lea	(Events_fg_0).w,a1
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	#$400,d2
		move.w	#$800,d3
		jsr	Adjust_BGDuringLoop(pc)
		move.w	(Events_fg_1).w,d0
		asr.w	#7,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		move.w	(Screen_shake_offset).w,d3
		sub.w	d3,d0
		swap	d0
		clr.w	d0
		asr.l	#5,d0
		move.l	d0,d1
		swap	d0
		add.w	d3,d0
		swap	d0
		lea	(HScroll_table).w,a1
		moveq	#0,d3
		moveq	#5-1,d2			; First five deformation speeds are constant
		bsr.s	sub_53996
		add.l	d1,d0
		move.l	d1,d2
		asr.l	#1,d2
		add.l	d2,d1
		move.l	$12(a1),d3
		addi.l	#$800,$12(a1)
		moveq	#9-1,d2			; Last 9 move slowly automatically
; End of function ICZ1_IntroDeform


; =============== S U B R O U T I N E =======================================


sub_53996:
		swap	d0
		move.w	d0,(a1)+
		swap	d0
		add.l	d1,d0
		add.l	d3,d1
		addi.l	#$800,d3
		dbf	d2,sub_53996
		rts
; End of function sub_53996


; =============== S U B R O U T I N E =======================================


ICZ1_BigSnowFall:
		cmpi.w	#-$12E,(Events_bg+$00).w
		ble.s	loc_539DE
		st	(Screen_shake_flag).w
		addi.l	#$2400,(Events_bg+$04).w
		move.l	(Events_bg+$04).w,d0
		sub.l	d0,(Events_bg+$00).w
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	loc_539F0
		moveq	#signextendB(sfx_Rumble2),d0
		jsr	(Play_SFX).l
		bra.s	loc_539F0
; ---------------------------------------------------------------------------

loc_539DE:
		tst.w	(Screen_shake_flag).w
		bpl.s	loc_539F0
		move.w	#4,(Screen_shake_flag).w
		move.w	#-$12E,(Events_bg+$00).w

loc_539F0:
		move.w	(Camera_Y_pos_copy).w,d0		; Use portion of background to show snow object
		subi.w	#$460,d0
		add.w	(Events_bg+$00).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$1D40,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; End of function ICZ1_BigSnowFall


; =============== S U B R O U T I N E =======================================


ICZ1_Deform:
		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w	; BG moves up/down at half speed
		asr.w	#1,d0
		move.w	d0,(Events_bg+$12).w	; Dynamic BG moves up/down at quarter speed
		move.w	(Camera_X_pos_copy).w,d0
		asr.w	#1,d0
		subi.w	#$1D80,d0
		move.w	d0,(Camera_X_pos_BG_copy).w	; BG moves left/right at half speed
		asr.w	#1,d0
		move.w	d0,(Events_bg+$10).w	; Dynamic BG moves left/right at quarter speed
		rts
; End of function ICZ1_Deform

; ---------------------------------------------------------------------------

Obj_ICZ1BigSnowPile:
		move.l	#loc_53A4C,(a0)
		move.b	#$80,height_pixels(a0)
		move.w	#$3880,x_pos(a0)
		bset	#7,status(a0)

loc_53A4C:
		cmpi.w	#8,(Events_routine_bg).w
		blo.s	loc_53A5A
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_53A5A:
		move.w	#$5E0,d0
		sub.w	(Events_bg+$00).w,d0		; Shift Y position based on offset
		move.w	d0,y_pos(a0)
		move.w	#$94,d1
		lea	ICZ1_SnowpileSlopeDef(pc),a2
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTopSloped2).l
		cmpi.w	#$70E,y_pos(a0)
		bne.s	locret_53AD2
		tst.b	(Ctrl_1_locked).w
		beq.s	locret_53AD2
		lea	(Player_1).w,a1
		btst	#Status_InAir,status(a1)		; Wait till player is standing on ground
		bne.s	locret_53AD2
		move.b	(Ctrl_1_pressed).w,d0
		andi.w	#button_A_mask|button_B_mask|button_C_mask,d0	; Wait until a jump button is pressed
		beq.s	locret_53AD2
		clr.b	(Ctrl_1_locked).w	; When done, unlock player
		move.w	#-$600,y_vel(a1)
		bset	#Status_InAir,status(a1)
		move.b	#1,jumping(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		move.b	#2,anim(a1)
		bset	#Status_Roll,status(a1)
		moveq	#signextendB(sfx_Jump),d0
		jsr	(Play_SFX).l	; Perform jumping on player object manually

locret_53AD2:
		rts
; ---------------------------------------------------------------------------

Obj_ICZTeleporter:
		jsr	(AllocateObjectAfterCurrent).l
		beq.s	loc_53ADE
		rts

loc_53ADE:
		move.l	#Obj_ICZTeleporterMain,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$10,height_pixels(a0)
		move.b	#$20,width_pixels(a0)
		move.w	#$80,priority(a0)
		move.w	#make_art_tile(ArtTile_ICZIntroSprites,1,0),art_tile(a0)
		move.l	#Map_ICZPlatforms,mappings(a0)		; Attributes for teleporter platform in ICZ
		move.w	#$3640,x_pos(a0)
		move.w	#$670,y_pos(a0)				; Set position
		move.b	#$1A,mapping_frame(a0)
		move.w	(Player_1+y_pos).w,$3E(a0)		; Knuckles Y position into $3E
		move.w	a1,$3C(a0)				; Child beam object into $3C
		move.l	#Obj_TeleporterBeamExpand,(a1)
		move.b	#$44,render_flags(a1)
		st	routine(a1)
		move.b	#$80,height_pixels(a1)
		move.b	#$18,width_pixels(a1)
		move.w	#$80,priority(a1)
		move.w	#make_art_tile(ArtTile_ICZTeleport-$12,1,0),art_tile(a1)
		move.l	#Map_SSZHPZTeleporter,mappings(a1)	; Set attributes of beam object
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.w	#2,mainspr_childsprites(a1)
		move.w	y_pos(a0),$44(a1)			; Lots of init stuff for the beam to work properly
		subi.w	#$80,$44(a1)
		move.b	#$18,$46(a1)
		move.w	a0,parent2(a1)				; Parent in $48
		lea	(Target_palette_line_2+$10).w,a1
		move.w	#$EA2,(a1)
		move.w	#$E80,4(a1)				; Slight change to palette
		lea	(Player_1).w,a1
		move.b	#1,object_control(a1)
		move.b	#2,anim(a1)
		bset	#Status_Roll,status(a1)			; Knuckles is under object control, spinning animation, and jumping

Obj_ICZTeleporterMain:
		lea	(Player_1).w,a1
		move.l	#$20000,d0
		move.l	#$800,d1
		jsr	(Gradual_SwingOffset).l		; Do gradual swing on Knuckles until he starts to reverse direction
		add.w	$3E(a0),d0
		move.w	d0,y_pos(a1)
		tst.l	$2E(a0)
		bmi.s	loc_53BFE
		clr.b	object_control(a1)			; Return player control to Knuckles
		clr.b	anim(a1)
		move.l	#Obj_ICZTeleporterCheckDel,(a0)

Obj_ICZTeleporterCheckDel:
		cmpi.w	#$3780,(Camera_X_pos_copy).w
		blo.s	loc_53BEE
		lea	(Normal_palette_line_2+$10).w,a1		; When player moves far enough to the right, restore palette and delete object
		move.w	#$2C,(a1)
		clr.w	4(a1)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_53BEE:
		moveq	#$23,d1			; Act as a solid object otherwise
		moveq	#$10,d2
		moveq	#1,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l

loc_53BFE:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
		dc.b  $61, $61
		dc.b  $61, $61
		dc.b  $60, $60
		dc.b  $60, $60
		dc.b  $5F, $5F
		dc.b  $5E, $5E
		dc.b  $5D, $5C
		dc.b  $5C, $5B
		dc.b  $5A, $59
		dc.b  $59, $58
		dc.b  $57, $57
ICZ1_SnowpileSlopeDef:
		dc.b  $56, $56
		dc.b  $55, $55
		dc.b  $54, $54
		dc.b  $53, $53
		dc.b  $52, $52
		dc.b  $51, $51
		dc.b  $51, $51
		dc.b  $50, $50
		dc.b  $50, $50
		dc.b  $4F, $4F
		dc.b  $4E, $4E
		dc.b  $4D, $4C
		dc.b  $4C, $4B
		dc.b  $4A, $49
		dc.b  $49, $48
		dc.b  $47, $47
		dc.b  $46, $46
		dc.b  $45, $45
		dc.b  $44, $44
		dc.b  $43, $43
		dc.b  $42, $42
		dc.b  $41, $41
		dc.b  $41, $41
		dc.b  $40, $40
		dc.b  $40, $40
		dc.b  $3F, $3F
		dc.b  $3E, $3E
		dc.b  $3D, $3C
		dc.b  $3C, $3B
		dc.b  $3A, $39
		dc.b  $39, $38
		dc.b  $37, $37
		dc.b  $36, $36
		dc.b  $35, $35
		dc.b  $34, $34
		dc.b  $33, $33
		dc.b  $32, $32
		dc.b  $31, $31
		dc.b  $31, $31
		dc.b  $30, $30
		dc.b  $30, $30
		dc.b  $2F, $2F
		dc.b  $2E, $2E
		dc.b  $2D, $2C
		dc.b  $2C, $2B
		dc.b  $2A, $29
		dc.b  $29, $28
		dc.b  $27, $27
		dc.b  $26, $26
		dc.b  $25, $25
		dc.b  $24, $24
		dc.b  $23, $23
		dc.b  $22, $22
		dc.b  $21, $21
		dc.b  $21, $21
		dc.b  $20, $20
		dc.b  $20, $20
		dc.b  $1F, $1F
		dc.b  $1E, $1E
		dc.b  $1D, $1C
		dc.b  $1C, $1B
		dc.b  $1A, $19
		dc.b  $19, $18
		dc.b  $17, $17
		dc.b  $16, $16
		dc.b  $15, $15
		dc.b  $14, $14
		dc.b  $13, $13
		dc.b  $12, $12
		dc.b  $11, $11
		dc.b  $11, $11
		dc.b  $10, $10
		dc.b  $10, $10
		dc.b   $F,  $F
		dc.b   $E,  $E
		dc.b   $D,  $C
		dc.b   $C,  $B
		dc.b   $A,   9
		dc.b    9,   8
		dc.b    7,   7
		dc.b    6,   6
		dc.b    5,   5
		dc.b    4,   4
		dc.b    3,   3
		dc.b    2,   2
; ---------------------------------------------------------------------------

ICZ2_ScreenInit:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

ICZ2_ScreenEvent:
		jmp	DrawTilesAsYouMove(pc)		; About as straightforward as you can get really
; ---------------------------------------------------------------------------

ICZ2_BackgroundInit:
		move.w	#4,(Events_routine_bg).w
		cmpi.w	#$3600,(Camera_X_pos).w	; Check ranges for either indoor/outdoor BGs
		bhs.s	loc_53CF6
		cmpi.w	#$720,(Camera_Y_pos).w
		bhs.s	loc_53D2C
		cmpi.w	#$1000,(Camera_X_pos).w
		bhs.s	loc_53CF6
		cmpi.w	#$580,(Camera_Y_pos).w
		bhs.s	loc_53D2C

loc_53CF6:
		clr.w	(Events_bg+$16).w			; Outdoors
		cmpi.w	#$720,(Camera_X_pos).w
		bhs.s	loc_53D0A
		jsr	(ICZ2_SetICZ1Pal).l
		bra.s	loc_53D10
; ---------------------------------------------------------------------------

loc_53D0A:
		jsr	(ICZ2_SetOutdoorsPal).l

loc_53D10:
		jsr	(ICZ2_OutDeform).l
		moveq	#0,d0
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	(ICZ2_OutBGDeformArray).l,a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

loc_53D2C:
		st	(Events_bg+$16).w			; Indoors
		jsr	(ICZ2_SetIndoorsPal).l
		jsr	(ICZ2_InDeform).l
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	(ICZ2_InBGDeformArray).l,a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

ICZ2_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	ICZ2_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

ICZ2_BackgroundEvent_Index:
		bra.w	ICZ2BGE_FromICZ1
; ---------------------------------------------------------------------------
		bra.w	ICZ2BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	ICZ2BGE_Refresh
; ---------------------------------------------------------------------------

ICZ2BGE_FromICZ1:
		addq.w	#4,(Events_routine_bg).w		; This only applies when coming from ICZ 1
		cmpi.w	#$580,(Camera_Y_pos).w
		bhs.s	loc_53D96
		bra.w	loc_53DFC
; ---------------------------------------------------------------------------

ICZ2BGE_Normal:
		tst.w	(Events_bg+$16).w
		bne.s	loc_53DD8
		move.w	(Camera_X_pos).w,d0		; If outdoors
		cmpi.w	#$1000,d0
		blo.s	loc_53DC4
		cmpi.w	#$3600,d0
		bhs.s	loc_53DC4
		cmpi.w	#$720,(Camera_Y_pos).w
		blo.s	loc_53DC4

loc_53D96:
		st	(Events_bg+$16).w				; Set to go indoors
		jsr	(ICZ2_SetIndoorsPal).l
		jsr	(ICZ2_InDeform).l
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.w	loc_53E84
; ---------------------------------------------------------------------------

loc_53DC4:
		jsr	(ICZ2_OutDeform).l				; No trigger, run normal deformation

loc_53DCA:
		lea	(ICZ2_OutBGDeformArray).l,a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

loc_53DD8:
		move.w	(Camera_X_pos).w,d0		; If indoors
		cmpi.w	#$1900,d0
		blo.s	loc_53DE8
		cmpi.w	#$1B80,d0
		blo.s	loc_53E38

loc_53DE8:
		cmpi.w	#$1000,d0
		blo.s	loc_53E38
		cmpi.w	#$3600,d0
		bhs.s	loc_53E38
		cmpi.w	#$720,(Camera_Y_pos).w
		bhs.s	loc_53E38

loc_53DFC:
		clr.w	(Events_bg+$16).w
		cmpi.w	#$720,(Camera_X_pos).w
		bhs.s	loc_53E10
		jsr	(ICZ2_SetICZ1Pal).l
		bra.s	loc_53E16
; ---------------------------------------------------------------------------

loc_53E10:
		jsr	(ICZ2_SetOutdoorsPal).l

loc_53E16:
		jsr	(ICZ2_OutDeform).l
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_53E68
; ---------------------------------------------------------------------------

loc_53E38:
		jsr	(ICZ2_InDeform).l

loc_53E3E:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	(ICZ2_InBGDeformArray).l,a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

ICZ2BGE_Refresh:
		tst.w	(Events_bg+$16).w
		bne.s	loc_53E7E
		jsr	(ICZ2_OutDeform).l

loc_53E68:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.w	loc_53DCA
		subq.w	#4,(Events_routine_bg).w
		bra.w	loc_53DCA
; ---------------------------------------------------------------------------

loc_53E7E:
		jsr	(ICZ2_InDeform).l

loc_53E84:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_53E3E
		subq.w	#4,(Events_routine_bg).w
		bra.s	loc_53E3E
; ---------------------------------------------------------------------------

LBZ1_ScreenInit:
		move.w	4(a3),d0
		subi.w	#$76,d0
		move.w	d0,$70(a3)
		move.w	d0,$74(a3)
		move.w	d0,$78(a3)
		move.w	d0,$7C(a3)
		movea.w	$48(a3),a1
		movea.w	$4C(a3),a5
		move.b	$79(a1),$79(a5)
		move.b	#$DB,$79(a1)
		jsr	LBZ1_RotateChunks(pc)
		lea	(HScroll_table+$148).w,a1
		moveq	#$E-1,d0

loc_53ECC:
		clr.l	(a1)+		; Clear VScroll
		dbf	d0,loc_53ECC
		jsr	LBZ1_EventVScroll(pc)
		lea	(HScroll_table+$100).w,a1
		moveq	#$C-1,d0

loc_53EDC:
		move.w	(a1)+,d1
		and.w	(Camera_Y_pos_mask).w,d1
		move.w	d1,(a1)+	; Set up tile offsets for VScroll array
		dbf	d0,loc_53EDC
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_53F06
		cmpi.w	#$3B60,(Camera_X_pos).w	; Skip this if Knuckles
		blo.s	loc_53F0A
		jsr	(AllocateObject).l
		bne.s	loc_53F06
		move.l	#Obj_LBZ1InvisibleBarrier,(a1)

loc_53F06:
		jsr	LBZ1_ModEndingLayout(pc)

loc_53F0A:
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		moveq	#0,d2
		jsr	(LBZ1_CheckLayoutMod).l
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

LBZ1_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		jsr	LBZ1_KnuxLevelSizeAdjust(pc)
		cmpi.w	#$55,(Events_fg_4).w
		bne.s	loc_53F6A
		clr.w	(Events_fg_4).w
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_53F50
		movea.w	8(a3),a1
		move.b	#$DA,$7D(a1)		; Changes the chunk where the boss appears
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

loc_53F50:
		movea.w	$4C(a3),a1
		move.b	$78(a1),d0
		movea.w	$50(a3),a1
		lea	$78(a1),a1
		move.b	d0,(a1)+		; Changes all the chunks where the boss appears in Knuckles' stage
		move.b	d0,(a1)+
		move.b	d0,(a1)+
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

loc_53F6A:
		move.w	(Player_1+x_pos).w,d0	; Normal level operation
		move.w	(Player_1+y_pos).w,d1
		move.w	(Events_bg+$00).w,d2
		bne.s	loc_53F86
		jsr	(LBZ1_CheckLayoutMod).l
		tst.w	d3
		bmi.s	loc_53FE2
		jmp	Refresh_PlaneScreenDirect(pc)	; Refresh screen when a layout mod is made
; ---------------------------------------------------------------------------

loc_53F86:
		lea	(LBZ1_LayoutModExitRange-4).l,a1		; If already in a layout
		adda.w	d2,a1
		cmp.w	(a1)+,d0
		blo.s	loc_53F98
		cmp.w	(a1)+,d0
		bhi.s	loc_53F98
		bra.s	loc_53FE2
; ---------------------------------------------------------------------------

loc_53F98:
		clr.w	(Events_bg+$00).w
		lsr.w	#1,d2
		jsr	loc_53FA6-2(pc,d2.w)
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

loc_53FA6:
		bra.s	LBZ1_LayoutExitMod1
; ---------------------------------------------------------------------------
		bra.s	LBZ1_LayoutExitMod2
; ---------------------------------------------------------------------------
		bra.s	LBZ1_LayoutExitMod3
; ---------------------------------------------------------------------------
		bra.s	LBZ1_LayoutExitMod4
; ---------------------------------------------------------------------------

LBZ1_LayoutExitMod1:
		movea.w	(a3),a5
		lea	$88(a5),a5
		jmp	(LBZ1_DoMod1).l
; ---------------------------------------------------------------------------

LBZ1_LayoutExitMod2:
		movea.w	$24(a3),a5
		lea	$8A(a5),a5
		jmp	(LBZ1_DoMod2).l
; ---------------------------------------------------------------------------

LBZ1_LayoutExitMod3:
		movea.w	(a3),a5
		lea	$98(a5),a5
		jmp	(LBZ1_DoMod3).l
; ---------------------------------------------------------------------------

LBZ1_LayoutExitMod4:
		movea.w	$30(a3),a5
		lea	$9A(a5),a5
		jmp	(LBZ1_DoMod4).l
; ---------------------------------------------------------------------------

loc_53FE2:
		jsr	LBZ1_EventVScroll(pc)		; Do the vscroll deformation, if necessary
		lea	(LBZ1_FGVScrollArray).l,a4
		lea	(HScroll_table+$100).w,a5
		moveq	#$F,d6
		moveq	#$C,d5
		jmp	DrawTilesVDeform(pc)

; =============== S U B R O U T I N E =======================================


LBZ1_EventVScroll:
		tst.w	(Events_fg_4).w
		beq.w	loc_540AC
		bpl.s	loc_5401C
		move.w	#1,(Events_fg_4).w
		move.w	#4,(Special_V_int_routine).w
		jsr	(AllocateObject).l
		bne.s	loc_5401C
		move.l	#Obj_LBZ1InvisibleBarrier,(a1)

loc_5401C:
		lea	(HScroll_table+$14C).w,a1
		lea	(LBZ1_CollapseScrollSpeed).l,a5
		move.l	$2C(a1),d0
		addi.l	#$100,$2C(a1)
		move.w	$30(a1),d1
		addq.w	#1,$30(a1)
		asr.w	#6,d1
		moveq	#$A,d2
		moveq	#$A-1,d3

loc_54040:
		addq.w	#2,d1
		andi.w	#$E,d1
		move.w	(a5,d1.w),d4
		ext.l	d4
		lsl.l	#4,d4
		move.l	(a1),d5
		sub.l	d4,d5
		sub.l	d0,d5
		swap	d5
		cmpi.w	#-$300,d5
		bgt.s	loc_54062
		move.w	#-$300,d5
		subq.w	#1,d2

loc_54062:
		swap	d5
		move.l	d5,(a1)+
		dbf	d3,loc_54040
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	loc_54082
		tst.w	d2
		beq.s	loc_54082
		moveq	#signextendB(sfx_BigRumble),d0
		jsr	(Play_SFX).l

loc_54082:
		tst.w	d2
		bne.s	loc_540AC
		clr.w	(Screen_shake_flag).w
		clr.w	(Events_fg_4).w
		move.w	#$C,(Special_V_int_routine).w
		jsr	LBZ1_ModEndingLayout(pc)
		lea	(HScroll_table+$148).w,a1
		moveq	#$E-1,d0

loc_5409E:
		clr.l	(a1)+
		dbf	d0,loc_5409E
		moveq	#signextendB(sfx_Crash),d0
		jsr	(Play_SFX).l

loc_540AC:
		lea	(HScroll_table+$100).w,a1
		lea	(HScroll_table+$130).w,a4
		lea	(HScroll_table+$148).w,a5
		move.w	(Camera_Y_pos_copy).w,d0
		moveq	#$C-1,d1

loc_540BE:
		move.w	(a5),d2
		add.w	d0,d2
		move.w	d2,(a1)
		move.w	d2,(a4)+
		addq.w	#4,a1
		addq.w	#4,a5
		dbf	d1,loc_540BE
		rts
; End of function LBZ1_EventVScroll


; =============== S U B R O U T I N E =======================================


LBZ1_ModEndingLayout:
		movea.w	(a3),a1			; This ensures that when Sonic starts from the lamppost before the boss the building behind him disappears
		lea	$74(a1),a1			; It also doubles as the layout used by Knuckles in his version of the level
		move.w	-8(a3),d0
		subq.w	#4,d0
		moveq	#$C-1,d1

loc_540DE:
		clr.l	(a1)+
		adda.w	d0,a1
		dbf	d1,loc_540DE
		movea.w	(a3),a5
		lea	$98(a5),a5
		movea.w	$24(a3),a1
		lea	$74(a1),a1
		move.w	-8(a3),d0
		subq.w	#4,d0
		moveq	#3-1,d1

loc_540FC:
		move.l	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_540FC
		st	(Events_bg+$02).w		; Disable the layout modding for this area (layoutmod3)
		rts
; End of function LBZ1_ModEndingLayout


; =============== S U B R O U T I N E =======================================


LBZ1_KnuxLevelSizeAdjust:
		cmpi.w	#3,(Player_mode).w
		bne.s	locret_54144		; Only do this if playing as Knuckles
		move.w	(Player_1+x_pos).w,d0
		cmpi.w	#$37C0,d0			; Basically this adjusts the top of the screen for Knuckles when he approaches the end of the level
		blo.s	locret_54144
		cmpi.w	#$3800,d0
		bhi.s	locret_54144
		move.w	(Player_1+y_pos).w,d0
		cmpi.w	#$600,d0
		blo.s	locret_54144
		cmpi.w	#$680,d0
		bhi.s	locret_54144
		moveq	#0,d1
		cmpi.w	#$640,d0
		bhs.s	loc_54140
		move.w	#$40C,d1

loc_54140:
		move.w	d1,(Camera_min_Y_pos).w

locret_54144:
		rts
; End of function LBZ1_KnuxLevelSizeAdjust


; =============== S U B R O U T I N E =======================================


LBZ1_RotateChunks:
		moveq	#$18-1,d2

loc_54148:
		lea	($FF6E00).l,a1
		lea	-2(a1),a5
		move.w	(a5),d0
		moveq	#$3F-1,d1

loc_54156:
		move.w	-(a5),-(a1)
		dbf	d1,loc_54156
		move.w	d0,(a5)
		dbf	d2,loc_54148
		rts
; End of function LBZ1_RotateChunks

; ---------------------------------------------------------------------------

Obj_LBZ1InvisibleBarrier:
		cmpi.w	#$3D80,(Camera_X_pos).w
		blo.s	loc_54172
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_54172:
		move.w	#$3BC0,d4
		move.w	d4,x_pos(a0)
		move.w	#$100,y_pos(a0)
		move.b	#$40,width_pixels(a0)
		bset	#7,status(a0)
		moveq	#$4B,d1
		move.w	#$100,d2
		move.w	#$100,d3
		jmp	(SolidObjectFull2).l
; ---------------------------------------------------------------------------

LBZ1_BackgroundInit:
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_541C6
		movea.w	(a3),a1			; Get rid of the Death Egg portion of the BG while playing as Knuckles. For obvious reasons.
		addq.w	#2,a1
		move.b	#$E4,(a1)+
		move.b	#$E6,(a1)+
		move.b	#$E0,(a1)+
		movea.w	4(a3),a1
		addq.w	#2,a1
		move.b	#$EC,(a1)+
		move.b	#$EE,(a1)+
		move.b	#$E8,(a1)+

loc_541C6:
		jsr	(LBZ1_Deform).l
		jsr	Reset_TileOffsetPositionEff(pc)
		move.w	d2,(HScroll_table+$002).w
		clr.l	(HScroll_table+$004).w
		lea	LBZ1_BGDrawArray(pc),a4
		lea	(HScroll_table).w,a5
		jsr	Refresh_PlaneTileDeform(pc)
		lea	LBZ1_BGDeformArray(pc),a4
		lea	(HScroll_table+$008).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

LBZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	LBZ1_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

LBZ1_BackgroundEvent_Index:
		bra.w	LBZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	LBZ1BGE_DoTransition
; ---------------------------------------------------------------------------

LBZ1BGE_Normal:
		tst.w	(Events_fg_5).w
		beq.s	loc_54248
		clr.w	(Events_fg_5).w		; Yeah, normal transition nonsense for the level change
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(LBZ2_128x128_Kos).l,a1
		lea	(RAM_start).l,a2
		jsr	(Queue_Kos).l
		lea	(LBZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$6B8).w,a2
		jsr	(Queue_Kos).l
		lea	(LBZ2_8x8_Secondary_KosM).l,a1
		move.w	#tiles_to_bytes($19D),d2
		jsr	(Queue_Kos_Module).l
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(Events_routine_bg).w

loc_54248:
		jsr	(LBZ1_Deform).l
		lea	LBZ1_BGDrawArray(pc),a4
		lea	(HScroll_table).w,a5
		moveq	#$20,d6
		moveq	#2,d5
		jsr	Draw_BG(pc)
		lea	LBZ1_BGDeformArray(pc),a4
		lea	(HScroll_table+$008).w,a5
		jsr	ApplyDeformation(pc)
		lea	(LBZ1_FGVScrollArray).l,a4
		lea	(HScroll_table+$12E).w,a5
		jsr	Apply_FGVScroll(pc)
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

LBZ1BGE_DoTransition:
		tst.b	(Kos_modules_left).w
		bne.w	loc_5432E
		move.w	#$601,(Current_zone_and_act).w
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(Respawn_table_keep).w
		jsr	Clear_Switches(pc)
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		jsr	(CheckLevelForWater).l
		move.w	#$8014,(VDP_control_port).l		; Water in this stage yaaay
		moveq	#PalID_LBZ2,d0
		jsr	(LoadPalette_Immediate).l
		movem.l	(sp)+,d7-a0/a2-a3
		jsr	Adjust_LBZ2Layout(pc)
		move.w	#$3A00,d0
		moveq	#0,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d0,(Player_2+x_pos).w
		jsr	Offset_ObjectsDuringTransition(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w
		jsr	Reset_TileOffsetPositionActual(pc)
		clr.l	(Events_bg+$00).w
		clr.l	(Events_bg+$14).w
		clr.w	(_unkEEA0).w
		clr.w	(Event_LBZ2_DeathEgg).w
		clr.w	(Events_fg_3).w
		move.w	#$40,(Events_bg+$10).w
		cmpi.w	#$540,(Camera_Y_pos).w
		blo.s	loc_5431C
		neg.w	(Events_bg+$10).w

loc_5431C:
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(sub_2807A).l				; Start LBZ2 tile animation
		movem.l	(sp)+,d7-a0/a2-a3
		clr.w	(Events_routine_bg).w

loc_5432E:
		lea	LBZ1_BGDeformArray(pc),a4
		lea	(HScroll_table+$008).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------
LBZ1_BGDrawArray:
		dc.w    $D0, $7FFF
LBZ1_BGDeformArray:
		dc.w    $D0,   $18,     8,     8, $7FFF
; ---------------------------------------------------------------------------

LBZ2_ScreenInit:
		jsr	Adjust_LBZ2Layout(pc)
		move.w	#4,(Events_routine_fg).w
		clr.l	(Events_bg+$14).w
		clr.w	(_unkEEA0).w
		clr.w	(Event_LBZ2_DeathEgg).w
		clr.w	(Events_fg_3).w
		bsr.s	LBZ2_LayoutMod
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

LBZ2_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	(Events_routine_fg).w,d0
		jmp	LBZ2_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

LBZ2_ScreenEvent_Index:
		bra.w	LBZ2SE_FromTransition
; ---------------------------------------------------------------------------
		bra.w	LBZ2SE_Normal
; ---------------------------------------------------------------------------

LBZ2SE_FromTransition:
		cmpi.w	#3,(Player_mode).w		; Only run when going from transition, of course
		beq.s	loc_543C2				; Knuckles adjusts the layout immediately.
		cmpi.w	#$60A,(Player_1+x_pos).w
		blo.s	loc_5439E
		bsr.s	LBZ2_LayoutMod
		addq.w	#4,(Events_routine_fg).w
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

loc_5439E:
		jmp	DrawTilesAsYouMove(pc)

; =============== S U B R O U T I N E =======================================


LBZ2_LayoutMod:
		movea.w	(a3),a5			; Thankfully, this is the only one in the whole level
		lea	$94(a5),a5
		movea.w	(a3),a1
		addq.w	#6,a1
		move.w	-8(a3),d0
		subq.w	#6,d0
		moveq	#6-1,d1

loc_543B4:
		move.l	(a5)+,(a1)+
		move.w	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_543B4
		rts
; End of function LBZ2_LayoutMod

; ---------------------------------------------------------------------------

loc_543C2:
		bsr.s	LBZ2_LayoutMod
		addq.w	#4,(Events_routine_fg).w

LBZ2SE_Normal:
		jmp	DrawTilesAsYouMove(pc)		; Remarkably straightforward

; =============== S U B R O U T I N E =======================================


Adjust_LBZ2Layout:
		movea.w	(Level_layout_main+$48).w,a1
		movea.w	(Level_layout_main+$4C).w,a5
		move.b	5(a1),5(a5)
		move.b	#$DB,5(a1)
		jsr	LBZ1_RotateChunks(pc)
		movea.w	(Level_layout_main+$4C).w,a1
		move.b	4(a1),d0
		movea.w	(Level_layout_main+$50).w,a1
		addq.w	#4,a1
		move.b	d0,(a1)+
		move.b	d0,(a1)+
		move.b	d0,(a1)+
		movea.w	(Level_layout_main+$1C).w,a1
		move.b	#$58,$8A(a1)
		movea.w	(Level_layout_main+$20).w,a1
		move.b	#$55,$8A(a1)
		rts
; End of function Adjust_LBZ2Layout

; ---------------------------------------------------------------------------

LBZ2_BackgroundInit:
		move.w	#8,(Events_routine_bg).w
		jsr	LBZ2_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		moveq	#$40,d0
		cmp.w	(Events_bg+$10).w,d0
		blt.s	loc_54432
		neg.w	d0
		cmp.w	(Events_bg+$10).w,d0
		bgt.s	loc_54436

loc_54432:
		move.w	d0,(Events_bg+$10).w		; Keep art reloading in range

loc_54436:
		lea	(LBZ2_BGDeformArray).l,a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

LBZ2_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	LBZ2_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

LBZ2_BackgroundEvent_Index:
		bra.w	LBZ2BGE_FromTransition
; ---------------------------------------------------------------------------
		bra.w	LBZ2BGE_Refresh
; ---------------------------------------------------------------------------
		bra.w	LBZ2BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	LBZ2BGE_DeathEgg
; ---------------------------------------------------------------------------
		bra.w	LBZ2BGE_PlatformDetach
; ---------------------------------------------------------------------------
		bra.w	LBZ2BGE_Falling
; ---------------------------------------------------------------------------

LBZ2BGE_FromTransition:
		jsr	LBZ2_Deform(pc)						; This and below are only done when transitioning
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_54488
; ---------------------------------------------------------------------------

LBZ2BGE_Refresh:
		jsr	LBZ2_Deform(pc)

loc_54488:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_544A4
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_544A4
; ---------------------------------------------------------------------------

LBZ2BGE_Normal:
		tst.w	(Events_fg_5).w
		bne.s	loc_544C6		; Wait for flag
		jsr	LBZ2_Deform(pc)

loc_544A4:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	(LBZ2_BGDeformArray).l,a4
		lea	(HScroll_table).w,a5
		jsr	ApplyDeformation(pc)
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

loc_544C6:
		clr.w	(Events_fg_5).w			; Oh boy, NOW the fun begins
		move.w	8(a3),(a3)
		move.w	$C(a3),4(a3)			; Modify the background slightly
		move.w	#$4390,d0
		move.w	d0,(Camera_max_X_pos).w		; X-end is at $4390
		move.w	#$668,d0
		move.w	d0,(Camera_max_Y_pos).w		; Y-end is $668
		move.w	d0,(Camera_target_max_Y_pos).w
		move.w	#$3C,(Events_bg+$0E).w
		move.w	#$1E00,(_unkEEA2).w
		move.l	#$6200,(_unkEE9C).w
		st	(Scroll_lock).w
		st	(Event_LBZ2_DeathEgg).w
		addq.w	#4,(Events_routine_bg).w

LBZ2BGE_DeathEgg:
		tst.w	(Event_LBZ2_DeathEgg).w
		beq.s	loc_5452E
		tst.w	(Screen_shake_flag).w
		bne.s	loc_5451A			; Branch if shaking
		clr.w	(Event_LBZ2_DeathEgg).w
		bra.s	loc_5452E
; ---------------------------------------------------------------------------

loc_5451A:
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	loc_5452E
		moveq	#signextendB(sfx_DeathEggRiseLoud),d0			; Play Death Egg rumbling sound
		jsr	(Play_SFX).l

loc_5452E:
		tst.w	(Events_fg_5).w
		beq.w	loc_545DE
		jsr	LBZ2_EndFallingAccel(pc)	; When signaled, start the falling of the death egg platform
		tst.w	(_unkEE9C).w
		bpl.w	loc_545DE
		clr.w	(Events_fg_5).w			; When movement starts going negative
		move.w	#$1B,(Draw_delayed_rowcount).w
		move.w	#$10,(Special_V_int_routine).w		; Do the first window copy
		clr.b	(Water_flag).w			; No more water evidently
		addq.w	#4,(Events_routine_bg).w
		bra.w	loc_545DE
; ---------------------------------------------------------------------------

LBZ2BGE_PlatformDetach:
		tst.w	(Special_V_int_routine).w
		bne.s	sub_545DA			; Wait for window copy to finish
		move.w	(Level_frame_counter).w,d0
		andi.w	#3,d0
		bne.s	loc_545AA
		move.w	(Events_bg+$16).w,d0	; Only ever four frames
		cmpi.w	#$28,d0
		blo.s	loc_545A4
		clr.w	(Events_bg+$16).w		; When scroll A has scrolled off screen
		move.w	#$18,(Special_V_int_routine).w	; Use the next Special VInt function to restore the entire platform
		movea.w	$2A(a3),a1
		lea	$87(a1),a1
		clr.b	(a1)
		clr.b	1(a1)
		clr.b	2(a1)				; Furthermore, clear the entire level layout at $580 Y, $4380 X (3 chunks long, 2 chunks high)
		adda.w	-$A(a3),a1
		clr.b	(a1)+
		clr.b	(a1)+
		clr.b	(a1)				; This is for when the platform scrolls off screen at the end
		addq.w	#4,(Events_routine_bg).w
		bra.s	LBZ2BGE_Falling
; ---------------------------------------------------------------------------

loc_545A4:
		addq.w	#1,d0
		move.w	d0,(Events_bg+$16).w	; Increment value

loc_545AA:
		bsr.s	sub_545DA
		move.w	(Camera_Y_pos_copy).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		move.w	(Events_bg+$16).w,d0
		add.w	d0,(V_scroll_value).w	; Actual vertical scroll is modified by EEE8.
		addq.w	#4,sp
		rts
; ---------------------------------------------------------------------------

LBZ2BGE_Falling:
		tst.w	(Events_fg_5).w
		beq.s	sub_545DA		; Continue Death Egg deformation until signal
		st	(Scroll_lock).w		; Set flag so that camera doesn't follow Sonic
		move.w	(Camera_Y_pos).w,(Camera_Y_pos_copy).w		; Scroll screen upwards
		subq.w	#2,(Camera_Y_pos).w
		rts

; =============== S U B R O U T I N E =======================================


sub_545DA:
		jsr	LBZ2_EndFallingAccel(pc)

loc_545DE:
		jsr	LBZ2_DeathEggMoveScreen(pc)
		jsr	LBZ2_DeathEggDeform(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	(LBZ2_DEBGDeformArray).l,a4
		lea	(HScroll_table).w,a5
		jsr	ApplyDeformation(pc)
		jmp	ShakeScreen_Setup(pc)
; End of function sub_545DA


; =============== S U B R O U T I N E =======================================


LBZ2_Deform:
		move.w	(Camera_Y_pos_copy).w,d0			; Oh hey, it's more waterline fun, wasn't this just so interesting the first time
		move.w	(Screen_shake_offset).w,d3
		sub.w	d3,d0
		subi.w	#$5F0,d0
		move.w	d0,d1
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d2
		asr.l	#3,d2
		sub.l	d2,d0
		asr.l	#2,d2
		sub.l	d2,d0
		swap	d0
		move.w	d0,d2
		addi.w	#$2C0,d0
		add.w	d3,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w			; Calculate effective Y position
		sub.w	d1,d2
		move.w	d2,(Events_bg+$10).w			; Water line equilibrium point
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		tst.w	d2
		beq.w	loc_546FA					; Equilibrium skips ahead
		move.l	d0,d1
		move.l	d0,d3
		asr.l	#6,d3
		move.l	d3,d4
		asr.l	#3,d4
		sub.l	d4,d3
		moveq	#$20-1,d4
		cmpi.w	#-$40,d2
		bgt.s	loc_5467A
		lea	(HScroll_table+$01E).w,a1	; Above water, no art reloading needed

loc_54662:
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		sub.l	d3,d1
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		sub.l	d3,d1
		dbf	d4,loc_54662
		bra.w	loc_546FA
; ---------------------------------------------------------------------------

loc_5467A:
		lea	(HScroll_table+$11E).w,a1	; Below water

loc_5467E:
		swap	d1
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		swap	d1
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		dbf	d4,loc_5467E
		cmpi.w	#$40,d2
		bge.s	loc_546FA		; No art reloading needed if out of range
		lea	(HScroll_table+$09E).w,a1
		lea	(a1),a5
		lea	(LBZ_WaterlineScroll_Data).l,a6
		move.w	d2,d1
		bmi.s	loc_546D2
		move.w	d1,d3			; Below water
		neg.w	d3
		addi.w	#$40,d3
		lsl.w	#6,d3
		adda.w	d3,a6
		subq.w	#1,d1
		moveq	#0,d3
		lsr.w	#1,d1
		bcc.s	loc_546C4

loc_546BC:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),(a1)+

loc_546C4:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),(a1)+
		dbf	d1,loc_546BC
		bra.s	loc_546FA
; ---------------------------------------------------------------------------

loc_546D2:
		move.w	d1,d3			; Above water
		addi.w	#$40,d3
		lsl.w	#6,d3
		adda.w	d3,a6
		neg.w	d1
		subq.w	#1,d1
		moveq	#0,d3
		lsr.w	#1,d1
		bcc.s	loc_546EE

loc_546E6:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),-(a1)

loc_546EE:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),-(a1)
		dbf	d1,loc_546E6

loc_546FA:
		lea	(HScroll_table+$1E2).w,a1			; Below the water area moving up (from Knuckles area of course)
		move.l	d0,d1
		asr.l	#1,d1
		move.l	d1,d3
		asr.l	#3,d3
		swap	d1
		move.w	d1,(Camera_X_pos_BG_copy).w		; Effective X
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		swap	d1
		move.w	d1,(Events_bg+$12).w		; Art reloading for the bricks in Knuckles' area
		move.w	d1,-(a1)
		swap	d1
		lea	(LBZ2_BGUWDeformRange).l,a5	; This is an array of counters used for deformation sizes underwater.
		sub.l	d3,d1					; Likely because the underwater wavy effect necessitates specifying deformation line-by-line
		moveq	#4,d4

loc_54726:
		sub.l	d3,d1
		swap	d1
		move.w	(a5)+,d5

loc_5472C:
		move.w	d1,-(a1)
		move.w	d1,-(a1)
		move.w	d1,-(a1)
		move.w	d1,-(a1)
		dbf	d5,loc_5472C
		swap	d1
		dbf	d4,loc_54726
		moveq	#$40-1,d3
		tst.w	d2
		bmi.s	loc_54748
		sub.w	d2,d3					; Only perform as much addition line-by-line deformation as needed
		bcs.s	loc_54756

loc_54748:
		swap	d1
		lsr.w	#1,d3
		bcc.s	loc_54750

loc_5474E:
		move.w	d1,-(a1)

loc_54750:
		move.w	d1,-(a1)
		dbf	d3,loc_5474E

loc_54756:
		lea	(HScroll_table).w,a1			; With that over with, we can actually do some normal stuff
		lea	(LBZ2_CloudDeformArray).l,a5
		move.l	d0,d1
		asr.l	#6,d1
		move.l	d1,d3
		move.l	(HScroll_table+$1E2).w,d4
		addi.l	#$E00,(HScroll_table+$1E2).w		; Move clouds
		moveq	#$D-1,d5

loc_54774:
		move.w	(a5)+,d6
		add.l	d4,d1
		swap	d1
		move.w	d1,(a1,d6.w)
		swap	d1
		add.l	d3,d1
		dbf	d5,loc_54774
		move.l	d0,d1			; And now just do the rest of the deformation
		asr.l	#4,d1
		move.l	d1,d3
		asr.l	#1,d3
		lea	(HScroll_table+$01A).w,a1
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		add.l	d3,d1
		swap	d1
		move.w	d1,(a1)+
		tst.w	d2
		bpl.s	loc_547B4		; If below water, just do the full deformation
		moveq	#$40-1,d4
		add.w	d2,d4
		bmi.s	loc_547D2		; If above water far enough that entire waterline shows, skip ahead
		cmpi.w	#$30,d4
		blo.s	loc_547C6
		subi.w	#$30,d4
		bra.s	loc_547B6
; ---------------------------------------------------------------------------

loc_547B4:
		moveq	#$10-1,d4

loc_547B6:
		moveq	#$18-1,d5

loc_547B8:
		move.w	d1,(a1)+		; First $30 pixels have their own deformation
		move.w	d1,(a1)+
		dbf	d5,loc_547B8
		swap	d1
		add.l	d3,d1
		swap	d1

loc_547C6:
		lsr.w	#1,d4			; As do the last $10 pixels
		bcc.s	loc_547CC

loc_547CA:
		move.w	d1,(a1)+

loc_547CC:
		move.w	d1,(a1)+
		dbf	d4,loc_547CA

loc_547D2:
		moveq	#$3F,d0			; And yet, there's more, cause we now have the wavy effects to go!
		sub.w	d2,d0
		bmi.s	locret_5480A	; If high enough, no waviness needed
		addi.w	#$60,d0			; Otherwise, keep it up
		cmpi.w	#$E0,d0
		blo.s	loc_547E6
		move.w	#$E0-1,d0

loc_547E6:
		lea	(HScroll_table+$1DE).w,a1
		lea	LBZ_WaterWaveArray(pc),a5	; Water wave array
		move.w	(Level_frame_counter).w,d1
		asr.w	#1,d1
		andi.w	#$7E,d1
		adda.w	d1,a5
		lsr.w	#1,d0
		bcc.s	loc_54802

loc_547FE:
		move.w	-(a5),d3
		add.w	d3,-(a1)

loc_54802:
		move.w	-(a5),d3
		add.w	d3,-(a1)
		dbf	d0,loc_547FE

locret_5480A:
		rts
; End of function LBZ2_Deform


; =============== S U B R O U T I N E =======================================


LBZ2_DeathEggDeform:
		move.w	(Camera_Y_pos_copy).w,d0		; Oh no, I'm not commenting all of this again.
		move.w	(Screen_shake_offset).w,d3
		sub.w	d3,d0
		subi.w	#$5F0,d0
		sub.w	(Events_bg+$02).w,d0
		sub.w	(Events_bg+$06).w,d0
		move.w	d0,d1
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d2
		asr.l	#3,d2
		sub.l	d2,d0
		asr.l	#2,d2
		sub.l	d2,d0
		swap	d0
		move.w	d0,d2
		addi.w	#$2C0,d0
		sub.w	(Events_fg_3).w,d0
		add.w	d3,d0
		bpl.s	loc_5485C
		moveq	#0,d3
		move.w	d0,d4

loc_54848:
		addi.w	#$100,d3
		addi.w	#$100,d4
		bmi.s	loc_54848
		cmp.w	(_unkEEA0).w,d3
		blo.s	loc_5485C
		move.w	d3,(_unkEEA0).w

loc_5485C:
		tst.w	(Events_fg_3).w
		bne.s	loc_5486C
		cmpi.w	#$100,d0
		bne.s	loc_5486C
		move.w	d0,(Events_fg_3).w

loc_5486C:
		add.w	(_unkEEA0).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		tst.w	(_unkEEA0).w
		beq.s	loc_5488A

loc_5487A:
		cmpi.w	#$100,d0
		blo.s	loc_54886
		subi.w	#$100,d0
		bra.s	loc_5487A
; ---------------------------------------------------------------------------

loc_54886:
		move.w	d0,(Camera_Y_pos_BG_copy).w

loc_5488A:
		tst.w	(_unkEE9C).w
		bmi.s	loc_54894
		sub.w	d1,d2
		bpl.s	loc_54898

loc_54894:
		move.w	#$7FFF,d2

loc_54898:
		move.w	d2,(Events_bg+$10).w
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		move.l	d0,d1
		move.l	d0,d3
		asr.l	#6,d3
		move.l	d3,d4
		asr.l	#3,d4
		sub.l	d4,d3
		moveq	#$20-1,d4
		lea	(HScroll_table+$0AC).w,a1

loc_548B6:
		swap	d1
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		swap	d1
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		dbf	d4,loc_548B6
		cmpi.w	#$40,d2
		bge.s	loc_54906
		lea	(HScroll_table+$02C).w,a1
		lea	(a1),a5
		lea	(LBZ_WaterlineScroll_Data).l,a6
		move.w	d2,d1
		move.w	d1,d3
		neg.w	d3
		addi.w	#$40,d3
		lsl.w	#6,d3
		adda.w	d3,a6
		subq.w	#1,d1
		moveq	#0,d3
		lsr.w	#1,d1
		bcc.s	loc_548FA

loc_548F2:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),(a1)+

loc_548FA:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),(a1)+
		dbf	d1,loc_548F2

loc_54906:
		lea	(HScroll_table+$0EC).w,a1
		move.l	d0,d1
		asr.l	#1,d1
		move.l	d1,d3
		asr.l	#3,d3
		moveq	#7-1,d4

loc_54914:
		sub.l	d3,d1
		dbf	d4,loc_54914
		moveq	#$60-1,d3
		sub.w	d2,d3
		bcs.s	loc_5492E
		swap	d1
		lsr.w	#1,d3
		bcc.s	loc_54928

loc_54926:
		move.w	d1,-(a1)

loc_54928:
		move.w	d1,-(a1)
		dbf	d3,loc_54926

loc_5492E:
		lea	(HScroll_table+$00C).w,a1
		lea	(LBZ2_CloudDeformArray).l,a5
		move.l	d0,d1
		asr.l	#6,d1
		move.l	d1,d3
		move.l	(HScroll_table+$1E2).w,d4
		addi.l	#$E00,(HScroll_table+$1E2).w
		moveq	#$D-1,d5

loc_5494C:
		move.w	(a5)+,d6
		add.l	d4,d1
		swap	d1
		move.w	d1,(a1,d6.w)
		swap	d1
		add.l	d3,d1
		dbf	d5,loc_5494C
		lea	(HScroll_table+$010).w,a1
		lea	(HScroll_table).w,a5
		moveq	#4-1,d1

loc_54968:
		move.l	(a1)+,(a5)+
		dbf	d1,loc_54968
		move.l	d0,d1
		asr.l	#4,d1
		move.l	d1,d3
		asr.l	#1,d3
		lea	(HScroll_table+$026).w,a1
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		add.l	d3,d1
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		add.l	d3,d1
		swap	d1
		move.w	d1,(a1)+
		moveq	#$40-1,d0
		sub.w	d2,d0
		addi.w	#$20,d0
		cmpi.w	#$60,d0
		blo.s	loc_549A0
		move.w	#$60-1,d0

loc_549A0:
		lea	(HScroll_table+$0EC).w,a1
		lea	LBZ_WaterWaveArray2(pc),a5
		move.w	(Level_frame_counter).w,d1
		asr.w	#1,d1
		andi.w	#$7E,d1
		adda.w	d1,a5
		lsr.w	#1,d0
		bcc.s	loc_549BC

loc_549B8:
		move.w	-(a5),d3
		add.w	d3,-(a1)

loc_549BC:
		move.w	-(a5),d3
		add.w	d3,-(a1)
		dbf	d0,loc_549B8
		rts
; End of function LBZ2_DeathEggDeform


; =============== S U B R O U T I N E =======================================


LBZ2_DeathEggMoveScreen:
		cmpi.b	#6,(Player_1+routine).w
		bhs.w	locret_54A92		; If dying, don't bother
		tst.b	(Scroll_lock).w
		beq.s	loc_549FC			; Skip if flag turned off
		move.w	(Player_1+x_pos).w,d0
		sub.w	(Camera_X_pos).w,d0
		subi.w	#$A0,d0
		bcs.s	loc_549E8
		add.w	d0,(Camera_X_pos).w	; Move screen along with player in Robotnik ship

loc_549E8:
		cmpi.w	#$4390,(Camera_X_pos).w
		bhs.s	loc_549F8
		cmpi.w	#$668,(Camera_Y_pos).w
		blo.s	loc_549FC

loc_549F8:
		clr.b	(Scroll_lock).w		; Stop movement when screen edge is reached

loc_549FC:
		tst.w	(Events_bg+$0E).w
		beq.s	loc_54A0A
		subq.w	#1,(Events_bg+$0E).w
		bra.w	locret_54A92
; ---------------------------------------------------------------------------

loc_54A0A:
		cmpi.w	#$4390,(Camera_X_pos).w
		blo.s	loc_54A1A
		move.w	(Camera_max_X_pos).w,d0
		move.w	d0,(Camera_min_X_pos).w

loc_54A1A:
		cmpi.w	#$668,(Camera_Y_pos).w
		blo.s	loc_54A2A
		move.w	(Camera_max_Y_pos).w,d0
		move.w	d0,(Camera_min_Y_pos).w		; Lock screen when edges are reached

loc_54A2A:
		lea	(Events_bg+$02).w,a1
		moveq	#0,d1
		move.w	(_unkEEA2).w,d1		; Speed of Death Egg movement
		add.l	d1,(a1)
		move.w	(a1),d0
		move.w	d0,d1
		sub.w	8(a1),d0
		move.w	d1,8(a1)
		move.w	#$2200,d1
		tst.b	(Scroll_lock).w
		bne.s	loc_54A50
		move.l	(_unkEE9C).w,d1		; Get BG movement speed if edge of screen is reached

loc_54A50:
		add.l	d1,4(a1)
		move.w	4(a1),d1
		move.w	d1,d2
		sub.w	$A(a1),d1
		move.w	d2,$A(a1)
		tst.b	(Scroll_lock).w
		beq.s	loc_54A74
		movea.w	(Events_bg+$00).w,a5	; If movement is still going
		add.w	d0,$14(a5)			; Add Y movement to screen and Robotnik ship
		add.w	d0,(Camera_Y_pos).w

loc_54A74:
		move.w	(Target_water_level).w,d2
		add.w	d0,d2
		add.w	d1,d2
		cmpi.w	#$F00,d2
		blo.s	loc_54A86
		move.w	#$F80,d2

loc_54A86:
		move.w	d2,(Target_water_level).w
		move.w	d0,(Events_bg+$14).w
		add.w	d1,(Events_bg+$14).w

locret_54A92:
		rts
; End of function LBZ2_DeathEggMoveScreen


; =============== S U B R O U T I N E =======================================


LBZ2_EndFallingAccel:
		tst.w	(_unkEEA2).w
		beq.s	loc_54AA2
		subi.w	#$100,(_unkEEA2).w
		bra.s	locret_54AB4
; ---------------------------------------------------------------------------

loc_54AA2:
		cmpi.l	#$FFFE8000,(_unkEE9C).w
		ble.s	locret_54AB4
		subi.l	#$100,(_unkEE9C).w

locret_54AB4:
		rts
; End of function LBZ2_EndFallingAccel

; ---------------------------------------------------------------------------

MHZ1_ScreenInit:
		clr.w	(Events_bg+$16).w
		clr.b	(_unkF7C1).w
		jsr	sub_54B80(pc)
		tst.w	(SK_alone_flag).w
		beq.s	loc_54B18
		move.b	(Last_star_post_hit).w,d0
		beq.s	loc_54AE0
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_54B18
		subq.b	#1,d0
		bne.s	loc_54B18
		move.w	#$680,d2
		bra.s	loc_54B10
; ---------------------------------------------------------------------------

loc_54AE0:
		move.w	#$560,d2
		move.w	#$948,d3
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_54B08
		lea	(Player_1).w,a1
		move.w	#$718,x_pos(a1)
		move.w	#$62D,y_pos(a1)
		move.w	#$680,d2
		move.w	#$5CD,d3

loc_54B08:
		move.w	d3,(Camera_Y_pos).w
		move.w	d3,(Camera_Y_pos_copy).w

loc_54B10:
		move.w	d2,(Camera_X_pos).w
		move.w	d2,(Camera_X_pos_copy).w

loc_54B18:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

MHZ1_ScreenEvent:
		tst.b	(Events_bg+$00).w
		bne.s	loc_54B7C
		tst.w	(Events_bg+$16).w
		bne.s	loc_54B7C
		jsr	sub_54B80(pc)
		move.w	#$AA0,d0
		cmpi.w	#$4100,(Player_1+x_pos).w
		blo.s	loc_54B40
		move.w	#$710,d0

loc_54B40:
		cmp.w	(Camera_max_Y_pos).w,d0
		beq.s	loc_54B4E
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w

loc_54B4E:
		cmpi.w	#$710,(Camera_Y_pos).w
		blo.s	loc_54B7C
		cmpi.w	#$4298,(Camera_X_pos).w
		blo.s	loc_54B7C
		move.w	#$710,(Camera_min_Y_pos).w
		move.w	#8,(Special_events_routine).w
		st	(Events_bg+$00).w
		jsr	(AllocateObject).l
		bne.s	loc_54B7C
		move.l	#Obj_MHZMiniboss,(a1)

loc_54B7C:
		jmp	DrawTilesAsYouMove(pc)

; =============== S U B R O U T I N E =======================================


sub_54B80:
		move.w	#$680,d0
		tst.w	(SK_alone_flag).w
		bne.s	loc_54B98
		moveq	#0,d0
		cmpi.w	#$580,(Player_1+y_pos).w
		bhs.s	loc_54B98
		move.w	#$C0,d0

loc_54B98:
		cmp.w	(Camera_min_X_pos).w,d0
		beq.s	locret_54BA2
		move.w	d0,(Camera_min_X_pos).w

locret_54BA2:
		rts
; End of function sub_54B80

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
		beq.w	loc_54C3C
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
		jsr	sub_54CF4(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		move.w	(Camera_X_pos_copy).w,(Events_fg_0).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w
		jsr	Reset_TileOffsetPositionActual(pc)
		clr.w	(Special_events_routine).w
		clr.b	(Events_bg+$00).w

loc_54C3C:
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

loc_54CB0:
		clr.w	(Level_repeat_offset).w
		move.w	(Camera_X_pos).w,d0
		cmpi.w	#$4400,d0
		blo.s	loc_54CEE
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

loc_54CEE:
		move.w	d0,(Camera_min_X_pos).w
		rts

; =============== S U B R O U T I N E =======================================


sub_54CF4:
		lea	(Dynamic_object_RAM+object_size).w,a1
		moveq	#((Breathing_bubbles)-(Dynamic_object_RAM+object_size))/object_size-1,d2

loc_54CFA:
		move.l	(a1),d3
		beq.s	loc_54D26
		cmpi.l	#loc_2B962,d3
		bne.s	loc_54D16
		move.l	#Delete_Current_Sprite,(a1)
		move.w	respawn_addr(a1),d3
		beq.s	loc_54D16
		movea.w	d3,a5
		clr.b	(a5)

loc_54D16:
		btst	#2,render_flags(a1)
		beq.s	loc_54D26
		sub.w	d0,x_pos(a1)
		sub.w	d1,y_pos(a1)

loc_54D26:
		lea	next_object(a1),a1
		dbf	d2,loc_54CFA
		rts
; End of function sub_54CF4

; ---------------------------------------------------------------------------

MHZ2_ScreenInit:
		move.w	#4,(Events_routine_fg).w
		clr.w	(Events_bg+$16).w
		st	(_unkF7C1).w
		move.w	(Player_1+x_pos).w,d0
		lea	Pal_MHZ2Gold(pc),a1
		cmpi.w	#$2940,d0
		bhs.s	loc_54D72
		st	(Events_bg+$04).w
		lea	(Pal_MHZ2+$20).l,a1
		cmpi.w	#$9C0,d0
		bhs.s	loc_54D72
		cmpi.w	#$600,(Player_1+y_pos).w
		blo.s	loc_54D72
		clr.b	(Events_bg+$04).w
		clr.b	(_unkF7C1).w
		lea	(Pal_MHZ1+$20).l,a1

loc_54D72:
		lea	(Normal_palette_line_3).w,a5
		lea	(Target_palette_line_3).w,a6
		moveq	#bytesToLcnt($40),d0

loc_54D7C:
		move.l	(a1),(a5)+
		move.l	(a1)+,(a6)+
		dbf	d0,loc_54D7C
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
		bra.w	loc_54DB0
; ---------------------------------------------------------------------------
		bra.w	loc_54DBE
; ---------------------------------------------------------------------------
		bra.w	loc_54E86
; ---------------------------------------------------------------------------
		bra.w	loc_54E9C
; ---------------------------------------------------------------------------
		bra.w	loc_54F64
; ---------------------------------------------------------------------------

loc_54DB0:
		tst.b	(End_of_level_flag).w
		beq.s	loc_54DBA
		addq.w	#4,(Events_routine_fg).w

loc_54DBA:
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

loc_54DBE:
		tst.w	(Events_fg_4).w
		beq.s	loc_54DDC
		clr.w	(Events_fg_4).w
		move.w	#$320,(Draw_delayed_position).w
		move.w	#$A,(Draw_delayed_rowcount).w
		addq.w	#8,(Events_routine_fg).w
		bra.w	loc_54E9C
; ---------------------------------------------------------------------------

loc_54DDC:
		cmpi.w	#$3C90,(Camera_X_pos).w
		blo.s	loc_54E00
		bne.w	loc_54E7E
		move.w	#$3C90,(Camera_min_X_pos).w
		cmpi.w	#$280,(Camera_Y_pos).w
		blo.w	loc_54E7E
		move.w	#$280,(Camera_min_Y_pos).w
		bra.s	loc_54E7E
; ---------------------------------------------------------------------------

loc_54E00:
		move.w	#$620,d0
		cmpi.w	#$380,(Camera_X_pos).w
		blo.s	loc_54E1A
		moveq	#0,d0
		cmpi.w	#$3600,(Camera_X_pos).w
		blo.s	loc_54E1A
		move.w	#$1A8,d0

loc_54E1A:
		cmp.w	(Camera_min_Y_pos).w,d0
		beq.s	loc_54E24
		move.w	d0,(Camera_min_Y_pos).w

loc_54E24:
		cmpi.w	#$3600,(Camera_X_pos).w
		bhs.s	loc_54E4C
		move.w	#$98,d0
		cmpi.w	#$5C0,(Player_1+y_pos).w
		bhs.s	loc_54E3C
		move.w	#$380,d0

loc_54E3C:
		cmp.w	(Camera_min_X_pos).w,d0
		beq.s	loc_54E4C
		tst.w	(Events_bg+$16).w
		bne.s	loc_54E4C
		move.w	d0,(Camera_min_X_pos).w

loc_54E4C:
		move.w	#$9A0,d0
		cmpi.w	#$3A97,(Player_1+x_pos).w
		blo.s	loc_54E70
		move.w	#$280,d0
		cmpi.w	#$3AC0,(Player_1+x_pos).w
		bhs.s	loc_54E70
		cmpi.w	#$300,(Player_1+y_pos).w
		blo.s	loc_54E70
		move.w	#$9A0,d0

loc_54E70:
		cmp.w	(Camera_max_Y_pos).w,d0
		beq.s	loc_54E7E
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w

loc_54E7E:
		bsr.w	sub_55008
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

loc_54E86:
		move.w	(Camera_X_pos_copy).w,(HScroll_table+$004).w
		lea	MHZ2_BGDrawArray1(pc),a4
		lea	(HScroll_table).w,a5
		moveq	#$15,d6
		moveq	#2,d5
		jmp	loc_4EDD8(pc)
; ---------------------------------------------------------------------------

loc_54E9C:
		move.w	#$4280,d1
		move.w	#$280,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.w	locret_54F62
		move.l	#$400000,(_unkEE98).w
		move.w	#$80,d0
		move.w	d0,(_unkEEA2).w
		move.w	d0,(_unkEE9C).w
		jsr	sub_54F8C(pc)
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

loc_54EE4:
		move.l	(a5)+,(a1)+
		dbf	d0,loc_54EE4
		lea	(HScroll_table+$00C).w,a5
		clr.l	(a5)
		jsr	(AllocateObject).l
		bne.s	loc_54F2A
		move.l	#loc_5583E,(a1)
		move.w	#$4C0,$30(a1)
		move.w	#$4000,$3A(a1)
		jsr	(CreateNewSprite4).l
		bne.s	loc_54F2A
		move.l	#loc_55814,(a1)
		move.w	a1,(a5)+
		jsr	(CreateNewSprite4).l
		bne.s	loc_54F2A
		move.l	#loc_55814,(a1)
		move.w	a1,(a5)+

loc_54F2A:
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

locret_54F62:
		rts
; ---------------------------------------------------------------------------

loc_54F64:
		jsr	sub_54F8C(pc)
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


sub_54F8C:
		move.w	(Camera_X_pos_copy).w,d0
		move.w	d0,(HScroll_table+$008).w
		addi.w	#$1E0,d0
		add.w	(_unkEE98).w,d0
		move.w	(HScroll_table).w,d2
		move.w	d0,(HScroll_table).w
		move.w	(_unkEE9C).w,d1
		lea	(Player_1).w,a1
		cmpi.b	#$81,object_control(a1)
		bne.s	loc_54FD4
		move.w	#$2DC,d3
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_54FC4
		move.w	#$2CD,d3

loc_54FC4:
		move.w	(Events_bg+$0C).w,d4
		sub.w	d1,d4
		add.w	d4,y_pos(a1)
		sub.w	d0,d2
		add.w	d2,x_pos(a1)

loc_54FD4:
		move.w	d1,(Events_bg+$0C).w
		neg.w	d1
		addi.w	#$158,d1
		lea	(HScroll_table+$00C).w,a1
		move.w	#$46B8,d2
		bsr.s	sub_54FEC
		move.w	#$45B8,d2
; End of function sub_54F8C


; =============== S U B R O U T I N E =======================================


sub_54FEC:
		move.w	(a1)+,d3
		beq.s	locret_55006
		movea.w	d3,a5
		sub.w	d0,d2
		bcs.s	locret_55006
		addi.w	#$5C,d2
		andi.w	#$1FF,d2
		move.w	d2,$10(a5)
		move.w	d1,$14(a5)

locret_55006:
		rts
; End of function sub_54FEC


; =============== S U B R O U T I N E =======================================


sub_55008:
		lea	word_5513E(pc),a1
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		moveq	#0,d2
		move.w	#5-1,d3

loc_5501A:
		lea	(a1),a5
		cmp.w	(a5)+,d0
		blo.s	loc_5502C
		cmp.w	(a5)+,d0
		bhi.s	loc_5502C
		cmp.w	(a5)+,d1
		blo.s	loc_5502C
		cmp.w	(a5)+,d1
		blo.s	loc_55038

loc_5502C:
		adda.w	#$A,a1
		addq.w	#4,d2
		dbf	d3,loc_5501A
		rts
; ---------------------------------------------------------------------------

loc_55038:
		jmp	loc_5503C(pc,d2.w)
; End of function sub_55008

; ---------------------------------------------------------------------------

loc_5503C:
		bra.w	loc_55050
; ---------------------------------------------------------------------------
		bra.w	loc_55062
; ---------------------------------------------------------------------------
		bra.w	loc_55074
; ---------------------------------------------------------------------------
		bra.w	loc_55074
; ---------------------------------------------------------------------------
		bra.w	loc_55086
; ---------------------------------------------------------------------------

loc_55050:
		tst.w	(Events_bg+$04).w
		bne.s	loc_5505C
		cmp.w	(a5),d1
		blo.s	loc_55098
		rts
; ---------------------------------------------------------------------------

loc_5505C:
		cmp.w	(a5),d1
		bhs.s	loc_550A8
		rts
; ---------------------------------------------------------------------------

loc_55062:
		tst.w	(Events_bg+$04).w
		bne.s	loc_5506E
		cmp.w	(a5),d0
		bhs.s	loc_55098
		rts
; ---------------------------------------------------------------------------

loc_5506E:
		cmp.w	(a5),d0
		blo.s	loc_550A8
		rts
; ---------------------------------------------------------------------------

loc_55074:
		tst.w	(Events_bg+$04).w
		bne.s	loc_55080
		cmp.w	(a5),d0
		blo.s	loc_55098
		rts
; ---------------------------------------------------------------------------

loc_55080:
		cmp.w	(a5),d0
		bhs.s	loc_550B8
		rts
; ---------------------------------------------------------------------------

loc_55086:
		tst.w	(Events_bg+$04).w
		bne.s	loc_55092
		cmp.w	(a5),d1
		blo.s	loc_55098
		rts
; ---------------------------------------------------------------------------

loc_55092:
		cmp.w	(a5),d1
		bhs.s	loc_550B8
		rts
; ---------------------------------------------------------------------------

loc_55098:
		st	(Events_bg+$04).w
		st	(_unkF7C1).w
		lea	(Pal_MHZ2+$20).l,a1
		bra.s	loc_550C4
; ---------------------------------------------------------------------------

loc_550A8:
		clr.w	(Events_bg+$04).w
		clr.b	(_unkF7C1).w
		lea	(Pal_MHZ1+$20).l,a1
		bra.s	loc_550C4
; ---------------------------------------------------------------------------

loc_550B8:
		clr.w	(Events_bg+$04).w
		st	(_unkF7C1).w
		lea	Pal_MHZ2Gold(pc),a1

loc_550C4:
		lea	(Normal_palette_line_3).w,a5
		moveq	#bytesToLcnt($40),d0

loc_550CA:
		move.l	(a1)+,(a5)+
		dbf	d0,loc_550CA
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
word_5513E:
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
		blo.s	loc_55198
		cmpi.w	#$500,(Player_1+y_pos).w
		bhs.s	loc_55198
		move.w	#8,(Events_routine_bg).w
		jsr	sub_554B8(pc)
		bra.s	loc_5519C
; ---------------------------------------------------------------------------

loc_55198:
		jsr	MHZ_Deform(pc)

loc_5519C:
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
		bra.w	loc_551EE
; ---------------------------------------------------------------------------
		bra.w	loc_55236
; ---------------------------------------------------------------------------
		bra.w	loc_55250
; ---------------------------------------------------------------------------
		bra.w	loc_552F8
; ---------------------------------------------------------------------------
		bra.w	loc_55312
; ---------------------------------------------------------------------------
		bra.w	loc_553B6
; ---------------------------------------------------------------------------
		bra.w	loc_55424
; ---------------------------------------------------------------------------
		bra.w	loc_5543A
; ---------------------------------------------------------------------------
		bra.w	loc_5545A
; ---------------------------------------------------------------------------
		bra.w	loc_55486
; ---------------------------------------------------------------------------

loc_551EE:
		cmpi.w	#$3700,(Player_1+x_pos).w
		blo.s	loc_5521E
		cmpi.w	#$500,(Player_1+y_pos).w
		bhs.s	loc_5521E
		jsr	sub_554B8(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_5523A
; ---------------------------------------------------------------------------

loc_5521E:
		jsr	MHZ_Deform(pc)

loc_55222:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

loc_55236:
		jsr	sub_554B8(pc)

loc_5523A:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.w	loc_552E4
		addq.w	#4,(Events_routine_bg).w
		bra.w	loc_552E4
; ---------------------------------------------------------------------------

loc_55250:
		cmpi.w	#$500,(Player_1+y_pos).w
		blo.s	loc_5527A
		jsr	MHZ_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.w	loc_552FC
; ---------------------------------------------------------------------------

loc_5527A:
		cmpi.w	#$420,(Player_1+y_pos).w
		bls.s	loc_5528A
		btst	#1,(Player_1+status).w
		bne.s	loc_552E0

loc_5528A:
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(MHZ_Custom_Layout).l,a1
		lea	(Level_layout_header).w,a2
		move.w	#$200-1,d0

loc_5529C:
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		dbf	d0,loc_5529C
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
		bra.s	loc_55312
; ---------------------------------------------------------------------------

loc_552E0:
		jsr	sub_554B8(pc)

loc_552E4:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

loc_552F8:
		jsr	MHZ_Deform(pc)

loc_552FC:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.w	loc_55222
		clr.w	(Events_routine_bg).w
		bra.w	loc_55222
; ---------------------------------------------------------------------------

loc_55312:
		tst.b	(Events_bg+$00).w
		bne.s	loc_55380
		cmpi.w	#$3F00,(Camera_X_pos).w
		blo.w	loc_55486
		addq.w	#4,(Events_routine_fg).w
		clr.l	(HScroll_table).w
		move.w	(Camera_X_pos_copy).w,d0
		move.w	d0,(HScroll_table+$004).w
		andi.w	#$FFF0,d0
		move.w	d0,(HScroll_table+$006).w
		move.w	#$1A0,(Draw_delayed_position).w
		move.w	#2,(Draw_delayed_rowcount).w
		st	(Events_bg+$00).w
		lea	word_558E8(pc),a1
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_5535A
		lea	$10(a1),a1

loc_5535A:
		move.b	(a1),(Events_bg+$07).w
		st	(Scroll_lock).w
		move.w	#$C,(Special_events_routine).w
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(ArtKosM_MHZEndBossPillar).l,a1
		move.w	#tiles_to_bytes(ArtTile_MHZEndBossPillar),d2
		jsr	(Queue_Kos_Module).l
		movem.l	(sp)+,d7-a0/a2-a3

loc_55380:
		move.w	#$4000,d1
		move.w	#$180,d2
		lea	(Level_layout_main).w,a3
		move.w	#VRAM_Plane_A_Name_Table,d7
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		addq.w	#2,a3
		move.w	#VRAM_Plane_B_Name_Table,d7
		tst.w	(Draw_delayed_rowcount).w
		bpl.w	loc_55486
		move.w	#$80,(Draw_delayed_position).w
		move.w	#2,(Draw_delayed_rowcount).w
		st	(Events_bg+$01).w
		addq.w	#4,(Events_routine_bg).w

loc_553B6:
		move.w	#$200,d1
		move.w	#$80,d2
		jsr	Draw_PlaneVertTopDown(pc)
		bpl.w	loc_55486
		lea	(HScroll_table+$008).w,a5
		clr.l	(a5)
		clr.l	4(a5)
		jsr	(AllocateObject).l
		bne.s	loc_55420
		move.l	#loc_556F8,(a1)
		jsr	(CreateNewSprite4).l
		bne.s	loc_55420
		move.l	#loc_55732,(a1)
		move.w	a1,(a5)+
		moveq	#2,d1

loc_553F0:
		jsr	(CreateNewSprite4).l
		bne.s	loc_55420
		move.l	#loc_5577C,(a1)
		move.w	d1,$2E(a1)
		move.w	a1,(a5)+
		jsr	(CreateNewSprite4).l
		bne.s	loc_55420
		move.l	#loc_5577C,(a1)
		move.w	d1,$2E(a1)
		st	$30(a1)
		move.w	a1,(a5)+
		dbf	d1,loc_553F0

loc_55420:
		addq.w	#4,(Events_routine_bg).w

loc_55424:
		tst.w	(Events_fg_5).w
		bpl.s	loc_55486
		move.w	#$180,(Draw_delayed_position).w
		move.w	#2,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w

loc_5543A:
		moveq	#0,d1
		move.w	#$180,d2
		jsr	Draw_PlaneVertTopDown(pc)
		bpl.s	loc_55486
		clr.b	(Events_bg+$01).w
		move.w	#$280,(Draw_delayed_position).w
		move.w	#2,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w

loc_5545A:
		move.w	#$4080,d1
		move.w	#$280,d2
		lea	(Level_layout_main).w,a3
		move.w	#VRAM_Plane_A_Name_Table,d7
		jsr	Draw_PlaneVertTopDown(pc)
		addq.w	#2,a3
		move.w	#VRAM_Plane_B_Name_Table,d7
		tst.w	(Draw_delayed_rowcount).w
		bpl.s	loc_55486
		clr.b	(Events_bg+$00).w
		clr.w	(Events_routine_fg).w
		addq.w	#4,(Events_routine_bg).w

loc_55486:
		jsr	sub_554B8(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		jsr	sub_5550C(pc)
		cmpi.w	#$10,(Events_routine_fg).w
		bne.s	loc_554B4
		move.w	(_unkEE9C).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp

loc_554B4:
		jmp	ShakeScreen_Setup(pc)

; =============== S U B R O U T I N E =======================================


sub_554B8:
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
; End of function sub_554B8


; =============== S U B R O U T I N E =======================================


sub_5550C:
		jsr	PlainDeformation(pc)
		cmpi.w	#$10,(Events_routine_fg).w
		bne.s	loc_55534
		lea	(H_scroll_buffer).w,a1
		move.w	(HScroll_table).w,d0
		neg.w	d0
		moveq	#$40-1,d1

loc_55524:
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		dbf	d1,loc_55524
		bra.w	locret_5560A
; ---------------------------------------------------------------------------

loc_55534:
		tst.b	(Events_bg+$00).w
		beq.s	loc_55552
		lea	(H_scroll_buffer).w,a1
		move.w	(Camera_X_pos_BG_copy).w,d0
		neg.w	d0
		moveq	#$18-1,d1

loc_55546:
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		dbf	d1,loc_55546

loc_55552:
		tst.b	(Events_bg+$01).w
		beq.w	locret_5560A
		move.w	(Camera_X_pos).w,d0
		subi.w	#$4180,d0
		cmpi.w	#-$140,d0
		blt.w	loc_555FC
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
		bpl.s	loc_55586
		neg.l	d0

loc_55586:
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
		beq.s	loc_555A4
		neg.l	d1

loc_555A4:
		lea	(H_scroll_buffer+2).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$80,d0
		neg.w	d0
		swap	d0
		clr.w	d0
		moveq	#$30-1,d2

loc_555B8:
		swap	d0
		move.w	d0,(a1)
		swap	d0
		add.l	d1,d0
		addq.w	#4,a1
		dbf	d2,loc_555B8
		lea	(HScroll_table+$008).w,a1
		lea	(H_scroll_buffer+$BE).w,a5
		moveq	#$1C,d0
		moveq	#7-1,d1

loc_555D2:
		move.w	(a1)+,d2
		beq.s	locret_5560A
		movea.w	d2,a6
		move.w	(a5),d2
		subi.w	#$48,d2
		andi.w	#$1FF,d2
		add.w	(Camera_X_pos).w,d2
		move.w	d2,$10(a6)
		btst	#0,d1
		bne.s	loc_555F6
		suba.w	d0,a5
		addi.w	#$C,d0

loc_555F6:
		dbf	d1,loc_555D2
		bra.s	locret_5560A
; ---------------------------------------------------------------------------

loc_555FC:
		lea	(H_scroll_buffer+2).w,a1
		moveq	#$30-1,d0

loc_55602:
		clr.w	(a1)
		addq.w	#4,a1
		dbf	d0,loc_55602

locret_5560A:
		rts
; End of function sub_5550C

; ---------------------------------------------------------------------------

loc_5560C:
		clr.w	(Level_repeat_offset).w
		move.w	(Camera_X_pos).w,d0
		addq.w	#4,d0
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_55620
		addq.w	#1,d0

loc_55620:
		cmpi.w	#$4280,d0
		blo.s	loc_5569A
		tst.w	(Events_fg_5).w
		beq.s	loc_5564A
		st	(Events_fg_5).w
		cmpi.w	#$4420,d0
		blo.s	loc_5569A
		move.w	#$4420,d0
		move.w	#$45A0,(Camera_max_X_pos).w
		st	(Scroll_lock).w
		clr.w	(Special_events_routine).w
		bra.s	loc_5569E
; ---------------------------------------------------------------------------

loc_5564A:
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
		lea	word_558E8(pc),a1
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_55686
		lea	$10(a1),a1

loc_55686:
		move.b	(a1,d1.w),(Events_bg+$07).w
		tst.b	(_unkFAA9).w
		beq.s	loc_5569A
		st	(Events_bg+$0A).w
		clr.b	(_unkFAA9).w

loc_5569A:
		move.w	d0,(Camera_max_X_pos).w

loc_5569E:
		move.w	d0,(Camera_X_pos).w
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,d1
		lea	(Player_1).w,a1
		bsr.s	sub_556B8
		move.w	d1,d0
		lea	(Player_2).w,a1

; =============== S U B R O U T I N E =======================================


sub_556B8:
		cmpi.b	#5,anim(a1)
		bne.s	loc_556C4
		clr.b	anim(a1)

loc_556C4:
		addi.w	#$18,d0
		cmp.w	x_pos(a1),d0
		bls.s	loc_556E8
		move.w	d0,x_pos(a1)
		move.w	#$400,ground_vel(a1)
		cmpi.w	#3,(Player_mode).w
		bne.s	locret_556F6
		move.w	#$500,ground_vel(a1)
		bra.s	locret_556F6
; ---------------------------------------------------------------------------

loc_556E8:
		addi.w	#$A8,d0
		cmp.w	x_pos(a1),d0
		bhi.s	locret_556F6
		move.w	d0,x_pos(a1)

locret_556F6:
		rts
; End of function sub_556B8

; ---------------------------------------------------------------------------

loc_556F8:
		move.l	#loc_5576A,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#$18,width_pixels(a0)
		move.w	#$80,priority(a0)
		move.w	#make_art_tile(ArtTile_MHZEndBossPillar,3,1),art_tile(a0)
		move.l	#Map_MHZEndBossMisc,mappings(a0)
		move.w	#$4238,x_pos(a0)
		move.w	#$2F0,y_pos(a0)
		bra.s	loc_5576A
; ---------------------------------------------------------------------------

loc_55732:
		move.l	#loc_5576A,(a0)
		move.b	#$44,render_flags(a0)
		move.b	#$80,height_pixels(a0)
		move.b	#$C,width_pixels(a0)
		move.w	#$380,priority(a0)
		move.w	#make_art_tile(ArtTile_MHZEndBossPillar,3,0),art_tile(a0)
		move.l	#Map_MHZEndBossMisc,mappings(a0)
		move.w	#$300,y_pos(a0)
		move.b	#1,mapping_frame(a0)

loc_5576A:
		tst.b	(Events_bg+$01).w
		bne.s	loc_55776
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_55776:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5577C:
		move.l	#loc_557C8,(a0)
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
		bcs.s	loc_557C0

loc_557B6:
		addi.w	#$80,d0
		subq.w	#1,d1
		dbf	d2,loc_557B6

loc_557C0:
		move.w	d0,priority(a0)
		move.b	d1,mapping_frame(a0)

loc_557C8:
		tst.w	(Events_bg+$0A).w
		bne.s	loc_557D4
		tst.b	(Events_bg+$01).w
		bne.s	loc_557DA

loc_557D4:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_557DA:
		move.w	(Events_bg+$06).w,d0
		tst.w	$30(a0)
		beq.s	loc_557EC
		cmpi.w	#4,d0
		bne.s	locret_55812
		moveq	#0,d0

loc_557EC:
		lsl.w	#2,d0
		add.w	$2E(a0),d0
		add.w	d0,d0
		lea	word_558C2(pc),a1
		move.w	(a1,d0.w),y_pos(a0)
		jsr	(Draw_Sprite).l
		cmpi.w	#1,$2E(a0)
		bne.s	locret_55812
		jmp	(Add_SpriteToCollisionResponseList).l
; ---------------------------------------------------------------------------

locret_55812:
		rts
; ---------------------------------------------------------------------------

loc_55814:
		move.l	#loc_5582E,(a0)
		move.w	#$380,priority(a0)
		move.w	#make_art_tile(ArtTile_MHZShipPropeller,1,1),art_tile(a0)
		move.l	#Map_MHZEndBossMisc,mappings(a0)

loc_5582E:
		lea	Ani_MHZEndPropellers(pc),a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5583E:
		addq.b	#1,$3C(a0)
		addi.l	#$C0,$38(a0)
		move.l	$38(a0),d0
		sub.l	d0,(_unkEE98).w
		tst.w	(Events_fg_4).w
		beq.s	loc_55876
		cmpi.l	#$2800,$2E(a0)
		bne.s	loc_55876
		move.w	$32(a0),d0
		move.b	$3C(a0),d1
		andi.w	#3,d1
		bne.s	loc_55888
		addq.w	#1,$32(a0)
		bra.s	loc_55888
; ---------------------------------------------------------------------------

loc_55876:
		move.l	#$2800,d0
		move.l	#$C0,d1
		jsr	(Gradual_SwingOffset).l

loc_55888:
		add.w	(_unkEEA2).w,d0
		addq.w	#5,d0
		move.w	d0,(_unkEE9C).w
		tst.b	(_unkFAA9).w
		bne.s	loc_558AC
		cmpi.w	#-$3E6,(_unkEE98).w
		bgt.s	loc_558AC
		st	(_unkFAA9).w
		st	(Events_fg_4).w
		st	(Scroll_lock).w

loc_558AC:
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	locret_558C0
		moveq	#signextendB(sfx_LargeShip),d0
		jsr	(Play_SFX).l

locret_558C0:
		rts
; ---------------------------------------------------------------------------
word_558C2:
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
word_558E8:
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
; ---------------------------------------------------------------------------

SOZ1_ScreenInit:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

SOZ1_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

SOZ1_BackgroundInit:
		move.w	(a3),$1C(a3)
		movea.w	$18(a3),a1
		move.b	#$FD,$D(a1)
		jsr	sub_55D56(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	(Refresh_PlaneFull).l
		jmp	loc_55DF2(pc)
; ---------------------------------------------------------------------------

SOZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	SOZ1_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

SOZ1_BackgroundEvent_Index:
		bra.w	loc_55A9A
; ---------------------------------------------------------------------------
		bra.w	loc_55B04
; ---------------------------------------------------------------------------
		bra.w	loc_55B70
; ---------------------------------------------------------------------------
		bra.w	loc_55BCE
; ---------------------------------------------------------------------------
		bra.w	loc_55C26
; ---------------------------------------------------------------------------
		bra.w	loc_55C84
; ---------------------------------------------------------------------------

loc_55A9A:
		tst.w	(Events_fg_5).w
		beq.s	loc_55ACE
		clr.w	(Events_fg_5).w
		move.w	#-8,(_unkEE9C).w
		st	(Screen_shake_flag).w
		jsr	sub_55DB6(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_55B08
; ---------------------------------------------------------------------------

loc_55ACE:
		move.w	#$B20,d0
		cmpi.w	#$4000,(Player_1+x_pos).w
		blo.s	loc_55ADE
		move.w	#$960,d0

loc_55ADE:
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		jsr	sub_55E96(pc)
		jsr	sub_55D56(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l
		jmp	loc_55DF2(pc)
; ---------------------------------------------------------------------------

loc_55B04:
		jsr	sub_55DB6(pc)

loc_55B08:
		move.w	(Camera_X_pos_BG_copy).w,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.w	loc_55BA2
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(SOZ1_16x16_Custom_Kos).l,a1
		lea	(Block_table+$EA0).w,a2
		jsr	(Queue_Kos).l
		lea	(ArtKosM_SOZ1_Custom).l,a1
		move.w	#tiles_to_bytes($315),d2
		jsr	(Queue_Kos_Module).l
		movem.l	(sp)+,d7-a0/a2-a3
		jsr	(AllocateObject).l
		bne.s	loc_55B6A
		move.l	#loc_55F48,(a1)
		jsr	(CreateNewSprite4).l
		bne.s	loc_55B6A
		move.l	#loc_55F98,(a1)
		jsr	(CreateNewSprite4).l
		bne.s	loc_55B6A
		move.l	#loc_55FDA,(a1)

loc_55B6A:
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_55BA2
; ---------------------------------------------------------------------------

loc_55B70:
		cmpi.w	#$55,(Events_fg_5).w
		bne.s	loc_55B9E
		move.w	#$4378,d0
		cmp.w	(Player_1+x_pos).w,d0
		bhi.s	loc_55B9E
		cmpi.w	#$9A8,(Player_1+y_pos).w
		blo.s	loc_55B9E
		tst.w	(Player_mode).w
		bne.s	loc_55BB4
		cmp.w	(Player_2+x_pos).w,d0
		blo.s	loc_55BB4
		cmpi.w	#$9A8,(Player_2+y_pos).w
		bhs.s	loc_55BB4

loc_55B9E:
		jsr	sub_55D94(pc)

loc_55BA2:
		jsr	(DrawBGAsYouMove).l
		jsr	sub_55EBE(pc)
		jsr	sub_55E4C(pc)
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

loc_55BB4:
		move.w	#$10-1,(Palette_fade_info).w
		move.w	#$15,(Events_bg+$04).w
		move.w	#$10,(Events_bg+$06).w
		st	(Palette_fade_timer).w
		addq.w	#4,(Events_routine_bg).w

loc_55BCE:
		tst.w	(Events_bg+$06).w
		beq.s	loc_55BE0
		subq.w	#1,(Events_bg+$06).w
		bne.s	loc_55BFE
		st	(Events_bg+$02).w
		bra.s	loc_55BFE
; ---------------------------------------------------------------------------

loc_55BE0:
		tst.w	(Events_bg+$02).w
		bne.s	loc_55BFE
		btst	#0,(Level_frame_counter+1).w
		beq.s	loc_55BFE
		move.l	a0,-(sp)
		jsr	(Pal_ToBlack).l
		movea.l	(sp)+,a0
		subq.w	#1,(Events_bg+$04).w
		bmi.s	loc_55C10

loc_55BFE:
		jsr	sub_55D94(pc)
		jsr	(DrawBGAsYouMove).l
		jsr	sub_55EBE(pc)
		jmp	sub_55E4C(pc)
; ---------------------------------------------------------------------------


loc_55C10:
		move.w	#$4020-1,(Palette_fade_info).w
		move.w	#$15,(Events_bg+$04).w
		move.w	#8,(Events_bg+$06).w
		addq.w	#4,(Events_routine_bg).w

loc_55C26:
		tst.w	(Events_bg+$06).w
		beq.s	loc_55C32
		subq.w	#1,(Events_bg+$06).w
		bra.s	loc_55C4A
; ---------------------------------------------------------------------------

loc_55C32:
		btst	#0,(Level_frame_counter+1).w
		beq.s	loc_55C4A
		move.l	a0,-(sp)
		jsr	(Pal_ToBlack).l
		movea.l	(sp)+,a0
		subq.w	#1,(Events_bg+$04).w
		bmi.s	loc_55C4E

loc_55C4A:
		jmp	sub_55E4C(pc)
; ---------------------------------------------------------------------------

loc_55C4E:
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(SOZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$EA0).w,a2
		jsr	(Queue_Kos).l
		lea	(ArtKosM_SOZ2_Secondary).l,a1
		move.w	#tiles_to_bytes($315),d2
		jsr	(Queue_Kos_Module).l
		moveq	#PLCID_2C,d0
		jsr	(Load_PLC).l
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(Events_routine_bg).w
		rts
; ---------------------------------------------------------------------------

loc_55C84:
		tst.b	(Kos_modules_left).w
		bne.w	locret_55D54
		move.w	#$801,(Current_zone_and_act).w
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(Respawn_table_keep).w
		jsr	Clear_Switches(pc)
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		moveq	#PalID_SonicTails,d0
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_55CC6
		moveq	#PalID_Knuckles,d0

loc_55CC6:
		jsr	(LoadPalette).l
		moveq	#PalID_SOZ2,d0
		jsr	(LoadPalette).l
		moveq	#PalID_SOZ2,d0
		jsr	(LoadPalette_Immediate).l
		movem.l	(sp)+,d7-a0/a2-a3
		jsr	sub_55EFC(pc)
		lea	(Normal_palette_line_3).w,a1
		moveq	#bytesToLcnt($40),d0

loc_55CEA:
		clr.l	(a1)+
		dbf	d0,loc_55CEA
		move.w	(Player_1+x_pos).w,d2
		sub.w	(Player_2+x_pos).w,d2
		move.w	(Player_1+y_pos).w,d3
		sub.w	(Player_2+y_pos).w,d3
		move.w	#$140,d0
		move.w	#$3AC,d1
		move.w	d0,(Player_1+x_pos).w
		move.w	d1,(Player_1+y_pos).w
		sub.w	d2,d0
		sub.w	d3,d1
		move.w	d0,(Player_2+x_pos).w
		move.w	d1,(Player_2+y_pos).w
		move.w	#$A0,d0
		move.w	#$34C,d1
		move.w	d0,(Camera_X_pos).w
		move.w	d1,(Camera_Y_pos).w
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d1,(Camera_Y_pos_copy).w
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w
		move.w	d1,(Camera_min_Y_pos).w
		move.w	d1,(Camera_max_Y_pos).w
		move.w	d1,(Camera_target_max_Y_pos).w
		clr.l	(Events_bg+$02).w
		clr.w	(Events_fg_5).w
		clr.w	(Events_routine_bg).w

locret_55D54:
		rts

; =============== S U B R O U T I N E =======================================


sub_55D56:
		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#4,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		asr.l	#1,d1
		swap	d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		swap	d0
		swap	d1
		move.w	d1,(Events_bg+$10).w
		swap	d1
		asr.l	#1,d1
		lea	(HScroll_table).w,a1
		moveq	#7-1,d2

loc_55D86:
		swap	d0
		move.w	d0,(a1)+
		swap	d0
		add.l	d1,d0
		dbf	d2,loc_55D86
		rts
; End of function sub_55D56


; =============== S U B R O U T I N E =======================================


sub_55D94:
		tst.w	(Screen_shake_flag).w
		bpl.s	sub_55DB6
		move.w	(Level_frame_counter).w,d0
		andi.w	#3,d0
		beq.s	sub_55DB6
		addq.w	#1,(_unkEE9C).w
		cmpi.w	#$280,(_unkEE9C).w
		blt.s	sub_55DB6
		move.w	#8,(Screen_shake_flag).w
; End of function sub_55D94


; =============== S U B R O U T I N E =======================================


sub_55DB6:
		tst.w	(Screen_shake_flag).w
		bpl.s	loc_55DD0
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	loc_55DD0
		moveq	#signextendB(sfx_Rumble2),d0
		jsr	(Play_SFX).l

loc_55DD0:
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$900,d0
		add.w	(_unkEE9C).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$3CD0,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	d0,(Events_bg+$10).w
		rts
; End of function sub_55DB6

; ---------------------------------------------------------------------------

loc_55DF2:
		lea	(HScroll_table+$010).w,a1
		lea	AIZ2_SOZ1_LRZ3_FGDeformDelta(pc),a6
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	#$DF,d1
		move.w	(Level_frame_counter).w,d2
		asr.w	#1,d2
		add.w	d0,d2
		add.w	d0,d2
		andi.w	#$3E,d2
		adda.w	d2,a6
		move.w	(Camera_X_pos_copy).w,d6
		neg.w	d6
		jsr	MakeFGDeformArray(pc)
		lea	(H_scroll_buffer).w,a1
		lea	(HScroll_table+$010).w,a2
		lea	word_560DC(pc),a4
		lea	(HScroll_table).w,a5
		lea	AIZ2_SOZ1_LRZ3_FGDeformDelta(pc),a6
		move.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	#$DF,d1
		move.w	(Level_frame_counter).w,d2
		asr.w	#1,d2
		add.w	d0,d2
		add.w	d0,d2
		andi.w	#$3E,d2
		adda.w	d2,a6
		jmp	ApplyFGandBGDeformation(pc)

; =============== S U B R O U T I N E =======================================


sub_55E4C:
		lea	(H_scroll_buffer).w,a1
		lea	AIZ2_SOZ1_LRZ3_FGDeformDelta(pc),a6
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Level_frame_counter).w,d1
		asr.w	#1,d1
		add.w	d0,d1
		add.w	d0,d1
		andi.w	#$3E,d1
		adda.w	d1,a6
		move.w	(Camera_X_pos_copy).w,d0
		neg.w	d0
		move.w	(Camera_X_pos_BG_copy).w,d1
		neg.w	d1
		move.w	#$70-1,d2

loc_55E78:
		move.w	(a6)+,d3
		move.w	d3,d4
		add.w	d0,d3
		add.w	d1,d4
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		move.w	(a6)+,d3
		move.w	d3,d4
		add.w	d0,d3
		add.w	d1,d4
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		dbf	d2,loc_55E78
		rts
; End of function sub_55E4C


; =============== S U B R O U T I N E =======================================


sub_55E96:
		move.w	(Camera_max_Y_pos).w,d0
		cmpi.w	#$960,d0
		bne.s	locret_55EBC
		cmp.w	(Camera_Y_pos).w,d0
		bhi.s	locret_55EBC
		move.w	d0,(Camera_min_Y_pos).w
		cmpi.w	#$4310,(Camera_X_pos).w
		blo.s	locret_55EBC
		move.w	#$4180,(Camera_min_X_pos).w
		st	(Events_fg_5).w

locret_55EBC:
		rts
; End of function sub_55E96


; =============== S U B R O U T I N E =======================================


sub_55EBE:
		move.w	(Events_bg+$00).w,d0
		beq.s	locret_55EFA
		clr.w	(Events_bg+$00).w
		movea.w	$18(a3),a1
		move.b	d0,$D(a1)
		cmpi.w	#$540,(Camera_X_pos_BG_copy).w
		blo.s	locret_55EFA
		move.w	#$6A0,d1
		move.w	#$320,d0
		moveq	#5,d6
		moveq	#6-1,d2

loc_55EE4:
		movem.w	d0-d2/d6,-(sp)
		jsr	(Setup_TileRowDraw).l
		movem.w	(sp)+,d0-d2/d6
		addi.w	#$10,d0
		dbf	d2,loc_55EE4

locret_55EFA:
		rts
; End of function sub_55EBE


; =============== S U B R O U T I N E =======================================


sub_55EFC:
		lea	(Normal_palette_line_3+$2).w,a1
		lea	(Target_palette_line_3+$2).w,a5
		lea	word_560EA(pc),a6
		moveq	#$B-1,d0

loc_55F0A:
		move.w	(a6),(a1)+
		move.w	(a6)+,(a5)+
		dbf	d0,loc_55F0A
		lea	(Normal_palette_line_4+$2).w,a1
		lea	(Target_palette_line_4+$2).w,a5
		lea	word_56100(pc),a6
		moveq	#$F-1,d0

loc_55F20:
		move.w	(a6),(a1)+
		move.w	(a6)+,(a5)+
		dbf	d0,loc_55F20
		move.b	#5,(SOZ_darkness_level).w
		move.w	#(30*60)-1,(Palette_cycle_counter1).w
		move.b	#0,(Palette_cycle_counters+$00).w
		move.w	#4,(Palette_cycle_counters+$06).w
		move.w	#$D0,(Palette_cycle_counters+$02).w
		rts
; End of function sub_55EFC

; ---------------------------------------------------------------------------

loc_55F48:
		moveq	#0,d0
		move.b	routine(a0),d0
		jmp	loc_55F52(pc,d0.w)
; ---------------------------------------------------------------------------

loc_55F52:
		bra.w	loc_55F5E
; ---------------------------------------------------------------------------
		bra.w	loc_55F6E
; ---------------------------------------------------------------------------
		bra.w	loc_55F7C
; ---------------------------------------------------------------------------

loc_55F5E:
		tst.w	(Screen_shake_flag).w
		bne.s	locret_55F96
		move.w	#60,$2E(a0)
		addq.b	#4,routine(a0)

loc_55F6E:
		subq.w	#1,$2E(a0)
		bne.s	locret_55F96
		st	(Events_bg+$02).w
		addq.b	#4,routine(a0)

loc_55F7C:
		tst.w	(Events_bg+$02).w
		bne.s	locret_55F96
		jsr	(AllocateObject).l
		bne.s	loc_55F90
		move.l	#Obj_SOZMiniboss,(a1)

loc_55F90:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locret_55F96:
		rts
; ---------------------------------------------------------------------------

loc_55F98:
		move.l	#loc_55FBE,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$24,width_pixels(a0)
		move.w	#$200,priority(a0)
		move.l	#Map_SOZ1EndDoor,mappings(a0)
		move.w	#$A00,y_pos(a0)

loc_55FBE:
		tst.b	(Current_act).w
		beq.s	loc_55FCA
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_55FCA:
		move.w	(Camera_X_pos).w,x_pos(a0)
		st	(Spritemask_flag).w
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_55FDA:
		move.l	#loc_56012,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$24,width_pixels(a0)
		move.w	#$380,priority(a0)
		move.w	#make_art_tile($029,2,1),art_tile(a0)
		move.l	#Map_SOZ1EndDoor,mappings(a0)
		move.w	#$439C,x_vel(a0)
		move.w	#$9D4,y_vel(a0)
		move.b	#1,mapping_frame(a0)

loc_56012:
		bclr	#7,render_flags(a0)
		tst.w	(Events_bg+$02).w
		bne.s	loc_56020
		rts
; ---------------------------------------------------------------------------

loc_56020:
		moveq	#signextendB(sfx_DoorOpen),d0
		jsr	(Play_SFX).l
		move.w	#$F6,(Events_bg+$00).w
		move.l	#loc_56034,(a0)

loc_56034:
		moveq	#1,d0
		bsr.s	sub_560A2
		cmpi.w	#$58,$2E(a0)
		blo.s	loc_56050
		move.w	#$58,$2E(a0)
		clr.w	(Events_bg+$02).w
		move.l	#loc_56056,(a0)

loc_56050:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_56056:
		tst.b	(Current_act).w
		beq.s	loc_56062
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_56062:
		bclr	#7,render_flags(a0)
		tst.w	(Events_bg+$02).w
		bne.s	loc_56070
		rts
; ---------------------------------------------------------------------------

loc_56070:
		moveq	#signextendB(sfx_DoorOpen),d0
		jsr	(Play_SFX).l
		move.l	#loc_5607E,(a0)

loc_5607E:
		moveq	#-1,d0
		bsr.s	sub_560A2
		tst.w	$2E(a0)
		bpl.s	loc_5609C
		clr.w	$2E(a0)
		move.w	#$FD,(Events_bg+$00).w
		clr.w	(Events_bg+$02).w
		move.l	#loc_56012,(a0)

loc_5609C:
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_560A2:
		move.w	(Level_frame_counter).w,d1
		andi.w	#3,d1
		bne.s	loc_560AE
		add.w	d0,d0

loc_560AE:
		add.w	d0,$2E(a0)
		move.w	$1A(a0),d0
		add.w	$2E(a0),d0
		move.w	d0,y_pos(a0)
		lea	ScreenShakeArray2(pc),a1
		move.w	$2E(a0),d0
		andi.w	#$3F,d0
		move.b	(a1,d0.w),d0
		andi.w	#1,d0
		add.w	$18(a0),d0
		move.w	d0,x_pos(a0)
		rts
; End of function sub_560A2

; ---------------------------------------------------------------------------
word_560DC:
		dc.w   $110,     8,     8,     8,     8,     8, $7FFF
word_560EA:
		dc.w   $C46,  $824,  $804,  $402,  $202,  $200,     0,  $422,  $402,  $200,   $40
word_56100:
		dc.w   $6AE,  $664,  $422,  $402,  $200,     0,     0,  $EEE,  $466,  $224,     0,   $46,  $6EE,  $48C,  $26A
Map_SOZ1EndDoor:
		include "Levels/SOZ/Misc Object Data/Map - Act 1 End Door.asm"
; ---------------------------------------------------------------------------

SOZ2_ScreenInit:
		move.w	#$7FF,(Screen_Y_wrap_value).w
		move.w	#$7F0,(Camera_Y_pos_mask).w
		move.w	#$3C,(Layout_row_index_mask).w
		move.w	#8,(Events_routine_fg).w
		cmpi.w	#$4E80,(Player_1+x_pos).w
		blo.s	loc_561B0
		jsr	sub_5622C(pc)

loc_561B0:
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

SOZ2_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	(Events_routine_fg).w,d0
		jmp	SOZ2_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

SOZ2_ScreenEvent_Index:
		bra.w	loc_561D8
; ---------------------------------------------------------------------------
		bra.w	loc_56206
; ---------------------------------------------------------------------------
		bra.w	loc_5621A
; ---------------------------------------------------------------------------

loc_561D8:
		move.w	#$7FF,(Screen_Y_wrap_value).w
		move.w	#$7F0,(Camera_Y_pos_mask).w
		move.w	#$3C,(Layout_row_index_mask).w
		jsr	(Reset_TileOffsetPositionActual).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_fg).w

loc_56206:
		move.w	(Camera_X_pos_copy).w,d1
		move.w	(Camera_Y_pos_copy).w,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	loc_5621A
		addq.w	#4,(Events_routine_fg).w

loc_5621A:
		tst.w	(Events_fg_4).w
		beq.s	loc_56226
		clr.w	(Events_fg_4).w
		bsr.s	sub_5622C

loc_56226:
		jmp	(DrawTilesAsYouMove).l

; =============== S U B R O U T I N E =======================================


sub_5622C:
		movea.w	$1C(a3),a1
		lea	$AB(a1),a5
		lea	$95(a1),a1
		move.b	(a5)+,(a1)+
		move.b	(a5)+,(a1)+
		move.b	(a5)+,(a1)+
		move.b	(a5)+,(a1)+
		movea.w	$28(a3),a1
		lea	$AB(a1),a5
		lea	$8C(a1),a1
		move.w	-8(a3),d0
		subi.w	#9,d0
		moveq	#4-1,d1

loc_56256:
		moveq	#8,d2

loc_56258:
		move.b	(a5)+,(a1)+
		dbf	d2,loc_56258
		adda.w	d0,a1
		adda.w	d0,a5
		dbf	d1,loc_56256
		rts
; End of function sub_5622C

; ---------------------------------------------------------------------------

SOZ2_BackgroundInit:
		jsr	sub_5697E(pc)
		moveq	#$10,d0
		cmpi.w	#$2980,(Player_1+x_pos).w
		blo.s	loc_56278
		moveq	#$20,d0

loc_56278:
		move.w	d0,(Events_routine_bg).w
		jsr	sub_566D2(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		moveq	#0,d1
		jsr	(Refresh_PlaneFull).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

SOZ2_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	SOZ2_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

SOZ2_BackgroundEvent_Index:
		bra.w	loc_562D0	; $00
; ---------------------------------------------------------------------------
		bra.w	loc_56300	; $04
; ---------------------------------------------------------------------------
		bra.w	loc_56324	; $08
; ---------------------------------------------------------------------------
		bra.w	loc_56366	; $0C
; ---------------------------------------------------------------------------
		bra.w	loc_563A6	; $10
; ---------------------------------------------------------------------------
		bra.w	loc_5641C	; $14	Rising sand #1
; ---------------------------------------------------------------------------
		bra.w	loc_5645E	; $18	Rising sand #2
; ---------------------------------------------------------------------------
		bra.w	loc_564B8	; $1C
; ---------------------------------------------------------------------------
		bra.w	loc_564D4	; $20
; ---------------------------------------------------------------------------
		bra.w	loc_565C6	; $24
; ---------------------------------------------------------------------------
		bra.w	loc_565DE	; $28
; ---------------------------------------------------------------------------
		bra.w	loc_56676	; $2C
; ---------------------------------------------------------------------------
		bra.w	loc_566A4	; $30
; ---------------------------------------------------------------------------

loc_562D0:
		cmpi.w	#8,(Events_routine_fg).w
		blo.s	locret_562FE
		jsr	sub_5697E(pc)
		jsr	sub_566D2(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_56304
; ---------------------------------------------------------------------------

locret_562FE:
		rts
; ---------------------------------------------------------------------------

loc_56300:
		jsr	sub_566D2(pc)

loc_56304:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.w	loc_563C0
		move.w	#$10-1,(Palette_fade_info).w
		move.w	#$15,(Events_bg+$00).w
		addq.w	#4,(Events_routine_bg).w

loc_56324:
		btst	#0,(Level_frame_counter+1).w
		beq.s	loc_563A6
		cmpi.w	#5,(Events_bg+$00).w
		bne.s	loc_56346
		jsr	(AllocateObject).l
		bne.s	loc_56346
		move.l	#Obj_TitleCard,(a1)
		st	$3E(a1)

loc_56346:
		move.l	a0,-(sp)
		jsr	(Pal_FromBlack).l
		movea.l	(sp)+,a0
		subq.w	#1,(Events_bg+$00).w
		bpl.s	loc_563A6
		move.w	#$4020-1,(Palette_fade_info).w
		move.w	#$15,(Events_bg+$00).w
		addq.w	#4,(Events_routine_bg).w

loc_56366:
		btst	#0,(Level_frame_counter+1).w
		beq.s	loc_563A6
		move.l	a0,-(sp)
		jsr	(Pal_FromBlack).l
		movea.l	(sp)+,a0
		subq.w	#1,(Events_bg+$00).w
		bpl.s	loc_563A6
		move.l	#$6000,d0
		move.l	d0,(Camera_min_X_pos).w
		move.l	d0,(Camera_target_min_X_pos).w
		move.l	#-$FFF800,d0
		move.l	d0,(Camera_min_Y_pos).w
		move.l	d0,(Camera_target_min_Y_pos).w
		clr.w	(Palette_fade_timer).w
		clr.w	(Ctrl_1_locked).w
		addq.w	#4,(Events_routine_bg).w

loc_563A6:
		jsr	sub_5699A(pc)
		beq.s	loc_563B6
		move.w	#$18,(Events_routine_bg).w
		bra.w	loc_56484
; ---------------------------------------------------------------------------

loc_563B6:
		tst.w	(Events_fg_5).w
		bne.s	loc_563D8
		jsr	sub_566D2(pc)

loc_563C0:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

loc_563D8:
		clr.w	(Events_fg_5).w
		addq.w	#4,(Events_routine_bg).w
		moveq	#0,d0
		move.w	#$80,d0
		cmpi.w	#$400,(Player_1+y_pos).w
		blo.s	loc_563F6
		addq.w	#4,(Events_routine_bg).w
		move.w	#$3E0,d0

loc_563F6:
		swap	d0
		move.l	d0,(_unkEE9C).w
		jsr	sub_566E8(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		subi.w	#$10,(Camera_Y_pos_BG_rounded).w
		move.w	#$10,(Special_events_routine).w
		cmpi.w	#$14,(Events_routine_bg).w
		beq.s	loc_56440
		bra.s	loc_56474
; ---------------------------------------------------------------------------

loc_5641C:
		jsr	sub_5699A(pc)
		beq.s	loc_5642A
		move.w	#$18,(Events_routine_bg).w
		bra.s	loc_56484
; ---------------------------------------------------------------------------

loc_5642A:
		tst.w	(Events_fg_5).w
		bne.s	loc_56450
		cmpi.w	#$400,(_unkEE9C).w
		blo.s	loc_5643C
		clr.w	(Special_events_routine).w

loc_5643C:
		jsr	sub_566E8(pc)

loc_56440:
		jsr	(DrawBGAsYouMove).l
		jsr	(PlainDeformation).l
		jmp	Go_CheckPlayerRelease(pc)
; ---------------------------------------------------------------------------

loc_56450:
		clr.w	(Events_fg_5).w
		move.w	#$10,(Special_events_routine).w
		addq.w	#4,(Events_routine_bg).w

loc_5645E:
		jsr	sub_5699A(pc)
		bne.s	loc_56484
		cmpi.w	#$A00,(_unkEE9C).w
		blo.s	loc_56470
		clr.w	(Special_events_routine).w

loc_56470:
		jsr	sub_566E8(pc)

loc_56474:
		jsr	(DrawBGAsYouMove).l
		jsr	(PlainDeformation).l
		jmp	Go_CheckPlayerRelease(pc)
; ---------------------------------------------------------------------------

loc_56484:
		move.w	(Camera_X_pos_BG_copy).w,(Events_bg+$02).w
		move.w	(Camera_Y_pos_BG_copy).w,(Events_bg+$04).w
		jsr	sub_566D2(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		move.w	#$1F0,(Draw_delayed_position).w
		move.w	#$1F,(Draw_delayed_rowcount).w
		clr.w	(Events_fg_5).w
		clr.w	(Special_events_routine).w
		clr.b	(Background_collision_flag).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_564BC
; ---------------------------------------------------------------------------

loc_564B8:
		jsr	sub_566D2(pc)

loc_564BC:
		move.w	(Camera_Y_pos_BG_copy).w,d1
		moveq	#0,d2
		jsr	(Draw_PlaneHorzRightToLeft).l
		bpl.s	loc_564E8
		clr.w	(Events_bg+$02).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_564E8
; ---------------------------------------------------------------------------

loc_564D4:
		cmpi.w	#$5000,(Player_1+x_pos).w
		blo.s	loc_564E4
		cmpi.w	#$500,(Camera_Y_pos).w
		bhs.s	loc_56510

loc_564E4:
		jsr	sub_566D2(pc)

loc_564E8:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l
		move.w	(Events_bg+$02).w,d0
		beq.s	loc_5650A
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	(Events_bg+$04).w,(Camera_Y_pos_BG_copy).w

loc_5650A:
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

loc_56510:
		move.w	#$5250,(Events_bg+$0C).w
		move.w	#$6D8,(Events_bg+$0E).w
		movea.w	(a3),a1
		move.w	-8(a3),d0
		subq.w	#4,d0
		moveq	#0,d1
		moveq	#$10-1,d2

loc_56528:
		moveq	#4-1,d3

loc_5652A:
		move.b	(a1),4(a1)
		move.b	d1,(a1)+
		dbf	d3,loc_5652A
		adda.w	d0,a1
		dbf	d2,loc_56528
		lea	(HScroll_table).w,a1
		moveq	#$80-1,d2

loc_56540:
		move.l	d1,(a1)+
		dbf	d2,loc_56540
		jsr	sub_56706(pc)
		lea	(HScroll_table).w,a1
		moveq	#$D-1,d0

loc_56550:
		move.w	(a1)+,(a1)
		andi.w	#$FFF0,(a1)+
		dbf	d0,loc_56550
		move.w	#$500,(Camera_min_Y_pos).w
		move.w	#$680,d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		move.w	#$5140,(Camera_max_X_pos).w
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(SOZ2_16x16_Custom_Kos).l,a1
		lea	(Block_table+$EA0).w,a2
		jsr	(Queue_Kos).l
		lea	(ArtKosM_SOZ2_Custom).l,a1
		move.w	#tiles_to_bytes($315),d2
		jsr	(Queue_Kos_Module).l
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$7FFF,(Palette_cycle_counter1).w
		move.b	#0,(SOZ_darkness_level).w
		move.w	(Palette_cycle_counters+$06).w,d0
		neg.b	d0
		move.b	d0,(Palette_cycle_counters+$00).w
		move.w	#0,(Palette_cycle_counters+$08).w
		move.b	#$7F,(Anim_Counters).w
		jsr	sub_56A12(pc)
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_565F4
; ---------------------------------------------------------------------------

loc_565C6:
		move.w	(Camera_Y_pos_copy).w,d0
		cmp.w	(Camera_min_Y_pos).w,d0
		beq.s	loc_565D4
		move.w	d0,(Camera_min_Y_pos).w

loc_565D4:
		cmp.w	(Camera_max_Y_pos).w,d0
		bne.s	loc_565DE
		addq.w	#4,(Events_routine_bg).w

loc_565DE:
		move.w	#$7FFF,(Palette_cycle_counter1).w
		move.b	#$7F,(Anim_Counters).w
		tst.w	(Events_fg_5).w
		bmi.s	loc_5661A
		jsr	sub_56706(pc)

loc_565F4:
		lea	SOZ2_BGDrawArray(pc),a4
		lea	(HScroll_table).w,a5
		moveq	#$20,d6
		moveq	#$D,d5
		jsr	(Draw_BG).l
		lea	SOZ2_BGDrawArray(pc),a4
		lea	(HScroll_table+$100).w,a5
		jsr	(ApplyDeformation).l
		jmp	(ShakeScreen_Setup).l
; ---------------------------------------------------------------------------

loc_5661A:
		move.w	(Camera_X_pos_BG_copy).w,d0
		subi.w	#$100,d0
		move.w	d0,(Events_bg+$02).w
		jsr	sub_56964(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(SOZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$EA0).w,a2
		jsr	(Queue_Kos).l
		lea	(ArtKosM_SOZ2_Secondary).l,a1
		move.w	#tiles_to_bytes($315),d2
		jsr	(Queue_Kos_Module).l
		moveq	#PalID_SOZ2,d0
		jsr	(LoadPalette_Immediate).l
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(Events_routine_bg).w

loc_56676:
		tst.b	(Kos_modules_left).w
		bne.s	loc_566BC
		jsr	sub_56964(pc)
		move.w	#$200,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	loc_566A8
		clr.w	(Events_bg+$02).w
		move.w	#$52C0,(Camera_max_X_pos).w
		clr.b	(Anim_Counters).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_566A8
; ---------------------------------------------------------------------------

loc_566A4:
		jsr	sub_56964(pc)

loc_566A8:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	#$200,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l

loc_566BC:
		move.w	(Events_bg+$02).w,d0
		beq.s	loc_566C6
		move.w	d0,(Camera_X_pos_BG_copy).w

loc_566C6:
		jsr	(PlainDeformation).l
		jmp	(ShakeScreen_Setup).l

; =============== S U B R O U T I N E =======================================


sub_566D2:
		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		asr.w	#1,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; End of function sub_566D2


; =============== S U B R O U T I N E =======================================


sub_566E8:
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$2E0,d0
		add.w	(_unkEE9C).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$1930,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; End of function sub_566E8


; =============== S U B R O U T I N E =======================================


sub_56706:
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$250,d0
		move.w	#$6D8,d1
		sub.w	(Events_bg+$0E).w,d1
		add.w	d1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$4010,d0
		move.w	#$5250,d1
		sub.w	(Events_bg+$0C).w,d1
		add.w	d1,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		cmpi.b	#6,(Player_1+routine).w
		bhs.w	loc_56936
		move.w	(Events_bg+$08).w,d0
		jmp	loc_56744(pc,d0.w)
; ---------------------------------------------------------------------------

loc_56744:
		bra.w	loc_5675C
; ---------------------------------------------------------------------------
		bra.w	loc_5678A
; ---------------------------------------------------------------------------
		bra.w	loc_567B0
; ---------------------------------------------------------------------------
		bra.w	loc_5680A
; ---------------------------------------------------------------------------
		bra.w	loc_5687C
; ---------------------------------------------------------------------------
		bra.w	loc_56904
; ---------------------------------------------------------------------------

loc_5675C:
		jsr	loc_568DE(pc)
		tst.w	(Events_bg+$0A).w
		beq.w	loc_56936
		lea	(HScroll_table+$134).w,a1
		moveq	#-1,d0
		moveq	#9-1,d1

loc_56770:
		move.w	d0,-(a1)
		subq.w	#1,d0
		dbf	d1,loc_56770
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l
		move.w	#3,(Events_bg+$06).w
		addq.w	#4,(Events_bg+$08).w

loc_5678A:
		jsr	loc_568DE(pc)
		subq.w	#1,(Events_bg+$06).w
		bpl.w	loc_56936
		lea	(HScroll_table+$134).w,a1
		moveq	#-1,d0
		moveq	#9-1,d1

loc_5679E:
		move.w	d0,-(a1)
		subq.w	#2,d0
		dbf	d1,loc_5679E
		move.w	#8,(Events_bg+$06).w
		addq.w	#4,(Events_bg+$08).w

loc_567B0:
		jsr	loc_568DE(pc)
		subq.w	#1,(Events_bg+$06).w
		bpl.w	loc_56936
		lea	(HScroll_table+$184).w,a1
		lea	$3E(a1),a5
		lea	word_56AE2(pc),a6
		move.w	(Events_bg+$0A).w,d0
		sub.w	(Camera_Y_pos_copy).w,d0
		add.w	(Camera_Y_pos_BG_copy).w,d0
		subi.w	#$440,d0
		bcc.s	loc_567DC
		moveq	#0,d0

loc_567DC:
		lsr.w	#3,d0
		andi.w	#$FFFE,d0
		cmpi.w	#$10,d0
		bls.s	loc_567EA
		moveq	#$10,d0

loc_567EA:
		suba.w	d0,a6
		moveq	#9-1,d1

loc_567EE:
		move.l	#$80000,(a1)+
		move.w	(a6)+,(a5)+
		dbf	d1,loc_567EE
		clr.w	(Events_bg+$00).w
		moveq	#signextendB(sfx_Collapse),d0
		jsr	(Play_SFX).l
		addq.w	#4,(Events_bg+$08).w

loc_5680A:
		jsr	loc_568DE(pc)
		lea	(HScroll_table+$144).w,a1
		lea	$40(a1),a5
		lea	$3E(a5),a6
		moveq	#9,d0
		moveq	#9-1,d1

loc_5681E:
		tst.b	(a6)
		beq.s	loc_5682C
		bpl.s	loc_56828
		subq.w	#1,d0
		bra.s	loc_5683A
; ---------------------------------------------------------------------------

loc_56828:
		subq.b	#1,(a6)
		bra.s	loc_5683A
; ---------------------------------------------------------------------------

loc_5682C:
		move.l	(a5),d2
		sub.l	d2,(a1)
		subi.l	#$2800,(a5)
		bpl.s	loc_5683A
		st	(a6)

loc_5683A:
		addq.w	#4,a1
		addq.w	#4,a5
		addq.w	#2,a6
		dbf	d1,loc_5681E
		tst.w	d0
		beq.s	loc_56868
		cmpi.w	#9,d0
		beq.w	loc_56936
		tst.w	(Events_bg+$00).w
		bne.w	loc_56936
		moveq	#signextendB(sfx_BossRecovery),d0
		jsr	(Play_SFX).l
		st	(Events_bg+$00).w
		bra.w	loc_56936
; ---------------------------------------------------------------------------

loc_56868:
		lea	(HScroll_table+$122).w,a1
		moveq	#9-1,d1

loc_5686E:
		clr.w	(a1)+
		dbf	d1,loc_5686E
		clr.w	(Events_bg+$06).w
		addq.w	#4,(Events_bg+$08).w

loc_5687C:
		jsr	loc_568DE(pc)
		tst.w	(Events_bg+$06).w
		beq.s	loc_5689A
		subq.w	#1,(Events_bg+$06).w
		bne.w	loc_56936
		clr.w	(Events_bg+$0A).w
		clr.w	(Events_bg+$08).w
		bra.w	loc_56936
; ---------------------------------------------------------------------------

loc_5689A:
		lea	(HScroll_table+$144).w,a1
		lea	$40(a1),a5
		lea	$3F(a5),a6
		moveq	#9,d0
		moveq	#9-1,d1

loc_568AA:
		tst.b	(a6)
		beq.s	loc_568B8
		bpl.s	loc_568B4
		subq.w	#1,d0
		bra.s	loc_568C8
; ---------------------------------------------------------------------------

loc_568B4:
		subq.b	#1,(a6)
		bra.s	loc_568C8
; ---------------------------------------------------------------------------

loc_568B8:
		move.l	(a5),d2
		subi.l	#$2800,(a5)
		sub.l	d2,(a1)
		bmi.s	loc_568C8
		clr.l	(a1)
		st	(a6)

loc_568C8:
		addq.w	#4,a1
		addq.w	#4,a5
		addq.w	#2,a6
		dbf	d1,loc_568AA
		tst.w	d0
		bne.s	loc_56936
		move.w	#$F,(Events_bg+$06).w
		bra.s	loc_56936
; ---------------------------------------------------------------------------

loc_568DE:
		tst.w	(Events_fg_5).w
		bne.s	loc_568E6
		rts
; ---------------------------------------------------------------------------

loc_568E6:
		lea	(HScroll_table+$1C2).w,a1
		moveq	#0,d0
		moveq	#$C-1,d1

loc_568EE:
		move.w	d0,(a1)+
		addq.w	#5,d0
		dbf	d1,loc_568EE
		move.w	#$5140,(Camera_max_X_pos).w
		move.w	#$14,(Events_bg+$08).w
		addq.w	#4,sp

loc_56904:
		lea	(HScroll_table+$144).w,a1
		lea	$7E(a1),a5
		moveq	#$C,d0
		moveq	#$C-1,d1

loc_56910:
		tst.w	(a5)
		beq.s	loc_56918
		subq.w	#1,(a5)
		bra.s	loc_56926
; ---------------------------------------------------------------------------

loc_56918:
		subq.w	#5,(a1)
		cmpi.w	#-$100,(a1)
		bgt.s	loc_56926
		move.w	#-$100,(a1)
		subq.w	#1,d0

loc_56926:
		addq.w	#4,a1
		addq.w	#2,a5
		dbf	d1,loc_56910
		tst.w	d0
		bne.s	loc_56936
		st	(Events_fg_5).w

loc_56936:
		move.l	a0,-(sp)
		lea	(HScroll_table).w,a0
		lea	$100(a0),a1
		lea	$20(a1),a5
		lea	$20(a5),a6
		move.w	(Camera_X_pos_BG_copy).w,d0
		moveq	#$D-1,d1

loc_5694E:
		move.w	(a5)+,d2
		add.w	(a6),d2
		add.w	d0,d2
		move.w	d2,(a0)
		move.w	d2,(a1)+
		addq.w	#4,a0
		addq.w	#4,a6
		dbf	d1,loc_5694E
		movea.l	(sp)+,a0
		rts
; End of function sub_56706


; =============== S U B R O U T I N E =======================================


sub_56964:
		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		asr.w	#1,d0
		addi.w	#$200,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; End of function sub_56964


; =============== S U B R O U T I N E =======================================


sub_5697E:
		movea.w	$38(a3),a5
		movea.w	$3C(a3),a6
		lea	$17(a5),a5
		lea	$17(a6),a6
		moveq	#$A-1,d0

loc_56990:
		clr.b	(a5)+
		clr.b	(a6)+
		dbf	d0,loc_56990
		rts
; End of function sub_5697E


; =============== S U B R O U T I N E =======================================


sub_5699A:
		cmpi.w	#$2A00,(Player_1+x_pos).w
		blo.s	loc_569B6
		move.w	(Player_1+y_pos).w,d0
		cmpi.w	#$140,d0
		blo.s	loc_569B6
		cmpi.w	#$180,d0
		bhi.s	loc_569B6
		moveq	#-1,d0
		rts
; ---------------------------------------------------------------------------

loc_569B6:
		moveq	#0,d0
		rts
; End of function sub_5699A

; ---------------------------------------------------------------------------

loc_569BA:
		st	(Background_collision_flag).w
		addi.l	#$A000,(_unkEE9C).w
		move.w	#$2E0,d0
		add.w	(_unkEE9C).w,d0
		neg.w	d0
		move.w	d0,(Camera_Y_diff).w
		move.w	#$1930,(Camera_X_diff).w
		rts
; ---------------------------------------------------------------------------

Go_CheckPlayerRelease:
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(Player_1).w,a1
		btst	#Status_OnObj,status(a1)
		beq.s	loc_569F6
		movea.w	interact(a1),a0
		jsr	(CheckPlayerReleaseFromObj).l

loc_569F6:
		lea	(Player_2).w,a1
		btst	#Status_OnObj,status(a1)
		beq.s	loc_56A0C
		movea.w	interact(a1),a0
		jsr	(CheckPlayerReleaseFromObj).l

loc_56A0C:
		movem.l	(sp)+,d7-a0/a2-a3
		rts

; =============== S U B R O U T I N E =======================================


sub_56A12:
		jsr	(AllocateObject).l
		bne.s	locret_56A32
		move.l	#loc_56A34,d1
		moveq	#8-1,d2

loc_56A22:
		move.l	d1,(a1)
		move.w	d2,subtype(a1)
		jsr	(CreateNewSprite4).l
		dbne	d2,loc_56A22

locret_56A32:
		rts
; End of function sub_56A12

; ---------------------------------------------------------------------------

loc_56A34:
		move.b	#$40,width_pixels(a0)
		bset	#7,status(a0)
		move.w	subtype(a0),d0
		lsl.w	#4,d0
		addi.w	#$458,d0
		sub.w	(Camera_Y_pos_BG_copy).w,d0
		add.w	(Camera_Y_pos_copy).w,d0
		move.w	d0,y_pos(a0)
		move.w	subtype(a0),d0
		add.w	d0,d0
		lea	word_56AF4(pc),a1
		move.w	(a1,d0.w),d4
		add.w	d0,d0
		lea	(HScroll_table+$008).w,a1
		sub.w	(a1,d0.w),d4
		add.w	(Camera_X_pos_copy).w,d4
		cmpi.w	#$10,(Events_bg+$08).w
		beq.s	loc_56A7E
		move.w	#$7FFF,d4

loc_56A7E:
		move.w	d4,x_pos(a0)
		moveq	#$4B,d1
		moveq	#8,d2
		moveq	#8,d3
		jsr	(SolidObjectFull2).l
		move.w	#-$300,d0
		lea	(Player_1).w,a1
		btst	#$10,d6
		beq.s	loc_56AA4
		move.w	d0,x_vel(a1)
		move.w	d0,y_vel(a1)

loc_56AA4:
		lea	(Player_2).w,a1
		btst	#$11,d6
		beq.s	locret_56AB6
		move.w	d0,x_vel(a1)
		move.w	d0,y_vel(a1)

locret_56AB6:
		rts
; ---------------------------------------------------------------------------
SOZ2_BGDrawArray:
		dc.w   $440,   $10,   $10,   $10,   $10,   $10,   $10,   $10,   $10,   $10,   $10,   $10, $7FFF
		dc.w  $1800
		dc.w  $1502
		dc.w  $1204
		dc.w  $0F06
		dc.w  $0C08
		dc.w  $090A
		dc.w  $060C
		dc.w  $030E
word_56AE2:
		dc.w  $0010
		dc.w  $030E
		dc.w  $060C
		dc.w  $090A
		dc.w  $0C08
		dc.w  $0F06
		dc.w  $1204
		dc.w  $1502
		dc.w  $1800
word_56AF4:
		dc.w  $1268
		dc.w  $1260
		dc.w  $1260
		dc.w  $125C
		dc.w  $1254
		dc.w  $1248
		dc.w  $1248
		dc.w  $1248
; ---------------------------------------------------------------------------

LRZ1_ScreenInit:
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

LRZ1_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	(Events_bg+$0C).w,d0
		beq.s	loc_56B5E
		bmi.s	loc_56B2C
		movea.w	$40(a3),a1
		move.b	#$9C,$A(a1)
		bra.s	loc_56B54
; ---------------------------------------------------------------------------

loc_56B2C:
		movea.w	$38(a3),a1
		lea	$1D(a1),a1
		move.b	#$44,(a1)+
		move.b	#0,(a1)+
		move.b	#$4A,(a1)
		movea.w	$3C(a3),a1
		lea	$1D(a1),a1
		move.b	#$3E,(a1)+
		move.b	#0,(a1)+
		move.b	#$4B,(a1)

loc_56B54:
		clr.w	(Events_bg+$0C).w
		jmp	(Refresh_PlaneScreenDirect).l
; ---------------------------------------------------------------------------

loc_56B5E:
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

LRZ1_BackgroundInit:
		move.w	(a3),d0
		move.w	#$1C,d1
		moveq	#$19-1,d2

loc_56B6C:
		move.w	d0,(a3,d1.w)
		addq.w	#4,d1
		dbf	d2,loc_56B6C
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_56B88
		movea.w	4(a3),a1
		move.b	#-$A,4(a1)

loc_56B88:
		jsr	LRZ1_Deform(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		clr.l	(HScroll_table).w
		move.w	d2,(HScroll_table+$006).w
		clr.l	(HScroll_table+$008).w
		lea	LRZ1_BGDrawArray(pc),a4
		lea	(HScroll_table).w,a5
		jsr	(Refresh_PlaneTileDeform).l
		lea	LRZ1_BGDeformArray(pc),a4
		lea	(HScroll_table+$00C).w,a5
		jmp	(ApplyDeformation).l
; ---------------------------------------------------------------------------

LRZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	LRZ1_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

LRZ1_BackgroundEvent_Index:
		bra.w	loc_56BD2
; ---------------------------------------------------------------------------
		bra.w	loc_56C6E
; ---------------------------------------------------------------------------
		bra.w	loc_56C88
; ---------------------------------------------------------------------------
		bra.w	loc_56CAA
; ---------------------------------------------------------------------------

loc_56BD2:
		tst.w	(Events_fg_5).w
		beq.s	loc_56C28
		clr.w	(Events_fg_5).w
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(LRZ2_128x128_Secondary_Kos).l,a1
		lea	(Chunk_table+$180).l,a2
		jsr	(Queue_Kos).l
		lea	(LRZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$128).w,a2
		jsr	(Queue_Kos).l
		lea	(ArtKosM_LRZ2_Secondary).l,a1
		move.w	#tiles_to_bytes($090),d2
		jsr	(Queue_Kos_Module).l
		moveq	#PLCID_30,d0
		jsr	(Load_PLC).l
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$C,(Events_routine_bg).w
		bra.w	loc_56D16
; ---------------------------------------------------------------------------

loc_56C28:
		jsr	sub_56DCA(pc)
		jsr	LRZ1_Deform(pc)

loc_56C30:
		lea	LRZ1_BGDrawArray(pc),a4
		lea	(HScroll_table).w,a5
		moveq	#$20,d6
		moveq	#3,d5
		jsr	(Draw_BG).l
		move.l	(Events_bg+$02).w,d0
		beq.s	loc_56C5A
		move.w	d0,(Camera_Y_pos_BG_copy).w
		swap	d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		jsr	(PlainDeformation).l
		bra.s	loc_56C68
; ---------------------------------------------------------------------------

loc_56C5A:
		lea	LRZ1_BGDeformArray(pc),a4
		lea	(HScroll_table+$00C).w,a5
		jsr	(ApplyDeformation).l

loc_56C68:
		jmp	(ShakeScreen_Setup).l
; ---------------------------------------------------------------------------

loc_56C6E:
		jsr	sub_56DCA(pc)
		jsr	sub_56DAC(pc)

loc_56C76:
		jsr	(DrawBGAsYouMove).l
		jsr	(PlainDeformation).l
		jmp	(ShakeScreen_Setup).l
; ---------------------------------------------------------------------------

loc_56C88:
		jsr	LRZ1_Deform(pc)

loc_56C8C:
		lea	LRZ1_BGDrawArray(pc),a4
		lea	(HScroll_table-$04).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d1
		jsr	(Draw_PlaneVertBottomUpComplex).l
		bpl.s	loc_56C30
		clr.l	(Events_bg+$02).w
		clr.w	(Events_routine_bg).w
		bra.s	loc_56C30
; ---------------------------------------------------------------------------

loc_56CAA:
		tst.b	(Kos_modules_left).w
		bne.s	loc_56D16
		move.w	#$901,(Current_zone_and_act).w
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(Respawn_table_keep).w
		jsr	(Clear_Switches).l
		clr.b	(LRZ_rocks_routine).w
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$2C00,d0
		moveq	#0,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d0,(Player_2+x_pos).w
		jsr	(Offset_ObjectsDuringTransition).l
		sub.w	d0,(Camera_X_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w
		jsr	(Reset_TileOffsetPositionActual).l
		clr.w	(Events_routine_bg).w

loc_56D16:
		jsr	LRZ1_Deform(pc)
		lea	LRZ1_BGDrawArray(pc),a4
		lea	(HScroll_table).w,a5
		moveq	#$20,d6
		moveq	#3,d5
		jsr	(Draw_BG).l
		lea	LRZ1_BGDeformArray(pc),a4
		lea	(HScroll_table+$00C).w,a5
		jsr	(ApplyDeformation).l
		jmp	(ShakeScreen_Setup).l

; =============== S U B R O U T I N E =======================================


LRZ1_Deform:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Screen_shake_offset).w,d1
		sub.w	d1,d0
		asr.w	#3,d0
		add.w	d1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#3,d0
		move.l	d0,d1
		move.l	d0,d2
		asr.l	#2,d0
		swap	d1
		move.w	d1,(Camera_X_pos_BG_copy).w
		move.w	d1,(HScroll_table+$004).w
		swap	d1
		sub.l	d0,d1
		swap	d1
		move.w	d1,(Events_bg+$10).w
		swap	d1
		sub.l	d0,d1
		swap	d1
		move.w	d1,(Events_bg+$12).w
		lea	(HScroll_table+$01C).w,a1
		move.l	d2,d1
		moveq	#8-1,d3

loc_56D88:
		swap	d1
		move.w	d1,-(a1)
		swap	d1
		add.l	d0,d1
		dbf	d3,loc_56D88
		lea	(HScroll_table+$01C).w,a1
		add.l	d0,d2
		add.l	d0,d0
		moveq	#5-1,d3

loc_56D9E:
		swap	d2
		move.w	d2,(a1)+
		swap	d2
		add.l	d0,d2
		dbf	d3,loc_56D9E
		rts
; End of function LRZ1_Deform


; =============== S U B R O U T I N E =======================================


sub_56DAC:
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$788,d0
		add.w	(_unkEE9C).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$1500,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; End of function sub_56DAC


; =============== S U B R O U T I N E =======================================


sub_56DCA:
		lea	word_56F88(pc),a1
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		moveq	#0,d2
		move.w	#3-1,d3

loc_56DDC:
		lea	(a1),a5
		cmp.w	(a5)+,d0
		blo.s	loc_56DEE
		cmp.w	(a5)+,d0
		bhi.s	loc_56DEE
		cmp.w	(a5)+,d1
		blo.s	loc_56DEE
		cmp.w	(a5)+,d1
		blo.s	loc_56DFA

loc_56DEE:
		adda.w	#$A,a1
		addq.w	#4,d2
		dbf	d3,loc_56DDC
		rts
; ---------------------------------------------------------------------------

loc_56DFA:
		jmp	loc_56DFE(pc,d2.w)
; End of function sub_56DCA

; ---------------------------------------------------------------------------

loc_56DFE:
		bra.w	loc_56E0A
; ---------------------------------------------------------------------------
		bra.w	loc_56E1C
; ---------------------------------------------------------------------------
		bra.w	loc_56E2E
; ---------------------------------------------------------------------------

loc_56E0A:
		tst.w	(Events_bg+$00).w
		bne.s	loc_56E16
		cmp.w	(a5),d0
		bhs.s	loc_56E40
		rts
; ---------------------------------------------------------------------------

loc_56E16:
		cmp.w	(a5),d0
		blo.s	loc_56E66
		rts
; ---------------------------------------------------------------------------

loc_56E1C:
		tst.w	(Events_bg+$00).w
		bne.s	loc_56E28
		cmp.w	(a5),d0
		blo.s	loc_56E40
		rts
; ---------------------------------------------------------------------------

loc_56E28:
		cmp.w	(a5),d0
		bhs.s	loc_56E66
		rts
; ---------------------------------------------------------------------------

loc_56E2E:
		tst.w	(Events_bg+$00).w
		bne.s	loc_56E3A
		cmp.w	(a5),d1
		bhs.s	loc_56E40
		rts
; ---------------------------------------------------------------------------

loc_56E3A:
		cmp.w	(a5),d1
		blo.s	loc_56E66
		rts
; ---------------------------------------------------------------------------

loc_56E40:
		st	(Events_bg+$00).w
		jsr	(AllocateObject).l
		bne.s	loc_56E52
		move.l	#Obj_56EA0,(a1)

loc_56E52:
		jsr	sub_56DAC(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		addq.w	#4,(Events_routine_bg).w
		addq.w	#4,sp
		jmp	loc_56C76(pc)
; ---------------------------------------------------------------------------

loc_56E66:
		clr.w	(Events_bg+$00).w
		move.w	(Camera_X_pos_BG_copy).w,(Events_bg+$02).w
		move.w	(Camera_Y_pos_BG_copy).w,(Events_bg+$04).w
		jsr	LRZ1_Deform(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		move.w	d2,(HScroll_table+$006).w
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		addq.w	#4,sp
		jmp	loc_56C8C(pc)
; ---------------------------------------------------------------------------

Obj_56EA0:
		move.l	#loc_56EC2,(a0)
		move.b	#$80,height_pixels(a0)
		move.w	#$1E80,x_pos(a0)
		bset	#7,status(a0)
		move.w	#-$4000,$34(a0)
		clr.w	(_unkEE9C).w

loc_56EC2:
		tst.w	(Events_bg+$00).w
		bne.s	loc_56ECE
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_56ECE:
		move.l	$2E(a0),d0
		move.l	$32(a0),d1
		move.l	#-$100,d2
		tst.b	$36(a0)
		beq.s	loc_56EF6
		neg.l	d2
		add.l	d1,d0
		bmi.s	loc_56F0A
		moveq	#0,d0
		move.l	#$C000,d1
		clr.b	$36(a0)
		bra.s	loc_56F0C
; ---------------------------------------------------------------------------

loc_56EF6:
		add.l	d1,d0
		beq.s	loc_56EFC
		bpl.s	loc_56F0A

loc_56EFC:
		moveq	#0,d0
		move.l	#-$C000,d1
		st	$36(a0)
		bra.s	loc_56F0C
; ---------------------------------------------------------------------------

loc_56F0A:
		add.l	d2,d1

loc_56F0C:
		move.l	d1,$32(a0)
		move.l	d0,$2E(a0)
		swap	d0
		move.w	d0,(_unkEE9C).w
		neg.w	d0
		addi.w	#$988,d0
		move.w	d0,y_pos(a0)
		move.w	#$280,d1
		move.w	#$80,d2
		move.w	#$6C,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop).l
		btst	#p1_standing_bit,status(a0)
		beq.s	loc_56F54
		lea	(Player_1).w,a1
		btst	#Status_FireShield,status_secondary(a1)
		bne.s	loc_56F54
		jsr	(Touch_HurtSpikes).l

loc_56F54:
		btst	#p2_standing_bit,status(a0)
		beq.s	locret_56F66
		lea	(Player_2).w,a1
		jsr	(Touch_HurtSpikes).l

locret_56F66:
		rts
; ---------------------------------------------------------------------------
LRZ1_BGDrawArray:
		dc.w    $B0,  $100, $7FFF
LRZ1_BGDeformArray:
		dc.w    $40,   $20,   $10,   $10,   $10,   $10,   $10,  $100,   $10,   $10,   $10,   $20, $7FFF
word_56F88:
		dc.w  $1AC0, $1B40,  $840,  $8C0
		dc.w  $1B00, $2240, $2340,  $840
		dc.w   $880, $22C0, $20C0, $2180
		dc.w   $740,  $800,  $7A0
; ---------------------------------------------------------------------------

LRZ2_ScreenInit:
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

LRZ2_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

LRZ2_BackgroundInit:
		jsr	(AllocateObject).l
		bne.s	loc_56FD2
		move.l	#loc_5711E,(a1)
		move.w	a1,(Events_bg+$06).w

loc_56FD2:
		move.w	#8,(Events_routine_bg).w
		jsr	sub_57082(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		moveq	#0,d1
		jsr	(Refresh_PlaneFull).l
		lea	LRZ2_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	(ApplyDeformation).l
; ---------------------------------------------------------------------------

LRZ2_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	LRZ2_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

LRZ2_BackgroundEvent_Index:
		bra.w	loc_5700C
; ---------------------------------------------------------------------------
		bra.w	loc_57040
; ---------------------------------------------------------------------------
		bra.w	loc_57058
; ---------------------------------------------------------------------------

loc_5700C:
		jsr	(AllocateObject).l
		bne.s	loc_5701E
		move.l	#loc_5711E,(a1)
		move.w	a1,(Events_bg+$06).w

loc_5701E:
		jsr	sub_57082(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_57044
; ---------------------------------------------------------------------------

loc_57040:
		jsr	sub_57082(pc)

loc_57044:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	loc_5705C
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_5705C
; ---------------------------------------------------------------------------

loc_57058:
		jsr	sub_57082(pc)

loc_5705C:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l
		lea	LRZ2_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jsr	(ApplyDeformation).l
		jmp	(ShakeScreen_Setup).l

; =============== S U B R O U T I N E =======================================


sub_57082:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Screen_shake_offset).w,d1
		sub.w	d1,d0
		swap	d0
		clr.w	d0
		asr.l	#3,d0
		move.l	d0,d2
		asr.l	#2,d2
		sub.l	d2,d0
		swap	d0
		add.w	d1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#3,d0
		move.l	d0,d1
		move.l	d0,d2
		asr.l	#2,d0
		swap	d1
		move.w	d1,(Camera_X_pos_BG_copy).w
		swap	d1
		sub.l	d0,d1
		swap	d1
		move.w	d1,(Events_bg+$10).w
		swap	d1
		sub.l	d0,d1
		swap	d1
		move.w	d1,(Events_bg+$12).w
		lea	(HScroll_table+$010).w,a1
		move.l	d2,d1
		moveq	#8-1,d3

loc_570D2:
		swap	d1
		move.w	d1,-(a1)
		swap	d1
		add.l	d0,d1
		dbf	d3,loc_570D2
		lea	(HScroll_table+$010).w,a1
		add.l	d0,d2
		add.l	d0,d0
		moveq	#5-1,d3

loc_570E8:
		swap	d2
		move.w	d2,(a1)+
		swap	d2
		add.l	d0,d2
		dbf	d3,loc_570E8
		move.w	(Events_bg+$06).w,d0
		beq.s	locret_5711C
		movea.w	d0,a1
		move.w	#$678,d0
		sub.w	(HScroll_table+$004).w,d0
		cmpi.w	#-$7E0,d0
		ble.s	loc_5710C
		moveq	#0,d0

loc_5710C:
		move.w	d0,$10(a1)
		move.w	#$C0,d0
		sub.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	d0,$14(a1)

locret_5711C:
		rts
; End of function sub_57082

; ---------------------------------------------------------------------------

loc_5711E:
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_57130
		clr.w	(Events_bg+$06).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_57130:
		move.l	#loc_57156,(a0)
		move.b	#$40,height_pixels(a0)
		move.b	#$50,width_pixels(a0)
		move.w	#$380,priority(a0)
		move.w	#make_art_tile(ArtTile_LRZ2DeathEggBG,3,0),art_tile(a0)
		move.l	#Map_LRZ2DeathEggBG,mappings(a0)

loc_57156:
		tst.w	$2E(a0)
		bne.s	loc_57176
		tst.w	x_pos(a0)
		beq.s	locret_57182
		lea	(ArtKosM_LRZ2DeathEggBG).l,a1
		move.w	#tiles_to_bytes(ArtTile_LRZ2DeathEggBG),d2
		jsr	(Queue_Kos_Module).l
		st	$2E(a0)

loc_57176:
		tst.w	x_pos(a0)
		beq.s	locret_57182
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locret_57182:
		rts
; ---------------------------------------------------------------------------
LRZ2_BGDeformArray:
		dc.w   $20,   $20,   $20,   $10,   $10,   $10,   $10,   $F0,   $10,   $10,   $10,   $20, $7FFF
Map_LRZ2DeathEggBG:
		include "Levels/LRZ/Misc Object Data/Map - Act 2 BG Death Egg.asm"
; ---------------------------------------------------------------------------

SSZ1_ScreenInit:
		tst.b	(Last_star_post_hit).w
		bne.s	loc_57246
		jsr	(AllocateObject).l
		bne.s	loc_57246
		move.l	#Obj_57C1E,(a1)
		move.w	#$100,x_pos(a1)
		move.b	#$6C,$2D(a1)
		st	(Events_bg+$05).w
		move.w	#$200,(Camera_max_X_pos).w
		move.w	#$BC0,d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		moveq	#$60,d0
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d0,(Camera_X_pos).w
		move.w	#$F49,d0
		move.w	d0,(Camera_Y_pos_copy).w
		move.w	d0,(Camera_Y_pos).w
		st	(Scroll_lock).w

loc_57246:
		clr.w	(_unkEE98).w
		clr.w	(_unkEE9C).w
		lea	(HScroll_table+$1F6).w,a1
		lea	(a1),a5
		moveq	#5-1,d0

loc_57256:
		clr.w	(a1)+
		dbf	d0,loc_57256
		lea	word_58758(pc),a6
		moveq	#5-1,d1
		jsr	(AllocateObject).l
		bne.s	loc_5728E

loc_5726A:
		move.w	a1,(a5)+
		move.l	#loc_57BB2,(a1)
		move.w	(a6)+,$38(a1)
		move.w	(a6)+,$3A(a1)
		move.w	(a6)+,$40(a1)
		move.w	(a6)+,d2
		move.b	d2,mapping_frame(a1)
		jsr	(CreateNewSprite4).l
		dbne	d1,loc_5726A

loc_5728E:
		jsr	sub_5758A(pc)
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

SSZ1_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	(Events_routine_fg).w,d0
		jmp	SSZ1_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

SSZ1_ScreenEvent_Index:
		bra.w	loc_572BA
; ---------------------------------------------------------------------------
		bra.w	loc_57344
; ---------------------------------------------------------------------------
		bra.w	loc_574B0
; ---------------------------------------------------------------------------

loc_572BA:
		tst.b	(End_of_level_flag).w
		bne.s	loc_572CE
		jsr	sub_575EA(pc)
		jsr	sub_5758A(pc)
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

loc_572CE:
		jsr	(AllocateObject).l
		bne.s	loc_572E2
		move.l	#Obj_57E96,(a1)
		move.w	#$1E,$2E(a1)

loc_572E2:
		lea	(HScroll_table+$E0).w,a1
		lea	$20(a1),a5
		moveq	#$A-1,d0

loc_572EC:
		move.w	#-1,(a1)+
		clr.l	(a5)+
		clr.l	$3C(a5)
		dbf	d0,loc_572EC
		jsr	sub_5750C(pc)
		lea	(HScroll_table+$80).w,a1
		move.w	(Camera_Y_pos_mask).w,d0
		moveq	#$A-1,d1

loc_57308:
		move.w	(a1)+,(a1)
		and.w	d0,(a1)+
		dbf	d1,loc_57308
		jsr	(Restore_PlayerControl).l
		lea	(Player_2).w,a1
		jsr	(Restore_PlayerControl2).l
		st	(Ctrl_1_locked).w
		st	(Ctrl_2_locked).w
		clr.w	(Ctrl_1_logical).w
		clr.w	(Ctrl_2_logical).w
		st	(Scroll_lock).w
		st	(Screen_shake_flag).w
		move.w	#4,(Special_V_int_routine).w
		addq.w	#4,(Events_routine_fg).w
		bra.s	loc_5734E
; ---------------------------------------------------------------------------

loc_57344:
		tst.w	(Events_fg_4).w
		bne.s	loc_57360
		jsr	sub_5750C(pc)

loc_5734E:
		lea	word_577B2(pc),a4
		lea	(HScroll_table+$80).w,a5
		moveq	#$F,d6
		moveq	#$A,d5
		jmp	(DrawTilesVDeform).l
; ---------------------------------------------------------------------------

loc_57360:
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(SSZ1_128x128_Custom_Kos).l,a1
		lea	(Chunk_table+$180).l,a2
		jsr	(Queue_Kos).l
		lea	(SSZ1_16x16_Custom_Kos).l,a1
		lea	(Block_table+$B8).w,a2
		jsr	(Queue_Kos).l
		lea	(ArtKosM_SSZ1_Custom).l,a1
		move.w	#tiles_to_bytes($073),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_SSZSpiralRamp).l,a1
		move.w	#tiles_to_bytes(ArtTile_SSZSpiralRamp),d2
		jsr	(Queue_Kos_Module).l
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	-8(a3),d0
		subq.w	#3,d0
		movea.w	(a3),a1
		move.b	#4,(a1,d0.w)
		move.b	#5,1(a1,d0.w)
		move.b	#6,2(a1,d0.w)
		movea.w	4(a3),a1
		move.b	#7,(a1,d0.w)
		move.b	#8,1(a1,d0.w)
		move.b	#9,2(a1,d0.w)
		lea	(Normal_palette_line_2).w,a1
		lea	Pal_SSZDeathEgg(pc),a5
		moveq	#bytesToLcnt($20),d0

loc_573E4:
		move.l	(a5)+,(a1)+
		dbf	d0,loc_573E4
		jsr	sub_574DC(pc)
		move.w	(_unkEEEA).w,d0
		move.w	d0,d1
		andi.w	#$FFF0,d0
		move.w	d0,(_unkEEF2).w
		move.w	(_unkEEEE).w,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(_unkEEF4).w
		st	(_unkEE98).w
		clr.l	(_unkEEF6).w
		clr.w	(_unkEEFA).w
		jsr	(AllocateObject).l
		bne.w	loc_574A0
		move.w	#$5A8,d1
		move.w	#$58C,d2
		move.w	#$554,d3
		moveq	#$A-1,d4

loc_5742C:
		move.l	#loc_58234,(a1)
		move.w	#$1A38,x_pos(a1)
		move.w	d1,y_pos(a1)
		jsr	(CreateNewSprite4).l
		bne.s	loc_574A0
		move.l	#loc_58360,(a1)
		move.w	#$1A80,x_pos(a1)
		move.w	d2,y_pos(a1)
		tst.w	d4
		beq.s	loc_574A0
		jsr	(CreateNewSprite4).l
		bne.s	loc_574A0
		move.l	#loc_582AC,(a1)
		move.w	#$1A48,x_pos(a1)
		move.w	d1,y_pos(a1)
		subi.w	#$38,y_pos(a1)
		jsr	(CreateNewSprite4).l
		bne.s	loc_574A0
		move.l	#loc_581F2,(a1)
		move.w	#$19F8,x_pos(a1)
		move.w	d3,y_pos(a1)
		moveq	#$70,d5
		sub.w	d5,d1
		sub.w	d5,d2
		sub.w	d5,d3
		jsr	(CreateNewSprite4).l
		dbne	d4,loc_5742C

loc_574A0:
		st	(Events_fg_4).w
		move.w	#$C,(Special_V_int_routine).w
		addq.w	#4,(Events_routine_fg).w
		rts
; ---------------------------------------------------------------------------

loc_574B0:
		jsr	sub_574DC(pc)
		lea	(_unkEEEA).w,a6
		lea	(_unkEEF2).w,a5
		move.w	(_unkEEEE).w,d1
		moveq	#$F,d6
		jsr	(Draw_TileColumn).l
		lea	(_unkEEEE).w,a6
		lea	(_unkEEF4).w,a5
		move.w	(_unkEEEA).w,d1
		moveq	#$15,d6
		jmp	(Draw_TileRow).l

; =============== S U B R O U T I N E =======================================


sub_574DC:
		move.w	(Camera_X_pos_copy).w,(_unkEEEA).w
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$110,d0
		asr.w	#2,d0
		move.w	d0,(_unkEEEE).w
		cmpi.w	#$110,(Camera_Y_pos).w
		bne.w	sub_5758A
		addi.l	#$6000,(_unkEEF6).w
		move.w	(_unkEEF6).w,d0
		add.w	d0,(_unkEEEE).w
		bra.s	sub_5758A
; End of function sub_574DC


; =============== S U B R O U T I N E =======================================


sub_5750C:
		lea	(HScroll_table+$80).w,a5
		lea	$60(a5),a6
		move.w	(Camera_Y_pos_copy).w,d0
		moveq	#$A,d1
		moveq	#$A-1,d2

loc_5751C:
		tst.w	(a6)
		beq.s	loc_57526
		bmi.s	loc_57536
		subq.w	#1,(a6)
		bra.s	loc_57536
; ---------------------------------------------------------------------------

loc_57526:
		move.l	$80(a5),d3
		addi.l	#$800,$80(a5)
		sub.l	d3,$C0(a5)

loc_57536:
		move.w	$C0(a5),d3
		add.w	d0,d3
		cmpi.w	#$580,d3
		bhs.s	loc_5754C
		clr.l	$80(a5)
		move.w	#$580,d3
		subq.w	#1,d1

loc_5754C:
		move.w	d3,(a5)
		move.w	d3,-$20(a6)
		addq.w	#4,a5
		addq.w	#2,a6
		dbf	d2,loc_5751C
		movea.w	(_unkFAA4).w,a1
		move.w	$10(a1),d0
		subi.w	#$19A0,d0
		lsr.w	#3,d0
		andi.w	#$FFFC,d0
		lea	(HScroll_table+$140).w,a5
		move.w	#$660,d2
		sub.w	(a5,d0.w),d2
		move.w	d2,$14(a1)
		tst.w	d1
		bne.s	sub_5758A
		st	(Events_fg_4+1).w
		move.l	#Delete_Current_Sprite,(a1)
; End of function sub_5750C


; =============== S U B R O U T I N E =======================================


sub_5758A:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Screen_shake_offset).w,d3
		sub.w	d3,d0
		move.w	d0,d1
		asr.w	#2,d1
		add.w	d1,d0
		move.w	(_unkEE9C).w,d1
		move.w	d1,d2
		asr.w	#2,d2
		add.w	d2,d1
		asr.w	#1,d1
		add.w	d1,d0
		add.w	d3,d0
		move.w	(Camera_X_pos_copy).w,d1
		move.w	d1,d2
		asr.w	#2,d2
		add.w	d2,d1
		lea	(HScroll_table+$1F6).w,a5
		moveq	#5-1,d2

loc_575BA:
		move.w	(a5)+,d3
		beq.s	loc_575E4
		movea.w	d3,a6
		move.w	$38(a6),d3
		sub.w	d0,d3
		andi.w	#$FF,d3
		addi.w	#$70,d3
		move.w	d3,$14(a6)
		move.w	$3A(a6),d3
		sub.w	d1,d3
		andi.w	#$1FF,d3
		addi.w	#$50,d3
		move.w	d3,$10(a6)

loc_575E4:
		dbf	d2,loc_575BA
		rts
; End of function sub_5758A


; =============== S U B R O U T I N E =======================================


sub_575EA:
		tst.b	(Events_bg+$06).w
		bne.w	locret_57788
		cmpi.w	#$19A0,(Camera_X_pos).w
		blo.s	loc_5761C
		cmpi.w	#$680,(Player_1+y_pos).w
		bhs.s	loc_5761C
		move.w	#$19A0,(Camera_min_X_pos).w
		move.w	#$5C0,d0
		move.w	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		st	(Events_bg+$06).w
		bra.w	locret_57788
; ---------------------------------------------------------------------------

loc_5761C:
		tst.b	(Events_bg+$05).w
		bne.w	locret_57788
		move.b	(Events_bg+$01).w,d0
		or.b	(Events_bg+$03).w,d0
		bne.s	loc_57686
		move.w	(Camera_Y_pos).w,d0
		cmpi.w	#$100,d0
		blo.s	loc_57674
		cmpi.w	#$E00,d0
		bhs.s	loc_57674
		lea	word_5778A(pc),a1
		move.w	(Player_1+x_pos).w,d1

loc_57646:
		cmp.w	(a1)+,d1
		blo.s	loc_5764E
		addq.w	#2,a1
		bra.s	loc_57646
; ---------------------------------------------------------------------------

loc_5764E:
		move.w	(a1),d2
		cmp.w	d0,d2
		bhi.s	loc_57658
		move.w	d2,(Camera_min_Y_pos).w

loc_57658:
		lea	word_5779A(pc),a1

loc_5765C:
		cmp.w	(a1)+,d1
		blo.s	loc_57664
		addq.w	#2,a1
		bra.s	loc_5765C
; ---------------------------------------------------------------------------

loc_57664:
		move.w	(a1),d2
		cmp.w	d0,d2
		blo.s	loc_57686
		move.w	d2,(Camera_max_Y_pos).w
		move.w	d2,(Camera_target_max_Y_pos).w
		bra.s	loc_57686
; ---------------------------------------------------------------------------

loc_57674:
		move.w	#-$100,(Camera_min_Y_pos).w
		move.w	#$1000,d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w

loc_57686:
		move.w	(Player_1+y_pos).w,d0
		cmpi.w	#$440,d0
		blo.s	loc_5770C
		cmpi.w	#$880,d0
		bhs.w	loc_5777E
		tst.b	(Events_bg+$00).w
		bmi.w	loc_5777E
		bne.w	locret_57788
		tst.b	(Events_bg+$01).w
		bne.s	loc_576E8
		move.w	#$160,(Camera_min_X_pos).w
		move.w	#$19A0,(Camera_max_X_pos).w
		cmpi.w	#$7C0,d0
		blo.w	locret_57788
		cmpi.w	#$160,(Camera_X_pos).w
		bne.w	locret_57788
		btst	#1,(Player_1+status).w
		bne.w	locret_57788
		move.w	#$160,(Camera_max_X_pos).w
		move.w	#$7C0,d0
		move.w	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		st	(Events_bg+$01).w

loc_576E8:
		cmpi.w	#$7C0,(Camera_Y_pos).w
		bne.w	locret_57788
		jsr	(AllocateObject).l
		bne.s	loc_5770A
		move.l	#Obj_SSZGHZBoss,(a1)
		st	(Events_bg+$05).w
		move.w	#$7F00,(Events_bg+$00).w

loc_5770A:
		bra.s	locret_57788
; ---------------------------------------------------------------------------

loc_5770C:
		tst.b	(Events_bg+$02).w
		bmi.s	loc_5777E
		bne.s	locret_57788
		tst.b	(Events_bg+$03).w
		bne.s	loc_5775C
		move.w	#$1660,(Camera_max_X_pos).w
		moveq	#0,d1
		tst.w	(Events_bg+$00).w
		bne.s	loc_5772C
		move.w	#$160,d1

loc_5772C:
		move.w	d1,(Camera_min_X_pos).w
		cmpi.w	#$420,d0
		blo.s	locret_57788
		cmpi.w	#$1660,(Camera_X_pos).w
		bne.s	locret_57788
		btst	#1,(Player_1+status).w
		bne.s	locret_57788
		move.w	#$1660,(Camera_min_X_pos).w
		move.w	#$380,d0
		move.w	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		st	(Events_bg+$03).w

loc_5775C:
		cmpi.w	#$380,(Camera_Y_pos).w
		bne.s	locret_57788
		jsr	(AllocateObject).l
		bne.s	loc_5777C
		move.l	#Obj_SSZMTZBoss,(a1)
		st	(Events_bg+$05).w
		move.w	#$7F00,(Events_bg+$02).w

loc_5777C:
		bra.s	locret_57788
; ---------------------------------------------------------------------------

loc_5777E:
		clr.w	(Camera_min_X_pos).w
		move.w	#$19A0,(Camera_max_X_pos).w

locret_57788:
		rts
; End of function sub_575EA

; ---------------------------------------------------------------------------
word_5778A:
		dc.w   $EE0,  $D00
		dc.w  $11E0,  $CC0
		dc.w  $1340,  $B20
		dc.w  $7FFF,     0
word_5779A:
		dc.w   $640,  $C60
		dc.w   $880,  $CA0
		dc.w  $1200,  $C60
		dc.w  $1380,  $A80
		dc.w  $13C0,  $660
		dc.w  $7FFF,  $3E0
word_577B2:
		dc.w  $19C0
		dc.w    $20
		dc.w    $20
		dc.w    $20
		dc.w    $20
		dc.w    $20
		dc.w    $20
		dc.w    $20
		dc.w    $20
		dc.w  $7FFF
word_577C6:
		dc.w      0,     9
		dc.w     $C,     6
		dc.w      3,    $C
		dc.w      0,     9
		dc.w     $C,     3
Pal_SSZDeathEgg:
		binclude "Levels/SSZ/Palettes/Death Egg.bin"
		even
; ---------------------------------------------------------------------------

SSZ1_BackgroundInit:
		clr.w	(Events_bg+$10).w
		jsr	(AllocateObject).l
		bne.s	loc_57840
		move.l	#loc_57B6A,(a1)
		lea	word_5853E(pc),a5
		move.w	(a5)+,d1

loc_57812:
		jsr	(CreateNewSprite4).l
		bne.s	loc_57840
		move.l	#loc_57B8E,(a1)
		move.w	(a5)+,d2
		move.b	d2,render_flags(a1)
		move.b	#$80,height_pixels(a1)
		move.w	(a5)+,x_pos(a1)
		move.w	(a5)+,y_vel(a1)
		move.w	(a5)+,$2E(a1)
		move.l	(a5)+,$30(a1)
		dbf	d1,loc_57812

loc_57840:
		move.w	(Camera_Y_pos).w,d0
		and.w	(Screen_Y_wrap_value).w,d0
		cmpi.w	#$800,d0
		blo.s	loc_57854
		cmpi.w	#$F00,d0
		blo.s	loc_5786A

loc_57854:
		jsr	sub_579F0(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

loc_5786A:
		move.w	#8,(Events_routine_bg).w
		jsr	sub_57A60(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		move.w	#$1C00,d1
		jsr	(Refresh_PlaneFull).l
		lea	SSZ1_BGDeformArray(pc),a4
		lea	(HScroll_table+$004).w,a5
		jmp	(ApplyDeformation).l
; ---------------------------------------------------------------------------

SSZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	SSZ1_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

SSZ1_BackgroundEvent_Index:
		bra.w	loc_578AA
; ---------------------------------------------------------------------------
		bra.w	loc_57942
; ---------------------------------------------------------------------------
		bra.w	loc_57960
; ---------------------------------------------------------------------------
		bra.w	loc_579D2
; ---------------------------------------------------------------------------

loc_578AA:
		move.w	(Camera_Y_pos).w,d0
		and.w	(Screen_Y_wrap_value).w,d0
		cmpi.w	#$800,d0
		blo.s	loc_578EC
		cmpi.w	#$F00,d0
		bhs.s	loc_578EC
		move.w	(Camera_X_pos_BG_copy).w,(Events_bg+$0C).w
		move.w	(Camera_Y_pos_BG_copy).w,(Events_bg+$0E).w
		jsr	sub_57A60(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_57946
; ---------------------------------------------------------------------------

loc_578EC:
		jsr	sub_579F0(pc)

loc_578F0:
		jsr	(DrawBGAsYouMove).l
		jsr	(PlainDeformation).l
		jsr	(ShakeScreen_Setup).l
		tst.w	(_unkEE98).w
		bne.s	loc_57916
		lea	word_577B2(pc),a4
		lea	(HScroll_table+$0BE).w,a5
		jmp	(Apply_FGVScroll).l
; ---------------------------------------------------------------------------

loc_57916:
		move.w	(_unkEEFA).w,d0
		beq.s	loc_57932
		clr.w	(_unkEEFA).w
		move.w	d0,(a0)+
		move.w	#7,(a0)+
		moveq	#$20-1,d0

loc_57928:
		move.w	#$6061,(a0)+
		dbf	d0,loc_57928
		clr.w	(a0)

loc_57932:
		move.w	(_unkEEEE).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp
		rts
; ---------------------------------------------------------------------------

loc_57942:
		jsr	sub_57A60(pc)

loc_57946:
		move.w	#$1C00,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	loc_5799A
		clr.w	(Events_bg+$0C).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_5799A
; ---------------------------------------------------------------------------

loc_57960:
		move.w	(Camera_Y_pos).w,d0
		and.w	(Screen_Y_wrap_value).w,d0
		cmpi.w	#$800,d0
		blo.s	loc_57974
		cmpi.w	#$F00,d0
		blo.s	loc_57996

loc_57974:
		jsr	sub_579F0(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_579D6
; ---------------------------------------------------------------------------

loc_57996:
		jsr	sub_57A60(pc)

loc_5799A:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	#$1C00,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l
		move.w	(Events_bg+$0C).w,d0
		beq.s	loc_579C4
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	(Events_bg+$0E).w,(Camera_Y_pos_BG_copy).w
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

loc_579C4:
		lea	SSZ1_BGDeformArray(pc),a4
		lea	(HScroll_table+$004).w,a5
		jmp	(ApplyDeformation).l
; ---------------------------------------------------------------------------

loc_579D2:
		jsr	sub_579F0(pc)

loc_579D6:
		move.w	(Camera_X_pos_BG_copy).w,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	(Draw_PlaneVertSingleBottomUp).l
		bpl.w	loc_578F0
		clr.w	(Events_routine_bg).w
		bra.w	loc_578F0

; =============== S U B R O U T I N E =======================================


sub_579F0:
		tst.w	(Events_bg+$10).w
		bne.s	loc_57A30
		cmpi.w	#$1800,(Camera_X_pos).w
		blo.s	loc_57A12
		st	(Events_bg+$10).w
		bsr.s	sub_579F0
		move.w	(Camera_X_pos_BG_copy).w,d0
		andi.w	#$FFF0,d0
		move.w	d0,(Camera_X_pos_BG_rounded).w
		rts
; ---------------------------------------------------------------------------

loc_57A12:
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$160,d0
		add.w	(_unkEE9C).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		addi.w	#$28,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; ---------------------------------------------------------------------------

loc_57A30:
		cmpi.w	#$1800,(Camera_X_pos).w
		bhs.s	loc_57A4C
		clr.w	(Events_bg+$10).w
		bsr.s	sub_579F0
		move.w	(Camera_X_pos_BG_copy).w,d0
		andi.w	#$FFF0,d0
		move.w	d0,(Camera_X_pos_BG_rounded).w
		rts
; ---------------------------------------------------------------------------

loc_57A4C:
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$180,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,(Camera_X_pos_BG_copy).w
		rts
; End of function sub_579F0


; =============== S U B R O U T I N E =======================================


sub_57A60:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(_unkEE9C).w,d1
		asr.w	#1,d1
		add.w	d1,d0
		and.w	(Screen_Y_wrap_value).w,d0
		subi.w	#$800,d0
		asr.w	#1,d0
		addi.w	#$A0,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		lea	(HScroll_table+$004).w,a1
		move.l	-4(a1),d2
		addi.l	#$500,-4(a1)
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#5,d0
		move.l	d0,d1
		asr.l	#1,d0
		add.l	d2,d0
		swap	d0
		move.w	d0,(a1)
		move.w	d0,6(a1)
		move.w	d0,$A(a1)
		move.w	d0,$14(a1)
		swap	d0
		add.l	d2,d1
		add.l	d1,d0
		swap	d0
		move.w	d0,8(a1)
		move.w	d0,$E(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,4(a1)
		move.w	d0,$C(a1)
		move.w	d0,$12(a1)
		move.w	d0,$16(a1)
		move.w	d0,$3A(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,2(a1)
		move.w	d0,$10(a1)
		move.w	d0,$18(a1)
		move.w	d0,$38(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$1A(a1)
		move.w	d0,$36(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$1C(a1)
		move.w	d0,$34(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$1E(a1)
		move.w	d0,$32(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$20(a1)
		move.w	d0,$30(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$22(a1)
		move.w	d0,$2E(a1)
		swap	d0
		add.l	d1,d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$24(a1)
		move.w	d0,$2C(a1)
		swap	d0
		move.l	d1,d2
		asr.l	#1,d2
		add.l	d1,d0
		add.l	d1,d0
		add.l	d2,d0
		swap	d0
		move.w	d0,$26(a1)
		move.w	d0,$2A(a1)
		swap	d0
		add.l	d1,d0
		add.l	d1,d0
		add.l	d2,d0
		swap	d0
		move.w	d0,$28(a1)
		rts
; End of function sub_57A60

; ---------------------------------------------------------------------------

loc_57B6A:
		move.l	#loc_57B76,(a0)
		move.w	#$8000,$30(a0)

loc_57B76:
		move.l	#$8000,d0
		move.l	#$100,d1
		jsr	(Gradual_SwingOffset).l
		move.w	d0,(_unkEE9C).w
		rts
; ---------------------------------------------------------------------------

loc_57B8E:
		bset	#7,status(a0)
		move.w	y_vel(a0),d0
		sub.w	(_unkEE9C).w,d0
		move.w	d0,y_pos(a0)
		move.w	$2E(a0),d1
		movea.l	$30(a0),a2
		move.w	x_pos(a0),d4
		jmp	(SolidObjectTopSloped2).l
; ---------------------------------------------------------------------------

loc_57BB2:
		move.l	#loc_57BF6,(a0)
		move.b	#$40,render_flags(a0)
		move.b	#$10,height_pixels(a0)
		move.b	#$30,width_pixels(a0)
		move.w	#0,priority(a0)
		move.w	#make_art_tile(ArtTile_SSZMisc+$3C,3,1),art_tile(a0)
		move.l	#Map_SSZRoamingClouds,mappings(a0)
		move.w	$38(a0),y_vel(a0)
		jsr	(Random_Number).l
		andi.w	#$FFF,d0
		addi.w	#$C00,d0
		move.w	d0,$30(a0)

loc_57BF6:
		move.l	#$1C00,d0
		move.l	#$80,d1
		jsr	(Gradual_SwingOffset).l
		add.w	y_vel(a0),d0
		move.w	d0,$38(a0)
		move.l	$3E(a0),d0
		sub.l	d0,$3A(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_57C1E:
		jsr	(AllocateObjectAfterCurrent).l
		beq.s	loc_57C28
		rts
; ---------------------------------------------------------------------------

loc_57C28:
		move.l	#loc_57CD2,(a0)
		move.w	#$1000,y_pos(a0)
		move.w	#-$100,$38(a0)
		move.w	a1,$3C(a0)
		move.l	#Obj_TeleporterBeamExpand,(a1)
		move.b	#$44,render_flags(a1)
		move.b	#$80,height_pixels(a1)
		move.b	#$18,width_pixels(a1)
		move.w	#$80,priority(a1)
		move.w	#make_art_tile(ArtTile_SSZMisc+$88,3,1),art_tile(a1)
		move.l	#Map_SSZHPZTeleporter,mappings(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.w	#2,mainspr_childsprites(a1)
		move.w	y_pos(a0),$44(a1)
		subi.w	#$88,$44(a1)
		move.b	#$18,$46(a1)
		move.w	a0,$48(a1)
		tst.b	(Current_act).w
		bne.s	loc_57CAC
		jsr	(CreateNewSprite4).l
		bne.s	loc_57CAC
		move.l	#Obj_57E34,(a1)
		move.w	#$60,subtype(a1)

loc_57CAC:
		st	(Events_bg+$04).w
		lea	(Player_1).w,a1
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$65,d0
		move.w	d0,y_pos(a1)
		move.b	#3,object_control(a1)
		moveq	#0,d0
		move.b	d0,anim(a1)
		move.b	d0,mapping_frame(a1)
		rts
; ---------------------------------------------------------------------------

loc_57CD2:
		jsr	(sub_45866).l
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)
		tst.b	$2D(a0)
		bne.w	loc_57D50
		move.b	#1,object_control(a1)
		move.b	#2,anim(a1)
		bset	#Status_Roll,status(a1)
		move.w	#-1,y_vel(a1)
		move.w	y_pos(a1),d1
		move.w	d1,$3E(a0)
		tst.b	(Current_act).w
		beq.s	loc_57D18
		bset	#7,art_tile(a1)
		bra.s	loc_57D3C
; ---------------------------------------------------------------------------

loc_57D18:
		tst.w	(Player_mode).w
		bne.s	loc_57D3C
		jsr	(CreateNewSprite4).l
		bne.s	loc_57D3C
		move.l	#Obj_57DCC,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	d1,$3E(a1)
		move.w	#$C,subtype(a1)

loc_57D3C:
		clr.b	(Scroll_lock).w
		movea.w	$3C(a0),a1
		st	5(a1)
		move.l	#Obj_57D64,(a0)
		rts
; ---------------------------------------------------------------------------

loc_57D50:
		subi.w	#8,y_pos(a1)
		subq.b	#1,$2D(a0)
		beq.s	locret_57D62
		subi.w	#8,(Camera_Y_pos).w

locret_57D62:
		rts
; ---------------------------------------------------------------------------

Obj_57D64:
		jsr	(sub_45866).l
		lea	(Player_1).w,a1
		move.l	#$20000,d0
		move.l	#$800,d1
		jsr	(Gradual_SwingOffset).l
		add.w	$3E(a0),d0
		move.w	d0,y_pos(a1)
		tst.l	$2E(a0)
		bmi.s	locret_57DA0
		clr.b	object_control(a1)
		clr.b	anim(a1)
		clr.b	(Events_bg+$04).w
		move.l	#loc_57DA2,(a0)

locret_57DA0:
		rts
; ---------------------------------------------------------------------------

loc_57DA2:
		move.w	(Camera_Y_pos).w,d0
		cmp.w	(Camera_max_Y_pos).w,d0
		bne.s	loc_57DC6
		cmp.w	(Camera_min_Y_pos).w,d0
		beq.s	loc_57DB6
		move.w	d0,(Camera_min_Y_pos).w

loc_57DB6:
		move.w	$3A(a0),d0
		or.b	$38(a0),d0
		bne.s	loc_57DC6
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_57DC6:
		jmp	(sub_45866).l
; ---------------------------------------------------------------------------

Obj_57DCC:
		lea	(Player_2).w,a1
		tst.w	subtype(a0)
		beq.s	loc_57DFA
		subq.w	#1,subtype(a0)
		bne.s	locret_57E32
		move.w	x_pos(a0),x_pos(a1)
		move.b	#1,$2E(a1)
		move.b	#2,anim(a1)
		bset	#Status_Roll,status(a1)
		move.w	#-1,y_vel(a1)

loc_57DFA:
		move.l	#$20000,d0
		move.l	#$800,d1
		jsr	(Gradual_SwingOffset).l
		add.w	$3E(a0),d0
		move.w	d0,y_pos(a1)
		tst.l	$2E(a0)
		bmi.s	locret_57E32
		clr.b	object_control(a1)
		clr.b	anim(a1)
		clr.w	(Tails_CPU_flight_timer).w
		move.w	#6,(Tails_CPU_routine).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locret_57E32:
		rts
; ---------------------------------------------------------------------------

Obj_57E34:
		tst.w	subtype(a0)
		beq.s	loc_57E64
		subq.w	#1,subtype(a0)
		bne.s	locret_57E94
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_57E94
		move.l	#Obj_CutsceneKnuckles,(a1)
		move.w	#$100,x_pos(a1)
		move.b	#$2C,subtype(a1)
		move.w	a1,$20(a0)
		move.w	#$C4E,$3E(a0)

loc_57E64:
		movea.w	$20(a0),a1
		move.l	#$20000,d0
		move.l	#$800,d1
		jsr	(Gradual_SwingOffset).l
		add.w	$3E(a0),d0
		move.w	d0,y_pos(a1)
		tst.l	$2E(a0)
		bmi.s	locret_57E94
		bset	#0,(_unkFAB8).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locret_57E94:
		rts
; ---------------------------------------------------------------------------


Obj_57E96:
		cmpi.b	#4,routine(a0)
		bhi.s	loc_57EB0
		move.w	(Level_frame_counter).w,d0
		andi.w	#$F,d0
		bne.s	loc_57EB0
		moveq	#signextendB(sfx_BigRumble),d0
		jsr	(Play_SFX).l

loc_57EB0:
		moveq	#0,d0
		move.b	routine(a0),d0
		jmp	loc_57EBA(pc,d0.w)
; ---------------------------------------------------------------------------

loc_57EBA:
		bra.w	loc_57ECA
; ---------------------------------------------------------------------------
		bra.w	loc_57EDC
; ---------------------------------------------------------------------------
		bra.w	loc_57F18
; ---------------------------------------------------------------------------
		bra.w	loc_57F3E
; ---------------------------------------------------------------------------

loc_57ECA:
		subq.w	#1,$2E(a0)
		bne.w	locret_57FBE
		move.w	#4,$30(a0)
		addq.b	#4,routine(a0)

loc_57EDC:
		jsr	sub_57FC0(pc)
		cmpi.w	#$600,(Camera_Y_pos).w
		blo.w	locret_57FBE
		jsr	sub_57FE2(pc)
		cmpi.w	#$60C,(Camera_Y_pos).w
		blo.w	locret_57FBE
		lea	(HScroll_table+$E0).w,a1
		lea	word_577C6(pc),a5
		moveq	#($A/2)-1,d0

loc_57F02:
		move.l	(a5)+,(a1)+
		dbf	d0,loc_57F02
		moveq	#signextendB(sfx_Collapse),d0
		jsr	(Play_SFX).l
		addq.b	#4,routine(a0)
		bra.w	locret_57FBE
; ---------------------------------------------------------------------------

loc_57F18:
		jsr	sub_57FC0(pc)
		jsr	sub_57FE2(pc)
		cmpi.w	#$640,(Camera_Y_pos).w
		blo.w	locret_57FBE
		move.w	#$10-1,$2E(a0)
		move.w	#8,$30(a0)
		clr.w	$32(a0)
		addq.b	#4,routine(a0)

loc_57F3E:
		tst.w	(Events_fg_4).w
		bpl.s	locret_57FBE
		tst.w	$2E(a0)
		beq.s	loc_57F5E
		subq.w	#1,$2E(a0)
		bne.s	locret_57FBE
		jsr	(AllocateObject).l
		bne.s	loc_57F5E
		move.l	#Obj_583BE,(a1)

loc_57F5E:
		cmpi.w	#$5C0,(Camera_Y_pos).w
		bhs.s	loc_57F7E
		jsr	sub_58048(pc)
		move.w	(Level_frame_counter).w,d0
		addq.w	#8,d0
		andi.w	#$F,d0
		bne.s	loc_57F7E
		moveq	#signextendB(sfx_DeathEggRiseLoud),d0
		jsr	(Play_SFX).l

loc_57F7E:
		move.w	#$500,d0
		moveq	#0,d1
		move.b	$30(a0),d1
		subq.w	#1,d1
		bcs.s	loc_57F94

loc_57F8C:
		subi.w	#$70,d0
		dbf	d1,loc_57F8C

loc_57F94:
		moveq	#0,d1
		move.b	$31(a0),d1
		sub.w	d1,d0
		move.w	(Camera_Y_pos).w,d1
		sub.w	d0,d1
		bcs.s	locret_57FBE
		cmpi.w	#2,d1
		bls.s	loc_57FAC
		moveq	#2,d1

loc_57FAC:
		sub.w	d1,(Camera_Y_pos).w
		cmpi.w	#$110,(Camera_Y_pos).w
		bhs.s	locret_57FBE
		move.w	#$110,(Camera_Y_pos).w

locret_57FBE:
		rts

; =============== S U B R O U T I N E =======================================


sub_57FC0:
		cmpi.w	#$618,(Camera_Y_pos).w
		blo.s	loc_57FD2
		btst	#0,(Level_frame_counter+1).w
		beq.s	locret_57FE0
		bra.s	loc_57FDC
; ---------------------------------------------------------------------------

loc_57FD2:
		move.w	(Level_frame_counter).w,d0
		andi.w	#3,d0
		beq.s	locret_57FE0

loc_57FDC:
		addq.w	#1,(Camera_Y_pos).w

locret_57FE0:
		rts
; End of function sub_57FC0


; =============== S U B R O U T I N E =======================================


sub_57FE2:
		lea	(Player_1).w,a1
		lea	(Ctrl_1_logical).w,a2
		lea	$30(a0),a3
		bsr.s	sub_58002
		tst.w	(Player_mode).w
		bne.s	locret_58046
		lea	(Player_2).w,a1
		lea	(Ctrl_2_logical).w,a2
		lea	$31(a0),a3
; End of function sub_57FE2


; =============== S U B R O U T I N E =======================================


sub_58002:
		tst.b	object_control(a1)
		bne.s	locret_58046
		tst.b	(a3)
		bmi.s	loc_58016
		subq.b	#1,(a3)
		bpl.s	locret_58046
		move.w	#(button_C_mask<<8)|button_C_mask,(a2)
		rts
; ---------------------------------------------------------------------------

loc_58016:
		tst.w	y_vel(a1)
		bmi.s	loc_58034
		move.w	#$7FFF,y_pos(a1)
		andi.b	#$FC,render_flags(a1)
		move.b	#3,object_control(a1)
		clr.b	anim(a1)
		bra.s	locret_58046
; ---------------------------------------------------------------------------

loc_58034:
		move.w	#$2800,d0
		cmpi.w	#$1A40,x_pos(a1)
		blo.s	loc_58044
		move.w	#$2400,d0

loc_58044:
		move.w	d0,(a2)

locret_58046:
		rts
; End of function sub_58002


; =============== S U B R O U T I N E =======================================


sub_58048:
		lea	(Player_1).w,a1
		lea	$30(a0),a2
		moveq	#0,d3
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_5805C
		moveq	#-1,d3

loc_5805C:
		bsr.s	sub_5806E
		tst.w	(Player_mode).w
		bne.s	locret_58046
		lea	(Player_2).w,a1
		lea	$32(a0),a2
		moveq	#-1,d3
; End of function sub_58048


; =============== S U B R O U T I N E =======================================


sub_5806E:
		tst.w	4(a2)
		bne.w	loc_58192
		cmpi.w	#$910,(a2)
		bne.s	loc_580CC
		st	4(a2)
		move.b	#1,object_control(a1)
		bset	#Status_InAir,status(a1)
		move.b	#1,jumping(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		move.b	#2,anim(a1)
		bset	#Status_Roll,status(a1)
		move.w	#$800,ground_vel(a1)
		move.w	#$400,x_vel(a1)
		move.w	#-$680,y_vel(a1)
		clr.w	2+x_pos(a1)
		clr.w	2+y_pos(a1)
		moveq	#signextendB(sfx_Jump),d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

loc_580CC:
		moveq	#0,d0
		move.b	1(a2),d0
		addq.b	#1,d0
		cmpi.b	#$70,d0
		blo.s	loc_580E0
		subi.b	#$70,d0
		addq.b	#1,(a2)

loc_580E0:
		move.b	d0,1(a2)
		lea	byte_587B4(pc),a6
		move.b	(a6,d0.w),d0
		move.w	d0,d2
		andi.w	#drawing_mask,art_tile(a1)
		addi.b	#$40,d2
		bmi.s	loc_58100
		ori.w	#high_priority,art_tile(a1)

loc_58100:
		jsr	(GetSineCosine).l
		muls.w	#$4C00,d0
		swap	d0
		move.w	#$1A40,x_pos(a1)
		add.w	d0,x_pos(a1)
		muls.w	#$1C00,d1
		swap	d1
		subi.b	#$40,d2
		bpl.s	loc_58128
		neg.w	d1
		subi.w	#$38,d1

loc_58128:
		move.w	#$570,y_pos(a1)
		add.w	d1,y_pos(a1)
		lea	byte_58824(pc),a6
		moveq	#0,d0
		move.b	1(a2),d0
		move.b	(a6,d0.w),d0
		ext.w	d0
		sub.w	d0,y_pos(a1)
		moveq	#0,d0
		move.b	(a2),d0
		subq.w	#1,d0
		bcs.s	loc_58158

loc_5814E:
		subi.w	#$70,y_pos(a1)
		dbf	d0,loc_5814E

loc_58158:
		tst.w	d3
		beq.s	loc_58170
		addq.w	#4,y_pos(a1)
		move.w	#$100,priority(a1)
		tst.b	d2
		bmi.s	loc_58170
		move.w	#$80,priority(a1)

loc_58170:
		addi.w	#$A,d2
		andi.w	#$FF,d2
		move.w	d2,d0
		add.w	d2,d2
		add.w	d0,d2
		lsr.w	#6,d2
		lea	byte_587A8(pc),a2
		move.b	(a2,d2.w),d0
		move.b	d0,mapping_frame(a1)
		jmp	(Perform_Player_DPLC).l
; ---------------------------------------------------------------------------

loc_58192:
		tst.w	4(a2)
		bpl.s	loc_581D2
		move.w	x_vel(a1),d0
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,x_pos(a1)
		move.w	y_vel(a1),d0
		addi.w	#$38,y_vel(a1)
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,y_pos(a1)
		tst.w	y_vel(a1)
		bmi.s	locret_581F0
		move.b	#3,object_control(a1)
		clr.b	mapping_frame(a1)
		clr.b	anim(a1)
		move.w	#3*60,4(a2)
		bra.s	locret_581F0
; ---------------------------------------------------------------------------

loc_581D2:
		cmpa.w	#Player_1,a1
		bne.s	locret_581F0
		subq.w	#1,4(a2)
		bne.s	locret_581F0
		moveq	#signextendB(cmd_FadeOut),d0
		jsr	(Play_Music).l
		move.w	#$B00,d0
		jmp	(StartNewLevel).l
; ---------------------------------------------------------------------------

locret_581F0:
		rts
; End of function sub_5806E

; ---------------------------------------------------------------------------

loc_581F2:
		move.l	#loc_5821E,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$1C,height_pixels(a0)
		move.w	#$80,priority(a0)
		move.w	#make_art_tile(ArtTile_SSZSpiralRamp,2,1),art_tile(a0)
		move.l	#Map_SSZCollapsingBridge,mappings(a0)
		move.b	#9,mapping_frame(a0)

loc_5821E:
		move.w	y_pos(a0),d0
		subi.w	#$24,d0
		cmp.w	(Player_1+y_pos).w,d0
		bhs.w	loc_583A0
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_58234:
		move.l	#loc_58260,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#$80,priority(a0)
		move.w	#make_art_tile(ArtTile_SSZMisc+$20,2,1),art_tile(a0)
		move.l	#Map_SSZCollapsingBridge,mappings(a0)
		move.b	#6,mapping_frame(a0)

loc_58260:
		move.w	y_pos(a0),d0
		move.b	mapping_frame(a0),d1
		subq.b	#6,d1
		beq.s	loc_58288
		subq.b	#1,d1
		beq.s	loc_5827E
		subi.w	#$2C,d0
		cmp.w	(Player_1+y_pos).w,d0
		blo.s	loc_582A6
		bra.w	loc_583A0
; ---------------------------------------------------------------------------

loc_5827E:
		moveq	#-$20,d1
		moveq	#8,d2
		subi.w	#$24,d0
		bra.s	loc_58290
; ---------------------------------------------------------------------------

loc_58288:
		moveq	#-$40,d1
		moveq	#$10,d2
		subi.w	#$1C,d0

loc_58290:
		cmp.w	(Player_1+y_pos).w,d0
		blo.s	loc_582A6
		addq.b	#1,mapping_frame(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_582A6
		moveq	#8,d0
		bra.s	loc_5831E
; ---------------------------------------------------------------------------

loc_582A6:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_582AC:
		move.l	#loc_582D8,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#$200,priority(a0)
		move.w	#make_art_tile(ArtTile_SSZMisc+$20,2,0),art_tile(a0)
		move.l	#Map_SSZCollapsingBridge,mappings(a0)
		move.b	#$B,mapping_frame(a0)

loc_582D8:
		move.w	y_pos(a0),d0
		move.b	mapping_frame(a0),d1
		subi.b	#$B,d1
		beq.s	loc_58302
		subq.b	#1,d1
		beq.s	loc_582F8
		subi.w	#$2C,d0
		cmp.w	(Player_1+y_pos).w,d0
		blo.s	loc_5835A
		bra.w	loc_583A0
; ---------------------------------------------------------------------------

loc_582F8:
		moveq	#$20,d1
		moveq	#8,d2
		subi.w	#$24,d0
		bra.s	loc_5830A
; ---------------------------------------------------------------------------

loc_58302:
		moveq	#$40,d1
		moveq	#$10,d2
		subi.w	#$1C,d0

loc_5830A:
		cmp.w	(Player_1+y_pos).w,d0
		blo.s	loc_5835A
		addq.b	#1,mapping_frame(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_5835A
		moveq	#$D,d0

loc_5831E:
		move.l	#loc_583A6,(a1)
		move.b	#$84,render_flags(a1)
		move.b	#$10,height_pixels(a1)
		move.w	priority(a0),priority(a1)
		move.w	art_tile(a0),art_tile(a1)
		move.l	mappings(a0),mappings(a1)
		move.b	d0,mapping_frame(a1)
		move.w	x_pos(a0),x_pos(a1)
		add.w	d1,x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		add.w	d2,y_pos(a1)

loc_5835A:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_58360:
		move.l	#loc_5838C,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$1C,height_pixels(a0)
		move.w	#$100,priority(a0)
		move.w	#make_art_tile(ArtTile_SSZSpiralRamp,2,1),art_tile(a0)
		move.l	#Map_SSZCollapsingBridge,mappings(a0)
		move.b	#$A,mapping_frame(a0)

loc_5838C:
		move.w	y_pos(a0),d0
		subi.w	#$24,d0
		cmp.w	(Player_1+y_pos).w,d0
		bhs.s	loc_583A0
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_583A0:
		move.l	#loc_583A6,(a0)

loc_583A6:
		tst.b	render_flags(a0)
		bmi.s	loc_583B2
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_583B2:
		jsr	(MoveSprite).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_583BE:
		tst.w	(_unkEE98).w
		bne.s	loc_583C6
		rts
; ---------------------------------------------------------------------------

loc_583C6:
		move.l	#loc_583D2,(a0)
		move.w	#$870,$2E(a0)

loc_583D2:
		move.w	(Level_frame_counter).w,d0
		andi.w	#$F,d0
		bne.s	loc_583E4
		moveq	#signextendB(sfx_BigRumble),d0
		jsr	(Play_SFX).l

loc_583E4:
		tst.w	$30(a0)
		beq.s	loc_583F2
		subq.w	#1,$30(a0)
		bra.w	locret_584A0
; ---------------------------------------------------------------------------

loc_583F2:
		move.w	(Player_1+y_pos).w,d0
		cmpi.w	#$4000,d0
		blo.s	loc_58400
		move.w	#$5C0,d0

loc_58400:
		addi.w	#$198,d0
		move.w	$2E(a0),d1
		cmp.w	d1,d0
		bhi.w	locret_584A0
		move.w	d1,d0
		cmpi.w	#$300,d0
		bhs.s	loc_5841C
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_5841C:
		lsl.w	#4,d1
		andi.w	#$F00,d1
		addi.w	#-$2000,d1
		move.w	d1,(_unkEEFA).w
		lea	word_58894(pc),a2
		cmpi.w	#$380,d0
		blo.s	loc_58442
		lea	$80(a2),a2
		cmpi.w	#$800,d0
		blo.s	loc_58442
		lea	$80(a2),a2

loc_58442:
		lea	byte_58A3E(pc),a3
		move.w	$32(a0),d4
		addq.w	#3,$32(a0)
		move.w	d0,d1
		andi.w	#$70,d0
		adda.w	d0,a2
		subi.w	#$178,d1
		move.w	#$1A08,d2
		moveq	#8-1,d3
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_58494

loc_58468:
		move.l	#loc_584A2,(a1)
		move.w	(a2)+,art_tile(a1)
		move.w	d2,x_pos(a1)
		move.w	d1,y_pos(a1)
		andi.w	#7,d4
		move.b	(a3,d4.w),$2E(a1)
		addq.w	#1,d4
		addi.w	#$10,d2
		jsr	(CreateNewSprite4).l
		dbne	d3,loc_58468

loc_58494:
		subi.w	#$10,$2E(a0)
		move.w	#7,$30(a0)

locret_584A0:
		rts
; ---------------------------------------------------------------------------

loc_584A2:
		move.w	art_tile(a0),d0
		bpl.s	loc_584BE
		clr.w	art_tile(a0)
		addq.w	#1,d0
		beq.s	loc_584E4
		move.b	#1,mapping_frame(a0)
		addq.w	#1,d0
		beq.s	loc_584BE
		addq.b	#1,mapping_frame(a0)

loc_584BE:
		move.l	#loc_584DE,(a0)
		move.b	#$84,render_flags(a0)
		move.b	#8,height_pixels(a0)
		move.w	#$180,priority(a0)
		move.l	#Map_SSZSpiralRampPieces,mappings(a0)

loc_584DE:
		tst.b	render_flags(a0)
		bmi.s	loc_584EA

loc_584E4:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_584EA:
		tst.b	$2E(a0)
		beq.s	loc_584F6
		subq.b	#1,$2E(a0)
		bra.s	loc_584FC
; ---------------------------------------------------------------------------

loc_584F6:
		jsr	(MoveSprite).l

loc_584FC:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
SSZ1_BGDeformArray:
		dc.w   $1D0
		dc.w    $10
		dc.w      8
		dc.w    $18
		dc.w    $10
		dc.w    $10
		dc.w      8
		dc.w    $28
		dc.w    $10
		dc.w      8
		dc.w      8
		dc.w    $28
		dc.w      8
		dc.w    $20
		dc.w      8
		dc.w      8
		dc.w      8
		dc.w    $10
		dc.w    $18
		dc.w    $20
		dc.w    $40
		dc.w    $20
		dc.w    $18
		dc.w    $10
		dc.w      8
		dc.w      8
		dc.w      8
		dc.w    $20
		dc.w      8
		dc.w  $7FFF
word_5853E:
		dc.w $A-1
		dc.w      0,  $C38,   $C0,   $A0
		dc.l byte_585B8
		dc.w      0,  $E58,  $180,  $180
		dc.l byte_585B8
		dc.w      0, $13D8,  $200,  $140
		dc.l byte_58618
		dc.w      0,  $D78,  $2C0,   $E0
		dc.l byte_58618
		dc.w      1,  $F18,  $2C0,   $C0
		dc.l byte_58638
		dc.w      1,  $9D8,  $580,  $140
		dc.l byte_58618
		dc.w      0,  $E18,  $5C0,  $100
		dc.l byte_58658
		dc.w      0,  $F78,  $6C0,  $120
		dc.l byte_58638
		dc.w      0,  $498,  $540,   $40
		dc.l byte_585B8
		dc.w      0,  $618,  $500,   $40
		dc.l byte_585B8
byte_585B8:
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21
byte_58618:
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21
byte_58638:
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21
byte_58658:
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21
		dc.b  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $22, $22, $22, $22, $22, $22, $22, $22
		dc.b  $23, $23, $23, $23, $23, $23, $24, $24, $24, $24, $24, $25, $25, $25, $26, $26, $26, $27, $27, $27
		dc.b  $28, $28, $29, $29, $2A, $2A, $2B, $2B, $2C, $2C, $2D, $2D, $2E, $2F, $2F, $30, $31, $31, $32, $33
		dc.b  $33, $34, $35, $36, $37, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41, $42, $43, $44, $45
		dc.b  $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4E, $4F, $50, $51, $52, $53, $53, $53, $54, $55, $55
		dc.b  $56, $56, $57, $58, $58, $59, $59, $5A, $5A, $5A, $5B, $5B, $5C, $5C, $5C, $5D, $5D, $5E, $5E, $5E
		dc.b  $5E, $5F, $5F, $5F, $5F, $60, $60, $60, $60, $60, $60, $61, $61, $61, $61, $61, $61, $61, $61, $61
		dc.b  $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61
		dc.b  $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61
		dc.b  $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61
		dc.b  $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61
		dc.b  $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61
		even
word_58758:
		dc.w    $10,   $30, $FE00,     1
		dc.w    $44,  $100, $9E00,     2
		dc.w    $78,   $B0, $E600,     1
		dc.w    $AC,  $1C0, $B600,     2
		dc.w    $D8,  $140, $CE00,     1
Map_SSZRoamingClouds:
		include "Levels/SSZ/Misc Object Data/Map - Roaming Clouds.asm"
byte_587A8:
		dc.b  $EF, $FA, $F9, $F8, $F7, $F6, $F5, $F4, $F3, $F2, $F1, $F0
byte_587B4:
		dc.b    0,   2,   5,   7,   9,  $B,  $E, $10, $12, $15, $17, $19, $1B, $1E, $20, $22, $25, $27, $29, $2B
		dc.b  $2E, $30, $32, $35, $37, $39, $3B, $3E, $40, $42, $45, $47, $49, $4B, $4E, $50, $52, $55, $57, $59
		dc.b  $5B, $5E, $60, $62, $65, $67, $69, $6B, $6E, $70, $72, $75, $77, $79, $7B, $7E, $80, $82, $85, $87
		dc.b  $89, $8B, $8E, $90, $92, $95, $97, $99, $9B, $9E, $A0, $A2, $A5, $A7, $A9, $AB, $AE, $B0, $B2, $B5
		dc.b  $B7, $B9, $BB, $BE, $C0, $C2, $C5, $C7, $C9, $CB, $CE, $D0, $D2, $D5, $D7, $D9, $DB, $DE, $E0, $E2
		dc.b  $E5, $E7, $E9, $EB, $EE, $F0, $F2, $F5, $F7, $F9, $FB, $FE
byte_58824:
		dc.b    3,   3,   4,   5,   6,   6,   7,   7,   8,   8,   8,   8,   7,   7,   7,   7,   7,   6,   5,   4
		dc.b    3,   3,   3,   2,   1,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,  -1,  -1,  -1,  -1,  -2
		dc.b   -2,  -2,  -2,  -2,  -2,  -3,  -3,  -3,  -3,  -2,  -2,  -1,  -1,   0,   0,   2,   3,   4,   5,   6
		dc.b    7,   7,   8,   8,   9,   9,   9,   8,   7,   7,   7,   7,   7,   6,   5,   4,   3,   3,   3,   2
		dc.b    1,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,  -1,  -1,  -1,  -1,  -2,  -2,  -1,  -1,  -1
		dc.b   -1,  -2,  -2,  -2,  -2,  -1,  -1,   0,   0,   0,   1,   3
		even
word_58894:
		dc.w  $4000, $4004, $4008, $400C, $480C, $4808, $4804, $4800
		dc.w  $4010, $4014, $4018, $401C, $481C, $4818, $4814, $4810
		dc.w  $4020, $4024, $4028, $402C, $482C, $4828, $4824, $4820
		dc.w  $4020, $4024, $4028, $402C, $482C, $4828, $4824, $4820
		dc.w  $4030, $4034, $4038, $403C, $483C, $4838, $4834, $4830
		dc.w  $4040, $4044, $4048, $404C, $484C, $4848, $4844, $4840
		dc.w  $4020, $4024, $4028, $402C, $482C, $4828, $4824, $4820
		dc.w  $4040, $4044, $4048, $404C, $484C, $4848, $4844, $4840
		dc.w  $4020, $4024, $4028, $402C, $482C, $4828, $4824, $4820
		dc.w  $4040, $4044, $4048, $404C, $484C, $4848, $4844, $4840
		dc.w  $4020, $4024, $4028, $402C, $482C, $4828, $4824, $4820
		dc.w  $4020, $4024, $4028, $402C, $482C, $4828, $4824, $4820
		dc.w  $4030, $4034, $4038, $403C, $483C, $4838, $4834, $4830
		dc.w  $4040, $4044, $4048, $404C, $484C, $4848, $4844, $4840
		dc.w  $4020, $4024, $4028, $402C, $482C, $4828, $4824, $4820
		dc.w  $4040, $4044, $4048, $404C, $484C, $4848, $4844, $4840
		dc.w  $4020, $4024, $4028, $402C, $482C, $4828, $4824, $4820
		dc.w  $4040, $4044, $4048, $404C, $484C, $4848, $4844, $4840
		dc.w  $4020, $4024, $4028, $402C, $482C, $4828, $4824, $4820
		dc.w  $4040, $4044, $4048, $404C, $484C, $4848, $4844, $4840
		dc.w  $4020, $4024, $4028, $402C, $482C, $4828, $4824, $4820
		dc.w  $4040, $4044, $4048, $404C, $484C, $4848, $4844, $4840
		dc.w  $FFFE, $4054, $4058, $405C, $485C, $4858, $4854, $FFFD
		dc.w  $FFFF, $FFFF, $FFFE, $4068, $4868, $FFFD, $FFFF, $FFFF
Map_SSZSpiralRampPieces:
		include "Levels/SSZ/Misc Object Data/Map - Spiral Ramp Pieces.asm"
byte_58A3E:
		dc.b  $1C
		dc.b    8
		dc.b  $10
		dc.b    0
		dc.b    4
		dc.b  $14
		dc.b  $18
		dc.b   $C
		even
; ---------------------------------------------------------------------------

SSZ2_ScreenInit:
		st	(Palette_cycle_counters+$00).w
		jsr	(AllocateObject).l
		bne.s	loc_58A92
		move.l	#Obj_57C1E,(a1)
		move.w	#$A0,x_pos(a1)
		move.b	#$44,$2D(a1)
		moveq	#0,d1
		move.w	d1,(Camera_X_pos_copy).w
		move.w	d1,(Camera_X_pos).w
		move.w	#$649,d1
		move.w	d1,(Camera_Y_pos_copy).w
		move.w	d1,(Camera_Y_pos).w
		st	(Scroll_lock).w
		jsr	(CreateNewSprite4).l
		bne.s	loc_58A92
		move.l	#loc_59078,(a1)
		move.w	#1,$30(a1)

loc_58A92:
		jsr	(Reset_TileOffsetPositionActual).l
		moveq	#0,d1
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

SSZ2_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	(Events_routine_fg).w,d0
		jmp	SSZ2_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

SSZ2_ScreenEvent_Index:
		bra.w	loc_58ACC
; ---------------------------------------------------------------------------
		bra.w	loc_58AE0
; ---------------------------------------------------------------------------
		bra.w	loc_58B20
; ---------------------------------------------------------------------------
		bra.w	loc_58B7C
; ---------------------------------------------------------------------------
		bra.w	loc_58B9E
; ---------------------------------------------------------------------------
		bra.w	loc_58C42
; ---------------------------------------------------------------------------
		bra.w	loc_58C68
; ---------------------------------------------------------------------------

loc_58ACC:
		move.w	(Camera_min_Y_pos).w,d0
		cmp.w	(Camera_max_Y_pos).w,d0
		bne.w	loc_58C68
		addq.w	#4,(Special_V_int_routine).w
		addq.w	#4,(Events_routine_fg).w

loc_58AE0:
		tst.w	(Events_fg_4).w
		beq.w	loc_58C68
		clr.w	(Events_fg_4).w
		movea.w	$24(a3),a1
		movea.w	$28(a3),a5
		moveq	#4-1,d0

loc_58AF6:
		move.b	#$17,(a1)+
		move.b	#$18,(a1)+
		move.b	#$19,(a5)+
		move.b	#$19,(a5)+
		dbf	d0,loc_58AF6
		move.b	#$17,(a1)
		move.b	#$19,(a5)
		st	(Ending_running_flag).w
		addq.w	#4,(Events_routine_fg).w
		jmp	(Refresh_PlaneFullDirect).l
; ---------------------------------------------------------------------------

loc_58B20:
		tst.w	(Events_fg_4).w
		beq.w	loc_58C68
		bmi.w	loc_58C68
		clr.w	(Events_fg_4).w
		move	#$2700,sr
		lea	(VDP_data_port).l,a6
		move.l	#vdpComm(tiles_to_bytes($7F0),VRAM,WRITE),(VDP_control_port).l
		move.l	#$66666666,d0
		moveq	#bytesToLcnt(tiles_to_bytes($10)),d1

loc_58B4C:
		move.l	d0,(a6)
		dbf	d1,loc_58B4C
		move	#$2300,sr
		jsr	(AllocateObject).l
		bne.s	loc_58B64
		move.l	#loc_591D6,(a1)

loc_58B64:
		move.w	#$1F0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		clr.b	(Palette_cycle_counters+$00).w
		addq.w	#4,(Events_routine_fg).w
		bra.w	locret_58C7E
; ---------------------------------------------------------------------------

loc_58B7C:
		move.w	#$200,d1
		move.w	#$100,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.w	locret_58C7E
		clr.w	(Camera_Y_pos_copy).w
		clr.l	(Camera_Y_pos).w
		clr.w	(Camera_X_pos).w
		addq.w	#4,(Events_routine_fg).w

loc_58B9E:
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(sub_5B18E).l
		movem.l	(sp)+,d7-a0/a2-a3
		cmpi.b	#7,(Super_emerald_count).w
		bhs.s	loc_58BBC
		cmpi.b	#7,(Chaos_emerald_count).w
		blo.s	loc_58C1A

loc_58BBC:
		jsr	sub_592EE(pc)
		tst.w	(_unkFAAE).w
		beq.w	locret_58C7E
		move.w	#$14C0,d0
		tst.w	(SK_alone_flag).w
		bne.s	loc_58BD6
		move.w	#$1660,d0

loc_58BD6:
		cmp.w	(Camera_Y_pos).w,d0
		bne.w	locret_58C7E
		tst.w	(Events_routine_bg).w
		bne.w	locret_58C7E
		clr.b	(_unkFAB9).w
		move.w	(Camera_Y_pos_BG_copy).w,d0
		addi.w	#$100,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		clr.w	(Camera_Y_pos_BG_copy+2).w
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Camera_Y_pos_BG_rounded).w
		lea	(Pal_Ending2).l,a1
		lea	(Normal_palette_line_2).w,a5
		moveq	#bytesToLcnt($60),d0

loc_58C0E:
		move.l	(a1)+,(a5)+
		dbf	d0,loc_58C0E
		addq.w	#4,(Events_routine_bg).w
		bra.s	locret_58C7E
; ---------------------------------------------------------------------------

loc_58C1A:
		tst.w	(Events_fg_4).w
		beq.s	locret_58C7E
		lea	(Pal_Ending1).l,a1
		lea	(Normal_palette_line_2).w,a5
		moveq	#bytesToLcnt($60),d0

loc_58C2C:
		move.l	(a1)+,(a5)+
		dbf	d0,loc_58C2C
		move.w	#$7F0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_fg).w

loc_58C42:
		moveq	#0,d1
		move.w	#$700,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	locret_58C7E
		move.w	#$720,d0
		move.w	d0,(Camera_Y_pos_copy).w
		move.w	d0,(Camera_Y_pos).w
		clr.w	(Camera_Y_pos+2).w
		move.w	d0,(Camera_Y_pos_rounded).w
		addq.w	#4,(Events_routine_fg).w

loc_58C68:
		jsr	sub_5928C(pc)
		lea	(Camera_Y_pos_copy).w,a6
		lea	(Camera_Y_pos_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jmp	(Draw_TileRow).l
; ---------------------------------------------------------------------------

locret_58C7E:
		rts
; ---------------------------------------------------------------------------
word_58C80:
		dc.w   $380
		dc.w    $10
		dc.w    $10
		dc.w    $18
		dc.w    $10
		dc.w      8
		dc.w    $10
		dc.w    $10
		dc.w      8
		dc.w    $38
		dc.w    $10
		dc.w    $10
		dc.w    $28
		dc.w      8
		dc.w    $20
		dc.w      8
		dc.w      8
		dc.w      8
		dc.w      8
		dc.w      8
		dc.w    $18
		dc.w    $20
		dc.w    $30
		dc.w      8
		dc.w      8
		dc.w    $10
		dc.w      8
		dc.w    $28
		dc.w    $10
		dc.w    $10
		dc.w    $18
		dc.w    $10
		dc.w      8
		dc.w    $10
		dc.w    $10
		dc.w      8
		dc.w  $7FFF
SSZ2_DeformArray:
		dc.w   $800
		dc.w    $24
		dc.w      4
		dc.w    $14
		dc.w      4
		dc.w    $1C
		dc.w      4
		dc.w    $20
		dc.w  $8080
		dc.w  $7FFF
SSZ2_BGDeformArray:
		dc.w   $120
		dc.w      8
		dc.w      8
		dc.w      4
		dc.w      4
		dc.w      8
		dc.w      8
		dc.w    $18
		dc.w    $10
		dc.w    $10
		dc.w  $7FFF
; ---------------------------------------------------------------------------

SSZ2_BackgroundInit:
		clr.l	(_unkEE9C).w
		jsr	sub_58D3E(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		moveq	#0,d1
		jsr	(Refresh_PlaneFull).l
		jmp	sub_58FBC(pc)
; ---------------------------------------------------------------------------

SSZ2_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	SSZ2_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

SSZ2_BackgroundEvent_Index:
		bra.w	loc_58D1E
; ---------------------------------------------------------------------------
		lea	(Level_layout_main).w,a3

loc_58D1E:
		jsr	sub_58D3E(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l
		jsr	sub_58FBC(pc)
		jmp	(ShakeScreen_Setup).l

; =============== S U B R O U T I N E =======================================


sub_58D3E:
		tst.w	(Events_routine_bg).w
		beq.s	loc_58D6E

loc_58D44:
		lea	(HScroll_table).w,a1
		move.l	(a1),d0
		addi.l	#$8000,(a1)+
		lea	$16(a1),a1
		move.w	#$5E,-(a1)
		clr.w	d0
		move.l	d0,d1
		asr.l	#3,d1
		moveq	#8-1,d2

loc_58D60:
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		dbf	d2,loc_58D60
		rts
; ---------------------------------------------------------------------------

loc_58D6E:
		cmpi.w	#$18,(Events_routine_fg).w
		bhs.w	loc_58F52
		cmpi.w	#$C,(Events_routine_fg).w
		bhs.w	locret_58F50
		lea	(HScroll_table).w,a1
		move.l	(a1),d2
		addi.l	#$1000,(a1)+
		clr.w	(a1)+
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#5,d0
		move.l	d0,d1
		asr.l	#1,d0
		add.l	d2,d0
		swap	d0
		move.w	d0,(a1)
		move.w	d0,4(a1)
		move.w	d0,8(a1)
		move.w	d0,$10(a1)
		move.w	d0,$36(a1)
		move.w	d0,$3A(a1)
		move.w	d0,$3E(a1)
		move.w	d0,$46(a1)
		swap	d0
		add.l	d2,d1
		add.l	d1,d0
		swap	d0
		move.w	d0,6(a1)
		move.w	d0,$A(a1)
		move.w	d0,$E(a1)
		move.w	d0,$14(a1)
		move.w	d0,$3C(a1)
		move.w	d0,$40(a1)
		move.w	d0,$44(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,2(a1)
		move.w	d0,$C(a1)
		move.w	d0,$16(a1)
		move.w	d0,$34(a1)
		move.w	d0,$38(a1)
		move.w	d0,$42(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$12(a1)
		swap	d0
		lea	$18(a1),a1
		moveq	#9-1,d2

loc_58E14:
		swap	d0
		move.w	d0,(a1)+
		swap	d0
		add.l	d1,d0
		dbf	d2,loc_58E14
		cmpi.w	#4,(Events_routine_fg).w
		bhi.s	loc_58E3A
		lea	(HScroll_table+$02A).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		moveq	#9-1,d1

loc_58E32:
		move.w	d0,(a1)+
		dbf	d1,loc_58E32
		bra.s	loc_58E6E
; ---------------------------------------------------------------------------

loc_58E3A:
		lea	(HScroll_table+$004).w,a1
		move.w	$2A(a1),$2C(a1)
		move.w	$28(a1),d0
		move.w	d0,$2A(a1)
		move.w	d0,$2E(a1)
		move.w	$26(a1),$28(a1)
		move.w	$24(a1),$26(a1)
		move.w	$22(a1),$30(a1)
		move.w	$1E(a1),$32(a1)
		move.w	$1A(a1),$34(a1)

loc_58E6E:
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$320,d0
		sub.w	(_unkEE9C).w,d0
		move.w	(Special_V_int_routine).w,d1
		subq.w	#4,d1
		beq.s	loc_58E88
		subq.w	#4,d1
		beq.s	loc_58E88
		addq.w	#8,d0

loc_58E88:
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	#$5E,(Camera_X_pos_BG_copy).w
		lea	(HScroll_table+$0D0).w,a5
		lea	(a5),a6
		move.w	(Events_bg+$00).w,d0
		smi	d6
		bpl.s	loc_58EA2
		neg.w	d0

loc_58EA2:
		swap	d0
		clr.w	d0
		asr.l	#7,d0
		move.w	d0,d1
		swap	d0
		moveq	#0,d2
		moveq	#0,d3
		moveq	#$40-1,d4
		tst.b	d6
		bne.s	loc_58EC8

loc_58EB6:
		add.w	d1,d3
		addx.w	d0,d2
		move.w	d2,-(a5)
		move.w	d2,d5
		neg.w	d5
		move.w	d5,(a6)+
		dbf	d4,loc_58EB6
		bra.s	loc_58ED8
; ---------------------------------------------------------------------------

loc_58EC8:
		add.w	d1,d3
		addx.w	d0,d2
		move.w	d2,(a6)+
		move.w	d2,d5
		neg.w	d5
		move.w	d5,-(a5)
		dbf	d4,loc_58EC8

loc_58ED8:
		lea	(HScroll_table+$160).w,a5
		lea	(a5),a6
		move.w	(Events_bg+$00).w,d0
		smi	d6
		bpl.s	loc_58EE8
		neg.w	d0

loc_58EE8:
		swap	d0
		clr.w	d0
		asr.l	#3,d0
		move.w	d0,d1
		swap	d0
		moveq	#0,d2
		moveq	#0,d3
		moveq	#8-1,d4
		tst.b	d6
		bne.s	loc_58F0E

loc_58EFC:
		add.w	d1,d3
		addx.w	d0,d2
		move.w	d2,-(a5)
		move.w	d2,d5
		neg.w	d5
		move.w	d5,(a6)+
		dbf	d4,loc_58EFC
		bra.s	loc_58F1E
; ---------------------------------------------------------------------------

loc_58F0E:
		add.w	d1,d3
		addx.w	d0,d2
		move.w	d2,(a6)+
		move.w	d2,d5
		neg.w	d5
		move.w	d5,-(a5)
		dbf	d4,loc_58F0E

loc_58F1E:
		lea	(HScroll_table+$170).w,a1
		lea	(HScroll_table+$140).w,a5
		move.w	(Camera_X_pos_BG_copy).w,d0
		move.w	d0,d1
		andi.w	#$F,d1
		beq.s	loc_58F36
		addi.w	#$10,d0

loc_58F36:
		lsr.w	#3,d0
		andi.w	#$FFFE,d0
		adda.w	d0,a5
		move.w	(Camera_Y_pos_BG_copy).w,d0
		addq.w	#8,d0
		moveq	#$14-1,d1

loc_58F46:
		move.w	(a5)+,d2
		add.w	d0,d2
		move.w	d2,(a1)+
		dbf	d1,loc_58F46

locret_58F50:
		rts
; ---------------------------------------------------------------------------

loc_58F52:
		lea	(HScroll_table).w,a1
		move.l	(a1),d0
		subi.l	#$10000,(a1)+
		lea	$110(a1),a1
		clr.w	d0
		move.l	d0,d1
		asr.l	#5,d1
		moveq	#$20-1,d2

loc_58F6A:
		swap	d0
		move.w	d0,-(a1)
		move.w	d0,-(a1)
		move.w	d0,-(a1)
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		dbf	d2,loc_58F6A
		move.w	(a1),d0
		neg.w	d0
		move.w	d0,-4(a1)
		move.w	d0,-$C(a1)
		move.w	8(a1),d0
		neg.w	d0
		move.w	d0,-8(a1)
		move.w	$10(a1),d0
		neg.w	d0
		move.w	d0,-2(a1)
		move.w	$18(a1),d0
		neg.w	d0
		move.w	d0,-$E(a1)
		move.w	$20(a1),d0
		neg.w	d0
		move.w	d0,-$A(a1)
		move.w	$28(a1),d0
		neg.w	d0
		move.w	d0,-6(a1)
		rts
; End of function sub_58D3E


; =============== S U B R O U T I N E =======================================


sub_58FBC:
		tst.w	(Events_routine_bg).w
		beq.s	loc_58FD0
		lea	SSZ2_BGDeformArray(pc),a4
		lea	(HScroll_table+$004).w,a5
		jmp	(ApplyDeformation).l
; ---------------------------------------------------------------------------

loc_58FD0:
		cmpi.w	#$18,(Events_routine_fg).w
		bhs.w	loc_5906A
		cmpi.w	#$C,(Events_routine_fg).w
		bhs.w	loc_59064
		lea	word_58C80(pc),a4
		lea	(HScroll_table+$004).w,a5
		jsr	(ApplyFGDeformation).l
		lea	(H_scroll_buffer+2).w,a1
		lea	(HScroll_table+$050).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d0
		subi.w	#$100,d0
		bmi.s	loc_59018
		subi.w	#$80,d0
		bpl.s	loc_5904A
		move.w	d0,d1
		neg.w	d0
		addi.w	#$80,d1
		add.w	d1,d1
		adda.w	d1,a5
		bra.s	loc_59036
; ---------------------------------------------------------------------------

loc_59018:
		neg.w	d0
		cmpi.w	#$E0,d0
		bhs.s	loc_5904A
		move.w	d0,d1
		addi.w	#-$E0,d0
		neg.w	d0
		cmpi.w	#$80,d0
		blo.s	loc_59032
		move.w	#$80,d0

loc_59032:
		lsl.w	#2,d1
		adda.w	d1,a1

loc_59036:
		subq.w	#1,d0
		move.w	(Camera_X_pos_BG_copy).w,d1
		neg.w	d1

loc_5903E:
		move.w	(a5)+,d2
		add.w	d1,d2
		move.w	d2,(a1)
		addq.w	#4,a1
		dbf	d0,loc_5903E

loc_5904A:
		lea	(Vscroll_buffer).w,a1
		lea	(HScroll_table+$170).w,a5
		move.w	(Camera_Y_pos_copy).w,d0
		swap	d0
		moveq	#$14-1,d1

loc_5905A:
		move.w	(a5)+,d0
		move.l	d0,(a1)+
		dbf	d1,loc_5905A
		rts
; ---------------------------------------------------------------------------

loc_59064:
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

loc_5906A:
		lea	SSZ2_DeformArray(pc),a4
		lea	(HScroll_table+$004).w,a5
		jmp	(ApplyFGDeformation).l
; End of function sub_58FBC

; ---------------------------------------------------------------------------

loc_59078:
		moveq	#0,d0
		move.b	routine(a0),d0
		jmp	loc_59082(pc,d0.w)
; ---------------------------------------------------------------------------

loc_59082:
		bra.w	loc_5908E
; ---------------------------------------------------------------------------
		bra.w	loc_590E4
; ---------------------------------------------------------------------------
		bra.w	loc_59194
; ---------------------------------------------------------------------------

loc_5908E:
		tst.w	(Special_V_int_routine).w
		beq.w	locret_591D4
		addi.l	#$11B,(_unkEE9C).w
		move.l	#$2000,d0
		move.l	#$4A,d1
		jsr	(Gradual_SwingOffset).l
		cmp.w	(Events_bg+$00).w,d0
		beq.w	locret_591D4
		move.w	d0,(Events_bg+$00).w
		bne.w	locret_591D4
		tst.w	(Events_fg_4).w
		bpl.w	locret_591D4
		tst.b	$38(a0)
		bne.s	loc_590D6
		st	$38(a0)
		bra.w	locret_591D4
; ---------------------------------------------------------------------------

loc_590D6:
		clr.w	(Events_fg_4).w
		move.w	#$C,(Special_V_int_routine).w
		addq.b	#4,routine(a0)

loc_590E4:
		cmpi.b	#7,(Super_emerald_count).w
		bhs.s	loc_590F4
		cmpi.b	#7,(Chaos_emerald_count).w
		blo.s	loc_59146

loc_590F4:
		cmpi.w	#$8000,$3C(a0)
		bhs.s	loc_59102
		addi.w	#$20,$3C(a0)

loc_59102:
		move.l	$3A(a0),d0
		sub.l	d0,(_unkEE9C).w
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$318,d0
		sub.w	(_unkEE9C).w,d0
		cmpi.w	#$D0,d0
		beq.s	loc_59124
		bcs.s	loc_59132
		subq.w	#1,(Camera_Y_pos).w
		bra.s	loc_59132
; ---------------------------------------------------------------------------

loc_59124:
		tst.b	$39(a0)
		bne.s	loc_59132
		st	$39(a0)
		st	(_unkFAA9).w

loc_59132:
		cmpi.w	#$2A0,(Camera_Y_pos).w
		bne.w	locret_591D4
		st	(Events_fg_4+1).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_59146:
		cmpi.w	#$8000,$3C(a0)
		bhs.s	loc_59154
		addi.w	#$20,$3C(a0)

loc_59154:
		move.l	$3A(a0),d0
		add.l	d0,(_unkEE9C).w
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$318,d0
		sub.w	(_unkEE9C).w,d0
		cmpi.w	#$D0,d0
		beq.s	loc_59176
		bcc.s	loc_59184
		addq.w	#1,(Camera_Y_pos).w
		bra.s	loc_59184
; ---------------------------------------------------------------------------

loc_59176:
		tst.b	$39(a0)
		bne.s	loc_59184
		st	$39(a0)
		st	(_unkFAA9).w

loc_59184:
		cmpi.w	#$600,(Camera_Y_pos).w
		bne.s	locret_591D4
		st	(Events_fg_4+1).w
		addq.b	#4,routine(a0)

loc_59194:
		cmpi.w	#$18,(Events_routine_fg).w
		blo.s	locret_591D4
		move.l	$3A(a0),d0
		add.l	d0,(Camera_Y_pos).w
		move.w	(Camera_Y_pos).w,d0
		cmpi.w	#$7D0,d0
		blo.s	locret_591D4
		subi.l	#$98,$3A(a0)
		bpl.s	locret_591D4
		cmpi.w	#$804,(Camera_Y_pos).w
		bne.s	locret_591D4
		jsr	(AllocateObject).l
		bne.s	loc_591CE
		move.l	#Obj_5EF68,(a1)

loc_591CE:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locret_591D4:
		rts
; ---------------------------------------------------------------------------

loc_591D6:
		move.l	#loc_59208,(a0)
		move.b	#$40,render_flags(a0)
		move.b	#$40,height_pixels(a0)
		move.w	#$380,priority(a0)
		move.l	#Map_KnuxEndingIslandMask,mappings(a0)
		move.w	#$122,x_pos(a0)
		move.w	#$F0,y_pos(a0)
		move.w	#8,mainspr_childsprites(a0)

loc_59208:
		tst.w	(Events_routine_bg).w
		beq.s	loc_59232
		cmpi.w	#$80,(Camera_Y_pos_BG_copy).w
		bne.s	loc_59218
		bra.s	loc_59220
; ---------------------------------------------------------------------------

loc_59218:
		subi.l	#$6000,(Camera_Y_pos_BG_copy).w

loc_59220:
		move.w	(Camera_Y_pos_BG_copy).w,d0
		subi.w	#$1D0,d0
		neg.w	d0
		addi.w	#$F0,d0
		move.w	d0,y_pos(a0)

loc_59232:
		lea	sub2_x_pos(a0),a1
		move.w	y_pos(a0),d0
		subi.w	#$40,d0
		moveq	#1,d2

loc_59240:
		move.w	#$A2,d1
		moveq	#4-1,d3

loc_59246:
		move.w	d1,(a1)+
		move.w	d0,(a1)+
		addq.w	#2,a1
		addi.w	#$40,d1
		dbf	d3,loc_59246
		addi.w	#$40,d0
		dbf	d2,loc_59240
		cmpi.w	#$18,(Events_routine_fg).w
		bne.s	loc_5926A
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_5926A:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Map_KnuxEndingIslandMask:
		include "General/Ending/Map - Knuckles Ending Island Mask.asm"

; =============== S U B R O U T I N E =======================================


sub_5928C:
		tst.b	(Palette_cycle_counters+$00).w
		bne.s	locret_592BC
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	locret_592BC
		move.w	#7,(Palette_cycle_counter1).w
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#6,d0
		cmpi.w	#$30,d0
		blo.s	loc_592AC
		moveq	#0,d0

loc_592AC:
		move.w	d0,(Palette_cycle_counter0).w
		move.l	Pal_EndingWater(pc,d0.w),(Normal_palette_line_4+$1A).w
		move.w	Pal_EndingWater+$4(pc,d0.w),(Normal_palette_line_4+$1E).w

locret_592BC:
		rts
; End of function sub_5928C

; ---------------------------------------------------------------------------
Pal_EndingWater:
		binclude "General/Ending/Palettes/Water Cycle.bin"
		even

; =============== S U B R O U T I N E =======================================


sub_592EE:
		tst.b	(Palette_cycle_counters+$00).w
		bne.s	locret_59318
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	locret_59318
		move.w	#3,(Palette_cycle_counter1).w
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#4,d0
		cmpi.w	#$38,d0
		blo.s	loc_5930E
		moveq	#0,d0

loc_5930E:
		move.w	d0,(Palette_cycle_counter0).w
		move.l	word_5931A(pc,d0.w),(Normal_palette_line_4+$16).w

locret_59318:
		rts
; End of function sub_592EE

; ---------------------------------------------------------------------------
word_5931A:
		dc.w   $C40,  $400
		dc.w   $E68,  $600
		dc.w   $E80,  $800
		dc.w   $E80,  $800
		dc.w   $EE0,  $A00
		dc.w   $EE0,  $A00
		dc.w   $EE0,  $C00
		dc.w   $C40,  $C00
		dc.w   $E68,  $C00
		dc.w   $E80,  $400
		dc.w   $E80,  $600
		dc.w   $EE0,  $A00
		dc.w   $EA4,  $800
		dc.w   $EA4,  $400
; ---------------------------------------------------------------------------

DEZ1_ScreenInit:
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

DEZ1_ScreenEvent:
		tst.w	(Events_fg_4).w
		beq.s	loc_59378
		clr.w	(Events_fg_4).w
		movea.w	$14(a3),a1
		move.b	#$BD,$6E(a1)
		jmp	(Refresh_PlaneScreenDirect).l
; ---------------------------------------------------------------------------

loc_59378:
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

DEZ1_BackgroundInit:
		clr.w	(Camera_X_pos_BG_copy).w
		clr.w	(Camera_Y_pos_BG_copy).w
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

DEZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	DEZ1_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

DEZ1_BackgroundEvent_Index:
		bra.w	loc_593A8
; ---------------------------------------------------------------------------
		bra.w	loc_593EC
; ---------------------------------------------------------------------------

loc_593A8:
		tst.w	(Events_fg_5).w
		beq.s	loc_593E6
		clr.w	(Events_fg_5).w
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(DEZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$15E0).w,a2
		jsr	(Queue_Kos).l
		lea	(ArtKosM_DEZ2_Secondary).l,a1
		move.w	#tiles_to_bytes($292),d2
		jsr	(Queue_Kos_Module).l
		moveq	#PLCID_38,d0
		jsr	(Load_PLC).l
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(Events_routine_bg).w

loc_593E6:
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

loc_593EC:
		tst.b	(Kos_modules_left).w
		bne.w	loc_59488
		move.w	#$B01,(Current_zone_and_act).w
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(Respawn_table_keep).w
		jsr	(Clear_Switches).l
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		lea	(Normal_palette_line_3).w,a0
		lea	(Pal_DEZ2+$20).l,a1
		moveq	#bytesToLcnt($40),d0

loc_59430:
		move.l	(a1)+,(a0)+
		dbf	d0,loc_59430
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$3600,d0
		move.w	#-$400,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d1,(Player_1+y_pos).w
		sub.w	d0,(Player_2+x_pos).w
		sub.w	d1,(Player_2+y_pos).w
		jsr	(Offset_ObjectsDuringTransition).l
		sub.w	d0,(Camera_X_pos).w
		sub.w	d1,(Camera_Y_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d1,(Camera_Y_pos_copy).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w
		sub.w	d1,(Camera_min_Y_pos).w
		sub.w	d1,(Camera_max_Y_pos).w
		move.w	(Camera_max_Y_pos).w,(Camera_target_max_Y_pos).w
		jsr	(Reset_TileOffsetPositionActual).l
		clr.w	(Events_routine_bg).w

loc_59488:
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

DEZ2_ScreenInit:
		move.w	#4,(Events_routine_fg).w
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

DEZ2_ScreenEvent:
		move.w	(Events_routine_fg).w,d0
		jmp	DEZ2_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

DEZ2_ScreenEvent_Index:
		bra.w	loc_594B4
; ---------------------------------------------------------------------------
		bra.w	loc_594DA
; ---------------------------------------------------------------------------
		bra.w	loc_594F8
; ---------------------------------------------------------------------------

loc_594B4:
		tst.w	(Events_fg_4).w
		beq.s	loc_594F8
		clr.w	(Events_fg_4).w
		movea.w	$38(a3),a1
		addq.w	#1,a1
		move.b	#$D7,(a1)+
		move.b	#$DC,(a1)+
		move.b	#$D7,(a1)
		addq.w	#4,(Events_routine_fg).w
		jmp	(Refresh_PlaneScreenDirect).l
; ---------------------------------------------------------------------------

loc_594DA:
		tst.w	(Events_fg_4).w
		beq.s	loc_594F8
		clr.w	(Events_fg_4).w
		movea.w	$18(a3),a1
		move.b	#$BC,$6B(a1)
		addq.w	#4,(Events_routine_fg).w
		jmp	(Refresh_PlaneScreenDirect).l
; ---------------------------------------------------------------------------

loc_594F8:
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

DEZ2_BackgroundInit:
		move.w	#8,(Events_routine_bg).w
		clr.w	(Camera_X_pos_BG_copy).w
		clr.w	(Camera_Y_pos_BG_copy).w
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

DEZ2_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	DEZ2_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

DEZ2_BackgroundEvent_Index:
		bra.w	loc_59532
; ---------------------------------------------------------------------------
		bra.w	loc_59556
; ---------------------------------------------------------------------------
		bra.w	loc_59566
; ---------------------------------------------------------------------------

loc_59532:
		clr.w	(Camera_X_pos_BG_copy).w
		clr.w	(Camera_Y_pos_BG_copy).w
		jsr	(Reset_TileOffsetPositionEff).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w

loc_59556:
		moveq	#0,d1
		moveq	#0,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	loc_59566
		addq.w	#4,(Events_routine_bg).w

loc_59566:
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

DDZ_ScreenInit:
		jsr	(AllocateObject).l
		bne.s	loc_5957A
		move.l	#loc_81492,(a1)

loc_5957A:
		clr.w	(_unkEE98).w
		clr.w	(_unkEEA0).w
		clr.w	(_unkEE9C).w
		clr.w	(_unkEEA2).w
		moveq	#0,d1
		moveq	#0,d0
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

DDZ_ScreenEvent:
		jsr	sub_59648(pc)
		move.w	(Events_routine_fg).w,d4
		jmp	DDZ_ScreenEvent_Index(pc,d4.w)
; ---------------------------------------------------------------------------

DDZ_ScreenEvent_Index:
		bra.w	loc_595B0
; ---------------------------------------------------------------------------
		bra.w	loc_595C0
; ---------------------------------------------------------------------------
		bra.w	loc_595EE
; ---------------------------------------------------------------------------
		bra.w	loc_59602
; ---------------------------------------------------------------------------

loc_595B0:
		tst.w	(Events_bg+$00).w
		beq.w	locret_59646
		jsr	sub_59672(pc)
		addq.w	#4,(Events_routine_fg).w

loc_595C0:
		cmpi.w	#$200,(Events_bg+$00).w
		bne.s	loc_595D6
		cmpi.w	#$400,d0
		bhs.s	sub_59614
		cmpi.w	#$220,d1
		bhs.s	sub_59614
		bra.s	loc_5961E
; ---------------------------------------------------------------------------

loc_595D6:
		jsr	sub_59672(pc)
		bsr.s	sub_59614
		move.w	#$F0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_fg).w
		bra.s	loc_595F0
; ---------------------------------------------------------------------------

loc_595EE:
		bsr.s	sub_59614

loc_595F0:
		moveq	#0,d1
		moveq	#0,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	locret_59646
		addq.w	#4,(Events_routine_fg).w
		bra.s	locret_59646
; ---------------------------------------------------------------------------

loc_59602:
		cmpi.w	#$400,d0
		blo.s	sub_59614
		cmpi.w	#$800,d0
		bhs.s	sub_59614
		cmpi.w	#$220,d1
		blo.s	loc_5961E

; =============== S U B R O U T I N E =======================================


sub_59614:
		move.w	d2,(_unkEE98).w
		move.w	d3,(_unkEE9C).w
		bra.s	locret_59646
; ---------------------------------------------------------------------------

loc_5961E:
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
; ---------------------------------------------------------------------------

locret_59646:
		rts
; End of function sub_59614


; =============== S U B R O U T I N E =======================================


sub_59648:
		move.w	(_unkEE98).w,d2
		move.w	(_unkEE9C).w,d3
		move.w	(Camera_X_pos_copy).w,d0
		sub.w	(Events_bg+$02).w,d0
		add.w	(Events_bg+$00).w,d0
		move.w	d0,(_unkEE98).w
		move.w	(Camera_Y_pos_copy).w,d1
		sub.w	(Events_bg+$04).w,d1
		addi.w	#$100,d1
		move.w	d1,(_unkEE9C).w
		rts
; End of function sub_59648


; =============== S U B R O U T I N E =======================================


sub_59672:
		move.w	(_unkEE98).w,d5
		move.w	d5,d4
		andi.w	#$FFF0,d5
		move.w	d5,(_unkEEA0).w
		move.w	(_unkEE9C).w,d5
		and.w	(Camera_Y_pos_mask).w,d5
		move.w	d5,(_unkEEA2).w
		rts
; End of function sub_59672

; ---------------------------------------------------------------------------

DDZ_BackgroundInit:
		clr.w	(HScroll_table).w
		jsr	sub_596EA(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		moveq	#0,d1
		jsr	(Refresh_PlaneFull).l
		bra.s	loc_596BC
; ---------------------------------------------------------------------------

DDZ_BackgroundEvent:
		jsr	sub_596EA(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l

loc_596BC:
		lea	DDZ_BGDeformArray(pc),a4
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

; =============== S U B R O U T I N E =======================================


sub_596EA:
		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Events_bg+$06).w,d0
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		asr.l	#3,d1
		moveq	#5,d2
		lea	(HScroll_table+$00E).w,a1

loc_59708:
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		dbf	d2,loc_59708
		rts
; End of function sub_596EA

; ---------------------------------------------------------------------------
DDZ_BGDeformArray:
		dc.w    $B0,   $10,     8,     8,   $18,   $38, $7FFF
; ---------------------------------------------------------------------------

Pachinko_ScreenInit:
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

Pachinko_ScreenEvent:
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

Pachinko_BackgroundInit:
		jsr	Pachinko_BGScroll(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

Pachinko_BackgroundEvent:
		jsr	Pachinko_BGScroll(pc)
		jsr	(DrawBGAsYouMove).l
		jmp	(PlainDeformation).l

; =============== S U B R O U T I N E =======================================


Pachinko_BGScroll:
		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#3,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$A0,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#2,d1
		add.l	d1,d0
		swap	d0
		addi.w	#$60,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; End of function Pachinko_BGScroll

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
		bra.w	loc_597AA
; ---------------------------------------------------------------------------
		bra.w	loc_597E4
; ---------------------------------------------------------------------------

loc_597AA:
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

loc_597E4:
		moveq	#$20,d1
		move.w	#$400,d0
		sub.w	(Events_bg+$00).w,d0
		add.w	(Camera_X_pos_copy).w,d0
		lea	(_unkEE98).w,a1
		bsr.s	sub_59832
		move.w	#$400,d0
		sub.w	(Events_bg+$02).w,d0
		add.w	(Camera_Y_pos_copy).w,d0
		lea	(_unkEE9C).w,a1
		bsr.s	sub_59832
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


sub_59832:
		sub.w	(a1),d0
		smi	d2
		bpl.s	loc_5983A
		neg.w	d0

loc_5983A:
		cmp.w	d1,d0
		bls.s	loc_59840
		move.w	d1,d0

loc_59840:
		tst.b	d2
		beq.s	loc_59846
		neg.w	d0

loc_59846:
		add.w	d0,(a1)
		rts
; End of function sub_59832

; ---------------------------------------------------------------------------

Slots_BackgroundInit:
		lea	(HScroll_table).w,a1
		moveq	#$80-1,d0

loc_59850:
		clr.l	(a1)+
		dbf	d0,loc_59850
		moveq	#0,d1
		moveq	#0,d0
		move.l	d0,(Camera_Y_pos_BG_copy).w
		jsr	(Refresh_PlaneFull).l
		jmp	loc_59990(pc)
; ---------------------------------------------------------------------------

Slots_BackgroundEvent:
		move.l	#$400,d0
		tst.w	(SStage_scalar_index_1).w
		bpl.s	loc_59876
		neg.l	d0

loc_59876:
		add.l	(Events_bg+$06).w,d0
		move.l	#$8000,d1
		cmp.l	d1,d0
		bgt.s	loc_5988A
		neg.l	d1
		cmp.l	d1,d0
		bge.s	loc_5988C

loc_5988A:
		move.l	d1,d0

loc_5988C:
		move.l	d0,(Events_bg+$06).w
		add.l	d0,(Camera_Y_pos_BG_copy).w
		andi.w	#$FF,(Camera_Y_pos_BG_copy).w
		lea	($FF1000).l,a0
		move.l	a0,(Plane_buffer_2_addr).w
		clr.w	(a0)
		clr.w	(Events_bg+$04).w
		lea	word_599DE(pc),a5
		lea	(HScroll_table+$020).w,a6
		moveq	#8-1,d6

loc_598B4:
		move.l	a5,-(sp)
		move.w	d6,-(sp)
		move.w	(a5),d0
		move.l	2(a5),d1
		add.l	d1,(a6)
		bcc.s	loc_598C6
		add.w	d0,(a6)
		bra.s	loc_598CE
; ---------------------------------------------------------------------------

loc_598C6:
		move.w	(a6),d1
		sub.w	d0,d1
		bcs.s	loc_598D2
		move.w	d1,(a6)

loc_598CE:
		st	$A(a6)

loc_598D2:
		move.w	$A(a5),d5
		beq.s	loc_598E0
		tst.w	(Events_bg+$04).w
		bne.w	loc_59962

loc_598E0:
		subq.w	#1,4(a6)
		bmi.s	loc_598EE
		tst.w	$A(a6)
		beq.s	loc_59962
		bra.s	loc_598F4
; ---------------------------------------------------------------------------

loc_598EE:
		move.w	6(a5),4(a6)

loc_598F4:
		move.w	6(a6),d0
		addq.w	#1,d0
		cmp.w	8(a5),d0
		blo.s	loc_59902
		moveq	#0,d0

loc_59902:
		move.w	d0,6(a6)
		clr.w	$A(a6)
		st	(Events_bg+$04).w
		tst.w	d5
		bne.s	loc_5991A
		move.w	(a5),d0
		add.w	d0,8(a6)
		bra.s	loc_59962
; ---------------------------------------------------------------------------

loc_5991A:
		btst	#0,7(a6)
		beq.s	loc_59926
		add.w	$C(a5),d5

loc_59926:
		moveq	#0,d1
		move.w	(a5),d2
		move.w	6(a6),d3
		subq.w	#1,d3
		bcs.s	loc_59938

loc_59932:
		add.w	d2,d1
		dbf	d3,loc_59932

loc_59938:
		move.w	$10(a5),d0
		move.w	$12(a5),d6
		movem.l	d1/d5-d6/a5,-(sp)
		jsr	(sub_4ECAA).l
		movem.l	(sp)+,d1/d5-d6/a5
		tst.w	$E(a5)
		beq.s	loc_59962
		addi.w	#$10,d0
		addi.w	#$100,d5
		jsr	(sub_4ECAA).l

loc_59962:
		move.w	(sp)+,d6
		movea.l	(sp)+,a5
		lea	$14(a5),a5
		lea	$C(a6),a6
		dbf	d6,loc_598B4
		lea	(HScroll_table).w,a1
		lea	(HScroll_table+$020).w,a5
		moveq	#8-1,d0

loc_5997C:
		move.w	(a5),d1
		add.w	8(a5),d1
		move.w	d1,(a1)+
		move.w	d1,$E(a1)
		lea	$C(a5),a5
		dbf	d0,loc_5997C

loc_59990:
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
word_599DE:
		dc.w    $48,     0, $C000,     8,     8, $E000, $FFFE,     1,     0,   $19
		dc.w    $48,     0, $C000,     9,     8, $E200, $FFFE,     1,   $20,   $19
		dc.w    $50,     0, $A000,    $B,   $10, $E400,     0,     1,   $40,   $19
		dc.w    $40,     0, $E000,     4,     8,     0,     0,     0,     0,     0
		dc.w    $40,     1,     0,     3,     8,     0,     0,     0,     0,     0
		dc.w    $48,     0, $C000,    $A,     8, $EB00, $FFFE,     1,   $B0,   $19
		dc.w    $58,     0, $8000,     7,     4, $ED00, $FFFE,     0,   $D0,   $19
		dc.w    $40,     0, $E000,     5,     8,     0,     0,     0,     0,     0
; ---------------------------------------------------------------------------

LRZ3_ScreenInit:
		clr.w	(Camera_max_X_pos).w
		lea	(Player_1).w,a1
		cmpi.w	#$480,x_pos(a1)
		blo.s	loc_59AF8
		lea	(Target_palette_line_2).w,a1
		lea	(Pal_LRZBossFire).l,a5
		moveq	#bytesToLcnt($60),d0

loc_59A9A:
		move.l	(a5)+,(a1)+
		dbf	d0,loc_59A9A

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

loc_59AF8:
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

LRZ3_ScreenEvent:
		move.w	(Events_routine_fg).w,d0
		jmp	LRZ3_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

LRZ3_ScreenEvent_Index:
		bra.w	loc_59B1C
; ---------------------------------------------------------------------------
		bra.w	loc_59B46
; ---------------------------------------------------------------------------
		bra.w	loc_59B88
; ---------------------------------------------------------------------------
		bra.w	loc_59BA4
; ---------------------------------------------------------------------------

loc_59B1C:
		move.w	(Act3_ring_count).w,d0
		beq.s	loc_59B30
		clr.w	(Act3_ring_count).w
		move.w	d0,(Ring_count).w
		move.b	#1,(Update_HUD_ring_count).w

loc_59B30:
		move.l	(Act3_timer).w,d0
		beq.s	loc_59B42
		clr.l	(Act3_timer).w
		move.l	d0,(Timer).w
		st	(Update_HUD_timer).w

loc_59B42:
		addq.w	#4,(Events_routine_fg).w

loc_59B46:
		move.b	#1,(Update_HUD_life_count).w
		tst.w	(Events_fg_4).w
		beq.s	loc_59B78
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

loc_59B78:
		move.w	(Camera_Y_pos).w,d0
		cmp.w	(Camera_max_Y_pos).w,d0
		bne.s	loc_59BA4
		move.w	d0,(Camera_min_Y_pos).w
		bra.s	loc_59BA4
; ---------------------------------------------------------------------------

loc_59B88:
		tst.w	(Events_fg_4).w
		beq.s	loc_59BA4
		clr.w	(Events_fg_4).w
		clr.w	(Camera_X_pos+2).w
		clr.w	(Camera_Y_pos+2).w
		move.w	#$14,(Special_events_routine).w
		addq.w	#4,(Events_routine_fg).w

loc_59BA4:
		move.w	(Events_bg+$0C).w,d1
		beq.s	loc_59BF4
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

loc_59BDA:
		movem.w	d0-d2/d6,-(sp)
		jsr	(Setup_TileRowDraw).l
		movem.w	(sp)+,d0-d2/d6
		addi.w	#$10,d0
		dbf	d2,loc_59BDA
		clr.w	(Events_bg+$0C).w

loc_59BF4:
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

LRZ3_BackgroundInit:
		jsr	(AllocateObject).l
		bne.s	loc_59C08
		move.l	#Obj_59FC4,(a1)

loc_59C08:
		lea	(HScroll_table).w,a1
		move.l	#$600050,d0
		moveq	#$14-1,d1

loc_59C14:
		move.l	d0,(a1)+
		dbf	d1,loc_59C14
		lea	(HScroll_table+$100).w,a1
		move.l	#$30303030,d0
		moveq	#$30-1,d1

loc_59C26:
		move.l	d0,(a1)+
		dbf	d1,loc_59C26
		move.w	(a3),$7C(a3)
		jsr	sub_59D82(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		jmp	sub_59DDE(pc)
; ---------------------------------------------------------------------------

LRZ3_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	LRZ3_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

LRZ3_BackgroundEvent_Index:
		bra.w	loc_59C60
; ---------------------------------------------------------------------------
		bra.w	loc_59C8C
; ---------------------------------------------------------------------------
		bra.w	loc_59D02
; ---------------------------------------------------------------------------
		bra.w	loc_59D24
; ---------------------------------------------------------------------------
		bra.w	loc_59D74
; ---------------------------------------------------------------------------

loc_59C60:
		cmpi.w	#$500,(Camera_Y_pos).w
		blo.s	loc_59C6E
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_59C8C
; ---------------------------------------------------------------------------

loc_59C6E:
		jsr	sub_59D82(pc)

loc_59C72:
		jsr	(DrawBGAsYouMove).l
		move.w	(Events_bg+$04).w,d0
		beq.s	loc_59C88
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	(Events_bg+$06).w,(Camera_Y_pos_BG_copy).w

loc_59C88:
		jmp	sub_59DDE(pc)
; ---------------------------------------------------------------------------

loc_59C8C:
		cmpi.w	#$500,(Camera_Y_pos).w
		blo.s	loc_59CD8
		cmpi.w	#$A00,(Camera_X_pos).w
		bne.s	loc_59CCA
		move.w	(Camera_Y_pos).w,d0
		cmp.w	(Camera_max_Y_pos).w,d0
		bne.s	loc_59CCA
		move.w	#$A00,(Camera_max_X_pos).w
		move.w	d0,(Camera_min_Y_pos).w
		jsr	(AllocateObject).l
		bne.s	loc_59CBE
		move.l	#Obj_LRZEndBoss,(a1)

loc_59CBE:
		move.w	#4,(Special_V_int_routine).w
		addq.w	#8,(Events_routine_bg).w
		bra.s	loc_59D24
; ---------------------------------------------------------------------------

loc_59CCA:
		jsr	sub_59DA2(pc)
		jsr	(DrawBGAsYouMove).l
		jmp	sub_59DDE(pc)
; ---------------------------------------------------------------------------

loc_59CD8:
		move.w	(Camera_X_pos_BG_copy).w,(Events_bg+$04).w
		move.w	(Camera_Y_pos_BG_copy).w,(Events_bg+$06).w
		jsr	sub_59D82(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_59D06
; ---------------------------------------------------------------------------

loc_59D02:
		jsr	sub_59D82(pc)

loc_59D06:
		move.w	(Camera_X_pos_BG_copy).w,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	(Draw_PlaneVertTopDown).l
		bpl.w	loc_59C72
		clr.w	(Events_bg+$04).w
		clr.w	(Events_routine_bg).w
		bra.w	loc_59C72
; ---------------------------------------------------------------------------

loc_59D24:
		tst.w	(Events_fg_5).w
		beq.s	loc_59D30
		tst.w	(Events_bg+$0A).w
		beq.s	loc_59D66

loc_59D30:
		jsr	sub_59DBC(pc)
		lea	word_5A106(pc),a4
		lea	(HScroll_table).w,a5
		moveq	#$F,d6
		moveq	#$14,d5
		jsr	(DrawTilesVDeform2).l
		jsr	sub_59DDE(pc)
		lea	(Vscroll_buffer).w,a1
		lea	(HScroll_table).w,a5
		move.w	(Camera_Y_pos_copy).w,d0
		swap	d0
		moveq	#$14-1,d1

loc_59D5A:
		move.w	(a5),d0
		move.l	d0,(a1)+
		addq.w	#4,a5
		dbf	d1,loc_59D5A
		rts
; ---------------------------------------------------------------------------

loc_59D66:
		clr.w	(Events_fg_5).w
		move.w	#$C,(Special_V_int_routine).w
		addq.w	#4,(Events_routine_bg).w

loc_59D74:
		jsr	sub_59DA2(pc)
		jsr	(DrawBGAsYouMove).l
		jmp	sub_59DDE(pc)

; =============== S U B R O U T I N E =======================================


sub_59D82:
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
; End of function sub_59D82


; =============== S U B R O U T I N E =======================================


sub_59DA2:
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$700,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$500,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		rts
; End of function sub_59DA2


; =============== S U B R O U T I N E =======================================


sub_59DBC:
		bsr.s	sub_59DA2
		lea	(HScroll_table).w,a1
		lea	$113(a1),a5
		moveq	#$30,d1
		moveq	#$14-1,d2

loc_59DCA:
		moveq	#0,d3
		move.b	(a5),d3
		sub.w	d1,d3
		add.w	d0,d3
		move.w	d3,(a1)
		addq.w	#4,a1
		addq.w	#8,a5
		dbf	d2,loc_59DCA
		rts
; End of function sub_59DBC


; =============== S U B R O U T I N E =======================================


sub_59DDE:
		tst.b	(End_of_level_flag).w
		bne.s	loc_59DF2
		tst.b	(_unkFACD).w
		bne.s	loc_59DF2
		cmpi.w	#8,(Events_routine_fg).w
		bhs.s	loc_59DF8

loc_59DF2:
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

loc_59DF8:
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

loc_59E34:
		move.w	(a5)+,d3
		add.w	d0,d3
		move.w	d3,(a1)+
		move.w	(a6)+,d3
		add.w	d1,d3
		move.w	d3,(a1)+
		dbf	d2,loc_59E34
		rts
; End of function sub_59DDE

; ---------------------------------------------------------------------------

loc_59E46:
		tst.w	(Events_bg+$02).w
		beq.s	loc_59E52
		subq.w	#1,(Events_bg+$02).w
		rts
; ---------------------------------------------------------------------------

loc_59E52:
		st	(Scroll_lock).w
		move.w	(Events_bg+$00).w,d0
		jmp	loc_59E5E(pc,d0.w)
; ---------------------------------------------------------------------------

loc_59E5E:
		bra.w	loc_59E7A
; ---------------------------------------------------------------------------
		bra.w	loc_59E90
; ---------------------------------------------------------------------------
		bra.w	loc_59EA8
; ---------------------------------------------------------------------------
		bra.w	loc_59EBE
; ---------------------------------------------------------------------------
		bra.w	loc_59ED4
; ---------------------------------------------------------------------------
		bra.w	loc_59EE8
; ---------------------------------------------------------------------------
		bra.w	loc_59F00
; ---------------------------------------------------------------------------

loc_59E7A:
		move.l	#$20000,d2
		moveq	#0,d1
		cmpi.w	#$410,(Camera_X_pos).w
		blo.w	loc_59F3C
		addq.w	#4,(Events_bg+$00).w

loc_59E90:
		move.l	#$16A00,d2
		move.l	d2,d1
		neg.l	d1
		cmpi.w	#$330,(Camera_Y_pos).w
		bhi.w	loc_59F3C
		addq.w	#4,(Events_bg+$00).w

loc_59EA8:
		move.l	#$20000,d2
		moveq	#0,d1
		cmpi.w	#$650,(Camera_X_pos).w
		blo.w	loc_59F3C
		addq.w	#4,(Events_bg+$00).w

loc_59EBE:
		move.l	#$16A00,d2
		move.l	d2,d1
		neg.l	d1
		cmpi.w	#$2F0,(Camera_Y_pos).w
		bhi.s	loc_59F3C
		addq.w	#4,(Events_bg+$00).w

loc_59ED4:
		move.l	#$20000,d2
		moveq	#0,d1
		cmpi.w	#$910,(Camera_X_pos).w
		blo.s	loc_59F3C
		addq.w	#4,(Events_bg+$00).w

loc_59EE8:
		move.l	#$1D900,d2
		move.l	#$C400,d1
		cmpi.w	#$320,(Camera_Y_pos).w
		blo.s	loc_59F3C
		addq.w	#4,(Events_bg+$00).w

loc_59F00:
		move.l	#$20000,d2
		moveq	#0,d1
		cmpi.w	#$BBF,(Camera_X_pos).w
		blo.s	loc_59F3C
		moveq	#0,d2
		cmpi.w	#$C50,(Player_1+x_pos).w
		blo.s	loc_59F3C
		move.w	#$A00,(Camera_min_X_pos).w
		move.w	#$BC0,(Camera_max_X_pos).w
		move.w	#$560,d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		clr.b	(Scroll_lock).w
		clr.w	(Special_events_routine).w
		rts
; ---------------------------------------------------------------------------

loc_59F3C:
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
		bsr.s	sub_59F82
		movem.w	(sp)+,d0/d2
		lea	(Player_2).w,a1

; =============== S U B R O U T I N E =======================================


sub_59F82:
		cmpi.b	#5,anim(a1)
		bne.s	loc_59F8E
		clr.b	anim(a1)

loc_59F8E:
		addi.w	#$10,d0
		cmp.w	x_pos(a1),d0
		bls.s	loc_59FB4
		btst	#Status_Push,status(a1)
		beq.s	loc_59FA8
		lea	(a1),a0
		jmp	(Kill_Character).l
; ---------------------------------------------------------------------------

loc_59FA8:
		move.w	d0,x_pos(a1)
		asr.l	#8,d2
		move.w	d2,ground_vel(a1)
		bra.s	locret_59FC2
; ---------------------------------------------------------------------------

loc_59FB4:
		addi.w	#$110,d0
		cmp.w	x_pos(a1),d0
		bhi.s	locret_59FC2
		move.w	d0,x_pos(a1)

locret_59FC2:
		rts
; End of function sub_59F82

; ---------------------------------------------------------------------------

Obj_59FC4:
		move.l	#loc_59FDC,(a0)
		move.b	#$C0,height_pixels(a0)
		move.w	#$640,y_pos(a0)
		bset	#7,status(a0)

loc_59FDC:
		cmpi.w	#$C,(Events_routine_bg).w
		bne.w	loc_5A07A
		move.w	(Events_bg+$0A).w,d0
		tst.b	(Events_bg+$09).w
		beq.s	loc_59FFA
		cmpi.w	#$80,d0
		bhs.s	loc_5A000
		addq.w	#1,d0
		bra.s	loc_5A000
; ---------------------------------------------------------------------------

loc_59FFA:
		tst.w	d0
		beq.s	loc_5A000
		subq.w	#1,d0

loc_5A000:
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
		bne.s	loc_5A040
		lea	(HScroll_table+$110).w,a1

loc_5A020:
		move.b	d2,(a1)+
		add.w	d1,d3
		addx.w	d0,d2
		dbf	d4,loc_5A020
		moveq	#$30,d2
		moveq	#0,d3
		moveq	#$10-1,d4
		lea	(HScroll_table+$110).w,a1

loc_5A034:
		sub.w	d1,d3
		subx.w	d0,d2
		move.b	d2,-(a1)
		dbf	d4,loc_5A034
		bra.s	loc_5A062
; ---------------------------------------------------------------------------

loc_5A040:
		lea	(HScroll_table+$1B0).w,a1

loc_5A044:
		move.b	d2,-(a1)
		add.w	d1,d3
		addx.w	d0,d2
		dbf	d4,loc_5A044
		moveq	#$30,d2
		moveq	#0,d3
		moveq	#$10-1,d4
		lea	(HScroll_table+$1B0).w,a1

loc_5A058:
		sub.w	d1,d3
		subx.w	d0,d2
		move.b	d2,(a1)+
		dbf	d4,loc_5A058

loc_5A062:
		move.w	#$A0,d1
		lea	(HScroll_table+$110).w,a2
		move.w	#$AA0,d4
		move.w	d4,x_pos(a0)
		jsr	(SolidObjectTopSloped2).l
		bra.s	loc_5A094
; ---------------------------------------------------------------------------

loc_5A07A:
		move.w	#$180,d1
		move.w	#$40,d2
		move.w	#$30,d3
		move.w	#$B80,d4
		move.w	d4,x_pos(a0)
		jsr	(SolidObjectTop).l

loc_5A094:
		move.w	(Events_bg+$0A).w,d0
		swap	d0
		clr.w	d0
		lsr.l	#7,d0
		move.l	d0,d1
		lsr.l	#1,d1
		add.l	d1,d0
		tst.b	(Events_bg+$08).w
		bne.s	loc_5A0AC
		neg.l	d0

loc_5A0AC:
		move.l	d0,(Events_bg+$14).w
		btst	#p1_standing_bit,status(a0)
		beq.s	loc_5A0DE
		lea	(Player_1).w,a1
		tst.b	(End_of_level_flag).w
		bne.s	loc_5A0D6
		btst	#Status_FireShield,status_secondary(a1)
		bne.s	loc_5A0D6
		tst.b	(_unkFACD).w
		bne.s	loc_5A0D6
		jsr	(Touch_HurtSpikes).l

loc_5A0D6:
		move.l	(Events_bg+$14).w,d0
		add.l	d0,x_pos(a1)

loc_5A0DE:
		btst	#p2_standing_bit,status(a0)
		beq.s	locret_5A104
		lea	(Player_2).w,a1
		tst.b	(End_of_level_flag).w
		bne.s	loc_5A0FC
		tst.b	(_unkFACD).w
		bne.s	loc_5A0FC
		jsr	(Touch_HurtSpikes).l

loc_5A0FC:
		move.l	(Events_bg+$14).w,d0
		add.l	d0,x_pos(a1)

locret_5A104:
		rts
; ---------------------------------------------------------------------------
word_5A106:
		dc.w   $310,   $10,   $10,   $10,   $10,   $10,   $10,   $10,   $10,   $10
		dc.w    $10,   $10,   $10,   $10,   $10,   $10,   $10,   $10,   $10, $7FFF
; ---------------------------------------------------------------------------

HPZ_ScreenInit:
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_5A13E
		move.w	#$AA0,(Camera_max_X_pos).w
		bra.s	loc_5A14C
; ---------------------------------------------------------------------------

loc_5A13E:
		cmpi.w	#$480,(Player_1+y_pos).w
		bhs.s	loc_5A14C
		move.w	#$AA0,(Camera_min_X_pos).w

loc_5A14C:
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

HPZ_ScreenEvent:
		tst.w	(Events_bg+$00).w
		bne.s	loc_5A176
		tst.w	(Palette_fade_timer).w
		bne.s	loc_5A176
		jsr	(AllocateObject).l
		bne.s	loc_5A172
		move.l	#Obj_HPZPaletteControl,(a1)

loc_5A172:
		st	(Events_bg+$00).w

loc_5A176:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		tst.w	(Events_fg_4).w
		beq.s	loc_5A19E
		clr.w	(Events_fg_4).w
		movea.w	$1C(a3),a1
		move.b	#$61,$30(a1)
		move.b	#$61,$31(a1)
		jmp	(Refresh_PlaneScreenDirect).l
; ---------------------------------------------------------------------------

loc_5A19E:
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

HPZ_BackgroundInit:
		move.w	$14(a3),$18(a3)
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_5A1C2
		movea.w	4(a3),a1
		move.b	#$8E,3(a1)
		move.b	#$8F,4(a1)

loc_5A1C2:
		cmpi.w	#$EC0,(Player_1+x_pos).w
		bhs.s	loc_5A1D0
		jsr	sub_5A32C(pc)
		bra.s	loc_5A1DA
; ---------------------------------------------------------------------------

loc_5A1D0:
		move.w	#8,(Events_routine_bg).w
		jsr	sub_5A334(pc)

loc_5A1DA:
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
		bra.w	loc_5A224
; ---------------------------------------------------------------------------
		bra.w	loc_5A288
; ---------------------------------------------------------------------------
		bra.w	loc_5A2A6
; ---------------------------------------------------------------------------
		bra.w	loc_5A30A
; ---------------------------------------------------------------------------

loc_5A224:
		cmpi.w	#$EC0,(Player_1+x_pos).w
		blo.s	loc_5A25E
		jsr	sub_5A334(pc)
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
		bra.s	loc_5A28C
; ---------------------------------------------------------------------------

loc_5A25E:
		jsr	sub_5A32C(pc)

loc_5A262:
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

loc_5A288:
		jsr	sub_5A334(pc)

loc_5A28C:
		lea	HPZ_BGDrawArray(pc),a4
		lea	(HScroll_table-$04).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d1
		jsr	(Draw_PlaneVertBottomUpComplex).l
		bpl.s	loc_5A2E4
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_5A2E4
; ---------------------------------------------------------------------------

loc_5A2A6:
		cmpi.w	#$EC0,(Player_1+x_pos).w
		bhs.s	loc_5A2E0
		jsr	sub_5A32C(pc)
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
		bra.s	loc_5A30E
; ---------------------------------------------------------------------------

loc_5A2E0:
		jsr	sub_5A334(pc)

loc_5A2E4:
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

loc_5A30A:
		jsr	sub_5A32C(pc)

loc_5A30E:
		lea	HPZ_BGDrawArray(pc),a4
		lea	(HScroll_table-$04).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d1
		jsr	(Draw_PlaneVertBottomUpComplex).l
		bpl.w	loc_5A262
		clr.w	(Events_routine_bg).w
		bra.w	loc_5A262

; =============== S U B R O U T I N E =======================================


sub_5A32C:
		move.w	#$348,d2
		moveq	#0,d3
		bra.s	loc_5A33C
; End of function sub_5A32C


; =============== S U B R O U T I N E =======================================


sub_5A334:
		move.w	#$E00,d2
		move.w	#$700,d3

loc_5A33C:
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

loc_5A388:
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d2,d0
		dbf	d1,loc_5A388
		move.w	(HScroll_table+$01A).w,(HScroll_table+$004).w
		rts
; End of function sub_5A334

; ---------------------------------------------------------------------------
HPZ_BGDrawArray:
		dc.w   $200, $7FFF
HPZ_BGDeformArray:
		dc.w   $198,     8,     4,     4,     8,     8,   $10,     8,   $30, $7FFF
; ---------------------------------------------------------------------------

DEZ3_ScreenInit:
		clr.w	(Events_bg+$10).w
		st	(Events_bg+$12).w
		jsr	sub_5A79E(pc)
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

loc_5A3FA:
		clr.b	(a1)+
		dbf	d1,loc_5A3FA
		jsr	(AllocateObject).l
		bne.s	loc_5A442
		move.l	#Obj_5A7C8,(a1)
		jsr	(CreateNewSprite4).l
		bne.s	loc_5A442
		move.l	#Obj_5A8E6,(a1)
		jsr	(CreateNewSprite4).l
		bne.s	loc_5A442
		move.l	#Obj_DEZ3_Boss,(a1)
		move.w	#$3C0,d0
		move.w	#$F8,d1
		move.w	d0,$10(a1)
		move.w	d1,$14(a1)
		move.w	d0,(Events_bg+$02).w
		move.w	d1,(Events_bg+$04).w

loc_5A442:
		move.w	#$6C0,(Events_bg+$00).w
		st	(Scroll_lock).w
		move.w	#$80,d0
		move.w	d0,(Camera_X_pos).w
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d0,(Events_bg+$16).w
		jsr	sub_5A508(pc)
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
		bra.w	loc_5A49A
; ---------------------------------------------------------------------------
		bra.w	loc_5A4C4
; ---------------------------------------------------------------------------

loc_5A49A:
		move.w	(Act3_ring_count).w,d0
		beq.s	loc_5A4AE
		clr.w	(Act3_ring_count).w
		move.w	d0,(Ring_count).w
		move.b	#1,(Update_HUD_ring_count).w

loc_5A4AE:
		move.l	(Act3_timer).w,d0
		beq.s	loc_5A4C0
		clr.l	(Act3_timer).w
		move.l	d0,(Timer).w
		st	(Update_HUD_timer).w

loc_5A4C0:
		addq.w	#4,(Events_routine_fg).w

loc_5A4C4:
		jsr	sub_5A508(pc)
		lea	DEZ3_BGDrawArray(pc),a4
		lea	(HScroll_table).w,a6
		moveq	#2,d5
		move.w	(Camera_Y_pos_rounded).w,d6
		jsr	(Draw_BGNoVert).l
		move.w	(Events_bg+$06).w,d1
		beq.s	locret_5A506
		clr.w	(Events_bg+$06).w
		move.w	#$1E0,d0
		and.w	d0,d1
		moveq	#2,d6
		moveq	#2-1,d2

loc_5A4F0:
		movem.w	d0-d2/d6,-(sp)
		jsr	(Setup_TileRowDraw).l
		movem.w	(sp)+,d0-d2/d6
		addi.w	#$10,d0
		dbf	d2,loc_5A4F0

locret_5A506:
		rts

; =============== S U B R O U T I N E =======================================


sub_5A508:
		moveq	#$20,d0
		add.w	(Screen_shake_offset).w,d0
		move.w	d0,(Camera_Y_pos_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		move.w	d0,(HScroll_table+$00A).w
		andi.w	#$1FF,d0
		move.w	d0,(HScroll_table+$004).w
		rts
; End of function sub_5A508

; ---------------------------------------------------------------------------
DEZ3_BGDrawArray:
		dc.w    $E0, $7FFF
; ---------------------------------------------------------------------------

DEZ3_BackgroundInit:
		lea	(Level_layout_main).w,a3
		move.w	#VRAM_Plane_A_Name_Table,d7
		jsr	sub_5A76C(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		bra.w	loc_5A734
; ---------------------------------------------------------------------------

DEZ3_BackgroundEvent:
		lea	(Level_layout_main).w,a3
		move.w	#VRAM_Plane_A_Name_Table,d7
		jsr	sub_5A76C(pc)
		move.w	(Events_routine_bg).w,d0
		jmp	DEZ3_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

DEZ3_BackgroundEvent_Index:
		bra.w	loc_5A57C
; ---------------------------------------------------------------------------
		bra.w	loc_5A5B0
; ---------------------------------------------------------------------------
		bra.w	loc_5A5E0
; ---------------------------------------------------------------------------
		bra.w	loc_5A606
; ---------------------------------------------------------------------------
		bra.w	loc_5A61A
; ---------------------------------------------------------------------------
		bra.w	loc_5A662
; ---------------------------------------------------------------------------
		bra.w	loc_5A676
; ---------------------------------------------------------------------------
		bra.w	loc_5A71A
; ---------------------------------------------------------------------------
		bra.w	loc_5A72E
; ---------------------------------------------------------------------------

loc_5A57C:
		move.b	#1,(Update_HUD_life_count).w
		tst.w	(Events_fg_5).w
		beq.w	loc_5A72E
		clr.w	(Events_fg_5).w
		movea.w	8(a3),a1
		move.b	#$1A,$D(a1)
		move.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	(Camera_X_pos_BG_copy).w,d1
		moveq	#$15,d6
		jsr	(Refresh_PlaneDirect).l
		addq.w	#4,(Events_routine_bg).w
		bra.w	loc_5A734
; ---------------------------------------------------------------------------

loc_5A5B0:
		tst.w	(Screen_shake_flag).w
		beq.w	loc_5A72E
		jsr	(AllocateObject).l
		bne.s	loc_5A5DC
		move.l	#Obj_5A922,(a1)
		move.w	#$13,$2E(a1)
		move.w	#$2D0,$30(a1)
		move.w	#$2C0,(Events_bg+$16).w
		addq.w	#4,(Events_routine_bg).w

loc_5A5DC:
		bra.w	loc_5A72E
; ---------------------------------------------------------------------------

loc_5A5E0:
		cmpi.w	#$6C0,(Events_bg+$00).w
		beq.w	loc_5A72E
		jsr	(Reset_TileOffsetPositionEff).l
		move.w	#$F0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		move.w	(_unkEE8E).w,(Events_bg+$0C).w
		addq.w	#4,(Events_routine_bg).w

loc_5A606:
		moveq	#0,d1
		moveq	#0,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	loc_5A61A
		clr.w	(Events_bg+$0C).w
		addq.w	#4,(Events_routine_bg).w

loc_5A61A:
		cmpi.w	#$2C0,(Events_bg+$00).w
		beq.w	loc_5A72E
		jsr	(Reset_TileOffsetPositionEff).l
		move.w	#$F0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		move.w	(_unkEE8E).w,(Events_bg+$0C).w
		jsr	(AllocateObject).l
		bne.s	loc_5A65E
		move.l	#Obj_5A94C,(a1)
		move.w	(Camera_X_pos_copy).w,d0
		andi.w	#$FFE0,d0
		move.w	d0,(Events_bg+$16).w
		subi.w	#$10,d0
		move.w	d0,$30(a1)

loc_5A65E:
		addq.w	#4,(Events_routine_bg).w

loc_5A662:
		moveq	#0,d1
		moveq	#0,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	loc_5A676
		clr.w	(Events_bg+$0C).w
		addq.w	#4,(Events_routine_bg).w

loc_5A676:
		tst.w	(Events_bg+$00).w
		beq.w	loc_5A6FE
		jsr	sub_5A79E(pc)
		tst.w	(Events_fg_5).w
		beq.w	loc_5A72E
		clr.w	(Events_fg_5).w
		move.w	(Events_bg+$0A).w,d0
		jmp	loc_5A696(pc,d0.w)
; ---------------------------------------------------------------------------

loc_5A696:
		bra.s	loc_5A69E
; ---------------------------------------------------------------------------
		bra.s	loc_5A6A4
; ---------------------------------------------------------------------------
		bra.s	loc_5A69E
; ---------------------------------------------------------------------------
		bra.s	loc_5A6AA
; ---------------------------------------------------------------------------

loc_5A69E:
		move.w	#$603,d0
		bra.s	loc_5A6B4
; ---------------------------------------------------------------------------

loc_5A6A4:
		move.w	#$903,d0
		bra.s	loc_5A6B4
; ---------------------------------------------------------------------------

loc_5A6AA:
		move.w	#$807,d0
		move.w	#-2,(Events_bg+$0A).w

loc_5A6B4:
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

loc_5A6E2:
		movem.w	d0-d3/d6,-(sp)
		jsr	(Setup_TileRowDraw).l
		movem.w	(sp)+,d0-d3/d6
		addi.w	#$10,d0
		cmp.w	d3,d0
		bhi.s	loc_5A6FC
		dbf	d2,loc_5A6E2

loc_5A6FC:
		bra.s	loc_5A72E
; ---------------------------------------------------------------------------

loc_5A6FE:
		jsr	(Reset_TileOffsetPositionEff).l
		move.w	#$F0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		move.w	(_unkEE8E).w,(Events_bg+$0C).w
		addq.w	#4,(Events_routine_bg).w

loc_5A71A:
		moveq	#0,d1
		moveq	#0,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	loc_5A72E
		clr.w	(Events_bg+$0C).w
		addq.w	#4,(Events_routine_bg).w

loc_5A72E:
		jsr	(DrawBGAsYouMove).l

loc_5A734:
		lea	DEZ3_BGDrawArray(pc),a4
		lea	(HScroll_table+$008).w,a5
		lea	(H_scroll_buffer).w,a1
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Events_bg+$0C).w,d3
		bne.s	loc_5A74E
		move.w	(Camera_X_pos_BG_copy).w,d3

loc_5A74E:
		move.w	#$E0-1,d1
		jsr	(ApplyDeformation2).l
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp
		jmp	(ShakeScreen_Setup).l

; =============== S U B R O U T I N E =======================================


sub_5A76C:
		move.w	(Camera_X_pos_BG_copy).w,(_unkEE8E).w
		tst.w	(Events_bg+$00).w
		bne.s	loc_5A77C
		moveq	#0,d0
		bra.s	loc_5A788
; ---------------------------------------------------------------------------

loc_5A77C:
		move.w	(Camera_X_pos_copy).w,d0
		sub.w	(Events_bg+$02).w,d0
		add.w	(Events_bg+$00).w,d0

loc_5A788:
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	(Camera_Y_pos_copy).w,d0
		sub.w	(Events_bg+$04).w,d0
		addi.w	#$180,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		rts
; End of function sub_5A76C


; =============== S U B R O U T I N E =======================================


sub_5A79E:
		moveq	#0,d1
		move.w	(Events_bg+$10).w,d1
		cmp.w	(Events_bg+$12).w,d1
		beq.s	locret_5A7C6
		move.w	d1,(Events_bg+$12).w
		addq.w	#2,d1
		lsl.w	#2,d1
		addi.l	#ArtUnc_DEZFBLaser,d1
		move.w	#tiles_to_bytes($208),d2
		move.w	#$40,d3
		jsr	(Add_To_DMA_Queue).l

locret_5A7C6:
		rts
; End of function sub_5A79E

; ---------------------------------------------------------------------------

Obj_5A7C8:
		move.l	#loc_5A7EC,(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$130,x_pos(a0)
		move.w	#$F0,y_pos(a0)
		bset	#7,status(a0)
		move.w	#$80,$2E(a0)

loc_5A7EC:
		cmpi.b	#$17,(Current_zone).w
		beq.s	loc_5A7FA
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_5A7FA:
		move.w	(Events_bg+$08).w,d1
		beq.s	loc_5A83C
		clr.w	(Events_bg+$08).w
		cmp.w	(Events_bg+$16).w,d1
		blo.s	loc_5A83C
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_5A82C
		move.l	#Obj_5A872,(a1)
		move.w	d1,x_pos(a1)
		move.w	$2E(a0),d2
		subi.w	#$20,d2
		cmp.w	d1,d2
		bhi.s	loc_5A82C
		move.w	d1,(Events_bg+$06).w

loc_5A82C:
		moveq	#$20,d0
		add.w	d0,(Events_bg+$16).w
		cmp.w	$2E(a0),d1
		blo.s	loc_5A83C
		add.w	d0,x_pos(a0)

loc_5A83C:
		moveq	#-$20,d1
		move.w	(Camera_X_pos_copy).w,d0
		andi.w	#$FFE0,d0
		move.w	$2E(a0),d2
		cmp.w	d2,d0
		beq.s	loc_5A860
		bcs.s	loc_5A858
		cmp.w	(Events_bg+$16).w,d2
		blo.s	loc_5A85C
		neg.w	d1

loc_5A858:
		add.w	d1,x_pos(a0)

loc_5A85C:
		move.w	d0,$2E(a0)

loc_5A860:
		move.w	#$B0,d1
		moveq	#$10,d2
		moveq	#$10,d3
		move.w	x_pos(a0),d4
		jmp	(SolidObjectTop).l
; ---------------------------------------------------------------------------

Obj_5A872:
		move.l	#loc_5A8B2,(a0)
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

loc_5A8B2:
		tst.b	render_flags(a0)
		bmi.s	loc_5A8C4
		move.w	(Camera_X_pos_coarse_back).w,d0
		addi.w	#$400,d0
		move.w	d0,x_pos(a0)

loc_5A8C4:
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
		move.l	#loc_5A904,(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$40,x_pos(a0)
		move.w	#$F0,y_pos(a0)
		bset	#7,status(a0)

loc_5A904:
		cmpi.w	#$6C0,(Events_bg+$00).w
		beq.s	loc_5A912
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_5A912:
		moveq	#$40,d1
		moveq	#$10,d2
		moveq	#$10,d3
		move.w	x_pos(a0),d4
		jmp	(SolidObjectTop).l
; ---------------------------------------------------------------------------

Obj_5A922:
		subq.w	#1,$32(a0)
		bpl.s	locret_5A94A
		move.w	#$10-1,$32(a0)
		move.w	$30(a0),(Events_bg+$08).w
		addi.w	#$20,$30(a0)
		subq.w	#1,$2E(a0)
		bne.s	locret_5A94A
		clr.w	(Screen_shake_flag).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locret_5A94A:
		rts
; ---------------------------------------------------------------------------

Obj_5A94C:
		cmpi.b	#$17,(Current_zone).w
		beq.s	loc_5A95A
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_5A95A:
		tst.w	(Events_bg+$00).w
		bne.s	loc_5A97C
		move.w	(Camera_X_pos_copy).w,d0
		addi.w	#$9C,d0
		cmp.w	$30(a0),d0
		blo.s	locret_5A9AA
		move.w	$30(a0),(Events_bg+$08).w
		addi.w	#$20,$30(a0)
		bra.s	locret_5A9AA
; ---------------------------------------------------------------------------

loc_5A97C:
		cmpi.w	#$110,(Events_bg+$04).w
		bhs.s	locret_5A9AA
		subq.w	#1,$32(a0)
		bpl.s	locret_5A9AA
		move.w	(Events_bg+$02).w,d0
		addi.w	#$90,d0
		cmp.w	$30(a0),d0
		blo.s	locret_5A9AA
		move.w	$30(a0),(Events_bg+$08).w
		addi.w	#$20,$30(a0)
		move.w	#$D,$32(a0)

locret_5A9AA:
		rts
; ---------------------------------------------------------------------------
Map_DEZ3Blocks:
		include "Levels/DEZ/Misc Object Data/Map - Act 3 Blocks.asm"
; ---------------------------------------------------------------------------

HPZS_ScreenInit:
		tst.b	(Chaos_emerald_count).w
		beq.s	loc_5AA14
		move.b	(Current_special_stage).w,d0
		ori.b	#$80,d0
		move.b	d0,(HPZ_current_special_stage).w

loc_5AA14:
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
		jsr	sub_5A334(pc)
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
		jsr	sub_5A334(pc)
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

Ending_ScreenInit:
		jsr	(AllocateObject).l
		bne.s	loc_5AAB0
		move.l	#Obj_5D86A,(a1)

loc_5AAB0:
		st	(Ending_running_flag).w
		st	(Scroll_lock).w
		move.b	#3,(Player_1+object_control).w
		move.l	#$2000000,d0
		move.l	d0,(Camera_X_pos).w
		move.l	d0,(Camera_X_pos_copy).w
		move.l	d0,(Camera_Y_pos).w
		move.l	d0,(Camera_Y_pos_copy).w
		clr.l	(_unkEE98).w
		clr.l	(_unkEE9C).w
		move.w	#$2B4,(Events_bg+$02).w
		jsr	sub_5B11C(pc)
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

Ending_ScreenEvent:
		move.w	(Events_routine_fg).w,d0
		jmp	Ending_ScreenEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

Ending_ScreenEvent_Index:
		bra.w	loc_5AB36
; ---------------------------------------------------------------------------
		bra.w	loc_5AB58
; ---------------------------------------------------------------------------
		bra.w	loc_5AB6E
; ---------------------------------------------------------------------------
		bra.w	loc_5ABBC
; ---------------------------------------------------------------------------
		bra.w	loc_5AC70
; ---------------------------------------------------------------------------
		bra.w	loc_5ACFC
; ---------------------------------------------------------------------------
		bra.w	loc_5AD16
; ---------------------------------------------------------------------------
		bra.w	loc_5AD30
; ---------------------------------------------------------------------------
		bra.w	loc_5AD56
; ---------------------------------------------------------------------------
		bra.w	loc_5AD8E
; ---------------------------------------------------------------------------
		bra.w	loc_5AE0A
; ---------------------------------------------------------------------------
		bra.w	loc_5AE76
; ---------------------------------------------------------------------------
		bra.w	loc_5AE90
; ---------------------------------------------------------------------------
		bra.w	loc_5AEA8
; ---------------------------------------------------------------------------
		bra.w	loc_5AED4
; ---------------------------------------------------------------------------

loc_5AB36:
		tst.w	(Events_fg_4).w
		beq.w	loc_5AEE4
		clr.w	(Events_fg_4).w
		move.w	(_unkEE98).w,(Events_bg+$00).w
		jsr	sub_5AEEA(pc)
		jsr	(Reset_TileOffsetPositionActual).l
		addq.w	#4,(Events_routine_fg).w
		bra.s	loc_5AB62
; ---------------------------------------------------------------------------

loc_5AB58:
		tst.w	(Events_fg_4).w
		bne.s	loc_5AB66
		jsr	sub_5AEEA(pc)

loc_5AB62:
		bra.w	loc_5AEE4
; ---------------------------------------------------------------------------

loc_5AB66:
		clr.w	(Events_fg_4).w
		addq.w	#4,(Events_routine_fg).w

loc_5AB6E:
		jsr	sub_5AEEA(pc)
		cmpi.b	#7,(Chaos_emerald_count).w
		blo.s	loc_5AB96
		moveq	#0,d0
		move.w	(Events_bg+$06).w,d0
		addi.w	#$10,d0
		cmpi.w	#$8000,d0
		blo.s	loc_5AB8E
		move.w	#$8000,d0

loc_5AB8E:
		move.w	d0,(Events_bg+$06).w
		sub.l	d0,(Events_bg+$02).w

loc_5AB96:
		tst.w	(Events_fg_4).w
		beq.w	loc_5AEE4
		clr.w	(Events_fg_4).w
		move.w	#$40-1,(Palette_fade_info).w
		move.w	#$15,(Events_bg+$08).w
		st	(Palette_fade_timer).w
		st	(Palette_cycle_counters+$00).w
		addq.w	#4,(Events_routine_fg).w
		bra.s	loc_5ABC0
; ---------------------------------------------------------------------------

loc_5ABBC:
		jsr	sub_5AEEA(pc)

loc_5ABC0:
		move.l	a0,-(sp)
		jsr	(Pal_ToBlack).l
		movea.l	(sp)+,a0
		subq.w	#1,(Events_bg+$08).w
		bpl.w	loc_5AEE4
		clearRAM	Sprite_table_input,(Sprite_table_input_end-Sprite_table_input)
		clearRAM	Player_2,(Kos_decomp_buffer-Player_2)-2
		cmpi.b	#7,(Super_emerald_count).w
		bhs.s	loc_5AC04
		move.w	#$24,(Events_routine_fg).w
		bra.w	loc_5ADC0
; ---------------------------------------------------------------------------

loc_5AC04:
		jsr	(AllocateObject).l
		bne.s	loc_5AC12
		move.l	#Obj_5DFEE,(a1)

loc_5AC12:
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(AIZ1_128x128_Kos).l,a1
		lea	(RAM_start).l,a2
		jsr	(Queue_Kos).l
		lea	(AIZ1_16x16_Primary_Kos).l,a1
		lea	(Block_table).w,a2
		jsr	(Queue_Kos).l
		lea	(AIZ1_16x16_MainLevel_Kos).l,a1
		lea	(Block_table+$268).w,a2
		jsr	(Queue_Kos).l
		lea	(AIZ1_8x8_Primary_KosM).l,a1
		move.w	#tiles_to_bytes($000),d2
		jsr	(Queue_Kos_Module).l
		lea	(AIZ1_8x8_MainLevel_KosM).l,a1
		move.w	#tiles_to_bytes($0BE),d2
		jsr	(Queue_Kos_Module).l
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(Events_routine_fg).w

loc_5AC70:
		tst.b	(Kos_modules_left).w
		bne.w	loc_5AEE4
		movem.l	d7-a0/a2-a3,-(sp)
		clr.w	(Current_zone_and_act).w
		move.b	#1,(Last_star_post_hit).w
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		move.w	#$D01,(Current_zone_and_act).w
		clr.b	(Last_star_post_hit).w
		moveq	#PalID_SonicTails,d0
		jsr	(LoadPalette).l
		moveq	#PalID_AIZ,d0
		jsr	(LoadPalette).l
		lea	(Pal_SSZ2+$20).l,a1
		lea	(Target_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

loc_5ACB8:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_5ACB8
		jsr	(Adjust_AIZ1Chunks2).l
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$1EB8,d0
		move.w	d0,(Camera_X_pos).w
		move.w	d0,(Camera_X_pos_copy).w
		move.w	#$1E0,d0
		move.w	d0,(Camera_Y_pos).w
		move.w	d0,(Camera_Y_pos_copy).w
		jsr	(Reset_TileOffsetPositionActual).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_fg).w

loc_5ACFC:
		move.w	(Camera_X_pos_copy).w,d1
		move.w	(Camera_Y_pos_copy).w,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.w	loc_5AEE4
		addq.w	#4,(Events_routine_bg).w
		addq.w	#4,(Events_routine_fg).w

loc_5AD16:
		cmpi.w	#$10,(Events_routine_bg).w
		blo.w	loc_5AEE4
		move.w	#$40-1,(Palette_fade_info).w
		move.w	#$15,(Events_bg+$08).w
		addq.w	#4,(Events_routine_fg).w

loc_5AD30:
		move.l	a0,-(sp)
		jsr	(Pal_FromBlack).l
		movea.l	(sp)+,a0
		subq.w	#1,(Events_bg+$08).w
		bpl.w	loc_5AEE4
		clr.w	(Palette_fade_timer).w
		clr.b	(Palette_cycle_counters+$00).w
		clr.w	(Palette_cycle_counter1).w
		clr.w	(Palette_cycle_counter0).w
		addq.w	#4,(Events_routine_fg).w

loc_5AD56:
		tst.w	(Events_fg_4).w
		bne.s	loc_5AD72
		addi.l	#$1000,(Events_bg+$0A).w
		move.l	a0,-(sp)
		jsr	(AnPal_AIZ1).l
		movea.l	(sp)+,a0
		bra.w	loc_5AEE4
; ---------------------------------------------------------------------------

loc_5AD72:
		clr.w	(Events_fg_4).w
		move.w	#$40-1,(Palette_fade_info).w
		move.w	#$15,(Events_bg+$08).w
		st	(Palette_fade_timer).w
		st	(Palette_cycle_counters+$00).w
		addq.w	#4,(Events_routine_fg).w

loc_5AD8E:
		move.l	a0,-(sp)
		jsr	(Pal_ToBlack).l
		movea.l	(sp)+,a0
		subq.w	#1,(Events_bg+$08).w
		bpl.w	loc_5AEE4
		clearRAM	Sprite_table_input,(Sprite_table_input_end-Sprite_table_input)
		clearRAM	Player_2,(Kos_decomp_buffer-Player_2)-2

loc_5ADC0:
		jsr	(AllocateObject).l
		bne.s	loc_5ADCE
		move.l	#Obj_Ending,(a1)

loc_5ADCE:
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(SSZ2_128x128_Kos).l,a1
		lea	(RAM_start).l,a2
		jsr	(Queue_Kos).l
		lea	(SSZ2_16x16_Kos).l,a1
		lea	(Block_table).w,a2
		jsr	(Queue_Kos).l
		lea	(ArtKosM_SSZ2).l,a1
		moveq	#tiles_to_bytes($000),d2
		jsr	(Queue_Kos_Module).l
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(Events_routine_fg).w

loc_5AE0A:
		tst.b	(Kos_modules_left).w
		bne.w	loc_5AEE4
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		moveq	#PalID_SonicTails,d0
		jsr	(LoadPalette).l
		lea	(Pal_Ending1).l,a1
		lea	(Target_palette_line_2).w,a5
		moveq	#bytesToLcnt($60),d0

loc_5AE36:
		move.l	(a1)+,(a5)+
		dbf	d0,loc_5AE36
		jsr	sub_5B11C(pc)
		movem.l	(sp)+,d7-a0/a2-a3
		move.l	#$2000000,d0
		move.l	d0,(Camera_X_pos).w
		move.l	d0,(Camera_X_pos_copy).w
		move.l	d0,(Camera_Y_pos).w
		move.l	d0,(Camera_Y_pos_copy).w
		jsr	(Reset_TileOffsetPositionActual).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_fg).w

loc_5AE76:
		move.w	(Camera_X_pos_copy).w,d1
		move.w	(Camera_Y_pos_copy).w,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	loc_5AEE4
		move.w	#$14,(Events_routine_bg).w
		addq.w	#4,(Events_routine_fg).w

loc_5AE90:
		cmpi.w	#4,(Events_routine_bg).w
		bhi.s	loc_5AEE4
		move.w	#$40-1,(Palette_fade_info).w
		move.w	#$15,(Events_bg+$08).w
		addq.w	#4,(Events_routine_fg).w

loc_5AEA8:
		move.l	a0,-(sp)
		jsr	(Pal_FromBlack).l
		movea.l	(sp)+,a0
		subq.w	#1,(Events_bg+$08).w
		bpl.s	loc_5AEE4
		clr.w	(Palette_fade_timer).w
		clr.b	(Palette_cycle_counters+$00).w
		clr.w	(Palette_cycle_counter1).w
		clr.w	(Palette_cycle_counter0).w
		clr.l	(Camera_Y_pos).w
		clr.l	(Camera_Y_pos_copy).w
		addq.w	#4,(Events_routine_fg).w

loc_5AED4:
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(sub_5B18E).l
		movem.l	(sp)+,d7-a0/a2-a3
		rts
; ---------------------------------------------------------------------------

loc_5AEE4:
		jmp	(DrawTilesAsYouMove).l

; =============== S U B R O U T I N E =======================================


sub_5AEEA:
		move.w	(_unkEE98).w,d0
		sub.w	(Events_bg+$00).w,d0
		addi.w	#$140,d0
		move.w	d0,(Camera_X_pos_copy).w
		move.w	(_unkEE9C).w,d0
		sub.w	(Events_bg+$02).w,d0
		move.w	d0,(Camera_Y_pos_copy).w
		rts
; End of function sub_5AEEA

; ---------------------------------------------------------------------------

Ending_BackgroundInit:
		jsr	sub_5B092(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		move.w	#$200,d1
		jsr	(Refresh_PlaneFull).l
		lea	Ending_BGDeformArray1(pc),a4
		lea	(HScroll_table+$004).w,a5
		jmp	(ApplyDeformation).l
; ---------------------------------------------------------------------------

Ending_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	Ending_BackgroundEvent_Index(pc,d0.w)
; ---------------------------------------------------------------------------

Ending_BackgroundEvent_Index:
		bra.w	loc_5AF4E
; ---------------------------------------------------------------------------
		bra.w	loc_5AF84
; ---------------------------------------------------------------------------
		bra.w	loc_5AFC4
; ---------------------------------------------------------------------------
		bra.w	loc_5AFF0
; ---------------------------------------------------------------------------
		bra.w	loc_5B012
; ---------------------------------------------------------------------------
		bra.w	loc_5B03A
; ---------------------------------------------------------------------------
		bra.w	loc_5B072
; ---------------------------------------------------------------------------

loc_5AF4E:
		tst.w	(Events_fg_5).w
		bne.s	loc_5AF5A
		jsr	sub_5B092(pc)
		bra.s	loc_5AF88
; ---------------------------------------------------------------------------

loc_5AF5A:
		clr.w	(Events_fg_5).w
		lea	(Pal_Ending1).l,a1
		lea	(Normal_palette_line_2).w,a5
		moveq	#bytesToLcnt($60),d0

loc_5AF6A:
		move.l	(a1)+,(a5)+
		dbf	d0,loc_5AF6A
		jsr	sub_5B116(pc)
		move.w	#$220,d0
		move.w	d0,(_unkEE9C).w
		move.w	d0,(Camera_Y_pos_BG_rounded).w
		addq.w	#4,(Events_routine_bg).w

loc_5AF84:
		jsr	sub_5B0A8(pc)

loc_5AF88:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	#$200,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l
		lea	Ending_BGDeformArray1(pc),a4
		tst.w	(Events_routine_bg).w
		beq.s	loc_5AFAA
		lea	Ending_BGDeformArray2(pc),a4

loc_5AFAA:
		lea	(HScroll_table+$004).w,a5
		jsr	(ApplyDeformation).l
		lea	sub_592EE(pc),a1
		tst.w	(Events_routine_bg).w
		beq.s	loc_5AFC2
		lea	sub_5928C(pc),a1

loc_5AFC2:
		jmp	(a1)
; ---------------------------------------------------------------------------

loc_5AFC4:
		jsr	(AIZ1_Deform).l
		jsr	(Reset_TileOffsetPositionEff).l
		clr.l	(HScroll_table).w
		move.w	d2,(HScroll_table+$006).w
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_5AFF6
; ---------------------------------------------------------------------------

loc_5AFF0:
		jsr	(AIZ1_Deform).l

loc_5AFF6:
		lea	(AIZ1_BGDrawArray).l,a4
		lea	(HScroll_table-$04).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d1
		jsr	(Draw_PlaneVertBottomUpComplex).l
		bpl.s	loc_5B020
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_5B020
; ---------------------------------------------------------------------------

loc_5B012:
		jsr	(AIZ1_Deform).l
		move.w	(Events_bg+$0A).w,d0
		sub.w	d0,(Camera_Y_pos_BG_copy).w

loc_5B020:
		lea	(AIZ1_BGDrawArray).l,a4
		lea	(HScroll_table).w,a5
		moveq	#$20,d6
		moveq	#2,d5
		jsr	(Draw_BG).l
		jmp	(AIZ1_ApplyDeformWater).l
; ---------------------------------------------------------------------------

loc_5B03A:
		movea.w	$1C(a3),a1
		addq.w	#4,a1
		move.b	#$1A,(a1)+
		move.b	#$1B,(a1)+
		move.b	#$1A,(a1)+
		move.b	#$1B,(a1)+
		jsr	sub_5B0A8(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_5B076
; ---------------------------------------------------------------------------

loc_5B072:
		jsr	sub_5B0A8(pc)

loc_5B076:
		move.w	#$200,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.w	loc_5AF88
		move.w	#4,(Events_routine_bg).w
		bpl.w	loc_5AF88

; =============== S U B R O U T I N E =======================================


sub_5B092:
		move.w	(_unkEE9C).w,d0
		cmpi.w	#$120,d0
		bls.s	loc_5B0A0
		move.w	#$120,d0

loc_5B0A0:
		move.w	d0,(Camera_Y_pos_BG_copy).w
		jmp	loc_58D44(pc)
; End of function sub_5B092


; =============== S U B R O U T I N E =======================================


sub_5B0A8:
		move.w	(_unkEE9C).w,(Camera_Y_pos_BG_copy).w
		move.w	(_unkEE98).w,d0
		swap	d0
		clr.w	d0
		move.l	d0,d1
		asr.l	#4,d1
		lea	(HScroll_table).w,a1
		add.l	(a1),d1
		addi.l	#$800,(a1)+
		lea	$10(a1),a1
		moveq	#$20-1,d2

loc_5B0CC:
		swap	d0
		move.w	d0,(a1)+
		move.w	d0,(a1)+
		move.w	d0,(a1)+
		move.w	d0,(a1)+
		swap	d0
		add.l	d1,d0
		dbf	d2,loc_5B0CC
		lea	(HScroll_table+$014).w,a1
		move.w	(a1),d0
		move.w	d0,-4(a1)
		move.w	d0,-$C(a1)
		move.w	8(a1),d0
		move.w	d0,-8(a1)
		move.w	$10(a1),d0
		move.w	d0,-2(a1)
		move.w	$18(a1),d0
		move.w	d0,-$E(a1)
		move.w	$20(a1),d0
		move.w	d0,-$A(a1)
		move.w	$28(a1),d0
		move.w	d0,-6(a1)
		rts
; End of function sub_5B0A8


; =============== S U B R O U T I N E =======================================


sub_5B116:
		lea	(Normal_palette_line_2).w,a6
		bra.s	loc_5B120
; End of function sub_5B116


; =============== S U B R O U T I N E =======================================


sub_5B11C:
		lea	(Target_palette_line_2).w,a6

loc_5B120:
		lea	(Target_palette_line_2).w,a5
		lea	Pal_5B16E(pc),a1
		moveq	#bytesToLcnt($20),d0

loc_5B12A:
		move.l	(a1),(a5)+
		move.l	(a1)+,(a6)+
		dbf	d0,loc_5B12A
		lea	(Pal_SSZ2+$20).l,a1
		moveq	#bytesToLcnt($20),d0

loc_5B13A:
		move.l	(a1),(a5)+
		move.l	(a1)+,(a6)+
		dbf	d0,loc_5B13A
		rts
; End of function sub_5B11C

; ---------------------------------------------------------------------------
Ending_BGDeformArray1:
		dc.w    $A0
		dc.w      8
		dc.w      8
		dc.w      4
		dc.w      4
		dc.w      8
		dc.w      8
		dc.w    $18
		dc.w    $10
		dc.w    $10
		dc.w  $7FFF
Ending_BGDeformArray2:
		dc.w   $300
		dc.w    $24
		dc.w      4
		dc.w    $14
		dc.w      4
		dc.w    $1C
		dc.w      4
		dc.w    $20
		dc.w  $8080
		dc.w  $7FFF
Pal_5B16E:
		binclude "General/Ending/Palettes/Sky.bin"
		even

; =============== S U B R O U T I N E =======================================


sub_5B18E:
		move.w	(_unkFA86).w,d0
		move.w	off_5B19A(pc,d0.w),d0
		jmp	off_5B19A(pc,d0.w)
; End of function sub_5B18E

; ---------------------------------------------------------------------------
off_5B19A:
		dc.w loc_5B1A2-off_5B19A
		dc.w loc_5B1F4-off_5B19A
		dc.w loc_5B204-off_5B19A
		dc.w locret_5B2D4-off_5B19A
; ---------------------------------------------------------------------------

loc_5B1A2:
		addq.w	#2,(_unkFA86).w
		clr.b	(_unkFACC).w
		clr.l	(Camera_Y_pos).w
		clr.l	(V_scroll_value).w
		clr.w	(_unkFAAE).w
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_5B1D2
		jsr	(AllocateObject).l
		bne.s	loc_5B1D2
		move.l	#Obj_Song_Fade_Transition,(a1)
		move.b	#mus_CreditsK,subtype(a1)

loc_5B1D2:
		bsr.w	sub_5B514
		move.w	#$EEE,(Normal_palette+$2).w
		move.w	#$EE,(Normal_palette_line_2+$2).w
		lea	PLC_SKCredits(pc),a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------
PLC_SKCredits: plrlistheader
		plreq ArtTile_Ending_CreditsText, ArtNem_CreditsText
PLC_SKCredits_End
; ---------------------------------------------------------------------------

loc_5B1F4:
		subq.w	#1,(_unkF660).w
		bpl.s	locret_5B202
		addq.w	#2,(_unkFA86).w
		bsr.w	sub_5B42A

locret_5B202:
		rts
; ---------------------------------------------------------------------------

loc_5B204:
		move.l	(Camera_Y_pos).w,d0
		move.l	d0,d1
		add.l	(_unkFAC8).w,d0
		move.l	d0,(Camera_Y_pos).w
		swap	d0
		swap	d1
		eor.w	d0,d1
		btst	#4,d1
		beq.s	locret_5B282
		lsl.w	#4,d0
		addi.w	#$E00,d0
		move.w	d0,d1
		andi.w	#$F00,d1
		bsr.w	sub_5B2D6
		moveq	#0,d2
		tst.w	(SK_alone_flag).w
		beq.s	loc_5B238
		moveq	#8,d2

loc_5B238:
		add.w	(_unkFAAE).w,d2
		movea.l	off_5B284(pc,d2.w),a1
		move.w	(_unkFA84).w,d2
		move.w	(a1,d2.w),d2
		lea	(a1,d2.w),a1
		move.w	(a1)+,d2
		cmpi.w	#-8,d2
		beq.s	loc_5B294
		cmpi.w	#-$C,d2
		beq.s	loc_5B29E
		move.w	d2,d3
		andi.w	#$FF00,d0
		andi.w	#$FF00,d3
		cmp.w	d0,d3
		bne.s	locret_5B282
		move.w	#make_art_tile(ArtTile_Ending_CreditsText,0,1),d6
		bclr	#0,d2
		beq.s	loc_5B276
		move.w	#make_art_tile(ArtTile_Ending_CreditsText,1,1),d6

loc_5B276:
		andi.w	#$FFE,d2
		bsr.w	sub_5B318
		addq.w	#2,(_unkFA84).w

locret_5B282:
		rts
; ---------------------------------------------------------------------------
off_5B284:
		dc.l CreditsText_Part1
		dc.l CreditsText_Part2
		dc.l CreditsText_Part1_SK
		dc.l CreditsText_Part2_SK
; ---------------------------------------------------------------------------

loc_5B294:
		addq.w	#4,(_unkFAAE).w
		clr.w	(_unkFA84).w
		rts
; ---------------------------------------------------------------------------

loc_5B29E:
		addq.w	#2,(_unkFA86).w
		clr.l	(Timer).w
		st	(Events_fg_4).w
		st	(_unkFACC).w
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_5B2B8
		rts
; ---------------------------------------------------------------------------

loc_5B2B8:
		tst.b	(_unkFA88).w
		bmi.s	loc_5B2CE
		jsr	(AllocateObject).l
		bne.s	locret_5B2CC
		move.l	#Obj_5EF68,(a1)

locret_5B2CC:
		rts
; ---------------------------------------------------------------------------

loc_5B2CE:
		clr.b	(_unkFAB9).w
		rts
; ---------------------------------------------------------------------------

locret_5B2D4:
		rts

; =============== S U B R O U T I N E =======================================


sub_5B2D6:
		move	#$2700,sr
		lea	(VDP_data_port).l,a6
		move.w	d1,d2
		addi.w	#VRAM_Plane_A_Name_Table,d2
		swap	d2
		clr.w	d2
		swap	d2
		lsl.l	#2,d2
		lsr.w	#2,d2
		ori.w	#$4000,d2
		swap	d2
		move.l	#$80<<16,d3
		moveq	#0,d4
		moveq	#2-1,d5

loc_5B300:
		move.l	d2,VDP_control_port-VDP_data_port(a6)
		moveq	#$28-1,d6

loc_5B306:
		move.w	d4,(a6)
		dbf	d6,loc_5B306
		add.l	d3,d2
		dbf	d5,loc_5B300
		move	#$2300,sr

locret_5B316:
		rts
; End of function sub_5B2D6


; =============== S U B R O U T I N E =======================================


sub_5B318:
		bsr.w	sub_5B36C
		move	#$2700,sr
		lea	(VDP_data_port).l,a6
		addi.w	#VRAM_Plane_A_Name_Table,d2
		swap	d2
		clr.w	d2
		swap	d2
		lsl.l	#2,d2
		lsr.w	#2,d2
		ori.w	#$4000,d2
		swap	d2
		move.l	d2,d3
		addi.l	#$80<<16,d3
		lea	(Chunk_table+$7000).l,a1
		move.l	d2,VDP_control_port-VDP_data_port(a6)
		subq.w	#1,d0
		move.w	d0,d1

loc_5B350:
		move.w	(a1)+,(a6)
		dbf	d0,loc_5B350
		lea	(Chunk_table+$7080).l,a1
		move.l	d3,VDP_control_port-VDP_data_port(a6)

loc_5B360:
		move.w	(a1)+,(a6)
		dbf	d1,loc_5B360
		move	#$2300,sr
		rts
; End of function sub_5B318


; =============== S U B R O U T I N E =======================================


sub_5B36C:
		lea	(Chunk_table+$7000).l,a2
		lea	(Chunk_table+$7080).l,a3
		moveq	#0,d0

loc_5B37A:
		moveq	#0,d1
		move.b	(a1)+,d1
		beq.s	locret_5B316
		cmpi.b	#" ",d1
		beq.w	loc_5B420
		cmpi.b	#"?",d1
		beq.w	loc_5B418
		cmpi.b	#"!",d1
		beq.s	loc_5B410
		cmpi.b	#"&",d1
		beq.s	loc_5B408
		cmpi.b	#")",d1
		beq.s	loc_5B400
		cmpi.b	#"(",d1
		beq.s	loc_5B3F8
		cmpi.b	#".",d1
		beq.s	loc_5B3F0
		cmpi.b	#"I",d1
		beq.s	loc_5B3DC
		addq.w	#2,d0
		subi.b	#"A",d1
		lsl.w	#3,d1
		lea	CreditsText_PlaneMap(pc),a4
		adda.w	d1,a4

loc_5B3C2:
		move.w	(a4)+,d5
		add.w	d6,d5
		move.w	d5,(a2)+
		move.w	(a4)+,d5
		add.w	d6,d5
		move.w	d5,(a2)+
		move.w	(a4)+,d5
		add.w	d6,d5
		move.w	d5,(a3)+
		move.w	(a4)+,d5
		add.w	d6,d5
		move.w	d5,(a3)+
		bra.s	loc_5B37A
; ---------------------------------------------------------------------------

loc_5B3DC:
		addq.w	#1,d0
		lea	CreditsText_PlaneMap.LetterI(pc),a4

loc_5B3E2:
		move.w	(a4)+,d5
		add.w	d6,d5
		move.w	d5,(a2)+
		move.w	(a4)+,d5
		add.w	d6,d5
		move.w	d5,(a3)+
		bra.s	loc_5B37A
; ---------------------------------------------------------------------------

loc_5B3F0:
		addq.w	#1,d0
		lea	CreditsText_PlaneMap.Period(pc),a4
		bra.s	loc_5B3E2
; ---------------------------------------------------------------------------

loc_5B3F8:
		addq.w	#1,d0
		lea	CreditsText_PlaneMap.LeftBracket(pc),a4
		bra.s	loc_5B3E2
; ---------------------------------------------------------------------------

loc_5B400:
		addq.w	#1,d0
		lea	CreditsText_PlaneMap.RightBracket(pc),a4
		bra.s	loc_5B3E2
; ---------------------------------------------------------------------------

loc_5B408:
		addq.w	#2,d0
		lea	CreditsText_PlaneMap.Ampersand(pc),a4
		bra.s	loc_5B3C2
; ---------------------------------------------------------------------------

loc_5B410:
		addq.w	#1,d0
		lea	CreditsText_PlaneMap.Exclamation(pc),a4
		bra.s	loc_5B3E2
; ---------------------------------------------------------------------------

loc_5B418:
		addq.w	#2,d0
		lea	CreditsText_PlaneMap.QuestionMark(pc),a4
		bra.s	loc_5B3C2
; ---------------------------------------------------------------------------

loc_5B420:
		addq.w	#1,d0
		clr.w	(a2)+
		clr.w	(a3)+
		bra.w	loc_5B37A
; End of function sub_5B36C


; =============== S U B R O U T I N E =======================================


sub_5B42A:
		lea	(ArtKosM_ANDKnuckles).l,a1
		move.w	#tiles_to_bytes(ArtTile_Ending_ANDKnuckles),d2
		jsr	(Queue_Kos_Module).l
		move.w	(Player_mode).w,d0
		moveq	#0,d1
		andi.w	#3,d0
		subq.w	#2,d0
		bmi.s	loc_5B452
		beq.s	loc_5B44E
		addi.w	#$18,d1

loc_5B44E:
		addi.w	#$18,d1

loc_5B452:
		tst.w	(SK_alone_flag).w
		bne.s	loc_5B45C
		addi.w	#$C,d1

loc_5B45C:
		tst.b	(_unkFA88).w
		bmi.s	loc_5B46C
		beq.s	loc_5B468
		addi.w	#4,d1

loc_5B468:
		addi.w	#4,d1

loc_5B46C:
		movea.l	off_5B472(pc,d1.w),a2
		jmp	(a2)
; End of function sub_5B42A

; ---------------------------------------------------------------------------
off_5B472:
		dc.l loc_5B4C4
		dc.l loc_5B4C4
		dc.l loc_5B4C4
		dc.l sub_5B4E8
		dc.l sub_5B4E8
		dc.l loc_5B4F8
		dc.l sub_5B4E8
		dc.l sub_5B4E8
		dc.l loc_5B4F8
		dc.l sub_5B4E8
		dc.l sub_5B4E8
		dc.l loc_5B4F8
		dc.l loc_5B4C4
		dc.l loc_5B4BA
		dc.l loc_5B4BA
		dc.l sub_5B4E8
		dc.l loc_5B4DE
		dc.l loc_5B4D4
; ---------------------------------------------------------------------------

loc_5B4BA:
		lea	PLC_CreditsKnuxPose(pc),a1
		jsr	(Load_PLC_Raw).l

loc_5B4C4:
		lea	(ArtKosM_SKPoseBanner).l,a1
		move.w	#tiles_to_bytes(ArtTile_Ending_Logo),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_5B4D4:
		lea	PLC_S3EndingGraphics(pc),a1
		jsr	(Load_PLC_Raw).l

loc_5B4DE:
		lea	PLC_CreditsKnuxPose(pc),a1
		jsr	(Load_PLC_Raw).l

; =============== S U B R O U T I N E =======================================


sub_5B4E8:
		lea	(ArtKosM_S3PoseBanner).l,a1
		move.w	#tiles_to_bytes(ArtTile_Ending_Logo),d2
		jmp	(Queue_Kos_Module).l
; End of function sub_5B4E8

; ---------------------------------------------------------------------------

loc_5B4F8:
		bsr.s	sub_5B4E8
		lea	PLC_S3EndingGraphics(pc),a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------
PLC_S3EndingGraphics: plrlistheader
		plreq ArtTile_Ending_S3Sprites, ArtNem_S3EndingGraphics
PLC_S3EndingGraphics_End

PLC_CreditsKnuxPose: plrlistheader
		plreq ArtTile_Ending_KnuxEndPose, ArtNem_KnuxEndPose
PLC_CreditsKnuxPose_End

; =============== S U B R O U T I N E =======================================


sub_5B514:
		moveq	#0,d1
		tst.w	(SK_alone_flag).w
		bne.s	loc_5B520
		addi.w	#$24,d1

loc_5B520:
		btst	#6,(Graphics_flags).w
		beq.s	loc_5B52C
		addi.w	#$12,d1

loc_5B52C:
		move.w	(Player_mode).w,d0
		subq.w	#2,d0
		bmi.s	loc_5B53E
		beq.s	loc_5B53A
		addi.w	#6,d1

loc_5B53A:
		addi.w	#6,d1

loc_5B53E:
		tst.b	(_unkFA88).w
		bmi.s	loc_5B54A
		beq.s	loc_5B548
		addq.w	#2,d1

loc_5B548:
		addq.w	#2,d1

loc_5B54A:
		lea	CreditsText_ScrollSpeed(pc),a1
		moveq	#0,d0
		move.w	(a1,d1.w),d0
		lsl.l	#8,d0
		move.l	d0,(_unkFAC8).w
		lea	CreditsText_ScrollDelay(pc),a1
		move.w	(a1,d1.w),(_unkF660).w
		rts
; End of function sub_5B514

; ---------------------------------------------------------------------------
CreditsText_PlaneMap:
		dc.w      0,  $800,     1,     2	; A
		dc.w      3,     4,     5,     6	; B
		dc.w      7,     8,     9,    $A	; C
		dc.w      3,  $807,    $B,  $809	; D
		dc.w      3,    $C,     5,    $D	; E
		dc.w      3,    $C,    $E,    $F	; F
		dc.w      7,     8,     9,   $10	; G
		dc.w    $11,  $811,    $E, $180B	; H
.LetterI:	dc.w    $11,   $12,     0,     0	; I
		dc.w    $13,  $811,   $14,   $15	; J
		dc.w    $16,   $17,   $18,   $19	; K
		dc.w    $11,   $13,    $B,   $1A	; L
		dc.w    $1B,   $1C,   $1D,   $1E	; M
		dc.w    $1B,  $811,   $1D,   $1F	; N
		dc.w      7,  $807,     9,  $809	; O
		dc.w    $20,   $21,   $22,   $23	; P
		dc.w      7,  $807,     9,   $24	; Q
		dc.w    $20,   $21,   $25,   $26	; R
		dc.w   $821,    $C,   $27,     6	; S
		dc.w    $28,   $29,   $2A,   $2B	; T
		dc.w    $11,  $811,  $815,   $15	; U
		dc.w    $2C,  $82C,   $2D,  $82D	; V
		dc.w    $2E,  $811,   $2F,   $30	; W
		dc.w    $31,  $831,   $32,  $832	; X
		dc.w    $31,   $33,   $2A,   $2B	; Y
		dc.w   $80C,   $34,   $35,   $36	; Z
.Period:	dc.w    $13,   $37			; .
.LeftBracket:	dc.w    $38, $1038			; (
.RightBracket:	dc.w   $838, $1838			; )
.Ampersand:	dc.w    $39,   $3A,   $3B,   $3C	; &
.Exclamation:	dc.w   $812,   $3D			; !
.QuestionMark:	dc.w  $180A,   $3E,   $3F,   $40	; ?
CreditsText_ScrollDelay:
		; S&K NTSC     None  Chaos Emeralds  Super Emeralds
		dc.w      13*60  +0,      11*60 +30,      13*60  +0	; Sonic
		dc.w      12*60 +30,      12*60 +30,      12*60 +30	; Tails (unused)
		dc.w       2*60 +45,       2*60  +0,       2*60  +0	; Knuckles
		; S&K PAL      None  Chaos Emeralds  Super Emeralds
		dc.w      11*50  +0,       8*50 +48,      11*50  +0	; Sonic
		dc.w       1*50 +10,       1*50 +10,       1*50 +10	; Tails (unused)
		dc.w       2*50 +35,       3*50  +0,       2*50  +0	; Knuckles
		; S3K NTSC     None  Chaos Emeralds  Super Emeralds
		dc.w      12*60 +30,      11*60  +0,              0	; Sonic
		dc.w      12*60 +30,      12*60 +30,              0	; Tails
		dc.w       2*60 +45,       2*60  +0,       2*60  +0	; Knuckles
		; S3K PAL      None  Chaos Emeralds  Super Emeralds
		dc.w      10*50 +20,       8*50 +13,              0	; Sonic
		dc.w      10*50 +20,      10*50 +20,              0	; Tails
		dc.w       2*50  +0,       3*50  +0,       3*50  +0	; Knuckles
CreditsText_ScrollSpeed:
		; S&K NTSC     None  Chaos Emeralds  Super Emeralds
		dc.w            $C3,            $C3,            $C3	; Sonic
		dc.w           $100,           $100,           $100	; Tails (unused)
		dc.w            $BD,            $B1,            $B1	; Knuckles
		; S&K PAL      None  Chaos Emeralds  Super Emeralds
		dc.w            $E8,            $E8,           $100	; Sonic
		dc.w           $100,           $100,           $100	; Tails (unused)
		dc.w            $E5,            $D6,           $100	; Knuckles
		; S3K NTSC     None  Chaos Emeralds  Super Emeralds
		dc.w            $CE,            $CE,            $CF	; Sonic
		dc.w            $CE,            $CE,            $CD	; Tails
		dc.w            $C8,            $BC,            $BC	; Knuckles
		; S3K PAL      None  Chaos Emeralds  Super Emeralds
		dc.w            $F5,            $F5,            $FD	; Sonic
		dc.w            $F5,            $F5,            $FB	; Tails
		dc.w            $F2,            $E2,            $E2	; Knuckles
CreditsText_Part1_SK:
		dc.w byte_5B72E-CreditsText_Part1_SK
		dc.w byte_5B744-CreditsText_Part1_SK
		dc.w byte_5B756-CreditsText_Part1_SK
		dc.w byte_5B76A-CreditsText_Part1_SK
		dc.w byte_5B77C-CreditsText_Part1_SK
		dc.w byte_5B78E-CreditsText_Part1_SK
		dc.w byte_5B7A0-CreditsText_Part1_SK
		dc.w byte_5B7AC-CreditsText_Part1_SK
		dc.w byte_5B7B8-CreditsText_Part1_SK
		dc.w byte_5B7C4-CreditsText_Part1_SK
		dc.w byte_5B7D8-CreditsText_Part1_SK
		dc.w byte_5B7EE-CreditsText_Part1_SK
		dc.w byte_5B802-CreditsText_Part1_SK
		dc.w byte_5B81A-CreditsText_Part1_SK
		dc.w byte_5B82E-CreditsText_Part1_SK
		dc.w byte_5B840-CreditsText_Part1_SK
		dc.w byte_5B852-CreditsText_Part1_SK
		dc.w byte_5B85E-CreditsText_Part1_SK
		dc.w byte_5B874-CreditsText_Part1_SK
		dc.w byte_5B886-CreditsText_Part1_SK
		dc.w byte_5B89A-CreditsText_Part1_SK
		dc.w byte_5B8B0-CreditsText_Part1_SK
		dc.w byte_5B8C6-CreditsText_Part1_SK
		dc.w byte_5B8D4-CreditsText_Part1_SK
		dc.w byte_5B8E4-CreditsText_Part1_SK
		dc.w byte_5B8F4-CreditsText_Part1_SK
		dc.w byte_5B908-CreditsText_Part1_SK
		dc.w byte_5B918-CreditsText_Part1_SK
		dc.w byte_5B928-CreditsText_Part1_SK
		dc.w byte_5B938-CreditsText_Part1_SK
		dc.w byte_5B948-CreditsText_Part1_SK
		dc.w byte_5B958-CreditsText_Part1_SK
		dc.w byte_5B96E-CreditsText_Part1_SK
		dc.w byte_5B982-CreditsText_Part1_SK
		dc.w byte_5B992-CreditsText_Part1_SK
		dc.w byte_5B9A2-CreditsText_Part1_SK
byte_5B72E:	dc.b $F
		dc.b 7
		dc.b "EXECUTIVE PRODUCER",0
		even
byte_5B744:	dc.b $11
		dc.b $E
		dc.b "HAYAO NAKAYAMA",0
		even
byte_5B756:	dc.b $21
		dc.b $B
		dc.b "PROJECT MANAGERS",0
		even
byte_5B76A:	dc.b $23
		dc.b $10
		dc.b "HISASHI SUZUKI",0
		even
byte_5B77C:	dc.b $24
		dc.b $E
		dc.b "SHINOBU TOYODA",0
		even
byte_5B78E:	dc.b $25
		dc.b $E
		dc.b "MASAHARU YOSHII",0
		even
byte_5B7A0:	dc.b $35
		dc.b $19
		dc.b "PRODUCER",0
		even
byte_5B7AC:	dc.b $37
		dc.b $18
		dc.b "YUJI NAKA",0
		even
byte_5B7B8:	dc.b $47
		dc.b $1B
		dc.b "DIRECTOR",0
		even
byte_5B7C4:	dc.b $49
		dc.b 8
		dc.b "HIROKAZU YASUHARA",0
		even
byte_5B7D8:	dc.b $59
		dc.b 9
		dc.b "LEAD GAME DESIGNER",0
		even
byte_5B7EE:	dc.b $5B
		dc.b 8
		dc.b "HIROKAZU YASUHARA",0
		even
byte_5B802:	dc.b $6B
		dc.b 3
		dc.b "SENIOR GAME DESIGNERS",0
		even
byte_5B81A:	dc.b $6D
		dc.b $A
		dc.b "HISAYOSHI YOSHIDA",0
		even
byte_5B82E:	dc.b $6E
		dc.b $10
		dc.b "TAKASHI IIZUKA",0
		even
byte_5B840:	dc.b $7E
		dc.b $B
		dc.b "LEAD PROGRAMMER",0
		even
byte_5B852:	dc.b $80
		dc.b $18
		dc.b "YUJI NAKA",0
		even
byte_5B85E:	dc.b $90
		dc.b 7
		dc.b "SENIOR PROGRAMMERS",0
		even
byte_5B874:	dc.b $92
		dc.b $C
		dc.b "TAKAHIRO HAMANO",0
		even
byte_5B886:	dc.b $93
		dc.b 8
		dc.b "MASANOBU YAMAMOTO",0
		even
byte_5B89A:	dc.b $A3
		dc.b 7
		dc.b "CHARACTER DESIGNER",0
		even
byte_5B8B0:	dc.b $A5
		dc.b 6
		dc.b "TAKASHI THOMAS YUDA",0
		even
byte_5B8C6:	dc.b $B5
		dc.b $17
		dc.b "C.G. ARTIST",0
		even
byte_5B8D4:	dc.b $B7
		dc.b $12
		dc.b "KUNITAKE AOKI",0
		even
byte_5B8E4:	dc.b $C7
		dc.b $13
		dc.b "ENEMY ARTIST",0
		even
byte_5B8F4:	dc.b $C9
		dc.b $A
		dc.b "SATOSHI YOKOKAWA",0
		even
byte_5B908:	dc.b $D9
		dc.b $11
		dc.b "SCENE ARTISTS",0
		even
byte_5B918:	dc.b $DB
		dc.b $12
		dc.b "KUNITAKE AOKI",0
		even
byte_5B928:	dc.b $DC
		dc.b $14
		dc.b "CHIE YOSHIDA",0
		even
byte_5B938:	dc.b $DD
		dc.b $12
		dc.b "TSUNEKO AOKI",0
		even
byte_5B948:	dc.b $DE
		dc.b $10
		dc.b "SHIGERU OKADA",0
		even
byte_5B958:	dc.b $DF
		dc.b 6
		dc.b "TAKASHI THOMAS YUDA",0
		even
byte_5B96E:	dc.b $E0
		dc.b $A
		dc.b "SATOSHI YOKOKAWA",0
		even
byte_5B982:	dc.b $F0
		dc.b $11
		dc.b "ART ASSISTANT",0
		even
byte_5B992:	dc.b $F2
		dc.b $12
		dc.b "OSAMU OHASHI",0
		even
byte_5B9A2:	dc.b $FF
		dc.b $F8
CreditsText_Part2_SK:
		dc.w byte_5B9F6-CreditsText_Part2_SK
		dc.w byte_5BA08-CreditsText_Part2_SK
		dc.w byte_5BA1A-CreditsText_Part2_SK
		dc.w byte_5BA2C-CreditsText_Part2_SK
		dc.w byte_5BA32-CreditsText_Part2_SK
		dc.w byte_5BA42-CreditsText_Part2_SK
		dc.w byte_5BA4A-CreditsText_Part2_SK
		dc.w byte_5BA5E-CreditsText_Part2_SK
		dc.w byte_5BA70-CreditsText_Part2_SK
		dc.w byte_5BA82-CreditsText_Part2_SK
		dc.w byte_5BA94-CreditsText_Part2_SK
		dc.w byte_5BAA2-CreditsText_Part2_SK
		dc.w byte_5BABA-CreditsText_Part2_SK
		dc.w byte_5BAD2-CreditsText_Part2_SK
		dc.w byte_5BAE2-CreditsText_Part2_SK
		dc.w byte_5BAF0-CreditsText_Part2_SK
		dc.w byte_5BB02-CreditsText_Part2_SK
		dc.w byte_5BB12-CreditsText_Part2_SK
		dc.w byte_5BB2A-CreditsText_Part2_SK
		dc.w byte_5BB3C-CreditsText_Part2_SK
		dc.w byte_5BB4C-CreditsText_Part2_SK
		dc.w byte_5BB62-CreditsText_Part2_SK
		dc.w byte_5BB72-CreditsText_Part2_SK
		dc.w byte_5BB88-CreditsText_Part2_SK
		dc.w byte_5BB92-CreditsText_Part2_SK
		dc.w byte_5BB9E-CreditsText_Part2_SK
		dc.w byte_5BBAC-CreditsText_Part2_SK
		dc.w byte_5BBBC-CreditsText_Part2_SK
		dc.w byte_5BBD4-CreditsText_Part2_SK
		dc.w byte_5BBE2-CreditsText_Part2_SK
		dc.w byte_5BBF0-CreditsText_Part2_SK
		dc.w byte_5BC04-CreditsText_Part2_SK
		dc.w byte_5BC14-CreditsText_Part2_SK
		dc.w byte_5BC26-CreditsText_Part2_SK
		dc.w byte_5BC38-CreditsText_Part2_SK
		dc.w byte_5BC48-CreditsText_Part2_SK
		dc.w byte_5BC5C-CreditsText_Part2_SK
		dc.w byte_5BC6A-CreditsText_Part2_SK
		dc.w byte_5BC7A-CreditsText_Part2_SK
		dc.w byte_5BC82-CreditsText_Part2_SK
		dc.w byte_5BC88-CreditsText_Part2_SK
byte_5B9F6:	dc.b 2
		dc.b $D
		dc.b "MUSIC COMPOSERS",0
		even
byte_5BA08:	dc.b 4
		dc.b $E
		dc.b "HOWARD DROSSIN",0
		even
byte_5BA1A:	dc.b $14
		dc.b $D
		dc.b "SEGA SOUND TEAM",0
		even
byte_5BA2C:	dc.b $16
		dc.b $24
		dc.b "BO",0
		even
byte_5BA32:	dc.b $17
		dc.b $12
		dc.b "SACHIO OGAWA",0
		even
byte_5BA42:	dc.b $18
		dc.b $20
		dc.b "MILPO",0
		even
byte_5BA4A:	dc.b $19
		dc.b $A
		dc.b "MASARU SETSUMARU",0
		even
byte_5BA5E:	dc.b $1A
		dc.b $C
		dc.b "TATSUYUKI MAEDA",0
		even
byte_5BA70:	dc.b $1B
		dc.b $C
		dc.b "TOMONORI SAWADA",0
		even
byte_5BA82:	dc.b $1C
		dc.b $E
		dc.b "MASAYUKI NAGAO",0
		even
byte_5BA94:	dc.b $1D
		dc.b $16
		dc.b "JUN SENOUE",0
		even
byte_5BAA2:	dc.b $2D
		dc.b 3
		dc.b "EXECUTIVE MANAGEMENT",0
		even
byte_5BABA:	dc.b $2F
		dc.b 6
		dc.b $53
		dc.b "HOUICHIROU IRIMAJIRI",0
		even
byte_5BAD2:	dc.b $30
		dc.b $12
		dc.b "TOM KALINSKE",0
		even
byte_5BAE2:	dc.b $31
		dc.b $16
		dc.b "PAUL RIOUX",0
		even
byte_5BAF0:	dc.b $41
		dc.b $D
		dc.b "PRODUCT MANAGER",0
		even
byte_5BB02:	dc.b $43
		dc.b $12
		dc.b "PAMELA KELLY",0
		even
byte_5BB12:	dc.b $53
		dc.b 3
		dc.b "EXECUTIVE COORDINATOR",0
		even
byte_5BB2A:	dc.b $55
		dc.b $E
		dc.b "MAMORU SHIGETA",0
		even
byte_5BB3C:	dc.b $56
		dc.b $14
		dc.b "TOMIO TAKAMI",0
		even
byte_5BB4C:	dc.b $57
		dc.b $A
		dc.b "DIANE A. FORNASIER ",0
		even
byte_5BB62:	dc.b $58
		dc.b $12
		dc.b "ROGER HECTOR",0
		even
byte_5BB72:	dc.b $59
		dc.b 4
		dc.b "TAKAHARU UTSUNOMIYA",0
		even
byte_5BB88:	dc.b $69
		dc.b $1B
		dc.b "TESTERS",0
		even
byte_5BB92:	dc.b $6B
		dc.b $16
		dc.b "JASON KUO",0
		even
byte_5BB9E:	dc.b $6C
		dc.b $16
		dc.b "RICK GREER",0
		even
byte_5BBAC:	dc.b $6D
		dc.b $12
		dc.b "MIKE WILLIAMS",0
		even
byte_5BBBC:	dc.b $7D
		dc.b 5
		dc.b "SOUND SPECIAL THANKS",0
		even
byte_5BBD4:	dc.b $7F
		dc.b $16
		dc.b "CUBE CORP.",0
		even
byte_5BBE2:	dc.b $80
		dc.b $16
		dc.b "OPUS CORP.",0
		even
byte_5BBF0:	dc.b $81
		dc.b 8
		dc.b "MASANORI NAKAYAMA",0
		even
byte_5BC04:	dc.b $82
		dc.b $14
		dc.b "(STUDIO WHO)",0
		even
byte_5BC14:	dc.b $92
		dc.b $F
		dc.b "SPECIAL THANKS",0
		even
byte_5BC26:	dc.b $94
		dc.b $10
		dc.b "JINA ISHIWATARI",0
		even
byte_5BC38:	dc.b $95
		dc.b $12
		dc.b "EMI KAWAMURA",0
		even
byte_5BC48:	dc.b $96
		dc.b 8
		dc.b "DEBORAH MCCRACKEN",0
		even
byte_5BC5C:	dc.b $97
		dc.b $14
		dc.b "TAKU MAKINO",0
		even
byte_5BC6A:	dc.b $AB
		dc.b $13
		dc.b "PRESENTED BY",0
		even
byte_5BC7A:	dc.b $AD
		dc.b $20
		dc.b "SEGA",0
		even
byte_5BC82:	dc.b $BD
		dc.b $20
		dc.b "  ",0
		even
byte_5BC88:	dc.b $FF
		dc.b $F4
CreditsText_Part1:
		dc.w byte_5BCD2-CreditsText_Part1
		dc.w byte_5BCE8-CreditsText_Part1
		dc.w byte_5BCFA-CreditsText_Part1
		dc.w byte_5BD0E-CreditsText_Part1
		dc.w byte_5BD20-CreditsText_Part1
		dc.w byte_5BD32-CreditsText_Part1
		dc.w byte_5BD44-CreditsText_Part1
		dc.w byte_5BD50-CreditsText_Part1
		dc.w byte_5BD5C-CreditsText_Part1
		dc.w byte_5BD68-CreditsText_Part1
		dc.w byte_5BD7C-CreditsText_Part1
		dc.w byte_5BD92-CreditsText_Part1
		dc.w byte_5BDA6-CreditsText_Part1
		dc.w byte_5BDBE-CreditsText_Part1
		dc.w byte_5BDD2-CreditsText_Part1
		dc.w byte_5BDE4-CreditsText_Part1
		dc.w byte_5BDF6-CreditsText_Part1
		dc.w byte_5BE02-CreditsText_Part1
		dc.w byte_5BE18-CreditsText_Part1
		dc.w byte_5BE2A-CreditsText_Part1
		dc.w byte_5BE3E-CreditsText_Part1
		dc.w byte_5BE54-CreditsText_Part1
		dc.w byte_5BE6A-CreditsText_Part1
		dc.w byte_5BE78-CreditsText_Part1
		dc.w byte_5BE88-CreditsText_Part1
		dc.w byte_5BE98-CreditsText_Part1
		dc.w byte_5BEAC-CreditsText_Part1
		dc.w byte_5BEBC-CreditsText_Part1
		dc.w byte_5BECC-CreditsText_Part1
		dc.w byte_5BEDC-CreditsText_Part1
		dc.w byte_5BEEC-CreditsText_Part1
		dc.w byte_5BEFC-CreditsText_Part1
		dc.w byte_5BF12-CreditsText_Part1
		dc.w byte_5BF26-CreditsText_Part1
		dc.w byte_5BF36-CreditsText_Part1
		dc.w byte_5BF46-CreditsText_Part1
byte_5BCD2:	dc.b $F
		dc.b 7
		dc.b "EXECUTIVE PRODUCER",0
		even
byte_5BCE8:	dc.b $11
		dc.b $E
		dc.b "HAYAO NAKAYAMA",0
		even
byte_5BCFA:	dc.b $21
		dc.b $B
		dc.b "PROJECT MANAGERS",0
		even
byte_5BD0E:	dc.b $23
		dc.b $10
		dc.b "HISASHI SUZUKI",0
		even
byte_5BD20:	dc.b $24
		dc.b $E
		dc.b "SHINOBU TOYODA",0
		even
byte_5BD32:	dc.b $25
		dc.b $E
		dc.b "MASAHARU YOSHII",0
		even
byte_5BD44:	dc.b $35
		dc.b $19
		dc.b "PRODUCER",0
		even
byte_5BD50:	dc.b $37
		dc.b $18
		dc.b "YUJI NAKA",0
		even
byte_5BD5C:	dc.b $47
		dc.b $1B
		dc.b "DIRECTOR",0
		even
byte_5BD68:	dc.b $49
		dc.b 8
		dc.b "HIROKAZU YASUHARA",0
		even
byte_5BD7C:	dc.b $59
		dc.b 9
		dc.b "LEAD GAME DESIGNER",0
		even
byte_5BD92:	dc.b $5B
		dc.b 8
		dc.b "HIROKAZU YASUHARA",0
		even
byte_5BDA6:	dc.b $6B
		dc.b 3
		dc.b "SENIOR GAME DESIGNERS",0
		even
byte_5BDBE:	dc.b $6D
		dc.b $A
		dc.b "HISAYOSHI YOSHIDA",0
		even
byte_5BDD2:	dc.b $6E
		dc.b $10
		dc.b "TAKASHI IIZUKA",0
		even
byte_5BDE4:	dc.b $7E
		dc.b $B
		dc.b "LEAD PROGRAMMER",0
		even
byte_5BDF6:	dc.b $80
		dc.b $18
		dc.b "YUJI NAKA",0
		even
byte_5BE02:	dc.b $90
		dc.b 7
		dc.b "SENIOR PROGRAMMERS",0
		even
byte_5BE18:	dc.b $92
		dc.b $C
		dc.b "TAKAHIRO HAMANO",0
		even
byte_5BE2A:	dc.b $93
		dc.b 8
		dc.b "MASANOBU YAMAMOTO",0
		even
byte_5BE3E:	dc.b $A3
		dc.b 7
		dc.b "CHARACTER DESIGNER",0
		even
byte_5BE54:	dc.b $A5
		dc.b 6
		dc.b "TAKASHI THOMAS YUDA",0
		even
byte_5BE6A:	dc.b $B5
		dc.b $17
		dc.b "C.G. ARTIST",0
		even
byte_5BE78:	dc.b $B7
		dc.b $12
		dc.b "KUNITAKE AOKI",0
		even
byte_5BE88:	dc.b $C7
		dc.b $13
		dc.b "ENEMY ARTIST",0
		even
byte_5BE98:	dc.b $C9
		dc.b $A
		dc.b "SATOSHI YOKOKAWA",0
		even
byte_5BEAC:	dc.b $D9
		dc.b $11
		dc.b "SCENE ARTISTS",0
		even
byte_5BEBC:	dc.b $DB
		dc.b $12
		dc.b "KUNITAKE AOKI",0
		even
byte_5BECC:	dc.b $DC
		dc.b $14
		dc.b "CHIE YOSHIDA",0
		even
byte_5BEDC:	dc.b $DD
		dc.b $12
		dc.b "TSUNEKO AOKI",0
		even
byte_5BEEC:	dc.b $DE
		dc.b $10
		dc.b "SHIGERU OKADA",0
		even
byte_5BEFC:	dc.b $DF
		dc.b 6
		dc.b "TAKASHI THOMAS YUDA",0
		even
byte_5BF12:	dc.b $E0
		dc.b $A
		dc.b "SATOSHI YOKOKAWA",0
		even
byte_5BF26:	dc.b $F0
		dc.b $11
		dc.b "ART ASSISTANT",0
		even
byte_5BF36:	dc.b $F2
		dc.b $12
		dc.b "OSAMU OHASHI",0
		even
byte_5BF46:	dc.b $FF
		dc.b $F8
CreditsText_Part2:
		dc.w byte_5BFAE-CreditsText_Part2
		dc.w byte_5BFC0-CreditsText_Part2
		dc.w byte_5BFCE-CreditsText_Part2
		dc.w byte_5BFDE-CreditsText_Part2
		dc.w byte_5BFEC-CreditsText_Part2
		dc.w byte_5BFFA-CreditsText_Part2
		dc.w byte_5C00E-CreditsText_Part2
		dc.w byte_5C01A-CreditsText_Part2
		dc.w byte_5C02C-CreditsText_Part2
		dc.w byte_5C03E-CreditsText_Part2
		dc.w byte_5C044-CreditsText_Part2
		dc.w byte_5C054-CreditsText_Part2
		dc.w byte_5C05C-CreditsText_Part2
		dc.w byte_5C070-CreditsText_Part2
		dc.w byte_5C082-CreditsText_Part2
		dc.w byte_5C094-CreditsText_Part2
		dc.w byte_5C0A6-CreditsText_Part2
		dc.w byte_5C0B4-CreditsText_Part2
		dc.w byte_5C0C8-CreditsText_Part2
		dc.w byte_5C0D8-CreditsText_Part2
		dc.w byte_5C0F0-CreditsText_Part2
		dc.w byte_5C108-CreditsText_Part2
		dc.w byte_5C118-CreditsText_Part2
		dc.w byte_5C126-CreditsText_Part2
		dc.w byte_5C138-CreditsText_Part2
		dc.w byte_5C148-CreditsText_Part2
		dc.w byte_5C160-CreditsText_Part2
		dc.w byte_5C172-CreditsText_Part2
		dc.w byte_5C182-CreditsText_Part2
		dc.w byte_5C198-CreditsText_Part2
		dc.w byte_5C1A8-CreditsText_Part2
		dc.w byte_5C1BE-CreditsText_Part2
		dc.w byte_5C1C8-CreditsText_Part2
		dc.w byte_5C1D4-CreditsText_Part2
		dc.w byte_5C1E2-CreditsText_Part2
		dc.w byte_5C1F2-CreditsText_Part2
		dc.w byte_5C20A-CreditsText_Part2
		dc.w byte_5C222-CreditsText_Part2
		dc.w byte_5C22A-CreditsText_Part2
		dc.w byte_5C238-CreditsText_Part2
		dc.w byte_5C246-CreditsText_Part2
		dc.w byte_5C25A-CreditsText_Part2
		dc.w byte_5C26A-CreditsText_Part2
		dc.w byte_5C27C-CreditsText_Part2
		dc.w byte_5C28E-CreditsText_Part2
		dc.w byte_5C29E-CreditsText_Part2
		dc.w byte_5C2B2-CreditsText_Part2
		dc.w byte_5C2C0-CreditsText_Part2
		dc.w byte_5C2D0-CreditsText_Part2
		dc.w byte_5C2D8-CreditsText_Part2
		dc.w byte_5C2DE-CreditsText_Part2
byte_5BFAE:	dc.b 2
		dc.b $D
		dc.b "MUSIC COMPOSERS",0
		even
byte_5BFC0:	dc.b 4
		dc.b $16
		dc.b "BRAD BUXER",0
		even
byte_5BFCE:	dc.b 5
		dc.b $12
		dc.b "BOBBY BROOKS",0
		even
byte_5BFDE:	dc.b 6
		dc.b $14
		dc.b "DARRYL ROSS",0
		even
byte_5BFEC:	dc.b 7
		dc.b $14
		dc.b "GEOFF GRACE",0
		even
byte_5BFFA:	dc.b 8
		dc.b $E
		dc.b "DOUG GRIGSBY III",0
		even
byte_5C00E:	dc.b 9
		dc.b $1A
		dc.b "SCIROCCO",0
		even
byte_5C01A:	dc.b $A
		dc.b $E
		dc.b "HOWARD DROSSIN",0
		even
byte_5C02C:	dc.b $1A
		dc.b $D
		dc.b "SEGA SOUND TEAM",0
		even
byte_5C03E:	dc.b $1C
		dc.b $24
		dc.b "BO",0
		even
byte_5C044:	dc.b $1D
		dc.b $12
		dc.b "SACHIO OGAWA",0
		even
byte_5C054:	dc.b $1E
		dc.b $20
		dc.b "MILPO",0
		even
byte_5C05C:	dc.b $1F
		dc.b $A
		dc.b "MASARU SETSUMARU",0
		even
byte_5C070:	dc.b $20
		dc.b $C
		dc.b "TATSUYUKI MAEDA",0
		even
byte_5C082:	dc.b $21
		dc.b $C
		dc.b "TOMONORI SAWADA",0
		even
byte_5C094:	dc.b $22
		dc.b $E
		dc.b "MASAYUKI NAGAO",0
		even
byte_5C0A6:	dc.b $23
		dc.b $16
		dc.b "JUN SENOUE",0
		even
byte_5C0B4:	dc.b $33
		dc.b 9
		dc.b "SOUND COORDINATOR",0
		even
byte_5C0C8:	dc.b $35
		dc.b $14
		dc.b "HISAKI NIMIYA",0
		even
byte_5C0D8:	dc.b $45
		dc.b 3
		dc.b "EXECUTIVE MANAGEMENT",0
		even
byte_5C0F0:	dc.b $47
		dc.b 6
		dc.b "SHOUICHIROU IRIMAJIRI",0
		even
byte_5C108:	dc.b $48
		dc.b $12
		dc.b "TOM KALINSKE",0
		even
byte_5C118:	dc.b $49
		dc.b $16
		dc.b "PAUL RIOUX",0
		even
byte_5C126:	dc.b $59
		dc.b $D
		dc.b "PRODUCT MANAGER",0
		even
byte_5C138:	dc.b $5B
		dc.b $12
		dc.b "PAMELA KELLY",0
		even
byte_5C148:	dc.b $6B
		dc.b 3
		dc.b "EXECUTIVE COORDINATOR",0
		even
byte_5C160:	dc.b $6D
		dc.b $E
		dc.b "MAMORU SHIGETA",0
		even
byte_5C172:	dc.b $6E
		dc.b $14
		dc.b "TOMIO TAKAMI",0
		even
byte_5C182:	dc.b $6F
		dc.b $A
		dc.b "DIANE A. FORNASIER ",0
		even
byte_5C198:	dc.b $70
		dc.b $12
		dc.b "ROGER HECTOR",0
		even
byte_5C1A8:	dc.b $71
		dc.b 4
		dc.b "TAKAHARU UTSUNOMIYA",0
		even
byte_5C1BE:	dc.b $81
		dc.b $1B
		dc.b "TESTERS",0
		even
byte_5C1C8:	dc.b $83
		dc.b $16
		dc.b "JASON KUO",0
		even
byte_5C1D4:	dc.b $84
		dc.b $16
		dc.b "RICK GREER",0
		even
byte_5C1E2:	dc.b $85
		dc.b $12
		dc.b "MIKE WILLIAMS",0
		even
byte_5C1F2:	dc.b $95
		dc.b 5
		dc.b "SOUND SPECIAL THANKS",0
		even
byte_5C20A:	dc.b $97
		dc.b 6
		dc.b "MAYUMI NINA SAKAZAKI",0
		even
byte_5C222:	dc.b $98
		dc.b $20
		dc.b "(MRM)",0
		even
byte_5C22A:	dc.b $99
		dc.b $16
		dc.b "CUBE CORP.",0
		even
byte_5C238:	dc.b $9A
		dc.b $16
		dc.b "OPUS CORP.",0
		even
byte_5C246:	dc.b $9B
		dc.b 8
		dc.b "MASANORI NAKAYAMA",0
		even
byte_5C25A:	dc.b $9C
		dc.b $14
		dc.b "(STUDIO WHO)",0
		even
byte_5C26A:	dc.b $AC
		dc.b $F
		dc.b "SPECIAL THANKS",0
		even
byte_5C27C:	dc.b $AE
		dc.b $10
		dc.b "JINA ISHIWATARI",0
		even
byte_5C28E:	dc.b $AF
		dc.b $12
		dc.b "EMI KAWAMURA",0
		even
byte_5C29E:	dc.b $B0
		dc.b 8
		dc.b "DEBORAH MCCRACKEN",0
		even
byte_5C2B2:	dc.b $B1
		dc.b $14
		dc.b "TAKU MAKINO",0
		even
byte_5C2C0:	dc.b $C5
		dc.b $13
		dc.b "PRESENTED BY",0
		even
byte_5C2D0:	dc.b $C7
		dc.b $20
		dc.b "SEGA",0
		even
byte_5C2D8:	dc.b $D7
		dc.b $20
		dc.b "  ",0
		even
byte_5C2DE:	dc.b $FF
		dc.b $F4