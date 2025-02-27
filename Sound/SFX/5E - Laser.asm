Sound_5E_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_5E_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_5E_FM5,	$00, $03

; FM5 Data
Sound_5E_FM5:
	smpsSetvoice        $00
	dc.b	nBb5, $18

Sound_5E_Loop00:
	dc.b	smpsNoAttack, $03
	smpsFMAlterVol      $03
	smpsLoop            $00, $10, Sound_5E_Loop00
	smpsStop

Sound_5E_Voices:
;	Voice $00
;	$00
;	$53, $03, $1F, $20, 	$1F, $1F, $1F, $10, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$00, $00, $00, $0F, 	$10, $23, $10, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $02, $01, $00, $05
	smpsVcCoarseFreq    $00, $0F, $03, $03
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $10, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $00, $00, $00
	smpsVcTotalLevel    $00, $10, $23, $10

