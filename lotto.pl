#!/usr/bin/perl
# 2010-11-05 Sebastian Rockel
# Parse lotto historic file
# count support of numbers
# present it to user
#

use warnings;
use strict;

if ( ($#ARGV+1) <= 0) {
  print "Usage: lotto.pl <text file>\n";
  exit 0;
}

my $INFILE=shift;
die "Cannot open file $INFILE, $!" if (! -e $INFILE);

open(INFILE, "<", $INFILE) or die "Cannot open file: $!";

my @count6of49   = ();
my @countZusZahl = ();
my @countSupZahl = ();
# Init with zeros
for (my $count=0; $count<49; $count++){ push(@count6of49, 0); }
for (my $count=0; $count<49; $count++){ push(@countZusZahl, 0); }
for (my $count=0; $count<10; $count++){ push(@countSupZahl, 0); }

my $cntGames=0;
while(<INFILE>){
  chomp($_);
  if ( $_ =~ m/\W*?^Gewinnzahlen:\D*?(\d{1,2})\D*?\,\D*?(\d{1,2})\D*?\,\D*?(\d{1,2})\D*?\,\D*?(\d{1,2})\D*?\,\D*?(\d{1,2})\D*?\,\D*?(\d{1,2})/ ){
    $count6of49[$1-1]+=1;
    $count6of49[$2-1]+=1;
    $count6of49[$3-1]+=1;
    $count6of49[$4-1]+=1;
    $count6of49[$5-1]+=1;
    $count6of49[$6-1]+=1;
    $cntGames++;
  }
  if ( $_ =~ m/\W*?^Zusatzzahl:\D*?(\d{1,2})/ ){
    $countZusZahl[$1-1]+=1;
  }
  if ( $_ =~ m/\W*?^Superzahl:\D*?(\d{1,2})/ ){
    $countSupZahl[$1]+=1;
  }
}
close(INFILE);

my $aSize = @count6of49;
my $sumAll=0;

$sumAll = $cntGames*6;
my $equalProp = $sumAll/49;
my %numProp = ();
my %zusPropHash = ();
my %supPropHash = ();
my $ZusEqProp = $cntGames/49;
my $SupEqProp = $cntGames/10;

# Print results
print "6 aus 49 : $cntGames Spiele\n";
printf("Zahl | #gezogen | rel. Haeufigk. | Zus.Haeuf. | Zus.zahl | Sup.Haeuf. | Sup.zahl\n");
for (my $number=0; $number<=49; $number++){
  my $numProp = $count6of49[$number-1]/$equalProp;
  my $zusProp = $countZusZahl[$number-1]/$ZusEqProp;
  my $supProp = 0.;
  if ($number < 1){
    $supProp = $countSupZahl[$number]/$SupEqProp;
    printf( "%2d:\t\t\t\t\t%2d\t%.2f\n",
      $number,
      $countSupZahl[$number],
      $supProp);
  }elsif ( $number<10 ){
    $supProp = $countSupZahl[$number]/$SupEqProp;
    printf( "%2d:\t%2d\t%.2f\t%2d\t%.2f\t%2d\t%.2f\n",
      $number,
      $count6of49[$number-1],
      $numProp,
      $countZusZahl[$number-1],
      $zusProp,
      $countSupZahl[$number-1],
      $supProp);
  } else {
    $supProp = 0.;
    printf( "%2d:\t%2d\t%.2f\t%2d\t%.2f\n",
      $number,
      $count6of49[$number-1],
      $numProp,
      $countZusZahl[$number-1],
      $zusProp);
  }
  $numProp{$number}=$numProp;
  $zusPropHash{$number}=$zusProp;
  if ( $number<10 ){
    $supPropHash{$number}=$supProp;
  }
}

print "Summe:\t" . $sumAll . "\n";
printf("Gleichwahrscheinlichkeit:\t%.2f\n", $equalProp);

print "\nWahrscheinlichste Zahlen:\n";
foreach my $value (sort {$numProp{$b} cmp $numProp{$a}} keys %numProp) {
  printf ( "%2d:\t%5.2f\n", $value, $numProp{$value}-1);

}
print "\nWahrscheinlichste Zus.zahlen:\n";
foreach my $value (sort {$zusPropHash{$b} cmp $zusPropHash{$a}} keys %zusPropHash) {
  printf ( "%2d:\t%5.2f\n", $value, $zusPropHash{$value}-1);

}
print "\nWahrscheinlichste Sup.zahlen:\n";
foreach my $value (sort {$supPropHash{$b} cmp $supPropHash{$a}} keys %supPropHash) {
  printf ( "%2d:\t%5.2f\n", $value, $supPropHash{$value}-1);

}
#print "@countZusZahl\n";
#print "@countSupZahl\n";


exit 0;
