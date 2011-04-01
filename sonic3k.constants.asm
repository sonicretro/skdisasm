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
subtype =		$2C ; byte
ros_bit =		$3B ; byte ; the bit to be cleared when an object is destroyed if the ROS flag is set
ros_addr =		$3C ; word ; the RAM address whose bit to clear when an object is destroyed if the ROS flag is set
routine_secondary =	$3C ; byte ; used by monitors for this purpose at least
vram_art =      $40 ; word ; address of art in VRAM (same as art_tile * $20)
parent =		$42 ; word ; address of the object that owns or spawned this one, if applicable
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
HW_Version =				$A10001
HW_Port_1_Data =			$A10003
HW_Port_2_Data =			$A10005
HW_Expansion_Data =			$A10007
HW_Port_1_Control =			$A10009
HW_Port_2_Control =			$A1000B
HW_Expansion_Control =		$A1000D
HW_Port_1_TxData =			$A1000F
HW_Port_1_RxData =			$A10011
HW_Port_1_SCtrl =			$A10013
HW_Port_2_TxData =			$A10015
HW_Port_2_RxData =			$A10017
HW_Port_2_SCtrl =			$A10019
HW_Expansion_TxData =		$A1001B
HW_Expansion_RxData =		$A1001D
HW_Expansion_SCtrl =		$A1001F
; ---------------------------------------------------------------------------

; VDP addresses
VDP_data_port =			$C00000
VDP_control_port =		$C00004
PSG_input =			$C00011
; ---------------------------------------------------------------------------

; sign-extends a 32-bit integer to 64-bit
; all RAM addresses are run through this function to allow them to work in both 16-bit and 32-bit addressing modes
ramaddr function x,(-(x&$80000000)<<1)|x

; RAM addresses
RAM_start =			ramaddr( $FFFF0000 )
Chunk_table =			ramaddr( $FFFF0000 ) ; $8000 bytes ; chunk (128x128) definitions, $80 bytes per definition

Sprite_table_buffer_2 =		ramaddr(   $FF7880 ) ; $280 bytes ; alternate sprite table for player 1 in competition mode
Sprite_table_buffer_P2 =	ramaddr(   $FF7B00 ) ; $280 bytes ; sprite table for player 2 in competition mode
Sprite_table_buffer_P2_2 =	ramaddr(   $FF7D80 ) ; $280 bytes ; alternate sprite table for player 2 in competition mode

Level_layout_header =		ramaddr( $FFFF8000 ) ; 8 bytes ; first word = chunks per FG row, second word = chunks per BG row, third word = FG rows, fourth word = BG rows
Level_layout_main =		ramaddr( $FFFF8008 ) ; $40 word-sized line pointers followed by actual layout data
Block_table =			ramaddr( $FFFF9000 ) ; $1A00 bytes ; block (16x16) definitions, 8 bytes per definition

Nem_code_table =		ramaddr( $FFFFAA00 ) ; $200 bytes ; code table is built up here and then used during decompression
Sprite_table_input =		ramaddr( $FFFFAC00 ) ; $400 bytes ; 8 priority levels, $80 bytes per level

Object_RAM =			ramaddr( $FFFFB000 ) ; $1FCC bytes ; $4A bytes per object, 110 objects
Player_1 =			ramaddr( $FFFFB000 ) ; main character in 1 player mode, player 1 in Competition mode
Player_2 =			ramaddr( $FFFFB04A ) ; Tails in a Sonic and Tails game, player 2 in Competition mode
Reserved_object_3 =		ramaddr( $FFFFB094 ) ; during a level, an object whose sole purpose is to clear the collision response list is stored here
Dynamic_object_RAM =		ramaddr( $FFFFB0DE ) ; $1A04 bytes ; 90 objects
Level_object_RAM =		ramaddr( $FFFFCAE2 ) ; $4EA bytes ; various fixed in-level objects
Breathing_bubbles =		ramaddr( $FFFFCB2C ) ; for the main character
Breathing_bubbles_P2 =		ramaddr( $FFFFCB76 ) ; for Tails in a Sonic and Tails game
Super_stars =			ramaddr( $FFFFCBC0 ) ; for Super Sonic and Super Knuckles
Hyper_trail =			ramaddr( $FFFFCBC0 ) ; for Hyper Sonic and Hyper Knuckles
Tails_tails_2P =		ramaddr( $FFFFCBC0 ) ; Tails' tails in Competition mode
Tails_tails =			ramaddr( $FFFFCC0A ) ; Tails' tails
Dust =				ramaddr( $FFFFCC54 )
Dust_P2 =			ramaddr( $FFFFCC9E )
Shield =			ramaddr( $FFFFCCE8 )
Shield_P2 =			ramaddr( $FFFFCD32 ) ; left over from Sonic 2 I'm guessing
Hyper_Sonic_stars =		ramaddr( $FFFFCD7C )
Super_Tails_birds =		ramaddr( $FFFFCD7C )
Invincibility_stars =		ramaddr( $FFFFCEA4 )

Kos_decomp_buffer =		ramaddr( $FFFFD000 ) ; $1000 bytes ; each module in a KosM archive is decompressed here and then DMAed to VRAM
H_scroll_buffer =		ramaddr( $FFFFE000 ) ; $380 bytes ; horizontal scroll table is built up here and then DMAed to VRAM
Collision_response_list =	ramaddr( $FFFFE380 ) ; $80 bytes ; only objects in this list are processed by the collision response routines
Stat_table =			ramaddr( $FFFFE400 ) ; $100 bytes ; used by Tails' AI in a Sonic and Tails game
Pos_table_P2 =			ramaddr( $FFFFE400 ) ; $100 bytes ; used by Player 2 in competition mode
Pos_table =			ramaddr( $FFFFE500 ) ; $100 bytes
Competition_saved_data =	ramaddr( $FFFFE600 ) ; $54 bytes ; saved data from Competition Mode
Saved_data =			ramaddr( $FFFFE6AC ) ; $54 bytes ; saved data from 1 player mode
Ring_status_table =		ramaddr( $FFFFE700 ) ; $400 bytes ; 1 word per ring
Object_respawn_table =		ramaddr( $FFFFEB00 ) ; $300 bytes ; 1 byte per object, every object in the level gets an entry

Camera_RAM =			ramaddr( $FFFFEE00 ) ; various camera and scroll-related variables are stored here
H_scroll_amount =		ramaddr( $FFFFEE00 ) ; word ; number of pixels camera scrolled horizontally in the last frame * $100
V_scroll_amount =		ramaddr( $FFFFEE02 ) ; word ; number of pixels camera scrolled vertically in the last frame * $100
H_scroll_amount_P2 =		ramaddr( $FFFFEE04 ) ; word
V_scroll_amount_P2 =		ramaddr( $FFFFEE06 ) ; word
Scroll_lock =			ramaddr( $FFFFEE0A ) ; byte ; if this is set scrolling routines aren't called
Scroll_lock_P2 =		ramaddr( $FFFFEE0B ) ; byte
Camera_target_min_X_pos =	ramaddr( $FFFFEE0C ) ; word
Camera_target_max_X_pos =	ramaddr( $FFFFEE0E ) ; word
Camera_target_min_Y_pos =	ramaddr( $FFFFEE10 ) ; word
Camera_target_max_Y_pos =	ramaddr( $FFFFEE12 ) ; word
Camera_min_X_pos =		ramaddr( $FFFFEE14 ) ; word
Camera_max_X_pos =		ramaddr( $FFFFEE16 ) ; word
Camera_min_Y_pos =		ramaddr( $FFFFEE18 ) ; word
Camera_max_Y_pos =		ramaddr( $FFFFEE1A ) ; word ; this is the only one which ever differs from its target value
Camera_min_X_pos_P2 =		ramaddr( $FFFFEE1C ) ; word
Camera_max_X_pos_P2 =		ramaddr( $FFFFEE1E ) ; word
Camera_min_Y_pos_P2 =		ramaddr( $FFFFEE20 ) ; word
Camera_max_Y_pos_P2 =		ramaddr( $FFFFEE22 ) ; word
H_scroll_frame_offset =		ramaddr( $FFFFEE24 ) ; word ; if this is non-zero with value x, horizontal scrolling will be based on the player's position x / $100 + 1 frames ago
Pos_table_index =		ramaddr( $FFFFEE26 ) ; word ; goes up in increments of 4
H_scroll_frame_offset_P2 =	ramaddr( $FFFFEE28 ) ; word
Pos_table_index_P2 =		ramaddr( $FFFFEE2A ) ; word
Distance_from_screen_top =	ramaddr( $FFFFEE2C ) ; word ; the vertical scroll manager scrolls the screen until the player's distance from the top of the screen is equal to this (or between this and this + $40 when in the air). $60 by default
Distance_from_screen_top_P2 =	ramaddr( $FFFFEE2E ) ; word
Drowned_flag =			ramaddr( $FFFFEE30 ) ; byte
Camera_max_Y_pos_changing =	ramaddr( $FFFFEE32 ) ; byte ; set when the maximum camera Y pos is undergoing a change
Dynamic_resize_routine =	ramaddr( $FFFFEE33 ) ; byte
Fast_V_scroll_flag =		ramaddr( $FFFFEE39 ) ; byte ; if this is set vertical scroll when the player is on the ground and has a speed of less than $800 is capped at 24 pixels per frame instead of 6
V_scroll_value_P2_copy =	ramaddr( $FFFFEE3A ) ; long ; upper word for foreground, lower word for background

