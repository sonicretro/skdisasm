Snd_SKCredits_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_SKCredits_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $0F

	smpsHeaderDAC       Snd_SKCredits_DAC
	smpsHeaderFM        Snd_SKCredits_FM1,	$00, $00
	smpsHeaderFM        Snd_SKCredits_FM2,	$00, $00
	smpsHeaderFM        Snd_SKCredits_FM3,	$00, $00
	smpsHeaderFM        Snd_SKCredits_FM4,	$00, $00
	smpsHeaderFM        Snd_SKCredits_FM5,	$00, $00
	smpsHeaderPSG       Snd_SKCredits_PSG1,	$00, $00, $00, sTone_1B
	smpsHeaderPSG       Snd_SKCredits_PSG2,	$00, $00, $00, sTone_1B
	smpsHeaderPSG       Snd_SKCredits_PSG3,	$00, $00, $00, sTone_1B

; FM1 Data
Snd_SKCredits_FM1:
	smpsSetNote         $4C
	smpsSetVol          $75
	dc.b	nRst, $30
	smpsSetvoice        $20
	dc.b	nD2, $10, $07, nRst, $06, nRst, $05, nD2, $07, nRst, $06, nRst
	dc.b	$05, nD3, $06, nD2, nRst, $07, nD3, $06, nRst, nC2, $0C, smpsNoAttack
	dc.b	$0C, $0C, nRst, $06, nC3, nRst, $0C, $18, $18, nD2, $11, $07
	dc.b	nRst, $06, nRst, $05, nD2, $07, nRst, $06, nRst, $05, nD3, $06
	dc.b	nD2, nRst, $07, nD3, $06, nRst, nC2, $0C, smpsNoAttack, $06, nRst, nC3
	dc.b	nRst, nC2, nC3, nC2, nRst, nC2, nRst, nG1, nRst, nB1, nRst, nBb1
	dc.b	$0C, smpsNoAttack, $0D, nBb1, $0C, nBb2, nBb1, nBb1, nBb2, nBb1, nAb1, smpsNoAttack
	dc.b	nAb1, nAb1, nAb2, nAb1, nAb1, nAb2, nAb1, nC2, smpsNoAttack, nC2, nC2, nC3
	dc.b	nC2, nC3, nC2, nC3, nC2, smpsNoAttack, $30, nRst, $30
	smpsSetNote         $40
	smpsSetVol          $72
	smpsSetvoice        $00
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nRst, $60, nRst, nRst
	smpsSetvoice        $00
	dc.b	nB5, $04, nBb5, nG5, nA5, nFs5, nAb5, nF5, nG5, nE5, nFs5, nEb5
	dc.b	nF5, nD5, nE5, nCs5, nEb5, nC5, nD5, nB4, nCs5, nBb4, nC5, nA4
	dc.b	nB4

Snd_SKCredits_Loop1B:
	smpsSetvoice        $02
	dc.b	nB4, $01, nC5, $3B, nD5, $06, nRst, nF5, nRst, nG5, nRst, nE5
	dc.b	$01, nF5, $06, nRst, $05, nCs5, $06, nRst, nC5, nBb4, nRst, nG4
	dc.b	$36, nRst, $0C, nBb4, $18, nC5, $06, nBb4, $05, nC5, $01, nCs5
	dc.b	$06, nRst, nC5, nRst, nEb5, nD5, nRst, nBb4, nRst, $60
	smpsLoop            $00, $02, Snd_SKCredits_Loop1B
	dc.b	nRst, $0C, nBb4, $18, nC5, $06, nBb4, nCs5, nRst, nC5, nRst, nBb4
	dc.b	nC5, nRst, nBb4, nRst, $60, nRst, $0C, nBb4, $18, nC5, $06, nBb4
	dc.b	$05, nCs5, $01, nD5, nEb5, $06, nRst, $05, nD5, $06, nRst, nC5
	dc.b	nD5, nRst, nBb4, nRst, $60
	smpsSetvoice        $07
	smpsSetNote         $4C
	smpsSetVol          $76
	dc.b	nF1, $04, nRst, $02, nF1, $04, nRst, $02, nF1, $04, nRst, $02
	dc.b	nF1, $06, nF1, $02, nRst, $46, nG1, $04, nRst, $02, nG1, $04
	dc.b	nRst, $02, nG1, $04, nRst, $02, nG1, $04, nRst, $02, nG1, $04
	dc.b	nRst, $14, nC2, $10, nRst, $08, nG1, $0E, nRst, $0A, nA1, $04
	dc.b	nRst, $08, nG1, $02, nRst, $04, nA1, $08, nRst, $0A, nC2, $04
	dc.b	nRst, $08, nB1, $02, nRst, $04, nC2, $08, nRst, $0A, nD2, $04
	dc.b	nRst, $08, nC2, $02, nRst, $04, nD2, $08, nRst, $0A, nE2, $04
	dc.b	nRst, $08, nD2, $02, nRst, $04, nE2, $08, nRst, $0A, nG2, $16
	dc.b	nRst, $02, nG1, $16, nRst, $02, nA1, $02, nRst, $0A, nA1, $04
	dc.b	nRst, $02, nA1, $08, nRst, $0A, nC2, $04, nRst, $08, nC2, $06
	dc.b	nC2, $04, nRst, $0E, nD2, $04, nRst, $02, nC2, $06, nA1, $02
	dc.b	nRst, $0A, nG1, $06, nRst, $0C, nG1, $06, nRst, $0C, nA1, $24
	dc.b	nRst, $18, nA1, $04, nRst, $08, nA1, $04, nRst, $02, nA1, $06
	dc.b	nRst, $0C, nC2, $06, nRst, $06, nC2, $04, nRst, $02, nC2, $04
	dc.b	nRst, $0E, nD2, $02, nRst, $04, nC2, $06, nA1, $04, nRst, $08
	dc.b	nG1, $06, nRst, $0C, nG1, $06, nRst, $0C, nA1, $36, nRst, $06
	dc.b	nRst, $30
	smpsPan             panCenter, $00
	smpsSetNote         $40
	smpsSetVol          $78
	smpsModSet          $0D, $01, $02, $06
	smpsCall            Snd_SKCredits_Call01
	smpsCall            Snd_SKCredits_Call01
	smpsCall            Snd_SKCredits_Call02
	dc.b	nRst, $10
	smpsCall            Snd_SKCredits_Call02
	dc.b	nRst, $10
	smpsSetNote         $40
	smpsSetVol          $74
	smpsSetvoice        $18
	smpsCall            Snd_SKCredits_Call03
	dc.b	nRst, $18
	smpsSetvoice        $03
	smpsSetVol          $70
	smpsSetvoice        $1A
	smpsCall            Snd_SKCredits_Call04
	dc.b	nRst, $10, nRst, $60
	smpsPan             panCenter, $00
	smpsSetNote         $28
	smpsSetVol          $72
	smpsSetvoice        $0F
	smpsAlterNote       $FE
	dc.b	nG2, $07, nRst, $04, nG2, $08, nRst, $04, $24, nG3, nG2, nG2
	dc.b	$0C, nRst, nC3, $14, nB2, $10, nG2, $08, nRst, $04, nG2, $08
	dc.b	nRst, $04, $24, nG3, nG2, nG2, $0C, nRst, $30

Snd_SKCredits_Loop1C:
	dc.b	nC3, $60, nC4, $24, nC3, nC4, $18, nBb2, $06, nRst, $06, nBb2
	dc.b	$54, nBb3, $24, nBb2, nBb3, $18, nA2, $06, nRst, $06, nA2, $48
	dc.b	nG3, $06, nAb3, nA3, $24, nA2, nA3, $18, nAb2, $06, nRst, $06
	dc.b	nAb2, $54, nAb3, $24, nAb2, nBb3, $18
	smpsLoop            $00, $02, Snd_SKCredits_Loop1C
	dc.b	nC3, $60, smpsNoAttack, $60, smpsNoAttack, $61
	smpsSetVol          $6D
	smpsSetNote         $41
	smpsSetvoice        $1E
	smpsPan             panCenter, $00
	smpsAlterNote       $FE
	smpsModSet          $14, $01, $06, $06
	dc.b	nA4, $06, nCs5, nB4, nD5
	smpsFMAlterVol      $FF
	dc.b	nCs5, nE5, nD5, nFs5
	smpsFMAlterVol      $FF
	dc.b	nE5, nAb5, nFs5, nA5
	smpsFMAlterVol      $FF
	dc.b	nAb5, nB5, nA5, nCs6
	smpsSetvoice        $1C
	dc.b	nA4, $18, nFs4, $0C, nE4, nA4, nFs4, nD4, nE4, smpsNoAttack, nE4, $24
	dc.b	nD5, $18
	smpsNoteFill        $06
	dc.b	$0C, $0C, $0C
	smpsNoteFill        $00
	dc.b	nCs5, $18, nA4, $0C, nE4, nFs4, $04, nRst, $08, nA4, $18, nB4
	dc.b	$0C, smpsNoAttack, nB4, $30, nRst, nA4, $18, nFs4, $0C, nE4, nA4, nFs4
	dc.b	nD4, nE4, smpsNoAttack, nE4, $24, nD5, $18
	smpsNoteFill        $06
	dc.b	$0C, $0C, $0C
	smpsNoteFill        $00
	smpsFMAlterVol      $FD
	dc.b	nD5, nCs5, $18, nA4, nB4, nRst, $0C, nE5, nD5, $18, nA4, nB4
	smpsFMAlterVol      $FE
	dc.b	nCs5, $0C
	smpsStop

Snd_SKCredits_Call02:
	smpsSetvoice        $0B
	dc.b	nE4, $48, nE4, $06, nA4, nRst, nE4, $42, nD4, $06, nRst, nC4
	dc.b	nRst, nB3, nRst, nC4, $12, nA3, $06, nRst, $48, nRst, $50
	smpsReturn

Snd_SKCredits_Call04:
	dc.b	nAb3, $06, nBb3, nC4, nEb4
	smpsLoop            $00, $04, Snd_SKCredits_Call04

Snd_SKCredits_Loop2F:
	dc.b	nBb3, $06, nC4, nD4, nF4
	smpsLoop            $00, $04, Snd_SKCredits_Loop2F
	dc.b	nRst, $60, nRst, $06, nBb4, $12, nA4, $06, nRst, nG4, nRst, nBb4
	dc.b	nRst, nG4, nA4, nRst, nBb4, $12

Snd_SKCredits_Loop30:
	dc.b	nAb3, $06, nBb3, nC4, nEb4
	smpsLoop            $00, $04, Snd_SKCredits_Loop30

Snd_SKCredits_Loop31:
	dc.b	nBb3, $06, nC4, nD4, nF4
	smpsLoop            $00, $04, Snd_SKCredits_Loop31
	dc.b	nRst, $60, nRst, $06, nBb4, $12, nA4, $06, nRst, nG4, nRst, nBb4
	dc.b	nG4, nRst, nC5, nRst, $08
	smpsReturn

Snd_SKCredits_Call03:
	dc.b	nRst, $0C, nD4, nD4, nC4, nC4, nB3, nB3, nA3, nAb3, $18, nA3
	dc.b	$08, nRst, $04, nB3, $08, nRst, $34, nRst, $0C, nAb4, $08, nRst
	dc.b	$04, nA4, $08, nRst, $04, nB4, $08, nRst, $04, nC5, $08, nRst
	dc.b	$04, nB4, $08, nRst, $04, nA4, $08, nRst, $04, nB4, $08, nRst
	dc.b	$04, nD5, $08, nRst, $04, nC5, $08, nRst, $04, nB4, $08, nRst
	dc.b	$04, nA4, $08, nRst, $04, nAb4, $08, nRst, $04, nF4, $08, nRst
	dc.b	$04, nE4, $08, nRst, $04, nD4, $08, nRst, $04, nE5, $08, nRst
	dc.b	$10, nD5, $08, nRst, $40, nC5, $08, nRst, $10, nB4, $08, nRst
	dc.b	$40, nE5, $08, nRst, $10, nD5, $08, nRst, $40, nAb5, $08, nRst
	dc.b	$10, nF5, $08, nRst, $10, nB5, $08, nRst, $04, nD6, $08, nRst
	dc.b	$04
	smpsReturn

Snd_SKCredits_Call01:
	smpsSetvoice        $13
	dc.b	nRst, $0C, nB4, $04, nRst, $08, nC5, $04, nRst, $08, nB4, $24
	dc.b	nE5, $04, nRst, $14, nEb5, $02, nE5, $16, nC5, $04, nRst, $08
	dc.b	nA4, $18, nE4, $60, nRst, $24
	smpsSetvoice        $14
	dc.b	nRst, $36, nD5, $06, nE5, nG5, nB4, nC5, nA4, $0C
	smpsReturn

; Unreachable
	dc.b	nEb4, $0C, nD4, $02, nC4, nBb3, nAb3, nG3, nF3, nC4, $0A, nRst
	dc.b	$02, nEb4, $04, nRst, $02, nE4, nF4, nRst, $08, nD4, $10, nRst
	dc.b	$02, nC4, $04, nRst, $08, nBb3, $04, nRst, $08, nFs3, $02, nG3
	dc.b	$14, nRst, $02, nFs3, nG3, $08, nRst, $02, nF3, $04, nRst, $02
	dc.b	nFs3, nG3, $28, nC4, $04, nRst, $02, nD4, $04, nRst, $02, nEb4
	dc.b	$0C, nD4, $02, nC4, nBb3, nAb3, nG3, nF3, nC4, $0A, nRst, $02
	dc.b	nEb4, $04, nRst, $02, nE4, nF4, nRst, $08, nD4, $10, nRst, $02
	dc.b	nC4, $04, nRst, $08, nB3, $04, nRst, $08, nC4, $10, nRst, $02
	dc.b	nC4, $04, nRst, $02, nD4, $0A, nRst, $02, nC4, $04, nRst, $02
	dc.b	nD4, $04, nRst, $08, nEb4, $10, nRst, $02, nF4, $0A, nRst, $02
	dc.b	nC4, $04, nRst, $02, nD4, $04, nRst, $02, nEb4, $0C, nD4, $02
	dc.b	nC4, nBb3, nAb3, nG3, nF3, nC4, $0A, nRst, $02, nEb4, $04, nRst
	dc.b	$02, nE4, nF4, nRst, $08, nD4, $10, nRst, $02, nC4, $04, nRst
	dc.b	$08, nBb3, $04, nRst, $08, nFs3, $02, nG3, $14, nRst, $02, nFs3
	dc.b	nG3, $08, nRst, $02, nF3, $04, nRst, $02, nFs3, nG3, $28, nC4
	dc.b	$04, nRst, $02, nD4, $04, nRst, $02, nEb4, $10, nRst, $02, nEb4
	dc.b	$04, nRst, $08, nD4, $04, nRst, $02, nEb4, $10, nRst, $02, nEb4
	dc.b	$04, nRst, $02, nF4, $0A, nRst, $02, nEb4, $04, nRst, $08, nAb4
	dc.b	$04, nRst, $0E, nC5, $04, nRst, $08, nC5, $04, nRst, $08, nC5
	dc.b	$04, nRst, $02, nC5, $0A, nRst, $02, nB4, $04, $F9
	
; FM2 Data
Snd_SKCredits_FM2:
	smpsSetvoice        $1F
	smpsSetVol          $68
	dc.b	nRst, $30
	smpsCall            Snd_SKCredits_Call05
	dc.b	nRst, $3C
	smpsSetNote         $40
	smpsSetVol          $70
	smpsSetvoice        $01
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00

Snd_SKCredits_Loop16:
	dc.b	nG2, $06, nA2, nD3, nF3, nRst, nE3, nRst, nD3, nRst, nC3, nRst
	dc.b	nC3, nD3, nD3, $01, nRst, $05, nE3, $0C, nC3, $06, nBb2, nRst
	dc.b	nBb2, nBb2, $02, nRst, $04, nBb2, $02, nRst, $04, nC3, $06, nBb2
	dc.b	nRst, nBb2, nRst, nBb2, $02, nRst, $04, nC3, $0C, nBb2
	smpsLoop            $00, $06, Snd_SKCredits_Loop16
	dc.b	nFs2, $06, nFs3, nFs2, nRst, nFs2, nRst, nFs2, nRst, nAb2, nRst, nAb2
	dc.b	nRst, nAb2, nRst, nAb2, nAb2, nRst, nBb2, $12, nBb2, $06, nRst, $12
	dc.b	nBb2, $06, nAb2, nA2, nBb2, nRst, $18, nFs2, $06, nFs3, nFs2, nRst
	dc.b	nFs2, nRst, nFs2, nRst, nAb2, nRst, nAb2, nRst, nAb2, nRst, nAb2, nAb2
	dc.b	nRst, nBb2, $12, nBb2, $06, nRst, $12, nBb2, $06, nAb2, nA2, nBb2
	dc.b	nRst, $0C
	smpsSetvoice        $08
	smpsPan             panLeft, $00
	smpsSetNote         $4C
	smpsSetVol          $7E
	dc.b	nE4, $06, nF4, $06, nG4, $24, nC4, $36, nRst, $06, nG4, $18
	dc.b	nA4, $04, nRst, $08, nG4, $38, nRst, $10, nA4, $0C, nG4, $06
	dc.b	nRst, $06, nA4, $04, nRst, $08, nC5, $10, nRst, $02, nB4, $04
	dc.b	nRst, $0C, nA4, $06, nRst, $08, nB4, $10, nRst, $02, nC5, $04
	dc.b	nRst, $0E, nD5, $04, nRst, $08, nC5, $16, nRst, $02, nB4, $16
	dc.b	nRst, $02, nE5, $0C, nA4, $06, nE5, $04, nRst, $0E, nA4, $22
	dc.b	nRst, $02, nC5, $14, nRst, $04, nB4, $06, nRst, $06, nB4, $04
	dc.b	nRst, $02, nD5, $06, nRst, $06, nB4, $04, nRst, $02, nC5, $32
	dc.b	nRst, $0A, nE5, $0C, nA4, $04, nRst, $02, nE5, $06, nRst, $0C
	dc.b	nA4, $22, nRst, $02, nC5, $14, nRst, $04, nB4, $06, nRst, $06
	dc.b	nB4, $04, nRst, $02, nD5, $06, nRst, $06, nB4, $04, nRst, $02
	dc.b	nC5, $26, nRst, $16, nRst, $30
	smpsPan             panCenter, $00
	smpsSetNote         $40
	smpsSetVol          $76
	smpsModSet          $0D, $01, $02, $06

Snd_SKCredits_Loop17:
	smpsSetvoice        $15
	dc.b	nA1, $06, nA1, nA2, $0C, nA1, $06, nA1, nA1, $03, nRst, nA1
	dc.b	nRst, nAb1, $0C, nAb2, $04, nRst, $08, nAb1, $0C, nAb1, $06, nAb1
	dc.b	nG1, nG1, nG2, $0C, nG1, $06, nG1, nG1, $03, nRst, nG1, nRst
	dc.b	nAb1, $0C, nAb2, $04, nRst, $08, nAb1, $0C, nAb1, $06, nAb1, nA1
	dc.b	$0C, nA1, nA1, nG2, $06, nA2, nA1, $0C, nA1, nA1, nG2, $06
	dc.b	nA2, nG2, nA2, $03, nRst, nA1, $0C, nA1, nG2, $06, nA2, $03
	dc.b	nRst, nA1, $0C, nA1, nG2, $06, nA2, $03, nRst, nA1, $0C
	smpsLoop            $00, $04, Snd_SKCredits_Loop17
	smpsSetNote         $40
	smpsSetVol          $75

Snd_SKCredits_Loop18:
	dc.b	nE1, $0C, nRst, $24, nE1, $0C, nE1, $0A, nRst, $1A
	smpsLoop            $00, $08, Snd_SKCredits_Loop18
	smpsSetVol          $73
	smpsSetvoice        $1B

Snd_SKCredits_Loop19:
	dc.b	nAb1, $0C, nAb1, nAb1, $03, nRst, nAb2, nRst, nAb1, nRst, nAb2, nRst
	dc.b	nAb1, $0C, nAb1, nAb1, $03, nRst, nAb2, nRst, nAb1, nRst, nAb2, nRst
	dc.b	nBb1, $0C, nBb1, nBb1, $03, nRst, nBb2, nRst, nBb1, nRst, nBb2, nRst
	dc.b	nBb1, $0C, nBb1, nBb1, $03, nRst, nBb2, nRst, nBb1, nRst, nBb2, nRst
	dc.b	nC2, $06, nC2, $03, nRst, nBb2, $06, nC3, $03, nRst, nF2, $06
	dc.b	nG2, $03, nRst, nC2, nRst, nBb1, nRst, nC2, $06, nBb1, nC2, $03
	dc.b	nRst, nC2, $06, nRst, nC2, nRst, nC2, nC2, $0C, nC2, nRst, $48
	smpsLoop            $00, $02, Snd_SKCredits_Loop19
	dc.b	nRst, $60
	smpsPan             panCenter, $00
	smpsSetNote         $40
	smpsSetVol          $68
	dc.b	nRst, $60, nRst, nRst, nRst

Snd_SKCredits_Loop1A:
	smpsSetvoice        $10
	dc.b	nC4, $60, smpsNoAttack, $60, nBb3, smpsNoAttack, $60, nA3, smpsNoAttack, $60, nAb3, smpsNoAttack
	dc.b	$60
	smpsLoop            $00, $02, Snd_SKCredits_Loop1A
	dc.b	nC4, $60, smpsNoAttack, $60, smpsNoAttack, $60
	smpsSetVol          $7B
	smpsSetNote         $4D
	smpsPan             panCenter, $00
	smpsSetvoice        $1D
	dc.b	nE1, $06, nE1, nRst, nE1, nRst, nE1, nE1, smpsNoAttack, nE1, nRst, nRst
	dc.b	nE1, smpsNoAttack, nE1, nE1, nE1, nE1, nE1, nA1, $06, nA1, nRst, nA1
	dc.b	nRst, nA1, nA1, smpsNoAttack, nA1, nFs1, $0C, nFs1, smpsNoAttack, nFs1, nE1, nE1
	dc.b	$06, nE1, nRst, nE1, nRst, nE1, nD1, smpsNoAttack, nD1, nRst, nD1, nRst
	dc.b	nD2, smpsNoAttack, nD2, nD1, nD1, nD1, nA1, nA1, nRst, nA1, nRst, nA1
	dc.b	nA1, smpsNoAttack, nA1, nFs1, $0C, nFs1, smpsNoAttack, nFs1, nG1, nG1, $06, nG1
	dc.b	nRst, nG1, nRst, nG1, nE1, smpsNoAttack, nE1, nRst, nE1, nRst, nE2, smpsNoAttack
	dc.b	nE2, nE1, nE1, nE1, nA1, $06, nA1, nRst, nA1, nRst, nA1, nA1
	dc.b	smpsNoAttack, nA1, nFs1, $0C, nFs1, smpsNoAttack, nFs1, nE1, nE1, $06, nE1, nRst
	dc.b	nE1, nRst, nE1, nD1, smpsNoAttack, nD1, nRst, nD1, nRst, nD2, smpsNoAttack, nD2
	dc.b	nD1, nD1, nD1, nA1, nA1, nRst, nA1, nRst, nA1, nA1, smpsNoAttack, nA1
	dc.b	nFs1, $0C, nFs1, smpsNoAttack, nFs1, nG1, nG1, $06, nG1, nRst, nG1, nRst
	dc.b	nG1, nE1, smpsNoAttack, nE1, nRst, nE1, nRst, nE2, smpsNoAttack, nE2, nE1
	smpsFMAlterVol      $FD
	dc.b	nA1, $60
	smpsStop

