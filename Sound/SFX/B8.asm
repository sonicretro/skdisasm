Sound_B8_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_B8_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG2, Sound_B8_PSG2,	$00, $00

; PSG2 Data
Sound_B8_PSG2:
	smpsPSGvoice        sTone_03

Sound_B8_Loop00:
	dc.b	nD5, $04, nE5, nFs5
	smpsPSGAlterVol     $01
	smpsAlterPitch      $FF
	smpsLoop            $00, $05, Sound_B8_Loop00

Sound_B8_Loop01:
	dc.b	nD5, $04, nE5, nFs5
	smpsPSGAlterVol     $01
	smpsAlterPitch      $01
	smpsLoop            $00, $07, Sound_B8_Loop01
	smpsStop

; Song seems to not use any FM voices
Sound_B8_Voices:
