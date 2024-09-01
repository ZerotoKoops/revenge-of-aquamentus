clockCutscenesHandler:
    ld a,(wTimeOfDay)
    rst_jumpTable
    .dw dawnToDayCutscene
    .dw dawnDuskCutscene
    .dw duskToNightCutscene
    .dw dawnDuskCutscene

dawnDuskCutscene:
    ld a,(wTilesetFlags)
    and TILESETFLAG_OUTDOORS
    jp z,endCutscene
    ld a,(wCutsceneState)
    rst_jumpTable
    .dw @state0
    .dw @state1
    .dw endCutscene

@state0:
	ld a,(wPaletteThread_mode)
	cpa $00
	ret nz
    call disableObjects   
; clear cutscene variables
	ld b,$20
	ld hl,wTmpcfc0.genericCutscene.state
	call clearMemory  
    ld a,(wActiveRoom)
; Guru Guru
    cp <ROOM_SEASONS_021
    jr z,+
	ld a,SNDCTRL_MEDIUM_FADEOUT
	call playSound  
+
	jp incCutsceneState

@state1:
	call incCutsceneState

.ifdef ROM_AGES
    call checkForDawnDuskPaletteExceptions
    ret c

	ld hl,$de90
	ld bc,paletteData4b50;4a30
	call func_13c6
	lda PALH_33
.else ; ROM_SEASONS

; Check for in Dark Forest
    ld a,(wTilesetPalette)
    cpa PALH_TILESET_TARM_RUINS_SPRING
    jr nz,+
    ld a,$02
    jr @@loadTransitionData

+
    xor a ; clear carry flag
    ld a,(wTimeOfDay)
    rra
@@loadTransitionData:
    ld hl,@paletteData
    ld b,a
    add a
    add a
    add b
    rst_addAToHl
    ldi a,(hl)
    ld c,a
    ldi a,(hl)
    ld b,a
    ldi a,(hl)
    push hl
    ld h,(hl)
    ld l,a

	call func_13c6

    pop hl
    inc hl
    ld a,(hl)
.endif
	call loadPaletteHeader
    callab bank1.updateGrassAnimationModifier
    ret

;;
; word: transition to
; word: transition from
; byte: new palette header
@paletteData:
; Spring
    .dw paletteData4e00 paletteData49b0
    .db PALH_TILESET_TARM_RUINS_AUTUMN
; Summer
    .dw paletteData4e30 paletteData4dd0
    .db PALH_TILESET_TARM_RUINS_WINTER
; Dark Wood Spring
    .dw paletteData4e00 paletteData4da0
    .db PALH_TILESET_TARM_RUINS_AUTUMN

endCutscene:
	ld a,(wPaletteThread_mode)
	cpa $00
	ret nz
    ;lda $00
    ld (wDisabledObjects),a
    ld (wDisableWarpTiles),a
    ld (wDisableScreenTransitions),a
    ld (wMenuDisabled),a

	ld a,CUTSCENE_INGAME
	ld (wCutsceneIndex),a
	ret   


dawnToDayCutscene:
duskToNightCutscene:
    ld a,(wCutsceneState)
    rst_jumpTable
    .dw @state0
    .dw @state1
    .dw waitForText
    .dw @state3
    .dw endCutscene

@state0:
	call retIfTextIsActive
	ld a,(wPaletteThread_mode)
	cpa $00
	ret nz

    call disableObjects

	ld b,$10
	ld hl,wGenericCutscene.cbb3
	call clearMemory  
    ld a,60
    ld (wGenericCutscene.cbb7),a
; clear cutscene variables
	call incCutsceneState  
    ;ld a,(wTilesetFlags)
    ;and TILESETFLAG_OUTDOORS
    ;ret z
	jp fadeoutToBlack
    
@state1:
    call decCbb7
    ret nz

    ld (hl),100
    call incCutsceneState

; clear Beach item - would pop up after transition if Link is in correct room
    call checkIsAtBeach
    call c,clearInteractions

    lda $01
    ld (wTextboxPosition),a
	lda TEXTBOXFLAG_ALTPALETTE1|TEXTBOXFLAG_DONTCHECKPOSITION
	ld (wTextboxFlags),a
.ifdef ROM_AGES
    ld b,>TX_0210
.else ; ROM_SEASONS
    ld b,>TX_020b
.endif
; $00 - $05 depending on day and day/night
    call getDayNightCombination

.ifdef ROM_AGES
    add <TX_0210
.else ; ROM_SEASONS
    add <TX_020b
.endif
    ld c,a
    jp showTextNonExitable

@state3:
    call retIfTextIsActive

    call incCutsceneState
.ifdef ROM_AGES
    ld a,(wTilesetFlags)
    and TILESETFLAG_OUTDOORS
    jr z,++
    ;ret z
.else ; ROM_SEASONS
    callab bank1.updateSeasonByRoomPack
    ;ld a,(wTimeOfDay) ; clock
	;rra	;$00 if day, $01 if night
    ;ld (wRoomStateModifier),a

    ld a,(wActiveGroup)
    cpa >ROOM_SEASONS_000
    jr nz,++
    ;ret nz
.endif


;reload tileset for change in time of day
    callab bank1.cutsceneTimeOfDay_reloadRoom
++
    call reloadTileMap
    callab bank1.checkDarkenRoomAndClearPaletteFadeState ;temp?
    jr z,+
    call fadeinFromWhiteToRoom
    or h ; just so the next call is not used
+
    call z,fadeinFromBlack

    call checkIsAtBeach
    jr nc,+
; respawns buried beach item
    call getFreeInteractionSlot
    jr nz,+
    ld (hl),INTERAC_ROSA
    inc l
    ld (hl),$02
+
; Only reset music if in overworld
    ld a,(wActiveGroup)
    cpa >ROOM_SEASONS_000
    ret nz
    ld a,(wActiveRoom)
    cpa <ROOM_SEASONS_021
    ret z
    ;call loadScreenMusic
    callab bank1.checkPlayRoomMusic
    ld a,SNDCTRL_MEDIUM_FADEIN
	jp playSound 

waitForText:
	ld a,(wTextIsActive)
	rlca
	ret nc

	ld a,(wPaletteThread_mode)
	cpa $00
	ret nz

    ld hl,wGenericCutscene.cbb7
    dec (hl)
    ret nz

; get rid of textbox (have to reload tilemap)
    ld (wTextboxFlags),a
    call stopTextThread
	jp incCutsceneState

disableObjects:
    lda $83
    ld (wDisabledObjects),a
    ld (wDisableWarpTiles),a
    ld (wDisableScreenTransitions),a
    ld (wMenuDisabled),a 
    ret

;;
; sets c flag if at beach
checkIsAtBeach:
    ld a,(wActiveGroup)
    cpa >ROOM_SEASONS_033
    jr nz,++
    ld a,(wActiveRoom)
    cp <ROOM_SEASONS_033
    jr c,++
    cp <ROOM_SEASONS_034
    jr z,+
    cp <ROOM_SEASONS_043
    jr z,+
    cp <ROOM_SEASONS_044
    jr nz,++
+
    scf
    ret
++
    xor a
    ret

clockCutsceneSongOfTime:
clockCutsceneOutOfTime:
    ld a,(wCutsceneState)
    or a
    call nz,updateParts

    ld a,(wCutsceneState)
    rst_jumpTable
    .dw @state0
    .dw @state1
    .dw @state2
    .dw @state3
    .dw waitForText
    .dw @state5
    .dw @state6
    .dw endCutscene

@state0:
	ld a,(wPaletteThread_mode)
	cpa $00
	ret nz
    call disableObjects   
; clear cutscene variables
	ld b,$20
	ld hl,wTmpcfc0.genericCutscene.state
	call clearMemory  
; Maku cutscene fadeout
    call hideStatusBar
    ld a,$02
    call fadeoutToBlackWithDelay
	ld a,$ff
	ld (wDirtyFadeBgPalettes),a
	ld (wFadeBgPaletteSources),a
	ld a,$01
	ld (wDirtyFadeSprPalettes),a
	ld a,$fe
	ld (wFadeSprPaletteSources),a
    jp incCutsceneState

@state1:
	ld a,(wPaletteThread_mode)
	cpa $00
	ret nz

    ld a,SNDCTRL_FAST_FADEOUT
    call playSound

; clear everything except Link
    call clearEnemies
    call clearParts
    call clearItems
    call clearInteractions

@giveBackJewels:
    ld hl,wInsertedJewels
    ld c,$03
-
    ld a,c
    call checkFlag
    jr z,@@nextJewel
    push bc
    ld a,c
    add TREASURE_ROUND_JEWEL
    ld c,$00
    call giveTreasure
    pop bc
@@nextJewel:
    dec c
    ld a,c
    cpa $ff
    jr nz,-

; clear everything obtained
    callab fileManagement.outOfTimeVariables

@clearRoomFlags:
    ld e,$05
--
    ld hl,@itemRooms
    ld a,e
    dec a
    rst_addDoubleIndex

    ldi a,(hl)
    ld h,(hl)
    ld l,a
; hl == first room
-
    ldi a,(hl)
    or a
    jr z,@@nextGroup
    ld b,a
    push hl
    ld a,>wGroup0RoomFlags
    add e
    dec a
    ld h,a
    ld l,b
    ld a,(hl)
    and $10 ;not item, not 40, not 80, not directional key doors
    ld (hl),a
    pop hl
    jr -

@@nextGroup:
    dec e
    jr nz,--

    lda $00
    ld hl,wDisplayedRupees
    ldi (hl),a
    ld (hl),a
    ld b,$08
    ld hl,wD6RupeeRoomRupees
    call clearMemory

    ld a,$ff
    ld (wSeedTreeRefilledBitset),a

    ld a,15
@setCounter:
    ld (wGenericCutscene.cbb7),a
    jp incCutsceneState


@itemRooms:
    .dw @@group0
    .dw @@group1
    .dw @@group4
    .dw @@group5

@@group0:
    ;.db <ROOM_SEASONS_010 ;L2 sword
    .db <ROOM_SEASONS_042 ;rupees
    .db $00

; groups 1, 2, 3
@@group1:
    .db <ROOM_SEASONS_385 ;mayor rupees
    .db $00

; groups 4, 6
@@group4:
    .db <ROOM_SEASONS_40a ;upper corner jewel room
    .db <ROOM_SEASONS_40b ;rupees
    .db <ROOM_SEASONS_40c ;bombable wall to rupee room
    .db <ROOM_SEASONS_40d ;rupee room
    ;.db <ROOM_SEASONS_40e ;compass
    .db <ROOM_SEASONS_40f ;small key block
    .db <ROOM_SEASONS_411 ;keese above hole stairs
    .db <ROOM_SEASONS_412 ;retraction wall
    .db <ROOM_SEASONS_413 ;facade small key
    .db <ROOM_SEASONS_416 ;rupees
    .db <ROOM_SEASONS_418 ;floor masters stairs
    .db <ROOM_SEASONS_41a ;small key block
    .db <ROOM_SEASONS_41b ;roller torches stairs
    .db <ROOM_SEASONS_41c ;entrance small key block
    .db <ROOM_SEASONS_41d ;small key block
    .db <ROOM_SEASONS_41e ;torches small key
    .db <ROOM_SEASONS_420 ;owl small key
    .db <ROOM_SEASONS_421 ;mimics small key
    .db <ROOM_SEASONS_422 ;moblins stairs
    .db <ROOM_SEASONS_423 ;directional key door
    .db <ROOM_SEASONS_424 ;underwater small key
    .db <ROOM_SEASONS_425 ;swimming challenge small key
    .db <ROOM_SEASONS_427 ;boss key
    .db <ROOM_SEASONS_42a ;directional key door
    .db <ROOM_SEASONS_42b ;ice block puzzle
    .db <ROOM_SEASONS_42c ;jumping platform
    .db <ROOM_SEASONS_42e ;small key
    .db <ROOM_SEASONS_430 ;rupees
    ;.db <ROOM_SEASONS_432 ;map
    .db <ROOM_SEASONS_4f1 ;rupees
    .db <ROOM_SEASONS_4fd ;torch puzzle
    .db <ROOM_SEASONS_63e ;small key
    .db <ROOM_SEASONS_653 ;rupees
    .db $00

; groups 5, 7
@@group5:
    .db $00

@state2:
    call decCbb7
    ret nz

    ld a,SND_TRANSFORM
    call playSound
    ld a,30
    jp @setCounter

@state3:
    call decCbb7
    ret nz

    ld a,MUS_ROOM_OF_RITES
    call playSound

    ;lda $01
    ;ld (wTextboxPosition),a
	lda TEXTBOXFLAG_ALTPALETTE1;|TEXTBOXFLAG_DONTCHECKPOSITION
	ld (wTextboxFlags),a
    ld a,10
    call @setCounter
    ld bc,TX_173b
    jp showTextNonExitable

@state6:
    ;call decCbb7
    ;ret nz
    call incCutsceneState
    call fadeinFromBlack
    call showStatusBar
    ld a,$ff
    ld (wStatusBarNeedsRefresh),a
    call updateStatusBar
    call clearPaletteFadeVariablesAndRefreshPalettes
    lda LINK_STATE_NORMAL ;$01
    ld (wLinkForceState),a
    ld (wLinkDeathTrigger),a
    ret

@state5:
    call retIfTextIsActive

    ld de,wGenericCutscene.cbb8
    ld a,(de)
    rst_jumpTable
    .dw @@cbb8_0
    .dw @@cbb8_1
    .dw @@cbb8_2
    .dw @@cbb8_3

@@cbb8_0:
    call incCbb8
    lda $01;%00010111
    ld (wDisabledObjects),a
    call reloadTileMap
    call @createLightning
    ld a,30
-
    ld (wGenericCutscene.cbb7),a
    ret

@@cbb8_1:
    call decCbb7
    ret nz
    call incCbb8
    call @createLightning
    ld a,15
    jr -

@@cbb8_2:
    call decCbb7
    ret nz
    call incCbb8
    call @createLightning
    ld a,30
    jr -

@@cbb8_3:
    call decCbb7
    ret nz
    lda $00
    ld (hl),a
    lda $83
    ld (wDisabledObjects),a
    jp incCutsceneState

@createLightning:
    call getFreePartSlot
    ret nz
    ld (hl),PART_LIGHTNING
    inc l
    inc (hl)
    inc l
    inc (hl)

    ld de,w1Link.yh
    ld l,Part.yh
    ld a,(de)
    ldi (hl),a
    inc l
    ld e,<w1Link.xh
    ld a,(de)
    ld (hl),a
    ret

decCbb7:
    ld hl,wGenericCutscene.cbb7
    dec (hl)
    ret

incCbb8:
    ld a,(de)
    inc a
    ld (de),a
    ret
