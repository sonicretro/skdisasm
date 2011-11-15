; ---------------------------------------------------------------------------
; ===========================================================================
; º                                                                         º
; º	                        SONIC&K SOUND DRIVER                            º
; º                                                                         º
; ===========================================================================
; Disassembled by MarkeyJester
; Routines, pointers and stuff by Linncaki
; Throroungly commented and improved (including optional bugfixes) by Flamewing
; ===========================================================================
; Constants
; ===========================================================================

; Set this to 1 to fix some bugs in the driver.
fix_sndbugs				=  0

z80_SoundDriver:
		!org	0							; z80 Align, handled by the build process
		CPU Z80
		listing off

MusID__First			= 01h
MusID_1UP				= 2Ah
MusID_Emerald			= 2Bh
MusID__End				= 33h
SndID__First			= MusID__End
SndID_Ring				= SndID__First
SndID_Spindash			= 0ABh
SndID__FirstContinuous	= 0BCh
MusID_SKCredits			= 0DCh
SndID__End				= 0E0h
FadeID__First			= 0E1h
FadeID__End				= 0E6h
SndID_StopSega			= 0FEh
SndID_Sega				= 0FFh
; ---------------------------------------------------------------------------
NoteRest            	= 080h
FirstCoordFlag      	= 0E0h
; ---------------------------------------------------------------------------
zID_MusicPointers0 = 0
zID_UniVoiceBank = 2
zID_MusicPointers4 = 4
zID_SFXPointers = 6
zID_FreqFlutterPointers = 8
zID_PSGTonePointers = 0Ah
; ---------------------------------------------------------------------------
z80_stack				=	2000h
; equates: standard (for Genesis games) addresses in the memory map
zYM2612_A0				=	4000h
zYM2612_D0				=	4001h
zYM2612_A1				=	4002h
zYM2612_D1				=	4003h
zBankRegister			=	6000h
zPSG					=	7F11h
zROMWindow				=	8000h

; z80 RAM:
	if fix_sndbugs
zVariablesStart         =	1BF0h
zSpecFM3Freqs           =	zVariablesStart
zSpecFM3FreqsSFX        =	zSpecFM3Freqs + 8
	else
zVariablesStart         =	1C00h
	endif

zPalFlag				=	1C02h
zPalDblUpdCounter		=	1C04h
zSoundQueue0			=	1C05h
zSoundQueue1			=	1C06h
zSoundQueue2			=	1C07h
zTempoSpeedup			=	1C08h
zNextSound				=	1C09h

; The following 3 variables are used for M68K input
zMusicNumber			=	1C0Ah				; Play_Sound
zSFXNumber0				=	1C0Bh				; Play_Sound_2
zSFXNumber1				=	1C0Ch				; Play_Sound_2

zFadeOutTimeout			=	1C0Dh
zFadeDelay				=	1C0Eh
zFadeDelayTimeout		=	1C0Fh

zPauseFlag				=	1C10h
zHaltFlag				=	1C11h
zFM3Settings			=	1C12h
zTempoAccumulator		=	1C13h
unk_1C15				=	1C15h				; Set twice, never read
zFadeToPrevFlag			=	1C16h
unk_1C17				=	1C17h				; Set once, never read
unk_1C18				=	1C18h
zUpdatingSFX			=	1C19h
unk_1C21				=	1C21h
zCurrentTempo			=	1C24h
zContinousSFX			=	1C25h
zContinousSFXFlag		=	1C26h
zSpindashRev			=	1C27h
zRingSpeaker			=	1C28h
zFadeInTimeout			=	1C29h
zVoiceTblPtrSave		=	1C2Ah				; For 1-up
zCurrentTempoSave		=	1C2Ch				; For 1-up
zSongBankSave			=	1C2Dh				; For 1-up
zTempoSpeedupSave		=	1C2Eh				; For 1-up
zSpeedupTimeout			=	1C2Fh
zDACIndex				=	1C30h				; bit 7 = 1 if playing, 0 if not; remaining 7 bits are index into DAC tables (1-based)
zContSFXLoopCnt			=	1C31h				; Used as a loop counter for continuous SFX
zSFXSaveIndex			=	1C32h
zSongPosition			=	1C33h
zTrackInitPos			=	1C35h
zVoiceTblPtr			=	1C37h				; 2 bytes
zSFXVoiceTblPtr			=	1C39h				; 2 bytes
zSFXTempoDivider		=	1C3Bh
zSongBank				=	1C3Eh				; Bits 15 to 22 of M68K bank address
PlaySegaPCMFlag			=	1C3Fh
; Now starts song and SFX z80 RAM
; Max number of music channels: 6 FM + 3 PSG or 1 DAC + 5 FM + 3 PSG
zTracksStart			=	1C40h
zSongFM6_DAC			=	zTracksStart+0*zTrackSz		; Music DAC or FM6 track
zSongFM1				=	zTracksStart+1*zTrackSz
zSongFM2				=	zTracksStart+2*zTrackSz
zSongFM3				=	zTracksStart+3*zTrackSz
zSongFM4				=	zTracksStart+4*zTrackSz
zSongFM5				=	zTracksStart+5*zTrackSz
zSongPSG1				=	zTracksStart+6*zTrackSz
zSongPSG2				=	zTracksStart+7*zTrackSz
zSongPSG3				=	zTracksStart+8*zTrackSz
zTracksEnd				=	zTracksStart+9*zTrackSz
; This is RAM for backup of songs (e.g., for 1-up jingle)
zTracksSaveStart		=	zTracksEnd
zSaveSongFM6_DAC		=	zTracksSaveStart+0*zTrackSz
zSaveSongFM1			=	zTracksSaveStart+1*zTrackSz
zSaveSongFM2			=	zTracksSaveStart+2*zTrackSz
zSaveSongFM3			=	zTracksSaveStart+3*zTrackSz
zSaveSongFM4			=	zTracksSaveStart+4*zTrackSz
zSaveSongFM5			=	zTracksSaveStart+5*zTrackSz
zSaveSongPSG1			=	zTracksSaveStart+6*zTrackSz
zSaveSongPSG2			=	zTracksSaveStart+7*zTrackSz
zSaveSongPSG3			=	zTracksSaveStart+8*zTrackSz
zTracksSaveEnd			=	zTracksSaveStart+9*zTrackSz
; This is RAM for SFX channels
; Note this overlaps with the save RAM for 1-up sound, above
; Max number of SFX channels: 4 FM + 3 PSG
zTracksSFXStart			=	zTracksEnd
zSFX_FM3				=	zTracksSFXStart+0*zTrackSz
zSFX_FM4				=	zTracksSFXStart+1*zTrackSz
zSFX_FM5				=	zTracksSFXStart+2*zTrackSz
zSFX_FM6				=	zTracksSFXStart+3*zTrackSz
zSFX_PSG1				=	zTracksSFXStart+4*zTrackSz
zSFX_PSG2				=	zTracksSFXStart+5*zTrackSz
zSFX_PSG3				=	zTracksSFXStart+6*zTrackSz
zTracksSFXEnd			=	zTracksSFXStart+7*zTrackSz

; Track data (each song track)
; Playback control bits:
; 	0 (01h)		Noise channel (PSG) or FM3 special mode (FM)
; 	1 (02h)		Do not attack next note
; 	2 (04h)		SFX is overriding this track
; 	3 (08h)		'Alternate SMPS mode' flag
; 	4 (10h)		'Track is resting' flag
; 	5 (20h)		Unknown/unused
; 	6 (40h)		'Sustain frequency' flag -- prevents frequency from changing again for the lifetime of the track
; 	7 (80h)		Track is playing
zTrackPlaybackControl	=  0
; Track data (each song track)
; Voice control bits:
; 	0-1    		FM channel assignment bits (00 = FM1 or FM4, 01 = FM2 or FM5, 10 = FM3 or FM6/DAC, 11 = invalid)
; 	2 (04h)		For FM/DAC channels, selects if reg/data writes are bound for part II (set) or part I (unset)
; 	3 (08h)		Unknown/unused
; 	4 (10h)		Unknown/unused
; 	5-6    		PSG Channel assignment bits (00 = PSG1, 01 = PSG2, 10 = PSG3, 11 = Noise)
; 	7 (80h)		PSG track if set, FM or DAC track otherwise
zTrackVoiceControl		=  1
zTrackTempoDivider		=  2
zTrackDataPointerLow	=  3
zTrackDataPointerHigh	=  4
zTrackKeyOffset			=  5
zTrackVolume			=  6
zTrackModulationCtrl	=  7				; Modulation is on if nonzero. If only bit 7 is set, then it is normal modulation; otherwise, this-1 is index on frequency flutter pointer table
zTrackVoiceIndex		=  8				; FM instrument/PSG voice
zTrackStackPointer		=  9				; For call subroutine coordination flag
zTrackAMSFMSPan			= 0Ah
zTrackDurationTimeout	= 0Bh
zTrackSavedDuration		= 0Ch				; Already multiplied by timing divisor
; ---------------------------------
; Alternate names for same offset:
zTrackSavedDAC          = 0Dh				; For DAC channel
; ---------------------------------
zTrackFreqLow           = 0Dh				; For FM/PSG channels
; ---------------------------------
zTrackFreqHigh          = 0Eh				; For FM/PSG channels
zTrackVoiceSongID       = 0Fh				; For using voices from a different song
zTrackFreqDisplacement  = 10h
zTrackUnk11h            = 11h
zTrackVolFlutter        = 17h				; Used for dynamic volume adjustments
; ---------------------------------
; Alternate names for same offsets:
zTrackFMFlutter         = 18h
zTrackFMFlutterMask     = 19h
zTrackPSGNoise          = 1Ah
; ---------------------------------
zTrackHaveSSGEGFlag     = 18h				; For FM channels, if track has SSG-EG data
zTrackSSGEGPointerLow   = 19H				; For FM channels, custom SSG-EG data pointer
zTrackSSGEGPointerHigh  = 1AH				; For FM channels, custom SSG-EG data pointer
; ---------------------------------
zTrackFeedbackAlgo      = 1Bh
zTrackTLPtrLow          = 1Ch
zTrackTLPtrHigh         = 1Dh
zTrackNoteFillTimeout   = 1Eh
zTrackNoteFillMaster    = 1Fh
zTrackModulationPtrLow  = 20h
zTrackModulationPtrHigh = 21h
; ---------------------------------
; Alternate names for same offset:
zTrackModulationValLow  = 22h
; ---------------------------------
zTrackFreqFlutterSens   = 22h
; ---------------------------------
zTrackModulationValHigh = 23h
zTrackModulationWait    = 24h
; ---------------------------------
; Alternate names for same offset:
zTrackModulationSpeed   = 25h
; ---------------------------------
zTrackFreqFlutterIndex  = 25h
; ---------------------------------
zTrackModulationDelta   = 26h
zTrackModulationSteps   = 27h
zTrackLoopCounters      = 28h				; May end u overwriting following data
zTrackVoicesLow         = 2Ah				; Low byte of pointer to track's voices, used only if zUpdatingSFX is set
zTrackVoicesHigh        = 2Bh				; High byte of pointer to track's voices, used only if zUpdatingSFX is set
zTrackSz				= 30h				; Size of all tracks

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
		xor	a
		ld	(hl), a
    endm

bankswitch2 macro
		ld	hl, zBankRegister
		ld	(hl), a
		rept 7
			rra
			ld	(hl), a
		endm
		xor	a
		ld	(hl), a
    endm

bankswitch3 macro
		ld	b, 8
-
		ld	(zBankRegister), a
		rrca
		djnz	-
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
		xor	a
		ld	(hl), a
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
		db 0F2h								; Filler; broken jp p,loc?

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
		ld	hl, (ptrMasterIndex)			; Read pointer to (pointer to pointer table) table
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
;word_15
ptrMasterIndex:
		dw		z80_SoundDriverPointers

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
		nop
		nop
		nop
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
		db    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
; ---------------------------------------------------------------------------
	align	8
; =============== S U B	R O U T	I N E =======================================
;
; This subroutine is called every V-Int. After it is processed, the z80
; returns to the digital audio loop to comtinue playing DAC samples.
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

-		ld	a, r							; Get memory refresh register
		ld	(unk_1C17), a					; Save it
		call	zUpdateEverything			; Update all tracks
		ld	a, (zPalFlag)					; Get PAL flag
		or	a								; Is it set?
		jr	z, ++							; Branch if not (NTSC)
		ld	a, (zPalDblUpdCounter)			; Get PAL double-update timeout counter
		or	a								; Is it zero?
		jr	nz, +							; Branch if not
		ld	a, 5							; Set it back to 5...
		ld	(zPalDblUpdCounter), a			; ... and save it
		jp	-								; Go again

+
		dec	a								; Decrease PAL double-update timeout counter
		ld	(zPalDblUpdCounter), a			; Store it
+
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
		ld	sp, z80_stack			    ; set the stack pointer to 0x2000 (end of z80 RAM)
			; The following instruction block keeps the z80 in a tight loop.
		ld	c, 0							; c = 0
-
		ld	b, 0							; b = 0
		djnz	$							; Loop in this instruction, decrementing b each iteration, until b = 0
		dec	c								; c--
		jr	z, -							; Loop if c = 0
		
		call	zMusicFade					; Stop all music
		ld	a, zmake68kBank(DacBank2)		; Set song bank to second DAC bank (default value)
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
		bit	7, (ix+zTrackVoiceControl)		; Is this a PSG track?
		ret	nz								; Is so, quit
		bit	2, (ix+zTrackPlaybackControl)	; Is SFX overriding this track?
		ret	nz								; Return if yes
		add	a, (ix+zTrackVoiceControl)		; Add the channel bits to the register address
		bit	2, (ix+zTrackVoiceControl)		; Is this the DAC channel or FM4 or FM5 or FM6?
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
		nop									; Wait
		ld	a, c							; a = data to send
		ld	(zYM2612_D0), a					; Send data to register
		ret
