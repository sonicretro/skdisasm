; ---------------------------------------------------------------------------
; ===========================================================================
; ∫                                                                         ∫
; ∫	                        SONIC&K SOUND DRIVER                            ∫
; ∫                                                                         ∫
; ===========================================================================
; Disassembled by MarkeyJester
; Routines, pointers and stuff by Linncaki
; ===========================================================================
; Macros
; ===========================================================================
z80_SoundDriver:
		!org	0					; z80 Align, handled by the build process
		CPU Z80
		listing off

; ---------------------------------------------------------------------------
; equates: standard (for Genesis games) addresses in the memory map
zYM2612_A0 =	4000h
zYM2612_D0 =	4001h
zYM2612_A1 =	4002h
zYM2612_D1 =	4003h
zBankRegister =	6000h
zPSG =			7F11h
z68kMemory =	8000h
; Variables passed from the 68k:
palFlag =		1C02h
tempoMod =		1C08h
playSlot0 =		1C0Ah	; Play_Sound
playSlot1 =		1C0Bh	; Play_Sound_2
playSlot2 =		1C0Ch	; Play_Sound_2
pauseFlag =		1C10h

; function to turn a 68k address into a word the Z80 can use to access it
zmake68kPtr function addr,z68kMemory+(addr&7FFFh)

; function to turn a 68k address into a bank byte
zmake68kBank function addr,(((addr&3F8000h)/z68kMemory))
; ---------------------------------------------------------------------------
; ===========================================================================
; Entry Point
; ===========================================================================

; EntryPoint:
		di
		di
		im	1
		jp	loc_85
; ---------------------------------------------------------------------------
		db 0F2h	; Ú

; =============== S U B	R O U T	I N E =======================================


sub_8:
		ld	hl, (word_15)
		ld	b, 0
		add	hl, bc
		ex	af, af'
		ld	a, (hl)
		inc	hl
		ld	h, (hl)
		ld	l, a
		ex	af, af'
		ret
; End of function sub_8

; ---------------------------------------------------------------------------
word_15:
		dw		z80_SoundDriverPointers
		db		0

; =============== S U B	R O U T	I N E =======================================


sub_18:
		ld	c, a
		ld	b, 0
		add	hl, bc
		add	hl, bc
		nop
		nop
		nop

loc_20:
		ld	a, (hl)
		inc	hl
		ld	h, (hl)
		ld	l, a
		ret
; End of function sub_18

; ---------------------------------------------------------------------------
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
; ---------------------------------------------------------------------------
		di
		push	af
		push	iy
		exx

loc_3D:
		ld	a, r
		ld	(1C17h), a
		call	sub_11B
		ld	a, (palFlag)
		or	a
		jr	z, loc_5D
		ld	a, (1C04h)
		or	a
		jr	nz, loc_59
		ld	a, 5
		ld	(1C04h), a
		jp	loc_3D
; ---------------------------------------------------------------------------

loc_59:
		dec	a
		ld	(1C04h), a

loc_5D:
		ld	a, (1C30h)
		and	7Fh ; ''
		ld	c, a
		ld	b, 0
		ld	hl, DAC_Banks ; '÷'
		add	hl, bc
		ld	a, (hl)
		ld	hl, zBankRegister
		ld	(hl), a
		rrca
		ld	(hl), a
		rrca
		ld	(hl), a
		rrca
		ld	(hl), a
		rrca
		ld	(hl), a
		rrca
		ld	(hl), a
		rrca
		ld	(hl), a
		rrca
		ld	(hl), a
		xor	a
		ld	(hl), a
		exx
		pop	iy
		pop	af
		ld	b, 1
		ret
; ---------------------------------------------------------------------------

loc_85:
		ld	sp, 2000h
		ld	c, 0

loc_8A:
		ld	b, 0

loc_8C:
		djnz	$
		dec	c
		jr	z, loc_8A
		call	sub_944
		ld	a, 1Dh
		ld	(1C3Eh), a
		xor	a
		ld	(1C27h), a
		ld	(1C30h), a
		ld	(1C3Fh), a
		ld	(1C28h), a
		ld	a, 5
		ld	(1C04h), a
		ei
		jp	loc_108A

; =============== S U B	R O U T	I N E =======================================


sub_AF:

; FUNCTION CHUNK AT 00CB SIZE 00000002 BYTES

		bit	7, (ix+1)
		ret	nz
		bit	2, (ix+0)
		ret	nz
		add	a, (ix+1)
		bit	2, (ix+1)
		jr	nz, loc_CB
; End of function sub_AF


; =============== S U B	R O U T	I N E =======================================


sub_C2:
		ld	(zYM2612_A0), a
		nop
		ld	a, c
		ld	(zYM2612_D0), a
		ret
; End of function sub_C2

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_AF

loc_CB:
		sub	4
; END OF FUNCTION CHUNK	FOR sub_AF

; =============== S U B	R O U T	I N E =======================================


sub_CD:
		ld	(zYM2612_A1), a
		nop
		ld	a, c
		ld	(zYM2612_D1), a
		ret
; End of function sub_CD

; ---------------------------------------------------------------------------
; ===========================================================================
; DAC BANKS
; ===========================================================================
DAC_Banks:
		db		zmake68kBank(DacBank1),zmake68kBank(DacBank1),zmake68kBank(DacBank1),zmake68kBank(DacBank1)
		db		zmake68kBank(DacBank1),zmake68kBank(DacBank1),zmake68kBank(DacBank1),zmake68kBank(DacBank1)
		db		zmake68kBank(DacBank1),zmake68kBank(DacBank1),zmake68kBank(DacBank1),zmake68kBank(DacBank1)
		db		zmake68kBank(DacBank1),zmake68kBank(DacBank1),zmake68kBank(DacBank1),zmake68kBank(DacBank1)
		db		zmake68kBank(DacBank1),zmake68kBank(DacBank1),zmake68kBank(DacBank1),zmake68kBank(DacBank1)
		db		zmake68kBank(DacBank1),zmake68kBank(DacBank1),zmake68kBank(DacBank1),zmake68kBank(DacBank1)
		db		zmake68kBank(DacBank1),zmake68kBank(DacBank1),zmake68kBank(DacBank1),zmake68kBank(DacBank1)
		db		zmake68kBank(DacBank2),zmake68kBank(DacBank2),zmake68kBank(DacBank2),zmake68kBank(DacBank2)
		db		zmake68kBank(DacBank2),zmake68kBank(DacBank2),zmake68kBank(DacBank2),zmake68kBank(DacBank2)
		db		zmake68kBank(DacBank2),zmake68kBank(DacBank2),zmake68kBank(DacBank2),zmake68kBank(DacBank2)
		db		zmake68kBank(DacBank2),zmake68kBank(DacBank2),zmake68kBank(DacBank2),zmake68kBank(DacBank3)
		db		zmake68kBank(DacBank3),zmake68kBank(DacBank3),zmake68kBank(DacBank3),zmake68kBank(DacBank3)
		db		zmake68kBank(DacBank3),zmake68kBank(DacBank3),zmake68kBank(DacBank1),zmake68kBank(DacBank1)
		db		zmake68kBank(DacBank3),zmake68kBank(DacBank3),zmake68kBank(DacBank3),zmake68kBank(DacBank3)
		db		zmake68kBank(DacBank3),zmake68kBank(DacBank3),zmake68kBank(DacBank3),zmake68kBank(DacBank3)
		db		zmake68kBank(DacBank3),zmake68kBank(DacBank3),zmake68kBank(DacBank3),zmake68kBank(DacBank3)
		db		zmake68kBank(DacBank3),zmake68kBank(DacBank3),zmake68kBank(DacBank3),zmake68kBank(DacBank3)
		db		zmake68kBank(DacBank3)

; =============== S U B	R O U T	I N E =======================================


sub_11B:
		call	sub_7FF
		call	sub_19E

loc_121:
		call	sub_9CC
		call	sub_879
		call	sub_8DF
		ld	a, (1C16h)
		cp	29h ; ')'
		jr	nz, loc_149
		ld	a, (playSlot0)
		cp	2Ah ; '*'
		jr	z, loc_13C
		cp	32h ; '2'
		jr	c, loc_140

loc_13C:
		xor	a
		ld	(playSlot0), a

loc_140:
		xor	a
		ld	(playSlot1), a
		ld	(playSlot2), a
		jr	loc_168
; ---------------------------------------------------------------------------

loc_149:
		ld	a, (1C16h)
		cp	0FFh
		jr	z, loc_168
		ld	hl, playSlot0
		ld	e, (hl)
		inc	hl
		ld	d, (hl)
		inc	hl
		ld	a, (hl)
		or	d
		or	e
		jr	z, loc_168
		call	sub_9E2
		call	loc_4E2
		call	loc_4E2
		call	loc_4E2

loc_168:
		ld	a, (1C3Eh)
		ld	hl, zBankRegister
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		xor	a
		ld	(hl), a
		xor	a
		ld	(1C19h), a
		ld	a, (1C16h)
		cp	0FFh
		call	z, sub_A20
		ld	ix, 1C40h
		bit	7, (ix+0)
		call	nz, sub_B98
		ld	b, 8
		ld	ix, 1C70h
		jr	loc_1BF
; End of function sub_11B


; =============== S U B	R O U T	I N E =======================================


sub_19E:
		ld	a, 1
		ld	(1C19h), a
		ld	a, zmake68kBank(SndBank)
		ld	hl, zBankRegister
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		xor	a
		ld	(hl), a
		ld	ix, 1DF0h
		ld	b, 7

loc_1BF:
		push	bc
		bit	7, (ix+0)
		call	nz, sub_1E9
		ld	de, 30h	; '0'
		add	ix, de
		pop	bc
		djnz	loc_1BF
		ld	a, (tempoMod)
		or	a
		ret	z
		ld	a, (1C2Fh)
		or	a
		jp	nz, loc_1E4
		ld	a, (tempoMod)
		ld	(1C2Fh), a
		jp	loc_121
; ---------------------------------------------------------------------------

loc_1E4:
		dec	a
		ld	(1C2Fh), a
		ret
; End of function sub_19E


; =============== S U B	R O U T	I N E =======================================


sub_1E9:

; FUNCTION CHUNK AT 0342 SIZE 00000019 BYTES
; FUNCTION CHUNK AT 0FC4 SIZE 00000073 BYTES

		bit	7, (ix+1)
		jp	nz, loc_FC4
		call	sub_33A
		jr	nz, loc_20C
		call	sub_277
		bit	4, (ix+0)
		ret	nz
		call	sub_39E
		call	sub_46F
		call	sub_3C9
		call	sub_22B
		jp	loc_342
; ---------------------------------------------------------------------------

loc_20C:
		bit	4, (ix+0)
		ret	nz
		call	sub_36D
		ld	a, (ix+1Eh)
		or	a
		jr	z, loc_220
		dec	(ix+1Eh)
		jp	z, sub_35B

loc_220:
		call	sub_46F
		bit	6, (ix+0)
		ret	nz
		call	sub_3C9
; End of function sub_1E9


; =============== S U B	R O U T	I N E =======================================


sub_22B:
		bit	2, (ix+0)
		ret	nz
		bit	0, (ix+0)
		jp	nz, loc_244

loc_237:
		ld	a, 0A4h	; '§'
		ld	c, h
		call	sub_AF
		ld	a, 0A0h	; '†'
		ld	c, l
		call	sub_AF
		ret
; ---------------------------------------------------------------------------

loc_244:
		ld	a, (ix+1)
		cp	2
		jr	nz, loc_237
		ld	b, 4
		ld	hl, loc_272

loc_250:
		push	bc
		ld	a, (hl)
		inc	hl
		push	hl
		ex	de, hl
		ld	c, (hl)
		inc	hl
		ld	b, (hl)
		inc	hl
		ex	de, hl
		ld	l, (ix+0Dh)
		ld	h, (ix+0Eh)
		add	hl, bc
		push	af
		ld	c, h
		call	sub_C2
		pop	af
		sub	4
		ld	c, l
		call	sub_C2
		pop	hl
		pop	bc
		djnz	loc_250
		ret
; End of function sub_22B

; ---------------------------------------------------------------------------
loc_272:
		db 0ADh	; ≠
		db 0AEh	; Æ
		db 0ACh	; ¨
		db 0A6h	; ¶

; =============== S U B	R O U T	I N E =======================================


nullsub_A:
		ret
; End of function nullsub_A


; =============== S U B	R O U T	I N E =======================================


sub_277:
		ld	e, (ix+3)
		ld	d, (ix+4)
		res	1, (ix+0)
		res	4, (ix+0)

loc_285:
		ld	a, (de)
		inc	de
		cp	0E0h ; '‡'
		jp	nc, loc_BED
		ex	af, af'
		call	sub_35B
		ex	af, af'
		bit	3, (ix+0)
		jp	nz, loc_2E8
		or	a
		jp	p, loc_308
		sub	81h ; 'Å'
		jp	p, loc_2A6
		call	sub_106C
		jr	loc_2D4
; ---------------------------------------------------------------------------

loc_2A6:
		add	a, (ix+5)
		ld	hl, loc_AA5
		push	af
		rst	18h
		pop	af
		bit	7, (ix+1)
		jr	nz, loc_2CE
		push	de
		ld	d, 8
		ld	e, 0Ch
		ex	af, af'
		xor	a

loc_2BC:
		ex	af, af'
		sub	e
		jr	c, loc_2C5
		ex	af, af'
		add	a, d
		jr	loc_2BC
; ---------------------------------------------------------------------------
		db    8
; ---------------------------------------------------------------------------

loc_2C5:
		add	a, e
		ld	hl, 0B4Dh
		rst	18h
		ex	af, af'
		or	h
		ld	h, a
		pop	de

loc_2CE:
		ld	(ix+0Dh), l
		ld	(ix+0Eh), h

loc_2D4:
		ld	a, (de)
		or	a
		jp	p, loc_307
		ld	a, (ix+0Ch)
		ld	(ix+0Bh), a
		jr	loc_30E
; ---------------------------------------------------------------------------
		db  1Ah
		db  13h
		db 0DDh	; ›
		db  77h	; w
		db  11h
		db  18h
		db  1Eh
; ---------------------------------------------------------------------------

loc_2E8:
		ld	h, a
		ld	a, (de)
		inc	de
		ld	l, a
		or	h
		jr	z, loc_2FB
		ld	a, (ix+5)
		ld	b, 0
		or	a
		jp	p, loc_2F9
		dec	b

loc_2F9:
		ld	c, a
		add	hl, bc

loc_2FB:
		ld	(ix+0Dh), l
		ld	(ix+0Eh), h
		ld	a, (de)
		inc	de
		ld	(ix+11h), a
		ld	a, (de)

loc_307:
		inc	de

loc_308:
		call	sub_330
		ld	(ix+0Ch), a

loc_30E:
		ld	(ix+3),	e
		ld	(ix+4),	d
		ld	a, (ix+0Ch)
		ld	(ix+0Bh), a
		bit	1, (ix+0)
		ret	nz
		xor	a
		ld	(ix+25h), a
		ld	(ix+22h), a
		ld	(ix+17h), a
		ld	a, (ix+1Fh)
		ld	(ix+1Eh), a
		ret
; End of function sub_277


; =============== S U B	R O U T	I N E =======================================


sub_330:
		ld	b, (ix+2)
		dec	b
		ret	z
		ld	c, a

loc_336:
		add	a, c
		djnz	loc_336
		ret
; End of function sub_330


; =============== S U B	R O U T	I N E =======================================


sub_33A:
		ld	a, (ix+0Bh)
		dec	a
		ld	(ix+0Bh), a
		ret
; End of function sub_33A

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1E9

loc_342:
		ld	a, (ix+0Dh)
		or	(ix+0Eh)
		ret	z
		ld	a, (ix+0)
		and	6
		ret	nz
		ld	a, (ix+1)
		or	0F0h ; ''
		ld	c, a
		ld	a, 28h ; '('
		call	sub_C2
		ret
; END OF FUNCTION CHUNK	FOR sub_1E9

; =============== S U B	R O U T	I N E =======================================


sub_35B:
		ld	a, (ix+0)
		and	6
		ret	nz

loc_361:
		ld	c, (ix+1)
		bit	7, c
		ret	nz
; End of function sub_35B

; START	OF FUNCTION CHUNK FOR sub_9F6

loc_367:
		ld	a, 28h ; '('
		call	sub_C2
		ret
; END OF FUNCTION CHUNK	FOR sub_9F6

; =============== S U B	R O U T	I N E =======================================


sub_36D:
		ld	a, (ix+18h)
		or	a
		ret	z
		ret	m
		dec	a
		ld	c, 0Ah
		rst	8
		rst	18h
		call	sub_103A
		ld	h, (ix+1Dh)
		ld	l, (ix+1Ch)
		ld	de, 4B1h
		ld	b, 4
		ld	c, (ix+19h)

loc_389:
		push	af
		sra	c
		push	bc
		jr	nc, loc_397
		add	a, (hl)
		and	7Fh ; ''
		ld	c, a
		ld	a, (de)
		call	sub_AF

loc_397:
		pop	bc
		inc	de
		inc	hl
		pop	af
		djnz	loc_389
		ret
; End of function sub_36D


; =============== S U B	R O U T	I N E =======================================


sub_39E:
		bit	7, (ix+7)
		ret	z
		bit	1, (ix+0)
		ret	nz
		ld	e, (ix+20h)
		ld	d, (ix+21h)
		push	ix
		pop	hl
		ld	b, 0
		ld	c, 24h ; '$'
		add	hl, bc
		ex	de, hl
		ldi
		ldi
		ldi
		ld	a, (hl)
		srl	a
		ld	(de), a
		xor	a
		ld	(ix+22h), a
		ld	(ix+23h), a
		ret
; End of function sub_39E


; =============== S U B	R O U T	I N E =======================================


sub_3C9:
		ld	a, (ix+7)
		or	a
		ret	z
		cp	80h ; 'Ä'
		jr	nz, loc_41A
		dec	(ix+24h)
		ret	nz
		inc	(ix+24h)
		push	hl
		ld	l, (ix+22h)
		ld	h, (ix+23h)
		ld	e, (ix+20h)
		ld	d, (ix+21h)
		push	de
		pop	iy
		dec	(ix+25h)
		jr	nz, loc_405
		ld	a, (iy+1)
		ld	(ix+25h), a
		ld	a, (ix+26h)
		ld	c, a
		and	80h ; 'Ä'
		rlca
		neg
		ld	b, a
		add	hl, bc
		ld	(ix+22h), l
		ld	(ix+23h), h

loc_405:
		pop	bc
		add	hl, bc
		dec	(ix+27h)
		ret	nz
		ld	a, (iy+3)
		ld	(ix+27h), a
		ld	a, (ix+26h)
		neg
		ld	(ix+26h), a
		ret
; ---------------------------------------------------------------------------

loc_41A:
		dec	a
		ex	de, hl
		ld	c, 8
		rst	8
		rst	18h
		jr	loc_425
; ---------------------------------------------------------------------------

loc_422:
		ld	(ix+25h), a

loc_425:
		push	hl
		ld	c, (ix+25h)
		ld	b, 0
		add	hl, bc
		ld	a, (hl)
		pop	hl
		bit	7, a
		jp	z, loc_460
		cp	82h ; 'Ç'
		jr	z, loc_449
		cp	80h ; 'Ä'
		jr	z, loc_44D
		cp	84h ; 'Ñ'
		jr	z, loc_450
		ld	h, 0FFh
		jr	nc, loc_462
		set	6, (ix+0)
		pop	hl
		ret
; ---------------------------------------------------------------------------

loc_449:
		inc	bc
		ld	a, (bc)
		jr	loc_422
; ---------------------------------------------------------------------------

loc_44D:
		xor	a
		jr	loc_422
; ---------------------------------------------------------------------------

loc_450:
		inc	bc
		ld	a, (bc)
		add	a, (ix+22h)
		ld	(ix+22h), a
		inc	(ix+25h)
		inc	(ix+25h)
		jr	loc_425
; ---------------------------------------------------------------------------

loc_460:
		ld	h, 0

loc_462:
		ld	l, a
		ld	b, (ix+22h)
		inc	b
		ex	de, hl

