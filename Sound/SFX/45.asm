Sound_45_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_45_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_45_FM5,	$00, $05

; FM5 Data
Sound_45_FM5:
	smpsSetvoice        $00
	dc.b	nEb3, $1B
	smpsStop

Sound_45_Voices:
;	Voice $00
;	$03
;	$32, $04, $70, $03, 	$1F, $1F, $1F, $1F, 	$00, $00, $00, $00
;	$00, $0D, $0C, $0B, 	$0F, $0F, $0F, $0F, 	$08, $0D, $10, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $07, $00, $03
	smpsVcCoarseFreq    $03, $00, $04, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $0B, $0C, $0D, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $10, $0D, $08

