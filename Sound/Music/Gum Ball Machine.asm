Snd_GumBonus_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_GumBonus_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $1E

	smpsHeaderDAC       Snd_GumBonus_DAC
	smpsHeaderFM        Snd_GumBonus_FM1,	$F4, $1A
	smpsHeaderFM        Snd_GumBonus_FM2,	$F4, $09
	smpsHeaderFM        Snd_GumBonus_FM3,	$F4, $1A
	smpsHeaderFM        Snd_GumBonus_FM4,	$F4, $16
	smpsHeaderFM        Snd_GumBonus_FM5,	$F4, $19
	smpsHeaderPSG       Snd_GumBonus_PSG1,	$DC, $03, $00, $00
	smpsHeaderPSG       Snd_GumBonus_PSG2,	$E8, $03, $00, $00
	smpsHeaderPSG       Snd_GumBonus_PSG3,	$00, $00, $00, sTone_03

; FM1 Data
Snd_GumBonus_FM1:
	smpsPan             panRight, $00
	smpsFMAlterVol      $08
	smpsSetvoice        $00
	smpsModSet          $07, $01, $08, $05
	dc.b	nRst, $01, nA5, $06, nC5, nF5, nA5, nB5, nD5, nG5, nB5, nC6
	dc.b	nE5, nA5, nC6, nD6, nF5, nB5, nD6, nE6, nG5, nC6, nE6, nF6
	dc.b	nA5, nD6, nF6
	smpsFMAlterVol      $FF
	dc.b	nE6
	smpsFMAlterVol      $FF
	dc.b	nD6
	smpsFMAlterVol      $FF
	dc.b	nC6
	smpsFMAlterVol      $FF
	dc.b	nB5
	smpsFMAlterVol      $FF
	dc.b	nA5
	smpsFMAlterVol      $FF
	dc.b	nG5
	smpsFMAlterVol      $FF
	dc.b	nF5
	smpsFMAlterVol      $FF
	dc.b	nD5
	smpsSetvoice        $01

Snd_GumBonus_Jump05:
	smpsModSet          $07, $01, $08, $05
	smpsPan             panRight, $00
	dc.b	nF5, $12, $03, nBb5, nB5, $02, nRst, $0A, nF5, $05, nRst, $07
	dc.b	nE5, $12, $03, nBb5, nB5, $02, nRst, $0A, nE5, $05, nRst, $07
	dc.b	nEb5, $12, $03, nBb5, nC6, $05, nRst, $07, nEb5, $05, nRst, $07
	dc.b	nD5, $0D, nRst, $05, nD5, $0F, nRst, $03, nD5, $06, nRst, nCs5
	dc.b	$0D, nRst, $05, nCs5, $0C, nG5, $06, nF5, $04, nRst, $08, nC5
	dc.b	$0D, nRst, $05, nC5, $0C, nG5, $06, nF5, $05, nRst, $07, nD5
	dc.b	$05, nRst, $07, nD5, $05, nRst, $07, nB4, $05, nRst, $07, nB4
	dc.b	$05, nRst, $07, nC5, $23, nRst, $0D, nF5, $12, $03, nBb5, nC6
	dc.b	nRst, $09, nF5, $05, nRst, $07, nE5, $12, $03, nBb5, nB5, $02
	dc.b	nRst, $0A, nE5, $05, nRst, $07, nEb5, $12, $03, nBb5, nC6, $06
	dc.b	nRst, nEb5, $05, nRst, $07, nD5, $0E, nRst, $04, nD5, $0F, nRst
	dc.b	$03, nD5, $06, nRst, nCs5, $0E, nRst, $04, nCs5, $0C, nG5, $06
	dc.b	nF5, $05, nRst, $07, nC5, $0E, nRst, $04, nC5, $0C, nG5, $06
	dc.b	nF5, nRst, nC5, $08, nRst, $04, nC5, $0C, nD5, $04, nRst, $08
	dc.b	nBb4, $05, nRst, $07, nA4, $30
	smpsPan             panLeft, $00
	smpsSetvoice        $02
	smpsModSet          $07, $01, $03, $05
	smpsAlterPitch      $0C
	smpsFMAlterVol      $F6
	dc.b	nRst, $0C, nD5, $18, $07, nRst, $05, nF5, $12, nRst, $06, nF5
	dc.b	$11, nRst, $07, nE5, $12, nRst, $06, nE5, $0F, nRst, $09, nE5
	dc.b	$30, nRst, $0C, nD5, $12, nRst, $06, nD5, nRst, nD5, nRst, nD5
	dc.b	nRst, nD5, nRst, nD5, $05, nRst, $07, nE5, $11, nRst, $07, nE5
	dc.b	$11, nRst, $07, nE5, $11, nRst, $07, nE5, $18, smpsNoAttack, $05, nRst
	dc.b	$07, nD5, $13, nRst, $05, nD5, $07, nRst, $05, nF5, $12, nRst
	dc.b	$06, nF5, $10, nRst, $08, nE5, $11, nRst, $07, nE5, $0F, nRst
	dc.b	$09, nF5, $30, smpsNoAttack, $05, nRst, $07, nD5, $12, nRst, $06, nD5
	dc.b	nRst, nD5, nRst, nD5, nRst, nD5, nRst, nD5, $05, nRst, $07, nE5
	dc.b	$08, nRst, $10, nE5, $18, nE5, $18, nE5, $18
	smpsAlterPitch      $F4
	smpsSetvoice        $01
	smpsFMAlterVol      $0A
	smpsJump            Snd_GumBonus_Jump05

