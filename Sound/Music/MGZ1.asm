Snd_MGZ1_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_MGZ1_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $40

	smpsHeaderDAC       Snd_MGZ1_DAC
	smpsHeaderFM        Snd_MGZ1_FM1,	$00, $0C
	smpsHeaderFM        Snd_MGZ1_FM2,	$00, $0D
	smpsHeaderFM        Snd_MGZ1_FM3,	$00, $0D
	smpsHeaderFM        Snd_MGZ1_FM4,	$00, $0D
	smpsHeaderFM        Snd_MGZ1_FM5,	$00, $12
	smpsHeaderPSG       Snd_MGZ1_PSG1,	$E8, $02, $00, $00
	smpsHeaderPSG       Snd_MGZ1_PSG2,	$E8, $02, $00, $00
	smpsHeaderPSG       Snd_MGZ1_PSG3,	$E8, $02, $00, $00

; FM1 Data
Snd_MGZ1_FM1:
	smpsSetvoice        $01
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00

Snd_MGZ1_Loop04:
	dc.b	nCs2, $08, nCs3, $04, nB2, $08, nRst, $04, nB2, $08, nRst, $04
	dc.b	nBb2, $08, nB2, $06, nRst, $2E, nFs2, $08, nFs3, $04, nE3, $08
	dc.b	nRst, $04, nE3, $08, nRst, $04, nEb3, $08, nE3, $06, nRst, $16
	dc.b	nFs2, $18
	smpsLoop            $00, $0A, Snd_MGZ1_Loop04

Snd_MGZ1_Loop05:
	dc.b	nB2, $08, nB3, $04, nB3, $08, nRst, $04, nB2, $08, nRst, $04
	dc.b	nB3, $08, nB2, $06, nRst, $2E, nB2, $08, nB3, $04, nB3, $08
	dc.b	nRst, $04, nB2, $08, nRst, $04, nB3, $08, nB2, $06, nRst, $16
	dc.b	nFs2, $18
	smpsLoop            $00, $03, Snd_MGZ1_Loop05
	dc.b	nB2, $08, nB3, $04, nB3, $08, nRst, $04, nB2, $08, nRst, $04
	dc.b	nB3, $08, nB2, $06, nRst, $2E, nB2, $08, nB3, $04, nB3, $08
	dc.b	nRst, $04, nB2, $08, nRst, $04, nB3, $08, nB2, $06, nRst, $18
	dc.b	nC3, $16
	smpsJump            Snd_MGZ1_FM1

; Unreachable
	smpsStop

; FM2 Data
Snd_MGZ1_FM2:
	smpsSetvoice        $00
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nRst, $60, nRst, nRst, nRst, nRst, $0C, nCs4, nCs4, $06, nRst, nB3
	dc.b	$08, nCs4, $06, nRst, $2E, nRst, $0C, nFs4, nFs4, $04, nRst, $08
	dc.b	nFs4, nE4, $0B, nRst, $05, nEb4, $0C, nCs4, $06, nRst, nB3, nRst
	dc.b	nB3, $11, nRst, $03, nCs4, $06, nRst, $0A, nCs4, $06, nRst, $36
	dc.b	nRst, $60, nRst, $0C, nCs4, nCs4, $06, nRst, nB3, $08, nCs4, $06
	dc.b	nRst, $2E, nRst, $08, nFs4, $0C, nFs4, $04, nFs4, $06, nRst, nE4
	dc.b	$08, nE4, $09, nRst, $07, nEb4, $06, nRst, nCs4, $0C, nB3, $06
	dc.b	nRst, nCs4, $48, nRst, $18, nRst, $60, nRst, $18, nCs5, $06, nRst
	dc.b	$12, nB4, $06, nRst, $12, nBb4, $06, nRst, $12, nAb4, $3C, nBb4
	dc.b	$1E, nAb4, $02, nFs4, nF4, nE4, $60
	smpsSetvoice        $06
	dc.b	nRst, $38, nCs5, $04, nEb5, $08, nE5, $04, nEb5, $08, nCs5, $06
	dc.b	nRst, nCs5, $04
	smpsSetvoice        $00
	dc.b	nRst, $18, nCs5, $06, nRst, $12, nB4, $06, nRst, $12, nBb4, $06
	dc.b	nRst, $12, nAb4, $48, nBb4, $18, nE4, $30, nEb4, $06, nRst, nE4
	dc.b	$24, nCs4, $60
	smpsSetvoice        $07
	dc.b	nRst, $18, nB4, $06, nRst, $12, nEb5, $0C, nE5, $06, nRst, $12
	dc.b	nEb5, $06, nRst, nRst, $0C, nFs5, $06, nRst, $12, nB4, $3C, nB5
	dc.b	$24, nFs5, $06, nG5, nG5, $0C, nFs5, nE5, nFs5, $06, nRst, nRst
	dc.b	$0C, nEb5, $06, nRst, $12, nB4, $3C, nRst, $18, nB4, $06, nRst
	dc.b	$12, nEb5, $0C, nE5, $06, nRst, nEb5, $04, nRst, nEb5, nE5, $0C
	dc.b	nFs5, nEb5, $06, nRst, $12, nB4, $3C, nB5, $24, nFs5, $06, nG5
	dc.b	nFs5, $0C, nE5, nEb5, nCs5, $06, nRst, nRst, $0C, nEb5, $06, nRst
	dc.b	$12, nB4, $24, nRst, $18
	smpsJump            Snd_MGZ1_FM2

