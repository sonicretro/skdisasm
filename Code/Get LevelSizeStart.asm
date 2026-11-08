; =============== S U B R O U T I N E =======================================


Get_LevelSizeStart:
		clr.b	(Deform_lock).w
		clr.b	(_unkEE08).w
		clr.b	(Scroll_lock).w
		clr.b	(Scroll_lock_P2).w
		clr.b	(Fast_V_scroll_flag).w
		moveq	#0,d0
		move.b	d0,(Dynamic_resize_routine).w
		move.w	d0,(_unkF660).w
		move.w	d0,(_unkF662).w
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#4,d0
		lea	LevelSizes(pc,d0.w),a0
		move.l	(a0)+,d0
		move.l	d0,(Camera_min_X_pos).w
		move.l	d0,(Camera_target_min_X_pos).w
		move.l	d0,(Camera_min_X_pos_P2).w
		move.l	(a0)+,d0
		move.l	d0,(Camera_min_Y_pos).w
		move.l	d0,(Camera_target_min_Y_pos).w
		move.l	d0,(Camera_min_Y_pos_P2).w
		move.w	#$60,(Distance_from_top).w
		move.w	#$60,(Distance_from_top_P2).w
		move.w	#-1,(Screen_X_wrap_value).w
		move.w	#-1,(Screen_Y_wrap_value).w
		bra.w	locK_1BE46
; ---------------------------------------------------------------------------
LevelSizes:	;     xstart    xend  ystart    yend	; Level
		dc.w   $1308,  $6000,      0,   $390	; AIZ1
		dc.w       0,  $4640,      0,   $590	; AIZ2
		dc.w       0,  $6000,      0,  $1000	; HCZ1
		dc.w       0,  $6000,      0,  $1000	; HCZ2
		dc.w       0,  $6000,  -$100,  $1000	; MGZ1
		dc.w       0,  $6000,      0,  $1000	; MGZ2
		dc.w       0,  $6000,      0,   $B20	; CNZ1
	if Sonic3_Alone
		dc.w       0,  $6000,      0,  $1000	; CNZ2
		dc.w       0,  $6000,      0,  $1000	; FBZ1
		dc.w       0,  $6000,      0,  $1000	; FBZ2
	else
		dc.w       0,  $6000,   $580,  $1000	; CNZ2
		dc.w       0,  $2E60,      0,   $B00	; FBZ1
		dc.w       0,  $6000,      0,   $B00	; FBZ2
	endif
		dc.w       0,  $7000,  -$100,   $800	; ICZ1
		dc.w       0,  $7000,      0,   $B20	; ICZ2
		dc.w       0,  $6000,      0,  $1000	; LBZ1
	if Sonic3_Alone
		dc.w       0,  $6000,      0,  $1000	; LBZ2
		dc.w       0,  $6000,      0,  $1000	; MHZ1
		dc.w       0,  $6000,      0,  $1000	; MHZ2
		dc.w       0,  $6000,      0,  $1000	; SOZ1
		dc.w       0,  $6000,      0,  $1000	; SOZ2
		dc.w       0,  $6000,      0,  $1000	; LRZ1
		dc.w       0,  $6000,      0,  $1000	; LRZ2
		dc.w       0,  $6000,      0,  $1000	; SSZ1
		dc.w       0,  $6000,      0,  $1000	; SSZ2
		dc.w       0,  $6000,      0,  $1000	; DEZ1
		dc.w       0,  $6000,      0,  $1000	; DEZ2
	else
		dc.w       0,  $6000,      0,   $B20	; LBZ2
		dc.w       0,  $4298,      0,   $AA0	; MHZ1
		dc.w     $98,  $3C90,   $620,   $9A0	; MHZ2
		dc.w       0,  $4310,      0,   $B20	; SOZ1
		dc.w       0,  $6000,  -$100,   $800	; SOZ2
		dc.w       0,  $2CC0,      0,   $B20	; LRZ1
		dc.w    $940,  $3EC0,      0,   $B20	; LRZ2
		dc.w       0,  $19A0,  -$100,  $1000	; SSZ1
		dc.w       0,  $6000,      0,   $400	; SSZ2
		dc.w       0,  $6000,      0,   $B20	; DEZ1
		dc.w       0,  $6000,      0,   $F10	; DEZ2
	endif
		dc.w       0,  $6000,      0,  $1000	; DDZ
		dc.w       0,  $6000,      0,  $1000	; DDZ
		dc.w       0,  $6000,      0,  $1000	; AIZ Intro (?)
		dc.w       0,  $6000,      0,  $1000	; Ending scene
		dc.w       0,  $12C0,   $100,   $190	; ALZ
		dc.w       0,  $12C0,   $100,   $190	; ALZ
		dc.w       0,  $12C0,   $200,   $390	; BPZ
		dc.w       0,  $12C0,   $200,   $390	; BPZ
		dc.w       0,  $12C0,   $100,   $190	; DPZ
		dc.w       0,  $12C0,   $100,   $190	; DPZ
		dc.w       0,  $12C0,  -$100,  $1000	; CGZ
		dc.w       0,  $12C0,      0,    $90	; CGZ
		dc.w       0,  $12C0,   $100,   $190	; EMZ
		dc.w       0,  $12C0,   $100,   $190	; EMZ
		dc.w     $60,    $60,      0,   $240	; Gumball
		dc.w     $60,    $60,      0,   $240	; Gumball
	if Sonic3_Alone
		dc.w       0,  $6000,      0,  $1000	; Pachinko
		dc.w       0,  $6000,      0,  $1000	; Pachinko
		dc.w       0,  $6000,      0,  $1000	; Slots
		dc.w       0,  $6000,      0,  $1000	; Slots
		dc.w       0,  $6000,      0,  $1000	; LRZ Boss
		dc.w       0,  $6000,      0,  $1000	; HPZ
		dc.w       0,  $6000,      0,  $1000	; DEZ Boss
		dc.w       0,  $6000,      0,  $1000	; Special Stage Arena (HPZ)
	else
		dc.w       0,   $140,      0,   $F00	; Pachinko
		dc.w       0,   $140,      0,   $F00	; Pachinko
		dc.w       0,  $6000,      0,  $1000	; Slots
		dc.w       0,  $6000,      0,  $1000	; Slots
		dc.w       0,   $EC0,      0,   $430	; LRZ Boss
		dc.w       0,  $1880,      0,   $B20	; HPZ
		dc.w       0,  $6000,    $20,    $20	; DEZ Boss
		dc.w   $1500,  $1640,   $320,   $320	; Special Stage Arena (HPZ)
	endif
