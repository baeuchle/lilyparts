\version "2.24.3"
\include "lilyparts/head.ly"
hasEins = ##t
hasZwei = ##t
\include "lilyparts/calc.ly"

global = { \time 4/4 \key c \major }
gitEinsS = \relative c' \repeat unfold 8 { c4 d e f <e g>1 }
gitZweiS = \relative c  \repeat unfold 8 { c4 g c b c1 }

\include "lilyparts/stimmen.ly"

\book {
  \header {
    title = "Lilysplit / lilyparts demo"
    composer = "Bjørn Bäuchle"
    tagline = ##f
  }
  \include "lilyparts/paper.ly"
  \include "lilyparts/score.ly"
}
