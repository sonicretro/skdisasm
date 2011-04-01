Map_SStageSonic:	dc.w word_ABE2C-Map_SStageSonic
		dc.w word_ABE2E-Map_SStageSonic
		dc.w word_ABE3C-Map_SStageSonic
		dc.w word_ABE4A-Map_SStageSonic
		dc.w word_ABE5E-Map_SStageSonic
		dc.w word_ABE72-Map_SStageSonic
		dc.w word_ABE86-Map_SStageSonic
		dc.w word_ABE9A-Map_SStageSonic
		dc.w word_ABEAE-Map_SStageSonic
		dc.w word_ABEC2-Map_SStageSonic
		dc.w word_ABECA-Map_SStageSonic
		dc.w word_ABED2-Map_SStageSonic
PLC_SStageSonic:dc.w word_ABE2C-PLC_SStageSonic

		dc.w word_ABEDA-PLC_SStageSonic
		dc.w word_ABEE0-PLC_SStageSonic
		dc.w word_ABEE6-PLC_SStageSonic
		dc.w word_ABEEE-PLC_SStageSonic
		dc.w word_ABEF6-PLC_SStageSonic
		dc.w word_ABEFE-PLC_SStageSonic
		dc.w word_ABF06-PLC_SStageSonic
		dc.w word_ABF0E-PLC_SStageSonic
		dc.w word_ABF16-PLC_SStageSonic
		dc.w word_ABF1A-PLC_SStageSonic
		dc.w word_ABF1E-PLC_SStageSonic
word_ABE2C:	dc.w 0

word_ABE2E:	dc.w 2
		dc.b  $DD,  $F,	  0,   0, $FF, $F0
		dc.b  $FD,   8,	  0, $10, $FF, $F2
word_ABE3C:	dc.w 2
		dc.b  $D5,  $F,	  0,   0, $FF, $F0
		dc.b  $F5,   9,	  0, $10, $FF, $F1
word_ABE4A:	dc.w 3
		dc.b  $D5,  $F,	  0,   0, $FF, $F0
		dc.b  $F5,   8,	  0, $10, $FF, $F2
		dc.b  $FD,   5,	  0, $13, $FF, $F2
word_ABE5E:	dc.w 3
		dc.b  $D5,  $F,	  0,   0, $FF, $F0
		dc.b  $F5,   8,	  0, $10, $FF, $F2
		dc.b  $FD,   5,	  0, $13, $FF, $F2
word_ABE72:	dc.w 3
		dc.b  $D5,  $F,	  0,   0, $FF, $EE
		dc.b  $F5,   8,	  0, $10, $FF, $F6
		dc.b  $FD,   1,	  0, $13, $FF, $F6
word_ABE86:	dc.w 3
		dc.b  $D5,  $F,	  8,   0, $FF, $EF
		dc.b  $F5,   8,	  8, $10, $FF, $F7
		dc.b  $FD,   5,	  8, $13, $FF, $FF
word_ABE9A:	dc.w 3
		dc.b  $D5,  $F,	  8,   0, $FF, $EF
		dc.b  $F5,   8,	  8, $10, $FF, $F7
		dc.b  $FD,   5,	  8, $13, $FF, $FF
word_ABEAE:	dc.w 3
		dc.b  $D5,  $F,	  8,   0, $FF, $F0
		dc.b  $F5,   8,	  8, $10, $FF, $F0
		dc.b  $FD,   1,	  8, $13,   0,	 0
word_ABEC2:	dc.w 1
		dc.b  $DA,  $F,	  0,   0, $FF, $F0
word_ABECA:	dc.w 1
		dc.b  $DA,  $F,	  0,   0, $FF, $F0
word_ABED2:	dc.w 1
		dc.b  $DA,  $F,	  0,   0, $FF, $F0
word_ABEDA:	dc.w 2
		dc.w $F000
		dc.w $2010
word_ABEE0:	dc.w 2
		dc.w $F013
		dc.w $5023
word_ABEE6:	dc.w 3
		dc.w $F029
		dc.w $2039
		dc.w $303C
word_ABEEE:	dc.w 3
		dc.w $F040
		dc.w $2050
		dc.w $3053
word_ABEF6:	dc.w 3
		dc.w $F057
		dc.w $2067
		dc.w $106A
word_ABEFE:	dc.w 3
		dc.w $F029
		dc.w $2039
		dc.w $303C
word_ABF06:	dc.w 3
		dc.w $F040
		dc.w $2050
		dc.w $3053
word_ABF0E:	dc.w 3
		dc.w $F057
		dc.w $2067
		dc.w $106A
word_ABF16:	dc.w 1
		dc.w $F06C
word_ABF1A:	dc.w 1
		dc.w $F07C
word_ABF1E:	dc.w 1
		dc.w $F08C