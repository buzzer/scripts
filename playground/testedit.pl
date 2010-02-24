#!/usr/bin/perl
use strict;
use warnings;

use Tk;

my $input = 'noname.pl';

# Zuerst wieder ein Hauptfenster und zwei Frames:
my $mw     = MainWindow->new();
my $frame  = $mw->Frame();
my $frame2 = $mw->Frame();

# Menubuttons
my $m_file = $frame2->Menubutton(-text      => "Datei",
                                 -underline => 0,
                                );
my $m_opti = $frame2->Menubutton(-text      => "Ausführen",
                                 -underline => 0,
                                );
my $m_help = $frame2->Menubutton(-text      => "Hilfe",
                                 -underline => 0,
                                );

# Jetzt erstellen wir unser Text-Widget mit 2 Scrollbars
# in unserem Frame, allerdings diesmal via Scrolled:
my $text = $frame->Scrolled('Text',
                            -wrap       => 'none',
                            -scrollbars => 'osoe',
                            -background => 'white',
                            -foreground => 'blue',
                            -width      => 80,
                            -height     => 35,
                            -font       => '{Courier New} 12 {normal}',
                           );

# Jetzt packen wir wieder alles zusammen:
$m_file->pack(-side   => 'left',
              -expand => 0,
              -fill   => 'x',
             );
$m_opti->pack(-side   => 'left',
              -expand => 0,
              -fill   => 'none',
             );
$m_help->pack(-side   => 'left',
              -expand => 0,
              -fill   => 'none',
             );
$frame2->pack(-side   => 'top',
              -expand => 0,
              -fill   => 'x',
             );
$frame-> pack(-side   => 'top',
              -expand => 1,
              -fill   => 'both',
             );
$text->  pack(-side   => 'left',
              -expand => 1,
              -fill   => 'both',
             );

$m_file->command(-label     => "Neu",
                 -command   => [\&neu, "neu"],
                );
$m_file->command(-label     => "Öffnen",
                 -command   => [\&open, "open"],
                );
$m_file->command(-label     => "Speichern",
                 -command   => [\&save, "speichern"],
                );
$m_file->command(-label     => "Beenden",
                 -underline => 1,
                 -command   => sub { exit 0 },
                );
$m_opti->command(-label     => "/usr/bin/perl -w $input",
                 -command   =>  \&perl,
                );

$m_help->command(-label     => "Autor",
                 -command   => sub {},
                );
$m_help->command(-label => "Hilfe",
                 -command => sub{},
                );

# Der Exit Button:
my $fbut = $mw->Frame()->pack();
my $bxit = $fbut->Button(-text    => 'Exit',
                         -command => [$mw => 'destroy'],
                        )
                  ->pack(-side => 'left',
                         -expand => 0,
                         -fill   => 'none',
                        );

MainLoop();


sub file {
} # sub file


sub neu {
    my $tw = $mw->Toplevel(-title => 'Neu');
    $tw->Label(-text => "Wie soll die Datei heißen : ")->pack();
    my $in = $tw->Entry(-textvariable => \$input)->pack();
    $in->bind('<Return>', [\&create, $tw]);
} # sub neu


# Erzeugen einer neuen Datei
sub create {
    CORE::open (IFILE, ">> $input") or die "can't create '$input':$!\n";
    close IFILE;
    $_[1]->destroy();  #Fenster wieder löschen
} # sub create


sub open {
    my $tw = $mw->Toplevel(-title => 'Öffnen');
    $tw->Label(-text => "Welche Datei wollen sie Öffnen : ")->pack();
    my $in = $tw->Entry(-textvariable => \$input)->pack();
    $in->bind('<Return>', [ \&read, $tw ]);
} # sub open


# Datei zum Lesen und Schreiben Öffnen
sub read {
    CORE::open (IFILE, "< $input") or die "can't open '$input':$!\n";
    while (<IFILE>) {
        $text->insert("end", $_);
    }
    close IFILE;
    $_[1]->destroy();  #Fenster wieder löschen
} # sub read


sub save {
    my $tw = $mw->Toplevel(-title => 'Speichern');
    $tw->Label(-text => "Speichern : $input")->pack();
    my $in=$tw->Entry(-textvariable => \$input)->pack();
    print $input , "\n";
    $in->bind('<Return>', [\&write, $tw]);
} # sub save


#Speichern der Eingabe
sub write {
    CORE::open (IFILE, "+< $input") or die "can't open '$input':$!\n";
    print IFILE $text->get('1.0', 'end');;
    close IFILE or die $!;
    $_[1]->destroy(); #Fenster löschen
} # sub write


sub perl {
    system("/usr/bin/perl -w $input");
} # sub perl
