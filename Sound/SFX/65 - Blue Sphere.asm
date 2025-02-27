Sound_65_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_65_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_65_FM5,	$F4, $05

; FM5 Data
Sound_65_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $41, $00
	dc.b	nEb5, $08
	smpsFMAlterVol      $05
	smpsModSet          $01, $01, $D0, $00
	dc.b	nEb5, $08
	smpsStop

Sound_65_Voices:
;	Voice $00
;	$05
;	$07, $12, $22, $32, 	$0A, $0F, $0F, $0F, 	$00, $00, $00, $00
;	$00, $10, $10, $10, 	$0F, $0F, $0F, $0F, 	$21, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $02, $01, $00
	smpsVcCoarseFreq    $02, $02, $02, $07
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0F, $0F, $0F, $0A
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $10, $10, $10, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $21

