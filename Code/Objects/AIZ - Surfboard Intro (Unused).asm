; ---------------------------------------------------------------------------

Obj_AIZSurfboardIntro:
		move.l	#Map_SurfboardIntro,mappings(a0)
		move.w	#$100,priority(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#4,render_flags(a0)
		move.w	#make_art_tile(ArtTile_Player_1,0,0),art_tile(a0)
		move.b	#-1,(Player_prev_frame).w
		move.l	#Obj_AIZSurfboardIntro_Main,(a0)
		move.w	(Player_1+x_pos).w,x_pos(a0)
		move.w	(Player_1+y_pos).w,y_pos(a0)
		subi.w	#$20,x_pos(a0)
		subi.w	#$10,y_pos(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		clr.w	(Events_fg_1).w
		tst.b	$2C(a0)
		bne.s	loc3_20B78
		lea	(Player_1).w,a1
		move.b	#0,mapping_frame(a1)
		move.b	#3,$2E(a1)

loc3_20B78:
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	Obj_AIZSurfboardIntro_Main
		move.l	#Obj_SurfboardSplash,(a1)
		move.w	a0,$30(a1)

Obj_AIZSurfboardIntro_Main:
		tst.b	subtype(a0)
		bne.s	loc3_20BFC
		lea	(Player_1).w,a1
		addi.w	#8,x_pos(a1)
		addi.w	#8,x_pos(a0)
		cmpi.w	#$900,x_pos(a1)
		bcs.s	loc3_20BFC
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc3_20BD0
		move.l	#Obj_Surfboard,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		addi.w	#$C,y_pos(a1)
		move.w	a0,$30(a1)

loc3_20BD0:
		move.w	#$800,x_vel(a0)
		move.w	#-$400,y_vel(a0)
		move.l	#Obj_AIZSurfboardIntro_Jump,(a0)
		move.w	#1,anim(a0)
		subi.w	#5,x_pos(a0)
		move.b	#7,mapping_frame(a0)
		jsr	(SurfboardIntro_Load_PLC).l
		bra.s	loc3_20C00
; ---------------------------------------------------------------------------

loc3_20BFC:
		bsr.w	SurfboardIntro_Move

loc3_20C00:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

Obj_AIZSurfboardIntro_Jump:
		lea	(Player_1).w,a1
		addi.w	#8,x_pos(a1)
		jsr	(MoveSprite2).l
		addi.w	#$20,y_vel(a0)
		moveq	#1,d2
		move.w	x_pos(a0),d0
		cmp.w	x_pos(a1),d0
		beq.s	loc3_20C30
		blt.s	loc3_20C2C
		neg.w	d2

loc3_20C2C:
		add.w	d2,x_pos(a0)

loc3_20C30:
		tst.w	y_vel(a0)
		bmi.s	loc3_20C74
		cmpi.w	#$440,y_pos(a0)
		bcs.s	loc3_20C74
		move.w	#$440,y_pos(a0)
		move.w	#0,y_vel(a0)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.w	#1,anim(a1)
		move.w	#$800,ground_vel(a1)
		move.w	#$800,x_vel(a1)
		move.w	#0,y_vel(a1)
		move.l	#Obj_AIZSurfboardIntro_Run,(a0)

loc3_20C74:
		lea	(Ani_SurfboardIntro).l,a1
		jsr	(Animate_Sprite).l
		jsr	(SurfboardIntro_Load_PLC).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
Ani_SurfboardIntro:
		include "General/Sprites/Sonic/Anim - Sonic Surfboard.asm"
; ---------------------------------------------------------------------------

Obj_AIZSurfboardIntro_Run:
		movea.l	a0,a3
		lea	(Player_1).w,a0
		move.w	#0,y_vel(a0)
		cmpi.w	#$1170,x_pos(a0)
		bcs.s	loc3_20CB6
		cmpi.w	#$1270,x_pos(a0)
		bcc.s	loc3_20CB6
		move.w	#-$138,y_vel(a0)

