Snd_LRZ1_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoiceUVB
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $26

	smpsHeaderDAC       Snd_LRZ1_DAC
	smpsHeaderFM        Snd_LRZ1_FM1,	$0C, $09
	smpsHeaderFM        Snd_LRZ1_FM2,	$0C, $01
	smpsHeaderFM        Snd_LRZ1_FM3,	$0C, $03
	smpsHeaderFM        Snd_LRZ1_FM4,	$0C, $13
	smpsHeaderFM        Snd_LRZ1_FM5,	$0C, $13
	smpsHeaderPSG       Snd_LRZ1_PSG1,	$F4, $04, $00, sTone_0C
	smpsHeaderPSG       Snd_LRZ1_PSG2,	$F4, $04, $00, sTone_0C
	smpsHeaderPSG       Snd_LRZ1_PSG3,	$F4, $01, $00, sTone_0C

; Unreachable
	smpsStop
	smpsStop

Snd_LRZ1_Call00:
	dc.b	dKickS3, $0C, dElectricFloorTom, $06, dElectricFloorTom, dSnareS3, $30, dSnareS3, $18, dKickS3, $0C, dElectricFloorTom
	dc.b	$06, dElectricFloorTom, dSnareS3, $30, dSnareS3, $06, dElectricFloorTom, $06, dMidpitchSnare, $0C
	smpsReturn

Snd_LRZ1_Call01:
	dc.b	dKickS3, $06, dKickS3, dKickS3, dKickS3, dSnareS3, $24, dElectricFloorTom, $06, dElectricFloorTom, dSnareS3, $06
	dc.b	dKickS3, $06, dMidpitchSnare, $0C
	smpsReturn

Snd_LRZ1_Call02:
	dc.b	dKickS3, $0C, dKickS3, $06, dKickS3, dSnareS3, $0C, dKickS3, $06, dKickS3, $12, dElectricFloorTom
	dc.b	$06, dElectricFloorTom, dSnareS3, dKickS3, dMidpitchSnare, $0C, dKickS3, $0C, dKickS3, $06, dSnareS3, dKickS3
	dc.b	dKickS3, dSnareS3, $18, dKickS3, $06, dKickS3, dSnareS3, dElectricFloorTom, dMidpitchSnare, $0C
	smpsReturn

; DAC Data
Snd_LRZ1_DAC:
	smpsCall            Snd_LRZ1_Call00
	smpsLoop            $01, $06, Snd_LRZ1_DAC

Snd_LRZ1_Loop00:
	smpsCall            Snd_LRZ1_Call01
	smpsLoop            $01, $02, Snd_LRZ1_Loop00
	dc.b	dKickS3, $0C, dKickS3, $06, dKickS3, $06, dSnareS3, $0C, dKickS3, $0C, dKickS3, $06
	dc.b	dKickS3, $12, dSnareS3, $0C, dKickS3, $06, dKickS3, $12, dKickS3, $0C, dSnareS3, $06
	dc.b	dKickS3, $12, dKickS3, $12, dSnareS3, $06, dSnareS3, $06, dSnareS3, $06, dSnareS3, $0C

Snd_LRZ1_Loop01:
	smpsCall            Snd_LRZ1_Call02
	smpsLoop            $01, $02, Snd_LRZ1_Loop01
	smpsJump            Snd_LRZ1_DAC

; Unreachable
	smpsStop
	smpsStop

; FM1 Data
Snd_LRZ1_FM1:
	smpsSetvoice        $22
	smpsAlterNote       $00
	smpsModSet          $0F, $01, $03, $06

Snd_LRZ1_Jump02:
	dc.b	nA1, $04, nRst, $08, nG1, $02, nRst, $04, nA1, $44, nRst, $0A
	dc.b	nF1, $04, nRst, $08, nF1, $02, nRst, $04, nF1, $04, nRst, $08
	dc.b	nF1, $04, nRst, $08, nG1, $2E, nRst, $08, nA1, $04, nRst, $08
	dc.b	nG1, $02, nRst, $04, nA1, $42, nRst, $0C, nF1, $04, nRst, $08
	dc.b	nF1, $02, nRst, $04, nF1, $04, nRst, $08, nF1, $04, nRst, $08
	dc.b	nG1, $2E, nRst, $08, nA1, $04, nRst, $08, nG1, $02, nRst, $04
	dc.b	nA1, $44, nRst, $0A, nF1, $04, nRst, $08, nF1, $02, nRst, $04
	dc.b	nF1, $04, nRst, $08, nF1, $04, nRst, $08, nG1, $2A, nRst, $0C
	dc.b	nA1, $04, nRst, $08, nG1, $02, nRst, $04, nA1, $42, nRst, $0C
	dc.b	nF1, $04, nRst, $08, nF1, $02, nRst, $04, nF1, $04, nRst, $08
	dc.b	nF1, $04, nRst, $08, nG1, $2C, nRst, $0A, nA1, $04, nRst, $08
	dc.b	nG1, $04, nRst, $02, nA1, $46, nRst, $08, nF1, $04, nRst, $08
	dc.b	nF1, $02, nRst, $04, nF1, $04, nRst, $08, nF1, $04, nRst, $08
	dc.b	nG1, $2E, nRst, $08, nA1, $04, nRst, $08, nG1, $04, nRst, $02
	dc.b	nA1, $44, nRst, $0A, nF1, $04, nRst, $08, nF1, $02, nRst, $04
	dc.b	nF1, $04, nRst, $08, nF1, $04, nRst, $08, nG1, $2C, nRst, $0A
	dc.b	nF1, $04, nRst, $02, nF1, $04, nRst, $02, nF1, $04, nRst, $02
	dc.b	nF1, $06, nF1, $02, nRst, $46, nG1, $04, nRst, $02, nG1, $04
	dc.b	nRst, $02, nG1, $04, nRst, $02, nG1, $04, nRst, $02, nG1, $04
	dc.b	nRst, $14, nC2, $10, nRst, $08, nG1, $0E, nRst, $0A, nA1, $04
	dc.b	nRst, $08, nG1, $02, nRst, $04, nA1, $08, nRst, $0A, nC2, $04
	dc.b	nRst, $08, nB1, $02, nRst, $04, nC2, $08, nRst, $0A, nD2, $04
	dc.b	nRst, $08, nC2, $02, nRst, $04, nD2, $08, nRst, $0A, nE2, $04
	dc.b	nRst, $08, nD2, $02, nRst, $04, nE2, $08, nRst, $0A, nG2, $16
	dc.b	nRst, $02, nG1, $16, nRst, $02, nA1, $02, nRst, $0A, nA1, $04
	dc.b	nRst, $02, nA1, $08, nRst, $0A, nC2, $04, nRst, $08, nC2, $06
	dc.b	nC2, $04, nRst, $0E, nD2, $04, nRst, $02, nC2, $06, nA1, $02
	dc.b	nRst, $0A, nG1, $06, nRst, $0C, nG1, $06, nRst, $0C, nA1, $24
	dc.b	nRst, $18, nA1, $04, nRst, $08, nA1, $04, nRst, $02, nA1, $06
	dc.b	nRst, $0C, nC2, $06, nRst, $06, nC2, $04, nRst, $02, nC2, $04
	dc.b	nRst, $0E, nD2, $02, nRst, $04, nC2, $06, nA1, $04, nRst, $08
	dc.b	nG1, $06, nRst, $0C, nG1, $06, nRst, $0C, nA1, $36, nRst, $06
	smpsJump            Snd_LRZ1_Jump02

; Unreachable
	smpsStop

; FM2 Data
Snd_LRZ1_FM2:
	smpsPan             panLeft, $00
	smpsSetvoice        $0C
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06

Snd_LRZ1_Jump01:
	smpsCall            Snd_LRZ1_Call03
	smpsSetvoice        $0C
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsCall            Snd_LRZ1_Call04
	smpsSetvoice        $0C
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsCall            Snd_LRZ1_Call05
	smpsJump            Snd_LRZ1_Jump01

Snd_LRZ1_Call03:
	dc.b	nRst, $60, nRst, $60, nRst, $60, nRst, $54, nD4, $06, nEb4, $06
	dc.b	nE4, $12, nG4, $04, nRst, $0E, nC4, $22, nRst, $02, nE4, $04
	dc.b	nRst, $08, nA3, $10, nRst, $02, nC4, $04, nRst, $02, nE4, $48
	dc.b	nD4, $06, nEb4, $06, nE4, $12, nG4, $04, nRst, $0E, nC4, $20
	dc.b	nRst, $04, nE4, $04, nRst, $08, nD4, $12, nC4, $06, nA3, $48
	smpsReturn

Snd_LRZ1_Call04:
	dc.b	nD4, $06, nEb4, $06, nE4, $12, nG4, $04, nRst, $0E, nC4, $22
	dc.b	nRst, $02, nE4, $04, nRst, $08, nA3, $12, nC4, $06, nE4, $48
	dc.b	nD4, $06, nEb4, $06, nE4, $10, nRst, $02, nG4, $04, nRst, $0E
	dc.b	nC4, $24, nE4, $04, nRst, $08, nD4, $12, nC4, $06, nA3, $48
	dc.b	nE4, $06, nF4, $06, nG4, $24, nC4, $36, nRst, $06, nG4, $18
	dc.b	nA4, $04, nRst, $08, nG4, $38, nRst, $10, nA4, $0C, nG4, $06
	dc.b	nRst, $06, nA4, $04, nRst, $08, nC5, $10, nRst, $02, nB4, $04
	dc.b	nRst, $0C, nA4, $06, nRst, $08, nB4, $10, nRst, $02, nC5, $04
	dc.b	nRst, $0E, nD5, $04, nRst, $08, nC5, $16, nRst, $02, nB4, $16
	dc.b	nRst, $02
	smpsReturn

Snd_LRZ1_Call05:
	dc.b	nE5, $0C, nA4, $06, nE5, $04, nRst, $0E, nA4, $22, nRst, $02
	dc.b	nC5, $14, nRst, $04, nB4, $06, nRst, $06, nB4, $04, nRst, $02
	dc.b	nD5, $06, nRst, $06, nB4, $04, nRst, $02, nC5, $32, nRst, $0A
	dc.b	nE5, $0C, nA4, $04, nRst, $02, nE5, $06, nRst, $0C, nA4, $22
	dc.b	nRst, $02, nC5, $14, nRst, $04, nB4, $06, nRst, $06, nB4, $04
	dc.b	nRst, $02, nD5, $06, nRst, $06, nB4, $04, nRst, $02, nC5, $26
	dc.b	nRst, $16
	smpsReturn

; Unreachable
	smpsStop

; FM3 Data
Snd_LRZ1_FM3:
	dc.b	nRst, $02
	smpsSetvoice        $0C
	smpsAlterNote       $02
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00

Snd_LRZ1_Jump00:
	smpsCall            Snd_LRZ1_Call03
	smpsSetvoice        $0C
	smpsAlterNote       $02
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	smpsCall            Snd_LRZ1_Call04
	smpsSetvoice        $0C
	smpsAlterNote       $02
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	smpsCall            Snd_LRZ1_Call05
	smpsJump            Snd_LRZ1_Jump00

; Unreachable
	smpsStop

; FM4 Data
Snd_LRZ1_FM4:
	smpsSetvoice        $06
	smpsAlterNote       $01
	smpsModSet          $0A, $01, $03, $06
	dc.b	nA2, $0A, nRst, $02, nC3, $04, nRst, $02, nA2, $0A, nRst, $02
	dc.b	nB2, $0A, nRst, $02, nG2, $0C, nA2, $0A, nRst, $02, nG2, $06
	dc.b	nF2, $08, nRst, $04, nE2, $04, nRst, $08, nA2, $0C, nC3, $04
	dc.b	nRst, $02, nA2, $0C, nB2, $0A, nRst, $02, nG2, $0A, nRst, $02
	dc.b	nA2, $0A, nRst, $02, nD2, $06, nG2, $0C, nE2, $04, nRst, $08
	dc.b	nA2, $0A, nRst, $02, nC3, $04, nRst, $02, nA2, $0C, nB2, $0A
	dc.b	nRst, $02, nG2, $0A, nRst, $02, nA2, $0A, nRst, $02, nG2, $06
	dc.b	nF2, $0C, nE2, $04, nRst, $08, nA2, $0C, nC3, $04, nRst, $02
	dc.b	nA2, $0C, nB2, $0A, nRst, $02, nG2, $0A, nRst, $02, nA2, $0A
	dc.b	nRst, $02, nD2, $06, nG2, $0C, nE2, $04, nRst, $08, nA2, $0A
	dc.b	nRst, $02, nC3, $04, nRst, $02, nA2, $0A, nRst, $02, nB2, $0A
	dc.b	nRst, $02, nG2, $0C, nA2, $0A, nRst, $02, nG2, $06, nF2, $08
	dc.b	nRst, $04, nE2, $04, nRst, $08, nA2, $0C, nC3, $04, nRst, $02
	dc.b	nA2, $0C, nB2, $0A, nRst, $02, nG2, $0A, nRst, $02, nA2, $0A
	dc.b	nRst, $02, nD2, $06, nG2, $0C, nE2, $04, nRst, $08, nA2, $0A
	dc.b	nRst, $02, nC3, $04, nRst, $02, nA2, $0C, nB2, $0A, nRst, $02
	dc.b	nG2, $0A, nRst, $02, nA2, $0A, nRst, $02, nG2, $06, nF2, $0C
	dc.b	nE2, $04, nRst, $08, nA2, $0C, nC3, $04, nRst, $02, nA2, $0C
	dc.b	nB2, $0A, nRst, $02, nG2, $0A, nRst, $02, nA2, $0A, nRst, $02
	dc.b	nD2, $06, nG2, $0C, nE2, $04, nRst, $08, nA2, $0A, nRst, $02
	dc.b	nC3, $04, nRst, $02, nA2, $0A, nRst, $02, nB2, $0A, nRst, $02
	dc.b	nG2, $0C, nA2, $0A, nRst, $02, nG2, $06, nF2, $08, nRst, $04
	dc.b	nE2, $04, nRst, $08, nA2, $0C, nC3, $04, nRst, $02, nA2, $0C
	dc.b	nB2, $0A, nRst, $02, nG2, $0A, nRst, $02, nA2, $0A, nRst, $02
	dc.b	nD2, $06, nG2, $0C, nE2, $04, nRst, $08, nA2, $0A, nRst, $02
	dc.b	nC3, $04, nRst, $02, nA2, $0C, nB2, $0A, nRst, $02, nG2, $0A
	dc.b	nRst, $02, nA2, $0A, nRst, $02, nG2, $06, nF2, $0C, nE2, $04
	dc.b	nRst, $08, nA2, $0C, nC3, $04, nRst, $02, nA2, $0C, nB2, $0A
	dc.b	nRst, $02, nG2, $0A, nRst, $02, nA2, $0A, nRst, $02, nD2, $06
	dc.b	nG2, $0C, nE2, $04, nRst, $08
	smpsSetvoice        $06
	smpsAlterNote       $03
	smpsModSet          $00, $01, $03, $06
	dc.b	nF3, $04, nRst, $02, nF3, $04, nRst, $02, nF3, $04, nRst, $02
	dc.b	nF3, $04, nRst, $1A, nA3, $02, nB3, $02, nC4, $0E, nC4, $12
	dc.b	nE4, $06, nRst, $06, nG3, $04, nRst, $02, nG3, $04, nRst, $02
	dc.b	nG3, $04, nRst, $02, nG3, $04, nRst, $1C, nG3, $14, nRst, $02
	dc.b	nD4, $10, nRst, $14, nA3, $0C, nG3, $06, nRst, $06, nA3, $04
	dc.b	nRst, $08, nC4, $10, nRst, $02, nB3, $04, nRst, $0C, nA3, $06
	dc.b	nRst, $08, nB3, $10, nRst, $02, nC4, $04, nRst, $0E, nD4, $04
	dc.b	nRst, $08, nE4, $16, nRst, $02, nB3, $16, nRst, $02
	smpsSetvoice        $0D
	smpsAlterNote       $01
	smpsModSet          $0F, $01, $06, $04
	smpsFMAlterVol      $04
	dc.b	nE3, $0C, nA2, $04, nRst, $02, nE3, $04, nRst, $0E, nA2, $24
	dc.b	nC3, $16, nRst, $02, nB2, $06, nRst, $06, nB2, $04, nRst, $02
	dc.b	nD3, $06, nRst, $0C, nC3, $36, nRst, $06, nE3, $0C, nA2, $04
	dc.b	nRst, $02, nE3, $04, nRst, $0E, nA2, $24, nC3, $16, nRst, $02
	dc.b	nB2, $06, nRst, $06, nB2, $04, nRst, $02, nD3, $06, nRst, $06
	dc.b	nB2, $04, nRst, $02, nC3, $3C
	smpsFMAlterVol      $FC
	smpsJump            Snd_LRZ1_FM4

; Unreachable
	smpsStop

