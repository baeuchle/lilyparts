% © CC-BY-SA 4.0 Bjørn Bäuchle, see file LICENSE

%{
   Diese Datei macht aus ausgewählten Stimmen-Variablen (...S)
   Musiksystem-Variablen (...M)
%}

\include "chords.ly"

masterR = {
  \global
  \clef "G"
  \global
  \masterRS
}

masterL = {
  \global
  \clef "F"
  \global
  \masterLS
}

masterM = \new PianoStaff <<
  \set PianoStaff.instrumentName = "Master"
  \set PianoStaff.shortInstrumentName = "M"
  \new Staff = "masterRH" \masterR
  \new Staff = "masterLH" \masterL
>>

gitDiviM = { \new Staff = "diviGit" \with {
     \remove "Time_signature_engraver"
     \RemoveEmptyStaves
     \override VerticalAxisGroup.remove-first = ##t
     \hide Clef
     \clef "G_8"
     fontSize = #-4
     midiInstrument = #"acoustic guitar (nylon)"
     \override StaffSymbol.staff-space = #(magstep -4)
     \override StaffSymbol.thickness = #(magstep -4)
     \global
  } { \stopStaff \gitDiviS }
}

gitPercM = {
  \new DrumStaff = "percGit"  <<
    \global
    \new DrumVoice {
      \stopStaff
      \gitDiviS
    }
  >>
}

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

chordNames = \new ChordNames {
  % the next two lines are basically \semiGermanChords, just the bass
  % note obeys the same rules as the chord name proper and is uppercase.
  \set chordRootNamer = #(chord-name->german-markup #f)
  \set chordNoteNamer = #(chord-name->german-markup #f)
  \set noChordSymbol = ##f
  \set chordChanges = ##t
  \set chordNameLowercaseMinor = ##t
  \set Staff.midiInstrument = #"acoustic guitar (nylon)"
  \global
  \gitRythS
}

chordRythm = \new Staff \with {
  \override StaffSymbol.line-count = #1
} <<
  \new Voice \with {
    \consists "Pitch_squash_engraver"
  } {
    \set Staff.instrumentName = "Rythm"
    \set Staff.shortInstrumentName = "(R)"
    \clef percussion
    \global
    \improvisationOn
    \baseNoteChord \gitRythS
    \improvisationOff
  }
>>

gitRythM = <<
  \chordNames
  \chordRythm
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

saxAltBM = \new Staff <<
  \new Voice {
    \set Staff.instrumentName = "Saxophon Ⅱ"
    \set Staff.shortInstrumentName = "(SⅡ)"
    \clef "G"
    \set Staff.midiInstrument = #"alto sax"
    \transposition es
    \transpose es c { \global }
    \saxAltBS
  }
>>

gitElecM = \new Staff <<
  \new Voice {
    \set Staff.instrumentName = "E-Gitarre"
    \set Staff.shortInstrumentName = "(E)"
    \clef "G_8"
    \set Staff.midiInstrument = #"overdriven guitar"
    \global
    \gitElecS
  }
>>

querFltM = \new Staff <<
  \new Voice {
    \set Staff.instrumentName = "Querflöte"
    \set Staff.shortInstrumentName = "(Q)"
    \clef "G"
    \set Staff.midiInstrument = #"flute"
    \global
    \querFltS
  }
>>

gitOktaM = \new Staff <<
  \new Voice {
    \set Staff.instrumentName = "Oktavgitarre"
    \set Staff.shortInstrumentName = "(O)"
    \clef "G"
    \set Staff.midiInstrument = #"acoustic guitar (nylon)"
    \global
    \gitOktaS
  }
>>

percussM = {
  \new DrumStaff \with {
    \override StaffSymbol.line-count = \percLines
    countPercentRepeats = ##t
    drumStyleTable = #(alist->hash-table percTable)
  }
  <<
    \global
    \set DrumStaff.instrumentName = "Drums"
    \set DrumStaff.shortInstrumentName = "(D)"
    \new DrumVoice \percussS
  >>
}

#(begin
  (ly:progress "\nVersion: ~a ~a\n" gitver lilyver)
  (ly:progress "Instruments: ~a\n" instruments)
  (ly:progress "Excerpt: ~a\n" auszug)
  (ly:progress "Suffix: ~a\n" suffix)
  (ly:progress "MIDI: ~a\n" (if makeMidi "ja" "nein"))
)
