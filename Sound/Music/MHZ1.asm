Snd_MHZ1_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_MHZ1_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $39

	smpsHeaderDAC       Snd_MHZ1_DAC
	smpsHeaderFM        Snd_MHZ1_FM1,	$00, $0D
	smpsHeaderFM        Snd_MHZ1_FM2,	$00, $0F
	smpsHeaderFM        Snd_MHZ1_FM3,	$00, $0A
	smpsHeaderFM        Snd_MHZ1_FM4,	$00, $0A
	smpsHeaderFM        Snd_MHZ1_FM5,	$00, $16
	smpsHeaderPSG       Snd_MHZ1_PSG1,	$E8, $02, $00, $00
	smpsHeaderPSG       Snd_MHZ1_PSG2,	$E8, $02, $00, $00
	smpsHeaderPSG       Snd_MHZ1_PSG3,	$E8, $02, $00, $00

; FM1 Data
Snd_MHZ1_FM1:
	dc.b	nRst, $60, nRst, $30

Snd_MHZ1_Jump05:
	smpsSetvoice        $00
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nRst, $60, nRst, nRst, nB5, $04, nBb5, nG5, nA5, nFs5, nAb5, nF5
	dc.b	nG5, nE5, nFs5, nEb5, nF5, nD5, nE5, nCs5, nEb5, nC5, nD5, nB4
	dc.b	nCs5, nBb4, nC5, nA4, nB4

Snd_MHZ1_Loop09:
	smpsSetvoice        $02
	dc.b	nB4, $01, nC5, $3B, nD5, $06, nRst, nF5, nRst, nG5, nRst, nE5
	dc.b	$01, nF5, $06, nRst, $05, nCs5, $06, nRst, nC5, $08, nBb4, $06
	dc.b	nRst, nG4, $34, nRst, $0C, nBb4, $18, nC5, $08, nBb4, $03, nC5
	dc.b	$01, nCs5, $06, nRst, nC5, nRst, nEb5, $08, nD5, $06, nRst, nBb4
	dc.b	$04, nRst, $60
	smpsLoop            $00, $02, Snd_MHZ1_Loop09
	dc.b	nRst, $0C, nBb4, $18, nC5, $08, nBb4, $04, nCs5, $06, nRst, nC5
	dc.b	nRst, nBb4, $08, nC5, $06, nRst, nBb4, $04, nRst, $60, nRst, $0C
	dc.b	nBb4, $18, nC5, $08, nBb4, $03, nCs5, $01, nD5, nEb5, $06, nRst
	dc.b	$05, nD5, $06, nRst, nC5, $08, nD5, $06, nRst, nBb4, $04, nRst
	dc.b	$60, nD5, $01, nEb5, $3B, nF5, $06, nRst, $05, nF5, $02, nG5
	dc.b	$06, nRst, $05, nEb5, $06, nRst, nF5, $12, nRst, $06, nCs5, $14
	dc.b	nBb4, $34, nRst, $0B, nA4, $01, nBb4, $18, nC5, $08, nBb4, $03
	dc.b	nB4, $01, nC5, nCs5, $06, nRst, $05, nC5, $06, nRst, nBb4, $08
	dc.b	nC5, $06, nRst, nBb4, $04, nRst, $60
	smpsJump            Snd_MHZ1_Jump05

; Unreachable
	smpsStop

; FM2 Data
Snd_MHZ1_FM2:
	smpsSetvoice        $01
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nD3, $0C, nRst, $18, nD3, $0C, nRst, $18, nD3, $0C, nD3, $0C
	dc.b	nRst, $14, nD3, $03, nRst, $01, nC3, $08, nB2, $04, nA2, $0C

Snd_MHZ1_Jump04:
	smpsSetvoice        $01
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00

Snd_MHZ1_Loop07:
	dc.b	nG2, $08, nA2, $04, nD3, $08, nF3, $06, nRst, nE3, nRst, nD3
	dc.b	nRst, nC3, nRst, nC3, $04, nD3, $08, nD3, $01, nRst, $03, nE3
	dc.b	$0C, nC3, $08, nBb2, $06, nRst, nBb2, $04, nBb2, $08, nBb2, $04
	dc.b	nC3, $08, nBb2, $06, nRst, nBb2, nRst, nBb2, $04, nC3, $0C, nBb2
	smpsLoop            $00, $06, Snd_MHZ1_Loop07

Snd_MHZ1_Loop08:
	dc.b	nFs2, $08, nFs3, $04, nFs2, $06, nRst, nFs2, nRst, nFs2, nRst, nAb2
	dc.b	nRst, nAb2, nRst, nAb2, nRst, nAb2, $08, nAb2, $04, nRst, $08, nBb2
	dc.b	$10, nBb2, $06, nRst, $12, nBb2, $08, nAb2, $04, nA2, $08, nBb2
	dc.b	$06, nRst, $16
	smpsLoop            $00, $02, Snd_MHZ1_Loop08
	dc.b	nC3, $06, nRst, nC3, nRst, nC3, nRst, nC3, $08, nC3, $04, nC3
	dc.b	$06, nRst, nC3, nRst, nC3, nRst, nC3, $08, nC3, $04, nBb2, $06
	dc.b	nRst, nBb2, nRst, nBb2, nRst, nBb2, $08, nBb2, $04, nBb2, $06, nRst
	dc.b	nBb2, nRst, nBb2, nRst, nBb2, $08, nBb2, $04, nFs2, $08, nFs3, $04
	dc.b	nFs2, $06, nRst, nFs2, nRst, nFs2, nRst, nAb2, nRst, nAb2, nRst, nAb2
	dc.b	nRst, nAb2, $08, nAb2, $04, nRst, $08, nBb2, $10, nBb2, $06, nRst
	dc.b	$12, nBb2, $08, nAb2, $04, nA2, $08, nBb2, $06, nRst, $16
	smpsJump            Snd_MHZ1_Jump04

; Unreachable
	smpsStop

; FM3 Data
Snd_MHZ1_FM3:
	smpsSetvoice        $03
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panLeft, $00
	dc.b	nRst, $06, nFs4, $02, nG4, nAb4, nA4, $0A, nRst, $02, nA4, $0A
	dc.b	nRst, $02, nRst, $06, nFs4, $02, nG4, nAb4, nA4, $0A, nRst, $02
	dc.b	nA4, $0A, nRst, $02, nRst, $0C, nA4, $0A, nRst, $02, nRst, $30

Snd_MHZ1_Jump03:
	smpsSetvoice        $03
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panLeft, $00

Snd_MHZ1_Loop05:
	dc.b	nRst, $0C, nG4, $08, nG4, $04, nG4, $08, nG4, $06, nRst, $0A
	dc.b	nG4, $08, nG4, $04, nG4, $08, nG4, $06, nRst, $0A, nG4, $08
	dc.b	nG4, $04, nRst, $60
	smpsLoop            $00, $02, Snd_MHZ1_Loop05

Snd_MHZ1_Loop06:
	dc.b	nRst, $0C, nE4, $08, nE4, $04, nE4, $08, nE4, $06, nRst, $0A
	dc.b	nE4, $08, nE4, $04, nE4, $08, nE4, $06, nRst, $0A, nE4, $08
	dc.b	nE4, $04, nRst, $60, nRst, $0C, nFs4, $08, nFs4, $04, nFs4, $08
	dc.b	nFs4, $06, nRst, $0A, nF4, $08, nF4, $04, nF4, $08, nF4, $06
	dc.b	nRst, $0A, nF4, $08, nF4, $04, nRst, $60
	smpsLoop            $00, $02, Snd_MHZ1_Loop06
	dc.b	nRst, $08, nFs5, $10, nFs5, $06, nRst, nFs5, nRst, nAb5, $08, nG5
	dc.b	$04, nAb5, $08, nC6, $06, nRst, $16, nRst, $08, nF4, $10, nF4
	dc.b	$06, nRst, $12, nF4, $08, nEb4, $04, nE4, $08, nF4, $06, nRst
	dc.b	nBb4, $0C, nC5, $04, nRst, $08, nFs5, $10, nFs5, $06, nRst, nFs5
	dc.b	nRst, nAb5, $08, nG5, $04, nAb5, $08, nC6, $06, nRst, $16, nRst
	dc.b	$08, nF4, $10, nF4, $06, nRst, $12, nF4, $08, nEb4, $04, nE4
	dc.b	$08, nF4, $04, nE4, $08, nEb4, $04, nD4, $08, nCs4, $04, nC4
	dc.b	$30, nC4, $06, nRst, nEb4, nRst, nF4, $08, nG4, $06, nRst, nEb4
	dc.b	$04, nRst, $08, nF4, $10, nF4, $06, nRst, nF4, nRst, nF4, $08
	dc.b	nCs4, $06, nRst, nEb4, nRst, nF4, $10, nRst, $0C, nFs4, $18, nAb4
	dc.b	$08, nFs4, $04, nBb4, $06, nRst, nAb4, nRst, nFs4, $08, nAb4, $06
	dc.b	nRst, nF4, $04, nRst, $60
	smpsJump            Snd_MHZ1_Jump03

