my $OSdelim;
my $OSsep;

my @EMPTY = (); # global constant

sub u_init() {

  use Env qw(JR_HOME CLASSPATH OS);

  # $OS defined only (usually) on Windows
  # Cygwin: $OS is windows will work fine
  # provided that Perl was installed within Cygwin.
  if(defined($OS) && $OS =~ /Windows/) {
    $OSdelim = ";";
    $OSsep = "\\";
  }
  else {
    $OSdelim = ":";
    $OSsep = "/";
  }

  if (! $JR_HOME ) {
    $! = 1;
    die "$0 requires environment variable JR_HOME\n"
      . "   to be set to the absolute pathname of JR's home\n";
  }

  if (! opendir (JRHOME, $JR_HOME) ) {
    $! = 1;
    die "$0: environment variable JR_HOME set to $JR_HOME\n"
      . "   but that directory does not exist or is not readable\n";
  }
  if (! closedir(JRHOME)) {
    $! = 1;
    die "$0: cannot close $JR_HOME\n";
  }

  my $JRT_JAR;
  my $JRX_JAR;
  ## print "ct sees jrhome= $JR_HOME\n";

  ##Set the JRT_JAR and JRX_JAR variables
  $JRT_JAR = setjarvar( "JRT", "jrt.jar");
  $JRX_JAR = setjarvar( "JRX", "jrx.jar");

  use Getopt::Long;
  my $optionclasspath;
  # handle only -classpath here.
  # other args specific to jr, jrc, or jrrun (e.g., -version, -explicit)
  # can be handled as needed by those tools.
  Getopt::Long::Configure("pass_through");
  GetOptions('classpath=s' => \$optionclasspath)
  || die "$0: problem processing command line options\n";

  ## print "after GetOptions \n";

  my $cpath;
  if ($optionclasspath) {
    $cpath = $optionclasspath . $OSdelim;
  }
  else {
    $cpath = "";
    if(defined($CLASSPATH)) {
	$cpath = $CLASSPATH . $OSdelim;
    }
  }
  # set CLASSPATH to get JR stuff.
  # until 2003-02 we prepended "." and $JR_JAR.
  # 2004-11-27: put both in CLASSPATH since generated code imports run-time
  $CLASSPATH = $cpath . "." . $OSdelim . $JRT_JAR
                            . $OSdelim . $JRX_JAR;
  ## print "ct1 $CLASSPATH \n";
}

# note: code is nearly the same as in jrv.
# at some point, share this sub.
# (no need to name as u_ since this sub used only within u_init.pl.)
sub setjarvar {
    my $m = shift(@_); # message
    my $f = shift(@_); # jar file

    my $jar = $JR_HOME . "/classes/" . $f;
    my $archname;
    $archname = `perl -V:archname`;
    # special case for Perl within Cygwin
    # since Java needs Windows-style CLASSPATH.
    # code after this if should work fine since Cygwin
    # allows both kinds of names.
    if(defined($OS) && $OS =~ /Windows/ && $archname =~ /cygwin/) {
	# 2007-10-20 quotes needed on $jar since it might contain spaces.
        $jar  = `cygpath -w "$jar"`;
	chomp($jar);
    }

    # Make sure that the file $jar points to is accessible
    # 2006-08-13 was:
    # if ( (-e $jar) !=1 || (-r $JR_HOME) != 1 ) {
    # but discovered that -e returns undefined if file doesn't exist
    # and then can't compare undefined with number.
    # (seems like it should return false.  Oh well, below is better anyway.)
    if ( !(-e $jar) || !(-r $JR_HOME) ) {
	$! = 1;
	die "$0: $m jar file set to " .
	    $jar .
	    "\nbut that file does not exist or is not readable\n";
    }

    return $jar;
}
