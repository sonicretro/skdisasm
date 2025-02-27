Sound_D6_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_D6_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM3, Sound_D6_FM3,	$10, $04

; FM3 Data
Sound_D6_FM3:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $0C, $01

Sound_D6_Loop00:
	dc.b	nC0, $08, nC0
	smpsContinuousLoop  Sound_D6_Loop00
	smpsStop

Sound_D6_Voices:
;	Voice $00
;	$F9
;	$22, $31, $11, $32, 	$0F, $0E, $1F, $1F, 	$05, $18, $09, $02
;	$0B, $1F, $10, $05, 	$1F, $2F, $4F, $2F, 	$0E, $17, $14, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $07
	smpsVcUnusedBits    $03
	smpsVcDetune        $03, $01, $03, $02
	smpsVcCoarseFreq    $02, $01, $01, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $0E, $0F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $09, $18, $05
	smpsVcDecayRate2    $05, $10, $1F, $0B
	smpsVcDecayLevel    $02, $04, $02, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $14, $17, $0E

