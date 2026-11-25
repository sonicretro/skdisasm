; ---------------------------------------------------------------------------
; byte3_22602:
byteK_23F74:
		dc.b  $10, $10
		dc.b  $20, $10
		dc.b  $30, $10
		dc.b  $40, $10
		dc.b  $10, $10
		dc.b  $10, $20
		dc.b  $10, $30
		dc.b  $10, $40
		even
; ---------------------------------------------------------------------------

Obj_Spikes:
		ori.b	#4,render_flags(a0)
		move.w	#$200,priority(a0)
		move.b	subtype(a0),d0
		andi.w	#$F0,d0
		lsr.w	#3,d0
		tst.w	(Competition_mode).w
	if Sonic3_Alone
		bne.s	locK_24034
	else
		bne.w	locK_24034
	endif
		lea	byteK_23F74(pc,d0.w),a1
		move.b	(a1)+,width_pixels(a0)
		move.b	(a1)+,height_pixels(a0)
		move.l	#locK_24090,(a0)
		move.l	#Map_Spikes,mappings(a0)
		move.w	#make_art_tile(ArtTile_SpikesSprings+$8,0,0),art_tile(a0)
	if ~~Sonic3_Alone
		cmpi.b	#4,(Current_zone).w
		bne.s	locK_23FD0
		move.w	#make_art_tile(ArtTile_FBZSpikes,0,0),art_tile(a0)

locK_23FD0:
	endif
		lsr.w	#1,d0
		move.b	d0,mapping_frame(a0)
		cmpi.b	#4,d0
		blo.s	locK_23FE8
		move.l	#locK_240E2,(a0)
		move.w	#make_art_tile(ArtTile_SpikesSprings,0,0),art_tile(a0)
; loc3_22666:
locK_23FE8:
	if Sonic3_Alone
		btst	#1,status(a0)
	else
		move.b	status(a0),d0
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_23FF6
		eori.b	#2,d0

locK_23FF6:
		andi.b	#2,d0
	endif
		beq.s	locK_24002
		move.l	#locK_2413E,(a0)
; loc3_22674:
locK_24002:
	if ~~Sonic3_Alone
		move.w	#$20,$3C(a0)
	endif
		move.w	x_pos(a0),$30(a0)
		move.w	y_pos(a0),$32(a0)
		move.b	subtype(a0),d0
		andi.b	#$F,d0
		add.b	d0,d0
		move.b	d0,subtype(a0)
		rts
; ---------------------------------------------------------------------------
; byte3_22690:
byteK_24024:
		dc.b   $C,  $C
		dc.b  $18,  $C
		dc.b  $24,  $C
		dc.b  $30,  $C
		dc.b   $C,  $C
		dc.b   $C, $18
		dc.b   $C, $24
		dc.b   $C, $30
; ---------------------------------------------------------------------------
; loc3_226A0:
locK_24034:
		lea	byteK_24024(pc,d0.w),a1
		move.b	(a1)+,width_pixels(a0)
		move.b	(a1)+,height_pixels(a0)
		move.l	#locK_2418E,(a0)
		move.l	#Map_2PSpikes,mappings(a0)
		move.w	#make_art_tile(ArtTile_2PArt_2,0,0),art_tile(a0)
		lsr.w	#1,d0
		move.b	d0,mapping_frame(a0)
		cmpi.b	#4,d0
		blo.s	locK_24066
		move.l	#locK_241DC,(a0)
; loc3_226D2:
locK_24066:
		btst	#1,status(a0)
		beq.s	locK_24074
		move.l	#locK_24234,(a0)
