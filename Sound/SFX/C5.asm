Sound_C5_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_C5_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM3, Sound_C5_FM3,	$00, $00

; FM3 Data
Sound_C5_FM3:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $1C, $01
	dc.b	nFs4, $26, smpsNoAttack
	smpsModSet          $00, $00, $00, $00

Sound_C5_Loop00:
	dc.b	$16, smpsNoAttack
	smpsContinuousLoop  Sound_C5_Loop00
	dc.b	$01
	smpsStop

Sound_C5_Voices:
;	Voice $00
;	$34
;	$0B, $0F, $06, $03, 	$1F, $1F, $1F, $0F, 	$00, $00, $0C, $00
;	$00, $08, $00, $09, 	$FF, $0F, $FF, $0F, 	$08, $86, $08, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $03, $06, $0F, $0B
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $0C, $00, $00
	smpsVcDecayRate2    $09, $00, $08, $00
	smpsVcDecayLevel    $00, $0F, $00, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $08, $06, $08

