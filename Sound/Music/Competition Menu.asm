Snd_2PMenu_Header:
	smpsHeaderStartSong 3, 1
	smpsHeaderVoice     Snd_2PMenu_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $4A

	smpsHeaderDAC       Snd_2PMenu_DAC
	smpsHeaderFM        Snd_2PMenu_FM1,	$00, $03
	smpsHeaderFM        Snd_2PMenu_FM2,	$F4, $00 ; This transpose causes a note to underflow (which may have been deliberate)
	smpsHeaderFM        Snd_2PMenu_FM3,	$00, $05
	smpsHeaderFM        Snd_2PMenu_FM4,	$00, $05
	smpsHeaderFM        Snd_2PMenu_FM5,	$00, $05
	smpsHeaderPSG       Snd_2PMenu_PSG1,	$E8, $00, $00, sTone_0F
	smpsHeaderPSG       Snd_2PMenu_PSG2,	$E8, $01, $00, sTone_0F
	smpsHeaderPSG       Snd_2PMenu_PSG3,	$2E, $00, $00, sTone_0D

; FM1 Data
Snd_2PMenu_FM1:
	smpsSetvoice        $00

Snd_2PMenu_Loop03:
	dc.b	nE3, $06, nRst, $1E, nE3, $06, nD3, $12, nB2, $06, nRst, nA2
	dc.b	nRst, nRst, nRst
	smpsLoop            $00, $08, Snd_2PMenu_Loop03
	dc.b	nE3, $06, nRst, $36, nB2, $06, nD3, $12, nE3, $06, nRst, nFs3
	dc.b	$06, nRst, $2A, nCs3, $06, nCs3, nE3, nFs3, nRst, $18, nB2, $06
	dc.b	nRst, $36, nFs2, $06, nA2, $12, nB2, $06, nRst, nB2, $06, nRst
	dc.b	$24, nD2, $06, nD3, nRst, nCs3, nRst, nB2, nRst, nA2, nRst, nE2
	dc.b	$06, nRst, $36, nB1, $06, nD2, nB1, nE2, nB1, nRst, nFs2, $06
	dc.b	nRst, $2A, nCs2, $06, nCs2, nE2, nFs2, $1E, nB2, $06, nRst, $36
	dc.b	nFs2, $06, nA2, $12, nB2, $06, nRst, nB2, $06, nRst, $12, nRst
	dc.b	$0C, nB2, nA2, nRst, nRst, nRst

Snd_2PMenu_Loop04:
	dc.b	nE3, $06, nRst, $1E, nE3, $06, nD3, $12, nB2, $06, nRst, nA2
	dc.b	nRst, nRst, nRst
	smpsLoop            $00, $08, Snd_2PMenu_Loop04
	smpsJump            Snd_2PMenu_Loop03

; Unreachable
	smpsStop

; FM2 Data
Snd_2PMenu_FM2:
	smpsCall            Snd_2PMenu_Call03
	smpsSetvoice        $06
	; This use of nG0 is invalid, as the transpose is -$C, which causes
	; the note to underflow and become nG7.
	dc.b	nG0, $60, nRst
	smpsSetvoice        $07
	dc.b	nE5, $0D
	smpsFMAlterVol      $08
	dc.b	nE5, $0B, nRst, $48
	smpsFMAlterVol      $F8
	dc.b	nE5, $0D
	smpsFMAlterVol      $08
	dc.b	nE5, $0B, nRst, $48
	smpsFMAlterVol      $F8
	smpsSetvoice        $06
	; This use of nG0 is invalid, as the transpose is -$C, which causes
	; the note to underflow and become nG7.
	dc.b	nG0, $60, nRst
	smpsSetvoice        $07
	dc.b	nE5, $0D
	smpsFMAlterVol      $08
	dc.b	nE5, $0B, nRst, $48
	smpsFMAlterVol      $F8
	dc.b	nE5, $0D
	smpsFMAlterVol      $08
	dc.b	nE5, $0B, nRst, $48
	smpsFMAlterVol      $F8
	smpsCall            Snd_2PMenu_Call03
	smpsJump            Snd_2PMenu_FM2

