Sound_AB_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_AB_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_AB_FM5,	$00, $00

; FM5 Data
Sound_AB_FM5:
	smpsSpindashRev
	smpsSetvoice        $00
	smpsModSet          $01, $01, $1A, $01
	dc.b	nC5, $18, smpsNoAttack
	smpsModSet          $00, $00, $00, $00
	dc.b	$02

Sound_AB_Loop00:
	dc.b	smpsNoAttack, $02
	smpsFMAlterVol      $02
	smpsLoop            $00, $18, Sound_AB_Loop00
	smpsResetSpindashRev
	smpsStop

Sound_AB_Voices:
;	Voice $00
;	$34
;	$00, $0C, $03, $09, 	$9F, $8F, $8C, $D5, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$00, $80, $1C, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $09, $03, $0C, $00
	smpsVcRateScale     $03, $02, $02, $02
	smpsVcAttackRate    $15, $0C, $0F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1C, $00, $00

