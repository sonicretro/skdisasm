Snd_SlotBonus_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_SlotBonus_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $20

	smpsHeaderDAC       Snd_SlotBonus_DAC
	smpsHeaderFM        Snd_SlotBonus_FM1,	$F4, $09
	smpsHeaderFM        Snd_SlotBonus_FM2,	$F4, $0E
	smpsHeaderFM        Snd_SlotBonus_FM3,	$00, $0B
	smpsHeaderFM        Snd_SlotBonus_FM4,	$00, $1D
	smpsHeaderFM        Snd_SlotBonus_FM5,	$00, $08
	smpsHeaderPSG       Snd_SlotBonus_PSG1,	$E8, $04, $05, $00
	smpsHeaderPSG       Snd_SlotBonus_PSG2,	$E8, $04, $05, $00
	smpsHeaderPSG       Snd_SlotBonus_PSG3,	$00, $00, $00, sTone_03

; FM1 Data
Snd_SlotBonus_FM1:
	smpsSetvoice        $00
	smpsPan             panCenter, $00
	smpsModSet          $07, $01, $02, $05
	dc.b	nD4, $05, nRst, $07, nD4, $05, nRst, $07, nD4, $06, nA3, $05
	dc.b	nRst, $07, nA3, $06, nB3, $05, nRst, $07, nB3, $0C, nCs4, $05
	dc.b	nRst, $07, nCs4, $0C, nD4, $05, nRst, $07, nD4, $05, nRst, $07
	dc.b	nD4, $06, nA3, $05, nRst, $07, nA3, $06, nB3, $05, nRst, $07
	dc.b	nA3, $0C, nCs4, $05, nRst, $07, nA3, $0C, nD4, $05, nRst, $07
	dc.b	nD4, $05, nRst, $07, nD4, $06, nA3, $05, nRst, $07, nA3, $06
	dc.b	nB3, $05, nRst, $07, nB3, $0C, nCs4, $05, nRst, $07, nCs4, $0C
	dc.b	nD4, $05, nRst, $07, nD4, $05, nRst, $07, nD4, $06, nA3, $05
	dc.b	nRst, $07, nA3, $06, nB3, $05, nRst, $07, nA3, $0C, nCs4, $05
	dc.b	nRst, $07, nA3, $0C

