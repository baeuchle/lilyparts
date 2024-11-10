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
  \repeat volta 2 { \divisi ##f #1 { c4 c2 c4 } \relative c' { as2 as4 as } }
  \repeat unfold 2 { \divisi ##f #1 { c4 c c c } \relative c' { as4 as as as } }
  \repeat percent 2 { \divisi ##f #1 { c4 c c c } \relative c' { a2 a } }
  \repeat tremolo 16 { \divisi ##f #1 { c32 c' } \relative c' { a32 as } }
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
  \repeat volta 2 { \divisi #showEins #1 { g4 g2 g4 } \relative c' { es2 es4 es } }
  \repeat unfold 2 { \divisi #showEins #1 { g4 g g g } \relative c' { es4 es es es } }
  \repeat percent 2 { \divisi #showEins #1 { g4 g g g } \relative c' { e4 e e e } }
  \melodieZ
  \melodieZ
  \bar "|."
}
gitDiviS = { s1*18 }

\include "gomp/stimmen.ly"

\book {
  \header {
    title       = "Ossia-Test"
    instrument  = \instruments
  }
  \include "gomp/paper.ly"
  \include "gomp/score.ly"
}
