Snd_LRZ2_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoiceUVB
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $33

	smpsHeaderDAC       Snd_LRZ2_DAC
	smpsHeaderFM        Snd_LRZ2_FM1,	$0C, $15
	smpsHeaderFM        Snd_LRZ2_FM2,	$00, $11
	smpsHeaderFM        Snd_LRZ2_FM3,	$0C, $18
	smpsHeaderFM        Snd_LRZ2_FM4,	$0C, $15
	smpsHeaderFM        Snd_LRZ2_FM5,	$0C, $1A
	smpsHeaderPSG       Snd_LRZ2_PSG1,	$F4, $04, $00, sTone_0C
	smpsHeaderPSG       Snd_LRZ2_PSG2,	$F4, $03, $00, sTone_0C
	smpsHeaderPSG       Snd_LRZ2_PSG3,	$00, $02, $00, sTone_0C

; Unreachable
	smpsStop
	smpsStop

; DAC Data
Snd_LRZ2_DAC:
	dc.b	nRst, $18, nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $06
	smpsPan             panCenter, $00
	dc.b	dLowTomS3, $06
	smpsPan             panLeft, $00
	dc.b	dFloorTomS3, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $18, nRst, $18, nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $06
	smpsPan             panCenter, $00
	dc.b	dLowTomS3, $06
	smpsPan             panLeft, $00
	dc.b	dFloorTomS3, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $18, nRst, $18, nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $06
	smpsPan             panCenter, $00
	dc.b	dLowTomS3, $06
	smpsPan             panLeft, $00
	dc.b	dFloorTomS3, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $18

Snd_LRZ2_Jump00:
	dc.b	dKickS3, $18, nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $18, nRst, $0C, dKickS3, $0C, dKickS3, $18, nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $18, nRst, $0C, dKickS3, $0C, dKickS3, $18, nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $06
	smpsPan             panCenter, $00
	dc.b	dLowTomS3, $06
	smpsPan             panLeft, $00
	dc.b	dFloorTomS3, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $0C, dSnareS3, $0C, dKickS3, $18, nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $18, nRst, $0C, dKickS3, $0C, dKickS3, $12, dKickS3, $06, nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $18, nRst, $18, dKickS3, $12, dKickS3, $06, nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $18, nRst, $0C, dSnareS3, $0C, dKickS3, $12, dKickS3, $06, nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $06
	smpsPan             panCenter, $00
	dc.b	dLowTomS3, $06
	smpsPan             panLeft, $00
	dc.b	dFloorTomS3, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $18, dKickS3, $12, dKickS3, $06, nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $18, nRst, $0C, dSnareS3, $0C, dKickS3, $12, dKickS3, $06, nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $18, nRst, $18, dKickS3, $12, dKickS3, $06, nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $18, nRst, $0C, dSnareS3, $0C, dKickS3, $12, dKickS3, $06, nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $06
	smpsPan             panCenter, $00
	dc.b	dLowTomS3, $06
	smpsPan             panLeft, $00
	dc.b	dFloorTomS3, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $18, dKickS3, $12, dKickS3, $06, nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $18, nRst, $0C, dSnareS3, $0C, dKickS3, $12, dKickS3, $06, dSnareS3, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $06, dKickS3, $12, nRst, $0C, dSnareS3, $0C, dKickS3, $12, dKickS3, $06
	dc.b	nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $06
	smpsPan             panCenter, $00
	dc.b	dLowTomS3, $0C
	smpsPan             panLeft, $00
	dc.b	dFloorTomS3, $06
	smpsPan             panCenter, $00
	dc.b	nRst, $0C, dSnareS3, $0C, dKickS3, $12, dKickS3, $06, nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $06, dKickS3, $0C, dKickS3, $06, nRst, $0C, dSnareS3, $0C, dKickS3, $12
	dc.b	dKickS3, $06, nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $06
	smpsPan             panCenter, $00
	dc.b	dLowTomS3, $06
	smpsPan             panLeft, $00
	dc.b	dFloorTomS3, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $0C, dSnareS3, $0C, dKickS3, $12, dKickS3, $06, dSnareS3, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $06, dKickS3, $12, nRst, $0C, dSnareS3, $0C, dKickS3, $12, dKickS3, $06
	dc.b	nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $06
	smpsPan             panCenter, $00
	dc.b	dLowTomS3, $06
	smpsPan             panLeft, $00
	dc.b	dFloorTomS3, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $0C, dSnareS3, $0C, dKickS3, $12, dKickS3, $06, nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $06, dKickS3, $0C, dKickS3, $06, nRst, $0C, dSnareS3, $0C, dKickS3, $12
	dc.b	dKickS3, $06, nRst, $0C
	smpsPan             panRight, $00
	dc.b	dHighTom, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $06
	smpsPan             panCenter, $00
	dc.b	dLowTomS3, $06
	smpsPan             panLeft, $00
	dc.b	dFloorTomS3, $0C
	smpsPan             panCenter, $00
	dc.b	nRst, $0C, dSnareS3, $06, nRst, $06
	smpsJump            Snd_LRZ2_Jump00

; Unreachable
	smpsStop

; FM1 Data
Snd_LRZ2_FM1:
	smpsPan             panRight, $00
	smpsSetvoice        $04
	smpsAlterNote       $05
	smpsModSet          $0A, $01, $06, $06

Snd_LRZ2_Jump03:
	dc.b	nA4, $18, smpsNoAttack, $18, smpsNoAttack, $18, nF4, $18, smpsNoAttack, $18, smpsNoAttack, $18
	dc.b	nG4, $18, smpsNoAttack, $18, smpsNoAttack, $18, nE4, $18, smpsNoAttack, $18, smpsNoAttack, $18

Snd_LRZ2_Jump05:
	dc.b	nA4, $18, smpsNoAttack, $18, smpsNoAttack, $18, smpsNoAttack, $18, smpsNoAttack, $18, smpsNoAttack, $18
	dc.b	smpsNoAttack, $18, smpsNoAttack, $18, nRst, $18, nRst, $18, nRst, $18, nRst, $18
	dc.b	nRst, $18, nRst, $18, nRst, $18, nA4, $18, nG4, $18, smpsNoAttack, $18
	dc.b	smpsNoAttack, $0C, nC5, $0C, smpsNoAttack, $0C, nB4, $0C, nG4, $18, smpsNoAttack, $18
	dc.b	nRst, $18, nRst, $18, nG4, $18, smpsNoAttack, $18, smpsNoAttack, $0C, nC5, $0C
	dc.b	smpsNoAttack, $0C, nB4, $0C, nG4, $18, smpsNoAttack, $18, smpsNoAttack, $18, nRst, $18
	dc.b	nG4, $18, smpsNoAttack, $18, smpsNoAttack, $0C, nB4, $0C, smpsNoAttack, $0C, nC5, $0C
	dc.b	nD5, $18, smpsNoAttack, $18, smpsNoAttack, $18, smpsNoAttack, $18, nG4, $18, smpsNoAttack, $18
	dc.b	smpsNoAttack, $0C, nC5, $0C, smpsNoAttack, $0C, nB4, $0C, nG4, $18, smpsNoAttack, $18
	dc.b	nRst, $18, nRst, $18, nRst, $18, nRst, $18, nRst, $18, nRst, $18
	dc.b	nRst, $18, nRst, $18, nRst, $18, nRst, $18, nE5, $18, smpsNoAttack, $0C
	dc.b	nA4, $0C, smpsNoAttack, $18, nC5, $18, nB4, $18, smpsNoAttack, $18, smpsNoAttack, $18
	dc.b	smpsNoAttack, $0C, nG4, $0C, nA4, $18, smpsNoAttack, $18, smpsNoAttack, $0C, nRst, $0C
	dc.b	nRst, $18, nRst, $18, nRst, $18, nRst, $18, nRst, $18, nE5, $18
	dc.b	smpsNoAttack, $0C, nA4, $0C, smpsNoAttack, $18, nC5, $18, nB4, $18, smpsNoAttack, $18
	dc.b	smpsNoAttack, $18, smpsNoAttack, $18
	smpsJump            Snd_LRZ2_Jump05

; Unreachable
	smpsStop

; FM2 Data
Snd_LRZ2_FM2:
	smpsSetvoice        $03
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	dc.b	nF2, $48, nCs2, nEb2, nC2

Snd_LRZ2_Jump04:
	smpsSetvoice        $0B
	smpsAlterNote       $00
	smpsModSet          $0F, $01, $06, $06
	smpsFMAlterVol      $08
	dc.b	nG2, $06, nA2, nC3, nA2, nD3, nA2, nE3, nA2, nG3, nD3, nA3
	dc.b	nC4, nG3, nD3, nE3, nG3, nG2, nA2, nC3, nA2, nD3, nA2, nE3
	dc.b	nA2, nG3, nD3, nA3, nE3, nG3, nE3, nD3, nE3, nG2, nA2, nC3
	dc.b	nA2, nD3, nA2, nE3, nA2, nG3, nD3, nA3, nC4, nG3, nD3, nE3
	dc.b	nG3, nG2, nA2, nC3, nA2, nD3, nA2, nE3, nA2, nG3, nD3, nA3
	dc.b	nE3
	smpsSetvoice        $03
	smpsAlterNote       $00
	smpsModSet          $03, $01, $02, $05
	smpsFMAlterVol      $F8
	dc.b	nE2, $18, nA2, $0A, nRst, $02, nA2, nRst, $04, nA2, $48, nRst
	dc.b	$06, nA2, $0A, nRst, $02, nA2, nRst, $04, nA3, $48, nRst, $06
	dc.b	nA2, $0A, nRst, $02, nA2, nRst, $04, nA2, $48, nRst, $06, nA2
	dc.b	$0A, nRst, $02, nA2, nRst, $04, nA3, $48, nRst, $06, nF2, $0A
	dc.b	nRst, $02, nF2, nRst, $04, nF2, $48, nRst, $06, nF2, $0A, nRst
	dc.b	$02, nF2, nRst, $04, nF3, $48, nRst, $06, nF2, $0A, nRst, $02
	dc.b	nF2, nRst, $04, nF2, $48, nRst, $06, nF2, $0A, nRst, $02, nF2
	dc.b	nRst, $04, nF3, $30
	smpsSetvoice        $14
	smpsAlterNote       $00
	smpsModSet          $02, $01, $01, $02
	smpsFMAlterVol      $FC
	dc.b	nF3, $0C, nC3, nG2, $06, nA2, $0A, nRst, $02, nA2, nRst, $04
	dc.b	nA2, $30, nG2, $0C, nG2, $02, nRst, $04, nAb2, $0C, nA2, $0A
	dc.b	nRst, $02, nA2, nRst, $04, nA3, $3A, nRst, $02, nG3, nRst, $04
	dc.b	nE3, $0C, nA2, $0A, nRst, $02, nA2, nRst, $04, nA2, $2E, nRst
	dc.b	$02, nG2, $0C, nG2, $02, nRst, $04, nAb2, $0C, nA2, $0A, nRst
	dc.b	$02, nA2, nRst, $04, nA3, $3A, nRst, $02, nG3, nRst, $04, nE3
	dc.b	$0C, nA2, $0A, nRst, $02, nA2, nRst, $04, nA2, $2E, nRst, $02
	dc.b	nG2, $0C, nG2, $02, nRst, $04, nAb2, $0C, nA2, $0A, nRst, $02
	dc.b	nA2, nRst, $04, nA3, $2E, nRst, $02, nA3, $0C, nE3, $0C, nG2
	dc.b	$06, nA2, $0A, nRst, $02, nA2, nRst, $04, nA2, $2E, nRst, $02
	dc.b	nG2, $0C, nG2, $02, nRst, $04, nAb2, $0C, nA2, $0A, nRst, $02
	dc.b	nA2, nRst, $04, nA3, $3A, nRst, $02, nG3, nRst, $04, nE3, $0C
	smpsFMAlterVol      $04
	smpsJump            Snd_LRZ2_Jump04

; Unreachable
	smpsStop

; FM3 Data
Snd_LRZ2_FM3:
	dc.b	nRst, $07
	smpsPan             panLeft, $00
	smpsSetvoice        $1F
	smpsAlterNote       $01
	smpsModSet          $0F, $01, $06, $06
	smpsJump            Snd_LRZ2_Jump03

; Unreachable
	smpsStop

; FM4 Data
Snd_LRZ2_FM4:
	smpsAlterNote       $01
	smpsSetvoice        $0B
	smpsAlterNote       $00
	smpsModSet          $0F, $01, $06, $06
	dc.b	nF4, $06, nG4, $06, nF4, $06, nG4, $06, nF4, $06, nG4, $06
	dc.b	nF4, $06, nG4, $06, nF4, $06, nG4, $06, nF4, $06, nG4, $06
	dc.b	nCs4, $06, nEb4, $06, nCs4, $06, nEb4, $06, nCs4, $06, nEb4, $06
	dc.b	nCs4, $06, nEb4, $06, nCs4, $06, nEb4, $06, nCs4, $06, nEb4, $06
	dc.b	nEb4, $06, nF4, $06, nEb4, $06, nF4, $06, nEb4, $06, nF4, $06
	dc.b	nEb4, $06, nF4, $06, nEb4, $06, nF4, $06, nEb4, $06, nF4, $06
	dc.b	nC4, $06, nD4, $06, nC4, $06, nD4, $06, nC4, $06, nD4, $06
	dc.b	nC4, $06, nD4, $06, nC4, $06, nD4, $06, nC4, $06, nD4, $06

