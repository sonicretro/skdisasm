Sound_50_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_50_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_50_FM5,	$E4, $05

; FM5 Data
Sound_50_FM5:
	smpsSetvoice        $00
	dc.b	nB3, $02, smpsNoAttack, nC4, smpsNoAttack, nCs4, smpsNoAttack, nD4, $30

Sound_50_Loop00:
	dc.b	smpsNoAttack, $01
	smpsFMAlterVol      $01
	smpsLoop            $00, $0A, Sound_50_Loop00
	smpsStop

Sound_50_Voices:
;	Voice $00
;	$3C
;	$03, $01, $12, $01, 	$1F, $11, $1F, $11, 	$00, $0D, $00, $00
;	$00, $08, $00, $00, 	$0F, $3F, $0F, $0F, 	$00, $8A, $05, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $01, $00, $00
	smpsVcCoarseFreq    $01, $02, $01, $03
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $11, $1F, $11, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $0D, $00
	smpsVcDecayRate2    $00, $00, $08, $00
	smpsVcDecayLevel    $00, $00, $03, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $05, $0A, $00

