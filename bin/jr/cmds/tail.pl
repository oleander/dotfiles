# 2002-07-05 downloaded from http://www.netcetera.org
# no changes made, except for these comments.

#!/usr/local/bin/perl -w
#
# tail.pl - simplified Unix tail command, implemented in Perl
#
# v1.1, 04/viii/01
# (c) Simon Whitaker, 2001

use strict;
use Getopt::Std;

my %opts;

# Get command line switches with arguments using getopt
#   n = number of lines to read (default 10)
getopt('n', \%opts);

# Get boolean command line switches using getopts
#   h = show help
getopts('h', \%opts);

# For the sake of readability let's assign the options to named variables
my $numLines  = $opts{n};
my $help      = $opts{h};
my $showFilename;

if ($numLines < 1) { $numLines = 10 }

if ($help) {
  print <<END;

Usage: tail [-n num] file [file2 file3...]

       tail displays the last num lines of a text file

Options:
       -h   show this help information

       -n   specify number of lines to display (default is 10)

END
exit;
}

# Read other arguments - need file to search in and pattern to look for
@ARGV || die "Insufficient arguments supplied.\nUsage: tail [options] file [file2 file3...]\n";

# We want to display filenames if we're working with more than one file or with wildcards
if (@ARGV > 1 || $ARGV[0] =~ /\*/) {
  $showFilename = 1;
}

while (my $file = shift @ARGV) {
  if ($file =~ /\*/) { 
    push @ARGV, glob $file;
    next;
  }
  
  print "\n==> $file <==\n" if $showFilename;
  # Step through once, to find number of lines
  open (FH, $file) or print "Can't open $file for reading\n";
  1 while <FH>;
  my $totalLines = $.;
  close FH;

  open (FH, $file) or print "Can't open $file for reading\n";
  while (<FH>) {
    next if $. <= $totalLines - $numLines;
    print;
  }
  close FH;
  
}
