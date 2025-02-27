Sound_7A_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_7A_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_7A_FM5,	$00, $04

; FM5 Data
Sound_7A_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $0C, $01

Sound_7A_Loop00:
	dc.b	nC0, $0A
	smpsFMAlterVol      $07
	smpsLoop            $00, $06, Sound_7A_Loop00
	smpsStop

Sound_7A_Voices:
;	Voice $00
;	$F1
;	$21, $30, $11, $33, 	$1F, $1F, $1F, $1F, 	$05, $18, $09, $02
;	$0B, $1F, $10, $05, 	$1F, $2F, $4F, $2F, 	$0E, $07, $04, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $06
	smpsVcUnusedBits    $03
	smpsVcDetune        $03, $01, $03, $02
	smpsVcCoarseFreq    $03, $01, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $09, $18, $05
	smpsVcDecayRate2    $05, $10, $1F, $0B
	smpsVcDecayLevel    $02, $04, $02, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $04, $07, $0E

