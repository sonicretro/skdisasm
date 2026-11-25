
; =============== S U B R O U T I N E =======================================


Load_Rings:
		moveq	#0,d0
		move.b	(Rings_manager_routine).w,d0
		move.w	Load_Rings_Index(pc,d0.w),d0
		jmp	Load_Rings_Index(pc,d0.w)
; End of function Load_Rings

; ---------------------------------------------------------------------------

Load_Rings_Index:
		dc.w locK_E8BE-Load_Rings_Index
		dc.w locK_E942-Load_Rings_Index
	if ~~Sonic3_Alone
		dc.w locK_E9CA-Load_Rings_Index
	endif
; ---------------------------------------------------------------------------
; loc3_F604:
locK_E8BE:
		addq.b	#2,(Rings_manager_routine).w
		bsr.w	subK_EB1A
	if ~~Sonic3_Alone
		cmpi.b	#$14,(Current_zone).w
		beq.s	locK_E904
	endif
		movea.l	(Ring_start_addr_ROM).w,a1
		lea	(Ring_status_table).w,a2
		move.w	(Camera_X_pos).w,d4
		subq.w	#8,d4
		bhi.s	locK_E8E6
		moveq	#1,d4
		bra.s	locK_E8E6
; ---------------------------------------------------------------------------
; loc3_F720:
locK_E8E2:
		addq.w	#4,a1
		addq.w	#2,a2
; loc3_F624:
locK_E8E6:
		cmp.w	(a1),d4
		bhi.s	locK_E8E2
		move.l	a1,(Ring_start_addr_ROM).w
		move.w	a2,(Ring_start_addr_RAM).w
		addi.w	#$150,d4
		bra.s	locK_E8FA
; ---------------------------------------------------------------------------
; loc3_F636:
locK_E8F8:
		addq.w	#4,a1
; loc3_F638:
locK_E8FA:
		cmp.w	(a1),d4
		bhi.s	locK_E8F8
		move.l	a1,(Ring_end_addr_ROM).w
		rts

	if ~~Sonic3_Alone
; ---------------------------------------------------------------------------
; loc3_F642:
locK_E904:
		addq.b	#2,(Rings_manager_routine).w
		movea.l	(Ring_start_addr_ROM).w,a1
		lea	(Ring_status_table_2).w,a2
		move.w	(Camera_Y_pos).w,d4
		subq.w	#8,d4
		bhi.s	locK_E920
		moveq	#1,d4
		bra.s	locK_E920
; ---------------------------------------------------------------------------

locK_E91C:
		addq.w	#4,a1
		addq.w	#2,a2

locK_E920:
		cmp.w	2(a1),d4
		bhi.s	locK_E91C
		move.l	a1,(Ring_start_addr_ROM).w
		move.w	a2,(Ring_start_addr_RAM).w
		addi.w	#$F0,d4
		bra.s	locK_E936
; ---------------------------------------------------------------------------

locK_E934:
		addq.w	#4,a1

locK_E936:
		cmp.w	2(a1),d4
		bhi.s	locK_E934
		move.l	a1,(Ring_end_addr_ROM).w
		rts
; ---------------------------------------------------------------------------
	endif

locK_E942:
	if Sonic3_Alone
		lea	(Ring_consumption_table).w,a2
		move.w	(a2)+,d1
		subq.w	#1,d1
		bcs.s	loc3_F676

loc3_F64C:
		move.w	(a2)+,d0
		beq.s	loc3_F64C
		movea.w	d0,a1
		subq.b	#1,(a1)
		bne.s	loc3_F672
		move.b	#6,(a1)
		addq.b	#1,1(a1)
		cmpi.b	#8,1(a1)
		bne.s	loc3_F672
		move.w	#-1,(a1)
		clr.w	-2(a2)
		subq.w	#1,(Ring_consumption_table).w

loc3_F672:
		dbf	d1,loc3_F64C

loc3_F676:
	else
		bsr.s	subK_E994
	endif
		movea.l	(Ring_start_addr_ROM).w,a1
		movea.w	(Ring_start_addr_RAM).w,a2
		move.w	(Camera_X_pos).w,d4
		subq.w	#8,d4
		bhi.s	locK_E95C
		moveq	#1,d4
		bra.s	locK_E95C
