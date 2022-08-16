Sound_DB_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_DB_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG3, Sound_DB_PSG3,	$00, $00

; PSG3 Data
Sound_DB_PSG3:
	smpsPSGform         $E7
	dc.b	nA6, $05

Sound_DB_Loop00:
	dc.b	smpsNoAttack, nMaxPSG2, $16
	smpsContinuousLoop  Sound_DB_Loop00
	smpsStop

; Song seems to not use any FM voices
Sound_DB_Voices:
