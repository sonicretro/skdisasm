Snd_LBZ1_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_LBZ_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $2F

	smpsHeaderDAC       Snd_LBZ1_DAC
	smpsHeaderFM        Snd_LBZ1_FM1,	$00, $0C
	smpsHeaderFM        Snd_LBZ1_FM2,	$0C, $08
	smpsHeaderFM        Snd_LBZ1_FM3,	$00, $0C
	smpsHeaderFM        Snd_LBZ1_FM4,	$00, $0C
	smpsHeaderFM        Snd_LBZ1_FM5,	$0C, $0C
	smpsHeaderPSG       Snd_LBZ1_PSG1,	$F4, $02, $00, $00
	smpsHeaderPSG       Snd_LBZ1_PSG2,	$F4, $04, $00, $00
	smpsHeaderPSG       Snd_LBZ_PSG3,	$00, $02, $00, $00

; FM1 Data
Snd_LBZ1_FM1:
	smpsSetvoice        $02
	dc.b	nRst, $60, nRst, nRst, nRst

Snd_LBZ1_Jump04:
	dc.b	nRst, $60, nRst, nRst, nRst

Snd_LBZ1_Loop0C:
	smpsCall            Snd_LBZ1_Call09
	smpsLoop            $00, $02, Snd_LBZ1_Loop0C
	dc.b	nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst, nRst

Snd_LBZ1_Loop0D:
	smpsCall            Snd_LBZ1_Call09
	smpsLoop            $00, $02, Snd_LBZ1_Loop0D
	dc.b	nRst, $0C, nC5, nRst, $48
	smpsJump            Snd_LBZ1_Jump04

Snd_LBZ1_Call09:
	smpsSetvoice        $02
	dc.b	nRst, $06, nEb4, $04, nRst, $0E, nEb4, $12, nEb4, $06, nRst, $18
	dc.b	nC4, $06, nBb3, nG3, nF3, nRst, $18, nEb4, $12, nEb4, $06, nRst
	dc.b	$18
	smpsSetvoice        $03
	smpsModSet          $01, $01, $03, $05
	dc.b	nEb5
	smpsModSet          $01, $01, $01, $04
	smpsSetvoice        $02
	dc.b	nRst, $06, nEb4, $04, nRst, $0E, nEb4, $12, nEb4, $06, nRst, $18
	dc.b	nC4, $06, nBb3, nG3, nF3
	smpsModSet          $01, $01, $01, $04
	dc.b	nRst, $18, nEb4, $12, nEb4, $06, nRst, $18
	smpsSetvoice        $03
	smpsFMAlterVol      $05
	smpsModSet          $06, $01, $12, $01
	dc.b	nEb5, $0C
	smpsModSet          $01, $01, $01, $04
	smpsFMAlterVol      $FB
	dc.b	nEb5, $0C
	smpsReturn

; FM2 Data
Snd_LBZ1_FM2:
	smpsSetvoice        $00
	smpsCall            Snd_LBZ1_Call06
	smpsLoop            $00, $04, Snd_LBZ1_FM2

Snd_LBZ1_Loop0A:
	smpsCall            Snd_LBZ1_Call06
	smpsLoop            $00, $03, Snd_LBZ1_Loop0A
	dc.b	nRst, $42, nD2, $06, nG2, $0C, nD2
	smpsCall            Snd_LBZ1_Call07
	smpsCall            Snd_LBZ1_Call08
	smpsCall            Snd_LBZ1_Call07
	smpsCall            Snd_LBZ1_Call07

Snd_LBZ1_Loop0B:
	smpsCall            Snd_LBZ1_Call06
	smpsLoop            $00, $08, Snd_LBZ1_Loop0B
	smpsCall            Snd_LBZ1_Call07
	smpsCall            Snd_LBZ1_Call08
	smpsCall            Snd_LBZ1_Call07
	smpsCall            Snd_LBZ1_Call07
	dc.b	nC2, nC1, nC3, nRst, $4E
	smpsJump            Snd_LBZ1_Loop0A

