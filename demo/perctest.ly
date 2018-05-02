\include "gomp/head.ly"
hasEins = ##t
\include "gomp/calc.ly"
#(set-global-staff-size 32)

#(define percTable '(
        (hihat cross #f 4)
        (snare xcircle #f 2)
        (hightom xcircle #f -2)
        (lowtom xcircle #f -4)
        ))

global = {}
gitEinsS = \relative c {
  \namedSpan "Normal notes" { c4 c c c }
  \namedSpan "Notes inside \perc" \perc { c8 c d d e-- e f-> f }
  \namedSpan "drums inside \perc" \perc \drummode { hh4 sn r8 toml tomh4 }
  \namedSpan "unfolded and unknown" \perc \drummode { \repeat unfold 6 hh8 cymr4 }
  \bar "|."
}
gitDiviS = { s1*4 }
\include "gomp/stimmen.ly"

\book {
  \header {
    title = "Test für Perkussive Gitarren"
  }
  \include "gomp/paper.ly"
  \include "gomp/score.ly"
}
