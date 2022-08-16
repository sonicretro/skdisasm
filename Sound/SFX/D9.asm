Sound_D9_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_D9_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM3, Sound_D9_FM3,	$D3, $09

; FM3 Data
Sound_D9_FM3:
	smpsSetvoice        $00
	smpsModSet          $03, $01, $0D, $01

Sound_D9_Loop00:
	dc.b	nC0, $16
	smpsContinuousLoop  Sound_D9_Loop00
	smpsStop

Sound_D9_Voices:
;	Voice $00
;	$FB
;	$21, $30, $21, $31, 	$0A, $14, $13, $0F, 	$05, $18, $09, $02
;	$0B, $1F, $10, $05, 	$1F, $2F, $4F, $2F, 	$1B, $17, $04, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $03
	smpsVcDetune        $03, $02, $03, $02
	smpsVcCoarseFreq    $01, $01, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0F, $13, $14, $0A
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $09, $18, $05
	smpsVcDecayRate2    $05, $10, $1F, $0B
	smpsVcDecayLevel    $02, $04, $02, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $04, $17, $1B

