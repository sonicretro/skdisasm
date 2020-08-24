	phase Level_layout_header+$400
SStage_extra_sprites :=		*			; some extra sprite info for special stages
				ds.b $70		; Sonic & Knuckles has a different address... So uh... Yes
			ds.b $390			; unused
SStage_collision_response_list := *			; some extra sprite info for special stages
			ds.b $100			; unused
SStage_unkA500 :=		*			; unknown special stage array
			ds.b $100			; Sonic & Knuckles has a different address... So uh... Yes
SStage_unkA600 :=		*			; unknown special stage array
			ds.b $100			; Sonic & Knuckles has a different address... So uh... Yes

	phase Stat_table+$12
_unkE412			ds.w 1			; unused, but referenced in sphere test
_unkE414			ds.w 1			; used in sphere test
_unkE416			ds.w 1			; used in sphere test
Sphere_test_address		ds.w 1			; address of the sphere test object

Save_pointer :=			Competition_saved_data+$B8; long ; pointer to the active save slot in 1 player mode
Saved_data :=			Competition_saved_data+$CC; $34 bytes ; saved data from 1 player mode
H_int_jump :=			_tempF608		; 6 bytes ; contains an instruction to jump to the H-int handler
H_int_addr :=			H_int_jump+2		; long

	phase _unkF712+8
CNZ_bumper_routine		ds.b 1			; left over from Sonic 2
CNZ_bumper_unk			ds.b 1			; left over from Sonic 2 ; set only, never used again
CNZ_visible_bumpers_start	ds.l 1			; left over from Sonic 2
CNZ_Visible_bumpers_end		ds.l 1			; left over from Sonic 2
CNZ_Visible_bumpers_start_P2	ds.l 1			; left over from Sonic 2
CNZ_Visible_bumpers_end_P2	ds.l 1			; left over from Sonic 2

	phase _tempFF88
Current_zone_2P			ds.b 1			; left over from Sonic 2
Current_act_2P			ds.b 1			; left over from Sonic 2
Options_menu_box =		_tempFF8C		; byte ; left over from Sonic 2
_unkFF98 =			_tempFF98		; word ; unused

	phase Demo_mode_flag
Level_select_flag :=		*
				ds.b 1			; Sonic & Knuckles has a different address... So uh... Yes
Slow_motion_flag :=		*
				ds.b 1			; Sonic & Knuckles has a different address... So uh... Yes
Debug_cheat_flag :=		*			; set if the debug cheat's been entered
				ds.w 1			; Sonic & Knuckles has a different address... So uh... Yes
Level_select_cheat_counter :=	*			; progress entering level select cheat, unused
				ds.w 1			; Sonic & Knuckles has a different address... So uh... Yes
Debug_mode_cheat_counter :=	*			; progress entering debug mode cheat, unused
				ds.w 1			; Sonic & Knuckles has a different address... So uh... Yes
Competition_mode :=		*
				ds.w 1			; Sonic & Knuckles has a different address... So uh... Yes
P1_character :=			*			; 0 := Sonic, 1 := Tails, 2 := Knuckles
				ds.b 1			; Sonic & Knuckles has a different address... So uh... Yes
P2_character :=			*
				ds.b 1			; Sonic & Knuckles has a different address... So uh... Yes
_dbgFFDC			ds.b 1			; seems like a leftover constant. Existed in Sonic 1 and Sonic 2 as well
_dbgFFDD			ds.b 1			; seems like a leftover constant. Existed in Sonic 1 and Sonic 2 as well
_dbgFFDE			ds.b 1			; seems like a leftover constant. Existed in Sonic 1 and Sonic 2 as well
_dbgFFDF			ds.b 1			; seems like a leftover constant. Existed in Sonic 1 and Sonic 2 as well

	phase V_int_jump
Demo_mode_flag :=		*
				ds.w 1			; Sonic & Knuckles has a different address... So uh... Yes
Next_demo_number :=		*
				ds.w 1			; Sonic & Knuckles has a different address... So uh... Yes
Ending_demo_number		ds.w 1			; zone for the ending demos, unused
V_blank_cycles :=		*			; the number of cycles between V-blanks
				ds.w 1			; Sonic & Knuckles has a different address... So uh... Yes
Graphics_flags :=		*			; bit 7 set := English system, bit 6 set := PAL system
				ds.b 1			; Sonic & Knuckles has a different address... So uh... Yes
			ds.b 1				; unused
Debug_mode_flag :=		*
				ds.w 1			; Sonic 3 has a different address... So uh... Yes
Checksum_string :=		*			; set to 'init' once the checksum routine has run
				ds.l 1			; Sonic & Knuckles has a different address... So uh... Yes
	dephase
	!org 0

.check2 =	(*)&$FFFFFF
	if (.check2>0)&(.check2<$FF0000)
		fatal "Sonic 3 RAM definitions are too large by $\{*} bytes!"
	endif
