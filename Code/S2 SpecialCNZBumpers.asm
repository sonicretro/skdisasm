
; =============== S U B R O U T I N E =======================================


S2_SpecialCNZBumpers:
		moveq	#0,d0
		move.b	(CNZ_bumper_routine).w,d0
		move.w	SpecialCNZBumpers_Index(pc,d0.w),d0
		jmp	SpecialCNZBumpers_Index(pc,d0.w)
; End of function S2_SpecialCNZBumpers

; ---------------------------------------------------------------------------
SpecialCNZBumpers_Index:
		dc.w SpecialCNZBumpers_Init-SpecialCNZBumpers_Index
		dc.w SpecialCNZBumpers_Main-SpecialCNZBumpers_Index
; ---------------------------------------------------------------------------

SpecialCNZBumpers_Init:
		addq.b	#2,(CNZ_bumper_routine).w
		lea	(SpecialCNZBumpers_Act1).l,a1
		tst.b	(Current_act).w
		beq.s	loc3_F8E6
		lea	(SpecialCNZBumpers_Act2).l,a1

loc3_F8E6:
		move.w	(Camera_X_pos).w,d4
		subq.w	#8,d4
		bhi.s	loc3_F8F6
		moveq	#1,d4
		bra.s	loc3_F8F6
; ---------------------------------------------------------------------------

loc3_F8F2:
		lea	6(a1),a1

loc3_F8F6:
		cmp.w	2(a1),d4
		bhi.s	loc3_F8F2
		move.l	a1,(CNZ_visible_bumpers_start).w
		move.l	a1,(CNZ_Visible_bumpers_start_P2).w
		addi.w	#$150,d4
		bra.s	loc3_F90E
; ---------------------------------------------------------------------------

loc3_F90A:
		lea	6(a1),a1

loc3_F90E:
		cmp.w	2(a1),d4
		bhi.s	loc3_F90A
		move.l	a1,(CNZ_Visible_bumpers_end).w
		move.l	a1,(CNZ_Visible_bumpers_end_P2).w
		move.b	#1,(CNZ_bumper_unk).w
		rts
; ---------------------------------------------------------------------------

SpecialCNZBumpers_Main:
		movea.l	(CNZ_visible_bumpers_start).w,a1
		move.w	(Camera_X_pos).w,d4
		subq.w	#8,d4
		bhi.s	loc3_F938
		moveq	#1,d4
		bra.s	loc3_F938
; ---------------------------------------------------------------------------

loc3_F934:
		lea	6(a1),a1

loc3_F938:
		cmp.w	2(a1),d4
		bhi.s	loc3_F934
		bra.s	loc3_F942
; ---------------------------------------------------------------------------

loc3_F940:
		subq.w	#6,a1

loc3_F942:
		cmp.w	-4(a1),d4
		bls.s	loc3_F940
		move.l	a1,(CNZ_visible_bumpers_start).w
		movea.l	(CNZ_Visible_bumpers_end).w,a2
		addi.w	#$150,d4
		bra.s	loc3_F95A
; ---------------------------------------------------------------------------

loc3_F956:
		lea	6(a2),a2

loc3_F95A:
		cmp.w	2(a2),d4
		bhi.s	loc3_F956
		bra.s	loc3_F964
; ---------------------------------------------------------------------------

loc3_F962:
		subq.w	#6,a2

loc3_F964:
		cmp.w	-4(a2),d4
		bls.s	loc3_F962
		move.l	a2,(CNZ_Visible_bumpers_end).w
		tst.w	(Competition_mode).w
		bne.s	loc3_F97E
		move.l	a1,(CNZ_Visible_bumpers_start_P2).w
		move.l	a2,(CNZ_Visible_bumpers_end_P2).w
		rts
; ---------------------------------------------------------------------------

loc3_F97E:
		movea.l	(CNZ_Visible_bumpers_start_P2).w,a1
		move.w	(Camera_X_pos_P2).w,d4
		subq.w	#8,d4
		bhi.s	loc3_F992
		moveq	#1,d4
		bra.s	loc3_F992
; ---------------------------------------------------------------------------

loc3_F98E:
		lea	6(a1),a1

loc3_F992:
		cmp.w	2(a1),d4
		bhi.s	loc3_F98E
		bra.s	loc3_F99C
; ---------------------------------------------------------------------------

loc3_F99A:
		subq.w	#6,a1

loc3_F99C:
		cmp.w	-4(a1),d4
		bls.s	loc3_F99A
		move.l	a1,(CNZ_Visible_bumpers_start_P2).w
		movea.l	(CNZ_Visible_bumpers_end_P2).w,a2
		addi.w	#$150,d4
		bra.s	loc3_F9B4
; ---------------------------------------------------------------------------

loc3_F9B0:
		lea	6(a2),a2

loc3_F9B4:
		cmp.w	2(a2),d4
		bhi.s	loc3_F9B0
		bra.s	loc3_F9BE
; ---------------------------------------------------------------------------

loc3_F9BC:
		subq.w	#6,a2

loc3_F9BE:
		cmp.w	-4(a2),d4
		bls.s	loc3_F9BC
		move.l	a2,(CNZ_Visible_bumpers_end_P2).w
		rts

; =============== S U B R O U T I N E =======================================


Check_CNZ_Bumpers:
		movea.l	(CNZ_visible_bumpers_start).w,a1
		movea.l	(CNZ_Visible_bumpers_end).w,a2
		cmpa.w	#Player_1,a0
		beq.s	loc3_F9E0
		movea.l	(CNZ_Visible_bumpers_start_P2).w,a1
		movea.l	(CNZ_Visible_bumpers_end_P2).w,a2

loc3_F9E0:
		cmpa.l	a1,a2
		beq.w	locret3_FA7A
		move.w	x_pos(a0),d2
		move.w	y_pos(a0),d3
		subi.w	#9,d2
		moveq	#0,d5
		move.b	y_radius(a0),d5
		subq.b	#3,d5
		sub.w	d5,d3
		cmpi.b	#$4D,mapping_frame(a0)
		bne.s	loc3_FA0A
		addi.w	#$C,d3
		moveq	#$A,d5

loc3_FA0A:
		move.w	#$12,d4
		add.w	d5,d5

CNZ_Bumper_Loop:
		move.w	(a1),d0
		andi.w	#$E,d0
		lea	byte3_FA5A(pc,d0.w),a3
		moveq	#0,d1
		move.b	(a3)+,d1
		move.w	2(a1),d0
		sub.w	d1,d0
		sub.w	d2,d0
		bcc.s	loc3_FA32
		add.w	d1,d1
		add.w	d1,d0
		bcs.s	loc3_FA38
		bra.w	CNZ_Bumper_Next
; ---------------------------------------------------------------------------

loc3_FA32:
		cmp.w	d4,d0
		bhi.w	CNZ_Bumper_Next

loc3_FA38:
		moveq	#0,d1
		move.b	(a3)+,d1
		move.w	4(a1),d0
		sub.w	d1,d0
		sub.w	d3,d0
		bcc.s	loc3_FA52
		add.w	d1,d1
		add.w	d1,d0
		bcs.w	loc3_FA66
		bra.w	CNZ_Bumper_Next
; ---------------------------------------------------------------------------

loc3_FA52:
		cmp.w	d5,d0
		bhi.w	CNZ_Bumper_Next
		bra.s	loc3_FA66
; ---------------------------------------------------------------------------
byte3_FA5A:
		dc.b $20
		dc.b $20
		dc.b $20
		dc.b $20
		dc.b $40
		dc.b   8
		dc.b $40
		dc.b   8
		dc.b   8
		dc.b $40
		dc.b   8
		dc.b $40
; ---------------------------------------------------------------------------

loc3_FA66:
		move.w	(a1),d0
		move.w	off3_FA7C(pc,d0.w),d0
		jmp	off3_FA7C(pc,d0.w)
; ---------------------------------------------------------------------------

CNZ_Bumper_Next:
		lea	6(a1),a1
		cmpa.l	a1,a2
		bne.w	CNZ_Bumper_Loop

locret3_FA7A:
		rts
