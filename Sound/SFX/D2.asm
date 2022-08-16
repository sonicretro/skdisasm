Sound_D2_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_D2_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM3, Sound_D2_FM3,	$F2, $05

; FM3 Data
Sound_D2_FM3:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $EB, $16

Sound_D2_Loop00:
	dc.b	nBb5, $05, nG5, $03, nBb5, $05, nG5, $03
	smpsContinuousLoop  Sound_D2_Loop00
	smpsStop

Sound_D2_Voices:
;	Voice $00
;	$11
;	$0F, $0F, $0B, $0F, 	$5F, $5F, $5F, $5F, 	$1C, $1A, $13, $12
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$14, $28, $2A, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $02
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $0F, $0B, $0F, $0F
	smpsVcRateScale     $01, $01, $01, $01
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $12, $13, $1A, $1C
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $2A, $28, $14

