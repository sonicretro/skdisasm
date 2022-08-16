Sound_51_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_51_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_51_FM5,	$00, $10

; FM5 Data
Sound_51_FM5:
	smpsSetvoice        $00

Sound_51_Loop00:
	dc.b	nCs3, $03
	smpsAlterPitch      $FF
	smpsFMAlterVol      $02
	smpsLoop            $00, $10, Sound_51_Loop00
	smpsStop

Sound_51_Voices:
;	Voice $00
;	$06
;	$00, $09, $09, $09, 	$1F, $0D, $0D, $0D, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$20, $80, $80, $80
	smpsVcAlgorithm     $06
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $09, $09, $09, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0D, $0D, $0D, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $20

