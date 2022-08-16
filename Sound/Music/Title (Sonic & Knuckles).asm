Snd_Title_Header:
	smpsHeaderStartSong 3, 1
	smpsHeaderVoice     Snd_Title_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $00

	smpsHeaderDAC       Snd_Title_DAC
	smpsHeaderFM        Snd_Title_FM1,	$00, $15
	smpsHeaderFM        Snd_Title_FM2,	$0C, $1C
	smpsHeaderFM        Snd_Title_FM3,	$00, $10
	smpsHeaderFM        Snd_Title_FM4,	$00, $05
	smpsHeaderFM        Snd_Title_FM5,	$00, $05
	smpsHeaderPSG       Snd_Title_PSG1,	$E8, $05, $00, sTone_0A
	smpsHeaderPSG       Snd_Title_PSG2,	$F4, $02, $00, sTone_0A
	smpsHeaderPSG       Snd_Title_PSG3,	$E8, $05, $00, sTone_0A

; FM1 Data
Snd_Title_FM1:
	smpsSetvoice        $04
	smpsAlterNote       $F6
	dc.b	nRst, $6C
	smpsModSet          $2A, $01, $29, $00
	dc.b	nE4, $3C, smpsNoAttack
	smpsModSet          $01, $00, $00, $00
	dc.b	nE4, $18
	smpsSetvoice        $00
	smpsAlterNote       $00
	smpsModSet          $14, $01, $04, $07

Snd_Title_Jump00:
	dc.b	nA4, $18, nFs4, $0C, nE4, nA4, nFs4, nD4, nE4, $30, nD5, $18
	smpsNoteFill        $06
	dc.b	$0C, $0C, $0C
	smpsNoteFill        $00
	dc.b	nCs5, $18, nA4, $0C, nE4, nFs4, $04, nRst, $08, nA4, $18, nB4
	dc.b	$0C, smpsNoAttack, nB4, $30, nRst, nA4, $18, nFs4, $0C, nE4, nA4, nFs4
	dc.b	nD4, nE4, $30, nD5, $18, nCs5, $0C, nB4, nA4, $0C
	smpsNoteFill        $17
	smpsFMAlterVol      $FE
	dc.b	nCs5, $18
	smpsNoteFill        $06
	dc.b	nA4, $0C, $0C, nG4
	smpsNoteFill        $00
	dc.b	nG4, $18, nA4, $09
	smpsStop

; Unreachable
	smpsStop

; FM2 Data
Snd_Title_FM2:
	smpsSetvoice        $01
	smpsModSet          $15, $01, $06, $06
	dc.b	nE1, $06, nE1, nRst, nE1, nRst, nE1, nE1, smpsNoAttack, nE1, nRst, nRst
	dc.b	nE1, smpsNoAttack, nE1, nE1, nE1, nE1, smpsNoAttack, nE1, nE1, $06, nE1, nRst
	dc.b	nE1, nRst, nE1, nE1, smpsNoAttack, nE1, nRst, nRst, nE1, smpsNoAttack, nE1, nE1
	dc.b	nE1, nE1, nE1, nA1, $06, nA1, nRst, nA1, nRst, nA1, nA1, smpsNoAttack
	dc.b	nA1, nFs1, $0C, nFs1, smpsNoAttack, nFs1, nE1, nE1, $06, nE1, nRst, nE1
	dc.b	nRst, nE1, nD1, smpsNoAttack, nD1, nRst, nD1, nRst, nD2, smpsNoAttack, nD2, nD1
	dc.b	nD1, nD1, nA1, nA1, nRst, nA1, nRst, nA1, nA1, smpsNoAttack, nA1, nFs1
	dc.b	$0C, nFs1, smpsNoAttack, nFs1, nG1, nG1, $06, nG1, nRst, nG1, nRst, nG1
	dc.b	nE1, smpsNoAttack, nE1, nRst, nE1, nRst, nE2, smpsNoAttack, nE2, nE1, nE1, nE1
	dc.b	nA1, nA1, nRst, nA1, nRst, nA1, nA1, smpsNoAttack, nA1, nFs1, $0C, nFs1
	dc.b	smpsNoAttack, nFs1, nE1, nE1, $06, nE1, nRst, nE1, nRst, nE1, nD1, smpsNoAttack
	dc.b	nD1, nRst, nD1, nRst, nD2, smpsNoAttack, nD2, nD1, nD1, nD1, nRst, $54
	dc.b	nA0, $78
	smpsStop

; FM3 Data
Snd_Title_FM3:
	smpsSetvoice        $04
	smpsPan             panCenter, $00
	dc.b	nRst, $60
	smpsModSet          $2A, $01, $29, $00
	dc.b	nE4, $3C, smpsNoAttack
	smpsModSet          $01, $00, $00, $00
	dc.b	nE4, $24
	smpsSetvoice        $02
	smpsPan             panLeft, $00
	smpsModSet          $00, $00, $00, $00

Snd_Title_Loop00:
	dc.b	nA2, $06, nA2
	smpsFMAlterVol      $FD
	dc.b	nA2, nA2
	smpsFMAlterVol      $FD
	dc.b	nA2, nA2
	smpsFMAlterVol      $FD
	dc.b	nA2, nFs2
	smpsFMAlterVol      $FD
	dc.b	nFs2, nFs2
	smpsFMAlterVol      $03
	dc.b	nFs2, nFs2
	smpsFMAlterVol      $03
	dc.b	nFs2, nFs2
	smpsFMAlterVol      $03
	dc.b	nE2, nE2
	smpsFMAlterVol      $03
	dc.b	nE2, nE2
	smpsFMAlterVol      $03
	dc.b	nE3, nE2
	smpsFMAlterVol      $03
	dc.b	nB2, nE2
	smpsFMAlterVol      $03
	dc.b	nD2, nD2
	smpsFMAlterVol      $03
	dc.b	nD2, nD2
	smpsFMAlterVol      $FD
	dc.b	nD3, nD2
	smpsFMAlterVol      $FD
	dc.b	nA2, nD2
	smpsFMAlterVol      $FD
	dc.b	nD3, nD2
	smpsFMAlterVol      $FD
	smpsLoop            $00, $02, Snd_Title_Loop00
	dc.b	nA2, $06, nA2
	smpsFMAlterVol      $FD
	dc.b	nA2, nA2
	smpsFMAlterVol      $FD
	dc.b	nA2, nA2
	smpsFMAlterVol      $FD
	dc.b	nA2, nFs2
	smpsFMAlterVol      $FD
	dc.b	nFs2, nFs2
	smpsFMAlterVol      $03
	dc.b	nFs2, nFs2
	smpsFMAlterVol      $03
	dc.b	nFs2, nFs2
	smpsFMAlterVol      $03
	dc.b	nE2, nE2
	smpsFMAlterVol      $03
	dc.b	nE2, nE2
	smpsFMAlterVol      $03
	dc.b	nE3, nE2
	smpsFMAlterVol      $03
	dc.b	nE3, nE2
	smpsFMAlterVol      $03
	dc.b	nD2, nD2
	smpsFMAlterVol      $03
	dc.b	nD2, nD2
	smpsFMAlterVol      $FD
	dc.b	nD3, nD2
	smpsFMAlterVol      $FD
	dc.b	nA2, nD2
	smpsFMAlterVol      $FD
	dc.b	nD3, nD2
	smpsFMAlterVol      $FD
	smpsStop

; FM4 Data
Snd_Title_FM4:
	smpsSetvoice        $05
	smpsAlterNote       $FC
	smpsPan             panRight, $00
	smpsModSet          $01, $01, $06, $00
	dc.b	nG3, $60, smpsNoAttack, nG3
	smpsSetvoice        $03
	smpsModSet          $14, $01, $04, $06
	dc.b	nRst, $18, nA3, $0C, nRst, $18, nFs3, $09, nRst, $0F, nE3, $24
	dc.b	nRst, $48, nRst, $18, nA3, $0C, nRst, $18, nA3, $09, nRst, $1B
	dc.b	nB3, $06, nRst, nB3, $18, nB3, $30, nRst, $0C, nA3, $0C, nRst
	dc.b	$09, nRst, $03, nRst, $0C, nRst, nRst, nFs3, $09, nRst, $0F, nE3
	dc.b	$3C, nRst, $30
	smpsNoteFill        $17
	dc.b	nCs4, $18
	smpsNoteFill        $06
	dc.b	nA3, $0C, $0C, nG3
	smpsNoteFill        $00
	dc.b	nG3, $18, nA3, $09
	smpsStop

