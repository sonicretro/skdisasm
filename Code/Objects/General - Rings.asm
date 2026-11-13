; ---------------------------------------------------------------------------

Obj_Ring:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Ring_Index(pc,d0.w),d1
		jmp	Ring_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Ring_Index:
		dc.w Obj_RingInit-Ring_Index
		dc.w Obj_RingAnimate-Ring_Index
		dc.w Obj_RingCollect-Ring_Index
		dc.w Obj_RingSparkle-Ring_Index
		dc.w Obj_RingDelete-Ring_Index
; ---------------------------------------------------------------------------

Obj_RingInit:
		addq.b	#2,routine(a0)
		move.l	#Map_Ring,mappings(a0)
		move.w	#make_art_tile(ArtTile_Ring,1,1),art_tile(a0)
		move.b	#4,render_flags(a0)
		move.w	#$100,priority(a0)
		move.b	#$47,collision_flags(a0)
		move.b	#8,width_pixels(a0)
		tst.w	(Competition_mode).w
		beq.s	Obj_RingAnimate
		move.w	#make_art_tile(ArtTile_2PArt_3+$C,3,0),art_tile(a0)

Obj_RingAnimate:
		move.b	(Rings_frame).w,mapping_frame(a0)
		bra.w	Sprite_CheckDeleteTouch3
; ---------------------------------------------------------------------------

Obj_RingCollect:
		addq.b	#2,routine(a0)
		move.b	#0,collision_flags(a0)
		move.w	#$80,priority(a0)
		bsr.s	GiveRing

Obj_RingSparkle:
		lea	(Ani_RingSparkle).l,a1
		bsr.w	Animate_Sprite
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------

Obj_RingDelete:
		bra.w	Delete_Current_Sprite

; =============== S U B R O U T I N E =======================================


GiveRing:
		cmpi.w	#999,(Total_ring_count).w	; did Sonic collect 999 or more rings?
		bhs.s	GiveRing_1P			; if yes, branch
		addq.w	#1,(Total_ring_count).w		; add 1 to the number of collected rings

GiveRing_1P:
		move.w	#sfx_RingRight,d0		; prepare to play the ring sound
		cmpi.w	#999,(Ring_count).w		; does the player 1 have 999 or more rings?
		bhs.s	JmpTo_Play_SFX			; if yes, play the ring sound
		addq.w	#1,(Ring_count).w		; add 1 to the ring count
		ori.b	#1,(Update_HUD_ring_count).w	; set flag to update the ring counter in the HUD
		cmpi.w	#100,(Ring_count).w		; does the player 1 have less than 100 rings?
		blo.s	JmpTo_Play_SFX			; if yes, play the ring sound
		bset	#1,(Extra_life_flags).w		; test and set the flag for the first extra life
		beq.s	locK_1A5D8			; if it was clear before, branch
		cmpi.w	#200,(Ring_count).w		; does the player 1 have less than 200 rings?
		blo.s	JmpTo_Play_SFX			; if yes, play the ring sound
		bset	#2,(Extra_life_flags).w		; test and set the flag for the second extra life
		bne.s	JmpTo_Play_SFX			; if it was set before, play the ring sound

locK_1A5D8:
		addq.b	#1,(Life_count).w		; add 1 to the life count
		addq.b	#1,(Update_HUD_life_count).w	; add 1 to the displayed life count
		moveq	#signextendB(mus_ExtraLife),d0	; prepare to play the extra life jingle
		jmp	(Play_Music).l			; Sonic 2 wound up putting music in the stereo sound queue, this would have fixed it
; ---------------------------------------------------------------------------

JmpTo_Play_SFX:
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------
		; unused
		rts
; ---------------------------------------------------------------------------

GiveRing_Tails:
		cmpi.w	#999,(Total_ring_count_P2).w
		bhs.s	locK_1A5FC
		addq.w	#1,(Total_ring_count_P2).w

locK_1A5FC:
		cmpi.w	#999,(Ring_count_P2).w
		bhs.s	locK_1A608
		addq.w	#1,(Ring_count_P2).w

locK_1A608:
		tst.w	(Competition_mode).w
		beq.s	GiveRing_1P
		ori.b	#1,(_unkFEBE).w
		move.w	#sfx_RingRight,d0
		cmpi.w	#100,(Ring_count_P2).w
		blo.s	locK_1A644
		bset	#1,(Extra_life_flags_P2).w
		beq.s	locK_1A638
		cmpi.w	#200,(Ring_count_P2).w
		blo.s	locK_1A644
		bset	#2,(Extra_life_flags_P2).w
		bne.s	locK_1A644

locK_1A638:
		addq.b	#1,(Life_count_P2).w
		moveq	#signextendB(mus_ExtraLife),d0
		jmp	(Play_Music).l
; ---------------------------------------------------------------------------

locK_1A644:
		jmp	(Play_SFX).l
; End of function GiveRing

; ---------------------------------------------------------------------------

Obj_Bouncing_Ring:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Bouncing_Ring_Index(pc,d0.w),d1
		jmp	Bouncing_Ring_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Bouncing_Ring_Index:
		dc.w locK_1A67A-Bouncing_Ring_Index
		dc.w locK_1A75C-Bouncing_Ring_Index
		dc.w locK_1A7C2-Bouncing_Ring_Index
		dc.w locK_1A7D6-Bouncing_Ring_Index
		dc.w locK_1A7E4-Bouncing_Ring_Index

	if ~~Sonic3_Alone
; ---------------------------------------------------------------------------

Obj_Bouncing_Ring_Reverse_Gravity:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Bouncing_Ring_Reverse_Gravity_Index(pc,d0.w),d1
		jmp	Bouncing_Ring_Reverse_Gravity_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Bouncing_Ring_Reverse_Gravity_Index:
		dc.w locK_1A67A-Bouncing_Ring_Reverse_Gravity_Index
		dc.w locK_1A7E8-Bouncing_Ring_Reverse_Gravity_Index
		dc.w locK_1A7C2-Bouncing_Ring_Reverse_Gravity_Index
		dc.w locK_1A7D6-Bouncing_Ring_Reverse_Gravity_Index
		dc.w locK_1A7E4-Bouncing_Ring_Reverse_Gravity_Index
	endif
; ---------------------------------------------------------------------------
; loc3_18E3E:
locK_1A67A:
	if ~~Sonic3_Alone
		move.l	#Obj_Bouncing_Ring,d6
		tst.b	(Reverse_gravity_flag).w
		beq.s	locK_1A68C
		move.l	#Obj_Bouncing_Ring_Reverse_Gravity,d6

locK_1A68C:
	endif
		movea.l	a0,a1
		moveq	#0,d5
		move.w	(Ring_count).w,d5
		tst.b	$3F(a0)
		beq.s	locK_1A69E
		move.w	(Ring_count_P2).w,d5
; loc3_18E50:
locK_1A69E:
		moveq	#$20,d0
		cmp.w	d0,d5
		blo.s	locK_1A6A6
		move.w	d0,d5
; loc3_18E58:
locK_1A6A6:
		subq.w	#1,d5
		move.w	#$288,d4
		bra.s	locK_1A6B6
; ---------------------------------------------------------------------------
; loc3_18E60:
locK_1A6AE:
		bsr.w	AllocateObjectAfterCurrent
		bne.w	locK_1A738
; loc3_18E68:
locK_1A6B6:
	if Sonic3_Alone
		move.l	#Obj_Bouncing_Ring,(a1)
	else
		move.l	d6,(a1)
	endif
		addq.b	#2,routine(a1)
		move.b	#8,y_radius(a1)
		move.b	#8,x_radius(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.l	#Map_Ring,mappings(a1)
		move.w	#make_art_tile(ArtTile_Ring,1,1),art_tile(a1)
		move.b	#$84,render_flags(a1)
		move.w	#$180,priority(a1)
		move.b	#$47,collision_flags(a1)
		move.b	#8,width_pixels(a1)
		move.b	#-1,(Ring_spill_anim_counter).w
		tst.w	d4
		bmi.s	locK_1A728
		move.w	d4,d0
		jsr	(GetSineCosine).l
		move.w	d4,d2
		lsr.w	#8,d2
		asl.w	d2,d0
		asl.w	d2,d1
		move.w	d0,d2
		move.w	d1,d3
		addi.b	#$10,d4
		bcc.s	locK_1A728
		subi.w	#$80,d4
		bcc.s	locK_1A728
		move.w	#$288,d4
; loc3_18EDE:
locK_1A728:
		move.w	d2,x_vel(a1)
		move.w	d3,y_vel(a1)
		neg.w	d2
		neg.w	d4
		dbf	d5,locK_1A6AE
; loc3_18EEE:
locK_1A738:
		move.w	#signextendB(sfx_RingLoss),d0
		jsr	(Play_SFX).l
		move.w	#0,(Ring_count).w
		move.b	#$80,(Update_HUD_ring_count).w
		move.b	#0,(Extra_life_flags).w
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		bne.w	locK_1A7E8
	endif
; loc3_18F0A:
locK_1A75C:
		move.b	(Ring_spill_anim_frame).w,mapping_frame(a0)
		bsr.w	MoveSprite2
		addi.w	#$18,y_vel(a0)
	if Sonic3_Alone
		bmi.s	locK_1A79C
	else
		bmi.s	locK_1A7B0
	endif
		move.b	(V_int_run_count+3).w,d0
		add.b	d7,d0
		andi.b	#7,d0
	if Sonic3_Alone
		bne.s	locK_1A79C
	else
		bne.s	locK_1A7B0
	endif
		tst.b	render_flags(a0)
		bpl.s	locK_1A79C
		jsr	(RingCheckFloorDist).l
		tst.w	d1
		bpl.s	locK_1A79C
		add.w	d1,y_pos(a0)
		move.w	y_vel(a0),d0
		asr.w	#2,d0
		sub.w	d0,y_vel(a0)
		neg.w	y_vel(a0)
; loc3_18F4A:
locK_1A79C:
		tst.b	(Ring_spill_anim_counter).w
		beq.s	locK_1A7E4
		move.w	(Camera_max_Y_pos).w,d0
		addi.w	#$E0,d0
		cmp.w	y_pos(a0),d0
		blo.s	locK_1A7E4

locK_1A7B0:
	if Sonic3_Alone
		bsr.w	Add_SpriteToCollisionResponseList
	else
		jsr	(Add_SpriteToCollisionResponseList).l
	endif
		move.w	(Level_repeat_offset).w,d0
		sub.w	d0,x_pos(a0)
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------
; loc3_18F6E:
locK_1A7C2:
		addq.b	#2,routine(a0)
		move.b	#0,collision_flags(a0)
		move.w	#$80,priority(a0)
		bsr.w	GiveRing
; loc3_18F82:
locK_1A7D6:
		lea	(Ani_RingSparkle).l,a1
		bsr.w	Animate_Sprite
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------
; loc3_18F90:
locK_1A7E4:
		bra.w	Delete_Current_Sprite

	if ~~Sonic3_Alone
; ---------------------------------------------------------------------------

locK_1A7E8:
		move.b	(Ring_spill_anim_frame).w,mapping_frame(a0)
		bsr.w	MoveSprite_TestGravity2
		addi.w	#$18,y_vel(a0)
		bmi.s	locK_1A83C
		move.b	(V_int_run_count+3).w,d0
		add.b	d7,d0
		andi.b	#7,d0
		bne.s	locK_1A83C
		tst.b	render_flags(a0)
		bpl.s	locK_1A828
		jsr	(RingCheckFloorDist_ReverseGravity).l
		tst.w	d1
		bpl.s	locK_1A828
		sub.w	d1,y_pos(a0)
		move.w	y_vel(a0),d0
		asr.w	#2,d0
		sub.w	d0,y_vel(a0)
		neg.w	y_vel(a0)

locK_1A828:
		tst.b	(Ring_spill_anim_counter).w
		beq.s	locK_1A7E4
		move.w	(Camera_max_Y_pos).w,d0
		addi.w	#$E0,d0
		cmp.w	y_pos(a0),d0
		blo.s	locK_1A7E4

locK_1A83C:
		jsr	(Add_SpriteToCollisionResponseList).l
		move.w	(Level_repeat_offset).w,d0
		sub.w	d0,x_pos(a0)
		bra.w	Draw_Sprite
	endif
; ---------------------------------------------------------------------------

Obj_Attracted_Ring:
		; init
		move.l	#Map_Ring,mappings(a0)
		move.w	#make_art_tile(ArtTile_Ring,1,1),art_tile(a0)
		move.b	#4,render_flags(a0)
		move.w	#$100,priority(a0)
		move.b	#$47,collision_flags(a0)
		move.b	#8,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		move.b	#8,y_radius(a0)
		move.b	#8,x_radius(a0)
		move.l	#locK_1A88C,(a0)
; loc3_18FD2:
locK_1A88C:
		tst.b	routine(a0)
		bne.s	AttractedRing_GiveRing
		bsr.w	AttractedRing_Move
		btst	#Status_LtngShield,(Player_1+status_secondary).w	; Does player still have a lightning shield?
		bne.s	Obj_Attracted_RingAnimate
		move.l	#Obj_Bouncing_Ring,(a0)		; If not, change object
		move.b	#2,routine(a0)
		move.b	#-1,(Ring_spill_anim_counter).w

Obj_Attracted_RingAnimate:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locK_1A8C6
		move.b	#3,anim_frame_timer(a0)
		addq.b	#1,mapping_frame(a0)
		andi.b	#3,mapping_frame(a0)
; loc3_1900C:
locK_1A8C6:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	locK_1A8E4
	if Sonic3_Alone
		bsr.w	Add_SpriteToCollisionResponseList
	else
		jsr	(Add_SpriteToCollisionResponseList).l
	endif
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------
; loc3_19028:
locK_1A8E4:
		move.w	respawn_addr(a0),d0
		beq.s	locK_1A8F0
		movea.w	d0,a2
		bclr	#7,(a2)
; loc3_19034:
locK_1A8F0:
	if FixBugs
		move.w	$30(a0),d0
	else
		; Bug: Probably meant to be $30(a0), as Test_Ring_Collisions_AttractRing
		; stores the ring's address in the ring status table there.
		; This is corrected in Sonic & Knuckles Collection.
		move.w	$30,d0
	endif
		beq.s	locK_1A8FC
		movea.w	d0,a2
		move.w	#0,(a2)
; loc3_19040:
locK_1A8FC:
		bra.w	Delete_Current_Sprite
; ---------------------------------------------------------------------------

AttractedRing_GiveRing:
		move.b	#0,collision_flags(a0)
		move.w	#$80,priority(a0)
		subq.w	#1,(Perfect_rings_left).w
		bsr.w	GiveRing
		move.l	#locK_1A920,(a0)
		move.b	#0,routine(a0)
; loc3_19064:
locK_1A920:
		tst.b	routine(a0)
		bne.s	locK_1A934
		lea	(Ani_RingSparkle).l,a1
		bsr.w	Animate_Sprite
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------
; loc3_19078:
locK_1A934:
		bra.w	Delete_Current_Sprite

; =============== S U B R O U T I N E =======================================


AttractedRing_Move:
		; Move on X axis
		move.w	#$30,d1
		move.w	(Player_1+x_pos).w,d0
		cmp.w	x_pos(a0),d0
		bhs.s	AttractedRing_MoveRight	; If ring is to the left of the player, branch

		neg.w	d1
		tst.w	x_vel(a0)
		bmi.s	AttractedRing_ApplyMovementX
		add.w	d1,d1
		add.w	d1,d1
		bra.s	AttractedRing_ApplyMovementX
; ---------------------------------------------------------------------------

AttractedRing_MoveRight:
		tst.w	x_vel(a0)
		bpl.s	AttractedRing_ApplyMovementX
		add.w	d1,d1
		add.w	d1,d1

AttractedRing_ApplyMovementX:
		add.w	d1,x_vel(a0)
		; Move on Y axis
		move.w	#$30,d1
		move.w	(Player_1+y_pos).w,d0
		cmp.w	y_pos(a0),d0
		bhs.s	AttractedRing_MoveUp	; If ring is below the player, branch

		neg.w	d1
		tst.w	y_vel(a0)
		bmi.s	AttractedRing_ApplyMovementY
		add.w	d1,d1
		add.w	d1,d1
		bra.s	AttractedRing_ApplyMovementY
; ---------------------------------------------------------------------------

AttractedRing_MoveUp:
		tst.w	y_vel(a0)
		bpl.s	AttractedRing_ApplyMovementY
		add.w	d1,d1
		add.w	d1,d1

AttractedRing_ApplyMovementY:
		add.w	d1,y_vel(a0)
		jmp	(MoveSprite2).l
; End of function AttractedRing_Move

; ---------------------------------------------------------------------------
Ani_RingSparkle:
		include "General/Sprites/Ring/Anim - Ring Sparkle.asm"
Map_Ring:
		include "General/Sprites/Ring/Map - Ring.asm"

	if ~~Sonic3_Alone
; ---------------------------------------------------------------------------

Obj_SlotRing:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	SlotRing_Index(pc,d0.w),d1
		jmp	SlotRing_Index(pc,d1.w)
; ---------------------------------------------------------------------------
SlotRing_Index:
		dc.w locK_1AA02-SlotRing_Index
		dc.w locK_1AA56-SlotRing_Index
		dc.w locK_1AA62-SlotRing_Index
; ---------------------------------------------------------------------------

locK_1AA02:
		moveq	#0,d1
		move.w	$3C(a0),d1
		swap	d1
		move.l	$34(a0),d0
		sub.l	d1,d0
		asr.l	#4,d0
		sub.l	d0,$34(a0)
		move.w	$34(a0),x_pos(a0)
		moveq	#0,d1
		move.w	$3E(a0),d1
		swap	d1
		move.l	$38(a0),d0
		sub.l	d1,d0
		asr.l	#4,d0
		sub.l	d0,$38(a0)
		move.w	$38(a0),y_pos(a0)
		lea	Ani_Ring(pc),a1
		bsr.w	Animate_Sprite
		subq.w	#1,$40(a0)
		bne.w	Draw_Sprite
		movea.l	$2E(a0),a1
		subq.w	#1,(a1)
		bsr.w	GiveRing
		addi.b	#2,routine(a0)

locK_1AA56:
		lea	Ani_RingSparkle(pc),a1
		bsr.w	Animate_Sprite
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------

locK_1AA62:
		bra.w	Delete_Current_Sprite
; ---------------------------------------------------------------------------
Ani_Ring:
		include "General/Sprites/Ring/Anim - Ring.asm"
	endif