;;
; ITEM_FLUTE ($0e)
; ITEM_HARP ($11)
parentItemCode_flute:
;parentItemCode_harp:
	ld e,Item.state
	ld a,(de)
	rst_jumpTable
	.dw @state0
	.dw @state1

@state0:
	call checkLinkOnGround
	jp nz,clearParentItem
	ld a,(wInstrumentsDisabledCounter)
	or a
	jp nz,clearParentItem
	call isLinkInHole
	jp c,clearParentItem
	call checkNoOtherParentItemsInUse
	jp nz,clearParentItem

	ld a,$80
	ld (wcc95),a
	ld a,$ff ~ DISABLE_LINK ~ DISABLE_ALL_BUT_INTERACTIONS
	ld (wDisabledObjects),a

	call parentItemLoadAnimationAndIncState

	; Determine what sound to play
	ld b,$00
	call @getSelectedSongAddr
	jr z,+
	ld b,$03
+
	ld a,(hl)
	add b
	ld hl,@sfxList
	rst_addAToHl
	ld a,(hl)
	call playSound

@state1:
	ld hl,w1Link.collisionType
	res 7,(hl)

	; Create floating music note every $20 frames
	call itemDecCounter1
	ld a,(hl)
	and $1f
	jr nz,++

	ld l,Item.animParameter
	bit 0,(hl)
	ld bc,$fcf8
	jr z,+
	ld c,$08
+
	call getRandomNumber
	and $01
	push de
	ld d,>w1Link
	call objectCreateFloatingMusicNote
	pop de
++
	call specialObjectAnimate_optimized
	call @getSelectedSongAddr

	ld a,$ff
	jr z,+
	ld a,(hl)
+
	ld (wLinkPlayingInstrument),a
	ld (wLinkRidingObject),a
	ld c,$80
	jr nz,++

	ld a,(hl)
	or a
	jr nz,++
	ld c,$40
++
	ld e,Item.animParameter
	ld a,(de)
	and c
	ret z

; Done playing song

	ld hl,w1Link.collisionType
	set 7,(hl)

	call @getSelectedSongAddr
	jr nz,@harp

	; Flute: try to spawn companion
	ldbc INTERAC_COMPANION_SPAWNER, $80
	call objectCreateInteraction

@clearSelf:
	xor a
	ld (wDisabledObjects),a
	ld (wcc95),a
	jp clearParentItem


.ifdef ROM_AGES ; Harp code

@tuneEchoesInVain:
	ld bc,TX_5110
	call showText
	jr @clearSelf

.endif

@harp:
.ifdef ROM_SEASONS
	jr @clearSelf
.else
	; Only allow harp playing on overworld, non-maku tree screens
	ld a,(wTilesetFlags)
	and (TILESETFLAG_UNDERWATER|TILESETFLAG_SIDESCROLL|TILESETFLAG_LARGE_INDOORS|TILESETFLAG_DUNGEON|TILESETFLAG_INDOORS|TILESETFLAG_MAKU)
	jr nz,@clearSelf

	ld a,(hl)
	rst_jumpTable
	.dw @clearSelf
	.dw @tuneOfEchoes
	.dw @tuneOfCurrents
	.dw @tuneOfAges

@tuneOfEchoes:
	call getThisRoomFlags
	bit ROOMFLAG_BIT_PORTALSPOT_DISCOVERED,(hl)
	jr nz,@clearSelf
	jr @tuneEchoesInVain

@tuneOfCurrents:
	; Test TILESETFLAG_BIT_PAST
	ld a,(wTilesetFlags)
	rlca
	jr nc,@tuneEchoesInVain

@tuneOfAges:
	call restartSound

	ld a,CUTSCENE_TIMEWARP
	ld (wCutsceneTrigger),a

	ld a,DISABLE_LINK|DISABLE_ENEMIES|DISABLE_8|DISABLE_COMPANION|DISABLE_40
	ld (wDisabledObjects),a
	ld (wDisableLinkCollisionsAndMenu),a
	ld (wcde0),a
	call clearAllItemsAndPutLinkOnGround
	jp specialObjectAnimate_optimized
.endif


@sfxList:
	.db SND_FILLED_HEART_CONTAINER
	.db SND_FLUTE_RICKY
	.db SND_FLUTE_DIMITRI
	.db SND_FLUTE_MOOSH
.ifdef ROM_AGES
	.db SND_TUNE_OF_ECHOES
	.db SND_TUNE_OF_CURRENTS
	.db SND_TUNE_OF_AGES
.else
	; CROSSITEMS: For now we're putting placeholder sounds for the harp songs in seasons
	.db SND_FILLED_HEART_CONTAINER
	.db SND_FILLED_HEART_CONTAINER
	.db SND_FILLED_HEART_CONTAINER
.endif

;;
; @param[out]	hl	wFluteIcon or wSelectedHarpSong
; @param[out]	zflag	Set if using flute, unset for harp
@getSelectedSongAddr:
	ld hl,wFluteIcon
	ld e,Item.id
	ld a,(de)
	cp ITEM_FLUTE

	ret z
	ld l,<wSelectedHarpSong
	ret

parentItemCode_harp:
	ld e,Item.state
	ld a,(de)
	rst_jumpTable
	.dw @state0
	.dw @state1
	.dw @state2
	.dw @state3
	.dw @state4
	.dw @state5
	.dw @state6

@state0:
	call checkLinkOnGround
	jp nz,clearParentItem
	ld a,(wInstrumentsDisabledCounter)
	or a
	jp nz,clearParentItem
	call isLinkInHole
	jp c,clearParentItem
	call checkNoOtherParentItemsInUse
	jp nz,clearParentItem

	ld a,$80
	ld (wcc95),a
	ld a,$ff ~ DISABLE_LINK ~ DISABLE_ALL_BUT_INTERACTIONS
	ld (wDisabledObjects),a

	call parentItemLoadAnimationAndIncState	

	ld a,(wActiveMusic)
	cp SND_GETITEM
	jr nc,+
	ld a,$02
	call setMusicVolume
	ld a,$01
	call setMusicVolume
+
	ld a,Item.var34
	ld e,Item.var33
	ld (de),a
	ld a,$fe
	ld e,Item.var3c ; what to set wLinkPlayingInstrument less 1
	ld (de),a
	ret

;;
; Waiting for next note to play
@state1:
; Find current directional key just pressed
	ld a,(wKeysJustPressed)
	call getHighestSetBit
	jp nc,@stub
	rst_jumpTable
	.dw @@btnA
	.dw @@btnB
	.dw @@btnSelect
	.dw @stub
	.dw @@btnRight
	.dw @@btnLeft
	.dw @@btnUp
	.dw @@btnDown


@@btnB:
	ld a,$03
	jr @setState


@@btnSelect:
	ld e,Item.var32
	ld a,$01
	ld (de),a
	inc a ; ld a,$02
	jr @setState

@@btnA:
	ld a,SND_NOTE_D4
	jr @playSound
@@btnRight:
	ld a,SND_NOTE_A4
	jr @playSound
@@btnLeft:
	ld a,SND_NOTE_B4
	jr @playSound
@@btnUp:
	ld a,SND_NOTE_D5
	jr @playSound
@@btnDown:
	ld a,SND_NOTE_F4

@playSound:
; save note played in
	ld b,a
	call @getVar33
	jr nz,+
	ld (hl),l ;Item.var33
+
	inc (hl)
	ld a,b
	ld (de),a
	call playSound
	call @checkSong
@stub:
	call @setLinkPlayingInstrumentVar
	ld hl,w1Link.collisionType
	res 7,(hl)
@createFloatingNotes:
	; Create floating music note every $20 frames
	call itemDecCounter1
	ld a,(hl)
	and $1f
	jr nz,++
@@loadNote:
	ld l,Item.animParameter
	bit 0,(hl)
	ld bc,$fcf8
	jr z,+
	ld c,$08
+
	call getRandomNumber
	and $01
	push de
	ld d,>w1Link
	call objectCreateFloatingMusicNote
	pop de
++
	jp specialObjectAnimate