; FM5 Data
Snd_Title_FM5:
	smpsPan             panLeft, $00
	smpsSetvoice        $05
	smpsModSet          $01, $01, $06, $00
	dc.b	nG3, $60, smpsNoAttack, nG3
	smpsSetvoice        $03
	smpsAlterNote       $04
	smpsModSet          $14, $01, $04, $06
	dc.b	nRst, $18, nA3, $0C, nRst, $18, nFs3, $09, nRst, $0F, nE3, $24
	dc.b	nRst, $48, nRst, $18, nA3, $0C, nRst, $18, nFs3, $09, nRst, $1B
	dc.b	nG3, $06, nRst, nG3, $18, nE3, $30, nRst, $0C, nA3, $0C, nRst
	dc.b	$09, nRst, $03, nRst, $0C, nRst, nRst, nFs3, $09, nRst, $0F, nE3
	dc.b	$3C, nRst, $30
	smpsNoteFill        $17
	dc.b	nCs4, $18
	smpsNoteFill        $06
	dc.b	nA3, $0C, $0C, nG3
	smpsNoteFill        $00
	dc.b	nG3, $18, nA3, $09
	smpsStop

; PSG1 Data
Snd_Title_PSG1:
	smpsPSGvoice        sTone_0A
	dc.b	nRst, $60, nA3, $06, nCs4, nB3, nD4
	smpsPSGAlterVol     $FF
	dc.b	nCs4, nE4, nD4, nFs4
	smpsPSGAlterVol     $FF
	dc.b	nE4, nAb4, nFs4, nA4
	smpsPSGAlterVol     $FF
	dc.b	nAb4, nB4, nA4, nCs5
	smpsPSGAlterVol     $03
	smpsAlterPitch      $0C
	smpsModSet          $00, $00, $00, $00
	dc.b	nE4, $0C, nB3, nE4, nB3, nE4, nB3, nE4, nB3, nD4, nB3, nE4
	dc.b	nB3, nE4, nB3, nE4, nB3, nE4, $0C, nB3, nE4, nB3, nE4, nB3
	dc.b	nE4, nB3, nD4, nB3, nD4, nB3, nD5, nB4, nD5, nB4, nE4, $0C
	dc.b	nB3, nE4, nB3, nE4, nB3, nE4, nB3, nD4, nB3, nE4, nB3, nE4
	dc.b	nB3, nE4, nB3, nRst, $60, nG3, $0C
	smpsPSGAlterVol     $01
	dc.b	nA3, $18
	smpsPSGAlterVol     $01
	dc.b	nCs4, $24
	smpsPSGAlterVol     $01
	dc.b	nE3, $18
	smpsPSGAlterVol     $01
	dc.b	nG3, $0C
	smpsPSGAlterVol     $01
	dc.b	nA3, $18
	smpsPSGAlterVol     $01
	dc.b	nCs4, $24
	smpsPSGAlterVol     $01
	dc.b	nE3, $60
	smpsStop

; PSG2 Data
Snd_Title_PSG2:
	smpsModSet          $01, $01, $FD, $00
	smpsAlterNote       $04
	dc.b	nD1, $60, smpsNoAttack, $60, nRst, $06
	smpsModSet          $00, $00, $00, $00
	smpsPSGAlterVol     $03
	smpsAlterNote       $00
	dc.b	nCs4, $0C, nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b	nA3, nCs4, nA3, nCs4, nA3, nCs4, $0C, nA3, nCs4, nA3, nCs4, nA3
	dc.b	nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs5, nA4, nCs5, nA4, nCs4, $0C
	dc.b	nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b	nA3, nCs4, nA3, nRst, $5A, nA2, $18
	smpsPSGAlterVol     $01
	dc.b	nE3, $24
	smpsPSGAlterVol     $01
	dc.b	nA3, $18
	smpsPSGAlterVol     $01
	dc.b	nD4, $0C
	smpsPSGAlterVol     $01
	dc.b	nA2, $18
	smpsPSGAlterVol     $01
	dc.b	nE3, $24
	smpsPSGAlterVol     $01
	dc.b	nA3, $18
	smpsPSGAlterVol     $01
	dc.b	nD4, $60
	smpsStop

; PSG3 Data
Snd_Title_PSG3:
	smpsAlterNote       $02
	dc.b	nRst, $60, nRst, $03, nB3, $06, nE4, nCs4, nFs4
	smpsPSGAlterVol     $FF
	dc.b	nD4, nAb4, nE4, nA4
	smpsPSGAlterVol     $FF
	dc.b	nFs4, nB4, nAb4, nCs5
	smpsPSGAlterVol     $FF
	dc.b	nA4, nD5, nB4, nE5, $03
	smpsModSet          $15, $01, $03, $06
	smpsPSGAlterVol     $FF
	smpsJump            Snd_Title_Jump00

; Unreachable
	smpsStop

