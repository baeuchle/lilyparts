%{
  Provides \namedSpan "text" ly:music which sets a sequence of music
  into some kind of spanners which have a given name.

  PROBLEM: Currently, this works with Staff.ottavation, but that means
  it is neither nestable nor does it go together with, well, ottavation.
%}

#(if (defined? 'SPANS_LY_ALREADY_INCLUDED)
 (display "spans.ly has already been included, crossing fingers!")
)
#(define SPANS_LY_ALREADY_INCLUDED #t)

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
