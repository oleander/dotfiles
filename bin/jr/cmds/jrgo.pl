# u_jfindmain does all the work and exits on failure.
my $basen;
$basen = u_jrfindmain();

u_init();
my $exitstatus;
$exitstatus = u_jrgo($basen);
exit $exitstatus;