; ---------------------------------------------------------------------------
off3_FA7C:
		dc.w loc3_FA88-off3_FA7C
		dc.w loc3_FB3A-off3_FA7C
		dc.w loc3_FBA0-off3_FA7C
		dc.w loc3_FBF8-off3_FA7C
		dc.w loc3_FC4E-off3_FA7C
		dc.w loc3_FCA6-off3_FA7C
; ---------------------------------------------------------------------------

loc3_FA88:
		move.w	4(a1),d0
		sub.w	y_pos(a0),d0
		neg.w	d0
		cmpi.w	#$20,d0
		blt.s	loc3_FAA2
		move.w	#$A00,y_vel(a0)
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

loc3_FAA2:
		move.w	2(a1),d0
		sub.w	x_pos(a0),d0
		neg.w	d0
		cmpi.w	#$20,d0
		blt.s	loc3_FABC
		move.w	#$A00,x_vel(a0)
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

loc3_FABC:
		move.w	2(a1),d0
		sub.w	x_pos(a0),d0
		cmpi.w	#$20,d0
		blt.s	loc3_FACE
		move.w	#$20,d0

loc3_FACE:
		add.w	4(a1),d0
		subq.w	#8,d0
		move.w	y_pos(a0),d1
		addi.w	#$E,d1
		sub.w	d1,d0
		bcc.s	locret3_FAEA
		move.w	#$20,d3
		bsr.s	loc3_FAEC
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

locret3_FAEA:
		rts
; ---------------------------------------------------------------------------

loc3_FAEC:
		move.w	x_vel(a0),d1
		move.w	y_vel(a0),d2
		jsr	(GetArcTan).l
		move.b	d0,(_dbgFFDC).w
		sub.w	d3,d0
		move.w	d0,d1
		bpl.s	loc3_FB06
		neg.w	d1

loc3_FB06:
		neg.w	d0
		add.w	d3,d0
		move.b	d0,(_dbgFFDD).w
		move.b	d1,(_dbgFFDF).w
		cmpi.b	#$38,d1
		bcs.s	loc3_FB1A
		move.w	d3,d0

loc3_FB1A:
		move.b	d0,(_dbgFFDE).w
		jsr	(GetSineCosine).l
		muls.w	#-$A00,d1
		asr.l	#8,d1
		move.w	d1,x_vel(a0)
		muls.w	#-$A00,d0
		asr.l	#8,d0
		move.w	d0,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc3_FB3A:
		move.w	4(a1),d0
		sub.w	y_pos(a0),d0
		neg.w	d0
		cmpi.w	#$20,d0
		blt.s	loc3_FB54
		move.w	#$A00,y_vel(a0)
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

loc3_FB54:
		move.w	2(a1),d0
		sub.w	x_pos(a0),d0
		cmpi.w	#$20,d0
		blt.s	loc3_FB6C
		move.w	#-$A00,x_vel(a0)
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

loc3_FB6C:
		move.w	2(a1),d0
		sub.w	x_pos(a0),d0
		neg.w	d0
		cmpi.w	#$20,d0
		blt.s	loc3_FB80
		move.w	#$20,d0

loc3_FB80:
		add.w	4(a1),d0
		subq.w	#8,d0
		move.w	y_pos(a0),d1
		addi.w	#$E,d1
		sub.w	d1,d0
		bcc.s	locret3_FB9E
		move.w	#$60,d3
		bsr.w	loc3_FAEC
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

locret3_FB9E:
		rts
; ---------------------------------------------------------------------------

loc3_FBA0:
		move.w	4(a1),d0
		sub.w	y_pos(a0),d0
		neg.w	d0
		cmpi.w	#8,d0
		blt.s	loc3_FBBA
		move.w	#$A00,y_vel(a0)
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

loc3_FBBA:
		move.w	2(a1),d0
		sub.w	x_pos(a0),d0
		cmpi.w	#$40,d0
		blt.s	loc3_FBD2
		move.w	#-$A00,x_vel(a0)
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

loc3_FBD2:
		neg.w	d0
		cmpi.w	#$40,d0
		blt.s	loc3_FBE4
		move.w	#$A00,x_vel(a0)
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

loc3_FBE4:
		move.w	#$38,d3
		tst.w	d0
		bmi.s	loc3_FBF0
		move.w	#$48,d3

loc3_FBF0:
		bsr.w	loc3_FAEC
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

loc3_FBF8:
		move.w	4(a1),d0
		sub.w	y_pos(a0),d0
		cmpi.w	#8,d0
		blt.s	loc3_FC10
		move.w	#-$A00,y_vel(a0)
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

loc3_FC10:
		move.w	2(a1),d0
		sub.w	x_pos(a0),d0
		cmpi.w	#$40,d0
		blt.s	loc3_FC28
		move.w	#-$A00,x_vel(a0)
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

loc3_FC28:
		neg.w	d0
		cmpi.w	#$40,d0
		blt.s	loc3_FC3A
		move.w	#$A00,x_vel(a0)
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

loc3_FC3A:
		move.w	#$C8,d3
		tst.w	d0
		bmi.s	loc3_FC46
		move.w	#$B8,d3

loc3_FC46:
		bsr.w	loc3_FAEC
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

loc3_FC4E:
		move.w	2(a1),d0
		sub.w	x_pos(a0),d0
		neg.w	d0
		cmpi.w	#8,d0
		blt.s	loc3_FC68
		move.w	#$A00,x_vel(a0)
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

loc3_FC68:
		move.w	4(a1),d0
		sub.w	y_pos(a0),d0
		cmpi.w	#$40,d0
		blt.s	loc3_FC80
		move.w	#-$A00,y_vel(a0)
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

loc3_FC80:
		neg.w	d0
		cmpi.w	#$40,d0
		blt.s	loc3_FC92
		move.w	#$A00,x_vel(a0)
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

loc3_FC92:
		move.w	#8,d3
		tst.w	d0
		bmi.s	loc3_FC9E
		move.w	#$F8,d3

loc3_FC9E:
		bsr.w	loc3_FAEC
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

loc3_FCA6:
		move.w	2(a1),d0
		sub.w	x_pos(a0),d0
		cmpi.w	#8,d0
		blt.s	loc3_FCBE
		move.w	#$A00,x_vel(a0)
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

loc3_FCBE:
		move.w	4(a1),d0
		sub.w	y_pos(a0),d0
		cmpi.w	#$40,d0
		blt.s	loc3_FCD6
		move.w	#-$A00,y_vel(a0)
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

loc3_FCD6:
		neg.w	d0
		cmpi.w	#$40,d0
		blt.s	loc3_FCE8
		move.w	#$A00,x_vel(a0)
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

loc3_FCE8:
		move.w	#$78,d3
		tst.w	d0
		bmi.s	loc3_FCF4
		move.w	#$88,d3

loc3_FCF4:
		bsr.w	loc3_FAEC
		bra.w	loc3_FCFC
; ---------------------------------------------------------------------------

loc3_FCFC:
		bset	#Status_InAir,status(a0)
		bclr	#Status_RollJump,status(a0)
		bclr	#Status_Push,status(a0)
		clr.b	jumping(a0)
		move.w	#sfx_MagneticSpike,d0
		jmp	(Play_SFX).l
; End of function Check_CNZ_Bumpers

