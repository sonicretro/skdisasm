=========================================================
Stealth's Sonic and Knuckles Split Disassembly v1.0
Split and compiled by jman2050
=========================================================

After a year and a half of work starting in mid-to-late 2009 a complete split disassembly of Sonic and Knuckles is now available
for editing and research. This is a followup to Stealth's original 2007 release of the disassembly, being built from that source.
The release of this project represents the completion of usable split disassemblies for all three of the original Genesis Sonic
games, though for the sake of simplicity Sonic 3 by itself is ignored. The project also represents the work of several people beyond
myself, and are, recalled to the best of my ability,

STEALTH - The creator of this disassembly and collaborator for this split project. Without his effort creating a usable
disassembly in the first place and his knowledge of the game's structure, this project would absolutely not be possible.

ANDLABS - Spearheaded the initial research and development of the project at the start before I took over for the majority of
the effort. Continued to help with research in various ways.

ROBJOE - Assisted in the testing the integrity of the disassembly and for the creation of several supplemental materials for
use with Stealth's SonED2 program.

MARKEYJESTER - Graciously provided a complete presentable disassembly for the Z80 sound driver, which was incorporated into
the disassembly package allowing the easy movement of sound-related data. Also assisted in research for identifying parts of
the game's data

LINNCAKI - Provided the actual implementation of MarkeyJester's disassembled sound driver into the package at large. Also for general
assistance and integrity testing

CINOSSU - General assistance and testing

SHOBIZ - Performed the important task of converting the disassembly to work with the Macro AS Assembler, which in turn allowed the
easy integration of the disassembled sound driver into the project.

MALEVOLENCE - Provided the SVN used to coordinate the efforts of many of those involved with the project.

=========================================================

What follows from here are several collected personal notes about the usage of the disassembly, how it's organized, and other
random tidbits that are deemed relevant.




=========================================================
REGARDING THE DIRECTORY STRUCTURE
=========================================================
As should be noted, the directory structure of this disassembly is decidedly different from releases of previous split
disassemblies. Instead of generally organizing data solely based on what type of data it is, effort has been made to seperate
data contextually, grouping each file more by what they are used for than anything else. The first primary directory is GENERAL,
which contains data used for various miscellaneous elements of the game including the title screen, special stage, menus, etc, and
also contains the Sprites folder, which itself contains seperate folders for each badnik and for each general-usage object.
This is also where the data regarding the player objects themselves are stored.

The second directory is LEVELS, which provides seperate folders for each zone in the game, each containing all data directly used
for that level, be it tiles, blocks, chunks, miscellaneous object data for various level elements, etc.

For the sake of convenience, all sound-related data has been seperated into its own folder, SOUND.

And finally, data expressly used for the Sonic 3 Lock-on functionality is included in the S3 LOCKON folder.

Please explore each folder to learn where everything is and how data is organized.

=========================================================
REGARDING THE ASSEMBLY MACRO SONIC3_COMPLETE
=========================================================
At the start of the ASM file is the macro Sonic3_Complete, which is set to 1 by default. When set to 0, the assembly will build a
byte-perfect Sonic and Knuckles rom, not using any specific Sonic 3 data, instead relying on an appended S3.bin rom for that
purpose. Setting it to 1, however, will change the assembly process, incorporating all necessary Sonic 3 data split from the original
rom to create a complete Sonic 3 and Knuckles rom without filler. This macro also enables certain minor changes to the code
to better facilitate changes to the game, and also enables the recompilation of all sound driver-related data. If your goal is to
heavily modify Sonic 3 and Knuckles, then keeping the macro Sonic3_Complete at 1 is the recommended choice.

=========================================================
REGARDING BUILDING THE DISASSEMBLY
=========================================================
The 'BuildScripts' directory contains two sets of build scripts - the windows batch files (*.bat), and the python scripts (*.py).
The .bat ones are the simplest to use but will only work on windows. The python scripts are cross platform (windows and mac) but
require python to be installed.

Batch files: (double click to run)
buildSK.bat          - builds a byte-perfect copy of the Sonic And Knuckles rom in the base dir.
buildS3Complete.bat  - builds a combined Sonic 3 And Knuckles rom (using the SONIC3_COMPLETE macro detailed above).

Python files: (run with 'python nameOfScript')
buildSK.py             - builds a byte-perfect copy of the Sonic And Knuckles rom in the base dir. Output and errors go in the 'Builds' sub dir.
buildS3Complete.py     - builds a combined Sonic 3 And Knuckles rom (using the SONIC3_COMPLETE macro detailed above). Output and errors go in the 'Builds' sub dir.
buildAndVerify.py      - builds both a S&K rom and a S3 Complete rom, then verifies that the S&K rom is byte identical to the original rom. Output and errors go in the 'Builds' sub dir.

=========================================================
REGARDING EDITING WITH SONED2
=========================================================
The disassembly also comes with a SONED PROJECTS folder, which contains prebuilt project files for use with SonEd2 v. 11.02.24,
recently released and available at Stealth's site http://stealth.hapisan.com/SonED/

There is no built-in support for other level editors at this time.

=========================================================
REGARDING THE DISASSEMBLY'S COMPLETION
=========================================================
Though this split disassembly is "complete" in that it splits all relevant data and is usable for editing, there are still many
aspects of the disassembly that await completion. The naming scheme for various routines and data is inconsistent at best, and much
of the code and unsplit data remains unidentified. Community work has been done to other disassemblies to alleviate the incomplete
portions of those disassemblies and it is my expectation that similar efforts will be made on this one. Neither any of the
contributors mentioned above nor I bear any direct responsibility for changes that may be made to the disassembly from this 
release forward unless otherwise stated.

=========================================================
REGARDING HOW SONIC AND KNUCKLES WORKS
=========================================================
Sonic and Knuckles, and Sonic 3 for that matter, are obviously extensions of Sonic 2's code, but are still very different in how
they do things. Sonic and Knuckles overhauls many of the internal systems that Sonic 2 used for the sake of convenience,
organization, and speed. This includes but is not limited to Moduled Kosinski decompression for realtime decompression of
art data, changes to the object system in various ways, including major changes to the Sprite Status Table, usage of built-in
routines to better handle relationships between different objects, such as those between parent and child objects, and a completely
overhauled level drawing system that offloads much of the work to outside VBlank and, while being far more flexible and capable,
requires a significantly higher level of skill and knowledge to use properly as opposed to how Sonic 2 did things. Furthermore,
Sonic 3 and Knuckles is heavily event-driven, relying on very specific hardcoded instructions in various levels that must be taken
into account when making any modifications, and require a knowledge of ASM coding to understand and change. Thus it is to be noted
that great care must be taken in modifying Sonic 3 and Knuckles directly and that you MUST KNOW WHAT YOU ARE DOING to bear fruitful
results. If you are not prepared for that type of task, then it's recommended that the disassembly and its data be used mostly
for research purposes while work is done using the far more accesible Sonic 1 or Sonic 2 disassemblies as a base.

=========================================================
REGARDING SOUND AND MUSIC
=========================================================
Though many efforts were made to make the usage of sound and music as flexible as possible, there are some limitations. Each sound
effect and song uses SMPS notation, but differs from previous games in that pointers to various data are absolute rather than
relative. The Z80 can only access one $8000-byte area of the ROM at the time, referred to as "banks", and these pointers refer to 
a location within this banked area in ROM. Practically speaking, this means that each piece of music/sound effect must be located 
at a specific location within its bank to function, and the only way to accomplish this for the time being is manually aligning
each "set" of music/sfx and ensuring that they remain in the correct order and are unedited. If you wish to edit the music or 
sound effects then keep this limitation in mind. There may be tools made in the future to alleviate this issue.

=========================================================
IN CONCLUSION
=========================================================
As was stated, this project represents the work of many people and a great deal of time and effort. It is my hope that this
disassembly is used extensively and improved even further to allow for many great hacks to come. It is also my hope that people
understand the difficulties involved in the project and to put up with any mistakes or problems that may come about as a result
of carelessness or whatnot. Aside from that, keep all the information in this Readme in mind and happy hacking!