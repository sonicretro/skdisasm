Sound_6A_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_6A_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_6A_FM5,	$F2, $04

; FM5 Data
Sound_6A_FM5:
	smpsSetvoice        $00
	dc.b	nCs3

Sound_6A_Loop00:
	dc.b	$02, smpsNoAttack, nB2, $01, smpsNoAttack
	smpsAlterPitch      $02
	smpsLoop            $00, $26, Sound_6A_Loop00
	dc.b	$01
	smpsStop

Sound_6A_Voices:
;	Voice $00
;	$3B
;	$3C, $39, $30, $31, 	$DF, $1F, $1F, $DF, 	$04, $05, $04, $01
;	$04, $04, $04, $02, 	$FF, $0F, $1F, $AF, 	$29, $20, $0F, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $03, $03
	smpsVcCoarseFreq    $01, $00, $09, $0C
	smpsVcRateScale     $03, $00, $00, $03
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $04, $05, $04
	smpsVcDecayRate2    $02, $04, $04, $04
	smpsVcDecayLevel    $0A, $01, $00, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $0F, $20, $29