loc_468:
		add	hl, de
		djnz	loc_468
		inc	(ix+25h)
		ret
; End of function sub_3C9


; =============== S U B	R O U T	I N E =======================================


sub_46F:
		ld	h, (ix+0Eh)
		ld	l, (ix+0Dh)
		ld	b, 0
		ld	a, (ix+10h)
		or	a
		jp	p, loc_480
		ld	b, 0FFh

loc_480:
		ld	c, a
		add	hl, bc
		ret
; End of function sub_46F


; =============== S U B	R O U T	I N E =======================================


sub_483:
		ld	hl, (1C37h)
		ld	a, (1C19h)
		or	a
		jr	z, loc_492
		ld	l, (ix+2Ah)
		ld	h, (ix+2Bh)

loc_492:
		xor	a
		or	b
		ret	z
		ld	de, 19h

loc_498:
		add	hl, de
		djnz	loc_498
		ret
; End of function sub_483

; ---------------------------------------------------------------------------

loc_49C:
		db 0B0h	; ∞
		db  30h	; 0
		db  38h	; 8
		db  34h	; 4
		db  3Ch	; <
		db  50h	; P
		db  58h	; X
		db  54h	; T
		db  5Ch	; /		; S
		db  60h	; `
		db  68h	; h
		db  64h	; d
		db  6Ch	; l
		db  70h	; p
		db  78h	; x
		db  74h	; t
		db  7Ch	; |
		db  80h	; Ä
		db  88h	; à
		db  84h	; Ñ
		db  8Ch	; å
		db  40h	; @
		db  48h	; H
		db  44h	; D
		db  4Ch	; L
		db  90h	; ê
		db  98h	; ò
		db  94h	; î
		db  9Ch	; ú

; =============== S U B	R O U T	I N E =======================================


sub_4B9:
		ld	de, loc_49C
		ld	c, (ix+0Ah)
		ld	a, 0B4h	; '¥'
		call	sub_AF
		call	sub_4DA
		ld	(ix+1Bh), a
		ld	b, 14h

loc_4CC:
		call	sub_4DA
		djnz	loc_4CC
		ld	(ix+1Ch), l
		ld	(ix+1Dh), h
		jp	sub_CBA
; End of function sub_4B9


; =============== S U B	R O U T	I N E =======================================


sub_4DA:
		ld	a, (de)
		inc	de
		ld	c, (hl)
		inc	hl
		call	sub_AF
		ret
; End of function sub_4DA

; ---------------------------------------------------------------------------

loc_4E2:
		ld	a, (1C05h)
		ld	(1C09h), a
		ld	a, (1C06h)
		ld	(1C05h), a
		ld	a, (1C07h)
		ld	(1C06h), a
		xor	a
		ld	(1C07h), a
		ld	a, (1C09h)

; ---------------------------------------------------------------------------
; ===========================================================================
; Type Check
; ===========================================================================
; 1-32, DC = Music
; 33-DB, DD-DF = SFX
; E1-E6 = Fade Effects
; FF = SEGA Scream

; TypeCheck:
sub_4FB:
		cp	0DCh
		jp	z, loc_552							; Check if sound to play is DC, Music
		cp	0FFh
		jp	z, loc_A16							; Check if sound to play is FF, SEEEEEGAAAAA!
		cp	33h
		jp	c, loc_558							; Check if sound to play is lower than 33, Music
		cp	0E0h
		jp	c, loc_6A9							; Check if sound to play is lower than E0, Sound effects
		cp	0E1h
		jp	c, sub_944							; Check if sound to play is lower than E1, Nothing
		cp	0E6h
		jp	nc, sub_944							; Check if sound to play is higher than E6 or equal, Nothing
		sub	0E1h								; If none of the checks passed, do fade effects.
		ld	hl, loc_524
		rst	18h
		xor	a
		ld	(1C18h), a
		jp	(hl)
; End of function sub_4FB
; ---------------------------------------------------------------------------

loc_524:
		ld	e, h
		ex	af, af'
		ld	b, h
		add	hl, bc
		cp	h
		add	hl, bc
		ld	l, 5
		ld	e, h
		ex	af, af'
		ld	ix, 1DF0h
		ld	b, 7
		ld	a, 1
		ld	(1C19h), a

loc_539:
		push	bc
		bit	7, (ix+0)
		call	nz, sub_54D
		ld	de, 30h	; '0'
		add	ix, de
		pop	bc
		djnz	loc_539
		call	sub_690
		ret

; =============== S U B	R O U T	I N E =======================================


sub_54D:

; FUNCTION CHUNK AT 0C7F SIZE 00000006 BYTES
; FUNCTION CHUNK AT 0D87 SIZE 000000B2 BYTES

		push	hl
		push	hl
		jp	loc_C7F
; End of function sub_54D

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_4FB

loc_552:
		ld	a, 32h ; '2'
		push	af
		jp	loc_5DB
; ---------------------------------------------------------------------------

loc_558:
		sub	1
		ret	m
		push	af
		cp	29h ; ')'
		jp	nz, loc_5DB
		ld	a, (1C29h)
		or	a
		jp	z, loc_580
		xor	a
		ld	(playSlot0), a
		ld	(playSlot1), a
		ld	(playSlot2), a
		ld	(1C05h), a
		ld	(1C06h), a
		ld	(1C07h), a
		ld	(1C09h), a
		pop	af
		ret
; ---------------------------------------------------------------------------

loc_580:
		ld	a, (1C16h)
		cp	29h ; ')'
		jp	z, loc_5DE
		xor	a
		ld	(playSlot0), a
		ld	(playSlot1), a
		ld	(playSlot2), a
		ld	(1C05h), a
		ld	(1C06h), a
		ld	(1C07h), a
		ld	a, (1C3Eh)
		ld	(1C2Dh), a
		ld	a, (tempoMod)
		ld	(1C2Eh), a
		xor	a
		ld	(tempoMod), a
		ld	hl, 1C40h
		ld	de, 1DF0h
		ld	bc, 1B0h
		ldir
		ld	hl, 1DF0h
		ld	de, 30h	; '0'
		ld	b, 9

loc_5BE:
		ld	a, (hl)
		and	7Fh ; ''
		set	2, (hl)
		ld	(hl), a
		add	hl, de
		djnz	loc_5BE
		ld	a, 29h ; ')'
		ld	(1C16h), a
		ld	a, (1C24h)
		ld	(1C2Ch), a
		ld	hl, (1C37h)
		ld	(1C2Ah), hl
		jp	loc_5DE
; ---------------------------------------------------------------------------

loc_5DB:
		call	sub_944

loc_5DE:
		pop	af
		push	af
		ld	hl, 0B65h
		add	a, l
		ld	l, a
		adc	a, h
		sub	l
		ld	h, a
		ld	(loc_5EB+1), hl

loc_5EB:
		ld	a, (z80_MusicBanks)
		ld	(1C3Eh), a
		ld	hl, zBankRegister
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		xor	a
		ld	(hl), a
		ld	a, 0B6h	; '∂'
		ld	(zYM2612_A1), a
		nop
		ld	a, 0C0h	; '¿'
		ld	(zYM2612_D1), a
		pop	af
		ld	c, 4
		rst	8
		rst	18h
		push	hl
		push	hl
		rst	20h
		ld	(1C37h), hl
		pop	hl
		pop	iy
		ld	a, (iy+5)
		ld	(1C13h), a
		ld	(1C24h), a
		ld	de, 6
		add	hl, de
		ld	(1C33h), hl
		ld	hl, loc_695
		ld	(1C35h), hl
		ld	de, 1C40h
		ld	b, (iy+2)
		ld	a, (iy+4)

loc_63D:
		push	bc
		ld	hl, (1C35h)
		ldi
		ldi
		ld	(de), a
		inc	de
		ld	(1C35h), hl
		ld	hl, (1C33h)
		ldi
		ldi
		ldi
		ldi
		ld	(1C33h), hl
		call	sub_7C5
		pop	bc
		djnz	loc_63D
		ld	a, (iy+3)
		or	a
		jp	z, sub_690
		ld	b, a
		ld	hl, 6A3h
		ld	(1C35h), hl
		ld	de, 1D60h
		ld	a, (iy+4)

loc_672:
		push	bc
		ld	hl, (1C35h)
		ldi
		ldi
		ld	(de), a
		inc	de
		ld	(1C35h), hl
		ld	hl, (1C33h)
		ld	bc, 6
		ldir
		ld	(1C33h), hl
		call	loc_7CC
		pop	bc
		djnz	loc_672
; END OF FUNCTION CHUNK	FOR sub_4FB

; =============== S U B	R O U T	I N E =======================================


sub_690:
		xor	a
		ld	(1C09h), a
		ret
; End of function sub_690

; ---------------------------------------------------------------------------
loc_695:
		db  80h	; Ä
		db    6
		db  80h	; Ä
		db    0
		db  80h	; Ä
		db    1
		db  80h	; Ä
		db    2
		db  80h	; Ä
		db    4
		db  80h	; Ä
		db    5
		db  80h	; Ä
		db    6
		db  80h	; Ä
		db  80h	; Ä
		db  80h	; Ä
		db 0A0h	; †
		db  80h	; Ä
		db 0C0h	; ¿
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_4FB

loc_6A9:
		sub	33h ; '3'
		or	a
		jp	nz, loc_6B7
		ld	a, (1C28h)
		xor	1
		ld	(1C28h), a

loc_6B7:
		ex	af, af'
		ld	a, zmake68kBank(SndBank)
		ld	hl, zBankRegister
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		xor	a
		ld	(hl), a
		xor	a
		ld	c, 6
		ld	(1C19h), a
		ex	af, af'
		cp	78h ; 'x'
		jp	z, loc_70C
		cp	89h ; 'â'
		jp	c, loc_706
		push	af
		ld	b, a
		ld	a, (1C25h)
		sub	b
		jp	nz, loc_6FB
		ld	a, 80h ; 'Ä'
		ld	(1C26h), a
		rst	8
		pop	af
		ld	c, a
		rst	18h
		inc	hl
		inc	hl
		inc	hl
		ld	a, (hl)
		ld	(1C31h), a
		jp	sub_690
; ---------------------------------------------------------------------------

loc_6FB:
		xor	a
		ld	(1C26h), a
		pop	af
		ld	(1C25h), a
		jp	loc_70C
; ---------------------------------------------------------------------------

loc_706:
		push	af
		xor	a
		ld	(1C27h), a
		pop	af

loc_70C:
		rst	8
		rst	18h
		push	hl
		rst	20h
		ld	(1C39h), hl
		xor	a
		ld	(1C15h), a
		pop	hl
		push	hl
		pop	iy
		ld	a, (iy+2)
		ld	(1C3Bh), a
		ld	de, 4
		add	hl, de
		ld	b, (iy+3)
		ld	a, b
		ld	(1C31h), a

loc_72C:
		push	bc
		push	hl
		inc	hl
		ld	c, (hl)
		call	sub_78F
		set	2, (hl)
		push	ix
		ld	a, (1C19h)
		or	a
		jr	z, loc_740
		pop	hl
		push	iy

loc_740:
		pop	de
		pop	hl
		ldi
		ld	a, (de)
		cp	2
		call	z, loc_979
		ldi
		ld	a, (1C3Bh)
		ld	(de), a
		inc	de
		ldi
		ldi
		ldi
		ldi
		call	sub_7C5
		bit	7, (ix+0)
		jr	z, loc_76E
		ld	a, (ix+1)
		cp	(iy+1)
		jr	nz, loc_76E
		set	2, (iy+0)

loc_76E:
		push	hl
		ld	hl, (1C39h)
		ld	a, (1C19h)
		or	a
		jr	z, loc_77C
		push	iy
		pop	ix

loc_77C:
		ld	(ix+2Ah), l
		ld	(ix+2Bh), h
		call	sub_35B
		call	sub_986
		pop	hl
		pop	bc
		djnz	loc_72C
		jp	sub_690
; END OF FUNCTION CHUNK	FOR sub_4FB

; =============== S U B	R O U T	I N E =======================================


sub_78F:
		bit	7, c
		jr	nz, loc_79B
		ld	a, c
		bit	2, a
		jr	z, loc_7B2
		dec	a
		jr	loc_7B2
; ---------------------------------------------------------------------------

loc_79B:				; CODE XREF: sub_78F+2j
		ld	a, 1Fh
		call	sub_1075
		ld	a, 0FFh
		ld	(7F11h), a
		ld	a, c
		srl	a
		srl	a
		srl	a
		srl	a
		srl	a
		add	a, 2

loc_7B2:
		sub	2
		ld	(1C32h), a
		push	af
		ld	hl, 7DFh
		rst	18h
		push	hl
		pop	ix
		pop	af
		ld	hl, 7EFh
		rst	18h
		ret
; End of function sub_78F


; =============== S U B	R O U T	I N E =======================================


sub_7C5:
		ex	af, af'
		xor	a
		ld	(de), a
		inc	de
		ld	(de), a
		inc	de
		ex	af, af'

loc_7CC:
		ex	de, hl
		ld	(hl), 30h ; '0'
		inc	hl
		ld	(hl), 0C0h ; '¿'
		inc	hl
		ld	(hl), 1
		ld	b, 24h ; '$'

loc_7D7:
		inc	hl
		ld	(hl), 0
		djnz	loc_7D7
		inc	hl
		ex	de, hl
		ret
; End of function sub_7C5

; ---------------------------------------------------------------------------
		db 0F0h	; 
		db  1Dh
		db  20h
		db  1Eh
		db  50h	; P
		db  1Eh
		db  80h	; Ä
		db  1Eh
		db 0B0h	; ∞
		db  1Eh
		db 0E0h	; ‡
		db  1Eh
		db  10h
		db  1Fh
		db  10h
		db  1Fh
		db 0D0h	; –
		db  1Ch
		db    0
		db  1Dh
		db  30h	; 0
		db  1Dh
		db  40h	; @
		db  1Ch
		db  60h	; `
		db  1Dh
		db  90h	; ê
		db  1Dh
		db 0C0h	; ¿
		db  1Dh
		db 0C0h	; ¿
		db  1Dh

; =============== S U B	R O U T	I N E =======================================


sub_7FF:

; FUNCTION CHUNK AT 098D SIZE 0000002F BYTES

		ld	hl, pauseFlag
		ld	a, (hl)
		or	a
		ret	z
		jp	m, loc_810
		pop	de
		dec	a
		ret	nz
		ld	(hl), 2
		jp	loc_98D
; ---------------------------------------------------------------------------

loc_810:
		xor	a
		ld	(hl), a
		ld	a, (1C0Dh)
		or	a
		jp	nz, sub_944
		ld	ix, 1C70h
		ld	b, 6

loc_81F:
		ld	a, (1C11h)
		or	a
		jr	nz, loc_82B
		bit	7, (ix+0)
		jr	z, loc_833

loc_82B:
		ld	c, (ix+0Ah)
		ld	a, 0B4h	; '¥'
		call	sub_AF

loc_833:
		ld	de, 30h	; '0'
		add	ix, de
		djnz	loc_81F
		ld	ix, 1F40h
		ld	b, 7

loc_840:
		bit	7, (ix+0)
		jr	z, loc_854
		bit	7, (ix+1)
		jr	nz, loc_854
		ld	c, (ix+0Ah)
		ld	a, 0B4h	; '¥'
		call	sub_AF

loc_854:
		ld	de, 30h	; '0'
		add	ix, de
		djnz	loc_840
		ret
; End of function sub_7FF