loc3_20CB6:
		jsr	(MoveSprite2).l
		cmpi.w	#$13C0,x_pos(a0)
		bcs.s	loc3_20CE2
		move.b	#0,$2E(a0)
		move.l	#Obj_AIZSurfboardIntro_Stop,(a3)
		move.b	#1,(Ctrl_1_locked).w
		move.w	#button_left_mask<<8,(Ctrl_1_logical).w
		move.w	#$E,$2E(a3)

loc3_20CE2:
		jsr	(Animate_Sonic).l
		move.l	a3,-(sp)
		jsr	(Sonic_Load_PLC).l
		movea.l	(sp)+,a0
		addi.w	#8,x_pos(a0)
		move.b	#0,mapping_frame(a0)
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

Obj_AIZSurfboardIntro_Stop:
		subq.w	#1,$2E(a0)
		bpl.s	loc3_20D32
		lea	(Player_1).w,a1
		move.w	#0,ground_vel(a1)
		move.w	#0,x_vel(a1)
		move.w	#0,y_vel(a1)
		move.b	#0,(Ctrl_1_locked).w
		move.w	#0,(Ctrl_1_logical).w
		move.l	#Obj_AIZSurfboardIntro_CheckDelete,(a0)

loc3_20D32:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

Obj_AIZSurfboardIntro_CheckDelete:
		jmp	(Sprite_OnScreen_Test).l

; =============== S U B R O U T I N E =======================================


SurfboardIntro_Move:
		move.w	#2,d1
		move.w	(Player_1+x_pos).w,d0
		cmp.w	x_pos(a0),d0
		bcc.s	loc3_20D4E
		neg.w	d1

loc3_20D4E:
		add.w	d1,x_vel(a0)
		moveq	#0,d2
		lea	(SurfboardIntro_DownFrames).l,a1
		move.w	#3,d1
		move.w	(Player_1+y_pos).w,d0
		cmp.w	y_pos(a0),d0
		bcc.s	loc3_20D76
		moveq	#1,d2
		lea	(SurfboardIntro_UpFrames).l,a1
		move.w	#4,d1
		neg.w	d1

loc3_20D76:
		add.w	d1,y_vel(a0)
		jsr	(MoveSprite2).l
		move.w	y_vel(a0),d0
		tst.w	d2
		bne.s	loc3_20D8A
		neg.w	d0

loc3_20D8A:
		addi.w	#$80,d0
		cmpi.w	#$100,d0
		bcs.s	loc3_20D98
		move.w	#$100,d0

loc3_20D98:
		lsr.w	#5,d0
		move.b	(a1,d0.w),d0
		addq.b	#1,d0
		move.b	d0,mapping_frame(a0)
		jsr	(SurfboardIntro_Load_PLC).l
		subq.w	#1,$2E(a0)
		bpl.s	locret3_20DCA
		move.w	#5,$2E(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	locret3_20DCA
		move.l	#Obj_SurfboardWaves,(a1)
		move.w	a0,$30(a1)

locret3_20DCA:
		rts
; ---------------------------------------------------------------------------
SurfboardIntro_DownFrames:
		dc.b    2,   1,   1,   0,   0,   0,   0,   1,   2,   2
SurfboardIntro_UpFrames:
		dc.b    3,   4,   4,   4,   5,   5,   5,   4,   3,   3
		even
; End of function SurfboardIntro_Move


; =============== S U B R O U T I N E =======================================


SurfboardIntro_Load_PLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		cmp.b	(Player_prev_frame).w,d0
		beq.s	locret3_20E32
		move.b	d0,(Player_prev_frame).w
		lea	(DPLC_SurfboardIntro).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret3_20E32
		move.w	#tiles_to_bytes(ArtTile_Player_1),d4

loc3_20E06:
		moveq	#0,d1
		move.w	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		addi.l	#ArtUnc_SurfboardIntro,d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		dbf	d5,loc3_20E06

locret3_20E32:
		rts
; End of function SurfboardIntro_Load_PLC

