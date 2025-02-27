Sound_8E_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_8E_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_8E_FM5,	$B0, $04

; FM5 Data
Sound_8E_FM5:
	smpsSetvoice        $00
	smpsModSet          $02, $01, $0B, $D5
	dc.b	nF4, $06
	smpsFMAlterVol      $09
	dc.b	nF4, $3A
	smpsStop

Sound_8E_Voices:
;	Voice $00
;	$D2
;	$11, $92, $6F, $0F, 	$19, $1D, $1C, $12, 	$02, $04, $03, $0C
;	$17, $02, $06, $03, 	$07, $0F, $0F, $0F, 	$0A, $15, $11, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $02
	smpsVcUnusedBits    $03
	smpsVcDetune        $00, $06, $09, $01
	smpsVcCoarseFreq    $0F, $0F, $02, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $12, $1C, $1D, $19
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0C, $03, $04, $02
	smpsVcDecayRate2    $03, $06, $02, $17
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $07
	smpsVcTotalLevel    $00, $11, $15, $0A