; Unreachable
	smpsStop

Snd_2PMenu_Call03:
	smpsSetvoice        $06
	dc.b	nC4, $60, nRst
	smpsSetvoice        $07
	dc.b	nE5, $0D
	smpsFMAlterVol      $08
	dc.b	nE5, $0B, nRst, $48
	smpsFMAlterVol      $F8
	dc.b	nRst, $60
	smpsSetvoice        $06
	dc.b	nRst, $06, nC4, $5A, nRst, $60
	smpsSetvoice        $07
	dc.b	nE5, $0D
	smpsFMAlterVol      $08
	dc.b	nE5, $0B, nRst, $48
	smpsFMAlterVol      $F8
	dc.b	nRst, $60
	smpsReturn

; FM3 Data
Snd_2PMenu_FM3:
	smpsPan             panLeft, $00
	smpsAlterNote       $01

Snd_2PMenu_Jump01:
	smpsCall            Snd_2PMenu_Call02
	smpsSetvoice        $02
	dc.b	nG3, $60, nA3, $24, nE3, $3C, nA3, $60, nA3, nG3, $60, nA3
	dc.b	$24, nE3, $3C, nA3, $60, nA3, $48, nCs4, $18
	smpsCall            Snd_2PMenu_Call02
	smpsJump            Snd_2PMenu_Jump01

; Unreachable
	smpsStop

Snd_2PMenu_Call02:
	smpsSetvoice        $03
	dc.b	nRst, $24, nA3, $3C, smpsNoAttack, $3C
	smpsSetvoice        $01
	smpsNoteFill        $06
	dc.b	nG5, $06, nG5
	smpsFMAlterVol      $10
	dc.b	nG5, nRst
	smpsFMAlterVol      $F0
	dc.b	nA5, nRst
	smpsNoteFill        $00
	smpsSetvoice        $03
	dc.b	nA3, $60, smpsNoAttack, $54
	smpsSetvoice        $05
	smpsModSet          $01, $01, $03, $06
	dc.b	nE5, $12
	smpsModOff
	smpsSetvoice        $03
	dc.b	nRst, $1E, nA3, $3C, smpsNoAttack, $3C
	smpsSetvoice        $01
	smpsNoteFill        $06
	dc.b	nG5, $06, nG5
	smpsFMAlterVol      $10
	dc.b	nG5, nRst
	smpsFMAlterVol      $F0
	dc.b	nA5, nRst
	smpsNoteFill        $00
	smpsSetvoice        $03
	dc.b	nA3, $60, smpsNoAttack, $60
	smpsReturn

; FM4 Data
Snd_2PMenu_FM4:
	smpsPan             panRight, $00

Snd_2PMenu_Jump00:
	smpsCall            Snd_2PMenu_Call01
	smpsSetvoice        $02
	dc.b	nB3, $60, nE4, nD4, nD4, nB3, $60, nE4, nCs4, nD4, $48, nE4
	dc.b	$18
	smpsCall            Snd_2PMenu_Call01
	smpsJump            Snd_2PMenu_Jump00

; Unreachable
	smpsStop

Snd_2PMenu_Call01:
	smpsSetvoice        $03
	dc.b	nRst, $24, nB3, $3C, smpsNoAttack, $3C
	smpsSetvoice        $01
	smpsNoteFill        $06
	dc.b	nG4, $06, nG4
	smpsFMAlterVol      $10
	dc.b	nG4, nRst
	smpsFMAlterVol      $F0
	dc.b	nA4, nRst
	smpsNoteFill        $00
	smpsSetvoice        $03
	dc.b	nB3, $60, smpsNoAttack, $54
	smpsSetvoice        $05
	smpsModSet          $01, $01, $03, $06
	dc.b	nG5, $12
	smpsModOff
	smpsSetvoice        $03
	dc.b	nRst, $1E, nB3, $3C, smpsNoAttack, $3C
	smpsSetvoice        $01
	smpsNoteFill        $06
	dc.b	nG4, $06, nG4
	smpsFMAlterVol      $10
	dc.b	nG4, nRst
	smpsFMAlterVol      $F0
	dc.b	nA4, nRst
	smpsNoteFill        $00
	smpsSetvoice        $03
	dc.b	nB3, $60, smpsNoAttack, $60
	smpsReturn

