Snd_BPZ_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_BPZ_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $08

	smpsHeaderDAC       Snd_BPZ_DAC
	smpsHeaderFM        Snd_BPZ_FM1,	$F4, $0B
	smpsHeaderFM        Snd_BPZ_FM2,	$00, $09
	smpsHeaderFM        Snd_BPZ_FM3,	$F4, $0B
	smpsHeaderFM        Snd_BPZ_FM4,	$00, $0B
	smpsHeaderFM        Snd_BPZ_FM5,	$00, $0B
	smpsHeaderPSG       Snd_BPZ_PSG1,	$F4, $03, $00, $00
	smpsHeaderPSG       Snd_BPZ_PSG2,	$F4, $03, $00, $00
	smpsHeaderPSG       Snd_BPZ_PSG3,	$00, $00, $00, $00

; FM1 Data
Snd_BPZ_FM1:
	dc.b	nRst, $30

Snd_BPZ_Jump04:
	smpsSetvoice        $00
	smpsCall            Snd_BPZ_Call01
	smpsModSet          $18, $01, $FE, $FF
	dc.b	nE5, $30, smpsNoAttack, $0C
	smpsModOff
	smpsSetvoice        $05
	smpsCall            Snd_BPZ_Call01
	smpsModSet          $0C, $01, $FF, $30
	dc.b	nE5, $30, smpsNoAttack, $0C
	smpsModOff
	smpsSetvoice        $01
	smpsAlterPitch      $0C
	smpsCall            Snd_BPZ_Call02
	smpsSetvoice        $00
	smpsAlterPitch      $F4
	dc.b	nAb5, $06, nA5, nRst, nAb5, nRst, nFs5, nRst, nE5, nFs5, $18, nAb5
	dc.b	nEb5, $06, nE5, nRst, nEb5, nRst, nB4, nCs5, nB4, $30, smpsNoAttack, $06
	dc.b	nAb5, nA5, nRst, nAb5, nRst, nFs5, nRst, nE5, nFs5, $18, nAb5, nE5
	dc.b	$06, nFs5, nRst, nAb5, nRst, nB5, nCs6, nB5, $30, smpsNoAttack, $06, nAb5
	dc.b	nA5, nRst, nAb5, nRst, nFs5, nRst, nE5, nFs5, $18, nAb5, nEb5, $06
	dc.b	nE5, nRst, nEb5, nRst, nB4, nCs5, nB4, $30, smpsNoAttack, $06, nRst, $0C
	dc.b	nB4, $06, nRst, nE5, $18, nEb5, nE5, nFs5, $0C, nB4, nD5, nEb5
	dc.b	nFs5, nB5, $24
	smpsJump            Snd_BPZ_Jump04

Snd_BPZ_Call01:
	smpsPan             panCenter, $00
	dc.b	nRst, $0C, nE4, $04, nRst, $02, nG4, $04, nRst, $02, nAb4, $0C
	dc.b	nB4, $06, nRst, nD5, $12, nCs5, nB4, $03, nRst, $09, nA4, $12
	dc.b	nAb4, nE4, $04, nRst, $08, nE4, $04, nRst, $08, nEb4, $04, nRst
	dc.b	$08, nE4, $06, nFs4, nAb4, $0C, nRst, nE4, $04, nRst, $02, nG4
	dc.b	$04, nRst, $02, nAb4, $0C, nB4, nD5, $12, nCs5, nB4, $04, nRst
	dc.b	$08, nA4, $12, nAb4, nA4, $04, nRst, $08, nB4, $04, nRst, $08
	dc.b	nCs5, $04, nRst, $08, nD5, $0C, nE5, $06, nRst
	smpsFMAlterVol      $FF
	dc.b	nA4, nAb4, nA4, nAb4, nA4, nAb4, nA4, nAb4
	smpsFMAlterVol      $FF
	dc.b	nA4, $0C, nAb4, $06, nA4, $0C, nAb4, $06, nA4, $0C
	smpsFMAlterVol      $FF
	dc.b	nB4, $06, nBb4, nB4, nBb4, nB4, nBb4, nB4, nBb4
	smpsFMAlterVol      $FF
	dc.b	nB4, nRst, nC5, nRst, nCs5, nRst, nD5, nRst
	smpsFMAlterVol      $04
	dc.b	nRst, $0C, nE4, $04, nRst, $02, nG4, $04, nRst, $02, nAb4, $0C
	dc.b	nB4, nD5, $12, nCs5, nA4, $0C, nAb4, $0F, nFs5, $03, nAb5, $12
	smpsReturn

Snd_BPZ_Call02:
	dc.b	nCs5, $30, smpsNoAttack, $30, nEb5, smpsNoAttack, $30, $30, smpsNoAttack, $30, nE5, nE5
	dc.b	nE5, smpsNoAttack, $30, nFs5, smpsNoAttack, $30, nE5, nFs5, nFs5, smpsNoAttack, $30
	smpsReturn

; FM2 Data
Snd_BPZ_FM2:
	smpsSetvoice        $02
	dc.b	nRst, $30

Snd_BPZ_Loop04:
	dc.b	nE2, $04, nRst, $08, nB2, $04, nRst, $08, nE3, $0C, nB2, $04
	dc.b	nRst, $02, nD3, $04, nRst, $08, nD3, $06, nCs3, $0C, nB2, nA2
	dc.b	nE2, $04, nRst, $08, nE2, $04, nRst, $08, nB2, $0C, nCs3, $06
	dc.b	nD3, nRst, nD3, nRst, nCs3, $0C, nB2, $06, nA2, $0C
	smpsLoop            $00, $02, Snd_BPZ_Loop04
	dc.b	nA2, $04, nRst, $08, nA2, $08, nRst, $04, nA2, $04, nRst, $08
	dc.b	nA2, $08, nRst, $04, nA2, $04, nRst, $08, nA2, $08, nRst, $04
	dc.b	nA2, $04, nRst, $08, nA2, $08, nRst, $04, nB2, $04, nRst, $08
	dc.b	nB2, $08, nRst, $04, nB2, $04, nRst, $08, nB2, $08, nRst, $04
	dc.b	nB2, $04, nRst, $08, nB2, $08, nRst, $04, nB2, $04, nRst, $08
	dc.b	nB2, $08, nRst, $04, nE2, $04, nRst, $08, nB2, $08, nRst, $04
	dc.b	nE3, $0C, nB2, $04, nRst, $02, nD3, $04, nRst, $08, nD3, $06
	dc.b	nCs3, $0C, nB2, nA2, nE2, $04, nRst, $08, nE2, $08, nRst, $04
	dc.b	nB2, $0C, nCs3, $06, nD3, nRst, nD3, nRst, nCs3, $0C, nB2, $06
	dc.b	nA2, $0C

Snd_BPZ_Loop05:
	dc.b	nE2, $04, nRst, $08, nB2, $04, nRst, $08, nE3, $0C, nB2, $04
	dc.b	nRst, $02, nD3, $04, nRst, $08, nD3, $06, nCs3, $0C, nB2, nA2
	dc.b	nE2, $04, nRst, $08, nE2, $04, nRst, $08, nB2, $0C, nCs3, $06
	dc.b	nD3, nRst, nD3, nRst, nCs3, $0C, nB2, $06, nA2, $0C
	smpsLoop            $00, $02, Snd_BPZ_Loop05
	dc.b	nA2, $04, nRst, $08, nA2, $04, nRst, $08, nA2, $04, nRst, $08
	dc.b	nA2, $04, nRst, $08, nA2, $04, nRst, $08, nA2, $04, nRst, $08
	dc.b	nA2, $04, nRst, $08, nA2, $04, nRst, $08, nB2, $04, nRst, $08
	dc.b	nB2, $04, nRst, $08, nB2, $04, nRst, $08, nB2, $04, nRst, $08
	dc.b	nB2, $04, nRst, $08, nB2, $04, nRst, $08, nB2, $04, nRst, $08
	dc.b	nB2, $04, nRst, $08, nE2, $04, nRst, $08, nB2, $04, nRst, $08
	dc.b	nE3, $0C, nB2, $04, nRst, $02, nD3, $04, nRst, $08, nD3, $06
	dc.b	nCs3, $0C, nB2, nA2, nE2, $04, nRst, $08, nE2, $04, nRst, $08
	dc.b	nB2, $0C, nCs3, $06, nD3, nRst, nD3, nRst, nCs3, $0C, nB2, $06
	dc.b	nA2, $0C, nA2, $04, nRst, $08, nA2, $08, nRst, $04, nA2, $04
	dc.b	nRst, $08, nA2, $08, nRst, $04, nA2, $04, nRst, $08, nA2, $08
	dc.b	nRst, $04, nA2, $04, nRst, $08, nA2, $08, nRst, $04, nA2, $04
	dc.b	nRst, $08, nA2, $08, nRst, $04, nA2, $04, nRst, $08, nA2, $08
	dc.b	nRst, $04, nA2, $04, nRst, $08, nB2, $08, nRst, $04, nA2, $04
	dc.b	nRst, $08, nFs2, $08, nRst, $04, nAb2, $04, nRst, $08, nAb2, $08
	dc.b	nRst, $04, nAb2, $04, nRst, $08, nAb2, $08, nRst, $04, nAb2, $04
	dc.b	nRst, $08, nE2, $08, nRst, $04, nAb2, $04, nRst, $08, nB2, $08
	dc.b	nRst, $04, nCs3, $04, nRst, $08, nAb2, $08, nRst, $04, nCs3, $04
	dc.b	nRst, $08, nEb3, $08, nRst, $04, nB2, $04, nRst, $08, nEb3, $08
	dc.b	nRst, $04, nFs3, $04, nRst, $08, nEb3, $0C, nA2, $04, nRst, $08
	dc.b	nA2, $08, nRst, $04, nA2, $04, nRst, $08, nA2, $08, nRst, $04
	dc.b	nA2, $04, nRst, $08, nFs2, $08, nRst, $04, nA2, $04, nRst, $08
	dc.b	nCs3, $08, nRst, $04, nB2, $04, nRst, $08, nB2, $08, nRst, $04
	dc.b	nB2, $04, nRst, $08, nB2, $08, nRst, $04, nB2, $04, nRst, $08
	dc.b	nEb3, $08, nRst, $04, nCs3, $04, nRst, $08, nB2, $08, nRst, $04
	dc.b	nCs3, $04, nRst, $08, nAb2, $08, nRst, $04, nCs3, $04, nRst, $08
	dc.b	nEb3, $08, nRst, $04, nD3, $04, nRst, $08, nFs3, $08, nRst, $04
	dc.b	nA3, $04, nRst, $08, nD3, $08, nRst, $04, nEb3, $04, nRst, $08
	dc.b	nEb3, $08, nRst, $04, nFs3, $04, nRst, $08, nEb3, $08, nRst, $04
	dc.b	nB2, $04, nRst, $08, nB2, $08, nRst, $04, nEb3, $04, nRst, $08
	dc.b	nB2, $08, nRst, $04

