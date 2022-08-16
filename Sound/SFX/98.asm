Sound_98_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_98_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cFM5, Sound_98_FM5,	$00, $06
	smpsHeaderSFXChannel cPSG3, Sound_98_PSG3,	$F0, $04

; FM5 Data
Sound_98_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $B2, $11
	dc.b	nC0, $03, $09
	smpsFMAlterVol      $15
	smpsLoop            $00, $03, Sound_98_FM5
	smpsStop

; PSG3 Data
Sound_98_PSG3:
	smpsPSGform         $E7
	smpsModSet          $01, $01, $04, $01
	dc.b	nC0, $0F
	smpsPSGAlterVol     $05
	smpsLoop            $00, $03, Sound_98_PSG3
	smpsStop

Sound_98_Voices:
;	Voice $00
;	$02
;	$10, $10, $10, $11, 	$18, $18, $1A, $1F, 	$00, $05, $17, $10
;	$00, $08, $0D, $00, 	$00, $0F, $0F, $1D, 	$10, $00, $00, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $01, $01, $01
	smpsVcCoarseFreq    $01, $00, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1A, $18, $18
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $10, $17, $05, $00
	smpsVcDecayRate2    $00, $0D, $08, $00
	smpsVcDecayLevel    $01, $00, $00, $00
	smpsVcReleaseRate   $0D, $0F, $0F, $00
	smpsVcTotalLevel    $00, $00, $00, $10

