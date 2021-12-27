	phase Level_layout_header+$400
SStage_extra_sprites :=		*		; Sonic & Knuckles uses a different address
				ds.b $70		; some extra sprite info for special stages
			ds.b $390			; unused
SStage_collision_response_list := *		; Sonic & Knuckles uses a different address
			ds.b $100			; some extra sprite info for special stages
SStage_unkA500 :=		*		; Sonic & Knuckles uses a different address
			ds.b $100			; unknown special stage array
SStage_unkA600 :=		*		; Sonic & Knuckles uses a different address
			ds.b $100			; unknown special stage array
	dephase

	phase Stat_table+$12
_unkE412			ds.w 1			; unused, but referenced in sphere test
_unkE414			ds.w 1			; used in sphere test
_unkE416			ds.w 1			; used in sphere test
Sphere_test_address		ds.w 1			; address of the sphere test object

Save_pointer :=			Competition_saved_data+$B8; long ; pointer to the active save slot in 1 player mode
Saved_data :=			Competition_saved_data+$CC; $34 bytes ; saved data from 1 player mode
H_int_jump :=			_tempF608		; 6 bytes ; contains an instruction to jump to the H-int handler
H_int_addr :=			H_int_jump+2		; long
	dephase

	phase _unkF712+8
CNZ_bumper_routine		ds.b 1			; left over from Sonic 2
CNZ_bumper_unk			ds.b 1			; left over from Sonic 2 ; set only, never used again
CNZ_visible_bumpers_start	ds.l 1			; left over from Sonic 2
CNZ_Visible_bumpers_end		ds.l 1			; left over from Sonic 2
CNZ_Visible_bumpers_start_P2	ds.l 1			; left over from Sonic 2
CNZ_Visible_bumpers_end_P2	ds.l 1			; left over from Sonic 2
	dephase

	phase _tempFF88
Current_zone_2P			ds.b 1			; left over from Sonic 2
Current_act_2P			ds.b 1			; left over from Sonic 2
Options_menu_box =		_tempFF8C		; byte ; left over from Sonic 2
_unkFF98 =			_tempFF98		; word ; unused
	dephase

	phase Demo_mode_flag
Level_select_flag :=		*		; Sonic & Knuckles uses a different address
				ds.b 1
Slow_motion_flag :=		*		; Sonic & Knuckles uses a different address
				ds.b 1
Debug_cheat_flag :=		*		; Sonic & Knuckles uses a different address
				ds.w 1			; set if the debug cheat's been entered
Level_select_cheat_counter :=	*		; Sonic & Knuckles uses a different address
				ds.w 1			; progress entering level select cheat, unused
Debug_mode_cheat_counter :=	*		; Sonic & Knuckles uses a different address
				ds.w 1			; progress entering debug mode cheat, unused
Competition_mode :=		*		; Sonic & Knuckles uses a different address
				ds.w 1
P1_character :=			*		; Sonic & Knuckles uses a different address
				ds.b 1			; 0 = Sonic, 1 = Tails, 2 = Knuckles
P2_character :=			*		; Sonic & Knuckles uses a different address
				ds.b 1
_dbgFFDC			ds.b 1			; seems like a leftover constant. Existed in Sonic 1 and Sonic 2 as well
_dbgFFDD			ds.b 1			; seems like a leftover constant. Existed in Sonic 1 and Sonic 2 as well
_dbgFFDE			ds.b 1			; seems like a leftover constant. Existed in Sonic 1 and Sonic 2 as well
_dbgFFDF			ds.b 1			; seems like a leftover constant. Existed in Sonic 1 and Sonic 2 as well
	dephase

	phase V_int_jump
Demo_mode_flag :=		*		; Sonic & Knuckles uses a different address
				ds.w 1
Next_demo_number :=		*		; Sonic & Knuckles uses a different address
				ds.w 1
Ending_demo_number		ds.w 1			; zone for the ending demos, unused
V_blank_cycles :=		*		; Sonic & Knuckles uses a different address
				ds.w 1			; the number of cycles between V-blanks
Graphics_flags :=		*		; Sonic & Knuckles uses a different address
				ds.b 1			; bit 7 set = English system, bit 6 set = PAL system
			ds.b 1				; unused
Debug_mode_flag :=		*		; Sonic & Knuckles uses a different address
				ds.w 1
Checksum_string :=		*		; Sonic & Knuckles uses a different address
				ds.l 1			; set to Ref_Checksum_String once the checksum routine has run
Ref_Checksum_String := 'init'
	dephase
	!org 0

.check2 =	(*)&$FFFFFF
	if (.check2>0)&(.check2<$FF0000)
		fatal "Sonic 3 RAM definitions are too large by $\{*} bytes!"
	endif
