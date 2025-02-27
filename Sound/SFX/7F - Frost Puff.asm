Sound_7F_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_7F_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG3, Sound_7F_PSG3,	$E5, $01

; PSG3 Data
Sound_7F_PSG3:
	smpsPSGform         $E7
	dc.b	nF5, $05
	smpsModSet          $02, $03, $F5, $0A
	dc.b	nEb6, $06, nE6, $05, nB4, $03, nE6, $05, nB4, $03
	smpsStop

; Song seems to not use any FM voices
Sound_7F_Voices:
