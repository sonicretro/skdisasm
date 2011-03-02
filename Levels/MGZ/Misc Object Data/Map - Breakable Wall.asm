Map_21FF18:	dc.w Frame_21FF20-Map_21FF18 ; ...
		dc.w Frame_21FF5E-Map_21FF18
		dc.w Frame_21FF20-Map_21FF18
		dc.w Frame_21FF5E-Map_21FF18
Frame_21FF20:	dc.w $A
		dc.b $D8, $D,  0,$66,$FF,$E0
		dc.b $D8, $D,  8,$66,  0,  0
		dc.b $E8, $D,  0,$66,$FF,$E0
		dc.b $E8, $D,  8,$66,  0,  0
		dc.b $F8, $D,  0,$66,$FF,$E0
		dc.b $F8, $D,  8,$66,  0,  0
		dc.b   8, $D,  0,$66,$FF,$E0
		dc.b   8, $D,  8,$66,  0,  0
		dc.b $18, $D,  0,$6E,$FF,$E0
		dc.b $18, $D,  8,$6E,  0,  0
Frame_21FF5E:	dc.w $14
		dc.b $D8,  5,  0,$66,$FF,$E0
		dc.b $D8,  5,  0,$6A,$FF,$F0
		dc.b $D8,  5,  8,$6A,  0,  0
		dc.b $D8,  5,  8,$66,  0,$10
		dc.b $E8,  5,  0,$66,$FF,$E0
		dc.b $E8,  5,  0,$6A,$FF,$F0
		dc.b $E8,  5,  8,$6A,  0,  0
		dc.b $E8,  5,  8,$66,  0,$10
		dc.b $F8,  5,  0,$66,$FF,$E0
		dc.b $F8,  5,  0,$6A,$FF,$F0
		dc.b $F8,  5,  8,$6A,  0,  0
		dc.b $F8,  5,  8,$66,  0,$10
		dc.b   8,  5,  0,$66,$FF,$E0
		dc.b   8,  5,  0,$6A,$FF,$F0
		dc.b   8,  5,  8,$6A,  0,  0
		dc.b   8,  5,  8,$66,  0,$10
		dc.b $18,  5,  0,$6E,$FF,$E0
		dc.b $18,  5,  0,$72,$FF,$F0
		dc.b $18,  5,  8,$72,  0,  0
		dc.b $18,  5,  8,$6E,  0,$10
