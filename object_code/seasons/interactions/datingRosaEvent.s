; ==================================================================================================
; INTERAC_DATING_ROSA_EVENT
; ==================================================================================================
interactionCode31:
	ld e,$42
	ld a,(de)
	rst_jumpTable
	.dw @subid0
	.dw @subid1
	.dw @subid2
	.dw @subid3
@subid0:
@subid3:
	ld e,$44
	ld a,(de)
	rst_jumpTable
	.dw @@state0
	.dw @@state1
@@state0:
	ld a,$01
	ld (de),a
	call interactionInitGraphics
	ld a,GLOBALFLAG_DATING_ROSA
	call checkGlobalFlag
	jp nz,interactionDelete
	ld h,d
	ld l,$6b
	ld (hl),$00
	ld l,$49
	ld (hl),$ff
	ld a,GLOBALFLAG_DATED_ROSA
	call checkGlobalFlag
	jr nz,+
	ld e,$77
	ld a,$04
	ld (de),a
+
	ld hl,mainScripts.rosaScript_goOnDate
	call interactionSetScript
	ld a,>TX_2900
	call interactionSetHighTextIndex
	call objectGetTileAtPosition
	ld (hl),$00
	jr +
@@state1:
	call interactionRunScript
+
	jp npcFaceLinkAndAnimate
@subid1:
	ld e,$44
	ld a,(de)
	rst_jumpTable
	.dw @@state0
	.dw @@state1
	.dw @@state2
	.dw @@state3
@@state0:
	ld a,$01
	ld (de),a
	call interactionInitGraphics
	call makeActiveObjectFollowLink
	call interactionSetAlwaysUpdateBit
	call objectSetReservedBit1
	ld l,$73
	ld (hl),$01
	ld l,$70
	ld e,$4b
	ld a,(de)
	ldi (hl),a
	ld e,$4d
	ld a,(de)
	ldi (hl),a
	ld e,$48
	ld a,($d008)
	ld (de),a
	ld (hl),$00
	call interactionSetAnimation
	call objectSetVisiblec3
	jp objectSetPriorityRelativeToLink_withTerrainEffects
@@state1:
	call objectSetPriorityRelativeToLink_withTerrainEffects
	call @@func_61a4
	ret c
	ld c,$20
	call objectUpdateSpeedZ_paramC
	call z,@@func_6182
	call @@func_628e
	ld h,d
	ld l,$4b
	ld a,(hl)
	ld b,a
	ld l,$70
	cp (hl)
	jr nz,+
	ld l,$4d
	ld a,(hl)
	ld c,a
	ld l,$71
	cp (hl)
	ret z
+
	ld l,$70
	ld (hl),b
	inc l
	ld (hl),c
	jp interactionAnimate
@@func_6182:
	ld h,d
	ld l,$46
	ld a,(hl)
	or a
	jr z,+
	dec (hl)
	ret nz
	ld bc,$fe40
	jp objectSetSpeedZ
+
	ld a,($cc77)
	or a
	ret z
	ld a,($cca4)
	and $81
	ret nz
	ld a,($cc02)
	or a
	ret nz
	ld (hl),$10
	ret
@@func_61a4:
	ld a,(wActiveGroup)
	cp $06
	jr nc,@@goToState3
	ld a,(wActiveRoom)
	ld hl,@@roomTable_61dd
	call findRoomSpecificData
	ret nc
	rst_jumpTable
	.dw @@screenAboveRosa
	.dw @@beachEntranceScreen
	.dw @@goToState3
@@screenAboveRosa:
	ld e,$73
	ld a,(de)
	or a
	jr nz,+
	ld a,($cd00)
	and $01
	jr z,+
	ld e,$44
	ld a,$02
	ld (de),a
	scf
	ret
+
	xor a
	ret
@@beachEntranceScreen:
	ld e,$73
	xor a
	ld (de),a
	ret
@@goToState3:
	ld e,$44
	ld a,$03
	ld (de),a
	ret
@@roomTable_61dd:
	.dw @@group0
	.dw @@group1
	.dw @@group2
	.dw @@group3
	.dw @@group4
	.dw @@group5
	.dw @@group6
	.dw @@group7
@@group0:
@@group2:
@@group6:
@@group7:
	.db $00
@@group1:
	; beach entrance
	.db <ROOM_SEASONS_167 $01
	.db <ROOM_SEASONS_177 $00
	.db $00
@@group3:
	; 1F pirate house
	.db <ROOM_SEASONS_38a $02
	; Left room of Strange brother's house
	.db <ROOM_SEASONS_3b1 $02
	.db $00
@@group4:
	.db <ROOM_SEASONS_4f0 $02
@@group5:
	.db $00

