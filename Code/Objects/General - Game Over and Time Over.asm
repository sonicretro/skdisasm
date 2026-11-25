; ---------------------------------------------------------------------------

Obj_GameOver:
		tst.l	(Nem_decomp_queue).w
		beq.s	locK_2D5CE
		rts
; ---------------------------------------------------------------------------
; loc_2C9B4:
locK_2D5CE:
	if ~~Sonic3_Alone
		tst.b	mapping_frame(a0)
		bne.s	locK_2D5DE
		st	(SRAM_mask_interrupts_flag).w
		jsr	(SaveGame_LivesContinues).l

locK_2D5DE:
	endif
		move.w	#$50,x_pos(a0)
		btst	#0,mapping_frame(a0)
		beq.s	locK_2D5F2
		move.w	#$1F0,x_pos(a0)
; loc3_2C9C8:
locK_2D5F2:
		move.w	#$F0,y_pos(a0)
		move.l	#Map_GameOver,mappings(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,1),art_tile(a0)
		move.w	#0,priority(a0)
		move.l	#locK_2D612,(a0)
; loc3_2C9E8:
locK_2D612:
		moveq	#$10,d1
		cmpi.w	#$120,x_pos(a0)
		beq.s	locK_2D62A
		bcs.s	locK_2D620
		neg.w	d1
; loc3_2C9F6:
locK_2D620:
		add.w	d1,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_2CA00:
locK_2D62A:
		move.w	#8*60,anim_frame_timer(a0)
		move.l	#locK_2D638,(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_2CA0E:
locK_2D638:
		move.w	#0,(Collision_response_list).w
		btst	#0,mapping_frame(a0)
		bne.w	locK_2D68A
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask|button_start_mask,d0
		bne.s	locK_2D666
		tst.w	anim_frame_timer(a0)
		beq.s	locK_2D666
		subq.w	#1,anim_frame_timer(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_2CA3C:
locK_2D666:
		tst.b	(Time_over_flag).w
		bne.s	locK_2D680
		move.b	#GameMode_Continue,(Game_mode).w
		tst.b	(Continue_count).w
		bne.s	locK_2D68A
		move.b	#GameMode_SegaScreen,(Game_mode).w
		bra.s	locK_2D68A
; ---------------------------------------------------------------------------
; loc3_2CA56:
locK_2D680:
		clr.l	(Saved_timer).w
		move.w	#1,(Restart_level_flag).w
; loc3_2CA60:
locK_2D68A:
		jmp	(Draw_Sprite).l