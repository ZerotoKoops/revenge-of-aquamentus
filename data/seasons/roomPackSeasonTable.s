; Each byte corresponds to the default season to load in a particular room pack
; (data/seasons/roomPacks.s)

; clock - determines what season to load depending on day and day/night
; 6 bytes per room pack
roomPackSeasonTable:
; skips room pack $00
	/*$01*/ .db SEASON_SPRING SEASON_SUMMER SEASON_AUTUMN SEASON_SUMMER SEASON_AUTUMN SEASON_WINTER ; village
	/*$02*/ .db SEASON_SPRING SEASON_SUMMER SEASON_SPRING SEASON_WINTER SEASON_AUTUMN SEASON_WINTER ; plains
	/*$03*/ .db SEASON_SPRING SEASON_SUMMER SEASON_AUTUMN SEASON_WINTER SEASON_AUTUMN SEASON_WINTER ; beach
	/*$04*/ .db SEASON_SPRING SEASON_SUMMER SEASON_SPRING SEASON_SUMMER SEASON_AUTUMN SEASON_WINTER ; outside tower
	/*$05*/ .db SEASON_SPRING SEASON_SUMMER SEASON_SPRING SEASON_SUMMER SEASON_AUTUMN SEASON_WINTER ; flooded area

/*
	.db $00 $00 $00 $00 $00 $00 $03 $00 $00 $01 $00 $00 $00 $00 $00 $00
	.db $03 $02 $01 $02 $00 $01 $03 $02 $00 $01 $00 $03 $03 $03
*/
