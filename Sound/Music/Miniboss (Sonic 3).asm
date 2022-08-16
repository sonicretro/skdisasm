Snd_S3_Miniboss_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Snd_S3_Miniboss_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $44

	smpsHeaderDAC       Snd_S3_Miniboss_DAC
	; The transposition of $C2 is too low, causing the octave calculation to underflow.
	; In drivers that don't calculate the octave (such as Sonic 1's and Sonic 2's
	; drivers, which are derived from SMPS 68k Type 1b), this invalid transpose causes
	; this channel's notes to play with nonsensical frequencies.
	; Calculating the correct transposition is tricky because you have to consider that
	; it's the sum of the transposition *with the note* that underflows the octave
	; calculation, so the correct transposition depends on which notes it is used with.
	; '(((x/12)&7)*12)+(x%12)' can be used to obtain a post-underflow version of the
	; transpositon. Then, if the notes used with this transposition would cause the sum
	; to exceed $60, then subtract $60 from the transposition.
	; $C2 run through the formula is $02, and the notes that this displacement is used
	; with are in the low octaves, so the sum will never exceed $60. Because of this,
	; $02 is the correct displacement.
	smpsHeaderFM        Snd_S3_Miniboss_FM1,	$C2, $03
	smpsHeaderFM        Snd_S3_Miniboss_FM2,	$0C, $0B
	smpsHeaderFM        Snd_S3_Miniboss_FM3,	$0C, $10
	smpsHeaderFM        Snd_S3_Miniboss_FM4,	$00, $14
	smpsHeaderFM        Snd_S3_Miniboss_FM5,	$00, $14
	smpsHeaderPSG       Snd_S3_Miniboss_PSG1,	$00, $00, $00, $00
	smpsHeaderPSG       Snd_S3_Miniboss_PSG2,	$03, $01, $00, $00
	smpsHeaderPSG       Snd_S3_Miniboss_PSG3,	$00, $00, $00, $00

; FM1 Data
Snd_S3_Miniboss_FM1:
	smpsSetvoice        $04
	dc.b	nC1, $18, nRst, $48
	smpsCall            Snd_S3_Miniboss_Call05
	smpsCall            Snd_S3_Miniboss_Call06
	smpsCall            Snd_S3_Miniboss_Call05
	smpsCall            Snd_S3_Miniboss_Call07
	smpsCall            Snd_S3_Miniboss_Call05
	smpsCall            Snd_S3_Miniboss_Call06
	smpsCall            Snd_S3_Miniboss_Call05
	smpsCall            Snd_S3_Miniboss_Call08
	smpsCall            Snd_S3_Miniboss_Call09
	smpsCall            Snd_S3_Miniboss_Call0A
	smpsCall            Snd_S3_Miniboss_Call09
	smpsCall            Snd_S3_Miniboss_Call0B
	smpsCall            Snd_S3_Miniboss_Call09
	smpsCall            Snd_S3_Miniboss_Call0A
	smpsCall            Snd_S3_Miniboss_Call0C
	smpsCall            Snd_S3_Miniboss_Call0B

Snd_S3_Miniboss_Loop01:
	smpsCall            Snd_S3_Miniboss_Call09
	smpsCall            Snd_S3_Miniboss_Call0A
	smpsCall            Snd_S3_Miniboss_Call09
	smpsCall            Snd_S3_Miniboss_Call0B
	smpsLoop            $00, $02, Snd_S3_Miniboss_Loop01
	smpsSetvoice        $04
	dc.b	nC1, $12, nC1, nC1, nC1, nC1, nC1, $06, nRst, $0C, nC1, $12
	dc.b	nC1, nC1, nC1, nC1, $0C, nRst, $60
	smpsJump            Snd_S3_Miniboss_FM1

Snd_S3_Miniboss_Call05:
	smpsSetvoice        $04
	dc.b	nC1, $0C, nRst, $07, nC1, $05, nRst, $0C, nC1, nRst, nC1, nRst
	dc.b	$18
	smpsReturn

Snd_S3_Miniboss_Call06:
	smpsSetvoice        $04
	dc.b	nC1, $0C, nRst, $07, nC1, $05, nRst, $0C, nC1, nRst, $07, nC1
	dc.b	$05, nC1, $0C, nRst, $18
	smpsReturn

Snd_S3_Miniboss_Call07:
	smpsSetvoice        $04
	dc.b	nC1, $0C, nRst, $18, nRst, $0C, nRst, nRst, nRst, nRst
	smpsReturn

Snd_S3_Miniboss_Call08:
	smpsSetvoice        $04
	dc.b	nC1, $18, nRst, nC1, $03, nC1, nC1, nC1, nC1, nC1, nC1, nC1
	dc.b	nC1, $18
	smpsReturn

Snd_S3_Miniboss_Call09:
	smpsSetvoice        $04
	dc.b	nC1, $0C, nRst, $07, nC1, $05
	smpsSetvoice        $05
	dc.b	nE3, $0C
	smpsSetvoice        $04
	dc.b	nC1, nRst, nC1
	smpsSetvoice        $05
	dc.b	nE3, $18
	smpsReturn

Snd_S3_Miniboss_Call0A:
	smpsSetvoice        $04
	dc.b	nC1, $0C, nRst, $07, nC1, $05
	smpsSetvoice        $05
	dc.b	nE3, $0C
	smpsSetvoice        $04
	dc.b	nC1, nRst, $07, nC1, $05, nC1, $0C
	smpsSetvoice        $05
	dc.b	nE3, $13, nE3, $05
	smpsReturn

Snd_S3_Miniboss_Call0B:
	smpsSetvoice        $04
	dc.b	nC1, $0C, nRst
	smpsSetvoice        $05
	dc.b	nE3
	smpsSetvoice        $04
	dc.b	nC1, nC1, nC1
	smpsSetvoice        $05
	dc.b	nE3
	smpsSetvoice        $04
	dc.b	nC1, $07
	smpsSetvoice        $05
	dc.b	nE3, $05
	smpsReturn

Snd_S3_Miniboss_Call0C:
	smpsSetvoice        $04
	dc.b	nC1, $0C, nRst, $07, nC1, $05
	smpsSetvoice        $05
	dc.b	nE3, $0C
	smpsSetvoice        $04
	dc.b	nC1, nRst, $07, nRst, $05, nC1, $0C
	smpsSetvoice        $05
	dc.b	nE3, $13, nE3, $05
	smpsReturn

; FM2 Data
Snd_S3_Miniboss_FM2:
	smpsSetvoice        $00
	dc.b	nBb2, $04, nRst, $03, $05, nRst, $07, nBb2, $05, nF2, $04, nRst
	dc.b	$03, $05, nRst, $07, nF2, $05, nBb1, $07, nRst, $29
	smpsCall            Snd_S3_Miniboss_Call03
	smpsCall            Snd_S3_Miniboss_Call04
	smpsCall            Snd_S3_Miniboss_Call03
	dc.b	nEb2, $04, nRst, $03, nBb1, $05, nFs2, $0C, nBb1, nCs2
	smpsCall            Snd_S3_Miniboss_Call03
	smpsCall            Snd_S3_Miniboss_Call04
	dc.b	nEb2, $04, nRst, $03, nEb2, $05, nD2, $0C, nCs2, nC2, nB1, nBb1
	dc.b	nB1, nD2
	smpsCall            Snd_S3_Miniboss_Call03
	smpsCall            Snd_S3_Miniboss_Call04
	smpsCall            Snd_S3_Miniboss_Call03
	dc.b	nEb2, $04, nRst, $03, nBb1, $05, nFs2, $0C, nBb1, nCs2
	smpsCall            Snd_S3_Miniboss_Call03
	smpsCall            Snd_S3_Miniboss_Call04
	dc.b	nEb2, $04, nRst, $03, nEb2, $05, nD2, $0C, nCs2, nC2, nRst, $24
	dc.b	nE2, $0C
	smpsModSet          $18, $01, $FE, $FF
	dc.b	nEb2, $30, nRst, $30
	smpsModOff
	dc.b	nRst, $60, nRst, nEb2, $04, nRst, $03, nEb2, $05, nD2, $0C, nCs2
	dc.b	nC2, nB1, nC2, nRst, nD2
	smpsCall            Snd_S3_Miniboss_Call03
	smpsCall            Snd_S3_Miniboss_Call04
	smpsCall            Snd_S3_Miniboss_Call03
	dc.b	nEb2, $04, nRst, $03, nBb1, $05, nFs2, $0C, nBb1, nCs2
	smpsCall            Snd_S3_Miniboss_Call03
	smpsCall            Snd_S3_Miniboss_Call04
	dc.b	nEb2, $04, nRst, $03, nEb2, $05, nD2, $0C, nCs2, nC2, nB1, nBb1
	dc.b	nB1, nD2, nRst, $60, nRst, nRst, nRst
	smpsCall            Snd_S3_Miniboss_Call03
	smpsCall            Snd_S3_Miniboss_Call04
	smpsCall            Snd_S3_Miniboss_Call03
	dc.b	nEb2, $04, nRst, $03, nBb1, $05, nFs2, $0C, nBb1, nCs2
	smpsCall            Snd_S3_Miniboss_Call03
	smpsCall            Snd_S3_Miniboss_Call04
	dc.b	nEb2, $04, nRst, $03, nEb2, $05, nD2, $0C, nCs2, nC2, nB1, nBb1
	dc.b	nB1, nD2, nEb2, $24, nD2, nCs2, nC2, nB1, nBb1, $6C
	smpsJump            Snd_S3_Miniboss_FM2

; Unreachable
	smpsStop

Snd_S3_Miniboss_Call03:
	dc.b	nEb2, $04, nRst, $03, nEb2, $05, nD2, $0C, nCs2, nD2
	smpsReturn

Snd_S3_Miniboss_Call04:
	dc.b	nEb2, $05, nRst, $07, nRst, nEb2, $05, nRst, $15, nD2, $03
	smpsReturn

; FM3 Data
Snd_S3_Miniboss_FM3:
	smpsSetvoice        $02
	smpsModSet          $01, $01, $01, $08
	dc.b	nBb4, $07, nBb4, $05, nRst, $07, nBb4, $05, nBb4, $07, nBb4, $05
	dc.b	nRst, $07, nBb4, $05, nBb4, nRst, $2B, nRst, $1F, nBb3, $05, nC4
	dc.b	nRst, $07, nCs4, $05, nRst, $07, nC4, nCs4, $05, nC4, $07, nAb3
	dc.b	$05, nFs3, nRst, $07, nRst, $60, nRst, $0C
	smpsModSet          $05, $01, $13, $0E
	dc.b	nCs4
	smpsModOff
	smpsFMAlterVol      $0A
	dc.b	nCs4, $06, nRst
	smpsFMAlterVol      $F6
	smpsModSet          $05, $01, $13, $0E
	dc.b	nAb3, $0C
	smpsModOff
	smpsFMAlterVol      $0A
	dc.b	nAb3, $06, nRst
	smpsFMAlterVol      $F6
	smpsModSet          $05, $01, $13, $0E
	dc.b	nFs3, $0C
	smpsModOff
	smpsFMAlterVol      $0A
	dc.b	nFs3, $06, nRst
	smpsFMAlterVol      $F6
	smpsModSet          $05, $01, $13, $0E
	dc.b	nAb3, $0C
	smpsModSet          $01, $01, $01, $06
	dc.b	nRst, $07, nFs3, $05, nRst, $0C, nEb3, $13
	smpsModOff
	dc.b	nEb3, $05, nFs3, $07, nAb3, $05, nRst, $24, nRst, $1F, nBb3, $05
	dc.b	nC4, nRst, $07, nCs4, $05, nRst, $07, nC4, nCs4, $05, nC4, $07
	dc.b	nRst, $05, nRst, $07, nBb3, $05, nC4, $07, nCs4, $05, nC4, nRst
	dc.b	$0E, nBb3, $05, nC4, $07, nCs4, $05, nC4, $07, nBb3, $05, nFs3
	dc.b	$0C, nRst, $18, nRst, $30, nEb3, $04, nD3, nEb3, nF3, nEb3, nF3
	dc.b	nFs3, nF3, nFs3, nAb3, nFs3, nAb3, nBb3, nFs3, nCs4, nC4, nAb3, nB3
	dc.b	nBb3, nFs3, nA3, nAb3, nFs3, nEb3, nRst, $18
	smpsModSet          $01, $01, $F1, $71
	dc.b	nAb2
	smpsModSet          $01, $01, $01, $05
	smpsAlterPitch      $F4
	dc.b	nRst, $0C, nEb4, $05, nRst, $07, nEb4, $05, nRst, $07, nEb4, $05
	dc.b	nRst, $07, nEb4, $05, nRst, $07, nEb4, $05, nRst, $07, nEb4, nFs4
	dc.b	$05, nRst, $18, nEb4, $05, nRst, $07, nEb4, $05, nRst, $07, nEb4
	dc.b	$05, nRst, $07, nEb4, $05, nRst, $07, nEb4, $05, nRst, $07, nEb4
	dc.b	nFs4, $05, nRst, $18, nEb4, $05, nRst, $07, nEb4, $05, nRst, $07
	dc.b	nEb4, $05, nRst, $07, nEb4, nFs4, $05, nAb4, $07, nFs4, $05, nEb4
	dc.b	$07, nFs4, $05, nAb4, $07, nFs4, $05, nEb4, $05, nRst, $07, nEb4
	dc.b	$05, nRst, $07, nEb4, $05, nRst, $07, nEb4, $05, nRst, $07, nEb4
	dc.b	nFs4, $05, nRst, $1F, nEb4, $04, nRst, $01
	smpsCall            Snd_S3_Miniboss_Call01

