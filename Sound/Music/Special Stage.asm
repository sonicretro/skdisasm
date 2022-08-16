Snd_SpecialS_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_SpecialS_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $25

	smpsHeaderDAC       Snd_SpecialS_DAC
	smpsHeaderFM        Snd_SpecialS_FM1,	$00, $17
	smpsHeaderFM        Snd_SpecialS_FM2,	$00, $0F
	smpsHeaderFM        Snd_SpecialS_FM3,	$00, $17
	smpsHeaderFM        Snd_SpecialS_FM4,	$00, $17
	smpsHeaderFM        Snd_SpecialS_FM5,	$00, $1F
	smpsHeaderPSG       Snd_SpecialS_PSG1,	$0C, $05, $00, sTone_0C
	smpsHeaderPSG       Snd_SpecialS_PSG2,	$0C, $05, $00, sTone_0C
	smpsHeaderPSG       Snd_SpecialS_PSG3,	$00, $04, $00, sTone_02

; FM1 Data
Snd_SpecialS_FM1:
	smpsSetvoice        $01
	dc.b	nE5, $06, nRst, $0C, nE4, $06, nB3, nRst, nE4, nRst, nFs4, nRst
	dc.b	nAb4, nRst, nB4, nRst, nD5, nRst, nE5, nE5, nRst, nE5, nE5, nRst
	dc.b	nE5, nE5, nRst, nD5, nRst, nD5, nD5, $0C, nE5, nRst, $60

Snd_SpecialS_Jump03:
	smpsSetvoice        $03
	smpsModSet          $14, $01, $06, $06
	smpsCall            Snd_SpecialS_Call00
	smpsCall            Snd_SpecialS_Call01
	smpsCall            Snd_SpecialS_Call02
	dc.b	nE6
	smpsFMAlterVol      $06
	smpsSetvoice        $04
	dc.b	nA6, $66, nA5, $06, nA6, nA5, nA6, $0C
	smpsCall            Snd_SpecialS_Call03
	dc.b	nEb4
	smpsFMAlterVol      $FA
	smpsJump            Snd_SpecialS_Jump03

; Unreachable
	smpsStop

Snd_SpecialS_Call00:
	dc.b	nA5, $0C, nE5, $06, nA5, nRst, nB5, nRst, nC6, $02, smpsNoAttack, nCs6
	dc.b	smpsNoAttack, nD6, $08, nCs6, $06, nB5, nRst, nA5, $0C, nB5, nA5, $0C
	dc.b	nE5, $06, nA5, nRst, nB5, nRst, nC6, $02, smpsNoAttack, nCs6, smpsNoAttack, nD6
	dc.b	$08, nCs6, $06, nB5, nRst, nA5, $18
	smpsLoop            $00, $02, Snd_SpecialS_Call00
	dc.b	nFs5, $12, nAb5, nA5, $0C, nBb5, $03, smpsNoAttack, nB5, $09, nA5, $06
	dc.b	nAb5, nRst, nFs5, $12, nE5, $12, nB5, nA5, $24, nE5, $18, nFs5
	dc.b	$12, nAb5, nA5, $0C, nAb5, $12, nA5, nB5, $0C, nCs6, $18, nB5
	dc.b	nCs6, nE6
	smpsReturn

Snd_SpecialS_Call01:
	dc.b	nFs6, $12, nFs6, nE6, $0C, nFs6, $12, nFs6, nE6, $06, nFs6, nA6
	dc.b	$12, nAb6, nE6, $0C, nCs6, $24, nD6, $06, nE6, nFs6, $12, nFs6
	dc.b	nE6, $0C, nFs6, $12, nFs6, nE6, $06, nFs6, nA6, $12, nAb6, nCs7
	dc.b	$3C, nFs6, $12, nFs6, nE6, $0C, nFs6, $12, nFs6, nE6, $06, nFs6
	dc.b	nA6, $12, nAb6, nE6, $0C, nCs6, $24, nD6, $06, nE6, nFs6, $12
	dc.b	nFs6, nE6, $0C, nFs6, $12, nFs6, nE6, $06, nFs6, nA6, $12, nAb6
	dc.b	nCs7, $24, nAb6, $18, nFs6, $24, $06, nAb6, nA6, $12, nAb6, nE6
	dc.b	$0C, nA6, $60
	smpsReturn

Snd_SpecialS_Call02:
	dc.b	nFs6, $24, $06, $06, $12, nE6, nD6, $0C, nE6, $60, nD6, $24
	dc.b	$06, $06, $12, nCs6, nB5, $0C, nCs6, $48, nB5, $18, nA5, $24
	dc.b	$06, $06, $12, nB5, nCs6, $0C

Snd_SpecialS_Loop22:
	dc.b	nA5, $30, $12, nB5, nCs6, $0C
	smpsLoop            $00, $02, Snd_SpecialS_Loop22
	dc.b	nCs6, $18, nB5, nCs6
	smpsReturn

Snd_SpecialS_Call03:
	dc.b	nG6, $06, nE6, nD6, $0C, nD6, $02, nE6, $04, nD6, $0C, nE6
	dc.b	nD6, nD5, $06, nB4, nA4, nG4, nE4, nD4, nE4, nG4, nE4, nG4
	dc.b	nA4, nB4, nA4, nB4, nD5, nD5, $03, nE5, $09, nD5, $0C, nB4
	dc.b	$06, nA4, nB4, nD5, nE5, nD5, nE5, nFs5, nG5, nA5, nB5, nCs6
	dc.b	nD6, nCs6, nB5, nG6, nFs6, nE6, nFs6, nE6, nD6, nFs6, nE6, nD6
	dc.b	nCs6, $04, nD6, nCs6, nB5, $06, nA5, nFs5, nE5, nD5, nCs5, $04
	dc.b	nD5, $06, nCs5, $08, nB4, $06, nA4, nG4, $0C, nA4, $06, nG4
	dc.b	$0C, nFs4, nE4, nFs4, $06, nD4, nE4, nFs4, nG4, nA4, nB4, nG4
	dc.b	nA4, nCs5, nD5, nE5, nFs5, nG5, nFs5, nG5, $03, nA5, $09, nG5
	dc.b	$06, nE5, $0C, nD5, $06, nRst, nE5, nRst, nD5, nA4, nG4, smpsNoAttack
	dc.b	$0C, nFs4, $03, nF4, nE4
	smpsReturn

; FM2 Data
Snd_SpecialS_FM2:
	smpsSetvoice        $00
	dc.b	nRst, $12, nA2, $06, nE2, nRst, nA2, nRst, nB2, nRst, nCs3, nRst
	dc.b	nE2, nRst, nFs2, nRst, nA2, nA2, nE3, nA3, nA3, nRst, nA3, nA3
	dc.b	nRst, nG3, nRst, nG3, nG2, nD3, nG3, $0C, nRst, $60

Snd_SpecialS_Loop0D:
	dc.b	nA2, $12, nE3, nA2, $0C, nG2, $12, nD3, nG2, $0C
	smpsLoop            $00, $04, Snd_SpecialS_Loop0D

Snd_SpecialS_Loop0E:
	dc.b	nFs2, $12, nCs3, nFs2, $0C, nB2, $12, nFs2, nB2, $0C, nE2, $12
	dc.b	nB2, nE2, $0C, nA2, $12, nE3, nA2, $0C
	smpsLoop            $00, $02, Snd_SpecialS_Loop0E

Snd_SpecialS_Loop0F:
	dc.b	nD2, $12, nA2, nD3, $0C, nD2, $12, nA2, nD2, $0C, nA2, $12
	dc.b	nA2, $06, nRst, $0C, nE2, nA2, $18, nE2
	smpsLoop            $00, $04, Snd_SpecialS_Loop0F
	dc.b	nD2, $12, nA2, nD2, $0C, nE2, $12, nAb2, nB2, $0C, nA2, $06
	dc.b	nA2, nE3, nA3, nA3, nRst, nA3, nA3, nRst, nG3, nRst, nG3, nG2
	dc.b	nD3, nG3, $0C

