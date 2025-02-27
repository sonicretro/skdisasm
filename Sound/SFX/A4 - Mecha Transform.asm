Sound_A4_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_A4_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cPSG1, Sound_A4_PSG1,	$0F, $03
	smpsHeaderSFXChannel cPSG2, Sound_A4_PSG2,	$11, $04

; PSG1 Data
Sound_A4_PSG1:
	dc.b	nRst, $03

; PSG2 Data
Sound_A4_PSG2:
	dc.b	nRst, $03
	smpsPSGvoice        sTone_16
	smpsModSet          $03, $01, $ED, $10
	dc.b	nD0, $07
	smpsAlterPitch      $01
	smpsLoop            $00, $10, Sound_A4_PSG2
	dc.b	nRst, $03, nEb0, $05, nRst, $03, nEb0, $05
	smpsStop

; Song seems to not use any FM voices
Sound_A4_Voices:
