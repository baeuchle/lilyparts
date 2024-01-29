%{
  Papier-Definitionen:
                          +---------------------+
                          |                     |
                          |                     |
                          |                     |
                          |                     |
                          |                     |
                          | vverlver ©        3 |
                          +---------------------+

  +---------------------+ +---------------------+
  | Auszug Titel        | |        Titel Auszug |
  |                     | |                     |
  |                     | |                     |
  |                     | |                     |
  |                     | |                     |
  | 2        ©     vver | | vver    ©         3 |
  +---------------------+ +---------------------+

  \auszug muss definiert sein.

  Diese Datei wird direkt in den \book {}-Block eingebunden.
%}

\header {
  midititle = #(if (defined? 'pdftitle) pdftitle title)
  pdftitle = #(string-append midititle " " suffix)
  pdfsubtitle = \auszug
  gv = \gitver
  lv = \lilyver
  keywords = #(string-append (if (defined? 'keywords) keywords "") " " gv " " lv)
  pdfarr = #(if (defined? 'pdfarranger) pdfarranger (if (defined?  'arranger) arranger ""))
  pdfarranger = #(
    if (and (> (string-length pdfarr) 6) (equal?  (substring pdfarr 0 7) "Bearb. "))
      (substring pdfarr 7)
      pdfarr
    )
  arranger = #(
    if (and (> (string-length pdfarr) 5) (equal?  (substring pdfarr 0 5) "Bearb"))
      arranger
      (string-append "Bearb. " arranger)
    )
}

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
      \line { \gitver }
    }
  }
  oddFooterMarkup = \markup {
    \abs-fontsize #8
    \fill-line {
      \line { \gitver \on-the-fly #first-page { \lilyver } }
      \fromproperty #'header:copyright
      \fromproperty #'page:page-number-string
    }
  }
}
\bookOutputSuffix \suffix
