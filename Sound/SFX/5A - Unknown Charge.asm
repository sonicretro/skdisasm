Sound_5A_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_5A_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_5A_FM5,	$00, $00

; FM5 Data
Sound_5A_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $18, $00
	dc.b	nF2, $30
	smpsStop

Sound_5A_Voices:
;	Voice $00
;	$03
;	$0A, $0A, $0F, $0F, 	$1F, $1F, $1F, $1F, 	$00, $00, $0C, $00
;	$00, $00, $00, $09, 	$FF, $FF, $FF, $0F, 	$21, $10, $10, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $0F, $0F, $0A, $0A
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $0C, $00, $00
	smpsVcDecayRate2    $09, $00, $00, $00
	smpsVcDecayLevel    $00, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $10, $10, $21

