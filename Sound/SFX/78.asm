Sound_78_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_78_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_78_FM5,	$E6, $06

; FM5 Data
Sound_78_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $19, $02
	dc.b	nE5, $2C
	smpsStop

Sound_78_Voices:
;	Voice $00
;	$01
;	$70, $30, $00, $12, 	$1F, $1F, $1F, $1F, 	$1F, $0B, $07, $01
;	$08, $01, $09, $01, 	$CF, $1F, $FF, $FF, 	$04, $03, $02, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $00, $03, $07
	smpsVcCoarseFreq    $02, $00, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $07, $0B, $1F
	smpsVcDecayRate2    $01, $09, $01, $08
	smpsVcDecayLevel    $0F, $0F, $01, $0C
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $02, $03, $04

