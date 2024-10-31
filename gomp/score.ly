%{
    Setzt den Inhalt der Variablen \music in je einen Score für Noten- und
    einen für MIDI-Eport.

    Diese Datei wird direkt in den \book {}-Block eingebunden.
%}

% Noten:
\score {
  \unfoldRepeats \articulate <<
  \new GrandStaff <<
    \new StaffGroup <<
      #(if hasMast #{ \masterM #})
      #(if hasEins #{ \gitEinsM #})
      #(if hasZwei #{ \gitZweiM #})
      #(if hasDrei #{ \gitDreiM #})
      #(if hasVier #{ \gitVierM #})
      #(if hasBass #{ \gitBassM #})
      #(if hasRyth #{ \chordRythm #})
      #(if hasDrum #{ \percussM #})
      #(if hasQuer #{ \querFltM #})
      #(if hasSaxo #{ \saxAltAM #})
      #(if hasSaxb #{ \saxAltBM #})
      #(if hasElec #{ \gitElecM #})
      #(if hasQuer #{ \gitOktaM #})
      \gitDiviM
      \gitPercM
    >>
  >>
  >>
  \midi {}
}

\score {
  <<
    #(if (and (= alls 1) showRyth) #{
      \set Score.rehearsalMarkFormatter = #format-mark-box-alphabet
    #})
    #(if showMast masterM)
    \new StaffGroup <<
      #(if showQuer querFltM)
      #(if showSaxo saxAltAM)
      #(if showSaxb saxAltBM)
      #(if showElec gitElecM)
      #(if showOkta gitOktaM)
    >>
    \new StaffGroup <<
      #(if showEins gitEinsM)
      #(if showZwei gitZweiM)
      #(if showDrei gitDreiM)
      #(if showVier gitVierM)
      \gitDiviM
      #(if showBass gitBassM)
      #(if showRyth gitRythM)
    >>
    \new StaffGroup <<
      #(if showDrum percussM)
    >>
  >>
  \layout {
    \layout_variable
  }
}
