; ==================================================================================================
; INTERAC_MISCELLANEOUS_2
; ==================================================================================================
interactionCodedc:
	ld e,Interaction.subid
	ld a,(de)
	rst_jumpTable
	.dw interactionCodedc_subid00
	.dw interactionCodedc_subid01
	.dw interactionCodedc_subid02
	.dw interactionCodedc_subid03
	.dw interactionCodedc_subid04
/*
	.dw interactionCodedc_subid4
	.dw interactionCodedc_subid5
	.dw interactionCodedc_subid6
	.dw interactionCodedc_subid7
	.dw interactionCodedc_subid8
	.dw interactionCodedc_subid9
	.dw interactionCodedc_subidA
	.dw interactionCodedc_subidB
	.dw interactionCodedc_subidC
	.dw interactionCodedc_subidD
	.dw interactionCodedc_subidE
	.dw interactionCodedc_subidF
	.dw interactionCodedc_subid10
	.dw interactionCodedc_subid11
*/
/*
interactionCodedc_subidF:
	call interactionDeleteAndRetIfEnabled02
	call getThisRoomFlags
	and $20
	jp nz,interactionDelete
	ld e,$4d
	ld a,(de)
	ld b,a
	ld a,(wActiveTriggers)
	cp b
	jr nz,@func_66b9
	ld e,$4b
	ld a,(de)
	ld c,a
	ld b,$cf
	ld a,(bc)
	cp TILEINDEX_CHEST
	ret z
	ld a,TILEINDEX_CHEST
	call setTile
	call @func_66d2
	ld a,$4d
	jp playSound
@func_66b9:
	ld e,$4b
	ld a,(de)
	ld c,a
	ld b,$cf
	ld a,(bc)
	cp $f1
	ret nz
	ld a,$03
	ld ($ff00+$70),a
	ld b,$df
	ld a,(bc)
	ld l,a
	xor a
	ld ($ff00+$70),a
	ld a,l
	call setTile
@func_66d2:
	call getFreeInteractionSlot
	ret nz
	ld (hl),INTERAC_PUFF
	ld l,$4b
	jp setShortPosition_paramC
*/

interactionCodedc_subid03:
	ld e,$44
	ld a,(de)
	rst_jumpTable
	.dw interactionIncState
	.dw @state0
	.dw @state1
	.dw @state2
	.dw @state3
	.dw @state4
@state0:
	ld a,(wActiveTriggers)
	or a
	ret z
	ld a,$01
	ld e,$46
	ld (de),a
	jp interactionIncState
@state1:
	call interactionDecCounter1
	ret nz
	ld l,$45
	ld a,(hl)
	cp $03
	jr z,+
	inc (hl)
	ld hl,table_675a
	rst_addAToHl
	ld a,(hl)
	ld b,$6d
	jr func_6744
+
	call interactionIncState
	ld l,$46
	ld (hl),$43
@state2:
	call interactionDecCounter1
	ret nz
	ld (hl),$01
	jp interactionIncState
@state3:
	call interactionDecCounter1
	ret nz
	ld l,$45
	ld a,(hl)
	or a
	jp z,interactionIncState
	dec (hl)
	ld a,(hl)
	ld hl,table_675a
	rst_addAToHl
	ld a,(hl)
	ld b,$fd
	call func_6744
	ld (hl),$1e
	ret
@state4:
	ld a,(wActiveTriggers)
	or a
	ret nz
	ld a,$01
	ld e,$44
	ld (de),a
	ret
func_6744:
	ld c,a
	ld a,b
	call setTile
	call getFreeInteractionSlot
	ret nz
	ld (hl),INTERAC_PUFF
	ld l,$4b
	call setShortPosition_paramC
	ld h,d
	ld l,$46
	ld (hl),$0f
	ret
table_675a:
	.db $65 $64 $63