; Unreachable
	smpsStop

; FM3 Data
Snd_MGZ1_FM3:
	smpsSetvoice        $02
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panLeft, $00
	dc.b	nRst, $08, nB4, $04
	smpsSetvoice        $08
	dc.b	nB2, $03, nRst, $05, nB2, $04
	smpsSetvoice        $02
	dc.b	nB4, nRst, $14, nB4, nB4, $04, nRst, $0C
	smpsSetvoice        $08
	dc.b	nB2, $03, nRst, $05, nB2, $04
	smpsSetvoice        $03
	dc.b	nRst, $42, nBb4, $02, nB4, nC5, nCs5, $18
	smpsSetvoice        $02
	dc.b	nRst, $08, nB4, $04
	smpsSetvoice        $08
	dc.b	nB2, $03, nRst, $05, nB2, $04
	smpsSetvoice        $02
	dc.b	nB4, nRst, $14, nB4, nB4, $04, nRst, $0C
	smpsSetvoice        $08
	dc.b	nB2, $03, nRst, $05, nB2, $04
	smpsSetvoice        $04
	dc.b	nAb4, $60

Snd_MGZ1_Loop02:
	smpsSetvoice        $02
	dc.b	nRst, $08, nB4, $04
	smpsSetvoice        $08
	dc.b	nB2, $03, nRst, $05, nB2, $04
	smpsSetvoice        $02
	dc.b	nB4, nRst, $14, nB4, nB4, $04, nRst, $0C
	smpsSetvoice        $08
	dc.b	nB2, $03, nRst, $05, nB2, $04
	smpsSetvoice        $03
	dc.b	nRst, $42, nBb4, $02, nB4, nC5, nCs5, $18
	smpsSetvoice        $02
	dc.b	nRst, $08, nB4, $04
	smpsSetvoice        $08
	dc.b	nB2, $03, nRst, $05, nB2, $04
	smpsSetvoice        $02
	dc.b	nB4, nRst, $14, nB4, nB4, $04, nRst, $0C
	smpsSetvoice        $08
	dc.b	nB2, $03, nRst, $05, nB2, $04
	smpsSetvoice        $04
	dc.b	nAb4, $3C
	smpsSetvoice        $09
	dc.b	nFs5, $24
	smpsLoop            $00, $04, Snd_MGZ1_Loop02

Snd_MGZ1_Loop03:
	smpsSetvoice        $05
	dc.b	nE4, $08, nE4, $04, nB3, $06, nRst, nE4, nRst, nG4, $08, nE4
	dc.b	$06, nRst, nB3, $28, nEb4, $08, nEb4, $04, nB3, $06, nRst, nEb4
	dc.b	nRst, nFs4, $08, nEb4, $06, nRst, nRst, $28
	smpsLoop            $00, $03, Snd_MGZ1_Loop03
	dc.b	nE4, $08, nE4, $04, nB3, $06, nRst, nE4, nRst, nG4, $08, nE4
	dc.b	$06, nRst, nB3, $28, nEb4, $08, nEb4, $04, nB3, $06, nRst, nEb4
	dc.b	nRst, nFs4, $08, nEb4, $06, nRst, nRst, $10, nE4, $18
	smpsJump            Snd_MGZ1_FM3

; Unreachable
	smpsStop