Snd_SKCredits_Call05:
	smpsModSet          $0C, $02, $01, $0E
	dc.b	nA4, $30, smpsNoAttack, $0C, nB4, nRst, nG4, smpsNoAttack, $30, smpsNoAttack, $0C
	smpsModSet          $14, $01, $FE, $01
	dc.b	nE4, $30
	smpsModSet          $0C, $02, $01, $0E
	dc.b	nRst, $0C, nA4, $18, nA4, $0C, nB4, nRst, nG4, nRst, nE4, nE4
	dc.b	nRst, nE4, nEb4, nRst, nD4, nRst
	smpsModSet          $01, $01, $05, $00
	dc.b	nC5, $0C, smpsNoAttack
	smpsModSet          $00, $00, $00, $00
	dc.b	nC5, $18
	smpsModSet          $0C, $02, $01, $0E
	dc.b	nBb4, $0C, nA4, nRst, nAb4, smpsNoAttack, nAb4, $18, nEb4, nEb4, $0C, nF4
	dc.b	nAb4, nG4, smpsNoAttack, nG4, $54
	smpsModSet          $01, $01, $0A, $00
	dc.b	nBb4, $0C, smpsNoAttack
	smpsModSet          $00, $00, $00, $00
	dc.b	nBb4, $24
	smpsModSet          $0C, $02, $01, $0E
	smpsReturn

; Unreachable
Snd_SKCredits_Loop32:
	dc.b	nF2, $0C, nBb2, $0C, nF3, $0C, nE3, $05, nRst, $0D, nC3, $05
	dc.b	nRst, $0D, nBb2, $3B, nRst, $3D, nF2, $0C, nBb2, $0C, nF3, $0C
	dc.b	nE3, $05, nRst, $0D, nC3, $05, nRst, $0D, nD3, $3B, nRst, $3D
	smpsLoop            $00, $02, Snd_SKCredits_Loop32
	smpsReturn

; Unreachable
	dc.b	nC2, $06, nRst, nC2, $0C, nBb1, $12, nA1, $06, nRst, $2A, nA1
	dc.b	$06, nF1, nRst, nF1, $0C, nFs1, $12, nG1, $06, nRst, $18, nD2
	dc.b	$0C, nG2, $06, nD2
	smpsReturn

; Unreachable
	dc.b	nC2, nRst, nC2, $0C, nBb1, $12, nA1, $06, nRst, $2A, nA1, $06
	dc.b	nF1, nRst, nF1, $0C, nFs1, $12, nG1, $06, nRst, $18, nD2
	smpsReturn

; FM3 Data
Snd_SKCredits_FM3:
	smpsModSet          $0C, $01, $01, $0F
	smpsSetvoice        $1F
	smpsAlterNote       $FE
	smpsSetVol          $5C
	dc.b	nRst, $30, nRst, $09
	smpsCall            Snd_SKCredits_Call05
	dc.b	nRst, $33
	smpsPan             panLeft, $00
	smpsSetNote         $40
	smpsSetVol          $75
	smpsSetvoice        $03
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panLeft, $00

Snd_SKCredits_Loop12:
	dc.b	nRst, $0C, nG4, $06, nG4, nG4, nG4, nRst, $0C, nG4, $06, nG4
	dc.b	nG4, nG4, nRst, $0C, nG4, $06, nG4, nRst, $60
	smpsLoop            $00, $02, Snd_SKCredits_Loop12

Snd_SKCredits_Loop13:
	dc.b	nRst, $0C, nE4, $06, nE4, nE4, nE4, nRst, $0C, nE4, $06, nE4
	dc.b	nE4, nE4, nRst, $0C, nE4, $06, nE4, nRst, $60, nRst, $0C, nFs4
	dc.b	$06, nFs4, nFs4, nFs4, nRst, $0C, nF4, $06, nF4, nF4, nF4, nRst
	dc.b	$0C, nF4, $06, nF4, nRst, $60
	smpsLoop            $00, $02, Snd_SKCredits_Loop13
	smpsSetvoice        $04
	dc.b	nRst, $06, nFs5, $12, nFs5, $06, nRst, nFs5, nRst, nAb5, nG5, nAb5
	dc.b	nC6, nRst, $18
	smpsSetvoice        $05
	dc.b	nRst, $06, nF4, $12, nF4, $06, nRst, $12, nF4, $06, nEb4, nE4
	dc.b	nF4, nRst
	smpsSetvoice        $06
	dc.b	nBb4, $0C, nC5, $06
	smpsSetvoice        $04
	dc.b	nRst, nFs5, $12, nFs5, $06, nRst, nFs5, nRst, nAb5, nG5, nAb5, nC6
	dc.b	nRst, $18
	smpsSetvoice        $05
	dc.b	nRst, $06, nF4, $12, nF4, $06, nRst, $12, nF4, $06, nEb4, nE4
	dc.b	nF4, nRst, nRst
	smpsSetvoice        $08
	smpsPan             panRight, $00
	smpsSetNote         $4C
	smpsSetVol          $7C
	dc.b	nRst, $02, nE4, $06, nF4, $06, nG4, $24, nC4, $36, nRst, $06
	dc.b	nG4, $18, nA4, $04, nRst, $08, nG4, $38, nRst, $10, nA4, $0C
	dc.b	nG4, $06, nRst, $06, nA4, $04, nRst, $08, nC5, $10, nRst, $02
	dc.b	nB4, $04, nRst, $0C, nA4, $06, nRst, $08, nB4, $10, nRst, $02
	dc.b	nC5, $04, nRst, $0E, nD5, $04, nRst, $08, nC5, $16, nRst, $02
	dc.b	nB4, $16, nRst, $02, nE5, $0C, nA4, $06, nE5, $04, nRst, $0E
	dc.b	nA4, $22, nRst, $02, nC5, $14, nRst, $04, nB4, $06, nRst, $06
	dc.b	nB4, $04, nRst, $02, nD5, $06, nRst, $06, nB4, $04, nRst, $02
	dc.b	nC5, $32, nRst, $0A, nE5, $0C, nA4, $04, nRst, $02, nE5, $06
	dc.b	nRst, $0C, nA4, $22, nRst, $02, nC5, $14, nRst, $04, nB4, $06
	dc.b	nRst, $06, nB4, $04, nRst, $02, nD5, $06, nRst, $06, nB4, $04
	dc.b	nRst, $02, nC5, $26, nRst, $14, $30
	smpsPan             panLeft, $00
	smpsSetNote         $40
	smpsSetVol          $74
	smpsModSet          $0D, $01, $02, $06

Snd_SKCredits_Loop14:
	smpsSetvoice        $16
	dc.b	nA4, $10, nRst, $08, nG4, $10, nRst, $08, nE4, $0F, nRst, $03
	dc.b	nC4, $0F, nRst, $03, nA3, $06, nRst, nRst, nC4, $12, nD4, $06
	dc.b	nRst, nE4, nRst, nD4, $12, nC4, $06, nRst, $18
	smpsSetvoice        $17
	dc.b	nE4, $30, nF4, nFs4, nF4
	smpsLoop            $00, $04, Snd_SKCredits_Loop14
	smpsPan             panLeft, $00
	smpsSetNote         $40
	smpsSetVol          $73
	smpsSetvoice        $19
	dc.b	nRst, $0C, nD6, $08, nRst, $04, nAb6, $0A, nRst, $0E, nAb6, $0C
	dc.b	nF6, $0A, nRst, $0E, nD6, $08, nRst, $04, nRst, $0C, nB5, $08
	dc.b	nRst, $10, nAb5, $08, nRst, $28, nB5, $06, nC6, nB5, $08, nRst
	dc.b	$1C, nAb5, $08, nRst, $1C, nF5, $08, nRst, $10, nRst, $0C, nE5
	dc.b	$08, nRst, $1C, nE5, $08, nRst, $28, nRst, $0C, nE5, nF5, nAb5
	dc.b	$08, nRst, $04, nAb5, nA5, nAb5, $10, nF5, $0C, nE5, $08, nRst
	dc.b	$04, nRst, $0C, nE5, nD5, nC5, nB4, $04, nC5, nB4, $10, nAb4
	dc.b	$0C, nE4, nRst, nE5, nF5, nAb5, $08, nRst, $04, nAb5, nA5, nAb5
	dc.b	$10, nF5, $0C, nE5, $08, nRst, $04, nA5, nB5, nA5, $10, nAb5
	dc.b	$0C, nA5, nB5, nD6, nRst, $18, nRst, $60, nRst, nRst, nRst, nRst
	dc.b	nRst, nRst, nRst, nRst, $60
	smpsPan             panCenter, $00
	smpsSetNote         $40
	smpsSetVol          $68
	smpsSetvoice        $12
	dc.b	nRst, $60, nRst, nF5, $12, nE5, nC5, $0C, nC6, $12, nB5, nG5
	dc.b	$0C, nF5, $12, nE5
	smpsFMAlterVol      $FF
	dc.b	nC5, $0C, nRst
	smpsFMAlterVol      $01
	dc.b	nB4, nRst, $18
	smpsSetvoice        $11

Snd_SKCredits_Loop15:
	dc.b	nC3, $06, nC2, nC3, nC2, nD3, nC2, nE3, nC2, nF3, nC2, nE3
	dc.b	nC2, nD3, nC2, nE3, nC2
	smpsLoop            $00, $12, Snd_SKCredits_Loop15
	dc.b	nC3, $06, nC2, nC3, nC2, nD3, nC2, nE3, nC2, nF3, nC2, nE3
	dc.b	nC2, nD3, nC2, nE3, nC2, nRst, $01
	smpsSetVol          $63
	smpsSetNote         $41
	smpsPan             panCenter, $00
	smpsSetvoice        $1E
	smpsAlterNote       $02
	smpsModSet          $15, $01, $06, $06
	dc.b	nRst, $03, nB4, $06, nE5, nCs5, nFs5
	smpsFMAlterVol      $FF
	dc.b	nD5, nAb5, nE5, nA5
	smpsFMAlterVol      $FF
	dc.b	nFs5, nB5, nAb5, nCs6
	smpsFMAlterVol      $FF
	dc.b	nA5, nD6, nB5, nE6, $03
	smpsSetvoice        $1C
	dc.b	nRst, $07, nA4, $18, nFs4, $0C, nE4, nA4, nFs4, nD4, nE4, smpsNoAttack
	dc.b	nE4, $24, nD5, $18
	smpsNoteFill        $06
	dc.b	$0C, $0C, $0C
	smpsNoteFill        $00
	dc.b	nCs5, $18, nA4, $0C, nE4, nFs4, $04, nRst, $08, nA4, $18, nB4
	dc.b	$0C, smpsNoAttack, nB4, $30, nRst, nA4, $18, nFs4, $0C, nE4, nA4, nFs4
	dc.b	nD4, nE4, smpsNoAttack, nE4, $24, nD5, $18
	smpsNoteFill        $06
	dc.b	$0C, $0C, $0C
	smpsNoteFill        $00
	smpsFMAlterVol      $FD
	dc.b	nD5, nCs5, $18, nA4, nB4, nRst, $0C, nE5, nD5, $18, nA4, nB4
	dc.b	$05, nRst, $05
	smpsFMAlterVol      $FE
	dc.b	nA4, $0C
	smpsStop

; FM4 Data
Snd_SKCredits_FM4:
	smpsPan             panRight, $00
	smpsAlterNote       $FD
	dc.b	nRst, $30
	smpsCall            Snd_SKCredits_Call00
	dc.b	nRst, $30
	smpsPan             panRight, $00
	smpsSetNote         $40
	smpsSetVol          $75
	smpsSetvoice        $03
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panRight, $00

Snd_SKCredits_Loop09:
	dc.b	nRst, $0C, nE4, $06, nE4, nE4, nE4, nRst, $0C, nE4, $06, nE4
	dc.b	nE4, nE4, nRst, $0C, nE4, $06, nE4, nRst, $60
	smpsLoop            $00, $02, Snd_SKCredits_Loop09

