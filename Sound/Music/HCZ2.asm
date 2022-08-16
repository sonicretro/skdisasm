Snd_HCZ2_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoiceUVB
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $25

	smpsHeaderDAC       Snd_HCZ2_DAC
	smpsHeaderFM        Snd_HCZ2_FM1,	$18, $0F
	smpsHeaderFM        Snd_HCZ2_FM2,	$18, $0A
	smpsHeaderFM        Snd_HCZ2_FM3,	$18, $13
	smpsHeaderFM        Snd_HCZ2_FM4,	$0C, $0F
	smpsHeaderFM        Snd_HCZ2_FM5,	$0C, $0C
	smpsHeaderPSG       Snd_HCZ2_PSG1,	$F4, $04, $00, sTone_0C
	smpsHeaderPSG       Snd_HCZ2_PSG2,	$F4, $04, $00, sTone_0C
	smpsHeaderPSG       Snd_HCZ2_PSG3,	$00, $03, $00, sTone_0C

; Unreachable
	smpsStop
	smpsStop

; DAC Data
Snd_HCZ2_DAC:
	dc.b	dKickS3, $06
	smpsPan             panLeft, $00
	dc.b	dHighTom, $02, dHighTom, $04, dHighTom, $06, dHighTom, dHighTom, dHighTom
	smpsPan             panCenter, $00
	dc.b	dMidTomS3, dMidTomS3, dMidTomS3, dMidTomS3, dMidTomS3, dLowTomS3
	smpsPan             panRight, $00
	dc.b	dLowTomS3, $02, dLowTomS3, $04, dLowTomS3, $06, dFloorTomS3, dFloorTomS3
	smpsPan             panCenter, $00
	dc.b	dKickS3, $0C, dSnareS3, $1E, dKickS3, $0C, dKickS3, $12, dKickS3, $0C, dSnareS3
	smpsLoop            $00, $02, Snd_HCZ2_DAC

Snd_HCZ2_Loop00:
	dc.b	dKickS3, $18, dSnareS3, $06, dKickS3, $0C, dKickS3, dKickS3, $12, dSnareS3, $0C, dKickS3
	smpsLoop            $00, $03, Snd_HCZ2_Loop00
	dc.b	dKickS3, $24, dSnareS3, $06, dKickS3, $0C, dKickS3, $12, dKickS3, $0C, dSnareS3

Snd_HCZ2_Loop01:
	dc.b	dKickS3, $18, dSnareS3, $06, dKickS3, $0C, dKickS3, dKickS3, $12, dSnareS3, $0C, dKickS3
	smpsLoop            $00, $02, Snd_HCZ2_Loop01
	dc.b	dKickS3, $18, dSnareS3, $06, dKickS3, $0C, dKickS3, dKickS3, $12, dSnareS3, $0C, dKickS3
	dc.b	$06, dSnareS3, $0C, dKickS3, dKickS3, $06, dHighTom, dMidTomS3, dLowTomS3, dSnareS3, $18, $0C
	dc.b	$02, $04, $06, dSnareS3
	smpsCall            Snd_HCZ2_Call00
	dc.b	dKickS3, $18, dSnareS3, $06, dKickS3, $0C, dKickS3, $1E, dSnareS3, $0C, dKickS3, $12
	dc.b	dSnareS3, dSnareS3, $0C, dSnareS3, $06, dSnareS3, $0C, dSnareS3, $12, dSnareS3, $06, dSnareS3
	dc.b	dSnareS3, dSnareS3
	smpsCall            Snd_HCZ2_Call00
	dc.b	dKickS3, $18, dSnareS3, $06, dKickS3, $0C, dKickS3, $1E, dSnareS3, $0C, dKickS3, $06
	dc.b	dKickS3, $0C, dKickS3, dKickS3, $06, dSnareS3, dKickS3, dKickS3, dSnareS3, dKickS3, dKickS3, $0C
	dc.b	dSnareS3, dSnareS3, $06, dSnareS3, dSnareS3

Snd_HCZ2_Loop02:
	smpsCall            Snd_HCZ2_Call01
	smpsLoop            $00, $02, Snd_HCZ2_Loop02
	smpsCall            Snd_HCZ2_Call01
	dc.b	dKickS3, $0C, dSnareS3, dKickS3, $06, dSnareS3, $0C, $06, dKickS3, dSnareS3, $12, $04
	dc.b	dSnareS3, dSnareS3, dSnareS3, $06, dSnareS3

Snd_HCZ2_Loop03:
	smpsCall            Snd_HCZ2_Call01
	smpsLoop            $00, $02, Snd_HCZ2_Loop03
	dc.b	dKickS3, $12, $06, dSnareS3, $1E, dKickS3, $06, $0C, dSnareS3, $1E, $0C, $0C
	dc.b	$06, $0C, $18, $02, $02, $02, $06, $06, $06
	smpsJump            Snd_HCZ2_DAC

; Unreachable
	smpsStop

Snd_HCZ2_Call00:
	dc.b	dKickS3, $18, dSnareS3, $06, dKickS3, $0C, dKickS3, $1E, dSnareS3, $0C, dKickS3, dKickS3
	dc.b	$18, dSnareS3, $06, dKickS3, $0C, dKickS3, $1E, dSnareS3, $0C, dKickS3
	smpsReturn

Snd_HCZ2_Call01:
	dc.b	dKickS3, $12, dKickS3, $06, dSnareS3, $1E, dKickS3, $06, dKickS3, $0C, dSnareS3, $18
	smpsReturn

; FM1 Data
Snd_HCZ2_FM1:
	smpsSetvoice        $03
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsCall            Snd_HCZ2_Call02
	smpsSetvoice        $0E
	smpsAlterNote       $01
	smpsModSet          $0F, $01, $06, $06
	smpsCall            Snd_HCZ2_Call03
	smpsSetvoice        $03
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsCall            Snd_HCZ2_Call04
	smpsJump            Snd_HCZ2_FM1

