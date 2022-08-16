Snd_Results_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoiceUVB
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $25

	smpsHeaderDAC       Snd_Results_DAC
	smpsHeaderFM        Snd_Results_FM1,	$0C, $12
	smpsHeaderFM        Snd_Results_FM2,	$0C, $16
	smpsHeaderFM        Snd_Results_FM3,	$0C, $16
	smpsHeaderFM        Snd_Results_FM4,	$0C, $16
	smpsHeaderFM        Snd_Results_FM5,	$0C, $1A
	smpsHeaderPSG       Snd_Results_PSG1,	$00, $03, $00, sTone_0C
	smpsHeaderPSG       Snd_Results_PSG2,	$00, $03, $00, sTone_0C
	smpsHeaderPSG       Snd_Results_PSG3,	$00, $05, $00, sTone_0C

; Unreachable
	smpsStop
	smpsStop

; DAC Data
Snd_Results_DAC:
	dc.b	dSnareS3, $06, dKickS3, dKickS3, dSnareS3, dKickS3, dKickS3, dSnareS3, dKickS3, dSnareS3, dKickS3, dKickS3
	dc.b	dSnareS3, dKickS3, dKickS3, dSnareS3, dKickS3, $01, nRst, dKickS3, dKickS3, nRst, dKickS3, dHighTom
	dc.b	$06, dMidTomS3, dLowTomS3, dHighTom, dMidTomS3, dLowTomS3, dHighTom, dMidTomS3, dLowTomS3, dSnareS3
	smpsStop

; FM1 Data
Snd_Results_FM1:
	smpsSetvoice        $15
	dc.b	nG0, $05, nRst, $01, nG1, $05, nRst, $01, nG0, $05, nRst, $01
	dc.b	nD1, $05, nRst, $07, nG1, $05, nRst, $01, nG0, $05, nRst, $07
	dc.b	nA0, $05, nRst, $01, nA1, $05, nRst, $01, nA0, $05, nRst, $01
	dc.b	nE1, $05, nRst, $07, nA1, $05, nRst, $01, nA0, $05, nRst, $07
	dc.b	nD1, $05, nRst, $01, nD2, $05, nRst, $01, nD1, $05, nRst, $01
	dc.b	nE1, $05, nRst, $01, nE2, $05, nRst, $01, nE1, $05, nRst, $01
	dc.b	nG1, $05, nRst, $01, nG2, $05, nRst, $01, nG1, $05, nRst, $01
	dc.b	nA1, $5F, nRst, $01
	smpsStop

; FM2 Data
Snd_Results_FM2:
	smpsAlterNote       $03
	smpsSetvoice        $08

Snd_Results_Jump00:
	dc.b	nD3, $06, nD3, nD3, nD3, $07, nRst, $05, nD3, $07, nRst, $05
	dc.b	nE3, $05, nRst, $07, nE3, $05, nRst, $07, nE3, $07, nRst, $05
	dc.b	nE3, $11, nRst, $01, nG3, $05, nRst, $0D, nA3, $05, nRst, $0D
	dc.b	nC4, $11, nRst, $01, nD4, $5F, nRst, $01
	smpsStop

; FM3 Data
Snd_Results_FM3:
	smpsAlterNote       $FF
	smpsSetvoice        $01
	dc.b	nC3, $06, nC3, nC3, nB2, nRst, nB2, nRst, nD3, nRst, $06, nD3
	dc.b	$06, nRst, $06, nCs3, $06, nRst, nCs3, $11, nRst, $01, nE3, $05
	dc.b	nRst, $0D, nFs3, $05, nRst, $0D, nA3, $11, nRst, $01, nB3, $5F
	dc.b	nRst, $01
	smpsStop

; FM4 Data
Snd_Results_FM4:
	smpsAlterNote       $01
	smpsSetvoice        $01

Snd_Results_Jump01:
	dc.b	nG2, $06, nG2, nG2, nG2, nRst, nG2, nRst, nA2, nRst, nA2, $03
	dc.b	nRst, $09, nA2, $05, nRst, $07, nA2, $11, nRst, $01, nC3, $05
	dc.b	nRst, $0D, nD3, $05, nRst, $0D, nF3, $11, nRst, $01, nG3, $5F
	dc.b	nRst, $01
	smpsStop

; FM5 Data
Snd_Results_FM5:
	smpsAlterNote       $FD
	smpsPSGvoice        sTone_03
	dc.b	nRst, $01
	smpsSetvoice        $01
	smpsJump            Snd_Results_Jump00

; Unreachable
	smpsStop

; PSG1 Data
Snd_Results_PSG1:
	smpsAlterNote       $01
	smpsPSGvoice        sTone_03
	smpsJump            Snd_Results_Jump00

; Unreachable
	smpsSetvoice        sTone_01
	dc.b	nD3, $06, nD3, nD3, nD3, $05, nRst, $07, nD3, $05, nRst, $07
	dc.b	nE3, $03, nRst, $09, nE3, $03, nRst, $09, nE3, $05, nRst, $07
	dc.b	nE3, $11, nRst, $01, nG3, $05, nRst, $0D, nA3, $05, nRst, $0D
	dc.b	nC4, $11, nRst, $01, nD4, $5F, nRst, $01
	smpsStop

; PSG2 Data
Snd_Results_PSG2:
	smpsAlterNote       $FF
	smpsSetvoice        sTone_01
	smpsPSGvoice        sTone_03
	smpsJump            Snd_Results_Jump01

; Unreachable
	smpsStop

; PSG3 Data
Snd_Results_PSG3:
	smpsPSGvoice        sTone_02
	smpsPSGform         $E7
	dc.b	nMaxPSG2, $06, nMaxPSG2, nMaxPSG2, nMaxPSG2, $05, nRst, $07, nMaxPSG2, $05, nRst, $07
	dc.b	nMaxPSG2, $03, nRst, $09, nMaxPSG2, $03, nRst, $09, nMaxPSG2, $05, nRst, $07
	dc.b	nMaxPSG2, $11, nRst, $01, nMaxPSG2, $05, nRst, $0D, nMaxPSG2, $05, nRst, $0D
	dc.b	nMaxPSG2, $11, nRst, $01, nMaxPSG2, $5F, nRst, $01
	smpsStop

