Snd_ICZ2_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_ICZ_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $14

	smpsHeaderDAC       Snd_ICZ2_DAC
	smpsHeaderFM        Snd_ICZ2_FM1,	$00, $02
	smpsHeaderFM        Snd_ICZ2_FM2,	$F4, $08
	smpsHeaderFM        Snd_ICZ2_FM3,	$F4, $08
	smpsHeaderFM        Snd_ICZ2_FM4,	$F4, $08
	smpsHeaderFM        Snd_ICZ2_FM5,	$F4, $08
	smpsHeaderPSG       Snd_ICZ2_PSG1,	$E8, $01, $00, sTone_06
	smpsHeaderPSG       Snd_ICZ2_PSG2,	$E8, $02, $00, sTone_06
	smpsHeaderPSG       Snd_ICZ2_PSG3,	$00, $01, $00, sTone_02

; FM1 Data
Snd_ICZ2_FM1:
	smpsSetvoice        $00

Snd_ICZ2_Loop0F:
	dc.b	nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	smpsLoop            $01, $03, Snd_ICZ2_Loop0F
	dc.b	nC3, $0C, $18, $06, nC3, nBb2, $0C, $18, $06, nBb2, nAb2, $0C
	dc.b	$18, $06, nAb2, nG2, $0C, $18, $06, nG2, nC3, $0C, $18, $06
	dc.b	nC3, nEb3, $0C, $18, $06, nEb3, nBb2, $0C, $18, $06, nBb2, nBb2
	dc.b	$0C, $18, $06, nBb2

Snd_ICZ2_Loop10:
	dc.b	nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	smpsLoop            $01, $02, Snd_ICZ2_Loop10

Snd_ICZ2_Loop11:
	dc.b	nC3, $0C, $18, $06, nC3, nBb2, $0C, $18, $06, nBb2, nAb2, $0C
	dc.b	$18, $06, nAb2, nG2, $0C, $18, $06, nG2, nC3, $0C, $18, $06
	dc.b	nC3, nEb3, $0C, $18, $06, nEb3, nBb2, $0C, $18, $06, nBb2, nBb2
	dc.b	$0C, $18, $06, nBb2
	smpsLoop            $01, $02, Snd_ICZ2_Loop11

Snd_ICZ2_Loop12:
	dc.b	nC3, $0C, $06, nC3, nC3, $0C, $06, nC3, nAb2, $0C, $06, nAb2
	dc.b	nAb2, $0C, $06, nAb2, nBb2, $0C, $06, nBb2, nBb2, nBb2, nBb2, nBb2
	dc.b	nG2, $0C, $06, nG2, nG2, $0C, $06, nG2, nC3, $0C, $06, nC3
	dc.b	nC3, $0C, $06, nC3, nAb2, $0C, $06, nAb2, nAb2, $0C, $06, nAb2
	dc.b	nBb2, $0C, $06, nBb2, nBb2, $0C, $06, nBb2, nBb2, $0C, $06, nBb2
	dc.b	nBb2, $0C, $06, nBb2
	smpsLoop            $01, $04, Snd_ICZ2_Loop12

Snd_ICZ2_Loop13:
	dc.b	nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	smpsLoop            $01, $02, Snd_ICZ2_Loop13
	smpsJump            Snd_ICZ2_Loop0F

; FM2 Data
Snd_ICZ2_FM2:
	smpsSetvoice        $01
	smpsAlterPitch      $0C
	smpsModSet          $01, $01, $03, $03

Snd_ICZ2_Loop0C:
	dc.b	nG4, $30, smpsNoAttack, $30, smpsNoAttack, nG4, nF4, nG4, smpsNoAttack, $30, nF4, smpsNoAttack
	dc.b	$30
	smpsLoop            $01, $04, Snd_ICZ2_Loop0C
	smpsAlterPitch      $F4
	smpsSetvoice        $02
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5, nF5, $0C, nBb4, $30
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, smpsNoAttack, $30, nRst, $30, nRst, nRst
	dc.b	nRst, nRst, nRst, nRst, nRst
	smpsSetvoice        $01
	smpsAlterPitch      $0C
	smpsModSet          $01, $01, $03, $03
	dc.b	nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nG4, smpsNoAttack, $30, smpsNoAttack
	dc.b	nG4, nF4, nG4, smpsNoAttack, $30, nF4, smpsNoAttack, $30
	smpsAlterPitch      $F4
	smpsSetvoice        $02

Snd_ICZ2_Loop0D:
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5, nF5, $0C, nBb4, $30
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, smpsNoAttack, $30
	smpsLoop            $01, $04, Snd_ICZ2_Loop0D