Snd_LRZ2_Jump02:
	dc.b	nG2, $06, nA2, $06, nC3, $06, nA2, $06, nD3, $06, nA2, $06
	dc.b	nE3, $06, nA2, $06, nG3, $06, nD3, $06, nA3, $06, nC4, $06
	dc.b	nG3, $06, nD3, $06, nE3, $06, nG3, $06, nG2, $06, nA2, $06
	dc.b	nC3, $06, nA2, $06, nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b	nG3, $06, nD3, $06, nA3, $06, nE3, $06, nG3, $06, nE3, $06
	dc.b	nD3, $06, nE3, $06, nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b	nD3, $06, nA2, $06, nE3, $06, nA2, $06, nG3, $06, nD3, $06
	dc.b	nA3, $06, nC4, $06, nG3, $06, nD3, $06, nE3, $06, nG3, $06
	dc.b	nG2, $06, nA2, $06, nC3, $06, nA2, $06, nD3, $06, nA2, $06
	dc.b	nE3, $06, nA2, $06, nG3, $06, nD3, $06, nA3, $06, nE3, $06
	dc.b	nG3, $06, nE3, $06, nD3, $06, nE3, $06, nG2, $06, nA2, $06
	dc.b	nC3, $06, nA2, $06, nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b	nG3, $06, nD3, $06, nA3, $06, nC4, $06, nG3, $06, nD3, $06
	dc.b	nE3, $06, nG3, $06, nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b	nD3, $06, nA2, $06, nE3, $06, nA2, $06, nG3, $06, nD3, $06
	dc.b	nA3, $06, nE3, $06, nG3, $06, nE3, $06, nD3, $06, nE3, $06
	dc.b	nG2, $06, nA2, $06, nC3, $06, nA2, $06, nD3, $06, nA2, $06
	dc.b	nE3, $06, nA2, $06, nG3, $06, nD3, $06, nA3, $06, nC4, $06
	dc.b	nG3, $06, nD3, $06, nE3, $06, nG3, $06, nG2, $06, nA2, $06
	dc.b	nC3, $06, nA2, $06, nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b	nG3, $06, nD3, $06, nA3, $06, nE3, $06, nG3, $06, nE3, $06
	dc.b	nD3, $06, nE3, $06, nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b	nD3, $06, nA2, $06, nE3, $06, nA2, $06, nG3, $06, nD3, $06
	dc.b	nA3, $06, nC4, $06, nG3, $06, nD3, $06, nE3, $06, nG3, $06
	dc.b	nG2, $06, nA2, $06, nC3, $06, nA2, $06, nD3, $06, nA2, $06
	dc.b	nE3, $06, nA2, $06, nG3, $06, nD3, $06, nA3, $06, nE3, $06
	dc.b	nG3, $06, nE3, $06, nD3, $06, nE3, $06, nG2, $06, nA2, $06
	dc.b	nC3, $06, nA2, $06, nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b	nG3, $06, nD3, $06, nA3, $06, nC4, $06, nG3, $06, nD3, $06
	dc.b	nE3, $06, nG3, $06, nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b	nD3, $06, nA2, $06, nE3, $06, nA2, $06, nG3, $06, nD3, $06
	dc.b	nA3, $06, nE3, $06, nG3, $06, nE3, $06, nD3, $06, nE3, $06
	dc.b	nG2, $06, nA2, $06, nC3, $06, nA2, $06, nD3, $06, nA2, $06
	dc.b	nE3, $06, nA2, $06, nG3, $06, nD3, $06, nA3, $06, nC4, $06
	dc.b	nG3, $06, nD3, $06, nE3, $06, nG3, $06, nG2, $06, nA2, $06
	dc.b	nC3, $06, nA2, $06, nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b	nG3, $06, nD3, $06, nA3, $06, nE3, $06, nG3, $06, nE3, $06
	dc.b	nD3, $06, nE3, $06, nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b	nD3, $06, nA2, $06, nE3, $06, nA2, $06, nG3, $06, nD3, $06
	dc.b	nA3, $06, nC4, $06, nG3, $06, nD3, $06, nE3, $06, nG3, $06
	dc.b	nG2, $06, nA2, $06, nC3, $06, nA2, $06, nD3, $06, nA2, $06
	dc.b	nE3, $06, nA2, $06, nG3, $06, nD3, $06, nA3, $06, nE3, $06
	dc.b	nG3, $06, nE3, $06, nD3, $06, nE3, $06, nG2, $06, nA2, $06
	dc.b	nC3, $06, nA2, $06, nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b	nG3, $06, nD3, $06, nA3, $06, nC4, $06, nG3, $06, nD3, $06
	dc.b	nE3, $06, nG3, $06, nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b	nD3, $06, nA2, $06, nE3, $06, nA2, $06, nG3, $06, nD3, $06
	dc.b	nA3, $06, nE3, $06, nG3, $06, nE3, $06, nD3, $06, nE3, $06
	dc.b	nG2, $06, nA2, $06, nC3, $06, nA2, $06, nD3, $06, nA2, $06
	dc.b	nE3, $06, nA2, $06, nG3, $06, nD3, $06, nA3, $06, nC4, $06
	dc.b	nG3, $06, nD3, $06, nE3, $06, nG3, $06, nG2, $06, nA2, $06
	dc.b	nC3, $06, nA2, $06, nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b	nG3, $06, nD3, $06, nA3, $06, nE3, $06, nG3, $06, nE3, $06
	dc.b	nD3, $06, nE3, $06
	smpsJump            Snd_LRZ2_Jump02

; Unreachable
	smpsStop

; FM5 Data
Snd_LRZ2_FM5:
	smpsPan             panRight, $00
	smpsAlterNote       $FF
	smpsSetvoice        $08
	smpsAlterNote       $FF
	smpsModSet          $0F, $01, $06, $06
	dc.b	nC3, $06, nF3, $06, nA3, $06, nC4, $06, nF4, $06, nA4, $06
	dc.b	nC5, $06, nA4, $06, nF4, $06, nC4, $06, nA3, $06, nF3, $06
	dc.b	nAb2, $06, nCs3, $06, nF3, $06, nAb3, $06, nCs4, $06, nF4, $06
	dc.b	nAb4, $06, nF4, $06, nCs4, $06, nAb3, $06, nF3, $06, nCs3, $06
	dc.b	nBb2, $06, nEb3, $06, nG3, $06, nBb3, $06, nEb4, $06, nG4, $06
	dc.b	nBb4, $06, nG4, $06, nEb4, $06, nBb3, $06, nG3, $06, nEb3, $06
	dc.b	nG2, $06, nC3, $06, nE3, $06, nG3, $06, nC4, $06, nE4, $06
	dc.b	nG4, $06, nE4, $06, nC4, $06, nG3, $06, nE3, $06, nC3, $06

Snd_LRZ2_Jump01:
	smpsSetvoice        $0B
	smpsAlterNote       $00
	smpsModSet          $0F, $01, $06, $06
	dc.b	nA4, $06, nA5, $06, nRst, $06, nA4, $06, nRst, $06, nA4, $06
	dc.b	nA5, $06, nA4, $06, nRst, $06, nE5, $06, nA4, $06, nD5, $06
	dc.b	nA4, $06, nG4, $06, nE5, $06, nG5, $06, nA4, $06, nA5, $06
	dc.b	nRst, $06, nA4, $06, nRst, $06, nA4, $06, nA5, $06, nA4, $06
	dc.b	nRst, $06, nE5, $06, nA4, $06, nD5, $06, nA4, $06, nG4, $06
	dc.b	nE5, $06, nG5, $06
	smpsSetvoice        $08
	smpsAlterNote       $FF
	smpsModSet          $0F, $01, $06, $06
	dc.b	nA4, $04, nRst, $08, nC5, $04, nRst, $02, nA4, $04, nRst, $02
	dc.b	nRst, $06, nB4, $04, nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b	nA4, $04, nRst, $08, nG4, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nE4, $04, nRst, $08, nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b	nA4, $04, nRst, $02, nRst, $06, nB4, $04, nRst, $08, nG4, $04
	dc.b	nRst, $02, nRst, $06, nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b	nG4, $04, nRst, $08, nE4, $04, nRst, $08, nA4, $04, nRst, $08
	dc.b	nC5, $04, nRst, $02, nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b	nRst, $08, nG4, $04, nRst, $02, nRst, $06, nA4, $04, nRst, $08
	dc.b	nG4, $04, nRst, $02, nF4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b	nA4, $04, nRst, $08, nC5, $04, nRst, $02, nA4, $04, nRst, $02
	dc.b	nRst, $06, nB4, $04, nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b	nA4, $04, nRst, $08, nD4, $04, nRst, $02, nG4, $04, nRst, $08
	dc.b	nE4, $04, nRst, $08, nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b	nA4, $04, nRst, $02, nRst, $06, nB4, $04, nRst, $08, nG4, $04
	dc.b	nRst, $02, nRst, $06, nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nE4, $04, nRst, $08, nA4, $04, nRst, $08
	dc.b	nC5, $04, nRst, $02, nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b	nRst, $08, nG4, $04, nRst, $02, nRst, $06, nA4, $04, nRst, $08
	dc.b	nD4, $04, nRst, $02, nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b	nA4, $04, nRst, $08, nC5, $04, nRst, $02, nA4, $04, nRst, $02
	dc.b	nRst, $06, nB4, $04, nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b	nA4, $04, nRst, $08, nG4, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nE4, $04, nRst, $08, nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b	nA4, $04, nRst, $02, nRst, $06, nB4, $04, nRst, $08, nG4, $04
	dc.b	nRst, $02, nRst, $06, nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b	nG4, $04, nRst, $08, nE4, $04, nRst, $08, nA4, $04, nRst, $08
	dc.b	nC5, $04, nRst, $02, nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b	nRst, $08, nG4, $04, nRst, $02, nRst, $06, nA4, $04, nRst, $08
	dc.b	nG4, $04, nRst, $02, nF4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b	nA4, $04, nRst, $08, nC5, $04, nRst, $02, nA4, $04, nRst, $02
	dc.b	nRst, $06, nB4, $04, nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b	nA4, $04, nRst, $08, nD4, $04, nRst, $02, nG4, $04, nRst, $08
	dc.b	nE4, $04, nRst, $08, nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b	nA4, $04, nRst, $02, nRst, $06, nB4, $04, nRst, $08, nG4, $04
	dc.b	nRst, $02, nRst, $06, nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b	nA4, $04, nRst, $08, nE4, $04, nRst, $08, nA4, $04, nRst, $08
	dc.b	nC5, $04, nRst, $02, nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b	nRst, $08, nG4, $04, nRst, $02, nRst, $06, nA4, $04, nRst, $08
	dc.b	nD4, $04, nRst, $02, nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b	nA4, $04, nRst, $08, nC5, $04, nRst, $02, nA4, $04, nRst, $02
	dc.b	nRst, $06, nB4, $04, nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b	nA4, $04, nRst, $08, nG4, $04, nRst, $02, nA4, $04, nRst, $08
	dc.b	nE4, $04, nRst, $08, nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b	nA4, $04, nRst, $02, nRst, $06, nB4, $04, nRst, $08, nG4, $04
	dc.b	nRst, $02, nRst, $06, nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b	nG4, $04, nRst, $08, nE4, $04, nRst, $08, nA4, $04, nRst, $08
	dc.b	nC5, $04, nRst, $02, nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b	nRst, $08, nG4, $04, nRst, $02, nRst, $06, nA4, $04, nRst, $08
	dc.b	nG4, $04, nRst, $02, nA4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b	nA4, $04, nRst, $08, nC5, $04, nRst, $02, nA4, $04, nRst, $02
	dc.b	nRst, $06, nB4, $04, nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b	nA4, $04, nRst, $08, nD4, $04, nRst, $02, nG4, $04, nRst, $08
	dc.b	nE4, $04, nRst, $08, nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b	nA4, $04, nRst, $02, nRst, $06, nB4, $04, nRst, $08, nG4, $04
	dc.b	nRst, $02, nRst, $06, nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b	nA4, $04, nRst, $08, nE4, $04, nRst, $08, nA4, $04, nRst, $08
	dc.b	nC5, $04, nRst, $02, nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b	nRst, $08, nG4, $04, nRst, $02, nRst, $06, nA4, $04, nRst, $08
	dc.b	nD4, $04, nRst, $02, nG4, $04, nRst, $08, nE4, $04, nRst, $08
	smpsJump            Snd_LRZ2_Jump01

