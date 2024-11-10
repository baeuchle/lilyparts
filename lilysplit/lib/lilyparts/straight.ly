% © CC-BY-SA 4.0 Bjørn Bäuchle, see file LICENSE

%{
  Provides
    \straight music
%}

#(if (defined? 'STRAIGHT_LY_ALREADY_INCLUDED)
 (ly:warning "straight.ly has already been included, crossing fingers!")
)
#(define STRAIGHT_LY_ALREADY_INCLUDED #t)

$(if (not (defined? 'SPANS_LY_ALREADY_INCLUDED))
  (ly:error "spans.ly must be included before straight.ly")
)

straight = #(define-music-function
  (parser location musix)
  (ly:music?)
  #{ \namedSpan "Straight" #musix #}
)

