; ==================================================================================================
; INTERAC_TREASURE_HUNTER
; ==================================================================================================
interactionCode39:
	ld e,Interaction.state
	ld a,(de)
	rst_jumpTable
	.dw @state0
	.dw @state1
	.dw @state2

@state0:
	call interactionInitGraphics
	ld a,>TX_0b00
	call interactionSetHighTextIndex
	ret
	