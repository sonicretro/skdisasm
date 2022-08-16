Snd_ICZ1_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_ICZ_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $14

	smpsHeaderDAC       Snd_ICZ1_DAC
	smpsHeaderFM        Snd_ICZ1_FM1,	$00, $02
	smpsHeaderFM        Snd_ICZ1_FM2,	$F4, $08
	smpsHeaderFM        Snd_ICZ1_FM3,	$F4, $08
	smpsHeaderFM        Snd_ICZ1_FM4,	$F4, $08
	smpsHeaderFM        Snd_ICZ1_FM5,	$F4, $08
	smpsHeaderPSG       Snd_ICZ1_PSG1,	$E8, $01, $00, sTone_06
	smpsHeaderPSG       Snd_ICZ1_PSG2,	$E8, $02, $00, sTone_06
	smpsHeaderPSG       Snd_ICZ1_PSG3,	$00, $03, $00, sTone_02

; FM1 Data
Snd_ICZ1_FM1:
	smpsSetvoice        $00

Snd_ICZ1_Loop13:
	dc.b	nC3, $0C, $18, $06, nC3, nBb2, $0C, $18, $06, nBb2, nAb2, $0C
	dc.b	$18, $06, nAb2, nG2, $0C, $18, $06, nG2, nC3, $0C, $18, $06
	dc.b	nC3, nEb3, $0C, $18, $06, nEb3, nBb2, $0C, $18, $06, nBb2, nBb2
	dc.b	$0C, $18, $06, nBb2
	smpsLoop            $01, $04, Snd_ICZ1_Loop13
	dc.b	nC3, $0C, $06, nC3, nC3, $0C, $06, nC3, nAb2, $0C, $06, nAb2
	dc.b	nAb2, $0C, $06, nAb2, nBb2, $0C, $06, nBb2, nBb2, nBb2, nBb2, nBb2
	dc.b	nG2, $0C, $06, nG2, nG2, $0C, $06, nG2, nC3, $0C, $06, nC3
	dc.b	nC3, $0C, $06, nC3, nAb2, $0C, $06, nAb2, nAb2, $0C, $06, nAb2
	dc.b	nBb2, $0C, $06, nBb2, nBb2, $0C, $06, nBb2, nG2, $0C, $06, nG2
	dc.b	nG2, $0C, $06, nG2, nC3, $0C, $06, nC3, nC3, $0C, $06, nC3
	dc.b	nAb2, $0C, $06, nAb2, nAb2, $0C, $06, nAb2, nBb2, $0C, $06, nBb2
	dc.b	nBb2, nBb2, nBb2, nBb2, nG2, $0C, $06, nG2, nG2, $0C, $06, nG2
	dc.b	nC3, $0C, $06, nC3, nC3, $0C, $06, nC3, nAb2, $0C, $06, nAb2
	dc.b	nAb2, $0C, $06, nAb2, nBb2, $0C, $06, nBb2, nBb2, $0C, $06, nBb2
	dc.b	nBb2, $0C, $06, nBb2, nBb2, $0C, $06, nBb2

Snd_ICZ1_Loop14:
	dc.b	nC3, $0C, $18, $06, nC3, nBb2, $0C, $18, $06, nBb2, nAb2, $0C
	dc.b	$18, $06, nAb2, nG2, $0C, $18, $06, nG2, nC3, $0C, $18, $06
	dc.b	nC3, nEb3, $0C, $18, $06, nEb3, nBb2, $0C, $18, $06, nBb2, nBb2
	dc.b	$0C, $18, $06, nBb2
	smpsLoop            $01, $02, Snd_ICZ1_Loop14

