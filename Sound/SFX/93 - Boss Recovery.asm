Sound_93_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_93_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cFM5, Sound_93_FM5,	$00, $0B
	smpsHeaderSFXChannel cFM4, Sound_93_FM4,	$00, $0C

; FM5 Data
Sound_93_FM5:
	dc.b	nRst, $04

; FM4 Data
Sound_93_FM4:
	smpsSetvoice        $00
	smpsModSet          $02, $01, $22, $B1

Sound_93_Loop00:
	dc.b	nC1, $06, nD1, nE1, nFs1
	smpsAlterPitch      $06
	smpsFMAlterVol      $FE
	smpsLoop            $00, $04, Sound_93_Loop00

Sound_93_Loop01:
	dc.b	nC1, $06
	smpsFMAlterVol      $05
	smpsLoop            $00, $05, Sound_93_Loop01
	smpsStop

Sound_93_Voices:
;	Voice $00
;	$F6
;	$11, $00, $03, $03, 	$1F, $1F, $1F, $1F, 	$10, $0C, $0C, $0C
;	$0B, $1F, $10, $05, 	$1F, $2F, $4F, $2F, 	$09, $84, $92, $8E
	smpsVcAlgorithm     $06
	smpsVcFeedback      $06
	smpsVcUnusedBits    $03
	smpsVcDetune        $00, $00, $00, $01
	smpsVcCoarseFreq    $03, $03, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0C, $0C, $0C, $10
	smpsVcDecayRate2    $05, $10, $1F, $0B
	smpsVcDecayLevel    $02, $04, $02, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0E, $12, $04, $09

