;;
; Called from loadTilesetData in bank 0. Function differs substantially in Ages and Seasons.
;
; HACK-BASE: This has been modified for the expanded tilesets patch.
loadTilesetData_body:
	call getTempleRemainsSeasonsTilesetData
	jr c,@gotTilesetIndex
	call getMoblinKeepSeasonsTilesetData
	jr c,@gotTilesetIndex

	; HACK-BASE: Use hFF8B to store the "layout group override"
	ld a,$ff
	ldh (<hFF8B),a

	ld a,(wActiveGroup)
	ld hl,roomTilesetsGroupTable
	rst_addDoubleIndex
	ldi a,(hl)
	ld h,(hl)
	ld l,a
	ld a,(wActiveRoom)
	rst_addAToHl
	ld a,(hl)
	ld (wTilesetIndex),a

@gotTilesetIndex:
	ld a,(wTilesetIndex)
	and $7f
	call multiplyABy8
	ld hl,tilesetData
	add hl,bc

	; If it's a seasonal tileset, then dereference the next pointer
	ld a,(hl)
	inc a
	jr nz,@gotTilesetData
	inc hl
	ldi a,(hl)
	ld h,(hl)
	ld l,a
	ld a,(wRoomStateModifier)
	;and $01 ; clock
	call multiplyABy8
	add hl,bc

@gotTilesetData:
	ldi a,(hl)
	ld e,a
	and $0f
	cp $0f
	jr nz,+
	ld a,$ff
+
	ld (wDungeonIndex),a
	ld a,e
	swap a
	and $0f
	ld (wActiveCollisions),a

	ldi a,(hl)
	ld (wTilesetFlags),a

	ld b,$05
	ld de,wTilesetIndex + 1
	inc hl
@copyloop:
	ldi a,(hl)
	ld (de),a
	inc e
	dec b
	jr nz,@copyloop

	; HACK-BASE: Set wLayoutGroupOverride (usually $ff for no override)
	ldh a,(<hFF8B)
	ld (wLayoutGroupOverride),a

	; For gnarled root dungeon entrance: load "unique graphics" when opened
	; HACK-BASE: TODO TODO TODO FIXME FIXME FIXME
	;; ld a,(wActiveGroup)
	;; or a
	;; ret nz
	;; ld a,(wActiveRoom)
	;; cp <ROOM_SEASONS_096
	;; ret nz
	;; call getThisRoomFlags
	;; and $80
	;; ret nz
	;; ld a,$20
	;; ld (wTilesetUniqueGfx),a
	ret

getTempleRemainsSeasonsTilesetData:
	ld a,GLOBALFLAG_TEMPLE_REMAINS_FILLED_WITH_LAVA
	call checkGlobalFlag
	ret z

	call checkIsTempleRemains
	ret nc

	; HACK-BASE: This value will go to wLayoutGroupOverride (read from subrosia map).
	; Normally it uses a modified tileset to set a different layout group, but we no longer
	; allow tilesets to set the layout group themselves because of how incredibly confusing it
	; is.
	ld a,$04
	ldh (<hFF8B),a

	; Use this tileset
	ld a,$17
	ld (wTilesetIndex),a
	scf
	ret

; @param[out]	cflag	set if active room is temple remains
checkIsTempleRemains:
	ld a,(wActiveGroup)
	or a
	ret nz
	ld a,(wActiveRoom)
	cp $14
	jr c,+
	sub $04
	cp $30
	ret nc
	and $0f
	cp $04
	ret
+
	xor a
	ret

getMoblinKeepSeasonsTilesetData:
	ld a,(wActiveGroup)
	or a
	ret nz

	call getMoblinKeepScreenIndex
	ret nc

	ld a,GLOBALFLAG_MOBLINS_KEEP_DESTROYED
	call checkGlobalFlag
	ret z

	; HACK-BASE: This value will go to wLayoutGroupOverride (read from spring map).
	; Same deal as temple remains code above.
	ld a,$00
	ldh (<hFF8B),a

	; Use this tileset
	ld a,$1a
	ld (wTilesetIndex),a
	scf
	ret

;;
; @param[out]	cflag	Set if active room is in Moblin keep
getMoblinKeepScreenIndex:
	ld a,(wActiveRoom)
	ld b,$05
	ld hl,moblinKeepRooms
-
	cp (hl)
	jr z,+
	inc hl
	dec b
	jr nz,-
	xor a
	ret
+
	scf
	ret

moblinKeepRooms:
	.db $5b $5c $6b $6c $7b
