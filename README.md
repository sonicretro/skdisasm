# DISCLAIMER

Any and all content presented in this repository is presented for informational and educational purposes only.
Commercial usage is expressly prohibited. Sonic Retro claims no ownership of any code in these repositories.
You assume any and all responsibility for using this content responsibly. Sonic Retro claims no responsibiliy or warranty.


# Sonic 3/Sonic & Knuckles Disassembly

## The Directory Structure

As should be noted, the directory structure of this disassembly is decidedly different from releases of previous split
disassemblies. Instead of generally organizing data solely based on what type of data it is, effort has been made to seperate
data contextually, grouping each file more by what they are used for than anything else. The first primary directory is 'General',
which contains data used for various miscellaneous elements of the game including the title screen, special stage, menus, etc, and
also contains the 'Sprites' folder, which itself contains seperate folders for each badnik and for each general-usage object.
This is also where the data regarding the player objects themselves are stored.

The second directory is 'Levels', which provides seperate folders for each zone in the game, each containing all data directly used
for that level, be it tiles, blocks, chunks, miscellaneous object data for various level elements, etc.

For the sake of convenience, all sound-related data has been seperated into its own folder, 'sound'.

And finally, data expressly used for the Sonic 3 Lock-on functionality is included in the 'Lockon S3' folder.

Please explore each folder to learn where everything is and how data is organized.


## The 'Sonic3_Complete' Flag

Referenced throughout the Sonic & Knuckles disassembly is the 'Sonic3_Complete' flag. When it is set to 0, the disassembly will build a
byte-perfect Sonic & Knuckles ROM, not using any specific Sonic 3 data, instead relying on an appended Sonic 3 ROM for that
purpose. Setting it to 1, however, will change the assembly process, incorporating all necessary Sonic 3 data split from the original
ROM to create a complete Sonic 3 & Knuckles ROM without any filler. This macro also enables certain minor changes to the code
to better facilitate changes to the game. If your goal is to heavily modify Sonic 3 & Knuckles, then keeping 'Sonic3_Complete' set to 1
is the recommended choice.


## Building the Disassembly

The base directory contains two sets of build scripts - the Windows Batch files (*.bat), and the Lua scripts (*.lua).
The Batch files are the simplest to use but will only work on Windows. The Lua scripts are cross platform (Windows, Mac, Linux,
FreeBSD) but require Lua to be installed. The Batch files are ran by double-clicking them, while the Lua scripts are ran on the
command line with 'lua nameOfScript'.

buildS3         - Builds a byte-perfect copy of the Sonic 3 ROM.
buildSK         - Builds a byte-perfect copy of the Sonic & Knuckles ROM.
buildS3Complete - Builds a combined Sonic 3 & Knuckles ROM (using the 'Sonic3_Complete' flag detailed above).
chkbitperfect   - Builds both an S3 ROM and an S&K ROM, then verifies that they are byte-identical to the original ROMs.


## Editing with SonLVL

Inside the 'SonLVL INI Files' directory are project files for SonLVL. SonLVL can be found here: https://info.sonicretro.org/SonLVL


## Editing with SonED2

The disassembly also comes with a 'SonED Projects' folder, which contains prebuilt project files for use with SonEd2 v. 11.02.24,
recently released and available at Stealth's site http://stealth.hapisan.com/SonED/


## The Disassembly's Completion

Though this split disassembly is "complete" in that it splits all relevant data and is usable for editing, there are still many
aspects of the disassembly that await completion. The naming scheme for various routines and data is inconsistent at best, and much
of the code and unsplit data remains unidentified. Community work has been done to other disassemblies to alleviate the incomplete
portions of those disassemblies and it is my expectation that similar efforts will be made on this one. Neither any of the
contributors mentioned above nor I bear any direct responsibility for changes that may be made to the disassembly from this 
release forward unless otherwise stated.


## How Sonic & Knuckles Works

Sonic & Knuckles, and Sonic 3 for that matter, are obviously extensions of Sonic 2's code, but are still very different in how
they do things. Sonic & Knuckles overhauls many of the internal systems that Sonic 2 used for the sake of convenience,
organization, and speed. This includes but is not limited to Moduled Kosinski decompression for realtime decompression of
art data, changes to the object system in various ways, including major changes to the Sprite Status Table, usage of built-in
routines to better handle relationships between different objects, such as those between parent and child objects, and a completely
overhauled level drawing system that offloads much of the work to outside VBlank and, while being far more flexible and capable,
requires a significantly higher level of skill and knowledge to use properly as opposed to how Sonic 2 did things. Furthermore,
Sonic 3 & Knuckles is heavily event-driven, relying on very specific hardcoded instructions in various levels that must be taken
into account when making any modifications, and require a knowledge of ASM coding to understand and change. Thus it is to be noted
that great care must be taken in modifying Sonic 3 & Knuckles directly and that you MUST KNOW WHAT YOU ARE DOING to bear fruitful
results. If you are not prepared for that type of task, then it's recommended that the disassembly and its data be used mostly
for research purposes while work is done using the far more accesible Sonic 1 or Sonic 2 disassemblies as a base.
