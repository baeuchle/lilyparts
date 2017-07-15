%{
    Setzt den Inhalt der Variablen \music in je einen Score für Noten- und
    einen für MIDI-Eport.

    Diese Datei wird direkt in den \book {}-Block eingebunden.
%}

% Noten:
\bookOutputSuffix \suffix
\score {
  \new GrandStaff <<
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
      #(if showBass gitBassM)
    >>
    \new StaffGroup <<
      #(if showDrum percM)
    >>
  >>
  \layout {}
}

\score {
  \new GrandStaff <<
    \unfoldRepeats
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
      #(if showBass gitBassM)
    >>
    \new StaffGroup <<
      #(if showDrum percM)
    >>
  >>
  \midi {}
}
