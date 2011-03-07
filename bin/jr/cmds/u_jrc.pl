sub u_jrc(\@) {
  my $A = shift(@_);

  ## print "u_jrc.pl $CLASSPATH \n";

  return u_mysystem("java edu.ucdavis.jr.trans.sun.tools.javac.Main -classpath \"$CLASSPATH\" @$A");

}

