sub u_jr(\@) {
  my $A = shift(@_);
  # for translating and running a simple JR program:
  #   usage: jr name_of_main_class [arguments to JR program]
  #
  # assumes JR program is exactly *.jr.
  #
  # note: removes jrGen (e.g., in case it was copied and now contains extra)

  #### arguably, jr should use "--"
  #### to separate jr options from program options.
  #### if it did, then below code could be replaced by call to GetOptions.
  #### similarly, jrgo and jrgox should then use "--" and could handle
  #### -explicit or -implicit args (or could hack them like below too).
  #### (jrgo and jrgox don't work now since they put the name_of_main_class
  #### as first argument to jr.)
  #### (if change anything, be sure to update book appendix.)

  # handle -explicit or -implicit
  # that appear before name_of_main_class
  # (note: doesn't handle -version anymore since test for number of args
  # below would fail.)
  # so now correctly handle, e.g.,
  #    jr -explicit main.jr (previously wasn't giving error)
  #    jr -explicit (previously wasn't giving error)
  my @args = @EMPTY;
  my $shiftcnt = 0; # bad idea to shift @A within foreach ...(@A)
  foreach my $a (@$A) {
    if ($a =~ /^-explicit$/ || $a =~ /^-implicit$/) {
	push(@args, $a);
	$shiftcnt++;
    }
    elsif ($a =~ /^-/) {
      $! = 1;
      die "unknown command line option\n";
    }
    else { # quit arg processing on first non "-" argument
      last;
    }
  }
  for (my $k=1; $k <= $shiftcnt; $k++) {
      shift(@$A);
  }

  # sanity check
  if ( @$A < 1 ) {
    $! = 1;
    die "usage: $0 name_of_main_class \[arguments to JR program\]\n";
  }

  # some error checking to avoid common mistake: jr *.jr
  if (@$A[0] =~ /\.jr$/) {
    $! = 1;
    die "error: name_of_main_class is a .jr file\n";
  }

  ##print "jr.pl $CLASSPATH \n";

  my @theargs = (@args, @$A); 

  ##print "u_jr @theargs zz \n";

  my $exitstatus;
  my $unused = # avoid "Useless use of not in void context..."
  ##!system("echo 001") &&
  !($exitstatus = u_jrt(@EMPTY)) &&
  ## !system("echo 006") &&
  !($exitstatus = u_jrrun( @theargs ));
  return $exitstatus;
}

