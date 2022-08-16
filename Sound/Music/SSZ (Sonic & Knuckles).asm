Snd_SSZ_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_SSZ_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $04

	smpsHeaderDAC       Snd_SSZ_DAC
	smpsHeaderFM        Snd_SSZ_FM1,	$E8, $0D
	smpsHeaderFM        Snd_SSZ_FM2,	$00, $17
	smpsHeaderFM        Snd_SSZ_FM3,	$00, $17
	smpsHeaderFM        Snd_SSZ_FM4,	$00, $1C
	smpsHeaderFM        Snd_SSZ_FM5,	$00, $15
	smpsHeaderPSG       Snd_SSZ_PSG1,	$F4, $05, $00, $00
	smpsHeaderPSG       Snd_SSZ_PSG2,	$F4, $05, $00, $00
	smpsHeaderPSG       Snd_SSZ_PSG3,	$00, $02, $00, $00

; FM1 Data
Snd_SSZ_FM1:
	smpsSetvoice        $00
	smpsAlterNote       $FE

Snd_SSZ_Jump01:
	dc.b	nG2, $07, nRst, $04, nG2, $08, nRst, $04, $24, nG3, nG2, nG2
	dc.b	$0C, nRst, nC3, $14, nB2, $10, nG2, $08, nRst, $04, nG2, $08
	dc.b	nRst, $04, $24, nG3, nG2, nG2, $0C, nRst, $30

Snd_SSZ_Loop08:
	dc.b	nC3, $60, nC4, $24, nC3, nC4, $18, nBb2, $06, nRst, $06, nBb2
	dc.b	$54, nBb3, $24, nBb2, nBb3, $18, nA2, $06, nRst, $06, nA2, $48
	dc.b	nG3, $06, nAb3, nA3, $24, nA2, nA3, $18, nAb2, $06, nRst, $06
	dc.b	nAb2, $54, nAb3, $24, nAb2, nBb3, $18
	smpsLoop            $00, $02, Snd_SSZ_Loop08
	dc.b	nG2, $48, nG3, $0C, nG3, $48, nG2, $24, nAb2, $48, nAb3, $0C
	dc.b	nAb3, $48, nAb2, $0C, nAb3, $18, nG2, $48, nG3, $0C, nG3, $48
	dc.b	nG2, $24, nAb2, $3C, nAb3, $24, nBb2, $3C, nBb3, $24, nC3, $60
	dc.b	nC4, $24, nC3, nC4, $18, nBb2, $06, nRst, $06, nBb2, $54, nBb3
	dc.b	$24, nBb2, nBb3, $18, nA2, $06, nRst, $06, nA2, $48, nG3, $06
	dc.b	nAb3, nA3, $24, nA2, nA3, $18, nAb2, $06, nRst, $06, nAb2, $54
	dc.b	nBb3, $24, nBb2, nBb3, $18, nRst, $01
	smpsJump            Snd_SSZ_Jump01

; Unreachable
	smpsStop

; FM2 Data
Snd_SSZ_FM2:
	dc.b	nRst, $60, nRst, nRst, nRst

Snd_SSZ_Loop07:
	smpsSetvoice        $03
	dc.b	nC4, $60, smpsNoAttack, $60, nBb3, smpsNoAttack, $60, nA3, smpsNoAttack, $60, nAb3, smpsNoAttack
	dc.b	$60
	smpsLoop            $00, $02, Snd_SSZ_Loop07
	dc.b	nG3, smpsNoAttack, $60, nAb3, smpsNoAttack, $60, nG3, smpsNoAttack, $60, nAb3, nBb3, nC4
	dc.b	smpsNoAttack, $60, nBb3, smpsNoAttack, $60, nA3, smpsNoAttack, $60, nAb3, nBb3
	smpsJump            Snd_SSZ_FM2

; Unreachable
	smpsStop

; FM3 Data
Snd_SSZ_FM3:
	smpsSetvoice        $01
	dc.b	nRst, $60, nRst, nF5, $12, nE5, nC5, $0C, nC6, $12, nB5, nG5
	dc.b	$0C, nF5, $12, nE5
	smpsFMAlterVol      $FF
	dc.b	nC5, $0C, nRst
	smpsFMAlterVol      $01
	dc.b	nB4, nRst, $18
	smpsSetvoice        $02

