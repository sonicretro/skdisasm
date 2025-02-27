Sound_7D_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_7D_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_7D_FM5,	$E3, $02

; FM5 Data
Sound_7D_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $FA, $41
	dc.b	nD3, $1A
	smpsStop

Sound_7D_Voices:
;	Voice $00
;	$0A
;	$40, $3B, $11, $31, 	$1F, $1F, $1B, $0C, 	$05, $18, $05, $10
;	$03, $03, $00, $05, 	$1F, $2F, $1F, $2F, 	$10, $60, $0E, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $01
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $01, $03, $04
	smpsVcCoarseFreq    $01, $01, $0B, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0C, $1B, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $10, $05, $18, $05
	smpsVcDecayRate2    $05, $00, $03, $03
	smpsVcDecayLevel    $02, $01, $02, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $0E, $60, $10

