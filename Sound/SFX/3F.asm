Sound_3F_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_3F_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_3E_3F_40_41_FM5,	$F6, $0A

Sound_3F_Voices:
;	Voice $00
;	$05
;	$11, $02, $23, $31, 	$0B, $0C, $0E, $1C, 	$0A, $00, $04, $00
;	$08, $06, $09, $0B, 	$FF, $0F, $BF, $0F, 	$09, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $02, $00, $01
	smpsVcCoarseFreq    $01, $03, $02, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1C, $0E, $0C, $0B
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $04, $00, $0A
	smpsVcDecayRate2    $0B, $09, $06, $08
	smpsVcDecayLevel    $00, $0B, $00, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $09

