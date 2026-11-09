; =============== S U B R O U T I N E =======================================


Animate_Sprite:
		moveq	#0,d0
		move.b	anim(a0),d0
		cmp.b	prev_anim(a0),d0
		beq.s	locK_1AC00
		move.b	d0,prev_anim(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
; loc3_1926E:
locK_1AC00:
		subq.b	#1,anim_frame_timer(a0)
		bcc.s	locretK_1AC36
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),anim_frame_timer(a0)
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		bmi.s	locK_1AC38
; loc3_1928A:
locK_1AC1C:
		move.b	d0,mapping_frame(a0)
		move.b	status(a0),d1
		andi.b	#3,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		addq.b	#1,anim_frame(a0)
; locret3_192A4:
locretK_1AC36:
		rts
; ---------------------------------------------------------------------------
; loc3_192A6:
locK_1AC38:
		addq.b	#1,d0			; Code FF - Repeat animation from beginning
		bne.s	locK_1AC48
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
		bra.s	locK_1AC1C
; ---------------------------------------------------------------------------
; loc3_192B6:
locK_1AC48:
		addq.b	#1,d0			; Code FE - Repeat animation from earlier point
		bne.s	locK_1AC5C
		move.b	2(a1,d1.w),d0
		sub.b	d0,anim_frame(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	locK_1AC1C
; ---------------------------------------------------------------------------
; loc3_192CA:
locK_1AC5C:
		addq.b	#1,d0			; Code FD - Start new animation
		bne.s	locK_1AC68
		move.b	2(a1,d1.w),anim(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_192D6:
locK_1AC68:
		addq.b	#1,d0			; Code FC - Increment routine counter
		bne.s	locK_1AC7A
		addq.b	#2,routine(a0)
		clr.b	anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_192E8:
locK_1AC7A:
		addq.b	#1,d0			; Code FB - Move offscreen
		bne.s	locretK_1AC86
		move.w	#$7F00,x_pos(a0)
		rts
; ---------------------------------------------------------------------------
; locret3_192F4:
locretK_1AC86:
		rts
; End of function Animate_Sprite


; =============== S U B R O U T I N E =======================================


Animate_SpriteIrregularDelay:
		moveq	#0,d0
		move.b	anim(a0),d0
		cmp.b	prev_anim(a0),d0
		beq.s	locK_1ACA0
		move.b	d0,prev_anim(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
; loc3_1930E:
locK_1ACA0:
		subq.b	#1,anim_frame_timer(a0)
		bcc.s	locretK_1ACDA
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		add.w	d1,d1
		move.b	(a1,d1.w),d0
		bmi.s	locK_1ACDC
; loc3_19328:
locK_1ACBA:
		move.b	1(a1,d1.w),anim_frame_timer(a0)
		move.b	d0,mapping_frame(a0)
		move.b	status(a0),d1
		andi.b	#3,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		addq.b	#1,anim_frame(a0)
; locret3_19348:
locretK_1ACDA:
		rts
; ---------------------------------------------------------------------------
; loc3_1934A:
locK_1ACDC:
		addq.b	#1,d0
		bne.s	locK_1ACEA
	if (Sonic3_Alone=1)&(FixBugs=0)
		move.b	#0,anim_frame(a0)
	else
		; Bug: S3 did not clear d1, making locK_1ACBA run a frame short with each loop.
		; This was fixed, but apart from the Blue Spheres title, the only other effect
		; is that the wink animation on the S3 title now runs a frame too long.
		moveq	#0,d1
		move.b	d1,anim_frame(a0)
	endif
		move.b	(a1),d0
		bra.s	locK_1ACBA
; ---------------------------------------------------------------------------
; loc3_19358:
locK_1ACEA:
		addq.b	#1,d0
		bne.s	locK_1AD00
		move.b	1(a1,d1.w),d0
		sub.b	d0,anim_frame(a0)
		add.w	d0,d0
		sub.b	d0,d1
		move.b	(a1,d1.w),d0
		bra.s	locK_1ACBA
; ---------------------------------------------------------------------------
; loc3_1936E:
locK_1AD00:
		addq.b	#1,d0
		bne.s	locK_1AD0C
		move.b	1(a1,d1.w),anim(a0)
		rts
; ---------------------------------------------------------------------------
; loc3_1937A:
locK_1AD0C:
		addq.b	#1,d0
		bne.s	locretK_1AD1E
		addq.b	#2,routine(a0)
		clr.b	anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)
		rts
; ---------------------------------------------------------------------------
; locret3_1938C:
locretK_1AD1E:
		rts
; End of function Animate_SpriteIrregularDelay