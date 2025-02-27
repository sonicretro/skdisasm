Sound_5D_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_5D_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_5D_FM5,	$F3, $00

; FM5 Data
Sound_5D_FM5:
	smpsSetvoice        $00
	dc.b	nCs1, $05, nEb1
	smpsStop

Sound_5D_Voices:
;	Voice $00
;	$20
;	$00, $00, $00, $00, 	$1F, $1F, $1F, $1F, 	$00, $11, $00, $00
;	$00, $00, $00, $09, 	$0F, $FF, $FF, $0F, 	$03, $10, $1A, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $04
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $11, $00
	smpsVcDecayRate2    $09, $00, $00, $00
	smpsVcDecayLevel    $00, $0F, $0F, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1A, $10, $03

