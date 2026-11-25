; ---------------------------------------------------------------------------

Obj_SphereTest:
		lea	(word3_2382C).l,a6
		movea.l	a0,a1
		move.l	#Obj_SphereTest_Main,(a1)
		cmpi.b	#1,subtype(a0)
		beq.w	loc3_23398
		cmpi.b	#2,subtype(a0)
		beq.w	loc3_23556
		tst.b	(Ctrl_2).w
		bne.w	loc3_23556

loc3_23398:
		moveq	#0,d2
		moveq	#$E-1,d3
		tst.w	(Sphere_test_address).w
		bne.s	loc3_233D6
		move.w	a0,(Sphere_test_address).w
		move.w	#0,(_unkE412).w
		move.w	#0,(_unkE414).w
		move.w	#$200,(_unkE416).w
		move.w	#0,(SStage_scalar_index_0).w
		move.w	#0,(SStage_scalar_index_1).w
		move.w	#0,(SStage_scalar_index_2).w
		bra.s	loc3_233DC
; ---------------------------------------------------------------------------

loc3_233CC:
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc3_234E0

loc3_233D6:
		move.l	#Obj_EosianSphere,(a1)

loc3_233DC:
		bsr.w	sub3_23500
		bsr.w	sub3_23540
		move.w	d2,d0
		addi.w	#$10,d2
		jsr	(GetSineCosine).l
		asr.w	#1,d0
		asr.w	#1,d1
		move.w	d1,$34(a1)
		move.w	d0,$36(a1)
		move.w	#-$20,$38(a1)
		move.l	a6,$3A(a1)
		adda.w	#$10,a6
		dbf	d3,loc3_233CC
		moveq	#0,d2
		moveq	#$E-1,d3

loc3_23412:
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc3_234E0
		move.l	#Obj_EosianSphere,(a1)
		bsr.w	sub3_23500
		bsr.w	sub3_23540
		move.w	d2,d0
		addi.w	#$10,d2
		jsr	(GetSineCosine).l
		asr.w	#1,d0
		asr.w	#1,d1
		move.w	d1,$34(a1)
		move.w	d0,$36(a1)
		move.w	#$20,$38(a1)
		move.l	a6,$3A(a1)
		adda.w	#$10,a6
		dbf	d3,loc3_23412
		moveq	#0,d2
		moveq	#$E-1,d3

loc3_23458:
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc3_234E0
		move.l	#Obj_EosianSphere,(a1)
		bsr.w	sub3_23500
		bsr.w	sub3_23540
		move.w	d2,d0
		addi.w	#$10,d2
		jsr	(GetSineCosine).l
		asr.w	#1,d0
		asr.w	#1,d1
		move.w	#$20,$34(a1)
		move.w	d0,$36(a1)
		move.w	d1,$38(a1)
		move.l	a6,$3A(a1)
		adda.w	#$10,a6
		dbf	d3,loc3_23458
		moveq	#0,d2
		moveq	#$E-1,d3

loc3_2349E:
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc3_234E0
		move.l	#Obj_EosianSphere,(a1)
		bsr.w	sub3_23500
		bsr.w	sub3_23540
		move.w	d2,d0
		addi.w	#$10,d2
		jsr	(GetSineCosine).l
		asr.w	#1,d0
		asr.w	#1,d1
		move.w	#-$20,$34(a1)
		move.w	d0,$36(a1)
		move.w	d1,$38(a1)
		move.l	a6,$3A(a1)
		adda.w	#$10,a6
		dbf	d3,loc3_2349E

loc3_234E0:
		lea	(Pal_SphereTest).l,a1
		lea	(Normal_palette_line_2).w,a2
		move.w	#bytesToWcnt($20),d0

loc3_234EE:
		move.w	(a1)+,(a2)+
		dbf	d0,loc3_234EE
		moveq	#PLCID_09,d0
		jsr	(Load_PLC).l
		bra.w	Obj_SphereTest_Main

; =============== S U B R O U T I N E =======================================


sub3_23500:
		move.b	#4,render_flags(a1)
		move.b	#$10,width_pixels(a1)
		move.b	#$10,height_pixels(a1)
		move.w	#$200,priority(a1)
		move.l	#Map_SphereTest,mappings(a1)
		move.w	#make_art_tile(ArtTile_SphereTest,1,0),art_tile(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	x_pos(a0),$30(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.w	y_pos(a0),$32(a1)
		rts
; End of function sub3_23500


; =============== S U B R O U T I N E =======================================


sub3_23540:
		cmpi.w	#$40,d2
		bne.s	loc3_2354A
		addi.w	#$10,d2

loc3_2354A:
		cmpi.w	#$C0,d2
		bne.s	locret3_23554
		addi.w	#$10,d2

locret3_23554:
		rts
; End of function sub3_23540

; ---------------------------------------------------------------------------

loc3_23556:
		moveq	#0,d2
		moveq	#$10-1,d3
		tst.w	(Sphere_test_address).w
		bne.s	loc3_23594
		move.w	a0,(Sphere_test_address).w
		move.w	#0,(_unkE412).w
		move.w	#0,(_unkE414).w
		move.w	#$200,(_unkE416).w
		move.w	#0,(SStage_scalar_index_0).w
		move.w	#0,(SStage_scalar_index_1).w
		move.w	#0,(SStage_scalar_index_2).w
		bra.s	loc3_2359A
; ---------------------------------------------------------------------------

loc3_2358A:
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc3_2364C

loc3_23594:
		move.l	#Obj_EosianSphere,(a1)

loc3_2359A:
		bsr.w	sub3_2366C
		move.w	d2,d0
		addi.w	#$10,d2
		jsr	(GetSineCosine).l
		asr.w	#1,d0
		asr.w	#1,d1
		move.w	d1,$34(a1)
		move.w	d0,$36(a1)
		move.w	#0,$38(a1)
		move.l	a6,$3A(a1)
		adda.w	#$10,a6
		dbf	d3,loc3_2358A
		moveq	#0,d2
		moveq	#$10-1,d3

loc3_235CC:
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc3_2364C
		move.l	#Obj_EosianSphere,(a1)
		bsr.w	sub3_2366C
		move.w	d2,d0
		addi.w	#$10,d2
		jsr	(GetSineCosine).l
		asr.w	#1,d0
		asr.w	#1,d1
		move.w	#0,$34(a1)
		move.w	d0,$36(a1)
		move.w	d1,$38(a1)
		move.l	a6,$3A(a1)
		adda.w	#$10,a6
		dbf	d3,loc3_235CC
		moveq	#0,d2
		moveq	#$10-1,d3

loc3_2360E:
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc3_2364C
		move.l	#Obj_EosianSphere,(a1)
		bsr.w	sub3_2366C
		move.w	d2,d0
		addi.w	#$10,d2
		jsr	(GetSineCosine).l
		asr.w	#1,d0
		asr.w	#1,d1
		move.w	d0,$34(a1)
		move.w	#0,$36(a1)
		move.w	d1,$38(a1)
		move.l	a6,$3A(a1)
		adda.w	#$10,a6
		dbf	d3,loc3_2360E

loc3_2364C:
		lea	(Pal_SphereTest).l,a1
		lea	(Normal_palette_line_2).w,a2
		move.w	#bytesToWcnt($20),d0

loc3_2365A:
		move.w	(a1)+,(a2)+
		dbf	d0,loc3_2365A
		moveq	#PLCID_09,d0
		jsr	(Load_PLC).l
		bra.w	Obj_SphereTest_Main

; =============== S U B R O U T I N E =======================================


sub3_2366C:
		move.b	#4,render_flags(a1)
		move.b	#$10,width_pixels(a1)
		move.b	#$10,height_pixels(a1)
		move.w	#$200,priority(a1)
		move.l	#Map_SphereTest,mappings(a1)
		move.w	#make_art_tile(ArtTile_SphereTest,1,0),art_tile(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	x_pos(a0),$30(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.w	y_pos(a0),$32(a1)
		rts
; End of function sub3_2366C

; ---------------------------------------------------------------------------
Pal_SphereTest:
		binclude "General/Special Stage/Palettes/Eosian Spheres.bin"
		even
; ---------------------------------------------------------------------------

Obj_SphereTest_Main:
		move.b	(Ctrl_2).w,d1
		btst	#button_A,d1
		beq.s	loc3_236E2
		cmpi.w	#$800,(_unkE416).w
		bcc.s	loc3_236E2
		addq.w	#8,(_unkE416).w

loc3_236E2:
		btst	#button_C,d1
		beq.s	loc3_236F4
		cmpi.w	#$81,(_unkE416).w
		bcs.s	loc3_236F4
		subq.w	#8,(_unkE416).w

loc3_236F4:
		tst.w	$3E(a0)
		bne.s	loc3_2371A
		btst	#button_up,d1
		bne.s	loc3_23704
		addq.w	#3,(SStage_scalar_index_0).w

loc3_23704:
		btst	#button_right,d1
		bne.s	loc3_2370E
		addq.w	#2,(SStage_scalar_index_1).w

loc3_2370E:
		btst	#button_B,d1
		bne.s	loc3_23718
		addq.w	#1,(SStage_scalar_index_2).w

loc3_23718:
		bra.s	loc3_23738
; ---------------------------------------------------------------------------

loc3_2371A:
		btst	#button_up,d1
		beq.s	loc3_23724
		subq.w	#1,(SStage_scalar_index_0).w

loc3_23724:
		btst	#button_right,d1
		beq.s	loc3_2372E
		addq.w	#1,(SStage_scalar_index_1).w

loc3_2372E:
		btst	#button_B,d1
		beq.s	loc3_23738
		addq.w	#1,(SStage_scalar_index_2).w

loc3_23738:
		btst	#button_start,(Ctrl_2_pressed).w
		beq.s	loc3_23758
		eori.w	#-1,$3E(a0)
		move.w	#0,(SStage_scalar_index_0).w
		move.w	#0,(SStage_scalar_index_1).w
		move.w	#0,(SStage_scalar_index_2).w

loc3_23758:
		btst	#button_down,d1
		bne.s	loc3_23762
		addq.w	#8,(_unkE414).w

loc3_23762:
		btst	#button_left,d1
		bne.s	loc3_2376C
		subq.w	#8,(_unkE414).w

loc3_2376C:
		move.w	(SStage_scalar_index_2).w,d0
		lea	(SStage_scalar_result_2).w,a1
		bsr.w	GetScalars
		move.w	(SStage_scalar_index_1).w,d0
		lea	(SStage_scalar_result_1).w,a1
		bsr.w	GetScalars
		move.w	(SStage_scalar_index_0).w,d0
		lea	(SStage_scalar_result_0).w,a1
		bsr.w	GetScalars

Obj_EosianSphere:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	loc3_237A6
		bra.s	loc3_237C4
; ---------------------------------------------------------------------------

loc3_237A6:
		move.w	respawn_addr(a0),d0
		beq.s	loc3_237B2
		movea.w	d0,a2
		bclr	#7,(a2)

loc3_237B2:
		cmpa.w	(Sphere_test_address).w,a0
		bne.s	loc3_237BE
		move.w	#0,(Sphere_test_address).w

loc3_237BE:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc3_237C4:
		movea.l	$3A(a0),a6
		move.w	$34(a0),d1
		move.w	$36(a0),d2
		move.w	$38(a0),d0
		bsr.w	sub3_2398E
		bsr.w	sub3_23964
		add.w	(_unkE416).w,d0
		cmpi.w	#$80,d0
		blt.s	locret3_2382A
		bsr.w	sub3_2393A
		add.w	(_unkE414).w,d2
		bsr.w	sub3_2392C
		add.w	$30(a0),d1
		move.w	d1,x_pos(a0)
		add.w	$32(a0),d2
		move.w	d2,y_pos(a0)
		subi.w	#$80,d0
		lsr.w	#5,d0
		addi.w	#0,d0
		cmpi.w	#$10,d0
		bcs.s	loc3_23816
		move.w	#$F,d0

loc3_23816:
		move.b	d0,mapping_frame(a0)
		lsl.w	#6,d0
		andi.w	#$380,d0
		move.w	d0,priority(a0)
		jsr	(Draw_Sprite).l

locret3_2382A:
		rts
; ---------------------------------------------------------------------------
word3_2382C:
		dc.w   -$70, $8000,  -$70, $8000,     0, $8000,     0,  $234
		dc.w   -$50, $8000,  -$70, $8000,     0, $8000,     0,  $234
		dc.w   -$30, $8000,  -$70, $8000,     0, $8000,     0,  $234
		dc.w   -$10, $8000,  -$70, $8000,     0, $8000,     0,  $234
		dc.w    $10, $8000,  -$70, $8000,     0, $8000,     0,  $234
		dc.w    $30, $8000,  -$70, $8000,     0, $8000,     0,  $234
		dc.w    $50, $8000,  -$70, $8000,     0, $8000,     0,  $234
		dc.w    $70, $8000,  -$70, $8000,     0, $8000,     0,  $234
		dc.w   -$70, $8000,   $70, $8000,     0, $8000,     0,  $234
		dc.w   -$50, $8000,   $70, $8000,     0, $8000,     0,  $234
		dc.w   -$30, $8000,   $70, $8000,     0, $8000,     0,  $234
		dc.w   -$10, $8000,   $70, $8000,     0, $8000,     0,  $234
		dc.w    $10, $8000,   $70, $8000,     0, $8000,     0,  $234
		dc.w    $30, $8000,   $70, $8000,     0, $8000,     0,  $234
		dc.w    $50, $8000,   $70, $8000,     0, $8000,     0,  $234
		dc.w    $70, $8000,   $70, $8000,     0, $8000,     0,  $234

; =============== S U B R O U T I N E =======================================


sub3_2392C:
		ext.l	d1
		lsl.l	#8,d1
		divs.w	d0,d1
		ext.l	d2
		lsl.l	#8,d2
		divs.w	d0,d2
		rts
; End of function sub3_2392C


; =============== S U B R O U T I N E =======================================


sub3_2393A:
		swap	d0
		move.w	d1,d3
		move.w	d2,d4
		move.w	(SStage_scalar_result_2).w,d0
		muls.w	d0,d3
		muls.w	d0,d4
		move.w	(SStage_scalar_result_2+2).w,d0
		muls.w	d0,d1
		muls.w	d0,d2
		sub.l	d4,d1
		add.l	d1,d1
		add.l	d1,d1
		swap	d1
		add.l	d3,d2
		add.l	d2,d2
		add.l	d2,d2
		swap	d2
		swap	d0
		rts
; End of function sub3_2393A


; =============== S U B R O U T I N E =======================================


sub3_23964:
		swap	d2
		move.w	d0,d3
		move.w	d1,d4
		move.w	(SStage_scalar_result_1).w,d2
		muls.w	d2,d3
		muls.w	d2,d4
		move.w	(SStage_scalar_result_1+2).w,d2
		muls.w	d2,d0
		muls.w	d2,d1
		sub.l	d4,d0
		add.l	d0,d0
		add.l	d0,d0
		swap	d0
		add.l	d3,d1
		add.l	d1,d1
		add.l	d1,d1
		swap	d1
		swap	d2
		rts
; End of function sub3_23964


; =============== S U B R O U T I N E =======================================


sub3_2398E:
		swap	d1
		move.w	d0,d3
		move.w	d2,d4
		move.w	(SStage_scalar_result_0).w,d1
		muls.w	d1,d3
		muls.w	d1,d4
		move.w	(SStage_scalar_result_0+2).w,d1
		muls.w	d1,d0
		muls.w	d1,d2
		sub.l	d4,d0
		add.l	d0,d0
		add.l	d0,d0
		swap	d0
		add.l	d3,d2
		add.l	d2,d2
		add.l	d2,d2
		swap	d2
		swap	d1
		rts
; End of function sub3_2398E


; =============== S U B R O U T I N E =======================================


GetScalars:
		add.w	d0,d0
		andi.w	#$1FE,d0
		move.w	ScalarTable(pc,d0.w),(a1)+
		addi.w	#$80,d0
		andi.w	#$1FE,d0
		move.w	ScalarTable(pc,d0.w),(a1)+
		rts
; End of function GetScalars

; ---------------------------------------------------------------------------
ScalarTable:
		binclude "General/Special Stage/Scalars.bin"
		even
Map_SphereTest:
		include "General/Special Stage/Map - Eosian Spheres.asm"