Snd_HCZ2_Call02:
	dc.b	nRst, $7F, nRst, nRst, $76, nG4, $06, nBb4, nC5, nG4, nF4, $02
	dc.b	nEb4, nD4, nC4, nBb3, nA3, nG3, nRst, $04, nBb3, $06, nC4, nG3
	dc.b	nF3, $02, nFs3, $04, nF3, $06, nEb3, nC3, nG3, $02, nA3, nBb3
	dc.b	$08, nBb3, $02, nBb3, $04, nA3, $12, nG3, $02, nFs3, nF3, nEb3
	dc.b	nD3, nC3, nBb2, nA2, nG2, nRst, $36, nBb3, $06, nB3, nC4, nFs3
	dc.b	$02, nG3, $04, nF3, $02, nEb3, nC3, nBb2, nA2, nG2, nF2, nEb2
	dc.b	$04, nF3, $02, nFs3, $04, nF3, $06, nEb3, nF3, nEb3, nC3, nBb2
	dc.b	nG3, $0C, nG3, $06, nC4, $12, nA3, $02, nG3, nF3, nEb3, nD3
	dc.b	nC3, nRst, $3C, nG4, $06, nBb4, nC5, nG4, nF4, $02, nEb4, nD4
	dc.b	nC4, nBb3, nA3, nG3, nRst, $04, nBb3, $06, nC4, nG3, nF3, $02
	dc.b	nFs3, $04, nF3, $06, nEb3, nC3, nG3, $02, nA3, nBb3, $08, nBb3
	dc.b	$02, nBb3, $04, nA3, $12, nG3, $02, nF3, nEb3, nD3, nC3, nBb2
	dc.b	nA2, nG2, nF2, nRst, $36, nBb3, $06, nB3, nC4, nFs3, $02, nG3
	dc.b	$04, nF3, $02, nEb3, nC3, nBb2, nA2, nG2, nF2, nEb2, $04, nF3
	dc.b	$02, nFs3, $04, nF3, $06, nEb3, nF3, nEb3, nC3, nBb2, nG3, $0C
	dc.b	nG3, $06, nEb3, $12, nD3, $02, nC3, nBb2, nA2, nG2, nF2, nRst
	dc.b	$1E
	smpsReturn

Snd_HCZ2_Call03:
	smpsAlterPitch      $F4
	dc.b	nF3, $06, nFs3, $02, nG3, $04, nBb3, $06, nEb4, nF4, nG4, nBb4
	dc.b	nD5, $02, nEb5, $08, nRst, $02, nF5, $04, nRst, $02, nFs5, nG5
	dc.b	$08, nRst, $02, nC5, $0A, nRst, $02, nFs5, nG5, $26, nRst, $02
	dc.b	nF5, $04, nRst, $02, nEb5, $04, nRst, $02, nCs5, nD5, $26, nRst
	dc.b	$02, nBb4, $34, nRst, $02, nCs5, nD5, $08, nRst, $02, nEb5, $04
	dc.b	nRst, $02, nE5, nF5, $08, nRst, $02, nBb4, $0A, nRst, $02, nF5
	dc.b	nF5, $26, nRst, $02, nEb5, $04, nRst, $02, nD5, $04, nRst, $02
	dc.b	nC5, $2E, nRst, $08, nD5, $10, nRst, $02, nEb5, $0A, nRst, $02
	dc.b	nF5, $0A, nRst, $02, nD5, nEb5, $08, nRst, $02, nF5, $04, nRst
	dc.b	$02, nFs5, nG5, $08, nRst, $02, nC5, $0A, nRst, $02, nG5, $28
	dc.b	nRst, $02, nF5, $04, nRst, $02, nEb5, $04, nRst, $02, nCs5, nD5
	dc.b	$26, nRst, $02, nEb5, $1C, nRst, $0E, nEb5, $04, nRst, $02, nF5
	dc.b	$04, nRst, $02, nFs5, nG5, $08, nRst, $02, nEb5, $04, nRst, $02
	dc.b	nG5, $0A, nRst, $02, nBb4, $0A, nRst, $02, nC5, $28, nRst, $02
	dc.b	nEb5, $04, nRst, $02, nF5, $04, nRst, $02, nG5, $2E, nRst, $02
	dc.b	nF5, $12, nEb5, $02, nD5, nC5, nBb4, nAb4, nG4, nF4, nEb4, nD4
	smpsReturn

Snd_HCZ2_Call04:
	smpsAlterPitch      $0C
	dc.b	nC4, $04, nRst, $02, nD4, $04, nRst, $02, nEb4, $0C, nD4, $02
	dc.b	nC4, nBb3, nAb3, nG3, nF3, nC4, $0A, nRst, $02, nEb4, $04, nRst
	dc.b	$02, nE4, nF4, nRst, $08, nD4, $10, nRst, $02, nC4, $04, nRst
	dc.b	$08, nBb3, $04, nRst, $08, nFs3, $02, nG3, $14, nRst, $02, nFs3
	dc.b	nG3, $08, nRst, $02, nF3, $04, nRst, $02, nFs3, nG3, $28, nC4
	dc.b	$04, nRst, $02, nD4, $04, nRst, $02, nEb4, $0C, nD4, $02, nC4
	dc.b	nBb3, nAb3, nG3, nF3, nC4, $0A, nRst, $02, nEb4, $04, nRst, $02
	dc.b	nE4, nF4, nRst, $08, nD4, $10, nRst, $02, nC4, $04, nRst, $08
	dc.b	nB3, $04, nRst, $08, nC4, $10, nRst, $02, nC4, $04, nRst, $02
	dc.b	nD4, $0A, nRst, $02, nC4, $04, nRst, $02, nD4, $04, nRst, $08
	dc.b	nEb4, $10, nRst, $02, nF4, $0A, nRst, $02, nC4, $04, nRst, $02
	dc.b	nD4, $04, nRst, $02, nEb4, $0C, nD4, $02, nC4, nBb3, nAb3, nG3
	dc.b	nF3, nC4, $0A, nRst, $02, nEb4, $04, nRst, $02, nE4, nF4, nRst
	dc.b	$08, nD4, $10, nRst, $02, nC4, $04, nRst, $08, nBb3, $04, nRst
	dc.b	$08, nFs3, $02, nG3, $14, nRst, $02, nFs3, nG3, $08, nRst, $02
	dc.b	nF3, $04, nRst, $02, nFs3, nG3, $28, nC4, $04, nRst, $02, nD4
	dc.b	$04, nRst, $02, nEb4, $10, nRst, $02, nEb4, $04, nRst, $08, nD4
	dc.b	$04, nRst, $02, nEb4, $10, nRst, $02, nEb4, $04, nRst, $02, nF4
	dc.b	$0A, nRst, $02, nEb4, $04, nRst, $08, nAb4, $04, nRst, $0E, nC5
	dc.b	$04, nRst, $08, nC5, $04, nRst, $08, nC5, $04, nRst, $02, nC5
	dc.b	$0A, nRst, $02, nB4, $04, nRst, $2C
	smpsReturn

; Unreachable
	smpsStop

; FM2 Data
Snd_HCZ2_FM2:
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $0F, $01, $06, $06
	dc.b	nC1, $0A, nRst, $02, nEb1, nRst, $04, nC1, $10, nRst, $02, nEb1
	dc.b	nRst, $04, nF1, nRst, $08, nEb1, $10, nRst, $02, nF1, $16, nRst
	dc.b	$02, nC1, $0A, nRst, $02, nA0, nRst, $04, nC1, $12, nA0, $04
	dc.b	nRst, $02, nBb0, $04, nRst, $08, nG0, $10, nRst, $02, nBb0, $16
	dc.b	nRst, $02, nC1, $0A, nRst, $02, nEb1, nRst, $04, nC1, $10, nRst
	dc.b	$02, nEb1, nRst, $04, nF1, nRst, $08, nEb1, $10, nRst, $02, nF1
	dc.b	$16, nRst, $02, nC1, $0A, nRst, $02, nA0, nRst, $04, nC1, $12
	dc.b	nA0, $04, nRst, $02, nBb0, $04, nRst, $08, nG0, $10, nRst, $02
	dc.b	nBb0, $16, nRst, $02, nC1, $0A, nRst, $02, nEb1, nRst, $04, nC1
	dc.b	$10, nRst, $02, nEb1, nRst, $04, nF1, nRst, $08, nEb1, $10, nRst
	dc.b	$02, nF1, $16, nRst, $02, nC1, $0A, nRst, $02, nA0, nRst, $04
	dc.b	nC1, $12, nA0, $04, nRst, $02, nBb0, $04, nRst, $08, nG0, $10
	dc.b	nRst, $02, nBb0, $16, nRst, $02, nC1, $0A, nRst, $02, nEb1, nRst
	dc.b	$04, nC1, $10, nRst, $02, nEb1, nRst, $04, nF1, nRst, $08, nEb1
	dc.b	$10, nRst, $02, nF1, $16, nRst, $02, nC1, $0A, nRst, $02, nA0
	dc.b	nRst, $04, nC1, $12, nA0, $04, nRst, $02, nBb0, $04, nRst, $08
	dc.b	nG0, $10, nRst, $02, nBb0, $16, nRst, $02, nC1, $0A, nRst, $02
	dc.b	nEb1, nRst, $04, nC1, $10, nRst, $02, nEb1, $04, nRst, $02, nF1
	dc.b	$04, nRst, $08, nEb1, $10, nRst, $02, nF1, $16, nRst, $02, nC1
	dc.b	$0A, nRst, $02, nA0, nRst, $04, nC1, $12, nA0, $04, nRst, $02
	dc.b	nBb0, $04, nRst, $08, nG0, $10, nRst, $02, nBb0, $16, nRst, $02
	dc.b	nC1, $0A, nRst, $02, nEb1, nRst, $04, nC1, $10, nRst, $02, nEb1
	dc.b	$04, nRst, $02, nF1, $04, nRst, $08, nEb1, $10, nRst, $02, nF1
	dc.b	$10, nRst, $02, nEb1, $04, nRst, $08, nC2, $04, nRst, $02, nBb1
	dc.b	$04, nRst, $02, nG1, $04, nRst, $02, nF1, $04, nFs1, nF1, nEb1
	dc.b	$06, nC1, $04, nRst, $14, nG0, $1C, nRst, $02, nAb0, $0A, nRst
	dc.b	$02, nAb0, nRst, $04, nAb1, nRst, $08, nAb0, $04, nRst, $08, nAb0
	dc.b	$04, nRst, $08, nAb1, $04, nRst, $02, nAb0, $16, nRst, $02, nAb0
	dc.b	$04, nRst, $08, nG0, $0A, nRst, $02, nG0, nRst, $04, nG1, nRst
	dc.b	$08, nG0, $04, nRst, $08, nG0, $04, nRst, $08, nG1, $04, nRst
	dc.b	$02, nG0, $16, nRst, $02, nG0, $04, nRst, $08, nBb0, $0A, nRst
	dc.b	$02, nBb0, nRst, $04, nBb1, nRst, $08, nBb0, $04, nRst, $08, nBb0
	dc.b	$04, nRst, $08, nBb1, $04, nRst, $02, nBb0, $10, nRst, $02, nBb0
	dc.b	nRst, $04, nBb0, nRst, $0E, nC1, $04, nRst, $0E, nC1, $04, nRst
	dc.b	$08, nC2, $04, nRst, $02, nC1, $04, nRst, $08, nC2, $10, nRst
	dc.b	$02, nC1, $0A, nRst, $02, nC2, $0A, nRst, $02, nAb0, $0A, nRst
	dc.b	$02, nAb0, nRst, $04, nAb1, nRst, $08, nAb0, $04, nRst, $08, nAb0
	dc.b	$04, nRst, $08, nAb1, $04, nRst, $02, nAb0, $16, nRst, $02, nAb0
	dc.b	$04, nRst, $08, nG0, $0A, nRst, $02, nG0, nRst, $04, nG1, nRst
	dc.b	$08, nG0, $04, nRst, $08, nG0, $04, nRst, $08, nG1, $04, nRst
	dc.b	$02, nG0, $16, nRst, $02, nG0, $04, nRst, $08, nF0, $0A, nRst
	dc.b	$02, nF0, nRst, $04, nF1, nRst, $08, nF0, $04, nRst, $08, nF0
	dc.b	$04, nRst, $08, nF1, $04, nRst, $02, nF0, $16, nRst, $02, nF0
	dc.b	nRst, $04, nAb0, nRst, $08, nAb0, $04, nRst, $08, nAb0, $04, nRst
	dc.b	$08, nAb0, $04, nRst, $02, nAb0, $0A, nRst, $02, nG0, $04, nRst
	dc.b	$02, nG0, $04, nRst, $08, nG0, $04, nRst, $08, nG1, $04, nRst
	dc.b	$02, nG0, $04, nRst, $02, nG0, $04, nRst, $02, nF0, $10, nRst
	dc.b	$02, nF0, nRst, $22, nG0, $02, nRst, $04, nG1, $0A, nRst, $02
	dc.b	nG0, $16, nRst, $02, nAb0, $10, nRst, $02, nAb0, nRst, $22, nBb0
	dc.b	$02, nRst, $04, nBb1, $0A, nRst, $02, nBb0, $0A, nRst, $02, nBb1
	dc.b	$0A, nRst, $02, nF0, $10, nRst, $02, nF0, nRst, $22, nG0, $02
	dc.b	nRst, $04, nG1, $0A, nRst, $02, nG0, $16, nRst, $02, nC1, $10
	dc.b	nRst, $02, nC2, nRst, $04, nBb0, $10, nRst, $02, nBb1, nRst, $0A
	dc.b	nAb0, $02, nRst, $04, nAb1, $0A, nRst, $02, nG0, $0A, nRst, $02
	dc.b	nG1, $0A, nRst, $02, nF0, $10, nRst, $02, nF0, nRst, $22, nG0
	dc.b	$02, nRst, $04, nG1, $0A, nRst, $02, nG0, $16, nRst, $02, nAb0
	dc.b	$10, nRst, $02, nAb0, nRst, $22, nBb0, $02, nRst, $04, nBb1, $0A
	dc.b	nRst, $02, nBb0, $0A, nRst, $02, nBb1, $0A, nRst, $02, nAb0, $10
	dc.b	nRst, $02, nAb0, nRst, $22, nF0, $02, nRst, $04, nF0, $0A, nRst
	dc.b	$02, nEb0, $0A, nRst, $02, nF0, $0A, nRst, $08, nG0, $04, nRst
	dc.b	$08, nG0, $04, nRst, $08, nG0, $04, nRst, $02, nG0, $0A, nRst
	dc.b	$02, nG0, $04, nRst, $14, nF0, $04, nRst, $02, nFs0, $04, nRst
	dc.b	$02, nG0, $04, nRst, $02, nBb0, $04, nRst, $02
	smpsJump            Snd_HCZ2_FM2

