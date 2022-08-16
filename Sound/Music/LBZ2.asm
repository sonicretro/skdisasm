Snd_LBZ2_Header:
	smpsHeaderStartSong 3, 1
	smpsHeaderVoice     Snd_LBZ_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $2F

	smpsHeaderDAC       Snd_LBZ2_DAC
	smpsHeaderFM        Snd_LBZ2_FM1,	$00, $0C
	smpsHeaderFM        Snd_LBZ2_FM2,	$0C, $08
	smpsHeaderFM        Snd_LBZ2_FM3,	$00, $0C
	smpsHeaderFM        Snd_LBZ2_FM4,	$00, $0C
	smpsHeaderFM        Snd_LBZ2_FM5,	$0C, $0C
	smpsHeaderPSG       Snd_LBZ2_PSG1,	$F4, $02, $00, $00
	smpsHeaderPSG       Snd_LBZ2_PSG2,	$F4, $04, $00, $00
	smpsHeaderPSG       Snd_LBZ_PSG3,	$00, $02, $00, $00

; FM1 Data
Snd_LBZ2_FM1:
	smpsSetvoice        $02
	dc.b	nRst, $60, nRst, nRst, nRst

Snd_LBZ2_Jump05:
	dc.b	nRst, $60, nRst, nRst, nRst
	smpsCall            Snd_LBZ2_Call0A
	smpsCall            Snd_LBZ2_Call0B
	dc.b	nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst, nRst

Snd_LBZ2_Loop06:
	smpsCall            Snd_LBZ2_Call0B
	smpsLoop            $00, $02, Snd_LBZ2_Loop06
	dc.b	nRst, $0C, nC5, nRst, $48
	smpsJump            Snd_LBZ2_Jump05

Snd_LBZ2_Call0A:
	smpsSetvoice        $02
	dc.b	nRst, $60, nRst, nRst, nRst, $48
	smpsSetvoice        $03
	smpsModSet          $06, $01, $12, $01
	dc.b	nEb5, $0C
	smpsModSet          $01, $01, $01, $04
	dc.b	nEb5, $0C
	smpsReturn

Snd_LBZ2_Call0B:
	smpsSetvoice        $02
	dc.b	nRst, $06, nEb4, nRst, $0C, nEb4, $12, nEb4, $06, nRst, $18, nC4
	dc.b	$06, nBb3, nG3, nF3, nRst, $18, nEb4, $12, nEb4, $06, nRst, $18
	smpsSetvoice        $03
	smpsModSet          $01, $01, $03, $05
	dc.b	nEb5
	smpsModSet          $01, $01, $01, $04
	smpsSetvoice        $02
	dc.b	nRst, $06, nEb4, nRst, $0C, nEb4, $12, nEb4, $06, nRst, $18, nC4
	dc.b	$06, nBb3, nG3, nF3
	smpsModSet          $01, $01, $01, $04
	dc.b	nRst, $18, nEb4, $12, nEb4, $06, nRst, $18
	smpsSetvoice        $03
	smpsModSet          $06, $01, $12, $01
	dc.b	nEb5, $0C
	smpsModSet          $01, $01, $01, $04
	dc.b	nEb5, $0C
	smpsReturn

; FM2 Data
Snd_LBZ2_FM2:
	smpsSetvoice        $00
	smpsCall            Snd_LBZ2_Call07
	smpsLoop            $00, $04, Snd_LBZ2_FM2

Snd_LBZ2_Jump04:
	dc.b	nRst, $60, nRst, nRst, nRst
	smpsCall            Snd_LBZ2_Call08
	smpsCall            Snd_LBZ2_Call09
	smpsCall            Snd_LBZ2_Call08
	smpsCall            Snd_LBZ2_Call08
	dc.b	nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	smpsCall            Snd_LBZ2_Call08
	smpsCall            Snd_LBZ2_Call09
	smpsCall            Snd_LBZ2_Call08
	smpsCall            Snd_LBZ2_Call08
	dc.b	nC2, nC1, nC3, nRst, $4E
	smpsJump            Snd_LBZ2_Jump04

Snd_LBZ2_Call07:
	dc.b	nG1, $12, nD2, nA2, $1E, nD2, $06, nG2, $0C, nD2
	smpsReturn

Snd_LBZ2_Call08:
	dc.b	nC2, $06, nRst, nC2, $0C, nBb1, $12, nA1, $06, nRst, $2A, nA1
	dc.b	$06, nF1, nRst, nF1, $0C, nFs1, $12, nG1, $06, nRst, $18, nD2
	dc.b	$0C, nG2, $06, nD2
	smpsReturn

Snd_LBZ2_Call09:
	dc.b	nC2, nRst, nC2, $0C, nBb1, $12, nA1, $06, nRst, $2A, nA1, $06
	dc.b	nF1, nRst, nF1, $0C, nFs1, $12, nG1, $06, nRst, $18, nD2
	smpsReturn

; FM3 Data
Snd_LBZ2_FM3:
	smpsSetvoice        $03
	dc.b	nRst, $60, nRst, nRst, nRst

Snd_LBZ2_Jump03:
	dc.b	nRst, $60, nRst, nRst, nRst
	smpsSetvoice        $03
	smpsCall            Snd_LBZ2_Call05
	smpsCall            Snd_LBZ2_Call06
	smpsFMAlterVol      $06
	smpsModSet          $01, $01, $01, $06
	smpsSetvoice        $01
	dc.b	nF4, $48, nE4, $18, nD4, $5A, nRst, $06, nF4, $48, nG4, $18
	dc.b	nD4, $5A, nRst, $06
	smpsFMAlterVol      $FA
	dc.b	nRst, $60, nRst, nRst, nRst

Snd_LBZ2_Loop05:
	smpsSetvoice        $03
	smpsCall            Snd_LBZ2_Call06
	smpsLoop            $00, $02, Snd_LBZ2_Loop05
	smpsSetvoice        $03
	dc.b	nRst, $0C, nC4, $0C, nRst, $48
	smpsJump            Snd_LBZ2_Jump03

Snd_LBZ2_Call05:
	dc.b	nRst, $60, nRst, nRst, $60, nRst, $48
	smpsFMAlterVol      $03
	smpsModSet          $06, $01, $12, $01
	dc.b	nC5, $0C
	smpsModSet          $01, $01, $01, $04
	dc.b	nC5, $0C
	smpsFMAlterVol      $FD
	smpsReturn

Snd_LBZ2_Call06:
	dc.b	nRst, $60, nRst, $48
	smpsModSet          $01, $01, $03, $05
	dc.b	nC5, $18
	smpsModSet          $01, $01, $01, $04
	dc.b	nRst, $60, nRst, $48
	smpsFMAlterVol      $03
	smpsModSet          $06, $01, $12, $01
	dc.b	nC5, $0C
	smpsModSet          $01, $01, $01, $04
	dc.b	nC5, $0C
	smpsFMAlterVol      $FD
	smpsReturn

; FM4 Data
Snd_LBZ2_FM4:
	smpsSetvoice        $03
	dc.b	nRst, $60, nRst, nRst, nRst

Snd_LBZ2_Jump02:
	dc.b	nRst, $60, nRst, nRst, nRst
	smpsSetvoice        $03
	smpsCall            Snd_LBZ2_Call03
	smpsCall            Snd_LBZ2_Call04
	smpsFMAlterVol      $09
	smpsModSet          $01, $01, $01, $06
	smpsSetvoice        $01
	dc.b	nRst, $05, nF4, $48, nE4, $18, nD4, $5A, nRst, $06, nF4, $48
	dc.b	nG4, $18, nD4, $55, nRst, $06
	smpsFMAlterVol      $F7
	smpsSetvoice        $03
	dc.b	nRst, $60, nRst, nRst, nRst

Snd_LBZ2_Loop04:
	smpsCall            Snd_LBZ2_Call04
	smpsLoop            $00, $02, Snd_LBZ2_Loop04
	smpsSetvoice        $03
	dc.b	nRst, $0C, nC4, $0C, nRst, $48
	smpsJump            Snd_LBZ2_Jump02

Snd_LBZ2_Call03:
	dc.b	nRst, $60, nRst, nRst, $60, nRst, $48
	smpsModSet          $06, $01, $12, $01
	dc.b	nBb4, $0C
	smpsModSet          $01, $01, $01, $04
	dc.b	nBb4, $0C
	smpsReturn

Snd_LBZ2_Call04:
	dc.b	nRst, $60, nRst, $48
	smpsModSet          $01, $01, $03, $05
	dc.b	nBb4, $18
	smpsModSet          $01, $01, $01, $04
	dc.b	nRst, $60, nRst, $48
	smpsModSet          $06, $01, $12, $01
	dc.b	nBb4, $0C
	smpsModSet          $01, $01, $01, $04
	dc.b	nBb4, $0C
	smpsReturn

; FM5 Data
Snd_LBZ2_FM5:
	smpsSetvoice        $02
	dc.b	nRst, $60, nRst, nRst, nRst

Snd_LBZ2_Jump01:
	dc.b	nRst, $60, nRst, nRst, nRst
	smpsCall            Snd_LBZ2_Call01
	smpsCall            Snd_LBZ2_Call02
	dc.b	nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst, nRst

Snd_LBZ2_Loop03:
	smpsCall            Snd_LBZ2_Call02
	smpsLoop            $00, $02, Snd_LBZ2_Loop03
	dc.b	nRst, $0C, nC4, nRst, $48
	smpsJump            Snd_LBZ2_Jump01

Snd_LBZ2_Call01:
	dc.b	nRst, $60, nRst, nRst, nRst, $48
	smpsSetvoice        $03
	smpsModSet          $06, $01, $12, $01
	dc.b	nG4, $0C
	smpsModSet          $01, $01, $01, $04
	dc.b	nG4, $0C
	smpsReturn

Snd_LBZ2_Call02:
	smpsSetvoice        $02
	dc.b	nRst, $06, nBb3, $04, nRst, $0E, nBb3, $12, nBb3, $06, nRst, $18
	dc.b	nRst, $30, nBb3, $12, nBb3, $06, nRst, $18
	smpsSetvoice        $03
	smpsModSet          $01, $01, $03, $05
	dc.b	nG4
	smpsModSet          $01, $01, $01, $04
	smpsSetvoice        $02
	dc.b	nRst, $06, nBb3, $04, nRst, $0E, nBb3, $12, nBb3, $06, nRst, $18
	dc.b	nRst, $30, nBb3, $12, nBb3, $06, nRst, $18
	smpsSetvoice        $03
	smpsFMAlterVol      $05
	smpsModSet          $06, $01, $12, $01
	dc.b	nG4, $0C
	smpsModSet          $01, $01, $01, $04
	smpsFMAlterVol      $FB
	dc.b	nG4, $0C
	smpsReturn

; PSG1 Data
Snd_LBZ2_PSG1:
	smpsNoteFill        $05
	smpsPSGvoice        sTone_11
	dc.b	nRst, $60, nRst, nRst
	smpsCall            Snd_LBZ2_Call0D

Snd_LBZ2_Jump06:
	smpsCall            Snd_LBZ2_Call0D
	dc.b	nF5, $06, nRst, nG5, nRst, nD5, nRst, nF5, nF5, nRst, nF5, nG5
	dc.b	nRst, $1E, nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst

Snd_LBZ2_Loop0B:
	dc.b	nRst, $60, nRst
	smpsLoop            $00, $04, Snd_LBZ2_Loop0B
	dc.b	nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	smpsJump            Snd_LBZ2_Jump06

Snd_LBZ2_Call0D:
	dc.b	nF5, $06, nRst, nG5, nRst, nD5, nRst, nF5, nF5, nRst, nF5, nG5
	dc.b	nRst, nD5, nRst, nF5, nRst, nRst, $60
	smpsReturn

; PSG2 Data
Snd_LBZ2_PSG2:
	dc.b	nRst, $01
	smpsModChange       $01
	smpsJump            Snd_LBZ2_PSG1

; PSG3 Data
Snd_LBZ_PSG3:
	smpsPSGform         $E7

Snd_LBZ2_Loop07:
	smpsCall            Snd_LBZ2_Call0C
	smpsLoop            $00, $10, Snd_LBZ2_Loop07

Snd_LBZ2_Loop08:
	smpsCall            Snd_LBZ2_Call0C
	smpsLoop            $00, $0C, Snd_LBZ2_Loop08
	smpsPSGvoice        sTone_13
	dc.b	nRst, $60

Snd_LBZ2_Loop09:
	smpsCall            Snd_LBZ2_Call0C
	smpsLoop            $00, $1C, Snd_LBZ2_Loop09
	smpsPSGvoice        sTone_13
	dc.b	nRst, $60

Snd_LBZ2_Loop0A:
	smpsCall            Snd_LBZ2_Call0C
	smpsLoop            $00, $40, Snd_LBZ2_Loop0A
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG1, $06, nMaxPSG1
	smpsPSGvoice        sTone_13
	dc.b	nRst, $54
	smpsJump            Snd_LBZ2_Loop08

Snd_LBZ2_Call0C:
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG1, $06, nMaxPSG1
	smpsPSGvoice        sTone_13
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG1, $06
	smpsReturn

; DAC Data
Snd_LBZ2_DAC:
	dc.b	dModLooseKick, $12, nRst, dModLooseKick, $3C

Snd_LBZ2_Loop00:
	dc.b	dModLooseKick, $06, dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum, nRst, dModLooseKick, dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum
	dc.b	dPowerTom, dPowerTom, $18
	smpsLoop            $00, $02, Snd_LBZ2_Loop00
	dc.b	dModLooseKick, $0C, dHiWoodBlock, $06, dModLooseKick, dLowWoodBlock, dLowWoodBlock, dModLooseKick, dHiWoodBlock, nRst, dHiWoodBlock, dLowWoodBlock
	dc.b	dLowWoodBlock, dLowWoodBlock, dLowWoodBlock, dLowWoodBlock, dLowWoodBlock

Snd_LBZ2_Jump00:
	smpsCall            Snd_LBZ2_Call00
	dc.b	dModLooseKick, $06, dHiHitDrum, nRst, dModLooseKick, dSnareGo, nRst, dModLooseKick, dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum
	dc.b	dSnareGo, dSnareGo, nRst, dLowWoodBlock, dLowWoodBlock
	smpsCall            Snd_LBZ2_Call00
	dc.b	dModLooseKick, $06, nRst, dHiWoodBlock, nRst, dLowWoodBlock, dLowWoodBlock, dLowWoodBlock, dHiWoodBlock, nRst, nRst, $2A
	dc.b	dModLooseKick, $12, dModLooseKick, $06, nRst, $12, dModLooseKick, $1E, dMetalCrashHit, $24, dScratchS3, $24
	dc.b	dPowerTom, $18, dScratchS3

Snd_LBZ2_Loop01:
	dc.b	dModLooseKick, $0C, dModLooseKick, nRst, $12, dModLooseKick, $06, nRst, $2A, dModLooseKick, $06, dModLooseKick
	dc.b	$0C, dModLooseKick, nRst, $12, dModLooseKick, $06, nRst, $30
	smpsLoop            $00, $02, Snd_LBZ2_Loop01
	dc.b	dModLooseKick, $0C, dModLooseKick, nRst, $12, dModLooseKick, $06, nRst, $2A, dModLooseKick, $06, nRst
	dc.b	$36, dQuietGlassCrash, $12, dMetalCrashHit, $0B, dMetalCrashHit, $0D

Snd_LBZ2_Loop02:
	dc.b	dModLooseKick, $06, nRst, dHiHitDrum, dModLooseKick, dLowHitDrum, dLowHitDrum, dModLooseKick, dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum
	dc.b	dPowerTom, dPowerTom, nRst, dLowHitDrum, nRst, dModLooseKick, $0C, dHiWoodBlock, $06, dModLooseKick, dLowWoodBlock, dLowWoodBlock
	dc.b	dModLooseKick, dHiWoodBlock, nRst, dHiWoodBlock, dLowWoodBlock, dLowWoodBlock, dLowWoodBlock, dLowWoodBlock, dLowWoodBlock, dLowWoodBlock
	smpsLoop            $00, $02, Snd_LBZ2_Loop02
	dc.b	dModLooseKick, $06, dHiHitDrum, nRst, dModLooseKick, dSnareGo, nRst, dModLooseKick, dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum
	dc.b	dPowerTom, dSnareGo, nRst, dLowWoodBlock, dLowWoodBlock, dModLooseKick, nRst, dHiWoodBlock, dModLooseKick, dSnareGo, nRst, dModLooseKick
	dc.b	dHiWoodBlock, nRst, dHiWoodBlock, dLowWoodBlock, dSnareGo, dSnareGo, nRst, dLowWoodBlock, dLowWoodBlock, dModLooseKick, $06, dHiHitDrum
	dc.b	nRst, dModLooseKick, dSnareGo, nRst, dModLooseKick, dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum, dPowerTom, dSnareGo, nRst
	dc.b	dLowWoodBlock, dLowWoodBlock, dModLooseKick, nRst, dHiWoodBlock, dModLooseKick, dSnareGo, nRst, dModLooseKick, dHiWoodBlock, nRst, dSnareGo
	dc.b	nRst, dSnareGo, dSnareGo, nRst, dSnareGo, nRst, nRst, $60, nRst, dModLooseKick, $0C, dModLooseKick
	dc.b	nRst, $48, nRst, $60, dModLooseKick, $06, nRst, dGo, nRst, dModLooseKick, nRst, dGo
	dc.b	dModLooseKick, nRst, nRst, dGo, nRst, nRst, nRst, dGo, dModLooseKick, dModLooseKick, $06, nRst
	dc.b	dGo, nRst, dModLooseKick, nRst, dGo, dModLooseKick, nRst, nRst, dGo, nRst, nRst, nRst
	dc.b	dGo, dModLooseKick, dModLooseKick, nRst, dGo, nRst, dSnareGo, nRst, dGo, dModLooseKick, nRst, nRst
	dc.b	dGo, nRst, dSnareGo, nRst, dGo, dModLooseKick, dModLooseKick, nRst, dGo, nRst, dSnareGo, nRst
	dc.b	dGo, dModLooseKick, dModLooseKick, dSnareGo, dGo, dSnareGo, dSnareGo, nRst, dSnareGo, nRst, dModLooseKick, dModLooseKick
	dc.b	dSnareGo, nRst, $4E
	smpsJump            Snd_LBZ2_Jump00

Snd_LBZ2_Call00:
	dc.b	dModLooseKick, $06, dHiHitDrum, nRst, dHiHitDrum, dSnareGo, nRst, dModLooseKick, dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum
	dc.b	dPowerTom, dSnareGo, nRst, dLowWoodBlock, dLowWoodBlock
	smpsReturn

; Unreachable
	dc.b	dModLooseKick, $0C, dSnareGo, $12, dModLooseKick, $06, dPowerTom, $12, dSnareGo, $06, dSnareGo, $18
	smpsReturn
	dc.b	nRst, nRst, dSnareGo, nRst, nRst, nRst, dSnareGo, nRst, nRst, nRst, dSnareGo, nRst
	dc.b	nRst, nRst, dSnareGo, nRst, dModLooseKick, $06, nRst, dSnareGo, nRst, dModLooseKick, nRst, dSnareGo
	dc.b	dModLooseKick, nRst, nRst, dSnareGo, nRst, nRst, nRst, dSnareGo, dModLooseKick

Snd_LBZ_Voices:
;	Voice $00
;	$03
;	$62, $40, $44, $31, 	$1F, $1F, $1F, $1C, 	$0B, $0A, $02, $01
;	$08, $0B, $04, $06, 	$1F, $1F, $1F, $1F, 	$2A, $1A, $2B, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $04, $04, $06
	smpsVcCoarseFreq    $01, $04, $00, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1C, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $02, $0A, $0B
	smpsVcDecayRate2    $06, $04, $0B, $08
	smpsVcDecayLevel    $01, $01, $01, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $80, $2B, $1A, $2A

;	Voice $01
;	$3D
;	$01, $02, $02, $02, 	$1F, $08, $8A, $0A, 	$08, $08, $08, $08
;	$00, $01, $00, $00, 	$0F, $1F, $1F, $1F, 	$1F, $88, $88, $87
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $02, $02, $02, $01
	smpsVcRateScale     $00, $02, $00, $00
	smpsVcAttackRate    $0A, $0A, $08, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $08, $08, $08
	smpsVcDecayRate2    $00, $00, $01, $00
	smpsVcDecayLevel    $01, $01, $01, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $87, $88, $88, $1F

;	Voice $02
;	$3A
;	$31, $7F, $61, $0A, 	$9C, $DB, $9C, $9A, 	$04, $08, $03, $09
;	$03, $01, $00, $00, 	$1F, $0F, $FF, $FF, 	$23, $25, $1B, $84
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $06, $07, $03
	smpsVcCoarseFreq    $0A, $01, $0F, $01
	smpsVcRateScale     $02, $02, $03, $02
	smpsVcAttackRate    $1A, $1C, $1B, $1C
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $09, $03, $08, $04
	smpsVcDecayRate2    $00, $00, $01, $03
	smpsVcDecayLevel    $0F, $0F, $00, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $84, $1B, $25, $23

;	Voice $03
;	$3A
;	$01, $07, $31, $11, 	$8E, $8E, $8D, $53, 	$0E, $0E, $0E, $03
;	$00, $00, $00, $07, 	$1F, $FF, $1F, $0F, 	$18, $28, $17, $82
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $03, $00, $00
	smpsVcCoarseFreq    $01, $01, $07, $01
	smpsVcRateScale     $01, $02, $02, $02
	smpsVcAttackRate    $13, $0D, $0E, $0E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $0E, $0E, $0E
	smpsVcDecayRate2    $07, $00, $00, $00
	smpsVcDecayLevel    $00, $01, $0F, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $82, $17, $28, $18

; Unused voice
;	Voice $04
;	$F5
;	$24, $30, $10, $32, 	$1F, $1F, $1F, $1F, 	$05, $18, $09, $02
;	$06, $0F, $06, $02, 	$1F, $2F, $4F, $2F, 	$0F, $0E, $0E, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $06
	smpsVcUnusedBits    $03
	smpsVcDetune        $03, $01, $03, $02
	smpsVcCoarseFreq    $02, $00, $00, $04
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $09, $18, $05
	smpsVcDecayRate2    $02, $06, $0F, $06
	smpsVcDecayLevel    $02, $04, $02, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $80, $0E, $0E, $0F

