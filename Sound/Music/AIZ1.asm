Snd_AIZ1_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoiceUVB
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $1F

	smpsHeaderDAC       Snd_AIZ1_DAC
	smpsHeaderFM        Snd_AIZ1_FM1,	$18, $0F
	smpsHeaderFM        Snd_AIZ1_FM2,	$0C, $16
	smpsHeaderFM        Snd_AIZ1_FM3,	$0C, $16
	smpsHeaderFM        Snd_AIZ1_FM4,	$0C, $16
	smpsHeaderFM        Snd_AIZ1_FM5,	$0C, $16
	smpsHeaderPSG       Snd_AIZ1_PSG1,	$F4, $04, $00, sTone_0C
	smpsHeaderPSG       Snd_AIZ1_PSG2,	$F4, $04, $00, sTone_0C
	smpsHeaderPSG       Snd_AIZ1_PSG3,	$00, $04, $00, sTone_0C

; Unreachable
	smpsStop

; DAC Data
Snd_AIZ1_DAC:
	smpsCall            Snd_AIZ1_Call00
	smpsLoop            $00, $03, Snd_AIZ1_DAC
	dc.b	dKickS3, $0C, dHighMetalHit, $06, dLowTomS3, dKickS3, $0C, dMidTomS3, $06, dLowMetalHit, dKickS3, $0C
	dc.b	dHighMetalHit, $06, dLowTomS3, dKickS3, $0C, dSnareS3

Snd_AIZ1_Loop00:
	smpsCall            Snd_AIZ1_Call00
	smpsLoop            $00, $03, Snd_AIZ1_Loop00
	dc.b	dSnareS3, dSnareS3, dSnareS3, dSnareS3, dKickS3, dHighTom, dMidTomS3, dLowTomS3, dKickS3, dHigherMetalHit, $09, dHigherMetalHit
	dc.b	$02, dHigherMetalHit, $01, dHigherMetalHit, $06, dHigherMetalHit, dHigherMetalHit, $12

Snd_AIZ1_Loop01:
	smpsCall            Snd_AIZ1_Call00
	smpsLoop            $00, $07, Snd_AIZ1_Loop01
	dc.b	dKickS3, $18, dKickS3, $17, dSnareS3, $01, dSnareS3, $06, dSnareS3, $0C, dSnareS3, dSnareS3
	dc.b	$06, dSnareS3, $0C
	smpsCall            Snd_AIZ1_Call00
	dc.b	dKickS3, $0C, dHighMetalHit, $06, dLowTomS3, dKickS3, $0C, dMidTomS3, $06, dLowMetalHit, dKickS3, $0C
	dc.b	dHighMetalHit, $06, dLowTomS3, dKickS3, $0C, dSnareS3
	smpsCall            Snd_AIZ1_Call00
	dc.b	dKickS3, $0C, dHighMetalHit, $06, dLowTomS3, dKickS3, $0C, dMidTomS3, $06, dLowMetalHit, dKickS3, dHigherMetalHit
	dc.b	dHighMetalHit, dLowTomS3, dKickS3, $0C, dSnareS3, $06, dSnareS3
	smpsCall            Snd_AIZ1_Call00
	dc.b	dKickS3, $0C, dHighMetalHit, $06, dLowTomS3, dKickS3, $0C, dMidTomS3, $06, dLowMetalHit, dKickS3, $0C
	dc.b	dHighMetalHit, $06, dLowTomS3, dKickS3, $0C, dSnareS3
	smpsCall            Snd_AIZ1_Call00
	dc.b	dKickS3, $0C, dHighMetalHit, $06, dLowTomS3, dKickS3, $0C, dMidTomS3, $06, dLowMetalHit, dSnareS3, dSnareS3
	dc.b	dSnareS3, $0C, dSnareS3, $06, dSnareS3, dSnareS3, $0C, dKickS3

Snd_AIZ1_Loop02:
	smpsCall            Snd_AIZ1_Call01
	smpsLoop            $00, $03, Snd_AIZ1_Loop02
	dc.b	dHighMetalHit, $06, dLowTomS3, dKickS3, $0C, dMidTomS3, $06, dLowMetalHit, dKickS3, dSnareS3, dHighMetalHit, dSnareS3
	dc.b	dSnareS3, $0C, dSnareS3, $06, dMetalHit, dKickS3, $0C

Snd_AIZ1_Loop03:
	smpsCall            Snd_AIZ1_Call01
	smpsLoop            $00, $03, Snd_AIZ1_Loop03
	dc.b	dHighMetalHit, $06, dLowTomS3, dKickS3, $0C, dMidTomS3, $06, dLowMetalHit, dKickS3, $0C, dHighMetalHit, $06
	dc.b	dLowTomS3, dSnareS3, $0C, dSnareS3, $06, dMetalHit, dKickS3, $0C

Snd_AIZ1_Loop04:
	smpsCall            Snd_AIZ1_Call01
	smpsLoop            $00, $02, Snd_AIZ1_Loop04
	dc.b	dHighMetalHit, $06, dLowTomS3, dKickS3, $0C, dMidTomS3, $06, dLowMetalHit, dKickS3, $0C, dHighMetalHit, $06
	dc.b	dLowTomS3, dSnareS3, $0C, dHighTom, $06, dMetalHit, $03, dMidMetalHit, $02, dMidMetalHit, $01, dHigherMetalHit
	dc.b	$06, dHigherMetalHit, $0C, dHigherMetalHit, dLowTomS3, $06, dSnareS3, $06, dKickS3, $0C, dKickS3, dKickS3
	dc.b	$03, dKickS3, dSnareS3, $06, nRst, $12
	smpsJump            Snd_AIZ1_DAC

; Unreachable
	smpsStop

Snd_AIZ1_Call00:
	dc.b	dKickS3, $0C, dHighMetalHit, $06, dLowTomS3, dKickS3, $0C, dMidTomS3, $06, dLowMetalHit, dKickS3, $0C
	dc.b	dHighMetalHit, $06, dLowTomS3, dKickS3, $0C, dHighTom, $06, dMetalHit
	smpsReturn

Snd_AIZ1_Call01:
	dc.b	dHighMetalHit, $06, dLowTomS3, dKickS3, $0C, dMidTomS3, $06, dLowMetalHit, dKickS3, $0C, dHighMetalHit, $06
	dc.b	dLowTomS3, dSnareS3, $0C, dHighTom, $06, dMetalHit, dKickS3, $0C
	smpsReturn

