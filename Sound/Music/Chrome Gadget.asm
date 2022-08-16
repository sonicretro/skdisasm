Snd_CGZ_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoiceUVB
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $25

	smpsHeaderDAC       Snd_CGZ_DAC
	smpsHeaderFM        Snd_CGZ_FM1,	$18, $0C
	smpsHeaderFM        Snd_CGZ_FM2,	$0C, $02
	smpsHeaderFM        Snd_CGZ_FM3,	$0C, $0C
	smpsHeaderFM        Snd_CGZ_FM4,	$0C, $0B
	smpsHeaderFM        Snd_CGZ_FM5,	$0C, $0B
	smpsHeaderPSG       Snd_CGZ_PSG1,	$F4, $03, $00, sTone_0C
	smpsHeaderPSG       Snd_CGZ_PSG2,	$F4, $04, $00, sTone_0C
	smpsHeaderPSG       Snd_CGZ_PSG3,	$00, $02, $00, sTone_0C

; Unreachable
	smpsStop
	smpsStop

Snd_CGZ_Call00:
	dc.b	dKickS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, $06, dKickS3, $06, dKickS3, $12
	dc.b	dKickS3, $06, dSnareS3, $18
	smpsReturn

Snd_CGZ_Call01:
	dc.b	dKickS3, $0C, dKickS3, $06, dSnareS3, $0C, dKickS3, $06, dSnareS3, $12, dSnareS3, $0C
	dc.b	dKickS3, $06, dSnareS3, $18
	smpsReturn

Snd_CGZ_Call03:
	dc.b	dKickS3, $12, dKickS3, $06, dSnareS3, $06, dKickS3, $06, dKickS3, $18, dKickS3, $06
	dc.b	dKickS3, $06, dSnareS3, $18
	smpsReturn

Snd_CGZ_Call02:
	dc.b	dKickS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, $06, dKickS3, $0C, dKickS3, $0C
	dc.b	dKickS3, $06, dSnareS3, $18
	smpsReturn

; DAC Data
Snd_CGZ_DAC:
	smpsCall            Snd_CGZ_Call00
	smpsLoop            $01, $03, Snd_CGZ_DAC
	dc.b	dKickS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, $06, dKickS3, $06, dKickS3, $12
	dc.b	dKickS3, $06, dSnareS3, $0C, dSnareS3, $06, dSnareS3, $06

Snd_CGZ_Loop00:
	smpsCall            Snd_CGZ_Call00
	smpsLoop            $01, $03, Snd_CGZ_Loop00
	dc.b	dKickS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, $06, dKickS3, $06, dKickS3, $12
	dc.b	dKickS3, $06, dSnareS3, $0C, dSnareS3, $06, dSnareS3, $06
	smpsCall            Snd_CGZ_Call01
	smpsCall            Snd_CGZ_Call02
	smpsCall            Snd_CGZ_Call01
	dc.b	dKickS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, $06, dKickS3, $0C, dSnareS3, $0C
	dc.b	dKickS3, $06, dSnareS3, $06, dSnareS3, $06, dSnareS3, $06, dSnareS3, $06
	smpsCall            Snd_CGZ_Call01
	smpsCall            Snd_CGZ_Call02
	dc.b	dKickS3, $0C, dKickS3, $06, dSnareS3, $0C, dKickS3, $06, dSnareS3, $06, dKickS3, $0C
	dc.b	dSnareS3, $0C, dKickS3, $06, dSnareS3, $12, dSnareS3, $06, dKickS3, $06, dSnareS3, $0C
	dc.b	dSnareS3, $06, dSnareS3, $0C, dSnareS3, $06, dSnareS3, $06, dKickS3, $12, dKickS3, $06
	dc.b	dSnareS3, $02, dSnareS3, $04, dSnareS3, $06, dSnareS3, $06, dSnareS3, $06

Snd_CGZ_Loop01:
	smpsCall            Snd_CGZ_Call03
	smpsLoop            $01, $03, Snd_CGZ_Loop01
	dc.b	dKickS3, $12, dKickS3, $06, dSnareS3, $06, dKickS3, $06, dKickS3, $18, dKickS3, $06
	dc.b	dKickS3, $06, dSnareS3, $0C, dSnareS3, $06, dSnareS3, $06

Snd_CGZ_Loop02:
	smpsCall            Snd_CGZ_Call03
	smpsLoop            $01, $03, Snd_CGZ_Loop02
	dc.b	dKickS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, $06, dKickS3, $06, dKickS3, $06
	dc.b	dSnareS3, $06, dSnareS3, $06, dKickS3, $06, dSnareS3, $06, dSnareS3, $06, dSnareS3, $06
	dc.b	dSnareS3, $06

Snd_CGZ_Loop03:
	smpsCall            Snd_CGZ_Call03
	smpsLoop            $01, $03, Snd_CGZ_Loop03
	dc.b	dKickS3, $12, dKickS3, $06, dSnareS3, $06, dKickS3, $06, dKickS3, $12, dSnareS3, $06
	dc.b	dKickS3, $06, dKickS3, $06, dSnareS3, $0C, dSnareS3, $06, dSnareS3, $06

Snd_CGZ_Loop04:
	smpsCall            Snd_CGZ_Call03
	smpsLoop            $01, $02, Snd_CGZ_Loop04
	dc.b	dSnareS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, $06, dKickS3, $06, dSnareS3, $12
	dc.b	dKickS3, $06, dSnareS3, $18, dSnareS3, $0C, dSnareS3, $06, dSnareS3, $06, dSnareS3, $06
	dc.b	dSnareS3, $06, dSnareS3, $06, dSnareS3, $06, dKickS3, $12, dKickS3, $06, dSnareS3, $02
	dc.b	dSnareS3, $04, dSnareS3, $06, dSnareS3, $06, dSnareS3, $06
	smpsJump            Snd_CGZ_DAC

; Unreachable
	smpsStop

; FM1 Data
Snd_CGZ_FM1:
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02

