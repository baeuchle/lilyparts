\include "gomp/head.ly"
hasEins = ##t
\include "gomp/calc.ly"
#(set-global-staff-size 32)

global = {}
gitEinsS = \relative c {
  c4 c
  \clef "G"
  \perc { c c c c }
  c c
  \perc \drummode { hh4 sn toml tomh }
  \clef "G_15"
  c c
  \perc \drummode { hh4 sn toml tomh }
  c c
  \bar "|."
}
gitDiviS = { s1*2 }
\include "gomp/stimmen.ly"

\book {
  \header {
    title = "Test für Perkussive Gitarren"
  }
  \include "gomp/paper.ly"
  \include "gomp/score.ly"
}