Snd_ICZ2_Loop0E:
	dc.b	nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	smpsLoop            $01, $02, Snd_ICZ2_Loop0E
	smpsJump            Snd_ICZ2_FM2

; FM3 Data
Snd_ICZ2_FM3:
	smpsCall            Snd_ICZ2_Call01
	dc.b	nAb3, $30, nG3, nRst, nRst, nRst, nRst
	smpsLoop            $01, $04, Snd_ICZ2_FM3

Snd_ICZ2_Loop09:
	smpsCall            Snd_ICZ2_Call01
	dc.b	nRst, $30, nRst, nRst, nRst, nRst, nRst
	smpsLoop            $01, $02, Snd_ICZ2_Loop09
	dc.b	nRst, $30, nRst, nRst, nRst, nRst, nRst
	smpsCall            Snd_ICZ2_Call01
	dc.b	nRst, $30, nRst, nAb3, $30, nG3, nRst, nRst, nRst, nRst

Snd_ICZ2_Loop0A:
	smpsCall            Snd_ICZ2_Call01
	dc.b	nRst, $30, nRst, nRst, nRst, nRst, nRst
	smpsLoop            $01, $04, Snd_ICZ2_Loop0A

Snd_ICZ2_Loop0B:
	dc.b	nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	smpsLoop            $00, $02, Snd_ICZ2_Loop0B
	smpsJump            Snd_ICZ2_FM3

Snd_ICZ2_Call01:
	smpsSetvoice        $04
	smpsModSet          $01, $01, $A1, $FF
	smpsPan             panLeft, $00
	dc.b	nG6, $09, nRst, $27, nRst, $06
	smpsSetvoice        $05
	smpsFMAlterVol      $2C
	smpsPan             panRight, $00

Snd_ICZ2_Loop1E:
	dc.b	nBb2, $01
	smpsFMAlterVol      $FD
	smpsLoop            $00, $12, Snd_ICZ2_Loop1E
	smpsFMAlterVol      $0A
	dc.b	nRst, $18
	smpsSetvoice        $01
	smpsModSet          $01, $01, $03, $03
	smpsPan             panCenter, $00
	smpsReturn

; FM4 Data
Snd_ICZ2_FM4:
	smpsSetvoice        $01
	smpsAlterPitch      $0C
	smpsModSet          $01, $01, $03, $03

Snd_ICZ2_Loop05:
	dc.b	nC4, $30, nBb3, nC4, nBb3, nC4, nBb3, smpsNoAttack, nBb3, smpsNoAttack, $30
	smpsLoop            $01, $04, Snd_ICZ2_Loop05
	smpsAlterPitch      $F4
	smpsSetvoice        $03
	smpsPan             panRight, $00

Snd_ICZ2_Loop06:
	dc.b	nBb4, $06, nC4, nG4, nC5, nG4, nC4, nG4, nC5, nG4, nC4, nAb4
	dc.b	nC5, nAb4, nC4, nAb4, nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b	nD5, nBb4, nD4, nBb4, nG4, nBb4, nD4, nBb4, nG4
	smpsLoop            $01, $03, Snd_ICZ2_Loop06
	dc.b	nBb4, $06, nC4, nG4, nC5, nG4, nC4, nG4, nC5, nG4, nC4, nAb4
	dc.b	nC5, nAb4, nC4, nAb4, nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b	nD5, nBb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	smpsPan             panCenter, $00
	smpsSetvoice        $01
	smpsAlterPitch      $0C
	smpsModSet          $01, $01, $03, $03
	dc.b	nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nC4, nBb3, nC4
	dc.b	nBb3, nC4, nBb3, smpsNoAttack, nBb3, smpsNoAttack, $30
	smpsAlterPitch      $F4
	smpsSetvoice        $03

Snd_ICZ2_Loop08:
	smpsPan             panRight, $00

Snd_ICZ2_Loop07:
	dc.b	nBb4, $06, nC4, nG4, nC5, nG4, nC4, nG4, nC5, nG4, nC4, nAb4
	dc.b	nC5, nAb4, nC4, nAb4, nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b	nD5, nBb4, nD4, nBb4, nG4, nBb4, nD4, nBb4, nG4
	smpsLoop            $02, $03, Snd_ICZ2_Loop07
	dc.b	nBb4, $06, nC4, nG4, nC5, nG4, nC4, nG4, nC5, nG4, nC4, nAb4
	dc.b	nC5, nAb4, nC4, nAb4, nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b	nD5, nBb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	smpsPan             panCenter, $00
	smpsLoop            $01, $03, Snd_ICZ2_Loop08
	smpsJump            Snd_ICZ2_FM4

