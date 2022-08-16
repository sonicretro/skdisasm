Snd_DPZ_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoiceUVB
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $23

	smpsHeaderDAC       Snd_DPZ_DAC
	smpsHeaderFM        Snd_DPZ_FM1,	$18, $0A
	smpsHeaderFM        Snd_DPZ_FM2,	$0C, $11
	smpsHeaderFM        Snd_DPZ_FM3,	$0C, $11
	smpsHeaderFM        Snd_DPZ_FM4,	$00, $0F
	smpsHeaderFM        Snd_DPZ_FM5,	$00, $0F
	smpsHeaderPSG       Snd_DPZ_PSG1,	$F4, $04, $00, sTone_0C
	smpsHeaderPSG       Snd_DPZ_PSG2,	$F4, $04, $00, sTone_0C
	smpsHeaderPSG       Snd_DPZ_PSG3,	$00, $00, $00, sTone_0C

; Unreachable
	smpsStop
	smpsStop

; DAC Data
Snd_DPZ_DAC:
	dc.b	dSnareS3, $18, dSnareS3, $18, dSnareS3, $18, dSnareS3, $18, dKickS3, $12, dKickS3, $06
	dc.b	dSnareS3, $0C, dKickS3, $0C, dKickS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, $0C
	dc.b	dSnareS3, $18, dSnareS3, $18, dKickS3, $06, dSnareS3, $12, dSnareS3, $0C, dSnareS3, $06
	dc.b	dSnareS3, $06, dKickS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, $0C, dKickS3, $12
	dc.b	dKickS3, $06, dSnareS3, $0C, dKickS3, $0C, dSnareS3, $18, dSnareS3, $18, dSnareS3, $18
	dc.b	dSnareS3, $18, dKickS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, $0C, dKickS3, $12
	dc.b	dKickS3, $06, dSnareS3, $0C, dKickS3, $0C, dSnareS3, $18, dSnareS3, $18, dKickS3, $06
	dc.b	dSnareS3, $12, dSnareS3, $0C, dSnareS3, $06, dSnareS3, $06, dKickS3, $12, dKickS3, $06
	dc.b	dSnareS3, $0C, dKickS3, $0C, dKickS3, $12, dKickS3, $06, dSnareS3, $06, dSnareS3, $06
	dc.b	dSnareS3, $06, dSnareS3, $06, dKickS3, $18, dSnareS3, $12, dKickS3, $06, dKickS3, $18
	dc.b	dSnareS3, $18, dKickS3, $18, dSnareS3, $12, dKickS3, $06, dKickS3, $18, dSnareS3, $18
	dc.b	dKickS3, $18, dSnareS3, $12, dKickS3, $06, dKickS3, $18, dSnareS3, $18, dKickS3, $18
	dc.b	dSnareS3, $12, dKickS3, $06, dKickS3, $18, dSnareS3, $0C, dSnareS3, $0C, dKickS3, $18
	dc.b	dSnareS3, $12, dKickS3, $06, dKickS3, $18, dSnareS3, $18, dKickS3, $18, dSnareS3, $12
	dc.b	dKickS3, $06, dKickS3, $18, dSnareS3, $18, dKickS3, $18, dSnareS3, $12, dKickS3, $06
	dc.b	dKickS3, $18, dSnareS3, $18, dKickS3, $18, dSnareS3, $12, dKickS3, $06, dKickS3, $06
	dc.b	dSnareS3, $0C, dSnareS3, $06, dSnareS3, $0C, dSnareS3, $06, dSnareS3, $06, dKickS3, $18
	dc.b	dSnareS3, $12, dKickS3, $06, dKickS3, $18, dSnareS3, $18, dKickS3, $18, dSnareS3, $12
	dc.b	dKickS3, $06, dKickS3, $18, dSnareS3, $18, dKickS3, $18, dSnareS3, $12, dKickS3, $06
	dc.b	dKickS3, $18, dSnareS3, $0C, dSnareS3, $0C, dSnareS3, $18, dSnareS3, $18, dSnareS3, $18
	dc.b	dSnareS3, $0C, dSnareS3, $0C, dKickS3, $18, dSnareS3, $12, dKickS3, $06, dKickS3, $18
	dc.b	dSnareS3, $18, dKickS3, $18, dSnareS3, $12, dKickS3, $06, dKickS3, $18, dSnareS3, $18
	dc.b	dSnareS3, $06, dKickS3, $06, dSnareS3, $06, dSnareS3, $06, nRst, $0C, dSnareS3, $06
	dc.b	dKickS3, $06, dKickS3, $0C, dSnareS3, $06, dKickS3, $06, dSnareS3, $06, dSnareS3, $0C
	dc.b	dKickS3, $06, dSnareS3, $06, dSnareS3, $0C, dSnareS3, $06, nRst, $06, dKickS3, $06
	dc.b	dSnareS3, $0C, nRst, $0C, dSnareS3, $06, dSnareS3, $06, dSnareS3, $06, dSnareS3, $06
	dc.b	dSnareS3, $02, nRst, $08
	smpsJump            Snd_DPZ_DAC

; Unreachable
	smpsStop

; FM1 Data
Snd_DPZ_FM1:
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nA1, $04, nRst, $02, nC2, $04, nRst, $02, nA1, $04, nRst, $08
	dc.b	nG1, $04, nRst, $02, nB1, $04, nRst, $02, nG1, $04, nRst, $08
	dc.b	nF1, $04, nRst, $02, nA1, $04, nRst, $02, nF1, $04, nRst, $08
	dc.b	nE1, $04, nRst, $02, nG1, $04, nRst, $02, nE1, $04, nRst, $08
	dc.b	nD1, $10, nRst, $02, nD1, $06, smpsNoAttack, $0A, nRst, $02, nD1, $04
	dc.b	nRst, $08, nE1, $10, nRst, $02, nE1, $06, smpsNoAttack, $0A, nRst, $02
	dc.b	nE1, $04, nRst, $08, nA1, $04, nRst, $02, nC2, $04, nRst, $02
	dc.b	nA1, $04, nRst, $08, nG1, $04, nRst, $02, nB1, $04, nRst, $02
	dc.b	nG1, $04, nRst, $08, nF1, $04, nRst, $02, nA1, $04, nRst, $02
	dc.b	nF1, $04, nRst, $08, nE1, $04, nRst, $02, nG1, $04, nRst, $02
	dc.b	nE1, $04, nRst, $08, nD1, $10, nRst, $02, nD1, $06, smpsNoAttack, $0A
	dc.b	nRst, $02, nD1, $04, nRst, $08, nE1, $10, nRst, $02, nE1, $06
	dc.b	smpsNoAttack, $0A, nRst, $02, nE1, $04, nRst, $08, nA1, $04, nRst, $02
	dc.b	nC2, $04, nRst, $02, nA1, $04, nRst, $08, nG1, $04, nRst, $02
	dc.b	nB1, $04, nRst, $02, nG1, $04, nRst, $08, nF1, $04, nRst, $02
	dc.b	nA1, $04, nRst, $02, nF1, $04, nRst, $08, nE1, $04, nRst, $02
	dc.b	nG1, $04, nRst, $02, nE1, $04, nRst, $08, nD1, $10, nRst, $02
	dc.b	nD1, $06, smpsNoAttack, $0A, nRst, $02, nD1, $04, nRst, $08, nE1, $10
	dc.b	nRst, $02, nE1, $06, smpsNoAttack, $0A, nRst, $02, nE1, $04, nRst, $08
	dc.b	nA1, $04, nRst, $02, nC2, $04, nRst, $02, nA1, $04, nRst, $08
	dc.b	nG1, $04, nRst, $02, nB1, $04, nRst, $02, nG1, $04, nRst, $08
	dc.b	nF1, $04, nRst, $02, nA1, $04, nRst, $02, nF1, $04, nRst, $08
	dc.b	nE1, $04, nRst, $02, nG1, $04, nRst, $02, nE1, $04, nRst, $08
	dc.b	nD1, $10, nRst, $02, nD1, $06, smpsNoAttack, $0A, nRst, $02, nD1, $04
	dc.b	nRst, $08, nE1, $10, nRst, $02, nE1, $06, smpsNoAttack, $0A, nRst, $02
	dc.b	nG1, $04, nRst, $08, nC2, $10, nRst, $02, nC2, $02, nRst, $04
	dc.b	nRst, $06, nG1, $04, nRst, $02, nA1, $06, nG1, $06, nC2, $10
	dc.b	nRst, $02, nC2, $02, nRst, $04, nRst, $06, nG1, $04, nRst, $02
	dc.b	nA1, $06, nC2, $06, nBb1, $10, nRst, $02, nBb1, $02, nRst, $04
	dc.b	nRst, $06, nF1, $04, nRst, $02, nG1, $06, nF1, $06, nBb1, $10
	dc.b	nRst, $02, nBb1, $02, nRst, $04, nRst, $06, nF1, $04, nRst, $02
	dc.b	nG1, $06, nBb1, $06, nA1, $10, nRst, $02, nA1, $02, nRst, $04
	dc.b	nRst, $06, nF1, $04, nRst, $02, nG1, $06, nF1, $06, nA1, $10
	dc.b	nRst, $02, nA1, $02, nRst, $04, nRst, $06, nF1, $04, nRst, $02
	dc.b	nG1, $06, nA1, $06, nG1, $04, nRst, $08, nG1, $0C, nA1, $02
	dc.b	nRst, $0A, nA1, $0A, nRst, $02, nB1, $04, nRst, $08, nB1, $0C
	dc.b	nC2, $02, nRst, $0A, nD2, $0C, nC2, $0E, nRst, $04, nC2, $04
	dc.b	nRst, $02, nRst, $06, nG1, $06, nA1, $06, nG1, $04, nRst, $02
	dc.b	nC2, $0E, nRst, $04, nC2, $04, nRst, $02, nRst, $06, nG1, $06
	dc.b	nA1, $06, nC2, $04, nRst, $02, nBb1, $10, nRst, $02, nBb1, $04
	dc.b	nRst, $02, nRst, $06, nF1, $06, nG1, $06, nF1, $06, nBb1, $10
	dc.b	nRst, $02, nBb1, $04, nRst, $02, nRst, $06, nF1, $06, nG1, $06
	dc.b	nBb1, $04, nRst, $02, nA1, $10, nRst, $02, nA1, $04, nRst, $02
	dc.b	nRst, $06, nF1, $04, nRst, $02, nG1, $06, nF1, $04, nRst, $02
	dc.b	nA1, $0E, nRst, $04, nA1, $06, nRst, $06, nF1, $06, nG1, $06
	dc.b	nA1, $04, nRst, $02, nG1, $02, nRst, $0A, nG1, $0C, nA1, $04
	dc.b	nRst, $08, nA1, $0C, nB1, $04, nRst, $08, nB1, $0C, nC2, $02
	dc.b	nRst, $0A, nD2, $0A, nRst, $02, nF1, $10, nRst, $02, nF1, $04
	dc.b	nRst, $02, nRst, $06, nC1, $06, nD1, $06, nC1, $06, nF1, $10
	dc.b	nRst, $02, nF1, $02, nRst, $04, nRst, $06, nC1, $06, nD1, $06
	dc.b	nF1, $06, nE1, $10, nRst, $02, nE1, $02, nRst, $04, nRst, $06
	dc.b	nG0, $06, nA0, $06, nG0, $06, nE1, $10, nRst, $02, nE1, $02
	dc.b	nRst, $04, nRst, $06, nG0, $06, nA0, $06, nG0, $06, nD1, $10
	dc.b	nRst, $02, nD1, $02, nRst, $04, nRst, $06, nG0, $06, nA0, $06
	dc.b	nG0, $06, nD1, $10, nRst, $02, nD1, $02, nRst, $04, nRst, $06
	dc.b	nG0, $06, nA0, $06, nG0, $06, nC1, $04, nRst, $08, nC1, $0C
	dc.b	nD1, $02, nRst, $0A, nD1, $0C, nE1, $04, nRst, $08, nE1, $0C
	dc.b	nF1, $04, nRst, $08, nG1, $0C, nF1, $10, nRst, $02, nF1, $04
	dc.b	nRst, $02, nRst, $06, nC1, $06, nD1, $06, nC1, $06, nF1, $10
	dc.b	nRst, $02, nF1, $04, nRst, $02, nRst, $06, nG1, $06, nA1, $06
	dc.b	nC2, $06, nB1, $12, nG1, $02, nRst, $04, nRst, $06, nG0, $06
	dc.b	nA0, $06, nC1, $06, nA1, $12, nE1, $02, nRst, $04, nRst, $18
	dc.b	nD1, $06, nRst, $06, nD1, $02, nRst, $04, nD1, $04, nRst, $02
	dc.b	nRst, $0C, nD1, $06, nRst, $06, nRst, $0C, nD1, $06, nRst, $06
	dc.b	nC1, $06, nD1, $06, nRst, $0C, nG1, $04, nRst, $02, nG1, $06
	dc.b	nRst, $06, nG1, $04, nRst, $02, nRst, $0C, nAb1, $0C, smpsNoAttack, $0A
	dc.b	nRst, $02, nE1, $0C, smpsNoAttack, $12, nRst, $04
	smpsJump            Snd_DPZ_FM1

; Unreachable
	smpsStop

; FM2 Data
Snd_DPZ_FM2:
	smpsPan             panLeft, $00
	smpsSetvoice        $0C
	smpsAlterNote       $FD
	smpsModSet          $0F, $01, $06, $06
	smpsCall            Snd_DPZ_Call00
	smpsSetvoice        $03
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsCall            Snd_DPZ_Call01
	smpsJump            Snd_DPZ_FM2

Snd_DPZ_Call00:
	dc.b	nA3, $10, nRst, $02, nA3, $04, nRst, $02, nRst, $06, nG3, $02
	dc.b	nRst, $04, nG3, $04, nRst, $08, nF3, $16, nRst, $02, nE3, $16
	dc.b	nRst, $02, nRst, $18, nA3, $16, nRst, $02, nB3, $16, nRst, $02
	dc.b	nG3, $16, nRst, $02, nA3, $10, nRst, $02, nA3, $04, nRst, $02
	dc.b	nRst, $06, nG3, $02, nRst, $04, nG3, $04, nRst, $08, nRst, $06
	dc.b	nF3, $10, nRst, $02, nE3, $16, nRst, $02, nRst, $18, nA3, $16
	dc.b	nRst, $02, nB3, $16, nRst, $02, nG3, $16, nRst, $02, nA3, $10
	dc.b	nRst, $02, nA3, $04, nRst, $02, nRst, $06, nG3, $02, nRst, $04
	dc.b	nG3, $04, nRst, $08, nF3, $16, nRst, $02, nE3, $16, nRst, $02
	dc.b	nRst, $18, nA3, $16, nRst, $02, nB3, $16, nRst, $02, nG3, $16
	dc.b	nRst, $02, nA3, $10, nRst, $02, nA3, $04, nRst, $02, nRst, $06
	dc.b	nG3, $02, nRst, $04, nG3, $04, nRst, $08, nRst, $06, nF3, $10
	dc.b	nRst, $02, nE3, $16, nRst, $02, nRst, $18, nA3, $16, nRst, $02
	dc.b	nB3, $16, nRst, $02, nG3, $16, nRst, $02
	smpsReturn

Snd_DPZ_Call01:
	smpsAlterPitch      $0C
	smpsFMAlterVol      $04
	dc.b	nG4, $18, smpsNoAttack, $0A, nRst, $02, nE4, $0C, smpsNoAttack, $18, smpsNoAttack, $0A
	dc.b	nRst, $02, nF4, $04, nRst, $02, nG4, $04, nRst, $02, nF4, $18
	dc.b	smpsNoAttack, $0A, nRst, $02, nD4, $0C, smpsNoAttack, $18, smpsNoAttack, $0A, nRst, $02
	dc.b	nE4, $04, nRst, $02, nF4, $04, nRst, $02, nE4, $18, smpsNoAttack, $0A
	dc.b	nRst, $02, nC4, $0C, smpsNoAttack, $18, smpsNoAttack, $0A, nRst, $02, nD4, $04
	dc.b	nRst, $02, nE4, $04, nRst, $02, nD4, $04, nRst, $08, nD4, $0A
	dc.b	nRst, $02, nRst, $0C, nG3, $0C, smpsNoAttack, $18, smpsNoAttack, $0A, nRst, $0E
	dc.b	nG4, $18, smpsNoAttack, $0A, nRst, $02, nE4, $0C, smpsNoAttack, $18, smpsNoAttack, $0A
	dc.b	nRst, $02, nF4, $04, nRst, $02, nG4, $04, nRst, $02, nF4, $18
	dc.b	smpsNoAttack, $0A, nRst, $02, nD4, $0C, smpsNoAttack, $18, smpsNoAttack, $0A, nRst, $02
	dc.b	nE4, $04, nRst, $02, nF4, $04, nRst, $02, nE4, $18, smpsNoAttack, $0A
	dc.b	nRst, $02, nC4, $0C, smpsNoAttack, $18, smpsNoAttack, $0A, nRst, $02, nD4, $04
	dc.b	nRst, $02, nE4, $04, nRst, $02, nD4, $04, nRst, $08, nD4, $0C
	dc.b	smpsNoAttack, $02, nRst, $0A, nG3, $0C, smpsNoAttack, $16, nRst, $02
	smpsSetvoice        $0A
	smpsAlterNote       $01
	smpsModSet          $0A, $01, $03, $06
	smpsAlterPitch      $F4
	smpsFMAlterVol      $FA
	dc.b	nRst, $0C, nC5, $04, nRst, $02, nD5, $04, nRst, $02, nE5, $18
	dc.b	smpsNoAttack, $16, nRst, $02, nD5, $10, nRst, $02, nG5, $06, smpsNoAttack, $0A
	dc.b	nRst, $02, nF5, $0A, nRst, $02, nE5, $18, smpsNoAttack, $16, nRst, $02
	dc.b	nC5, $10, nRst, $02, nD5, $06, smpsNoAttack, $0A, nRst, $02, nE5, $0A
	dc.b	nRst, $02, nD5, $18, smpsNoAttack, $18, smpsNoAttack, $0A, nRst, $02, nE5, $0C
	dc.b	smpsNoAttack, $0A, nRst, $02, nF5, $0A, nRst, $02, nE5, $18, smpsNoAttack, $18
	dc.b	smpsNoAttack, $16, nRst, $02, nRst, $0C, nD5, $04, nRst, $02, nE5, $04
	dc.b	nRst, $02, nF5, $18, smpsNoAttack, $16, nRst, $02, nD5, $10, nRst, $02
	dc.b	nG5, $06, smpsNoAttack, $0A, nRst, $02, nF5, $0A, nRst, $02, nE5, $04
	dc.b	nRst, $08, nE5, $0C, smpsNoAttack, $16, nRst, $02, nC5, $18, smpsNoAttack, $16
	dc.b	nRst, $02, nRst, $0C, nD5, $04, nRst, $02, nC5, $04, nRst, $02
	dc.b	nD5, $04, nRst, $08, nE5, $04, nRst, $02, nD5, $04, nRst, $02
	dc.b	nE5, $04, nRst, $08, nF5, $04, nRst, $02, nE5, $04, nRst, $02
	dc.b	nF5, $04, nRst, $08, nG5, $04, nRst, $02, nF5, $04, nRst, $02
	dc.b	nG5, $04, nRst, $08, nA5, $04, nRst, $02, nAb5, $04, nRst, $02
	dc.b	nA5, $04, nRst, $08, nAb5, $0C, smpsNoAttack, $0A, nRst, $02, nE5, $0C
	dc.b	smpsNoAttack, $16
	smpsFMAlterVol      $02
	smpsReturn

; Unreachable
	smpsStop

; FM3 Data
Snd_DPZ_FM3:
	dc.b	nRst, $02

Snd_DPZ_Jump00:
	smpsPan             panRight, $00
	smpsSetvoice        $0C
	smpsAlterNote       $03
	smpsModSet          $0F, $01, $06, $06
	smpsCall            Snd_DPZ_Call00
	smpsSetvoice        $03
	smpsAlterNote       $02
	smpsModSet          $0F, $01, $06, $06
	smpsCall            Snd_DPZ_Call01
	smpsJump            Snd_DPZ_Jump00

; Unreachable
	smpsStop

; FM4 Data
Snd_DPZ_FM4:
	smpsSetvoice        $19
	smpsAlterNote       $03
	smpsModSet          $00, $01, $03, $06
	dc.b	nC4, $10, nRst, $02, nC4, $04, nRst, $02, nRst, $06, nB3, $02
	dc.b	nRst, $04, nB3, $04, nRst, $08, nA3, $16, nRst, $02, nG3, $16
	dc.b	nRst, $02, nRst, $18, nC4, $16, nRst, $02, nD4, $16, nRst, $02
	dc.b	nB3, $16, nRst, $02, nC4, $10, nRst, $02, nC4, $04, nRst, $02
	dc.b	nRst, $06, nB3, $02, nRst, $04, nB3, $04, nRst, $08, nRst, $06
	dc.b	nA3, $10, nRst, $02, nG3, $16, nRst, $02, nRst, $18, nD4, $16
	dc.b	nRst, $02, nE4, $16, nRst, $02, nB3, $16, nRst, $02, nC4, $10
	dc.b	nRst, $02, nC4, $04, nRst, $02, nRst, $06, nB3, $02, nRst, $04
	dc.b	nB3, $04, nRst, $08, nA3, $16, nRst, $02, nG3, $16, nRst, $02
	dc.b	nRst, $18, nC4, $16, nRst, $02, nD4, $16, nRst, $02, nB3, $16
	dc.b	nRst, $02, nC4, $10, nRst, $02, nC4, $04, nRst, $02, nRst, $06
	dc.b	nB3, $02, nRst, $04, nB3, $04, nRst, $08, nRst, $06, nA3, $10
	dc.b	nRst, $02, nG3, $16, nRst, $02, nRst, $18, nD4, $16, nRst, $02
	dc.b	nE4, $16, nRst, $02, nB3, $16, nRst, $02
	smpsAlterPitch      $0C
	dc.b	nC2, $10, nRst, $02, nC2, $04, nRst, $02, nRst, $06, nG3, $04
	dc.b	nRst, $08, nG3, $04, nRst, $02, nRst, $06, nC2, $04, nRst, $02
	dc.b	nG3, $04, nRst, $02, nC2, $04, nRst, $02, nRst, $06, nC2, $04
	dc.b	nRst, $02, nG3, $0A, nRst, $02, nBb1, $10, nRst, $02, nBb1, $04
	dc.b	nRst, $02, nRst, $06, nF3, $04, nRst, $08, nF3, $04, nRst, $02
	dc.b	nRst, $06, nBb1, $04, nRst, $02, nF3, $04, nRst, $02, nBb1, $04
	dc.b	nRst, $02, nF3, $16, nRst, $02, nA1, $10, nRst, $02, nA1, $04
	dc.b	nRst, $02, nRst, $06, nE3, $04, nRst, $08, nE3, $04, nRst, $02
	dc.b	nRst, $06, nA1, $04, nRst, $02, nE3, $04, nRst, $02, nA1, $04
	dc.b	nRst, $02, nRst, $06, nA1, $04, nRst, $02, nE3, $0A, nRst, $02
	dc.b	nRst, $06, nG2, $04, nRst, $02, nB2, $04, nRst, $02, nD3, $04
	dc.b	nRst, $02, nG3, $04, nRst, $02, nD3, $04, nRst, $02, nG3, $04
	dc.b	nRst, $02, nG3, $04, nRst, $02, nRst, $06, nB3, $04, nRst, $08
	dc.b	nB3, $04, nRst, $02, nC4, $04, nRst, $08, nD4, $04, nRst, $08
	dc.b	nC2, $10, nRst, $02, nC2, $04, nRst, $02, nRst, $06, nG3, $04
	dc.b	nRst, $08, nG3, $04, nRst, $02, nRst, $06, nC2, $04, nRst, $02
	dc.b	nG3, $04, nRst, $02, nC2, $04, nRst, $02, nRst, $06, nC2, $04
	dc.b	nRst, $02, nG3, $0A, nRst, $02, nBb1, $10, nRst, $02, nBb1, $04
	dc.b	nRst, $02, nRst, $06, nF3, $04, nRst, $08, nF3, $04, nRst, $02
	dc.b	nRst, $06, nBb1, $04, nRst, $02, nF3, $04, nRst, $02, nBb1, $04
	dc.b	nRst, $02, nF3, $16, nRst, $02, nA1, $10, nRst, $02, nA1, $04
	dc.b	nRst, $02, nRst, $06, nE3, $04, nRst, $08, nE3, $04, nRst, $02
	dc.b	nRst, $06, nA1, $04, nRst, $02, nE3, $04, nRst, $02, nA1, $04
	dc.b	nRst, $02, nRst, $06, nA1, $04, nRst, $02, nE3, $0A, nRst, $02
	dc.b	nRst, $06, nG2, $04, nRst, $02, nB2, $04, nRst, $02, nD3, $04
	dc.b	nRst, $02, nG3, $04, nRst, $02, nD3, $04, nRst, $02, nG3, $04
	dc.b	nRst, $02, nG3, $04, nRst, $02, nRst, $06, nB3, $04, nRst, $08
	dc.b	nB3, $04, nRst, $02, nC4, $04, nRst, $08, nC4, $04, nRst, $08
	dc.b	nA3, $18, smpsNoAttack, $16, nRst, $02, nA3, $10, nRst, $02, nB3, $06
	dc.b	smpsNoAttack, $0A, nRst, $02, nC4, $0A, nRst, $02, nB3, $18, smpsNoAttack, $16
	dc.b	nRst, $02, nG3, $10, nRst, $02, nA3, $06, smpsNoAttack, $0A, nRst, $02
	dc.b	nB3, $0A, nRst, $02, nA3, $18, smpsNoAttack, $16, nRst, $02, nF3, $10
	dc.b	nRst, $02, nG3, $06, smpsNoAttack, $0A, nRst, $02, nA3, $0A, nRst, $02
	dc.b	nRst, $06, nC3, $04, nRst, $02, nE3, $04, nRst, $02, nG3, $04
	dc.b	nRst, $02, nC4, $04, nRst, $02, nG3, $04, nRst, $02, nC4, $04
	dc.b	nRst, $02, nC4, $04, nRst, $02, nRst, $06, nE4, $04, nRst, $08
	dc.b	nE4, $04, nRst, $02, nF4, $04, nRst, $08, nG4, $04, nRst, $08
	dc.b	nC4, $18, smpsNoAttack, $18, nC4, $12, nD4, $06, smpsNoAttack, $0A, nRst, $02
	dc.b	nF4, $0A, nRst, $02, nE4, $04, nRst, $08, nE4, $0C, smpsNoAttack, $0A
	dc.b	nRst, $02, nE4, $0A, nRst, $02, nA4, $18, smpsNoAttack, $16, nRst, $02
	dc.b	nRst, $0C, nB4, $06, nA4, $06, nB4, $06, nRst, $06, nC5, $04
	dc.b	nRst, $02, nB4, $06, nC5, $04, nRst, $08, nD5, $04, nRst, $02
	dc.b	nC5, $06, nD5, $04, nRst, $08, nE5, $06, nD5, $06, nE5, $04
	dc.b	nRst, $08, nF5, $04, nRst, $02, nE5, $06, nF5, $04, nRst, $08
	dc.b	nE5, $0C, smpsNoAttack, $0A, nRst, $02, nC5, $0C, smpsNoAttack, $16
	smpsAlterPitch      $F4
	smpsJump            Snd_DPZ_FM4

; Unreachable
	smpsStop

; FM5 Data
Snd_DPZ_FM5:
	smpsSetvoice        $1B
	smpsAlterNote       $00
	smpsModSet          $0F, $01, $06, $06
	smpsAlterPitch      $F4
	dc.b	nE5, $18, smpsNoAttack, $16, nRst, $02, nF5, $10, nRst, $02, nF5, $04
	dc.b	nRst, $02, nG5, $16, nRst, $02, nC6, $10, nRst, $02, nB5, $06
	dc.b	smpsNoAttack, $0A, nRst, $02, nA5, $0A, nRst, $02, nG5, $10, nRst, $02
	dc.b	nE5, $06, smpsNoAttack, $0A, nRst, $02, nF5, $0A, nRst, $02, nE5, $18
	dc.b	smpsNoAttack, $16, nRst, $02, nRst, $06, nA5, $10, nRst, $02, nB5, $16
	dc.b	nRst, $02, nC6, $10, nRst, $02, nB5, $06, smpsNoAttack, $0A, nRst, $02
	dc.b	nA5, $0A, nRst, $02, nG5, $10, nRst, $02, nE5, $06, smpsNoAttack, $0A
	dc.b	nRst, $02, nG5, $0A, nRst, $02, nE5, $18, smpsNoAttack, $16, nRst, $02
	dc.b	nF5, $10, nRst, $02, nF5, $04, nRst, $02, nG5, $16, nRst, $02
	dc.b	nC6, $10, nRst, $02, nB5, $06, smpsNoAttack, $0A, nRst, $02, nA5, $0A
	dc.b	nRst, $02, nG5, $10, nRst, $02, nE5, $06, smpsNoAttack, $0A, nRst, $02
	dc.b	nF5, $0A, nRst, $02, nE5, $18, smpsNoAttack, $16, nRst, $02, nRst, $06
	dc.b	nA5, $10, nRst, $02, nB5, $16, nRst, $02, nC6, $10, nRst, $02
	dc.b	nB5, $06, smpsNoAttack, $0A, nRst, $02, nA5, $0A, nRst, $02, nG5, $10
	dc.b	nRst, $02, nE5, $06, smpsNoAttack, $0A, nRst, $02, nG5, $0A, nRst, $02
	dc.b	nE5, $18, smpsNoAttack, $04, nRst, $02
	smpsSetvoice        $19
	smpsAlterNote       $FD
	smpsModSet          $00, $01, $03, $06
	smpsAlterPitch      $18
	dc.b	nE3, $04, nRst, $08, nE3, $04, nRst, $02, nRst, $0C, nE3, $04
	dc.b	nRst, $08, nRst, $0C, nE3, $0A, nRst, $02, nRst, $18, nRst, $06
	dc.b	nD3, $04, nRst, $08, nD3, $04, nRst, $02, nRst, $0C, nD3, $04
	dc.b	nRst, $08, nD3, $16, nRst, $02, nRst, $18, nRst, $06, nC3, $04
	dc.b	nRst, $08, nC3, $04, nRst, $02, nRst, $0C, nC3, $04, nRst, $08
	dc.b	nRst, $0C, nC3, $0A, nRst, $02, nRst, $18, nRst, $18, nRst, $06
	dc.b	nG3, $04, nRst, $08, nG3, $04, nRst, $02, nA3, $04, nRst, $08
	dc.b	nB3, $04, nRst, $08, nRst, $18, nRst, $06, nE3, $04, nRst, $08
	dc.b	nE3, $04, nRst, $02, nRst, $0C, nE3, $04, nRst, $08, nRst, $0C
	dc.b	nE3, $0A, nRst, $02, nRst, $18, nRst, $06, nD3, $04, nRst, $08
	dc.b	nD3, $04, nRst, $02, nRst, $0C, nD3, $04, nRst, $08, nD3, $16
	dc.b	nRst, $02, nRst, $18, nRst, $06, nC3, $04, nRst, $08, nC3, $04
	dc.b	nRst, $02, nRst, $0C, nC3, $04, nRst, $08, nRst, $0C, nC3, $0A
	dc.b	nRst, $02, nRst, $18, nRst, $18, nRst, $06, nG3, $04, nRst, $08
	dc.b	nG3, $04, nRst, $02, nA3, $04, nRst, $08, nA3, $04, nRst, $08
	dc.b	nC4, $10, nRst, $02, nC4, $04, nRst, $02, nRst, $0C, nC4, $04
	dc.b	nRst, $08, nRst, $18, nRst, $18, nG3, $10, nRst, $02, nG3, $04
	dc.b	nRst, $02, nRst, $0C, nG3, $04, nRst, $08, nRst, $18, nRst, $18
	dc.b	nF3, $10, nRst, $02, nF3, $04, nRst, $02, nRst, $0C, nF3, $04
	dc.b	nRst, $08, nRst, $18, nRst, $18, nRst, $18, nRst, $18, nRst, $06
	dc.b	nC4, $04, nRst, $08, nC4, $04, nRst, $02, nD4, $04, nRst, $08
	dc.b	nE4, $04, nRst, $08, nC4, $10, nRst, $02, nC4, $04, nRst, $02
	dc.b	nRst, $0C, nC4, $04, nRst, $08, nRst, $18, nRst, $18, nB3, $10
	dc.b	nRst, $02, nB3, $04, nRst, $02, nRst, $06, nB3, $04, nRst, $0E
	dc.b	nE4, $10, nRst, $02, nE4, $04, nRst, $02, nRst, $06, nE4, $04
	dc.b	nRst, $0E, nRst, $18, nRst, $18, nRst, $18, nRst, $18, nRst, $18
	dc.b	nRst, $18, nRst, $18, nRst, $16
	smpsAlterPitch      $F4
	smpsJump            Snd_DPZ_FM5

; Unreachable
	smpsStop

; PSG1 Data
Snd_DPZ_PSG1:
	dc.b	nRst, $01
	smpsPSGvoice        sTone_0A
	smpsAlterNote       $FF
	smpsJump            Snd_DPZ_Jump02

; PSG2 Data
Snd_DPZ_PSG2:
	smpsAlterNote       $00
	smpsPSGvoice        sTone_0A

Snd_DPZ_Jump02:
	dc.b	nC5, $04, nRst, $02, nE5, $04, nRst, $02, nC5, $04, nRst, $08
	dc.b	nB4, $04, nRst, $02, nD5, $04, nRst, $02, nB4, $04, nRst, $08
	dc.b	nA4, $04, nRst, $02, nC5, $04, nRst, $02, nA4, $04, nRst, $08
	dc.b	nG4, $04, nRst, $02, nB4, $04, nRst, $02, nG4, $04, nRst, $08
	dc.b	nF4, $0C, nRst, $06, nF4, $06, smpsNoAttack, $04, nRst, $08, nF4, $04
	dc.b	nRst, $08, nG4, $0C, nRst, $06, nG4, $06, smpsNoAttack, $04, nRst, $08
	dc.b	nG4, $04, nRst, $08, nC5, $04, nRst, $02, nE5, $04, nRst, $02
	dc.b	nC5, $04, nRst, $08, nB4, $04, nRst, $02, nD5, $04, nRst, $02
	dc.b	nB4, $04, nRst, $08, nA4, $04, nRst, $02, nC5, $04, nRst, $02
	dc.b	nA4, $04, nRst, $08, nG4, $04, nRst, $02, nB4, $04, nRst, $02
	dc.b	nG4, $04, nRst, $08, nF4, $0C, nRst, $06, nF4, $06, smpsNoAttack, $04
	dc.b	nRst, $08, nF4, $06, nRst, $06, nG4, $0A, nRst, $08, nG4, $06
	dc.b	smpsNoAttack, $02, nRst, $0A, nG4, $02, nRst, $0A, nC5, $04, nRst, $02
	dc.b	nE5, $04, nRst, $02, nC5, $04, nRst, $08, nB4, $04, nRst, $02
	dc.b	nD5, $04, nRst, $02, nB4, $04, nRst, $08, nA4, $04, nRst, $02
	dc.b	nC5, $04, nRst, $02, nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b	nB4, $04, nRst, $02, nG4, $04, nRst, $08, nF4, $0C, nRst, $06
	dc.b	nF4, $06, smpsNoAttack, $04, nRst, $08, nF4, $04, nRst, $08, nG4, $0C
	dc.b	nRst, $06, nG4, $06, smpsNoAttack, $02, nRst, $0A, nG4, $02, nRst, $0A
	dc.b	nC5, $04, nRst, $02, nE5, $04, nRst, $02, nC5, $04, nRst, $08
	dc.b	nB4, $04, nRst, $02, nD5, $04, nRst, $02, nB4, $04, nRst, $08
	dc.b	nA4, $04, nRst, $02, nC5, $04, nRst, $02, nA4, $04, nRst, $08
	dc.b	nG4, $04, nRst, $02, nB4, $04, nRst, $02, nG4, $04, nRst, $08
	dc.b	nF4, $0C, nRst, $06, nF4, $06, smpsNoAttack, $04, nRst, $08, nF4, $06
	dc.b	nRst, $06, nG4, $0C, nRst, $06, nG4, $06, smpsNoAttack, $02, nRst, $0A
	dc.b	nD4, $0A, nRst, $02, nC4, $04, nRst, $02, nC4, $04, nRst, $02
	dc.b	nC5, $04, nRst, $02, nC4, $04, nRst, $02, nC4, $04, nRst, $02
	dc.b	nC5, $04, nRst, $0E, nRst, $18, nRst, $18, nBb3, $04, nRst, $02
	dc.b	nBb3, $04, nRst, $02, nBb4, $04, nRst, $02, nBb3, $04, nRst, $02
	dc.b	nRst, $18, nRst, $18, nRst, $18, nA3, $04, nRst, $02, nA3, $04
	dc.b	nRst, $02, nA4, $04, nRst, $02, nA3, $04, nRst, $02, nA3, $04
	dc.b	nRst, $02, nA4, $04, nRst, $02, nA3, $04, nRst, $02, nA3, $04
	dc.b	nRst, $02, nRst, $18, nRst, $18, nRst, $06, nG3, $04, nRst, $02
	dc.b	nB3, $04, nRst, $02, nD4, $04, nRst, $02, nG4, $04, nRst, $02
	dc.b	nD4, $04, nRst, $02, nG4, $04, nRst, $02, nG4, $04, nRst, $02
	dc.b	nRst, $06, nB4, $04, nRst, $08, nB4, $04, nRst, $02, nC5, $04
	dc.b	nRst, $08, nD5, $04, nRst, $08, nC4, $04, nRst, $02, nC4, $04
	dc.b	nRst, $02, nC5, $04, nRst, $02, nC4, $04, nRst, $02, nC4, $04
	dc.b	nRst, $02, nC5, $04, nRst, $02, nC4, $04, nRst, $02, nC4, $04
	dc.b	nRst, $02, nRst, $18, nRst, $18, nBb3, $04, nRst, $02, nBb3, $04
	dc.b	nRst, $02, nBb4, $04, nRst, $02, nBb3, $04, nRst, $02, nBb3, $04
	dc.b	nRst, $02, nBb4, $04, nRst, $02, nBb3, $04, nRst, $02, nBb3, $04
	dc.b	nRst, $02, nRst, $18, nRst, $18, nA3, $04, nRst, $02, nA3, $04
	dc.b	nRst, $02, nA4, $04, nRst, $02, nA3, $04, nRst, $02, nA3, $04
	dc.b	nRst, $02, nA4, $04, nRst, $02, nA3, $04, nRst, $02, nA3, $04
	dc.b	nRst, $02, nRst, $18, nRst, $18, nRst, $06, nG3, $04, nRst, $02
	dc.b	nB3, $04, nRst, $02, nD4, $04, nRst, $02, nG4, $04, nRst, $02
	dc.b	nD4, $04, nRst, $02, nG4, $04, nRst, $02, nG4, $04, nRst, $02
	dc.b	nRst, $06, nB4, $04, nRst, $08, nB4, $04, nRst, $02, nC5, $04
	dc.b	nRst, $14, nE4, $10, nRst, $02, nE4, $04, nRst, $02, nRst, $0C
	dc.b	nE4, $04, nRst, $08, nRst, $0C, nA4, $04, nRst, $02, nB4, $04
	dc.b	nRst, $02, nRst, $06, nB4, $04, nRst, $02, nC5, $04, nRst, $08
	dc.b	nB3, $10, nRst, $02, nB3, $04, nRst, $02, nRst, $0C, nB3, $04
	dc.b	nRst, $08, nRst, $0C, nG4, $04, nRst, $02, nA4, $04, nRst, $02
	dc.b	nRst, $06, nA4, $04, nRst, $02, nB4, $04, nRst, $08, nA3, $10
	dc.b	nRst, $02, nA3, $04, nRst, $02, nRst, $0C, nA3, $04, nRst, $08
	dc.b	nRst, $0C, nF4, $04, nRst, $02, nG4, $04, nRst, $02, nRst, $06
	dc.b	nG4, $04, nRst, $02, nA4, $04, nRst, $08, nRst, $06, nC4, $04
	dc.b	nRst, $02, nE4, $04, nRst, $02, nG4, $04, nRst, $02, nC5, $04
	dc.b	nRst, $02, nG4, $04, nRst, $02, nC5, $04, nRst, $02, nC5, $04
	dc.b	nRst, $02, nRst, $06, nE5, $04, nRst, $08, nE5, $04, nRst, $02
	dc.b	nF5, $04, nRst, $08, nG5, $04, nRst, $08, nF4, $10, nRst, $02
	dc.b	nF4, $04, nRst, $02, nRst, $0C, nF4, $04, nRst, $08, nRst, $0C
	dc.b	nC4, $04, nRst, $02, nD4, $04, nRst, $02, nRst, $06, nD4, $04
	dc.b	nRst, $02, nF4, $04, nRst, $08, nE4, $04, nRst, $02, nE5, $04
	dc.b	nRst, $02, nE4, $04, nRst, $02, nE5, $04, nRst, $02, nE4, $04
	dc.b	nRst, $02, nE5, $04, nRst, $02, nE4, $04, nRst, $08, nA4, $04
	dc.b	nRst, $02, nA4, $04, nRst, $02, nA3, $04, nRst, $02, nA4, $04
	dc.b	nRst, $02, nA3, $04, nRst, $02, nA4, $04, nRst, $02, nA3, $04
	dc.b	nRst, $08, nD4, $04, nRst, $02, nD4, $04, nRst, $02, nD5, $04
	dc.b	nRst, $02, nD4, $04, nRst, $02, nD4, $04, nRst, $02, nD5, $04
	dc.b	nRst, $02, nE4, $04, nRst, $02, nE4, $04, nRst, $02, nE5, $04
	dc.b	nRst, $02, nE4, $04, nRst, $02, nF4, $04, nRst, $02, nF4, $04
	dc.b	nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $02, nG4, $04
	dc.b	nRst, $02, nG4, $04, nRst, $02, nG5, $04, nRst, $02, nG4, $04
	dc.b	nRst, $02, nG4, $04, nRst, $02, nAb4, $04, nRst, $02, nA4, $04
	dc.b	nRst, $08, nAb4, $0C, smpsNoAttack, $04, nRst, $02, nF4, $04, nRst, $02
	dc.b	nFs4, $04, nRst, $02, nG4, $04, nRst, $02, nAb4, $04, nRst, $02
	dc.b	nA4, $04, nRst, $02, nBb4, $04, nRst, $02, nB4, $04
	smpsJump            Snd_DPZ_PSG2

; Unreachable
	smpsStop

; PSG3 Data
Snd_DPZ_PSG3:
	smpsPSGvoice        sTone_02
	smpsPSGform         $E7

Snd_DPZ_Jump01:
	dc.b	nRst, $0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06, nMaxPSG1, $06, smpsNoAttack, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $18, smpsNoAttack, $18, smpsNoAttack, $18, smpsNoAttack, $18, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, smpsNoAttack, $0C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $04, smpsNoAttack, $02, smpsNoAttack, $18, smpsNoAttack, $18, smpsNoAttack, $18, smpsNoAttack, $18
	dc.b	smpsNoAttack, $18, smpsNoAttack, $18, smpsNoAttack, $18, smpsNoAttack, $16
	smpsJump            Snd_DPZ_Jump01

; Unreachable
	smpsStop

