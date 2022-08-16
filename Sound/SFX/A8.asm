Sound_A8_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_A8_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_A8_FM5,	$09, $05

; FM5 Data
Sound_A8_FM5:
	smpsSetvoice        $00
	dc.b	nC5, $02, nC5, $08
	smpsStop

Sound_A8_Voices:
;	Voice $00
;	$0B
;	$53, $55, $07, $0A, 	$1F, $1F, $0F, $0F, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$00, $00, $00, $06, 	$10, $12, $10, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $01
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $05, $05
	smpsVcCoarseFreq    $0A, $07, $05, $03
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0F, $0F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $06, $00, $00, $00
	smpsVcTotalLevel    $00, $10, $12, $10

