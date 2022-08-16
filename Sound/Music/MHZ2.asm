Snd_MHZ2_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_MHZ2_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $30

	smpsHeaderDAC       Snd_MHZ2_DAC
	smpsHeaderFM        Snd_MHZ2_FM1,	$00, $0D
	smpsHeaderFM        Snd_MHZ2_FM2,	$00, $0F
	smpsHeaderFM        Snd_MHZ2_FM3,	$00, $0A
	smpsHeaderFM        Snd_MHZ2_FM4,	$00, $0A
	smpsHeaderFM        Snd_MHZ2_FM5,	$00, $13
	smpsHeaderPSG       Snd_MHZ2_PSG1,	$E8, $02, $00, $00
	smpsHeaderPSG       Snd_MHZ2_PSG2,	$E8, $02, $00, $00
	smpsHeaderPSG       Snd_MHZ2_PSG3,	$E8, $02, $00, $00

; FM1 Data
Snd_MHZ2_FM1:
	dc.b	nRst, $60

Snd_MHZ2_Jump05:
	smpsSetvoice        $00
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nRst, $60, nRst, nRst
	smpsSetvoice        $00
	dc.b	nB5, $04, nBb5, nG5, nA5, nFs5, nAb5, nF5, nG5, nE5, nFs5, nEb5
	dc.b	nF5, nD5, nE5, nCs5, nEb5, nC5, nD5, nB4, nCs5, nBb4, nC5, nA4
	dc.b	nB4

Snd_MHZ2_Loop08:
	smpsSetvoice        $02
	dc.b	nB4, $01, nC5, $3B, nD5, $06, nRst, nF5, nRst, nG5, nRst, nE5
	dc.b	$01, nF5, $06, nRst, $05, nCs5, $06, nRst, nC5, nBb4, nRst, nG4
	dc.b	$36, nRst, $0C, nBb4, $18, nC5, $06, nBb4, $05, nC5, $01, nCs5
	dc.b	$06, nRst, nC5, nRst, nEb5, nD5, nRst, nBb4, nRst, $60
	smpsLoop            $00, $02, Snd_MHZ2_Loop08
	dc.b	nRst, $0C, nBb4, $18, nC5, $06, nBb4, nCs5, nRst, nC5, nRst, nBb4
	dc.b	nC5, nRst, nBb4, nRst, $60, nRst, $0C, nBb4, $18, nC5, $06, nBb4
	dc.b	$05, nCs5, $01, nD5, nEb5, $06, nRst, $05, nD5, $06, nRst, nC5
	dc.b	nD5, nRst, nBb4, nRst, $60, nD5, $01, nEb5, $3B, nF5, $06, nRst
	dc.b	$05, nF5, $02, nG5, $06, nRst, $05, nEb5, $06, nRst, nF5, $12
	dc.b	nRst, $06, nCs5, $12, nBb4, $36, nRst, $0B, nA4, $01, nBb4, $18
	dc.b	nC5, $06, nBb4, $05, nB4, $01, nC5, nCs5, $06, nRst, $05, nC5
	dc.b	$06, nRst, nBb4, nC5, nRst, nBb4, nRst, $60
	smpsJump            Snd_MHZ2_Jump05

; Unreachable
	smpsStop

; FM2 Data
Snd_MHZ2_FM2:
	dc.b	nRst, $60

Snd_MHZ2_Jump04:
	smpsSetvoice        $01
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00

Snd_MHZ2_Loop06:
	dc.b	nG2, $06, nA2, nD3, nF3, nRst, nE3, nRst, nD3, nRst, nC3, nRst
	dc.b	nC3, nD3, nD3, $01, nRst, $05, nE3, $0C, nC3, $06, nBb2, nRst
	dc.b	nBb2, nBb2, $02, nRst, $04, nBb2, $02, nRst, $04, nC3, $06, nBb2
	dc.b	nRst, nBb2, nRst, nBb2, $02, nRst, $04, nC3, $0C, nBb2
	smpsLoop            $00, $06, Snd_MHZ2_Loop06

