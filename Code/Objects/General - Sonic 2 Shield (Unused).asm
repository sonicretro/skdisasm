; ---------------------------------------------------------------------------

Obj_S2Shield:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Obj_S2Shield_Index(pc,d0.w),d1
		jmp	Obj_S2Shield_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj_S2Shield_Index:
		dc.w Obj_S2Shield_Init-Obj_S2Shield_Index
		dc.w Obj_S2Shield_Main-Obj_S2Shield_Index
; ---------------------------------------------------------------------------

Obj_S2Shield_Init:
		addq.b	#2,routine(a0)
		move.l	#Map_S2Shield,mappings(a0)
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a0)

Obj_S2Shield_Main:
		movea.w	parent(a0),a2
		btst	#Status_Invincible,status_secondary(a2)
		bne.s	locretK_187D6
		btst	#Status_Shield,status_secondary(a2)
		beq.s	Obj_S2Shield_Destroy
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		move.b	status(a2),status(a0)
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	Obj_S2Shield_Display
		ori.w	#high_priority,art_tile(a0)

Obj_S2Shield_Display:
		lea	(Ani_S2Shield).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; locret3_17566:
locretK_187D6:
		rts
; ---------------------------------------------------------------------------

Obj_S2Shield_Destroy:
		jmp	(Delete_Current_Sprite).l