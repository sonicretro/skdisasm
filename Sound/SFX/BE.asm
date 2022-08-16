Sound_BE_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_BE_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM3, Sound_BE_FM3,	$12, $10

; FM3 Data
Sound_BE_FM3:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $2B, $0B
	dc.b	nA0, $29

Sound_BE_Loop00:
	dc.b	smpsNoAttack, nA0, $16
	smpsContinuousLoop  Sound_BE_Loop00
	smpsStop

Sound_BE_Voices:
;	Voice $00
;	$34
;	$0C, $0D, $0A, $1A, 	$1F, $1F, $1F, $1F, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$11, $80, $10, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $00, $00, $00
	smpsVcCoarseFreq    $0A, $0A, $0D, $0C
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $10, $00, $11