/*
interactionCodedc_subid1:
	ld e,$44
	ld a,(de)
	rst_jumpTable
	.dw @state0
	.dw @state1
	.dw @state2
@state0:
	ld a,$01
	ld (de),a
	call checkIsLinkedGame
	jp z,interactionDelete
	ld (wDisableWarpTiles),a
	ret
@state1:
	call returnIfScrollMode01Unset
	ld a,(wActiveTilePos)
	ld b,a
	ld a,(wEnteredWarpPosition)
	cp b
	ret z
	jp interactionIncState
@state2:
	call objectGetTileAtPosition
	ld b,a
	ld a,(wActiveTileIndex)
	cp b
	ret nz
	call checkLinkID0AndControlNormal
	ret nc
	ld hl,wWarpDestGroup
	ld (hl),$85
	inc l
	ld (hl),$30
	inc l
	ld (hl),$93
	inc l
	ld (hl),$ff
	ld a,$01
	ld (wWarpTransition2),a
	jp interactionDelete

interactionCodedc_subid2:
	ld e,$44
	ld a,(de)
	rst_jumpTable
	.dw interactionCodedc_subid1@state0
	.dw @state1
@state1:
	ld a,$01
	ld (wDisableWarpTiles),a
	call objectGetTileAtPosition
	ld b,a
	ld a,(wActiveTileIndex)
	cp b
	ret nz
	ld a,(wLinkInAir)
	or a
	ret nz
	call getLinkedHerosCaveSideEntranceRoom
	ld a,$05
	ld (wWarpDestGroup),a
	ld a,$09
	ld (wWarpTransition),a
	ld a,$00
	ld (wScrollMode),a
	ld a,LINK_STATE_WARPING
	ld (wLinkForceState),a
	jp interactionDelete

interactionCodedc_subid3:
	ld h,d
	ld l,$4b
	ld a,(wActiveTriggers)
	and (hl)
	cp (hl)
	ld hl,wActiveTriggers
	jr nz,+
	set 7,(hl)
	ret
+
	ld hl,wActiveTriggers
	res 7,(hl)
	ret

interactionCodedc_subid4:
	ld e,$44
	ld a,(de)
	rst_jumpTable
	.dw @state0
	.dw @state1
	.dw @state2
	.dw @state3
@state0:
	ld e,$4d
	ld a,(de)
	ld e,$70
	ld (de),a
	ld b,a
	call getThisRoomFlags
	and $20
	jr z,+
	call @func_681b
	jp interactionDelete
+
	ld e,$4b
	ld a,(de)
	ld c,a
	call objectSetShortPosition
	jp interactionIncState
@func_681b:
	ld e,$70
	ld a,(de)
	ld hl,wc64a
	cp (hl)
	ret c
	ld (hl),a
	ret
@state1:
	call getThisRoomFlags
	and $20
	ret z
	call @func_681b
	call interactionIncState
	ld l,$46
	ld (hl),$28
@state2:
	call retIfTextIsActive
	call interactionDecCounter1
	ret nz
	ld (hl),$1e
	call objectCreatePuff
	jp interactionIncState
@state3:
	call interactionDecCounter1
	ret nz
	ld a,$4d
	call playSound
	ldbc INTERAC_MINIBOSS_PORTAL $02
	call objectCreateInteraction
	ret nz
	jp interactionDelete

interactionCodedc_subid5:
	ld e,$44
	ld a,(de)
	rst_jumpTable
	.dw @state0
	.dw @state1
	.dw @state2
	.dw @state3
	.dw @state4
@state0:
	ld a,$01
	ld (de),a
@state1:
	ld a,(wActiveTriggers)
	cp $1f
	ret nz
	ld h,d
	ld a,$0f
	ld l,$46
	ld (hl),$0f
	inc l
	ld (hl),$73
	jp interactionIncState
@state2:
	call interactionDecCounter1
	ret nz
	inc l
	ld a,(hl)
	ld b,$6d
	call func_6744
	ld a,c
	cp $7d
	jp z,interactionIncState
	ld l,$47
	inc (hl)
	ret
@state3:
	ld a,(wActiveTriggers)
	cp $1f
	ret z
	jp interactionIncState
@state4:
	call interactionDecCounter1
	ret nz
	inc l
	ld a,(hl)
	ld b,$f4
	call func_6744
	ld a,c
	cp $73
	jr z,+
	ld l,$47
	dec (hl)
	ret
+
	ld h,d
	ld l,$44
	ld (hl),$01
	ret

interactionCodedc_subid6:
	ld e,$44
	ld a,(de)
	or a
	jr nz,+
	call getThisRoomFlags
	and $20
	jp nz,interactionDelete
	call interactionIncState
+
	ld a,($cc31)
	bit 6,a
	ret z
	call getFreeInteractionSlot
	ret nz
	ld (hl),INTERAC_TREASURE
	inc l
	ld (hl),TREASURE_SMALL_KEY
	inc l
	ld (hl),$01
	call objectCopyPosition
	jp interactionDelete

interactionCodedc_subid7:
	ld e,$44
	ld a,(de)
	rst_jumpTable
	.dw @state0
	.dw @state1
	.dw @state2
	.dw @state3
	.dw @state4
@state0:
	ld a,$01
	ld (de),a
@state1:
	ld e,$70
	ld a,(de)
	ld b,a
	ld a,(wActiveTriggers)
	cp b
	ret z
	ld (de),a
	ld (wccb1),a
	ld c,a
	ld a,b
	cpl
	and c
	call getHighestSetBit
	ld h,d
	ld l,$71
	ld (hl),a
	jp interactionIncState
@state2:
	ld b,$04
-
	call @func_6923
	call getFreeInteractionSlot
	ret nz
	ld (hl),INTERAC_PUFF
	ld l,$4b
	call setShortPosition_paramC
	dec b
	jr nz,-
	call interactionIncState
	ld l,$46
	ld (hl),$1e
	ret
@func_6923:
	ld a,b
	dec a
	ld hl,@table_692b
	rst_addAToHl
	ld c,(hl)
	ret
@table_692b:
	.db $22 $2c $82 $8c
@func_692f:
	ld e,$71
	ld a,(de)
	ld hl,@table_693a
	rst_addDoubleIndex
	ldi a,(hl)
	ld e,(hl)
	ld d,a
	ret
@table_693a:
	.db ENEMY_SPIKED_BEETLE $00
	.db ENEMY_GIBDO $00
	.db ENEMY_ARROW_DARKNUT $01
	.db ENEMY_MAGUNESU $00
	.db ENEMY_LYNEL $01
	.db ENEMY_IRON_MASK $00
	.db ENEMY_POLS_VOICE $00
	.db ENEMY_STALFOS $02
@state3:
	call interactionDecCounter1
	ret nz
	ld a,$01
	ld (wLoadedTreeGfxIndex),a
	call @func_692f
	ld b,$04
-
	call @func_6923
	call getFreeEnemySlot
	ret nz
	ld (hl),d
	inc l
	ld (hl),e
	ld l,$8b
	call setShortPosition_paramC
	dec b
	jr nz,-
	ldh a,(<hActiveObject)
	ld d,a
	jp interactionIncState
@state4:
	ld a,($cc30)
	or a
	ret nz
	ld a,(wActiveTriggers)
	inc a
	jp z,interactionDelete
	xor a
	ld ($ccc8),a
	ld e,$44
	ld a,$01
	ld (de),a
	ret

interactionCodedc_subid8:
	ld e,$44
	ld a,(de)
	rst_jumpTable
	.dw @state0
	.dw @state1
@state0:
	ld a,$01
	ld (de),a
@state1:
	ld a,(wcca2)
	or a
	ret z
	ld b,a
	ld e,$47
	ld a,(de)
	ld hl,table_6a02
	rst_addAToHl
	ld a,(hl)
	cp b
	jr nz,+
	ld a,(de)
	inc a
	ld (de),a
	jr ++
+
	ld e,$70
	ld a,$01
	ld (de),a
++
	ldbc TREASURE_RUPEES RUPEEVAL_070
	ld e,$70
	ld a,(de)
	or a
	jr nz,@wrongChest
	ldbc TREASURE_RUPEES RUPEEVAL_200
	ld e,$47
	ld a,(de)
	cp $08
	jr c,@spawnRupeeTreasure
	call getThisRoomFlags
	bit 5,a
	jr nz,@spawnRupeeTreasure
	set 7,(hl)
	call func_6a18
	ld a,$4f
	call setTile
	ld a,SND_SOLVEPUZZLE
	ldbc TREASURE_RUPEES RUPEEVAL_200
	jr @success
@wrongChest:
	ld a,SND_ERROR
@success:
	call playSound
@spawnRupeeTreasure:
	call getFreeInteractionSlot
	ret nz
	ld (hl),INTERAC_TREASURE
	inc l
	ld (hl),b
	inc l
	ld (hl),c
	ld l,$4b
	ld a,($ccbc)
	ld b,a
	and $f0
	ldi (hl),a
	inc l
	ld a,b
	swap a
	and $f0
	or $08
	ld (hl),a
	ld a,$81
	ld ($cca4),a
	xor a
	ld ($ccbc),a
	ret
table_6a02:
	.db $66 $5b $43 $3b
	.db $59 $23 $73 $35

interactionCodedc_subid9:
	call getThisRoomFlags
	and $80
	jp z,interactionDelete
	call func_6a18
	jp interactionDelete
func_6a18:
	call getFreeInteractionSlot
	ret nz
	ld (hl),INTERAC_PORTAL_SPAWNER
	inc l
	ld (hl),$01
	ld c,$57
	ld l,$4b
	jp setShortPosition_paramC

interactionCodedc_subidA:
	ld hl,$c904
	set 4,(hl)
	jp interactionDelete

interactionCodedc_subidB:
	xor a
	ld (wToggleBlocksState),a
	jp interactionDelete


interactionCodedc_subidC:
*/
interactionCodedc_subid04:
	call checkInteractionState
	jr nz,@state1
	call objectGetTileAtPosition
	ld a,(wEnteredWarpPosition)
	cp l
	jp nz,interactionDelete
	call interactionIncState
	call interactionSetAlwaysUpdateBit
	ld a,$81
	ld (wDisabledObjects),a
	ld (wMenuDisabled),a
@state1:
	ld a,(wPaletteThread_mode)
	or a
	ret nz
	ld bc,TX_0201
	call showText
	xor a
	ld (wDisabledObjects),a
	ld (wMenuDisabled),a
	jp interactionDelete
/*
interactionCodedc_subidD:
	ld a,(wWarpDestPos)
	cp $22
	jr nz,+
	xor a
	ld (wWarpDestPos),a
	call initializeDungeonStuff
+
	jp interactionDelete

interactionCodedc_subidE:
	ld a,(wScrollMode)
	and $01
	ret z
	ld hl,wRoomLayout|$79
-
	ld a,(hl)
	cp $fe
	jr z,+
	cp $ff
	jr nz,++
+
	ld (hl),$7b
++
	dec l
	jr nz,-
	jp interactionDelete
*/


interactionCodedc_subid00:
	ld e,Interaction.xh
	ld a,(de)
	or a
	jr z,+
	ld a,(wActiveTriggers)
	and $01
	jp nz,interactionDelete
+
	call checkInteractionState
	jr nz,@state1
	call interactionIncState
	call @unset
@state1:
	ld e,Interaction.yh
	ld a,(de)
	;push de

	ld hl,@roomJewelTriggerTable
	rst_addDoubleIndex
	ldi a,(hl)
	ld b,(hl)
	ld c,a

	ld a,(bc)
	ld e,a
	ld a,(wInsertedJewels)
	and e ; only checking the related bits
	jr z,@unset

	xor e ; all bits must be set
	jr nz,@unset

	inc bc
	ld a,(bc)
	ld e,a
	ld hl,wJewelRooms-1

-
	inc hl
	inc bc
	ld a,(bc)
	or a
	jr z,-

	ld d,(hl)
	cp d
	jr nz,@unset

	dec e
	jr nz,-


@set:
	ld hl,wActiveTriggers
	set 0,(hl)
	;pop de
	ret

@unset:
	ld hl,wActiveTriggers
	res 0,(hl)
	;pop de ; when called by @state0, this will cause the call to act like a jump
	ret

@roomJewelTriggerTable:
	/*$00*/ .dw @@room437
	/*$01*/ .dw @@room411
	/*$02*/ .dw @@room414_00
	/*$03*/ .dw @@room433_00
	/*$04*/ .dw @@room430
	/*$05*/ .dw @@room412
	/*$06*/ .dw @@room42f
	/*$07*/ .dw @@room40a
	/*$08*/ .dw @@room433_01
	/*$09*/ .dw @@room414_01
	/*$0a*/ .dw @@room418

@@room437:
	.db $01, $01, <ROOM_SEASONS_437
@@room411:
	.db $02, $01, $00, <ROOM_SEASONS_411
@@room414_00:
	.db $01, $01, <ROOM_SEASONS_414
@@room414_01:
	.db $04, $01, $00, $00, <ROOM_SEASONS_40c
@@room433_00:
	.db $02, $01, $00, <ROOM_SEASONS_433