Snd_S3_Miniboss_Loop00:
	dc.b	nRst, $5B, nEb4, $03, nRst, $02
	smpsCall            Snd_S3_Miniboss_Call01
	smpsLoop            $00, $03, Snd_S3_Miniboss_Loop00
	smpsCall            Snd_S3_Miniboss_Call02
	dc.b	nRst, $60, nRst, $2B, nEb4, $05, nFs4, nRst, $07, nFs4, $05, nRst
	dc.b	$07, nFs4, nAb4, $05, nBb4, $07, nAb4, $05, nRst, $60
	smpsCall            Snd_S3_Miniboss_Call02
	smpsCall            Snd_S3_Miniboss_Call00
	smpsAlterPitch      $0C
	smpsJump            Snd_S3_Miniboss_FM3

Snd_S3_Miniboss_Call00:
	smpsModChange       $07
	dc.b	nEb4, $0C
	smpsModChange       $08
	dc.b	nD4, nEb4, nF4, nEb4, nF4
	smpsModChange       $07
	dc.b	nFs4
	smpsModChange       $08
	dc.b	nF4, nFs4, $07, nRst, $05
	smpsModChange       $07
	dc.b	nAb4, $0C
	smpsModChange       $08
	dc.b	nFs4, nAb4
	smpsModChange       $07
	dc.b	nA4
	smpsModSet          $01, $01, $01, $08
	dc.b	nAb4, nA4, nBb4, $0C, smpsNoAttack, $60
	smpsReturn

Snd_S3_Miniboss_Call01:
	dc.b	nRst, $07, nFs4, $04, nRst, $08, nAb4, $05, nRst, $13, nEb4, $05
	dc.b	nFs4, nRst, $07, nFs4, $05, nRst, $07, nFs4, nAb4, $05, nRst, $0C
	smpsReturn

Snd_S3_Miniboss_Call02:
	smpsModChange       $06
	dc.b	nBb4, $0C
	smpsModOff
	dc.b	nAb4, $07, nBb4, $05
	smpsModChange       $06
	dc.b	nAb4, $0C
	smpsModOff
	dc.b	nFs4, $07, nAb4, $05
	smpsModChange       $06
	dc.b	nFs4, $0C
	smpsModOff
	dc.b	nF4, $07, nFs4, $05
	smpsModChange       $06
	dc.b	nF4, $0C
	smpsModOff
	dc.b	nEb4, $05, nRst, $07
	smpsReturn

; FM4 Data
Snd_S3_Miniboss_FM4:
	smpsSetvoice        $03
	smpsFMAlterVol      $02
	dc.b	nBb3, $07, nBb3, $05, nRst, $07, nBb3, $05, nBb3, $07, nBb3, $05
	dc.b	nRst, $07, nBb3, $05, nBb3, nRst, $2B
	smpsFMAlterVol      $FE
	dc.b	nBb3, $60, smpsNoAttack, $30, nRst, $18, nB4, $18, nBb3, $60, smpsNoAttack, $30
	dc.b	nRst, $30, nBb3, $60, smpsNoAttack, $30, nRst, $18, nB4, $18, nBb3, $60
	dc.b	nRst, $60, nBb3, $60, smpsNoAttack, $30, nB3, $30, nBb3, $60, smpsNoAttack, $60
	dc.b	nFs3, $48, nRst, $18, nF4, $60, nBb3, $60, nBb3, $60, nRst, $60
	dc.b	nRst, nRst, nRst, nFs4, $60, nF4, $60, nEb4, $60, nEb4, $60
	smpsAlterPitch      $F4
	smpsFMAlterVol      $02
	smpsCall            Snd_S3_Miniboss_Call00
	smpsFMAlterVol      $FE
	smpsAlterPitch      $0C
	smpsJump            Snd_S3_Miniboss_FM4

; FM5 Data
Snd_S3_Miniboss_FM5:
	smpsSetvoice        $03

