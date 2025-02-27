Sound_B4_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_B4_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_B4_FM5,	$00, $00

; FM5 Data
Sound_B4_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $0C, $01
	dc.b	nC0, $1A
	smpsStop

Sound_B4_Voices:
;	Voice $00
;	$39
;	$21, $30, $10, $31, 	$1F, $1F, $1F, $1F, 	$05, $18, $09, $00
;	$0B, $1F, $10, $0F, 	$1F, $2F, $4F, $0F, 	$0E, $07, $04, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $01, $03, $02
	smpsVcCoarseFreq    $01, $00, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $09, $18, $05
	smpsVcDecayRate2    $0F, $10, $1F, $0B
	smpsVcDecayLevel    $00, $04, $02, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $04, $07, $0E