; FM4 Data
Snd_MGZ1_FM4:
	smpsSetvoice        $02
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panRight, $00
	dc.b	nRst, $08, nE5, $04
	smpsSetvoice        $08
	dc.b	nE3, $03, nRst, $05, nE3, $04
	smpsSetvoice        $02
	dc.b	nE5, nRst, $14, nE5, nE5, $04, nRst, $0C
	smpsSetvoice        $08
	dc.b	nE3, $03, nRst, $05, nE3, $04
	smpsSetvoice        $03
	dc.b	nRst, $42, nEb5, $02, nE5, nF5, nFs5, $18
	smpsSetvoice        $02
	dc.b	nRst, $08, nE5, $04
	smpsSetvoice        $08
	dc.b	nE3, $03, nRst, $05, nE3, $04
	smpsSetvoice        $02
	dc.b	nE5, nRst, $14, nE5, nE5, $04, nRst, $0C
	smpsSetvoice        $08
	dc.b	nE3, $03, nRst, $05, nE3, $04
	smpsSetvoice        $04
	dc.b	nCs5, $60

Snd_MGZ1_Loop00:
	smpsSetvoice        $02
	dc.b	nRst, $08, nE5, $04
	smpsSetvoice        $08
	dc.b	nE3, $03, nRst, $05, nE3, $04
	smpsSetvoice        $02
	dc.b	nE5, nRst, $14, nE5, nE5, $04, nRst, $0C
	smpsSetvoice        $08
	dc.b	nE3, $03, nRst, $05, nE3, $04
	smpsSetvoice        $03
	dc.b	nRst, $42, nEb5, $02, nE5, nF5, nFs5, $18
	smpsSetvoice        $02
	dc.b	nRst, $08, nE5, $04
	smpsSetvoice        $08
	dc.b	nE3, $03, nRst, $05, nE3, $04
	smpsSetvoice        $02
	dc.b	nE5, nRst, $14, nE5, nE5, $04, nRst, $0C
	smpsSetvoice        $08
	dc.b	nE3, $03, nRst, $05, nE3, $04
	smpsSetvoice        $04
	dc.b	nCs5, $3C
	smpsSetvoice        $09
	dc.b	nB4, $24
	smpsLoop            $00, $04, Snd_MGZ1_Loop00

Snd_MGZ1_Loop01:
	smpsSetvoice        $05
	dc.b	nG4, $08, nG4, $04, nE4, $06, nRst, nG4, nRst, nB4, $08, nG4
	dc.b	$06, nRst, nE4, $28, nFs4, $08, nFs4, $04, nEb4, $06, nRst, nFs4
	dc.b	nRst, nB4, $08, nFs4, $06, nRst, nRst, $28
	smpsLoop            $00, $03, Snd_MGZ1_Loop01
	dc.b	nG4, $08, nG4, $04, nE4, $06, nRst, nG4, nRst, nB4, $08, nG4
	dc.b	$06, nRst, nE4, $28, nFs4, $08, nFs4, $04, nEb4, $06, nRst, nFs4
	dc.b	nRst, nB4, $08, nFs4, $06, nRst, nRst, $10, nA4, $18
	smpsJump            Snd_MGZ1_FM4

; Unreachable
	smpsStop

; FM5 Data
Snd_MGZ1_FM5:
	dc.b	nRst, $0B