Snd_S3_Miniboss_Jump00:
	smpsModSet          $01, $01, $01, $04
	smpsFMAlterVol      $02
	dc.b	nBb3, $07, nBb3, $05, nRst, $07, nBb3, $05, nBb3, $07, nBb3, $05
	dc.b	nRst, $07, nBb3, $05, nBb3, nRst, $2B
	smpsFMAlterVol      $FE
	dc.b	nF3, $60, smpsNoAttack, $30, nRst, $18, nFs3, nF3, $60, smpsNoAttack, $48, nRst
	dc.b	$18, nF3, $60, smpsNoAttack, $48, nFs3, $18, nF3, $60, nRst, $60, nF3
	dc.b	$60, smpsNoAttack, $30, nFs3, $30, nF3, $60, smpsNoAttack, nF3, $60, nEb3, $48
	dc.b	nRst, $18, nC3, $60, nB2, $60, nC3, $60, nRst, $60, nRst, nRst
	dc.b	nRst, nEb4, $60, nC4, nB3, nC4
	smpsFMAlterVol      $02
	smpsCall            Snd_S3_Miniboss_Call00
	smpsFMAlterVol      $FE
	smpsJump            Snd_S3_Miniboss_Jump00

; PSG2 Data
Snd_S3_Miniboss_PSG2:
	smpsPSGvoice        sTone_1D
	smpsModSet          $01, $01, $05, $96
	dc.b	nRst, $60, nG2, $10, nRst, $50, nRst, $60, nRst, nRst, nG2, $10
	dc.b	nRst, $50, nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst, nG2, $10
	dc.b	nRst, $50, nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst, nG2, $10
	dc.b	nRst, $50, nRst, $60, nRst, nRst, nRst, nRst, nRst
	smpsJump            Snd_S3_Miniboss_PSG2

; PSG1 Data
Snd_S3_Miniboss_PSG1:
	smpsPSGvoice        sTone_22
	smpsModSet          $01, $01, $01, $08
	dc.b	nBb4, $07, nBb4, $05, nRst, $07, nBb4, $05, nBb4, $07, nBb4, $05
	dc.b	nRst, $07, nBb4, $05, nBb4, nRst, $2B, nRst, $1F, nBb3, $05, nC4
	dc.b	nRst, $07, nCs4, $05, nRst, $07, nC4, nCs4, $05, nC4, $07, nAb3
	dc.b	$05, nFs3, nRst, $07, nRst, $60, nRst, $0C
	smpsModSet          $05, $01, $13, $0E
	dc.b	nCs4
	smpsModOff
	smpsPSGAlterVol     $0A
	dc.b	nCs4, $06, nRst
	smpsPSGAlterVol     $F6
	smpsModSet          $05, $01, $13, $0E
	dc.b	nAb3, $0C
	smpsModOff
	smpsPSGAlterVol     $0A
	dc.b	nAb3, $06, nRst
	smpsPSGAlterVol     $F6
	smpsModSet          $05, $01, $13, $0E
	dc.b	nFs3, $0C
	smpsModOff
	smpsPSGAlterVol     $0A
	dc.b	nFs3, $06, nRst
	smpsPSGAlterVol     $F6
	smpsModSet          $05, $01, $13, $0E
	dc.b	nAb3, $0C
	smpsModChange       $04
	dc.b	nRst, $07, nFs3, $05, nRst, $0C, nEb3, $13
	smpsModOff
	dc.b	nEb3, $05, nFs3, $07, nAb3, $05, nRst, $24, nRst, $1F, nBb3, $05
	dc.b	nC4, nRst, $07, nCs4, $05, nRst, $07, nC4, nCs4, $05, nC4, $07
	dc.b	nRst, $05, nRst, $07, nBb3, $05, nC4, $07, nCs4, $05, nC4, nRst
	dc.b	$0E, nBb3, $05, nC4, $07, nCs4, $05, nC4, $07, nBb3, $05, nFs3
	dc.b	$0C, nRst, $18, nRst, $30, nEb3, $04, nD3, nEb3, nF3, nEb3, nF3
	dc.b	nFs3, nF3, nFs3, nAb3, nFs3, nAb3, nBb3, nFs3, nCs4, nC4, nAb3, nB3
	dc.b	nBb3, nFs3, nA3, nAb3, nFs3, nEb3, nRst, $18
	smpsModSet          $01, $01, $F1, $71
	dc.b	nAb2
	smpsModChange       $04
	smpsAlterPitch      $F4
	dc.b	nRst, $0C, nEb4, $05, nRst, $07, nEb4, $05, nRst, $07, nEb4, $05
	dc.b	nRst, $07, nEb4, $05, nRst, $07, nEb4, $05, nRst, $07, nEb4, nFs4
	dc.b	$05, nRst, $18, nEb4, $05, nRst, $07, nEb4, $05, nRst, $07, nEb4
	dc.b	$05, nRst, $07, nEb4, $05, nRst, $07, nEb4, $05, nRst, $07, nEb4
	dc.b	nFs4, $05, nRst, $18, nEb4, $05, nRst, $07, nEb4, $05, nRst, $07
	dc.b	nEb4, $05, nRst, $07, nEb4, nFs4, $05, nAb4, $07, nFs4, $05, nEb4
	dc.b	$07, nFs4, $05, nAb4, $07, nFs4, $05, nEb4, $05, nRst, $07, nEb4
	dc.b	$05, nRst, $07, nEb4, $05, nRst, $07, nEb4, $05, nRst, $07, nEb4
	dc.b	nFs4, $05, nRst, $1F, nEb4, $04, nRst, $01
	smpsCall            Snd_S3_Miniboss_Call01

