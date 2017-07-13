%{
  Papier-Definitionen:
  +---------------------+ +---------------------+
  | Auszug Titel        | |        Titel Auszug |
  |                     | |                     |
  |                     | |                     |
  |                     | |                     |
  |                     | |                     |
  | 2        ©          | |         ©         3 |
  +---------------------+ +---------------------+

  \auszug muss definiert sein.

  Diese Datei wird direkt in den \book {}-Block eingebunden.
%}
% to be included directly in \book:
#(if (= partitur 0) (string-append instr " (Auszug)"))
#(if (and (= partitur 0) (> (+ gitA gitB gitC gitD gitE) 0)) (define auszug "Gitarre "))
#(if (and (= partitur 0) (= gitA 1)) (define auszug (string-append auszug "1 ")))
#(if (and (= partitur 0) (= gitB 1)) (define auszug (string-append auszug "2 ")))
#(if (and (= partitur 0) (= gitC 1)) (define auszug (string-append auszug "3 ")))
#(if (and (= partitur 0) (= gitD 1)) (define auszug (string-append auszug "4 ")))
#(if (and (= partitur 0) (= gitE 1)) (define auszug (string-append auszug "Bass ")))
#(if (and (= partitur 0) (= eGit 1)) (define auszug (string-append auszug "E-Gitarre ")))
#(if (and (= partitur 0) (= okta 1)) (define auszug (string-append auszug "Oktavgitarre ")))
#(if (and (= partitur 0) (= quer 1)) (define auszug (string-append auszug "Querflöte ")))
#(if (and (= partitur 0) (= saxo 1)) (define auszug (string-append auszug "Saxophon ")))
#(if (and (= partitur 0) (= saxb 1)) (define auszug (string-append auszug "Saxophon Ⅱ")))
\paper {
  evenHeaderMarkup = \markup {
    \fill-line {
      \auszug
      \fromproperty #'header:title
      \line {}
    }
  }
  oddHeaderMarkup = \markup {
    \fill-line {
      \line {}
      \on-the-fly #not-first-page
      \fromproperty #'header:title
      \on-the-fly #not-first-page
      \auszug
    }
  }
  evenFooterMarkup = \markup {
    \fill-line {
      \fromproperty #'page:page-number-string
      \fromproperty #'header:copyright
      \line {}
    }
  }
  oddFooterMarkup = \markup {
    \fill-line {
      \line {}
      \fromproperty #'header:copyright
      \fromproperty #'page:page-number-string
    }
  }
}