; FM5 Data
Snd_2PMenu_FM5:
	smpsCall            Snd_2PMenu_Call00
	smpsSetvoice        $02
	dc.b	nD4, $3C, nG4, $12, nA4, nA4, $60, nA4, nA4, nD4, $3C, nG4
	dc.b	$12, nA4, nA4, $60, nE4, nA4, $48, nCs5, $18
	smpsCall            Snd_2PMenu_Call00
	smpsJump            Snd_2PMenu_FM5

; Unreachable
	smpsStop

Snd_2PMenu_Call00:
	smpsSetvoice        $03
	dc.b	nRst, $24, nD4, $3C, smpsNoAttack, $60, nE4, smpsNoAttack, nE4
	smpsLoop            $00, $02, Snd_2PMenu_Call00
	smpsReturn

; PSG1 Data
Snd_2PMenu_PSG1:
	dc.b	nRst, $01
	smpsAlterNote       $FF

; PSG2 Data
Snd_2PMenu_PSG2:
	smpsPSGvoice        sTone_1F

Snd_2PMenu_Jump03:
	smpsCall            Snd_2PMenu_Call08
	smpsCall            Snd_2PMenu_Call08
	dc.b	nRst, $60, nRst, nRst, nRst, $18, nD5, nE5, $03, nFs5, $15, nD5
	dc.b	$18, nG4, $03, nA4, $2D, nRst, $30, nRst, $18, nA4, $12, nG4
	dc.b	$06, nFs4, $18, nA4, nE4, $24, nRst, $3C, nRst, $60
	smpsCall            Snd_2PMenu_Call08

Snd_2PMenu_Loop05:
	dc.b	nRst, $18, nD5, $0C, nB4, $06, nRst, nG4, $0C, nB4, $06, nRst
	dc.b	nD5, $0C, nB4, $06, nRst
	smpsLoop            $00, $02, Snd_2PMenu_Loop05
	dc.b	nRst, $18, nE5, $0C, nB4, $06, nRst, nG4, $0C, nB4, $06, nRst
	dc.b	nE5, $0C, nB4, $06, nRst, nRst, $60
	smpsJump            Snd_2PMenu_Jump03

; Unreachable
	smpsStop

Snd_2PMenu_Call08:
	dc.b	nRst, $18, nD5, $0C, nB4, $06, nRst, nG4, $0C, nB4, $06, nRst
	dc.b	nD5, $0C, nB4, $06, nRst
	smpsLoop            $00, $02, Snd_2PMenu_Call08

Snd_2PMenu_Loop06:
	dc.b	nRst, $18, nE5, $0C, nB4, $06, nRst, nG4, $0C, nB4, $06, nRst
	dc.b	nE5, $0C, nB4, $06, nRst
	smpsLoop            $00, $02, Snd_2PMenu_Loop06
	smpsReturn

; PSG3 Data
Snd_2PMenu_PSG3:
	smpsPSGform         $E7
	smpsPSGvoice        sTone_1E

