#(begin
    (define alls 0) (define gits 0) (define oths 0)
    (if hasEins (begin (if showEins (define alls (+ alls 1))) (define gits (+ gits 1))) (define showEins #f))
    (if hasZwei (begin (if showZwei (define alls (+ alls 1))) (define gits (+ gits 1))) (define showZwei #f))
    (if hasDrei (begin (if showDrei (define alls (+ alls 1))) (define gits (+ gits 1))) (define showDrei #f))
    (if hasVier (begin (if showVier (define alls (+ alls 1))) (define gits (+ gits 1))) (define showVier #f))
    (if hasBass (begin (if showBass (define alls (+ alls 1))) (define oths (+ oths 1))) (define showBass #f))
    (if hasDrum (begin (if showDrum (define alls (+ alls 1))) (define oths (+ oths 1))) (define showDrum #f))
    (if hasOkta (begin (if showOkta (define alls (+ alls 1))) (define oths (+ oths 1))) (define showOkta #f))
    (if hasElec (begin (if showElec (define alls (+ alls 1))) (define oths (+ oths 1))) (define showElec #f))
    (if hasQuer (begin (if showQuer (define alls (+ alls 1))) (define oths (+ oths 1))) (define showQuer #f))
    (if hasSaxo (begin (if showSaxo (define alls (+ alls 1))) (define oths (+ oths 1))) (define showSaxo #f))
    (if hasSaxb (begin (if showSaxb (define alls (+ alls 1))) (define oths (+ oths 1))) (define showSaxb #f))
)

#(begin
    (define instruments "Gitarrenorchester")
    (define mehr #f)
    (if (> oths 0) (define instruments (string-append instruments " mit ")))
    (if hasBass (begin (define mehr #t) (define instruments (string-append instruments "Bass"))))
    (if (and hasDrum mehr)              (define instruments (string-append instruments ", ")))
    (if hasDrum (begin (define mehr #t) (define instruments (string-append instruments "Percussion"))))
    (if (and hasOkta mehr)              (define instruments (string-append instruments ", ")))
    (if hasOkta (begin (define mehr #t) (define instruments (string-append instruments "Oktavgitarren"))))
    (if (and hasElec mehr)              (define instruments (string-append instruments ", ")))
    (if hasElec (begin (define mehr #t) (define instruments (string-append instruments "E-Gitarre"))))
    (if (and hasQuer mehr)              (define instruments (string-append instruments ", ")))
    (if hasQuer (begin (define mehr #t) (define instruments (string-append instruments "Querflöte"))))
    (if (and (or hasSaxo hasSaxb) mehr) (define instruments (string-append instruments ", ")))
    (if (or hasSaxo hasSaxb)            (define instruments (string-append instruments "Saxophon")))
    (if (and hasSaxo hasSaxb)           (define instruments (string-append instruments "e")))
    (if (> (+ oths gits) alls)          (define instruments (string-append instruments " (Auszug)")))
)

#(begin
    (define auszug "")
    (if (and showPart (= (+ oths gits) alls)) (define auszug "Partitur") (begin
        (if (> gits 0) (define auszug ""))
        (if showEins (define auszug (string-append auszug "Git. 1 ")))
        (if showZwei (define auszug (string-append auszug "Git. 2 ")))
        (if showDrei (define auszug (string-append auszug "Git. 3 ")))
        (if showVier (define auszug (string-append auszug "Git. 4 ")))
        (if showBass (define auszug (string-append auszug "Bass ")))
        (if showDrum (define auszug (string-append auszug "Percussion ")))
        (if showOkta (define auszug (string-append auszug "Oktavgitarre ")))
        (if showElec (define auszug (string-append auszug "E-Gitarre ")))
        (if showQuer (define auszug (string-append auszug "Querflöte ")))
        (if showSaxo (define auszug (string-append auszug "Saxophon ")))
        (if showSaxb (define auszug (string-append auszug "Saxophon Ⅱ ")))
    ))
)

#(begin
    (define suffix "")
    (if makeMidi (define suffix (string-append suffix "_midi")))
    (if (and showPart (< (+ oths gits) alls)) (define suffix "_p"))
    (if (not showAlle) (begin
        (if showEins (define suffix (string-append suffix "_1")))
        (if showZwei (define suffix (string-append suffix "_2")))
        (if showDrei (define suffix (string-append suffix "_3")))
        (if showVier (define suffix (string-append suffix "_4")))
        (if showBass (define suffix (string-append suffix "_b")))
        (if showDrum (define suffix (string-append suffix "_d")))
        (if showOkta (define suffix (string-append suffix "_o")))
        (if showElec (define suffix (string-append suffix "_e")))
        (if showQuer (define suffix (string-append suffix "_q")))
        (if showSaxo (define suffix (string-append suffix "_s")))
        (if showSaxb (define suffix (string-append suffix "_b")))
    ))
    (if (> (string-length suffix) 0) (define suffix (substring suffix 1)))
)

#(begin
    (display "Instrumente: ")
    (display instruments)
    (newline)

    (display "Auszug: ")
    (display auszug)
    (newline)

    (display "Suffix: ")
    (display suffix)
    (newline)

    (display "MIDI: ")
    (if makeMidi (display "ja") (display "nein"))
    (newline)
)
