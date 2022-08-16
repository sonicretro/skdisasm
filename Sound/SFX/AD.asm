Sound_AD_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_A7_AD_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM4, Sound_AD_FM4,	$17, $0C

; FM4 Data
Sound_AD_FM4:
	smpsSetvoice        $00
	dc.b	nB4, $48
	smpsStop
