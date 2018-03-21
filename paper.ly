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
\bookOutputSuffix \suffix
