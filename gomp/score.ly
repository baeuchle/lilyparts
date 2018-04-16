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
  \unfoldRepeats
  \new GrandStaff <<
    \new StaffGroup <<
      \gitEinsM
      \gitZweiM
      \gitDreiM
      \gitVierM
      \gitBassM
      \percussM
      \querFltM
      \saxAltAM
      \saxAltBM
      \gitElecM
      \gitOktaM
    >>
  >>
  \midi {}
}

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
      #(if showDrum percussM)
    >>
  >>
  \layout {}
}