Snd_ICZ1_Loop15:
	dc.b	nC3, $0C, $06, nC3, nC3, $0C, $06, nC3, nAb2, $0C, $06, nAb2
	dc.b	nAb2, $0C, $06, nAb2, nBb2, $0C, $06, nBb2, nBb2, nBb2, nBb2, nBb2
	dc.b	nG2, $0C, $06, nG2, nG2, $0C, $06, nG2, nC3, $0C, $06, nC3
	dc.b	nC3, $0C, $06, nC3, nAb2, $0C, $06, nAb2, nAb2, $0C, $06, nAb2
	dc.b	nBb2, $0C, $06, nBb2, nBb2, $0C, $06, nBb2, nG2, $0C, $06, nG2
	dc.b	nG2, $0C, $06, nG2, nC3, $0C, $06, nC3, nC3, $0C, $06, nC3
	dc.b	nAb2, $0C, $06, nAb2, nAb2, $0C, $06, nAb2, nBb2, $0C, $06, nBb2
	dc.b	nBb2, nBb2, nBb2, nBb2, nG2, $0C, $06, nG2, nG2, $0C, $06, nG2
	dc.b	nC3, $0C, $06, nC3, nC3, $0C, $06, nC3, nAb2, $0C, $06, nAb2
	dc.b	nAb2, $0C, $06, nAb2, nBb2, $0C, $06, nBb2, nBb2, $0C, $06, nBb2
	dc.b	nBb2, $0C, $06, nBb2, nBb2, $0C, $06, nBb2
	smpsLoop            $01, $02, Snd_ICZ1_Loop15
	smpsJump            Snd_ICZ1_FM1

; FM2 Data
Snd_ICZ1_FM2:
	smpsAlterPitch      $0C
	smpsSetvoice        $01
	smpsModSet          $01, $01, $03, $03

Snd_ICZ1_Loop0F:
	dc.b	nG4, $30, smpsNoAttack, $30, smpsNoAttack, nG4, nF4, nG4, smpsNoAttack, $30, nF4, smpsNoAttack
	dc.b	$30
	smpsLoop            $01, $04, Snd_ICZ1_Loop0F
	smpsAlterPitch      $F4
	smpsSetvoice        $02

Snd_ICZ1_Loop10:
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5, nF5, $0C, nBb4, $30
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, smpsNoAttack, $30
	smpsLoop            $01, $02, Snd_ICZ1_Loop10
	smpsSetvoice        $01
	smpsAlterPitch      $0C

Snd_ICZ1_Loop11:
	dc.b	nG4, $30, smpsNoAttack, $30, smpsNoAttack, nG4, nF4, nG4, smpsNoAttack, $30, nF4, smpsNoAttack
	dc.b	$30
	smpsLoop            $01, $02, Snd_ICZ1_Loop11
	smpsAlterPitch      $F4
	smpsSetvoice        $02

Snd_ICZ1_Loop12:
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5, nF5, $0C, nBb4, $30
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, smpsNoAttack, $30
	smpsLoop            $01, $04, Snd_ICZ1_Loop12
	smpsJump            Snd_ICZ1_FM2

; FM3 Data
Snd_ICZ1_FM3:
	smpsSetvoice        $04
	smpsModSet          $01, $01, $A1, $FF
	smpsPan             panLeft, $00
	dc.b	nG6, $09, nRst, $27, nRst, $06
	smpsSetvoice        $05
	smpsFMAlterVol      $2C
	smpsPan             panRight, $00

Snd_ICZ1_Loop0B:
	dc.b	nBb2, $01
	smpsFMAlterVol      $FD
	smpsLoop            $00, $12, Snd_ICZ1_Loop0B
	smpsFMAlterVol      $0A
	dc.b	nRst, $18
	smpsSetvoice        $01
	smpsModSet          $01, $01, $03, $03
	smpsPan             panCenter, $00
	dc.b	nAb3, $30, nG3, nRst, nRst, nRst, nRst
	smpsLoop            $01, $04, Snd_ICZ1_FM3

