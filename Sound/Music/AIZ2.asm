Snd_AIZ2_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoiceUVB
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $15

	smpsHeaderDAC       Snd_AIZ2_DAC
	smpsHeaderFM        Snd_AIZ2_FM1,	$18, $0F
	smpsHeaderFM        Snd_AIZ2_FM2,	$0C, $13
	smpsHeaderFM        Snd_AIZ2_FM3,	$0C, $13
	smpsHeaderFM        Snd_AIZ2_FM4,	$0C, $13
	smpsHeaderFM        Snd_AIZ2_FM5,	$0C, $13
	smpsHeaderPSG       Snd_AIZ2_PSG1,	$F4, $04, $00, sTone_0C
	smpsHeaderPSG       Snd_AIZ2_PSG2,	$F4, $04, $00, sTone_0C
	smpsHeaderPSG       Snd_AIZ2_PSG3,	$00, $03, $00, sTone_0C

; Unreachable
	smpsStop
	smpsStop

Snd_AIZ2_Call00:
	dc.b	dKickS3, $0C, dKickS3, dSnareS3, dKickS3, $06, dSnareS3, $0C, dSnareS3, $06, dKickS3, $0C
	dc.b	dSnareS3, dKickS3, dKickS3, dKickS3, dSnareS3, dKickS3, $06, dSnareS3, $0C, dSnareS3, $06, dKickS3
	dc.b	dSnareS3, dSnareS3, $0C, dKickS3, $06, dSnareS3
	smpsReturn

Snd_AIZ2_Call01:
	dc.b	dKickS3, $0C, dKickS3, dSnareS3, dKickS3, $06, dSnareS3, $0C, dSnareS3, $06, dKickS3, $0C
	dc.b	dSnareS3, dKickS3
	smpsReturn

; DAC Data
Snd_AIZ2_DAC:
	smpsCall            Snd_AIZ2_Call00
	smpsLoop            $01, $03, Snd_AIZ2_DAC
	smpsCall            Snd_AIZ2_Call01
	dc.b	dKickS3, dKickS3, dSnareS3, dKickS3, $06, dSnareS3, $0C, dSnareS3, $06, dKickS3, dSnareS3, dSnareS3
	dc.b	dSnareS3, dMidTomS3, $0C

Snd_AIZ2_Loop00:
	smpsCall            Snd_AIZ2_Call00
	smpsLoop            $01, $03, Snd_AIZ2_Loop00
	smpsCall            Snd_AIZ2_Call01
	dc.b	dKickS3, $18, dKickS3, $15, dSnareS3, $02, dSnareS3, $01, dSnareS3, $06, dSnareS3, $0C
	dc.b	dSnareS3, dSnareS3, $06, dSnareS3, $0C

Snd_AIZ2_Loop01:
	smpsCall            Snd_AIZ2_Call00
	smpsLoop            $01, $03, Snd_AIZ2_Loop01
	smpsCall            Snd_AIZ2_Call01
	dc.b	dKickS3, $06, dSnareS3, $0C, dSnareS3, $06, dMidTomS3, $0C, dKickS3, $06, dSnareS3, $0C
	dc.b	dSnareS3, $06, dHighTom, $0C, dSnareS3, $06, dSnareS3, dFloorTomS3, dSnareS3
	smpsCall            Snd_AIZ2_Call01
	dc.b	dKickS3, dKickS3, dSnareS3, dKickS3, $06, dSnareS3, $0C, dSnareS3, $06, dKickS3, dSnareS3, dSnareS3
	dc.b	$0C, dKickS3, $06, dSnareS3
	smpsCall            Snd_AIZ2_Call01
	dc.b	dKickS3, dKickS3, dSnareS3, dKickS3, $06, dSnareS3, $0C, dSnareS3, $06, dKickS3, dSnareS3, dSnareS3
	dc.b	dSnareS3, dMidTomS3, $0C
	smpsCall            Snd_AIZ2_Call01
	dc.b	dKickS3, dKickS3, dSnareS3, dKickS3, $06, dSnareS3, $0C, dSnareS3, $06, dKickS3, dSnareS3, dSnareS3
	dc.b	$0C, dKickS3, $06, dSnareS3
	smpsCall            Snd_AIZ2_Call01
	dc.b	dKickS3, dKickS3, dSnareS3, $06, dSnareS3, dKickS3, dSnareS3, $0C, dSnareS3, $06, dKickS3, dSnareS3
	dc.b	dSnareS3, dSnareS3, dSnareS3, dSnareS3
	smpsCall            Snd_AIZ2_Call01
	dc.b	dKickS3, dKickS3, dSnareS3, dKickS3, $06, dSnareS3, $0C, dSnareS3, $06, dKickS3, dSnareS3, dSnareS3
	dc.b	$0C, dKickS3, $06, dSnareS3
	smpsCall            Snd_AIZ2_Call01
	dc.b	dKickS3, dKickS3, dSnareS3, $06, dKickS3, $0C, dKickS3, $06, dHighTom, dMidTomS3, $0C, dFloorTomS3
	dc.b	$06, dSnareS3, dSnareS3, dMidTomS3, $0C
	smpsJump            Snd_AIZ2_DAC

; Unreachable
	smpsStop

