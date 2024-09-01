invertedSongOfTimeStart:
	tempo 100
invertedSongOfTimeChannel2:
	duty $02
	env $0 $03
	vol $9
.macro m_invertedSongOfTimeChannel2
; Measure 1
	octave 5
	beat f Q
; Measure 2
	beat d HF a Q f Q
; Measure 3
	beat d HF a Q e Q+E1
; Measure 4a
	beat ds E2 d E1 cs E2
	beat c Q
.endm
	m_invertedSongOfTimeChannel2
; Measure 4d
	octaved
	beat b Q+HF
	cmdff

invertedSongOfTimeChannel3:
	duty $02
	env $0 $03
	vol $0
	beat gs3 10
	vol $5
	m_invertedSongOfTimeChannel2
; Measure 4
	octaved
	beat b Q+HF-10
	cmdff

invertedSongOfTimeChannel5:
	duty $0e
	beat r (Q+W) r (Q+W) r (Q+W)
	cmdff

invertedSongOfTimeChannel7:
	cmdf0 $00
	beat $00 (Q+W) $00 (Q+W) $00 (Q+W)
	cmdff