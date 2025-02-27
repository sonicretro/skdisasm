Sound_8A_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_8A_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM4, Sound_8A_FM4,	$0C, $00

; FM4 Data
Sound_8A_FM4:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $27, $82

Sound_8A_Loop00:
	dc.b	nC0, $0C
	smpsFMAlterVol      $18
	smpsLoop            $00, $03, Sound_8A_Loop00
	smpsStop

Sound_8A_Voices:
;	Voice $00
;	$35
;	$14, $17, $04, $0C, 	$0E, $10, $11, $0E, 	$0C, $15, $03, $06
;	$16, $0E, $09, $10, 	$2F, $2F, $4C, $4F, 	$2F, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $01, $01
	smpsVcCoarseFreq    $0C, $04, $07, $04
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0E, $11, $10, $0E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $03, $15, $0C
	smpsVcDecayRate2    $10, $09, $0E, $16
	smpsVcDecayLevel    $04, $04, $02, $02
	smpsVcReleaseRate   $0F, $0C, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $2F

