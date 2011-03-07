sub u_jrgox($) {
  my $basen = shift(@_);

  my @args = ($basen, @ARGV);

  return u_jrrun(@args);
}

