Snd_S3_1UP_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_S3_1UP_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $02, $05

	smpsHeaderDAC       Snd_S3_1UP_DAC
	smpsHeaderFM        Snd_S3_1UP_FM1,	$0C, $08
	smpsHeaderFM        Snd_S3_1UP_FM2,	$0C, $19
	smpsHeaderFM        Snd_S3_1UP_FM3,	$00, $0D
	smpsHeaderFM        Snd_S3_1UP_FM4,	$18, $1B
	smpsHeaderFM        Snd_S3_1UP_FM5,	$0C, $12
	smpsHeaderPSG       Snd_S3_1UP_PSG1,	$00, $01, $00, $00
	smpsHeaderPSG       Snd_S3_1UP_PSG2,	$00, $01, $00, $00
	smpsHeaderPSG       Snd_S3_1UP_PSG3,	$00, $00, $00, $00

; FM1 Data
Snd_S3_1UP_FM1:
	smpsSetvoice        $01
	smpsModSet          $14, $01, $06, $06
	dc.b	nB3, $03, nRst, nB3, $06, nC4, $03, nRst, nC4, $06, nD4, $03
	dc.b	smpsNoAttack, nEb4, $02, smpsNoAttack, nE4, $02, smpsNoAttack, nF4, $02, smpsNoAttack, nFs4, $09
	dc.b	nD4, $06, nG4, $03, nRst, nG4, $02, nRst, $01, nG4, $02, nRst
	dc.b	$01, nG4, $04, nRst, $02, nG4, $04, nRst, $02, nG4, $0C, nRst
	dc.b	$01
	smpsStop

; FM2 Data
Snd_S3_1UP_FM2:
	smpsSetvoice        $03
	smpsModSet          $15, $01, $06, $06
	dc.b	nRst, $01
	smpsAlterNote       $03
	dc.b	nG3, $03, nRst, nG3, $06, nA3, $03, nRst, nA3, $06, nB3, $09
	dc.b	nRst, $03, nA3, $09, nRst, $03, nG3, $03, nRst, nG3, $02, nRst
	dc.b	$01, nG3, $02, nRst, $01, nG3, $04, nRst, $02, nG3, $04, nRst
	dc.b	$02, nG3, $0C, nRst, $01
	smpsStop

; FM3 Data
Snd_S3_1UP_FM3:
	smpsSetvoice        $00
	dc.b	nG2, $02, nRst, $01, nRst, $03, nG3, $02, nRst, $01, nG3, $02
	dc.b	nRst, $01, nA2, $02, nRst, $01, nRst, $03, nA3, $02, nRst, $01
	dc.b	nA3, $02, nRst, $01, nB2, $02, nRst, $01, nRst, $03, nB3, $02
	dc.b	nRst, $01, nB3, $02, nRst, $01, nA2, $02, nRst, $01, nRst, $03
	dc.b	nA3, $02, nRst, $01, nA3, $02, nRst, $01, nG2, $05, nRst, $01
	dc.b	nD2, $05, nRst, $01, nG2, $05, nRst, $01, nD2, $05, nRst, $01
	dc.b	nG2, $0C
	smpsStop

; FM4 Data
Snd_S3_1UP_FM4:
	smpsSetvoice        $03
	dc.b	nG4, $03, nF4, nD4, nF4, nG4, $03, nF4, nD4, nF4, nG4, $03
	dc.b	nF4, nD4, nF4, nA4, $03, nG4, nE4, nG4, nG4, $01, smpsNoAttack, nAb4
	dc.b	smpsNoAttack, nA4, smpsNoAttack, nBb4, smpsNoAttack, nB4, smpsNoAttack, nC5, smpsNoAttack, nCs5, smpsNoAttack, nD5
	dc.b	smpsNoAttack, nEb5, smpsNoAttack, nE5, smpsNoAttack, nF5, smpsNoAttack, nFs5, smpsNoAttack, nG5, smpsNoAttack, nFs5
	dc.b	smpsNoAttack, nF5, smpsNoAttack, nE5, smpsNoAttack, nEb5, smpsNoAttack, nD5, smpsNoAttack, nCs5, smpsNoAttack, nC5
	dc.b	smpsNoAttack, nB4, smpsNoAttack, nBb4, smpsNoAttack, nA4, smpsNoAttack, nAb4, smpsNoAttack, nG4, $0C, nRst
	dc.b	$01
	smpsStop

; FM5 Data
Snd_S3_1UP_FM5:
	dc.b	nRst, $02
	smpsJump            Snd_S3_1UP_FM1

; Unreachable
	smpsStop

; PSG1 Data
Snd_S3_1UP_PSG1:
	smpsPSGvoice        sTone_0A
	dc.b	nG3, $18, nA3, $18, nB3, $24
	smpsStop

; PSG2 Data
Snd_S3_1UP_PSG2:
	smpsPSGvoice        sTone_0A
	dc.b	nD4, $18, nFs4, $18, nG4, $24
	smpsStop

; PSG3 Data
Snd_S3_1UP_PSG3:
	smpsPSGform         $E7
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2, $03, nMaxPSG2
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG2, $03, nMaxPSG2
	smpsPSGAlterVol     $04
	dc.b	nMaxPSG2, $03, nMaxPSG2
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG2, $03, nMaxPSG2
	smpsPSGAlterVol     $04
	dc.b	nMaxPSG2, $03, nMaxPSG2
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG2, $03, nMaxPSG2
	smpsPSGAlterVol     $04
	dc.b	nMaxPSG2, $03, nMaxPSG2
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG2, $03, nMaxPSG2
	smpsPSGAlterVol     $04
	dc.b	nMaxPSG2, $03, nMaxPSG2
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG2, $03, nMaxPSG2
	smpsPSGAlterVol     $04
	dc.b	nMaxPSG2, $03, nMaxPSG2
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG2, $03, nMaxPSG2
	smpsPSGAlterVol     $04
	dc.b	nMaxPSG2, $0C
	smpsStop

; DAC Data
Snd_S3_1UP_DAC:
	dc.b	nRst, $30, dHiTimpaniS3, $06, dLowTimpaniS3, dHiTimpaniS3, dLowTimpaniS3, dHiTimpaniS3, $0C, nRst
	smpsFade
	smpsStop

Snd_S3_1UP_Voices:
;	Voice $00
;	$3B
;	$0D, $01, $00, $00, 	$9F, $1F, $1F, $1F, 	$0E, $0D, $09, $09
;	$00, $00, $00, $00, 	$DF, $DF, $DF, $DF, 	$33, $15, $17, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $01, $0D
	smpsVcRateScale     $00, $00, $00, $02
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $09, $09, $0D, $0E
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0D, $0D, $0D, $0D
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $17, $15, $33

;	Voice $01
;	$3A
;	$01, $07, $01, $01, 	$8E, $8E, $8D, $53, 	$0E, $0E, $0E, $03
;	$00, $00, $00, $07, 	$1F, $FF, $1F, $0F, 	$18, $28, $27, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $07, $01
	smpsVcRateScale     $01, $02, $02, $02
	smpsVcAttackRate    $13, $0D, $0E, $0E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $0E, $0E, $0E
	smpsVcDecayRate2    $07, $00, $00, $00
	smpsVcDecayLevel    $00, $01, $0F, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $27, $28, $18

;	Voice $02
;	$3C
;	$01, $02, $0F, $04, 	$8D, $52, $9F, $1F, 	$09, $00, $00, $0D
;	$00, $00, $00, $00, 	$23, $08, $02, $F7, 	$15, $80, $1D, $87
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $04, $0F, $02, $01
	smpsVcRateScale     $00, $02, $01, $02
	smpsVcAttackRate    $1F, $1F, $12, $0D
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0D, $00, $00, $09
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $00, $00, $02
	smpsVcReleaseRate   $07, $02, $08, $03
	smpsVcTotalLevel    $07, $1D, $00, $15

;	Voice $03
;	$3D
;	$01, $01, $01, $01, 	$94, $19, $19, $19, 	$0F, $0D, $0D, $0D
;	$07, $04, $04, $04, 	$25, $1A, $1A, $1A, 	$15, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $02
	smpsVcAttackRate    $19, $19, $19, $14
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0D, $0D, $0D, $0F
	smpsVcDecayRate2    $04, $04, $04, $07
	smpsVcDecayLevel    $01, $01, $01, $02
	smpsVcReleaseRate   $0A, $0A, $0A, $05
	smpsVcTotalLevel    $00, $00, $00, $15

