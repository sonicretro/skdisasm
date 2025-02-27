Sound_68_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_68_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $03

	smpsHeaderSFXChannel cFM3, Sound_68_FM3,	$00, $00
	smpsHeaderSFXChannel cFM4, Sound_68_FM4,	$00, $00
	smpsHeaderSFXChannel cFM5, Sound_68_FM5,	$00, $00

; FM3 Data
Sound_68_FM3:
	smpsSetvoice        $00
	smpsAlterNote       $01
	dc.b	nC4, $12, nE4, nG4, nB4, $60
	smpsStop

; FM4 Data
Sound_68_FM4:
	smpsSetvoice        $00
	smpsAlterNote       $02
	dc.b	nRst, $06, nE4, $12, nG4, nB4, nD5, $5A
	smpsStop

; FM5 Data
Sound_68_FM5:
	smpsSetvoice        $00
	smpsAlterNote       $04
	dc.b	nRst, $0C, nG4, $12, nB4, nD5, nF5, $54
	smpsStop

Sound_68_Voices:
;	Voice $00
;	$05
;	$19, $0A, $2C, $78, 	$5F, $5F, $5F, $5F, 	$06, $00, $00, $00
;	$00, $09, $09, $0A, 	$FF, $0F, $0F, $0F, 	$20, $90, $90, $90
	smpsVcAlgorithm     $05
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $02, $00, $01
	smpsVcCoarseFreq    $08, $0C, $0A, $09
	smpsVcRateScale     $01, $01, $01, $01
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $06
	smpsVcDecayRate2    $0A, $09, $09, $00
	smpsVcDecayLevel    $00, $00, $00, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $10, $10, $10, $20

