; ---------------------------------------------------------------------------
		; unused
		subq.w	#1,$24(a0)
		bpl.s	loc3_6068
		move.w	#7,$24(a0)
		moveq	#0,d0
		move.b	$2E(a0),d0
		addq.b	#1,$2E(a0)
		move.b	byte3_6074(pc,d0.w),d0
		bne.s	loc3_6016
		move.b	#1,$2E(a0)
		move.b	byte3_6074(pc),d0

loc3_6016:
		lsl.w	#7,d0
		lea	(RAM_start).l,a1
		lea	(a1,d0.w),a1
		lea	(RAM_start+$200).l,a2
		move.w	#bytesToWcnt($100),d0

loc3_602C:
		move.w	(a1)+,(a2)+
		dbf	d0,loc3_602C
		moveq	#0,d0
		move.b	$2F(a0),d0
		addq.b	#1,$2F(a0)
		move.b	byte3_608E(pc,d0.w),d0
		bne.s	loc3_604C
		move.b	#1,$2F(a0)
		move.b	byte3_608E(pc),d0

loc3_604C:
		lsl.w	#7,d0
		lea	(RAM_start).l,a1
		lea	(a1,d0.w),a1
		lea	(RAM_start+$F00).l,a2
		move.w	#bytesToWcnt($80),d0

loc3_6062:
		move.w	(a1)+,(a2)+
		dbf	d0,loc3_6062

loc3_6068:
		cmpi.w	#6,$24(a0)
		beq.w	loc3_6110
		rts
; ---------------------------------------------------------------------------
byte3_6074:
		dc.b    2, $12,   6, $14,   8, $16,  $A, $18,  $C, $18,  $A, $16,   8, $14,   6, $12
		dc.b    3, $1A,  $E, $1C, $10, $1C,  $E, $1A,   0,   0
byte3_608E:
		dc.b    2, $1F, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D
		dc.b  $2E, $2F, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D
		dc.b  $3E, $3F, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D
		dc.b  $4E, $4D, $4C, $4B, $4A, $49, $48, $47, $46, $45, $44, $43, $42, $41, $40, $3F
		dc.b  $3E, $3D, $3C, $3B, $3A, $39, $38, $37, $36, $35, $34, $33, $32, $31, $30, $2F
		dc.b  $2E, $2D, $2C, $2B, $2A, $29, $28, $27, $26, $25, $24, $23, $22, $21, $20, $1F
		dc.b    2, $4F, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D
		dc.b  $5E, $5D, $5C, $5B, $5A, $59, $58, $57, $56, $55, $54, $53, $52, $51, $50, $4F
		dc.b    0,   0
		even
; ---------------------------------------------------------------------------

loc3_6110:
		move	#$2700,sr
		movem.l	d0-a6,-(sp)
		lea	(Plane_buffer).w,a0
		lea	(Block_table).w,a2
		lea	(Level_layout_main).w,a3
		move.w	#$C000,d7
		move.w	(Camera_X_pos).w,d0
		move.w	d0,d1
		move.w	(Camera_Y_pos).w,d0
		andi.w	#$FF0,d0
		jsr	(Refresh_PlaneFull).l
		movem.l	(sp)+,d0-a6
		move	#$2300,sr
		rts