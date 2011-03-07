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
$result = File::Compare::compare_text($ARGV[0], $ARGV[1]);

exit $result;
