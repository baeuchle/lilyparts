#!/usr/bin/perl -w

use strict;

my @dateien = ();
my @stimmen = ();
my $partitur = '';
our %stimmeda = ();
our $midi = '';

# get arguments from command line
use Config;
use Getopt::Long;
Getopt::Long::Configure('no_ignore_case');

GetOptions ( 'help|h|?' => \&help
           , 'datei=s@' => \@dateien
           , 'stimme=s@' => \@stimmen
           , 'partitur!' => \$partitur
           , 'midi!' => \$midi
           );

for my $stimme (@stimmen) {
  $stimme =~ s/eins/1/i;
  $stimme =~ s/zwei/2/i;
  $stimme =~ s/drei/4/i;
  $stimme =~ s/vier/5/i;
  $stimme =~ s/bass/5/i;
  my @mehrstimmen = split /_/, $stimme;
  $stimmeda{$_} = 1 for @mehrstimmen;
}
print "$_ " for sort keys %stimmeda;
print "\n";
print "partitur\n" if $partitur;
my $diesestimmen = join "_", @stimmen;

for my $dateiname (@dateien) {
  $dateiname .= '.ly' unless -r $dateiname;
  print "Lese $dateiname...\n";
  open QUELLE, $dateiname or die $!;
 
  $dateiname =~ s/\.([^\.]+)$//;
  my $suffix = $1;
  my $m = $midi ne '' ? ".midi" : "";
 
  my $zieldatei = $dateiname.$diesestimmen.$m.'.'.$suffix;
  print "Öffne Datei $zieldatei...\n";
  open ZIEL, '>', $zieldatei or die $!;
 
  my $schreibe = 1;
  while (<QUELLE>) {
    # Marker für mehrere Zeilen:
    $schreibe = 1 if /\%\%\s+GIT\s+(\d)\s+\%\%/ &&  &istStimmeDabei($1);
    $schreibe = 0 if /\%\%\s+GIT\s+(\d)\s+\%\%/ && !&istStimmeDabei($1);
    $schreibe = 1 if /\%\%\s+ALLE\s+\%\%/;
    $schreibe = 1 if /\%\%\s+PARTITUR\s+\%\%/  &&  $partitur;
    $schreibe = 0 if /\%\%\s+PARTITUR\s+\%\%/  && !$partitur;
    next unless $schreibe;
    # Marker für diese Zeile:
    if (s/^\s*\%EINZEL(\d)//) {
      next if $partitur;
      next unless &istStimmeDabei($1);
    }
    elsif (s/^\s*\%EINZEL//) {
      next if $partitur;
    }
    elsif (s/^\s*\%MIDI//) {
      next unless $midi;
    }
    print ZIEL;
  }
  close ZIEL;
}
exit 0;

sub istStimmeDabei {
  my $stimme = shift;
  return 1 if $midi;
  return defined $stimmeda{$1};
}

sub help {
  print STDERR <<'HILFE';

einzelstimmen.pl -- Extrahiere Einzelstimmen aus Lilypond-Dateien

Die Teile, die in den Einzelstimmen benutzt werden sollen, müssen mit
einer Zeile
"%% GIT 1 %%"
markiert sein (wobei 1 die Nummer der gewünschten Stimme ist). Dinge,
die nur in der Partitur erscheinen sollen, müssen ein
"%% PARTITUR %%"
vorangestellt haben. Dinge, die wieder in allen Versionen auftauchen, haben
"%% ALLE %%" vorangestellt.

Bis zum Ende der Zeile kann "%EINZEL " für alle Einzelstimmen oder
"%EINZEL1" für Stimme 1 benutzt werden.

OPTIONEN:

--help: Zeige diese Hilfe
--datei DATEI: Benutze die Datei als Input. Mehrere Dateien können
               angegeben werden, sie werden nacheinander abgearbeitet.
--stimme #: Erstelle Einzelstimme für die angegebene Stimme. Kann
            mehrfach verwendet werden, dann werden Auszüge für mehrere
            Stimmen erstellt.
--partitur: Erstellt eine Partitur aus den angegebenen Stimmen. Dies
            steuert, ob die "%% PARTITUR"-Zeilen benutzt werden oder
            nicht (etwa für kleineren Druck)
HILFE
}
