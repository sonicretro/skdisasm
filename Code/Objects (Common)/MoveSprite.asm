; ---------------------------------------------------------------------------
; Subroutine to make an object move and fall downward increasingly fast
; This moves the object horizontally and vertically
; and also applies gravity to its speed
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================

MoveSprite:
		move.w	x_vel(a0),d0	; load x speed
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,x_pos(a0)	; add x speed to x position	; note this affects the subpixel position x_sub(a0) = 2+x_pos(a0)
		move.w	y_vel(a0),d0	; load y speed
		addi.w	#$38,y_vel(a0)	; increase vertical speed (apply gravity)
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,y_pos(a0)	; add old y speed to y position	; note this affects the subpixel position y_sub(a0) = 2+y_pos(a0)
		rts
; End of function MoveSprite

; ---------------------------------------------------------------------------
; Subroutine translating object speed to update object position
; This moves the object horizontally and vertically
; but does not apply gravity to it
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================

MoveSprite2:
		move.w	x_vel(a0),d0	; load horizontal speed
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,x_pos(a0)	; add to x-axis position	; note this affects the subpixel position x_sub(a0) = 2+x_pos(a0)
		move.w	y_vel(a0),d0	; load vertical speed
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,y_pos(a0)	; add to y-axis position	; note this affects the subpixel position y_sub(a0) = 2+y_pos(a0)
		rts
; End of function MoveSprite2

	if ~~Sonic3_Alone
; =============== S U B R O U T I N E =======================================

MoveSprite_TestGravity:
		tst.b	(Reverse_gravity_flag).w
		beq.s	MoveSprite

		move.w	x_vel(a0),d0	; load x speed
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,x_pos(a0)	; add x speed to x position	; note this affects the subpixel position x_sub(a0) = 2+x_pos(a0)
		move.w	y_vel(a0),d0	; load y speed
		addi.w	#$38,y_vel(a0)	; increase vertical speed (apply gravity)
		neg.w	d0		; reverse it
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,y_pos(a0)	; add old y speed to y position	; note this affects the subpixel position y_sub(a0) = 2+y_pos(a0)
		rts
; End of function MoveSprite_TestGravity


; =============== S U B R O U T I N E =======================================

MoveSprite_TestGravity2:
		tst.b	(Reverse_gravity_flag).w
		beq.s	MoveSprite2

		move.w	x_vel(a0),d0	; load horizontal speed
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,x_pos(a0)	; add to x-axis position	; note this affects the subpixel position x_sub(a0) = 2+x_pos(a0)
		move.w	y_vel(a0),d0	; load vertical speed
		neg.w	d0		; reverse it
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,y_pos(a0)	; add to y-axis position	; note this affects the subpixel position y_sub(a0) = 2+y_pos(a0)
		rts
; End of function MoveSprite_TestGravity2
	endif