Snd_CGZ_Jump03:
	dc.b	nA0, $0A, nRst, $02, nE1, $04, nRst, $02, nA1, $0A, nRst, $02
	dc.b	nE1, $04, nRst, $02, nA1, $04, nRst, $02, nE1, $04, nRst, $02
	dc.b	nA0, $0A, nRst, $02, nE1, $04, nRst, $02, nA1, $0A, nRst, $02
	dc.b	nE1, $04, nRst, $02, nA1, $0A, nRst, $02, nA0, $0A, nRst, $02
	dc.b	nE1, $04, nRst, $02, nA1, $0A, nRst, $02, nE1, $04, nRst, $02
	dc.b	nA1, $04, nRst, $02, nE1, $04, nRst, $02, nA0, $0A, nRst, $02
	dc.b	nE1, $04, nRst, $02, nA1, $0A, nRst, $02, nE1, $04, nRst, $02
	dc.b	nA1, $0A, nRst, $02, nAb0, $0A, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nAb1, $0A, nRst, $02, nEb1, $04, nRst, $02, nAb1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nAb0, $0A, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nAb1, $0A, nRst, $02, nEb1, $04, nRst, $02, nAb1, $0A, nRst, $02
	dc.b	nAb0, $0A, nRst, $02, nEb1, $04, nRst, $02, nAb1, $0A, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nAb1, $04, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nAb0, $0A, nRst, $02, nEb1, $04, nRst, $02, nAb1, $0A, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nAb1, $0A, nRst, $02, nA0, $0A, nRst, $02
	dc.b	nE1, $04, nRst, $02, nA1, $0A, nRst, $02, nE1, $04, nRst, $02
	dc.b	nA1, $04, nRst, $02, nE1, $04, nRst, $02, nA0, $0A, nRst, $02
	dc.b	nE1, $04, nRst, $02, nA1, $0A, nRst, $02, nE1, $04, nRst, $02
	dc.b	nA1, $0A, nRst, $02, nA0, $0A, nRst, $02, nE1, $04, nRst, $02
	dc.b	nA1, $0A, nRst, $02, nE1, $04, nRst, $02, nA1, $04, nRst, $02
	dc.b	nE1, $04, nRst, $02, nA0, $0A, nRst, $02, nE1, $04, nRst, $02
	dc.b	nA1, $0A, nRst, $02, nE1, $04, nRst, $02, nA1, $0A, nRst, $02
	dc.b	nAb0, $0A, nRst, $02, nEb1, $04, nRst, $02, nAb1, $0A, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nAb1, $04, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nAb0, $0A, nRst, $02, nEb1, $04, nRst, $02, nAb1, $0A, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nAb1, $0A, nRst, $02, nAb0, $0A, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nAb1, $0A, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nAb1, $04, nRst, $02, nEb1, $04, nRst, $02, nAb0, $0A, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nAb1, $0A, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nAb1, $0A, nRst, $02, nD1, $0A, nRst, $02, nD1, $04, nRst, $02
	dc.b	nD1, $0A, nRst, $02, nD1, $04, nRst, $02, nD1, $10, nRst, $02
	dc.b	nD2, $0A, nRst, $02, nD1, $04, nRst, $02, nD1, $0A, nRst, $02
	dc.b	nD1, $04, nRst, $02, nD1, $04, nRst, $02, nCs1, $0A, nRst, $02
	dc.b	nCs1, $04, nRst, $02, nCs1, $0A, nRst, $02, nCs1, $04, nRst, $02
	dc.b	nCs1, $10, nRst, $02, nCs1, $0A, nRst, $02, nCs1, $04, nRst, $02
	dc.b	nCs1, $0A, nRst, $02, nCs1, $04, nRst, $02, nCs1, $04, nRst, $02
	dc.b	nC1, $0A, nRst, $02, nC1, $04, nRst, $02, nC1, $0A, nRst, $02
	dc.b	nC1, $04, nRst, $02, nC1, $10, nRst, $02, nC2, $0A, nRst, $02
	dc.b	nC1, $04, nRst, $02, nC1, $0A, nRst, $02, nC1, $04, nRst, $02
	dc.b	nC1, $04, nRst, $02, nCs1, $0A, nRst, $02, nCs1, $04, nRst, $02
	dc.b	nCs1, $0A, nRst, $02, nCs1, $04, nRst, $02, nCs1, $10, nRst, $02
	dc.b	nCs1, $0A, nRst, $02, nCs1, $04, nRst, $02, nCs1, $0A, nRst, $02
	dc.b	nCs1, $04, nRst, $02, nCs1, $04, nRst, $02, nD1, $0A, nRst, $02
	dc.b	nD1, $04, nRst, $02, nD1, $0A, nRst, $02, nD1, $04, nRst, $02
	dc.b	nD1, $10, nRst, $02, nD2, $0A, nRst, $02, nD1, $04, nRst, $02
	dc.b	nD1, $0A, nRst, $02, nD1, $04, nRst, $02, nD1, $04, nRst, $02
	dc.b	nCs1, $0A, nRst, $02, nCs1, $04, nRst, $02, nCs1, $0A, nRst, $02
	dc.b	nCs1, $04, nRst, $02, nCs1, $10, nRst, $02, nCs1, $0A, nRst, $02
	dc.b	nCs1, $04, nRst, $02, nCs1, $0A, nRst, $02, nCs1, $04, nRst, $02
	dc.b	nCs1, $04, nRst, $02, nC1, $0A, nRst, $02, nC2, $04, nRst, $02
	dc.b	nC1, $0A, nRst, $02, nC1, $04, nRst, $02, nC2, $04, nRst, $02
	dc.b	nC1, $04, nRst, $08, nEb2, $04, nRst, $02, nCs2, $04, nRst, $02
	dc.b	nC2, $04, nRst, $02, nBb1, $04, nRst, $02, nAb1, $04, nRst, $02
	dc.b	nG1, $04, nRst, $02, nFs1, $04, nRst, $08, nFs1, $04, nRst, $08
	dc.b	nFs1, $04, nRst, $02, nFs1, $04, nRst, $08, nFs1, $04, nRst, $02
	dc.b	nAb1, $04, nRst, $1A, nF1, $16, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $08, nEb2, $0A, nRst, $02, nD2, $04, nRst, $02
	dc.b	nEb2, $10, nRst, $08, nEb1, $04, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nBb1, $04, nRst, $02, nBb1, $04, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nEb1, $04, nRst, $02, nEb1, $04, nRst, $08
	dc.b	nEb2, $0A, nRst, $02, nD2, $04, nRst, $02, nEb2, $10, nRst, $08
	dc.b	nEb1, $04, nRst, $02, nEb1, $04, nRst, $02, nBb1, $04, nRst, $02
	dc.b	nBb1, $04, nRst, $02, nEb1, $04, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nD1, $04, nRst, $02, nD1, $04, nRst, $08, nD2, $0A, nRst, $02
	dc.b	nC2, $04, nRst, $02, nD2, $10, nRst, $08, nD1, $04, nRst, $02
	dc.b	nD1, $04, nRst, $02, nD2, $04, nRst, $02, nD2, $04, nRst, $02
	dc.b	nD1, $04, nRst, $02, nD1, $04, nRst, $02, nD1, $04, nRst, $02
	dc.b	nD1, $04, nRst, $08, nD2, $0A, nRst, $02, nC2, $04, nRst, $02
	dc.b	nD2, $10, nRst, $08, nD1, $04, nRst, $02, nD1, $04, nRst, $02
	dc.b	nD2, $04, nRst, $02, nD2, $04, nRst, $02, nD1, $04, nRst, $02
	dc.b	nD1, $04, nRst, $02, nEb1, $04, nRst, $02, nEb1, $04, nRst, $08
	dc.b	nEb2, $0A, nRst, $02, nD2, $04, nRst, $02, nEb2, $10, nRst, $08
	dc.b	nEb1, $04, nRst, $02, nEb1, $04, nRst, $02, nBb1, $04, nRst, $02
	dc.b	nBb1, $04, nRst, $02, nEb1, $04, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nEb1, $04, nRst, $08, nEb2, $0A, nRst, $02
	dc.b	nD2, $04, nRst, $02, nEb2, $10, nRst, $08, nEb1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nBb1, $04, nRst, $02, nBb1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nEb1, $04, nRst, $02, nD1, $04, nRst, $02
	dc.b	nD1, $04, nRst, $08, nD2, $0A, nRst, $02, nC2, $04, nRst, $02
	dc.b	nD2, $10, nRst, $08, nD1, $04, nRst, $02, nD1, $04, nRst, $02
	dc.b	nD2, $04, nRst, $02, nD2, $04, nRst, $02, nD1, $04, nRst, $02
	dc.b	nD1, $04, nRst, $02, nD1, $04, nRst, $02, nD1, $04, nRst, $08
	dc.b	nD2, $0A, nRst, $02, nC2, $04, nRst, $02, nD2, $10, nRst, $08
	dc.b	nD1, $04, nRst, $02, nD1, $04, nRst, $02, nD2, $04, nRst, $02
	dc.b	nD2, $04, nRst, $02, nD1, $04, nRst, $02, nD1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nEb1, $04, nRst, $08, nEb2, $0A, nRst, $02
	dc.b	nD2, $04, nRst, $02, nEb2, $10, nRst, $08, nEb1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nBb1, $04, nRst, $02, nBb1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nEb1, $04, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $08, nEb2, $0A, nRst, $02, nD2, $04, nRst, $02
	dc.b	nEb2, $10, nRst, $08, nEb1, $04, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nBb1, $04, nRst, $02, nBb1, $04, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nD1, $04, nRst, $02, nD1, $04, nRst, $08
	dc.b	nD2, $0A, nRst, $02, nC2, $04, nRst, $02, nD2, $10, nRst, $08
	dc.b	nD1, $04, nRst, $02, nD1, $04, nRst, $02, nD2, $04, nRst, $02
	dc.b	nD2, $04, nRst, $02, nD1, $04, nRst, $02, nD1, $04, nRst, $02
	dc.b	nD1, $04, nRst, $02, nD1, $04, nRst, $08, nD2, $0A, nRst, $02
	dc.b	nC2, $04, nRst, $02, nD2, $10, nRst, $08, nD1, $04, nRst, $02
	dc.b	nD1, $04, nRst, $02, nD2, $04, nRst, $02, nD2, $04, nRst, $02
	dc.b	nD1, $04, nRst, $02, nD1, $04, nRst, $02, nCs1, $04, nRst, $02
	dc.b	nCs1, $04, nRst, $08, nCs2, $0A, nRst, $02, nC2, $04, nRst, $02
	dc.b	nCs2, $10, nRst, $08, nCs1, $04, nRst, $02, nCs1, $04, nRst, $02
	dc.b	nCs2, $04, nRst, $02, nCs2, $04, nRst, $02, nCs1, $04, nRst, $02
	dc.b	nCs1, $04, nRst, $02, nCs1, $04, nRst, $02, nCs1, $04, nRst, $08
	dc.b	nCs2, $0A, nRst, $02, nC2, $04, nRst, $02, nCs2, $10, nRst, $08
	dc.b	nCs1, $04, nRst, $02, nCs1, $04, nRst, $02, nCs2, $04, nRst, $02
	dc.b	nCs2, $04, nRst, $02, nCs1, $04, nRst, $02, nCs1, $04, nRst, $02
	dc.b	nC1, $04, nRst, $08, nC1, $04, nRst, $02, nC2, $04, nRst, $02
	dc.b	nC1, $04, nRst, $08, nC1, $04, nRst, $02, nC2, $04, nRst, $02
	dc.b	nC1, $04, nRst, $08, nC1, $04, nRst, $02, nC2, $04, nRst, $02
	dc.b	nC1, $04, nRst, $08, nC1, $04, nRst, $02, nC2, $04, nRst, $02
	dc.b	nC1, $04, nRst, $08, nC1, $04, nRst, $02, nC2, $04, nRst, $02
	dc.b	nC1, $04, nRst, $08, nC1, $04, nRst, $02, nC2, $04, nRst, $08
	dc.b	nC1, $04, nRst, $08, nC1, $04, nRst, $02, nC1, $04, nRst, $02
	dc.b	nC1, $04, nRst, $02, nG1, $04, nRst, $02, nC2, $04, nRst, $02
	smpsJump            Snd_CGZ_Jump03