; ---------------------------------------------------------------------------
; loc3_F68A:
locK_E958:
		addq.w	#4,a1
		addq.w	#2,a2
; loc3_F68E:
locK_E95C:
		cmp.w	(a1),d4
		bhi.s	locK_E958
		bra.s	locK_E966
; ---------------------------------------------------------------------------
; loc3_F694:
locK_E962:
		subq.w	#4,a1
		subq.w	#2,a2
; loc3_F698:
locK_E966:
		cmp.w	-4(a1),d4
		bls.s	locK_E962
		move.l	a1,(Ring_start_addr_ROM).w
		move.w	a2,(Ring_start_addr_RAM).w
		movea.l	(Ring_end_addr_ROM).w,a2
		addi.w	#$150,d4
		bra.s	locK_E980
; ---------------------------------------------------------------------------
; loc3_F6B0:
locK_E97E:
		addq.w	#4,a2
; loc3_F6B2:
locK_E980:
		cmp.w	(a2),d4
		bhi.s	locK_E97E
		bra.s	locK_E988
; ---------------------------------------------------------------------------
; loc3_F6B8:
locK_E986:
		subq.w	#4,a2
; loc3_F6BA:
locK_E988:
		cmp.w	-4(a2),d4
		bls.s	locK_E986
		move.l	a2,(Ring_end_addr_ROM).w
		rts

; =============== S U B R O U T I N E =======================================

	if ~~Sonic3_Alone
subK_E994:
		lea	(Ring_consumption_table).w,a2
		move.w	(a2)+,d1
		subq.w	#1,d1
		bcs.s	locretK_E9C8

locK_E99E:
		move.w	(a2)+,d0
		beq.s	locK_E99E
		movea.w	d0,a1
		subq.b	#1,(a1)
		bne.s	locK_E9C4
		move.b	#6,(a1)
		addq.b	#1,1(a1)
		cmpi.b	#8,1(a1)
		bne.s	locK_E9C4
		move.w	#-1,(a1)
		clr.w	-2(a2)
		subq.w	#1,(Ring_consumption_table).w

locK_E9C4:
		dbf	d1,locK_E99E

locretK_E9C8:
		rts
; End of function subK_E994

; ---------------------------------------------------------------------------

locK_E9CA:
		bsr.s	subK_E994
		movea.l	(Ring_start_addr_ROM).w,a1
		movea.w	(Ring_start_addr_RAM).w,a2
		move.w	(Camera_Y_pos).w,d4
		subq.w	#8,d4
		bhi.s	locK_E9E4
		moveq	#1,d4
		bra.s	locK_E9E4
; ---------------------------------------------------------------------------

locK_E9E0:
		addq.w	#4,a1
		addq.w	#2,a2

locK_E9E4:
		cmp.w	2(a1),d4
		bhi.s	locK_E9E0
		bra.s	locK_E9F0
; ---------------------------------------------------------------------------

locK_E9EC:
		subq.w	#4,a1
		subq.w	#2,a2

locK_E9F0:
		cmp.w	-2(a1),d4
		bls.s	locK_E9EC
		move.l	a1,(Ring_start_addr_ROM).w
		move.w	a2,(Ring_start_addr_RAM).w
		movea.l	(Ring_end_addr_ROM).w,a2
		addi.w	#$F0,d4
		bra.s	locK_EA0A
; ---------------------------------------------------------------------------

locK_EA08:
		addq.w	#4,a2

locK_EA0A:
		cmp.w	2(a2),d4
		bhi.s	locK_EA08
		bra.s	locK_EA14
; ---------------------------------------------------------------------------

locK_EA12:
		subq.w	#4,a2

locK_EA14:
		cmp.w	-2(a2),d4
		bls.s	locK_EA12
		move.l	a2,(Ring_end_addr_ROM).w
		rts
	endif

; =============== S U B R O U T I N E =======================================


Test_Ring_Collisions:
		cmpi.b	#90,invulnerability_timer(a0)
		bhs.w	locretK_EAE4
		movea.l	(Ring_start_addr_ROM).w,a1
		movea.l	(Ring_end_addr_ROM).w,a2
		cmpa.l	a1,a2
		beq.w	locretK_EAE4
		movea.w	(Ring_start_addr_RAM).w,a4
		btst	#Status_LtngShield,status_secondary(a0)	; does Sonic have a Lightning Shield?
		beq.s	Test_Ring_Collisions_NoAttraction
		move.w	x_pos(a0),d2
		move.w	y_pos(a0),d3
		subi.w	#$40,d2
		subi.w	#$40,d3
		move.w	#6,d1
		move.w	#$C,d6
		move.w	#$80,d4
		move.w	#$80,d5
		bra.s	Test_Ring_Collisions_NextRing
