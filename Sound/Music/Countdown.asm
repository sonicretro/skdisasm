Snd_Drown_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_Drown_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $7F

	smpsHeaderDAC       Snd_Drown_DAC
	smpsHeaderFM        Snd_Drown_FM1,	$0C, $08
	smpsHeaderFM        Snd_Drown_FM2,	$E8, $0E
	smpsHeaderFM        Snd_Drown_FM3,	$F4, $40
	smpsHeaderFM        Snd_Drown_FM4,	$06, $11
	smpsHeaderFM        Snd_Drown_FM5,	$0C, $19
	smpsHeaderPSG       Snd_Drown_PSG1,	$0C, $19, $00, $00
	smpsHeaderPSG       Snd_Drown_PSG2,	$0C, $19, $00, $00
	smpsHeaderPSG       Snd_Drown_PSG3,	$0C, $19, $00, $00

; FM1 Data
Snd_Drown_FM1:
	smpsSetvoice        $00
	smpsFade            $01
	smpsNoteFill        $03
	smpsCall            Snd_Drown_Call01
	smpsSetTempoMod     $40
	smpsCall            Snd_Drown_Call01
	smpsSetTempoMod     $20
	smpsCall            Snd_Drown_Call01
	smpsSetTempoMod     $10
	smpsCall            Snd_Drown_Call01
	smpsSetTempoMod     $08
	smpsCall            Snd_Drown_Call01
	dc.b	nC5, $0C
	smpsFade            $01
	smpsStop

; FM2 Data
Snd_Drown_FM2:
	smpsSetvoice        $01

Snd_Drown_Loop03:
	smpsFMAlterVol      $FF
	smpsCall            Snd_Drown_Call00
	smpsLoop            $00, $0A, Snd_Drown_Loop03
	dc.b	nC5, $06
	smpsStop

; FM3 Data
Snd_Drown_FM3:
	smpsSetvoice        $02

Snd_Drown_Loop02:
	smpsFMAlterVol      $FE
	dc.b	smpsNoAttack, nC6, $02, smpsNoAttack, nCs6, smpsNoAttack, nC6, smpsNoAttack, nCs6, smpsNoAttack, nC6, smpsNoAttack
	dc.b	nCs6, smpsNoAttack, nC6, smpsNoAttack, nCs6
	smpsLoop            $00, $1E, Snd_Drown_Loop02
	dc.b	nC6, $0C
	smpsStop

; FM4 Data
Snd_Drown_FM4:
	smpsSetvoice        $03
	smpsNoteFill        $03
	dc.b	nRst, $03

Snd_Drown_Loop01:
	smpsPan             panRight, $00
	dc.b	nC4, $06, nC5
	smpsPan             panCenter, $00
	dc.b	nC4, nC5
	smpsPan             panLeft, $00
	dc.b	nCs4, nCs5
	smpsPan             panCenter, $00
	dc.b	nCs4, nCs5
	smpsLoop            $00, $0A, Snd_Drown_Loop01
	smpsStop

; FM5 Data
Snd_Drown_FM5:
	smpsSetvoice        $00
	smpsNoteFill        $03
	dc.b	nRst, $04

Snd_Drown_Loop00:
	smpsPan             panLeft, $00
	dc.b	nC4, $06, nC5
	smpsPan             panLeft, $00
	dc.b	nC4, nC5
	smpsPan             panRight, $00
	dc.b	nCs4, nCs5
	smpsPan             panRight, $00
	dc.b	nCs4, nCs5
	smpsLoop            $00, $0A, Snd_Drown_Loop00
	smpsStop

; DAC Data
Snd_Drown_DAC:
	dc.b	dSnareS3, $0C, dSnareS3, dSnareS3, dSnareS3
	smpsLoop            $00, $0A, Snd_Drown_DAC
	dc.b	dSnareS3, $06

; PSG1 Data
Snd_Drown_PSG1:
; PSG2 Data
Snd_Drown_PSG2:
; PSG3 Data
Snd_Drown_PSG3:
	smpsStop

Snd_Drown_Call01:
	dc.b	nC4, $06, nC5, nC4, nC5, nCs4, nCs5, nCs4, nCs5

Snd_Drown_Call00:
	dc.b	nC4, $06, nC5, nC4, nC5, nCs4, nCs5, nCs4, nCs5
	smpsReturn

Snd_Drown_Voices:
;	Voice $00
;	$3C
;	$31, $52, $50, $30, 	$52, $53, $52, $53, 	$08, $00, $08, $00
;	$04, $00, $04, $00, 	$1F, $0F, $1F, $0F, 	$1A, $80, $16, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $05, $05, $03
	smpsVcCoarseFreq    $00, $00, $02, $01
	smpsVcRateScale     $01, $01, $01, $01
	smpsVcAttackRate    $13, $12, $13, $12
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $08, $00, $08
	smpsVcDecayRate2    $00, $04, $00, $04
	smpsVcDecayLevel    $00, $01, $00, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $16, $00, $1A

;	Voice $01
;	$18
;	$37, $30, $30, $31, 	$9E, $DC, $1C, $9C, 	$0D, $06, $04, $01
;	$08, $0A, $03, $05, 	$BF, $BF, $3F, $2F, 	$2C, $22, $14, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $03
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $03, $03
	smpsVcCoarseFreq    $01, $00, $00, $07
	smpsVcRateScale     $02, $00, $03, $02
	smpsVcAttackRate    $1C, $1C, $1C, $1E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $04, $06, $0D
	smpsVcDecayRate2    $05, $03, $0A, $08
	smpsVcDecayLevel    $02, $03, $0B, $0B
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $14, $22, $2C

;	Voice $02
;	$2C
;	$52, $58, $34, $34, 	$1F, $12, $1F, $12, 	$00, $0A, $00, $0A
;	$00, $00, $00, $00, 	$0F, $1F, $0F, $1F, 	$15, $82, $14, $82
	smpsVcAlgorithm     $04
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $05, $05
	smpsVcCoarseFreq    $04, $04, $08, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $12, $1F, $12, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $00, $0A, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $01, $00, $01, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $02, $14, $02, $15

;	Voice $03
;	$07
;	$34, $31, $54, $51, 	$14, $14, $14, $14, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$91, $91, $91, $91
	smpsVcAlgorithm     $07
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $05, $05, $03, $03
	smpsVcCoarseFreq    $01, $04, $01, $04
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $14, $14, $14, $14
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $11, $11, $11, $11

