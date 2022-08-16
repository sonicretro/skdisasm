Sound_3C_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_3C_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM4, Sound_3C_FM4,	$0C, $05

; FM4 Data
Sound_3C_FM4:
	smpsSetvoice        $00
	dc.b	nRst, $01
	smpsModSet          $03, $01, $09, $FF
	dc.b	nCs6, $25
	smpsModSet          $00, $01, $00, $00

Sound_3C_Loop00:
	dc.b	smpsNoAttack
	smpsFMAlterVol      $01
	dc.b	nCs6, $02
	smpsLoop            $00, $2A, Sound_3C_Loop00
	smpsStop

Sound_3C_Voices:
;	Voice $00
;	$3C
;	$00, $44, $02, $02, 	$1F, $1F, $1F, $15, 	$00, $1F, $00, $00
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$0D, $80, $28, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $04, $00
	smpsVcCoarseFreq    $02, $02, $04, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $15, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $1F, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $28, $00, $0D

