Sound_9C_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_9C_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_9C_FM5,	$F0, $00

; FM5 Data
Sound_9C_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $F7, $EA

Sound_9C_Loop00:
	dc.b	nAb5, $02, $03, nRst, $02
	smpsFMAlterVol      $06
	smpsLoop            $00, $0E, Sound_9C_Loop00
	smpsStop

Sound_9C_Voices:
;	Voice $00
;	$45
;	$3F, $4F, $FF, $4F, 	$18, $18, $17, $10, 	$00, $00, $02, $06
;	$0B, $1C, $18, $1D, 	$10, $1B, $1B, $02, 	$37, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $00
	smpsVcUnusedBits    $01
	smpsVcDetune        $04, $0F, $04, $03
	smpsVcCoarseFreq    $0F, $0F, $0F, $0F
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $10, $17, $18, $18
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $02, $00, $00
	smpsVcDecayRate2    $1D, $18, $1C, $0B
	smpsVcDecayLevel    $00, $01, $01, $01
	smpsVcReleaseRate   $02, $0B, $0B, $00
	smpsVcTotalLevel    $00, $00, $00, $37

