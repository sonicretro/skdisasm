; =============== S U B R O U T I N E =======================================


Draw_Sprite:
		lea	(Sprite_table_input).w,a1
		adda.w	priority(a0),a1

locK_1ABCE:
		cmpi.w	#$7E,(a1)
	if Sonic3_Alone
		bhs.s	locretK_1ABDA
	else
		bhs.s	locK_1ABDC
	endif
		addq.w	#2,(a1)
		adda.w	(a1),a1
		move.w	a0,(a1)
; locret3_19254:
locretK_1ABDA:
		rts
; ---------------------------------------------------------------------------
	if ~~Sonic3_Alone
locK_1ABDC:
		cmpa.w	#Sprite_table_input+($80*7),a1
		beq.s	locretK_1ABDA
		adda.w	#$80,a1
		bra.s	locK_1ABCE
	endif
; End of function Draw_Sprite