Sound_56_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_4C_56_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_56_FM5,	$EE, $00

; FM5 Data
Sound_56_FM5:
	smpsSetvoice        $00
	dc.b	nB2, $06, nEb3
	smpsStop
