Sound_99_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_99_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM3, Sound_99_FM3,	$07, $00

; FM3 Data
Sound_99_FM3:
	smpsSetvoice        $00
	dc.b	nG2, $48
	smpsStop

Sound_99_Voices:
;	Voice $00
;	$03
;	$10, $70, $00, $3F, 	$1F, $1F, $1F, $1F, 	$17, $1F, $00, $15
;	$00, $00, $00, $00, 	$FF, $0F, $0F, $FF, 	$03, $1B, $2C, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $00, $07, $01
	smpsVcCoarseFreq    $0F, $00, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $15, $00, $1F, $17
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $00, $00, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $2C, $1B, $03

