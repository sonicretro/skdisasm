Sound_4A_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_4A_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_4A_FM5,	$05, $00

; FM5 Data
Sound_4A_FM5:
	smpsSetvoice        $00
	dc.b	nE2, $06
	smpsStop

Sound_4A_Voices:
;	Voice $00
;	$3C
;	$00, $01, $01, $00, 	$1F, $12, $1A, $1F, 	$10, $00, $1F, $00
;	$09, $13, $0A, $12, 	$FF, $0F, $FF, $0F, 	$00, $80, $00, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $01, $01, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1A, $12, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $1F, $00, $10
	smpsVcDecayRate2    $12, $0A, $13, $09
	smpsVcDecayLevel    $00, $0F, $00, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $00

