Snd_Emerald_Header:
	smpsHeaderStartSong 3, 1
	smpsHeaderVoice     Snd_Emerald_Voices
	smpsHeaderChan      $07, $03
	smpsHeaderTempo     $01, $35

	smpsHeaderDAC       Snd_Emerald_DAC
	smpsHeaderFM        Snd_Emerald_FM1,	$F4, $08
	smpsHeaderFM        Snd_Emerald_FM2,	$F4, $08
	smpsHeaderFM        Snd_Emerald_FM3,	$F4, $07
	smpsHeaderFM        Snd_Emerald_FM4,	$F4, $16
	smpsHeaderFM        Snd_Emerald_FM5,	$F4, $16
	smpsHeaderFM        Snd_Emerald_FM6,	$F4, $16
	smpsHeaderPSG       Snd_Emerald_PSG1,	$F4, $02, $00, sTone_04
	smpsHeaderPSG       Snd_Emerald_PSG2,	$F4, $02, $00, sTone_05
	smpsHeaderPSG       Snd_Emerald_PSG3,	$F4, $00, $00, sTone_04

; FM3 Data
Snd_Emerald_FM3:
	smpsAlterNote       $02

; FM1 Data
Snd_Emerald_FM1:
	smpsSetvoice        $00
	dc.b	nE5, $06, nG5, nC6, nE6, $0C, nC6, nG6, $2A
	smpsStop

; FM2 Data
Snd_Emerald_FM2:
	smpsSetvoice        $00
	dc.b	nC5, $06, nE5, nG5, nC6, $0C, nA5, nD6, $2A
	smpsStop

; FM4 Data
Snd_Emerald_FM4:
	smpsSetvoice        $01
	dc.b	nE5, $0C, nE5, $06, nG5, $06, nRst, nG5, nRst, nC6, $2A
	smpsStop

; FM5 Data
Snd_Emerald_FM5:
	smpsSetvoice        $01
	dc.b	nC6, $0C, nC6, $06, nE6, $06, nRst, nE6, nRst, nG6, $2A
	smpsStop

; FM6 Data
; There is FM channel 6 data in this song, however the Sonic & Knuckles sound driver doesn't support FM on channel 6, causing it to be silent
; This is likely a left over from Sonic 1 and 2 where those game's sound drivers do support FM on channel 6
Snd_Emerald_FM6:
	smpsSetvoice        $01
	dc.b	nG5, $0C, nG5, $06, nC6, $06, nRst, nC6, nRst, nE6, $2A
	smpsStop

; PSG2 Data
Snd_Emerald_PSG2:
	dc.b	nRst, $2D

Snd_Emerald_Loop01:
	dc.b	nG5, $06, nF5, nE5, nD5
	smpsPSGAlterVol     $03
	smpsLoop            $00, $04, Snd_Emerald_Loop01
	smpsStop

; PSG1 Data
Snd_Emerald_PSG1:
	smpsNop             $01
	dc.b	nRst, $02, nRst, $2D

Snd_Emerald_Loop00:
	dc.b	nG5, $06, nF5, nE5, nD5
	smpsPSGAlterVol     $03
	smpsLoop            $00, $04, Snd_Emerald_Loop00

; DAC Data
Snd_Emerald_DAC:
; PSG3 Data
Snd_Emerald_PSG3:
	smpsStop

Snd_Emerald_Voices:
;	Voice $00
;	$04
;	$35, $72, $54, $46, 	$1F, $1F, $1F, $1F, 	$07, $0A, $07, $0D
;	$00, $0B, $00, $0B, 	$1F, $0F, $1F, $0F, 	$23, $14, $1D, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $05, $07, $03
	smpsVcCoarseFreq    $06, $04, $02, $05
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0D, $07, $0A, $07
	smpsVcDecayRate2    $0B, $00, $0B, $00
	smpsVcDecayLevel    $00, $01, $00, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $80, $1D, $14, $23

;	Voice $01
;	$3C
;	$31, $52, $50, $30, 	$52, $53, $52, $53, 	$08, $00, $08, $00
;	$04, $00, $04, $00, 	$10, $07, $10, $07, 	$1A, $80, $16, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $05, $05, $03
	smpsVcCoarseFreq    $00, $00, $02, $01
	smpsVcRateScale     $01, $01, $01, $01
	smpsVcAttackRate    $13, $12, $13, $12
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $08, $00, $08
	smpsVcDecayRate2    $00, $04, $00, $04
	smpsVcDecayLevel    $00, $01, $00, $01
	smpsVcReleaseRate   $07, $00, $07, $00
	smpsVcTotalLevel    $80, $16, $80, $1A

