% © CC-BY-SA 4.0 Bjørn Bäuchle, see file LICENSE

%{
  Provides \namedSpan "text" (middleCPos) ly:music which sets a sequence of
  music into some kind of spanners which have a given name. middleCPos defaults
  to 1, which is the correct value for a G_8 clef. It must be equal to the
  current context's middleCPosition, but we can only check that, not read it.

  PROBLEM: Currently, this works with Staff.ottavation, but that means
  it is neither nestable nor does it go together with, well, ottavation.
%}

#(if (defined? 'SPANS_LY_ALREADY_INCLUDED)
 (ly:warning "spans.ly has already been included, crossing fingers!")
)
#(define SPANS_LY_ALREADY_INCLUDED #t)

namedSpan = #(define-music-function
  (name middleCPos musix)
  (string? (number? 1) ly:music?)
  (make-sequential-music (list
    ; test middleCPos:
    (make-apply-context
      (lambda (context)
        (if (not (= middleCPos (ly:context-property context 'middleCPosition)))
          (ly:error "\\namedSpan \"~a\" N {...} must be called with N being the correct current middleCPosition (defaults to 1)! Received ~a, current value is ~a" name middleCPos (ly:context-property context 'middleCPosition))
        )
      )
    )
    ; this starts the text spanner
    (make-music 'OttavaEvent 'ottava-number 1)
    ; here, we set the text for our spanner as given in the argument.
    (context-spec-music
      (make-property-set 'ottavation name)
      'Staff
    )
    ; and here we reset middleCPosition. We checked before that middleCPos is
    ; the correct value.
    (context-spec-music
      (make-sequential-music (list
        (make-property-set 'middleCPosition middleCPos)
      ))
      'Staff
    )
    ; this is the music that is being spanned:
    musix
    ; stop the text spanner
    (make-music 'OttavaEvent 'ottava-number 0)
    ; now we need to unset the middleCPosition: It is not sufficient to
    ; simply set it back, because if it is set by us, then a clef change will
    ; not touch it. Thus, we need to actively delete our meddling.
    (context-spec-music
      (make-music
        'PropertyUnset
        'symbol 'middleCPosition
      )
      'Voice
    )
    ; the same comment about unsetting applies to the ottavation text:
    (context-spec-music
      (make-music
        'PropertyUnset
        'symbol 'ottavation
      )
      'Staff
    )
  ))
)
