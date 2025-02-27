Sound_A2_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_A2_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_A2_FM5,	$00, $02

; FM5 Data
Sound_A2_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $85, $32
	dc.b	nD0, $03

Sound_A2_Loop00:
	dc.b	nC3, $0D, nRst, $02
	smpsFMAlterVol      $18
	smpsLoop            $00, $04, Sound_A2_Loop00
	smpsStop

Sound_A2_Voices:
;	Voice $00
;	$02
;	$12, $14, $28, $12, 	$11, $1C, $1C, $14, 	$00, $10, $00, $00
;	$02, $02, $02, $02, 	$2F, $2F, $FF, $3F, 	$05, $00, $0B, $85
	smpsVcAlgorithm     $02
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $02, $01, $01
	smpsVcCoarseFreq    $02, $08, $04, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $14, $1C, $1C, $11
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $10, $00
	smpsVcDecayRate2    $02, $02, $02, $02
	smpsVcDecayLevel    $03, $0F, $02, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $05, $0B, $00, $05

