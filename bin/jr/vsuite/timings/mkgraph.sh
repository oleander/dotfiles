#!/bin/sh
#
#  mkgraph file... -- make graph from SR timings
#
#  pipe output into:   grap | pic | psroff

FILES="$@"
NFILES=`echo $FILES | wc -w`

cat <<EOF
.po .25i
.ft H
.G1
frame ht 7 width 7
coord log y
ticks bot from 1 to $NFILES
ticks left from .5 to 500 by *10
ticks left from 1 to 100 by *10
ticks left from 2 to 200 by *10
label left "\\(*msec"
copy thru X
   "\$3" size -2 at \$1, \$2
   X
EOF


n=0
for i in $FILES
do
    n=`expr $n + 1`
    awk <$i '
	/^ *[0-9].*\..*\./	{ printf "'$n' "; }
	/loop control/		{ print $3, "loop"; }
	/local call/		{ print $3, "call"; }
	/i.* call, no new/	{ print $3, "icall"; }
	/i.* call, new process/	{ print $3, "pcall"; }
	/create.destroy/	{ print $3, "create"; }
	/semaphore P/		{ print $3, "P"; }
	/semaphore V/		{ print $3, "V"; }
	/semaphore pair/	{ print $3, "PV"; }
	/semaphore.*switch/	{ print $3, "sem"; }
	/asynchronous send/	{ print $3, "asy"; }
	/message.*switch/	{ print $3, "msg"; }
	/rendezvous/		{ print $3, "rdv"; }
    '
done

cat <<'EOF'
.G2
.sp .2i
.po 1i
.nf
.ps 7
.vs 8
EOF

n=0
for i in $FILES
do
    n=`expr $n + 1`
    echo $n. $i
done

exit
