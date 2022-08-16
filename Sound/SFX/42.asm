Sound_42_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_42_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG3, Sound_42_PSG3,	$10, $00

; PSG3 Data
Sound_42_PSG3:
	smpsPSGform         $E7
	smpsPSGvoice        sTone_17
	dc.b	nCs6, $04
	smpsModSet          $02, $01, $06, $07
	dc.b	nE5, $10
	smpsStop

; Song seems to not use any FM voices
Sound_42_Voices:
