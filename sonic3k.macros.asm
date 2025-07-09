; simplifying macros and functions
; nameless temporary symbols should NOT be used inside macros because they can interfere with the surrounding code
; normal labels should be used instead (which automatically become local to the macro)

; sign-extends a 32-bit integer to 64-bit
; all RAM addresses are run through this function to allow them to work in both 16-bit and 32-bit addressing modes
ramaddr function x,(-(x&$80000000)<<1)|x

; makes a VDP command
vdpComm function addr,type,rwd,(((type&rwd)&3)<<30)|((addr&$3FFF)<<16)|(((type&rwd)&$FC)<<2)|((addr&$C000)>>14)

; values for the type argument
VRAM = %100001
CRAM = %101011
VSRAM = %100101

; values for the rwd argument
READ = %001100
WRITE = %000111
DMA = %100111

; tells the VDP to copy a region of 68k memory to VRAM or CRAM or VSRAM
dma68kToVDP macro source,dest,length,type
	lea	(VDP_control_port).l,a5
	move.l	#(($9400|((((length)>>1)&$FF00)>>8))<<16)|($9300|(((length)>>1)&$FF)),(a5)
	move.l	#(($9600|((((source)>>1)&$FF00)>>8))<<16)|($9500|(((source)>>1)&$FF)),(a5)
	move.w	#$9700|(((((source)>>1)&$FF0000)>>16)&$7F),(a5)
	move.w	#(vdpComm(dest,type,DMA)>>16)&$FFFF,(a5)
	move.w	#vdpComm(dest,type,DMA)&$FFFF,(DMA_trigger_word).w
	move.w	(DMA_trigger_word).w,(a5)
	; From '  § 7  DMA TRANSFER' of https://emu-docs.org/Genesis/sega2f.htm:
	;
	; "In the case of ROM to VRAM transfers,
	; a hardware feature causes occasional failure of DMA unless the
	; following two conditions are observed:
	;
	; --The destination address write (to address $C00004) must be a word
	;   write.
	;
	; --The final write must use the work RAM.
	;   There are two ways to accomplish this, by copying the DMA program
	;   into RAM or by doing a final "move.w ram address $C00004""
    endm

; tells the VDP to fill a region of VRAM with a certain byte
dmaFillVRAM macro byte,addr,length
	lea	(VDP_control_port).l,a5
	move.w	#$8F01,(a5) ; VRAM pointer increment: $0001
	move.l	#(($9400|((((length)-1)&$FF00)>>8))<<16)|($9300|(((length)-1)&$FF)),(a5) ; DMA length ...
	move.w	#$9780,(a5) ; VRAM fill
	move.l	#vdpComm(addr,VRAM,DMA),(a5) ; Start at ...
	move.w	#(byte)|((byte)<<8),(VDP_data_port).l ; Fill with byte
.loop:	move.w	(a5),d1
	btst	#1,d1
	bne.s	.loop ; busy loop until the VDP is finished filling...
	move.w	#$8F02,(a5) ; VRAM pointer increment: $0002
    endm

; calculates initial loop counter value for a dbf loop
; that writes n bytes total at 4 bytes per iteration
bytesToLcnt function n,n>>2-1

; calculates initial loop counter value for a dbf loop
; that writes n bytes total at 2 bytes per iteration
bytesToWcnt function n,n>>1-1

; calculates initial loop counter value for a dbf loop
; that writes n bytes total at x bytes per iteration
bytesToXcnt function n,x,n/x-1

; fills a region of 68k RAM with 0
clearRAM macro addr,length
    if ((addr)&$8000)==0
	lea	(addr).l,a1
    else
	lea	(addr).w,a1
    endif
	moveq	#0,d0
    if ((addr)&1)
	move.b	d0,(a1)+
    endif
	move.w	#bytesToLcnt(length - ((addr)&1)),d1
.loop:	move.l	d0,(a1)+
	dbf	d1,.loop
    if ((length - ((addr)&1))&2)
	move.w	d0,(a1)+
    endif
    if ((length - ((addr)&1))&1)
	move.b	d0,(a1)+
    endif
    endm

; tells the Z80 to stop, and waits for it to finish stopping (acquire bus)
stopZ80 macro
	move.w	#$100,(Z80_bus_request).l ; stop the Z80
.loop:	btst	#0,(Z80_bus_request).l
	bne.s	.loop ; loop until it says it's stopped
    endm

; tells the Z80 to start again
startZ80 macro
	move.w	#0,(Z80_bus_request).l    ; start the Z80
    endm

; function to make a little-endian 16-bit pointer for the Z80 sound driver
z80_ptr function x,(x)<<8&$FF00|(x)>>8&$7F|$80

; macro to declare a little-endian 16-bit pointer for the Z80 sound driver
rom_ptr_z80 macro addr
	dc.w z80_ptr(addr)
    endm

; macros to convert from tile index to art tiles, block mapping or VRAM address.
make_art_tile function addr,pal,pri,((pri&1)<<15)|((pal&3)<<13)|(addr&tile_mask)
tiles_to_bytes function addr,((addr&$7FF)<<5)

; function to calculate the location of a tile in plane mappings with a width of 40 cells
planeLocH28 function col,line,(($50 * line) + (2 * col))

; macro for generating water palette transition tables
watertransheader macro {INTLABEL}
__LABEL__ label *
	; Number of entries in list minus one
	dc.w (((__LABEL___End - __LABEL__ - 2) / 2) - 1)
	endm

; macro for generating level select strings
levselstr macro str
	save
	codepage	LEVELSELECT
	dc.b strlen(str)-1, str
	restore
    endm

; codepage for level select
	save
	codepage LEVELSELECT
	charset '0','9', 16
	charset 'A','Z', 30
	charset 'a','z', 30
	charset '*', 26
	charset $A9, 27	; '?'
	charset ':', 28
	charset '.', 29
	charset ' ',  0
	restore

; macros for defining animated PLC script lists
zoneanimstart macro {INTLABEL}
__LABEL__ label *
zoneanimcount := 0
zoneanimcur := "__LABEL__"
	dc.w zoneanimcount___LABEL__	; Number of scripts for a zone (-1)
    endm

zoneanimend macro
zoneanimcount_{"\{zoneanimcur}"} = zoneanimcount-1
    endm

zoneanimdeclanonid := 0

zoneanimdecl macro duration,artaddr,vramaddr,numentries,numvramtiles
zoneanimdeclanonid := zoneanimdeclanonid + 1
start:
	dc.l (duration&$FF)<<24|artaddr
	dc.w tiles_to_bytes(vramaddr)
	dc.b numentries, numvramtiles
zoneanimcount := zoneanimcount + 1
    endm

; macro for declaring a "main level load block" (MLLB)
levartptrs macro plc1,plc2,palette,art1,art2,map16x161,map16x162,map128x1281,map128x1282
	dc.l (plc1<<24)|art1
	dc.l (plc2<<24)|art2
	dc.l (palette<<24)|map16x161
	dc.l (palette<<24)|map16x162
	dc.l map128x1281
	dc.l map128x1282
    endm

; macro for a pattern load request list header
; must be on the same line as a label that has a corresponding _End label later
plrlistheader macro {INTLABEL}
__LABEL__ label *
	dc.w (((__LABEL___End - __LABEL__Plc) / 6) - 1)
__LABEL__Plc:
    endm

; macro for a pattern load request
plreq macro toVRAMaddr,fromROMaddr
	dc.l	fromROMaddr
	dc.w	tiles_to_bytes(toVRAMaddr)
    endm

; macro for a debug object list header
; must be on the same line as a label that has a corresponding _End label later
dbglistheader macro {INTLABEL}
__LABEL__ label *
	dc.w ((__LABEL___End - __LABEL__ - 2) / $A)
    endm

; macro to define debug list object data
dbglistobj macro   obj, mapaddr, subtype, frame, vram
	dc.l frame<<24|obj
	dc.l subtype<<24|mapaddr
	dc.w vram
    endm

tribyte macro val
	if "val"<>""
		dc.b (val >> 16)&$FF,(val>>8)&$FF,val&$FF
		shift
		tribyte ALLARGS
	endif
    endm

; macro to define a palette script pointer
palscriptptr	macro header, data
	dc.w data-header, 0
	dc.l header
