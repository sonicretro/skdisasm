Sound_C1_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_C1_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM3, Sound_C1_FM3,	$F0, $0D

; FM3 Data
Sound_C1_FM3:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $0F, $00
	dc.b	nEb3, $30, smpsNoAttack
	smpsModOff

Sound_C1_Loop00:
	dc.b	nB3, $16, smpsNoAttack
	smpsContinuousLoop  Sound_C1_Loop00
	dc.b	$01
	smpsStop

Sound_C1_Voices:
;	Voice $00
;	$04
;	$2F, $07, $06, $00, 	$17, $17, $07, $17, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$30, $80, $20, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $02
	smpsVcCoarseFreq    $00, $06, $07, $0F
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $17, $07, $17, $17
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $20, $00, $30

