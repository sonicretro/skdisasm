Sound_8F_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_8F_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_8F_FM5,	$00, $04

; FM5 Data
Sound_8F_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $C9, $F9
	dc.b	nG2, $05

Sound_8F_Loop00:
	dc.b	nC0, $04
	smpsAlterPitch      $01
	smpsLoop            $00, $0B, Sound_8F_Loop00
	smpsStop

Sound_8F_Voices:
;	Voice $00
;	$F8
;	$10, $30, $05, $30, 	$16, $1D, $1A, $1B, 	$12, $0E, $11, $04
;	$11, $13, $09, $13, 	$1F, $1F, $4F, $2F, 	$5D, $80, $05, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $03
	smpsVcDetune        $03, $00, $03, $01
	smpsVcCoarseFreq    $00, $05, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1B, $1A, $1D, $16
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $04, $11, $0E, $12
	smpsVcDecayRate2    $13, $09, $13, $11
	smpsVcDecayLevel    $02, $04, $01, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $05, $80, $5D

