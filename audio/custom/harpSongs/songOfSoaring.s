songOfSoaringStart:
	tempo 120
songOfSoaringChannel2:
	duty $02
	env $0 $03
	vol $9
.rept 2
; Measure 1
	octave 5
	beat f E1 b E2 ou d Q
.endr
; Measure 2
	tempo 128
	octave 5
	beat f E1 b E2
	tempo 136
	octaveu
	beat d E1 od fs E2
	tempo 144
	octaveu
	beat c E1 ds E2
; Measure 3
	tempo 152
	octaved
	beat g E1 ou cs E2
	tempo 160
	beat e E1 od gs E2
	tempo 168
	octaveu
	beat d E1 f E2
; Measure 4
	tempo 176
	octaved
	beat a E1 ou ds E2
	tempo 184
	beat fs E1 od as E2
	tempo 192
	octaveu
	beat e E1 g E2
; Measure 5
	tempo 160
	beat gs E1 r S3 gs S4 gs HF
	cmdff


songOfSoaringChannel3:
	tempo 120
	duty $02
	env $0 $03
	vol $0
	beat gs3 10
	vol $5
.rept 2
; Measure 1
	octave 5
	beat f E1 b E2 ou d Q
.endr
; Measure 2
	tempo 128
	octave 5
	beat f E1 b E2
	tempo 136
	octaveu
	beat d E1 od fs E2
	tempo 144
	octaveu
	beat c E1 ds E2
; Measure 3
	tempo 152
	octaved
	beat g E1 ou cs E2
	tempo 160
	beat e E1 od gs E2
	tempo 168
	octaveu
	beat d E1 f E2
; Measure 4
	tempo 176
	octaved
	beat a E1 ou ds E2
	tempo 184
	beat fs E1 od as E2
	tempo 192
	octaveu
	beat e E1 g E2
; Measure 5
	tempo 160
	beat gs E1 r S3 gs S4 gs HF-10
	cmdff

songOfSoaringChannel5:
; Measure 1
	tempo 120
	duty $08
	octave 4
	beat b HF
	duty $0f
	beat b HF
; Measure 2
	tempo 128
	beat b Q
	tempo 136
	beat as Q
	tempo 144
	beat a Q
; Measure 3
	tempo 152
	beat gs Q
	tempo 160
	beat g Q
	tempo 168
	beat fs Q
; Measure 4
	tempo 176
	beat f Q
	tempo 184
	beat e Q
	tempo 192
	beat ds Q
; Measure 5
	tempo 160
	beat d Q
	duty $08
	beat d HF
	cmdff

/*
; Measure 1
	tempo 120
	duty $08
	octave 3
	rest W
; Measure 2
	tempo 128
	rest Q
	tempo 136
	rest Q
	tempo 144
	rest Q
; Measure 3
	tempo 152
	rest Q
	tempo 160
	rest Q
	tempo 168
	rest Q
; Measure 4
	tempo 176
	rest Q
	tempo 184
	rest Q
	tempo 192
	rest Q
; Measure 5
	tempo 160
	rest HF+Q
	cmdff
*/

songOfSoaringChannel7:
; Measure 1-2
	tempo 120
	cmdf0 $00
	beat $00 W
; Measure 2
	tempo 128
	beat $00 Q
	tempo 136
	beat $00 Q
	tempo 144
	beat $00 Q
; Measure 3
	tempo 152
	beat $00 Q
	tempo 160
	beat $00 Q
	tempo 168
	beat $00 Q
; Measure 4
	tempo 176
	beat $00 Q
	tempo 184
	beat $00 Q
	tempo 192
	beat $00 Q
; Measure 5
	tempo 160
	beat $00 HF+Q
	cmdff