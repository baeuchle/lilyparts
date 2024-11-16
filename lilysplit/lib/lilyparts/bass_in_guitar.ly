% © CC-BY-SA 4.0 Bjørn Bäuchle, see file LICENSE

%{
  Provides
    \bassAchtva (as markup)
    \bassAchtvaExplain (also markup)
    \bassTacet N? music
%}

#(if (defined? 'BASS_IN_GUITAR_LY_ALREADY_INCLUDED)
 (ly:warning "bass_in_guitar.ly has already been included, crossing fingers!")
)
#(define BASS_IN_GUITAR_LY_ALREADY_INCLUDED #t)

$(if (not (defined? 'SPANS_LY_ALREADY_INCLUDED))
  (ly:error "spans.ly must be included before bass_in_guitar.ly")
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
  (middleCPos musix)
  ((number? 1) ly:music?)
  (namedSpan "Bass tacet" middleCPos musix)
)