Snd_2PMenu_Jump02:
	smpsCall            Snd_2PMenu_Call04
	smpsCall            Snd_2PMenu_Call05
	smpsCall            Snd_2PMenu_Call06
	smpsCall            Snd_2PMenu_Call05
	smpsCall            Snd_2PMenu_Call07
	smpsCall            Snd_2PMenu_Call07
	smpsCall            Snd_2PMenu_Call04
	smpsCall            Snd_2PMenu_Call05
	smpsCall            Snd_2PMenu_Call04
	smpsCall            Snd_2PMenu_Call04
	smpsCall            Snd_2PMenu_Call04
	smpsCall            Snd_2PMenu_Call04
	smpsCall            Snd_2PMenu_Call07
	smpsCall            Snd_2PMenu_Call06
	smpsCall            Snd_2PMenu_Call06
	smpsCall            Snd_2PMenu_Call05
	smpsCall            Snd_2PMenu_Call04
	smpsCall            Snd_2PMenu_Call07
	smpsCall            Snd_2PMenu_Call04
	smpsCall            Snd_2PMenu_Call04
	smpsCall            Snd_2PMenu_Call07
	smpsCall            Snd_2PMenu_Call06
	smpsCall            Snd_2PMenu_Call04
	smpsCall            Snd_2PMenu_Call07
	smpsJump            Snd_2PMenu_Jump02

; Unreachable
	smpsStop

Snd_2PMenu_Call04:
	smpsPSGvoice        sTone_1E
	smpsPSGAlterVol     $02
	dc.b	(nMaxPSG1-$2E)&$FF, $0C
	smpsPSGAlterVol     $FE
	dc.b	(nMaxPSG1-$2E)&$FF, (nMaxPSG1-$2E)&$FF
	smpsPSGAlterVol     $02
	dc.b	(nMaxPSG1-$2E)&$FF
	smpsPSGAlterVol     $FE
	dc.b	(nMaxPSG1-$2E)&$FF
	smpsPSGAlterVol     $02
	dc.b	(nMaxPSG1-$2E)&$FF, (nMaxPSG1-$2E)&$FF
	smpsPSGAlterVol     $FE
	smpsPSGvoice        sTone_27
	dc.b	(nMaxPSG1-$2E)&$FF, $06, nRst
	smpsReturn

Snd_2PMenu_Call05:
	smpsPSGvoice        sTone_1E
	smpsPSGAlterVol     $02
	dc.b	(nMaxPSG1-$2E)&$FF, $0C
	smpsPSGAlterVol     $FE
	dc.b	(nMaxPSG1-$2E)&$FF, (nMaxPSG1-$2E)&$FF
	smpsPSGAlterVol     $02
	dc.b	(nMaxPSG1-$2E)&$FF
	smpsPSGAlterVol     $FE
	dc.b	(nMaxPSG1-$2E)&$FF
	smpsPSGAlterVol     $02
	dc.b	(nMaxPSG1-$2E)&$FF, (nMaxPSG1-$2E)&$FF
	smpsPSGAlterVol     $FE
	dc.b	(nMaxPSG1-$2E)&$FF, $06, (nMaxPSG1-$2E)&$FF
	smpsReturn

Snd_2PMenu_Call06:
	smpsPSGvoice        sTone_1E
	smpsPSGAlterVol     $02
	dc.b	(nMaxPSG1-$2E)&$FF, $0C
	smpsPSGAlterVol     $FE
	dc.b	(nMaxPSG1-$2E)&$FF, (nMaxPSG1-$2E)&$FF
	smpsPSGAlterVol     $02
	dc.b	(nMaxPSG1-$2E)&$FF
	smpsPSGAlterVol     $FE
	dc.b	(nMaxPSG1-$2E)&$FF
	smpsPSGAlterVol     $02
	dc.b	(nMaxPSG1-$2E)&$FF, (nMaxPSG1-$2E)&$FF
	smpsPSGAlterVol     $FE
	dc.b	(nMaxPSG1-$2E)&$FF, $06
	smpsPSGvoice        sTone_27
	dc.b	(nMaxPSG1-$2E)&$FF
	smpsReturn

