Sound_CC_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_CC_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cFM3, Sound_CC_FM3,	$00, $06
	smpsHeaderSFXChannel cFM4, Sound_CC_FM4,	$00, $06

; FM3 Data
Sound_CC_FM3:
	dc.b	nE0, $03, nC0, $07, nA0, $0A, nEb1, $07

; FM4 Data
Sound_CC_FM4:
	smpsSetvoice        $00
	dc.b	nAb0, $08, nBb0, $08
	smpsContinuousLoop  Sound_CC_FM3
	smpsStop

Sound_CC_Voices:
;	Voice $00
;	$FA
;	$11, $31, $13, $30, 	$0A, $0F, $1F, $1F, 	$05, $18, $09, $02
;	$06, $0F, $06, $02, 	$0F, $07, $4F, $2F, 	$07, $0E, $0E, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $03
	smpsVcDetune        $03, $01, $03, $01
	smpsVcCoarseFreq    $00, $03, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $0F, $0A
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $09, $18, $05
	smpsVcDecayRate2    $02, $06, $0F, $06
	smpsVcDecayLevel    $02, $04, $00, $00
	smpsVcReleaseRate   $0F, $0F, $07, $0F
	smpsVcTotalLevel    $00, $0E, $0E, $07