; Unreachable
	smpsStop

; FM3 Data
Snd_HCZ2_FM3:
	dc.b	nRst, $07

Snd_HCZ2_Jump00:
	smpsSetvoice        $03
	smpsAlterNote       $02
	smpsModSet          $0F, $01, $06, $06
	smpsCall            Snd_HCZ2_Call02
	smpsSetvoice        $0E
	smpsAlterNote       $FF
	smpsModSet          $0F, $01, $06, $06
	smpsCall            Snd_HCZ2_Call03
	smpsSetvoice        $03
	smpsAlterNote       $02
	smpsModSet          $0F, $01, $06, $06
	smpsCall            Snd_HCZ2_Call04
	smpsJump            Snd_HCZ2_Jump00

; Unreachable
	smpsStop

; FM4 Data
Snd_HCZ2_FM4:
	smpsSetvoice        $06
	smpsAlterNote       $01
	smpsModSet          $0A, $01, $03, $06
	dc.b	nF3, $04, nRst, $08, nF3, $04, nRst, $0E, nF3, $04, nRst, $02
	dc.b	nF3, nRst, $04, nF3, $0A, nRst, $02, nF3, $0A, nRst, $02, nBb2
	dc.b	$04, nRst, $02, nF3, $04, nRst, $08, nF3, $04, nRst, $08, nEb3
	dc.b	$04, nRst, $08, nEb3, $04, nRst, $0E, nEb3, $04, nRst, $02, nEb3
	dc.b	nRst, $04, nE3, nRst, $08, nE3, $10, nRst, $02, nE3, $04, nRst
	dc.b	$08, nE3, $04, nRst, $08, nF3, $04, nRst, $08, nF3, $04, nRst
	dc.b	$0E, nF3, $04, nRst, $02, nF3, nRst, $04, nF3, $0A, nRst, $02
	dc.b	nF3, $0A, nRst, $02, nBb2, $04, nRst, $02, nF3, $04, nRst, $08
	dc.b	nF3, $04, nRst, $08, nEb3, $04, nRst, $08, nEb3, $04, nRst, $0E
	dc.b	nEb3, $04, nRst, $02, nEb3, nRst, $04, nE3, nRst, $08, nE3, $10
	dc.b	nRst, $02, nE3, $04, nRst, $08, nE3, $04, nRst, $08, nF3, $04
	dc.b	nRst, $08, nF3, $04, nRst, $0E, nF3, $04, nRst, $02, nF3, nRst
	dc.b	$04, nF3, $0A, nRst, $02, nF3, $0A, nRst, $02, nBb2, $04, nRst
	dc.b	$02, nF3, $04, nRst, $08, nF3, $04, nRst, $08, nEb3, $04, nRst
	dc.b	$08, nEb3, $04, nRst, $0E, nEb3, $04, nRst, $02, nEb3, nRst, $04
	dc.b	nE3, nRst, $08, nE3, $10, nRst, $02, nE3, $04, nRst, $08, nE3
	dc.b	$04, nRst, $08, nF3, $04, nRst, $08, nF3, $04, nRst, $0E, nF3
	dc.b	$04, nRst, $02, nF3, nRst, $04, nF3, $0A, nRst, $02, nF3, $0A
	dc.b	nRst, $02, nBb2, $04, nRst, $02, nF3, $04, nRst, $08, nF3, $04
	dc.b	nRst, $08, nEb3, $04, nRst, $08, nEb3, $04, nRst, $0E, nEb3, $04
	dc.b	nRst, $02, nEb3, nRst, $04, nE3, nRst, $08, nE3, $10, nRst, $02
	dc.b	nE3, $04, nRst, $08, nE3, $04, nRst, $08, nF3, $04, nRst, $08
	dc.b	nF3, $04, nRst, $0E, nF3, $04, nRst, $02, nF3, nRst, $04, nF3
	dc.b	$0A, nRst, $02, nF3, $0A, nRst, $02, nBb2, $04, nRst, $02, nF3
	dc.b	$04, nRst, $08, nF3, $04, nRst, $08, nEb3, $04, nRst, $08, nEb3
	dc.b	$04, nRst, $0E, nEb3, $04, nRst, $02, nEb3, nRst, $04, nE3, nRst
	dc.b	$08, nE3, $10, nRst, $02, nE3, $04, nRst, $08, nE3, $04, nRst
	dc.b	$08, nF3, $04, nRst, $08, nF3, $04, nRst, $0E, nF3, $04, nRst
	dc.b	$02, nF3, nRst, $04, nF3, $0A, nRst, $02, nF3, $0A, nRst, $02
	dc.b	nBb2, $04, nRst, $02, nF3, $04, nRst, $08, nF3, $04, nRst, $02
	dc.b	nEb3, $04, nRst, $08, nC4, $06, nBb3, nG3, nF3, $04, nFs3, nF3
	dc.b	nEb3, $06, nC3, nRst, $12, nF3, $1E, nEb3, $0A, nRst, $02, nD3
	dc.b	$04, nRst, $02, nEb3, $0A, nRst, $02, nD3, $0A, nRst, $02, nEb3
	dc.b	$04, nRst, $0E, nC4, $04, nRst, $02, nC4, $04, nRst, $08, nD4
	dc.b	$02, nRst, $04, nEb4, $0A, nRst, $02, nD3, $0A, nRst, $02, nF3
	dc.b	$04, nRst, $02, nD3, $0A, nRst, $02, nF3, $0A, nRst, $02, nD3
	dc.b	$04, nRst, $0E, nBb3, $04, nRst, $02, nBb3, $04, nRst, $08, nC4
	dc.b	$02, nRst, $04, nD4, $0A, nRst, $02, nD3, $0A, nRst, $02, nC3
	dc.b	$04, nRst, $02, nD3, $0A, nRst, $02, nC3, $0A, nRst, $02, nD3
	dc.b	$04, nRst, $0E, nD4, $04, nRst, $02, nD4, $04, nRst, $08, nEb4
	dc.b	$02, nRst, $04, nF4, $0A, nRst, $08, nBb3, $04, nRst, $0E, nBb3
	dc.b	$0A, nRst, $02, nBb3, $04, nRst, $02, nBb3, $04, nRst, $08, nBb3
	dc.b	$10, nRst, $02, nEb3, $0A, nRst, $02, nF3, $0A, nRst, $02, nEb3
	dc.b	$0A, nRst, $02, nD3, $04, nRst, $02, nEb3, $0A, nRst, $02, nD3
	dc.b	$0A, nRst, $02, nEb3, $04, nRst, $0E, nC4, $04, nRst, $02, nC4
	dc.b	$04, nRst, $08, nD4, $02, nRst, $04, nEb4, $0A, nRst, $02, nD3
	dc.b	$0A, nRst, $02, nF3, $04, nRst, $02, nD3, $0A, nRst, $02, nF3
	dc.b	$0A, nRst, $02, nBb2, $04, nRst, $0E, nBb3, $04, nRst, $02, nBb3
	dc.b	$04, nRst, $08, nEb4, $02, nRst, $04, nG4, $0A, nRst, $02, nEb3
	dc.b	$0A, nRst, $02, nBb2, $04, nRst, $02, nEb3, $0A, nRst, $02, nBb2
	dc.b	$0A, nRst, $02, nC3, $04, nRst, $0E, nA3, $04, nRst, $02, nA3
	dc.b	$04, nRst, $08, nC4, $02, nRst, $04, nEb4, $0A, nRst, $08, nEb4
	dc.b	$04, nRst, $08, nEb4, $04, nRst, $08, nEb4, $04, nRst, $02, nEb4
	dc.b	$0A, nRst, $02, nB3, $04, nRst, $02, nB3, $04, nRst, $08, nB3
	dc.b	$04, nRst, $0E, nEb3, $04, nRst, $02, nF3, $04, nRst, $08, nG3
	dc.b	$04, nRst, $02, nF3, $04, nRst, $02, nEb3, $04, nRst, $08, nD3
	dc.b	$04, nRst, $02, nEb3, $04, nRst, $02, nC3, $04, nRst, $08, nBb3
	dc.b	$10, nRst, $02, nG3, $04, nRst, $08, nF3, $04, nRst, $0E, nD4
	dc.b	$04, nRst, $02, nBb3, $04, nRst, $02, nG3, $04, nRst, $02, nEb3
	dc.b	$10, nRst, $02, nD3, $34, nRst, $08, nG3, $04, nRst, $02, nF3
	dc.b	$04, nRst, $02, nEb3, $04, nRst, $08, nD3, $04, nRst, $02, nEb3
	dc.b	$04, nRst, $02, nC3, $04, nRst, $08, nB3, $10, nRst, $02, nG3
	dc.b	$04, nRst, $08, nF3, $04, nRst, $08, nG3, $16, nRst, $02, nBb3
	dc.b	$10, nRst, $02, nBb3, $04, nRst, $08, nAb3, $10, nRst, $02, nG3
	dc.b	$16, nRst, $08, nG3, $04, nRst, $02, nF3, $04, nRst, $02, nEb3
	dc.b	$04, nRst, $08, nD3, $04, nRst, $02, nEb3, $04, nRst, $02, nC3
	dc.b	$04, nRst, $08, nBb3, $10, nRst, $02, nG3, $04, nRst, $08, nF3
	dc.b	$04, nRst, $0E, nD4, $04, nRst, $02, nBb3, $04, nRst, $02, nG3
	dc.b	$04, nRst, $02, nEb3, $10, nRst, $02, nD3, $34, nRst, $08, nG3
	dc.b	$04, nRst, $02, nF3, $04, nRst, $02, nEb3, $04, nRst, $08, nD3
	dc.b	$04, nRst, $02, nEb3, $04, nRst, $02, nC3, $04, nRst, $08, nEb2
	dc.b	$04, nRst, $02, nAb2, $04, nRst, $02, nEb2, $04, nRst, $02, nEb3
	dc.b	$0A, nRst, $02, nAb3, $0A, nRst, $08, nG3, $04, nRst, $08, nG3
	dc.b	$04, nRst, $08, nG3, $04, nRst, $02, nG3, $0A, nRst, $02, nG3
	dc.b	$04, nRst, $2C
	smpsJump            Snd_HCZ2_FM4

; Unreachable
	smpsStop

; FM5 Data
Snd_HCZ2_FM5:
	smpsSetvoice        $06
	smpsAlterNote       $FF
	smpsModSet          $0A, $01, $03, $06
	dc.b	nBb2, $04, nRst, $08, nBb2, $04, nRst, $0E, nBb2, $04, nRst, $02
	dc.b	nBb2, nRst, $04, nBb2, $0A, nRst, $02, nBb2, $0A, nRst, $08, nBb2
	dc.b	$04, nRst, $08, nBb2, $04, nRst, $08, nA2, $04, nRst, $08, nA2
	dc.b	$04, nRst, $0E, nA2, $04, nRst, $02, nA2, nRst, $04, nBb2, nRst
	dc.b	$08, nBb2, $10, nRst, $02, nBb2, $04, nRst, $08, nBb2, $04, nRst
	dc.b	$08, nBb2, $04, nRst, $08, nBb2, $04, nRst, $0E, nBb2, $04, nRst
	dc.b	$02, nBb2, nRst, $04, nBb2, $0A, nRst, $02, nBb2, $0A, nRst, $08
	dc.b	nBb2, $04, nRst, $08, nBb2, $04, nRst, $08, nA2, $04, nRst, $08
	dc.b	nA2, $04, nRst, $0E, nA2, $04, nRst, $02, nA2, nRst, $04, nBb2
	dc.b	nRst, $08, nBb2, $10, nRst, $02, nBb2, $04, nRst, $08, nBb2, $04
	dc.b	nRst, $08, nBb2, $04, nRst, $08, nBb2, $04, nRst, $0E, nBb2, $04
	dc.b	nRst, $02, nBb2, nRst, $04, nBb2, $0A, nRst, $02, nBb2, $0A, nRst
	dc.b	$08, nBb2, $04, nRst, $08, nBb2, $04, nRst, $08, nA2, $04, nRst
	dc.b	$08, nA2, $04, nRst, $0E, nA2, $04, nRst, $02, nA2, nRst, $04
	dc.b	nBb2, nRst, $08, nBb2, $10, nRst, $02, nBb2, $04, nRst, $08, nBb2
	dc.b	$04, nRst, $08, nBb2, $04, nRst, $08, nBb2, $04, nRst, $0E, nBb2
	dc.b	$04, nRst, $02, nBb2, nRst, $04, nBb2, $0A, nRst, $02, nBb2, $0A
	dc.b	nRst, $08, nBb2, $04, nRst, $08, nBb2, $04, nRst, $08, nA2, $04
	dc.b	nRst, $08, nA2, $04, nRst, $0E, nA2, $04, nRst, $02, nA2, nRst
	dc.b	$04, nBb2, nRst, $08, nBb2, $10, nRst, $02, nBb2, $04, nRst, $08
	dc.b	nBb2, $04, nRst, $08, nBb2, $04, nRst, $08, nBb2, $04, nRst, $0E
	dc.b	nBb2, $04, nRst, $02, nBb2, nRst, $04, nBb2, $0A, nRst, $02, nBb2
	dc.b	$0A, nRst, $08, nBb2, $04, nRst, $08, nBb2, $04, nRst, $08, nA2
	dc.b	$04, nRst, $08, nA2, $04, nRst, $0E, nA2, $04, nRst, $02, nA2
	dc.b	nRst, $04, nBb2, nRst, $08, nBb2, $10, nRst, $02, nBb2, $04, nRst
	dc.b	$08, nBb2, $04, nRst, $08, nBb2, $04, nRst, $08, nBb2, $04, nRst
	dc.b	$0E, nBb2, $04, nRst, $02, nBb2, nRst, $04, nBb2, $0A, nRst, $02
	dc.b	nBb2, $0A, nRst, $08, nBb2, $04, nRst, $08, nBb2, $04, nRst, $02
	dc.b	nBb2, $04, nRst, $44, nB2, $1E, nC3, $0A, nRst, $02, nBb2, $04
	dc.b	nRst, $02, nC3, $0A, nRst, $02, nBb2, $0A, nRst, $02, nC3, $04
	dc.b	nRst, $0E, nAb3, $04, nRst, $02, nAb3, $04, nRst, $08, nBb3, $02
	dc.b	nRst, $04, nC4, $0A, nRst, $02, nBb2, $0A, nRst, $02, nD3, $04
	dc.b	nRst, $02, nBb2, $0A, nRst, $02, nD3, $0A, nRst, $02, nBb2, $04
	dc.b	nRst, $0E, nG3, $04, nRst, $02, nG3, $04, nRst, $08, nAb3, $02
	dc.b	nRst, $04, nBb3, $0A, nRst, $02, nBb2, $0A, nRst, $02, nAb2, $04
	dc.b	nRst, $02, nBb2, $0A, nRst, $02, nAb2, $0A, nRst, $02, nBb2, $04
	dc.b	nRst, $0E, nBb3, $04, nRst, $02, nBb3, $04, nRst, $08, nC4, $02
	dc.b	nRst, $04, nD4, $0A, nRst, $08, nG3, $04, nRst, $0E, nF3, $0A
	dc.b	nRst, $02, nF3, $04, nRst, $02, nG3, $04, nRst, $08, nD3, $10
	dc.b	nRst, $02, nC3, $0A, nRst, $02, nD3, $0A, nRst, $02, nC3, $0A
	dc.b	nRst, $02, nBb2, $04, nRst, $02, nC3, $0A, nRst, $02, nBb2, $0A
	dc.b	nRst, $02, nC3, $04, nRst, $0E, nAb3, $04, nRst, $02, nAb3, $04
	dc.b	nRst, $08, nBb3, $02, nRst, $04, nC4, $0A, nRst, $02, nBb2, $0A
	dc.b	nRst, $02, nD3, $04, nRst, $02, nBb2, $0A, nRst, $02, nD3, $0A
	dc.b	nRst, $02, nG2, $04, nRst, $0E, nG3, $04, nRst, $02, nG3, $04
	dc.b	nRst, $08, nBb3, $02, nRst, $04, nEb4, $0A, nRst, $02, nBb2, $0A
	dc.b	nRst, $02, nG2, $04, nRst, $02, nBb2, $0A, nRst, $02, nG2, $0A
	dc.b	nRst, $02, nA2, $04, nRst, $0E, nF3, $04, nRst, $02, nF3, $04
	dc.b	nRst, $08, nA3, $02, nRst, $04, nC4, $0A, nRst, $08, nG3, $04
	dc.b	nRst, $08, nG3, $04, nRst, $08, nG3, $04, nRst, $02, nG3, $0A
	dc.b	nRst, $02, nF3, $04, nRst, $02, nF3, $04, nRst, $08, nF3, $04
	dc.b	nRst, $0E, nC3, $04, nRst, $02, nD3, $04, nRst, $08, nEb3, $04
	dc.b	nRst, $02, nD3, $04, nRst, $02, nC3, $04, nRst, $08, nBb2, $04
	dc.b	nRst, $02, nC3, $04, nRst, $02, nAb2, $04, nRst, $08, nF3, $10
	dc.b	nRst, $02, nEb3, $04, nRst, $08, nD3, $04, nRst, $0E, nBb3, $04
	dc.b	nRst, $02, nG3, $04, nRst, $02, nEb3, $04, nRst, $02, nC3, $10
	dc.b	nRst, $02, nF2, $34, nRst, $08, nEb3, $04, nRst, $02, nD3, $04
	dc.b	nRst, $02, nC3, $04, nRst, $08, nBb2, $04, nRst, $02, nC3, $04
	dc.b	nRst, $02, nAb2, $04, nRst, $08, nF3, $10, nRst, $02, nEb3, $04
	dc.b	nRst, $08, nD3, $04, nRst, $08, nEb3, $16, nRst, $02, nF3, $10
	dc.b	nRst, $02, nF3, $04, nRst, $08, nEb3, $10, nRst, $02, nD3, $16
	dc.b	nRst, $08, nEb3, $04, nRst, $02, nD3, $04, nRst, $02, nC3, $04
	dc.b	nRst, $08, nBb2, $04, nRst, $02, nC3, $04, nRst, $02, nAb2, $04
	dc.b	nRst, $08, nF3, $10, nRst, $02, nEb3, $04, nRst, $08, nD3, $04
	dc.b	nRst, $0E, nBb3, $04, nRst, $02, nG3, $04, nRst, $02, nEb3, $04
	dc.b	nRst, $02, nC3, $10, nRst, $02, nF2, $34, nRst, $08, nEb3, $04
	dc.b	nRst, $02, nD3, $04, nRst, $02, nC3, $04, nRst, $08, nBb2, $04
	dc.b	nRst, $02, nC3, $04, nRst, $02, nAb2, $04, nRst, $1A, nC3, $0A
	dc.b	nRst, $02, nEb3, $0A, nRst, $08, nD3, $04, nRst, $08, nD3, $04
	dc.b	nRst, $08, nD3, $04, nRst, $02, nD3, $0A, nRst, $02, nD3, $04
	dc.b	nRst, $2C
	smpsJump            Snd_HCZ2_FM5

