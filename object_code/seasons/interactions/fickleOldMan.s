; ==================================================================================================
; INTERAC_FICKLE_OLD_MAN
; ==================================================================================================
interactionCode80:
	call checkInteractionState
	jr nz,@state1
	ld a,$01
	ld (de),a
	call interactionInitGraphics
	ld b,$07
	call checkIfHoronVillageNPCShouldBeSeen
	ld a,c
	or a
	jp z,interactionDelete
	ld e,Interaction.subid
	ld a,b
	ld (de),a
	ld hl,@table_7717
	rst_addDoubleIndex
	ldi a,(hl)
	ld h,(hl)
	ld l,a
	call interactionSetScript
	jp objectSetVisible82
@state1:
	call interactionRunScript
	jp interactionAnimateAsNpc
@table_7717:
	.dw mainScripts.fickleOldManScript_zeldaDream ;$00
	.dw mainScripts.fickleOldManScript_gateSwordExpo ;$01
	.dw mainScripts.fickleOldManScript_zeldaDream ;$02
	.dw mainScripts.fickleOldManScript_towerExpo ;$03
	.dw mainScripts.fickleOldManScript_zeldaDream ;$04
	.dw mainScripts.fickleOldManScript_towerExpo ;$05
	.dw mainScripts.fickleOldManScript_hiddenTreasure ;$06
	.dw mainScripts.fickleOldManScript_zeldaDream ;$07
	.dw mainScripts.fickleOldManScript_towerExpo ;$08
	.dw mainScripts.fickleOldManScript_vastWorld ;$09
	.dw mainScripts.fickleOldManScript_badClouds ;$0a
	.dw mainScripts.fickleOldManScript_vastWorld ;$0b
	.dw mainScripts.fickleOldManScript_gameBeat ;$0c
