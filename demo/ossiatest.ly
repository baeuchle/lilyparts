\include "gomp/head.ly"
hasEins = ##t
hasZwei = ##t
\include "gomp/calc.ly"
#(set-global-staff-size 32)

melodie = { c4 c c c }
global = {}
gitEinsS = \relative c {
  \melodie
  \divisi ##f       #1 { c4 c c c } \relative c' { a2 as }
  \divisi ##f       #1 { c4 c c c } \relative c' { a2 as }
  \divisi ##f       #1 { c4 c c c } \relative c' { a2 as }
  \divisi ##t       #1 { c4 c c c } \relative c' { a2 as }
  \divisi ##t       #1 { c4 c c c } \relative c' { a2 as }
  \divisi ##t       #1 { c4 c c c } \relative c' { a2 as }
  \divisi #showZwei #1 { c4 c c c } \relative c' { a2 as }
  \divisi #showZwei #1 { c4 c c c } \relative c' { a2 as }
  \divisi #showZwei #1 { c4 c c c } \relative c' { a2 as }
  \melodie
  \perc \drummode { hh4_\markup { perc } hh hh hh }
  \melodie
  \bar "|."
}
melodieZ = { g4 g g g }
gitZweiS = \relative c' {
  \melodieZ
  \unMarkedDivisi ##f       { g4 g g g } \diviMark #2 \relative c' { e2 es }
  \unMarkedDivisi ##t       { g4 g g g } \diviMark #2 \relative c' { e2 es }
  \unMarkedDivisi #showEins { g4 g g g } \diviMark #2 \relative c' { e2 es }
  \unMarkedDivisi ##f       { g4 g g g } \diviMark #2 \relative c' { e2 es }
  \unMarkedDivisi ##t       { g4 g g g } \diviMark #2 \relative c' { e2 es }
  \unMarkedDivisi #showEins { g4 g g g } \diviMark #2 \relative c' { e2 es }
  \unMarkedDivisi ##f       { g4 g g g } \diviMark #2 \relative c' { e2 es }
  \unMarkedDivisi ##t       { g4 g g g } \diviMark #2 \relative c' { e2 es }
  \unMarkedDivisi #showEins { g4 g g g } \diviMark #2 \relative c' { e2 es }
  \melodieZ
  \perc \drummode { sn4_\markup { perc } sn sn sn }
  \melodieZ
  \bar "|."
}
gitDiviS = { s1*13 }

\include "gomp/stimmen.ly"

\book {
  \header {
    title       = "Ossia-Test"
    instrument  = \instruments
  }
  \include "gomp/paper.ly"
  \include "gomp/score.ly"
}
