; =============== S U B R O U T I N E =======================================


LoadLevelLoadBlock:
		move.w	(Current_zone_and_act).w,d0
		bne.s	locK_782A
		cmpi.w	#2,(Player_mode).w
	if Sonic3_Alone
		beq.s	locK_7826
	else
		bhs.s	locK_7826
	endif
		tst.b	(Last_star_post_hit).w
		beq.s	locK_782A
; loc3_5E34:
locK_7826:
		move.w	#$D00,d0
; loc3_5E38:
locK_782A:
		ror.b	#1,d0
		lsr.w	#4,d0
		andi.w	#$1F8,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		lea	(LevelLoadBlock).l,a4
		lea	(a4,d0.w),a4
		move.l	(a4)+,d0
		andi.l	#$FFFFFF,d0
		move.l	d0,d7
		movea.l	d0,a1
		move.w	(a1),d4
		move.w	#0,d2
		jsr	(Queue_Kos_Module).l
		move.l	(a4)+,d0
		andi.l	#$FFFFFF,d0
		cmp.l	d0,d7
		beq.s	locK_7870
		movea.l	d0,a1
		move.w	d4,d2
		jsr	(Queue_Kos_Module).l

locK_7870:
		move.b	#VInt_ID_C,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		bsr.w	Wait_VSync
		bsr.w	Process_Nem_Queue_Init
		jsr	(Process_Kos_Module_Queue).l
		tst.b	(Kos_modules_left).w
		bne.s	locK_7870
		rts
; End of function LoadLevelLoadBlock