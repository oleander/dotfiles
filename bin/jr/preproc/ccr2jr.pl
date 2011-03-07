
my $fsuffix = "ccr";

# parsing routines:
my $gnest; # nesting depth of _region
my $snest; # nesting depth of _resource

# semantic checking
my $sawregion = 0; # have seen any _regions.
my %resources; # names of resources seen
# fields need not be unique across resources,
# so fields won't necessarily be entirely accurate.
# but it's a good quick check in most cases;
# if it fails, then look in resourcesfields, which has complete info.
my %fields; # pairs of (fields, resource in which defined)
my %resourcesfields; # pairs of (resource,field), anything)
my %regions; # names of active regions
my %regions_refcnt; # reference count for active region
                    # (so searching can just use defined().)
my @thisnamestack; # records the thisnames for active regions

main();

sub main {

  $exitstatus = 0; # in case no command line args, so terminate works.

  foreach my $a (@ARGV) {
    my $newn = checkfile($a, $fsuffix);
    if (!open(I, "$a")) { # input file
      $! = 1;
      die "can't open $a\n";
    }
    $Ifile = "$a";
    if (!open(O, "> $newn")) { # output file
      $! = 1;
      die "can't open $newn\n";
    }
    do1file();
    close(I);
    close(O);
  }
  if ( checkenv() ) {
    my $PREPROC = "$JR_HOME/preproc/";
    if  ( checkdir($PREPROC) ) {
      use File::Copy;
      mustcopy("$PREPROC/r_rem.jr",".");
    }
  }
  terminate();
}

sub do1file {

  # (re-)initialize globals
  $tok = ""; # anything not "EOF"
  $realtok = "(**EOF**)";
  $line = "";
  $wholeline = "";

  $exitstatus = 0;
  $errorcnt = 0;
  $MAXERRCNT = 20;

  $gnest = -1; # -1 since serves as index into stack array.
  $snest = 0;

  print O "$BANNER\n";
  parse();
  print O "\n";

}

sub parse {
  scan();
  stuff("main");
  if ($tok ne "EOF") {
    error("junk after logical end of input (possible extra })");
  }
}

# invoked either for main or region.
# behaves slightly differently.
sub stuff {
  my $how = shift(@_); # not used anymore, except in debug output.
  my $previd = ""; # previous ID (will be the one before a ".")
  while ($tok ne "EOF" && $tok ne "}") {
##    print "tok is $tok\n";
##    print "realtok is $realtok\n";
    if ($tok eq "{") {
      out($tok);
##    print "recursing $how on { $realtok \n";
      scan();
      stuff($how);
##    print "back from recursing $how on { $realtok \n";
      mustbe("}");
      outln("}");
    }
    elsif ($tok eq "ID") {
      if ($realtok eq "_resource") {
        if ($sawregion ne 0) {
          # keep going to try to find other errors
          error("_resource appears after _region");
        }
        resource();
      }
      elsif ($realtok eq "_region") {
        $sawregion = 1;
        region();
      }
      else { # i.e., non-interesting id.
        $previd = $realtok;
        outln($realtok);
        scan();
      }
    }
    elsif ($tok eq ".") {
      out($tok);
      scan();
      if ($tok eq "ID") {
##print "found dot $realtok \n";
        if (defined($fields{$realtok})) { # found field name
##print "$realtok is defined\n";
          my $within = 1; # whether field within region
          if (!(defined($regions{$fields{$realtok}}))) {
##print "$fields{$realtok} is defined\n";
            $within = 0;
            # try a bit harder to find field name
            # it might be duplicated in resources,
            # so its fields is for other resource.
            foreach my $r (keys %regions) {
               if ( defined($resourcesfields{$r,$realtok}) ) {
                 $within = 1;
                 last;
               }
            }
            if ($within == 0) { 
              error("found `" . $realtok . "' outside region");
            }
          }
          if ($within == 1) { # within region, check that 
            if ($previd eq "") { # using only id.id form (e.g., not id[id].id)
              error("must reference `" . $realtok .
                    "' only via region's thisname");
            }
            else { # using id.id, check that first id is a thisname.
              my $k;
              for ($k=0; $k < $gnest; $k++) {
# print "$k \n";
# print "$thisnamestack[$k] \n";
# print "previd = $previd \n";
                if ($thisnamestack[$k] eq $previd) { last;}
              }
              if ($k >= $gnest) {
                error("must reference `" . $realtok .
                       "' only via region's thisname");
              }
            }
          }
	}
      }
      # note that if get id above, then it won't be region (shouldn't happen)
      out($realtok);
      scan();
    }
    else { # i.e., not dot or id
      $previd = "";
      out($realtok);
      scan();
    }
  }
##  print "tok is $tok\n";
##  print "realtok is $realtok\n";
}

sub resource {
  if ($snest > 0 || $gnest > 0) {
    error("_resource nested within _resource or _region; truly weird, Dude.");
    terminate();  }
  $snest++;
  mustbe("ID"); # skip over _resource
  my $classname = mustbe("ID");
  if (defined($resources{$classname})) {
    error("resource `" . $classname . "' already seen");
  }
  $resources{$classname} = "*nothing*"; # any value will do
  outln("class ".$classname." {");
  outln("  r_rem r_r = new r_rem();");
  toplevels($classname);
  out("}");
  $snest--;
}


# don't output top { and  } here; do those in resource
sub toplevels {
  my $classname = shift(@_);
  mustbe("{");
  while ( $tok ne "EOF" && $tok ne "}") {
    toplevel($classname);
  }
  mustbe("}");
}

# handle toplevel declarations or static{} or regular {}
sub toplevel {
  my $classname = shift(@_);

  # static can start a declaration or an initializer
  # for us, it's okay just to skip it.
  my $sawstatic = 0;
  if ($tok eq "ID" && $realtok eq "static") {
    $sawstatic = 1;
    outln($realtok);
    scan();
  }
  if ($tok eq "{") { # handle initializer (static or non-static)
    initializer();
  }
  else {
    decllist($classname,$sawstatic)
  }
}

# gobble up initializer,
# which (for us) consists of stuff within matched pair of {}.
sub initializer {
  mustbe("{");
  outln("{");
  while ( $tok ne "EOF" && $tok ne "}") {
    if ($tok eq "{") {
      initializer();
    }
    else {
      if ($tok eq "ID") {
        outln($realtok);
      }
      else {
        out($realtok);
      }
      scan();
    }
  }
  mustbe("}");
  outln("}");
}

# each of following is an example of a decllist:
#   public boolean free;
#   public int x, y;
#   public int x = 10;
#   public int x = 10, y =  20;
#   public int [] x = new int [10];
#
# idea: keep last id before `;', `,', `='.

sub decllist {
  my $classname = shift(@_);
  my $sawstatic = shift(@_);
  my $myid = "";
  my $sawfinal = 0;
  my $loop1 = 1; # simulate do { ... } while loop
  while ( $loop1 ) {
##print "xx  $tok $realtok\n";
    my $seenequals = 0;
    my $loop2 = 1; # simulate do { ... } while loop
    while ( $loop2 ) {
##print "yy  $tok $realtok\n";
      if ($seenequals == 0 && $tok eq "ID") {
        if ($realtok eq "static") { $sawstatic = 1;}
        elsif ($realtok eq "final") { $sawfinal = 1;}
        $myid = $realtok;
      }
      elsif ($tok eq "=") {
        $seenequals++;
      }
      if ($tok eq "ID") {
        outln($realtok);
      }
      else {
        out($realtok);
      }
      scan();
      $loop2 = $tok ne "," && $tok ne ";" && $tok ne "EOF";
    }

##print "zzz" myid
    if ($myid eq "") {
      error("can't parse declaration");
      terminate();
    }
    if ($sawstatic == 1) {
      if ($sawfinal == 0) {
        error("static non-final declaration in resource not allowed");
      }
    }
    else { # make entry only for non-static fields
      $fields{$myid} = $classname;
      $resourcesfields{$classname,$myid} = "*nothing*"; # any value will do
    }
    $loop1 = $tok ne ";" && $tok ne "EOF";
  }
  out($realtok);
  scan(); # skip semicolon
}

sub region {
  if ($snest > 0) {
    error("_region nested within _resource; truly weird, Dude.");
    terminate();
  }
  $gnest++;
  mustbeid("_region"); # skip over _region
  my $classname = mustbe("ID");
##print "$tok\n";
##print "$realtok\n";
  if (!defined($resources{$classname})) {
    error("_region for unknown resource `" . $classname . "'");
  }
  insert_regions($classname);
  mustbeid("_with");
  my $thisname = mustbe("ID");
  $thisnamestack[$gnest] = $thisname;
##print "$thisname\n";
##print "$tok\n";
##print "$realtok\n";
  mustbe("=");
  out("{ final $classname $thisname = ");
  # skip abitrary expression on RHS.
  my $one = 0;
  while ( $tok ne "EOF" && $realtok ne "_when" && $tok ne "{") {
    $one = 1;
    out($realtok);
    scan();
  }
  if ($one == 0) {
    error("empty right-hand side of =");
  }
  outln(";");
  out("$thisname\.r_r\.enter();");
  # could get rid of bozo if no while, but user could still say
  # _when true or _when false.
  # (perhaps should disallow those?)
  outln("boolean bozo$gnest = false;");
  outln("while (! (bozo$gnest =(");
  if ($realtok eq "_when") {
    scan();
    # skip abitrary _when expression
    my $one = 0;
    while ( $tok ne "EOF" && $tok ne "{") {
      $one = 1;
      out($realtok);
      scan();
    }
    if ($one == 0) {
      error("empty _when expression");
    }
  }
  elsif ($tok ne "{") {
    error("can't find { after _with with no _when");
  }
  else {
    out("true");
  }
  outln("))) {");
  outln("  $thisname\.r_r\.exit1_delay();\n}");
  $gnest++;
  mustbe("{");
  stuff("region");
  mustbe("}");
  outln("$thisname\.r_r\.exit2();\n}");
  delete_regions($classname);
  $gnest--; # note: effectively pops thisnamestack too.
}

sub insert_regions {
  my $classname = shift(@_);
  if (defined($regions{$classname})) {
    $regions_refcnt{$classname}++;
  }
  else {
    $regions{$classname} = "*nothing*"; # just make entry, value unused.
    $regions_refcnt{$classname} = 1;
  }
}

sub delete_regions {
  my $classname = shift(@_);
  if (!defined($regions{$classname})) {
    error("my bad: `" . $classname . "' not in regions (delete_regions)");
    terminate();
  }
  $regions_refcnt{$classname}--;
  if ($regions_refcnt{$classname} == 0) {
    delete $regions{$classname};
  }
}