Snd_BPZ_Loop06:
	dc.b	nE2, $04, nRst, $08, nE2, $08, nRst, $04, nE2, $04, nRst, $08
	dc.b	nE2, $08, nRst, $04, nA2, $04, nRst, $08, nA2, $08, nRst, $04
	dc.b	nB2, $04, nRst, $08, nB2, $08, nRst, $04
	smpsLoop            $00, $04, Snd_BPZ_Loop06

Snd_BPZ_Loop07:
	dc.b	nE2, $04, nRst, $08, nE2, $08, nRst, $04, nE2, $04, nRst, $08
	dc.b	nE2, $08, nRst, $04, nA2, $04, nRst, $08, nA2, $08, nRst, $04
	dc.b	nB2, $04, nRst, $08, nB2, $08, nRst, $04
	smpsLoop            $00, $02, Snd_BPZ_Loop07
	dc.b	nA2, $04, nRst, $08, nA2, $08, nRst, $04, nA2, $04, nRst, $08
	dc.b	nA2, $08, nRst, $04, nA2, $04, nRst, $08, nA2, $08, nRst, $04
	dc.b	nA2, $04, nRst, $08, nA2, $08, nRst, $04

Snd_BPZ_Loop08:
	dc.b	nB2, $04, nRst, $08
	smpsLoop            $00, $08, Snd_BPZ_Loop08
	smpsJump            Snd_BPZ_Loop04

; FM3 Data
Snd_BPZ_FM3:
	dc.b	nRst, $30

Snd_BPZ_Jump03:
	smpsPan             panCenter, $00
	dc.b	nRst, $30, nRst
	smpsAlterPitch      $0C
	smpsSetvoice        $03
	dc.b	nRst, $18, nRst, nAb5, $24, nB4, $0C, smpsNoAttack, $30, smpsNoAttack, $30, nRst
	dc.b	nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, $18, nA5, $30, nE5
	dc.b	$18
	smpsAlterPitch      $F4
	smpsSetvoice        $05
	dc.b	nRst, $0C, nAb4, $04, nRst, $02, nB4, $04, nRst, $02, nE5, $0C
	dc.b	nFs5, $06, nRst, nAb5, $12, nFs5, nE5, $04, nRst, $08, nCs5, $12
	dc.b	nB4, nAb4, $04, nRst, $08, nAb4, $04, nRst, $08, nFs4, $04, nRst
	dc.b	$08, nAb4, $06, nA4, nB4, $0C, nRst, nAb4, $04, nRst, $02, nB4
	dc.b	$04, nRst, $02, nE5, $0C, nFs5, $06, nRst, nAb5, $12, nFs5, nE5
	dc.b	$04, nRst, $08, nCs5, $12, nB4, nCs5, $04, nRst, $08, nEb5, $04
	dc.b	nRst, $08, nE5, $04, nRst, $08, nFs5, $0C, nA5, nD5, $06, nCs5
	dc.b	nD5, nCs5, nD5, nCs5, nD5, nCs5, nD5, $0C, nCs5, $06, nD5, $0C
	dc.b	nCs5, $06, nD5, $0C, nEb5, $06, nD5, nEb5, nD5, nEb5, nD5, nEb5
	dc.b	nD5, nG5, nRst, nFs5, nRst, nF5, nRst, nE5, nRst, nRst, $0C, nAb4
	dc.b	$04, nRst, $02, nB4, $04, nRst, $02, nE5, $0C, nFs5, $06, nRst
	dc.b	nAb5, $12, nFs5, nE5, $04, nRst, $08
	smpsModSet          $0C, $01, $FF, $30
	dc.b	nB4, $0F, nA5, $03, nB5, $12
	smpsModSet          $0C, $01, $FF, $30
	dc.b	nAb5, $30, smpsNoAttack, $0C
	smpsModOff
	smpsSetvoice        $03
	smpsFMAlterVol      $FA
	dc.b	nA4, $24, nB4, $18, nCs5, $0C, nE5, $18, nEb5, $24, nB4, $30
	dc.b	smpsNoAttack, $0C, nAb4, $12, nC5, nEb5, $0C, nFs5, $18, nE5, $0C, nCs5
	dc.b	smpsNoAttack, $30, nRst, nA4, $24, $18, nB4, $0C, nCs5, $18, nEb5, $24
	dc.b	nB4, $18, nCs5, $0C, nEb5, $18, nE5, $0C, nEb5, nE5, nFs5, nA5
	dc.b	nAb5, nFs5, nE5
	smpsFMAlterVol      $06
	smpsSetvoice        $00
	dc.b	$0C, nAb4, $06, nA4, nB4, $0C, nCs5, nB4, $06, nCs5, nEb5, nE5
	dc.b	nFs5, nAb5, nA5, $0C
	smpsSetvoice        $04
	smpsAlterPitch      $0C
	dc.b	nE3, $06, nE4, nE5, nE4, nE5, nE3, nE4, nEb5, nE5, nE3, nE4
	dc.b	nE5, nE3, nE4, nEb5, nE5, nE3, nE4, nE5, nE4, nE5, nE3, nEb5
	dc.b	nE4, nE5, nEb5, nE4, nE5, nE3, nE4, nEb5, nE5, nE3, nE4, nE5
	dc.b	nE4, nE5, nE3, nE4, nEb5, nE5, nE3, nE4, nE5, nE3, nE4, nEb5
	dc.b	nE5, nE3, nE4, nE5, nE4, nE5, nE3, nEb5, nE4, nE5, nEb5, nE4
	dc.b	nE5, nE3, nE4, nEb5, nE5, nE3, nE4, nE5, nE4, nE5, nE3, nE4
	dc.b	nEb5, nE5, nE3, nE4, nE5, nE3, nE4, nEb5, nE5, nE3, nE4, nE5
	dc.b	nE4, nE5, nE3, nEb5, nE4, nE5, nEb5, nE4, nE5, nE3, nE4, nEb5
	dc.b	nE5, nA3, nA3, nFs5, nA3, nE5, nA3, nA3, nE5, nAb5, nA3, nA3
	dc.b	nCs5, nA3, nA3, nCs5, nE5, nB3, nB3, nFs5, nB3, nEb5, nB3, nE5
	dc.b	nB3, nEb5, nE5, nB3, nFs5, nB3, nB3, nB4, nEb5
	smpsAlterPitch      $F4
	smpsJump            Snd_BPZ_Jump03

; FM4 Data
Snd_BPZ_FM4:
	dc.b	nRst, $30

