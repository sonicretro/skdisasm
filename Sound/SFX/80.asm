Sound_80_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_80_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_80_FM5,	$00, $00

; FM5 Data
Sound_80_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $69, $70
	dc.b	nB5, $06, nD6, $07
	smpsStop

Sound_80_Voices:
;	Voice $00
;	$43
;	$38, $4F, $F7, $44, 	$9F, $1F, $1F, $1F, 	$0B, $09, $08, $0B
;	$0A, $12, $04, $0C, 	$10, $01, $14, $19, 	$2D, $80, $08, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $00
	smpsVcUnusedBits    $01
	smpsVcDetune        $04, $0F, $04, $03
	smpsVcCoarseFreq    $04, $07, $0F, $08
	smpsVcRateScale     $00, $00, $00, $02
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0B, $08, $09, $0B
	smpsVcDecayRate2    $0C, $04, $12, $0A
	smpsVcDecayLevel    $01, $01, $00, $01
	smpsVcReleaseRate   $09, $04, $01, $00
	smpsVcTotalLevel    $00, $08, $80, $2D