; Unreachable
	smpsStop

; PSG1 Data
Snd_LRZ2_PSG1:
	smpsPSGvoice        sTone_0A
	dc.b	nC3, $06, nF3, $06, nA3, $06, nC4, $06, nF4, $06, nA4, $06
	dc.b	nC5, $06, nA4, $06, nF4, $06, nC4, $06, nA3, $06, nF3, $06
	dc.b	nAb2, $06, nCs3, $06, nF3, $06, nAb3, $06, nCs4, $06, nF4, $06
	dc.b	nAb4, $06, nF4, $06, nCs4, $06, nAb3, $06, nF3, $06, nCs3, $06
	dc.b	nBb2, $06, nEb3, $06, nG3, $06, nBb3, $06, nEb4, $06, nG4, $06
	dc.b	nBb4, $06, nG4, $06, nEb4, $06, nBb3, $06, nG3, $06, nEb3, $06
	dc.b	nG2, $06, nC3, $06, nE3, $06, nG3, $06, nC4, $06, nE4, $06
	dc.b	nG4, $06, nE4, $06, nC4, $06, nG3, $06, nE3, $06, nC3, $06

Snd_LRZ2_Jump08:
	dc.b	nA4, $06, nA5, $06, nRst, $06, nA4, $06, nRst, $06, nA4, $06
	dc.b	nA5, $06, nA4, $06, nRst, $06, nE5, $06, nA4, $06, nD5, $06
	dc.b	nA4, $06, nG4, $06, nE5, $06, nG5, $06, nA4, $06, nA5, $06
	dc.b	nRst, $06, nA4, $06, nRst, $06, nA4, $06, nA5, $06, nA4, $06
	dc.b	nRst, $06, nE5, $06, nA4, $06, nD5, $06, nA4, $06, nG4, $06
	dc.b	nE5, $06, nG5, $06, nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b	nA4, $04, nRst, $02, nRst, $06, nB4, $04, nRst, $08, nG4, $04
	dc.b	nRst, $02, nRst, $06, nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nE4, $04, nRst, $08, nA4, $04, nRst, $08
	dc.b	nC5, $04, nRst, $02, nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b	nRst, $08, nG4, $04, nRst, $02, nRst, $06, nA4, $04, nRst, $08
	dc.b	nD4, $04, nRst, $02, nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b	nA4, $04, nRst, $08, nC5, $04, nRst, $02, nA4, $04, nRst, $02
	dc.b	nRst, $06, nB4, $04, nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b	nA4, $04, nRst, $08, nG4, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nE4, $04, nRst, $08, nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b	nA4, $04, nRst, $02, nRst, $06, nB4, $04, nRst, $08, nG4, $04
	dc.b	nRst, $02, nRst, $06, nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b	nG4, $04, nRst, $08, nE4, $04, nRst, $08, nA4, $04, nRst, $08
	dc.b	nC5, $04, nRst, $02, nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b	nRst, $08, nG4, $04, nRst, $02, nRst, $06, nA4, $04, nRst, $08
	dc.b	nG4, $04, nRst, $02, nF4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b	nA4, $04, nRst, $08, nC5, $04, nRst, $02, nA4, $04, nRst, $02
	dc.b	nRst, $06, nB4, $04, nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b	nA4, $04, nRst, $08, nD4, $04, nRst, $02, nG4, $04, nRst, $08
	dc.b	nE4, $04, nRst, $08, nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b	nA4, $04, nRst, $02, nRst, $06, nB4, $04, nRst, $08, nG4, $04
	dc.b	nRst, $02, nRst, $06, nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nE4, $04, nRst, $08, nA4, $04, nRst, $08
	dc.b	nC5, $04, nRst, $02, nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b	nRst, $08, nG4, $04, nRst, $02, nRst, $06, nA4, $04, nRst, $08
	dc.b	nD4, $04, nRst, $02, nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b	nA4, $04, nRst, $08, nC5, $04, nRst, $02, nA4, $04, nRst, $02
	dc.b	nRst, $06, nB4, $04, nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b	nA4, $04, nRst, $08, nG4, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nE4, $04, nRst, $08, nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b	nA4, $04, nRst, $02, nRst, $06, nB4, $04, nRst, $08, nG4, $04
	dc.b	nRst, $02, nRst, $06, nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b	nG4, $04, nRst, $08, nE4, $04, nRst, $08, nA4, $04, nRst, $08
	dc.b	nC5, $04, nRst, $02, nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b	nRst, $08, nG4, $04, nRst, $02, nRst, $06, nA4, $04, nRst, $08
	dc.b	nG4, $04, nRst, $02, nA4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b	nA4, $04, nRst, $08, nC5, $04, nRst, $02, nA4, $04, nRst, $02
	dc.b	nRst, $06, nB4, $04, nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b	nA4, $04, nRst, $08, nD4, $04, nRst, $02, nG4, $04, nRst, $08
	dc.b	nE4, $04, nRst, $08, nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b	nA4, $04, nRst, $02, nRst, $06, nB4, $04, nRst, $08, nG4, $04
	dc.b	nRst, $02, nRst, $06, nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b	nA4, $04, nRst, $08, nE4, $04, nRst, $08, nA4, $04, nRst, $08
	dc.b	nC5, $04, nRst, $02, nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b	nRst, $08, nG4, $04, nRst, $02, nRst, $06, nA4, $04, nRst, $08
	dc.b	nD4, $04, nRst, $02, nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b	nA4, $04, nRst, $08, nC5, $04, nRst, $02, nA4, $04, nRst, $02
	dc.b	nRst, $06, nB4, $04, nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b	nA4, $04, nRst, $08, nG4, $04, nRst, $02, nA4, $04, nRst, $08
	dc.b	nE4, $04, nRst, $08, nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b	nA4, $04, nRst, $02, nRst, $06, nB4, $04, nRst, $08, nG4, $04
	dc.b	nRst, $02, nRst, $06, nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b	nG4, $04, nRst, $08, nE4, $04, nRst, $08, nA4, $04, nRst, $08
	dc.b	nC5, $04, nRst, $02, nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b	nRst, $08, nG4, $04, nRst, $02, nRst, $06, nA4, $04, nRst, $08
	dc.b	nG4, $04, nRst, $02, nA4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b	nA4, $04, nRst, $08, nC5, $04, nRst, $02, nA4, $04, nRst, $02
	dc.b	nRst, $06, nB4, $04, nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b	nA4, $04, nRst, $08, nD4, $04, nRst, $02, nG4, $04, nRst, $08
	dc.b	nE4, $04, nRst, $08
	smpsJump            Snd_LRZ2_Jump08

