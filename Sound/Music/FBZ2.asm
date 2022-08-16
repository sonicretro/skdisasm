Snd_FBZ2_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_FBZ2_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $00

	smpsHeaderDAC       Snd_FBZ2_DAC
	smpsHeaderFM        Snd_FBZ2_FM1,	$00, $07
	smpsHeaderFM        Snd_FBZ2_FM2,	$00, $09
	smpsHeaderFM        Snd_FBZ2_FM3,	$00, $0B
	smpsHeaderFM        Snd_FBZ2_FM4,	$00, $0B
	smpsHeaderFM        Snd_FBZ2_FM5,	$00, $10
	smpsHeaderPSG       Snd_FBZ2_PSG1,	$E8, $02, $00, $00
	smpsHeaderPSG       Snd_FBZ2_PSG2,	$E8, $02, $00, $00
	smpsHeaderPSG       Snd_FBZ2_PSG3,	$E8, $02, $00, $00

; FM1 Data
Snd_FBZ2_FM1:
	smpsModSet          $0D, $01, $02, $06
	smpsAlterNote       $02
	smpsPan             panCenter, $00
	dc.b	nRst, $60

Snd_FBZ2_Loop07:
	smpsSetvoice        $00
	dc.b	nRst, $0C, nB4, $04, nRst, $08, nC5, $04, nRst, $08, nB4, $24
	dc.b	nE5, $04, nRst, $14, nEb5, $02, nE5, $16, nC5, $04, nRst, $08
	dc.b	nA4, $18, nE4, $60, nRst, $24
	smpsSetvoice        $02
	dc.b	nRst, $36, nD5, $06, nE5, nG5, nB4, nC5, nA4, $0C
	smpsLoop            $00, $02, Snd_FBZ2_Loop07
	smpsSetvoice        $05
	dc.b	nE4, $48, nE4, $06, nA4, nRst, nE4, $42, nD4, $06, nRst, nC4
	dc.b	nRst, nB3, nRst, nC4, $12, nA3, $06, nRst, $48, nRst, $60, nE4
	dc.b	$48, nE4, $06, nA4, $04, nRst, $08, nE4, $42, nD4, $06, nRst
	dc.b	nC4, nRst, nB3, nRst, nC4, $12, nE4, $06, nRst, $48, nRst, $3C
	dc.b	nE5, $0C, nD5, nC5, nC5, $12, nA4, nE5, $30, nD5, $06, nC5
	dc.b	nD5, $0B, nRst, $07, nB4, $0B, nRst, $07, nG4, $24, nB4, $0C
	dc.b	nA4, nAb4, $12, nB4, $06, nRst, $0C, nD5, $18, nF5, $06, nRst
	dc.b	nE5, nRst, nD5, nRst, nE5, $10, nRst, $08, nD5, $10, nRst, $08
	dc.b	nC5, $10, nRst, $08, nB4, $10, nRst, $08, nC5, $12, nA4, nE5
	dc.b	$2D, nRst, $03, nD5, $06, nC5, nD5, $0B, nRst, $07, nB4, $0B
	dc.b	nRst, $07, nG4, $24, nB4, $0C, nA4, nAb4, $12, nB4, $06, nRst
	dc.b	$0C, nD5, $18, nF5, $06, nRst, nE5, nRst, nD5, nRst, nE5, nD5
	dc.b	nE5, $7F, smpsNoAttack, nE5, $05, nRst, $30
	smpsJump            Snd_FBZ2_Loop07

; Unreachable
	smpsStop

; FM2 Data
Snd_FBZ2_FM2:
	smpsSetvoice        $01
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nD5, $06, nE5, nA4, $02, nRst, $04, nA4, $02, nRst, $04, nD4
	dc.b	$06, nE4, nA3, $02, nRst, $04, nA3, $02, nRst, $04, nD3, $06
	dc.b	nE3, nA2, $02, nRst, $04, nA2, $02, nRst, $04, nD2, $06, nE2
	dc.b	nA1, $02, nRst, $04, nA1, $02, nRst, $04

