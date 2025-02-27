Sound_52_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_52_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG3, Sound_52_PSG3,	$00, $03

; PSG3 Data
Sound_52_PSG3:
	smpsModSet          $01, $01, $F0, $08
	smpsPSGform         $E7
	dc.b	nE5, $07

Sound_52_Loop00:
	dc.b	nG6, $01
	smpsPSGAlterVol     $01
	smpsLoop            $00, $0C, Sound_52_Loop00
	smpsStop

; Song seems to not use any FM voices
Sound_52_Voices:
