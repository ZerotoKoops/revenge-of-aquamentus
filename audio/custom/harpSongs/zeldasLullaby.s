zeldasLullabyStart:
	tempo 140
zeldasLullabyChannel2:
	duty $02
	env $0 $03
	vol $9
.rept 2
; Measure 1,3
	octave 5
	beat b HF ou d Q
; Measure 2,4
	octaved
	beat a HF+Q
.endr
; Measure 5
	beat b HF ou d Q
; Measure 6
	beat a HF g Q
; Measure 7
	beat d HF+Q
	cmdff

zeldasLullabyChannel3:
	duty $02
	env $0 $03
	vol $0
	beat gs3 10
	vol $5
.rept 2
; Measure 1,3
	octave 5
	beat b HF ou d Q
; Measure 2,4
	octaved
	beat a HF+Q
.endr
; Measure 5
	beat b HF ou d Q
; Measure 6
	beat a HF g Q
; Measure 7
	beat d HF+Q-10
	cmdff

zeldasLullabyChannel5:
	duty $0e
	beat r 3*(HF+Q) r 3*(HF+Q) r HF+Q
	cmdff

zeldasLullabyChannel7:
	cmdf0 $00
	beat $00 3*(HF+Q) $00 3*(HF+Q) $00 HF+Q
	cmdff