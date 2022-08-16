Snd_SOZ2_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_SOZ2_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $20

	smpsHeaderDAC       Snd_SOZ2_DAC
	smpsHeaderFM        Snd_SOZ2_FM1,	$00, $0B
	smpsHeaderFM        Snd_SOZ2_FM2,	$00, $0B
	smpsHeaderFM        Snd_SOZ2_FM3,	$00, $0C
	smpsHeaderFM        Snd_SOZ2_FM4,	$00, $0C
	smpsHeaderFM        Snd_SOZ2_FM5,	$00, $13
	smpsHeaderPSG       Snd_SOZ2_PSG1,	$E8, $06, $00, $00
	smpsHeaderPSG       Snd_SOZ2_PSG2,	$E8, $02, $00, $00
	smpsHeaderPSG       Snd_SOZ2_PSG3,	$E8, $02, $00, $00

; FM1 Data
Snd_SOZ2_FM1:
	smpsSetvoice        $00
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nRst, $24, nE4, $06, nF4, nAb4, $0C, nA4, $0A, nRst, $0E, nB4
	dc.b	$08, nRst, $04, nRst, $0C, nA4, nAb4, nF4, nE4, nF4, nAb4, nA4
	dc.b	nB4, $06, nRst, nA4, nRst, $12, nB4, $18, nA4, $0C, nB4, nC5
	dc.b	nD5, nB4, nC5, nD5, nE5, nD5, nC5, nB4

Snd_SOZ2_Jump02:
	smpsSetvoice        $03
	dc.b	nA5, $30, nE5, nF5, $48, nAb5, $0C, nB5, nA5, $30, nC6, nB5
	dc.b	nAb5, nA5, nE5, nF5, $48, nAb5, $0C, nB5, nA5, $30, nC6, nB5
	dc.b	nE6
	smpsSetvoice        $00
	dc.b	nRst, $0C, nD4, nD4, nC4, nC4, nB3, nB3, nA3, nAb3, $18, nA3
	dc.b	$08, nRst, $04, nB3, $08, nRst, $34, nRst, $0C, nAb4, $08, nRst
	dc.b	$04, nA4, $08, nRst, $04, nB4, $08, nRst, $04, nC5, $08, nRst
	dc.b	$04, nB4, $08, nRst, $04, nA4, $08, nRst, $04, nB4, $08, nRst
	dc.b	$04, nD5, $08, nRst, $04, nC5, $08, nRst, $04, nB4, $08, nRst
	dc.b	$04, nA4, $08, nRst, $04, nAb4, $08, nRst, $04, nF4, $08, nRst
	dc.b	$04, nE4, $08, nRst, $04, nD4, $08, nRst, $04, nE5, $08, nRst
	dc.b	$10, nD5, $08, nRst, $40, nC5, $08, nRst, $10, nB4, $08, nRst
	dc.b	$40, nE5, $08, nRst, $10, nD5, $08, nRst, $40, nAb5, $08, nRst
	dc.b	$10, nF5, $08, nRst, $10, nB5, $08, nRst, $04, nD6, $08, nRst
	dc.b	$04
	smpsSetvoice        $04
	dc.b	nA4, $0C, nB4, nC5, $0B, nRst, $0D, nC5, $18, nB4, $0B, nRst
	dc.b	$0D, nB4, $18, nAb4, nA4, $0C, nB4, nRst, $30, nRst, $0C, nC5
	dc.b	$0B, nRst, $19, nB4, $0B, nRst, $0D, nA4, $0B, nRst, $0D, nAb4
	dc.b	$18, nA4, $0C, nE4, $0A, nRst, $1A, nA4, $0C, nB4, nC5, $0B
	dc.b	nRst, $0D, nC5, $18, nB4, $0B, nRst, $0D, nB4, $18, nAb4, nA4
	dc.b	$0C, nB4, nRst, $30, nRst, $0C, nC5, $0B, nRst, $19, nB4, $0B
	dc.b	nRst, $0D, nC5, $0B, nRst, $0D, nD5, $0C, nC5, $06, nRst, nD5
	dc.b	$07, nRst, $05, nE5, $0C, nD5, $06, nRst, nE5, $07, nRst, $05
	dc.b	nF5, $0C, nE5, $07, nRst, $05
	smpsJump            Snd_SOZ2_Jump02

; Unreachable
	smpsStop

; FM2 Data
Snd_SOZ2_FM2:
	smpsSetvoice        $01
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00

Snd_SOZ2_Loop03:
	dc.b	nA1, $0C, nC2, nA1, nC2, nA1, nC2, nA1, nC2
	smpsLoop            $00, $03, Snd_SOZ2_Loop03
	dc.b	nA1, $0C, nC2, nA1, nC2, nD2, nB1, nAb1, nB1

Snd_SOZ2_Loop04:
	dc.b	nA1, $0C, nC2, nA1, nC2, nA1, nC2, nA1, nC2, nAb1, nB1, nAb1
	dc.b	nB1, nAb1, nB1, nAb1, nB1
	smpsLoop            $00, $04, Snd_SOZ2_Loop04

Snd_SOZ2_Loop05:
	dc.b	nE1, $30, nE1, $0C, nE1, $0A, nRst, $1A, nRst, $0C, nE1, nRst
	dc.b	nE1, nRst, $30
	smpsLoop            $00, $03, Snd_SOZ2_Loop05
	dc.b	nE1, $30, nE1, $0C, nE1, $0A, nRst, $1A, nRst, $0C, nE1, nRst
	dc.b	nE1, nRst, nB1, $24

Snd_SOZ2_Loop06:
	dc.b	nA1, $0C, nA1, nC2, $0A, nRst, $0E, nA1, $0C, nA1, nD2, $0A
	dc.b	nRst, $0E, nAb1, $0C, nAb1, nE2, $0A, nRst, $0E, nE2, $0C, nD2
	dc.b	nC2, nB1
	smpsLoop            $00, $04, Snd_SOZ2_Loop06
	smpsJump            Snd_SOZ2_Loop04

; Unreachable
	smpsStop

; FM3 Data
Snd_SOZ2_FM3:
	smpsSetvoice        $02
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panLeft, $00
	dc.b	nRst, $60, nRst, nB4, $06, nRst, nA4, nRst, $42, nC5, $06, nRst
	dc.b	nD5, nRst, nB4, nRst, $1E, nE5, $06, nRst, nD5, nRst, $1E

Snd_SOZ2_Jump01:
	smpsSetvoice        $06
	dc.b	nA4, $60, nAb4, $30, nD5, nC5, $60, nB4, $30, nAb4, nA4, $60
	dc.b	nAb4, $30, nD5, nC5, $60, nB4, $30, nAb4
	smpsSetvoice        $05
	dc.b	nRst, $0C, nD6, $08, nRst, $04, nAb6, $0A, nRst, $0E, nAb6, $0C
	dc.b	nF6, $0A, nRst, $0E, nD6, $08, nRst, $04, nRst, $0C, nB5, $08
	dc.b	nRst, $10, nAb5, $08, nRst, $28, nB5, $06, nC6, nB5, $08, nRst
	dc.b	$1C, nAb5, $08, nRst, $1C, nF5, $08, nRst, $10, nRst, $0C, nE5
	dc.b	$08, nRst, $1C, nE5, $08, nRst, $28, nRst, $0C, nE5, nF5, nAb5
	dc.b	$08, nRst, $04, nAb5, nA5, nAb5, $10, nF5, $0C, nE5, $08, nRst
	dc.b	$04, nRst, $0C, nE5, nD5, nC5, nB4, $04, nC5, nB4, $10, nAb4
	dc.b	$0C, nE4, nRst, nE5, nF5, nAb5, $08, nRst, $04, nAb5, nA5, nAb5
	dc.b	$10, nF5, $0C, nE5, $08, nRst, $04, nA5, nB5, nA5, $10, nAb5
	dc.b	$0C, nA5, nB5, nD6, nRst, $18
	smpsSetvoice        $07
	dc.b	nRst, $60, nRst, $3C, nD5, $08, nRst, $04, nC5, $08, nRst, $04
	dc.b	nB4, $08, nRst, $04, nRst, $60, nRst, $24, nB4, $04, nC5, nB4
	dc.b	$34, nRst, $60, nRst, $3C, nD5, $08, nRst, $04, nC5, $08, nRst
	dc.b	$04, nB4, $08, nRst, $04, nRst, $60, nB4, $08, nRst, $10, nA4
	dc.b	$08, nRst, $10, nAb4, $08, nRst, $10, nE4, $08, nRst, $10
	smpsJump            Snd_SOZ2_Jump01

; Unreachable
	smpsStop

; FM4 Data
Snd_SOZ2_FM4:
	smpsSetvoice        $02
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panRight, $00
	dc.b	nRst, $60, nRst, nE4, $06, nRst, nE4, nRst, $42, nE4, $06, nRst
	dc.b	nE4, nRst, nE4, nRst, $1E, nAb4, $06, nRst, nAb4, nRst, $1E

Snd_SOZ2_Loop02:
	dc.b	nRst, $60, nRst
	smpsSetvoice        $07
	dc.b	nRst, $18, nE5, nC5, nD5, nB4, nC5, nAb4, nB4
	smpsLoop            $00, $02, Snd_SOZ2_Loop02
	dc.b	nRst, $60, nRst, nRst, nRst
	smpsSetvoice        $00
	dc.b	nC5, $08, nRst, $10, nB4, $08, nRst, $40, nA4, $08, nRst, $10
	dc.b	nAb4, $08, nRst, $40, nC5, $08, nRst, $10, nB4, $08, nRst, $40
	dc.b	nF5, $08, nRst, $10, nD5, $08, nRst, $10, nAb5, $08, nRst, $04
	dc.b	nB5, $08, nRst, $10, nB5, $08, nRst, $04
	smpsSetvoice        $06
	dc.b	nA4, $60, nB4, nC5, nB4, nA4, nB4, nC5, nE5, $30, nAb5
	smpsJump            Snd_SOZ2_Loop02

; Unreachable
	smpsStop

; FM5 Data
Snd_SOZ2_FM5:
	dc.b	nRst, $10
	smpsSetvoice        $00
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nRst, $24, nE4, $06, nF4, nAb4, $0C, nA4, $0A, nRst, $0E, nB4
	dc.b	$08, nRst, $04, nRst, $0C, nA4, nAb4, nF4, nE4, nF4, nAb4, nA4
	dc.b	nB4, $06, nRst, nA4, nRst, $12, nB4, $18, nA4, $0C, nB4, nC5
	dc.b	nD5, nB4, nC5, nD5, nE5, nD5, nC5, nB4

Snd_SOZ2_Jump00:
	smpsSetvoice        $03
	dc.b	nA5, $30, nE5, nF5, $48, nAb5, $0C, nB5, nA5, $30, nC6, nB5
	dc.b	nAb5, nA5, nE5, nF5, $48, nAb5, $0C, nB5, nA5, $30, nC6, nB5
	dc.b	nE6
	smpsSetvoice        $00
	dc.b	nRst, $0C, nD4, nD4, nC4, nC4, nB3, nB3, nA3, nAb3, $18, nA3
	dc.b	$08, nRst, $04, nB3, $08, nRst, $34, nRst, $0C, nAb4, $08, nRst
	dc.b	$04, nA4, $08, nRst, $04, nB4, $08, nRst, $04, nC5, $08, nRst
	dc.b	$04, nB4, $08, nRst, $04, nA4, $08, nRst, $04, nB4, $08, nRst
	dc.b	$04, nD5, $08, nRst, $04, nC5, $08, nRst, $04, nB4, $08, nRst
	dc.b	$04, nA4, $08, nRst, $04, nAb4, $08, nRst, $04, nF4, $08, nRst
	dc.b	$04, nE4, $08, nRst, $04, nD4, $08, nRst, $04, nE5, $08, nRst
	dc.b	$10, nD5, $08, nRst, $40, nC5, $08, nRst, $10, nB4, $08, nRst
	dc.b	$40, nE5, $08, nRst, $10, nD5, $08, nRst, $40, nAb5, $08, nRst
	dc.b	$10, nF5, $08, nRst, $10, nB5, $08, nRst, $04, nD6, $08, nRst
	dc.b	$04
	smpsSetvoice        $04
	dc.b	nA4, $0C, nB4, nC5, $0B, nRst, $0D, nC5, $18, nB4, $0B, nRst
	dc.b	$0D, nB4, $18, nAb4, nA4, $0C, nB4, nRst, $30, nRst, $0C, nC5
	dc.b	$0B, nRst, $19, nB4, $0B, nRst, $0D, nA4, $0B, nRst, $0D, nAb4
	dc.b	$18, nA4, $0C, nE4, $0A, nRst, $1A, nA4, $0C, nB4, nC5, $0B
	dc.b	nRst, $0D, nC5, $18, nB4, $0B, nRst, $0D, nB4, $18, nAb4, nA4
	dc.b	$0C, nB4, nRst, $30, nRst, $0C, nC5, $0B, nRst, $19, nB4, $0B
	dc.b	nRst, $0D, nC5, $0B, nRst, $0D, nD5, $0C, nC5, $06, nRst, nD5
	dc.b	$07, nRst, $05, nE5, $0C, nD5, $06, nRst, nE5, $07, nRst, $05
	dc.b	nF5, $0C, nE5, $07, nRst, $05
	smpsJump            Snd_SOZ2_Jump00

