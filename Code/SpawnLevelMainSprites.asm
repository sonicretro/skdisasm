; =============== S U B R O U T I N E =======================================


LevelLoad_ActiveCharacter:
		cmpi.b	#GameMode_Demo+$80,(Game_mode).w
		beq.s	locK_67CC
		tst.w	(Competition_mode).w
		bne.s	locK_67CC
		move.w	(Player_option).w,(Player_mode).w		; Move selected character to active character
		rts
; ---------------------------------------------------------------------------
; loc3_4DAE:
locK_67CC:
	if Sonic3_Alone
		move.w	#0,(Player_mode).w
	else
		move.w	#3,(Player_mode).w			; If loading a demo OR 2P mode enabled (?)
		cmpi.b	#7,(Current_zone).w
		beq.s	locretK_67EC
		move.w	#0,(Player_mode).w
		tst.w	(SK_alone_flag).w
		beq.s	locretK_67EC
		move.w	#1,(Player_mode).w

locretK_67EC:
	endif
		rts
; End of function LevelLoad_ActiveCharacter


; =============== S U B R O U T I N E =======================================


SpawnLevelMainSprites:
		move.l	#Obj_ResetCollisionResponseList,(Reserved_object_3).w
		bsr.w	SpawnLevelMainSprites_SpawnPlayers
		bsr.w	SpawnLevelMainSprites_SpawnPowerup
		tst.b	(Last_star_post_hit).w
		bne.w	locretK_69B6
		tst.b	(Special_bonus_entry_flag).w
		bne.w	locretK_69B6
		lea	(Player_1).w,a1
		lea	(Player_2).w,a2
		cmpi.w	#0,(Current_zone_and_act).w
		bne.s	locK_6834
		cmpi.w	#2,(Player_mode).w
	if Sonic3_Alone
		beq.s	locretK_6832
	else
		bhs.s	locretK_6832
	endif
		move.l	#Obj_AIZPlaneIntro,(Dynamic_object_RAM+(object_size*2)).w
		clr.b	(Level_started_flag).w
	if Sonic3_Alone
		rts
	endif

; locret3_4DFC:
locretK_6832:
		rts
; ---------------------------------------------------------------------------
; loc3_4DFE:
locK_6834:
		cmpi.w	#$100,(Current_zone_and_act).w
		bne.s	locK_6886
		move.b	#$1B,anim(a1)
	if ~~Sonic3_Alone
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_685C
		move.w	#($21<<8)|$21,anim(a1)	; and prev_anim
		move.b	#1,anim_frame(a1)
	if FixBugs
		move.b	#0,anim_frame_timer(a1)
	else
		; Bug: this tries to clear Knuckles' anim_frame_timer, but Knuckles is in a1
		move.b	#0,anim_frame_timer(a0)
	endif

locK_685C:
	endif
		bset	#Status_InAir,status(a1)
		cmpi.w	#2,(Player_mode).w
		bne.s	locK_6870
		move.b	#1,jumping(a1)
; loc3_4E20:
locK_6870:
		tst.l	(a2)
		beq.s	locK_6886
		move.b	#$1B,anim(a2)
		bset	#Status_InAir,status(a2)
		move.b	#1,jumping(a2)
; loc3_4E36:
locK_6886:
	if ~~Sonic3_Alone
		cmpi.w	#$900,(Current_zone_and_act).w
		bne.s	locK_6896
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_68A6

locK_6896:
		cmpi.w	#$1600,(Current_zone_and_act).w
		beq.s	locK_68A6
	endif
		cmpi.w	#$200,(Current_zone_and_act).w
		bne.s	locK_68C2

locK_68A6:
		move.b	#$1B,anim(a1)
		bset	#Status_InAir,status(a1)
		tst.l	(a2)
		beq.s	locK_68C2
		move.b	#$1B,anim(a2)
		bset	#Status_InAir,status(a2)
