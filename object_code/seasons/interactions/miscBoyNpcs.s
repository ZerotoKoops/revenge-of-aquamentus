; ==================================================================================================
; INTERAC_MISC_BOY_NPCS
; ==================================================================================================
interactionCode3e:
	call checkInteractionState
	jp nz,@state1
	ld a,$01
	ld (de),a
	ld h,d
	ld l,Interaction.subid;$42
	ld a,(hl)
	ld b,a
	and $0f
	ldi (hl),a
	ld a,b
	and $f0
	swap a
	ld (hl),a ;[Var03]
	cp $03
	jr nz,@nonVar03_03
	; subid30-34
	call getSunkenCityNPCVisibleSubId@main
	ld e,Interaction.subid;$42
	ld a,(de)
	cp b
	jp nz,interactionDelete
	cp $01
	jr nz,@continue
/*
	ld a,GLOBALFLAG_MOBLINS_KEEP_DESTROYED
	call checkGlobalFlag
	ld a,<ROOM_SEASONS_06e
	jr nz,+
	ld a,<ROOM_SEASONS_05e
+
	ld hl,wActiveRoom
	cp (hl)
	jp nz,interactionDelete
*/
	jr @continue
@nonVar03_03:
	add $04
	ld b,a
	call checkHoronVillageNPCShouldBeSeen_body@main
	jp nc,interactionDelete
@continue:
	ld e,$42
	ld a,b
	ld (de),a
	inc e
	ld a,(de)
	rst_jumpTable
	.dw @@var03_00
	.dw @@var03_01
	.dw @@var03_02
	.dw @@var03_03
@@var03_00:
	call @@var03_03
	call getFreeInteractionSlot
	jr nz,+
	ld (hl),INTERAC_BALL_THROWN_TO_DOG
	ld bc,$00fd
	call objectCopyPositionWithOffset
	ld l,Interaction.yh;$4b
	ld a,(hl)
	ld l,Interaction.var36;$76
	ld (hl),a
	ld l,Interaction.xh;$4d
	ld a,(hl)
	ld l,Interaction.var37;$77
	ld (hl),a
+
	jr @func_68e9
@@var03_01:
@@var03_03:
	ld h,d
	ld l,Interaction.subid;$42
	ldi a,(hl)
	push af
	ldd a,(hl)
	ld (hl),a
	call interactionInitGraphics
	pop af
	ld e,Interaction.subid;$42
	ld (de),a
	inc e
	ld a,(de)
	ld hl,table_6ac9
	rst_addDoubleIndex
	ldi a,(hl)
	ld h,(hl)
	ld l,a
	ld e,Interaction.subid;$42
	ld a,(de)
	rst_addDoubleIndex
	ldi a,(hl)
	ld h,(hl)
	ld l,a
	call interactionSetScript
	call interactionRunScript
	jp objectSetVisible82
@@var03_02:
	ld a,(wRoomStateModifier)
	cp SEASON_WINTER
	jp z,interactionDelete
	call @@var03_03
	ld a,(wRoomStateModifier)
	cp SEASON_SPRING
	ret nz
	ld h,d
	ld l,Interaction.angle;$49
	ld (hl),ANGLE_RIGHT;$08
	ld l,Interaction.speed;$50
	ld (hl),SPEED_100;$28
	ld l,Interaction.yh;$4b
	ld (hl),$62
	ld l,Interaction.xh;$4d
	ld (hl),$28
	ld a,$06
	jp interactionSetAnimation
@func_68e9:
	call getRandomNumber
	and $3f
	add $78
	ld h,d
	ld l,Interaction.var36;$76
	ld (hl),a
	ret

@state1:
	ld e,Interaction.var03;$43
	ld a,(de)
	rst_jumpTable
	.dw @@var03_00
	.dw @@var03_01
	.dw @@var03_02
	.dw @@var03_03
@@var03_00:
	ld e,Interaction.substate;$45
	ld a,(de)
	rst_jumpTable
	.dw @@@substate0
	.dw @@@substate1
@@@substate0:
	call func_6abc
	jr nz,+
	ld l,Interaction.animCounter;$60
	ld (hl),$01
	call interactionIncSubstate
	ld hl,wccd4;$cceb
	ld (hl),$01
	call interactionAnimate
+
	jp @@@runScriptPushLinkAwayUpdateDrawPriority
@@@substate1:
	ld a,(wccd4);$cceb)
	cp $02
	jr nz,@@@runScriptPushLinkAwayUpdateDrawPriority
	call @func_68e9
	ld l,Interaction.substate;$45
	ld (hl),$00
	ld a,$08
	call interactionSetAnimation