; FM5 Data
Snd_LRZ1_FM5:
	smpsSetvoice        $0B
	smpsAlterNote       $FF
	smpsModSet          $0A, $01, $03, $06
	dc.b	nA3, $0A, nRst, $02, nC4, $04, nRst, $02, nA3, $0A, nRst, $02
	dc.b	nB3, $0A, nRst, $02, nG3, $0C, nA3, $0A, nRst, $02, nG3, $06
	dc.b	nF3, $08, nRst, $04, nE3, $04, nRst, $08, nA3, $0C, nC4, $04
	dc.b	nRst, $02, nA3, $0C, nB3, $0A, nRst, $02, nG3, $0A, nRst, $02
	dc.b	nA3, $0A, nRst, $02, nD3, $06, nG3, $0C, nE3, $04, nRst, $08
	dc.b	nA3, $0A, nRst, $02, nC4, $04, nRst, $02, nA3, $0C, nB3, $0A
	dc.b	nRst, $02, nG3, $0A, nRst, $02, nA3, $0A, nRst, $02, nG3, $08
	dc.b	nRst, $0A, nE3, $04, nRst, $08, nA3, $0C, nC4, $04, nRst, $02
	dc.b	nA3, $0C, nB3, $0A, nRst, $02, nG3, $0A, nRst, $02, nA3, $0A
	dc.b	nRst, $02, nD3, $06, nG3, $0C, nE3, $04, nRst, $08, nA3, $0A
	dc.b	nRst, $02, nC4, $06, nA3, $0C, nB3, $0C, nG3, $0C, nA3, $0A
	dc.b	nRst, $02, nG3, $08, nRst, $0A, nE3, $04, nRst, $08, nA3, $0A
	dc.b	nRst, $02, nC4, $06, nA3, $0C, nB3, $0A, nRst, $02, nG3, $0C
	dc.b	nA3, $0A, nRst, $02, nD3, $04, nRst, $02, nG3, $0C, nE3, $04
	dc.b	nRst, $08, nA3, $0A, nRst, $02, nC4, $06, nA3, $0C, nB3, $0A
	dc.b	nRst, $02, nG3, $0C, nA3, $0A, nRst, $02, nG3, $08, nRst, $0A
	dc.b	nE3, $04, nRst, $08, nA3, $0A, nRst, $02, nC4, $06, nA3, $0A
	dc.b	nRst, $02, nB3, $0A, nRst, $02, nG3, $0C, nA3, $0A, nRst, $02
	dc.b	nD3, $06, nG3, $0C, nE3, $04, nRst, $08, nA3, $0C, nC4, $06
	dc.b	nA3, $0C, nB3, $0C, nG3, $0C, nA3, $0A, nRst, $02, nG3, $08
	dc.b	nRst, $0A, nE3, $04, nRst, $08, nA3, $0C, nC4, $06, nA3, $0C
	dc.b	nB3, $0A, nRst, $02, nG3, $0C, nA3, $08, nRst, $04, nD3, $06
	dc.b	nG3, $0C, nE3, $04, nRst, $08, nA3, $0C, nC4, $06, nA3, $0C
	dc.b	nB3, $0C, nG3, $0C, nA3, $0A, nRst, $02, nG3, $08, nRst, $0A
	dc.b	nE3, $04, nRst, $08, nA3, $0A, nRst, $02, nC4, $06, nA3, $0C
	dc.b	nB3, $0A, nRst, $02, nG3, $0C, nA3, $0A, nRst, $02, nD3, $06
	dc.b	nG3, $0E, nRst, $0A
	smpsSetvoice        $06
	smpsAlterNote       $FD
	smpsModSet          $00, $01, $03, $06
	dc.b	nC4, $04, nRst, $02, nC4, $04, nRst, $02, nC4, $04, nRst, $02
	dc.b	nC4, $04, nRst, $1A, nF4, $02, nG4, $02, nA4, $0E, nA4, $12
	dc.b	nC5, $06, nB4, $02, nA4, $02, nG4, $02, nD4, $04, nRst, $02
	dc.b	nD4, $04, nRst, $02, nD4, $04, nRst, $02, nD4, $04, nRst, $1A
	dc.b	nEb4, $02, nE4, $14, nRst, $02, nB4, $10, nB4, $02, nA4, $02
	dc.b	nG4, $02, nF4, $02, nRst, $0C, nC4, $0C, nC4, $06, nRst, $06
	dc.b	nC4, $04, nRst, $08, nE4, $10, nRst, $02, nE4, $04, nRst, $0C
	dc.b	nE4, $06, nRst, $08, nF4, $10, nRst, $02, nF4, $04, nRst, $0E
	dc.b	nF4, $04, nRst, $08, nG4, $16, nRst, $02, nD4, $16, nRst, $02
	smpsSetvoice        $0D
	smpsAlterNote       $FF
	smpsModSet          $0F, $01, $06, $04
	smpsFMAlterVol      $04
	dc.b	nC4, $0C, nF3, $04, nRst, $02, nC4, $04, nRst, $0E, nF3, $24
	dc.b	nA3, $16, nRst, $02, nG3, $06, nRst, $06, nG3, $04, nRst, $02
	dc.b	nB3, $06, nRst, $0C, nA3, $36, nRst, $06, nC4, $0C, nF3, $04
	dc.b	nRst, $02, nC4, $04, nRst, $0E, nF3, $24, nA3, $16, nRst, $02
	dc.b	nG3, $06, nRst, $06, nG3, $04, nRst, $02, nB3, $06, nRst, $06
	dc.b	nG3, $04, nRst, $02, nA3, $3C
	smpsFMAlterVol      $FC
	smpsJump            Snd_LRZ1_FM5

; Unreachable
	smpsStop

; PSG1 Data
Snd_LRZ1_PSG1:
	dc.b	nRst, $01
	smpsPSGvoice        sTone_04
	smpsAlterNote       $FF

Snd_LRZ1_Jump05:
	smpsCall            Snd_LRZ1_Call06
	dc.b	nA3, nA3, nA3, nA3, $12, nC4, $06, nC4, nC4, nC4, $12, nD4
	dc.b	$06, nD4, nC4, $0C, nB3, nB3, $06, nB3, $0C, nB3, $06, nC4
	dc.b	$18, nC4, $06, nC4, nC4, nC4, nB3, $0C, nA3, $06, nA3, nA3
	dc.b	nA3, nA3, $0C, nC4, $06, nC4, nC4, nC4, $12, nD4, $06, nC4
	dc.b	nB3, $0C, nG3, $12, nG3, nA3, $3C
	smpsJump            Snd_LRZ1_Jump05

; Unreachable
	smpsStop

Snd_LRZ1_Call06:
	dc.b	nA3, $06, nA4, $0C, nA3, $06, nA4, $0C, nA3, $06, nA4, $0C
	dc.b	nA3, $06, nA4, $0C, nA3, nA4, nF3, $06, nF4, $0C, nF3, $06
	dc.b	nF4, $0C, nF3, $06, nG3, $0C, nG4, $06, nG3, $0C, nG4, nG3
	dc.b	nA3, $06, nA4, $0C, nA3, $06, nA4, $0C, nA3, $06, nA4, $0C
	dc.b	nA3, $06, nA4, $0C, nA3, nA4, nF3, $06, nF4, $0C, nF3, $06
	dc.b	nF4, $0C, nF3, $06, nG3, $0C, nG4, $06, nG3, $0C, nG4, nG3
	dc.b	nA3, $06, nA4, $0C, nA3, $06, nA4, $0C, nA3, $06, nA4, $0C
	dc.b	nA3, $06, nA4, $0C, nA3, nA4, nF3, $06, nF4, $0C, nF3, $06
	dc.b	nF4, $0C, nF3, $06, nG3, $0C, nG4, $06, nG3, $0C, nG4, nG3
	dc.b	nA3, $06, nA4, $0C, nA3, $06, nA4, $0C, nA3, $06, nA4, $0C
	dc.b	nA3, $06, nA4, $0C, nA3, nA4, nF3, $06, nF4, $0C, nF3, $06
	dc.b	nF4, $0C, nF3, $06, nG3, $0C, nG4, $06, nG3, $0C, nG4, nG3
	dc.b	nA3, $06, nA4, $0C, nA3, $06, nA4, $0C, nA3, $06, nA4, $0C
	dc.b	nA3, $06, nA4, $0C, nA3, nA4, nF3, $06, nF4, $0C, nF3, $06
	dc.b	nF4, $0C, nF3, $06, nG3, $0C, nG4, $06, nG3, $0C, nG4, nG3
	dc.b	nA3, $06, nA4, $0C, nA3, $06, nA4, $0C, nA3, $06, nA4, $0C
	dc.b	nA3, $06, nA4, $0C, nA3, nA4, nF3, $06, nF4, $0C, nF3, $06
	dc.b	nF4, $0C, nF3, $06, nG3, $0C, nG4, $06, nG3, $0C, nG4, nG3
	dc.b	nF3, nF3, nF3, nC3, $06, nF3, $0C, nF3, nC3, $06, nF3, $0C
	dc.b	nC3, nG3, nG3, nG3, nD3, $06, nG3, $0C, nG3, nD3, $06, nG3
	dc.b	$0C, nD3, nD3, $06, nF3, nA3, nG3, nF3, nE3, nG3, nB3, nD4
	dc.b	nC4, nB3, nA3, nA3, nC4, nE4, nD4, nC4, nB3, nB3, nD4, nF4
	dc.b	nE4, nD4, nC4, nG4, nF4, nE4, nD4, nE4, nD4, nC4, nG3
	smpsReturn

; PSG2 Data
Snd_LRZ1_PSG2:
	smpsPSGvoice        sTone_04

Snd_LRZ1_Jump04:
	smpsCall            Snd_LRZ1_Call06
	dc.b	nC4, $0C, nC4, $06, nC5, $0C, nC4, $06, nE4, nE5, $0C, nE4
	dc.b	$06, nE4, nE5, nD5, nD5, nC5, $0C, nB3, nB3, $06, nB4, $0C
	dc.b	nB3, $06, nE4, nE5, $0C, nE4, $06, nE4, nE4, $1E, nC4, $0C
	dc.b	nC4, $06, nC5, $0C, nC4, $06, nE4, nE5, $0C, nE4, $06, nE4
	dc.b	nE5, nD5, nC5, nA4, $0C, nB3, nB3, $06, nB4, $0C, nB3, $06
	dc.b	nE4, nE5, $0C, nE4, $06, nE4, nE4, $1E
	smpsJump            Snd_LRZ1_Jump04

; Unreachable
	smpsStop

; PSG3 Data
Snd_LRZ1_PSG3:
	smpsPSGvoice        sTone_02
	smpsPSGform         $E7

Snd_LRZ1_Jump03:
	dc.b	nRst, $0C
	smpsPSGvoice        sTone_01
	dc.b	nBb6, $06, nBb6, $5A, nBb6, $06, nBb6, $3C, nBb6, $06
	smpsPSGvoice        sTone_08
	dc.b	nBb6, $18
	smpsPSGvoice        sTone_01
	dc.b	nBb6, $06, nBb6, $5A, nBb6, $06, nBb6, $3C, nBb6, $06
	smpsPSGvoice        sTone_08
	dc.b	nBb6, $18
	smpsPSGvoice        sTone_01
	dc.b	nBb6, $06, nBb6, $5A, nBb6, $06, nBb6, $3C, nBb6, $06
	smpsPSGvoice        sTone_08
	dc.b	nBb6, $18
	smpsPSGvoice        sTone_01
	dc.b	nBb6, $06, nBb6, $5A, nBb6, $06, nBb6, $3C, nBb6, $06
	smpsPSGvoice        sTone_08
	dc.b	nBb6, $18
	smpsPSGvoice        sTone_01
	dc.b	nBb6, $06, nBb6, $5A, nBb6, $06, nBb6, $3C, nBb6, $06
	smpsPSGvoice        sTone_08
	dc.b	nBb6, $18
	smpsPSGvoice        sTone_01
	dc.b	nBb6, $06, nBb6, $5A, nBb6, $06, nBb6, $3C, nBb6, $06
	smpsPSGvoice        sTone_08
	dc.b	nBb6, $48
	smpsPSGvoice        sTone_01
	dc.b	nBb6, $06, nBb6, $12
	smpsPSGvoice        sTone_08
	dc.b	nBb6, $48
	smpsPSGvoice        sTone_01
	dc.b	nBb6, $06, nBb6, $12
	smpsPSGvoice        sTone_08
	dc.b	nBb6, $60, $60, $48
	smpsPSGvoice        sTone_01
	dc.b	nBb6, $06, nBb6, $12
	smpsPSGvoice        sTone_08
	dc.b	nBb6, $5A
	smpsPSGvoice        sTone_01
	dc.b	nBb6, $06
	smpsPSGvoice        sTone_08
	dc.b	nBb6, $5A
	smpsPSGvoice        sTone_01
	dc.b	nBb6, $06
	smpsPSGvoice        sTone_08
	dc.b	nBb6, $60, $0C
	smpsJump            Snd_LRZ1_Jump03

; Unreachable
	smpsStop