Snd_SpecialS_Loop10:
	dc.b	nD2, $12, nA2, $06, nRst, $0C, nD3, $3C, nA2, $12, nA2, $06
	dc.b	nRst, $0C, nA2, $3C
	smpsLoop            $00, $02, Snd_SpecialS_Loop10
	dc.b	nFs2, $12, nA2, $06, nRst, $0C, nCs3, $3C, nF2, $12, nA2, $06
	dc.b	nRst, $0C, nCs3, $3C, nE2, $12, nA2, $06, nRst, $0C, nCs3, $3C
	dc.b	nA2, $18, nAb2, nFs2, nE2

Snd_SpecialS_Loop11:
	dc.b	nA2, $12, nE3, nA2, $0C, nG2, $12, nD3, nG2, $0C
	smpsLoop            $00, $07, Snd_SpecialS_Loop11
	dc.b	nA2, $12, nE3, nA2, $0C, nG2, $06, $0C, nG3, $12, nA3, $0C
	smpsJump            Snd_SpecialS_Loop0D

; Unreachable
	smpsStop

; FM3 Data
Snd_SpecialS_FM3:
	smpsSetvoice        $01
	smpsPan             panRight, $00
	dc.b	nA4, $06, nRst, $0C, nA3, $06, nE3, nRst, nA3, nRst, nB3, nRst
	dc.b	nCs4, nRst, nE4, nRst, nG4, nRst, nA4, nA4, nRst, nA4, nA4, nRst
	dc.b	nA4, nA4, nRst, nG4, nRst, nG4, nG4, $0C, nA4, nRst, $60

Snd_SpecialS_Jump02:
	smpsSetvoice        $02

Snd_SpecialS_Loop09:
	dc.b	nCs4, $0C, nA3, $06, nE3, nRst, nA3, nRst, nB3, $0C, nG3, $06
	dc.b	nG3, nG3, $0C, nD3, $06, nB3, nB3
	smpsLoop            $00, $04, Snd_SpecialS_Loop09

Snd_SpecialS_Loop0A:
	dc.b	nA3, $0C, nFs3, $06, nA3, nRst, nFs3, nRst, nB3, $0C, nD3, $06
	dc.b	nD3, nFs3, $0C, nD3, $06, nFs3, nB3, nE3, $0C, nB2, $06, nB2
	dc.b	nRst, nE3, nRst, nA3, $0C, nE3, $06, nE3, nA3, $0C, nA2, $06
	dc.b	nE3, nCs3
	smpsLoop            $00, $02, Snd_SpecialS_Loop0A

Snd_SpecialS_Loop0B:
	dc.b	nA3, $12, $06, nRst, $18
	smpsLoop            $00, $02, Snd_SpecialS_Loop0B
	dc.b	nCs4, $12, $06, nRst, $0C, nA3, $3C
	smpsLoop            $01, $04, Snd_SpecialS_Loop0B
	dc.b	nA3, $30, nB3, $12, nB3, nB3, $0C
	smpsSetvoice        $01
	dc.b	nA4, $06, nA4, nRst, nA4, nA4, nRst, nA4, nA4, nRst, nG4, nRst
	dc.b	nG4, nG4, $0C, nA4
	smpsSetvoice        $02
	dc.b	nA3, $60, nA3, nA3, nA3, nFs3, nF3, nE3, nA3, $18, nAb3, nFs3
	dc.b	nE3

Snd_SpecialS_Loop0C:
	dc.b	nCs4, $0C, nA3, $06, nE3, nRst, nA3, nRst, nB3, $0C, nG3, $06
	dc.b	nG3, nG3, $0C, nD3, $06, nB3, nB3
	smpsLoop            $00, $07, Snd_SpecialS_Loop0C
	smpsSetvoice        $01
	smpsFMAlterVol      $08
	dc.b	nE4, $12
	smpsFMAlterVol      $FC
	dc.b	nA4
	smpsFMAlterVol      $FC
	dc.b	nA4
	smpsFMAlterVol      $FB
	dc.b	nG4, $0C, $12, nA4, $0C
	smpsFMAlterVol      $05
	smpsJump            Snd_SpecialS_Jump02

; Unreachable
	smpsStop

; FM4 Data
Snd_SpecialS_FM4:
	smpsSetvoice        $01
	smpsPan             panLeft, $00
	dc.b	nA5, $06, nRst, $0C, nA4, $06, nE4, nRst, nA4, nRst, nB4, nRst
	dc.b	nCs5, nRst, nE5, nRst, nG5, nRst, nA5, nA5, nRst, nA5, nA5, nRst
	dc.b	nA5, nA5, nRst, nG5, nRst, nG5, nG5, $0C, nA5, nRst, $60

Snd_SpecialS_Jump01:
	smpsSetvoice        $02

Snd_SpecialS_Loop05:
	dc.b	nE4, $0C, nA4, $06, nCs4, nRst, nE4, nRst, nD4, $12, nB3, $06
	dc.b	nD4, $0C, nG3, $06, nG4, nD4
	smpsLoop            $00, $04, Snd_SpecialS_Loop05

Snd_SpecialS_Loop06:
	dc.b	nCs4, $0C, nFs4, $06, nCs4, nRst, nCs4, nRst, nD4, $0C, nFs3, $06
	dc.b	nB3, nD4, $0C, nFs3, $06, nB3, nD4, nB3, $0C, nE3, $06, nAb3
	dc.b	nRst, nB3, nRst, nCs4, $0C, nA3, $06, nB3, nCs4, $0C, nE3, $06
	dc.b	nA3, nCs4
	smpsLoop            $00, $02, Snd_SpecialS_Loop06

Snd_SpecialS_Loop07:
	dc.b	nFs4, $12, nFs4, $06, nRst, $18
	smpsLoop            $00, $02, Snd_SpecialS_Loop07
	dc.b	nA4, $12, nA4, $06, nRst, $0C, nE4, $3C
	smpsLoop            $01, $04, Snd_SpecialS_Loop07
	dc.b	nFs4, $30, nAb4, $12, nAb4, nAb4, $0C
	smpsSetvoice        $01
	dc.b	nA5, $06, nA5, nRst, nA5, nA5, nRst, nA5, nA5, nRst, nG5, nRst
	dc.b	nG5, nG5, $0C, nA5
	smpsSetvoice        $02
	dc.b	nFs4, $60, nE4, nD4, nCs4, nCs4, nCs4, nCs4, nCs4, $18, nB3, nA3
	dc.b	nAb3

Snd_SpecialS_Loop08:
	dc.b	nE4, $0C, nA4, $06, nCs4, nRst, nE4, nRst, nD4, $12, nB3, $06
	dc.b	nD4, $0C, nG3, $06, nG4, nD4
	smpsLoop            $00, $07, Snd_SpecialS_Loop08
	smpsSetvoice        $01
	smpsFMAlterVol      $08
	dc.b	nA4, $12
	smpsFMAlterVol      $FC
	dc.b	nCs5
	smpsFMAlterVol      $FC
	dc.b	nE5
	smpsFMAlterVol      $FB
	dc.b	nG5, $0C, $12, nA5, $0C
	smpsFMAlterVol      $05
	smpsJump            Snd_SpecialS_Jump01

; Unreachable
	smpsStop

; FM5 Data
Snd_SpecialS_FM5:
	smpsSetvoice        $02
	dc.b	nA5, $06, nRst, $0C, nA4, $06, nE4, nRst, nA4, nRst, nB4, nRst
	dc.b	nCs5, nRst, nE5, nRst, nG5, nRst, nA5, nA5, nRst, nA5, nA5, nRst
	dc.b	nA5, nA5, nRst, nG5, nRst, nG5, nG5, $0C, nA5, nRst, $60
	smpsAlterNote       $F8

