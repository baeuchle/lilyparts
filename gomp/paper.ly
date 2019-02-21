%{
  Papier-Definitionen:
                          +---------------------+
                          |                     |
                          |                     |
                          |                     |
                          |                     |
                          |                     |
                          | ver     ©         3 |
                          +---------------------+

  +---------------------+ +---------------------+
  | Auszug Titel        | |        Titel Auszug |
  |                     | |                     |
  |                     | |                     |
  |                     | |                     |
  |                     | |                     |
  | 2        ©      ver | | ver     ©         3 |
  +---------------------+ +---------------------+

  \auszug muss definiert sein.

  Diese Datei wird direkt in den \book {}-Block eingebunden.
%}

\paper {
  evenHeaderMarkup = \markup {
    \abs-fontsize #8
    \fill-line {
      \auszug
      \fromproperty #'header:title
      \line {}
    }
  }
  oddHeaderMarkup = \markup {
    \abs-fontsize #8
    \fill-line {
      \line {}
      \on-the-fly #not-first-page
      \fromproperty #'header:title
      \on-the-fly #not-first-page
      \auszug
    }
  }
  evenFooterMarkup = \markup {
    \abs-fontsize #8
    \fill-line {
      \fromproperty #'page:page-number-string
      \fromproperty #'header:copyright
      \line { \gitver \lilyver }
    }
  }
  oddFooterMarkup = \markup {
    \abs-fontsize #8
    \fill-line {
      \line { \gitver \lilyver }
      \fromproperty #'header:copyright
      \fromproperty #'page:page-number-string
    }
  }
}
\bookOutputSuffix \suffix
