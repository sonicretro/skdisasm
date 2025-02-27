Sound_77_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_77_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cFM5, Sound_77_FM5,	$FA, $00
	smpsHeaderSFXChannel cPSG3, Sound_77_PSG3,	$04, $00

; FM5 Data
Sound_77_FM5:
	smpsSetvoice        $00
	dc.b	nA5, $04

Sound_77_Loop00:
	dc.b	nEb6, $02
	smpsFMAlterVol      $05
	smpsLoop            $00, $05, Sound_77_Loop00
	smpsStop

; PSG3 Data
Sound_77_PSG3:
	smpsModSet          $01, $01, $1B, $08
	smpsPSGform         $E7
	dc.b	(nMaxPSG1-$4)&$FF, $07

Sound_77_Loop01:
	dc.b	nE6, $05
	smpsPSGAlterVol     $02
	smpsLoop            $00, $0C, Sound_77_Loop01
	smpsStop

Sound_77_Voices:
;	Voice $00
;	$23
;	$0E, $0E, $0B, $00, 	$18, $10, $0C, $14, 	$00, $0E, $19, $10
;	$00, $0C, $00, $0F, 	$0C, $EF, $FF, $FF, 	$00, $04, $00, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $04
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $0B, $0E, $0E
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $14, $0C, $10, $18
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $10, $19, $0E, $00
	smpsVcDecayRate2    $0F, $00, $0C, $00
	smpsVcDecayLevel    $0F, $0F, $0E, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0C
	smpsVcTotalLevel    $00, $00, $04, $00

