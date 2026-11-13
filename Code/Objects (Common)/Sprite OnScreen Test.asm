; ---------------------------------------------------------------------------

Sprite_OnScreen_Test:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	locK_1B5A0
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------
; loc3_19C02:
locK_1B5A0:
		move.w	respawn_addr(a0),d0
		beq.s	locK_1B5AC
		movea.w	d0,a2
		bclr	#7,(a2)
; loc3_19C0E:
locK_1B5AC:
		bra.w	Delete_Current_Sprite
; ---------------------------------------------------------------------------

Sprite_OnScreen_Test2:
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	locK_1B5C4
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------
; loc3_19C26:
locK_1B5C4:
		move.w	respawn_addr(a0),d0
		beq.s	locK_1B5D0
		movea.w	d0,a2
		bclr	#7,(a2)
; loc3_19C32:
locK_1B5D0:
		bra.w	Delete_Current_Sprite

; =============== S U B R O U T I N E =======================================


Delete_Sprite_If_Not_In_Range:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	locK_1B5EA
		rts
; ---------------------------------------------------------------------------
; loc3_19C4C:
locK_1B5EA:
		move.w	respawn_addr(a0),d0
		beq.s	locK_1B5F6
		movea.w	d0,a2
		bclr	#7,(a2)
; loc3_19C58:
locK_1B5F6:
		bra.w	Delete_Current_Sprite
; End of function Delete_Sprite_If_Not_In_Range

; ---------------------------------------------------------------------------
		; unused
		tst.w	(Competition_mode).w
		bne.s	locK_1B628
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	locK_1B618
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------
; loc3_19C7A:
locK_1B618:
		move.w	respawn_addr(a0),d0
		beq.s	locK_1B624
		movea.w	d0,a2
		bclr	#7,(a2)
; loc3_19C86:
locK_1B624:
		bra.w	Delete_Current_Sprite
; ---------------------------------------------------------------------------
; loc3_19C8A:
locK_1B628:
		move.w	x_pos(a0),d0
		andi.w	#$FF00,d0
		move.w	d0,d1
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$300,d0
		bhi.w	locK_1B642
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------
; loc3_19CA4:
locK_1B642:
		sub.w	(_unkF7DC).w,d1
		cmpi.w	#$300,d1
		bhi.w	locK_1B652
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------
; loc3_19CB4:
locK_1B652:
		move.w	respawn_addr(a0),d0
		beq.s	locK_1B65E
		movea.w	d0,a2
		bclr	#7,(a2)
; loc3_19CC0:
locK_1B65E:
		bra.w	Delete_Current_Sprite
; ---------------------------------------------------------------------------

Sprite_CheckDeleteTouch3:
		move.w	x_pos(a0),d0
; loc3_19CC8: locK_1B666:
Sprite_CheckDeleteTouch3_A0:
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	locK_1B680
		jsr	(Add_SpriteToCollisionResponseList).l
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------
; loc3_19CE2:
locK_1B680:
		move.w	respawn_addr(a0),d0
		beq.s	locK_1B68C
		movea.w	d0,a2
		bclr	#7,(a2)
; loc3_19CEE:
locK_1B68C:
		bra.w	Delete_Current_Sprite