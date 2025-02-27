Sound_36_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_36_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cPSG2, Sound_36_PSG2,	$00, $00
	smpsHeaderSFXChannel cPSG1, Sound_36_PSG1,	$FE, $00

; PSG1 Data
Sound_36_PSG1:
	dc.b	nRst, $01

; PSG2 Data
Sound_36_PSG2:
	smpsPSGvoice        sTone_0D
	dc.b	nBb3, $01, nRst, nBb3, nRst, $03

Sound_36_Loop00:
	dc.b	nBb3, $01, nRst, $01
	smpsLoop            $00, $0B, Sound_36_Loop00
	smpsStop

; Song seems to not use any FM voices
Sound_36_Voices:
