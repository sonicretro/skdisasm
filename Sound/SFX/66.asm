Sound_66_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_66_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $04

	smpsHeaderSFXChannel cFM3, Sound_66_FM3,	$F4, $00
	smpsHeaderSFXChannel cFM4, Sound_66_FM4,	$F7, $00
	smpsHeaderSFXChannel cFM5, Sound_66_FM5,	$F9, $00
	smpsHeaderSFXChannel cPSG3, Sound_66_PSG3,	$00, $00

; FM3 Data
Sound_66_FM3:
; FM4 Data
Sound_66_FM4:
; FM5 Data
Sound_66_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $0B, $01
	dc.b	nC4, $18

Sound_66_Loop00:
	dc.b	smpsNoAttack, $03
	smpsFMAlterVol      $01
	smpsLoop            $00, $19, Sound_66_Loop00
	smpsStop

; PSG3 Data
Sound_66_PSG3:
	smpsPSGform         $E7
	smpsPSGvoice        sTone_1D
	dc.b	nMaxPSG1, $30
	smpsStop

Sound_66_Voices:
;	Voice $00
;	$00
;	$31, $0F, $00, $31, 	$1F, $1F, $1F, $10, 	$00, $00, $06, $00
;	$00, $00, $00, $07, 	$0F, $0F, $4F, $0F, 	$10, $13, $14, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $00, $00, $03
	smpsVcCoarseFreq    $01, $00, $0F, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $10, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $06, $00, $00
	smpsVcDecayRate2    $07, $00, $00, $00
	smpsVcDecayLevel    $00, $04, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $14, $13, $10

