; =============== S U B R O U T I N E =======================================


Delete_Current_Sprite:
		movea.l	a0,a1
; End of function Delete_Current_Sprite


; =============== S U B R O U T I N E =======================================


Delete_Referenced_Sprite:
		moveq	#bytesToLcnt(object_size-2),d0
		moveq	#0,d1

.loop:
		move.l	d1,(a1)+
		dbf	d0,.loop
		move.w	d1,(a1)+
		rts
; End of function Delete_Referenced_Sprite