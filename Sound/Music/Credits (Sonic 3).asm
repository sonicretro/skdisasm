Snd_S3Credits_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_S3Credits_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $0C

	smpsHeaderDAC       Snd_S3Credits_DAC
	smpsHeaderFM        Snd_S3Credits_FM1,	$00, $06
	smpsHeaderFM        Snd_S3Credits_FM2,	$00, $0A
	smpsHeaderFM        Snd_S3Credits_FM3,	$00, $17
	smpsHeaderFM        Snd_S3Credits_FM4,	$0C, $18
	smpsHeaderFM        Snd_S3Credits_FM5,	$0C, $1B
	smpsHeaderPSG       Snd_S3Credits_PSG1,	$DC, $03, $00, sTone_1B
	smpsHeaderPSG       Snd_S3Credits_PSG2,	$E8, $03, $00, sTone_1B
	smpsHeaderPSG       Snd_S3Credits_PSG3,	$0A, $03, $00, sTone_1B

; FM1 Data
Snd_S3Credits_FM1:
	smpsSetvoice        $00

Snd_S3Credits_Loop06:
	smpsCall            Snd_S3Credits_Call0A
	smpsLoop            $00, $04, Snd_S3Credits_Loop06
	smpsCall            Snd_S3Credits_Call0B

Snd_S3Credits_Jump03:
	dc.b	nRst, $60, nRst

Snd_S3Credits_Loop07:
	smpsSetvoice        $00
	smpsCall            Snd_S3Credits_Call0A
	smpsLoop            $00, $04, Snd_S3Credits_Loop07
	smpsCall            Snd_S3Credits_Call0B
	smpsJump            Snd_S3Credits_Jump03

; Unreachable
	smpsAlterVol        $09
	dc.b	nAb2, $60, nAb2
	smpsAlterVol        $F7
	smpsSetvoice        $00

Snd_S3Credits_Jump05:
	smpsCall            Snd_S3Credits_Call0A
	smpsJump            Snd_S3Credits_Jump05

Snd_S3Credits_Call0A:
	dc.b	nEb2, $06, nRst, $24, nEb2, $06, nEb2, nRst, $2A, nCs2, $06, nRst
	dc.b	$18, nCs2, $06, nRst, $18, nCs2, $06, nRst, $1E, nFs2, $06, nRst
	dc.b	$24, nFs2, $06, nFs2, nRst, $2A, nAb2, $06, nRst, $18, nAb2, $06
	dc.b	nRst, $18, nAb2, $06, nRst, $1E
	smpsReturn

Snd_S3Credits_Call0B:
	smpsModSet          $18, $02, $0A, $02
	smpsSetvoice        $02
	smpsFMAlterVol      $0A
	dc.b	nAb2, $60, nFs2, nF2, nFs2, nAb2, $5A, nFs2, $06, smpsNoAttack, $60, nF2
	dc.b	$60, nE2, $5A, nA2, $06, smpsNoAttack, $60, nD2, $60, nG2
	smpsFMAlterVol      $F6
	smpsReturn

; FM2 Data
Snd_S3Credits_FM2:
	smpsSetvoice        $01
	smpsNoteFill        $03

Snd_S3Credits_Jump02:
	smpsPan             panLeft, $00

Snd_S3Credits_Loop05:
	smpsCall            Snd_S3Credits_Call06
	smpsLoop            $00, $02, Snd_S3Credits_Loop05
	smpsCall            Snd_S3Credits_Call07
	smpsCall            Snd_S3Credits_Call08
	smpsCall            Snd_S3Credits_Call07
	smpsCall            Snd_S3Credits_Call07
	smpsCall            Snd_S3Credits_Call08
	dc.b	nE2, nEb4, nAb3, nE3, nEb4, nAb3, nE3, nEb4, nE3, nEb4, nAb3, nE3
	dc.b	nEb4, nE3, nAb3, nA2, nCs4, nAb3, nA2, nCs4, nA2, nCs4, nAb3, nA2
	dc.b	nCs4, nA2, nAb3, nA2, nCs4, nAb3, nA2, nCs4, nD2, nCs4, nFs3, nD2
	dc.b	nCs4, nD2, nFs3, nD2, nCs4, nFs3, nD2, nCs4, nD2, nCs4, nFs3, nG2
	dc.b	nB3, nFs3, nG2, nB3, nFs3, nG2, nB3, nFs3, nG2, nB3, nFs3, nG2
	dc.b	nB3, nG2, nFs3, nB3
	smpsPan             panCenter, $00
	smpsFMAlterVol      $04
	smpsCall            Snd_S3Credits_Call09
	dc.b	nEb4
	smpsFMAlterVol      $FF
	smpsJump            Snd_S3Credits_Jump02

; Unreachable
Snd_S3Credits_Jump06:
	smpsCall            Snd_S3Credits_Call06
	smpsJump            Snd_S3Credits_Jump06

Snd_S3Credits_Call09:
	dc.b	nBb2, $06, nEb4, nAb3, nBb2, nEb4, nAb3, nBb2, nEb4
	smpsFMAlterVol      $FF
	dc.b	nBb2, nEb4, nAb3, nBb2, nEb4, nBb2, nBb3, nBb2
	smpsFMAlterVol      $FF
	dc.b	nEb4, nAb3, nBb2, nEb4, nBb2, nEb4, nAb3, nBb2
	smpsFMAlterVol      $FF
	dc.b	nEb4, nBb2, nAb3, nBb2, nEb4, nBb2, nAb3
	smpsReturn

Snd_S3Credits_Call07:
	dc.b	nAb2, $06, nBb3, nAb3, nAb3, nC4, nAb3, nAb3, nCs4, nAb3, nAb3, nEb4
	dc.b	nAb3, nAb3, nAb2, nCs4, nAb3
	smpsReturn

Snd_S3Credits_Call08:
	dc.b	nFs2, nBb3, nAb3, nFs3, nC4, nAb3, nFs3, nCs4, nAb3, nFs3, nEb4, nFs3
	dc.b	nAb3, nFs3, nCs4, nAb3, nF2, nBb3, nAb3, nF3, nC4, nAb3, nF3, nCs4
	dc.b	nAb3, nF3, nEb4, nF3, nAb3, nF3, nCs4, nAb3
	smpsReturn

Snd_S3Credits_Call06:
	dc.b	nEb2, $06, nBb3, nG3, nEb3, nEb4, nG3, nEb3, nBb3, nG3, nEb3, nEb4
	dc.b	nEb3, nG3, nEb3, nBb3, nG3, nCs2, nEb4, nCs3, nEb4, nF3, nCs3, nCs4
	dc.b	nCs3, nF3, nCs3, nAb3, nCs3, nF3, nCs3, nAb3, nF3, nFs2, nAb3, nCs3
	dc.b	nAb3, nFs3, nCs3, nBb3, nCs3, nFs3, nCs3, nCs4, nCs3, nFs3, nCs3, nBb3
	dc.b	nFs3, nAb2, nC4, nEb3, nC4, nAb3, nEb3, nCs4, nEb3, nAb3, nEb3, nEb4
	dc.b	nEb3, nAb3, nEb3, nCs4, nAb3, nEb2, nBb3, nG3, nEb3, nEb4, nG3, nBb2
	dc.b	nBb3, nG3, nEb3, nEb4, nBb2, nG3, nEb3, nBb3, nG3, nCs2, nEb4, nF3
	dc.b	nCs3, nCs4, nF3, nAb2, nAb3, nF3, nCs3, nCs4, nAb2, nF3, nCs3, nAb3
	dc.b	nF3, nAb1, nAb3, nFs3, nFs2, nBb3, nFs3, nBb1, nCs4, nFs3, nCs3, nBb3
	dc.b	nFs3, nFs3, nFs3, nAb3, nFs3, nAb1, nBb3, nAb3, nAb2, nC4, nAb3, nC3
	dc.b	nCs4, nAb3, nEb3, nEb4, nEb3, nAb3, nEb3, nCs4, nAb3
	smpsReturn

; FM3 Data
Snd_S3Credits_FM3:
	smpsSetvoice        $02
	smpsModSet          $48, $01, $06, $02
	smpsCall            Snd_S3Credits_Call03
	dc.b	nBb3, $24, nEb4, nBb4, $18, nAb4, $60, smpsNoAttack, $60, smpsNoAttack, $60
	smpsCall            Snd_S3Credits_Call03
	dc.b	$60, nF4, nFs4, $30, nAb4, nAb4, $60
	smpsCall            Snd_S3Credits_Call04

Snd_S3Credits_Jump01:
	dc.b	nRst, $60, nRst
	smpsCall            Snd_S3Credits_Call02
	smpsCall            Snd_S3Credits_Call05
	smpsCall            Snd_S3Credits_Call03
	dc.b	nBb3, $24, nEb4, nBb4, $18, nAb4, $60, smpsNoAttack, $60, smpsNoAttack, $60
	smpsCall            Snd_S3Credits_Call04
	smpsJump            Snd_S3Credits_Jump01

; Unreachable
	dc.b	nEb5, $60, smpsNoAttack, $60
Snd_S3Credits_Jump07:
	smpsCall            Snd_S3Credits_Call02
	smpsCall            Snd_S3Credits_Call05
	smpsJump            Snd_S3Credits_Jump07

Snd_S3Credits_Call03:
	dc.b	nRst, $30, nEb4, $60, nCs4, nEb4, $30, nC4, $24, nCs4, nEb4, $18
	smpsReturn

Snd_S3Credits_Call02:
	dc.b	nEb4, $24, nF4, nG4, $18, nBb4, $24, nAb4, nF4, $18, nFs4, $24
	dc.b	nBb4, $24, nCs5, $18, nC5, $24, nAb4, nEb4, $3C, nG4, $24, nBb4
	dc.b	$18, nAb4, $24, nF4, nCs4, $18
	smpsReturn

Snd_S3Credits_Call05:
	dc.b	nBb4, $24, nCs5, nFs5, $18, nEb5, $24, nC5, nAb4, $18
	smpsReturn

Snd_S3Credits_Call04:
	dc.b	nC5, $24, nCs5, nC5, $18, smpsNoAttack
	smpsLoop            $00, $03, Snd_S3Credits_Call04
	dc.b	nC5, $24, nBb4, nAb4, $18

Snd_S3Credits_Loop0A:
	dc.b	smpsNoAttack, nC5, $24, nCs5, nC5, $18
	smpsLoop            $00, $02, Snd_S3Credits_Loop0A
	dc.b	nEb5, $60, nAb5, smpsNoAttack, $60, nFs5, smpsNoAttack, $60
	smpsReturn

; FM4 Data
Snd_S3Credits_FM4:
	smpsPan             panRight, $00
	smpsSetvoice        $02
	smpsCall            Snd_S3Credits_Call00
	dc.b	nG3, nF3, nFs3, nAb3, nG3, nAb3, nBb3, nC4
	smpsCall            Snd_S3Credits_Call01

Snd_S3Credits_Jump00:
	dc.b	nRst, $02, nRst, $60, nRst
	smpsAlterPitch      $F4
	smpsCall            Snd_S3Credits_Call02
	smpsAlterPitch      $0C
	dc.b	nFs3, $24, nBb3, nCs4, $18, nC4, $24, nAb3, nEb3, $18
	smpsCall            Snd_S3Credits_Call00
	smpsCall            Snd_S3Credits_Call01
	smpsJump            Snd_S3Credits_Jump00

; Unreachable
	dc.b	nBb3, $60, nC4

Snd_S3Credits_Jump08:
	smpsAlterPitch      $F4
	smpsCall            Snd_S3Credits_Call02
	smpsAlterPitch      $0C
	;smpsJump            Snd_BPZ_Jump05;$ABFD
	smpsAlterVol        $FD
	dc.b	nFs3, $24, nBb3, nCs4, $18, nC4, $24, nAb3, $A8, $18
	smpsAlterVol        $03
	smpsJump            Snd_S3Credits_Jump08

Snd_S3Credits_Call00:
	dc.b	nG3, $60, nF3, nFs3, nAb3, nEb3, nCs3, nFs3, nC3
	smpsReturn