; ---------------------------------------------------------------------------
Map_SurfboardIntro:
		include "General/Sprites/Sonic/Map - Sonic Surfboarding.asm"
DPLC_SurfboardIntro:
		include "General/Sprites/Sonic/DPLC - Sonic Surfboarding.asm"
; ---------------------------------------------------------------------------

Obj_SurfboardWaves:
		move.l	#Map_AIZIntroWaves,mappings(a0)
		move.w	#$100,priority(a0)
		move.b	#0,width_pixels(a0)
		move.b	#4,render_flags(a0)
		move.w	#make_art_tile(ArtTile_AIZIntroSprites,0,0),art_tile(a0)
		move.l	#Obj_SurfboardWaves_Main,(a0)
		move.w	#1,anim(a0)	; and prev_anim
		move.b	#0,mapping_frame(a0)
		move.b	#0,anim_frame(a0)
		bset	#0,status(a0)
		movea.w	$30(a0),a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		addi.w	#-$28,x_pos(a0)
		addi.w	#$18,y_pos(a0)

Obj_SurfboardWaves_Main:
		lea	(Ani_SurfboardWaves).l,a1
		jsr	(Animate_SpriteIrregularDelay).l
		tst.b	routine(a0)
		beq.s	loc3_20FE6
		move.w	#$7FFF,x_pos(a0)

loc3_20FE6:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
Ani_SurfboardWaves:
		include "General/Sprites/Surfboard/Anim - Surfboard Waves.asm"
; ---------------------------------------------------------------------------

Obj_SurfboardSplash:
		movea.l	a0,a1
		bsr.s	SurfboardSplash_Init
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc3_2102A
		bsr.s	SurfboardSplash2_Init
		move.l	#Obj_SurfboardSplash2_Main,(a1)
		move.w	#$80,priority(a1)
		move.w	#-$14,$32(a1)
		move.w	#$10,$34(a1)
		move.w	$30(a0),$30(a1)

loc3_2102A:
		bra.s	Obj_SurfboardSplash_Main

; =============== S U B R O U T I N E =======================================


SurfboardSplash_Init:
		move.l	#Obj_SurfboardSplash_Main,(a1)
		move.w	#$180,priority(a1)
		move.w	#8,$32(a1)
		move.w	#$18,$34(a1)

SurfboardSplash2_Init:
		move.l	#Map_SurfboardSplash,mappings(a1)
		move.b	#$1C,width_pixels(a1)
		move.b	#4,render_flags(a1)
		move.w	#$529,art_tile(a1)
		move.w	#1,anim(a1)	; and prev_anim
		bset	#0,status(a1)
		rts
; End of function SurfboardSplash_Init

; ---------------------------------------------------------------------------

Obj_SurfboardSplash_Main:
		movea.w	$30(a0),a1
		lea	(SurfboardSplash_Offsets).l,a2
		bsr.w	SurfboardSplash_SetOffsets
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		move.w	$32(a0),d0
		add.w	d0,x_pos(a0)
		move.w	$34(a0),d0
		add.w	d0,y_pos(a0)
		cmpi.b	#7,mapping_frame(a1)
		bcs.s	loc3_210A4
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc3_210A4:
		cmpi.b	#5,mapping_frame(a1)
		bcs.s	loc3_210BA
		tst.w	$36(a0)
		beq.s	locret3_210B8
		subq.w	#1,$36(a0)
		bra.s	loc3_210C0
; ---------------------------------------------------------------------------

locret3_210B8:
		rts
; ---------------------------------------------------------------------------

loc3_210BA:
		move.w	#3,$36(a0)

loc3_210C0:
		lea	(Ani_SurfboardSplash).l,a1
		jsr	(Animate_SpriteIrregularDelay).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
SurfboardSplash_Offsets:
		dc.b    0, $18
		dc.b    0, $11
		dc.b    0, $15
		dc.b   -8, $15
		dc.b   -8, $13
		dc.b   -8, $13
		dc.b   -8, $13
; ---------------------------------------------------------------------------

Obj_SurfboardSplash2_Main:
		movea.w	$30(a0),a1
		lea	(SurfboardSplash2_Offsets).l,a2
		bsr.s	SurfboardSplash_SetOffsets
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		move.w	$32(a0),d0
		add.w	d0,x_pos(a0)
		move.w	$34(a0),d0
		add.w	d0,y_pos(a0)
		cmpi.b	#7,mapping_frame(a1)
		bcs.s	loc3_21116
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc3_21116:
		cmpi.b	#5,mapping_frame(a1)
		bcc.s	loc3_2112C
		tst.w	$36(a0)
		beq.s	locret3_2112A
		subq.w	#1,$36(a0)
		bra.s	loc3_21132
; ---------------------------------------------------------------------------

locret3_2112A:
		rts
; ---------------------------------------------------------------------------

loc3_2112C:
		move.w	#3,$36(a0)

loc3_21132:
		lea	(Ani_SurfboardSplash).l,a1
		jsr	(Animate_SpriteIrregularDelay).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
SurfboardSplash2_Offsets:
		dc.b   -8, $12
		dc.b   -8, $12
		dc.b   -8, $12
		dc.b   -8, $12
		dc.b   -8, $12
		dc.b  -$F, $12
		dc.b -$13, $17

; =============== S U B R O U T I N E =======================================


SurfboardSplash_SetOffsets:
		moveq	#0,d0
		move.b	mapping_frame(a1),d0
		add.w	d0,d0
		move.b	(a2,d0.w),d1
		ext.w	d1
		moveq	#1,d2
		cmp.w	$32(a0),d1
		beq.s	loc3_21170
		bgt.s	loc3_2116C
		neg.w	d2

loc3_2116C:
		add.w	d2,$32(a0)

loc3_21170:
		move.b	1(a2,d0.w),d1
		ext.w	d1
		moveq	#1,d2
		cmp.w	$34(a0),d1
		beq.s	locret3_21186
		bgt.s	loc3_21182
		neg.w	d2

loc3_21182:
		add.w	d2,$34(a0)

locret3_21186:
		rts
; End of function SurfboardSplash_SetOffsets

; ---------------------------------------------------------------------------
Ani_SurfboardSplash:
		include "General/Sprites/Surfboard/Anim - Surfboard Splash.asm"
Map_AIZIntroWaves:
		include "Levels/AIZ/Misc Object Data/Map - Intro Waves.asm"
Map_SurfboardSplash:
		include "General/Sprites/Surfboard/Map - Surfboard Splash.asm"
; ---------------------------------------------------------------------------

Obj_Surfboard:
		move.l	#Map_Surfboard,mappings(a0)
		move.w	#$80,priority(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#4,render_flags(a0)
		move.w	#make_art_tile(ArtTile_Surfboard,0,0),art_tile(a0)
		move.l	#Obj_Surfboard_Main,(a0)
		move.w	#1,anim(a0)
		move.w	#$800,x_vel(a0)
		move.w	#-$300,y_vel(a0)

Obj_Surfboard_Main:
		cmpi.b	#3,anim_frame(a0)
		bcs.s	loc3_212FE
		tst.w	x_vel(a0)
		beq.s	loc3_212FE
		subi.w	#$10,x_vel(a0)

loc3_212FE:
		jsr	(MoveSprite2).l
		addi.w	#$20,y_vel(a0)
		lea	(Ani_Surfboard).l,a1
		jsr	(Animate_SpriteIrregularDelay).l
		move.b	#0,status(a0)
		move.b	anim_frame(a0),d0
		andi.b	#7,d0
		cmpi.b	#4,d0
		bcs.s	loc3_21330
		move.b	#3,status(a0)

loc3_21330:
		tst.b	routine(a0)
		beq.s	loc3_2133C
		move.w	#$7FFF,x_pos(a0)

loc3_2133C:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
Ani_Surfboard:
		include "General/Sprites/Surfboard/Anim - Surfboard.asm"
Map_Surfboard:
		include "General/Sprites/Surfboard/Map - Surfboard.asm"