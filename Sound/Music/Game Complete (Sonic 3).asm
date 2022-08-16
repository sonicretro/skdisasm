Snd_S3_PresSega_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_S3_PresSega_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $10

	smpsHeaderDAC       Snd_S3_PresSega_DAC
	smpsHeaderFM        Snd_S3_PresSega_FM1,	$0D, $10
	smpsHeaderFM        Snd_S3_PresSega_FM2,	$0D, $1B
	smpsHeaderFM        Snd_S3_PresSega_FM3,	$01, $05
	smpsHeaderFM        Snd_S3_PresSega_FM4,	$0D, $18
	smpsHeaderFM        Snd_S3_PresSega_FM5,	$0D, $13
	smpsHeaderPSG       Snd_S3_PresSega_PSG1,	$01, $01, $00, $00
	smpsHeaderPSG       Snd_S3_PresSega_PSG2,	$01, $01, $00, $00
	smpsHeaderPSG       Snd_S3_PresSega_PSG3,	$00, $04, $00, $00

; FM1 Data
Snd_S3_PresSega_FM1:
	smpsSetvoice        $00
	smpsModSet          $14, $01, $06, $06
	smpsFMAlterVol      $18
	dc.b	nD3, $06, nA2
	smpsFMAlterVol      $FD
	dc.b	nD3, nFs3
	smpsFMAlterVol      $FD
	dc.b	nD3, nFs3
	smpsFMAlterVol      $FD
	dc.b	nA3, nFs3
	smpsFMAlterVol      $FD
	dc.b	nA3, nC4
	smpsFMAlterVol      $FD
	dc.b	nA3, nC4
	smpsFMAlterVol      $FD
	dc.b	nD4, nC4
	smpsFMAlterVol      $FD
	dc.b	nD4, nFs4
	smpsFMAlterVol      $FD
	dc.b	nBb3, $02, smpsNoAttack, nB3, $04, nRst, $06, nB3, $0C, nC4, $06, nRst
	dc.b	nC4, $0C, nD4, $0C, nRst, nD4, $06, nRst, nBb3, $04, smpsNoAttack, nB3
	dc.b	$0E, nRst, $06, nB3, $0C, nC4, $06, nRst, nD4, $12, nRst, $06
	dc.b	nCs4, nRst, nD4, $12, nRst, $06
	smpsFMAlterVol      $FE
	dc.b	nF4, $0C, nRst, nF4, nRst, nF4, nE4, nF4, $06, nRst
	smpsFMAlterVol      $FE
	dc.b	nFs4, $04

Snd_S3_PresSega_Loop04:
	smpsFMAlterVol      $FF
	dc.b	smpsNoAttack, nG4, $17
	smpsLoop            $00, $04, Snd_S3_PresSega_Loop04
	smpsStop

; FM2 Data
Snd_S3_PresSega_FM2:
	smpsSetvoice        $00
	smpsModSet          $15, $01, $06, $06
	smpsFMAlterVol      $18
	dc.b	nA2, $06, nFs2
	smpsFMAlterVol      $FD
	dc.b	nA2, nC3
	smpsFMAlterVol      $FD
	dc.b	nA2, nC3
	smpsFMAlterVol      $FD
	dc.b	nD3, nC3
	smpsFMAlterVol      $FD
	dc.b	nD3, nFs3
	smpsFMAlterVol      $FD
	dc.b	nD3, nFs3
	smpsFMAlterVol      $FD
	dc.b	nA3, nFs3
	smpsFMAlterVol      $FD
	dc.b	nA3, nC4
	smpsFMAlterVol      $FD
	dc.b	nRst, $03, nG3, $06, nRst, nG3, $0C, nA3, $06, nRst, nA3, $0C
	dc.b	nB3, $0C, nRst, nB3, $06, nRst, nFs3, $04, smpsNoAttack, nG3, $0E, nRst
	dc.b	$06, nG3, $0C, nA3, $06, nRst, nB3, $12, nRst, $06, nBb3, nRst
	dc.b	nB3, $12, nRst, $06
	smpsFMAlterVol      $FE
	dc.b	nC4, $0C, nRst, nC4, nRst, nC4, nB3, nA3, $06, nRst
	smpsFMAlterVol      $FE
	dc.b	nBb3, $04

Snd_S3_PresSega_Loop03:
	smpsFMAlterVol      $FF
	dc.b	smpsNoAttack, nB3, $17
	smpsLoop            $00, $04, Snd_S3_PresSega_Loop03
	smpsStop

; FM3 Data
Snd_S3_PresSega_FM3:
	smpsSetvoice        $03
	smpsAlterPitch      $0C
	smpsFMAlterVol      $28
	dc.b	nA2, $0C
	smpsFMAlterVol      $FD
	dc.b	nA2
	smpsFMAlterVol      $FD
	dc.b	nA2
	smpsFMAlterVol      $FD
	dc.b	nD3
	smpsFMAlterVol      $FD
	dc.b	nD3
	smpsFMAlterVol      $FD
	dc.b	nD3
	smpsFMAlterVol      $FD
	dc.b	nA3
	smpsFMAlterVol      $FD
	dc.b	nA3
	smpsFMAlterVol      $ED
	smpsAlterPitch      $F4
	smpsSetvoice        $01
	smpsCall            Snd_S3_Title_Call04
	smpsCall            Snd_S3_Title_Call05
	dc.b	nE2, $05, nRst, $01, nRst, $06
	smpsCall            Snd_S3_Title_Call06
	dc.b	nA2, $05, nRst, $01, nRst, $06, nG2, $05, nRst, $01, nG2, $05
	dc.b	nRst, $01, nG2, $05, nRst, $01, nRst, $06, nG2, $05, nRst, $01
	dc.b	nRst, $06, nG2, $05, nRst, $01, nG2, $05, nRst, $06, nG3, $06
	dc.b	nRst, $01, nG2, $05, nRst, $07, nG3, $0A, nRst, $08, nG2, $60
	smpsStop

