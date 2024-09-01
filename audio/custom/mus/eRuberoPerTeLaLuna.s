musRuberoPerTeStart:
    tempo 140

    .redefine HI_VOL $6
    .redefine LO_VOL $4
.macro m_musRuberoPerTeChannel1Measure1
; Measure 1
    ;vibrato $e1
    env $0 $05
    duty $02
    vibrato $00
    vol HI_VOL+2
    beat \1 E2 \1 E1 \1 E2
.endm

musRuberoPerTeChannel1:
; Measure 1
    m_musRuberoPerTeChannel1Measure1 b4
; Measure 2-3
.rept 2 INDEX REPTCTR
    env $0 $04
    duty $01
    vol LO_VOL
.rept 3
    octave 4
    beat g E1+S3 b S4+S1
    beat b S2 b E2
.endr
; Measure 3c
    beat g E1

.ifeq REPTCTR 1
musRuberoPerTeChannel1Loop:
.endif
; Measure 3c
    m_musRuberoPerTeChannel1Measure1 b4
.endr

.rept 2 INDEX REPTCTR
.ifeq REPTCTR 0
; Measure 4
    rest HF
; Measure 4c
    octave 5
    duty $02
    vibrato $81
    vol HI_VOL
    env $0 $06
    beat c E1+S3 c S4+E1
    octaved
    env $0 $00
    beat b E2+E1
; Measure 5a
    octaveu
    ;beat fs E2+HF
    beat fs E2+E1+S3
    vol LO_VOL
    vibrato $01
    beat fs S4+Q

    vibrato $81
    vol HI_VOL
    octaved
    beat b Q 
; Measure 6
    octaveu
    beat c Q+S1 r S2 c E2 r S1
    beat c S2+E2 
    ;beat g Q+HF
    beat g Q+E1+S3
    vol LO_VOL
    vibrato $01
    beat g S4+Q
.else ; REPTCTR == 1
; Measure 11c
    env $0 $03
    vol HI_VOL
    beat b E2 b E1
    env $0 $00
    vibrato $81
    ;beat b E2+Q+S1 r S2
    beat b E2+E1
    vol LO_VOL
    vibrato $01
    beat b E2+S1 r S2
; Measure 12
    vibrato $81
    env $0 $05
    vol HI_VOL
    beat b E2 b E1+S3
    env $0 $00
    beat b S4+E1 
    octaveu
    ;beat fs E2+HF r E1
    beat fs E2+Q+S1
    vol LO_VOL
    vibrato $01
    beat fs S2+E2 r E1
; Measure 13c
    vibrato $81
    env $0 $05
    vol HI_VOL
    beat e E2+S1 e S2+E2
; Measure 14
    env $0 $00
    beat e Q+E1 d E2+S1
    ;beat c S2+E2+Q+Q r E1
    beat c S2+E2+E1+S3
    vibrato $01
    vol LO_VOL
    beat c S4+Q r E1
; Measure 15b
    vibrato $81
    vol HI_VOL
    octaved
    beat b E2
.endif
; Measure 7c,15c
    vibrato $81
    vol HI_VOL
    env $0 $06
    octave 5
    beat c E1+S3 c S4+E1 
    octaved
    env $0 $00
    ;beat b E2+Q+E1
    beat b E2+E1+S3
    vol LO_VOL
    vibrato $01
    beat b S4+E1
; Measure 8b,16b
    vibrato $81
    env $0 $06
    vol HI_VOL
    beat b E2
    env $0 $00
    beat b E1+S3 ou c S4+E1
    octaved
    ;beat a E2+Q+E1
    beat a E2+E1+S3
    vol LO_VOL
    vibrato $01
    beat a S4+E1
; Measure 9b,17b
    vibrato $81
    vol HI_VOL
    beat fs E2 g E1+S3

.ifeq REPTCTR 0
    ;env $0 $00
    ;beat fs S4+Q+E1+S3
    beat fs S4+Q
    vol LO_VOL
    vibrato $01
    beat fs E1+S3
; Measure 10a
    vibrato $81
    vol HI_VOL
    ;beat e S4+HF r E1
    beat e S4+Q+S1
    vol LO_VOL
    vibrato $01
    beat e S2+E2 r E1
; Measure 10d
    vibrato $00
    vol HI_VOL
    .rept 3    
        beat b E2 r E1
    .endr
.else ; REPTCTR == 1
; Measure 17
    ;env $0 $00
    ;beat fs S4+Q+S1
    beat fs S4+E1+S3
    vol LO_VOL
    vibrato $01
    beat fs S4+S1
; Measure 18a
    vibrato $81
    vol HI_VOL
    ;beat e S2+E2+Q
    beat e S2+E2+S1
    vol LO_VOL
    vibrato $01
    beat e S2+E2
.endif
.endr
; Measure 18c
    vibrato $00
    ;duty $02
    vol HI_VOL-1
    ;env $0 $00
.rept 2
    octave 3
    beat g E1 e E2
.endr
; Measure 19
    beat g E1
    ;duty $02
    vol HI_VOL
    vibrato $81
    env $0 $04
    octave 5
    beat e E2
.rept 3
    beat e E1 e E2
.endr
; Measure 20
    env $0 $00
    beat e Q c Q
    ;beat g HF r E1
    beat g Q+S1
    vibrato $01
    vol LO_VOL
    beat g S2+E2 r E1
; Measure 21a
    vibrato $81
    env $0 $04
    vol HI_VOL
    octave 5
    beat e E2
.rept 3
    beat e E1 e E2
.endr
; Measure 22
    env $0 $00
    beat e Q c Q
    ;beat g HF+Q r E1
    beat g Q+E1+S3
    vibrato $01
    vol LO_VOL
    beat g S4+Q r E1
; Measure 23a
    vibrato $81
    vol HI_VOL
    beat c E2+E1 g E2+S1 fs S2+E2
; Measure 24
    octaved
    beat b Q+E1 ou g E2
    beat fs E1+S3 e S4+E1
    octaved
    ;beat as E2+Q+E2
    beat as E2+Q
    vol LO_VOL
    vibrato $01
    beat as E2
; Measure 25b
    vibrato $81
    vol HI_VOL
    octaveu
    beat e S3+T7 r T8 e Q fs E1 e E2
; Measure 26-27
    beat e Q+E1 ds E2 cs Q
    beat ds E1 e E2+Q+E1 r E2+E1

    goto musRuberoPerTeChannel1Loop
    cmdff


.macro m_musRuberoPerTeChannel0Measure6
.rept \3
    beat \1 E1+S3 \2 S4+S1
    beat \2 S2 \2 E2
.endr
.endm

musRuberoPerTeChannel0:
    .redefine HI_VOL $5
    .redefine LO_VOL $3
; Measure 1
    m_musRuberoPerTeChannel1Measure1 fs4
; Measure 2-3
.rept 2 INDEX REPTCTR
    env $0 $04
    duty $01
    vol LO_VOL
.rept 3
    octave 4
    beat e E1+S3 g S4+S1
    beat g S2 g E2
.endr
; Measure 3c
    beat e E1

.ifeq REPTCTR 1
musRuberoPerTeChannel0Loop:
.endif
; Measure 3c
    m_musRuberoPerTeChannel1Measure1 fs4
.endr

; Measure 4-5
    rest W+W
; Measure 6-7
    env $0 $05
    duty $01
    vol HI_VOL
    m_musRuberoPerTeChannel0Measure6 a3 c4 4
; Measure 8
    m_musRuberoPerTeChannel0Measure6 g3 b3 2
; Measure 9
    m_musRuberoPerTeChannel0Measure6 b3 ds4 2
; Measure 10
    m_musRuberoPerTeChannel0Measure6 g3 b3 2
; Measure 11
    rest E1
    vibrato $00
    duty $02
    vol HI_VOL
    octave 4
    .rept 2    
        beat e E2 r E1
    .endr
    env $0 $03
    beat fs E2 fs E1 fs E2
; Measure 12
    env $1 $00
    duty $01
    vol LO_VOL
    octave 3
    beat b Q b E1 r E2
    beat a Q a E1 r E2
; Measure 13
    beat g Q g E1 r E2
    beat fs Q fs E1 r E2
; Measure 14
    octaveu
    beat c Q c E1 r E2
    octaved
    beat b Q b E1 r E2
; Measure 15
    beat a Q a E1 r E2
    octaveu
    beat c Q c E1 r E2
; Measure 16
    octaved
    beat b Q b E1 r E2
    beat a Q a E1 r E2