; ---------------------------------------------------------------------------
; loc3_1A374:
locK_1BE46:
		tst.b	(Last_star_post_hit).w
		beq.s	locK_1BE5E
		jsr	(Load_Starpost_Settings).l
		move.w	(Player_1+x_pos).w,d1
		move.w	(Player_1+y_pos).w,d0
		bra.w	locK_1BF74
; ---------------------------------------------------------------------------
; loc3_1A38C:
locK_1BE5E:
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#5,d0
	if Sonic3_Alone
		lea	(Start_Locations).l,a1
	else
		lea	(Sonic_Start_Locations).l,a1
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_1BE7A
		lea	(Knux_Start_Locations).l,a1

locK_1BE7A:
	endif
		lea	(a1,d0.w),a1
		moveq	#0,d1
		move.w	(a1)+,d1
		move.w	d1,(Player_1+x_pos).w
		moveq	#0,d0
		move.w	(a1),d0
		move.w	d0,(Player_1+y_pos).w
		tst.b	(Last_star_post_hit).w
		bne.w	locK_1BF74
		cmpi.w	#0,(Current_zone_and_act).w
		bne.s	locK_1BEC6
		cmpi.w	#2,(Player_mode).w
		bhs.s	locK_1BEC6
		move.w	#$40,d1				; If in Angel Island Zone and playing as Sonic, the start position is overridden for the intro
		move.w	d1,(Player_1+x_pos).w
		move.w	#$420,d0
		move.w	d0,(Player_1+y_pos).w
		move.w	#0,d1
		move.w	d1,(Camera_min_X_pos).w
		move.w	d1,(Camera_target_min_X_pos).w
		move.w	d1,(Camera_min_X_pos_P2).w
