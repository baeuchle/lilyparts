% © CC-BY-SA 4.0 Bjørn Bäuchle, see file LICENSE
\version "2.24.3"

\include "lilyparts/head.ly"
hasEins = ##t
\include "lilyparts/calc.ly"
#(set-global-staff-size 24)
\include "test-helper.ly"

testMelody = \relative c' { c4 << d \\ b >> c\3 c-1 <a c e>8 r r2 c4-. }

gitEinsS = \relative c' {
  \mark\default \testMelody
  \ottava 1 \mark\default \testMelody \ottava 0
  \testMelody
  \namedSpan "namedSpan" { \mark\default \testMelody }
  \testMelody
  \ottava 1 \mark\default \testMelody \ottava 0
  \testMelody
  \solo { \mark\default \repeat unfold 8 c4 }
  \clef "F"
  \mark\default \testMelody
  \bassTacet 6 { \mark\default \testMelody }
  \clef "G_8"
  \straight { \mark\default \testMelody }
  \testMelody
  \fine
}
\include "lilyparts/stimmen.ly"

\book {
  \header {
    title = "Various \\namedSpan commands"
  }
  \include "lilyparts/paper.ly"
  \include "lilyparts/score.ly"
  \markuplist {
    \line \bold { This tests our "\\namedSpan" commands. }
    \wordwrap { \box{A}: Two measures of our test melody. Repeated after each test to make sure it looks like in the beginning. }
    \line { \box{B}: An ottavation 8vb }
    \line { \box{C}: "\\namedSpan" „namedSpan“. }
    \line { \box{D}: Normal ottavation again: Make sure the text is still ok! }
    \line { \box{E}: Special span "\solo", with unfolded repeat. }
    \line { \box{F}: Make sure a new clef can shift middleC }
    \line { \box{G}: Special span "\bassTacet 6" with explicit middleCPos argument 6 (due to F clef)}
    \line { \box{H}: Special span "\straight" with default clef G\sub{8} }
  }
}
