sunsSongStart:
	tempo 112
sunsSongChannel2:
	duty $02
	env $0 $02
	vol $9
; Measure 1
	octave 5
	beat a R2 f R3
; Measure 2
	octaveu
	beat d R1+R2 r R3+R1
	octaved
	beat a R2 f R3	
; Measure 3
	octaveu
	beat d R1+R2 r R3+Y1
	octaved
	beat g Y2 a Y3 b W8 ou c W9 d W10 e W11 f W12
; Measure 4
	beat g S1 g S2 g S3 g S4 g HF
	cmdff

sunsSongChannel3:
	duty $02
	env $0 $02
	vol $0
	beat gs3 10
	vol $5
; Measure 1
	octave 5
	beat a R2 f R3
; Measure 2
	octaveu
	beat d R1+R2 r R3+R1
	octaved
	beat a R2 f R3	
; Measure 3
	octaveu
	beat d R1+R2 r R3+Y1
	octaved
	beat g Y2 a Y3 b W8 ou c W9 d W10 e W11 f W12
; Measure 4
	beat g S1 g S2 g S3 g S4 g HF-10
	cmdff

sunsSongChannel5:
	duty $0e
	beat r R2+R3+HF r HF+HF
	cmdff

sunsSongChannel7:
	cmdf0 $00
	beat $00 R2+R3+HF $00 HF+HF
	cmdff