; Unreachable
	smpsStop

; PSG2 Data
Snd_LRZ2_PSG2:
	smpsPSGvoice        sTone_08
	dc.b	nF4, $06, nG4, $06, nF4, $06, nG4, $06, nF4, $06, nG4, $06
	dc.b	nF4, $06, nG4, $06, nF4, $06, nG4, $06, nF4, $06, nG4, $06
	dc.b	nCs4, $06, nEb4, $06, nCs4, $06, nEb4, $06, nCs4, $06, nEb4, $06
	dc.b	nCs4, $06, nEb4, $06, nCs4, $06, nEb4, $06, nCs4, $06, nEb4, $06
	dc.b	nEb4, $06, nF4, $06, nEb4, $06, nF4, $06, nEb4, $06, nF4, $06
	dc.b	nEb4, $06, nF4, $06, nEb4, $06, nF4, $06, nEb4, $06, nF4, $06
	dc.b	nC4, $06, nD4, $06, nC4, $06, nD4, $06, nC4, $06, nD4, $06
	dc.b	nC4, $06, nD4, $06, nC4, $06, nD4, $06, nC4, $06, nD4, $06

Snd_LRZ2_Jump07:
	dc.b	nG2, $06, nA2, $06, nC3, $06, nA2, $06, nD3, $06, nA2, $06
	dc.b	nE3, $06, nA2, $06, nG3, $06, nD3, $06, nA3, $06, nC4, $06
	dc.b	nG3, $06, nD3, $06, nE3, $06, nG3, $06, nG2, $06, nA2, $06
	dc.b	nC3, $06, nA2, $06, nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b	nG3, $06, nD3, $06, nA3, $06, nE3, $06, nG3, $06, nE3, $06
	dc.b	nD3, $06, nE3, $06, nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b	nD3, $06, nA2, $06, nE3, $06, nA2, $06, nG3, $06, nD3, $06
	dc.b	nA3, $06, nC4, $06, nG3, $06, nD3, $06, nE3, $06, nG3, $06
	dc.b	nG2, $06, nA2, $06, nC3, $06, nA2, $06, nD3, $06, nA2, $06
	dc.b	nE3, $06, nA2, $06, nG3, $06, nD3, $06, nA3, $06, nE3, $06
	dc.b	nG3, $06, nE3, $06, nD3, $06, nE3, $06, nA3, $06, nRst, $06
	dc.b	nA3, $06, nA4, $06, nRst, $18, nA3, $06, nA3, $06, nRst, $06
	dc.b	nA3, $06, nRst, $18, nA3, $06, nRst, $06, nA3, $06, nA4, $06
	dc.b	nRst, $18, nA3, $06, nA3, $06, nRst, $06, nA3, $06, nRst, $18
	dc.b	nA3, $06, nRst, $06, nA3, $06, nA4, $06, nRst, $18, nA3, $06
	dc.b	nA3, $06, nRst, $06, nA3, $06, nRst, $18, nA3, $06, nRst, $06
	dc.b	nA3, $06, nA4, $06, nRst, $18, nA3, $06, nA3, $06, nRst, $06
	dc.b	nA3, $06, nRst, $18, nA3, $06, nRst, $06, nA3, $06, nA4, $06
	dc.b	nRst, $18, nA3, $06, nA3, $06, nRst, $06, nA3, $06, nRst, $18
	dc.b	nA3, $06, nRst, $06, nA3, $06, nA4, $06, nRst, $18, nA3, $06
	dc.b	nA3, $06, nRst, $06, nA3, $06, nRst, $18, nA3, $06, nRst, $06
	dc.b	nA3, $06, nA4, $06, nRst, $18, nA3, $06, nA3, $06, nRst, $06
	dc.b	nA3, $06, nRst, $18, nA3, $06, nRst, $06, nA3, $06, nA4, $06
	dc.b	nRst, $18, nA3, $06, nA3, $06, nRst, $06, nA3, $06, nRst, $18
	dc.b	nRst, $06, nA4, $04, nRst, $02, nA5, $04, nRst, $02, nA5, $04
	dc.b	nRst, $02, nRst, $06, nA4, $04, nRst, $02, nA5, $04, nRst, $02
	dc.b	nA5, $04, nRst, $02, nRst, $18, nRst, $18, nRst, $06, nA4, $04
	dc.b	nRst, $02, nA5, $04, nRst, $02, nA5, $04, nRst, $02, nRst, $06
	dc.b	nA4, $04, nRst, $02, nA5, $04, nRst, $02, nA5, $04, nRst, $02
	dc.b	nRst, $18, nRst, $18, nRst, $06, nA4, $04, nRst, $02, nA5, $04
	dc.b	nRst, $02, nA5, $04, nRst, $02, nRst, $06, nA4, $04, nRst, $02
	dc.b	nA5, $04, nRst, $02, nA5, $04, nRst, $02, nRst, $18, nRst, $18
	dc.b	nRst, $06, nA4, $04, nRst, $02, nA5, $04, nRst, $02, nA5, $04
	dc.b	nRst, $02, nRst, $06, nA4, $04, nRst, $02, nA5, $04, nRst, $02
	dc.b	nA5, $04, nRst, $02, nRst, $18, nRst, $18, nRst, $06, nA4, $04
	dc.b	nRst, $02, nA5, $04, nRst, $02, nA5, $04, nRst, $02, nRst, $06
	dc.b	nA4, $04, nRst, $02, nA5, $04, nRst, $02, nA5, $04, nRst, $02
	dc.b	nRst, $18, nRst, $18, nRst, $06, nA4, $04, nRst, $02, nA5, $04
	dc.b	nRst, $02, nA5, $04, nRst, $02, nRst, $06, nA4, $04, nRst, $02
	dc.b	nA5, $04, nRst, $02, nA5, $04, nRst, $02, nRst, $18, nRst, $18
	dc.b	nRst, $06, nA4, $04, nRst, $02, nA5, $04, nRst, $02, nA5, $04
	dc.b	nRst, $02, nRst, $06, nA4, $04, nRst, $02, nA5, $04, nRst, $02
	dc.b	nA5, $04, nRst, $02, nRst, $18, nRst, $18, nRst, $06, nA4, $04
	dc.b	nRst, $02, nA5, $04, nRst, $02, nA5, $04, nRst, $02, nRst, $06
	dc.b	nA4, $04, nRst, $02, nA5, $04, nRst, $02, nA5, $04, nRst, $02
	dc.b	nRst, $18, nRst, $18
	smpsJump            Snd_LRZ2_Jump07