; Unreachable
	smpsStop

; FM2 Data
Snd_CGZ_FM2:
	smpsSetvoice        $0C
	smpsAlterNote       $02
	smpsModSet          $0F, $01, $07, $07

Snd_CGZ_Jump02:
	dc.b	nC4, $04, nRst, $14, nB3, $10, nRst, $02, nC4, $04, nRst, $0E
	dc.b	nA3, $16, nRst, $02, nB3, $04, nRst, $02, nC4, $04, nRst, $02
	dc.b	nD4, $22, nRst, $02, nC4, $04, nRst, $02, nB3, $04, nRst, $02
	dc.b	nA3, $16, nRst, $02, nG3, $04, nRst, $02, nA3, $04, nRst, $02
	dc.b	nB3, $04, nRst, $02, nC4, $04, nRst, $02, nD4, $34, nRst, $08
	dc.b	nD4, $04, nRst, $14, nBb3, $34, nRst, $0E, nC3, $04, nRst, $02
	dc.b	nD3, $04, nRst, $02, nEb3, $04, nRst, $02, nF3, $04, nRst, $02
	dc.b	nG3, $04, nRst, $02, nAb3, $04, nRst, $02, nBb3, $04, nRst, $02
	dc.b	nC4, $04, nRst, $14, nB3, $10, nRst, $02, nC4, $04, nRst, $0E
	dc.b	nA3, $16, nRst, $02, nB3, $04, nRst, $02, nC4, $04, nRst, $02
	dc.b	nD4, $22, nRst, $02, nC4, $04, nRst, $02, nB3, $04, nRst, $02
	dc.b	nA3, $16, nRst, $02, nG3, $04, nRst, $02, nA3, $04, nRst, $02
	dc.b	nB3, $04, nRst, $02, nC4, $04, nRst, $02, nD4, $34, nRst, $08
	dc.b	nD4, $04, nRst, $14, nBb3, $34, nRst, $0E, nC3, $04, nRst, $02
	dc.b	nD3, $04, nRst, $02, nEb3, $04, nRst, $02, nF3, $04, nRst, $02
	dc.b	nG3, $04, nRst, $02, nAb3, $04, nRst, $02, nBb3, $04, nRst, $02
	dc.b	nC4, $52, nRst, $02, nF3, $04, nRst, $02, nG3, $04, nRst, $02
	dc.b	nAb3, $10, nRst, $02, nG3, $04, nRst, $0E, nG3, $0A, nRst, $02
	dc.b	nF3, $10, nRst, $02, nG3, $10, nRst, $02, nAb3, $0A, nRst, $02
	dc.b	nAb3, $22, nRst, $02, nEb3, $2E, nRst, $02, nAb3, $04, nRst, $02
	dc.b	nEb4, $04, nRst, $02, nEb4, $22, nRst, $02, nAb3, $16, nRst, $0E
	dc.b	nG3, $0A, nRst, $02, nAb3, $04, nRst, $02, nBb3, $04, nRst, $02
	dc.b	nC4, $52, nRst, $02, nF3, $04, nRst, $02, nG3, $04, nRst, $02
	dc.b	nAb3, $10, nRst, $02, nG3, $04, nRst, $0E, nG3, $0A, nRst, $02
	dc.b	nF3, $10, nRst, $02, nG3, $10, nRst, $02, nAb3, $0A, nRst, $02
	dc.b	nBb3, $0A, nRst, $02, nBb3, $04, nRst, $02, nEb4, $0A, nRst, $02
	dc.b	nBb3, $04, nRst, $02, nEb4, $04, nRst, $02, nEb4, $28, nRst, $02
	dc.b	nG3, $04, nRst, $02, nBb3, $04, nRst, $08, nBb3, $04, nRst, $08
	dc.b	nCs4, $04, nRst, $02, nCs4, $04, nRst, $08, nCs4, $04, nRst, $02
	dc.b	nC4, $04, nRst, $02, nBb3, $02, nAb3, $02, nFs3, $02, nF3, $02
	dc.b	nEb3, $02, nCs3, $02, nC3, $02, nBb2, $02, nAb2, $02, nFs2, $02
	dc.b	nF2, $02, nEb2, $02, nEb3, $04, nRst, $02, nF3, $04, nRst, $02
	dc.b	nG3, $04, nRst, $02, nA3, $04, nRst, $02, nBb3, $10, nRst, $02
	dc.b	nA3, $04, nRst, $0E, nBb3, $10, nRst, $02, nG3, $10, nRst, $02
	dc.b	nA3, $04, nRst, $08, nBb3, $04, nRst, $08, nBb3, $10, nRst, $02
	dc.b	nA3, $04, nRst, $0E, nBb3, $10, nRst, $02, nC4, $04, nRst, $08
	dc.b	nBb3, $04, nRst, $02, nC4, $0A, nRst, $02, nBb3, $0A, nRst, $02
	dc.b	nBb3, $28, nRst, $02, nF3, $34, nRst, $38, nBb4, $04, nRst, $0E
	dc.b	nA4, $04, nRst, $08, nBb4, $04, nRst, $08, nBb3, $10, nRst, $02
	dc.b	nA3, $04, nRst, $0E, nBb3, $10, nRst, $02, nG3, $10, nRst, $02
	dc.b	nA3, $04, nRst, $08, nBb3, $04, nRst, $08, nBb3, $0A, nRst, $02
	dc.b	nBb3, $04, nRst, $02, nA3, $04, nRst, $08, nA3, $04, nRst, $02
	dc.b	nBb3, $10, nRst, $02, nC4, $04, nRst, $08, nBb3, $04, nRst, $02
	dc.b	nC4, $0A, nRst, $02, nBb3, $0A, nRst, $02, nBb3, $1C, nRst, $02
	dc.b	nBb3, $04, nRst, $02, nF4, $04, nRst, $02, nD4, $10, nRst, $02
	dc.b	nD4, $04, nRst, $02, nEb4, $04, nRst, $02, nD4, $0A, nRst, $02
	dc.b	nC4, $04, nRst, $02, nBb3, $34, nRst, $08, nC4, $04, nRst, $02
	dc.b	nBb3, $0A, nRst, $02, nF3, $16, nRst, $02, nBb3, $10, nRst, $02
	dc.b	nA3, $04, nRst, $0E, nBb3, $10, nRst, $02, nG3, $10, nRst, $02
	dc.b	nA3, $04, nRst, $08, nBb3, $04, nRst, $08, nBb3, $10, nRst, $02
	dc.b	nA3, $04, nRst, $0E, nBb3, $10, nRst, $02, nC4, $04, nRst, $08
	dc.b	nBb3, $04, nRst, $02, nC4, $0A, nRst, $02, nBb3, $0A, nRst, $02
	dc.b	nBb3, $28, nRst, $02, nF3, $34, nRst, $38, nBb4, $04, nRst, $0E
	dc.b	nA4, $04, nRst, $08, nBb4, $04, nRst, $08, nBb3, $0A, nRst, $02
	dc.b	nBb3, $04, nRst, $02, nAb3, $04, nRst, $08, nAb3, $04, nRst, $02
	dc.b	nBb3, $10, nRst, $02, nBb3, $04, nRst, $0E, nEb3, $04, nRst, $02
	dc.b	nF3, $04, nRst, $02, nG3, $04, nRst, $02, nAb3, $04, nRst, $02
	dc.b	nBb3, $0A, nRst, $02, nBb3, $04, nRst, $02, nAb3, $04, nRst, $08
	dc.b	nAb3, $04, nRst, $02, nBb3, $10, nRst, $02, nBb3, $04, nRst, $08
	dc.b	nF3, $04, nRst, $02, nG3, $04, nRst, $02, nAb3, $04, nRst, $02
	dc.b	nBb3, $04, nRst, $02, nC4, $04, nRst, $02, nG3, $60, $2E, nRst
	dc.b	$08, nBb3, $04, nRst, $08, nG3, $04, nRst, $08, nBb3, $04, nRst
	dc.b	$02, nC4, $0A, nRst, $02
	smpsJump            Snd_CGZ_Jump02

