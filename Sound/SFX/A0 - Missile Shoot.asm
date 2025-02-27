Sound_A0_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_A0_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG3, Sound_A0_PSG3,	$00, $00

; PSG3 Data
Sound_A0_PSG3:
	smpsPSGform         $E7
	smpsPSGvoice        sTone_1D
	smpsModSet          $01, $01, $FE, $53
	dc.b	nAb6, $06, nEb5, $38
	smpsStop

; Song seems to not use any FM voices
Sound_A0_Voices:
