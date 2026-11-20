
; =============== S U B R O U T I N E =======================================

; sub3_2536C:
subK_263AA:
		move.l	#Map_LBZFlameThrower,mappings(a1)
		move.w	#make_art_tile(ArtTile_LBZMisc-$17,2,0),art_tile(a1)
		move.b	#$10,width_pixels(a1)
		move.b	#$10,height_pixels(a1)
		ori.b	#4,render_flags(a1)
		move.w	#$200,priority(a1)
		rts
; End of function subK_263AA

; ---------------------------------------------------------------------------

Obj_LBZFlameThrower:
		movea.l	a0,a1
		bsr.s	subK_263AA
		move.l	#locK_263DC,(a0)
; loc3_2539E:
locK_263DC:
		move.b	(V_int_run_count+3).w,d0
		add.b	subtype(a0),d0
		andi.b	#$7F,d0
		bne.s	locK_2643C
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	locK_2643C
		move.l	#Obj_AutoSpin460,(a1)
		bsr.s	subK_263AA
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.b	status(a0),status(a1)
		move.b	#$9D,collision_flags(a1)
		bset	#4,shield_reaction(a1)
		addi.w	#$40,x_pos(a1)
		btst	#0,status(a0)
		beq.s	locK_2642E
		subi.w	#2*$40,x_pos(a1)
; loc3_253F0:
locK_2642E:
		tst.b	render_flags(a0)
		bpl.s	locK_2643C
		moveq	#signextendB(sfx_FireAttack),d0
		jsr	(Play_SFX).l
; loc3_253FE:
locK_2643C:
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

Obj_AutoSpin460:
		lea	(Ani_LBZFlameThrower).l,a1
		jsr	(Animate_Sprite).l
		tst.b	routine(a0)
		beq.s	locK_26478
		move.w	#$7FFF,x_pos(a0)

locK_26478:
		jmp	(Sprite_CheckDeleteTouch3).l
; ---------------------------------------------------------------------------

Ani_LBZFlameThrower:
		include "Levels/LBZ/Misc Object Data/Anim - Flame Thrower.asm"
	if Sonic3_Alone
Map_LBZFlameThrower:
		include "Levels/LBZ/Misc Object Data/Map - Flame Thrower.asm"
	endif