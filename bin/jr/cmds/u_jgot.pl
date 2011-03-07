sub u_jgot(\@) {
  my $A = shift(@_);
  if ( @$A != 0 ) {
    print STDERR "jgot ignoring command line arguments\n";
  }
  return u_mysystem("javac *.java");
}