Snd_SKCredits_Loop0A:
	dc.b	nRst, $0C, nC4, $06, nC4, nC4, nC4, nRst, $0C, nC4, $06, nC4
	dc.b	nC4, nC4, nRst, $0C, nC4, $06, nC4, nRst, $60, nRst, $0C, nCs4
	dc.b	$06, nCs4, nCs4, nCs4, nRst, $0C, nD4, $06, nD4, nD4, nD4, nRst
	dc.b	$0C, nD4, $06, nD4, nRst, $60
	smpsLoop            $00, $02, Snd_SKCredits_Loop0A
	smpsSetvoice        $04
	dc.b	nRst, $06, nFs4, $12, nFs4, $06, nRst, nFs4, nRst, nAb4, nG4, nAb4
	dc.b	nC5, nRst, $18
	smpsSetvoice        $05
	dc.b	nRst, $06, nD4, $12, nD4, $06, nRst, $12, nD4, $06, nC4, nCs4
	dc.b	nD4, nRst
	smpsSetvoice        $06
	dc.b	nFs4, $0C, nAb4, $06
	smpsSetvoice        $04
	dc.b	nRst, nFs4, $12, nFs4, $06, nRst, nFs4, nRst, nAb4, nG4, nAb4, nC5
	dc.b	nRst, $18
	smpsSetvoice        $05
	dc.b	nRst, $06, nD4, $12, nD4, $06, nRst, $12, nD4, $06, nC4, nCs4
	dc.b	nD4, nRst, nRst, nRst, nRst
	smpsSetNote         $4C
	smpsSetVol          $6C
	smpsPan             panCenter, $00
	smpsSetvoice        $09
	dc.b	nF3, $04, nRst, $02, nF3, $04, nRst, $02, nF3, $04, nRst, $02
	dc.b	nF3, $04, nRst, $1A, nA3, $02, nB3, $02, nC4, $0E, nC4, $12
	dc.b	nE4, $06, nRst, $06, nG3, $04, nRst, $02, nG3, $04, nRst, $02
	dc.b	nG3, $04, nRst, $02, nG3, $04, nRst, $1C, nG3, $14, nRst, $02
	dc.b	nD4, $10, nRst, $14, nA3, $0C, nG3, $06, nRst, $06, nA3, $04
	dc.b	nRst, $08, nC4, $10, nRst, $02, nB3, $04, nRst, $0C, nA3, $06
	dc.b	nRst, $08, nB3, $10, nRst, $02, nC4, $04, nRst, $0E, nD4, $04
	dc.b	nRst, $08, nE4, $16, nRst, $02, nB3, $16, nRst, $02
	smpsSetvoice        $0A
	dc.b	nE3, $0C, nA2, $04, nRst, $02, nE3, $04, nRst, $0E, nA2, $24
	dc.b	nC3, $16, nRst, $02, nB2, $06, nRst, $06, nB2, $04, nRst, $02
	dc.b	nD3, $06, nRst, $0C, nC3, $36, nRst, $06, nE3, $0C, nA2, $04
	dc.b	nRst, $02, nE3, $04, nRst, $0E, nA2, $24, nC3, $16, nRst, $02
	dc.b	nB2, $06, nRst, $06, nB2, $04, nRst, $02, nD3, $06, nRst, $06
	dc.b	nB2, $04, nRst, $02, nC3, $3C, smpsNoAttack, $24, nRst, $0C
	smpsPan             panRight, $00
	smpsSetNote         $40
	smpsSetVol          $74
	smpsModSet          $0D, $01, $02, $06

Snd_SKCredits_Loop0B:
	smpsSetvoice        $16
	dc.b	nE4, $10, nRst, $08, nE4, $10, nRst, $08, nC4, $0F, nRst, $03
	dc.b	nA3, $0F, nRst, $03, nE3, $06, nRst, nRst, nA3, $12, nB3, $06
	dc.b	nRst, nC4, nRst, nB3, $12, nA3, $06, nRst, $18
	smpsSetvoice        $17
	dc.b	nC4, $30, nC4, nC4, nC4
	smpsLoop            $00, $04, Snd_SKCredits_Loop0B
	smpsPan             panRight, $00
	smpsSetNote         $40
	smpsSetVol          $73
	dc.b	nRst, $60, nRst, nRst, nRst
	smpsSetvoice        $18
	dc.b	nC5, $08, nRst, $10, nB4, $08, nRst, $40, nA4, $08, nRst, $10
	dc.b	nAb4, $08, nRst, $40, nC5, $08, nRst, $10, nB4, $08, nRst, $40
	dc.b	nF5, $08, nRst, $10, nD5, $08, nRst, $10, nAb5, $08, nRst, $04
	dc.b	nB5, $08, nRst, $10, nB5, $08, nRst, $04
	smpsSetVol          $70
	smpsSetvoice        $1A

Snd_SKCredits_Loop0C:
	dc.b	nAb2, $06, nBb2, nC3, nEb3
	smpsLoop            $00, $04, Snd_SKCredits_Loop0C

Snd_SKCredits_Loop0D:
	dc.b	nBb2, $06, nC3, nD3, nF3
	smpsLoop            $00, $04, Snd_SKCredits_Loop0D
	dc.b	nRst, $60, nRst, $06, nG4, $12, nF4, $06, nRst, nE4, nRst, nG4
	dc.b	nRst, nE4, nF4, $05, nRst, $07, nG4, $12

Snd_SKCredits_Loop0E:
	dc.b	nAb2, $06, nBb2, nC3, nEb3
	smpsLoop            $00, $04, Snd_SKCredits_Loop0E

Snd_SKCredits_Loop0F:
	dc.b	nBb2, $06, nC3, nD3, nF3
	smpsLoop            $00, $04, Snd_SKCredits_Loop0F
	dc.b	nRst, $60, nRst, $06, nG4, $12, nF4, $06, nRst, nE4, nRst, nG4
	dc.b	nE4, nRst, nA4, nRst, nG4, nRst, nRst, nRst, $60
	smpsAlterNote       $00
	smpsPan             panCenter, $00
	smpsSetNote         $40
	smpsSetVol          $6A
	smpsModSet          $24, $01, $04, $08
	smpsSetvoice        $12

Snd_SKCredits_Loop10:
	dc.b	nC5, $12, nB4, nG4, $0C, nG5, $12, nF5, nE5, $0C
	smpsLoop            $00, $03, Snd_SKCredits_Loop10
	dc.b	nC5, $12, nB4
	smpsFMAlterVol      $FF
	dc.b	nG4, $0C, nRst
	smpsFMAlterVol      $01
	dc.b	nG4, nRst, $18
	smpsFMAlterVol      $FD

Snd_SKCredits_Loop11:
	dc.b	nC6, $07, nRst, $05, nC6, $48, nC5, $06, nE5, nF5, $24, nE5
	dc.b	$18, nC5, $24
	smpsLoop            $00, $02, Snd_SKCredits_Loop11
	dc.b	nRst, $0C, nRst, nA4, nRst, nRst, nC5, nRst, nRst, nF4, nRst, nRst
	dc.b	nA4, $24, nA4, $18, nRst, $24, nAb4, $0C, nC5, nBb4, nAb4, nEb5
	dc.b	$18, nC5, $0C, nD5, nEb5, $18, nD5, $0C, nC5, $18
	smpsLoop            $01, $02, Snd_SKCredits_Loop11
	dc.b	nC6, $60, smpsNoAttack, $60, smpsNoAttack, $60
	smpsSetVol          $6D
	smpsSetNote         $4D
	smpsSetvoice        $22
	smpsPan             panRight, $00
	smpsModSet          $01, $01, $0C, $00
	dc.b	nG2, $60
	smpsSetvoice        $23
	smpsModSet          $00, $00, $00, $00
	dc.b	nA3, nB3, $24, nA3, $30, smpsNoAttack, $0C, nA3, $60, nG3, $0C, $18
	dc.b	nB3, $30, smpsNoAttack, $0C, nA3, $60, nB3, $24, nA3, $30, smpsNoAttack, $0C
	smpsSetvoice        $24
	dc.b	nA4, $24, nA4, $30, nRst, $0C
	smpsFMAlterVol      $FF
	dc.b	nB4, $24, nB4, $30
	smpsFMAlterVol      $FF
	dc.b	nCs5, $0C
	smpsStop

Snd_SKCredits_Call00:
	smpsSetvoice        $1F
	smpsModSet          $0C, $02, $01, $10
	smpsSetNote         $40
	smpsSetVol          $68
	dc.b	nD4, $30, smpsNoAttack, $0C, nD4, nRst, nC4, smpsNoAttack, $30, smpsNoAttack, $0C
	smpsModSet          $1C, $01, $FE, $01
	dc.b	nG3, $30
	smpsModSet          $0C, $02, $01, $10
	dc.b	nRst, $0C, nD4, $18, nD4, $0C, nD4, nRst, nC4, nRst, nG4, nC4
	dc.b	nRst, nC4, nB3, nRst, nBb3, nRst, nF4, $24, nD4, $0C, nCs4, nRst
	dc.b	nC4, smpsNoAttack, $30, nC4, $0C, nEb4, nF4, nE4, smpsNoAttack, nE4, $54, nG4
	dc.b	$3C
	smpsReturn

; Unreachable
Snd_SKCredits_Loop33:
	dc.b	nRst, $0C, nD3, $02, nRst, $0A, nE3, $02, nRst, $16, nD3, $11
	dc.b	nRst, $01, nE3, $02, nRst, $28, nA4, $05, nRst, $01, nBb4, $05
	dc.b	nRst, $07, nBb4, $02, nRst, $04, nBb4, $02, nRst, $04, nBb4, $02
	dc.b	nRst, $04, nBb4, $02, nRst, $0A, nA4, $23, nRst, $01, nRst, $0C
	dc.b	nD3, $02, nRst, $0A, nE3, $02, nRst, $16, nD3, $11, nRst, $01
	dc.b	nE3, $02, nRst, $28, nA4, $05, nRst, $01, nBb4, $05, nRst, $07
	dc.b	nBb4, $02, nRst, $04, nBb4, $02, nRst, $04, nBb4, $02, nRst, $04
	dc.b	nBb4, $02, nRst, $0A, nC5, $05, nRst, $01, nBb4, $1D, nRst, $01
	smpsLoop            $00, $02, Snd_SKCredits_Loop33
	smpsReturn

; Unreachable
	smpsStop

