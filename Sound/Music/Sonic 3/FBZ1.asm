Snd_FBZ1_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_FBZ1_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $00

	smpsHeaderDAC       Snd_FBZ1_DAC
	smpsHeaderFM        Snd_FBZ1_FM1,	$00, $0A
	smpsHeaderFM        Snd_FBZ1_FM2,	$00, $0A
	smpsHeaderFM        Snd_FBZ1_FM3,	$00, $0D
	smpsHeaderFM        Snd_FBZ1_FM4,	$00, $0D
	smpsHeaderFM        Snd_FBZ1_FM5,	$00, $13
	smpsHeaderPSG       Snd_FBZ1_PSG1,	$E8, $02, $00, $00
	smpsHeaderPSG       Snd_FBZ1_PSG2,	$E8, $02, $00, $00
	smpsHeaderPSG       Snd_FBZ1_PSG3,	$E8, $02, $00, $00

; FM1 Data
Snd_FBZ1_FM1:
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nRst, $18

Snd_FBZ1_Jump01:
	smpsSetvoice        $05
	dc.b	nRst, $0C, nA6, $7F, smpsNoAttack, nA6, $0B, nG6, $06, nE6, nD6, nE6
	dc.b	nD6, nC6, nA5, nD6, $02, nEb6, $0A, nA5, $0C, nRst, $48, nRst
	dc.b	$30, nD6, $06, nEb6, nD6, nEb6, nG6, nA6, nC7, nA6, nRst, $0C
	dc.b	nA6, $7F, smpsNoAttack, nA6, $0B, nG6, $06, nE6, nD6, nE6, nD6, nC6
	dc.b	nA5, nD6, $02, nEb6, $0A, nA5, $0C, nRst, $48, nE5, $06, nG5
	dc.b	nE5, nG5, nA5, nG5, nA5, nC6, nEb6, nE6, nD6, nC6, nA6, nG6
	dc.b	nE6, nC6
	smpsSetvoice        $00
	dc.b	nE4, $48, nE4, $06, nA4, $04, nRst, $08, nE4, $42, nD4, $05
	dc.b	nRst, $07, nC4, $05, nRst, $07, nB3, $05, nRst, $07, nC4, $12
	dc.b	nA3, $06, nRst, $48, nRst, $60, nE4, $48, nE4, $06, nA4, $04
	dc.b	nRst, $08, nE4, $42, nD4, $05, nRst, $07, nC4, $05, nRst, $07
	dc.b	nB3, $05, nRst, $07, nC4, $12, nE4, $06, nRst, $48, nRst, $3C
	dc.b	nE5, $0C, nD5, nC5, nC5, $12, nA4, nE5, $30, nD5, $06, nC5
	dc.b	nD5, $0B, nRst, $07, nB4, $0B, nRst, $07, nG4, $24, nB4, $0C
	dc.b	nA4, nAb4, $12, nB4, $06, nRst, $0C, nD5, $18, nF5, $06, nRst
	dc.b	nE5, nRst, nD5, nRst, nE5, $10, nRst, $08, nD5, $10, nRst, $08
	dc.b	nC5, $10, nRst, $08, nB4, $10, nRst, $08, nC5, $12, nA4, nE5
	dc.b	$2D, nRst, $03, nD5, $06, nC5, nD5, $0B, nRst, $07, nB4, $0B
	dc.b	nRst, $07, nG4, $24, nB4, $0C, nA4, nAb4, $12, nB4, $06, nRst
	dc.b	$0C, nD5, $18, nF5, $06, nRst, nE5, nRst, nD5, nRst, nE5, nD5
	dc.b	nE5, $7F, smpsNoAttack, nE5, $05, nRst, $30
	smpsJump            Snd_FBZ1_Jump01

; Unreachable
	smpsStop

; FM2 Data
Snd_FBZ1_FM2:
	smpsSetvoice        $01
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nD3, $06, nE3, nA2, $03, nRst, nA2, nRst