; FM1 Data
Snd_AIZ2_FM1:
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nC1, $0C
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nC2, $03, nRst, $09
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nA0, $0C
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nA1, $03, nRst
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nBb0, $0C, nBb0, $03, nRst, nA0, $0C, nBb0, nG0, nC1
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nC2, $03, nRst, $09
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nA0, $0C
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nA1, $03, nRst
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nBb0, $0C, nF0, $06, nRst
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nF1, $03, nRst, $09
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nG0, $06
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nG1, $0C
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nC1
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nC2, $03, nRst, $09
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nA0, $0C
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nA1, $03, nRst
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nBb0, $0C, nBb0, $03, nRst, nA0, $0C, nBb0, nG0, nC1
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nC2, $03, nRst, $09
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nA0, $0C
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nA1, $03, nRst
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nBb0, $0C, nF0, $06, nRst
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nF1, $03, nRst, $09
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nG0, $06
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nG1, $0C
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nC1
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nC2, $03, nRst, $09
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nA0, $0C
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nA1, $03, nRst
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nBb0, $0C, nBb0, $03, nRst, nA0, $0C, nBb0, nG0, nC1
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nC2, $03, nRst, $09
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nA0, $0C
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nA1, $03, nRst
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nBb0, $0C, nF0, $06, nRst
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nF1, $03, nRst, $09
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nG0, $06
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nG1, $0C
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nC1
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nC2, $03, nRst, $09
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nA0, $0C
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nA1, $03, nRst
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nBb0, $0C, nBb0, $03, nRst, nA0, $0C, nBb0, nG0, nF0, $06
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nF1, $03, nRst, $09
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nF0, $0C
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nF1, $03, nRst
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nG0, $0C, nRst, $06
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	dc.b	nG1
	smpsSetvoice        $15
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nF1, nEb1, nF1, nEb1, nD1, nBb0, nC1, $18, nEb1, $12, nF1, $0C
	dc.b	nEb1, $03, nRst, nF1, $0C, nG1, nEb1, nC1, $18, nEb1, $12, nF1
	dc.b	$0C, nEb1, $03, nRst, nF1, $0C, nG1, nBb1, nC1, $18, nEb1, $12
	dc.b	nF1, $0C, nEb1, $03, nRst, nF1, $0C, nG1, nEb1, nC1, $18, nEb1
	dc.b	$12, nF1, $0C, nEb1, $03, nRst, nF1, $0C, nG0, nBb0, nC1, $18
	dc.b	nEb1, $12, nF1, $0C, nEb1, $03, nRst, nF1, $0C, nG1, nEb1, nC1
	dc.b	$18, nEb1, $12, nF1, $0C, nEb1, $03, nRst, nF1, $0C, nG1, nBb1
	dc.b	nC1, $18, nEb1, $12, nF1, $0C, nEb1, $03, nRst, nF1, $0C, nF1
	dc.b	nEb1, nG0, $18, nD1, $12, nF1, $0C, nFs1, $03, nRst, nG1, $0C
	dc.b	nG0, $18, nC1, nC1, $12, nEb1, $0C, nC1, $03, nRst, nEb1, $0C
	dc.b	nF1, nG1, nF0, $18, nF0, $12, nG0, $0C, nF0, $03, nRst, nG0
	dc.b	$0C, nBb0, nB0, nC1, $18, nC1, $12, nEb1, $0C, nC1, $03, nRst
	dc.b	nEb1, $0C, nF1, nG1, nF0, $18, nF0, $12, nG0, $0C, nF0, $03
	dc.b	nRst, nG0, $0C, nBb0, nB0, nC1, $18, nC1, $12, nEb1, $0C, nC1
	dc.b	$03, nRst, nEb1, $0C, nF1, nG1, nF0, $18, nF0, $12, nG0, $0C
	dc.b	nF0, $03, nRst, nG0, $0C, nBb0, nB0, nC1, $18, nC1, $12, nEb1
	dc.b	$0C, nC1, $03, nRst, nEb1, $0C, nF1, nG1, nF0, $12, nF1, $03
	dc.b	nRst, $09, nF0, $06, nG0, $18, nG1, $03, nRst, $09, nFs0, $0C
	dc.b	nFs1, $03, nRst, $09, nF0, $18, nF0, $12, nF0, $0C, nF0, $03
	dc.b	nRst, nC1, $0C, nF1, nF0, nG0, $18, nG0, $12, nG0, $0C, nG0
	dc.b	$03, nRst, nD1, $0C, nG1, nG0, nC1, nG0, nBb0, nG0, $06, nC1
	dc.b	$0C, nC1, $06, nG0, $0C, nBb0, nG0, nC1, nG0, nBb0, nG0, $06
	dc.b	nC1, $0C, nC1, $06, nG0, $0C, nBb0, nG0, nF0, $18, nF0, $12
	dc.b	nF0, $0C, nF0, $03, nRst, nC1, $0C, nF1, nF0, nG0, $18, nG0
	dc.b	$12, nG0, $0C, nG0, $03, nRst, nD1, $0C, nG1, nG0, nC1, nG0
	dc.b	nBb0, nG0, $06, nC1, $0C, nC1, $06, nG0, $0C, nBb0, nG0, nC1
	dc.b	nC1, nEb1, nEb1, $06, nF1, $0C, nEb1, $06, nF1, $0C, nG0, nFs0
	dc.b	nF0, $18, nF0, $12, nF0, $0C, nF0, $03, nRst, nC1, $0C, nF1
	dc.b	nF0, nG0, $18, nG0, $12, nG0, $0C, nG0, $03, nRst, nD1, $0C
	dc.b	nG1, nG0, nAb0, $18, nAb0, $12, nAb0, $0C, nAb0, $03, nRst, nEb1
	dc.b	$0C, nAb1, nAb0, nBb0, $18, nBb0, $12, nBb0, $0C, nBb0, $03, nRst
	dc.b	nD1, $0C, nEb1, nF1
	smpsJump            Snd_AIZ2_FM1

; Unreachable
	smpsStop

; FM2 Data
Snd_AIZ2_FM2:
	dc.b	nRst, $0C
	smpsSetvoice        $12
	smpsAlterNote       $03
	smpsModSet          $00, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nG3, $06, nRst, $0C, nA3, $06, nRst, $0C, nBb3, $06, nRst, $36
	smpsSetvoice        $06
	smpsAlterNote       $03
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panCenter, $00
	dc.b	nC4, $06, nRst, $12, nD3, $06, nC3, $06, nRst, $30
	smpsSetvoice        $12
	smpsAlterNote       $03
	smpsModSet          $00, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nRst, $0C, nBb3, $06, nRst, $0C, nA3, $06, nRst, $0C, nG3, $06
	dc.b	nRst, $2A
	smpsSetvoice        $06
	smpsAlterNote       $03
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panCenter, $00
	dc.b	nRst, $30, nF3, $06, nA3, $06, nF4, $06, nEb4, $1D, nRst, $01
	smpsSetvoice        $12
	smpsAlterNote       $03
	smpsModSet          $00, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nRst, $0C, nG3, $06, nRst, $0C, nA3, $06, nRst, $0C, nBb3, $06
	dc.b	nRst, $2A
	smpsSetvoice        $06
	smpsAlterNote       $03
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panCenter, $00
	dc.b	nRst, $0C, nC4, $06, nRst, $12, nD3, $06, nC3, $06, nRst, $30
	smpsSetvoice        $12
	smpsAlterNote       $03
	smpsModSet          $00, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nRst, $0C, nBb3, $06, nRst, $0C, nA3, $06, nRst, $0C, nG3, $06
	dc.b	nRst, $2A
	smpsSetvoice        $06
	smpsAlterNote       $03
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panCenter, $00
	dc.b	nA3, $06, nRst, $0C, nA3, $06, nRst, $0C, nB3, $17, nRst, $01
	smpsSetvoice        $17
	smpsAlterNote       $01
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panCenter, $00
	dc.b	nEb2, $0B, nRst, $01, nG2, $0B, nRst, $01, nEb3, $0B, nRst, $01
	dc.b	nD3, $05, nRst, $0D, nBb2, $05, nRst, $0D, nG2, $3B, nRst, $3D
	smpsSetvoice        $17
	smpsAlterNote       $01
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panCenter, $00
	dc.b	nEb2, $0B, nRst, $01, nG2, $0B, nRst, $01, nEb3, $0B, nRst, $01
	dc.b	nD3, $05, nRst, $0D, nBb2, $05, nRst, $0D, nC3, $3B, nRst, $3D
	smpsSetvoice        $17
	smpsAlterNote       $01
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panCenter, $00
	dc.b	nEb2, $0B, nRst, $01, nG2, $0B, nRst, $01, nEb3, $0B, nRst, $01
	dc.b	nD3, $05, nRst, $0D, nBb2, $05, nRst, $0D, nG2, $3B, nRst, $31
	smpsSetvoice        $17
	smpsAlterNote       $01
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panCenter, $00
	dc.b	nRst, $0C, nEb2, $0B, nRst, $01, nG2, $0B, nRst, $01, nEb3, $0B
	dc.b	nRst, $01, nD3, $05, nRst, $0D, nBb2, $05, nRst, $0D, nC3, $3B
	dc.b	nRst, $01
	smpsSetvoice        $17
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nRst, $0C, nA3, $05, nRst, $01, nB3, $05, nRst, $07, nB3, $06
	dc.b	nB3, $06, nB3, $06, nB3, $06, nRst, $06, nC4, $05, nRst, $01
	dc.b	nB3, $1D, nRst, $0D, nBb3, $0B, nRst, $01, nBb3, $0B, nRst, $0D
	dc.b	nA3, $05, nRst, $0D, nBb3, $05, nRst, $19, nC3, $05, nRst, $01
	dc.b	nG3, $05, nRst, $01, nC4, $05, nRst, $01, nBb3, $05, nRst, $07
	dc.b	nBb3, $05, nRst, $07, nA3, $05, nRst, $07, nA3, $05, nRst, $07
	dc.b	nF3, $05, nRst, $01, nC3, $05, nRst, $1F, nBb3, $0B, nRst, $01
	dc.b	nBb3, $0B, nRst, $0D, nA3, $05, nRst, $0D, nBb3, $05, nRst, $19
	dc.b	nC3, $05, nRst, $01, nG3, $05, nRst, $01, nC4, $05, nRst, $01
	dc.b	nBb3, $05, nRst, $07, nBb3, $05, nRst, $07, nA3, $05, nRst, $07
	dc.b	nA3, $05, nRst, $07, nBb3, $05, nRst, $01, nC4, $05, nRst, $1F
	dc.b	nBb3, $0B, nRst, $01, nBb3, $0B, nRst, $0D, nA3, $05, nRst, $0D
	dc.b	nBb3, $05, nRst, $19, nC3, $05, nRst, $01, nG3, $05, nRst, $01
	dc.b	nC4, $05, nRst, $01, nBb3, $05, nRst, $07, nBb3, $05, nRst, $07
	dc.b	nA3, $05, nRst, $07, nA3, $05, nRst, $07, nF3, $05, nRst, $01
	dc.b	nC3, $05, nRst, $1F, nBb3, $0B, nRst, $01, nBb3, $0B, nRst, $0D
	dc.b	nA3, $05, nRst, $0D, nBb3, $05, nRst, $19, nC3, $05, nRst, $01
	dc.b	nG3, $05, nRst, $01, nC4, $05, nRst, $01, nBb3, $05, nRst, $07
	dc.b	nBb3, $05, nRst, $07, nA3, $05, nRst, $07
	smpsSetvoice        $06
	smpsAlterNote       $03
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panCenter, $00
	dc.b	nA3, $06, nBb3, $06, nC4, $06, nEb4, $06, nD4, $06, nBb3, $06
	dc.b	nC4, $06
	smpsSetvoice        $12
	smpsAlterNote       $03
	smpsModSet          $00, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nRst, $0C, nAb3, $0B, nRst, $01, nC4, $0B, nRst, $01, nG4, $0B
	dc.b	nRst, $01, nF4, $05, nRst, $0D, nEb4, $05, nRst, $0D, nD4, $05
	dc.b	nRst, $07

