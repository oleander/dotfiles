# finds java file containing main
# and then runs java and javac using that file's name as name_of_main_class.
# (not symmetric with jrgo; more a combination of jr and jrgo)

# u_jfindmain does all the work and exits on failure.
my $basen;
$basen = u_jfindmain();

my $exitstatus;
$exitstatus = u_jgo($basen);
exit $exitstatus;