Snd_FBZ1_Loop08:
	dc.b	nA2, $0C, nG3, $06, nA3, nA2, $04, nRst, $08, nA2, $03, nRst
	dc.b	nA2, nRst, nAb2, $0C, nG3, $06, nAb3, nAb2, $04, nRst, $08, nAb2
	dc.b	$03, nRst, nAb2, nRst, nG2, $0C, nG2, $06, nG3, nG2, $04, nRst
	dc.b	$08, nG2, $03, nRst, nG2, nRst, nAb2, $0C, nAb3, $04, nRst, $08
	dc.b	nAb2, $04, nRst, $08, nAb2, $03, nRst, nAb2, nRst, nA2, $0C, nG3
	dc.b	$06, nA3, nD3, nE3, nA2, $03, nRst, nA2, nRst, nA2, $0C, nA2
	dc.b	$03, nRst, nA2, $0C, nA2, nA2, $03, nRst, nA2, $06, nD3, nE3
	dc.b	nG3, nA3, nA2, $0C, nA2, $03, nRst, nA2, nRst, nG3, $06, nA3
	dc.b	nA2, nD3, nE3, nA2, $0C
	smpsLoop            $00, $04, Snd_FBZ1_Loop08
	dc.b	nF2, $06, nF3, $0C, nF2, $03, nRst, nF2, $06, nF3, $0C, nF2
	dc.b	$03, nRst, nF2, $0C, nF3, $06, nRst, nF2, $0C, nF3, $06, nRst
	dc.b	nG2, nG3, $0C, nG2, $03, nRst, nG2, $06, nG3, $0C, nG2, $03
	dc.b	nRst, nG2, $0C, nG3, $06, nRst, nG2, $0C, nG3, $06, nRst, nAb2
	dc.b	nAb3, $0C, nAb2, $03, nRst, nAb2, $06, nAb3, $0C, nAb2, $03, nRst
	dc.b	nAb2, $0C, nAb3, $06, nRst, nAb2, $0C, nAb3, $06, nRst, nA2, nA3
	dc.b	$0C, nA2, $03, nRst, nA2, $06, nA3, $0C, nA2, $03, nRst, nG2
	dc.b	$0C, nG3, $06, nRst, nG2, $0C, nG3, $06, nRst, nF2, nF3, $0C
	dc.b	nF2, $03, nRst, nF2, $06, nF3, $0C, nF2, $03, nRst, nF2, $0C
	dc.b	nF3, $06, nRst, nF2, $0C, nF3, $06, nRst, nG2, nG3, $0C, nG2
	dc.b	$03, nRst, nG2, $06, nG3, $0C, nG2, $03, nRst, nG2, $0C, nG3
	dc.b	$06, nRst, nG2, $0C, nG3, $06, nRst, nAb2, nAb3, $0C, nAb2, $03
	dc.b	nRst, nAb2, $06, nAb3, $0C, nAb2, $03, nRst, nAb2, $0C, nAb3, $06
	dc.b	nRst, nAb2, $0C, nAb3, $06, nRst, nA2, nA3, $0C, nA2, $03, nRst
	dc.b	nA2, $06, nA3, $0C, nA2, $03, nRst, nA2, $0C, nA3, $06, nRst
	dc.b	nA2, $0C, nA3, $06, nRst, nA2, nRst, nA2, nRst, nA2, nRst, nA2
	dc.b	$03, nRst, nA2, nRst, nA2, nRst, nA3, nRst, nG3, $06, nA3, nD3
	dc.b	nE3, nA2, $03, nRst, nA2, nRst
	smpsJump            Snd_FBZ1_Loop08
	
; Unreachable
	smpsStop

; FM3 Data
Snd_FBZ1_FM3:
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panLeft, $00
	dc.b	nRst, $18

Snd_FBZ1_Loop06:
	smpsSetvoice        $02
	dc.b	nA4, $10, nRst, $08, nG4, $10, nRst, $08, nE4, $0F, nRst, $03
	dc.b	nD4, $0F, nRst, $03, nC4, $06, nRst, nRst, nC4, $12, nD4, $06
	dc.b	nRst, nE4, nRst, nD4, $12, nC4, $06, nRst, $18
	smpsSetvoice        $03
	dc.b	nE4, $06, nRst, nE5, $24, nF4, $06, nRst, nF5, $24, nFs4, $06
	dc.b	nRst, nFs5, $24, nF4, $06, nRst, nF5, $24
	smpsLoop            $00, $04, Snd_FBZ1_Loop06

Snd_FBZ1_Loop07:
	smpsSetvoice        $04
	dc.b	nRst, $0C, nC5, $24, nRst, $0C, nC5, $06, nRst, nB4, nC5, nRst
	dc.b	$0C, nRst, nD5, $23, nRst, $0D, nD5, $06, nRst, nC5, nD5, nRst
	dc.b	$0C, nRst, nD5, $23, nRst, $0D, nD5, $06, nRst, nC5, nD5, nRst
	dc.b	$0C, nRst, nE5, nE5, $06, nE5, nRst, nE5, nRst, nE5, nRst, nE5
	dc.b	nE5, nRst, nE5, nRst
	smpsLoop            $00, $02, Snd_FBZ1_Loop07
	dc.b	nRst, $0C, nE5, $06, nRst, nE5, nRst, nE5, nRst, nE5, nRst, $2A
	smpsJump            Snd_FBZ1_Loop06
	
; Unreachable
	smpsStop

; FM4 Data
Snd_FBZ1_FM4:
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panRight, $00
	dc.b	nRst, $18

Snd_FBZ1_Loop04:
	smpsSetvoice        $02
	dc.b	nE4, $10, nRst, $08, nE4, $10, nRst, $08, nC4, $0F, nRst, $03
	dc.b	nA3, $0F, nRst, $03, nE3, $06, nRst, nRst, nA3, $12, nB3, $06
	dc.b	nRst, nC4, nRst, nB3, $12, nA3, $06, nRst, $18
	smpsSetvoice        $03
	dc.b	nC4, $06, nRst, nC5, $24, nC4, $06, nRst, nC5, $24, nC4, $06
	dc.b	nRst, nC5, $24, nC4, $06, nRst, nC5, $24
	smpsLoop            $00, $04, Snd_FBZ1_Loop04

Snd_FBZ1_Loop05:
	smpsSetvoice        $04
	dc.b	nRst, $0C, nA4, $24, nRst, $0C, nA4, $06, nRst, nG4, nA4, nRst
	dc.b	$0C, nRst, nB4, $23, nRst, $0D, nB4, $06, nRst, nA4, nB4, nRst
	dc.b	$0C, nRst, nB4, $23, nRst, $0D, nB4, $06, nRst, nA4, nB4, nRst
	dc.b	$0C, nRst, nC5, nC5, $06, nC5, nRst, nC5, nRst, nC5, nRst, nC5
	dc.b	nC5, nRst, nC5, nRst
	smpsLoop            $00, $02, Snd_FBZ1_Loop05
	dc.b	nRst, $0C, nC5, $06, nRst, nC5, nRst, nC5, nRst, nC5, nRst, $2A
	smpsJump            Snd_FBZ1_Loop04
	
; Unreachable
	smpsStop

; FM5 Data
Snd_FBZ1_FM5:
	dc.b	nRst, $10
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nRst, $18

Snd_FBZ1_Jump00:
	smpsSetvoice        $05
	dc.b	nRst, $0C, nA6, $7F, smpsNoAttack, nA6, $0B, nG6, $06, nE6, nD6, nE6
	dc.b	nD6, nC6, nA5, nD6, $02, nEb6, $0A, nA5, $0C, nRst, $48, nRst
	dc.b	$30, nD6, $06, nEb6, nD6, nEb6, nG6, nA6, nC7, nA6, nRst, $0C
	dc.b	nA6, nA0, $7F, smpsNoAttack, nA6, $0B, nG6, $06, nE6, nD6, nE6, nD6
	dc.b	nC6, nA5, nD6, $02, nEb6, $0A, nA5, $0C, nRst, $48, nE5, $06
	dc.b	nG5, nE5, nG5, nA5, nG5, nA5, nC6, nEb6, nE6, nD6, nC6, nA6
	dc.b	nG6, nE6, nC6
	smpsSetvoice        $00
	dc.b	nE4, $48, nE4, $06, nA4, $04, nRst, $08, nE4, $42, nD4, $05
	dc.b	nRst, $07, nC4, $05, nRst, $07, nB3, $05, nRst, $07, nC4, $12
	dc.b	nA3, $06, nRst, $48, nRst, $60, nE4, $48, nE4, $06, nA4, $04
	dc.b	nRst, $08, nE4, $42, nD4, $05, nRst, $07, nC4, $05, nRst, $07
	dc.b	nB3, $05, nRst, $07, nC4, $12, nE4, $06, nRst, $48, nRst, $3C
	dc.b	nE5, $0C, nD5, nC5, nC5, $12, nA4, nE5, $30, nD5, $06, nC5
	dc.b	nD5, $0B, nRst, $07, nB4, $0B, nRst, $07, nG4, $24, nB4, $0C
	dc.b	nA4, nAb4, $12, nB4, $06, nRst, $0C, nD5, $18, nF5, $06, nRst
	dc.b	nE5, nRst, nD5, nRst, nE5, $10, nRst, $08, nD5, $10, nRst, $08
	dc.b	nC5, $10, nRst, $08, nB4, $10, nRst, $08, nC5, $12, nA4, nE5
	dc.b	$2D, nRst, $03, nD5, $06, nC5, nD5, $0B, nRst, $07, nB4, $0B
	dc.b	nRst, $07, nG4, $24, nB4, $0C, nA4, nAb4, $12, nB4, $06, nRst
	dc.b	$0C, nD5, $18, nF5, $06, nRst, nE5, nRst, nD5, nRst, nE5, nD5
	dc.b	nE5, $7F, smpsNoAttack, nE5, $05, nRst, $30
	smpsJump            Snd_FBZ1_Jump00
	
; Unreachable
	smpsStop

; DAC Data
Snd_FBZ1_DAC:
	dc.b	dKickS3, $06, dKickS3, dKickS3, dKickS3

Snd_FBZ1_Loop00:
	dc.b	dKickS3, $18, dSnareS3
	smpsLoop            $00, $07, Snd_FBZ1_Loop00
	dc.b	dKickS3, $18, dSnareS3, $0C, dSnareS3

Snd_FBZ1_Loop01:
	dc.b	dKickS3, $18, dSnareS3
	smpsLoop            $00, $07, Snd_FBZ1_Loop01
	dc.b	dKickS3, $18, dSnareS3, $0C, dSnareS3

Snd_FBZ1_Loop02:
	dc.b	dKickS3, $18, dSnareS3
	smpsLoop            $00, $0F, Snd_FBZ1_Loop02
	dc.b	dKickS3, $0C, dSnareS3, dSnareS3, dSnareS3

Snd_FBZ1_Loop03:
	dc.b	dKickS3, $0C, dClapS3, dSnareS3, dClapS3, $06, dClapS3, dKickS3, $0C, dClapS3, dSnareS3, dClapS3
	dc.b	$06, dClapS3, dKickS3, $0C, dClapS3, dSnareS3, dClapS3, $06, dClapS3, dKickS3, dClapS3, dClapS3
	dc.b	dClapS3, dSnareS3, $0C, dClapS3
	smpsLoop            $00, $04, Snd_FBZ1_Loop03
	dc.b	dKickS3, $0C, dSnareS3, dSnareS3, dSnareS3, $06, dSnareS3, dSnareS3, $30
	smpsJump            Snd_FBZ1_Loop00
	