Snd_AIZ2_Loop0B:
	dc.b	nB3, $03, nRst, $01
	smpsLoop            $00, $09, Snd_AIZ2_Loop0B
	dc.b	nG3, $05, nRst, $07, nB3, $05, nRst, $0D, nC4, $05, nRst, $0D
	dc.b	nD4, $05, nRst, $07

Snd_AIZ2_Loop0C:
	dc.b	nEb4, $03, nRst, $01
	smpsLoop            $00, $0C, Snd_AIZ2_Loop0C

Snd_AIZ2_Loop0D:
	dc.b	nD4, $03, nRst, $01
	smpsLoop            $00, $0C, Snd_AIZ2_Loop0D

Snd_AIZ2_Loop0E:
	dc.b	nC4, $03, nRst, $01
	smpsLoop            $00, $0C, Snd_AIZ2_Loop0E

Snd_AIZ2_Loop0F:
	dc.b	nG3, $03, nRst, $01
	smpsLoop            $00, $0B, Snd_AIZ2_Loop0F
	dc.b	nG3, $03, nRst, $0D, nAb3, $0B, nRst, $01, nC4, $0B, nRst, $01
	dc.b	nG4, $0B, nRst, $01, nF4, $05, nRst, $0D, nEb4, $05, nRst, $0D
	dc.b	nD4, $05, nRst, $07

Snd_AIZ2_Loop10:
	dc.b	nB3, $03, nRst, $01
	smpsLoop            $00, $09, Snd_AIZ2_Loop10
	dc.b	nG3, $05, nRst, $07, nB3, $05, nRst, $0D, nC4, $05, nRst, $0D
	dc.b	nD4, $05, nRst, $07

Snd_AIZ2_Loop11:
	dc.b	nEb4, $03, nRst, $01
	smpsLoop            $00, $09, Snd_AIZ2_Loop11
	dc.b	nD4, $05, nRst, $01, nEb4, $05, nRst, $01

Snd_AIZ2_Loop12:
	dc.b	nF4, $03, nRst, $01
	smpsLoop            $00, $09, Snd_AIZ2_Loop12
	dc.b	nEb4, $05, nRst, $01, nF4, $05, nRst, $01

Snd_AIZ2_Loop13:
	dc.b	nG4, $03, nRst, $01
	smpsLoop            $00, $15, Snd_AIZ2_Loop13
	dc.b	nG4, $03, nRst, $2D, nF3, $05, nRst, $01, nG3, $05, nRst, $01
	dc.b	nAb3, $05, nRst, $0D, nBb3, $05, nRst, $0D, nC4, $05, nRst, $2B
	dc.b	nG3, $05, nRst, $01, nAb3, $05, nRst, $01, nBb3, $05, nRst, $0D
	dc.b	nC4, $05, nRst, $0D, nD4, $05, nRst, $07, nAb2, $05, nRst, $01
	dc.b	nC3, $05, nRst, $01, nEb3, $05, nRst, $01, nAb3, $05, nRst, $01
	dc.b	nEb3, $05, nRst, $01, nAb3, $05, nRst, $01, nC4, $05, nRst, $01
	dc.b	nEb4, $05, nRst, $01, nC4, $05, nRst, $01, nEb4, $05, nRst, $01
	dc.b	nAb4, $05, nRst, $01, nC5, $05, nRst, $01, nAb4, $05, nRst, $01
	dc.b	nC5, $05, nRst, $01, nEb5, $05, nRst, $01, nAb5, $05, nRst, $01
	dc.b	nRst, $60
	smpsJump            Snd_AIZ2_FM2

; Unreachable
	smpsStop