Snd_SSZ_Loop03:
	smpsCall            Snd_SSZ_Call00
	smpsLoop            $01, $02, Snd_SSZ_Loop03

Snd_SSZ_Loop04:
	dc.b	nC3, $06, nG1, nC3, nG1, nD3, nG1, nE3, nG1, nF3, nG1, nE3
	dc.b	nG1, nD3, nG1, nE3, nG1
	smpsLoop            $00, $02, Snd_SSZ_Loop04

Snd_SSZ_Loop05:
	dc.b	nC3, $06, nAb1, nC3, nAb1, nD3, nAb1, nE3, nAb1, nF3, nAb1, nE3
	dc.b	nAb1, nD3, nAb1, nE3, nAb1
	smpsLoop            $00, $02, Snd_SSZ_Loop05

Snd_SSZ_Loop06:
	dc.b	nC3, $06, nG1, nC3, nG1, nD3, nG1, nE3, nG1, nF3, nG1, nE3
	dc.b	nG1, nD3, nG1, nE3, nG1
	smpsLoop            $00, $02, Snd_SSZ_Loop06
	dc.b	nC3, $06, nAb1, nC3, nAb1, nD3, nAb1, nE3, nAb1, nF3, nAb1, nE3
	dc.b	nAb1, nD3, nAb1, nE3, nAb1, nC3, $06, nBb1, nC3, nBb1, nD3, nBb1
	dc.b	nE3, nBb1, nF3, nBb1, nE3, nBb1, nD3, nBb1, nE3, nBb1
	smpsCall            Snd_SSZ_Call00
	smpsJump            Snd_SSZ_FM3

; Unreachable
	smpsStop

Snd_SSZ_Call00:
	smpsSetvoice        $02
	dc.b	nC3, $06, nC2, nC3, nC2, nD3, nC2, nE3, nC2, nF3, nC2, nE3
	dc.b	nC2, nD3, nC2, nE3, nC2
	smpsLoop            $00, $02, Snd_SSZ_Call00

Snd_SSZ_Loop0C:
	smpsSetvoice        $02
	dc.b	nC3, $06, nBb1, nC3, nBb1, nD3, nBb1, nE3, nBb1, nF3, nBb1, nE3
	dc.b	nBb1, nD3, nBb1, nE3, nBb1
	smpsLoop            $00, $02, Snd_SSZ_Loop0C

Snd_SSZ_Loop0D:
	smpsSetvoice        $02
	dc.b	nC3, $06, nA1, nC3, nA1, nD3, nA1, nE3, nA1, nF3, nA1, nE3
	dc.b	nA1, nD3, nA1, nE3, nA1
	smpsLoop            $00, $02, Snd_SSZ_Loop0D

Snd_SSZ_Loop0E:
	smpsSetvoice        $02
	dc.b	nC3, $06, nAb1, nC3, nAb1, nD3, nAb1, nE3, nAb1, nF3, nAb1, nE3
	dc.b	nAb1, nD3, nAb1, nE3, nAb1
	smpsLoop            $00, $02, Snd_SSZ_Loop0E
	smpsReturn

; FM5 Data
Snd_SSZ_FM5:
	smpsModSet          $24, $01, $04, $08
	smpsSetvoice        $01

Snd_SSZ_Jump00:
	dc.b	nC5, $12, nB4, nG4, $0C, nG5, $12, nF5, nE5, $0C
	smpsLoop            $00, $03, Snd_SSZ_Jump00
	dc.b	nC5, $12, nB4
	smpsFMAlterVol      $FF
	dc.b	nG4, $0C, nRst
	smpsFMAlterVol      $01
	dc.b	nG4, nRst, $18
	smpsFMAlterVol      $FD

