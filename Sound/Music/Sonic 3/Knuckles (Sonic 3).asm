Snd_S3_Knux_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_S3_Knux_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $43

	smpsHeaderDAC       Snd_S3_Knux_DAC
	; The transposition of $C2 is too low, causing the octave calculation to underflow.
	; In drivers that don't calculate the octave (such as Sonic 1's and Sonic 2's
	; drivers, which are derived from SMPS 68k Type 1b), this invalid transpose causes
	; this channel's notes to play with nonsensical frequencies.
	; Calculating the correct transposition is tricky because you have to consider that
	; it's the sum of the transposition *with the note* that underflows the octave
	; calculation, so the correct transposition depends on which notes it is used with.
	; '(((x/12)&7)*12)+(x%12)' can be used to obtain a post-underflow version of the
	; transpositon. Then, if the notes used with this transposition would cause the sum
	; to exceed $60, then subtract $60 from the transposition.
	; $C2 run through the formula is $02, and the notes that this displacement is used
	; with are in the low octaves, so the sum will never exceed $60. Because of this,
	; $02 is the correct displacement.
	smpsHeaderFM        Snd_S3_Knux_FM1,	$C2, $03
	smpsHeaderFM        Snd_S3_Knux_FM2,	$E0, $18
	smpsHeaderFM        Snd_S3_Knux_FM3,	$0C, $10
	smpsHeaderFM        Snd_S3_Knux_FM4,	$00, $14
	smpsHeaderFM        Snd_S3_Knux_FM5,	$00, $14
	smpsHeaderPSG       Snd_S3_Knux_PSG1,	$03, $01, $00, $00
	smpsHeaderPSG       Snd_S3_Knux_PSG2,	$00, $01, $00, $00
	smpsHeaderPSG       Snd_S3_Knux_PSG3,	$00, $00, $00, $00

; FM1 Data
Snd_S3_Knux_FM1:
	smpsSetvoice        $01
	dc.b	nC1, $08, $04, nRst, $07, nC1, $05
	smpsSetvoice        $02
	dc.b	nE3, $0C
	smpsSetvoice        $01
	dc.b	nC1, nRst, nC1
	smpsSetvoice        $02
	dc.b	nE3, $18
	smpsSetvoice        $01
	dc.b	nC1, $0C, nRst, $07, nC1, $05
	smpsSetvoice        $02
	dc.b	nE3, $0C
	smpsSetvoice        $01
	dc.b	nC1, nRst, $07, nRst, $05, nC1, $0C
	smpsSetvoice        $02
	dc.b	nE3, $13, nRst, $05
	smpsJump            Snd_S3_Knux_FM1

; Unused track data.
; This is leftover from the miniboss theme, which this song is a stripped-down version of.
Snd_S3_Knux_Loop01: ; Snd_S3_Miniboss_Loop01
	smpsLoop	$00, $02, Snd_S3_Knux_Loop01
	smpsJump	Snd_S3_Knux_FM1

;Snd_S3_Miniboss_Call05:
	smpsFMvoice	$01
	dc.b	nC1, $0C, nRst, $07, nC1, $05, nRst, $0C, nC1, nRst, nC1, nRst
	dc.b	$18
	smpsReturn

;Snd_S3_Miniboss_Call06:
	smpsFMvoice	$01
	dc.b	nC1, $0C, nRst, $07, nC1, $05, nRst, $0C, nC1, nRst, $07, nC1
	dc.b	$05, nC1, $0C, nRst, $18
	smpsReturn

;Snd_S3_Miniboss_Call07:
	smpsFMvoice	$01
	dc.b	nC1, $0C, nRst, $18, nRst, $0C, nRst, nRst, nRst, nRst
	smpsReturn

;Snd_S3_Miniboss_Call08:
	smpsFMvoice	$01
	dc.b	nC1, $18, nRst, nC1, $03, nC1, nC1, nC1, nC1, nC1, nC1, nC1
	dc.b	nC1, $18
	smpsReturn

;Snd_S3_Miniboss_Call09:
	smpsFMvoice	$01
	dc.b	nC1, $09, $03, nRst, $07, nC1, $05
	smpsFMvoice	$02
	dc.b	nE3, $0C
	smpsFMvoice	$01
	dc.b	nC1, nRst, nC1
	smpsFMvoice	$02
	dc.b	nE3, $18
	smpsReturn

;Snd_S3_Miniboss_Call0A:
	smpsFMvoice	$01
	dc.b	nC1, $0C, nRst, $07, nC1, $05
	smpsFMvoice	$02
	dc.b	nE3, $0C
	smpsFMvoice	$01
	dc.b	nC1, nRst, $07, nRst, $05, nC1, $0C
	smpsFMvoice	$02
	dc.b	nE3, $13, nRst, $05
	smpsReturn

;Snd_S3_Miniboss_Call0B:
	smpsFMvoice	$01
	dc.b	nC1, $0C, nRst
	smpsFMvoice	$02
	dc.b	nE3
	smpsFMvoice	$01
	dc.b	nC1, nC1, nC1
	smpsFMvoice	$02
	dc.b	nE3
	smpsFMvoice	$01
	dc.b	nC1, $05
	smpsFMvoice	$02
	dc.b	nRst, $07
	smpsReturn

;Snd_S3_Miniboss_Call0C:
	smpsFMvoice	$01
	dc.b	nC1, $0C, nRst, $07, nC1, $05
	smpsFMvoice	$02
	dc.b	nE3, $0C
	smpsFMvoice	$01
	dc.b	nC1, nRst, $07, nRst, $05, nC1, $0C
	smpsFMvoice	$02
	dc.b	nE3, $13, nE3, $05
	smpsReturn

; FM2 Data
Snd_S3_Knux_FM2:
	smpsSetvoice        $00
	dc.b	nC4, $07, $05, $07, nRst, $05, nRst, $07, nC4, $05, $07, $05
	dc.b	nC4, $07, $05, $07, $05, $07, $05, $07, $05
	smpsJump            Snd_S3_Knux_FM2

; Unreachable
	smpsStop

; FM3 Data
Snd_S3_Knux_FM3:
; FM4 Data
Snd_S3_Knux_FM4:
; FM5 Data
Snd_S3_Knux_FM5:
; PSG1 Data
Snd_S3_Knux_PSG1:
; PSG2 Data
Snd_S3_Knux_PSG2:
; PSG3 Data
Snd_S3_Knux_PSG3:
	smpsStop

; DAC Data
Snd_S3_Knux_DAC:
	smpsCall            Snd_S3_Knux_Call00
	smpsLoop            $00, $04, Snd_S3_Knux_DAC

Snd_S3_Knux_Jump00:
	smpsCall            Snd_S3_Knux_Call01

Snd_S3_Knux_Loop00:
	smpsCall            Snd_S3_Knux_Call00
	smpsLoop            $00, $03, Snd_S3_Knux_Loop00
	smpsJump            Snd_S3_Knux_Jump00

; Unreachable
	smpsStop

Snd_S3_Knux_Call00:
	dc.b	nRst, $0C, dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08, dLowerEchoedClapHit_S3, $04, $0C, $0C, $08, $04, dEchoedClapHit_S3
	dc.b	$18, nRst, $0C, dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08, dLowerEchoedClapHit_S3, $04, $0C, $14, $04, dEchoedClapHit_S3
	dc.b	$18, nRst, $0C, dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08, dLowerEchoedClapHit_S3, $04, $0C, $0C, $08, $04
	dc.b	dEchoedClapHit_S3, $18, nRst, $0C, dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08, dLowerEchoedClapHit_S3, $04, $0C, $14, $04
	dc.b	dEchoedClapHit_S3, $18
	smpsReturn

Snd_S3_Knux_Call01:
	dc.b	dBassHey, $0C, dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08, dLowerEchoedClapHit_S3, $04, $0C, $0C, $08, $04, dEchoedClapHit_S3
	dc.b	$18, nRst, $0C, dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08, dLowerEchoedClapHit_S3, $04, $0C, $14, $04, dEchoedClapHit_S3
	dc.b	$18, nRst, $0C, dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08, dLowerEchoedClapHit_S3, $04, $0C, $0C, $08, $04
	dc.b	dEchoedClapHit_S3, $18, nRst, $0C, dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08, dLowerEchoedClapHit_S3, $04, $0C, $14, $04
	dc.b	dEchoedClapHit_S3, $18
	smpsReturn

Snd_S3_Knux_Voices:
;	Voice $00
;	$01
;	$02, $00, $00, $00, 	$1F, $1F, $1F, $1F, 	$10, $18, $18, $10
;	$0E, $00, $00, $08, 	$FF, $FF, $FF, $0F, 	$12, $10, $10, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $00, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $10, $18, $18, $10
	smpsVcDecayRate2    $08, $00, $00, $0E
	smpsVcDecayLevel    $00, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $10, $10, $12

;	Voice $01
;	$05
;	$00, $00, $00, $00, 	$1F, $1F, $1F, $1F, 	$12, $0C, $0C, $0C
;	$12, $18, $1F, $1F, 	$1F, $1F, $1F, $1F, 	$07, $86, $86, $86
	smpsVcAlgorithm     $05
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0C, $0C, $0C, $12
	smpsVcDecayRate2    $1F, $1F, $18, $12
	smpsVcDecayLevel    $01, $01, $01, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $06, $06, $06, $07

;	Voice $02
;	$3C
;	$00, $00, $F0, $F1, 	$1F, $1F, $17, $1F, 	$1F, $1F, $14, $1F
;	$09, $11, $3A, $1D, 	$02, $0F, $9F, $7F, 	$03, $80, $02, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $0F, $0F, $00, $00
	smpsVcCoarseFreq    $01, $00, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $17, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $1F, $14, $1F, $1F
	smpsVcDecayRate2    $1D, $3A, $11, $09
	smpsVcDecayLevel    $07, $09, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $02
	smpsVcTotalLevel    $00, $02, $00, $03

