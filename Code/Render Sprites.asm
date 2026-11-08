; =============== S U B R O U T I N E =======================================


Render_Sprites:
		tst.w	(Competition_mode).w
		bne.w	Render_Sprites_CompetitionMode
		moveq	#80-1,d7
		moveq	#0,d6
		lea	(Sprite_table_input).w,a5
		lea	(Camera_X_pos_copy).w,a3
		lea	(Sprite_table).w,a6
		tst.b	(Level_started_flag).w
		beq.s	locK_1AD4A
		jsr	(Render_HUD).l
		jsr	(Render_Rings).l
; loc3_193B8:
locK_1AD4A:
		tst.w	(a5)
		beq.w	Render_Sprites_NextLevel
		lea	2(a5),a4
; loc3_193C2:
locK_1AD54:
		movea.w	(a4)+,a0	; a0=object
		andi.b	#$7F,render_flags(a0)	; clear on-screen flag
		move.b	render_flags(a0),d6
		move.w	x_pos(a0),d0
		move.w	y_pos(a0),d1
		btst	#6,d6		; is the multi-draw flag set?
		bne.w	locK_1AE58	; if it is, branch
		btst	#2,d6		; is this to be positioned by screen coordinates?
		beq.s	locK_1ADB2	; if it is, branch
		moveq	#0,d2
		move.b	width_pixels(a0),d2
		sub.w	(a3),d0
		move.w	d0,d3
		add.w	d2,d3		; is the object right edge to the left of the screen?
		bmi.s	Render_Sprites_NextObj	; if it is, branch
		move.w	d0,d3
		sub.w	d2,d3
		cmpi.w	#320,d3		; is the object left edge to the right of the screen?
		bge.s	Render_Sprites_NextObj	; if it is, branch
		addi.w	#128,d0
		sub.w	4(a3),d1
		move.b	height_pixels(a0),d2
		add.w	d2,d1
		and.w	(Screen_Y_wrap_value).w,d1
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#224,d2
		cmp.w	d2,d1
		bhs.s	Render_Sprites_NextObj	; if the object is below the screen
		addi.w	#128,d1
		sub.w	d3,d1
; loc3_19420:
locK_1ADB2:
		ori.b	#$80,render_flags(a0)	; set on-screen flag
		tst.w	d7
		bmi.s	Render_Sprites_NextObj
		movea.l	mappings(a0),a1
		moveq	#0,d4
		btst	#5,d6		; is the static mappings flag set?
		bne.s	locK_1ADD8	; if it is, branch
		move.b	mapping_frame(a0),d4
		add.w	d4,d4
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4		; get number of pieces
		bmi.s	Render_Sprites_NextObj	; if there are 0 pieces, branch
; loc3_19446:
locK_1ADD8:
		move.w	art_tile(a0),d5
		jsr	subK_1AF6C(pc)

Render_Sprites_NextObj:
		subq.w	#2,(a5)		; decrement object count
		bne.w	locK_1AD54	; if there are objects left, repeat

Render_Sprites_NextLevel:
		cmpa.l	#Sprite_table_input,a5
		bne.s	locK_1ADFC
	if Sonic3_Alone
		cmpi.w	#$900,(Current_zone_and_act).w	; LRZ Act 1?
		bne.s	locK_1ADFC
		jsr	(sub_1AF14).l
	else
		cmpi.b	#9,(Current_zone).w	; LRZ?
		bne.s	locK_1ADFC
		jsr	(sub_1CB68).l
	endif
; loc3_1946A:
locK_1ADFC:
		lea	$80(a5),a5	; load next priority level
		cmpa.l	#Sprite_table_input_end,a5
		blo.w	locK_1AD4A
		move.w	d7,d6
		bmi.s	locK_1AE18
		moveq	#0,d0
; loc3_1947E:
locK_1AE10:
		move.w	d0,(a6)
		addq.w	#8,a6
		dbf	d7,locK_1AE10
; loc3_19486:
locK_1AE18:
		subi.w	#$4F,d6
		neg.w	d6
		move.b	d6,(Sprites_drawn).w
		tst.w	(Spritemask_flag).w
		beq.s	locretK_1AE56
	if ~~Sonic3_Alone
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	locK_1AE34
	endif
		clr.w	(Spritemask_flag).w

