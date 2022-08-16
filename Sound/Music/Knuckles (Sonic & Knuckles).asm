Snd_Knux_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_Knux_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $10

	smpsHeaderDAC       Snd_Knux_DAC
	smpsHeaderFM        Snd_Knux_FM1,	$0C, $11
	smpsHeaderFM        Snd_Knux_FM2,	$FE, $00
	smpsHeaderFM        Snd_Knux_FM3,	$0C, $17
	smpsHeaderFM        Snd_Knux_FM4,	$F4, $0E
	smpsHeaderFM        Snd_Knux_FM5,	$18, $10
	smpsHeaderPSG       Snd_Knux_PSG1,	$F4, $05, $00, $00
	smpsHeaderPSG       Snd_Knux_PSG2,	$F4, $02, $00, $00
	smpsHeaderPSG       Snd_Knux_PSG3,	$00, $03, $00, $00

; FM1 Data
Snd_Knux_FM1:
	smpsSetvoice        $05

Snd_Knux_Jump01:
	dc.b	nA3, $06, nG3, nG3, nG3, nG3, nE3, nE3, nE3, nD3, nE3, nD3
	dc.b	nC3, nC3, nA2, nA2, nA2, nRst, $0C, nE3, nE3, nD3, nC3, nA2
	dc.b	nA2, nA2, nG2, nA2, nA2, nA2, nC3, nA2, nA2, nA2, nRst, $0C
	dc.b	nE3, nE3, nD3, nC3, nA2, nA2, nA2, nA3, nA3, nG3, nE3, nE3
	dc.b	nA2, nRst, nA2, nRst, nE3, nE3, nD3, nC3, nA2, nA2, nA2, nG2
	dc.b	nA2, nA2, nA2, nC3, nA2, nA2, nA2, nRst, nE3, nE3, nD3, nC3
	dc.b	nA2, nA2, nA2, nG2, nA2, nA3, nG3, nA3, $06, nA1, $03, nB1
	dc.b	nC2, nD2, nE2, nF2, nG2, nA2, nB2, nC3, nD3, nE3, nF3, nG3
	smpsJump            Snd_Knux_Jump01

; Unreachable
	smpsStop

; FM2 Data
Snd_Knux_FM2:
	smpsModSet          $01, $01, $F0, $00

Snd_Knux_Jump00:
	dc.b	nRst, $60

Snd_Knux_Loop01:
	smpsSetvoice        $04
	dc.b	nG3, $13, $05, nD3, $0C
	smpsSetvoice        $07
	dc.b	nRst
	smpsLoop            $00, $10, Snd_Knux_Loop01
	smpsJump            Snd_Knux_Jump00

; Unreachable
	smpsStop

; FM3 Data
Snd_Knux_FM3:
	dc.b	nRst, $0C
	smpsAlterNote       $FE
	smpsJump            Snd_Knux_FM1

; Unreachable
	smpsStop

; FM4 Data
Snd_Knux_FM4:
	smpsSetvoice        $06
	smpsNoteFill        $05
	dc.b	nA5, $06, nG5, nG5, nG5, nG5, nE5, nE5, nE5, nD5, nE5, nD5
	dc.b	nC5, nC5, nA4, nA4, nA4, nRst, $60, nRst, nRst, nA5, $0C
	smpsNoteFill        $0B
	dc.b	$0C, nG5, nE5
	smpsNoteFill        $15
	dc.b	nE5, $18, nRst, nRst, $60, nRst, nRst
	smpsNoteFill        $0C
	dc.b	nRst, $18, nA5, $0C, nG5, nA5, nRst, $24
	smpsJump            Snd_Knux_FM4

; Unreachable
	smpsStop

; FM5 Data
Snd_Knux_FM5:
	smpsAlterNote       $FE
	smpsAlterPitch      $E8
	smpsJump            Snd_Knux_FM4

; Unreachable
	smpsSetvoice        $03
	smpsAlterNote       $02
	smpsStop

; PSG1 Data
Snd_Knux_PSG1:
	smpsPSGvoice        sTone_0A
	dc.b	nRst, $0B

Snd_Knux_Jump04:
	dc.b	nRst, $60, nA3, $0C
	smpsNoteFill        $05
	dc.b	$06, $06
	smpsNoteFill        $00
	dc.b	$0C, $0C, nC4, $24, nA3, $0C, nC4, nD4, nBb3, $01, smpsNoAttack, nA3
	dc.b	$23, $06, $06, $06, nRst, nA3, $0C, nAb3, $02, smpsNoAttack, nG3, $0A
	dc.b	nE3, $0C, nE3, $24, nC3, $0C, nD3, nE3, nE3, $02, smpsNoAttack, nD3
	dc.b	$0A, nC3, $0C, nA2, $48, nA3, $0C
	smpsNoteFill        $05
	dc.b	$06, $06, $06, $06, $06, $06
	smpsNoteFill        $00
	dc.b	nC4, $24, nA3, $0C, nC4, nD4, nA3, $24
	smpsNoteFill        $05
	dc.b	$06, $06, $06, $06
	smpsNoteFill        $00
	dc.b	$0C, nE4, nD4, smpsNoAttack, nD4, nC4, nC4, $01, smpsNoAttack, nCs4, smpsNoAttack, nD4
	dc.b	smpsNoAttack, nC4, $09, nA3, $0C, nA3, nG3, nA3, nRst, nA4, nG4, nA4
	dc.b	nRst, nRst, nRst
	smpsJump            Snd_Knux_Jump04

; Unreachable
	smpsStop

; PSG2 Data
Snd_Knux_PSG2:
	smpsPSGvoice        sTone_0A
	smpsAlterNote       $FF

Snd_Knux_Jump03:
	dc.b	nRst, $60, nA3, $0C
	smpsNoteFill        $05
	dc.b	$06, $06
	smpsNoteFill        $00
	dc.b	$0C, $0C, nC4, $24, nA3, $0C, nC4, nD4, nBb3, $01, smpsNoAttack, nA3
	dc.b	$23, $06, $06, $06, nRst, nA3, $0C, nAb3, $02, smpsNoAttack, nG3, $0A
	dc.b	nE3, $0C, nE3, $24, nC3, $0C, nD3, nE3, nE3, $02, smpsNoAttack, nD3
	dc.b	$0A, nC3, $0C, nA2, $48, nA3, $0C
	smpsNoteFill        $05
	dc.b	$06, $06, $06, $06, $06, $06
	smpsNoteFill        $00
	dc.b	nC4, $24, nA3, $0C, nC4, nD4, nA3, $24
	smpsNoteFill        $05
	dc.b	$06, $06, $06, $06
	smpsNoteFill        $00
	dc.b	$0C
	smpsAlterNote       $00
	dc.b	nE4
	smpsAlterNote       $FF
	dc.b	nD4, smpsNoAttack, nD4, nC4, nC4, $01, smpsNoAttack, nCs4, smpsNoAttack, nD4, smpsNoAttack, nC4
	dc.b	$09, nA3, $0C, nA3, nG3, nA3, nRst, nA4, nG4, nA4, nRst, nRst
	dc.b	nRst
	smpsJump            Snd_Knux_Jump03

; Unreachable
	smpsStop

; PSG3 Data
Snd_Knux_PSG3:
	smpsPSGform         $E7

Snd_Knux_Jump02:
	smpsPSGvoice        sTone_26
	dc.b	nMaxPSG2, $60
	smpsPSGvoice        sTone_01

Snd_Knux_Loop02:
	dc.b	nMaxPSG2, $06, nRst, nMaxPSG2, nRst, nMaxPSG2, nRst, nMaxPSG2, nRst, nMaxPSG2, nRst, nMaxPSG2
	dc.b	nRst, nMaxPSG2, nRst, nMaxPSG2, nRst
	smpsLoop            $00, $08, Snd_Knux_Loop02
	smpsJump            Snd_Knux_Jump02

; Unreachable
	smpsStop

; DAC Data
Snd_Knux_DAC:
	dc.b	dCrashCymbal, $3C, dEchoedClapHit, $06, dEchoedClapHit, nRst, dEchoedClapHit, dEchoedClapHit, nRst

Snd_Knux_Loop00:
	dc.b	dLooserSnare, $18, dElectricFloorTom, dElectricFloorTom, $0C, dEchoedClapHit, $06, dEchoedClapHit, dElectricFloorTom, dEchoedClapHit, dEchoedClapHit, nRst
	smpsLoop            $00, $08, Snd_Knux_Loop00
	smpsJump            Snd_Knux_DAC

; Unreachable
	smpsStop

Snd_Knux_Voices:
;	Voice $00
;	$01
;	$02, $00, $00, $00, 	$1F, $1F, $1F, $1F, 	$10, $18, $18, $10
;	$0E, $00, $00, $08, 	$FF, $FF, $FF, $0F, 	$12, $10, $10, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $00, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $10, $18, $18, $10
	smpsVcDecayRate2    $08, $00, $00, $0E
	smpsVcDecayLevel    $00, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $10, $10, $12

;	Voice $01
;	$05
;	$00, $00, $00, $00, 	$1F, $1F, $1F, $1F, 	$12, $0C, $0C, $0C
;	$12, $18, $1F, $1F, 	$1F, $1F, $1F, $1F, 	$07, $86, $86, $86
	smpsVcAlgorithm     $05
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0C, $0C, $0C, $12
	smpsVcDecayRate2    $1F, $1F, $18, $12
	smpsVcDecayLevel    $01, $01, $01, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $06, $06, $06, $07

;	Voice $02
;	$3C
;	$00, $00, $F0, $F1, 	$1F, $1F, $17, $1F, 	$1F, $1F, $14, $1F
;	$09, $11, $3A, $1D, 	$02, $0F, $9F, $7F, 	$03, $80, $02, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $0F, $0F, $00, $00
	smpsVcCoarseFreq    $01, $00, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $17, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $1F, $14, $1F, $1F
	smpsVcDecayRate2    $1D, $3A, $11, $09
	smpsVcDecayLevel    $07, $09, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $02
	smpsVcTotalLevel    $00, $02, $00, $03

;	Voice $03
;	$3C
;	$22, $00, $01, $10, 	$12, $13, $12, $12, 	$00, $00, $00, $10
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $3F, 	$23, $90, $1E, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $00, $00, $02
	smpsVcCoarseFreq    $00, $01, $00, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $12, $12, $13, $12
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $10, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $03, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1E, $10, $23

;	Voice $04
;	$00
;	$00, $03, $02, $00, 	$D9, $DF, $1F, $1F, 	$12, $11, $14, $0C
;	$0A, $00, $0A, $02, 	$FF, $FF, $FF, $FF, 	$22, $07, $27, $85
	smpsVcAlgorithm     $00
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $02, $03, $00
	smpsVcRateScale     $00, $00, $03, $03
	smpsVcAttackRate    $1F, $1F, $1F, $19
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0C, $14, $11, $12
	smpsVcDecayRate2    $02, $0A, $00, $0A
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $05, $27, $07, $22

;	Voice $05
;	$3C
;	$36, $31, $76, $72, 	$94, $9F, $96, $9F, 	$12, $00, $14, $0F
;	$04, $0A, $04, $0D, 	$2F, $0F, $4F, $2F, 	$33, $80, $1A, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $07, $03, $03
	smpsVcCoarseFreq    $02, $06, $01, $06
	smpsVcRateScale     $02, $02, $02, $02
	smpsVcAttackRate    $1F, $16, $1F, $14
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0F, $14, $00, $12
	smpsVcDecayRate2    $0D, $04, $0A, $04
	smpsVcDecayLevel    $02, $04, $00, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1A, $00, $33

;	Voice $06
;	$3A
;	$01, $07, $31, $71, 	$8E, $8E, $8D, $53, 	$0E, $0E, $0E, $03
;	$00, $00, $00, $07, 	$1F, $FF, $1F, $0F, 	$18, $28, $27, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $03, $00, $00
	smpsVcCoarseFreq    $01, $01, $07, $01
	smpsVcRateScale     $01, $02, $02, $02
	smpsVcAttackRate    $13, $0D, $0E, $0E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $0E, $0E, $0E
	smpsVcDecayRate2    $07, $00, $00, $00
	smpsVcDecayLevel    $00, $01, $0F, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $27, $28, $18

;	Voice $07
;	$01
;	$DF, $09, $03, $09, 	$10, $1F, $1F, $1F, 	$09, $00, $00, $0E
;	$00, $00, $00, $13, 	$15, $05, $05, $3A, 	$0C, $08, $0C, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $0D
	smpsVcCoarseFreq    $09, $03, $09, $0F
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0E, $00, $00, $09
	smpsVcDecayRate2    $13, $00, $00, $00
	smpsVcDecayLevel    $03, $00, $00, $01
	smpsVcReleaseRate   $0A, $05, $05, $05
	smpsVcTotalLevel    $00, $0C, $08, $0C

