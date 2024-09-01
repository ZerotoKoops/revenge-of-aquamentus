; This is a list of positions Link can warp to with gale seeds.
; This does not populate the screens themselves with trees or anything.
;
; Data format:
;   b0: room index (or $00 to terminate the list)
;   b1: position for Link to land in
;   b2: map popup index (should show the tree type)

treeWarps:
	.db <ROOM_SEASONS_000 $62 $19 ;mystery
	.db <ROOM_SEASONS_005 $53 $15 ;ember
	.db <ROOM_SEASONS_032 $45 $18 ;gale
	.db <ROOM_SEASONS_050 $48 $17 ;pegasus
	.db <ROOM_SEASONS_055 $33 $16 ;scent
/*
	.db $10 $34 $18
	.db $5f $43 $18
	.db $67 $23 $16
	.db $72 $44 $17
	.db $9e $45 $19
	.db $f8 $33 $15
*/
	.db $ff $ff $ff
	.db $ff $ff $ff
	.db $ff $ff $ff
	.db $ff
