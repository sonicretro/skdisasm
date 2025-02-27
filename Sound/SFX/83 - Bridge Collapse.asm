Sound_83_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_83_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $03

	smpsHeaderSFXChannel cFM5, Sound_83_FM5,	$00, $03
	smpsHeaderSFXChannel cFM4, Sound_83_FM4,	$DF, $00
	smpsHeaderSFXChannel cPSG3, Sound_83_PSG3,	$20, $00

; FM5 Data
Sound_83_FM5:
	dc.b	nRst, $03

; FM4 Data
Sound_83_FM4:
	smpsSetvoice        $00
	smpsModSet          $03, $01, $36, $06
	dc.b	nD0, $22
	smpsStop

; PSG3 Data
Sound_83_PSG3:
	smpsPSGform         $E7
	smpsModSet          $02, $01, $09, $28

Sound_83_Loop00:
	dc.b	nC4, $0F
	smpsPSGAlterVol     $0B
	smpsLoop            $00, $03, Sound_83_Loop00
	smpsStop

Sound_83_Voices:
;	Voice $00
;	$31
;	$4B, $F2, $00, $04, 	$0F, $0F, $1F, $1F, 	$0B, $03, $07, $0A
;	$10, $0B, $16, $0A, 	$FF, $0F, $FF, $0F, 	$50, $07, $10, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $0F, $04
	smpsVcCoarseFreq    $04, $00, $02, $0B
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $0F, $0F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $07, $03, $0B
	smpsVcDecayRate2    $0A, $16, $0B, $10
	smpsVcDecayLevel    $00, $0F, $00, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $10, $07, $50

