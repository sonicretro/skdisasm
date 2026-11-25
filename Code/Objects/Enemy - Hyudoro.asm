; ' <-- lol TextWrangler; it assumes ' is the string delimiter for all assembly files; I don't want
;     my screen to be filled with pink
; ---------------------------------------------------------------------------

; original label: gost08
; Obj_SOZGhosts:
Hyudoro:
		move.l	#Hyudoro_ctr,(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$A0,y_pos(a0)

; locK_8F0CA:
Hyudoro_ctr:
		cmpi.b	#2,(Player_1+character_id).w ; Is the player character Knuckles?
		beq.s	._100
		tst.b	(Last_star_post_hit).w
		beq.w	return

; locK_8F0DA:
._100:
		moveq	#0,d0
		move.b	(SOZ_darkness_level).w,d0
		beq.s	.clr_ret
		move.b	.cnt_tbl(pc,d0.w),d0
		move.b	(Hyudoro_count).w,d1
		cmp.b	d0,d1
		bhs.w	return
		subq.w	#1,$3A(a0)
		bpl.w	return
		addq.b	#1,d1
		move.b	d1,(Hyudoro_count).w
		cmp.b	d0,d1
		bhs.s	._200
		move.w	#$3F,$3A(a0)

; locK_8F108:
._200:
		lea	Hyudoro_body_set_tbl(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

; locK_8F112:
.clr_ret:
		clr.b	(Hyudoro_count).w
		rts
; ---------------------------------------------------------------------------

; byteK_8F118:
.cnt_tbl:
		dc.b    0,   1,   2,   2,   3,   3
		even
; ---------------------------------------------------------------------------

; locK_8F11E:
Hyudoro_body:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.act_tbl(pc,d0.w),d1
		jsr	.act_tbl(pc,d1.w)
		lea	Hyudoro_DPLC_tbl(pc),a2
		jsr	(Perform_DPLC).l
		tst.b	render_flags(a0)
		bpl.s	.fout0
		tst.b	(SOZ_darkness_level).w
		beq.s	.fout1
		jsr	(Check_PlayerCollision).l
		beq.s	._100
		jsr	(Check_PlayerAttack).l
		bne.s	.fout1
		tst.b	invulnerability_timer(a1)
		bne.s	._100
		jsr	(HurtCharacter_Directly).l

; locK_8F15E:
._100:
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

; locK_8F16A:
.fout0:
		subq.b	#1,(Hyudoro_count).w
		jmp	(Go_Delete_SpriteSlotted2).l
; ---------------------------------------------------------------------------

; locK_8F174:
.fout1:
		move.l	#Hyudoro_body_fout0,(a0)
		move.l	#.fout0,$34(a0)
		lea	Hyudoro_away_pg00(pc),a1
		jsr	(Set_Raw_Animation).l
		moveq	#signextendB(sfx_Bouncy),d0
		jsr	(Play_SFX).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

; offK_8F19A:
.act_tbl:
		dc.w Hyudoro_init-.act_tbl
		dc.w Hyudoro_wait0-.act_tbl
		dc.w Hyudoro_move0-.act_tbl
		dc.w Hyudoro_chg0-.act_tbl
		dc.w Hyudoro_chg1-.act_tbl
		dc.w Hyudoro_chg2-.act_tbl
		dc.w Hyudoro_atak0-.act_tbl
		dc.w Hyudoro_atak1-.act_tbl
		dc.w Hyudoro_atak2-.act_tbl
; ---------------------------------------------------------------------------

; locK_8F1AC:
Hyudoro_init:
		lea	Hyudoro_init_tbl(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		bclr	#2,render_flags(a0)
		bset	#7,render_flags(a0)
		move.b	(SOZ_darkness_level).w,child_dx(a0)
		move.b	(Hyudoro_count).w,child_dy(a0)
		bsr.w	set_Hyudoro_body_init
		moveq	#signextendB(sfx_GhostAppear),d0
		jsr	(Play_SFX).l

; locK_8F1DA:
Hyudoro_wait0:
		jsr	(Animate_RawMultiDelay).l
		tst.w	d2
		beq.s	.ret
		cmpi.b	#5,(SOZ_darkness_level).w
		beq.s	Hyudoro_atak_init
		move.b	#4,routine(a0)

; locretK_8F1F2:
.ret:
		rts
; ---------------------------------------------------------------------------

; locK_8F1F4:
Hyudoro_atak_init:
		move.b	#$C,routine(a0)
		bra.w	set_puka_init
; ---------------------------------------------------------------------------

; locK_8F1FE:
Hyudoro_move0:
		jsr	(Animate_RawMultiDelay).l
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		bsr.w	chk_Hyudoro_limit
		move.b	(SOZ_darkness_level).w,d0
		cmp.b	child_dx(a0),d0
		beq.s	.ret

.next:
		move.b	#6,routine(a0)

; locretK_8F224:
.ret:
		rts
; ---------------------------------------------------------------------------

; locK_8F226:
Hyudoro_chg0:
		jsr	(Animate_RawMultiDelay).l
		jsr	(Swing_UpAndDown).l
		tst.w	d3
		bne.s	.next
		jsr	(MoveSprite2).l
		bra.w	chk_Hyudoro_limit
; ---------------------------------------------------------------------------

; locK_8F240:
.next:
		move.b	#8,routine(a0)
		moveq	#0,d0
		move.b	(SOZ_darkness_level).w,d0
		move.b	.chk_puka_tbl(pc,d0.w),d1
		beq.w	return
		move.b	d0,child_dx(a0)
		cmpi.b	#5,d0
		beq.s	Hyudoro_atak_init
		move.b	#4,routine(a0)
		bra.w	set_puka_init
; ---------------------------------------------------------------------------

; byteK_8F268:
.chk_puka_tbl:
		dc.b    0,   0,   0,   1,   0,   1
		even
; ---------------------------------------------------------------------------

; locK_8F26E:
Hyudoro_chg1:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		bsr.w	chk_Hyudoro_limit
		jsr	(Animate_RawMultiDelay).l
		beq.s	.ret
		cmpi.b	#2,anim_frame(a0)
		bne.s	.ret

.next:
		move.b	#$A,routine(a0)
		move.b	(SOZ_darkness_level).w,d0
		move.b	d0,child_dx(a0)
		add.w	d0,d0
		andi.w	#$C,d0
		movea.l	.pg_tbl(pc,d0.w),a1
		move.b	(a1),mapping_frame(a0)
		jsr	(Set_Raw_Animation).l

; locretK_8F2B0:
.ret:
		rts
; ---------------------------------------------------------------------------

; offK_8F2B2:
.pg_tbl:
		dc.l Hyudoro_chg_pg00
		dc.l Hyudoro_chg_pg00
		dc.l Hyudoro_chg_pg01
; ---------------------------------------------------------------------------

; locK_8F2BE:
Hyudoro_chg2:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		bsr.w	chk_Hyudoro_limit
		jsr	(Animate_RawMultiDelay).l
		tst.w	d2
		beq.s	.ret

.next:
		move.b	#4,routine(a0)

; locretK_8F2DE:
.ret:
		rts
; ---------------------------------------------------------------------------

; locK_8F2E0:
Hyudoro_atak0:
		jsr	(Animate_RawMultiDelay).l
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		move.w	x_pos(a0),d0
		tst.w	x_vel(a0)
		bmi.s	.chk_l

.chk_r:
		cmpi.w	#$1A0,d0
		bhi.s	.neg
		rts
; ---------------------------------------------------------------------------

; locK_8F304:
.chk_l:
		cmpi.w	#$A0,d0
		bhs.s	.ret

; locK_8F30A:
.neg:
		move.b	#$E,routine(a0)
		bchg	#0,render_flags(a0)
		neg.w	x_vel(a0)
		move.w	#60-1,$2E(a0)

; locretK_8F320:
.ret:
		rts
; ---------------------------------------------------------------------------

; locK_8F322:
Hyudoro_atak1:
		jsr	(Animate_RawMultiDelay).l
		subq.w	#1,$2E(a0)
		bpl.w	return

.next:
		move.b	#$10,routine(a0)
		move.b	#$D7,collision_flags(a0)
		bset	#2,render_flags(a0)
		move.w	(Camera_X_pos).w,d0
		move.w	x_pos(a0),d1
		subi.w	#$80,d1
		add.w	d1,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		move.w	y_pos(a0),d1
		subi.w	#$80,d1
		add.w	d1,d0
		move.w	d0,y_pos(a0)
		move.w	#$100,y_vel(a0)

.ret:
		rts
; ---------------------------------------------------------------------------

; locK_8F36E:
Hyudoro_atak2:
		jsr	(Animate_RawMultiDelay).l
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

; locK_8F37A:
Hyudoro_body_fout0:
		jsr	(Animate_RawMultiDelay).l
		lea	Hyudoro_DPLC_tbl(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

; Obj_SOZGhostCapsuleLoadArt:
set_SOZ_capsule_Hyudoro_cg:
		moveq	#0,d0
		move.b	subtype(a0),d0
		movea.l	.col_tbl(pc,d0.w),a1
		jsr	(Check_PlayerInRange).l
		tst.l	d0
		beq.w	return
		tst.w	d0
		beq.w	return
		moveq	#0,d0
		move.b	subtype(a0),d0
		movea.l	.jmp_tbl(pc,d0.w),a1
		jsr	(a1)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

; offK_8F3BE:
.col_tbl:
		dc.l col_tbl_00
		dc.l col_tbl_04

; offK_8F3C6:
.jmp_tbl:
		dc.l set_soz_capsule_cg
		dc.l set_soz_enemy_cg

; wordK_8F3CE:
col_tbl_00:
		dc.w   -$10,   $20,  -$40,   $80

; wordK_8F3D6:
col_tbl_04:
		dc.w   -$10,   $20,  -$80,  $100
; ---------------------------------------------------------------------------

; original label: set_openbox_cg
; locK_8F3DE:
set_soz_capsule_cg:
		lea	PLC_SOZGhostCapsule(pc),a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------

PLC_SOZGhostCapsule: plrlistheader
		plreq ArtTile_SOZGhostCapsule, ArtNem_EggCapsule
PLC_SOZGhostCapsule_End
; ---------------------------------------------------------------------------

; original label: set_emy08_cg
; locK_8F3F0:
set_soz_enemy_cg:
		jmp	(LoadEnemyArt).l
; ---------------------------------------------------------------------------

; original label: obox08
; Obj_SOZGhostCapsule:
SOZ_capsule:
		lea	SOZ_capsule_init_tbl(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_89C14,(a0)
		move.b	#3,subtype(a0)
		lea	SOZ_capsule_switch_set_tbl(pc),a2
		jsr	(CreateChild1_Normal).l
		tst.b	(Last_star_post_hit).w
		bne.s	._100
		cmpi.b	#2,(Player_1+character_id).w ; Is the player character Knuckles?
		bne.s	return

; locK_8F424:
._100:
		move.l	#loc_89C54,(a0)
		move.b	#1,mapping_frame(a0)
		bset	#5,$38(a0)

; locretK_8F436:
return:
		rts
; ---------------------------------------------------------------------------

; locK_8F438:
SOZ_capsule_switch:
		lea	(word_86B3E).l,a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_8672A,(a0)
		tst.b	(Last_star_post_hit).w
		beq.s	.ret
		move.l	#loc_86754,(a0)
		move.b	#$C,mapping_frame(a0)

; locretK_8F45C:
.ret:
		rts
; ---------------------------------------------------------------------------

; locK_8F45E:
SOZ_capsule_Hyudoro:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.act_tbl(pc,d0.w),d1
		jsr	.act_tbl(pc,d1.w)
		tst.b	subtype(a0)
		bne.s	._100
		lea	Hyudoro_DPLC_tbl(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Sprite_CheckDeleteSlotted).l
; ---------------------------------------------------------------------------

; locK_8F482:
._100:
		jmp	(Sprite_CheckDelete).l
; ---------------------------------------------------------------------------

; offK_8F488:
.act_tbl:
		dc.w SOZ_capsule_Hyudoro_init-.act_tbl
		dc.w SOZ_capsule_Hyudoro_move0-.act_tbl
		dc.w SOZ_capsule_Hyudoro_move1-.act_tbl
; ---------------------------------------------------------------------------

; locK_8F48E:
SOZ_capsule_Hyudoro_init:
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		lea	.spd_tbl(pc,d0.w),a1
		move.w	(a1)+,x_vel(a0)
		move.w	(a1)+,$40(a0)
		jsr	(Change_FlipXWithVelocity).l
		tst.w	d0
		bne.s	._100
		lea	Hyudoro_init_tbl(pc),a1
		jmp	(SetUp_ObjAttributesSlotted).l
; ---------------------------------------------------------------------------

; locK_8F4B6:
._100:
		lea	SOZ_capsule_Hyudoro_init_tbl(pc),a1
		jmp	(SetUp_ObjAttributes).l
; ---------------------------------------------------------------------------

; wordK_8F4C0:
.spd_tbl:
		dc.w  -$200,  -$20
		dc.w   $200,  -$20
		dc.w  -$280,  -$18
		dc.w   $280,  -$18
		dc.w  -$300,  -$10
		dc.w   $300,  -$10
; ---------------------------------------------------------------------------

; locK_8F4D8:
SOZ_capsule_Hyudoro_move0:
		lea	Hyudoro_pg00(pc),a1
		jsr	(Animate_RawNoSST).l

; locK_8F4E2:
SOZ_capsule_Hyudoro_move1:
		move.w	$40(a0),d0
		add.w	d0,y_vel(a0)
		jmp	(MoveSprite2).l

; =============== S U B R O U T I N E =======================================


; subK_8F4F0:
chk_Hyudoro_limit:
		move.w	x_pos(a0),d0
		tst.w	x_vel(a0)
		bmi.s	.chk_l

.chk_r:
		cmpi.w	#$1A0,d0
		bhi.s	.neg
		rts
; ---------------------------------------------------------------------------

; locK_8F502:
.chk_l:
		cmpi.w	#$A0,d0
		bhs.s	.ret

; locK_8F508:
.neg:
		bchg	#0,render_flags(a0)
		neg.w	x_vel(a0)

; locretK_8F512:
.ret:
		rts
; ---------------------------------------------------------------------------

; locK_8F514:
set_Hyudoro:
		move.b	#1,(Last_star_post_hit).w
		lea	(SOZ2_Start).l,a1
		move.w	(a1)+,(Saved_X_pos).w
		move.w	(a1)+,(Saved_Y_pos).w
		jsr	(Save_Level_Data).l
		lea	SOZ_capsule_Hyudoro_set_tbl(pc),a2
		jmp	(CreateChild1_Normal).l

; =============== S U B R O U T I N E =======================================


; subK_8F538:
set_Hyudoro_body_init:
		jsr	(Random_Number).l
		andi.w	#$FF,d0
		subi.w	#$7F,d0
		add.w	d0,x_pos(a0)
		moveq	#0,d1
		move.b	(SOZ_darkness_level).w,d1
		add.w	d1,d1
		move.w	Hyudoro_init_spd_tbl(pc,d1.w),d2
		cmpi.w	#$120,d0
		bhs.s	._100
		bset	#0,render_flags(a0)
		neg.w	d2

; locK_8F564:
._100:
		move.w	d2,x_vel(a0)
		andi.w	#$C,d1
		move.l	.pg_tbl(pc,d1.w),$30(a0)
		bra.w	set_puka_init
; ---------------------------------------------------------------------------

; offK_8F576:
.pg_tbl:
		dc.l Hyudoro_apar_pg00
		dc.l Hyudoro_apar_pg01
		dc.l Hyudoro_apar_pg02
; ---------------------------------------------------------------------------

; wordK_8F582:
Hyudoro_init_spd_tbl:
		dc.w  -$100
		dc.w  -$100
		dc.w  -$100
		dc.w  -$180
		dc.w  -$180
		dc.w  -$200
; ---------------------------------------------------------------------------

; locK_8F58E:
set_puka_init:
		moveq	#0,d0
		move.b	(SOZ_darkness_level).w,d0
		add.w	d0,d0
		move.w	Hyudoro_init_spd_tbl(pc,d0.w),d1
		tst.w	x_vel(a0)
		bmi.s	._100
		neg.w	d1

; locK_8F5A2:
._100:
		move.w	d1,x_vel(a0)
		add.w	d0,d0
		movea.l	.puka_tbl(pc,d0.w),a1
		bclr	#0,$38(a0)
		jsr	(a1)
		tst.w	y_vel(a0)
		bpl.s	._200
		bset	#0,$38(a0)
		neg.w	d0

; locK_8F5C2:
._200:
		move.w	d0,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

; offK_8F5C8:
.puka_tbl:
		dc.l puka_init_00
		dc.l puka_init_00
		dc.l puka_init_00
		dc.l puka_init_01
		dc.l puka_init_01
		dc.l puka_init_02
; ---------------------------------------------------------------------------

; locK_8F5E0:
puka_init_00:
		move.w	#$40,d0
		move.w	d0,$3E(a0)
		move.w	#4,$40(a0)
		rts
; ---------------------------------------------------------------------------

; locK_8F5F0:
puka_init_01:
		move.w	#$80,d0
		move.w	d0,$3E(a0)
		move.w	#8,$40(a0)
		bclr	#0,$38(a0)
		rts
; ---------------------------------------------------------------------------

; locK_8F606:
puka_init_02:
		move.w	#$C0,d0
		move.w	d0,$3E(a0)
		move.w	#$10,$40(a0)
		bclr	#0,$38(a0)
		rts
; ---------------------------------------------------------------------------

; ObjSlot_SOZGhosts:
Hyudoro_init_tbl:
		dc.w 3-1
		dc.w make_art_tile(ArtTile_SOZGhosts,1,1)
		dc.w    $12
		dc.w      0
		dc.l Map_SOZGhosts
		dc.w      0
		dc.b  $10, $14,   0,   0

; ObjDat_SOZGhostCapsule:
SOZ_capsule_init_tbl:
		dc.l Map_EggCapsule
		dc.w make_art_tile(ArtTile_SOZGhostCapsule,0,1)
		dc.w   $180
		dc.b  $30, $20,   0,   0

; ObjDat3_8F63A:
SOZ_capsule_Hyudoro_init_tbl:
		dc.l Map_SOZGhosts
		dc.w make_art_tile(ArtTile_SOZGhosts,1,1)
		dc.w   $200
		dc.b  $30, $20,   0,   0

; ChildObjDat_8F646:
SOZ_capsule_switch_set_tbl:
		dc.w 1-1
		dc.l SOZ_capsule_switch
		dc.b    0,-$24

; ChildObjDat_8F64E:
SOZ_capsule_Hyudoro_set_tbl:
		dc.w 6-1
		dc.l SOZ_capsule_Hyudoro
		dc.b   -8,  -4
		dc.l SOZ_capsule_Hyudoro
		dc.b    8,  -4
		dc.l SOZ_capsule_Hyudoro
		dc.b  $10,  -4
		dc.l SOZ_capsule_Hyudoro
		dc.b -$10,  -4
		dc.l SOZ_capsule_Hyudoro
		dc.b  $18,  -4
		dc.l SOZ_capsule_Hyudoro
		dc.b -$18,  -4

; ChildObjDat_8F674:
Hyudoro_body_set_tbl:
		dc.w 1-1
		dc.l Hyudoro_body

; DPLCPtr_SOZGhosts:
Hyudoro_DPLC_tbl:
		dc.l ArtUnc_SOZGhosts
		dc.l DPLC_SOZGhosts

; byteK_8F682:
Hyudoro_apar_pg00:
		dc.b  $11,   3
		dc.b  $11,   3
		dc.b  $10,   3
		dc.b   $F,   4
		dc.b   $E,   4
		dc.b  $F8, Hyudoro_pg00-Hyudoro_apar_pg00

; byteK_8F68E:
Hyudoro_pg00:
		dc.b    0,   3,   1,   3,   2,   4, $FC

; byteK_8F695:
Hyudoro_apar_pg01:
		dc.b  $11,   3
		dc.b  $11,   3
		dc.b  $10,   3
		dc.b   $F,   4
		dc.b   $E,   4
		dc.b   $D,   4
		dc.b  $F8, Hyudoro_pg01-Hyudoro_apar_pg01

Hyudoro_pg01:
		dc.b    5,   3
		dc.b    6,   3
		dc.b    7,   4
		dc.b  $FC

; byteK_8F6AA:
Hyudoro_apar_pg02:
		dc.b  $11,   3
		dc.b  $11,   3
		dc.b  $10,   3
		dc.b   $F,   4
		dc.b   $E,   4
		dc.b   $D,   4
		dc.b  $F8, Hyudoro_pg02-Hyudoro_apar_pg02

Hyudoro_pg02:
		dc.b   $A,   3
		dc.b   $B,   3
		dc.b   $C,   4
		dc.b  $FC

; byteK_8F6BF:
Hyudoro_away_pg00:
		dc.b   $D,   4
		dc.b   $D,   4
		dc.b   $E,   4
		dc.b   $F,   4
		dc.b  $10,   3
		dc.b  $11,   3
		dc.b  $F4

; byteK_8F6CC:
Hyudoro_chg_pg00:
		dc.b    3,   7
		dc.b    3,   7
		dc.b    4,   7
		dc.b  $F8, Hyudoro_pg01-Hyudoro_chg_pg00

; byteK_8F6D4:
Hyudoro_chg_pg01:
		dc.b    8,   7
		dc.b    8,   7
		dc.b    9,   7
		dc.b  $F8, Hyudoro_pg02-Hyudoro_chg_pg01

DPLC_SOZGhosts:
		include "General/Sprites/SOZ Ghosts/DPLC - SOZ Ghosts.asm"