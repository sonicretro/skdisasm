Sound_A6_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_A6_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG3, Sound_A6_PSG3,	$02, $00

; PSG3 Data
Sound_A6_PSG3:
	smpsPSGform         $E7
	smpsPSGvoice        sTone_1D
	smpsModSet          $01, $01, $E0, $CA
	dc.b	nF4, $03, nFs4, $0D
	smpsStop

; Song seems to not use any FM voices
Sound_A6_Voices:
