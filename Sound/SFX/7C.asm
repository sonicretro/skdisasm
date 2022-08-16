Sound_7C_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_7C_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_7C_FM5,	$F9, $02

; FM5 Data
Sound_7C_FM5:
	smpsSetvoice        $00
	dc.b	nEb6, $05

Sound_7C_Loop00:
	dc.b	nF6, $02
	smpsFMAlterVol      $03
	smpsLoop            $00, $0E, Sound_7C_Loop00
	smpsStop

Sound_7C_Voices:
;	Voice $00
;	$83
;	$1F, $17, $1E, $1F, 	$1F, $1F, $16, $16, 	$00, $00, $00, $09
;	$02, $12, $12, $09, 	$FF, $8F, $FF, $EF, 	$0B, $16, $01, $82
	smpsVcAlgorithm     $03
	smpsVcFeedback      $00
	smpsVcUnusedBits    $02
	smpsVcDetune        $01, $01, $01, $01
	smpsVcCoarseFreq    $0F, $0E, $07, $0F
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $16, $16, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $09, $00, $00, $00
	smpsVcDecayRate2    $09, $12, $12, $02
	smpsVcDecayLevel    $0E, $0F, $08, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $02, $01, $16, $0B

