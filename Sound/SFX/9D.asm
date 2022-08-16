Sound_9D_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_9D_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_9D_FM5,	$2C, $0B

; FM5 Data
Sound_9D_FM5:
	smpsSetvoice        $00
	smpsModSet          $01, $01, $36, $95
	dc.b	nFs2, $10

Sound_9D_Loop00:
	dc.b	nC3, $10
	smpsLoop            $00, $07, Sound_9D_Loop00
	smpsStop

Sound_9D_Voices:
;	Voice $00
;	$1C
;	$31, $D7, $01, $00, 	$10, $DB, $17, $15, 	$02, $0D, $0F, $0A
;	$1C, $12, $0E, $13, 	$8F, $00, $00, $12, 	$08, $80, $10, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $03
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $0D, $03
	smpsVcCoarseFreq    $00, $01, $07, $01
	smpsVcRateScale     $00, $00, $03, $00
	smpsVcAttackRate    $15, $17, $1B, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $0F, $0D, $02
	smpsVcDecayRate2    $13, $0E, $12, $1C
	smpsVcDecayLevel    $01, $00, $00, $08
	smpsVcReleaseRate   $02, $00, $00, $0F
	smpsVcTotalLevel    $00, $10, $00, $08

