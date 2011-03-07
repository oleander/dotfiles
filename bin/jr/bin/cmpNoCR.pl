# 2005-06-16 like cmp.pl, but ignore differences due to different
# newline conventions.
#
# for use under Cygwin:
#  when using
#     the Java installed within Windows
#     the Perl installed within Cygwin
#  a println() generates a \r\n in .out files
# whereas the .std files contain only \n
# could fix via changing println() to println(" "),
# but don't want to require that in all the source (esp. the book's code).

# 
# just sets exit status, like UNIX's "cmp -s"

use strict;

use Getopt::Long;
my $option_s;
GetOptions('s' => \$option_s)
|| die "$0: problem processing command line options\n";

(@ARGV == 2) ||
    die "$0: needs exactly two filenames to compare\n";

use File::Compare;
my $result;
$result = File::Compare::compare_text($ARGV[0], $ARGV[1],
                                      sub {return &cmpline($_[0], $_[1]);});

exit $result;

# compare lines, but ignore \r's.
sub cmpline {
    my $l0 = $_[0];
    my $l1 = $_[1];
    $l0 =~ s/\r//g;
    $l1 =~ s/\r//g;
    $l0 ne $l1
}