._headpos :=	header
    endm

; macro to define a palette script header
palscripthdr	macro palette, entries, value
	dc.w (palette)&$FFFF
	dc.b entries-1, value
    endm

; macro to define a palette script data
palscriptdata	macro frames, data
.framec :=	frames-1
	shift
	dc.w ALLARGS
	dc.w .framec
    endm

; macro to define a palette script data from an external file
palscriptfile	macro frames, data
.framec :=	frames-1
	shift
	binclude ALLARGS
	dc.w .framec
    endm

; macro to repeat script from start
palscriptrept	macro header
	dc.w -4
    endm

; macro to define loop from start for x number of times, then initialize with new header
palscriptloop	macro header
	dc.w -8, header-._headpos
._headpos :=	header
    endm

; macro to run the custom script routine
palscriptrun	macro header
	dc.w -$C
    endm

; Function to turn a sample rate into a djnz loop counter
pcmLoopCounterBase function sampleRate,baseCycles, 1+(Z80_Clock/(sampleRate)-(baseCycles)+(13/2))/13
pcmLoopCounter function sampleRate, pcmLoopCounterBase(sampleRate,102) ; 102 is the number of cycles zPlaySEGAPCM takes to deliver one sample.
dpcmLoopCounter function sampleRate, pcmLoopCounterBase(sampleRate,297/2) ; 297 is the number of cycles zPlayDigitalAudio takes to deliver two samples.

; Function to make a little endian (z80) pointer
k68z80Pointer function addr,((((addr&$7FFF)+$8000)<<8)&$FF00)+(((addr&$7FFF)+$8000)>>8)

little_endian function x,(x)<<8&$FF00|(x)>>8&$FF

startBank macro {INTLABEL}
	align	$8000
__LABEL__ label *
soundBankStart := __LABEL__
soundBankName := "__LABEL__"
    endm

DebugSoundbanks := 0

finishBank macro
	if * > soundBankStart + $8000
		fatal "soundBank \{soundBankName} must fit in $8000 bytes but was $\{*-soundBankStart}. Try moving something to the other bank."
	elseif (DebugSoundbanks<>0)&&(MOMPASS=1)
		message "soundBank \{soundBankName} has $\{$8000+soundBankStart-*} bytes free at end."
	endif
    endm

; macro to declare an entry in an offset table rooted at a bank
offsetBankTableEntry macro ptr
	dc.ATTRIBUTE k68z80Pointer(ptr-soundBankStart)
    endm

; Special INCLUDE wrapper function
DACINCLUDE macro file,{INTLABEL}
__LABEL__ label *
	INCLUDE file
__LABEL___Len  := little_endian(*-__LABEL__)
__LABEL___Ptr  := k68z80Pointer(__LABEL__-soundBankStart)
__LABEL__.previous_reference := 0
__LABEL__.current_reference := 0
    endm

; Function magic for boolean arithmetic, because 'if' statements suffer from those annoying 'must be evaluable on first pass' errors.
zero_if_false function boolean,value,value&(0-boolean)
zero_if_true function boolean,value,zero_if_false(~~boolean,value)
ternary function boolean,trueValue,falseValue,zero_if_false(boolean,trueValue)|zero_if_true(boolean,falseValue)