Snd_S3_Miniboss_Loop06:
	dc.b	nRst, $5B, nEb4, $03, nRst, $02
	smpsCall            Snd_S3_Miniboss_Call01
	smpsLoop            $00, $03, Snd_S3_Miniboss_Loop06
	smpsCall            Snd_S3_Miniboss_Call02
	dc.b	nRst, $60, nRst, $2B, nEb4, $05, nFs4, nRst, $07, nFs4, $05, nRst
	dc.b	$07, nFs4, nAb4, $05, nBb4, $07, nAb4, $05, nRst, $60
	smpsCall            Snd_S3_Miniboss_Call02
	smpsCall            Snd_S3_Miniboss_Call00
	smpsAlterPitch      $0C
	smpsJump            Snd_S3_Miniboss_PSG1

; PSG3 Data
Snd_S3_Miniboss_PSG3:
	smpsPSGform         $E7
	dc.b	nRst, $60
	smpsPSGvoice        sTone_26
	dc.b	nMaxPSG1, $60
	smpsPSGvoice        sTone_02
	smpsCall            Snd_S3_Miniboss_Call0D
	dc.b	nRst, $60
	smpsCall            Snd_S3_Miniboss_Call0D
	smpsPSGvoice        sTone_26
	dc.b	nMaxPSG1, $60
	smpsPSGvoice        sTone_02
	smpsCall            Snd_S3_Miniboss_Call0D
	dc.b	nRst, $48, nMaxPSG1, $07, nRst, $0C, nMaxPSG1, $05, nRst, $0C, nMaxPSG1, nRst
	dc.b	nMaxPSG1, nMaxPSG1, nMaxPSG1, nMaxPSG1, nRst

Snd_S3_Miniboss_Loop02:
	smpsCall            Snd_S3_Miniboss_Call0D
	smpsLoop            $00, $03, Snd_S3_Miniboss_Loop02
	dc.b	nMaxPSG1, $0C, nMaxPSG1, nMaxPSG1, nMaxPSG1, nMaxPSG1, nMaxPSG1, nMaxPSG1, nRst

Snd_S3_Miniboss_Loop03:
	smpsCall            Snd_S3_Miniboss_Call0D
	smpsLoop            $00, $03, Snd_S3_Miniboss_Loop03
	dc.b	nMaxPSG1, $07
	smpsPSGAlterVol     $04
	dc.b	$05, $07
	smpsPSGAlterVol     $FC
	dc.b	$05
	smpsPSGAlterVol     $04
	dc.b	$07, $05
	smpsPSGAlterVol     $FC
	dc.b	$07
	smpsPSGAlterVol     $04
	dc.b	$05
	smpsPSGAlterVol     $FC
	dc.b	nMaxPSG1, $0C, nMaxPSG1, nMaxPSG1, nRst

Snd_S3_Miniboss_Loop04:
	smpsCall            Snd_S3_Miniboss_Call0D
	smpsLoop            $00, $03, Snd_S3_Miniboss_Loop04
	dc.b	nRst, $60

