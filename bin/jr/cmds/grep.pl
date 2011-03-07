# 2002-07-05 downloaded from http://www.netcetera.org
# changes:
#   made output more like UNIX's grep
#     (only show filename if grepping multiple files)
#   implemented -v and -c options

# 2003-07-24 oops!
# changes:
#   added exit status (was always exiting with 0, so jrv Scripts not
#   really testing as they should)
#
#   also changed from using regex matching to use index
#   (thus, more like UNIX grep: grep "multiple (2) found"
#    will work without interpreting (2) as regex.)
#   (as part of this change, mapped $pattern to lowercase too)   
#   N.B., this limits what can be put in Script files
#   e.g., * now means just *, nothing special (unlike regular grep)

#!/usr/local/bin/perl -w
#
# grep.pl - a simple grep subset, implemented in Perl
#
# v1.1, 04/viii/01
# (c) Simon Whitaker, 2001

use strict;
use Getopt::Std;

my %opts;
my @dirs;
my @files;

# Get boolean command line switches using getopts
#   r = recurse through subdirectories
#   h = show help
#   i = case insensitive
#   c = only count matching (-v non-matching) lines
#   v = invert the sense of matching
getopts('rhicv', \%opts);

# For the sake of readability let's assign the options to named variables
my $recurse = $opts{r};
my $help    = $opts{h};
my $i       = $opts{i} ? "(?i)" : "";
my $c       = $opts{c};
my $v       = $opts{v};

if ($help) {
  print <<END;

Usage: grep [-h] [-r] [-i] [-c] [-v] pattern file/directory

       grep searches for patterns in text files

Options:
       -h   show this help information

       -r   recurse through subdirectories

       -i   make search case insensitive

       -c   only count matching (-v non-matching) lines

       -v   invert the sense of matching

END
exit 1;
}

# Read other arguments - need file to search in and pattern to look for
my $pattern = shift;
if ($i ne "") {
  $pattern =~ tr/A-Z/a-z/;
}


#@ARGV || ($! = 1 and die "Insufficient arguments supplied.\nUsage: grep [options] pattern file [file2 file3...]\n");

if (@ARGV) {
  for (@ARGV) {
    if (-d) {
      getFilesFromDir($_, \@files)
    }
    elsif (/\*/) {
      my @wildcardFiles = glob($_);
      for my $thisFile (@wildcardFiles) {
        push @files, $thisFile;
      }
    }
    else { push @files, $_ }
  }

  my $multiplefiles = scalar(@files)  > 1;
  my $exitstatus = 1;
  for (@files) {
    my $count; # number of lines on which pattern occurs in a file
    $count = lookFor($multiplefiles, $pattern, $_);
    if ($count > 0) {
      $exitstatus = 0;
    }
  }
  exit $exitstatus;
}

sub lookFor {
  my $showfn  = shift; # print filename?
  my $pattern = shift;
  my $file    = shift or return;
  my $lineNo;
  
  my $count = 0;
#  open (FH, $file) or (print "Can't open $file for reading\n" and return);
  open (FH, $file) or ($! = 2 and die "Can't open $file for reading\n");
  while (<FH>) {
#    if ( (!$v && /$i$pattern/) || ($v && !/$i$pattern/) ){
    my $target = $_;
    if ($i ne "") {
      $target =~ tr/A-Z/a-z/;
    }
    my $hit = (index($target,$pattern) != -1);
    if ( (!$v && $hit) || ($v && !$hit) ){
      $count++;
      if (! $c) {
        if ($showfn) {
          print "$file ($.): $_";
        }
        else {
          print "$_";
        }
      }
    }
  }
  close FH;
  print "$count\n" if ($c);
  return $count;
}

sub getFilesFromDir {
  my $root  = shift;
  my $files = shift or return;

  opendir(ROOT, $root) or die "On opening $root: $!";
  my @files = readdir ROOT;
  for my $thisFile (@files) {
    if (-d "$root/$thisFile") {
      next if $thisFile =~ /\.\.?/; # ignore . and ..
      getFilesFromDir("$root/$thisFile", $files) if $recurse;
    }
    elsif ( -T "$root/$thisFile" ) {
      push @$files, "$root/$thisFile";
    }
  }
  closedir ROOT;
}