; FM3 Data
Snd_GumBonus_FM3:
	smpsSetvoice        $01
	smpsFMAlterVol      $08
	smpsPan             panLeft, $00
	smpsModSet          $07, $01, $09, $05
	dc.b	nA5, $06, nC5, nF5, nA5, nB5, nD5, nG5, nB5, nC6, nE5, nA5
	dc.b	nC6, nD6, nF5, nB5, nD6, nE6, nG5, nC6, nE6, nF6, nA5, nD6
	dc.b	nF6
	smpsFMAlterVol      $FF
	dc.b	nE6
	smpsFMAlterVol      $FF
	dc.b	nD6
	smpsFMAlterVol      $FF
	dc.b	nC6
	smpsFMAlterVol      $FF
	dc.b	nB5
	smpsFMAlterVol      $FF
	dc.b	nA5
	smpsFMAlterVol      $FF
	dc.b	nG5
	smpsFMAlterVol      $FF
	dc.b	nF5
	smpsFMAlterVol      $FF
	dc.b	nD5

Snd_GumBonus_Jump04:
	smpsModSet          $07, $01, $09, $05
	smpsPan             panLeft, $00
	dc.b	nA5, $12, $03, nBb5, nC6, $05, nRst, $07, nA5, $05, nRst, $07
	dc.b	nA5, $12, $03, nBb5, nC6, $05, nRst, $07, nA5, $05, nRst, $07
	dc.b	nA5, $12, $03, nBb5, nC6, $05, nRst, $07, nA5, $04, nRst, $08
	dc.b	nG5, $0E, nRst, $04, nF5, $11, nRst, $01, nE5, $06, nRst, nF5
	dc.b	$0F, nRst, $03, nCs5, $0C, nG5, $06, nF5, $04, nRst, $08, nF5
	dc.b	$0D, nRst, $05, nC5, $0C, nG5, $06, nF5, $05, nRst, $07, nF5
	dc.b	$04, nRst, $08, nF5, $05, nRst, $07, nE5, $06, nRst, nF5, $05
	dc.b	nRst, $07, nG5, $24, nRst, $0C, nA5, $12, $03, nBb5, nC6, nRst
	dc.b	$09, nA5, $04, nRst, $08, nA5, $12, $03, nBb5, nC6, $05, nRst
	dc.b	$07, nA5, $05, nRst, $07, nA5, $12, $03, nBb5, nC6, $06, nRst
	dc.b	nA5, $04, nRst, $08, nG5, $0F, nRst, $03, nF5, $11, nRst, $01
	dc.b	nE5, $07, nRst, $05, nF5, $10, nRst, $02, nCs5, $0C, nG5, $06
	dc.b	nF5, $05, nRst, $07, nF5, $0F, nRst, $03, nC5, $0C, nG5, $06
	dc.b	nF5, nRst, nE5, $0C, nC5, nD5, $04, nRst, $08, nE5, $06, nRst
	dc.b	nF5, $30
	smpsPan             panRight, $00
	smpsSetvoice        $02
	smpsModSet          $07, $01, $03, $05
	smpsAlterPitch      $0C
	smpsFMAlterVol      $F6
	dc.b	nRst, $0C, nD5, $18, $07, nRst, $05, nF5, $12, nRst, $06, nF5
	dc.b	$11, nRst, $07, nE5, $12, nRst, $06, nE5, $0F, nRst, $09, nE5
	dc.b	$30, nRst, $0C, nD5, $12, nRst, $06, nD5, nRst, nD5, nRst, nD5
	dc.b	nRst, nD5, nRst, nD5, $05, nRst, $07, nE5, $11, nRst, $07, nE5
	dc.b	$11, nRst, $07, nE5, $11, nRst, $07, nE5, $18, smpsNoAttack, $05, nRst
	dc.b	$07, nD5, $13, nRst, $05, nD5, $07, nRst, $05, nF5, $12, nRst
	dc.b	$06, nF5, $10, nRst, $08, nE5, $11, nRst, $07, nE5, $0F, nRst
	dc.b	$09, nF5, $30, smpsNoAttack, $05, nRst, $07, nD5, $12, nRst, $06, nD5
	dc.b	nRst, nD5, nRst, nD5, nRst, nD5, nRst, nD5, $05, nRst, $07, nE5
	dc.b	$08, nRst, $10, nE5, $18, nE5, $18, nE5, $18
	smpsAlterPitch      $F4
	smpsSetvoice        $01
	smpsFMAlterVol      $0A
	smpsJump            Snd_GumBonus_Jump04

; FM2 Data
Snd_GumBonus_FM2:
	smpsSetvoice        $03
	smpsPan             panCenter, $00
	dc.b	nF4, $18, nG4, nA4, nB4, nC5, nD5, nRst, $06, nC5, nB4, $0C
	dc.b	nA4, nG4

Snd_GumBonus_Jump03:
	dc.b	nF4, $09, nRst, $03, nF5, $05, nRst, $07, nF4, $0A, nRst, $02
	dc.b	nF5, $07, nRst, $05, nE4, $0C, nE5, $06, nE4, $07, nRst, $05
	dc.b	nE4, $06, nE5, $07, nRst, $05, nEb4, $0B, nRst, $01, nEb5, $06
	dc.b	nRst, nEb4, $0B, nRst, $01, nEb5, $06, nRst, nD4, $0A, nRst, $02
	dc.b	nD5, $06, nD4, nRst, nD4, nD5, $07, nRst, $05, nCs4, $0C, nCs5
	dc.b	$07, nRst, $05, nCs4, $0B, nRst, $01, nCs5, $06, nRst, nC4, $0A
	dc.b	nRst, $02, nC5, $06, nC4, nRst, nC4, nC5, $09, nRst, $03, nD4
	dc.b	$0B, nRst, $01, nD5, $07, nRst, $05, nD4, $0C, nD5, $04, nRst
	dc.b	$02, nD5, $06, nRst, nC5, nC4, $07, nRst, $05, nD4, $06, nRst
	dc.b	nE4, nRst, nF4, $0A, nRst, $02, nF5, $05, nRst, $07, nF4, $0C
	dc.b	nF5, $07, nRst, $05, nE4, $0C, nE5, $06, nE4, nRst, nE4, nE5
	dc.b	$08, nRst, $04, nEb4, $0B, nRst, $01, nEb5, $06, nRst, nEb4, $0C
	dc.b	nEb5, $06, nRst, nD4, $0A, nRst, $02, nD5, $06, nD4, nRst, nD4
	dc.b	nD5, $08, nRst, $04, nCs4, $0A, nRst, $02, nCs5, $06, nRst, nCs4
	dc.b	$0B, nRst, $01, nCs5, $06, nRst, nC4, $0B, nRst, $01, nC5, $06
	dc.b	nC4, $07, nRst, $05, nC4, $06, nC5, nRst, nC5, nRst, nC4, nRst
	dc.b	nD4, nRst, nE4, $05, nRst, $07, nF4, $06, nRst, nC4, $05, nRst
	dc.b	$07, nA3, $06, nRst, nF3, $07, nRst, $05, nBb3, $0C, nBb4, $05
	dc.b	nRst, $07, nBb3, $0C, nBb4, $05, nRst, $01, nBb3, $06, nRst, nBb3
	dc.b	nC4, $08, nRst, $04, nD4, $06, nRst, nF4, $05, nRst, $07, nA3
	dc.b	$0A, nRst, $02, nA4, $06, nRst, nA3, $07, nRst, $05, nA4, $06
	dc.b	nA3, nRst, nA3, nBb3, nRst, nC4, $07, nRst, $05, nE4, $06, nRst
	dc.b	nG3, $09, nRst, $03, nG4, $06, nRst, nG3, $0A, nRst, $02, nG4
	dc.b	$06, nG3, nRst, nG3, nA3, nRst, nB3, $09, nRst, $03, nD4, $06
	dc.b	nRst, nC4, $0C, nC5, $06, nRst, nC4, $08, nRst, $04, nC5, $06
	dc.b	nC4, nRst, nC4, nD4, nRst, nE4, $07, nRst, $05, nG4, $06, nRst
	dc.b	nBb3, $08, nRst, $04, nBb4, $06, nRst, nBb3, $0B, nRst, $01, nBb4
	dc.b	$05, nRst, $01, nBb3, $06, nRst, nBb3, nC4, $08, nRst, $04, nD4
	dc.b	$06, nRst, nF4, nRst, nA3, $0C, nA4, $06, nRst, nA3, $0C, nA4
	dc.b	$06, nRst, nD4, $05, nRst, $07, nD4, nRst, $05, nE4, $07, nRst
	dc.b	$05, nF4, $07, nRst, $05, nG4, $07, nRst, $05, nG3, $12, nRst
	dc.b	$06, nG3, nRst, nG3, $07, nRst, $05, nG3, $06, nRst, nA3, $07
	dc.b	nRst, $05, nB3, $06, nRst, nC4, nRst, $12, nE4, $0D, nRst, $0B
	dc.b	nG4, $0E, nRst, $0A, nC5, $12, nRst, $06
	smpsJump            Snd_GumBonus_Jump03