Snd_FBZ2_Loop06:
	dc.b	nA1, $06, nA1, nA2, $0C, nA1, $06, nA1, nA1, $03, nRst, nA1
	dc.b	nRst, nAb1, $0C, nAb2, $04, nRst, $08, nAb1, $0C, nAb1, $06, nAb1
	dc.b	nG1, nG1, nG2, $0C, nG1, $06, nG1, nG1, $03, nRst, nG1, nRst
	dc.b	nAb1, $0C, nAb2, $04, nRst, $08, nAb1, $0C, nAb1, $06, nAb1, nA1
	dc.b	$0C, nA1, nA1, nG2, $06, nA2, nA1, $0C, nA1, nA1, nG2, $06
	dc.b	nA2, nG2, nA2, $03, nRst, nA1, $0C, nA1, nG2, $06, nA2, $03
	dc.b	nRst, nA1, $0C, nA1, nG2, $06, nA2, $03, nRst, nA1, $0C
	smpsLoop            $00, $04, Snd_FBZ2_Loop06
	dc.b	nF1, $06, nF1, nF2, $0C, nF1, $06, nF1, nF2, $0C, nF1, $06
	dc.b	nF1, nF2, $0C, nF1, $06, nF1, nF2, $0C, nG1, $06, nG1, nG2
	dc.b	$0C, nG1, $06, nG1, nG2, $0C, nG1, $06, nG1, nG2, $0C, nG1
	dc.b	$06, nG1, nG2, $0C, nAb1, $06, nAb1, nAb2, $0C, nAb1, $06, nAb1
	dc.b	nAb2, $0C, nAb1, $06, nAb1, nAb2, $0C, nAb1, $06, nAb1, nAb2, $0C
	dc.b	nA1, $06, nA1, nA2, $0C, nA1, $06, nA1, nA2, $0C, nG1, $06
	dc.b	nG1, nG2, $0C, nG1, $06, nG1, nG2, $0C, nF1, $06, nF1, nF2
	dc.b	$0C, nF1, $06, nF1, nF2, $0C, nF1, $06, nF1, nF2, $0C, nF1
	dc.b	$06, nF1, nF2, $0C, nG1, $06, nG1, nG2, $0C, nG1, $06, nG1
	dc.b	nG2, $0C, nG1, $06, nG1, nG2, $0C, nG1, $06, nG1, nG2, $0C
	dc.b	nAb1, $06, nAb1, nAb2, $0C, nAb1, $06, nAb1, nAb2, $0C, nAb1, $06
	dc.b	nAb1, nAb2, $0C, nAb1, $06, nAb1, nAb2, $0C, nA1, $06, nA1, nA2
	dc.b	$0C, nA1, $06, nA1, nA2, $0C, nA1, $06, nA1, nA2, $0C, nA1
	dc.b	$06, nA1, nA2, $0C, nA1, $06, nRst, nA1, nRst, nA1, nRst, nA1
	dc.b	nA1, nA1, nA2, $02, nRst, $04, nG2, $06, nA2, nD2, nE2, nA1
	dc.b	$02, nRst, $04, nA1, $02, nRst, $04
	smpsJump            Snd_FBZ2_Loop06

; Unreachable
	smpsStop

; FM3 Data
Snd_FBZ2_FM3:
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panRight, $00
	dc.b	nRst, $60