; Unreachable
	smpsStop

; FM4 Data
Snd_MHZ1_FM4:
	smpsSetvoice        $03
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panRight, $00
	dc.b	nRst, $06, nEb4, $02, nE4, nF4, nFs4, $0A, nRst, $02, nFs4, $0A
	dc.b	nRst, $02, nRst, $06, nEb4, $02, nE4, nF4, nFs4, $0A, nRst, $02
	dc.b	nFs4, $0A, nRst, $02, nRst, $0C, nFs4, $0A, nRst, $02, nRst, $30

Snd_MHZ1_Jump02:
	smpsSetvoice        $03
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panRight, $00

Snd_MHZ1_Loop03:
	dc.b	nRst, $0C, nE4, $08, nE4, $04, nE4, $08, nE4, $06, nRst, $0A
	dc.b	nE4, $08, nE4, $04, nE4, $08, nE4, $06, nRst, $0A, nE4, $08
	dc.b	nE4, $04, nRst, $60
	smpsLoop            $00, $02, Snd_MHZ1_Loop03

Snd_MHZ1_Loop04:
	dc.b	nRst, $0C, nC4, $08, nC4, $04, nC4, $08, nC4, $06, nRst, $0A
	dc.b	nC4, $08, nC4, $04, nC4, $08, nC4, $06, nRst, $0A, nC4, $08
	dc.b	nC4, $04, nRst, $60, nRst, $0C, nCs4, $08, nCs4, $04, nCs4, $08
	dc.b	nCs4, $06, nRst, $0A, nD4, $08, nD4, $04, nD4, $08, nD4, $06
	dc.b	nRst, $0A, nD4, $08, nD4, $04, nRst, $60
	smpsLoop            $00, $02, Snd_MHZ1_Loop04
	dc.b	nRst, $08, nFs4, $10, nFs4, $06, nRst, nFs4, nRst, nAb4, $08, nG4
	dc.b	$04, nAb4, $08, nC5, $06, nRst, $16, nRst, $08, nD4, $10, nD4
	dc.b	$06, nRst, $12, nD4, $08, nC4, $04, nCs4, $08, nD4, $06, nRst
	dc.b	nFs4, $0C, nAb4, $04, nRst, $08, nFs4, $10, nFs4, $06, nRst, nFs4
	dc.b	nRst, nAb4, $08, nG4, $04, nAb4, $08, nC5, $03, nRst, $19, nRst
	dc.b	$08, nD4, $10, nD4, $06, nRst, $12, nD4, $08, nC4, $04, nCs4
	dc.b	$08, nD4, $04, nCs4, $08, nC4, $04, nB3, $08, nBb3, $04, nG3
	dc.b	$30, nG3, $06, nRst, nC4, nRst, nD4, $08, nEb4, $06, nRst, nC4
	dc.b	$04, nRst, $08, nD4, $10, nD4, $06, nRst, nD4, nRst, nD4, $08
	dc.b	nBb3, $06, nRst, nC4, nRst, nD4, $10, nRst, $0C, nEb4, $18, nEb4
	dc.b	$08, nEb4, $04, nF4, $06, nRst, nEb4, nRst, nD4, $08, nEb4, $06
	dc.b	nRst, nD4, $04, nRst, $60
	smpsJump            Snd_MHZ1_Jump02

