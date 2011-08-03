; อออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ

LockOnROM_Start:		binclude "Lockon S3/Header.bin"
	even
Pal_Competition1:		binclude "General/Competition Menu/Palettes/1.bin"
	even
Map_CompetitionObject:		include "General/Competition Menu/Map - Competition Objects.asm"
MapUnc_CompetitionNumbers:		dc.w  $A503, $A50F, $A504, $A510, $A505, $A511, $A506, $A50F, $A507, $A512, $A508, $A513, $A509, $A50F, $A50A, $A510
										dc.w  $A50B, $A50F, $A50C, $A50F, $A50D, $A514, $A50E, $A514, $8000, $8000

Pal_Competition2:		binclude "General/Competition Menu/Palettes/2.bin"
	even
Pal_Competition3:		binclude "General/Competition Menu/Palettes/3.bin"
	even
Pal_Competition4:		binclude "General/Competition Menu/Palettes/4.bin"
	even
Map_CompetitionSelect:		include "General/Competition Menu/Map - Competition Select.asm"

Pal_CompetitionResults:		binclude "General/Competition Menu/Palettes/Results.bin"
	even
MapEni_CompetitionResultsLED:		binclude "General/Competition Menu/Enigma Map/Menu.bin"
	even
MapUnc_CompetitionResultsLetters:		dc.w $A3BA,$ABBA
		dc.w $A3BB,$A3BC
		dc.w $A3BD,$A3BE
		dc.w $A3BF,$A3C0
		dc.w $A3C1,$A3C2
		dc.w $A3C3,$A3C4
		dc.w $A3C5,$A3C6
		dc.w $A3C7,$A3C8
		dc.w $A3C9,$A3CA
		dc.w $A3CB,$A3CC
MapUnc_CompetitionResultsDividers:		dc.w $A3E0,$A3E0,$A3E0,$A3E0
		dc.w $A3E1,$A3E1,$A3E1,$A3E1
		dc.w $A3E0,$A3E0,$A3E0,$A3E0
		dc.w $A3E1,$A3E1,$A3E1,$A3E1
		dc.w $A3E0,$A3E0,$A3E0,$A3E0
		dc.w $A3E1,$A3E1,$A3E1,$A3E1
		dc.w $A3E0,$A3E0,$A3E0,$A3E0
		dc.w $A3E1,$A3E1,$A3E1,$A3E1
		dc.w $A3E0,$A3E0,$A3E0,$A3E0
		dc.w $A3E1,$A3E1,$A3E1,$A3E1
MapUnc_CompetitionResultsTOTAL:		dc.w $A3D8,$A3D9,$A3D8,$A3DA,$A3DB
		dc.w $A3DC,$A3DD,$A3DC,$A3DE,$A3DF


MapUnc_ResultsWin:		dc.w  $A3CD, $A3CE, $A3CF, $A3D0
MapUnc_ResultsLose:		dc.w  $A3D1, $A3D2, $A3D3, $ABD3
MapUnc_ResultsTie:		dc.w  $A3D4, $A3D5, $A3D6, $A3D7
Pal_CompetitionTimeAttack:		binclude "General/Competition Menu/Palettes/Time Attack.bin"
	even
MapUnc_CompetitionLAPNum:		dc.w $A3E2,$A3E3,$A3E4,$8000,$A3E8
		dc.w $A3E5,$A3E6,$A3E7,$8000,$A3ED
		dc.w $A3E2,$A3E3,$A3E4,$8000,$A3E9
		dc.w $A3E5,$A3E6,$A3E7,$8000,$A3EE
		dc.w $A3E2,$A3E3,$A3E4,$8000,$A3EA
		dc.w $A3E5,$A3E6,$A3E7,$8000,$A3EF
		dc.w $A3E2,$A3E3,$A3E4,$8000,$A3EB
		dc.w $A3E5,$A3E6,$A3E7,$8000,$A3F0
		dc.w $A3E2,$A3E3,$A3E4,$8000,$A3EC
		dc.w $A3E5,$A3E6,$A3E7,$8000,$A3F1
MapUnc_CompetitionRECORDS:		dc.w $E5A3,$E5A9,$E5A5,$E5B9,$E5A3,$E5A7,$E5BD
		dc.w $E5A2,$E5AA,$E5A6,$E5A6,$E5A2,$E5A8,$E5A6
MapUnc_Competition1st2nd3rd:		dc.w $E58F,$E5BD,$E5BE
		dc.w $E590,$E5A6,$E5AF
		dc.w $8000,$8000,$8000
		dc.w $E591,$E5B7,$E5A7
		dc.w $E592,$E5B8,$E5A8
		dc.w $8000,$8000,$8000
		dc.w $E593,$E5A3,$E5A7
		dc.w $E594,$E5A2,$E5A8
MapUnc_CompetitionAZURELAKE:		dc.w $8000,$E5A1,$E5C5,$E5BF,$E5A3,$E5A9,$8000,$E5B3,$E5A1,$E5B1,$E5A9,$8000,$8000
		dc.w $8000,$E5A2,$E5C6,$E5A6,$E5A2,$E5AA,$8000,$E5B4,$E5A2,$E5B2,$E5AA,$8000,$8000
MapUnc_CompetitionBALLOONPARK:		dc.w $E5A3,$E5A1,$E5B3,$E5B3,$E5B9,$E5B9,$E5B7,$8000,$E5BA,$E5A1,$E5A3,$E5B1,$8000
		dc.w $E5A4,$E5A2,$E5B4,$E5B4,$E5A6,$E5A6,$E5B8,$8000,$E5AB,$E5A2,$E5A2,$E5B2,$8000
MapUnc_CompetitionCHROMEGADGET:		dc.w $E5A5,$E5AD,$E5A3,$E5B9,$E5B5,$E5A9,$8000,$E5AC,$E5A1,$E5A7,$E5AC,$E5A9,$E5BE
		dc.w $E5A6,$E5A2,$E5A2,$E5A6,$E5B6,$E5AA,$8000,$E5A6,$E5A2,$E5A8,$E5A6,$E5AA,$E5AF
MapUnc_CompetitionDESERTPALACE:		dc.w $E5A7,$E5A9,$E5BD,$E5A9,$E5A3,$E5BE,$8000,$E5BA,$E5A1,$E5B3,$E5A1,$E5A5,$E5A9
		dc.w $E5A8,$E5AA,$E5A6,$E5AA,$E5A2,$E5AF,$8000,$E5AB,$E5A2,$E5B4,$E5A2,$E5A6,$E5AA
MapUnc_CompetitionENDLESSMINE:		dc.w $E5A9,$E5B7,$E5A7,$E5B3,$E5A9,$E5BD,$E5BD,$8000,$E5B5,$E5AE,$E5B7,$E5A9,$8000
		dc.w $E5AA,$E5B8,$E5A8,$E5B4,$E5AA,$E5A6,$E5A6,$8000,$E5B6,$E5AF,$E5B8,$E5AA,$8000
ArtKos_SaveScreenS3Zone:		binclude "General/Save Menu/Kosinski Art/Zone Art.bin"
	even
Map_AIZ1Tree:		include "Levels/AIZ/Misc Object Data/Map - Act 1 Tree.asm"
Map_AIZ1ZiplinePeg:		include "Levels/AIZ/Misc Object Data/Map - Act 1 Zipline Peg.asm"
Map_BreakableBar:		include "Levels/HCZ/Misc Object Data/Map - Breakable Bar.asm"

Map_HCZBlock:		include "Levels/HCZ/Misc Object Data/Map - Block.asm"

Map_AIZRock:		include "Levels/AIZ/Misc Object Data/Map - Rock.asm"

Map_AIZRock2:		include "Levels/AIZ/Misc Object Data/Map - Rock 2.asm"

Map_EMZRock:		include "Levels/EMZ/Misc Object Data/Map - Rock.asm"

Map_AIZCollapsingPlatform:		include "Levels/AIZ/Misc Object Data/Map - Collapsing Platform.asm"

Map_AIZCollapsingPlatform2:			include "Levels/AIZ/Misc Object Data/Map - Collapsing Platform 2.asm"

Map_LBZCollapsingBridge:		include "Levels/LBZ/Misc Object Data/Map - Collapsing Bridge.asm"

Map_LBZCollapsingLedge:		include "Levels/LBZ/Misc Object Data/Map - Collapsing Ledge.asm"

Map_HCZCollapsingBridge:		include "Levels/HCZ/Misc Object Data/Map - Collapsing Bridge.asm"

Map_MGZCollapsingBridge:		include "Levels/MGZ/Misc Object Data/Map - Collapsing Bridge.asm"

Map_ICZCollapsingBridge:		include "Levels/ICZ/Misc Object Data/Map - Collapsing Bridge.asm"

Map_AIZBreakableWall:		include "Levels/AIZ/Misc Object Data/Map - Breakable Wall.asm"

Map_MGZBreakableWall:		include "Levels/MGZ/Misc Object Data/Map - Breakable Wall.asm"

Map_HCZBreakableWall:		include "Levels/HCZ/Misc Object Data/Map - Breakable Wall.asm"

Map_LBZBreakableWall:		include "Levels/LBZ/Misc Object Data/Map - Breakable Wall.asm"

Map_AIZIntroWaves:		include "Levels/AIZ/Misc Object Data/Map - Intro Waves.asm"
Map_LBZUnusedElevator:		include "Levels/LBZ/Misc Object Data/Map - Unused Elevator.asm"
Map_LBZExplodingTrigger:		include "Levels/LBZ/Misc Object Data/Map - Exploding Trigger.asm"

Map_MGZDashTrigger:			include "Levels/MGZ/Misc Object Data/Map - Dash Trigger.asm"

Map_LBZTriggerBridge:		include "Levels/LBZ/Misc Object Data/Map - Trigger Bridge.asm"

Map_LBZPlayerLauncher:		include "Levels/LBZ/Misc Object Data/Map - Player Launcher.asm"

Map_LBZFlameThrower:		include "Levels/LBZ/Misc Object Data/Map - Flame Thrower.asm"
Map_LBZCupElevator:			include "Levels/LBZ/Misc Object Data/Map - Cup Elevator.asm"

Map_LBZUnusedUnknown:		include "Levels/LBZ/Misc Object Data/Map - Unused Unknown.asm"

Map_LBZPipePlug:		include "Levels/LBZ/Misc Object Data/Map - PipePlug.asm"

Map_LBZSpinLauncher:		include "Levels/LBZ/Misc Object Data/Map - Spin Launcher.asm"

Map_LBZLoweringGrapple:		include "Levels/LBZ/Misc Object Data/Map - Lowering Grapple.asm"

Map_LBZSmashingSpikes:		include "Levels/LBZ/Misc Object Data/Map - Smashing Spikes.asm"

Map_MGZSmashingPillar:		include "Levels/MGZ/Misc Object Data/Map - Smashing Pillar.asm"

Map_LBZGateLaser:		include "Levels/LBZ/Misc Object Data/Map - Gate Laser.asm"

Map_LBZTubeElevator:		include "Levels/LBZ/Misc Object Data/Map - Tube Elevator.asm"

Map_AIZDisappearingFloor:		include "Levels/AIZ/Misc Object Data/Map - Disappearing Floor.asm"

;Map_2294C0:		above
Map_AIZCorkFloor:		include "Levels/AIZ/Misc Object Data/Map - Cork Floor.asm"

Map_AIZCorkFloor2:		include "Levels/AIZ/Misc Object Data/Map - Cork Floor 2.asm"

Map_CNZCorkFloor:		include "Levels/CNZ/Misc Object Data/Map - Cork Floor.asm"

Map_ICZCorkFloor:		include "Levels/ICZ/Misc Object Data/Map - Cork Floor.asm"

Map_LBZCorkFloor:		include "Levels/LBZ/Misc Object Data/Map - Cork Floor.asm"

Map_AIZFlippingBridge:		include "Levels/AIZ/Misc Object Data/Map - Flipping Bridge.asm"

Map_AIZFallingLog2:			include "Levels/AIZ/Misc Object Data/Map - Falling Log 2.asm"

Map_AIZFallingLog:		include "Levels/AIZ/Misc Object Data/Map - Falling Log.asm"

Map_AIZFallingLogSplash2:		include "Levels/AIZ/Misc Object Data/Map - Falling Log Splash 2.asm"
Map_AIZFallingLogSplash:		include "Levels/AIZ/Misc Object Data/Map - Falling Log Splash.asm"
Map_AIZSpikedLog:		include "Levels/AIZ/Misc Object Data/Map - Spiked Log.asm"

Map_AIZForegroundPlant:		include "Levels/AIZ/Misc Object Data/Map - Foreground Plant.asm"

Map_Button2:		include "General/Sprites/Buttons/Map - Button 2.asm"

Map_CNZButton:		include "Levels/CNZ/Misc Object Data/Map - Button.asm"

Map_2PButton:		include "General/2P Zone/Map - 2P Button.asm"

Map_HCZWaterRush:		include "Levels/HCZ/Misc Object Data/Map - Water Rush.asm"
Map_HCZWaterRushBlock:		include "Levels/HCZ/Misc Object Data/Map - Water Rush Block.asm"

Map_HCZWaterWall:		include "Levels/HCZ/Misc Object Data/Map - Waterfall.asm"

Map_HCZWaterWallDebris:		include "Levels/HCZ/Misc Object Data/Map - Water Wall Debris.asm"

Map_HCZFan:		include "Levels/HCZ/Misc Object Data/Map - Fan.asm"

Map_HCZLargeFan:		include "Levels/HCZ/Misc Object Data/Map - Large Fan.asm"

Map_CGZFan:		include "Levels/CGZ/Misc Object Data/Map - Fan.asm"

Map_HCZHandLauncher:		include "Levels/HCZ/Misc Object Data/Map - Hand Launcher.asm"

Map_HCZConveyorSpike:		include "Levels/HCZ/Misc Object Data/Map - Conveyor Spike.asm"

Map_CNZBalloon:		include "Levels/CNZ/Misc Object Data/Map - Balloon.asm"

Map_CNZCannon:		include "General/Sprites/CNZ Cannon/Map - CNZ Cannon.asm"

Map_CNZRisingPlatform:		include "Levels/CNZ/Misc Object Data/Map - Rising Platform.asm"

Map_CNZTrapDoor:		include "Levels/CNZ/Misc Object Data/Map - Trap Door.asm"

Map_CNZLightBulb:		include "Levels/CNZ/Misc Object Data/Map - Light Bulb.asm"

Map_CNZHoverFan:		include "Levels/CNZ/Misc Object Data/Map - Hover Fan.asm"

Map_CNZCylinder:		include "Levels/CNZ/Misc Object Data/Map - Cylinder.asm"

Map_HCZSpinningColumn:		include "Levels/HCZ/Misc Object Data/Map - Spinning Column.asm"

Map_Bumper:		include "General/Sprites/Level Misc/Map - Bumper.asm"

Map_2PBumper:		include "General/2P Zone/Map - 2P Bumper.asm"

Map_MGZSwingingPlatform:		include "Levels/MGZ/Misc Object Data/Map - Swinging Platform.asm"

Map_MGZSwingingSpikeBall:		include "Levels/MGZ/Misc Object Data/Map - Swinging Spike Ball.asm"

Map_MGZHeadTrigger:			include "Levels/MGZ/Misc Object Data/Map - Head Trigger.asm"

Map_MGZTriggerPlatform:		include "Levels/MGZ/Misc Object Data/Map - Trigger Platform.asm"

Map_MGZMovingSpikePlatform:			include "Levels/MGZ/Misc Object Data/Map - Moving Spike Platform.asm"

Map_MGZPulley:		include "Levels/MGZ/Misc Object Data/Map - Pulley.asm"

Map_HCZWaterDrop:		include "Levels/HCZ/Misc Object Data/Map - Water Drop.asm"

Map_HCZWaterSplash:			include "Levels/HCZ/Misc Object Data/Map - Water Splash.asm"

Map_HCZWaterSplash2:		include "Levels/HCZ/Misc Object Data/Map - Water Splash 2.asm"

	include "Lockon S3/Screen Events.asm"

Map_S3EndingGraphics:		include "General/Ending/Map - S3 Ending Graphics.asm"
ArtNem_S3EndingGraphics:		binclude "General/Title/Nemesis Art/S3 Ending Graphics.bin"
	even
SStageLayoutPtrs:
		dc.l SStage1_Layout
		dc.l SStage2_Layout
		dc.l SStage3_Layout
		dc.l SStage4_Layout
		dc.l SStage5_Layout
		dc.l SStage6_Layout
		dc.l SStage7_Layout
		dc.l SStage8_Layout
SStage1_Layout:		binclude "General/Special Stage/Layout/S3 1.bin"
	even
SStage2_Layout:		binclude "General/Special Stage/Layout/S3 2.bin"
	even
SStage3_Layout:		binclude "General/Special Stage/Layout/S3 3.bin"
	even
SStage4_Layout:		binclude "General/Special Stage/Layout/S3 4.bin"
	even
SStage5_Layout:		binclude "General/Special Stage/Layout/S3 5.bin"
	even
SStage6_Layout:		binclude "General/Special Stage/Layout/S3 6.bin"
	even
SStage7_Layout:		binclude "General/Special Stage/Layout/S3 7.bin"
	even
SStage8_Layout:		binclude "General/Special Stage/Layout/S3 8.bin"
	even

HCZ_WaterlineScroll_Data:		binclude "Levels/HCZ/Misc/HCZ Waterline Scroll Data.bin"
	even
LBZ_WaterlineScroll_Data:		binclude "Levels/LBZ/Misc/LBZ Waterline Scroll Data.bin"
	even

Solid_AIZ1:		binclude "Levels/AIZ/Collision/1.bin"
	even
Solid_AIZ2:		binclude "Levels/AIZ/Collision/2.bin"
	even
Solid_HCZ1:		binclude "Levels/HCZ/Collision/1.bin"
	even
Solid_HCZ2:		binclude "Levels/HCZ/Collision/2.bin"
	even
Solid_MGZ1:		binclude "Levels/MGZ/Collision/1.bin"
	even
Solid_MGZ2:		binclude "Levels/MGZ/Collision/2.bin"
	even
Solid_CNZ:		binclude "Levels/CNZ/Collision/1.bin"
	even
Solid_ICZ1:		binclude "Levels/ICZ/Collision/1.bin"
	even
Solid_ICZ2:		binclude "Levels/ICZ/Collision/2.bin"
	even
Solid_LBZ1:		binclude "Levels/LBZ/Collision/1.bin"
	even
Solid_LBZ2:		binclude "Levels/LBZ/Collision/2.bin"
	even
Solid_ALZ:		binclude "Levels/ALZ/Collision/1.bin"
	even
Solid_BPZ:		binclude "Levels/BPZ/Collision/1.bin"
	even
Solid_DPZ:		binclude "Levels/DPZ/Collision/1.bin"
	even
Solid_CGZ:		binclude "Levels/CGZ/Collision/1.bin"
	even
Solid_EMZ:		binclude "Levels/EMZ/Collision/1.bin"
	even
Solid_Gumball_Special:		binclude "Levels/Gumball/Collision/1.bin"
	even
Layout_AIZ1:		binclude "Levels/AIZ/Layout/1.bin"
	even
Layout_AIZ2:		binclude "Levels/AIZ/Layout/2.bin"
	even
Layout_HCZ1:		binclude "Levels/HCZ/Layout/1.bin"
	even
Layout_HCZ2:		binclude "Levels/HCZ/Layout/2.bin"
	even
Layout_MGZ1:		binclude "Levels/MGZ/Layout/1.bin"
	even
Layout_MGZ2:		binclude "Levels/MGZ/Layout/2.bin"
	even
Layout_CNZ1:		binclude "Levels/CNZ/Layout/1.bin"
	even
Layout_CNZ2:		binclude "Levels/CNZ/Layout/2.bin"
	even
Layout_ICZ1:		binclude "Levels/ICZ/Layout/1.bin"
	even
Layout_ICZ2:		binclude "Levels/ICZ/Layout/2.bin"
	even
Layout_LBZ1:		binclude "Levels/LBZ/Layout/1.bin"
	even
Layout_LBZ2:		binclude "Levels/LBZ/Layout/2.bin"
	even
Layout_ALZ:		binclude "Levels/ALZ/Layout/1.bin"
	even