; End of function zWriteFMI

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR zWriteFMIorII

;loc_CB
zWriteFMII_reduced:
		sub	4								; Strip 'bound to part II regs' bit
; END OF FUNCTION CHUNK	FOR zWriteFMIorII

; =============== S U B	R O U T	I N E =======================================
;
; Writes a reg/data pair to part II
;
; Input:  a    Value for register
;         c    Value for data

;sub_CD
zWriteFMII:
		ld	(zYM2612_A1), a					; Select YM2612 register
		nop									; Wait
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
		db		zmake68kBank(DAC_AC_Data)            ,zmake68kBank(DAC_AD_AE_Data)         ,zmake68kBank(DAC_AD_AE_Data)         ,zmake68kBank(DAC_AF_B0_Data)
		db		zmake68kBank(DAC_AF_B0_Data)         ,zmake68kBank(DAC_B1_Data)            ,zmake68kBank(DAC_B2_B3_Data)         ,zmake68kBank(DAC_B2_B3_Data)
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
		cp	MusID_1UP-1						; Is it still 1-Up?
		jr	nz, zlocCheckFadeIn				; Branch if not
		ld	a, (zMusicNumber)				; Get next music to play
		cp	MusID_1UP						; Is it another 1-Up?
		jr	z, +							; Branch if yes
		cp	MusID__End-1					; Is it music (except credits song)?
		jr	c, ++							; Branch if not
+
		xor	a								; a = 0
		ld	(zMusicNumber), a				; Clear queue entry
+
		xor	a								; a = 0
		ld	(zSFXNumber0), a				; Clear first queued SFX
		ld	(zSFXNumber1), a				; Clear second queued SFX
		jr	+

;loc_149
zlocCheckFadeIn:
		ld	a, (zFadeToPrevFlag)			; Get fade-to-previous flag
		cp	0FFh							; Is it 0FFh?
		jr	z, +							; Branch if yes
		ld	hl, zMusicNumber				; Point hl to M68K input
		ld	e, (hl)							; e = next song to play
		inc	hl								; Advance pointer
		ld	d, (hl)							; d = next SFX to play
		inc	hl								; Advance pointer
		ld	a, (hl)							; a = next SFX to play
		or	d								; Combine bits of a and d
		or	e								; Is anything in the play queue?
		jr	z, +							; Branch if not
		call	zFillSoundQueue				; Transfer M68K input
		call	zCycleSoundQueue			; Cycle queue and play first entry
		call	zCycleSoundQueue			; Cycle queue and play second entry
		call	zCycleSoundQueue			; Cycle queue and play third entry
+
		ld	a, (zSongBank)					; Get bank ID for music
		bankswitch2							; Bank switch to it
		xor	a								; a = 0
		ld	(zUpdatingSFX), a				; Updating music
		ld	a, (zFadeToPrevFlag)			; Get fade-to-previous flag
		cp	0FFh							; Is it 0FFh?
		call	z, zFadeInToPrevious		; Fade to previous if yes
		ld	ix, zTracksStart				; ix = track RAM
		bit	7, (ix+zTrackPlaybackControl)	; Is FM6/DAC track playing?
		call	nz, zUpdateDACTrack			; Branch if yes
		ld	b, (zTracksEnd-zSongFM1)/zTrackSz	; Number of tracks
		ld	ix, zSongFM1					; ix = FM1 track RAM
		jr	+								; Play all tracks

; =============== S U B	R O U T	I N E =======================================
;
;sub_19E
zUpdateSFXTracks:
		ld	a, 1							; a = 1
		ld	(zUpdatingSFX), a				; Updating SFX
		ld	a, zmake68kBank(SndBank)		; Get SFX bank ID
		bankswitch2							; Bank switch to SFX
		ld	ix, zTracksSFXStart				; ix = start of SFX track RAM
		ld	b, (zTracksSFXEnd-zTracksSFXStart)/zTrackSz	; Number of channels

/		push	bc							; Save bc
		bit	7, (ix+zTrackPlaybackControl)	; Is track playing?
		call	nz, zUpdateFMorPSGTrack		; Call routine if yes
		ld	de, zTrackSz					; Spacing between tracks
		add	ix, de							; Advance to next track
		pop	bc								; Restore bc
		djnz	-							; Loop for all tracks
		
		ld	a, (zTempoSpeedup)				; Get tempo speed-up value
		or	a								; Is music sped up?
		ret	z								; Return if not
		ld	a, (zSpeedupTimeout)			; Get extra tempo timeout
		or	a								; Has it expired?
		jp	nz, +							; Branch if not
		ld	a, (zTempoSpeedup)				; Get master tempo speed-up value
		ld	(zSpeedupTimeout), a			; Reset extra tempo timeout to it
		jp	zUpdateMusic					; Update music again
; ---------------------------------------------------------------------------
+
		dec	a								; Decrement timeout...
		ld	(zSpeedupTimeout), a			; ... then store new value
		ret
; End of function zUpdateSFXTracks


; =============== S U B	R O U T	I N E =======================================
; Updates FM or PSG track.
;
;sub_1E9
zUpdateFMorPSGTrack:
		bit	7, (ix+zTrackVoiceControl)		; Is this a PSG channel?
		jp	nz, zUpdatePSGTrack				; Branch if yes
		call	zTrackRunTimer				; Run note timer
		jr	nz, +							; Branch if note hasn't expired yet
		call	zGetNextNote				; Get next note for FM track
		bit	4, (ix+zTrackPlaybackControl)	; Is track resting?
		ret	nz								; Return if yes
		call	zPrepareModulation			; Initialize modulation
		call	zUpdateFreq					; Add frequency displacement to frequency
		call	zDoModulation				; Apply modulation
		call	zFMSendFreq					; Send frequancy to YM2612
		jp	zFMNoteOn						; Note on on all operators
; ---------------------------------------------------------------------------
+
		bit	4, (ix+zTrackPlaybackControl)	; Is track resting?
		ret	nz								; Return if yes
		call	zDoFMFlutter				; Do FM flutter for track
		ld	a, (ix+zTrackNoteFillTimeout)	; Get note fill timeout
		or	a								; Has timeout expired?
		jr	z, +							; Branch if yes
		dec	(ix+zTrackNoteFillTimeout)		; Update note fill timeout
		jp	z, zKeyOffIfActive				; Send key off if needed
+
		call	zUpdateFreq					; Add frequency displacement to frequency
		bit	6, (ix+zTrackPlaybackControl)	; Is 'sustain frequency' bit set?
		ret	nz								; Return if yes
		call	zDoModulation				; Apply modulation then fall through
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
		bit	2, (ix+zTrackPlaybackControl)	; Is SFX overriding this track?
		ret	nz								; Return if yes
		bit	0, (ix+zTrackPlaybackControl)	; Is track in special mode (FM3 only)?
		jp	nz, +							; Branch if yes

-		ld	a, 0A4h							; Command to update frequency MSB
		ld	c, h							; High byte of frequency
		call	zWriteFMIorII				; Send it to YM2612
		ld	a, 0A0h							; Command to update frequency LSB
		ld	c, l							; Low byte of frequency
		call	zWriteFMIorII				; Send it to YM2612
		ret
; ---------------------------------------------------------------------------
+
		ld	a, (ix+zTrackVoiceControl)		; a = voice control byte
		cp	2								; Is this FM3?
		jr	nz, -							; Branch if not
	if fix_sndbugs
		call	zGetSpecialFM3DataPointer	; de = pointer to saved FM3 frequency shifts
	endif
		ld	b, zSpecialFreqCommands_End-zSpecialFreqCommands	; Number of entries
		ld	hl, zSpecialFreqCommands		; Lookup table

		; DANGER! de is unset here, and could be pointing anywhere! Luckily,
		; only reads are performed from it.
-		push	bc							; Save bc
		ld	a, (hl)							; a = register selector
		inc	hl								; Advance pointer
		push	hl							; Save hl
		ex	de, hl							; Exchange de and hl
		ld	c, (hl)							; Get byte from whatever the hell de was pointing to
		inc	hl								; Advance pointer
		ld	b, (hl)							; Get byte from whatever the hell de was pointing to
		inc	hl								; Advance pointer
		ex	de, hl							; Exchange de and hl
		ld	l, (ix+zTrackFreqLow)			; l = low byte of track frequency
		ld	h, (ix+zTrackFreqHigh)			; h = high byte of track frequency
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
		djnz	-							; Loop for all operators
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
	if fix_sndbugs
zGetSpecialFM3DataPointer:
		ld	de,zSpecFM3Freqs				; de = pointer to saved FM3 frequency shifts
		ld	a, (zUpdatingSFX)				; Get flag
		or	a								; Is this a SFX track?
		ret	z								; Return if not
		ld	de,zSpecFM3FreqsSFX				; de = pointer to saved FM3 frequency shifts
	endif
znullsub_A:
		ret
; End of function nullsub_A


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
		ld	e, (ix+zTrackDataPointerLow)	; e = low byte of track data pointer
		ld	d, (ix+zTrackDataPointerHigh)	; d = high byte of track data pointer
		res	1, (ix+zTrackPlaybackControl)	; Clear 'do not attack next note' flag
		res	4, (ix+zTrackPlaybackControl)	; Clear 'track is at rest' flag

;loc_285
zGetNextNote_cont:
		ld	a, (de)							; Get next byte from track
		inc	de								; Advance pointer
		cp	FirstCoordFlag					; Is it a coordination flag?
		jp	nc, zHandleFMorPSGCoordFlag		; Branch if yes
		ex	af, af'							; Save af
		call	zKeyOffIfActive				; Kill note
		ex	af, af'							; Restore af
		bit	3, (ix+zTrackPlaybackControl)	; Is alternate SMPS mode flag set?
		jp	nz, zAlternateSMPS				; Branch if yes
		or	a								; Is this a duration?
		jp	p, zStoreDuration				; Branch if yes
		sub	81h								; Make the note into a 0-based index
		jp	p, +							; Branch if it is a note and not a rest
		call	zKillTrack					; Put track at rest
		jr	zGetNoteDuration
