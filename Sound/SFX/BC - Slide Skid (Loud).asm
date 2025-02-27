Sound_BC_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_BC_C8_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM3, Sound_BC_C8_FM3,	$00, $10

; FM3 Data
Sound_BC_C8_FM3:
	smpsSetvoice        $00

Sound_BC_C8_Loop00:
	dc.b	nBb6, $16
	smpsContinuousLoop  Sound_BC_C8_Loop00
	smpsStop

Sound_BC_C8_Voices:
;	Voice $00
;	$38
;	$00, $30, $00, $01, 	$1F, $1F, $1F, $0F, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$00, $00, $00, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $03, $00
	smpsVcCoarseFreq    $01, $00, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $00