; ---------------------------------------------------------------------------
SpecialCNZBumpers_Act1:
		dc.w     $A,  $410,  $540
		dc.w      0,  $560,  $520
		dc.w     $A,  $810,  $400
		dc.w      8,  $8F0,  $400
		dc.w      4,  $C40,  $1E0
		dc.w      4,  $CC0,  $1E0
		dc.w      4,  $D40,  $1E0
		dc.w      4,  $DC0,  $1E0
		dc.w      4,  $E40,  $1E0
		dc.w      4,  $E40,  $460
		dc.w      4,  $EC0,  $460
		dc.w      4,  $F40,  $460
		dc.w      4,  $FC0,  $460
		dc.w      6, $11C0,  $120
		dc.w      4, $11C0,  $1E0
		dc.w      6, $1240,  $120
		dc.w      4, $1240,  $1E0
		dc.w      6, $12C0,  $120
		dc.w      6, $1440,  $320
		dc.w      4, $1440,  $3E0
		dc.w      6, $1440,  $420
		dc.w      6, $14C0,  $320
		dc.w     $A, $1590,  $640
		dc.w      6, $15C0,  $420
		dc.w      8, $15F0,  $6C0
		dc.w     $A, $1610,  $6C0
		dc.w      6, $1640,  $420
		dc.w      8, $1670,  $640
		dc.w      6, $19C0,  $220
		dc.w      0, $19E0,  $360
		dc.w      6, $1A40,  $220
		dc.w      2, $1A60,  $320
		dc.w      2, $1AA0,  $6E0
		dc.w      4, $1AC0,  $360
		dc.w      6, $1AC0,  $620
		dc.w      4, $1AC0,  $760
		dc.w      4, $1B40,  $360
		dc.w      6, $1B40,  $620
		dc.w      4, $1B40,  $760
		dc.w      4, $1BC0,  $360
		dc.w      6, $1BC0,  $620
		dc.w      4, $1BC0,  $760
		dc.w      4, $1C40,  $760
		dc.w      4, $1CC0,  $760
		dc.w      0, $1CE0,  $360
		dc.w      0, $1D20,  $320
		dc.w      2, $1F60,  $620
		dc.w      0, $2060,  $620
		dc.w      0, $20A0,  $4A0
		dc.w      2, $21E0,  $1A0
		dc.w      2, $2260,  $4E0
		dc.w      8, $22F0,  $1C0
		dc.w      8, $23F0,  $3C0
		dc.w      0, $FFFF,     0
SpecialCNZBumpers_Act2:
		dc.w      0,     0,     0
		dc.w      2,  $DA0,  $5A0
		dc.w      0,  $EE0,  $5A0
		dc.w      2, $1320,  $320
		dc.w      0, $1360,  $2A0
		dc.w      4, $1540,  $1E0
		dc.w      6, $1540,  $220
		dc.w      4, $15C0,  $1E0
		dc.w      6, $15C0,  $220
		dc.w      4, $1640,  $1E0
		dc.w      6, $1640,  $220
		dc.w      6, $1740,  $720
		dc.w      4, $1740,  $7E0
		dc.w      6, $17C0,  $720
		dc.w      4, $17C0,  $7E0
		dc.w     $A, $1810,  $240
		dc.w      6, $1840,  $720
		dc.w      4, $1840,  $7E0
		dc.w      6, $18C0,  $720
		dc.w      4, $18C0,  $7E0
		dc.w     $A, $1890,  $3C0
		dc.w      8, $1930,  $240
		dc.w      6, $1940,  $720
		dc.w      4, $1940,  $7E0
		dc.w      6, $19C0,  $720
		dc.w      4, $19C0,  $7E0
		dc.w      6, $1A40,  $720
		dc.w      4, $1A40,  $7E0
		dc.w      6, $1AC0,  $720
		dc.w      4, $1AC0,  $7E0
		dc.w     $A, $1C90,  $240
		dc.w      2, $1CA0,  $360
		dc.w      2, $1D20,  $3E0
		dc.w      4, $1DC0,  $1E0
		dc.w      6, $1DC0,  $220
		dc.w      4, $1E40,  $1E0
		dc.w      6, $1E40,  $220
		dc.w      8, $1E70,  $380
		dc.w      4, $1EC0,  $5E0
		dc.w      6, $1F80,  $590
		dc.w      2, $2220,  $1A0
		dc.w      2, $2260,  $1E0
		dc.w      2, $22A0,  $220
		dc.w      2, $22E0,  $260
		dc.w      2, $23A0,  $4E0
		dc.w      0, $2520,  $520
		dc.w      8, $2530,  $1C0
		dc.w      8, $2530,  $2C0
		dc.w      8, $2530,  $340
		dc.w      8, $2530,  $3C0
		dc.w      8, $2530,  $4C0
		dc.w      0, $25A0,  $360
		dc.w      0, $25E0,  $320
		dc.w      0, $FFFF,     0