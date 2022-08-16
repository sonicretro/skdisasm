Sound_B6_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_B6_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cFM5, Sound_B6_FM5,	$00, $06
	smpsHeaderSFXChannel cPSG3, Sound_B6_PSG3,	$00, $00

; FM5 Data
Sound_B6_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $C5, $1A
	dc.b	nE6, $0F
	smpsStop

; PSG3 Data
Sound_B6_PSG3:
	smpsPSGvoice        sTone_1D
	dc.b	nRst, $06
	smpsModSet          $01, $02, $05, $FF
	smpsPSGform         $E7
	dc.b	nE6, $4F
	smpsStop

Sound_B6_Voices:
;	Voice $00
;	$3D
;	$09, $03, $00, $00, 	$1F, $1F, $1F, $1F, 	$10, $0C, $0C, $0C
;	$0B, $1F, $10, $05, 	$1F, $2F, $4F, $2F, 	$09, $84, $92, $8E
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $03, $09
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0C, $0C, $0C, $10
	smpsVcDecayRate2    $05, $10, $1F, $0B
	smpsVcDecayLevel    $02, $04, $02, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0E, $12, $04, $09

