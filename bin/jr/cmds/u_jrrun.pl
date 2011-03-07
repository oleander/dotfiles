sub u_jrrun(\@) {
  my $A = shift(@_);

  # common code set CLASSPATH, but we need it to include jrGen,
  # so we'll set it again (but only add jrGen).
  # until 2003-02 we prepended jrGen.

  $CLASSPATH= $CLASSPATH . $OSdelim . "jrGen";
  ## print "jrrun sees classpath= $CLASSPATH\n";

  my $args = u_quote_args(@$A);
  ##print "u_jrrun $args\n";
  use Env qw( JRSH JRRSH JRSHC );
  # use these variables rather than above to avoid
  # warnings about "Use of uninitialized value ..."
  my $myJRSH  = defined($JRSH ) ? $JRSH  : "";
  my $myJRRSH = defined($JRRSH) ? $JRRSH : "";
  my $myJRSHC = defined($JRSHC) ? $JRSHC : "";

  return u_mysystem ("java -DJRSH=$myJRSH -DJRSHC=$myJRSHC -DJRRSH=$myJRRSH edu.ucdavis.jr.jrx.JRX_impl $args");

}