Snd_2PMenu_Call07:
	smpsPSGvoice        sTone_1E
	smpsPSGAlterVol     $02
	dc.b	(nMaxPSG1-$2E)&$FF, $0C
	smpsPSGAlterVol     $FE
	dc.b	(nMaxPSG1-$2E)&$FF, (nMaxPSG1-$2E)&$FF
	smpsPSGAlterVol     $02
	dc.b	(nMaxPSG1-$2E)&$FF
	smpsPSGAlterVol     $FE
	dc.b	(nMaxPSG1-$2E)&$FF
	smpsPSGAlterVol     $02
	dc.b	(nMaxPSG1-$2E)&$FF, (nMaxPSG1-$2E)&$FF
	smpsPSGAlterVol     $FE
	smpsPSGvoice        sTone_27
	dc.b	(nMaxPSG1-$2E)&$FF
	smpsReturn

; DAC Data
Snd_2PMenu_DAC:
	dc.b	dKickS3, $06, nRst, nRst, nRst, dSnareS3, nRst, nRst, dKickS3, dKickS3, nRst, dKickS3
	dc.b	nRst, dSnareS3, nRst, nRst, nRst
	smpsLoop            $00, $03, Snd_2PMenu_DAC
	dc.b	dKickS3, nRst, nRst, nRst, dSnareS3, nRst, nRst, dKickS3, dKickS3, nRst, dKickS3, nRst
	dc.b	dSnareS3, nRst, dSnareS3, dSnareS3

Snd_2PMenu_Loop00:
	dc.b	dKickS3, $06, nRst, nRst, nRst, dSnareS3, nRst, nRst, dKickS3, dKickS3, nRst, dKickS3
	dc.b	nRst, dSnareS3, nRst, nRst, nRst
	smpsLoop            $00, $03, Snd_2PMenu_Loop00
	dc.b	dKickS3, nRst, dSnareS3, nRst, dSnareS3, nRst, nRst, dKickS3, dKickS3, nRst, dSnareS3, dSnareS3
	dc.b	dSnareS3, nRst, dSnareS3, dSnareS3

Snd_2PMenu_Loop01:
	dc.b	dKickS3, nRst, nRst, nRst, dSnareS3, nRst, nRst, dKickS3, dKickS3, nRst, dKickS3, nRst
	dc.b	dSnareS3, nRst, dKickS3, nRst
	smpsLoop            $00, $03, Snd_2PMenu_Loop01
	dc.b	dKickS3, nRst, nRst, nRst, dSnareS3, nRst, nRst, dKickS3, dKickS3, nRst, dKickS3, nRst
	dc.b	dSnareS3, nRst, dSnareS3, dSnareS3
	smpsLoop            $01, $02, Snd_2PMenu_Loop01

Snd_2PMenu_Loop02:
	dc.b	dKickS3, $06, nRst, nRst, nRst, dSnareS3, nRst, nRst, dKickS3, dKickS3, nRst, dKickS3
	dc.b	nRst, dSnareS3, nRst, nRst, nRst
	smpsLoop            $00, $03, Snd_2PMenu_Loop02
	dc.b	dKickS3, nRst, nRst, nRst, dSnareS3, nRst, nRst, dKickS3, dKickS3, nRst, dKickS3, nRst
	dc.b	dSnareS3, nRst, dSnareS3, dSnareS3
	smpsLoop            $01, $02, Snd_2PMenu_Loop02
	smpsJump            Snd_2PMenu_DAC

; Unreachable
	smpsStop

Snd_2PMenu_Voices:
;	Voice $00
;	$00
;	$27, $33, $30, $21, 	$DF, $DF, $9F, $9F, 	$07, $06, $09, $06
;	$07, $06, $06, $08, 	$20, $10, $10, $0F, 	$19, $37, $10, $84
	smpsVcAlgorithm     $00
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $02, $03, $03, $02
	smpsVcCoarseFreq    $01, $00, $03, $07
	smpsVcRateScale     $02, $02, $03, $03
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $09, $06, $07
	smpsVcDecayRate2    $08, $06, $06, $07
	smpsVcDecayLevel    $00, $01, $01, $02
	smpsVcReleaseRate   $0F, $00, $00, $00
	smpsVcTotalLevel    $84, $10, $37, $19

