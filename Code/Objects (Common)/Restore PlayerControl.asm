; =============== S U B R O U T I N E =======================================


Restore_PlayerControl:
		lea	(Player_1).w,a1

Restore_PlayerControl2:
		clr.b	object_control(a1)
		bclr	#Status_InAir,status(a1)
		move.w	#(5<<8)|5,anim(a1)	; and prev_anim
		clr.b	anim_frame(a1)
		clr.b	anim_frame_timer(a1)
		rts
; End of function Restore_PlayerControl