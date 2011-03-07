#!/usr/local/bin/perl -w
# sort - sort files (no merging yet)
# Copyright (c) 1999 Albert Dvornik <bert@mit.edu>
#
# This program is free and open software. You may use, modify, distribute,
# and sell this program (and any modified variants) in any way you wish,
# provided you do not restrict others from doing the same.
#
# [On the other hand, you may wish to wait with distributing and selling
# for long enough for us to whip up some documentation and fix the bugs. =)]

use strict;
use locale;

### parse command line

use vars qw( $DEBUG @keys @files %sort_opt $delim $uniquify $have_non_b );

# show usage
sub usage {
  $! = 2;
  die join "\n", @_, <<"EndOfUsage";
Usage:   sort [options] [files...]
Summary of options:
 -u      Output single line for each set of lines with equal keys.  ("unique")
 -t STR  Set the field separator to string STR.
 -: RE   Set the field separator to Perl regular expression RE.
 -D      Enables debugging output.

 -b      Ignore leading whitespace.
 -d      Ignore everything but letters, digits and whitespace.  ("dictionary")
 -f      Fold upper case letters to lower case.
 -i      Ignore non-printable characters.
 -n      Compare fields numerically.
 -r      Reverse the sense of comparisons.

 +FIELD1[.CHAR1][bdfinr] [-FIELD2[.CHAR2]][bdfinr]
         Specify starting [and ending] position for sort key, counting fields
         and characters from 0.  Ending position is first character after key.
         Letters specify options for current key; otherwise use global options.
 -k FIELD1[.CHAR1][bdfinr][,FIELD2[.CHAR2]][bdfinr]
         Specify starting [and ending] position for sort key, counting fields
         and characters from 1.  Ending position is last character within key.
         Letters specify options for current key; otherwise use global options.

See documentation for details.
EndOfUsage
}

