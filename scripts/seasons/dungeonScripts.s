; These are a bunch of scripts used by INTERAC_DUNGEON_SCRIPT.

dungeonScript_minibossDeath:
	stopifroomflag80set
	checknoenemies
	orroomflag $80
	wait 20
	spawninteraction INTERAC_MINIBOSS_PORTAL, $00, $00, $00

enableLinkAndMenu:
	writememory wDisableLinkCollisionsAndMenu, $00

dungeonScript_end:
	scriptend

dungeonScript_checkActiveTriggersEq02:
	stopifitemflagset
	checkmemoryeq wActiveTriggers, $02
	scriptjump spawnChestAfterPuff

dungeonScript_checkActiveTriggersEq01:
	stopifitemflagset
	checkmemoryeq wActiveTriggers, $01


spawnChestAfterPuff:
	playsound SND_SOLVEPUZZLE
	createpuff
	wait 15
	settilehere TILEINDEX_CHEST
	scriptend


dungeonScript_bossDeath:
	jumpifroomflagset $80, spawnHeartContainerCenterOfRoom
	checknoenemies
	orroomflag $80

spawnHeartContainerCenterOfRoom:
	stopifitemflagset
	setcoords $58, $78
	spawnitem TREASURE_HEART_CONTAINER, $00
	writememory wDisableLinkCollisionsAndMenu, $00
	scriptend


snakesRemainsScript_timerForChestDisappearing:
	stopifitemflagset
	wait 240
	wait 240
	wait 240
	wait 240
	wait 240
	wait 240
	wait 240
	stopifitemflagset
	playsound SND_POOF
	createpuff
	settilehere TILEINDEX_STANDARD_FLOOR
	scriptend


snakesRemainsScript_bossDeath:
	jumpifroomflagset $80, ++
	checknoenemies
	orroomflag $80
++
	stopifitemflagset
	setcoords $80, $78

spawnHeartContainerHere:
	spawnitem TREASURE_HEART_CONTAINER, $00
	writememory wDisableLinkCollisionsAndMenu, $00
	scriptend

/*
poisonMothsLairScript_hallwayTrapRoom:
	asm15 scriptHelp.D3spawnPitSpreader
	checkmemoryeq wActiveTriggers, $01
	asm15 scriptHelp.D3hallToMiniboss_buttonStepped
	scriptend


poisonMothsLairScript_checkStatuePuzzle:
	asm15 scriptHelp.D3StatuePuzzleCheck
	wait 1
	scriptjump poisonMothsLairScript_checkStatuePuzzle


poisonMothsLairScript_minibossDeath:
	stopifroomflag80set
	checknoenemies
	orroomflag $80
	wait 20
	createpuff
	settilehere TILEINDEX_INDOOR_UPSTAIRCASE
	spawninteraction INTERAC_MINIBOSS_PORTAL, $00, $00, $00
	scriptjump enableLinkAndMenu
*/

dungeonScript_omuaiDeath:
	jumpifroomflagset ROOMFLAG_80, omuaiDeath_coordsForHeartContainer
	checknoenemies

omuaiDeath_coordsForHeartContainer:
	stopifitemflagset
	scriptjump spawnHeartContainerHere

/*
poisonMothsLairScript_bossDeath:
	jumpifroomflagset $80, poisonMothsLair_coordsForHeartContainer
	checknoenemies
	wait 60
	createpuff
	settilehere $45

poisonMothsLair_coordsForHeartContainer:
	stopifitemflagset
	setcoords $20, $78
	scriptjump spawnHeartContainerHere


poisonMothsLairScript_openEssenceDoorIfBossBeat:
	asm15 scriptHelp.D3openEssenceDoorIfBossBeat_body
	scriptend


dancingDragonScript_spawnStairsToB1:
	stopifroomflag80set
	checknoenemies
	orroomflag $80
	spawninteraction INTERAC_PUFF, $00, $38, $98
	wait 8
	settilehere TILEINDEX_SOUTH_STAIRS
	playsound SND_SOLVEPUZZLE
	scriptend


dancingDragonScript_torchesHallway:
	jumpifroomflagset $80, @spawnChest
	checkmemoryeq wNumTorchesLit, $03
	orroomflag $80
	wait 8
@spawnChest:
	stopifitemflagset
	scriptjump spawnChestAfterPuff


dancingDragonScript_spawnBossKey:
	stopifitemflagset
	spawnitem TREASURE_BOSS_KEY, $02
	scriptend


dancingDragonScript_pushingPotsRoom:
	stopifitemflagset
	checkmemoryeq wActiveTriggers, $ff
	spawnitem TREASURE_SMALL_KEY, $01
	scriptend


dancingDragonScript_bridgeInB2:
	stopifroomflag80set
	checkmemoryeq wNumTorchesLit, $02
	asm15 scriptHelp.D4spawnBridgeB2
	scriptend


unicornsCaveScript_spawnBossKey:
	stopifitemflagset
	spawnitem TREASURE_BOSS_KEY, $00
	scriptend


unicornsCaveScript_dropMagnetBallAfterDarknutKill:
	stopifroomflag80set
	wait 30
	checknoenemies
	orroomflag $80
	scriptend


dungeonScript_spawnKeyOnMagnetBallToButton:
	stopifitemflagset
	checkmemoryeq wActiveTriggers, $01
	spawnitem TREASURE_SMALL_KEY, $01
	scriptend


ancientRuinsScript_spawnStaircaseUp1FTopLeftRoom:
	stopifroomflag80set
	checkflagset $00, wToggleBlocksState
	setangle <ROOM_SEASONS_5bc

createWallUpStaircaseAndSetOtherRoomFlag:
	; angle is the low index of the other room
	asm15 scriptHelp.D6setFlagBit7InRoomWithLowIndexInAngle
	playsound SND_SOLVEPUZZLE
	orroomflag $80
	createpuff
	wait 8
	settilehere TILEINDEX_INDOOR_WALL_UPSTAIRCASE
	scriptend


ancientRuinsScript_spawnStaircaseUp1FTopMiddleRoom:
	stopifroomflag80set
	checkmemoryeq wActiveTriggers, $01
	setangle <ROOM_SEASONS_5be
	scriptjump createWallUpStaircaseAndSetOtherRoomFlag


; ???
ancientRuinsScript_4c50:
	setangle $02

loopCheckToggleBlocks:
	asm15 scriptHelp.toggleBlocksInAngleBitsHit
	wait 8
	scriptjump loopCheckToggleBlocks


ancientRuinsScript_5TorchesMovingPlatformsRoom:
	stopifroomflag80set
	checkmemoryeq wNumTorchesLit, $05
	setcounter1 45
	setangle <ROOM_SEASONS_5c4
	scriptjump createWallUpStaircaseAndSetOtherRoomFlag


ancientRuinsScript_roomWithJustRopesSpawningButton:
	checkmemoryeq wActiveTriggers, $01
	asm15 scriptHelp.D6RandomButtonSpawnRopes
	scriptend


ancientRuinsScript_UShapePitToMagicBoomerangOrb:
	setangle $04
	scriptjump loopCheckToggleBlocks
*/

ancientRuinsScript_randomButtonRoom:
	jumpifroomflagset ROOMFLAG_40 @puzzleDone
	asm15 scriptHelp.D6getRandomButtonResult
	jumptable_memoryaddress $cfc1
	.dw ancientRuinsScript_randomButtonRoom
	.dw @failed
	.dw @success
@success:
	;playsound SND_SOLVEPUZZLE
	;createpuff
	wait 30
	;settilehere TILEINDEX_INDOOR_UPSTAIRCASE
	orroomflag ROOMFLAG_40
	ormemory wActiveTriggers $04
	scriptjump spawnChestAfterPuff
	;asm15 scriptHelp.D6setFlagBit7InFirst4FRoom
	;scriptend
@failed:
	wait 60
	playsound SND_ERROR
	wait 60
	asm15 scriptHelp.D6RandomButtonSpawnRopes
	wait 60
	checknoenemies
	scriptjump ancientRuinsScript_randomButtonRoom

@puzzleDone:
	ormemory wActiveTriggers $04
	stopifitemflagset
	scriptjump spawnChestAfterPuff
/*
ancientRuinsScript_4F3OrbsRoom:
	setangle $38
	scriptjump loopCheckToggleBlocks


ancientRuinsScript_spawnStairsLeadingToBoss:
	stopifroomflag80set
	checkflagset $06, wToggleBlocksState
	asm15 scriptHelp.D6setFlagBit7InLast4FRoom
	orroomflag $80
	playsound SND_SOLVEPUZZLE
	createpuff
	wait 30
	settilehere TILEINDEX_INDOOR_DOWNSTAIRCASE
	scriptend


ancientRuinsScript_spawnHeartContainerAndStairsUp:
	jumpifroomflagset $80, spawnHeartContainerCenterOfRoom
	checknoenemies
	orroomflag $80
	setcoords $08, $78
	createpuff
	wait 30
	settilehere TILEINDEX_INDOOR_WALL_UPSTAIRCASE
	scriptjump spawnHeartContainerCenterOfRoom


ancientRuinsScript_1FTopRightTrapButtonRoom:
	checkmemoryeq wActiveTriggers, $01
	asm15 scriptHelp.D6spawnFloorDestroyerAndEscapeBridge
	stopifroomflag80set
	orroomflag $80
	scriptend


ancientRuinsScript_crystalTrapRoom:
	stopifitemflagset
	spawnitem TREASURE_RUPEES, $0a
@waitUntilRupeeGotten:
	jumpifroomflagset $20, @rupeeGotten
	wait 8
	scriptjump @waitUntilRupeeGotten
@rupeeGotten:
	loadscript scripts2.startCrystalTrapRoomSequence


ancientRuinsScript_spawnChestAfterCrystalTrapRoom:
	asm15 scriptHelp.D6spawnChestAfterCrystalTrapRoom_body
	scriptend


explorersCryptScript_dropKeyDownAFloor:
	stopifroomflag40set
	checkmemoryeq wActiveTriggers, $01
	asm15 scriptHelp.D7dropKeyDownAFloor
	scriptend


explorersCryptScript_keyDroppedFromAbove:
	stopifitemflagset
	jumpifroomflagset $80, @keyDroppedFromAbove
	scriptend
@keyDroppedFromAbove:
	spawnitem TREASURE_SMALL_KEY, $01
	scriptend


explorersCryptScript_4OrbTrampoline:
	setangle $01

explorersCryptScript_roomLeftOfRandomArmosRoom:
	jumpifroomflagset $40, D7createTrampoline
	checkmemoryeq wActiveTriggers, $01
	scriptjump D7buttonPressed

explorersCryptScript_magunesuTrampoline:
	asm15 interactionSetAlwaysUpdateBit
	jumpifroomflagset $40, D7createTrampoline
	checknoenemies

D7buttonPressed:
	orroomflag $40
	playsound SND_SOLVEPUZZLE

D7createTrampoline:
	wait 8
	createpuff
	wait 15
	asm15 scriptHelp.createD7Trampoline
	scriptend


; ???
explorersCryptScript_4d05:
	stopifitemflagset
	jumpifroomflagset $40, spawnChestAfterPuff
	checkmemoryeq wActiveTriggers, $01
	orroomflag $40
	scriptjump spawnChestAfterPuff


explorersCryptScript_randomlyPlaceNonEnemyArmos:
	asm15 scriptHelp.D7randomlyPlaceNonEnemyArmos_body
	scriptend


dungeonScript_checkIfMagnetBallOnButton:
	stopifitemflagset
	jumptable_memoryaddress wActiveTriggers
	.dw @unpressed
	.dw @pressed
@unpressed:
	asm15 scriptHelp.D7MagnetBallRoom_removeChest
	scriptjump dungeonScript_checkIfMagnetBallOnButton
@pressed:
	asm15 scriptHelp.D7MagnetBallRoom_addChest
	scriptjump dungeonScript_checkIfMagnetBallOnButton


explorersCryptScript_1stPoeSisterRoom:
	loadscript scripts2.explorersCrypt_firstPoeSister


explorersCryptScript_2ndPoeSisterRoom:
	loadscript scripts2.explorersCrypt_secondPoeSister


explorersCryptScript_4FiresRoom_1:
	stopifroomflag40set
	asm15 scriptHelp.checkFirstPoeBeaten
	jumptable_memoryaddress $cfc1
	.dw @notBeaten
	.dw explorersCrypt_poeBeaten

@notBeaten:
	loadscript scripts2.explorersCrypt_firesGoingOut_1

explorersCrypt_poeBeaten:
	playsound SND_SOLVEPUZZLE
	orroomflag $40
	scriptend


explorersCryptScript_4FiresRoom_2:
	stopifroomflag40set
	asm15 scriptHelp.checkSecondPoeBeaten
	jumptable_memoryaddress $cfc1
	.dw @notBeaten
	.dw explorersCrypt_poeBeaten

@notBeaten:
	loadscript scripts2.explorersCrypt_firesGoingOut_2


explorersCryptScript_darknutBridge:
	stopifroomflag80set
	checknoenemies
	orroomflag $80
	asm15 scriptHelp.D7spawnDarknutBridge
	scriptend


swordAndShieldMazeScript_verticalBridgeUnlockedByOrb:
	stopifroomflag80set
	checkmemoryeq wToggleBlocksState, $01
	asm15 scriptHelp.D8VerticalBridgeUnlockedByOrb
	scriptend


swordAndShieldMazeScript_verticalBridgeInLava:
	stopifroomflag80set
	checkmemoryeq wActiveTriggers, $01
	asm15 scriptHelp.D8VerticalBridgeInLava
	scriptend


swordAndShieldMazeScript_armosBlockingStairs:
	stopifroomflag80set
	writeobjectbyte Interaction.direction, $96

@checkIfWillMove:
	asm15 scriptHelp.D8armosCheckIfWillMove
	jumptable_objectbyte $49
	.dw @checkIfWillMove
	.dw stubScript


swordAndShieldMazeScript_7torchesAfterMiniboss:
	asm15 scriptHelp.D8createFiresGoingOut, $a0
	stopifroomflag80set
	checkmemoryeq wNumTorchesLit, $07

puzzelSolvedSpawnUpStaircase:
	orroomflag $80
	createpuff
	wait 30
	settilehere TILEINDEX_INDOOR_UPSTAIRCASE
	playsound SND_SOLVEPUZZLE
	scriptend


swordAndShieldMazeScript_spawnFireKeeseAtLavaHoles:
	stopifroomflag40set
	asm15 scriptHelp.D8setSpawnAtLavaHole
@loop:
	wait 240
	asm15 scriptHelp.D8SpawnLimitedFireKeese
	scriptjump @loop

*/
swordAndShieldMazeScript_pushableIceBlocks:
	stopifroomflag80set
@waitUntilIceBlocksInPlace:
	wait 8
	asm15 scriptHelp.D8checkAllIceBlocksInPlace
	jumptable_memoryaddress $cfc1
	.dw @waitUntilIceBlocksInPlace
	.dw @success
@success:
	orroomflag ROOMFLAG_80
	playsound SND_SOLVEPUZZLE
	createpuff
	wait 20
	settilehere $52
	scriptend


/*
swordAndShieldMazeScript_horizontalBridgeByMoldorms:
	stopifroomflag80set
	checkmemoryeq wActiveTriggers, $01
	asm15 scriptHelp.D8HorizontalBridgeByMoldorms
	scriptend


swordAndShieldMazeScript_tripleEyesByMiniboss:
	stopifroomflag80set
	checkmemoryeq wActiveTriggers, $07
	scriptjump puzzelSolvedSpawnUpStaircase


swordAndShieldMazeScript_tripleEyesNearStart:
	stopifitemflagset
	checkmemoryeq wActiveTriggers, $07
	scriptjump spawnChestAfterPuff


onoxsCastleScript_setFlagOnAllEnemiesDefeated:
	stopifroomflag40set
	checknoenemies
	orroomflag $40
	playsound SND_SOLVEPUZZLE
	scriptend


onoxsCastleScript_resetRoomFlagsOnDungeonStart:
	asm15 scriptHelp.D9forceRoomClearsOnDungeonEntry
	scriptend


herosCaveScript_spawnChestOnTorchLit:
	stopifitemflagset
	checkmemoryeq wNumTorchesLit, $01
	scriptjump spawnChestAfterPuff


herosCaveScript_spawnChestOn2TorchesLit:
	stopifitemflagset
	checkmemoryeq wNumTorchesLit, $02
	scriptjump spawnChestAfterPuff


herosCaveScript_check6OrbsHit:
	setangle $3f
	scriptjump loopCheckToggleBlocks


herosCaveScript_allButtonsPressedAndEnemiesDefeated:
	stopifitemflagset
	checkmemoryeq wActiveTriggers, $ff
	wait 60
	checknoenemies
	spawnitem TREASURE_SMALL_KEY, $01
	scriptend
*/