Snd_S3Credits_Call01:
	dc.b	nEb4, $24, nF4, nEb4, $18, smpsNoAttack
	smpsLoop            $00, $03, Snd_S3Credits_Call01
	dc.b	nEb4, $24, nCs4, $3C

Snd_S3Credits_Loop09:
	dc.b	nEb4, $24, nF4, nEb4, $18, smpsNoAttack
	smpsLoop            $00, $02, Snd_S3Credits_Loop09
	dc.b	nAb4, $60, smpsNoAttack, $60, nCs5, smpsNoAttack, $60, nB4, $60
	smpsReturn

; FM5 Data
Snd_S3Credits_FM5:
	smpsPan             panCenter, $00
	dc.b	nRst, $04
	smpsAlterNote       $03
	smpsJump            Snd_S3Credits_FM3

; Unreachable
	smpsStop

; PSG1 Data
Snd_S3Credits_PSG1:
	smpsCall            Snd_S3Credits_Call0C
	smpsLoop            $00, $02, Snd_S3Credits_PSG1

Snd_S3Credits_Loop08:
	dc.b	nRst, $60
	smpsLoop            $00, $0D, Snd_S3Credits_Loop08
	smpsJump            Snd_S3Credits_PSG1

; Unreachable
Snd_S3Credits_Jump09:
	smpsCall            Snd_S3Credits_Call0C
	smpsJump            Snd_S3Credits_Jump09
	
Snd_S3Credits_Call0C:
	dc.b	nEb4, $0C, nBb4, nEb4, $06, nEb4, nBb4, nEb4, nRst, $24, nCs4, $0C
	dc.b	nAb4, $06, nCs4, nCs4, $0C, nAb4, $06, nCs4, nCs4, nAb4, nRst, $30
	dc.b	nFs4, $06, nFs4, nCs5, nFs4, nFs4, nFs4, nCs5, nFs4, nRst, $24, nAb4
	dc.b	$06, nAb4, nEb5, $0C, nAb4, $06, nAb4, nEb5, nAb4, nAb4, nAb5, nAb4
	dc.b	nAb5, nAb4, nAb4, nEb5, nAb4, nAb4, nEb4, nBb4, nEb4, $0C, nEb5, $06
	dc.b	nEb4, nEb5, nEb4, nEb4, nBb4, nRst, $1E, nEb4, $0C, nAb4, $06, nCs4
	dc.b	$0C, nCs5, $06, nCs4, nCs5, nCs4, nCs4, nAb4, $0C, nCs4, $06, nCs4
	dc.b	nAb4, nCs4, nCs4, nCs4, nFs4, nFs4, nCs5, nFs4, nFs4, nFs4, nCs5, nFs4
	dc.b	nRst, $24, nAb4, $06, nAb4, nEb5, $12, nAb4, $06, nAb5, nAb4, nAb4
	dc.b	nEb5, nAb4, nAb5, nAb4, nRst, $1E
	smpsReturn

; PSG2 Data
Snd_S3Credits_PSG2:
	dc.b	nRst, $01
	smpsJump            Snd_S3Credits_PSG1

; PSG3 Data
Snd_S3Credits_PSG3:
	smpsPSGform         $E7
	dc.b	nRst, $60, nRst, nRst, nRst
	smpsNoteFill        $03

Snd_S3Credits_Jump04:
	dc.b	nRst, $0C, (nMaxPSG2-$A)&$FF, $06, (nMaxPSG2-$A)&$FF
	smpsJump            Snd_S3Credits_Jump04

; DAC Data
Snd_S3Credits_DAC:
	dc.b	nRst, $60, nRst, $48, dMetalCrashHit, $18, dKickHey, $60, dKickHey, $2A, nRst, $12
	dc.b	dKickHey, dKickHey

Snd_S3Credits_Loop00:
	dc.b	dKickHey, $18, dOddSnareKick, dKickExtraBass, dOddSnareKick
	smpsLoop            $00, $03, Snd_S3Credits_Loop00
	dc.b	dKickHey, $18, dOddSnareKick, $12, nRst, $12, dKickHey, dKickHey
	smpsLoop            $01, $05, Snd_S3Credits_Loop00

Snd_S3Credits_Loop01:
	dc.b	dKickHey, $18, dOddSnareKick, dKickExtraBass, dOddSnareKick
	smpsLoop            $00, $04, Snd_S3Credits_Loop01
	dc.b	dKickHey, $18, dOddSnareKick, $12, nRst, $12, dKickHey, dKickHey

Snd_S3Credits_Loop02:
	dc.b	dKickHey, $18, dOddSnareKick, dKickExtraBass, dOddSnareKick
	smpsLoop            $00, $03, Snd_S3Credits_Loop02
	dc.b	dKickHey, $18, dOddSnareKick, $12, nRst, $12, dKickHey, dKickHey

Snd_S3Credits_Loop03:
	dc.b	dKickHey, $18, dOddSnareKick, dKickExtraBass, dOddSnareKick
	smpsLoop            $00, $03, Snd_S3Credits_Loop03
	dc.b	dKickHey, $18, dOddSnareKick, $12, nRst, $12, dKickHey, dKickHey
	smpsLoop            $01, $05, Snd_S3Credits_Loop03

Snd_S3Credits_Loop04:
	dc.b	dKickHey, $18, dOddSnareKick, dKickExtraBass, dOddSnareKick
	smpsLoop            $00, $04, Snd_S3Credits_Loop04
	dc.b	dKickHey, $18, dOddSnareKick, $12, nRst, $12, dKickHey, dKickHey
	smpsJump            Snd_S3Credits_Loop02

; Unreachable
Snd_S3Credits_Jump0A:
	dc.b	nEb5, $18, nBb2, nB2, nBb2
	smpsLoop            $00, $03, Snd_S3Credits_Jump0A
	dc.b	nEb5, $18, nBb2, $12, nRst, $12, nEb5, nEb5
	smpsJump            Snd_S3Credits_Jump0A

Snd_S3Credits_Voices:
;	Voice $00
;	$12
;	$37, $31, $30, $30, 	$9E, $DC, $1C, $9C, 	$0D, $06, $04, $01
;	$08, $0A, $03, $05, 	$B6, $B6, $36, $26, 	$2C, $33, $14, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $02
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $03, $03
	smpsVcCoarseFreq    $00, $00, $01, $07
	smpsVcRateScale     $02, $00, $03, $02
	smpsVcAttackRate    $1C, $1C, $1C, $1E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $04, $06, $0D
	smpsVcDecayRate2    $05, $03, $0A, $08
	smpsVcDecayLevel    $02, $03, $0B, $0B
	smpsVcReleaseRate   $06, $06, $06, $06
	smpsVcTotalLevel    $00, $14, $33, $2C

;	Voice $01
;	$1C
;	$3B, $01, $31, $31, 	$1F, $1B, $1E, $1E, 	$0F, $07, $06, $07
;	$00, $0A, $00, $00, 	$8A, $8A, $8A, $8A, 	$26, $8C, $18, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $03
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $00, $03
	smpsVcCoarseFreq    $01, $01, $01, $0B
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1E, $1E, $1B, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $07, $06, $07, $0F
	smpsVcDecayRate2    $00, $00, $0A, $00
	smpsVcDecayLevel    $08, $08, $08, $08
	smpsVcReleaseRate   $0A, $0A, $0A, $0A
	smpsVcTotalLevel    $00, $18, $0C, $26

;	Voice $02
;	$3A
;	$63, $60, $50, $32, 	$4F, $4F, $4F, $48, 	$04, $04, $04, $05
;	$03, $01, $01, $01, 	$18, $18, $15, $17, 	$1E, $1F, $1D, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $05, $06, $06
	smpsVcCoarseFreq    $02, $00, $00, $03
	smpsVcRateScale     $01, $01, $01, $01
	smpsVcAttackRate    $08, $0F, $0F, $0F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $04, $04, $04
	smpsVcDecayRate2    $01, $01, $01, $03
	smpsVcDecayLevel    $01, $01, $01, $01
	smpsVcReleaseRate   $07, $05, $08, $08
	smpsVcTotalLevel    $00, $1D, $1F, $1E

