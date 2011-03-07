sub u_jgox($) {
  my $basen = shift(@_);
  my $args = u_quote_args(@ARGV);
  
  $exitstatus = u_mysystem("java $basen $args");

  return $exitstatus;
}

