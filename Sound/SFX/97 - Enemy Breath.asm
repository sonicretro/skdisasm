Sound_97_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_97_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG3, Sound_97_PSG3,	$14, $02

; PSG3 Data
Sound_97_PSG3:
	smpsPSGform         $E7
	smpsPSGvoice        sTone_11
	dc.b	nCs6, $04, (nMaxPSG2-$14)&$FF, $7F
	smpsStop

; Song seems to not use any FM voices
Sound_97_Voices:
