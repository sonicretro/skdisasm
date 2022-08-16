Sound_8B_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_8B_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_8B_FM5,	$F4, $00

; FM5 Data
Sound_8B_FM5:
	smpsSetvoice        $00
	smpsModSet          $03, $01, $7F, $03
	dc.b	nBb3, $05

Sound_8B_Loop00:
	dc.b	nF5, $0B
	smpsFMAlterVol      $17
	smpsLoop            $00, $03, Sound_8B_Loop00
	smpsStop

Sound_8B_Voices:
;	Voice $00
;	$20
;	$20, $68, $30, $33, 	$1F, $1F, $1F, $1F, 	$15, $15, $15, $13
;	$13, $0C, $0D, $10, 	$2F, $2F, $3F, $2F, 	$3C, $1B, $24, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $04
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $06, $02
	smpsVcCoarseFreq    $03, $00, $08, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $13, $15, $15, $15
	smpsVcDecayRate2    $10, $0D, $0C, $13
	smpsVcDecayLevel    $02, $03, $02, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $24, $1B, $3C