; Unreachable
	smpsStop

; PSG1 Data
Snd_HCZ2_PSG1:
	smpsPSGvoice        sTone_0A

Snd_HCZ2_Jump02:
	dc.b	nC4, $04, nRst, $02, nG3, $04, nRst, $02, nBb3, $04, nRst, $02
	dc.b	nG3, $04, nRst, $08, nG3, $04, nRst, $02, nBb3, $04, nRst, $02
	dc.b	nG3, $04, nRst, $02, nC4, $04, nRst, $02, nG3, $04, nRst, $02
	dc.b	nBb3, $04, nRst, $02, nG3, $04, nRst, $60, nRst, $1A, nC4, $04
	dc.b	nRst, $02, nG3, $04, nRst, $02, nBb3, $04, nRst, $02, nG3, $04
	dc.b	nRst, $08, nG3, $04, nRst, $02, nBb3, $04, nRst, $02, nG3, $04
	dc.b	nRst, $02, nC4, $04, nRst, $02, nG3, $04, nRst, $02, nBb3, $04
	dc.b	nRst, $02, nG3, $04, nRst, $60, nRst, nRst, $38, nF4, $06, nFs4
	dc.b	nG4, nBb5, nRst, nC5, nFs5, $02, nG5, $12, nRst, $70, nC4, $04
	dc.b	nRst, $02, nA4, $04, nRst, $02, nG4, $04, nRst, $08, nF4, $04
	dc.b	nRst, $02, nFs4, nG4, $04, nE4, nRst, $7F, nRst, $31, nF4, $06
	dc.b	nFs4, nG4, nBb5, nRst, nC5, nFs5, $02, nG5, $12, nRst, $70, nC5
	dc.b	$06, nBb4, nG4, nF4, $04, nFs4, nF4, nEb4, $06, nC4, nRst, $12
	dc.b	nBb3, $1E, nRst, $3C, nC4, $04, nRst, $02, nC4, $04, nRst, $08
	dc.b	nD4, $02, nRst, $04, nEb4, $0A, nRst, $3E, nBb3, $04, nRst, $02
	dc.b	nBb3, $04, nRst, $08, nC4, $02, nRst, $04, nD4, $0A, nRst, $3E
	dc.b	nD4, $04, nRst, $02, nD4, $04, nRst, $08, nEb4, $02, nRst, $04
	dc.b	nF4, $0A, nRst, $08, nEb5, $04, nRst, $0E, nD5, $0A, nRst, $02
	dc.b	nD5, $04, nRst, $02, nEb5, $04, nRst, $08, nD5, $10, nRst, $02
	dc.b	nEb5, $0A, nRst, $02, nF5, $0A, nRst, $3E, nC4, $04, nRst, $02
	dc.b	nC4, $04, nRst, $08, nD4, $02, nRst, $04, nEb4, $0A, nRst, $3E
	dc.b	nBb3, $04, nRst, $02, nBb3, $04, nRst, $08, nEb4, $02, nRst, $04
	dc.b	nG4, $0A, nRst, $3E, nA3, $04, nRst, $02, nA3, $04, nRst, $08
	dc.b	nC4, $02, nRst, $04, nEb4, $0A, nRst, $08, nEb4, $04, nRst, $02
	dc.b	nEb3, $04, nRst, $02, nEb4, $04, nRst, $02, nEb3, $04, nRst, $02
	dc.b	nEb4, $04, nRst, $02, nEb4, $04, nRst, $02, nEb3, $04, nRst, $02
	dc.b	nD4, $04, nRst, $02, nD4, $04, nRst, $08, nD4, $04, nRst, $50
	dc.b	nBb3, $04, nRst, $02, nG3, $04, nRst, $02, nBb3, $04, nRst, $02
	dc.b	nBb3, $04, nRst, $02, nBb3, $04, nRst, $02, nG3, $04, nRst, $02
	dc.b	nBb3, $04, nRst, $38, nD4, $04, nRst, $02, nBb3, $04, nRst, $02
	dc.b	nD4, $04, nRst, $02, nF4, $04, nRst, $02, nD4, $04, nRst, $02
	dc.b	nBb3, $04, nRst, $02, nG3, $04, nRst, $38, nB3, $04, nRst, $02
	dc.b	nG3, $04, nRst, $02, nB3, $04, nRst, $02, nF3, $04, nRst, $02
	dc.b	nG3, $04, nRst, $02, nB3, $04, nRst, $02, nD4, $04, nRst, $02
	dc.b	nC3, $04, nRst, $02, nEb3, $04, nRst, $02, nG3, $04, nRst, $02
	dc.b	nEb3, $04, nRst, $02, nD3, $04, nRst, $02, nF3, $04, nRst, $02
	dc.b	nBb3, $04, nRst, $02, nD3, $04, nRst, $02, nEb3, $04, nRst, $02
	dc.b	nAb3, $04, nRst, $02, nC4, $04, nRst, $02, nEb3, $04, nRst, $02
	dc.b	nF3, $04, nRst, $02, nG3, $04, nRst, $02, nD4, $04, nRst, $02
	dc.b	nG3, $04, nRst, $38, nBb3, $04, nRst, $02, nG3, $04, nRst, $02
	dc.b	nBb3, $04, nRst, $02, nBb3, $04, nRst, $02, nBb3, $04, nRst, $02
	dc.b	nG3, $04, nRst, $02, nBb3, $04, nRst, $38, nD4, $04, nRst, $02
	dc.b	nBb3, $04, nRst, $02, nD4, $04, nRst, $02, nF4, $04, nRst, $02
	dc.b	nD4, $04, nRst, $02, nBb3, $04, nRst, $02, nG3, $04, nRst, $38
	dc.b	nEb3, $04, nRst, $02, nAb3, $04, nRst, $02, nEb3, $04, nRst, $02
	dc.b	nEb3, $04, nRst, $02, nC4, $04, nRst, $02, nAb3, $04, nRst, $02
	dc.b	nEb4, $04, nRst, $08, nEb5, $04, nRst, $08, nEb5, $04, nRst, $08
	dc.b	nEb5, $04, nRst, $02, nEb5, $0A, nRst, $02, nD5, $04, nRst, $2C
	smpsJump            Snd_HCZ2_Jump02

