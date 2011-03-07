sub u_jgo($) {
  my $basen = shift(@_);
  my $args = u_quote_args(@ARGV);
  
  # assign result to variable below to avoid Perl -w warning:
  # "Useless use of not in void context ..."

  my $unused =
  !($exitstatus = u_mysystem("javac *.java")) &&
  !($exitstatus = u_mysystem("java $basen $args"));

  return $exitstatus;
}

