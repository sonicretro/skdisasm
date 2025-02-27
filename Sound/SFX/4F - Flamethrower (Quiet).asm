Sound_4F_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_4F_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG3, Sound_4F_PSG3,	$00, $03

; PSG3 Data
Sound_4F_PSG3:
	smpsPSGform         $E7
	dc.b	nG3, $10
	smpsStop

; Song seems to not use any FM voices
Sound_4F_Voices:
