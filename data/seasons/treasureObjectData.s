m_section_free TreasureObjectData NAMESPACE treasureData

; Treasure objects are a kind of Interaction (INTERAC_TREASURE). Each "Treasure Object" contains
; the information necessary to display a specific treasure (see "constants/common/treasure.s") and
; give it to Link. Many treasures need a "parameter" to go with them (ie. level, amount). All of
; this "extra data" is defined here.
;
; The "m_TreasureSubid" macro takes 4 bytes as parameters:
;   b0: bit 7    = next 2 bytes are a pointer
;       bits 4-6 = spawn mode
;       bit 3    = ?
;       bits 0-2 = grab mode
;   b1: Parameter (value of 'c' to pass to "giveTreasure")
;   b2: Low text ID on pickup ($ff for no text; high byte of ID is always $00, TX_00XX)
;   b3: Graphics to use. (Gets copied to object's subid, so graphics are determined by the
;       corresponding value for interaction $60 in data/{game}/interactionData.s.)
;
; The macro takes a final parameter, which will be the name to give this new subid of the treasure
; index. This name will resolve to a 4-digit hex number (XXYY, where XX = treasure index and YY
; = subid).
;
; For documentation of spawn modes and grab modes, see "constants/common/treasureSpawnModes.s".
;
; See also constants/common/treasure.s for treasure lists.

.define CURRENT_TREASURE_INDEX $10000

treasureObjectData:
	/* $00 */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_NONE_00
	/* $01 */ m_TreasurePointer treasureObjectData01
	/* $02 */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_PUNCH_00
	/* $03 */ m_TreasurePointer treasureObjectData03
	/* $04 */ m_TreasureSubid   $38, $00, <TX_00_GET_CANE, $7e, TREASURE_OBJECT_CANE_OF_SOMARIA_00
	/* $05 */ m_TreasurePointer treasureObjectData05
	/* $06 */ m_TreasurePointer treasureObjectData06
	/* $07 */ m_TreasurePointer treasureObjectData07
	/* $08 */ m_TreasureSubid   $38, $00, $30, $18, TREASURE_OBJECT_MAGNET_GLOVES_00
	/* $09 */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_SWITCH_HOOK_HELPER_00
	/* $0a */ m_TreasurePointer treasureObjectData0a
	/* $0b */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_SWITCH_HOOK_CHAIN_00
	/* $0c */ m_TreasurePointer treasureObjectData0c
	/* $0d */ m_TreasurePointer treasureObjectData0d
	/* $0e */ m_TreasureSubid   $0a, $0c, $3b, $23, TREASURE_OBJECT_FLUTE_00
	/* $0f */ m_TreasureSubid   $38, $01, <TX_00_GET_SEEDSHOOTER, $80, TREASURE_OBJECT_SHOOTER_00
	/* $10 */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_10_00
	/* $11 */ m_TreasureSubid   $0a, $00, <TX_00_GET_HARP, $81, TREASURE_OBJECT_HARP_00
	/* $12 */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_12_00
	/* $13 */ m_TreasurePointer treasureObjectData13
	/* $14 */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_14_00
	/* $15 */ m_TreasureSubid   $0a, $00, $25, $1b, TREASURE_OBJECT_SHOVEL_00
	/* $16 */ m_TreasurePointer treasureObjectData16
	/* $17 */ m_TreasurePointer treasureObjectData17
	/* $18 */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_18_00
	/* $19 */ m_TreasurePointer treasureObjectData19
	/* $1a */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_1a_00
	/* $1b */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_1b_00
	/* $1c */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_1c_00
	/* $1d */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_MINECART_COLLISION_00
	/* $1e */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_FOOLS_ORE_00
	/* $1f */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_1f_00
	/* $20 */ m_TreasurePointer treasureObjectData20
	/* $21 */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_SCENT_SEEDS_00
	/* $22 */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_PEGASUS_SEEDS_00
	/* $23 */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_GALE_SEEDS_00
	/* $24 */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_MYSTERY_SEEDS_00
	/* $25 */ m_TreasureSubid   $38, $00, <TX_00_GET_ECHOES,   $82, TREASURE_OBJECT_TUNE_OF_ECHOES_00
	/* $26 */ m_TreasureSubid   $38, $00, <TX_00_GET_CURRENTS, $83, TREASURE_OBJECT_TUNE_OF_CURRENTS_00
	/* $27 */ m_TreasureSubid   $38, $00, <TX_00_GET_AGES,     $84, TREASURE_OBJECT_TUNE_OF_AGES_00
	/* $28 */ m_TreasurePointer treasureObjectData28
	/* $29 */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_HEART_REFILL_00
	/* $2a */ m_TreasurePointer treasureObjectData2a
	/* $2b */ m_TreasurePointer treasureObjectData2b
	/* $2c */ m_TreasurePointer treasureObjectData2c
	/* $2d */ m_TreasurePointer treasureObjectData2d
	/* $2e */ m_TreasureSubid   $32, $00, $31, $31, TREASURE_OBJECT_FLIPPERS_00
	/* $2f */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_POTION_00
	/* $30 */ m_TreasurePointer treasureObjectData30
	/* $31 */ m_TreasurePointer treasureObjectData31
	/* $32 */ m_TreasurePointer treasureObjectData32
	/* $33 */ m_TreasurePointer treasureObjectData33
	/* $34 */ m_TreasurePointer treasureObjectData34
	/* $35 */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_35_00
	/* $36 */ m_TreasureSubid   $02, $00, $33, $47, TREASURE_OBJECT_MAKU_SEED_00
	/* $37 */ m_TreasureSubid   $02, $0b, $6b, $2f, TREASURE_OBJECT_ORE_CHUNKS_00
	/* $38 */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_38_00
	/* $39 */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_39_00
	/* $3a */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_3a_00
	/* $3b */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_3b_00
	/* $3c */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_3c_00
	/* $3d */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_3d_00
	/* $3e */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_3e_00
	/* $3f */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_3f_00
	/* $40 */ m_TreasurePointer $0000
	/* $41 */ m_TreasurePointer treasureObjectData41
	/* $42 */ m_TreasurePointer treasureObjectData42
	/* $43 */ m_TreasureSubid   $09, $00, $43, $45, TREASURE_OBJECT_FLOODGATE_KEY_00
	/* $44 */ m_TreasureSubid   $09, $00, $44, $46, TREASURE_OBJECT_DRAGON_KEY_00
	/* $45 */ m_TreasureSubid   $5a, $00, $40, $57, TREASURE_OBJECT_STAR_ORE_00
	/* $46 */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_RIBBON_00
	/* $47 */ m_TreasureSubid   $0a, $00, $66, $54, TREASURE_OBJECT_SPRING_BANANA_00
	/* $48 */ m_TreasureSubid   $09, $01, $67, $55, TREASURE_OBJECT_RICKY_GLOVES_00
	/* $49 */ m_TreasureSubid   $0a, $00, $3c, $56, TREASURE_OBJECT_BOMB_FLOWER_00
	/* $4a */ m_TreasurePointer treasureObjectData4a
	/* $4b */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_TREASURE_MAP_00
	/* $4c */ m_TreasureSubid   $68, $00, $47, $36, TREASURE_OBJECT_ROUND_JEWEL_00
	/* $4d */ m_TreasurePointer treasureObjectData4d
	/* $4e */ m_TreasureSubid   $38, $00, $48, $38, TREASURE_OBJECT_SQUARE_JEWEL_00
	/* $4f */ m_TreasureSubid   $38, $00, $49, $39, TREASURE_OBJECT_X_SHAPED_JEWEL_00
	/* $50 */ m_TreasureSubid   $38, $00, $3f, $59, TREASURE_OBJECT_RED_ORE_00
	/* $51 */ m_TreasureSubid   $38, $00, $3e, $58, TREASURE_OBJECT_BLUE_ORE_00
	/* $52 */ m_TreasureSubid   $0a, $00, $3d, $5a, TREASURE_OBJECT_HARD_ORE_00
	/* $53 */ m_TreasureSubid   $5a, $00, <TX_0045, $27, TREASURE_OBJECT_MEMBERS_CARD_00
	/* $54 */ m_TreasureSubid   $38, $00, $70, $26, TREASURE_OBJECT_MASTERS_PLAQUE_00
	/* $55 */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_55_00
	/* $56 */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_56_00
	/* $57 */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_57_00
	/* $58 */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_BOMB_FLOWER_LOWER_HALF_00
	/* $59 */ m_TreasureSubid   $38, $00, <TX_00_GET_MERMAIDSUIT, $7c, TREASURE_OBJECT_MERMAID_SUIT_00
	/* $5a */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_5a_00
	/* $5b */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_5b_00
	/* $5c */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_5c_00
	/* $5d */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_5d_00
	/* $5e */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_5e_00
	/* $5f */ m_TreasureSubid   $00, $00, $ff, $00, TREASURE_OBJECT_5f_00
	/* $60 */ m_TreasureSubid   $0c, $00, $72, $57, TREASURE_OBJECT_60_00
	/* $61 */ m_TreasureSubid   $02, $00, $6e, $05, TREASURE_OBJECT_BOMB_UPGRADE_00
	/* $62 */ m_TreasureSubid   $02, $00, $46, $20, TREASURE_OBJECT_SATCHEL_UPGRADE_00


treasureObjectData16:
	m_BeginTreasureSubids TREASURE_BRACELET
	m_TreasureSubid $38, $01, $26, $19, TREASURE_OBJECT_BRACELET_00
	m_TreasureSubid $38, $02, <TX_00_GET_POWERGLOVE, $7d, TREASURE_OBJECT_BRACELET_01

treasureObjectData19:
	m_BeginTreasureSubids TREASURE_SEED_SATCHEL
	m_TreasureSubid $0a, $01, $2d, $20, TREASURE_OBJECT_SEED_SATCHEL_00
	m_TreasureSubid $09, $00, $46, $20, TREASURE_OBJECT_SEED_SATCHEL_UPGRADE

treasureObjectData01:
	m_BeginTreasureSubids TREASURE_SHIELD
	m_TreasureSubid $0a, $01, $1f, $13, TREASURE_OBJECT_SHIELD_00
	m_TreasureSubid $0a, $02, $20, $14, TREASURE_OBJECT_SHIELD_01
	m_TreasureSubid $0a, $03, $21, $15, TREASURE_OBJECT_SHIELD_02

treasureObjectData03:
	m_BeginTreasureSubids TREASURE_BOMBS
	m_TreasureSubid $38, $10, $4d, $05, TREASURE_OBJECT_BOMBS_00
	m_TreasureSubid $30, $10, $4d, $05, TREASURE_OBJECT_BOMBS_01
	m_TreasureSubid $02, $10, $4d, $05, TREASURE_OBJECT_BOMBS_02
	m_TreasureSubid $38, $30, $4d, $05, TREASURE_OBJECT_BOMBS_03

treasureObjectData05:
	m_BeginTreasureSubids TREASURE_SWORD
	m_TreasureSubid $38, $01, $1c, $10, TREASURE_OBJECT_SWORD_00
	m_TreasureSubid $09, $02, $1d, $11, TREASURE_OBJECT_SWORD_01
	m_TreasureSubid $09, $03, $1e, $12, TREASURE_OBJECT_SWORD_02
	m_TreasureSubid $03, $01, $ff, $10, TREASURE_OBJECT_SWORD_03
	m_TreasureSubid $03, $02, $ff, $11, TREASURE_OBJECT_SWORD_04
	m_TreasureSubid $03, $03, $ff, $12, TREASURE_OBJECT_SWORD_05

treasureObjectData06:
	m_BeginTreasureSubids TREASURE_BOOMERANG
	m_TreasureSubid $0a, $01, $22, $1c, TREASURE_OBJECT_BOOMERANG_00
	m_TreasureSubid $38, $02, $23, $1d, TREASURE_OBJECT_BOOMERANG_01

treasureObjectData07:
	m_BeginTreasureSubids TREASURE_ROD_OF_SEASONS
	m_TreasureSubid $38, $07, $0a, $1e, TREASURE_OBJECT_ROD_OF_SEASONS_00
	m_TreasureSubid $01, $07, $ff, $1e, TREASURE_OBJECT_ROD_OF_SEASONS_01
	m_TreasureSubid $09, $00, $0d, $1e, TREASURE_OBJECT_ROD_OF_SEASONS_02
	m_TreasureSubid $09, $01, $0b, $1e, TREASURE_OBJECT_ROD_OF_SEASONS_03
	m_TreasureSubid $09, $02, $0c, $1e, TREASURE_OBJECT_ROD_OF_SEASONS_04
	m_TreasureSubid $09, $03, $0a, $1e, TREASURE_OBJECT_ROD_OF_SEASONS_05
	m_TreasureSubid $09, $07, $71, $1e, TREASURE_OBJECT_ROD_OF_SEASONS_06

treasureObjectData0a:
	m_BeginTreasureSubids TREASURE_SWITCH_HOOK
	m_TreasureSubid $38, $01, <TX_00_GET_SWITCHHOOK, $7f, TREASURE_OBJECT_SWITCH_HOOK_00
	m_TreasureSubid $38, $02, <TX_00_GET_LONGHOOK,   $7f, TREASURE_OBJECT_SWITCH_HOOK_01

treasureObjectData0c:
	m_BeginTreasureSubids TREASURE_BIGGORON_SWORD
	m_TreasureSubid $02, $00, $6f, $25, TREASURE_OBJECT_BIGGORON_SWORD_00
	m_TreasureSubid $30, $00, $6f, $25, TREASURE_OBJECT_BIGGORON_SWORD_01

treasureObjectData0d:
	m_BeginTreasureSubids TREASURE_BOMBCHUS
	m_TreasureSubid $0a, $10, $32, $24, TREASURE_OBJECT_BOMBCHUS_00
	m_TreasureSubid $30, $10, $32, $24, TREASURE_OBJECT_BOMBCHUS_01

treasureObjectData13:
	m_BeginTreasureSubids TREASURE_SLINGSHOT
	m_TreasureSubid $38, $01, $2e, $21, TREASURE_OBJECT_SLINGSHOT_00
	m_TreasureSubid $38, $02, $2f, $22, TREASURE_OBJECT_SLINGSHOT_01

treasureObjectData17:
	m_BeginTreasureSubids TREASURE_FEATHER
	m_TreasureSubid $38, $01, $27, $16, TREASURE_OBJECT_FEATHER_00
	m_TreasureSubid $38, $02, $28, $17, TREASURE_OBJECT_FEATHER_01
	m_TreasureSubid $5a, $01, $37, $16, TREASURE_OBJECT_FEATHER_02

treasureObjectData20:
	m_BeginTreasureSubids TREASURE_EMBER_SEEDS
	m_TreasureSubid $30, $04, $4f, $06, TREASURE_OBJECT_EMBER_SEEDS_00

treasureObjectData34:
	m_BeginTreasureSubids TREASURE_GASHA_SEED
	m_TreasureSubid $02, $01, $4b, $0d, TREASURE_OBJECT_GASHA_SEED_00
	m_TreasureSubid $38, $01, $4b, $0d, TREASURE_OBJECT_GASHA_SEED_01
	m_TreasureSubid $52, $01, $4b, $0d, TREASURE_OBJECT_GASHA_SEED_02
	m_TreasureSubid $02, $01, $4b, $0d, TREASURE_OBJECT_GASHA_SEED_03
	m_TreasureSubid $0a, $01, $4b, $0d, TREASURE_OBJECT_GASHA_SEED_04
	m_TreasureSubid $4a, $01, $4b, $0d, TREASURE_OBJECT_GASHA_SEED_05

treasureObjectData28:
	m_BeginTreasureSubids TREASURE_RUPEES
	m_TreasureSubid $38, $01, $01, $28, TREASURE_OBJECT_RUPEES_00
	m_TreasureSubid $38, $03, $02, $29, TREASURE_OBJECT_RUPEES_01
	m_TreasureSubid $38, $04, $03, $2a, TREASURE_OBJECT_RUPEES_02
	m_TreasureSubid $38, $05, $04, $2b, TREASURE_OBJECT_RUPEES_03
	m_TreasureSubid $38, $07, $05, $2b, TREASURE_OBJECT_RUPEES_04
	m_TreasureSubid $38, $0b, $06, $2c, TREASURE_OBJECT_RUPEES_05
	m_TreasureSubid $38, $0c, $07, $2d, TREASURE_OBJECT_RUPEES_06
	m_TreasureSubid $38, $0f, $08, $2d, TREASURE_OBJECT_RUPEES_07
	m_TreasureSubid $38, $0d, $09, $2e, TREASURE_OBJECT_RUPEES_08
	m_TreasureSubid $30, $01, $01, $28, TREASURE_OBJECT_RUPEES_09
	m_TreasureSubid $18, $01, $ff, $2e, TREASURE_OBJECT_RUPEES_0a
	m_TreasureSubid $08, $05, $ff, $2b, TREASURE_OBJECT_RUPEES_0b
	m_TreasureSubid $08, $07, $05, $2b, TREASURE_OBJECT_RUPEES_0c
	m_TreasureSubid $30, $04, $03, $2a, TREASURE_OBJECT_RUPEES_0d
	m_TreasureSubid $08, $0f, $08, $2d, TREASURE_OBJECT_RUPEES_0e

