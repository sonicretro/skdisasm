
; =============== S U B R O U T I N E =======================================


ChangeRingFrame:
		subq.b	#1,(Rings_frame_timer).w
		bpl.s	locK_77E8
		move.b	#7,(Rings_frame_timer).w
		addq.b	#1,(Rings_frame).w
		andi.b	#3,(Rings_frame).w
; loc3_59F6:
locK_77E8:
		tst.b	(Ring_spill_anim_counter).w
		beq.s	locK_780A
		moveq	#0,d0
		move.b	(Ring_spill_anim_counter).w,d0
		add.w	(Ring_spill_anim_accum).w,d0
		move.w	d0,(Ring_spill_anim_accum).w
		rol.w	#7,d0
		andi.w	#3,d0
		move.b	d0,(Ring_spill_anim_frame).w
		subq.b	#1,(Ring_spill_anim_counter).w
; loc3_5A18:
locK_780A:
		addi.w	#$180,(AIZ_vine_angle).w
		rts
; End of function ChangeRingFrame