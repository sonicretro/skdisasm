Sound_CD_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_CD_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM3, Sound_CD_FM3,	$00, $05

; FM3 Data
Sound_CD_FM3:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $C1, $8E
	dc.b	nC0, $04, $04, $04, $04
	smpsContinuousLoop  Sound_CD_FM3
	smpsStop

Sound_CD_Voices:
;	Voice $00
;	$F9
;	$22, $30, $20, $30, 	$10, $09, $1F, $1F, 	$00, $18, $09, $02
;	$0C, $1F, $10, $05, 	$0F, $2F, $4F, $2F, 	$11, $07, $04, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $07
	smpsVcUnusedBits    $03
	smpsVcDetune        $03, $02, $03, $02
	smpsVcCoarseFreq    $00, $00, $00, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $09, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $09, $18, $00
	smpsVcDecayRate2    $05, $10, $1F, $0C
	smpsVcDecayLevel    $02, $04, $02, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $04, $07, $11

