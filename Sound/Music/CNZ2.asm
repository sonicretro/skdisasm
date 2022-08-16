Snd_CNZ2_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_CNZ2_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $44

	smpsHeaderDAC       Snd_CNZ2_DAC
	smpsHeaderFM        Snd_CNZ2_FM1,	$00, $0C
	smpsHeaderFM        Snd_CNZ2_FM2,	$00, $06
	smpsHeaderFM        Snd_CNZ2_FM3,	$00, $07
	smpsHeaderFM        Snd_CNZ2_FM4,	$00, $05
	smpsHeaderFM        Snd_CNZ2_FM5,	$0C, $13
	smpsHeaderPSG       Snd_CNZ2_PSG1,	$F4, $04, $00, $00
	smpsHeaderPSG       Snd_CNZ2_PSG2,	$F4, $04, $00, $00
	smpsHeaderPSG       Snd_CNZ2_PSG3,	$23, $02, $00, $00

; FM1 Data
Snd_CNZ2_FM1:
	smpsModSet          $02, $01, $05, $04
	smpsSetvoice        $03
	dc.b	nRst, $60, smpsNoAttack, $60, nRst, $60, nRst, $48
	smpsSetvoice        $00
	smpsModSet          $0B, $01, $0C, $04
	dc.b	nC5, $13, nB4, $05
	smpsSetvoice        $00
	smpsModSet          $02, $01, $02, $04
	smpsCall            Snd_CNZ2_Call00
	smpsModSet          $11, $01, $15, $05
	dc.b	nG4, $30, nRst, $18
	smpsSetvoice        $03
	smpsModSet          $02, $01, $05, $04
	smpsCall            Snd_CNZ2_Call06
	dc.b	nRst, $48
	smpsSetvoice        $00
	smpsModSet          $0B, $01, $0C, $04
	dc.b	nC5, $13, nB4, $05
	smpsSetvoice        $00
	smpsModSet          $02, $01, $02, $04
	smpsCall            Snd_CNZ2_Call00
	smpsModSet          $11, $01, $15, $05
	dc.b	nG4, $30, nRst, $18
	smpsSetvoice        $03
	smpsModSet          $02, $01, $05, $04
	smpsCall            Snd_CNZ2_Call06
	dc.b	nRst, $0C, nEb4, $05, nRst, $1F, nC4, $05, nRst, $13, nRst, $60
	dc.b	nRst, nRst, nRst, $60, nRst, $60, nRst, nRst, nRst, $60
	smpsSetvoice        $00
	smpsModSet          $0B, $01, $0C, $04
	dc.b	nC5, $13, nB4, $05
	smpsSetvoice        $00
	smpsModSet          $02, $01, $02, $04
	smpsCall            Snd_CNZ2_Call00
	smpsModSet          $11, $01, $15, $05
	dc.b	nG4, $30, nRst, $18, nRst, $60, nRst, $48, nRst, $18
	smpsSetvoice        $04
	smpsModSet          $02, $01, $05, $04
	dc.b	nG5, $05, nRst, $07, nFs5, $05, nRst, $07, nF5, nFs5, $05, nF5
	dc.b	$07, nE5, $05, nEb5, nRst, $07, nD5, $05, nRst, $07, nCs5, nD5
	dc.b	$05, nCs5, $07, nC5, $05, nB4, nRst, $07, nBb4, $05, nRst, $07
	dc.b	nBb4, nB4, $05, nC5, $07, nCs5, $05, nD5, $24, nRst, $05, nD5
	dc.b	$07, nG5, $05, nRst, $07, nFs5, $05, nRst, $07, nF5, nFs5, $05
	dc.b	nF5, $07, nE5, $05, nEb5, nRst, $07, nD5, $05, nRst, $07, nCs5
	dc.b	nD5, $05, nCs5, $07, nC5, $05, nB4, nRst, $07, nBb4, $05, nRst
	dc.b	$07, nA4, nBb4, $05, nA4, $07, nAb4, $05, nG4, $24, nRst, $05
	dc.b	nD5, $07, nG5, nRst, $05, nFs5, $07, nRst, $05, nF5, $07, nFs5
	dc.b	$05, nF5, $07, nE5, $05, nEb5, $07, nRst, $05, nD5, $07, nRst
	dc.b	$05, nCs5, $07, nD5, $05, nCs5, $07, nC5, $05
	smpsAlterPitch      $F4
	smpsCall            Snd_CNZ2_Call02
	smpsAlterPitch      $0C
	smpsJump            Snd_CNZ2_FM1

Snd_CNZ2_Call06:
	dc.b	nE5, $05, nRst, $07, nEb5, $05, nRst, $07, nD5, nEb5, $05, nD5
	dc.b	$07, nCs5, $05, nC5, nRst, $07, nB4, $05, nRst, $07, nBb4, $0C
	dc.b	nA4, $05, nRst, $07
	smpsReturn

Snd_CNZ2_Call00:
	dc.b	nD5, $06, nRst, nC5, nRst, nB4, nRst, nC5, nRst, nG4, nRst, nA4
	dc.b	$05, nRst, $07, nC5, $0C, nB4, nG4, nRst
	smpsReturn

; Unreachable
	dc.b	nF5, $07, nE5, $05, nEb5, nRst, $07, nD5, $05, nRst, $07, nCs5
	dc.b	nD5, $05, nCs5, $07, nC5, $05
	smpsReturn

; FM2 Data
Snd_CNZ2_FM2:
	smpsSetvoice        $01

Snd_CNZ2_Loop05:
	dc.b	nC2, $0C, nRst, $18, nC2, $0C, nRst, $30
	smpsLoop            $00, $03, Snd_CNZ2_Loop05
	dc.b	nRst, $60

Snd_CNZ2_Loop06:
	dc.b	nC2, $0C, nRst, $18, nC2, $0C, nRst, $30
	smpsLoop            $00, $08, Snd_CNZ2_Loop06
	smpsCall            Snd_CNZ2_Call05
	dc.b	nG2, $06, nRst, nG2, nRst, $2A, nG2, $1E, nRst, $06, nRst, $60

Snd_CNZ2_Loop07:
	dc.b	nC2, $0C, nRst, $18, nC2, $0C, nRst, $30
	smpsLoop            $00, $07, Snd_CNZ2_Loop07
	dc.b	nC2, $0C, nRst, $18, nC2, $0C, nRst, nG1, nA1, nB1

Snd_CNZ2_Loop08:
	smpsCall            Snd_CNZ2_Call05
	smpsLoop            $00, $02, Snd_CNZ2_Loop08
	dc.b	nG2, $06, nRst, nG2, nRst, $2A, nG2, $1E, nRst, $06
	smpsCall            Snd_CNZ2_Call02
	smpsJump            Snd_CNZ2_FM2

Snd_CNZ2_Call05:
	dc.b	nG2, $06, nRst, nG2, nRst, $2A, nG2, $1E, nRst, $06, nG2, nRst
	dc.b	nG2, $2A, nRst, $06, nG2, $0C, nF2, nFs2
	smpsReturn

; FM3 Data
Snd_CNZ2_FM3:
	smpsPan             panLeft, $00
	smpsNoteFill        $06
	smpsSetvoice        $02
	dc.b	nRst, $0C, nG4, $18, nG4, nG4, nG4, $0C
	smpsLoop            $00, $03, Snd_CNZ2_FM3
	dc.b	nRst, $60, nRst, $60, nRst, nRst
	smpsNoteFill        $06
	smpsSetvoice        $02
	dc.b	nRst, $0C, nG4, $18, nG4, nG4, nG4, $0C, nRst, $60, nRst, nRst
	dc.b	nRst
	smpsNoteFill        $00
	smpsSetvoice        $03
	smpsCall            Snd_CNZ2_Call04
	dc.b	nRst, $0C, nD4, nRst, $07, nD4, $05, nRst, $0C, nD4, $05, nRst
	dc.b	$07, nRst, $24, nRst, $60, nRst, $60, nRst, nRst, nRst, nRst, nRst
	smpsNoteFill        $06
	smpsSetvoice        $02
	dc.b	nRst, $0C, nG4, $18, nG4, nG4, nG4, $0C, nRst, $0C, nG4, $18
	dc.b	nG4, nG4, nG4, $0C

Snd_CNZ2_Loop04:
	smpsNoteFill        $00
	smpsSetvoice        $03
	smpsCall            Snd_CNZ2_Call04
	smpsLoop            $00, $02, Snd_CNZ2_Loop04
	dc.b	nRst, $0C, nD4, nRst, $07, nD4, $05, nRst, $0C, nD4, $05, nRst
	dc.b	$07, nRst, $24
	smpsCall            Snd_CNZ2_Call02
	smpsJump            Snd_CNZ2_FM3

