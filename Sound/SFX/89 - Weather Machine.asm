Sound_89_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_89_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG2, Sound_89_PSG2,	$FB, $02

; PSG2 Data
Sound_89_PSG2:
	dc.b	nD4, $05
	smpsStop

; Song seems to not use any FM voices
Sound_89_Voices:
