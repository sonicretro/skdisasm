; ---------------------------------------------------------------------------

Obj_StarPost:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	StarPost_Index(pc,d0.w),d1
		jmp	StarPost_Index(pc,d1.w)
; ---------------------------------------------------------------------------
StarPost_Index:
		dc.w locK_2CFC0-StarPost_Index
		dc.w locK_2D012-StarPost_Index
		dc.w locK_2D0F8-StarPost_Index
		dc.w locK_2D10A-StarPost_Index
		dc.w locK_2D47E-StarPost_Index
; ---------------------------------------------------------------------------
; loc3_2C436:
locK_2CFC0:
		addq.b	#2,routine(a0)
		move.l	#Map_StarPost,mappings(a0)
		move.w	#make_art_tile(ArtTile_StarPost+8,0,0),art_tile(a0)
		move.b	#4,render_flags(a0)
		move.b	#8,width_pixels(a0)
		move.b	#$28,height_pixels(a0)
		move.w	#$280,priority(a0)
		movea.w	respawn_addr(a0),a2
		btst	#0,(a2)
		bne.s	locK_2D008
		move.b	(Last_star_post_hit).w,d1
		andi.b	#$7F,d1
		move.b	subtype(a0),d2
		andi.b	#$7F,d2
		cmp.b	d2,d1
		blo.s	locK_2D012
; loc3_2C47E:
locK_2D008:
		bset	#0,(a2)
		move.b	#2,anim(a0)
; loc3_2C488:
locK_2D012:
		tst.w	(Debug_placement_mode).w
		bne.w	locK_2D0F8
		lea	(Player_1).w,a3
		move.b	(Last_star_post_hit).w,d1
		bsr.s	subK_2D028
		bra.w	locK_2D0F8

; =============== S U B R O U T I N E =======================================

; sub3_2C49E:
subK_2D028:
		andi.b	#$7F,d1
		move.b	subtype(a0),d2
		andi.b	#$7F,d2
		cmp.b	d2,d1
		bhs.w	locK_2D0EA
		move.w	x_pos(a3),d0
		sub.w	x_pos(a0),d0
		addi.w	#8,d0
		cmpi.w	#$10,d0
		bhs.w	locretK_2D0E8
		move.w	y_pos(a3),d0
		sub.w	y_pos(a0),d0
		addi.w	#$40,d0
		cmpi.w	#$68,d0
		bhs.w	locretK_2D0E8
		moveq	#signextendB(sfx_Starpost),d0
		jsr	(Play_SFX).l
		jsr	(AllocateObject).l
		bne.s	locK_2D0D0
		move.l	#Obj_StarPost,(a1)
		move.b	#6,routine(a1)
		move.w	x_pos(a0),$30(a1)
		move.w	y_pos(a0),$32(a1)
		subi.w	#$14,$32(a1)
		move.l	mappings(a0),mappings(a1)
		move.w	art_tile(a0),art_tile(a1)
		move.b	#4,render_flags(a1)
		move.b	#8,width_pixels(a1)
		move.b	#8,height_pixels(a1)
		move.w	#$200,priority(a1)
		move.b	#2,mapping_frame(a1)
		move.w	#$20,$36(a1)
		move.w	a0,$3E(a1)
	if Sonic3_Alone
		cmpi.w	#50,(Ring_count).w
	else
		cmpi.w	#20,(Ring_count).w
	endif
		blo.s	locK_2D0D0
		bsr.w	subK_2D3C8
; loc3_2C546:
locK_2D0D0:
		move.b	#1,anim(a0)
		bsr.w	subK_2D164
		move.b	#4,routine(a0)
		movea.w	respawn_addr(a0),a2
		bset	#0,(a2)
; locret3_2C55E:
locretK_2D0E8:
		rts
; ---------------------------------------------------------------------------
; loc3_2C560:
locK_2D0EA:
		tst.b	anim(a0)
		bne.s	locretK_2D0F6
		move.b	#2,anim(a0)
; locret3_2C56C:
locretK_2D0F6:
		rts
; End of function subK_2D028

; ---------------------------------------------------------------------------
; loc3_2C56E:
locK_2D0F8:
		lea	(Ani_Starpost).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
; loc3_2C580:
locK_2D10A:
		subq.w	#1,$36(a0)
		bpl.s	locK_2D12E
		movea.w	$3E(a0),a1
		cmpi.l	#Obj_StarPost,(a1)
		bne.s	locK_2D128
		move.b	#2,anim(a1)
		move.b	#0,mapping_frame(a1)
; loc3_2C59E:
locK_2D128:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
; loc3_2C5A4:
locK_2D12E:
		move.b	angle(a0),d0
		subi.b	#$10,angle(a0)
		subi.b	#$40,d0
		jsr	(GetSineCosine).l
		muls.w	#$C00,d1
		swap	d1
		add.w	$30(a0),d1
		move.w	d1,x_pos(a0)
		muls.w	#$C00,d0
		swap	d0
		add.w	$32(a0),d0
		move.w	d0,y_pos(a0)
		jmp	(Sprite_OnScreen_Test).l

; =============== S U B R O U T I N E =======================================

; sub3_2C5DA:
subK_2D164:
		move.b	subtype(a0),(Last_star_post_hit).w
		move.w	x_pos(a0),(Saved_X_pos).w
		move.w	y_pos(a0),(Saved_Y_pos).w
; End of function subK_2D164


; =============== S U B R O U T I N E =======================================


Save_Level_Data:
		move.b	(Last_star_post_hit).w,(Saved_last_star_post_hit).w
		move.w	(Current_zone_and_act).w,(Saved_zone_and_act).w
		move.w	(Apparent_zone_and_act).w,(Saved_apparent_zone_and_act).w
		move.w	(Player_1+art_tile).w,(Saved_art_tile).w
		move.w	(Player_1+top_solid_bit).w,(Saved_solid_bits).w
		move.w	(Ring_count).w,(Saved_ring_count).w
		move.b	(Extra_life_flags).w,(Saved_extra_life_flags).w
		move.l	(Timer).w,(Saved_timer).w
		move.b	(Dynamic_resize_routine).w,(Saved_dynamic_resize_routine).w
		move.w	(Camera_max_Y_pos).w,(Saved_camera_max_Y_pos).w
		move.w	(Camera_X_pos).w,(Saved_camera_X_pos).w
		move.w	(Camera_Y_pos).w,(Saved_camera_Y_pos).w
		move.w	(Mean_water_level).w,(Saved_mean_water_level).w
		move.b	(Water_full_screen_flag).w,(Saved_water_full_screen_flag).w
		rts
; End of function Save_Level_Data


; =============== S U B R O U T I N E =======================================


Save_Level_Data2:
		move.b	(Last_star_post_hit).w,(Saved2_last_star_post_hit).w
		move.w	(Current_zone_and_act).w,(Saved2_zone_and_act).w
		move.w	(Apparent_zone_and_act).w,(Saved2_apparent_zone_and_act).w
		move.w	x_pos(a0),(Saved2_X_pos).w
		move.w	y_pos(a0),(Saved2_Y_pos).w
		move.w	(Player_1+art_tile).w,(Saved2_art_tile).w
		move.w	(Player_1+top_solid_bit).w,(Saved2_solid_bits).w
		move.w	(Ring_count).w,(Saved2_ring_count).w
		move.b	(Extra_life_flags).w,(Saved2_extra_life_flags).w
		move.l	(Timer).w,(Saved2_timer).w
		move.b	(Dynamic_resize_routine).w,(Saved2_dynamic_resize_routine).w
		move.w	(Camera_max_Y_pos).w,(Saved2_camera_max_Y_pos).w
		move.w	(Camera_X_pos).w,(Saved2_camera_X_pos).w
		move.w	(Camera_Y_pos).w,(Saved2_camera_Y_pos).w
		move.w	(Mean_water_level).w,(Saved2_mean_water_level).w
		move.b	(Water_full_screen_flag).w,(Saved2_water_full_screen_flag).w
		move.b	(Player_1+status_secondary).w,(Saved2_status_secondary).w
		rts
; End of function Save_Level_Data2


; =============== S U B R O U T I N E =======================================


Load_Starpost_Settings:
		tst.b	(Special_bonus_entry_flag).w
		bne.w	locK_2D2C2
		move.b	(Saved_last_star_post_hit).w,(Last_star_post_hit).w
		move.w	(Saved_zone_and_act).w,(Current_zone_and_act).w
		move.w	(Saved_apparent_zone_and_act).w,(Apparent_zone_and_act).w
		move.w	(Saved_X_pos).w,(Player_1+x_pos).w
		move.w	(Saved_Y_pos).w,(Player_1+y_pos).w
		move.w	(Saved_ring_count).w,(Ring_count).w
		move.b	(Saved_extra_life_flags).w,(Extra_life_flags).w
		tst.b	(Respawn_table_keep).w
		bne.s	locK_2D274
		clr.w	(Ring_count).w
		clr.b	(Extra_life_flags).w
; loc3_2C6EA:
locK_2D274:
		move.l	(Saved_timer).w,(Timer).w
		move.b	#60-1,(Timer_frame).w
		subq.b	#1,(Timer_second).w
		move.w	(Saved_art_tile).w,(Player_1+art_tile).w
		move.w	(Saved_solid_bits).w,(Player_1+top_solid_bit).w
		move.b	(Saved_dynamic_resize_routine).w,(Dynamic_resize_routine).w
		move.w	(Saved_camera_max_Y_pos).w,(Camera_max_Y_pos).w
		move.w	(Saved_camera_max_Y_pos).w,(Camera_target_max_Y_pos).w
		move.w	(Saved_camera_X_pos).w,(Camera_X_pos).w
		move.w	(Saved_camera_Y_pos).w,(Camera_Y_pos).w
		tst.b	(Water_flag).w
		beq.s	locretK_2D2C0
		move.w	(Saved_mean_water_level).w,(Mean_water_level).w
		move.b	(Saved_water_full_screen_flag).w,(Water_full_screen_flag).w
; locret3_2C736:
locretK_2D2C0:
		rts
; ---------------------------------------------------------------------------
; loc3_2C738:
locK_2D2C2:
		clr.b	(Special_bonus_entry_flag).w
		move.w	(Saved2_zone_and_act).w,(Current_zone_and_act).w
		move.w	(Saved2_apparent_zone_and_act).w,(Apparent_zone_and_act).w
		move.w	(Saved2_X_pos).w,(Player_1+x_pos).w
		move.w	(Saved2_Y_pos).w,(Player_1+y_pos).w
		move.w	(Saved2_ring_count).w,(Ring_count).w
		move.b	(Saved2_extra_life_flags).w,(Extra_life_flags).w
		move.l	(Saved2_timer).w,(Timer).w
		move.b	#60-1,(Timer_frame).w
		subq.b	#1,(Timer_second).w
		move.w	(Saved2_art_tile).w,(Player_1+art_tile).w
		move.w	(Saved2_solid_bits).w,(Player_1+top_solid_bit).w
		move.b	(Saved2_dynamic_resize_routine).w,(Dynamic_resize_routine).w
		move.w	(Saved2_camera_max_Y_pos).w,(Camera_max_Y_pos).w
		move.w	(Saved2_camera_max_Y_pos).w,(Camera_target_max_Y_pos).w
		move.w	(Saved2_camera_X_pos).w,(Camera_X_pos).w
		move.w	(Saved2_camera_Y_pos).w,(Camera_Y_pos).w
		tst.b	(Water_flag).w
		beq.s	locretK_2D336
		move.w	(Saved2_mean_water_level).w,(Mean_water_level).w
		move.b	(Saved2_water_full_screen_flag).w,(Water_full_screen_flag).w
; locret3_2C7AC:
locretK_2D336:
		rts
; End of function Load_Starpost_Settings

; ---------------------------------------------------------------------------
Ani_Starpost:
		include "General/Sprites/Starpost/Anim - Starpost.asm"
Map_StarPost:
		include "General/Sprites/Starpost/Map - Starpost.asm"
Map_StarpostStars:
		include "General/Sprites/Starpost/Map - Starpost Stars.asm"

; =============== S U B R O U T I N E =======================================


subK_2D3C8:
		moveq	#4-1,d1
		moveq	#0,d2

locK_2D3CC:
		jsr	(AllocateObject).l
	if Sonic3_Alone
		bne.s	locret3_2C8AC
	else
		bne.s	locK_2D436
	endif
		move.l	(a0),(a1)
		move.l	#Map_StarpostStars,mappings(a1)
		move.w	#make_art_tile(ArtTile_StarPost+8,0,0),art_tile(a1)
		move.b	#4,render_flags(a1)
		move.b	#8,routine(a1)
		move.w	x_pos(a0),d0
		move.w	d0,x_pos(a1)
		move.w	d0,$30(a1)
		move.w	y_pos(a0),d0
		subi.w	#$30,d0
		move.w	d0,y_pos(a1)
		move.w	d0,$32(a1)
		move.w	priority(a0),priority(a1)
		move.b	#8,width_pixels(a1)
		move.b	#1,mapping_frame(a1)
		move.w	#-$400,x_vel(a1)
		move.w	#0,y_vel(a1)
		move.w	d2,$34(a1)
		addi.w	#$40,d2
		dbf	d1,locK_2D3CC

	if Sonic3_Alone
locret3_2C8AC:
		rts
	else
locK_2D436:
		lea	(ArtKosM_StarPostStars3).l,a1
		move.w	(Ring_count).w,d0
		subi.w	#20,d0
		divu.w	#15,d0
		ext.l	d0
		moveq	#2,d2
		tst.w	(SK_alone_flag).w
		bne.s	locK_2D454
		moveq	#3,d2

locK_2D454:
		divu.w	d2,d0
		swap	d0
		tst.w	d0
		beq.s	locK_2D474
		lea	(ArtKosM_StarPost_Stars1).l,a1
		cmpi.w	#1,d0
		beq.s	locK_2D474
		tst.w	(SK_alone_flag).w
		bne.s	locK_2D474
		lea	(ArtKosM_StarPostStars2).l,a1

locK_2D474:
		move.w	#tiles_to_bytes(ArtTile_StarPost+8),d2
		jmp	(Queue_Kos_Module).l
	endif