; FM5 Data
Snd_SKCredits_FM5:
	smpsAlterNote       $03
	smpsPan             panLeft, $00
	dc.b	nRst, $30
	smpsCall            Snd_SKCredits_Call00
	dc.b	nRst, $30, nRst, $0E
	smpsSetNote         $40
	smpsSetVol          $6C
	smpsSetvoice        $00
	smpsModSet          $0D, $01, $02, $06
	smpsPan             panCenter, $00
	dc.b	nRst, $60, nRst, nRst
	smpsSetvoice        $00
	dc.b	nB5, $04, nBb5, nG5, nA5, nFs5, nAb5, nF5, nG5, nE5, nFs5, nEb5
	dc.b	nF5, nD5, nE5, nCs5, nEb5, nC5, nD5, nB4, nCs5, nBb4, nC5, nA4
	dc.b	nB4
	smpsSetvoice        $02
	dc.b	nB4, $01, nC5, $3B, nD5, $06, nRst, nF5, nRst, nG5, nRst, nE5
	dc.b	$01, nF5, $06, nRst, $05, nCs5, $06, nRst, nC5, nBb4, nRst, nG4
	dc.b	$36, nRst, $0C, nBb4, $18, nC5, $06, nBb4, $05, nC5, $01, nCs5
	dc.b	$06, nRst, nC5, nRst, nEb5, nD5, nRst, nBb4, nRst, $60, nB4, $01
	dc.b	nC5, $3B, nD5, $06, nRst, nF5, nRst, nG5, nRst, nE5, $01, nF5
	dc.b	$06, nRst, $05, nCs5, $06, nRst, nC5, nBb4, nRst, nG4, $36, nRst
	dc.b	$0C, nBb4, $18, nC5, $06, nBb4, $05, nC5, $01, nCs5, $06, nRst
	dc.b	nC5, nRst, nEb5, nD5, nRst, nBb4, nRst, $60, nRst, $0C, nBb4, $18
	dc.b	nC5, $06, nBb4, nCs5, nRst, nC5, nRst, nBb4, nC5, nRst, nBb4, nRst
	dc.b	$60, nRst, $0C, nBb4, $18, nC5, $06, nBb4, $05, nCs5, $01, nD5
	dc.b	nEb5, $06, nRst, $05, nD5, $06, nRst, nC5, nD5, nRst, nBb4, nRst
	dc.b	$52
	smpsSetNote         $4C
	smpsSetVol          $6C
	smpsSetvoice        $09
	dc.b	nC4, $04, nRst, $02, nC4, $04, nRst, $02, nC4, $04, nRst, $02
	dc.b	nC4, $04, nRst, $1A, nF4, $02, nG4, $02, nA4, $0E, nA4, $12
	dc.b	nC5, $06, nB4, $02, nA4, $02, nG4, $02, nD4, $04, nRst, $02
	dc.b	nD4, $04, nRst, $02, nD4, $04, nRst, $02, nD4, $04, nRst, $1A
	dc.b	nEb4, $02, nE4, $14, nRst, $02, nB4, $10, nB4, $02, nA4, $02
	dc.b	nG4, $02, nF4, $02, nRst, $0C, nC4, $0C, nC4, $06, nRst, $06
	dc.b	nC4, $04, nRst, $08, nE4, $10, nRst, $02, nE4, $04, nRst, $0C
	dc.b	nE4, $06, nRst, $08, nF4, $10, nRst, $02, nF4, $04, nRst, $0E
	dc.b	nF4, $04, nRst, $08, nG4, $16, nRst, $02, nD4, $16, nRst, $02
	smpsSetvoice        $0A
	dc.b	nC4, $0C, nF3, $04, nRst, $02, nC4, $04, nRst, $0E, nF3, $24
	dc.b	nA3, $16, nRst, $02, nG3, $06, nRst, $06, nG3, $04, nRst, $02
	dc.b	nB3, $06, nRst, $0C, nA3, $36, nRst, $06, nC4, $0C, nF3, $04
	dc.b	nRst, $02, nC4, $04, nRst, $0E, nF3, $24, nA3, $16, nRst, $02
	dc.b	nG3, $06, nRst, $06, nG3, $04, nRst, $02, nB3, $06, nRst, $06
	dc.b	nG3, $04, nRst, $02, nA3, $3C, smpsNoAttack, $24, nRst, $0C
	smpsPan             panCenter, $00
	smpsSetNote         $40
	smpsSetVol          $6F
	smpsModSet          $0D, $01, $02, $06
	dc.b	nRst, $10
	smpsCall            Snd_SKCredits_Call01
	smpsCall            Snd_SKCredits_Call01
	smpsCall            Snd_SKCredits_Call02
	dc.b	nRst, $10
	smpsCall            Snd_SKCredits_Call02
	smpsSetNote         $40
	smpsSetVol          $6B
	dc.b	nRst, $10
	smpsSetvoice        $18
	smpsCall            Snd_SKCredits_Call03
	dc.b	nRst, $08
	smpsSetVol          $69
	smpsSetvoice        $1A
	dc.b	nRst, $10
	smpsCall            Snd_SKCredits_Call04
	dc.b	nRst, $60
	smpsPan             panCenter, $00
	smpsSetNote         $40
	smpsSetVol          $60
	smpsModSet          $24, $01, $04, $08
	smpsAlterNote       $02
	smpsSetvoice        $12
	dc.b	nRst, $0E

Snd_SKCredits_Loop07:
	dc.b	nC5, $12, nB4, nG4, $0C, nG5, $12, nF5, nE5, $0C
	smpsLoop            $00, $03, Snd_SKCredits_Loop07
	dc.b	nC5, $12, nB4
	smpsFMAlterVol      $FF
	dc.b	nG4, $0C, nRst
	smpsFMAlterVol      $01
	dc.b	nG4, nRst, $18
	smpsFMAlterVol      $FD

Snd_SKCredits_Loop08:
	dc.b	nC6, $07, nRst, $05, nC6, $48, nC5, $06, nE5, nF5, $24, nE5
	dc.b	$18, nC5, $24
	smpsLoop            $00, $02, Snd_SKCredits_Loop08
	dc.b	nRst, $0C, nRst, nA4, nRst, nRst, nC5, nRst, nRst, nF4, nRst, nRst
	dc.b	nA4, $24, nA4, $18, nRst, $24, nAb4, $0C, nC5, nBb4, nAb4, nEb5
	dc.b	$18, nC5, $0C, nD5, nEb5, $18, nD5, $0C, nC5, $18
	smpsLoop            $01, $02, Snd_SKCredits_Loop08
	dc.b	nC6, $60, smpsNoAttack, nC6, $52, smpsNoAttack, $60
	smpsSetVol          $6D
	smpsSetNote         $4D
	smpsSetvoice        $22
	smpsPan             panLeft, $00
	smpsModSet          $01, $01, $0C, $00
	dc.b	nG2, $60
	smpsSetvoice        $23
	smpsModSet          $00, $00, $00, $00
	dc.b	nE3, nE3, $24, nD3, $30, smpsNoAttack, $0C, nE3, $60, nD3, $0C, $18
	dc.b	nE3, $30, smpsNoAttack, $0C, nE3, $60, nE3, $24, nD3, $30, smpsNoAttack, $0C
	smpsSetvoice        $24
	dc.b	nE4, $24, nD4, $30, nRst, $0C
	smpsFMAlterVol      $FF
	dc.b	nG4, $24, nE4, $30
	smpsFMAlterVol      $FF
	dc.b	nE4, $0C
	smpsStop

; PSG1 Data
Snd_SKCredits_PSG1:
	smpsSetNote         $40
	smpsSetVol          $4F
	dc.b	nRst, $30
	smpsPSGvoice        sTone_0A

Snd_SKCredits_Loop27:
	dc.b	nA5, $0C, nD5
	smpsLoop            $00, $04, Snd_SKCredits_Loop27

Snd_SKCredits_Loop28:
	dc.b	nB5, nE5
	smpsLoop            $00, $04, Snd_SKCredits_Loop28
	smpsLoop            $01, $02, Snd_SKCredits_Loop27

Snd_SKCredits_Loop29:
	dc.b	nBb5, nF5
	smpsLoop            $00, $04, Snd_SKCredits_Loop29

Snd_SKCredits_Loop2A:
	dc.b	nAb5, nC5
	smpsLoop            $00, $04, Snd_SKCredits_Loop2A

Snd_SKCredits_Loop2B:
	dc.b	nC6, nE5
	smpsLoop            $00, $04, Snd_SKCredits_Loop2B
	dc.b	nC6, nE5, nC6, nE5, nRst, $30, nRst, $60, nRst, nRst, nRst, nRst
	dc.b	nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	smpsSetNote         $34
	smpsSetVol          $5F
	dc.b	nRst, $01
	smpsPSGvoice        sTone_04
	smpsAlterNote       $FF
	smpsCall            Snd_SKCredits_Call06
	dc.b	nA3, nA3, nA3, nA3, $12, nC4, $06, nC4, nC4, nC4, $12, nD4
	dc.b	$06, nD4, nC4, $0C, nB3, nB3, $06, nB3, $0C, nB3, $06, nC4
	dc.b	$18, nC4, $06, nC4, nC4, nC4, nB3, $0C, nA3, $06, nA3, nA3
	dc.b	nA3, nA3, $0C, nC4, $06, nC4, nC4, nC4, $12, nD4, $06, nC4
	dc.b	nB3, $0C, nG3, $12, nG3, nA3, $3B, smpsNoAttack, $24, nRst, $0C, nRst
	dc.b	$60, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b	nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b	nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, $60
	smpsSetNote         $34
	smpsSetVol          $57
	smpsPSGvoice        sTone_04

Snd_SKCredits_Loop2C:
	dc.b	nG4, $06, nF4, nC4, nF4
	smpsLoop            $00, $0E, Snd_SKCredits_Loop2C
	dc.b	nRst, $0C, nB3, nRst, $18

Snd_SKCredits_Loop2D:
	dc.b	nC5, $06, nC4, nC5, nC4, nC5, nC4, nC5, nC4, nC6, nC4, nC6
	dc.b	nC4, nC5, nC4, nC5, nC4
	smpsLoop            $00, $12, Snd_SKCredits_Loop2D
	smpsSetVol          $17
	smpsSetNote         $41
	smpsPSGvoice        sTone_0C
	dc.b	nA1, $06, nCs2, nB1, nD2
	smpsPSGAlterVol     $FF
	dc.b	nCs2, nE2, nD2, nFs2
	smpsPSGAlterVol     $FF
	dc.b	nE2, nAb2, nFs2, nA2
	smpsPSGAlterVol     $FF
	dc.b	nAb2, nB2, nA2, nCs3
	smpsPSGAlterVol     $FF
	dc.b	nA2, $06, nCs3, nB2, nD3
	smpsPSGAlterVol     $FF
	dc.b	nCs3, nE3, nD3, nFs3
	smpsPSGAlterVol     $FF
	dc.b	nE3, nAb3, nFs3, nA3
	smpsPSGAlterVol     $FF
	dc.b	nAb3, nB3, nA3, nCs4
	smpsPSGAlterVol     $FD
	smpsPSGvoice        sTone_0A
	dc.b	nE4, $0C, nB3, nE4, nB3, nE4, nB3, nE4, nB3, nD4, nB3, nE4
	dc.b	nB3, nE4, nB3, nE4, nB3, nE4, $0C, nB3, nE4, nB3, nE4, nB3
	dc.b	nE4, nB3, nD4, nB3, nD4, nB3, nD5, nB4, nD5, nB4, nE4, $0C
	dc.b	nB3, nE4, nB3, nE4, nB3, nE4, nB3, nD4, nB3, nD4, nB3, nD4
	dc.b	nB3, nD4, nB3, nE4, $0C, nB3, nE4, nB3, nD4, nB3, nD4, nB3
	dc.b	nD4, nA3, nD4, nA3, nE4, nB3, nE4
	smpsPSGAlterVol     $01

Snd_SKCredits_Loop2E:
	dc.b	nA4
	smpsPSGAlterVol     $01
	dc.b	nG5
	smpsPSGAlterVol     $01
	smpsLoop            $00, $05, Snd_SKCredits_Loop2E
	smpsStop

Snd_SKCredits_Call06:
	dc.b	nF3, $0C, nF3, nF3, nC3, $06, nF3, $0C, nF3, nC3, $06, nF3
	dc.b	$0C, nC3, nG3, nG3, nG3, nD3, $06, nG3, $0C, nG3, nD3, $06
	dc.b	nG3, $0C, nD3, nD3, $06, nF3, nA3, nG3, nF3, nE3, nG3, nB3
	dc.b	nD4, nC4, nB3, nA3, nA3, nC4, nE4, nD4, nC4, nB3, nB3, nD4
	dc.b	nF4, nE4, nD4, nC4, nG4, nF4, nE4, nD4, nE4, nD4, nC4, nG3
	smpsReturn

; Unreachable
	smpsStop

; PSG2 Data
Snd_SKCredits_PSG2:
	smpsSetNote         $40
	smpsSetVol          $4F
	smpsPSGvoice        sTone_0A
	dc.b	nRst, $30, nRst, $06

Snd_SKCredits_Loop21:
	dc.b	nFs5, $0C, nFs5
	smpsLoop            $00, $04, Snd_SKCredits_Loop21

Snd_SKCredits_Loop22:
	dc.b	nG5, nC5
	smpsLoop            $00, $04, Snd_SKCredits_Loop22
	smpsLoop            $01, $02, Snd_SKCredits_Loop21

Snd_SKCredits_Loop23:
	dc.b	nA5, nD5
	smpsLoop            $00, $04, Snd_SKCredits_Loop23

Snd_SKCredits_Loop24:
	dc.b	nEb5, nEb5
	smpsLoop            $00, $04, Snd_SKCredits_Loop24