; Unreachable
	smpsStop

; FM3 Data
Snd_CGZ_FM3:
	dc.b	nRst, $08
	smpsSetvoice        $0C
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $07, $07

Snd_CGZ_Jump06:
	smpsJump            Snd_CGZ_Jump02

; Unreachable
	smpsJump            Snd_CGZ_Jump06
	smpsStop

; FM4 Data
Snd_CGZ_FM4:
	smpsPan             panLeft, $00
	smpsSetvoice        $0A
	smpsAlterNote       $02
	smpsModSet          $0A, $01, $03, $06

Snd_CGZ_Jump01:
	dc.b	nE3, $05, nRst, $13, nD3, $11, nRst, $01, nE3, $03, nRst, $09
	dc.b	nC3, $05, nRst, $01, nC4, $05, nRst, $01, nC4, $05, nRst, $19
	dc.b	nG2, $11, nRst, $01, nG2, $05, nRst, $0D, nG2, $23, nRst, $01
	dc.b	nG3, $17, nRst, $01, nF3, $3B, nRst, $01, nF3, $05, nRst, $13
	dc.b	nD3, $23, nRst, $01, nD4, $05, nRst, $01, nD4, $05, nRst, $01
	dc.b	nC4, $05, nRst, $01, nD4, $05, nRst, $19, nF3, $17, nRst, $01
	dc.b	nE3, $05, nRst, $13, nD3, $11, nRst, $01, nE3, $03, nRst, $09
	dc.b	nC3, $05, nRst, $01, nC4, $05, nRst, $01, nC4, $05, nRst, $19
	dc.b	nG2, $11, nRst, $01, nG2, $05, nRst, $0D, nG2, $23, nRst, $01
	dc.b	nG3, $17, nRst, $01, nF3, $3B, nRst, $01, nF3, $05, nRst, $13
	dc.b	nD3, $23, nRst, $01, nD4, $05, nRst, $01, nD4, $05, nRst, $01
	dc.b	nC4, $05, nRst, $01, nD4, $05, nRst, $19, nF3, $17, nRst, $0D
	dc.b	nG2, $05, nRst, $01, nBb2, $0B, nRst, $01, nG2, $05, nRst, $01
	dc.b	nBb2, $23, nRst, $01, nF3, $17, nRst, $01, nF3, $11, nRst, $01
	dc.b	nEb3, $05, nRst, $0D, nEb3, $0B, nRst, $01, nC3, $11, nRst, $01
	dc.b	nEb3, $11, nRst, $01, nF3, $0B, nRst, $0D, nAb2, $05, nRst, $01
	dc.b	nC3, $0B, nRst, $01, nAb2, $05, nRst, $01, nC3, $24, nEb3, $17
	dc.b	nRst, $01, nF3, $11, nRst, $01, nF3, $05, nRst, $0D, nC3, $2F
	dc.b	nRst, $19, nG2, $05, nRst, $01, nBb2, $0B, nRst, $01, nG2, $05
	dc.b	nRst, $01, nBb2, $23, nRst, $01, nF3, $17, nRst, $01, nF3, $11
	dc.b	nRst, $01, nEb3, $05, nRst, $0D, nEb3, $0B, nRst, $01, nC3, $11
	dc.b	nRst, $01, nEb3, $11, nRst, $01, nF3, $0B, nRst, $0D, nC3, $05
	dc.b	nRst, $01, nG3, $0B, nRst, $01, nC3, $05, nRst, $01, nG3, $05
	dc.b	nRst, $01, nG3, $29, nRst, $01, nEb3, $05, nRst, $01, nCs3, $05
	dc.b	nRst, $07, nCs3, $05, nRst, $07, nF3, $05, nRst, $01, nF3, $05
	dc.b	nRst, $07, nF3, $05, nRst, $01, nF3, $05, nRst, $19, nEb3, $17
	dc.b	nRst, $01, nF3, $11, nRst, $01, nF3, $05, nRst, $0D, nF3, $11
	dc.b	nRst, $01, nBb2, $11, nRst, $01, nC3, $05, nRst, $07, nEb3, $05
	dc.b	nRst, $07, nF3, $11, nRst, $01, nF3, $05, nRst, $0D, nF3, $11
	dc.b	nRst, $01, nF3, $05, nRst, $07, nEb3, $05, nRst, $01, nF3, $0B
	dc.b	nRst, $01, nEb3, $0B, nRst, $01, nD3, $11, nRst, $01, nD3, $05
	dc.b	nRst, $07, nD3, $05, nRst, $07, nD3, $35, nRst, $07, nD3, $05
	dc.b	nRst, $01, nF3, $05, nRst, $01, nBb3, $05, nRst, $01, nBb3, $05
	dc.b	nRst, $01, nF3, $05, nRst, $01, nBb3, $05, nRst, $01, nD4, $05
	dc.b	nRst, $07, nF4, $05, nRst, $0D, nF4, $05, nRst, $07, nF4, $05
	dc.b	nRst, $07, nF3, $11, nRst, $01, nF3, $05, nRst, $0D, nF3, $11
	dc.b	nRst, $01, nBb2, $11, nRst, $01, nC3, $05, nRst, $07, nEb3, $05
	dc.b	nRst, $07, nF3, $11, nRst, $01, nF3, $05, nRst, $0D, nF3, $11
	dc.b	nRst, $01, nF3, $05, nRst, $07, nEb3, $05, nRst, $01, nF3, $0B
	dc.b	nRst, $01, nEb3, $0B, nRst, $01, nD3, $11, nRst, $01, nD3, $05
	dc.b	nRst, $07, nD3, $05, nRst, $01, nBb3, $05, nRst, $01, nF3, $11
	dc.b	nRst, $2B, nD3, $05, nRst, $01, nF3, $05, nRst, $01, nBb3, $05
	dc.b	nRst, $01, nBb3, $05, nRst, $01, nF3, $05, nRst, $01, nBb3, $05
	dc.b	nRst, $01, nD4, $05, nRst, $07, nF4, $05, nRst, $01, nD4, $05
	dc.b	nRst, $07, nBb3, $17, nRst, $01, nF3, $11, nRst, $01, nF3, $05
	dc.b	nRst, $0D, nF3, $11, nRst, $01, nBb2, $11, nRst, $01, nC3, $05
	dc.b	nRst, $07, nEb3, $05, nRst, $07, nF3, $11, nRst, $01, nF3, $05
	dc.b	nRst, $0D, nF3, $11, nRst, $01, nF3, $05, nRst, $07, nEb3, $05
	dc.b	nRst, $01, nF3, $0B, nRst, $01, nEb3, $0B, nRst, $01, nD3, $11
	dc.b	nRst, $01, nD3, $05, nRst, $07, nD3, $05, nRst, $07, nD3, $35
	dc.b	nRst, $07, nD3, $05, nRst, $01, nF3, $05, nRst, $01, nBb3, $05
	dc.b	nRst, $01, nBb3, $05, nRst, $01, nF3, $05, nRst, $01, nBb3, $05
	dc.b	nRst, $01, nD4, $05, nRst, $07, nF4, $05, nRst, $0D, nF4, $05
	dc.b	nRst, $07, nF4, $05, nRst, $07, nF3, $11, nRst, $01, nF3, $05
	dc.b	nRst, $0D, nF3, $11, nRst, $01, nF3, $05, nRst, $0D, nF3, $0B
	dc.b	nRst, $01, nF3, $0B, nRst, $01, nF3, $11, nRst, $01, nF3, $05
	dc.b	nRst, $0D, nF3, $11, nRst, $01, nF3, $05, nRst, $0D, nF3, $0B
	dc.b	nRst, $01, nF3, $0B, nRst, $01, nF3, $5F, nRst, $01, nE3, $2F
	dc.b	nRst, $07, nE3, $05, nRst, $07, nC3, $05, nRst, $07, nE3, $05
	dc.b	nRst, $01, nE3, $0B, nRst, $01
	smpsSetvoice        $0A
	smpsAlterNote       $02
	smpsModSet          $0A, $01, $03, $06
	smpsJump            Snd_CGZ_Jump01

