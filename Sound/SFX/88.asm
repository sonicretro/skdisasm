Sound_88_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_88_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_88_FM5,	$05, $0C

; FM5 Data
Sound_88_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $02, $76
	dc.b	nAb2, $11
	smpsStop

Sound_88_Voices:
;	Voice $00
;	$FA
;	$3F, $A0, $FF, $9F, 	$1F, $18, $0B, $11, 	$08, $1F, $08, $02
;	$0B, $1F, $11, $05, 	$2C, $FE, $4F, $2F, 	$18, $02, $04, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $03
	smpsVcDetune        $09, $0F, $0A, $03
	smpsVcCoarseFreq    $0F, $0F, $00, $0F
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $11, $0B, $18, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $08, $1F, $08
	smpsVcDecayRate2    $05, $11, $1F, $0B
	smpsVcDecayLevel    $02, $04, $0F, $02
	smpsVcReleaseRate   $0F, $0F, $0E, $0C
	smpsVcTotalLevel    $00, $04, $02, $18

