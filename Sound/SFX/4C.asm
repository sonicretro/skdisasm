Sound_4C_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_4C_56_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_4C_FM5,	$F8, $00

; FM5 Data
Sound_4C_FM5:
	smpsSetvoice        $00
	dc.b	nG2, $03, nB2, $07
	smpsStop

Sound_4C_56_Voices:
;	Voice $00
;	$3C
;	$00, $0A, $00, $00, 	$1F, $1F, $1F, $0F, 	$00, $16, $15, $0F
;	$00, $00, $00, $00, 	$0F, $AF, $FF, $FF, 	$00, $80, $04, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $0A, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0F, $15, $16, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0A, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $04, $00, $00

