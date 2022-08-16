Sound_92_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_92_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_92_FM5,	$00, $06

; FM5 Data
Sound_92_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $0C, $01

Sound_92_Loop00:
	dc.b	nC0, $0E
	smpsFMAlterVol      $12
	smpsLoop            $00, $04, Sound_92_Loop00
	smpsStop

Sound_92_Voices:
;	Voice $00
;	$F3
;	$26, $20, $1B, $30, 	$1F, $1F, $1F, $1F, 	$12, $11, $04, $02
;	$0B, $0E, $0B, $16, 	$0F, $0F, $0F, $2F, 	$7B, $19, $15, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $06
	smpsVcUnusedBits    $03
	smpsVcDetune        $03, $01, $02, $02
	smpsVcCoarseFreq    $00, $0B, $00, $06
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $04, $11, $12
	smpsVcDecayRate2    $16, $0B, $0E, $0B
	smpsVcDecayLevel    $02, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $15, $19, $7B

