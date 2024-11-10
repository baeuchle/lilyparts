# Lilysplit

This suite is primarily intended for my own personal use, but some parts
may be of use for other people.

Its main aim is to facilitate musical engraving for a guitar orchestra
with possible additional instruments. Since I am German and it isn't
possible to include numbers in variable names in Lilypond, I chose to
use semi-german names for some variables.

Consider the simple lilypond file doc/demo/demo.ly:

```
\version "2.24.3"
\include "lilyparts/head.ly"
hasEins = ##t
hasZwei = ##t
\include "lilyparts/calc.ly"

global = { \time 4/4 \key c \major }
gitEinsS = \relative c' \repeat unfold 8 { c4 d e f <e g>1 }
gitZweiS = \relative c  \repeat unfold 8 { c4 g c b c1 }

\include "lilyparts/stimmen.ly"

\book {
  \header {
    title = "Lilysplit / lilyparts demo"
    composer = "Bjørn Bäuchle"
    tagline = ##f
  }
  \include "lilyparts/paper.ly" % optional, see below
  \include "lilyparts/score.ly"
}
```

and now run it through lilysplit:

```
lilysplit demo.ly
```

This will create files demo.pdf containing the complete score made of
two staves "Git 1" and "Git 2", files demo-1.pdf and demo-2.pdf with the
single staves, and demo.midi .

Note that for every voice that should have content, a variable
"``...S``" needs to be filled. "``global``" must be defined and will be
added to the beginning of the Staff.

The order of the includes included in the snippet is important:

1. lilyparts/head.ly sets up the environment
2. the lines with hasXXXX = ##t tell us which voices to include
3. lilyparts/calc.ly then calculates the instrument names, file
   extensions etc.
4. lilyparts/stimmen.ly creates the voice variables which are used
   later in score.ly
5. lilyparts/paper.ly prepares the paper canvas with titles, version
   information etc. Strictly speaking, it isn't necessary.
6. lilyparts/score.ly actually engraves the score and/or midi file.
