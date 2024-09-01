; ==================================================================================================
; INTERAC_OLD_MAN_WITH_JEWEL
;
; Variables:
;   var35: $01 if Link has at least 5 essences
; ==================================================================================================
interactionCode8f:
	ld e,Interaction.state
	ld a,(de)
	rst_jumpTable
	.dw @state0
	.dw @state1

@state0:
	ld a,$01
	ld (de),a ; [state]
	call interactionInitGraphics

	ld a,>TX_3600
	call interactionSetHighTextIndex

	ld hl,mainScripts.oldManWithJewelScript
	call interactionSetScript
	call @checkHaveEssences

	ld a,$02
	call interactionSetAnimation
	jr @state1

@state1:
	call interactionRunScript
	jp npcFaceLinkAndAnimate

@checkHaveEssences:
	ld h,d
	ld l,Interaction.var38
	ld (hl),$00
	;ld a,(wEssencesObtained)
	;call getNumSetBits
	ld a,TREASURE_ROUND_JEWEL
	call checkTreasureObtained
	ret nc
	ld a,TREASURE_PYRAMID_JEWEL
	call checkTreasureObtained
	ret nc
	ld a,TREASURE_SQUARE_JEWEL
	call checkTreasureObtained
	ret nc
	ld a,(wSwordLevel)
	cp $02
	ret nz

	inc (hl)
	ret
/*
	ld h,d
	ld l,Interaction.var38
	;cp $05
	ld (hl),$00
	;ret c
	inc (hl)
	ret
*/