Snd_SpecialS_Jump00:
	smpsSetvoice        $03
	smpsModSet          $14, $01, $06, $06
	dc.b	nRst, $12
	smpsCall            Snd_SpecialS_Call00
	smpsCall            Snd_SpecialS_Call01
	smpsCall            Snd_SpecialS_Call02
	dc.b	nE6, $06
	smpsSetvoice        $04
	smpsFMAlterVol      $FB
	dc.b	nE6, $66, nRst, $06, nE6, nRst, nE6, $0C
	smpsFMAlterVol      $0A
	dc.b	nRst, $03
	smpsCall            Snd_SpecialS_Call03
	smpsFMAlterVol      $FB
	smpsJump            Snd_SpecialS_Jump00

; Unreachable
	smpsStop

; PSG1 Data
Snd_SpecialS_PSG1:
	dc.b	nRst, $12, nA2, $06, nE2, nRst, nA2, nRst, nB2, nRst, nCs3, nRst
	dc.b	nE3, nRst, nG3, nRst, nA3, nA3, nRst, nA3, nA3, nRst, nA3, nA3
	dc.b	nRst, nG3, nRst, nG3, nG3, $0C, nA3, nRst, $60

Snd_SpecialS_Loop1E:
	dc.b	nE2, $0C, nA2, $06, nCs2, nRst, nE2, nRst, nD2, $12, nB1, $06
	dc.b	nD2, $0C, nG1, $06, nG2, nD2
	smpsLoop            $00, $04, Snd_SpecialS_Loop1E

Snd_SpecialS_Loop1F:
	dc.b	nCs2, $0C, nFs2, $06, nCs2, nRst, nCs2, nRst, nD2, $0C, nFs1, $06
	dc.b	nB1, nD2, $0C, nFs1, $06, nB1, nD2, nB1, $0C, nE1, $06, nAb1
	dc.b	nRst, nB1, nRst, nCs2, $0C, nA1, $06, nB1, nCs2, $0C, nE1, $06
	dc.b	nA1, nCs2
	smpsLoop            $00, $02, Snd_SpecialS_Loop1F
	smpsPSGvoice        sTone_09

Snd_SpecialS_Loop20:
	dc.b	nFs2, $60, nE2, nFs2, nA2
	smpsLoop            $00, $02, Snd_SpecialS_Loop20
	dc.b	nFs2, $30, nAb2, $12, nAb2, nAb2, $0C
	smpsPSGvoice        sTone_0C
	dc.b	nA3, $06, nA3, nRst, nA3, nA3, nRst, nA3, nA3, nRst, nG3, nRst
	dc.b	nG3, nG3, $0C, nA3
	smpsPSGvoice        sTone_09
	smpsCall            Snd_SpecialS_Call04
	dc.b	nG1, nAb1, nA1, nBb1, nB1, nC2
	smpsPSGAlterVol     $02
	smpsPSGvoice        sTone_0C

Snd_SpecialS_Loop21:
	dc.b	nE2, $0C, nA2, $06, nCs2, nRst, nE2, nRst, nD2, $12, nB1, $06
	dc.b	nD2, $0C, nG1, $06, nG2, nD2
	smpsLoop            $00, $07, Snd_SpecialS_Loop21
	dc.b	nE2, $0C, nA2, $06, nCs2, nRst, nE2, nRst, nD2, $0C, nG2, $0C
	dc.b	$12, nA2, $0C
	smpsJump            Snd_SpecialS_Loop1E

; Unreachable
	smpsStop

; PSG2 Data
Snd_SpecialS_PSG2:
	dc.b	nRst, $12, nA1, $06, nE1, nRst, nA1, nRst, nB1, nRst, nCs2, nRst
	dc.b	nE2, nRst, nG2, nRst, nE2, nE2, nRst, nE2, nE2, nRst, nE2, nE2
	dc.b	nRst, nD2, nRst, nD2, nD2, $0C, nE2, nRst, $60

Snd_SpecialS_Loop1A:
	dc.b	nCs2, $0C, nA1, $06, nE1, nRst, nA1, nRst, nB1, $0C, nG1, $06
	dc.b	nG1, nG1, $0C, nD1, $06, nB1, nB1
	smpsLoop            $00, $04, Snd_SpecialS_Loop1A

