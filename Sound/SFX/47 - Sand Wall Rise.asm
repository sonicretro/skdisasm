Sound_47_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_47_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG3, Sound_47_PSG3,	$00, $00

; PSG3 Data
Sound_47_PSG3:
	smpsPSGform         $E7
	smpsPSGvoice        sTone_0D
	dc.b	nMaxPSG2, $02, smpsNoAttack, nMaxPSG1, smpsNoAttack, nA6, smpsNoAttack, nAb6

Sound_47_Loop00:
	dc.b	smpsNoAttack, nG6
	smpsPSGAlterVol     $01
	smpsLoop            $00, $0A, Sound_47_Loop00
	smpsStop

; Song seems to not use any FM voices
Sound_47_Voices:
