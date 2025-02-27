Sound_75_Header:
	smpsHeaderStartSong 3, 1
	smpsHeaderVoice     Sound_75_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_75_FM5,	$15, $05

; FM5 Data
Sound_75_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $20, $85
	dc.b	nD0, $03, nB0, $1E
	smpsStop

Sound_75_Voices:
;	Voice $00
;	$35
;	$02, $FD, $01, $F6, 	$0F, $16, $14, $11, 	$06, $04, $0F, $08
;	$02, $03, $03, $04, 	$7F, $6F, $3F, $2F, 	$31, $28, $0E, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $0F, $00, $0F, $00
	smpsVcCoarseFreq    $06, $01, $0D, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $11, $14, $16, $0F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $0F, $04, $06
	smpsVcDecayRate2    $04, $03, $03, $02
	smpsVcDecayLevel    $02, $03, $06, $07
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $80, $0E, $28, $31