; DAC Data
Snd_Title_DAC:
	dc.b	dKickS3, $06, dKickS3, nRst, dKickS3, nRst, nRst, dKickS3, nRst, nRst, nRst, dKickS3
	dc.b	nRst, dSnareS3, dSnareS3, nRst, nRst, dKickS3, dKickS3, nRst, dKickS3, nRst, nRst, dSnareS3
	dc.b	nRst, nRst, nRst, dKickS3, nRst, dSnareS3, dSnareS3, dSnareS3, dSnareS3, dCrashCymbal, $06, nRst
	dc.b	nRst, dKickS3, dSnareS3, dKickS3, dKickS3, nRst, dKickS3, nRst, dKickS3, nRst, dSnareS3, nRst
	dc.b	dKickS3, nRst, dKickS3, dKickS3, nRst, dKickS3, dSnareS3, dKickS3, dKickS3, nRst, nRst, dKickS3
	dc.b	nRst, dKickS3, dSnareS3, dKickS3, dKickS3, nRst, dKickS3, $06, dKickS3, nRst, dKickS3, dSnareS3
	dc.b	dKickS3, dKickS3, nRst, dKickS3, nRst, dKickS3, nRst, dSnareS3, nRst, dKickS3, nRst, dKickS3
	dc.b	dKickS3, nRst, dKickS3, dSnareS3, dKickS3, dKickS3, nRst, nRst, dKickS3, nRst, dKickS3, dSnareS3
	dc.b	dKickS3, dKickS3, nRst, dKickS3, dKickS3, nRst, dKickS3, dSnareS3, dKickS3, dKickS3, nRst, dKickS3
	dc.b	nRst, dKickS3, nRst, dSnareS3, nRst, dKickS3, nRst, dKickS3, dKickS3, nRst, dKickS3, dSnareS3
	dc.b	dKickS3, dKickS3, nRst, nRst, dKickS3, nRst, dKickS3, dSnareS3, dKickS3, dKickS3, dKickS3, dKickS3
	dc.b	nRst, nRst, nRst, dSnareS3, nRst, nRst, dSnareS3, dKickS3, $0C, dKickS3, dSnareS3, dCrashCymbal
	smpsStop

Snd_Title_Voices:
;	Voice $00
;	$3D
;	$61, $02, $12, $52, 	$1F, $18, $18, $1B, 	$09, $02, $01, $02
;	$06, $00, $00, $00, 	$5F, $4F, $3F, $4F, 	$17, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $05, $01, $00, $06
	smpsVcCoarseFreq    $02, $02, $02, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1B, $18, $18, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $01, $02, $09
	smpsVcDecayRate2    $00, $00, $00, $06
	smpsVcDecayLevel    $04, $03, $04, $05
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $80, $80, $80, $17

;	Voice $01
;	$2D
;	$01, $51, $31, $21, 	$13, $1F, $19, $1F, 	$0B, $09, $00, $0B
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$0C, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $02, $03, $05, $00
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $19, $1F, $13
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0B, $00, $09, $0B
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $80, $80, $80, $0C

;	Voice $02
;	$0A
;	$51, $76, $01, $19, 	$1C, $1B, $1C, $1F, 	$00, $08, $04, $11
;	$00, $01, $00, $00, 	$1F, $FF, $FF, $7F, 	$82, $10, $32, $0C
	smpsVcAlgorithm     $02
	smpsVcFeedback      $01
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $00, $07, $05
	smpsVcCoarseFreq    $09, $01, $06, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1C, $1B, $1C
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $11, $04, $08, $00
	smpsVcDecayRate2    $00, $00, $01, $00
	smpsVcDecayLevel    $07, $0F, $0F, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0C, $32, $10, $82

;	Voice $03
;	$2A
;	$32, $2A, $01, $02, 	$12, $12, $11, $16, 	$0A, $0E, $0E, $08
;	$00, $00, $00, $00, 	$FF, $FF, $1F, $CF, 	$15, $15, $2C, $85
	smpsVcAlgorithm     $02
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $02, $03
	smpsVcCoarseFreq    $02, $01, $0A, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $16, $11, $12, $12
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $0E, $0E, $0A
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0C, $01, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $85, $2C, $15, $15

;	Voice $04
;	$3D
;	$12, $58, $04, $15, 	$0F, $1A, $1C, $1A, 	$00, $00, $0F, $05
;	$00, $00, $00, $00, 	$0F, $0F, $1F, $FF, 	$22, $86, $86, $86
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $00, $05, $01
	smpsVcCoarseFreq    $05, $04, $08, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1A, $1C, $1A, $0F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $0F, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $01, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $86, $86, $86, $22

;	Voice $05
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
	smpsVcTotalLevel    $8E, $8E, $8E, $10

