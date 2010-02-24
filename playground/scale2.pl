#!/usr/bin/perl
use strict;
use warnings;

use Tk;

my $mw = MainWindow->new();


my $f1 = $mw->Frame(-relief      => 'sunken',
                    -width       => '50',
                    -height      => '50',
                    -borderwidth => '10',
                   )
             ->pack(-side => 'left',
                    -pady => '10',
                    -padx => '10',
                   );

my $f2 = $mw->Frame(-relief      => 'raised',
                    -width       => '50',
                    -height      => '50',
                    -borderwidth => '10',
                   )
             ->pack(-side => 'left',
                    -pady => '10',
                    -padx => '10',
                   );

my $f3 = $mw->Frame(-relief      =>'sunken',
                    -width       => '100',
                    -height      => '100',
                    -borderwidth => '10',
                   )
             ->pack(-side => 'left',
                    -pady => '10',
                    -padx => '10',
                   );

my $summe = 0;
$f3->Label(-textvariable => \$summe)->pack();

my $schalter = $f2->Button(-text => "Berechne Summe",
                           -command =>  \&ergebnis,
                          )
                    ->pack(-anchor => 'center');

my $scale1 = $f1->Scale(-from   => 0,
                        -to     => 100,
                        -orient => "horizontal",
                        -label  => "Zahl 1 :",
                       )
                 ->pack();

my $scale2 = $f1->Scale(-from   => 0,
                        -to     => 100,
                        -orient => "horizontal",
                        -label  => "Zahl 2 :",
                       )
                 ->pack();

my $scale3 = $f1->Scale(-from   => 0,
                        -to     => 100,
                        -orient => "horizontal",
                        -label  => "Zahl 3 :",
                       )
                 ->pack();


MainLoop();

sub ergebnis {
    $summe = $scale1->get() + $scale2->get() + $scale3->get();
}