Snd_MHZ2_Loop07:
	dc.b	nFs2, $06, nFs3, nFs2, nRst, nFs2, nRst, nFs2, nRst, nAb2, nRst, nAb2
	dc.b	nRst, nAb2, nRst, nAb2, nAb2, nRst, nBb2, $12, nBb2, $06, nRst, $12
	dc.b	nBb2, $06, nAb2, nA2, nBb2, nRst, $18
	smpsLoop            $00, $02, Snd_MHZ2_Loop07
	dc.b	nC3, $06, nRst, nC3, nRst, nC3, nRst, nC3, nC3, nC3, nRst, nC3
	dc.b	nRst, nC3, nRst, nC3, nC3, nBb2, nRst, nBb2, nRst, nBb2, nRst, nBb2
	dc.b	nBb2, nBb2, nRst, nBb2, nRst, nBb2, nRst, nBb2, nBb2, nFs2, nFs3, nFs2
	dc.b	nRst, nFs2, nRst, nFs2, nRst, nAb2, nRst, nAb2, nRst, nAb2, nRst, nAb2
	dc.b	nAb2, nRst, nBb2, $12, nBb2, $06, nRst, $12, nBb2, $06, nAb2, nA2
	dc.b	nBb2, nRst, $18
	smpsJump            Snd_MHZ2_Jump04

; Unreachable
	smpsStop

; FM3 Data
Snd_MHZ2_FM3:
	dc.b	nRst, $60

Snd_MHZ2_Jump03:
	smpsSetvoice        $03
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panLeft, $00

Snd_MHZ2_Loop04:
	dc.b	nRst, $0C, nG4, $06, nG4, nG4, nG4, nRst, $0C, nG4, $06, nG4
	dc.b	nG4, nG4, nRst, $0C, nG4, $06, nG4, nRst, $60
	smpsLoop            $00, $02, Snd_MHZ2_Loop04

Snd_MHZ2_Loop05:
	dc.b	nRst, $0C, nE4, $06, nE4, nE4, nE4, nRst, $0C, nE4, $06, nE4
	dc.b	nE4, nE4, nRst, $0C, nE4, $06, nE4, nRst, $60, nRst, $0C, nFs4
	dc.b	$06, nFs4, nFs4, nFs4, nRst, $0C, nF4, $06, nF4, nF4, nF4, nRst
	dc.b	$0C, nF4, $06, nF4, nRst, $60
	smpsLoop            $00, $02, Snd_MHZ2_Loop05
	smpsSetvoice        $04
	dc.b	nRst, $06, nFs5, $12, nFs5, $06, nRst, nFs5, nRst, nAb5, nG5, nAb5
	dc.b	nC6, nRst, $18
	smpsSetvoice        $05
	dc.b	nRst, $06, nF4, $12, nF4, $06, nRst, $12, nF4, $06, nEb4, nE4
	dc.b	nF4, nRst
	smpsSetvoice        $06
	dc.b	nBb4, $0C, nC5, $06
	smpsSetvoice        $04
	dc.b	nRst, nFs5, $12, nFs5, $06, nRst, nFs5, nRst, nAb5, nG5, nAb5, nC6
	dc.b	nRst, $18
	smpsSetvoice        $05
	dc.b	nRst, $06, nF4, $12, nF4, $06, nRst, $12, nF4, $06, nEb4, nE4
	dc.b	nF4
	smpsSetvoice        $06
	dc.b	nE4, nEb4, nD4, nCs4, nC4, $30, nC4, $06, nRst, nEb4, nRst, nF4
	dc.b	nG4, nRst, nEb4, nRst, nF4, $12, nF4, $06, nRst, nF4, nRst, nF4
	dc.b	nCs4, nRst, nEb4, nRst, nF4, $12
	smpsSetvoice        $03
	dc.b	nRst, $0C, nFs4, $18, nAb4, $06, nFs4, nBb4, nRst, nAb4, nRst, nFs4
	dc.b	nAb4, nRst, nF4, nRst, $60
	smpsJump            Snd_MHZ2_Jump03

; Unreachable
	smpsStop

; FM4 Data
Snd_MHZ2_FM4:
	dc.b	nRst, $60

Snd_MHZ2_Jump02:
	smpsSetvoice        $03
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panRight, $00

Snd_MHZ2_Loop02:
	dc.b	nRst, $0C, nE4, $06, nE4, nE4, nE4, nRst, $0C, nE4, $06, nE4
	dc.b	nE4, nE4, nRst, $0C, nE4, $06, nE4, nRst, $60
	smpsLoop            $00, $02, Snd_MHZ2_Loop02

