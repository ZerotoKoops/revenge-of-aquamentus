_harpSoundPointers:
	m_soundPointer zeldasLullaby	; $d6
	m_soundPointer eponasSong		; $d7
	m_soundPointer sariasSong		; $d8
	m_soundPointer sunsSong			; $d9
	m_soundPointer songOfTime		; $da
	m_soundPointer songOfStorms		; $db
	m_soundPointer songOfHealing	; $dc
	m_soundPointer songOfSoaring
	m_soundPointer songOfDoubleTime
	m_soundPointer invertedSongOfTime
	
	m_soundPointer noteB3	; $dd
	m_soundPointer noteC4	; $de
	m_soundPointer noteCs4	; $df
	m_soundPointer noteD4	; $e0
	m_soundPointer noteDs4	; $e1
	m_soundPointer noteE4	; $e2
	m_soundPointer noteF4	; $e3
	m_soundPointer noteFs4	; $e4
	m_soundPointer noteG4	; $e5
	m_soundPointer noteGs4	; $e6
	m_soundPointer noteA4	; $e7
	m_soundPointer noteAs4	; $e8
	m_soundPointer noteB4	; $e9
	m_soundPointer noteC5	; $ea
	m_soundPointer noteCs5	; $eb
	m_soundPointer noteD5	; $ec
	m_soundPointer noteDs5	; $ed
	m_soundPointer noteE5	; $ee
	m_soundPointer noteF5	; $ef

sndde:
	.db $00
	.dw snddeChannel0
	.db $01
	.dw snddeChannel1
	.db $04
	.dw snddeChannel4
	.db $06
	.dw snddeChannel6
	.db $ff