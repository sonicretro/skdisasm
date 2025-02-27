Sound_BF_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_BF_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM3, Sound_BF_FM3,	$02, $00

; FM3 Data
Sound_BF_FM3:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $7F, $24

Sound_BF_Loop00:
	dc.b	nB1, $16, smpsNoAttack
	smpsContinuousLoop  Sound_BF_Loop00
	dc.b	$01
	smpsStop

Sound_BF_Voices:
;	Voice $00
;	$04
;	$00, $10, $22, $30, 	$0F, $0F, $0F, $0F, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$19, $88, $30, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $02, $01, $00
	smpsVcCoarseFreq    $00, $02, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0F, $0F, $0F, $0F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $30, $08, $19

