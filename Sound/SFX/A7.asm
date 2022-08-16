Sound_A7_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_A7_AD_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM3, Sound_A7_FM3,	$0B, $10

; FM3 Data
Sound_A7_FM3:
	smpsSetvoice        $00
	dc.b	nB4, $17
	smpsStop

Sound_A7_AD_Voices:
;	Voice $00
;	$07
;	$30, $70, $10, $20, 	$17, $19, $14, $14, 	$00, $00, $00, $00
;	$0C, $0C, $0C, $0C, 	$0F, $0F, $0F, $0F, 	$80, $80, $80, $80
	smpsVcAlgorithm     $07
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $02, $01, $07, $03
	smpsVcCoarseFreq    $00, $00, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $14, $14, $19, $17
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $0C, $0C, $0C, $0C
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $00

