Sound_73_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_73_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_73_FM5,	$F6, $06

; FM5 Data
Sound_73_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $14, $F6
	dc.b	nF2, $1E
	smpsFMAlterVol      $0C
	smpsLoop            $00, $05, Sound_73_FM5
	smpsStop

Sound_73_Voices:
;	Voice $00
;	$82
;	$1D, $10, $1B, $10, 	$04, $10, $0D, $1F, 	$00, $00, $00, $00
;	$02, $02, $02, $02, 	$2F, $2F, $FF, $3F, 	$1B, $2D, $1B, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $00
	smpsVcUnusedBits    $02
	smpsVcDetune        $01, $01, $01, $01
	smpsVcCoarseFreq    $00, $0B, $00, $0D
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $0D, $10, $04
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $02, $02, $02, $02
	smpsVcDecayLevel    $03, $0F, $02, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1B, $2D, $1B