Ring_start_addr_ROM =		ramaddr( $FFFFEE42 ) ; long ; address in the ring layout of the first ring whose X position is >= camera X position - 8
Ring_end_addr_ROM =		ramaddr( $FFFFEE46 ) ; long ; address in the ring layout of the first ring whose X position is >= camera X position + 328
Ring_start_addr_RAM =		ramaddr( $FFFFEE4A ) ; word ; address in the ring status table of the first ring whose X position is >= camera X position - 8
Apparent_zone_and_act =		ramaddr( $FFFFEE4E ) ; word
Apparent_zone =			ramaddr( $FFFFEE4E ) ; byte ; always equal to actual zone
Apparent_act =			ramaddr( $FFFFEE4F ) ; byte ; for example, after AIZ gets burnt, this indicates act 1 even though it's actually act 2
Palette_fade_timer =		ramaddr( $FFFFEE50 ) ; word ; the palette gets faded in until this timer expires
Act_3_flag =			ramaddr( $FFFFEE5E ) ; byte ; set when entering LRZ 3 or DEZ 3 directly from previous act. Prevents title card from loading
Camera_X_pos_P2 =		ramaddr( $FFFFEE60 ) ; word
Camera_Y_pos_P2 =		ramaddr( $FFFFEE64 ) ; word
Camera_X_pos_P2_copy =		ramaddr( $FFFFEE68 ) ; word
Camera_Y_pos_P2_copy =		ramaddr( $FFFFEE6C ) ; word
Camera_X_pos =			ramaddr( $FFFFEE78 ) ; word
Camera_Y_pos =			ramaddr( $FFFFEE7C ) ; word
Camera_X_pos_copy =		ramaddr( $FFFFEE80 ) ; word
Camera_Y_pos_copy =		ramaddr( $FFFFEE84 ) ; word
Camera_X_pos_rounded =		ramaddr( $FFFFEE88 ) ; word ; rounded down to the nearest block boundary ($10th pixel)
Camera_Y_pos_rounded =		ramaddr( $FFFFEE8A ) ; word ; rounded down to the nearest block boundary ($10th pixel)
Camera_X_pos_BG_copy =		ramaddr( $FFFFEE8C ) ; word
Camera_Y_pos_BG_copy =		ramaddr( $FFFFEE90 ) ; word
Camera_X_pos_BG_rounded =	ramaddr( $FFFFEE94 ) ; word ; rounded down to the nearest block boundary ($10th pixel)
Camera_Y_pos_BG_rounded =	ramaddr( $FFFFEE96 ) ; word ; rounded down to the nearest block boundary ($10th pixel)
Plane_double_update_flag =	ramaddr( $FFFFEEA4 ) ; word ; set when two block are to be updated instead of one (i.e. the camera's scrolled by more than $10 pixels)
Special_V_int_routine =		ramaddr( $FFFFEEA6 ) ; word
Screen_X_wrap_value =		ramaddr( $FFFFEEA8 ) ; word ; set to $FFFF
Screen_Y_wrap_value =		ramaddr( $FFFFEEAA ) ; word ; either $7FF or $FFF
Camera_Y_pos_mask =		ramaddr( $FFFFEEAC ) ; word ; either $7F0 or $FF0
Layout_row_index_mask =		ramaddr( $FFFFEEAE ) ; word ; either $3C or $7C

Not_ghost_flag =		ramaddr( $FFFFEE49 ) ; byte ; set if Player 2 in competition mode isn't a ghost of player 1
Demo_data_addr =		ramaddr( $FFFFEE52 ) ; long ; keeps getting incremented as the demo progresses
Use_normal_sprite_table =	ramaddr( $FFFFEF3C ) ; word ; if this is set Sprite_table_buffer and Sprite_table_buffer_P2 will be DMAed instead of Sprite_table_buffer_2 and Sprite_table_buffer_P2_2
SRAM_mask_interrupts_flag =	ramaddr( $FFFFEF56 ) ; word ; if this is set SRAM routines will mask all interrupts (by setting the SR to $2700)
Object_index_addr =		ramaddr( $FFFFEF5A ) ; long ; points to either the object index for S3 levels or that for S&K levels
Camera_Y_pos_coarse_back =	ramaddr( $FFFFEF64 ) ; word ; Camera_Y_pos_coarse - $80
Ending_running_flag =		ramaddr( $FFFFEF72 ) ; word ; the only thing this does is prevent the game from pausing
Plane_buffer_2_addr =		ramaddr( $FFFFEF74 ) ; long ; the address of the second plane buffer to process, if applicable
Demo_number =			ramaddr( $FFFFEF7A ) ; byte ; the currently running demo
Ring_consumption_table =	ramaddr( $FFFFEF80 ) ; $80 bytes ; stores the addresses of all rings currently being consumed
Ring_consumption_count =	ramaddr( $FFFFEF80 ) ; word ; the number of rings being consumed currently
Ring_consumption_list =		ramaddr( $FFFFEF82 ) ; $7E bytes ; the remaining part of the ring consumption table

Target_water_palette =		ramaddr( $FFFFF000 ) ; $80 bytes ; used by palette fading routines
Water_palette =			ramaddr( $FFFFF080 ) ; $80 bytes ; this is what actually gets displayed
Water_palette_line_2 =		ramaddr( $FFFFF0A0 ) ; $20 bytes
Water_palette_line_3 =		ramaddr( $FFFFF0C0 ) ; $20 bytes
Water_palette_line_4 =		ramaddr( $FFFFF0E0 ) ; $20 bytes

Plane_buffer =			ramaddr( $FFFFF100 ) ; $480 bytes ; used by level drawing routines
VRAM_buffer =			ramaddr( $FFFFF580 ) ; $80 bytes ; used to temporarily hold data while it is being transferred from one VRAM location to another

Game_mode =			ramaddr( $FFFFF600 ) ; byte
Ctrl_1_logical =		ramaddr( $FFFFF602 ) ; word ; both held and pressed
Ctrl_1_held_logical =		ramaddr( $FFFFF602 ) ; byte 
Ctrl_1_pressed_logical =	ramaddr( $FFFFF603 ) ; byte
Ctrl_1 =			ramaddr( $FFFFF604 ) ; word ; both held and pressed
Ctrl_1_held =			ramaddr( $FFFFF604 ) ; byte ; all held buttons
Ctrl_1_pressed =		ramaddr( $FFFFF605 ) ; byte ; buttons being pressed newly this frame
Ctrl_2 =			ramaddr( $FFFFF606 ) ; word ; both held and pressed
Ctrl_2_held =			ramaddr( $FFFFF606 ) ; byte
Ctrl_2_pressed =		ramaddr( $FFFFF607 ) ; byte
VDP_reg_1_command =		ramaddr( $FFFFF60E ) ; word ; AND the lower byte by $BF and write to VDP control port to disable display, OR by $40 to enable
Demo_timer =			ramaddr( $FFFFF614 ) ; word ; the time left for a demo to start/run
V_scroll_value =		ramaddr( $FFFFF616 ) ; long ; both foreground and background
V_scroll_value_FG =		ramaddr( $FFFFF616 ) ; word
V_scroll_value_BG =		ramaddr( $FFFFF618 ) ; word
V_scroll_value_P2 =		ramaddr( $FFFFF61E ) ; long
V_scroll_value_FG_P2 =		ramaddr( $FFFFF61E ) ; word
V_scroll_value_BG_P2 =		ramaddr( $FFFFF620 ) ; word
Teleport_active_timer =		ramaddr( $FFFFF622 ) ; byte ; left over from Sonic 2
Teleport_active_flag =		ramaddr( $FFFFF623 ) ; byte ; left over from Sonic 2
H_int_counter_command =		ramaddr( $FFFFF624 ) ; word ; contains a command to write to VDP register $0A (line interrupt counter)
H_int_counter =			ramaddr( $FFFFF625 ) ; byte ; just the counter part of the command
Palette_fade_info =		ramaddr( $FFFFF626 ) ; word ; both index and count
Palette_fade_index =		ramaddr( $FFFFF626 ) ; byte ; colour to start fading from
Palette_fade_count =		ramaddr( $FFFFF627 ) ; byte ; the number of colours to fade
Lag_frame_count =		ramaddr( $FFFFF628 ) ; word ; more specifically, the number of times V-int routine 0 has run. Reset at the end of a normal frame
V_int_routine =			ramaddr( $FFFFF62A ) ; byte
Sprites_drawn =			ramaddr( $FFFFF62C ) ; byte ; used to ensure the sprite limit isn't exceeded
Water_palette_data_addr =	ramaddr( $FFFFF62E ) ; long ; points to the water palette data for the current level
RNG_seed =			ramaddr( $FFFFF636 ) ; long ; used by the random number generator
Game_paused =			ramaddr( $FFFFF63A ) ; word
DMA_trigger_word =		ramaddr( $FFFFF640 ) ; word ; transferred from RAM to avoid crashing the Mega Drive
H_int_flag =			ramaddr( $FFFFF644 ) ; word ; unless this is set H-int will return immediately

Water_level =			ramaddr( $FFFFF646 ) ; word ; keeps fluctuating
Mean_water_level =		ramaddr( $FFFFF648 ) ; word ; the steady central value of the water level
Target_water_level =		ramaddr( $FFFFF64A ) ; word
Water_speed =			ramaddr( $FFFFF64C ) ; byte ; this is added to or subtracted from Mean_water_level every frame till it reaches Target_water_level
Water_full_screen_flag =	ramaddr( $FFFFF64E ) ; byte ; set if water covers the entire screen (i.e. the underwater pallete should be DMAed during V-int rather than the normal palette)
Do_Updates_in_H_int =		ramaddr( $FFFFF64F ) ; byte ; if this is set Do_Updates will be called from H-int instead of V-int
Hyper_Sonic_flash_timer =	ramaddr( $FFFFF666 ) ; byte ; used for Hyper Sonic's double jump move
Super_Tails_flag =		ramaddr( $FFFFF667 ) ; byte
Ctrl_2_logical =		ramaddr( $FFFFF66A ) ; word ; both held and pressed
Ctrl_2_held_logical =		ramaddr( $FFFFF66A ) ; byte
Ctrl_2_pressed_logical =	ramaddr( $FFFFF66B ) ; byte
Scroll_force_positions =	ramaddr( $FFFFF676 ) ; byte ; if this is set scrolling will be based on the two variables below rather than the player's actual position
Scroll_forced_X_pos =		ramaddr( $FFFFF678 ) ; word
Scroll_forced_Y_pos =		ramaddr( $FFFFF67C ) ; word

Nem_decomp_queue =		ramaddr( $FFFFF680 ) ; $60 bytes ; 6 bytes per entry, first longword is source location and next word is VRAM destination
Nem_decomp_source =		ramaddr( $FFFFF680 ) ; long ; the compressed data location for the first entry in the queue
Nem_decomp_destination =	ramaddr( $FFFFF684 ) ; word ; destination in VRAM for the first entry in the queue
Nem_decomp_vars =		ramaddr( $FFFFF6E0 ) ; $20 bytes ; various variables used by the Nemesis decompression queue processor
Nem_write_routine =		ramaddr( $FFFFF6E0 ) ; long ; points to either Nem_PCD_WriteRowToVDP or Nem_PCD_WriteRowToVDP_XOR
Nem_repeat_count =		ramaddr( $FFFFF6E4 ) ; long ; stored repeat count for the current palette index
Nem_palette_index =		ramaddr( $FFFFF6E8 ) ; long ; the current palette index
Nem_previous_row =		ramaddr( $FFFFF6EC ) ; long ; used in XOR mode
Nem_data_word =			ramaddr( $FFFFF6F0 ) ; long ; contains the current compressed word being processed
Nem_shift_value =		ramaddr( $FFFFF6F4 ) ; long ; the number of bits the data word needs to be shifted by
Nem_patterns_left =		ramaddr( $FFFFF6F8 ) ; word ; the number of patterns remaining to be decompressed
Nem_frame_patterns_left =	ramaddr( $FFFFF6FA ) ; word ; the number of patterns remaining to be decompressed in the current frame

Rings_manager_routine =		ramaddr( $FFFFF710 ) ; byte
Level_started_flag =		ramaddr( $FFFFF711 ) ; byte
Water_flag =			ramaddr( $FFFFF730 ) ; byte
Flying_carrying_Sonic_flag =	ramaddr( $FFFFF73E ) ; byte ; set when Tails carries Sonic in a Sonic and Tails game
Flying_picking_Sonic_timer =	ramaddr( $FFFFF73F ) ; byte ; until this is 0 Tails can't pick Sonic up
Ctrl_1_title =			ramaddr( $FFFFF748 ) ; word ; copy of Ctrl_1, used on the title screen
Ctrl_1_held_title =		ramaddr( $FFFFF748 ) ; byte
Ctrl_1_pressed_title =		ramaddr( $FFFFF749 ) ; byte
Sonic_Knux_top_speed =		ramaddr( $FFFFF760 ) ; word
Sonic_Knux_acceleration =	ramaddr( $FFFFF762 ) ; word
Sonic_Knux_deceleration =	ramaddr( $FFFFF764 ) ; word
Object_load_routine =		ramaddr( $FFFFF76C ) ; byte ; routine counter for the object loading manager
Camera_X_pos_coarse =		ramaddr( $FFFFF76E ) ; word ; rounded down to the nearest chunk boundary (128th pixel)
Camera_Y_pos_coarse =		ramaddr( $FFFFF770 ) ; word ; rounded down to the nearest chunk boundary (128th pixel)
Object_load_addr_front =	ramaddr( $FFFFF772 ) ; long ; the address inside the object placement data of the first object whose X pos is >= Camera_X_pos_coarse + $280
Object_load_addr_back =		ramaddr( $FFFFF776 ) ; long ; the address inside the object placement data of the first object whose X pos is >= Camera_X_pos_coarse - $80
Object_respawn_index_front =	ramaddr( $FFFFF77A ) ; word ; the object respawn table index for the object at Obj_load_addr_front
Object_respawn_index_back =	ramaddr( $FFFFF77C ) ; word ; the object respawn table index for the object at Obj_load_addr_back
Collision_addr =		ramaddr( $FFFFF796 ) ; long ; points to the primary or secondary collision data as appropriate
Boss_flag =			ramaddr( $FFFFF7AA ) ; byte ; set if a boss fight is going on
Primary_collision_addr =	ramaddr( $FFFFF7B4 ) ; long
Secondary_collision_addr =	ramaddr( $FFFFF7B8 ) ; long
Reverse_gravity_flag =		ramaddr( $FFFFF7C6 ) ; byte
Ctrl_1_locked =			ramaddr( $FFFFF7CA ) ; byte
Ctrl_2_locked =			ramaddr( $FFFFF7CB ) ; byte
Chain_bonus_counter =		ramaddr( $FFFFF7D0 ) ; word
Time_bonus_countdown =		ramaddr( $FFFFF7D2 ) ; word ; used on the results screen
Ring_bonus_countdown =		ramaddr( $FFFFF7D4 ) ; word ; used on the results screen
Camera_X_pos_coarse_back =	ramaddr( $FFFFF7DA ) ; word ; Camera_X_pos_coarse - $80
Level_trigger_array =		ramaddr( $FFFFF7E0 ) ; $10 bytes ; used by buttons, etc.

Sprite_table_buffer =		ramaddr( $FFFFF800 ) ; $280 bytes
DMA_queue =			ramaddr( $FFFFFB00 ) ; $FC bytes ; stores all the VDP commands necessary to initiate a DMA transfer
DMA_queue_slot =		ramaddr( $FFFFFBFC ) ; long ; points to the next free slot on the queue

Normal_palette =		ramaddr( $FFFFFC00 ) ; $80 bytes
Normal_palette_line_2 =		ramaddr( $FFFFFC20 ) ; $20 bytes
Normal_palette_line_3 =		ramaddr( $FFFFFC40 ) ; $20 bytes
Normal_palette_line_4 =		ramaddr( $FFFFFC60 ) ; $20 bytes
Target_palette =		ramaddr( $FFFFFC80 ) ; $80 bytes ; used by palette fading routines
Target_palette_line_2 =		ramaddr( $FFFFFCA0 ) ; $20 bytes
Target_palette_line_3 =		ramaddr( $FFFFFCC0 ) ; $20 bytes
Target_palette_line_4 =		ramaddr( $FFFFFCE0 ) ; $20 bytes

System_stack =			ramaddr( $FFFFFE00 ) ; $100 bytes ; this is the top of the stack, it grows downwards
Restart_level_flag =		ramaddr( $FFFFFE02 ) ; word
Level_frame_counter =		ramaddr( $FFFFFE04 ) ; word ; the number of frames which have elapsed since the level started
Debug_object =			ramaddr( $FFFFFE06 ) ; byte ; the current position in the debug mode object list
Debug_placement_mode =		ramaddr( $FFFFFE08 ) ; word ; both routine and type
Debug_placement_routine =	ramaddr( $FFFFFE08 ) ; byte
Debug_placement_type =		ramaddr( $FFFFFE09 ) ; byte ; 0 = normal gameplay, 1 = normal object placement, 2 = frame cycling
V_int_run_count =		ramaddr( $FFFFFE0C ) ; long ; the number of times V-int has run
Current_zone_and_act =		ramaddr( $FFFFFE10 ) ; word
Current_zone =			ramaddr( $FFFFFE10 ) ; byte
Current_act =			ramaddr( $FFFFFE11 ) ; byte
Life_count =			ramaddr( $FFFFFE12 ) ; byte
Current_special_stage =		ramaddr( $FFFFFE16 ) ; byte
Continue_count =		ramaddr( $FFFFFE18 ) ; byte
Super_Sonic_Knux_flag =		ramaddr( $FFFFFE19 ) ; byte
Time_over_flag =		ramaddr( $FFFFFE1A ) ; byte
Extra_life_flags =		ramaddr( $FFFFFE1B ) ; byte
Update_HUD_life_count =		ramaddr( $FFFFFE1C ) ; byte
Update_HUD_ring_count =		ramaddr( $FFFFFE1D ) ; byte
Update_HUD_timer =		ramaddr( $FFFFFE1E ) ; byte
Update_HUD_score =		ramaddr( $FFFFFE1F ) ; byte
Ring_count =			ramaddr( $FFFFFE20 ) ; word
Timer =				ramaddr( $FFFFFE22 ) ; long
Timer_minute =			ramaddr( $FFFFFE23 ) ; byte
Timer_second =			ramaddr( $FFFFFE24 ) ; byte
Timer_frame =			ramaddr( $FFFFFE25 ) ; byte ; the second gets incremented when this reaches 60
Score =				ramaddr( $FFFFFE26 ) ; long
Last_star_post_hit =		ramaddr( $FFFFFE2A ) ; byte

; the following variables are all saved when hitting a star post
Saved_last_star_post_hit =	ramaddr( $FFFFFE2B ) ; byte
Saved_zone_and_act =		ramaddr( $FFFFFE2C ) ; word
Saved_X_pos =			ramaddr( $FFFFFE2E ) ; word
Saved_Y_pos =			ramaddr( $FFFFFE30 ) ; word
Saved_ring_count =		ramaddr( $FFFFFE32 ) ; word
Saved_timer =			ramaddr( $FFFFFE34 ) ; long
Saved_art_tile =		ramaddr( $FFFFFE38 ) ; word
Saved_solid_bits =		ramaddr( $FFFFFE3A ) ; word ; copy of Player 1's top_solid_bit and lrb_solid_bit
Saved_camera_X_pos =		ramaddr( $FFFFFE3C ) ; word
Saved_camera_Y_pos =		ramaddr( $FFFFFE3E ) ; word
Saved_mean_water_level =	ramaddr( $FFFFFE40 ) ; word
Saved_water_full_screen_flag =	ramaddr( $FFFFFE42 ) ; byte
Saved_extra_life_flags =	ramaddr( $FFFFFE43 ) ; byte
Saved_camera_max_Y_pos =	ramaddr( $FFFFFE44 ) ; word
Saved_dynamic_resize_routine =	ramaddr( $FFFFFE46 ) ; word
Saved_status_secondary =	ramaddr( $FFFFFE47 ) ; word

Special_bonus_entry_flag =	ramaddr( $FFFFFE48 ) ; byte ; 1 for entering a Special Stage, 2 for entering a Bonus Stage

; the following variables are all saved when entering a special stage
Saved2_last_star_post_hit =	ramaddr( $FFFFFE49 ) ; byte
Saved2_zone_and_act =		ramaddr( $FFFFFE4A ) ; word
Saved2_X_pos =			ramaddr( $FFFFFE4C ) ; word
Saved2_Y_pos =			ramaddr( $FFFFFE4E ) ; word
Saved2_ring_count =		ramaddr( $FFFFFE50 ) ; word
Saved2_timer =			ramaddr( $FFFFFE52 ) ; long
Saved2_art_tile =		ramaddr( $FFFFFE56 ) ; word
Saved2_solid_bits =		ramaddr( $FFFFFE58 ) ; word
Saved2_camera_X_pos =		ramaddr( $FFFFFE5A ) ; word
Saved2_camera_Y_pos =		ramaddr( $FFFFFE5C ) ; word
Saved2_mean_water_level =	ramaddr( $FFFFFE5E ) ; word
Saved2_water_full_screen_flag =	ramaddr( $FFFFFE60 ) ; byte
Saved2_extra_life_flags =	ramaddr( $FFFFFE61 ) ; byte
Saved2_camera_max_Y_pos =	ramaddr( $FFFFFE62 ) ; word
Saved2_dynamic_resize_routine =	ramaddr( $FFFFFE64 ) ; byte

Rings_frame_timer =		ramaddr( $FFFFFEB2 ) ; byte
Rings_frame =			ramaddr( $FFFFFEB3 ) ; byte
Ring_spill_anim_counter =	ramaddr( $FFFFFEB6 ) ; byte
Ring_spill_anim_frame =		ramaddr( $FFFFFEB7 ) ; byte
Ring_spill_anim_accum =		ramaddr( $FFFFFEB8 ) ; byte
Life_count_P2 =			ramaddr( $FFFFFEC6 ) ; byte ; left over from Sonic 2
Total_ring_count =		ramaddr( $FFFFFEC8 ) ; word ; left over from Sonic 2
Total_ring_count_P2 =		ramaddr( $FFFFFECA ) ; word ; left over from Sonic 2
Ring_count_P2 =			ramaddr( $FFFFFED0 ) ; word ; left over from Sonic 2
Timer_P2 =			ramaddr( $FFFFFED2 ) ; long ; left over from Sonic 2
Timer_minute_P2 =		ramaddr( $FFFFFED3 ) ; byte ; left over from Sonic 2
Score_P2 =			ramaddr( $FFFFFED6 ) ; long ; left over from Sonic 2
Perfect_rings_left =		ramaddr( $FFFFFF04 ) ; word ; left over from Sonic 2
Player_mode =			ramaddr( $FFFFFF08 ) ; word ; 0 = Sonic and Tails, 1 = Sonic alone, 2 = Tails alone, 3 = Knuckles alone
Player_option =			ramaddr( $FFFFFF0A ) ; word ; option selected on level select, data select screen or Sonic & Knuckles title screen

Kos_decomp_queue_count =	ramaddr( $FFFFFF0E ) ; word ; the number of pieces of data on the queue. Sign bit set indicates a decompression is in progress
Kos_decomp_stored_registers =	ramaddr( $FFFFFF10 ) ; $28 bytes ; allows decompression to be spread over multiple frames
Kos_decomp_stored_SR =		ramaddr( $FFFFFF38 ) ; word
Kos_decomp_bookmark =		ramaddr( $FFFFFF3A ) ; long ; the address within the Kosinski queue processor at which processing is to be resumed
Kos_description_field =		ramaddr( $FFFFFF3E ) ; word ; used by the Kosinski queue processor the same way the stack is used by the normal Kosinski decompression routine
Kos_decomp_queue =		ramaddr( $FFFFFF40 ) ; $20 bytes ; 2 longwords per entry, first is source location and second is decompression location
Kos_decomp_source =		ramaddr( $FFFFFF40 ) ; long ; the compressed data location for the first entry in the queue
Kos_decomp_destination =	ramaddr( $FFFFFF44 ) ; long ; the decompression location for the first entry in the queue
Kos_modules_left =		ramaddr( $FFFFFF60 ) ; byte ; the number of modules left to decompresses. Sign bit set indicates a module is being decompressed/has been decompressed
Kos_last_module_size =		ramaddr( $FFFFFF62 ) ; word ; the uncompressed size of the last module in words. All other modules are $800 words
Kos_module_queue =		ramaddr( $FFFFFF64 ) ; $18 bytes ; 6 bytes per entry, first longword is source location and next word is VRAM destination
Kos_module_source =		ramaddr( $FFFFFF64 ) ; long ; the compressed data location for the first module in the queue
Kos_module_destination =	ramaddr( $FFFFFF68 ) ; word ; the VRAM destination for the first module in the queue

Sound_test_sound =		ramaddr( $FFFFFF84 ) ; word
Title_screen_option =		ramaddr( $FFFFFF86 ) ; byte
Competition_mode_type =		ramaddr( $FFFFFF8B ) ; byte ; 0 = grand prix, 3 = match race, -1 = time attack
Total_bonus_countup =		ramaddr( $FFFFFF8E ) ; word ; the total points to be added due to various bonuses this frame in the end of level results screen
Level_music =			ramaddr( $FFFFFF90 ) ; word

Saved2_status_secondary =	ramaddr( $FFFFFF96 ) ; byte
Saved_apparent_zone_and_act =	ramaddr( $FFFFFF9A ) ; word
Saved2_apparent_zone_and_act =	ramaddr( $FFFFFF9C ) ; word
Blue_spheres_header_flag =	ramaddr( $FFFFFF9F ) ; byte ; 0 = SEGA GENESIS, 1 = SEGA MEGA DRIVE
SK_alone_flag =			ramaddr( $FFFFFFAE ) ; word ; -1 if Sonic 3 isn't locked on
Emerald_count =			ramaddr( $FFFFFFB0 ) ; word ; both chaos and super emeralds
Chaos_emerald_count =		ramaddr( $FFFFFFB0 ) ; byte
Super_emerald_count =		ramaddr( $FFFFFFB1 ) ; byte
Collected_emeralds_array =	ramaddr( $FFFFFFB2 ) ; 7 bytes ; 1 byte per emerald, 0 = not collected, 1 = chaos emerald collected, 2 = grey super emerald, 3 = super emerald collected
SK_special_stage_flag =		ramaddr( $FFFFFFBB ) ; byte ; set if a Sonic & Knuckles special stage is being run
Next_extra_life_score =		ramaddr( $FFFFFFC0 ) ; long
Next_extra_life_score_P2 =	ramaddr( $FFFFFFC4 ) ; long ; left over from Sonic 2

Demo_mode_flag =		ramaddr( $FFFFFFD0 ) ; word
Next_demo_number =		ramaddr( $FFFFFFD2 ) ; word
V_blank_cycles =		ramaddr( $FFFFFFD6 ) ; word ; the number of cycles between V-blanks
Graphics_flags =		ramaddr( $FFFFFFD8 ) ; byte ; bit 7 set = English system, bit 6 set = PAL system
Debug_mode_flag =		ramaddr( $FFFFFFDA ) ; word
Level_select_flag =		ramaddr( $FFFFFFE0 ) ; byte
Slow_motion_flag =		ramaddr( $FFFFFFE1 ) ; byte
Debug_cheat_flag =		ramaddr( $FFFFFFE2 ) ; word ; set if the debug cheat's been entered

Competition_mode =		ramaddr( $FFFFFFE8 ) ; word
P1_character =			ramaddr( $FFFFFFEA ) ; byte ; 0 = Sonic, 1 = Tails, 2 = Knuckles
P2_character =			ramaddr( $FFFFFFEB ) ; byte

V_int_jump =			ramaddr( $FFFFFFF0 ) ; 6 bytes ; contains an instruction to jump to the V-int handler
V_int_addr =			ramaddr( $FFFFFFF2 ) ; long
H_int_jump =			ramaddr( $FFFFFFF6 ) ; 6 bytes ; contains an instruction to jump to the H-int handler
H_int_addr =			ramaddr( $FFFFFFF8 ) ; long
Checksum_string =		ramaddr( $FFFFFFFC ) ; long ; set to 'SM&K' once the checksum routine has run
