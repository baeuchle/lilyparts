% © CC-BY-SA 4.0 Bjørn Bäuchle, see file LICENSE
\version "2.24.3"

\include "lilyparts/head.ly"
hasEins = ##t
hasZwei = ##t
\include "lilyparts/calc.ly"
\include "test-helper.ly"
#(set-global-staff-size 24)

melodie = \relative c { c4 c c d }
melodieZ = \relative c' { g4 a a g }
splitEins = \relative c' { c2 c4 b }
splitZwei = \relative c' { e2 f4 f }
gitEinsS = \relative c {
  \melodie
  \mark\markup\bold{\box A\circle 1} \divisi ##f #1 \melodie \splitEins
  \mark\markup\bold{\box A\circle 2} \divisi ##f #1 \melodie \splitEins
  \mark\markup\bold{\box A\circle 3} \divisi ##f #1 \melodie \splitEins
  \mark\markup\bold{\box B\circle 1} \divisi ##t #1 \melodie \splitEins
  \mark\markup\bold{\box B\circle 2} \divisi ##t #1 \melodie \splitEins
  \mark\markup\bold{\box B\circle 3} \divisi ##t #1 \melodie \splitEins
  \mark\markup\bold{\box C\circle 1} \divisi #showZwei #1 \melodie \splitEins
  \mark\markup\bold{\box C\circle 2} \divisi #showZwei #1 \melodie \splitEins
  \mark\markup\bold{\box C\circle 3} \divisi #showZwei #1 \melodie \splitEins
  R1
  \mark #4
  \divisi ##f #1 \repeat volta 2 \melodie \repeat volta 2 \splitEins
  \repeat volta 2 \divisi ##f #1 \melodie \splitEins
  \mark #5
  \repeat unfold 2 \divisi ##f #1 \melodie \splitEins
  \divisi ##f #1 \repeat unfold 2 \melodie \repeat unfold 2 \splitEins
  \mark #6
  \divisi ##f #1 \repeat percent 2 \melodie \repeat percent 2 \splitEins
  \fine
}
gitZweiS = \relative c' {
  \melodieZ
  \mark\markup\bold{\box A\circle 1} \unMarkedDivisi ##f       \melodieZ \splitZwei
  \mark\markup\bold{\box A\circle 2} \unMarkedDivisi ##t       \melodieZ \splitZwei
  \mark\markup\bold{\box A\circle 3} \unMarkedDivisi #showEins \melodieZ \splitZwei
  \mark\markup\bold{\box B\circle 1} \unMarkedDivisi ##f       \melodieZ \splitZwei
  \mark\markup\bold{\box B\circle 2} \unMarkedDivisi ##t       \melodieZ \splitZwei
  \mark\markup\bold{\box B\circle 3} \unMarkedDivisi #showEins \melodieZ \splitZwei
  \mark\markup\bold{\box C\circle 1} \unMarkedDivisi ##f       \melodieZ \splitZwei
  \mark\markup\bold{\box C\circle 2} \unMarkedDivisi ##t       \melodieZ \splitZwei
  \mark\markup\bold{\box C\circle 3} \unMarkedDivisi #showEins \melodieZ \splitZwei
  R1
  \mark #4
  \divisi #showEins #2 \repeat volta 2 \melodieZ \repeat volta 2 \splitZwei
  \repeat volta 2 \divisi #showEins #2 \melodieZ \splitZwei
  \mark #5
  \repeat unfold 2 \divisi #showEins #2 \melodieZ \splitZwei
  \divisi #showEins #2 \repeat unfold 2 \melodieZ \repeat unfold 2 \splitZwei
  \mark #6
  \divisi #showEins #2 \repeat percent 2 \melodieZ \repeat percent 2 \splitZwei
  \fine
}
gitDiviS = { s1*19 }

\include "lilyparts/stimmen.ly"

\book {
  \header {
    title = "Ossia-Test"
  }
  \include "lilyparts/paper.ly"
  \include "lilyparts/score.ly"

  \markuplist {
    \wordwrap-lines \bold { Tests various combinations of divided voices }
    \wordwrap-lines { The correct functioning needs to be assessed from all outputs (complete score and both excerpts)! All MIDI outputs are in the two main channels. }
    \wordwrap-lines { \bold{\box A\circle{1}} - \bold{\box C\circle 2} : Both voices always split. Git1 uses "\divisi", Git2 uses "\unMarkedDivisi". }
    \wordwrap-lines { \bold\box{A}: Git1 never yields, i.e., division always in ossia system. }
    \wordwrap-lines { \bold\box{B}: Git1 always yields, i.e., its division always in own system. }
    \wordwrap-lines { \bold\box{C}: Git1 yields for Git2, i.e., only in ossia if Git2 is not shown. }
    \wordwrap-lines { \bold\circle{1}: Git2 never yields, i.e., division always in ossia system. }
    \wordwrap-lines { \bold\circle{2}: Git2 always yields, i.e., its division always in own system. }
    \wordwrap-lines { \bold\circle{3}: Git2 yields for Git1, i.e., only in ossia if Git1 is not shown. }
    \wordwrap-lines { \bold\box{D} - \bold\box{F}: Both use "\divisi"; Git2 yields if Git1 is shown. }
    \wordwrap-lines { \bold\box{D}: repeat volta inside / around split }
    \wordwrap-lines { \bold\box{E}: repeat unfold inside / around split }
    \wordwrap-lines { \bold\box{F}: repeat percent }
    \wordwrap-lines \with-color #red \bold { TODO: automatically calculate length of gitDiviS }
  }
}