; FM1 Data
Snd_AIZ1_FM1:
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nC1, $0B, nRst, $01
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nRst, nC2, $04, nRst, $07, nBb1, $0B, nRst, $01, nA1, $05, nRst
	dc.b	$01, nBb1, $05, nRst, $07, nA1, $05, nRst, $01, nBb1, $05, nRst
	dc.b	$07, nBb1, $05, nRst, $07, nC2, $0B, nRst, $01
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nC1, $0B, nRst, $01
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nBb1, nC2, $04, nRst, $07, nBb1, $0B, nRst, $01, nA1, $05, nRst
	dc.b	$01, nBb1, $05, nRst, $07
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nBb0, $05, nRst, $07, nBb0, $05, nRst, $07, nBb0, $05, nRst, $01
	dc.b	nB0, $0B, nRst, $01, nC1, $0B, nRst, $01
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nB1, nC2, $04, nRst, $07, nBb1, $0B, nRst, $01, nA1, $05, nRst
	dc.b	$01, nBb1, $05, nRst, $07, nA1, $05, nRst, $01, nBb1, $05, nRst
	dc.b	$07, nBb1, $05, nRst, $08, nC2, $0A, nRst, $01
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nC1, $0B, nRst, $01
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nC2, $05, nRst, $07, nBb1, $0B, nRst, $01, nA1, $05, nRst, $01
	dc.b	nBb1, $05, nRst, $07
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nBb0, $05, nRst, $07, nBb0, $05, nRst, $07, nBb0, $05, nRst, $01
	dc.b	nB0, $0B, nRst, $01
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nC1, $0B, nRst, $01
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nRst, nC2, $04, nRst, $07, nBb1, $0B, nRst, $01, nA1, $05, nRst
	dc.b	$01, nBb1, $05, nRst, $07, nA1, $05, nRst, $01, nBb1, $05, nRst
	dc.b	$07, nBb1, $05, nRst, $07, nC2, $0B, nRst, $01
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nC1, $0B, nRst, $01
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nBb1, nC2, $04, nRst, $07, nBb1, $0B, nRst, $01, nA1, $05, nRst
	dc.b	$01, nBb1, $05, nRst, $07
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nBb0, $05, nRst, $07, nBb0, $05, nRst, $07, nBb0, $05, nRst, $01
	dc.b	nB0, $0B, nRst, $01, nC1, $0B, nRst, $01
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nB1, nC2, $04, nRst, $07, nBb1, $0B, nRst, $01, nA1, $05, nRst
	dc.b	$01, nBb1, $05, nRst, $07, nA1, $05, nRst, $01, nBb1, $05, nRst
	dc.b	$07, nBb1, $05, nRst, $08, nC2, $0A, nRst, $01
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nG0, $05, nRst, $01, nG0, $05, nRst, $01, nG0, $05, nRst, $01
	dc.b	nG0, $05, nRst, $1F, nF0, $05, nRst, $01, nA0, $0B, nRst, $01
	dc.b	nBb0, $0B, nRst, $01, nB0, $0B, nRst, $01, nC1, $16, nRst, $02
	dc.b	nC1, $10, nRst, $02, nC1, $10, nRst, $02, nG0, $0A, nRst, $02
	dc.b	nC1, $0A, nRst, $02, nG0, $0A, nRst, $02, nF0, $16, nRst, $02
	dc.b	nF0, $10, nRst, $02, nF0, $0A, nRst, $02, nF0, $04, nRst, $02
	dc.b	nA0, $0A, nRst, $02, nBb0, $0A, nRst, $02, nB0, $0A, nRst, $02
	dc.b	nC1, $16, nRst, $02, nC1, $10, nRst, $02, nC1, $10, nRst, $02
	dc.b	nG0, $0A, nRst, $02, nC1, $0A, nRst, $02, nG0, $0A, nRst, $02
	dc.b	nF0, $16, nRst, $02, nF0, $10, nRst, $02, nF0, $0A, nRst, $02
	dc.b	nF0, $04, nRst, $02, nA0, $0A, nRst, $02, nBb0, $0A, nRst, $02
	dc.b	nB0, $0A, nRst, $02, nC1, $16, nRst, $02, nC1, $10, nRst, $02
	dc.b	nC1, $10, nRst, $02, nG0, $0A, nRst, $02, nC1, $0A, nRst, $02
	dc.b	nG0, $0A, nRst, $02, nF0, $16, nRst, $02, nF0, $10, nRst, $02
	dc.b	nF0, $0A, nRst, $02, nF0, $04, nRst, $02, nA0, $0A, nRst, $02
	dc.b	nBb0, $0A, nRst, $02, nB0, $0A, nRst, $02, nC1, $16, nRst, $02
	dc.b	nC1, $10, nRst, $02, nC1, $10, nRst, $02, nG0, $0A, nRst, $02
	dc.b	nC1, $0A, nRst, $02, nG0, $0A, nRst, $02, nF0, $16, nRst, $02
	dc.b	nF0, $10, nRst, $02, nF0, $0A, nRst, $02, nF0, $04, nRst, $02
	dc.b	nA0, $0A, nRst, $02, nBb0, $0A, nRst, $02, nB0, $0A, nRst, $02
	dc.b	nC1, $16, nRst, $02, nC1, $10, nRst, $02, nC1, $10, nRst, $02
	dc.b	nG0, $0A, nRst, $02, nC1, $0A, nRst, $02, nG0, $0A, nRst, $02
	dc.b	nF0, $16, nRst, $02, nF0, $10, nRst, $02, nF0, $0A, nRst, $02
	dc.b	nF0, $04, nRst, $02, nA0, $0A, nRst, $02, nBb0, $0A, nRst, $02
	dc.b	nB0, $0A, nRst, $02, nC1, $16, nRst, $02, nC1, $10, nRst, $02
	dc.b	nC1, $10, nRst, $02, nG0, $0A, nRst, $02, nC1, $0A, nRst, $02
	dc.b	nG0, $0A, nRst, $02, nF0, $16, nRst, $02, nF0, $10, nRst, $02
	dc.b	nF0, $0A, nRst, $02, nF0, $04, nRst, $02, nA0, $0A, nRst, $02
	dc.b	nBb0, $0A, nRst, $02, nB0, $0A, nRst, $02, nC1, $16, nRst, $02
	dc.b	nC1, $10, nRst, $02, nC1, $10, nRst, $02, nG0, $0A, nRst, $02
	dc.b	nC1, $0A, nRst, $02, nG0, $0A, nRst, $02, nF0, $16, nRst, $02
	dc.b	nF0, $10, nRst, $02, nF0, $0A, nRst, $02, nF0, $04, nRst, $02
	dc.b	nA0, $0A, nRst, $02, nBb0, $0A, nRst, $02, nB0, $0A, nRst, $02
	dc.b	nC1, $16, nRst, $02, nC1, $10, nRst, $02, nC1, $10, nRst, $02
	dc.b	nG0, $0A, nRst, $02, nC1, $0A, nRst, $02, nG0, $0A, nRst, $02
	dc.b	nF0, $16, nRst, $02, nF0, $10, nRst, $02, nF0, $0A, nRst, $02
	dc.b	nF0, $04, nRst, $02, nC1, $04, nRst, $02, nF1, $04, nRst, $02
	dc.b	nF1, $04, nRst, $02, nC1, $04, nRst, $02, nF0, $0A, nRst, $02
	dc.b	nE0, $16, nRst, $02, nE0, $10, nRst, $02, nA0, $10, nRst, $02
	dc.b	nA0, $0A, nRst, $02, nE1, $0A, nRst, $02, nA0, $0A, nRst, $02
	dc.b	nD1, $16, nRst, $02, nD1, $10, nRst, $02, nG0, $0A, nRst, $02
	dc.b	nG0, $04, nRst, $02, nG1, $0A, nRst, $02, nG1, $0A, nRst, $02
	dc.b	nF1, $0A, nRst, $02, nE1, $16, nRst, $02, nE1, $10, nRst, $02
	dc.b	nA0, $10, nRst, $02, nA0, $0A, nRst, $02, nE1, $0A, nRst, $02
	dc.b	nA0, $0A, nRst, $02, nD1, $16, nRst, $02, nD1, $10, nRst, $02
	dc.b	nG0, $0A, nRst, $02, nG0, $04, nRst, $02, nG1, $0A, nRst, $02
	dc.b	nG1, $0A, nRst, $02, nF1, $0A, nRst, $02, nE1, $16, nRst, $02
	dc.b	nE1, $10, nRst, $02, nA0, $10, nRst, $02, nA0, $0A, nRst, $02
	dc.b	nE1, $0A, nRst, $02, nA0, $0A, nRst, $02, nD1, $16, nRst, $02
	dc.b	nD1, $10, nRst, $02, nG0, $0A, nRst, $02, nG0, $04, nRst, $02
	dc.b	nG1, $0A, nRst, $02, nG1, $0A, nRst, $02, nF1, $0A, nRst, $02
	dc.b	nE1, $16, nRst, $02, nE1, $10, nRst, $02, nA0, $10, nRst, $02
	dc.b	nA0, $0A, nRst, $02, nE1, $0A, nRst, $02, nA0, $0A, nRst, $02
	dc.b	nD1, $16, nRst, $02, nD1, $10, nRst, $02, nG0, $0A, nRst, $02
	dc.b	nG0, $04, nRst, $02, nG1, $0A, nRst, $02, nFs1, $0A, nRst, $02
	dc.b	nFs1, $0A, nRst, $02, nF1, $16, nRst, $02, nF1, $10, nRst, $02
	dc.b	nC1, $10, nRst, $02, nC1, $0A, nRst, $02, nF1, $0A, nRst, $02
	dc.b	nF1, $0A, nRst, $02, nD1, $16, nRst, $02, nD1, $10, nRst, $02
	dc.b	nA0, $10, nRst, $02, nA0, $0A, nRst, $02, nD1, $0A, nRst, $02
	dc.b	nD1, $0A, nRst, $02, nBb0, $16, nRst, $02, nBb0, $10, nRst, $02
	dc.b	nF0, $10, nRst, $02, nF0, $0A, nRst, $02, nBb0, $0A, nRst, $02
	dc.b	nBb0, $0A, nRst, $02, nG0, $16, nRst, $02, nG0, $10, nRst, $02
	dc.b	nB0, $10, nRst, $02, nB0, $0A, nRst, $02, nC1, $0A, nRst, $02
	dc.b	nD1, $0A, nRst, $02
	smpsJump            Snd_AIZ1_FM1

; Unreachable
	smpsStop

; FM2 Data
Snd_AIZ1_FM2:
	smpsSetvoice        $18
	smpsAlterNote       $FB
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	smpsCall            Snd_AIZ1_Call02
	smpsCall            Snd_AIZ1_Call03
	smpsSetvoice        $17
	smpsAlterNote       $05
	smpsModSet          $0F, $01, $03, $05
	smpsPan             panRight, $00
	smpsCall            Snd_AIZ1_Call04
	smpsSetvoice        $11
	smpsAlterNote       $FB
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nD3, nF3, nD4, nC4, $1E
	smpsSetvoice        $18
	smpsAlterNote       $FB
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	smpsCall            Snd_AIZ1_Call05
	smpsSetvoice        $11
	smpsAlterNote       $FB
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nA3, $06, nA3, nA3, nA3, nRst, $24
	smpsFMAlterVol      $FA
	smpsFMAlterVol      $FB
	smpsSetvoice        $06
	smpsAlterNote       $FB
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panCenter, $00
	smpsCall            Snd_AIZ1_Call06
	smpsSetvoice        $06
	smpsAlterNote       $FB
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panCenter, $00
	smpsCall            Snd_AIZ1_Call07
	dc.b	nBb1, $01, smpsNoAttack, nAb2, $01, smpsNoAttack, nBb2, $39, nRst, $3D
	smpsSetvoice        $06
	smpsAlterNote       $FB
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panCenter, $00
	smpsCall            Snd_AIZ1_Call08
	smpsSetvoice        $06
	smpsAlterNote       $FB
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panCenter, $00
	smpsCall            Snd_AIZ1_Call09
	dc.b	nRst, $03
	smpsFMAlterVol      $05
	smpsFMAlterVol      $F8
	smpsSetvoice        $0F
	smpsAlterNote       $03
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	smpsCall            Snd_AIZ1_Call0A
	dc.b	nRst, $1F
	smpsFMAlterVol      $08
	smpsSetvoice        $06
	smpsAlterNote       $03
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panCenter, $00
	smpsCall            Snd_AIZ1_Call0B
	dc.b	nRst, $07
	smpsFMAlterVol      $FE
	smpsSetvoice        $0F
	smpsAlterNote       $03
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nG3, $0B, nRst, $01, nD4, $0B, nRst, $01, nG4, $0B, nRst, $01
	smpsSetvoice        $0F
	smpsAlterNote       $03
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nF4, $05, nRst, $0D, nE4, $05, nRst, $0D, nC4, $05, nRst, $07
	dc.b	nA3, $30, nD4, $05, nRst, $0D, nC4, $05, nRst, $0D, nB3, $05
	dc.b	nRst, $0D
	smpsFMAlterVol      $02
	smpsSetvoice        $06
	smpsAlterNote       $03
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panCenter, $00
	dc.b	nG2, $30, nE2, $2F, nRst, $01, nA2, $0F, nRst, $01, nG2, $0F
	dc.b	nRst, $01, nF2, $0F, nRst, $01, nE2, $0F, nRst, $01, nF2, $0F
	dc.b	nRst, $01, nA2, $0F, nRst, $07
	smpsFMAlterVol      $FE
	smpsSetvoice        $0F
	smpsAlterNote       $03
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nG3, $0B, nRst, $01, nD4, $0B, nRst, $01, nG4, $0B, nRst, $01
	dc.b	nF4, $05, nRst, $0D, nE4, $05, nRst, $0D, nC4, $05, nRst, $07
	dc.b	nA3, $30, nD4, $05, nRst, $0D, nC4, $05, nRst, $0D, nB3, $05
	dc.b	nRst, $07
	smpsSetvoice        $06
	smpsAlterNote       $FE
	smpsModSet          $0C, $01, $06, $05
	smpsPan             panLeft, $00
	dc.b	nA3, $1D, nRst, $07, nA3, $02, nRst, $04, nB3, $02, nRst, $04
	dc.b	nC4, $12, nB3, $12, nA3, $0B, nRst, $01, nC4, $1D, nRst, $07
	dc.b	nC4, $02, nRst, $04, nD4, $02, nRst, $04, nE4, $12, nD4, $12
	dc.b	nC4, $0B, nRst, $01, nD4, $30, nA3, $30, nC4, $18, nB3, nC4
	dc.b	nD4
	smpsFMAlterVol      $02
	smpsJump            Snd_AIZ1_FM2

