%{
  Provides
    \straight music
%}

#(if (defined? 'STRAIGHT_LY_ALREADY_INCLUDED)
 (display "straight.ly has already been included, crossing fingers!")
)
#(define STRAIGHT_LY_ALREADY_INCLUDED #t)

#(if (not (defined? 'SPANS_LY_ALREADY_INCLUDED))
  #{ \include "spans.ly" #}
)

straight = #(define-music-function
  (parser location musix)
  (ly:music?)
  #{ \namedSpan "Straight" #musix #}
)