Snd_SlotBonus_Jump05:
	dc.b	nD4, $05, nRst, $07, nD4, $05, nRst, $07, nD4, $06, nA3, $05
	dc.b	nRst, $07, nA3, $06, nB3, $05, nRst, $07, nB3, $0C, nCs4, $05
	dc.b	nRst, $07, nCs4, $0C, nD4, $05, nRst, $07, nD4, $05, nRst, $07
	dc.b	nD4, $06, nA3, $05, nRst, $07, nA3, $06, nB3, $05, nRst, $07
	dc.b	nA3, $0C, nCs4, $05, nRst, $07, nA3, $0C, nD4, $05, nRst, $07
	dc.b	nD4, $05, nRst, $07, nD4, $06, nA3, $05, nRst, $07, nA3, $06
	dc.b	nB3, $05, nRst, $07, nB3, $0C, nCs4, $05, nRst, $07, nCs4, $0C
	dc.b	nD4, $05, nRst, $07, nD4, $05, nRst, $07, nD4, $06, nA3, $05
	dc.b	nRst, $07, nA3, $06, nB3, $05, nRst, $07, nA3, $0C, nCs4, $05
	dc.b	nRst, $07, nA3, $0C, nG3, $06, nRst, nG3, nRst, nG3, nRst, nG3
	dc.b	nG3, nRst, nG3, nA3, nRst, nB3, $0A, nRst, $02, nD4, $0A, nRst
	dc.b	$02, nFs3, $06, nRst, nFs3, nRst, nFs3, nRst, nFs3, nCs4, nRst, nCs4
	dc.b	nRst, nCs4, nB3, nCs4, nD4, nFs4, nG3, nRst, nG3, nRst, nG3, nRst
	dc.b	nG3, nAb3, nRst, nAb3, nRst, nAb3, nA3, nB3, nCs4, nD4, nA3, nRst
	dc.b	$12, nA3, $48, nD4, $06, nRst, nD4, nRst, nD4, nRst, nA3, nB3
	dc.b	nRst, nB3, nA3, nRst, nB3, $0A, nRst, $02, nCs4, $0A, nRst, $02
	dc.b	nD4, $06, nRst, nD4, nRst, nD4, nA3, nRst, nA3, nB3, nRst, nA3
	dc.b	$0A, nRst, $02, nCs4, $06, nRst, nA3, $0A, nRst, $02, nD4, $06
	dc.b	nRst, nD4, nRst, nD4, nA3, nRst, nA3, nB3, nRst, nB3, $0A, nRst
	dc.b	$02, nCs4, $06, nRst, nCs4, $0A, nRst, $02, nD4, $06, nRst, nD4
	dc.b	nRst, nD4, nA3, nRst, nA3, nB3, nRst, nA3, $0A, nRst, $02, nCs4
	dc.b	$06, nRst, nA3, $0A, nRst, $02, nG3, $06, nRst, nG3, nRst, nG3
	dc.b	nRst, nG3, nG3, nRst, nG3, nA3, $0A, nRst, $02, nB3, $06, nRst
	dc.b	nD4, $0A, nRst, $02, nFs3, $06, nRst, nFs3, nRst, nFs3, nRst, nFs3
	dc.b	nFs3, $0A, nRst, $02, nB3, $06, nRst, nCs4, nD4, nRst, nFs4, $0A
	dc.b	nRst, $02, nG3, $06, nRst, nA3, nRst, nB3, nRst, nD4, nA3, nRst
	dc.b	nB3, nRst, nB3, nCs4, nRst, nE4, $0A, nRst, $02, nD4, $08, nRst
	dc.b	$10, nD3, $48, nG3, $06, nRst, nD4, nRst, nG3, nRst, nD4, nG3
	dc.b	nRst, nG3, nA3, nRst, nB3, nRst, nD4, $0A, nRst, $02, nFs3, $06
	dc.b	nRst, nCs4, nRst, nFs3, nRst, nCs4, nFs3, nRst, nFs3, nAb3, nRst, nA3
	dc.b	nRst, nCs4, $0A, nRst, $02, nE3, $06, nRst, nB3, nRst, nE3, nRst
	dc.b	nB3, nE3, nRst, nE3, nFs3, nRst, nAb3, nRst, nB3, $0A, nRst, $02
	dc.b	nA3, $18, nB3, nCs4, nA3, $0A, nRst, $02, nAb3, $0A, nRst, $02
	dc.b	nG3, $06, nRst, nD4, nRst, nG3, nRst, nD4, nG3, nRst, nG3, nA3
	dc.b	nRst, nB3, nRst, nD4, $0A, nRst, $02, nFs3, $06, nRst, nCs4, nRst
	dc.b	nFs3, nRst, nCs4, nFs3, nRst, nFs3, nAb3, nRst, nA3, nRst, nCs4, $0A
	dc.b	nRst, $02, nE3, $06, nRst, nB3, nRst, nE3, nRst, nB3, nE3, nRst
	dc.b	nE3, nFs3, $0A, nRst, $02, nAb3, $0A, nRst, $02, nB3, $0A, nRst
	dc.b	$02, nA3, $0A, nRst, $0E, nE4, $18, nA4, $06, nRst, nE4, nRst
	dc.b	nA3, $18
	smpsJump            Snd_SlotBonus_Jump05

; FM2 Data
Snd_SlotBonus_FM2:
	smpsSetvoice        $02
	smpsPan             panLeft, $00
	smpsModSet          $07, $01, $08, $05

Snd_SlotBonus_Call07:
	dc.b	nRst, $60, nRst, nRst, nRst

Snd_SlotBonus_Jump04:
	dc.b	nRst, $0C, nA4, $18, nD5, $04, nRst, $08, nE5, $12, nD5, nE5
	dc.b	$04, nRst, $08, nFs5, $04, nRst, $08, nG5, $04, nRst, $08, nFs5
	dc.b	$06, nD5, nRst, nD5, $36, nRst, $0C, nA4, $18, nD5, $04, nRst
	dc.b	$08, nE5, $04, nFs5, nE5, nD5, $16, nRst, $02, nE5, $04, nRst
	dc.b	$08, nFs5, $04, nRst, $08, nG5, $06, nRst, nFs5, nD5, nRst, nA5
	dc.b	$36, smpsNoAttack, $06, nRst, $06, nB5, $18, nG5, $06, nRst, nCs6, $02
	dc.b	nD6, $10, nCs6, $12, nB5, $04, nRst, $08, nA5, $04, nRst, $08
	dc.b	nB5, $06, nRst, nA5, nFs5, nRst, nD5, $36, nRst, $0C, nE5, $14
	dc.b	nRst, $04, nE5, $08, nRst, $04, nFs5, $0C, nE5, $06, nRst, nAb5
	dc.b	$0C, nB5, $04, nRst, $08, nA5, $04, nRst, $14, nG5, $18, nFs5
	dc.b	nE5, nRst, $0C, nA4, $18, nD5, $04, nRst, $08, nE5, $12, nD5
	dc.b	nE5, $04, nRst, $08, nFs5, $04, nRst, $08, nG5, $06, nRst, nFs5
	dc.b	nD5, nRst, nD5, $36, nRst, $0C, nA4, $18, nD5, $06, nRst, nE5
	dc.b	nFs5, nE5, nD5, $12, nE5, $04, nRst, $08, nFs5, $02, nRst, $0A
	dc.b	nG5, $06, nRst, nFs5, nD5, nRst, nA5, $36, nRst, $0C, nA5, $02
	dc.b	nB5, $16, nG5, $06, nRst, nCs6, $02, nD6, $10, nCs6, $12, nB5
	dc.b	$04, nRst, $08, nA5, $04, nRst, $08, nB5, $06, nRst, nA5, nFs5
	dc.b	nRst, nD5, $32, nRst, $04, nE5, $12, nRst, $06, nG5, $14, nRst
	dc.b	$04, nFs5, $12, nRst, $06, nE5, $12, nRst, $06, nD5, $0A, nRst
	dc.b	$0E, nD5, $18, nCs5, nC5, nB4, nD5, $06, nRst, nB4, nRst, nG5
	dc.b	$12, nD5, $10, nG5, $06, nRst, $08, nFs5, $06, nRst, nG5, nRst
	dc.b	nFs5, nCs5, nRst, nFs5, $36, nRst, $0C, nE5, $10, nRst, $08, nE5
	dc.b	$06, nRst, nE5, $0C, nD5, $04, nRst, $08, nCs5, $06, nRst, nE5
	dc.b	$04, nRst, $08, nD5, $0C, nCs5, $04, nRst, $08, nB4, $0C, nCs5
	dc.b	$04, nRst, $08, nD5, $0C, nCs5, $04, nRst, $08, nB4, $0C, nA4
	dc.b	$04, nRst, $08, nRst, $0C, nG4, $0E, nRst, $0A, nD5, $04, nRst
	dc.b	$08, nG5, $12, nRst, $06, nD5, $12, nRst, $06, nA5, $10, nRst
	dc.b	$08, nFs5, $10, nRst, $08, nFs5, $28, nRst, $08, nG5, $0C, nRst
	dc.b	$06, nG5, $0C, nRst, $06, nG5, nRst, nB4, $10, nRst, $02, nAb5
	dc.b	$0C, nRst, $06, nB4, nRst, nCs5, $04, nRst, $02, nA5, $06, nRst
	dc.b	nCs5, $04, nRst, $02, nA5, $04, nRst, $08, nCs5, $04, nRst, $08
	dc.b	nCs5, $26, nRst, $0A
	smpsJump            Snd_SlotBonus_Jump04

; FM3 Data
Snd_SlotBonus_FM3:
	smpsSetvoice        $01
	smpsPan             panCenter, $00
	smpsModSet          $07, $01, $07, $05
	dc.b	nRst, $60, nRst, nRst, nRst

