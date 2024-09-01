; Tree refill data is also used for the child and an event in room $6f (king moblin?).
;
; It waits for you to visit 8 unique rooms in the overworld, then sets the bit in
; wSeedTreeRefilledBitset when you next visit that screen.
;
; For trees, each index corresponds to an enemy object with id "5aXX".
;
; Data format:
;   Param 1: room index
;   Param 2: low byte of data location

seedTreeRefillLocations:
	m_TreeRefillData <ROOM_SEASONS_052, (<wxSeedTreeRefillData+$00) ; ember
	m_TreeRefillData <ROOM_SEASONS_024, (<wxSeedTreeRefillData+$08) ; mystery
	m_TreeRefillData <ROOM_SEASONS_033, (<wxSeedTreeRefillData+$10) ; scent
	m_TreeRefillData <ROOM_SEASONS_012, (<wxSeedTreeRefillData+$18) ; pegasus 
	m_TreeRefillData <ROOM_SEASONS_035, (<wxSeedTreeRefillData+$20) ; gale
	m_TreeRefillData <ROOM_SEASONS_026, (<wxSeedTreeRefillData+$28)
	m_TreeRefillData <ROOM_SEASONS_031, (<wxSeedTreeRefillData+$30)
	m_TreeRefillData <ROOM_SEASONS_042, (<wxSeedTreeRefillData+$38)
	;m_TreeRefillData $f8, (<wxSeedTreeRefillData+$00)
	;m_TreeRefillData $9e, (<wxSeedTreeRefillData+$08)
	;m_TreeRefillData $67, (<wxSeedTreeRefillData+$10)
	;m_TreeRefillData $72, (<wxSeedTreeRefillData+$18)
	;m_TreeRefillData $5f, (<wxSeedTreeRefillData+$20)
	;m_TreeRefillData $10, (<wxSeedTreeRefillData+$28)
	;m_TreeRefillData $6f, (<wxSeedTreeRefillData+$30) ; king moblin?
	;m_TreeRefillData $f6, (<wxSeedTreeRefillData+$38) ; child
