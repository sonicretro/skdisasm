Sound_D4_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_D4_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM3, Sound_D4_FM3,	$00, $00

; FM3 Data
Sound_D4_FM3:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $20, $01
	dc.b	nF0, $16
	smpsModSet          $00, $00, $00, $00

Sound_D4_Loop00:
	dc.b	smpsNoAttack, $16
	smpsContinuousLoop  Sound_D4_Loop00
	smpsStop

Sound_D4_Voices:
;	Voice $00
;	$0A
;	$40, $35, $11, $31, 	$1F, $1F, $1B, $0C, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$20, $40, $0E, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $01
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $01, $03, $04
	smpsVcCoarseFreq    $01, $01, $05, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0C, $1B, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $0E, $40, $20