treasureObjectData2b:
	m_BeginTreasureSubids TREASURE_HEART_PIECE
	m_TreasureSubid $0a, $01, $17, $3a, TREASURE_OBJECT_HEART_PIECE_00
	m_TreasureSubid $38, $01, $17, $3a, TREASURE_OBJECT_HEART_PIECE_01
	m_TreasureSubid $02, $01, $17, $3a, TREASURE_OBJECT_HEART_PIECE_02

treasureObjectData2a:
	m_BeginTreasureSubids TREASURE_HEART_CONTAINER
	m_TreasureSubid $1a, $04, $16, $3b, TREASURE_OBJECT_HEART_CONTAINER_00
	m_TreasureSubid $30, $04, $16, $3b, TREASURE_OBJECT_HEART_CONTAINER_01
	m_TreasureSubid $02, $04, $16, $3b, TREASURE_OBJECT_HEART_CONTAINER_02

treasureObjectData2c:
	m_BeginTreasureSubids TREASURE_RING_BOX
	m_TreasureSubid $02, $01, $57, $33, TREASURE_OBJECT_RING_BOX_00
	m_TreasureSubid $02, $02, $34, $34, TREASURE_OBJECT_RING_BOX_01
	m_TreasureSubid $02, $03, $34, $35, TREASURE_OBJECT_RING_BOX_02
	m_TreasureSubid $02, $02, $58, $34, TREASURE_OBJECT_RING_BOX_03
	m_TreasureSubid $02, $03, $59, $35, TREASURE_OBJECT_RING_BOX_04

treasureObjectData2d:
	m_BeginTreasureSubids TREASURE_RING
	m_TreasureSubid $09, $ff, $54, $0e, TREASURE_OBJECT_RING_00
	m_TreasureSubid $29, $ff, $54, $0e, TREASURE_OBJECT_RING_01
	m_TreasureSubid $49, $ff, $54, $0e, TREASURE_OBJECT_RING_02
	m_TreasureSubid $59, $ff, $54, $0e, TREASURE_OBJECT_RING_03
	m_TreasureSubid $38, $28, $54, $0e, TREASURE_OBJECT_RING_04
	m_TreasureSubid $38, $2b, $54, $0e, TREASURE_OBJECT_RING_05
	m_TreasureSubid $38, $10, $54, $0e, TREASURE_OBJECT_RING_06
	m_TreasureSubid $38, $0c, $54, $0e, TREASURE_OBJECT_RING_07
	m_TreasureSubid $38, $0d, $54, $0e, TREASURE_OBJECT_RING_08
	m_TreasureSubid $38, $2a, $54, $0e, TREASURE_OBJECT_RING_09
	m_TreasureSubid $38, $23, $54, $0e, TREASURE_OBJECT_RING_0a
	m_TreasureSubid $38, $05, $54, $0e, TREASURE_OBJECT_RING_0b
	m_TreasureSubid $30, $2f, $54, $0e, TREASURE_OBJECT_RING_0c
	m_TreasureSubid $30, $21, $54, $0e, TREASURE_OBJECT_RING_0d
	m_TreasureSubid $38, $01, $54, $0e, TREASURE_OBJECT_RING_0e
	m_TreasureSubid $38, $03, $54, $0e, TREASURE_OBJECT_RING_0f
	m_TreasureSubid $38, $2d, $54, $0e, TREASURE_OBJECT_RING_10

treasureObjectData30:
	m_BeginTreasureSubids TREASURE_SMALL_KEY
	m_TreasureSubid $18, $01, $ff, $42, TREASURE_OBJECT_SMALL_KEY_00
	m_TreasureSubid $28, $01, $ff, $42, TREASURE_OBJECT_SMALL_KEY_01
	m_TreasureSubid $49, $01, $1a, $42, TREASURE_OBJECT_SMALL_KEY_02
	m_TreasureSubid $38, $01, $1a, $42, TREASURE_OBJECT_SMALL_KEY_03
	m_TreasureSubid $08, $01, $1a, $42, TREASURE_OBJECT_SMALL_KEY_04

