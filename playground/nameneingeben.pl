#!/usr/bin/perl
use strict;
use warnings;

use Tk;

my $fenster   = MainWindow->new();

my $text      = $fenster->Label(-text     => 'Bitte geben sie Ihren Namen ein  : ',
                                -height   =>  5,
                                -width    => 40,
                               );
my $eingabe   = $fenster->Entry();
my $schalter  = $fenster->Button(-text    => 'OK',
                                 -height  => 1,
                                 -width   => 4,
                                 -command => \&eingabe_bearbeiten,
                                );
my $schalter2 = $fenster->Button(-text    => 'Ende',
                                 -height  => 1,
                                 -width   => 4,
                                 -command => sub { exit },
                                );

$text     ->pack();
$eingabe  ->pack();
$schalter ->pack();
$schalter2->pack();

MainLoop();

sub eingabe_bearbeiten {
    print "Hallo " . $eingabe->get , "\n";
    $eingabe->delete(0, 'end');
}
