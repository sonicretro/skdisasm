Sound_5C_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_5C_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_5C_FM5,	$00, $00

; FM5 Data
Sound_5C_FM5:
	smpsSetvoice        $00
	dc.b	nF2, $10
	smpsStop

Sound_5C_Voices:
;	Voice $00
;	$01
;	$01, $B0, $FC, $40, 	$1F, $1F, $1F, $1F, 	$00, $04, $06, $1F
;	$0B, $10, $10, $0F, 	$0F, $FF, $FF, $05, 	$19, $00, $28, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $0F, $0B, $00
	smpsVcCoarseFreq    $00, $0C, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $1F, $06, $04, $00
	smpsVcDecayRate2    $0F, $10, $10, $0B
	smpsVcDecayLevel    $00, $0F, $0F, $00
	smpsVcReleaseRate   $05, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $28, $00, $19

