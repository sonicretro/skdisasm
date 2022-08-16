Snd_S3_Invic_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_S3_Invic_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $2C

	smpsHeaderDAC       Snd_S3_Invic_DAC
	smpsHeaderFM        Snd_S3_Invic_FM1,	$18, $12
	smpsHeaderFM        Snd_S3_Invic_FM2,	$00, $09
	smpsHeaderFM        Snd_S3_Invic_FM3,	$18, $1C
	smpsHeaderFM        Snd_S3_Invic_FM4,	$00, $1C
	smpsHeaderFM        Snd_S3_Invic_FM5,	$00, $1C
	smpsHeaderPSG       Snd_S3_Invic_PSG1,	$F4, $06, $00, $00
	smpsHeaderPSG       Snd_S3_Invic_PSG2,	$F4, $06, $00, $00
	smpsHeaderPSG       Snd_S3_Invic_PSG3,	$3B, $02, $00, $00

; FM1 Data
Snd_S3_Invic_FM1:
	smpsSetvoice        $00
	smpsModSet          $14, $01, $06, $06
	dc.b	nB3, $04, nRst, nB3, $08, nC4, $04, nRst, nC4, $08, nD4, $08
	dc.b	nRst, nD4, $04, nRst, nBb3, $04, smpsNoAttack, nB3, $08, nRst, $04, nB3
	dc.b	$08, nC4, $04, nRst, nD4, $0C, nRst, $04, nD4, nRst, nD4, $0C
	dc.b	nRst, $04, nF4, $0C, nRst, $04, nF4, $0C, nRst, $04, nF4, $0C
	dc.b	nRst, $04, nF4, $0C, nRst, $04
	smpsFMAlterVol      $FE

Snd_S3_Invic_Loop0F:
	dc.b	nF4, $03, nRst, $05
	smpsLoop            $00, $08, Snd_S3_Invic_Loop0F
	smpsFMAlterVol      $02
	dc.b	nB3, $04, nRst, nB3, $08, nC4, $04, nRst, nC4, $08, nD4, $08
	dc.b	nRst, nD4, $04, nRst, nBb3, $04, smpsNoAttack, nB3, $08, nRst, $04, nB3
	dc.b	$08, nC4, $04, nRst, nD4, $0C, nRst, $04, nD4, nRst, nD4, $0C
	dc.b	nRst, $04, nF4, $0C, nRst, $04, nF4, $0C, nRst, $04, nF4, $0C
	dc.b	nRst, $04, nF4, $0C, nRst, $04
	smpsFMAlterVol      $FE

Snd_S3_Invic_Loop10:
	dc.b	nA4, $03, nRst, $05
	smpsLoop            $00, $08, Snd_S3_Invic_Loop10
	smpsFMAlterVol      $02
	smpsJump            Snd_S3_Invic_FM1

; Unreachable
	smpsStop

; FM2 Data
Snd_S3_Invic_FM2:
	smpsSetvoice        $01
	dc.b	nG2, $04, nRst, nG2, nRst, nG2, nRst, nG2, nRst, nD2, $0C, nRst
	dc.b	$04, nD2, nRst, nG2, $08, nRst, $08, nG2, $04, nRst, nG2, nRst
	dc.b	nD2, $08, nRst, nD2, $04, nRst, nD2, $0C, nRst, $04

Snd_S3_Invic_Loop0C:
	dc.b	nF2, $03, nRst, $05
	smpsLoop            $00, $10, Snd_S3_Invic_Loop0C
	dc.b	nG2, $04, nRst, nG2, nRst, nG2, nRst, nG2, nRst, nD2, $0C, nRst
	dc.b	$04, nD2, nRst, nG2, $08, nRst, $08, nG2, $04, nRst, nG2, nRst
	dc.b	nD2, $08, nRst, nD2, $04, nRst, nD2, $0C, nRst, $04

Snd_S3_Invic_Loop0D:
	dc.b	nF2, $03, nRst, $05
	smpsLoop            $00, $08, Snd_S3_Invic_Loop0D

Snd_S3_Invic_Loop0E:
	dc.b	nA2, $03, nRst, $05
	smpsLoop            $00, $08, Snd_S3_Invic_Loop0E
	smpsJump            Snd_S3_Invic_FM2

; Unreachable
	smpsStop

; FM3 Data
Snd_S3_Invic_FM3:
	smpsSetvoice        $00
	smpsModSet          $15, $01, $06, $06
	dc.b	nRst, $03
	smpsAlterNote       $03

Snd_S3_Invic_Jump00:
	dc.b	nG3, $04, nRst, nG3, $08, nA3, $04, nRst, nA3, $08, nB3, $08
	dc.b	nRst, nB3, $04, nRst, nFs3, $04, smpsNoAttack, nG3, $08, nRst, $04, nG3
	dc.b	$08, nA3, $04, nRst, nB3, $0C, nRst, $04, nB3, nRst, nB3, $0C
	dc.b	nRst, $04, nC4, $0C, nRst, $04, nC4, $0C, nRst, $04, nC4, $0C
	dc.b	nRst, $04, nC4, $0C, nRst, $04
	smpsFMAlterVol      $FE

