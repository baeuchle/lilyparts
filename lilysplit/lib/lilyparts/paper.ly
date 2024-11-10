% © CC-BY-SA 4.0 Bjørn Bäuchle, see file LICENSE

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
  midititle = #(if (defined? 'midititle) midititle (if (defined?  'pdftitle) pdftitle title))
  pdftitle = #(string-append midititle " " auszug)
  pdfsubtitle = \auszug
  gv = \gitver
  lv = \lilyver
  keywords = #(string-append (if (defined? 'keywords) keywords "") " " gv " " lv)
  % make sure arranger is present:
  arranger = #(if (defined? 'arranger) arranger "")
  pdfarr = #(if (defined? 'pdfarranger) pdfarranger arranger)
  % pdfarranger without "Bearb. "
  pdfarranger = #(
    if (and (> (string-length pdfarr) 6) (equal?  (substring pdfarr 0 7) "Bearb. "))
      (substring pdfarr 7)
      pdfarr
    )
  % arranger, if present, with "Bearb. "
  arranger = #(
    if (or (= (string-length arranger) 0)
    (and (> (string-length arranger) 5) (equal?  (substring arranger 0 5)
    "Bearb")))
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
      \unless \on-first-page \fromproperty #'header:title
      \unless \on-first-page \auszug
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
      \line { \gitver \if \on-first-page { \lilyver } }
      \fromproperty #'header:copyright
      \fromproperty #'page:page-number-string
    }
  }
}
