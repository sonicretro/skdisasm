; ---------------------------------------------------------------------------
; word3_29316:
wordK_2A232:
		dc.w     1
		dc.w     3
		dc.w     7
		dc.w    $F
		dc.w   $1F
		dc.w   $3F
		dc.w   $7F
		dc.w   $FF
		dc.w  $1FF
		dc.w  $3FF
		dc.w  $7FF
		dc.w  $FFF
		dc.w $1FFF
		dc.w $3FFF
		dc.w $7FFF
		dc.w $FFFF
; ---------------------------------------------------------------------------

Obj_AIZDisappearingFloor:
		move.b	subtype(a0),d0
		move.b	d0,d1
		andi.w	#$F,d0
		move.w	d0,d2
		add.w	d0,d0
		move.w	wordK_2A232(pc,d0.w),$32(a0)
		subq.w	#3,d2
		bcc.s	locK_2A26C
		moveq	#0,d2
; loc3_29350:
locK_2A26C:
		lsr.w	#4,d1
		andi.w	#$F,d1
		lsl.w	d2,d1
		move.w	d1,$34(a0)
		move.l	#Map_AIZDisappearingFloor,mappings(a0)
		move.w	#make_art_tile(ArtTile_AIZMisc2,2,0),art_tile(a0)	; immediately gets overwritten?
		move.w	#make_art_tile($001,2,0),art_tile(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#4,render_flags(a0)
		move.w	#$280,priority(a0)
		move.w	(Level_frame_counter).w,d0
		add.w	$34(a0),d0
		and.w	$32(a0),d0
		beq.s	locK_2A2D0
		subi.w	#$C8,d0
		bcc.s	locK_2A2D0
		neg.w	d0
		move.b	d0,anim_frame_timer(a0)
		move.b	#0,anim_frame(a0)
		move.w	#(2<<8)|2,anim(a0)	; and prev_anim
		move.b	#5,mapping_frame(a0)
; loc3_293B4:
locK_2A2D0:
		move.l	#locK_2A2D6,(a0)
; loc3_293BA:
locK_2A2D6:
		move.w	(Level_frame_counter).w,d0
		add.w	$34(a0),d0
		and.w	$32(a0),d0
		bne.w	locK_2A300
		move.w	#(1<<8)|0,anim(a0)	; and prev_anim
		move.b	#0,$36(a0)
		tst.b	render_flags(a0)
		bpl.s	locK_2A300
		moveq	#signextendB(sfx_WaterfallSplash),d0
		jsr	(Play_SFX).l
; loc3_293E4:
locK_2A300:
		lea	(Ani_AIZDisappearingFloor).l,a1
		jsr	(Animate_SpriteIrregularDelay).l
		cmpi.b	#5,mapping_frame(a0)
		bne.s	locK_2A366
		tst.b	$36(a0)
		bne.s	locK_2A366
		move.b	#1,$36(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	locK_2A366
		move.l	#locK_2A36C,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.l	#Map_AIZDisappearingFloor2,mappings(a1)
		move.w	#make_art_tile(ArtTile_AIZMisc2,3,0),art_tile(a1)
		move.b	#$28,width_pixels(a1)
		move.b	#$20,height_pixels(a1)
		move.b	#4,render_flags(a1)
		move.w	#$200,priority(a1)
		move.w	a0,$3C(a1)
; loc3_2944A:
locK_2A366:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
; loc3_29450:
locK_2A36C:
		movea.w	$3C(a0),a1
		cmpi.b	#3,mapping_frame(a1)
		bne.s	locK_2A37E
		move.w	#$7FF0,x_pos(a0)
; loc3_29462:
locK_2A37E:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locK_2A394
		move.b	#3,anim_frame_timer(a0)
		addq.b	#1,mapping_frame(a0)
		andi.b	#3,mapping_frame(a0)
; loc3_29478:
locK_2A394:
		move.w	#$2B,d1
		move.w	#$18,d2
		move.w	#$19,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

Ani_AIZDisappearingFloor:
		include "Levels/AIZ/Misc Object Data/Anim - Disappearing Floor.asm"
	if Sonic3_Alone
Map_AIZDisappearingFloor:
		include "Levels/AIZ/Misc Object Data/Map - Disappearing Floor.asm"
	endif