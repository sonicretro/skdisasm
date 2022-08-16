Sound_9A_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_9A_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG3, Sound_9A_PSG3,	$FF, $00

; PSG3 Data
Sound_9A_PSG3:
	smpsPSGform         $E7
	smpsPSGvoice        sTone_15
	smpsModSet          $01, $01, $DD, $02
	dc.b	nE5, $04

Sound_9A_Loop00:
	dc.b	nG6, $01
	smpsPSGAlterVol     $01
	smpsLoop            $00, $0C, Sound_9A_Loop00
	smpsStop

; Song seems to not use any FM voices
Sound_9A_Voices:
