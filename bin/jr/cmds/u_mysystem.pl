sub u_mysystem($) {
  my $s = shift(@_);
  system($s);
  return $?>>8;
}