; FM4 Data
Snd_GumBonus_FM4:
	smpsSetvoice        $00
	smpsFMAlterVol      $FB
	smpsPan             panCenter, $00
	smpsModSet          $07, $01, $05, $05
	dc.b	nC6, $06, nF5, nA5, nC6, nD6, nG5, nB5, nD6, nE6, nA5, nC6
	dc.b	nE6, nF6, nB5, nD6, nF6, nG6, nC6, nE6, nG6, nA6, nD6, nF6
	dc.b	nA6, nG5, nA5, nB5, nC6, nD6, nE6, nF6, nG6
	smpsFMAlterVol      $05

Snd_GumBonus_Jump02:
	dc.b	nF5, $18, nG5, $0C, nF5, nE5, $18, nF5, $0C, nE5, nEb5, $18
	dc.b	nF5, $0C, nEb5, $0B, nRst, $01, nD5, $18, nE5, $0C, nD5, $0B
	dc.b	nRst, $01, nCs5, $18, nRst, $06, nEb5, nCs5, $0B, nRst, $01, nC5
	dc.b	$19, nRst, $05, nD5, $06, nC5, $0C, nF5, $18, nD5, $16, nRst
	dc.b	$02, nC5, $18, nD5, $0C, nE5, $0B, nRst, $01, nF5, $18, nG5
	dc.b	$0C, nF5, nE5, $18, nF5, $0C, nE5, nEb5, $18, nF5, $0C, nEb5
	dc.b	$0B, nRst, $01, nD5, $18, nE5, $0C, nD5, nCs5, $1A, nRst, $04
	dc.b	nEb5, $06, nCs5, $0B, nRst, $01, nC5, $19, nRst, $05, nD5, $06
	dc.b	nC5, $0C, nG5, nF5, nE5, nC5, nF5, nC5, nA4, nF4, $0B, nRst
	dc.b	$01, nBb4, $30, nD5, $12, nC5, nBb4, $0C, nA4, $2F, nRst, $01
	dc.b	nC5, $12, nBb4, $11, nRst, $01, nA4, $0C, nG4, $30, $0C, nB4
	dc.b	nC5, nD5, $0A, nRst, $02, nC5, $17, nRst, $01, nD5, $18, nE5
	dc.b	nG5, nBb4, $2F, nRst, $01, nD5, $0C, nC5, nBb4, nD5, nCs5, $18
	dc.b	nA4, $17, nRst, $01, nD5, $18, nC5, $17, nRst, $01, nB4, $18
	dc.b	nG4, $17, nRst, $01, nA4, $18, nB4, nC5, nE5, $16, nRst, $02
	dc.b	nG5, $18, nBb5, $17, nRst, $01
	smpsJump            Snd_GumBonus_Jump02

; FM5 Data
Snd_GumBonus_FM5:
	smpsPan             panCenter, $00
	dc.b	nRst, $30, nRst, nRst, nRst

Snd_GumBonus_Jump01:
	smpsSetvoice        $01
	dc.b	nF3, $03, nRst, $09, nF4, $04, nRst, $08, nF3, $04, nRst, $08
	dc.b	nF4, $03, nRst, $09, nE3, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b	nE3, $04, nRst, $08, nE4, $04, nRst, $08, nEb3, $03, nRst, $09
	dc.b	nEb4, $04, nRst, $08, nEb3, $04, nRst, $08, nEb4, $04, nRst, $08
	dc.b	nD3, $03, nRst, $09, nD4, $04, nRst, $08, nD3, $05, nRst, $07
	dc.b	nD4, $04, nRst, $08, nCs3, $03, nRst, $09, nCs4, $04, nRst, $08
	dc.b	nCs3, $03, nRst, $09, nCs4, $03, nRst, $09, nC3, $03, nRst, $09
	dc.b	nC4, $03, nRst, $09, nC3, $03, nRst, $09, nC4, $04, nRst, $08
	dc.b	nD3, $03, nRst, $09, nD4, $04, nRst, $08, nD3, $04, nRst, $08
	dc.b	nD4, $04, nRst, $08, nRst, $06, nC4, $05, nRst, $01, nC3, $04
	dc.b	nRst, $08, nD3, $04, nRst, $08, nE3, $03, nRst, $09, nF3, $03
	dc.b	nRst, $09, nF4, $04, nRst, $08, nF3, $03, nRst, $09, nF4, $03
	dc.b	nRst, $09, nE3, $02, nRst, $0A, nE4, $03, nRst, $09, nE3, $03
	dc.b	nRst, $09, nE4, $03, nRst, $09, nEb3, $03, nRst, $09, nEb4, $03
	dc.b	nRst, $09, nEb3, $03, nRst, $09, nEb4, $03, nRst, $09, nD3, $03
	dc.b	nRst, $09, nD4, $03, nRst, $09, nD3, $04, nRst, $08, nD4, $04
	dc.b	nRst, $08, nCs3, $02, nRst, $0A, nCs4, $03, nRst, $09, nCs3, $03
	dc.b	nRst, $09, nCs4, $03, nRst, $09, nC3, $04, nRst, $08, nC4, $04
	dc.b	nRst, $08, nC3, $04, nRst, $08, nC4, $03, nRst, $09, nRst, $06
	dc.b	nG3, $05, nRst, $01, nC3, $03, nRst, $09, nD3, $05, nRst, $07
	dc.b	nE3, $04, nRst, $08, nF3, $02, nRst, $0A, nC3, $04, nRst, $08
	dc.b	nA2, $04, nRst, $08, nF2, $03, nRst, $09
	smpsSetvoice        $00
	smpsModSet          $07, $01, $07, $05
	smpsFMAlterVol      $F4
	dc.b	nRst, $0C, nD5, $18, nF5, $06, nRst, nBb5, $13, nRst, $05, nD6
	dc.b	$0F, nRst, $09, nC6, $10, nRst, $08, nA5, $0E, nRst, $0A, nC6
	dc.b	$30, nRst, $0C, nB5, $11, nRst, $07, nB5, $06, nRst, nB5, $05
	dc.b	nRst, $07, nG5, $06, nRst, nA5, $05, nRst, $07, nB5, $06, nRst
	dc.b	nC6, $10, nRst, $08, nBb5, $11, nRst, $07, nA5, $12, nRst, $06
	dc.b	nG5, $18, smpsNoAttack, $05, nRst, $07, nD5, $13, nRst, $05, nF5, $06
	dc.b	nRst, nBb5, $12, nRst, $06, nD6, $10, nRst, $08, nCs6, $10, nRst
	dc.b	$08, nA5, $11, nRst, $07, nD6, $30, smpsNoAttack, $04, nRst, $08, nB5
	dc.b	$12, nRst, $06, nB5, $05, nRst, $07, nB5, $05, nRst, $07, nG5
	dc.b	$05, nRst, $07, nA5, $05, nRst, $07, nB5, $06, nRst, nC6, $08
	dc.b	nRst, $10, nBb5, $18, nA5, $18, nG5, $18
	smpsFMAlterVol      $0C
	smpsModSet          $00, $00, $00, $00
	smpsJump            Snd_GumBonus_Jump01

; PSG1 Data
Snd_GumBonus_PSG1:
	smpsPSGvoice        $00
	dc.b	nRst, $02, nA5, $06, nC5, nF5, nA5, nB5, nD5, nG5, nB5, nC6
	dc.b	nE5, nA5, nC6, nD6, nF5, nB5, nD6, nE6, nG5, nC6, nE6, nF6
	dc.b	nA5, nD6, nF6, nE6, nD6, nC6, nB5, nA5, nG5, nF5, nD5

Snd_GumBonus_Jump08:
	dc.b	nF5, $12, $03, nBb5, nC6, $02, nRst, $0A, nF5, $05, nRst, $07
	dc.b	nE5, $12, $03, nBb5, nC6, $02, nRst, $0A, nE5, $05, nRst, $07
	dc.b	nEb5, $12, $03, nBb5, nC6, $05, nRst, $07, nEb5, $05, nRst, $07
	dc.b	nD5, $0D, nRst, $05, nD5, $0F, nRst, $03, nD5, $06, nRst, nCs5
	dc.b	$0D, nRst, $05, nCs5, $0C, nG5, $06, nF5, $04, nRst, $08, nC5
	dc.b	$0D, nRst, $05, nC5, $0C, nG5, $06, nF5, $05, nRst, $07, nD5
	dc.b	$05, nRst, $07, nD5, $05, nRst, $07, nB4, $05, nRst, $07, nB4
	dc.b	$05, nRst, $07, nC5, $23, nRst, $0D, nF5, $12, $03, nBb5, nC6
	dc.b	nRst, $09, nF5, $05, nRst, $07, nE5, $12, $03, nBb5, nC6, $02
	dc.b	nRst, $0A, nE5, $05, nRst, $07, nEb5, $12, $03, nBb5, nC6, $06
	dc.b	nRst, nEb5, $05, nRst, $07, nD5, $0E, nRst, $04, nD5, $0F, nRst
	dc.b	$03, nD5, $06, nRst, nCs5, $0E, nRst, $04, nCs5, $0C, nG5, $06
	dc.b	nF5, $05, nRst, $07, nC5, $0E, nRst, $04, nC5, $0C, nG5, $06
	dc.b	nF5, nRst, nC5, $08, nRst, $04, nC5, $0C, nD5, $04, nRst, $08
	dc.b	nBb4, $05, nRst, $07, nA4, $30
	smpsPSGvoice        sTone_09
	smpsPSGAlterVol     $FF
	dc.b	nF5, $05, nRst, $07, nBb5, $06, nRst, nD6, $05, nRst, $07, nBb5
	dc.b	$06, nRst, nF6, $05, nRst, $07, nBb5, $06, nRst, nD6, nRst, nF6
	dc.b	nRst, nF5, nRst, nA5, nRst, nC6, nRst, nA5, $07, nRst, $05, nF6
	dc.b	nRst, $07, nC6, $06, nRst, nA5, nRst, nC6, $05, nRst, $07, nG5
	dc.b	$06, nRst, nB5, nRst, nD6, $05, nRst, $07, nB5, nRst, $05, nG6
	dc.b	$06, nRst, nB5, nRst, nD6, nRst, nG6, $05, nRst, $07, nE5, $05
	dc.b	nRst, $07, nG5, $06, nRst, nC6, $05, nRst, $07, nD6, $06, nRst
	dc.b	nE6, nRst, nD6, $05, nRst, $07, nC6, $05, nRst, $07, nBb5, $05
	dc.b	nRst, $07, nF5, $05, nRst, $07, nBb5, $06, nRst, nD6, nRst, nBb5
	dc.b	nRst, nF6, $05, nRst, $07, nD6, nRst, $05, nBb5, $06, nRst, nD6
	dc.b	$05, nRst, $07, nE5, $06, nRst, nA5, nRst, nCs6, nRst, nE6, $05
	dc.b	nRst, $07, nD6, $05, nRst, $07, nA5, $06, nRst, nF5, $07, nRst
	dc.b	$05, nD5, $04, nRst, $08, nD5, $05, nRst, $07, nD5, $05, nRst
	dc.b	$07, nG5, $05, nRst, $07, nB5, $05, nRst, $07, nD6, $06, nRst
	dc.b	nG5, $05, nRst, $07, nB5, $06, nRst, nD6, $05, nRst, $07, nG5
	dc.b	$06, nRst, $12, nG5, $18, nF5, $18, nE5, $18
	smpsPSGAlterVol     $01
	smpsPSGvoice        $00
	smpsJump            Snd_GumBonus_Jump08

; PSG2 Data
Snd_GumBonus_PSG2:
	smpsPSGvoice        $00
	dc.b	nRst, $03, nA5, $06, nC5, nF5, nA5, nB5, nD5, nG5, nB5, nC6
	dc.b	nE5, nA5, nC6, nD6, nF5, nB5, nD6, nE6, nG5, nC6, nE6, nF6
	dc.b	nA5, nD6, nF6, nE6, nD6, nC6, nB5, nA5, nG5, nF5, nD5

Snd_GumBonus_Jump07:
	dc.b	nA5, $12, $03, nBb5, nC6, $05, nRst, $07, nA5, $05, nRst, $07
	dc.b	nA5, $12, $03, nBb5, nC6, $05, nRst, $07, nA5, $05, nRst, $07
	dc.b	nA5, $12, $03, nBb5, nC6, $05, nRst, $07, nA5, $04, nRst, $08
	dc.b	nG5, $0E, nRst, $04, nF5, $11, nRst, $01, nE5, $06, nRst, nF5
	dc.b	$0F, nRst, $03, nCs5, $0C, nG5, $06, nF5, $04, nRst, $08, nF5
	dc.b	$0D, nRst, $05, nC5, $0C, nG5, $06, nF5, $05, nRst, $07, nF5
	dc.b	$04, nRst, $08, nF5, $05, nRst, $07, nE5, $06, nRst, nF5, $05
	dc.b	nRst, $07, nG5, $24, nRst, $0C, nA5, $12, $03, nBb5, nC6, nRst
	dc.b	$09, nA5, $04, nRst, $08, nA5, $12, $03, nBb5, nC6, $05, nRst
	dc.b	$07, nA5, $05, nRst, $07, nA5, $12, $03, nBb5, nC6, $06, nRst
	dc.b	nA5, $04, nRst, $08, nG5, $0F, nRst, $03, nF5, $11, nRst, $01
	dc.b	nE5, $07, nRst, $05, nF5, $10, nRst, $02, nCs5, $0C, nG5, $06
	dc.b	nF5, $05, nRst, $07, nF5, $0F, nRst, $03, nC5, $0C, nG5, $06
	dc.b	nF5, nRst, nE5, $0C, nC5, nD5, $04, nRst, $08, nE5, $06, nRst
	dc.b	nF5, $30
	smpsPSGvoice        sTone_09
	smpsPSGAlterVol     $FF
	dc.b	nBb4, $05, nRst, $07, nD5, $06, nRst, nF5, $05, nRst, $07, nD5
	dc.b	$06, nRst, nBb5, $05, nRst, $07, nD5, $06, nRst, nF5, nRst, nBb5
	dc.b	nRst, nA4, nRst, nC5, nRst, nF5, nRst, nC5, $07, nRst, $05, nA5
	dc.b	nRst, $07, nC5, $06, nRst, nF5, nRst, nA5, $05, nRst, $07, nG4
	dc.b	$06, nRst, nB4, nRst, nD5, $05, nRst, $07, nB4, nRst, $05, nG5
	dc.b	$06, nRst, nB4, nRst, nD5, nRst, nG5, $05, nRst, $07, nC5, $05
	dc.b	nRst, $07, nE5, $06, nRst, nG5, $05, nRst, $07, nE5, $06, nRst
	dc.b	nC6, nRst, nBb5, $05, nRst, $07, nA5, $05, nRst, $07, nG5, $05
	dc.b	nRst, $07, nBb4, $05, nRst, $07, nD5, $06, nRst, nF5, nRst, nD5
	dc.b	nRst, nBb5, $05, nRst, $07, nD5, nRst, $05, nF5, $06, nRst, nBb5
	dc.b	$05, nRst, $07, nA4, $06, nRst, nCs5, nRst, nE5, nRst, nA5, $05
	dc.b	nRst, $07, nD5, $05, nRst, $07, nF5, $06, nRst, nA5, $07, nRst
	dc.b	$05, nD6, $04, nRst, $08, nG5, $05, nRst, $07, nG4, $05, nRst
	dc.b	$07, nB4, $05, nRst, $07, nD5, $05, nRst, $07, nG5, $06, nRst
	dc.b	nD5, $05, nRst, $07, nG5, $06, nRst, nB5, $05, nRst, $07, nC5
	dc.b	$06, nRst, $12, nC5, $18, nD5, $18, nE5, $18
	smpsPSGAlterVol     $01
	smpsPSGvoice        $00
	smpsJump            Snd_GumBonus_Jump07

; PSG3 Data
Snd_GumBonus_PSG3:
	smpsPSGform         $E7
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2, $18, nMaxPSG2, nMaxPSG2, nMaxPSG2, nMaxPSG2, nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2, $0C
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2, $0C, nMaxPSG2, nMaxPSG2

Snd_GumBonus_Jump06:
	dc.b	nRst, nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2, nMaxPSG2, nRst, nMaxPSG2, $18, $0C, nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2, $18, nRst, $0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2, $18, $0C, nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2, nMaxPSG2, nRst, nMaxPSG2, $18, $0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2, nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2, nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2, nMaxPSG2, $18
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2, $0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2, nMaxPSG2, $18
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2, $0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2, nMaxPSG2, $18
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2, $0C, nRst, $30
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2, $0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2, nMaxPSG2, nMaxPSG2, $18
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2, $0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2, $18, nMaxPSG2, nMaxPSG2, nMaxPSG2, nMaxPSG2, $0C
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG2, nRst, $18
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2
	smpsJump            Snd_GumBonus_Jump06