Snd_LBZ1_Call06:
	dc.b	nG1, $12, nD2, nA2, $1E, nD2, $06, nG2, $0C, nD2
	smpsReturn

Snd_LBZ1_Call07:
	dc.b	nC2, $06, nRst, nC2, $0C, nBb1, $12, nA1, $06, nRst, $2A, nA1
	dc.b	$06, nF1, nRst, nF1, $0C, nFs1, $12, nG1, $06, nRst, $18, nD2
	dc.b	$0C, nG2, $06, nD2
	smpsReturn

Snd_LBZ1_Call08:
	dc.b	nC2, nRst, nC2, $0C, nBb1, $12, nA1, $06, nRst, $2A, nA1, $06
	dc.b	nF1, nRst, nF1, $0C, nFs1, $12, nG1, $06, nRst, $18, nD2
	smpsReturn

; FM3 Data
Snd_LBZ1_FM3:
	smpsSetvoice        $03
	dc.b	nRst, $60, nRst, nRst, nRst

Snd_LBZ1_Jump03:
	dc.b	nRst, $60, nRst, nRst, nRst

Snd_LBZ1_Loop08:
	smpsCall            Snd_LBZ1_Call05
	smpsLoop            $00, $02, Snd_LBZ1_Loop08
	smpsFMAlterVol      $06

Snd_LBZ1_Loop09:
	smpsModSet          $01, $01, $01, $06
	smpsSetvoice        $01
	dc.b	nF4, $48, nE4, $18, nD4, $5A, nRst, $06, nF4, $48, nG4, $18
	dc.b	nD4, $5A, nRst, $06
	smpsLoop            $00, $02, Snd_LBZ1_Loop09
	dc.b	nBb4, $60, smpsNoAttack, $30, nC5, $30, nG4, $60, smpsNoAttack, $5A, nRst, $06
	dc.b	nBb4, $60, nBb4, $30, nF4, nC4, $60, smpsNoAttack, $5A, nRst, $06
	smpsFMAlterVol      $FA
	smpsSetvoice        $03
	dc.b	nRst, $0C, nC4, $0C, nRst, $48
	smpsJump            Snd_LBZ1_Jump03

Snd_LBZ1_Call05:
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
Snd_LBZ1_FM4:
	smpsSetvoice        $03
	dc.b	nRst, $60, nRst, nRst, nRst

Snd_LBZ1_Jump02:
	dc.b	nRst, $60, nRst, nRst, nRst

Snd_LBZ1_Loop06:
	smpsCall            Snd_LBZ1_Call04
	smpsLoop            $00, $02, Snd_LBZ1_Loop06
	smpsFMAlterVol      $09

Snd_LBZ1_Loop07:
	smpsModSet          $01, $01, $01, $06
	smpsSetvoice        $01
	dc.b	nRst, $05, nF4, $48, nE4, $18, nD4, $5A, nRst, $06, nF4, $48
	dc.b	nG4, $18, nD4, $55, nRst, $06
	smpsLoop            $00, $02, Snd_LBZ1_Loop07
	dc.b	nRst, $05, nBb4, $60, smpsNoAttack, $30, nC5, $30, nG4, $60, smpsNoAttack, $5A
	dc.b	nRst, $06, nBb4, $60, nBb4, $30, nF4, nC4, $60, smpsNoAttack, $55, nRst
	dc.b	$06
	smpsFMAlterVol      $F7
	smpsSetvoice        $03
	dc.b	nRst, $0C, nC4, $0C, nRst, $48
	smpsJump            Snd_LBZ1_Jump02

Snd_LBZ1_Call04:
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
Snd_LBZ1_FM5:
	smpsSetvoice        $02
	dc.b	nRst, $60, nRst, nRst, nRst

Snd_LBZ1_Jump01:
	dc.b	nRst, $60, nRst, nRst, nRst

Snd_LBZ1_Loop04:
	smpsCall            Snd_LBZ1_Call03
	smpsLoop            $00, $02, Snd_LBZ1_Loop04
	dc.b	nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst, nRst

Snd_LBZ1_Loop05:
	smpsCall            Snd_LBZ1_Call03
	smpsLoop            $00, $02, Snd_LBZ1_Loop05
	dc.b	nRst, $0C, nC4, nRst, $48
	smpsJump            Snd_LBZ1_Jump01

Snd_LBZ1_Call03:
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
Snd_LBZ1_PSG1:
	smpsNoteFill        $05
	smpsPSGvoice        sTone_11
	dc.b	nRst, $60, nRst, nRst
	smpsCall            Snd_LBZ1_Call0A

Snd_LBZ1_Jump05:
	smpsCall            Snd_LBZ1_Call0A
	dc.b	nF5, $06, nRst, nG5, nRst, nD5, nRst, nF5, nF5, nRst, nF5, nG5
	dc.b	nRst, $1E, nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst

Snd_LBZ1_Loop0E:
	smpsCall            Snd_LBZ1_Call0A
	smpsLoop            $00, $04, Snd_LBZ1_Loop0E
	dc.b	nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	smpsJump            Snd_LBZ1_Jump05

Snd_LBZ1_Call0A:
	dc.b	nF5, $06, nRst, nG5, nRst, nD5, nRst, nF5, nF5, nRst, nF5, nG5
	dc.b	nRst, nD5, nRst, nF5, nRst, $66
	smpsReturn

; PSG2 Data
Snd_LBZ1_PSG2:
	dc.b	nRst, $01
	smpsModChange       $01
	smpsJump            Snd_LBZ1_PSG1

; DAC Data
Snd_LBZ1_DAC:
	dc.b	dModLooseKick, $12, nRst, dModLooseKick, $3C

Snd_LBZ1_Loop00:
	dc.b	dModLooseKick, $06, dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum, nRst, dModLooseKick, dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum
	dc.b	dPowerTom, dPowerTom, $18
	smpsLoop            $00, $02, Snd_LBZ1_Loop00
	dc.b	dModLooseKick, $0C, dHiWoodBlock, $06, dModLooseKick, dLowWoodBlock, dLowWoodBlock, dModLooseKick, dHiWoodBlock, nRst, dHiWoodBlock, dLowWoodBlock
	dc.b	dLowWoodBlock, dLowWoodBlock, dLowWoodBlock, dLowWoodBlock, dLowWoodBlock

Snd_LBZ1_Jump00:
	smpsCall            Snd_LBZ1_Call00
	dc.b	dModLooseKick, $06, dHiHitDrum, nRst, dModLooseKick, dSnareGo, nRst, dModLooseKick, dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum
	dc.b	dSnareGo, dSnareGo, nRst, dLowWoodBlock, dLowWoodBlock
	smpsCall            Snd_LBZ1_Call00
	dc.b	dModLooseKick, $06, nRst, dHiWoodBlock, nRst, dLowWoodBlock, dLowWoodBlock, dLowWoodBlock, dHiWoodBlock, nRst, nRst, $2A
	dc.b	dModLooseKick, $0C, dModLooseKick, dSnareGo, $12, dModLooseKick, $1E, dMetalCrashHit, $18
	smpsCall            Snd_LBZ1_Call01

Snd_LBZ1_Loop01:
	dc.b	dModLooseKick, $0C, dModLooseKick, dSnareGo, $12, dModLooseKick, $1E, dSnareGo, $24
	smpsCall            Snd_LBZ1_Call02
	smpsLoop            $00, $02, Snd_LBZ1_Loop01
	dc.b	dModLooseKick, $0C, dModLooseKick, dSnareGo, $12, dModLooseKick, $1E, dSnareGo, $18, nRst, $36, dQuietGlassCrash
	dc.b	$12, dMetalCrashHit, $0B, dMetalCrashHit, $0D