Snd_SSZ_Loop01:
	dc.b	nC6, $07, nRst, $05, nC6, $48, nC5, $06, nE5, nF5, $24, nE5
	dc.b	$18, nC5, $24
	smpsLoop            $00, $02, Snd_SSZ_Loop01
	dc.b	nRst, $0C, nRst, nA4, nRst, nRst, nC5, nRst, nRst, nF4, nRst, nRst
	dc.b	nA4, $24, nA4, $18, nRst, $24, nAb4, $0C, nC5, nBb4, nAb4, nEb5
	dc.b	$18, nC5, $0C, nD5, nEb5, $18, nD5, $0C, nC5, $18

Snd_SSZ_Loop02:
	dc.b	nC6, $06, nRst, nC6, $48, nC5, $06, nE5, nF5, $24, nE5, $18
	dc.b	nC5, $24
	smpsLoop            $00, $02, Snd_SSZ_Loop02
	dc.b	nRst, $0C, nRst, nA4, nRst, nRst, nC5, nRst, nRst, nF4, nRst, nRst
	dc.b	nA4, $24, nA4, $18, nRst, $24, nAb4, $0C, nC5, nBb4, nAb4, nEb5
	dc.b	$18, nC5, $0C, nD5, nEb5, $18, nD5, $0C, nF5, $18
	smpsFMAlterVol      $FF
	dc.b	nG5, $24, nEb6, nD6, $07, nRst, $05, $18, nG5, $54, nAb5, $24
	dc.b	nEb6, nD6, $07, nRst, $05, $18, nF6, $24, nEb6, $18, nD6, nG5
	dc.b	$24, nEb6, nD6, $07, nRst, $05, $18, nG5, $54, nAb5, $24, nC6
	dc.b	nEb6, $18, nG6, nF6, $0C, nEb6, $18, nF6, $24, nC6, $54, nC5
	dc.b	$06, nE5, nF5, $24, nE5, $18, nC5, $24
	smpsFMAlterVol      $FF
	dc.b	nC6, $54, nC6, $06, nE6, nF6, $24, nE6, $18, nC6, $24
	smpsFMAlterVol      $FF
	dc.b	nG6, $0C, nC6, $07, nRst, $05, nRst, $24, nC6, $0C, nG6, nC6
	dc.b	$07, nRst, $05, nRst, $0C, nC6, nRst, nC6, nG6, nC6, nRst, nC6
	smpsFMAlterVol      $FF
	dc.b	nBb6, $24, nAb6, nG6, nF6, nEb6, $18, nF6
	smpsFMAlterVol      $07
	smpsJump            Snd_SSZ_Jump00

; Unreachable
	smpsStop

; FM4 Data
Snd_SSZ_FM4:
	smpsModSet          $24, $01, $04, $07
	smpsAlterNote       $02
	smpsSetvoice        $01
	dc.b	nRst, $0E
	smpsJump            Snd_SSZ_Jump00

; Unreachable
	smpsStop

; PSG1 Data
Snd_SSZ_PSG1:
	smpsPSGvoice        sTone_04

Snd_SSZ_Loop09:
	dc.b	nG4, $06, nF4, nC4, nF4
	smpsLoop            $00, $0E, Snd_SSZ_Loop09
	dc.b	nRst, $0C, nB3, nRst, $18

Snd_SSZ_Loop0A:
	smpsCall            Snd_SSZ_Call01
	smpsLoop            $00, $08, Snd_SSZ_Loop0A
	smpsAlterPitch      $07
	smpsCall            Snd_SSZ_Call01
	smpsAlterPitch      $01
	smpsCall            Snd_SSZ_Call01
	smpsAlterPitch      $FF
	smpsCall            Snd_SSZ_Call01
	smpsAlterPitch      $F9
	smpsCall            Snd_SSZ_Call01

Snd_SSZ_Loop0B:
	smpsCall            Snd_SSZ_Call01
	smpsLoop            $00, $04, Snd_SSZ_Loop0B
	smpsJump            Snd_SSZ_Loop09

; Unreachable
	smpsStop

Snd_SSZ_Call01:
	dc.b	nC5, $06, nC4, nC5, nC4, nC5, nC4, nC5, nC4, nC6, nC4, nC6
	dc.b	nC4, nC5, nC4, nC5, nC4
	smpsLoop            $01, $02, Snd_SSZ_Call01
	smpsReturn

