% © CC-BY-SA 4.0 Bjørn Bäuchle, see file LICENSE
\version "2.24.3"

\include "lilyparts/head.ly"
hasEins = ##t
\include "lilyparts/calc.ly"
#(set-global-staff-size 24)
\include "test-helper.ly"

#(define percTable '((hihat cross #f 3)))

variable = { c4 }

gitEinsS = \relative c' {
  \diviMark #0 c4 % NoteEvent
  \diviMark #1 <c e>4 % EventChord
  \diviMark #2 { c8 d } % SequentialMusic (NoteEvent)
  \diviMark #3 { <c e>8 d8 } % SequentialMusic (EventChord)
  \diviMark #4 \relative c c8 % RelativeOctaveMusic (NoteEvent)
  \diviMark #5 \relative c, <c' e> % RelativeOctaveMusic (EventChord)
  \diviMark #6 \relative c' { c,8 d } % RelativeOctaveMusic (SequentialMusic (NoteEvent))
  \diviMark #7 \relative c'' { <c,, e>8 d } % RelativeOctaveMusic (SequentialMusic (EventChord))
  \diviMark #8 r4 % RestEvent
  \diviMark #9 R1 % MultiMeasureRestMusic
  \diviMark #10 c2->
  \diviMark #11 << c2 \\ a2 >>
  s1
  \mark\default
  \diviMark #1 \variable % make sure \variable is not changed:
  \diviMark #2 \variable
  \variable
  \diviMark #0 \diviMark #1 \variable % put two marks
  \mark\default
  \diviMark #1 \repeat unfold 2 { c4 d e f f e d c } \alternative { b1 d1 }
  \diviMark #2 \repeat volta 2 { c4 b a g g a b c }
  \diviMark #3 \repeat volta 2 { c4 d e f f e d c } \alternative { b1 d1 }
  \diviMark #4 \repeat percent 2 { c4 b a g g a b c }
  \diviMark #5 \repeat tremolo 6 { c16 d } e4
  \diviMark #6 { \mark\default c4 d8 e d c d e d4 c c2 }
  \mark\default
  \diviMark #1 << #(firstMark +1 (markup #:box "2") #{c4 d e d#})
               \\ #(firstMark +1 (markup #:box "3") #{a2 b#}) >>
  \fine
}
\include "lilyparts/stimmen.ly"

\book {
  \header {
    title = "\diviMark and \firstMark"
  }
  \include "lilyparts/paper.ly"
  \include "lilyparts/score.ly"
  \markuplist {
    \wordwrap-lines \bold { Tests the correct application of "\diviMark" to various types of music. }
    \wordwrap-lines { \bold{Before \box A}: Each c and rest has a diviMark, from 0 through 12: }
    \wordwrap-lines { \hspace #2 0: \triangle ##f above; \box{1} above, \box{2} below, \circle{3} above, \circle{4} below, 5: \scale #'(1 . -1) { \triangle ##f } below, all else \triangle ##t }
    \wordwrap-lines { \bold\box{A}: Make sure variables are left unchanged by "\diviMark"; }
    \wordwrap-lines { \hspace #2 Expectation: \box{1} above, \box{2} below, no mark, \box{1} and \triangle ##f both above }
    \wordwrap-lines { \bold\box{B}: Various repeats: }
    \wordwrap-lines { \hspace #2 \box{1} unfold (diviMark is set on first note of each repetition) }
    \wordwrap-lines { \hspace #2 \box{2} volta (without alternatives) }
    \wordwrap-lines { \hspace #2 \circle{3} volta (with alternatives) }
    \wordwrap-lines { \hspace #2 \circle{4} percent repeat }
    \wordwrap-lines { \hspace #2 \scale #'(1 . -1) { \triangle ##f } tremolo repeat }
    \wordwrap-lines { \bold\box{C}: No "\diviMark!" Rehearsal mark is the first item of music.  \with-color #red \bold { Don't do this. }}
    \wordwrap-lines { \bold\box{D}: Test triple mark: \box{1} around simultaneous music, \box{2} in
    its first voice (the fourths) and \box{3} in its second voice (the halves) }
  }
}