Snd_BPZ_Jump02:
	dc.b	nRst, $0C
	smpsSetvoice        $04
	smpsPan             panLeft, $00
	dc.b	nE5, $06, nRst, $0C, nD5, $06, nRst, nB4, nD5, nE5, nRst, nD5
	dc.b	nRst, nB4, nD5, nE5, nRst, $0C, nE5, $06, nRst, $0C, nD5, $06
	dc.b	nRst, nB4, nD5, nE5, nRst, nD5, nRst, nB4, nRst, nD5, nRst, $0C
	dc.b	nE5, $06, nRst, $0C, nD5, $06, nRst, nB4, nD5, nE5, nRst, nD5
	dc.b	nRst, nB4, nD5, nE5, nRst, $0C, nE5, $06, nRst, $0C, nD5, $06
	dc.b	nRst, nB4, nD5, nE5, nRst, nD5, nRst, nB4, nRst, nD5
	smpsSetvoice        $01
	smpsPan             panCenter, $00
	dc.b	nA5, $30, smpsNoAttack, $18, nCs6, nFs5, $30, nB5, $2D, nRst, $03
	smpsSetvoice        $04
	smpsPan             panLeft, $00
	dc.b	nRst, $0C, nE5, $06, nRst, $0C, nD5, $06, nRst, nB4, nD5, nE5
	dc.b	nRst, nD5, nRst, nB4, nD5, nE5, nRst, $0C, nE5, $06, nRst, $0C
	dc.b	nD5, $06, nRst, nB4, nD5, nE5, nRst, nD5, nRst, nB4, nRst, nD5
	dc.b	nRst, $0C, nE5, $06, nRst, $0C, nD5, $06, nRst, nB4, nD5, nE5
	dc.b	nRst, nD5, nRst, nB4, nD5, nE5, nRst, $0C, nE5, $06, nRst, $0C
	dc.b	nD5, $06, nRst, nB4, nD5, nE5, nRst, nD5, nRst, nB4, nRst, nD5
	dc.b	nRst, $0C, nE5, $06, nRst, $0C, nD5, $06, nRst, nB4, nD5, nE5
	dc.b	nRst, nD5, nRst, nB4, nD5, nE5, nRst, $0C, nE5, $06, nRst, $0C
	dc.b	nD5, $06, nRst, nB4, nD5, nE5, nRst, nD5, nRst, nB4, nRst, nD5
	smpsSetvoice        $01
	smpsPan             panCenter, $00
	dc.b	nA5, $30, smpsNoAttack, $18, nCs6, nFs5, $30, nB5
	smpsSetvoice        $04
	smpsPan             panLeft, $00
	dc.b	nRst, $0C, nE5, $06, nRst, $0C, nD5, $06, nRst, nB4, nD5, nE5
	dc.b	nRst, nD5, nRst, nB4, nD5, nE5, nRst, $0C, nE5, $06, nRst, $0C
	dc.b	nD5, $06, nRst, nB4, nD5, nE5, nRst, nD5, nRst, nB4, nRst, nD5
	smpsPan             panCenter, $00
	dc.b	nA5, nA4, nAb5, nA4, nFs5, nA4, nE5, nA4, nA5, nA4, nAb5, nA4
	dc.b	nE5, nA4, nFs5, nA4, nA5, nA4, nAb5, nA4, nFs5, nA4, nE5, nA4
	dc.b	nA5, nA4, nAb5, nA4, nE5, nA4, nFs5, nA4, nA5, nC5, nAb5, nC5
	dc.b	nFs5, nC5, nE5, nC5, nA5, nC5, nAb5, nC5, nFs5, nC5, nE5, nC5
	dc.b	nA5, nAb5, nFs5, nE5, nFs5, nE5, nEb5, nCs5, nE5, nEb5, nCs5, nB4
	dc.b	nCs5, nB4, nA4, nAb4, nA5, nA4, nAb5, nA4, nFs5, nA4, nE5, nA4
	dc.b	nA5, nA4, nAb5, nA4, nFs5, nA4, nE5, nA4, nA5, nB4, nAb5, nB4
	dc.b	nFs5, nB4, nE5, nB4, nA5, nB4, nAb5, nB4, nFs5, nB4, nE5, nB4
	dc.b	nAb5, nCs5, nEb5, nE5, nFs5, nAb5, nA5, nFs5, nA5, nD5, nE5, nFs5
	dc.b	nA5, nFs5, nA5, nFs5
	smpsSetvoice        $03
	dc.b	nB5, $12, nFs5, nEb5, $0C, nB4, $30
	smpsSetvoice        $04
	smpsPan             panLeft, $00
	dc.b	nRst, $0C, nA5, $06, nRst, nAb5, nRst, $0C, nFs5, $06, nAb5, nRst
	dc.b	$0C, nAb5, $06, nRst, $0C, nFs5, $06, nAb5, nRst, $0C, nA5, $06
	dc.b	nRst, nAb5, nRst, nFs5, nRst, nAb5, nFs5, nRst, nAb5, nRst, $0C, nFs5
	dc.b	$06, nAb5, nRst, $0C, nA5, $06, nRst, nAb5, nRst, $0C, nFs5, $06
	dc.b	nAb5, nRst, $0C, nAb5, $06, nRst, $0C, nFs5, $06, nAb5, nRst, $0C
	dc.b	nA5, $06, nRst, nAb5, nRst, nFs5, nRst, nAb5, nFs5, nRst, nAb5, nRst
	dc.b	$0C, nFs5, $06, nAb5, nRst, $0C, nA5, $06, nRst, nAb5, nRst, $0C
	dc.b	nFs5, $06, nAb5, nRst, $0C, nAb5, $06, nRst, $0C, nFs5, $06, nAb5
	dc.b	nRst, $0C, nA5, $06, nRst, nAb5, nRst, nFs5, nRst, nAb5, nFs5, nRst
	dc.b	nAb5, nRst, $0C, nFs5, $06, nAb5, nRst, $0C, nA5, $06, nRst, nA5
	dc.b	nRst, $0C, nA5, $06, nA5, nRst, $0C, nE5, $06, nRst, $0C, nE5
	dc.b	$06, nAb5, nRst, $0C, nB5, $06, nRst, nFs5, nRst, nAb5, nRst, nFs5
	dc.b	nAb5, nRst, nB5, nRst, $0C, nEb5, $06, nFs5
	smpsJump            Snd_BPZ_Jump02

; FM5 Data
Snd_BPZ_FM5:
	dc.b	nRst, $30

Snd_BPZ_Jump01:
	smpsPan             panCenter, $00
	dc.b	nRst, $30, nRst
	smpsSetvoice        $03
	dc.b	nRst, $18, nA5, $30, nE5, $18, smpsNoAttack, $30, nRst, nRst, nRst
	smpsSetvoice        $01
	dc.b	nE5, $30, smpsNoAttack, $18, nA5, nB4, $30, nEb5, $2D, nRst, $03, nRst
	dc.b	$30, nRst
	smpsSetvoice        $03
	dc.b	nRst, $18, nRst, nAb5, $24, nB5, $0C, smpsNoAttack, $30, nRst, nRst, $18
	dc.b	nA5, nAb5, nE5, $0C, nB4, smpsNoAttack, $30, nRst, nRst, nRst
	smpsSetvoice        $01
	smpsPan             panCenter, $00
	dc.b	nE5, $30, smpsNoAttack, $18, nA5, nB4, $30, nFs5, $2D, nRst, $03, nRst
	dc.b	$30, nRst, nRst, nRst
	smpsSetvoice        $01
	smpsCall            Snd_BPZ_Call00
	smpsSetvoice        $06
	dc.b	nE3, $30, smpsNoAttack, nE3, nE3, smpsNoAttack, nE3, nE3, smpsNoAttack, nE3, nE3, smpsNoAttack
	dc.b	nE3, nE3, smpsNoAttack, nE3, nE3, smpsNoAttack, nE3, nA3, smpsNoAttack, nA3, nB3, smpsNoAttack
	dc.b	nB3
	smpsJump            Snd_BPZ_Jump01

Snd_BPZ_Call00:
	dc.b	nA4, smpsNoAttack, $30, nB4, smpsNoAttack, $30, nC5, smpsNoAttack, $30, nCs5, nB4, nCs5
	dc.b	smpsNoAttack, $30, nEb5, smpsNoAttack, $30, nCs5, nD5, nEb5, smpsNoAttack, $30
	smpsReturn

; PSG1 Data
Snd_BPZ_PSG1:
	dc.b	nRst, $30

Snd_BPZ_Loop0A:
	smpsPSGvoice        sTone_09
	dc.b	nB4, $30, smpsNoAttack, nB4, nE4, smpsNoAttack, nE4, nB4, smpsNoAttack, nB4, nE4, smpsNoAttack
	dc.b	nE4
	smpsPSGvoice        sTone_03
	smpsPSGAlterVol     $FE
	dc.b	nE4, smpsNoAttack, nE4, $18, $18, nFs4, $30, smpsNoAttack, nEb4
	smpsPSGAlterVol     $02
	smpsPSGvoice        sTone_09
	dc.b	nE4, smpsNoAttack, nE4, nE4, smpsNoAttack, nE4
	smpsLoop            $00, $02, Snd_BPZ_Loop0A
	smpsAlterPitch      $F4
	smpsCall            Snd_BPZ_Call02
	smpsAlterPitch      $18
	dc.b	nE3, $30, smpsNoAttack, nE3, nE3, smpsNoAttack, nE3, nE3, smpsNoAttack, nE3, nE3, smpsNoAttack
	dc.b	nE3, nE3, smpsNoAttack, nE3, nE3, smpsNoAttack, nE3, nA3, smpsNoAttack, nA3, nB3, smpsNoAttack
	dc.b	nB3
	smpsAlterPitch      $F4
	smpsJump            Snd_BPZ_Loop0A

; Unreachable
	smpsStop

; PSG2 Data
Snd_BPZ_PSG2:
	dc.b	nRst, $30

Snd_BPZ_Loop09:
	smpsPSGvoice        sTone_09
	dc.b	nFs4, $30, smpsNoAttack, nFs4, nA4, smpsNoAttack, nA4, nFs4, smpsNoAttack, nFs4, nA4, smpsNoAttack
	dc.b	nA4
	smpsPSGvoice        sTone_03
	smpsPSGAlterVol     $FE
	dc.b	nA4, smpsNoAttack, nA4, $18, $18, nB4, $30, smpsNoAttack, nB4
	smpsPSGAlterVol     $02
	smpsPSGvoice        sTone_09
	dc.b	nFs4, smpsNoAttack, nFs4, nFs4, smpsNoAttack, nFs4
	smpsLoop            $00, $02, Snd_BPZ_Loop09
	smpsCall            Snd_BPZ_Call00
	smpsAlterPitch      $0C
	dc.b	nAb3, $30, smpsNoAttack, nAb3, nAb3, smpsNoAttack, nAb3, nAb3, smpsNoAttack, nAb3, nAb3, smpsNoAttack
	dc.b	nAb3, nAb3, smpsNoAttack, nAb3, nAb3, smpsNoAttack, nAb3, nCs4, smpsNoAttack, nCs4, nEb4, smpsNoAttack
	dc.b	nEb4
	smpsAlterPitch      $F4
	smpsJump            Snd_BPZ_Loop09

; Unreachable
	smpsStop

; PSG3 Data
Snd_BPZ_PSG3:
	smpsStop

; Unreachable
	smpsPSGform         $E7
	dc.b	nRst, $30

Snd_BPZ_Jump05:
	dc.b	nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nBb4, $05, nRst
	dc.b	$13, nBb4, $04, nRst, $02, nBb4, $04, nRst, $0E, nBb4, $05, nRst
	dc.b	$13, nBb4, $06, $01, nRst, $11, nBb4, $07, nRst, $11, nBb4, $04
	dc.b	nRst, $02, nBb4, $04, nRst, $0E, nBb4, $07, nRst, $11, nBb4, $06
	dc.b	$01, nRst, $11, nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b	nRst, nRst, nRst, nRst, nA4, $05, nRst, $13, nA4, $04, nRst, $02
	dc.b	nA4, $04, nRst, $0E, nA4, $05, nRst, $13, nA4, $06, $01, nRst
	dc.b	$11, nA4, $07, nRst, $11, nA4, $04, nRst, $02, nA4, $04, nRst
	dc.b	$0E, nA4, $07, nRst, $11, nA4, $06, $01, nRst, $11, nRst, $30
	dc.b	nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b	nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, $0C, nA4, $06, nA4
	dc.b	nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C
	dc.b	nA4, $06, nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4, $06
	dc.b	nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4, $06, nA4, nRst
	dc.b	$0C, nA4, $06, nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4
	dc.b	$06, nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4, $06, nA4
	dc.b	nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C
	dc.b	nA4, $06, nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4, $06
	dc.b	nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4, $06, nA4, nRst
	dc.b	$0C, nA4, $06, nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4
	dc.b	$06, nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4, $06, nA4
	dc.b	nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C
	dc.b	nA4, $06, nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4, $06
	dc.b	nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4, $06, nA4
	smpsJump            Snd_BPZ_Jump05

; DAC Data
Snd_BPZ_DAC:
	dc.b	dSnareS3, $06, dSnareS3, dKickS3, $0C, dSnareS3, dKickS3

Snd_BPZ_Jump00:
	dc.b	dCrashCymbal, $0C, nRst, dSnareS3, dKickS3, dKickS3, $06, dSnareS3, dKickS3, $0C, dSnareS3, dKickS3
	dc.b	dKickS3, dKickS3, dSnareS3, dKickS3, dKickS3, $06, dSnareS3, dKickS3, $0C, dSnareS3, dKickS3, dKickS3
	dc.b	nRst, dSnareS3, dKickS3, dKickS3, $06, dSnareS3, dKickS3, $0C, dSnareS3, dKickS3, dKickS3, dKickS3
	dc.b	dSnareS3, dKickS3, dKickS3, $06, dSnareS3, dKickS3, $0C, dSnareS3, dSnareS3

Snd_BPZ_Loop00:
	dc.b	dKickS3, dSnareS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, dSnareS3, $12, dKickS3, $06
	dc.b	dSnareS3, $0C
	smpsLoop            $00, $02, Snd_BPZ_Loop00
	dc.b	dCrashCymbal, nRst, dSnareS3, dKickS3, dKickS3, $06, dSnareS3, dKickS3, $0C, dSnareS3, dKickS3, dKickS3
	dc.b	dKickS3, dSnareS3, dKickS3, dKickS3, $06, dSnareS3, dKickS3, $0C, dSnareS3, dSnareS3, dCrashCymbal, nRst
	dc.b	dSnareS3, dKickS3, dKickS3, $06, dSnareS3, dKickS3, $0C, dSnareS3, dKickS3, dKickS3, dKickS3, dSnareS3
	dc.b	dKickS3, dKickS3, $06, dSnareS3, dKickS3, $0C, dSnareS3, dKickS3, dKickS3, nRst, dSnareS3, dKickS3
	dc.b	dKickS3, $06, dSnareS3, dKickS3, $0C, dSnareS3, dKickS3, dKickS3, dKickS3, dSnareS3, dKickS3, dKickS3
	dc.b	$06, dSnareS3, dKickS3, $0C, dSnareS3, dSnareS3

Snd_BPZ_Loop01:
	dc.b	dKickS3, dSnareS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, dSnareS3, $12, dKickS3, $06
	dc.b	dSnareS3, $0C
	smpsLoop            $00, $02, Snd_BPZ_Loop01
	dc.b	dCrashCymbal, nRst, dSnareS3, dKickS3, dKickS3, $06, dSnareS3, dKickS3, $0C, dSnareS3, dKickS3, dKickS3
	dc.b	dKickS3, dSnareS3, dKickS3, dKickS3, $06, dSnareS3, dKickS3, $0C, dSnareS3, dSnareS3

Snd_BPZ_Loop02:
	dc.b	dKickS3, dKickS3, dSnareS3, dKickS3, dKickS3, $06, dSnareS3, dKickS3, $0C, dSnareS3, dKickS3
	smpsLoop            $00, $03, Snd_BPZ_Loop02
	dc.b	dKickS3, dKickS3, dSnareS3, dKickS3, dKickS3, $06, dSnareS3, dKickS3, $0C, dSnareS3, dSnareS3
	smpsLoop            $01, $02, Snd_BPZ_Loop02

Snd_BPZ_Loop03:
	dc.b	dKickS3, dSnareS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, dSnareS3, $12, dKickS3, $06
	dc.b	dSnareS3, $0C
	smpsLoop            $00, $05, Snd_BPZ_Loop03
	dc.b	dKickS3, dSnareS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, dSnareS3, dSnareS3, $06, dSnareS3
	dc.b	dSnareS3, dSnareS3, dKickS3, $0C, dSnareS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, dSnareS3
	dc.b	$12, dKickS3, $06, dSnareS3, $0C, dKickS3, dSnareS3, $12, dKickS3, $06, dSnareS3, $0C
	dc.b	dKickS3, dSnareS3, dSnareS3, $06, dSnareS3, dKickS3, dSnareS3
	smpsJump            Snd_BPZ_Jump00

Snd_BPZ_Voices:
;	Voice $00
;	$02
;	$31, $26, $12, $02, 	$17, $17, $10, $1F, 	$05, $08, $02, $08
;	$00, $00, $00, $00, 	$9F, $0F, $0F, $1F, 	$2B, $26, $16, $82
	smpsVcAlgorithm     $02
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $01, $02, $03
	smpsVcCoarseFreq    $02, $02, $06, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $10, $17, $17
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $02, $08, $05
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $01, $00, $00, $09
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $02, $16, $26, $2B

;	Voice $01
;	$05
;	$20, $11, $21, $03, 	$18, $10, $11, $10, 	$0A, $06, $06, $06
;	$00, $00, $00, $00, 	$CF, $4F, $4F, $4F, 	$10, $90, $90, $90
	smpsVcAlgorithm     $05
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $02, $01, $02
	smpsVcCoarseFreq    $03, $01, $01, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $10, $11, $10, $18
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $06, $06, $0A
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $04, $04, $04, $0C
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $10, $10, $10, $10

;	Voice $02
;	$00
;	$27, $37, $30, $20, 	$1F, $1F, $1F, $1F, 	$07, $06, $09, $06
;	$07, $06, $06, $08, 	$20, $10, $10, $0F, 	$19, $37, $18, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $02, $03, $03, $02
	smpsVcCoarseFreq    $00, $00, $07, $07
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $09, $06, $07
	smpsVcDecayRate2    $08, $06, $06, $07
	smpsVcDecayLevel    $00, $01, $01, $02
	smpsVcReleaseRate   $0F, $00, $00, $00
	smpsVcTotalLevel    $00, $18, $37, $19

;	Voice $03
;	$04
;	$17, $03, $06, $74, 	$5F, $5F, $5F, $5F, 	$00, $08, $00, $00
;	$00, $00, $00, $0A, 	$0F, $FF, $0F, $0F, 	$1C, $88, $23, $88
	smpsVcAlgorithm     $04
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $00, $00, $01
	smpsVcCoarseFreq    $04, $06, $03, $07
	smpsVcRateScale     $01, $01, $01, $01
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $08, $00
	smpsVcDecayRate2    $0A, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $0F, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $08, $23, $08, $1C

;	Voice $04
;	$3C
;	$02, $02, $00, $02, 	$1F, $1F, $1F, $1F, 	$0C, $03, $07, $02
;	$04, $05, $04, $05, 	$FF, $FF, $FF, $FF, 	$1A, $88, $1E, $88
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $02, $00, $02, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $07, $03, $0C
	smpsVcDecayRate2    $05, $04, $05, $04
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $08, $1E, $08, $1A

;	Voice $05
;	$01
;	$02, $04, $02, $02, 	$17, $17, $13, $1F, 	$00, $0C, $00, $08
;	$00, $00, $00, $00, 	$0F, $FF, $0F, $1F, 	$1F, $1A, $1B, $84
	smpsVcAlgorithm     $01
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $02, $02, $04, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $13, $17, $17
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $00, $0C, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $01, $00, $0F, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $04, $1B, $1A, $1F

;	Voice $06
;	$04
;	$02, $04, $03, $06, 	$13, $0D, $13, $0D, 	$06, $06, $06, $06
;	$00, $00, $00, $00, 	$4F, $4F, $4F, $4F, 	$18, $88, $18, $88
	smpsVcAlgorithm     $04
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $06, $03, $04, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0D, $13, $0D, $13
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $06, $06, $06
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $04, $04, $04, $04
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $08, $18, $08, $18