; PSG2 Data
Snd_SSZ_PSG2:
	smpsStop

; PSG3 Data
Snd_SSZ_PSG3:
	smpsPSGform         $E7

Snd_SSZ_Jump02:
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsPSGvoice        sTone_04
	dc.b	nMaxPSG2, $0C
	smpsJump            Snd_SSZ_Jump02

; Unreachable
	smpsStop

; DAC Data
Snd_SSZ_DAC:
	smpsPan             panCenter, $00
	dc.b	nRst, $60, nRst, nRst, nRst, $17, nRst, $0C, dSnareS3, nRst, dSnareS3, nRst
	dc.b	dKickS3, $06, dKickS3

Snd_SSZ_Loop00:
	smpsPan             panCenter, $00
	dc.b	dKickS3, $05, dKickS3, dKickS3, $0E, nRst, $0C, dMuffledSnare, $05, dMuffledSnare, dMuffledSnare, $0E
	dc.b	dMuffledSnare, $0C, nRst, dKickS3, $06, dKickS3, dKickS3, $0C, dKickS3, nRst, dMuffledSnare, $05
	dc.b	dMuffledSnare, dMuffledSnare, $0E, dMuffledSnare, $0C, nRst, dKickS3, dKickS3, $0C, dKickS3, nRst, dMuffledSnare
	dc.b	$05, dMuffledSnare, dMuffledSnare, $0E, dMuffledSnare, $0C, nRst, dKickS3, $06, dKickS3, dKickS3, $0C
	dc.b	dKickS3, nRst, dMuffledSnare, $05, dMuffledSnare, dMuffledSnare, $08
	smpsPan             panLeft, $00
	dc.b	dElectricMidTom, $06, dElectricMidTom, dElectricMidTom
	smpsPan             panCenter, $00
	dc.b	dElectricLowTom, dElectricLowTom
	smpsPan             panRight, $00
	dc.b	dElectricFloorTom, nRst
	smpsLoop            $00, $08, Snd_SSZ_Loop00
	dc.b	nRst, $01
	smpsJump            Snd_SSZ_DAC

; Unreachable
	smpsStop

Snd_SSZ_Voices:
;	Voice $00
;	$34
;	$02, $02, $02, $02, 	$1F, $5F, $1F, $5F, 	$0E, $00, $12, $00
;	$00, $08, $02, $08, 	$4F, $0F, $4F, $0F, 	$12, $80, $12, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $02, $02, $02, $02
	smpsVcRateScale     $01, $00, $01, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $12, $00, $0E
	smpsVcDecayRate2    $08, $02, $08, $00
	smpsVcDecayLevel    $00, $04, $00, $04
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $12, $00, $12

;	Voice $01
;	$3D
;	$01, $01, $01, $11, 	$1C, $18, $18, $1B, 	$06, $05, $04, $05
;	$06, $05, $06, $06, 	$60, $89, $59, $79, 	$18, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1B, $18, $18, $1C
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $04, $05, $06
	smpsVcDecayRate2    $06, $06, $05, $06
	smpsVcDecayLevel    $07, $05, $08, $06
	smpsVcReleaseRate   $09, $09, $09, $00
	smpsVcTotalLevel    $00, $00, $00, $18

;	Voice $02
;	$3D
;	$02, $01, $01, $11, 	$1C, $18, $18, $1B, 	$06, $05, $04, $05
;	$06, $05, $06, $06, 	$6F, $8F, $5F, $7F, 	$18, $88, $88, $88
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $01, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1B, $18, $18, $1C
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $04, $05, $06
	smpsVcDecayRate2    $06, $06, $05, $06
	smpsVcDecayLevel    $07, $05, $08, $06
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $08, $08, $08, $18

;	Voice $03
;	$04
;	$02, $02, $03, $03, 	$13, $10, $13, $10, 	$06, $0C, $06, $0C
;	$00, $00, $00, $00, 	$4F, $2F, $4F, $2F, 	$18, $90, $18, $90
	smpsVcAlgorithm     $04
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $03, $03, $02, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $10, $13, $10, $13
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0C, $06, $0C, $06
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $02, $04, $02, $04
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $10, $18, $10, $18