locK_1AE34:
		lea	(Sprite_table-4).w,a0
		move.w	#$7C0,d0
	if Sonic3_Alone
		moveq	#80-1,d1
	else
		moveq	#79-1,d1
	endif
; loc3_194A4:
locK_1AE3E:
		addq.w	#8,a0
		cmp.w	(a0),d0
		dbeq	d1,locK_1AE3E
		bne.s	locretK_1AE56
		move.w	#1,2(a0)
		clr.w	$A(a0)
	if ~~Sonic3_Alone
		subq.w	#1,d1
		bpl.s	locK_1AE3E
	endif
; locret3_194B8:
locretK_1AE56:
		rts
; ---------------------------------------------------------------------------
; loc3_194BA:
locK_1AE58:
		btst	#2,d6		; is this to be positioned by screen coordinates?
		bne.s	locK_1AEA2	; if it is, branch
		moveq	#0,d2

		; check if object is within X bounds
		move.b	width_pixels(a0),d2
		subi.w	#128,d0
		move.w	d0,d3
		add.w	d2,d3
		bmi.w	Render_Sprites_NextObj
		move.w	d0,d3
		sub.w	d2,d3
		cmpi.w	#320,d3
		bge.w	Render_Sprites_NextObj
		addi.w	#128,d0

		; check if object is within Y bounds
		move.b	height_pixels(a0),d2
		subi.w	#128,d1
		move.w	d1,d3
		add.w	d2,d3
		bmi.w	Render_Sprites_NextObj
		move.w	d1,d3
		sub.w	d2,d3
		cmpi.w	#224,d3
		bge.w	Render_Sprites_NextObj
		addi.w	#128,d1
		bra.s	locK_1AEE4
; ---------------------------------------------------------------------------
; loc3_19504:
locK_1AEA2:
		moveq	#0,d2
		move.b	width_pixels(a0),d2
		sub.w	(a3),d0
		move.w	d0,d3
		add.w	d2,d3
		bmi.w	Render_Sprites_NextObj
		move.w	d0,d3
		sub.w	d2,d3
		cmpi.w	#320,d3
		bge.w	Render_Sprites_NextObj
		addi.w	#128,d0
		sub.w	4(a3),d1
		move.b	height_pixels(a0),d2
		add.w	d2,d1
		and.w	(Screen_Y_wrap_value).w,d1
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#224,d2
		cmp.w	d2,d1
		bhs.w	Render_Sprites_NextObj
		addi.w	#128,d1
		sub.w	d3,d1
; loc3_19546:
locK_1AEE4:
		ori.b	#$80,render_flags(a0)
		tst.w	d7
		bmi.w	Render_Sprites_NextObj
		move.w	art_tile(a0),d5
		movea.l	mappings(a0),a2
		moveq	#0,d4
		move.b	mapping_frame(a0),d4
		beq.s	locK_1AF1C
		add.w	d4,d4
		lea	(a2),a1
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	locK_1AF1C
		move.w	d6,d3
		jsr	subK_1B070(pc)
		move.w	d3,d6
		tst.w	d7
		bmi.w	Render_Sprites_NextObj
; loc3_1957E:
locK_1AF1C:
		move.w	mainspr_childsprites(a0),d3
		subq.w	#1,d3
		bcs.w	Render_Sprites_NextObj
		lea	sub2_x_pos(a0),a0
; loc3_1958C:
locK_1AF2A:
		move.w	(a0)+,d0
		move.w	(a0)+,d1
		btst	#2,d6
		beq.s	locK_1AF46
		sub.w	(a3),d0
		addi.w	#128,d0
		sub.w	4(a3),d1
		addi.w	#128,d1
		and.w	(Screen_Y_wrap_value).w,d1
; loc3_195A8:
locK_1AF46:
		addq.w	#1,a0
		moveq	#0,d4
		move.b	(a0)+,d4
		add.w	d4,d4
		lea	(a2),a1
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	locK_1AF62
		move.w	d6,-(sp)
		jsr	subK_1B070(pc)
		move.w	(sp)+,d6
; loc3_195C4:
locK_1AF62:
		tst.w	d7
		dbmi	d3,locK_1AF2A
		bra.w	Render_Sprites_NextObj
; End of function Render_Sprites


