		dc.w word_4CA4-Map_TitleScreenText
		dc.w word_4CD0-Map_TitleScreenText
		dc.w word_4CFC-Map_TitleScreenText
		dc.w word_4D16-Map_TitleScreenText
word_4CA4:	dc.w 7			; DATA XREF: ROM:00004C9Co
		dc.b	0,  $C,	$20,   0,   0,	 0
		dc.b	0,  $C,	$20,   4,   0, $20
		dc.b	0,  $C,	$20,   8,   0, $40
		dc.b  $10,  $C,	  0,  $C,   0,	 0
		dc.b  $10,  $C,	  0, $10,   0, $20
		dc.b  $10,  $C,	  0, $14,   0, $40
		dc.b	0,   4,	$20, $24, $FF, $EC
word_4CD0:	dc.w	7,  $C,	  0,   0,  $C,	 4 ; DATA XREF:	ROM:00004C9Co
		dc.w  $20,  $C,	  8, $40,$100C,$200C
		dc.w	0,$100C,$2010, $20,$100C,$2014
		dc.w  $40,$1004,$2024,$FFEC
word_4CFC:	dc.w 4			; DATA XREF: ROM:00004C9Co
		dc.b	8,  $C,	$20, $18,   0,	 0
		dc.b	8,  $C,	$20, $1C,   0, $20
		dc.b	8,  $C,	$20, $20,   0, $40
		dc.b	8,   4,	$20, $24, $FF, $EC
word_4D16:	dc.w 3			; DATA XREF: ROM:00004C9Co
		dc.b	0,   0,	  0, $26,   0,	 0
		dc.b	0,  $C,	  0, $27,   0, $10
		dc.b	0,  $C,	  0, $2B,   0, $38