Snd_CNZ2_Call04:
	dc.b	nRst, $0C, nD4, nRst, $07, nD4, $05, nRst, $0C, nD4, $05, nRst
	dc.b	$07, nRst, $24, nRst, $0C, nG3, $0C, nRst, $07, nG3, $05, nRst
	dc.b	$0C, nG3, $05, nRst, $2B
	smpsReturn

; FM4 Data
Snd_CNZ2_FM4:
	smpsPan             panRight, $00
	smpsNoteFill        $06
	smpsSetvoice        $02
	dc.b	nC4, $0C, nE4, nG3, nE4, nC4, nE4, nG3, nE4
	smpsLoop            $00, $03, Snd_CNZ2_FM4
	dc.b	nRst, $60, nRst, $60, nRst, nRst
	smpsNoteFill        $06
	smpsSetvoice        $02
	dc.b	nC4, $0C, nE4, nG3, nE4, nC4, nE4, nG3, nE4, nRst, $60, nRst
	dc.b	nRst, nRst
	smpsNoteFill        $00
	smpsSetvoice        $03
	smpsCall            Snd_CNZ2_Call03
	dc.b	nRst, $0C, nF3, nG2, $07, nF3, $05, nRst, $07, nG2, $05, nF3
	dc.b	nRst, $13, nF3, $07, nG3, $05, nF3, $07, nC3, $05, nRst, $60
	dc.b	nRst, $60, nRst, nRst, nRst, nRst, nRst
	smpsNoteFill        $06
	smpsSetvoice        $02
	dc.b	nC4, $0C, nE4, nG3, nE4, nC4, nE4, nG3, nE4, nC4, $0C, nE4
	dc.b	nG3, nE4, nC4, nE4, nG3, nE4

Snd_CNZ2_Loop03:
	smpsNoteFill        $00
	smpsSetvoice        $03
	smpsCall            Snd_CNZ2_Call03
	smpsLoop            $00, $02, Snd_CNZ2_Loop03
	dc.b	nRst, $0C, nF3, nG2, $07, nF3, $05, nRst, $07, nG2, $05, nF3
	dc.b	nRst, $13, nF3, $07, nG3, $05, nF3, $07, nC3, $05
	smpsCall            Snd_CNZ2_Call02
	smpsJump            Snd_CNZ2_FM4

Snd_CNZ2_Call03:
	dc.b	nRst, $0C, nF3, nG2, $07, nF3, $05, nRst, $07, nG2, $05, nF3
	dc.b	nRst, $13, nF3, $07, nG3, $05, nF3, $07, nC3, $05, nC2, $05
	dc.b	nRst, $13, nC3, $05, nRst, $07, nRst, nC3, $05, nRst, $13, nG2
	dc.b	$05, nBb2, $07, nC3, $05, nBb2, $07, nG2, $05
	smpsReturn

; FM5 Data
Snd_CNZ2_FM5:
	smpsSetvoice        $03
	dc.b	nRst, $60, nRst, $60, nRst, $60, nRst, $02, nRst, $48, nC5, $13
	dc.b	nB4, $03
	smpsSetvoice        $00
	smpsModSet          $02, $01, $02, $04
	dc.b	nRst, $02
	smpsCall            Snd_CNZ2_Call00
	smpsModSet          $11, $01, $15, $05
	dc.b	nG4, $30, nRst, $16
	smpsSetvoice        $03
	dc.b	nC5, $06, nRst, nB4, nRst, nBb4, $07, nB4, $05, nBb4, $07, nA4
	dc.b	$05, nAb4, $05, nRst, $07, nG4, $05, nRst, $07, nFs4, $0C, nF4
	dc.b	$05, nRst, $07, nRst, $48
	smpsSetvoice        $00
	smpsModSet          $0B, $01, $0C, $04
	dc.b	nRst, $02, nC5, $13, nB4, $05
	smpsSetvoice        $00
	smpsModSet          $02, $01, $02, $04
	smpsCall            Snd_CNZ2_Call00
	smpsModSet          $11, $01, $15, $05
	dc.b	nG4, $30, nRst, $16
	smpsSetvoice        $03
	dc.b	nC5, $05, nRst, $07, nB4, $05, nRst, $07, nBb4, nB4, $05, nBb4
	dc.b	$07, nA4, $05, nAb4, nRst, $07, nG4, $05, nRst, $07, nFs4, $0C
	dc.b	nF4, $05, nRst, $07, nRst, $0C, nBb3, $05, nRst, $07, nF3, nG3
	dc.b	$05, nF3, nRst, $07, nG3, $05, nRst, $07, nF3, nG3, $05, nF3
	dc.b	$07, nBb3, $05, nG3, nRst, $07
	smpsCall            Snd_CNZ2_Call01
	dc.b	nRst, $0C, nA3, $0C, nRst, $07, nA3, $05, nRst, $0C, nA3, $05
	dc.b	nRst, $2B, nRst, $60
	smpsSetvoice        $00
	dc.b	nRst, $60, nRst, nRst, nRst, $48
	smpsSetvoice        $00
	smpsModSet          $0B, $01, $0C, $04
	dc.b	nRst, $02, nC5, $13, nB4, $05
	smpsSetvoice        $00
	smpsModSet          $02, $01, $02, $04
	smpsCall            Snd_CNZ2_Call00
	smpsModSet          $11, $01, $15, $05
	dc.b	nG4, $30, nRst, $16
	smpsSetvoice        $03
	dc.b	nRst, $60, nRst

Snd_CNZ2_Loop02:
	smpsCall            Snd_CNZ2_Call01
	smpsLoop            $00, $02, Snd_CNZ2_Loop02
	dc.b	nRst, $0C, nA3, $0C, nRst, $07, nA3, $05, nRst, $0C, nA3, $05
	dc.b	nRst, $2B
	smpsCall            Snd_CNZ2_Call02
	smpsJump            Snd_CNZ2_FM5

Snd_CNZ2_Call01:
	dc.b	nRst, $0C, nA3, $0C, nRst, $07, nA3, $05, nRst, $3C, nRst, $0C
	dc.b	nF3, $0C, nRst, $07, nF3, $05, nRst, $0C, nE3, $05, nRst, $2B
	smpsReturn

; PSG1 Data
Snd_CNZ2_PSG1:
	smpsNoteFill        $06
	smpsPSGvoice        sTone_05
	smpsModChange       $02
	dc.b	nRst, $0C, nG4, $18, nG4, nG4, nG4, $0C
	smpsLoop            $00, $03, Snd_CNZ2_PSG1
	dc.b	nRst, $60, nRst, $60, nRst, nRst, nRst, $0C
	smpsNoteFill        $06
	smpsPSGvoice        sTone_05
	dc.b	nG4, $18, nG4, nG4, nG4, $0C, nRst, $60, nRst, nRst, nRst
	smpsNoteFill        $00
	smpsPSGvoice        sTone_04
	smpsCall            Snd_CNZ2_Call04
	dc.b	nRst, $0C, nD4, nRst, $07, nD4, $05, nRst, $0C, nD4, $05, nRst
	dc.b	$07, nRst, $24, nRst, $60, nRst, $60, nRst, nRst, nRst, nRst, nRst
	smpsNoteFill        $06
	smpsPSGvoice        sTone_05
	dc.b	nRst, $0C, nG4, $18, nG4, nG4, nG4, $0C, nRst, $0C, nG4, $18
	dc.b	nG4, nG4, nG4, $0C

Snd_CNZ2_Loop0D:
	smpsNoteFill        $00
	smpsPSGvoice        sTone_04
	smpsCall            Snd_CNZ2_Call04
	smpsLoop            $00, $02, Snd_CNZ2_Loop0D
	dc.b	nRst, $0C, nD4, nRst, $07, nD4, $05, nRst, $0C, nD4, $05, nRst
	dc.b	$07, nRst, $24, nRst, $60, nRst
	smpsJump            Snd_CNZ2_PSG1

