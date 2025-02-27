Sound_8C_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_8C_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_8C_FM5,	$EC, $07

; FM5 Data
Sound_8C_FM5:
	smpsSetvoice        $00
	smpsModSet          $02, $01, $6B, $D5
	dc.b	nB3, $06
	smpsFMAlterVol      $0A
	dc.b	nF4, $0B
	smpsStop

Sound_8C_Voices:
;	Voice $00
;	$3B
;	$0F, $0F, $10, $01, 	$14, $1F, $0E, $14, 	$0C, $04, $01, $04
;	$02, $02, $02, $03, 	$DF, $2F, $2F, $2F, 	$22, $24, $13, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $01, $00, $00
	smpsVcCoarseFreq    $01, $00, $0F, $0F
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $14, $0E, $1F, $14
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $04, $01, $04, $0C
	smpsVcDecayRate2    $03, $02, $02, $02
	smpsVcDecayLevel    $02, $02, $02, $0D
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $13, $24, $22