# convert option letters into a hash
sub curr_opt {
  my @opt = map split(//), grep defined, @_;
  my $ret = @opt ? {map +($_,1), @opt} : {%sort_opt};
  $have_non_b = 1 unless $ret->{'b'};
  $ret;
}

ARG:
while (@ARGV) {
  local ($_) = shift @ARGV;

  # handle +pos1[opts] -pos2[opts]

  my (@beg, @end);
  if (@beg = /^\+(\d+)(?:\.(\d+))?([bdfinr]*)$/) {
    @end = ();
    @ARGV && (@end = ($ARGV[0] =~ /^-(\d+)(?:\.(\d+))?([bdfinr]*)$/))
      && shift @ARGV;

    push @keys, [curr_opt($beg[2], $end[2]), 0, @beg[0,1], @end[0,1]];
    next ARG;
  }

  usage "The position specification `$_' is invalid." if /^\+/;

  # anything not starting with `-' should be a file

  /^-/ or push(@files, $_), next ARG;

  # `--' means the rest of the args are files and should be left alone

  ($_ eq '--') and last ARG;

  # handle flags

  substr $_, 0, 1, '';   # if we're here, $_ starts with a `-'; remove it.

 OPTION:
  while (length $_) {
    # get the next flag and remove it from $_
    my $o = substr $_, 0, 1, '';

    ($o eq 'D')
      and $DEBUG++, next OPTION;

    ($o eq 'b') || ($o eq 'd') || ($o eq 'f') || ($o eq 'i')
      || ($o eq 'n') || ($o eq 'r')
        and $sort_opt{$o} = 1, next OPTION;

    ($o eq 'u')
      and $uniquify = 1, next OPTION;

    if ($o eq 't') {
      usage "-t or -: may only be specified once." if defined $delim;
      length $_ and $delim = quotemeta(substr $_, 0, 1, ''), next OPTION;
      @ARGV     and $delim = quotemeta(shift @ARGV), next OPTION;
      usage "The argument to -t is missing.";
    }

    if ($o eq ':') {
      usage "-t or -: may only be specified once." if defined $delim;
      length $_ and $delim = $_, next ARG;
      @ARGV     and $delim = shift @ARGV, next ARG;
      usage "The argument to -: is missing.";
    }

    if ($o eq 'k') {
      $_ = shift @ARGV if !length $_ && @ARGV;
      @beg = /^(\d+)(?:\.(\d+))?([bdfinr]*)(?:,(\d+)(?:\.(\d+))?([bdfinr]*))?$/
        or usage "Invalid argument in -k '$_'.";
      push @keys, [curr_opt(@beg[2,5]), 1, @beg[0,1,3,4]];
      next ARG;   # we slurped the rest of the argument already
    }

    usage "Unrecognized flag '-$o'";
  }
}

($delim !~ m@(?:^|[^\\])/@s) && eval { qr/$delim/; 1 }
  or die "Delimiter regular expression is invalid.\n"
  if defined $delim;

@ARGV = (@files, @ARGV);  # set ARGV to the list of files to process
@keys = ([curr_opt(), 0, 0, undef]) unless @keys;   # default to `sort +0'

### construct parts of split_sub and sort_sub

use vars qw( @preps @splits @sorts );
use vars qw( $cur_field );
$cur_field = 1;

KEY:
foreach (@keys) {
  my ($opt, $offset, $field1, $char1, $field2, $char2) = @$_;

  $field1 -= $offset if defined $field1;
  $char1 -= $offset  if defined $char1;
  $field2 -= $offset if defined $field2;
  # NB: $char2 is _not_ affected by the offset, since -k ???,?.x
  # specifies the last character to be considered, but -?.x specifies
  # the first character to skip.

  # a `real' zero character offset implies just ignore this field
  $field2--          if defined $field2 && !$offset && !$char2;
  # character offset zero means *end* with -k (sigh)
  $char2 = undef     unless $char2;

  my ($field);

  if (! defined $field2) {
    # all options till the end -> make a looping quasi-Schwartzian transform

    # if the start has a character offset, we have to deal separately...
    add_cmp_field($field1, $char1, undef, $opt), $field1++ if $char1;
    # now handle the rest of the fields
    add_cmp_rest($field1, $opt);
    next KEY;
  }

  # a fixed number of options -> make a fixed Schwartzian transform.
  usage "A key ends before it starts." if $field1 > $field2;

 FIELD:
  foreach $field ($field1..$field2) {
    add_cmp_field($field,
                  ($field == $field1) && $char1,
                  ($field == $field2) ? $char2 : undef,
                  $opt);
  }
}

# make the code fragments used for fields in a key.
sub make_frags {
  my ($chunk, $low, $high, $opt, @ab) = @_;

  ## handle extraction

  # b   Ignore leading blanks (spaces and tabs) in field comparisons.
  $chunk = "($chunk =~ /(\\S.*)/)[0]"
    if $opt->{'b'} and !$opt->{'n'} || $low || $high
      and (defined $delim || $have_non_b);

  # handle character offsets
  $chunk = ("substr($chunk, " . ($low+0)
            . (defined $high && (', '.($high - $low))) . ")")
    if $low or defined $high;

  # f   Fold upper case letters onto lower case.
  $chunk = "lc($chunk)" if $opt->{'f'};

  # i   Ignore all characters that are non-printable, according to LC_CTYPE.
  if ($opt->{'i'} && !$opt->{'d'}) {
    $chunk = "join('', grep POSIX::isprint(\$_), split //, $chunk)";
    $INC{'POSIX.pm'} or require POSIX
      or die "-i requires the POSIX module!\nunable to proceed";
  }

  # options that require the use of temporaries

  # there's currently only one, so we roll it up into one line
  $chunk = "(\$tmp = $chunk,\n\t\$tmp =~ s/[^\\w\\s]+|_+//g,\n\t\$tmp)[-1]",
    @preps = ('my $tmp;')
      if $opt->{'d'};

#  if ($opt->{'d'}) {
#    @preps = ('my $tmp;');
#    $chunk = "(\$tmp = $chunk,\n\t";
#
#    # d   `Dictionary' order: only blank and alphanumeric characters,
#    #     according to the current setting of LC_CTYPE, are significant.
#    $chunk .= "\$tmp =~ s/[^\\w\\s]+|_+//g,\n\t" if $opt->{'d'};
#
#    $chunk .= "\$tmp)[-1]";
#  }

  ## handle comparison

  # n   Sort by numeric value (implies -b).
  my $sort_op = $opt->{'n'} ? '<=>' : 'cmp';

  # r   Reverse the sense of comparisons.
  @ab = reverse @ab if $opt->{'r'};

  ## return the result

  ($chunk, "($ab[0] $sort_op $ab[1])");
}

# do everything that's needed to set up a single field in a key.
sub add_cmp_field {
  my ($field, $low, $high, $opt) = @_;

  usage "A key's field ends before it starts."
    if defined $high and $low > $high;

  return if defined $high and $low == $high;

  my $index = $#splits + 2;
  my ($split, $sort) = make_frags("\$fields[$field]", $low, $high, $opt,
                                  "\$a->[$index]", "\$b->[$index]");

  push @splits, $split;
  push @sorts, $sort;
}

# remove leading and trailing whitespace from each arg
sub despace { map +(s/^\s+//, s/\s+$//, $_)[-1], @_; }

# do everything that's needed to set up a range of fields up to end of line.
sub add_cmp_rest {
  my ($field, $opt) = @_;

  my $index = $#splits + 2;
  my ($split, $sort) = make_frags('$_', undef, undef, $opt,
                                  '$aa->[$i]', '$bb->[$i]');

  my $range = $field ? "[$field..\$#fields]" : '';
  push @splits, ($split eq '$_') ? "[ \@fields$range ]"
                                 : "[ map(($split), \@fields$range) ]";
  push @sorts, despace <<"EndOfMess";
  do {
    my \$i = 0;
    my \$aa = \$a->[$index];
    my \$bb = \$b->[$index];
    my \$max = \$#\$aa > \$#\$bb ? \$\#\$aa : \$\#\$bb;
    my \$result = 0;
    \$result = $sort,
      \$i++
        until \$result || (\$i > \$max);
    \$result;
  }
EndOfMess
}

### use the constructed parts to build split_sub...

sub split_sub;

{
  my $pat = (defined $delim && "/$delim/")
         || ($have_non_b && '/(?<!\s)(?=\s)/')
         || '';
  my $preps =  join "\n  ", @preps;
  my $splits = join ",\n    ", '$_', @splits;

  my $sub = <<"EndOfSplitSub";
#line 1 "split_sub"
sub split_sub {
  local (\$^W) = 0;
  my \@fields = split $pat;
  $preps
  [ $splits ];
}
EndOfSplitSub

  print STDERR $sub if $DEBUG;

  eval "\n$sub; 1" && defined &split_sub
    or die "internal error: construction of split_sub failed:\n  $@\n";

  @preps = @splits = ();
}

### ...and sort_sub

sub sort_sub;

{
  my $sorts = join "\n           ||\n  ", @sorts;

  my $sub = <<"EndOfSortSub";
#line 1 "sort_sub"
sub sort_sub {
  local (\$^W) = 0;
  $sorts;
}
EndOfSortSub

  print STDERR $sub if $DEBUG;

  eval "\n$sub; 1" && defined(&sort_sub)
    or die "internal error: construction of sort_sub failed:\n  $@\n";
  @sorts = ();
}

### OK, we're go for launch...

my @records = ();

while (<>) { push @records, split_sub } 
@records = sort sort_sub @records;

my $last;
foreach (@records) {
  # u   Unique: suppress all but one in each set of lines having equal keys.
  if ($uniquify) {
    next if defined $last and ($a=$_, $b=$last, !sort_sub)[-1];
    $last = $_;
  }
  print $_->[0];
}

__END__

### OPTIONS CURRENTLY NOT SUPPORTED:
#     -M           Compare as months.  The first  three  non-blank
#                 characters of the field are folded to upper case
#                 and compared.  For example, in English the sort-
#                 ing  order  is  "JAN"  <  "FEB"  <  ... < "DEC".
#                 Invalid fields compare low to "JAN".   The   - M
#                 option implies the -b option (see below).
#     -c           Check that the input-file is  sorted  according
#                 to the ordering rules; give no output unless the
#                 file is out of sort.
#     -m           Merge only, the input-files are already sorted.
#     -ooutput     The argument given is the name  of  an  output-
#                 file  to  use  instead  of  the standard output.
#                 This file may be the same as one of the  inputs.
#                 There may be optional blanks between -o and out-
#                 put.
#     -T directory
#                 The directory argument is the name of  a  direc-
#                 tory in which to place temporary files.
#     -ykmem       The amount of main memory used by  sort  has  a
#                 large  impact  on  its  performance.   Sorting a
#                 small file in a large  amount  of  memory  is  a
#                 waste.   If  this option is omitted, sort begins
#                 using a system default memory size, and  contin-
#                 ues to use more space as needed.  If this option
#                 is presented with a value kmem, sort will  start
#                 using that number of kilobytes of memory, unless
#                 the  administrative  minimum   or   maximum   is
#                 violated,   in   which  case  the  corresponding
#                 extremum will be used.  Thus, -y0 is  guaranteed
#                 to start with minimum memory.  By convention, -y
#                 (with no argument) starts with maximum memory.
#     -H      Use a merge sort instead of a radix sort.  This option should be
#             used for files larger than 60Mb.
#     -R char
#             char is used as the record separator character.  This should be
#             used with discretion; -R _alphanumeric_ usually produces undesir-
#             able results.  The default line separator is newline.

=head1 NAME

sort - sort or sequence check text files

=head1 SYNOPSIS

B<sort> [B<-bdfinruD>] [B<-t> I<str>|B<-:> I<regexp>]
[I<+pos1> [I<-pos2>]] [B<-k> I<pos1>[I<,pos2>]]
[I<file> ...]

=head1 DESCRIPTION

The C<sort> program sorts the lines of one or more text files.
Comparisons are based on one or more sort keys extracted from each
line of input.  If no sort keys are explicitly specified, the entire
lines are used.  By default, the comparison is made lexicographically,
using the ordering specified by the current locale (if any).

=head2 Options

The following global options control the operation of C<sort>:

=over 4

=item C<-u>

Output only a single line for each set of lines having equal keys.
("unique" output)

=item C<-t> I<STRING>

Set the field separator to I<STRING>.  The specified field separator
is not included in the fields themselves.

The space between the B<-t> specifier and I<STRING> is optional if and
only if I<STRING> consists of a single character.

=item C<-:> I<REGEXP>

Set the field separator to I<REGEXP>, which should be a Perl regular
expression.  Occurrences of / (forward slash) in I<REGEXP> must be
quoted.  The string matched by I<REGEXP> is normally not included in
the fields themselves, but:

=over 4

=item *

If I<REGEXP> contains parenthesized subexpressions, the data matched
by those subexpressions will be treated as additional fields.  (See
L<the I<EXAMPLES> section|"EXAMPLES">.)

=item *

If I<REGEXP> uses lookbehind or lookahead (see L<perlre>), the matched
data is left as a part of the field preceding or following the match,
respectively.

=back

=item C<-D>

Enables debugging output.
The behavior of this option is subject to change.

=back

The following options override the default ordering rules, and may
also be attached to specific keys (see B<+pos1...> and B<-k>).
When they appear independent of key field specifications, the
requested field ordering rules are applied globally to all sort keys.
When attached to a specific key, the ordering options override all
global ordering options for that key.

=over 4

=item C<-b>

Ignore leading whitespace when determining the start and the end of
each input field.

=item C<-d>

Ignore everything except letters, digits and whitespace characters.
("dictionary" order)

=item C<-f>

Fold upper case letters to lower case.

=item C<-i>

Ignore non-printable characters.  (Requires the POSIX module to be
present in the Perl installation.)

=item C<-n>

Compare fields numerically.
(An initial numeric string, consisting of optional blanks, optional
minus sign, and zero or more digits with optional decimal point, is
sorted by arithmetic value.)

In some versions of C<sort>, B<-n> implies B<-b> (which matters if you
use character position offsets).  With this version, if you want
B<-b>, use B<-b>.

=item C<-r>

Reverse the sense of comparisons (and therefore the order of sorting).

=back

Finally, there are two, mutually confusing, ways of specifying sort keys:

=over 4

=item I<+POS1> [I<-POS2>]

Specifies the starting position, I<POS1>, and optionally the ending
position, I<POS2>, of a sort key.  I<POS2> denotes the first position
B<not> to be included in the sort key.  A missing I<POS2> argument
indicates that the key should include all fields until the end of the
line.

Each of I<POS1> and I<POS2> is of the form I<M>[.I<N>], followed by
zero or more of the option letters B<b>, B<d>, B<f>, B<i>, B<n> and
B<r>.  I<M> is a non-negative integer specifying the field.  If
present, I<N> is a non-negative integer specifying the character
offset into the I<M>th field.  Both I<M> and I<N> are B<counted from
0>; thus, C<1.2> specifies the third character of the second field.
If .I<N> is omitted, the position refers to the start of the field, so
C<2> is equivalent to C<2.0>.

The option letters, if present, specify options to be used for the
current sort key; if no letters are specified, the global sort options
are used.

The I<-POS2> argument must immediately follow the I<+POS1> argument.
Things like C<sort +1 -n -2> will produce an error.

=item C<-k> I<POS1>[I<,POS2>]

Specifies the starting position, I<POS1>, and optionally the ending
position, I<POS2>, of a sort key.  I<POS2> denotes the B<last>
position to be included in the sort key.  A missing I<POS2> argument
indicates that the key should include all fields until the end of the
line.

Each of I<POS1> and I<POS2> is of the form I<M>[.I<N>], followed by
zero or more of the option letters B<b>, B<d>, B<f>, B<i>, B<n> and
B<r>.  I<M> is a non-negative integer specifying the field.  If
present, I<N> is a non-negative integer specifying the character
offset into the I<M>th field.  Both I<M> and I<N> are B<counted from
1>; thus, C<1.2> specifies the second character of the first field.
If the character offset of I<POS1> is omitted, the position refers to
the start of the field, so C<-k 2,...> is equivalent to C<-k 2.1,...> .
If the character offset of I<POS2> is omitted, the position refers to
the B<end> of the field.

As a special case, if the character offset of I<POS2> is zero, it is
taken to refer to the B<end> of the specified field, just as if it was
omitted.  Thus, C<-k ...,2> is equivalent to C<-k ...,2.0> .

The option letters, if present, specify options to be used for the
current sort key; if no letters are specified, the global sort options
are used.

=back

=head1 EXAMPLES

        sort +1 -2
        sort -k 2,2
Either example sorts lexicographically by the second field of each line.

        sort +1 -2 +3 -5
        sort -k 2,2 -k 4,5
        sort +1 -2 -k 4,5
Sorts lexicographically by the second, fourth and fifth field of each
line.  (More verbosely, to compare two lines, we first compare their
second field.  If the two second fields are lexicographically equal,
we compare the fourth field.  If the fourth fields are equal, compare
the fifth field.  If the fifth fields are also equal, the lines are
considered equal.)

        sort -n +2 +0b -1
        sort -n -k 3 -k 1b,1
Sorts numerically by the fields of each line starting from the third
(ie, 3rd, 4th, 5th, ...).  If two lines compare as equal, compare the
first field lexicographically, ignoring any leading whitespace.

        sort -n +2.1 -2.4
        sort -n -k 3.2,3.4
Numerically compares the second through fourth characters of the third
field.

        sort.pl -t: +2n /etc/passwd
Splits the lines of the file C</etc/passwd> into colon-separated
fields, and sorts numerically on fields starting from the third field.

        sort -: '(\d+)' +3n -4 +2 -3 +1n -2
Separates the input into fields consisting alternately of either all
non-digits or all digits.  (The regular expression instructs C<sort>
to use fields separated by fields of digits.  Therefore, the first
field will be non-digits, but may be empty.)  Sort numerically by
the fourth field (second numeric field), lexicographically by the
third field (second non-numeric field), and numerically by the second
field (first numeric field).

=cut

        sort '-:(?x:  =[ :-> ]=)'
Any occurrence of `=:=', `=;=', `=<=', `===' or `=>=' is considered a
field delimiter.  (Unless your machine uses a non-ASCII character
set.)  Also, the emoticon symbol meaning "the author is better at
coming up with perverse examples than actually writing"...

=head1 ENVIRONMENT

These environment variables affect the execution of C<sort>:

=over 4

=item LC_COLLATE

Determine the locale for ordering rules.

=item LC_CTYPE

Determine the locale for the interpretation of sequences of bytes of
text data as characters (for example, single- versus multi-byte
characters in arguments and input files) and the behaviour of
character classification for the B<-b>, B<-d>, B<-f>, B<-i> and B<-n>
options.

=back

See L<locale> for more information about localization and Perl.

=head1 BUGS

No bugs in C<sort> are currently known.

=head1 AUTHOR

Albert Dvornik, <bert@mit.edu>.

=head1 COPYRIGHT and LICENSE

This program is copyright (c) Albert Dvornik 1999.

This program is free and open software. You may use, modify,
distribute, and sell this program (and any modified variants) in any
way you wish, provided you do not restrict others from doing the same.

