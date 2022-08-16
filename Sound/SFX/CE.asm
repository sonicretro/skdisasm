Sound_CE_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_CE_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG3, Sound_CE_CF_PSG3,	$E1, $05

; PSG3 Data
Sound_CE_CF_PSG3:
	smpsPSGform         $E7
	smpsModSet          $0F, $01, $FF, $47
	smpsPSGvoice        $00

Sound_CE_CF_Loop00:
	dc.b	nA7, $16, smpsNoAttack
	smpsContinuousLoop  Sound_CE_CF_Loop00
	dc.b	$01
	smpsStop

; Song seems to not use any FM voices
Sound_CE_Voices:
