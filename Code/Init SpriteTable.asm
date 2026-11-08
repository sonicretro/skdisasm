; =============== S U B R O U T I N E =======================================


Init_SpriteTable:
		clr.w	(Spritemask_flag).w
	if Sprite_table_page_flip_pending<>(Current_sprite_table_page+2)
		clr.w	(Current_sprite_table_page).w
		clr.w	(Sprite_table_page_flip_pending).w
	else
		clr.l	(Current_sprite_table_page).w ; Clears both Current_sprite_table_page and Sprite_table_page_flip_pending!
	endif
		tst.w	(Competition_mode).w
		beq.s	locK_1AA9E
		lea	(Sprite_table).w,a0
		bsr.s	Init_SpriteTable2
		bsr.s	Init_SpriteTable_2Player
		lea	(Sprite_table_alternate).l,a0
		bsr.s	Init_SpriteTable2
		bsr.s	Init_SpriteTable_2Player
		lea	(Sprite_table_P2).l,a0
		bsr.s	Init_SpriteTable2
		lea	(Sprite_table_P2_alternate).l,a0
		bra.s	Init_SpriteTable2
; ---------------------------------------------------------------------------
; loc3_19162:
locK_1AA9E:
		lea	(Sprite_table).w,a0
; End of function Init_SpriteTable


; =============== S U B R O U T I N E =======================================


Init_SpriteTable2:
		moveq	#0,d0
		moveq	#1,d1
		moveq	#bytesToXcnt(Sprite_table_end-Sprite_table,8),d7

.loop:
		move.w	d0,(a0)
		move.b	d1,3(a0)
		addq.w	#1,d1
		addq.w	#8,a0
		dbf	d7,.loop
		move.b	d0,-5(a0)
		rts
; End of function Init_SpriteTable2


; =============== S U B R O U T I N E =======================================


Init_SpriteTable_2Player:
		lea	-$280(a0),a0
		move.l	#$EB0301,(a0)+
		move.l	#1,(a0)+
		move.l	#$EB0302,(a0)+
		move.l	#0,(a0)
		rts
; End of function Init_SpriteTable_2Player