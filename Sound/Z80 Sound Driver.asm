; ---------------------------------------------------------------------------
; ===========================================================================
; ║                                                                         ║
; ║                             SONIC&K SOUND DRIVER                        ║
; ║                         Modified SMPS Z80 Type 2 DAC                    ║
; ║                                                                         ║
; ===========================================================================
; Disassembled by MarkeyJester
; Routines, pointers and stuff by Linncaki
; Thoroughly commented and improved (including optional bugfixes) by Flamewing
; ===========================================================================
; Constants
; ===========================================================================

; Set this to 1 to fix some bugs in the driver.
fix_sndbugs				=  0

z80_SoundDriverStart:

; ---------------------------------------------------------------------------
zTrack STRUCT DOTS
	; Playback control bits:
	; 	0 (01h)		Noise channel (PSG) or FM3 special mode (FM)
	; 	1 (02h)		Do not attack next note
	; 	2 (04h)		SFX is overriding this track
	; 	3 (08h)		'Alternate frequency mode' flag
	; 	4 (10h)		'Track is resting' flag
	; 	5 (20h)		'Pitch slide' flag
	; 	6 (40h)		'Sustain frequency' flag -- prevents frequency from changing again for the lifetime of the track
	; 	7 (80h)		Track is playing
	PlaybackControl:	ds.b 1	; S&K: 0
	; Voice control bits:
	; 	0-1    		FM channel assignment bits (00 = FM1 or FM4, 01 = FM2 or FM5, 10 = FM3 or FM6/DAC, 11 = invalid)
	; 	2 (04h)		For FM/DAC channels, selects if reg/data writes are bound for part II (set) or part I (unset)
	; 	3 (08h)		Unknown/unused
	; 	4 (10h)		Unknown/unused
	; 	5-6    		PSG Channel assignment bits (00 = PSG1, 01 = PSG2, 10 = PSG3, 11 = Noise)
	; 	7 (80h)		PSG track if set, FM or DAC track otherwise
	VoiceControl:		ds.b 1	; S&K: 1
	TempoDivider:		ds.b 1	; S&K: 2
	DataPointerLow:		ds.b 1	; S&K: 3
	DataPointerHigh:	ds.b 1	; S&K: 4
	Transpose:			ds.b 1	; S&K: 5
	Volume:				ds.b 1	; S&K: 6
	ModulationCtrl:		ds.b 1	; S&K: 7		; Modulation is on if nonzero. If only bit 7 is set, then it is normal modulation; otherwise, this-1 is index on modulation envelope pointer table
	VoiceIndex:			ds.b 1	; S&K: 8		; FM instrument/PSG voice
	StackPointer:		ds.b 1	; S&K: 9		; For call subroutine coordination flag
	AMSFMSPan:			ds.b 1	; S&K: 0Ah
	DurationTimeout:	ds.b 1	; S&K: 0Bh
	SavedDuration:		ds.b 1	; S&K: 0Ch		; Already multiplied by timing divisor
	; ---------------------------------
	; Alternate names for same offset:
	SavedDAC:					; S&K: 0Dh		; For DAC channel
	FreqLow:			ds.b 1	; S&K: 0Dh		; For FM/PSG channels
	; ---------------------------------
	FreqHigh:			ds.b 1	; S&K: 0Eh		; For FM/PSG channels
	VoiceSongID:		ds.b 1	; S&K: 0Fh		; For using voices from a different song
	Detune:			ds.b 1	; S&K: 10h	; In S&K, some places used 11h instead of 10h
	Unk11h:			ds.b 1	; S&K: 11h
					ds.b 5	; S&K: 12h-16h	; Unused
	VolEnv:				ds.b 1	; S&K: 17h		; Used for dynamic volume adjustments
	; ---------------------------------
	; Alternate names for same offsets:
	FMVolEnv:					; S&K: 18h
	HaveSSGEGFlag:		ds.b 1	; S&K: 18h		; For FM channels, if track has SSG-EG data
	FMVolEnvMask:				; S&K: 19h
	SSGEGPointerLow:	ds.b 1	; S&K: 19h		; For FM channels, custom SSG-EG data pointer
	PSGNoise:					; S&K: 1Ah
	SSGEGPointerHigh:	ds.b 1	; S&K: 1Ah		; For FM channels, custom SSG-EG data pointer
	; ---------------------------------
	FeedbackAlgo:		ds.b 1	; S&K: 1Bh
	TLPtrLow:			ds.b 1	; S&K: 1Ch
	TLPtrHigh:			ds.b 1	; S&K: 1Dh
	NoteFillTimeout:	ds.b 1	; S&K: 1Eh
	NoteFillMaster:		ds.b 1	; S&K: 1Fh
	ModulationPtrLow:	ds.b 1	; S&K: 20h
	ModulationPtrHigh:	ds.b 1	; S&K: 21h
	; ---------------------------------
	; Alternate names for same offset:
	ModulationValLow:			; S&K: 22h
	ModEnvSens:			ds.b 1	; S&K: 22h
	; ---------------------------------
	ModulationValHigh:	ds.b 1	; S&K: 23h
	ModulationWait:		ds.b 1	; S&K: 24h
	; ---------------------------------
	; Alternate names for same offset:
	ModulationSpeed:			; S&K: 25h
	ModEnvIndex:		ds.b 1	; S&K: 25h
	; ---------------------------------
	ModulationDelta:	ds.b 1	; S&K: 26h
	ModulationSteps:	ds.b 1	; S&K: 27h
	LoopCounters:		ds.b 2	; S&K: 28h		; Might overflow into the following data
	VoicesLow:			ds.b 1	; S&K: 2Ah		; Low byte of pointer to track's voices, used only if zUpdatingSFX is set
	VoicesHigh:			ds.b 1	; S&K: 2Bh		; High byte of pointer to track's voices, used only if zUpdatingSFX is set
	Stack_top:			ds.b 4	; S&K: 2Ch-2Fh	; Track stack; can be used by LoopCounters
zTrack ENDSTRUCT
; ---------------------------------------------------------------------------
z80_stack				=	$2000
z80_stack_end				=	z80_stack-$60
; equates: standard (for Genesis games) addresses in the memory map
zYM2612_A0				=	$4000
zYM2612_D0				=	$4001
zYM2612_A1				=	$4002
zYM2612_D1				=	$4003
zBankRegister			=	$6000
zPSG					=	$7F11
zROMWindow				=	$8000
; ---------------------------------------------------------------------------
; z80 RAM:
	if fix_sndbugs
zDataStart				=	$1BF0
	else
zDataStart				=	$1C00
	endif
		phase zDataStart
	if fix_sndbugs
zSpecFM3Freqs				ds.b 8
zSpecFM3FreqsSFX			ds.b 8
	endif
					ds.b 2	; unused
zPalFlag:			ds.b 1
					ds.b 1	; unused
zPalDblUpdCounter:	ds.b 1
zSoundQueue0:		ds.b 1
zSoundQueue1:		ds.b 1
zSoundQueue2:		ds.b 1
zTempoSpeedup:		ds.b 1
zNextSound:			ds.b 1
; The following 3 variables are used for M68K input
zMusicNumber:		ds.b 1	; Play_Sound
zSFXNumber0:		ds.b 1	; Play_Sound_2
zSFXNumber1:		ds.b 1	; Play_Sound_2

zTempVariablesStart:

zFadeOutTimeout:	ds.b 1
zFadeDelay:			ds.b 1
zFadeDelayTimeout:	ds.b 1
zPauseFlag:			ds.b 1
zHaltFlag:			ds.b 1
zFM3Settings:		ds.b 1	; Set twice, never read (is read in Z80 Type 1 for YM timer-related purposes)
zTempoAccumulator:	ds.b 1
					ds.b 1	; unused
unk_1C15			ds.b 1	; Set twice, never read
zFadeToPrevFlag:	ds.b 1
unk_1C17:			ds.b 1	; Set once, never read
unk_1C18:			ds.b 1	; Set twice, never read
zUpdatingSFX:		ds.b 1
					ds.b $A	; unused
zCurrentTempo:		ds.b 1
zContinuousSFX:		ds.b 1
zContinuousSFXFlag:	ds.b 1
zSpindashRev:		ds.b 1
zRingSpeaker:		ds.b 1
zFadeInTimeout:		ds.b 1
zVoiceTblPtrSave:	ds.b 2	; For 1-up
zCurrentTempoSave:	ds.b 1	; For 1-up
zSongBankSave:		ds.b 1	; For 1-up
zTempoSpeedupSave:	ds.b 1	; For 1-up
zSpeedupTimeout:	ds.b 1
zDACIndex:			ds.b 1	; bit 7 = 1 if playing, 0 if not; remaining 7 bits are index into DAC tables (1-based)
zContSFXLoopCnt:	ds.b 1	; Used as a loop counter for continuous SFX
zSFXSaveIndex:		ds.b 1
zSongPosition:		ds.b 2
zTrackInitPos:		ds.b 2	; 2 bytes
zVoiceTblPtr:		ds.b 2	; 2 bytes
zSFXVoiceTblPtr:	ds.b 2	; 2 bytes
zSFXTempoDivider:	ds.b 1
					ds.b 2	; unused
zSongBank:			ds.b 1	; Bits 15 to 22 of M68K bank address
PlaySegaPCMFlag:	ds.b 1
; Now starts song and SFX z80 RAM
; Max number of music channels: 6 FM + 3 PSG or 1 DAC + 5 FM + 3 PSG
zTracksStart:
zSongFM6_DAC:	zTrack
zSongFM1:		zTrack
zSongFM2:		zTrack
zSongFM3:		zTrack
zSongFM4:		zTrack
zSongFM5:		zTrack
zSongPSG1:		zTrack
zSongPSG2:		zTrack
zSongPSG3:		zTrack
zTracksEnd:
; This is RAM for backup of songs (when 1-up jingle is playing)
; and for SFX channels. Note these two overlap.
; Max number of SFX channels: 4 FM + 3 PSG
zTracksSFXStart:
zSFX_FM3:		zTrack
zSFX_FM4:		zTrack
zSFX_FM5:		zTrack
zSFX_FM6:		zTrack
zSFX_PSG1:		zTrack
zSFX_PSG2:		zTrack
zSFX_PSG3:		zTrack
zTracksSFXEnd:
		dephase

		phase zTracksSFXStart
zTracksSaveStart:
zSaveSongDAC:	zTrack
zSaveSongFM1:	zTrack
zSaveSongFM2:	zTrack
zSaveSongFM3:	zTrack
zSaveSongFM4:	zTrack
zSaveSongFM5:	zTrack
zSaveSongPSG1:	zTrack
zSaveSongPSG2:	zTrack
zSaveSongPSG3:	zTrack
zTracksSaveEnd:

zTempVariablesEnd:
	if * > z80_stack_end	; Don't declare more space than the RAM can contain!
		fatal "The RAM variable declarations are too large. It's \{*-z80_stack_end}h bytes past the start of the bottom of the stack, at \{z80_stack_end}h."
	endif
		dephase
; ---------------------------------------------------------------------------
		!org z80_SoundDriverStart	; Rewind the ROM address to where we were earlier (allocating the RAM above messes with it)
; z80_SoundDriver:
Z80_SoundDriver:
		org		Z80_SoundDriver+Size_of_Snd_driver_guess	; This 'org' inserts some padding that we can paste the compressed sound driver over later (see the 's3p2bin' tool)

		save
		!org	0							; z80 Align, handled by the build process
		CPU Z80
		listing purecode
; ---------------------------------------------------------------------------
NoteRest				= 080h
FirstCoordFlag			= 0E0h
; ---------------------------------------------------------------------------
	if fix_sndbugs
zID_MusicPointers = 0
zID_SFXPointers = 2
zID_ModEnvPointers = 4
zID_VolEnvPointers = 6
	else
zID_PriorityList = 0	; Earlier drivers had this; unused
zID_UniVoiceBank = 2
zID_MusicPointers = 4
zID_SFXPointers = 6
zID_ModEnvPointers = 8
zID_VolEnvPointers = 0Ah
zID_SongLimit = 0Ch		; Earlier drivers had this; unused
	endif
; ---------------------------------------------------------------------------

; ===========================================================================
; Macros
; ===========================================================================
bankswitch1 macro
		ld	hl, zBankRegister
		ld	(hl), a
		rept 7
			rrca
			ld	(hl), a
		endm
	if fix_sndbugs
		ld	(hl),h ; The low bit of h is 0
	else
		xor	a
		ld	(hl), a
	endif
    endm

bankswitch2 macro
		ld	hl, zBankRegister
		ld	(hl), a
		rept 7
			rra
			ld	(hl), a
		endm
	if fix_sndbugs
		ld	(hl),h ; The low bit of h is 0
	else
		xor	a
		ld	(hl), a
	endif
    endm

bankswitch3 macro
		ld	b, 8

.bankloop:
		ld	(zBankRegister), a
		rrca
		djnz	.bankloop
		xor	a
		ld	(zBankRegister), a
    endm

bankswitchToMusic macro
		ld	hl, zBankRegister
		ld	a, (zSongBank)
		ld	(hl), a
		rept 7
			rra
			ld	(hl), a
		endm
	if fix_sndbugs
		ld	(hl),h ; The low bit of h is 0
	else
		xor	a
		ld	(hl), a
	endif
    endm

; macro to make a certain error message clearer should you happen to get it...
rsttarget macro {INTLABEL}
	if ($&7)||($>38h)
		fatal "Function __LABEL__ is at 0\{$}h, but must be at a multiple of 8 bytes <= 38h to be used with the rst instruction."
	endif
	if "__LABEL__"<>""
__LABEL__ label $
	endif
    endm

; function to turn a 68k address into a word the Z80 can use to access it
zmake68kPtr function addr,zROMWindow+(addr&7FFFh)

; function to turn a 68k address into a bank byte
zmake68kBank function addr,(((addr&3F8000h)/zROMWindow))
; ---------------------------------------------------------------------------
; ===========================================================================
; Entry Point
; ===========================================================================

; EntryPoint:
		di									; Disable interrupts
		di									; Disable interrupts
		im	1								; set interrupt mode 1
		jp	zInitAudioDriver
; ---------------------------------------------------------------------------
	if fix_sndbugs=0
		db 0F2h								; Filler; broken jp p,loc?
	endif

; =============== S U B	R O U T	I N E =======================================
;
; Gets the correct pointer to pointer table for the data type in question
; (music, sfx, voices, etc.).
;
; Input:  c    ID for data type.
; Output: hl   Master pointer table for	index
;         af'  Trashed
;         b    Trashed

; sub_8
	align	8
GetPointerTable:	rsttarget
	if fix_sndbugs
		ld	hl, z80_SoundDriverPointers		; Load pointer table
	else
		ld	hl, (ptrMasterIndex)			; Read pointer to (pointer to pointer table) table
	endif
		ld	b, 0							; b = 0
		add	hl, bc							; Add offset into pointer table
		ex	af, af'							; Back up af
		ld	a, (hl)							; Read low byte of pointer into a
		inc	hl
		ld	h, (hl)							; Read high byte of pointer into h
		ld	l, a							; Put low byte of pointer into l
		ex	af, af'							; Restore af
		ret
; End of function GetPointerTable

; ---------------------------------------------------------------------------
	if fix_sndbugs=0
;word_15
ptrMasterIndex:
		dw		z80_SoundDriverPointers
	endif

; =============== S U B	R O U T	I N E =======================================
;
; Reads	an offset into a pointer table and returns dereferenced pointer.
;
;
; Input:  a    Index into pointer table
;	      hl   Pointer to pointer table
; Output: hl   Selected	pointer	in pointer table
;         bc   Trashed

; sub_18
	align	8
PointerTableOffset:	rsttarget
		ld	c, a							; c = index into pointer table
		ld	b, 0							; b = 0
		add	hl, bc							; hl += bc
		add	hl, bc							; hl += bc
	if fix_sndbugs
		jp	ReadPointer						; 10 clock cycles, 3 bytes
	else
		nop								; 12 clock cycles, 3 bytes
		nop
		nop
	endif
; End of function PointerTableOffset

; =============== S U B	R O U T	I N E =======================================
;
; Dereferences a pointer.
;
; Input:  hl	Pointer
; output: hl	Equal to what that was being pointed to by hl

; loc_20
	align	8
ReadPointer:	rsttarget
		ld	a, (hl)							; Read low byte of pointer into a
		inc	hl
		ld	h, (hl)							; Read high byte of pointer into h
		ld	l, a							; Put low byte of pointer into l
		ret
; End of function PointerTableOffset

; ---------------------------------------------------------------------------
; There is room for two more 'rsttarget's here
; ---------------------------------------------------------------------------
	align	38h
; =============== S U B	R O U T	I N E =======================================
;
; This subroutine is called every V-Int. After it is processed, the z80
; returns to the digital audio loop to continue playing DAC samples.
;
; If the SEGA PCM is being played, it disables interrupts -- this means that
; this procedure will NOT be called while the SEGA PCM is playing.
;
;zsub_38
zVInt:	rsttarget
		di									; Disable interrupts
		push	af							; Save af
		push	iy							; Save iy
		exx									; Save bc,de,hl

.doupdate:
	if fix_sndbugs=0
		ld	a, r							; Get memory refresh register
		ld	(unk_1C17), a					; Save it
	endif
		call	zUpdateEverything			; Update all tracks
		ld	a, (zPalFlag)					; Get PAL flag
		or	a								; Is it set?
		jr	z, .not_pal						; Branch if not (NTSC)
		ld	a, (zPalDblUpdCounter)			; Get PAL double-update timeout counter
		or	a								; Is it zero?
		jr	nz, .pal_timer					; Branch if not
		ld	a, 5							; Set it back to 5...
		ld	(zPalDblUpdCounter), a			; ... and save it
		jp	.doupdate						; Go again

.pal_timer:
		dec	a								; Decrease PAL double-update timeout counter
		ld	(zPalDblUpdCounter), a			; Store it

.not_pal:
		ld	a, (zDACIndex)					; Get index of playing DAC sample
		and	7Fh								; Strip 'DAC playing' bit
		ld	c, a							; c = a
		ld	b, 0							; Sign extend c to bc
		ld	hl, DAC_Banks					; Make hl point to DAC bank table
		add	hl, bc							; Offset into entry for current sample
		ld	a, (hl)							; Get bank index
		bankswitch1							; Switch to current DAC sample's bank
		exx									; Restore bc,de,hl
		pop	iy								; Restore iy
		pop	af								; Restore af
		ld	b, 1							; b = 1
		ret
; ---------------------------------------------------------------------------
;loc_85
zInitAudioDriver:
		ld	sp, z80_stack					; set the stack pointer to 0x2000 (end of z80 RAM)
			; The following instruction block keeps the z80 in a tight loop.
		ld	c, 0							; c = 0

.loop:
		ld	b, 0							; b = 0
		djnz	$							; Loop in this instruction, decrementing b each iteration, until b = 0
		dec	c								; c--
		jr	z, .loop						; Loop if c = 0

		call	zStopAllSound					; Stop all music
		ld	a, zmake68kBank(Snd_Bank2_Start)		; Set song bank to second music bank (default value)
		ld	(zSongBank), a					; Store it
		xor	a								; a = 0
		ld	(zSpindashRev), a				; Reset spindash rev
		ld	(zDACIndex), a					; Clear current DAC sample index
		ld	(PlaySegaPCMFlag), a			; Clear the Sega sound flag
		ld	(zRingSpeaker), a				; Make rings play on left speaker
		ld	a, 5							; Set PAL double-update counter to 5
		ld	(zPalDblUpdCounter), a			; (that is, do not double-update for 5 frames)
		ei									; Enable interrupts
		jp	zPlayDigitalAudio				; Start digital audio loop

; =============== S U B	R O U T	I N E =======================================
;
; Writes a reg/data pair to part I or II
;
; Input:  a    Value for register
;         c    Value for data
;         ix   Pointer to track RAM

;sub_AF
zWriteFMIorII:
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG track?
		ret	nz								; Is so, quit
		bit	2, (ix+zTrack.PlaybackControl)	; Is SFX overriding this track?
		ret	nz								; Return if yes
		add	a, (ix+zTrack.VoiceControl)		; Add the channel bits to the register address
		bit	2, (ix+zTrack.VoiceControl)		; Is this the DAC channel or FM4 or FM5 or FM6?
		jr	nz, zWriteFMII_reduced			; If yes, write reg/data pair to part II;
											; otherwise, write reg/data pair as is to part I.
; End of function zWriteFMIorII


; =============== S U B	R O U T	I N E =======================================
;
; Writes a reg/data pair to part I
;
; Input:  a    Value for register
;         c    Value for data

;sub_C2
zWriteFMI:
		ld	(zYM2612_A0), a					; Select YM2612 register
	if fix_sndbugs=0
		; Pointless, since there's no need to delay between writing to the address port and the data port
		nop									; Wait
	endif
		ld	a, c							; a = data to send
		ld	(zYM2612_D0), a					; Send data to register
		ret
; End of function zWriteFMI
; ---------------------------------------------------------------------------

;loc_CB
zWriteFMII_reduced:
		sub	4								; Strip 'bound to part II regs' bit
; ---------------------------------------------------------------------------

; =============== S U B	R O U T	I N E =======================================
;
; Writes a reg/data pair to part II
;
; Input:  a    Value for register
;         c    Value for data

;sub_CD
zWriteFMII:
		ld	(zYM2612_A1), a					; Select YM2612 register
	if fix_sndbugs=0
		; Pointless, since there's no need to delay between writing to the address port and the data port
		nop									; Wait
	endif
		ld	a, c							; a = data to send
		ld	(zYM2612_D1), a					; Send data to register
		ret
; End of function zWriteFMII

; ---------------------------------------------------------------------------
; ===========================================================================
; DAC BANKS
; ===========================================================================
; Note: this table has a dummy first entry for the case when there is no DAC
; sample being played -- the code still results in a valid bank switch, and
; does not need to worry about special cases.
DAC_Banks:
		db		zmake68kBank(DacBank1)               ,zmake68kBank(DAC_81_Data)            ,zmake68kBank(DAC_82_83_84_85_Data)   ,zmake68kBank(DAC_82_83_84_85_Data)
		db		zmake68kBank(DAC_82_83_84_85_Data)   ,zmake68kBank(DAC_82_83_84_85_Data)   ,zmake68kBank(DAC_86_Data)            ,zmake68kBank(DAC_87_Data)
		db		zmake68kBank(DAC_88_Data)            ,zmake68kBank(DAC_89_Data)            ,zmake68kBank(DAC_8A_8B_Data)         ,zmake68kBank(DAC_8A_8B_Data)
		db		zmake68kBank(DAC_8C_Data)            ,zmake68kBank(DAC_8D_8E_Data)         ,zmake68kBank(DAC_8D_8E_Data)         ,zmake68kBank(DAC_8F_Data)
		db		zmake68kBank(DAC_90_91_92_93_Data)   ,zmake68kBank(DAC_90_91_92_93_Data)   ,zmake68kBank(DAC_90_91_92_93_Data)   ,zmake68kBank(DAC_90_91_92_93_Data)
		db		zmake68kBank(DAC_94_95_96_97_Data)   ,zmake68kBank(DAC_94_95_96_97_Data)   ,zmake68kBank(DAC_94_95_96_97_Data)   ,zmake68kBank(DAC_94_95_96_97_Data)
		db		zmake68kBank(DAC_98_99_9A_Data)      ,zmake68kBank(DAC_98_99_9A_Data)      ,zmake68kBank(DAC_98_99_9A_Data)      ,zmake68kBank(DAC_9B_Data)
		db		zmake68kBank(DAC_9C_Data)            ,zmake68kBank(DAC_9D_Data)            ,zmake68kBank(DAC_9E_Data)            ,zmake68kBank(DAC_9F_Data)
		db		zmake68kBank(DAC_A0_Data)            ,zmake68kBank(DAC_A1_Data)            ,zmake68kBank(DAC_A2_Data)            ,zmake68kBank(DAC_A3_Data)
		db		zmake68kBank(DAC_A4_Data)            ,zmake68kBank(DAC_A5_Data)            ,zmake68kBank(DAC_A6_Data)            ,zmake68kBank(DAC_A7_Data)
		db		zmake68kBank(DAC_A8_Data)            ,zmake68kBank(DAC_A9_Data)            ,zmake68kBank(DAC_AA_Data)            ,zmake68kBank(DAC_AB_Data)
		db		zmake68kBank(DAC_AC_Data)            ,zmake68kBank(DAC_AD_AE_Data)         ,zmake68kBank(DAC_AD_AE_Data)         ,zmake68kBank(DAC_AF_Data)
		db		zmake68kBank(DAC_AF_Data)            ,zmake68kBank(DAC_B1_Data)            ,zmake68kBank(DAC_B2_B3_Data)         ,zmake68kBank(DAC_B2_B3_Data)
		db		zmake68kBank(DAC_B4_C1_C2_C3_C4_Data),zmake68kBank(DAC_B5_Data)            ,zmake68kBank(DAC_B6_Data)            ,zmake68kBank(DAC_B7_Data)
		db		zmake68kBank(DAC_B8_B9_Data)         ,zmake68kBank(DAC_B8_B9_Data)         ,zmake68kBank(DAC_BA_Data)            ,zmake68kBank(DAC_BB_Data)
		db		zmake68kBank(DAC_BC_Data)            ,zmake68kBank(DAC_BD_Data)            ,zmake68kBank(DAC_BE_Data)            ,zmake68kBank(DAC_BF_Data)
		db		zmake68kBank(DAC_C0_Data)            ,zmake68kBank(DAC_B4_C1_C2_C3_C4_Data),zmake68kBank(DAC_B4_C1_C2_C3_C4_Data),zmake68kBank(DAC_B4_C1_C2_C3_C4_Data)
		db		zmake68kBank(DAC_B4_C1_C2_C3_C4_Data)

