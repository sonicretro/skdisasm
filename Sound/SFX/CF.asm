Sound_CF_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_CF_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG3, Sound_CE_CF_PSG3,	$E1, $00

; Song seems to not use any FM voices
Sound_CF_Voices:
