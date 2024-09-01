; ==================================================================================================
; INTERAC_JEWEL
; ==================================================================================================
interactionCode92:
	call checkInteractionState
	jr nz,@state1

@state0:
	inc a
	ld (de),a ; [state] = 1
/*
	ld e,Interaction.subid
	ld a,(de)
	ld hl,@xPositions
	rst_addAToHl
	ld a,(hl)
	ld h,d
	ld l,Interaction.xh
	ld (hl),a

	ld l,Interaction.yh
	ld (hl),$2c
*/
	ldbc $10,$0c
	ld a,(wLinkObjectIndex)
	cp $d1
	jr nz,+
	ldbc $10,$18
+
	call objectSetCollideRadii
	call interactionInitGraphics
	jp objectSetVisible83
/*
@xPositions:
	.db $24 $34 $6c $7c
*/
;if Link swipes sword, jewel returns to Link's inventory
@state1:
	ld a,(w1Link.direction)
	cpa DIR_DOWN
	ret z

	ld a,(w1WeaponItem.id)
	cp ITEM_SWORD
	ret nz

	ld a,(wLinkObjectIndex)
	cp $d1
	jr z,+
	ld a,(wcc63)
	or a
	ret nz
+
	call objectCheckCollidedWithLink_notDead
	ret nc

	ld e,Interaction.subid
	ld a,(de)
	ld c,a
	ld hl,wInsertedJewels
	call unsetFlag

	ld a,c
	ld hl,wJewelRooms
	rst_addAToHl
	ld (hl),$ff

	ld a,c
	add TREASURE_ROUND_JEWEL
	ld c,$00
	call giveTreasure
	ld a,SND_GETSEED
	call playSound

	jp interactionDelete