; Unreachable
	smpsStop

; PSG2 Data
Snd_HCZ2_PSG2:
	smpsPSGvoice        sTone_08
	dc.b	nRst, $01
	smpsAlterNote       $01

Snd_HCZ2_Jump03:
	smpsJump            Snd_HCZ2_Jump02

; Unreachable
	smpsJump            Snd_HCZ2_Jump03
	smpsStop

; PSG3 Data
Snd_HCZ2_PSG3:
	smpsPSGvoice        sTone_02
	smpsPSGform         $E7

Snd_HCZ2_Jump01:
	dc.b	nRst, $18, nRst, $18, nRst, $18, nRst, $18, nRst, $18
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $04, nMaxPSG1, $04, nMaxPSG1, $04
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $0C, smpsNoAttack, $18, smpsNoAttack, $18, smpsNoAttack, $18, smpsNoAttack, $18, smpsNoAttack, $18
	dc.b	smpsNoAttack, $18, nMaxPSG1, $04, nMaxPSG1, $04, nMaxPSG1, $04
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $0C, smpsNoAttack, $18

Snd_HCZ2_Loop04:
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsLoop            $01, $03, Snd_HCZ2_Loop04
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $18, smpsNoAttack, $18
	dc.b	smpsNoAttack, $18, smpsNoAttack, $18

Snd_HCZ2_Loop05:
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $0C
	smpsLoop            $01, $03, Snd_HCZ2_Loop05
	dc.b	smpsNoAttack, $18, smpsNoAttack, $18, smpsNoAttack, $18, smpsNoAttack, $18

Snd_HCZ2_Loop06:
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $0C
	smpsLoop            $01, $03, Snd_HCZ2_Loop06
	dc.b	smpsNoAttack, $18, smpsNoAttack, $18, smpsNoAttack, $18, smpsNoAttack, $18
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, smpsNoAttack, $18, nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $18, smpsNoAttack, $18, smpsNoAttack, $18, smpsNoAttack, $18
	smpsJump            Snd_HCZ2_Jump01

; Unreachable
	smpsStop
