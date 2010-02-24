#!/usr/bin/perl -w 
# 
############################################################################## 
# Perl-Script bernoulli 
# 
# berechnet die Bernoulli-Zahlen mit langer Rationalzahl-Arithmetik 
# mit Hilfe der Perl-Module Math::BigInt und Math::BigRat 
# 
# Author: B. Schiekel <mb.schiekel@t-online.de>, 
# Copyright (C) 2004 B. Schiekel, D-89073 ULM. 
# 
# This program is free software and distributed under the terms of the 
# GNU General Public License version 2 or later. 
############################################################################## 
use Math::BigInt; 
use Math::BigRat; 
$n = 0; 
$help = 0; 
if (defined @ARGV) { 
    foreach $arg (@ARGV) { 
        if ($arg =~ /-n=([0-9]+)/) {$n = $1;} 
        if ($arg =~ /--help/) {$help = 1;} 
        if ($arg =~ /-h/) {$help = 1;} 
    } 
} 
if ($help) { 
    print("\n"); 
    print("Aufruf: bernoulli [OPTION]\n"); 
    print("\n"); 
    print("Berechnet die Bernoulli Zahlen mit langer Rationalzahl-Arithmetik \n"); 
    print("und schreibt diese in die Datei bernoulli.dat \n"); 
    print("\n"); 
    print("-n=m [mit m = gr¨osste zu berechnende Bernoilli-Zahl] \n"); 
    print("--help this help\n"); 
    print("-h this help\n"); 
    print("\n"); 
    exit(0) ; 
} 
if ($n == 0) { 
    print("\n"); 
    print("B[0] = 1 , wenn Sie mehr wissen wollen, sollten Sie aufrufen:\n"); 
    print("bernoulli -n=m [mit m = gr¨osste zu berechnende Bernoulli-Zahl] \n"); 
    print("\n");
    exit(0); 
} 
# zun¨achst berechnen wir die Binomial-Koeffizienten, 
# (i|0) = (i|i) = 1; 
for ($i=0; $i<=$n; $i++) { 
    $binom[$i][0] = Math::BigInt->new(1); 
    $binom[$i][$i] = Math::BigInt->new(1); 
} 
# (i|1) = (i|i-1) = i; 
if ($n >= 2) { 
    for ($i=2; $i<=$n; $i++) { 
        $binom[$i][1] = Math::BigInt->new($i); 
        $binom[$i][$i-1] = Math::BigInt->new($i); 
    } 
} 
# (i|j) = (i-1|j) + (i-1|j-1) 
if ($n >= 4) { 
    for ($i=4; $i<=$n; $i++) { 
        for ($j=2; $j<=$i-1; $j++) { 
            $binom[$i][$j] = Math::BigInt->new(0); 
            $binom[$i][$j] = $binom[$i-1][$j] + $binom[$i-1][$j-1]; 
        } 
    } 
} 
# jetzt berechnen wir die Bernoulli-Zahlen 
$b[0] = Math::BigRat->new('1'); 
$b[1] = Math::BigRat->new('-1/2'); 
# Achtung: ab i>=2 sind nur die geraden b[i] definiert 
for ($i=2; $i<=$n; $i+=2) { 
    $b[$i] = Math::BigRat->new('0'); 
    for ($j=0; $j<=$i-1; $j++) { 
# ab j>=2 werden nur die geraden b[j] aufsummiert 
if ($j<=2 || $j==2*int($j/2)) { 
    $b[$i] = $b[$i] - ($b[$j] * $binom[$i][$j] / ($i-$j+1)); 
} 
} 
} 
# wir schreiben die Ergebnisse auf Datei 
# Achtung: ab i>=2 sind nur die geraden b[i] definiert 
open(DAT,">bernoulli.dat") || 
die "cannot open bernoulli.dat \n"; 
for ($i=0; $i<=$n; $i++) { 
    if ($i<=2 || $i==2*int($i/2)) { 
        print(DAT "B[$i] = ",$b[$i]->bstr(),"\n"); 
    } 
} 
close(DAT) || 
die "cannot close bernoulli.dat \n"; 
#bernoulli
