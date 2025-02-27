Sound_90_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_90_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_90_FM5,	$00, $03

; FM5 Data
Sound_90_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $0C, $01

Sound_90_Loop00:
	dc.b	nC0, $0B
	smpsLoop            $00, $02, Sound_90_Loop00
	smpsStop

Sound_90_Voices:
;	Voice $00
;	$FA
;	$20, $30, $11, $30, 	$0C, $11, $1F, $1F, 	$12, $0E, $11, $04
;	$1B, $13, $09, $13, 	$1F, $1F, $4F, $2F, 	$0E, $80, $05, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $03
	smpsVcDetune        $03, $01, $03, $02
	smpsVcCoarseFreq    $00, $01, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $11, $0C
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $04, $11, $0E, $12
	smpsVcDecayRate2    $13, $09, $13, $1B
	smpsVcDecayLevel    $02, $04, $01, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $05, $80, $0E

