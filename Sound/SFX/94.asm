Sound_94_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_94_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_94_FM5,	$00, $08

; FM5 Data
Sound_94_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $CB, $16
	dc.b	nC0, $08, nC0, $08
	smpsStop

Sound_94_Voices:
;	Voice $00
;	$F9
;	$20, $30, $10, $30, 	$1F, $1F, $0B, $1F, 	$05, $18, $09, $02
;	$0B, $1F, $10, $05, 	$1F, $2F, $4F, $2F, 	$0D, $8C, $03, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $07
	smpsVcUnusedBits    $03
	smpsVcDetune        $03, $01, $03, $02
	smpsVcCoarseFreq    $00, $00, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $0B, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $09, $18, $05
	smpsVcDecayRate2    $05, $10, $1F, $0B
	smpsVcDecayLevel    $02, $04, $02, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $03, $8C, $0D