Layout_BPZ:		binclude "Levels/BPZ/Layout/1.bin"
	even
Layout_DPZ:		binclude "Levels/DPZ/Layout/1.bin"
	even
Layout_CGZ:		binclude "Levels/CGZ/Layout/1.bin"
	even
Layout_EMZ:		binclude "Levels/EMZ/Layout/1.bin"
	even
Layout_Gumball_Special:		binclude "Levels/Gumball/Layout/1.bin"
	even
ArtUnc_CNZCannon:		binclude "General/Sprites/CNZ Cannon/CNZ Cannon.bin"
	even
ArtUnc_SStageTails:		binclude "General/Sprites/Tails/Art/SStage Tails.bin"
	even
Map_SStageTails:		include "General/Sprites/Tails/Map - SStage Tails.asm"

ArtUnc_SStageTailstails:		binclude "General/Sprites/Tails/Art/SStage Tails tails.bin"
	even
Map_SStageTailstails:		include "General/Sprites/Tails/Map - SStage Tails tails.asm"

Map_Sonic2P:		include "General/Sprites/Sonic/Map - Sonic 2P.asm"

PLC_Sonic2P:		include "General/Sprites/Sonic/DPLC - Sonic 2P.asm"
Map_Tails_2P:		include "General/Sprites/Tails/Map - Tails 2P.asm"

Map_Tails2P_Tail:		include "General/Sprites/Tails/Map - Tails tail 2P.asm"

PLC_Tails2P:		include "General/Sprites/Tails/DPLC - Tails 2P.asm"

DPLC_Tails2P_Tail:		include "General/Sprites/Tails/DPLC - Tails tails 2P.asm"

Map_Knuckles2P:		include "General/Sprites/Knuckles/Map - Knuckles 2P.asm"

PLC_Knuckles2P:		include "General/Sprites/Knuckles/DPLC - Knuckles 2P.asm"
	align $20
ArtUnc_AniAIZ1_0:		binclude "Levels/AIZ/Animated Tiles/Act1 0.bin"
	even

ArtUnc_AniAIZ1_1:		binclude "Levels/AIZ/Animated Tiles/Act1 1.bin"
	even
ArtUnc_AniAIZ2_1:		binclude "Levels/AIZ/Animated Tiles/Act2 1.bin"
	even

ArtUnc_AniAIZ2_0:		binclude "Levels/AIZ/Animated Tiles/Act2 0.bin"
	even
ArtUnc_AniAIZ2_3:		binclude "Levels/AIZ/Animated Tiles/Act2 3.bin"
	even
ArtUnc_AniAIZ2_2:		binclude "Levels/AIZ/Animated Tiles/Act2 2.bin"
	even
ArtUnc_AniAIZ2_FirstTree:		binclude "Levels/AIZ/Animated Tiles/Act2 First Tree.bin"
	even
ArtUnc_AniHCZ1_0:		binclude "Levels/HCZ/Animated Tiles/Act1 0.bin"
	even
ArtUnc_AniHCZ1_WaterlineBelow:		binclude "Levels/HCZ/Animated Tiles/Act1 Water Below 1.bin"
	even

ArtUnc_FixHCZ1_UpperBG1:		binclude "Levels/HCZ/Animated Tiles/Act1 Upper BG 1.bin"
	even
ArtUnc_AniHCZ1_WaterlineAbove:		binclude "Levels/HCZ/Animated Tiles/Act1 Water Above 1.bin"
	even

ArtUnc_FixHCZ1_LowerBG1:		binclude "Levels/HCZ/Animated Tiles/Act1 Lower BG 1.bin"
	even
ArtUnc_AniHCZ1_WaterlineBelow2:		binclude "Levels/HCZ/Animated Tiles/Act1 Water Below 2.bin"
	even
ArtUnc_FixHCZ1_UpperBG2:		binclude "Levels/HCZ/Animated Tiles/Act1 Upper BG 2.bin"
	even
ArtUnc_AniHCZ1_WaterlineAbove2:		binclude "Levels/HCZ/Animated Tiles/Act1 Water Above 2.bin"
	even
ArtUnc_FixHCZ1_LowerBG2:		binclude "Levels/HCZ/Animated Tiles/Act1 Lower BG 2.bin"
	even
ArtUnc_AniHCZ__1:		binclude "Levels/HCZ/Animated Tiles/0.bin"
	even

ArtUnc_AniHCZ2_0:		binclude "Levels/HCZ/Animated Tiles/Act2 0.bin"
	even
ArtUnc_AniHCZ2_SmallBGLine:		binclude "Levels/HCZ/Animated Tiles/Act2 1.bin"
	even
ArtUnc_AniHCZ2_2:		binclude "Levels/HCZ/Animated Tiles/Act2 2.bin"
	even
ArtUnc_AniHCZ2_3:		binclude "Levels/HCZ/Animated Tiles/Act2 3.bin"
	even
ArtUnc_AniHCZ2_4:		binclude "Levels/HCZ/Animated Tiles/Act2 4.bin"
	even
ArtUnc_AniMGZ__0:		binclude "Levels/MGZ/Animated Tiles/MGZ Animated 0.bin"
	even
ArtUnc_AniMGZ__1:		binclude "Levels/MGZ/Animated Tiles/MGZ Animated 1.bin"
	even
ArtUnc_AniCNZ__0:		binclude "Levels/CNZ/Animated Tiles/0.bin"
	even

ArtUnc_AniCNZ__1:		binclude "Levels/CNZ/Animated Tiles/1.bin"
	even
ArtUnc_AniCNZ__2:		binclude "Levels/CNZ/Animated Tiles/2.bin"
	even
ArtUnc_AniCNZ__3:		binclude "Levels/CNZ/Animated Tiles/3.bin"
	even
ArtUnc_AniCNZ__4:		binclude "Levels/CNZ/Animated Tiles/4.bin"
	even
ArtUnc_AniCNZ__6:		binclude "Levels/CNZ/Animated Tiles/6.bin"
	even
ArtUnc_AniCNZ__5:		binclude "Levels/CNZ/Animated Tiles/5.bin"
	even

ArtUnc_AniICZ__1:		binclude "Levels/ICZ/Animated Tiles/1.bin"
	even
ArtUnc_AniICZ__2:		binclude "Levels/ICZ/Animated Tiles/2.bin"
	even
ArtUnc_AniICZ__3:		binclude "Levels/ICZ/Animated Tiles/3.bin"
	even
ArtUnc_AniICZ__4:		binclude "Levels/ICZ/Animated Tiles/4.bin"
	even
ArtUnc_AniICZ__5:		binclude "Levels/ICZ/Animated Tiles/5.bin"
	even
ArtUnc_AniICZ__0:		binclude "Levels/ICZ/Animated Tiles/0.bin"
	even
ArtUnc_AniLBZ1_0:		binclude "Levels/LBZ/Animated Tiles/Act1 0.bin"
	even
ArtUnc_AniLBZ1_1:		binclude "Levels/LBZ/Animated Tiles/Act1 1.bin"
	even
ArtUnc_AniLBZ1_2:		binclude "Levels/LBZ/Animated Tiles/Act1 2.bin"
	even
ArtUnc_AniLBZ2_2:		binclude "Levels/LBZ/Animated Tiles/Act2 2.bin"
	even
ArtUnc_AniLBZ2_WaterlineBelow:		binclude "Levels/LBZ/Animated Tiles/Act2 Water Below.bin"
	even

ArtUnc_AniLBZ2_LowerBG:		binclude "Levels/LBZ/Animated Tiles/Act2 Lower BG.bin"
	even
ArtUnc_AniLBZ2_WaterlineAbove:		binclude "Levels/LBZ/Animated Tiles/Act2 Water Above.bin"
	even
ArtUnc_AniLBZ2_UpperBG:		binclude "Levels/LBZ/Animated Tiles/Act2 Upper BG.bin"
	even
ArtUnc_AniLBZ__0:		binclude "Levels/LBZ/Animated Tiles/0.bin"
	even

ArtUnc_AniLBZ2_0:		binclude "Levels/LBZ/Animated Tiles/Act2 0.bin"
	even

ArtUnc_AniLBZ2_1:		binclude "Levels/LBZ/Animated Tiles/Act2 1.bin"
	even

ArtUnc_AniALZ:		binclude "Levels/ALZ/Animated Tiles/0.bin"
	even
ArtUnc_AniBPZ__0:		binclude "Levels/BPZ/Animated Tiles/0.bin"
	even
ArtUnc_AniBPZ__1:		binclude "Levels/BPZ/Animated Tiles/1.bin"
	even
ArtUnc_AniBPZ__2:		binclude "Levels/BPZ/Animated Tiles/2.bin"
	even
ArtUnc_AniBPZ__3:		binclude "Levels/BPZ/Animated Tiles/3.bin"
	even
ArtUnc_AniDPZ:		binclude "Levels/DPZ/Animated Tiles/0.bin"
	even
ArtUnc_AniDPZ__BG:		binclude "Levels/DPZ/Animated Tiles/BG 0.bin"
	even

ArtUnc_AniGumball:		binclude "Levels/Gumball/Animated Tiles/0.bin"
	even
ArtUnc_SplashDrown:				binclude "General/Sprites/Splash Drown/Splash Drown.bin"
	even

ArtNem_Title_SonicSprites:		binclude "General/Title/Nemesis Art/S3 Sonic Sprites.bin"
	even
DemoDat_AIZ:		binclude "Levels/AIZ/Demodata/1.bin"
	even
DemoDat_HCZ:		binclude "Levels/HCZ/Demodata/1.bin"
	even
DemoDat_MGZ:		binclude "Levels/MGZ/Demodata/1.bin"
	even
ArtUnc_Tails:		binclude "General/Sprites/Tails/Art/Tails.bin"
	even
ArtUnc_Tails_Tail:		binclude "General/Sprites/Tails/Art/Tails tails.bin"
	even
ArtUnc_Sonic2P:		binclude "General/Sprites/Sonic/Art/Sonic 2P.bin"
	even
ArtUnc_Tails2P:		binclude "General/Sprites/Tails/Art/Tails 2P.bin"
	even
ArtUnc_Tails2P_Tail:		binclude "General/Sprites/Tails/Art/Tails tails 2P.bin"
	even
