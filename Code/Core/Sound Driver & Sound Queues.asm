
; =============== S U B R O U T I N E =======================================


SndDrvInit:
		nop
		move.w	#$100,(Z80_bus_request).l
		move.w	#$100,(Z80_reset).l	; release Z80 reset

		; Load SMPS sound driver
		lea	(Z80_SoundDriver).l,a0
		lea	(Z80_RAM).l,a1
	if Sonic3_Alone
		move.w	#(Size_of_Snd_driver_guess+Size_of_Snd_driver2_guess+$BC)-1,d0	; Oddly, this loads $BC extra bytes of padding into the Z80 instead of loading the exact size of the Z80. Remove the +$BC to fix this.

-		move.b	(a0)+,(a1)+
		dbf	d0,-
	else
		bsr.w	Kos_Decomp

		; Load sound driver data (PSG envelopes, music/sound pointers, FM voice bank)
		lea	(Z80_SoundDriverData).l,a0
		lea	(Z80_RAM+z80_SoundDriverPointers).l,a1
		bsr.w	Kos_Decomp
	endif
		; Load default variables
		lea	(Z80_DefaultVariables).l,a0
		lea	(Z80_RAM+zDataStart).l,a1
		move.w	#Z80_DefaultVariables_end-Z80_DefaultVariables-1,d0

-
		move.b	(a0)+,(a1)+
		dbf	d0,-
		; Detect PAL region consoles
		btst	#6,(Graphics_flags).w
		beq.s	+
		move.b	#1,(Z80_RAM+zPalFlag).l

+
		move.w	#0,(Z80_reset).l	; reset Z80
		nop
		nop
		nop
		nop
		move.w	#$100,(Z80_reset).l	; release reset
		startZ80
		rts
; End of function SndDrvInit

; ---------------------------------------------------------------------------
; Default Z80 variables. These are actually set to more meaningful values
; in other SMPS Z80 drivers.
; ---------------------------------------------------------------------------
Z80_DefaultVariables:
		dc.b 0	; Unused 1
		dc.b 0	; Unused 2
		dc.b 0	; zPalFlag
		dc.b 0	; Unused 3
		dc.b 0	; zPalDblUpdCounter
		dc.b 0	; zSoundQueue0
		dc.b 0	; zSoundQueue1
		dc.b 0	; zSoundQueue2
		dc.b 0	; zTempoSpeedup
		dc.b 0	; zNextSound
		dc.b 0	; zMusicNumber
		dc.b 0	; zSFXNumber0
		dc.b 0	; zSFXNumber1
		dc.b 0	; zFadeOutTimeout
		dc.b 0	; zFadeDelay
		dc.b 0	; zFadeDelayTimeout
Z80_DefaultVariables_end:

; ---------------------------------------------------------------------------
; Always replaces an index previous passed to this function
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Play_Music:
		stopZ80
		move.b	d0,(Z80_RAM+zMusicNumber).l
		startZ80
		rts
; End of function Play_Music

; ---------------------------------------------------------------------------
; plays a sound if the source object is on-screen
; unused/dead code, left over from Sonic 2

Play_SFX_Local:
		tst.b	render_flags(a0)
		bpl.s	Play_SFX_Done

; ---------------------------------------------------------------------------
; Can handle up to two different indexes in one frame
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Play_SFX:
		stopZ80
		cmp.b	(Z80_RAM+zSFXNumber0).l,d0
		beq.s	++
		tst.b	(Z80_RAM+zSFXNumber0).l
		bne.s	+
		move.b	d0,(Z80_RAM+zSFXNumber0).l
		startZ80
		rts

+
		move.b	d0,(Z80_RAM+zSFXNumber1).l

+
		startZ80

Play_SFX_Done:
		rts
; End of function Play_SFX


; =============== S U B R O U T I N E =======================================


Change_Music_Tempo:
		stopZ80
		move.b	d0,(Z80_RAM+zTempoSpeedup).l
		startZ80
		rts
; End of function Change_Music_Tempo