; DAC Data
Snd_GumBonus_DAC:
	dc.b	dKickS3, $18, dKickS3, dKickS3, dKickS3, dKickS3, dKickS3, $0C, dSnareS3, nRst, $06, dSnareS3
	dc.b	dKickS3, dSnareS3, dSnareS3, $0C, dSnareS3

Snd_GumBonus_Jump00:
	dc.b	dCrashCymbal, $0C, dSnareS3, dKickS3, dSnareS3, dKickS3, dSnareS3, dKickS3, dSnareS3, dKickS3, dSnareS3, dKickS3
	dc.b	dSnareS3, dKickS3, dSnareS3, dKickS3, dSnareS3, dCrashCymbal, dSnareS3, dKickS3, $06, dSnareS3, dSnareS3, $0C
	dc.b	dCrashCymbal, dSnareS3, $06, dSnareS3, dKickS3, $0C, dSnareS3, dKickS3, dSnareS3, $06, dSnareS3, dKickS3
	dc.b	$0C, dSnareS3, $06, dSnareS3, dKickS3, dSnareS3, $0C, $06, dKickS3, dSnareS3, dClapS3, $0C
	dc.b	dCrashCymbal, $0C, dSnareS3, dKickS3, dSnareS3, dKickS3, dSnareS3, dKickS3, dSnareS3, dKickS3, dSnareS3, dKickS3
	dc.b	dSnareS3, dKickS3, dSnareS3, dKickS3, dSnareS3, dCrashCymbal, dSnareS3, dKickS3, $06, dSnareS3, dSnareS3, $0C
	dc.b	dCrashCymbal, dSnareS3, $06, dSnareS3, dKickS3, $0C, dSnareS3, dKickS3, dSnareS3, $06, dSnareS3, dKickS3
	dc.b	dSnareS3, dSnareS3, dSnareS3, dMuffledSnare, dSnareS3, $0C, $06, dMuffledSnare, dSnareS3, dMuffledSnare, dSnareS3, dKickS3
	dc.b	$0C, dCrashCymbal, dKickS3, $06, dKickS3, dSnareS3, $0C, dKickS3, $06, dKickS3, dSnareS3, dKickS3
	dc.b	$0C, $06, dSnareS3, $0C, dKickS3, dSnareS3, dKickS3, $06, dKickS3, dSnareS3, $0C, dKickS3
	dc.b	$06, dKickS3, dSnareS3, dKickS3, $0C, $06, dSnareS3, $0C, dCrashCymbal, dSnareS3, dKickS3, $06
	dc.b	$0C, dSnareS3, $06, dCrashCymbal, $0C, dSnareS3, dKickS3, $06, dKickS3, dSnareS3, dSnareS3, dMuffledSnare
	dc.b	$0C, dSnareS3, dMuffledSnare, dSnareS3, dElectricHighTom, $06, dElectricMidTom, dElectricLowTom, dElectricFloorTom, dSnareS3, dSnareS3, dSnareS3
	dc.b	dSnareS3, dKickS3, $0C, dCrashCymbal, dKickS3, $06, dKickS3, dSnareS3, $0C, dKickS3, $06, dKickS3
	dc.b	dSnareS3, dKickS3, $0C, $06, dSnareS3, $0C, dKickS3, dCrashCymbal, dKickS3, dCrashCymbal, dKickS3, dCrashCymbal
	dc.b	dKickS3, dCrashCymbal, dKickS3, dSnareS3, dKickS3, dSnareS3, dSnareS3, $06, $0C, dElectricHighTom, $06, dSnareS3
	dc.b	dElectricLowTom, dSnareS3, dElectricFloorTom, dMuffledSnare, dSnareS3, $0C, $06, dMuffledSnare, $0C, dSnareS3, dCrashCymbal, dClapS3
	dc.b	dClapS3, dClapS3
	smpsJump            Snd_GumBonus_Jump00

Snd_GumBonus_Voices:
;	Voice $00
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

;	Voice $01
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

;	Voice $02
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

;	Voice $03
;	$20
;	$36, $35, $30, $31, 	$DF, $DF, $9F, $9F, 	$07, $06, $09, $06
;	$07, $06, $06, $08, 	$20, $10, $10, $F8, 	$19, $37, $13, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $04
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $03, $03
	smpsVcCoarseFreq    $01, $00, $05, $06
	smpsVcRateScale     $02, $02, $03, $03
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $09, $06, $07
	smpsVcDecayRate2    $08, $06, $06, $07
	smpsVcDecayLevel    $0F, $01, $01, $02
	smpsVcReleaseRate   $08, $00, $00, $00
	smpsVcTotalLevel    $00, $13, $37, $19

