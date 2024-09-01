; ==================================================================================================
; INTERAC_GURU_GURU
;
; Ztk: var36 - $00 if no gale seeds obtained
;			   $01 if not enough seeds
;			   $02 if enough seeds
; Var37
; Var38
; Var39
; Var3a
; Var3b
; ==================================================================================================
interactionCode58:
	ld e,Interaction.state;$44
	ld a,(de)
	rst_jumpTable
	.dw @state0
	.dw @state1
@state0:
	ld a,TREASURE_GALE_SEEDS
	call checkTreasureObtained
	jr nc,@@galeSeedsNotObtained

	ld e,Interaction.var36
	ld a,(wNumGaleSeeds)
	cpa $10
	ld a,$01
	jr c,@@notEnoughSeeds
	inc a

@@notEnoughSeeds:
	ld (de),a

@@galeSeedsNotObtained:
	call interactionInitGraphics
	ld h,d
	ld l,Interaction.state;$44
	ld (hl),$01 ; Interaction.state == $01
	ld l,Interaction.var3c;$7c
	ld (hl),$01
	ld l,Interaction.var37;$77
	ld (hl),$78
	ld l,Interaction.var3b;$7b
	ld (hl),$01
	ld l,Interaction.var39;$79
	ld (hl),$01
	ld l,Interaction.speed;$50
	ld (hl),$0f
	call func_7e20
	ld a,>TX_0b00
	call interactionSetHighTextIndex
	ld hl,mainScripts.guruGuruScript
	call interactionSetScript
	jp func_7ddc
@state1:
	call interactionRunScript
	call func_7deb
	jr func_7ddc
func_7ddc:
	ld e,Interaction.var39;$79
	ld a,(de)
	or a
	jr z,+
	call interactionAnimate
+
	call objectPreventLinkFromPassing
	jp objectSetPriorityRelativeToLink_withTerrainEffects
func_7deb:
	ld e,Interaction.var38;$78
	ld a,(de)
	rst_jumpTable
	.dw @var38_00
	.dw func_7e38
@var38_00:
	ld e,Interaction.var3b;$7b
	ld a,(de)
	or a
	jr z,func_7e0f
	ld h,d
	ld l,Interaction.var37;$77
	dec (hl)
	ret nz
	ld (hl),$78
	ld l,Interaction.angle;$49
	ld a,(hl)
	xor $10
	ld (hl),a
	ld l,Interaction.var3a;$7a
	ld a,(hl)
	xor $02
	ld (hl),a
	jp interactionSetAnimation
func_7e0f:
	ld h,d
	ld l,Interaction.var38;$78
	ld (hl),$01
	ld l,Interaction.var39;$79
	ld (hl),$00
	ld a,(w1Link.xh);($d00d)
	ld l,Interaction.xh;$4d
	cp (hl)
	jr nc,func_7e2c
func_7e20:
	ld l,Interaction.angle;$49
	ld (hl),ANGLE_LEFT;$18
	ld l,Interaction.var3a;$7a
	ld a,$03
	ld (hl),a
	jp interactionSetAnimation
func_7e2c:
	ld l,Interaction.angle;$49
	ld (hl),ANGLE_RIGHT;$08
	ld l,Interaction.var3a;$7a
	ld a,$01
	ld (hl),a
	jp interactionSetAnimation
func_7e38:
	ld e,Interaction.var3b;$7b
	ld a,(de)
	or a
	ret z
	ld h,d
	ld l,Interaction.var38;$78
	ld (hl),$00
	ld l,Interaction.var39;$79
	ld (hl),$01
	ld l,Interaction.var37;$77
	ld (hl),$78
	ret
