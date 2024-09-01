; ==================================================================================================
; INTERAC_SWITCH_TILE_TOGGLER
; ==================================================================================================
interactionCode78:
	ld e,Interaction.state
	ld a,(de)
	rst_jumpTable
	.dw @state0
	.dw @state1

@state0:
	ld a,$01
	ld (de),a
	ld a,(wSwitchState)
	ld e,Interaction.var03
	ld (de),a

@state1:
	ld a,(wSwitchState)
	ld b,a
	ld e,Interaction.var03
	ld a,(de)
	cp b
	ret z

	ld a,b
	ld (de),a
	ld e,Interaction.xh
	ld a,(de)
	ld hl,@tileReplacement
	rst_addDoubleIndex
	ld e,Interaction.subid
	ld a,(de)
	and b
	jr z,+
	inc hl
+
	ld e,Interaction.yh
	ld a,(de)
	ld c,a
	ld a,(hl)
	jp setTile

; Index for this table is "Interaction.xh". Determines what tiles will appear when
; a switch is on or off.
;   b0: tile index when switch not pressed
;   b1: tile index when switch pressed
@tileReplacement:
	.db TILEINDEX_TRACK_HORIZONTAL TILEINDEX_TRACK_TL ; $00
	.db TILEINDEX_TRACK_HORIZONTAL TILEINDEX_TRACK_BR ; $01
	.db TILEINDEX_TRACK_HORIZONTAL TILEINDEX_TRACK_BL ; $02
	.db TILEINDEX_TRACK_HORIZONTAL TILEINDEX_TRACK_TR ; $03
	.db TILEINDEX_TRACK_VERTICAL TILEINDEX_TRACK_TL ; $04
	.db TILEINDEX_TRACK_VERTICAL TILEINDEX_TRACK_BR ; $05
	.db TILEINDEX_TRACK_VERTICAL TILEINDEX_TRACK_BL ; $06
	.db TILEINDEX_TRACK_VERTICAL TILEINDEX_TRACK_TR ; $07
	.db TILEINDEX_TRACK_TL TILEINDEX_TRACK_HORIZONTAL ; $08
	.db TILEINDEX_TRACK_BR TILEINDEX_TRACK_HORIZONTAL ; $09
	.db TILEINDEX_TRACK_BL TILEINDEX_TRACK_HORIZONTAL ; $0a
	.db TILEINDEX_TRACK_TR TILEINDEX_TRACK_HORIZONTAL ; $0b (patch's minecart game)
	.db TILEINDEX_TRACK_TL TILEINDEX_TRACK_VERTICAL ; $0c
	.db TILEINDEX_TRACK_BR TILEINDEX_TRACK_VERTICAL ; $0d
	.db TILEINDEX_TRACK_BL TILEINDEX_TRACK_VERTICAL ; $0e
	.db TILEINDEX_TRACK_TR TILEINDEX_TRACK_VERTICAL ; $0f
	.db TILEINDEX_TRACK_TL TILEINDEX_TRACK_BL ; $10
	.db TILEINDEX_TRACK_BR TILEINDEX_TRACK_TR ; $11
	.db TILEINDEX_TRACK_BL TILEINDEX_TRACK_TL ; $12
	.db TILEINDEX_TRACK_TR TILEINDEX_TRACK_BR ; $13
	.db TILEINDEX_TRACK_TL TILEINDEX_TRACK_TR ; $14
	.db TILEINDEX_TRACK_BR TILEINDEX_TRACK_BL ; $15
	.db TILEINDEX_TRACK_BL TILEINDEX_TRACK_BR ; $16
	.db TILEINDEX_TRACK_TR TILEINDEX_TRACK_TL ; $17
	.db $5b $5e ; $18
