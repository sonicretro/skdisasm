Sound_79_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_79_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cFM5, Sound_79_FM5,	$B6, $08
	smpsHeaderSFXChannel cPSG3, Sound_79_PSG3,	$00, $00

; FM5 Data
Sound_79_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $FA, $84
	dc.b	nE5, $07
	smpsLoop            $00, $07, Sound_79_FM5
	smpsStop

; PSG3 Data
Sound_79_PSG3:
	smpsModSet          $01, $01, $F0, $08
	smpsPSGform         $E7
	dc.b	nEb4, $08

Sound_79_Loop00:
	dc.b	nB3, $05
	smpsPSGAlterVol     $01
	smpsLoop            $00, $18, Sound_79_Loop00
	smpsStop

Sound_79_Voices:
;	Voice $00
;	$F9
;	$21, $30, $10, $32, 	$1F, $1F, $1F, $1F, 	$05, $18, $09, $02
;	$0B, $1F, $10, $05, 	$1F, $2F, $4F, $2F, 	$0E, $07, $04, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $07
	smpsVcUnusedBits    $03
	smpsVcDetune        $03, $01, $03, $02
	smpsVcCoarseFreq    $02, $00, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $09, $18, $05
	smpsVcDecayRate2    $05, $10, $1F, $0B
	smpsVcDecayLevel    $02, $04, $02, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $04, $07, $0E

