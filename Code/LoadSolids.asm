
; =============== S U B R O U T I N E =======================================


LoadSolids:
		moveq	#0,d0
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#5,d0
		lea	(SolidIndexes).l,a1
		adda.l	d0,a1
		move.l	(a1),d0
		move.l	d0,(Primary_collision_addr).w
	if ~~Sonic3_Alone
		if Sonic3_Complete=0
			cmpi.l	#S3_Level_Solid_Data,d0
			blo.s	LoadSolids_SK_Interleaved_Format
		else
			bpl.s	LoadSolids_SK_Interleaved_Format
		endif
	endif
		addi.l	#$600,d0
		move.l	d0,(Secondary_collision_addr).w
	if Sonic3_Alone
		move.l	#Primary_collision_addr,(Collision_addr).w
	else
		move.l	(Primary_collision_addr).w,(Collision_addr).w
	endif
		rts
; ---------------------------------------------------------------------------
	if ~~Sonic3_Alone
LoadSolids_SK_Interleaved_Format:
		addq.l	#1,d0
		move.l	d0,(Secondary_collision_addr).w
		move.l	(Primary_collision_addr).w,(Collision_addr).w
		rts
	endif
; End of function LoadSolids