; loc3_1A3E6:
locK_1BEC6:
		cmpi.w	#$500,(Current_zone_and_act).w
		bne.s	locK_1BF1E
		cmpi.w	#2,(Player_mode).w
		blo.s	locK_1BF1E
	if ~~Sonic3_Alone
		bne.s	locK_1BF1E
	endif
		move.w	#$35A0,d1			; If in Ice Cap Act 1 and playing as Tails,
		move.w	d1,(Camera_min_X_pos).w	; we use a different start position and different level sizes
		move.w	d1,(Camera_target_min_X_pos).w	; to skip the snowboarding sequence
		move.w	d1,(Camera_min_X_pos_P2).w
		move.w	#$3780,d1
		move.w	d1,(Player_1+x_pos).w
		move.w	#$36F0,d1
		move.w	d1,(Camera_X_pos).w
		move.w	d1,(Camera_X_pos_P2).w
		move.w	#$1E0,d0
		move.w	d0,(Player_1+y_pos).w
		move.w	#$200,d0
		move.w	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_target_min_Y_pos).w
		move.w	d0,(Camera_min_Y_pos_P2).w
		move.w	d0,(Camera_Y_pos).w
		move.w	d0,(Camera_Y_pos_P2).w
		rts
; ---------------------------------------------------------------------------
; loc3_1A43C:
locK_1BF1E:
	if ~~Sonic3_Alone
		cmpi.w	#$700,(Current_zone_and_act).w
		bne.s	locK_1BF48
		cmpi.w	#3,(Player_mode).w
		bhs.s	locK_1BF48
		tst.w	(SK_alone_flag).w
		bne.s	locK_1BF48
		move.w	#$C0,d2				; If playing as Sonic/Tails in MHZ 1 with Sonic 3 locked on, modify level size
		move.w	d2,(Camera_min_X_pos).w
		move.w	d2,(Camera_target_min_X_pos).w
		move.w	d2,(Camera_min_X_pos_P2).w
		move.w	#$160,d1

locK_1BF48:
		cmpi.w	#$1601,(Current_zone_and_act).w
		beq.s	locK_1BF70
		cmpi.w	#$B00,(Current_zone_and_act).w
		beq.s	locK_1BF70
		cmpi.w	#$900,(Current_zone_and_act).w
		beq.s	locK_1BF68
		cmpi.w	#$300,(Current_zone_and_act).w
		bne.s	locK_1BF74

locK_1BF68:
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_1BF74

locK_1BF70:
		addi.w	#$B0,d1		; Only if in Hidden Palace, in Death Egg 1, in Lava Reef 1 as Knuckles, in Carnival Night 1 as Knuckles
							; This is likely for level intros that start behind the camera
	endif

locK_1BF74:
		subi.w	#$A0,d1
		bcc.s	locK_1BF7C
		moveq	#0,d1
; loc3_1A444:
locK_1BF7C:
		tst.w	(Competition_mode).w
		bne.s	locK_1BF8C
		move.w	(Camera_max_X_pos).w,d2
		cmp.w	d2,d1
		blo.s	locK_1BF8C
		move.w	d2,d1
; loc3_1A454:
locK_1BF8C:
		move.w	d1,(Camera_X_pos).w
		move.w	d1,(Camera_X_pos_P2).w
		subi.w	#$60,d0
		bcc.s	locK_1BF9C
		moveq	#0,d0
; loc3_1A464:
locK_1BF9C:
		cmp.w	(Camera_max_Y_pos).w,d0
		blt.s	locK_1BFA6
		move.w	(Camera_max_Y_pos).w,d0
; loc3_1A46E:
locK_1BFA6:
		move.w	d0,(Camera_Y_pos).w
		move.w	d0,(Camera_Y_pos_P2).w
		rts
; End of function Get_LevelSizeStart