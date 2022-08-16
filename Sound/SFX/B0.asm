Sound_B0_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_B0_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $03

	smpsHeaderSFXChannel cFM3, Sound_B0_FM3,	$F5, $08
	smpsHeaderSFXChannel cFM4, Sound_B0_FM4,	$00, $00
	smpsHeaderSFXChannel cFM5, Sound_B0_FM5,	$00, $00

; FM5 Data
Sound_B0_FM5:
	smpsSetvoice        $00
	dc.b	nA0, $08, nRst, $02, nA0, $08
	smpsStop

; FM4 Data
Sound_B0_FM4:
	smpsSetvoice        $01
	dc.b	nRst, $12, nA5, $55
	smpsStop

; FM3 Data
Sound_B0_FM3:
	smpsSetvoice        $02
	dc.b	nRst, $02, nF5, $05, $04, $05, $04
	smpsStop

Sound_B0_Voices:
;	Voice $00
;	$3B
;	$03, $02, $03, $06, 	$18, $1A, $1A, $96, 	$17, $0E, $0A, $10
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$00, $28, $39, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $06, $03, $02, $03
	smpsVcRateScale     $02, $00, $00, $00
	smpsVcAttackRate    $16, $1A, $1A, $18
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $10, $0A, $0E, $17
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $39, $28, $00

;	Voice $01
;	$04
;	$37, $72, $77, $49, 	$1F, $1F, $1F, $1F, 	$07, $0A, $07, $0D
;	$00, $0B, $00, $0B, 	$1F, $0F, $1F, $0F, 	$23, $80, $23, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $07, $07, $03
	smpsVcCoarseFreq    $09, $07, $02, $07
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0D, $07, $0A, $07
	smpsVcDecayRate2    $0B, $00, $0B, $00
	smpsVcDecayLevel    $00, $01, $00, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $23, $00, $23

;	Voice $02
;	$3C
;	$0F, $00, $00, $00, 	$1F, $1A, $18, $1C, 	$17, $11, $1A, $0E
;	$00, $0F, $14, $10, 	$1F, $9F, $9F, $2F, 	$07, $80, $26, $8C
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $00, $0F
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1C, $18, $1A, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0E, $1A, $11, $17
	smpsVcDecayRate2    $10, $14, $0F, $00
	smpsVcDecayLevel    $02, $09, $09, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0C, $26, $00, $07