Snd_LBZ1_Loop02:
	dc.b	dModLooseKick, $06, dHiHitDrum, nRst, dModLooseKick, dSnareGo, nRst, dModLooseKick, dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum
	dc.b	dPowerTom, dSnareGo, nRst, dLowWoodBlock, dLowWoodBlock, dModLooseKick, nRst, dHiWoodBlock, dModLooseKick, dSnareGo, nRst, dModLooseKick
	dc.b	dHiWoodBlock, nRst, dHiWoodBlock, dLowWoodBlock, dSnareGo, dSnareGo, nRst, dLowWoodBlock, dLowWoodBlock
	smpsLoop            $00, $03, Snd_LBZ1_Loop02
	dc.b	dModLooseKick, $06, dHiHitDrum, nRst, dModLooseKick, dSnareGo, nRst, dModLooseKick, dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum
	dc.b	dPowerTom, dSnareGo, nRst, dLowWoodBlock, dLowWoodBlock, dModLooseKick, nRst, dHiWoodBlock, dModLooseKick, dSnareGo, nRst, dModLooseKick
	dc.b	dHiWoodBlock, nRst, dSnareGo, nRst, dSnareGo, dSnareGo, nRst, dSnareGo, nRst, dModLooseKick, $06, nRst
	dc.b	dModLooseKick, nRst, dSnareGo, nRst, nRst, dModLooseKick, nRst, nRst, dGo, nRst, dSnareGo, nRst
	dc.b	dGo, nRst, dModLooseKick, nRst, dGo, nRst, dSnareGo, nRst, dGo, dModLooseKick, dModLooseKick, nRst
	dc.b	dGo, dSnareGo, dSnareGo, nRst, dGo, nRst

Snd_LBZ1_Loop03:
	dc.b	dModLooseKick, $06, nRst, dGo, nRst, dSnareGo, nRst, dGo, dModLooseKick, dModLooseKick, nRst, dGo
	dc.b	nRst, dSnareGo, nRst, dGo, dModLooseKick, dModLooseKick, nRst, dGo, nRst, dSnareGo, nRst, dGo
	dc.b	dModLooseKick, dModLooseKick, nRst, dGo, dSnareGo, dSnareGo, nRst, dGo, nRst
	smpsLoop            $00, $02, Snd_LBZ1_Loop03
	dc.b	dModLooseKick, $06, nRst, dGo, nRst, dSnareGo, nRst, dGo, dModLooseKick, dModLooseKick, nRst, dGo
	dc.b	nRst, dSnareGo, nRst, dGo, dModLooseKick, dModLooseKick, nRst, dGo, nRst, dSnareGo, nRst, dGo
	dc.b	dModLooseKick, dModLooseKick, dSnareGo, dGo, dSnareGo, dSnareGo, nRst, dSnareGo, nRst, dModLooseKick, dModLooseKick, dSnareGo
	dc.b	$54
	smpsJump            Snd_LBZ1_Jump00

Snd_LBZ1_Call00:
	dc.b	dModLooseKick, $06, dHiHitDrum, nRst, dHiHitDrum, dSnareGo, nRst, dModLooseKick, dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum
	dc.b	dPowerTom, dSnareGo, nRst, dLowWoodBlock, dLowWoodBlock
	smpsReturn

Snd_LBZ1_Call01:
	dc.b	dModLooseKick, $18, dSnareGo, $0C, dScratchS3, dPowerTom, $12, dSnareGo, $06, dSnareGo, $0C, dScratchS3
	smpsReturn

Snd_LBZ1_Call02:
	dc.b	dModLooseKick, $0C, dSnareGo, $12, dModLooseKick, $06, dPowerTom, $12, dSnareGo, $06, dSnareGo, $18
	smpsReturn