Snd_ICZ1_Loop0C:
	dc.b	nEb4, $30, nC4, nD4, nBb3, nEb4, nC4, nD4, smpsNoAttack, $30
	smpsLoop            $01, $02, Snd_ICZ1_Loop0C
	smpsSetvoice        $01
	smpsModSet          $01, $01, $03, $03
	smpsPan             panCenter, $00
	dc.b	nRst, nRst, nAb3, $30, nG3, nRst, nRst
	smpsSetvoice        $04
	smpsModSet          $01, $01, $A1, $FF
	smpsPan             panLeft, $00
	dc.b	nG6, $09, nRst, $27, nRst, $06
	smpsSetvoice        $05
	smpsFMAlterVol      $2C
	smpsPan             panRight, $00

Snd_ICZ1_Loop0D:
	dc.b	nBb2, $01
	smpsFMAlterVol      $FD
	smpsLoop            $00, $12, Snd_ICZ1_Loop0D
	smpsFMAlterVol      $0A
	dc.b	nRst, $18
	smpsSetvoice        $01
	smpsModSet          $01, $01, $03, $03
	smpsPan             panCenter, $00
	dc.b	nRst, $30, nRst, nAb3, nG3, nRst, nRst, nRst, nRst

Snd_ICZ1_Loop0E:
	dc.b	nEb4, $30, nC4, nD4, nBb3, nEb4, nC4, nD4, smpsNoAttack, $30
	smpsLoop            $01, $04, Snd_ICZ1_Loop0E
	smpsJump            Snd_ICZ1_FM3

; FM4 Data
Snd_ICZ1_FM4:
	smpsAlterPitch      $0C
	smpsSetvoice        $01
	smpsModSet          $01, $01, $03, $03

Snd_ICZ1_Loop07:
	dc.b	nC4, $30, nBb3, nC4, nBb3, nC4, nBb3, smpsNoAttack, nBb3, smpsNoAttack, $30
	smpsLoop            $00, $04, Snd_ICZ1_Loop07
	smpsAlterPitch      $F4
	smpsSetvoice        $03
	smpsModSet          $00, $00, $00, $00
	smpsPan             panRight, $00

Snd_ICZ1_Loop08:
	dc.b	nBb4, $06, nC4, nG4, nC5, nG4, nC4, nG4, nC5, nG4, nC4, nAb4
	dc.b	nC5, nAb4, nC4, nAb4, nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b	nD5, nBb4, nD4, nBb4, nG4, nBb4, nD4, nBb4, nG4
	smpsLoop            $00, $03, Snd_ICZ1_Loop08
	dc.b	nBb4, $06, nC4, nG4, nC5, nG4, nC4, nG4, nC5, nG4, nC4, nAb4
	dc.b	nC5, nAb4, nC4, nAb4, nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b	nD5, nBb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	smpsPan             panCenter, $00
	smpsSetvoice        $01
	smpsAlterPitch      $0C
	smpsModSet          $01, $01, $03, $03

Snd_ICZ1_Loop09:
	dc.b	nC4, $30, nBb3, nC4, nBb3, nC4, nBb3, smpsNoAttack, nBb3, smpsNoAttack, $30
	smpsLoop            $00, $02, Snd_ICZ1_Loop09
	smpsAlterPitch      $F4
	smpsSetvoice        $03
	smpsModSet          $00, $00, $00, $00
	smpsPan             panRight, $00

Snd_ICZ1_Loop0A:
	dc.b	nBb4, $06, nC4, nG4, nC5, nG4, nC4, nG4, nC5, nG4, nC4, nAb4
	dc.b	nC5, nAb4, nC4, nAb4, nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b	nD5, nBb4, nD4, nBb4, nG4, nBb4, nD4, nBb4, nG4
	smpsLoop            $01, $03, Snd_ICZ1_Loop0A
	dc.b	nBb4, $06, nC4, nG4, nC5, nG4, nC4, nG4, nC5, nG4, nC4, nAb4
	dc.b	nC5, nAb4, nC4, nAb4, nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b	nD5, nBb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	smpsLoop            $00, $02, Snd_ICZ1_Loop0A
	smpsPan             panCenter, $00
	smpsJump            Snd_ICZ1_FM4

; FM5 Data
Snd_ICZ1_FM5:
	smpsAlterPitch      $0C
	smpsSetvoice        $01
	smpsModSet          $01, $01, $03, $03

Snd_ICZ1_Loop03:
	dc.b	nEb4, $30, smpsNoAttack, $30, smpsNoAttack, nEb4, nD4, nEb4, smpsNoAttack, $30, nD4, smpsNoAttack
	dc.b	$30
	smpsLoop            $01, $04, Snd_ICZ1_Loop03
	smpsAlterPitch      $F4
	smpsSetvoice        $03
	smpsModSet          $00, $00, $00, $00

Snd_ICZ1_Loop04:
	dc.b	nC4, $06, nG4, nC5, nG4, nC4, nG4, nC5, nG4, nC4, nAb4, nC5
	dc.b	nAb4, nC4, nAb4, nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b	nBb4, nD4, nBb4, nG4, nBb4, nD4, nBb4, nG4, nBb4, nC4, nG4, nC5
	dc.b	nG4, nC4, nG4, nC5, nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4, nC5
	dc.b	nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b	nBb4, nD4, nBb4, nD5, nBb4
	smpsLoop            $01, $02, Snd_ICZ1_Loop04
	smpsSetvoice        $01
	smpsAlterPitch      $0C
	smpsModSet          $01, $01, $03, $03

Snd_ICZ1_Loop05:
	dc.b	nEb4, $30, smpsNoAttack, $30, smpsNoAttack, nEb4, nD4, nEb4, smpsNoAttack, $30, nD4, smpsNoAttack
	dc.b	$30
	smpsLoop            $01, $02, Snd_ICZ1_Loop05
	smpsAlterPitch      $F4
	smpsSetvoice        $03
	smpsModSet          $00, $00, $00, $00

Snd_ICZ1_Loop06:
	dc.b	nC4, $06, nG4, nC5, nG4, nC4, nG4, nC5, nG4, nC4, nAb4, nC5
	dc.b	nAb4, nC4, nAb4, nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b	nBb4, nD4, nBb4, nG4, nBb4, nD4, nBb4, nG4, nBb4, nC4, nG4, nC5
	dc.b	nG4, nC4, nG4, nC5, nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4, nC5
	dc.b	nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b	nBb4, nD4, nBb4, nD5, nBb4
	smpsLoop            $01, $04, Snd_ICZ1_Loop06
	smpsJump            Snd_ICZ1_FM5

; PSG1 Data
Snd_ICZ1_PSG1:
	smpsPSGvoice        sTone_02
	smpsAlterPitch      $18
	smpsNoteFill        $09

Snd_ICZ1_Loop1B:
	dc.b	nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4, $2A
	smpsLoop            $01, $10, Snd_ICZ1_Loop1B
	smpsAlterPitch      $E8
	smpsNoteFill        $00
	smpsPSGvoice        sTone_16

Snd_ICZ1_Loop1C:
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5, nF5, $0C, nBb4, $30
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, smpsNoAttack, $30
	smpsLoop            $01, $02, Snd_ICZ1_Loop1C
	smpsPSGvoice        sTone_02
	smpsAlterPitch      $18
	smpsNoteFill        $09

Snd_ICZ1_Loop1D:
	dc.b	nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4, $2A
	smpsLoop            $01, $07, Snd_ICZ1_Loop1D
	dc.b	nRst, $30, nRst
	smpsAlterPitch      $E8
	smpsNoteFill        $00
	smpsPSGvoice        sTone_16

Snd_ICZ1_Loop1E:
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5, nF5, $0C, nBb4, $30
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, smpsNoAttack, $30
	smpsLoop            $01, $04, Snd_ICZ1_Loop1E
	smpsJump            Snd_ICZ1_PSG1

; PSG2 Data
Snd_ICZ1_PSG2:
	smpsAlterNote       $01

Snd_ICZ1_Jump00:
	smpsPSGvoice        sTone_01
	smpsAlterPitch      $18
	smpsNoteFill        $09
	smpsModSet          $00, $01, $01, $02

Snd_ICZ1_Loop18:
	dc.b	nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4, $2A
	smpsLoop            $01, $10, Snd_ICZ1_Loop18
	smpsAlterPitch      $E8
	smpsNoteFill        $00
	smpsPSGvoice        sTone_16
	smpsPSGAlterVol     $02
	dc.b	nRst, $18
	smpsModSet          $00, $01, $01, $03
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5, nF5, $0C, nBb4, $30
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, smpsNoAttack, $30, nC5, $18, nC6, nBb5
	dc.b	$30, nD5, $12, nEb5, nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b	$30, nD5, smpsNoAttack, $18
	smpsPSGAlterVol     $FE
	smpsModSet          $00, $00, $00, $00
	smpsPSGvoice        sTone_01
	smpsAlterPitch      $18
	smpsModSet          $00, $01, $01, $02
	smpsNoteFill        $09

Snd_ICZ1_Loop19:
	dc.b	nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4, $2A
	smpsLoop            $01, $07, Snd_ICZ1_Loop19
	dc.b	nRst, $30, nRst
	smpsAlterPitch      $E8
	smpsNoteFill        $00
	smpsPSGvoice        sTone_16
	smpsPSGAlterVol     $02
	dc.b	nRst, $18
	smpsModSet          $00, $01, $01, $03

Snd_ICZ1_Loop1A:
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5, nF5, $0C, nBb4, $30
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, smpsNoAttack, $30
	smpsLoop            $01, $03, Snd_ICZ1_Loop1A
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5, nF5, $0C, nBb4, $30
	dc.b	nC5, $18, nC6, nBb5, $30, nD5, smpsNoAttack, $18
	smpsPSGAlterVol     $FE
	smpsModSet          $00, $00, $00, $00
	smpsJump            Snd_ICZ1_Jump00

; PSG3 Data
Snd_ICZ1_PSG3:
	smpsPSGform         $E7
	smpsPSGvoice        sTone_02

Snd_ICZ1_Loop16:
	dc.b	nRst, $0C, nMaxPSG2, $18, nMaxPSG2, nMaxPSG2, nMaxPSG2, $0C
	smpsLoop            $01, $1F, Snd_ICZ1_Loop16
	dc.b	nRst, $0C, nMaxPSG2, $18, nMaxPSG2, nRst, $24

Snd_ICZ1_Loop17:
	dc.b	nRst, $0C, nMaxPSG2, $18, nMaxPSG2, nMaxPSG2, nMaxPSG2, $0C
	smpsLoop            $01, $10, Snd_ICZ1_Loop17
	smpsJump            Snd_ICZ1_Loop16

; DAC Data
Snd_ICZ1_DAC:
	dc.b	dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick
	dc.b	dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick
	dc.b	$0C, dBassHey, dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dQuickHit, $06
	dc.b	dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit
	dc.b	dQuickHit, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit
	smpsLoop            $00, $04, Snd_ICZ1_DAC

Snd_ICZ1_Loop00:
	dc.b	dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dReverseFadingWind, $0C, dLooseSnareNoise, $18
	dc.b	dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, dHipHopHitKick3, $0C, $06, dDanceStyleKick
	dc.b	$18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, dQuickHit
	dc.b	dQuickHit, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $0C
	dc.b	dQuickHit, $06, dQuickHit
	smpsLoop            $00, $02, Snd_ICZ1_Loop00

Snd_ICZ1_Loop01:
	dc.b	dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $0C, dBassHey, dDanceStyleKick
	dc.b	$18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, dQuickHit
	dc.b	dQuickHit, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $0C
	dc.b	dQuickHit, $06, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $0C, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick
	smpsLoop            $00, $02, Snd_ICZ1_Loop01

Snd_ICZ1_Loop02:
	dc.b	dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dReverseFadingWind, $0C, dLooseSnareNoise, $18
	dc.b	dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, dHipHopHitKick3, $0C, $06, dDanceStyleKick
	dc.b	$18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, dQuickHit
	dc.b	dQuickHit, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $0C
	dc.b	dQuickHit, $06, dQuickHit
	smpsLoop            $00, $04, Snd_ICZ1_Loop02
	smpsJump            Snd_ICZ1_DAC

Snd_ICZ_Voices:
;	Voice $00
;	$20
;	$34, $38, $30, $31, 	$DF, $DF, $9F, $9F, 	$07, $08, $08, $0A
;	$07, $0E, $0A, $11, 	$20, $1F, $1F, $1F, 	$22, $37, $14, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $04
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $03, $03
	smpsVcCoarseFreq    $01, $00, $08, $04
	smpsVcRateScale     $02, $02, $03, $03
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $08, $08, $07
	smpsVcDecayRate2    $11, $0A, $0E, $07
	smpsVcDecayLevel    $01, $01, $01, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $00
	smpsVcTotalLevel    $00, $14, $37, $22

;	Voice $01
;	$35
;	$02, $04, $02, $01, 	$10, $0A, $0C, $0E, 	$07, $04, $04, $04
;	$01, $0A, $0A, $0A, 	$28, $1B, $1B, $1B, 	$1D, $8E, $8D, $8E
	smpsVcAlgorithm     $05
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $02, $04, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0E, $0C, $0A, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $04, $04, $04, $07
	smpsVcDecayRate2    $0A, $0A, $0A, $01
	smpsVcDecayLevel    $01, $01, $01, $02
	smpsVcReleaseRate   $0B, $0B, $0B, $08
	smpsVcTotalLevel    $0E, $0D, $0E, $1D

;	Voice $02
;	$2D
;	$02, $02, $02, $02, 	$10, $10, $10, $10, 	$07, $08, $08, $08
;	$01, $05, $05, $05, 	$28, $1B, $1B, $1B, 	$20, $86, $86, $89
	smpsVcAlgorithm     $05
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $02, $02, $02, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $10, $10, $10, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $08, $08, $07
	smpsVcDecayRate2    $05, $05, $05, $01
	smpsVcDecayLevel    $01, $01, $01, $02
	smpsVcReleaseRate   $0B, $0B, $0B, $08
	smpsVcTotalLevel    $09, $06, $06, $20

;	Voice $03
;	$06
;	$04, $04, $03, $34, 	$1F, $1F, $1F, $1F, 	$0F, $0F, $0F, $0F
;	$0D, $12, $11, $10, 	$1F, $0F, $1F, $0F, 	$1D, $84, $96, $80
	smpsVcAlgorithm     $06
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $00, $00, $00
	smpsVcCoarseFreq    $04, $03, $04, $04
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0F, $0F, $0F, $0F
	smpsVcDecayRate2    $10, $11, $12, $0D
	smpsVcDecayLevel    $00, $01, $00, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $16, $04, $1D

;	Voice $04
;	$3D
;	$00, $04, $07, $0A, 	$1F, $1F, $1F, $1F, 	$1F, $1D, $1D, $1D
;	$05, $06, $16, $00, 	$09, $1F, $1F, $1F, 	$34, $8D, $87, $86
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $0A, $07, $04, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $1D, $1D, $1D, $1F
	smpsVcDecayRate2    $00, $16, $06, $05
	smpsVcDecayLevel    $01, $01, $01, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $09
	smpsVcTotalLevel    $06, $07, $0D, $34

;	Voice $05
;	$32
;	$38, $46, $4F, $32, 	$1F, $1F, $1F, $1F, 	$0E, $1C, $16, $02
;	$00, $00, $00, $00, 	$60, $60, $40, $39, 	$05, $04, $18, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $04, $04, $03
	smpsVcCoarseFreq    $02, $0F, $06, $08
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $16, $1C, $0E
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $03, $04, $06, $06
	smpsVcReleaseRate   $09, $00, $00, $00
	smpsVcTotalLevel    $00, $18, $04, $05