; =============== S U B	R O U T	I N E =======================================
;
;sub_11B
zUpdateEverything:
		call	zPauseUnpause				; Pause/unpause according to M68K input
		call	zUpdateSFXTracks			; Do SFX tracks

;loc_121
zUpdateMusic:
		call	TempoWait					; Delay song tracks as appropriate for main tempo mod
		call	zDoMusicFadeOut				; Check if music should be faded out and fade if needed
		call	zDoMusicFadeIn				; Check if music should be faded in and fade if needed
		ld	a, (zFadeToPrevFlag)			; Get fade-to-prev flag
		cp	mus_ExtraLife-mus__First			; Is it still 1-Up?
		jr	nz, .check_fade_in				; Branch if not
		ld	a, (zMusicNumber)				; Get next music to play
		cp	mus_ExtraLife						; Is it another 1-Up?
		jr	z, .clr_queue					; Branch if yes
		cp	mus__End-mus__First					; Is it music (except credits song)?
		jr	c, .clr_sfx						; Branch if not

.clr_queue:
		xor	a								; a = 0
		ld	(zMusicNumber), a				; Clear queue entry

.clr_sfx:
		xor	a								; a = 0
		ld	(zSFXNumber0), a				; Clear first queued SFX
		ld	(zSFXNumber1), a				; Clear second queued SFX
		jr	.update_music

;loc_149
.check_fade_in:
		ld	a, (zFadeToPrevFlag)			; Get fade-to-previous flag
		cp	0FFh							; Is it 0FFh?
		jr	z, .update_music				; Branch if yes
		ld	hl, zMusicNumber				; Point hl to M68K input
		ld	e, (hl)							; e = next song to play
		inc	hl								; Advance pointer
		ld	d, (hl)							; d = next SFX to play
		inc	hl								; Advance pointer
		ld	a, (hl)							; a = next SFX to play
		or	d								; Combine bits of a and d
		or	e								; Is anything in the play queue?
		jr	z, .update_music				; Branch if not
		call	zFillSoundQueue				; Transfer M68K input
		call	zCycleSoundQueue			; Cycle queue and play first entry
		call	zCycleSoundQueue			; Cycle queue and play second entry
		call	zCycleSoundQueue			; Cycle queue and play third entry

.update_music:
		ld	a, (zSongBank)					; Get bank ID for music
		bankswitch2							; Bank switch to it
		xor	a								; a = 0
		ld	(zUpdatingSFX), a				; Updating music
		ld	a, (zFadeToPrevFlag)			; Get fade-to-previous flag
		cp	0FFh							; Is it 0FFh?
		call	z, zFadeInToPrevious		; Fade to previous if yes
		ld	ix, zSongFM6_DAC				; ix = FM6/DAC track RAM
		bit	7, (ix+zTrack.PlaybackControl)	; Is FM6/DAC track playing?
		call	nz, zUpdateDACTrack			; Branch if yes
		ld	b, (zTracksEnd-zSongFM1)/zTrack.len	; Number of tracks
		ld	ix, zSongFM1					; ix = FM1 track RAM
		jr	zTrackUpdLoop					; Play all tracks

; =============== S U B	R O U T	I N E =======================================
;
;sub_19E
zUpdateSFXTracks:
		ld	a, 1							; a = 1
		ld	(zUpdatingSFX), a				; Updating SFX
		ld	a, zmake68kBank(SndBank)		; Get SFX bank ID
		bankswitch2							; Bank switch to SFX
		ld	ix, zTracksSFXStart				; ix = start of SFX track RAM
		ld	b, (zTracksSFXEnd-zTracksSFXStart)/zTrack.len	; Number of channels

zTrackUpdLoop:
		push	bc							; Save bc
		bit	7, (ix+zTrack.PlaybackControl)	; Is track playing?
		call	nz, zUpdateFMorPSGTrack		; Call routine if yes
		ld	de, zTrack.len					; Spacing between tracks
		add	ix, de							; Advance to next track
		pop	bc								; Restore bc
		djnz	zTrackUpdLoop				; Loop for all tracks

		ld	a, (zTempoSpeedup)				; Get tempo speed-up value
		or	a								; Is music sped up?
		ret	z								; Return if not
		ld	a, (zSpeedupTimeout)			; Get extra tempo timeout
		or	a								; Has it expired?
		jp	nz, .no_dbl_update				; Branch if not
		ld	a, (zTempoSpeedup)				; Get master tempo speed-up value
		ld	(zSpeedupTimeout), a			; Reset extra tempo timeout to it
		jp	zUpdateMusic					; Update music again
; ---------------------------------------------------------------------------
.no_dbl_update:
		dec	a								; Decrement timeout...
		ld	(zSpeedupTimeout), a			; ... then store new value
		ret
; End of function zUpdateSFXTracks


; =============== S U B	R O U T	I N E =======================================
; Updates FM or PSG track.
;
;sub_1E9
zUpdateFMorPSGTrack:
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG channel?
		jp	nz, zUpdatePSGTrack				; Branch if yes
	if fix_sndbugs
		dec	(ix+zTrack.DurationTimeout)		; Run note timer
	else
		call	zTrackRunTimer				; Run note timer
	endif
		jr	nz, .note_going					; Branch if note hasn't expired yet
		call	zGetNextNote				; Get next note for FM track
		bit	4, (ix+zTrack.PlaybackControl)	; Is track resting?
		ret	nz								; Return if yes
		call	zPrepareModulation			; Initialize modulation
		call	zUpdateFreq					; Add frequency displacement to frequency
		call	zDoModulation				; Apply modulation
		call	zFMSendFreq					; Send frequency to YM2612
		jp	zFMNoteOn						; Note on on all operators
; ---------------------------------------------------------------------------
.note_going:
		bit	4, (ix+zTrack.PlaybackControl)	; Is track resting?
		ret	nz								; Return if yes
		call	zDoFMVolEnv					; Do FM volume envelope effects for track
		ld	a, (ix+zTrack.NoteFillTimeout)	; Get note fill timeout
		or	a								; Is timeout either not running or expired?
		jr	z, .keep_going					; Branch if yes
		dec	(ix+zTrack.NoteFillTimeout)		; Update note fill timeout
		jp	z, zKeyOffIfActive				; Send key off if needed

.keep_going:
		call	zUpdateFreq					; Add frequency displacement to frequency
		bit	6, (ix+zTrack.PlaybackControl)	; Is 'sustain frequency' bit set?
		ret	nz								; Return if yes
		call	zDoModulation				; Apply modulation then fall through
		; Fall through to next function
; End of function zUpdateFMorPSGTrack


; =============== S U B	R O U T	I N E =======================================
; Uploads track's frequency to YM2612.
;
; Input:   ix    Pointer to track RAM
;          hl    Frequency to upload
;          de    For FM3 in special mode, pointer to extra FM3 frequency data (never correctly set)
; Output:  a     Trashed
;          bc    Trashed
;          hl    Trashed
;          de    Increased by 8
;
;sub_22B
zFMSendFreq:
		bit	2, (ix+zTrack.PlaybackControl)	; Is SFX overriding this track?
		ret	nz								; Return if yes
		bit	0, (ix+zTrack.PlaybackControl)	; Is track in special mode (FM3 only)?
		jp	nz, .special_mode				; Branch if yes

.not_fm3:
		ld	a, 0A4h							; Command to update frequency MSB
		ld	c, h							; High byte of frequency
		call	zWriteFMIorII				; Send it to YM2612
		ld	a, 0A0h							; Command to update frequency LSB
		ld	c, l							; Low byte of frequency
	if fix_sndbugs
		jp	zWriteFMIorII					; Send it to YM2612
	else
		call	zWriteFMIorII				; Send it to YM2612
		ret
	endif
; ---------------------------------------------------------------------------
.special_mode:
		ld	a, (ix+zTrack.VoiceControl)		; a = voice control byte
		cp	2								; Is this FM3?
		jr	nz, .not_fm3					; Branch if not
	if fix_sndbugs
		call	zGetSpecialFM3DataPointer	; de = pointer to saved FM3 frequency shifts
	endif
		ld	b, zSpecialFreqCommands_End-zSpecialFreqCommands	; Number of entries
		ld	hl, zSpecialFreqCommands		; Lookup table

		; DANGER! de is unset here, and could be pointing anywhere! Luckily,
		; only reads are performed from it.
.loop:
		push	bc							; Save bc
		ld	a, (hl)							; a = register selector
		inc	hl								; Advance pointer
		push	hl							; Save hl
		ex	de, hl							; Exchange de and hl
		ld	c, (hl)							; Get byte from whatever the hell de was pointing to
		inc	hl								; Advance pointer
		ld	b, (hl)							; Get byte from whatever the hell de was pointing to
		inc	hl								; Advance pointer
		ex	de, hl							; Exchange de and hl
		ld	l, (ix+zTrack.FreqLow)			; l = low byte of track frequency
		ld	h, (ix+zTrack.FreqHigh)			; h = high byte of track frequency
		add	hl, bc							; hl = full frequency for operator
		push	af							; Save af
		ld	c, h							; High byte of frequency
		call	zWriteFMI					; Sent it to YM2612
		pop	af								; Restore af
		sub	4								; Move on to frequency LSB
		ld	c, l							; Low byte of frequency
		call	zWriteFMI					; Sent it to YM2612
		pop	hl								; Restore hl
		pop	bc								; Restore bc
		djnz	.loop						; Loop for all operators
		ret
; End of function zFMSendFreq

; ---------------------------------------------------------------------------
;loc_272
zSpecialFreqCommands:
		db 0ADh								; Operator 4 frequency MSB
		db 0AEh								; Operator 3 frequency MSB
		db 0ACh								; Operator 2 frequency MSB
		db 0A6h								; Operator 1 frequency MSB
zSpecialFreqCommands_End

; =============== S U B	R O U T	I N E =======================================
;
zGetSpecialFM3DataPointer:
	if fix_sndbugs
		ld	de, zSpecFM3Freqs				; de = pointer to saved FM3 frequency shifts
		ld	a, (zUpdatingSFX)				; Get flag
		or	a								; Is this a SFX track?
		ret	z								; Return if not
		ld	de, zSpecFM3FreqsSFX				; de = pointer to saved FM3 frequency shifts
	endif
		ret
; End of function zGetSpecialFM3DataPointer


; =============== S U B	R O U T	I N E =======================================
; Gets next note from the track's data stream. If any coordination flags are
; found, they are handled and then the function keeps looping until a note is
; found.
;
; Input:   ix    Pointer to track's RAM
; Output:  de    Pointer to current position on track data
;          hl    Note frequency
;          All others possibly trashed due to coordination flags
;
;sub_277
zGetNextNote:
		ld	e, (ix+zTrack.DataPointerLow)	; e = low byte of track data pointer
		ld	d, (ix+zTrack.DataPointerHigh)	; d = high byte of track data pointer
		res	1, (ix+zTrack.PlaybackControl)	; Clear 'do not attack next note' flag
		res	4, (ix+zTrack.PlaybackControl)	; Clear 'track is at rest' flag

;loc_285
zGetNextNote_cont:
		ld	a, (de)							; Get next byte from track
		inc	de								; Advance pointer
		cp	FirstCoordFlag					; Is it a coordination flag?
		jp	nc, zHandleFMorPSGCoordFlag		; Branch if yes
		ex	af, af'							; Save af
		call	zKeyOffIfActive				; Kill note
		ex	af, af'							; Restore af
		bit	3, (ix+zTrack.PlaybackControl)	; Is alternate frequency mode flag set?
		jp	nz, zAltFreqMode				; Branch if yes
		or	a								; Is this a duration?
		jp	p, zStoreDuration				; Branch if yes
		sub	81h								; Make the note into a 0-based index
		jp	p, .got_note					; Branch if it is a note and not a rest
		call	zRestTrack					; Put track at rest
		jr	zGetNoteDuration
; ---------------------------------------------------------------------------
.got_note:
		add	a, (ix+zTrack.Transpose)		; Add in transposition
		ld	hl, zPSGFrequencies				; PSG frequency lookup table
		push	af							; Save af
		rst	PointerTableOffset				; hl = frequency value for note
		pop	af								; Restore af
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG track?
		jr	nz, zGotNoteFreq				; Branch if yes
		push	de							; Save de
		ld	d, 8							; Each octave above the first adds this to frequency high bits
		ld	e, 0Ch							; 12 notes per octave
		ex	af, af'							; Exchange af with af'
		xor	a								; Clear a (which will clear a')

.loop:
		ex	af, af'							; Exchange af with af'
		sub	e								; Subtract 1 octave from the note
		jr	c, .got_displacement			; If this is less than zero, we are done
		ex	af, af'							; Exchange af with af'
		add	a, d							; One octave up
		jr	.loop							; Loop
; ---------------------------------------------------------------------------
	if fix_sndbugs=0
		ex	af, af'							; Exchange af with af' (dead code)
	endif
; ---------------------------------------------------------------------------
.got_displacement:
		add	a, e							; Add 1 octave back (so note index is positive)
		ld	hl, zFMFrequencies				; FM first octave frequency lookup table
		rst	PointerTableOffset				; hl = frequency of the note on the first octave
		ex	af, af'							; Exchange af with af'
		or	h								; a = high bits of frequency (including octave bits, which were in a)
		ld	h, a							; h = high bits of frequency (including octave bits)
		pop	de								; Restore de

;loc_2CE
zGotNoteFreq:
		ld	(ix+zTrack.FreqLow), l			; Store low byte of note frequency
		ld	(ix+zTrack.FreqHigh), h			; Store high byte of note frequency

;loc_2D4
zGetNoteDuration:
		ld	a, (de)							; Get duration from the track
		or	a								; Is it an actual duration?
		jp	p, zGotNoteDuration				; Branch if yes
	if fix_sndbugs=0
		ld	a, (ix+zTrack.SavedDuration)	; Get saved duration (zFinishTrackUpdate should do it...)
		ld	(ix+zTrack.DurationTimeout), a	; Set it as next timeout duration (zFinishTrackUpdate should do it...)
	endif
		jr	zFinishTrackUpdate
; ---------------------------------------------------------------------------
zApplyPitchSlide:
	if fix_sndbugs=0
		; Unused/dead code in S3/S&K/S3D; this is code for pitch slides
		; in the Battletoads sound driver.
		ld	a, (de)							; Get new pitch slide value from track
		inc	de								; Advance pointer
		ld	(ix+zTrack.Unk11h), a			; Store pitch slide
		jr	zGetRawDuration
	endif
; ---------------------------------------------------------------------------
;loc_2E8
;zAlternateSMPS
zAltFreqMode:
		; Setting bit 3 on zTrack.PlaybackControl puts the song in a weird mode.
		;
		; This weird mode has literal frequencies and durations on the track.
		; Each byte on the track is either a coordination flag (0E0h to 0FFh) or
		; the high byte of a frequency. For the latter case, the following byte
		; is then the low byte of this same frequency.
		; If the frequency is nonzero, the (sign extended) key displacement is
		; simply *added* to this frequency.
		; After the frequency, there is then a byte that is unused.
		; Finally, there is a raw duration byte following.
		;
		; To put the track in this mode, coord. flag 0FDh can be used; if the
		; parameter byte is 1, the mode is toggled on. To turn the mode off,
		; coord. flag 0FDh can be used with a parameter != 1.
		ld	h, a							; h = byte from track
		ld	a, (de)							; a = next byte from track
		inc	de								; Advance pointer
		ld	l, a							; l = last byte read from track
		or	h								; Is hl nonzero?
		jr	z, .got_zero					; Branch if not
		ld	a, (ix+zTrack.Transpose)		; a = transposition
	if fix_sndbugs
		ld	c, a							; bc = sign extension of key displacement
		rla									; Carry contains sign of key displacement
		sbc	a, a							; a = 0 or -1 if carry is 0 or 1
		ld	b, a							; bc = sign extension of key displacement
	else
		ld	b, 0							; b = 0
		or	a								; Is a negative?
		jp	p, .did_sign_extend				; Branch if not
		dec	b								; Set b to -1

.did_sign_extend:
		ld	c, a							; bc = sign extension of key displacement
	endif
		add	hl, bc							; hl += key displacement

.got_zero:
		ld	(ix+zTrack.FreqLow), l			; Store low byte of note frequency
		ld	(ix+zTrack.FreqHigh), h			; Store high byte of note frequency
	if fix_sndbugs
		inc	de								; Skip the useless pitch slide byte
	else
		ld	a, (de)							; Get pitch slide value from the track
		inc	de								; Advance to next byte in track
		ld	(ix+zTrack.Unk11h), a			; Store pitch slide
	endif
;loc_306
zGetRawDuration:
		ld	a, (de)							; Get raw duration from track

;loc_307
zGotNoteDuration:
		inc	de								; Advance to next byte in track

;loc_308
zStoreDuration:
		call	zComputeNoteDuration		; Multiply note by tempo divider
		ld	(ix+zTrack.SavedDuration), a	; Store it for next note

;loc_30E
zFinishTrackUpdate:
		ld	(ix+zTrack.DataPointerLow), e	; Save low byte of current location in song
		ld	(ix+zTrack.DataPointerHigh), d	; Save high byte of current location in song
		ld	a, (ix+zTrack.SavedDuration)	; Get current saved duration
		ld	(ix+zTrack.DurationTimeout), a	; Set it as duration timeout
		bit	1, (ix+zTrack.PlaybackControl)	; Is 'do not attack next note' flag set?
		ret	nz								; Return if yes
		xor	a								; Clear a
		ld	(ix+zTrack.ModEnvIndex), a		; Clear modulation envelope index
		ld	(ix+zTrack.ModEnvSens), a		; Clear modulation envelope multiplier
		ld	(ix+zTrack.VolEnv), a			; Reset volume envelope
		ld	a, (ix+zTrack.NoteFillMaster)	; Get master note fill
		ld	(ix+zTrack.NoteFillTimeout), a	; Set note fill timeout
		ret
; End of function zGetNextNote


; =============== S U B	R O U T	I N E =======================================
; This routine multiplies the note duration by the tempo divider. This can
; easily overflow, as the result is stored in a byte.
;
; Input:   a    Note duration
; Output:  a    Final note duration
;          b    zero
;          c    Damaged
;sub_330
zComputeNoteDuration:
		ld	b, (ix+zTrack.TempoDivider)		; Get tempo divider for this track
		dec	b								; Make it into a loop counter
		ret	z								; Return if it was 1
		ld	c, a							; c = a

.loop:
		add	a, c							; a += c
		djnz	.loop						; Loop
		ret
; End of function zComputeNoteDuration


; =============== S U B	R O U T	I N E =======================================
; Reduces note duration timeout for current track.
;
; Input:   ix   Track data
; Output:  a    New duration
;sub_33A
	if fix_sndbugs=0
zTrackRunTimer:
		ld	a, (ix+zTrack.DurationTimeout)	; Get track duration timeout
		dec	a								; Decrement it...
		ld	(ix+zTrack.DurationTimeout), a	; ... and save new value
		ret
; End of function zTrackRunTimer
	endif

; ---------------------------------------------------------------------------
;loc_342
zFMNoteOn:
		ld	a, (ix+zTrack.FreqLow)			; Get low byte of note frequency
		or	(ix+zTrack.FreqHigh)			; Is the note frequency zero?
		ret	z								; Return if yes
		ld	a, (ix+zTrack.PlaybackControl)	; Get playback control byte for track
	if fix_sndbugs
		and	16h								; Is either bit 4 ("track at rest") or 2 ("SFX overriding this track") or bit 1 ("do not attack next note") set?
	else
		and	6								; Is either bit 1 ("do not attack next note") or 2 ("SFX overriding this track") set?
	endif
		ret	nz								; Return if yes
		ld	a, (ix+zTrack.VoiceControl)		; Get voice control byte from track
		or	0F0h							; We want only the FM channel assignment bits
		ld	c, a							; Key on for all operators
		ld	a, 28h							; Select key on/of register
	if fix_sndbugs
		jp	zWriteFMI						; Send command to YM2612
	else
		call	zWriteFMI					; Send command to YM2612
		ret
	endif
; ---------------------------------------------------------------------------

; =============== S U B	R O U T	I N E =======================================
; Writes reg/data pair to register 28h (key on/off) if track active
;
; Input:   ix   Track data
; Output:  a    Damaged
;          c    Damaged
;sub_35B
zKeyOffIfActive:
		ld	a, (ix+zTrack.PlaybackControl)	; Get playback control byte for track
		and	6								; Is either bit 1 ("do not attack next note") or 2 ("SFX overriding this track") set?
		ret	nz								; Return if yes
; End of function zKeyOffIfActive

; =============== S U B	R O U T	I N E =======================================
; Writes reg/data pair to register 28h (key on/off)
;
; Input:   ix   Track data
; Output:  a    Damaged
;          c    Damaged
;loc_361
zKeyOff:
		ld	c, (ix+zTrack.VoiceControl)		; Get voice control byte for track (this will turn off all operators as high nibble = 0)
		bit	7, c							; Is this a PSG track?
		ret	nz								; Return if yes
; End of function zKeyOff

; =============== S U B	R O U T	I N E =======================================
; Writes reg/data pair to register 28h (key on/off)
;
; Input:   c    Data to write
; Output:  a    Damaged
;loc_367
zKeyOnOff:
		ld	a, 28h							; Write to KEY ON/OFF port
	if fix_sndbugs
		res	6, (ix+zTrack.PlaybackControl)	; From Dyna Brothers 2, but in a better place; clear flag to sustain frequency
		jp	zWriteFMI						; Send it
	else
		call	zWriteFMI					; Send it
		ret
	endif
; End of function zKeyOnOff

; =============== S U B	R O U T	I N E =======================================
; Performs volume envelope effects in FM channels.
;
; Input:   ix    Pointer to track RAM
; Output:  a     Trashed
;          bc    Trashed
;          de    Trashed
;          hl    Trashed
;
;sub_36D
;zDoFMFlutter
zDoFMVolEnv:
		ld	a, (ix+zTrack.FMVolEnv)			; Get FM volume envelope
		or	a								; Is it zero?
		ret	z								; Return if yes
		ret	m								; Return if it is actually the custom SSG-EG flag
		dec	a								; Make a into an index
		ld	c, zID_VolEnvPointers			; Value for volume envelope pointer table
		rst	GetPointerTable					; hl = pointer to volume envelope table
		rst	PointerTableOffset				; hl = pointer to volume envelope for track
		call	zDoVolEnv					; a = new volume envelope
		ld	h, (ix+zTrack.TLPtrHigh)			; h = high byte to TL data pointer
		ld	l, (ix+zTrack.TLPtrLow)			; l = low byte to TL data pointer
		ld	de, zFMInstrumentTLTable		; de = pointer to FM TL register table
		ld	b, zFMInstrumentTLTable_End-zFMInstrumentTLTable	; Number of entries
		ld	c, (ix+zTrack.FMVolEnvMask)		; c = envelope bitmask

.loop:
		push	af							; Save af
		sra	c								; Divide c by 2
		push	bc							; Save bc
		jr	nc, .skip_reg					; Branch if c bit shifted was zero
		add	a, (hl)							; Add TL value to volume envelope
	if fix_sndbugs=0
		; This isn't actually needed
		and	7Fh								; Strip sign bit
	endif
		ld	c, a							; c = TL + volume envelope
		ld	a, (de)							; a = YM2612 register
		call	zWriteFMIorII				; Send TL data to YM2612

.skip_reg:
		pop	bc								; Restore bc
		inc	de								; Advance to next YM2612 register
		inc	hl								; Advance to next TL value
		pop	af								; Restore af
		djnz	.loop						; Loop for all registers
		ret
; End of function zDoFMVolEnv

; =============== S U B	R O U T	I N E =======================================
; Initializes normal modulation.
;
; Input:   ix    Pointer to track's RAM
; Output:  de    If modulation control has bit 7 set and track is to attack next note, pointer to modulation steps in track RAM
;          hl    If modulation control has bit 7 set and track is to attack next note, pointer to modulation steps in track data
;
;sub_39E
zPrepareModulation:
		bit	7, (ix+zTrack.ModulationCtrl)	; Is modulation on?
		ret	z								; Return if not
		bit	1, (ix+zTrack.PlaybackControl)	; Is 'do not attack next note' bit set?
		ret	nz								; Return if yes
		ld	e, (ix+zTrack.ModulationPtrLow)	; e = low byte of pointer to modulation data
		ld	d, (ix+zTrack.ModulationPtrHigh)	; d = high byte of pointer to modulation data
		push	ix							; Save ix
		pop	hl								; hl = pointer to track data
		ld	b, 0							; b = 0
		ld	c, zTrack.ModulationWait		; c = offset in track RAM for modulation data
		add	hl, bc							; hl = pointer to modulation data in track RAM
		ex	de, hl							; Exchange de and hl
		ldi									; *de++ = *hl++
		ldi									; *de++ = *hl++
		ldi									; *de++ = *hl++
		ld	a, (hl)							; a = number of modulation steps
		srl	a								; Divide by 2
		ld	(de), a							; Store in track RAM
		xor	a								; a = 0
		ld	(ix+zTrack.ModulationValLow), a	; Clear low byte of accumulated modulation
		ld	(ix+zTrack.ModulationValHigh), a	; Clear high byte of accumulated modulation
		ret
; End of function zPrepareModulation


; =============== S U B	R O U T	I N E =======================================
; Applies modulation.
;
; Input:   ix    Pointer to track's RAM
;          hl    Note frequency
; Output:
;    If modulation control is 80h (normal modulation):
;          hl    Final note frequency
;          de    Pointer to modulation data in track RAM
;          iy    Pointer to modulation data in track RAM
;          bc    Unmodulated note frequency
;
;    If modulation control is nonzero and not 80h (modulation envelope effects):
;
;
;sub_3C9
zDoModulation:
		ld	a, (ix+zTrack.ModulationCtrl)	; Get modulation control byte
		or	a								; Is modulation active?
		ret	z								; Return if not
		cp	80h								; Is modulation control 80h?
		jr	nz, zDoModEnvelope				; Branch if not
		dec	(ix+zTrack.ModulationWait)		; Decrement modulation wait
		ret	nz								; Return if nonzero
		inc	(ix+zTrack.ModulationWait)		; Increase it back to 1 for next frame
		push	hl							; Save hl
		ld	l, (ix+zTrack.ModulationValLow)	; l = low byte of accumulated modulation
		ld	h, (ix+zTrack.ModulationValHigh)	; h = high byte of accumulated modulation
		; In non-Type 2 DAC versions of SMPS Z80, the following four instructions were below the 'jr nz'
		; which could lead to a bug where iy isn't initialised, but still used as a pointer.
		ld	e, (ix+zTrack.ModulationPtrLow)	; e = low byte of modulation data pointer
		ld	d, (ix+zTrack.ModulationPtrHigh)	; d = high byte of modulation data pointer
		push	de							; Save de
		pop	iy								; iy = pointer to modulation data
		dec	(ix+zTrack.ModulationSpeed)		; Decrement modulation speed
		jr	nz, .mod_sustain				; Branch if nonzero
		ld	a, (iy+1)						; Get original modulation speed
		ld	(ix+zTrack.ModulationSpeed), a	; Reset modulation speed timeout
		ld	a, (ix+zTrack.ModulationDelta)	; Get modulation delta per step
		ld	c, a							; c = modulation delta per step
	if fix_sndbugs
		rla									; Carry contains sign of delta
		sbc	a, a							; a = 0 or -1 if carry is 0 or 1
	else
		and	80h								; Get only sign bit
		rlca								; Shift it into bit 0
		neg									; Negate (so it is either 0 or -1)
	endif
		ld	b, a							; bc = sign extension of delta
		add	hl, bc							; hl += bc
		ld	(ix+zTrack.ModulationValLow), l	; Store low byte of accumulated modulation
		ld	(ix+zTrack.ModulationValHigh), h	; Store high byte of accumulated modulation

.mod_sustain:
		pop	bc								; bc = note frequency
		add	hl, bc							; hl = modulated note frequency
		dec	(ix+zTrack.ModulationSteps)		; Reduce number of modulation steps
		ret	nz								; Return if nonzero
		ld	a, (iy+3)						; Get number of steps from track data
		ld	(ix+zTrack.ModulationSteps), a	; Reset modulation steps in track RAM
		ld	a, (ix+zTrack.ModulationDelta)	; Load modulation delta
		neg									; Change its sign
		ld	(ix+zTrack.ModulationDelta), a	; Store it back
		ret
; ---------------------------------------------------------------------------
;loc_41A
;zDoFrequencyFlutter
zDoModEnvelope:
		dec	a								; Convert into pointer table index
		ex	de, hl							; Exchange de and hl; de = note frequency
		ld	c, zID_ModEnvPointers			; Value for modulation envelope pointer table
		rst	GetPointerTable					; hl = pointer to modulation envelope pointer table
		rst	PointerTableOffset				; hl = modulation envelope pointer for modulation control byte
		jr	zDoModEnvelope_cont
; ---------------------------------------------------------------------------
;zFreqFlutterSetIndex
zModEnvSetIndex:
		ld	(ix+zTrack.ModEnvIndex), a		; Set new modulation envelope index

;loc_425
;zDoFrequencyFlutter_cont
zDoModEnvelope_cont:
		push	hl							; Save hl
		ld	c, (ix+zTrack.ModEnvIndex)		; c = modulation envelope index
		ld	b, 0							; b = 0
		add	hl, bc							; Offset into modulation envelope table
	if fix_sndbugs
		; Fix based on similar code from Space Harrier II's sound driver.
		; This fixes both "DANGER!" bugs below. This is better than the
		; previous fix, which was based on Ristar's driver.
		ld	c, l
		ld	b, h
		ld	a, (bc)							; a = new modulation envelope value
	else
		ld	a, (hl)							; a = new modulation envelope value
	endif
		pop	hl								; Restore hl
		bit	7, a							; Is modulation envelope negative?
		jp	z, zlocPositiveModEnvMod		; Branch if not
		cp	82h								; Is it 82h?
		jr	z, zlocChangeModEnvIndex		; Branch if yes
		cp	80h								; Is it 80h?
		jr	z, zlocResetModEnvMod			; Branch if yes
		cp	84h								; Is it 84h?
		jr	z, zlocModEnvIncMultiplier		; Branch if yes
		ld	h, 0FFh							; h = 0FFh
		jr	nc, zlocApplyModEnvMod			; Branch if more than 84h
		set	6, (ix+zTrack.PlaybackControl)	; Set 'sustain frequency' bit
		pop	hl								; Tamper with return location so as to not return to caller
		ret
; ---------------------------------------------------------------------------
;loc_449
;zlocChangeFlutterIndex
zlocChangeModEnvIndex:
		inc	bc								; Increment bc
		; DANGER! Uses bc as a pointer, getting bytes from code region.
		; This happens for several frequency flutters, so you should avoid them
		; unless you enable the driver bug fixes.
		ld	a, (bc)							; Use it as a pointer??? Getting bytes from code region?
		jr	zModEnvSetIndex					; Set position to nonsensical value
; ---------------------------------------------------------------------------
;loc_44D
;zlocResetFlutterMod
zlocResetModEnvMod:
		xor	a								; a = 0
		jr	zModEnvSetIndex					; Reset position for modulation envelope
; ---------------------------------------------------------------------------
;loc_450
;zlocFlutterIncMultiplier
zlocModEnvIncMultiplier:
		inc	bc								; Increment bc
		; DANGER! Uses bc as a pointer, getting bytes from code region.
		; Luckily, this does not happen for any of the existing frequency
		; flutters.
		ld	a, (bc)							; Use it as a pointer??? Getting bytes from code region?
		add	a, (ix+zTrack.ModEnvSens)		; Add envelope sensibility to a...
		ld	(ix+zTrack.ModEnvSens), a		; ... then store new value
		inc	(ix+zTrack.ModEnvIndex)			; Advance envelope modulation...
		inc	(ix+zTrack.ModEnvIndex)			; ... twice.
		jr	zDoModEnvelope_cont
; ---------------------------------------------------------------------------
;loc_460
;zlocPositiveFlutterMod
zlocPositiveModEnvMod:
		ld	h, 0							; h = 0

;loc_462
;zlocApplyFlutterMod
zlocApplyModEnvMod:
		ld	l, a							; hl = sign extension of modulation value
		ld	b, (ix+zTrack.ModEnvSens)		; Fetch envelope sensibility
		inc	b								; Increment it (minimum 1)
		ex	de, hl							; Swap hl and de; hl = note frequency

.loop:
		add	hl, de							; hl += de
		djnz	.loop						; Make hl = note frequency + b * de
		inc	(ix+zTrack.ModEnvIndex)			; Advance modulation envelope
		ret
; End of function zDoModulation

; =============== S U B	R O U T	I N E =======================================
; Adds the current frequency displacement (signed) to note frequency.
;
; Input:   ix    Track RAM
; Output:  hl    Shifted frequency
;          a     Damaged
;          bc    Damaged
;
;sub_46F
;zDoPitchSlide
zUpdateFreq:
		ld	h, (ix+zTrack.FreqHigh)			; h = high byte of note frequency
		ld	l, (ix+zTrack.FreqLow)			; l = low byte of note frequency
	if fix_sndbugs
		ld	a, (ix+zTrack.Detune)			; a = detune
		ld	c, a							; bc = sign extension of frequency displacement
		rla									; Carry contains sign of frequency displacement
		sbc	a, a							; a = 0 or -1 if carry is 0 or 1
		ld	b, a							; bc = sign extension of frequency displacement
	else
		ld	b, 0							; b = 0
		ld	a, (ix+zTrack.Detune)			; a = detune
		or	a								; Is a negative?
		jp	p, .did_sign_extend				; Branch if not
		ld	b, 0FFh							; b = -1

.did_sign_extend:
		ld	c, a							; bc = sign extension of frequency displacement
	endif
		add	hl, bc							; Add to frequency
		ret
; End of function zUpdateFreq

; =============== S U B	R O U T	I N E =======================================
; Gets offset for requested FM instrument.
;
;sub_483
zGetFMInstrumentPointer:
		ld	hl, (zVoiceTblPtr)				; hl = pointer to voice table
		ld	a, (zUpdatingSFX)				; Get flag
		or	a								; Is this a SFX track?
		jr	z, zGetFMInstrumentOffset		; Branch if not
		ld	l, (ix+zTrack.VoicesLow)		; l = low byte of track's voice pointer
		ld	h, (ix+zTrack.VoicesHigh)		; h = high byte of track's voice pointer

;loc_492
zGetFMInstrumentOffset:
		xor	a								; a = 0
		or	b								; Is FM instrument the first one (zero)?
		ret	z								; Return if so
		ld	de, 25							; Size of each FM instrument

.loop:
		add	hl, de							; Advance pointer to next instrument
		djnz	.loop						; Loop until instrument offset is found
		ret
; End of function zGetFMInstrumentPointer

; ---------------------------------------------------------------------------
;loc_49C
zFMInstrumentRegTable:
		db 0B0h								; Feedback/Algorithm
zFMInstrumentOperatorTable:
		db  30h								; Detune/multiple operator 1
		db  38h								; Detune/multiple operator 3
		db  34h								; Detune/multiple operator 2
		db  3Ch								; Detune/multiple operator 4
zFMInstrumentRSARTable:
		db  50h								; Rate scaling/attack rate operator 1
		db  58h								; Rate scaling/attack rate operator 3
		db  54h								; Rate scaling/attack rate operator 2
		db  5Ch								; Rate scaling/attack rate operator 4
zFMInstrumentAMD1RTable:
		db  60h								; Amplitude modulation/first decay rate operator 1
		db  68h								; Amplitude modulation/first decay rate operator 3
		db  64h								; Amplitude modulation/first decay rate operator 2
		db  6Ch								; Amplitude modulation/first decay rate operator 4
zFMInstrumentD2RTable:
		db  70h								; Secondary decay rate operator 1
		db  78h								; Secondary decay rate operator 3
		db  74h								; Secondary decay rate operator 2
		db  7Ch								; Secondary decay rate operator 4
zFMInstrumentD1LRRTable:
		db  80h								; Secondary amplitude/release rate operator 1
		db  88h								; Secondary amplitude/release rate operator 3
		db  84h								; Secondary amplitude/release rate operator 2
		db  8Ch								; Secondary amplitude/release rate operator 4
zFMInstrumentOperatorTable_End
;loc_4B1
zFMInstrumentTLTable:
		db  40h								; Total level operator 1
		db  48h								; Total level operator 3
		db  44h								; Total level operator 2
		db  4Ch								; Total level operator 4
zFMInstrumentTLTable_End
;loc_4B5
zFMInstrumentSSGEGTable:
		db  90h								; SSG-EG operator 1
		db  98h								; SSG-EG operator 3
		db  94h								; SSG-EG operator 2
		db  9Ch								; SSG-EG operator 4
zFMInstrumentSSGEGTable_End

; =============== S U B	R O U T	I N E =======================================
; Subroutine to send FM instrument data to YM2612 chip.
;
;sub_4B9
zSendFMInstrument:
		ld	de, zFMInstrumentRegTable		; de = pointer to register output table
		ld	c, (ix+zTrack.AMSFMSPan)		; Send track AMS/FMS/panning
		ld	a, 0B4h							; Select AMS/FMS/panning register
		call	zWriteFMIorII				; Set track data
		call	zSendFMInstrData			; Send data to register
		ld	(ix+zTrack.FeedbackAlgo), a		; Save current feedback/algorithm

	if fix_sndbugs
		; Start with detune/multiplier operators
		ld	b, zFMInstrumentRSARTable-zFMInstrumentOperatorTable	; Number of commands to issue

.loop1:
		call	zSendFMInstrData			; Send FM instrument data
		djnz	.loop1						; Loop

		; Now for rate scaling/attack rate. The attack rate must be 1Fh if using
		; SSG-EG, which is the reason for the split.
		ld	b, zFMInstrumentAMD1RTable-zFMInstrumentRSARTable	; Number of commands to issue

.loop2:
		call	zSendFMInstrDataRSAR		; Send FM instrument data
		djnz	.loop2						; Loop

		; Finalize with all the other operators.
		ld	b, zFMInstrumentOperatorTable_End-zFMInstrumentAMD1RTable	; Number of commands to issue

.loop3:
		call	zSendFMInstrData			; Send FM instrument data
		djnz	.loop3						; Loop
	else
		; DANGER! The following code ignores the fact that SSG-EG mode must be
		; used with maximum (1Fh) attack rate or output is officially undefined.
		; Setting voices with SSG-EG enabled then has the potential effect of
		; weird sound, even in real hardware.

		ld	b, zFMInstrumentOperatorTable_End-zFMInstrumentOperatorTable	; Number of commands to issue

.loop:
		call	zSendFMInstrData			; Send FM instrument data
		djnz	.loop							; Loop
	endif
		ld	(ix+zTrack.TLPtrLow), l			; Save low byte of pointer to (not yet uploaded) TL data
		ld	(ix+zTrack.TLPtrHigh), h		; Save high byte of pointer to (not yet uploaded) TL data
		jp	zSendTL							; Send TL data
; End of function zSendFMInstrument

; =============== S U B	R O U T	I N E =======================================
; Sends FM instrument data to YM2612.
;
; Input:   ix    Track data
;          hl    Pointer to instrument data
;          de    Pointer to register selector table
; Output:   a    Value written to the register
;           c    Value written to the register
;
;sub_4DA
zSendFMInstrData:
		ld	a, (de)							; Get register output
		inc	de								; Advance pointer
		ld	c, (hl)							; Get value from instrument RAM
		inc	hl								; Advance pointer
	if fix_sndbugs
		jp	zWriteFMIorII					; Write track data
	else
		call	zWriteFMIorII				; Write track data
		ret
	endif
; End of function zSendFMInstrData

	if fix_sndbugs
zSendFMInstrDataRSAR:
		ld	a, (ix+zTrack.HaveSSGEGFlag)	; Get custom SSG-EG flag
		or	a								; Does track have custom SSG-EG data?
		jp	p, zSendFMInstrData				; Branch if not
		ld	a, (hl)							; Get value from instrument RAM
		inc	hl								; Advance pointer
		or 1Fh								; Set AR to maximum
		ld	c, a							; c = RS/AR for operator
		ld	a, (de)							; Get register output
		inc	de								; Advance pointer
		jp	zWriteFMIorII					; Write track data
	endif

; =============== S U B	R O U T	I N E =======================================
; Rotates sound queue and clears last entry. Then plays the popped sound from
; the queue.
;loc_4E2
zCycleSoundQueue:
		ld	a, (zSoundQueue0)				; Get first item in sound queue
		ld	(zNextSound), a					; Save into next sound variable
		ld	a, (zSoundQueue1)				; Get second item in queue
		ld	(zSoundQueue0), a				; Move to first spot
		ld	a, (zSoundQueue2)				; Get third item in queue
		ld	(zSoundQueue1), a				; Move to second spot
		xor	a								; a = 0
		ld	(zSoundQueue2), a				; Clear third spot in queue
		ld	a, (zNextSound)					; a = next sound to play
; End of function zCycleSoundQueue

; ===========================================================================
; Type Check
; ===========================================================================
; 1-32, DC = Music
; 33-DB, DD-DF = SFX
; E1-E6 = Fade Effects
; FF = SEGA Scream

; TypeCheck:
;sub_4FB
zPlaySoundByIndex:
		cp	mus_CreditsK					; Is this the credits music?
		jp	z, zPlayMusicCredits			; Branch if yes
		cp	mus_SEGA						; Is this the SEGA sound?
		jp	z, zPlaySegaSound				; Branch if yes
		cp	mus__End						; Is this a music?
		jp	c, zPlayMusic					; Branch if yes
		cp	sfx__End						; Is this a sound effect?
		jp	c, zPlaySound_CheckRing			; Branch if yes
		cp	mus__FirstCmd					; Is it before the first fade effect?
		jp	c, zStopAllSound					; Branch if yes
		cp	mus__EndCmd						; Is this after the last fade effect?
		jp	nc, zStopAllSound					; Branch if yes
		sub	mus__FirstCmd					; If none of the checks passed, do fade effects.
		ld	hl, zFadeEffects				; hl = switch table pointer
		rst	PointerTableOffset				; Get address of function that handles the fade effect
	if fix_sndbugs=0
		xor	a								; Set a = 0
		ld	(unk_1C18), a					; Set otherwise unused value to zero
	endif
		jp	(hl)							; Handle fade effect
; End of function zPlaySoundByIndex
; ---------------------------------------------------------------------------
;loc_524
zFadeEffects:
		dw	zFadeOutMusic					; E1h
		dw	zStopAllSound						; E2h
		dw	zPSGSilenceAll					; E3h
		dw	zStopSFX						; E4h
		dw	zFadeOutMusic					; E5h
; ---------------------------------------------------------------------------
;sub_52E
zStopSFX:
		ld	ix, zTracksSFXStart				; ix = pointer to SFX track memory
		ld	b, (zTracksSFXEnd-zTracksSFXStart)/zTrack.len	; Number of channels
		ld	a, 1							; a = 1
		ld	(zUpdatingSFX), a				; Set flag to update SFX

.loop:
		push	bc							; Save bc
		bit	7, (ix+zTrack.PlaybackControl)	; Is track playing?
		call	nz, zSilenceStopTrack		; Branch if yes
		ld	de, zTrack.len					; Spacing between tracks
		add	ix, de							; ix = pointer to next track
		pop	bc								; Restore bc
		djnz	.loop						; Loop for each track
	if fix_sndbugs
		jp	zClearNextSound
	else
		call	zClearNextSound
		ret
	endif

; =============== S U B	R O U T	I N E =======================================
; Writes hl to stack twice and stops track, silencing it. The two hl pushes
; will be counteracted by cfSilenceStopTrack.
;
;sub_54D
zSilenceStopTrack:
		push	hl							; Save hl...
		push	hl							; ... twice
		jp	cfSilenceStopTrack				; Silence FM channel and stop track
; End of function zSilenceStopTrack
; ---------------------------------------------------------------------------

;loc_552
zPlayMusicCredits:
		ld	a, 32h							; Credits music is the last entry on the music table
		push	af							; Save af
		jp	zPlayMusic_DoFade				; Continue as music
; ---------------------------------------------------------------------------

;loc_558
zPlayMusic:
		sub	mus__First								; Remap index from 1h-32h to 0h-31h (see also credits music, above)
		ret	m								; Return if negative (id = 0)
		push	af							; Save af
		cp	mus_ExtraLife-mus__First						; Is it the 1-up music?
		jp	nz, zPlayMusic_DoFade			; Branch if not
		ld	a, (zFadeInTimeout)				; Fading timeout
		or	a								; Is music being faded?
		jp	z, .no_fade						; Branch if not
		xor	a								; a = 0
		ld	(zMusicNumber), a				; Clear M68K input queue...
		ld	(zSFXNumber0), a				; ... including SFX slot 0...
		ld	(zSFXNumber1), a				; ... and SFX slot 1
		ld	(zSoundQueue0), a				; Also clear music queue entry 0...
		ld	(zSoundQueue1), a				; ... and entry 1...
		ld	(zSoundQueue2), a				; ... and entry 2
		ld	(zNextSound), a					; Clear currently selected song to play
		pop	af								; Restore af
		ret
; ---------------------------------------------------------------------------
.no_fade:
		ld	a, (zFadeToPrevFlag)			; Get fade-to-prev flag
		cp	mus_ExtraLife-mus__First						; Was it triggered by the 1-up song?
		jp	z, zBGMLoad						; Branch if yes
		xor	a								; a = 0
		ld	(zMusicNumber), a				; Clear M68K input queue...
		ld	(zSFXNumber0), a				; ... including SFX slot 0...
		ld	(zSFXNumber1), a				; ... and SFX slot 1
		ld	(zSoundQueue0), a				; Also clear music queue entry 0...
		ld	(zSoundQueue1), a				; ... and entry 1...
		ld	(zSoundQueue2), a				; ... and entry 2
		ld	a, (zSongBank)					; Get song bank for extant track...
		ld	(zSongBankSave), a				; ... and save it
		ld	a, (zTempoSpeedup)				; Get current tempo speed-up value...
		ld	(zTempoSpeedupSave), a			; ... and save it
		xor	a								; a = 0
		ld	(zTempoSpeedup), a				; 1-Up should play on normal speed
		ld	hl, zTracksStart				; hl = pointer to song RAM
		ld	de, zTracksSaveStart			; de = pointer to RAM area to save the song data to
		ld	bc, zTracksSaveEnd-zTracksSaveStart		; Number of bytes to copy
		ldir								; while (bc-- > 0) *de++ = *hl++;
		ld	hl, zTracksSaveStart			; hl = pointer to saved song's RAM area
		ld	de, zTrack.len					; Spacing between tracks
		ld	b, (zTracksSaveEnd-zTracksSaveStart)/zTrack.len	; Number of tracks

.loop:
	if fix_sndbugs
		ld	a, (hl)							; Get playback control byte for song
		and	7Fh								; Strip the 'playing' bit
		or	4								; Set bit 2 (SFX overriding)
		ld	(hl), a							; And save it all
	else
		ld	a, (hl)							; Get playback control byte for song
		and	7Fh								; Strip the 'playing' bit
		set	2, (hl)							; Set bit 2 (SFX overriding)
		ld	(hl), a							; But then overwrite the whole thing...
	endif
		add	hl, de							; Advance to next track
		djnz	.loop						; Loop for all tracks

		ld	a, mus_ExtraLife-mus__First					; a = 1-up id-1
		ld	(zFadeToPrevFlag), a			; Set fade-to-prev flag to it
		ld	a, (zCurrentTempo)				; Get current tempo
		ld	(zCurrentTempoSave), a			; Save it
		ld	hl, (zVoiceTblPtr)				; Get voice table pointer
		ld	(zVoiceTblPtrSave), hl			; Save it
		jp	zBGMLoad
; ---------------------------------------------------------------------------

zPlayMusic_DoFade:
		call	zStopAllSound					; Stop all music

;loc_5DE
zBGMLoad:
		pop	af								; Restore af
		push	af							; Then save it back again
		ld	hl, z80_MusicBanks				; hl = table of music banks
		; The following block adds the music index to the table address as a 16-bit offset
		add	a, l							; a += l
		ld	l, a							; l = low byte of offset into music entry
		adc	a, h							; a += h, plus 1 if a + l overflowed the 8-bit register
		sub	l								; Now, a = high byte of offset into music entry
		ld	h, a							; hl is the offset to the music bank
	if fix_sndbugs
		ld	a, (hl)							; Get bank for the song to play
	else
		ld	(loc_5EB+1), hl					; Store into next instruction (self-modifying code)
loc_5EB:
		ld	a, (z80_MusicBanks)				; self-modified code; a is set to correct bank for the song to play
	endif
		ld	(zSongBank), a					; Save the song's bank...
		bankswitch2							; ... then bank switch to it
		ld	a, 0B6h							; Set Panning / AMS / FMS
		ld	(zYM2612_A1), a					; Write destination address to YM2612 address register
		nop
		ld	a, 0C0h							; default Panning / AMS / FMS settings (only stereo L/R enabled)
		ld	(zYM2612_D1), a					; Write to YM2612 data register
		pop	af								; Restore af
		ld	c, zID_MusicPointers			; c = 4 (music pointer table)
		rst	GetPointerTable					; hl = pointer table for music pointers
		rst	PointerTableOffset				; hl = pointer to song data
		push	hl							; Save hl...
		push	hl							; ... twice
		rst	ReadPointer						; Dereference pointer, so that hl = pointer to voice table
		ld	(zVoiceTblPtr), hl				; Store voice table pointer
		pop	hl								; Restore hl to pointer to song data
		pop	iy								; Also set iy = pointer to song data
		ld	a, (iy+5)						; Main tempo value
		ld	(zTempoAccumulator), a			; Set starting accumulator value
		ld	(zCurrentTempo), a				; Store current song tempo
		ld	de, 6							; Offset into DAC pointer
		add	hl, de							; hl = pointer to DAC pointer
		ld	(zSongPosition), hl				; Save it to RAM
		ld	hl, zFMDACInitBytes				; Load pointer to init data
		ld	(zTrackInitPos), hl				; Save it to RAM
		ld	de, zTracksStart				; de = pointer to track RAM
		ld	b, (iy+2)						; b = number of FM + DAC channels
		ld	a, (iy+4)						; a = tempo divider

.fm_dac_loop:
		push	bc							; Save bc (gets damaged by ldi instructions)
		ld	hl, (zTrackInitPos)				; Restore saved position for init bytes
		ldi									; *de++ = *hl++	(copy initial playback control)
		ldi									; *de++ = *hl++	(copy channel assignment bits)
		ld	(de), a							; Copy tempo divider
		inc	de								; Advance pointer
		ld	(zTrackInitPos), hl				; Save current position in channel assignment bits
		ld	hl, (zSongPosition)				; Load current position in BGM data
		ldi									; *de++ = *hl++ (copy track address low byte)
		ldi									; *de++ = *hl++ (copy track address high byte)
		ldi									; *de++ = *hl++ (default key offset)
		ldi									; *de++ = *hl++ (track default volume)
		ld	(zSongPosition), hl				; Store current position in BGM data
		call	zInitFMDACTrack				; Init the remainder of the track RAM
		pop	bc								; Restore bc
		djnz	.fm_dac_loop				; Loop for all tracks (stored in b)

		ld	a, (iy+3)						; Get number of PSG tracks
		or	a								; Do we have any PSG channels?
		jp	z, zClearNextSound				; Branch if not
		ld	b, a							; b = number of PSG tracks
		ld	hl, zPSGInitBytes				; Load pointer to init data
		ld	(zTrackInitPos), hl				; Save it to RAM
		ld	de, zSongPSG1					; de = pointer to RAM for song PSG tracks
		ld	a, (iy+4)						; a = tempo divider

.psg_loop:
		push	bc							; Save bc (gets damaged by ldi instructions)
		ld	hl, (zTrackInitPos)				; Restore saved position for init bytes
		ldi									; *de++ = *hl++
		ldi									; *de++ = *hl++
		ld	(de), a							; Copy tempo divider
		inc	de								; Advance pointer
		ld	(zTrackInitPos), hl				; Save current position in channel assignment bits
		ld	hl, (zSongPosition)				; Load current position in BGM data
		ld	bc, 6							; Copy 6 bytes
		ldir								; while (bc-- > 0) *de++ = *hl++; (copy track address, default key offset, default volume, modulation control, default PSG tone)
		ld	(zSongPosition), hl				; Store current position in BGM data
		call	zZeroFillTrackRAM			; Init the remainder of the track RAM
		pop	bc								; Restore bc
		djnz	.psg_loop					; Loop for all tracks (stored in b)

; =============== S U B	R O U T	I N E =======================================
; Clears next sound to play.
;sub_690
zClearNextSound:
		xor	a
		ld	(zNextSound), a
		ret
; End of function zClearNextSound
; ---------------------------------------------------------------------------
;loc_695
; FM/DAC channel assignment bits
; The first byte in every pair (always 80h) is default value for playback control bits.
; The second byte in every pair goes as follows:
; The first is for DAC; then 0, 1, 2 then 4, 5, 6 for the FM channels (the missing 3
; is the gap between part I and part II for YM2612 port writes).
zFMDACInitBytes:
		db   80h,   6
		db   80h,   0
		db   80h,   1
		db   80h,   2
		db   80h,   4
		db   80h,   5
	if fix_sndbugs=0
		db   80h,   6	; FM6 music track (does not exist in this driver)
	endif
;loc_6A3
; Default values for PSG tracks
; The first byte in every pair (always 80h) is default value for playback control bits.
; The second byte in every pair is the default values for PSG tracks.
zPSGInitBytes:
		db   80h, 80h
		db   80h, 0A0h
		db   80h, 0C0h
; ---------------------------------------------------------------------------
;loc_6A9
zPlaySound_CheckRing:
		sub	sfx__First					; Make it a 0-based index
		or	a								; Is it the ring sound?
		jp	nz, zPlaySound_Bankswitch		; Branch if not
		ld	a, (zRingSpeaker)				; Get speaker on which ring sound is played
		xor	1								; Toggle bit 0
		ld	(zRingSpeaker), a				; Save it

;loc_6B7
zPlaySound_Bankswitch:
		ex	af, af'							; Save af
		ld	a, zmake68kBank(SndBank)		; Load SFX sound bank address
		bankswitch2							; Bank switch to it
		xor	a								; a = 0
		ld	c, zID_SFXPointers				; SFX table index
		ld	(zUpdatingSFX), a				; Clear flag to update SFX
		ex	af, af'							; Restore af
		cp	sfx_Spindash-sfx__First		; Is this the spindash sound?
		jp	z, zPlaySound					; Branch if yes
		cp	sfx__FirstContinuous-sfx__First	; Is this before sound 0BCh?
		jp	c, zPlaySound_Normal			; Branch if yes
		push	af							; Save af
		ld	b, a							; b = sound index
		ld	a, (zContinuousSFX)				; Load last continuous SFX played
		sub	b								; Is this the same continuous sound that was playing?
		jp	nz, zPlaySound_NotCont			; Branch if not
		ld	a, 80h							; a = 80h
		ld	(zContinuousSFXFlag), a			; Flag continuous SFX as being extended
		rst	GetPointerTable					; hl = pointer to SFX data table
		pop	af								; Restore af
	if fix_sndbugs=0
		ld	c, a							; c = SFX index; redundant, as PointerTableOffset does it already
	endif
		rst	PointerTableOffset				; hl = pointer to SFX data
		inc	hl								; Skip low byte of voice pointer
		inc	hl								; Skip high byte of voice pointer
		inc	hl								; Skip timing divisor
		ld	a, (hl)							; Get number of SFX tracks
		ld	(zContSFXLoopCnt), a			; Save it to RAM (loop counter for continuous SFX)
		jp	zClearNextSound
; ---------------------------------------------------------------------------
;loc_6FB
zPlaySound_NotCont:
		xor	a								; a = 0
		ld	(zContinuousSFXFlag), a			; Clear continue continuous SFX flag
		pop	af								; Restore af
		ld	(zContinuousSFX), a				; Store SFX index
		jp	zPlaySound
; ---------------------------------------------------------------------------
;loc_706
zPlaySound_Normal:
		push	af							; Save af
		xor	a								; a = 0
		ld	(zSpindashRev), a				; Reset spindash rev
		pop		af							; Restore af

;loc_70C
zPlaySound:
		rst	GetPointerTable					; hl = pointer to SFX data table
		rst	PointerTableOffset				; hl = pointer to SFX data
		push	hl							; Save hl
		rst	ReadPointer						; hl = voice table pointer
		ld	(zSFXVoiceTblPtr), hl			; Save to RAM
	if fix_sndbugs=0
		xor	a								; a = 0
		ld	(unk_1C15), a					; Set otherwise unused location to zero
	endif
		pop	hl								; hl = pointer to SFX data
		push	hl							; Save it again
		pop	iy								; iy = pointer to SFX data
		ld	a, (iy+2)						; a = tempo divider
		ld	(zSFXTempoDivider), a			; Save to RAM
		ld	de, 4							; de = 4
		add	hl, de							; hl = pointer to SFX track data
		ld	b, (iy+3)						; b = number of tracks (FM + PSG) used by SFX
		ld	a, b							; Copy to a
		ld	(zContSFXLoopCnt), a			; Save to RAM (loop counter for continuous SFX)

;loc_72C
zSFXTrackInitLoop:
		push	bc							; Save bc; damaged by ldi instructions below
		push	hl							; Save hl
		inc	hl								; hl = pointer to channel identifier
		ld	c, (hl)							; c = channel identifier
		call	zGetSFXChannelPointers		; Get track pointers for track RAM (ix) and overridden song track (hl)
		set	2, (hl)							; Set 'SFX is overriding this track' bit
		push	ix							; Save pointer to SFX track data in RAM

	if fix_sndbugs=0
		ld	a, (zUpdatingSFX)				; Get flag
		or	a								; Are we updating SFX?
		jr	z, .normalsfx1							; Branch if not (hint: it was cleared just below the bank switch above so... always)

		; Effectively dead code.
		; Analysis of the Battletoads sound driver confirms previous speculation:
		; this code was meant for GHZ-like waterfall effects which were subsequently
		; scrapped in favor of the continuous SFX system.
		; If this system were to be reimplemented, then, after the call to
		; zGetSFXChannelPointers, we would have:
		; * ix = pointer to the overriding SFX track data in RAM;
		; * iy = pointer to the special SFX track data in RAM.
		; * hl = pointer to the overridden music track data in RAM;
		; This code would then ensure that de points to the correct RAM area for
		; the writes below.
		pop		hl							; hl = pointer to SFX track data in RAM
		push	iy							; Save iy (pointer to SFX data)
.normalsfx1:
	endif

		pop		de							; de = pointer to SFX track data in RAM (unless you consider the above effectively dead code)
		pop		hl							; hl = pointer to SFX track data
		ldi									; *de++ = *hl++ (initial playback control)
		ld	a, (de)							; Get the voice control byte from track RAM (to deal with SFX already there)
		cp	2								; Is this FM3?
		call	z, zFM3NormalMode			; Set FM3 to normal mode if so
		ldi									; *de++ = *hl++ (copy channel identifier)
		ld	a, (zSFXTempoDivider)			; Get SFX tempo divider
		ld	(de), a							; Store it to RAM
		inc	de								; Advance pointer
		ldi									; *de++ = *hl++ (low byte of channel data pointer)
		ldi									; *de++ = *hl++ (high byte of channel data pointer)
		ldi									; *de++ = *hl++ (key displacement)
		ldi									; *de++ = *hl++ (channel volume)
		call	zInitFMDACTrack				; Init the remainder of the track RAM

	if fix_sndbugs=0
		; Analysis of the Battletoads sound driver confirms previous speculation:
		; this code was meant for GHZ-like waterfall effects which were subsequently
		; scrapped in favor of the continuous SFX system.
		; If this system were to be reimplemented, then, after the call to
		; zGetSFXChannelPointers, we would have:
		; * ix = pointer to the overriding SFX track data in RAM;
		; * iy = pointer to the special SFX track data in RAM.
		; * hl = pointer to the overridden music track data in RAM;
		; The code would then be checking to see if the corresponding SFX track
		; was playing, make sure the tracks refer to the same FM/PSG channel
		; then, if needed, mark the special SFX track as being overridden by the
		; SFX so as to not abruptly end the SFX.
		; With the system unimplemented, iy points to the current SFX track data,
		; meaning that the second branch is never taken, resulting in an attempted
		; write to ROM.
		bit	7, (ix+zTrack.PlaybackControl)	; Is the 'playing' bit set for this track?
		jr	z, .dontoverride							; Branch if not (all SFX define it as 80h, so... never)
		ld	a, (ix+zTrack.VoiceControl)		; Grab the voice control byte
		cp	(iy+zTrack.VoiceControl)			; Is this equal to the one for the corresponding special SFX track?
		jr	nz, .dontoverride							; Branch if not
		set	2, (iy+zTrack.PlaybackControl)	; Set bit 2 of playback control ('SFX is overriding this track')
.dontoverride:
	endif

		push	hl							; Save hl
		ld	hl, (zSFXVoiceTblPtr)			; hl = pointer to voice data

	if fix_sndbugs=0
		ld	a, (zUpdatingSFX)				; Get flag
		or	a								; Are we updating SFX?
		jr	z, .normalsfx2							; Branch if not (hint: it was cleared just below the bank switch above so... always)

		; Analysis of the Battletoads sound driver confirms previous speculation:
		; this code was meant for GHZ-like waterfall effects which were subsequently
		; scrapped in favor of the continuous SFX system.
		; If this system were to be reimplemented, then, after the call to
		; zGetSFXChannelPointers, we would have:
		; * ix = pointer to the overriding SFX track data in RAM;
		; * iy = pointer to the special SFX track data in RAM.
		; * hl = pointer to the overridden music track data in RAM;
		; This code would then make ix point to the correct track data for the
		; function calls below.
		; Without it implemented, iy points to the current SFX track data.
		push	iy							; Save iy
		pop	ix							; ix = pointer to special SFX data
.normalsfx2:
	endif

		ld	(ix+zTrack.VoicesLow), l		; Low byte of voice pointer
		ld	(ix+zTrack.VoicesHigh), h		; High byte of voice pointer
		call	zKeyOffIfActive				; Kill channel notes
	if fix_sndbugs
		bit	7, (ix+zTrack.VoiceControl)		; Is this an FM track?
		call	z, zFMClearSSGEGOps			; If so, clear SSG-EG operators for track's channels
	else
		call	zFMClearSSGEGOps			; Clear SSG-EG operators for track's channels (even on PSG tracks!!!)
	endif
		pop		hl							; Restore hl
		pop		bc							; Restore bc
		djnz	zSFXTrackInitLoop			; Loop for all SFX tracks
		jp	zClearNextSound

; =============== S U B	R O U T	I N E =======================================
;
;sub_78F
zGetSFXChannelPointers:
		bit	7, c							; Is this a PSG track?
		jr	nz, .is_psg						; Branch if yes
		ld	a, c							; a = c
	if fix_sndbugs=0
		bit	2, a							; Is this FM4, FM5 or FM6?
		jr	z, .get_ptrs					; Branch if not
		dec	a								; Remove gap between FM3 and FM4+
	endif
		jr	.get_ptrs
; ---------------------------------------------------------------------------
.is_psg:
	if fix_sndbugs
		call	zSilencePSGChannel			; Silence channel at ix
		ld	a, c							; a = channel identifier
		; Shift high 3 bits to low bits so that we can convert it to a table index
		rlca
		rlca
		rlca
		and	7
		add	a, 3							; Compensate for subtraction below
	else
		ld	a, 1Fh							; a = 1Fh (redundant, as this is the first instruction of the function)
		call	zSilencePSGChannel			; Silence channel at ix
		; The next two lines are here because zSilencePSGChannel does not do
		; its job correctly. See the note there.
		ld	a, 0FFh							; Command to silence Noise channel
		ld	(zPSG), a						; Silence it
		ld	a, c							; a = channel identifier
		; The next 5 shifts are so that we can convert it to a table index
		srl	a
		srl	a
		srl	a
		srl	a
		srl	a
		add	a, 2							; Compensate for subtraction below
	endif

.get_ptrs:
		sub	2								; Start table at FM3
		ld	(zSFXSaveIndex), a				; Save index of overridden channel
		push	af							; Save af
		ld	hl, zSFXChannelData				; Pointer table for track RAM
		rst	PointerTableOffset				; hl = track RAM
		push	hl							; Save hl
		pop	ix								; ix = track RAM
		pop	af								; Restore af
		; This is where there is code in other drivers to load the special SFX
		; channel pointers to iy
		ld	hl, zSFXOverriddenChannel		; Pointer table for the overridden music track
	if fix_sndbugs
		jp	PointerTableOffset				; hl = RAM destination to mark as overridden
	else
		rst	PointerTableOffset				; hl = RAM destination to mark as overridden
		ret
	endif
; End of function zGetSFXChannelPointers


; =============== S U B	R O U T	I N E =======================================
;
;sub_7C5
zInitFMDACTrack:
		ex	af, af'							; Save af
		xor	a								; a = 0
		ld	(de), a							; Set modulation to inactive
		inc	de								; Advance to next byte
		ld	(de), a							; Set FM instrument/PSG tone to zero too
		inc	de								; Advance to next byte again
		ex	af, af'							; Restore af

;loc_7CC
zZeroFillTrackRAM:
		ex	de, hl							; Exchange the contents of de and hl
		ld	(hl), zTrack.len				; Call subroutine stack pointer
		inc	hl								; Advance to next byte
		ld	(hl), 0C0h						; default Panning / AMS / FMS settings (only stereo L/R enabled)
		inc	hl								; Advance to next byte
		ld	(hl), 1							; Current note duration timeout

		ld	b, zTrack.len-zTrack.DurationTimeout-1	; Loop counter

.loop:
		inc	hl								; Advance to next byte
		ld	(hl), 0							; Put 0 into this byte
		djnz	.loop						; Loop until end of track

		inc	hl								; Make hl point to next track
		ex	de, hl							; Exchange the contents of de and hl
		ret
; End of function zInitFMDACTrack
; ---------------------------------------------------------------------------
;zloc_7DF
zSFXChannelData:
		dw  zSFX_FM3						; FM3
	if fix_sndbugs
		dw  0000h	; Ironically, this filler is smaller than the code made to avoid it
	endif
		dw  zSFX_FM4						; FM4
		dw  zSFX_FM5						; FM5
		dw  zSFX_FM6						; FM6 or DAC
		dw  zSFX_PSG1						; PSG1
		dw  zSFX_PSG2						; PSG2
		dw  zSFX_PSG3						; PSG3
		dw  zSFX_PSG3						; PSG3/Noise
;zloc_7EF
zSFXOverriddenChannel:
		dw  zSongFM3						; FM3
	if fix_sndbugs
		dw  0000h
	endif
		dw  zSongFM4						; FM4
		dw  zSongFM5						; FM5
		dw  zSongFM6_DAC					; FM6 or DAC
		dw  zSongPSG1						; PSG1
		dw  zSongPSG2						; PSG2
		dw  zSongPSG3						; PSG3
		dw  zSongPSG3						; PSG3/Noise

; =============== S U B	R O U T	I N E =======================================
; Pauses/unpauses sound.
;
;sub_7FF
zPauseUnpause:
		ld	hl, zPauseFlag					; hl = pointer to pause flag
		ld	a, (hl)							; a = pause flag
		or	a								; Is sound driver paused?
		ret	z								; Return if not
		jp	m, .unpause						; Branch if pause flag is negative (unpause)
		pop	de								; Pop return value from the stack, so that a 'ret' will go back to zVInt
		dec	a								; Decrease a
		ret	nz								; Return if nonzero
		ld	(hl), 2							; Set pause flag to 2 (i.e., stay paused but don't pause again)
		jp	zPauseAudio						; Pause all but FM6/DAC
; ---------------------------------------------------------------------------
.unpause:
		xor	a								; a = 0
		ld	(hl), a							; Clear pause flag
		ld	a, (zFadeOutTimeout)			; Get fade timeout
		or	a								; Is it zero?
		jp	nz, zStopAllSound					; Stop all music if not
		ld	ix, zSongFM1					; Start with FM1 track
	if fix_sndbugs
		ld	b, (zSongPSG1-zSongFM1)/zTrack.len	; Number of FM tracks
	else
		; DANGER! This treats a PSG channel as if it were an FM channel. This
		; will break AMS/FMS/pan for FM1.

		ld	b, (zSongPSG2-zSongFM1)/zTrack.len	; Number of FM tracks +1
	endif

.fm_loop:
		ld	a, (zHaltFlag)					; Get halt flag
		or	a								; Is song halted?
		jr	nz, .set_pan					; Branch if yes
		bit	7, (ix+zTrack.PlaybackControl)	; Is track playing?
		jr	z, .skip_fm_track				; Branch if not

.set_pan:
		ld	c, (ix+zTrack.AMSFMSPan)		; Get track AMS/FMS/panning
		ld	a, 0B4h							; Command to select AMS/FMS/panning register
		call	zWriteFMIorII				; Write data to YM2612

.skip_fm_track:
		ld	de, zTrack.len					; Spacing between tracks
		add	ix, de							; Advance to next track
		djnz	.fm_loop					; Loop for all tracks

	if fix_sndbugs
		ld	ix, zTracksSFXStart				; Start at the start of SFX track data
		ld	b, (zTracksSFXEnd-zTracksSFXStart)/zTrack.len	; Number of tracks
	else
		; DANGER! This code goes past the end of Z80 RAM and into reserved territory!
		; By luck, it only *reads* from these areas...

		ld	ix, zTracksSFXEnd				; Start at the END of SFX track data (?)
		ld	b, 7							; But loop for 7 tracks (??)
	endif
.psg_loop:
		bit	7, (ix+zTrack.PlaybackControl)	; Is track playing?
		jr	z, .skip_psg_track				; Branch if not
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG track?
		jr	nz, .skip_psg_track				; Branch if yes
		ld	c, (ix+zTrack.AMSFMSPan)		; Get track AMS/FMS/panning
		ld	a, 0B4h							; Command to select AMS/FMS/panning register
		call	zWriteFMIorII				; Write data to YM2612

.skip_psg_track:
		ld	de, zTrack.len					; Spacing between tracks
		add	ix, de							; Go to next track
		djnz	.psg_loop					; Loop for all tracks

		ret
; End of function zPauseUnpause

; =============== S U B	R O U T	I N E =======================================
; Fades out music.
;sub_85C
zFadeOutMusic:
		ld	a, 28h							; a = 28h
		ld	(zFadeOutTimeout), a			; Set fade timeout to this (start fading out music)
		ld	a, 6							; a = 6
		ld	(zFadeDelayTimeout), a			; Set fade delay timeout
		ld	(zFadeDelay), a					; Set fade delay and fall through

; =============== S U B	R O U T	I N E =======================================
; Halts FM6/DAC, PSG1, PSG2, PSG3.
;sub_869
zHaltDACPSG:
		xor	a								; a = 0
		ld	(zSongFM6_DAC), a				; Halt FM6/DAC
		ld	(zSongPSG3), a					; Halt PSG3
		ld	(zSongPSG1), a					; Halt PSG1
		ld	(zSongPSG2), a					; Halt PSG2
		jp	zPSGSilenceAll
; End of function zHaltDACPSG


; =============== S U B	R O U T	I N E =======================================
; Fade out music slowly.
;
;sub_879
zDoMusicFadeOut:
		ld	hl, zFadeOutTimeout				; hl = pointer to fade timeout
		ld	a, (hl)							; a = fade counter
		or	a								; Is fade counter zero?
		ret	z								; Return if yes
		call	m, zHaltDACPSG				; Kill DAC and PSG channels if negative
		res	7, (hl)							; Clear sign bit
		ld	a, (zFadeDelayTimeout)			; Get fade delay timeout
		dec	a								; Decrement it
		jr	z, .timer_expired				; Branch if it zero now
		ld	(zFadeDelayTimeout), a			; Store it back
		ret
; ---------------------------------------------------------------------------
.timer_expired:
		ld	a, (zFadeDelay)					; Get fade delay
		ld	(zFadeDelayTimeout), a			; Restore counter to initial value
	if fix_sndbugs
		ld	hl, zFadeOutTimeout				; (hl) = fade timeout
		dec	(hl)							; Decrement it
	else
		ld	a, (zFadeOutTimeout)			; a = fade timeout
		dec	a								; Decrement it
		ld	(zFadeOutTimeout), a			; Then store it back
	endif
		jp	z, zStopAllSound					; Stop all music if it is zero
		ld	a, (zSongBank)					; a = current music bank ID
		bankswitch2							; Bank switch to music bank
		ld	ix, zTracksStart				; ix = pointer to track RAM
		ld	b, (zSongPSG1-zTracksStart)/zTrack.len	; Number of FM+DAC tracks

.loop:
		inc	(ix+zTrack.Volume)				; Decrease volume
		jp	p, .chk_change_volume			; If still positive, branch
		dec	(ix+zTrack.Volume)				; Increase it back to minimum volume (127)
		jr	.next_track
; ---------------------------------------------------------------------------
.chk_change_volume:
		bit	7, (ix+zTrack.PlaybackControl)	; Is track still playing?
		jr	z, .next_track					; Branch if not
		bit	2, (ix+zTrack.PlaybackControl)	; Is SFX overriding track?
		jr	nz, .next_track					; Branch if yes
		push	bc							; Save bc
		call	zSendTL						; Send new volume
		pop	bc								; Restore bc

.next_track:
		ld	de, zTrack.len					; Spacing between tracks
		add	ix, de							; Advance to next track
		djnz	.loop						; Loop for all tracks
		ret
; End of function zDoMusicFadeOut


; =============== S U B	R O U T	I N E =======================================
; Fades music in.
;
;sub_8DF
zDoMusicFadeIn:
		ld	a, (zFadeInTimeout)				; Get fading timeout
		or	a								; Is music being faded?
		ret	z								; Return if not
		ld	a, (zSongBank)					; Get current music bank
		bankswitch2							; Bank switch to music
	if fix_sndbugs
		ld	hl, zFadeDelay					; Get fade delay
		dec	(hl)							; Decrement it
	else
		ld	a, (zFadeDelay)					; Get fade delay
		dec	a								; Decrement it
		ld	(zFadeDelay), a					; Store it back
	endif
		ret	nz								; Return if it is not yet zero
		ld	a, (zFadeDelayTimeout)			; Get current fade delay timeout
		ld	(zFadeDelay), a					; Reset to starting fade delay
		ld	b, (zSongPSG1-zSongFM1)/zTrack.len	; Number of FM tracks
		ld	ix, zSongFM1					; ix = start of FM1 RAM
		ld	de, zTrack.len					; Spacing between tracks

.fm_loop:
	if fix_sndbugs
		dec	(ix+zTrack.Volume)				; Increase track volume
	else
		ld	a, (ix+zTrack.Volume)			; Get track volume
		dec	a								; Increase it
		ld	(ix+zTrack.Volume), a			; Then store it back
	endif
		push	bc							; Save bc
		call	zSendTL						; Send new volume
		pop	bc								; Restore bc
		add	ix, de							; Advance to next track
		djnz	.fm_loop					; Loop for all tracks

	if fix_sndbugs
		ld	hl, zFadeInTimeout				; Get fading timeout
		dec	(hl)							; Decrement it
	else
		ld	a, (zFadeInTimeout)				; Get fading timeout
		dec	a								; Decrement it
		ld	(zFadeInTimeout), a				; Then store it back
	endif
		ret	nz								; Return if still fading
		ld	b, (zTracksEnd-zSongPSG1)/zTrack.len	; Number of PSG tracks
		ld	ix, zSongPSG1					; ix = start of PSG RAM
		ld	de, zTrack.len					; Spacing between tracks

.psg_loop:
		res	2, (ix+zTrack.PlaybackControl)	; Clear 'SFX is overriding' bit
		add	ix, de							; Advance to next track
		djnz	.psg_loop					; Loop for all tracks

		ld	ix, zSongFM6_DAC				; ix = start of DAC/FM6 RAM
		res	2, (ix+zTrack.PlaybackControl)	; Clear 'SFX is overriding' bit
		ret
; End of function zDoMusicFadeIn


; =============== S U B	R O U T	I N E =======================================
; Wipes music data and fades all FM, PSG and DAC channels.
;sub_944 zMusicFade
zStopAllSound:
		; The following block sets to zero the z80 RAM from 1C0Dh to 1FD4h
		ld	hl, zTempVariablesStart				; Starting source address for copy
		ld	de, zTempVariablesStart+1					; Starting destination address for copy
	if fix_sndbugs
		ld	bc, zTempVariablesEnd-zTempVariablesStart-1	; Length of copy
	else
		ld	bc, zTempVariablesEnd-zTempVariablesStart-1+34h	; Length of copy
	endif
		ld	(hl), 0							; Initial value of zero
		ldir								; while (--length) *de++ = *hl++

		xor	a								; a = 0
		ld	(zTempoSpeedup), a				; Fade in normal speed

		ld	ix, zFMDACInitBytes				; Initialization data for channels
		ld	b, 6	; Number of FM channels

.loop:
		push	bc							; Save bc for loop

	if fix_sndbugs=0
		call	zFMSilenceChannel			; Silence track's channel
	else
		; Inline it because zKeyOnOff tries to write to ix+0, which we don't want
		call	zSetMaxRelRate
		ld	a, 40h							; Set total level...
		ld	c, 7Fh							; ... to minimum envelope amplitude...
		call	zFMOperatorWriteLoop		; ... for all operators of this track's channel
		ld	a, 28h							; Write to KEY ON/OFF port
		ld	c, (ix+zTrack.VoiceControl)		; Send key off
		call	zWriteFMI						; Send it
	endif

		call	zFMClearSSGEGOps			; Clears the SSG-EG operators for this channel
		inc	ix								; Go to next channel byte
		inc	ix								; But skip the 80h
		pop	bc								; Restore bc for loop counter
		djnz	.loop						; Loop while b > 0

	if fix_sndbugs=0
		ld	b, 7							; Unused
		xor	a								; a = 0
		ld	(zFadeOutTimeout), a			; Set fade timeout to zero... again
	endif
		call	zPSGSilenceAll				; Silence PSG
		ld	c, 0							; Write a zero...
		ld	a, 2Bh							; ... to DAC enable register
		call	zWriteFMI					; Disable DAC

;loc_979
zFM3NormalMode:
	if fix_sndbugs
		ld	c, 0							; FM3 mode: normal mode
	else
		xor	a								; a = 0 (is 0Fh in Z80 Type 1)
		ld	(zFM3Settings), a				; Save FM3 settings
		ld	c, a							; FM3 mode: normal mode
	endif
		ld	a, 27h							; FM3 special settings
		call	zWriteFMI					; Set it
		jp	zClearNextSound
; End of function zStopAllSound

; =============== S U B	R O U T	I N E =======================================
; Sets the SSG-EG registers (90h+) for all operators on this track to 0.
;
; Input:  ix    Pointer to track RAM
; Output: a     Damaged
;         b     Damaged
;         c     Damaged
;sub_986
zFMClearSSGEGOps:
		ld	a, 90h							; Set SSG-EG registers...
		ld	c, 0							; ... set to zero (as docs say it should)...
		jp	zFMOperatorWriteLoop			; ... for all operators of this track's channel
; End of function zFMClearSSGEGOps

; =============== S U B	R O U T	I N E =======================================
; Pauses all audio.
;loc_98D
zPauseAudio:
	if fix_sndbugs=0
		call	zPSGSilenceAll				; Redundant, as function falls-through to it anyway
	endif
		push	bc							; Save bc
		push	af							; Save af
		ld	b, (zSongFM4-zSongFM1)/zTrack.len	; FM1/FM2/FM3
		ld	a, 0B4h							; Command to select AMS/FMS/panning register (FM1)
		ld	c, 0							; AMS=FMS=panning=0

.loop1:
		push	af							; Save af
		call	zWriteFMI					; Write reg/data pair to YM2612
		pop	af								; Restore af
		inc	a								; Advance to next channel
		djnz	.loop1						; Loop for all channels

		ld	b, (zSongPSG1-zSongFM4)/zTrack.len	; FM4 and FM5, but not FM6
		ld	a, 0B4h							; Command to select AMS/FMS/panning register

.loop2:
		push	af							; Save af
		call	zWriteFMII					; Write reg/data pair to YM2612
		pop	af								; Restore af
		inc	a								; Advance to next channel
		djnz	.loop2						; Loop for all channels

		ld	c, 0							; Note off for all operators
		ld	b, (zSongPSG1-zSongFM1)/zTrack.len+1	; 5 FM channels + 1 gap between FM3 and FM4
		ld	a, 28h							; Command to send note on/off

.loop3:
		push	af							; Save af
		call	zWriteFMI					; Write reg/data pair to YM2612
		inc	c								; Next channel
		pop	af								; Restore af
		djnz	.loop3						; Loop for all channels

		pop	af								; Restore af
		pop	bc								; restore bc and fall through

; =============== S U B	R O U T	I N E =======================================
; Silences all PSG channels, including the noise channel.
;
; Output: a    Damaged
;sub_9BC
zPSGSilenceAll:
		push	bc							; Save bc
		ld	b, 4	; Loop 4 times: 3 PSG channels + noise channel
		ld	a, 9Fh							; Command to silence PSG1

.loop:
		ld	(zPSG), a						; Write command
		add	a, 20h							; Next channel
		djnz	.loop						; Loop for all PSG channels
		pop	bc								; Restore bc
		jp	zClearNextSound
; End of function zPSGSilenceAll


; =============== S U B	R O U T	I N E =======================================
; Tempo works as divisions of the 60Hz clock (there is a fix supplied for
; PAL that "kind of" keeps it on track.) Every time the internal music clock
; does NOT overflow, it will update. So a tempo of 80h will update every
; other frame, or 30 times a second.
;sub_9CC:
TempoWait:
		ld	a, (zCurrentTempo)				; Get current tempo value
		ld	hl, zTempoAccumulator			; hl = pointer to tempo accumulator
		add	a, (hl)							; a += tempo accumulator
		ld	(hl), a							; Store it as new accumulator value
		ret	nc								; If the addition did not overflow, return
		ld	hl, zTracksStart+zTrack.DurationTimeout	; Duration timeout of first track
		ld	de, zTrack.len					; Spacing between tracks
		ld	b, (zTracksEnd-zTracksStart)/zTrack.len	; Number of tracks

.loop:
		inc	(hl)							; Delay notes another frame
		add	hl, de							; Advance to next track
		djnz	.loop						; Loop for all channels
		ret
; End of function TempoWait


; =============== S U B	R O U T	I N E =======================================
; Copies over M68K input to the sound queue and clears the input variables
;sub_9E2
zFillSoundQueue:
		ld	hl, zMusicNumber				; M68K input
		ld	de, zSoundQueue0				; Sound queue
		ldi									; *de++ = *hl++
		ldi									; *de++ = *hl++
		ldi									; *de++ = *hl++
		xor	a								; a = 0
		dec	hl								; Point to zSFXNumber1
		ld	(hl), a							; Clear it
		dec	hl								; Point to zSFXNumber0
		ld	(hl), a							; Clear it
		dec	hl								; Point to zMusicNumber
		ld	(hl), a							; Clear it
		ret
; End of function zFillSoundQueue


; =============== S U B	R O U T	I N E =======================================
; Sets D1L to minimum, RR to maximum and TL to minimum amplitude for all
; operators on this track's channel, then sends note off for the same channel.
;
; Input:  ix    Pointer to track RAM
; Output: a     Damaged
;         b     Damaged
;         c     Damaged
;sub_9F6
zFMSilenceChannel:
		call	zSetMaxRelRate
		ld	a, 40h							; Set total level...
		ld	c, 7Fh							; ... to minimum envelope amplitude...
		call	zFMOperatorWriteLoop		; ... for all operators of this track's channel
		ld	c, (ix+zTrack.VoiceControl)		; Send key off
		jp	zKeyOnOff						; This does not safeguard against PSG tracks, making cfSilenceStopTrack dangerous (and zStopSFX even more so)
; End of function zFMSilenceChannel


; =============== S U B	R O U T	I N E =======================================
; Sets D1L to minimum and RR to maximum for all operators on this track's
; channel.
;
; Input:  ix    Pointer to track RAM
; Output: a     Damaged
;         b     Damaged
;         c     Damaged
;sub_A06
;zSetFMMinD1LRR
zSetMaxRelRate:
		ld	a, 80h							; Set D1L to minimum and RR to maximum...
		ld	c, 0FFh							; ... for all operators on this track's channel (fall through)
; End of function zSetMaxRelRate


; =============== S U B	R O U T	I N E =======================================
; Loops through all of a channel's operators and sets them to the desired value.
;
; Input:  ix    Pointer to track RAM
;         a     YM2612 register to write to
;         c     Value to write to register
; Output: b     Damaged
;sub_A0A
zFMOperatorWriteLoop:
		ld	b, 4							; Loop 4 times

.loop:
		push	af							; Save af
		call	zWriteFMIorII				; Write to part I or II, as appropriate
		pop	af								; Restore af
		add	a, 4							; a += 4
		djnz	.loop						; Loop
		ret
; End of function zFMOperatorWriteLoop
; ---------------------------------------------------------------------------
;loc_A16
zPlaySegaSound:
		call	zStopAllSound					; Fade music before playing the sound
	if fix_sndbugs
		xor	a								; a = 0
		ld	(zMusicNumber), a				; Clear M68K input queue...
		ld	(zSFXNumber0), a				; ... including SFX slot 0...
		ld	(zSFXNumber1), a				; ... and SFX slot 1
		ld	(zSoundQueue0), a				; Also clear music queue entry 0...
		ld	(zSoundQueue1), a				; ... and entry 1...
		ld	(zSoundQueue2), a				; ... and entry 2
		inc	a							; a = 1
	else
		ld	a, 1							; a = 1
	endif
		ld	(PlaySegaPCMFlag), a			; Set flag to play SEGA sound
		pop	hl								; Don't return to caller of zCycleSoundQueue
		ret

; =============== S U B	R O U T	I N E =======================================
; Performs massive restoration and starts fade in of previous music.
;
;sub_A20
zFadeInToPrevious:
		xor	a								; a = 0
		ld	(zFadeToPrevFlag), a			; Clear fade-to-prev flag
		ld	a, (zCurrentTempoSave)			; Get saved current tempo
		ld	(zCurrentTempo), a				; Restore it
		ld	a, (zTempoSpeedupSave)			; Get saved tempo speed-up
		ld	(zTempoSpeedup), a				; Restore it
		ld	hl, (zVoiceTblPtrSave)			; Get saved voice pointer
		ld	(zVoiceTblPtr), hl				; Restore it
		ld	a, (zSongBankSave)				; Get saved song bank ID
		ld	(zSongBank), a					; Restore it
		bankswitch2							; Bank switch to previous song's bank
		ld	hl, zTracksSaveStart			; Start of saved track data
		ld	de, zTracksStart				; Start of track data
		ld	bc, zTracksSaveEnd-zTracksSaveStart	; Number of bytes to copy
		ldir								; while (bc-- > 0) *de++ = *hl++;
	if fix_sndbugs
		ld	hl, zSongFM6_DAC.PlaybackControl
		ld	a, 84h							; a = 'track is playing' and 'track is resting' flags
		or	(hl)							; Add in track playback control bits
		ld	(hl), a							; Save everything
	else
		ld	a, (zSongFM6_DAC.PlaybackControl) ; a = FM6/DAC track playback control
		or	84h								; Set 'track is playing' and 'track is resting' flags
		ld	(zSongFM6_DAC.PlaybackControl), a ; Set new value
	endif
		ld	ix, zSongFM1					; ix = pointer to FM1 track RAM
		ld	b, (zTracksEnd-zSongFM1)/zTrack.len	; Number of FM+PSG tracks

.loop:
		ld	a, (ix+zTrack.PlaybackControl)	; a = track playback control
		or	84h								; Set 'track is playing' and 'track is resting' flags
		ld	(ix+zTrack.PlaybackControl), a	; Set new value
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG track?
		jp	nz, .skip_track					; Branch if yes
		res	2, (ix+zTrack.PlaybackControl)	; Clear 'SFX is overriding track' flag
		ld	a, (ix+zTrack.Volume)			; Get track volume
		add	a, 40h							; Lower volume by 40h
		ld	(ix+zTrack.Volume), a			; Store new volume
		ld	a, (ix+zTrack.VoiceIndex)		; a = FM instrument
		push	bc							; Save bc
		ld	b, a							; b = FM instrument
		call	zGetFMInstrumentPointer		; hl = pointer to instrument data
		call	zSendFMInstrument			; Send instrument
		pop	bc								; Restore bc

.skip_track:
		ld	de, zTrack.len					; Spacing between tracks
		add	ix, de							; ix = pointer to next track
		djnz	.loop						; Loop for all tracks

		ld	a, 40h							; a = 40h
		ld	(zFadeInTimeout), a				; Start fade
		ld	a, 2							; a = 2
		ld	(zFadeDelayTimeout), a			; Set fade delay timeout
		ld	(zFadeDelay), a					; Set fade delay
		ret
; End of function zFadeInToPrevious
; ---------------------------------------------------------------------------
;loc_AA5
zPSGFrequencies:
		; This table differs from the one in Sonic 1 and 2's drivers by
		; having an extra octave at the start and two extra notes at
		; the end, allowing it to span notes c-0 to b-6.
		dw 3FFh,3FFh,3FFh,3FFh,3FFh,3FFh,3FFh,3FFh,3FFh,3F7h,3BEh,388h
		dw 356h,326h,2F9h,2CEh,2A5h,280h,25Ch,23Ah,21Ah,1FBh,1DFh,1C4h
		dw 1ABh,193h,17Dh,167h,153h,140h,12Eh,11Dh,10Dh,0FEh,0EFh,0E2h
		dw 0D6h,0C9h,0BEh,0B4h,0A9h,0A0h,097h,08Fh,087h,07Fh,078h,071h
		dw 06Bh,065h,05Fh,05Ah,055h,050h,04Bh,047h,043h,040h,03Ch,039h
		dw 036h,033h,030h,02Dh,02Bh,028h,026h,024h,022h,020h,01Fh,01Dh
		dw 01Bh,01Ah,018h,017h,016h,015h,013h,012h,011h,010h,000h,000h
;loc_B4D
zFMFrequencies:
		; This table spans only a single octave, as the octave frequency
		; is calculated at run-time unlike in Sonic 1 and 2's drivers.
		dw 284h,2ABh,2D3h,2FEh,32Dh,35Ch,38Fh,3C5h,3FFh,43Ch,47Ch,4C0h
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
;
;sub_B98
zUpdateDACTrack:
	if fix_sndbugs
		dec	(ix+zTrack.DurationTimeout)		; Advance track duration timer
	else
		call	zTrackRunTimer				; Advance track duration timer
	endif
		ret	nz								; Return if note is still going
		ld	e, (ix+zTrack.DataPointerLow)	; e = low byte of track data pointer
		ld	d, (ix+zTrack.DataPointerHigh)	; d = high byte of track data pointer

;loc_BA2
zUpdateDACTrack_cont:
		ld	a, (de)							; Get next byte from track
		inc	de								; Advance pointer
		cp	FirstCoordFlag					; Is it a coordination flag?
		jp	nc, zHandleDACCoordFlag			; Branch if yes
		or	a								; Is it a note?
		jp	m, .got_sample					; Branch if yes
		dec	de								; We got a duration, so go back to it
		ld	a, (ix+zTrack.SavedDAC)			; Reuse previous DAC sample

.got_sample:
		ld	(ix+zTrack.SavedDAC), a			; Store new DAC sample
		cp	NoteRest						; Is it a rest?
		jp	z, zUpdateDACTrack_GetDuration	; Branch if yes
		res	7, a							; Clear bit 7
		push	de							; Save de
		ex	af, af'							; Save af
		call	zKeyOffIfActive				; Kill note (will do nothing if 'do not attack' is on)
		call	zFM3NormalMode				; Set FM3 to normal mode
		ex	af, af'							; Restore af
		ld	ix, zSongFM6_DAC					; ix = pointer to DAC track data
		bit	2, (ix+zTrack.PlaybackControl)	; Is SFX overriding DAC channel?
		jp	nz, .dont_play					; Branch if yes
		ld	(zDACIndex), a					; Queue DAC sample

.dont_play:
		pop	de								; Restore de

zUpdateDACTrack_GetDuration:
		ld	a, (de)							; Get note duration
		inc	de								; Advance pointer
		or	a								; Is it a duration?
		jp	p, zStoreDuration				; Branch if yes
		dec	de								; Put the byte back to the stream
	if fix_sndbugs=0
		ld	a, (ix+zTrack.SavedDuration)	; Reuse last duration (zFinishTrackUpdate should do it...)
		ld	(ix+zTrack.DurationTimeout), a	; Set new duration timeout (zFinishTrackUpdate should do it...)
	endif
		jp	zFinishTrackUpdate
; ---------------------------------------------------------------------------
;loc_BE3
zHandleDACCoordFlag:
		ld	hl, loc_BE9						; hl = desired return address
		jp	zHandleCoordFlag
; ---------------------------------------------------------------------------
loc_BE9:
		inc	de								; Advance to next byte in track
		jp	zUpdateDACTrack_cont			; Continue processing DAC track
; ---------------------------------------------------------------------------
;loc_BED
zHandleFMorPSGCoordFlag:
		ld	hl, loc_BF9						; hl = desired return address

;loc_BF0
zHandleCoordFlag:
		push	hl							; Set return location (ret) to location stored in hl
		sub	FirstCoordFlag					; Make it a zero-based index
		ld	hl, zCoordFlagSwitchTable		; Load switch table into hl
		rst	PointerTableOffset				; hl = pointer to target location
		ld	a, (de)							; a = coordination flag parameter
		jp	(hl)							; Indirect jump to coordination flag handler
; End of function zUpdateDACTrack
; ---------------------------------------------------------------------------
loc_BF9:
		inc	de								; Advance to next byte in track
		jp	zGetNextNote_cont				; Continue processing FM/PSG track
; ---------------------------------------------------------------------------
;loc_BFD
zCoordFlagSwitchTable:
		dw cfPanningAMSFMS					; 0E0h
		dw cfDetune							; 0E1h
		dw cfFadeInToPrevious				; 0E2h
		dw cfSilenceStopTrack				; 0E3h
		dw cfSetVolume						; 0E4h
		dw cfChangeVolume2					; 0E5h
		dw cfChangeVolume					; 0E6h
		dw cfPreventAttack					; 0E7h
		dw cfNoteFill						; 0E8h
		dw cfSpindashRev					; 0E9h
		dw cfPlayDACSample					; 0EAh
		dw cfConditionalJump				; 0EBh
		dw cfChangePSGVolume				; 0ECh
		dw cfSetKey							; 0EDh
		dw cfSendFMI						; 0EEh
		dw cfSetVoice						; 0EFh
		dw cfModulation						; 0F0h
		dw cfAlterModulation				; 0F1h
		dw cfStopTrack						; 0F2h
		dw cfSetPSGNoise					; 0F3h
		dw cfSetModulation					; 0F4h
		dw cfSetPSGVolEnv					; 0F5h
		dw cfJumpTo							; 0F6h
		dw cfRepeatAtPos					; 0F7h
		dw cfJumpToGosub					; 0F8h
		dw cfJumpReturn						; 0F9h
		dw cfDisableModulation				; 0FAh
		dw cfChangeTransposition			; 0FBh
		dw cfLoopContinuousSFX				; 0FCh
		dw cfToggleAltFreqMode				; 0FDh
		dw cfFM3SpecialMode					; 0FEh
		dw cfMetaCF							; 0FFh
;loc_C3D
zExtraCoordFlagSwitchTable:
		dw cfSetTempo						; 0FFh 00h
		dw cfPlaySoundByIndex				; 0FFh 01h
		dw cfHaltSound						; 0FFh 02h
		dw cfCopyData						; 0FFh 03h
		dw cfSetTempoDivider				; 0FFh 04h
		dw cfSetSSGEG						; 0FFh 05h
		dw cfFMVolEnv						; 0FFh 06h
		dw cfResetSpindashRev				; 0FFh 07h
; =============== S U B	R O U T	I N E =======================================
; Sets a new DAC sample for play.
;
; Has one parameter, the index (1-based) of the DAC sample to play.
;
;sub_C4D
cfPlayDACSample:
		ld	(zDACIndex), a					; Set next DAC sample to the parameter byte
		ret
; End of function cfPlayDACSample


; =============== S U B	R O U T	I N E =======================================
; Sets panning for track. By accident, you can sometimes set AMS and FMS
; flags -- but only if the bits in question were zero.
;
; Has one parameter byte, the AMS/FMS/panning bits.
;
;sub_C51
cfPanningAMSFMS:
		ld	c, 3Fh							; Mask for all but panning

zDoChangePan:
		ld	a, (ix+zTrack.AMSFMSPan)		; Get current AMS/FMS/panning
		and	c								; Mask out L+R
		push	de							; Store de
		ex	de, hl							; Exchange de and hl
		or	(hl)							; Mask in the new panning; may also add AMS/FMS
		ld	(ix+zTrack.AMSFMSPan), a		; Store new value in track RAM
		ld	c, a							; c = new AMS/FMS/panning
		ld	a, 0B4h							; a = YM2612 register to write to
		call	zWriteFMIorII				; Set new panning/AMS/FMS
		pop	de								; Restore de
		ret
; End of function cfPanningAMSFMS

; =============== S U B	R O U T	I N E =======================================
; Performs an escalating transposition ("revving") of the track.
;
; The saved value for the spindash rev is reset to zero every time a "normal"
; SFX is played (i.e., not a continuous SFX and not the spindash sound).
; Every time this function is called, the spindash rev value is added to the
; track key offset; unless this sum is exactly 10h, then the spindash rev is
; further increased by 1 for future calls.
;
; Has no parameter bytes.
;
;sub_C65
cfSpindashRev:
		ld	hl, zSpindashRev				; hl = pointer to escalating transposition
		ld	a, (hl)							; a = value of escalating transposition
		add	a, (ix+zTrack.Transpose)		; Add in current track transposition
		ld	(ix+zTrack.Transpose), a		; Store result as new track transposition
		cp	10h								; Is the current transposition 10h?
		jp	z, .skip_rev					; Branch if yes
		inc	(hl)							; Otherwise, increase escalating transposition

.skip_rev:
		dec	de								; Put parameter byte back
		ret
; End of function cfSpindashRev


; =============== S U B	R O U T	I N E =======================================
; Sets frequency displacement (signed). The final note frequency is shifted
; by this value.
;
; Has one parameter byte, the new frequency displacement.
;
;sub_C77 cfAlterNoteFreq
cfDetune:
		ld	(ix+zTrack.Detune), a	; Set detune
		ret
; End of function cfDetune


; =============== S U B	R O U T	I N E =======================================
; Fade in to previous song.
;
; Has one parameter byte. If the parameter byte if FFh, the engine will fade
; to the previous song. If the parameter byte is equal to 29h (1-Up ID - 1),
; the driver will prevent new music or SFX from playing as long as the 1-Up
; music is playing (but will not clear the M68K queue). For all other values,
; the queue will work as normal, but no fade-in will be done.
;
;sub_C7B
cfFadeInToPrevious:
		ld	(zFadeToPrevFlag), a
		ret
; End of function cfFadeInToPrevious

; =============== S U B	R O U T	I N E =======================================
; Silences FM channel and stops track. Expanded form of coord. flag 0F2h.
;
; Technically, it has a parameter byte, but it is irrelevant and unused.
;
;loc_C7F
cfSilenceStopTrack:
	if fix_sndbugs
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG track?
		call	z, zFMSilenceChannel		; If so, don't mess with the YM2612
	else
		call	zFMSilenceChannel
	endif
		jp	cfStopTrack
; End of function cfSilenceStopTrack

; =============== S U B	R O U T	I N E =======================================
; Sets track volume.
;
; Has one parameter byte, the volume.
;
; For FM tracks, this is a 7-bit value from 0 (lowest volume) to 127 (highest
; volume). The value is XOR'ed with 7Fh before being sent, then stripped of the
; sign bit. The volume change takes effect immediately.
;
; For PSG tracks, this is a 4-bit value ranging from 8 (lowest volume) to 78h
; (highest volume). The value is shifted 3 bits to the right, XOR'ed with 0Fh
; and AND'ed with 0Fh before being uploaded, so the sign bit and the lower 3
; bits are discarded.
;
;loc_C85
cfSetVolume:
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG channel?
		jr	z, .not_psg						; Branch if not
		; The following code gets bits 3, 4, 5 and 6 from the parameter byte,
		; puts them in positions 0 to 3 and inverts them, discarding all other
		; bits in the parameter byte.
		; Shift the parameter byte 3 bits to the right
		srl	a
		srl	a
		srl	a
		xor	0Fh								; Invert lower nibble's bits
		and	0Fh								; Clear out high nibble
		jp	zStoreTrackVolume
; ---------------------------------------------------------------------------
.not_psg:
		xor	7Fh								; Invert parameter byte (except irrelevant sign bit)
		and	7Fh								; Strip sign bit
		ld	(ix+zTrack.Volume), a			; Set as new track volume
		jr	zSendTL							; Begin using new volume immediately

; =============== S U B	R O U T	I N E =======================================
; Change track volume for a FM track.
;
; Has two parameter bytes: the first byte is ignored, the second is the signed
; change in volume. Positive lowers volume, negative increases it.
;
;loc_CA1
cfChangeVolume2:
		inc	de								; Advance pointer
		ld	a, (de)							; Get change in volume then fall-through


; =============== S U B	R O U T	I N E =======================================
; Change track volume for a FM track.
;
; Has one parameter byte, the signed change in volume. Positive lowers volume,
; negative increases it.
;
;loc_CA3
cfChangeVolume:
		; S2 places this check further down (and S1 lacks it altogether),
		; allowing PSG channels to change their volume. This means the
		; likes of S2's SFX $F0 will sound different in this driver
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG track?
		ret	nz								; Return if yes
		add	a, (ix+zTrack.Volume)			; Add in track's current volume
		jp	p, .set_vol						; Branch if result is still positive
		jp	pe, .underflow					; Branch if addition overflowed into more than 127 positive
		xor	a								; Set maximum volume
		jp	.set_vol
; ---------------------------------------------------------------------------
.underflow:
		ld	a, 7Fh							; Set minimum volume

.set_vol:
		ld	(ix+zTrack.Volume), a			; Store new volume

; =============== S U B	R O U T	I N E =======================================
; Subroutine to send TL information to YM2612.
;
;sub_CBA
zSendTL:
		push	de							; Save de
		ld	de, zFMInstrumentTLTable		; de = pointer to FM TL register table
		ld	l, (ix+zTrack.TLPtrLow)			; l = low byte of pointer to instrument's TL data
		ld	h, (ix+zTrack.TLPtrHigh)		; h = high byte of pointer to instrument's TL data
		ld	b, zFMInstrumentTLTable_End-zFMInstrumentTLTable	; Number of entries

.loop:
		ld	a, (hl)							; a = register data
		or	a								; Is it positive?
		jp	p, .skip_track_vol				; Branch if yes
		add	a, (ix+zTrack.Volume)			; Add track's volume to it
	if fix_sndbugs
		; Perform some clamping, to prevent volume attenuation overflow (quiet sounds becoming loud)
		jr	nc,.skip_track_vol
		ld	a, 7Fh
	endif

.skip_track_vol:
	if fix_sndbugs=0
		; Not actually needed
		and	7Fh								; Strip sign bit
	endif
		ld	c, a							; c = new volume for operator
		ld	a, (de)							; a = register write command
		call	zWriteFMIorII				; Send it to YM2612
		inc	de								; Advance pointer
		inc	hl								; Advance pointer
		djnz	.loop						; Loop

		pop	de								; Restore de
		ret
; End of function zSendTL

; =============== S U B	R O U T	I N E =======================================
; Prevents next note from attacking.
;
; Has no parameter bytes.
;
;loc_CDB
cfPreventAttack:
		set	1, (ix+zTrack.PlaybackControl)	; Set flag to prevent attack
		dec	de								; Put parameter byte back
		ret

; =============== S U B	R O U T	I N E =======================================
; Sets the note fill.
;
; Has one parameter byte, the new note fill. This value is multiplied by the
; tempo divider, and so may overflow.
;
;loc_CE1
cfNoteFill:
		call	zComputeNoteDuration		; Multiply note fill by tempo divider
		ld	(ix+zTrack.NoteFillTimeout), a	; Store result into note fill timeout
		ld	(ix+zTrack.NoteFillMaster), a	; Store master copy of note fill
		ret

; =============== S U B	R O U T	I N E =======================================
; Jump timeout. Shares the same loop counters as coord. flag 0E7h, so it has
; to be coordinated with these. Each time this coord. flag is encountered, it
; tests if the associated loop counter is 1. If it is, it will jump to the
; target location and the loop counter will be set to zero; otherwise, nothing
; happens.
;
; Has 3 parameter bytes: a loop counter index (identical to that of coord. flag
; 0E7h), and a 2-byte jump target.
;
;loc_CEB
cfConditionalJump:
		inc	de								; Advance track pointer
		add	a, zTrack.LoopCounters			; Add offset into loop counters
		ld	c, a							; c = offset of current loop counter
		ld	b, 0							; bc = sign-extended offset to current loop counter
		push	ix							; Save track RAM pointer
		pop	hl								; hl = pointer to track RAM
		add	hl, bc							; hl = pointer in RAM to current loop counter
		ld	a, (hl)							; a = value of current loop counter
		dec	a								; Decrement loop counter (note: value is not saved!)
		jp	z, .do_jump						; Branch if result is zero
		inc	de								; Skip another byte
		ret
; ---------------------------------------------------------------------------
.do_jump:
		xor	a								; a = 0
		ld	(hl), a							; Clear loop counter
		jp	cfJumpTo

; =============== S U B	R O U T	I N E =======================================
; Change PSG volume. Has no effect on FM or DAC channels.
;
; Has one parameter byte, the change in volume. The value is signed, but any
; result greater than 0Fh (or lower than 0) will result in no output.
;
;loc_D01
cfChangePSGVolume:
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG channel?
		ret	z								; Return if not
		res	4, (ix+zTrack.PlaybackControl)	; Clear 'track is resting' flag
		dec	(ix+zTrack.VolEnv)				; Decrement envelope index
		add	a, (ix+zTrack.Volume)			; Add track's current volume
		cp	0Fh								; Is it 0Fh or more?
		jp	c, zStoreTrackVolume			; Branch if not
		ld	a, 0Fh							; Limit to 0Fh (silence)

;loc_D17
zStoreTrackVolume:
		ld	(ix+zTrack.Volume), a			; Store new volume
		ret

; =============== S U B	R O U T	I N E =======================================
; Changes the track's key displacement.
;
; There is a single parameter byte, the new track key offset + 40h (that is,
; 40h is subtracted from the parameter byte before the key displacement is set)
;
;loc_D1B
cfSetKey:
		sub	40h								; Subtract 40h from key displacement
		ld	(ix+zTrack.Transpose), a		; Store result as new transposition
		ret

; =============== S U B	R O U T	I N E =======================================
; Sends an FM command to the YM2612. The command is sent to part I, so not all
; registers can be set using this coord. flag (in particular, channels FM4,
; FM5 and FM6 cannot (in general) be affected).
;
; Has 2 parameter bytes: a 1-byte register selector and a 1-byte register data.
;
;loc_D21
cfSendFMI:
		call	zGetFMParams				; Get parameters for FM command
	if fix_sndbugs
		jp	zWriteFMI						; Send it to YM2612
	else
		call	zWriteFMI					; Send it to YM2612
		ret
	endif

;loc_D28
zGetFMParams:
		ex	de, hl							; Exchange de and hl
		ld	a, (hl)							; Get YM2612 register selector
		inc	hl								; Advance pointer
		ld	c, (hl)							; Get YM2612 register data
		ex	de, hl							; Exchange back de and hl
		ret
; End of function cfSendFMI

; =============== S U B	R O U T	I N E =======================================
; Change current instrument (FM), tone (PSG) or sample (DAC).
;
; Has either a single positive parameter byte or a pair of parameter bytes of
; which the first is negative.
;
; If positive, the first parameter byte is the index of voice to use.
;
; If negative, and on a PSG track, then the first parameter byte is the index
; of voice to use while the second parameter byte is ignored.
;
; If negative and on a FM or DAC track, the first parameter byte is 80h + index
; of voice to use, while the second parameter byte is 7Fh + index of song whose
; voice bank is to be used (here, the AIZ1 song is index 1, not zero).
;
; The uploading of an FM instrument is irrelevant for the DAC.
;
;loc_D2E
cfSetVoice:
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG track?
		jr	nz, zSetVoicePSG				; Branch if yes
		call	zSetMaxRelRate				; Set minimum D1L/RR for channel
		ld	a, (de)							; Get voice index
		ld	(ix+zTrack.VoiceIndex), a		; Store to track RAM
		or	a								; Is it negative?
		jp	p, zSetVoiceUpload				; Branch if not
		inc	de								; Advance pointer
		ld	a, (de)							; Get song ID whose bank is desired
		ld	(ix+zTrack.VoiceSongID), a		; Store to track RAM and fall-through

; =============== S U B	R O U T	I N E =======================================
; Uploads the FM instrument from another song's voice bank.
;
;sub_D44
zSetVoiceUploadAlter:
		push	de							; Save de
		ld	a, (ix+zTrack.VoiceSongID)		; Get saved song ID for instrument data
		sub	81h								; Convert it to a zero-based index
		ld	c, zID_MusicPointers			; Value for music pointer table
		rst	GetPointerTable					; hl = pointer to music pointer table
		rst	PointerTableOffset				; hl = pointer to music data
		rst	ReadPointer						; hl = pointer to music voice data
		ld	a, (ix+zTrack.VoiceIndex)		; Get voice index
		and	7Fh								; Strip sign bit
		ld	b, a							; b = voice index
		call	zGetFMInstrumentOffset		; hl = pointer to voice data
		jr	zSetVoiceDoUpload
; ---------------------------------------------------------------------------
;loc_D5A
zSetVoiceUpload:
		push	de							; Save de
		ld	b, a							; b = instrument index
		call	zGetFMInstrumentPointer		; hl = pointer to instrument data

zSetVoiceDoUpload:
		call	zSendFMInstrument			; Upload instrument data to YM2612
		pop	de								; Restore de
		ret
; End of function cfSetVoice
; ---------------------------------------------------------------------------
;loc_D64:
zSetVoicePSG:
		or	a								; Is the voice index positive?
		jp	p, cfStoreNewVoice				; Branch if yes
		inc	de								; Otherwise, advance song data pointer
		jp	cfStoreNewVoice
; ---------------------------------------------------------------------------
	if fix_sndbugs=0
		ret									; Dead code
	endif

; =============== S U B	R O U T	I N E =======================================
; Turns on modulation on the channel.
;
; Has four 1-byte parameters: delay before modulation starts, modulation speed,
; modulation change per step, number of steps in modulation.
;
;loc_D6D
cfModulation:
		ld	(ix+zTrack.ModulationPtrLow), e		; Store low byte of modulation data pointer
		ld	(ix+zTrack.ModulationPtrHigh), d	; Store high byte of modulation data pointer
		ld	(ix+zTrack.ModulationCtrl), 80h	; Toggle modulation on
		inc	de								; Advance pointer...
		inc	de								; ... again...
		inc	de								; ... and again.
		ret

; =============== S U B	R O U T	I N E =======================================
; Sets modulation status according to parameter bytes.
;
; Has 2 1-byte parameters: the first byte is the new modulation state for PSG
; tracks, while the second byte is the new modulation state for FM tracks.
;
;loc_D7B
cfAlterModulation:
		inc	de								; Advance track pointer
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG track?
		jr	nz, cfSetModulation				; Branch if yes
		ld	a, (de)							; Get new modulation status

; =============== S U B	R O U T	I N E =======================================
; Sets modulation status.
;
; Has one parameter byte, the new modulation status.
;
;loc_D83
cfSetModulation:
		ld	(ix+zTrack.ModulationCtrl), a	; Set modulation status
		ret

; =============== S U B	R O U T	I N E =======================================
; Stops the current track.
;
; Technically, it has a parameter byte, but it is irrelevant and unused.
;
;loc_D87
cfStopTrack:
		res	7, (ix+zTrack.PlaybackControl)	; Clear 'track playing' flag
	if fix_sndbugs=0
		ld	a, 1Fh							; a = 1Fh
		ld	(unk_1C15), a					; Set otherwise unused location to 1Fh
	endif
		call	zKeyOffIfActive				; Send key off for track channel
		ld	c, (ix+zTrack.VoiceControl)		; c = voice control bits
		push	ix							; Save track pointer
		call	zGetSFXChannelPointers		; ix = track pointer, hl = overridden track pointer
		ld	a, (zUpdatingSFX)				; Get flag
		or	a								; Are we updating SFX?
		jp	z, zStopCleanExit				; Exit if not
	if fix_sndbugs=0
		xor	a								; a = 0
		ld	(unk_1C18), a					; Set otherwise unused value to zero
	endif
		push	hl							; Save hl
		ld	hl, (zVoiceTblPtr)				; hl = pointer to voice table
		pop	ix								; ix = overridden track's pointer
		res	2, (ix+zTrack.PlaybackControl)	; Clear 'SFX is overriding' bit
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG channel?
		jr	nz, zStopPSGTrack				; Branch if yes
		bit	7, (ix+zTrack.PlaybackControl)	; Is 'track playing' bit set?
		jr	z, zStopCleanExit				; Exit if not
		ld	a, 2							; a = 2 (FM3)
		cp	(ix+zTrack.VoiceControl)		; Is this track for FM3?
		jr	nz, .not_fm3					; Branch if not
		ld	a, 4Fh							; FM3 settings: special mode, enable and load A/B
		bit	0, (ix+zTrack.PlaybackControl)	; Is FM3 in special mode?
		jr	nz, .do_fm3_settings			; Branch if yes
		and	0Fh								; FM3 settings: normal mode, enable and load A/B

.do_fm3_settings:
		call	zWriteFM3Settings			; Set the above FM3 settings

.not_fm3:
		ld	a, (ix+zTrack.VoiceIndex)		; Get FM instrument
		or	a								; Is it positive?
		jp	p, .switch_to_music				; Branch if yes
		call	zSetVoiceUploadAlter		; Upload the voice from another song's voice bank
		jr	.send_ssg_eg
; ---------------------------------------------------------------------------
.switch_to_music:
		ld	b, a							; b = FM instrument
		push	hl							; Save hl
		bankswitchToMusic					; Bank switch to song bank
		pop	hl								; Restore hl
		call	zGetFMInstrumentOffset		; hl = pointer to instrument data
		call	zSendFMInstrument			; Send FM instrument
		ld	a, zmake68kBank(SndBank)		; Get SFX bank
		bankswitch2							; Bank switch to it
		ld	a, (ix+zTrack.HaveSSGEGFlag)	; Get custom SSG-EG flag
		or	a								; Does track have custom SSG-EG data?
		jp	p, zStopCleanExit				; Exit if not
		ld	e, (ix+zTrack.SSGEGPointerLow)	; e = low byte of pointer to SSG-EG data
		ld	d, (ix+zTrack.SSGEGPointerHigh)	; d = high byte of pointer to SSG-EG data

.send_ssg_eg:
		call	zSendSSGEGData				; Upload custom SSG-EG data

;loc_E22
zStopCleanExit:
		pop	ix								; Restore ix
		pop	hl								; Pop return value from stack
		pop	hl								; Pop another return value from stack
		ret
; ---------------------------------------------------------------------------
;loc_E27
zStopPSGTrack:
		bit	0, (ix+zTrack.PlaybackControl)	; Is this a noise channel?
		jr	z, zStopCleanExit				; Exit if not
		ld	a, (ix+zTrack.PSGNoise)			; Get track's PSG noise setting
		or	a								; Is it an actual noise?
		jp	p, .skip_command				; Branch if not
		ld	(zPSG), a						; Send it to PSG

.skip_command:
		jr	zStopCleanExit

; =============== S U B	R O U T	I N E =======================================
; Change PSG noise to parameter, and silences PSG3 channel.
;
; Has one parameter byte: if zero, the channel is changed back to a normal PSG
; channel and the noise is silenced; if non-zero, it must be in the 0E0h-0E7h
; range, and sets the noise type to use (and sets the channel as being a noise
; channel).
;
;loc_E39
cfSetPSGNoise:
	if fix_sndbugs
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG track?
		ret	z								; Return if not
		ld	(ix+zTrack.PSGNoise), a			; Store to track RAM
		set	0, (ix+zTrack.PlaybackControl)	; Mark PSG track as being noise
		or	a								; Test noise value
		ld	a, 0DFh							; Command to silence PSG3
		jr	nz, .skip_noise_silence			; If nonzero, branch
		res	0, (ix+zTrack.PlaybackControl)	; Otherwise, mark track as not being a noise channel
		ld	a, 0FFh							; Command to silence the noise channel

.skip_noise_silence:
		bit	2, (ix+zTrack.PlaybackControl)	; Is SFX overriding this track?
		ret	nz								; Return if yes
		ld	(zPSG), a						; Execute it
		ld	a, (de)							; Get PSG noise value
		ld	(zPSG), a						; Send command to PSG
	else
		bit	2, (ix+zTrack.VoiceControl)		; Is this a channel bound for part II (FM4, FM5, FM6/DAC)?
		ret	nz								; Return if yes
		ld	a, 0DFh							; Command to silence PSG3
		ld	(zPSG), a						; Execute it
		ld	a, (de)							; Get PSG noise value
		ld	(ix+zTrack.PSGNoise), a			; Store to track RAM
		set	0, (ix+zTrack.PlaybackControl)	; Mark PSG track as being noise
		or	a								; Test noise value
		jr	nz, .skip_noise_silence					; If nonzero, branch
		res	0, (ix+zTrack.PlaybackControl)	; Otherwise, mark track as not being a noise channel
		ld	a, 0FFh							; Command to silence the noise channel
.skip_noise_silence:
		ld	(zPSG), a						; Send command to PSG
	endif
		ret

; =============== S U B	R O U T	I N E =======================================
; Set PSG tone.
;
; Has one parameter byte, the new PSG tone to use.
;
;loc_E58
;cfSetPSGTone
cfSetPSGVolEnv:
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG track?
		ret	z								; Return if not

;loc_E5D
cfStoreNewVoice:
		ld	(ix+zTrack.VoiceIndex), a		; Store voice
		ret

; =============== S U B	R O U T	I N E =======================================
; Jump to specified location.
;
; Has a 2-byte parameter, indicating target location for jump.
;
;loc_E61
cfJumpTo:
		ex	de, hl							; Exchange de and hl
		ld	e, (hl)							; e = low byte of target location
		inc	hl								; Advance pointer
		ld	d, (hl)							; d = high byte of target location
		dec	de								; Put destination byte back
		ret

; =============== S U B	R O U T	I N E =======================================
; Loop section of music.
;
; Has four parameter bytes: a loop counter index (exactly like coord. flag 0EBh),
; a repeat count, and a 2-byte jump target.
;
;loc_E67
cfRepeatAtPos:
		inc	de								; Advance track pointer
		add	a, zTrack.LoopCounters			; Add offset into loop counters
		ld	c, a							; c = offset of current loop counter
		ld	b, 0							; bc = sign-extended offset to current loop counter
		push	ix							; Save track RAM pointer
		pop	hl								; hl = pointer to track RAM
		add	hl, bc							; hl = pointer in RAM to current loop counter
		ld	a, (hl)							; a = value of current loop counter
		or	a								; Is loop counter zero?
		jr	nz, .run_counter				; Branch if not
		ld	a, (de)							; Get repeat counter
		ld	(hl), a							; Reset loop counter to it

.run_counter:
		inc	de								; Advance track pointer
		dec	(hl)							; Decrement loop counter
		jp	nz, cfJumpTo					; Loop if it is nonzero
		inc	de								; Advance track pointer
		ret

; =============== S U B	R O U T	I N E =======================================
; Call subroutine. Stores current location on track-specific stack so that
; coord. flag 0F9h can be used to return to current location.
;
; Has one 2-byte parameter, the target subroutine's address.
;
;loc_E7E
cfJumpToGosub:
		ld	c, a							; c = low byte of target address
		inc	de								; Advance track pointer
		ld	a, (de)							; a = high byte of target address
		ld	b, a							; bc = target address
		push	bc							; Save bc
		push	ix							; Save ix
		pop	hl								; hl = pointer to track RAM
		dec	(ix+zTrack.StackPointer)		; Decrement track stack pointer
		ld	c, (ix+zTrack.StackPointer)		; c = track stack pointer
		dec	(ix+zTrack.StackPointer)		; Decrement track stack pointer again
		ld	b, 0							; b = 0
		add	hl, bc							; hl = offset of high byte of return address
		ld	(hl), d							; Store high byte of return address
		dec	hl								; Move pointer to target location
		ld	(hl), e							; Store low byte of return address
		pop	de								; de = jump target address
		dec	de								; Put back the byte
		ret

; =============== S U B	R O U T	I N E =======================================
; Returns from subroutine call. Does NOT check for stack overflows!
;
; Has no parameter bytes.
;
;loc_E98
cfJumpReturn:
		push	ix							; Save track RAM address
		pop	hl								; hl = pointer to track RAM
		ld	c, (ix+zTrack.StackPointer)		; c = offset to top of return stack
		ld	b, 0							; b = 0
		add	hl, bc							; hl = pointer to top of return stack
		ld	e, (hl)							; e = low byte of return address
		inc	hl								; Advance pointer
		ld	d, (hl)							; de = return address
		inc	(ix+zTrack.StackPointer)		; Pop byte from return stack
		inc	(ix+zTrack.StackPointer)		; Pop byte from return stack
		ret

; =============== S U B	R O U T	I N E =======================================
; Clears sign bit of modulation control, disabling normal modulation.
;
; Has no parameter bytes.
;
;loc_EAB
cfDisableModulation:
		res	7, (ix+zTrack.ModulationCtrl)	; Clear bit 7 of modulation control
		dec	de								; Put byte back
		ret

; =============== S U B	R O U T	I N E =======================================
; Adds a signed value to channel key displacement.
;
; Has one parameter byte, the change in channel key displacement.
;
;loc_EB1 cfAddKey
cfChangeTransposition:
		add	a, (ix+zTrack.Transpose)		; Add current transposition to parameter
		ld	(ix+zTrack.Transpose), a		; Store result as new transposition
		ret

; =============== S U B	R O U T	I N E =======================================
; If a continuous SFX is playing, it will continue playing from target address.
; A loop counter is decremented (it is initialized to number of SFX tracks)
; for continuous SFX; if the result is zero, the continuous SFX will be flagged
; to stop.
; Non-continuous SFX do not loop.
;
; Has a 2-byte parameter, the jump target address.
;
;loc_EB8
cfLoopContinuousSFX:
		ld	a, (zContinuousSFXFlag)			; Get 'continuous sound effect' flag
		cp	80h								; Is it equal to 80h?
		jp	z, .run_counter					; Branch if yes
		xor	a								; a = 0
		ld	(zContinuousSFX), a				; Clear last continuous SFX played
	if fix_sndbugs=0
		ld	(zContinuousSFXFlag), a			; Clear continuous sound effect flag (redundant; zContinuousSFXFlag will always be 0 at this point)
	endif
		inc	de								; Skip a byte
		ret
; ---------------------------------------------------------------------------
.run_counter:
	if fix_sndbugs
		ld	hl, zContSFXLoopCnt				; Get number loops to perform
		dec	(hl)							; Decrement it...
	else
		ld	a, (zContSFXLoopCnt)			; Get number loops to perform
		dec	a								; Decrement it...
		ld	(zContSFXLoopCnt), a			; ... and store it back
	endif
		jp	nz, cfJumpTo					; If result is non-zero, jump to target address
		xor	a								; a = 0
		ld	(zContinuousSFXFlag), a			; Clear continuous sound effect flag
		jp	cfJumpTo						; Jump to target address

; =============== S U B	R O U T	I N E =======================================
; Toggles alternate frequency mode according to parameter.
;
; Has a single byte parameter: is 1, enables alternate frequency mode, otherwise
; disables it.
;
;loc_EDA
;cfToggleAlternateSMPS
cfToggleAltFreqMode:
	if fix_sndbugs
		or	a								; Is parameter equal to 0?
		jr	z, .stop_altfreq_mode			; Branch if so
	else
		cp	1								; Is parameter equal to 1?
		jr	nz, .stop_altfreq_mode			; Branch if not
	endif
		set	3, (ix+zTrack.PlaybackControl)	; Start alternate frequency mode for track
		ret
; ---------------------------------------------------------------------------
.stop_altfreq_mode:
		res	3, (ix+zTrack.PlaybackControl)	; Stop alternate frequency mode for track
		ret

; =============== S U B	R O U T	I N E =======================================
; If current track is FM3, it is put into special mode. The function is weird,
; and may not work correctly (subject to verification).
;
; It has 4 1-byte parameters: all of them are indexes into a lookup table of
; unknown purpose, and must be in the 0-7 range. It is possible that this
; lookup table held frequencies (or frequency shifts) for FM3 and its operators
; in special mode.
;
;loc_EE8
cfFM3SpecialMode:
		ld	a, (ix+zTrack.VoiceControl)		; Get track's voice control
		cp	2								; Is this FM3?
		jr	nz, zTrackSkip3bytes			; Branch if not
		set	0, (ix+zTrack.PlaybackControl)	; Put FM3 in special mode
		ex	de, hl							; Exchange de and hl
		call	zGetSpecialFM3DataPointer	; de = pointer to saved FM3 frequency shifts
		ld	b, 4							; Loop counter: 4 parameter bytes

		; DANGER! The following code will trash the Z80 code due to failed
		; initialization of de. At the start of the function, hl was a pointer
		; to the coord. flag switch table entry that had the address of this
		; function; after 'ex	de, hl', now de is this pointer.
		; After the code below, the targets of the last few coord. flag handlers
		; will be overwritten by the nonsensical numbers at the lookup table.
.loop:
		push	bc							; Save bc
		ld	a, (hl)							; Get parameter byte
		inc	hl								; Advance pointer
		push	hl							; Save hl
		ld	hl, zFM3FreqShiftTable			; hl = pointer to lookup table
		add	a, a							; Multiply a by 2
		ld	c, a							; c = a
		ld	b, 0							; b = 0
		add	hl, bc							; hl = offset into lookup table
		ldi									; *de++ = *hl++
		ldi									; *de++ = *hl++
		pop	hl								; Restore hl
		pop	bc								; Restore bc
		djnz	.loop						; Loop for all parameters

		ex	de, hl							; Exchange back de and hl
		dec	de								; Put back last byte
		ld	a, 4Fh							; FM3 settings: special mode, enable and load A/B

; =============== S U B	R O U T	I N E =======================================
; Set up FM3 special settings
;
; Input:   a    Settings for FM3
; Output:  c    Damaged
;sub_F11
zWriteFM3Settings:
	if fix_sndbugs=0
		ld	(zFM3Settings), a				; Save FM3 settings
	endif
		ld	c, a							; c = FM3 settings
		ld	a, 27h							; Write data to FM3 settings register
	if fix_sndbugs
		jp	zWriteFMI						; Do it
	else
		call	zWriteFMI					; Do it
		ret
	endif
; End of function zWriteFM3Settings

; =============== S U B	R O U T	I N E =======================================
; Eats 3 bytes from the song.
zTrackSkip3bytes:
		inc	de								; Advance pointer...
		inc	de								; ... again...
		inc	de								; ... and again.
		ret
; ---------------------------------------------------------------------------
; Frequency shift data used in cfFM3SpecialMode, above. That function, as well
; as zFMSendFreq, use invalid addresses for read and write (respectively), so
; that this data is improperly used.
;loc_F1F
zFM3FreqShiftTable:
		dw    0, 132h, 18Eh, 1E4h, 234h, 27Eh, 2C2h, 2F0h

; =============== S U B	R O U T	I N E =======================================
; Meta coordination flag: the first parameter byte is an index into an extra
; coord. flag handler table.
;
; Has at least one parameter byte, the index into the jump table.
;
;loc_F2F
cfMetaCF:
		ld	hl, zExtraCoordFlagSwitchTable	; Load extra coordination flag switch table
		rst	PointerTableOffset				; hl = jump target for parameter
		inc	de								; Advance track pointer
		ld	a, (de)							; Get another parameter byte
		jp	(hl)							; Jump to coordination flag handler

; =============== S U B	R O U T	I N E =======================================
; Sets current tempo to parameter byte.
;
; Has one parameter byte, the new value for current tempo.
;
;loc_F36
cfSetTempo:
		ld	(zCurrentTempo), a				; Set current tempo to parameter
		ret

; =============== S U B	R O U T	I N E =======================================
; Plays another song or SFX.
;
; Has one parameter byte, the ID of what is to be played.
;
; DO NOT USE THIS TO PLAY THE SEGA PCM! It tampers with the stack pointer, and
; will wreak havok with the track update.
;
;loc_F3A:
cfPlaySoundByIndex:
		push	ix							; Save track pointer
		call	zPlaySoundByIndex			; Play sound specified by parameter
		pop	ix								; Restore track pointer
		ret

; =============== S U B	R O U T	I N E =======================================
; Halts or resumes all tracks according to parameter.
;
; Has one parameter byte, which is zero to resume all tracks and non-zero to
; halt them.
;
;loc_F42
cfHaltSound:
		ld	(zHaltFlag), a					; Set new mute flag
		or	a								; Is it set now?
		jr	z, .resume						; Branch if not
		push	ix							; Save ix
		push	de							; Save de
		ld	ix, zTracksStart				; Start of song RAM
		ld	b, (zTracksEnd-zTracksStart)/zTrack.len	; Number of tracks
		ld	de, zTrack.len					; Spacing between tracks

.loop1:
		res	7, (ix+zTrack.PlaybackControl)	; Clear 'track is playing' bit
		call	zKeyOff						; Stop current note
		add	ix, de							; Advance to next track
		djnz	.loop1						; Loop for all tracks
		pop	de								; Restore de
		pop	ix								; Restore ix
		jp	zPSGSilenceAll
; ---------------------------------------------------------------------------
.resume:
		push	ix							; Save ix
		push	de							; Save de
		ld	ix, zTracksStart				; Start of song RAM
		ld	b, (zTracksEnd-zTracksStart)/zTrack.len	; Number of tracks
		ld	de, zTrack.len					; Spacing between tracks

.loop2:
		set	7, (ix+zTrack.PlaybackControl)	; Set 'track is playing' bit
		add	ix, de							; Advance to next track
		djnz	.loop2						; Loop for all tracks
		pop	de								; Restore de
		pop	ix								; Restore ix
		ret

; =============== S U B	R O U T	I N E =======================================
; Copies data from selected location to current track. Playback will continue
; after the last byte copied.
;
; Has 3 parameter bytes, a 2-byte pointer to data to be copied and a 1-byte
; number of bytes to copy. The data is copied to the track's byte stream,
; starting after the parameters of this coord. flag, and will overwrite the data
; that what was there before. This likely will not work unless the song/SFX was
; copied to Z80 RAM in the first place.
;
;loc_F7D
cfCopyData:
		ex	de, hl							; Exchange de and hl
		ld	e, (hl)							; e = low byte of pointer to new song data
		inc	hl								; Advance track pointer
		ld	d, (hl)							; d = high byte of pointer to new song data
		inc	hl								; Advance track pointer
		ld	c, (hl)							; c = number of bytes to copy
		ld	b, 0							; b = 0
		inc	hl								; Advance track pointer
		ex	de, hl							; Exchange back de and hl
		ldir								; while (bc-- > 0) *de++ = *hl++;
		dec	de								; Put back last byte
		ret

; =============== S U B	R O U T	I N E =======================================
; Sets tempo divider for all tracks. Does not take effect until the next note
; duration is set.
;
; Has one parameter, the new tempo divider.
;
;loc_F8B
cfSetTempoDivider:
		ld	b, (zTracksEnd-zTracksStart)/zTrack.len	; Number of tracks
		ld	hl, zTracksStart+zTrack.TempoDivider	; Want to change tempo dividers

.loop:
		push	bc							; Save bc
		ld	bc, zTrack.len					; Spacing between tracks
		ld	(hl), a							; Set tempo divider for track
		add	hl, bc							; Advance to next track
		pop	bc								; Restore bc
		djnz	.loop
		ret

; =============== S U B	R O U T	I N E =======================================
; Sets SSG-EG data for current track.
;
; Has 4 parameter bytes, the operator parameters for SSG-EG data desired.
;
;loc_F9A
cfSetSSGEG:
		ld	(ix+zTrack.HaveSSGEGFlag), 80h	; Set custom SSG-EG data flag
		ld	(ix+zTrack.SSGEGPointerLow), e	; Save low byte of SSG-EG data pointer
		ld	(ix+zTrack.SSGEGPointerHigh), d	; Save high byte of SSG-EG data pointer

; =============== S U B	R O U T	I N E =======================================
; Sends SSG-EG data pointed to by de to appropriate registers in YM2612.
;
;sub_FA4
zSendSSGEGData:
		; DANGER! The following code ignores the fact that SSG-EG mode must be
		; used with maximum (1Fh) attack rate or output is officially undefined.
		; This has the potential effect of weird sound, even in real hardware.
	if fix_sndbugs
		; This fix is even better than what is done in Ristar's sound driver:
		; we preserve rate scaling, whereas that driver sets it to 0.
		ld	l, (ix+zTrack.TLPtrLow)			; l = low byte of pointer to TL data
		ld	h, (ix+zTrack.TLPtrHigh)		; hl = pointer to TL data
		ld	bc, zFMInstrumentTLTable-zFMInstrumentRSARTable		; bc = -10h
		add	hl, bc							; hl = pointer to RS/AR data
		push	hl							; Save hl (**)
	endif
		ld	hl, zFMInstrumentSSGEGTable		; hl = pointer to registers for SSG-EG data
		ld	b, zFMInstrumentSSGEGTable_End-zFMInstrumentSSGEGTable	; Number of entries

.loop:
		ld	a, (de)							; Get data to sent to SSG-EG register
		inc	de								; Advance pointer
		ld	c, a							; c = data to send
		ld	a, (hl)							; a = register to send to
	if fix_sndbugs
		call	zWriteFMIorII				; Send data to correct channel
		ex	(sp), hl						; Save hl, hl = pointer to RS/AR data (see line marked (**) above)
		ld	a, (hl)							; a = RS/AR value for operator
		inc	hl								; Advance pointer
		ex	(sp), hl						; Save hl, hl = pointer to registers for SSG-EG data
		or	1Fh								; Set AR to maximum, but keep RS intact
		ld	c, a							; c = RS/AR
		ld	a, (hl)							; a = register to send to
		sub	40h								; Convert into command to set RS/AR
	endif
		inc	hl								; Advance pointer
		call	zWriteFMIorII				; Send data to correct channel
		djnz	.loop						; Loop for all registers
	if fix_sndbugs
		pop	hl								; Remove from stack (see line marked (**) above)
	endif
		dec	de								; Rewind data pointer a bit
		ret
; End of function zSendSSGEGData

; =============== S U B	R O U T	I N E =======================================
; Starts or controls FM volume envelope effects, according to the parameters.
;
; Has two parameter bytes: the first is a (1-based) index into the PSG envelope
; table indicating how the envelope should go, while the second is a bitmask
; indicating which operators should be affected (in the form %00004231) for
; the current channel.
;
;loc_FB5
;cfFMFlutter
cfFMVolEnv:
		ld	(ix+zTrack.FMVolEnv), a			; Store envelope index
		inc	de								; Advance track pointer
		ld	a, (de)							; Get envelope mask
		ld	(ix+zTrack.FMVolEnvMask), a		; Store envelope bitmask
		ret

; =============== S U B	R O U T	I N E =======================================
; Resets spindash rev counter.
;
; Has no parameter bytes.
;
;loc_FBE
cfResetSpindashRev:
		xor	a								; a = 0
		ld	(zSpindashRev), a				; Reset spindash rev
		dec	de								; Put byte back
		ret

; =============== S U B	R O U T	I N E =======================================
; Updates a PSG track.
;
; Input:   ix    Pointer to track RAM
;
;loc_FC4
zUpdatePSGTrack:
	if fix_sndbugs
		dec	(ix+zTrack.DurationTimeout)		; Run note timer
	else
		call	zTrackRunTimer				; Run note timer
	endif
		jr	nz, .note_going					; Branch if note hasn't expired yet
		call	zGetNextNote				; Get next note for PSG track
		bit	4, (ix+zTrack.PlaybackControl)	; Is track resting?
		ret	nz								; Return if yes
		call	zPrepareModulation			; Initialize modulation
		jr	.skip_fill
; ---------------------------------------------------------------------------
.note_going:
		ld	a, (ix+zTrack.NoteFillTimeout)	; Get note fill
		or	a								; Has timeout expired?
		jr	z, .skip_fill					; Branch if yes
		dec	(ix+zTrack.NoteFillTimeout)		; Update note fill
		jp	z, zRestTrack					; Put PSG track at rest if needed

.skip_fill:
		call	zUpdateFreq					; Add frequency displacement to frequency
		call	zDoModulation				; Do modulation
		bit	2, (ix+zTrack.PlaybackControl)	; Is SFX overriding this track?
		ret	nz								; Return if yes
		ld	c, (ix+zTrack.VoiceControl)		; c = voice control byte
		ld	a, l							; a = low byte of new frequency
		and	0Fh								; Get only lower nibble
		or	c								; OR in PSG channel bits
		ld	(zPSG), a						; Send to PSG, latching register
		ld	a, l							; a = low byte of new frequency
		and	0F0h							; Get high nibble now
		or	h								; OR in the high byte of the new frequency
		; Swap nibbles
		rrca
		rrca
		rrca
		rrca
		ld	(zPSG), a						; Send to PSG, to latched register
		ld	a, (ix+zTrack.VoiceIndex)		; Get PSG tone
		or	a								; Test if it is zero
		ld	c, 0							; c = 0
		jr	z, .no_volenv					; Branch if no PSG tone
		dec	a								; Make it into a 0-based index
		ld	c, zID_VolEnvPointers			; Value for volume envelope pointer table
		rst	GetPointerTable					; hl = pointer to volume envelope table
		rst	PointerTableOffset				; hl = pointer to volume envelope for track
		call	zDoVolEnv					; Get new volume envelope
		ld	c, a							; c = new volume envelope

.no_volenv:
		bit	4, (ix+zTrack.PlaybackControl)	; Is track resting?
		ret	nz								; Return if yes
		ld	a, (ix+zTrack.Volume)			; Get track volume
		add	a, c							; Add volume envelope to it
		bit	4, a							; Is bit 4 set?
		jr	z, .no_underflow				; Branch if not
		ld	a, 0Fh							; Set silence on PSG track

.no_underflow:
		or	(ix+zTrack.VoiceControl)		; Mask in the PSG channel bits
		add	a, 10h							; Flag to latch volume
		bit	0, (ix+zTrack.PlaybackControl)	; Is this a noise channel?
	if fix_sndbugs
		jr	z, .not_noise					; Branch if not
		add	a, 20h							; Change to noise channel
.not_noise:
		ld	(zPSG), a						; Set noise channel volume
		ret
	else
		jr	nz, .set_noise					; Branch if yes
		ld	(zPSG), a						; Set PSG volume
		ret
; ---------------------------------------------------------------------------
.set_noise:
		add	a, 20h							; Change to noise channel
		ld	(zPSG), a						; Set noise channel volume
		ret
	endif
; ---------------------------------------------------------------------------
;loc_1037
;zDoFlutterSetValue
zDoVolEnvSetValue:
		ld	(ix+zTrack.VolEnv), a			; Set new value for PSG envelope index and fall through

; =============== S U B	R O U T	I N E =======================================
; Get next PSG volume envelope value.
;
; Input:   ix    Pointer to track RAM
;          hl    Pointer to current PSG volume envelope
; Output:  a     New volume envelope value
;          bc    Trashed
;
;sub_103A
;zDoFlutter
zDoVolEnv:
		push	hl							; Save hl
		ld	c, (ix+zTrack.VolEnv)			; Get current PSG envelope index
		ld	b, 0							; b = 0
		add	hl, bc							; Offset into PSG envelope table
	if fix_sndbugs
		; Fix based on similar code from Space Harrier II's sound driver.
		; This fixes the "DANGER!" bug below. This is better than the
		; previous fix, which was based on Ristar's driver.
		ld	c, l
		ld	b, h
		ld	a, (bc)							; a = PSG volume envelope
	else
		ld	a, (hl)							; a = PSG flutter value
	endif
		pop	hl								; Restore hl
		bit	7, a							; Is it a terminator?
		jr	z, zDoVolEnvAdvance				; Branch if not
		cp	83h								; Is it a command to put PSG channel to rest?
		jr	z, zDoVolEnvFullRest			; Branch if yes
		cp	81h								; Is it a command to set rest flag on PSG channel?
		jr	z, zDoVolEnvRest				; Branch if yes
		cp	80h								; Is it a command to reset envelope?
		jr	z, zDoVolEnvReset				; Branch if yes

		inc	bc								; Increment envelope index
		; DANGER! Will read data from code segment and use it as if it were valid!
		; In order to get here, the flutter value would have to be:
		; (1) negative;
		; (2) not 80h, 81h or 83h.
		; VolEnv_0A contains such a value, but luckily isn't used by any songs or sounds.
		ld	a, (bc)							; Get value from wherever the hell bc is pointing to
		jr	zDoVolEnvSetValue				; Use this as new envelope index
; ---------------------------------------------------------------------------
;loc_1057
;zDoFlutterFullRest
zDoVolEnvFullRest:
	if fix_sndbugs=0
		set	4, (ix+zTrack.PlaybackControl)	; Set 'track is resting' bit (zRestTrack already does this)
	endif
		pop	hl								; Pop return value from stack (causes a 'ret' to return to caller of zUpdatePSGTrack)
		jp	zRestTrack						; Put track at rest
; ---------------------------------------------------------------------------
;loc_105F
;zDoFlutterReset
zDoVolEnvReset:
		xor	a								; a = 0
		jr	zDoVolEnvSetValue
; ---------------------------------------------------------------------------
;loc_1062
;zDoFlutterRest
zDoVolEnvRest:
		pop	hl								; Pop return value from stack (causes a 'ret' to return to caller of zUpdatePSGTrack)
		set	4, (ix+zTrack.PlaybackControl)	; Set 'track is resting' bit
		ret									; Do NOT silence PSG channel
; ---------------------------------------------------------------------------
;loc_1068
;zDoFlutterAdvance
zDoVolEnvAdvance:
		inc	(ix+zTrack.VolEnv)				; Advance envelope
		ret
; End of function zDoVolEnv


; =============== S U B	R O U T	I N E =======================================
;
;sub_106C
zRestTrack:
		set	4, (ix+zTrack.PlaybackControl)	; Set 'track is resting' bit
		bit	2, (ix+zTrack.PlaybackControl)	; Is SFX overriding this track?
		ret	nz								; Return if so
; End of function zRestTrack


; =============== S U B	R O U T	I N E =======================================
;
;sub_1075
zSilencePSGChannel:
		ld	a, 1Fh							; Set volume to zero on PSG channel
		add	a, (ix+zTrack.VoiceControl)		; Add in the PSG channel selector
		or	a								; Is it an actual PSG channel?
		ret	p								; Return if not
		ld	(zPSG), a						; Silence this channel
	if fix_sndbugs
		cp	0DFh							; Was this PSG3?
		ret	nz								; Return if not
	else
		; This does not work as intended: since this function is called when
		; a new channel is starting, this bit will almost inevitably be 0
		; and the noise channel will not be silenced.
		bit	0, (ix+zTrack.PlaybackControl)	; Is this a noise channel?
		ret	z								; Return if not
	endif
		ld	a, 0FFh							; Command to silence Noise channel
		ld	(zPSG), a						; Do it
		ret
; End of function zSilencePSGChannel


; =============== S U B	R O U T	I N E =======================================
;
; Plays digital audio on the DAC, if any is queued. The z80 will be stuck in
; this function unless an interrupt occurs (that is, V-Int); after the V-Int
; is processed, the z80 will return back here.
;loc_108A
zPlayDigitalAudio:
		di									; Disable interrupts
		ld	a, 2Bh							; DAC enable/disable register
		ld	c, 0							; Value to disable DAC
		call	zWriteFMI					; Send YM2612 command

.dac_idle_loop:
		ei									; Enable interrupts
		ld	a, (PlaySegaPCMFlag)			; a = play SEGA PCM flag
		or	a								; Is SEGA sound being played?
		jp	nz, zPlaySEGAPCM				; Branch if yes
		ld	a, (zDACIndex)					; a = DAC index/flag
		or	a								; Is DAC channel being used?
		jr	z, .dac_idle_loop				; Loop if not
		ld	a, 2Bh							; DAC enable/disable register
		ld	c, 80h							; Value to enable DAC
		di									; Disable interrupts
		call	zWriteFMI					; Send YM2612 command
		ei									; Re-enable interrupts
		ld	iy, DecTable					; iy = pointer to jman2050 decode lookup table
		ld	hl, zDACIndex					; hl = pointer to DAC index/flag
		ld	a, (hl)							; a = DAC index
		dec	a								; a -= 1
		set	7, (hl)							; Set bit 7 to indicate that DAC sample is being played
		ld	hl, zmake68kPtr(DAC_Offsets)					; hl = pointer to ROM window
		rst	PointerTableOffset				; hl = pointer to DAC data
		ld	c, 80h							; c is an accumulator below; this initializes it to 80h
		ld	a, (hl)							; a = DAC rate
		ld	(.sample1_rate+1), a			; Store into following instruction (self-modifying code)
		ld	(.sample2_rate+1), a			; Store into following instruction (self-modifying code)
		inc	hl								; hl = pointer to low byte of DAC sample's length
		ld	e, (hl)							; e = low byte of DAC sample's length
		inc	hl								; hl = pointer to high byte of DAC sample's length
		ld	d, (hl)							; d = high byte of DAC sample's length
		inc	hl								; hl = pointer to low byte of DAC sample's in-bank location
		ld	a, (hl)							; a = low byte of DAC sample's in-bank location
		inc	hl								; hl = pointer to high byte of DAC sample's in-bank location
		ld	h, (hl)							; h = high byte of DAC sample's in-bank location
		ld	l, a							; l = low byte of DAC sample's in-bank location
		; hl is now pointer to DAC data, while de is the DAC sample's length

.dac_playback_loop:
.sample1_rate:
		ld	b, 0Ah							; self-modified code; b is set to DAC rate
		ei									; Enable interrupts
		djnz	$							; Loop in this instruction, decrementing b each iteration, until b = 0

		di									; Disable interrupts
		ld	a, 2Ah							; DAC channel register
		ld	(zYM2612_A0), a					; Send to YM2612
		ld	a, (hl)							; a = next byte of DAC sample
		; Want only the high nibble now, so shift it into position
		rlca
		rlca
		rlca
		rlca
		and	0Fh								; Get only low nibble (which was the high nibble originally)
		ld	(.sample1_index+2), a			; Store into following instruction (self-modifying code)
		ld	a, c							; a = c

.sample1_index:
		add	a, (iy+0)						; Self-modified code: the index offset is not zero, but what was set above
		ld	(zYM2612_D0), a					; Send byte to DAC
		ld	c, a							; Set c to the new value of a

.sample2_rate:
		ld	b, 0Ah							; self-modified code; b is set to DAC rate
		ei									; Enable interrupts
		djnz	$							; Loop in this instruction, decrementing b each iteration, until b = 0

		di									; Disable interrupts
		ld	a, 2Ah							; DAC channel register
		ld	(zYM2612_A0), a					; Send to YM2612
		ld	a, (hl)							; a = next byte of DAC sample
		and	0Fh								; Want only the low nibble
		ld	(.sample2_index+2), a			; Store into following instruction (self-modifying code)
		ld	a, c							; a = c

.sample2_index:
		add	a, (iy+0)						; Self-modified code: the index offset is not zero, but what was set above
		ld	(zYM2612_D0), a					; Send byte to DAC
		ei									; Enable interrupts
		ld	c, a							; Set c to the new value of a
		ld	a, (zDACIndex)					; a = DAC index/flag
		or	a								; Is playing flag set?
		jp	p, .dac_idle_loop				; Branch if not

		inc	hl								; Advance to next sample byte
		dec	de								; Mark one byte as being done
		ld	a, d							; a = d
		or	e								; Is length zero?
		jp	nz, .dac_playback_loop			; Loop if not

		xor	a								; a = 0
		ld	(zDACIndex), a					; Mark DAC as being idle
		jp	zPlayDigitalAudio				; Loop
; ---------------------------------------------------------------------------
; ===========================================================================
; JMan2050's DAC decode lookup table
; ===========================================================================
DecTable:
		db	   0,  1,   2,   4,   8,  10h,  20h,  40h
		db	 80h, -1,  -2,  -4,  -8, -10h, -20h, -40h
; ---------------------------------------------------------------------------

; =============== S U B	R O U T	I N E =======================================
;
; Plays the SEGA PCM sound. The z80 will be "stuck" in this function (as it
; disables interrupts) until either of the following conditions hold:
;
;	(1)	The SEGA PCM is fully played
;	(2)	The next song to play is 0FEh (mus_StopSEGA)
;loc_1126
zPlaySEGAPCM:
		di									; Disable interrupts
		xor	a								; a = 0
		ld	(PlaySegaPCMFlag), a			; Clear flag
		ld	a, 2Bh							; DAC enable/disable register
		ld	(zYM2612_A0), a					; Select the register
		nop									; Delay
		ld	a, 80h							; Value to enable DAC
		ld	(zYM2612_D0), a					; Enable DAC
		ld	a, zmake68kBank(SEGA_PCM)		; a = sound bank index
		bankswitch3							; Bank switch to sound bank
		ld	hl, zmake68kPtr(SEGA_PCM)		; hl = pointer to SEGA PCM
		ld	de, SEGA_PCM_End-SEGA_PCM		; de = length of SEGA PCM
		ld	a, 2Ah							; DAC channel register
		ld	(zYM2612_A0), a					; Send to YM2612
		nop									; Delay

.loop:
		ld	a, (hl)							; a = next byte of SEGA PCM
		ld	(zYM2612_D0), a					; Send to DAC
		ld	a, (zMusicNumber)				; Check next song number
		cp	mus_StopSEGA					; Is it the command to stop playing SEGA PCM?
		jr	z, .done						; Break the loop if yes
		nop
		nop

		ld	b, 0Ch							; Loop counter
		djnz	$							; Loop in this instruction, decrementing b each iteration, until b = 0

		inc	hl								; Advance to next byte of SEGA PCM
		dec	de								; Mark one byte as being done
		ld	a, d							; a = d
		or	e								; Is length zero?
		jr	nz, .loop						; Loop if not

.done:
		jp	zPlayDigitalAudio				; Go back to normal DAC code
; ---------------------------------------------------------------------------
		db 0

	if $ > 1300h
		fatal "Your Z80 code won't fit before its tables. It's \{$-1300h}h bytes past the start of music data \{1300h}h"
	endif

		restore
		padding off
		!org		Z80_SoundDriver+Size_of_Snd_driver_guess	; The assembler still thinks we're in Z80 memory, so use an 'org' to switch back to the cartridge

; Z80_Snd_Driver2:
Z80_SoundDriverData:
		org		Z80_SoundDriverData+Size_of_Snd_driver2_guess	; Once again, create some padding that we can paste the compressed data over later
; ---------------------------------------------------------------------------
		save
		CPU Z80
		listing purecode
		!org	1300h						; z80 Align, handled by the build process
; ---------------------------------------------------------------------------
; ===========================================================================
; Pointers
; ===========================================================================

z80_SoundDriverPointers:
	if fix_sndbugs
		dw	z80_MusicPointers
		dw	z80_SFXPointers
		dw	z80_ModEnvPointers
		dw	z80_VolEnvPointers
	else
		dw	z80_MusicPointers				; This would be the priority array in other drivers
		dw	z80_UniVoiceBank				; In other drivers, this is a pointer to special SFX table instead
		dw	z80_MusicPointers
		dw	z80_SFXPointers
		dw	z80_ModEnvPointers
		dw	z80_VolEnvPointers
		dw	33h								; This is the song limit; it is never used in any driver
	endif
; ---------------------------------------------------------------------------
; ===========================================================================
; Modulation Envelope Pointers
; ===========================================================================
;z80_FreqFlutterPointers
z80_ModEnvPointers:
		dw	ModEnv_00
		dw	ModEnv_01
		dw	ModEnv_02
		dw	ModEnv_03
		dw	ModEnv_04
		dw	ModEnv_05
		dw	ModEnv_06
		dw	ModEnv_07

ModEnv_01:	db    0
ModEnv_00:	db    1,   2,   1,   0,  -1,  -2,  -3,  -4,  -3,  -2,  -1, 83h
ModEnv_02:	db    0,   0,   0,   0, 13h, 26h, 39h, 4Ch, 5Fh, 72h, 7Fh, 72h, 83h
ModEnv_03:	db    1,   2,   3,   2,   1,   0,  -1,  -2,  -3,  -2,  -1,   0, 82h,   0
ModEnv_04:	db    0,   0,   1,   3,   1,   0,  -1,  -3,  -1,   0, 82h,   2
ModEnv_05:	db    0,   0,   0,   0,   0,  10,  20,  30,  20,  10,   0, -10, -20, -30, -20, -10, 82h,   4
ModEnv_06:	db    0,   0,   0,   0,  22,  44,  66,  44,  22,   0, -22, -44, -66, -44, -22, 82h,   3
ModEnv_07:	db    1,   2,   3,   4,   3,   2,   1,   0,  -1,  -2,  -3,  -4,  -3,  -2,  -1,   0, 82h,   1

; ---------------------------------------------------------------------------
; ===========================================================================
; Volume Envelope Pointers
; ===========================================================================
;z80_PSGTonePointers
z80_VolEnvPointers:
		dw		VolEnv_00,VolEnv_01,VolEnv_02,VolEnv_03,VolEnv_04,VolEnv_05
		dw		VolEnv_06,VolEnv_07,VolEnv_08,VolEnv_09,VolEnv_0A,VolEnv_0B
		dw		VolEnv_0C,VolEnv_0D,VolEnv_0E,VolEnv_0F,VolEnv_10,VolEnv_11
		dw		VolEnv_12,VolEnv_13,VolEnv_14,VolEnv_15,VolEnv_16,VolEnv_17
		dw		VolEnv_18,VolEnv_19,VolEnv_1A,VolEnv_1B,VolEnv_1C,VolEnv_1D
		dw		VolEnv_1E,VolEnv_1F,VolEnv_20,VolEnv_21,VolEnv_22,VolEnv_23
		dw		VolEnv_24,VolEnv_25,VolEnv_26

VolEnv_00:	db    2, 83h
VolEnv_01:	db    0,   2,   4,   6,   8, 10h, 83h
VolEnv_02:	db    2,   1,   0,   0,   1,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2
			db    2,   3,   3,   3,   4,   4,   4,   5, 81h
VolEnv_03:	db    0,   0,   2,   3,   4,   4,   5,   5,   5,   6,   6, 81h
VolEnv_04:	db    3,   0,   1,   1,   1,   2,   3,   4,   4,   5, 81h
VolEnv_05:	db    0,   0,   1,   1,   2,   3,   4,   5,   5,   6,   8,   7,   7,   6, 81h
VolEnv_06:	db    1, 0Ch,   3, 0Fh,   2,   7,   3, 0Fh, 80h
VolEnv_07:	db    0,   0,   0,   2,   3,   3,   4,   5,   6,   7,   8,   9, 0Ah, 0Bh, 0Eh, 0Fh
			db  83h
VolEnv_08:	db    3,   2,   1,   1,   0,   0,   1,   2,   3,   4, 81h
VolEnv_09:	db    1,   0,   0,   0,   0,   1,   1,   1,   2,   2,   2,   3,   3,   3,   3,   4
			db    4,   4,   5,   5, 81h
; The -10h in this FM volume envelope appears to be erroneous:
; negative volume attenuations aren't supported, and instead
; trigger the code intended for byte 82h.
; This envelope appears in many SMPS Z80 Type 2 DAC drivers,
; suggesting it was some kind of poorly-thought-out example.
; Oddly, this same envelope appears in Ristar (whose driver
; *does* support negative attenuations), despite SMPS 68k not
; supporting FM volume envelopes.
VolEnv_0A:	db  10h, 20h, 30h, 40h, 30h, 20h, 10h,   0,-10h, 80h
VolEnv_0B:	db    0,   0,   1,   1,   3,   3,   4,   5, 83h
VolEnv_0C:	db    0, 81h
VolEnv_0D:	db    2, 83h
VolEnv_0E:	db    0,   2,   4,   6,   8, 10h, 83h
VolEnv_0F:	db    9,   9,   9,   8,   8,   8,   7,   7,   7,   6,   6,   6,   5,   5,   5,   4
			db    4,   4,   3,   3,   3,   2,   2,   2,   1,   1,   1,   0,   0,   0, 81h
VolEnv_10:	db    1,   1,   1,   0,   0,   0, 81h
VolEnv_11:	db    3,   0,   1,   1,   1,   2,   3,   4,   4,   5, 81h
VolEnv_12:	db    0,   0,   1,   1,   2,   3,   4,   5,   5,   6,   8,   7,   7,   6, 81h
VolEnv_13:	db  0Ah,   5,   0,   4,   8, 83h
VolEnv_14:	db    0,   0,   0,   2,   3,   3,   4,   5,   6,   7,   8,   9, 0Ah, 0Bh, 0Eh, 0Fh
			db  83h
VolEnv_15:	db    3,   2,   1,   1,   0,   0,   1,   2,   3,   4, 81h
VolEnv_16:	db    1,   0,   0,   0,   0,   1,   1,   1,   2,   2,   2,   3,   3,   3,   3,   4
			db    4,   4,   5,   5, 81h
VolEnv_17:	db  10h, 20h, 30h, 40h, 30h, 20h, 10h,   0, 10h, 20h, 30h, 40h, 30h, 20h, 10h,   0
			db  10h, 20h, 30h, 40h, 30h, 20h, 10h,   0, 80h
VolEnv_18:	db    0,   0,   1,   1,   3,   3,   4,   5, 83h
VolEnv_19:	db    0,   2,   4,   6,   8, 16h, 83h
VolEnv_1A:	db    0,   0,   1,   1,   3,   3,   4,   5, 83h
VolEnv_1B:	db    4,   4,   4,   4,   3,   3,   3,   3,   2,   2,   2,   2,   1,   1,   1,   1
			db  83h
VolEnv_1C:	db    0,   0,   0,   0,   1,   1,   1,   1,   2,   2,   2,   2,   3,   3,   3,   3
			db    4,   4,   4,   4,   5,   5,   5,   5,   6,   6,   6,   6,   7,   7,   7,   7
			db    8,   8,   8,   8,   9,   9,   9,   9, 0Ah, 0Ah, 0Ah, 0Ah, 81h
VolEnv_1D:	db    0, 0Ah, 83h
VolEnv_1E:	db    0,   2,   4, 81h
VolEnv_1F:	db  30h, 20h, 10h,   0,   0,   0,   0,   0,   8, 10h, 20h, 30h, 81h
VolEnv_20:	db    0,   4,   4,   4,   4,   4,   4,   4,   4,   4,   4,   6,   6,   6,   8,   8
			db  0Ah, 83h
VolEnv_21:	db    0,   2,   3,   4,   6,   7, 81h
VolEnv_22:	db    2,   1,   0,   0,   0,   2,   4,   7, 81h
VolEnv_23:	db  0Fh,   1,   5, 83h
VolEnv_24:	db    8,   6,   2,   3,   4,   5,   6,   7,   8,   9, 0Ah, 0Bh, 0Ch, 0Dh, 0Eh, 0Fh
			db  10h, 83h
VolEnv_25:	db    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   1,   1,   1,   1,   1,   1
			db    1,   1,   1,   1,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   3,   3
			db    3,   3,   3,   3,   3,   3,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4
			db    4,   4,   5,   5,   5,   5,   5,   5,   5,   5,   5,   5,   6,   6,   6,   6
			db    6,   6,   6,   6,   6,   6,   7,   7,   7,   7,   7,   7,   7,   7,   7,   7
			db    8,   8,   8,   8,   8,   8,   8,   8,   8,   8,   9,   9,   9,   9,   9,   9
			db    9,   9, 83h
VolEnv_26:	db    0,   2,   2,   2,   3,   3,   3,   4,   4,   4,   5,   5, 83h

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
; FM Universal Voice Bank
; ===========================================================================
	align 17D8h
	if $ <> 17D8h
		fatal "The universal voice bank is not in a location where music can find it; any song using it will fail."
	endif

z80_UniVoiceBank:
	; Synth Bass 2
	    db  3Ch,   1,   0,   0,   0, 1Fh, 1Fh, 15h, 1Fh, 11h, 0Dh, 12h,   5
		db         7,   4,   9,   2, 55h, 3Ah, 25h, 1Ah, 1Ah, 80h,   7, 80h				; 0
	; Trumpet 1
	    db  3Dh,   1,   1,   1,   1, 94h, 19h, 19h, 19h, 0Fh, 0Dh, 0Dh, 0Dh
		db         7,   4,   4,   4, 25h, 1Ah, 1Ah, 1Ah, 15h, 80h, 80h, 80h				; 25
	; Slap Bass 2
	    db    3,   0,0D7h, 33h,   2, 5Fh, 9Fh, 5Fh, 1Fh, 13h, 0Fh, 0Ah, 0Ah
		db       10h, 0Fh,   2,   9, 35h, 15h, 25h, 1Ah, 13h, 16h, 15h, 80h				; 50
	; Synth Bass 1
	    db  34h, 70h, 72h, 31h, 31h, 1Fh, 1Fh, 1Fh, 1Fh, 10h,   6,   6,   6
		db         1,   6,   6,   6, 35h, 1Ah, 15h, 1Ah, 10h, 83h, 18h, 83h				; 75
	; Bell Synth 1
	    db  3Eh, 77h, 71h, 32h, 31h, 1Fh, 1Fh, 1Fh, 1Fh, 0Dh,   6,   0,   0
		db         8,   6,   0,   0, 15h, 0Ah, 0Ah, 0Ah, 1Bh, 80h, 80h, 80h				; 100
	; Bell Synth 2
	    db  34h, 33h, 41h, 7Eh, 74h, 5Bh, 9Fh, 5Fh, 1Fh,   4,   7,   7,   8
		db         0,   0,   0,   0,0FFh,0FFh,0EFh,0FFh, 23h, 80h, 29h, 87h				; 125
	; Synth Brass 1
	    db  3Ah,   1,   7, 31h, 71h, 8Eh, 8Eh, 8Dh, 53h, 0Eh, 0Eh, 0Eh,   3
		db         0,   0,   0,   7, 1Fh,0FFh, 1Fh, 0Fh, 18h, 28h, 27h, 80h				; 150
	; Synth like Bassoon
	    db  3Ch, 32h, 32h, 71h, 42h, 1Fh, 18h, 1Fh, 1Eh,   7, 1Fh,   7, 1Fh
		db         0,   0,   0,   0, 1Fh, 0Fh, 1Fh, 0Fh, 1Eh, 80h, 0Ch, 80h				; 175
	; Bell Horn type thing
	    db  3Ch, 71h, 72h, 3Fh, 34h, 8Dh, 52h, 9Fh, 1Fh,   9,   0,   0, 0Dh
		db         0,   0,   0,   0, 23h,   8,   2,0F7h, 15h, 80h, 1Dh, 87h				; 200
	; Synth Bass 3
	    db  3Dh,   1,   1,   0,   0, 8Eh, 52h, 14h, 4Ch,   8,   8, 0Eh,   3
		db         0,   0,   0,   0, 1Fh, 1Fh, 1Fh, 1Fh, 1Bh, 80h, 80h, 9Bh				; 225
	; Synth Trumpet
	    db  3Ah,   1,   1,   1,   2, 8Dh,   7,   7, 52h,   9,   0,   0,   3
		db         1,   2,   2,   0, 52h,   2,   2, 28h, 18h, 22h, 18h, 80h				; 250
	; Wood Block
	    db  3Ch, 36h, 31h, 76h, 71h, 94h, 9Fh, 96h, 9Fh, 12h,   0, 14h, 0Fh
		db         4, 0Ah,   4, 0Dh, 2Fh, 0Fh, 4Fh, 2Fh, 33h, 80h, 1Ah, 80h				; 275
	; Tubular Bell
	    db  34h, 33h, 41h, 7Eh, 74h, 5Bh, 9Fh, 5Fh, 1Fh,   4,   7,   7,   8
		db         0,   0,   0,   0,0FFh,0FFh,0EFh,0FFh, 23h, 90h, 29h, 97h				; 300
	; Strike Bass
	    db  38h, 63h, 31h, 31h, 31h, 10h, 13h, 1Ah, 1Bh, 0Eh,   0,   0,   0
		db         0,   0,   0,   0, 3Fh, 0Fh, 0Fh, 0Fh, 1Ah, 19h, 1Ah, 80h				; 325
	; Elec Piano
	    db  3Ah, 31h, 25h, 73h, 41h, 5Fh, 1Fh, 1Fh, 9Ch,   8,   5,   4,   5
		db         3,   4,   2,   2, 2Fh, 2Fh, 1Fh, 2Fh, 29h, 27h, 1Fh, 80h				; 350
	; Bright Piano
	    db    4, 71h, 41h, 31h, 31h, 12h, 12h, 12h, 12h,   0,   0,   0,   0
		db         0,   0,   0,   0, 0Fh, 0Fh, 0Fh, 0Fh, 23h, 80h, 23h, 80h				; 375
	; Church Bell
	    db  14h, 75h, 72h, 35h, 32h, 9Fh, 9Fh, 9Fh, 9Fh,   5,   5,   0, 0Ah
		db         5,   5,   7,   5, 2Fh,0FFh, 0Fh, 2Fh, 1Eh, 80h, 14h, 80h				; 400
	; Synth Brass 2
	    db  3Dh,   1,   0,   1,   2, 12h, 1Fh, 1Fh, 14h,   7,   2,   2, 0Ah
		db         5,   5,   5,   5, 2Fh, 2Fh, 2Fh,0AFh, 1Ch, 80h, 82h, 80h				; 425
	; Bell Piano
	    db  1Ch, 73h, 72h, 33h, 32h, 94h, 99h, 94h, 99h,   8, 0Ah,   8, 0Ah
		db         0,   5,   0,   5, 3Fh, 4Fh, 3Fh, 4Fh, 1Eh, 80h, 19h, 80h				; 450
	; Wet Wood Bass
	    db  31h, 33h,   1,   0,   0, 9Fh, 1Fh, 1Fh, 1Fh, 0Dh, 0Ah, 0Ah, 0Ah
		db       0Ah,   7,   7,   7,0FFh,0AFh,0AFh,0AFh, 1Eh, 1Eh, 1Eh, 80h				; 475
	; Silent Bass
	    db  3Ah, 70h, 76h, 30h, 71h, 1Fh, 95h, 1Fh, 1Fh, 0Eh, 0Fh,   5, 0Ch
		db         7,   6,   6,   7, 2Fh, 4Fh, 1Fh, 5Fh, 21h, 12h, 28h, 80h				; 500
	; Picked Bass
	    db  28h, 71h,   0, 30h,   1, 1Fh, 1Fh, 1Dh, 1Fh, 13h, 13h,   6,   5
		db         3,   3,   2,   5, 4Fh, 4Fh, 2Fh, 3Fh, 0Eh, 14h, 1Eh, 80h				; 525
	; Xylophone
	    db  3Eh, 38h,   1, 7Ah, 34h, 59h,0D9h, 5Fh, 9Ch, 0Fh,   4, 0Fh, 0Ah
		db         2,   2,   5,   5,0AFh,0AFh, 66h, 66h, 28h, 80h,0A3h, 80h				; 550
	; Sine Flute
	    db  39h, 32h, 31h, 72h, 71h, 1Fh, 1Fh, 1Fh, 1Fh,   0,   0,   0,   0
		db         0,   0,   0,   0, 0Fh, 0Fh, 0Fh, 0Fh, 1Bh, 32h, 28h, 80h				; 575
	; Pipe Organ
	    db    7, 34h, 74h, 32h, 71h, 1Fh, 1Fh, 1Fh, 1Fh, 0Ah, 0Ah,   5,   3
		db         0,   0,   0,   0, 3Fh, 3Fh, 2Fh, 2Fh, 8Ah, 8Ah, 80h, 80h				; 600
	; Synth Brass 2
	    db  3Ah, 31h, 37h, 31h, 31h, 8Dh, 8Dh, 8Eh, 53h, 0Eh, 0Eh, 0Eh,   3
		db         0,   0,   0,   0, 1Fh,0FFh, 1Fh, 0Fh, 17h, 28h, 26h, 80h				; 625
	; Harpsichord
	    db  3Bh, 3Ah, 31h, 71h, 74h,0DFh, 1Fh, 1Fh,0DFh,   0, 0Ah, 0Ah,   5
		db         0,   5,   5,   3, 0Fh, 5Fh, 1Fh, 5Fh, 32h, 1Eh, 0Fh, 80h				; 650
	; Metallic Bass
	    db    5,   4,   1,   2,   4, 8Dh, 1Fh, 15h, 52h,   6,   0,   0,   4
		db         2,   8,   0,   0, 1Fh, 0Fh, 0Fh, 2Fh, 16h, 90h, 84h, 8Ch				; 675
	; Alternate Metallic Bass
	    db  2Ch, 71h, 74h, 32h, 32h, 1Fh, 12h, 1Fh, 12h,   0, 0Ah,   0, 0Ah
		db         0,   0,   0,   0, 0Fh, 1Fh, 0Fh, 1Fh, 16h, 80h, 17h, 80h				; 700
	; Backdropped Metallic Bass
	    db  3Ah,   1,   7,   1,   1, 8Eh, 8Eh, 8Dh, 53h, 0Eh, 0Eh, 0Eh,   3
		db         0,   0,   0,   7, 1Fh,0FFh, 1Fh, 0Fh, 18h, 28h, 27h, 8Fh				; 725
	; Sine like Bell
	    db  36h, 7Ah, 32h, 51h, 11h, 1Fh, 1Fh, 59h, 1Ch, 0Ah, 0Dh,   6, 0Ah
		db         7,   0,   2,   2,0AFh, 5Fh, 5Fh, 5Fh, 1Eh, 8Bh, 81h, 80h				; 750
	; Synth like Metallic with Small Bell
	    db  3Ch, 71h, 72h, 3Fh, 34h, 8Dh, 52h, 9Fh, 1Fh,   9,   0,   0, 0Dh
		db         0,   0,   0,   0, 23h,   8,   2,0F7h, 15h, 85h, 1Dh, 8Ah				; 775
	; Nice Synth like lead
	    db  3Eh, 77h, 71h, 32h, 31h, 1Fh, 1Fh, 1Fh, 1Fh, 0Dh,   6,   0,   0
		db         8,   6,   0,   0, 15h, 0Ah, 0Ah, 0Ah, 1Bh, 8Fh, 8Fh, 8Fh				; 800
	; Rock Organ
	    db    7, 34h, 74h, 32h, 71h, 1Fh, 1Fh, 1Fh, 1Fh, 0Ah, 0Ah,   5,   3
		db         0,   0,   0,   0, 3Fh, 3Fh, 2Fh, 2Fh, 8Ah, 8Ah, 8Ah, 8Ah				; 825
	; Strike like Slap Bass
	    db  20h, 36h, 35h, 30h, 31h,0DFh,0DFh, 9Fh, 9Fh,   7,   6,   9,   6
		db         7,   6,   6,   8, 20h, 10h, 10h,0F8h, 19h, 37h, 13h, 80h				; 850

	if $ > zDataStart
		fatal "Your Z80 tables won't fit before its variables. It's \{$-zDataStart}h bytes past the start of the variables, at \{zDataStart}h"
	endif

; ---------------------------------------------------------------------------
; ===========================================================================
; END OF SOUND DRIVER
; ===========================================================================
		restore
		padding off
		!org		Z80_SoundDriverData+Size_of_Snd_driver2_guess	; The assembler still thinks we're in Z80 memory, so use an 'org' to switch back to the cartridge