; loc3_4E5A:
locK_68C2:
	if ~~Sonic3_Alone
		cmpi.w	#$700,(Current_zone_and_act).w
		bne.s	locK_68D0
		tst.w	(SK_alone_flag).w
		beq.s	locK_68D8

locK_68D0:
	endif
		cmpi.w	#$300,(Current_zone_and_act).w
		bne.s	locK_690A

locK_68D8:
		cmpi.w	#1,(Player_mode).w
		bne.s	locK_68FC
		move.l	#Obj_Tails,(Player_2).w
		move.w	(Player_1+x_pos).w,(Player_2+x_pos).w
		move.w	(Player_1+y_pos).w,(Player_2+y_pos).w
		move.w	#0,(Tails_CPU_routine).w
		bra.s	locK_690A
; ---------------------------------------------------------------------------
; loc3_5E86:
locK_68FC:
		cmpi.w	#2,(Player_mode).w
		bne.s	locK_690A
		move.w	#$20,(Tails_CPU_routine).w
; loc3_4E94:
locK_690A:
		cmpi.w	#$500,(Current_zone_and_act).w
		bne.s	locK_692E
		cmpi.w	#2,(Player_mode).w
		blo.s	locK_6926
	if ~~Sonic3_Alone
		bne.s	locK_692E
	endif
		move.l	#Obj_LevelIntroICZ1Tails,(Dynamic_object_RAM+(object_size*2)).w
		bra.s	locK_692E
; ---------------------------------------------------------------------------
; loc3_4EAE:
locK_6926:
		move.l	#Obj_LevelIntroICZ1,(Dynamic_object_RAM+(object_size*2)).w
; loc3_4EB6:
locK_692E:
		cmpi.w	#$600,(Current_zone_and_act).w
		bne.s	locK_693E
		move.l	#Obj_LevelIntro_PlayerLaunchFromGround,(Dynamic_object_RAM+(object_size*2)).w

locK_693E:
	if ~~Sonic3_Alone
		cmpi.w	#$700,(Current_zone_and_act).w
		bne.s	locK_695A
		cmpi.w	#3,(Player_mode).w
		bne.s	locK_695A
		move.b	#$1B,anim(a1)
		bset	#Status_InAir,status(a1)

locK_695A:
		cmpi.w	#$800,(Current_zone_and_act).w
		bne.s	locK_6986
		move.l	#Obj_LevelIntro_PlayerFallIntoGround,(Dynamic_object_RAM+(object_size*2)).w
		move.b	#2,anim(a1)
		bset	#Status_InAir,status(a1)
		tst.l	(a2)
		beq.s	locK_6986
		move.b	#2,anim(a2)
		bset	#Status_InAir,status(a2)

locK_6986:
		cmpi.w	#$300,(Current_zone_and_act).w
		beq.s	locK_69A6
		cmpi.w	#$B00,(Current_zone_and_act).w
		beq.s	locK_69AE
		cmpi.w	#$1601,(Current_zone_and_act).w
		beq.s	locK_69AE
		cmpi.w	#$900,(Current_zone_and_act).w
		bne.s	locretK_69B6

locK_69A6:
		cmpi.w	#3,(Player_mode).w
		bne.s	locretK_69B6

locK_69AE:
		move.l	#Obj_LevelIntro_PlayerRun,(Dynamic_object_RAM+(object_size*2)).w
	endif
; locret3_4EC6:
locretK_69B6:
		rts
; End of function SpawnLevelMainSprites


; =============== S U B R O U T I N E =======================================


SpawnLevelMainSprites_SpawnPowerup:
	if ~~Sonic3_Alone
		cmpi.w	#$D01,(Current_zone_and_act).w
		beq.s	locretK_6A00
		cmpi.b	#$13,(Current_zone).w
		beq.s	locK_69E0
		cmpi.b	#$14,(Current_zone).w
		beq.s	locK_69E0
		cmpi.b	#$16,(Current_zone).w
		bhs.s	locK_69E0
	endif
		cmpi.b	#$E,(Current_zone).w
		bhs.s	locretK_6A00

