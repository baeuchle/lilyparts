%{
  Provides
    \percLines (is 2)
    \percTable (is an empty table)
    \perc drums
%}

#(if (defined? 'PERCUSSION_HELPERS_LY_ALREADY_INCLUDED)
 (display "percussion_helpers.ly has already been included, crossing fingers!")
)
#(define PERCUSSION_HELPERS_LY_ALREADY_INCLUDED #t)

percLines = #2
#(define percTable '(
                   ))

% puts crossed notes into the current Staff or the drum sequence into
% the percGit Staff if we make a MIDI.
perc = #(define-music-function
  (parser location drums)
  (ly:music?)
  (if makeMidi
  #{
    <<
      {}
      \context DrumStaff = "percGit" \drummode { #drums }
    >>
  #}
  #{
    \override NoteHead.style = #'cross
    #drums
    \revert NoteHead.style
  #})
)

