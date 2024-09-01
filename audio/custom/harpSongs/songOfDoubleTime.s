songOfDoubleTimeStart:
	tempo 100
songOfDoubleTimeChannel2:
	duty $02
	env $0 $03
	vol $9
.macro m_songOfDoubleTimeChannel2
; Measure 1,2
	tempo 100
	octave 5
	beat a E1 a E2 
	tempo 110
	beat d E1 d E2
	tempo 120
	beat f E1 f E2
; Measure 1,2
	tempo 130
	beat a E1 a E2 
	tempo 140
	beat d E1 d E2 
	tempo 150
	beat f E1 f E2
; Measure 3
	tempo 160
	beat as E1 as E2
	tempo 170
	beat e E1 e E2
	tempo 180
	beat g E1 g E2
; Measure 4
	tempo 150
	octaveu
	beat cs E1 cs E2
	tempo 120
	octaved 
	beat as E1 as E2
	tempo 100
	octaveu
	beat e E1
	tempo 90
	beat e E2
.endm
	m_songOfDoubleTimeChannel2
; Measure 5
	beat f HF+Q
	cmdff

songOfDoubleTimeChannel3:
	duty $02
	env $0 $03
	vol $0
	beat gs3 10
	vol $5
	m_songOfDoubleTimeChannel2
; Measure 5
	beat f HF+Q-10
	cmdff

songOfDoubleTimeChannel5:
; Measure 1
	tempo 100
	duty $0e
	beat r Q
	tempo 110
	beat r Q
	tempo 120
	beat r Q
; Measure 2
	tempo 130
	beat r Q
	tempo 140
	beat r Q
	tempo 150
	beat r Q
; Measure 3
	tempo 160
	beat r Q
	tempo 170
	beat r Q
	tempo 180
	beat r Q
; Measure 4
	tempo 150
	beat r Q
	tempo 120
	beat r Q
	tempo 100
	beat r E1
; Measure 4c-5
	tempo 90
	beat r E2+HF+Q
	cmdff

songOfDoubleTimeChannel7:
	cmdf0 $00
; Measure 1
	tempo 100
	beat $00 Q
	tempo 110
	beat $00 Q
	tempo 120
	beat $00 Q
; Measure 2
	tempo 130
	beat $00 Q
	tempo 140
	beat $00 Q
	tempo 150
	beat $00 Q
; Measure 3
	tempo 160
	beat $00 Q
	tempo 170
	beat $00 Q
	tempo 180
	beat $00 Q
; Measure 4
	tempo 150
	beat $00 Q
	tempo 120
	beat $00 Q
	tempo 100
	beat $00 E1
; Measure 4c-5
	tempo 90
	beat $00 E2+HF+Q
	cmdff