locK_69E0:
		lea	(Player_1).w,a1
		move.b	(Saved_status_secondary).w,d0
		clr.b	(Saved_status_secondary).w
		andi.b	#(1<<Status_FireShield)|(1<<Status_LtngShield)|(1<<Status_BublShield),d0
		bne.s	locK_6A02
		move.b	(Saved2_status_secondary).w,d0
		clr.b	(Saved2_status_secondary).w
		andi.b	#(1<<Status_FireShield)|(1<<Status_LtngShield)|(1<<Status_BublShield),d0
		bne.s	locK_6A02
; locret3_4EF0:
locretK_6A00:
		rts
; ---------------------------------------------------------------------------
; loc3_4EF2:
locK_6A02:
		btst	#Status_FireShield,d0
		beq.s	locK_6A28
		andi.b	#$8E,status_secondary(a1)
		bset	#Status_Shield,status_secondary(a1)
		bset	#Status_FireShield,status_secondary(a1)
		move.l	#Obj_FireShield,(Shield).w
		move.w	a1,(Shield+parent).w
		rts
; ---------------------------------------------------------------------------
; loc3_4F18:
locK_6A28:
		btst	#Status_LtngShield,d0
		beq.s	locK_6A4E
		andi.b	#$8E,status_secondary(a1)
		bset	#Status_Shield,status_secondary(a1)
		bset	#Status_LtngShield,status_secondary(a1)
		move.l	#Obj_LightningShield,(Shield).w
		move.w	a1,(Shield+parent).w
		rts
; ---------------------------------------------------------------------------
; loc3_4F3E:
locK_6A4E:
		btst	#Status_BublShield,d0
		beq.s	locretK_6A74
		andi.b	#$8E,status_secondary(a1)
		bset	#Status_Shield,status_secondary(a1)
		bset	#Status_BublShield,status_secondary(a1)
		move.l	#Obj_BubbleShield,(Shield).w
		move.w	a1,(Shield+parent).w
		rts
; ---------------------------------------------------------------------------
; locret3_4F64:
locretK_6A74:
		rts
; End of function SpawnLevelMainSprites_SpawnPowerup


; =============== S U B R O U T I N E =======================================


SpawnLevelMainSprites_SpawnPlayers:
	if ~~Sonic3_Alone
		cmpi.w	#$1300,(Current_zone_and_act).w
		blo.s	locK_6A8A
		cmpi.w	#$1600,(Current_zone_and_act).w
		bhs.s	locK_6A8A
		clr.b	(Update_HUD_timer).w

locK_6A8A:
		cmpi.w	#$1400,(Current_zone_and_act).w
		bne.s	locK_6AB8
		move.l	#Obj_PachinkoEnergyTrap,(Dynamic_object_RAM+(object_size*2)).w
		move.w	#$78,(Dynamic_object_RAM+(object_size*2)+x_pos).w
		move.w	#$F30,(Dynamic_object_RAM+(object_size*2)+y_pos).w
		move.w	(Saved_ring_count).w,(Ring_count).w
		move.b	(Saved_extra_life_flags).w,(Extra_life_flags).w
		move.b	#1,(Update_HUD_ring_count).w

locK_6AB8:
		cmpi.b	#$15,(Current_zone).w
		beq.w	locK_6B76
	endif
		tst.w	(Competition_mode).w
		bne.w	locK_6B94
		move.w	(Player_mode).w,d0
		bne.s	locK_6B1E
		move.l	#Obj_Sonic,(Player_1).w
		move.l	#Obj_DashDust,(Dust).w
		move.l	#Obj_InstaShield,(Shield).w
		move.w	#Player_1,(Shield+parent).w
		move.l	#Obj_Tails,(Player_2).w
		move.w	(Player_1+x_pos).w,(Player_2+x_pos).w
		move.w	(Player_1+y_pos).w,(Player_2+y_pos).w
		subi.w	#$20,(Player_2+x_pos).w
		addi.w	#4,(Player_2+y_pos).w
		move.l	#Obj_DashDust,(Dust_P2).w
		move.w	#0,(Tails_CPU_routine).w
		rts