; FM3 Data
Snd_AIZ2_FM3:
	smpsSetvoice        $12
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panLeft, $00
	dc.b	nRst, $0C, nEb3, $06, nRst, $0C, nF3, $06, nRst, $0C, nG3, $06
	dc.b	nRst, $36
	smpsSetvoice        $06
	smpsAlterNote       $FD
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panCenter, $00
	dc.b	nG3, $06, nRst, $12, nF2, $06, nG2, $06, nRst, $30
	smpsSetvoice        $12
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panLeft, $00
	dc.b	nRst, $0C, nG3, $06, nRst, $0C, nF3, $06, nRst, $0C, nEb3, $06
	dc.b	nRst, $2A
	smpsSetvoice        $06
	smpsAlterNote       $FD
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panCenter, $00
	dc.b	nRst, $30, nD3, $06, nF3, $06, nD4, $06, nC4, $1D, nRst, $01
	smpsSetvoice        $12
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panLeft, $00
	dc.b	nRst, $0C, nEb3, $06, nRst, $0C, nF3, $06, nRst, $0C, nG3, $06
	dc.b	nRst, $2A
	smpsSetvoice        $06
	smpsAlterNote       $FD
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panCenter, $00
	dc.b	nRst, $0C, nG3, $06, nRst, $12, nF2, $06, nG2, $06, nRst, $30
	smpsSetvoice        $12
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panLeft, $00
	dc.b	nRst, $0C, nG3, $06, nRst, $0C, nF3, $06, nRst, $0C, nEb3, $06
	dc.b	nRst, $2A
	smpsSetvoice        $06
	smpsAlterNote       $FD
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panCenter, $00
	dc.b	nF3, $06, nRst, $0C, nF3, $06, nRst, $0C, nG3, $17, nRst, $01
	smpsSetvoice        $17
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nEb2, $0B, nRst, $01, nG2, $0B, nRst, $01, nEb3, $0B, nRst, $01
	dc.b	nD3, $05, nRst, $0D, nBb2, $05, nRst, $0D, nG2, $3B, nRst, $31
	smpsSetvoice        $17
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nRst, $0C, nEb2, $0B, nRst, $01, nG2, $0B, nRst, $01, nEb3, $0B
	dc.b	nRst, $01, nD3, $05, nRst, $0D, nBb2, $05, nRst, $0D, nC3, $3B
	dc.b	nRst, $3D
	smpsSetvoice        $17
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nEb2, $0B, nRst, $01, nG2, $0B, nRst, $01, nEb3, $0B, nRst, $01
	dc.b	nD3, $05, nRst, $0D, nBb2, $05, nRst, $0D, nG2, $3B, nRst, $3D
	smpsSetvoice        $17
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nEb2, $0B, nRst, $01, nG2, $0B, nRst, $01, nEb3, $0B, nRst, $01
	dc.b	nD3, $05, nRst, $0D, nBb2, $05, nRst, $0D, nC3, $3B, nRst, $01
	smpsSetvoice        $17
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nRst, $0C, nCs4, $05, nRst, $01, nD4, $05, nRst, $07, nD4, $06
	dc.b	nD4, $06, nD4, $06, nD4, $06, nRst, $06, nEb4, $05, nRst, $01
	dc.b	nD4, $1D, nRst, $0D, nG3, $0B, nRst, $01, nG3, $0B, nRst, $0D
	dc.b	nF3, $05, nRst, $0D, nG3, $05, nRst, $19
	smpsSetvoice        $17
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nC5, $05, nRst, $07, nA4, $05, nRst, $01, nBb4, $05, nRst, $07
	dc.b	nG4, $05, nRst, $07, nC5, $05, nRst, $07, nA4, $05, nRst, $01
	dc.b	nBb4, $05, nRst, $07, nG4, $05, nRst, $1F, nG3, $0B, nRst, $01
	dc.b	nG3, $0B, nRst, $0D, nF3, $05, nRst, $0D, nG3, $05, nRst, $19
	smpsSetvoice        $17
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nC5, $05, nRst, $07, nA4, $05, nRst, $01, nBb4, $05, nRst, $07
	dc.b	nG4, $05, nRst, $07, nC5, $05, nRst, $07, nA4, $05, nRst, $01
	dc.b	nBb4, $05, nRst, $07, nG4, $05, nRst, $1F, nG3, $0B, nRst, $01
	dc.b	nG3, $0B, nRst, $0D, nF3, $05, nRst, $0D, nG3, $05, nRst, $19
	smpsSetvoice        $17
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nC5, $05, nRst, $07, nA4, $05, nRst, $01, nBb4, $05, nRst, $07
	dc.b	nG4, $05, nRst, $07, nC5, $05, nRst, $07, nA4, $05, nRst, $01
	dc.b	nBb4, $05, nRst, $07, nG4, $05, nRst, $1F, nG3, $0B, nRst, $01
	dc.b	nG3, $0B, nRst, $0D, nF3, $05, nRst, $0D, nG3, $05, nRst, $4F
	dc.b	nF3, $06, nG3, $06, nA3, $06, nC4, $06, nBb3, $06, nG3, $06
	dc.b	nA3, $06
	smpsSetvoice        $12
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panLeft, $00
	dc.b	nRst, $0C, nAb3, $0B, nRst, $01, nC4, $0B, nRst, $01, nG4, $0B
	dc.b	nRst, $01, nF4, $05, nRst, $0D, nEb4, $05, nRst, $0D, nD4, $05
	dc.b	nRst, $07

Snd_AIZ2_Loop02:
	dc.b	nB3, $03, nRst, $01
	smpsLoop            $00, $09, Snd_AIZ2_Loop02
	dc.b	nG3, $05, nRst, $07, nB3, $05, nRst, $0D, nC4, $05, nRst, $0D
	dc.b	nD4, $05, nRst, $07

Snd_AIZ2_Loop03:
	dc.b	nEb4, $03, nRst, $01
	smpsLoop            $00, $0C, Snd_AIZ2_Loop03

Snd_AIZ2_Loop04:
	dc.b	nD4, $03, nRst, $01
	smpsLoop            $00, $0C, Snd_AIZ2_Loop04

Snd_AIZ2_Loop05:
	dc.b	nC4, $03, nRst, $01
	smpsLoop            $00, $0C, Snd_AIZ2_Loop05

Snd_AIZ2_Loop06:
	dc.b	nG3, $03, nRst, $01
	smpsLoop            $00, $0B, Snd_AIZ2_Loop06
	dc.b	nG3, $03, nRst, $0D, nAb3, $0B, nRst, $01, nC4, $0B, nRst, $01
	dc.b	nG4, $0B, nRst, $01, nF4, $05, nRst, $0D, nEb4, $05, nRst, $0D
	dc.b	nD4, $05, nRst, $07

Snd_AIZ2_Loop07:
	dc.b	nB3, $03, nRst, $01
	smpsLoop            $00, $09, Snd_AIZ2_Loop07
	dc.b	nG3, $05, nRst, $07, nB3, $05, nRst, $0D, nC4, $05, nRst, $0D
	dc.b	nD4, $05, nRst, $07

Snd_AIZ2_Loop08:
	dc.b	nEb4, $03, nRst, $01
	smpsLoop            $00, $09, Snd_AIZ2_Loop08
	dc.b	nD4, $05, nRst, $01, nEb4, $05, nRst, $01

Snd_AIZ2_Loop09:
	dc.b	nF4, $03, nRst, $01
	smpsLoop            $00, $09, Snd_AIZ2_Loop09
	dc.b	nEb4, $05, nRst, $01, nF4, $05, nRst, $01

Snd_AIZ2_Loop0A:
	dc.b	nG4, $03, nRst, $01
	smpsLoop            $00, $15, Snd_AIZ2_Loop0A
	dc.b	nG4, $03, nRst, $2D, nD3, $05, nRst, $01, nEb3, $05, nRst, $01
	dc.b	nF3, $05, nRst, $0D, nG3, $05, nRst, $0D, nAb3, $05, nRst, $2B
	dc.b	nEb3, $05, nRst, $01, nF3, $05, nRst, $01, nG3, $05, nRst, $0D
	dc.b	nAb3, $05, nRst, $0D, nBb3, $05, nRst, $07
	smpsSetvoice        $10
	smpsAlterNote       $FD
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panCenter, $00
	dc.b	nC5, $23, nRst, $01, nC5, $05, nRst, $01, nD5, $05, nRst, $01
	dc.b	nEb5, $11, nRst, $01, nD5, $11, nRst, $01, nC5, $0B, nRst, $01
	dc.b	nG5, $60
	smpsJump            Snd_AIZ2_FM3

; Unreachable
	smpsStop

; FM4 Data
Snd_AIZ2_FM4:
	smpsSetvoice        $16
	smpsAlterNote       $FF
	smpsModSet          $0A, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nRst, $0C, nG3, nRst, $06, nG3, $0C, nRst, $06, nG3, $0C, nRst
	dc.b	$06, nG3, $0C, nRst, $06, nG3, $0C, nRst, $60
	smpsSetvoice        $16
	smpsAlterNote       $FF
	smpsModSet          $0A, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nRst, $0C, nG3, nRst, $06, nG3, $0C, nRst, nA3, $03, nRst, $09
	dc.b	nG3, $06, nRst, $0C, nF3
	smpsSetvoice        $17
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nC4, $01, nRst, $05, nC4, $01, nRst, $05, nC5, $01, nRst, $05
	dc.b	nC4, $01, nRst, $05, nBb4, $01, nRst, $05, nC4, $01, nRst, $05
	dc.b	nBb4, $01, nRst, $05, nC5, $01, nRst, $35
	smpsSetvoice        $16
	smpsAlterNote       $FF
	smpsModSet          $0A, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nRst, $0C, nG3, nRst, $06, nG3, $0C, nRst, $06, nG3, $0C, nRst
	dc.b	$06, nG3, $0C, nRst, $06, nG3, $0C, nRst, $60
	smpsSetvoice        $16
	smpsAlterNote       $FF
	smpsModSet          $0A, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nRst, $0C, nG3, nRst, $06, nG3, $0C, nRst, nA3, $03, nRst, $09
	dc.b	nG3, $06, nRst, $0C, nF3, nRst, $60
	smpsFMAlterVol      $08
	smpsSetvoice        $16
	smpsAlterNote       $FF
	smpsModSet          $0A, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nRst, $0C, nEb3, nRst, $06, nEb3, $0C, nRst, $06, nF3, $0C, nRst
	dc.b	$06, nF3, $0C, nRst, $06, nF3, $0C, nRst, nG3, nRst, $06, nG3
	dc.b	$0C, nRst, $06, nF3, $0C, nRst, $06, nF3, $0C, nRst, $06, nF3
	dc.b	$0C, nRst, nEb3, nRst, $06, nEb3, $0C, nRst, $06, nF3, $0C, nRst
	dc.b	$06, nF3, $0C, nRst, $06, nF3, $0C
	smpsSetvoice        $17
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nRst, nA4, $05, nRst, $01, nBb4, $05, nRst, $07, nBb4, $02, nRst
	dc.b	$04, nBb4, $02, nRst, $04, nBb4, $02, nRst, $04, nBb4, $02, nRst
	dc.b	$0A, nC5, $05, nRst, $01, nBb4, $1D, nRst, $01
	smpsSetvoice        $16
	smpsAlterNote       $FF
	smpsModSet          $0A, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nRst, $0C, nEb3, nRst, $06, nEb3, $0C, nRst, $06, nF3, $0C, nRst
	dc.b	$06, nF3, $0C, nRst, $06, nF3, $0C, nRst, nG3, nRst, $06, nG3
	dc.b	$0C, nRst, $06, nF3, $0C, nRst, $06, nF3, $0C, nRst, $06, nF3
	dc.b	$0C, nRst, nEb3, nRst, $06, nEb3, $0C, nRst, $06, nF3, $0C, nRst
	dc.b	$06, nF3, $0C, nRst, $06, nF3, $0C
	smpsFMAlterVol      $F8
	smpsSetvoice        $0F
	smpsAlterNote       $01
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panLeft, $00
	smpsCall            Snd_AIZ2_Call02
	smpsCall            Snd_AIZ2_Call03
	dc.b	nA4, $11, nRst, $01, nBb4, $11, nRst, $01, nC5, $23, nRst, $19
	smpsSetvoice        $1E
	smpsAlterNote       $01
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panLeft, $00
	dc.b	nEb3, $2F, nRst, $01, nC3, $2F, nRst, $01, nG3, $0F, nRst, $01
	dc.b	nF3, $0F, nRst, $01, nEb3, $0F, nRst, $01, nD3, $0F, nRst, $01
	dc.b	nEb3, $0F, nRst, $01, nF3, $0F, nRst, $01, nRst, $0C
	smpsSetvoice        $1E
	smpsAlterNote       $01
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panLeft, $00
	dc.b	nG3, nBb3, $0B, nRst, $01, nEb4, $0B, nRst, $01, nD4, $05, nRst
	dc.b	$0D, nBb3, $05, nRst, $0D, nC4, $05, nRst, $07, nG3, $2F, nRst
	dc.b	$01
	smpsSetvoice        $06
	smpsAlterNote       $01
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panLeft, $00
	dc.b	nBb3, $05, nRst, $0D, nAb3, $05, nRst, $0D, nG3, $05, nRst, $07
	smpsSetvoice        $1E
	smpsAlterNote       $01
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panLeft, $00
	dc.b	nEb3, $2F, nRst, $01, nC3, $2F, nRst, $01, nG3, $0F, nRst, $01
	dc.b	nF3, $0F, nRst, $01, nEb3, $0F, nRst, $01, nD3, $0F, nRst, $01
	dc.b	nEb3, $0F, nRst, $01, nF3, $0F, nRst, $01, nG3, $0C
	smpsSetvoice        $1E
	smpsAlterNote       $01
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panLeft, $00
	dc.b	nG3, nBb3, $0B, nRst, $01, nEb4, $0B, nRst, $01, nD4, $05, nRst
	dc.b	$0D, nBb3, $05, nRst, $0D, nC4, $05, nRst, $07, nG3, $2F, nRst
	dc.b	$01
	smpsSetvoice        $06
	smpsAlterNote       $01
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panLeft, $00
	dc.b	nBb3, $05, nRst, $0D, nAb3, $05, nRst, $0D, nG3, $05, nRst, $07
	smpsSetvoice        $06
	smpsAlterNote       $03
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panCenter, $00
	dc.b	nAb3, $1D, nRst, $07, nAb3, $06, nBb3, $06, nC4, $11, nRst, $01
	dc.b	nBb3, $11, nRst, $01, nAb3, $0B, nRst, $01, nBb3, $1D, nRst, $07
	dc.b	nBb3, $06, nC4, $06, nD4, $11, nRst, $01, nC4, $11, nRst, $01
	dc.b	nBb3, $0B, nRst, $01, nC4, $2F, nRst, $01, nAb3, $2F, nRst, $01
	dc.b	nEb4, $17, nRst, $01, nD4, $17, nRst, $01, nEb4, $17, nRst, $01
	dc.b	nF4, $17, nRst, $01
	smpsJump            Snd_AIZ2_FM4

; Unreachable
	smpsStop

Snd_AIZ2_Call02:
	dc.b	nRst, $54, nEb4, $05, nRst, $01, nF4, $05, nRst, $01
	smpsReturn

Snd_AIZ2_Call03:
	dc.b	nG4, $05, nRst, $0D, nC4, $05, nRst, $0D, nBb4, $11, nRst, $07
	dc.b	nBb4, $05, nRst, $07, nBb4, $05, nRst, $07, nG4, $05, nRst, $07
	dc.b	nA4, $05, nRst, $0D, nF4, $05, nRst, $0D, nC4, $29, nRst, $07
	dc.b	nEb4, $05, nRst, $01, nF4, $05, nRst, $01, nG4, $05, nRst, $0D
	dc.b	nC4, $05, nRst, $0D, nBb4, $11, nRst, $07, nBb4, $05, nRst, $07
	dc.b	nBb4, $05, nRst, $07, nC5, $05, nRst, $07, nA4, $2F, nRst, $25
	dc.b	nEb4, $05, nRst, $01, nF4, $05, nRst, $01, nG4, $05, nRst, $0D
	dc.b	nC4, $05, nRst, $0D, nBb4, $0B, nRst, $07, nBb4, $06, nBb4, $06
	dc.b	nRst, $06, nBb4, $05, nRst, $07, nG4, $05, nRst, $07, nA4, $05
	dc.b	nRst, $0D, nF4, $05, nRst, $0D, nC4, $23, nRst, $0D, nEb4, $05
	dc.b	nRst, $01, nF4, $05, nRst, $01, nG4, $05, nRst, $0D, nC4, $05
	dc.b	nRst, $0D, nBb4, $11, nRst, $07, nBb4, $05, nRst, $07, nBb4, $05
	dc.b	nRst, $07, nC5, $05, nRst, $07
	smpsReturn

; FM5 Data
Snd_AIZ2_FM5:
	smpsSetvoice        $16
	smpsAlterNote       $02
	smpsModSet          $0A, $01, $06, $06
	smpsPan             panLeft, $00
	dc.b	nC3, $0C, nBb3, nC3, $06, nBb3, $0C, nC3, $06, nBb3, $0C, nC3
	dc.b	$06, nBb3, $0C, nC3, $06, nBb3, $60, $0C
	smpsSetvoice        $16
	smpsAlterNote       $02
	smpsModSet          $0A, $01, $06, $06
	smpsPan             panLeft, $00
	dc.b	nC3, nBb3, nC3, $06, nBb3, $0C, nC3, nC4, $06, nC3, nBb3, $0C
	dc.b	nC3, $06, nA3, $0C
	smpsSetvoice        $17
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nC4, $03, nRst, nC4, nRst, nC5, nRst, nC4, nRst, nBb4, nRst, nC4
	dc.b	nRst, nBb4, nRst, nC5, $03, nRst, $33
	smpsSetvoice        $16
	smpsAlterNote       $02
	smpsModSet          $0A, $01, $06, $06
	smpsPan             panLeft, $00
	dc.b	nC3, $0C, nBb3, nC3, $06, nBb3, $0C, nC3, $06, nBb3, $0C, nC3
	dc.b	$06, nBb3, $0C, nC3, $06, nBb3, $60, $0C
	smpsSetvoice        $16
	smpsAlterNote       $02
	smpsModSet          $0A, $01, $06, $06
	smpsPan             panLeft, $00
	dc.b	nC3, nBb3, nC3, $06, nBb3, $0C, nC3, nC4, $06, nC3, nBb3, $0C
	dc.b	nC3, $06, nA3, $60, $0C
	smpsFMAlterVol      $08
	smpsSetvoice        $16
	smpsAlterNote       $02
	smpsModSet          $0A, $01, $06, $06
	smpsPan             panLeft, $00
	dc.b	nC3, nG3, nC3, $06, nG3, $0C, nC3, $06, nA3, $0C, nC3, $06
	dc.b	nA3, $0C, nC3, $06, nA3, $0C, nC3, nBb3, nC3, $06, nBb3, $0C
	dc.b	nC3, $06, nA3, $0C, nC3, $06, nA3, $0C, nC3, $06, nA3, $0C
	dc.b	nC3, nG3, nC3, $06, nG3, $0C, nC3, $06, nA3, $0C, nC3, $06
	dc.b	nA3, $0C, nC3, $06, nA3, $0C
	smpsSetvoice        $17
	smpsAlterNote       $FE
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	smpsNoAttack, $0C, nD4, $06, nEb4, $0C, nEb4, $03, nRst, nEb4, nRst, nEb4
	dc.b	nRst, nEb4, $03, nRst, $09, nF4, $03, nRst, $03, nEb4, $1E
	smpsSetvoice        $16
	smpsAlterNote       $02
	smpsModSet          $0A, $01, $06, $06
	smpsPan             panLeft, $00
	dc.b	nC3, $0C, nG3, nC3, $06, nG3, $0C, nC3, $06, nA3, $0C, nC3
	dc.b	$06, nA3, $0C, nC3, $06, nA3, $0C, nC3, nBb3, nC3, $06, nBb3
	dc.b	$0C, nC3, $06, nA3, $0C, nC3, $06, nA3, $0C, nC3, $06, nA3
	dc.b	$0C, nC3, nG3, nC3, $06, nG3, $0C, nC3, $06, nA3, $0C, nC3
	dc.b	$06, nA3, $0C, nC3, $06, nC3, $0C
	smpsFMAlterVol      $F8
	smpsSetvoice        $0F
	smpsAlterNote       $00
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	smpsCall            Snd_AIZ2_Call02
	smpsCall            Snd_AIZ2_Call03
	smpsAlterPitch      $F4
	smpsSetvoice        $1E
	smpsAlterNote       $FD
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panRight, $00
	dc.b	nC5, $0C, nA4, $06, nBb4, $0C, nG4, nC5, $42, nAb4, $0C, nC5
	dc.b	nG5, nF5, $12, nEb5, nD5, $0C, nB4, $24, nG4, $0C, nB4, $12
	dc.b	nC5, nD5, $0C, nEb5, $30, nD5, nC5, nG4, $3C, nAb4, $0C, nC5
	dc.b	nG5, nF5, $12, nEb5, nD5, $0C, nB4, $24, nG4, $0C, nB4, $12
	dc.b	nC5, nD5, $0C, nEb5, $24, nD5, $06, nEb5, nF5, $24, nEb5, $06
	dc.b	nF5, nRst, $60, $60
	smpsAlterPitch      $0C
	smpsSetvoice        $06
	smpsAlterNote       $FD
	smpsModSet          $0F, $01, $06, $06
	smpsPan             panCenter, $00
	dc.b	nD3, $24, nD3, $06, nEb3, nF3, $12, nEb3, nD3, $0C, nEb3, $30
	dc.b	nC3, nG3, $18, nF3, nG3, nAb3
	smpsJump            Snd_AIZ2_FM5

; Unreachable
	smpsStop

; PSG1 Data
Snd_AIZ2_PSG1:
	smpsPSGvoice        sTone_05
	smpsAlterNote       $00
	smpsModSet          $0F, $01, $00, $06
	dc.b	nRst, $0C, nG3

Snd_AIZ2_Loop1A:
	dc.b	nRst, $06, nG3, $0C
	smpsLoop            $00, $04, Snd_AIZ2_Loop1A
	dc.b	nRst, $60
	smpsPSGvoice        sTone_05
	smpsAlterNote       $00
	smpsModSet          $0F, $01, $00, $06
	dc.b	nRst, $0C, nG3, nRst, $06, nG3, $0C, nRst, nA3, $06, nRst, $06
	dc.b	nG3, $06, nRst, $0C, nF3
	smpsPSGvoice        sTone_0A
	smpsAlterNote       $00
	smpsModSet          $0F, $01, $01, $06
	dc.b	nC4, $03, nRst, $03, nC4, $03, nRst, $03, nC5, $03, nRst, $03
	dc.b	nC4, $03, nRst, $03, nBb4, $03, nRst, $03, nC4, $03, nRst, $03
	dc.b	nBb4, $03, nRst, $03, nC5, $03, nRst, $33
	smpsPSGvoice        sTone_05
	smpsAlterNote       $00
	smpsModSet          $0F, $01, $00, $06
	dc.b	nRst, $0C, nG3

Snd_AIZ2_Loop1B:
	dc.b	nRst, $06, nG3, $0C
	smpsLoop            $00, $04, Snd_AIZ2_Loop1B
	dc.b	nRst, $60
	smpsPSGvoice        sTone_05
	smpsAlterNote       $00
	smpsModSet          $0F, $01, $00, $06
	dc.b	nRst, $0C, nG3, nRst, $06, nG3, $0C, nRst, nA3, $06, nRst, $06
	dc.b	nG3, $06, nRst, $0C, nF3, nRst, $60
	smpsPSGvoice        sTone_05
	smpsAlterNote       $00
	smpsModSet          $0F, $01, $00, $06
	dc.b	nRst, $0C, nEb3, nRst, $06, nEb3, $0C, nRst, $06, nF3, $0C, nRst
	dc.b	$06, nF3, $0C, nRst, $06, nF3, $0C, nRst, nG3, nRst, $06, nG3
	dc.b	$0C, nRst, $06, nF3, $0C, nRst, $06, nF3, $0C, nRst, $06, nF3
	dc.b	$0C, nRst, nEb3, nRst, $06, nEb3, $0C, nRst, $06, nF3, $0C, nRst
	dc.b	$06, nF3, $0C, nRst, $06, nF3, $0C
	smpsPSGvoice        sTone_0A
	smpsAlterNote       $00
	smpsModSet          $0F, $01, $01, $06
	dc.b	nRst, nA4, $05, nRst, $01, nBb4, $05, nRst, $07, nBb4, $06, nBb4
	dc.b	nBb4, nBb4, $06, nRst, $06, nC5, $05, nRst, $01, nBb4, $1E
	smpsCall            Snd_AIZ2_Call04
	smpsPSGvoice        sTone_0A
	smpsAlterNote       $00
	smpsModSet          $0F, $01, $01, $06
	dc.b	nRst, $0C, nA3, $05, nRst, $01, nB3, $05, nRst, $07, nB3, $06
	dc.b	nB3, nB3, nB3, $06, nRst, $06, nC4, $05, nRst, $01, nB3, $1E
	smpsPSGvoice        sTone_05
	smpsAlterNote       $00
	smpsModSet          $0F, $01, $00, $06
	smpsAlterPitch      $0C
	smpsCall            Snd_AIZ2_Call03
	smpsAlterPitch      $F4
	dc.b	nRst, $60
	smpsPSGvoice        sTone_0A
	smpsAlterNote       $00
	smpsModSet          $0F, $01, $01, $06
	smpsNoteFill        $03
	dc.b	nEb5, $06, nC5, nAb4, nEb4, nC4, nAb3, nEb3, nC3, nC5, nAb4, nEb4
	dc.b	nC4, nAb3, nEb3, nC3, nAb2, nD5, nBb4, nF4, nD4, nBb3, nF3, nD3
	dc.b	nBb2, nBb4, nF4, nD4, nBb3, nF3, nD3, nBb2
	smpsNoteFill        $00
	dc.b	nF2, $03, nRst, $60, nRst, nRst, $03
	smpsPSGvoice        sTone_0A
	smpsAlterNote       $00
	smpsModSet          $0F, $01, $01, $06
	smpsNoteFill        $03
	dc.b	nEb5, $06, nC5, nAb4, nEb4, nC4, nAb3, nEb3, nC3, nC5, nAb4, nEb4
	dc.b	nC4, nAb3, nEb3, nC3, nAb2, nD5, nBb4, nF4, nD4, nBb3, nF3, nD3
	dc.b	nBb2, nBb4, nF4, nD4, nBb3, nF3, nD3, nBb2
	smpsNoteFill        $00
	dc.b	nF2, $03, nRst, $60, nRst, nRst, $03
	smpsFMAlterVol      $FE
	smpsPSGvoice        sTone_0A
	smpsAlterNote       $00
	smpsModSet          $0F, $01, $01, $06
	dc.b	nEb4, $0B, nRst, $07, nEb4, $06, nRst, $48, nF4, $0B, nRst, $07
	dc.b	nF4, $06
	smpsFMAlterVol      $02
	dc.b	nRst, $48, nC4, $2F, nRst, $01, nAb3, $2F, nRst, $01, nEb4, $17
	dc.b	nRst, $01, nD4, $17, nRst, $01, nEb4, $17, nRst, $01, nF4, $17
	dc.b	nRst, $01
	smpsJump            Snd_AIZ2_PSG1

; Unreachable
	smpsStop

Snd_AIZ2_Call04:
	smpsPSGvoice        sTone_05
	smpsAlterNote       $FF
	smpsModSet          $0F, $01, $00, $06
	dc.b	nC3, $0C, nG3, nC3, $06, nG3, $0C, nC3, $06, nA3, $0C, nC3
	dc.b	$06, nA3, $0C, nC3, $06, nA3, $0C, nC3, nBb3, nC3, $06, nBb3
	dc.b	$0C, nC3, $06, nA3, $0C, nC3, $06, nA3, $0C, nC3, $06, nA3
	dc.b	$0C, nC3, nG3, nC3, $06, nG3, $0C, nC3, $06, nA3, $0C, nC3
	dc.b	$06, nA3, $0C, nC3, $06, nC3, $0C
	smpsReturn

; PSG2 Data
Snd_AIZ2_PSG2:
	smpsPSGvoice        sTone_05
	smpsAlterNote       $FF
	smpsModSet          $0F, $01, $00, $06
	dc.b	nC3, $0C, nBb3

Snd_AIZ2_Loop18:
	dc.b	nC3, $06, nBb3, $0C
	smpsLoop            $00, $04, Snd_AIZ2_Loop18
	dc.b	nRst, $60
	smpsPSGvoice        sTone_05
	smpsAlterNote       $FF
	smpsModSet          $0F, $01, $00, $06
	dc.b	nC3, $0C, nBb3, nC3, $06, nBb3, $0C, nC3, $06, nRst, nC4, $06
	dc.b	nC3, $06, nBb3, nRst, nC3, nA3, $0C
	smpsPSGvoice        sTone_0A
	smpsAlterNote       $FF
	smpsModSet          $0F, $01, $01, $06
	smpsNoteFill        $03
	dc.b	nC4, $06, nC4, nC5, nC4, nBb4, nC4, nBb4, nC5, $03
	smpsNoteFill        $00
	dc.b	nRst, $33
	smpsPSGvoice        sTone_05
	smpsAlterNote       $FF
	smpsModSet          $0F, $01, $00, $06
	dc.b	nC3, $0C, nBb3

Snd_AIZ2_Loop19:
	dc.b	nC3, $06, nBb3, $0C
	smpsLoop            $00, $04, Snd_AIZ2_Loop19
	dc.b	nRst, $60
	smpsPSGvoice        sTone_05
	smpsAlterNote       $FF
	smpsModSet          $0F, $01, $00, $06
	dc.b	nC3, $0C, nBb3, nC3, $06, nBb3, $0C, nC3, $06, nRst, nC4, $06
	dc.b	nC3, $06, nBb3, nRst, nC3, nA3, $0C, nRst, $60
	smpsPSGvoice        sTone_05
	smpsAlterNote       $FF
	smpsModSet          $0F, $01, $00, $06
	dc.b	nC3, $0C, nG3, nC3, $06, nG3, $0C, nC3, $06, nA3, $0C, nC3
	dc.b	$06, nA3, $0C, nC3, $06, nA3, $0C, nC3, nBb3, nC3, $06, nBb3
	dc.b	$0C, nC3, $06, nA3, $0C, nC3, $06, nA3, $0C, nC3, $06, nA3
	dc.b	$0C, nC3, nG3, nC3, $06, nG3, $0C, nC3, $06, nA3, $0C, nC3
	dc.b	$06, nA3, $0C, nC3, $06, nA3, $0C
	smpsPSGvoice        sTone_0A
	smpsAlterNote       $FF
	smpsModSet          $0F, $01, $01, $06
	dc.b	nRst, nD4, $05, nRst, $01, nEb4, $05, nRst, $07, nEb4, $02, nRst
	dc.b	$04, nEb4, $02, nRst, $04, nEb4, $02, nRst, $04, nEb4, $02, nRst
	dc.b	$0A, nF4, $05, nRst, $01, nEb4, $1E
	smpsCall            Snd_AIZ2_Call04
	smpsPSGvoice        sTone_0A
	smpsAlterNote       $FF
	smpsModSet          $0F, $01, $01, $06
	dc.b	nRst, $0C, nCs4, $05, nRst, $01, nD4, $05, nRst, $07, nD4, $02
	dc.b	nRst, $04, nD4, $02, nRst, $04, nD4, $02, nRst, $04, nD4, $02
	dc.b	nRst, $0A, nEb4, $05, nRst, $01, nD4, $1E
	smpsPSGvoice        sTone_05
	smpsAlterNote       $FF
	smpsModSet          $0F, $01, $00, $06
	smpsAlterPitch      $0C
	smpsCall            Snd_AIZ2_Call03
	smpsAlterPitch      $F4
	dc.b	nRst, $60
	smpsPSGvoice        sTone_0A
	smpsAlterNote       $FF
	smpsModSet          $0F, $01, $01, $06
	smpsNoteFill        $03
	dc.b	nEb5, $06, nC5, nAb4, nEb4, nC4, nAb3, nEb3, nC3, nC5, nAb4, nEb4
	dc.b	nC4, nAb3, nEb3, nC3, nAb2, nD5, nBb4, nF4, nD4, nBb3, nF3, nD3
	dc.b	nBb2, nBb4, nF4, nD4, nBb3, nF3, nD3, nBb2
	smpsNoteFill        $00
	dc.b	nF2, $03, nRst, $60, nRst, nRst, $03
	smpsPSGvoice        sTone_0A
	smpsAlterNote       $FF
	smpsModSet          $0F, $01, $01, $06
	smpsNoteFill        $03
	dc.b	nEb5, $06, nC5, nAb4, nEb4, nC4, nAb3, nEb3, nC3, nC5, nAb4, nEb4
	dc.b	nC4, nAb3, nEb3, nC3, nAb2, nD5, nBb4, nF4, nD4, nBb3, nF3, nD3
	dc.b	nBb2, nBb4, nF4, nD4, nBb3, nF3, nD3, nBb2
	smpsNoteFill        $00
	dc.b	nF2, $03, nRst, $60, nRst, nRst, $03
	smpsFMAlterVol      $FE
	smpsPSGvoice        sTone_0A
	smpsAlterNote       $FF
	smpsModSet          $0F, $01, $01, $06
	dc.b	nC4, $0B, nRst, $07, nC4, $02, nRst, $4C, nD4, $0B, nRst, $07
	dc.b	nD4, $02
	smpsFMAlterVol      $02
	dc.b	nRst, $4C, nC4, $2F, nRst, $01, nAb3, $2F, nRst, $01, nEb4, $17
	dc.b	nRst, $01, nD4, $17, nRst, $01, nEb4, $17, nRst, $01, nF4, $17
	dc.b	nRst, $01
	smpsJump            Snd_AIZ2_PSG2

; Unreachable
	smpsStop

; PSG3 Data
Snd_AIZ2_PSG3:
	smpsPSGvoice        sTone_02
	smpsPSGform         $E7

Snd_AIZ2_Loop14:
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG1, $06, nMaxPSG1
	smpsPSGvoice        sTone_05
	dc.b	nMaxPSG1, $06, nRst, $06
	smpsLoop            $01, $1C, Snd_AIZ2_Loop14
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG1, $0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1
	smpsPSGvoice        sTone_02
	dc.b	nMaxPSG1, $3C

Snd_AIZ2_Loop15:
	dc.b	nMaxPSG1, $0C, nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, $0C, nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, $0C
	dc.b	nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, $0C, nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, nMaxPSG1, nMaxPSG1, $0C
	dc.b	nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, $0C, nMaxPSG1, nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, $0C, nMaxPSG1
	dc.b	$06, nMaxPSG1
	smpsLoop            $01, $03, Snd_AIZ2_Loop15
	dc.b	nMaxPSG1, $0C, nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, $0C, nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, $0C
	dc.b	nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, $0C, nMaxPSG1, $06, nMaxPSG1, $60, $06

Snd_AIZ2_Loop16:
	dc.b	nMaxPSG1, $0C, nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, $0C, nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, $0C
	dc.b	nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, $0C, nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, nMaxPSG1, nMaxPSG1, $0C
	dc.b	nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, $0C, nMaxPSG1, nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, $0C, nMaxPSG1
	dc.b	$06, nMaxPSG1
	smpsLoop            $01, $04, Snd_AIZ2_Loop16

Snd_AIZ2_Loop17:
	dc.b	nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, $0C, nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, nMaxPSG1, $0C, nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, $0C
	smpsLoop            $01, $0A, Snd_AIZ2_Loop17
	dc.b	nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, $0C, nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, $0C, nMaxPSG1, $06
	dc.b	nMaxPSG1, nMaxPSG1, $0C, nMaxPSG1, $06, nMaxPSG1, nMaxPSG1, $60, $0C
	smpsJump            Snd_AIZ2_Loop14

; Unreachable
	smpsStop
