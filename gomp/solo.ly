%{
  Provides
    \solo music
%}

#(if (defined? 'SOLO_LY_ALREADY_INCLUDED)
 (display "solo.ly has already been included, crossing fingers!")
)
#(define SOLO_LY_ALREADY_INCLUDED #t)

#(if (not (defined? 'SPANS_LY_ALREADY_INCLUDED))
  #{ \include "spans.ly" #}
)

solo = #(define-music-function
  (parser location musix)
  (ly:music?)
  #{ \namedSpan "Solo" #musix #}
)
