Snd_DDZ_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_DDZ_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $0A

	smpsHeaderDAC       Snd_DDZ_DAC
	smpsHeaderFM        Snd_DDZ_FM1,	$00, $0E
	smpsHeaderFM        Snd_DDZ_FM2,	$00, $0A
	smpsHeaderFM        Snd_DDZ_FM3,	$00, $04
	smpsHeaderFM        Snd_DDZ_FM4,	$00, $04
	smpsHeaderFM        Snd_DDZ_FM5,	$00, $15
	smpsHeaderPSG       Snd_DDZ_PSG1,	$E8, $04, $00, $00
	smpsHeaderPSG       Snd_DDZ_PSG2,	$E8, $04, $00, $00
	smpsHeaderPSG       Snd_DDZ_PSG3,	$E8, $02, $00, $00

; FM1 Data
Snd_DDZ_FM1:
	smpsSetvoice        $02
	smpsModSet          $0D, $01, $02, $06
	dc.b	nRst, $3C, nCs5, $04, nD5, nEb5, nE5, nF5, nFs5, nG5, nAb5, nA5
	dc.b	nBb5, nB5, nC6, nCs6, nD6, nEb6, nE6, nEb6, nD6, nCs6, nC6, nB5
	dc.b	nBb5, nA5, nAb5, nG5, nFs5, nF5, nE5, nEb5, nD5, nCs5, nC5, nB4
	dc.b	nRst, $48, nCs6, $04, nC6, nB5, nBb5, nA5, nAb5, nG5, nFs5, nF5
	dc.b	nE5, nEb5, nD5, nCs5, nC5, nB4, nBb4, nA4, nAb4, nG4, nAb4, nA4
	dc.b	nBb4, nB4, nC5, nCs5, nD5, nEb5, nE5, nF5, nFs5, nEb5, $0C, nFs5
	dc.b	nA5, nD5, nF5, nAb5, nCs5, nE5, nG5, nC5, nEb5, nFs5, nB4, nD5
	dc.b	nF5, $18, nA5, $3C, nBb5, $0C, nA5, nG5, $6C

Snd_DDZ_Jump03:
	smpsSetvoice        $02
	dc.b	nRst, $60, nRst, nRst, nRst, $30, nA4, $04, nBb4, nB4, nC5, nCs5
	dc.b	nD5, nEb5, nE5, nF5, nFs5, nG5, nAb5, nA5, nBb5, nA5, nBb5, nA5
	dc.b	nBb5, nA5, nBb5, nA5, nBb5, nA5, nBb5, nA5, nBb5, nA5, nBb5, nA5
	dc.b	nBb5, nA5, nBb5, nA5, nBb5, nA5, nBb5, nA5, nBb5, nA5, nBb5, nA5
	dc.b	nBb5, nA5, nBb5, nA5, nBb5, nA5, nBb5, nA5, nAb5, nG5, nFs5, nF5
	dc.b	nE5, nEb5, nD5, nCs5, nC5, nB4, nBb4, nRst, $60, nRst
	smpsSetvoice        $05
	dc.b	nE5, $0C, nA4, nD5, nG4, $18, nC5, $0C, nF4, $3C, nE4, $0C
	dc.b	nF4, nC5, $24, nE5, $0C, nA4, nD5, nG4, $18, nC5, $0C, nF4
	dc.b	$3C, nE4, $0C, nF4, nE5, $24, nD5, nC5, nEb5, nD5, nF5, nE5
	dc.b	$06, nEb5, nD5, $27, nRst, $7F, smpsNoAttack, nRst, $1A, nE5, $0C, nA4
	dc.b	nD5, nG4, $18, nC5, $0C, nF4, $3C, nE4, $0C, nF4, nC5, $24
	dc.b	nE5, $0C, nA4, nD5, nG4, $18, nC5, $0C, nF4, $3C, nE4, $0C
	dc.b	nF4, nE5, $24, nD5, nC5, nEb5, nD5, nF5, nE5, $06, nEb5, nD5
	dc.b	$27, nRst, $7F, smpsNoAttack, nRst, $1A, nBb4, $06, nD5, nF5, nA5, $0C
	dc.b	nG5, $06, nFs5, nF5, $30, nC5, $0C, nEb5, $06, nFs5, nBb5, $0C
	dc.b	nA5, $06, nAb5, nG5, $30, nD5, $0C, nF5, $06, nAb5, nC6, $0C
	dc.b	nB5, $06, nBb5, nA5, $30, nE5, $0C, nG5, $06, nBb5, nD6, $0C
	dc.b	nCs6, $06, nD6, nE6, $7F, smpsNoAttack, nE6, $47
	smpsJump            Snd_DDZ_Jump03