; ---------------------------------------------------------------------------
		db  3Eh	; >
		db  28h	; (
		db  32h	; 2
		db  0Dh
		db  1Ch
		db  3Eh	; >
		db    6
		db  32h	; 2
		db  0Fh
		db  1Ch
		db  32h	; 2
		db  0Eh
		db  1Ch

; =============== S U B	R O U T	I N E =======================================


sub_869:
		xor	a
		ld	(1C40h), a
		ld	(1DC0h), a
		ld	(1D60h), a
		ld	(1D90h), a
		jp	sub_9BC
; End of function sub_869


; =============== S U B	R O U T	I N E =======================================


sub_879:
		ld	hl, 1C0Dh
		ld	a, (hl)
		or	a
		ret	z
		call	m, sub_869
		res	7, (hl)
		ld	a, (1C0Fh)
		dec	a
		jr	z, loc_88E
		ld	(1C0Fh), a
		ret
; ---------------------------------------------------------------------------

loc_88E:
		ld	a, (1C0Eh)
		ld	(1C0Fh), a
		ld	a, (1C0Dh)
		dec	a
		ld	(1C0Dh), a
		jp	z, sub_944
		ld	a, (1C3Eh)
		ld	hl, zBankRegister
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		xor	a
		ld	(hl), a
		ld	ix, 1C40h
		ld	b, 6

loc_8BB:				; CODE XREF: sub_879+63j
		inc	(ix+6)
		jp	p, loc_8C6
		dec	(ix+6)
		jr	loc_8D7
; ---------------------------------------------------------------------------

loc_8C6:				; CODE XREF: sub_879+45j
		bit	7, (ix+0)
		jr	z, loc_8D7
		bit	2, (ix+0)
		jr	nz, loc_8D7
		push	bc
		call	sub_CBA
		pop	bc

loc_8D7:				; CODE XREF: sub_879+4Bj sub_879+51j ...
		ld	de, 30h	; '0'
		add	ix, de
		djnz	loc_8BB
		ret
; End of function sub_879


; =============== S U B	R O U T	I N E =======================================


sub_8DF:				; CODE XREF: sub_11B+Cp
		ld	a, (1C29h)
		or	a
		ret	z
		ld	a, (1C3Eh)
		ld	hl, zBankRegister
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		xor	a
		ld	(hl), a
		ld	a, (1C0Eh)
		dec	a
		ld	(1C0Eh), a
		ret	nz
		ld	a, (1C0Fh)
		ld	(1C0Eh), a
		ld	b, 5
		ld	ix, 1C70h
		ld	de, 30h	; '0'

loc_912:				; CODE XREF: sub_8DF+41j
		ld	a, (ix+6)
		dec	a
		ld	(ix+6),	a
		push	bc
		call	sub_CBA
		pop	bc
		add	ix, de
		djnz	loc_912
		ld	a, (1C29h)
		dec	a
		ld	(1C29h), a
		ret	nz
		ld	b, 3
		ld	ix, 1D60h
		ld	de, 30h	; '0'

loc_933:				; CODE XREF: sub_8DF+5Aj
		res	2, (ix+0)
		add	ix, de
		djnz	loc_933
		ld	ix, 1C40h
		res	2, (ix+0)
		ret
; End of function sub_8DF


; =============== S U B	R O U T	I N E =======================================

; Blank slot?
sub_944:
		ld	hl, 1C0Dh
		ld	de, 1C0Eh
		ld	bc, 3C6h
		ld	(hl), 0
		ldir
		xor	a
		ld	(tempoMod), a
		ld	ix, loc_695
		ld	b, 6

loc_95B:
		push	bc
		call	sub_9F6
		call	sub_986
		inc	ix
		inc	ix
		pop	bc
		djnz	loc_95B
		ld	b, 7
		xor	a
		ld	(1C0Dh), a
		call	sub_9BC
		ld	c, 0
		ld	a, 2Bh ; '+'
		call	sub_C2

loc_979:
		xor	a
		ld	(1C12h), a
		ld	c, a
		ld	a, 27h ; '''
		call	sub_C2
		jp	sub_690
; End of function sub_944


; =============== S U B	R O U T	I N E =======================================


sub_986:
		ld	a, 90h ; 'ê'
		ld	c, 0
		jp	sub_A0A
; End of function sub_986

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_7FF

loc_98D:				; CODE XREF: sub_7FF+Ej
		call	sub_9BC
		push	bc
		push	af
		ld	b, 3
		ld	a, 0B4h	; '¥'
		ld	c, 0

loc_998:				; CODE XREF: sub_7FF+19Fj
		push	af
		call	sub_C2
		pop	af
		inc	a
		djnz	loc_998
		ld	b, 2
		ld	a, 0B4h	; '¥'

loc_9A4:				; CODE XREF: sub_7FF+1ABj
		push	af
		call	sub_CD
		pop	af
		inc	a
		djnz	loc_9A4
		ld	c, 0
		ld	b, 6
		ld	a, 28h ; '('

loc_9B2:				; CODE XREF: sub_7FF+1B9j
		push	af
		call	sub_C2
		inc	c
		pop	af
		djnz	loc_9B2
		pop	af
		pop	bc
; END OF FUNCTION CHUNK	FOR sub_7FF

; =============== S U B	R O U T	I N E =======================================


sub_9BC:
		push	bc
		ld	b, 4
		ld	a, 9Fh ; 'ü'

loc_9C1:
		ld	(7F11h), a
		add	a, 20h ; ' '
		djnz	loc_9C1
		pop	bc
		jp	sub_690
; End of function sub_9BC


; =============== S U B	R O U T	I N E =======================================


sub_9CC:
		ld	a, (1C24h)
		ld	hl, 1C13h
		add	a, (hl)
		ld	(hl), a
		ret	nc
		ld	hl, 1C4Bh
		ld	de, 30h	; '0'
		ld	b, 9

loc_9DD:
		inc	(hl)
		add	hl, de
		djnz	loc_9DD
		ret
; End of function sub_9CC


; =============== S U B	R O U T	I N E =======================================


sub_9E2:
		ld	hl, playSlot0
		ld	de, 1C05h
		ldi
		ldi
		ldi
		xor	a
		dec	hl
		ld	(hl), a
		dec	hl
		ld	(hl), a
		dec	hl
		ld	(hl), a
		ret
; End of function sub_9E2


; =============== S U B	R O U T	I N E =======================================


sub_9F6:

; FUNCTION CHUNK AT 0367 SIZE 00000006 BYTES

		call	sub_A06
		ld	a, 40h ; '@'
		ld	c, 7Fh ; ''
		call	sub_A0A
		ld	c, (ix+1)
		jp	loc_367
; End of function sub_9F6


; =============== S U B	R O U T	I N E =======================================


sub_A06:
		ld	a, 80h ; 'Ä'
		ld	c, 0FFh
; End of function sub_A06


; =============== S U B	R O U T	I N E =======================================


sub_A0A:
		ld	b, 4

loc_A0C:
		push	af
		call	sub_AF
		pop	af
		add	a, 4
		djnz	loc_A0C
		ret
; End of function sub_A0A

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_4FB

loc_A16:
		call	sub_944
		ld	a, 1
		ld	(1C3Fh), a
		pop	hl
		ret
; END OF FUNCTION CHUNK	FOR sub_4FB

; =============== S U B	R O U T	I N E =======================================


sub_A20:
		xor	a
		ld	(1C16h), a
		ld	a, (1C2Ch)
		ld	(1C24h), a
		ld	a, (1C2Eh)
		ld	(tempoMod), a
		ld	hl, (1C2Ah)
		ld	(1C37h), hl
		ld	a, (1C2Dh)
		ld	(1C3Eh), a
		ld	hl, zBankRegister
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		xor	a
		ld	(hl), a
		ld	hl, 1DF0h
		ld	de, 1C40h
		ld	bc, 1B0h
		ldir
		ld	a, (1C40h)
		or	84h ; 'Ñ'
		ld	(1C40h), a
		ld	ix, 1C70h
		ld	b, 8

loc_A69:
		ld	a, (ix+0)
		or	84h ; 'Ñ'
		ld	(ix+0),	a
		bit	7, (ix+1)
		jp	nz, loc_A90
		res	2, (ix+0)
		ld	a, (ix+6)
		add	a, 40h ; '@'
		ld	(ix+6),	a
		ld	a, (ix+8)
		push	bc
		ld	b, a
		call	sub_483
		call	sub_4B9
		pop	bc

loc_A90:
		ld	de, 30h	; '0'
		add	ix, de
		djnz	loc_A69
		ld	a, 40h ; '@'
		ld	(1C29h), a
		ld	a, 2
		ld	(1C0Fh), a
		ld	(1C0Eh), a
		ret
; End of function sub_A20

; ---------------------------------------------------------------------------
loc_AA5:
		db 0FFh
		db    3
		db 0FFh
		db    3
		db 0FFh
		db    3
		db 0FFh
		db    3
		db 0FFh
		db    3
		db 0FFh
		db    3
		db 0FFh
		db    3
		db 0FFh
		db    3
		db 0FFh
		db    3
		db 0F7h	; ˜
		db    3
		db 0BEh	; æ
		db    3
		db  88h	; à
		db    3
		db  56h	; V
		db    3
		db  26h	; &
		db    3
		db 0F9h	; ˘
		db    2
		db 0CEh	; Œ
		db    2
		db 0A5h	; •
		db    2
		db  80h	; Ä
		db    2
		db  5Ch	; /		; S
		db    2
		db  3Ah	; :
		db    2
		db  1Ah
		db    2
		db 0FBh	; ˚
		db    1
		db 0DFh	; ﬂ
		db    1
		db 0C4h	; ƒ
		db    1
		db 0ABh	; ´
		db    1
		db  93h	; ì
		db    1
		db  7Dh	; }
		db    1
		db  67h	; g
		db    1
		db  53h	; S
		db    1
		db  40h	; @
		db    1
		db  2Eh	; .
		db    1
		db  1Dh
		db    1
		db  0Dh
		db    1
		db 0FEh	; ˛
		db    0
		db 0EFh	; Ô
		db    0
		db 0E2h	; ‚
		db    0
		db 0D6h	; ÷
		db    0
		db 0C9h	; …
		db    0
		db 0BEh	; æ
		db    0
		db 0B4h	; ¥
		db    0
		db 0A9h	; ©
		db    0
		db 0A0h	; †
		db    0
		db  97h	; ó
		db    0
		db  8Fh	; è
		db    0
		db  87h	; á
		db    0
		db  7Fh	; 
		db    0
		db  78h	; x
		db    0
		db  71h	; q
		db    0
		db  6Bh	; k
		db    0
		db  65h	; e
		db    0
		db  5Fh	; _
		db    0
		db  5Ah	; Z
		db    0
		db  55h	; U
		db    0
		db  50h	; P
		db    0
		db  4Bh	; K
		db    0
		db  47h	; G
		db    0
		db  43h	; C
		db    0
		db  40h	; @
		db    0
		db  3Ch	; <
		db    0
		db  39h	; 9
		db    0
		db  36h	; 6
		db    0
		db  33h	; 3
		db    0
		db  30h	; 0
		db    0
		db  2Dh	; -
		db    0
		db  2Bh	; +
		db    0
		db  28h	; (
		db    0
		db  26h	; &
		db    0
		db  24h	; $
		db    0
		db  22h	; "
		db    0
		db  20h
		db    0
		db  1Fh
		db    0
		db  1Dh
		db    0
		db  1Bh
		db    0
		db  1Ah
		db    0
		db  18h
		db    0
		db  17h
		db    0
		db  16h
		db    0
		db  15h
		db    0
		db  13h
		db    0
		db  12h
		db    0
		db  11h
		db    0
		db  10h
		db    0
		db    0
		db    0
		db    0
		db    0
		db  84h	; Ñ
		db    2
		db 0ABh	; ´
		db    2
		db 0D3h	; ”
		db    2
		db 0FEh	; ˛
		db    2
		db  2Dh	; -
		db    3
		db  5Ch	; /		; S
		db    3
		db  8Fh	; è
		db    3
		db 0C5h	; ≈
		db    3
		db 0FFh
		db    3
		db  3Ch	; <
		db    4
		db  7Ch	; |
		db    4
		db 0C0h	; ¿
		db    4
; ---------------------------------------------------------------------------
; ===========================================================================
; MUSIC BANKS
; ===========================================================================
z80_MusicBanks:
		db  zmake68kBank(Snd_AIZ1),zmake68kBank(Snd_AIZ2),zmake68kBank(Snd_HCZ1),zmake68kBank(Snd_HCZ2)
		db  zmake68kBank(Snd_MGZ1),zmake68kBank(Snd_MGZ2),zmake68kBank(Snd_CNZ1),zmake68kBank(Snd_CNZ2)
		db  zmake68kBank(Snd_FBZ1),zmake68kBank(Snd_FBZ2),zmake68kBank(Snd_ICZ1),zmake68kBank(Snd_ICZ2)
		db  zmake68kBank(Snd_LBZ1),zmake68kBank(Snd_LBZ2),zmake68kBank(Snd_MHZ1),zmake68kBank(Snd_MHZ2)

		db  zmake68kBank(Snd_SOZ1),zmake68kBank(Snd_SOZ2),zmake68kBank(Snd_LRZ1),zmake68kBank(Snd_LRZ2)
		db  zmake68kBank(Snd_SSZ),zmake68kBank(Snd_DEZ1),zmake68kBank(Snd_DEZ2),zmake68kBank(Snd_Minib_SK)
		db  zmake68kBank(Snd_Boss),zmake68kBank(Snd_DDZ),zmake68kBank(Snd_PachBonus),zmake68kBank(Snd_SpecialS)
		db  zmake68kBank(Snd_SlotBonus),zmake68kBank(Snd_GumBonus),zmake68kBank(Snd_Knux),zmake68kBank(Snd_ALZ)

		db  zmake68kBank(Snd_BPZ),zmake68kBank(Snd_DPZ),zmake68kBank(Snd_CGZ),zmake68kBank(Snd_EMZ)
		db  zmake68kBank(Snd_Title),zmake68kBank(Snd_S3Credits),zmake68kBank(Snd_GameOver),zmake68kBank(Snd_Continue)
		db  zmake68kBank(Snd_Results),zmake68kBank(Snd_1UP),zmake68kBank(Snd_Emerald),zmake68kBank(Snd_Invic)
		db  zmake68kBank(Snd_2PMenu),zmake68kBank(Snd_Minib_SK),zmake68kBank(Snd_Menu),zmake68kBank(Snd_FinalBoss)

		db  zmake68kBank(Snd_Drown),zmake68kBank(Snd_PresSega),zmake68kBank(Snd_SKCredits)


; =============== S U B	R O U T	I N E =======================================


sub_B98:
		call	sub_33A
		ret	nz
		ld	e, (ix+3)
		ld	d, (ix+4)
		ld	a, (de)
		inc	de
		cp	0E0h ; '‡'
		jp	nc, loc_BE3
		or	a
		jp	m, loc_BB1
		dec	de
		ld	a, (ix+0Dh)

loc_BB1:
		ld	(ix+0Dh), a
		cp	80h ; 'Ä'
		jp	z, loc_BD3
		res	7, a
		push	de
		ex	af, af'
		call	sub_35B
		call	loc_979
		ex	af, af'
		ld	ix, 1C40h
		bit	2, (ix+0)
		jp	nz, loc_BD2
		ld	(1C30h), a

loc_BD2:
		pop	de

loc_BD3:
		ld	a, (de)
		inc	de
		or	a
		jp	p, loc_308
		dec	de
		ld	a, (ix+0Ch)
		ld	(ix+0Bh), a
		jp	loc_30E
; ---------------------------------------------------------------------------

loc_BE3:
		ld	hl, loc_BE9
		jp	loc_BF0
; ---------------------------------------------------------------------------
loc_BE9:
		db  13h
		db 0C3h	; √
		db 0A2h	; ¢
		db  0Bh
; ---------------------------------------------------------------------------

loc_BED:
		ld	hl, 0BF9h

loc_BF0:
		push	hl
		sub	0E0h ; '‡'
		ld	hl, loc_BFD
		rst	18h
		ld	a, (de)
		jp	(hl)
; End of function sub_B98

; ---------------------------------------------------------------------------
		inc	de
		jp	loc_285
; ---------------------------------------------------------------------------
loc_BFD:
		dw sub_C51
		dw sub_C77
		dw sub_C7B
		dw loc_C7F
		dw loc_C85
		dw loc_CA1
		dw loc_CA3
		dw loc_CDB
		dw loc_CE1
		dw sub_C65
		dw sub_C4D
		dw loc_CEB
		dw loc_D01
		dw loc_D1B
		dw loc_D21
		dw loc_D2E
		dw loc_D6D
		dw loc_D7B
		dw loc_D87
		dw loc_E39
		dw loc_D83
		dw loc_E58
		dw loc_E61
		dw loc_E67
		dw loc_E7E
		dw loc_E98
		dw loc_EAB
		dw loc_EB1
		dw loc_EB8
		dw loc_EDA
		dw loc_EE8
		dw loc_F2F
loc_C3D:
		dw loc_F36
		dw loc_F3A
		dw loc_F42
		dw loc_F7D
		dw loc_F8B
		dw loc_F9A
		dw loc_FB5
		dw loc_FBE

; =============== S U B	R O U T	I N E =======================================


sub_C4D:				; DATA XREF: ROM:0C11o
		ld	(1C30h), a
		ret
; End of function sub_C4D


; =============== S U B	R O U T	I N E =======================================


sub_C51:				; DATA XREF: ROM:0BFDo
		ld	c, 3Fh ; '?'
		ld	a, (ix+0Ah)
		and	c
		push	de
		ex	de, hl
		or	(hl)
		ld	(ix+0Ah), a
		ld	c, a
		ld	a, 0B4h	; '¥'
		call	sub_AF
		pop	de
		ret
; End of function sub_C51


; =============== S U B	R O U T	I N E =======================================


sub_C65:				; DATA XREF: ROM:0C0Fo
		ld	hl, 1C27h
		ld	a, (hl)
		add	a, (ix+5)
		ld	(ix+5),	a
		cp	10h
		jp	z, loc_C75
		inc	(hl)

loc_C75:				; CODE XREF: sub_C65+Cj
		dec	de
		ret
; End of function sub_C65


; =============== S U B	R O U T	I N E =======================================


sub_C77:				; DATA XREF: ROM:0BFFo
		ld	(ix+10h), a
		ret
; End of function sub_C77


; =============== S U B	R O U T	I N E =======================================


sub_C7B:				; DATA XREF: ROM:0C01o
		ld	(1C16h), a
		ret
; End of function sub_C7B

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_54D

loc_C7F:				; CODE XREF: sub_54D+2j
					; DATA XREF: ROM:0C03o
		call	sub_9F6
		jp	loc_D87
; END OF FUNCTION CHUNK	FOR sub_54D
; ---------------------------------------------------------------------------

loc_C85:				; DATA XREF: ROM:0C05o
		bit	7, (ix+1)
		jr	z, loc_C98
		srl	a
		srl	a
		srl	a
		xor	0Fh
		and	0Fh
		jp	loc_D17
; ---------------------------------------------------------------------------

loc_C98:				; CODE XREF: ROM:0C89j
		xor	7Fh ; ''
		and	7Fh ; ''
		ld	(ix+6),	a
		jr	sub_CBA
; ---------------------------------------------------------------------------

loc_CA1:				; DATA XREF: ROM:0C07o
		inc	de
		ld	a, (de)

loc_CA3:				; DATA XREF: ROM:0C09o
		bit	7, (ix+1)
		ret	nz
		add	a, (ix+6)
		jp	p, loc_CB7
		jp	pe, loc_CB5
		xor	a
		jp	loc_CB7
; ---------------------------------------------------------------------------

loc_CB5:				; CODE XREF: ROM:0CAEj
		ld	a, 7Fh ; ''

loc_CB7:				; CODE XREF: ROM:0CABj	ROM:0CB2j
		ld	(ix+6),	a

; =============== S U B	R O U T	I N E =======================================


sub_CBA:				; CODE XREF: sub_4B9+1Ej sub_879+5Ap ...
		push	de
		ld	de, 4B1h
		ld	l, (ix+1Ch)
		ld	h, (ix+1Dh)
		ld	b, 4

loc_CC6:				; CODE XREF: sub_CBA+1Dj
		ld	a, (hl)
		or	a
		jp	p, loc_CCE
		add	a, (ix+6)

loc_CCE:				; CODE XREF: sub_CBA+Ej
		and	7Fh ; ''
		ld	c, a
		ld	a, (de)
		call	sub_AF
		inc	de
		inc	hl
		djnz	loc_CC6
		pop	de
		ret
; End of function sub_CBA

; ---------------------------------------------------------------------------

loc_CDB:				; DATA XREF: ROM:0C0Bo
		set	1, (ix+0)
		dec	de
		ret
; ---------------------------------------------------------------------------

loc_CE1:				; DATA XREF: ROM:0C0Do
		call	sub_330
		ld	(ix+1Eh), a
		ld	(ix+1Fh), a
		ret
; ---------------------------------------------------------------------------

loc_CEB:				; DATA XREF: ROM:0C13o
		inc	de
		add	a, 28h ; '('
		ld	c, a
		ld	b, 0
		push	ix
		pop	hl
		add	hl, bc
		ld	a, (hl)
		dec	a
		jp	z, loc_CFC
		inc	de
		ret
; ---------------------------------------------------------------------------

loc_CFC:				; CODE XREF: ROM:0CF7j
		xor	a
		ld	(hl), a
		jp	loc_E61
; ---------------------------------------------------------------------------

loc_D01:				; DATA XREF: ROM:0C15o
		bit	7, (ix+1)
		ret	z
		res	4, (ix+0)
		dec	(ix+17h)
		add	a, (ix+6)
		cp	0Fh
		jp	c, loc_D17
		ld	a, 0Fh

loc_D17:				; CODE XREF: ROM:0C95j	ROM:0D12j
		ld	(ix+6),	a
		ret
; ---------------------------------------------------------------------------

loc_D1B:				; DATA XREF: ROM:0C17o
		sub	40h ; '@'
		ld	(ix+5),	a
		ret
; ---------------------------------------------------------------------------

loc_D21:				; DATA XREF: ROM:0C19o
		call	sub_D28
		call	sub_C2
		ret

; =============== S U B	R O U T	I N E =======================================


sub_D28:				; CODE XREF: ROM:loc_D21p
		ex	de, hl
		ld	a, (hl)
		inc	hl
		ld	c, (hl)
		ex	de, hl
		ret
; End of function sub_D28

; ---------------------------------------------------------------------------

loc_D2E:				; DATA XREF: ROM:0C1Bo
		bit	7, (ix+1)
		jr	nz, loc_D64
		call	sub_A06
		ld	a, (de)
		ld	(ix+8),	a
		or	a
		jp	p, loc_D5A
		inc	de
		ld	a, (de)
		ld	(ix+0Fh), a

; =============== S U B	R O U T	I N E =======================================


sub_D44:				; CODE XREF: sub_54D+88Ap
		push	de
		ld	a, (ix+0Fh)
		sub	81h ; 'Å'
		ld	c, 4
		rst	8
		rst	18h
		rst	20h
		ld	a, (ix+8)
		and	7Fh ; ''
		ld	b, a
		call	loc_492
		jr	loc_D5F
; ---------------------------------------------------------------------------

loc_D5A:				; CODE XREF: ROM:0D3Cj
		push	de
		ld	b, a
		call	sub_483

loc_D5F:				; CODE XREF: sub_D44+14j
		call	sub_4B9
		pop	de
		ret
; End of function sub_D44

; ---------------------------------------------------------------------------

loc_D64:				; CODE XREF: ROM:0D32j
		or	a
		jp	p, loc_E5D
		inc	de
		jp	loc_E5D
; ---------------------------------------------------------------------------
		ret
; ---------------------------------------------------------------------------

loc_D6D:				; DATA XREF: ROM:0C1Do
		ld	(ix+20h), e
		ld	(ix+21h), d
		ld	(ix+7),	80h ; 'Ä'
		inc	de
		inc	de
		inc	de
		ret
; ---------------------------------------------------------------------------

loc_D7B:				; DATA XREF: ROM:0C1Fo
		inc	de
		bit	7, (ix+1)
		jr	nz, loc_D83
		ld	a, (de)

loc_D83:				; CODE XREF: ROM:0D80j
					; DATA XREF: ROM:0C25o
		ld	(ix+7),	a
		ret
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_54D

loc_D87:				; CODE XREF: sub_54D+735j
					; DATA XREF: ROM:0C21o
		res	7, (ix+0)
		ld	a, 1Fh
		ld	(1C15h), a
		call	sub_35B
		ld	c, (ix+1)
		push	ix
		call	sub_78F
		ld	a, (1C19h)
		or	a
		jp	z, loc_E22
		xor	a
		ld	(1C18h), a
		push	hl
		ld	hl, (1C37h)
		pop	ix
		res	2, (ix+0)
		bit	7, (ix+1)
		jr	nz, loc_E27
		bit	7, (ix+0)
		jr	z, loc_E22
		ld	a, 2
		cp	(ix+1)
		jr	nz, loc_DD0
		ld	a, 4Fh ; 'O'
		bit	0, (ix+0)
		jr	nz, loc_DCD
		and	0Fh

loc_DCD:				; CODE XREF: sub_54D+87Cj
		call	sub_F11

loc_DD0:				; CODE XREF: sub_54D+874j
		ld	a, (ix+8)
		or	a
		jp	p, loc_DDC
		call	sub_D44
		jr	loc_E1F
; ---------------------------------------------------------------------------

loc_DDC:				; CODE XREF: sub_54D+887j
		ld	b, a
		push	hl
		ld	hl, zBankRegister
		ld	a, (1C3Eh)
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		xor	a
		ld	(hl), a
		pop	hl
		call	loc_492
		call	sub_4B9
		ld	a, zmake68kBank(SndBank)
		ld	hl, zBankRegister
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		rra
		ld	(hl), a
		xor	a
		ld	(hl), a
		ld	a, (ix+18h)
		or	a
		jp	p, loc_E22
		ld	e, (ix+19h)
		ld	d, (ix+1Ah)

loc_E1F:				; CODE XREF: sub_54D+88Dj
		call	sub_FA4

loc_E22:				; CODE XREF: sub_54D+852j sub_54D+86Dj ...
		pop	ix
		pop	hl
		pop	hl
		ret
; ---------------------------------------------------------------------------

loc_E27:				; CODE XREF: sub_54D+867j
		bit	0, (ix+0)
		jr	z, loc_E22
		ld	a, (ix+1Ah)
		or	a
		jp	p, loc_E37
		ld	(7F11h), a

loc_E37:				; CODE XREF: sub_54D+8E4j
		jr	loc_E22
; END OF FUNCTION CHUNK	FOR sub_54D
; ---------------------------------------------------------------------------

loc_E39:				; DATA XREF: ROM:0C23o
		bit	2, (ix+1)
		ret	nz
		ld	a, 0DFh	; 'ﬂ'
		ld	(7F11h), a
		ld	a, (de)
		ld	(ix+1Ah), a
		set	0, (ix+0)
		or	a
		jr	nz, loc_E54
		res	0, (ix+0)
		ld	a, 0FFh

loc_E54:				; CODE XREF: ROM:0E4Cj
		ld	(7F11h), a
		ret
; ---------------------------------------------------------------------------

loc_E58:				; DATA XREF: ROM:0C27o
		bit	7, (ix+1)
		ret	z

loc_E5D:				; CODE XREF: ROM:0D65j	ROM:0D69j
		ld	(ix+8),	a
		ret
; ---------------------------------------------------------------------------

loc_E61:				; CODE XREF: ROM:0CFEj	ROM:0E79j ...
		ex	de, hl
		ld	e, (hl)
		inc	hl
		ld	d, (hl)
		dec	de
		ret
; ---------------------------------------------------------------------------

loc_E67:				; DATA XREF: ROM:0C2Bo
		inc	de
		add	a, 28h ; '('
		ld	c, a
		ld	b, 0
		push	ix
		pop	hl
		add	hl, bc
		ld	a, (hl)
		or	a
		jr	nz, loc_E77
		ld	a, (de)
		ld	(hl), a

loc_E77:				; CODE XREF: ROM:0E73j
		inc	de
		dec	(hl)
		jp	nz, loc_E61
		inc	de
		ret
; ---------------------------------------------------------------------------

loc_E7E:				; DATA XREF: ROM:0C2Do
		ld	c, a
		inc	de
		ld	a, (de)
		ld	b, a
		push	bc
		push	ix
		pop	hl
		dec	(ix+9)
		ld	c, (ix+9)
		dec	(ix+9)
		ld	b, 0
		add	hl, bc
		ld	(hl), d
		dec	hl
		ld	(hl), e
		pop	de
		dec	de
		ret
; ---------------------------------------------------------------------------

loc_E98:				; DATA XREF: ROM:0C2Fo
		push	ix
		pop	hl
		ld	c, (ix+9)
		ld	b, 0
		add	hl, bc
		ld	e, (hl)
		inc	hl
		ld	d, (hl)
		inc	(ix+9)
		inc	(ix+9)
		ret
; ---------------------------------------------------------------------------

loc_EAB:				; DATA XREF: ROM:0C31o
		res	7, (ix+7)
		dec	de
		ret
; ---------------------------------------------------------------------------

loc_EB1:				; DATA XREF: ROM:0C33o
		add	a, (ix+5)
		ld	(ix+5),	a
		ret
; ---------------------------------------------------------------------------

loc_EB8:				; DATA XREF: ROM:0C35o
		ld	a, (1C26h)
		cp	80h ; 'Ä'
		jp	z, loc_EC9
		xor	a
		ld	(1C25h), a
		ld	(1C26h), a
		inc	de
		ret
; ---------------------------------------------------------------------------

loc_EC9:				; CODE XREF: ROM:0EBDj
		ld	a, (1C31h)
		dec	a
		ld	(1C31h), a
		jp	nz, loc_E61
		xor	a
		ld	(1C26h), a
		jp	loc_E61
; ---------------------------------------------------------------------------

loc_EDA:				; DATA XREF: ROM:0C37o
		cp	1
		jr	nz, loc_EE3
		set	3, (ix+0)
		ret
; ---------------------------------------------------------------------------

loc_EE3:				; CODE XREF: ROM:0EDCj
		res	3, (ix+0)
		ret
; ---------------------------------------------------------------------------

loc_EE8:				; DATA XREF: ROM:0C39o
		ld	a, (ix+1)
		cp	2
		jr	nz, loc_F1B
		set	0, (ix+0)
		ex	de, hl
		call	nullsub_A
		ld	b, 4

loc_EF9:				; CODE XREF: ROM:0F0Bj
		push	bc
		ld	a, (hl)
		inc	hl
		push	hl
		ld	hl, loc_F1F
		add	a, a
		ld	c, a
		ld	b, 0
		add	hl, bc
		ldi
		ldi
		pop	hl
		pop	bc
		djnz	loc_EF9
		ex	de, hl
		dec	de
		ld	a, 4Fh ; 'O'

; =============== S U B	R O U T	I N E =======================================


sub_F11:				; CODE XREF: sub_54D:loc_DCDp
		ld	(1C12h), a
		ld	c, a
		ld	a, 27h ; '''
		call	sub_C2
		ret
; End of function sub_F11

; ---------------------------------------------------------------------------

loc_F1B:
		inc	de
		inc	de
		inc	de
		ret
; ---------------------------------------------------------------------------
loc_F1F:
		dw 0
		dw 132h
		dw 18Eh
		dw 1E4h
		dw 234h
		dw 27Eh
		dw 2C2h
		dw 2F0h
; ---------------------------------------------------------------------------

loc_F2F:
		ld	hl, loc_C3D
		rst	18h
		inc	de
		ld	a, (de)
		jp	(hl)
; ---------------------------------------------------------------------------

loc_F36:
		ld	(1C24h), a
		ret
; ---------------------------------------------------------------------------

loc_F3A:
		push	ix
		call	sub_4FB
		pop	ix
		ret
; ---------------------------------------------------------------------------

loc_F42:
		ld	(1C11h), a
		or	a
		jr	z, loc_F65
		push	ix
		push	de
		ld	ix, 1C40h
		ld	b, 9
		ld	de, 30h	; '0'

loc_F54:
		res	7, (ix+0)
		call	loc_361
		add	ix, de
		djnz	loc_F54
		pop	de
		pop	ix
		jp	sub_9BC
; ---------------------------------------------------------------------------

loc_F65:
		push	ix
		push	de
		ld	ix, 1C40h
		ld	b, 9
		ld	de, 30h	; '0'

loc_F71:
		set	7, (ix+0)
		add	ix, de
		djnz	loc_F71
		pop	de
		pop	ix
		ret
; ---------------------------------------------------------------------------

loc_F7D:
		ex	de, hl
		ld	e, (hl)
		inc	hl
		ld	d, (hl)
		inc	hl
		ld	c, (hl)
		ld	b, 0
		inc	hl
		ex	de, hl
		ldir
		dec	de
		ret
; ---------------------------------------------------------------------------

loc_F8B:
		ld	b, 9
		ld	hl, 1C42h

loc_F90:
		push	bc
		ld	bc, 30h	; '0'
		ld	(hl), a
		add	hl, bc
		pop	bc
		djnz	loc_F90
		ret
; ---------------------------------------------------------------------------

loc_F9A:
		ld	(ix+18h), 80h ;	'Ä'
		ld	(ix+19h), e
		ld	(ix+1Ah), d

; =============== S U B	R O U T	I N E =======================================


sub_FA4:
		ld	hl, 4B5h
		ld	b, 4

loc_FA9:
		ld	a, (de)
		inc	de
		ld	c, a
		ld	a, (hl)
		inc	hl
		call	sub_AF
		djnz	loc_FA9
		dec	de
		ret
; End of function sub_FA4

; ---------------------------------------------------------------------------

loc_FB5:
		ld	(ix+18h), a
		inc	de
		ld	a, (de)
		ld	(ix+19h), a
		ret
; ---------------------------------------------------------------------------

loc_FBE:
		xor	a
		ld	(1C27h), a
		dec	de
		ret
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1E9

loc_FC4:
		call	sub_33A
		jr	nz, loc_FD6
		call	sub_277
		bit	4, (ix+0)
		ret	nz
		call	sub_39E
		jr	loc_FE2
; ---------------------------------------------------------------------------

loc_FD6:
		ld	a, (ix+1Eh)
		or	a
		jr	z, loc_FE2
		dec	(ix+1Eh)
		jp	z, sub_106C

loc_FE2:
		call	sub_46F
		call	sub_3C9
		bit	2, (ix+0)
		ret	nz
		ld	c, (ix+1)
		ld	a, l
		and	0Fh
		or	c
		ld	(7F11h), a
		ld	a, l
		and	0F0h ; ''
		or	h
		rrca
		rrca
		rrca
		rrca
		ld	(7F11h), a
		ld	a, (ix+8)
		or	a
		ld	c, 0
		jr	z, loc_1013
		dec	a
		ld	c, 0Ah
		rst	8
		rst	18h
		call	sub_103A
		ld	c, a

loc_1013:
		bit	4, (ix+0)
		ret	nz
		ld	a, (ix+6)
		add	a, c
		bit	4, a
		jr	z, loc_1022
		ld	a, 0Fh

loc_1022:
		or	(ix+1)
		add	a, 10h
		bit	0, (ix+0)
		jr	nz, loc_1031
		ld	(7F11h), a
		ret
; ---------------------------------------------------------------------------

loc_1031:
		add	a, 20h ; ' '
		ld	(7F11h), a
		ret
; END OF FUNCTION CHUNK	FOR sub_1E9
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_103A

loc_1037:
		ld	(ix+17h), a
; END OF FUNCTION CHUNK	FOR sub_103A

; =============== S U B	R O U T	I N E =======================================


sub_103A:

; FUNCTION CHUNK AT 1037 SIZE 00000003 BYTES

		push	hl
		ld	c, (ix+17h)
		ld	b, 0
		add	hl, bc
		ld	a, (hl)
		pop	hl
		bit	7, a
		jr	z, loc_1068
		cp	83h ; 'É'
		jr	z, loc_1057
		cp	81h ; 'Å'
		jr	z, loc_1062
		cp	80h ; 'Ä'
		jr	z, loc_105F
		inc	bc
		ld	a, (bc)
		jr	loc_1037
; ---------------------------------------------------------------------------

loc_1057:
		set	4, (ix+0)
		pop	hl
		jp	sub_106C
; ---------------------------------------------------------------------------

loc_105F:
		xor	a
		jr	loc_1037
; ---------------------------------------------------------------------------

loc_1062:
		pop	hl
		set	4, (ix+0)
		ret
; ---------------------------------------------------------------------------

loc_1068:
		inc	(ix+17h)
		ret
; End of function sub_103A


; =============== S U B	R O U T	I N E =======================================


sub_106C:
		set	4, (ix+0)
		bit	2, (ix+0)
		ret	nz
; End of function sub_106C


; =============== S U B	R O U T	I N E =======================================


sub_1075:
		ld	a, 1Fh
		add	a, (ix+1)
		or	a
		ret	p
		ld	(7F11h), a
		bit	0, (ix+0)
		ret	z
		ld	a, 0FFh
		ld	(7F11h), a
		ret
; End of function sub_1075

; ---------------------------------------------------------------------------

loc_108A:
		di
		ld	a, 2Bh ; '+'
		ld	c, 0
		call	sub_C2

loc_1092:
		ei
		ld	a, (1C3Fh)
		or	a
		jp	nz, loc_1126
		ld	a, (1C30h)
		or	a
		jr	z, loc_1092
		ld	a, 2Bh ; '+'
		ld	c, 80h ; 'Ä'
		di
		call	sub_C2
		ei
		ld	iy, DecTable
		ld	hl, 1C30h
		ld	a, (hl)
		dec	a
		set	7, (hl)
		ld	hl, 8000h
		rst	18h
		ld	c, 80h ; 'Ä'
		ld	a, (hl)
		ld	(byte_10CB), a
		ld	(byte_10E8), a
		inc	hl
		ld	e, (hl)
		inc	hl
		ld	d, (hl)
		inc	hl
		ld	a, (hl)
		inc	hl
		ld	h, (hl)
		ld	l, a
; ---------------------------------------------------------------------------
		db    6
byte_10CB:
		db 0Ah
		db 0FBh	; ˚
		db  10h
		db 0FEh	; ˛
		db 0F3h	; Û
		db  3Eh	; >
		db  2Ah	; *
		db  32h	; 2
		db    0
		db  40h	; @
		db  7Eh	; ~
		db    7
		db    7
		db    7
		db    7
		db 0E6h	; Ê
		db  0Fh
		db  32h	; 2
		db 0E2h	; ‚
		db  10h
		db  79h	; y
		db 0FDh	; ˝
		db  86h	; Ü
		db 0
		db  32h	; 2
		db    1
		db  40h	; @
		db  4Fh	; O
		db    6
byte_10E8:
		db 0Ah
		db 0FBh	; ˚
		db  10h
		db 0FEh	; ˛
		db 0F3h	; Û
		db  3Eh	; >
		db  2Ah	; *
		db  32h	; 2
		db    0
		db  40h	; @
		db  7Eh	; ~
		db 0E6h	; Ê
		db  0Fh
		db  32h	; 2
		db 0FBh	; ˚
		db  10h
		db  79h	; y
		db 0FDh	; ˝
		db  86h	; Ü
		db    0
		db  32h	; 2
		db    1
		db  40h	; @
		db 0FBh	; ˚
		db  4Fh	; O
		db  3Ah	; :
		db  30h	; 0
		db  1Ch
		db 0B7h	; ∑
		db 0F2h	; Ú
		db  92h	; í
		db  10h
		db  23h	; #
		db  1Bh
		db  7Ah	; z
		db 0B3h	; ≥
		db 0C2h	; ¬
		db 0CAh	;  
		db  10h
		db 0AFh	; Ø
		db  32h	; 2
		db  30h	; 0
		db  1Ch
		db 0C3h	; √
		db  8Ah	; ä
		db  10h
; ---------------------------------------------------------------------------
; ===========================================================================
; JMan2050's Decompression Table (The lossy compression found in Sonic 1)
; ===========================================================================
DecTable:
		db 000h,001h,002h,004h
		db 008h,010h,020h,040h
		db 080h,0FFh,0FEh,0FCh
		db 0F8h,0F0h,0E0h,0C0h
; ---------------------------------------------------------------------------

loc_1126:
		di
		xor	a
		ld	(1C3Fh), a
		ld	a, 2Bh ; '+'
		ld	(zYM2612_A0), a
		nop
		ld	a, 80h ; 'Ä'
		ld	(zYM2612_D0), a
		ld	a, zmake68kBank(SndBank)
		ld	b, 8

loc_113A:
		ld	(zBankRegister), a
		rrca
		djnz	loc_113A
		xor	a
		ld	(zBankRegister), a
		ld	hl, 8000h
		ld	de, 5E2Fh
		ld	a, 2Ah ; '*'
		ld	(zYM2612_A0), a
		nop

loc_1150:
		ld	a, (hl)
		ld	(zYM2612_D0), a
		ld	a, (playSlot0)
		cp	0FEh ; '˛'
		jr	z, loc_1167
		nop
		nop
		ld	b, 0Ch

loc_115F:
		djnz	$
		inc	hl
		dec	de
		ld	a, d
		or	e
		jr	nz, loc_1150

loc_1167:
		jp	loc_108A
; ---------------------------------------------------------------------------
		; db    0
z80_SoundDriverEnd:
Z80_Snd_Driver2:
; ---------------------------------------------------------------------------
		!org	1300h					; z80 Align, handled by the build process
; ---------------------------------------------------------------------------
; ===========================================================================
; Pointers
; ===========================================================================

z80_SoundDriverPointers:
		dw	z80_MusicPointers
		dw	z80_UniVoiceBank
		dw	z80_MusicPointers
		dw  z80_SFXPointers
		dw  z80_PSGNoisePointers
		dw  z80_PSGTonePointers
		dw  33h
; ---------------------------------------------------------------------------
; ===========================================================================
; PSG Noise Pointers
; ===========================================================================

z80_PSGNoisePointers:
		dw	PSG_Noise0
		dw	PSG_Noise1
		dw	PSG_Noise2
		dw	PSG_Noise3
		dw	PSG_Noise4
		dw	PSG_Noise5
		dw	PSG_Noise6
		dw	PSG_Noise7

PSG_Noise1:     db    0
PSG_Noise0:     db    1,   2,   1,   0,0FFh,0FEh,0FDh,0FCh,0FDh,0FEh,0FFh, 83h
PSG_Noise2:     db    0,   0,   0,   0, 13h, 26h, 39h, 4Ch, 5Fh, 72h, 7Fh, 72h, 83h
PSG_Noise3:     db    1,   2,   3,   2,   1,   0,0FFh,0FEh,0FDh,0FEh,0FFh,   0, 82h,   0
PSG_Noise4:     db    0,   0,   1,   3,   1,   0,0FFh,0FDh,0FFh,   0, 82h,   2
PSG_Noise5:     db    0,   0,   0,   0,   0, 0Ah, 14h, 1Eh, 14h, 0Ah,   0,0F6h,0ECh,0E2h,0ECh,0F6h
                db  82h,   4
PSG_Noise6:     db    0,   0,   0,   0, 16h, 2Ch, 42h, 2Ch, 16h,   0,0EAh,0D4h,0BEh,0D4h,0EAh, 82h
                db    3
PSG_Noise7:     db    1,   2,   3,   4,   3,   2,   1,   0,0FFh,0FEh,0FDh,0FCh,0FDh,0FEh,0FFh,   0
                db  82h,   1

; ---------------------------------------------------------------------------
; ===========================================================================
; PSG Tone Pointers
; ===========================================================================

z80_PSGTonePointers:
		dw		PSGTone_00,PSGTone_01,PSGTone_02,PSGTone_03,PSGTone_04,PSGTone_05
		dw		PSGTone_06,PSGTone_07,PSGTone_08,PSGTone_09,PSGTone_0A,PSGTone_0B
		dw		PSGTone_0C,PSGTone_0D,PSGTone_0E,PSGTone_0F,PSGTone_10,PSGTone_11
		dw		PSGTone_12,PSGTone_13,PSGTone_14,PSGTone_15,PSGTone_16,PSGTone_17
		dw		PSGTone_18,PSGTone_19,PSGTone_1A,PSGTone_1B,PSGTone_1C,PSGTone_1D
		dw		PSGTone_1E,PSGTone_1F,PSGTone_20,PSGTone_21,PSGTone_22,PSGTone_23
		dw		PSGTone_24,PSGTone_25,PSGTone_26

PSGTone_00:		db    2
                db  83h
PSGTone_01:		db    0,   2,   4,   6,   8, 10h, 83h
PSGTone_02:		db    2,   1,   0,   0,   1,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2
                db    2,   3,   3,   3,   4,   4,   4,   5, 81h
PSGTone_03:		db    0,   0,   2,   3,   4,   4,   5,   5,   5,   6,   6, 81h
PSGTone_04:		db    3,   0,   1,   1,   1,   2,   3,   4,   4,   5, 81h
PSGTone_05:		db    0,   0,   1,   1,   2,   3,   4,   5,   5,   6,   8,   7,   7,   6, 81h
PSGTone_06:		db    1, 0Ch,   3, 0Fh,   2,   7,   3, 0Fh, 80h
PSGTone_07:		db    0,   0,   0,   2,   3,   3,   4,   5,   6,   7,   8,   9, 0Ah, 0Bh, 0Eh, 0Fh
                db  83h
PSGTone_08:		db    3,   2,   1,   1,   0,   0,   1,   2,   3,   4, 81h
PSGTone_09:		db    1,   0,   0,   0,   0,   1,   1,   1,   2,   2,   2,   3,   3,   3,   3,   4
                db    4,   4,   5,   5, 81h
PSGTone_0A:		db  10h, 20h, 30h, 40h, 30h, 20h, 10h,   0,0F0h, 80h
PSGTone_0B:		db    0,   0,   1,   1,   3,   3,   4,   5, 83h
PSGTone_0C:		db    0, 81h
PSGTone_0D:		db    2, 83h
PSGTone_0E:		db    0,   2,   4,   6,   8, 10h, 83h
PSGTone_0F:		db    9,   9,   9,   8,   8,   8,   7,   7,   7,   6,   6,   6,   5,   5,   5,   4
                db    4,   4,   3,   3,   3,   2,   2,   2,   1,   1,   1,   0,   0,   0, 81h
PSGTone_10:		db    1,   1,   1,   0,   0,   0, 81h
PSGTone_11:		db    3,   0,   1,   1,   1,   2,   3,   4,   4,   5, 81h
PSGTone_12:		db    0,   0,   1,   1,   2,   3,   4,   5,   5,   6,   8,   7,   7,   6, 81h
PSGTone_13:		db  0Ah,   5,   0,   4,   8, 83h
PSGTone_14:		db    0,   0,   0,   2,   3,   3,   4,   5,   6,   7,   8,   9, 0Ah, 0Bh, 0Eh, 0Fh
                db  83h
PSGTone_15:		db    3,   2,   1,   1,   0,   0,   1,   2,   3,   4, 81h
PSGTone_16:		db    1,   0,   0,   0,   0,   1,   1,   1,   2,   2,   2,   3,   3,   3,   3,   4
                db    4,   4,   5,   5, 81h
PSGTone_17:		db  10h, 20h, 30h, 40h, 30h, 20h, 10h,   0, 10h, 20h, 30h, 40h, 30h, 20h, 10h,   0
                db  10h, 20h, 30h, 40h, 30h, 20h, 10h,   0, 80h
PSGTone_18:		db    0,   0,   1,   1,   3,   3,   4,   5, 83h
PSGTone_19:		db    0,   2,   4,   6,   8, 16h, 83h
PSGTone_1A:		db    0,   0,   1,   1,   3,   3,   4,   5, 83h
PSGTone_1B:		db    4,   4,   4,   4,   3,   3,   3,   3,   2,   2,   2,   2,   1,   1,   1,   1
                db  83h
PSGTone_1C:		db    0,   0,   0,   0,   1,   1,   1,   1,   2,   2,   2,   2,   3,   3,   3,   3
                db    4,   4,   4,   4,   5,   5,   5,   5,   6,   6,   6,   6,   7,   7,   7,   7
                db    8,   8,   8,   8,   9,   9,   9,   9, 0Ah, 0Ah, 0Ah, 0Ah, 81h
PSGTone_1D:		db    0, 0Ah, 83h
PSGTone_1E:		db    0,   2,   4, 81h
PSGTone_1F:		db  30h, 20h, 10h,   0,   0,   0,   0,   0,   8, 10h, 20h, 30h, 81h
PSGTone_20:		db    0,   4,   4,   4,   4,   4,   4,   4,   4,   4,   4,   6,   6,   6,   8,   8
                db  0Ah, 83h
PSGTone_21:		db    0,   2,   3,   4,   6,   7, 81h
PSGTone_22:		db    2,   1,   0,   0,   0,   2,   4,   7, 81h
PSGTone_23:		db  0Fh,   1,   5, 83h
PSGTone_24:		db    8,   6,   2,   3,   4,   5,   6,   7,   8,   9, 0Ah, 0Bh, 0Ch, 0Dh, 0Eh, 0Fh
                db  10h, 83h
PSGTone_25:		db    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   1,   1,   1,   1,   1,   1
                db    1,   1,   1,   1,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   3,   3
                db    3,   3,   3,   3,   3,   3,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4
                db    4,   4,   5,   5,   5,   5,   5,   5,   5,   5,   5,   5,   6,   6,   6,   6
                db    6,   6,   6,   6,   6,   6,   7,   7,   7,   7,   7,   7,   7,   7,   7,   7
                db    8,   8,   8,   8,   8,   8,   8,   8,   8,   8,   9,   9,   9,   9,   9,   9
                db    9,   9, 83h
PSGTone_26:		db    0,   2,   2,   2,   3,   3,   3,   4,   4,   4,   5,   5, 83h

; ---------------------------------------------------------------------------
; ===========================================================================
; Music Pointers
; ===========================================================================

z80_MusicPointers:
		dw	zmake68kPtr(Snd_AIZ1),zmake68kPtr(Snd_AIZ2),zmake68kPtr(Snd_HCZ1),zmake68kPtr(Snd_HCZ2)
		dw	zmake68kPtr(Snd_MGZ1),zmake68kPtr(Snd_MGZ2),zmake68kPtr(Snd_CNZ1),zmake68kPtr(Snd_CNZ2)
		dw	zmake68kPtr(Snd_FBZ1),zmake68kPtr(Snd_FBZ2),zmake68kPtr(Snd_ICZ1),zmake68kPtr(Snd_ICZ2)
		dw	zmake68kPtr(Snd_LBZ1),zmake68kPtr(Snd_LBZ2),zmake68kPtr(Snd_MHZ1),zmake68kPtr(Snd_MHZ2)

		dw	zmake68kPtr(Snd_SOZ1),zmake68kPtr(Snd_SOZ2),zmake68kPtr(Snd_LRZ1),zmake68kPtr(Snd_LRZ2)
		dw	zmake68kPtr(Snd_SSZ),zmake68kPtr(Snd_DEZ1),zmake68kPtr(Snd_DEZ2),zmake68kPtr(Snd_Minib_SK)
		dw	zmake68kPtr(Snd_Boss),zmake68kPtr(Snd_DDZ),zmake68kPtr(Snd_PachBonus),zmake68kPtr(Snd_SpecialS)
		dw	zmake68kPtr(Snd_SlotBonus),zmake68kPtr(Snd_GumBonus),zmake68kPtr(Snd_Knux),zmake68kPtr(Snd_ALZ)

		dw	zmake68kPtr(Snd_BPZ),zmake68kPtr(Snd_DPZ),zmake68kPtr(Snd_CGZ),zmake68kPtr(Snd_EMZ)
		dw	zmake68kPtr(Snd_Title),zmake68kPtr(Snd_S3Credits),zmake68kPtr(Snd_GameOver),zmake68kPtr(Snd_Continue)
		dw	zmake68kPtr(Snd_Results),zmake68kPtr(Snd_1UP),zmake68kPtr(Snd_Emerald),zmake68kPtr(Snd_Invic)
		dw	zmake68kPtr(Snd_2PMenu),zmake68kPtr(Snd_Minib_SK),zmake68kPtr(Snd_Menu),zmake68kPtr(Snd_FinalBoss)

		dw	zmake68kPtr(Snd_Drown),zmake68kPtr(Snd_PresSega),zmake68kPtr(Snd_SKCredits)
; ---------------------------------------------------------------------------
; ===========================================================================
; SFX Pointers
; ===========================================================================

z80_SFXPointers:
		dw	zmake68kPtr(Sound_33),zmake68kPtr(Sound_34),zmake68kPtr(Sound_35),zmake68kPtr(Sound_36)
		dw	zmake68kPtr(Sound_37),zmake68kPtr(Sound_38),zmake68kPtr(Sound_39),zmake68kPtr(Sound_3A)
		dw	zmake68kPtr(Sound_3B),zmake68kPtr(Sound_3C),zmake68kPtr(Sound_3D),zmake68kPtr(Sound_3E)
		dw	zmake68kPtr(Sound_3F)

		dw	zmake68kPtr(Sound_40),zmake68kPtr(Sound_41),zmake68kPtr(Sound_42),zmake68kPtr(Sound_43)
		dw	zmake68kPtr(Sound_44),zmake68kPtr(Sound_45),zmake68kPtr(Sound_46),zmake68kPtr(Sound_47)
		dw	zmake68kPtr(Sound_48),zmake68kPtr(Sound_49),zmake68kPtr(Sound_4A),zmake68kPtr(Sound_4B)
		dw	zmake68kPtr(Sound_4C),zmake68kPtr(Sound_4D),zmake68kPtr(Sound_4E),zmake68kPtr(Sound_4F)

		dw	zmake68kPtr(Sound_50),zmake68kPtr(Sound_51),zmake68kPtr(Sound_52),zmake68kPtr(Sound_53)
		dw	zmake68kPtr(Sound_54),zmake68kPtr(Sound_55),zmake68kPtr(Sound_56),zmake68kPtr(Sound_57)
		dw	zmake68kPtr(Sound_58),zmake68kPtr(Sound_59),zmake68kPtr(Sound_5A),zmake68kPtr(Sound_5B)
		dw	zmake68kPtr(Sound_5C),zmake68kPtr(Sound_5D),zmake68kPtr(Sound_5E),zmake68kPtr(Sound_5F)

		dw	zmake68kPtr(Sound_60),zmake68kPtr(Sound_61),zmake68kPtr(Sound_62),zmake68kPtr(Sound_63)
		dw	zmake68kPtr(Sound_64),zmake68kPtr(Sound_65),zmake68kPtr(Sound_66),zmake68kPtr(Sound_67)
		dw	zmake68kPtr(Sound_68),zmake68kPtr(Sound_69),zmake68kPtr(Sound_6A),zmake68kPtr(Sound_6B)
		dw	zmake68kPtr(Sound_6C),zmake68kPtr(Sound_6D),zmake68kPtr(Sound_6E),zmake68kPtr(Sound_6F)

		dw	zmake68kPtr(Sound_70),zmake68kPtr(Sound_71),zmake68kPtr(Sound_72),zmake68kPtr(Sound_73)
		dw	zmake68kPtr(Sound_74),zmake68kPtr(Sound_75),zmake68kPtr(Sound_76),zmake68kPtr(Sound_77)
		dw	zmake68kPtr(Sound_78),zmake68kPtr(Sound_79),zmake68kPtr(Sound_7A),zmake68kPtr(Sound_7B)
		dw	zmake68kPtr(Sound_7C),zmake68kPtr(Sound_7D),zmake68kPtr(Sound_7E),zmake68kPtr(Sound_7F)

		dw	zmake68kPtr(Sound_80),zmake68kPtr(Sound_81),zmake68kPtr(Sound_82),zmake68kPtr(Sound_83)
		dw	zmake68kPtr(Sound_84),zmake68kPtr(Sound_85),zmake68kPtr(Sound_86),zmake68kPtr(Sound_87)
		dw	zmake68kPtr(Sound_88),zmake68kPtr(Sound_89),zmake68kPtr(Sound_8A),zmake68kPtr(Sound_8B)
		dw	zmake68kPtr(Sound_8C),zmake68kPtr(Sound_8D),zmake68kPtr(Sound_8E),zmake68kPtr(Sound_8F)

		dw	zmake68kPtr(Sound_90),zmake68kPtr(Sound_91),zmake68kPtr(Sound_92),zmake68kPtr(Sound_93)
		dw	zmake68kPtr(Sound_94),zmake68kPtr(Sound_95),zmake68kPtr(Sound_96),zmake68kPtr(Sound_97)
		dw	zmake68kPtr(Sound_98),zmake68kPtr(Sound_99),zmake68kPtr(Sound_9A),zmake68kPtr(Sound_9B)
		dw	zmake68kPtr(Sound_9C),zmake68kPtr(Sound_9D),zmake68kPtr(Sound_9E),zmake68kPtr(Sound_9F)

		dw	zmake68kPtr(Sound_A0),zmake68kPtr(Sound_A1),zmake68kPtr(Sound_A2),zmake68kPtr(Sound_A3)
		dw	zmake68kPtr(Sound_A4),zmake68kPtr(Sound_A5),zmake68kPtr(Sound_A6),zmake68kPtr(Sound_A7)
		dw	zmake68kPtr(Sound_A8),zmake68kPtr(Sound_A9),zmake68kPtr(Sound_AA),zmake68kPtr(Sound_AB)
		dw	zmake68kPtr(Sound_AC),zmake68kPtr(Sound_AD),zmake68kPtr(Sound_AE),zmake68kPtr(Sound_AF)

		dw	zmake68kPtr(Sound_B0),zmake68kPtr(Sound_B1),zmake68kPtr(Sound_B2),zmake68kPtr(Sound_B3)
		dw	zmake68kPtr(Sound_B4),zmake68kPtr(Sound_B5),zmake68kPtr(Sound_B6),zmake68kPtr(Sound_B7)
		dw	zmake68kPtr(Sound_B8),zmake68kPtr(Sound_B9),zmake68kPtr(Sound_BA),zmake68kPtr(Sound_BB)
		dw	zmake68kPtr(Sound_BC),zmake68kPtr(Sound_BD),zmake68kPtr(Sound_BE),zmake68kPtr(Sound_BF)

		dw	zmake68kPtr(Sound_C0),zmake68kPtr(Sound_C1),zmake68kPtr(Sound_C2),zmake68kPtr(Sound_C3)
		dw	zmake68kPtr(Sound_C4),zmake68kPtr(Sound_C5),zmake68kPtr(Sound_C6),zmake68kPtr(Sound_C7)
		dw	zmake68kPtr(Sound_C8),zmake68kPtr(Sound_C9),zmake68kPtr(Sound_CA),zmake68kPtr(Sound_CB)
		dw	zmake68kPtr(Sound_CC),zmake68kPtr(Sound_CD),zmake68kPtr(Sound_CE),zmake68kPtr(Sound_CF)

		dw	zmake68kPtr(Sound_D0),zmake68kPtr(Sound_D1),zmake68kPtr(Sound_D2),zmake68kPtr(Sound_D3)
		dw	zmake68kPtr(Sound_D4),zmake68kPtr(Sound_D5),zmake68kPtr(Sound_D6),zmake68kPtr(Sound_D7)
		dw	zmake68kPtr(Sound_D8),zmake68kPtr(Sound_D9),zmake68kPtr(Sound_DA),zmake68kPtr(Sound_DB)
		dw	zmake68kPtr(Sound_DB),zmake68kPtr(Sound_DB),zmake68kPtr(Sound_DB),zmake68kPtr(Sound_DB)
; ---------------------------------------------------------------------------
; ===========================================================================
; PSG Universial Voice Bank
; ===========================================================================

z80_UniVoiceBank:
		;binclude		"Sound/UniVoiceBank.bin"
				db  3Ch,   1,   0,   0,   0, 1Fh, 1Fh, 15h, 1Fh, 11h, 0Dh, 12h,   5
				db    7,   4,   9,   2, 55h, 3Ah, 25h, 1Ah, 1Ah, 80h,   7, 80h			; 0
                db  3Dh,   1,   1,   1,   1, 94h, 19h, 19h, 19h, 0Fh, 0Dh, 0Dh, 0Dh
				db    7,   4,   4,   4, 25h, 1Ah, 1Ah, 1Ah, 15h, 80h, 80h, 80h			; 25
                db    3,   0,0D7h, 33h,   2, 5Fh, 9Fh, 5Fh, 1Fh, 13h, 0Fh, 0Ah, 0Ah
				db  10h, 0Fh,   2,   9, 35h, 15h, 25h, 1Ah, 13h, 16h, 15h, 80h			; 50
                db  34h, 70h, 72h, 31h, 31h, 1Fh, 1Fh, 1Fh, 1Fh, 10h,   6,   6,   6
				db    1,   6,   6,   6, 35h, 1Ah, 15h, 1Ah, 10h, 83h, 18h, 83h			; 75
                db  3Eh, 77h, 71h, 32h, 31h, 1Fh, 1Fh, 1Fh, 1Fh, 0Dh,   6,   0,   0
				db    8,   6,   0,   0, 15h, 0Ah, 0Ah, 0Ah, 1Bh, 80h, 80h, 80h			; 100
                db  34h, 33h, 41h, 7Eh, 74h, 5Bh, 9Fh, 5Fh, 1Fh,   4,   7,   7,   8 
				db    0,   0,   0,   0,0FFh,0FFh,0EFh,0FFh, 23h, 80h, 29h, 87h			; 125
                db  3Ah,   1,   7, 31h, 71h, 8Eh, 8Eh, 8Dh, 53h, 0Eh, 0Eh, 0Eh,   3
				db    0,   0,   0,   7, 1Fh,0FFh, 1Fh, 0Fh, 18h, 28h, 27h, 80h			; 150
                db  3Ch, 32h, 32h, 71h, 42h, 1Fh, 18h, 1Fh, 1Eh,   7, 1Fh,   7, 1Fh
				db    0,   0,   0,   0, 1Fh, 0Fh, 1Fh, 0Fh, 1Eh, 80h, 0Ch, 80h			; 175
                db  3Ch, 71h, 72h, 3Fh, 34h, 8Dh, 52h, 9Fh, 1Fh,   9,   0,   0, 0Dh
				db    0,   0,   0,   0, 23h,   8,   2,0F7h, 15h, 80h, 1Dh, 87h			; 200
                db  3Dh,   1,   1,   0,   0, 8Eh, 52h, 14h, 4Ch,   8,   8, 0Eh,   3
				db    0,   0,   0,   0, 1Fh, 1Fh, 1Fh, 1Fh, 1Bh, 80h, 80h, 9Bh			; 225
                db  3Ah,   1,   1,   1,   2, 8Dh,   7,   7, 52h,   9,   0,   0,   3
				db    1,   2,   2,   0, 52h,   2,   2, 28h, 18h, 22h, 18h, 80h			; 250
                db  3Ch, 36h, 31h, 76h, 71h, 94h, 9Fh, 96h, 9Fh, 12h,   0, 14h, 0Fh 
				db    4, 0Ah,   4, 0Dh, 2Fh, 0Fh, 4Fh, 2Fh, 33h, 80h, 1Ah, 80h			; 275
                db  34h, 33h, 41h, 7Eh, 74h, 5Bh, 9Fh, 5Fh, 1Fh,   4,   7,   7,   8
				db    0,   0,   0,   0,0FFh,0FFh,0EFh,0FFh, 23h, 90h, 29h, 97h			; 300
                db  38h, 63h, 31h, 31h, 31h, 10h, 13h, 1Ah, 1Bh, 0Eh,   0,   0,   0
				db    0,   0,   0,   0, 3Fh, 0Fh, 0Fh, 0Fh, 1Ah, 19h, 1Ah, 80h			; 325
                db  3Ah, 31h, 25h, 73h, 41h, 5Fh, 1Fh, 1Fh, 9Ch,   8,   5,   4,   5
				db    3,   4,   2,   2, 2Fh, 2Fh, 1Fh, 2Fh, 29h, 27h, 1Fh, 80h			; 350
                db    4, 71h, 41h, 31h, 31h, 12h, 12h, 12h, 12h,   0,   0,   0,   0
				db    0,   0,   0,   0, 0Fh, 0Fh, 0Fh, 0Fh, 23h, 80h, 23h, 80h			; 375
                db  14h, 75h, 72h, 35h, 32h, 9Fh, 9Fh, 9Fh, 9Fh,   5,   5,   0, 0Ah
				db    5,   5,   7,   5, 2Fh,0FFh, 0Fh, 2Fh, 1Eh, 80h, 14h, 80h			; 400
                db  3Dh,   1,   0,   1,   2, 12h, 1Fh, 1Fh, 14h,   7,   2,   2, 0Ah
				db    5,   5,   5,   5, 2Fh, 2Fh, 2Fh,0AFh, 1Ch, 80h, 82h, 80h			; 425
                db  1Ch, 73h, 72h, 33h, 32h, 94h, 99h, 94h, 99h,   8, 0Ah,   8, 0Ah
				db    0,   5,   0,   5, 3Fh, 4Fh, 3Fh, 4Fh, 1Eh, 80h, 19h, 80h			; 450
                db  31h, 33h,   1,   0,   0, 9Fh, 1Fh, 1Fh, 1Fh, 0Dh, 0Ah, 0Ah, 0Ah
				db  0Ah,   7,   7,   7,0FFh,0AFh,0AFh,0AFh, 1Eh, 1Eh, 1Eh, 80h			; 475
                db  3Ah, 70h, 76h, 30h, 71h, 1Fh, 95h, 1Fh, 1Fh, 0Eh, 0Fh,   5, 0Ch
				db    7,   6,   6,   7, 2Fh, 4Fh, 1Fh, 5Fh, 21h, 12h, 28h, 80h			; 500
                db  28h, 71h,   0, 30h,   1, 1Fh, 1Fh, 1Dh, 1Fh, 13h, 13h,   6,   5
				db    3,   3,   2,   5, 4Fh, 4Fh, 2Fh, 3Fh, 0Eh, 14h, 1Eh, 80h			; 525
                db  3Eh, 38h,   1, 7Ah, 34h, 59h,0D9h, 5Fh, 9Ch, 0Fh,   4, 0Fh, 0Ah
				db    2,   2,   5,   5,0AFh,0AFh, 66h, 66h, 28h, 80h,0A3h, 80h			; 550
                db  39h, 32h, 31h, 72h, 71h, 1Fh, 1Fh, 1Fh, 1Fh,   0,   0,   0,   0
				db    0,   0,   0,   0, 0Fh, 0Fh, 0Fh, 0Fh, 1Bh, 32h, 28h, 80h			; 575
                db    7, 34h, 74h, 32h, 71h, 1Fh, 1Fh, 1Fh, 1Fh, 0Ah, 0Ah,   5,   3
				db    0,   0,   0,   0, 3Fh, 3Fh, 2Fh, 2Fh, 8Ah, 8Ah, 80h, 80h			; 600
                db  3Ah, 31h, 37h, 31h, 31h, 8Dh, 8Dh, 8Eh, 53h, 0Eh, 0Eh, 0Eh,   3 
				db    0,   0,   0,   0, 1Fh,0FFh, 1Fh, 0Fh, 17h, 28h, 26h, 80h			; 625
                db  3Bh, 3Ah, 31h, 71h, 74h,0DFh, 1Fh, 1Fh,0DFh,   0, 0Ah, 0Ah,   5
				db    0,   5,   5,   3, 0Fh, 5Fh, 1Fh, 5Fh, 32h, 1Eh, 0Fh, 80h			; 650
                db    5,   4,   1,   2,   4, 8Dh, 1Fh, 15h, 52h,   6,   0,   0,   4
				db    2,   8,   0,   0, 1Fh, 0Fh, 0Fh, 2Fh, 16h, 90h, 84h, 8Ch			; 675
                db  2Ch, 71h, 74h, 32h, 32h, 1Fh, 12h, 1Fh, 12h,   0, 0Ah,   0, 0Ah
				db    0,   0,   0,   0, 0Fh, 1Fh, 0Fh, 1Fh, 16h, 80h, 17h, 80h			; 700
                db  3Ah,   1,   7,   1,   1, 8Eh, 8Eh, 8Dh, 53h, 0Eh, 0Eh, 0Eh,   3
				db    0,   0,   0,   7, 1Fh,0FFh, 1Fh, 0Fh, 18h, 28h, 27h, 8Fh			; 725
                db  36h, 7Ah, 32h, 51h, 11h, 1Fh, 1Fh, 59h, 1Ch, 0Ah, 0Dh,   6, 0Ah
				db    7,   0,   2,   2,0AFh, 5Fh, 5Fh, 5Fh, 1Eh, 8Bh, 81h, 80h			; 750
                db  3Ch, 71h, 72h, 3Fh, 34h, 8Dh, 52h, 9Fh, 1Fh,   9,   0,   0, 0Dh
				db    0,   0,   0,   0, 23h,   8,   2,0F7h, 15h, 85h, 1Dh, 8Ah			; 775
                db  3Eh, 77h, 71h, 32h, 31h, 1Fh, 1Fh, 1Fh, 1Fh, 0Dh,   6,   0,   0
				db    8,   6,   0,   0, 15h, 0Ah, 0Ah, 0Ah, 1Bh, 8Fh, 8Fh, 8Fh			; 800
                db    7, 34h, 74h, 32h, 71h, 1Fh, 1Fh, 1Fh, 1Fh, 0Ah, 0Ah,   5,   3 
				db    0,   0,   0,   0, 3Fh, 3Fh, 2Fh, 2Fh, 8Ah, 8Ah, 8Ah, 8Ah			; 825
                db  20h, 36h, 35h, 30h, 31h,0DFh,0DFh, 9Fh, 9Fh,   7,   6,   9,   6
				db    7,   6,   6,   8, 20h, 10h, 10h,0F8h, 19h, 37h, 13h, 80h			; 850


z80_SoundDriverPointersEnd:
; ---------------------------------------------------------------------------
; ===========================================================================
; END OF SOUND DRIVER
; ===========================================================================
		cpu 68000
		padding off
		listing off
		supmode on
		
		;!org		z80_SoundDriver+z80_SoundDriverPointersEnd-(z80_SoundDriverPointers-z80_SoundDriverEnd)      ; Fix alignment after sound driver
		!org		z80_SoundDriver+Size_of_Snd_driver_guess

Z80_Snd_Driver_End:

; Function to make a little endian (z80) pointer
k68z80Pointer function addr,((((addr&$7FFF)+$8000)<<8)&$FF00)+(((addr&$7FFF)+$8000)>>8)

little_endian function x,(x)<<8&$FF00|(x)>>8&$FF

startBank macro {INTLABEL}
	align 	$8000
__LABEL__ label *
soundBankStart := __LABEL__
    endm

DebugSoundbanks := 0

finishBank macro
	if * > soundBankStart + $8000
		fatal "soundBank must fit in $8000 bytes but was $/{*-soundBankStart}. Try moving something to the other bank."
	elseif (DebugSoundbanks<>0)&&(MOMPASS=1)
		message "soundBank has $/{$8000+soundBankStart-*} bytes free at end."
	endif
    endm

; macro to declare an entry in an offset table rooted at a bank
offsetBankTableEntry macro ptr
	dc.ATTRIBUTE k68z80Pointer(ptr-soundBankStart)
    endm

; Special BINCLUDE wrapper function
DACBINCLUDE macro file,{INTLABEL}
__LABEL__ label *
	BINCLUDE file
__LABEL___Len  := little_endian(*-__LABEL__)
__LABEL___Ptr  := k68z80Pointer(__LABEL__-soundBankStart)
__LABEL___Bank := soundBankStart
    endm

; Setup macro for DAC samples.
DAC_Setup macro rate,dacptr
	dc.b	rate
	dc.w 	dacptr_Len
	dc.w	dacptr_Ptr
    endm

; A "null" DAC sample.
DAC_Invalid:
DAC_Invalid_Len := 0
DAC_Invalid_Ptr := 0
DAC_Invalid_Bank := 0

; Setup a null entry for a DAC sample.
DAC_Null_Setup macro rate,dacptr
	dc.b	rate
	dc.w 	$0000,$0000
    endm

; Setup a chain-linked invalid entry for a DAC sample.
; The sample's length is correctly stored for the sample,
; while the pointer (usually) goes towards the DAC pointer
; entry of another DAC sample setup.
DAC_Null_Chain macro rate,dacptr,linkptr
	dc.b	rate
	dc.w 	dacptr_Len,k68z80Pointer(linkptr+3-soundBankStart)
    endm

; ---------------------------------------------------------------------------
; ===========================================================================
; Playlist
; ===========================================================================
LevelMusic_Playlist:
		binclude "Sound/Music/Music playlist.bin"
; ---------------------------------------------------------------------------
; ===========================================================================
; DAC Banks
; ===========================================================================
; DAC Bank 1
; ---------------------------------------------------------------------------
DacBank1:			startBank

DAC_Offsets:
		offsetBankTableEntry.w	DAC_81_Setup
		offsetBankTableEntry.w	DAC_82_Setup
		offsetBankTableEntry.w	DAC_83_Setup
		offsetBankTableEntry.w	DAC_84_Setup
		offsetBankTableEntry.w	DAC_85_Setup
		offsetBankTableEntry.w	DAC_86_Setup
		offsetBankTableEntry.w	DAC_87_Setup
		offsetBankTableEntry.w	DAC_88_Setup
		offsetBankTableEntry.w	DAC_89_Setup
		offsetBankTableEntry.w	DAC_8A_Setup
		offsetBankTableEntry.w	DAC_8B_Setup
		offsetBankTableEntry.w	DAC_8C_Setup
		offsetBankTableEntry.w	DAC_8D_Setup
		offsetBankTableEntry.w	DAC_8E_Setup
		offsetBankTableEntry.w	DAC_8F_Setup
		
		offsetBankTableEntry.w	DAC_90_Setup
		offsetBankTableEntry.w	DAC_91_Setup
		offsetBankTableEntry.w	DAC_92_Setup
		offsetBankTableEntry.w	DAC_93_Setup
		offsetBankTableEntry.w	DAC_94_Setup
		offsetBankTableEntry.w	DAC_95_Setup
		offsetBankTableEntry.w	DAC_96_Setup
		offsetBankTableEntry.w	DAC_97_Setup
		offsetBankTableEntry.w	DAC_98_Setup
		offsetBankTableEntry.w	DAC_99_Setup
		offsetBankTableEntry.w	DAC_9A_Setup
		offsetBankTableEntry.w	DAC_9B_Setup
		offsetBankTableEntry.w	DAC_9C_Setup
		offsetBankTableEntry.w	DAC_9D_Setup
		offsetBankTableEntry.w	DAC_9E_Setup
		offsetBankTableEntry.w	DAC_9F_Setup

		offsetBankTableEntry.w	DAC_A0_Setup
		offsetBankTableEntry.w	DAC_A1_Setup
		offsetBankTableEntry.w	DAC_A2_Setup
		offsetBankTableEntry.w	DAC_A3_Setup
		offsetBankTableEntry.w	DAC_A4_Setup
		offsetBankTableEntry.w	DAC_A5_Setup
		offsetBankTableEntry.w	DAC_A6_Setup
		offsetBankTableEntry.w	DAC_A7_Setup
		offsetBankTableEntry.w	DAC_A8_Setup
		offsetBankTableEntry.w	DAC_A9_Setup
		offsetBankTableEntry.w	DAC_AA_Setup
		offsetBankTableEntry.w	DAC_AB_Setup
		offsetBankTableEntry.w	DAC_AC_Setup
		offsetBankTableEntry.w	DAC_AD_Setup
		offsetBankTableEntry.w	DAC_AE_Setup
		offsetBankTableEntry.w	DAC_AF_Setup
		
		offsetBankTableEntry.w	DAC_B0_Setup
		offsetBankTableEntry.w	DAC_B1_Setup
		offsetBankTableEntry.w	DAC_B2_Setup
		offsetBankTableEntry.w	DAC_B3_Setup
		offsetBankTableEntry.w	DAC_B4_Setup
		offsetBankTableEntry.w	DAC_B5_Setup
		offsetBankTableEntry.w	DAC_B6_Setup
		offsetBankTableEntry.w	DAC_B7_Setup
		offsetBankTableEntry.w	DAC_B8_B9_Setup
		offsetBankTableEntry.w	DAC_B8_B9_Setup
		offsetBankTableEntry.w	DAC_BA_Setup
		offsetBankTableEntry.w	DAC_BB_Setup
		offsetBankTableEntry.w	DAC_BC_Setup
		offsetBankTableEntry.w	DAC_BD_Setup
		offsetBankTableEntry.w	DAC_BE_Setup
		offsetBankTableEntry.w	DAC_BF_Setup

		offsetBankTableEntry.w	DAC_C0_Setup
		offsetBankTableEntry.w	DAC_C1_Setup
		offsetBankTableEntry.w	DAC_C2_Setup
		offsetBankTableEntry.w	DAC_C3_Setup
		offsetBankTableEntry.w	DAC_C4_Setup

DAC_81_Setup:			DAC_Setup $04,DAC_81_Data
DAC_82_Setup:			DAC_Setup $0E,DAC_82_83_84_85_Data
DAC_83_Setup:			DAC_Setup $14,DAC_82_83_84_85_Data
DAC_84_Setup:			DAC_Setup $1A,DAC_82_83_84_85_Data
DAC_85_Setup:			DAC_Setup $20,DAC_82_83_84_85_Data
DAC_86_Setup:			DAC_Setup $04,DAC_86_Data
DAC_87_Setup:			DAC_Setup $04,DAC_87_Data
DAC_88_Setup:			DAC_Setup $06,DAC_88_Data
DAC_89_Setup:			DAC_Setup $0A,DAC_89_Data
DAC_8A_Setup:			DAC_Setup $14,DAC_8A_8B_Data
DAC_8B_Setup:			DAC_Setup $1B,DAC_8A_8B_Data
DAC_8C_Setup:			DAC_Setup $08,DAC_8C_Data
DAC_8D_Setup:			DAC_Setup $0B,DAC_8D_8E_Data
DAC_8E_Setup:			DAC_Setup $11,DAC_8D_8E_Data
DAC_8F_Setup:			DAC_Setup $08,DAC_8F_Data
DAC_90_Setup:			DAC_Setup $03,DAC_90_91_92_93_Data
DAC_91_Setup:			DAC_Setup $07,DAC_90_91_92_93_Data
DAC_92_Setup:			DAC_Setup $0A,DAC_90_91_92_93_Data
DAC_93_Setup:			DAC_Setup $0E,DAC_90_91_92_93_Data
DAC_94_Setup:			DAC_Setup $06,DAC_94_95_96_97_Data
DAC_95_Setup:			DAC_Setup $0A,DAC_94_95_96_97_Data
DAC_96_Setup:			DAC_Setup $0D,DAC_94_95_96_97_Data
DAC_97_Setup:			DAC_Setup $12,DAC_94_95_96_97_Data
DAC_98_Setup:			DAC_Setup $0B,DAC_98_99_9A_Data
DAC_99_Setup:			DAC_Setup $13,DAC_98_99_9A_Data
DAC_9A_Setup:			DAC_Setup $16,DAC_98_99_9A_Data
DAC_9B_Setup:			DAC_Setup $0C,DAC_9B_Data
DAC_A2_Setup:			DAC_Setup $0A,DAC_A2_Data
DAC_A3_Setup:			DAC_Setup $18,DAC_A3_Data
DAC_A4_Setup:			DAC_Setup $18,DAC_A4_Data
DAC_A5_Setup:			DAC_Setup $0C,DAC_A5_Data
DAC_A6_Setup:			DAC_Setup $09,DAC_A6_Data
DAC_A7_Setup:			DAC_Setup $18,DAC_A7_Data
DAC_A8_Setup:			DAC_Setup $18,DAC_A8_Data
DAC_A9_Setup:			DAC_Setup $0C,DAC_A9_Data
DAC_AA_Setup:			DAC_Setup $0A,DAC_AA_Data
DAC_AB_Setup:			DAC_Setup $0D,DAC_AB_Data
DAC_AC_Setup:			DAC_Setup $06,DAC_AC_Data
DAC_AD_Setup:			DAC_Setup $10,DAC_AD_AE_Data
DAC_AE_Setup:			DAC_Setup $18,DAC_AD_AE_Data
DAC_AF_Setup:			DAC_Setup $09,DAC_AF_B0_Data
DAC_B0_Setup:			DAC_Setup $12,DAC_AF_B0_Data
DAC_B1_Setup:			DAC_Setup $18,DAC_B1_Data
DAC_B2_Setup:			DAC_Setup $16,DAC_B2_B3_Data
DAC_B3_Setup:			DAC_Setup $20,DAC_B2_B3_Data
DAC_B4_Setup:			DAC_Setup $0C,DAC_B4_C1_C2_C3_C4_Data
DAC_B5_Setup:			DAC_Setup $0C,DAC_B5_Data
DAC_B6_Setup:			DAC_Setup $0C,DAC_B6_Data
DAC_B7_Setup:			DAC_Setup $18,DAC_B7_Data
DAC_B8_B9_Setup:		DAC_Setup $0C,DAC_B8_B9_Data
DAC_BA_Setup:			DAC_Setup $18,DAC_BA_Data
DAC_BB_Setup:			DAC_Setup $18,DAC_BB_Data
DAC_BC_Setup:			DAC_Setup $18,DAC_BC_Data
DAC_BD_Setup:			DAC_Setup $0C,DAC_BD_Data
DAC_BE_Setup:			DAC_Setup $0C,DAC_BE_Data
DAC_BF_Setup:			DAC_Setup $1C,DAC_BF_Data
DAC_C0_Setup:			DAC_Setup $0B,DAC_C0_Data
DAC_C1_Setup:			DAC_Setup $0F,DAC_B4_C1_C2_C3_C4_Data
DAC_C2_Setup:			DAC_Setup $11,DAC_B4_C1_C2_C3_C4_Data
DAC_C3_Setup:			DAC_Setup $12,DAC_B4_C1_C2_C3_C4_Data
DAC_C4_Setup:			DAC_Setup $0B,DAC_B4_C1_C2_C3_C4_Data
DAC_9C_Setup:			DAC_Setup $0A,DAC_9C_Data
DAC_9D_Setup:			DAC_Setup $18,DAC_9D_Data
DAC_9E_Setup:			DAC_Setup $18,DAC_9E_Data
DAC_9F_Setup:			DAC_Setup $0C,DAC_9F_Data
DAC_A0_Setup:			DAC_Setup $0C,DAC_A0_Data
DAC_A1_Setup:			DAC_Setup $0A,DAC_A1_Data
; ---------------------------------------------------------------------------

DAC_86_Data:			DACBINCLUDE "Sound/DAC/86.bin"
DAC_81_Data:			DACBINCLUDE "Sound/DAC/81.bin"
DAC_82_83_84_85_Data:	DACBINCLUDE "Sound/DAC/82-85.bin"
DAC_94_95_96_97_Data:	DACBINCLUDE "Sound/DAC/94-97.bin"
DAC_90_91_92_93_Data:	DACBINCLUDE "Sound/DAC/90-93.bin"
DAC_88_Data:			DACBINCLUDE "Sound/DAC/88.bin"
DAC_8A_8B_Data:			DACBINCLUDE "Sound/DAC/8A-8B.bin"
DAC_8C_Data:			DACBINCLUDE "Sound/DAC/8C.bin"
DAC_8D_8E_Data:			DACBINCLUDE "Sound/DAC/8D-8E.bin"
DAC_87_Data:			DACBINCLUDE "Sound/DAC/87.bin"
DAC_8F_Data:			DACBINCLUDE "Sound/DAC/8F.bin"
DAC_89_Data:			DACBINCLUDE "Sound/DAC/89.bin"
DAC_98_99_9A_Data:		DACBINCLUDE "Sound/DAC/98-9A.bin"
DAC_9B_Data:			DACBINCLUDE "Sound/DAC/9B.bin"
DAC_B2_B3_Data:			DACBINCLUDE "Sound/DAC/B2-B3.bin"

	finishBank

; ---------------------------------------------------------------------------
; Dac Bank 2
; ---------------------------------------------------------------------------
DacBank2:			startBank
		offsetBankTableEntry.w	DAC_81_Setup2
		offsetBankTableEntry.w	DAC_82_Setup2
		offsetBankTableEntry.w	DAC_83_Setup2
		offsetBankTableEntry.w	DAC_84_Setup2
		offsetBankTableEntry.w	DAC_85_Setup2
		offsetBankTableEntry.w	DAC_86_Setup2
		offsetBankTableEntry.w	DAC_87_Setup2
		offsetBankTableEntry.w	DAC_88_Setup2
		offsetBankTableEntry.w	DAC_89_Setup2
		offsetBankTableEntry.w	DAC_8A_Setup2
		offsetBankTableEntry.w	DAC_8B_Setup2
		offsetBankTableEntry.w	DAC_8C_Setup2
		offsetBankTableEntry.w	DAC_8D_Setup2
		offsetBankTableEntry.w	DAC_8E_Setup2
		offsetBankTableEntry.w	DAC_8F_Setup2
		
		offsetBankTableEntry.w	DAC_90_Setup2
		offsetBankTableEntry.w	DAC_91_Setup2
		offsetBankTableEntry.w	DAC_92_Setup2
		offsetBankTableEntry.w	DAC_93_Setup2
		offsetBankTableEntry.w	DAC_94_Setup2
		offsetBankTableEntry.w	DAC_95_Setup2
		offsetBankTableEntry.w	DAC_96_Setup2
		offsetBankTableEntry.w	DAC_97_Setup2
		offsetBankTableEntry.w	DAC_98_Setup2
		offsetBankTableEntry.w	DAC_99_Setup2
		offsetBankTableEntry.w	DAC_9A_Setup2
		offsetBankTableEntry.w	DAC_9B_Setup2
		offsetBankTableEntry.w	DAC_9C_Setup2
		offsetBankTableEntry.w	DAC_9D_Setup2
		offsetBankTableEntry.w	DAC_9E_Setup2
		offsetBankTableEntry.w	DAC_9F_Setup2

		offsetBankTableEntry.w	DAC_A0_Setup2
		offsetBankTableEntry.w	DAC_A1_Setup2
		offsetBankTableEntry.w	DAC_A2_Setup2
		offsetBankTableEntry.w	DAC_A3_Setup2
		offsetBankTableEntry.w	DAC_A4_Setup2
		offsetBankTableEntry.w	DAC_A5_Setup2
		offsetBankTableEntry.w	DAC_A6_Setup2
		offsetBankTableEntry.w	DAC_A7_Setup2
		offsetBankTableEntry.w	DAC_A8_Setup2
		offsetBankTableEntry.w	DAC_A9_Setup2
		offsetBankTableEntry.w	DAC_AA_Setup2
		offsetBankTableEntry.w	DAC_AB_Setup2
		offsetBankTableEntry.w	DAC_AC_Setup2
		offsetBankTableEntry.w	DAC_AD_Setup2
		offsetBankTableEntry.w	DAC_AE_Setup2
		offsetBankTableEntry.w	DAC_AF_Setup2
		
		offsetBankTableEntry.w	DAC_B0_Setup2
		offsetBankTableEntry.w	DAC_B1_Setup2
		offsetBankTableEntry.w	DAC_B2_Setup2
		offsetBankTableEntry.w	DAC_B3_Setup2
		offsetBankTableEntry.w	DAC_B4_Setup2
		offsetBankTableEntry.w	DAC_B5_Setup2
		offsetBankTableEntry.w	DAC_B6_Setup2
		offsetBankTableEntry.w	DAC_B7_Setup2
		offsetBankTableEntry.w	DAC_B8_B9_Setup2
		offsetBankTableEntry.w	DAC_B8_B9_Setup2
		offsetBankTableEntry.w	DAC_BA_Setup2
		offsetBankTableEntry.w	DAC_BB_Setup2
		offsetBankTableEntry.w	DAC_BC_Setup2
		offsetBankTableEntry.w	DAC_BD_Setup2
		offsetBankTableEntry.w	DAC_BE_Setup2
		offsetBankTableEntry.w	DAC_BF_Setup2

		offsetBankTableEntry.w	DAC_C0_Setup2
		offsetBankTableEntry.w	DAC_C1_Setup2
		offsetBankTableEntry.w	DAC_C2_Setup2
		offsetBankTableEntry.w	DAC_C3_Setup2
		offsetBankTableEntry.w	DAC_C4_Setup2

DAC_81_Setup2:			DAC_Null_Setup $04,DAC_81_Data
DAC_82_Setup2:			DAC_Null_Setup $0E,DAC_82_83_84_85_Data
DAC_83_Setup2:			DAC_Null_Chain $14,DAC_Invalid,DAC_82_Setup2
DAC_84_Setup2:			DAC_Null_Chain $1A,DAC_Invalid,DAC_83_Setup2
DAC_85_Setup2:			DAC_Null_Chain $20,DAC_Invalid,DAC_84_Setup2
DAC_86_Setup2:			DAC_Null_Setup $04,DAC_86_Data
DAC_87_Setup2:			DAC_Null_Setup $04,DAC_87_Data
DAC_88_Setup2:			DAC_Null_Setup $06,DAC_88_Data
DAC_89_Setup2:			DAC_Null_Setup $0A,DAC_89_Data
DAC_8A_Setup2:			DAC_Null_Setup $14,DAC_8A_8B_Data
DAC_8B_Setup2:			DAC_Null_Chain $1B,DAC_Invalid,DAC_8A_Setup2
DAC_8C_Setup2:			DAC_Null_Setup $08,DAC_8C_Data
DAC_8D_Setup2:			DAC_Null_Setup $0B,DAC_8D_8E_Data
DAC_8E_Setup2:			DAC_Null_Chain $11,DAC_Invalid,DAC_8D_Setup2
DAC_8F_Setup2:			DAC_Null_Setup $08,DAC_8F_Data
DAC_90_Setup2:			DAC_Null_Setup $03,DAC_90_91_92_93_Data
DAC_91_Setup2:			DAC_Null_Chain $07,DAC_Invalid,DAC_90_Setup2
DAC_92_Setup2:			DAC_Null_Chain $0A,DAC_Invalid,DAC_91_Setup2
DAC_93_Setup2:			DAC_Null_Chain $0E,DAC_Invalid,DAC_92_Setup2
DAC_94_Setup2:			DAC_Null_Setup $06,DAC_94_95_96_97_Data
DAC_95_Setup2:			DAC_Null_Chain $0A,DAC_Invalid,DAC_94_Setup2
DAC_96_Setup2:			DAC_Null_Chain $0D,DAC_Invalid,DAC_95_Setup2
DAC_97_Setup2:			DAC_Null_Chain $12,DAC_Invalid,DAC_96_Setup2
DAC_98_Setup2:			DAC_Null_Setup $0B,DAC_98_99_9A_Data
DAC_99_Setup2:			DAC_Null_Chain $13,DAC_Invalid,DAC_98_Setup2
DAC_9A_Setup2:			DAC_Null_Chain $16,DAC_Invalid,DAC_99_Setup2
DAC_9B_Setup2:			DAC_Null_Chain $0C,DAC_9B_Data,Bank2_Filler-3
DAC_A2_Setup2:			DAC_Setup $0A,DAC_A2_Data
DAC_A3_Setup2:			DAC_Setup $18,DAC_A3_Data
DAC_A4_Setup2:			DAC_Setup $18,DAC_A4_Data
DAC_A5_Setup2:			DAC_Setup $0C,DAC_A5_Data
DAC_A6_Setup2:			DAC_Setup $09,DAC_A6_Data
DAC_A7_Setup2:			DAC_Setup $18,DAC_A7_Data
DAC_A8_Setup2:			DAC_Setup $18,DAC_A8_Data
DAC_A9_Setup2:			DAC_Setup $0C,DAC_A9_Data
DAC_AA_Setup2:			DAC_Setup $0A,DAC_AA_Data
DAC_AB_Setup2:			DAC_Null_Setup $0D,DAC_AB_Data
DAC_AC_Setup2:			DAC_Null_Setup $06,DAC_AC_Data
DAC_AD_Setup2:			DAC_Null_Setup $10,DAC_AD_AE_Data
DAC_AE_Setup2:			DAC_Null_Chain $18,DAC_Invalid,DAC_AD_Setup2
DAC_AF_Setup2:			DAC_Null_Setup $09,DAC_AF_B0_Data
DAC_B0_Setup2:			DAC_Null_Chain $12,DAC_Invalid,DAC_AF_Setup2
DAC_B1_Setup2:			DAC_Null_Setup $18,DAC_B1_Data
DAC_B2_Setup2:			DAC_Null_Setup $16,DAC_B2_B3_Data
DAC_B3_Setup2:			DAC_Null_Chain $20,DAC_Invalid,DAC_B2_Setup2
DAC_B4_Setup2:			DAC_Null_Setup $0C,DAC_B4_C1_C2_C3_C4_Data
DAC_B5_Setup2:			DAC_Null_Setup $0C,DAC_B5_Data
DAC_B6_Setup2:			DAC_Null_Setup $0C,DAC_B6_Data
DAC_B7_Setup2:			DAC_Null_Setup $18,DAC_B7_Data
DAC_B8_B9_Setup2:		DAC_Null_Setup $0C,DAC_B8_B9_Data
DAC_BA_Setup2:			DAC_Null_Setup $18,DAC_BA_Data
DAC_BB_Setup2:			DAC_Null_Setup $18,DAC_BB_Data
DAC_BC_Setup2:			DAC_Null_Setup $18,DAC_BC_Data
DAC_BD_Setup2:			DAC_Null_Setup $0C,DAC_BD_Data
DAC_BE_Setup2:			DAC_Null_Setup $0C,DAC_BE_Data
DAC_BF_Setup2:			DAC_Null_Setup $1C,DAC_BF_Data
DAC_C0_Setup2:			DAC_Null_Setup $0B,DAC_C0_Data
DAC_C1_Setup2:			DAC_Null_Chain $0F,DAC_Invalid,DAC_B4_Setup2
DAC_C2_Setup2:			DAC_Null_Chain $11,DAC_Invalid,DAC_C1_Setup2
DAC_C3_Setup2:			DAC_Null_Chain $12,DAC_Invalid,DAC_C2_Setup2
DAC_C4_Setup2:			DAC_Null_Chain $0B,DAC_Invalid,DAC_C3_Setup2
DAC_9C_Setup2:			DAC_Setup $0A,DAC_9C_Data
DAC_9D_Setup2:			DAC_Setup $18,DAC_9D_Data
DAC_9E_Setup2:			DAC_Setup $18,DAC_9E_Data
DAC_9F_Setup2:			DAC_Setup $0C,DAC_9F_Data
DAC_A0_Setup2:			DAC_Setup $0C,DAC_A0_Data
DAC_A1_Setup2:			DAC_Setup $0A,DAC_A1_Data

Bank2_Filler:			cnop 	$7F7,soundBankStart
DAC_9C_Data:			DACBINCLUDE "Sound/DAC/9C.bin"
DAC_9D_Data:			DACBINCLUDE "Sound/DAC/9D.bin"
DAC_9E_Data:			DACBINCLUDE "Sound/DAC/9E.bin"
DAC_9F_Data:			DACBINCLUDE "Sound/DAC/9F.bin"
DAC_A0_Data:			DACBINCLUDE "Sound/DAC/A0.bin"
DAC_A1_Data:			DACBINCLUDE "Sound/DAC/A1.bin"
DAC_A2_Data:			DACBINCLUDE "Sound/DAC/A2.bin"
DAC_A3_Data:			DACBINCLUDE "Sound/DAC/A3.bin"
DAC_A4_Data:			DACBINCLUDE "Sound/DAC/A4.bin"
DAC_A5_Data:			DACBINCLUDE "Sound/DAC/A5.bin"
DAC_A6_Data:			DACBINCLUDE "Sound/DAC/A6.bin"
DAC_A7_Data:			DACBINCLUDE "Sound/DAC/A7.bin"
DAC_A8_Data:			DACBINCLUDE "Sound/DAC/A8.bin"
DAC_A9_Data:			DACBINCLUDE "Sound/DAC/A9.bin"
DAC_AA_Data:			DACBINCLUDE "Sound/DAC/AA.bin"

	finishBank

; ---------------------------------------------------------------------------
; Dac Bank 3
; ---------------------------------------------------------------------------
DacBank3:			startBank
		offsetBankTableEntry.w	DAC_81_Setup3
		offsetBankTableEntry.w	DAC_82_Setup3
		offsetBankTableEntry.w	DAC_83_Setup3
		offsetBankTableEntry.w	DAC_84_Setup3
		offsetBankTableEntry.w	DAC_85_Setup3
		offsetBankTableEntry.w	DAC_86_Setup3
		offsetBankTableEntry.w	DAC_87_Setup3
		offsetBankTableEntry.w	DAC_88_Setup3
		offsetBankTableEntry.w	DAC_89_Setup3
		offsetBankTableEntry.w	DAC_8A_Setup3
		offsetBankTableEntry.w	DAC_8B_Setup3
		offsetBankTableEntry.w	DAC_8C_Setup3
		offsetBankTableEntry.w	DAC_8D_Setup3
		offsetBankTableEntry.w	DAC_8E_Setup3
		offsetBankTableEntry.w	DAC_8F_Setup3
		
		offsetBankTableEntry.w	DAC_90_Setup3
		offsetBankTableEntry.w	DAC_91_Setup3
		offsetBankTableEntry.w	DAC_92_Setup3
		offsetBankTableEntry.w	DAC_93_Setup3
		offsetBankTableEntry.w	DAC_94_Setup3
		offsetBankTableEntry.w	DAC_95_Setup3
		offsetBankTableEntry.w	DAC_96_Setup3
		offsetBankTableEntry.w	DAC_97_Setup3
		offsetBankTableEntry.w	DAC_98_Setup3
		offsetBankTableEntry.w	DAC_99_Setup3
		offsetBankTableEntry.w	DAC_9A_Setup3
		offsetBankTableEntry.w	DAC_9B_Setup3
		offsetBankTableEntry.w	DAC_9C_Setup3
		offsetBankTableEntry.w	DAC_9D_Setup3
		offsetBankTableEntry.w	DAC_9E_Setup3
		offsetBankTableEntry.w	DAC_9F_Setup3

		offsetBankTableEntry.w	DAC_A0_Setup3
		offsetBankTableEntry.w	DAC_A1_Setup3
		offsetBankTableEntry.w	DAC_A2_Setup3
		offsetBankTableEntry.w	DAC_A3_Setup3
		offsetBankTableEntry.w	DAC_A4_Setup3
		offsetBankTableEntry.w	DAC_A5_Setup3
		offsetBankTableEntry.w	DAC_A6_Setup3
		offsetBankTableEntry.w	DAC_A7_Setup3
		offsetBankTableEntry.w	DAC_A8_Setup3
		offsetBankTableEntry.w	DAC_A9_Setup3
		offsetBankTableEntry.w	DAC_AA_Setup3
		offsetBankTableEntry.w	DAC_AB_Setup3
		offsetBankTableEntry.w	DAC_AC_Setup3
		offsetBankTableEntry.w	DAC_AD_Setup3
		offsetBankTableEntry.w	DAC_AE_Setup3
		offsetBankTableEntry.w	DAC_AF_Setup3
		
		offsetBankTableEntry.w	DAC_B0_Setup3
		offsetBankTableEntry.w	DAC_B1_Setup3
		offsetBankTableEntry.w	DAC_B2_Setup3
		offsetBankTableEntry.w	DAC_B3_Setup3
		offsetBankTableEntry.w	DAC_B4_Setup3
		offsetBankTableEntry.w	DAC_B5_Setup3
		offsetBankTableEntry.w	DAC_B6_Setup3
		offsetBankTableEntry.w	DAC_B7_Setup3
		offsetBankTableEntry.w	DAC_B8_B9_Setup3
		offsetBankTableEntry.w	DAC_B8_B9_Setup3
		offsetBankTableEntry.w	DAC_BA_Setup3
		offsetBankTableEntry.w	DAC_BB_Setup3
		offsetBankTableEntry.w	DAC_BC_Setup3
		offsetBankTableEntry.w	DAC_BD_Setup3
		offsetBankTableEntry.w	DAC_BE_Setup3
		offsetBankTableEntry.w	DAC_BF_Setup3

		offsetBankTableEntry.w	DAC_C0_Setup3
		offsetBankTableEntry.w	DAC_C1_Setup3
		offsetBankTableEntry.w	DAC_C2_Setup3
		offsetBankTableEntry.w	DAC_C3_Setup3
		offsetBankTableEntry.w	DAC_C4_Setup3

DAC_81_Setup3:			DAC_Null_Setup $04,DAC_81_Data
DAC_82_Setup3:			DAC_Null_Setup $0E,DAC_82_83_84_85_Data
DAC_83_Setup3:			DAC_Null_Chain $14,DAC_Invalid,DAC_82_Setup3
DAC_84_Setup3:			DAC_Null_Chain $1A,DAC_Invalid,DAC_83_Setup3
DAC_85_Setup3:			DAC_Null_Chain $20,DAC_Invalid,DAC_84_Setup3
DAC_86_Setup3:			DAC_Null_Setup $04,DAC_86_Data
DAC_87_Setup3:			DAC_Null_Setup $04,DAC_87_Data
DAC_88_Setup3:			DAC_Null_Setup $06,DAC_88_Data
DAC_89_Setup3:			DAC_Null_Setup $0A,DAC_89_Data
DAC_8A_Setup3:			DAC_Null_Setup $14,DAC_8A_8B_Data
DAC_8B_Setup3:			DAC_Null_Chain $1B,DAC_Invalid,DAC_8A_Setup3
DAC_8C_Setup3:			DAC_Null_Setup $08,DAC_8C_Data
DAC_8D_Setup3:			DAC_Null_Setup $0B,DAC_8D_8E_Data
DAC_8E_Setup3:			DAC_Null_Chain $11,DAC_Invalid,DAC_8D_Setup3
DAC_8F_Setup3:			DAC_Null_Setup $08,DAC_8F_Data
DAC_90_Setup3:			DAC_Null_Setup $03,DAC_90_91_92_93_Data
DAC_91_Setup3:			DAC_Null_Chain $07,DAC_Invalid,DAC_90_Setup3
DAC_92_Setup3:			DAC_Null_Chain $0A,DAC_Invalid,DAC_91_Setup3
DAC_93_Setup3:			DAC_Null_Chain $0E,DAC_Invalid,DAC_92_Setup3
DAC_94_Setup3:			DAC_Null_Setup $06,DAC_94_95_96_97_Data
DAC_95_Setup3:			DAC_Null_Chain $0A,DAC_Invalid,DAC_94_Setup3
DAC_96_Setup3:			DAC_Null_Chain $0D,DAC_Invalid,DAC_95_Setup3
DAC_97_Setup3:			DAC_Null_Chain $12,DAC_Invalid,DAC_96_Setup3
DAC_98_Setup3:			DAC_Null_Setup $0B,DAC_98_99_9A_Data
DAC_99_Setup3:			DAC_Null_Chain $13,DAC_Invalid,DAC_98_Setup3
DAC_9A_Setup3:			DAC_Null_Chain $16,DAC_Invalid,DAC_99_Setup3
DAC_9B_Setup3:			DAC_Null_Setup $0C,DAC_9B_Data
DAC_A2_Setup3:			DAC_Null_Setup $0A,DAC_A2_Data
DAC_A3_Setup3:			DAC_Null_Setup $18,DAC_A3_Data
DAC_A4_Setup3:			DAC_Null_Setup $18,DAC_A4_Data
DAC_A5_Setup3:			DAC_Null_Setup $0C,DAC_A5_Data
DAC_A6_Setup3:			DAC_Null_Setup $09,DAC_A6_Data
DAC_A7_Setup3:			DAC_Null_Setup $18,DAC_A7_Data
DAC_A8_Setup3:			DAC_Null_Setup $18,DAC_A8_Data
DAC_A9_Setup3:			DAC_Null_Setup $0C,DAC_A9_Data
DAC_AA_Setup3:			DAC_Null_Setup $0A,DAC_AA_Data
DAC_AB_Setup3:			DAC_Setup $0D,DAC_AB_Data
DAC_AC_Setup3:			DAC_Setup $06,DAC_AC_Data
DAC_AD_Setup3:			DAC_Setup $10,DAC_AD_AE_Data
DAC_AE_Setup3:			DAC_Setup $18,DAC_AD_AE_Data
DAC_AF_Setup3:			DAC_Setup $09,DAC_AF_B0_Data
DAC_B0_Setup3:			DAC_Setup $12,DAC_AF_B0_Data
DAC_B1_Setup3:			DAC_Setup $18,DAC_B1_Data
DAC_B2_Setup3:			DAC_Null_Chain $16,DAC_B2_B3_Data,Bank3_Filler2-3
DAC_B3_Setup3:			DAC_Null_Chain $20,DAC_B2_B3_Data,Bank3_Filler2-3
DAC_B4_Setup3:			DAC_Setup $0C,DAC_B4_C1_C2_C3_C4_Data
DAC_B5_Setup3:			DAC_Setup $0C,DAC_B5_Data
DAC_B6_Setup3:			DAC_Setup $0C,DAC_B6_Data
DAC_B7_Setup3:			DAC_Setup $18,DAC_B7_Data
DAC_B8_B9_Setup3:		DAC_Setup $0C,DAC_B8_B9_Data
DAC_BA_Setup3:			DAC_Setup $18,DAC_BA_Data
DAC_BB_Setup3:			DAC_Setup $18,DAC_BB_Data
DAC_BC_Setup3:			DAC_Setup $18,DAC_BC_Data
DAC_BD_Setup3:			DAC_Setup $0C,DAC_BD_Data
DAC_BE_Setup3:			DAC_Setup $0C,DAC_BE_Data
DAC_BF_Setup3:			DAC_Setup $1C,DAC_BF_Data
DAC_C0_Setup3:			DAC_Setup $0B,DAC_C0_Data
DAC_C1_Setup3:			DAC_Setup $0F,DAC_B4_C1_C2_C3_C4_Data
DAC_C2_Setup3:			DAC_Setup $11,DAC_B4_C1_C2_C3_C4_Data
DAC_C3_Setup3:			DAC_Setup $12,DAC_B4_C1_C2_C3_C4_Data
DAC_C4_Setup3:			DAC_Setup $0B,DAC_B4_C1_C2_C3_C4_Data
DAC_9C_Setup3:			DAC_Null_Setup $0A,DAC_9C_Data
DAC_9D_Setup3:			DAC_Null_Setup $18,DAC_9D_Data
DAC_9E_Setup3:			DAC_Null_Setup $18,DAC_9E_Data
DAC_9F_Setup3:			DAC_Null_Setup $0C,DAC_9F_Data
DAC_A0_Setup3:			DAC_Null_Setup $0C,DAC_A0_Data
DAC_A1_Setup3:			DAC_Null_Setup $0A,DAC_A1_Data

DAC_AB_Data:			DACBINCLUDE "Sound/DAC/AB.bin"
DAC_AC_Data:			DACBINCLUDE "Sound/DAC/AC.bin"
DAC_AD_AE_Data:			DACBINCLUDE "Sound/DAC/AD-AE.bin"
DAC_AF_B0_Data:			DACBINCLUDE "Sound/DAC/AF-B0.bin"
Bank3_Filler1:			cnop 	$28E0,soundBankStart
DAC_B1_Data:			DACBINCLUDE "Sound/DAC/B1.bin"
Bank3_Filler2:			cnop 	$3CAD,soundBankStart
DAC_B4_C1_C2_C3_C4_Data:DACBINCLUDE "Sound/DAC/B4C1-C4.bin"
DAC_B5_Data:			DACBINCLUDE "Sound/DAC/B5.bin"
DAC_B6_Data:			DACBINCLUDE "Sound/DAC/B6.bin"
DAC_B7_Data:			DACBINCLUDE "Sound/DAC/B7.bin"
DAC_B8_B9_Data:			DACBINCLUDE "Sound/DAC/B8-B9.bin"
DAC_BA_Data:			DACBINCLUDE "Sound/DAC/BA.bin"
DAC_BB_Data:			DACBINCLUDE "Sound/DAC/BB.bin"
DAC_BC_Data:			DACBINCLUDE "Sound/DAC/BC.bin"
DAC_BD_Data:			DACBINCLUDE "Sound/DAC/BD.bin"
DAC_BE_Data:			DACBINCLUDE "Sound/DAC/BE.bin"
DAC_BF_Data:			DACBINCLUDE "Sound/DAC/BF.bin"
DAC_C0_Data:			DACBINCLUDE "Sound/DAC/C0.bin"

	finishBank

; ---------------------------------------------------------------------------
; ===========================================================================
; Sound Bank
; ===========================================================================
SndBank:			startBank

SEGA_PCM:	binclude "Sound/Sega PCM.bin"
		even
Sound_33:	binclude "Sound/SFX/33.bin"
Sound_34:	binclude "Sound/SFX/34.bin"
Sound_35:	binclude "Sound/SFX/35.bin"
Sound_36:	binclude "Sound/SFX/36.bin"
Sound_37:	binclude "Sound/SFX/37.bin"
Sound_38:	binclude "Sound/SFX/38.bin"
Sound_39:	binclude "Sound/SFX/39.bin"
Sound_3A:	binclude "Sound/SFX/3A.bin"
Sound_3B:	binclude "Sound/SFX/3B.bin"
Sound_3C:	binclude "Sound/SFX/3C.bin"
Sound_3D:	binclude "Sound/SFX/3D.bin"
Sound_3E:	binclude "Sound/SFX/3E.bin"
Sound_3F:	binclude "Sound/SFX/3F.bin"
Sound_40:	binclude "Sound/SFX/40.bin"
Sound_41:	binclude "Sound/SFX/41.bin"
Sound_42:	binclude "Sound/SFX/42.bin"
Sound_43:	binclude "Sound/SFX/43.bin"
Sound_44:	binclude "Sound/SFX/44.bin"
Sound_45:	binclude "Sound/SFX/45.bin"
Sound_46:	binclude "Sound/SFX/46.bin"
Sound_47:	binclude "Sound/SFX/47.bin"
Sound_48:	binclude "Sound/SFX/48.bin"
Sound_49:	binclude "Sound/SFX/49.bin"
Sound_4A:	binclude "Sound/SFX/4A.bin"
Sound_4B:	binclude "Sound/SFX/4B.bin"
Sound_4C:	binclude "Sound/SFX/4C.bin"
Sound_4D:	binclude "Sound/SFX/4D.bin"
Sound_4E:	binclude "Sound/SFX/4E.bin"
Sound_4F:	binclude "Sound/SFX/4F.bin"
Sound_50:	binclude "Sound/SFX/50.bin"
Sound_51:	binclude "Sound/SFX/51.bin"
Sound_52:	binclude "Sound/SFX/52.bin"
Sound_53:	binclude "Sound/SFX/53.bin"
Sound_54:	binclude "Sound/SFX/54.bin"
Sound_55:	binclude "Sound/SFX/55.bin"
Sound_56:	binclude "Sound/SFX/56.bin"
Sound_57:	binclude "Sound/SFX/57.bin"
Sound_58:	binclude "Sound/SFX/58.bin"
Sound_59:	binclude "Sound/SFX/59.bin"
Sound_5A:	binclude "Sound/SFX/5A.bin"
Sound_5B:	binclude "Sound/SFX/5B.bin"
Sound_5C:	binclude "Sound/SFX/5C.bin"
Sound_5D:	binclude "Sound/SFX/5D.bin"
Sound_5E:	binclude "Sound/SFX/5E.bin"
Sound_5F:	binclude "Sound/SFX/5F.bin"
Sound_60:	binclude "Sound/SFX/60.bin"
Sound_61:	binclude "Sound/SFX/61.bin"
Sound_62:	binclude "Sound/SFX/62.bin"
Sound_63:	binclude "Sound/SFX/63.bin"
Sound_64:	binclude "Sound/SFX/64.bin"
Sound_65:	binclude "Sound/SFX/65.bin"
Sound_66:	binclude "Sound/SFX/66.bin"
Sound_67:	binclude "Sound/SFX/67.bin"
Sound_68:	binclude "Sound/SFX/68.bin"
Sound_69:	binclude "Sound/SFX/69.bin"
Sound_6A:	binclude "Sound/SFX/6A.bin"
Sound_6B:	binclude "Sound/SFX/6B.bin"
Sound_6C:	binclude "Sound/SFX/6C.bin"
Sound_6D:	binclude "Sound/SFX/6D.bin"
Sound_6E:	binclude "Sound/SFX/6E.bin"
Sound_6F:	binclude "Sound/SFX/6F.bin"
Sound_70:	binclude "Sound/SFX/70.bin"
Sound_71:	binclude "Sound/SFX/71.bin"
Sound_72:	binclude "Sound/SFX/72.bin"
Sound_73:	binclude "Sound/SFX/73.bin"
Sound_74:	binclude "Sound/SFX/74.bin"
Sound_75:	binclude "Sound/SFX/75.bin"
Sound_76:	binclude "Sound/SFX/76.bin"
Sound_77:	binclude "Sound/SFX/77.bin"
Sound_78:	binclude "Sound/SFX/78.bin"
Sound_79:	binclude "Sound/SFX/79.bin"
Sound_7A:	binclude "Sound/SFX/7A.bin"
Sound_7B:	binclude "Sound/SFX/7B.bin"
Sound_7C:	binclude "Sound/SFX/7C.bin"
Sound_7D:	binclude "Sound/SFX/7D.bin"
Sound_7E:	binclude "Sound/SFX/7E.bin"
Sound_7F:	binclude "Sound/SFX/7F.bin"
Sound_80:	binclude "Sound/SFX/80.bin"
Sound_81:	binclude "Sound/SFX/81.bin"
Sound_82:	binclude "Sound/SFX/82.bin"
Sound_83:	binclude "Sound/SFX/83.bin"
Sound_84:	binclude "Sound/SFX/84.bin"
Sound_85:	binclude "Sound/SFX/85.bin"
Sound_86:	binclude "Sound/SFX/86.bin"
Sound_87:	binclude "Sound/SFX/87.bin"
Sound_88:	binclude "Sound/SFX/88.bin"
Sound_89:	binclude "Sound/SFX/89.bin"
Sound_8A:	binclude "Sound/SFX/8A.bin"
Sound_8B:	binclude "Sound/SFX/8B.bin"
Sound_8C:	binclude "Sound/SFX/8C.bin"
Sound_8D:	binclude "Sound/SFX/8D.bin"
Sound_8E:	binclude "Sound/SFX/8E.bin"
Sound_8F:	binclude "Sound/SFX/8F.bin"
Sound_90:	binclude "Sound/SFX/90.bin"
Sound_91:	binclude "Sound/SFX/91.bin"
Sound_92:	binclude "Sound/SFX/92.bin"
Sound_93:	binclude "Sound/SFX/93.bin"
Sound_94:	binclude "Sound/SFX/94.bin"
Sound_95:	binclude "Sound/SFX/95.bin"
Sound_96:	binclude "Sound/SFX/96.bin"
Sound_97:	binclude "Sound/SFX/97.bin"
Sound_98:	binclude "Sound/SFX/98.bin"
Sound_99:	binclude "Sound/SFX/99.bin"
Sound_9A:	binclude "Sound/SFX/9A.bin"
Sound_9B:	binclude "Sound/SFX/9B.bin"
Sound_9C:	binclude "Sound/SFX/9C.bin"
Sound_9D:	binclude "Sound/SFX/9D.bin"
Sound_9E:	binclude "Sound/SFX/9E.bin"
Sound_9F:	binclude "Sound/SFX/9F.bin"
Sound_A0:	binclude "Sound/SFX/A0.bin"
Sound_A1:	binclude "Sound/SFX/A1.bin"
Sound_A2:	binclude "Sound/SFX/A2.bin"
Sound_A3:	binclude "Sound/SFX/A3.bin"
Sound_A4:	binclude "Sound/SFX/A4.bin"
Sound_A5:	binclude "Sound/SFX/A5.bin"
Sound_A6:	binclude "Sound/SFX/A6.bin"
Sound_A7:	binclude "Sound/SFX/A7.bin"
Sound_A8:	binclude "Sound/SFX/A8.bin"
Sound_A9:	binclude "Sound/SFX/A9.bin"
Sound_AA:	binclude "Sound/SFX/AA.bin"
Sound_AB:	binclude "Sound/SFX/AB.bin"
Sound_AC:	binclude "Sound/SFX/AC.bin"
Sound_AD:	binclude "Sound/SFX/AD.bin"
Sound_AE:	binclude "Sound/SFX/AE.bin"
Sound_AF:	binclude "Sound/SFX/AF.bin"
Sound_B0:	binclude "Sound/SFX/B0.bin"
Sound_B1:	binclude "Sound/SFX/B1.bin"
Sound_B2:	binclude "Sound/SFX/B2.bin"
Sound_B3:	binclude "Sound/SFX/B3.bin"
Sound_B4:	binclude "Sound/SFX/B4.bin"
Sound_B5:	binclude "Sound/SFX/B5.bin"
Sound_B6:	binclude "Sound/SFX/B6.bin"
Sound_B7:	binclude "Sound/SFX/B7.bin"
Sound_B8:	binclude "Sound/SFX/B8.bin"
Sound_B9:	binclude "Sound/SFX/B9.bin"
Sound_BA:	binclude "Sound/SFX/BA.bin"
Sound_BB:	binclude "Sound/SFX/BB.bin"
Sound_BC:	binclude "Sound/SFX/BC.bin"
Sound_BD:	binclude "Sound/SFX/BD.bin"
Sound_BE:	binclude "Sound/SFX/BE.bin"
Sound_BF:	binclude "Sound/SFX/BF.bin"
Sound_C0:	binclude "Sound/SFX/C0.bin"
Sound_C1:	binclude "Sound/SFX/C1.bin"
Sound_C2:	binclude "Sound/SFX/C2.bin"
Sound_C3:	binclude "Sound/SFX/C3.bin"
Sound_C4:	binclude "Sound/SFX/C4.bin"
Sound_C5:	binclude "Sound/SFX/C5.bin"
Sound_C6:	binclude "Sound/SFX/C6.bin"
Sound_C7:	binclude "Sound/SFX/C7.bin"
Sound_C8:	binclude "Sound/SFX/C8.bin"
Sound_C9:	binclude "Sound/SFX/C9.bin"
Sound_CA:	binclude "Sound/SFX/CA.bin"
Sound_CB:	binclude "Sound/SFX/CB.bin"
Sound_CC:	binclude "Sound/SFX/CC.bin"
Sound_CD:	binclude "Sound/SFX/CD.bin"
Sound_CE:	binclude "Sound/SFX/CE.bin"
Sound_CF:	binclude "Sound/SFX/CF.bin"
Sound_D0:	binclude "Sound/SFX/D0.bin"
Sound_D1:	binclude "Sound/SFX/D1.bin"
Sound_D2:	binclude "Sound/SFX/D2.bin"
Sound_D3:	binclude "Sound/SFX/D3.bin"
Sound_D4:	binclude "Sound/SFX/D4.bin"
Sound_D5:	binclude "Sound/SFX/D5.bin"
Sound_D6:	binclude "Sound/SFX/D6.bin"
Sound_D7:	binclude "Sound/SFX/D7.bin"
Sound_D8:	binclude "Sound/SFX/D8.bin"
Sound_D9:	binclude "Sound/SFX/D9.bin"
Sound_DA:	binclude "Sound/SFX/DA.bin"
Sound_DB:	binclude "Sound/SFX/DB.bin"

	finishBank

; ---------------------------------------------------------------------------
; ===========================================================================
; Music Banks
; ===========================================================================
; Music Bank 1
; ---------------------------------------------------------------------------
Snd_Bank1_Start:	startBank
Snd_FBZ1:			binclude	"Sound/Music/FBZ1.bin"
Snd_FBZ2:			binclude	"Sound/Music/FBZ2.bin"
Snd_MHZ1:			binclude	"Sound/Music/MHZ1.bin"
Snd_MHZ2:			binclude	"Sound/Music/MHZ2.bin"
Snd_SOZ1:			binclude	"Sound/Music/SOZ1.bin"
Snd_SOZ2:			binclude	"Sound/Music/SOZ2.bin"
Snd_LRZ1:			binclude	"Sound/Music/LRZ1.bin"
Snd_LRZ2:			binclude	"Sound/Music/LRZ2.bin"
Snd_SSZ:			binclude	"Sound/Music/SSZ.bin"
Snd_DEZ1:			binclude	"Sound/Music/DEZ1.bin"
Snd_DEZ2:			binclude	"Sound/Music/DEZ2.bin"
Snd_Minib_SK:		binclude	"Sound/Music/Miniboss.bin"
Snd_Boss:			binclude	"Sound/Music/Zone Boss.bin"
Snd_DDZ:			binclude	"Sound/Music/DDZ.bin"
Snd_PachBonus:		binclude	"Sound/Music/Pachinko.bin"
Snd_SpecialS:		binclude	"Sound/Music/Special Stage.bin"
Snd_SlotBonus:		binclude	"Sound/Music/Slots.bin"
Snd_Knux:			binclude	"Sound/Music/Knuckles.bin"
Snd_Title:			binclude	"Sound/Music/Title.bin"
Snd_1UP:			binclude	"Sound/Music/1UP.bin"
Snd_Emerald:		binclude	"Sound/Music/Chaos Emerald.bin"

	finishBank

; ---------------------------------------------------------------------------
; Music Bank 2
; ---------------------------------------------------------------------------
Snd_Bank2_Start:	startBank
Snd_AIZ1:			binclude	"Sound/Music/AIZ1.bin"
Snd_AIZ2:			binclude	"Sound/Music/AIZ2.bin"
Snd_HCZ1:			binclude	"Sound/Music/HCZ1.bin"
Snd_HCZ2:			binclude	"Sound/Music/HCZ2.bin"
Snd_MGZ1:			binclude	"Sound/Music/MGZ1.bin"
Snd_MGZ2:			binclude	"Sound/Music/MGZ2.bin"
Snd_CNZ2:			binclude	"Sound/Music/CNZ2.bin"
Snd_CNZ1:			binclude	"Sound/Music/CNZ1.bin"

	finishBank

; ---------------------------------------------------------------------------
; Music Bank 3
; ---------------------------------------------------------------------------
Snd_Bank3_Start:	startBank
Snd_ICZ2:			binclude	"Sound/Music/ICZ2.bin"
Snd_ICZ1:			binclude	"Sound/Music/ICZ1.bin"
Snd_LBZ2:			binclude	"Sound/Music/LBZ2.bin"
Snd_LBZ1:			binclude	"Sound/Music/LBZ1.bin"
		org		soundBankStart+$4104
Snd_SKCredits:		binclude 	"Sound/Music/Credits.bin"
Snd_GameOver:		binclude	"Sound/Music/Game Over.bin"
Snd_Continue:		binclude	"Sound/Music/Continue.bin"
Snd_Results:		binclude	"Sound/Music/Level Outro.bin"
Snd_Invic:			binclude	"Sound/Music/Invincible.bin"
Snd_Menu:			binclude	"Sound/Music/Menu.bin"
Snd_FinalBoss:		binclude	"Sound/Music/Final Boss.bin"
Snd_PresSega:		binclude	"Sound/Music/Game Complete.bin"

	finishBank

; ---------------------------------------------------------------------------
; Music Bank 4
; ---------------------------------------------------------------------------
Snd_Bank4_Start:	startBank
		org		soundBankStart+$AE8
Snd_GumBonus:		binclude	"Sound/Music/Gum Ball Machine.bin"
		org		soundBankStart+$19F7
Snd_ALZ:			binclude	"Sound/Music/Azure Lake.bin"
Snd_BPZ:			binclude	"Sound/Music/Balloon Park.bin"
Snd_DPZ:			binclude	"Sound/Music/Desert Palace.bin"
Snd_CGZ:			binclude	"Sound/Music/Chrome Gadget.bin"
Snd_EMZ:			binclude	"Sound/Music/Endless Mine.bin"
		org		soundBankStart+$6587
Snd_S3Credits:		binclude	"Sound/Music/Sonic 3 Credits.bin"
		org		soundBankStart+$75E4
Snd_2PMenu:			binclude	"Sound/Music/Competition Menu.bin"	
Snd_Drown:			binclude	"Sound/Music/Countdown.bin"

	finishBank