; Unreachable
	smpsStop

; FM5 Data
Snd_MHZ1_FM5:
	dc.b	nRst, $60, nRst, $30, nRst, $07

Snd_MHZ1_Jump01:
	smpsSetvoice        $00
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nRst, $60, nRst, nRst, nB5, $04, nBb5, nG5, nA5, nFs5, nAb5, nF5
	dc.b	nG5, nE5, nFs5, nEb5, nF5, nD5, nE5, nCs5, nEb5, nC5, nD5, nB4
	dc.b	nCs5, nBb4, nC5, nA4, nB4

Snd_MHZ1_Loop02:
	smpsSetvoice        $02
	dc.b	nB4, $01, nC5, $3B, nD5, $06, nRst, nF5, nRst, nG5, nRst, nE5
	dc.b	$01, nF5, $06, nRst, $05, nCs5, $06, nRst, nC5, $08, nBb4, $06
	dc.b	nRst, nG4, $34, nRst, $0C, nBb4, $18, nC5, $08, nBb4, $03, nC5
	dc.b	$01, nCs5, $06, nRst, nC5, nRst, nEb5, $08, nD5, $06, nRst, nBb4
	dc.b	$04, nRst, $60
	smpsLoop            $00, $02, Snd_MHZ1_Loop02
	dc.b	nRst, $0C, nBb4, $18, nC5, $08, nBb4, $04, nCs5, $06, nRst, nC5
	dc.b	nRst, nBb4, $08, nC5, $06, nRst, nBb4, $04, nRst, $60, nRst, $0C
	dc.b	nBb4, $18, nC5, $08, nBb4, $03, nCs5, $01, nD5, nEb5, $06, nRst
	dc.b	$05, nD5, $06, nRst, nC5, $08, nD5, $06, nRst, nBb4, $04, nRst
	dc.b	$60, nD5, $01, nEb5, $3B, nF5, $06, nRst, $05, nF5, $02, nG5
	dc.b	$06, nRst, $05, nEb5, $06, nRst, nF5, $12, nRst, $06, nCs5, $14
	dc.b	nBb4, $34, nRst, $0B, nA4, $01, nBb4, $18, nC5, $08, nBb4, $03
	dc.b	nB4, $01, nC5, nCs5, $06, nRst, $05, nC5, $06, nRst, nBb4, $08
	dc.b	nC5, $06, nRst, nBb4, $04, nRst, $60
	smpsJump            Snd_MHZ1_Jump01

; Unreachable
	smpsStop

; DAC Data
Snd_MHZ1_DAC:
	dc.b	dKickS3, $0C, dSnareS3, dSnareS3, dKickS3, dSnareS3, dSnareS3, dKickS3, dSnareS3, dKickS3, $08, dKickS3
	dc.b	$04, dSnareS3, $18, dKickS3, $04, dKickS3, dKickS3

Snd_MHZ1_Jump00:
	dc.b	nRst, $60, dSnareS3, $08, dKickS3, $0C, dKickS3, $10, dSnareS3, $08, dKickS3, $0C
	dc.b	dKickS3, dKickS3, $04, dSnareS3, $0C, dKickS3, nRst, $60, dSnareS3, $08, dKickS3, $0C
	dc.b	dKickS3, $10, dSnareS3, $08, dKickS3, $04, dSnareS3, $0C, dSnareS3, dSnareS3, $08, dSnareS3
	dc.b	$04, dSnareS3, $0C

Snd_MHZ1_Loop00:
	dc.b	dKickS3, $08, dMidTomS3, $04, dMidTomS3, $0C, dSnareS3, dMidTomS3, dLowTomS3, $14, dLowTomS3, $04
	dc.b	dSnareS3, $18
	smpsLoop            $00, $08, Snd_MHZ1_Loop00

