Sound_5F_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_5F_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_5F_FM5,	$00, $00

; FM5 Data
Sound_5F_FM5:
	smpsSetvoice        $00
	dc.b	nC0, $25
	smpsStop

Sound_5F_Voices:
;	Voice $00
;	$20
;	$00, $01, $00, $00, 	$1F, $1F, $1F, $1F, 	$00, $0C, $00, $00
;	$00, $00, $00, $0C, 	$FF, $FF, $FF, $0F, 	$04, $0A, $18, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $04
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $01, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $0C, $00
	smpsVcDecayRate2    $0C, $00, $00, $00
	smpsVcDecayLevel    $00, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $18, $0A, $04

