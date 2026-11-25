; ---------------------------------------------------------------------------

Obj_InstaShield:
		; Init
		move.l	#Map_InstaShield,mappings(a0)
		move.l	#DPLC_InstaShield,shield_plc(a0)			; Used by PLCLoad_Shields
		move.l	#ArtUnc_InstaShield,shield_art(a0)			; Used by PLCLoad_Shields
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a0)
		move.w	#tiles_to_bytes(ArtTile_Shield),vram_art(a0)	; Used by PLCLoad_Shields
		btst	#7,(Player_1+art_tile).w
		beq.s	.nothighpriority
		bset	#7,art_tile(a0)

	.nothighpriority:
		move.w	#1,anim(a0)			; Clear anim and set prev_anim to 1
		move.b	#-1,shield_prev_frame(a0)	; Reset shield_prev_frame (used by PLCLoad_Shields)
		move.l	#Obj_InstaShield_Main,(a0)

Obj_InstaShield_Main:
		movea.w	parent(a0),a2
		btst	#Status_Invincible,status_secondary(a2)	; Is the player invincible?
		bne.s	locretK_195A4			; If so, return
		move.w	x_pos(a2),x_pos(a0)		; Inherit player's x_pos
		move.w	y_pos(a2),y_pos(a0)		; Inherit player's y_pos
		move.b	status(a2),status(a0)		; Inherit status
		andi.b	#1,status(a0)			; Limit inheritance to 'orientation' bit
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	.normalgravity
		ori.b	#2,status(a0)			; Reverse the vertical mirror render flag bit (on if off beforehand and vice versa)

	.normalgravity:
	endif
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	.nothighpriority
		ori.w	#high_priority,art_tile(a0)

	.nothighpriority:
		lea	(Ani_InstaShield).l,a1
		jsr	(Animate_Sprite).l
		cmpi.b	#7,mapping_frame(a0)		; Has it reached then end of its animation?
		bne.s	.notover			; If not, branch
	if ~~Sonic3_Alone
		; In Sonic 3, if the player landed from using the Insta-Shield before its
		; animation finishes, they would be unable to use it again until they land
		; for a second time.
		tst.b	double_jump_flag(a2)		; Is it in its attacking state?
		beq.s	.notover			; If not, branch
	endif
		move.b	#2,double_jump_flag(a2)		; Mark attack as over

	.notover:
		tst.b	mapping_frame(a0)		; Is this the first frame?
		beq.s	.loadnewDPLC			; If so, branch and load the DPLC for this and the next few frames
		cmpi.b	#3,mapping_frame(a0)		; Is this the third frame?
		bne.s	.skipDPLC			; If not, branch as we don't need to load another DPLC yet

	.loadnewDPLC:
		bsr.w	PLCLoad_Shields

	.skipDPLC:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; locret3_18158:
locretK_195A4:
		rts
; ---------------------------------------------------------------------------

Obj_FireShield:
		; Init
		move.l	#Map_FireShield,mappings(a0)
		move.l	#DPLC_FireShield,shield_plc(a0)				; Used by PLCLoad_Shields
		move.l	#ArtUnc_FireShield,shield_art(a0)			; Used by PLCLoad_Shields
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a0)
		move.w	#tiles_to_bytes(ArtTile_Shield),vram_art(a0)	; Used by PLCLoad_Shields
		btst	#7,(Player_1+art_tile).w
		beq.s	locK_195F0
		bset	#7,art_tile(a0)
; loc3_181A4:
locK_195F0:
		move.w	#1,anim(a0)				; Clear anim and set prev_anim to 1
		move.b	#-1,shield_prev_frame(a0)		; Reset shield_prev_frame (used by PLCLoad_Shields)
		move.l	#Obj_FireShield_Main,(a0)

