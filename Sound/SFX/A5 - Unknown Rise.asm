Sound_A5_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_A5_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_A5_FM5,	$20, $06

; FM5 Data
Sound_A5_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $0F, $F4
	dc.b	nD1, $33
	smpsStop

Sound_A5_Voices:
;	Voice $00
;	$05
;	$05, $30, $79, $30, 	$07, $0C, $08, $0F, 	$00, $00, $00, $00
;	$01, $00, $01, $00, 	$0F, $0F, $2F, $0F, 	$4D, $81, $86, $8D
	smpsVcAlgorithm     $05
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $07, $03, $00
	smpsVcCoarseFreq    $00, $09, $00, $05
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0F, $08, $0C, $07
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $01, $00, $01
	smpsVcDecayLevel    $00, $02, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0D, $06, $01, $4D