Snd_SpecialS_Loop1B:
	dc.b	nA1, $0C, nFs1, $06, nA1, nRst, nFs1, nRst, nB1, $0C, nD1, $06
	dc.b	nD1, nFs1, $0C, nD1, $06, nFs1, nB1, nE1, $0C, nB0, $06, nB0
	dc.b	nRst, nE1, nRst, nA1, $0C, nE1, $06, nE1, nA1, $0C, nA0, $06
	dc.b	nE1, nCs1
	smpsLoop            $00, $02, Snd_SpecialS_Loop1B
	smpsPSGvoice        sTone_09

Snd_SpecialS_Loop1C:
	dc.b	nD2, $60, nCs2, nD2, nE2
	smpsLoop            $00, $02, Snd_SpecialS_Loop1C
	dc.b	nD2, $30, nE2, $12, nE2, nE2, $0C
	smpsPSGvoice        sTone_0C
	dc.b	nE2, $06, nE2, nRst, nE2, nE2, nRst, nE2, nE2, nRst, nD2, nRst
	dc.b	nD2, nD2, $0C, nE2
	smpsPSGvoice        sTone_09
	smpsAlterNote       $FE
	smpsPSGAlterVol     $02
	dc.b	nRst, $12
	smpsCall            Snd_SpecialS_Call04
	smpsPSGvoice        sTone_0C

Snd_SpecialS_Loop1D:
	dc.b	nCs2, $0C, nA1, $06, nE1, nRst, nA1, nRst, nB1, $0C, nG1, $06
	dc.b	nG1, nG1, $0C, nD1, $06, nB1, nB1
	smpsLoop            $00, $07, Snd_SpecialS_Loop1D
	dc.b	nCs2, $0C, nA1, $06, nE1, nRst, nA1, nRst, nB1, $0C, nD2, $0C
	dc.b	$12, nCs2, $0C
	smpsJump            Snd_SpecialS_Loop1A

; Unreachable
	smpsStop

Snd_SpecialS_Call04:
	dc.b	nD2, $24, $06, $06, $12, nCs2, nB1, $0C, nCs2, $60, nA1, $24
	dc.b	$06, $06, $12, $12, nE1, $0C, nA1, $48, nAb1, $18, nFs1, $24
	dc.b	$06, $06, $12, nAb1, nA1, $0C, nF1, $30, $12, nAb1, nA1, $0C
	dc.b	nE1, $30, $12, nAb1, nA1, $0C, nA1, $18, nAb1
	smpsPSGAlterVol     $FE
	dc.b	nA0, $03, nBb0, nB0, nC1, nCs1, nD1, nEb1, nE1, nF1, nFs1
	smpsReturn

; PSG3 Data
Snd_SpecialS_PSG3:
	smpsPSGform         $E7
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2, $0C

Snd_SpecialS_Loop12:
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsLoop            $00, $03, Snd_SpecialS_Loop12

Snd_SpecialS_Loop13:
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2, nMaxPSG2
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG2
	smpsPSGAlterVol     $04
	dc.b	nMaxPSG2
	smpsLoop            $00, $07, Snd_SpecialS_Loop13
	dc.b	nMaxPSG2, nMaxPSG2, nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2

Snd_SpecialS_Loop14:
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2, nMaxPSG2
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG2
	smpsPSGAlterVol     $04
	dc.b	nMaxPSG2
	smpsLoop            $00, $03, Snd_SpecialS_Loop14
	dc.b	nMaxPSG2, nMaxPSG2, nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsLoop            $01, $04, Snd_SpecialS_Loop14

Snd_SpecialS_Loop15:
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2, nMaxPSG2
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG2
	smpsPSGAlterVol     $04
	dc.b	nMaxPSG2
	smpsLoop            $00, $0F, Snd_SpecialS_Loop15
	dc.b	nMaxPSG2, nMaxPSG2, nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2

Snd_SpecialS_Loop16:
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2, $0C
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG2
	smpsPSGAlterVol     $04
	dc.b	nMaxPSG2
	smpsLoop            $00, $10, Snd_SpecialS_Loop16

Snd_SpecialS_Loop17:
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG2
	smpsPSGAlterVol     $04
	dc.b	nMaxPSG2
	smpsLoop            $00, $03, Snd_SpecialS_Loop17
	dc.b	nMaxPSG2, $06, nMaxPSG2, nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	smpsLoop            $01, $02, Snd_SpecialS_Loop17

Snd_SpecialS_Loop18:
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG2
	smpsPSGAlterVol     $04
	dc.b	nMaxPSG2
	smpsLoop            $00, $20, Snd_SpecialS_Loop18

Snd_SpecialS_Loop19:
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2, nMaxPSG2
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG2
	smpsPSGAlterVol     $04
	dc.b	nMaxPSG2
	smpsLoop            $00, $03, Snd_SpecialS_Loop19
	dc.b	nMaxPSG2, nMaxPSG2, nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsLoop            $01, $08, Snd_SpecialS_Loop19
	smpsJump            Snd_SpecialS_Loop14

; Unreachable
	smpsStop

; DAC Data
Snd_SpecialS_DAC:
	dc.b	dQuickLooseSnare, $06, dKickS3, $0C, dQuickLooseSnare, $06, dKickS3, $0C, dKickS3, dKickS3, dKickS3, dQuickLooseSnare
	dc.b	dKickS3, dQuickLooseSnare, $06, dQuickLooseSnare, $0C, dQuickLooseSnare, $06, dKickS3, $0C, dQuickLooseSnare, $06, dQuickLooseSnare
	dc.b	$0C, dKickS3, dKickS3, $06, dQuickLooseSnare, $0C, dQuickLooseSnare, $06, dQuickLooseSnare, dKickS3, $06, dElectricHighTom
	dc.b	$03, dElectricHighTom, dElectricHighTom, $06, dElectricHighTom, dElectricMidTom, dElectricMidTom, dElectricMidTom, dElectricLowTom, dElectricLowTom, dElectricLowTom, dKickS3
	dc.b	dKickS3, dQuickLooseSnare, dKickS3, $12

Snd_SpecialS_Loop00:
	dc.b	dKickS3, $12, dKickS3, $06, dQuickLooseSnare, dKickS3, $0C, dKickS3, dKickS3, $12, dQuickLooseSnare, $06
	dc.b	dKickS3, $12
	smpsLoop            $00, $03, Snd_SpecialS_Loop00
	dc.b	dKickS3, $12, dKickS3, $06, dQuickLooseSnare, dKickS3, $0C, dKickS3, dKickS3, $12, dQuickLooseSnare, $0C
	dc.b	dQuickLooseSnare, $06, dQuickLooseSnare

Snd_SpecialS_Loop01:
	dc.b	dKickS3, $12, dKickS3, $06, dQuickLooseSnare, $0C, dKickS3, $06, dQuickLooseSnare, $12, dKickS3, $0C
	dc.b	dQuickLooseSnare, dKickS3, $06, dKickS3
	smpsLoop            $00, $03, Snd_SpecialS_Loop01
	dc.b	dKickS3, $12, dKickS3, $06, dQuickLooseSnare, $0C, dKickS3, dQuickLooseSnare, dKickS3, dQuickLooseSnare, dKickS3

Snd_SpecialS_Loop02:
	dc.b	dKickS3, $12, dKickS3, $06, dQuickLooseSnare, $0C, dKickS3
	smpsLoop            $00, $10, Snd_SpecialS_Loop02
	dc.b	dKickS3, $12, dKickS3, $06, dQuickLooseSnare, $0C, dKickS3, $12, dKickS3, dQuickLooseSnare, $06, dKickS3
	dc.b	$12, dQuickLooseSnare, $06, dQuickLooseSnare, $0C, dQuickLooseSnare, $06, dKickS3, $0C, dQuickLooseSnare, $06, dQuickLooseSnare
	dc.b	$0C, dKickS3, dKickS3, $06, dQuickLooseSnare, $0C, dQuickLooseSnare, $06, dQuickLooseSnare, $06

Snd_SpecialS_Loop03:
	dc.b	dKickS3, $12, dKickS3, dKickS3, $24, dQuickLooseSnare, $18
	smpsLoop            $00, $07, Snd_SpecialS_Loop03
	dc.b	dKickS3, $12, dKickS3, $06, dQuickLooseSnare, $0C, dKickS3, $1E, dKickS3, $06, dQuickLooseSnare, dQuickLooseSnare
	dc.b	dQuickLooseSnare, dQuickLooseSnare

Snd_SpecialS_Loop04:
	dc.b	dKickS3, $12, dKickS3, $06, dQuickLooseSnare, dKickS3, $0C, dKickS3, dKickS3, $12, dQuickLooseSnare, $06
	dc.b	dKickS3, $12
	smpsLoop            $00, $07, Snd_SpecialS_Loop04
	dc.b	dKickS3, $06, dKickS3, dQuickLooseSnare, dKickS3, dKickS3, dQuickLooseSnare, $0C, dQuickLooseSnare, $06, dKickS3, dElectricHighTom
	dc.b	$03, dElectricHighTom, dElectricHighTom, $06, dElectricHighTom, dElectricMidTom, dElectricMidTom, dElectricLowTom, dElectricLowTom
	smpsJump            Snd_SpecialS_Loop00

; Unreachable
	smpsStop

Snd_SpecialS_Voices:
;	Voice $00
;	$3C
;	$01, $00, $00, $00, 	$1F, $1F, $15, $1F, 	$11, $0D, $12, $05
;	$07, $04, $09, $02, 	$55, $3A, $25, $1A, 	$1A, $80, $07, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $15, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $12, $0D, $11
	smpsVcDecayRate2    $02, $09, $04, $07
	smpsVcDecayLevel    $01, $02, $03, $05
	smpsVcReleaseRate   $0A, $05, $0A, $05
	smpsVcTotalLevel    $00, $07, $00, $1A

;	Voice $01
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

;	Voice $02
;	$03
;	$00, $D7, $33, $02, 	$5F, $9F, $5F, $1F, 	$13, $0F, $0A, $0A
;	$10, $0F, $02, $09, 	$35, $15, $25, $1A, 	$13, $16, $15, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $03, $0D, $00
	smpsVcCoarseFreq    $02, $03, $07, $00
	smpsVcRateScale     $00, $01, $02, $01
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $0A, $0F, $13
	smpsVcDecayRate2    $09, $02, $0F, $10
	smpsVcDecayLevel    $01, $02, $01, $03
	smpsVcReleaseRate   $0A, $05, $05, $05
	smpsVcTotalLevel    $00, $15, $16, $13

;	Voice $03
;	$34
;	$00, $02, $01, $01, 	$1F, $1F, $1F, $1F, 	$10, $06, $06, $06
;	$01, $06, $06, $06, 	$35, $1A, $15, $1A, 	$10, $80, $18, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $02, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $06, $06, $10
	smpsVcDecayRate2    $06, $06, $06, $01
	smpsVcDecayLevel    $01, $01, $01, $03
	smpsVcReleaseRate   $0A, $05, $0A, $05
	smpsVcTotalLevel    $00, $18, $00, $10

;	Voice $04
;	$3E
;	$07, $01, $02, $01, 	$1F, $1F, $1F, $1F, 	$0D, $06, $00, $00
;	$08, $06, $00, $00, 	$15, $0A, $0A, $0A, 	$1B, $80, $80, $80
	smpsVcAlgorithm     $06
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $02, $01, $07
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $06, $0D
	smpsVcDecayRate2    $00, $00, $06, $08
	smpsVcDecayLevel    $00, $00, $00, $01
	smpsVcReleaseRate   $0A, $0A, $0A, $05
	smpsVcTotalLevel    $00, $00, $00, $1B

