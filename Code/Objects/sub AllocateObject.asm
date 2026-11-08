; =============== S U B R O U T I N E =======================================

; Create_New_Sprite:
AllocateObject:
		lea	(Dynamic_object_RAM).w,a1
		moveq	#((Dynamic_object_RAM_end-Dynamic_object_RAM)/object_size)-1,d0
		bra.s	AllocateObjectAfterCurrent.loop
; ---------------------------------------------------------------------------
; Create_New_Sprite3:
AllocateObjectAfterCurrent:
		movea.l	a0,a1
		move.w	#Dynamic_object_RAM_end,d0
		sub.w	a0,d0
		lsr.w	#6,d0			; Divide by $40... even though SSTs are $4A bytes long in this game
		move.b	.lookup(pc,d0.w),d0	; Use a look-up table to get the right loop counter
		bmi.s	.return

.loop:
		lea	next_object(a1),a1
		tst.l	(a1)
		dbeq	d0,.loop

.return:
		rts

.lookup:
.a		set	Dynamic_object_RAM
.b		set	Dynamic_object_RAM_end
.c		set	.b			; begin from bottom of array and decrease backwards
		; There's a mistake here: this division should be rounded up,
		; otherwise the first object slot might not get an entry.
		rept	(.b-.a)/$40	; repeat for all slots, minus exception
.c		set	.c-$40			; address for previous $40 (also skip last part)
		dc.b	(.b-.c-1)/object_size-1	; write possible slots according to object_size division + hack + dbf hack
		endm
		even
; End of function AllocateObject