#!/usr/bin/perl -w
# remove jr_Gen directories

use strict;

my $dir;  # directory in which to start

main();

sub main {

    if (@ARGV == 0) {
	$dir = ".";
    }
    elsif (@ARGV == 1) {
	$dir = $ARGV[0];
    }
    else {
	$! = 1;
	die "usage: $0 [startdir]\n";
    }
##print "$dir\n";
    # remove all jrGen directories under $dir
    use File::Find;
    &finddepth(\&dwanted, $dir);

    exit 0;
}

sub dwanted {
    use File::Path;
    (    /^jrGen$/
    )
##	&& print "$File::Find::name \n";
	&& rmtree("jrGen");
}
