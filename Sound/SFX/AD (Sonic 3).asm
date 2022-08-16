S3_Sound_AD_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_A7_AD_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM3, S3_Sound_AD_FM3,	$17, $0C ; This channel was changed to FM4 in Sonic & Knuckles.

; FM3 Data
S3_Sound_AD_FM3:
	smpsSetvoice        $00
	dc.b	nB4, $48
	smpsStop