Snd_SKCredits_Loop25:
	dc.b	nG5, nG5
	smpsLoop            $00, $04, Snd_SKCredits_Loop25
	dc.b	nG5, nG5, nG5, nC5, nRst, $2A, nRst, $60, nRst, nRst, nRst, nRst
	dc.b	nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	smpsSetNote         $34
	smpsSetVol          $5F
	smpsPSGvoice        sTone_04
	smpsAlterNote       $00
	smpsCall            Snd_SKCredits_Call06
	dc.b	nC4, $0C, nC4, $06, nC5, $0C, nC4, $06, nE4, nE5, $0C, nE4
	dc.b	$06, nE4, nE5, nD5, nD5, nC5, $0C, nB3, nB3, $06, nB4, $0C
	dc.b	nB3, $06, nE4, nE5, $0C, nE4, $06, nE4, nE4, $1E, nC4, $0C
	dc.b	nC4, $06, nC5, $0C, nC4, $06, nE4, nE5, $0C, nE4, $06, nE4
	dc.b	nE5, nD5, nC5, nA4, $0C, nB3, nB3, $06, nB4, $0C, nB3, $06
	dc.b	nE4, nE5, $0C, nE4, $06, nE4, nE4, $1E, smpsNoAttack, $24, nRst, $0C
	dc.b	nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b	nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b	nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, $60, nRst
	dc.b	$60, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b	nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, $60, nRst
	smpsSetVol          $17
	smpsSetNote         $41
	smpsPSGvoice        sTone_0C
	dc.b	nRst, $03, nB1, $06, nE2, nCs2, nFs2
	smpsPSGAlterVol     $FF
	dc.b	nD2, nAb2, nE2, nA2
	smpsPSGAlterVol     $FF
	dc.b	nFs2, nB2, nAb2, nCs3
	smpsPSGAlterVol     $FF
	dc.b	nA2, nD3, nB2, nE3
	smpsPSGAlterVol     $FF
	dc.b	nB2, $06, nE3, nCs3, nFs3
	smpsPSGAlterVol     $FF
	dc.b	nD3, nAb3, nE3, nA3
	smpsPSGAlterVol     $FF
	dc.b	nFs3, nB3, nAb3, nCs4
	smpsPSGAlterVol     $FF
	dc.b	nA3, nD4, nB3, nE4, $03
	smpsPSGAlterVol     $FD
	smpsPSGvoice        sTone_0A
	dc.b	nRst, $06, nCs4, $0C, nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b	nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4, $0C, nA3, nCs4, nA3
	dc.b	nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs5, nA4, nCs5, nA4
	dc.b	nCs4, $0C, nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b	nA3, nCs4, nA3, nCs4, nA3, nCs4, $0C, nA3, nCs4, nA3, nCs4, nA3
	dc.b	nCs4, nA3, nB3, nG3, nB3, nG3, nCs4, nA3, nCs4
	smpsPSGAlterVol     $01

Snd_SKCredits_Loop26:
	dc.b	nE5
	smpsPSGAlterVol     $01
	dc.b	nA5
	smpsPSGAlterVol     $01
	smpsLoop            $00, $05, Snd_SKCredits_Loop26
	smpsStop

; PSG3 Data
Snd_SKCredits_PSG3:
	smpsPSGform         $E7
	smpsSetVol          $67
	dc.b	nRst, $30

Snd_SKCredits_Loop1D:
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $0C, $0C
	smpsPSGvoice        sTone_04
	dc.b	$0C
	smpsPSGvoice        sTone_01
	dc.b	$06
	smpsPSGvoice        sTone_04
	dc.b	$06
	smpsPSGvoice        sTone_01
	dc.b	$0C, $0C
	smpsPSGvoice        sTone_04
	dc.b	$18
	smpsLoop            $00, $02, Snd_SKCredits_Loop1D
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $0C, $0C
	smpsPSGvoice        sTone_04
	dc.b	$0C
	smpsPSGvoice        sTone_01
	dc.b	$06
	smpsPSGvoice        sTone_04
	dc.b	$06
	smpsPSGvoice        sTone_01
	dc.b	$0C, $0C
	smpsPSGvoice        sTone_04
	dc.b	$0C
	smpsPSGvoice        sTone_01
	dc.b	$0C, nMaxPSG1, $0C, $0C
	smpsPSGvoice        sTone_04
	dc.b	$0C
	smpsPSGvoice        sTone_01
	dc.b	$06
	smpsPSGvoice        sTone_04
	dc.b	$06
	smpsPSGvoice        sTone_01
	dc.b	$0C, $0C, $0C, $0C

Snd_SKCredits_Loop1E:
	smpsPSGvoice        sTone_01
	dc.b	$0C, $0C, $0C, $0C, $0C, $0C, $0C
	smpsPSGvoice        sTone_04
	dc.b	$0C
	smpsLoop            $00, $03, Snd_SKCredits_Loop1E
	dc.b	nRst, $60, nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b	nRst, nRst, nRst, nRst, nRst, nRst, nRst
	smpsSetNote         $34
	smpsSetVol          $77
	dc.b	nRst, $3C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $12
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $48
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $12
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $60, $60, $48
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $12
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $5A
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $5A
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nRst, $6C, nRst, $30, nRst, $60, nRst, nRst, nRst, nRst
	dc.b	nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b	nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b	nRst, nRst, nRst, nRst, $60
	smpsSetNote         $40
	smpsSetVol          $68

Snd_SKCredits_Loop1F:
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsPSGvoice        sTone_04
	dc.b	nMaxPSG2, $0C
	smpsLoop            $00, $50, Snd_SKCredits_Loop1F

Snd_SKCredits_Loop20:
	smpsPSGvoice        sTone_04
	dc.b	nMaxPSG2, $0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG2, $06, nMaxPSG2
	smpsLoop            $00, $08, Snd_SKCredits_Loop20
	smpsStop

; Unreachable
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, $06
	smpsPSGvoice        sTone_08
	dc.b	$0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, $06
	smpsPSGvoice        sTone_08
	dc.b	$0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, $06, $06, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, $06
	smpsPSGvoice        sTone_08
	dc.b	$0C
	smpsReturn

; Unreachable
Snd_SKCredits_Loop34:
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, $06, $06, $06
	smpsLoop            $02, $03, Snd_SKCredits_Loop34
	smpsReturn

; DAC Data
Snd_SKCredits_DAC:
	smpsFade            $00
	dc.b	nRst, $02, dElectricHighTom, $04, $04, $04, dElectricMidTom, $05, dElectricMidTom, $06, dElectricLowTom, nRst
	dc.b	nRst, nRst, $05, dCrashCymbal, $12, dKickS3, dKickS3, $18, $06, $06, dSnareS3, $0C
	dc.b	dCrashCymbal, nRst, dKickS3, nRst, $06, dKickS3, nRst, $0C, dKickS3, $18, dSnareS3, dCrashCymbal
	dc.b	$12, dKickS3, dKickS3, $18, $06, $06, dSnareS3, $0C, dCrashCymbal, nRst, dKickS3, nRst
	dc.b	$06, dKickS3, nRst, $0C, dSnareS3, $06, dSnareS3, dSnareS3, nRst, dSnareS3, nRst, dSnareS3
	dc.b	dSnareS3, dKickS3, $18, dSnareS3, dKickS3, $0C, dKickS3, dSnareS3, dKickS3, nRst, dKickS3, dSnareS3
	dc.b	nRst, dKickS3, dKickS3, dSnareS3, dKickS3, nRst, dKickS3, dSnareS3, nRst, dKickS3, dKickS3, dSnareS3
	dc.b	dKickS3, dSnareS3, $06, dSnareS3, nRst, dSnareS3, nRst, dSnareS3, dSnareS3, nRst, dSnareS3, $0C
	dc.b	dElectricHighTom, $06, dElectricMidTom, dElectricLowTom, nRst, nRst, nRst
	smpsSetTempoMod     $1F
	dc.b	dKickS3, $18, dKickS3, dKickS3, dKickS3, $0C, dSnareS3, $06, dKickS3, dSnareS3, dKickS3, $0C
	dc.b	dKickS3, $12, dSnareS3, $06, dKickS3, $0C, dKickS3, dKickS3, $06, dSnareS3, $0C, dKickS3
	dc.b	dKickS3, $18, dKickS3, dKickS3, dKickS3, $0C, dSnareS3, $06, dKickS3, dSnareS3, dKickS3, $0C
	dc.b	dKickS3, $12, dSnareS3, $06, dKickS3, dSnareS3, $0C, dSnareS3, dSnareS3, $06, dSnareS3, dSnareS3
	dc.b	$0C

Snd_SKCredits_Loop00:
	dc.b	dKickS3, $0C, dSnareS3, dSnareS3, dKickS3, dKickS3, dKickS3, dSnareS3, $18, dSnareS3, $06, dKickS3
	dc.b	$0C, dKickS3, $12, dSnareS3, $06, dKickS3, $0C, dKickS3, dKickS3, $06, dSnareS3, $0C
	dc.b	dKickS3
	smpsLoop            $00, $03, Snd_SKCredits_Loop00
	dc.b	dKickS3, $0C, dSnareS3, dSnareS3, dKickS3, dKickS3, dKickS3, dSnareS3, $18, dSnareS3, $06, dKickS3
	dc.b	$0C, dKickS3, $12, dSnareS3, $06, dKickS3, $0C, dKickS3, dKickS3, $06, dSnareS3, dSnareS3
	dc.b	dSnareS3, dSnareS3, dKickS3, $0C, dSnareS3, dKickS3, dSnareS3, dKickS3, dSnareS3, dSnareS3, dSnareS3, dKickS3
	dc.b	$06, dSnareS3, $12, dSnareS3, $18, dSnareS3, $06, dKickS3, dKickS3, dSnareS3, $0C, dSnareS3
	dc.b	dSnareS3, $06, dKickS3, $0C, dSnareS3, dKickS3, dSnareS3, dKickS3, dSnareS3, dSnareS3, dSnareS3, dKickS3
	dc.b	$06, dSnareS3, $12, dSnareS3, $18, dElectricHighTom, $02, dElectricMidTom, $04, dElectricLowTom, $06, dSnareS3
	dc.b	dSnareS3, dSnareS3, nRst, nRst, nRst

Snd_SKCredits_Loop01:
	dc.b	dKickS3, $06, dKickS3, dKickS3, dKickS3, dSnareS3, $24, dElectricFloorTom, $06, dElectricFloorTom, dSnareS3, $06
	dc.b	dKickS3, $06, dMidpitchSnare, $0C
	smpsLoop            $01, $02, Snd_SKCredits_Loop01
	dc.b	dKickS3, $0C, $06, $06, dSnareS3, $0C, dKickS3, $0C, $06, dKickS3, $12, dSnareS3
	dc.b	$0C, dKickS3, $06, $12, $0C, dSnareS3, $06, dKickS3, $12, $12, dSnareS3, $06
	dc.b	$06, $06, $0C, dKickS3, $0C, $06, $06, dSnareS3, $0C, dKickS3, $06, $12
	dc.b	dElectricFloorTom, $06, dElectricFloorTom, dSnareS3, dKickS3, dMidpitchSnare, $0C, dKickS3, $0C, $06, dSnareS3, dKickS3
	dc.b	dKickS3, dSnareS3, $18, dKickS3, $06, dKickS3, dSnareS3, dElectricFloorTom, dMidpitchSnare, $0C, dKickS3, $0C
	dc.b	$06, $06, dSnareS3, $0C, dKickS3, $06, $12, dElectricFloorTom, $06, dElectricFloorTom, dSnareS3, dKickS3
	dc.b	dMidpitchSnare, $0C, dMidTomS3, $06, dLowTomS3, $03, $03, dFloorTomS3, $06, dMidTomS3, dLowTomS3, $03
	dc.b	$03, dFloorTomS3, $06, dCrashCymbal, $0C, nRst, $30, nRst, $06
	smpsSetTempoMod     $08
	dc.b	dKickS3, dKickS3, nRst, dSnareS3, nRst, dSnareS3, dSnareS3

Snd_SKCredits_Loop02:
	dc.b	dKickS3, $18, dSnareS3, $06, dKickS3, dKickS3, dKickS3, dKickS3, $0C, dKickS3, dSnareS3, $18
	dc.b	dKickS3, dSnareS3, $06, dKickS3, dKickS3, dKickS3, dKickS3, $0C, dKickS3, dSnareS3, $18, dKickS3
	dc.b	dSnareS3, $06, dKickS3, dKickS3, dKickS3, dKickS3, $0C, dKickS3, dSnareS3, $18, dSnareS3, $06
	dc.b	dSnareS3, dKickS3, $0C, dKickS3, dSnareS3, $06, dSnareS3, dKickS3, $0C, dKickS3, dSnareS3, $06
	dc.b	dSnareS3, dSnareS3, $0C
	smpsLoop            $00, $03, Snd_SKCredits_Loop02
	dc.b	dKickS3, $18, dSnareS3, $06, dKickS3, dKickS3, dKickS3, dKickS3, $0C, dKickS3, dSnareS3, $18
	dc.b	dKickS3, dSnareS3, $06, dKickS3, dKickS3, dKickS3, dKickS3, $0C, dKickS3, dSnareS3, $18, dKickS3
	dc.b	dSnareS3, $06, dKickS3, dKickS3, dKickS3, dKickS3, $0C, dKickS3, dSnareS3, $18, dSnareS3, $06
	dc.b	dSnareS3, dElectricHighTom, $0C, dElectricLowTom, dSnareS3, $06, dSnareS3, dElectricHighTom, $0C, dElectricLowTom, dSnareS3, $02
	dc.b	$04, $06, $06, $06
	smpsSetTempoMod     $10