ArtUnc_Knuckles2P:		binclude "General/Sprites/Knuckles/Art/Knuckles 2P.bin"
	even
Map_Tails_Tail:		include "General/Sprites/Tails/Map - Tails tails.asm"
PLC_Tails_Tail:		include "General/Sprites/Tails/Tails tails pattern load cues.asm"
ICZSnowboard_Slope1:		binclude "Levels/ICZ/Misc/ICZ Snowboard Slope 1.bin"
	even
ICZSnowboard_Slope2:		binclude "Levels/ICZ/Misc/ICZ Snowboard Slope 2.bin"
	even
ArtUnc_SonicSnowboard:		binclude "General/Sprites/Sonic/Art/Sonic Snowboarding.bin"
	even
ArtUnc_Snowboard:		binclude "General/Sprites/Snowboard/Snowboard.bin"
	even
Map_SonicSnowboard:		include "General/Sprites/Sonic/Map - Sonic Snowboarding.asm"
DPLC_SonicSnowboard:		include "General/Sprites/Sonic/DPLC - Sonic Snowboarding.asm"
Map_Snowboard:		include "General/Sprites/Snowboard/Map - Snowboard.asm"
DPLC_Snowboard:		include "General/Sprites/Snowboard/DPLC - Snowboard.asm"
ArtNem_AIZIntroSprites:		binclude "Levels/AIZ/Nemesis Art/Intro Waves.bin"
	even
ArtNem_2PDashdust:		binclude "General/2P Zone/Nemesis Art/Spindash Dust.bin"
	even

MapEni_S3TitleSonic1:					binclude "General/Title/Enigma Map/S3 Sonic 1.bin"
	even
MapEni_S3TitleSonic2:					binclude "General/Title/Enigma Map/S3 Sonic 2.bin"
	even
MapEni_S3TitleSonic3:					binclude "General/Title/Enigma Map/S3 Sonic 3.bin"
	even
MapEni_S3TitleSonic4:					binclude "General/Title/Enigma Map/S3 Sonic 4.bin"
	even
MapEni_S3TitleSonic5:					binclude "General/Title/Enigma Map/S3 Sonic 5.bin"
	even
MapEni_S3TitleSonic6:					binclude "General/Title/Enigma Map/S3 Sonic 6.bin"
	even
MapEni_S3TitleSonic7:					binclude "General/Title/Enigma Map/S3 Sonic 7.bin"
	even
MapEni_S3TitleSonic8:					binclude "General/Title/Enigma Map/S3 Sonic 8.bin"
	even
MapEni_S3TitleSonic9:					binclude "General/Title/Enigma Map/S3 Sonic 9.bin"
	even
MapEni_S3TitleSonicA:					binclude "General/Title/Enigma Map/S3 Sonic A.bin"
	even
MapEni_S3TitleSonicB:					binclude "General/Title/Enigma Map/S3 Sonic B.bin"
	even
MapEni_S3TitleSonicC:					binclude "General/Title/Enigma Map/S3 Sonic C.bin"
	even
MapEni_S3TitleSonicD:					binclude "General/Title/Enigma Map/S3 Sonic D.bin"
	even

MapEni_S3TitleBg:		binclude "General/Title/Enigma Map/S3 BG.bin"
	even
Map_S3TitleBanner:		include "General/Title/Map - S3 Banner.asm"

ArtNem_Title_S3Banner:		binclude "General/Title/Nemesis Art/S3 Banner.bin"
	even
ArtKos_S3TitleSonic1:			binclude "General/Title/Kosinski Art/S3 Sonic 1.bin"
	even

ArtKos_S3TitleSonic8:			binclude "General/Title/Kosinski Art/S3 Sonic 8.bin"
	even

ArtKos_S3TitleSonic9:			binclude "General/Title/Kosinski Art/S3 Sonic 9.bin"
	even
ArtKos_S3TitleSonicA:			binclude "General/Title/Kosinski Art/S3 Sonic A.bin"
	even
ArtKos_S3TitleSonicB:			binclude "General/Title/Kosinski Art/S3 Sonic B.bin"
	even
ArtKos_S3TitleSonicC:			binclude "General/Title/Kosinski Art/S3 Sonic C.bin"
	even
ArtKos_S3TitleSonicD:			binclude "General/Title/Kosinski Art/S3 Sonic D.bin"
	even

ArtNem_TailsLifeIcon:		binclude "General/Sprites/HUD Icon/Tails Life Icon.bin"
	even
Map_LBZMiniboss:		include "Levels/LBZ/Misc Object Data/Map - Miniboss.asm"
Map_LBZMinibossBox:		include "Levels/LBZ/Misc Object Data/Map - Miniboss Box.asm"
Map_SnaleBlaster:		include "General/Sprites/Snail Blaster/Map - Snail Blaster.asm"

Map_Orbinaut:		include "General/Sprites/Orbinaut/Map - Orbinaut.asm"

Map_Ribot:		include "General/Sprites/Ribot/Map - Ribot.asm"

Map_Corkey:		include "General/Sprites/Corkey/Map - Corkey.asm"

Map_Flybot767:		include "General/Sprites/Flybot/Map - Flybot.asm"

DPLC_Flybot:		include "General/Sprites/Flybot/DPLC - Flybot.asm"
Map_LBZEndBoss:		include "Levels/LBZ/Misc Object Data/Map - End Boss.asm"

Map_CNZEndBoss:		include "Levels/CNZ/Misc Object Data/Map - End Boss.asm"

CNZEndBossMagnet_AngleX:		dc.b   0,  1,  2,  3,  4,  5,  6,  8,  9, $A, $B, $C, $D, $E, $F,$10
		dc.b $11,$12,$13,$14,$15,$16,$17,$18,$18,$19,$1A,$1B,$1C,$1D,$1E,$1E
		dc.b $1F,$20,$21,$21,$22,$23,$23,$24,$25,$25,$26,$26,$27,$27,$28,$28
		dc.b $29,$29,$29,$2A,$2A,$2A,$2B,$2B,$2B,$2B,$2C,$2C,$2C,$2C,$2C,$2C
LBZFinalBoss2_CircleLookup:		dc.b   0,  1,  2,  3,  4,  5,  6,  7,  8,  9, $A, $B, $C, $D, $D, $E
		dc.b  $F,$10,$11,$12,$13,$14,$15,$15,$16,$17,$18,$19,$19,$1A,$1B,$1C
		dc.b $1C,$1D,$1E,$1E,$1F,$20,$20,$21,$21,$22,$22,$23,$23,$24,$24,$25
		dc.b $25,$25,$26,$26,$26,$27,$27,$27,$27,$27,$28,$28,$28,$28,$28,$28


Map_Blastoid:		include "General/Sprites/Blastoid/Map - Blastoid.asm"

Map_Poindexter:		include "General/Sprites/Pointdexter/Map - Pointdexter.asm"

Map_Buggernaut:		include "General/Sprites/Buggernaut/Map - Buggernaut.asm"

Map_MegaChomper:		include "General/Sprites/Mega Chomper/Map - Mega Chomper.asm"

Map_TurboSpiker:		include "General/Sprites/Turbo Spiker/Map - Turbo Spiker.asm"

Map_Jawz:		include "General/Sprites/Jawz/Map - Jawz.asm"

DPLC_RhinoBot:		include "General/Sprites/Rhino/DPLC - RhinoBot.asm"
Map_RhinoBot:		include "General/Sprites/Rhino/Map - RhinoBot.asm"

Map_AIZMinibossFlame:		include "Levels/AIZ/Misc Object Data/Map - Miniboss Flame.asm"
Map_Tulipon:		include "General/Sprites/Tulipon/Map - Tulipon.asm"

Map_MonkeyDude:		include "General/Sprites/Monkey Dude/Map - Monkey Dude.asm"

Map_MGZMiniBoss:		include "Levels/MGZ/Misc Object Data/Map - Miniboss.asm"

Map_CaterKillerJr:		include "General/Sprites/Caterkiller Jr/Map - Caterkiller Jr.asm"

DPLC_Clamer:		include "General/Sprites/Clamer/DPLC - Clamer.asm"
Map_Clamer:		include "General/Sprites/Clamer/Map - Clamer.asm"

Map_CNZBlastoid:		include "Levels/CNZ/Misc Object Data/Map - Blastoid.asm"

Map_Batbot:		include "General/Sprites/Batbot/Map - Batbot.asm"

DPLC_BubblesBadnik:		include "General/Sprites/Bubbles Badnik/DPLC - Bubbles Badnik.asm"
Map_BubblesBadnik:		include "General/Sprites/Bubbles Badnik/Map - Bubbles Badnik.asm"

Map_Spiker:		include "General/Sprites/Spiker/Map - Spiker.asm"

Map_Mantis:		include "General/Sprites/Mantis/Map - Mantis.asm"

DPLC_Penguinator:		include "General/Sprites/Penguinator/DPLC - Penguinator.asm"
Map_Penguinator:		include "General/Sprites/Penguinator/Map - Penguinator.asm"

Map_ICZSnowdust:		include "Levels/ICZ/Misc Object Data/Map - Snowdust.asm"
Map_StarPointer:		include "General/Sprites/Star Pointer/Map - Star Pointer.asm"

Map_AIZEndBoss:		include "Levels/AIZ/Misc Object Data/Map - End Boss.asm"

Map_AIZMiniboss:		include "Levels/AIZ/Misc Object Data/Map - Miniboss.asm"
Map_AIZMinibossSmall:		include "Levels/AIZ/Misc Object Data/Map - Miniboss Small.asm"
Map_MGZEndBoss:		include "Levels/MGZ/Misc Object Data/Map - End Boss.asm"
HCZMiniboss_RocketTwistLookup:		dc.b $18,$18,$18,$18,$18,$18,$18,$18,$18,$17,$17,$17,$17,$17,$17,$16
		dc.b $16,$16,$16,$15,$15,$15,$15,$14,$14,$14,$13,$13,$13,$12,$12,$11
		dc.b $11,$11,$10,$10, $F, $F, $E, $E, $D, $D, $C, $C, $B, $B, $A, $A
		dc.b   9,  9,  8,  8,  7,  6,  6,  5,  5,  4,  4,  3,  2,  2,  1,  1
		dc.b   0,$FF,$FF,$FE,$FE,$FD,$FC,$FC,$FB,$FB,$FA,$FA,$F9,$F8,$F8,$F7
		dc.b $F7,$F6,$F6,$F5,$F5,$F4,$F4,$F3,$F3,$F2,$F2,$F1,$F1,$F0,$F0,$EF
		dc.b $EF,$EF,$EE,$EE,$ED,$ED,$ED,$EC,$EC,$EC,$EB,$EB,$EB,$EB,$EA,$EA
		dc.b $EA,$EA,$E9,$E9,$E9,$E9,$E9,$E9,$E8,$E8,$E8,$E8,$E8,$E8,$E8,$E8
		dc.b   0,  2,  4,  5,  7,  9, $B, $C, $E,$10,$11,$13,$15,$17,$18,$1A
		dc.b $1C,$1D,$1F,$20,$22,$23,$25,$27,$28,$29,$2B,$2C,$2E,$2F,$30,$32
		dc.b $33,$34,$35,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F,$3F,$40,$41,$42
		dc.b $43,$43,$44,$44,$45,$45,$46,$46,$47,$47,$47,$47,$48,$48,$48,$48
		dc.b   0,  1,  2,  2,  3,  4,  5,  5,  6,  7,  8,  9,  9, $A, $B, $C
		dc.b  $C, $D, $E, $E, $F,$10,$10,$11,$12,$12,$13,$14,$14,$15,$15,$16
		dc.b $17,$17,$18,$18,$19,$19,$1A,$1A,$1B,$1B,$1B,$1C,$1C,$1D,$1D,$1D
		dc.b $1E,$1E,$1E,$1E,$1F,$1F,$1F,$1F,$1F,$20,$20,$20,$20,$20,$20,$20

LBZ2FinalBoss2_CircleLookup2:		dc.b   0,  0,  1,  1,  2,  2,  3,  3,  4,  4,  5,  5,  6,  6,  7,  7
		dc.b   8,  8,  9,  9,  9, $A, $A, $B, $B, $C, $C, $C, $D, $D, $D, $E
		dc.b  $E, $E, $F, $F, $F,$10,$10,$10,$11,$11,$11,$11,$12,$12,$12,$12
		dc.b $12,$13,$13,$13,$13,$13,$13,$14,$14,$14,$14,$14,$14,$14,$14,$14
Map_HCZMiniboss:		include "Levels/HCZ/Misc Object Data/Map - Miniboss.asm"

Map_HCZMinibossSplash:		include "Levels/HCZ/Misc Object Data/Map - Miniboss Splash.asm"
DPLC_HCZMinibossSplash:		include "Levels/HCZ/Misc Object Data/DPLC - Miniboss Splash.asm"
Map_ICZEndBoss:		include "Levels/ICZ/Misc Object Data/Map - End Boss.asm"

Map_CNZMiniboss:		include "Levels/CNZ/Misc Object Data/Map - Miniboss.asm"

ICZMiniboss_OrbAngleLookup:		dc.b   0,  1,  2,  4,  5,  6,  7,  8,  9, $B, $C, $D, $E, $F,$10,$11
		dc.b $12,$13,$15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1E,$1F,$20,$21
		dc.b $22,$23,$24,$24,$25,$26,$27,$27,$28,$29,$29,$2A,$2A,$2B,$2B,$2C
		dc.b $2C,$2D,$2D,$2E,$2E,$2E,$2F,$2F,$2F,$2F,$2F,$30,$30,$30,$30,$30


Map_ICZMiniboss:		include "Levels/ICZ/Misc Object Data/Map - Miniboss.asm"

Map_HCZEndBoss:		include "Levels/HCZ/Misc Object Data/Map - End Boss.asm"

Map_MGZEndBossDebris:		include "Levels/MGZ/Misc Object Data/Map - End Boss Debris.asm"

Map_ICZWallAndColumn:		include "Levels/ICZ/Misc Object Data/Map - Wall and Column.asm"

Map_ICZPlatforms:		include "Levels/ICZ/Misc Object Data/Map - Platforms.asm"

Map_LBZKnuxBomb:		include "Levels/LBZ/Misc Object Data/Map - Knuckles Bomb.asm"
Map_CutsceneKnux:		include "General/Sprites/Knuckles/Cutscene/Map - Cutscene Knuckles.asm"
DPLC_CutsceneKnux:		include "General/Sprites/Knuckles/Cutscene/DPLC - Cutscene Knuckles.asm"
Map_AIZIntroPlane:		include "Levels/AIZ/Misc Object Data/Map - Intro Plane.asm"

Map_AIZIntroEmeralds:		include "Levels/AIZ/Misc Object Data/Map - Intro Emeralds.asm"
Map_LBZFinalBoss1:		include "Levels/LBZ/Misc Object Data/Map - Final Boss 1.asm"

Map_LBZDeathEggSmall:		include "Levels/LBZ/Misc Object Data/Map - Death Egg Small.asm"

Pal_MGZFadeCNZ:		binclude "Levels/Misc/Palettes/MGZ Fade to CNZ.bin"
	even
Map_LBZFinalBoss2:		include "Levels/LBZ/Misc Object Data/Map - Final Boss 2.asm"

ArtNem_AIZMiniboss:		binclude "Levels/AIZ/Nemesis Art/Miniboss.bin"
	even
ArtKosM_AIZEndBoss:		binclude "Levels/AIZ/KosinskiM Art/End Boss.bin"
	even
ArtNem_AIZMinibossSmall:		binclude "Levels/AIZ/Nemesis Art/Miniboss Small.bin"
	even
ArtUnc_AIZRhino:		binclude "General/Sprites/Rhino/Rhino.bin"
	even
ArtKosM_AIZ_Tulipon:		binclude "General/Sprites/Tulipon/Tulipon.bin"
	even
ArtKosM_AIZ_MonkeyDude:		binclude "General/Sprites/Monkey Dude/Monkey Dude.bin"
	even
ArtKosM_AIZ_CaterkillerJr:		binclude "General/Sprites/Caterkiller Jr/Caterkiller Jr.bin"
	even
ArtNem_HCZMiniboss:		binclude "Levels/HCZ/Nemesis Art/Miniboss.bin"
	even
ArtNem_HCZEndBoss:		binclude "Levels/HCZ/Nemesis Art/End Boss.bin"
	even
ArtNem_HCZDragonfly:		binclude "Levels/HCZ/Nemesis Art/Dragonfly.bin"
	even

ArtKosM_Jawz:		binclude "General/Sprites/Jawz/Jawz.bin"
	even
ArtKosM_MegaChopper:			binclude "General/Sprites/Mega Chopper/Mega Chopper.bin"
	even

ArtKosM_Blastoid:		binclude "General/Sprites/Blastoid/Blastoid.bin"
	even
ArtKosM_TurboSpiker:			binclude "General/Sprites/Turbo Spiker/Turbo Spiker.bin"
	even

ArtKosM_Pointdexter:		binclude "General/Sprites/Pointdexter/Pointdexter.bin"
	even

ArtKosM_MGZMiniboss:		binclude "Levels/MGZ/KosinskiM Art/Miniboss.bin"
	even
ArtNem_MGZSpire:		binclude "Levels/MGZ/Nemesis Art/Spire.bin"
	even
ArtKosM_MGZEndBoss:		binclude "Levels/MGZ/KosinskiM Art/End Boss.bin"
	even

ArtScaled_MGZEndBoss:		binclude "Levels/MGZ/Misc/MGZ End Boss Scaled.bin"
	even
ArtKosM_MGZEndBossDebris:		binclude "Levels/MGZ/KosinskiM Art/End Boss Debris.bin"
	even

ArtUnc_BubblesBadnik:		binclude "General/Sprites/Bubbles Badnik/Bubbles Badnik.bin"
	even
ArtKosM_Spiker:			binclude "General/Sprites/Spiker/Spiker.bin"
	even

ArtKosM_Mantis:		binclude "General/Sprites/Mantis/Mantis.bin"
	even

ArtNem_CNZMiniboss:		binclude "Levels/CNZ/Nemesis Art/Miniboss.bin"
	even
ArtNem_CNZEndBoss:		binclude "Levels/CNZ/Nemesis Art/End Boss.bin"
	even
ArtUnc_Clamer:		binclude "General/Sprites/Clamer/Clamer.bin"
	even
ArtKosM_ClamerShot:			binclude "General/Sprites/Clamer/Clamer Shot.bin"
	even
ArtKosM_Sparkle:			binclude "General/Sprites/Sparkle/Sparkle.bin"
	even
ArtKosM_Batbot:			binclude "General/Sprites/Batbot/Batbot.bin"
	even
ArtKosM_CNZBalloon:			binclude "Levels/CNZ/KosinskiM Art/Balloon.bin"
	even
ArtNem_ICZMisc1:		binclude "Levels/ICZ/Nemesis Art/Misc Art 1.bin"
	even

ArtNem_ICZIntroSprites:		binclude "Levels/ICZ/Nemesis Art/Intro Sprites.bin"
	even
ArtNem_ICZMisc2:		binclude "Levels/ICZ/Nemesis Art/Misc Art 2.bin"
	even
ArtNem_ICZEndBoss:		binclude "Levels/ICZ/Nemesis Art/End Boss.bin"
	even
ArtNem_ICZMiniboss:		binclude "Levels/ICZ/Nemesis Art/Miniboss.bin"
	even
ArtUnc_Penguinator:		binclude "General/Sprites/Penguinator/Penguinator.bin"
	even
ArtKosM_ICZSnowdust:			binclude "Levels/ICZ/KosinskiM Art/Snowdust.bin"
	even
ArtKosM_StarPointer:			binclude "General/Sprites/Star Pointer/Star Pointer.bin"
	even
ArtKosM_LBZMiniboss:		binclude "Levels/LBZ/KosinskiM Art/Miniboss.bin"
	even
ArtKosM_LBZMinibossBox:		binclude "Levels/LBZ/KosinskiM Art/Miniboss Box.bin"
	even

ArtNem_LBZFinalBoss1:		binclude "Levels/LBZ/Nemesis Art/Final Boss 1.bin"
	even
ArtKosM_LBZEndBoss:		binclude "Levels/LBZ/KosinskiM Art/End Boss.bin"
	even
