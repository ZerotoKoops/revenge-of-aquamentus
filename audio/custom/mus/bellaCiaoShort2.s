musBellaCiaoShort2Start:
    tempo 120 ;115
musBellaCiaoShort2Channel1:
    .redefine HI_VOL $6
    .redefine LO_VOL $4
    .redefine OCT 4

; Measure 1
    vol $0
    beat gs3 HF+E1
musBellaCiaoShort2Channel1Measure1c:
    vol HI_VOL
    duty $02
    vibrato $a2
    env $0 $07
    octave OCT
    beat d E2 g E1 a E2
; Measure 2-3
.rept 2
    beat as E1 g E2+Q r E1
    beat d E2 g E1 a E2
.endr
; Measure 4
.rept 2
    beat as Q a E1 g E2
.endr
; Measure 5
    octaveu
.rept 3
    beat d Q
.endr
    beat c E1 d E2
; Measure 6
    beat ds E1 ds E2+Q r E1
    beat g E2 f E1 ds E2
; Measure 7
    beat g E1 d E2+Q r Q
    beat c E1 od as E2
; Measure 8 
    beat a Q ou d Q od as Q as Q
; Measure 9
    env $0 $00
    beat g Q+S1
    vol LO_VOL
    vibrato $02
    beat g S2+E2 r E1

    goto musBellaCiaoShort2Channel1Measure1c
    cmdff

musBellaCiaoShort2Channel0:
    .redefine HI_VOL $5
    .redefine LO_VOL $3

; Measure 1-3
    vol $0
    beat gs3 E1
    duty $03
    env $0 $03
    vol LO_VOL
    octave OCT-1
    beat as E2+E1
    beat as E2+E1
musBellaCiaoShort2Channel0Measure1c:
    octave OCT-1
    duty $03
    env $0 $03
    vibrato $00
    vol LO_VOL
.rept 9
    beat as E2+E1
.endr
    beat as E2
; Measure 4
    duty $02
    env $1 $00
    octave OCT
    vol HI_VOL
    vibrato $a2
    beat g Q+S1
    env $0 $00
    vol LO_VOL
    vibrato $02
    beat g S2+E2

    env $1 $00
    vol HI_VOL
    vibrato $a2
    beat f Q+S1
    env $0 $00
    vol LO_VOL
    vibrato $02
    beat f S2+E2
; Measure 5
    duty $02
    vibrato $a2
    env $1 $07
    vol HI_VOL
.rept 2
    beat g Q
.endr
    beat fs Q a E1 as E2
; Measure 6
    beat g E1 g E2+Q r E1
    beat as E2 a E1 g E2
; Measure 7
    beat a E1 g E2+Q r Q
    beat a E1 g E2
; Measure 8 
    beat fs Q a Q fs Q g Q
; Measure 9
    env $1 $00
    beat d Q+S1
    env $0 $00
    vol LO_VOL
    vibrato $02
    beat d S2+E2 r E1

    goto musBellaCiaoShort2Channel0Measure1c
    cmdff

.macro m_musBellaCiaoShort2Channel4Measure1
.rept \3
    duty HI_VOL
    beat \1 S1
    duty LO_VOL
    beat \1 T3 r T4
    duty HI_VOL
    beat \2 S3
    duty LO_VOL
    beat \2 T7 r T8
.endr
.endm

musBellaCiaoShort2Channel4:
    .redefine HI_VOL $0e
    .redefine LO_VOL $0f

; Measure 1-4,9
musBellaCiaoShort2Channel4Measure2:
.rept 7 INDEX REPTCTR2
    m_musBellaCiaoShort2Channel4Measure1 g2 g3 1
    m_musBellaCiaoShort2Channel4Measure1 d2 g3 1
.endr
; Measure 4c
    m_musBellaCiaoShort2Channel4Measure1 f2 f3 2
; Measure 5
    m_musBellaCiaoShort2Channel4Measure1 ds2 ds3 2
    m_musBellaCiaoShort2Channel4Measure1 d2 d3 2
; Measure 6
    m_musBellaCiaoShort2Channel4Measure1 c2 ds3 1
    m_musBellaCiaoShort2Channel4Measure1 g2 ds3 1
    m_musBellaCiaoShort2Channel4Measure1 c2 ds3 1
    m_musBellaCiaoShort2Channel4Measure1 ds2 ds3 1
; Measure 7
.rept 2
    m_musBellaCiaoShort2Channel4Measure1 g2 g3 1
    m_musBellaCiaoShort2Channel4Measure1 d2 g3 1
.endr
; Measure 8
.rept 2
    m_musBellaCiaoShort2Channel4Measure1 a2 fs3 1
    m_musBellaCiaoShort2Channel4Measure1 d2 fs3 1
.endr

    goto musBellaCiaoShort2Channel4Measure2
    cmdff

.define musBellaCiaoShort2Channel6 MUSIC_CHANNEL_FALLBACK EXPORT