@setLinkPlayingInstrumentVar:
	ld e,Item.var3c
	ld a,(de)
	inc a
	ld (wLinkPlayingInstrument),a
	ld (wLinkRidingObject),a
	ret

@setState:
	ld e,Item.state
	ld (de),a
	lda $00
	inc e
	ld (de),a
	jp @stub

@getVar33:
	ld h,d
	ld l,Item.var33
	ld a,(hl)
	ld e,a
	cp Item.var3b
	ret

; finished playing
; reset music volume
@state3:
	ld a,(wActiveMusic)
	cp SND_GETITEM
	jr nc,+
	ld a,$02
	call setMusicVolume
	ld a,$03
	call setMusicVolume
+
; Done playing song
	call @setLinkPlayingInstrumentVar

	ld hl,w1Link.collisionType
	set 7,(hl)
	jp parentItemCode_flute@clearSelf


@state4:
	ld e,Item.counter2
	ld a,(de)
	cpa $00
	jp z,itemIncState
	dec a
	ld (de),a
	jp @stub

@state5:
	ld e,Item.var3c
	ld a,(de)
	rst_jumpTable
	.dw @state5_zeldasLullaby ;Zelda's Lullaby
	.dw @state5_eponasSong ;Epona's Song
	.dw @state5_stub ;Saria's Song
	.dw @state5_sunsSong
	.dw @state5_songOfTime
	.dw @state5_songOfStorms ;Song of Storms
	.dw @state5_songOfHealing
	.dw @state5_songOfSoaring ;Song of Soaring
	.dw @state5_songOfDoubleTime ;Song of Double Time
	.dw @state5_invertedSongOfTime ;Inverted Song of Time

;;
; Brings Link up to Gale Seed menu
; Really just spawns a gale seed for Link
@state5_songOfSoaring:
	call @playSong


	ld a,(wActiveGroup)
	cpa >ROOM_SEASONS_000
	jr z,@@overworld

	ld a,(wDungeonIndex)
	cpa $ff
	jr z,@@songJustEchoes

;dungeon
	call itemIncState
	ld bc,TX_021b
	jp showText

@@overworld:
	ld a,(wNumGaleSeeds)
	sub $01
	jr c,@@songJustEchoes
	daa
	ld (wNumGaleSeeds),a

	ldbc ITEM_GALE_SEED,$00
	ld e,$01
	call itemCreateChildWithID
	jr @goToState3

@@songJustEchoes:
	ld bc,TX_510f
	call showText
	jr @goToState3

@state6_songOfSoaring:
; assumes only in dungeon

	call @state6_checkTextOptions
	jr nz,@goToState3

	ld a,LINK_STATE_GRABBED_BY_WALLMASTER
	ld (wLinkForceState),a

	ld e,Item.state
	ld a,$03
	ld (de),a
	jp @state3

;;
;Skip to the next half day incrementally
@state5_sunsSong:
	ld hl,wTimeFlags
	bit 1,(hl)
	jr nz,@state5_stub
	; fall through

;;
; Actually skip forward in time
@state5_songOfDoubleTime:
	call itemIncState
	call @playSong
	call getDayNightCombination
	add <TX_0215
	ld c,a
	ld b,>TX_0215
	jp showText

@state5_stub:
	call @playSong
@goToState3:
	ld a,$03
	jp @setState

@state6_sunsSong:
	call @state6_checkTextOptions
	jr nz,@goToState3

	ld hl,wTimeFlags
	set TIMEFLAG_BIT_SUNS_SONG,(hl)
	jr @goToState3

@state6_songOfDoubleTime:
	call @state6_checkTextOptions
	jr nz,@goToState3

	ld bc,$0559
	ld hl,wClock
	ld a,(wTimeOfDay)
	and TIME_NIGHT
	jr nz,+
	ld b,$17
+
	ld (hl),c
	inc hl
	ld (hl),b
	jr @goToState3

;;
;Slow down time
@state5_invertedSongOfTime:
	ld a,(wTimeFlags)
	xor TIMEFLAG_SLOW_TIME
	ld (wTimeFlags),a
	call @playSong
	jr @goToState3

;;
;Heal Link once per cycle
@state5_songOfHealing:
	call @playSong

	ld hl,wTimeFlags
	bit TIMEFLAG_BIT_SONG_OF_HEALING_USED,(hl)
	jr nz,@goToState3

	set TIMEFLAG_BIT_SONG_OF_HEALING_USED,(hl)
	ld hl,wLinkMaxHealth
	ldd a,(hl)
	ld (hl),a
	jr @goToState3

;;
;Start playing the Song of Storms music
@state5_songOfStorms:
	call @playSong
	ld e,Item.direction
	lda $00
	ld (de),a
	inc e
	lda $02
	ld (de),a
	jp itemIncState

@state6_songOfStorms:
	ld h,d
	ld l,Item.direction
	dec (hl)
	jp nz,@stub

	ld (hl),50
	inc l
	dec (hl)
	jp nz,@stub 

	ld a,MUS_SONG_OF_STORMS
	call playSound
	jp @goToState3

;;
;Bring back to the first day
@state5_songOfTime:
	call itemIncState
	call @playSong
	ld bc,TX_0211
	jp showText

@state6_songOfTime:
	call @state6_checkTextOptions
	jr nz,+

	ld hl,wTimeFlags
	lda CUTSCENE_S_SONG_OF_TIME
	ld (wCutsceneTrigger),a
+
	ld e,Item.state
	ld a,$03
	ld (de),a
	jp @state3

;;
; Give Link a hint for each progression
@state5_zeldasLullaby:
	call itemIncState
	call @playSong
	ld bc,TX_100a
	jp showText

@state6_zeldasLullaby:
	call @state6_checkTextOptions
	jp nz,@goToState3

	callab seasonsInteractionsBank08.checkNPCStage
	ld a,b
	add <TX_100b
	ld c,a
	ld b,>TX_100b
	call showText
	jp @goToState3

;;
; Calls Ricky
@state5_eponasSong:
	; Flute: try to spawn companion
	ldbc INTERAC_COMPANION_SPAWNER, $80
	call objectCreateInteraction
	jp @state5_stub

@state6:
	ld e,Item.var3c
	ld a,(de)
	rst_jumpTable
	.dw @state6_zeldasLullaby ;Zelda's Lullaby
	.dw @state5_stub ;Epona's Song
	.dw @state5_stub ;Saria's Song
	.dw @state6_sunsSong
	.dw @state6_songOfTime
	.dw @state6_songOfStorms
	.dw @state5_stub ;Song of Healing
	.dw @state6_songOfSoaring ;Song of Soaring
	.dw @state6_songOfDoubleTime
	.dw @state5_stub ;Inverted Song of Time

@state6_checkTextOptions:
	ld a,(wTextIsActive)
	or a
	jr z,+
	pop af
	jp @stub
+
	ld a,(wSelectedTextOption)
	or a
	ret

@playSong:
	ld e,Item.var3c
	ld a,(de)
	add SND_ZELDAS_LULLABY
	jp playSound

@state2:
	ld a,(wKeysJustPressed)
	xor BTN_A|BTN_B
	call @@var32InB
	jr z,@@btnsBAndA

	ld a,(wKeysJustPressed)
	swap a
	call getHighestSetBit
	jp nc,@stub
	ld c,a
	rst_jumpTable
	.dw @@btnDirection
	.dw @@btnDirection
	.dw @@btnDirection
	.dw @@btnDirection
	.dw @@btnA
	.dw @@btnB
	.dw @@btnSelect
	.dw @@btnStart

@@btnsBAndA:
	add b
	jr +

@@btnA:
+
	add b
@@btnB:
	ld a,(wKeysPressed)
	and BTN_RIGHT|BTN_LEFT|BTN_UP|BTN_DOWN
	swap a
	call getHighestSetBit
	jp nc,@stub	
	jr @@getNoteAndPlaySound

@@btnDirection:
	;ld b,b
	ld a,(wKeysPressed)
	and BTN_A|BTN_B
	ld l,a
	inc l
	call @@var32InB
	xor a
-
	dec l
	jr z,+	
	add b
	jr -
+
	ld b,a
	ld a,c

@@getNoteAndPlaySound:
	ld hl,@@longNoteList
	rst_addAToHl
	ld a,(hl)
	add b
	jp @playSound

@@btnSelect:
	ld a,$01
	jp @setState

@@btnStart:
	ld e,Item.var32
	ld a,(de)
	xor $fe
	ld (de),a
	jp @stub

@@var32InB:
	ld e,Item.var32
	ld a,(de)
	ld b,a
	ret

@@longNoteList:
	.db SND_NOTE_F4 ; RIGHT
	.db SND_NOTE_A4 ; LEFT
	.db SND_NOTE_D5 ; UP
	.db SND_NOTE_D4 ; DOWN

@checkSong:
	call @getVar33
	ld hl,@@song00
	ld b,NUM_SONGS ; number of songs
--
	push de
	push bc
	ld c,SONG_LENGTH ; length of each song
-
	ldi a,(hl)
	or a
	jr z,@@rightNote

@@checkNote:
	ld b,a
	ld a,(de)
	cp b
	jr z,@@rightNote

@@wrongNote:
	dec c
	ld a,c
	rst_addAToHl
	pop bc
	pop de
	dec b
	jr nz,--
	ret

@@rightNote:
	inc e
	ld a,Item.var3c ; went too far
	cp e
	jr nz,+
	ld e,Item.var34
+
	dec c
	jr nz,-

@@correctSong:
	pop bc
	pop de

	ld a,NUM_SONGS ; number of songs
	sub b
	ld e,Item.var3c
	ld (de),a ; song played

	ld a,50
	ld e,Item.counter2
	ld (de),a

	ld a,$04
	jp @setState


; Zelda's Lullaby
@@song00:
	.db $00 $00
	.db SND_NOTE_B4 SND_NOTE_D5 SND_NOTE_A4
	.db SND_NOTE_B4 SND_NOTE_D5 SND_NOTE_A4

; Epona's Song
@@song01:
	.db $00 $00
	.db SND_NOTE_D5 SND_NOTE_B4 SND_NOTE_A4
	.db SND_NOTE_D5 SND_NOTE_B4 SND_NOTE_A4

; Saria's Song
@@song02:
	.db $00 $00
	.db SND_NOTE_F4 SND_NOTE_A4 SND_NOTE_B4
	.db SND_NOTE_F4 SND_NOTE_A4 SND_NOTE_B4

; Sun's Song
@@song03:
	.db $00 $00
	.db SND_NOTE_A4 SND_NOTE_F4 SND_NOTE_D5
	.db SND_NOTE_A4 SND_NOTE_F4 SND_NOTE_D5

; Song of Time
@@song04:
	.db $00 $00
	.db SND_NOTE_A4 SND_NOTE_D4 SND_NOTE_F4
	.db SND_NOTE_A4 SND_NOTE_D4 SND_NOTE_F4

; Song of Storms
@@song05:
	.db $00 $00
	.db SND_NOTE_D4 SND_NOTE_F4 SND_NOTE_D5
	.db SND_NOTE_D4 SND_NOTE_F4 SND_NOTE_D5

; Song of Healing
@@song06:
	.db $00 $00
	.db SND_NOTE_B4 SND_NOTE_A4 SND_NOTE_F4
	.db SND_NOTE_B4 SND_NOTE_A4 SND_NOTE_F4

; Song of Soaring
@@song07:
	.db $00 $00
	.db SND_NOTE_F4 SND_NOTE_B4 SND_NOTE_D5
	.db SND_NOTE_F4 SND_NOTE_B4 SND_NOTE_D5

; Song of Double Time
@@song08:
	.db $00 $00
	.db SND_NOTE_A4 SND_NOTE_A4 SND_NOTE_D4
	.db SND_NOTE_D4 SND_NOTE_F4 SND_NOTE_F4

; Inverted Song of Time
@@song09:
	.db $00 $00
	.db SND_NOTE_F4 SND_NOTE_D4 SND_NOTE_A4
	.db SND_NOTE_F4 SND_NOTE_D4 SND_NOTE_A4