Snd_FBZ2_Loop05:
	smpsSetvoice        $03
	dc.b	nA4, $10, nRst, $08, nG4, $10, nRst, $08, nE4, $0F, nRst, $03
	dc.b	nC4, $0F, nRst, $03, nA3, $06, nRst, nRst, nC4, $12, nD4, $06
	dc.b	nRst, nE4, nRst, nD4, $12, nC4, $06, nRst, $18
	smpsSetvoice        $04
	dc.b	nE4, $30, nF4, nFs4, nF4
	smpsLoop            $00, $04, Snd_FBZ2_Loop05
	smpsSetvoice        $06
	dc.b	nF4, $30, nC4, $18, nA4, nG4, $48, nD4, $18, nD4, $48, nF4
	dc.b	$0C
	smpsSetvoice        $07
	dc.b	nAb4, $03, nA4, nBb4, nB4, nC5, $18, nA4, nA4, nE4
	smpsSetvoice        $06
	dc.b	nF4, $30, nC4, $18, nA4, nG4, $48, nD4, $18, nD4, $48, nF4
	dc.b	$18, nE4, $7F, smpsNoAttack, nE4, $11, nRst, $30
	smpsJump            Snd_FBZ2_Loop05

; Unreachable
	smpsStop

; FM4 Data
Snd_FBZ2_FM4:
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panLeft, $00
	dc.b	nRst, $60

Snd_FBZ2_Loop04:
	smpsSetvoice        $03
	dc.b	nE4, $10, nRst, $08, nE4, $10, nRst, $08, nC4, $0F, nRst, $03
	dc.b	nA3, $0F, nRst, $03, nE3, $06, nRst, nRst, nA3, $12, nB3, $06
	dc.b	nRst, nC4, nRst, nB3, $12, nA3, $06, nRst, $18
	smpsSetvoice        $04
	dc.b	nC4, $30, nC4, nC4, nC4
	smpsLoop            $00, $04, Snd_FBZ2_Loop04
	smpsSetvoice        $06
	dc.b	nA3, $30, nA3, nD4, $18, nC4, nB3, $30, nB3, $18, nA3, nAb3
	dc.b	$24
	smpsSetvoice        $07
	dc.b	nF4, $03, nFs4, nG4, nAb4, nA4, $18, nE4, nE4, nC4
	smpsSetvoice        $06
	dc.b	nA3, $30, nA3, nD4, $18, nC4, nB3, $30, nB3, $18, nA3, nAb3
	dc.b	$30, nC4, $7F, smpsNoAttack, nC4, $11, nRst, $30
	smpsJump            Snd_FBZ2_Loop04

; Unreachable
	smpsStop

; FM5 Data
Snd_FBZ2_FM5:
	dc.b	nRst, $10
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	smpsAlterNote       $FE
	dc.b	nRst, $60

Snd_FBZ2_Loop03:
	smpsSetvoice        $00
	dc.b	nRst, $0C, nB4, $04, nRst, $08, nC5, $04, nRst, $08, nB4, $24
	dc.b	nE5, $04, nRst, $14, nEb5, $02, nE5, $16, nC5, $04, nRst, $08
	dc.b	nA4, $18, nE4, $60, nRst, $24
	smpsSetvoice        $02
	dc.b	nRst, $36, nD5, $06, nE5, nG5, nB4, nC5, nA4, $0C
	smpsLoop            $00, $02, Snd_FBZ2_Loop03
	smpsSetvoice        $05
	dc.b	nE4, $48, nE4, $06, nA4, $04, nRst, $08, nE4, $42, nD4, $06
	dc.b	nRst, nC4, nRst, nB3, nRst, nC4, $12, nA3, $06, nRst, $48, nRst
	dc.b	$60, nE4, $48, nE4, $06, nA4, $04, nRst, $08, nE4, $42, nD4
	dc.b	$06, nRst, nC4, nRst, nB3, nRst, nC4, $12, nE4, $06, nRst, $48
	dc.b	nRst, $3C, nE5, $0C, nD5, nC5, nC5, $12, nA4, nE5, $30, nD5
	dc.b	$06, nC5, nD5, $0B, nRst, $07, nB4, $0B, nRst, $07, nG4, $24
	dc.b	nB4, $0C, nA4, nAb4, $12, nB4, $06, nRst, $0C, nD5, $18, nF5
	dc.b	$06, nRst, nE5, nRst, nD5, nRst, nE5, $10, nRst, $08, nD5, $10
	dc.b	nRst, $08, nC5, $10, nRst, $08, nB4, $10, nRst, $08, nC5, $12
	dc.b	nA4, nE5, $2D, nRst, $03, nD5, $06, nC5, nD5, $0B, nRst, $07
	dc.b	nB4, $0B, nRst, $07, nG4, $24, nB4, $0C, nA4, nAb4, $12, nB4
	dc.b	$06, nRst, $0C, nD5, $18, nF5, $06, nRst, nE5, nRst, nD5, nRst
	dc.b	nE5, nD5, nE5, $7F, smpsNoAttack, nE5, $05, nRst, $30
	smpsJump            Snd_FBZ2_Loop03

; Unreachable
	smpsStop

; DAC Data
Snd_FBZ2_DAC:
	dc.b	nRst, $48, dSnareS3, $06, dSnareS3, dSnareS3, dSnareS3

Snd_FBZ2_Loop00:
	dc.b	dKickS3, $18, dSnareS3, $06, dKickS3, dKickS3, dKickS3, dKickS3, $0C, dKickS3, dSnareS3, $18
	dc.b	dKickS3, dSnareS3, $06, dKickS3, dKickS3, dKickS3, dKickS3, $0C, dKickS3, dSnareS3, $18, dKickS3
	dc.b	dSnareS3, $06, dKickS3, dKickS3, dKickS3, dKickS3, $0C, dKickS3, dSnareS3, $18, dSnareS3, $06
	dc.b	dSnareS3, dKickS3, $0C, dKickS3, dSnareS3, $06, dSnareS3, dKickS3, $0C, dKickS3, dSnareS3, $06
	dc.b	dSnareS3, dSnareS3, $0C
	smpsLoop            $00, $03, Snd_FBZ2_Loop00

Snd_FBZ2_Loop01:
	dc.b	dKickS3, $18, dSnareS3, $06, dKickS3, dKickS3, dKickS3, dKickS3, $0C, dKickS3, dSnareS3, $18
	smpsLoop            $00, $03, Snd_FBZ2_Loop01
	dc.b	dSnareS3, $06, dSnareS3, dKickS3, $0C, dKickS3, dSnareS3, $06, dSnareS3, dKickS3, $0C, dSnareS3
	dc.b	dSnareS3, $06, dSnareS3, dSnareS3, dSnareS3

Snd_FBZ2_Loop02:
	dc.b	dKickS3, $0C, dClapS3, dSnareS3, dClapS3, $06, dClapS3, dKickS3, $0C, dClapS3, dSnareS3, dClapS3
	dc.b	$06, dClapS3, dKickS3, $0C, dClapS3, dSnareS3, dClapS3, $06, dClapS3, dKickS3, dClapS3, dClapS3
	dc.b	dClapS3, dSnareS3, $0C, dClapS3
	smpsLoop            $00, $04, Snd_FBZ2_Loop02
	dc.b	dKickS3, $0C, dSnareS3, dSnareS3, dSnareS3, $06, dSnareS3, dSnareS3, $30
	smpsJump            Snd_FBZ2_Loop00

; Unreachable
	smpsStop

; PSG1 Data
Snd_FBZ2_PSG1:
	smpsStop

; PSG2 Data
Snd_FBZ2_PSG2:
	smpsStop

; Unreachable
	smpsStop

; PSG3 Data
Snd_FBZ2_PSG3:
	smpsStop

Snd_FBZ2_Voices:
;	Voice $00
;	$05
;	$2E, $17, $1F, $1F, 	$1F, $1F, $1F, $1F, 	$00, $0B, $08, $08
;	$00, $08, $08, $08, 	$00, $19, $19, $19, 	$28, $8A, $89, $89
	smpsVcAlgorithm     $05
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $01, $01, $02
	smpsVcCoarseFreq    $0F, $0F, $07, $0E
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $08, $0B, $00
	smpsVcDecayRate2    $08, $08, $08, $00
	smpsVcDecayLevel    $01, $01, $01, $00
	smpsVcReleaseRate   $09, $09, $09, $00
	smpsVcTotalLevel    $09, $09, $0A, $28