Obj_FireShield_Main:
		movea.w	parent(a0),a2
		btst	#Status_Invincible,status_secondary(a2)	; Is player invincible?
	if Sonic3_Alone
		bne.s	locretK_19690				; If so, do not display and do not update variables
	else
		bne.w	locretK_19690				; If so, do not display and do not update variables
	endif
		cmpi.b	#$1C,anim(a2)				; Is player in their 'blank' animation?
		beq.s	locretK_19690				; If so, do not display and do not update variables
		btst	#Status_Shield,status_secondary(a2)	; Should the player still have a shield?
		beq.w	Obj_FireShield_Destroy			; If not, change to Insta-Shield
		btst	#Status_Underwater,status(a2)		; Is player underwater?
		bne.s	Obj_FireShield_DestroyUnderwater	; If so, branch
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		tst.b	anim(a0)				; Is shield in its 'dashing' state?
		bne.s	.nothighpriority			; If so, do not update orientation or allow changing of the priority art_tile bit
		move.b	status(a2),status(a0)			; Inherit status
		andi.b	#1,status(a0)				; Limit inheritance to 'orientation' bit
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	.normalgravity
		ori.b	#2,status(a0)				; If in reverse gravity, reverse the vertical mirror render flag bit (on if off beforehand and vice versa)

	.normalgravity:
	endif
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	.nothighpriority
		ori.w	#high_priority,art_tile(a0)

	.nothighpriority:
		lea	(Ani_FireShield).l,a1
		jsr	(Animate_Sprite).l
		move.w	#$80,priority(a0)		; Layer shield over player sprite
		cmpi.b	#$F,mapping_frame(a0)		; Are these the frames that display in front of the player?
		blo.s	.overplayer			; If so, branch
		move.w	#$200,priority(a0)		; If not, layer shield behind player sprite

	.overplayer:
		bsr.w	PLCLoad_Shields
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; locret3_18236:
locretK_19690:
		rts
; ---------------------------------------------------------------------------

Obj_FireShield_DestroyUnderwater:
		andi.b	#$8E,status_secondary(a2)	; Sets Status_Shield, Status_FireShield, Status_LtngShield, and Status_BublShield to 0
		jsr	(AllocateObject).l		; Set up for a new object
		bne.w	Obj_FireShield_Destroy		; If that can't happen, branch
		move.l	#Obj_FireShield_Dissipate,(a1)	; Create dissipate object
		move.w	x_pos(a0),x_pos(a1)		; Put it at shields' x_pos
		move.w	y_pos(a0),y_pos(a1)		; Put it at shields' y_pos

Obj_FireShield_Destroy:
		andi.b	#$8E,status_secondary(a2)	; Sets Status_Shield, Status_FireShield, Status_LtngShield, and Status_BublShield to 0
		move.l	#Obj_InstaShield,(a0)		; Replace the Fire Shield with the Insta-Shield
		rts
; ---------------------------------------------------------------------------

Obj_LightningShield:
		; init
		; Load Spark art
		move.l	#ArtUnc_LightningShield_Sparks,d1			; Load art source
		move.w	#tiles_to_bytes(ArtTile_Shield_Sparks),d2		; Load art destination
		move.w	#(ArtUnc_LightningShield_Sparks_end-ArtUnc_LightningShield_Sparks)/2,d3	; Size of art (in words)
		jsr	(Add_To_DMA_Queue).l

		move.l	#Map_LightningShield,mappings(a0)
		move.l	#DPLC_LightningShield,shield_plc(a0)			; Used by PLCLoad_Shields
		move.l	#ArtUnc_LightningShield,shield_art(a0)			; Used by PLCLoad_Shields
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a0)
		move.w	#tiles_to_bytes(ArtTile_Shield),vram_art(a0)	; Used by PLCLoad_Shields
		btst	#7,(Player_1+art_tile).w
		beq.s	.nothighpriority
		bset	#7,art_tile(a0)

	.nothighpriority:
		move.w	#1,anim(a0)				; Clear anim and set prev_anim to 1
		move.b	#-1,shield_prev_frame(a0)		; Reset shield_prev_frame (used by PLCLoad_Shields)
		move.l	#Obj_LightningShield_Main,(a0)

