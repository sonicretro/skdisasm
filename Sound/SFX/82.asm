Sound_82_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_82_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_82_FM5,	$1E, $00

; FM5 Data
Sound_82_FM5:
	smpsSetvoice        $00
	smpsModSet          $02, $01, $09, $06
	dc.b	nA2, $30
	smpsStop

Sound_82_Voices:
;	Voice $00
;	$38
;	$0A, $0A, $0A, $07, 	$1F, $1F, $1F, $12, 	$00, $00, $00, $00
;	$00, $00, $00, $0C, 	$00, $00, $00, $0F, 	$00, $00, $00, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $07, $0A, $0A, $0A
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $12, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $0C, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $00, $00, $00
	smpsVcTotalLevel    $00, $00, $00, $00

