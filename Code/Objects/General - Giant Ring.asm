; ---------------------------------------------------------------------------

Obj_SSEntryRing:
		move.b	subtype(a0),d0
		move.l	(Collected_special_ring_array).w,d1
		btst	d0,d1
		beq.s	locK_6167C				; only make the ring if it hasn't already been collected
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
; loc3_44248:
locK_6167C:
		jsr	(Obj_WaitOffscreen).l			; Don't start anything until the ring is explicitly onscreen
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	SSEntryRing_Index(pc,d0.w),d1
		jsr	SSEntryRing_Index(pc,d1.w)
		bra.w	SSEntryRing_Display
; ---------------------------------------------------------------------------

SSEntryRing_Index:
		dc.w SSEntryRing_Init-SSEntryRing_Index
		dc.w SSEntryRing_Main-SSEntryRing_Index
		dc.w SSEntryRing_Animate-SSEntryRing_Index
; ---------------------------------------------------------------------------

SSEntryRing_Init:
		lea	ObjSlot_SSEntryRing(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l		; Only one special stage ring can be loaded at one time, period
		move.l	#AniRaw_SSEntryRing,$30(a0)
	if ~~Sonic3_Alone
		tst.b	subtype(a0)
		bmi.s	locK_616C6			; If negative, then ALWAYS make this a Super Emerald ring
		tst.w	(SK_alone_flag).w		; Probably only used in MHZ for the first rings
		bne.s	SSEntryRing_Main			; If only Sonic & Knuckles, skip ahead
		bsr.w	SSEntry_CheckLevel
		beq.s	SSEntryRing_Main			; If in an S3 level, skip ahead since it's a normal ring
		cmpi.b	#7,(Chaos_emerald_count).w
		bne.s	SSEntryRing_Main			; Only make this a Super Emerald ring if you actually have 7 Chaos Emeralds

locK_616C6:
		bset	#6,$38(a0)				; Make this a Super Emerald ring
		lea	(PalSPtr_SSEntry).l,a1
		lea	(Palette_rotation_data).w,a2
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		lea	(PalSPtr_SSEntry2).l,a1
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		clr.w	(a2)					; Set up the palette script pointers
	endif

SSEntryRing_Main:
		jsr	(Animate_Raw).l
		tst.w	(Debug_placement_mode).w
		bne.s	locretK_61708		; If in debug mode, don't allow collision
		cmpi.b	#8,mapping_frame(a0)
		blo.s	locretK_61708		; If ring hasn't finished forming, don't allow collision
		lea	SSEntry_Range(pc),a1
		jsr	(Check_PlayerInRange).l
		tst.w	d0
		bne.s	locK_6170A
; locret3_4429A:
locretK_61708:
		rts
; ---------------------------------------------------------------------------
; loc3_4429C:
locK_6170A:
		lea	(Player_1).w,a1			; If collision was made
		cmpi.b	#6,routine(a1)
		bhs.s	locretK_61708		; If player has died for whatever reason, don't do anything
	if Sonic3_Alone
		cmpi.w	#7,(Chaos_emerald_count).w
		beq.s	locK_61794
	else
		moveq	#signextendB(sfx_BigRing),d0
		jsr	(Play_SFX).l		; Play the ring swish sound
		cmpi.b	#7,(Chaos_emerald_count).w
		bne.s	locK_6173A			; If Chaos Emeralds aren't collected, branch
		tst.w	(SK_alone_flag).w
		bne.s	locK_61794			; If only Sonic & Knuckles and the emeralds are collected, go claim 50 rings
		bsr.w	SSEntry_CheckLevel
		beq.s	locK_61794			; Otherwise, only do so if on an S3 level
		cmpi.b	#7,(Super_emerald_count).w
		beq.s	locK_61794			; Only collect rings in an SK level if the Super Emeralds are collected as well

locK_6173A:
	endif
		move.b	#4,routine(a0)
		move.b	#-1,(Player_prev_frame).w	; Make the player disappear and lock input
		lea	(Player_1).w,a1
		move.b	#0,mapping_frame(a1)
		move.b	#$1C,anim(a1)
		move.b	#$53,object_control(a1)
	if Sonic3_Alone
		lea	ChildObjDat_44476(pc),a2
		jsr	(CreateChild6_Simple).l
		move.w	(Player_1+x_pos).w,d0
		cmp.w	x_pos(a0),d0
		bcs.s	locretK_61708
		bset	#0,render_flags(a1)
		moveq	#signextendB(sfx_BigRing),d0
		jsr	(Play_SFX).l		; Play the ring swish sound
		rts
	else
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	locK_61778
		lea	(Player_2).w,a1
		move.b	#0,mapping_frame(a1)
		move.b	#$1C,anim(a1)
		move.b	#$53,object_control(a1)		; Lock both players, etc.

locK_61778:
		jsr	(AllocateObject).l
		bne.s	locretK_6178A
		move.l	#Obj_SSEntryFlash,(a1)
		move.w	a0,parent3(a1)			; Set ring as parent

locretK_6178A:
		rts
	endif
; ---------------------------------------------------------------------------
SSEntry_Range:
		dc.w   -$18,   $30,  -$28,   $50
; ---------------------------------------------------------------------------
; loc3_442FE:
locK_61794:
		moveq	#signextendB(sfx_BigRing),d0
		jsr	(Play_SFX).l
		move.b	subtype(a0),d0
		move.l	(Collected_special_ring_array).w,d1
		bset	d0,d1
		move.l	d1,(Collected_special_ring_array).w	; Set the special stage ring as collected
	if Sonic3_Alone
		bset	#0,$38(a0)
	else
		bset	#5,$38(a0)
	endif
		moveq	#50,d0				; Add 50 rings
		jmp	(AddRings).l
; ---------------------------------------------------------------------------

SSEntryRing_Animate:
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

Obj_SSEntryFlash:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	SSEntryFlash_Index(pc,d0.w),d1
		jsr	SSEntryFlash_Index(pc,d1.w)
		lea	DPLCPtr_SSEntryFlash(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

SSEntryFlash_Index:
		dc.w SSEntryFlash_Init-SSEntryFlash_Index
		dc.w SSEntryFlash_Main-SSEntryFlash_Index
; ---------------------------------------------------------------------------

SSEntryFlash_Init:
	if ~~Sonic3_Alone
		lea	ObjSlot_SSEntryFlash(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
	endif
		move.l	#AniRaw_SSEntryFlash,$30(a0)
		move.l	#SSEntryFlash_Finished,$34(a0)
		movea.w	parent3(a0),a1
	if Sonic3_Alone
		move.b	subtype(a1),subtype(a0)
		lea	ObjSlot_SSEntryFlash(pc),a1
		jmp	(SetUp_ObjAttributesSlotted).l
	else
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		move.b	subtype(a1),subtype(a0)		; Copy positional data from parent ring
		move.w	(Player_1+x_pos).w,d0
		cmp.w	x_pos(a0),d0
		blo.s	locretK_61820
		bset	#0,render_flags(a1)		; Set direction based on where player approached

locretK_61820:
		rts
	endif
; ---------------------------------------------------------------------------

SSEntryFlash_Main:
		move.b	mapping_frame(a0),d6
		jsr	(Animate_RawAdjustFlipX).l
		cmp.b	mapping_frame(a0),d6
		beq.s	locretK_61844
		cmpi.b	#3,anim_frame(a0)
		bne.s	locretK_61844
		movea.w	parent3(a0),a1			; Set parent to be deleted in the middle of the animation
	if Sonic3_Alone
		bset	#0,$38(a1)
	else
		bset	#5,$38(a1)
	endif
; locret3_44390:
locretK_61844:
		rts
; ---------------------------------------------------------------------------

SSEntryFlash_Finished:
		move.l	#Obj_Wait,(a0)		; This is performed when animation is finished
		move.w	#$20,$2E(a0)
		move.l	#SSEntryFlash_GoSS,$34(a0)
		rts
; ---------------------------------------------------------------------------

SSEntryFlash_GoSS:
	if Sonic3_Alone
		cmpi.w	#7,(Chaos_emerald_count).w
		beq.s	locK_618D0
	endif
		moveq	#signextendB(sfx_EnterSS),d0
		jsr	(Play_SFX).l		; Play the special stage entry sound (you know the one)
		jsr	(Clear_SpriteRingMem).l
		jsr	(Save_Level_Data2).l
	if Sonic3_Alone
		move.b	#1,(Special_bonus_entry_flag).w
		move.b	#GameMode_SpecialStage3,(Game_mode).w
		move.b	#1,(Respawn_table_keep).w
		move.b	subtype(a0),d0
		move.l	(Collected_special_ring_array).w,d1
		bset	d0,d1
		move.l	d1,(Collected_special_ring_array).w		; Set SS ring as collected
	else
		tst.b	subtype(a0)
		bmi.s	locK_618AC			; If negative, always go to HPZ
		moveq	#0,d0
		tst.w	(SK_alone_flag).w
		bne.s	locK_61892			; If SK alone, go directly to special stage
		bsr.w	SSEntry_CheckLevel
		beq.s	locK_61892			; Otherwise, do so if S3 levels
		cmpi.b	#7,(Chaos_emerald_count).w
		bne.s	locK_61892			; or if Chaos Emeralds aren't collected
		bra.w	locK_618AC			; When conditions are met, go to HPZ
; ---------------------------------------------------------------------------
		; unused
		moveq	#1,d0

locK_61892:
		move.b	d0,(SK_special_stage_flag).w			; Regular ring takes you directly to special stage
		move.b	#1,(Special_bonus_entry_flag).w
		move.b	#GameMode_SpecialStage,(Game_mode).w
		move.b	#1,(Respawn_table_keep).w
		bra.w	locK_618D0
; ---------------------------------------------------------------------------

locK_618AC:
		move.b	#2,(Special_bonus_entry_flag).w			; Super Emerald takes you to HPZ
		move.w	#$1701,(Current_zone_and_act).w
		move.w	#$1701,(Apparent_zone_and_act).w
		move.b	#0,(Last_star_post_hit).w
		move.b	#1,(Restart_level_flag).w
		move.b	#1,(Respawn_table_keep).w
	endif
; loc3_443E4:
locK_618D0:
	if ~~Sonic3_Alone
		move.b	subtype(a0),d0
		move.l	(Collected_special_ring_array).w,d1
		bset	d0,d1
		move.l	d1,(Collected_special_ring_array).w		; Set SS ring as collected
	endif
		jmp	(Go_Delete_SpriteSlotted2).l

	if ~~Sonic3_Alone
; =============== S U B R O U T I N E =======================================


SSEntry_CheckLevel:
		cmpi.b	#7,(Current_zone).w
		bhs.s	locK_618F8
		cmpi.b	#4,(Current_zone).w
		beq.s	locK_618F8
		moveq	#0,d1				; 0 is S3 levels
		rts
; ---------------------------------------------------------------------------

locK_618F8:
		moveq	#1,d1				; 1 is SK levels
		rts
; End of function SSEntry_CheckLevel
	endif

; ---------------------------------------------------------------------------

SSEntryRing_Display:
	if Sonic3_Alone
		btst	#0,$38(a0)
		bne.s	locK_6196A
		tst.b	render_flags(a0)
		bpl.s	locK_61928
	else
		btst	#5,$38(a0)
		bne.s	locK_6196A
		tst.b	4(a0)
		bpl.s	locK_61928
		btst	#6,$38(a0)
		beq.s	locK_61918
		jsr	(Run_PalRotationScript).l			; Only run the rotation script if this is a Super Emerald ring

locK_61918:
	endif
		lea	DPLCPtr_SSEntryRing(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_44408:
locK_61928:
		move.w	x_pos(a0),d0					; If off-screen
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	locK_6196A
		move.w	y_pos(a0),d0
		move.w	(Camera_Y_pos).w,d1
		move.w	y_pos(a0),d0
		sub.w	(Camera_Y_pos).w,d0
		addi.w	#$80,d0
		cmpi.w	#$200,d0
		bhi.w	locK_6196A					; Jump below when far enough off-screen
	if ~~Sonic3_Alone
		move.l	#$EE0088,(Normal_palette_line_2+$A).w
		move.w	#$44,(Normal_palette_line_2+$1E).w
	endif
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; loc3_4443C:
locK_6196A:
	if ~~Sonic3_Alone
		move.l	#$EE0088,(Normal_palette_line_2+$A).w
		move.w	#$44,(Normal_palette_line_2+$1E).w			; Restore the part of the palette that was changed
	endif
		lea	(ArtKosM_BadnikExplosion).l,a1
		move.w	#tiles_to_bytes(ArtTile_Explosion),d2
		jsr	(Queue_Kos_Module).l			; Restore the overwritten badnik explosion art
		jmp	(Go_Delete_SpriteSlotted).l
; ---------------------------------------------------------------------------

ObjSlot_SSEntryRing:
		dc.w 1-1
		dc.w make_art_tile(ArtTile_Explosion,1,0)
		dc.w    $40,     4
		dc.l Map_SSEntryRing
		dc.w   $280
		dc.b  $20, $20,   0,   0

ObjSlot_SSEntryFlash:
		dc.w 1-1
		dc.w make_art_tile(ArtTile_Player_1,1,0)
		dc.w    $18,     6
		dc.l Map_SSEntryFlash
		dc.w   $200
		dc.b  $20, $20,   0,   0

	if Sonic3_Alone
ChildObjDat_44476:
		dc.w 1-1
		dc.l Obj_SSEntryFlash
	endif

DPLCPtr_SSEntryRing:
		dc.l ArtUnc_SSEntryRing
		dc.l DPLC_SSEntryRing
DPLCPtr_SSEntryFlash:
		dc.l ArtUnc_SSEntryFlash
		dc.l DPLC_SSEntryFlash
AniRaw_SSEntryRing:
		dc.b    4,   0,   0,   1,   2,   3,   4,   5,   6,   7
		dc.b  $F8, .jump-AniRaw_SSEntryRing

.jump:
		dc.b    6,  $A,   9,   8,  $B, $FC

AniRaw_SSEntryFlash:
		dc.b    0,   0,   0,   1,   2,   3|$40,   3,   2,   1,   0, $F4
		even

Map_SSEntryRing:
		include "General/Sprites/SS Entry/Map - Entry Ring.asm"
DPLC_SSEntryRing:
		include "General/Sprites/SS Entry/DPLC - Special Stage Entry Ring.asm"
Map_SSEntryFlash:
		include "General/Sprites/SS Entry/Map - Entry Flash.asm"
DPLC_SSEntryFlash:
		include "General/Sprites/SS Entry/DPLC - Special Stage Entry Flash.asm"

	if ~~Sonic3_Alone
PalSPtr_SSEntry:
		palscriptptr .header, .data
.header	palscripthdr	Normal_palette_line_2+$A, 2, 0
.data	palscriptdata	3, $ECE, $A8A
	palscriptdata	3, $AEE, $6EE
	palscriptdata	3, $ECA, $A86
	palscriptdata	3, $AEE, $6EE
	palscriptdata	3, $8E8, $4C4
	palscriptdata	3, $AEE, $6EE
	palscriptdata	3, $6EC, $4CA
	palscriptdata	3, $AEE, $6EE
	palscriptdata	3, $6CE, $2AC
	palscriptdata	3, $AEE, $6EE
	palscriptrept
	palscriptdata	2, $6EE, $0AA
	palscriptdata	2, $8EE, $0CC
	palscriptdata	2, $AEE, $6EE
	palscriptdata	2, $CEE, $AEE
	palscriptdata	2, $EEE, $EEE
	palscriptdata	2, $CEE, $AEE
	palscriptdata	2, $AEE, $6EE
	palscriptdata	2, $8EE, $0CC
	palscriptrept

PalSPtr_SSEntry2:
		palscriptptr .header, .data
.header	palscripthdr	Normal_palette_line_2+$1E, 1, 0
.data	palscriptdata	3, $868
	palscriptdata	3, $0AA
	palscriptdata	3, $864
	palscriptdata	3, $0AA
	palscriptdata	3, $2A2
	palscriptdata	3, $0AA
	palscriptdata	3, $4A8
	palscriptdata	3, $0AA
	palscriptdata	3, $28A
	palscriptdata	3, $0AA
	palscriptrept
	palscriptdata	2, $066
	palscriptdata	2, $088
	palscriptdata	2, $0AA
	palscriptdata	2, $0CC
	palscriptdata	2, $EEE
	palscriptdata	2, $0CC
	palscriptdata	2, $0AA
	palscriptdata	2, $088
	palscriptrept
	palscriptdata	2, $6EE, $0AA
	palscriptdata	2, $8EE, $0CC
	palscriptdata	2, $AEE, $6EE
	palscriptdata	2, $CEE, $AEE
	palscriptdata	2, $EEE, $EEE
	palscriptdata	2, $CEE, $AEE
	palscriptdata	2, $AEE, $6EE
	palscriptdata	2, $8EE, $0CC
	palscriptdata	1, $066
	palscriptdata	1, $088
	palscriptdata	1, $0AA
	palscriptdata	1, $0CC
	palscriptdata	1, $EEE
	palscriptdata	1, $0CC
	palscriptdata	1, $0AA
	palscriptdata	1, $088
	endif