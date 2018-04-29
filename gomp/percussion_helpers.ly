%{
  Provides
    \percLines (is 2)
    \percTable (is an empty table)
    \perc drums
%}

#(if (defined? 'PERCUSSION_HELPERS_LY_ALREADY_INCLUDED)
 (display "percussion_helpers.ly has already been included, crossing fingers!")
)
#(define PERCUSSION_HELPERS_LY_ALREADY_INCLUDED #t)

% number of lines in drum system:
percLines = #2
% drum types. By default, this is empty; overwrite it with
% #(define percTable '( (drumname notehead accent position) .. ))
% close to your drum definition.
#(define percTable '())

#(define (unsetMiddleC) (begin
  ;;(display "unsetMiddleC[]\n")
  (make-music
    'ContextSpeccedMusic
    'context-type 'Voice
    'add-info "Inserted by unsetMiddleC"
    'element (make-music
      'PropertyUnset
      'symbol 'middleCPosition
    )
  )
))
#(define (setMiddleC notePosition) (begin
  ;;(display "setMiddleC[")
  ;;(display notePosition)
  ;;(display "]\n")
  (make-music
    'ContextSpeccedMusic
    'context-type 'Voice
    'add-info "Inserted by setMiddleC"
    'element (make-music
      'PropertySet
      'value notePosition
      'symbol 'middleCPosition
    )
  )
))

#(define (setNoteHead value) (begin
  ;;(display "setNoteHead[")
  ;;(display value)
  ;;(display "]\n")
  (make-music
    'ContextSpeccedMusic
    'context-type 'Bottom
    'add-info "Inserted by setNoteHead"
    'element (make-music
      'OverrideProperty
      'pop-first #t
      'grob-property-path (list (quote style))
      'grob-value value
      'symbol 'NoteHead
    )
  )
))

#(define (inspect key value) (begin
   (display "Key: ")
   (display key)
   (display "; Value: ")
   (display value)
   (newline)
))

#(define (transformDrumNotes drums percHash)
  (let ((musicType (ly:music-property drums 'name)))
    (if (eq? musicType 'SequentialMusic)
      (make-music musicType
        'elements (map (lambda (x) (transformDrumNotes x percHash)) (ly:music-property drums 'elements))
        'add-info "inserted by transformDrumNotes with SequentialMusic"
      )
    (if (eq? musicType 'UnfoldedRepeatedMusic)
      (begin
        (ly:music-set-property! drums 'element (transformDrumNotes (ly:music-property drums 'element) percHash))
        drums
      )
    (if (eq? musicType 'NoteEvent)
      (begin
        (make-music 'SequentialMusic
          'add-info "inserted by transformDrumNotes with NoteEvent"
          'elements (list
            (if (hashq-ref percHash (ly:music-property drums 'drum-type))
              (begin
                (ly:music-set-property! drums 'add-info "This drum-type has a defined NoteHead")
                (setNoteHead (list-ref (hashq-ref percHash (ly:music-property drums 'drum-type)) 0))
              )
              (begin
                (display "WARNING: No predefined NoteHead found for ")
                (display (ly:music-property drums 'drum-type 'unspecified-drum-type))
                (newline)
                (ly:music-set-property! drums 'add-info "This drum-type does NOT have a defined NoteHead")
                (if (eq? (ly:music-property drums 'drum-type 'invalid) 'invalid)
                  (begin
                    (ly:music-set-property! drums 'add-info "No DRUM!")
                    (setNoteHead 'default)
                  )
                  (setNoteHead 'slash)
                )
              )
            )
            (if (hashq-ref percHash (ly:music-property drums 'drum-type))
              (setMiddleC (list-ref (hashq-ref percHash (ly:music-property drums 'drum-type)) 2))
              (if (eq? (ly:music-property drums 'drum-type 'invalid) 'invalid)
                (unsetMiddleC)
                (setMiddleC 0)
              )
            )
            (begin
              drums
            )
          )
        )
      )
    (if (eq? musicType 'RestEvent)
      ;; Don't change rests.
      drums
    (if (eq? musicType 'EventChord)
      ;; The problem with EventChord is that I would have to set and reset
      ;; middleCPosition twice inside one chord. Simply recursing like in
      ;; SequentialMusic yields a missing note, which isn't what we want
      ;; either. Therefore, for the time being, EventChords are forbidden.
      (begin
        (display "ERROR: Invalid Type in transformDrumNotes: ")
        (display musicType)
        (display " is not supported\n")
        ;;TODO: Optionally color the notes
        (make-music 'SequentialMusic 'elements (list drums))
      )
    (begin
      (display "WARNING: Unknown Type in transformDrumNotes: ")
      (display musicType)
      (newline)
      (display "Only know how to handle:\n")
      (display " NoteEvent,\n")
      ;;(display " MultiMeasureRestMusic,\n")
      ;;(display " RelativeOctaveMusic,\n")
      (display " RestEvent,\n")
      (display " SequentialMusic,\n")
      (display " UnfoldedRepeatedMusic.\n")
      (display-scheme-music drums)
      (newline)
      ;;TODO: Optionally color the notes
      (make-music 'SequentialMusic 'elements (list drums))
    ))))))
  )
)

% puts crossed notes into the current Staff or the drum sequence into
% the percGit Staff if we make a MIDI.
perc = #(define-music-function
  (parser location drums)
  (ly:music?)
  (if makeMidi
    #{
      <<
        {}
        \context DrumStaff = "percGit" { #drums }
      >>
    #}
    (make-music
      'SequentialMusic
      'elements (list
        (setNoteHead 'harmonic)
        (setMiddleC 0)
        (transformDrumNotes drums (alist->hash-table percTable))
        (unsetMiddleC)
        (make-music ;; revert NoteHead
          'ContextSpeccedMusic
          'context-type
          'Bottom
          'element
          (make-music
            'RevertProperty
            'grob-property-path
            (list (quote style))
            'symbol
            'NoteHead))
      )
    )
  )
)

