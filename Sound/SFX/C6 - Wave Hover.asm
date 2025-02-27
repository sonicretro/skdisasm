Sound_C6_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_C6_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM3, Sound_C6_FM3,	$E0, $10

; FM3 Data
Sound_C6_FM3:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $30, $10
	dc.b	nEb5, $16

Sound_C6_Loop00:
	dc.b	smpsNoAttack, $10
	smpsContinuousLoop  Sound_C6_Loop00

Sound_C6_Loop01:
	dc.b	smpsNoAttack, $02
	smpsFMAlterVol      $04
	smpsLoop            $00, $10, Sound_C6_Loop01
	smpsStop

Sound_C6_Voices:
;	Voice $00
;	$05
;	$07, $37, $16, $25, 	$07, $0D, $0F, $08, 	$04, $00, $00, $00
;	$00, $00, $00, $00, 	$3F, $0F, $0F, $0F, 	$28, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $02, $01, $03, $00
	smpsVcCoarseFreq    $05, $06, $07, $07
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $08, $0F, $0D, $07
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $04
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $03
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $28

