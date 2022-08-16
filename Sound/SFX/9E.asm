Sound_9E_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_9E_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cPSG3, Sound_9E_PSG3,	$00, $04
	smpsHeaderSFXChannel cFM5, Sound_9E_FM5,	$00, $01

; PSG3 Data
Sound_9E_PSG3:
	smpsPSGvoice        sTone_15
	smpsPSGform         $E7
	dc.b	nF5, $05, nA5, $05, smpsNoAttack

Sound_9E_Loop00:
	dc.b	$07
	smpsPSGAlterVol     $01
	dc.b	smpsNoAttack
	smpsLoop            $00, $0F, Sound_9E_Loop00
	smpsStop

; FM5 Data
Sound_9E_FM5:
	smpsSetvoice        $00
	dc.b	nG1, $1C
	smpsStop

Sound_9E_Voices:
;	Voice $00
;	$52
;	$ED, $F3, $13, $F1, 	$1F, $1F, $1F, $1F, 	$03, $11, $0E, $0F
;	$01, $00, $0A, $0D, 	$FF, $FF, $FF, $FF, 	$22, $17, $07, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $02
	smpsVcUnusedBits    $01
	smpsVcDetune        $0F, $01, $0F, $0E
	smpsVcCoarseFreq    $01, $03, $03, $0D
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0F, $0E, $11, $03
	smpsVcDecayRate2    $0D, $0A, $00, $01
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $07, $17, $22