; =============== S U B R O U T I N E =======================================

; sub3_195CE:
subK_1AF6C:
		lsr.b	#1,d6
		bcs.s	locK_1AF9E
		lsr.b	#1,d6
		bcs.w	locK_1B038
; loc3_195D8:
locK_1AF76:
		move.b	(a1)+,d2
		ext.w	d2
		add.w	d1,d2
		move.w	d2,(a6)+
		move.b	(a1)+,(a6)+
		addq.w	#1,a6
		move.w	(a1)+,d2
		add.w	d5,d2
		move.w	d2,(a6)+
		move.w	(a1)+,d2
		add.w	d0,d2
		andi.w	#$1FF,d2
		bne.s	locK_1AF94
		addq.w	#1,d2
; loc3_195F6:
locK_1AF94:
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,locK_1AF76
		rts
; ---------------------------------------------------------------------------
; loc3_19600:
locK_1AF9E:
		lsr.b	#1,d6
		bcs.s	locK_1AFE8
; loc3_19604:
locK_1AFA2:
		move.b	(a1)+,d2
		ext.w	d2
		add.w	d1,d2
		move.w	d2,(a6)+
		move.b	(a1)+,d6
		move.b	d6,(a6)+
		addq.w	#1,a6
		move.w	(a1)+,d2
		add.w	d5,d2
		eori.w	#$800,d2
		move.w	d2,(a6)+
		move.w	(a1)+,d2
		neg.w	d2
		move.b	byteK_1AFD8(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d0,d2
		andi.w	#$1FF,d2
		bne.s	locK_1AFCE
		addq.w	#1,d2
; loc3_19630:
locK_1AFCE:
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,locK_1AFA2
		rts
; ---------------------------------------------------------------------------
; byte3_1963A:
byteK_1AFD8:
		dc.b    8,   8,   8,   8
		dc.b  $10, $10, $10, $10
		dc.b  $18, $18, $18, $18
		dc.b  $20, $20, $20, $20
		even
; ---------------------------------------------------------------------------
; loc3_1964A:
locK_1AFE8:
		move.b	(a1)+,d2
		ext.w	d2
		neg.w	d2
		move.b	(a1),d6
		move.b	byteK_1B028(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d1,d2
		move.w	d2,(a6)+
		move.b	(a1)+,d6
		move.b	d6,(a6)+
		addq.w	#1,a6
		move.w	(a1)+,d2
		add.w	d5,d2
		eori.w	#$1800,d2
		move.w	d2,(a6)+
		move.w	(a1)+,d2
		neg.w	d2
		move.b	byteK_1AFD8(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d0,d2
		andi.w	#$1FF,d2
		bne.s	locK_1B01E
		addq.w	#1,d2
; loc3_19680:
locK_1B01E:
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,locK_1AFE8
		rts
; ---------------------------------------------------------------------------
; byte3_1968A:
byteK_1B028:
		dc.b    8, $10, $18, $20
		dc.b    8, $10, $18, $20
		dc.b    8, $10, $18, $20
		dc.b    8, $10, $18, $20
		even
; ---------------------------------------------------------------------------
; loc3_1969A:
locK_1B038:
		move.b	(a1)+,d2
		ext.w	d2
		neg.w	d2
		move.b	(a1)+,d6
		move.b	d6,2(a6)
		move.b	byteK_1B028(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d1,d2
		move.w	d2,(a6)+
		addq.w	#2,a6
		move.w	(a1)+,d2
		add.w	d5,d2
		eori.w	#$1000,d2
		move.w	d2,(a6)+
		move.w	(a1)+,d2
		add.w	d0,d2
		andi.w	#$1FF,d2
		bne.s	locK_1B066
		addq.w	#1,d2
; loc3_196C8:
locK_1B066:
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,locK_1B038
		rts
; End of function subK_1AF6C


; =============== S U B R O U T I N E =======================================

; sub3_196D2:
subK_1B070:
		lsr.b	#1,d6
		bcs.s	locK_1B0C2
		lsr.b	#1,d6
		bcs.w	locK_1B19C
; loc3_196DC:
locK_1B07A:
		move.b	(a1)+,d2
		ext.w	d2
		add.w	d1,d2
		cmpi.w	#-32+128,d2
		bls.s	locK_1B0BA
		cmpi.w	#224+128,d2
		bhs.s	locK_1B0BA
		move.w	d2,(a6)+
		move.b	(a1)+,(a6)+
		addq.w	#1,a6
		move.w	(a1)+,d2
		add.w	d5,d2
		move.w	d2,(a6)+
		move.w	(a1)+,d2
		add.w	d0,d2
		cmpi.w	#-32+128,d2
		bls.s	locK_1B0B2
		cmpi.w	#320+128,d2
		bhs.s	locK_1B0B2
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,locK_1B07A
		rts
; ---------------------------------------------------------------------------
; loc3_19714:
locK_1B0B2:
		subq.w	#6,a6
		dbf	d4,locK_1B07A
		rts
; ---------------------------------------------------------------------------
; loc3_1971C:
locK_1B0BA:
		addq.w	#5,a1
		dbf	d4,locK_1B07A
		rts
; ---------------------------------------------------------------------------
; loc3_19724:
locK_1B0C2:
		lsr.b	#1,d6
		bcs.s	locK_1B12C
; loc3_19728:
locK_1B0C6:
		move.b	(a1)+,d2
		ext.w	d2
		add.w	d1,d2
		cmpi.w	#-32+128,d2
		bls.s	locK_1B114
		cmpi.w	#224+128,d2
		bhs.s	locK_1B114
		move.w	d2,(a6)+
		move.b	(a1)+,d6
		move.b	d6,(a6)+
		addq.w	#1,a6
		move.w	(a1)+,d2
		add.w	d5,d2
		eori.w	#$800,d2
		move.w	d2,(a6)+
		move.w	(a1)+,d2
		neg.w	d2
		move.b	byteK_1B11C(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d0,d2
		cmpi.w	#-32+128,d2
		bls.s	locK_1B10C
		cmpi.w	#320+128,d2
		bhs.s	locK_1B10C
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,locK_1B0C6
		rts
; ---------------------------------------------------------------------------
; loc3_1976E:
locK_1B10C:
		subq.w	#6,a6
		dbf	d4,locK_1B0C6
		rts
; ---------------------------------------------------------------------------
; loc3_19776:
locK_1B114:
		addq.w	#5,a1
		dbf	d4,locK_1B0C6
		rts
; ---------------------------------------------------------------------------
; byte3_1977E:
byteK_1B11C:
		dc.b    8,   8,   8,   8
		dc.b  $10, $10, $10, $10
		dc.b  $18, $18, $18, $18
		dc.b  $20, $20, $20, $20
		even
; ---------------------------------------------------------------------------
; loc3_1978E:
locK_1B12C:
		move.b	(a1)+,d2
		ext.w	d2
		neg.w	d2
		move.b	(a1),d6
		move.b	byteK_1B18C(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d1,d2
		cmpi.w	#-32+128,d2
		bls.s	locK_1B184
		cmpi.w	#224+128,d2
		bhs.s	locK_1B184
		move.w	d2,(a6)+
		move.b	(a1)+,d6
		move.b	d6,(a6)+
		addq.w	#1,a6
		move.w	(a1)+,d2
		add.w	d5,d2
		eori.w	#$1800,d2
		move.w	d2,(a6)+
		move.w	(a1)+,d2
		neg.w	d2
		move.b	byteK_1B11C(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d0,d2
		cmpi.w	#-32+128,d2
		bls.s	locK_1B17C
		cmpi.w	#320+128,d2
		bhs.s	locK_1B17C
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,locK_1B12C
		rts
; ---------------------------------------------------------------------------
; loc3_197DE:
locK_1B17C:
		subq.w	#6,a6
		dbf	d4,locK_1B12C
		rts
; ---------------------------------------------------------------------------
; loc3_197E6:
locK_1B184:
		addq.w	#5,a1
		dbf	d4,locK_1B12C
		rts
; ---------------------------------------------------------------------------
; byte3_197EE:
byteK_1B18C:
		dc.b    8, $10, $18, $20
		dc.b    8, $10, $18, $20
		dc.b    8, $10, $18, $20
		dc.b    8, $10, $18, $20
		even
; ---------------------------------------------------------------------------
; loc3_197FE:
locK_1B19C:
		move.b	(a1)+,d2
		ext.w	d2
		neg.w	d2
		move.b	(a1)+,d6
		move.b	d6,2(a6)
		move.b	byteK_1B18C(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d1,d2
		cmpi.w	#-32+128,d2
		bls.s	locK_1B1EC
		cmpi.w	#224+128,d2
		bhs.s	locK_1B1EC
		move.w	d2,(a6)+
		addq.w	#2,a6
		move.w	(a1)+,d2
		add.w	d5,d2
		eori.w	#$1000,d2
		move.w	d2,(a6)+
		move.w	(a1)+,d2
		add.w	d0,d2
		cmpi.w	#-32+128,d2
		bls.s	locK_1B1E4
		cmpi.w	#320+128,d2
		bhs.s	locK_1B1E4
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,locK_1B19C
		rts
; ---------------------------------------------------------------------------
; loc3_19846:
locK_1B1E4:
		subq.w	#6,a6
		dbf	d4,locK_1B19C
		rts
; ---------------------------------------------------------------------------
; loc3_1984E:
locK_1B1EC:
		addq.w	#4,a1
		dbf	d4,locK_1B19C
		rts
; End of function subK_1B070

; ---------------------------------------------------------------------------

Render_Sprites_CompetitionMode:
		moveq	#(80-2)-1,d7
		moveq	#0,d6
		lea	(Sprite_table_input).w,a5
		lea	(Camera_X_pos_copy).w,a3
		; Unlike in Sonic 2, the sprite tables are page-flipped in two-player mode.
		; This fixes a race-condition where incomplete sprite tables can be uploaded
		; to the VDP on lag frames, causing corrupted sprites to appear.

		; Modify the back buffer.
		lea	(Sprite_table+$10).w,a6
		tst.w	(Current_sprite_table_page).w
		beq.s	locK_1B210
		lea	(Sprite_table_alternate+$10).l,a6
; loc3_19872:
locK_1B210:
		tst.b	(Level_started_flag).w
		beq.s	locK_1B21C
		jsr	(Render_HUD_P1).l
; loc3_1987E:
locK_1B21C:
		move.b	1(a5),(a5)
		beq.w	locK_1B2C8
		lea	2(a5),a4
; loc3_1988A:
locK_1B228:
		movea.w	(a4)+,a0
		andi.b	#$7F,render_flags(a0)
		move.b	render_flags(a0),d6
		btst	#4,d6
		bne.w	locK_1B2C2
		move.w	x_pos(a0),d0
		move.w	y_pos(a0),d1
		btst	#6,d6
		bne.w	locK_1B3EC
		btst	#2,d6
		beq.s	locK_1B294
		moveq	#0,d2
		sub.w	(a3),d0
		move.b	width_pixels(a0),d2
		add.w	d2,d0
		and.w	(Screen_X_wrap_value).w,d0
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#320,d2
		cmp.w	d2,d0
		bhs.s	locK_1B2C2
		addi.w	#128,d0
		sub.w	d3,d0
		moveq	#0,d2
		sub.w	4(a3),d1
		move.b	height_pixels(a0),d2
		add.w	d2,d1
		and.w	(Screen_Y_wrap_value).w,d1
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#224/2,d2
		cmp.w	d2,d1
		bhs.s	locK_1B2C2
		addi.w	#128,d1
		sub.w	d3,d1
; loc3_198F6:
locK_1B294:
		ori.b	#$80,render_flags(a0)
		tst.w	d7
		bmi.s	locK_1B2C2
		movea.l	mappings(a0),a1
		moveq	#0,d4
		btst	#5,d6
		bne.s	locK_1B2BA
		move.b	mapping_frame(a0),d4
		add.w	d4,d4
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	locK_1B2C2
; loc3_1991C:
locK_1B2BA:
		move.w	art_tile(a0),d5
		jsr	subK_1AF6C(pc)
; loc3_19924:
locK_1B2C2:
		subq.b	#2,(a5)
		bne.w	locK_1B228
; loc3_1992A:
locK_1B2C8:
		lea	$80(a5),a5
		cmpa.l	#Sprite_table_input_end,a5
		blo.w	locK_1B21C
		tst.w	d7
		bmi.s	locK_1B2E4
		moveq	#0,d0
; loc3_1993E:
locK_1B2DC:
		move.w	d0,(a6)
		addq.w	#8,a6
		dbf	d7,locK_1B2DC
; loc3_19946:
locK_1B2E4:
		move.l	(Sprite_table_input+2+($80*2)).w,d0
		cmpi.l	#((Player_1&$FFFF)<<16)|(Player_2&$FFFF),d0
		bne.s	locK_1B2F6
		swap	d0
		move.l	d0,(Sprite_table_input+2+($80*2)).w
; loc3_19958:
locK_1B2F6:
		moveq	#80-1,d7
		lea	(Sprite_table_input).w,a5
		lea	(Camera_X_pos_P2_copy).w,a3
		; Unlike in Sonic 2, the sprite tables are page-flipped in two-player mode.
		; This fixes a race-condition where incomplete sprite tables can be uploaded
		; to the VDP on lag frames, causing corrupted sprites to appear.

		; Modify the back buffer.
		lea	(Sprite_table_P2).l,a6
		tst.w	(Current_sprite_table_page).w
		beq.s	locK_1B312
		lea	(Sprite_table_P2_alternate).l,a6
; loc3_19974:
locK_1B312:
		tst.b	(Level_started_flag).w
		beq.s	locK_1B31E
		jsr	(Render_HUD_P2).l
; loc3_19980:
locK_1B31E:
		tst.b	1(a5)
		beq.w	locK_1B3CA
		lea	2(a5),a4
; loc3_1998C:
locK_1B32A:
		movea.w	(a4)+,a0
		move.b	render_flags(a0),d6
		btst	#3,d6
		bne.w	locK_1B3C2
		move.w	x_pos(a0),d0
		move.w	y_pos(a0),d1
		btst	#6,d6
		bne.w	locK_1B4B8
		btst	#2,d6
		beq.s	locK_1B390
		moveq	#0,d2
		sub.w	(a3),d0
		move.b	width_pixels(a0),d2
		add.w	d2,d0
		and.w	(Screen_X_wrap_value).w,d0
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#320,d2
		cmp.w	d2,d0
		bhs.s	locK_1B3C2
		addi.w	#128,d0
		sub.w	d3,d0
		moveq	#0,d2
		sub.w	4(a3),d1
		move.b	height_pixels(a0),d2
		add.w	d2,d1
		and.w	(Screen_Y_wrap_value).w,d1
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#224/2,d2
		cmp.w	d2,d1
		bhs.s	locK_1B3C2
		addi.w	#128,d1
		sub.w	d3,d1
; loc3_199F2:
locK_1B390:
		addi.w	#224/2,d1
		ori.b	#$80,render_flags(a0)
		tst.w	d7
		bmi.s	locK_1B3C2
		movea.l	mappings(a0),a1
		moveq	#0,d4
		btst	#5,d6
		bne.s	locK_1B3BA
		move.b	mapping_frame(a0),d4
		add.w	d4,d4
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	locK_1B3C2
; loc3_19A1C:
locK_1B3BA:
		move.w	art_tile(a0),d5
		jsr	subK_1AF6C(pc)
; loc3_19A24:
locK_1B3C2:
		subq.b	#2,1(a5)
		bne.w	locK_1B32A
; loc3_19A2C:
locK_1B3CA:
		lea	$80(a5),a5
		cmpa.l	#Sprite_table_input_end,a5
		blo.w	locK_1B31E
		tst.w	d7
		bmi.s	locK_1B3E6
		moveq	#0,d0
; loc3_19a40:
locK_1B3DE:
		move.w	d0,(a6)
		addq.w	#8,a6
		dbf	d7,locK_1B3DE
; LOC3_19a48:
locK_1B3E6:
		; The new sprite tables are complete: signal a page flip to
		; allow them to be uploaded to the VDP!
		st.b	(Sprite_table_page_flip_pending).w
		rts
; ---------------------------------------------------------------------------
; loc3_19A4E:
locK_1B3EC:
		moveq	#0,d2
		sub.w	(a3),d0
		move.b	width_pixels(a0),d2
		add.w	d2,d0
		and.w	(Screen_X_wrap_value).w,d0
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#320,d2
		cmp.w	d2,d0
		bhs.w	locK_1B2C2
		addi.w	#128,d0
		sub.w	d3,d0
		moveq	#0,d2
		sub.w	4(a3),d1
		move.b	height_pixels(a0),d2
		add.w	d2,d1
		and.w	(Screen_Y_wrap_value).w,d1
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#224/2,d2
		cmp.w	d2,d1
		bhs.w	locK_1B2C2
		addi.w	#128,d1
		sub.w	d3,d1
		ori.b	#$80,render_flags(a0)
		tst.w	d7
		bmi.w	locK_1B2C2
		move.w	art_tile(a0),d5
		movea.l	mappings(a0),a2
		moveq	#0,d4
		move.b	mapping_frame(a0),d4
		beq.s	locK_1B46A
		add.w	d4,d4
		lea	(a2),a1
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	locK_1B46A
		move.w	d6,d3
		jsr	subK_1B070(pc)
		move.w	d3,d6
		tst.w	d7
		bmi.w	locK_1B2C2
; loc3_19ACC:
locK_1B46A:
		move.w	mainspr_childsprites(a0),d3
		subq.w	#1,d3
		bcs.w	locK_1B2C2
		lea	sub2_x_pos(a0),a0
; loc3_19ADA:
locK_1B478:
		move.w	(a0)+,d0
		sub.w	(a3),d0
		addi.w	#128,d0
		and.w	(Screen_X_wrap_value).w,d0
		move.w	(a0)+,d1
		sub.w	4(a3),d1
		addi.w	#128,d1
		and.w	(Screen_Y_wrap_value).w,d1
		addq.w	#1,a0
		moveq	#0,d4
		move.b	(a0)+,d4
		add.w	d4,d4
		lea	(a2),a1
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	locK_1B4AE
		move.w	d6,-(sp)
		jsr	subK_1B070(pc)
		move.w	(sp)+,d6
; loc3_19B10:
locK_1B4AE:
		tst.w	d7
		dbmi	d3,locK_1B478
		bra.w	locK_1B2C2
; ---------------------------------------------------------------------------
; loc3_19B1A:
locK_1B4B8:
		moveq	#0,d2
		sub.w	(a3),d0
		move.b	width_pixels(a0),d2
		add.w	d2,d0
		and.w	(Screen_X_wrap_value).w,d0
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#320,d2
		cmp.w	d2,d0
		bhs.w	locK_1B3C2
		addi.w	#128,d0
		sub.w	d3,d0
		moveq	#0,d2
		sub.w	4(a3),d1
		move.b	height_pixels(a0),d2
		add.w	d2,d1
		and.w	(Screen_Y_wrap_value).w,d1
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#224/2,d2
		cmp.w	d2,d1
		bhs.w	locK_1B3C2
		addi.w	#240,d1
		sub.w	d3,d1
		ori.b	#$80,render_flags(a0)
		tst.w	d7
		bmi.w	locK_1B3C2
		move.w	art_tile(a0),d5
		movea.l	mappings(a0),a2
		moveq	#0,d4
		move.b	mapping_frame(a0),d4
		beq.s	locK_1B536
		add.w	d4,d4
		lea	(a2),a1
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	locK_1B536
		move.w	d6,d3
		jsr	subK_1B070(pc)
		move.w	d3,d6
		tst.w	d7
		bmi.w	locK_1B3C2
; loc3_19B98:
locK_1B536:
		move.w	mainspr_childsprites(a0),d3
		subq.w	#1,d3
		bcs.w	locK_1B3C2
		lea	sub2_x_pos(a0),a0
; loc3_19BA6:
locK_1B544:
		move.w	(a0)+,d0
		sub.w	(a3),d0
		addi.w	#128,d0
		and.w	(Screen_X_wrap_value).w,d0
		move.w	(a0)+,d1
		sub.w	4(a3),d1
		addi.w	#128,d1
		and.w	(Screen_Y_wrap_value).w,d1
		addi.w	#224/2,d1
		addq.w	#1,a0
		moveq	#0,d4
		move.b	(a0)+,d4
		add.w	d4,d4
		lea	(a2),a1
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	locK_1B57E
		move.w	d6,-(sp)
		jsr	subK_1B070(pc)
		move.w	(sp)+,d6
; loc3_19BE0:
locK_1B57E:
		tst.w	d7
		dbmi	d3,locK_1B544
		bra.w	locK_1B3C2