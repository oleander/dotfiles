## print "jrc.pl @ARGV \n";

u_init();
my $exitstatus;
$exitstatus = u_jrc(@ARGV);
exit $exitstatus;

