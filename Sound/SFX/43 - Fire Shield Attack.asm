Sound_43_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_43_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG3, Sound_43_PSG3,	$00, $00

; PSG3 Data
Sound_43_PSG3:
	smpsPSGform         $E7
	dc.b	nD3, $15, smpsNoAttack

Sound_43_Loop00:
	dc.b	$02
	smpsPSGAlterVol     $01
	dc.b	smpsNoAttack
	smpsLoop            $00, $10, Sound_43_Loop00
	smpsStop

; Song seems to not use any FM voices
Sound_43_Voices:
