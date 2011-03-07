#
# finds jr or java file containing main
# and then echoes that class name
#
# invoke as jrfindmain for jr files
# invoke as jfindmain for java files
#
# not perfect:
#   assumes main declaration
#     appears entirely on 1 line
#     does not appear in comments.
#     contains no comments within (e.g., "... void /*haha*/ main ...")
#   assumes the program does not have multiple main methods
#        (allowed but probably not common).

sub u_findmain($$) {
  my $suffix = shift(@_);
  my $msg = shift(@_);

  # make sure have at least one file with $suffix
  my $none = 1;
  my @suffixfiles = ("*$suffix");
  foreach my $f ( <@suffixfiles> ) {
    $none = 0;
    last;
  }
  if ($none) {
    $! = 1;
    die "$0 sees no $suffix files\n";
  }

  # build up expression for which to search

  # "void main" part
  my $v = "void\\s+main";

  # parameter parts
  # q is (String [] args)
  # r is (String args [])
  # remember to escape \, (, ), [, ]
  my $idpat = "[a-zA-Z_][a-zA-Z_0-9]*";
  my $q = "\\(\(\\s*final\\s\)?\\s*String\\s*\\[\\s*\\]\\s*$idpat\\s*\\)";
  my $r = "\\(\(\\s*final\\s\)?\\s*String\\s+$idpat\\s*\\[\\s*\\]\\s*\\)";

  my $p = "($q|$r)";

  # specifier parts
  my $s = "(public\\s+static|static\\s+public)";

  my $a = "$s\\s+$v\\s*$p";
  #######print $a;

  my $count = 0;
  my $file = ""; # set only if count>0
  # parallel arrays:
  #   filenames and linenumbers within those files on which main found.
  # just for fancy error output.
  my @allwithmainfilenames = ();
  my @allwithmainlinenumbers = (); 
  foreach my $f ( <@suffixfiles> ) {
  ####  print "xxxxxxxx $f\n";
    open(F,$f);
    my $linenumber = 0;
    while ( <F> ) {
  ####    print "$_\n";
      $linenumber++;
      if (/$a/) {
  #######print "found";
        $count++;
        $file = $f;
	push(@allwithmainfilenames, $f);
	push(@allwithmainlinenumbers, $linenumber);
      }
    }
    close(F);
  }
  ##print $count, "\n";
  ##print $file, "\n";
  ##print $0, "\n";

  if ($count == 0) {
    $! = 1;
    die "$0 can't find main_class\n";
  }
  if ($count != 1) {
    $! = 1;
    print STDERR "$0 found multiple ($count) mains:\n";
    for (my $i = 0; $i < $count; $i++) {
	print STDERR "  file $allwithmainfilenames[$i], line $allwithmainlinenumbers[$i]\n";
    }
    die "use $msg\n";
  }

  my $basen = $file;
  # strip off any leading path
  $basen =~ s#.*/##;
  # strip off suffix
  $basen =~ s/$suffix$//;

  return $basen;
}

