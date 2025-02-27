Sound_41_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_41_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_3E_3F_40_41_FM5,	$0A, $00

Sound_41_Voices:
;	Voice $00
;	$36
;	$07, $10, $0E, $0C, 	$1F, $1F, $1F, $1F, 	$00, $00, $00, $00
;	$00, $0D, $0D, $0E, 	$0F, $0F, $0F, $0F, 	$17, $80, $80, $80
	smpsVcAlgorithm     $06
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $01, $00
	smpsVcCoarseFreq    $0C, $0E, $00, $07
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $0E, $0D, $0D, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $17