ArtKosM_LBZFinalBoss2:		binclude "Levels/LBZ/KosinskiM Art/Final Boss 2.bin"
	even
ArtKosM_SnailBlaster:				binclude "General/Sprites/Snail Blaster/Snail Blaster.bin"
	even
ArtKosM_Ribot:			binclude "General/Sprites/Ribot/Ribot.bin"
	even
ArtKosM_Orbinaut:			binclude "General/Sprites/Orbinaut/Orbinaut.bin"
	even
ArtKosM_Corkey:			binclude "General/Sprites/Corkey/Corkey.bin"
	even
ArtUnc_Flybot:		binclude "General/Sprites/Flybot/Flybot.bin"
	even
ArtNem_LBZKnuxBomb:		binclude "Levels/LBZ/Nemesis Art/Knuckles Bomb.bin"
	even
ArtKosM_LBZ2DeathEggSmall:		binclude "Levels/LBZ/KosinskiM Art/Act 2 Death Egg Small.bin"
	even
ArtKosM_LBZ2DeathEgg2_8x8:		binclude "Levels/LBZ/Tiles/Act 2 Death Egg 2.bin"
	even
ArtNem_AIZBossFire:		binclude "Levels/AIZ/Nemesis Art/Miniboss Fire.bin"
	even
ArtKosM_AIZIntroPlane:		binclude "Levels/AIZ/KosinskiM Art/Intro Plane.bin"
	even
ArtUnc_CutsceneKnux:		binclude "General/Sprites/Knuckles/Cutscene/Cutscene Main.bin"
	even
ArtKosM_AIZIntroEmeralds:		binclude "Levels/AIZ/KosinskiM Art/Intro Emeralds.bin"
	even
ArtKosM_TailsEndPose:		binclude "General/Ending/KosinskiM Art/Tails Ending Pose.bin"
	even
ArtNem_S38x16Font:		binclude "General/Title/Nemesis Art/S3 8x16 Font.bin"
	even
ArtNem_AIZCorkFloor:		binclude "Levels/AIZ/Nemesis Art/Cork Floor 1.bin"
	even
ArtNem_AIZCorkFloor2:		binclude "Levels/AIZ/Nemesis Art/Cork Floor 2.bin"
	even

ArtNem_AIZSwingVine:		binclude "Levels/AIZ/Nemesis Art/Swing Vine.bin"
	even

ArtNem_AIZSlideRope:		binclude "Levels/AIZ/Nemesis Art/Zip Vine.bin"
	even
ArtNem_AIZBackgroundTree:		binclude "Levels/AIZ/Nemesis Art/BG Tree.bin"
	even

ArtNem_AIZMisc1:		binclude "Levels/AIZ/Nemesis Art/Misc Art 1.bin"
	even
ArtNem_AIZFallingLog:		binclude "Levels/AIZ/Nemesis Art/Falling Log.bin"
	even
ArtNem_AIZMisc2:				binclude "Levels/AIZ/Nemesis Art/Misc Art 2.bin"
	even

ArtNem_HCZSpikeBall:		binclude "Levels/HCZ/Nemesis Art/Spike Ball.bin"
	even

ArtNem_HCZWaveSplash:		binclude "Levels/HCZ/Nemesis Art/Wave Splash.bin"
	even

ArtNem_HCZButton:		binclude "Levels/HCZ/Nemesis Art/Button.bin"
	even

ArtNem_HCZMisc:		binclude "Levels/HCZ/Nemesis Art/Misc Art.bin"
	even

ArtNem_HCZWaterRush:		binclude "Levels/HCZ/Nemesis Art/Water Rush.bin"
	even
ArtKosM_HCZLargeFan:		binclude "Levels/HCZ/KosinskiM Art/Large Fan.bin"
	even
ArtKosM_HCZGeyserHorz:		binclude "Levels/HCZ/KosinskiM Art/Geyser Horizontal.bin"
	even
ArtKosM_HCZGeyserVert:		binclude "Levels/HCZ/KosinskiM Art/Geyser Vertical.bin"
	even

ArtNem_HCZ2Slide:		binclude "Levels/HCZ/Nemesis Art/Act 2 Slide.bin"
	even
ArtNem_HCZ2BlockPlat:		binclude "Levels/HCZ/Nemesis Art/Act 2  Block Platform.bin"
	even
ArtUnc_HCZWaterSplash2:		binclude "Levels/HCZ/Animated Tiles/Water Splash 2.bin"
	even
ArtUnc_HCZWaterSplash:		binclude "Levels/HCZ/Animated Tiles/Water Splash.bin"
	even
ArtNem_HCZ2KnuxWall:		binclude "Levels/HCZ/Nemesis Art/Act 2  Knuckles Wall.bin"
	even
ArtNem_MGZMisc1:		binclude "Levels/MGZ/Nemesis Art/Misc Art 1.bin"
	even

ArtNem_MGZMisc2:		binclude "Levels/MGZ/Nemesis Art/Misc Art 2.bin"
	even

ArtNem_MGZSigns:		binclude "Levels/MGZ/Nemesis Art/Direction Signs.bin"
	even

ArtNem_CNZMisc:		binclude "Levels/CNZ/Nemesis Art/Misc Art.bin"
	even
ArtNem_CNZPlatform:		binclude "Levels/CNZ/Nemesis Art/Platform.bin"
	even
ArtNem_LBZMisc:		binclude "Levels/LBZ/Nemesis Art/Misc Art.bin"
	even

ArtNem_LBZTubeTrans:		binclude "Levels/LBZ/Nemesis Art/Tube Transport.bin"
	even
ArtNem_LBZ2Misc:		binclude "Levels/LBZ/Nemesis Art/Act 2 Misc Art.bin"
	even
ArtNem_2PArt_1:		binclude "General/2P Zone/Nemesis Art/Misc Art 1.bin"
	even

ArtNem_2PArt_2:		binclude "General/2P Zone/Nemesis Art/Misc Art 2.bin"
	even

ArtNem_2PArt_3:		binclude "General/2P Zone/Nemesis Art/Misc Art 3.bin"
	even

ArtNem_2PStartPost:		binclude "General/2P Zone/Nemesis Art/Start Post.bin"
	even

ArtNem_2PTime:		binclude "General/2P Zone/Nemesis Art/Time Display.bin"
	even

ArtNem_2PLapNum:		binclude "General/2P Zone/Nemesis Art/Lap Numbers.bin"
	even

ArtNem_2PPosIcon:		binclude "General/2P Zone/Nemesis Art/Position Icons.bin"
	even

ArtNem_BPZMisc:		binclude "Levels/BPZ/Nemesis Art/Misc Art.bin"
	even
ArtNem_DPZMisc:		binclude "Levels/DPZ/Nemesis Art/Misc Art.bin"
	even
ArtNem_CGZMisc:		binclude "Levels/CGZ/Nemesis Art/Platform.bin"
	even
ArtNem_EMZMisc:		binclude "Levels/EMZ/Nemesis Art/Misc Art.bin"
	even
ArtKosM_AIZ2Bombership2_8x8:		binclude "Levels/AIZ/Tiles/Act 2 Bombership 2.bin"
	even
ArtKosM_ResultsMILES:		binclude "General/Sprites/Results/Results MILES.bin"
	even
ArtKosM_ResultsTAILS:		binclude "General/Sprites/Results/Results TAILS.bin"
	even

ArtKosM_AIZTitleCard:		binclude "Levels/AIZ/KosinskiM Art/Title Card.bin"
	even
ArtKosM_HCZTitleCard:		binclude "Levels/HCZ/KosinskiM Art/Title Card.bin"
	even
ArtKosM_MGZTitleCard:		binclude "Levels/MGZ/KosinskiM Art/Title Card.bin"
	even
ArtKosM_CNZTitleCard:		binclude "Levels/CNZ/KosinskiM Art/Title Card.bin"
	even
ArtKosM_ICZTitleCard:		binclude "Levels/ICZ/KosinskiM Art/Title Card.bin"
	even
ArtKosM_LBZTitleCard:		binclude "Levels/LBZ/KosinskiM Art/Title Card.bin"
	even
ArtKosM_ALZTitleCard:		binclude "Levels/ALZ/KosinskiM Art/Title Card.bin"
	even
ArtKosM_BPZTitleCard:		binclude "Levels/BPZ/KosinskiM Art/Title Card.bin"
	even
ArtKosM_DPZTitleCard:		binclude "Levels/DPZ/KosinskiM Art/Title Card.bin"
	even
ArtKosM_CGZTitleCard:		binclude "Levels/CGZ/KosinskiM Art/Title Card.bin"
	even
ArtKosM_EMZTitleCard:		binclude "Levels/EMZ/KosinskiM Art/Title Card.bin"
	even
Pal_SaveMenuBG:		binclude "General/Save Menu/Palettes/BG.bin"
	even
Pal_CompetitionMenuBG:		binclude "General/Competition Menu/Palettes/BG.bin"
	even
MapEni_S3MenuBG:		binclude "General/Title/Enigma Map/S3 Menu BG.bin"
	even
ArtKos_S3MenuBG:		binclude "General/Save Menu/Kosinski Art/Menu BG.bin"
	even
MapEni_CompetitionLevBorder:		binclude "General/Competition Menu/Enigma Map/Level Border.bin"
	even
MapUnc_CompetitionTimeBorder:		dc.w $829F,$82A1,$82A1,$82A1,$82A1,$82A1,$82A1,$82A1,$82A1,$82A1,$82A9,$82AB
		dc.w $82A0,$82A2,$82A2,$82A2,$82A2,$82A2,$82A2,$82A2,$82A2,$82A2,$82AA,$82AC
		dc.w $82A0,$82AB,$82AB,$82AB,$82AB,$82AB,$82AB,$82AB,$82AB,$82AB,$82B1,$82B5
		dc.w $82A0,$82AB,$82AB,$82AB,$82AB,$82AB,$82AB,$82AB,$82AB,$82AB,$82B1,$82B5
		dc.w $82A0,$82AB,$82AB,$82AB,$82AB,$82AB,$82AB,$82AB,$82AB,$82AB,$82B1,$82B5
		dc.w $82A0,$82AB,$82AB,$82AB,$82AB,$82AB,$82AB,$82AB,$82AB,$82AB,$82B1,$82B5
		dc.w $82A0,$82AB,$82AB,$82AB,$82AB,$82AB,$82AB,$82AB,$82AB,$82AB,$82B1,$82B5
		dc.w $82B9,$82BB,$82BB,$82BB,$82BB,$82BB,$82BB,$82BB,$82BB,$82BB,$82C3,$82C5
		dc.w $82BA,$82BC,$82BC,$82BC,$82BC,$82BC,$82BC,$82BC,$82BC,$82BC,$82BC,$82C6
MapUnc_CompetitionBESTTIME:		dc.w $A515,$A516,$A517,$A518,$A519,$A51A,$A51B,$A51C,$A51D
		dc.w $A51E,$A51F,$A520,$A521,$A522,$A523,$A524,$A525,$A526

MapEni_CompetitionLevImage:		binclude "General/Competition Menu/Enigma Map/Level Images.bin"
	even
MapEni_CompetitionLevName:		binclude "General/Competition Menu/Enigma Map/Level Names.bin"
	even
ArtKos_CompetitionMode:		binclude "General/Competition Menu/Kosinski Art/Mode Select.bin"
	even
ArtKos_CompetitionLevel:		binclude "General/Competition Menu/Kosinski Art/Level Select.bin"
	even
ArtKos_CompetitionResults:		binclude "General/Competition Menu/Kosinski Art/Results.bin"
	even
Map_CompetitionPlayerSprite:		include "General/Competition Menu/Map - Competition Player Sprites.asm"

ArtKos_CompetitionPlayer:		binclude "General/Competition Menu/Kosinski Art/Player Sprites.bin"
	even
MapEni_SaveScreen_Layout:			binclude "General/Save Menu/Enigma Map/Save Screen Layout.bin"
	even
MapUnc_SaveScreenNEW:		dc.w $A2A3,$A2A3,$A2A3,$A2A3,$A2A3,$A2A3,$A2A3,$A2A3,$A2A3,$A2A3
		dc.w $A2A3,$A2A3,$A2A3,$A2A3,$A2A3,$A2A3,$A2A3,$A2A3,$A2A3,$A2A3
		dc.w $A2A3,$A2C7,$A2C8,$A2C9,$A2CA,$A2CB,$A2CC,$A2CD,$A2CE,$A2A3
		dc.w $A2A3,$A2CF,$A2D0,$A2D1,$A2D2,$A2D3,$A2D4,$A2D5,$A2D6,$A2A3
		dc.w $A2A3,$A2D7,$A2D8,$A2D9,$B2CA,$A2DA,$A2DB,$A2DC,$A2A3,$A2A3
		dc.w $A2A3,$A2A3,$A2A3,$A2A3,$A2A3,$A2A3,$A2A3,$A2A3,$A2A3,$A2A3
		dc.w $A2A3,$A2A3,$A2A3,$A2A3,$A2A3,$A2A3,$A2A3,$A2A3,$A2A3,$A2A3
MapPtrs_SaveScreenStatic:		dc.l MapUnc_SaveScreenStatic1
		dc.l MapUnc_SaveScreenStatic2
		dc.l MapUnc_SaveScreenStatic3
		dc.l MapUnc_SaveScreenStatic4
MapUnc_SaveScreenStatic1:		dc.w $A2DD,$A2DE,$A2DF,$A2E0,$A2DD,$A2DE,$A2DF,$A2E0,$A2DD,$A2E0
		 dc.w $AAE0,$AADD,$AAE0,$B2DE,$B2DF,$B2E0,$B2DD,$AADD,$AAE0,$AADD
		dc.w $AAE0,$AADF,$AADE,$AADD,$AAE0,$AADF,$AADE,$B2DF,$AAE0,$AADD
		dc.w $A2DF,$AAE0,$BAE0,$BADF,$BADE,$A2E0,$A2E0,$A2DE,$A2DF,$A2E0
		dc.w $BAE0,$BADF,$BADE,$BADD,$BAE0,$BADF,$BADE,$BADD,$A2E0,$BADE
		dc.w $A2DD,$A2DE,$A2DF,$A2E0,$A2DD,$A2DE,$A2DF,$A2E0,$A2DD,$A2E0
		dc.w $AAE0,$AADD,$AAE0,$B2DE,$B2DF,$B2E0,$B2DD,$AADD,$AAE0,$AADD
MapUnc_SaveScreenStatic2:		dc.w $B2DD,$B2E0,$B2DD,$AADD,$AAE0,$AADF,$AADE,$B2E0,$B2DD,$B2E0
		dc.w $BAE0,$BADD,$BAE0,$BADF,$BADE,$BADD,$BAE0,$BADF,$BADE,$BADD
		dc.w $A2DE,$BAE0,$A2DD,$A2DE,$A2DF,$A2E0,$A2DD,$A2DE,$A2DF,$A2E0
		dc.w $BAE0,$BADF,$BADE,$BAE0,$BAE0,$A2DE,$A2DF,$A2E0,$B2E0,$BADF
		dc.w $B2DD,$B2E0,$AADF,$B2DE,$B2DF,$B2E0,$B2DD,$B2DE,$B2DF,$B2E0
		dc.w $B2DD,$B2E0,$B2DD,$AADD,$AAE0,$AADF,$AADE,$B2E0,$B2DD,$B2E0
		dc.w $BAE0,$BADD,$BAE0,$BADF,$BADE,$BADD,$BAE0,$BADF,$BADE,$BADD
MapUnc_SaveScreenStatic3:		dc.w $BAE0,$BADD,$BAE0,$A2DE,$A2DF,$A2E0,$A2DD,$BADD,$BAE0,$BADD
		dc.w $B2DD,$B2DE,$B2DF,$B2E0,$B2DD,$B2DE,$B2DF,$B2E0,$B2DD,$B2E0
		dc.w $AAE0,$AADF,$AADE,$AADD,$AAE0,$AADF,$AADE,$AADD,$B2E0,$AADE
		dc.w $B2DF,$BAE0,$AAE0,$AADF,$AADE,$B2E0,$B2E0,$B2DE,$B2DF,$B2E0
		dc.w $BAE0,$BADF,$BADE,$BADD,$BAE0,$BADF,$BADE,$A2DF,$BAE0,$BADD
		dc.w $BAE0,$BADD,$BAE0,$A2DE,$A2DF,$A2E0,$A2DD,$BADD,$BAE0,$BADD
		dc.w $B2DD,$B2DE,$B2DF,$B2E0,$B2DD,$B2DE,$B2DF,$B2E0,$B2DD,$B2E0
MapUnc_SaveScreenStatic4:		dc.w $AAE0,$AADD,$AAE0,$AADF,$AADE,$AADD,$AAE0,$AADF,$AADE,$AADD
		dc.w $A2DD,$A2E0,$A2DD,$BADD,$BAE0,$BADF,$BADE,$A2E0,$A2DD,$A2E0
		dc.w $A2DD,$A2E0,$BADF,$A2DE,$A2DF,$A2E0,$A2DD,$A2DE,$A2DF,$A2E0
		dc.w $AAE0,$AADF,$AADE,$AAE0,$AAE0,$B2DE,$B2DF,$B2E0,$A2E0,$AADF
		dc.w $B2DE,$AAE0,$B2DD,$B2DE,$B2DF,$B2E0,$B2DD,$B2DE,$B2DF,$B2E0
		dc.w $AAE0,$AADD,$AAE0,$AADF,$AADE,$AADD,$AAE0,$AADF,$AADE,$AADD
		dc.w $A2DD,$A2E0,$A2DD,$BADD,$BAE0,$BADF,$BADE,$A2E0,$A2DD,$A2E0
ArtKos_SaveScreenMisc:			binclude "General/Save Menu/Kosinski Art/Misc.bin"
	even

; Music data placed here
	;org $2C8000
	;binclude "Sound/Music/AIZ1.bin"
	;binclude "Sound/Music/AIZ2.bin"
	;binclude "Sound/Music/HCZ1.bin"
	;binclude "Sound/Music/HCZ2.bin"
	;binclude "Sound/Music/MGZ1.bin"
	;binclude "Sound/Music/MGZ2.bin"
	;binclude "Sound/Music/CNZ2.bin"
	;binclude "Sound/Music/CNZ1.bin"
	;org $2D0000
	;binclude "Sound/Music/ICZ2.bin"
	;binclude "Sound/Music/ICZ1.bin"
	;binclude "Sound/Music/LBZ2.bin"
	;binclude "Sound/Music/LBZ1.bin"
	;org $2D8AE8
	;binclude "Sound/Music/Gum Ball Machine.bin"
	;org $2D99F7
	;binclude "Sound/Music/Azure Lake.bin"
	;binclude "Sound/Music/Balloon Park.bin"
	;binclude "Sound/Music/Desert Palace.bin"
	;binclude "Sound/Music/Chrome Gadget.bin"
	;binclude "Sound/Music/Endless Mine.bin"
	;org $2DE587
	;binclude "Sound/Music/Sonic 3 Credits.bin"
	;org $2DF5E4
	;binclude "Sound/Music/Competition Menu.bin"
	;binclude "Sound/Music/Countdown.bin"

	;org $2E8000
	;binclude "sound/DAC/s3/S3DAC header 1.bin"
	;org $2E87F7
	;binclude "sound/DAC/s3/9C.bin"
	;binclude "sound/DAC/s3/9D.bin"
	;binclude "sound/DAC/s3/9E.bin"
	;binclude "sound/DAC/s3/9F.bin"
	;binclude "sound/DAC/s3/A0.bin"
	;binclude "sound/DAC/s3/A1.bin"
	;binclude "sound/DAC/s3/A2.bin"
	;binclude "sound/DAC/s3/A3.bin"
	;binclude "sound/DAC/s3/A4.bin"
	;binclude "sound/DAC/s3/A5.bin"
	;binclude "sound/DAC/s3/A6.bin"
	;binclude "sound/DAC/s3/A7.bin"
	;binclude "sound/DAC/s3/A8.bin"
	;binclude "sound/DAC/s3/A9.bin"
	;binclude "sound/DAC/s3/AA.bin"
	;org $2F0000
	;binclude "sound/DAC/s3/S3DAC header 2.bin"
	;binclude "sound/DAC/s3/AB.bin"
	;binclude "sound/DAC/s3/AC.bin"
	;binclude "sound/DAC/s3/AD-AE.bin"
	;binclude "sound/DAC/s3/AF-B0.bin"
	;org $2F28E0
	;binclude "sound/DAC/s3/B1.bin"
	;org $2F3CAD
	;binclude "sound/DAC/s3/B4C1-C4.bin"
	;binclude "sound/DAC/s3/B5.bin"
	;binclude "sound/DAC/s3/B6.bin"
	;binclude "sound/DAC/s3/B7.bin"
	;binclude "sound/DAC/s3/B8-B9.bin"
	;binclude "sound/DAC/s3/BA.bin"
	;binclude "sound/DAC/s3/BB.bin"
	;binclude "sound/DAC/s3/BC.bin"
	;binclude "sound/DAC/s3/BD.bin"
	;binclude "sound/DAC/s3/BE.bin"
	;binclude "sound/DAC/s3/BF.bin"
	;binclude "sound/DAC/s3/C0.bin"

	;org $2F8000
