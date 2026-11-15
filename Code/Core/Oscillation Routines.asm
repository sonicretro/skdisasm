
; =============== S U B R O U T I N E =======================================


OscillateNumInit:
		lea	(Oscillating_table).w,a1
		lea	(Osc_Data).l,a2
		moveq	#bytesToWcnt(Oscillating_table_end-Oscillating_table),d1

Osc_Loop:
		move.w	(a2)+,(a1)+
		dbf	d1,Osc_Loop
		rts
; End of function OscillateNumInit

; ---------------------------------------------------------------------------

Osc_Data:
		dc.w %0000000001111101	; oscillation direction bitfield
		dc.w    $80,     0	; baseline values
		dc.w    $80,     0
		dc.w    $80,     0
		dc.w    $80,     0
		dc.w    $80,     0
		dc.w    $80,     0
		dc.w    $80,     0
		dc.w    $80,     0
		dc.w    $80,     0
		dc.w  $3848,   $EE
		dc.w  $2080,   $B4
		dc.w  $3080,  $10E
		dc.w  $5080,  $1C2
		dc.w  $7080,  $276
		dc.w    $80,     0
		dc.w  $4000,   $FE

; =============== S U B R O U T I N E =======================================


OscillateNumDo:
		tst.w	(Competition_mode).w
		bne.s	locK_774A
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	OscillateNumDo_Return
; loc3_5958:
locK_774A:
		lea	(Oscillating_table).w,a1
		lea	(Osc_Data2).l,a2
		move.w	(a1)+,d3
		moveq	#bytesToLcnt(Osc_Data2_end-Osc_Data2),d1
; loc3_5966:
locK_7758:
		move.w	(a2)+,d2
		move.w	(a2)+,d4
		btst	d1,d3
		bne.s	locK_7774
		move.w	2(a1),d0
		add.w	d2,d0
		move.w	d0,2(a1)
		add.w	d0,(a1)
		cmp.b	(a1),d4
		bhi.s	locK_7786
		bset	d1,d3
		bra.s	locK_7786
; ---------------------------------------------------------------------------
; loc3_5982:
locK_7774:
		move.w	2(a1),d0
		sub.w	d2,d0
		move.w	d0,2(a1)
		add.w	d0,(a1)
		cmp.b	(a1),d4
		bls.s	locK_7786
		bclr	d1,d3
; loc3_5994:
locK_7786:
		addq.w	#4,a1
		dbf	d1,locK_7758
		move.w	d3,(Oscillating_table).w

OscillateNumDo_Return:
		rts
; End of function OscillateNumDo

; ---------------------------------------------------------------------------

Osc_Data2:
		dc.w    2, $10
		dc.w    2, $18
		dc.w    2, $20
		dc.w    2, $30
		dc.w    4, $20
		dc.w    8,   8
		dc.w    8, $40
		dc.w    4, $40
		dc.w    2, $38
		dc.w    2, $38
		dc.w    2, $20
		dc.w    3, $30
		dc.w    5, $50
		dc.w    7, $70
		dc.w    2, $40
		dc.w    2, $40
Osc_Data2_end