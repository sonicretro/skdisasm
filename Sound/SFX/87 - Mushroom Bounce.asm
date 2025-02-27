Sound_87_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_87_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_87_FM5,	$17, $04

; FM5 Data
Sound_87_FM5:
	smpsSetvoice        $00
	smpsModSet          $06, $01, $58, $97
	dc.b	nC0, $06

Sound_87_Loop00:
	dc.b	nE0, $09
	smpsFMAlterVol      $0E
	smpsLoop            $00, $06, Sound_87_Loop00
	smpsStop

Sound_87_Voices:
;	Voice $00
;	$F2
;	$26, $6C, $10, $30, 	$1F, $0C, $12, $15, 	$17, $10, $08, $09
;	$1D, $17, $13, $13, 	$11, $19, $1F, $1F, 	$5F, $7C, $00, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $06
	smpsVcUnusedBits    $03
	smpsVcDetune        $03, $01, $06, $02
	smpsVcCoarseFreq    $00, $00, $0C, $06
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $15, $12, $0C, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $09, $08, $10, $17
	smpsVcDecayRate2    $13, $13, $17, $1D
	smpsVcDecayLevel    $01, $01, $01, $01
	smpsVcReleaseRate   $0F, $0F, $09, $01
	smpsVcTotalLevel    $00, $00, $7C, $5F