get_z80_bank function value,value-(value#$8000)
is_in_this_z80_bank function value,get_z80_bank(value)==get_z80_bank(*)

; Setup macro for DAC samples.
DAC_Setup macro dacptr,sampleRate
.sample_rate := dacptr.sample_rate
    if "sampleRate"<>""
.sample_rate := int(.sample_rate*sampleRate)
    endif
	dc.b	dpcmLoopCounter(.sample_rate)
	; Your eyes are not deceiving you; DAC metadata does some truly bizarre things.
	; Basically, in Sonic 3, if the DAC sample is not in the same bank as this metadata,
	; then the metadata will have blank pointers. An exception to this is when this is
	; not the first metadata in the bank to reference the DAC sample, in which case it
	; will point to the previous metadata instead. It makes absolutely no sense, but it
	; must be recreated in order to produce a bit-perfect ROM.
	dc.w	zero_if_false((SonicDriverVer <> 3) || is_in_this_z80_bank(dacptr), dacptr_Len)
dacptr.previous_reference := dacptr.current_reference
dacptr.current_reference := *
	dc.w	ternary((SonicDriverVer <> 3) || is_in_this_z80_bank(dacptr), dacptr_Ptr, ternary(is_in_this_z80_bank(dacptr.previous_reference), k68z80Pointer(dacptr.previous_reference), 0))
    endm

startDACBank macro {INTLABEL}
__LABEL__: startBank
		offsetBankTableEntry.w	__LABEL__.DAC_81_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_82_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_83_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_84_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_85_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_86_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_87_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_88_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_89_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_8A_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_8B_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_8C_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_8D_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_8E_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_8F_Setup

		offsetBankTableEntry.w	__LABEL__.DAC_90_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_91_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_92_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_93_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_94_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_95_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_96_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_97_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_98_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_99_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_9A_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_9B_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_9C_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_9D_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_9E_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_9F_Setup

		offsetBankTableEntry.w	__LABEL__.DAC_A0_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_A1_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_A2_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_A3_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_A4_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_A5_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_A6_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_A7_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_A8_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_A9_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_AA_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_AB_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_AC_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_AD_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_AE_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_AF_Setup

		offsetBankTableEntry.w	__LABEL__.DAC_B0_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_B1_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_B2_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_B3_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_B4_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_B5_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_B6_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_B7_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_B8_B9_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_B8_B9_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_BA_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_BB_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_BC_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_BD_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_BE_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_BF_Setup

		offsetBankTableEntry.w	__LABEL__.DAC_C0_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_C1_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_C2_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_C3_Setup
		offsetBankTableEntry.w	__LABEL__.DAC_C4_Setup

__LABEL__.DAC_81_Setup:			DAC_Setup DAC_81_Data
__LABEL__.DAC_82_Setup:			DAC_Setup DAC_82_83_84_85_Data
__LABEL__.DAC_83_Setup:			DAC_Setup DAC_82_83_84_85_Data,0.80
__LABEL__.DAC_84_Setup:			DAC_Setup DAC_82_83_84_85_Data,0.65
__LABEL__.DAC_85_Setup:			DAC_Setup DAC_82_83_84_85_Data,0.56
__LABEL__.DAC_86_Setup:			DAC_Setup DAC_86_Data
__LABEL__.DAC_87_Setup:			DAC_Setup DAC_87_Data
__LABEL__.DAC_88_Setup:			DAC_Setup DAC_88_Data
__LABEL__.DAC_89_Setup:			DAC_Setup DAC_89_Data
__LABEL__.DAC_8A_Setup:			DAC_Setup DAC_8A_8B_Data
__LABEL__.DAC_8B_Setup:			DAC_Setup DAC_8A_8B_Data,0.82
__LABEL__.DAC_8C_Setup:			DAC_Setup DAC_8C_Data
__LABEL__.DAC_8D_Setup:			DAC_Setup DAC_8D_8E_Data
__LABEL__.DAC_8E_Setup:			DAC_Setup DAC_8D_8E_Data,0.77
__LABEL__.DAC_8F_Setup:			DAC_Setup DAC_8F_Data
__LABEL__.DAC_90_Setup:			DAC_Setup DAC_90_91_92_93_Data
__LABEL__.DAC_91_Setup:			DAC_Setup DAC_90_91_92_93_Data,0.78
__LABEL__.DAC_92_Setup:			DAC_Setup DAC_90_91_92_93_Data,0.66
__LABEL__.DAC_93_Setup:			DAC_Setup DAC_90_91_92_93_Data,0.56
__LABEL__.DAC_94_Setup:			DAC_Setup DAC_94_95_96_97_Data
__LABEL__.DAC_95_Setup:			DAC_Setup DAC_94_95_96_97_Data,0.79
__LABEL__.DAC_96_Setup:			DAC_Setup DAC_94_95_96_97_Data,0.70
__LABEL__.DAC_97_Setup:			DAC_Setup DAC_94_95_96_97_Data,0.57
__LABEL__.DAC_98_Setup:			DAC_Setup DAC_98_99_9A_Data
__LABEL__.DAC_99_Setup:			DAC_Setup DAC_98_99_9A_Data,0.71
__LABEL__.DAC_9A_Setup:			DAC_Setup DAC_98_99_9A_Data,0.65
__LABEL__.DAC_9B_Setup:			DAC_Setup DAC_9B_Data
__LABEL__.DAC_A2_Setup:			DAC_Setup DAC_A2_Data
__LABEL__.DAC_A3_Setup:			DAC_Setup DAC_A3_Data
__LABEL__.DAC_A4_Setup:			DAC_Setup DAC_A4_Data
__LABEL__.DAC_A5_Setup:			DAC_Setup DAC_A5_Data
__LABEL__.DAC_A6_Setup:			DAC_Setup DAC_A6_Data
__LABEL__.DAC_A7_Setup:			DAC_Setup DAC_A7_Data
__LABEL__.DAC_A8_Setup:			DAC_Setup DAC_A8_Data
__LABEL__.DAC_A9_Setup:			DAC_Setup DAC_A9_Data
__LABEL__.DAC_AA_Setup:			DAC_Setup DAC_AA_Data
__LABEL__.DAC_AB_Setup:			DAC_Setup DAC_AB_Data
__LABEL__.DAC_AC_Setup:			DAC_Setup DAC_AC_Data
__LABEL__.DAC_AD_Setup:			DAC_Setup DAC_AD_AE_Data
__LABEL__.DAC_AE_Setup:			DAC_Setup DAC_AD_AE_Data,0.76
__LABEL__.DAC_AF_Setup:			DAC_Setup DAC_AF_B0_Data
__LABEL__.DAC_B0_Setup:			DAC_Setup DAC_AF_B0_Data,0.70
__LABEL__.DAC_B1_Setup:			DAC_Setup DAC_B1_Data
__LABEL__.DAC_B2_Setup:			DAC_Setup DAC_B2_B3_Data
__LABEL__.DAC_B3_Setup:			DAC_Setup DAC_B2_B3_Data,0.76
__LABEL__.DAC_B4_Setup:			DAC_Setup DAC_B4_C1_C2_C3_C4_Data
__LABEL__.DAC_B5_Setup:			DAC_Setup DAC_B5_Data
__LABEL__.DAC_B6_Setup:			DAC_Setup DAC_B6_Data
__LABEL__.DAC_B7_Setup:			DAC_Setup DAC_B7_Data
__LABEL__.DAC_B8_B9_Setup:		DAC_Setup DAC_B8_B9_Data
__LABEL__.DAC_BA_Setup:			DAC_Setup DAC_BA_Data
__LABEL__.DAC_BB_Setup:			DAC_Setup DAC_BB_Data
__LABEL__.DAC_BC_Setup:			DAC_Setup DAC_BC_Data
__LABEL__.DAC_BD_Setup:			DAC_Setup DAC_BD_Data
__LABEL__.DAC_BE_Setup:			DAC_Setup DAC_BE_Data
__LABEL__.DAC_BF_Setup:			DAC_Setup DAC_BF_Data
__LABEL__.DAC_C0_Setup:			DAC_Setup DAC_C0_Data
__LABEL__.DAC_C1_Setup:			DAC_Setup DAC_B4_C1_C2_C3_C4_Data,0.88
__LABEL__.DAC_C2_Setup:			DAC_Setup DAC_B4_C1_C2_C3_C4_Data,0.80
__LABEL__.DAC_C3_Setup:			DAC_Setup DAC_B4_C1_C2_C3_C4_Data,0.78
__LABEL__.DAC_C4_Setup:			DAC_Setup DAC_B4_C1_C2_C3_C4_Data,1.04
__LABEL__.DAC_9C_Setup:			DAC_Setup DAC_9C_Data
__LABEL__.DAC_9D_Setup:			DAC_Setup DAC_9D_Data
__LABEL__.DAC_9E_Setup:			DAC_Setup DAC_9E_Data
__LABEL__.DAC_9F_Setup:			DAC_Setup DAC_9F_Data
__LABEL__.DAC_A0_Setup:			DAC_Setup DAC_A0_Data
__LABEL__.DAC_A1_Setup:			DAC_Setup DAC_A1_Data
    endm
