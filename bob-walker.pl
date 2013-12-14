#!/usr/bin/env perl

use strict;
use Getopt::Std;

my %opt;
getopts('hadprsx', \%opt);

my @words = qw(beard beer pie);

sub usage() {
    print STDERR << "EOF";
usage: $0 options

This script simulates a bob walker

OPTIONS:
    -h      Show this message
    -a      Enable all modes!
    -d      Drunk mode!
    -p      Programming mode!
    -r      Random mode!
    -s      Sport mode!
    -x      Christmas mode!

EOF
    exit;
}

# -h means we need help!
usage() if $opt{h};

# -s invokes sport mode!
if ($opt{s} or $opt{a}) {
    push(@words,"rugby");
    push(@words,"cricket");
}

# -p invokes programming mode!
if ($opt{p} or $opt{a}) {
    push(@words,"chef");
    push(@words,"perl");
    push(@words,"CPAN");
}

# -x invokes christmas mode!
if ($opt{x} or $opt{a}) {
    push(@words,"mince pies");
    push(@words,"reindeer");
}

# -d if we are drunk, become sleepy
sub filter() {
    my $word = $_[0];
    if ($opt{d} or $opt{a}) {
        $word =~ s/e/eeee/g;
        print "$word\n";
        sleep(1);
    } else {
        print "$word\n";
    }
}

sub choice() {
    my $counter  = $_[0];
    my $listSize = scalar @words;
    my $choice;
    if ($opt{r} or $opt{a}) {
       $choice = int(rand($#words));
    } else {
       $choice = $counter % $listSize;
    }
    $words[$choice];
}

my $count;
for ($count = 1; $count < 10000000000; $count++) {
    &filter(&choice($count));
}
