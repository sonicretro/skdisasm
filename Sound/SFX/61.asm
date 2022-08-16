Sound_61_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_61_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_61_FM5,	$00, $00

; FM5 Data
Sound_61_FM5:
	smpsSetvoice        $00
	dc.b	nD0, $0D

Sound_61_Loop00:
	dc.b	nD0, $0D
	smpsFMAlterVol      $15
	smpsLoop            $00, $04, Sound_61_Loop00
	smpsStop

Sound_61_Voices:
;	Voice $00
;	$54
;	$48, $02, $03, $01, 	$1F, $1F, $1F, $1F, 	$11, $00, $0A, $00
;	$00, $05, $00, $05, 	$FF, $0F, $FF, $0F, 	$02, $80, $10, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $02
	smpsVcUnusedBits    $01
	smpsVcDetune        $00, $00, $00, $04
	smpsVcCoarseFreq    $01, $03, $02, $08
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $0A, $00, $11
	smpsVcDecayRate2    $05, $00, $05, $00
	smpsVcDecayLevel    $00, $0F, $00, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $10, $00, $02

