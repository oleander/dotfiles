use strict;

(@ARGV == 3) ||
    die "$0: needs commandname, pathname, and suffix\n";

my $commandname = $ARGV[0];
my $pathname = $ARGV[1];
my $suffix = $ARGV[2];

# use ../cmds since used in cmds, preproc, and jrv
open FIN, "../cmds/Master.bat" || die "Can't open Master.bat: $!\n";
while(<FIN>){
    s/GENBATREPLACETHIS/set com=$pathname$commandname$suffix/;
    print;
}
close FIN;
