Sound_91_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_91_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_91_FM5,	$00, $00

; FM5 Data
Sound_91_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $0C, $01
	dc.b	nG0, $06

Sound_91_Loop00:
	dc.b	nC0, $0E
	smpsFMAlterVol      $0D
	smpsLoop            $00, $06, Sound_91_Loop00
	smpsStop

Sound_91_Voices:
;	Voice $00
;	$FA
;	$1F, $30, $00, $32, 	$13, $1F, $1F, $1F, 	$12, $0E, $11, $04
;	$1B, $13, $09, $13, 	$1F, $1F, $4F, $2F, 	$0E, $80, $05, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $03
	smpsVcDetune        $03, $00, $03, $01
	smpsVcCoarseFreq    $02, $00, $00, $0F
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $13
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $04, $11, $0E, $12
	smpsVcDecayRate2    $13, $09, $13, $1B
	smpsVcDecayLevel    $02, $04, $01, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $05, $80, $0E