Snd_MHZ2_Loop03:
	dc.b	nRst, $0C, nC4, $06, nC4, nC4, nC4, nRst, $0C, nC4, $06, nC4
	dc.b	nC4, nC4, nRst, $0C, nC4, $06, nC4, nRst, $60, nRst, $0C, nCs4
	dc.b	$06, nCs4, nCs4, nCs4, nRst, $0C, nD4, $06, nD4, nD4, nD4, nRst
	dc.b	$0C, nD4, $06, nD4, nRst, $60
	smpsLoop            $00, $02, Snd_MHZ2_Loop03
	smpsSetvoice        $04
	dc.b	nRst, $06, nFs4, $12, nFs4, $06, nRst, nFs4, nRst, nAb4, nG4, nAb4
	dc.b	nC5, nRst, $18
	smpsSetvoice        $05
	dc.b	nRst, $06, nD4, $12, nD4, $06, nRst, $12, nD4, $06, nC4, nCs4
	dc.b	nD4, nRst
	smpsSetvoice        $06
	dc.b	nFs4, $0C, nAb4, $06
	smpsSetvoice        $04
	dc.b	nRst, nFs4, $12, nFs4, $06, nRst, nFs4, nRst, nAb4, nG4, nAb4, nC5
	dc.b	nRst, $18
	smpsSetvoice        $05
	dc.b	nRst, $06, nD4, $12, nD4, $06, nRst, $12, nD4, $06, nC4, nCs4
	dc.b	nD4
	smpsSetvoice        $06
	dc.b	nCs4, nC4, nB3, nBb3, nG3, $30, nG3, $06, nRst, nC4, nRst, nD4
	dc.b	nEb4, nRst, nC4, nRst, nD4, $12, nD4, $06, nRst, nD4, nRst, nD4
	dc.b	nBb3, nRst, nC4, nRst, nD4, $12
	smpsSetvoice        $03
	dc.b	nRst, $0C, nEb4, $18, nEb4, $06, nEb4, nF4, nRst, nEb4, nRst, nD4
	dc.b	nEb4, nRst, nD4, nRst, $60
	smpsJump            Snd_MHZ2_Jump02

; Unreachable
	smpsStop

; FM5 Data
Snd_MHZ2_FM5:
	dc.b	nRst, $60, nRst, $0E

Snd_MHZ2_Jump01:
	smpsSetvoice        $00
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nRst, $60, nRst, nRst
	smpsSetvoice        $00
	dc.b	nB5, $04, nBb5, nG5, nA5, nFs5, nAb5, nF5, nG5, nE5, nFs5, nEb5
	dc.b	nF5, nD5, nE5, nCs5, nEb5, nC5, nD5, nB4, nCs5, nBb4, nC5, nA4
	dc.b	nB4

Snd_MHZ2_Loop01:
	smpsSetvoice        $02
	dc.b	nB4, $01, nC5, $3B, nD5, $06, nRst, nF5, nRst, nG5, nRst, nE5
	dc.b	$01, nF5, $06, nRst, $05, nCs5, $06, nRst, nC5, nBb4, nRst, nG4
	dc.b	$36, nRst, $0C, nBb4, $18, nC5, $06, nBb4, $05, nC5, $01, nCs5
	dc.b	$06, nRst, nC5, nRst, nEb5, nD5, nRst, nBb4, nRst, $60
	smpsLoop            $00, $02, Snd_MHZ2_Loop01
	dc.b	nRst, $0C, nBb4, $18, nC5, $06, nBb4, nCs5, nRst, nC5, nRst, nBb4
	dc.b	nC5, nRst, nBb4, nRst, $60, nRst, $0C, nBb4, $18, nC5, $06, nBb4
	dc.b	$05, nCs5, $01, nD5, nEb5, $06, nRst, $05, nD5, $06, nRst, nC5
	dc.b	nD5, nRst, nBb4, nRst, $60, nD5, $01, nEb5, $3B, nF5, $06, nRst
	dc.b	$05, nF5, $02, nG5, $06, nRst, $05, nEb5, $06, nRst, nF5, $12
	dc.b	nRst, $06, nCs5, $12, nBb4, $36, nRst, $0B, nA4, $01, nBb4, $18
	dc.b	nC5, $06, nBb4, $05, nB4, $01, nC5, nCs5, $06, nRst, $05, nC5
	dc.b	$06, nRst, nBb4, nC5, nRst, nBb4, nRst, $60
	smpsJump            Snd_MHZ2_Jump01

; Unreachable
	smpsStop

; DAC Data
Snd_MHZ2_DAC:
	dc.b	dKickS3, $0C, dSnareS3, dKickS3, dSnareS3, dKickS3, $04, dKickS3, dKickS3, dSnareS3, $0C, dSnareS3
	dc.b	dSnareS3, $06, dSnareS3

Snd_MHZ2_Jump00:
	dc.b	dKickS3, $18, dKickS3, dKickS3, dKickS3, $0C, dSnareS3, $06, dKickS3, dSnareS3, dKickS3, $0C
	dc.b	dKickS3, $12, dSnareS3, $06, dKickS3, $0C, dKickS3, dKickS3, $06, dSnareS3, $0C, dKickS3
	dc.b	dKickS3, $18, dKickS3, dKickS3, dKickS3, $0C, dSnareS3, $06, dKickS3, dSnareS3, dKickS3, $0C
	dc.b	dKickS3, $12, dSnareS3, $06, dKickS3, dSnareS3, $0C, dSnareS3, dSnareS3, $06, dSnareS3, dSnareS3
	dc.b	$0C

Snd_MHZ2_Loop00:
	dc.b	dKickS3, $0C, dSnareS3, dSnareS3, dKickS3, dKickS3, dKickS3, dSnareS3, $18, dSnareS3, $06, dKickS3
	dc.b	$0C, dKickS3, $12, dSnareS3, $06, dKickS3, $0C, dKickS3, dKickS3, $06, dSnareS3, $0C
	dc.b	dKickS3
	smpsLoop            $00, $03, Snd_MHZ2_Loop00
	dc.b	dKickS3, $0C, dSnareS3, dSnareS3, dKickS3, dKickS3, dKickS3, dSnareS3, $18, dSnareS3, $06, dKickS3
	dc.b	$0C, dKickS3, $12, dSnareS3, $06, dKickS3, $0C, dKickS3, dKickS3, $06, dSnareS3, dSnareS3
	dc.b	dSnareS3, dSnareS3, dKickS3, $0C, dSnareS3, dKickS3, dSnareS3, dKickS3, dSnareS3, dSnareS3, dSnareS3, dKickS3
	dc.b	$06, dSnareS3, $12, dSnareS3, $18, dSnareS3, $06, dKickS3, dKickS3, dSnareS3, $0C, dSnareS3
	dc.b	dSnareS3, $06, dKickS3, $0C, dSnareS3, dKickS3, dSnareS3, dKickS3, dSnareS3, dSnareS3, dSnareS3, dKickS3
	dc.b	$06, dSnareS3, $12, dSnareS3, $18, dSnareS3, $06, dKickS3, dKickS3, dKickS3, dSnareS3, dSnareS3
	dc.b	dSnareS3, dSnareS3, dKickS3, $0C, dKickS3, dSnareS3, dKickS3, dKickS3, dKickS3, dSnareS3, dKickS3, dKickS3
	dc.b	dSnareS3, dSnareS3, dKickS3, dSnareS3, dKickS3, $06, dSnareS3, $0C, dSnareS3, dSnareS3, $06, dKickS3
	dc.b	$0C, dSnareS3, dKickS3, dSnareS3, dKickS3, dSnareS3, dSnareS3, dSnareS3, dKickS3, $06, dSnareS3, $12
	dc.b	dSnareS3, $18, dSnareS3, $0C, dKickS3, $04, dKickS3, dKickS3, dSnareS3, $18
	smpsJump            Snd_MHZ2_Jump00

; Unreachable
	smpsStop

; PSG1 Data
Snd_MHZ2_PSG1:
	smpsStop

; PSG2 Data
Snd_MHZ2_PSG2:
	smpsStop

; Unreachable
	smpsStop

; PSG3 Data
Snd_MHZ2_PSG3:
	smpsStop

Snd_MHZ2_Voices:
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

;	Voice $04
;	$1B
;	$63, $50, $21, $41, 	$15, $0F, $16, $13, 	$10, $01, $06, $05
;	$05, $01, $05, $01, 	$CF, $0F, $DF, $CF, 	$21, $12, $2A, $81
	smpsVcAlgorithm     $03
	smpsVcFeedback      $03
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $02, $05, $06
	smpsVcCoarseFreq    $01, $01, $00, $03
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $13, $16, $0F, $15
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $06, $01, $10
	smpsVcDecayRate2    $01, $05, $01, $05
	smpsVcDecayLevel    $0C, $0D, $00, $0C
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $2A, $12, $21

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
;	$14, $76, $72, $71, 	$9F, $9F, $1F, $1F, 	$0C, $0C, $0C, $0C
;	$0E, $0E, $03, $02, 	$0F, $0F, $DF, $DF, 	$81, $81, $81, $81
	smpsVcAlgorithm     $07
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $07, $07, $01
	smpsVcCoarseFreq    $01, $02, $06, $04
	smpsVcRateScale     $00, $00, $02, $02
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0C, $0C, $0C, $0C
	smpsVcDecayRate2    $02, $03, $0E, $0E
	smpsVcDecayLevel    $0D, $0D, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $01, $01, $01

