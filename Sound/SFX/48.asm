Sound_48_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_48_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG3, Sound_48_PSG3,	$00, $00

; PSG3 Data
Sound_48_PSG3:
	smpsPSGform         $E7
	smpsPSGvoice        sTone_0D
	dc.b	nFs4, $04

Sound_48_Loop00:
	dc.b	smpsNoAttack, $0F
	smpsPSGAlterVol     $01
	smpsLoop            $00, $04, Sound_48_Loop00
	smpsStop

; Song seems to not use any FM voices
Sound_48_Voices:
