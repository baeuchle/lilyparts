%{
  Provides
    \bassAchtva (as markup)
    \bassAchtvaExplain (also markup)
    \bassTacet music
%}

#(if (defined? 'BASS_IN_GUITAR_LY_ALREADY_INCLUDED)
 (display "bass_in_guitar.ly has already been included, crossing fingers!")
)
#(define BASS_IN_GUITAR_LY_ALREADY_INCLUDED #t)

#(if (not (defined? 'SPANS_LY_ALREADY_INCLUDED))
  #{ \include "spans.ly" #}
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