shoreCave_spawnBridges:
	checkmemoryeq wActiveTriggers, $01
	jumpifroomflagset ROOMFLAG_80, @spawnKey

	asm15 scriptHelp.D0spawnBridge_0
	wait 30
	asm15 scriptHelp.D0spawnBridge_1
	wait 30
	asm15 scriptHelp.D0spawnBridge_2
	wait 36
	asm15 scriptHelp.D0spawnBridge_3
	orroomflag ROOMFLAG_80
@spawnKey:
	checknoenemies
	stopifitemflagset
	spawnitem TREASURE_SMALL_KEY, $01
	scriptend

dungeonScript_fourTorchRoom:
	checkmemoryeq wNumTorchesLit, $04
	ormemory wActiveTriggers $02
	scriptend

dungeonScript_owlPuzzle:
	stopifitemflagset
	checktile $45 TILEINDEX_RED_PUSHABLE_BLOCK
	checktile $47 TILEINDEX_RED_PUSHABLE_BLOCK
	checktile $36 TILEINDEX_YELLOW_PUSHABLE_BLOCK
	checktile $56 TILEINDEX_BLUE_PUSHABLE_BLOCK
@spawnChest:
	scriptjump spawnChestAfterPuff	

dungeonScript_torchesSpawnKey:
	jumpifroomflagset ROOMFLAG_80 @spawnKey
	maketorcheslightable
	checktile $75 TILEINDEX_LIT_TORCH
	checktile $95 TILEINDEX_LIT_TORCH
@spawnKey:
	stopifitemflagset
	orroomflag ROOMFLAG_80
	spawnitem TREASURE_SMALL_KEY, $01
	scriptend

dungeonScript_spawnKeyInWater:
	stopifitemflagset
	spawnitem TREASURE_SMALL_KEY, $02
	scriptend

dungeonScript_spawnFacade:
	jumpifroomflagset ROOMFLAG_80 @facadeDead
	jumpifobjectbyteeq Interaction.state $01 @state1

@state0:
	spawnenemyhere ENEMY_FACADE $00
	writeobjectbyte Interaction.state $01
@state1:
	checknoenemies
	orroomflag ROOMFLAG_80
@spawnChest:
	stopifitemflagset
	scriptjump spawnChestAfterPuff

@facadeDead:
	spawnenemy ENEMY_BEETLE $01 $78 $28
	spawnenemy ENEMY_BEETLE $01 $48 $58
	spawnenemy ENEMY_BEETLE $01 $68 $a8
	scriptjump @spawnChest

dungeonScript_spawnPyramidBridge:
	jumptable_objectbyte Interaction.substate
	.dw @state0
	.dw @spawnBridge
	.dw @state2
	.dw @despawnBridge

@state0:
@state2:
	asm15 scriptHelp.checkActiveTriggersChanged
	scriptjump dungeonScript_spawnPyramidBridge

@spawnBridge:
	asm15 scriptHelp.spawnPyramidBridge
	setsubstate $02
	scriptjump dungeonScript_spawnPyramidBridge

@despawnBridge:
	wait 60
	playsound SND_BIGSWORD
	settileat $3c, $b0
	wait 10
	settileat $4c, $f4
	wait 10
	playsound SND_BIGSWORD
	settileat $5c, $f4
	wait 10
	settileat $6c, $f4
	wait 10
	playsound SND_BIGSWORD
	settileat $7c, $b2
	playsound SND_BIGSWORD
	setsubstate $00
	scriptjump dungeonScript_spawnPyramidBridge

; Spawn stairs to the bracelet room when the two torches are lit.
spiritsGraveScript_stairsToBraceletRoom:
	stopifroomflag80set
	;asm15 scriptHelp.makeTorchesLightable
	checkmemoryeq wNumTorchesLit, $02
	orroomflag ROOMFLAG_80;$80
	playsound SND_SOLVEPUZZLE
	asm15 objectCreatePuff
	settilehere TILEINDEX_INDOOR_DOWNSTAIRCASE
	scriptend

ancientTombScript_retractWall:
	stopifroomflag40set
	;checkmemoryeq wActiveTriggers, $01
	disableinput
	wait 30
	asm15 scriptHelp.ancientTomb_startWallRetractionCutscene
	scriptend

dungeonScript_activeTriggerIfTorchLit:
@checkTorchesLit:
	jumptable_memoryaddress wNumTorchesLit
	.dw @unlitTorches
	.dw @litTorches
	.dw @litTorches

@litTorches:
	ormemory wActiveTriggers $01
	scriptjump @checkTorchesLit
@unlitTorches:
	writememory wActiveTriggers $00
	scriptjump @checkTorchesLit

dungeonScript_checkActiveTriggersEq01_spawnStaircase:
	stopifroomflag80set
	checkmemoryeq wActiveTriggers $01
	wait 30
	checktext

	wait 60
	playsound SND_DOORCLOSE
	wait 60
	playsound SND_DOORCLOSE
	wait 60
	createpuff
	playsound SND_SOLVEPUZZLE
	orroomflag ROOMFLAG_80
	settilehere $47;TILEINDEX_INDOOR_DOWNSTAIRCASE
	scriptend

dungeonScript_bossKeyRoom:
	stopifitemflagset
	jumpifroomflagset ROOMFLAG_80, @spawnBossKey
	checkmemoryeq wActiveTriggers $0e ;bits 1-3
	checkmemoryeq wNumTorchesLit $04

	orroomflag ROOMFLAG_80
@spawnBossKey:
	playsound SND_SOLVEPUZZLE
	spawnitem TREASURE_BOSS_KEY $01
	wait 30
	stopifitemflagset
	spawnitem TREASURE_BOSS_KEY $02
	scriptend
	
dungeonScript_checkActiveTriggersEq01_spawnHole:
	stopifroomflag40set
	checkmemoryeq wActiveTriggers, $01
	playsound SND_SOLVEPUZZLE
	createpuff
	wait 15
	settilehere $45 ; fallable hole
	orroomflag ROOMFLAG_40
	scriptend


/*
spiritsGraveScript_spawnMovingPlatform:
	checkflagset $01, wActiveTriggers
	setcoords $58, $20;$48, $78
	asm15 objectCreatePuff
	setcoords $68, $20;$58, $78
	asm15 objectCreatePuff
	wait 30
	spawninteraction INTERAC_MOVING_PLATFORM, $05, $60, $20 ;$50, $78
	playsound SND_SOLVEPUZZLE
	scriptend
*/