; PSG2 Data
Snd_CNZ2_PSG2:
	smpsPSGvoice        sTone_12
	smpsModChange       $02
	smpsNoteFill        $06
	dc.b	nC4, $0C, nE4, nG3, nE4, nC4, nE4, nG3, nE4
	smpsLoop            $00, $03, Snd_CNZ2_PSG2
	dc.b	nRst, $60
	smpsPSGvoice        sTone_12
	dc.b	nRst, $60, nRst, nRst
	smpsNoteFill        $06
	dc.b	nC4, $0C, nE4, nG3, nE4, nC4, nE4, nG3, nE4, nRst, $60, nRst
	dc.b	nRst, nRst
	smpsNoteFill        $00
	smpsPSGvoice        sTone_11
	dc.b	nRst, $0C, nF3, nG2, $07, nF3, $05, nRst, $07, nG2, $05, nF3
	dc.b	nRst, $13, nF3, $07, nG3, $05, nF3, $07, nC3, $05, nC2, $05
	dc.b	nRst, $13, nC3, $05, nRst, $07, nRst, nC3, $05, nRst, $13, nG2
	dc.b	$05, nBb2, $07, nC3, $05, nBb2, $07, nG2, $05, nRst, $0C, nF3
	dc.b	nG2, $07, nF3, $05, nRst, $07, nG2, $05, nF3, nRst, $13, nF3
	dc.b	$07, nG3, $05, nF3, $07, nC3, $05, nRst, $60, nRst, $60, nRst
	dc.b	nRst, nRst, nRst, $60, nRst
	smpsNoteFill        $06
	smpsPSGvoice        sTone_12
	dc.b	nC4, $0C, nE4, nG3, nE4, nC4, nE4, nG3, nE4, nC4, $0C, nE4
	dc.b	nG3, nE4, nC4, nE4, nG3, nE4

Snd_CNZ2_Loop0C:
	smpsNoteFill        $00
	smpsPSGvoice        sTone_11
	smpsCall            Snd_CNZ2_Call03
	smpsLoop            $00, $02, Snd_CNZ2_Loop0C
	dc.b	nRst, $0C, nF3, nG2, $07, nF3, $05, nRst, $07, nG2, $05, nF3
	dc.b	nRst, $13, nF3, $07, nG3, $05, nF3, $07, nC3, $05, nRst, $60
	dc.b	nRst
	smpsJump            Snd_CNZ2_PSG2

; PSG3 Data
Snd_CNZ2_PSG3:
	smpsPSGvoice        sTone_01
	smpsPSGform         $E7

Snd_CNZ2_Loop09:
	smpsCall            Snd_CNZ2_Call07
	smpsLoop            $00, $03, Snd_CNZ2_Loop09
	dc.b	(nMaxPSG2-$23)&$FF, $0C, nRst, $54

Snd_CNZ2_Loop0A:
	smpsCall            Snd_CNZ2_Call07
	smpsLoop            $00, $0B, Snd_CNZ2_Loop0A
	dc.b	(nMaxPSG2-$23)&$FF, $0C, nRst, $54

Snd_CNZ2_Loop0B:
	smpsCall            Snd_CNZ2_Call07
	smpsLoop            $00, $0D, Snd_CNZ2_Loop0B
	dc.b	(nMaxPSG2-$23)&$FF, $0C, nRst, $54, nRst, $60
	smpsJump            Snd_CNZ2_Loop09

Snd_CNZ2_Call07:
	dc.b	(nMaxPSG2-$23)&$FF, $08, $04, $04, nRst, $08
	smpsPSGAlterVol     $FE
	dc.b	(nMaxPSG2-$23)&$FF, $04
	smpsPSGAlterVol     $02
	dc.b	nRst, $08, (nMaxPSG2-$23)&$FF, $08, $04, (nMaxPSG2-$23)&$FF, nRst, $14
	smpsPSGAlterVol     $FE
	dc.b	(nMaxPSG2-$23)&$FF, $04
	smpsPSGAlterVol     $02
	dc.b	nRst, $14
	smpsReturn

; DAC Data
Snd_CNZ2_DAC:
	dc.b	dPowerKick, $0C, dClick, dQuickGlassCrash, $24, dPowerKick, $0C, dQuickGlassCrash, dQuickGlassCrash
	smpsLoop            $00, $03, Snd_CNZ2_DAC
	dc.b	dGlassCrashKick, $48, dQuietGlassCrash, $18

Snd_CNZ2_Loop00:
	dc.b	dPowerKick, $0C, dClick, dQuickGlassCrash, $24, dPowerKick, $0C, dQuickGlassCrash, dQuickGlassCrash
	smpsLoop            $00, $0B, Snd_CNZ2_Loop00
	dc.b	dGlassCrashKick, $48, dQuietGlassCrash, $18

Snd_CNZ2_Loop01:
	dc.b	dPowerKick, $0C, dClick, dQuickGlassCrash, $24, dPowerKick, $0C, dQuickGlassCrash, dQuickGlassCrash
	smpsLoop            $00, $0D, Snd_CNZ2_Loop01
	dc.b	dGlassCrashSnare, $60, dGlassCrash
	smpsJump            Snd_CNZ2_DAC

