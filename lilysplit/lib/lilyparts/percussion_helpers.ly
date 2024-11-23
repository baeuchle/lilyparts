% © CC-BY-SA 4.0 Bjørn Bäuchle, see file LICENSE

%{
  Provides
    \percLines (is 2)
    \percTable (is an empty table)
    \perc drums
%}

\version "2.24.3"

#(if (defined? 'PERCUSSION_HELPERS_LY_ALREADY_INCLUDED)
 (ly:warning "percussion_helpers.ly has already been included, crossing fingers!" "")
)
#(define PERCUSSION_HELPERS_LY_ALREADY_INCLUDED #t)

% number of lines in drum system:
percLines = #2
% drum types. By default, this is empty; overwrite it with
% #(define percTable '( (drumname notehead accent position) .. ))
% close to your drum definition.
#(define percTable '())

#(define (setMiddleC notePosition)
  (ly:debug "setMiddleC[~a]" notePosition)
  (context-spec-music
    (make-property-set 'middleCPosition notePosition)
    'Voice
  )
)

#(define (unsetMiddleC) (begin
  (ly:debug "unsetMiddleC[]")
  (context-spec-music
    (make-property-unset 'middleCPosition)
    'Voice
  )
))

#(define (setNoteHead value)
  (ly:debug "setNoteHead[~a]" value)
  (context-spec-music
    (make-grob-property-set 'NoteHead 'style value)
    'Bottom
  )
)

#(define (revertNoteHead)
  (context-spec-music
    (make-grob-property-revert 'NoteHead 'style)
    'Bottom
  )
)

#(define (inspect key value)
   (ly:debug "Key: ~a; Value: ~a" key value)
)

#(define (transformDrumNotes drums percHash)
  (let ((musicType (ly:music-property drums 'name))
        (elementList (ly:music-property drums 'elements))
        (elementItem (ly:music-property drums 'element))
        (drumType (ly:music-property drums 'drum-type))
        (drumProp (hashq-ref percHash (ly:music-property drums 'drum-type)))
       )
    (ly:debug "<transformDrumNotes ~a>" musicType)
    (if (eq? musicType 'EventChord)
      ;; For EventChord, we need special cases that we do not yet have. In
      ;; particular, there needs to be a common setMiddleC and unsetMiddleC
      ;; before/after, which disallows mixing with 'real' notes. It is so far
      ;; unclear (to me) how setNoteHead can be incorporated, yet I know that
      ;; it is possible to have different noteHeads in one chord.
      (ly:error "Invalid Type in transformDrumNotes: ~a is not supported" musicType)
    )
    (if (not (null? elementItem))
      ; e.g. RelativeOctaveMusic, Repeats
      (ly:music-set-property! drums 'element
        (transformDrumNotes elementItem percHash)
      )
    )
    (if (not (null? elementList))
      ; e.g. SequentialMusic
      (ly:music-set-property! drums 'elements
        (map (lambda (x) (transformDrumNotes x percHash)) elementList)
      )
    )
    (if (and (null? elementList) (null? elementItem))
    (begin
      (ly:debug "DrumProp: ~a DrumType: ~a" drumProp drumType)
      (if (and (not drumProp) (not (null? drumType)))
        (ly:debug "drum ~a has no configured output, defaulting to slash" drumType)
      )
      (make-sequential-music (list
        (setNoteHead
          (if drumProp
            (list-ref drumProp 0)
            (if (null? drumType) 'default 'slash)
        ))
        (if (not (null? drumType))
          (setMiddleC 0)
          (make-music 'SequentialMusic (list))
        )
        (begin
          (ly:music-set-property! drums 'pitch
            (if (null? drumType)
              (ly:music-property drums 'pitch)
              (ly:make-pitch 0 (if drumProp (list-ref drumProp 2) 0))
          ))
          drums
        )
        (if (not (null? drumType))
          (unsetMiddleC)
          (make-music 'SequentialMusic (list))
        )
        (revertNoteHead)
      ))
    )
    ; else: repeat (the changed) drums:
    drums
    )
  )
)

% puts crossed notes into the current Staff or the drum sequence into
% the percGit Staff if we make a MIDI.
perc = #(define-music-function
  (drums)
  (ly:music?)
  (if makeMidi
    ; TODO: make this into scheme, and maybe iterate through drums to switch
    ; back context to main system on notes actually containing a pitch (or not
    ; containing a drum-type)
    #{
      <<
        {}
        \context DrumStaff = "percGit" { #drums }
      >>
    #}
    (absolute (make-sequential-music (list
      (transformDrumNotes drums (alist->hash-table percTable))
    )))

  )
)

