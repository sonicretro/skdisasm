; Equates section - names for variables

; ---------------------------------------------------------------------------
; Object Status Table offsets
; ---------------------------------------------------------------------------

; universally followed object conventions:
render_flags =		  4 ; bitfield ; refer to SCHG for details
height_pixels =		  6 ; byte
width_pixels =		  7 ; byte
priority =		  8 ; word ; in units of $80
art_tile =		 $A ; word ; PCCVH AAAAAAAAAAA ; P = priority, CC = palette line, V = y-flip; H = x-flip, A = starting cell index of art
mappings =		 $C ; long
x_pos =			$10 ; word, or long when extra precision is required
y_pos =			$14 ; word, or long when extra precision is required
mapping_frame =		$22 ; byte
; ---------------------------------------------------------------------------
; conventions followed by most objects:
routine =		  5 ; byte
x_vel =			$18 ; word
y_vel =			$1A ; word
y_radius =		$1E ; byte ; collision height / 2
x_radius =		$1F ; byte ; collision width / 2
anim =			$20 ; byte
prev_anim =		$21 ; byte ; when this isn't equal to anim the animation restarts
anim_frame =		$23 ; byte
anim_frame_timer =	$24 ; byte
angle =			$26 ; byte ; angle about axis into plane of the screen (00 = vertical, 360 degrees = 256)
status =		$2A ; bitfield ; refer to SCHG for details
; ---------------------------------------------------------------------------
; conventions followed by many objects but not Sonic/Tails/Knuckles:
x_pixel =		x_pos ; word ; x-coordinate for objects using screen positioning
y_pixel =		y_pos ; word ; y-coordinate for objects using screen positioning
collision_flags =	$28 ; byte ; TT SSSSSS ; TT = collision type, SSSSSS = size
collision_property =	$29 ; byte ; usage varies, bosses use it as a hit counter
shield_reaction =	$2B ; byte ; bit 3 = bounces off shield, bit 4 = negated by fire shield, bit 5 = negated by lightning shield, bit 6 = negated by bubble shield
subtype =		$2C ; byte
ros_bit =		$3B ; byte ; the bit to be cleared when an object is destroyed if the ROS flag is set
ros_addr =		$3C ; word ; the RAM address whose bit to clear when an object is destroyed if the ROS flag is set
routine_secondary =	$3C ; byte ; used by monitors for this purpose at least
vram_art =		$40 ; word ; address of art in VRAM (same as art_tile * $20)
parent =		$42 ; word ; address of the object that owns or spawned this one, if applicable
child_dx = 		$42 ; byte ; X offset of child relative to parent
child_dy = 		$43 ; byte ; Y offset of child relative to parent
parent3 = 		$46 ; word ; parent of child objects
parent2 =		$48 ; word ; several objects use this instead
respawn_addr =		$48 ; word ; the address of this object's entry in the respawn table
; ---------------------------------------------------------------------------
; conventions specific to Sonic/Tails/Knuckles:
ground_vel =		$1C ; word ; overall velocity along ground, not updated when in the air
double_jump_property =	$25 ; byte ; remaining frames of flight / 2 for Tails, gliding-related for Knuckles
flip_angle =		$27 ; byte ; angle about horizontal axis (360 degrees = 256)
status_secondary =	$2B ; byte ; see SCHG for details
air_left =		$2C ; byte
flip_type =		$2D ; byte ; bit 7 set means flipping is inverted, lower bits control flipping type
object_control =	$2E ; byte ; bit 0 set means character can jump out, bit 7 set means he can't
double_jump_flag =	$2F ; byte ; meaning depends on current character, see SCHG for details
flips_remaining =	$30 ; byte
flip_speed =		$31 ; byte
move_lock =		$32 ; word ; horizontal control lock, counts down to 0
invulnerability_timer =	$34 ; byte ; decremented every frame
invincibility_timer =	$35 ; byte ; decremented every 8 frames
speed_shoes_timer =	$36 ; byte ; decremented every 8 frames
status_tertiary =	$37 ; byte ; see SCHG for details
character_id =		$38 ; byte ; 0 for Sonic, 1 for Tails, 2 for Knuckles
scroll_delay_counter =	$39 ; byte ; incremented each frame the character is looking up/down, camera starts scrolling when this reaches 120
next_tilt =		$3A ; byte ; angle on ground in front of character
tilt =			$3B ; byte ; angle on ground
stick_to_convex =	$3C ; byte ; used to make character stick to convex surfaces such as the rotating discs in CNZ
spin_dash_flag =	$3D ; byte ; bit 1 indicates spin dash, bit 7 indicates forced roll
spin_dash_counter =	$3E ; word
jumping =		$40 ; byte
interact =		$42 ; word ; RAM address of the last object the character stood on
default_y_radius =	$44 ; byte ; default value of y_radius
default_x_radius =	$45 ; byte ; default value of x_radius
top_solid_bit =		$46 ; byte ; the bit to check for top solidity (either $C or $E)
lrb_solid_bit =		$47 ; byte ; the bit to check for left/right/bottom solidity (either $D or $F)
; ---------------------------------------------------------------------------
; conventions followed by some/most bosses:
boss_hitcount2 =	$29
; ---------------------------------------------------------------------------
; when childsprites are activated (i.e. bit #6 of render_flags set)
mainspr_childsprites 	= $16	; amount of child sprites
sub2_x_pos		= $18	;x_vel
sub2_y_pos		= $1A	;y_vel
sub2_mapframe		= $1D
sub3_x_pos		= $1E	;y_radius
sub3_y_pos		= $20	;anim
sub3_mapframe		= $23	;anim_frame
sub4_x_pos		= $24	;anim_frame_timer
sub4_y_pos		= $26	;angle
sub4_mapframe		= $29	;collision_property
sub5_x_pos		= $2A	;status
sub5_y_pos		= $2C	;subtype
sub5_mapframe		= $2F
sub6_x_pos		= $30
sub6_y_pos		= $32
sub6_mapframe		= $35
sub7_x_pos		= $36
sub7_y_pos		= $38
sub7_mapframe		= $3B
sub8_x_pos		= $3C
sub8_y_pos		= $3E
sub8_mapframe		= $41
sub9_x_pos		= $42
sub9_y_pos		= $44
sub9_mapframe		= $47
next_subspr		= $6
; ---------------------------------------------------------------------------
; property of all objects:
object_size =		$4A ; the size of an object's status table entry
next_object =		object_size
; ---------------------------------------------------------------------------
; unknown or inconsistently used offsets that are not applicable to sonic/tails:
objoff_12 =		2+x_pos
objoff_16 =		2+y_pos
objoff_1C =		$1C
objoff_1D =		$1D
objoff_27 =		$27
objoff_2E =		$2E
objoff_2F =		$2F
objoff_30 =		$30
 enum   objoff_31=$31,objoff_32=$32,objoff_33=$33,objoff_34=$34,objoff_35=$35,objoff_36=$36,objoff_37=$37
 enum 	objoff_38=$38,objoff_39=$39,objoff_3A=$3A,objoff_3B=$3B,objoff_3C=$3C,objoff_3D=$3D,objoff_3E=$3E
 enum 	objoff_3F=$3F,objoff_40=$40,objoff_41=$41,objoff_42=$42,objoff_43=$43,objoff_44=$44,objoff_45=$45
 enum 	objoff_46=$46,objoff_47=$47,objoff_48=$48,objoff_49=$49

 ; ---------------------------------------------------------------------------
; Bits 3-6 of an object's status after a SolidObject call is a
; bitfield with the following meaning:
p1_standing_bit   = 3
p2_standing_bit   = p1_standing_bit + 1

p1_standing       = 1<<p1_standing_bit
p2_standing       = 1<<p2_standing_bit

pushing_bit_delta = 2
p1_pushing_bit    = p1_standing_bit + pushing_bit_delta
p2_pushing_bit    = p1_pushing_bit + 1

p1_pushing        = 1<<p1_pushing_bit
p2_pushing        = 1<<p2_pushing_bit


standing_mask     = p1_standing|p2_standing
pushing_mask      = p1_pushing|p2_pushing

; ---------------------------------------------------------------------------
; Controller Buttons
;
; Buttons bit numbers
button_up:			EQU	0
button_down:			EQU	1
button_left:			EQU	2
button_right:			EQU	3
button_B:			EQU	4
button_C:			EQU	5
button_A:			EQU	6
button_start:			EQU	7
; Buttons masks (1 << x == pow(2, x))
button_up_mask:			EQU	1<<button_up	; $01
button_down_mask:		EQU	1<<button_down	; $02
button_left_mask:		EQU	1<<button_left	; $04
button_right_mask:		EQU	1<<button_right	; $08
button_B_mask:			EQU	1<<button_B	; $10
button_C_mask:			EQU	1<<button_C	; $20
button_A_mask:			EQU	1<<button_A	; $40
button_start_mask:		EQU	1<<button_start	; $80

; ---------------------------------------------------------------------------
; Player Status Variables
Status_Facing       = 0
Status_InAir        = 1
Status_Roll         = 2
Status_OnObj        = 3
Status_RollJump     = 4
Status_Push         = 5
Status_Underwater   = 6

; ---------------------------------------------------------------------------
; Player status_secondary variables
Status_Shield       = 0
Status_Invincible   = 1
Status_SpeedShoes   = 2

Status_FireShield   = 4
Status_LtngShield   = 5
Status_BublShield   = 6

; ---------------------------------------------------------------------------
; Elemental Shield DPLC variables
shield_prev_frame   = $34
shield_art          = $38
shield_plc          = $3C

; ---------------------------------------------------------------------------
; Address equates
; ---------------------------------------------------------------------------

; Z80 addresses
Z80_RAM =			$A00000 ; start of Z80 RAM
Z80_RAM_end =			$A02000 ; end of non-reserved Z80 RAM
Z80_bus_request =		$A11100
Z80_reset =			$A11200

SRAM_access_flag =		$A130F1
Security_addr =			$A14000
; ---------------------------------------------------------------------------

; I/O Area
HW_Version =			$A10001
HW_Port_1_Data =		$A10003
HW_Port_2_Data =		$A10005
HW_Expansion_Data =		$A10007
HW_Port_1_Control =		$A10009
HW_Port_2_Control =		$A1000B
HW_Expansion_Control =		$A1000D
HW_Port_1_TxData =		$A1000F
HW_Port_1_RxData =		$A10011
HW_Port_1_SCtrl =		$A10013
HW_Port_2_TxData =		$A10015
HW_Port_2_RxData =		$A10017
HW_Port_2_SCtrl =		$A10019
HW_Expansion_TxData =		$A1001B
HW_Expansion_RxData =		$A1001D
HW_Expansion_SCtrl =		$A1001F
; ---------------------------------------------------------------------------

; VDP addresses
VDP_data_port =			$C00000
VDP_control_port =		$C00004
PSG_input =			$C00011
; ---------------------------------------------------------------------------

; RAM addresses

Sprite_table_alternate =	ramaddr(   $FF7880 ) ; $280 bytes ; alternate sprite table for player 1 in competition mode
Sprite_table_P2 =		ramaddr(   $FF7B00 ) ; $280 bytes ; sprite table for player 2 in competition mode
Sprite_table_P2_alternate =	ramaddr(   $FF7D80 ) ; $280 bytes ; alternate sprite table for player 2 in competition mode

	phase $FFFF0000
RAM_start =			*
Chunk_table			ds.b $8000		; chunk (128x128) definitions, $80 bytes per definition

Level_layout_header		ds.b 8			; first word = chunks per FG row, second word = chunks per BG row, third word = FG rows, fourth word = BG rows
Level_layout_main		ds.b $FF8		; $40 word-sized line pointers followed by actual layout data
Object_respawn_table_2 :=	Level_layout_header+$400; $200 bytes ; respawn table used by glowing spheres bonus stage, because... Reasons?
Ring_status_table_2 :=		Level_layout_header+$600; $400 bytes ; ring status table used by glowing spheres bonus stage, because... Reasons?
Block_table			ds.b $1800		; block (16x16) definitions, 8 bytes per definition, space for $300 blocks
SStage_collision_response_list := Block_table+$1400	; $100 bytes ; sprite collision list during a special stage
SStage_unkA500 :=		Block_table+$1500	; unknown special stage array
SStage_unkA600 :=		Block_table+$1600	; unknown special stage array
HScroll_table			ds.b $200		; array of background scroll positions for the level. WARNING: some references are before this label
_unkA880 :=			HScroll_table+$80	; used in SSZ screen/background events
_unkA8E0 :=			HScroll_table+$E0	; used in SSZ screen/background events
Nem_code_table			ds.b $200		; code table is built up here and then used during decompression
Sprite_table_input		ds.b $400		; 8 priority levels, $80 bytes per level

Object_RAM =			*			; $1FCC bytes ; $4A bytes per object, 110 objects
Player_1			ds.b object_size	; main character in 1 player mode, player 1 in Competition mode
Player_2			ds.b object_size	; Tails in a Sonic and Tails game, player 2 in Competition mode
Reserved_object_3		ds.b object_size	; during a level, an object whose sole purpose is to clear the collision response list is stored here
Dynamic_object_RAM		ds.b object_size*90	; $1A04 bytes ; 90 objects
Dynamic_object_RAM_end =	*
Level_object_RAM =		Dynamic_object_RAM_end	; $4EA bytes ; various fixed in-level objects
		ds.b object_size			; unknown
Breathing_bubbles		ds.b object_size	; for the main character
Breathing_bubbles_P2		ds.b object_size	; for Tails in a Sonic and Tails game
Super_stars =			*			; for Super Sonic and Super Knuckles
Tails_tails_2P			ds.b object_size	; Tails' tails in Competition mode
Tails_tails			ds.b object_size	; Tails' tails
Dust				ds.b object_size
Dust_P2				ds.b object_size
Shield				ds.b object_size
Shield_P2			ds.b object_size	; left over from Sonic 2 I'm guessing
Invincibility_stars		ds.b object_size*4
Invincibility_stars_P2		ds.b object_size*3
Wave_Splash			ds.b object_size	; Obj_HCZWaveSplash is loaded here
Object_RAM_end =		*
			ds.b $14			; unused
Conveyor_belt_load_array	ds.b $E			; each subtype of hcz conveyor belt uses a different byte to check if it's already loaded. Since they're so wide, the object loader may try loading them multiple times
			ds.b $12			; unused

Kos_decomp_buffer		ds.b $1000		; each module in a KosM archive is decompressed here and then DMAed to VRAM
H_scroll_buffer			ds.b $380		; horizontal scroll table is built up here and then DMAed to VRAM
Collision_response_list		ds.b $80		; only objects in this list are processed by the collision response routines
Stat_table =			*			; used by Tails' AI in a Sonic and Tails game
Pos_table_P2			ds.b $100		; used by Player 2 in competition mode
Pos_table 			ds.b $100		;
Competition_saved_data		ds.b $54		; saved data from Competition Mode
			ds.b $C				; unused
Save_pointer :=			*		; S3 uses a different address
				ds.l 1			; pointer to the active save slot in 1 player mode
			ds.w 1				; unused
Emerald_flicker_flag		ds.w 1			; controls the emerald flicker in save screen and special stage results.
			ds.b $44			; unused
Saved_data :=			*		; S3 uses a different address
				ds.b $54		; saved data from 1 player mode
Ring_status_table		ds.b $400		; 1 word per ring
Object_respawn_table		ds.b $300		; 1 byte per object, every object in the level gets an entry

Camera_RAM =			*			; various camera and scroll-related variables are stored here
H_scroll_amount			ds.w 1			; number of pixels camera scrolled horizontally in the last frame * $100
V_scroll_amount			ds.w 1			; number of pixels camera scrolled vertically in the last frame * $100
H_scroll_amount_P2		ds.w 1
V_scroll_amount_P2		ds.w 1
_unkEE08			ds.b 1			; this is actually unused
			ds.b 1				; unused
Scroll_lock			ds.b 1			; if this is set scrolling routines aren't called
Scroll_lock_P2			ds.b 1
Camera_target_min_X_pos		ds.w 1
Camera_target_max_X_pos		ds.w 1
Camera_target_min_Y_pos		ds.w 1
Camera_target_max_Y_pos		ds.w 1
Camera_min_X_pos		ds.w 1
Camera_max_X_pos		ds.w 1
Camera_min_Y_pos		ds.w 1
Camera_max_Y_pos		ds.w 1			; this is the only one which ever differs from its target value
Camera_min_X_pos_P2		ds.w 1
Camera_max_X_pos_P2		ds.w 1
Camera_min_Y_pos_P2		ds.w 1
Camera_max_Y_pos_P2		ds.w 1
H_scroll_frame_offset		ds.w 1			; if this is non-zero with value x, horizontal scrolling will be based on the player's position x / $100 + 1 frames ago
Pos_table_index			ds.w 1			; goes up in increments of 4
H_scroll_frame_offset_P2	ds.w 1
Pos_table_index_P2		ds.w 1
Distance_from_top		ds.w 1			; the vertical scroll manager scrolls the screen until the player's distance from the top of the screen is equal to this (or between this and this + $40 when in the air). $60 by default
Distance_from_top_P2		ds.w 1
Deform_lock			ds.b 1
			ds.b 1				; unused
Camera_max_Y_pos_changing	ds.b 1			; set when the maximum camera Y pos is undergoing a change
Dynamic_resize_routine		ds.b 1
			ds.b 5				; unused
Fast_V_scroll_flag		ds.b 1			; if this is set vertical scroll when the player is on the ground and has a speed of less than $800 is capped at 24 pixels per frame instead of 6
V_scroll_value_P2_copy		ds.l 1			; upper word for foreground, lower word for background
Camera_X_diff			ds.w 1			; difference between Camera_X_pos_copy and Camera_X_pos_BG_copy, used for background collision in SSZ and other levels
Camera_Y_diff			ds.w 1			; difference between Camera_Y_pos_copy and Camera_Y_pos_BG_copy, used for background collision in SSZ and other levels
Ring_start_addr_ROM		ds.l 1			; address in the ring layout of the first ring whose X position is >= camera X position - 8
Ring_end_addr_ROM		ds.l 1			; address in the ring layout of the first ring whose X position is >= camera X position + 328
Ring_start_addr_RAM		ds.w 1			; address in the ring status table of the first ring whose X position is >= camera X position - 8
			ds.w 1				; unused
Apparent_zone_and_act =		*
Apparent_zone			ds.b 1			; always equal to actual zone
Apparent_act			ds.b 1			; for example, after AIZ gets burnt, this indicates act 1 even though it's actually act 2
Palette_fade_timer		ds.w 1			; the palette gets faded in until this timer expires
Competition_time_record		ds.l 1		; player 1's recorded time for the current run, to be displayed in menus and the result screen 
Competition_time_record_minute =			Competition_time_record+1
Competition_time_record_second =			Competition_time_record+2
Competition_time_record_frame =			Competition_time_record+3
Competition_time_record_P2	ds.l 1		; player 2's recorded time for the current run, to be displayed in menus and the result screen 
Competition_time_record_minute_P2 =		Competition_time_record_P2+1
Competition_time_record_second_P2 =		Competition_time_record_P2+2
Competition_time_record_frame_P2 =		Competition_time_record_P2+3
Competition_time_attack_new_top_record			ds.b 1		; signifies new time records in time attack mode. set: no new records, clear: 1st place, $1: 2nd place, $2: 3rd place record.
			ds.b 1				; unused
Competition_lap_count			ds.b 1			; number of laps that player 1 has completed
Competition_lap_count_2P			ds.b 1		; number of laps that player 2 has completed
Act3_flag			ds.b 1			; set when entering LRZ 3 or DEZ 3 directly from previous act. Prevents title card from loading
			ds.b 1				; unused
Camera_X_pos_P2			ds.l 1
Camera_Y_pos_P2			ds.l 1
Camera_X_pos_P2_copy		ds.w 1
			ds.w 1				; unused
Camera_Y_pos_P2_copy		ds.w 1
			ds.w 1				; unused
_unkEE70			ds.w 1			; it is unclear how this is used
			ds.w 1				; unused
_unkEE74			ds.w 1			; it is unclear how this is used
			ds.w 1				; unused
Camera_X_pos			ds.l 1
Camera_Y_pos			ds.l 1
Camera_X_pos_copy		ds.l 1
Camera_Y_pos_copy		ds.l 1
Camera_X_pos_rounded		ds.w 1			; rounded down to the nearest block boundary ($10th pixel)
Camera_Y_pos_rounded		ds.w 1			; rounded down to the nearest block boundary ($10th pixel)
Camera_X_pos_BG_copy		ds.w 1
_unkEE8E			ds.w 1			; various uses in screen/background events and competition mode

Camera_Y_pos_BG_copy		ds.l 1
Camera_X_pos_BG_rounded		ds.w 1			; rounded down to the nearest block boundary ($10th pixel)
Camera_Y_pos_BG_rounded		ds.w 1			; rounded down to the nearest block boundary ($10th pixel)
_unkEE98			ds.l 1			; various uses in screen/background events and competition mode
_unkEE9C			ds.l 1			; various uses in screen/background events and competition mode
_unkEEA0			ds.w 1			; various uses in screen/background events and competition mode
_unkEEA2			ds.w 1			; various uses in screen/background events and competition mode
Plane_double_update_flag	ds.w 1			; set when two block are to be updated instead of one (i.e. the camera's scrolled by more than $10 pixels)
Special_V_int_routine		ds.w 1
Screen_X_wrap_value		ds.w 1			; set to $FFFF
Screen_Y_wrap_value		ds.w 1			; either $7FF or $FFF
Camera_Y_pos_mask		ds.w 1			; either $7F0 or $FF0
Layout_row_index_mask		ds.w 1			; either $3C or $7C

_unkEEB0			ds.w 1			;
Special_events_routine		ds.w 1			; routine counter for various special events. Used for example with LBZ2 Death Egg sequence
Events_fg_0			ds.w 1			; various flags used by screen events
Events_fg_1			ds.w 1			; various flags used by screen events
Events_fg_2			ds.w 1			; various flags used by screen events
_unkEEBA			ds.w 1			; only used in Sonic 3
Level_repeat_offset		ds.w 1			; the number of pixels the screen was moved this frame, used to offset level objects horizontally. Used only for level repeat sections, such as AIZ airship.
Events_fg_3			ds.w 1			; various flags used by screen events
Events_routine_fg		ds.w 1			; screen events routine counter
Events_routine_bg		ds.w 1			; background events routine counter
Events_fg_4			ds.w 1			; various flags used by screen events
Events_fg_5			ds.w 1			; various flags used by screen events
Draw_delayed_position		ds.w 1			; position to redraw screen from. Screen is reloaded 1 row at a time to avoid game lag
Draw_delayed_rowcount		ds.w 1			; number of rows for screen redrawing. Screen is reloaded 1 row at a time to avoid game lag
Screen_shake_flag		ds.w 1			; flag for enabling screen shake. Negative values cause screen to shake infinitely, positive values make the screen shake for a short amount of time
Screen_shake_offset		ds.w 1			; vertical offset when screen_shake_flag is enabled. This is added to camera position later
Screen_shake_last_offset	ds.w 1			; value of Screen_shake_offset for the previous frame

Events_bg			ds.b $18		; $18 bytes ; various flags used by background events
SStage_results_object_addr =	Events_bg+$E		; word ; RAM address of the special stage results object
FBZ_cloud_addr =		*			; $14 bytes ; addresses for cloud objects in FBZ2
Vscroll_buffer =		*			; $50 bytes ; vertical scroll buffer used in various levels
_unkEEEA			ds.w 1			; various unknown uses for EEEA
			ds.w 1				; used in some instances (see above)
_unkEEEE			ds.w 1			; used exclusively in SSZ background events code
			ds.w 1				; used in some instances (see above)
_unkEEF2			ds.w 1			; used exclusively in SSZ background events code
_unkEEF4			ds.w 1			; used exclusively in SSZ background events code
_unkEEF6			ds.l 1			; used exclusively in SSZ background events code
_unkEEFA			ds.w 1			; used exclusively in SSZ background events code
			ds.b $3E			; used in some instances (see above)

Spritemask_flag			ds.w 1			; when set, indicates that special sprites are used for sprite masking

; These two variables implement page-flipping of the game's sprite tables in
; Competition Mode, to avoid incomplete sprite table data being uploaded to
; the VDP, which was a problem that Sonic 2 suffered from.
Current_sprite_table_page	ds.w 1
Sprite_table_page_flip_pending	ds.w 1

Event_LBZ2_DeathEgg =		*			; if set, Launch Base 2 Death Egg is currently rising
_unkEF40_1			ds.l 1			; used as a part of calculating decimal scores
_unkEF44_1 =			*			; used as a jump pointer in vint 1E, unknown why this is used
_unkEF44_2			ds.l 1			; used as a part of calculating decimal scores
Competition_menu_selection	ds.b 1			; 0 = Grandprix, 1 = Matchrace, 2 = Timeattack. 3 = Exit
Not_ghost_flag			ds.b 1			; set if Player 2 in competition mode isn't a ghost of player 1
Competition_menu_zone		ds.b 1			; competition mode zone id. This is different from the zone order in game
Dataselect_entry		ds.b 1			; the selected save entry in data select menu. This includes no save and delete options, too
Dataselect_nosave_player	ds.w 1			; Player mode for NO SAVE option in data select menu
Competition_menu_items		ds.b 1			; 0 = Enabled, FF = Disabled
			ds.b 1				; unused
Demo_start_button		ds.b 1			; keeps track of whether controller 1 has pressed the start button. May be used by the demo data itself
			ds.b 1				; unused
Demo_data_addr			ds.l 1			; keeps getting incremented as the demo progresses
SRAM_mask_interrupts_flag	ds.w 1			; if this is set SRAM routines will mask all interrupts (by setting the SR to $2700)
			ds.w 1				; unused
Object_index_addr		ds.l 1			; points to either the object index for S3 levels or that for S&K levels
Act3_ring_count			ds.w 1			; stores ring count during act 3 transition
Act3_timer			ds.l 1			; stores timer during act 3 transition
Camera_Y_pos_coarse_back	ds.w 1			; Camera_Y_pos_coarse - $80
Glide_screen_shake		ds.w 1			; alternate screen shaking flag only used when hyper knuckles hits a wall after gliding
_unkEF68			ds.w 1			; stores a tile used in special stage results screen, unknown purpose
Special_stage_zone_and_act	ds.w 1			; stored zone and act during special stage results screen?
HPZ_special_stage_completed	ds.w 1			; set if special stage was completed. This determines which cutscene to play when entering HPZS
Current_special_stage_2		ds.b 1			; seems to be just a copy of Current_special_stage
			ds.b 1				; unused
HPZ_current_special_stage	ds.b 1			; seems to be just a copy of Current_special_stage used specifically for HPZS
			ds.b 1				; unused
Ending_running_flag		ds.w 1			; the only thing this does is prevent the game from pausing
Plane_buffer_2_addr		ds.l 1			; the address of the second plane buffer to process, if applicable
Demo_hold_counter		ds.b 1			; the number of frames to hold the current buttons. This only applies to S&K demos
Demo_hold_buttons		ds.b 1			; the buttons to hold. This only applies to S&K demos
Demo_number			ds.w 1			; the currently running demo
			ds.l 1				; unused

Ring_consumption_table =	*			; $80 bytes ; stores the addresses of all rings currently being consumed
Ring_consumption_count		ds.w 1			; the number of rings being consumed currently
Ring_consumption_list		ds.w $3F		; the remaining part of the ring consumption table

SStage_layout_buffer =		*			; $600 bytes ; yes, this area is used to for special stage layouts!
Target_water_palette		ds.b $80		; used by palette fading routines
Water_palette			ds.b $80		; this is what actually gets displayed
Water_palette_line_2 =		Water_palette+$20	; $20 bytes
Water_palette_line_3 =		Water_palette+$40	; $20 bytes
Water_palette_line_4 =		Water_palette+$60	; $20 bytes
Plane_buffer			ds.b $480		; used by level drawing routines
VRAM_buffer			ds.b $80		; used to temporarily hold data while it is being transferred from one VRAM location to another

Game_mode			ds.b 1
			ds.b 1				; unused
Ctrl_1_logical =		*			; both held and pressed
Ctrl_1_held_logical		ds.b 1
Ctrl_1_pressed_logical		ds.b 1
Ctrl_1 =			*			; both held and pressed
Ctrl_1_held			ds.b 1			; all held buttons
Ctrl_1_pressed			ds.b 1			; buttons being pressed newly this frame
Ctrl_2 =			*			; both held and pressed
Ctrl_2_held			ds.b 1
Ctrl_2_pressed			ds.b 1
_tempF608		ds.b 6				; this is used in Sonic 3 Alone, but unused in Sonic & Knuckles and Sonic 3 Complete

VDP_reg_1_command		ds.w 1			; AND the lower byte by $BF and write to VDP control port to disable display, OR by $40 to enable
			ds.l 1				; unused
Demo_timer			ds.w 1			; the time left for a demo to start/run
V_scroll_value =		*			; both foreground and background
V_scroll_value_FG		ds.w 1
V_scroll_value_BG		ds.w 1
_unkF61A			ds.l 1			; unused
V_scroll_value_P2 =		*
V_scroll_value_FG_P2		ds.w 1
V_scroll_value_BG_P2		ds.w 1
Teleport_active_timer		ds.b 1			; left over from Sonic 2
Teleport_active_flag		ds.b 1			; left over from Sonic 2
H_int_counter_command		ds.w 1			; contains a command to write to VDP register $0A (line interrupt counter)
H_int_counter =			H_int_counter_command+1	; just the counter part of the command
Palette_fade_info =		*			; both index and count
Palette_fade_index		ds.b 1			; colour to start fading from
Palette_fade_count		ds.b 1			; the number of colours to fade
Lag_frame_count			ds.w 1			; more specifically, the number of times V-int routine 0 has run. Reset at the end of a normal frame
V_int_routine			ds.b 1
			ds.b 1				; unused
Sprites_drawn			ds.b 1			; used to ensure the sprite limit isn't exceeded
			ds.b 1				; unused
Water_palette_data_addr		ds.l 1			; points to the water palette data for the current level
Palette_cycle_counter0		ds.w 1			; various counters and variables for palette cycles
Palette_cycle_counter1		ds.w 1			; various counters and variables for palette cycles
RNG_seed			ds.l 1			; used by the random number generator
Game_paused			ds.w 1
			ds.l 1				; unused
DMA_trigger_word		ds.w 1			; transferred from RAM to avoid crashing the Mega Drive
			ds.w 1				; unused
H_int_flag			ds.w 1			; unless this is set H-int will return immediately

Water_level			ds.w 1			; keeps fluctuating
Mean_water_level		ds.w 1			; the steady central value of the water level
Target_water_level		ds.w 1
Water_speed			ds.b 1			; this is added to or subtracted from Mean_water_level every frame till it reaches Target_water_level
Water_entered_counter		ds.b 1			; incremented when entering and exiting water, read by the the floating AIZ spike log, cleared on level initialisation and dynamic events of certain levels
Water_full_screen_flag		ds.b 1			; set if water covers the entire screen (i.e. the underwater palette should be DMAed during V-int rather than the normal palette)
Do_Updates_in_H_int		ds.b 1			; if this is set Do_Updates will be called from H-int instead of V-int
Palette_cycle_counters		ds.b $C			; various counters and variables for palette cycles
Palette_frame			ds.w 1
Palette_timer			ds.b 1
Super_palette_status		ds.b 1			 ; appears to be a flag for the palette's current status: '0' for 'off', '1' for 'fading', -1 for 'fading done'
_unkF660			ds.w 1
_unkF662			ds.w 1			 ; unused
Background_collision_flag	ds.b 1			 ; if set, background collision is enabled
Disable_death_plane		ds.b 1			 ; if set, going below the screen wont kill the player
Hyper_Sonic_flash_timer		ds.b 1			 ; used for Hyper Sonic's double jump move
Super_Tails_flag		ds.b 1
Palette_frame_Tails		ds.b 1			 ; Tails would use Palette_frame and Palette_timer, but they're reserved for his Super Flickies
Palette_timer_Tails		ds.b 1
Ctrl_2_logical =		*			 ; both held and pressed
Ctrl_2_held_logical		ds.b 1
Ctrl_2_pressed_logical		ds.b 1
_unkF66C			ds.b 1
			ds.b 3				; unused
Super_frame_count		ds.w 1
			ds.l 1				; unused
Scroll_force_positions		ds.b 1			; if this is set scrolling will be based on the two variables below rather than the player's actual position
			ds.b 1				; unused
Scroll_forced_X_pos		ds.w 1
			ds.w 1				; unused
Scroll_forced_Y_pos		ds.w 1			; note: must be exactly 4 bytes after Scroll_forced_X_pos
			ds.w 1				; unused

Nem_decomp_queue		ds.b 6*$10		; 6 bytes per entry, first longword is source location and next word is VRAM destination
Nem_decomp_source =		Nem_decomp_queue	; long ; the compressed data location for the first entry in the queue
Nem_decomp_destination =	Nem_decomp_queue+4	; word ; destination in VRAM for the first entry in the queue
Nem_decomp_vars =		*			; $20 bytes ; various variables used by the Nemesis decompression queue processor
Nem_write_routine		ds.l 1			; points to either Nem_PCD_WriteRowToVDP or Nem_PCD_WriteRowToVDP_XOR
Nem_repeat_count		ds.l 1			; stored repeat count for the current palette index
Nem_palette_index		ds.l 1			; the current palette index
Nem_previous_row		ds.l 1			; used in XOR mode
Nem_data_word			ds.l 1			; contains the current compressed word being processed
Nem_shift_value			ds.l 1			; the number of bits the data word needs to be shifted by
Nem_patterns_left		ds.w 1			; the number of patterns remaining to be decompressed
Nem_frame_patterns_left		ds.w 1			; the number of patterns remaining to be decompressed in the current frame
			ds.l 1				; unused?

Tails_CPU_interact		ds.w 1			; RAM address of the last object Tails stood on while controlled by AI
Tails_CPU_idle_timer		ds.w 1			; counts down while controller 2 is idle, when it reaches 0 the AI takes over
Tails_CPU_flight_timer		ds.w 1			; counts up while Tails is respawning, when it reaches 300 he drops into the level
			ds.w 1				; unused
Tails_CPU_routine		ds.w 1			; Tails' current AI routine in a Sonic and Tails game
Tails_CPU_target_X		ds.w 1			; Tails' target x-position
Tails_CPU_target_Y		ds.w 1			; Tails' target y-position
Tails_CPU_auto_fly_timer	ds.b 1		; counts up until AI Tails automatically flies up to maintain altitude, while grabbing Sonic in Marble Garden Act 2's boss
Tails_CPU_auto_jump_flag	ds.b 1		; set to #1 when AI Tails needs to jump of his own accord, regardless of whether Sonic jumped or not
Rings_manager_routine		ds.b 1
Level_started_flag		ds.b 1
_unkF712			ds.b $1C		; ??? ; unknown object respawn table
AIZ1_palette_cycle_flag		ds.b 1			; selects which palette cycles are used in AIZ1
			ds.b 1				; unused
Water_flag			ds.b 1
			ds.b $D				; unused
Flying_carrying_Sonic_flag	ds.b 1			; set when Tails carries Sonic in a Sonic and Tails game
Flying_picking_Sonic_timer	ds.b 1			; until this is 0 Tails can't pick Sonic up
_unkF740			ds.w 1
			ds.w 1				; unused
_unkF744			ds.w 1
Tails_CPU_star_post_flag	ds.b 1			; copy of Last_star_post_hit, sets Tails' starting behavior in a Sonic and Tails game
			ds.b 1				; unused
Ctrl_1_title =			*			; copy of Ctrl_1, used on the title screen
Ctrl_1_held_title		ds.b 1
Ctrl_1_pressed_title		ds.b 1
_unkF74A			ds.b 1
_unkF74B			ds.b 1
_unkF74C			ds.w 1
Gliding_collision_flags		ds.b 1
Disable_wall_grab		ds.b 1			; if set, disables Knuckles wall grab
			ds.b $10			; unused
Max_speed			ds.w 1
Acceleration			ds.w 1
Deceleration			ds.w 1
Player_prev_frame		ds.b 1			; used by DPLC routines to detect whether a DMA transfer is required
			ds.b 1				; unused
Primary_Angle			ds.b 1
Primary_Angle_save		ds.b 1	; Used in FindFloor/FindWall
Secondary_Angle			ds.b 1
Secondary_Angle_save	ds.b 1	; Used in FindFloor/FindWall

Object_load_routine		ds.b 1			; routine counter for the object loading manager
			ds.b 1				; unused
Camera_X_pos_coarse		ds.w 1			; rounded down to the nearest chunk boundary (128th pixel)
Camera_Y_pos_coarse		ds.w 1			; rounded down to the nearest chunk boundary (128th pixel)
Object_load_addr_front		ds.l 1			; the address inside the object placement data of the first object whose X pos is >= Camera_X_pos_coarse + $280
Object_load_addr_back		ds.l 1			; the address inside the object placement data of the first object whose X pos is >= Camera_X_pos_coarse - $80
Object_respawn_index_front	ds.w 1			; the object respawn table index for the object at Obj_load_addr_front
Object_respawn_index_back	ds.w 1			; the object respawn table index for the object at Obj_load_addr_back
			ds.b $16			; unused
Pal_fade_delay			ds.w 1			; timer for palette fade routines
Collision_addr			ds.l 1			; points to the primary or secondary collision data as appropriate
			ds.b $10			; unused
Boss_flag			ds.b 1			; set if a boss fight is going on
			ds.b 5				; unused
_unkF7B0			ds.b 4

Primary_collision_addr		ds.l 1
Secondary_collision_addr	ds.l 1
			ds.l 1				; unused
MHZ_pollen_counter		ds.b 1			; number of currently active pollen or leaves in MHZ
_unkF7C1			ds.b 1
_unkF7C2			ds.b 1
_unkF7C3			ds.b 1
_unkF7C4			ds.w 1
Reverse_gravity_flag		ds.b 1
_unkF7C7			ds.b 1
WindTunnel_flag			ds.b 1
WindTunnel_flag_P2		ds.b 1
Ctrl_1_locked			ds.b 1
Ctrl_2_locked			ds.b 1
			ds.l 1				; unused
Chain_bonus_counter		ds.w 1
Time_bonus_countdown		ds.w 1			; used on the results screen
Ring_bonus_countdown		ds.w 1			; used on the results screen
			ds.l 1				; unused
Camera_X_pos_coarse_back	ds.w 1			; Camera_X_pos_coarse - $80
_unkF7DC			ds.w 1
Player_prev_frame_P2		ds.b 1			; used by DPLC routines to detect whether a DMA transfer is required
Player_prev_frame_P2_tail	ds.b 1			; used by DPLC routines to detect whether a DMA transfer is required
Level_trigger_array		ds.b $10		; used by buttons, etc.
Anim_Counters			ds.b $10		; each word stores data on animated level art, including duration and current frame

Sprite_table			ds.b $280
_unkFA80			ds.w 1			; unused
_unkFA82			ds.b 1
_unkFA83			ds.b 1
_unkFA84			ds.w 1
_unkFA86			ds.w 1
_unkFA88			ds.b 1
_unkFA89			ds.b 1
_unkFA8A			ds.w 1
_unkFA8C			ds.w 1			; unused?
_unkFA8E			ds.w 1
_unkFA90			ds.w 1
Camera_stored_max_X_pos		ds.w 1			; the target camera maximum x-position
Camera_stored_min_X_pos		ds.w 1			; the target camera minimum x-position
Camera_stored_min_Y_pos		ds.w 1			; the target camera minimum y-position
Camera_stored_max_Y_pos		ds.w 1			; the target camera maximum y-position
Slotted_object_bits		ds.w 1			; bits to determine which slots are used for slotted objects
			ds.b 6				; unused
_unkFAA2			ds.b 1
_unkFAA3			ds.b 1
_unkFAA4			ds.w 1
Signpost_addr			ds.w 1			; address of the currently active signpost object. Hidden monitors use this for bouncing
_unkFAA8			ds.b 1
_unkFAA9			ds.b 1
End_of_level_flag		ds.b 1			; set if end of level is current active, for example after beating a boss
_unkFAAB			ds.b 1
_unkFAAC			ds.b 1
_unkFAAD			ds.b 1
_unkFAAE			ds.w 1
_unkFAB0			ds.w 1
_unkFAB2			ds.w 1
_unkFAB4			ds.w 1
_unkFAB6			ds.w 1
_unkFAB8			ds.b 1
_unkFAB9			ds.b 1
_unkFABA			ds.w 1
_unkFABC			ds.b 1
_unkFABD			ds.b 1
_unkFABE			ds.b 1			; unused?
Palette_rotation_disable	ds.b 1			; if set, palette rotation scripts are disabled
_unkFAC0			ds.b 1
_unkFAC1			ds.b 1
_unkFAC2			ds.w 1
_unkFAC4			ds.w 1
			ds.w 1				; unused
_unkFAC8			ds.w 1
			ds.w 1				; unused
_unkFACC			ds.b 1
_unkFACD			ds.b 1
Pal_fade_delay2			ds.w 1			; timer for palette fade from white routine
			ds.b $A				; unused
Palette_rotation_custom		ds.l 1			; custom routine for palette rotation scripts
Palette_rotation_data		ds.w 9			; data used by palette rotation scripts. Last word must always be 0
SSZ_MTZ_boss_X_pos			ds.w 1			; horizontal position of the Metropolis Zone boss in Sky Sanctuary
			ds.w 1				; unused
SSZ_MTZ_boss_Y_pos			ds.w 1			; vertical position of the Metropolis Zone boss in Sky Sanctuary
			ds.w 1				; unused
SSZ_MTZ_boss_X_vel			ds.w 1				; horizontal velocity of the Metropolis Zone boss in Sky Sanctuary
SSZ_MTZ_boss_Y_vel			ds.w 1				; vertical velocity of the Metropolis Zone boss in Sky Sanctuary
SSZ_MTZ_boss_laser_timer			ds.w 1	; counts down until a laser is fired in Sky Sanctuary's Metropolis boss fight
			ds.w 1				; unused

DMA_queue			ds.w $12*7		; stores all the VDP commands necessary to initiate a DMA transfer
DMA_queue_slot			ds.l 1			; points to the next free slot on the queue

Normal_palette			ds.b $80
Normal_palette_line_2 =		Normal_palette+$20	; $20 bytes
Normal_palette_line_3 =		Normal_palette+$40	; $20 bytes
Normal_palette_line_4 =		Normal_palette+$60	; $20 bytes
Target_palette			ds.b $80		; used by palette fading routines
Target_palette_line_2 =		Target_palette+$20	; $20 bytes
Target_palette_line_3 =		Target_palette+$40	; $20 bytes
Target_palette_line_4 =		Target_palette+$60	; $20 bytes
Stack_contents			ds.b $100		; stack contents
System_stack =			*			; this is the top of the stack, it grows downwards

			ds.w 1				; unused
Restart_level_flag		ds.w 1
Level_frame_counter		ds.w 1			; the number of frames which have elapsed since the level started
Debug_object			ds.b 1			; the current position in the debug mode object list
			ds.b 1				; unused
Debug_placement_mode =		*			; both routine and type
Debug_placement_routine		ds.b 1
Debug_placement_type		ds.b 1			; 0 = normal gameplay, 1 = normal object placement, 2 = frame cycling
Debug_camera_delay		ds.b 1
Debug_camera_speed		ds.b 1
V_int_run_count			ds.l 1			; the number of times V-int has run
Current_zone_and_act =		*
Current_zone			ds.b 1
Current_act			ds.b 1
Life_count			ds.b 1
			ds.b 3				; unused
Current_special_stage		ds.b 1
			ds.b 1				; unused
Continue_count			ds.b 1
Super_Sonic_Knux_flag		ds.b 1
Time_over_flag			ds.b 1
Extra_life_flags		ds.b 1
Update_HUD_life_count		ds.b 1
Update_HUD_ring_count		ds.b 1
Update_HUD_timer		ds.b 1
Update_HUD_score		ds.b 1
Ring_count			ds.w 1
Timer				ds.l 1
Timer_minute =			Timer+1
Timer_second =			Timer+2
Timer_frame =			Timer+3			; the second gets incremented when this reaches 60
Score				ds.l 1
Last_star_post_hit		ds.b 1

; the following variables are all saved when hitting a star post
Saved_last_star_post_hit	ds.b 1
Saved_zone_and_act		ds.w 1
Saved_X_pos			ds.w 1
Saved_Y_pos			ds.w 1
Saved_ring_count		ds.w 1
Saved_timer			ds.l 1
Saved_art_tile			ds.w 1
Saved_solid_bits		ds.w 1			; copy of Player 1's top_solid_bit and lrb_solid_bit
Saved_camera_X_pos		ds.w 1
Saved_camera_Y_pos		ds.w 1
Saved_mean_water_level		ds.w 1
Saved_water_full_screen_flag	ds.b 1
Saved_extra_life_flags		ds.b 1
Saved_camera_max_Y_pos		ds.w 1
Saved_dynamic_resize_routine	ds.b 1
Saved_status_secondary		ds.b 1
Special_bonus_entry_flag	ds.b 1			; 1 for entering a Special Stage, 2 for entering a Bonus Stage

; the following variables are all saved when entering a special stage
Saved2_last_star_post_hit	ds.b 1
Saved2_zone_and_act		ds.w 1
Saved2_X_pos			ds.w 1
Saved2_Y_pos			ds.w 1
Saved2_ring_count		ds.w 1
Saved2_timer			ds.l 1
Saved2_art_tile			ds.w 1
Saved2_solid_bits		ds.w 1
Saved2_camera_X_pos		ds.w 1
Saved2_camera_Y_pos		ds.w 1
Saved2_mean_water_level		ds.w 1
Saved2_water_full_screen_flag	ds.b 1
Saved2_extra_life_flags		ds.b 1
Saved2_camera_max_Y_pos		ds.w 1
Saved2_dynamic_resize_routine	ds.b 1

LRZ_rocks_routine		ds.b 1			; routine counter for lrz special rocks
LRZ_rocks_addr_front		ds.l 1			; the address inside the lrz rocks data of the first rock whose X pos is >= Camera_X_pos_coarse + $280
LRZ_rocks_addr_back		ds.l 1			; the address inside the lrz rocks data of the first rock whose X pos is >= Camera_X_pos_coarse - $80
Oscillating_table		ds.b $42		; various oscillating variables
Oscillating_table_end =		*			; end of oscillating data array
Slot_machine_goal_frame_timer			ds.b 1
Slot_machine_goal_frame			ds.b 1
Rings_frame_timer		ds.b 1
Rings_frame			ds.b 1
Slot_machine_peppermint_frame_timer			ds.b 1
Slot_machine_peppermint_frame			ds.b 1
Ring_spill_anim_counter		ds.b 1
Ring_spill_anim_frame		ds.b 1
Ring_spill_anim_accum		ds.w 1
AIZ_vine_angle			ds.w 1			; controls the angle of AIZ giant vines
			ds.w 1				; unused
_unkFEBE			ds.b 1			; unused
Extra_life_flags_P2		ds.b 1
Max_speed_P2			ds.w 1
Acceleration_P2			ds.w 1
Deceleration_P2			ds.w 1
Life_count_P2			ds.b 1			; left over from Sonic 2
Update_HUD_timer_P2		ds.b 1			; used in competition mode
Total_ring_count		ds.w 1			; left over from Sonic 2
Total_ring_count_P2		ds.w 1			; left over from Sonic 2
Monitors_broken			ds.w 1			; left over from Sonic 2. Apparently Sonic 3 developers liked copypasting, since gaining a life from rings also increments this counter
Monitors_broken_P2		ds.w 1			; left over from Sonic 2
Ring_count_P2			ds.w 1			; left over from Sonic 2
Timer_P2			ds.l 1			; used in competition mode
Timer_minute_P2 =		Timer_P2+1
Timer_second_P2 =		Timer_P2+2
Timer_frame_P2 =		Timer_P2+3		; the second gets incremented when this reaches 60
Score_P2			ds.l 1			; left over from Sonic 2
Competition_total_laps			ds.b 1		; total number of laps in competition mode (typically 5)
			ds.b 1				; unused
Competition_current_lap			ds.b 1		; current lap number for player 1 in competition mode
Competition_current_lap_2P		ds.b 1		; current lap number for player 2 in competition mode
Loser_time_left			ds.b 1			; left over from Sonic 2
			ds.b $23			; unused
Results_screen_2P		ds.w 1			; left over from Sonic 2
Perfect_rings_left		ds.w 1			; left over from Sonic 2
_unkFF06			ds.w 1			; unknown
Player_mode			ds.w 1			; 0 = Sonic and Tails, 1 = Sonic alone, 2 = Tails alone, 3 = Knuckles alone
Player_option			ds.w 1			; option selected on level select, data select screen or Sonic & Knuckles title screen
			ds.w 1				; unused

Kos_decomp_queue_count		ds.w 1			; the number of pieces of data on the queue. Sign bit set indicates a decompression is in progress
Kos_decomp_stored_registers	ds.w 20			; allows decompression to be spread over multiple frames
Kos_decomp_stored_SR		ds.w 1
Kos_decomp_bookmark		ds.l 1			; the address within the Kosinski queue processor at which processing is to be resumed
Kos_description_field		ds.w 1			; used by the Kosinski queue processor the same way the stack is used by the normal Kosinski decompression routine
Kos_decomp_queue		ds.l 2*4		; 2 longwords per entry, first is source location and second is decompression location
Kos_decomp_source =		Kos_decomp_queue	; long ; the compressed data location for the first entry in the queue
Kos_decomp_destination =	Kos_decomp_queue+4	; long ; the decompression location for the first entry in the queue
Kos_modules_left		ds.b 1			; the number of modules left to decompresses. Sign bit set indicates a module is being decompressed/has been decompressed
			ds.b 1				; unused
Kos_last_module_size		ds.w 1			; the uncompressed size of the last module in words. All other modules are $800 words
Kos_module_queue		ds.w 3*4		; 6 bytes per entry, first longword is source location and next word is VRAM destination
Kos_module_source =		Kos_module_queue	; long ; the compressed data location for the first module in the queue
Kos_module_destination =	Kos_module_queue+4	; word ; the VRAM destination for the first module in the queue

_unkFF7C			ds.w 1
_unkFF7E			ds.w 1
Level_select_repeat		ds.w 1			; delay counter for repeating the button press. Allows the menu move even when up/down is held down
Level_select_option		ds.w 1			; the current selected option in the level select
Sound_test_sound		ds.w 1
Title_screen_option		ds.b 1
			ds.b 1				; unused
_tempFF88		ds.w 1				; this is used in Sonic 3 Alone, but unused in Sonic & Knuckles and Sonic 3 Complete
Competition_settings =		*			; both items and game type
Competition_items		ds.b 1			; 0 = Enabled, FF = Disabled.
Competition_type		ds.b 1			; 0 = grand prix, 3 = match race, -1 = time attack
_tempFF8C		ds.b 1				; this is used in Sonic 3 Alone, but unused in Sonic & Knuckles and Sonic 3 Complete
			ds.b 1				; unused
Total_bonus_countup		ds.w 1			; the total points to be added due to various bonuses this frame in the end of level results screen
Current_music			ds.w 1
Collected_special_ring_array	ds.l 1			; each bit indicates a special stage entry ring in the current zone
Saved2_status_secondary		ds.b 1
Respawn_table_keep		ds.b 1			; if set, respawn table is not reset during level load
_tempFF98		ds.w 1				; this is used in Sonic 3 Alone, but unused in Sonic & Knuckles and Sonic 3 Complete
Saved_apparent_zone_and_act	ds.w 1
Saved2_apparent_zone_and_act	ds.w 1
			ds.b 1				; unused

Blue_spheres_header_flag	ds.b 1			; 0 = SEGA GENESIS, 1 = SEGA MEGA DRIVE
Blue_spheres_mode		ds.b 1			; 0 = single stage, 1 = full game
Blue_spheres_menu_flag		ds.b 1			; 0 = NO WAY!, 1 = normal, bit 7 set = entering a code
Blue_spheres_current_stage	ds.b 4			; the layout parts that make up the current stage
Blue_spheres_current_level	ds.l 1			; number shown at the top of the full game menu
Blue_spheres_option		ds.b 1			; 0 = level, 1 = start, 2 = code
Blue_spheres_progress_flag	ds.b 1			; 0 = normal, -1 = disabled (single stage mode or using a code from single stage mode)
Blue_spheres_difficulty		ds.b 1			; value currently displayed
Blue_spheres_target_difficulty	ds.b 1			; value read from the layout
SK_alone_flag			ds.w 1			; -1 if Sonic 3 isn't locked on
Emerald_counts =		*			; both chaos and super emeralds
Chaos_emerald_count		ds.b 1
Super_emerald_count		ds.b 1
Collected_emeralds_array	ds.b 7			; 1 byte per emerald, 0 = not collected, 1 = chaos emerald collected, 2 = grey super emerald, 3 = super emerald collected
			ds.b 1				; unused

Emeralds_converted_flag		ds.b 1			; set if at least one emerald has been converted to a super emerald
SK_special_stage_flag		ds.b 1			; set if a Sonic & Knuckles special stage is being run
Title_anim_buffer		ds.b 1			; status of the title animation buffer. Changes 2 different nametables in VDP while the other is being processed
Title_anim_delay		ds.b 1			; title animation delay counter
Title_anim_frame		ds.b 1			; title animation frame number
			ds.b 1				; unused
Next_extra_life_score		ds.l 1
Next_extra_life_score_P2	ds.l 1			; left over from Sonic 2
			ds.w 1				; unused
Debug_saved_mappings		ds.l 1			; player 1 mappings before entering debug mode
Debug_saved_art_tile		ds.w 1			; player 1 art_tile before entering debug mode
Demo_mode_flag :=		*		; S3 uses a different address
				ds.w 1
Next_demo_number :=		*		; S3 uses a different address
				ds.w 1
Blue_spheres_stage_flag :=	*		; S3 uses a different address
				ds.b 1			; set if a Blue Sphere special stage is being run
			ds.b 1				; unused
V_blank_cycles :=		*		; S3 uses a different address
				ds.w 1			; the number of cycles between V-blanks
Graphics_flags :=		*		; S3 uses a different address
				ds.b 1			; bit 7 set = English system, bit 6 set = PAL system
			ds.b 1				; unused
Debug_mode_flag :=		*		; S3 uses a different address
				ds.w 1
			ds.l 1				; unused
Level_select_flag :=		*		; S3 uses a different address
				ds.b 1
Slow_motion_flag :=		*		; S3 uses a different address
				ds.b 1
Debug_cheat_flag :=		*		; S3 uses a different address
				ds.w 1			; set if the debug cheat's been entered
Level_select_cheat_counter :=	*		; S3 uses a different address
				ds.w 1			; progress entering level select cheat, unused
Debug_mode_cheat_counter :=	*		; S3 uses a different address
				ds.w 1			; progress entering debug mode cheat, unused
Competition_mode :=		*		; S3 uses a different address
				ds.w 1
P1_character :=			*		; S3 uses a different address
				ds.b 1			; 0 = Sonic, 1 = Tails, 2 = Knuckles
P2_character :=			*		; S3 uses a different address
				ds.b 1
			ds.l 1				; unused

V_int_jump :=			*		; S3 uses a different address
				ds.b 6			; contains an instruction to jump to the V-int handler
V_int_addr :=			V_int_jump+2		; long
H_int_jump :=			*		; S3 uses a different address
				ds.b 6			; contains an instruction to jump to the H-int handler
H_int_addr :=			H_int_jump+2		; long
Checksum_string :=		*		; S3 uses a different address
				ds.l 1			; set to Ref_Checksum_String once the checksum routine has run
Ref_Checksum_String := 'SM&K'

.check =	(*)&$FFFFFF
	if (.check>0)&(.check<$FF0000)
		fatal "Sonic & Knuckles RAM definitions are too large by $\{*} bytes!"
	endif
	dephase

; extra Special Stage variables
	phase Pos_table_P2
SStage_scalar_index_0		ds.w 1			; unknown scalar table index value
SStage_scalar_index_1		ds.w 1			; unknown scalar table index value
SStage_scalar_index_2		ds.w 1			; unknown scalar table index value
SStage_scalar_result_0		ds.l 1			; unknown scalar table results values
SStage_scalar_result_1		ds.l 1			; unknown scalar table results values
SStage_scalar_result_2		ds.l 1			; unknown scalar table results values
	ds.b $A
SStage_scalar_result_3		ds.l 1			; unknown scalar table results values
Special_stage_anim_frame	ds.w 1			; special stage globe's current animation frame, $10 and higher is turning
Special_stage_X_pos		ds.w 1
Special_stage_Y_pos		ds.w 1
Special_stage_angle		ds.b 1			; $00 = north, $40 = west, $80 = south, $C0 = east
			ds.b 1				; unused
Special_stage_velocity		ds.w 1			; player's movement speed, negative when going backwards
Special_stage_turning		ds.b 1			; direction of next turn, 4 = left, -4 = right
Special_stage_bumper_lock	ds.b 1			; if set, the player can't start advancing by pressing up
Special_stage_prev_anim_frame	ds.b 1
			ds.b 2				; unused
Special_stage_palette_frame	ds.b 1			; same as Special_stage_anim_frame, but set to 0 while turning
Special_stage_turn_lock		ds.b 1			; if set, the player can't turn
Special_stage_advancing		ds.b 1			; set when the player player presses up
Special_stage_jumping		ds.b 1			; $80 = normal jump, $81 = spring
Special_stage_fade_timer	ds.b 1			; counts up when leaving the special stage
Special_stage_prev_X_pos	ds.w 1
Special_stage_prev_Y_pos	ds.w 1
Special_stage_spheres_left	ds.w 1
Special_stage_ring_count	ds.w 1
Special_stage_sphere_HUD_flag	ds.b 1
Special_stage_extra_life_flags	ds.b 1			; when bit 7 is set, the ring HUD is updated
Special_stage_rate_timer	ds.w 1			; when this reaches 0, the special stage speeds up
Special_stage_jumping_P2	ds.b 1			; $80 = normal jump, $81 = spring
			ds.b 1				; unused
Special_stage_rings_left	ds.w 1
Special_stage_rate		ds.w 1			; player's maximum speed in either direction
Special_stage_palette_addr	ds.l 1			; ROM address of the stage's color palette
Special_stage_clear_timer	ds.w 1			; counts up after getting the last sphere, when it reaches $100 the emerald appears
Special_stage_clear_routine	ds.b 1			; if set, the player can't jump
Special_stage_emerald_timer	ds.b 1			; counts down when the emerald appears, when it reaches 0 the emerald sound plays
Special_stage_interact		ds.w 1			; address of the last bumper touched, or the emerald at the end of the stage
Special_stage_started		ds.b 1			; set when the player begins moving at the start of the stage
			ds.b $2F			; unused
SStage_extra_sprites :=		*		; S3 uses a different address
				ds.b $70		; some extra sprite info for special stages
	dephase
; ---------------------------------------------------------------------------
; Art tile stuff
palette_line_0      =      (0<<13)
palette_line_1      =      (1<<13)
palette_line_2      =      (2<<13)
palette_line_3      =      (3<<13)
high_priority       =      (1<<15)
tile_mask           =      $07FF
drawing_mask        =      $7FFF

; ---------------------------------------------------------------------------
; VRAM and tile art base addresses.
; VRAM Reserved regions.
VRAM_Plane_A_Name_Table               = $C000	; Extends until $CFFF
VRAM_Plane_B_Name_Table               = $E000	; Extends until $EFFF

; Menu background.
ArtTile_ArtKos_S3MenuBG               = $0001

; Competition mode.
ArtTile_ArtKos_Competition_LevSel     = $029F
ArtTile_ArtKos_Competition_ModeSel    = $034A
ArtTile_ArtKos_Competition_Results    = $034A
ArtTile_ArtKos_Competition_CharSel    = $05C9

; Save screen.
ArtTile_ArtKos_Save_Misc              = $029F
ArtTile_ArtKos_Save_Extra             = $0454

; ---------------------------------------------------------------------------
; Universal locations.

; Universal (used on all standard levels).
ArtTile_Monitors                      = $04C4
ArtTile_CutsceneKnux                  = $04DA
ArtTile_Explosion                     = $05A0
ArtTile_StarPost                      = $05E4
ArtTile_Player_1                      = $0680
ArtTile_Player_2                      = $06A0
ArtTile_Player_2_Tail                 = $06B0
ArtTile_Ring                          = $06BC
ArtTile_Shield                        = $079C
ArtTile_Shield_Sparks                 = $07BB
ArtTile_DashDust                      = $07E0
ArtTile_DashDust_P2                   = $07F0

; ---------------------------------------------------------------------------
; Sound commands list.

	phase $E1
mus__FirstCmd =			*		; ID of the first sound command
mus_FadeOut			ds.b 1		; $E1 - fade out music
mus_Stop			ds.b 1		; $E2 - stop music and sound effects
mus_MutePSG			ds.b 1		; $E3 - mute all PSG channels
mus_StopSFX			ds.b 1		; $E4 - stop all sound effects
mus_FadeOut2			ds.b 1		; $E5 - fade out music (duplicate)
mus__EndCmd =			*		; next ID after last sound command

mus_S2SEGA =			$FA		; $FA - SEGA sound ID in Sonic 2
mus_StopSEGA =			$FE		; $FE - Stop SEGA sound
mus_SEGA =			$FF		; $FF - Play SEGA sound
	dephase
; ---------------------------------------------------------------------------
; Music ID's list. These do not affect the sound driver, be careful.

	phase $01
mus__First =			*		; ID of the first music
mus_AIZ1			ds.b 1		; $01
mus_AIZ2			ds.b 1		; $02
mus_HCZ1			ds.b 1		; $03
mus_HCZ2			ds.b 1		; $04
mus_MGZ1			ds.b 1		; $05
mus_MGZ2			ds.b 1		; $06
mus_CNZ1			ds.b 1		; $07
mus_CNZ2			ds.b 1		; $08
mus_FBZ1			ds.b 1		; $09
mus_FBZ2			ds.b 1		; $0A
mus_ICZ1			ds.b 1		; $0B
mus_ICZ2			ds.b 1		; $0C
mus_LBZ1			ds.b 1		; $0D
mus_LBZ2			ds.b 1		; $0E
mus_MHZ1			ds.b 1		; $0F
mus_MHZ2			ds.b 1		; $10
mus_SOZ1			ds.b 1		; $11
mus_SOZ2			ds.b 1		; $12
mus_LRZ1			ds.b 1		; $13
mus_LRZ2			ds.b 1		; $14
mus_SSZ				ds.b 1		; $15
mus_DEZ1			ds.b 1		; $16
mus_DEZ2			ds.b 1		; $17
mus_MinibossK			ds.b 1		; $18
mus_EndBoss			ds.b 1		; $19
mus_DDZ				ds.b 1		; $1A
mus_Pachinko			ds.b 1		; $1B
mus_SpecialStage		ds.b 1		; $1C
mus_Slots			ds.b 1		; $1D
mus_Gumball			ds.b 1		; $1E
mus_Knuckles			ds.b 1		; $1F
mus_ALZ				ds.b 1		; $20
mus_BPZ				ds.b 1		; $21
mus_DPZ				ds.b 1		; $22
mus_CGZ				ds.b 1		; $23
mus_EMZ				ds.b 1		; $24
mus_TitleScreen			ds.b 1		; $25
mus_Credits3			ds.b 1		; $26
mus_GameOver			ds.b 1		; $27
mus_Continue			ds.b 1		; $28
mus_GotThroughAct		ds.b 1		; $29
mus_ExtraLife			ds.b 1		; $2A
mus_Emerald			ds.b 1		; $2B
mus_Invincibility		ds.b 1		; $2C
mus_CompetitionMenu		ds.b 1		; $2D
mus_Miniboss			ds.b 1		; $2E
mus_DataSelect			ds.b 1		; $2F
mus_FinalBoss			ds.b 1		; $30
mus_Drowning			ds.b 1		; $31
mus_Ending			ds.b 1		; $32
mus__End =			*		; next ID after last music
	dephase

; ---------------------------------------------------------------------------
; Sound effect ID's list. These do not affect the sound driver, be careful.

	phase $33
sfx__First =			*		; ID of the first sound effect
sfx_RingRight			ds.b 1		; $33
sfx_RingLeft			ds.b 1		; $34
sfx_Death			ds.b 1		; $35
sfx_Skid			ds.b 1		; $36
sfx_SpikeHit			ds.b 1		; $37
sfx_Bubble			ds.b 1		; $38
sfx_Splash			ds.b 1		; $39
sfx_Shield			ds.b 1		; $3A
sfx_Drown			ds.b 1		; $3B
sfx_Roll			ds.b 1		; $3C
sfx_Break			ds.b 1		; $3D
sfx_FireShield			ds.b 1		; $3E
sfx_BubbleShield		ds.b 1		; $3F
sfx_UnknownShield		ds.b 1		; $40
sfx_LightningShield		ds.b 1		; $41
sfx_InstaAttack			ds.b 1		; $42
sfx_FireAttack			ds.b 1		; $43
sfx_BubbleAttack		ds.b 1		; $44
sfx_ElectricAttack		ds.b 1		; $45
sfx_Whistle			ds.b 1		; $46
sfx_SandwallRise		ds.b 1		; $47
sfx_Blast			ds.b 1		; $48
sfx_Thump			ds.b 1		; $49
sfx_Grab			ds.b 1		; $4A
sfx_WaterfallSplash		ds.b 1		; $4B
sfx_GlideLand			ds.b 1		; $4C
sfx_Projectile			ds.b 1		; $4D
sfx_MissileExplode		ds.b 1		; $4E
sfx_FlamethrowerQuiet		ds.b 1		; $4F
sfx_BossActivate		ds.b 1		; $50
sfx_MissileThrow		ds.b 1		; $51
sfx_SpikeMove			ds.b 1		; $52
sfx_Charging			ds.b 1		; $53
sfx_BossLaser			ds.b 1		; $54
sfx_BlockConveyor		ds.b 1		; $55
sfx_FlipBridge			ds.b 1		; $56
sfx_Geyser			ds.b 1		; $57
sfx_FanLatch			ds.b 1		; $58
sfx_Collapse			ds.b 1		; $59
sfx_UnknownCharge		ds.b 1		; $5A
sfx_Switch			ds.b 1		; $5B
sfx_MechaSpark			ds.b 1		; $5C
sfx_FloorThump			ds.b 1		; $5D
sfx_Laser			ds.b 1		; $5E
sfx_Crash			ds.b 1		; $5F
sfx_BossZoom			ds.b 1		; $60
sfx_BossHitFloor		ds.b 1		; $61
sfx_Jump			ds.b 1		; $62
sfx_Starpost			ds.b 1		; $63
sfx_PulleyGrab			ds.b 1		; $64
sfx_BlueSphere			ds.b 1		; $65
sfx_AllSpheres			ds.b 1		; $66
sfx_LevelProjectile		ds.b 1		; $67
sfx_Perfect			ds.b 1		; $68
sfx_PushBlock			ds.b 1		; $69
sfx_Goal			ds.b 1		; $6A
sfx_ActionBlock			ds.b 1		; $6B
sfx_Splash2			ds.b 1		; $6C
sfx_UnknownShift		ds.b 1		; $6D
sfx_BossHit			ds.b 1		; $6E
sfx_Rumble2			ds.b 1		; $6F
sfx_LavaBall			ds.b 1		; $70
sfx_Shield2			ds.b 1		; $71
sfx_Hoverpad			ds.b 1		; $72
sfx_Transporter			ds.b 1		; $73
sfx_TunnelBooster		ds.b 1		; $74
sfx_BalloonPlatform		ds.b 1		; $75
sfx_TrapDoor			ds.b 1		; $76
sfx_Balloon			ds.b 1		; $77
sfx_GravityMachine		ds.b 1		; $78
sfx_Lightning			ds.b 1		; $79
sfx_BossMagma			ds.b 1		; $7A
sfx_SmallBumpers		ds.b 1		; $7B
sfx_ChainTension		ds.b 1		; $7C
sfx_UnknownPump			ds.b 1		; $7D
sfx_GroundSlide			ds.b 1		; $7E
sfx_FrostPuff			ds.b 1		; $7F
sfx_IceSpikes			ds.b 1		; $80
sfx_TubeLauncher		ds.b 1		; $81
sfx_SandSplash			ds.b 1		; $82
sfx_BridgeCollapse		ds.b 1		; $83
sfx_UnknownPowerUp		ds.b 1		; $84
sfx_UnknownPowerDown		ds.b 1		; $85
sfx_Alarm			ds.b 1		; $86
sfx_MushroomBounce		ds.b 1		; $87
sfx_PulleyMove			ds.b 1		; $88
sfx_WeatherMachine		ds.b 1		; $89
sfx_Bouncy			ds.b 1		; $8A
sfx_ChopTree			ds.b 1		; $8B
sfx_ChopStuck			ds.b 1		; $8C
sfx_UnknownFlutter		ds.b 1		; $8D
sfx_UnknownRevving		ds.b 1		; $8E
sfx_DoorOpen			ds.b 1		; $8F
sfx_DoorMove			ds.b 1		; $90
sfx_DoorClose			ds.b 1		; $91
sfx_GhostAppear			ds.b 1		; $92
sfx_BossRecovery		ds.b 1		; $93
sfx_ChainTick			ds.b 1		; $94
sfx_BossHand			ds.b 1		; $95
sfx_MechaLand			ds.b 1		; $96
sfx_EnemyBreath			ds.b 1		; $97
sfx_BossProjectile		ds.b 1		; $98
sfx_UnknownPlink		ds.b 1		; $99
sfx_SpringLatch			ds.b 1		; $9A
sfx_ThumpBoss			ds.b 1		; $9B
sfx_SuperEmerald		ds.b 1		; $9C
sfx_Targeting			ds.b 1		; $9D
sfx_Clank			ds.b 1		; $9E
sfx_SuperTransform		ds.b 1		; $9F
sfx_MissileShoot		ds.b 1		; $A0
sfx_UnknownOminous		ds.b 1		; $A1
sfx_FloorLauncher		ds.b 1		; $A2
sfx_GravityLift			ds.b 1		; $A3
sfx_MechaTransform		ds.b 1		; $A4
sfx_UnknownRise			ds.b 1		; $A5
sfx_LaunchGrab			ds.b 1		; $A6
sfx_LaunchReady			ds.b 1		; $A7
sfx_EnergyZap			ds.b 1		; $A8
sfx_AirDing			ds.b 1		; $A9
sfx_Bumper			ds.b 1		; $AA
sfx_Spindash			ds.b 1		; $AB
sfx_Continue			ds.b 1		; $AC
sfx_LaunchGo			ds.b 1		; $AD
sfx_Flipper			ds.b 1		; $AE
sfx_EnterSS			ds.b 1		; $AF
sfx_Register			ds.b 1		; $B0
sfx_Spring			ds.b 1		; $B1
sfx_Error			ds.b 1		; $B2
sfx_BigRing			ds.b 1		; $B3
sfx_Explode			ds.b 1		; $B4
sfx_Diamonds			ds.b 1		; $B5
sfx_Dash			ds.b 1		; $B6
sfx_SlotMachine			ds.b 1		; $B7
sfx_Signpost			ds.b 1		; $B8
sfx_RingLoss			ds.b 1		; $B9
sfx_Flying			ds.b 1		; $BA
sfx_FlyTired			ds.b 1		; $BB
sfx__FirstContinuous =		*		; ID of the first continuous sound effect
sfx_SlideSkidLoud		ds.b 1		; $BC
sfx_LargeShip			ds.b 1		; $BD
sfx_RobotnikSiren		ds.b 1		; $BE
sfx_BossRotate			ds.b 1		; $BF
sfx_FanBig			ds.b 1		; $C0
sfx_FanSmall			ds.b 1		; $C1
sfx_FlamethrowerLoud		ds.b 1		; $C2
sfx_GravityTunnel		ds.b 1		; $C3
sfx_BossPanic			ds.b 1		; $C4
sfx_UnknownSpin			ds.b 1		; $C5
sfx_WaveHover			ds.b 1		; $C6
sfx_CannonTurn			ds.b 1		; $C7
sfx_SlideSkidQuiet		ds.b 1		; $C8
sfx_SpikeBalls			ds.b 1		; $C9
sfx_LightTunnel			ds.b 1		; $CA
sfx_Rumble			ds.b 1		; $CB
sfx_BigRumble			ds.b 1		; $CC
sfx_DeathEggRiseLoud		ds.b 1		; $CD
sfx_WindQuiet			ds.b 1		; $CE
sfx_WindLoud			ds.b 1		; $CF
sfx_Rising			ds.b 1		; $D0
sfx_UnknownFlutter2		ds.b 1		; $D1
sfx_GumballTab			ds.b 1		; $D2
sfx_DeathEggRiseQuiet		ds.b 1		; $D3
sfx_TurbineHum			ds.b 1		; $D4
sfx_LavaFall			ds.b 1		; $D5
sfx_UnknownZap			ds.b 1		; $D6
sfx_ConveyorPlatform		ds.b 1		; $D7
sfx_UnknownSaw			ds.b 1		; $D8
sfx_MagneticSpike		ds.b 1		; $D9
sfx_LeafBlower			ds.b 1		; $DA
sfx_WaterSkid			ds.b 1		; $DB
mus_CreditsK			ds.b 1		; $DC - Can also be treated as SFX?
				ds.b 3		; unused SFX slots, the driver will happily play them though
sfx__End =			*		; next ID after the last sound effect

	dephase
	!org 0				; make sure we reset the ROM position to 0
