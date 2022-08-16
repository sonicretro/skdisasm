Snd_MGZ2_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_MGZ2_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $3D

	smpsHeaderDAC       Snd_MGZ2_DAC
	smpsHeaderFM        Snd_MGZ2_FM1,	$00, $09
	smpsHeaderFM        Snd_MGZ2_FM2,	$00, $0C
	smpsHeaderFM        Snd_MGZ2_FM3,	$00, $0D
	smpsHeaderFM        Snd_MGZ2_FM4,	$00, $0D
	smpsHeaderFM        Snd_MGZ2_FM5,	$00, $1D
	smpsHeaderPSG       Snd_MGZ2_PSG1,	$E8, $02, $00, $00
	smpsHeaderPSG       Snd_MGZ2_PSG2,	$E8, $02, $00, $00
	smpsHeaderPSG       Snd_MGZ2_PSG3,	$E8, $02, $00, $00

; FM1 Data
Snd_MGZ2_FM1:
	smpsSetvoice        $01
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00

Snd_MGZ2_Loop01:
	dc.b	nCs1, $08, nCs2, $04, nB1, $08, nRst, $04, nB1, $08, nRst, $04
	dc.b	nBb1, $08, nB1, $10, nBb1, $06, nRst, nAb1, nRst, nFs1, nRst, nFs1
	dc.b	$08, nFs2, $04, nE2, $0C, nE2, $06, nRst, $02, nEb2, $06, nRst
	dc.b	$06, nE2, $04, nRst, $30
	smpsLoop            $00, $0A, Snd_MGZ2_Loop01

Snd_MGZ2_Loop02:
	dc.b	nB1, $18, nEb2, $14, nE2, $10, nFs2, $06, nRst, nA2, nRst, nB2
	dc.b	nRst, nB1, $08, nB1, $04, nB1, $0C, nFs1, $02, nRst, $06, nFs1
	dc.b	$0C, nG1, $10, nG1, $0C, nA1, nBb1
	smpsLoop            $00, $03, Snd_MGZ2_Loop02
	dc.b	nB1, $18, nD2, $14, nE2, $10, nF2, $06, nRst, nA2, nRst, nB2
	dc.b	nRst, nB1, $08, nB1, $04, nB1, $0C, nFs1, $02, nRst, $06, nA1
	dc.b	$0C, nB1, $06, nRst, $16, nC2, $18
	smpsJump            Snd_MGZ2_FM1

; Unreachable
	smpsStop

; FM2 Data
Snd_MGZ2_FM2:
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
	dc.b	$1E, nAb4, $02, nFs4, nF4, nE4, $60, nRst, $38
	smpsSetvoice        $05
	dc.b	nCs5, $04, nEb5, $08, nE5, $04, nEb5, $08, nCs5, $06, nRst, nCs5
	dc.b	$04
	smpsSetvoice        $00
	dc.b	nRst, $18, nCs5, $06, nRst, $12, nB4, $06, nRst, $12, nBb4, $06
	dc.b	nRst, $12, nAb4, $48, nBb4, $18, nE4, $30, nEb4, $06, nRst, nE4
	dc.b	$24, nCs4, $60
	smpsSetvoice        $04
	dc.b	nRst, $18, nB4, $06, nRst, $12, nEb5, $0C, nE5, $06, nRst, $12
	dc.b	nEb5, $06, nRst, nRst, $0C, nFs5, $06, nRst, $12, nB4, $3C, nB5
	dc.b	$24, nFs5, $06, nG5, nG5, $0C, nFs5, nE5, nFs5, $06, nRst, nRst
	dc.b	$0C, nEb5, $06, nRst, $12, nB4, $3C, nRst, $18, nB4, $06, nRst
	dc.b	$12, nEb5, $0C, nE5, $06, nRst, nEb5, $04, nRst, nEb5, nE5, $0C
	dc.b	nFs5, nEb5, $06, nRst, $12, nB4, $3C, nB5, $24, nFs5, $06, nG5
	dc.b	nFs5, $0C, nE5, nEb5, nCs5, $06, nRst, nRst, $0C, nEb5, $06, nRst
	dc.b	$12, nB4, $24, nRst, $18
	smpsJump            Snd_MGZ2_FM2

; Unreachable
	smpsStop

; FM3 Data
Snd_MGZ2_FM3:
	smpsSetvoice        $02
	smpsModSet          $0D, $01, $02, $06
	dc.b	nRst, $18, nB3, $14, nB3, $06, nRst, $2E, nRst, $18, nCs4, $14
	dc.b	nCs4, $06, nRst, nB3, $23, nRst, $05, nB3, $48, nRst, $18, nAb3
	dc.b	$48, nRst, $18
	smpsLoop            $00, $05, Snd_MGZ2_FM3
	smpsSetvoice        $03
	dc.b	nE3, $60, nEb3, $48, nEb3, $18, nE3, $60, nEb3, nE3, nEb3, $48
	dc.b	nEb3, $18, nD3, $60, nEb3, $48, nRst, $18
	smpsJump            Snd_MGZ2_FM3

; Unreachable
	smpsStop

; FM4 Data
Snd_MGZ2_FM4:
	smpsSetvoice        $02
	smpsModSet          $0D, $01, $02, $06
	dc.b	nRst, $18, nE4, $14, nE4, $06, nRst, $2E, nRst, $18, nFs4, $14
	dc.b	nFs4, $06, nRst, nE4, $28, nE4, $48, nRst, $18, nCs4, $48, nRst
	dc.b	$18
	smpsLoop            $00, $05, Snd_MGZ2_FM4
	smpsSetvoice        $03
	dc.b	nG3, $60, nFs3, $48, nFs3, $18, nG3, $60, nFs3, nG3, nFs3, $48
	dc.b	nFs3, $18, nF3, $60, nFs3, $48, nRst, $18
	smpsJump            Snd_MGZ2_FM4

; Unreachable
	smpsStop

; FM5 Data
Snd_MGZ2_FM5:
	dc.b	nRst, $14

Snd_MGZ2_Jump00:
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
	dc.b	$1E, nAb4, $02, nFs4, nF4, nE4, $60, nRst, $38
	smpsSetvoice        $05
	dc.b	nCs5, $04, nEb5, $08, nE5, $04, nEb5, $08, nCs5, $06, nRst, nCs5
	dc.b	$04
	smpsSetvoice        $00
	dc.b	nRst, $18, nCs5, $06, nRst, $12, nB4, $06, nRst, $12, nBb4, $06
	dc.b	nRst, $12, nAb4, $48, nBb4, $18, nE4, $30, nEb4, $06, nRst, nE4
	dc.b	$24, nCs4, $60
	smpsSetvoice        $04
	dc.b	nRst, $18, nB4, $06, nRst, $12, nEb5, $0C, nE5, $06, nRst, $12
	dc.b	nEb5, $06, nRst, nRst, $0C, nFs5, $06, nRst, $12, nB4, $3C, nB5
	dc.b	$24, nFs5, $06, nG5, nG5, $0C, nFs5, nE5, nFs5, $06, nRst, nRst
	dc.b	$0C, nEb5, $06, nRst, $12, nB4, $3C, nRst, $18, nB4, $06, nRst
	dc.b	$12, nEb5, $0C, nE5, $06, nRst, nEb5, $04, nRst, nEb5, nE5, $0C
	dc.b	nFs5, nEb5, $06, nRst, $12, nB4, $3C, nB5, $24, nFs5, $06, nG5
	dc.b	nFs5, $0C, nE5, nEb5, nCs5, $06, nRst, nRst, $0C, nEb5, $06, nRst
	dc.b	$12, nB4, $24, nRst, $18
	smpsJump            Snd_MGZ2_Jump00

; Unreachable
	smpsStop