@@@runScriptPushLinkAwayUpdateDrawPriority:
	call interactionRunScript
	jp interactionPushLinkAwayAndUpdateDrawPriority
@@var03_01:
	ld h,d
	ld l,Interaction.subid;$42
	ld a,(hl)
	cp $02
	jr c,@@var03_03
	call checkInteractionSubstate
	jr nz,+
	call interactionIncSubstate
	xor a
	ld l,Interaction.z;$4e
	ldi (hl),a
	ld (hl),a
	call beginJump
+
	call updateSpeedZ
@@var03_03:
	call interactionRunScript
	jp interactionAnimateAsNpc
@@var03_02:
	ld a,(wRoomStateModifier)
	cp SEASON_SPRING
	jp nz,@@var03_03
	ld e,Interaction.substate;$45
	ld a,(de)
	rst_jumpTable
	.dw @@@substate0
	.dw @@@substate1
	.dw @@@substate2
	.dw @@@substate3
	.dw @@@substate4
	.dw @@@substate5
	.dw @@@substate6
	.dw @@@substate7
	.dw @@@substate8
	.dw @@@substate9
	.dw @@@substateA
	.dw @@@substateB
	.dw @@@substateC
@@@substate0:
	call objectCheckCollidedWithLink_notDeadAndNotGrabbing
	jr nc,+
	ld h,d
	ld l,Interaction.var37;$77
	ld (hl),$0c
+
	call func_6ac1
	jp nz,runScriptSetPriorityRelativeToLink_withTerrainEffects
	call objectApplySpeed
	cp SPEED_1e0;Interaction.yh;$4b
	jr c,+
	call interactionIncSubstate
	ld bc,$fe80
	call objectSetSpeedZ
	ld l,Interaction.speed;$50
	ld (hl),SPEED_80;$14
	ld a,$09
	call interactionSetAnimation
+
	jp animateRunScript
@@@substate1:
	ld a,(wUnknown);$ccc3)
	or a
	ret nz
	inc a
	ld (wUnknown),a;$ccc3),a
	call interactionIncSubstate
	jp objectSetVisiblec2
@@@substate2:
	ld c,$20
	call objectUpdateSpeedZ_paramC
	jp nz,objectApplySpeed
	call interactionIncSubstate
	ld l,Interaction.var36;$76
	ld (hl),$28
	call objectCenterOnTile
	ld l,Interaction.yh;$4b
	ld a,(hl)
	sub $05
	ld (hl),a
	ld a,$06
	jp interactionSetAnimation
@@@substate3:
	call func_6abc
	ret nz
	call interactionIncSubstate
	ld a,$05
	jp interactionSetAnimation
@@@substate4:
	ld e,Interaction.zh;$4f
	ld a,($ccc3)
	ld (de),a
	or a
	ret nz
	call interactionIncSubstate
	ld bc,$fd40
	call objectSetSpeedZ
	ld l,Interaction.zh;$4f
	ld (hl),$f6
	ld l,Interaction.speed;$50
	ld (hl),$28
	ld l,Interaction.angle;$49
	ld (hl),ANGLE_UP;$00
	ld a,SND_JUMP;$53
	jp playSound
@@@substate5:
	ld c,$20
	call objectUpdateSpeedZ_paramC
	jp nz,objectApplySpeed
	call interactionIncSubstate
	ld l,Interaction.var36;$76
	ld (hl),$10
	ld l,Interaction.pressedAButton;$71
	ld (hl),$00
	ret
@@@substate6:
	call func_6abc
	ret nz
	jp interactionIncSubstate
@@@substate7:
	call objectCheckCollidedWithLink_notDeadAndNotGrabbing
	jr nc,+
	ld h,d
	ld l,Interaction.var37;$77
	ld (hl),$0c
+
	call func_6ac1
	jp nz,runScriptSetPriorityRelativeToLink_withTerrainEffects
	call objectApplySpeed
	ld e,Interaction.yh;$4b
	ld a,(de)
	cp $28
	jr nc,+
	call interactionIncSubstate
	ld l,Interaction.var36;$76
	ld (hl),$06
	ld l,Interaction.angle;$49
	ld (hl),ANGLE_LEFT;$18
+
	jp animateRunScript
@@@substate8:
@@@substateA:
	call func_6abc
	ret nz
	ld l,Interaction.angle;$49
	ld a,(hl)
	swap a
	rlca
	add $05
	call interactionSetAnimation
	jp interactionIncSubstate
@@@substate9:
	call objectCheckCollidedWithLink_notDeadAndNotGrabbing
	jr nc,+
	ld h,d
	ld l,Interaction.var37;$77
	ld (hl),$0c
