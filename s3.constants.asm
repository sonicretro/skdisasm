SStage_collision_response_list := ramaddr( $FFFF8800 ) ; $100 bytes ; sprite collision list during a special stage

H_int_jump :=			ramaddr( $FFFFF608 ) ; 6 bytes ; contains an instruction to jump to the H-int handler
H_int_addr :=			ramaddr( $FFFFF60A ) ; long
Save_pointer :=			ramaddr( $FFFFE6B8 ) ; long ; pointer to the active save slot in 1 player mode
Saved_data :=			ramaddr( $FFFFE6CC ) ; $34 bytes ; saved data from 1 player mode

Level_select_flag :=		ramaddr( $FFFFFFD0 ) ; byte
Slow_motion_flag :=		ramaddr( $FFFFFFD1 ) ; byte
Debug_cheat_flag :=		ramaddr( $FFFFFFD2 ) ; word ; set if the debug cheat's been entered
Level_select_cheat_counter :=	ramaddr( $FFFFFFD4 ) ; word ; progress entering level select cheat
Debug_mode_cheat_counter :=	ramaddr( $FFFFFFD6 ) ; word ; progress entering debug mode cheat, unused
Competition_mode :=		ramaddr( $FFFFFFD8 ) ; word
P1_character :=			ramaddr( $FFFFFFDA ) ; byte ; 0 := Sonic, 1 := Tails, 2 := Knuckles
P2_character :=			ramaddr( $FFFFFFDB ) ; byte

Demo_mode_flag :=		ramaddr( $FFFFFFF0 ) ; word
Next_demo_number :=		ramaddr( $FFFFFFF2 ) ; word ; the currently running demo
Ending_demo_number :=		ramaddr( $FFFFFFF4 ) ; word ; zone for the ending demos, unused
V_blank_cycles :=		ramaddr( $FFFFFFF6 ) ; word ; the number of cycles between V-blanks
Graphics_flags :=		ramaddr( $FFFFFFF8 ) ; byte ; bit 7 set := English system, bit 6 set := PAL system
Debug_mode_flag :=		ramaddr( $FFFFFFFA ) ; word
Checksum_string :=		ramaddr( $FFFFFFFC ) ; long ; set to 'init' once the checksum routine has run
