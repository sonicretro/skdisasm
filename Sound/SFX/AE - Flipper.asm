Sound_AE_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_AE_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_AE_FM5,	$0D, $0A

; FM5 Data
Sound_AE_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $04, $56
	dc.b	nF1, $03, nCs2, $25
	smpsStop

Sound_AE_Voices:
;	Voice $00
;	$3D
;	$12, $77, $10, $30, 	$5F, $5F, $5F, $5F, 	$0F, $00, $0A, $01
;	$0A, $0D, $0A, $0D, 	$4F, $0F, $0F, $0F, 	$13, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $01, $07, $01
	smpsVcCoarseFreq    $00, $00, $07, $02
	smpsVcRateScale     $01, $01, $01, $01
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $0A, $00, $0F
	smpsVcDecayRate2    $0D, $0A, $0D, $0A
	smpsVcDecayLevel    $00, $00, $00, $04
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $13