; End of function subK_2D3C8

; ---------------------------------------------------------------------------
; loc3_2C8AE:
locK_2D47E:
		move.b	collision_property(a0),d0
		beq.w	locK_2D50A
		andi.b	#1,d0
		beq.s	locK_2D506
		move.b	#2,(Special_bonus_entry_flag).w
	if Sonic3_Alone
		move.w	#$1300,(Current_zone_and_act).w
		move.w	#$1300,(Apparent_zone_and_act).w
	else
		move.w	#$1500,d1
		move.w	(Saved_ring_count).w,d0
		subi.w	#20,d0
		divu.w	#15,d0
		ext.l	d0
		moveq	#2,d2
		tst.w	(SK_alone_flag).w
		bne.s	locK_2D4AE
		moveq	#3,d2

locK_2D4AE:
		divu.w	d2,d0
		swap	d0
		tst.w	d0
		beq.s	locK_2D4CA
		move.w	#$1400,d1
		cmpi.w	#1,d0
		beq.s	locK_2D4CA
		tst.w	(SK_alone_flag).w
		bne.s	locK_2D4CA
		move.w	#$1300,d1

locK_2D4CA:
		move.w	d1,(Current_zone_and_act).w
		move.w	d1,(Apparent_zone_and_act).w
		move.w	(Ring_count).w,(Saved_ring_count).w
		move.b	(Extra_life_flags).w,(Saved_extra_life_flags).w
	endif
		move.b	#0,(Last_star_post_hit).w
		move.b	#1,(Restart_level_flag).w
	if Sonic3_Alone
		move.b	(Player_1+status_secondary).w,(Saved2_status_secondary).w
	else
		move.b	(Player_1+status_secondary).w,d0
		andi.b	#$71,d0
		move.b	d0,(Saved2_status_secondary).w
		move.b	d0,(Saved_status_secondary).w
	endif
		move.b	#1,(Respawn_table_keep).w
		jsr	(Clear_SpriteRingMem).l
; loc3_2C8EC:
locK_2D506:
		clr.b	collision_property(a0)
; loc3_2C8F0:
locK_2D50A:
		addi.w	#$A,$34(a0)
		move.w	$34(a0),d0
		andi.w	#$FF,d0
		jsr	(GetSineCosine).l
		asr.w	#5,d0
		asr.w	#3,d1
		move.w	d1,d3
		move.w	$34(a0),d2
		andi.w	#$3E0,d2
		lsr.w	#5,d2
		moveq	#2,d5
		moveq	#0,d4
		cmpi.w	#$10,d2
		ble.s	locK_2D53A
		neg.w	d1
; loc3_2C920:
locK_2D53A:
		andi.w	#$F,d2
		cmpi.w	#8,d2
		ble.s	locK_2D54A
		neg.w	d2
		andi.w	#7,d2
; loc3_2C930:
locK_2D54A:
		lsr.w	#1,d2
		beq.s	locK_2D550
		add.w	d1,d4
; loc3_2C936:
locK_2D550:
		asl.w	#1,d1
		dbf	d5,locK_2D54A
		asr.w	#4,d4
		add.w	d4,d0
		addq.w	#1,$36(a0)
		move.w	$36(a0),d1
		cmpi.w	#$80,d1
		beq.s	locK_2D574
		bgt.s	locK_2D57A
; loc3_2C950:
locK_2D56A:
		muls.w	d1,d0
		muls.w	d1,d3
		asr.w	#7,d0
		asr.w	#7,d3
		bra.s	locK_2D58C
; ---------------------------------------------------------------------------
; loc3_2C95A:
locK_2D574:
		move.b	#$D8,collision_flags(a0)
; loc3_2C960:
locK_2D57A:
		cmpi.w	#$180,d1
		ble.s	locK_2D58C
		neg.w	d1
		addi.w	#$200,d1
		bmi.w	locK_2D5C0
		bra.s	locK_2D56A
; ---------------------------------------------------------------------------
; loc3_2C972:
locK_2D58C:
		move.w	$30(a0),d2
		add.w	d3,d2
		move.w	d2,x_pos(a0)
		move.w	$32(a0),d2
		add.w	d0,d2
		move.w	d2,y_pos(a0)
		addq.b	#1,anim_frame(a0)
		move.b	anim_frame(a0),d0
		andi.w	#6,d0
		lsr.w	#1,d0
		cmpi.b	#3,d0
		bne.s	locK_2D5B6
		moveq	#1,d0
; loc3_2C99C:
locK_2D5B6:
		move.b	d0,mapping_frame(a0)
		jmp	(Sprite_CheckDeleteTouch3).l
; ---------------------------------------------------------------------------
; loc3_2C9A6:
locK_2D5C0:
		jmp	(Delete_Current_Sprite).l