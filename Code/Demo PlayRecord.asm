; =============== S U B R O U T I N E =======================================


GetDemoPtr:
	if Sonic3_Alone
		move.w	(Next_demo_number).w,d0
		lsl.w	#2,d0
		move.l	DemoPtrs(pc,d0.w),(Demo_data_addr).w
	else
		move.w	(Demo_number).w,d0
		lsl.w	#2,d0
		movea.l	DemoPtrs(pc,d0.w),a0
		move.b	(a0)+,(Demo_hold_counter).w
		move.l	a0,(Demo_data_addr).w
		clr.b	(Demo_hold_buttons).w
	endif
		move.w	#button_start_mask<<8,(Ctrl_1).w
		move.w	#button_start_mask<<8,(Ctrl_2).w
		st	(Demo_start_button).w
		rts
; End of function GetDemoPtr

; ---------------------------------------------------------------------------

DemoPtrs:
	if Sonic3_Alone
		dc.l DemoDat_MGZ+1
		dc.l DemoDat_AIZ+1
		dc.l DemoDat_HCZ+1
	else
		dc.l DemoDat_AIZ
		dc.l DemoDat_HCZ
		dc.l DemoDat_MGZ
		dc.l DemoDat_MHZ
		dc.l DemoDat_FBZ
		dc.l DemoDat_SOZ
		dc.l DemoDat_SpecialStage
	endif

; =============== S U B R O U T I N E =======================================


Demo_PlayRecord:
		tst.w	(Demo_mode_flag).w
		bne.s	locK_761E
		rts
; ---------------------------------------------------------------------------
; loc3_587C:
locK_761E:
		move.b	(Ctrl_1_pressed).w,d0
	if Sonic3_Alone
		or.b	(Ctrl_2_pressed).w,d0
	endif
		andi.b	#button_start_mask,d0
		beq.s	locK_762E
		move.b	#GameMode_TitleScreen,(Game_mode).w
; loc3_5890:
locK_762E:
		movea.l	(Demo_data_addr).w,a0
	if ~~Sonic3_Alone
		cmpi.b	#4,(Current_zone).w
		beq.s	locK_765E
		cmpi.b	#7,(Current_zone).w
		bhs.s	locK_765E
	endif
		move.b	(Demo_start_button).w,d1
		andi.b	#button_start_mask,d1
		or.b	-1(a0),d1
		move.b	(Ctrl_1_held).w,d0
		andi.b	#button_start_mask,d0
		sne	(Demo_start_button).w
		or.b	(a0)+,d0
	if Sonic3_Alone
		move.l	a0,(Demo_data_addr).w
		move.b	d0,(Ctrl_1_held).w
	else
		bra.s	locK_768C
; ---------------------------------------------------------------------------

locK_765E:
		move.b	(a0),d2
		subq.b	#1,(Demo_hold_counter).w
		bcc.s	locK_766E
		addq.w	#2,a0
		move.b	-1(a0),(Demo_hold_counter).w

locK_766E:
		move.b	(Demo_start_button).w,d1
		andi.b	#button_start_mask,d1
		or.b	(Demo_hold_buttons).w,d1
		move.b	d2,(Demo_hold_buttons).w
		move.b	(Ctrl_1).w,d0
		andi.b	#button_start_mask,d0
		sne	(Demo_start_button).w
		or.b	d2,d0

locK_768C:
		move.b	d0,(Ctrl_1_held).w
	endif
		eor.b	d0,d1
		and.b	d0,d1
		move.b	d1,(Ctrl_1_pressed).w
		move.w	#(button_start_mask<<8)|button_start_mask,d0
		and.w	d0,(Ctrl_2).w
	if ~~Sonic3_Alone
		move.l	a0,(Demo_data_addr).w
	endif
		rts
; End of function Demo_PlayRecord