;	Voice $01
;	$03
;	$74, $18, $71, $11, 	$DF, $5F, $1F, $1F, 	$0C, $0F, $01, $01
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$0B, $1D, $10, $84
	smpsVcAlgorithm     $03
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $07, $01, $07
	smpsVcCoarseFreq    $01, $01, $08, $04
	smpsVcRateScale     $00, $00, $01, $03
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $01, $0F, $0C
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $04, $10, $1D, $0B

;	Voice $02
;	$02
;	$71, $52, $41, $11, 	$17, $16, $15, $17, 	$0A, $03, $05, $03
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$07, $1F, $25, $87
	smpsVcAlgorithm     $02
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $04, $05, $07
	smpsVcCoarseFreq    $01, $01, $02, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $17, $15, $16, $17
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $05, $03, $0A
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $07, $25, $1F, $07

;	Voice $03
;	$3D
;	$41, $01, $21, $71, 	$0D, $12, $52, $D2, 	$01, $01, $01, $01
;	$08, $00, $09, $00, 	$89, $F8, $F9, $F8, 	$1D, $87, $87, $87
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $02, $00, $04
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $03, $01, $00, $00
	smpsVcAttackRate    $12, $12, $12, $0D
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $01, $01, $01
	smpsVcDecayRate2    $00, $09, $00, $08
	smpsVcDecayLevel    $0F, $0F, $0F, $08
	smpsVcReleaseRate   $08, $09, $08, $09
	smpsVcTotalLevel    $07, $07, $07, $1D

;	Voice $04
;	$03
;	$61, $51, $23, $41, 	$10, $10, $0F, $15, 	$1C, $01, $06, $05
;	$05, $01, $05, $01, 	$C9, $0C, $D9, $C9, 	$18, $17, $17, $83
	smpsVcAlgorithm     $03
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $02, $05, $06
	smpsVcCoarseFreq    $01, $03, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $15, $0F, $10, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $06, $01, $1C
	smpsVcDecayRate2    $01, $05, $01, $05
	smpsVcDecayLevel    $0C, $0D, $00, $0C
	smpsVcReleaseRate   $09, $09, $0C, $09
	smpsVcTotalLevel    $03, $17, $17, $18

;	Voice $05
;	$02
;	$74, $51, $13, $31, 	$93, $D3, $12, $13, 	$06, $01, $01, $03
;	$0C, $13, $0C, $0B, 	$FF, $EF, $DF, $8F, 	$33, $13, $19, $83
	smpsVcAlgorithm     $02
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $01, $05, $07
	smpsVcCoarseFreq    $01, $03, $01, $04
	smpsVcRateScale     $00, $00, $03, $02
	smpsVcAttackRate    $13, $12, $13, $13
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $01, $01, $06
	smpsVcDecayRate2    $0B, $0C, $13, $0C
	smpsVcDecayLevel    $08, $0D, $0E, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $03, $19, $13, $33

;	Voice $06
;	$3D
;	$71, $73, $22, $31, 	$10, $18, $14, $14, 	$01, $01, $00, $02
;	$00, $06, $04, $07, 	$FF, $FC, $FF, $F8, 	$1E, $8A, $87, $87
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $02, $07, $07
	smpsVcCoarseFreq    $01, $02, $03, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $14, $14, $18, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $00, $01, $01
	smpsVcDecayRate2    $07, $04, $06, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $08, $0F, $0C, $0F
	smpsVcTotalLevel    $07, $07, $0A, $1E

;	Voice $07
;	$14
;	$21, $12, $33, $44, 	$1D, $1D, $1D, $1E, 	$00, $01, $01, $01
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$2D, $86, $2D, $87
	smpsVcAlgorithm     $04
	smpsVcFeedback      $02
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $03, $01, $02
	smpsVcCoarseFreq    $04, $03, $02, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1E, $1D, $1D, $1D
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $01, $01, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $07, $2D, $06, $2D