Snd_S3_Miniboss_Loop05:
	smpsCall            Snd_S3_Miniboss_Call0D
	smpsLoop            $00, $03, Snd_S3_Miniboss_Loop05
	dc.b	nMaxPSG1, $0C, nRst, $07, nMaxPSG1, $05, nRst, $0C, nMaxPSG1, nMaxPSG1, nMaxPSG1, nMaxPSG1
	dc.b	nRst, nRst, $60, nRst, nRst
	smpsJump            Snd_S3_Miniboss_PSG3

; Unreachable
	smpsStop

Snd_S3_Miniboss_Call0D:
	dc.b	nMaxPSG1, $07
	smpsPSGAlterVol     $04
	dc.b	$05, $07
	smpsPSGAlterVol     $FC
	dc.b	$05
	smpsPSGAlterVol     $04
	dc.b	$07, $05
	smpsPSGAlterVol     $FC
	dc.b	$07
	smpsPSGAlterVol     $04
	dc.b	$05, $0C
	smpsPSGAlterVol     $FC
	dc.b	$24
	smpsReturn

; DAC Data
Snd_S3_Miniboss_DAC:
	dc.b	nRst, $30, $0C, dCrashingNoiseWoo, dComeOn, nRst, dHipHopHitKick, nRst, $54, nRst, $0C, dLowerEchoedClapHit_S3
	dc.b	dEchoedClapHit_S3, $08, dLowerEchoedClapHit_S3, $04, $0C, $0C, $08, $04, dEchoedClapHit_S3, $0C, dBassHey, dHipHopHitKick
	dc.b	nRst, $54, nRst, $0C, dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08, dLowerEchoedClapHit_S3, $04, $0C, dHipHopHitKick, dHipHopHitPowerKick
	dc.b	dPowerKickHit, dLowPowerKickHit, dHipHopHitKick, nRst, $48, dHipHopHitKick, $0C, nRst, $0C, dLowerEchoedClapHit_S3, dHipHopHitKick, $08
	dc.b	dLowerEchoedClapHit_S3, $04, $0C, $0C, $08, dEchoedClapHit_S3, $04, dLowestPowerKickHit, $0C, dBassHey, dHipHopHitKick, $48
	dc.b	dLowerEchoedClapHit_S3, $0C, $08, $04, $08, dEchoedClapHit_S3, $04, dLowerEchoedClapHit_S3, $0C, $0C, $08, $04
	dc.b	dHipHopHitKick, $0C, dHipHopHitPowerKick, nRst, dWoo, dHipHopHitKick, $0C, dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08, dLowerEchoedClapHit_S3, $04
	dc.b	$0C, $0C, $08, $04, dEchoedClapHit_S3, $18, nRst, $0C, dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08, dLowerEchoedClapHit_S3
	dc.b	$04, $0C, $14, $04, dEchoedClapHit_S3, $0C, dBassHey, dHipHopHitKick, $0C, dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08
	dc.b	dLowerEchoedClapHit_S3, $04, $0C, $0C, $08, $04, dEchoedClapHit_S3, $18, dHipHopHitKick, $07, $05, dHipHopHitPowerKick
	dc.b	$0C, dPowerKickHit, dLowPowerKickHit, dLowerPowerKickHit, dLowPowerKickHit, dComeOn, dHipHopHitPowerKick, dHipHopHitKick, $0C, dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08
	dc.b	dLowerEchoedClapHit_S3, $04, $0C, $0C, $08, $04, dEchoedClapHit_S3, $18, nRst, $0C, dLowerEchoedClapHit_S3, dWoo
	dc.b	$08, nRst, $04, dLowerEchoedClapHit_S3, $0C, $14, $04, dEchoedClapHit_S3, $0C, dBassHey, nRst, $0C
	dc.b	dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08, dLowerEchoedClapHit_S3, $04, $0C, $0C, $08, $04, dEchoedClapHit_S3, $18, nRst
	dc.b	$0C, dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08, $04, $0C, dHipHopHitKick, dHipHopHitKick, dComeOn, dHipHopHitKick, dHipHopHitKick, $0C
	dc.b	dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08, dLowerEchoedClapHit_S3, $04, $0C, $0C, $08, $04, dEchoedClapHit_S3, $18, nRst
	dc.b	$0C, dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08, dLowerEchoedClapHit_S3, $04, dWoo, $0C, dLowerEchoedClapHit_S3, $14, $04, dEchoedClapHit_S3
	dc.b	$0C, dBassHey, dHipHopHitKick, $0C, dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08, $04, $0C, $0C, $08, $04
	dc.b	dEchoedClapHit_S3, $18, nRst, $0C, nRst, dHipHopHitKick, nRst, dHipHopHitKick, dHipHopHitKick, dComeOn, dHipHopHitKick, dHipHopHitKick
	dc.b	$0C, dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08, dLowerEchoedClapHit_S3, $04, $0C, $0C, $08, $04, dEchoedClapHit_S3, $18
	dc.b	nRst, $0C, dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08, dLowerEchoedClapHit_S3, $04, $0C, $14, $04, dEchoedClapHit_S3, $0C
	dc.b	dBassHey, dHipHopHitKick, $0C, dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08, dLowerEchoedClapHit_S3, $04, $0C, $0C, $08, $04
	dc.b	dEchoedClapHit_S3, $18, nRst, $0C, nRst, dHipHopHitKick, nRst, dHipHopHitKick, dHipHopHitKick, dComeOn, dHipHopHitKick, nRst
	dc.b	$60, nRst, nRst, $0C, dLowerEchoedClapHit_S3, dEchoedClapHit_S3, $08, dLowerEchoedClapHit_S3, $04, $0C, $0C, $08
	dc.b	$04, dEchoedClapHit_S3, $18
	smpsJump            Snd_S3_Miniboss_DAC