treasureObjectData31:
	m_BeginTreasureSubids TREASURE_BOSS_KEY
	m_TreasureSubid $19, $00, $1b, $43, TREASURE_OBJECT_BOSS_KEY_00
	m_TreasureSubid $29, $00, $1b, $43, TREASURE_OBJECT_BOSS_KEY_01
	m_TreasureSubid $49, $00, $1b, $43, TREASURE_OBJECT_BOSS_KEY_02
	m_TreasureSubid $38, $00, $1b, $43, TREASURE_OBJECT_BOSS_KEY_03

treasureObjectData32:
	m_BeginTreasureSubids TREASURE_COMPASS
	m_TreasureSubid $1a, $00, $19, $41, TREASURE_OBJECT_COMPASS_00
	m_TreasureSubid $2a, $00, $19, $41, TREASURE_OBJECT_COMPASS_01
	m_TreasureSubid $68, $00, $19, $41, TREASURE_OBJECT_COMPASS_02

treasureObjectData33:
	m_BeginTreasureSubids TREASURE_MAP
	m_TreasureSubid $1a, $00, $18, $40, TREASURE_OBJECT_MAP_00
	m_TreasureSubid $2a, $00, $18, $40, TREASURE_OBJECT_MAP_01
	m_TreasureSubid $68, $00, $18, $40, TREASURE_OBJECT_MAP_02

treasureObjectData41:
	m_BeginTreasureSubids TREASURE_TRADEITEM
	m_TreasureSubid $0a, $00, $5a, $70, TREASURE_OBJECT_TRADEITEM_00
	m_TreasureSubid $0a, $01, $5b, $71, TREASURE_OBJECT_TRADEITEM_01
	m_TreasureSubid $0a, $02, $5c, $72, TREASURE_OBJECT_TRADEITEM_02
	m_TreasureSubid $0a, $03, $5d, $73, TREASURE_OBJECT_TRADEITEM_03
	m_TreasureSubid $0a, $04, $5e, $74, TREASURE_OBJECT_TRADEITEM_04
	m_TreasureSubid $0a, $05, $5f, $75, TREASURE_OBJECT_TRADEITEM_05
	m_TreasureSubid $0a, $06, $60, $76, TREASURE_OBJECT_TRADEITEM_06
	m_TreasureSubid $0a, $07, $61, $77, TREASURE_OBJECT_TRADEITEM_07
	m_TreasureSubid $0a, $08, $62, $78, TREASURE_OBJECT_TRADEITEM_08
	m_TreasureSubid $0a, $09, $63, $79, TREASURE_OBJECT_TRADEITEM_09
	m_TreasureSubid $0a, $0a, $64, $7a, TREASURE_OBJECT_TRADEITEM_0a
	m_TreasureSubid $0a, $0b, $65, $7b, TREASURE_OBJECT_TRADEITEM_0b

treasureObjectData42:
	m_BeginTreasureSubids TREASURE_GNARLED_KEY
	m_TreasureSubid $69, $00, $42, $44, TREASURE_OBJECT_GNARLED_KEY_00
	m_TreasureSubid $09, $00, $42, $44, TREASURE_OBJECT_GNARLED_KEY_01

treasureObjectData4a:
	m_BeginTreasureSubids TREASURE_PIRATES_BELL
	m_TreasureSubid $0a, $00, $55, $5b, TREASURE_OBJECT_PIRATES_BELL_00
	m_TreasureSubid $4a, $00, $55, $5b, TREASURE_OBJECT_PIRATES_BELL_01
	m_TreasureSubid $0a, $01, $56, $5c, TREASURE_OBJECT_PIRATES_BELL_02

treasureObjectData4d:
	m_BeginTreasureSubids TREASURE_PYRAMID_JEWEL
	m_TreasureSubid $68, $00, $4a, $37, TREASURE_OBJECT_PYRAMID_JEWEL_00
	m_TreasureSubid $02, $00, $4a, $37, TREASURE_OBJECT_PYRAMID_JEWEL_01

.ends