; Unreachable
	smpsStop

; FM2 Data
Snd_DDZ_FM2:
	smpsSetvoice        $01
	smpsModSet          $0D, $01, $02, $06
	dc.b	nC3, $18, nB2, $24, nB2, $0C, nBb2, nA2, nAb2, nG2, nFs2, nG2
	dc.b	nAb2, nA2, nBb2, nB2, nC3, $18, nB2, $24, nBb2, nRst, $0C, nBb2
	dc.b	nA2, nAb2, nG2, nFs2, nF2, nE2, nEb3, $24, nD3, nCs3, nC3, nB2
	dc.b	$30, nBb2, $54, nA2, $6C

Snd_DDZ_Loop03:
	dc.b	nD4, $06, nD3, nD3, nD3, nF3, nD3, nD3, nD3, nG3, nD3, nD3
	dc.b	nD3, nAb3, nD3, nD3, nD3, nA3, nD3, nD3, nD3, nBb3, nD3, nD3
	dc.b	nD3, nB3, nD3, nD3, nD3, nC4, nD3, nCs4, nD3
	smpsLoop            $00, $06, Snd_DDZ_Loop03
	dc.b	nEb4, $06, nEb3, nEb3, nEb3, nF3, nEb3, nEb3, nEb3, nG3, nEb3, nEb3
	dc.b	nEb3, nAb3, nEb3, nEb3, nEb3, nBb3, nEb3, nEb3, nEb3, nC4, nEb3, nEb3
	dc.b	nEb3, nD4, nEb3, nEb3, nEb3, nEb4, nEb3, nF4, nEb3

Snd_DDZ_Loop04:
	dc.b	nD4, $06, nD3, nD3, nD3, nF3, nD3, nD3, nD3, nG3, nD3, nD3
	dc.b	nD3, nAb3, nD3, nD3, nD3, nA3, nD3, nD3, nD3, nBb3, nD3, nD3
	dc.b	nD3, nB3, nD3, nD3, nD3, nC4, nD3, nCs4, nD3
	smpsLoop            $00, $03, Snd_DDZ_Loop04
	dc.b	nEb4, $06, nEb3, nEb3, nEb3, nF3, nEb3, nEb3, nEb3, nG3, nEb3, nEb3
	dc.b	nEb3, nAb3, nEb3, nEb3, nEb3, nBb3, nEb3, nEb3, nEb3, nC4, nEb3, nEb3
	dc.b	nEb3, nD4, nEb3, nEb3, nEb3, nEb4, nEb3, nF4, nEb3, nD4, nD3, nD3
	dc.b	nD3, nF3, nD3, nD3, nD3, nG3, nD3, nD3, nD3, nAb3, nD3, nD3
	dc.b	nD3, nA3, nD3, nD3, nD3, nBb3, nD3, nD3, nD3, nB3, nD3, nD3
	dc.b	nD3, nC4, nD3, nCs4, nD3, nBb3, nBb3, nBb3, nBb3, nBb3, nF3, nBb3
	dc.b	nB3, $0C, nB3, $06, nB3, nB3, nB3, nF3, nB3, nC3, $0C, nC3
	dc.b	$06, nC3, nC3, nC3, nFs3, nC3, nCs3, $0C, nCs3, $06, nCs3, nCs3
	dc.b	nCs3, nG3, nCs3, nD3, $0C, nD3, $06, nD3, nD3, nD3, nAb3, nD3
	dc.b	nEb3, $0C, nEb3, $06, nEb3, nEb3, nEb3, nA3, nEb3, nE3, $0C, nE3
	dc.b	$06, nE3, nE3, nE3, nBb3, nE3, nA3, $0C, nA3, $06, nA3, nA3
	dc.b	nA3, nE3, nA3, nA3, $0C, nA3, $06, nA3, nA3, nA3, nE3, nA3
	dc.b	nA3, $0C, nA3, $06, nA3, nA3, nA3, nE3, nA3, nA3, $0C, nA3
	dc.b	$06, nA3, nA3, nA3, nE3, nA3, nA3
	smpsJump            Snd_DDZ_Loop03

; Unreachable
	smpsStop

; FM3 Data
Snd_DDZ_FM3:
	smpsSetvoice        $00
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panRight, $00
	dc.b	nRst, $0C, nEb5, $06, nRst, nD5, $7F, smpsNoAttack, nD5, $29, nRst, $0C
	dc.b	nEb5, $06, nRst, nD5, $24, nCs5, $7F, smpsNoAttack, nCs5, $05, nC5, $24
	dc.b	nB4, nBb4, nA4, nA4, $30, nA4, $54, nG4, $6C

Snd_DDZ_Jump02:
	smpsSetvoice        $03
	dc.b	nF4, $18, nA3, nBb3, nB3, nC4, nCs4, nD4, nEb4, $0C, nE4, nF4
	dc.b	$18, nA3, nBb3, nB3, nC4, nCs4, nD4, nEb4, $0C, nE4, nF4, $18
	dc.b	nA3, nBb3, nB3, nC4, nCs4, nD4, nEb4, $0C, nE4, nF4, $18, nA3
	dc.b	nBb3, nB3, nC4, nCs4, nD4, nEb4, $0C, nE4, nF4, $18, nA3, nBb3
	dc.b	nB3, nC4, nCs4, nD4, nEb4, $0C, nE4, nF4, $18, nA3, nBb3, nB3
	dc.b	nC4, nCs4, nD4, nEb4, $0C, nE4, nG4, $7F, smpsNoAttack, nG4, $41, nF4
	dc.b	$18, nA3, nBb3, nB3, nC4, nCs4, nD4, nEb4, $0C, nE4, nF4, $18
	dc.b	nA3, nBb3, nB3, nC4, nCs4, nD4, nEb4, $0C, nE4, nF4, $18, nA3
	dc.b	nBb3, nB3, nC4, nCs4, nD4, nEb4, $0C, nE4, nG4, $7F, smpsNoAttack, nG4
	dc.b	$41, nF4, $18, nA3, nBb3, nB3, nC4, nCs4, nD4, nEb4, $0C, nE4
	smpsSetvoice        $00
	dc.b	nF5, $03, nRst, nF5, nRst, nF5, nRst, nF5, nRst, nF5, $06, nRst
	dc.b	nF5, $03, nRst, nF5, $06, nRst, nF5, $03, nRst, nF5, nRst, nF5
	dc.b	nRst, nF5, $06, nRst, nF5, $03, nRst, nFs5, $0C, nFs5, $03, nRst
	dc.b	nFs5, nRst, nFs5, nRst, nFs5, $06, nRst, nFs5, $03, nRst, nG5, $06
	dc.b	nRst, nG5, $03, nRst, nG5, nRst, nG5, nRst, nG5, $06, nRst, nG5
	dc.b	$03, nRst, nAb5, $0C, nAb5, $03, nRst, nAb5, nRst, nAb5, nRst, nAb5
	dc.b	$06, nRst, nAb5, $03, nRst, nA5, $06, nRst, nA5, $03, nRst, nA5
	dc.b	nRst, nA5, nRst, nA5, $06, nRst, nA5, $03, nRst, nBb5, $0C, nBb5
	dc.b	$03, nRst, nBb5, nRst, nBb5, nRst, nBb5, $06, nRst, nBb5, $03, nRst
	dc.b	nD6, $06, nRst, nD6, $03, nRst, nD6, nRst, nD6, nRst, nD6, $06
	dc.b	nRst, nD6, $03, nRst, nCs6, $0C, nCs6, $03, nRst, nCs6, nRst, nCs6
	dc.b	nRst, nCs6, $06, nRst, nCs6, $03, nRst, nD6, $06, nRst, nD6, $03
	dc.b	nRst, nD6, nRst, nD6, nRst, nD6, $06, nRst, nD6, $03, nRst, nCs6
	dc.b	$0C, nCs6, $03, nRst, nCs6, nRst, nCs6, nRst, nCs6, $06, nRst, nCs6
	dc.b	$03, nRst, nCs6, nRst
	smpsJump            Snd_DDZ_Jump02

; Unreachable
	smpsStop

; FM4 Data
Snd_DDZ_FM4:
	smpsSetvoice        $00
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panLeft, $00
	dc.b	nRst, $0C, nC5, $06, nRst, nAb4, $7F, smpsNoAttack, nAb4, $29, nRst, $0C
	dc.b	nBb4, $06, nRst, nAb4, $24, nG4, $7F, smpsNoAttack, nG4, $05, nA4, $24
	dc.b	nAb4, nG4, nFs4, nF4, $30, nF4, $54, nE4, $6C

Snd_DDZ_Jump01:
	dc.b	nRst, $60, nRst, nRst, nRst, nRst, nRst
	smpsSetvoice        $04
	dc.b	nD6, $0C, nF6, nAb6, nCs6, nE6, nG6, nC6, nEb6, nFs6, nB5, nD6
	dc.b	nF6, nBb5, nCs6, nE6, nA5, nRst, $60, nRst, nRst, nRst
	smpsSetvoice        $03
	dc.b	nBb3, nEb5
	smpsSetvoice        $04
	dc.b	nD6, $0C, nF6, nAb6, nCs6, nE6, nG6, nC6, nEb6, nFs6, nB5, nD6
	dc.b	nF6, nBb5, nCs6, nE6, nA5, nRst, $60, nRst, nRst, nRst
	smpsSetvoice        $03
	dc.b	nBb3, $7F, smpsNoAttack, nBb3, $41
	smpsSetvoice        $04
	dc.b	nD6, $0C, nF6, nAb6, nCs6, nE6, nG6, nC6, nEb6, nFs6, nB5, nD6
	dc.b	nF6, nBb5, nCs6, nE6, nA5
	smpsSetvoice        $00
	dc.b	nD5, $03, nRst, nD5, nRst, nD5, nRst, nD5, nRst, nD5, $06, nRst
	dc.b	nD5, $03, nRst, nD5, $06, nRst, nD5, $03, nRst, nD5, nRst, nD5
	dc.b	nRst, nD5, $06, nRst, nD5, $03, nRst, nEb5, $0C, nEb5, $03, nRst
	dc.b	nEb5, nRst, nEb5, nRst, nEb5, $06, nRst, nEb5, $03, nRst, nE5, $06
	dc.b	nRst, nE5, $03, nRst, nE5, nRst, nE5, nRst, nE5, $06, nRst, nE5
	dc.b	$03, nRst, nF5, $0C, nF5, $03, nRst, nF5, nRst, nF5, nRst, nF5
	dc.b	$06, nRst, nF5, $03, nRst, nFs5, $06, nRst, nFs5, $03, nRst, nFs5
	dc.b	nRst, nFs5, nRst, nFs5, $06, nRst, nFs5, $03, nRst, nG5, $0C, nG5
	dc.b	$03, nRst, nG5, nRst, nG5, nRst, nG5, $06, nRst, nG5, $03, nRst
	dc.b	nG5, $06, nRst, nG5, $03, nRst, nG5, nRst, nG5, nRst, nG5, $06
	dc.b	nRst, nG5, $03, nRst, nG5, $0C, nG5, $03, nRst, nG5, nRst, nG5
	dc.b	nRst, nG5, $06, nRst, nG5, $03, nRst, nG5, $06, nRst, nG5, $03
	dc.b	nRst, nG5, nRst, nG5, nRst, nG5, $06, nRst, nG5, $03, nRst, nG5
	dc.b	$0C, nG5, $03, nRst, nG5, nRst, nG5, nRst, nG5, $06, nRst, nG5
	dc.b	$03, nRst, nG5, nRst
	smpsJump            Snd_DDZ_Jump01

; Unreachable
	smpsStop

; FM5 Data
Snd_DDZ_FM5:
	dc.b	nRst, $0D
	smpsSetvoice        $02
	smpsModSet          $0D, $01, $02, $06
	dc.b	nRst, $3C, nCs5, $04, nD5, nEb5, nE5, nF5, nFs5, nG5, nAb5, nA5
	dc.b	nBb5, nB5, nC6, nCs6, nD6, nEb6, nE6, nEb6, nD6, nCs6, nC6, nB5
	dc.b	nBb5, nA5, nAb5, nG5, nFs5, nF5, nE5, nEb5, nD5, nCs5, nC5, nB4
	dc.b	nRst, $48, nCs6, $04, nC6, nB5, nBb5, nA5, nAb5, nG5, nFs5, nF5
	dc.b	nE5, nEb5, nD5, nCs5, nC5, nB4, nBb4, nA4, nAb4, nG4, nAb4, nA4
	dc.b	nBb4, nB4, nC5, nCs5, nD5, nEb5, nE5, nF5, nFs5, nEb5, $0C, nFs5
	dc.b	nA5, nD5, nF5, nAb5, nCs5, nE5, nG5, nC5, nEb5, nFs5, nB4, nD5
	dc.b	nF5, $18, nA5, $3C, nBb5, $0C, nA5, nG5, $6C

Snd_DDZ_Jump00:
	smpsSetvoice        $02
	dc.b	nRst, $60, nRst, nRst, nRst, $30, nA4, $04, nBb4, nB4, nC5, nCs5
	dc.b	nD5, nEb5, nE5, nF5, nFs5, nG5, nAb5, nA5, nBb5, nA5, nBb5, nA5
	dc.b	nBb5, nA5, nBb5, nA5, nBb5, nA5, nBb5, nA5, nBb5, nA5, nBb5, nA5
	dc.b	nBb5, nA5, nBb5, nA5, nBb5, nA5, nBb5, nA5, nBb5, nA5, nBb5, nA5
	dc.b	nBb5, nA5, nBb5, nA5, nBb5, nA5, nBb5, nA5, nAb5, nG5, nFs5, nF5
	dc.b	nE5, nEb5, nD5, nCs5, nC5, nB4, nBb4, nRst, $60, nRst
	smpsSetvoice        $05
	dc.b	nE5, $0C, nA4, nD5, nG4, $18, nC5, $0C, nF4, $3C, nE4, $0C
	dc.b	nF4, nC5, $24, nE5, $0C, nA4, nD5, nG4, $18, nC5, $0C, nF4
	dc.b	$3C, nE4, $0C, nF4, nE5, $24, nD5, nC5, nEb5, nD5, nF5, nE5
	dc.b	$06, nEb5, nD5, $27, nRst, $7F, smpsNoAttack, nRst, $1A, nE5, $0C, nA4
	dc.b	nD5, nG4, $18, nC5, $0C, nF4, $3C, nE4, $0C, nF4, nC5, $24
	dc.b	nE5, $0C, nA4, nD5, nG4, $18, nC5, $0C, nF4, $3C, nE4, $0C
	dc.b	nF4, nE5, $24, nD5, nC5, nEb5, nD5, nF5, nE5, $06, nEb5, nD5
	dc.b	$27, nRst, $7F, smpsNoAttack, nRst, $1A, nBb4, $06, nD5, nF5, nA5, $0C
	dc.b	nG5, $06, nFs5, nF5, $30, nC5, $0C, nEb5, $06, nFs5, nBb5, $0C
	dc.b	nA5, $06, nAb5, nG5, $30, nD5, $0C, nF5, $06, nAb5, nC6, $0C
	dc.b	nB5, $06, nBb5, nA5, $30, nE5, $0C, nG5, $06, nBb5, nD6, $0C
	dc.b	nCs6, $06, nD6, nE6, $7F, smpsNoAttack, nE6, $47
	smpsJump            Snd_DDZ_Jump00

; Unreachable
	smpsStop

; DAC Data
Snd_DDZ_DAC:
	dc.b	dKickS3, $18, dSnareS3, $24, dKickS3, $0C, dSnareS3, $18, nRst, $0C, dKickS3, dSnareS3
	dc.b	$18, dKickS3, $0C, dKickS3, dSnareS3, $18, dKickS3, dSnareS3, $24, dKickS3, $0C, dSnareS3
	dc.b	$18, nRst, $0C, dKickS3, dSnareS3, $18, dKickS3, $0C, dKickS3, dSnareS3, $06, dKickS3
	dc.b	$12, dKickS3, $18, dSnareS3, $0C, dKickS3, $18, dKickS3, $0C, dSnareS3, $06, dKickS3
	dc.b	$12, nRst, $0C, dKickS3, dSnareS3, dKickS3, $06, dKickS3, dSnareS3, $0C, dKickS3, dSnareS3
	dc.b	$06, dKickS3, $0C, dKickS3, $06, dKickS3, $0C, dKickS3, dSnareS3, dKickS3, dKickS3, dKickS3
	dc.b	dSnareS3, dKickS3, nRst, dKickS3, dSnareS3, dKickS3, dKickS3, $06, dSnareS3, dSnareS3, dSnareS3, dSnareS3
	dc.b	dSnareS3, dSnareS3, dSnareS3

Snd_DDZ_Loop00:
	dc.b	dKickS3, $0C, dSnareS3, dKickS3, dSnareS3, dKickS3, dSnareS3, $06, dKickS3, $0C, dKickS3, $06
	dc.b	dSnareS3, $0C
	smpsLoop            $00, $07, Snd_DDZ_Loop00
	dc.b	dKickS3, $0C, dSnareS3, dKickS3, dSnareS3, dKickS3, $06, dSnareS3, dSnareS3, dKickS3, dSnareS3, dKickS3
	dc.b	dSnareS3, dSnareS3

Snd_DDZ_Loop01:
	dc.b	dKickS3, $0C, dSnareS3, dKickS3, dSnareS3, dKickS3, dSnareS3, $06, dKickS3, $0C, dKickS3, $06
	dc.b	dSnareS3, $0C
	smpsLoop            $00, $07, Snd_DDZ_Loop01
	dc.b	dKickS3, $0C, dSnareS3, dKickS3, dSnareS3, dKickS3, dSnareS3, $06, dKickS3, $0C, dKickS3, $06
	dc.b	dSnareS3, dSnareS3

Snd_DDZ_Loop02:
	dc.b	dKickS3, $0C, dSnareS3, dKickS3, dSnareS3, dKickS3, dSnareS3, $06, dKickS3, $0C, dKickS3, $06
	dc.b	dSnareS3, $0C
	smpsLoop            $00, $07, Snd_DDZ_Loop02
	dc.b	dKickS3, $0C, dSnareS3, dKickS3, dSnareS3, $06, dKickS3, dSnareS3, dSnareS3, dKickS3, dKickS3, dSnareS3
	dc.b	dKickS3, dSnareS3, dSnareS3, dKickS3, $0C, dSnareS3, dKickS3, dSnareS3, $06, dKickS3, $0C, dKickS3
	dc.b	$06, dSnareS3, $0C, dKickS3, dSnareS3, $06, dKickS3, $12, dSnareS3, $0C, dKickS3, dSnareS3
	dc.b	$06, dKickS3, $0C, dKickS3, $06, dSnareS3, $0C, dKickS3, dSnareS3, $06, dKickS3, $12
	dc.b	dSnareS3, $0C, dKickS3, dSnareS3, $06, dKickS3, $0C, dKickS3, $06, dSnareS3, $0C, dKickS3
	dc.b	dSnareS3, $06, dKickS3, $12, dSnareS3, $0C, dKickS3, dSnareS3, $06, dKickS3, $0C, dKickS3
	dc.b	$06, dSnareS3, $0C, dKickS3, dSnareS3, $06, dKickS3, $12, dSnareS3, $0C, dKickS3, $06
	dc.b	dSnareS3, dSnareS3, dKickS3, $0C, dKickS3, $06, dSnareS3, $0C, dKickS3, dSnareS3, $06, dKickS3
	dc.b	$0C, dSnareS3, $06, dSnareS3, dSnareS3, dSnareS3, dSnareS3, dSnareS3, dSnareS3
	smpsJump            Snd_DDZ_Loop00

; Unreachable
	smpsStop

; PSG1 Data
Snd_DDZ_PSG1:
	smpsModSet          $0D, $01, $02, $06

Snd_DDZ_Loop06:
	dc.b	nRst, $60
	smpsLoop            $00, $04, Snd_DDZ_Loop06

Snd_DDZ_Loop07:
	dc.b	nD6, $06, nD7, nD6
	smpsLoop            $00, $0F, Snd_DDZ_Loop07
	dc.b	nD6, $06

Snd_DDZ_Loop08:
	dc.b	nCs7, $06, nCs6, nCs6
	smpsLoop            $00, $06, Snd_DDZ_Loop08

Snd_DDZ_Loop09:
	dc.b	nRst, $60
	smpsLoop            $00, $18, Snd_DDZ_Loop09
	dc.b	nBb4, $06, nBb5, nBb4, nBb4, nBb5, nBb4, nBb4, nB4, nRst, nB5, nB4
	dc.b	nB4, nB5, nB4, nB4, nC5, nRst, nC6, nC5, nC5, nC6, nC5, nC5
	dc.b	nCs5, nRst, nCs6, nCs5, nCs5, nCs6, nRst, nCs5, nD5, nRst, nD6, nD5
	dc.b	nD5, nD6, nD5, nD5, nEb5, nRst, nEb6, nEb5, nEb5, nEb6, nEb5, nEb5
	dc.b	nE5, nRst, nE6, nE5, nE5, nE6, nE5, nE5, nA5, nRst, nA6, nA5
	dc.b	nA5, nA6, nA5, nA5, nA6, nRst, nA6, nA5, nA5, nA6, nA5, nA5
	dc.b	nA6, nRst, nA6, nA5, nA5, nA6, nA5, nA5, nA6, nRst, nA6, nA5
	dc.b	nA5, nA6, nA5, nA5, nA6
	smpsJump            Snd_DDZ_Loop09