; Unreachable
	smpsStop

; FM3 Data
Snd_AIZ1_FM3:
	smpsSetvoice        $18
	smpsAlterNote       $05
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panLeft, $00
	smpsCall            Snd_AIZ1_Call02
	smpsSetvoice        $18
	smpsAlterNote       $05
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panLeft, $00
	smpsCall            Snd_AIZ1_Call03
	smpsSetvoice        $17
	smpsAlterNote       $FB
	smpsModSet          $0F, $01, $03, $05
	smpsPan             panLeft, $00
	smpsCall            Snd_AIZ1_Call04
	smpsSetvoice        $06
	smpsAlterNote       $FE
	smpsModSet          $0C, $01, $06, $05
	smpsPan             panLeft, $00
	dc.b	nF3, $06, nBb3, nF4, nE4, $1E
	smpsSetvoice        $18
	smpsAlterNote       $05
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panLeft, $00
	smpsCall            Snd_AIZ1_Call05
	dc.b	nC5, $06, nC5, nC5, nC5, nRst, $24
	smpsFMAlterVol      $FA
	smpsSetvoice        $06
	smpsAlterNote       $03
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panCenter, $00
	smpsFMAlterVol      $00
	dc.b	nRst, $03
	smpsCall            Snd_AIZ1_Call06
	smpsCall            Snd_AIZ1_Call07
	dc.b	nD3, $3B, nRst, $3D
	smpsCall            Snd_AIZ1_Call08
	smpsCall            Snd_AIZ1_Call09
	smpsFMAlterVol      $00
	smpsSetvoice        $0F
	smpsAlterNote       $FB
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	smpsCall            Snd_AIZ1_Call0A
	dc.b	nRst, $19
	smpsSetvoice        $06
	smpsAlterNote       $03
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panCenter, $00
	smpsCall            Snd_AIZ1_Call0B
	dc.b	nRst, $01
	smpsSetvoice        $06
	smpsAlterNote       $03
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panCenter, $00
	dc.b	nG2, $5F, nRst, $07, nA3, $2F, nRst, $01, nD4, $05, nRst, $0D
	dc.b	nC4, $05, nRst, $0D, nB3, $05, nRst, $01, nG2, $2F, nRst, $01
	dc.b	nE2, $2F, nRst, $01
	smpsSetvoice        $06
	smpsAlterNote       $03
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panCenter, $00
	dc.b	nA2, $0F, nRst, $01, nG2, $0F, nRst, $01, nF2, $0F, nRst, $01
	dc.b	nE2, $0F, nRst, $01, nF2, $0F, nRst, $01, nA2, $0F, nRst, $01
	dc.b	nG2, $5F, nRst, $01, nA3, $2F, nRst, $01, nD4, $05, nRst, $0D
	dc.b	nC4, $05, nRst, $0D, nB3, $05, nRst, $07
	smpsSetvoice        $0F
	smpsAlterNote       $FB
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nRst, $60, nF3, $1D, nRst, $07, nF3, $02, nRst, $04, nG3, $02
	dc.b	nRst, $04, nA3, $11, nRst, $01, nG3, $11, nRst, $01, nF3, $0B
	dc.b	nRst, $01
	smpsSetvoice        $11
	smpsAlterNote       $FB
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nA3, $2F, nRst, $01, nF3, $2F, nRst, $01, nA3, $17, nRst, $01
	dc.b	nG3, $17, nRst, $01, nA3, $17, nRst, $01, nB3, $17, nRst, $01
	smpsJump            Snd_AIZ1_FM3

Snd_AIZ1_Call02:
	dc.b	nG3, $04, nE3
	smpsFMAlterVol      $06
	dc.b	nG3, nE3
	smpsFMAlterVol      $02
	dc.b	nG3, nE3, nG3, nE3
	smpsFMAlterVol      $02
	dc.b	nG3, nE3, nG3, nE3
	smpsFMAlterVol      $02
	dc.b	nG3, nE3
	smpsFMAlterVol      $FA
	dc.b	nG3, nE3
	smpsFMAlterVol      $FE
	dc.b	nG3, nE3
	smpsFMAlterVol      $FC
	dc.b	nA3, nF3
	smpsFMAlterVol      $06
	dc.b	nA3, nF3
	smpsFMAlterVol      $02
	dc.b	nA3, nF3
	smpsFMAlterVol      $F8
	smpsReturn

Snd_AIZ1_Call03:
	dc.b	nBb3, $04, nG3
	smpsFMAlterVol      $04
	dc.b	nBb3, nG3
	smpsFMAlterVol      $02
	dc.b	nBb3, nG3
	smpsFMAlterVol      $02
	dc.b	nBb3, nG3
	smpsFMAlterVol      $02
	dc.b	nBb3, nG3, nBb3, nG3
	smpsFMAlterVol      $FE
	dc.b	nBb3, nG3
	smpsFMAlterVol      $FE
	dc.b	nBb3
	smpsFMAlterVol      $FE
	dc.b	nG3
	smpsFMAlterVol      $FE
	dc.b	nBb3, nG3
	smpsFMAlterVol      $FE
	dc.b	nA3, nF3
	smpsFMAlterVol      $04
	dc.b	nA3, nF3
	smpsFMAlterVol      $02
	dc.b	nA3, nF3
	smpsFMAlterVol      $FE
	dc.b	nA3
	smpsFMAlterVol      $FE
	dc.b	nBb3
	smpsFMAlterVol      $02
	dc.b	nA3
	smpsFMAlterVol      $FE
	dc.b	nG3, nE3
	smpsFMAlterVol      $02
	dc.b	nG3, nE3
	smpsFMAlterVol      $02
	dc.b	nG3, nE3
	smpsFMAlterVol      $02
	dc.b	nG3, nE3
	smpsFMAlterVol      $02
	dc.b	nG3, nE3
	smpsFMAlterVol      $FE
	dc.b	nG3, nE3
	smpsFMAlterVol      $FE
	dc.b	nG3, nE3
	smpsFMAlterVol      $FE
	dc.b	nG3, nE3
	smpsFMAlterVol      $FE
	dc.b	nG3, nE3, nG3, nE3
	smpsFMAlterVol      $FE
	dc.b	nG3
	smpsReturn

Snd_AIZ1_Call04:
	dc.b	nC4, $06, nC4, nC5, nC4, nBb4, nC4, nBb4, nC5
	smpsReturn

Snd_AIZ1_Call05:
	dc.b	nG3, $04, nE3
	smpsFMAlterVol      $06
	dc.b	nG3, nE3
	smpsFMAlterVol      $02
	dc.b	nG3, nE3, nG3, nE3
	smpsFMAlterVol      $02
	dc.b	nG3, nE3, nG3, nE3
	smpsFMAlterVol      $02
	dc.b	nG3, nE3
	smpsFMAlterVol      $FA
	dc.b	nG3, nE3
	smpsFMAlterVol      $FE
	dc.b	nG3, nE3
	smpsFMAlterVol      $FC
	dc.b	nA3, nF3
	smpsFMAlterVol      $06
	dc.b	nA3, nF3
	smpsFMAlterVol      $02
	dc.b	nA3, nF3
	smpsFMAlterVol      $F8
	dc.b	nBb3, nG3
	smpsFMAlterVol      $04
	dc.b	nBb3, nG3
	smpsFMAlterVol      $02
	dc.b	nBb3, nG3
	smpsFMAlterVol      $02
	dc.b	nBb3, nG3
	smpsFMAlterVol      $02
	dc.b	nBb3, nG3, nBb3, nG3
	smpsFMAlterVol      $FE
	dc.b	nBb3, nG3
	smpsFMAlterVol      $FE
	dc.b	nBb3
	smpsFMAlterVol      $FE
	dc.b	nG3
	smpsFMAlterVol      $FE
	dc.b	nBb3, nG3
	smpsFMAlterVol      $FE
	dc.b	nA3, nF3
	smpsFMAlterVol      $04
	dc.b	nA3, nF3
	smpsFMAlterVol      $02
	dc.b	nA3, nF3
	smpsFMAlterVol      $FE
	dc.b	nA3
	smpsFMAlterVol      $FE
	dc.b	nBb3
	smpsFMAlterVol      $02
	dc.b	nA3
	smpsFMAlterVol      $FE
	dc.b	nG3, nE3
	smpsFMAlterVol      $02
	dc.b	nG3, nE3
	smpsFMAlterVol      $02
	dc.b	nG3, nE3
	smpsFMAlterVol      $02
	dc.b	nG3, nE3
	smpsFMAlterVol      $02
	dc.b	nG3, nE3
	smpsFMAlterVol      $FE
	dc.b	nG3, nE3
	smpsFMAlterVol      $FE
	dc.b	nG3, nE3
	smpsFMAlterVol      $FE
	dc.b	nG3, nE3
	smpsFMAlterVol      $FE
	dc.b	nG3, nE3, nG3, nE3
	smpsFMAlterVol      $FE
	dc.b	nG3
	smpsReturn

