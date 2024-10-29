%{
  Head definitions for GOMP lilypond files.
%}

\version "2.24.3"
\include "articulate.ly"

#(if (defined? 'HEAD_LY_ALREADY_INCLUDED)
  (ly:warning "head.ly has already been included, crossing fingers!")
)
#(define HEAD_LY_ALREADY_INCLUDED #t)

% make includes relative for this file (and set it to default at the end):
#(begin
  (define includes_are_relative (ly:get-option 'relative-includes))
  (ly:set-option 'relative-includes #t)
  (ly:debug (ly:command-line-code))
  (ly:debug (ly:command-line-options))
  (use-modules (guile-user))
  ; sets showAlle to true, except when disabled on command line.
  ; then, sets showPart, showEins etc to that value, except defined differently on command line.
  ; then, sets hasEins etc to false.
  ; Also reads gitver, lilyver and makeMidi from command line.

  (define gitver   (if (defined? 'gitver  ) gitver   ""))
  (define lilyver  (if (defined? 'lilyver ) lilyver  ""))
  (define makeMidi (if (defined? 'makeMidi) makeMidi #f))
  (define showAlle (if (defined? 'showAlle) showAlle #t))
  (define showPart (if (defined? 'showPart) showPart showAlle))
  (define showEins (if (defined? 'showEins) showEins showAlle)) (define hasEins #f)
  (define showZwei (if (defined? 'showZwei) showZwei showAlle)) (define hasZwei #f)
  (define showDrei (if (defined? 'showDrei) showDrei showAlle)) (define hasDrei #f)
  (define showVier (if (defined? 'showVier) showVier showAlle)) (define hasVier #f)
  (define showBass (if (defined? 'showBass) showBass showAlle)) (define hasBass #f)
  (define showRyth (if (defined? 'showRyth) showRyth showAlle)) (define hasRyth #f)
  (define showDrum (if (defined? 'showDrum) showDrum showAlle)) (define hasDrum #f)
  (define showOkta (if (defined? 'showOkta) showOkta showAlle)) (define hasOkta #f)
  (define showElec (if (defined? 'showElec) showElec showAlle)) (define hasElec #f)
  (define showQuer (if (defined? 'showQuer) showQuer showAlle)) (define hasQuer #f)
  (define showSaxo (if (defined? 'showSaxo) showSaxo showAlle)) (define hasSaxo #f)
  (define showSaxb (if (defined? 'showSaxb) showSaxb showAlle)) (define hasSaxb #f)
  (define showMast (if (defined? 'showMast) showMast showAlle)) (define hasMast #f)
  (if (defined? 'mypapersize) (set-default-paper-size mypapersize))

  (ly:debug (string-append "git version: " gitver))
  (ly:debug (string-append "lily version: " lilyver))
  (ly:debug (if makeMidi "makeMidi" "make no Midi"))
  (ly:debug (if showAlle "showAlle" "show no Alle"))
  (ly:debug (if showPart "showPart" "show no Part"))
  (ly:debug (if showEins "showEins" "show no Eins"))
  (ly:debug (if showZwei "showZwei" "show no Zwei"))
  (ly:debug (if showDrei "showDrei" "show no Drei"))
  (ly:debug (if showVier "showVier" "show no Vier"))
  (ly:debug (if showRyth "showRyth" "show no Ryth"))
  (ly:debug (if showBass "showBass" "show no Bass"))
  (ly:debug (if showDrum "showDrum" "show no Drum"))
  (ly:debug (if showOkta "showOkta" "show no Okta"))
  (ly:debug (if showElec "showElec" "show no Elec"))
  (ly:debug (if showQuer "showQuer" "show no Quer"))
  (ly:debug (if showSaxo "showSaxo" "show no Saxo"))
  (ly:debug (if showSaxb "showSaxb" "show no Saxb"))
  (ly:debug (if showMast "showMast" "show no Mast"))

  ; Wir definieren für alle Instrumente eine *S*timme. Diese Variablen werden in stimmen.ly in Scores gepackt.
  (define gitDiviS #{#})
  (define gitEinsS #{#})
  (define gitZweiS #{#})
  (define gitDreiS #{#})
  (define gitVierS #{#})
  (define gitBassS #{#})
  (define gitOktaS #{#})
  (define gitElecS #{#})
  (define gitRythS #{#})
  (define querFltS #{#})
  (define saxAltAS #{#})
  (define saxAltBS #{#})
  (define percussS #{#})
  (define masterRS #{#})
  (define masterLS #{#})

  (define layout_variable #{#})
  (ly:set-option 'relative-includes includes_are_relative)
)

\include "spans.ly"
\include "divisi.ly"
\include "solo.ly"
\include "bass_in_guitar.ly"
\include "percussion_helpers.ly"
\include "straight.ly"