; ---------------------------------------------------------------------------
+
		add	a, (ix+zTrackKeyOffset)			; Add in key displacement
		ld	hl, zPSGFrequencies				; PSG frequency lookup table
		push	af							; Save af
		rst	PointerTableOffset				; hl = frequency value for note
		pop	af								; Restore af
		bit	7, (ix+zTrackVoiceControl)		; Is this a PSG track?
		jr	nz, zGotNoteFreq				; Branch if yes
		push	de							; Save de
		ld	d, 8							; Each octave above the first adds this to frequency high bits
		ld	e, 0Ch							; 12 notes per octave
		ex	af, af'							; Exchange af with af'
		xor	a								; Clear a (which will clear a')

-		ex	af, af'							; Exchange af with af'
		sub	e								; Subtract 1 octave from the note
		jr	c, +							; If this is less than zero, we are done
		ex	af, af'							; Exchange af with af'
		add	a, d							; One octave up
		jr	-								; Loop
; ---------------------------------------------------------------------------
	if fix_sndbugs=0
		ex	af, af'							; Exchange af with af' (dead code)
	endif
; ---------------------------------------------------------------------------
+
		add	a, e							; Add 1 octave back (so note index is positive)
		ld	hl, zFMFrequencies				; FM first octave frequency lookup table
		rst	PointerTableOffset				; hl = frequency of the note on the first octave
		ex	af, af'							; Exchange af with af'
		or	h								; a = high bits of frequency (including octave bits, which were in a)
		ld	h, a							; h = high bits of frequency (including octave bits)
		pop	de								; Restore de

;loc_2CE
zGotNoteFreq:
		ld	(ix+zTrackFreqLow), l			; Store low byte of note frequency
		ld	(ix+zTrackFreqHigh), h			; Store high byte of note frequency

;loc_2D4
zGetNoteDuration:
		ld	a, (de)							; Get duration from the track
		or	a								; Is it an actual duration?
		jp	p, zGotNoteDuration				; Branch if yes
		ld	a, (ix+zTrackSavedDuration)		; Get saved duration
		ld	(ix+zTrackDurationTimeout), a	; Set it as next timeout duration
		jr	zFinishTrackUpdate
; ---------------------------------------------------------------------------
	if fix_sndbugs=0
		; Unused/dead code:
		ld	a, (de)
		inc	de
		ld	(ix+zTrackUnk11h),a
		jr	loc_306
	endif
; ---------------------------------------------------------------------------
;loc_2E8
zAlternateSMPS:
		; Setting bit 3 on zTrackPlaybackControl puts the song in a weird mode.
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
		jr	z, ++							; Branch if not
		ld	a, (ix+zTrackKeyOffset)			; a = key displacement
		ld	b, 0							; b = 0
		or	a								; Is a negative?
		jp	p, +							; Branch if not
		dec	b								; Set b to -1
+
		ld	c, a							; bc = sign extension of key displacement
		add	hl, bc							; hl += key displacement
+
		ld	(ix+zTrackFreqLow), l			; Store low byte of note frequency
		ld	(ix+zTrackFreqHigh), h			; Store high byte of note frequency
		ld	a, (de)							; Get another byte from the track
		inc	de								; Advance to next byte in track
		ld	(ix+zTrackUnk11h), a			; Store unknown byte to otherwise unused location
loc_306:
		ld	a, (de)							; Get raw duration from track

;loc_307
zGotNoteDuration:
		inc	de								; Advance to next byte in track

;loc_308
zStoreDuration:
		call	zComputeNoteDuration		; Multiply note by tempo divider
		ld	(ix+zTrackSavedDuration), a		; Store it for next note

;loc_30E
zFinishTrackUpdate:
		ld	(ix+zTrackDataPointerLow), e	; Save low byte of current location in song
		ld	(ix+zTrackDataPointerHigh), d	; Save high byte of current location in song
		ld	a, (ix+zTrackSavedDuration)		; Get current saved duration
		ld	(ix+zTrackDurationTimeout), a	; Set it as duration timeout
		bit	1, (ix+zTrackPlaybackControl)	; Is 'do not attack next note' flag set?
		ret	nz								; Branch of yes
		xor	a								; Clear a
		ld	(ix+zTrackModulationSpeed), a	; Clear modulation speed
		ld	(ix+zTrackModulationValLow), a	; Clear low byte of accumulated modulation
		ld	(ix+zTrackVolFlutter), a		; Reset flutter
		ld	a, (ix+zTrackNoteFillMaster)	; Get master note fill
		ld	(ix+zTrackNoteFillTimeout), a	; Set note fill timeout
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
		ld	b, (ix+zTrackTempoDivider)		; Get tempo divider for this track
		dec	b								; Make it into a loop conuter
		ret	z								; Return if it was 1
		ld	c, a							; c = a

-		add	a, c							; a += c
		djnz	-							; Loop
		ret
; End of function zComputeNoteDuration


; =============== S U B	R O U T	I N E =======================================
; Reduces note duration timeout for current track.
;
; Input:   ix   Track data
; Output:  a    New duration
;sub_33A
zTrackRunTimer:
		ld	a, (ix+zTrackDurationTimeout)	; Get track duration timeout
		dec	a								; Decrement it...
		ld	(ix+zTrackDurationTimeout), a	; ... and save new value
		ret
; End of function zTrackRunTimer

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR zUpdateFMorPSGTrack
;loc_342
zFMNoteOn:
		ld	a, (ix+zTrackFreqLow)			; Get low byte of note frequency
		or	(ix+zTrackFreqHigh)				; Is the note frequency zero?
		ret	z								; Return if yes
		ld	a, (ix+zTrackPlaybackControl)	; Get playback control byte for track
	if fix_sndbugs
		and	14h								; Is either bit 4 ("track at rest") or 2 ("SFX overriding this track") set?
	else
		and	6								; Is either bit 1 ("do not attack next note") or 2 ("SFX overriding this track") set?
	endif
		ret	nz								; Return if yes
		ld	a, (ix+zTrackVoiceControl)		; Get voice control byte from track
		or	0F0h							; We want only the FM channel assignment bits
		ld	c, a							; Key on for all operators
		ld	a, 28h							; Select key on/of register
		call	zWriteFMI					; Send command to YM2612
		ret
; END OF FUNCTION CHUNK	FOR zUpdateFMorPSGTrack

; =============== S U B	R O U T	I N E =======================================
; Writes reg/data pair to register 28h (key on/off) if track active
;
; Input:   ix   Track data
; Output:  a    Damaged
;          c    Damaged
;sub_35B
zKeyOffIfActive:
		ld	a, (ix+zTrackPlaybackControl)	; Get playback control byte for track
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
		ld	c, (ix+zTrackVoiceControl)		; Get voice control byte for track (this will turn off all operators as high nibble = 0)
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
		call	zWriteFMI					; Send it
		ret
; End of function zKeyOnOff

; =============== S U B	R O U T	I N E =======================================
; Performs flutter in FM channels.
;
; Input:   ix    Pointer to track RAM
; Output:  a     Trashed
;          bc    Trashed
;          de    Trashed
;          hl    Trashed
;
;sub_36D
zDoFMFlutter:
		ld	a, (ix+zTrackFMFlutter)			; Get FM flutter value
		or	a								; Is it zero?
		ret	z								; Return if yes
		ret	m								; Return if it is actually the custom SSG-EG flag
		dec	a								; Make a into an index
		ld	c, zID_PSGTonePointers			; Value for PSG tone pointer table
		rst	GetPointerTable					; hl = pointer to PSG flutter table
		rst	PointerTableOffset				; hl = pointer to PSG flutter for track
		call	zDoFlutter					; a = new flutter value
		ld	h, (ix+zTrackTLPtrHigh)			; h = high byte ot TL data pointer
		ld	l, (ix+zTrackTLPtrLow)			; l = low byte ot TL data pointer
		ld	de, zFMInstrumentTLTable		; de = pointer to FM TL register table
		ld	b, zFMInstrumentTLTable_End-zFMInstrumentTLTable	; Number of entries
		ld	c, (ix+zTrackFMFlutterMask)		; c = flutter bitmask

-		push	af							; Save af
		sra	c								; Divide c by 2
		push	bc							; Save bc
		jr	nc, +							; Branch if c bit shifted was zero
		add	a, (hl)							; Add TL value to flutter value
		and	7Fh								; Strip sign bit
		ld	c, a							; c = TL + flutter
		ld	a, (de)							; a = YM2612 register
		call	zWriteFMIorII				; Send TL data to YM2612
+
		pop	bc								; Restore bc
		inc	de								; Advance to next YM2612 register
		inc	hl								; Advance to next TL value
		pop	af								; Restore af
		djnz	-							; Loop for all registers
		ret
; End of function zDoFMFlutter

; =============== S U B	R O U T	I N E =======================================
; Initializes normal modulation.
;
; Input:   ix    Pointer to track's RAM
; Output:  de    If modulation control has bit 7 set and track is to attack next note, pointer to modulation steps in track RAM
;          hl    If modulation control has bit 7 set and track is to attack next note, pointer to modulation steps in track data
;
;sub_39E
zPrepareModulation:
		bit	7, (ix+zTrackModulationCtrl)	; Is modulation on?
		ret	z								; Return if not
		bit	1, (ix+zTrackPlaybackControl)	; Is 'do not attack next note' bit set?
		ret	nz								; Return if yes
		ld	e, (ix+zTrackModulationPtrLow)	; e = low byte of pointer to modulation data
		ld	d, (ix+zTrackModulationPtrHigh)	; d = high byte of pointer to modulation data
		push	ix							; Save ix
		pop	hl								; hl = pointer to track data
		ld	b, 0							; b = 0
		ld	c, zTrackModulationWait			; c = offset in track RAM for modulation data
		add	hl, bc							; hl = pointer to modulation data in track RAM
		ex	de, hl							; Exchange de and hl
		ldi									; *de++ = *hl++
		ldi									; *de++ = *hl++
		ldi									; *de++ = *hl++
		ld	a, (hl)							; a = number of modulation steps
		srl	a								; Divide by 2
		ld	(de), a							; Store in track RAM
		xor	a								; a = 0
		ld	(ix+zTrackModulationValLow), a	; Clear low byte of accumulated modulation
		ld	(ix+zTrackModulationValHigh), a	; Clear high byte of accumulated modulation
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
;    If modulation control is nonzero and not 80h (frequency flutter):
;
;
;sub_3C9
zDoModulation:
		ld	a, (ix+zTrackModulationCtrl)	; Get modulation control byte
		or	a								; Is modulation active?
		ret	z								; Return if not
		cp	80h								; Is modulation control 80h?
		jr	nz, zDoFrequencyFlutter			; Branch if not
		dec	(ix+zTrackModulationWait)		; Decrement modulation wait
		ret	nz								; Return if nonzero
		inc	(ix+zTrackModulationWait)		; Increase it back to 1 for next frame
		push	hl							; Save hl
		ld	l, (ix+zTrackModulationValLow)	; l = low byte of accumulated modulation
		ld	h, (ix+zTrackModulationValHigh)	; h = high byte of accumulated modulation
		ld	e, (ix+zTrackModulationPtrLow)	; e = low byte of modulation data pointer
		ld	d, (ix+zTrackModulationPtrHigh)	; d = high byte of modulation data pointer
		push	de							; Save de
		pop	iy								; iy = pointer to modulation data
		dec	(ix+zTrackModulationSpeed)		; Decrement modulation speed
		jr	nz, +							; Branch if nonzero
		ld	a, (iy+1)						; Get original modulation speed
		ld	(ix+zTrackModulationSpeed), a	; Reset modulation speed timeout
		ld	a, (ix+zTrackModulationDelta)	; Get modulation delta per step
		ld	c, a							; c = modulation delta per step
		and	80h								; Get only sign bit
		rlca								; Shift it into bit 0
		neg									; Negate (so it is either 0 or -1)
		ld	b, a							; bc = sign extension of delta
		add	hl, bc							; hl += bc
		ld	(ix+zTrackModulationValLow), l	; Store low byte of accumulated modulation
		ld	(ix+zTrackModulationValHigh), h	; Store high byte of accumulated modulation
+
		pop	bc								; bc = note frequency
		add	hl, bc							; hl = modulated note frequency
		dec	(ix+zTrackModulationSteps)		; Reduce number of modulation steps
		ret	nz								; Return if nonzero
		ld	a, (iy+3)						; Get number of steps from track data
		ld	(ix+zTrackModulationSteps), a	; Reset modulation steps in track RAM
		ld	a, (ix+zTrackModulationDelta)	; Load modulation delta
		neg									; Change its sign
		ld	(ix+zTrackModulationDelta), a	; Store it back
		ret
; ---------------------------------------------------------------------------
;loc_41A
zDoFrequencyFlutter:
		dec	a								; Convert into pointer table index
		ex	de, hl							; Exchange de and hl; de = note frequency
		ld	c, zID_FreqFlutterPointers		; Value for frequency flutter pointer table
		rst	GetPointerTable					; hl = pointer to frequency flutter pointer table
		rst	PointerTableOffset				; hl = frequency flutter pointer for modulation control byte
		jr	zDoFrequencyFlutter_cont
; ---------------------------------------------------------------------------

zFreqFlutterSetIndex:
		ld	(ix+zTrackFreqFlutterIndex), a	; Set new frequency flutter index

;loc_425
zDoFrequencyFlutter_cont:
		push	hl							; Save hl
		ld	c, (ix+zTrackFreqFlutterIndex)	; c = frequency flutter index
		ld	b, 0							; b = 0
		add	hl, bc							; hl += bc
		ld	a, (hl)							; a = new frequency flutter value
		pop	hl								; Restore hl
		bit	7, a							; Is frequency flutter negative?
		jp	z, zlocPositiveFlutterMod			; Branch if not
		cp	82h								; Is it 82h?
		jr	z, zlocChangeFlutterIndex		; Branch if yes
		cp	80h								; Is it 80h?
		jr	z, zlocResetFlutterMod			; Branch if yes
		cp	84h								; Is it 84h?
		jr	z, zlocFlutterIncMultiplier		; Branch if yes
		ld	h, 0FFh							; h = 0FFh
		jr	nc, zlocApplyFlutterMod			; Branch if more than 84h
		set	6, (ix+zTrackPlaybackControl)	; Set 'sustain frequency' bit
		pop	hl								; Tamper with return location so as to not return to caller
		ret
; ---------------------------------------------------------------------------
;loc_449
zlocChangeFlutterIndex:
		inc	bc								; Increment bc
	if fix_sndbugs
		; Fix based on similar code from Ristar's sound driver.
		push	hl							; Save hl
		add	hl, bc							; hl += bc
		ld	a, (hl)							; a = new frequency flutter index
		pop	hl								; Restore hl
	else
		; DANGER! Uses bc as a pointer, getting bytes from code region.
		; This happens for several frequency flutters, so you should avoid them
		; unless you enable the driver bug fixes.

		ld	a, (bc)							; Use it as a pointer??? Getting bytes from code region?
	endif
		jr	zFreqFlutterSetIndex			; Set position to nonsensical value
; ---------------------------------------------------------------------------
;loc_44D
zlocResetFlutterMod:
		xor	a								; a = 0
		jr	zFreqFlutterSetIndex			; Reset position for frequency flutter
; ---------------------------------------------------------------------------
;loc_450
zlocFlutterIncMultiplier:
		inc	bc								; Increment bc
	if fix_sndbugs
		; Fix based on similar code from Ristar's sound driver.
		push	hl							; Save hl
		add	hl, bc							; hl += bc
		ld	a, (hl)							; a = what to add to flutter sensibility value
		pop	hl								; Restore hl
	else
		; DANGER! Uses bc as a pointer, getting bytes from code region.
		; Luckily, this does not happen for any of the existing frequency
		; flutter.

		ld	a, (bc)							; Use it as a pointer??? Getting bytes from code region?
	endif
		add	a, (ix+zTrackFreqFlutterSens)	; Add flutter sensibility to a...
		ld	(ix+zTrackFreqFlutterSens), a	; ... then store new value
		inc	(ix+zTrackFreqFlutterIndex)		; Advance flutter modulation...
		inc	(ix+zTrackFreqFlutterIndex)		; ... twice.
		jr	zDoFrequencyFlutter_cont
; ---------------------------------------------------------------------------
;loc_460
zlocPositiveFlutterMod:
		ld	h, 0							; h = 0

;loc_462
zlocApplyFlutterMod:
		ld	l, a							; hl = sign extension of modulation value
		ld	b, (ix+zTrackFreqFlutterSens)	; Fetch flutter sensibility
		inc	b								; Increment it (minimum 1)
		ex	de, hl							; Swap hl and de; hl = note frequency

-		add	hl, de							; hl += de
		djnz	-							; Make hl = note frequency + b * de
		inc	(ix+zTrackFreqFlutterIndex)		; Advance frequency flutter
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
zUpdateFreq:
		ld	h, (ix+zTrackFreqHigh)			; h = high byte of note frequency
		ld	l, (ix+zTrackFreqLow)			; l = low byte of note frequency
		ld	b, 0							; b = 0
		ld	a, (ix+zTrackFreqDisplacement)	; a = frequency displacement
		or	a								; Is a negative?
		jp	p, +							; Branch if not
		ld	b, 0FFh							; b = -1
+
		ld	c, a							; bc = sign extension of frequency displacement
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
		ld	l, (ix+zTrackVoicesLow)			; l = low byte of track's voice pointer
		ld	h, (ix+zTrackVoicesHigh)		; h = high byte of track's voice pointer

;loc_492
zGetFMInstrumentOffset:
		xor	a								; a = 0
		or	b								; Is FM instrument the first one (zero)?
		ret	z								; Return if so
		ld	de, 25							; Size of each FM instrument

-		add	hl, de							; Advance pointer to next instrument
		djnz	-							; Loop until instrument offset is found
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
		db  50h								; Rate scalling/attack rate operator 1
		db  58h								; Rate scalling/attack rate operator 3
		db  54h								; Rate scalling/attack rate operator 2
		db  5Ch								; Rate scalling/attack rate operator 4
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
		ld	c, (ix+zTrackAMSFMSPan)			; Send track AMS/FMS/panning
		ld	a, 0B4h							; Select AMS/FMS/panning register
		call	zWriteFMIorII				; Set track data
		call	zSendFMInstrData			; Send data to register
		ld	(ix+zTrackFeedbackAlgo), a		; Save current feedback/algorithm

	if fix_sndbugs
		; Start with detune/multiplier operators
		ld	b, zFMInstrumentRSARTable-zFMInstrumentOperatorTable	; Number of commands to issue

-		call	zSendFMInstrData			; Send FM instrument data
		djnz	-							; Loop

		; Now for rate scaking/attack rate. The attack rate must be 1Fh if using
		; SSG-EG, which is the reason for the split.
		ld	b, zFMInstrumentAMD1RTable-zFMInstrumentRSARTable	; Number of commands to issue

-		call	zSendFMInstrDataRSAR		; Send FM instrument data
		djnz	-							; Loop

		; Finalize with all the other operators.
		ld	b, zFMInstrumentOperatorTable_End-zFMInstrumentAMD1RTable	; Number of commands to issue

-		call	zSendFMInstrData			; Send FM instrument data
		djnz	-							; Loop
	else
		; DANGER! The following code ignores the fact that SSG-EG mode must be
		; used with maximum (1Fh) attack rate or output is officially undefined.
		; Setting voices with SSG-EG enabled then has the potential effect of
		; weird sound, even in real hardware.

		ld	b, zFMInstrumentOperatorTable_End-zFMInstrumentOperatorTable	; Number of commands to issue

-		call	zSendFMInstrData			; Send FM instrument data
		djnz	-							; Loop
	endif
		ld	(ix+zTrackTLPtrLow), l			; Save low byte of pointer to (not yet uploaded) TL data
		ld	(ix+zTrackTLPtrHigh), h			; Save high byte of pointer to (not yet uploaded) TL data
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
		call	zWriteFMIorII				; Write track data
		ret
; End of function zSendFMInstrData

	if fix_sndbugs
zSendFMInstrDataRSAR:
		ld	a, (ix+zTrackHaveSSGEGFlag)		; Get custom SSG-EG flag
		or	a								; Does track have custom SSG-EG data?
		jp	p, zSendFMInstrData				; Branch if not
		ld	a, (hl)							; Get value from instrument RAM
		inc	hl								; Advance pointer
		or 1Fh								; Set AR to maximum
		ld	c, a							; c = RS/AR for operator
		ld	a, (de)							; Get register output
		inc	de								; Advance pointer
		call	zWriteFMIorII				; Write track data
		ret
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

; ---------------------------------------------------------------------------
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
		cp	MusID_SKCredits					; Is this the credits music?
		jp	z, zPlayMusicCredits			; Branch if yes
		cp	SndID_Sega						; Is this the SEGA sound?
		jp	z, zPlaySegaSound				; Branch if yes
		cp	MusID__End						; Is this a music?
		jp	c, zPlayMusic					; Branch if yes
		cp	SndID__End						; Is this a sound effect?
		jp	c, zPlaySound_CheckRing			; Branch if yes
		cp	FadeID__First					; Is it before the first fade effect?
		jp	c, zMusicFade					; Branch if yes
		cp	FadeID__End						; Is this after the last fade effect?
		jp	nc, zMusicFade					; Branch if yes
		sub	FadeID__First					; If none of the checks passed, do fade effects.
		ld	hl, zFadeEffects				; hl = switch table pointer
		rst	PointerTableOffset				; Get address of function that handles the fade effect
		xor	a								; Set a = 0
		ld	(unk_1C18), a					; Set otherwise unused value to zero
		jp	(hl)							; Handle fade effect
; End of function zPlaySoundByIndex
; ---------------------------------------------------------------------------
;loc_524
zFadeEffects:
		dw	zFadeOutMusic					; E1h
		dw	zMusicFade						; E2h
		dw	zPSGSilenceAll					; E3h
		dw	zStopSFX						; E4h
		dw	zFadeOutMusic					; E5h
; ---------------------------------------------------------------------------
;sub_52E
zStopSFX:
		ld	ix, zTracksSFXStart				; ix = pointer to SFX track memory
		ld	b, (zTracksSFXEnd-zTracksSFXStart)/zTrackSz		; Number of channels
		ld	a, 1							; a = 1
		ld	(zUpdatingSFX), a				; Set flag to update SFX

-		push	bc							; Save bc
		bit	7, (ix+zTrackPlaybackControl)	; Is track playing?
		call	nz, zSilenceStopTrack		; Branch if yes
		ld	de, zTrackSz					; Spacing between tracks
		add	ix, de							; ix = pointer to next track
		pop	bc								; Restore bc
		djnz	-							; Loop for each track
		call	zClearNextSound
		ret

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
		sub	1								; Remap index from 1h-32h to 0h-31h (see also credits music, above)
		ret	m								; Return if negative (id = 0)
		push	af							; Save af
		cp	MusID_1UP-1						; Is it the 1-up music?
		jp	nz, zPlayMusic_DoFade			; Branch if not
		ld	a, (zFadeInTimeout)				; Fading timeout
		or	a								; Is music being faded?
		jp	z, +							; Branch if not
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
+
		ld	a, (zFadeToPrevFlag)			; Get fade-to-prev flag
		cp	MusID_1UP-1						; Was it triggered by the 1-up song?
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
		ld	de, zTrackSz					; Spacing between tracks
		ld	b, (zTracksSaveEnd-zTracksSaveStart)/zTrackSz		; Number of tracks

-		ld	a, (hl)							; Get playback control byte for song
		and	7Fh								; Strip the 'playing' bit
		set	2, (hl)							; Set bit 2 (SFX overriding)
		ld	(hl), a							; But then overwrite the whole thing...
		add	hl, de							; Advance to next track
		djnz	-							; Loop for all tracks
		
		ld	a, MusID_1UP-1					; a = 1-up id-1
		ld	(zFadeToPrevFlag), a			; Set fade-to-prev flag to it
		ld	a, (zCurrentTempo)				; Get current tempo
		ld	(zCurrentTempoSave), a			; Save it
		ld	hl, (zVoiceTblPtr)				; Get voice table pointer
		ld	(zVoiceTblPtrSave), hl			; Save it
		jp	zBGMLoad
; ---------------------------------------------------------------------------

zPlayMusic_DoFade:
		call	zMusicFade					; Stop all music

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
		ld	(loc_5EB+1), hl					; Store into next instruction (self-modifying code)
loc_5EB:
		ld	a, (z80_MusicBanks)				; self-modified code; a is set to correct bank for the song to play
		ld	(zSongBank), a					; Save the song's bank...
		bankswitch2							; ... then bank switch to it
		ld	a, 0B6h							; Set Panning / AMS / FMS
		ld	(zYM2612_A1), a					; Write destination address to YM2612 address register
		nop
		ld	a, 0C0h							; default Panning / AMS / FMS settings (only stereo L/R enabled)
		ld	(zYM2612_D1), a					; Write to YM2612 data register
		pop	af								; Restore af
		ld	c, zID_MusicPointers4			; c = 4 (music pointer table)
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

-		push	bc							; Save bc (gets damaged by ldi instructions)
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
		ld	(zSongPosition), hl				; Store current potition in BGM data
		call	zInitFMDACTrack				; Init the remainder of the track RAM
		pop	bc								; Restore bc
		djnz	-							; Loop for all tracks (stored in b)
		
		ld	a, (iy+3)						; Get number of PSG tracks
		or	a								; Do we have any PSG channels?
		jp	z, zClearNextSound				; Branch if not
		ld	b, a							; b = number of PSG tracks
		ld	hl, zPSGInitBytes				; Load pointer to init data
		ld	(zTrackInitPos), hl				; Save it to RAM
		ld	de, zSongPSG1					; de = pointer to RAM for song PSG tracks
		ld	a, (iy+4)						; a = tempo divider

-		push	bc							; Save bc (gets damaged by ldi instructions)
		ld	hl, (zTrackInitPos)				; Restore saved position for init bytes
		ldi									; *de++ = *hl++
		ldi									; *de++ = *hl++
		ld	(de), a							; Copy tempo divider
		inc	de								; Advance pointer
		ld	(zTrackInitPos), hl				; Save current position in channel assignment bits
		ld	hl, (zSongPosition)				; Load current position in BGM data
		ld	bc, 6							; Copy 6 bytes
		ldir								; while (bc-- > 0) *de++ = *hl++; (copy track address, default key offset, default volume, modulation control, default PSG tone)
		ld	(zSongPosition), hl				; Store current potition in BGM data
		call	zZeroFillTrackRAM			; Init the remainder of the track RAM
		pop	bc								; Restore bc
		djnz	-							; Loop for all tracks (stored in b)

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
		db   80h,   6, 80h,   0, 80h,   1, 80h,   2, 80h,   4, 80h,   5, 80h,   6
;loc_6A3
; Default values for PSG tracks
; The first byte in every pair (always 80h) is default value for playback control bits.
; The second byte in every pair is the default values for PSG tracks.
zPSGInitBytes:
		db   80h, 80h, 80h, 0A0h, 80h, 0C0h
; ---------------------------------------------------------------------------
;loc_6A9
zPlaySound_CheckRing:
		sub	SndID__First					; Make it a 0-based index
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
		cp	SndID_Spindash-SndID__First		; Is this the spindash sound?
		jp	z, zPlaySound					; Branch if yes
		cp	SndID__FirstContinuous-SndID__First	; Is this before sound 0BCh?
		jp	c, zPlaySound_Normal			; Branch if yes
		push	af							; Save af
		ld	b, a							; b = sound index
		ld	a, (zContinousSFX)				; Load last continuous SFX played
		sub	b								; Is this the same continuous sound that was playing?
		jp	nz, zPlaySound_NotCont			; Branch if not
		ld	a, 80h							; a = 80h
		ld	(zContinousSFXFlag), a			; Flag continuous SFX as being extended
		rst	GetPointerTable					; hl = pointer to SFX data table
		pop	af								; Restore af
		ld	c, a							; c = SFX index; redundant, as PointerTableOffset does it already
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
		ld	(zContinousSFXFlag), a			; Clear continue continuous SFX flag
		pop	af								; Restore af
		ld	(zContinousSFX), a				; Store SFX index
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
		xor	a								; a = 0
		ld	(unk_1C15), a					; Set otherwise unused location to zero
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
		jr	z, +							; Branch if not (hint: it was cleared just below the bank switch above so... always)

		; Effectively dead code.
		; SPECULATION: It is possible that this was meant for GHZ-like waterfall
		; effects which were subsequently scrapped.
		; If this speculation is true, then it is likely that, after the call to
		; zGetSFXChannelPointers, we would have:
		; * ix = pointer to the overriding SFX track data in RAM;
		; * iy = pointer to the special SFX track data in RAM.
		; This code would then ensure that de points to the correct RAM area for
		; the writes below.
		pop		hl							; hl = pointer to SFX track data in RAM
		push	iy							; Save iy (pointer to SFX data)
+
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
		; SPECULATION: The code until the '+' label below was likely related to
		; GHZ-like waterfall effects which were subsequently scrapped.
		; If this speculation is true, then we would have at this point:
		; * ix = pointer to the overriding SFX track data in RAM;
		; * iy = pointer to the special SFX track data in RAM.
		; The code would then be checking to see if the corresponding SFX track
		; was playing, make sure the tracks refer to the same FM/PSG channel
		; then, if needed, mark the special SFX track as being overridden by the
		; SFX so as to not abruptly end the SFX.
		bit	7, (ix+zTrackPlaybackControl)	; Is the 'playing' bit set for this track?
		jr	z, +							; Branch if not (all SFX define it as 80h, so... never)
		ld	a, (ix+zTrackVoiceControl)		; Grab the voice control byte
		cp	(iy+zTrackVoiceControl)			; Is this equal to the one for this track? (hint: should be, we copied it above...)
		jr	nz, +							; Branch if not (hint: never...)
		set	2, (iy+zTrackPlaybackControl)	; Set bit 2 of playback control ('SFX is overriding this track') -- on *ROM*???
+
	endif

		push	hl							; Save hl
		ld	hl, (zSFXVoiceTblPtr)			; hl = pointer to voice data

	if fix_sndbugs=0
		ld	a, (zUpdatingSFX)				; Get flag
		or	a								; Are we updating SFX?
		jr	z, +							; Branch if not (hint: it was cleared just below the bank switch above so... always)

		; Effectively dead code.
		; SPECULATION: It is possible that this was meant for GHZ-like waterfall
		; effects which were subsequently scrapped.
		; If this speculation is true, then at this point we would have:
		; * ix = pointer to the overriding SFX track data in RAM;
		; * iy = pointer to the special SFX track data in RAM.
		; This code would then make ix point to the correct track data for the
		; function calls below.
		push	iy							; Save iy
		pop		ix							; ix = pointer to SFX data
+
	endif

		ld	(ix+zTrackVoicesLow), l			; Low byte of voice pointer
		ld	(ix+zTrackVoicesHigh), h		; High byte of voice pointer
		call	zKeyOffIfActive				; Kill channel notes
		call	zFMClearSSGEGOps			; Clear SSG-EG operators for track's channels
		pop		hl							; Restore hl
		pop		bc							; Restore bc
		djnz	zSFXTrackInitLoop			; Loop for all SFX tracks
		jp	zClearNextSound

; =============== S U B	R O U T	I N E =======================================
;
;sub_78F
zGetSFXChannelPointers:
		bit	7, c							; Is this a PSG track?
		jr	nz, +							; Branch if yes
		ld	a, c							; a = c
		bit	2, a							; Is this FM4, FM5 or FM6?
		jr	z, ++							; Branch if not
		dec	a								; Remove gap between FM3 and FM4+
		jr	++
; ---------------------------------------------------------------------------
+
		ld	a, 1Fh							; a = 1Fh (redundant, as this is the first instruction of the function)
		call	zSilencePSGChannel			; Silence channel at ix
		ld	a, 0FFh							; Command to silence PSG3/Noise channel (zSilencePSGChannel should do it...)
		ld	(zPSG), a						; Silence it (zSilencePSGChannel should do it...)
		ld	a, c							; a = channel identifier
			; The next 5 shifts are so that we can convert it to a table index
		srl	a
		srl	a
		srl	a
		srl	a
		srl	a
		add	a, 2							; Compensate for subtration below
+
		sub	2								; Start table at FM3
		ld	(zSFXSaveIndex), a				; Save index of overridden channel
		push	af							; Save af
		ld	hl, zSFXChannelData				; Pointer table for track RAM
		rst	PointerTableOffset				; hl = track RAM
		push	hl							; Save hl
		pop	ix								; ix = track RAM
		pop	af								; Restore af
		ld	hl, zSFXOverriddenChannel		; Pointer table for the overridden music track
		rst	PointerTableOffset				; hl = RAM destination to mark as overridden
		ret
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
		ld	(hl), zTrackSz					; Call subroutine stack pointer
		inc	hl								; Advance to next byte
		ld	(hl), 0C0h						; default Panning / AMS / FMS settings (only stereo L/R enabled)
		inc	hl								; Advance to next byte
		ld	(hl), 1							; Current note duration timeout

		ld	b, zTrackSz-zTrackDurationTimeout-1		; Loop counter

-		inc	hl								; Advance to next byte
		ld	(hl), 0							; Put 0 into this byte
		djnz	-							; Loop until end of track

		inc	hl								; Make hl point to next track
		ex	de, hl							; Exchange the contents of de and hl
		ret
; End of function zInitFMDACTrack

; ---------------------------------------------------------------------------
;zloc_7DF
zSFXChannelData:
		dw  zSFX_FM3						; FM3
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
		jp	m, +							; Branch if pause flag is negative (unpause)
		pop	de								; Pop return value from the stack, so that a 'ret' will go back to zVInt
		dec	a								; Decrease a
		ret	nz								; Return if nonzero
		ld	(hl), 2							; Set pause flag to 2 (i.e., stay paused but don't pause again)
		jp	zPauseAudio						; Pause all but FM6/DAC
; ---------------------------------------------------------------------------
+
		xor	a								; a = 0
		ld	(hl), a							; Clear pause flag
		ld	a, (zFadeOutTimeout)			; Get fade timeout
		or	a								; Is it zero?
		jp	nz, zMusicFade					; Stop all music if not
		ld	ix, zSongFM1					; Start with FM1 track
	if fix_sndbugs
		ld	b, (zSongPSG1-zSongFM1)/zTrackSz	; Number of tracks
	else
		; DANGER! This treats a PSG channel as if it were an FM channel. This
		; will break AMS/FMS/pan for FM1.

		ld	b, (zSongPSG2-zSongFM1)/zTrackSz	; Number of tracks
	endif

-		ld	a, (zHaltFlag)					; Get halt flag
		or	a								; Is song halted?
		jr	nz, +							; Branch if yes
		bit	7, (ix+zTrackPlaybackControl)	; Is track playing?
		jr	z, ++							; Branch if not
+
		ld	c, (ix+zTrackAMSFMSPan)			; Get track AMS/FMS/panning
		ld	a, 0B4h							; Command to select AMS/FMS/panning register
		call	zWriteFMIorII				; Write data to YM2612
+
		ld	de, zTrackSz					; Spacing between tracks
		add	ix, de							; Advance to next track
		djnz	-							; Loop for all tracks

	if fix_sndbugs
		ld	ix, zTracksSFXStart				; Start at the start of SFX track data
		ld	b, (zTracksSFXEnd-zTracksSFXStart)/zTrackSz		; Number of tracks
	else
		; DANGER! This code goes past the end of Z80 RAM and into reserved territory!
		; By luck, it only *reads* from these areas...

		ld	ix, zTracksSFXEnd				; Start at the END of SFX track data (?)
		ld	b, 7							; But loop for 7 tracks (??)
	endif

-		bit	7, (ix+zTrackPlaybackControl)	; Is track playing?
		jr	z, +							; Branch if not
		bit	7, (ix+zTrackVoiceControl)		; Is this a PSG track?
		jr	nz, +							; Branch if yes
		ld	c, (ix+zTrackAMSFMSPan)			; Get track AMS/FMS/panning
		ld	a, 0B4h							; Command to select AMS/FMS/panning register
		call	zWriteFMIorII				; Write data to YM2612
+
		ld	de, zTrackSz					; Spacing between tracks
		add	ix, de							; Go to next track
		djnz	-							; Loop for all tracks
		ret
; End of function zPauseUnpause

; =============== S U B	R O U T	I N E =======================================
; Fades out music.
;sub_85C
zFadeOutMusic:
		ld	a, 28h							; a = 28h
		ld	(zFadeOutTimeout),a				; Set fade timeout to this (start fading out music)
		ld	a, 6							; a = 6
		ld  (zFadeDelayTimeout), a			; Set fade delay timeout
		ld  (zFadeDelay), a					; Set fade delay and fall through

; =============== S U B	R O U T	I N E =======================================
; Halts FM6/DAC, PSG1, PSG2, PSG3.
;sub_869
zHaltDACPSG:
		xor	a								; a = 0
		ld	(zTracksStart), a				; Halt FM6/DAC
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
		jr	z, +							; Branch if it zero now
		ld	(zFadeDelayTimeout), a			; Store it back
		ret
; ---------------------------------------------------------------------------
+
		ld	a, (zFadeDelay)					; Get fade delay
		ld	(zFadeDelayTimeout), a			; Restore counter to initial value
		ld	a, (zFadeOutTimeout)			; a = fade timeout
		dec	a								; Decrement it
		ld	(zFadeOutTimeout), a			; Then store it back
		jp	z, zMusicFade					; Stop all music if it is zero
		ld	a, (zSongBank)					; a = current music bank ID
		bankswitch2							; Bank switch to music bank
		ld	ix, zTracksStart				; ix = pointer to track RAM
		ld	b, (zSongPSG1-zTracksStart)/zTrackSz	; Number of tracks

-		inc	(ix+zTrackVolume)				; Decrease volume
		jp	p, +							; If still positive, branch
		dec	(ix+zTrackVolume)				; Increase it back to minimum volume (127)
		jr	++
; ---------------------------------------------------------------------------
+
		bit	7, (ix+zTrackPlaybackControl)	; Is track still playing?
		jr	z, +							; Branch if not
		bit	2, (ix+zTrackPlaybackControl)	; Is SFX overriding track?
		jr	nz, +							; Branch if yes
		push	bc							; Save bc
		call	zSendTL						; Send new volume
		pop	bc								; Restore bc
+
		ld	de, zTrackSz					; Spacing between tracks
		add	ix, de							; Advance to next track
		djnz	-							; Loop for all tracks
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
		ld	a, (zFadeDelay)					; Get fade delay
		dec	a								; Decrement it
		ld	(zFadeDelay), a					; Store it back
		ret	nz								; Branch if it is not yet zero
		ld	a, (zFadeDelayTimeout)			; Get current fade delay timeout
		ld	(zFadeDelay), a					; Reset to starting fade delay
		ld	b, (zSongPSG1-zSongFM1)/zTrackSz	; Number of tracks
		ld	ix, zSongFM1					; ix = start of FM1 RAM
		ld	de, zTrackSz					; Spacing between tracks

-		ld	a, (ix+zTrackVolume)			; Get track volume
		dec	a								; Increase it
		ld	(ix+zTrackVolume), a			; Then store it back
		push	bc							; Save bc
		call	zSendTL						; Send new volume
		pop	bc								; Restore bc
		add	ix, de							; Advance to next track
		djnz	-							; Loop for all tracks
		
		ld	a, (zFadeInTimeout)				; Get fading timeout
		dec	a								; Decrement it
		ld	(zFadeInTimeout), a				; Then store it back
		ret	nz								; Return if still fading
		ld	b, (zTracksEnd-zSongPSG1)/zTrackSz	; Number of tracks
		ld	ix, zSongPSG1					; ix = start of PSG RAM
		ld	de, zTrackSz					; Spacing between tracks

-		res	2, (ix+zTrackPlaybackControl)	; Clear 'SFX is overriding' bit
		add	ix, de							; Advance to next track
		djnz	-							; Loop for all tracks
		
		ld	ix, zTracksStart				; ix = start of DAC/FM6 RAM
		res	2, (ix+zTrackPlaybackControl)	; Clear 'SFX is overriding' bit
		ret
; End of function zDoMusicFadeIn


; =============== S U B	R O U T	I N E =======================================
; Wipes music data and fades all FM, PSG and DAC channels.
;sub_944
zMusicFade:
		; The following block sets to zero the z80 RAM from 1C0Dh to 1FD4h
		ld	hl, zFadeOutTimeout				; Starting source address for copy
		ld	de, zFadeDelay					; Starting destination address for copy
		ld	bc, 3C6h						; Length of copy
		ld	(hl), 0							; Initial value of zero
		ldir								; while (--0x3c6) *de++ = *hl++

		xor	a								; a = 0
		ld	(zTempoSpeedup), a				; Fade in normal speed
		
		ld	ix, zFMDACInitBytes				; Initialization data for channels
		ld	b, (zSongPSG2-zSongFM1)/zTrackSz	; Number of channels

-		push	bc							; Save bc for loop
		call	zFMSilenceChannel			; Silence track's channel
		call	zFMClearSSGEGOps			; Clears the SSG-EG operators for this channel
		inc	ix								; Go to next channel byte
		inc	ix								; But skip the 80h
		pop	bc								; Restore bc for loop counter
		djnz	-							; Loop while b > 0
		
		ld	b, 7							; Unused
		xor	a								; a = 0
		ld	(zFadeOutTimeout), a			; Set fade timeout to zero... again
		call	zPSGSilenceAll				; Silence PSG
		ld	c, 0							; Write a zero...
		ld	a, 2Bh							; ... to DAC enable register
		call	zWriteFMI					; Disable DAC

;loc_979
zFM3NormalMode:
		xor	a								; a = 0
		ld	(zFM3Settings), a				; Save FM3 settings
		ld	c, a							; FM3 mode: normal mode
		ld	a, 27h							; FM3 special settings
		call	zWriteFMI					; Set it
		jp	zClearNextSound
; End of function zMusicFade

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
		call	zPSGSilenceAll				; Redundant, as function falls-through to it anyway
		push	bc							; Save bc
		push	af							; Save af
		ld	b, 3							; FM1/FM2/FM3
		ld	a, 0B4h							; Command to select AMS/FMS/panning register (FM1)
		ld	c, 0							; AMS=FMS=panning=0

-		push	af							; Save af
		call	zWriteFMI					; Write reg/data pair to YM2612
		pop	af								; Restore af
		inc	a								; Advance to next channel
		djnz	-							; Loop for all channels

		ld	b, 2							; FM4 and FM5, but not FM6
		ld	a, 0B4h							; Command to select AMS/FMS/panning register

-		push	af							; Save af
		call	zWriteFMII					; Write reg/data pair to YM2612
		pop	af								; Restore af
		inc	a								; Advance to next channel
		djnz	-							; Loop for all channels

		ld	c, 0							; Note off for all operators
		ld	b, 6							; 5 FM channels + 1 gap between FM3 and FM4 (NOT FM6)
		ld	a, 28h							; Command to send note on/off

-		push	af							; Save af
		call	zWriteFMI					; Write reg/data pair to YM2612
		inc	c								; Next channel
		pop	af								; Restore af
		djnz	-							; Loop for all channels

		pop	af								; Restore af
		pop	bc								; restore bc and fall through

; =============== S U B	R O U T	I N E =======================================
; Silences all PSG channels, including the noise channel.
;
; Output: a    Damaged
;sub_9BC
zPSGSilenceAll:
		push	bc							; Save bc
		ld	b, 4							; Loop 4 times: 3 PSG channels + noise channel
		ld	a, 9Fh							; Command to silence PSG1

-		ld	(zPSG), a						; Write command
		add	a, 20h							; Next channel
		djnz	-							; Loop for all PSG channels
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
		ld	hl, zTracksStart+zTrackDurationTimeout		; Duration timeout of first track
		ld	de, zTrackSz					; Spacing between tracks
		ld	b, (zTracksEnd-zTracksStart)/zTrackSz	; Number of tracks

-		inc	(hl)							; Delay notes another frame
		add	hl, de							; Advance to next track
		djnz	-							; Loop for all channels
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
		call	zSetFMMinD1LRR
		ld	a, 40h							; Set total level...
		ld	c, 7Fh							; ... to minimum envelope amplitude...
		call	zFMOperatorWriteLoop		; ... for all operators of this track's channel
		ld	c, (ix+zTrackVoiceControl)		; Send key off
		jp	zKeyOnOff
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
zSetFMMinD1LRR:
		ld	a, 80h							; Set D1L to minimum and RR to maximum...
		ld	c, 0FFh							; ... for all operators on this track's channel (fall through)
; End of function zSetFMMinD1LRR


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

-		push	af							; Save af
		call	zWriteFMIorII				; Write to part I or II, as appropriate
		pop	af								; Restore af
		add	a, 4							; a += 4
		djnz	-							; Loop
		ret
; End of function zFMOperatorWriteLoop

; ---------------------------------------------------------------------------
;loc_A16
zPlaySegaSound:
		call	zMusicFade					; Fade music before playing the sound
		ld	a, 1							; a = 1
		ld	(PlaySegaPCMFlag), a			; Set flag to play SEGA sound
		pop	hl								; Restore hl
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
		ld	a, (zTracksStart)				; a = FM6/DAC track playback control
		or	84h								; Set 'track is playing' and 'track is resting' flags
		ld	(zTracksStart), a				; Set new value
		ld	ix, zSongFM1					; ix = pointer to FM1 track RAM
		ld	b, (zTracksEnd-zSongFM1)/zTrackSz	; Number of tracks

-		ld	a, (ix+zTrackPlaybackControl)	; a = track playback control
		or	84h								; Set 'track is playing' and 'track is resting' flags
		ld	(ix+zTrackPlaybackControl), a	; Set new value
		bit	7, (ix+zTrackVoiceControl)		; Is this a PSG track?
		jp	nz, +							; Branch if yes
		res	2, (ix+zTrackPlaybackControl)	; Clear 'SFX is overriding track' flag
		ld	a, (ix+zTrackVolume)			; Get track volume
		add	a, 40h							; Lower volume by 40h
		ld	(ix+zTrackVolume), a			; Store new volume
		ld	a, (ix+zTrackVoiceIndex)		; a = FM instrument
		push	bc							; Save bc
		ld	b, a							; b = FM instrument
		call	zGetFMInstrumentPointer		; hl = pointer to instrument data
		call	zSendFMInstrument			; Send instrument
		pop	bc								; Restore bc
+
		ld	de, zTrackSz					; Spacing between tracks
		add	ix, de							; ix = pointer to next track
		djnz	-							; Loop for all tracks

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
		; This table starts with 12 notes not in S1 or S2:
		dw 3FFh,3FFh,3FFh,3FFh,3FFh,3FFh,3FFh,3FFh,3FFh,3F7h,3BEh,388h
		; The following notes are present on S1 and S2 too:
		dw 356h,326h,2F9h,2CEh,2A5h,280h,25Ch,23Ah,21Ah,1FBh,1DFh,1C4h
		dw 1ABh,193h,17Dh,167h,153h,140h,12Eh,11Dh,10Dh,0FEh,0EFh,0E2h
		dw 0D6h,0C9h,0BEh,0B4h,0A9h,0A0h,097h,08Fh,087h,07Fh,078h,071h
		dw 06Bh,065h,05Fh,05Ah,055h,050h,04Bh,047h,043h,040h,03Ch,039h
		dw 036h,033h,030h,02Dh,02Bh,028h,026h,024h,022h,020h,01Fh,01Dh
		dw 01Bh,01Ah,018h,017h,016h,015h,013h,012h,011h,010h,000h,000h
		; Then, it falls through to the 12 base notes from FM octaves.
;loc_B4D
zFMFrequencies:
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
		call	zTrackRunTimer				; Advance track duration timer
		ret	nz								; Branch if note is still going
		ld	e, (ix+zTrackDataPointerLow)	; e = low byte of track data pointer
		ld	d, (ix+zTrackDataPointerHigh)	; d = high byte of track data pointer

;loc_BA2
zUpdateDACTrack_cont:
		ld	a, (de)							; Get next byte from track
		inc	de								; Advance pointer
		cp	FirstCoordFlag					; Is it a coordination flag?
		jp	nc, zHandleDACCoordFlag			; Branch if yes
		or	a								; Is it a note?
		jp	m, +							; Branch if yes
		dec	de								; We got a duration, so go back to it
		ld	a, (ix+zTrackSavedDAC)			; Reuse previous DAC sample
+
		ld	(ix+zTrackSavedDAC), a			; Store new DAC sample
		cp	NoteRest						; Is it a rest?
		jp	z, ++							; Branch if yes
		res	7, a							; Clear bit 7
		push	de							; Save de
		ex	af, af'							; Save af
		call	zKeyOffIfActive				; Kill note (will do nothing if 'do not attack' is on)
		call	zFM3NormalMode				; Set FM3 to normal mode
		ex	af, af'							; Restore af
		ld	ix, zTracksStart				; ix = pointer to start of track data
		bit	2, (ix+zTrackPlaybackControl)	; Is SFX overriding DAC channel?
		jp	nz, +							; Branch if yes
		ld	(zDACIndex), a					; Queue DAC sample
+
		pop	de								; Restore de
+
		ld	a, (de)							; Get note duration
		inc	de								; Advance pointer
		or	a								; Is it a duration?
		jp	p, zStoreDuration				; Branch if yes
		dec	de								; Put the byte back to the stream
		ld	a, (ix+zTrackSavedDuration)		; Reuse last duration
		ld	(ix+zTrackDurationTimeout), a	; Set new duration timeout
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
		dw cfAlterNoteFreq					; 0E1h
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
		dw cfSetPSGTone						; 0F5h
		dw cfJumpTo							; 0F6h
		dw cfRepeatAtPos					; 0F7h
		dw cfJumpToGosub					; 0F8h
		dw cfJumpReturn						; 0F9h
		dw cfDisableModulation				; 0FAh
		dw cfAddKey							; 0FBh
		dw cfLoopContinuousSFX				; 0FCh
		dw cfToggleAlternateSMPS			; 0FDh
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
		dw cfFMFlutter						; 0FFh 06h
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
		ld	a, (ix+zTrackAMSFMSPan)			; Get current AMS/FMS/panning
		and	c								; Mask out L+R
		push	de							; Store de
		ex	de, hl							; Exchange de and hl
		or	(hl)							; Mask in the new panning; may also add AMS/FMS
		ld	(ix+zTrackAMSFMSPan), a			; Store new value in track RAM
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
		add	a, (ix+zTrackKeyOffset)			; Add in current track key offset
		ld	(ix+zTrackKeyOffset), a			; Store result as new track key offset
		cp	10h								; Is the current transposition 10h?
		jp	z, +							; Branch if yes
		inc	(hl)							; Otherwise, increase escalating transposition
+
		dec	de								; Put parameter byte back
		ret
; End of function cfSpindashRev


; =============== S U B	R O U T	I N E =======================================
; Sets frequency displacement (signed). The final note frequency is shifted
; by this value.
;
; Has one parameter byte, the new frequency displacement.
;
;sub_C77
cfAlterNoteFreq:
		ld	(ix+zTrackFreqDisplacement), a	; Set frequency displacement
		ret
; End of function cfAlterNoteFreq


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
		call	zFMSilenceChannel
		jp	cfStopTrack
; End of function cfSilenceStopTrack

; =============== S U B	R O U T	I N E =======================================
; Sets track volume.
;
; Has one parameter byte, the volume.
;
; For FM tracks, this is a 7-bit value from 0 (lowest volume) to 127 (highest
; volume). The value is XOR'ed with 7Fh before being sent, then stripped of the
; sign bit. The volume change takes effect immediatelly.
;
; For PSG tracks, this is a 4-bit value ranging from 8 (lowest volume) to 78h
; (highest volume). The value is shifted 3 bits to the right, XOR'ed with 0Fh
; and AND'ed with 0Fh before being uploaded, so the sign bit and the lower 3
; bits are discarded.
;
;loc_C85
cfSetVolume:
		bit	7, (ix+zTrackVoiceControl)		; Is this a PSG channel?
		jr	z, +							; Branch if not
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
+
		xor	7Fh								; Invert parameter byte (except irrelevant sign bit)
		and	7Fh								; Strip sign bit
		ld	(ix+zTrackVolume), a			; Set as new track volume
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
		bit	7, (ix+zTrackVoiceControl)		; Is this a PSG track?
		ret	nz								; Return if yes
		add	a, (ix+zTrackVolume)			; Add in track's current volume
		jp	p, ++							; Branch if result is still positive
		jp	pe, +							; Branch if addition overflowed into more than 127 positive
		xor	a								; Set maximum volume
		jp	++
; ---------------------------------------------------------------------------
+
		ld	a, 7Fh							; Set minimum volume
+
		ld	(ix+zTrackVolume), a			; Store new volume

; =============== S U B	R O U T	I N E =======================================
; Subroutine to send TL information to YM2612.
;
;sub_CBA
zSendTL:
		push	de							; Save de
		ld	de, zFMInstrumentTLTable		; de = pointer to FM TL register table
		ld	l, (ix+zTrackTLPtrLow)			; l = low byte of pointer to instrument's TL data
		ld	h, (ix+zTrackTLPtrHigh)			; h = high byte of pointer to instrument's TL data
		ld	b, zFMInstrumentTLTable_End-zFMInstrumentTLTable	; Number of entries

-		ld	a, (hl)							; a = register data
		or	a								; Is it positive?
		jp	p, +							; Branch if yes
		add	a, (ix+zTrackVolume)			; Add track's volume to it
+
		and	7Fh								; Strip sign bit
		ld	c, a							; c = new volume for operator
		ld	a, (de)							; a = register write command
		call	zWriteFMIorII				; Send it to YM2612
		inc	de								; Advance pointer
		inc	hl								; Advance pointer
		djnz	-							; Loop

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
		set	1, (ix+zTrackPlaybackControl)	; Set flag to prevent attack
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
		ld	(ix+zTrackNoteFillTimeout), a	; Store result into note fill timeout
		ld	(ix+zTrackNoteFillMaster), a	; Store master copy of note fill
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
		add	a, zTrackLoopCounters			; Add offset into loop counters
		ld	c, a							; c = offset of current loop conuter
		ld	b, 0							; bc = sign-extended offset to current loop counter
		push	ix							; Save track RAM pointer
		pop	hl								; hl = pointer to track RAM
		add	hl, bc							; hl = pointer in RAM to current loop conuter
		ld	a, (hl)							; a = value of current loop counter
		dec	a								; Decrement loop counter (note: value is not saved!)
		jp	z, +							; Branch if result is zero
		inc	de								; Skip another byte
		ret
; ---------------------------------------------------------------------------
+
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
		bit	7, (ix+zTrackVoiceControl)		; Is this a PSG channel?
		ret	z								; Return if not
		res	4, (ix+zTrackPlaybackControl)	; Clear 'track is resting' flag
		dec	(ix+zTrackVolFlutter)			; Decrement flutter index
		add	a, (ix+zTrackVolume)			; Add track's current volume
		cp	0Fh								; Is it 0Fh or more?
		jp	c, zStoreTrackVolume			; Branch if not
		ld	a, 0Fh							; Limit to 0Fh (silence)

;loc_D17
zStoreTrackVolume:
		ld	(ix+zTrackVolume), a			; Store new volume
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
		ld	(ix+zTrackKeyOffset), a			; Store result as new key displacement
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
		call	zWriteFMI					; Send it to YM2612
		ret

;loc_D28
zGetFMParams:
		ex	de, hl							; Exchange de and hl
		ld	a, (hl)							; Get YM2612 regigter selector
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
		bit	7, (ix+zTrackVoiceControl)		; Is this a PSG track?
		jr	nz, zSetVoicePSG				; Branch if yes
		call	zSetFMMinD1LRR				; Set minimum D1L/RR for channel
		ld	a, (de)							; Get voice index
		ld	(ix+zTrackVoiceIndex), a		; Store to track RAM
		or	a								; Is it negative?
		jp	p, zSetVoiceUpload				; Branch if not
		inc	de								; Advance pointer
		ld	a, (de)							; Get song ID whose bank is desired
		ld	(ix+zTrackVoiceSongID), a		; Store to track RAM and fall-through

; =============== S U B	R O U T	I N E =======================================
; Uploads the FM instrument from another song's voice bank.
;
;sub_D44
zSetVoiceUploadAlter:
		push	de							; Save de
		ld	a, (ix+zTrackVoiceSongID)		; Get saved song ID for instrument data
		sub	81h								; Convert it to a zero-based index
		ld	c, zID_MusicPointers4			; Value for music pointer table
		rst	GetPointerTable					; hl = pointer to music pointer table
		rst	PointerTableOffset				; hl = pointer to music data
		rst	ReadPointer						; hl = pointer to music voice data
		ld	a, (ix+zTrackVoiceIndex)		; Get voice index
		and	7Fh								; Strip sign bit
		ld	b, a							; b = voice index
		call	zGetFMInstrumentOffset		; hl = pointer to voice data
		jr	+
; ---------------------------------------------------------------------------
;loc_D5A
zSetVoiceUpload:
		push	de							; Save de
		ld	b, a							; b = instrument index
		call	zGetFMInstrumentPointer		; hl = pointer to instrument data
+
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
		ld	(ix+zTrackModulationPtrLow), e	; Store low byte of modulation data pointer
		ld	(ix+zTrackModulationPtrHigh), d	; Store high byte of modulation data pointer
		ld	(ix+zTrackModulationCtrl), 80h	; Toggle modulation on
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
		bit	7, (ix+zTrackVoiceControl)		; Is this a PSG track?
		jr	nz, cfSetModulation				; Branch if yes
		ld	a, (de)							; Get new modulation status

; =============== S U B	R O U T	I N E =======================================
; Sets modulation status.
;
; Has one parameter byte, the new modulation status.
;
;loc_D83
cfSetModulation:
		ld	(ix+zTrackModulationCtrl), a	; Set modulation status
		ret

; =============== S U B	R O U T	I N E =======================================
; Stops the current track.
;
; Technically, it has a parameter byte, but it is irrelevant and unused.
;
;loc_D87
cfStopTrack:
		res	7, (ix+zTrackPlaybackControl)	; Clear 'track playing' flag
		ld	a, 1Fh							; a = 1Fh
		ld	(unk_1C15), a					; Set otherwise unused location to 1Fh
		call	zKeyOffIfActive				; Send key off for track channel
		ld	c, (ix+zTrackVoiceControl)		; c = voice control bits
		push	ix							; Save track pointer
		call	zGetSFXChannelPointers		; ix = track pointer, hl = overridden track pointer
		ld	a, (zUpdatingSFX)				; Get flag
		or	a								; Are we updating SFX?
		jp	z, zStopCleanExit				; Exit if not
		xor	a								; a = 0
		ld	(unk_1C18), a					; Set otherwise unused value to zero
		push	hl							; Save hl
		ld	hl, (zVoiceTblPtr)				; hl = pointer to voice table
		pop	ix								; ix = overridden track's pointer
		res	2, (ix+zTrackPlaybackControl)	; Clear 'SFX is overriding' bit
		bit	7, (ix+zTrackVoiceControl)		; Is this a PSG channel?
		jr	nz, zStopPSGTrack				; Branch if yes
		bit	7, (ix+zTrackPlaybackControl)	; Is 'track playing' bit set?
		jr	z, zStopCleanExit				; Exit if not
		ld	a, 2							; a = 2 (FM3)
		cp	(ix+zTrackVoiceControl)			; Is this track for FM3?
		jr	nz, ++							; Branch if not
		ld	a, 4Fh							; FM3 settings: special mode, enable and load A/B
		bit	0, (ix+zTrackPlaybackControl)	; Is FM3 in special mode?
		jr	nz, +							; Branch if yes
		and	0Fh								; FM3 settings: normal mode, enable and load A/B
+
		call	zWriteFM3Settings			; Set the above FM3 settings
+
		ld	a, (ix+zTrackVoiceIndex)		; Get FM instrument
		or	a								; Is it positive?
		jp	p, +							; Branch if yes
		call	zSetVoiceUploadAlter		; Upload the voice from another song's voice bank
		jr	++
; ---------------------------------------------------------------------------
+
		ld	b, a							; b = FM instrument
		push	hl							; Save hl
		bankswitchToMusic					; Bank switch to song bank
		pop	hl								; Restore hl
		call	zGetFMInstrumentOffset		; hl = pointer to instrument data
		call	zSendFMInstrument			; Send FM instrument
		ld	a, zmake68kBank(SndBank)		; Get SFX bank
		bankswitch2							; Bank switch to it
		ld	a, (ix+zTrackHaveSSGEGFlag)		; Get custom SSG-EG flag
		or	a								; Does track have custom SSG-EG data?
		jp	p, zStopCleanExit				; Exit if not
		ld	e, (ix+zTrackSSGEGPointerLow)	; e = low byte of pointer to SSG-EG data
		ld	d, (ix+zTrackSSGEGPointerHigh)	; d = high byte of pointer to SSG-EG data
+
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
		bit	0, (ix+zTrackPlaybackControl)	; Is this a noise channel?
		jr	z, zStopCleanExit				; Exit if not
		ld	a, (ix+zTrackPSGNoise)			; Get track's PSG noise setting
		or	a								; Is it an actual noise?
		jp	p, +							; Branch if not
		ld	(zPSG), a						; Send it to PSG
+
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
		bit	7, (ix+zTrackVoiceControl)		; Is this a PSG track?
		ret	z								; Return if not
		ld	(ix+zTrackPSGNoise), a			; Store to track RAM
		set	0, (ix+zTrackPlaybackControl)	; Mark PSG track as being noise
		or	a								; Test noise value
		ld	a, 0DFh							; Command to silence PSG3
		jr	nz, +							; If nonzero, branch
		res	0, (ix+zTrackPlaybackControl)	; Otherwise, mark track as not being a noise channel
		ld	a, 0FFh							; Command to silence the noise channel
+
		bit	2, (ix+zTrackPlaybackControl)	; Is SFX overriding this track?
		ret	nz								; Return if yes
		ld	(zPSG), a						; Execute it
		ld	a, (de)							; Get PSG noise value
		ld	(zPSG), a						; Send command to PSG
	else
		bit	2, (ix+zTrackVoiceControl)		; Is this a channel bound for part II (FM4, FM5, FM6/DAC)?
		ret	nz								; Return if yes
		ld	a, 0DFh							; Command to silence PSG3
		ld	(zPSG), a						; Execute it
		ld	a, (de)							; Get PSG noise value
		ld	(ix+zTrackPSGNoise), a			; Store to track RAM
		set	0, (ix+zTrackPlaybackControl)	; Mark PSG track as being noise
		or	a								; Test noise value
		jr	nz, +							; If nonzero, branch
		res	0, (ix+zTrackPlaybackControl)	; Otherwise, mark track as not being a noise channel
		ld	a, 0FFh							; Command to silence the noise channel
+
		ld	(zPSG), a						; Send command to PSG
	endif
		ret

; =============== S U B	R O U T	I N E =======================================
; Set PSG tone.
;
; Has one parameter byte, the new PSG tone to use.
;
;loc_E58
cfSetPSGTone:
		bit	7, (ix+zTrackVoiceControl)		; Is this a PSG track?
		ret	z								; Return if not

;loc_E5D
cfStoreNewVoice:
		ld	(ix+zTrackVoiceIndex), a		; Store voice
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
		add	a, zTrackLoopCounters			; Add offset into loop counters
		ld	c, a							; c = offset of current loop conuter
		ld	b, 0							; bc = sign-extended offset to current loop counter
		push	ix							; Save track RAM pointer
		pop	hl								; hl = pointer to track RAM
		add	hl, bc							; hl = pointer in RAM to current loop conuter
		ld	a, (hl)							; a = value of current loop counter
		or	a								; Is loop counter zero?
		jr	nz, +							; Branch if not
		ld	a, (de)							; Get repeat counter
		ld	(hl), a							; Reset loop counter to it
+
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
		dec	(ix+zTrackStackPointer)			; Decrement track stack pointer
		ld	c, (ix+zTrackStackPointer)		; c = track stack pointer
		dec	(ix+zTrackStackPointer)			; Decrement track stack pointer again
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
		ld	c, (ix+zTrackStackPointer)		; c = offset to top of return stack
		ld	b, 0							; b = 0
		add	hl, bc							; hl = pointer to top of return stack
		ld	e, (hl)							; e = low byte of return address
		inc	hl								; Advance pointer
		ld	d, (hl)							; de = return address
		inc	(ix+zTrackStackPointer)			; Pop byte from return stack
		inc	(ix+zTrackStackPointer)			; Pop byte from return stack
		ret

; =============== S U B	R O U T	I N E =======================================
; Clears sign bit of modulation control, disabling normal modulation.
;
; Has no parameter bytes.
;
;loc_EAB
cfDisableModulation:
		res	7, (ix+zTrackModulationCtrl)	; Clear bit 7 of modulation control
		dec	de								; Put byte back
		ret

; =============== S U B	R O U T	I N E =======================================
; Adds a signed value to channel key displacement.
;
; Has one parameter byte, the change in channel key displacement.
;
;loc_EB1
cfAddKey:
		add	a, (ix+zTrackKeyOffset)			; Add current key displacement to parameter
		ld	(ix+zTrackKeyOffset), a			; Store result as new key displacement
		ret

; =============== S U B	R O U T	I N E =======================================
; If a continuous SFX is playing, it will continue playing from target address.
; A loop conuter is decremented (it is initialized to number of SFX tracks)
; for continuous SFX; if the result is zero, the continuous SFX will be flagged
; to stop.
; Non-continuous SFX do not loop.
;
; Has a 2-byte parameter, the jump target address.
;
;loc_EB8
cfLoopContinuousSFX:
		ld	a, (zContinousSFXFlag)			; Get 'continuous sound effect' flag
		cp	80h								; Is it equal to 80h?
		jp	z, +							; Branch if yes
		xor	a								; a = 0
		ld	(zContinousSFX), a				; Clear last continuous SFX played
		ld	(zContinousSFXFlag), a			; Clear continous sound effect flag
		inc	de								; Skip a byte
		ret
; ---------------------------------------------------------------------------
+
		ld	a, (zContSFXLoopCnt)			; Get number loops to perform
		dec	a								; Decrement it...
		ld	(zContSFXLoopCnt), a			; ... and store it back
		jp	nz, cfJumpTo					; If result is non-zero, jump to target address
		xor	a								; a = 0
		ld	(zContinousSFXFlag), a			; Clear continous sound effect flag
		jp	cfJumpTo						; Jump to target address

; =============== S U B	R O U T	I N E =======================================
; Toggles alternate SMPS mode according to parameter.
;
; Has a single byte parameter: is 1, enables alternate SMPS mode, otherwise
; disables it.
;
;loc_EDA
cfToggleAlternateSMPS:
		cp	1								; Is parameter equal to 1?
		jr	nz, +							; Branch if not
		set	3, (ix+zTrackPlaybackControl)	; Start alternate SMPS mode for track
		ret
; ---------------------------------------------------------------------------
+
		res	3, (ix+zTrackPlaybackControl)	; Stop alternate SMPS mode for track
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
		ld	a, (ix+zTrackVoiceControl)		; Get track's voice control
		cp	2								; Is this FM3?
		jr	nz, zTrackSkip3bytes			; Branch if not
		set	0, (ix+zTrackPlaybackControl)	; Put FM3 in special mode
		ex	de, hl							; Exchange de and hl
	if fix_sndbugs
		call	zGetSpecialFM3DataPointer	; de = pointer to saved FM3 frequency shifts
	else
		call	znullsub_A					; Do nothing (this was likely supposed to set de to a sensible value)
	endif
		ld	b, 4							; Loop counter: 4 parameter bytes

		; DANGER! The following code will trash the Z80 code due to failed
		; initialization of de. At the start of the function, hl was a pointer
		; to the coord. flag switch table entry that had the address of this
		; function; after 'ex	de, hl', now de is this pointer.
		; After the code below, the targets of the last few coord. flag handlers
		; will be overwritten by the nonsensical numbers at the lookup table.
-		push	bc							; Save bc
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
		djnz	-							; Loop for all parameters

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
		ld	(zFM3Settings), a				; Save FM3 settings
		ld	c, a							; c = FM3 settings
		ld	a, 27h							; Write data to FM3 settigns register
		call	zWriteFMI					; Do it
		ret
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
; as zFMSendFreq, use invalid addresses for read and write (respectivelly), so
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
		jr	z, +							; Branch if not
		push	ix							; Save ix
		push	de							; Save de
		ld	ix, zTracksStart				; Start of song RAM
		ld	b, (zTracksEnd-zTracksStart)/zTrackSz	; Number of tracks
		ld	de, zTrackSz					; Spacing between tracks

-		res	7, (ix+zTrackPlaybackControl)	; Clear 'track is playing' bit
		call	zKeyOff						; Stop current note
		add	ix, de							; Advance to next track
		djnz	-							; Loop for all tracks
		pop	de								; Restore de
		pop	ix								; Restore ix
		jp	zPSGSilenceAll
; ---------------------------------------------------------------------------
+
		push	ix							; Save ix
		push	de							; Save de
		ld	ix, zTracksStart				; Start of song RAM
		ld	b, (zTracksEnd-zTracksStart)/zTrackSz	; Number of tracks
		ld	de, zTrackSz					; Spacing between tracks

-		set	7, (ix+zTrackPlaybackControl)	;Set 'track is playing' bit
		add	ix, de							; Advance to next track
		djnz	-							; Loop for all tracks
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
		ld	b, (zTracksEnd-zTracksStart)/zTrackSz	; Number of tracks
		ld	hl, zTracksStart+zTrackTempoDivider	; Want to change tempo dividers

-		push	bc							; Save bc
		ld	bc, zTrackSz					; Spacing between tracks
		ld	(hl), a							; Set tempo divider for track
		add	hl, bc							; Advance to next track
		pop	bc								; Restore bc
		djnz	-
		ret

; =============== S U B	R O U T	I N E =======================================
; Sets SSG-EG data for current track.
;
; Has 4 parameter bytes, the operator parameters for SSG-EG data desired.
;
;loc_F9A
cfSetSSGEG:
		ld	(ix+zTrackHaveSSGEGFlag), 80h	; Set custom SSG-EG data flag
		ld	(ix+zTrackSSGEGPointerLow), e	; Save low byte of SSG-EG data pointer
		ld	(ix+zTrackSSGEGPointerHigh), d	; Save high byte of SSG-EG data pointer

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
		ld	l, (ix+zTrackTLPtrLow)			; l = low byte of pointer to TL data
		ld	h, (ix+zTrackTLPtrHigh)			; hl = pointer to TL data
		ld	bc, zFMInstrumentTLTable-zFMInstrumentRSARTable		; bc = -10h
		add	hl, bc							; hl = pointer to RS/AR data
		push	hl							; Save hl (**)
	endif
		ld	hl, zFMInstrumentSSGEGTable		; hl = pointer to registers for SSG-EG data
		ld	b, zFMInstrumentSSGEGTable_End-zFMInstrumentSSGEGTable	; Number of entries

-		ld	a, (de)							; Get data to sent to SSG-EG register
		inc	de								; Advance pointer
		ld	c, a							; c = data to send
		ld	a, (hl)							; a = register to send to
		inc	hl								; Advance pointer
	if fix_sndbugs
		push	af							; Save af
		call	zWriteFMIorII				; Send data to correct channel
		ex	(sp), hl						; Save hl, hl = pointer to RS/AR data (see line marked (**) above)
		ld	a, (hl)							; a = RS/AR value for operator
		inc	hl								; Advance pointer
		ex	(sp), hl						; Save hl, hl = pointer to registers for SSG-EG data
		or	1Fh								; Set AR to maximum, but keep RS intact
		ld	c, a							; c = RS/AR
		pop	af								; Restore af
		sub	40h								; Convert into command to set RS/AR
	endif
		call	zWriteFMIorII				; Send data to correct channel
		djnz	-							; Loop for all registers
	if fix_sndbugs
		pop	hl								; Remove from stack (see line marked (**) above)
	endif
		dec	de								; Rewind data pointer a bit
		ret
; End of function zSendSSGEGData

; =============== S U B	R O U T	I N E =======================================
; Starts or controls FM flutter, according to the parameters.
;
; Has two parameter bytes: the first is a (1-based) index into the PSG flutter
; table indicating how the flutter should go, while the second is a bitmask
; indicating which operators should be affected (in the form %00004231) for
; the current channel.
;
;loc_FB5
cfFMFlutter:
		ld	(ix+zTrackFMFlutter), a			; Store flutter index
		inc	de								; Advance track pointer
		ld	a, (de)							; Get flutter mask
		ld	(ix+zTrackFMFlutterMask), a		; Store flutter bitmask
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
		call	zTrackRunTimer				; Run note timer
		jr	nz, +							; Branch if note hasn't expired yet
		call	zGetNextNote				; Get next note for PSG track
		bit	4, (ix+zTrackPlaybackControl)	; Is track resting?
		ret	nz								; Return if yes
		call	zPrepareModulation			; Initialize modulation
		jr	++
; ---------------------------------------------------------------------------
+
		ld	a, (ix+zTrackNoteFillTimeout)	; Get note fill
		or	a								; Has timeout expired?
		jr	z, +							; Branch if yes
		dec	(ix+zTrackNoteFillTimeout)		; Update note fill
		jp	z, zRestTrack					; Put PSG track at rest if needed
+
		call	zUpdateFreq					; Add frequency displacement to frequency
		call	zDoModulation				; Do modulation
		bit	2, (ix+zTrackPlaybackControl)	; Is SFX overriding this track?
		ret	nz								; Return if yes
		ld	c, (ix+zTrackVoiceControl)		; c = voice control byte
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
		ld	a, (ix+zTrackVoiceIndex)		; Get PSG tone
		or	a								; Test if it is zero
		ld	c, 0							; c = 0
		jr	z, +							; Branch if no PSG tone
		dec	a								; Make it into a 0-based index
		ld	c, zID_PSGTonePointers			; Value for PSG tone pointer table
		rst	GetPointerTable					; hl = pointer to PSG flutter table
		rst	PointerTableOffset				; hl = pointer to PSG flutter for track
		call	zDoFlutter					; Get new flutter value
		ld	c, a							; c = new flutter value
+
		bit	4, (ix+zTrackPlaybackControl)	; Is track resting?
		ret	nz								; Return if yes
		ld	a, (ix+zTrackVolume)			; Get track volume
		add	a, c							; Add flutter to it
		bit	4, a							; Is bit 4 set?
		jr	z, +							; Branch if not
		ld	a, 0Fh							; Set silence on PSG track
+
		or	(ix+zTrackVoiceControl)			; Mask in the PSG channel bits
		add	a, 10h							; Flag to latch volume
		bit	0, (ix+zTrackPlaybackControl)	; Is this a noise channel?
		jr	nz, +							; Branch if yes
		ld	(zPSG), a						; Set PSG volume
		ret
; ---------------------------------------------------------------------------
+
		add	a, 20h							; Change to noise channel
		ld	(zPSG), a						; Set noise channel volume
		ret
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR zDoFlutter
;loc_1037
zDoFlutterSetValue:
		ld	(ix+zTrackVolFlutter), a		; Set new value for PSG flutter index and fall through

; =============== S U B	R O U T	I N E =======================================
; Get next PSG flutter value.
;
; Input:   ix    Pointer to track RAM
;          hl    Pointer to current PSG flutter
; Output:  a     New flutter value
;          bc    Trashed
;
;sub_103A
zDoFlutter:
		push	hl							; Save hl
		ld	c, (ix+zTrackVolFlutter)		; Get current PSG flutter index
		ld	b, 0							; b = 0
		add	hl, bc							; Offset into PSG flutter
		ld	a, (hl)							; a = PSG flutter value
		pop	hl								; Restore hl
		bit	7, a							; Is it a terminator?
		jr	z, zDoFlutterAdvance			; Branch if not
		cp	83h								; Is it a command to put PSG channel to rest?
		jr	z, zDoFlutterFullRest			; Branch if yes
		cp	81h								; Is it a command to set rest flag on PSG channel?
		jr	z, zDoFlutterRest				; Branch if yes
		cp	80h								; Is it a command to reset flutter?
		jr	z, zDoFlutterReset				; Branch if yes
		
		inc	bc								; Increment flutter index
	if fix_sndbugs
		; Fix based on similar code from Ristar's sound driver.
		push	hl							; Save hl
		add	hl, bc							; Offset into PSG flutter
		ld	a, (hl)							; a = new PSG flutter value
		pop	hl								; Restore hl
	else
		; DANGER! Will read data from code segment and use it as if it were valid!
		; In order to get here, the flutter value would have to be:
		; (1) negative;
		; (2) not 80h, 81h or 83h.
		; As it stands, none of the entries in the flutter tables will allow
		; this code to execute.

		ld	a, (bc)							; Get value from wherever the hell bc is pointing to
	endif
		jr	zDoFlutterSetValue				; Use this as new flutter index
; ---------------------------------------------------------------------------
;loc_1057
zDoFlutterFullRest:
		set	4, (ix+zTrackPlaybackControl)	; Set 'track is resting' bit
		pop	hl								; Pop return value from stack (causes a 'ret' to return to caller of zUpdatePSGTrack)
		jp	zRestTrack						; Put track at rest
; ---------------------------------------------------------------------------
;loc_105F
zDoFlutterReset:
		xor	a								; a = 0
		jr	zDoFlutterSetValue
; ---------------------------------------------------------------------------
;loc_1062
zDoFlutterRest:
		pop	hl								; Pop return value from stack (causes a 'ret' to return to caller of zUpdatePSGTrack)
		set	4, (ix+zTrackPlaybackControl)	; Set 'track is resting' bit
		ret									; Do NOT silence PSG channel
; ---------------------------------------------------------------------------
;loc_1068
zDoFlutterAdvance:
		inc	(ix+zTrackVolFlutter)			; Advance flutter
		ret
; End of function zDoFlutter


; =============== S U B	R O U T	I N E =======================================
;
;sub_106C
zKillTrack:
	if fix_sndbugs
		xor	a
		ld	(ix+zTrackFreqLow), a			; Clear low byte of frequency
		ld	(ix+zTrackFreqHigh), a			; Clear high byte of frequency
	endif

zRestTrack:
		set	4, (ix+zTrackPlaybackControl)	; Set 'track is resting' bit
		bit	2, (ix+zTrackPlaybackControl)	; Is SFX overriding this track?
		ret	nz								; Return if so
; End of function zRestTrack


; =============== S U B	R O U T	I N E =======================================
;
;sub_1075
zSilencePSGChannel:
		ld	a, 1Fh							; Set volume to zero on PSG channel
		add	a, (ix+zTrackVoiceControl)		; Add in the PSG channel selector
		or	a								; Is it an actual PSG channel?
		ret	p								; Branch if not
		ld	(zPSG), a						; Silence this channel
		bit	0, (ix+zTrackPlaybackControl)	; Is this a noise channel?
		ret	z								; Return if not
		ld	a, 0FFh							; Command to silence PSG3/Noise channel
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

loc_1092:
		ei									; Enable interrupts
		ld	a, (PlaySegaPCMFlag)			; a = play SEGA PCM flag
		or	a								; Is SEGA sound being played?
		jp	nz, zPlaySEGAPCM				; Branch if yes
		ld	a, (zDACIndex)					; a = DAC index/flag
		or	a								; Is DAC channel being used?
		jr	z, loc_1092						; Loop if not
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
		ld	hl, zROMWindow					; hl = pointer to ROM window
		rst	PointerTableOffset				; hl = pointer to DAC data
		ld	c, 80h							; c is an accumulator below; this initializes it to 80h
		ld	a, (hl)							; a = DAC rate
		ld	(loc_10CA+1), a					; Store into following instruction (self-modifying code)
		ld	(loc_10E7+1), a					; Store into following instruction (self-modifying code)
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

loc_10CA:
		ld	b,0Ah							; self-modified code; b is set to DAC rate
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
		ld	(loc_10E0+2), a					; Store into following instruction (self-modifying code)
		ld	a, c							; a = c
loc_10E0:
		add	a, (iy+0)						; Self-modified code: the index offset is not zero, but what was set above
		ld	(zYM2612_D0), a					; Send byte to DAC
		ld	c,a								; Set c to the new value of a
loc_10E7:
		ld	b,0Ah							; self-modified code; b is set to DAC rate
		ei									; Enable interrupts
		djnz	$							; Loop in this instruction, decrementing b each iteration, until b = 0

		di									; Disable interrupts
		ld	a, 2Ah							; DAC channel register
		ld	(zYM2612_A0), a					; Send to YM2612
		ld	a, (hl)							; a = next byte of DAC sample
		and	0Fh								; Want only the low nibble
		ld	(loc_10F9+2), a					; Store into following instruction (self-modifying code)
		ld	a, c							; a = c
loc_10F9:
		add	a, (iy+0)						; Self-modified code: the index offset is not zero, but what was set above
		ld	(zYM2612_D0), a					; Send byte to DAC
		ei									; Enable interrupts
		ld	c, a							; Set c to the new value of a
		ld	a, (zDACIndex)					; a = DAC index/flag
		or	a								; Is playing flag set?
		jp	p, loc_1092						; Branch if not

		inc	hl								; Advance to next sample byte
		dec	de								; Mark one byte as being done
		ld	a, d							; a = d
		or	e								; Is length zero?
		jp	nz, loc_10CA					; Loop if not

		xor	a								; a = 0
		ld	(zDACIndex),a					; Mark DAC as being idle
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
;	(2)	The next song to play is 0FEh (SndID_StopSega)
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

-		ld	a, (hl)							; a = next byte of SEGA PCM
		ld	(zYM2612_D0), a					; Send to DAC
		ld	a, (zMusicNumber)				; Check next song number
		cp	SndID_StopSega					; Is it the command to stop playing SEGA PCM?
		jr	z, +							; Break the loop if yes
		nop
		nop

		ld	b, 0Ch							; Loop counter
		djnz	$							; Loop in this instruction, decrementing b each iteration, until b = 0

		inc	hl								; Advance to next byte of SEGA PCM
		dec	de								; Mark one byte as being done
		ld	a, d							; a = d
		or	e								; Is length zero?
		jr	nz, -							; Loop if not

+		jp	zPlayDigitalAudio				; Go back to normal DAC code
; ---------------------------------------------------------------------------
			; db    0

	if $ > 1300h
		fatal "Your Z80 code won't fit before its tables. It's \{$-1300h}h bytes past the start of music data \{1300h}h"
	endif
z80_SoundDriverEnd:
Z80_Snd_Driver2:
; ---------------------------------------------------------------------------
		!org	1300h						; z80 Align, handled by the build process
; ---------------------------------------------------------------------------
; ===========================================================================
; Pointers
; ===========================================================================

z80_SoundDriverPointers:
		dw	z80_MusicPointers
		dw	z80_UniVoiceBank
		dw	z80_MusicPointers
		dw  z80_SFXPointers
		dw  z80_FreqFlutterPointers
		dw  z80_PSGTonePointers
		dw  33h
; ---------------------------------------------------------------------------
; ===========================================================================
; Frequency Flutter Pointers
; ===========================================================================

z80_FreqFlutterPointers:
		dw	FreqFlutter0
		dw	FreqFlutter1
		dw	FreqFlutter2
		dw	FreqFlutter3
		dw	FreqFlutter4
		dw	FreqFlutter5
		dw	FreqFlutter6
		dw	FreqFlutter7

FreqFlutter1:   db    0
FreqFlutter0:   db    1,   2,   1,   0,0FFh,0FEh,0FDh,0FCh,0FDh,0FEh,0FFh, 83h
FreqFlutter2:   db    0,   0,   0,   0, 13h, 26h, 39h, 4Ch, 5Fh, 72h, 7Fh, 72h, 83h
FreqFlutter3:   db    1,   2,   3,   2,   1,   0,0FFh,0FEh,0FDh,0FEh,0FFh,   0, 82h,   0
FreqFlutter4:   db    0,   0,   1,   3,   1,   0,0FFh,0FDh,0FFh,   0, 82h,   2
FreqFlutter5:   db    0,   0,   0,   0,   0, 0Ah, 14h, 1Eh, 14h, 0Ah,   0,0F6h,0ECh,0E2h,0ECh,0F6h
                db  82h,   4
FreqFlutter6:   db    0,   0,   0,   0, 16h, 2Ch, 42h, 2Ch, 16h,   0,0EAh,0D4h,0BEh,0D4h,0EAh, 82h
                db    3
FreqFlutter7:   db    1,   2,   3,   4,   3,   2,   1,   0,0FFh,0FEh,0FDh,0FCh,0FDh,0FEh,0FFh,   0
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

PSGTone_00:		db    2, 83h
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
	; Harpischord
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

	if $ > zVariablesStart
		fatal "Your Z80 tables won't fit before its variables. It's \{$-zVariablesStart}h bytes past the start of music data \{zVariablesStart}h"
	endif

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
		fatal "soundBank must fit in $8000 bytes but was $\{*-soundBankStart}. Try moving something to the other bank."
	elseif (DebugSoundbanks<>0)&&(MOMPASS=1)
		message "soundBank has $\{$8000+soundBankStart-*} bytes free at end."
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
SEGA_PCM_End
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
