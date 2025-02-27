Sound_8D_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_8D_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG3, Sound_8D_PSG3,	$1F, $05

; PSG3 Data
Sound_8D_PSG3:
	smpsPSGform         $E7
	smpsPSGvoice        sTone_16
	smpsModSet          $01, $01, $F0, $17
	dc.b	nD4, $03, $03, $03, $03, $04
	smpsStop

; Song seems to not use any FM voices
Sound_8D_Voices:
