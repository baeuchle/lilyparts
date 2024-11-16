% © CC-BY-SA 4.0 Bjørn Bäuchle, see file LICENSE

\version "2.24.3"

\include "lilyparts/head.ly"
hasEins = ##t
\include "lilyparts/calc.ly"
#(set-global-staff-size 24)

#(define percTable '(
        (hihat cross #f 4)
        (snare xcircle #f 2)
        (hightom xcircle #f -2)
        (lowtom xcircle #f -4)
        ))

global = {}
gitEinsS = \relative c {
  \set Score.rehearsalMarkFormatter = #format-mark-box-alphabet
  \mark #1 c4 c c c
  \mark #2 \perc { d1 }
  \mark #3 \perc \drummode { hh4 sn r8 toml tomh4 }
  \mark #4 \perc \drummode { \repeat unfold 6 hh8 cymr4 }
  \bar "|."
}
gitDiviS = { s1*4 }

\include "lilyparts/stimmen.ly"

\book {
  \header {
    title = "Test für perkussive Gitarren"
  }
  \include "lilyparts/paper.ly"
  \include "lilyparts/score.ly"
  \markuplist {
    \wordwrap { \bold { The above score should show the following: }}
    \wordwrap { \box{A}: Four fourths of middle cs }
    \wordwrap { \box{B}: normal note inside a "\perc" environment. }
    \wordwrap { \hspace #2 This part generates a \with-color #(x11-color 'orange) warning: \bold { No predefined NoteHead found for ridecymbal } }
    \wordwrap { \box{C}: Known drums inside "\perc". should look like: f' cross, d' circled cross, rest, e circled cross, g circled cross. }
    \wordwrap { \box{D}: Known drums in unfolded repeat (f' cross) and one unknown drum (slash) inside "\perc". ) }
    \wordwrap { \hspace #2 This part generates a \with-color #(x11-color 'orange) warning: \bold { This is not a drum! MIDI output unspecified } }
  }
}
