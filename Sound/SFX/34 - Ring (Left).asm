Sound_34_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_33_34_B9_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM5, Sound_34_FM5,	$00, $05

; FM5 Data
Sound_34_FM5:
	smpsSetvoice        $00
	smpsPan             panLeft, $00
	smpsJump            Sound_34_Jump00
