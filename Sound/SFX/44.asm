Sound_44_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_44_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_44_FM5,	$EE, $00

; FM5 Data
Sound_44_FM5:
	smpsSetvoice        $00
	smpsModSet          $03, $01, $32, $2B
	dc.b	nB2, $20
	smpsStop

Sound_44_Voices:
;	Voice $00
;	$04
;	$02, $01, $22, $21, 	$1F, $1F, $1F, $1F, 	$0B, $00, $0B, $00
;	$00, $0E, $00, $0E, 	$FF, $0F, $FF, $0F, 	$14, $80, $14, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $02, $02, $00, $00
	smpsVcCoarseFreq    $01, $02, $01, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $0B, $00, $0B
	smpsVcDecayRate2    $0E, $00, $0E, $00
	smpsVcDecayLevel    $00, $0F, $00, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $14, $00, $14

