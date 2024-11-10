% © CC-BY-SA 4.0 Bjørn Bäuchle, see file LICENSE

#(if (defined? 'ATTACCA_LY_ALREADY_INCLUDED)
 (ly:warning "attacca.ly has already been included, crossing fingers!")
)
#(define ATTACCA_LY_ALREADY_INCLUDED #t)

attacca = {
  \once \override Score.RehearsalMark #'break-visibility = #begin-of-line-invisible
  \once \override Score.RehearsalMark #'direction = #DOWN
  \once \override Score.RehearsalMark #'font-size = 1
  \once \override Score.RehearsalMark #'self-alignment-X = #right
  \mark \markup{\bold Attacca}
}

