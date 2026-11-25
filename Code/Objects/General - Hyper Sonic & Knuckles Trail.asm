; ---------------------------------------------------------------------------
		; unused
		dc.l byteK_189ED
		dc.b    0,  $B
		dc.l byteK_18A02
		dc.b  $16,  $D
		dc.l byteK_18A1B
		dc.b  $2C,  $D
; ---------------------------------------------------------------------------

Obj_HyperSonicKnux_Trail:
		; init
		move.l	#Map_Knuckles,mappings(a0)	; Load Knuckles' mappings
		cmpi.w	#3,(Player_mode).w		; Are we playing as Knuckles?
		beq.s	.playingasknux			; If so, branch
		move.l	#Map_SuperSonic,mappings(a0)	; If not, you must be Hyper Sonic, load Super/Hyper Sonic mappings

	.playingasknux:
		move.w	#make_art_tile(ArtTile_Player_1,0,0),art_tile(a0)
		move.w	#$100,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#4,render_flags(a0)
		move.l	#Obj_HyperSonicKnux_Trail_Main,(a0)

Obj_HyperSonicKnux_Trail_Main:
		tst.b	(Super_Sonic_Knux_flag).w	; Are we in non-super/hyper state?
		beq.w	Delete_Current_Sprite		; If so, branch and delete
		moveq	#$C,d1				; This will be subtracted from Pos_table_index, giving the object an older entry
		btst	#0,(Level_frame_counter+1).w	; Even frame? (Think of it as 'every other number' logic)
		beq.s	.evenframe			; If so, branch
		moveq	#$14,d1				; On every other frame, use a different number to subtract, giving the object an even older entry

	.evenframe:
		move.w	(Pos_table_index).w,d0
		lea	(Pos_table).w,a1
		sub.b	d1,d0
		lea	(a1,d0.w),a1
		move.w	(a1)+,x_pos(a0)			; Use previous player x_pos
		move.w	(a1)+,y_pos(a0)			; Use previous player y_pos
		lea	(Stat_table).w,a1
		move.b	3(a1,d0.w),art_tile(a0)
		move.b	(Player_1+mapping_frame).w,mapping_frame(a0)	; Use player's current mapping_frame
		move.b	(Player_1+render_flags).w,render_flags(a0)	; Use player's current render_flags
		move.w	(Player_1+priority).w,priority(a0)		; Use player's current priority
		bra.w	Draw_Sprite