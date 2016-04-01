#!/usr/bin/perl -w

use strict;
my @dateien = ();
my @stimmen = ();
my $partitur = '';
our %stimmeda = ();
my @markerlist;
my $namesuffix = '';

# get arguments from command line
use Config;
use Getopt::Long;
Getopt::Long::Configure('no_ignore_case');

GetOptions ( 'help|h|?' => \&help
           , 'datei=s@' => \@dateien
           , 'stimme=s@' => \@stimmen
           , 'partitur!' => \$partitur
           , 'markers=s@' => \@markerlist
           , 'namesuffix=s' => \$namesuffix
           );

my %markers;
for my $marker (@markerlist) {
  $markers{lc $marker} = 1;
}

for my $stimme (@stimmen) {
  $stimme =~ s/eins/1/i;
  $stimme =~ s/zwei/2/i;
  $stimme =~ s/drei/4/i;
  $stimme =~ s/vier/5/i;
  $stimme =~ s/bass/5/i;
  my @mehrstimmen = split /_/, $stimme;
  $stimmeda{$_} = 1 for @mehrstimmen;
}
print "Stimmen: ";
print "$_ " for sort keys %stimmeda;
print "\n";
print "partitur\n" if $partitur;
print "Marker: ";
print "$_ " for @markerlist;
print "\n";
my $diesestimmen = join "_", @stimmen;
unless ($namesuffix) {
  $namesuffix = $diesestimmen;
}
unless ($namesuffix) {
  $namesuffix = '.auszug';
}

for my $dateiname (@dateien) {
  $dateiname .= '.ly' unless -r $dateiname;
  print "Lese $dateiname...\n";
  open QUELLE, $dateiname or die $!;
 
  $dateiname =~ s/\.([^\.]+)$//;
  my $suffix = $1;
 
  my $zieldatei = $dateiname.$namesuffix.'.'.$suffix;
  print "Öffne Datei $zieldatei...\n";
  open ZIEL, '>', $zieldatei or die $!;
 
  my $schreibe = 1;
  while (<QUELLE>) {
    # Marker für mehrere Zeilen:
    $schreibe = 1 if /\%\%\s+GIT\s+(\d)\s+\%\%/ && &istStimmeDabei($1);
    $schreibe = 1 if /\%\%\s+PARTITUR\s+\%\%/   && $partitur;
    $schreibe = 1 if /\%\%\s+ALLE\s+\%\%/;
    $schreibe = 0 if /\%\%\s+GIT\s+(\d)\s+\%\%/ && !&istStimmeDabei($1);
    $schreibe = 0 if /\%\%\s+PARTITUR\s+\%\%/   && !$partitur;
    next unless $schreibe;
    # Marker für diese Zeile:
    # %EINZEL7 wird nicht in Partitur und nur für Stimme 7 geschrieben.
    if (s/^\s*\%EINZEL(\d)//) {
      next if $partitur;
      next unless &istStimmeDabei($1);
    }
    # %EINZEL wird nicht in Partitur, aber für sonst immer (alle
    # Einzelstimmen) geschrieben.
    elsif (s/^\s*\%EINZEL//) {
      next if $partitur;
    }
    # %%MARKER wird nur geschrieben, wenn --marker MARKER gegeben wurde.
    # Das ist case-insensitive.
    elsif (s/^\s*\%\%(\S+)//) {
      next unless defined $markers{lc $1};
    }
    print ZIEL;
  }
  close ZIEL;
}
exit 0;

sub istStimmeDabei {
  my $stimme = shift;
  return 1 if keys %stimmeda == 0;
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
            Stimmen erstellt. Werden keine Stimmen definiert, werden
            alle Stimmen benutzt. Um alle Stimmen auszuschalten, sollte
            eine nicht-existente Stimme ausgewählt werden.
--partitur: Erstellt eine Partitur aus den angegebenen Stimmen. Dies
            steuert, ob die "%% PARTITUR"-Zeilen benutzt werden oder
            nicht (etwa für kleineren Druck)
--marker #: Definiert Kommentar-Marker, deren Zeilen überall auftauchen.
            Beispiel: --marker ASDF wird Zeilen, die mit %%ASDF
            anfangen, einbeziehen.
--namesuffix #:
            Name-Anhängsel, um diesen Auszug zu bezeichnen. Mit
            --namesuffix asdf wird aus Datei test.ly der Auszug
            testasdf.ly erzeugt. Wenn weggelassen, werden die benutzten
            Stimmen mit "_" zusammengezogen und benutzt (z.B.
            test1_2.ly), falls keine Stimmen angegeben sind, wird
            ".auszug" benutzt (also test.auszug.ly).
HILFE
}