; Unreachable
	smpsStop

; DAC Data
Snd_SOZ2_DAC:
	dc.b	dKickS3, $18, dKickS3, dKickS3, dKickS3, $0C, dSnareS3
	smpsLoop            $00, $03, Snd_SOZ2_DAC
	dc.b	dKickS3, $18, dSnareS3, dKickS3, $0C, dSnareS3, dSnareS3, dSnareS3

Snd_SOZ2_Loop00:
	dc.b	dKickS3, $18, dKickS3, dKickS3, dSnareS3
	smpsLoop            $00, $07, Snd_SOZ2_Loop00
	dc.b	dKickS3, $0C, dKickS3, dSnareS3, dKickS3, dKickS3, dSnareS3, dSnareS3, dSnareS3, dKickS3, $18, dSnareS3
	dc.b	dKickS3, $0C, dKickS3, dSnareS3, $18, nRst, $0C, dKickS3, dSnareS3, dKickS3, $0B, nRst
	dc.b	$19, dSnareS3, $18, dKickS3, dSnareS3, dKickS3, $0C, dKickS3, dSnareS3, $18, dKickS3, dSnareS3
	dc.b	$0C, dKickS3, dKickS3, dKickS3, dSnareS3, dSnareS3, $06, dSnareS3

Snd_SOZ2_Loop01:
	dc.b	dKickS3, $18, dSnareS3, dKickS3, $0C, dKickS3, dSnareS3, $18
	smpsLoop            $00, $03, Snd_SOZ2_Loop01
	dc.b	dKickS3, $18, dSnareS3, $0C, dKickS3, dKickS3, dSnareS3, $06, dSnareS3, dSnareS3, dSnareS3, dSnareS3
	dc.b	dSnareS3, dKickS3, $18, dSnareS3, dKickS3, $0C, dKickS3, dSnareS3, $18, dKickS3, dSnareS3, dKickS3
	dc.b	$0C, dKickS3, dSnareS3, dKickS3, dKickS3, $18, dSnareS3, dKickS3, $0C, dKickS3, dSnareS3, $18
	dc.b	dKickS3, dSnareS3, dKickS3, $0C, dKickS3, dSnareS3, dSnareS3, dKickS3, $18, dSnareS3, dKickS3, $0C
	dc.b	dKickS3, dSnareS3, $18, dKickS3, dSnareS3, dKickS3, $0C, dKickS3, dSnareS3, dKickS3, dKickS3, $18
	dc.b	dSnareS3, dKickS3, $0C, dKickS3, dSnareS3, $18, dKickS3, dSnareS3, dKickS3, $0C, dSnareS3, $06
	dc.b	dSnareS3, dSnareS3, dSnareS3, dSnareS3, dSnareS3
	smpsJump            Snd_SOZ2_Loop00

; Unreachable
	smpsStop

; PSG1 Data
Snd_SOZ2_PSG1:
	smpsStop

; PSG2 Data
Snd_SOZ2_PSG2:
	smpsStop

; Unreachable
	smpsStop

; PSG3 Data
Snd_SOZ2_PSG3:
	smpsStop

Snd_SOZ2_Voices:
;	Voice $00
;	$10
;	$57, $4B, $77, $41, 	$19, $12, $5F, $1F, 	$02, $06, $05, $01
;	$00, $0F, $00, $00, 	$18, $38, $58, $18, 	$25, $23, $23, $84
	smpsVcAlgorithm     $00
	smpsVcFeedback      $02
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $07, $04, $05
	smpsVcCoarseFreq    $01, $07, $0B, $07
	smpsVcRateScale     $00, $01, $00, $00
	smpsVcAttackRate    $1F, $1F, $12, $19
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $05, $06, $02
	smpsVcDecayRate2    $00, $00, $0F, $00
	smpsVcDecayLevel    $01, $05, $03, $01
	smpsVcReleaseRate   $08, $08, $08, $08
	smpsVcTotalLevel    $04, $23, $23, $25

