; =============== S U B R O U T I N E =======================================


UpdateWaterSurface:
		rts
; ---------------------------------------------------------------------------
		; unused leftover from Sonic 2
		tst.b	(Water_flag).w
		beq.s	locret3_50DC
		move.w	(Camera_X_pos).w,d1
	if FixBugs
		; This function can cause the water surface's to be cut off at the
		; left when the game is paused. This is because this function pushes
		; the water surface sprite to the right every frame. To fix this,
		; just avoid pushing the sprite to the right when the game is about
		; to be paused.
		move.b	(Ctrl_1_pressed).w,d0 ; is Start button pressed?
		or.b	(Ctrl_2_pressed).w,d0 ; (either player)
		andi.b	#button_start_mask,d0
		bne.s	loc3_50D2
	endif
		btst	#0,(Level_frame_counter+1).w
		beq.s	loc3_50D2
		addi.w	#$20,d1

loc3_50D2:
		move.w	d1,d0
		addi.w	#$60,d0
		addi.w	#$120,d1

locret3_50DC:
		rts
; End of function UpdateWaterSurface