Snd_SKCredits_Loop03:
	dc.b	dKickS3, $18, dSnareS3, $0C, dKickS3, dKickS3, dKickS3, dSnareS3, $18
	smpsLoop            $00, $03, Snd_SKCredits_Loop03
	dc.b	dKickS3, $18, dSnareS3, $0C, dKickS3, dKickS3, dKickS3, dSnareS3, dSnareS3, $06, dSnareS3

Snd_SKCredits_Loop04:
	dc.b	dKickS3, $18, dSnareS3, $0C, dKickS3, dKickS3, dKickS3, dSnareS3, $18
	smpsLoop            $00, $03, Snd_SKCredits_Loop04
	dc.b	dKickS3, $18, dSnareS3, $0C, dKickS3, dKickS3, dSnareS3, $06, dSnareS3, dSnareS3, dSnareS3, dSnareS3
	dc.b	dSnareS3
	smpsSetTempoMod     $08

Snd_SKCredits_Loop05:
	dc.b	dKickS3, $18, dSnareS3, dKickS3, dSnareS3
	smpsLoop            $00, $07, Snd_SKCredits_Loop05
	dc.b	dCrashCymbal, $30, dElectricFloorTom, $04, $04, $04, $06, $06, dTightSnare, dTightSnare, dMidpitchSnare, $0C
	dc.b	dKickS3, $06, nRst, nRst, nRst, dSnareS3, nRst, nRst, dSnareS3, nRst, dKickS3, dKickS3
	dc.b	nRst, dSnareS3, dSnareS3, nRst, nRst
	smpsSetTempoMod     $0C
	smpsPan             panCenter, $00
	dc.b	dCrashCymbal, $60, nRst, nRst, nRst, $17, nRst, $0C, dSnareS3, nRst, dSnareS3, nRst
	dc.b	dKickS3, $06, dKickS3

Snd_SKCredits_Loop06:
	smpsPan             panCenter, $00
	dc.b	dKickS3, $05, dKickS3, dKickS3, $0E, nRst, $0C, dMuffledSnare, $05, dMuffledSnare, dMuffledSnare, $0E
	dc.b	dMuffledSnare, $0C, nRst, dKickS3, $06, dKickS3, dKickS3, $0C, dKickS3, nRst, dMuffledSnare, $05
	dc.b	dMuffledSnare, dMuffledSnare, $0E, dMuffledSnare, $0C, nRst, dKickS3, dKickS3, $0C, dKickS3, nRst, dMuffledSnare
	dc.b	$05, dMuffledSnare, dMuffledSnare, $0E, dMuffledSnare, $0C, nRst, dKickS3, $06, dKickS3, dKickS3, $0C
	dc.b	dKickS3, nRst, dMuffledSnare, $05, dMuffledSnare, dMuffledSnare, $08
	smpsPan             panLeft, $00
	dc.b	dElectricMidTom, $06, dElectricMidTom, dElectricMidTom
	smpsPan             panCenter, $00
	dc.b	dElectricLowTom, dElectricLowTom
	smpsPan             panRight, $00
	dc.b	dElectricFloorTom, nRst
	smpsLoop            $00, $04, Snd_SKCredits_Loop06
	smpsPan             panCenter, $00
	dc.b	dKickS3, $05, dKickS3, dKickS3, $0E, nRst, $0C, dMuffledSnare, $05, dMuffledSnare, dMuffledSnare, $0E
	dc.b	dMuffledSnare, $0C, nRst, dKickS3, $06, dKickS3, dKickS3, $0C, dKickS3, nRst, dMuffledSnare, $05
	dc.b	dMuffledSnare, dMuffledSnare, $0E, dMuffledSnare, $0C, nRst, dKickS3, dKickS3, $0C, dKickS3, nRst, dMuffledSnare
	dc.b	$05, dMuffledSnare, dMuffledSnare, $0E, dKickS3, $06, dKickS3, dMuffledSnare, dMuffledSnare, dMuffledSnare, dMuffledSnare, nRst
	dc.b	$01, dCrashCymbal, $30, nRst, $0C, dSnareS3, dSnareS3, dSnareS3, $06, $06, dCrashCymbal, $18
	dc.b	dSnareS3, $0C, dKickS3, dKickS3, $06, dKickS3, dKickS3, $0C, dSnareS3, $18, dKickS3, $18
	dc.b	dSnareS3, $0C, dKickS3, dKickS3, $06, dKickS3, dKickS3, $0C, dSnareS3, $18, dKickS3, $18
	dc.b	dSnareS3, $0C, dKickS3, dKickS3, $06, dKickS3, dKickS3, $0C, dSnareS3, $18, dKickS3, $18
	dc.b	dSnareS3, $0C, dKickS3, dKickS3, $06, dKickS3, dKickS3, $0C, dSnareS3, $06, $06, nRst
	dc.b	nRst, dCrashCymbal, $18, dSnareS3, $0C, dKickS3, dKickS3, $06, dKickS3, dKickS3, $0C, dSnareS3
	dc.b	$18, dKickS3, $18, dSnareS3, $0C, dKickS3, dKickS3, $06, dKickS3, dKickS3, $0C, dSnareS3
	dc.b	$06, $06, nRst, nRst, dKickS3, $18, dSnareS3, dKickS3, $06, dKickS3, dKickS3, $0C
	dc.b	dSnareS3, $18, dKickS3, $18, dSnareS3, $12, dKickS3, $06, dKickS3, dKickS3, dKickS3, $0C
	dc.b	dSnareS3, dCrashCymbal, $60, nRst, $60
	smpsFade            $01
	smpsStop

Snd_SKCredits_Voices:
;	Voice $00
;	$38
;	$4C, $33, $74, $41, 	$1F, $1F, $1F, $1F, 	$11, $0F, $0D, $0D
;	$00, $0F, $00, $00, 	$FF, $FF, $FF, $FF, 	$21, $16, $26, $81
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $07, $03, $04
	smpsVcCoarseFreq    $01, $04, $03, $0C
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0D, $0D, $0F, $11
	smpsVcDecayRate2    $00, $00, $0F, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $26, $16, $21

;	Voice $01
;	$35
;	$40, $30, $50, $30, 	$18, $1F, $1F, $1F, 	$0D, $0B, $09, $09
;	$00, $00, $00, $00, 	$EF, $EF, $EF, $EF, 	$14, $85, $85, $85
	smpsVcAlgorithm     $05
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $05, $03, $04
	smpsVcCoarseFreq    $00, $00, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $18
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $09, $09, $0B, $0D
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0E, $0E, $0E, $0E
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $05, $05, $05, $14

;	Voice $02
;	$3B
;	$71, $12, $13, $71, 	$11, $10, $14, $1A, 	$0C, $09, $0A, $02
;	$00, $06, $04, $07, 	$1F, $EF, $FF, $EF, 	$1B, $24, $24, $81
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $01, $01, $07
	smpsVcCoarseFreq    $01, $03, $02, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1A, $14, $10, $11
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $0A, $09, $0C
	smpsVcDecayRate2    $07, $04, $06, $00
	smpsVcDecayLevel    $0E, $0F, $0E, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $24, $24, $1B

;	Voice $03
;	$34
;	$61, $03, $00, $61, 	$1F, $1E, $51, $D0, 	$0C, $08, $01, $01
;	$08, $00, $09, $00, 	$8F, $FF, $FF, $FF, 	$11, $85, $19, $86
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $06, $00, $00, $06
	smpsVcCoarseFreq    $01, $00, $03, $01
	smpsVcRateScale     $03, $01, $00, $00
	smpsVcAttackRate    $10, $11, $1E, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $01, $08, $0C
	smpsVcDecayRate2    $00, $09, $00, $08
	smpsVcDecayLevel    $0F, $0F, $0F, $08
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $06, $19, $05, $11

;	Voice $04
;	$1B
;	$63, $50, $21, $41, 	$15, $0F, $16, $13, 	$10, $01, $06, $05
;	$05, $01, $05, $01, 	$CF, $0F, $DF, $CF, 	$21, $12, $2A, $81
	smpsVcAlgorithm     $03
	smpsVcFeedback      $03
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $02, $05, $06
	smpsVcCoarseFreq    $01, $01, $00, $03
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $13, $16, $0F, $15
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $06, $01, $10
	smpsVcDecayRate2    $01, $05, $01, $05
	smpsVcDecayLevel    $0C, $0D, $00, $0C
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $2A, $12, $21

;	Voice $05
;	$34
;	$31, $30, $71, $31, 	$16, $1B, $13, $1F, 	$13, $06, $08, $08
;	$08, $0B, $0C, $0D, 	$9F, $8F, $9F, $8F, 	$0F, $8C, $12, $83
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $07, $03, $03
	smpsVcCoarseFreq    $01, $01, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $13, $1B, $16
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $08, $06, $13
	smpsVcDecayRate2    $0D, $0C, $0B, $08
	smpsVcDecayLevel    $08, $09, $08, $09
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $03, $12, $0C, $0F

;	Voice $06
;	$07
;	$14, $76, $72, $71, 	$9F, $9F, $1F, $1F, 	$0C, $0C, $0C, $0C
;	$0E, $0E, $03, $02, 	$0F, $0F, $DF, $DF, 	$81, $81, $81, $81
	smpsVcAlgorithm     $07
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $07, $07, $01
	smpsVcCoarseFreq    $01, $02, $06, $04
	smpsVcRateScale     $00, $00, $02, $02
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0C, $0C, $0C, $0C
	smpsVcDecayRate2    $02, $03, $0E, $0E
	smpsVcDecayLevel    $0D, $0D, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $01, $01, $01

;	Voice $07
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

;	Voice $08
;	$34
;	$33, $41, $7E, $74, 	$5B, $9F, $5F, $1F, 	$04, $07, $07, $08
;	$00, $00, $00, $00, 	$FF, $FF, $EF, $FF, 	$23, $90, $29, $97
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $07, $04, $03
	smpsVcCoarseFreq    $04, $0E, $01, $03
	smpsVcRateScale     $00, $01, $02, $01
	smpsVcAttackRate    $1F, $1F, $1F, $1B
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $07, $07, $04
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0E, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $17, $29, $10, $23

;	Voice $09
;	$3A
;	$01, $07, $31, $71, 	$8E, $8E, $8D, $53, 	$0E, $0E, $0E, $03
;	$00, $00, $00, $07, 	$1F, $FF, $1F, $0F, 	$18, $28, $27, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $03, $00, $00
	smpsVcCoarseFreq    $01, $01, $07, $01
	smpsVcRateScale     $01, $02, $02, $02
	smpsVcAttackRate    $13, $0D, $0E, $0E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $0E, $0E, $0E
	smpsVcDecayRate2    $07, $00, $00, $00
	smpsVcDecayLevel    $00, $01, $0F, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $27, $28, $18

;	Voice $0A
;	$38
;	$63, $31, $31, $31, 	$10, $13, $1A, $1B, 	$0E, $00, $00, $00
;	$00, $00, $00, $00, 	$3F, $0F, $0F, $0F, 	$1A, $19, $1A, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $03, $06
	smpsVcCoarseFreq    $01, $01, $01, $03
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1B, $1A, $13, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $0E
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $03
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1A, $19, $1A

;	Voice $0B
;	$02
;	$74, $51, $13, $31, 	$93, $D3, $12, $13, 	$06, $01, $01, $03
;	$0C, $13, $0C, $0B, 	$FF, $EF, $DF, $8F, 	$33, $13, $19, $83
	smpsVcAlgorithm     $02
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $01, $05, $07
	smpsVcCoarseFreq    $01, $03, $01, $04
	smpsVcRateScale     $00, $00, $03, $02
	smpsVcAttackRate    $13, $12, $13, $13
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $01, $01, $06
	smpsVcDecayRate2    $0B, $0C, $13, $0C
	smpsVcDecayLevel    $08, $0D, $0E, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $03, $19, $13, $33

