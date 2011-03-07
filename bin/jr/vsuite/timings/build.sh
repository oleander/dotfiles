#!/bin/sh
#
#  build.sh -- build benchmark programs for timing

# once it was ${1-jrc}, but jrrun is hardcoded elsewhere, so ...
JR=jrc

rm -f build.out

# make sure JR exists
$JR -version 2>&1 || exit 1

cat List | while read DIR SCALE DESCR
do
    case $DIR in
	"#"*|"")	continue;;
    esac
## JR has no optimization to turn on (at least not yet ;-)

## 2006-08-09 JR version 1 needed ``; cd jrGen; jr_rmic'' in each of below
    echo " (cd $DIR; $JR *.jr; javac jrGen/*.java)"
           (cd $DIR; $JR *.jr; javac jrGen/*.java)
done

# these (obviously) depend on format of output from tools
$JR -version >build.out 2>&1
jrrun -version >>build.out 2>&1

(javac -version  2>&1 | head -n 1)  >>build.out
(java  -version  2>&1 | head -n 1)  >>build.out

exit 0