+
	call func_6ac1
	jr nz,runScriptSetPriorityRelativeToLink_withTerrainEffects
	call objectApplySpeed
	cp $18
	jr nc,+
	call interactionIncSubstate
	ld l,$76
	ld (hl),$06
	ld l,$49
	ld (hl),$10
+
	jp animateRunScript
@@@substateB:
	call objectCheckCollidedWithLink_notDeadAndNotGrabbing
	jr nc,+
	ld h,d
	ld l,$77
	ld (hl),$0c
+
	call func_6ac1
	jr nz,runScriptSetPriorityRelativeToLink_withTerrainEffects
	call objectApplySpeed
	ld e,$4b
	ld a,(de)
	cp $62
	jr c,+
	call interactionIncSubstate
	ld l,$76
	ld (hl),$06
	ld l,$49
	ld (hl),$08
+
	jp animateRunScript
@@@substateC:
	call func_6abc
	ret nz
	ld l,$45
	ld (hl),$00
	ld a,$06
	jp interactionSetAnimation

animateRunScript:
	call interactionAnimate

runScriptSetPriorityRelativeToLink_withTerrainEffects:
	call interactionRunScript
	jp objectSetPriorityRelativeToLink_withTerrainEffects

func_6abc:
	ld h,d
	ld l,$76
	dec (hl)
	ret
	
func_6ac1:
	ld h,d
	ld l,$77
	ld a,(hl)
	or a
	ret z
	dec (hl)
	ret

table_6ac9:
	.dw @var03_00
	.dw @var03_01
	.dw @var03_02
	.dw @var03_03

@var03_00:
	.dw mainScripts.boyWithDogScript_text1 ;$00
	.dw mainScripts.boyWithDogScript_text1 ;$01
	.dw mainScripts.boyWithDogScript_text1 ;$02
	.dw mainScripts.boyWithDogScript_text2 ;$03
	.dw mainScripts.boyWithDogScript_text2 ;$04
	.dw mainScripts.boyWithDogScript_text3 ;$05
	.dw mainScripts.boyWithDogScript_text5 ;$06
	.dw mainScripts.boyWithDogScript_text5 ;$07
	.dw mainScripts.boyWithDogScript_text6 ;$08
	.dw mainScripts.boyWithDogScript_text6 ;$09
	.dw mainScripts.boyWithDogScript_text7 ;$0a
	.dw mainScripts.boyWithDogScript_text4 ;$0b
	.dw mainScripts.boyWithDogScript_text5 ;$0c

@var03_01:
	.dw mainScripts.horonVillageBoyScript_text1 ;$00
	.dw mainScripts.horonVillageBoyScript_text1 ;$01
	.dw mainScripts.horonVillageBoyScript_text1 ;$02
	.dw mainScripts.horonVillageBoyScript_text1 ;$03
	.dw mainScripts.horonVillageBoyScript_text2 ;$04
	.dw mainScripts.horonVillageBoyScript_text2 ;$05
	.dw mainScripts.horonVillageBoyScript_text3 ;$06
	.dw mainScripts.horonVillageBoyScript_text4 ;$07
	.dw mainScripts.horonVillageBoyScript_text5 ;$08
	.dw mainScripts.horonVillageBoyScript_text6 ;$09
	.dw mainScripts.horonVillageBoyScript_text7 ;$0a
	.dw mainScripts.horonVillageBoyScript_text2 ;$0b
	.dw mainScripts.horonVillageBoyScript_text8 ;$0c

@var03_02:
	.dw mainScripts.springBloomBoyScript_text1 ;$00
	.dw mainScripts.springBloomBoyScript_text1 ;$01
	.dw mainScripts.springBloomBoyScript_text1 ;$02
	.dw mainScripts.springBloomBoyScript_text1 ;$03
	.dw mainScripts.springBloomBoyScript_text1 ;$04
	.dw mainScripts.springBloomBoyScript_text1 ;$05
	.dw mainScripts.springBloomBoyScript_text2 ;$06
	.dw mainScripts.springBloomBoyScript_text2 ;$07
	.dw mainScripts.springBloomBoyScript_text2 ;$08
	.dw mainScripts.springBloomBoyScript_text2 ;$09
	.dw mainScripts.springBloomBoyScript_text2 ;$0a
	.dw mainScripts.springBloomBoyScript_text1 ;$0b
	.dw mainScripts.springBloomBoyScript_text3 ;$0c

@var03_03:
	.dw mainScripts.sunkenCityBoyScript_text1 ;$00
	.dw mainScripts.sunkenCityBoyScript_text2 ;$01
	.dw mainScripts.sunkenCityBoyScript_text2 ;$02
	.dw mainScripts.sunkenCityBoyScript_text4 ;$03
	.dw mainScripts.sunkenCityBoyScript_text3 ;$04
