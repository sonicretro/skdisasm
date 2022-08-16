Sound_59_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_59_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $04

	smpsHeaderSFXChannel cFM3, Sound_59_FM3,	$10, $00
	smpsHeaderSFXChannel cFM4, Sound_59_FM4,	$00, $00
	smpsHeaderSFXChannel cFM5, Sound_59_FM5,	$10, $00
	smpsHeaderSFXChannel cPSG3, Sound_59_PSG3,	$0C, $00

; FM3 Data
Sound_59_FM3:
	smpsPan             panRight, $00
	dc.b	nRst, $02
	smpsJump            Sound_59_FM4

; FM5 Data
Sound_59_FM5:
	smpsPan             panLeft, $00
	dc.b	nRst, $01

; FM4 Data
Sound_59_FM4:
	smpsSetvoice        $00
	smpsModSet          $03, $01, $20, $04
	dc.b	nC0, $10
	smpsStop

; PSG3 Data
Sound_59_PSG3:
	smpsModSet          $01, $01, $0F, $05
	smpsPSGform         $E7

Sound_59_Loop00:
	dc.b	nB3, $18, smpsNoAttack
	smpsPSGAlterVol     $03
	smpsLoop            $00, $05, Sound_59_Loop00
	smpsStop

Sound_59_Voices:
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

