Sound_6B_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_6B_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG2, Sound_6B_PSG2,	$0C, $00

; PSG2 Data
Sound_6B_PSG2:
	smpsModSet          $01, $01, $E6, $35
	dc.b	nCs1, $06
	smpsStop

; Song seems to not use any FM voices
Sound_6B_Voices:
