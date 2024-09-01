eponasSongStart:
	tempo 100
eponasSongChannel2:
	duty $02
	env $0 $03
	vol $9
.rept 2
; Measure 1,2
	octave 6
	beat d E1 od b E2 a HF
.endr
; Measure 3
	octaveu
	beat d E1 od b E2 a Q b Q
; Measure 4
	beat a HF+Q
	cmdff

eponasSongChannel3:
	duty $02
	env $0 $03
	vol $0
	beat gs3 10
	vol $5
.rept 2
; Measure 1,2
	octave 6
	beat d E1 od b E2 a HF
.endr
; Measure 3
	octaveu
	beat d E1 od b E2 a Q b Q
; Measure 4
	beat a HF+Q-10
	cmdff

eponasSongChannel5:
	duty $0e
	beat r 2*(HF+Q) r 2*(HF+Q)
	cmdff

eponasSongChannel7:
	cmdf0 $00
	beat $00 2*(HF+Q) $00 2*(HF+Q)
	cmdff