; Unreachable
	smpsStop

; FM5 Data
Snd_CGZ_FM5:
	smpsPan             panRight, $00
	smpsSetvoice        $0A
	smpsAlterNote       $FE
	smpsModSet          $0A, $01, $03, $06

Snd_CGZ_Jump00:
	dc.b	nG3, $05, nRst, $13, nG3, $11, nRst, $01, nG3, $03, nRst, $09
	dc.b	nE3, $05, nRst, $01, nE4, $05, nRst, $01, nE4, $05, nRst, $19
	dc.b	nB2, $11, nRst, $01, nB2, $05, nRst, $0D, nC3, $23, nRst, $01
	dc.b	nB3, $17, nRst, $01, nBb3, $3B, nRst, $01, nBb3, $05, nRst, $13
	dc.b	nF3, $23, nRst, $01, nF4, $05, nRst, $01, nF4, $05, nRst, $01
	dc.b	nEb4, $05, nRst, $01, nF4, $05, nRst, $19, nAb3, $17, nRst, $01
	dc.b	nG3, $05, nRst, $13, nG3, $11, nRst, $01, nG3, $03, nRst, $09
	dc.b	nE3, $05, nRst, $01, nE4, $05, nRst, $01, nE4, $05, nRst, $19
	dc.b	nB2, $11, nRst, $01, nB2, $05, nRst, $0D, nC3, $23, nRst, $01
	dc.b	nB3, $17, nRst, $01, nBb3, $3B, nRst, $01, nBb3, $05, nRst, $13
	dc.b	nF3, $23, nRst, $01, nF4, $05, nRst, $01, nF4, $05, nRst, $01
	dc.b	nEb4, $05, nRst, $01, nF4, $05, nRst, $19, nAb3, $17, nRst, $0D
	dc.b	nE3, $05, nRst, $01, nF3, $0B, nRst, $01, nE3, $05, nRst, $01
	dc.b	nF3, $23, nRst, $01, nBb3, $17, nRst, $01, nC4, $11, nRst, $01
	dc.b	nBb3, $05, nRst, $0D, nBb3, $0B, nRst, $01, nAb3, $11, nRst, $01
	dc.b	nBb3, $11, nRst, $01, nC4, $0B, nRst, $0D, nC3, $05, nRst, $01
	dc.b	nEb3, $0B, nRst, $01, nC3, $05, nRst, $01, nEb3, $24, nAb3, $17
	dc.b	nRst, $01, nC4, $11, nRst, $01, nC4, $05, nRst, $0D, nF3, $2F
	dc.b	nRst, $19, nE3, $05, nRst, $01, nF3, $0B, nRst, $01, nE3, $05
	dc.b	nRst, $01, nF3, $23, nRst, $01, nBb3, $17, nRst, $01, nC4, $11
	dc.b	nRst, $01, nBb3, $05, nRst, $0D, nBb3, $0B, nRst, $01, nAb3, $11
	dc.b	nRst, $01, nBb3, $11, nRst, $01, nC4, $0B, nRst, $0D, nEb3, $05
	dc.b	nRst, $01, nBb3, $0B, nRst, $01, nEb3, $05, nRst, $01, nBb3, $05
	dc.b	nRst, $01, nBb3, $29, nRst, $01, nG3, $05, nRst, $01, nF3, $05
	dc.b	nRst, $07, nF3, $05, nRst, $07, nBb3, $05, nRst, $01, nBb3, $05
	dc.b	nRst, $07, nBb3, $05, nRst, $01, nC4, $05, nRst, $19, nA3, $17
	dc.b	nRst, $01, nC4, $11, nRst, $01, nC4, $05, nRst, $0D, nC4, $11
	dc.b	nRst, $01, nEb3, $11, nRst, $01, nF3, $05, nRst, $07, nG3, $05
	dc.b	nRst, $07, nC4, $11, nRst, $01, nC4, $05, nRst, $0D, nC4, $11
	dc.b	nRst, $01, nA3, $05, nRst, $07, nG3, $05, nRst, $01, nA3, $0B
	dc.b	nRst, $01, nG3, $0B, nRst, $01, nF3, $11, nRst, $01, nF3, $05
	dc.b	nRst, $07, nF3, $05, nRst, $07, nBb3, $35, nRst, $07, nF3, $05
	dc.b	nRst, $01, nBb3, $05, nRst, $01, nD4, $05, nRst, $01, nD4, $05
	dc.b	nRst, $01, nBb3, $05, nRst, $01, nD4, $05, nRst, $01, nF4, $05
	dc.b	nRst, $07, nBb4, $05, nRst, $0D, nA4, $05, nRst, $07, nBb4, $05
	dc.b	nRst, $07, nC4, $11, nRst, $01, nC4, $05, nRst, $0D, nC4, $11
	dc.b	nRst, $01, nEb3, $11, nRst, $01, nF3, $05, nRst, $07, nG3, $05
	dc.b	nRst, $07, nC4, $11, nRst, $01, nC4, $05, nRst, $0D, nC4, $11
	dc.b	nRst, $01, nA3, $05, nRst, $07, nG3, $05, nRst, $01, nA3, $0B
	dc.b	nRst, $01, nG3, $0B, nRst, $01, nF3, $11, nRst, $01, nF3, $05
	dc.b	nRst, $07, nF3, $05, nRst, $01, nD4, $05, nRst, $01, nBb3, $11
	dc.b	nRst, $01, nF4, $05, nRst, $01, nG4, $05, nRst, $01, nF4, $0B
	dc.b	nRst, $01, nEb4, $05, nRst, $01, nD4, $0B, nRst, $01, nF3, $05
	dc.b	nRst, $01, nBb3, $05, nRst, $01, nD4, $05, nRst, $01, nD4, $05
	dc.b	nRst, $01, nBb3, $05, nRst, $01, nD4, $05, nRst, $01, nF4, $05
	dc.b	nRst, $07, nA4, $05, nRst, $01, nF4, $05, nRst, $07, nD4, $17
	dc.b	nRst, $01, nC4, $11, nRst, $01, nC4, $05, nRst, $0D, nC4, $11
	dc.b	nRst, $01, nEb3, $11, nRst, $01, nF3, $05, nRst, $07, nG3, $05
	dc.b	nRst, $07, nC4, $11, nRst, $01, nC4, $05, nRst, $0D, nC4, $11
	dc.b	nRst, $01, nA3, $05, nRst, $07, nG3, $05, nRst, $01, nA3, $0B
	dc.b	nRst, $01, nG3, $0B, nRst, $01, nF3, $11, nRst, $01, nF3, $05
	dc.b	nRst, $07, nF3, $05, nRst, $07, nBb3, $35, nRst, $07, nF3, $05
	dc.b	nRst, $01, nBb3, $05, nRst, $01, nD4, $05, nRst, $01, nD4, $05
	dc.b	nRst, $01, nBb3, $05, nRst, $01, nD4, $05, nRst, $01, nF4, $05
	dc.b	nRst, $07, nBb4, $05, nRst, $0D, nA4, $05, nRst, $07, nBb4, $05
	dc.b	nRst, $07, nC4, $11, nRst, $01, nC4, $05, nRst, $0D, nC4, $11
	dc.b	nRst, $01, nC4, $05, nRst, $0D, nC4, $0B, nRst, $01, nC4, $0B
	dc.b	nRst, $01, nC4, $11, nRst, $01, nC4, $05, nRst, $0D, nC4, $11
	dc.b	nRst, $01, nC4, $05, nRst, $0D, nC4, $0B, nRst, $01, nC4, $0B
	dc.b	nRst, $01, nC4, $5F, nRst, $01, nC4, $2F, nRst, $07, nG3, $05
	dc.b	nRst, $07, nE3, $05, nRst, $07, nG3, $05, nRst, $01, nG3, $0B
	dc.b	nRst, $01
	smpsJump            Snd_CGZ_Jump00