; loc3_226E0:
locK_24074:
		move.w	x_pos(a0),$30(a0)
		move.w	y_pos(a0),$32(a0)
		move.b	subtype(a0),d0
		andi.b	#$F,d0
		add.b	d0,d0
		move.b	d0,subtype(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_226FC:
locK_24090:
		bsr.w	subK_242B6
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		bsr.w	SolidObjectFull
		move.b	status(a0),d6
		andi.b	#standing_mask,d6
		beq.s	locK_240D8
		move.b	d6,d0
		andi.b	#p1_standing,d0
		beq.s	locK_240CA
		lea	(Player_1).w,a1
		bsr.w	Touch_HurtSpikes
; loc3_22736:
locK_240CA:
		andi.b	#p2_standing,d6
		beq.s	locK_240D8
		lea	(Player_2).w,a1
		bsr.w	Touch_HurtSpikes
; loc3_22744:
locK_240D8:
		move.w	$30(a0),d0
		jmp	(Sprite_OnScreen_Test2).l
; ---------------------------------------------------------------------------
; loc3_2274E:
locK_240E2:
		bsr.w	subK_242B6
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		bsr.w	SolidObjectFull
		swap	d6
		andi.w	#1|2,d6
		beq.s	locK_24134
		move.b	d6,d0
		andi.b	#1,d0
		beq.s	locK_24120
		lea	(Player_1).w,a1
		bsr.w	Touch_HurtSpikes
		bclr	#p1_pushing_bit,status(a0)
; loc3_2278C:
locK_24120:
		andi.b	#2,d6
		beq.s	locK_24134
		lea	(Player_2).w,a1
		bsr.w	Touch_HurtSpikes
		bclr	#p2_pushing_bit,status(a0)
; loc3_227A0:
locK_24134:
		move.w	$30(a0),d0
		jmp	(Sprite_OnScreen_Test2).l
; ---------------------------------------------------------------------------
; loc3_227AA:
locK_2413E:
		bsr.w	subK_242B6
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		bsr.w	SolidObjectFull
		swap	d6
		andi.w	#4|8,d6
		beq.s	locK_24184
		move.b	d6,d0
		andi.b	#4,d0
		beq.s	locK_24176
		lea	(Player_1).w,a1
		bsr.w	Touch_HurtSpikes
; loc3_227E2:
locK_24176:
		andi.b	#8,d6
		beq.s	locK_24184
		lea	(Player_2).w,a1
		bsr.w	Touch_HurtSpikes
; loc3_227F0:
locK_24184:
		move.w	$30(a0),d0
		jmp	(Sprite_OnScreen_Test2).l
; ---------------------------------------------------------------------------
; loc3_227FA:
locK_2418E:
		bsr.w	subK_243BA
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#7,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		bsr.w	SolidObjectFull
		move.b	status(a0),d6
		andi.b	#standing_mask,d6
		beq.s	locK_241D6
		move.b	d6,d0
		andi.b	#p1_standing,d0
		beq.s	locK_241C8
		lea	(Player_1).w,a1
		bsr.w	Touch_HurtSpikes
; loc3_22834:
locK_241C8:
		andi.b	#p2_standing,d6
		beq.s	locK_241D6
		lea	(Player_2).w,a1
		bsr.w	Touch_HurtSpikes
; loc3_22842:
locK_241D6:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_22848:
locK_241DC:
		bsr.w	subK_243BA
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#7,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		bsr.w	SolidObjectFull
		swap	d6
		andi.w	#1|2,d6
		beq.s	locK_2422E
		move.b	d6,d0
		andi.b	#1,d0
		beq.s	locK_2421A
		lea	(Player_1).w,a1
		bsr.w	Touch_HurtSpikes
		bclr	#p1_pushing_bit,status(a0)
; loc3_22886:
locK_2421A:
		andi.b	#2,d6
		beq.s	locK_2422E
		lea	(Player_2).w,a1
		bsr.w	Touch_HurtSpikes
		bclr	#p2_pushing_bit,status(a0)
; loc3_2289A:
locK_2422E:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_228A0:
locK_24234:
		bsr.w	subK_243BA
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#7,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		bsr.w	SolidObjectFull
		swap	d6
		andi.w	#4|8,d6
		beq.s	locK_2427A
		move.b	d6,d0
		andi.b	#4,d0
		beq.s	locK_2426C
		lea	(Player_1).w,a1
		bsr.w	Touch_HurtSpikes
; loc3_228D8:
locK_2426C:
		andi.b	#8,d6
		beq.s	locK_2427A
		lea	(Player_2).w,a1
		bsr.w	Touch_HurtSpikes
; loc3_228E6:
locK_2427A:
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================

; sub3_228EC: subK_24280:
Touch_HurtSpikes:
		btst	#Status_Invincible,status_secondary(a1)
		bne.s	locretK_242B4
		tst.b	invulnerability_timer(a1)
		bne.s	locretK_242B4
		cmpi.b	#4,routine(a1)
		bhs.s	locretK_242B4
		move.l	y_pos(a1),d3
		move.w	y_vel(a1),d0
		ext.l	d0
		asl.l	#8,d0
		sub.l	d0,d3
		move.l	d3,y_pos(a1)
		movea.l	a0,a2
		movea.l	a1,a0
		jsr	(HurtCharacter).l
		movea.l	a2,a0
; locret3_22920:
locretK_242B4:
		rts
; End of function Touch_HurtSpikes


; =============== S U B R O U T I N E =======================================

; sub3_22922:
subK_242B6:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	offK_242C4(pc,d0.w),d1
		jmp	offK_242C4(pc,d1.w)
; End of function subK_242B6

; ---------------------------------------------------------------------------
; off3_22930:
offK_242C4:
		dc.w locretK_242CC-offK_242C4
		dc.w locK_242CE-offK_242C4
		dc.w locK_242E2-offK_242C4
	if ~~Sonic3_Alone
		dc.w locK_24356-offK_242C4
	endif
; ---------------------------------------------------------------------------
; locret3_22936:
locretK_242CC:
		rts
; ---------------------------------------------------------------------------
; loc3_22938:
locK_242CE:
		bsr.w	subK_242F6
		moveq	#0,d0
		move.b	$34(a0),d0
		add.w	$32(a0),d0
		move.w	d0,y_pos(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_2294C:
locK_242E2:
		bsr.w	subK_242F6
		moveq	#0,d0
		move.b	$34(a0),d0
		add.w	$30(a0),d0
		move.w	d0,x_pos(a0)
		rts

; =============== S U B R O U T I N E =======================================

; sub3_22960:
subK_242F6:
		tst.w	$38(a0)
		beq.s	locK_24312
		subq.w	#1,$38(a0)
		bne.s	locretK_24354
		tst.b	render_flags(a0)
		bpl.s	locretK_24354
		moveq	#signextendB(sfx_SpikeMove),d0
		jsr	(Play_SFX).l
		bra.s	locretK_24354
; ---------------------------------------------------------------------------
; loc3_2297C:
locK_24312:
		tst.w	$36(a0)
		beq.s	locK_24334
		subi.w	#$800,$34(a0)
		bcc.s	locretK_24354
		move.w	#0,$34(a0)
		move.w	#0,$36(a0)
		move.w	#60,$38(a0)
		bra.s	locretK_24354
; ---------------------------------------------------------------------------
; loc3_2299E:
locK_24334:
		addi.w	#$800,$34(a0)
		cmpi.w	#$2000,$34(a0)
		blo.s	locretK_24354
		move.w	#$2000,$34(a0)
		move.w	#1,$36(a0)
		move.w	#60,$38(a0)
; locret3_229BE:
locretK_24354:
		rts
; End of function subK_242F6

; ---------------------------------------------------------------------------

	if ~~Sonic3_Alone
locK_24356:
		move.b	status(a0),d3
		andi.b	#pushing_mask,d3
		beq.s	locK_2437C
		move.w	x_pos(a0),d2
		lea	(Player_1).w,a1
		move.b	$3E(a0),d0
		moveq	#5,d6
		bsr.s	subK_2438A
		lea	(Player_2).w,a1
		move.b	$3F(a0),d0
		moveq	#6,d6
		bsr.s	subK_2438A

locK_2437C:
		move.b	(Player_1+status).w,$3E(a0)
		move.b	(Player_2+status).w,$3F(a0)
		rts

; =============== S U B R O U T I N E =======================================


subK_2438A:
		btst	d6,d3
		beq.s	locretK_243B8
		cmp.w	x_pos(a1),d2
		blo.s	locretK_243B8
		btst	#5,d0
		beq.s	locretK_243B8
		subq.w	#1,$3A(a0)
		bpl.s	locretK_243B8
		move.w	#$10,$3A(a0)
		tst.w	$3C(a0)
		beq.s	locretK_243B8
		subq.w	#1,$3C(a0)
		addq.w	#1,x_pos(a0)
		addq.w	#1,x_pos(a1)

locretK_243B8:
		rts
; End of function subK_2438A
	endif

; =============== S U B R O U T I N E =======================================

; sub3_229C0:
subK_243BA:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	offK_243C8(pc,d0.w),d1
		jmp	offK_243C8(pc,d1.w)
; End of function subK_243BA

; ---------------------------------------------------------------------------
; off3_229CE:
offK_243C8:
		dc.w locretK_242CC-offK_243C8
		dc.w locK_243CE-offK_243C8
		dc.w locK_243E2-offK_243C8
; ---------------------------------------------------------------------------
; loc3_229D4:
locK_243CE:
		bsr.w	subK_243F6
		moveq	#0,d0
		move.b	$34(a0),d0
		add.w	$32(a0),d0
		move.w	d0,y_pos(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_229E8:
locK_243E2:
		bsr.w	subK_243F6
		moveq	#0,d0
		move.b	$34(a0),d0
		add.w	$30(a0),d0
		move.w	d0,x_pos(a0)
		rts

; =============== S U B R O U T I N E =======================================

; sub3_229FC:
subK_243F6:
		tst.w	$38(a0)
		beq.s	locK_24412
		subq.w	#1,$38(a0)
		bne.s	locretK_24454
		tst.b	render_flags(a0)
		bpl.s	locretK_24454
		moveq	#signextendB(sfx_SpikeMove),d0
		jsr	(Play_SFX).l
		bra.s	locretK_24454
; ---------------------------------------------------------------------------
; loc3_22A18:
locK_24412:
		tst.w	$36(a0)
		beq.s	locK_24434
		subi.w	#$800,$34(a0)
		bcc.s	locretK_24454
		move.w	#0,$34(a0)
		move.w	#0,$36(a0)
		move.w	#60,$38(a0)
		bra.s	locretK_24454
; ---------------------------------------------------------------------------
; loc3_22A3A:
locK_24434:
		addi.w	#$800,$34(a0)
		cmpi.w	#$1800,$34(a0)
		blo.s	locretK_24454
		move.w	#$1800,$34(a0)
		move.w	#1,$36(a0)
		move.w	#60,$38(a0)
; locret3_22A5A:
locretK_24454:
		rts
; End of function subK_243F6

; ---------------------------------------------------------------------------

Map_Spikes:
		include "General/Sprites/Level Misc/Map - Spikes.asm"
Map_2PSpikes:
		include "General/2P Zone/Map - Spikes.asm"