; FM4 Data
Snd_S3_PresSega_FM4:
	smpsSetvoice        $03
	smpsFMAlterVol      $10
	dc.b	nRst, $06, nFs2, $0C
	smpsFMAlterVol      $FD
	dc.b	nC3
	smpsFMAlterVol      $FD
	dc.b	nC3
	smpsFMAlterVol      $FD
	dc.b	nC3
	smpsFMAlterVol      $FD
	dc.b	nFs3
	smpsFMAlterVol      $FD
	dc.b	nFs3
	smpsFMAlterVol      $FD
	dc.b	nFs3
	smpsFMAlterVol      $FD
	dc.b	nC4, $06
	smpsFMAlterVol      $05
	dc.b	nRst, $03

Snd_S3_PresSega_Loop00:
	smpsCall            Snd_S3_Title_Call00
	smpsLoop            $00, $08, Snd_S3_PresSega_Loop00

Snd_S3_PresSega_Loop01:
	smpsCall            Snd_S3_Title_Call01
	smpsLoop            $00, $04, Snd_S3_PresSega_Loop01

Snd_S3_PresSega_Loop02:
	smpsCall            Snd_S3_Title_Call00
	smpsLoop            $00, $04, Snd_S3_PresSega_Loop02
	smpsPan             panLeft, $00
	smpsStop

; FM5 Data
Snd_S3_PresSega_FM5:
	dc.b	nRst, $0D
	smpsFMAlterVol      $05
	smpsJump            Snd_S3_PresSega_FM1

; PSG1 Data
Snd_S3_PresSega_PSG1:
	smpsPSGvoice        sTone_0A
	dc.b	nRst, $60, nG3, nA3, nC4, nD4
	smpsStop

; PSG2 Data
Snd_S3_PresSega_PSG2:
	smpsPSGvoice        sTone_0A
	dc.b	nRst, $60, nD3, nF3, nA3, nB3
	smpsStop

; PSG3 Data
Snd_S3_PresSega_PSG3:
	smpsPSGform         $E7
	smpsPSGvoice        sTone_02
	dc.b	nRst, $60

Snd_S3_PresSega_Loop05:
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsPSGAlterVol     $04
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsPSGAlterVol     $04
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsPSGAlterVol     $04
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsPSGAlterVol     $04
	smpsLoop            $00, $03, Snd_S3_PresSega_Loop05
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsPSGAlterVol     $04
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsPSGAlterVol     $04
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG2, $06, nMaxPSG2, nMaxPSG2, nMaxPSG2, nMaxPSG2, nMaxPSG2
	smpsStop

; DAC Data
Snd_S3_PresSega_DAC:
	smpsFade            $25
	dc.b	dCrashCymbal, $30, nRst, $06, dSnareS3, dSnareS3, $06, nRst, dSnareS3, nRst, dSnareS3, dSnareS3
	dc.b	dKickS3, $18, dSnareS3, dKickS3, dSnareS3, dKickS3, dSnareS3, dKickS3, dSnareS3, $06, nRst, nRst
	dc.b	dSnareS3, $06, dKickS3, $18, dSnareS3, dKickS3, dSnareS3, dKickS3, dSnareS3, $06, nRst, nRst
	dc.b	dSnareS3, dKickS3, dSnareS3, dSnareS3, nRst, dSnareS3, $06, nRst, dSnareS3, dCrashCymbal
	smpsStop

Snd_S3_PresSega_Voices:
;	Voice $00
;	$3D
;	$01, $01, $12, $12, 	$1F, $1F, $1F, $1F, 	$10, $06, $06, $06
;	$01, $00, $00, $00, 	$30, $1A, $1A, $1A, 	$0E, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $01, $00, $00
	smpsVcCoarseFreq    $02, $02, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $06, $06, $10
	smpsVcDecayRate2    $00, $00, $00, $01
	smpsVcDecayLevel    $01, $01, $01, $03
	smpsVcReleaseRate   $0A, $0A, $0A, $00
	smpsVcTotalLevel    $00, $00, $00, $0E

;	Voice $01
;	$00
;	$2A, $30, $30, $21, 	$9F, $5F, $1F, $1F, 	$00, $0F, $01, $00
;	$07, $00, $00, $0C, 	$0F, $4F, $FF, $0F, 	$26, $30, $1D, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $02, $03, $03, $02
	smpsVcCoarseFreq    $01, $00, $00, $0A
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
;	$00, $00, $00, $00, 	$F7, $F8, $F7, $F8, 	$1D, $84, $19, $84
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
	smpsVcTotalLevel    $04, $19, $04, $1D

;	Voice $03
;	$04
;	$17, $03, $06, $74, 	$5F, $5F, $5F, $5F, 	$00, $08, $00, $00
;	$00, $00, $00, $0A, 	$0F, $FF, $0F, $0F, 	$1C, $83, $23, $83
	smpsVcAlgorithm     $04
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $00, $00, $01
	smpsVcCoarseFreq    $04, $06, $03, $07
	smpsVcRateScale     $01, $01, $01, $01
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $08, $00
	smpsVcDecayRate2    $0A, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $0F, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $03, $23, $03, $1C