; ---------------------------------------------------------------------------

Test_Ring_Collisions_NoAttraction:
		move.w	x_pos(a0),d2
		move.w	y_pos(a0),d3
		subi.w	#8,d2
		moveq	#0,d5
		move.b	y_radius(a0),d5
		subq.b	#3,d5
		sub.w	d5,d3
		move.w	#6,d1
		move.w	#$C,d6
		move.w	#$10,d4
		add.w	d5,d5

Test_Ring_Collisions_NextRing:
		tst.w	(a4)
		bne.w	locK_EADA
		move.w	(a1),d0
		sub.w	d1,d0
		sub.w	d2,d0
		bcc.s	locK_EAA0
		add.w	d6,d0
		bcs.s	locK_EAA6
		bra.w	locK_EADA
; ---------------------------------------------------------------------------
; loc3_F746:
locK_EAA0:
		cmp.w	d4,d0
		bhi.w	locK_EADA
; loc3_F74C:
locK_EAA6:
		move.w	2(a1),d0
		sub.w	d1,d0
		sub.w	d3,d0
		bcc.s	locK_EAB8
		add.w	d6,d0
		bcs.s	locK_EABE
		bra.w	locK_EADA
; ---------------------------------------------------------------------------
; loc3_F75E:
locK_EAB8:
		cmp.w	d5,d0
		bhi.w	locK_EADA
; loc3_F764:
locK_EABE:
		btst	#Status_LtngShield,status_secondary(a0)	; does Sonic have a Lightning Shield?
		bne.s	Test_Ring_Collisions_AttractRing
; loc3_F76C:
locK_EAC6:
		move.w	#$604,(a4)
		bsr.s	subK_EAE6
		lea	(Ring_consumption_list).w,a3
; loc3_F776:
locK_EAD0:
		tst.w	(a3)+
		bne.s	locK_EAD0
		move.w	a4,-(a3)
		addq.w	#1,(Ring_consumption_table).w
; loc3_F780:
locK_EADA:
		addq.w	#4,a1
		addq.w	#2,a4
		cmpa.l	a1,a2
		bne.w	Test_Ring_Collisions_NextRing
; locret3_F78A:
locretK_EAE4:
		rts
; End of function Test_Ring_Collisions


; =============== S U B R O U T I N E =======================================

; sub3_F78C:
subK_EAE6:
		subq.w	#1,(Perfect_rings_left).w
		jmp	(GiveRing).l
; End of function subK_EAE6

; ---------------------------------------------------------------------------

Test_Ring_Collisions_AttractRing:
		movea.l	a1,a3
		jsr	(AllocateObject).l
		bne.w	locK_EB16
		move.l	#Obj_Attracted_Ring,(a1)
		move.w	(a3),x_pos(a1)
		move.w	2(a3),y_pos(a1)
		move.w	a4,$30(a1)
		move.w	#-1,(a4)
		rts
; ---------------------------------------------------------------------------
; loc3_F7BC:
locK_EB16:
		movea.l	a3,a1
		bra.s	locK_EAC6

; =============== S U B R O U T I N E =======================================

; sub3_F7C0:
subK_EB1A:
		moveq	#0,d0
		tst.b	(Respawn_table_keep).w
		bne.s	locK_EB30
		lea	(Ring_status_table).w,a1
		move.w	#bytesToLcnt(Ring_status_table_end-Ring_status_table),d1
; loc3_F7D0:
locK_EB2A:
		move.l	d0,(a1)+
		dbf	d1,locK_EB2A
; loc3_F7D6:
locK_EB30:
		lea	(Ring_consumption_table).w,a1
		moveq	#bytesToLcnt(Ring_consumption_table_end-Ring_consumption_table),d1
