
.redefine WAIT_LEN 10
.redefine NOTE_LEN 12
.redefine BEAT 1

.macro m_noteChannel2Timbre
	duty $02
	env $0 $02
	vol $9
.endm

.macro m_noteChannel3Timbre
	duty $02
	env $0 $02
	vol $0
	beat gs3 WAIT_LEN
	vol $5
.endm

noteB3Start:
noteB3Channel2:
	m_noteChannel2Timbre
	octave 4
	beat b WAIT_LEN+NOTE_LEN
	cmdff

noteB3Channel3:
	m_noteChannel3Timbre
	beat b NOTE_LEN
	cmdff

noteC4Start:
noteC4Channel2:
	m_noteChannel2Timbre
	octaveu
	beat c WAIT_LEN+NOTE_LEN
	cmdff

noteC4Channel3:
	m_noteChannel3Timbre
	beat c NOTE_LEN
	cmdff

noteCs4Start:
noteCs4Channel2:
	m_noteChannel2Timbre
	beat cs WAIT_LEN+NOTE_LEN
	cmdff

noteCs4Channel3:
	m_noteChannel3Timbre
	beat cs NOTE_LEN
	cmdff

noteD4Start:
noteD4Channel2:
	m_noteChannel2Timbre
	beat d WAIT_LEN+NOTE_LEN
	cmdff

noteD4Channel3:
	m_noteChannel3Timbre
	beat d NOTE_LEN
	cmdff

noteDs4Start:
noteDs4Channel2:
	m_noteChannel2Timbre
	beat ds WAIT_LEN+NOTE_LEN
	cmdff

noteDs4Channel3:
	m_noteChannel3Timbre
	beat ds NOTE_LEN
	cmdff

noteE4Start:
noteE4Channel2:
	m_noteChannel2Timbre
	beat e WAIT_LEN+NOTE_LEN
	cmdff

noteE4Channel3:
	m_noteChannel3Timbre
	beat e NOTE_LEN
	cmdff

noteF4Start:
noteF4Channel2:
	m_noteChannel2Timbre
	beat f WAIT_LEN+NOTE_LEN
	cmdff

noteF4Channel3:
	m_noteChannel3Timbre
	beat f NOTE_LEN
	cmdff

noteFs4Start:
noteFs4Channel2:
	m_noteChannel2Timbre
	beat fs WAIT_LEN+NOTE_LEN
	cmdff

noteFs4Channel3:
	m_noteChannel3Timbre
	beat fs NOTE_LEN
	cmdff

noteG4Start:
noteG4Channel2:
	m_noteChannel2Timbre
	beat g WAIT_LEN+NOTE_LEN
	cmdff

noteG4Channel3:
	m_noteChannel3Timbre
	beat g NOTE_LEN
	cmdff

noteGs4Start:
noteGs4Channel2:
	m_noteChannel2Timbre
	beat gs WAIT_LEN+NOTE_LEN
	cmdff

noteGs4Channel3:
	m_noteChannel3Timbre
	beat gs NOTE_LEN
	cmdff

noteA4Start:
noteA4Channel2:
	m_noteChannel2Timbre
	beat a WAIT_LEN+NOTE_LEN
	cmdff

noteA4Channel3:
	m_noteChannel3Timbre
	beat a NOTE_LEN
	cmdff

noteAs4Start:
noteAs4Channel2:
	m_noteChannel2Timbre
	beat as WAIT_LEN+NOTE_LEN
	cmdff

noteAs4Channel3:
	m_noteChannel3Timbre
	beat as NOTE_LEN
	cmdff

noteB4Start:
noteB4Channel2:
	m_noteChannel2Timbre
	beat b WAIT_LEN+NOTE_LEN
	cmdff

noteB4Channel3:
	m_noteChannel3Timbre
	beat b NOTE_LEN
	cmdff

noteC5Start:
noteC5Channel2:
	m_noteChannel2Timbre
	octaveu
	beat c WAIT_LEN+NOTE_LEN
	cmdff

noteC5Channel3:
	m_noteChannel3Timbre
	beat c NOTE_LEN
	cmdff

noteCs5Start:
noteCs5Channel2:
	m_noteChannel2Timbre
	beat cs WAIT_LEN+NOTE_LEN
	cmdff

noteCs5Channel3:
	m_noteChannel3Timbre
	beat cs NOTE_LEN
	cmdff

noteD5Start:
noteD5Channel2:
	m_noteChannel2Timbre
	beat d WAIT_LEN+NOTE_LEN
	cmdff

noteD5Channel3:
	m_noteChannel3Timbre
	beat d NOTE_LEN
	cmdff

noteDs5Start:
noteDs5Channel2:
	m_noteChannel2Timbre
	beat ds WAIT_LEN+NOTE_LEN
	cmdff

noteDs5Channel3:
	m_noteChannel3Timbre
	beat ds NOTE_LEN
	cmdff

noteE5Start:
noteE5Channel2:
	m_noteChannel2Timbre
	beat e WAIT_LEN+NOTE_LEN
	cmdff

noteE5Channel3:
	m_noteChannel3Timbre
	beat e NOTE_LEN
	cmdff

noteF5Start:
noteF5Channel2:
	m_noteChannel2Timbre
	beat f WAIT_LEN+NOTE_LEN
	cmdff

noteF5Channel3:
	m_noteChannel3Timbre
	beat f NOTE_LEN
	cmdff

noteB3Channel5:
noteC4Channel5:
noteCs4Channel5:
noteD4Channel5:
noteDs4Channel5:
noteE4Channel5:
noteF4Channel5:
noteFs4Channel5:
noteG4Channel5:
noteGs4Channel5:
noteA4Channel5:
noteAs4Channel5:
noteB4Channel5:
noteC5Channel5:
noteCs5Channel5:
noteD5Channel5:
noteDs5Channel5:
noteE5Channel5:
noteF5Channel5:
	duty $0e
	beat r WAIT_LEN+NOTE_LEN
	cmdff

noteB3Channel7:
noteC4Channel7:
noteCs4Channel7:
noteD4Channel7:
noteDs4Channel7:
noteE4Channel7:
noteF4Channel7:
noteFs4Channel7:
noteG4Channel7:
noteGs4Channel7:
noteA4Channel7:
noteAs4Channel7:
noteB4Channel7:
noteC5Channel7:
noteCs5Channel7:
noteD5Channel7:
noteDs5Channel7:
noteE5Channel7:
noteF5Channel7:
	cmdf0 $00
	beat $00 WAIT_LEN+NOTE_LEN
	cmdff
.UNDEFINE WAIT_LEN
.UNDEFINE NOTE_LEN