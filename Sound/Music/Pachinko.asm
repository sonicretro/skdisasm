Snd_PachBonus_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_PachBonus_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $16

	smpsHeaderDAC       Snd_PachBonus_DAC
	smpsHeaderFM        Snd_PachBonus_FM1,	$00, $0B
	smpsHeaderFM        Snd_PachBonus_FM2,	$00, $07
	smpsHeaderFM        Snd_PachBonus_FM3,	$00, $0B
	smpsHeaderFM        Snd_PachBonus_FM4,	$00, $0B
	smpsHeaderFM        Snd_PachBonus_FM5,	$00, $14
	smpsHeaderPSG       Snd_PachBonus_PSG1,	$E8, $06, $00, $00
	smpsHeaderPSG       Snd_PachBonus_PSG2,	$E8, $02, $00, $00
	smpsHeaderPSG       Snd_PachBonus_PSG3,	$E8, $02, $00, $00

; FM1 Data
Snd_PachBonus_FM1:
	smpsSetvoice        $00
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nRst, $60, nRst

Snd_PachBonus_Jump02:
	smpsSetvoice        $00
	dc.b	nRst, $60, nRst

Snd_PachBonus_Loop06:
	dc.b	nRst, $0C, nD5, nCs5, $06, nRst, $12, nB4, $0C, nA4, $06, nRst
	dc.b	$12, nAb4, $06, nRst, nG4, $08, nAb4, $04, nG4, $08, nAb4, $04
	dc.b	nE4, $08, nB3, $06, nRst, nD4, $34, nRst, $0C, nE4, $08, nD4
	dc.b	$04, nE4, $06, nRst, $12, nAb4, $08, nD4, $04, nFs4, $06, nRst
	dc.b	nE4, nRst, nA4, nRst, nAb4, $24, nA4, $0C, nB4, $30, nRst, $0C
	dc.b	nD5, nCs5, $06, nRst, $12, nB4, $0C, nA4, $06, nRst, $12, nAb4
	dc.b	$06, nRst, nG4, $08, nAb4, $04, nG4, $08, nAb4, $04, nE4, $08
	dc.b	nB3, $06, nRst, nD4, $34, nRst, $0C, nE4, $08, nD4, $04, nE4
	dc.b	$06, nRst, $12, nAb4, $08, nE4, $04, nFs4, $06, nRst, nE4, nRst
	dc.b	nA4, nRst, nAb4, $24, nE4, $3C
	smpsLoop            $00, $02, Snd_PachBonus_Loop06
	dc.b	nRst, $60, nRst, nRst, $18, nG5, nFs5, nE5, nAb4, $08, nA4, $04
	dc.b	nC5, $08, nCs5, $06, nRst, nE5, nRst, nEb5, $34, nRst, $0C
	smpsSetvoice        $03
	dc.b	nCs5, $06, nRst, nB4, $08, nCs5, $06, nRst, $2A, nE5, $10
	smpsSetvoice        $00
	dc.b	nBb4, $08, nB4, $04, nBb4, $08, nFs4, $06, nRst, nCs4, nRst, nBb3
	dc.b	$23, nRst, $11, nRst, $0C, nF4, $08, nFs4, $04, nAb4, $08, nA4
	dc.b	$06, nRst, nB4, nRst, nCs5, nRst, nEb5, nRst, nE5, $10, nEb5, $20
	dc.b	nRst, $04, nC5, $08, nC5, $28
	smpsSetvoice        $03
	dc.b	nEb5, $08, nEb5, $04
	smpsSetvoice        $00
	dc.b	nRst, $0C, nA4, $08, nC5, $04, nCs5, $08, nE5, $06, nRst, $0A
	dc.b	nG5, $06, nRst, nFs5, nRst, nG5, $0C, nA5, $06, nRst
	smpsSetvoice        $03
	dc.b	nG4, $08, nG4, $04, nRst, $30, nFs4, $24
	smpsJump            Snd_PachBonus_Jump02

; Unreachable
	smpsStop

; FM2 Data
Snd_PachBonus_FM2:
	smpsSetvoice        $01
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nE2, $0C, nAb2, nA2, nB2, $08, nE2, $06, nRst, nE2, $04, nAb2
	dc.b	$0C, nA2, nB2, nE2, nAb2, nA2, nB2, $08, nE2, $06, nRst, nE2
	dc.b	$04, nD3, $0C, nCs3, nB2

Snd_PachBonus_Jump01:
	dc.b	nE2, $0C, nAb2, nA2, nB2, $08, nE2, $06, nRst, nE2, $04, nAb2
	dc.b	$0C, nA2, nB2, nE2, nAb2, nA2, nB2, $08, nE2, $06, nRst, nE2
	dc.b	$04, nCs3, $0C, nD3, nEb3

Snd_PachBonus_Loop05:
	dc.b	nE2, $0C, nAb2, nA2, nB2, $08, nE2, $06, nRst, nE2, $04, nAb2
	dc.b	$0C, nA2, nB2, nE2, nAb2, nA2, nB2, $08, nE2, $06, nRst, nE2
	dc.b	$04, nD3, $0C, nCs3, nB2, nE2, nAb2, nA2, nB2, $08, nE2, $06
	dc.b	nRst, nE2, $04, nAb2, $0C, nA2, nB2, nE2, nAb2, nA2, nB2, $08
	dc.b	nE2, $06, nRst, nE2, $04, nCs3, $0C, nD3, nEb3
	smpsLoop            $00, $04, Snd_PachBonus_Loop05
	dc.b	nE2, $0C, nAb2, nA2, nB2, $08, nE3, $06, nRst, nE3, $04, nEb3
	dc.b	$0C, nD3, nB2, nA2, nAb2, nFs2, nF2, nE2, nEb2, nD2, nEb2, nA2
	dc.b	nCs3, nD3, nEb3, $08, nE3, $06, nRst, nE3, $04, nEb3, $0C, nB2
	dc.b	nE2, nAb2, $08, nAb2, $04, nFs2, $0C, nG2, nAb2, nC3, nAb2, nEb3
	dc.b	nC3, nCs3, $08, nCs3, $04, nAb2, $0C, nCs3, nC3, nB2, nFs2, nB2
	dc.b	nFs3, nBb2, $08, nBb2, $04, nFs2, $0C, nBb2, nFs3, nE3, nCs3, nBb2
	dc.b	nE2, nFs2, nA2, nC3, nCs3, $08, nE3, $10, nCs3, $0C, nFs2, nG2
	dc.b	nAb2, nCs3, nD3, nEb3, $08, nFs3, $10, nAb2, $0C, nEb3, nFs3, nA2
	dc.b	nC3, nD3, nEb3, $08, nE3, $10, nG3, $0C, nA3, nE3, nB2, $08
	dc.b	nB2, $06, nRst, $0A, nBb2, $08, nB2, $04, nD3, $08, nEb3, $06
	dc.b	nRst, $0A, nB2, $1E, nRst, $06
	smpsJump            Snd_PachBonus_Jump01

; Unreachable
	smpsStop

; FM3 Data
Snd_PachBonus_FM3:
	smpsSetvoice        $02
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panLeft, $00
	dc.b	nRst, $60, nRst

Snd_PachBonus_Loop04:
	smpsSetvoice        $02
	dc.b	nFs5, $04, nRst, $14, nFs5, $04, nRst, $14, nAb5, $10, nRst, $04
	dc.b	nFs5, nRst, $18, nRst, $08, nFs5, $04, nRst, $0C, nFs5, $04, nRst
	dc.b	$14, nAb5, $10, nRst, $04, nFs5, nRst, $18
	smpsLoop            $00, $0A, Snd_PachBonus_Loop04
	dc.b	nRst, $60, nRst
	smpsSetvoice        $03
	dc.b	nRst, $0C, nE5, $06, nRst, nEb5, $08, nE5, $06, nRst, $12, nB4
	dc.b	$04, nC5, $08, nCs5, $06, nRst, nB5, $10, nCs5, $08, nEb5, $04
	dc.b	nCs5, $08, nBb4, $06, nRst, nFs4, nRst, nCs4, $34, nRst, $60, nRst
	dc.b	$54, nAb5, $08, nAb5, $04, nRst, $0C, nC5, $08, nE5, $04, nFs5
	dc.b	$08, nG5, $06, nRst, $0A, nB5, $06, nRst, nA5, nRst, nB5, $0C
	dc.b	nC6, $06, nRst, nEb5, $08, nEb5, $06, nRst, $2E, nEb5, $24
	smpsJump            Snd_PachBonus_Loop04

; Unreachable
	smpsStop

; FM4 Data
Snd_PachBonus_FM4:
	smpsSetvoice        $02
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panRight, $00
	dc.b	nRst, $60, nRst

Snd_PachBonus_Loop03:
	dc.b	nB5, $08, nE3, $06, nRst, nE4, $04, nB5, $06, nRst, nE4, $08
	dc.b	nE5, $04, nCs6, $10, nRst, $04, nB5, $06, nRst, $0A, nG4, $08
	dc.b	nAb4, $04, nE4, $08, nB5, $04, nE4, $06, nRst, nB5, nRst, nE4
	dc.b	$08, nE5, $04, nCs6, $10, nRst, $04, nB5, $06, nRst, $0A, nG4
	dc.b	$08, nAb4, $04
	smpsLoop            $00, $0A, Snd_PachBonus_Loop03
	dc.b	nE5, $0C, nA4, nCs5, nE5, nFs5, nE5, nCs5, nA4, nEb5, nAb4, nC5
	dc.b	nEb5, nAb5, nAb4, nC5, nEb5, nAb5, nCs5, nE5, nAb5, nFs5, nB4, nEb5
	dc.b	nFs5, nRst, nBb4, nCs5, nFs5, nBb5, nFs5, nCs5, nBb4, nCs5, nFs4, nA4
	dc.b	nCs5, nE5, nCs5, nA4, nFs4, nEb5, nAb4, nB4, nEb5, nAb5, nAb4, nB4
	dc.b	nEb5, nC5, nA4, nC5, nE5, nG5, nE5, nC5, nE5, nRst, $60
	smpsJump            Snd_PachBonus_Loop03

; Unreachable
	smpsStop

; FM5 Data
Snd_PachBonus_FM5:
	dc.b	nRst, $0C
	smpsSetvoice        $00
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nRst, $60, nRst

Snd_PachBonus_Jump00:
	smpsSetvoice        $00
	dc.b	nRst, $60, nRst

Snd_PachBonus_Loop02:
	dc.b	nRst, $0C, nD5, nCs5, $06, nRst, $12, nB4, $0C, nA4, $06, nRst
	dc.b	$12, nAb4, $06, nRst, nG4, $08, nAb4, $04, nG4, $08, nAb4, $04
	dc.b	nE4, $08, nB3, $06, nRst, nD4, $34, nRst, $0C, nE4, $08, nD4
	dc.b	$04, nE4, $06, nRst, $12, nAb4, $08, nD4, $04, nFs4, $06, nRst
	dc.b	nE4, nRst, nA4, nRst, nAb4, $24, nA4, $0C, nB4, $30, nRst, $0C
	dc.b	nD5, nCs5, $06, nRst, $12, nB4, $0C, nA4, $06, nRst, $12, nAb4
	dc.b	$06, nRst, nG4, $08, nAb4, $04, nG4, $08, nAb4, $04, nE4, $08
	dc.b	nB3, $06, nRst, nD4, $34, nRst, $0C, nE4, $08, nD4, $04, nE4
	dc.b	$06, nRst, $12, nAb4, $08, nE4, $04, nFs4, $06, nRst, nE4, nRst
	dc.b	nA4, nRst, nAb4, $24, nE4, $3C
	smpsLoop            $00, $02, Snd_PachBonus_Loop02
	dc.b	nRst, $60, nRst, nRst, $18, nG5, nFs5, nE5, nAb4, $08, nA4, $04
	dc.b	nC5, $08, nCs5, $06, nRst, nE5, nRst, nEb5, $34, nRst, $0C
	smpsSetvoice        $03
	dc.b	nCs5, $06, nRst, nB4, $08, nCs5, $06, nRst, $2A, nE5, $10
	smpsSetvoice        $00
	dc.b	nBb4, $08, nB4, $04, nBb4, $08, nFs4, $06, nRst, nCs4, nRst, nBb3
	dc.b	$23, nRst, $11, nRst, $0C, nF4, $08, nFs4, $04, nAb4, $08, nA4
	dc.b	$06, nRst, nB4, nRst, nCs5, nRst, nEb5, nRst, nE5, $10, nEb5, $20
	dc.b	nRst, $04, nC5, $08, nC5, $28
	smpsSetvoice        $03
	dc.b	nEb5, $08, nEb5, $04
	smpsSetvoice        $00
	dc.b	nRst, $0C, nA4, $08, nC5, $04, nCs5, $08, nE5, $06, nRst, $0A
	dc.b	nG5, $06, nRst, nFs5, nRst, nG5, $0C, nA5, $06, nRst
	smpsSetvoice        $03
	dc.b	nG4, $08, nG4, $04, nRst, $30, nFs4, $24
	smpsJump            Snd_PachBonus_Jump00

; Unreachable
	smpsStop

; DAC Data
Snd_PachBonus_DAC:
	dc.b	nRst, $60, nRst, $30, dSnareS3, $0C, dSnareS3, dSnareS3, dSnareS3, $08, dSnareS3, $04

Snd_PachBonus_Loop00:
	dc.b	dKickS3, $0C, dKickS3, dSnareS3, dKickS3, $08, dSnareS3, $0C, dSnareS3, $04, dKickS3, $0C
	dc.b	dSnareS3, dKickS3, $08, dSnareS3, $04, dKickS3, $0C, dKickS3, dSnareS3, dKickS3, $08, dSnareS3
	dc.b	$0C, dSnareS3, $04, dKickS3, $0C, dSnareS3, $08, dSnareS3, $04, dKickS3, $08, dSnareS3
	dc.b	$04
	smpsLoop            $00, $09, Snd_PachBonus_Loop00
	dc.b	nRst, $60, nRst, $30, dSnareS3, $08, dSnareS3, $04, dSnareS3, $08, dSnareS3, $04
	dc.b	dSnareS3, $08, dSnareS3, $04, dSnareS3, $08, dSnareS3, $04

Snd_PachBonus_Loop01:
	dc.b	dKickS3, $0C, dSnareS3, dKickS3, dSnareS3, $08, dSnareS3, $04, dKickS3, $0C, dSnareS3, $08
	dc.b	dKickS3, $0C, dKickS3, $04, dSnareS3, $08, dSnareS3, $04
	smpsLoop            $00, $07, Snd_PachBonus_Loop01
	dc.b	dKickS3, $14, dKickS3, $04, dSnareS3, $08, dKickS3, $0C, dSnareS3, $04, dKickS3, $08
	dc.b	dSnareS3, $0C, dKickS3, $04, dSnareS3, dSnareS3, dSnareS3, dSnareS3, dSnareS3, dSnareS3
	smpsJump            Snd_PachBonus_Loop00

; Unreachable
	smpsStop

; PSG1 Data
Snd_PachBonus_PSG1:
	smpsModSet          $0D, $01, $01, $06
	dc.b	nRst, $60, nRst

Snd_PachBonus_Loop07:
	dc.b	nRst, $60
	smpsModSet          $0D, $03, $02, $0A
	smpsLoop            $00, $0A, Snd_PachBonus_Loop07
	dc.b	nRst, $18, nD6, nCs6, nA5, nAb5, $30, nE5, $18, nA5, nAb5, $60
	dc.b	nB5, nB5, $18, nD6, nCs6, nA5, nAb5, $30, nE5, $18, nA5, nAb5
	dc.b	$48, nE6, $18, nD6, $60

Snd_PachBonus_Loop08:
	dc.b	nRst, $60
	smpsLoop            $00, $0A, Snd_PachBonus_Loop08
	smpsJump            Snd_PachBonus_Loop07

; Unreachable
	smpsStop

; PSG2 Data
Snd_PachBonus_PSG2:
	smpsStop

; Unreachable
	smpsStop

; PSG3 Data
Snd_PachBonus_PSG3:
	smpsStop

Snd_PachBonus_Voices:
;	Voice $00
;	$38
;	$41, $11, $71, $41, 	$16, $13, $0F, $17, 	$02, $0C, $05, $01
;	$00, $0F, $00, $00, 	$1F, $3F, $5F, $1F, 	$2A, $12, $24, $81
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $07, $01, $04
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $17, $0F, $13, $16
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $05, $0C, $02
	smpsVcDecayRate2    $00, $00, $0F, $00
	smpsVcDecayLevel    $01, $05, $03, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $24, $12, $2A

;	Voice $01
;	$33
;	$54, $50, $11, $11, 	$DF, $5F, $1F, $1F, 	$0C, $0D, $01, $01
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$22, $17, $22, $81
	smpsVcAlgorithm     $03
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $01, $05, $05
	smpsVcCoarseFreq    $01, $01, $00, $04
	smpsVcRateScale     $00, $00, $01, $03
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $01, $0D, $0C
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $22, $17, $22

;	Voice $02
;	$3B
;	$73, $11, $10, $71, 	$1F, $1F, $1F, $1F, 	$0C, $09, $0A, $02
;	$00, $06, $04, $07, 	$1F, $EF, $FF, $EF, 	$21, $26, $13, $83
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $01, $01, $07
	smpsVcCoarseFreq    $01, $00, $01, $03
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $0A, $09, $0C
	smpsVcDecayRate2    $07, $04, $06, $00
	smpsVcDecayLevel    $0E, $0F, $0E, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $03, $13, $26, $21

;	Voice $03
;	$35
;	$61, $01, $61, $71, 	$10, $11, $50, $D1, 	$06, $01, $01, $01
;	$08, $00, $09, $00, 	$8F, $FF, $FF, $FF, 	$17, $88, $88, $8A
	smpsVcAlgorithm     $05
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $06, $00, $06
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $03, $01, $00, $00
	smpsVcAttackRate    $11, $10, $11, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $01, $01, $06
	smpsVcDecayRate2    $00, $09, $00, $08
	smpsVcDecayLevel    $0F, $0F, $0F, $08
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0A, $08, $08, $17

