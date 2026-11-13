; =============== S U B R O U T I N E =======================================


Process_Sprites:
		tst.b	(Teleport_active_flag).w
		bne.s	locretK_1AB0C
		lea	(Object_RAM).w,a0
		tst.w	(Competition_mode).w
		bne.s	locK_1AAFA
		cmpi.b	#$C,(Player_1+routine).w
		beq.s	locK_1AAFA
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	locK_1AB0E
; loc3_191BE:
locK_1AAFA:
		moveq	#(Object_RAM_end-Object_RAM)/object_size-1,d7
; End of function Process_Sprites


; =============== S U B R O U T I N E =======================================

; sub3_191C0:
subK_1AAFC:
		move.l	(a0),d0
		beq.s	locK_1AB04
		movea.l	d0,a1
		jsr	(a1)
; loc3_191C8:
locK_1AB04:
		lea	next_object(a0),a0
		dbf	d7,subK_1AAFC
; locret3_191D0:
locretK_1AB0C:
		rts
; End of function subK_1AAFC

; ---------------------------------------------------------------------------
; loc3_191D2:
locK_1AB0E:	; this is broken?
		moveq	#((Dynamic_object_RAM+object_size)-Object_RAM)/object_size-1,d7
		bsr.s	subK_1AAFC
		moveq	#((Level_object_RAM+object_size)-(Dynamic_object_RAM+object_size))/object_size-1,d7
		bsr.s	subK_1AB1A
		moveq	#(Object_RAM_end-(Level_object_RAM+object_size))/object_size-1,d7
		bra.s	subK_1AAFC

; =============== S U B R O U T I N E =======================================

; sub3_191DE:
subK_1AB1A:
		move.l	(a0),d0
		beq.s	locK_1AB28
		tst.b	render_flags(a0)
		bpl.s	locK_1AB28
		jsr	Draw_Sprite(pc)
; loc3_191EC:
locK_1AB28:
		lea	next_object(a0),a0
		dbf	d7,subK_1AB1A
		rts
; End of function subK_1AB1A