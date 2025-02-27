Sound_86_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_86_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_86_FM5,	$D0, $06

; FM5 Data
Sound_86_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $09, $F6
	dc.b	nC0, $37
	smpsStop

Sound_86_Voices:
;	Voice $00
;	$E4
;	$1F, $31, $16, $30, 	$14, $1A, $1F, $1F, 	$00, $01, $09, $02
;	$01, $05, $03, $05, 	$14, $0F, $0F, $0F, 	$0D, $8C, $03, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $04
	smpsVcUnusedBits    $03
	smpsVcDetune        $03, $01, $03, $01
	smpsVcCoarseFreq    $00, $06, $01, $0F
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1A, $14
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $09, $01, $00
	smpsVcDecayRate2    $05, $03, $05, $01
	smpsVcDecayLevel    $00, $00, $00, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $04
	smpsVcTotalLevel    $00, $03, $0C, $0D

