Sound_74_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_74_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_74_FM5,	$FE, $02

; FM5 Data
Sound_74_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $04, $05
	dc.b	nG1, $36
	smpsStop

Sound_74_Voices:
;	Voice $00
;	$3C
;	$01, $06, $0A, $0E, 	$16, $0F, $1C, $10, 	$0E, $11, $11, $11
;	$09, $0A, $06, $0A, 	$4F, $3F, $3F, $3F, 	$17, $80, $20, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $0E, $0A, $06, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $10, $1C, $0F, $16
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $11, $11, $11, $0E
	smpsVcDecayRate2    $0A, $06, $0A, $09
	smpsVcDecayLevel    $03, $03, $03, $04
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $20, $00, $17

