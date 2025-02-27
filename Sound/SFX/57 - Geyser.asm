Sound_57_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_39_57_6C_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cPSG3, Sound_57_PSG3,	$00, $00
	smpsHeaderSFXChannel cFM5, Sound_39_57_6C_FM5,	$00, $00

; PSG3 Data
Sound_57_PSG3:
	smpsPSGform         $E7
	dc.b	nB4, $0B

Sound_57_Loop00:
	dc.b	nAb6
	smpsPSGAlterVol     $01
	smpsLoop            $00, $0A, Sound_57_Loop00
	dc.b	$10
	smpsStop
