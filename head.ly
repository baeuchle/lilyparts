%{
  Kopfdefinitionen für meine Lilypond-Dateien.

  Hier sollte alles definiert werden, was geladen werden kann, bevor
  einzelstimmen.pl irgendwas aufruft.

%}

\version "2.18.2"

#(set-default-paper-size "a4")
#(ly:set-option 'point-and-click #f)

% Variablen:
% Ist eine ganze Partitur (heißt v.a., dass es kleiner gedruckt wird):
partitur = 1
% Gitarre 1 soll gedruckt werden, wenn 1
gitA = 0
% Gitarre 2 soll gedruckt werden, wenn 1
gitB = 0
% ...
gitC = 0
gitD = 0
% Bassgitarre
gitE = 0
% Saxophon-Stimme
saxo = 0
saxb = 0 % Bass voice sax
quer = 0 % Flute
% Perkussion
perc = 0
% oktavgitarre
okta = 0
% E-Gitarre
eGit = 0

% Midi soll geschrieben werden
midiOn = 0

% Der normale "Auszug" ist "Partitur"
auszug = "Partitur"
% Das normale "Instrument" ist "Gitarrenorchester"
instr = "Gitarrenorchester"

% Wir definieren für alle Gitarren und das 1. Alt-Saxophon eine *S*timme. Diese Variablen werden in stimmen.ly in Scores gepackt.
gitEinsS = {}
gitZweiS = {}
gitDreiS = {}
gitVierS = {}
gitBassS = {}
saxAltAS = {}
