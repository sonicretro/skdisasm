Snd_Invic_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_Invic_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $70

	smpsHeaderDAC       Snd_Invic_DAC
	smpsHeaderFM        Snd_Invic_FM1,	$00, $15
	smpsHeaderFM        Snd_Invic_FM2,	$00, $0A
	smpsHeaderFM        Snd_Invic_FM3,	$00, $1F
	smpsHeaderFM        Snd_Invic_FM4,	$00, $13
	smpsHeaderFM        Snd_Invic_FM5,	$00, $13
	smpsHeaderPSG       Snd_Invic_PSG1,	$00, $05, $00, $00
	smpsHeaderPSG       Snd_Invic_PSG2,	$00, $05, $00, $00
	smpsHeaderPSG       Snd_Invic_PSG3,	$E8, $01, $00, $00

; FM1 Data
Snd_Invic_FM1:
	smpsModSet          $14, $01, $06, $06
	smpsAlterNote       $FE
	smpsPan             panCenter, $00

Snd_Invic_Jump03:
	smpsSetvoice        $00
	dc.b	nRst, $18

Snd_Invic_Jump05:
	dc.b	nA4, $0C, nFs4, $06, nE4, nA4, nFs4, nD4, nE4, smpsNoAttack, nE4, $12
	dc.b	nD5, $0C
	smpsNoteFill        $05
	dc.b	$06, $06, $06
	smpsNoteFill        $00
	dc.b	nCs5, $0C, nA4, $06, nE4, nFs4, $02, nRst, $04, nA4, $0C, nB4
	dc.b	$06, smpsNoAttack, nB4, $24, nRst, $0C
	smpsJump            Snd_Invic_Jump05

; Unreachable
	smpsStop

; FM2 Data
Snd_Invic_FM2:
	dc.b	nRst, $18
	smpsSetvoice        $01

Snd_Invic_Jump04:
	dc.b	nA1, $03, nA1, nRst, nA1, nRst, nA1, nA1, smpsNoAttack, nA1, nFs1, $06
	dc.b	nFs1, smpsNoAttack, nFs1, nE1, nE1, $03, nE1, nRst, nE1, nRst, nE1, nD1
	dc.b	smpsNoAttack, nD1, nRst, nD1, nRst, nD2, smpsNoAttack, nD2, nD1, nD1, nD1, nA1
	dc.b	nA1, nRst, nA1, nRst, nA1, nA1, smpsNoAttack, nA1, nFs1, $06, nFs1, smpsNoAttack
	dc.b	nFs1, nG1, nG1, $03, nG1, nRst, nG1, nRst, nG1, nE1, smpsNoAttack, nE1
	dc.b	nRst, nE1, nRst, nE2, smpsNoAttack, nE2, nE1, nE1, nE1
	smpsJump            Snd_Invic_Jump04

; Unreachable
	smpsStop

; FM3 Data
Snd_Invic_FM3:
	dc.b	nRst, $0B
	smpsAlterNote       $02
	smpsModSet          $14, $01, $05, $06
	smpsPan             panLeft, $00
	smpsJump            Snd_Invic_Jump03

; Unreachable
	smpsStop

; FM4 Data
Snd_Invic_FM4:
	smpsPan             panRight, $00
	smpsSetvoice        $02
	dc.b	nRst, $18

Snd_Invic_Jump02:
	smpsNoteFill        $05
	dc.b	nRst, $0C, nA5, $12, nA5, nRst, $0C, nB5, $12
	smpsNoteFill        $00
	dc.b	nA5
	smpsNoteFill        $05
	dc.b	nRst, $0C, nA5, $12, nA5, nG5, $06
	smpsNoteFill        $00
	dc.b	nG5, $0C, nE5, $18, nRst, $06
	smpsJump            Snd_Invic_Jump02

; Unreachable
	smpsStop

; FM5 Data
Snd_Invic_FM5:
	smpsPan             panLeft, $00
	smpsSetvoice        $02
	dc.b	nRst, $18

Snd_Invic_Jump01:
	smpsNoteFill        $05
	dc.b	nRst, $0C, nE5, $12, nE5, nRst, $0C, nE5, $12
	smpsNoteFill        $00
	dc.b	nD5
	smpsNoteFill        $05
	dc.b	nRst, $0C, nE5, $12, nE5, nD5, $06
	smpsNoteFill        $00
	dc.b	nD5, $0C, nB4, $18, nRst, $06
	smpsJump            Snd_Invic_Jump01

; Unreachable
	smpsStop

; PSG1 Data
Snd_Invic_PSG1:
	dc.b	nRst, $18
	smpsPSGvoice        sTone_0A

Snd_Invic_Jump07:
	dc.b	nE4, $06, nB3, nE4, nB3, nE4, nB3, nE4, nB3, nD4, nB3, nE4
	dc.b	nB3, nE4, nB3, nE4, nB3, nE4, $06, nB3, nE4, nB3, nE4, nB3
	dc.b	nE4, nB3, nD4, nB3, nD4, nB3, nD5, nB4, nD5, nB4, nE4, $06
	dc.b	nB3, nE4, nB3, nE4, nB3, nE4, nB3, nD4, nB3, nE4, nB3, nE4
	dc.b	nB3, nE4, nB3, nE4, $06, nB3, nE4, nB3, nE4, nB3, nE4, nB3
	dc.b	nE3, nG3, nFs3, nA3, nAb3, nB3, nB3, nD4
	smpsJump            Snd_Invic_Jump07

; Unreachable
	smpsStop

; PSG2 Data
Snd_Invic_PSG2:
	dc.b	nRst, $18
	smpsPSGvoice        sTone_0A
	dc.b	nRst, $03

Snd_Invic_Jump06:
	dc.b	nCs4, $06, nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b	nA3, nCs4, nA3, nCs4, nA3, nCs4, $06, nA3, nCs4, nA3, nCs4, nA3
	dc.b	nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs5, nA4, nCs5, nA4, nCs4, $06
	dc.b	nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b	nA3, nCs4, nA3, nCs4, $06, nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3
	dc.b	nFs3, nA3, nG3, nB3, nA3, nCs4, nCs4, nE4
	smpsJump            Snd_Invic_Jump06

; Unreachable
	smpsStop

; PSG3 Data
Snd_Invic_PSG3:
	smpsPSGvoice        sTone_0A
	smpsModSet          $14, $01, $02, $06
	dc.b	nRst, $18
	smpsJump            Snd_Invic_Jump05

; Unreachable
	smpsStop

; DAC Data
Snd_Invic_DAC:
	dc.b	dSnareS3, $06, dSnareS3, dSnareS3, $03, dSnareS3, dSnareS3, dSnareS3

Snd_Invic_Jump00:
	dc.b	dCrashCymbal, $0C, dSnareS3, dKickS3, $06, dKickS3, dSnareS3, nRst, dKickS3, $0C, dSnareS3, $09
	dc.b	$03, dKickS3, $06, dKickS3, dSnareS3, nRst, dKickS3, $0C, dSnareS3, dKickS3, $06, dKickS3
	dc.b	dSnareS3, nRst, dKickS3, $0C, dSnareS3, $09, $03, dKickS3, $06, dKickS3, dSnareS3, $03
	dc.b	nRst, dSnareS3, dSnareS3
	smpsJump            Snd_Invic_Jump00

; Unreachable
	smpsStop

Snd_Invic_Voices:
;	Voice $00
;	$3D
;	$61, $02, $12, $52, 	$1F, $18, $18, $1B, 	$04, $02, $01, $02
;	$00, $00, $00, $00, 	$5F, $4F, $3F, $4F, 	$17, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $05, $01, $00, $06
	smpsVcCoarseFreq    $02, $02, $02, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1B, $18, $18, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $01, $02, $04
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $04, $03, $04, $05
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $17

;	Voice $01
;	$2D
;	$01, $51, $31, $21, 	$1F, $1F, $1F, $1F, 	$0B, $09, $00, $0B
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$0C, $90, $90, $90
	smpsVcAlgorithm     $05
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $02, $03, $05, $00
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0B, $00, $09, $0B
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $10, $10, $10, $0C

;	Voice $02
;	$3D
;	$00, $01, $01, $01, 	$94, $19, $19, $19, 	$0F, $0D, $0D, $0D
;	$07, $04, $04, $04, 	$25, $1A, $1A, $1A, 	$10, $84, $84, $84
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $01, $00
	smpsVcRateScale     $00, $00, $00, $02
	smpsVcAttackRate    $19, $19, $19, $14
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0D, $0D, $0D, $0F
	smpsVcDecayRate2    $04, $04, $04, $07
	smpsVcDecayLevel    $01, $01, $01, $02
	smpsVcReleaseRate   $0A, $0A, $0A, $05
	smpsVcTotalLevel    $04, $04, $04, $10

