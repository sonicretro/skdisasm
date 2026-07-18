; Palette pointers

palptr:	macro paletteLabel,paletteRAMaddress,paletteSize,{INTLABEL},{GLOBALSYMBOLS}
__LABEL__: = (*-PalPoint)/8
	dc.l paletteLabel
	dc.w paletteRAMaddress&$FFFF,bytesToLcnt(paletteSize)
	endm

PalID_S2Sega:		palptr Pal_S2Sega,		Normal_palette,		$80	; $00
PalID_S2Title:		palptr Pal_S2Title,		Normal_palette_line_2,	$20	; $01
PalID_S2LevSel:		palptr Pal_S2LevSel,		Normal_palette,		$80	; $02
PalID_SonicTails:	palptr Pal_SonicTails,		Normal_palette,		$20	; $03
PalID_S2Menu:		palptr Pal_S2Menu,		Normal_palette,		$80	; $04
PalID_Knuckles:		palptr Pal_Knuckles,		Normal_palette_line_2,	$20	; $05
PalID_S2Sega_2:		palptr Pal_S2Sega,		Normal_palette,		$80	; $06
PalID_S2Sega_3:		palptr Pal_S2Sega,		Normal_palette,		$80	; $07
PalID_S2Sega_4:		palptr Pal_S2Sega,		Normal_palette,		$80	; $08
PalID_S2Sega_5:		palptr Pal_S2Sega,		Normal_palette,		$80	; $09
PalID_AIZIntro:		palptr Pal_AIZIntro,		Normal_palette_line_2,	$60	; $0A
PalID_AIZFire:		palptr Pal_AIZFire,		Normal_palette_line_2,	$60	; $0B
PalID_HCZ1:		palptr Pal_HCZ1,		Normal_palette_line_2,	$60	; $0C
PalID_HCZ2:		palptr Pal_HCZ2,		Normal_palette_line_2,	$60	; $0D
PalID_MGZ1:		palptr Pal_MGZ,			Normal_palette_line_2,	$60	; $0E
PalID_MGZ2:		palptr Pal_MGZ,			Normal_palette_line_2,	$60	; $0F
PalID_CNZ1:		palptr Pal_CNZ,			Normal_palette_line_2,	$60	; $10
PalID_CNZ2:		palptr Pal_CNZ,			Normal_palette_line_2,	$60	; $11
PalID_FBZ1:		palptr Pal_FBZ,			Normal_palette_line_2,	$60	; $12
PalID_FBZ2:		palptr Pal_FBZ,			Normal_palette_line_2,	$60	; $13
PalID_ICZ1:		palptr Pal_ICZ1,		Normal_palette_line_2,	$60	; $14
PalID_ICZ2:		palptr Pal_ICZ2,		Normal_palette_line_2,	$60	; $15
PalID_LBZ1:		palptr Pal_LBZ1,		Normal_palette_line_2,	$60	; $16
PalID_LBZ2:		palptr Pal_LBZ2,		Normal_palette_line_2,	$60	; $17
PalID_MHZ1:		palptr Pal_ALZ,			Normal_palette_line_2,	$60	; $18
PalID_MHZ2:		palptr Pal_ALZ,			Normal_palette_line_2,	$60	; $19
PalID_SOZ1:		palptr Pal_ALZ,			Normal_palette_line_2,	$60	; $1A
PalID_SOZ2:		palptr Pal_ALZ,			Normal_palette_line_2,	$60	; $1B
PalID_LRZ1:		palptr Pal_ALZ,			Normal_palette_line_2,	$60	; $1C
PalID_LRZ2:		palptr Pal_ALZ,			Normal_palette_line_2,	$60	; $1D
PalID_SSZ1:		palptr Pal_ALZ,			Normal_palette_line_2,	$60	; $1E
PalID_SSZ2:		palptr Pal_ALZ,			Normal_palette_line_2,	$60	; $1F
PalID_DEZ1:		palptr Pal_ALZ,			Normal_palette_line_2,	$60	; $20
PalID_DEZ2:		palptr Pal_ALZ,			Normal_palette_line_2,	$60	; $21
PalID_DDZ1:		palptr Pal_ALZ,			Normal_palette_line_2,	$60	; $22
PalID_DDZ2:		palptr Pal_ALZ,			Normal_palette_line_2,	$60	; $23
PalID_Ending1:		palptr Pal_ALZ,			Normal_palette_line_2,	$60	; $24
PalID_Ending2:		palptr Pal_ALZ,			Normal_palette_line_2,	$60	; $25
PalID_ALZ:		palptr Pal_ALZ,			Normal_palette_line_2,	$60	; $26
PalID_ALZ_2:		palptr Pal_ALZ,			Normal_palette_line_2,	$60	; $27
PalID_BPZ:		palptr Pal_BPZ,			Normal_palette_line_2,	$60	; $28
PalID_BPZ_2:		palptr Pal_BPZ,			Normal_palette_line_2,	$60	; $29
PalID_AIZ:		palptr Pal_AIZ,			Normal_palette_line_2,	$60	; $2A
PalID_AIZ_Water:	palptr Pal_AIZ_Water,		Normal_palette,		$80	; $2B
PalID_AIZ2_Water:	palptr Pal_AIZ2_Water,		Normal_palette,		$80	; $2C
PalID_LBZ_Water:	palptr Pal_LBZ_Water,		Normal_palette,		$80	; $2D
PalID_LBZ2_Water:	palptr Pal_LBZ_Water,		Normal_palette,		$80	; $2E
PalID_LBZ_Water2:	palptr Pal_LBZ_Water2,		Normal_palette_line_2,	$60	; $2F
PalID_AIZBoss:		palptr Pal_AIZBoss,		Normal_palette_line_2,	$60	; $30
PalID_HCZ1_Water:	palptr Pal_HCZ1_Water,		Normal_palette,		$80	; $31
PalID_HCZ2_Water:	palptr Pal_HCZ2_Water,		Normal_palette,		$80	; $32
PalID_Gumball_Special:	palptr Pal_Gumball_Special,	Normal_palette_line_2,	$60	; $33
PalID_DPZ:		palptr Pal_DPZ,			Normal_palette_line_2,	$60	; $34
PalID_CGZ:		palptr Pal_CGZ,			Normal_palette_line_2,	$60	; $35
PalID_EMZ:		palptr Pal_EMZ,			Normal_palette_line_2,	$60	; $36
PalID_Pachinko_Special:	palptr Pal_Pachinko_Special,	Normal_palette_line_2,	$60	; $37
PalID_Slot_Special:	palptr Pal_Slot_Special,	Normal_palette_line_2,	$60	; $38
PalID_ICZ2_Water:	palptr Pal_ICZ2_Water,		Normal_palette,		$80	; $39
PalID_CNZ_Water:	palptr Pal_CNZ_Water,		Normal_palette,		$80	; $3A
PalID_AIZ_2:		palptr Pal_AIZ,			Normal_palette_line_2,	$60	; $3B