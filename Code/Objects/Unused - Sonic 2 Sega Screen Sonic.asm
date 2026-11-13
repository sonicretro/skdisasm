; ---------------------------------------------------------------------------

Obj_SonicOnSegaScr:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	SonicOnSegaScr_Index(pc,d0.w),d1
		jmp	SonicOnSegaScr_Index(pc,d1.w)
; ---------------------------------------------------------------------------
SonicOnSegaScr_Index:
		dc.w SonicOnSegaScr_Init-SonicOnSegaScr_Index
		dc.w SonicOnSegaScr_RunLeft-SonicOnSegaScr_Index
		dc.w SonicOnSegaScr_MidWipe-SonicOnSegaScr_Index
		dc.w SonicOnSegaScr_RunRight-SonicOnSegaScr_Index
		dc.w SonicOnSegaScr_EndWipe-SonicOnSegaScr_Index
		dc.w locret3_43340-SonicOnSegaScr_Index
; ---------------------------------------------------------------------------

SonicOnSegaScr_Init:
		lea	ObjDat3_434E0(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#0,render_flags(a0)
		move.w	#$1E8,x_pos(a0)
		move.w	#$F0,y_pos(a0)
		move.w	#$B,$2E(a0)
		move.w	#2,(_unkF662).w
		bset	#0,render_flags(a0)
		bset	#0,status(a0)
		lea	(H_scroll_buffer+$138).w,a1
		lea	Streak_Horizontal_offsets(pc),a2
		moveq	#0,d0
		moveq	#35-1,d6

loc3_431B8:
		move.b	(a2)+,d0
		add.w	d0,(a1)
		addq.w	#8,a1
		dbf	d6,loc3_431B8
		move.w	d7,-(sp)
		moveq	#0,d0
		moveq	#0,d1
		lea	SonicRunningSpriteScaleData(pc),a6
		moveq	#8-1,d7

loc3_431CE:
		movea.l	(a6)+,a1
		movea.l	(a6)+,a2
		move.b	(a6)+,d0
		move.b	(a6)+,d1
		bsr.w	Scale_2x
		dbf	d7,loc3_431CE
		move.w	(sp)+,d7
		rts
; ---------------------------------------------------------------------------
SonicRunningSpriteScaleData:
		dc.l Chunk_table
		dc.l Chunk_table+$B00
		dc.b 3-1
		dc.b 2-1
		dc.l Chunk_table+$C0
		dc.l Chunk_table+$E00
		dc.b 4-1
		dc.b 4-1
		dc.l Chunk_table+$2C0
		dc.l Chunk_table+$1600
		dc.b 3-1
		dc.b 2-1
		dc.l Chunk_table+$380
		dc.l Chunk_table+$1900
		dc.b 4-1
		dc.b 4-1
		dc.l Chunk_table+$580
		dc.l Chunk_table+$2100
		dc.b 3-1
		dc.b 2-1
		dc.l Chunk_table+$640
		dc.l Chunk_table+$2400
		dc.b 4-1
		dc.b 4-1
		dc.l Chunk_table+$840
		dc.l Chunk_table+$2C00
		dc.b 3-1
		dc.b 2-1
		dc.l Chunk_table+$900
		dc.l Chunk_table+$2F00
		dc.b 4-1
		dc.b 4-1
; ---------------------------------------------------------------------------

SonicOnSegaScr_RunLeft:
		subi.w	#$20,x_pos(a0)
		subq.w	#1,$2E(a0)
		bmi.s	loc3_43254
		bsr.w	SonicOnSegaScr_Move_Streaks_Left
		lea	(Ani_SonicOnSegaScr).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc3_43254:
		addq.b	#2,routine(a0)
		move.w	#$C,$2E(a0)
		move.b	#1,$30(a0)
		move.b	#-1,$31(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

SonicOnSegaScr_MidWipe:
		tst.w	$2E(a0)
		beq.s	loc3_4327E
		subq.w	#1,$2E(a0)
		bsr.w	SonicOnSegaScr_Move_Streaks_Left

loc3_4327E:
		lea	byte_433F4(pc),a1
		bsr.w	sub_433A6
		bne.s	loc3_4328A
		rts
; ---------------------------------------------------------------------------

loc3_4328A:
		addq.b	#2,routine(a0)
		bchg	#0,render_flags(a0)
		move.w	#$B,$2E(a0)
		move.w	#4,(_unkF662).w
		subi.w	#$28,x_pos(a0)
		bchg	#0,render_flags(a0)
		bchg	#0,status(a0)
	if FixBugs
		clearRAM	H_scroll_buffer,(Target_water_palette-H_scroll_buffer)
	else
		; Bug: this should be (Target_water_palette-H_scroll_buffer)
		clearRAM	H_scroll_buffer,(Target_water_palette-H_scroll_buffer)+4
	endif
		lea	(H_scroll_buffer+$13C).w,a1
		lea	Streak_Horizontal_offsets(pc),a2
		moveq	#0,d0
		moveq	#35-1,d6

loc3_432CE:
		move.b	(a2)+,d0
		sub.w	d0,(a1)
		addq.w	#8,a1
		dbf	d6,loc3_432CE

locret3_432D8:
		rts
; ---------------------------------------------------------------------------

SonicOnSegaScr_RunRight:
		subq.w	#1,$2E(a0)
		bmi.s	loc3_432FC
		addi.w	#$20,x_pos(a0)
		bsr.w	SonicOnSegaScr_Move_Streaks_Right
		lea	(Ani_SonicOnSegaScr).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc3_432FC:
		addq.b	#2,routine(a0)
		move.w	#$C,$2E(a0)
		move.b	#1,$30(a0)
		move.b	#-1,$31(a0)
		rts
; ---------------------------------------------------------------------------

SonicOnSegaScr_EndWipe:
		tst.w	$2E(a0)
		beq.s	loc3_43322
		subq.w	#1,$2E(a0)
		bsr.w	SonicOnSegaScr_Move_Streaks_Right

loc3_43322:
		lea	byte_4346A(pc),a1
		bsr.w	sub_433A6
		bne.s	loc3_4332E
		rts
; ---------------------------------------------------------------------------

loc3_4332E:
		addq.b	#2,routine(a0)
		st	(_unkF660).w
		move.b	#cmd_S2SEGA,d0
		jsr	(Play_SFX).l

locret3_43340:
		rts
; ---------------------------------------------------------------------------

ObjB1:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	ObjB1_Index(pc,d0.w),d1
		jmp	ObjB1_Index(pc,d1.w)
; ---------------------------------------------------------------------------
ObjB1_Index:
		dc.w ObjB1_Init-ObjB1_Index
		dc.w ObjB1_Main-ObjB1_Index
; ---------------------------------------------------------------------------

ObjB1_Init:
		lea	ObjDat3_434EA(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#0,render_flags(a0)
		move.b	#4,mapping_frame(a0)
		move.w	#$174,x_pos(a0)
		move.w	#$D8,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

ObjB1_Main:
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


SonicOnSegaScr_Move_Streaks_Left:
		lea	(H_scroll_buffer+$138).w,a1
		move.w	#35-1,d6

loc3_43386:
		subi.w	#$20,(a1)
		addq.w	#8,a1
		dbf	d6,loc3_43386
		rts
; End of function SonicOnSegaScr_Move_Streaks_Left


; =============== S U B R O U T I N E =======================================


SonicOnSegaScr_Move_Streaks_Right:
		lea	(H_scroll_buffer+$13C).w,a1
		move.w	#35-1,d6

loc3_4339A:
		addi.w	#$20,(a1)
		addq.w	#8,a1
		dbf	d6,loc3_4339A
		rts
; End of function SonicOnSegaScr_Move_Streaks_Right


; =============== S U B R O U T I N E =======================================


sub_433A6:
		subq.b	#1,$30(a0)
		bne.s	loc3_433EC
		moveq	#0,d0
		move.b	$31(a0),d0
		addq.b	#1,d0
		cmp.b	1(a1),d0
		bcs.s	loc3_433C0
		tst.b	3(a1)
		bne.s	loc3_433F0

loc3_433C0:
		move.b	d0,$31(a0)
		move.b	(a1),$30(a0)
		lea	6(a1),a2
		moveq	#0,d1
		move.b	2(a1),d1
		move.w	d1,d2
		tst.w	d0
		beq.s	loc3_433E2

loc3_433D8:
		subq.b	#1,d0
		beq.s	loc3_433E0
		add.w	d2,d1
		bra.s	loc3_433D8
; ---------------------------------------------------------------------------

loc3_433E0:
		adda.w	d1,a2

loc3_433E2:
		movea.w	4(a1),a3

loc3_433E6:
		move.w	(a2)+,(a3)+
		subq.w	#2,d2
		bne.s	loc3_433E6

loc3_433EC:
		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------

loc3_433F0:
		moveq	#1,d0
		rts
; End of function sub_433A6

; ---------------------------------------------------------------------------
byte_433F4:
		dc.b    4
		dc.b    7
		dc.b  $10
		dc.b  $FF
		dc.w Normal_palette+$10
		binclude "General/S2Menu/Palettes/Sega Screen 2.bin"
byte_4346A:
		dc.b    4
		dc.b    7
		dc.b  $10
		dc.b  $FF
		dc.w Normal_palette
		binclude "General/S2Menu/Palettes/Sega Screen 3.bin"
ObjDat3_434E0:
		dc.l Map_SonicOnSegaScr
		dc.w make_art_tile(ArtTile_S2Sega+8,2,1)
		dc.w    $80
		dc.b  $10
		dc.b    0
ObjDat3_434EA:
		dc.l Map_SonicOnSegaScr
		dc.w make_art_tile($003,0,0)
		dc.w   $100
		dc.b    8
		dc.b    0
Ani_SonicOnSegaScr:
		include "General/S2Menu/Anim - Sonic On Sega Screen.asm"
Map_SonicOnSegaScr:
		include "General/S2Menu/Map - Sonic On Sega Screen.asm"

; =============== S U B R O U T I N E =======================================


SegaScr_VInt:
		move.w	(_unkF662).w,d0
		beq.w	locret3_432D8
		clr.w	(_unkF662).w
		move.w	SegaScr_VInt_Index-2(pc,d0.w),d0
		jmp	SegaScr_VInt_Index(pc,d0.w)
; End of function SegaScr_VInt

; ---------------------------------------------------------------------------
SegaScr_VInt_Index:
		dc.w loc3_435C4-SegaScr_VInt_Index
		dc.w loc3_435F6-SegaScr_VInt_Index
; ---------------------------------------------------------------------------

loc3_435C4:
		dma68kToVDP $FF0B00,$1100,$2C00,VRAM
		lea	ObjB1_Streak_fade_to_right(pc),a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$950,VRAM,WRITE),d0
		bra.w	loc3_43632
; ---------------------------------------------------------------------------

loc3_435F6:
		dmaFillVRAM 0,VRAM_Plane_A_Name_Table,$2000
		lea	ObjB1_Streak_fade_to_left(pc),a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$9A0,VRAM,WRITE),d0
		bra.w	loc3_43632
; ---------------------------------------------------------------------------

loc3_43632:
		lea	(VDP_data_port).l,a6
		move.l	#$100<<16,d6
		moveq	#8-1,d1
		moveq	#$A-1,d2

loc3_43642:
		move.l	d0,4(a6)
		move.w	d1,d3
		movea.l	a1,a2

loc3_4364A:
		move.w	(a2)+,d4
		bclr	#$A,d4
		beq.s	loc3_43656
		bsr.w	sub_43664

loc3_43656:
		move.w	d4,(a6)
		dbf	d3,loc3_4364A
		add.l	d6,d0
		dbf	d2,loc3_43642
		rts

; =============== S U B R O U T I N E =======================================


sub_43664:
		moveq	#bytesToWcnt($52),d5

loc3_43666:
		move.w	d4,(a6)
		dbf	d5,loc3_43666
		rts
; End of function sub_43664

; ---------------------------------------------------------------------------
ObjB1_Streak_fade_to_right:
		dc.w make_art_tile(ArtTile_S2Sega+0,1,1)
		dc.w make_art_tile(ArtTile_S2Sega+1,1,1)
		dc.w make_art_tile(ArtTile_S2Sega+2,1,1)
		dc.w make_art_tile(ArtTile_S2Sega+3,1,1)
		dc.w make_art_tile(ArtTile_S2Sega+4,1,1)
		dc.w make_art_tile(ArtTile_S2Sega+5,1,1)
		dc.w make_art_tile(ArtTile_S2Sega+6,1,1)
		dc.w make_art_tile(ArtTile_S2Sega+7,1,1)|(1<<$A)
ObjB1_Streak_fade_to_left:
		dc.w make_art_tile(ArtTile_S2Sega+7,1,1)|(1<<$A)
		dc.w make_art_tile(ArtTile_S2Sega+6,1,1)
		dc.w make_art_tile(ArtTile_S2Sega+5,1,1)
		dc.w make_art_tile(ArtTile_S2Sega+4,1,1)
		dc.w make_art_tile(ArtTile_S2Sega+3,1,1)
		dc.w make_art_tile(ArtTile_S2Sega+2,1,1)
		dc.w make_art_tile(ArtTile_S2Sega+1,1,1)
		dc.w make_art_tile(ArtTile_S2Sega+0,1,1)
Streak_Horizontal_offsets:
		dc.b  $12
		dc.b    4
		dc.b    4
		dc.b    2
		dc.b    2
		dc.b    2
		dc.b    2
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    4
		dc.b    4
		dc.b    6
		dc.b   $A
		dc.b    8
		dc.b    6
		dc.b    4
		dc.b    4
		dc.b    4
		dc.b    4
		dc.b    6
		dc.b    6
		dc.b    8
		dc.b    8
		dc.b   $A
		dc.b   $A
		dc.b   $C
		dc.b   $E
		dc.b  $10
		dc.b  $16
		dc.b    0
		even

; =============== S U B R O U T I N E =======================================


Scale_2x:
		move.w	d1,d2
		andi.w	#1,d2
		addq.w	#1,d2
		lsl.w	#6,d2
		swap	d2
		move.w	d1,d3
		lsr.w	#1,d3
		addq.w	#1,d3
		lsl.w	#6,d3
		swap	d3
		bsr.w	sub_436DE
		btst	#1,d0
		beq.w	locret3_432D8
		btst	#1,d1
		bne.s	loc3_436DC
		movea.l	a3,a5

loc3_436DC:
		movea.l	a5,a2
; End of function Scale_2x


; =============== S U B R O U T I N E =======================================


sub_436DE:
		movea.l	a2,a4
		swap	d2
		lea	(a2,d2.w),a3
		swap	d2
		move.w	d1,d5
		andi.w	#1,d5
		bsr.w	Scale2x_SingleTile
		btst	#1,d1
		beq.s	loc3_4371A
		swap	d2
		move.w	d2,d4
		swap	d2
		add.w	d4,d4
		move.w	d0,d3
		andi.w	#1,d3
		lsl.w	d3,d4
		adda.w	d4,a4
		move.w	d1,d5
		lsr.w	#1,d5
		swap	d3
		lea	(a4,d3.w),a5
		swap	d3
		bsr.w	Scale2x_SingleTile2

loc3_4371A:
		btst	#0,d0
		bne.s	loc3_43726
		btst	#1,d0
		beq.s	locret3_43756

loc3_43726:
		swap	d2
		lea	(a2,d2.w),a2
		lea	(a2,d2.w),a3
		swap	d2
		move.w	d1,d5
		andi.w	#1,d5
		bsr.w	Scale2x_SingleTile
		btst	#1,d1
		beq.s	locret3_43756
		move.w	d1,d5
		lsr.w	#1,d5
		swap	d3
		lea	(a4,d3.w),a4
		lea	(a4,d3.w),a5
		swap	d3
		bsr.w	Scale2x_SingleTile2

locret3_43756:
		rts
; End of function sub_436DE


; =============== S U B R O U T I N E =======================================


Scale2x_SingleTile:
		moveq	#8-1,d6

.loop:
		bsr.w	Scale_2x_LeftPixels
		addq.w	#4,a2
		bsr.w	Scale_2x_RightPixels
		addq.w	#4,a3
		dbf	d6,.loop
		dbf	d5,Scale2x_SingleTile
		rts
; End of function Scale2x_SingleTile


; =============== S U B R O U T I N E =======================================


Scale2x_SingleTile2:
		moveq	#8-1,d6

.loop:
		bsr.w	Scale_2x_LeftPixels2
		addq.w	#4,a4
		bsr.w	Scale_2x_RightPixels2
		addq.w	#4,a5
		dbf	d6,.loop
		dbf	d5,Scale2x_SingleTile2
		rts
; End of function Scale2x_SingleTile2


; =============== S U B R O U T I N E =======================================


Scale_2x_LeftPixels:
		bsr.w	loc3_4378C

loc3_4378C:
		move.b	(a1)+,d2
		move.b	d2,d3
		andi.b	#$F0,d2
		move.b	d2,d4
		lsr.b	#4,d4
		or.b	d2,d4
		move.b	d4,(a2)+
		move.b	d4,3(a2)
		andi.b	#$F,d3
		move.b	d3,d4
		lsl.b	#4,d4
		or.b	d3,d4
		move.b	d4,(a2)+
		move.b	d4,3(a2)
		rts
; End of function Scale_2x_LeftPixels


; =============== S U B R O U T I N E =======================================


Scale_2x_RightPixels:
		bsr.w	loc3_437B6

loc3_437B6:
		move.b	(a1)+,d2
		move.b	d2,d3
		andi.b	#$F0,d2
		move.b	d2,d4
		lsr.b	#4,d4
		or.b	d2,d4
		move.b	d4,(a3)+
		move.b	d4,3(a3)
		andi.b	#$F,d3
		move.b	d3,d4
		lsl.b	#4,d4
		or.b	d3,d4
		move.b	d4,(a3)+
		move.b	d4,3(a3)
		rts
; End of function Scale_2x_RightPixels


; =============== S U B R O U T I N E =======================================


Scale_2x_LeftPixels2:
		bsr.w	loc3_437E0

loc3_437E0:
		move.b	(a1)+,d2
		move.b	d2,d3
		andi.b	#$F0,d2
		move.b	d2,d4
		lsr.b	#4,d4
		or.b	d2,d4
		move.b	d4,(a4)+
		move.b	d4,3(a4)
		andi.b	#$F,d3
		move.b	d3,d4
		lsl.b	#4,d4
		or.b	d3,d4
		move.b	d4,(a4)+
		move.b	d4,3(a4)
		rts
; End of function Scale_2x_LeftPixels2


; =============== S U B R O U T I N E =======================================


Scale_2x_RightPixels2:
		bsr.w	loc3_4380A

loc3_4380A:
		move.b	(a1)+,d2
		move.b	d2,d3
		andi.b	#$F0,d2
		move.b	d2,d4
		lsr.b	#4,d4
		or.b	d2,d4
		move.b	d4,(a5)+
		move.b	d4,3(a5)
		andi.b	#$F,d3
		move.b	d3,d4
		lsl.b	#4,d4
		or.b	d3,d4
		move.b	d4,(a5)+
		move.b	d4,3(a5)
		rts
; End of function Scale_2x_RightPixels2