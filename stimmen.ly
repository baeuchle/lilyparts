%{
   Diese Datei macht aus ausgewählten Stimmen-Variablen (...S)
   Musiksystem-Variablen (...M)
%}

gitEinsM = \new Staff <<
  \new Voice {
    \set Staff.instrumentName = "Gitarre 1"
    \set Staff.shortInstrumentName = "(1)"
    \clef "G_8"
    \set Staff.midiInstrument = #"acoustic guitar (nylon)"
    \global
    \gitEinsS
  }
>>

gitZweiM = \new Staff <<
  \new Voice {
    \set Staff.instrumentName = "Gitarre 2"
    \set Staff.shortInstrumentName = "(2)"
    \clef "G_8"
    \set Staff.midiInstrument = #"acoustic guitar (nylon)"
    \global
    \gitZweiS
  }
>>

gitDreiM = \new Staff <<
  \new Voice {
    \set Staff.instrumentName = "Gitarre 3"
    \set Staff.shortInstrumentName = "(3)"
    \clef "G_8"
    \set Staff.midiInstrument = #"acoustic guitar (nylon)"
    \global
    \gitDreiS
  }
>>

gitVierM = \new Staff <<
  \new Voice {
    \set Staff.instrumentName = "Gitarre 4"
    \set Staff.shortInstrumentName = "(4)"
    \clef "G_8"
    \set Staff.midiInstrument = #"acoustic guitar (nylon)"
    \global
    \gitVierS
  }
>>

gitBassM = \new Staff <<
  \new Voice {
    \set Staff.instrumentName = "Bass"
    \set Staff.shortInstrumentName = "(B)"
    \clef "G_15"
    \set Staff.midiInstrument = #"acoustic guitar (nylon)"
    \global
    \gitBassS
  }
>>

saxAltAM = \new Staff <<
  \new Voice {
    \set Staff.instrumentName = "Saxophon"
    \set Staff.shortInstrumentName = "(S)"
    \clef "G"
    \set Staff.midiInstrument = #"alto sax"
    \transposition es
    \transpose es c { \global }
    \saxAltAS
  }
>>
