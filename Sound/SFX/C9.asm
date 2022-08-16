Sound_C9_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_C9_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM3, Sound_C9_FM3,	$FD, $00

; FM3 Data
Sound_C9_FM3:
	smpsSetvoice        $00
	smpsModSet          $02, $01, $A2, $42

Sound_C9_Loop00:
	dc.b	nCs2, $0D
	smpsFMAlterVol      $10
	dc.b	nCs2, $0D
	smpsLoop            $00, $02, Sound_C9_Loop00
	smpsFMAlterVol      $E0
	smpsContinuousLoop  Sound_C9_Loop00
	smpsStop

Sound_C9_Voices:
;	Voice $00
;	$7B
;	$21, $16, $17, $90, 	$1F, $13, $1F, $0F, 	$12, $10, $05, $12
;	$05, $02, $01, $03, 	$2F, $4F, $5F, $2F, 	$1A, $08, $1F, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $01
	smpsVcDetune        $09, $01, $01, $02
	smpsVcCoarseFreq    $00, $07, $06, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0F, $1F, $13, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $12, $05, $10, $12
	smpsVcDecayRate2    $03, $01, $02, $05
	smpsVcDecayLevel    $02, $05, $04, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1F, $08, $1A