; DAC Data
Snd_MGZ2_DAC:
	dc.b	dKickS3, $18, dSnareS3, $14, dKickS3, $10, dKickS3, $0C, dSnareS3, dKickS3, dKickS3, $18
	dc.b	dSnareS3, $08, dKickS3, $0C, dKickS3, $1C, dSnareS3, $18
	smpsLoop            $00, $09, Snd_MGZ2_DAC
	dc.b	dKickS3, $18, dSnareS3, $14, dKickS3, $10, dKickS3, $0C, dSnareS3, dKickS3, dKickS3, $18
	dc.b	dSnareS3, $08, dKickS3, $0C, dKickS3, $10, dSnareS3, $0C, dSnareS3, $08, dSnareS3, $04
	dc.b	dSnareS3, $0C

Snd_MGZ2_Loop00:
	dc.b	dKickS3, $18, dSnareS3, $14, dKickS3, $10, dKickS3, $0C, dSnareS3, dKickS3, dKickS3, $18
	dc.b	dSnareS3, $08, dKickS3, $0C, dKickS3, $10, dSnareS3, $0C, dSnareS3, dSnareS3
	smpsLoop            $00, $04, Snd_MGZ2_Loop00
	smpsJump            Snd_MGZ2_DAC

; Unreachable
	smpsStop

; PSG1 Data
Snd_MGZ2_PSG1:
	smpsStop

; PSG2 Data
Snd_MGZ2_PSG2:
	smpsStop

; Unreachable
	smpsStop

; PSG3 Data
Snd_MGZ2_PSG3:
	smpsStop

Snd_MGZ2_Voices:
;	Voice $00
;	$10
;	$46, $13, $76, $41, 	$19, $55, $50, $11, 	$02, $06, $05, $01
;	$00, $0F, $00, $00, 	$18, $38, $58, $18, 	$2D, $1F, $1B, $81
	smpsVcAlgorithm     $00
	smpsVcFeedback      $02
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $07, $01, $04
	smpsVcCoarseFreq    $01, $06, $03, $06
	smpsVcRateScale     $00, $01, $01, $00
	smpsVcAttackRate    $11, $10, $15, $19
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $05, $06, $02
	smpsVcDecayRate2    $00, $00, $0F, $00
	smpsVcDecayLevel    $01, $05, $03, $01
	smpsVcReleaseRate   $08, $08, $08, $08
	smpsVcTotalLevel    $01, $1B, $1F, $2D

;	Voice $01
;	$38
;	$75, $13, $71, $11, 	$DF, $5F, $1F, $1F, 	$0C, $0D, $01, $01
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$1E, $1E, $1E, $81
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $07, $01, $07
	smpsVcCoarseFreq    $01, $01, $03, $05
	smpsVcRateScale     $00, $00, $01, $03
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $01, $0D, $0C
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $1E, $1E, $1E

;	Voice $02
;	$02
;	$71, $52, $41, $11, 	$17, $16, $15, $17, 	$0A, $03, $05, $03
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$07, $1F, $25, $8A
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
	smpsVcTotalLevel    $0A, $25, $1F, $07

;	Voice $03
;	$3D
;	$41, $01, $21, $71, 	$0D, $12, $52, $D2, 	$01, $01, $01, $01
;	$08, $00, $09, $00, 	$89, $F8, $F9, $F8, 	$1D, $8B, $8B, $8B
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
	smpsVcTotalLevel    $0B, $0B, $0B, $1D

;	Voice $04
;	$03
;	$61, $51, $23, $41, 	$10, $10, $0F, $15, 	$1C, $01, $06, $05
;	$05, $01, $05, $01, 	$C9, $0C, $D9, $C9, 	$18, $17, $17, $81
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
	smpsVcTotalLevel    $01, $17, $17, $18

;	Voice $05
;	$3D
;	$7B, $57, $14, $31, 	$9E, $DE, $1F, $1F, 	$0C, $01, $0D, $0B
;	$0C, $13, $0C, $0B, 	$FF, $EF, $DF, $8F, 	$30, $8C, $8F, $81
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $01, $05, $07
	smpsVcCoarseFreq    $01, $04, $07, $0B
	smpsVcRateScale     $00, $00, $03, $02
	smpsVcAttackRate    $1F, $1F, $1E, $1E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0B, $0D, $01, $0C
	smpsVcDecayRate2    $0B, $0C, $13, $0C
	smpsVcDecayLevel    $08, $0D, $0E, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $0F, $0C, $30