@@room433_01:
	.db $02, $01, $00, <ROOM_SEASONS_430
@@room430:
	.db $03, $02, <ROOM_SEASONS_430, <ROOM_SEASONS_430
@@room412:
	.db $02, $01, $00, <ROOM_SEASONS_412
@@room42f:
	.db $07, $03, <ROOM_SEASONS_42f, <ROOM_SEASONS_412, <ROOM_SEASONS_42f
@@room40a:
	.db $0f, $04, <ROOM_SEASONS_40a, <ROOM_SEASONS_40a, <ROOM_SEASONS_40a, <ROOM_SEASONS_40a
@@room418:
	.db $0b, $03, <ROOM_SEASONS_418, <ROOM_SEASONS_418, $00, <ROOM_SEASONS_418


; var03 subid of moving platform
interactionCodedc_subid01:
	ld e,Interaction.state
	ld a,(de)
	rst_jumpTable
	.dw @state0
	.dw @state1
	.dw @state2

; check to spawn platform the first time
@state0:
	inc e ;Interaction.substate
	ld a,(de)
	rst_jumpTable
	.dw @substate0
	.dw @spawnPuffAndIncSubstate
	.dw @spawnPuffAndSetCounter1
	.dw @decCounter
	.dw @@spawnMovingPlatform
	.dw @decCounter
	.dw @playSoundAndSetState1

@@spawnMovingPlatform:
	call getFreeInteractionSlot
	ret nz
	ld (hl),INTERAC_MOVING_PLATFORM
	inc l

; get index for platform
	ld e,Interaction.var03
	ld a,(de)
	ld (hl),a
; set position
	call objectCopyPosition

	ld e,Interaction.relatedObj1
	ld a,Interaction.start
	ld (de),a
	inc e
	ld a,h
	ld (de),a

	jr @setCounter1_15

; platform is spawned, check to turn invisible
@state1:
	call @takePositionFromPlatform
	ld e,Interaction.substate
	ld a,(de)
	rst_jumpTable
	.dw @@substate0
	.dw @spawnPuffAndIncSubstate
	.dw @spawnPuffAndSetCounter1
	.dw @@setPlatformInvisibleIntangible

@@substate0:
	call @checkActiveTriggers
	ret nz
	jr @incSubstate

@@setPlatformInvisibleIntangible:
	ld a,Object.visible
	call objectGetRelatedObject1Var
	res 7,(hl)
	ldbc $00, $00
	call objectHSetCollideRadii
	ld a,$02
	jr @setStateAndResetSubstate

; check to spawn platform the subsequent time
@state2:
	call @takePositionFromPlatform
	ld e,Interaction.substate
	ld a,(de)
	rst_jumpTable
	.dw @substate0
	.dw @spawnPuffAndIncSubstate
	.dw @spawnPuffAndSetCounter1
	.dw @decCounter
	.dw @@setPlatformVisibleTangible
	.dw @decCounter
	.dw @playSoundAndSetState1

@@setPlatformVisibleTangible:
	call @checkActiveTriggers
	jr z,@setCounter1_15
	ld a,Object.visible
	call objectGetRelatedObject1Var
	set 7,(hl)
	ldbc $10, $10
	call objectHSetCollideRadii

@setCounter1_15:
	ld e,Interaction.counter1
	ld a,15
	ld (de),a

@incSubstate:
	jp interactionIncSubstate

@playSoundAndSetState1:
	call @checkActiveTriggers
	ld a,SND_SOLVEPUZZLE
	call nz,playSound
	ld a,$01
@setStateAndResetSubstate:
	ld e,Interaction.state
	ld (de),a
	inc e ;Interaction.substate
	xor a
	ld (de),a
	ret

@substate0:
	call @checkActiveTriggers
	ret z
	jr @incSubstate

@spawnPuffAndIncSubstate:
	ldbc $f8, $00
@createPuff:
	push bc
	call objectCreatePuff
	pop bc
	ret nz
	call objectCopyPositionWithOffset
	jr @incSubstate

@spawnPuffAndSetCounter1:
	ldbc $08, $00
	call @createPuff
	inc l ; Interaction.counter1
	ld (hl),30
	ret

@decCounter:
	call interactionDecCounter1
	ret nz
	jr @incSubstate
	
@checkActiveTriggers:
	ld a,(wActiveTriggers)
	and $01
	ret

@takePositionFromPlatform:
	lda Object.start
	call objectGetRelatedObject1Var
	jp objectTakePosition

interactionCodedc_subid02:
	ld e,Interaction.state
	ld a,(de)
	rst_jumpTable
	;.dw @findTorches
	.dw @torch0
	.dw @torch1
	.dw @torch2
	.dw @state3
	.dw @state4
/*
@findTorches:
	ld e,Interaction.var30
	ld h,$d0
	ld l,Part.id
	ld c,PART_LIGHTABLE_TORCH
-
	call objectFindObject_paramC
	jr nz,@incState
; a == h
	ld (de),a
	inc e
	jr -
*/

@torch0:
	ldbc $01,$59
	jr @checkTorches
@torch1:
	ldbc $02,$55
	jr @checkTorches

@torch2:
	ldbc $03,$57

@checkTorches:
	ld a,(wNumTorchesLit)
	cp b
	ret c

	ld a,c
	ld hl,wRoomLayout
	rst_addAToHl
	ld a,TILEINDEX_LIT_TORCH
	cp (hl)
	call nz,interactionIncSubstate
@incState:
	jp interactionIncState

@state3:
	ld a,30;$1e
	ld e,Interaction.counter1;$46
	ld (de),a
	jr @incState

@state4:
	call interactionDecCounter1
	ret nz
	ld h,d
	ld l,Interaction.substate
	ld a,(hl)
	or a
	jr nz,@error

	ld c,$42;$5c
	ld a,$06;$05
	call setTile
	call objectCreatePuff
	call getThisRoomFlags
	set ROOMFLAG_BIT_80,(hl)
	ld a,SND_SOLVEPUZZLE;$4d
	call playSound
	jp interactionDelete

@error: 
	lda $00
	ldd (hl),a ; [substate == $00]
	ld (hl),a ; [state == $00]
	ld (wNumTorchesLit),a

	call getFreeInteractionSlot
	jr nz,+
	ld (hl),INTERAC_CREATE_OBJECT_AT_EACH_TILEINDEX
	inc l
	ld (hl),TILEINDEX_UNLIT_TORCH
	ld l,Interaction.yh
	ld (hl),PART_LIGHTABLE_TORCH
	ld l,Interaction.xh
	ld (hl),$10 ;Part with subid $00
/*
	ld c,$03
	ld e,Interaction.var30
-
	ld a,(de)
	ld h,a
	ld l,Part.state
	ld (hl),$01 ; set lightable torch state to $1
	inc e
	dec c
	jr nz,-
*/
+
	ld c,$55
	ld a,TILEINDEX_UNLIT_TORCH
	call setTileInAllBuffers
	ld c,$57
	ld a,TILEINDEX_UNLIT_TORCH
	call setTileInAllBuffers
	ld c,$59
	ld a,TILEINDEX_UNLIT_TORCH
	call setTileInAllBuffers

	ld a,SND_ERROR
	jp playSound