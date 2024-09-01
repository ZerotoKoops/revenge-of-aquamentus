songOfHealingStart:
	tempo 96
songOfHealingChannel2:
	duty $02
	env $0 $03
	vol $9
.rept 2
; Measure 1,2
	octave 5
	beat b Q a Q f Q
.endr
; Measure 3
	beat b Q a Q e E1 d E2
; Measure 4
	beat e HF+Q
	cmdff

songOfHealingChannel3:
	duty $02
	env $0 $03
	vol $0
	beat gs3 10
	vol $5
.rept 2
; Measure 1,2
	octave 5
	beat b Q a Q f Q
.endr
; Measure 3
	beat b Q a Q e E1 d E2
; Measure 4
	beat e HF+Q-10
	cmdff

songOfHealingChannel5:
	duty $0e
	beat r 2*(HF+Q) r 2*(HF+Q)
	cmdff

songOfHealingChannel7:
	cmdf0 $00
	beat $00 2*(HF+Q) $00 2*(HF+Q)
	cmdff