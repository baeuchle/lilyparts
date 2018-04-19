%{
  Kopfdefinitionen für meine Lilypond-Dateien.

  Hier sollte alles definiert werden, was geladen werden kann, bevor
  einzelstimmen.pl irgendwas aufruft.

%}

\version "2.18.2"

#(use-modules (guile-user))
% setzt showAlle auf true, außer wenn auf cmdline ausgeschaltet.
% setzt dann showPart, showEins etc auf diesen Wert, außer wenn auf cmdline anders definiert.
% setzt auch hasEins, hasZwei etc auf false.
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

percLines = #2
#(define percTable '(
                   ))

namedSpan = #(define-music-function
  (parser location name musix)
  (string? ly:music?)
  #{
    \ottava #0
    \set Staff.ottavation = #name
    #musix
    \ottava #0
  #}
) 

divisi = #(define-music-function
  (parser location yield normal additional)
  (boolean? ly:music? ly:music?)
  (if yield
  #{
    \namedSpan "divisi" << #additional \\ #normal >>
  #}
  #{
    <<
      #normal
      \context Staff = "diviGit" {
        \startStaff #additional \stopStaff
      }
    >>
  #}
  )
) 

solo = #(define-music-function
  (parser location musix)
  (ly:music?)
  #{ \namedSpan "Solo" #musix #}
)

bassAchtva = \markup { \musicglyph #"pedal.*" }
#(define-markup-command
  (bassAchtvaExplain layout props maybe)
  (boolean?)
  (if maybe
  (interpret-markup layout props #{
    \markup { \musicglyph #"pedal.*": Bassgitarre 1 Oktave höher }
  #})
  (interpret-markup layout props #{ "" #})
  )
)

bassTacet = #(define-music-function
  (parser location musix)
  (ly:music?)
  #{ \namedSpan "Bass tacet" #musix #}
)
