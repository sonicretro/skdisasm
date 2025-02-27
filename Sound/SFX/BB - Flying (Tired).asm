Sound_BB_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_BA_BB_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM4, Sound_BB_FM4,	$FA, $0B

; FM4 Data
Sound_BB_FM4:
	smpsSetvoice        $00
	dc.b	nE2, $08, $08
	smpsStop
