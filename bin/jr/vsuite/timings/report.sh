#!/bin/sh
#
#  report.sh -- produce summary of timing results

echo ""
echo ""
echo ""
echo "JR Timing Results"
echo ""
cat run.out || exit 1
cat build.out || exit 1

echo 
echo "Results are given in microseconds" 
echo 
echo "     times    mean  median  test" 

cat List | while read DIR SCALE DESCR
do
    case $DIR in
	"#"*)	continue;;
	"")	echo ""; continue;;
    esac

    sort -k 2 -n $DIR/$DIR.out |
    awk ' 
		{ ntimes += $1; nmsec += $3; n[NR] = $1; t[NR] = $3;}
	END	{ mid = int ((NR + 1) / 2);
		  median = t[mid] * 1000 / n[mid];
		  mean = nmsec * 1000 / ntimes;	
		  printf ("%10d %7.2f %7.2f  %s\n", \
		    ntimes, mean, median, "'"$DESCR"'");
		}
	' 
done
exit 0
