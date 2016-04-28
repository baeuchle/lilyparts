% Eine Notensystemgruppe für 5 Gitarren. Die ...M-Variablen sollten in
% stimmen.pl aus ...S-Variablen gemacht worden sein und mit dem
% richtigen Namen, MIDI-Instrumenten und Schlüssel ausgestattet worden
% sein.

\new StaffGroup <<
  #(if (= gitA 1) gitEinsM)
  #(if (= gitB 1) gitZweiM)
  #(if (= gitC 1) gitDreiM)
  #(if (= gitD 1) gitVierM)
  #(if (= gitE 1) gitBassM)
>>
