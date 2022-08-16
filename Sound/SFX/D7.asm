Sound_D7_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_D7_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM3, Sound_D7_FM3,	$00, $06

; FM3 Data
Sound_D7_FM3:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $CB, $16

Sound_D7_Loop00:
	dc.b	nC0, $0B, $0B
	smpsContinuousLoop  Sound_D7_Loop00
	smpsStop

Sound_D7_Voices:
;	Voice $00
;	$F9
;	$20, $30, $12, $30, 	$13, $1A, $1F, $0F, 	$05, $18, $09, $02
;	$0B, $1F, $10, $05, 	$1F, $2F, $4F, $2F, 	$0D, $8C, $03, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $07
	smpsVcUnusedBits    $03
	smpsVcDetune        $03, $01, $03, $02
	smpsVcCoarseFreq    $00, $02, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0F, $1F, $1A, $13
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $09, $18, $05
	smpsVcDecayRate2    $05, $10, $1F, $0B
	smpsVcDecayLevel    $02, $04, $02, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $03, $8C, $0D

