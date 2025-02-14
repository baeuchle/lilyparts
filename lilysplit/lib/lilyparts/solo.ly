% © CC-BY-SA 4.0 Bjørn Bäuchle, see file LICENSE

%{
  Provides
    \solo N? music
%}

#(if (defined? 'SOLO_LY_ALREADY_INCLUDED)
 (ly:warning "solo.ly has already been included, crossing fingers!")
)
#(define SOLO_LY_ALREADY_INCLUDED #t)

$(if (not (defined? 'SPANS_LY_ALREADY_INCLUDED))
  (ly:error "spans.ly must be included before solo.ly")
)

solo = #(define-music-function
  (middleCPos musix)
  ((number? 1) ly:music?)
  (namedSpan "Solo" middleCPos musix)
)