Snd_AIZ1_Call06:
	dc.b	nF1, $01, smpsNoAttack, nEb2, $01, smpsNoAttack, nF2, $0A, nBb1, $01, smpsNoAttack, nAb2
	dc.b	$01, smpsNoAttack, nBb2, $0A, nF2, $01, smpsNoAttack, nEb3, $01, smpsNoAttack, nF3, $0A
	dc.b	nE2, $01, smpsNoAttack, nD3, $01, smpsNoAttack, nE3, $03, nRst, $0D, nC2, $01
	dc.b	smpsNoAttack, nBb2, $01, smpsNoAttack, nC3, $03, nRst, $0D, nBb1, $01, smpsNoAttack, nAb2
	dc.b	$01, smpsNoAttack, nBb2, $39, nRst, $3D
	smpsReturn

Snd_AIZ1_Call07:
	dc.b	nF1, $01, smpsNoAttack, nEb2, $01, smpsNoAttack, nF2, $0A, nBb1, $01, smpsNoAttack, nAb2
	dc.b	$01, smpsNoAttack, nBb2, $0A, nF2, $01, smpsNoAttack, nEb3, $01, smpsNoAttack, nF3, $0A
	dc.b	nE2, $01, smpsNoAttack, nD3, $01, smpsNoAttack, nE3, $03, nRst, $0D, nC2, $01
	dc.b	smpsNoAttack, nBb2, $01, smpsNoAttack, nC3, $03, nRst, $0D
	smpsReturn

Snd_AIZ1_Call08:
	dc.b	nF1, $01, smpsNoAttack, nEb2, $01, smpsNoAttack, nF2, $0A, nBb1, $01, smpsNoAttack, nAb2
	dc.b	$01, smpsNoAttack, nBb2, $0A, nF2, $01, smpsNoAttack, nEb3, $01, smpsNoAttack, nF3, $0A
	dc.b	nE2, $01, smpsNoAttack, nD3, $01, smpsNoAttack, nE3, $03, nRst, $0D, nC2, $01
	dc.b	smpsNoAttack, nBb2, $01, smpsNoAttack, nC3, $03, nRst, $0D, nBb1, $01, smpsNoAttack, nAb2
	dc.b	$01, smpsNoAttack, nBb2, $39, nRst, $3D
	smpsReturn

Snd_AIZ1_Call09:
	dc.b	nF1, $01, smpsNoAttack, nEb2, $01, smpsNoAttack, nF2, $0A, nBb1, $01, smpsNoAttack, nAb2
	dc.b	$01, smpsNoAttack, nBb2, $0A, nF2, $01, smpsNoAttack, nEb3, $01, smpsNoAttack, nF3, $0A
	dc.b	nE2, $01, smpsNoAttack, nD3, $01, smpsNoAttack, nE3, $03, nRst, $0D, nC2, $01
	dc.b	smpsNoAttack, nBb2, $01, smpsNoAttack, nC3, $03, nRst, $0D, nD2, $01, smpsNoAttack, nC3
	dc.b	$01, smpsNoAttack, nD3, $39, nRst, $49
	smpsFMAlterVol      $06
	dc.b	nRst, $09
	smpsReturn

Snd_AIZ1_Call0A:
	dc.b	nE4, $05, nRst, $01, nF4, $05, nRst, $01, nG4, $05, nRst, $0D
	dc.b	nC4, $05, nRst, $0D, nBb4, $11, nRst, $07, nBb4, $05, nRst, $07
	dc.b	nBb4, $05, nRst, $07, nG4, $05, nRst, $07, nA4, $05, nRst, $0D
	dc.b	nF4, $05, nRst, $0D, nC4, $29, nRst, $07, nE4, $05, nRst, $01
	dc.b	nF4, $05, nRst, $01, nG4, $05, nRst, $0D, nC4, $05, nRst, $0D
	dc.b	nBb4, $11, nRst, $07, nBb4, $05, nRst, $07, nBb4, $05, nRst, $07
	dc.b	nC5, $05, nRst, $07, nA4, $2F, nRst, $25, nE4, $05, nRst, $01
	dc.b	nF4, $05, nRst, $01, nG4, $05, nRst, $0D, nC4, $05, nRst, $0D
	dc.b	nBb4, $0B, nRst, $07, nBb4, $02, nRst, $04, nBb4, $02, nRst, $0A
	dc.b	nBb4, $05, nRst, $07, nG4, $05, nRst, $07, nA4, $05, nRst, $0D
	dc.b	nF4, $05, nRst, $0D, nC4, $23, nRst, $0D, nE4, $05, nRst, $01
	dc.b	nF4, $05, nRst, $01, nG4, $05, nRst, $0D, nC4, $05, nRst, $0D
	dc.b	nBb4, $11, nRst, $07, nBb4, $05, nRst, $07, nBb4, $05, nRst, $07
	dc.b	nC5, $05, nRst, $07, nA4, $11, nRst, $01, nBb4, $11, nRst, $01
	dc.b	nC5, $23
	smpsReturn

Snd_AIZ1_Call0B:
	dc.b	nG1, $01, smpsNoAttack, nF2, $01, smpsNoAttack, nG2, $2D, nRst, $01, nE1, $01
	dc.b	smpsNoAttack, nD2, $01, smpsNoAttack, nE2, $2D, nRst, $01, nA1, $01, smpsNoAttack, nG2
	dc.b	$01, smpsNoAttack, nA2, $0D, nRst, $01, nG1, $01, smpsNoAttack, nF2, $01, smpsNoAttack
	dc.b	nG2, $0D, nRst, $01, nF1, $01, smpsNoAttack, nEb2, $01, smpsNoAttack, nF2, $0D
	dc.b	nRst, $01, nE1, $01, smpsNoAttack, nD2, $01, smpsNoAttack, nE2, $0D, nRst, $01
	dc.b	nF1, $01, smpsNoAttack, nEb2, $01, smpsNoAttack, nF2, $0D, nRst, $01, nA1, $01
	dc.b	smpsNoAttack, nG2, $01, smpsNoAttack, nA2, $0D
	smpsReturn

; Unreachable
	smpsStop

; FM4 Data
Snd_AIZ1_FM4:
	smpsSetvoice        $16
	smpsAlterNote       $FB
	smpsModSet          $03, $01, $02, $05
	smpsPan             panRight, $00
	dc.b	nG3, $05, nRst, $0D, nG3, $05, nRst, $19, nG3, $05, nRst, $0D
	dc.b	nG3, $05, nRst, $19, nF3, $05, nRst, $0D, nF3, $05, nRst, $07
	smpsSetvoice        $06
	smpsAlterNote       $FE
	smpsModSet          $0C, $01, $06, $05
	smpsPan             panLeft, $00
	dc.b	nD3, $04, nRst, $02, nE3, $04, nRst, $02, nF3, $04, nRst, $08
	smpsSetvoice        $16
	smpsAlterNote       $FB
	smpsModSet          $03, $01, $02, $05
	smpsPan             panRight, $00
	dc.b	nF3, $05, nRst, $07, nF3, $05, nRst, $07, nF3, $05, nRst, $01
	dc.b	nFs3, $05, nRst, $07, nG3, $05, nRst, $0D, nG3, $05, nRst, $19
	dc.b	nG3, $05, nRst, $0D, nG3, $05, nRst, $19, nF3, $05, nRst, $0D
	dc.b	nF3, $05, nRst, $19
	smpsSetvoice        $06
	smpsAlterNote       $FE
	smpsModSet          $0C, $01, $06, $05
	smpsPan             panLeft, $00
	dc.b	nF3, $04, nRst, $02, nBb3, $04, nRst, $02, nF4, $04, nRst, $02
	dc.b	nE4, $1D, nRst, $01
	smpsSetvoice        $16
	smpsAlterNote       $FB
	smpsModSet          $03, $01, $02, $05
	smpsPan             panRight, $00
	dc.b	nG3, $05, nRst, $0D, nG3, $05, nRst, $19, nG3, $05, nRst, $0D
	dc.b	nG3, $05, nRst, $19, nF3, $05, nRst, $0D, nF3, $05, nRst, $07
	smpsSetvoice        $06
	smpsAlterNote       $FE
	smpsModSet          $0C, $01, $06, $05
	smpsPan             panLeft, $00
	dc.b	nD3, $04, nRst, $02, nE3, $04, nRst, $02, nF3, $04, nRst, $08
	smpsSetvoice        $16
	smpsAlterNote       $FB
	smpsModSet          $03, $01, $02, $05
	smpsPan             panRight, $00
	dc.b	nF3, $05, nRst, $07, nF3, $05, nRst, $07, nF3, $05, nRst, $01
	dc.b	nFs3, $05, nRst, $07, nG3, $05, nRst, $0D, nG3, $05, nRst, $19
	dc.b	nG3, $05, nRst, $0D, nG3, $05, nRst, $19
	smpsSetvoice        $06
	smpsAlterNote       $FE
	smpsModSet          $0C, $01, $06, $05
	smpsPan             panLeft, $00
	dc.b	nC4, $05, nRst, $01, nC4, $05, nRst, $01, nC4, $05, nRst, $01
	dc.b	nC4, $05, nRst, $55
	smpsSetvoice        $17
	smpsAlterNote       $FB
	smpsModSet          $0F, $01, $03, $05
	smpsPan             panLeft, $00
	dc.b	nD3, $02, nRst, $0A, nE3, $02, nRst, $16, nD3, $11, nRst, $01
	dc.b	nE3, $02, nRst, $28, nA4, $05, nRst, $01, nBb4, $05, nRst, $07
	dc.b	nBb4, $02, nRst, $04, nBb4, $02, nRst, $04, nBb4, $02, nRst, $04
	dc.b	nBb4, $02, nRst, $0A, nA4, $23, nRst, $0D, nD3, $02, nRst, $0A
	dc.b	nE3, $02, nRst, $16, nD3, $11, nRst, $01, nE3, $02, nRst, $28
	dc.b	nA4, $05, nRst, $01, nBb4, $05, nRst, $07, nBb4, $02, nRst, $04
	dc.b	nBb4, $02, nRst, $04, nBb4, $02, nRst, $04, nBb4, $02, nRst, $0A
	dc.b	nC5, $05, nRst, $01, nBb4, $1D, nRst, $0D, nD3, $02, nRst, $0A
	dc.b	nE3, $02, nRst, $16, nD3, $11, nRst, $01, nE3, $02, nRst, $28
	dc.b	nA4, $05, nRst, $01, nBb4, $05, nRst, $07, nBb4, $02, nRst, $04
	dc.b	nBb4, $02, nRst, $04, nBb4, $02, nRst, $04, nBb4, $02, nRst, $0A
	dc.b	nA4, $23, nRst, $0D, nD3, $02, nRst, $0A, nE3, $02, nRst, $16
	dc.b	nD3, $11, nRst, $01, nE3, $02, nRst, $28, nA4, $05, nRst, $01
	dc.b	nBb4, $05, nRst, $07, nBb4, $02, nRst, $04, nBb4, $02, nRst, $04
	dc.b	nBb4, $02, nRst, $04, nBb4, $02, nRst, $0A, nC5, $05, nRst, $01
	dc.b	nBb4, $1D, nRst, $0D
	smpsSetvoice        $16
	smpsAlterNote       $FB
	smpsModSet          $03, $01, $02, $05
	smpsPan             panRight, $00
	dc.b	nE3, $0B, nRst, $01, nE3, $0B, nRst, $0D, nD3, $05, nRst, $0D
	dc.b	nE3, $05, nRst, $19, nC2, $05, nRst, $01, nG2, $05, nRst, $01
	dc.b	nC3, $05, nRst, $01, nBb2, $05, nRst, $07, nBb2, $05, nRst, $07
	dc.b	nA2, $05, nRst, $07, nA2, $05, nRst, $07, nF2, $05, nRst, $01
	dc.b	nC2, $05, nRst, $1F, nE3, $0B, nRst, $01, nE3, $0B, nRst, $0D
	dc.b	nD3, $05, nRst, $0D, nE3, $05, nRst, $19, nC2, $05, nRst, $01
	dc.b	nG2, $05, nRst, $01, nC3, $05, nRst, $01, nBb2, $05, nRst, $07
	dc.b	nBb2, $05, nRst, $07, nA2, $05, nRst, $07, nA2, $05, nRst, $07
	dc.b	nBb2, $05, nRst, $01, nC3, $05, nRst, $1F, nE3, $0B, nRst, $01
	dc.b	nE3, $0B, nRst, $0D, nD3, $05, nRst, $0D, nE3, $05, nRst, $19
	dc.b	nC2, $05, nRst, $01, nG2, $05, nRst, $01, nC3, $05, nRst, $01
	dc.b	nBb2, $05, nRst, $07, nBb2, $05, nRst, $07, nA2, $05, nRst, $07
	dc.b	nA2, $05, nRst, $07, nF2, $05, nRst, $01, nC2, $05, nRst, $1F
	dc.b	nE3, $0B, nRst, $01, nE3, $0B, nRst, $0D, nD3, $05, nRst, $0D
	dc.b	nE3, $05, nRst, $19, nC2, $05, nRst, $01, nG2, $05, nRst, $01
	dc.b	nC3, $05, nRst, $01, nBb2, $05, nRst, $07, nBb2, $05, nRst, $07
	dc.b	nA2, $05, nRst, $07
	smpsSetvoice        $06
	smpsAlterNote       $FE
	smpsModSet          $0C, $01, $06, $05
	smpsPan             panLeft, $00
	dc.b	nA3, $02, nRst, $04, nBb3, $02, nRst, $04, nC4, $02, nRst, $04
	dc.b	nEb4, $02, nRst, $04, nD4, $02, nRst, $04, nBb3, $02, nRst, $04
	dc.b	nC4, $02, nRst, $10
	smpsSetvoice        $18
	smpsAlterNote       $05
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panLeft, $00
	dc.b	nG3, $0B, nRst, $01, nC4, $0B, nRst, $01, nG4, $0B, nRst, $01
	dc.b	nF4, $05, nRst, $0D, nE4, $05, nRst, $0D, nC4, $05, nRst, $07
	dc.b	nA3, $03, nRst, $01

