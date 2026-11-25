; ---------------------------------------------------------------------------
; Generates a pseudo-random number in d0
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Random_Number:
		move.l	(RNG_seed).w,d1
	if Sonic3_Alone
		bne.s	+
		move.l	#$2A6D365A,d1	; reset seed if needed
	else
		tst.w	d1
		bne.s	+
		move.l	#$2A6D365B,d1	; reset seed if needed
	endif
+
		move.l	d1,d0
		asl.l	#2,d1
		add.l	d0,d1
		asl.l	#3,d1
		add.l	d0,d1
		move.w	d1,d0
		swap	d1
		add.w	d1,d0
		move.w	d0,d1
		swap	d1
		move.l	d1,(RNG_seed).w
		rts
; End of function Random_Number