; Unreachable
	smpsStop

; PSG3 Data
Snd_LRZ2_PSG3:
	smpsPSGvoice        sTone_02
	smpsPSGform         $E7
	dc.b	nRst, $54
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $60, nMaxPSG1, $60, nMaxPSG1, $0C

Snd_LRZ2_Jump06:
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $04, nMaxPSG1, $04, nMaxPSG1, $04
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $54
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $0C, nMaxPSG1, $0C, nMaxPSG1, $48, nMaxPSG1, $04, nMaxPSG1, $04, nMaxPSG1, $04
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $48, nMaxPSG1, $60, $60, nMaxPSG1, $0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $0C, nMaxPSG1, $0C, nMaxPSG1, $3C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $60, nMaxPSG1, $60, nMaxPSG1, $60, nMaxPSG1, $0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $0C, nMaxPSG1, $0C, nMaxPSG1, $3C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $60, nMaxPSG1, $60, nMaxPSG1, $0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $04, nMaxPSG1, $04, nMaxPSG1, $04
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $0C, nMaxPSG1, $3C, nMaxPSG1, $0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $0C, nMaxPSG1, $0C, nMaxPSG1, $3C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $60, nMaxPSG1, $18
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $42
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $24, nMaxPSG1, $3C, nMaxPSG1, $0C
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $0C, nMaxPSG1, $0C, nMaxPSG1, $3C
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $60, nMaxPSG1, $18
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06, nMaxPSG1, $42
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $0C
	smpsJump            Snd_LRZ2_Jump06

; Unreachable
	smpsStop