;	Voice $01
;	$38
;	$75, $12, $71, $11, 	$DF, $5F, $1F, $1F, 	$09, $0A, $01, $01
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$19, $1A, $1E, $81
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $07, $01, $07
	smpsVcCoarseFreq    $01, $01, $02, $05
	smpsVcRateScale     $00, $00, $01, $03
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $01, $0A, $09
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $1E, $1A, $19

;	Voice $02
;	$02
;	$73, $52, $41, $11, 	$17, $16, $15, $17, 	$0A, $03, $05, $03
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$0A, $1D, $23, $85
	smpsVcAlgorithm     $02
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $04, $05, $07
	smpsVcCoarseFreq    $01, $01, $02, $03
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $17, $15, $16, $17
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $05, $03, $0A
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $05, $23, $1D, $0A

;	Voice $03
;	$3D
;	$40, $02, $23, $71, 	$0D, $12, $52, $D2, 	$01, $01, $01, $01
;	$08, $00, $09, $00, 	$89, $F8, $F9, $F8, 	$19, $8B, $8D, $89
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $02, $00, $04
	smpsVcCoarseFreq    $01, $03, $02, $00
	smpsVcRateScale     $03, $01, $00, $00
	smpsVcAttackRate    $12, $12, $12, $0D
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $01, $01, $01
	smpsVcDecayRate2    $00, $09, $00, $08
	smpsVcDecayLevel    $0F, $0F, $0F, $08
	smpsVcReleaseRate   $08, $09, $08, $09
	smpsVcTotalLevel    $09, $0D, $0B, $19

;	Voice $04
;	$03
;	$61, $3E, $23, $41, 	$10, $10, $0F, $15, 	$1C, $01, $06, $05
;	$05, $01, $05, $01, 	$C9, $0C, $D9, $C9, 	$18, $19, $17, $83
	smpsVcAlgorithm     $03
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $02, $03, $06
	smpsVcCoarseFreq    $01, $03, $0E, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $15, $0F, $10, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $06, $01, $1C
	smpsVcDecayRate2    $01, $05, $01, $05
	smpsVcDecayLevel    $0C, $0D, $00, $0C
	smpsVcReleaseRate   $09, $09, $0C, $09
	smpsVcTotalLevel    $03, $17, $19, $18

;	Voice $05
;	$02
;	$74, $50, $13, $31, 	$95, $D5, $15, $16, 	$06, $01, $01, $03
;	$0C, $13, $0C, $0B, 	$FF, $EF, $DF, $8F, 	$32, $18, $23, $81
	smpsVcAlgorithm     $02
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $01, $05, $07
	smpsVcCoarseFreq    $01, $03, $00, $04
	smpsVcRateScale     $00, $00, $03, $02
	smpsVcAttackRate    $16, $15, $15, $15
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $01, $01, $06
	smpsVcDecayRate2    $0B, $0C, $13, $0C
	smpsVcDecayLevel    $08, $0D, $0E, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $23, $18, $32

;	Voice $06
;	$38
;	$70, $20, $40, $40, 	$0B, $11, $0F, $10, 	$02, $03, $02, $02
;	$00, $06, $04, $07, 	$1F, $EC, $FF, $E8, 	$2C, $11, $15, $85
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $04, $02, $07
	smpsVcCoarseFreq    $00, $00, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $10, $0F, $11, $0B
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $02, $03, $02
	smpsVcDecayRate2    $07, $04, $06, $00
	smpsVcDecayLevel    $0E, $0F, $0E, $01
	smpsVcReleaseRate   $08, $0F, $0C, $0F
	smpsVcTotalLevel    $05, $15, $11, $2C

;	Voice $07
;	$24
;	$44, $72, $17, $63, 	$1D, $1D, $1D, $1E, 	$0A, $08, $11, $0B
;	$00, $00, $00, $00, 	$57, $58, $57, $58, 	$19, $89, $32, $83
	smpsVcAlgorithm     $04
	smpsVcFeedback      $04
	smpsVcUnusedBits    $00
	smpsVcDetune        $06, $01, $07, $04
	smpsVcCoarseFreq    $03, $07, $02, $04
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1E, $1D, $1D, $1D
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0B, $11, $08, $0A
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $05, $05, $05, $05
	smpsVcReleaseRate   $08, $07, $08, $07
	smpsVcTotalLevel    $03, $32, $09, $19

