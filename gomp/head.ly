%{
  Head definitions for GOMP lilypond files.
%}

% make includes relative for this file (and set it to default at the end):
#(begin
  (define includes_are_relative (ly:get-option 'relative-includes))
  (ly:set-option 'relative-includes #t)
)

\version "2.18.2"

#(use-modules (guile-user))
% sets showAlle to true, except when disabled on command line.
% then, sets showPart, showEins etc to that value, except defined differently on command line.
% then, sets hasEins etc to false.
% Also reads gitver, lilyver and makeMidi from command line.
#(begin
  (if (not (and #t (defined? 'gitver))) (define gitver ""))
  (if (not (and #t (defined? 'lilyver))) (define lilyver ""))
  (if (not (and #t (defined? 'makeMidi))) (define makeMidi #f))
  (if (not (and #t (defined? 'showAlle))) (define showAlle #t))
  (if (not (and #t (defined? 'showPart))) (define showPart showAlle))
  (if (not (and #t (defined? 'showEins))) (define showEins showAlle)) (define hasEins #f)
  (if (not (and #t (defined? 'showZwei))) (define showZwei showAlle)) (define hasZwei #f)
  (if (not (and #t (defined? 'showDrei))) (define showDrei showAlle)) (define hasDrei #f)
  (if (not (and #t (defined? 'showVier))) (define showVier showAlle)) (define hasVier #f)
  (if (not (and #t (defined? 'showBass))) (define showBass showAlle)) (define hasBass #f)
  (if (not (and #t (defined? 'showDrum))) (define showDrum showAlle)) (define hasDrum #f)
  (if (not (and #t (defined? 'showOkta))) (define showOkta showAlle)) (define hasOkta #f)
  (if (not (and #t (defined? 'showElec))) (define showElec showAlle)) (define hasElec #f)
  (if (not (and #t (defined? 'showQuer))) (define showQuer showAlle)) (define hasQuer #f)
  (if (not (and #t (defined? 'showSaxo))) (define showSaxo showAlle)) (define hasSaxo #f)
  (if (not (and #t (defined? 'showSaxb))) (define showSaxb showAlle)) (define hasSaxb #f)
)

#(begin
  (set-default-paper-size "a4")
  (ly:set-option 'point-and-click #f)
)

% Wir definieren für alle Instrumente eine *S*timme. Diese Variablen werden in stimmen.ly in Scores gepackt.
gitDiviS = {}
gitEinsS = {}
gitZweiS = {}
gitDreiS = {}
gitVierS = {}
gitBassS = {}
gitOktaS = {}
gitElecS = {}
querFltS = {}
saxAltAS = {}
saxAltBS = {}
percussS = {}

\include "spans.ly"
\include "divisi.ly"
\include "solo.ly"
\include "bass_in_guitar.ly"
\include "percussion_helpers.ly"
\include "straight.ly"

#(ly:set-option 'relative-includes includes_are_relative)
