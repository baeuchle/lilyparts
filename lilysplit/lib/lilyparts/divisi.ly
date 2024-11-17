% © CC-BY-SA 4.0 Bjørn Bäuchle, see file LICENSE

%{
  Provides
    \divisi yield voiceIndex normal additional
    \unMarkedDivisi yield normal additional
    \diviMark voiceIndex music
%}

#(if (defined? 'DIVISI_LY_ALREADY_INCLUDED)
 (ly:warning "divisi.ly has already been included, crossing fingers!")
)
#(define DIVISI_LY_ALREADY_INCLUDED #t)

$(if (not (defined? 'SPANS_LY_ALREADY_INCLUDED))
  (ly:error "spans.ly must be included before divisi.ly")
)

% Starts a divisi section. If we don't need to $yield to another voice,
% the second voice is out into the diviGit Staff, and if there is more
% than one voice in total "(> alls 1)", there will be a diviMark with
% the given voiceIndex on it.
%TODO: This always writes the upper voice into diviGit; I'd like to
% configure that (but that makes the interface even longer)
% voiceIndex is used for \diviMark; if negative then no mark is shown.
% MIDI output will never end in diviGit.
divisi = #(define-music-function
  (yield voiceIndex normal additional)
  (boolean? number? ly:music? ly:music?)
  (if (or yield makeMidi)
    (namedSpan "divisi" ; we'll assume that this is always for a normal guitar, thus no middleCPos given.
      (make-simultaneous-music (list
        additional
        (make-music 'VoiceSeparator)
        normal
      ))
    )
    (make-simultaneous-music (list
      normal
      (make-music 'ContextSpeccedMusic
        'property-operations '()
        'context-id "diviGit"
        'context-type 'Staff
        'element (make-sequential-music (list
          (make-music 'StaffSpanEvent 'span-direction -1)
          (if (and (>= voiceIndex 0) (> alls 1))
            (diviMark voiceIndex additional)
            additional
          )
          (make-music 'StaffSpanEvent 'span-direction 1)
        ))
      )
    ))
  )
)

% like divisi, but never write a diviMark.
unMarkedDivisi = #(define-music-function
  (yield normal additional)
  (boolean? ly:music? ly:music?)
  (divisi yield -1 normal additional)
)

% adds a mark to the first note or chord in the given music object.
#(define (firstMark markDir markText note)
  (let ((musicType (ly:music-property note 'name)))
    ; the given music object is a NoteEvent? That's easy, simply add the
    ; markup to its articulations.
    ; Same procedure for MultiMeasureRestMusic
    (cond
      ((or (eq? musicType 'NoteEvent)
           (eq? musicType 'MultiMeasureRestMusic)
           (eq? musicType 'RestEvent)
      )
      (begin
        (set!
          (ly:music-property note 'articulations)
          (cons
            (make-music
              'TextScriptEvent
              'direction markDir
              'text markText)
            (ly:music-property note 'articulations)
          )
        )
        ; return the changed note
        note
      ))
      ; for a chord, the markup is a part of the elements:
      ((eq? musicType 'EventChord)
      (begin
        (set!
          (ly:music-property note 'elements)
          (cons
            (make-music
              'TextScriptEvent
              'direction markDir
              'text markText)
            (ly:music-property note 'elements)
          )
        )
        ; return the changed note.
        note
      ))
      ; SequentialMusic constists of several parts, so we'll extract the
      ; first, pass that recursively and then return the music.
      ((eq? musicType 'SequentialMusic)
      (begin
        (list-set!
          (ly:music-property note 'elements)
          0
          (firstMark markDir markText (first (ly:music-property note 'elements)))
        )
        note
      ))
      ((eq? musicType 'RelativeOctaveMusic)
      (begin
        (set!
          (ly:music-property note 'element)
          (firstMark markDir markText (ly:music-property note 'element))
        )
        note
      ))
      (else (begin
        (ly:warning "Unknown Type in firstMark: ~a" musicType)
        (ly:warning "Only know how to handle:")
        (ly:warning " NoteEvent,")
        (ly:warning " EventChord,")
        (ly:warning " MultiMeasureRestMusic,")
        (ly:warning " RelativeOctaveMusic,")
        (ly:warning " RestEvent,")
        (ly:warning " SequentialMusic.")
        (display-scheme-music note)
        (newline)
        (make-music 'SequentialMusic 'elements (list note))
      ))
    )
  )
)

% Adds a voice mark to the first note-like item in the given music.
% we accept voiceIndex 0 through 5, with all else giving a filled
% triangle.
diviMark = #(define-music-function (parser location voiceIndex note)
  (number? ly:music?)
  (begin
    (if (eq? voiceIndex 0) (firstMark +1 (markup #:triangle #f) note)
    (if (eq? voiceIndex 1) (firstMark +1 (markup #:box    "1") note)
    (if (eq? voiceIndex 2) (firstMark -1 (markup #:box    "2") note)
    (if (eq? voiceIndex 3) (firstMark +1 (markup #:circle "3") note)
    (if (eq? voiceIndex 4) (firstMark -1 (markup #:circle "4") note)
    (if (eq? voiceIndex 5) (firstMark -1 (markup #:scale '(1 . -1) #:triangle #f) note)
                           (firstMark -1 (markup #:triangle #t) note)
    ))))))
  )
)

