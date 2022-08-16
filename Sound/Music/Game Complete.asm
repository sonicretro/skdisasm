Snd_PresSega_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_PresSega_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $08

	smpsHeaderDAC       Snd_PresSega_DAC
	smpsHeaderFM        Snd_PresSega_FM1,	$01, $12
	smpsHeaderFM        Snd_PresSega_FM2,	$0D, $04
	smpsHeaderFM        Snd_PresSega_FM3,	$01, $1C
	smpsHeaderFM        Snd_PresSega_FM4,	$0D, $12
	smpsHeaderFM        Snd_PresSega_FM5,	$0D, $12
	smpsHeaderPSG       Snd_PresSega_PSG1,	$01, $09, $00, $00
	smpsHeaderPSG       Snd_PresSega_PSG2,	$01, $09, $00, $00
	smpsHeaderPSG       Snd_PresSega_PSG3,	$E9, $01, $00, $00

; FM1 Data
Snd_PresSega_FM1:
	smpsSetvoice        $05
	smpsAlterNote       $FE
	smpsModSet          $14, $01, $06, $06
	dc.b	nA4, $06, nCs5, nB4, nD5
	smpsFMAlterVol      $FF
	dc.b	nCs5, nE5, nD5, nFs5
	smpsFMAlterVol      $FF
	dc.b	nE5, nAb5, nFs5, nA5
	smpsFMAlterVol      $FF
	dc.b	nAb5, nB5, nA5, nCs6
	smpsSetvoice        $00
	dc.b	nA4, $18, nFs4, $0C, nE4, nA4, nFs4, nD4, nE4, smpsNoAttack, nE4, $24
	dc.b	nD5, $18
	smpsNoteFill        $06
	dc.b	$0C, $0C, $0C
	smpsNoteFill        $00
	smpsFMAlterVol      $FD
	dc.b	nD5, nCs5, $18, nA4, nB4, nRst, $0C, nE5, nD5, $18, nA4, nB4
	smpsFMAlterVol      $FE
	dc.b	nCs5, $0C
	smpsStop

; FM2 Data
Snd_PresSega_FM2:
	smpsSetvoice        $01
	dc.b	nE1, $06, nE1, nRst, nE1, nRst, nE1, nE1, smpsNoAttack, nE1, nRst, nRst
	dc.b	nE1, smpsNoAttack, nE1, nE1, nE1, nE1, nE1, nA1, $06, nA1, nRst, nA1
	dc.b	nRst, nA1, nA1, smpsNoAttack, nA1, nFs1, $0C, nFs1, smpsNoAttack, nFs1, nE1, nE1
	dc.b	$06, nE1, nRst, nE1, nRst, nE1, nD1, smpsNoAttack, nD1, nRst, nD1, nRst
	dc.b	nD2, smpsNoAttack, nD2, nD1, nD1, nD1, nA1, nA1, nRst, nA1, nRst, nA1
	dc.b	nA1, smpsNoAttack, nA1, nFs1, $0C, nFs1, smpsNoAttack, nFs1, nG1, nG1, $06, nG1
	dc.b	nRst, nG1, nRst, nG1, nE1, smpsNoAttack, nE1, nRst, nE1, nRst, nE2, smpsNoAttack
	dc.b	nE2, nE1
	smpsFMAlterVol      $FD
	dc.b	nA1, $60
	smpsStop

; FM3 Data
Snd_PresSega_FM3:
	smpsSetvoice        $05
	smpsAlterNote       $02
	smpsModSet          $15, $01, $06, $06
	dc.b	nRst, $03, nB4, $06, nE5, nCs5, nFs5
	smpsFMAlterVol      $FF
	dc.b	nD5, nAb5, nE5, nA5
	smpsFMAlterVol      $FF
	dc.b	nFs5, nB5, nAb5, nCs6
	smpsFMAlterVol      $FF
	dc.b	nA5, nD6, nB5, nE6, $03
	smpsSetvoice        $00
	dc.b	nRst, $07, nA4, $18, nFs4, $0C, nE4, nA4, nFs4, nD4, nE4, smpsNoAttack
	dc.b	nE4, $24, nD5, $18
	smpsNoteFill        $06
	dc.b	$0C, $0C, $0C
	smpsNoteFill        $00
	smpsFMAlterVol      $FD
	dc.b	nD5, nCs5, $18, nA4, nB4, nRst, $0C, nE5, nD5, $18, nA4, nB4
	dc.b	$05, nRst, $05
	smpsFMAlterVol      $FE
	dc.b	nA4, $0C
	smpsStop

; FM4 Data
Snd_PresSega_FM4:
	smpsSetvoice        $04
	smpsPan             panRight, $00
	smpsModSet          $01, $01, $0C, $00
	dc.b	nG2, $60
	smpsSetvoice        $03
	smpsModSet          $00, $00, $00, $00
	dc.b	nA3, nB3, $24, nA3, $30, smpsNoAttack, $0C
	smpsSetvoice        $02
	dc.b	nA4, $24, nA4, $30, nRst, $0C
	smpsFMAlterVol      $FF
	dc.b	nB4, $24, nB4, $30
	smpsFMAlterVol      $FF
	dc.b	nCs5, $0C
	smpsStop

; FM5 Data
Snd_PresSega_FM5:
	smpsSetvoice        $04
	smpsPan             panLeft, $00
	smpsModSet          $01, $01, $0C, $00
	dc.b	nG2, $60
	smpsSetvoice        $03
	smpsModSet          $00, $00, $00, $00
	dc.b	nE3, nE3, $24, nD3, $30, smpsNoAttack, $0C
	smpsSetvoice        $02
	dc.b	nE4, $24, nD4, $30, nRst, $0C
	smpsFMAlterVol      $FF
	dc.b	nG4, $24, nE4, $30
	smpsFMAlterVol      $FF
	dc.b	nE4, $0C
	smpsStop

; PSG1 Data
Snd_PresSega_PSG1:
	smpsPSGvoice        sTone_0C
	dc.b	nA2, $06, nCs3, nB2, nD3
	smpsPSGAlterVol     $FF
	dc.b	nCs3, nE3, nD3, nFs3
	smpsPSGAlterVol     $FF
	dc.b	nE3, nAb3, nFs3, nA3
	smpsPSGAlterVol     $FF
	dc.b	nAb3, nB3, nA3, nCs4
	smpsPSGAlterVol     $FD
	smpsPSGvoice        sTone_0A
	dc.b	nE4, $0C, nB3, nE4, nB3, nE4, nB3, nE4, nB3, nD4, nB3, nD4
	dc.b	nB3, nD4, nB3, nD4, nB3, nE4, $0C, nB3, nE4, nB3, nD4, nB3
	dc.b	nD4, nB3, nD4, nA3, nD4, nA3, nE4, nB3, nE4
	smpsPSGAlterVol     $01

Snd_PresSega_Loop01:
	dc.b	nA4
	smpsPSGAlterVol     $01
	dc.b	nG5
	smpsPSGAlterVol     $01
	smpsLoop            $00, $05, Snd_PresSega_Loop01
	smpsStop

; PSG2 Data
Snd_PresSega_PSG2:
	smpsPSGvoice        sTone_0C
	dc.b	nRst, $03, nB2, $06, nE3, nCs3, nFs3
	smpsPSGAlterVol     $FF
	dc.b	nD3, nAb3, nE3, nA3
	smpsPSGAlterVol     $FF
	dc.b	nFs3, nB3, nAb3, nCs4
	smpsPSGAlterVol     $FF
	dc.b	nA3, nD4, nB3, nE4, $03
	smpsPSGAlterVol     $FD
	smpsPSGvoice        sTone_0A
	dc.b	nRst, $06, nCs4, $0C, nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b	nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4, $0C, nA3, nCs4, nA3
	dc.b	nCs4, nA3, nCs4, nA3, nB3, nG3, nB3, nG3, nCs4, nA3, nCs4
	smpsPSGAlterVol     $01

Snd_PresSega_Loop00:
	dc.b	nE5
	smpsPSGAlterVol     $01
	dc.b	nA5
	smpsPSGAlterVol     $01
	smpsLoop            $00, $05, Snd_PresSega_Loop00
	smpsStop

; PSG3 Data
Snd_PresSega_PSG3:
	smpsPSGvoice        sTone_0A
	smpsModSet          $14, $01, $03, $06
	dc.b	nRst, $60, nA4, $18, nFs4, $0C, nE4, nA4, nFs4, nD4, nE4, smpsNoAttack
	dc.b	nE4, $24, nD5, $18
	smpsNoteFill        $06
	dc.b	$0C, $0C, $0C
	smpsNoteFill        $00
	smpsModSet          $00, $00, $00, $00
	dc.b	nA4, $24, nD4, $30, nRst, $0C, nG4, $24, nE4, $30, nCs4, $0C
	smpsStop

; DAC Data
Snd_PresSega_DAC:
	smpsFade            $25
	dc.b	dCrashCymbal, $30, nRst, $0C, dSnareS3, dSnareS3, dSnareS3, $06, $06, dCrashCymbal, $18, dSnareS3
	dc.b	$0C, dKickS3, dKickS3, $06, dKickS3, dKickS3, $0C, dSnareS3, $18, dKickS3, $18, dSnareS3
	dc.b	$0C, dKickS3, dKickS3, $06, dKickS3, dKickS3, $0C, dSnareS3, $06, $06, nRst, nRst
	dc.b	dKickS3, $18, dSnareS3, dKickS3, $06, dKickS3, dKickS3, $0C, dSnareS3, $18, dKickS3, dSnareS3
	dc.b	$12, dKickS3, $06, dKickS3, dKickS3, dKickS3, $0C, dSnareS3, dCrashCymbal, $60
	smpsStop

Snd_PresSega_Voices:
;	Voice $00
;	$3D
;	$01, $01, $11, $12, 	$18, $1F, $1F, $1F, 	$10, $06, $06, $06
;	$01, $00, $00, $00, 	$3F, $1F, $1F, $1F, 	$10, $83, $83, $83
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $01, $00, $00
	smpsVcCoarseFreq    $02, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $18
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $06, $06, $10
	smpsVcDecayRate2    $00, $00, $00, $01
	smpsVcDecayLevel    $01, $01, $01, $03
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $03, $03, $03, $10

;	Voice $01
;	$00
;	$23, $30, $30, $21, 	$9F, $5F, $1F, $1F, 	$00, $0F, $01, $00
;	$07, $00, $00, $0C, 	$0F, $4F, $FF, $0F, 	$26, $30, $1D, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $02, $03, $03, $02
	smpsVcCoarseFreq    $01, $00, $00, $03
	smpsVcRateScale     $00, $00, $01, $02
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $01, $0F, $00
	smpsVcDecayRate2    $0C, $00, $00, $07
	smpsVcDecayLevel    $00, $0F, $04, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1D, $30, $26

;	Voice $02
;	$3C
;	$71, $31, $12, $11, 	$17, $1F, $19, $2F, 	$04, $01, $07, $01
;	$00, $00, $00, $00, 	$F7, $F8, $F7, $F8, 	$1D, $80, $19, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $01, $03, $07
	smpsVcCoarseFreq    $01, $02, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $2F, $19, $1F, $17
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $07, $01, $04
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $08, $07, $08, $07
	smpsVcTotalLevel    $00, $19, $00, $1D

;	Voice $03
;	$2C
;	$71, $62, $31, $32, 	$5F, $54, $5F, $5F, 	$00, $09, $00, $09
;	$00, $03, $00, $03, 	$0F, $8F, $0F, $AF, 	$16, $80, $11, $80
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
	smpsVcTotalLevel    $00, $11, $00, $16

;	Voice $04
;	$3D
;	$51, $21, $30, $10, 	$1F, $1F, $1F, $1F, 	$0F, $00, $00, $00
;	$00, $00, $00, $00, 	$1F, $4F, $4F, $4F, 	$10, $8E, $8E, $8E
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $03, $02, $05
	smpsVcCoarseFreq    $00, $00, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $0F
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $04, $04, $04, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0E, $0E, $0E, $10

;	Voice $05
;	$04
;	$12, $0A, $06, $7C, 	$5F, $5F, $5F, $5F, 	$00, $08, $00, $00
;	$00, $00, $00, $0A, 	$0F, $FF, $0F, $0F, 	$11, $8C, $13, $8C
	smpsVcAlgorithm     $04
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $00, $00, $01
	smpsVcCoarseFreq    $0C, $06, $0A, $02
	smpsVcRateScale     $01, $01, $01, $01
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $08, $00
	smpsVcDecayRate2    $0A, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $0F, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0C, $13, $0C, $11

