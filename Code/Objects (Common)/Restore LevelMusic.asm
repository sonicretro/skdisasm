; ---------------------------------------------------------------------------

Obj_Song_Fade_ToLevelMusic:
		move.w	#2*60,$2E(a0)
		moveq	#signextendB(cmd_FadeOut),d0
		jsr	(Play_Music).l
		move.l	#locK_85B1E,(a0)
; loc3_54048:
locK_85B1E:
		subq.w	#1,$2E(a0)
	if Sonic3_Alone
		bpl.w	locret_529CE
	else
		bpl.w	locret_8405E
	endif
		bsr.w	Restore_LevelMusic
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_Song_Fade_Transition:
	if Sonic3_Alone
		move.w	#2*60,$2E(a0)
	else
		move.w	#90,$2E(a0)
	endif
		moveq	#signextendB(cmd_FadeOut),d0
		jsr	(Play_Music).l
		move.l	#locK_85B44,(a0)
; loc3_5406E:
locK_85B44:
		subq.w	#1,$2E(a0)
	if Sonic3_Alone
		bpl.w	locret_529CE
	else
		bpl.w	locret_8405E
	endif
		move.b	subtype(a0),d0
	if ~~Sonic3_Alone
		move.b	d0,(Current_music+1).w
	endif
		jsr	(Play_Music).l
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


Restore_LevelMusic:
		moveq	#0,d0
		lea	(Apparent_zone_and_act).w,a1
		move.b	(a1)+,d0
		add.b	d0,d0
		add.b	(a1),d0
	if Sonic3_Alone
		move.b	PlayLevelMusic_Playlist(pc,d0.w),d0
	else
		lea	(LevelMusic_Playlist).l,a2
		move.b	(a2,d0.w),d0
	endif
		move.w	d0,(Current_music).w
		btst	#Status_Invincible,(Player_1+status_secondary).w
		beq.s	locK_85B84
		moveq	#signextendB(mus_Invincibility),d0		; If invincible, play invincibility
; loc3_540A4:
locK_85B84:
		jmp	(Play_Music).l
; End of function Restore_LevelMusic

	if Sonic3_Alone
; ---------------------------------------------------------------------------

PlayLevelMusic_Playlist:
		dc.b mus_AIZ1, mus_AIZ2
		dc.b mus_HCZ1, mus_HCZ2
		dc.b mus_MGZ1, mus_MGZ2
		dc.b mus_CNZ1, mus_CNZ2
		dc.b mus_FBZ1, mus_FBZ2
		dc.b mus_ICZ1, mus_ICZ2
		dc.b mus_LBZ1, mus_LBZ2
	endif