Snd_S3_Invic_Loop0A:
	dc.b	nC4, $03, nRst, $05
	smpsLoop            $00, $08, Snd_S3_Invic_Loop0A
	smpsFMAlterVol      $02
	dc.b	nG3, $04, nRst, nG3, $08, nA3, $04, nRst, nA3, $08, nB3, $08
	dc.b	nRst, nB3, $04, nRst, nFs3, $04, smpsNoAttack, nG3, $08, nRst, $04, nG3
	dc.b	$08, nA3, $04, nRst, nB3, $0C, nRst, $04, nB3, nRst, nB3, $0C
	dc.b	nRst, $04, nC4, $0C, nRst, $04, nC4, $0C, nRst, $04, nC4, $0C
	dc.b	nRst, $04, nC4, $0C, nRst, $04
	smpsFMAlterVol      $FE

Snd_S3_Invic_Loop0B:
	dc.b	nA4, $03, nRst, $05
	smpsLoop            $00, $08, Snd_S3_Invic_Loop0B
	smpsFMAlterVol      $02
	smpsJump            Snd_S3_Invic_Jump00

; Unreachable
	smpsStop

; FM4 Data
Snd_S3_Invic_FM4:
	smpsSetvoice        $02
	smpsPan             panRight, $00

Snd_S3_Invic_Loop05:
	dc.b	nG5, $04, nD5
	smpsLoop            $00, $10, Snd_S3_Invic_Loop05

Snd_S3_Invic_Loop06:
	dc.b	nA5, $04, nF5
	smpsLoop            $00, $10, Snd_S3_Invic_Loop06

Snd_S3_Invic_Loop07:
	dc.b	nG5, $04, nD5
	smpsLoop            $00, $10, Snd_S3_Invic_Loop07

Snd_S3_Invic_Loop08:
	dc.b	nA5, $04, nF5
	smpsLoop            $00, $08, Snd_S3_Invic_Loop08

Snd_S3_Invic_Loop09:
	dc.b	nC6, $04, nF5
	smpsLoop            $00, $08, Snd_S3_Invic_Loop09
	smpsJump            Snd_S3_Invic_Loop05

; Unreachable
	smpsStop

; FM5 Data
Snd_S3_Invic_FM5:
	smpsSetvoice        $02
	smpsPan             panLeft, $00

Snd_S3_Invic_Loop00:
	dc.b	nB4, $04, nG4
	smpsLoop            $00, $10, Snd_S3_Invic_Loop00

Snd_S3_Invic_Loop01:
	dc.b	nC5, $04, nA4
	smpsLoop            $00, $10, Snd_S3_Invic_Loop01

Snd_S3_Invic_Loop02:
	dc.b	nB4, $04, nG4
	smpsLoop            $00, $10, Snd_S3_Invic_Loop02

Snd_S3_Invic_Loop03:
	dc.b	nC5, $04, nA4
	smpsLoop            $00, $08, Snd_S3_Invic_Loop03

Snd_S3_Invic_Loop04:
	dc.b	nF5, $04, nA4
	smpsLoop            $00, $08, Snd_S3_Invic_Loop04
	smpsJump            Snd_S3_Invic_Loop00

; Unreachable
	smpsStop

; DAC Data
Snd_S3_Invic_DAC:
	dc.b	dKickS3, $10, dKickS3, dKickS3, dKickS3
	smpsJump            Snd_S3_Invic_DAC

; Unreachable
	smpsStop

; PSG1 Data
Snd_S3_Invic_PSG1:
	smpsPSGvoice        sTone_0A
	dc.b	nRst, $02
	smpsJump            Snd_S3_Invic_Loop05

; Unreachable
	smpsStop

; PSG2 Data
Snd_S3_Invic_PSG2:
	smpsPSGvoice        sTone_0A
	dc.b	nRst, $02
	smpsJump            Snd_S3_Invic_Loop00

; Unreachable
	smpsStop

; PSG3 Data
Snd_S3_Invic_PSG3:
	smpsStop

Snd_S3_Invic_Voices:
;	Voice $00
;	$3D
;	$01, $00, $04, $03, 	$1F, $1F, $1F, $1F, 	$10, $06, $06, $06
;	$01, $06, $06, $06, 	$35, $1A, $18, $1A, 	$12, $82, $82, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $03, $04, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $06, $06, $10
	smpsVcDecayRate2    $06, $06, $06, $01
	smpsVcDecayLevel    $01, $01, $01, $03
	smpsVcReleaseRate   $0A, $08, $0A, $05
	smpsVcTotalLevel    $00, $02, $02, $12

;	Voice $01
;	$3A
;	$01, $02, $01, $01, 	$1F, $5F, $5F, $5F, 	$10, $11, $09, $09
;	$07, $00, $00, $00, 	$CF, $FF, $FF, $FF, 	$1C, $22, $18, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $02, $01
	smpsVcRateScale     $01, $01, $01, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $09, $09, $11, $10
	smpsVcDecayRate2    $00, $00, $00, $07
	smpsVcDecayLevel    $0F, $0F, $0F, $0C
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $18, $22, $1C

;	Voice $02
;	$3D
;	$01, $01, $01, $01, 	$94, $19, $19, $19, 	$0F, $0D, $0D, $0D
;	$07, $04, $04, $04, 	$25, $1A, $1A, $1A, 	$15, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $02
	smpsVcAttackRate    $19, $19, $19, $14
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0D, $0D, $0D, $0F
	smpsVcDecayRate2    $04, $04, $04, $07
	smpsVcDecayLevel    $01, $01, $01, $02
	smpsVcReleaseRate   $0A, $0A, $0A, $05
	smpsVcTotalLevel    $00, $00, $00, $15