;	Voice $01
;	$05
;	$30, $52, $01, $31, 	$51, $53, $52, $53, 	$05, $00, $00, $00
;	$00, $00, $00, $00, 	$1F, $0F, $0F, $0F, 	$0C, $90, $90, $90
	smpsVcAlgorithm     $05
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $00, $05, $03
	smpsVcCoarseFreq    $01, $01, $02, $00
	smpsVcRateScale     $01, $01, $01, $01
	smpsVcAttackRate    $13, $12, $13, $11
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $05
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $90, $90, $90, $0C

;	Voice $02
;	$2E
;	$05, $77, $58, $02, 	$1F, $1F, $14, $14, 	$00, $00, $00, $00
;	$08, $0B, $09, $06, 	$0F, $0F, $0F, $0F, 	$18, $90, $90, $90
	smpsVcAlgorithm     $06
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $05, $07, $00
	smpsVcCoarseFreq    $02, $08, $07, $05
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $14, $14, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $06, $09, $0B, $08
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $90, $90, $90, $18

;	Voice $03
;	$2C
;	$71, $62, $31, $32, 	$5F, $54, $5F, $5F, 	$00, $09, $00, $09
;	$00, $03, $00, $03, 	$0F, $8F, $0F, $AF, 	$16, $8B, $11, $8B
	smpsVcAlgorithm     $04
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $06, $07
	smpsVcCoarseFreq    $02, $01, $02, $01
	smpsVcRateScale     $01, $01, $01, $01
	smpsVcAttackRate    $1F, $1F, $14, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $09, $00, $09, $00
	smpsVcDecayRate2    $03, $00, $03, $00
	smpsVcDecayLevel    $0A, $00, $08, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $8B, $11, $8B, $16

;	Voice $04
;	$03
;	$02, $02, $02, $02, 	$1F, $1F, $1F, $1F, 	$08, $08, $00, $0E
;	$00, $00, $00, $05, 	$3F, $3F, $0F, $7F, 	$81, $20, $1D, $82
	smpsVcAlgorithm     $03
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $02, $02, $02, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0E, $00, $08, $08
	smpsVcDecayRate2    $05, $00, $00, $00
	smpsVcDecayLevel    $07, $00, $03, $03
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $82, $1D, $20, $81

;	Voice $05
;	$04
;	$22, $02, $21, $02, 	$18, $0B, $19, $08, 	$00, $05, $04, $00
;	$00, $00, $00, $00, 	$0F, $FF, $4F, $0F, 	$20, $90, $20, $88
	smpsVcAlgorithm     $04
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $02, $00, $02
	smpsVcCoarseFreq    $02, $01, $02, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $08, $19, $0B, $18
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $04, $05, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $04, $0F, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $88, $20, $90, $20

;	Voice $06
;	$00
;	$38, $1C, $1E, $1F, 	$1F, $1F, $1F, $1F, 	$00, $00, $00, $0C
;	$00, $00, $00, $0C, 	$0F, $0F, $0F, $1F, 	$00, $3D, $00, $88
	smpsVcAlgorithm     $00
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $01, $01, $03
	smpsVcCoarseFreq    $0F, $0E, $0C, $08
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0C, $00, $00, $00
	smpsVcDecayRate2    $0C, $00, $00, $00
	smpsVcDecayLevel    $01, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $88, $00, $3D, $00

;	Voice $07
;	$00
;	$70, $30, $13, $01, 	$1F, $1F, $0E, $1F, 	$00, $0B, $0E, $00
;	$08, $01, $10, $12, 	$0F, $1F, $FF, $0F, 	$15, $1E, $94, $00
	smpsVcAlgorithm     $00
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $01, $03, $07
	smpsVcCoarseFreq    $01, $03, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $0E, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $0E, $0B, $00
	smpsVcDecayRate2    $12, $10, $01, $08
	smpsVcDecayLevel    $00, $0F, $01, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $94, $1E, $15

