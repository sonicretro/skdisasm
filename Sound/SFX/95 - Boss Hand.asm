Sound_95_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_95_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_95_FM5,	$00, $02

; FM5 Data
Sound_95_FM5:
	smpsSetvoice        $00
	dc.b	nBb0, $13
	smpsFMAlterVol      $14
	smpsLoop            $00, $02, Sound_95_FM5
	smpsStop

Sound_95_Voices:
;	Voice $00
;	$FA
;	$00, $02, $00, $00, 	$19, $0C, $1F, $1F, 	$00, $00, $00, $00
;	$10, $10, $10, $00, 	$FF, $FF, $FF, $FF, 	$64, $25, $05, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $03
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $02, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $0C, $19
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $10, $10, $10
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $05, $25, $64

