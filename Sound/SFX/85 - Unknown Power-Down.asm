Sound_85_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_85_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_85_FM5,	$10, $05

; FM5 Data
Sound_85_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $F8, $C5
	dc.b	nCs1, $66
	smpsStop

Sound_85_Voices:
;	Voice $00
;	$3B
;	$65, $66, $41, $70, 	$10, $11, $50, $D1, 	$06, $01, $01, $01
;	$08, $00, $09, $00, 	$89, $F8, $F9, $F8, 	$18, $80, $80, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $04, $06, $06
	smpsVcCoarseFreq    $00, $01, $06, $05
	smpsVcRateScale     $03, $01, $00, $00
	smpsVcAttackRate    $11, $10, $11, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $01, $01, $06
	smpsVcDecayRate2    $00, $09, $00, $08
	smpsVcDecayLevel    $0F, $0F, $0F, $08
	smpsVcReleaseRate   $08, $09, $08, $09
	smpsVcTotalLevel    $00, $80, $80, $18

