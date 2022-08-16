Sound_D8_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_D8_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM3, Sound_D8_FM3,	$00, $05

; FM3 Data
Sound_D8_FM3:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $01, $83
	dc.b	nFs2, $16

Sound_D8_Loop00:
	dc.b	smpsNoAttack, nFs2, $16
	smpsContinuousLoop  Sound_D8_Loop00
	smpsStop

Sound_D8_Voices:
;	Voice $00
;	$82
;	$1F, $18, $14, $1F, 	$0D, $1F, $12, $0C, 	$00, $00, $00, $00
;	$02, $02, $02, $02, 	$2F, $2F, $FF, $3F, 	$22, $16, $11, $82
	smpsVcAlgorithm     $02
	smpsVcFeedback      $00
	smpsVcUnusedBits    $02
	smpsVcDetune        $01, $01, $01, $01
	smpsVcCoarseFreq    $0F, $04, $08, $0F
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0C, $12, $1F, $0D
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $02, $02, $02, $02
	smpsVcDecayLevel    $03, $0F, $02, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $02, $11, $16, $22

