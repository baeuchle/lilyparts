% © CC-BY-SA 4.0 Bjørn Bäuchle, see file LICENSE
\version "2.24.3"

\include "lilyparts/head.ly"
hasEins = ##t
\include "lilyparts/calc.ly"
#(set-global-staff-size 32)

#(define percTable '((hihat cross #f 3)))

global = {}
variable = { c4 }
variableAcc = { c4-> }
gitEinsS = \relative c {
  \namedSpan "namedSpan" { c c c c }
  \solo { c c c c }
  \bassTacet { c c c c }
  \break
  \straight { c c c c }
  \perc { c^\markup "(Perc)" \drummode { sn2 hh4 } }
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
  \diviMark #9 R1\fermata
  \diviMark #1 \variableAcc % make sure \variableAcc is not changed:
  \diviMark #2 \variableAcc
  \variableAcc
  \diviMark #0 \diviMark #1 c4-> % put two marks
}
\include "lilyparts/stimmen.ly"

\book {
  \header {
    title       = "functions from head.ly"
  }
  \include "lilyparts/paper.ly"
  \include "lilyparts/score.ly"
}
