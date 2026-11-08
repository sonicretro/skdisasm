; ---------------------------------------------------------------------------

Obj_HyperSonic_Stars:
		lea	(ArtKosM_HyperSonicStars).l,a1
		move.w	#tiles_to_bytes(ArtTile_Shield),d2
		jsr	(Queue_Kos_Module).l
		lea	(a0),a1
		moveq	#0,d0
		moveq	#0,d2
		moveq	#4-1,d1

	.createObject:
		move.l	#Obj_HyperSonic_Stars_Init,(a1)
		move.b	d0,angle(a1)
		addi.b	#$40,d0
		addq.b	#1,d2
		move.b	d2,anim_frame_timer(a1)
		lea	next_object(a1),a1
		dbf	d1,.createObject

Obj_HyperSonic_Stars_Init:
		; Wait for art to finish loading before we display
		tst.b	(Kos_modules_left).w
		beq.s	.artDoneLoading

	.return:
		rts
; ---------------------------------------------------------------------------

	.artDoneLoading:
		subq.b	#1,anim_frame_timer(a0)
		bne.s	.return
		move.l	#Map_HyperSonicStars,mappings(a0)
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a0)
		move.b	#6,mapping_frame(a0)
		cmpa.w	#Invincibility_stars,a0
		beq.s	.isParent
		move.l	#Obj_HyperSonic_Stars_Main.child,(a0)
		bra.s	Obj_HyperSonic_Stars_Main.child
; ---------------------------------------------------------------------------

	.isParent:
		move.l	#Obj_HyperSonic_Stars_Main,(a0)

Obj_HyperSonic_Stars_Main:
		tst.b	anim(a0)
		beq.s	.child
		clr.b	anim(a0)
		move.w	(Player_1+x_pos).w,x_pos(a0)
		move.w	(Player_1+y_pos).w,y_pos(a0)
		moveq	#2,d2
		bsr.w	Obj_LightningShield_CreateSpark_Part2
		move.b	#4,(Hyper_Sonic_flash_timer).w

	.child:
		tst.b	(Super_Sonic_Knux_flag).w
		beq.w	locK_19486
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locK_1941C
		move.b	#1,anim_frame_timer(a0)
		addq.b	#1,mapping_frame(a0)
		cmpi.b	#3,mapping_frame(a0)
		blo.s	locK_1941C
		move.b	#0,mapping_frame(a0)
		moveq	#0,d0
		move.w	d0,$30(a0)
		move.w	d0,$34(a0)

locK_1941C:
		move.b	angle(a0),d0
		addi.b	#-$10,angle(a0)
		jsr	(GetSineCosine).l
		asl.w	#3,d0
		asl.w	#3,d1
		move.w	d0,x_vel(a0)
		move.w	d1,y_vel(a0)
		move.w	x_vel(a0),d0
		add.w	d0,$30(a0)
		move.w	y_vel(a0),d1
		add.w	d1,$34(a0)
		move.b	$30(a0),d2
		ext.w	d2
		btst	#Status_Facing,(Player_1+status).w
		beq.s	locK_19458
		neg.w	d2

locK_19458:
		move.b	$34(a0),d3
		ext.w	d3
		add.w	(Player_1+x_pos).w,d2
		add.w	(Player_1+y_pos).w,d3
		move.w	d2,x_pos(a0)
		move.w	d3,y_pos(a0)
		andi.w	#drawing_mask,art_tile(a0)
		tst.b	(Player_1+art_tile).w
		bpl.s	locK_19480
		ori.w	#high_priority,art_tile(a0)

locK_19480:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locK_19486:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
Map_HyperSonicStars:
		include "General/Sprites/Sonic/Map - Hyper Sonic Stars.asm"