; Unreachable
	smpsStop

Snd_CNZ2_Call02:
	smpsSetvoice        $05
	dc.b	nC5, $18
	smpsNoteFill        $06
	dc.b	nFs4, $08, nB4, nE5, nEb5, nA4, nD5, nCs5, $18
	smpsNoteFill        $00
	dc.b	nC5, $18, nRst, $48
	smpsReturn

Snd_CNZ2_Voices:
;	Voice $00
;	$3B
;	$01, $02, $04, $02, 	$18, $1B, $19, $16, 	$1C, $19, $1D, $1F
;	$0A, $02, $02, $03, 	$0F, $1F, $1F, $1E, 	$26, $1B, $1B, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $02, $04, $02, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $16, $19, $1B, $18
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $1F, $1D, $19, $1C
	smpsVcDecayRate2    $03, $02, $02, $0A
	smpsVcDecayLevel    $01, $01, $01, $00
	smpsVcReleaseRate   $0E, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1B, $1B, $26

;	Voice $01
;	$25
;	$31, $12, $0A, $22, 	$1F, $1F, $1F, $1F, 	$0E, $0B, $10, $0E
;	$10, $00, $00, $00, 	$E7, $3F, $3F, $3F, 	$0B, $88, $88, $88
	smpsVcAlgorithm     $05
	smpsVcFeedback      $04
	smpsVcUnusedBits    $00
	smpsVcDetune        $02, $00, $01, $03
	smpsVcCoarseFreq    $02, $0A, $02, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0E, $10, $0B, $0E
	smpsVcDecayRate2    $00, $00, $00, $10
	smpsVcDecayLevel    $03, $03, $03, $0E
	smpsVcReleaseRate   $0F, $0F, $0F, $07
	smpsVcTotalLevel    $08, $08, $08, $0B

;	Voice $02
;	$3B
;	$04, $32, $03, $01, 	$14, $0E, $12, $4E, 	$00, $10, $12, $0C
;	$00, $00, $00, $00, 	$0F, $5F, $9F, $2F, 	$00, $3E, $26, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $03, $00
	smpsVcCoarseFreq    $01, $03, $02, $04
	smpsVcRateScale     $01, $00, $00, $00
	smpsVcAttackRate    $0E, $12, $0E, $14
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0C, $12, $10, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $02, $09, $05, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $26, $3E, $00

;	Voice $03
;	$3B
;	$0C, $02, $03, $02, 	$59, $1C, $1E, $1F, 	$0C, $04, $08, $07
;	$02, $03, $03, $04, 	$EF, $DF, $DF, $DF, 	$30, $2A, $2A, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $02, $03, $02, $0C
	smpsVcRateScale     $00, $00, $00, $01
	smpsVcAttackRate    $1F, $1E, $1C, $19
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $07, $08, $04, $0C
	smpsVcDecayRate2    $04, $03, $03, $02
	smpsVcDecayLevel    $0D, $0D, $0D, $0E
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $2A, $2A, $30

;	Voice $04
;	$3B
;	$72, $02, $32, $02, 	$6C, $1B, $12, $12, 	$05, $07, $02, $10
;	$03, $00, $00, $00, 	$EF, $FF, $2F, $1F, 	$2A, $33, $30, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $03, $00, $07
	smpsVcCoarseFreq    $02, $02, $02, $02
	smpsVcRateScale     $00, $00, $00, $01
	smpsVcAttackRate    $12, $12, $1B, $2C
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $10, $02, $07, $05
	smpsVcDecayRate2    $00, $00, $00, $03
	smpsVcDecayLevel    $01, $02, $0F, $0E
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $30, $33, $2A

;	Voice $05
;	$03
;	$02, $03, $10, $11, 	$15, $10, $12, $18, 	$10, $0C, $1C, $0D
;	$00, $1A, $00, $16, 	$3F, $5F, $6F, $5B, 	$0F, $18, $1C, $84
	smpsVcAlgorithm     $03
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $01, $00, $00
	smpsVcCoarseFreq    $01, $00, $03, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $18, $12, $10, $15
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0D, $1C, $0C, $10
	smpsVcDecayRate2    $16, $00, $1A, $00
	smpsVcDecayLevel    $05, $06, $05, $03
	smpsVcReleaseRate   $0B, $0F, $0F, $0F
	smpsVcTotalLevel    $04, $1C, $18, $0F

