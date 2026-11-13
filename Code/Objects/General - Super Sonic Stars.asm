; ---------------------------------------------------------------------------

Obj_SuperSonicKnux_Stars:
		move.l	#ArtUnc_SuperSonic_Stars,d1
		move.w	#tiles_to_bytes(ArtTile_Shield),d2
		move.w	#$1A0,d3
		jsr	(Add_To_DMA_Queue).l
		move.l	#Map_SuperSonic_Stars,mappings(a0)
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a0)
		btst	#7,(Player_1+art_tile).w
		beq.s	locK_1919E
		bset	#7,art_tile(a0)
; loc3_17EEA:
locK_1919E:
		move.l	#locK_191A4,(a0)
; loc3_17EF0:
locK_191A4:
		tst.b	(Super_Sonic_Knux_flag).w
		beq.w	locK_19230
		tst.b	anim(a0)
		beq.s	locK_191B6
		bsr.w	subK_19236
; loc3_17F02:
locK_191B6:
		tst.b	$34(a0)
		beq.s	locK_19200
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locK_191E8
		move.b	#1,anim_frame_timer(a0)
		addq.b	#1,mapping_frame(a0)
		cmpi.b	#6,mapping_frame(a0)
		blo.s	locK_191E8
		move.b	#0,mapping_frame(a0)
		move.b	#0,$34(a0)
		move.b	#1,$35(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_17F34:
locK_191E8:
		tst.b	$35(a0)
		bne.s	locK_191FA
; loc3_17F3A:
locK_191EE:
		move.w	(Player_1+x_pos).w,x_pos(a0)
		move.w	(Player_1+y_pos).w,y_pos(a0)
; loc3_17F46:
locK_191FA:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_17F4C:
locK_19200:
		tst.b	(Player_1+object_control).w
		bne.s	locK_19222
		move.w	(Player_1+ground_vel).w,d0
		bpl.s	locK_1920E
		neg.w	d0
; loc3_17F5A:
locK_1920E:
		cmpi.w	#$800,d0
		blo.s	locK_19222
		move.b	#0,mapping_frame(a0)
		move.b	#1,$34(a0)
		bra.s	locK_191EE
; ---------------------------------------------------------------------------
; loc3_17F6E:
locK_19222:
		move.b	#0,$34(a0)
		move.b	#0,$35(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_17F7C:
locK_19230:
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================

; sub3_17F82:
subK_19236:
		move.b	#0,anim(a0)
		lea	(Player_1).w,a2
		moveq	#$10-1,d5
		move.w	#$488,d4
; loc3_17F92:
locK_19246:
		bsr.w	AllocateObject
		bne.w	locretK_192BE
		move.l	#Obj_SuperSonicKnux_Stars_Timer,(a1)
		move.w	x_pos(a2),x_pos(a1)
		move.w	y_pos(a2),y_pos(a1)
		move.l	#Map_SuperSonic_Stars2,mappings(a1)
		move.w	#make_art_tile(ArtTile_Shield,0,1),art_tile(a1)
		move.b	#$84,render_flags(a1)
		move.w	#$380,priority(a1)
		move.b	#8,width_pixels(a1)
		move.b	#8,height_pixels(a1)
		tst.w	d4
		bmi.s	locK_192AE
		move.w	d4,d0
		jsr	(GetSineCosine).l
		move.w	d4,d2
		lsr.w	#8,d2
		asl.w	d2,d0
		asl.w	d2,d1
		move.w	d0,d2
		move.w	d1,d3
		addi.b	#$10,d4
		bcc.s	locK_192AE
		subi.w	#$80,d4
		bcc.s	locK_192AE
		move.w	#$488,d4
; loc3_17FFA:
locK_192AE:
		move.w	d2,x_vel(a1)
		move.w	d3,y_vel(a1)
		neg.w	d2
		neg.w	d4
		dbf	d5,locK_19246
; locret3_1800A:
locretK_192BE:
		rts
; End of function subK_19236

; ---------------------------------------------------------------------------

Obj_SuperSonicKnux_Stars_Timer:
		tst.b	render_flags(a0)
		bmi.s	locK_192CC
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
; loc3_18018:
locK_192CC:
		addq.b	#1,mapping_frame(a0)
		andi.b	#3,mapping_frame(a0)
		bsr.w	MoveSprite2
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------
Map_SuperSonic_Stars:
		include "General/Sprites/Shields/Map - Super Sonic Stars.asm"