; Unreachable
	smpsStop

Snd_S3_Miniboss_Voices:
;	Voice $00
;	$02
;	$02, $00, $00, $01, 	$1F, $1F, $1F, $1F, 	$00, $10, $08, $00
;	$0E, $00, $00, $08, 	$0F, $FF, $FF, $0F, 	$20, $1A, $10, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $00, $00, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $08, $10, $00
	smpsVcDecayRate2    $08, $00, $00, $0E
	smpsVcDecayLevel    $00, $0F, $0F, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $10, $1A, $20

;	Voice $01
;	$05
;	$00, $00, $00, $00, 	$1F, $1F, $1F, $1F, 	$12, $0C, $0C, $0C
;	$12, $18, $1F, $1F, 	$1F, $1F, $1F, $1F, 	$07, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0C, $0C, $0C, $12
	smpsVcDecayRate2    $1F, $1F, $18, $12
	smpsVcDecayLevel    $01, $01, $01, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $07

;	Voice $02
;	$15
;	$01, $05, $06, $06, 	$9F, $DF, $DF, $DF, 	$0B, $00, $00, $09
;	$08, $00, $00, $00, 	$40, $CF, $CF, $CF, 	$09, $90, $90, $A0
	smpsVcAlgorithm     $05
	smpsVcFeedback      $02
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $06, $06, $05, $01
	smpsVcRateScale     $03, $03, $03, $02
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $09, $00, $00, $0B
	smpsVcDecayRate2    $00, $00, $00, $08
	smpsVcDecayLevel    $0C, $0C, $0C, $04
	smpsVcReleaseRate   $0F, $0F, $0F, $00
	smpsVcTotalLevel    $20, $10, $10, $09

;	Voice $03
;	$1C
;	$01, $01, $01, $01, 	$9F, $DF, $9F, $5F, 	$0F, $12, $06, $06
;	$00, $07, $0B, $07, 	$FF, $2F, $FF, $FF, 	$18, $87, $11, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $03
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $01, $02, $03, $02
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $06, $12, $0F
	smpsVcDecayRate2    $07, $0B, $07, $00
	smpsVcDecayLevel    $0F, $0F, $02, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $11, $07, $18

;	Voice $04
;	$05
;	$00, $00, $00, $00, 	$1F, $1F, $1F, $1F, 	$12, $0C, $0C, $0C
;	$12, $18, $1F, $1F, 	$1F, $1F, $1F, $1F, 	$07, $86, $86, $86
	smpsVcAlgorithm     $05
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0C, $0C, $0C, $12
	smpsVcDecayRate2    $1F, $1F, $18, $12
	smpsVcDecayLevel    $01, $01, $01, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $06, $06, $06, $07

;	Voice $05
;	$3C
;	$00, $00, $F0, $F1, 	$1F, $1F, $17, $1F, 	$1F, $1F, $14, $1F
;	$09, $11, $3A, $1D, 	$02, $0F, $9F, $7F, 	$03, $80, $02, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $0F, $0F, $00, $00
	smpsVcCoarseFreq    $01, $00, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $17, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $1F, $14, $1F, $1F
	smpsVcDecayRate2    $1D, $3A, $11, $09
	smpsVcDecayLevel    $07, $09, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $02
	smpsVcTotalLevel    $00, $02, $00, $03