Obj_LightningShield_Main:
		movea.w	parent(a0),a2
		btst	#Status_Invincible,status_secondary(a2)	; Is player invincible?
	if Sonic3_Alone
		bne.s	locretK_197C4				; If so, do not display and do not update variables
	else
		bne.w	locretK_197C4				; If so, do not display and do not update variables
	endif
		cmpi.b	#$1C,anim(a2)				; Is player in their 'blank' animation?
		beq.s	locretK_197C4				; If so, do not display and do not update variables
		btst	#Status_Shield,status_secondary(a2)	; Should the player still have a shield?
	if Sonic3_Alone
		beq.w	Obj_LightningShield_Destroy		; If not, change to Insta-Shield
	else
		beq.s	Obj_LightningShield_Destroy		; If not, change to Insta-Shield
	endif
		btst	#Status_Underwater,status(a2)		; Is player underwater?
		bne.s	Obj_LightningShield_DestroyUnderwater	; If so, branch
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		move.b	status(a2),status(a0)			; Inherit status
		andi.b	#1,status(a0)				; Limit inheritance to 'orientation' bit
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	.normalgravity
		ori.b	#2,status(a0)				; If in reverse gravity, reverse the vertical mirror render flag bit (on if off beforehand and vice versa)

	.normalgravity:
	endif
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	.nothighpriority
		ori.w	#high_priority,art_tile(a0)

	.nothighpriority:
		tst.b	anim(a0)				; Is shield in its 'double jump' state?
		beq.s	Obj_LightningShield_Display		; Is not, branch and display
		bsr.s	Obj_LightningShield_CreateSpark		; Create sparks
		clr.b	anim(a0)				; Once done, return to non-'double jump' state

Obj_LightningShield_Display:
		lea	(Ani_LightningShield).l,a1
		jsr	(Animate_Sprite).l
		move.w	#$80,priority(a0)			; Layer shield over player sprite
		cmpi.b	#$E,mapping_frame(a0)			; Are these the frames that display in front of the player?
		blo.s	.overplayer				; If so, branch
		move.w	#$200,priority(a0)			; If not, layer shield behind player sprite

	.overplayer:
		bsr.w	PLCLoad_Shields
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; locret3_1835E:
locretK_197C4:
		rts
; ---------------------------------------------------------------------------

Obj_LightningShield_DestroyUnderwater:
		tst.w	(Palette_fade_timer).w
	if Sonic3_Alone
		bne.s	Obj_LightningShield_Destroy
		andi.b	#$8E,status_secondary(a2)	; Sets Status_Shield, Status_FireShield, Status_LtngShield, and Status_BublShield to 0

		; Flashes the underwater palette white
		lea	(Water_palette).w,a1
		lea	(Target_water_palette).w,a2
		move.w	#bytesToLcnt($80),d0			; Size of Water_palette/4-1

loc3_18378:
		move.l	(a1),(a2)+			; Backup palette entries
		move.l	#$0EEE0EEE,(a1)+		; Overwrite palette entries with white
		dbf	d0,loc3_18378			; Loop until entire thing is overwritten

		move.w	#0,(Water_palette_line_3).w			; Set the first color in the third palette line to black
		move.b	#3,anim_frame_timer(a0)
		move.l	#Obj_LightningShield_DestroyUnderwater2,(a0)
		rts
; ---------------------------------------------------------------------------

Obj_LightningShield_Destroy:
		andi.b	#$8E,status_secondary(a2)	; Sets Status_Shield, Status_FireShield, Status_LtngShield, and Status_BublShield to 0
		move.l	#Obj_InstaShield,(a0)		; Replace the Lightning Shield with the Insta-Shield
		rts
	else
		beq.s	Obj_LightningShield_FlashWater

Obj_LightningShield_Destroy:
		andi.b	#$8E,status_secondary(a2)	; Sets Status_Shield, Status_FireShield, Status_LtngShield, and Status_BublShield to 0
		move.l	#Obj_InstaShield,(a0)		; Replace the Lightning Shield with the Insta-Shield
		rts
; ---------------------------------------------------------------------------

Obj_LightningShield_FlashWater:
		move.l	#Obj_LightningShield_DestroyUnderwater2,(a0)
		andi.b	#$8E,status_secondary(a2)	; Sets Status_Shield, Status_FireShield, Status_LtngShield, and Status_BublShield to 0

		; Flashes the underwater palette white
		lea	(Water_palette).w,a1
		lea	(Target_water_palette).w,a2
		move.w	#bytesToLcnt($80),d0			; Size of Water_palette/4-1

locK_197F2:
		move.l	(a1),(a2)+			; Backup palette entries
		move.l	#$0EEE0EEE,(a1)+		; Overwrite palette entries with white
		dbf	d0,locK_197F2			; Loop until entire thing is overwritten

		move.w	#0,-$40(a1)			; Set the first color in the third palette line to black
		move.b	#3,anim_frame_timer(a0)
		rts
	endif

; =============== S U B R O U T I N E =======================================


Obj_LightningShield_CreateSpark:
	if ~~Sonic3_Alone
		moveq	#1,d2

Obj_LightningShield_CreateSpark_Part2:
	endif
		lea	(SparkVelocities).l,a2
		moveq	#4-1,d1

	.loop:
		bsr.w	AllocateObject		; Find free object slot
		bne.s	.end			; If one can't be found, return
		move.l	#Obj_LightningShield_Spark,(a1)	; Make new object a Spark
		move.w	x_pos(a0),x_pos(a1)		; (Spark) Inherit x_pos from source object (Lightning Shield, Hyper Sonic Stars)
		move.w	y_pos(a0),y_pos(a1)		; (Spark) Inherit y_pos from source object (Lightning Shield, Hyper Sonic Stars)
		move.l	mappings(a0),mappings(a1)	; (Spark) Inherit mappings from source object (Lightning Shield, Hyper Sonic Stars)
		move.w	art_tile(a0),art_tile(a1)	; (Spark) Inherit art_tile from source object (Lightning Shield, Hyper Sonic Stars)
		move.b	#4,render_flags(a1)
		move.w	#$80,priority(a1)
		move.b	#8,width_pixels(a1)
		move.b	#8,height_pixels(a1)
	if Sonic3_Alone
		move.b	#1,anim(a1)
	else
		move.b	d2,anim(a1)
	endif
		move.w	(a2)+,x_vel(a1)			; (Spark) Give x_vel (unique to each of the four Sparks)
		move.w	(a2)+,y_vel(a1)			; (Spark) Give y_vel (unique to each of the four Sparks)
		dbf	d1,.loop

	.end:
		rts
; End of function Obj_LightningShield_CreateSpark

; ---------------------------------------------------------------------------
SparkVelocities:
		dc.w  -$200, -$200
		dc.w   $200, -$200
		dc.w  -$200,  $200
		dc.w   $200,  $200
; ---------------------------------------------------------------------------

Obj_LightningShield_Spark:
		jsr	(MoveSprite2).l
		addi.w	#$18,y_vel(a0)
		lea	(Ani_LightningShield).l,a1
		jsr	(Animate_Sprite).l
		tst.b	routine(a0)			; Changed by Animate_Sprite
		bne.s	Obj_LightningShield_Spark_Delete
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_LightningShield_Spark_Delete:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_LightningShield_DestroyUnderwater2:
		subq.b	#1,anim_frame_timer(a0)		; Is it time to end the white flash?
		bpl.s	.end			; If not, return
	if ~~Sonic3_Alone
		move.l	#Obj_InstaShield,(a0)		; Replace Lightning Shield with Insta-Shield
	endif
		lea	(Target_water_palette).w,a1
		lea	(Water_palette).w,a2
		move.w	#bytesToLcnt($80),d0		; Size of Water_palette/4-1

	.loop:
		move.l	(a1)+,(a2)+			; Restore backed-up underwater palette
		dbf	d0,.loop			; Loop until entire thing is restored
	if Sonic3_Alone
		move.l	#Obj_InstaShield,(a0)		; Replace Lightning Shield with Insta-Shield
	endif

	.end:
		rts
; ---------------------------------------------------------------------------

Obj_BubbleShield:
		; Init
		move.l	#Map_BubbleShield,mappings(a0)
		move.l	#DPLC_BubbleShield,shield_plc(a0)			; Used by PLCLoad_Shields
		move.l	#ArtUnc_BubbleShield,shield_art(a0)			; Used by PLCLoad_Shields
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a0)
		move.w	#tiles_to_bytes(ArtTile_Shield),vram_art(a0)	; Used by PLCLoad_Shields
		btst	#7,(Player_1+art_tile).w
		beq.s	.nothighpriority
		bset	#7,art_tile(a0)

	.nothighpriority:
		move.w	#1,anim(a0)				; Clear anim and set prev_anim to 1
		move.b	#-1,shield_prev_frame(a0)		; Reset shield_prev_frame (used by PLCLoad_Shields)
		movea.w	parent(a0),a1
		bsr.w	Player_ResetAirTimer
		move.l	#Obj_BubbleShield_Main,(a0)

Obj_BubbleShield_Main:
		movea.w	parent(a0),a2
		btst	#Status_Invincible,status_secondary(a2)	; Is player invincible?
		bne.s	locretK_1998A				; If so, do not display and do not update variables
		cmpi.b	#$1C,anim(a2)				; Is player in their 'blank' animation?
		beq.s	locretK_1998A				; If so, do not display and do not update variables
		btst	#Status_Shield,status_secondary(a2)	; Should the player still have a shield?
		beq.s	Obj_BubbleShield_Destroy		; If not, change to Insta-Shield
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		move.b	status(a2),status(a0)			; Inherit status
		andi.b	#1,status(a0)				; Limit inheritance to 'orientation' bit
	if ~~Sonic3_Alone
		tst.b	(Reverse_gravity_flag).w
		beq.s	.normalgravity
		ori.b	#2,status(a0)				; Reverse the vertical mirror render flag bit (on if off beforehand and vice versa)

	.normalgravity:
	endif
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	.nothighpriority
		ori.w	#high_priority,art_tile(a0)

	.nothighpriority:
		lea	(Ani_BubbleShield).l,a1
		jsr	(Animate_Sprite).l
		bsr.w	PLCLoad_Shields
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; locret3_18518:
locretK_1998A:
		rts
; ---------------------------------------------------------------------------

Obj_BubbleShield_Destroy:
		andi.b	#$8E,status_secondary(a2)	; Sets Status_Shield, Status_FireShield, Status_LtngShield, and Status_BublShield to 0
		move.l	#Obj_InstaShield,(a0)		; Replace the Bubble Shield with the Insta-Shield
		rts

; =============== S U B R O U T I N E =======================================


PLCLoad_Shields:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		cmp.b	shield_prev_frame(a0),d0
		beq.s	locretK_199E8
		move.b	d0,shield_prev_frame(a0)
		movea.l	shield_plc(a0),a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locretK_199E8
		move.w	vram_art(a0),d4

PLCLoad_Shields_ReadEntry:
		moveq	#0,d1
		move.w	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		add.l	shield_art(a0),d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		dbf	d5,PLCLoad_Shields_ReadEntry
; locret3_18576:
locretK_199E8:
		rts
; End of function PLCLoad_Shields

; ---------------------------------------------------------------------------
Ani_InstaShield:
		include "General/Sprites/Shields/Anim - Insta-Shield.asm"
Ani_FireShield:
		include "General/Sprites/Shields/Anim - Fire Shield.asm"
	if Sonic3_Alone
Ani_LightningShield:
		include "General/Sprites/Shields/Anim - Lightning Shield S3.asm"
	else
Ani_LightningShield:
		include "General/Sprites/Shields/Anim - Lightning Shield.asm"
	endif
Ani_BubbleShield:
		include "General/Sprites/Shields/Anim - Bubble Shield.asm"
Map_FireShield:
		include "General/Sprites/Shields/Map - Fire Shield.asm"
DPLC_FireShield:
		include "General/Sprites/Shields/DPLC - Fire Shield.asm"
Map_LightningShield:
		include "General/Sprites/Shields/Map - Lightning Shield.asm"
DPLC_LightningShield:
		include "General/Sprites/Shields/DPLC - Lightning Shield.asm"
Map_BubbleShield:
		include "General/Sprites/Shields/Map - Bubble Shield.asm"
DPLC_BubbleShield:
		include "General/Sprites/Shields/DPLC - Bubble Shield.asm"
Map_InstaShield:
		include "General/Sprites/Shields/Map - Insta-Shield.asm"
DPLC_InstaShield:
		include "General/Sprites/Shields/DPLC - Insta-Shield.asm"