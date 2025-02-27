Sound_A3_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_A3_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_A3_FM5,	$E5, $06

; FM5 Data
Sound_A3_FM5:
	smpsSetvoice        $00
	smpsModSet          $02, $01, $06, $D7
	dc.b	nD0, $64
	smpsStop

Sound_A3_Voices:
;	Voice $00
;	$EB
;	$1F, $77, $D0, $11, 	$1C, $0B, $0F, $0F, 	$00, $00, $00, $00
;	$00, $00, $00, $03, 	$D2, $00, $03, $17, 	$13, $30, $A0, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $05
	smpsVcUnusedBits    $03
	smpsVcDetune        $01, $0D, $07, $01
	smpsVcCoarseFreq    $01, $00, $07, $0F
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0F, $0F, $0B, $1C
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $03, $00, $00, $00
	smpsVcDecayLevel    $01, $00, $00, $0D
	smpsVcReleaseRate   $07, $03, $00, $02
	smpsVcTotalLevel    $00, $A0, $30, $13

