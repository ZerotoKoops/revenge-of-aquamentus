; ==================================================================================================
; INTERAC_JEWEL_HELPER
; ==================================================================================================
interactionCode90:
	ld e,Interaction.state
	ld a,(de)
	rst_jumpTable
	.dw @state0
	.dw @state1

@state0:
	ld a,$01
	ld (de),a ; [state]

	; Load script
	ld e,Interaction.subid
	ld a,(de)
	ld hl,@scriptTable
	rst_addDoubleIndex
	ldi a,(hl)
	ld h,(hl)
	ld l,a
	call interactionSetScript

	ld e,Interaction.subid
	ld a,(de)
	rst_jumpTable
	.dw @subid0Init
	.dw @subid1Init
	.dw @subid2Init
	.dw @subid3Init
	.dw @subid4Init
	.dw @subid5Init
	.dw @subid6Init
	.dw @subid7Init

@subid0Init:
	call @spawnJewelGraphics
	;call getThisRoomFlags
	;bit ROOMFLAG_BIT_80,(hl)
	;jp nz,interactionDelete
	ret

@subid1Init:
	call checkIsLinkedGame
	jr z,@label_0a_130
	ld e,$4b
	ld a,(de)
	sub $08
	ld (de),a
@label_0a_130:
	jr @state1

@subid3Init:
	call interactionRunScript
	call interactionRunScript

@subid4Init:
@subid5Init:
	jr @state1

@subid2Init:
	call getThisRoomFlags
	and $40
	jr z,@label_0a_131
	ret
@label_0a_131:
	call getFreePartSlot
	ret nz
	ld (hl),PART_LIGHTABLE_TORCH
	ld l,$cb
	ld (hl),$78
	ld l,$cd
	ld (hl),$78
	ret

@subid6Init:
	call getThisRoomFlags
	bit 5,(hl)
	jp nz,interactionDelete
	call checkIsLinkedGame
	jr nz,@label_0a_132
	ld a,$34
	ld ($ccbd),a
	ld a,$01
	ld ($ccbe),a
	jp interactionDelete
@label_0a_132:
	xor a
	ld ($ccbc),a
	inc a
	ld ($ccbb),a
	ret

@subid7Init:
	call checkIsLinkedGame
	jp z,interactionDelete
	call getThisRoomFlags
	bit 7,a
	jp nz,interactionDelete
	bit 5,a
	jp z,interactionDelete
	call getFreeInteractionSlot
	ret nz
	ld (hl),$60
	inc l
	ld (hl),$4d
	inc l
	ld (hl),$01
	jp objectCopyPosition

@state1:
	ld e,Interaction.subid
	ld a,(de)
	rst_jumpTable
	.dw @subid0State1
	.dw @runScript
	.dw @runScript
	.dw @runScript
	.dw @runScript
	.dw @runScript
	.dw @subid6State1
	.dw @subid7State1

@runScript:
	call interactionRunScript
	jp c,interactionDelete
	ret

@subid0State1:
	ld e,Interaction.substate
	ld a,(de)
	rst_jumpTable
	.dw @subid0Substate0
	.dw @subid0Substate1
	.dw @subid0Substate2
	.dw @subid0Substate3
	.dw @subid0Substate4
	.dw @subid0Substate5

; Waiting for Link to insert jewels
@subid0Substate0:
	call @checkJewelInserted
	ret nc

	ld a,c;ld a,(hl)
	call loseTreasure
	ld a,c;ld a,(hl)
	call @insertJewel

	ld a,DISABLE_LINK|DISABLE_ALL_BUT_INTERACTIONS
	ld (wDisabledObjects),a
	ld (wMenuDisabled),a

/*
	ld a,(wActiveRoom)
	cp <ROOM_SEASONS_414
	jr z,+
	ld a,SND_SOLVEPUZZLE
	call playSound

+
*/
	call setLinkForceStateToState08
	xor a
	ld (w1Link.direction),a

	call interactionIncSubstate
	ld hl,mainScripts.jewelHelperScript_insertedJewel
	call interactionSetScript


; Just inserted jewel
@subid0Substate1:
	call interactionRunScript
	ret nc

	ld a,(wInsertedJewels)
	cp $0f
	;jr z,@insertedAllJewels
	xor a
	ld e,Interaction.substate
	ld (de),a
	ld (wMenuDisabled),a
	ld (wDisabledObjects),a
	ret

