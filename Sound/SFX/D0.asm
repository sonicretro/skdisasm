Sound_D0_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_D0_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM3, Sound_D0_FM3,	$F3, $07

; FM3 Data
Sound_D0_FM3:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $03, $CA
	dc.b	nCs3, $61
	smpsModSet          $01, $01, $DF, $05

Sound_D0_Loop00:
	dc.b	smpsNoAttack, $16
	smpsContinuousLoop  Sound_D0_Loop00
	smpsStop

Sound_D0_Voices:
;	Voice $00
;	$35
;	$06, $07, $03, $05, 	$11, $07, $0B, $EE, 	$0C, $15, $03, $06
;	$0C, $00, $00, $00, 	$1F, $1F, $1F, $1F, 	$2E, $8D, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $05, $03, $07, $06
	smpsVcRateScale     $03, $00, $00, $00
	smpsVcAttackRate    $2E, $0B, $07, $11
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $03, $15, $0C
	smpsVcDecayRate2    $00, $00, $00, $0C
	smpsVcDecayLevel    $01, $01, $01, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $0D, $2E

