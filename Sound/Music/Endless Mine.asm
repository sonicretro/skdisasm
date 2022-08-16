Snd_EMZ_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_EMZ_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $1C

	smpsHeaderDAC       Snd_EMZ_DAC
	smpsHeaderFM        Snd_EMZ_FM1,	$00, $10
	smpsHeaderFM        Snd_EMZ_FM2,	$00, $0F
	smpsHeaderFM        Snd_EMZ_FM3,	$00, $0E
	smpsHeaderFM        Snd_EMZ_FM4,	$00, $0E
	smpsHeaderFM        Snd_EMZ_FM5,	$00, $1D
	smpsHeaderPSG       Snd_EMZ_PSG1,	$E8, $05, $00, $00
	smpsHeaderPSG       Snd_EMZ_PSG2,	$E8, $02, $00, $00
	smpsHeaderPSG       Snd_EMZ_PSG3,	$E8, $02, $00, $00

; FM1 Data
Snd_EMZ_FM1:
	smpsSetvoice        $00
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nG5, $06, nG5, nG5, nRst, $4E

Snd_EMZ_Jump01:
	dc.b	nRst, $60, nRst, nRst, nRst
	smpsSetvoice        $06
	dc.b	nG5, nC5, nF5, nG5
	smpsSetvoice        $03
	dc.b	nRst, $0C, nC5, nB4, nC5, nG5, $12, nC5, nB4, $0C, nB4, $12
	dc.b	nC5, nA4, $2F, nRst, $0D, nG5, $12, nF5, nE5, $0C, nF5, $12
	dc.b	nE5, nD5, $0C, nC5, $12, nB4, nG4, $24, nRst, $18, nRst, $0C
	dc.b	nC5, nB4, nC5, nG5, $12, nC5, nB4, $0C, nB4, $12, nC5, nA4
	dc.b	$30, nRst, $0C, nG5, $12, nF5, nE5, $0C, nF5, $12, nG5, nA5
	dc.b	$0C, nC6, $12, nB5, nC6, $0C, nD6, $24, nRst, $0C
	smpsSetvoice        $05
	dc.b	nC5, $4E, nE4, $06, nA4, nC5, nD5, $30, nG4, nA4, nA4, $06
	dc.b	nD4, nE4, nG4, nAb4, nA4, nC5, nE5, nD5, $24, nA4, $3C
	smpsSetvoice        $04
	dc.b	nF4, $06, nC4, nG4, nC4, nA4, nC4, nF4, nC4, nG4, nC4, nA4
	dc.b	nC4, nB4, nC4, nA4, nC4, nG4, nD4, nA4, nD4, nB4, nD4, nG4
	dc.b	nD4, nA4, nD4, nB4, nD4, nD5, nD4, nC5, $0C
	smpsSetvoice        $07
	dc.b	nE5, $06, nRst, nA4, $0C, nC5, nD5, nE5, $12, nD5, nC5, $0C
	dc.b	nAb4, $12, nC5, nE5, $30, nD5, $06, nC5, nG4, $12, nC5, nE5
	dc.b	$18, nE5, $0C, nD5, nC5, nD5, $12, nA4, nFs4, $3C
	smpsSetvoice        $05
	dc.b	nF4, nC4, $0C, nF4, nA4, nG4, $24, nA4, $0C, nB4, $30, nA4
	dc.b	$7F, smpsNoAttack, nA4, $1D, nA4, $0C, nB4, nC5, nD5, $60, nD5, $06
	dc.b	nD5, nRst, $54
	smpsJump            Snd_EMZ_Jump01

; Unreachable
	smpsStop

; FM2 Data
Snd_EMZ_FM2:
	smpsSetvoice        $01
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nB1, $06, nB1, nG1, nRst, $2A, nG1, $0C, nB1, nG1

Snd_EMZ_Loop03:
	dc.b	nC2, $12, nG2, $06, nG2, $12, nC2, $06, nC2, $12, nG2, $06
	dc.b	nG2, $0C, nC2, nA1, $12, nE2, $06, nE2, $12, nA1, $06, nA1
	dc.b	$12, nE2, $06, nE2, $0C, nA1, nF1, $12, nC2, $06, nC2, $12
	dc.b	nF1, $06, nF1, $12, nC2, $06, nC2, $0C, nF1, nG1, $12, nD2
	dc.b	$06, nD2, $12, nG1, $06, nG1, $12, nD2, $06, nD2, $0C, nG1
	smpsLoop            $00, $04, Snd_EMZ_Loop03
	dc.b	nF1, $12, nC2, $06, nC2, $12, nF1, $06, nF1, $12, nC2, $06
	dc.b	nC2, $0C, nF1, nG1, $12, nD2, $06, nD2, $12, nG1, $06, nG1
	dc.b	$12, nD2, $06, nD2, $0C, nG1, nA1, $12, nE2, $06, nE2, $12
	dc.b	nA1, $06, nA1, $12, nE2, $06, nE2, $0C, nA1, nD2, $12, nA1
	dc.b	$06, nA1, $12, nD2, $06, nD2, $12, nA1, $06, nA1, $0C, nD2
	dc.b	nF1, $12, nC2, $06, nC2, $12, nF1, $06, nF1, $12, nC2, $06
	dc.b	nC2, $0C, nF1, nG1, $12, nD2, $06, nD2, $12, nG1, $06, nG1
	dc.b	$12, nD2, $06, nD2, $0C, nG1

Snd_EMZ_Loop04:
	dc.b	nA1, $12, nE2, $06, nE2, $12, nA1, $06, nA1, $12, nE2, $06
	dc.b	nE2, $0C, nA1
	smpsLoop            $00, $03, Snd_EMZ_Loop04
	dc.b	nFs1, $12, nD2, $06, nD2, $0C, nFs1, nFs2, $12, nFs1, $06, nD2
	dc.b	$0C, nFs1, nF1, $12, nC2, $06, nC2, $12, nF1, $06, nF1, $12
	dc.b	nC2, $06, nC2, $0C, nF1, nG1, $12, nD2, $06, nD2, $12, nG1
	dc.b	$06, nG1, $12, nD2, $06, nD2, $0C, nG1, nA1, $12, nF2, $06
	dc.b	nF2, $12, nA1, $06, nA1, $12, nF2, $06, nF2, $0C, nA1, nA1
	dc.b	$12, nF2, $06, nF2, $12, nA1, $06, nA1, $12, nF2, $06, nF2
	dc.b	$0C, nA1, nB1, $12, nG2, $06, nG2, $12, nB1, $06, nB1, $12
	dc.b	nG2, $06, nG2, $0C, nB1, nB1, $06, nB1, nRst, $30, nG1, $0C
	dc.b	nB1, nG1
	smpsJump            Snd_EMZ_Loop03

; Unreachable
	smpsStop

; FM3 Data
Snd_EMZ_FM3:
	smpsSetvoice        $00
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panRight, $00
	dc.b	nD5, $06, nD5, nD5, nRst, $4E

Snd_EMZ_Loop02:
	smpsSetvoice        $02
	dc.b	nC3, $06, nC4, nE5, nC4, nD5, $12, nC5, $06, nRst, nC5, nC4
	dc.b	$0C, nB4, nA4, nRst, $06, nA3, nE5, nA3, nD5, $12, nC5, $06
	dc.b	nRst, nD5, nA3, $0C, nA4, nB4, $06, nA4, nA2, nA3, nA4, nA3
	dc.b	nB4, $12, nC5, $06, nRst, nB4, nA3, $0C, nB4, nC5, nG2, $06
	dc.b	nG3, nC5, nG3, nB4, $12, nA4, $06, nRst, nD5, nG3, $0C, nB4
	dc.b	nC5, $06, nB4
	smpsLoop            $00, $04, Snd_EMZ_Loop02
	dc.b	nF3, $06, nRst, nC5, nRst, nF3, nC5, nRst, nF3, nF2, nRst, nA4
	dc.b	nF3, nC5, nRst, nF2, nF3, nG3, nRst, nB4, nRst, nG3, nG4, nRst
	dc.b	nG3, nG2, nRst, nB4, nG3, nC5, nRst, nG3, nG2, nA2, nA3, nC5
	dc.b	nRst, nA3, nC5, nRst, nA3, nA2, nRst, nA4, nA3, nC5, nRst, nA2
	dc.b	nA3, nA3, nRst, nC5, nRst, nD3, nC5, nRst, nD3, nD2, nRst, nFs4
	dc.b	nD3, nC5, nRst, nD3, nE3, nF3, nRst, nA4, nRst, nF3, nA4, nRst
	dc.b	nF3, nRst, $0C, nF3, $06, nF2, nA4, nRst, nF3, nRst, nG3, nG2
	dc.b	nB4, nRst, nG3, nB4, nRst, nG3, nRst, $0C, nG2, $06, nG3, nB4
	dc.b	nRst, nG3, nRst, nA2, nA3, nC5, nA3, nC5, $0C, nRst, $06, nC5
	dc.b	nRst, nC5, nA3, nA3, nC5, $0C, nA4, nRst, $06, nA3, nC5, nA3
	dc.b	nC5, $12, nC5, $06, nRst, nC5, nA3, $0C, nC5, nC5, $06, nAb4
	dc.b	nA2, nA3, nC5, nA3, nC5, $0C, nRst, $06, nC5, nRst, nC5, nA3
	dc.b	nA3, nC5, $0C, nC5, nRst, $06, nFs3, nA4, nFs3, nA4, $0C, nRst
	dc.b	$06, nA4, nRst, nA4, nFs3, $0C, nA4, nA4, $06, nFs4, nF2, nF3
	dc.b	nC5, nF3, nC5, $0C, nRst, $06, nC5, nRst, nC5, nF3, nF3, nC5
	dc.b	$0C, nC5, nRst, $06, nG3, nD5, nG3, nD5, $0C, nRst, $06, nD5
	dc.b	nRst, nD5, nG3, $0C, nA4, nB4, $06, nA4, nA2, nA3, nA4, nA3
	dc.b	nA4, $0C, nRst, $06, nA4, nRst, nA4, nA3, nA3, nA4, $0C, nA4
	dc.b	nRst, nA4, $06, nA3, nC5, $0C, nRst, $06, nA4, nRst, nC5, nA2
	dc.b	nA3, nF5, $0C, nC5, $06, nA4, nB3, nB3, nB4, nRst, nB3, nB4
	dc.b	nB2, nF5, nRst, nB4, nB2, nB3, nB4, nB3, nB3, nRst, nD5, nD5
	dc.b	nRst, $54
	smpsJump            Snd_EMZ_Loop02

; Unreachable
	smpsStop

; FM4 Data
Snd_EMZ_FM4:
	smpsSetvoice        $00
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panLeft, $00
	dc.b	nA4, $06, nA4, nA4, nRst, $4E

Snd_EMZ_Loop01:
	smpsSetvoice        $02
	dc.b	nRst, $0C, nC5, $06, nRst, nB4, $0C, nC4, $06, nA4, nRst, nA4
	dc.b	nRst, nC3, nG4, nC3, nF4, $0C, nA2, nC5, $05, nRst, $07, nB4
	dc.b	$0C, nA3, $06, nA4, nRst, nB4, nRst, nA2, nF4, nA2, nG4, nF4
	dc.b	nRst, $0C, nF4, $06, nRst, nG4, $0C, nA3, $06, nA4, nRst, nG4
	dc.b	nRst, nA2, nG4, nA2, nA4, nRst, nRst, $0C, nG4, $06, nRst, nG4
	dc.b	$0C, nG3, $06, nF4, nRst, nB4, nRst, nG2, nG4, nA2, nG4, nG4
	smpsLoop            $00, $04, Snd_EMZ_Loop01
	dc.b	nRst, $06, nF2, nA4, nRst, $0C, nA4, $06, nRst, $18, nF4, $06
	dc.b	nRst, nA4, nRst, $12, nRst, $06, nG2, nG4, nRst, $0C, nD4, $06
	dc.b	nRst, $18, nG4, $06, nRst, nG4, nRst, $12, nRst, $0C, nA4, $06
	dc.b	nRst, $0C, nA4, $06, nRst, $18, nE4, $06, nRst, nA4, nRst, $12
	dc.b	nD3, $06, nD2, nFs4, nRst, $0C, nFs4, $06, nRst, $18, nD4, $06
	dc.b	nRst, nFs4, nRst, $12, nRst, $06, nF2, nF4, nRst, $0C, nF4, $06
	dc.b	nRst, $24, nF4, $06, nRst, $12, nRst, $0C, nG4, $06, nRst, $0C
	dc.b	nG4, $06, nRst, $24, nG4, $06, nRst, $12, nRst, $0C, nA4, $06
	dc.b	nRst, nA4, $0C, nA3, $06, nA4, nRst, nA4, nRst, $0C, nA4, $06
	dc.b	nA3, nE4, $0C, nA2, nAb4, $06, nRst, nAb4, $0C, nA3, $06, nAb4
	dc.b	nRst, nAb4, nRst, nA2, nAb4, nA2, nAb4, nE4, nRst, $0C, nG4, $06
	dc.b	nRst, nG4, $0C, nA3, $06, nG4, nRst, nG4, nRst, $0C, nG4, $06
	dc.b	nA3, nG4, $0C, nFs2, nFs4, $06, nRst, nFs4, $0C, nFs3, $06, nFs4
	dc.b	nRst, nFs4, nRst, nFs2, nFs4, nFs3, nFs4, nD4, nRst, $0C, nA4, $06
	dc.b	nRst, nA4, $0C, nF3, $06, nA4, nRst, nA4, nRst, $0C, nA4, $06
	dc.b	nF3, nA4, $0C, nG2, nB4, $06, nRst, nB4, nRst, nG3, nB4, nRst
	dc.b	nB4, nRst, nG2, nF4, nG3, nG4, nF4, nRst, $0C, nF4, $06, nRst
	dc.b	nF4, $0C, nA2, $06, nF4, nRst, nF4, nRst, $0C, nF4, $06, nA3
	dc.b	nF4, $0C, nA3, $06, nA2, nF4, nRst, nF4, $0C, nA3, $06, nF4
	dc.b	nRst, nF4, nRst, $0C, nC5, $06, nA3, nF4, nF4, nRst, $0C, nG4
	dc.b	$06, nRst, $0C, nG4, $06, nRst, nD5, nRst, nG4, nRst, $0C, nG4
	dc.b	$06, nRst, $12, nG4, $06, nG4, nRst, $54
	smpsJump            Snd_EMZ_Loop01

; Unreachable
	smpsStop

; FM5 Data
Snd_EMZ_FM5:
	dc.b	nRst, $08
	smpsSetvoice        $00
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nG5, $06, nG5, nG5, nRst, $4E

Snd_EMZ_Jump00:
	dc.b	nRst, $60, nRst, nRst, nRst
	smpsSetvoice        $06
	dc.b	nG5, nC5, nF5, nG5
	smpsSetvoice        $03
	dc.b	nRst, $0C, nC5, nB4, nC5, nG5, $12, nC5, nB4, $0C, nB4, $12
	dc.b	nC5, nA4, $2F, nRst, $0D, nG5, $12, nF5, nE5, $0C, nF5, $12
	dc.b	nE5, nD5, $0C, nC5, $12, nB4, nG4, $24, nRst, $18, nRst, $0C
	dc.b	nC5, nB4, nC5, nG5, $12, nC5, nB4, $0C, nB4, $12, nC5, nA4
	dc.b	$30, nRst, $0C, nG5, $12, nF5, nE5, $0C, nF5, $12, nG5, nA5
	dc.b	$0C, nC6, $12, nB5, nC6, $0C, nD6, $24, nRst, $0C
	smpsSetvoice        $05
	dc.b	nC5, $4E, nE4, $06, nA4, nC5, nD5, $30, nG4, nA4, nA4, $06
	dc.b	nD4, nE4, nG4, nAb4, nA4, nC5, nE5, nD5, $24, nA4, $3C
	smpsSetvoice        $04
	dc.b	nF4, $06, nC4, nG4, nC4, nA4, nC4, nF4, nC4, nG4, nC4, nA4
	dc.b	nC4, nB4, nC4, nA4, nC4, nG4, nD4, nA4, nD4, nB4, nD4, nG4
	dc.b	nD4, nA4, nD4, nB4, nD4, nD5, nD4, nC5, $0C
	smpsSetvoice        $07
	dc.b	nE5, $06, nRst, nA4, $0C, nC5, nD5, nE5, $12, nD5, nC5, $0C
	dc.b	nAb4, $12, nC5, nE5, $30, nD5, $06, nC5, nG4, $12, nC5, nE5
	dc.b	$18, nE5, $0C, nD5, nC5, nD5, $12, nA4, nFs4, $3C
	smpsSetvoice        $05
	dc.b	nF4, nC4, $0C, nF4, nA4, nG4, $24, nA4, $0C, nB4, $30, nA4
	dc.b	$7F, smpsNoAttack, nA4, $1D, nA4, $0C, nB4, nC5, nD5, $60, nD5, $06
	dc.b	nD5, nRst, $54
	smpsJump            Snd_EMZ_Jump00

; Unreachable
	smpsStop

; DAC Data
Snd_EMZ_DAC:
	dc.b	dKickS3, $06, dKickS3, dKickS3, $54

Snd_EMZ_Loop00:
	dc.b	dKickS3, $18, dKickS3, dKickS3, dKickS3, $0C, dSnareS3, $06, dSnareS3, dKickS3, $18, dKickS3
	dc.b	dKickS3, dKickS3, $0C, dSnareS3
	smpsLoop            $00, $0F, Snd_EMZ_Loop00
	dc.b	dKickS3, $18, dKickS3, dKickS3, dKickS3, $0C, dSnareS3, $06, dSnareS3, dSnareS3, dSnareS3, $12
	dc.b	dKickS3, $18, dKickS3, dKickS3
	smpsJump            Snd_EMZ_Loop00

; Unreachable
	smpsStop

; PSG1 Data
Snd_EMZ_PSG1:
	smpsModSet          $0D, $01, $02, $06
	dc.b	nD5, $06, nD5, nD5, nRst, $4E

Snd_EMZ_Jump02:
	dc.b	nRst, $60, nRst, nRst, nRst, nC5, $0C, nRst, $54, nA4, $0C, nRst
	dc.b	$54, nC5, $0C, nRst, $54, nB4, $0C, nRst, $54, nRst, $60, nRst
	dc.b	nRst, nRst, nRst, nRst, nRst, nRst, nRst, $1E, nA4, $06, nC5, nD5
	dc.b	nF5, nRst, nE5, nRst, nD5, nA4, nRst, $0C, nRst, $60, nRst, nRst
	dc.b	nRst, $18, nC6, nB5, nA5, nRst, nE5, nD5, nG5, nA5, $60, nAb5
	dc.b	$48, nE6, $18, nG5, $60, nFs5, $24, nD6, $3C, nA4, nF4, $0C
	dc.b	nA4, nC5, nB4, $24, nC5, $0C, nD5, $30, nC5, $48, nE5, $18
	dc.b	nD5, $24, nC5, $18, nC5, $0C, nD5, nE5, nG5, $60, nG5, $06
	dc.b	nG5, nRst, $54
	smpsJump            Snd_EMZ_Jump02

; Unreachable
	smpsStop

; PSG2 Data
Snd_EMZ_PSG2:
	smpsStop

; Unreachable
	smpsStop

; PSG3 Data
Snd_EMZ_PSG3:
	smpsStop

Snd_EMZ_Voices:
;	Voice $00
;	$2D
;	$41, $51, $61, $41, 	$11, $1F, $5F, $1F, 	$04, $08, $08, $04
;	$00, $0F, $00, $00, 	$18, $38, $58, $18, 	$13, $8D, $8C, $8C
	smpsVcAlgorithm     $05
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $06, $05, $04
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $00, $01, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $11
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $04, $08, $08, $04
	smpsVcDecayRate2    $00, $00, $0F, $00
	smpsVcDecayLevel    $01, $05, $03, $01
	smpsVcReleaseRate   $08, $08, $08, $08
	smpsVcTotalLevel    $0C, $0C, $0D, $13

;	Voice $01
;	$0C
;	$74, $11, $71, $11, 	$1F, $5F, $1F, $1F, 	$10, $0D, $03, $04
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$17, $81, $15, $81
	smpsVcAlgorithm     $04
	smpsVcFeedback      $01
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $07, $01, $07
	smpsVcCoarseFreq    $01, $01, $01, $04
	smpsVcRateScale     $00, $00, $01, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $04, $03, $0D, $10
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $15, $01, $17

;	Voice $02
;	$03
;	$75, $53, $20, $11, 	$1F, $1F, $1F, $1F, 	$0A, $08, $09, $0B
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$15, $23, $2B, $82
	smpsVcAlgorithm     $03
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $02, $05, $07
	smpsVcCoarseFreq    $01, $00, $03, $05
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0B, $09, $08, $0A
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $02, $2B, $23, $15

;	Voice $03
;	$3D
;	$42, $01, $01, $61, 	$14, $19, $57, $D6, 	$06, $00, $00, $00
;	$08, $00, $09, $00, 	$8F, $FF, $FF, $FF, 	$23, $8C, $8C, $8C
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $06, $00, $00, $04
	smpsVcCoarseFreq    $01, $01, $01, $02
	smpsVcRateScale     $03, $01, $00, $00
	smpsVcAttackRate    $16, $17, $19, $14
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $06
	smpsVcDecayRate2    $00, $09, $00, $08
	smpsVcDecayLevel    $0F, $0F, $0F, $08
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0C, $0C, $0C, $23

;	Voice $04
;	$03
;	$61, $51, $21, $41, 	$10, $10, $0F, $15, 	$07, $01, $06, $05
;	$05, $01, $05, $01, 	$CF, $0F, $DF, $CF, 	$1D, $1E, $14, $81
	smpsVcAlgorithm     $03
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $02, $05, $06
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $15, $0F, $10, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $06, $01, $07
	smpsVcDecayRate2    $01, $05, $01, $05
	smpsVcDecayLevel    $0C, $0D, $00, $0C
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $14, $1E, $1D

;	Voice $05
;	$02
;	$74, $51, $13, $31, 	$90, $D9, $0F, $13, 	$06, $01, $01, $03
;	$0C, $13, $0C, $0B, 	$FF, $EF, $DF, $8F, 	$1B, $15, $17, $85
	smpsVcAlgorithm     $02
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $01, $05, $07
	smpsVcCoarseFreq    $01, $03, $01, $04
	smpsVcRateScale     $00, $00, $03, $02
	smpsVcAttackRate    $13, $0F, $19, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $01, $01, $06
	smpsVcDecayRate2    $0B, $0C, $13, $0C
	smpsVcDecayLevel    $08, $0D, $0E, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $05, $17, $15, $1B

;	Voice $06
;	$10
;	$45, $50, $64, $41, 	$1F, $1F, $5F, $1F, 	$04, $08, $08, $04
;	$00, $0F, $00, $00, 	$18, $38, $58, $18, 	$20, $25, $1C, $88
	smpsVcAlgorithm     $00
	smpsVcFeedback      $02
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $06, $05, $04
	smpsVcCoarseFreq    $01, $04, $00, $05
	smpsVcRateScale     $00, $01, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $04, $08, $08, $04
	smpsVcDecayRate2    $00, $00, $0F, $00
	smpsVcDecayLevel    $01, $05, $03, $01
	smpsVcReleaseRate   $08, $08, $08, $08
	smpsVcTotalLevel    $08, $1C, $25, $20

;	Voice $07
;	$10
;	$45, $51, $64, $41, 	$1F, $1F, $5F, $1F, 	$0C, $0A, $08, $04
;	$00, $0F, $00, $00, 	$18, $38, $58, $18, 	$20, $25, $1C, $86
	smpsVcAlgorithm     $00
	smpsVcFeedback      $02
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $06, $05, $04
	smpsVcCoarseFreq    $01, $04, $01, $05
	smpsVcRateScale     $00, $01, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $04, $08, $0A, $0C
	smpsVcDecayRate2    $00, $00, $0F, $00
	smpsVcDecayLevel    $01, $05, $03, $01
	smpsVcReleaseRate   $08, $08, $08, $08
	smpsVcTotalLevel    $06, $1C, $25, $20

