songOfStormsStart:
	tempo 160
songOfStormsChannel2:
	duty $02
	env $0 $03
	vol $9
.rept 2
; Measure 1,2
	octave 5
	beat d E1 f E2 ou d HF
.endr
; Measure 3
	beat e Q+R1 f R2 e R3
 	beat f R1 e R2 c R3
; Masure 4
	octaved
	beat a HF
	cmdff

songOfStormsChannel3:
	duty $02
	env $0 $03
	vol $0
	beat gs3 10
	vol $5
.rept 2
; Measure 1,2
	octave 5
	beat d E1 f E2 ou d HF
.endr
; Measure 3
	beat e Q+R1 f R2 e R3
 	beat f R1 e R2 c R3
; Masure 4
	octaved
	beat a HF-10
	cmdff

songOfStormsChannel5:
	duty $0e
	beat r 2*(HF+Q) r 2*(HF+Q)
	cmdff

songOfStormsChannel7:
	cmdf0 $00
	beat $00 2*(HF+Q) $00 2*(HF+Q)
	cmdff