; Unreachable
	smpsStop

; PSG2 Data
Snd_DDZ_PSG2:
	smpsModSet          $0D, $01, $02, $06
	dc.b	nRst, $0C, nG4, $06, nRst, nF4, $7F, smpsNoAttack, nF4, $29, nRst, $0C
	dc.b	nG4, $06, nRst, nF4, $24, nE4, $7F, smpsNoAttack, nE4, $05, nFs4, $24
	dc.b	nF4, nE4, nEb4, nD4, $30, nD4, $54, nCs4, $6C

Snd_DDZ_Loop05:
	dc.b	nRst, $60
	smpsLoop            $00, $1C, Snd_DDZ_Loop05
	dc.b	nRst, $60, nRst, $30
	smpsJump            Snd_DDZ_Loop05

; Unreachable
	smpsStop
	smpsStop

; PSG3 Data
Snd_DDZ_PSG3:
	smpsStop

Snd_DDZ_Voices:
;	Voice $00
;	$3D
;	$41, $10, $72, $61, 	$12, $17, $56, $17, 	$04, $06, $06, $03
;	$00, $0F, $00, $00, 	$1F, $3F, $5F, $1F, 	$1A, $88, $8B, $8B
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $06, $07, $01, $04
	smpsVcCoarseFreq    $01, $02, $00, $01
	smpsVcRateScale     $00, $01, $00, $00
	smpsVcAttackRate    $17, $16, $17, $12
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $06, $06, $04
	smpsVcDecayRate2    $00, $00, $0F, $00
	smpsVcDecayLevel    $01, $05, $03, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0B, $0B, $08, $1A

;	Voice $01
;	$2D
;	$01, $54, $30, $01, 	$1F, $1F, $1F, $1F, 	$12, $0E, $0A, $0A
;	$00, $04, $04, $03, 	$2F, $2F, $2F, $2F, 	$0E, $8B, $86, $86
	smpsVcAlgorithm     $05
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $03, $05, $00
	smpsVcCoarseFreq    $01, $00, $04, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $0A, $0E, $12
	smpsVcDecayRate2    $03, $04, $04, $00
	smpsVcDecayLevel    $02, $02, $02, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $06, $06, $0B, $0E

;	Voice $02
;	$04
;	$23, $00, $52, $00, 	$18, $12, $1A, $12, 	$08, $05, $0C, $09
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$16, $86, $28, $89
	smpsVcAlgorithm     $04
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $05, $00, $02
	smpsVcCoarseFreq    $00, $02, $00, $03
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $12, $1A, $12, $18
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $09, $0C, $05, $08
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $09, $28, $06, $16

;	Voice $03
;	$12
;	$22, $30, $50, $71, 	$0E, $12, $11, $1A, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$1A, $17, $17, $86
	smpsVcAlgorithm     $02
	smpsVcFeedback      $02
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $05, $03, $02
	smpsVcCoarseFreq    $01, $00, $00, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1A, $11, $12, $0E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $06, $17, $17, $1A

;	Voice $04
;	$04
;	$17, $03, $06, $74, 	$5F, $5F, $5F, $5F, 	$00, $08, $00, $00
;	$00, $00, $00, $0A, 	$0F, $FF, $0F, $0F, 	$1C, $89, $23, $88
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
	smpsVcTotalLevel    $08, $23, $09, $1C

;	Voice $05
;	$05
;	$71, $41, $40, $72, 	$12, $17, $16, $1A, 	$00, $00, $00, $00
;	$0C, $13, $0C, $0B, 	$FF, $FF, $FF, $FF, 	$10, $8A, $87, $85
	smpsVcAlgorithm     $05
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $04, $04, $07
	smpsVcCoarseFreq    $02, $00, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1A, $16, $17, $12
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $0B, $0C, $13, $0C
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $05, $07, $0A, $10