; FM5 Data
Snd_ICZ2_FM5:
	smpsSetvoice        $01
	smpsAlterPitch      $0C
	smpsModSet          $01, $01, $03, $03

Snd_ICZ2_Loop02:
	dc.b	nEb4, $30, smpsNoAttack, $30, smpsNoAttack, nEb4, nD4, nEb4, smpsNoAttack, $30, nD4, smpsNoAttack
	dc.b	$30
	smpsLoop            $01, $04, Snd_ICZ2_Loop02
	smpsAlterPitch      $F4
	smpsSetvoice        $03

Snd_ICZ2_Loop03:
	smpsCall            Snd_ICZ2_Call00
	smpsLoop            $01, $02, Snd_ICZ2_Loop03
	smpsSetvoice        $01
	smpsAlterPitch      $0C
	smpsModSet          $01, $01, $03, $03
	dc.b	nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nEb4, smpsNoAttack, $30
	dc.b	smpsNoAttack, nEb4, nD4, nEb4, smpsNoAttack, $30, nD4, smpsNoAttack, $30
	smpsAlterPitch      $F4
	smpsSetvoice        $03

Snd_ICZ2_Loop04:
	smpsCall            Snd_ICZ2_Call00
	smpsLoop            $01, $06, Snd_ICZ2_Loop04
	smpsJump            Snd_ICZ2_FM5

Snd_ICZ2_Call00:
	dc.b	nC4, $06, nG4, nC5, nG4, nC4, nG4, nC5, nG4, nC4, nAb4, nC5
	dc.b	nAb4, nC4, nAb4, nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b	nBb4, nD4, nBb4, nG4, nBb4, nD4, nBb4, nG4, nBb4, nC4, nG4, nC5
	dc.b	nG4, nC4, nG4, nC5, nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4, nC5
	dc.b	nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b	nBb4, nD4, nBb4, nD5, nBb4
	smpsReturn

; PSG1 Data
Snd_ICZ2_PSG1:
	smpsPSGvoice        sTone_02
	smpsAlterPitch      $18
	smpsNoteFill        $09

Snd_ICZ2_Loop1A:
	dc.b	nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4, $2A
	smpsLoop            $01, $10, Snd_ICZ2_Loop1A
	smpsAlterPitch      $E8
	smpsNoteFill        $00
	smpsPSGvoice        sTone_16
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5, nF5, $0C, nBb4, $30
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, smpsNoAttack, $30
	smpsPSGvoice        sTone_02
	smpsAlterPitch      $18
	smpsNoteFill        $09

Snd_ICZ2_Loop1B:
	dc.b	nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4, $2A
	smpsLoop            $01, $0B, Snd_ICZ2_Loop1B
	dc.b	nRst, $30, nRst
	smpsAlterPitch      $E8
	smpsNoteFill        $00
	smpsPSGvoice        sTone_16

Snd_ICZ2_Loop1C:
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5, nF5, $0C, nBb4, $30
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, smpsNoAttack, $30
	smpsLoop            $01, $04, Snd_ICZ2_Loop1C
	smpsPSGvoice        sTone_02
	smpsAlterPitch      $18
	smpsNoteFill        $09

Snd_ICZ2_Loop1D:
	dc.b	nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4, $2A
	smpsLoop            $01, $04, Snd_ICZ2_Loop1D
	smpsAlterPitch      $E8
	smpsNoteFill        $00
	dc.b	nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	smpsJump            Snd_ICZ2_PSG1

; PSG2 Data
Snd_ICZ2_PSG2:
	smpsPSGvoice        sTone_01
	smpsAlterPitch      $18
	smpsNoteFill        $09
	smpsModSet          $01, $01, $01, $02

Snd_ICZ2_Loop16:
	dc.b	nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4, $2A
	smpsLoop            $01, $10, Snd_ICZ2_Loop16
	smpsAlterPitch      $E8
	smpsNoteFill        $00
	smpsPSGvoice        sTone_16
	smpsPSGAlterVol     $02
	smpsModSet          $01, $01, $01, $03
	dc.b	nRst, $18, nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5, nF5, $0C
	dc.b	nBb4, $30, nC5, $18, nC6, nBb5, $30, nD5, smpsNoAttack, $18
	smpsPSGAlterVol     $FE
	smpsPSGvoice        sTone_01
	smpsAlterPitch      $18
	smpsNoteFill        $09
	smpsModSet          $01, $01, $01, $02

Snd_ICZ2_Loop17:
	dc.b	nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4, $2A
	smpsLoop            $01, $0B, Snd_ICZ2_Loop17
	dc.b	nRst, $30, nRst
	smpsAlterPitch      $E8
	smpsNoteFill        $00
	smpsPSGvoice        sTone_16
	smpsPSGAlterVol     $02
	smpsModSet          $01, $01, $01, $03
	dc.b	nRst, $18

Snd_ICZ2_Loop18:
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5, nF5, $0C, nBb4, $30
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, smpsNoAttack, $30
	smpsLoop            $01, $03, Snd_ICZ2_Loop18
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5, nF5, $0C, nBb4, $30
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, smpsNoAttack, $18
	smpsPSGAlterVol     $FE
	smpsPSGvoice        sTone_02
	smpsAlterPitch      $18
	smpsNoteFill        $09
	smpsModSet          $01, $01, $01, $02

Snd_ICZ2_Loop19:
	dc.b	nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4, $2A
	smpsLoop            $01, $04, Snd_ICZ2_Loop19
	smpsAlterPitch      $E8
	smpsNoteFill        $00
	dc.b	nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	smpsJump            Snd_ICZ2_PSG2

; PSG3 Data
Snd_ICZ2_PSG3:
	smpsPSGform         $E7
	smpsPSGvoice        sTone_02

Snd_ICZ2_Loop14:
	dc.b	nRst, $0C, nMaxPSG2, $18, nMaxPSG2, nMaxPSG2, nMaxPSG2, $0C
	smpsLoop            $01, $1F, Snd_ICZ2_Loop14
	dc.b	nRst, $0C, nMaxPSG2, $18, nMaxPSG2, nRst, $24

Snd_ICZ2_Loop15:
	dc.b	nRst, $0C, nMaxPSG2, $18, nMaxPSG2, nMaxPSG2, nMaxPSG2, $0C
	smpsLoop            $01, $14, Snd_ICZ2_Loop15
	dc.b	nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	smpsJump            Snd_ICZ2_PSG3

; DAC Data
Snd_ICZ2_DAC:
	dc.b	nRst, $30, nRst, $0C, dReverseFadingWind, $24, nRst, $30, nRst, nRst, nRst, nRst
	dc.b	nRst, nRst, $30, nRst, $0C, dReverseFadingWind, $24, nRst, $30, nRst, nRst, nRst
	dc.b	nRst, dQuickHit, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit

Snd_ICZ2_Loop00:
	dc.b	dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick
	dc.b	dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, $18
	dc.b	dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit
	dc.b	dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $0C, dQuickHit
	dc.b	$06, dQuickHit
	smpsLoop            $01, $02, Snd_ICZ2_Loop00
	dc.b	dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dReverseFadingWind, dLooseSnareNoise, $18, dDanceStyleKick
	dc.b	dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, $06, nRst
	dc.b	$12, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $18
	dc.b	dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick
	dc.b	$18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dReverseFadingWind, dLooseSnareNoise, $18, dDanceStyleKick, dDanceStyleKick
	dc.b	dDanceStyleKick, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12
	dc.b	dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick
	dc.b	dDanceStyleKick, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit

Snd_ICZ2_Loop01:
	dc.b	dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $0C, dQuickHit, $06
	dc.b	dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit
	dc.b	dDanceStyleKick, dQuickHit, dQuickHit, dQuickHit
	smpsLoop            $01, $03, Snd_ICZ2_Loop01
	dc.b	dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $0C, dQuickHit, $06
	dc.b	dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $0C, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $18, dDanceStyleKick
	dc.b	$06, nRst, $12, dDanceStyleKick, $0C, dReverseFadingWind, dLooseSnareNoise, $18, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick
	dc.b	$0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C
	dc.b	dQuickHit, $06, dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06
	dc.b	dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, $06
	dc.b	nRst, $12, dDanceStyleKick, $0C, dReverseFadingWind, dLooseSnareNoise, $18, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $0C
	dc.b	dQuickHit, $06, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dQuickHit
	dc.b	$06, dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $0C
	dc.b	dQuickHit, $06, dQuickHit, nRst, $30, nRst, $0C, dReverseFadingWind, dLooseSnareNoise, $18, nRst, $30
	dc.b	nRst, nRst, nRst, nRst, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $0C, dQuickHit
	dc.b	$06, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dReverseFadingWind, dLooseSnareNoise
	dc.b	$18, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick
	dc.b	$06, nRst, $12, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit, dQuickHit
	dc.b	dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick
	dc.b	$06, nRst, $12, dDanceStyleKick, $0C, dReverseFadingWind, dLooseSnareNoise, $18, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick
	dc.b	$0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C
	dc.b	dQuickHit, $06, dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06
	dc.b	dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, nRst, $30, nRst, nRst
	dc.b	nRst, nRst, nRst, nRst, nRst
	smpsJump            Snd_ICZ2_DAC