; loc3_F7DC:
locK_EB36:
		move.l	d0,(a1)+
		dbf	d1,locK_EB36
	if ~~Sonic3_Alone
		cmpi.b	#$14,(Current_zone).w
		bne.s	locK_EB52
		lea	(Ring_status_table_2).w,a1
		move.w	#bytesToLcnt(Ring_status_table_2_end-Ring_status_table_2),d1

locK_EB4C:
		move.l	d0,(a1)+
		dbf	d1,locK_EB4C

locK_EB52:
	endif
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#5,d0
		lea	(RingLocPtrs).l,a1
		movea.l	(a1,d0.w),a1
		move.l	a1,(Ring_start_addr_ROM).w
		addq.w	#4,a1
		moveq	#0,d5
		move.w	#511-1,d0
; loc3_F800:
locK_EB70:
		tst.l	(a1)+
		bmi.s	locK_EB7A
		addq.w	#1,d5
		dbf	d0,locK_EB70
; loc3_F80A:
locK_EB7A:
		move.w	d5,(Perfect_rings_left).w
		move.w	#0,(Perfect_rings_flag).w
		rts
; End of function subK_EB1A


; =============== S U B R O U T I N E =======================================


Render_Rings:
		movea.l	(Ring_start_addr_ROM).w,a0
		move.l	(Ring_end_addr_ROM).w,d2
		sub.l	a0,d2
		beq.s	locretK_EBEC
		movea.w	(Ring_start_addr_RAM).w,a4
		lea	CMap_Ring(pc),a1
		move.w	4(a3),d4
		move.w	#$F0,d5
		move.w	(Screen_Y_wrap_value).w,d3
; loc3_F836:
locK_EBA6:
		tst.w	(a4)+
		bmi.s	locK_EBE6
		move.w	2(a0),d1
		sub.w	d4,d1
		addq.w	#8,d1
		and.w	d3,d1
		cmp.w	d5,d1
		bhs.s	locK_EBE6
		addi.w	#$78,d1
		move.w	(a0),d0
		sub.w	(a3),d0
		addi.w	#$80,d0
		move.b	-1(a4),d6
		bne.s	locK_EBCE
		move.b	(Rings_frame).w,d6
; loc3_F85E:
locK_EBCE:
		lsl.w	#3,d6
		lea	(a1,d6.w),a2
		add.w	(a2)+,d1
		move.w	d1,(a6)+
		move.w	(a2)+,d6
		move.b	d6,(a6)
		addq.w	#2,a6
		move.w	(a2)+,(a6)+
		add.w	(a2)+,d0
		move.w	d0,(a6)+
		subq.w	#1,d7
; loc3_F876:
locK_EBE6:
		addq.w	#4,a0
		subq.w	#4,d2
		bne.s	locK_EBA6
; locret3_F87C:
locretK_EBEC:
		rts
; End of function Render_Rings

; ---------------------------------------------------------------------------
; Custom mappings format. Compare to Map_Ring.

; Differences include...
;  No offset table (each sprite assumed to be 8 bytes)
;  No 'sprite pieces per frame' value (hardcoded to 1)
;  Sign-extended Y-pos value
;  Sign-extended sprite size value

CMap_Ring:
;frame1:
		dc.w -8
		dc.w $0005
		dc.w $0000+make_art_tile(ArtTile_Ring,1,0)
		dc.w -8

;frame2:
		dc.w -8
		dc.w $0005
		dc.w $0004+make_art_tile(ArtTile_Ring,1,0)
		dc.w -8

;frame3:
		dc.w -8
		dc.w $0001
		dc.w $0008+make_art_tile(ArtTile_Ring,1,0)
		dc.w -4

;frame4:
		dc.w -8
		dc.w $0005
		dc.w $0804+make_art_tile(ArtTile_Ring,1,0)
		dc.w -8

;frame5:
		dc.w -8
		dc.w $0005
		dc.w $000A+make_art_tile(ArtTile_Ring,1,0)
		dc.w -8

;frame6:
		dc.w -8
		dc.w $0005
		dc.w $180A+make_art_tile(ArtTile_Ring,1,0)
		dc.w -8

;frame7:
		dc.w -8
		dc.w $0005
		dc.w $080A+make_art_tile(ArtTile_Ring,1,0)
		dc.w -8

;frame8:
		dc.w -8
		dc.w $0005
		dc.w $100A+make_art_tile(ArtTile_Ring,1,0)
		dc.w -8