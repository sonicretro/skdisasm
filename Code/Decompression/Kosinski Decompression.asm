; ---------------------------------------------------------------------------
; Kosinski decompression subroutine
; Inputs:
; a0 = compressed data location
; a1 = destination
; See http://www.segaretro.org/Kosinski_compression for format description
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Kos_Decomp:
		subq.l	#2,sp	; make space for two bytes on the stack
		move.b	(a0)+,1(sp)
		move.b	(a0)+,(sp)
		move.w	(sp),d5	; copy first description field
		moveq	#$F,d4	; 16 bits in a byte

Kos_Decomp_Loop:
		lsr.w	#1,d5	; bit which is shifted out goes into C flag
		move	sr,d6
		dbf	d4,Kos_Decomp_ChkBit
		move.b	(a0)+,1(sp)
		move.b	(a0)+,(sp)
		move.w	(sp),d5	; get next description field if needed
		moveq	#$F,d4	; reset bit counter

Kos_Decomp_ChkBit:
		move	d6,ccr	; was the bit set?
		bcc.s	Kos_Decomp_Match	; if not, branch (C flag clear means bit was clear)
		move.b	(a0)+,(a1)+	; otherwise, copy byte as-is
		bra.s	Kos_Decomp_Loop
; ---------------------------------------------------------------------------

Kos_Decomp_Match:
		moveq	#0,d3
		lsr.w	#1,d5	; get next bit
		move	sr,d6
		dbf	d4,Kos_Decomp_ChkBit2
		move.b	(a0)+,1(sp)
		move.b	(a0)+,(sp)
		move.w	(sp),d5
		moveq	#$F,d4

Kos_Decomp_ChkBit2:
		move	d6,ccr	; was the bit set?
		bcs.s	Kos_Decomp_FullMatch	; if it was, branch
		lsr.w	#1,d5	; bit which is shifted out goes into X flag
		dbf	d4,+
		move.b	(a0)+,1(sp)
		move.b	(a0)+,(sp)
		move.w	(sp),d5
		moveq	#$F,d4

+
		roxl.w	#1,d3	; get high repeat count bit (shift X flag in)
		lsr.w	#1,d5
		dbf	d4,+
		move.b	(a0)+,1(sp)
		move.b	(a0)+,(sp)
		move.w	(sp),d5
		moveq	#$F,d4

+
		roxl.w	#1,d3	; get low repeat count bit
		addq.w	#1,d3	; increment repeat count
		moveq	#-1,d2
		move.b	(a0)+,d2	; calculate offset
		bra.s	Kos_Decomp_MatchLoop
; ---------------------------------------------------------------------------

Kos_Decomp_FullMatch:
		move.b	(a0)+,d0	; get first byte
		move.b	(a0)+,d1	; get second byte
		moveq	#-1,d2
		move.b	d1,d2
		lsl.w	#5,d2
		move.b	d0,d2	; calculate offset
		andi.w	#7,d1	; does a third byte need to be read?
		beq.s	Kos_Decomp_FullMatch2	; if it does, branch
		move.b	d1,d3	; copy repeat count
		addq.w	#1,d3	; and increment it

Kos_Decomp_MatchLoop:
		move.b	(a1,d2.w),d0
		move.b	d0,(a1)+	; copy appropriate byte
		dbf	d3,Kos_Decomp_MatchLoop	; and repeat the copying
		bra.s	Kos_Decomp_Loop
; ---------------------------------------------------------------------------

Kos_Decomp_FullMatch2:
		move.b	(a0)+,d1
		beq.s	Kos_Decomp_Done	; 0 indicates end of compressed data
		cmpi.b	#1,d1
		beq.w	Kos_Decomp_Loop	; 1 indicates a new description needs to be read
		move.b	d1,d3	; otherwise, copy repeat count
		bra.s	Kos_Decomp_MatchLoop
; ---------------------------------------------------------------------------

Kos_Decomp_Done:
		addq.l	#2,sp	; restore stack pointer to original state
		rts
; End of function Kos_Decomp