Snd_MGZ1_Jump00:
	smpsSetvoice        $00
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nRst, $60, nRst, nRst, nRst, nRst, $0C, nCs4, nCs4, $06, nRst, nB3
	dc.b	$08, nCs4, $06, nRst, $2E, nRst, $0C, nFs4, nFs4, $04, nRst, $08
	dc.b	nFs4, nE4, $0B, nRst, $05, nEb4, $0C, nCs4, $06, nRst, nB3, nRst
	dc.b	nB3, $11, nRst, $03, nCs4, $06, nRst, $0A, nCs4, $06, nRst, $36
	dc.b	nRst, $60, nRst, $0C, nCs4, nCs4, $06, nRst, nB3, $08, nCs4, $06
	dc.b	nRst, $2E, nRst, $08, nFs4, $0C, nFs4, $04, nFs4, $06, nRst, nE4
	dc.b	$08, nE4, $09, nRst, $07, nEb4, $06, nRst, nCs4, $0C, nB3, $06
	dc.b	nRst, nCs4, $48, nRst, $18, nRst, $60, nRst, $18, nCs5, $06, nRst
	dc.b	$12, nB4, $06, nRst, $12, nBb4, $06, nRst, $12, nAb4, $3C, nBb4
	dc.b	$1E, nAb4, $02, nFs4, nF4, nE4, $60
	smpsSetvoice        $06
	dc.b	nRst, $38, nCs5, $04, nEb5, $08, nE5, $04, nEb5, $08, nCs5, $06
	dc.b	nRst, nCs5, $04
	smpsSetvoice        $00
	dc.b	nRst, $18, nCs5, $06, nRst, $12, nB4, $06, nRst, $12, nBb4, $06
	dc.b	nRst, $12, nAb4, $48, nBb4, $18, nE4, $30, nEb4, $06, nRst, nE4
	dc.b	$24, nCs4, $60
	smpsSetvoice        $07
	dc.b	nRst, $18, nB4, $06, nRst, $12, nEb5, $0C, nE5, $06, nRst, $12
	dc.b	nEb5, $06, nRst, nRst, $0C, nFs5, $06, nRst, $12, nB4, $3C, nB5
	dc.b	$24, nFs5, $06, nG5, nG5, $0C, nFs5, nE5, nFs5, $06, nRst, nRst
	dc.b	$0C, nEb5, $06, nRst, $12, nB4, $3C, nRst, $18, nB4, $06, nRst
	dc.b	$12, nEb5, $0C, nE5, $06, nRst, nEb5, $04, nRst, nEb5, nE5, $0C
	dc.b	nFs5, nEb5, $06, nRst, $12, nB4, $3C, nB5, $24, nFs5, $06, nG5
	dc.b	nFs5, $0C, nE5, nEb5, nCs5, $06, nRst, nRst, $0C, nEb5, $06, nRst
	dc.b	$12, nB4, $24, nRst, $18
	smpsJump            Snd_MGZ1_Jump00

; Unreachable
	smpsStop

; DAC Data
Snd_MGZ1_DAC:
	dc.b	dKickS3, $0C, dKickS3, $08, dKickS3, $04, dSnareS3, $0C, dKickS3, $08, dKickS3, $0C
	dc.b	dKickS3, $04, dKickS3, $08, dKickS3, $04, dSnareS3, $18, dKickS3, $0C, dKickS3, $08
	dc.b	dKickS3, $04, dSnareS3, $0C, dKickS3, $08, dKickS3, $10, dKickS3, $08, dKickS3, $04
	dc.b	dSnareS3, $0C, dSnareS3, $08, dSnareS3, $04, dKickS3, $0C, dKickS3, $08, dKickS3, $04
	dc.b	dSnareS3, $0C, dKickS3, $08, dKickS3, $0C, dKickS3, $04, dKickS3, $08, dKickS3, $04
	dc.b	dSnareS3, $18, dKickS3, $0C, dKickS3, $08, dKickS3, $04, dSnareS3, $0C, dKickS3, $08
	dc.b	dKickS3, $10, dKickS3, $04, dKickS3, dKickS3, dSnareS3, $0C, dKickS3
	smpsLoop            $00, $07, Snd_MGZ1_DAC
	smpsJump            Snd_MGZ1_DAC

; Unreachable
	smpsStop

; PSG1 Data
Snd_MGZ1_PSG1:
	smpsStop

; PSG2 Data
Snd_MGZ1_PSG2:
	smpsStop

; Unreachable
	smpsStop

; PSG3 Data
Snd_MGZ1_PSG3:
	smpsStop

Snd_MGZ1_Voices:
;	Voice $00
;	$38
;	$41, $31, $73, $41, 	$1A, $15, $18, $18, 	$02, $0C, $05, $01
;	$00, $0F, $00, $00, 	$1F, $3F, $5F, $1F, 	$2D, $10, $23, $81
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $07, $03, $04
	smpsVcCoarseFreq    $01, $03, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $18, $18, $15, $1A
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $05, $0C, $02
	smpsVcDecayRate2    $00, $00, $0F, $00
	smpsVcDecayLevel    $01, $05, $03, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $23, $10, $2D

;	Voice $01
;	$3B
;	$4C, $41, $40, $40, 	$18, $1F, $1F, $1F, 	$13, $10, $09, $09
;	$00, $00, $00, $00, 	$EF, $EF, $EF, $EF, 	$12, $1B, $0D, $81
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $04, $04, $04
	smpsVcCoarseFreq    $00, $00, $01, $0C
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $18
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $09, $09, $10, $13
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0E, $0E, $0E, $0E
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $0D, $1B, $12