; Unreachable
	smpsStop

; PSG1 Data
Snd_FBZ1_PSG1:
	smpsStop

; PSG2 Data
Snd_FBZ1_PSG2:
	smpsStop

; Unreachable
	smpsStop

; PSG3 Data
Snd_FBZ1_PSG3:
	smpsStop

Snd_FBZ1_Voices:
;	Voice $00
;	$38
;	$47, $31, $73, $41, 	$17, $11, $14, $18, 	$02, $0C, $05, $01
;	$00, $0F, $00, $00, 	$1F, $3F, $5F, $1F, 	$28, $13, $23, $81
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $07, $03, $04
	smpsVcCoarseFreq    $01, $03, $01, $07
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $18, $14, $11, $17
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $05, $0C, $02
	smpsVcDecayRate2    $00, $00, $0F, $00
	smpsVcDecayLevel    $01, $05, $03, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $23, $13, $28

;	Voice $01
;	$3B
;	$47, $40, $41, $40, 	$9F, $1F, $1F, $1F, 	$0F, $0E, $09, $09
;	$00, $00, $00, $00, 	$EF, $EF, $EF, $EF, 	$24, $12, $15, $81
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $04, $04, $04
	smpsVcCoarseFreq    $00, $01, $00, $07
	smpsVcRateScale     $00, $00, $00, $02
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $09, $09, $0E, $0F
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0E, $0E, $0E, $0E
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $15, $12, $24

;	Voice $02
;	$3B
;	$7C, $19, $11, $71, 	$13, $1C, $1C, $1B, 	$0C, $09, $0A, $02
;	$00, $06, $04, $07, 	$1F, $EF, $FF, $EF, 	$23, $29, $10, $81
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $01, $01, $07
	smpsVcCoarseFreq    $01, $01, $09, $0C
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1B, $1C, $1C, $13
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $0A, $09, $0C
	smpsVcDecayRate2    $07, $04, $06, $00
	smpsVcDecayLevel    $0E, $0F, $0E, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $10, $29, $23

;	Voice $03
;	$34
;	$61, $01, $01, $61, 	$10, $11, $50, $D1, 	$06, $01, $01, $01
;	$08, $00, $09, $00, 	$8F, $FF, $FF, $FF, 	$19, $85, $17, $86
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $06, $00, $00, $06
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $03, $01, $00, $00
	smpsVcAttackRate    $11, $10, $11, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $01, $01, $06
	smpsVcDecayRate2    $00, $09, $00, $08
	smpsVcDecayLevel    $0F, $0F, $0F, $08
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $06, $17, $05, $19

;	Voice $04
;	$1B
;	$65, $50, $20, $41, 	$1C, $18, $1A, $18, 	$0F, $0C, $0B, $07
;	$05, $01, $05, $01, 	$CF, $0F, $DF, $CF, 	$21, $19, $26, $81
	smpsVcAlgorithm     $03
	smpsVcFeedback      $03
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $02, $05, $06
	smpsVcCoarseFreq    $01, $00, $00, $05
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $18, $1A, $18, $1C
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $07, $0B, $0C, $0F
	smpsVcDecayRate2    $01, $05, $01, $05
	smpsVcDecayLevel    $0C, $0D, $00, $0C
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $26, $19, $21

;	Voice $05
;	$38
;	$73, $55, $12, $31, 	$16, $15, $14, $12, 	$0E, $01, $05, $04
;	$0C, $13, $0C, $0B, 	$FF, $EF, $DF, $8F, 	$36, $38, $21, $85
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $01, $05, $07
	smpsVcCoarseFreq    $01, $02, $05, $03
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $12, $14, $15, $16
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $04, $05, $01, $0E
	smpsVcDecayRate2    $0B, $0C, $13, $0C
	smpsVcDecayLevel    $08, $0D, $0E, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $05, $21, $38, $36

