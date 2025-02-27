Sound_46_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_46_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_46_FM5,	$00, $00

; FM5 Data
Sound_46_FM5:
	smpsSetvoice        $00
	smpsModSet          $05, $01, $1B, $37
	dc.b	nC5, $30
	smpsStop

Sound_46_Voices:
;	Voice $00
;	$07
;	$03, $13, $23, $33, 	$0F, $0F, $0F, $0F, 	$00, $00, $00, $00
;	$0B, $0B, $0A, $0C, 	$0F, $0F, $0F, $0F, 	$80, $80, $80, $80
	smpsVcAlgorithm     $07
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $02, $01, $00
	smpsVcCoarseFreq    $03, $03, $03, $03
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0F, $0F, $0F, $0F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $0C, $0A, $0B, $0B
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $00

