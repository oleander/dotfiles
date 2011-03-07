sub u_jrt(\@) {
  my $A = shift(@_);
  if ( @$A != 0 ) {
    print STDERR "jrt ignoring command line arguments\n";
  }
  # for translating a simple JR program:
  #   usage: jrt
  #
  # assumes JR program is exactly *.jr.
  #
  # note: removes jrGen (e.g., in case it was copied and now contains extra)

  ##print "jr.pl $CLASSPATH \n";

  # 2005-02-23 following is no longer needed (and probably wasn't for a while).
  # it would also set path to a path with Windows-style separator when run
  # under Cygwin with a Cygwin Perl,
  # which caused, e.g., system("rmic ...") not to find rmic.
  ## set PATH to get JR stuff
  ##use Env qw(PATH);
  ## 2003-09-03 need $OSdelim for ActivePerl (seems OK on other Perls)
  ##$PATH = "$JR_HOME" . "$OSsep" . "bin" . "$OSdelim" . "$PATH";

  # remove
  use File::Path;
  rmtree("jrGen", 0, 1);

  # now translate
  # (note system() returns exit status, so need to negate it)
  # note: use 'javac jrGen/*.java'
  #       rather than 'cd jrGen; javac *.java'
  # in case CLASSPATH set to something interesting
  # (e.g., pathname relative to current directory)

  my @starjr = glob("*.jr");
  # print "zz @starjr \n";

  # the duplicate $OSsep in u_mysystem below is:
  #   innocuous under Windows \\ and UNIX // interpreted without harm.
  #   needed under Cygwin  \\ interpreted as \, given to javac, which
  #      interprets it as Windows pathname, bravo.
  #      (could special case for Cygwin instead,
  #       but above likely more efficient.)

  my $exitstatus;
  my $unused = # avoid "Useless use of not in void context..."
  ##!system("echo 001") &&
  !($exitstatus = u_jrc(@starjr)) &&
  ##!system("echo 002") &&
  !($exitstatus = u_mysystem("javac jrGen" . $OSsep . $OSsep . "*.java"));

  ##  Java1.5 no longer needs rmic, so we don't need the rest of this:
  ##!system("echo 003") &&
  ##chdir("jrGen") &&
  ##!system("echo 004") &&
  ##
  ##!($exitstatus = u_mysystem("$jr_rmic")) &&
  ##!system("echo 005") &&
  ##chdir("..");

  return $exitstatus;
}