Snd_AIZ1_Loop05:
	smpsFMAlterVol      $02
	dc.b	nA3, $03, nRst, $01, nA3, $03, nRst, $01
	smpsLoop            $00, $04, Snd_AIZ1_Loop05
	smpsFMAlterVol      $F8
	dc.b	nC4, $05, nRst, $07, nB3, $05, nRst, $0D, nC4, $05, nRst, $0D
	dc.b	nD4, $05, nRst, $07, nE4, $03, nRst, $01

Snd_AIZ1_Loop06:
	smpsFMAlterVol      $02
	dc.b	nE4, $03, nRst, $01, nE4, $03, nRst, $01
	smpsLoop            $00, $05, Snd_AIZ1_Loop06
	smpsFMAlterVol      $02
	dc.b	nE4, $03, nRst, $01
	smpsFMAlterVol      $F4
	dc.b	nA3, $03, nRst, $01

Snd_AIZ1_Loop07:
	smpsFMAlterVol      $02
	dc.b	nA3, $03, nRst, $01, nA3, $03, nRst, $01
	smpsLoop            $00, $04, Snd_AIZ1_Loop07
	smpsFMAlterVol      $F8
	dc.b	nA3, $03, nRst, $09, nF4, $05, nRst, $0D, nE4, $05, nRst, $0D
	dc.b	nD4, $05, nRst, $07, nB3, $05, nRst, $0D, nA3, $05, nRst, $0D
	dc.b	nG3, $05, nRst, $13, nG3, $0B, nRst, $01, nC4, $0B, nRst, $01
	dc.b	nG4, $0B, nRst, $01, nF4, $05, nRst, $0D, nE4, $05, nRst, $0D
	dc.b	nC4, $05, nRst, $07, nA3, $03, nRst, $01

Snd_AIZ1_Loop08:
	smpsFMAlterVol      $02
	dc.b	nA3, $03, nRst, $01, nA3, $03, nRst, $01
	smpsLoop            $00, $04, Snd_AIZ1_Loop08
	smpsFMAlterVol      $F8
	dc.b	nC4, $05, nRst, $07, nB3, $05, nRst, $0D, nC4, $05, nRst, $0D
	dc.b	nD4, $05, nRst, $07, nG4, $03, nRst, $01

Snd_AIZ1_Loop09:
	smpsFMAlterVol      $02
	dc.b	nG4, $03, nRst, $01, nG4, $03, nRst, $01
	smpsLoop            $00, $05, Snd_AIZ1_Loop09
	smpsFMAlterVol      $02
	dc.b	nG4, $03, nRst, $01
	smpsFMAlterVol      $F4
	dc.b	nE4, $03, nRst, $01
	smpsFMAlterVol      $02
	dc.b	nE4, $03, nRst, $01, nE4, $03, nRst, $01

Snd_AIZ1_Loop0A:
	smpsFMAlterVol      $02
	dc.b	nE4, $03, nRst, $01, nE4, $03, nRst, $01
	smpsLoop            $00, $03, Snd_AIZ1_Loop0A
	smpsFMAlterVol      $F8
	dc.b	nA3, $03, nRst, $09, nF4, $05, nRst, $0D, nE4, $05, nRst, $0D
	dc.b	nD4, $05, nRst, $07, nB3, $05, nRst, $0D, nA3, $05, nRst, $0D
	dc.b	nG3, $05, nRst, $07
	smpsFMAlterVol      $F8
	smpsSetvoice        $17
	smpsAlterNote       $FB
	smpsModSet          $0F, $01, $03, $05
	smpsPan             panLeft, $00
	dc.b	nE4, $0B, nRst, $07, nE4, $03, nRst, $0F
	smpsSetvoice        $16
	smpsAlterNote       $FB
	smpsModSet          $03, $01, $02, $05
	smpsPan             panRight, $00
	dc.b	nF3, $05, nRst, $01, nG3, $05, nRst, $01, nA3, $05, nRst, $0D
	dc.b	nB3, $05, nRst, $0D, nC4, $05, nRst, $07
	smpsSetvoice        $17
	smpsAlterNote       $FB
	smpsModSet          $0F, $01, $03, $05
	smpsPan             panLeft, $00
	dc.b	nE4, $0B, nRst, $07, nE4, $03, nRst, $0F
	smpsSetvoice        $16
	smpsAlterNote       $FB
	smpsModSet          $03, $01, $02, $05
	smpsPan             panRight, $00
	dc.b	nF3, $05, nRst, $01, nG3, $05, nRst, $01, nA3, $05, nRst, $0D
	dc.b	nB3, $05, nRst, $0D, nC4, $05, nRst, $07, nF2, $05, nRst, $01
	dc.b	nA2, $05, nRst, $01, nD3, $05, nRst, $01, nF3, $05, nRst, $01
	dc.b	nD3, $05, nRst, $01, nF3, $05, nRst, $01, nA3, $05, nRst, $01
	dc.b	nD4, $05, nRst, $01, nA3, $05, nRst, $01, nD4, $05, nRst, $01
	dc.b	nF4, $05, nRst, $01, nA4, $05, nRst, $01, nF4, $05, nRst, $01
	dc.b	nA4, $05, nRst, $01, nD5, $05, nRst, $01, nF5, $05, nRst, $01
	smpsSetvoice        $11
	smpsAlterNote       $FB
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nC4, $17, nRst, $01, nB3, $17, nRst, $01, nC4, $17, nRst, $01
	dc.b	nD4, $17, nRst, $01
	smpsFMAlterVol      $08
	smpsJump            Snd_AIZ1_FM4

; Unreachable
	smpsStop

; FM5 Data
Snd_AIZ1_FM5:
	smpsSetvoice        $16
	smpsAlterNote       $05
	smpsModSet          $03, $01, $02, $05
	smpsPan             panLeft, $00
	dc.b	nE3, $05, nRst, $0D, nE3, $05, nRst, $19, nE3, $05, nRst, $0D
	dc.b	nE3, $05, nRst, $19, nD3, $05, nRst, $0D, nD3, $05, nRst, $07
	smpsSetvoice        $11
	smpsAlterNote       $FB
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nBb2, $04, nRst, $02, nC3, $04, nRst, $02, nD3, $04, nRst, $08
	smpsSetvoice        $16
	smpsAlterNote       $05
	smpsModSet          $03, $01, $02, $05
	smpsPan             panLeft, $00
	dc.b	nD3, $05, nRst, $07, nD3, $05, nRst, $07, nD3, $05, nRst, $01
	dc.b	nEb3, $05, nRst, $07, nE3, $05, nRst, $0D, nE3, $05, nRst, $19
	dc.b	nE3, $05, nRst, $0D, nE3, $05, nRst, $19, nD3, $05, nRst, $0D
	dc.b	nD3, $05, nRst, $19
	smpsSetvoice        $06
	smpsAlterNote       $02
	smpsModSet          $0C, $01, $FA, $05
	smpsPan             panRight, $00
	dc.b	nD3, $02, nRst, $04, nF3, $02, nRst, $04, nD4, $02, nRst, $04
	dc.b	nC4, $18, nRst, $06
	smpsSetvoice        $16
	smpsAlterNote       $05
	smpsModSet          $03, $01, $02, $05
	smpsPan             panLeft, $00
	dc.b	nE3, $05, nRst, $0D, nE3, $05, nRst, $19, nE3, $05, nRst, $0D
	dc.b	nE3, $05, nRst, $19, nD3, $05, nRst, $0D, nD3, $05, nRst, $07
	smpsSetvoice        $11
	smpsAlterNote       $FB
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nBb2, $04, nRst, $02, nC3, $04, nRst, $02, nD3, $04, nRst, $08
	smpsSetvoice        $16
	smpsAlterNote       $05
	smpsModSet          $03, $01, $02, $05
	smpsPan             panLeft, $00
	dc.b	nD3, $05, nRst, $07, nD3, $05, nRst, $07, nD3, $05, nRst, $01
	dc.b	nEb3, $05, nRst, $07, nE3, $05, nRst, $0D, nE3, $05, nRst, $19
	dc.b	nE3, $05, nRst, $0D, nE3, $05, nRst, $19
	smpsSetvoice        $11
	smpsAlterNote       $FB
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nA3, $05, nRst, $01, nA3, $05, nRst, $01, nA3, $05, nRst, $01
	dc.b	nA3, $05, nRst, $28
	smpsFMAlterVol      $04
	smpsSetvoice        $06
	smpsAlterNote       $03
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panCenter, $00
	dc.b	nF1, $01, smpsNoAttack, nEb2, $01, smpsNoAttack, nF2, $0A, nBb1, $01, smpsNoAttack, nAb2
	dc.b	$01, smpsNoAttack, nBb2, $0A, nF2, $01, smpsNoAttack, nEb3, $01, smpsNoAttack, nF3, $0A
	dc.b	nE2, $01, smpsNoAttack, nD3, $01, smpsNoAttack, nE3, $03, nRst, $0D, nC2, $01
	dc.b	smpsNoAttack, nBb2, $01, smpsNoAttack, nC3, $03, nRst, $0D, nBb1, $01, smpsNoAttack, nAb2
	dc.b	$01, smpsNoAttack, nBb2, $39, nRst, $3D, nF1, $01, smpsNoAttack, nEb2, $01, smpsNoAttack
	dc.b	nF2, $0A, nBb1, $01, smpsNoAttack, nAb2, $01, smpsNoAttack, nBb2, $0A, nF2, $01
	dc.b	smpsNoAttack, nEb3, $01, smpsNoAttack, nF3, $0A, nE2, $01, smpsNoAttack, nD3, $01, smpsNoAttack
	dc.b	nE3, $03, nRst, $0D, nC2, $01, smpsNoAttack, nBb2, $01, smpsNoAttack, nC3, $03
	dc.b	nRst, $0D, nD2, $01, smpsNoAttack, nC3, $01, smpsNoAttack, nD3, $39, nRst, $3D
	dc.b	nF1, $01, smpsNoAttack, nEb2, $01, smpsNoAttack, nF2, $0A, nBb1, $01, smpsNoAttack, nAb2
	dc.b	$01, smpsNoAttack, nBb2, $0A, nF2, $01, smpsNoAttack, nEb3, $01, smpsNoAttack, nF3, $0A
	dc.b	nE2, $01, smpsNoAttack, nD3, $01, smpsNoAttack, nE3, $03, nRst, $0D, nC2, $01
	dc.b	smpsNoAttack, nBb2, $01, smpsNoAttack, nC3, $03, nRst, $0D, nBb2, $3B, nRst, $3D
	dc.b	nF2, $0C, nBb2, $0C, nF3, $0C, nE3, $05, nRst, $0D, nC3, $05
	dc.b	nRst, $0D, nD3, $3B, nRst, $5E
	smpsFMAlterVol      $FC
	dc.b	nRst, $0C
	smpsSetvoice        $16
	smpsAlterNote       $05
	smpsModSet          $03, $01, $02, $05
	smpsPan             panLeft, $00
	dc.b	nC3, $0B, nRst, $01, nC3, $0B, nRst, $0D, nBb2, $05, nRst, $0D
	dc.b	nC3, $05, nRst, $19
	smpsFMAlterVol      $08
	smpsSetvoice        $10
	smpsAlterNote       $05
	smpsModSet          $0F, $01, $FA, $06
	smpsPan             panLeft, $00
	dc.b	nC5, $0C, nA4, $06, nBb4, $0C, nG4, nC5, nA4, $06, nBb4, $0C
	dc.b	nG4, $24
	smpsFMAlterVol      $F8
	smpsSetvoice        $16
	smpsAlterNote       $05
	smpsModSet          $03, $01, $02, $05
	smpsPan             panLeft, $00
	dc.b	nC3, $0B, nRst, $01, nC3, $0B, nRst, $0D, nBb2, $05, nRst, $0D
	dc.b	nC3, $05, nRst, $19
	smpsFMAlterVol      $08
	smpsSetvoice        $10
	smpsAlterNote       $05
	smpsModSet          $0F, $01, $FA, $06
	smpsPan             panLeft, $00
	dc.b	nC5, $0C, nA4, $06, nBb4, $0C, nG4, nC5, nA4, $06, nBb4, $0C
	dc.b	nG4, $24
	smpsFMAlterVol      $F8
	smpsSetvoice        $16
	smpsAlterNote       $05
	smpsModSet          $03, $01, $02, $05
	smpsPan             panLeft, $00
	dc.b	nC3, $0B, nRst, $01, nC3, $0B, nRst, $0D, nBb2, $05, nRst, $0D
	dc.b	nC3, $05, nRst, $19
	smpsFMAlterVol      $08
	smpsSetvoice        $10
	smpsAlterNote       $05
	smpsModSet          $0F, $01, $FA, $06
	smpsPan             panLeft, $00
	dc.b	nC5, $0C, nA4, $06, nBb4, $0C, nG4, nC5, nA4, $06, nBb4, $0C
	dc.b	nG4, $24
	smpsFMAlterVol      $F8
	smpsSetvoice        $16
	smpsAlterNote       $05
	smpsModSet          $03, $01, $02, $05
	smpsPan             panLeft, $00
	dc.b	nC3, $0B, nRst, $01, nC3, $0B, nRst, $0D, nBb2, $05, nRst, $0D
	dc.b	nC3, $05, nRst, $19
	smpsFMAlterVol      $08
	smpsSetvoice        $10
	smpsAlterNote       $05
	smpsModSet          $0F, $01, $FA, $06
	smpsPan             panLeft, $00
	dc.b	nC5, $0C, nA4, $06, nBb4, $0C, nG4, nC5, $05, nRst, $07
	smpsFMAlterVol      $F8
	smpsSetvoice        $11
	smpsAlterNote       $FB
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nF3, $02, nRst, $04, nG3, $02, nRst, $04, nA3, $02, nRst, $04
	dc.b	nC4, $02, nRst, $04, nBb3, $02, nRst, $04, nG3, $02, nRst, $04
	dc.b	nA3, $02, nRst, $04
	smpsSetvoice        $10
	smpsAlterNote       $05
	smpsModSet          $0F, $01, $FA, $06
	smpsPan             panLeft, $00
	dc.b	nRst, $0C, nG4, $0B, nRst, $01, nC5, $0B, nRst, $01, nG5, $0B
	dc.b	nRst, $01, nF5, $11, nRst, $01, nE5, $11, nRst, $01, nC5, $0B
	dc.b	nRst, $01, nA4, $23, nRst, $01, nC5, $0B, nRst, $01, nB4, $11
	dc.b	nRst, $01, nC5, $11, nRst, $01, nD5, $0B, nRst, $01, nE5, $2F
	dc.b	nRst, $01, nA4, $23, nRst, $01, nA4, $0B, nRst, $01, nF5, $11
	dc.b	nRst, $01, nE5, $11, nRst, $01, nD5, $0B, nRst, $01, nB4, $11
	dc.b	nRst, $01, nA4, $11, nRst, $01, nG4, $17, nRst, $01, nG4, $0B
	dc.b	nRst, $01, nC5, $0B, nRst, $01, nG5, $0B, nRst, $01, nF5, $11
	dc.b	nRst, $01, nE5, $11, nRst, $01, nC5, $0B, nRst, $01, nA4, $23
	dc.b	nRst, $01, nC5, $0B, nRst, $01, nB4, $11, nRst, $01, nC5, $11
	dc.b	nRst, $01, nD5, $0B, nRst, $01, nG5, $2F, nRst, $01, nE5, $23
	dc.b	nRst, $01, nA4, $0B, nRst, $01, nF5, $11, nRst, $01, nE5, $11
	dc.b	nRst, $01, nD5, $0B, nRst, $01, nB4, $11, nRst, $01, nA4, $11
	dc.b	nRst, $01, nG4, $0B, nRst, $01
	smpsSetvoice        $17
	smpsAlterNote       $05
	smpsModSet          $0F, $01, $03, $05
	smpsPan             panRight, $00
	dc.b	nC4, $0B, nRst, $07, nC4, $03, nRst, $0F
	smpsSetvoice        $16
	smpsAlterNote       $05
	smpsModSet          $03, $01, $02, $05
	smpsPan             panLeft, $00
	dc.b	nD3, $05, nRst, $01, nE3, $05, nRst, $01, nF3, $05, nRst, $0D
	dc.b	nG3, $05, nRst, $0D, nA3, $05, nRst, $07
	smpsSetvoice        $17
	smpsAlterNote       $05
	smpsModSet          $0F, $01, $03, $05
	smpsPan             panRight, $00
	dc.b	nC4, $0B, nRst, $07, nC4, $03, nRst, $0F
	smpsSetvoice        $16
	smpsAlterNote       $05
	smpsModSet          $03, $01, $02, $05
	smpsPan             panLeft, $00
	dc.b	nD3, $05, nRst, $01, nE3, $05, nRst, $01, nF3, $05, nRst, $0D
	dc.b	nG3, $05, nRst, $0D, nA3, $05, nRst, $07
	smpsSetvoice        $10
	smpsAlterNote       $05
	smpsModSet          $0F, $01, $FA, $06
	smpsPan             panLeft, $00
	dc.b	nD5, $24, nD5, $06, nE5, nF5, $12, nE5, nD5, $0C, nG5, $60
	smpsJump            Snd_AIZ1_FM5

; Unreachable
	smpsStop

; PSG1 Data
Snd_AIZ1_PSG1:
	dc.b	nG3, $05, nRst, $0D, nG3, $05, nRst, $19, nG3, $05, nRst, $0D
	dc.b	nG3, $05, nRst, $19, nF3, $05, nRst, $0D, nF3, $05, nRst, $07
	dc.b	nD3, $02, nRst, $04, nE3, $02, nRst, $04, nF3, $02, nRst, $0A
	dc.b	nF3, $05, nRst, $07, nF3, $05, nRst, $07, nF3, $05, nRst, $01
	dc.b	nFs3, $05, nRst, $07, nG3, $05, nRst, $0D, nG3, $05, nRst, $19
	dc.b	nG3, $05, nRst, $0D, nG3, $05, nRst, $19, nC4, $03, nRst, nC4
	dc.b	nRst, nC5, nRst, nC4, nRst, nBb4, nRst, nC4, nRst, nBb4, nRst, nC5
	dc.b	nRst, nF4, $02, nRst, $04, nBb4, $02, nRst, $04, nF5, $02, nRst
	dc.b	$04, nE5, $1D, nRst, $01, nG3, $05, nRst, $0D, nG3, $05, nRst
	dc.b	$19, nG3, $05, nRst, $0D, nG3, $05, nRst, $19, nF3, $05, nRst
	dc.b	$0D, nF3, $05, nRst, $07, nD3, $02, nRst, $04, nE3, $02, nRst
	dc.b	$04, nF3, $02, nRst, $0A, nF3, $05, nRst, $07, nF3, $05, nRst
	dc.b	$07, nF3, $05, nRst, $01, nFs3, $05, nRst, $07, nG3, $05, nRst
	dc.b	$0D, nG3, $05, nRst, $19, nG3, $05, nRst, $0D, nG3, $05, nRst
	dc.b	$19, nC6, $05, nRst, $01, nC6, $05, nRst, $01, nC6, $05, nRst
	dc.b	$01, nC6, $05, nRst, $55, nD3, $02, nRst, $0A, nE3, $02, nRst
	dc.b	$16, nD3, $11, nRst, $01, nE3, $02, nRst, $28, nA4, $05, nRst
	dc.b	$01, nBb4, $05, nRst, $07, nBb4, $02, nRst, $04, nBb4, $02, nRst
	dc.b	$04, nBb4, $02, nRst, $04, nBb4, $02, nRst, $0A, nA4, $23, nRst
	dc.b	$0D, nD3, $02, nRst, $0A, nE3, $02, nRst, $16, nD3, $11, nRst
	dc.b	$01, nE3, $02, nRst, $28, nA4, $05, nRst, $01, nBb4, $05, nRst
	dc.b	$07, nBb4, $02, nRst, $04, nBb4, $02, nRst, $04, nBb4, $02, nRst
	dc.b	$04, nBb4, $02, nRst, $0A, nC5, $05, nRst, $01, nBb4, $1D, nRst
	dc.b	$0D, nD3, $02, nRst, $0A, nE3, $02, nRst, $16, nD3, $11, nRst
	dc.b	$01, nE3, $02, nRst, $28, nA4, $05, nRst, $01, nBb4, $05, nRst
	dc.b	$07, nBb4, $02, nRst, $04, nBb4, $02, nRst, $04, nBb4, $02, nRst
	dc.b	$04, nBb4, $02, nRst, $0A, nA4, $23, nRst, $0D, nD3, $02, nRst
	dc.b	$0A, nE3, $02, nRst, $16, nD3, $11, nRst, $01, nE3, $02, nRst
	dc.b	$28, nA4, $05, nRst, $01, nBb4, $05, nRst, $07, nBb4, $02, nRst
	dc.b	$04, nBb4, $02, nRst, $04, nBb4, $02, nRst, $04, nBb4, $02, nRst
	dc.b	$0A, nC5, $05, nRst, $01, nBb4, $1D, nRst, $0D, nC3, $0B, nRst
	dc.b	$01, nC3, $0B, nRst, $0D, nBb2, $05, nRst, $0D, nC3, $05, nRst
	dc.b	$19, nC5, $0C, nA4, $06, nBb4, $0C, nG4, nC5, nA4, $06, nBb4
	dc.b	$0C, nG4, $24, nC3, $0B, nRst, $01, nC3, $0B, nRst, $0D, nBb2
	dc.b	$05, nRst, $0D, nC3, $05, nRst, $19, nC5, $0C, nA4, $06, nBb4
	dc.b	$0C, nG4, nC5, nA4, $06, nBb4, $0C, nG4, $24, nC3, $0B, nRst
	dc.b	$01, nC3, $0B, nRst, $0D, nBb2, $05, nRst, $0D, nC3, $05, nRst
	dc.b	$19, nC5, $0C, nA4, $06, nBb4, $0C, nG4, nC5, nA4, $06, nBb4
	dc.b	$0C, nG4, $24, nC3, $0B, nRst, $01, nC3, $0B, nRst, $0D, nBb2
	dc.b	$05, nRst, $0D, nC3, $05, nRst, $19, nC5, $0C, nA4, $06, nBb4
	dc.b	$0C, nG4, nC5, nF3, $02, nRst, $04, nG3, $02, nRst, $04, nA3
	dc.b	$02, nRst, $04, nC4, $02, nRst, $04, nBb3, $02, nRst, $04, nG3
	dc.b	$02, nRst, $04, nA3, $02, nRst, $04, nD5, $03, nRst, nB4, nRst
	dc.b	nG4, nRst, nE4, nRst, nD4, nRst, nB3, nRst, nG3, nRst, nE3, nRst
	dc.b	nC5, nRst, nB4, nRst, nG4, nRst, nE4, nRst, nC4, nRst, nB3, nRst
	dc.b	nG3, nRst, nE3, nRst, nC5, nRst, nA4, nRst, nF4, nRst, nD4, nRst
	dc.b	nC4, nRst, nA3, nRst, nF3, nRst, nD3, nRst, nB4, nRst, nA4, nRst
	dc.b	nF4, nRst, nD4, nRst, nB3, nRst, nA3, nRst, nF3, nRst, nD3, nRst
	dc.b	$0F, nG3, $0B, nRst, $01, nD4, $0B, nRst, $01, nG4, $0B, nRst
	dc.b	$01, nF4, $05, nRst, $0D, nE4, $05, nRst, $0D, nC4, $05, nRst
	dc.b	$07, nA3, $2F, nRst, $01, nD4, $05, nRst, $0D, nC4, $05, nRst
	dc.b	$0D, nB3, $05, nRst, $07, nD5, $03, nRst, nB4, nRst, nG4, nRst
	dc.b	nE4, nRst, nD4, nRst, nB3, nRst, nG3, nRst, nE3, nRst, nC5, nRst
	dc.b	nB4, nRst, nG4, nRst, nE4, nRst, nC4, nRst, nB3, nRst, nG3, nRst
	dc.b	nE3, nRst, nC5, nRst, nA4, nRst, nF4, nRst, nD4, nRst, nC4, nRst
	dc.b	nA3, nRst, nF3, nRst, nD3, nRst, nB4, nRst, nA4, nRst, nF4, nRst
	dc.b	nD4, nRst, nB3, nRst, nA3, nRst, nF3, nRst, nD3, nRst, nG4, $2F
	dc.b	nRst, $01, nE4, $23, nRst, $01, nA3, $0B, nRst, $01, nF4, $11
	dc.b	nRst, $01, nE4, $11, nRst, $01, nD4, $0B, nRst, $01, nB3, $11
	dc.b	nRst, $01, nA3, $11, nRst, $01, nG3, $0B, nRst, $01, nE4, $0B
	dc.b	nRst, $07, nE4, $03, nRst, $0F, nA3, $02, nRst, $04, nB3, $02
	dc.b	nRst, $04, nC4, $11, nRst, $01, nB3, $11, nRst, $01, nA3, $0B
	dc.b	nRst, $01, nE4, $0B, nRst, $07, nE4, $03, nRst, $0F, nF3, $02
	dc.b	nRst, $04, nG3, $02, nRst, $04, nA3, $11, nRst, $01, nG3, $11
	dc.b	nRst, $01, nF3, $0B, nRst, $01, nF2, $05, nRst, $01, nA2, $05
	dc.b	nRst, $01, nD3, $05, nRst, $01, nF3, $05, nRst, $01, nD3, $05
	dc.b	nRst, $01, nF3, $05, nRst, $01, nA3, $05, nRst, $01, nD4, $05
	dc.b	nRst, $01, nA3, $05, nRst, $01, nD4, $05, nRst, $01, nF4, $05
	dc.b	nRst, $01, nA4, $05, nRst, $01, nF4, $05, nRst, $01, nA4, $05
	dc.b	nRst, $01, nD5, $05, nRst, $01, nF5, $05, nRst, $01, nC4, $17
	dc.b	nRst, $01, nB3, $17, nRst, $01, nC4, $17, nRst, $01, nD4, $17
	dc.b	nRst, $01
	smpsJump            Snd_AIZ1_PSG1

; Unreachable
	smpsStop

; PSG2 Data
Snd_AIZ1_PSG2:
	dc.b	nE3, $05, nRst, $0D, nE3, $05, nRst, $19, nE3, $05, nRst, $0D
	dc.b	nE3, $05, nRst, $19, nD3, $05, nRst, $0D, nD3, $05, nRst, $07
	dc.b	nBb2, $02, nRst, $04, nC3, $02, nRst, $04, nD3, $02, nRst, $0A
	dc.b	nD3, $05, nRst, $07, nD3, $05, nRst, $07, nD3, $05, nRst, $01
	dc.b	nEb3, $05, nRst, $07, nE3, $05, nRst, $0D, nE3, $05, nRst, $19
	dc.b	nE3, $05, nRst, $0D, nE3, $05, nRst, $19, nC4, $03, nRst, nC4
	dc.b	nRst, nC5, nRst, nC4, nRst, nBb4, nRst, nC4, nRst, nBb4, nRst, nC5
	dc.b	nRst, nF4, $02, nRst, $04, nBb4, $02, nRst, $04, nF5, $02, nRst
	dc.b	$04, nE5, $1D, nRst, $01, nE3, $05, nRst, $0D, nE3, $05, nRst
	dc.b	$19, nE3, $05, nRst, $0D, nE3, $05, nRst, $19, nD3, $05, nRst
	dc.b	$0D, nD3, $05, nRst, $07, nBb2, $02, nRst, $04, nC3, $02, nRst
	dc.b	$04, nD3, $02, nRst, $0A, nD3, $05, nRst, $07, nD3, $05, nRst
	dc.b	$07, nD3, $05, nRst, $01, nEb3, $05, nRst, $07, nE3, $05, nRst
	dc.b	$0D, nE3, $05, nRst, $19, nE3, $05, nRst, $0D, nE3, $05, nRst
	dc.b	$19, nA4, $05, nRst, $01, nA4, $05, nRst, $01, nA4, $05, nRst
	dc.b	$01, nA4, $05, nRst, $55, nBb2, $02, nRst, $0A, nC3, $02, nRst
	dc.b	$16, nBb2, $11, nRst, $01, nC3, $02, nRst, $28, nFs4, $05, nRst
	dc.b	$01, nG4, $05, nRst, $07, nG4, $02, nRst, $04, nG4, $02, nRst
	dc.b	$04, nG4, $02, nRst, $04, nG4, $02, nRst, $0A, nF4, $23, nRst
	dc.b	$0D, nBb2, $02, nRst, $0A, nC3, $02, nRst, $16, nBb2, $11, nRst
	dc.b	$01, nC3, $02, nRst, $28, nFs4, $05, nRst, $01, nG4, $05, nRst
	dc.b	$07, nG4, $02, nRst, $04, nG4, $02, nRst, $04, nG4, $02, nRst
	dc.b	$04, nG4, $02, nRst, $0A, nA4, $05, nRst, $01, nG4, $1D, nRst
	dc.b	$0D, nBb2, $02, nRst, $0A, nC3, $02, nRst, $16, nBb2, $11, nRst
	dc.b	$01, nC3, $02, nRst, $28, nFs4, $05, nRst, $01, nG4, $05, nRst
	dc.b	$07, nG4, $02, nRst, $04, nG4, $02, nRst, $04, nG4, $02, nRst
	dc.b	$04, nG4, $02, nRst, $0A, nF4, $23, nRst, $0D, nBb2, $02, nRst
	dc.b	$0A, nC3, $02, nRst, $16, nBb2, $11, nRst, $01, nC3, $02, nRst
	dc.b	$28, nFs4, $05, nRst, $01, nG4, $05, nRst, $07, nG4, $02, nRst
	dc.b	$04, nG4, $02, nRst, $04, nG4, $02, nRst, $04, nG4, $02, nRst
	dc.b	$0A, nA4, $05, nRst, $01, nG4, $1D, nRst, $0D, nC3, $0B, nRst
	dc.b	$01, nC3, $0B, nRst, $0D, nBb2, $05, nRst, $0D, nC3, $05, nRst
	dc.b	$19, nC5, $0C, nA4, $06, nBb4, $0C, nG4, nC5, nA4, $06, nBb4
	dc.b	$0C, nG4, $24, nC3, $0B, nRst, $01, nC3, $0B, nRst, $0D, nBb2
	dc.b	$05, nRst, $0D, nC3, $05, nRst, $19, nC5, $0C, nA4, $06, nBb4
	dc.b	$0C, nG4, nC5, nA4, $06, nBb4, $0C, nG4, $24, nC3, $0B, nRst
	dc.b	$01, nC3, $0B, nRst, $0D, nBb2, $05, nRst, $0D, nC3, $05, nRst
	dc.b	$19, nC5, $0C, nA4, $06, nBb4, $0C, nG4, nC5, nA4, $06, nBb4
	dc.b	$0C, nG4, $24, nC3, $0B, nRst, $01, nC3, $0B, nRst, $0D, nBb2
	dc.b	$05, nRst, $0D, nC3, $05, nRst, $19, nC5, $0C, nA4, $06, nBb4
	dc.b	$0C, nG4, nC5, nF3, $02, nRst, $04, nG3, $02, nRst, $04, nA3
	dc.b	$02, nRst, $04, nC4, $02, nRst, $04, nBb3, $02, nRst, $04, nG3
	dc.b	$02, nRst, $04, nA3, $02, nRst, $04, nD5, $03, nRst, nB4, nRst
	dc.b	nG4, nRst, nE4, nRst, nD4, nRst, nB3, nRst, nG3, nRst, nE3, nRst
	dc.b	nC5, nRst, nB4, nRst, nG4, nRst, nE4, nRst, nC4, nRst, nB3, nRst
	dc.b	nG3, nRst, nE3, nRst, nC5, nRst, nA4, nRst, nF4, nRst, nD4, nRst
	dc.b	nC4, nRst, nA3, nRst, nF3, nRst, nD3, nRst, nB4, nRst, nA4, nRst
	dc.b	nF4, nRst, nD4, nRst, nB3, nRst, nA3, nRst, nF3, nRst, nD3, nRst
	dc.b	$15
	smpsFMAlterVol      $0A, $AC
	dc.b	$0B, nRst, $01, nD4, $0B, nRst, $01, nG4, $0B, nRst, $01, nF4
	dc.b	$05, nRst, $0D, nE4, $05, nRst, $0D, nC4, $05, nRst, $07, nA3
	dc.b	$2F, nRst, $01, nD4, $05, nRst, $0D, nC4, $05, nRst, $0D, nB3
	dc.b	$05, nRst, $01
	smpsFMAlterVol      $F6, $BF
	dc.b	$03, nRst, nB4, nRst, nG4, nRst, nE4, nRst, nD4, nRst, nB3, nRst
	dc.b	nG3, nRst, nE3, nRst, nC5, nRst, nB4, nRst, nG4, nRst, nE4, nRst
	dc.b	nC4, nRst, nB3, nRst, nG3, nRst, nE3, nRst, nC5, nRst, nA4, nRst
	dc.b	nF4, nRst, nD4, nRst, nC4, nRst, nA3, nRst, nF3, nRst, nD3, nRst
	dc.b	nB4, nRst, nA4, nRst, nF4, nRst, nD4, nRst, nB3, nRst, nA3, nRst
	dc.b	nF3, nRst, nD3, nRst, $09, nG4, $2F, nRst, $01, nE4, $23, nRst
	dc.b	$01, nA3, $0B, nRst, $01, nF4, $11, nRst, $01, nE4, $11, nRst
	dc.b	$01, nD4, $0B, nRst, $01, nB3, $11, nRst, $01, nA3, $11, nRst
	dc.b	$01, nG3, $06, nC4, $0B, nRst, $07, nC4, $03, nRst, $0F, nA3
	dc.b	$02, nRst, $04, nB3, $02, nRst, $04, nC4, $11, nRst, $01, nB3
	dc.b	$11, nRst, $01, nA3, $0B, nRst, $01, nC4, $0B, nRst, $07, nC4
	dc.b	$03, nRst, $0F, nF3, $02, nRst, $04, nG3, $02, nRst, $04, nA3
	dc.b	$11, nRst, $01, nG3, $11, nRst, $01, nF3, $0B, nRst, $01, nF2
	dc.b	$05, nRst, $01, nA2, $05, nRst, $01, nD3, $05, nRst, $01, nF3
	dc.b	$05, nRst, $01, nD3, $05, nRst, $01, nF3, $05, nRst, $01, nA3
	dc.b	$05, nRst, $01, nD4, $05, nRst, $01, nA3, $05, nRst, $01, nD4
	dc.b	$05, nRst, $01, nF4, $05, nRst, $01, nA4, $05, nRst, $01, nF4
	dc.b	$05, nRst, $01, nA4, $05, nRst, $01, nD5, $05, nRst, $01, nF5
	dc.b	$05, nRst, $01, nC4, $17, nRst, $01, nB3, $17, nRst, $01, nC4
	dc.b	$17, nRst, $01, nD4, $17, nRst, $01
	smpsJump            Snd_AIZ1_PSG2

; Unreachable
	smpsStop

; PSG3 Data
Snd_AIZ1_PSG3:
	smpsPSGvoice        sTone_02
	smpsPSGform         $E7
	dc.b	nMaxPSG1, $06, nMaxPSG1
	smpsPSGvoice        sTone_04
	dc.b	nMaxPSG1, $0C
	smpsPSGvoice        sTone_01

Snd_AIZ1_Loop0B:
	dc.b	nMaxPSG1, $06, nMaxPSG1
	smpsPSGvoice        sTone_04
	dc.b	nMaxPSG1, $0C
	smpsPSGvoice        sTone_01
	smpsLoop            $01, $1A, Snd_AIZ1_Loop0B
	dc.b	nMaxPSG1, $06, nMaxPSG1, nA6, $6C

Snd_AIZ1_Loop0C:
	dc.b	nMaxPSG1, $06, nMaxPSG1
	smpsPSGvoice        sTone_04
	dc.b	nMaxPSG1, $0C
	smpsPSGvoice        sTone_01
	smpsLoop            $01, $1B, Snd_AIZ1_Loop0C
	dc.b	nMaxPSG1, $06, nMaxPSG1, nA6, $6C

Snd_AIZ1_Loop0D:
	dc.b	nMaxPSG1, $06, nMaxPSG1
	smpsPSGvoice        sTone_04
	dc.b	nMaxPSG1, $0C
	smpsPSGvoice        sTone_01
	smpsLoop            $01, $4C, Snd_AIZ1_Loop0D
	dc.b	nRst, $60
	smpsJump            Snd_AIZ1_PSG3
