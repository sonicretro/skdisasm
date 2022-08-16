Sound_CB_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_6F_CB_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cFM3, Sound_6F_CB_FM3,	$00, $06
	smpsHeaderSFXChannel cFM4, Sound_6F_CB_FM4,	$00, $06

; FM3 Data
Sound_6F_CB_FM3:
	smpsSetvoice        $00
	dc.b	nBb0, $05

; FM4 Data
Sound_6F_CB_FM4:
	smpsSetvoice        $00

Sound_6F_CB_Loop00:
	dc.b	nAb0, $09, nBb0, $07, nAb0, $09, nBb0, $07
	smpsContinuousLoop  Sound_6F_CB_Loop00
	smpsStop

Sound_6F_CB_Voices:
;	Voice $00
;	$FA
;	$21, $30, $10, $32, 	$1F, $0F, $1F, $1F, 	$05, $18, $09, $02
;	$06, $0F, $06, $02, 	$1F, $07, $4F, $2F, 	$0F, $0E, $0E, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $03
	smpsVcDetune        $03, $01, $03, $02
	smpsVcCoarseFreq    $02, $00, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $0F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $09, $18, $05
	smpsVcDecayRate2    $02, $06, $0F, $06
	smpsVcDecayLevel    $02, $04, $00, $01
	smpsVcReleaseRate   $0F, $0F, $07, $0F
	smpsVcTotalLevel    $00, $0E, $0E, $0F

