% © CC-BY-SA 4.0 Bjørn Bäuchle, see file LICENSE
\version "2.24.3"

\include "lilyparts/head.ly"
hasEins = ##t
\include "lilyparts/calc.ly"
#(set-global-staff-size 24)
\include "test-helper.ly"

#(define percTable '((hihat cross #f 3)))

gitEinsS = \relative c' {
  \mark\default
  c^\bassAchtva c^\bassAchtva c^\bassAchtva c^\bassAchtva
  \break
}
\include "lilyparts/stimmen.ly"

\book {
  \header {
    title       = "functions from head.ly"
  }
  \include "lilyparts/paper.ly"
  \include "lilyparts/score.ly"
  \markuplist {
    \wordwrap-lines \bold { Test various lilypart functions: }
    \wordwrap-lines { \bold\box{A}: Use "\bassAchtva" four times }
  }
}
