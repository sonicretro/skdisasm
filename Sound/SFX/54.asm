Sound_54_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_54_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cFM3, Sound_54_FM3,	$00, $03
	smpsHeaderSFXChannel cPSG3, Sound_54_PSG3,	$00, $00

; FM3 Data
Sound_54_FM3:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $FA, $00
	dc.b	nC1, $50
	smpsStop

; PSG3 Data
Sound_54_PSG3:
	smpsPSGform         $E7
	smpsPSGvoice        sTone_0D
	dc.b	nEb5, $08

Sound_54_Loop00:
	dc.b	smpsNoAttack, $08
	smpsPSGAlterVol     $01
	smpsLoop            $00, $0A, Sound_54_Loop00
	smpsStop

Sound_54_Voices:
;	Voice $00
;	$38
;	$01, $33, $33, $02, 	$1F, $1F, $1F, $1F, 	$11, $00, $10, $00
;	$00, $00, $00, $06, 	$FF, $0F, $1F, $0F, 	$00, $13, $10, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $03, $03, $00
	smpsVcCoarseFreq    $02, $03, $03, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $10, $00, $11
	smpsVcDecayRate2    $06, $00, $00, $00
	smpsVcDecayLevel    $00, $01, $00, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $10, $13, $00