@insertedAllJewels:
	call interactionIncSubstate
	ld hl,mainScripts.jewelHelperScript_insertedAllJewels
	call interactionSetScript


; Just inserted final jewel
@subid0Substate2:
	call interactionRunScript
	ret nc
	jp interactionIncSubstate


; Gate opening
@subid0Substate3:
	ld hl,@gateOpenTiles
	ld b,$04
---
	ldi a,(hl)
	ldh (<hFF8C),a
	ldi a,(hl)
	ldh (<hFF8F),a
	ldi a,(hl)
	ldh (<hFF8E),a
	ldi a,(hl)
	push hl
	push bc
	call setInterleavedTile
	pop bc
	pop hl
	dec b
	jr nz,---

	ldh a,(<hActiveObject)
	ld d,a
	call interactionIncSubstate

	ld l,Interaction.counter1
	ld (hl),30

	ld a,$00
	call @spawnGatePuffs
	ld a,SND_KILLENEMY
	call playSound

@shakeScreen:
	ld a,$06
	call setScreenShakeCounter
	ld a,SND_DOORCLOSE
	jp playSound


; Gate opening
@subid0Substate4:
	call interactionDecCounter1
	ret nz
	ld hl,@gateOpenTiles
	ld b,$04
---
	ldi a,(hl)
	ld c,a
	ld a,(hl)
	push hl
	push bc
	call setTile
	pop bc
	pop hl
	inc hl
	inc hl
	inc hl
	dec b
	jr nz,---

	call @shakeScreen
	ld a,$04
	call @spawnGatePuffs
	ld a,SND_KILLENEMY
	call playSound
	call interactionIncSubstate
	ld l,Interaction.counter1
	ld (hl),60
	ret

@gateOpenTiles:
	.db $14 $ad $a0 $03 $15 $ad $a0 $01
	.db $24 $ad $a1 $03 $25 $ad $a1 $01


; Gates fully opened
@subid0Substate5:
	call interactionDecCounter1
	ret nz
	xor a
	ld (wMenuDisabled),a
	ld (wDisabledObjects),a
	ld a,SND_SOLVEPUZZLE
	call playSound
	jp interactionDelete


@subid6State1:
	ld e,Interaction.substate
	ld a,(de)
	rst_jumpTable
	.dw @@substate0
	.dw @@substate1
	.dw @@substate2
@@substate0:
	ld a,($ccbc)
	or a
	ret z
	ld a,($cc34)
	or a
	ret nz
	call interactionIncSubstate
	ld l,$46
	ld (hl),$1e
	ld a,$80
	ld ($cc02),a
	ld a,$81
	ld (wDisabledObjects),a
	ret
@@substate1:
	call interactionDecCounter1
	ret nz
	ldbc INTERAC_PUFF $80
	call objectCreateInteraction
	ret nz
	ld l,$4b
	ld a,(hl)
	sub $04
	ld (hl),a
	ld a,$85
	call playSound
	call interactionIncSubstate
	ld l,$46
	ld (hl),$10
	ret
@@substate2:
	call interactionDecCounter1
	ret nz
	ld b,$e3
	call objectCreateInteractionWithSubid00
	ret nz
	ld l,$4b
	ld a,(hl)
	sub $04
	ld (hl),a
	call getThisRoomFlags
	set 5,(hl)
	jp interactionDelete

@subid7State1:
	ld a,$4d
	call checkTreasureObtained
	ret nc
	call getThisRoomFlags
	set 7,(hl)
	jp interactionDelete

;;
@spawnJewelGraphics:
	ld e,Interaction.var03
	ld a,(de)
	ld c,a
	ld hl,wInsertedJewels
	call checkFlag
	ret z

	ld a,c
	ld hl,wJewelRooms
	rst_addAToHl
	ld a,(wActiveRoom)
	cp (hl)

	jr z, @spawnJewelGraphic
	ret
/*
	ld c,$00
@@next:
	ld hl,wInsertedJewels
	ld a,c
	call checkFlag
	jr z,++
	push bc
	call @spawnJewelGraphic
	pop bc
++
	inc c
	ld a,c
	cp $04
	jr c,@@next
	ret
*/
;;
; @param[out]	hl	Address of treasure index?
; @param[out]	cflag	c if inserted jewel
@checkJewelInserted:
	call checkLinkID0AndControlNormal
	ret nc
	ld a,(w1WeaponItem.id)
	cp ITEM_SWORD
	ret z
	ld a,(wcc63)
	cpa $00
	ret nz

	;ld hl,w1Link.direction
	;ldi a,(hl)
	;cpa DIR_UP
	ld hl,w1Link.angle
	ld a,(hl)
	cpa $ff
	ret z
	add $04
	and $1f
	cpa $09
	ret nc

	ld e,Interaction.yh
	ld l,<w1Link.yh
	ld a,(de)
	add $06
	sub (hl)
	cp $15
	ret nc

	ld e,Interaction.xh
	ld l,<w1Link.xh
	ld a,(de)
	inc a
	sub (hl)
	cp $03
	ret nc

	ld e,Interaction.var03
	ld a,(de)
	add TREASURE_ROUND_JEWEL
	ld c,a
	jp checkTreasureObtained


/*
	ld l,<w1Link.yh
	ld a,$36
	sub (hl)
	cp $15
	ret nc

	ld l,<w1Link.yh
	ld b,(hl)

	ld l,<w1Link.xh
	ld c,(hl)

	ld hl,@jewelPositions-3;1

@nextJewelRoom:
	inc hl
@nextJewelX:
	inc hl
@nextJewelY:
	inc hl
	ldi a,(hl)
	or a ; end check if reached end with no match
	ret z
	add $01
	sub c
	cp $03 ; 
	jr nc,@nextJewelX

	ldi a,(hl)
	sub b
	cp $15
	jr nc,@nextJewelY

	ld a,(wActiveRoom)
	cp (hl)
	jr nz,@nextJewelRoom

	ld a,(hl) ; jewel that fit
	jp checkTreasureObtained

@jewelPositions:
	.db $2c, $16, <ROOM_SEASONS_437, TREASURE_ROUND_JEWEL ;$24
	.db $34, $ff, <ROOM_SEASONS_400, TREASURE_PYRAMID_JEWEL
	.db $6c, $ff, <ROOM_SEASONS_400, TREASURE_SQUARE_JEWEL
	.db $7c, $ff, <ROOM_SEASONS_400, TREASURE_X_SHAPED_JEWEL
	.db $00
*/
;;
@insertJewel:
	sub TREASURE_ROUND_JEWEL
	ld c,a
	ld hl,wInsertedJewels
	call setFlag
	ld a,c
	ld hl,wJewelRooms
	rst_addAToHl
	ld a,(wActiveRoom)
	ld (hl),a

;;
; @param	c	Jewel index
@spawnJewelGraphic:
	call getFreeInteractionSlot
	ret nz
	ld (hl),INTERAC_JEWEL
	inc l
	ld (hl),c
	jp objectCopyPosition
	;ret

;;
; @param	a	Which puffs to spawn (0 or 4)
@spawnGatePuffs:
	ld bc,@puffPositions
	call addDoubleIndexToBc
	ld a,$04
---
	ldh (<hFF8B),a
	call getFreeInteractionSlot
	ret nz
	ld (hl),INTERAC_PUFF
	ld l,Interaction.yh
	ld a,(bc)
	ld (hl),a
	inc bc
	ld l,Interaction.xh
	ld a,(bc)
	ld (hl),a
	inc bc
	ldh a,(<hFF8B)
	dec a
	jr nz,---
	ret

@puffPositions:
	.db $18 $48
	.db $18 $58
	.db $28 $48
	.db $28 $58
	.db $18 $40
	.db $18 $60
	.db $28 $40
	.db $28 $60

@scriptTable:
	.dw mainScripts.jewelHelperScript_insertedJewel
	.dw mainScripts.jewelHelperScript_underwaterPyramidJewel
	.dw mainScripts.jewelHelperScript_createBridgeToXJewelMoldorm
	.dw mainScripts.jewelHelperScript_XjewelMoldorm
	.dw mainScripts.jewelHelperScript_spoolSwampSquareJewel
	.dw mainScripts.jewelHelperScript_eyeglassLakeSquareJewel
	.dw mainScripts.jewelHelperScript_stub
	.dw mainScripts.jewelHelperScript_stub