AIZ1_16x16_Primary_Kos:		binclude "Levels/AIZ/Blocks/Act 1 Primary.bin"
	even
AIZ1_16x16_Secondary_Kos:		binclude "Levels/AIZ/Blocks/Act 1 Secondary.bin"
	even
AIZ1_16x16_MainLevel_Kos:		binclude "Levels/AIZ/Blocks/Act 1 Main Level.bin"
	even
AIZ1_8x8_Primary_KosM:		binclude "Levels/AIZ/Tiles/Act 1 Primary.bin"
	even
AIZ1_8x8_Secondary_KosM:		binclude "Levels/AIZ/Tiles/Act 1 Secondary.bin"
	even
AIZ1_8x8_MainLevel_KosM:		binclude "Levels/AIZ/Tiles/Act 1 Main Level.bin"
	even
AIZ1_128x128_Kos:		binclude "Levels/AIZ/Chunks/Act 1.bin"
	even
AIZ1_8x8_Flames_KosM:		binclude "Levels/AIZ/Tiles/Act 1 Fire Overlay.bin"
	even

AIZ2_16x16_Primary_Kos:		binclude "Levels/AIZ/Blocks/Act 2 Primary.bin"
	even
AIZ2_16x16_Secondary_Kos:		binclude "Levels/AIZ/Blocks/Act 2 Secondary.bin"
	even
AIZ2_16x16_BomberShip_Kos:		binclude "Levels/AIZ/Blocks/Act 2 BomberShip.bin"
	even
AIZ2_8x8_Primary_KosM:		binclude "Levels/AIZ/Tiles/Act 2 Primary.bin"
	even
AIZ2_8x8_Secondary_KosM:		binclude "Levels/AIZ/Tiles/Act 2 Secondary.bin"
	even
AIZ2_8x8_BomberShip_KosM:		binclude "Levels/AIZ/Tiles/Act 2 Bombership.bin"
	even
AIZ2_128x128_Kos:		binclude "Levels/AIZ/Chunks/Act 2.bin"
	even

HCZ_16x16_Primary_Kos:		binclude "Levels/HCZ/Blocks/Primary.bin"
	even
HCZ_8x8_Primary_KosM:		binclude "Levels/HCZ/Tiles/Primary.bin"
	even
HCZ_128x128_Primary_Kos:		binclude "Levels/HCZ/Chunks/Primary.bin"
	even

HCZ1_16x16_Secondary_Kos:		binclude "Levels/HCZ/Blocks/Act 1 Secondary.bin"
	even
HCZ1_8x8_Secondary_KosM:		binclude "Levels/HCZ/Tiles/Act 1 Secondary.bin"
	even
HCZ1_128x128_Secondary_Kos:		binclude "Levels/HCZ/Chunks/Act 1 Secondary.bin"
	even

HCZ2_16x16_Secondary_Kos:		binclude "Levels/HCZ/Blocks/Act 2 Secondary.bin"
	even
HCZ2_8x8_Secondary_KosM:		binclude "Levels/HCZ/Tiles/Act 2 Secondary.bin"
	even
HCZ2_128x128_Secondary_Kos:		binclude "Levels/HCZ/Chunks/Act 2 Secondary.bin"
	even

MGZ_16x16_Primary_Kos:		binclude "Levels/MGZ/Blocks/Primary.bin"
	even
MGZ_8x8_Primary_KosM:		binclude "Levels/MGZ/Tiles/Primary.bin"
	even
MGZ_128x128_Primary_Kos:		binclude "Levels/MGZ/Chunks/Primary.bin"
	even

MGZ1_16x16_Secondary_Kos:		binclude "Levels/MGZ/Blocks/Act 1 Secondary.bin"
	even
MGZ1_8x8_Secondary_KosM:		binclude "Levels/MGZ/Tiles/Act 1 Secondary.bin"
	even
MGZ1_128x128_Secondary_Kos:		binclude "Levels/MGZ/Chunks/Act 1 Secondary.bin"
	even

MGZ2_16x16_Secondary_Kos:		binclude "Levels/MGZ/Blocks/Act 2 Secondary.bin"
	even
MGZ2_8x8_Secondary_KosM:		binclude "Levels/MGZ/Tiles/Act 2 Secondary.bin"
	even
MGZ2_128x128_Secondary_Kos:		binclude "Levels/MGZ/Chunks/Act 2 Secondary.bin"
	even
MGZ2_QuakeChunks:		binclude "Levels/MGZ/Chunks/Act 2 Quake.bin"
	even

CNZ_16x16_Kos:		binclude "Levels/CNZ/Blocks/Primary.bin"
	even
CNZ_8x8_KosM:		binclude "Levels/CNZ/Tiles/Primary.bin"
	even
CNZ_128x128_Kos:		binclude "Levels/CNZ/Chunks/Primary.bin"
	even

ICZ_16x16_Primary_Kos:		binclude "Levels/ICZ/Blocks/Primary.bin"
	even
ICZ_8x8_Primary_KosM:		binclude "Levels/ICZ/Tiles/Primary.bin"
	even
ICZ_128x128_Primary_Kos:		binclude "Levels/ICZ/Chunks/Primary.bin"
	even

ICZ1_16x16_Secondary_Kos:		binclude "Levels/ICZ/Blocks/Act 1 Secondary.bin"
	even
ICZ1_8x8_Secondary_KosM:		binclude "Levels/ICZ/Tiles/Act 1 Secondary.bin"
	even
ICZ1_128x128_Secondary_Kos:		binclude "Levels/ICZ/Chunks/Act 1 Secondary.bin"
	even

ICZ2_16x16_Secondary_Kos:		binclude "Levels/ICZ/Blocks/Act 2 Secondary.bin"
	even
ICZ2_8x8_Secondary_KosM:		binclude "Levels/ICZ/Tiles/Act 2 Secondary.bin"
	even
ICZ2_128x128_Secondary_Kos:		binclude "Levels/ICZ/Chunks/Act 2 Secondary.bin"
	even

LBZ_16x16_Primary_Kos:		binclude "Levels/LBZ/Blocks/Primary.bin"
	even
LBZ1_16x16_Secondary_Kos:		binclude "Levels/LBZ/Blocks/Act 1 Secondary.bin"
	even
LBZ_8x8_Primary_KosM:		binclude "Levels/LBZ/Tiles/Primary.bin"
	even
LBZ1_8x8_Secondary_KosM:		binclude "Levels/LBZ/Tiles/Act 1 Secondary.bin"
	even
LBZ1_128x128_Kos:		binclude "Levels/LBZ/Chunks/Act 1.bin"
	even

LBZ2_16x16_Secondary_Kos:		binclude "Levels/LBZ/Blocks/Act 2 Secondary.bin"
	even
LBZ2_16x16_DeathEgg_Kos:		binclude "Levels/LBZ/Blocks/Act 2 Death Egg.bin"
	even
LBZ2_8x8_Secondary_KosM:		binclude "Levels/LBZ/Tiles/Act 2 Secondary.bin"
	even
LBZ2_8x8_DeathEgg_KosM:		binclude "Levels/LBZ/Tiles/Act 2 Death Egg.bin"
	even
LBZ2_128x128_Kos:		binclude "Levels/LBZ/Chunks/Act 2.bin"
	even
LBZ2_128x128_DeathEgg_Kos:		binclude "Levels/LBZ/Chunks/Act 2 Death Egg.bin"
	even

ALZ_16x16_Kos:		binclude "Levels/ALZ/Blocks/Primary.bin"
	even
ALZ_8x8_KosM:		binclude "Levels/ALZ/Tiles/Primary.bin"
	even
ALZ_128x128_Kos:		binclude "Levels/ALZ/Chunks/Primary.bin"
	even

BPZ_16x16_Kos:		binclude "Levels/BPZ/Blocks/Primary.bin"
	even
BPZ_8x8_KosM:		binclude "Levels/BPZ/Tiles/Primary.bin"
	even
BPZ_128x128_Kos:		binclude "Levels/BPZ/Chunks/Primary.bin"
	even

DPZ_16x16_Kos:		binclude "Levels/DPZ/Blocks/Primary.bin"
	even
DPZ_8x8_KosM:		binclude "Levels/DPZ/Tiles/Primary.bin"
	even
DPZ_128x128_Kos:		binclude "Levels/DPZ/Chunks/Primary.bin"
	even

CGZ_16x16_Kos:		binclude "Levels/CGZ/Blocks/Primary.bin"
	even
CGZ_8x8_KosM:		binclude "Levels/CGZ/Tiles/Primary.bin"
	even
CGZ_128x128_Kos:		binclude "Levels/CGZ/Chunks/Primary.bin"
	even

EMZ_16x16_Kos:		binclude "Levels/EMZ/Blocks/Primary.bin"
	even
EMZ_8x8_KosM:		binclude "Levels/EMZ/Tiles/Primary.bin"
	even
EMZ_128x128_Kos:		binclude "Levels/EMZ/Chunks/Primary.bin"
	even

Gumball_16x16_Kos:		binclude "Levels/Gumball/Blocks/Primary.bin"
	even
Gumball_8x8_KosM:		binclude "Levels/Gumball/Tiles/Gumball.bin"
	even
Gumball_128x128_Kos:		binclude "Levels/Gumball/Chunks/Primary.bin"
	even
