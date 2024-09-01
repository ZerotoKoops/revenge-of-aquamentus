updateClock:
; second
	ld hl,wSecond
; skip ahead time
    ld a,(wTimeFlags)
    bit TIMEFLAG_BIT_SUNS_SONG,a
    jr nz,++

    dec (hl)
    jr nz,@refreshStatusBar
; minute
    push hl
    ld a,(wTimeOfDay)
    and TIME_NIGHT ;$02
    ld b,a
    ld a,(wTimeFlags)
    and TIMEFLAG_SLOW_TIME ;slow flag
    add b
    ld hl,@secondSpeeds
    rst_addAToHl
    ld b,(hl)
    pop hl
+
    ld (hl),b
++
    inc l
    call incDecimalHlRef
    ld a,$60
    cp (hl)
    jr nz,@return
; hour
    ld (hl),$00
    inc l
    call incDecimalHlRef
    ld a,$24
    cp (hl)
    jr nz,@return

    ld (hl),$00
@return:
    scf

@refreshStatusBar:
    ld hl,wStatusBarNeedsRefresh
    set 5,(hl)
    ret

; $00 if day and normal
; $01 if day and slow
; $02 if night and normal
; $03 if night and slow
@secondSpeeds:
    .db 60 100 30 50

updateDayOrNight:
    ld hl,wClock
    ldi a,(hl)
    ld b,(hl)
    ld c,a
    ld hl,@times
-
    ldi a,(hl)
    push hl
    ld h,(hl)
    ld l,a
    call compareHlToBc
    pop hl
    inc l
    jr nc,@foundTimeOfDay
    inc l
    jr -

@foundTimeOfDay:
    ld a,(wTimeOfDay)
    cp (hl)
    ret z

; Reset Sun's Song time skip if reached day or night
    bit 0,(hl)
    jr nz,+
    ld a,(wTimeFlags)
    res TIMEFLAG_BIT_SUNS_SONG,a
    ld (wTimeFlags),a
+
    ld a,(w1Link.state)
    cp LINK_STATE_NORMAL
    ret nz

.ifdef ROM_AGES
    lda CUTSCENE_CHANGE_TIME_OF_DAY
.else ;ROM_SEASONS
    lda CUTSCENE_S_CHANGE_TIME_OF_DAY
.endif
    ld (wCutsceneTrigger),a

    ld a,(hl)
    ld (wTimeOfDay),a
    cpa TIME_DAY
    ret nz

    ld hl,wDay
    ld a,$03
    cp (hl)
    jp nz,incDecimalHlRef
    lda CUTSCENE_S_OUT_OF_TIME
    ld (wCutsceneTrigger),a ;wCutsceneTrigger?
    ret

;;
; word: time of day
; byte: what to set day or night to if clock is less than this time
@times:
    dwb $0459 TIME_NIGHT ;TIME_03_59
    dwb TIME_05_59 TIME_DAWN
    dwb $1659 TIME_DAY ;TIME_15_59
    dwb TIME_17_59 TIME_DUSK
    dwb TIME_23_59 TIME_NIGHT

; cutscene to transition the time of day
cutsceneTimeOfDay:
    call func_1613
	jpab bank3Cutscenes.clockCutscenesHandler   
cutsceneOutOfTime:
    call func_1613
	jpab bank3Cutscenes.clockCutsceneOutOfTime   
cutsceneSongOfTime:
    call func_1613
	jpab bank3Cutscenes.clockCutsceneSongOfTime   

checkIsNightOutdoors:
    ld a,(wTimeOfDay)
    and TIME_NIGHT
    ret z
    ld a,(wTilesetFlags)
    and TILESETFLAG_OUTDOORS
    ret

cutsceneTimeOfDay_reloadRoom:
	call disableLcd
	call clearOam
    call reloadTileMap

.ifdef ROM_AGES
    ld a,(wTimeOfDay)
    cpa TIME_DAY
    ld a,(wTilesetPalette)
    jr z,+
	ld a,PALH_99
+
	call loadPaletteHeader
.endif
    call clearScreenVariables
    call clearMemoryOnScreenReload

	call loadTilesetData
	call loadTilesetGraphics
	call loadTilesetAndRoomLayout
	call generateVramTilesWithRoomChanges

    ld a,(wActiveRoom)
	ld (wLoadingRoom),a
	call loadRoomCollisions

    call func_131f
	ld de,w1Link.yh
	call getShortPositionFromDE
	ld (wWarpDestPos),a

	;call initializeRoom ; doubles objects if not cleared prior
	call checkDisplayEraOrSeasonInfo
    call updateGrassAnimationModifier
	call checkDarkenRoomAndClearPaletteFadeState

    ;call func_593a ; this updates Link's local respawn 
    call loadCommonGraphics
    ld a,$02
    call loadGfxRegisterStateIndex
    jp resetCamera