; Unreachable
	smpsStop

; PSG1 Data
Snd_CGZ_PSG1:
	smpsPSGvoice        sTone_04
	smpsAlterNote       $FF

Snd_CGZ_Jump05:
	dc.b	nRst, $60, nRst, nRst, $24, nBb3, $04, nRst, $02, nC4, $04, nRst
	dc.b	$02, nD4, $34, nRst, $08, nD4, $04, nRst, $14, nBb3, $34, nRst
	dc.b	$60, nRst, nRst, $2C, nBb3, $04, nRst, $02, nC4, $04, nRst, $02
	dc.b	nD4, $34, nRst, $08, nD4, $04, nRst, $14, nBb3, $34, nRst, $14
	dc.b	nE4, $04, nRst, $02, nF4, $0A, nRst, $02, nE4, $04, nRst, $02
	dc.b	nF4, $10, nRst, $02, nF3, $04, nRst, $02, nF3, $04, nRst, $02
	dc.b	nF3, $04, nRst, $1A, nC4, $10, nRst, $02, nBb3, $04, nRst, $0E
	dc.b	nBb3, $0A, nRst, $02, nAb3, $10, nRst, $02, nBb3, $10, nRst, $02
	dc.b	nC4, $0A, nRst, $0E, nEb4, $04, nRst, $02, nAb4, $0A, nRst, $02
	dc.b	nEb4, $04, nRst, $02, nAb4, $10, nRst, $02, nEb4, $04, nRst, $02
	dc.b	nEb4, $04, nRst, $02, nEb4, $04, nRst, $1A, nC4, $10, nRst, $02
	dc.b	nC4, $04, nRst, $0E, nF3, $10, nRst, $02, nF3, $04, nRst, $02
	dc.b	nF4, $04, nRst, $02, nF3, $04, nRst, $08, nF3, $04, nRst, $02
	dc.b	nF4, $04, nRst, $14, nE4, $04, nRst, $02, nF4, $0A, nRst, $02
	dc.b	nE4, $04, nRst, $02, nF4, $10, nRst, $02, nF3, $04, nRst, $02
	dc.b	nF3, $04, nRst, $02, nF3, $04, nRst, $1A, nC4, $10, nRst, $02
	dc.b	nBb3, $04, nRst, $0E, nBb3, $0A, nRst, $02, nAb3, $10, nRst, $02
	dc.b	nBb3, $10, nRst, $02, nC4, $0A, nRst, $0E, nEb4, $04, nRst, $02
	dc.b	nBb4, $0A, nRst, $02, nEb4, $04, nRst, $02, nBb4, $10, nRst, $02
	dc.b	nEb4, $04, nRst, $02, nEb4, $04, nRst, $02, nEb4, $04, nRst, $20
	dc.b	nBb3, $04, nRst, $08, nCs4, $04, nRst, $02, nCs4, $04, nRst, $08
	dc.b	nCs4, $04, nRst, $02, nC4, $04, nRst, $32
	smpsPSGvoice        sTone_0A
	dc.b	nF4, $04, nRst, $08, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF4, $04, nRst, $02, nF5, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF4, $04, nRst, $02, nF5, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF4, $04, nRst, $02, nF5, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF4, $04, nRst, $02, nF5, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF4, $04, nRst, $02, nF5, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF4, $04, nRst, $02, nF5, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF4, $04, nRst, $02, nF5, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $26
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF5, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF4, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF5, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF4, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF5, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF4, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF5, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF4, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF5, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF4, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF5, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF4, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF5, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF4, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nE4, $04, nRst, $08
	dc.b	nE5, $04, nRst, $02, nE4, $04, nRst, $08, nE5, $04, nRst, $02
	dc.b	nE5, $04, nRst, $02, nE4, $04, nRst, $32
	smpsJump            Snd_CGZ_Jump05

; Unreachable
	smpsStop

; PSG2 Data
Snd_CGZ_PSG2:
	smpsPSGvoice        sTone_04

Snd_CGZ_Jump04:
	dc.b	nRst, $60, nRst, nRst, $24, nBb3, $04, nRst, $02, nC4, $04, nRst
	dc.b	$02, nD4, $34, nRst, $08, nD4, $04, nRst, $14, nBb3, $34, nRst
	dc.b	$60, nRst, nRst, $2C, nBb3, $04, nRst, $02, nC4, $04, nRst, $02
	dc.b	nD4, $34, nRst, $08, nD4, $04, nRst, $14, nBb3, $34, nRst, $14
	dc.b	nE4, $04, nRst, $02, nF4, $0A, nRst, $02, nE4, $04, nRst, $02
	dc.b	nF4, $10, nRst, $02, nF3, $04, nRst, $02, nF3, $04, nRst, $02
	dc.b	nF3, $04, nRst, $1A, nC4, $10, nRst, $02, nBb3, $04, nRst, $0E
	dc.b	nBb3, $0A, nRst, $02, nAb3, $10, nRst, $02, nBb3, $10, nRst, $02
	dc.b	nC4, $0A, nRst, $0E, nEb4, $04, nRst, $02, nAb4, $0A, nRst, $02
	dc.b	nEb4, $04, nRst, $02, nAb4, $10, nRst, $02, nEb4, $04, nRst, $02
	dc.b	nEb4, $04, nRst, $02, nEb4, $04, nRst, $1A, nC4, $10, nRst, $02
	dc.b	nC4, $04, nRst, $0E, nF3, $10, nRst, $02, nF3, $04, nRst, $02
	dc.b	nF4, $04, nRst, $02, nF3, $04, nRst, $08, nF3, $04, nRst, $02
	dc.b	nF4, $04, nRst, $14, nE4, $04, nRst, $02, nF4, $0A, nRst, $02
	dc.b	nE4, $04, nRst, $02, nF4, $10, nRst, $02, nF3, $04, nRst, $02
	dc.b	nF3, $04, nRst, $02, nF3, $04, nRst, $1A, nC4, $10, nRst, $02
	dc.b	nBb3, $04, nRst, $0E, nBb3, $0A, nRst, $02, nAb3, $10, nRst, $02
	dc.b	nBb3, $10, nRst, $02, nC4, $0A, nRst, $0E, nEb4, $04, nRst, $02
	dc.b	nBb4, $0A, nRst, $02, nEb4, $04, nRst, $02, nBb4, $10, nRst, $02
	dc.b	nEb4, $04, nRst, $02, nEb4, $04, nRst, $02, nEb4, $04, nRst, $20
	dc.b	nBb3, $04, nRst, $08, nCs4, $04, nRst, $02, nCs4, $04, nRst, $08
	dc.b	nCs4, $04, nRst, $02, nC4, $04, nRst, $32
	smpsPSGvoice        sTone_0A
	dc.b	nBb3, $04, nRst, $08, nBb3, $04, nRst, $02, nA3, $04, nRst, $08
	dc.b	nA3, $04, nRst, $02, nBb3, $04, nRst, $38, nBb3, $04, nRst, $08
	dc.b	nBb3, $04, nRst, $02, nA3, $04, nRst, $08, nA3, $04, nRst, $02
	dc.b	nBb3, $04, nRst, $38, nD4, $04, nRst, $08, nC4, $04, nRst, $02
	dc.b	nD4, $04, nRst, $08, nC4, $04, nRst, $08, nD4, $04, nRst, $08
	dc.b	nD4, $04, nRst, $02, nEb4, $04, nRst, $08, nF4, $04, nRst, $08
	dc.b	nBb4, $04, nRst, $02, nF4, $04, nRst, $60, nRst, $02, nBb3, $04
	dc.b	nRst, $08, nBb3, $04, nRst, $02, nA3, $04, nRst, $08, nA3, $04
	dc.b	nRst, $02, nBb3, $04, nRst, $38, nBb3, $04, nRst, $08, nBb3, $04
	dc.b	nRst, $02, nA3, $04, nRst, $08, nA3, $04, nRst, $02, nBb3, $04
	dc.b	nRst, $38, nD4, $04, nRst, $08, nC4, $04, nRst, $02, nD4, $04
	dc.b	nRst, $08, nBb3, $04, nRst, $02, nF4, $04, nRst, $02, nD4, $04
	dc.b	nRst, $60, nRst, $1A, nD3, $04, nRst, $02, nF3, $04, nRst, $02
	dc.b	nBb3, $04, nRst, $02, nC4, $04, nRst, $02, nD4, $0A, nRst, $02
	dc.b	nEb4, $04, nRst, $02, nF4, $04, nRst, $0E, nF4, $10, nRst, $02
	dc.b	nG4, $10, nRst, $02, nA4, $04, nRst, $08, nBb4, $04, nRst, $08
	dc.b	nC5, $0A, nRst, $02, nC5, $04, nRst, $02, nA4, $04, nRst, $08
	dc.b	nA4, $04, nRst, $02, nBb4, $10, nRst, $02, nC5, $04, nRst, $08
	dc.b	nBb4, $04, nRst, $02, nA4, $0A, nRst, $02, nG4, $0A, nRst, $02
	dc.b	nF4, $04, nRst, $08, nD4, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nD4, $0A, nRst, $02, nF4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b	nEb4, $04, nRst, $08, nF4, $04, nRst, $08, nBb4, $04, nRst, $02
	dc.b	nF4, $04, nRst, $38, nBb4, $10, nRst, $02, nC5, $0A, nRst, $02
	dc.b	nD5, $0A, nRst, $02, nEb5, $0A, nRst, $02, nC5, $04, nRst, $02
	dc.b	nAb4, $0A, nRst, $02, nF4, $04, nRst, $02, nBb4, $10, nRst, $02
	dc.b	nBb4, $04, nRst, $0E, nC5, $0A, nRst, $02, nEb5, $0A, nRst, $02
	dc.b	nF5, nG5, $08, nRst, $02, nEb5, $04, nRst, $02, nC5, $0A, nRst
	dc.b	$02, nAb4, $04, nRst, $02, nF4, $10, nRst, $02, nF4, $04, nRst
	dc.b	$1A, nBb3, $04, nRst, $02, nF3, $04, nRst, $02, nC3, $04, nRst
	dc.b	$02, nD3, $04, nRst, $02, nF3, $04, nRst, $02, nG3, $04, nRst
	dc.b	$02, nD3, $04, nRst, $02, nF3, $04, nRst, $02, nG3, $04, nRst
	dc.b	$02, nC4, $04, nRst, $02, nF3, $04, nRst, $02, nG3, $04, nRst
	dc.b	$02, nC4, $04, nRst, $02, nD4, $04, nRst, $02, nG3, $04, nRst
	dc.b	$02, nC4, $04, nRst, $02, nD4, $04, nRst, $02, nF4, $04, nRst
	dc.b	$02, nC3, $04, nRst, $02, nD3, $04, nRst, $02, nE3, $04, nRst
	dc.b	$02, nG3, $04, nRst, $02, nD3, $04, nRst, $02, nE3, $04, nRst
	dc.b	$02, nG3, $04, nRst, $02, nC4, $04, nRst, $32
	smpsJump            Snd_CGZ_Jump04

; Unreachable
	smpsStop

; PSG3 Data
Snd_CGZ_PSG3:
	smpsPSGvoice        sTone_02
	smpsPSGform         $E7

Snd_CGZ_Loop05:
	smpsCall            Snd_CGZ_Call04
	smpsLoop            $01, $20, Snd_CGZ_Loop05

Snd_CGZ_Loop06:
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsLoop            $01, $06, Snd_CGZ_Loop06
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06, nMaxPSG1, $06
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $60, $06

Snd_CGZ_Loop07:
	smpsCall            Snd_CGZ_Call04
	smpsLoop            $01, $1E, Snd_CGZ_Loop07
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $1E

Snd_CGZ_Loop08:
	smpsCall            Snd_CGZ_Call04
	smpsLoop            $01, $1D, Snd_CGZ_Loop08
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $36
	smpsJump            Snd_CGZ_Loop05

; Unreachable
	smpsStop

Snd_CGZ_Call04:
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsReturn

