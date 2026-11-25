; =============== S U B R O U T I N E =======================================


Perform_Art_Scaling:
		clr.w	(_unkF740).w
		move.l	a0,-(sp)
		jsr	Init_ArtScaling
		movea.l	(sp)+,a0
		move.l	a0,-(sp)
		move.w	art_tile(a0),d0
	if Sonic3_Alone
		jsr	(sub_22C90).l
	else
		jsr	(sub_2468A).l
	endif
		movea.l	(sp)+,a0
		move.w	(_unkF740).w,d3
		lsl.w	#4,d3
		move.l	#Kos_decomp_buffer,d1
		move.w	$3A(a0),d2
		jmp	(Add_To_DMA_Queue).l
; End of function Perform_Art_Scaling


; =============== S U B R O U T I N E =======================================


subK_86180:
	if Sonic3_Alone
		move.w	x_vel(a0),d0
		addi.w	#-$28,d0
		cmpi.w	#-$80,d0
		blt.s	loc3_51DFC
		move.w	d0,x_vel(a0)

loc3_51DFC:
		move.w	y_vel(a0),d0
		addi.w	#8,d0
		cmpi.w	#$40,d0
		bge.s	locret3_51E0E
		move.w	d0,y_vel(a0)

locret3_51E0E:
		rts
	else
		move.w	x_vel(a0),d0
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,$30(a0)
		move.w	y_vel(a0),d0
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,$34(a0)
		rts
	endif
; End of function subK_86180


; =============== S U B R O U T I N E =======================================


subK_8619A:
	if Sonic3_Alone
		bsr.w	sub_4B30A
	endif
		move.w	$30(a0),d2
		move.w	$34(a0),d3
		moveq	#0,d0
		move.b	$40(a0),d0
		addq.w	#4,d0
		move.l	#$100,d4
		divu.w	d0,d4
		sub.w	d4,d2
		sub.w	d4,d3
		move.w	d2,x_pos(a0)
		move.w	d3,y_pos(a0)
		rts
; End of function subK_8619A