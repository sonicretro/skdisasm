Sound_7B_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_7B_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_7B_FM5,	$17, $04

; FM5 Data
Sound_7B_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $0C, $01
	dc.b	nC0, $08
	smpsFMAlterVol      $10
	dc.b	nE0
	smpsStop

Sound_7B_Voices:
;	Voice $00
;	$F1
;	$23, $30, $11, $30, 	$1F, $18, $1F, $1F, 	$05, $1F, $09, $01
;	$0B, $12, $03, $03, 	$1F, $0F, $4F, $2F, 	$6F, $31, $00, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $06
	smpsVcUnusedBits    $03
	smpsVcDetune        $03, $01, $03, $02
	smpsVcCoarseFreq    $00, $01, $00, $03
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $18, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $09, $1F, $05
	smpsVcDecayRate2    $03, $03, $12, $0B
	smpsVcDecayLevel    $02, $04, $00, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $31, $6F

