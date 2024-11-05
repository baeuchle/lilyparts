%{
    baseNoteChord copies music and changes all chords (in the copy) to
    only the first note.
%}

\version "2.24.3"

#(if (defined? 'CHORDS_LY_ALREADY_INCLUDED)
  (ly:warning "chords.ly has already been included, crossing fingers!")
)
#(define CHORDS_LY_ALREADY_INCLUDED #t)

#(define (getFirstNoteFromChord chord-elements)
  (if (null? chord-elements)
    ; if the argument is empty, return an empty list.
    (list)
    ; if the argument is not empty:
    (if (eq? (ly:music-property (car chord-elements) 'name) 'NoteEvent)
      ; if the first item is a NoteEvent, return that
      (car chord-elements)
      ; if the first item is something else, recurse from the next element.
      (getFirstNoteFromChord (cdr chord-elements))
    ) ; end if is-NoteEvent
  ) ; end if is-null
) % getFirstNoteFromChord

#(define (getArticulationsFromChord chord-elements)
  (if (null? chord-elements)
    ; argument is empty? return empty list.
    (list)
    (if (eq? (ly:music-property (car chord-elements) 'name) 'NoteEvent)
      ; if NoteEvent: try next chord-elements element.
      (getArticulationsFromChord (cdr chord-elements))
      ; else (not NoteEvent): prepend this to the articulations from the rest
      ; of the list.
      (cond (car chord-elements) (getArticulationsFromChord (cdr chord-elements)))
    ) ; end if is-NoteEvent
  ) ; end if is-null
) % getArticulationsFromChord

#(define (stripChord chord)
  (let ((firstnote (getFirstNoteFromChord (ly:music-property chord 'elements))))
    (let ((articulation (getArticulationsFromChord (ly:music-property chord 'elements))))
      (if (not (null? articulation))
        ; if there is some articulation in the chord, set firstnote's articulations
        ; to that.
        (ly:music-set-property! firstnote 'articulations articulation)
      ) ; endif articulation is present
    ) ; let articulation
    ; firstnote has been extracted, its articulations set - now return that.
    firstnote
  ) ; let firstnote
) % stripChord

#(define (bnc music)
  (let ((musicType (ly:music-property music 'name)))
    (ly:debug "<bnc ~a>" musicType)
    (if (eq? musicType 'EventChord)
      ; chords are what really interest us, they need to be stripped.
      (stripChord music)
    (begin ; else: not EventChord - strip any chords nested underneath, but
           ; else, copy.
      (if (not (null? (ly:music-property music 'elements)))
        ; if there are elements, transform them all:
        (ly:music-set-property! music 'elements
          (map (lambda (x) (bnc x)) (ly:music-property music 'elements))
        )
        (ly:debug "Input ~a has no 'elements!" musicType)
      )
      (if (not (null? (ly:music-property music 'element)))
        ; if there is element, transform it:
        (ly:music-set-property! music 'element
          (bnc (ly:music-property music 'element))
        )
        (ly:debug "Input ~a has no 'element!" musicType)
      )
      ; in the end, output the possibly-changed sequence.
      music
      ) ; end else clause
    ) ; end if
  ) ; let musicType
) % bnc

baseNoteChord = #(define-music-function
  (parser location chordseq)
  (ly:music?)
  ; call bnc with a copy of chordseq, so that chordseq isn't changed.
  (bnc (ly:music-deep-copy chordseq))
) % baseNoteChord

