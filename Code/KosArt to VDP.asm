
; =============== S U B R O U T I N E =======================================


KosArt_To_VDP:
		movea.l	a1,a3		; a1 will be changed by Kos_Decomp, so we're backing it up to a3
		jsr	(Kos_Decomp).l

		move.l	a3,d1		; move the backed-up a1 to d1
		andi.l	#$FFFFFF,d1	; d1 will be used in the DMA transfer as the Source Address

		move.l	a1,d3		; move end address of decompressed art to d3
		sub.l	a3,d3		; subtract 'start address of decompressed art' from 'end address of decompressed art', giving you the size of the decompressed art
		lsr.l	#1,d3		; divide size of decompressed art by two, d3 will be used in the DMA transfer as the Transfer Length (size/2)

		move.w	a2,d2		; move VRAM address to d2, d2 will be used in the DMA transfer as the Destination Address

		movea.l	a1,a3		; backup a1, this allows the same address to be used by multiple calls to KosArt_To_VDP without constant redefining
		jsr	(Add_To_DMA_Queue).l	; transfer *Transfer Length* of data from *Source Address* to *Destination Address*
		movea.l	a3,a1		; restore a1
		rts
; End of function KosArt_To_VDP