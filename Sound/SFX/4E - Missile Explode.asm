Sound_4E_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_4E_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cPSG3, Sound_4E_PSG3,	$00, $00
	smpsHeaderSFXChannel cFM5, Sound_4E_FM5,	$00, $10

; PSG3 Data
Sound_4E_PSG3:
	smpsPSGform         $E7
	dc.b	nMaxPSG1, $06

Sound_4E_Loop00:
	dc.b	nEb6, $06
	smpsAlterPitch      $FE
	smpsLoop            $00, $08, Sound_4E_Loop00

Sound_4E_Loop01:
	dc.b	nEb6
	smpsPSGAlterVol     $01
	smpsLoop            $00, $0E, Sound_4E_Loop01
	smpsStop

; FM5 Data
Sound_4E_FM5:
	smpsSetvoice        $00
	dc.b	nC2, $68
	smpsStop

Sound_4E_Voices:
;	Voice $00
;	$3D
;	$00, $10, $20, $00, 	$1F, $1F, $1F, $1F, 	$09, $00, $00, $00
;	$00, $0C, $0A, $0A, 	$FF, $0F, $0F, $0F, 	$06, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $02, $01, $00
	smpsVcCoarseFreq    $00, $00, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $09
	smpsVcDecayRate2    $0A, $0A, $0C, $00
	smpsVcDecayLevel    $00, $00, $00, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $06

