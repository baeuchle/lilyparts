% © CC-BY-SA 4.0 Bjørn Bäuchle, see file LICENSE

\version "2.24.3"

\include "lilyparts/head.ly"
hasEins = ##t
\include "lilyparts/calc.ly"
#(set-global-staff-size 24)
\include "test-helper.ly"

#(define percTable '(
        (hihat cross #f 4)
        (snare xcircle #f 2)
        (hightom triangle #f -2)
        (lowtom diamond #f -4)
        ))

gitEinsS = \relative c {
  \perc \drummode { \mark\default hh4-> sn^\markup{markup} tomh8 toml cymr r R1 }
  \mark\default \perc { \drummode {sn8} c8 d e f d c \drummode {tomh8} }
  \mark\default \perc \drummode { \repeat volta 3 { \repeat unfold 4 hh4 } \alternative { \repeat unfold 8 sn8 { \repeat tremolo 4 { toml16 tomh } \repeat tremolo 8 { toml32 tomh } }}}
  \mark\default \repeat unfold 16 c4
  \fine
}

\include "lilyparts/stimmen.ly"

\book {
  \header {
    title = "Test für perkussive Gitarren"
  }
  \include "lilyparts/paper.ly"
  \include "lilyparts/score.ly"
  \markuplist {
    \wordwrap-lines \bold { Percussion in normal voice systems }
    \wordwrap-lines { \bold\box{A}: Test "\perc" for the 4 defined drums, an undefined drum, rest, multirest, RehearsalMark }
    \wordwrap-lines { \bold\box{B}: Normal notes inside "\perc" between drums }
    \wordwrap-lines { \bold\box{C}: Repeat volta inside "\perc" }
    \wordwrap-lines { \bold\box{D}: Normal notes in the voice }
  }
}