Snd_MHZ1_Loop01:
	dc.b	dKickS3, $18, dSnareS3, dLowTomS3, $08, dLowTomS3, $0C, dLowTomS3, $04, dSnareS3, $18, nRst
	dc.b	$08, dKickS3, $10, dSnareS3, $18, dLowTomS3, $08, dLowTomS3, $04, dLowTomS3, $08, dSnareS3
	dc.b	$10, dKickS3, $0C
	smpsLoop            $00, $02, Snd_MHZ1_Loop01
	dc.b	dKickS3, $08, dMidTomS3, $0C, dMidTomS3, $04, dSnareS3, $18, dLowTomS3, $0C, dLowTomS3, dSnareS3
	dc.b	dLowTomS3, $08, dLowTomS3, $04, dKickS3, $08, dMidTomS3, $0C, dMidTomS3, $04, dSnareS3, $18
	dc.b	dLowTomS3, $0C, dLowTomS3, dSnareS3, dLowTomS3, $08, dLowTomS3, $04, dKickS3, $18, dSnareS3, dLowTomS3
	dc.b	$08, dLowTomS3, $0C, dLowTomS3, $04, dSnareS3, $18, nRst, $08, dKickS3, $10, dSnareS3
	dc.b	$18, dLowTomS3, $08, dLowTomS3, $04, dLowTomS3, $08, dSnareS3, $10, dKickS3, $0C
	smpsJump            Snd_MHZ1_Jump00

; Unreachable
	smpsStop

; PSG1 Data
Snd_MHZ1_PSG1:
	smpsStop

; PSG2 Data
Snd_MHZ1_PSG2:
	smpsStop

; Unreachable
	smpsStop

; PSG3 Data
Snd_MHZ1_PSG3:
	smpsStop

Snd_MHZ1_Voices:
;	Voice $00
;	$38
;	$4C, $33, $74, $41, 	$1F, $1F, $1F, $1F, 	$11, $0F, $0D, $0D
;	$00, $0F, $00, $00, 	$FF, $FF, $FF, $FF, 	$21, $16, $26, $81
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $07, $03, $04
	smpsVcCoarseFreq    $01, $04, $03, $0C
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0D, $0D, $0F, $11
	smpsVcDecayRate2    $00, $00, $0F, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $26, $16, $21

;	Voice $01
;	$35
;	$40, $30, $50, $30, 	$18, $1F, $1F, $1F, 	$0D, $0B, $09, $09
;	$00, $00, $00, $00, 	$EF, $EF, $EF, $EF, 	$14, $85, $85, $85
	smpsVcAlgorithm     $05
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $05, $03, $04
	smpsVcCoarseFreq    $00, $00, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $18
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $09, $09, $0B, $0D
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0E, $0E, $0E, $0E
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $05, $05, $05, $14

;	Voice $02
;	$3B
;	$71, $12, $13, $71, 	$11, $10, $14, $1A, 	$0C, $09, $0A, $02
;	$00, $06, $04, $07, 	$1F, $EF, $FF, $EF, 	$1B, $24, $24, $81
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $01, $01, $07
	smpsVcCoarseFreq    $01, $03, $02, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1A, $14, $10, $11
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $0A, $09, $0C
	smpsVcDecayRate2    $07, $04, $06, $00
	smpsVcDecayLevel    $0E, $0F, $0E, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $24, $24, $1B

;	Voice $03
;	$34
;	$61, $03, $00, $61, 	$1F, $1E, $51, $D0, 	$0C, $08, $01, $01
;	$08, $00, $09, $00, 	$8F, $FF, $FF, $FF, 	$11, $85, $19, $86
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $06, $00, $00, $06
	smpsVcCoarseFreq    $01, $00, $03, $01
	smpsVcRateScale     $03, $01, $00, $00
	smpsVcAttackRate    $10, $11, $1E, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $01, $08, $0C
	smpsVcDecayRate2    $00, $09, $00, $08
	smpsVcDecayLevel    $0F, $0F, $0F, $08
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $06, $19, $05, $11

