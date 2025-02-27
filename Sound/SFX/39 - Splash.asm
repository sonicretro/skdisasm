Sound_39_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_39_57_6C_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cPSG3, Sound_39_6C_PSG3,	$0C, $03
	smpsHeaderSFXChannel cFM5, Sound_39_57_6C_FM5,	$00, $06

; PSG3 Data
Sound_39_6C_PSG3:
	smpsPSGvoice        sTone_0D
	smpsPSGform         $E7
	dc.b	nF5, $05, nA5, $05, smpsNoAttack

Sound_39_6C_Loop00:
	dc.b	$07
	smpsPSGAlterVol     $01
	dc.b	smpsNoAttack
	smpsLoop            $00, $0F, Sound_39_6C_Loop00
	smpsStop

; FM5 Data
Sound_39_57_6C_FM5:
	smpsSetvoice        $00
	dc.b	nCs3, $14
	smpsStop

Sound_39_57_6C_Voices:
;	Voice $00
;	$00
;	$00, $03, $02, $00, 	$D9, $DF, $1F, $1F, 	$12, $11, $14, $0F
;	$0A, $00, $0A, $0D, 	$FF, $FF, $FF, $FF, 	$22, $07, $27, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $02, $03, $00
	smpsVcRateScale     $00, $00, $03, $03
	smpsVcAttackRate    $1F, $1F, $1F, $19
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0F, $14, $11, $12
	smpsVcDecayRate2    $0D, $0A, $00, $0A
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $27, $07, $22

