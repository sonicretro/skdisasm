Sound_72_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_72_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_72_FM5,	$1E, $0C

; FM5 Data
Sound_72_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $F0, $A5
	dc.b	nBb0, $16
	smpsStop

Sound_72_Voices:
;	Voice $00
;	$83
;	$11, $1D, $12, $10, 	$01, $16, $0D, $1F, 	$00, $00, $00, $00
;	$02, $02, $02, $02, 	$2F, $2F, $FF, $3F, 	$1B, $2D, $1B, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $00
	smpsVcUnusedBits    $02
	smpsVcDetune        $01, $01, $01, $01
	smpsVcCoarseFreq    $00, $02, $0D, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $0D, $16, $01
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $02, $02, $02, $02
	smpsVcDecayLevel    $03, $0F, $02, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1B, $2D, $1B