;	Voice $02
;	$3B
;	$71, $17, $13, $71, 	$11, $10, $14, $1A, 	$0C, $09, $0A, $02
;	$00, $06, $04, $07, 	$1F, $EF, $FF, $EF, 	$18, $1E, $1A, $85
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $01, $01, $07
	smpsVcCoarseFreq    $01, $03, $07, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1A, $14, $10, $11
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $0A, $09, $0C
	smpsVcDecayRate2    $07, $04, $06, $00
	smpsVcDecayLevel    $0E, $0F, $0E, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $05, $1A, $1E, $18

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

;	Voice $04
;	$1B
;	$43, $50, $21, $41, 	$08, $07, $06, $0E, 	$10, $00, $06, $05
;	$05, $01, $05, $01, 	$CF, $0F, $DF, $CF, 	$25, $16, $2D, $81
	smpsVcAlgorithm     $03
	smpsVcFeedback      $03
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $02, $05, $04
	smpsVcCoarseFreq    $01, $01, $00, $03
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0E, $06, $07, $08
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $06, $00, $10
	smpsVcDecayRate2    $01, $05, $01, $05
	smpsVcDecayLevel    $0C, $0D, $00, $0C
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $2D, $16, $25

;	Voice $05
;	$34
;	$31, $30, $71, $31, 	$16, $1B, $13, $1F, 	$13, $06, $08, $08
;	$08, $0B, $0C, $0D, 	$9F, $8F, $9F, $8F, 	$0F, $8C, $12, $83
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $07, $03, $03
	smpsVcCoarseFreq    $01, $01, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $13, $1B, $16
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $08, $06, $13
	smpsVcDecayRate2    $0D, $0C, $0B, $08
	smpsVcDecayLevel    $08, $09, $08, $09
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $03, $12, $0C, $0F

;	Voice $06
;	$07
;	$11, $74, $71, $71, 	$9F, $9F, $1F, $1F, 	$0C, $0C, $0C, $0C
;	$0E, $0E, $03, $02, 	$04, $04, $D8, $D8, 	$81, $81, $81, $81
	smpsVcAlgorithm     $07
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $07, $07, $01
	smpsVcCoarseFreq    $01, $01, $04, $01
	smpsVcRateScale     $00, $00, $02, $02
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0C, $0C, $0C, $0C
	smpsVcDecayRate2    $02, $03, $0E, $0E
	smpsVcDecayLevel    $0D, $0D, $00, $00
	smpsVcReleaseRate   $08, $08, $04, $04
	smpsVcTotalLevel    $01, $01, $01, $01

;	Voice $07
;	$2C
;	$21, $11, $42, $51, 	$16, $12, $10, $1E, 	$08, $11, $06, $09
;	$00, $00, $00, $00, 	$5F, $5F, $5F, $5F, 	$11, $81, $13, $88
	smpsVcAlgorithm     $04
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $05, $04, $01, $02
	smpsVcCoarseFreq    $01, $02, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1E, $10, $12, $16
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $09, $06, $11, $08
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $05, $05, $05, $05
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $08, $13, $01, $11

;	Voice $08
;	$2B
;	$05, $27, $64, $42, 	$17, $1F, $1F, $1F, 	$18, $0A, $0B, $09
;	$05, $08, $08, $00, 	$FF, $FF, $FF, $FF, 	$0F, $17, $1B, $81
	smpsVcAlgorithm     $03
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $06, $02, $00
	smpsVcCoarseFreq    $02, $04, $07, $05
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $17
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $09, $0B, $0A, $18
	smpsVcDecayRate2    $00, $08, $08, $05
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $1B, $17, $0F

;	Voice $09
;	$38
;	$4F, $47, $40, $40, 	$1C, $0F, $10, $11, 	$12, $09, $05, $07
;	$0D, $13, $01, $01, 	$2F, $FF, $1F, $1F, 	$1B, $13, $17, $81
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $04, $04, $04
	smpsVcCoarseFreq    $00, $00, $07, $0F
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $11, $10, $0F, $1C
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $07, $05, $09, $12
	smpsVcDecayRate2    $01, $01, $13, $0D
	smpsVcDecayLevel    $01, $01, $0F, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $17, $13, $1B

