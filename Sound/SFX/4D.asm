Sound_4D_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_4D_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_4D_FM5,	$00, $08

; FM5 Data
Sound_4D_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $E0, $14
	dc.b	nEb3, $09
	smpsStop

Sound_4D_Voices:
;	Voice $00
;	$3E
;	$00, $05, $04, $04, 	$1F, $1F, $16, $16, 	$00, $00, $00, $00
;	$00, $13, $11, $10, 	$0F, $0F, $0F, $0F, 	$00, $80, $80, $80
	smpsVcAlgorithm     $06
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $04, $04, $05, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $16, $16, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $10, $11, $13, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $00