; ---------------------------------------------------------------------------
; loc3_4FC2:
locK_6B1E:
		subq.w	#1,d0
		bne.s	locK_6B42
		move.l	#Obj_Sonic,(Player_1).w
		move.l	#Obj_DashDust,(Dust).w
		move.l	#Obj_InstaShield,(Shield).w
		move.w	#Player_1,(Shield+parent).w
		rts
; ---------------------------------------------------------------------------
; loc3_4FE6:
locK_6B42:
		subq.w	#1,d0
		bne.s	locK_6B64
		move.l	#Obj_Tails,(Player_1).w
		move.l	#Obj_DashDust,(Dust_P2).w
		addi.w	#4,(Player_1+y_pos).w
		move.w	#0,(Tails_CPU_routine).w
		rts
; ---------------------------------------------------------------------------
; loc3_5008:
locK_6B64:
	if Sonic3_Alone
		move.l	#Obj_Sonic,(Player_1).w
	else
		move.l	#Obj_Knuckles,(Player_1).w
	endif
		move.l	#Obj_DashDust,(Dust).w
		rts
; ---------------------------------------------------------------------------
	if ~~Sonic3_Alone
locK_6B76:
		moveq	#0,d0
		move.b	d0,(SStage_scalar_result_0+2).w
		move.w	d0,(SStage_scalar_result_0).w
		move.l	#Obj_Sonic_RotatingSlotBonus,(Player_1).w
		jsr	(sub_4B6AA).l
		st	(Deform_lock).w
		rts
	endif
; ---------------------------------------------------------------------------
; loc3_501A:
locK_6B94:
		move.b	(P1_character).w,d0
		bsr.s	sub_6BD8
		move.l	d1,(Player_1).w
		move.b	(P1_character).w,(Player_1+character_id).w
		move.w	(Player_1+x_pos).w,(Player_2+x_pos).w
		move.w	(Player_1+y_pos).w,(Player_2+y_pos).w
		move.l	#Obj_DashDust2P,(Dust).w
		tst.b	(Not_ghost_flag).w
		beq.s	locK_6BD6
		move.b	(P2_character).w,d0
		bsr.s	sub_6BD8
		move.l	d1,(Player_2).w
		move.b	(P2_character).w,(Player_2+character_id).w
		move.l	#Obj_DashDust2P,(Dust_P2).w
; loc3_505C:
locK_6BD6:
		bra.s	locK_6BF6
; End of function SpawnLevelMainSprites_SpawnPlayers


; =============== S U B R O U T I N E =======================================

; sub3_505E:
sub_6BD8:
		tst.b	d0
		bne.s	locK_6BE2
		move.l	#Obj_Sonic2P,d1
; loc3_5068:
locK_6BE2:
		subq.b	#1,d0
		bne.s	locK_6BEE
		move.l	#Obj_Tails2P,d1
		rts
; ---------------------------------------------------------------------------
; loc3_5074:
locK_6BEE:
		move.l	#Obj_Sonic2P,d1
		rts
; End of function sub_6BD8

; ---------------------------------------------------------------------------
; loc3_507C:
locK_6BF6:
		lea	(Target_palette_line_2).w,a2
		lea	(Pal_Level_2P).l,a1
		move.w	#bytesToWcnt($20),d0
; loc3_508A:
locK_6C04:
		move.w	(a1)+,(a2)+
		dbf	d0,locK_6C04
		rts
; ---------------------------------------------------------------------------

Pal_Level_2P:
		binclude "Levels/Misc/Palettes/2P Level Secondary.bin"
		even
; ---------------------------------------------------------------------------

Obj_ResetCollisionResponseList:
		move.w	#0,(Collision_response_list).w
		rts