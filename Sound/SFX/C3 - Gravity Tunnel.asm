Sound_C3_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_C3_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM3, Sound_C3_FM3,	$04, $18

; FM3 Data
Sound_C3_FM3:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $31, $11

Sound_C3_Loop00:
	dc.b	nA3, $16
	smpsContinuousLoop  Sound_C3_Loop00
	smpsStop

Sound_C3_Voices:
;	Voice $00
;	$35
;	$07, $32, $22, $11, 	$1F, $0F, $0F, $0F, 	$00, $00, $00, $00
;	$0D, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$15, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $02, $03, $00
	smpsVcCoarseFreq    $01, $02, $02, $07
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0F, $0F, $0F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $0D
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $15

