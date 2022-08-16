Sound_DA_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_DA_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM3, Sound_DA_FM3,	$03, $00

; FM3 Data
Sound_DA_FM3:
	smpsSetvoice        $00
	smpsModSet          $03, $01, $FD, $02

Sound_DA_Loop00:
	dc.b	nE1, $16, smpsNoAttack
	smpsContinuousLoop  Sound_DA_Loop00
	dc.b	$01
	smpsStop

Sound_DA_Voices:
;	Voice $00
;	$FA
;	$21, $47, $20, $30, 	$04, $08, $07, $12, 	$06, $0E, $09, $02
;	$00, $10, $01, $01, 	$00, $00, $00, $FE, 	$37, $4C, $00, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $03
	smpsVcDetune        $03, $02, $04, $02
	smpsVcCoarseFreq    $00, $00, $07, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $12, $07, $08, $04
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $09, $0E, $06
	smpsVcDecayRate2    $01, $01, $10, $00
	smpsVcDecayLevel    $0F, $00, $00, $00
	smpsVcReleaseRate   $0E, $00, $00, $00
	smpsVcTotalLevel    $00, $00, $4C, $37

