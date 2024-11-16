% © CC-BY-SA 4.0 Bjørn Bäuchle, see file LICENSE
\version "2.24.3"

\include "lilyparts/head.ly"
hasEins = ##t
\include "lilyparts/calc.ly"
#(set-global-staff-size 24)
\include "test-helper.ly"

#(define percTable '((hihat cross #f 3)))

gitEinsS = \relative c' {
  \perc { \mark\default c^\markup "(Perc)" \drummode { sn2 hh4 } }
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
    \wordwrap-lines { \bold\box{A}: Test "\perc". Should be one normal note (4), one slash (2), one cross (4). }
    \wordwrap-lines { \hspace #2 \bold { This emits two expected \with-color #(x11-color 'orange) warnings: } }
    \wordwrap-lines { \hspace #4 1st note (c): \bold {This is not a drum! MIDI output unspecified} (still printed: ok) }
    \wordwrap-lines { \hspace #4 2nd note (sn): \bold {No predefined NoteHead found for snare} (replaced with slash: ok) }
    \wordwrap-lines { \hspace #2 \bold { \with-color #red { and one unexpected warning: } } }
    \wordwrap-lines { \hspace #4 \bold { WARNING: Unknown Type in transformDrumNotes: RehearsalMarkEvent }}
    \wordwrap-lines { \hspace #4 This is an open issue. }
    \wordwrap-lines { \bold\box{B}: Use "\bassAchtva" four times }
  }
}
