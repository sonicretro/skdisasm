Sound_40_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_40_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_3E_3F_40_41_FM5,	$FC, $04

Sound_40_Voices:
;	Voice $00
;	$32
;	$05, $02, $13, $31, 	$0B, $1C, $10, $0D, 	$00, $00, $04, $00
;	$00, $00, $00, $0C, 	$0F, $0F, $1F, $0F, 	$0B, $17, $0C, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $01, $00, $00
	smpsVcCoarseFreq    $01, $03, $02, $05
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0D, $10, $1C, $0B
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $04, $00, $00
	smpsVcDecayRate2    $0C, $00, $00, $00
	smpsVcDecayLevel    $00, $01, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $0C, $17, $0B

