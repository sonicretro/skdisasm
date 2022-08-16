Sound_49_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_49_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_49_FM5,	$EC, $00

; FM5 Data
Sound_49_FM5:
	smpsSetvoice        $00
	dc.b	nBb2, $10
	smpsStop

Sound_49_Voices:
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