@@state2:
	ld e,$45
	ld a,(de)
	rst_jumpTable
	.dw @@@substate0
	.dw @@@substate1
	.dw @@@substate2
@@@substate0:
	ld a,$01
	ld (de),a
	call clearFollowingLinkObject
	ld a,GLOBALFLAG_DATING_ROSA
	call unsetGlobalFlag
	ld a,$01
	ld ($cca4),a
	ld a,$02
	ld ($d008),a
	ld a,$29
	call interactionSetHighTextIndex
	ld hl,mainScripts.rosaScript_dateEnded
	jp interactionSetScript
@@@substate1:
	ld c,$20
	call objectUpdateSpeedZ_paramC
	call interactionAnimate
	call objectSetPriorityRelativeToLink_withTerrainEffects
	call interactionRunScript
	ret nc
	ld e,$45
	ld a,$02
	ld (de),a
	ld bc,$4858
	call objectGetRelativeAngle
	ld e,$49
	ld (de),a
	ret
@@@substate2:
	call interactionAnimate
	call objectApplySpeed
	ld e,$4b
	ld a,(de)
	cp $48
	ret c
	ld h,d
	ld l,$42
	ld b,$06
	call clearMemory
	ld l,$40
	ld (hl),$01
	xor a
	ld ($cca4),a
	call objectGetTileAtPosition
	ld (hl),$00
	ld a,$28
	ld (wActiveMusic),a
	jp playSound
@@state3:
	call returnIfScrollMode01Unset
	ld e,$45
	ld a,(de)
	rst_jumpTable
	.dw @@@substate0
	.dw @@@substate1
@@@substate0:
	ld a,$01
	ld (de),a
	call clearFollowingLinkObject
	ld a,GLOBALFLAG_DATING_ROSA
	call unsetGlobalFlag
	ld bc,TX_291a
	jp showText
@@@substate1:
	call retIfTextIsActive
	jp interactionDelete
@@func_628e:
	ld h,d
	ld l,$48
	ld a,(hl)
	ld l,$72
	cp (hl)
	ret z
	ld (hl),a
	jp interactionSetAnimation
@subid2:
	ld e,Interaction.state;$44
	ld a,(de)
	rst_jumpTable
	.dw @@state0
	.dw @@state1
@@state0:
	ld a,$01 ; Interaction.state == 1
	ld (de),a
	;use this global flag cause why not
	ld a,GLOBALFLAG_STAR_ORE_FOUND
	call checkGlobalFlag
	jp c,interactionDelete
	ld a,(wcc84)
	or a
	jp nz,interactionDelete
	ld a,d
	ld (wcc84),a
	ld h,d
	ld l,Interaction.enabled;$40
	set 1,(hl) ; don't despawn

	call getRandomNumber
	and $03
	ld e,a
	ld a,(wTimeOfDay)
	and TIME_NIGHT
	rla ; x4
	add e

	ld hl,@@rooms
	rst_addDoubleIndex
	ld e,Interaction.var30;$70
	ldi a,(hl)
	ld (de),a
	inc e
	ld a,(hl)
	ld (de),a
	ld a,$ff
	ld e,Interaction.var32;$72
	ld (de),a
	ret
@@rooms:
	; var30 - var31
; day
	.db <ROOM_SEASONS_033, $63 ;$65 $57
	.db <ROOM_SEASONS_034, $37 ;$66 $56
	.db <ROOM_SEASONS_043, $33 ;$75 $27
	.db <ROOM_SEASONS_044, $42 ;$76 $24
;night
	.db <ROOM_SEASONS_033, $56
	.db <ROOM_SEASONS_034, $52
	.db <ROOM_SEASONS_043, $18
	.db <ROOM_SEASONS_044, $21

@@state1:
	ld e,Interaction.var32;$72
	ld a,(de)
	ld b,a
	ld a,(wActiveRoom)
	cp b
	ret z
	ld (de),a
	ld b,a
	ld e,Interaction.var30;$70
	ld a,(de)
	cp b
	jr nz,+
	call getFreeInteractionSlot
	ret nz
	ld (hl),INTERAC_TREASURE
	inc l
	ld (hl),TREASURE_MEMBERS_CARD;TREASURE_STAR_ORE
	ld e,Interaction.var31;$71
	ld a,(de)
	ld l,Interaction.yh;$4b
	jp setShortPosition
+
	ld a,TREASURE_MEMBERS_CARD;TREASURE_STAR_ORE
	call checkTreasureObtained
	jr c,+
	ld a,b
	cp <ROOM_SEASONS_033;$60
	ret nc
-
	xor a
	ld (wcc84),a
	jp interactionDelete
+
	ld a,GLOBALFLAG_STAR_ORE_FOUND
	call setGlobalFlag
	jr -