Snd_SlotBonus_Jump03:
	dc.b	nRst, $0C, nD5, $18, nCs5, $04, nRst, $08, nB4, $12, nA4, nCs5
	dc.b	$04, nRst, $08, nD5, $04, nRst, $08, nD5, $06, nRst, nD5, nE5
	dc.b	$04, nRst, $08, nFs5, $36, nRst, $0C, nD5, $18, nCs5, $04, nRst
	dc.b	$08, nB4, $12, nA4, nCs5, $04, nRst, $08, nD5, $04, nRst, $08
	dc.b	nD5, $04, nRst, $08, nD5, $04, nRst, $02, nE5, $04, nRst, $08
	dc.b	nFs5, $04, nRst, $08, nFs5, $04, nRst, $02, nFs5, $04, nRst, $08
	dc.b	nE5, $06, nRst, nD5, $0C, smpsNoAttack, nD5, $06, nRst, nG4, $12, nRst
	dc.b	$06, nG4, nRst, nG4, $0E, nRst, $04, nB4, $0E, nRst, $04, nD5
	dc.b	$06, nRst, nCs5, nRst, nCs5, $04, nRst, $08, nCs5, $06, nB4, $04
	dc.b	nRst, $08, nA4, $2E, nRst, $08, nRst, $0C, nG4, $12, nRst, $06
	dc.b	nG4, $08, nRst, $04, nRst, $0C, nAb4, $12, nRst, $06, nAb4, nRst
	dc.b	nA4, $04, nRst, $14, nA4, $18, nB4, nCs5, nRst, $0C, nD5, $14
	dc.b	nRst, $04, nCs5, nRst, $08, nB4, $0E, nRst, $04, nA4, $0E, nRst
	dc.b	$04, nCs5, nRst, $08, nD5, $06, nRst, nD5, nRst, nD5, nE5, nRst
	dc.b	nFs5, $2C, nRst, $0A, nRst, $0C, nD5, $18, nCs5, $04, nRst, $08
	dc.b	nB4, $12, nA4, nCs5, $04, nRst, $08, nD5, $04, nRst, $08, nD5
	dc.b	$04, nRst, $08, nD5, $04, nRst, $02, nE5, $04, nRst, $08, nFs5
	dc.b	$04, nRst, $08, nFs5, $04, nRst, $02, nFs5, $04, nRst, $08, nE5
	dc.b	$06, nRst, nD5, $0C, nRst, nG4, $18, nB4, $04, nRst, $08, nD5
	dc.b	$10, nRst, $02, nFs5, $0E, nRst, $04, nG5, $06, nRst, nFs5, nRst
	dc.b	nFs5, nRst, nFs5, nE5, nRst, nD5, $2A, nRst, $0C, nB4, $12, nRst
	dc.b	$06, nD5, $12, nRst, $06, nCs5, $12, nRst, $06, nE5, $12, nRst
	dc.b	$06, nFs5, $0E, nRst, $0A, nFs5, $14, nRst, $04, nG5, $12, nRst
	dc.b	$06, nA5, $12, nRst, $06, nG5, $1E, nRst, $06, nA5, nRst, nB5
	dc.b	$0E, nRst, $04, nA5, $0E, nRst, $04, nG5, nRst, $08, nA5, $1C
	dc.b	nRst, $02, nG5, $06, nRst, nFs5, $34, nRst, $02, nRst, $0C, nG5
	dc.b	$12, nRst, $06, nG5, nRst, nG5, $0C, nFs5, $04, nRst, $08, nE5
	dc.b	$0C, nD5, $06, nRst, nCs5, $12, nRst, $06, nD5, $12, nRst, $06
	dc.b	nE5, $12, nRst, $06, nFs5, $12, nRst, $06, nRst, $0C, nG5, $10
	dc.b	nRst, $08, nG5, $04, nRst, $08, nG5, $18, nA5, $06, nRst, nB5
	dc.b	nRst, nA5, $12, nRst, $06, nCs5, $12, nRst, $06, nFs5, $26, nRst
	dc.b	$0A, nE5, $0C, nRst, $06, nE5, $0E, nRst, $04, nE5, $06, nRst
	dc.b	nE5, $0C, nRst, $06, nE5, $0C, nRst, $06, nD5, nRst, nCs5, $04
	dc.b	nRst, $02, nCs5, $04, nRst, $08, nCs5, $02, nRst, $04, nCs5, nRst
	dc.b	$08, nB4, $04, nRst, $08, nA4, $06, nRst, $2A
	smpsJump            Snd_SlotBonus_Jump03

; FM4 Data
Snd_SlotBonus_FM4:
	smpsSetvoice        $03
	smpsPan             panCenter, $00
	smpsModSet          $07, $01, $09, $05
	dc.b	nRst, $60, nRst, nRst, nRst

Snd_SlotBonus_Jump02:
	dc.b	nD5, $18, nCs5, nB4, nA4, nD5, nCs5, nB4, nA4, nD5, nCs5, $16
	dc.b	nRst, $02, nB4, $18, nA4, nD5, $30, nE5, $18, nFs5, nG5, $30
	dc.b	nB5, $18, nD6, nCs6, nB5, nA5, nFs5, nG5, $30, nAb5, nA5, $08
	dc.b	nRst, $10, nCs6, $18, nB5, nA5, nD6, nCs6, nB5, nA5, nG5, nFs5
	dc.b	nE5, nD5, nD5, nCs5, nB4, nA4, nG4, nFs4, nE4, nD4, nG4, nA4
	dc.b	nB4, nD5, nCs5, nB4, nA4, nFs4, nG4, nB4, nA4, nCs5, $16, nRst
	dc.b	$02, nD5, $16, nRst, $02, nD5, $18, nE5, nFs5, $16, nRst, $02
	smpsFMAlterVol      $FC
	dc.b	nG5, $0C, nD6, $06, nB5, nG6, nD6, nB5, nG6, nD6, nB5, nG6
	dc.b	nD6, nB5, nG6, nD6, nB5, nFs5, $0C, nD6, $06, nA5, nFs6, nD6
	dc.b	nA5, nFs6, nD6, nA5, nFs6, nD6, nA5, nFs6, nD6, nA5, nE5, $0C
	dc.b	nB5, $06, nG5, nE6, nB5, nG5, nB5, nE5, $0C, nB5, $06, nAb5
	dc.b	nE6, nB5, nAb5, nB5, nA5, $0D, nCs6, $06, nRst, $05, nA5, $0D
	dc.b	nCs6, $06, nRst, $05, nA5, $0D, nCs6, $06, nRst, $05, nA5, $0D
	dc.b	nCs6, $06, nRst, $05, nG5, $0C, nD6, $06, nB5, nG6, nD6, nB5
	dc.b	nG6, nD6, nB5, nG6, nD6, nB5, nG6, nD6, nB5, nFs5, $0C, nD6
	dc.b	$06, nA5, nFs6, nD6, nA5, nFs6, nD6, nA5, nFs6, nD6, nA5, nFs6
	dc.b	nD6, nA5, nG5, $0C, nD6, $06, nB5, nG6, nD6, nB5, nD6, nAb5
	dc.b	$0C, nD6, $06, nB5, nAb6, nD6, nB5, nD6, nA5, nB5, nCs6, nD6
	dc.b	nB5, nCs6, nD6, nE6, nD6, nCs6, nB5, nA5, nG5, nFs5, nE5, nCs5
	smpsFMAlterVol      $04
	smpsJump            Snd_SlotBonus_Jump02

; FM5 Data
Snd_SlotBonus_FM5:
	smpsSetvoice        $04
	smpsPan             panRight, $00
	smpsModSet          $07, $01, $08, $05
	dc.b	nRst, $01

Snd_SlotBonus_Call06:
	dc.b	nRst, $60, nRst, nRst, nRst

Snd_SlotBonus_Jump01:
	dc.b	nRst, $0C, nA4, $18, nD5, $04, nRst, $08, nE5, $12, nD5, nE5
	dc.b	$04, nRst, $08, nFs5, $04, nRst, $08, nG5, $04, nRst, $08, nFs5
	dc.b	$06, nD5, nRst, nD5, $36, nRst, $0C, nA4, $18, nD5, $04, nRst
	dc.b	$08, nE5, $04, nFs5, nE5, nD5, $16, nRst, $02, nE5, $04, nRst
	dc.b	$08, nFs5, $04, nRst, $08, nG5, $06, nRst, nFs5, nD5, nRst, nA5
	dc.b	$36, smpsNoAttack, $06, nRst, $06, nB5, $18, nG5, $06, nRst, nCs6, $02
	dc.b	nD6, $10, nCs6, $12, nB5, $04, nRst, $08, nA5, $04, nRst, $08
	dc.b	nB5, $06, nRst, nA5, nFs5, nRst, nD5, $36, nRst, $0C, nE5, $14
	dc.b	nRst, $04, nE5, $08, nRst, $04, nFs5, $0C, nE5, $06, nRst, nAb5
	dc.b	$0C, nB5, $04, nRst, $08, nA5, $04, nRst, $14, nG5, $18, nFs5
	dc.b	nE5, nRst, $0C, nA4, $18, nD5, $04, nRst, $08, nE5, $12, nD5
	dc.b	nE5, $04, nRst, $08, nFs5, $04, nRst, $08, nG5, $06, nRst, nFs5
	dc.b	nD5, nRst, nD5, $36, nRst, $0C, nA4, $18, nD5, $06, nRst, nE5
	dc.b	nFs5, nE5, nD5, $12, nE5, $04, nRst, $08, nFs5, $02, nRst, $0A
	dc.b	nG5, $06, nRst, nFs5, nD5, nRst, nA5, $36, nRst, $0C, nA5, $02
	dc.b	nB5, $16, nG5, $06, nRst, nCs6, $02, nD6, $10, nCs6, $12, nB5
	dc.b	$04, nRst, $08, nA5, $04, nRst, $08, nB5, $06, nRst, nA5, nFs5
	dc.b	nRst, nD5, $32, nRst, $04, nE5, $12, nRst, $06, nG5, $14, nRst
	dc.b	$04, nFs5, $12, nRst, $06, nE5, $12, nRst, $06, nD5, $0A, nRst
	dc.b	$0E, nD5, $18, nCs5, nC5, nB4, nD5, $06, nRst, nB4, nRst, nG5
	dc.b	$12, nD5, $10, nG5, $06, nRst, $08, nFs5, $06, nRst, nG5, nRst
	dc.b	nFs5, nCs5, nRst, nFs5, $36, nRst, $0C, nE5, $10, nRst, $08, nE5
	dc.b	$06, nRst, nE5, $0C, nD5, $04, nRst, $08, nCs5, $06, nRst, nE5
	dc.b	$04, nRst, $08, nD5, $0C, nCs5, $04, nRst, $08, nB4, $0C, nCs5
	dc.b	$04, nRst, $08, nD5, $0C, nCs5, $04, nRst, $08, nB4, $0C, nA4
	dc.b	$04, nRst, $08, nRst, $0C, nB4, $10, nRst, $08, nB4, $06, nRst
	dc.b	nD5, $12, nRst, $06, nB5, $10, nRst, $08, nCs5, $10, nRst, $08
	dc.b	nCs5, $0E, nRst, $0A, nCs5, $26, nRst, $0A, nB4, $0C, nRst, $06
	dc.b	nB4, $0C, nRst, $06, nB4, nRst, nAb5, $0E, nRst, $04, nB4, $0C
	dc.b	nRst, $06, nAb5, nRst, nA5, $04, nRst, $02, nCs5, $04, nRst, $08
	dc.b	nA5, $02, nRst, $04, nCs5, nRst, $08, nA5, $04, nRst, $08, nA5
	dc.b	$26, nRst, $0A
	smpsJump            Snd_SlotBonus_Jump01

; PSG1 Data
Snd_SlotBonus_PSG1:
	smpsPSGvoice        sTone_09
	dc.b	nRst, $02
	smpsCall            Snd_SlotBonus_Call07

; PSG2 Data
Snd_SlotBonus_PSG2:
	smpsPSGvoice        sTone_09
	dc.b	nRst, $03
	smpsCall            Snd_SlotBonus_Call06

; PSG3 Data
Snd_SlotBonus_PSG3:
	smpsPSGform         $E7

Snd_SlotBonus_Loop00:
	smpsCall            Snd_SlotBonus_Call00
	smpsLoop            $00, $04, Snd_SlotBonus_Loop00

Snd_SlotBonus_Loop01:
	smpsCall            Snd_SlotBonus_Call00
	smpsLoop            $00, $07, Snd_SlotBonus_Loop01
	smpsCall            Snd_SlotBonus_Call01

Snd_SlotBonus_Loop02:
	smpsCall            Snd_SlotBonus_Call02
	smpsLoop            $00, $07, Snd_SlotBonus_Loop02
	smpsCall            Snd_SlotBonus_Call03

Snd_SlotBonus_Loop03:
	smpsCall            Snd_SlotBonus_Call02
	smpsLoop            $00, $03, Snd_SlotBonus_Loop03
	smpsCall            Snd_SlotBonus_Call03
	smpsCall            Snd_SlotBonus_Call04

Snd_SlotBonus_Loop04:
	smpsCall            Snd_SlotBonus_Call02
	smpsLoop            $00, $02, Snd_SlotBonus_Loop04
	smpsCall            Snd_SlotBonus_Call05
	smpsJump            Snd_SlotBonus_Loop01

Snd_SlotBonus_Call00:
	smpsPSGvoice        sTone_01
	dc.b	nB6, $18, nB6, nB6, nB6
	smpsReturn

Snd_SlotBonus_Call01:
	dc.b	nRst, $30
	smpsPSGvoice        sTone_01
	dc.b	nB6, $18
	smpsPSGvoice        sTone_02
	dc.b	nB6, $18
	smpsReturn

Snd_SlotBonus_Call02:
	smpsPSGvoice        sTone_01
	dc.b	nB6, $0C, nB6, nB6, nB6, nB6, nB6, nB6, nB6
	smpsReturn

Snd_SlotBonus_Call03:
	dc.b	nRst, $30
	smpsPSGvoice        sTone_02
	dc.b	nB6, $18, nB6
	smpsReturn

Snd_SlotBonus_Call04:
	dc.b	nRst, $0C
	smpsPSGvoice        sTone_01
	dc.b	nB6, $0C, nB6, nB6, nB6, nB6, nB6, nB6
	smpsReturn

Snd_SlotBonus_Call05:
	smpsPSGvoice        sTone_02
	dc.b	nB6, $18, nB6, nB6, nB6
	smpsReturn

; DAC Data
Snd_SlotBonus_DAC:
	dc.b	dElectricFloorTom, $0C, dElectricFloorTom, dMuffledSnare, $12, dElectricHighTom, $06, dKickS3, dElectricHighTom, dElectricMidTom, dElectricMidTom, dElectricLowTom
	dc.b	dElectricLowTom, dClapS3, $0C, dElectricFloorTom, dElectricFloorTom, dKickS3, $06, $0C, dKickS3, dSnareS3, dElectricMidTom, $06
	dc.b	dElectricLowTom, $0C, dClapS3, dElectricFloorTom, dElectricFloorTom, dMuffledSnare, $06, dElectricFloorTom, $0C, $06, dElectricHighTom, dElectricHighTom
	dc.b	$0C, dElectricMidTom, $06, dElectricMidTom, dElectricLowTom, dClapS3, $0C, dKickS3, dKickS3, $06, dSnareS3, $0C
	dc.b	dKickS3, $06, dElectricMidTom, dElectricLowTom, dKickS3, dSnareS3, dSnareS3, $0C, dMuffledSnare, dSnareS3, $06, dSnareS3

Snd_SlotBonus_Jump00:
	dc.b	dKickS3, $18, dMuffledSnare, $12, dSnareS3, $06, dKickS3, dElectricHighTom, $12, dElectricMidTom, $0C, dClapS3
	dc.b	dKickS3, $18, dMuffledSnare, $12, dSnareS3, $06, dKickS3, dElectricMidTom, $12, dElectricFloorTom, $0C, dClapS3
	dc.b	dKickS3, $18, dMuffledSnare, $06, dSnareS3, $0C, $06, dKickS3, dElectricHighTom, dElectricHighTom, $0C, dElectricMidTom
	dc.b	dClapS3, dKickS3, $18, dMuffledSnare, $0C, dSnareS3, $06, dSnareS3, dKickS3, dElectricMidTom, dElectricMidTom, $0C
	dc.b	dElectricFloorTom, dClapS3, dKickS3, $18, dMuffledSnare, $12, dSnareS3, $06, dKickS3, dElectricHighTom, $12, dElectricMidTom
	dc.b	$0C, dClapS3, dKickS3, $18, dMuffledSnare, $12, dSnareS3, $06, dKickS3, dElectricMidTom, $12, dElectricFloorTom
	dc.b	$0C, dClapS3, dKickS3, $18, dMuffledSnare, $06, dSnareS3, $0C, $06, dKickS3, dElectricHighTom, dElectricHighTom
	dc.b	$0C, dElectricMidTom, dClapS3, dCrashCymbal, $18, dCrashCymbal, dMuffledSnare, $06, dSnareS3, dSnareS3, dSnareS3, dMuffledSnare
	dc.b	dSnareS3, dSnareS3, dSnareS3, dKickS3, dKickS3, dSnareS3, $0C, dKickS3, dElectricLowTom, $06, dKickS3, $0C
	dc.b	dElectricHighTom, $06, $0C, dElectricLowTom, $06, dKickS3, dSnareS3, $0C, dKickS3, $06, dKickS3, dSnareS3
	dc.b	$0C, dKickS3, dElectricLowTom, $06, dKickS3, $0C, dElectricHighTom, $06, $0C, dElectricLowTom, $06, dKickS3
	dc.b	dElectricLowTom, $0C, dKickS3, $06, dKickS3, dSnareS3, $0C, dKickS3, dElectricLowTom, $06, dKickS3, $0C
	dc.b	dElectricHighTom, $06, $0C, dElectricLowTom, $06, dKickS3, dSnareS3, dSnareS3, dKickS3, dKickS3, dSnareS3, $0C
	dc.b	dKickS3, dElectricLowTom, $06, dKickS3, $0C, dElectricHighTom, $06, $0C, dMuffledSnare, $06, dSnareS3, $0C
	dc.b	$06, dKickS3, dKickS3, dSnareS3, $0C, dKickS3, dElectricLowTom, $06, dKickS3, $0C, dElectricHighTom, $06
	dc.b	$0C, dElectricLowTom, $06, dKickS3, dSnareS3, $0C, dKickS3, $06, dKickS3, dSnareS3, $0C, dKickS3
	dc.b	dElectricLowTom, $06, dKickS3, $0C, dElectricHighTom, $06, $0C, dElectricLowTom, $06, dKickS3, dElectricLowTom, $0C
	dc.b	dKickS3, $06, dKickS3, dSnareS3, $0C, dKickS3, dElectricLowTom, $06, dKickS3, $0C, dElectricHighTom, $06
	dc.b	$0C, dElectricLowTom, $06, dKickS3, dSnareS3, dSnareS3, dCrashCymbal, $18, dCrashCymbal, dMuffledSnare, $06, dSnareS3
	dc.b	$0C, $06, dElectricHighTom, dElectricMidTom, dElectricLowTom, dElectricFloorTom, dKickS3, $0C, dSnareS3, dKickS3, $06, $0C
	dc.b	dElectricHighTom, $06, dKickS3, $0C, dSnareS3, dKickS3, $06, $0C, dElectricLowTom, $06, dKickS3, $0C
	dc.b	dSnareS3, dKickS3, $06, dKickS3, dElectricMidTom, dElectricMidTom, dKickS3, $0C, dSnareS3, dKickS3, $06, dKickS3
	dc.b	dElectricFloorTom, dElectricFloorTom, dKickS3, $0C, dSnareS3, dKickS3, $06, dKickS3, dElectricHighTom, dElectricHighTom, dKickS3, $0C
	dc.b	dSnareS3, dKickS3, $06, dKickS3, dElectricLowTom, dElectricLowTom, dCrashCymbal, $18, dCrashCymbal, dMuffledSnare, $06, dElectricHighTom
	dc.b	dSnareS3, dElectricLowTom, dMuffledSnare, $0C, dSnareS3, $06, dSnareS3, dCrashCymbal, $0C, dSnareS3, dKickS3, $06
	dc.b	$0C, dElectricHighTom, $06, dKickS3, $0C, dSnareS3, dKickS3, $06, $0C, dElectricLowTom, $06, dKickS3
	dc.b	$0C, dSnareS3, dKickS3, $06, dKickS3, dElectricMidTom, dElectricMidTom, dKickS3, $0C, dSnareS3, dKickS3, $06
	dc.b	dKickS3, dElectricFloorTom, dElectricFloorTom, dKickS3, $0C, dSnareS3, dKickS3, $06, dKickS3, dElectricHighTom, dElectricHighTom, dKickS3
	dc.b	$0C, dSnareS3, dKickS3, $06, dKickS3, dElectricLowTom, dElectricLowTom, dSnareS3, dSnareS3, dKickS3, dSnareS3, dSnareS3
	dc.b	dKickS3, dSnareS3, dKickS3, dSnareS3, $0C, dKickS3, $06, dKickS3, dClapS3, $18
	smpsJump            Snd_SlotBonus_Jump00

Snd_SlotBonus_Voices:
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
;	$06
;	$01, $01, $01, $01, 	$1F, $0F, $0F, $0F, 	$0A, $0A, $08, $08
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$32, $94, $80, $80
	smpsVcAlgorithm     $06
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0F, $0F, $0F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $08, $0A, $0A
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $14, $32

;	Voice $04
;	$3A
;	$31, $25, $73, $41, 	$5F, $1F, $1F, $9C, 	$08, $05, $04, $1E
;	$03, $04, $02, $06, 	$2F, $2F, $1F, $0F, 	$29, $27, $1F, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $07, $02, $03
	smpsVcCoarseFreq    $01, $03, $05, $01
	smpsVcRateScale     $02, $00, $00, $01
	smpsVcAttackRate    $1C, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $1E, $04, $05, $08
	smpsVcDecayRate2    $06, $02, $04, $03
	smpsVcDecayLevel    $00, $01, $02, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1F, $27, $29

