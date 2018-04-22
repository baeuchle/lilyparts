\include "gomp/head.ly"
hasEins = ##t
\include "gomp/calc.ly"
#(set-global-staff-size 32)

global = {}
variable = { c4 }
variableAcc = { c4-> }
gitEinsS = \relative c {
  \namedSpan "namedSpan" { c c c c }
  \solo { c c c c }
  \bassTacet { c c c c }
  \break
  \straight { c c c c }
  \perc { c^\markup "(Perc)" c c c }
  { c^\bassAchtva c^\bassAchtva c^\bassAchtva c^\bassAchtva }
  \break
  c8
  \diviMark #0 c8
  \diviMark #1 <c e>8
  \diviMark #2 { c8 }
  \diviMark #3 { <c e>4 }
  \diviMark #4 \relative c c
  \diviMark #5 \relative c, <c' e>
  \diviMark #6 \relative c' { c, }
  \diviMark #7 \relative c'' { <c,, e> }
  \diviMark #8 r4
  \diviMark #9 R1
  \diviMark #1 \variable % make sure \variable is not changed:
  \diviMark #2 \variable
  \variable
  % now the same, but with accented notes:
  \diviMark #0 \diviMark #1 c4 % put two marks
  \break
  c8->
  \diviMark #0 c8->
  \diviMark #1 <c e>8->
  \diviMark #2 { c8-> }
  \diviMark #3 { <c e>4-> }
  \diviMark #4 \relative c c->
  \diviMark #5 \relative c, <c' e>->
  \diviMark #6 \relative c' { c,-> }
  \diviMark #7 \relative c'' { <c,, e>-> }
  \diviMark #8 r4->
  \diviMark #9 R1\fermataMarkup
  \diviMark #1 \variableAcc % make sure \variableAcc is not changed:
  \diviMark #2 \variableAcc
  \variableAcc
  \diviMark #0 \diviMark #1 c4-> % put two marks
}
\include "gomp/stimmen.ly"

\book {
  \header {
    title       = "functions from head.ly"
  }
  \include "gomp/paper.ly"
  \include "gomp/score.ly"
}
