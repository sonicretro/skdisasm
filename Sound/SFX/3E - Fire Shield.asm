Sound_3E_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_3E_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_3E_3F_40_41_FM5,	$E8, $00

; FM5 Data
Sound_3E_3F_40_41_FM5:
	smpsSetvoice        $00
	dc.b	nBb2, $05, smpsNoAttack, nB2, $26
	smpsStop

Sound_3E_Voices:
;	Voice $00
;	$0C
;	$01, $21, $31, $31, 	$1E, $0C, $0E, $1C, 	$0A, $00, $04, $00
;	$08, $12, $08, $0C, 	$FF, $0F, $BF, $0F, 	$03, $80, $0D, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $01
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $02, $00
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1C, $0E, $0C, $1E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $04, $00, $0A
	smpsVcDecayRate2    $0C, $08, $12, $08
	smpsVcDecayLevel    $00, $0B, $00, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $0D, $00, $03

