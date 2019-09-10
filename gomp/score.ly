%{
    Setzt den Inhalt der Variablen \music in je einen Score für Noten- und
    einen für MIDI-Eport.

    Diese Datei wird direkt in den \book {}-Block eingebunden.
%}

% Noten:
\score {
  % Bei MIDI ist immer jeder Output aktiviert.
  %{
    Technisch gesehen geht das leider nicht anders: Wenn hier auch
    if-Anweisungen stünden, werden die enthaltenen Variablen durch das
    unfoldRepeats verändert. So – ohne if und alles immer dabei – wird
    der Inhalt für das Layout weiter unten beibehalten.
  %}
  \unfoldRepeats \articulate <<
  \new GrandStaff <<
    \new StaffGroup <<
      \masterM
      \gitEinsM
      \gitZweiM
      \gitDreiM
      \gitVierM
      \gitDiviM
      \gitBassM
      \percussM
      \gitPercM
      \querFltM
      \saxAltAM
      \saxAltBM
      \gitElecM
      \gitOktaM
    >>
  >>
  >>
  \midi {}
}

\score {
  \new GrandStaff <<
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
    >>
    \new StaffGroup <<
      #(if showDrum percussM)
    >>
  >>
  \layout {}
}