; Measure 17
    beat g Q g E1 r E2
    beat fs Q fs E1 r E2

; Measure 18
    duty $02
    vol HI_VOL-1
    env $0 $00
.rept 4
    octave 4
    beat e E1 od b E2
.endr
; Measure 19
    beat e E1
    ;duty $02
    vol HI_VOL
    env $0 $04
    beat e E2
.rept 3
    beat e E1 e E2
.endr
; Measure 20
    duty $03
    env $0 $06
    octave 3
    beat e Q e Q e Q e Q
; Measure 21
    beat e Q e Q e Q b E1 g E2+Q
; Measure 22b
    beat g Q g Q g Q
; Measure 23
    beat g Q g Q g Q ou c E1 od d E2+Q
; Measure 24b
    beat d Q d Q d E1 g E2
; Measure 25
    beat cs Q cs Q cs Q cs Q
; Measure 26
    octave 2
    beat b Q ou fs Q a Q fs E1 od b E2
; Measure 27
    env $0 $00
    vibrato $a1
    beat e Q+E1
    vol LO_VOL
    vibrato $01
    beat e E2 r E1

    goto musRuberoPerTeChannel0Loop
    cmdff


.macro m_musRuberoPerTeChannel4Measure1
; Measure 1
    duty HI_VOL
    octave 2
    .redefine NOTE_END_WAIT T8
    beat b E2 b E1 b E2
    .undefine NOTE_END_WAIT
.endm

.macro m_musRuberoPerTeChannel4Measure4
; Measure 4
.rept \3
    beat \1 Q
    beat \2 Q
.endr
.endm

musRuberoPerTeChannel4:
    .redefine HI_VOL $0e
    .redefine LO_VOL $0f
; Measure 1
    m_musRuberoPerTeChannel4Measure1
; Measure 2
; Measure 2-3
.rept 2 INDEX REPTCTR
    duty LO_VOL
    .redefine NOTE_END_WAIT T8
.rept 3
    octave 2
    beat b E1+S3 ou e S4+S1
    beat e S2 e E2
.endr
; Measure 3c
    octaved
    beat b E1
    .undefine NOTE_END_WAIT

.ifeq REPTCTR 1
musRuberoPerTeChannel4Loop:
.endif
; Measure 3c
    m_musRuberoPerTeChannel4Measure1
.endr
.rept 2 INDEX REPTCTR
; Measure 4-5,12-13
    duty LO_VOL
    m_musRuberoPerTeChannel4Measure4 e2 e3 4
; Measure 6-7,14-15
    m_musRuberoPerTeChannel4Measure4 a2 a3 4
; Measure 8,16
    m_musRuberoPerTeChannel4Measure4 e2 e3 2
; Measure 9,17
    m_musRuberoPerTeChannel4Measure4 b2 b3 2
.ifeq REPTCTR 0
; Measure 10-11
    m_musRuberoPerTeChannel4Measure4 e2 e3 3
; Measure 11c
    octave 2
    beat e E1
    duty HI_VOL
.redefine NOTE_END_WAIT T8
    beat b E2 b E1 b E2
.undefine NOTE_END_WAIT
.else ; REPTCTR == 1
; Measure 18
    duty HI_VOL
.rept 2
    octave 2
    beat e E1 b E2 ou e E1 od b E2
.endr
.endif
.endr
; Measure 19
    beat e E1 r E2+Q+HF
; Measure 20
    octave 2
    .redefine NOTE_END_WAIT T8
    beat a Q a Q a Q a Q
; Measre 21
    beat a Q a Q a Q b E1 ou c E2+Q
; Measure 22b
    beat c Q c Q c Q
; Measure 23
    beat c Q c Q c Q c E1 od g E2+Q
; Measure 24b
    beat g Q g Q g E1 g E2
; Measure 25
    beat fs Q fs Q fs Q fs Q
; Measure 26
    octave 1
    .undefine NOTE_END_WAIT
    beat b Q ou b Q ou ds Q od fs E1 b E2
; Measure 27
    beat e Q+S1
    duty LO_VOL
    beat e S2+E2 r E2

    goto musRuberoPerTeChannel4Loop
    cmdff

;musRuberoPerTeChannel6:
.define musRuberoPerTeChannel6 MUSIC_CHANNEL_FALLBACK EXPORT

.undefine HI_VOL
.undefine LO_VOL