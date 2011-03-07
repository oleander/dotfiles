# preserve any quoting on command line by putting each A in quotes.
sub u_quote_args(\@) {
  my $A = shift(@_);
  my $args = "";
  foreach my $a ( @$A ) {
    $args .= "\"$a\" ";
    # print ":$a \n"
  }
  return $args;
}

