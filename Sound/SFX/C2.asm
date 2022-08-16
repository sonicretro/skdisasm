Sound_C2_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_C2_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG3, Sound_C2_PSG3,	$00, $00

; PSG3 Data
Sound_C2_PSG3:
	smpsPSGform         $E7
	dc.b	nCs4

Sound_C2_Loop00:
	dc.b	$04, $04, $04, $04, $03, $03
	smpsContinuousLoop  Sound_C2_Loop00
	smpsStop

; Song seems to not use any FM voices
Sound_C2_Voices:
