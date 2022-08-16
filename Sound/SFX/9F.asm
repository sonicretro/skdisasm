Sound_9F_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_9F_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cFM5, Sound_9F_FM5,	$F8, $08
	smpsHeaderSFXChannel cFM4, Sound_9F_FM4,	$F1, $0F

; FM4 Data
Sound_9F_FM4:
	dc.b	nRst, $03

; FM5 Data
Sound_9F_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $F8, $04
	dc.b	nA3, $13
	smpsFMAlterVol      $14
	smpsLoop            $00, $05, Sound_9F_FM5
	smpsStop

Sound_9F_Voices:
;	Voice $00
;	$7A
;	$1F, $1F, $04, $1F, 	$10, $1F, $18, $10, 	$10, $16, $0C, $00
;	$02, $02, $02, $02, 	$2F, $2F, $FF, $3F, 	$42, $16, $11, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $01
	smpsVcDetune        $01, $00, $01, $01
	smpsVcCoarseFreq    $0F, $04, $0F, $0F
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $10, $18, $1F, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $0C, $16, $10
	smpsVcDecayRate2    $02, $02, $02, $02
	smpsVcDecayLevel    $03, $0F, $02, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $11, $16, $42

