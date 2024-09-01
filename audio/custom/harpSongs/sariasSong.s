sariasSongStart:
	tempo 130
sariasSongChannel2:
	duty $02
	env $0 $02
	vol $9
; Measure 1
	octave 5
	beat f E1 a E2 b Q
; Measure 2
	beat f E1 a E2 b Q
; Measure 3
	beat f E1 a E2 b E1 ou e E2
; Measure 4
	beat d Q od b E1 ou c E2
; Measure 5
	octaved
	beat b E1 g E2 e Q
	cmdff

sariasSongChannel3:
	duty $02
	env $0 $02
	vol $0
	beat gs3 10
	vol $5
; Measure 1
	octave 5
	beat f E1 a E2 b Q
; Measure 2
	beat f E1 a E2 b Q
; Measure 3
	beat f E1 a E2 b E1 ou e E2
; Measure 4
	beat d Q od b E1 ou c E2
; Measure 5
	octaved
	beat b E1 g E2 e Q-10
	cmdff

sariasSongChannel5:
	duty $0e
	beat r HF+HF+HF r HF+HF
	cmdff

sariasSongChannel7:
	cmdf0 $00
	beat $00 HF+HF+HF $00 HF+HF
	cmdff