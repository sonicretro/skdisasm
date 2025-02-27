Sound_D5_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_D5_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cFM3, Sound_D5_FM3,	$00, $10
	smpsHeaderSFXChannel cFM4, Sound_D5_FM4,	$00, $0C

; FM3 Data
Sound_D5_FM3:
	dc.b	nRst, $04

; FM4 Data
Sound_D5_FM4:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $AC, $2E

Sound_D5_Loop00:
	dc.b	nFs0, $08, nE0
	smpsContinuousLoop  Sound_D5_Loop00
	smpsStop

Sound_D5_Voices:
;	Voice $00
;	$33
;	$11, $10, $10, $11, 	$05, $1F, $04, $1F, 	$1F, $01, $05, $00
;	$10, $09, $08, $00, 	$06, $03, $01, $1A, 	$0B, $01, $10, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $01, $01, $01
	smpsVcCoarseFreq    $01, $00, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $04, $1F, $05
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $05, $01, $1F
	smpsVcDecayRate2    $00, $08, $09, $10
	smpsVcDecayLevel    $01, $00, $00, $00
	smpsVcReleaseRate   $0A, $01, $03, $06
	smpsVcTotalLevel    $00, $10, $01, $0B

