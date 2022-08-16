Sound_4B_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_4B_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cFM5, Sound_4B_FM5,	$00, $06
	smpsHeaderSFXChannel cPSG3, Sound_4B_PSG3,	$00, $00

; FM5 Data
Sound_4B_FM5:
	smpsSetvoice        $00
	dc.b	nEb5, $06, smpsNoAttack, nG6, $05

Sound_4B_Loop00:
	dc.b	smpsNoAttack
	smpsFMAlterVol      $02
	dc.b	$05
	smpsLoop            $00, $0A, Sound_4B_Loop00
	smpsStop

; PSG3 Data
Sound_4B_PSG3:
	smpsPSGform         $E7
	dc.b	nBb5, $10

Sound_4B_Loop01:
	dc.b	smpsNoAttack
	smpsPSGAlterVol     $01
	smpsAlterPitch      $FF
	dc.b	$05
	smpsLoop            $00, $0A, Sound_4B_Loop01
	smpsStop

Sound_4B_Voices:
;	Voice $00
;	$00
;	$10, $0F, $10, $0F, 	$1F, $1F, $1F, $1F, 	$00, $00, $00, $00
;	$00, $00, $00, $04, 	$0F, $0F, $0F, $0F, 	$00, $00, $00, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $01, $00, $01
	smpsVcCoarseFreq    $0F, $00, $0F, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $04, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $00

