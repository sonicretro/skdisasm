Sound_76_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_76_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_76_FM5,	$00, $05

; FM5 Data
Sound_76_FM5:
	smpsSetvoice        $00
	dc.b	nAb3, $07, nG2, $13
	smpsStop

Sound_76_Voices:
;	Voice $00
;	$34
;	$08, $07, $03, $00, 	$1F, $1F, $1F, $1F, 	$19, $12, $19, $11
;	$05, $12, $00, $0F, 	$09, $04, $F0, $FF, 	$00, $80, $00, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $03, $07, $08
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $11, $19, $12, $19
	smpsVcDecayRate2    $0F, $00, $12, $05
	smpsVcDecayLevel    $0F, $0F, $00, $00
	smpsVcReleaseRate   $0F, $00, $04, $09
	smpsVcTotalLevel    $00, $00, $00, $00

