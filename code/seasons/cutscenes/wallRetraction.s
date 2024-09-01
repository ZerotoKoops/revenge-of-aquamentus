
;;
; CUTSCENE_WALL_RETRACTION
/*func_701d:
	ld a,(wDungeonIndex)
	cp $08
	jp z,wallRetraction_dungeon8

	; D6 wall retraction
	ld a,(wCutsceneState)
	rst_jumpTable
	.dw @state0
	.dw @state1

@state0:
	ld a,GFXH_MERMAIDS_CAVE_WALL_RETRACTION
@func_702f:
	call loadGfxHeader
	ld b,$10
	ld hl,wTmpcbb3
	call clearMemory
	call reloadTileMap
	call resetCamera
	call getThisRoomFlags
	set 6,(hl)
	call loadTilesetAndRoomLayout
	ld a,$3c
	ld (wTmpcbb4),a
	xor a
	ld (wScrollMode),a
	jr cutscene_incState
@state1:
	ld a,(wTmpcbb3)
	rst_jumpTable
	.dw @cbb3_00
	.dw @cbb3_01
@cbb3_00:
	call cutscene_tickDownCBB4ThenSetTo30
	ret nz
	ld (hl),$3c
	jr cutscene_incCBB3
@cbb3_01:
	ld a,$3c
	call setScreenShakeCounter
	call cutscene_tickDownCBB4ThenSetTo30
	ret nz
	ld (hl),$19
	callab tilesets.generateW3VramTilesAndAttributes
	ld bc,$260c
	call func_70f7
	xor a
	ld ($ff00+R_SVBK),a
	call reloadTileMap
	ld a,SND_DOORCLOSE
	call playSound
	ld hl,$cbb7
	inc (hl)
	ld a,(hl)
	cp $0f
	ret c
	call endWallRetractionCutscene
	ld a,$0f
	ld ($ce5d),a
	ret
*/
cutscene_tickDownCBB4ThenSetTo30:
	ld hl,$cbb4
	dec (hl)
	ret nz
	ld (hl),30
	ret
	
cutscene_incState:
	ld hl,wCutsceneState
	inc (hl)
	ret
	
cutscene_incCBB3:
	ld hl,wTmpcbb3
	inc (hl)
	ret

cbb3_00:
	call cutscene_tickDownCBB4ThenSetTo30
	ret nz
	ld (hl),$3c
	jr cutscene_incCBB3	

endWallRetractionCutscene:
	ld a,SND_SOLVEPUZZLE
	call playSound
	ld a,CUTSCENE_INGAME
	ld (wCutsceneIndex),a
	ld a,$01
	ld (wScrollMode),a
	xor a
	ld (wDisabledObjects),a
	ld (wMenuDisabled),a
	call loadTilesetAndRoomLayout
	jp loadRoomCollisions


wallRetraction:
	ld a,(wCutsceneState)
	rst_jumpTable
	.dw @state0
	.dw @state1
@state0:
	ld a,GFXH_DUNGEON_WALL_RETRACTION
@func_702f:
	call loadGfxHeader
	ld b,$10
	ld hl,wTmpcbb3
	call clearMemory

	ld a,TILEINDEX_PUSHABLE_STATUE
	call findTileInRoom
-
	ld a,l
	ldh (<hFF8C),a
	push hl
	call objectCreatePuff
	ldh a,(<hFF8C)
	ld l,Interaction.yh
	call setShortPosition
	ldh a,(<hFF8C)
	ld c,a
	ld a,TILEINDEX_STANDARD_FLOOR
	call setTileInAllBuffers

	ld a,TILEINDEX_PUSHABLE_STATUE
	pop hl
	dec l
	call backwardsSearch
	jr z,-	

	;ld a,UNCMP_GFXH_WALL_RETRACTION
	;call loadUncompressedGfxHeader
	call reloadTileMap
	call resetCamera
	call getThisRoomFlags
	set ROOMFLAG_BIT_40,(hl)
	call loadTilesetAndRoomLayout
	ld a,60;$3c
	ld (wTmpcbb4),a
	xor a
	ld (wScrollMode),a
	jP cutscene_incState
@state1:
	ld a,(wTmpcbb3)
	rst_jumpTable
	.dw cbb3_00
	.dw @cbb3_01
@cbb3_01:
	;ld a,60;$3c
	;call setScreenShakeCounter
	call cutscene_tickDownCBB4ThenSetTo30
	ret nz
	ld (hl),25;$19
	callab tilesets.generateW3VramTilesAndAttributes
; b == YX of starting 2x2 tile position
; c == number of tile columns to copy over
	ld a,(wWallRetraction.retractionCounter)
	ld c,a
	ld a,$0c ; number of 2x2 tiles
	sub c
	ld c,a
	ld b,$92;$92,10;$4d,$04
	call func_70f7
	xor a;lda :w1Link
	ld ($ff00+R_SVBK),a


	;ld a,UNCMP_GFXH_WALL_RETRACTION
	;call loadUncompressedGfxHeader
	call reloadTileMap
	ld a,SND_DOORCLOSE
	call playSound
	ld hl,wWallRetraction.retractionCounter
	inc (hl)
	ld a,(hl)
	cp $0b ; number of retractions + 1
	ret c
	jp endWallRetractionCutscene

func_70f7:
	;ld b,b
	ld a,c
	ldh (<hFF8C),a
	ld a,b
	ldh (<hFF8D),a
; hFF8C == number of tile columns to copy over
; hFF8D == YX short of starting tile position
	swap a
	and $0f
	add a
; hFF93 == tile column of starting position
	ldh (<hFF93),a

	ld a,(wWallRetraction.retractionCounter)
	ld de,w2TmpGfxBuffer;w3VramTiles
	call addAToDe;addDoubleIndexToDe
	ldh a,(<hFF8C)
	ld b,a
	ld a,$20
	sub b
; hFF8E == used to get tile data from next row
;		   by adding to de
	ldh (<hFF8E),a

; don't care about hl cause the initial load tile shouldn't move
; the moving load is actually with w2TmpGfxBuffer
	ld hl,w3VramTiles+$244 ;YX = $12,$04
	push hl
	;push de
	ld c,d ;what the heck is this

	call wallRetractionLoadTilesOrAttributes
	;pop de
	pop hl
	;set 2,d ; add $400
	set 2,h ; add $400
	ld de,w2TmpAttrBuffer
wallRetractionLoadTilesOrAttributes:
	ld c,$04 ; number of row tiles to go through
	ldh a,(<hFF93)
	sub c
; ret if reached the end of the permitted row
	ret c
	ld c,a
--
	ldh a,(<hFF8C)
	ld b,a
-
	ld a,:w2TmpGfxBuffer
	ld ($ff00+R_SVBK),a
	ld a,(de)
	inc de
	ldh (<hFF8B),a
	ld a,:w3VramTiles
	ld ($ff00+R_SVBK),a
	ldh a,(<hFF8B)
	ldi (hl),a
	dec b
	jr nz,-
	ldh a,(<hFF8E)
	call addAToDe
	ldh a,(<hFF8E)
	rst_addAToHl
	dec c
	jr nz,--
	ret

/*
	swap a
	and $0f ; only Y of tile position
	add a ; double of Y
	ld e,a
	ld a,(wWallRetraction.retractionCounter)
	add e
	ldh (<hFF93),a
	ld c,$20
	call multiplyAByC
	ld bc,w3VramTiles
	ldh a,(<hFF8D)
	and $0f ; only X of tile position
	call addDoubleIndexToBc
	add hl,bc
	ldh a,(<hFF8C)
	ld b,a
	ld a,$20
	sub b
	ldh (<hFF8E),a
	push hl
	ld c,d
	ld de,w2TmpGfxBuffer;$d000
	call func_712f
	pop hl
	set 2,h
	ld de,w2TmpAttrBuffer;$d400
func_712f:
	ldh a,(<hFF93)
	ld c,a
	ld a,$14
	sub c
	ret c
	ld c,a
--
	ldh a,(<hFF8C)
	ld b,a
-
	ld a,:w2TmpGfxBuffer;$02
	ld ($ff00+R_SVBK),a
	ld a,(de)
	inc de
	ldh (<hFF8B),a
	ld a,:w3VramTiles
	ld ($ff00+R_SVBK),a
	ldh a,(<hFF8B)
	ldi (hl),a
	dec b
	jr nz,-
	ldh a,(<hFF8E)
	call addAToDe
	ldh a,(<hFF8E)
	rst_addAToHl
	dec c
	jr nz,--
	ret
*/