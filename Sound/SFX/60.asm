Sound_60_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_60_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_60_FM5,	$E7, $00

; FM5 Data
Sound_60_FM5:
	smpsSetvoice        $00

Sound_60_Loop00:
	dc.b	nC6, $01
	smpsAlterPitch      $FF
	smpsFMAlterVol      $01
	smpsLoop            $00, $06, Sound_60_Loop00
	smpsModSet          $01, $01, $03, $00
	dc.b	nC6, $50

Sound_60_Loop01:
	dc.b	smpsNoAttack, $04
	smpsFMAlterVol      $01
	smpsLoop            $00, $08, Sound_60_Loop01
	smpsStop

Sound_60_Voices:
;	Voice $00
;	$3A
;	$41, $12, $62, $52, 	$5F, $1F, $1F, $8C, 	$08, $05, $04, $1E
;	$03, $04, $02, $06, 	$2F, $2F, $1F, $0F, 	$29, $27, $1F, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $05, $06, $01, $04
	smpsVcCoarseFreq    $02, $02, $02, $01
	smpsVcRateScale     $02, $00, $00, $01
	smpsVcAttackRate    $0C, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $1E, $04, $05, $08
	smpsVcDecayRate2    $06, $02, $04, $03
	smpsVcDecayLevel    $00, $01, $02, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1F, $27, $29

