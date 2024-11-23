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

#(define (first-mark textscriptevent music)
  (let ((musicType (ly:music-property music 'name))
        (elementList (ly:music-property music 'elements))
        (elementItem (ly:music-property music 'element))
       )
    ; we set the appropriate property of music and then output music at the
    ; end.
    (ly:debug "<first-mark ~a>" musicType)
    ; chords: add TextScriptEvent into 'elements
    (if (eq? musicType 'EventChord)
      (ly:music-set-property! music 'elements
        (cons textscriptevent elementList)
      )
    ; anything that has an 'element. This must be checked before 'elements,
    ; because \repeat has its body as 'element, but its alternatives as
    ; 'elements. We don't want to mark the latter ones.
    (if (not (null? elementItem))
      ; e.g. RelativeOctaveMusic, Repeats
      (ly:music-set-property! music 'element
        (first-mark textscriptevent elementItem)
      )
    ; anything that's not EventChord, doesn't have 'element, but has 'elements.
    ; this is e.g. SequentialMusic.
    (if (not (null? elementList))
      (ly:music-set-property! music 'elements
        (cons
          (first-mark textscriptevent (car elementList))
          (cdr elementList)
        )
      )
    ; all others: this will be NoteEvent, RestEvent, MultiMeasureRestMusic.
    ; simply add the TextScriptEvent
    (ly:music-set-property! music 'articulations
      ; this will be NoteEvent, RestEvent, MultiMeasureRestMusic etc.
      (cons textscriptevent (ly:music-property music 'articulations))
    )))) ; end ifs
    music
  )
)

% adds a mark to the first note or chord in the given music object.
% (prepares the text mark and calls first-mark with it)
#(define (firstMark markDir markText music)
  (first-mark
    (make-music
      'TextScriptEvent
      'direction markDir
      'text markText)
    music
  )
)

% Adds a voice mark to the first note-like item in the given music.
% we accept voiceIndex 0 through 5, with all else giving a filled
% triangle.
diviMark = #(define-music-function
  (voiceIndex note)
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