;	Voice $0C
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

;	Voice $0D
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

;	Voice $0E
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

;	Voice $0F
;	$34
;	$02, $02, $02, $02, 	$1F, $5F, $1F, $5F, 	$0E, $00, $12, $00
;	$00, $08, $02, $08, 	$4F, $0F, $4F, $0F, 	$12, $80, $12, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $02, $02, $02, $02
	smpsVcRateScale     $01, $00, $01, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $12, $00, $0E
	smpsVcDecayRate2    $08, $02, $08, $00
	smpsVcDecayLevel    $00, $04, $00, $04
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $12, $00, $12

;	Voice $10
;	$04
;	$02, $02, $03, $03, 	$13, $10, $13, $10, 	$06, $0C, $06, $0C
;	$00, $00, $00, $00, 	$4F, $2F, $4F, $2F, 	$18, $90, $18, $90
	smpsVcAlgorithm     $04
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $03, $03, $02, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $10, $13, $10, $13
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0C, $06, $0C, $06
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $02, $04, $02, $04
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $10, $18, $10, $18

;	Voice $11
;	$3D
;	$02, $01, $01, $11, 	$1C, $18, $18, $1B, 	$06, $05, $04, $05
;	$06, $05, $06, $06, 	$6F, $8F, $5F, $7F, 	$18, $88, $88, $88
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $01, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1B, $18, $18, $1C
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $04, $05, $06
	smpsVcDecayRate2    $06, $06, $05, $06
	smpsVcDecayLevel    $07, $05, $08, $06
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $08, $08, $08, $18

;	Voice $12
;	$3D
;	$01, $01, $01, $11, 	$1C, $18, $18, $1B, 	$06, $05, $04, $05
;	$06, $05, $06, $06, 	$60, $89, $59, $79, 	$18, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1B, $18, $18, $1C
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $04, $05, $06
	smpsVcDecayRate2    $06, $06, $05, $06
	smpsVcDecayLevel    $07, $05, $08, $06
	smpsVcReleaseRate   $09, $09, $09, $00
	smpsVcTotalLevel    $00, $00, $00, $18

;	Voice $13
;	$05
;	$2E, $17, $1F, $1F, 	$1F, $1F, $1F, $1F, 	$00, $0B, $08, $08
;	$00, $08, $08, $08, 	$00, $19, $19, $19, 	$28, $8A, $89, $89
	smpsVcAlgorithm     $05
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $01, $01, $02
	smpsVcCoarseFreq    $0F, $0F, $07, $0E
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $08, $0B, $00
	smpsVcDecayRate2    $08, $08, $08, $00
	smpsVcDecayLevel    $01, $01, $01, $00
	smpsVcReleaseRate   $09, $09, $09, $00
	smpsVcTotalLevel    $09, $09, $0A, $28

;	Voice $14
;	$02
;	$71, $52, $41, $11, 	$17, $16, $15, $17, 	$0A, $03, $05, $03
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$07, $1F, $25, $87
	smpsVcAlgorithm     $02
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $04, $05, $07
	smpsVcCoarseFreq    $01, $01, $02, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $17, $15, $16, $17
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $05, $03, $0A
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $07, $25, $1F, $07

;	Voice $15
;	$03
;	$74, $18, $71, $11, 	$DF, $5F, $1F, $1F, 	$0C, $0F, $01, $01
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$0B, $1D, $10, $84
	smpsVcAlgorithm     $03
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $07, $01, $07
	smpsVcCoarseFreq    $01, $01, $08, $04
	smpsVcRateScale     $00, $00, $01, $03
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $01, $0F, $0C
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $04, $10, $1D, $0B

;	Voice $16
;	$3D
;	$41, $01, $21, $71, 	$0D, $12, $52, $D2, 	$01, $01, $01, $01
;	$08, $00, $09, $00, 	$89, $F8, $F9, $F8, 	$1D, $87, $87, $87
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $02, $00, $04
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $03, $01, $00, $00
	smpsVcAttackRate    $12, $12, $12, $0D
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $01, $01, $01
	smpsVcDecayRate2    $00, $09, $00, $08
	smpsVcDecayLevel    $0F, $0F, $0F, $08
	smpsVcReleaseRate   $08, $09, $08, $09
	smpsVcTotalLevel    $07, $07, $07, $1D

;	Voice $17
;	$03
;	$61, $51, $23, $41, 	$10, $10, $0F, $15, 	$1C, $01, $06, $05
;	$05, $01, $05, $01, 	$C9, $0C, $D9, $C9, 	$18, $17, $17, $83
	smpsVcAlgorithm     $03
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $02, $05, $06
	smpsVcCoarseFreq    $01, $03, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $15, $0F, $10, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $06, $01, $1C
	smpsVcDecayRate2    $01, $05, $01, $05
	smpsVcDecayLevel    $0C, $0D, $00, $0C
	smpsVcReleaseRate   $09, $09, $0C, $09
	smpsVcTotalLevel    $03, $17, $17, $18

;	Voice $18
;	$10
;	$57, $4B, $76, $41, 	$19, $12, $5F, $1F, 	$02, $06, $05, $01
;	$00, $0F, $00, $00, 	$18, $38, $58, $18, 	$26, $1F, $1C, $87
	smpsVcAlgorithm     $00
	smpsVcFeedback      $02
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $07, $04, $05
	smpsVcCoarseFreq    $01, $06, $0B, $07
	smpsVcRateScale     $00, $01, $00, $00
	smpsVcAttackRate    $1F, $1F, $12, $19
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $05, $06, $02
	smpsVcDecayRate2    $00, $00, $0F, $00
	smpsVcDecayLevel    $01, $05, $03, $01
	smpsVcReleaseRate   $08, $08, $08, $08
	smpsVcTotalLevel    $07, $1C, $1F, $26

;	Voice $19
;	$02
;	$74, $50, $13, $31, 	$95, $D5, $15, $16, 	$06, $01, $01, $03
;	$0C, $13, $0C, $0B, 	$FF, $EF, $DF, $8F, 	$3D, $1D, $22, $81
	smpsVcAlgorithm     $02
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $01, $05, $07
	smpsVcCoarseFreq    $01, $03, $00, $04
	smpsVcRateScale     $00, $00, $03, $02
	smpsVcAttackRate    $16, $15, $15, $15
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $01, $01, $06
	smpsVcDecayRate2    $0B, $0C, $13, $0C
	smpsVcDecayLevel    $08, $0D, $0E, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $22, $1D, $3D

;	Voice $1A
;	$3D
;	$43, $05, $23, $71, 	$11, $16, $55, $D5, 	$01, $01, $01, $01
;	$08, $00, $09, $00, 	$89, $F8, $F9, $F8, 	$1B, $88, $8A, $88
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $02, $00, $04
	smpsVcCoarseFreq    $01, $03, $05, $03
	smpsVcRateScale     $03, $01, $00, $00
	smpsVcAttackRate    $15, $15, $16, $11
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $01, $01, $01
	smpsVcDecayRate2    $00, $09, $00, $08
	smpsVcDecayLevel    $0F, $0F, $0F, $08
	smpsVcReleaseRate   $08, $09, $08, $09
	smpsVcTotalLevel    $08, $0A, $08, $1B

;	Voice $1B
;	$38
;	$75, $13, $71, $11, 	$1F, $5F, $1F, $1F, 	$10, $0D, $03, $04
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$1F, $16, $1D, $81
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $07, $01, $07
	smpsVcCoarseFreq    $01, $01, $03, $05
	smpsVcRateScale     $00, $00, $01, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $04, $03, $0D, $10
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $1D, $16, $1F

;	Voice $1C
;	$3D
;	$01, $01, $11, $12, 	$18, $1F, $1F, $1F, 	$10, $06, $06, $06
;	$01, $00, $00, $00, 	$3F, $1F, $1F, $1F, 	$10, $83, $83, $83
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $01, $00, $00
	smpsVcCoarseFreq    $02, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $18
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $06, $06, $10
	smpsVcDecayRate2    $00, $00, $00, $01
	smpsVcDecayLevel    $01, $01, $01, $03
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $03, $03, $03, $10

;	Voice $1D
;	$00
;	$23, $30, $30, $21, 	$9F, $5F, $1F, $1F, 	$00, $0F, $01, $00
;	$07, $00, $00, $0C, 	$0F, $4F, $FF, $0F, 	$26, $30, $1D, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $02, $03, $03, $02
	smpsVcCoarseFreq    $01, $00, $00, $03
	smpsVcRateScale     $00, $00, $01, $02
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $01, $0F, $00
	smpsVcDecayRate2    $0C, $00, $00, $07
	smpsVcDecayLevel    $00, $0F, $04, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1D, $30, $26

;	Voice $1E
;	$04
;	$12, $0A, $06, $7C, 	$5F, $5F, $5F, $5F, 	$00, $08, $00, $00
;	$00, $00, $00, $0A, 	$0F, $FF, $0F, $0F, 	$11, $8C, $13, $8C
	smpsVcAlgorithm     $04
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $00, $00, $01
	smpsVcCoarseFreq    $0C, $06, $0A, $02
	smpsVcRateScale     $01, $01, $01, $01
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $08, $00
	smpsVcDecayRate2    $0A, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $0F, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0C, $13, $0C, $11

;	Voice $1F
;	$3D
;	$02, $02, $01, $02, 	$1F, $1F, $1F, $1F, 	$06, $05, $04, $05
;	$06, $05, $06, $06, 	$60, $87, $58, $78, 	$1B, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $02, $01, $02, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $04, $05, $06
	smpsVcDecayRate2    $06, $06, $05, $06
	smpsVcDecayLevel    $07, $05, $08, $06
	smpsVcReleaseRate   $08, $08, $07, $00
	smpsVcTotalLevel    $00, $00, $00, $1B

;	Voice $20
;	$04
;	$70, $71, $00, $00, 	$1F, $1F, $1F, $1F, 	$00, $0F, $01, $00
;	$07, $00, $00, $0C, 	$4F, $4F, $FF, $0F, 	$19, $80, $1A, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $07, $07
	smpsVcCoarseFreq    $00, $00, $01, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $01, $0F, $00
	smpsVcDecayRate2    $0C, $00, $00, $07
	smpsVcDecayLevel    $00, $0F, $04, $04
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1A, $00, $19

;	Voice $21
;	$07
;	$02, $03, $04, $05, 	$0F, $0F, $0F, $0F, 	$06, $06, $06, $06
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$8C, $8C, $88, $80
	smpsVcAlgorithm     $07
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $05, $04, $03, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0F, $0F, $0F, $0F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $06, $06, $06
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $08, $0C, $0C

;	Voice $22
;	$3D
;	$51, $21, $30, $10, 	$1F, $1F, $1F, $1F, 	$0F, $00, $00, $00
;	$00, $00, $00, $00, 	$1F, $4F, $4F, $4F, 	$10, $8E, $8E, $8E
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $03, $02, $05
	smpsVcCoarseFreq    $00, $00, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $0F
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $04, $04, $04, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0E, $0E, $0E, $10

;	Voice $23
;	$2C
;	$71, $62, $31, $32, 	$5F, $54, $5F, $5F, 	$00, $09, $00, $09
;	$00, $03, $00, $03, 	$0F, $8F, $0F, $AF, 	$16, $80, $11, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $06, $07
	smpsVcCoarseFreq    $02, $01, $02, $01
	smpsVcRateScale     $01, $01, $01, $01
	smpsVcAttackRate    $1F, $1F, $14, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $09, $00, $09, $00
	smpsVcDecayRate2    $03, $00, $03, $00
	smpsVcDecayLevel    $0A, $00, $08, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $11, $00, $16

;	Voice $24
;	$3C
;	$71, $31, $12, $11, 	$17, $1F, $19, $2F, 	$04, $01, $07, $01
;	$00, $00, $00, $00, 	$F7, $F8, $F7, $F8, 	$1D, $80, $19, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $01, $03, $07
	smpsVcCoarseFreq    $01, $02, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $2F, $19, $1F, $17
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $01, $07, $01, $04
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $08, $07, $08, $07
	smpsVcTotalLevel    $00, $19, $00, $1D

