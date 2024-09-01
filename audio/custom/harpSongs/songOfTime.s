songOfTimeStart:
	tempo 112
songOfTimeChannel2:
	duty $02
	env $0 $02
	vol $9
.rept 2
; Measure 1,2
	octave 5
	beat a Q d HF f Q
.endr
; Measure 3
	beat a E1 ou c E2 od b Q
	beat g Q f E1 g E2
; Measure 4
	beat a Q d Q
	beat c E1 e E2 d Q+W
	cmdff

songOfTimeChannel3:
	duty $02
	env $0 $02
	vol $0
	beat gs3 10
	vol $5
.rept 2
; Measure 1,2
	octave 5
	beat a Q d HF f Q
.endr
; Measure 3
	beat a E1 ou c E2 od b Q
	beat g Q f E1 g E2
; Measure 4
	beat a Q d Q
	beat c E1 e E2 d Q+W-10
	cmdff

songOfTimeChannel5:
	duty $0e
	beat r W r W r W r W r W
	cmdff

songOfTimeChannel7:
	cmdf0 $00
	beat $00 W $00 W $00 W $00 W $00 W
	cmdff