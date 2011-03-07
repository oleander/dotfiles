#  Makefile for JR operation benchmarks
#
#  This directory holds the tests used to obtain the timing results
#  of the style reported in Appendix E of the SR book.
#  (For SR,  best results came from a uniprocessor version
#  of SR built with "CFLAGS=-O -DNDEBUG"; for JR, who knows...)
#
#  To calculate timings, type "make JR=path" giving the path to the version
#  of jrc to use.  Results appear in report.out.  
#
#  If a machine is too fast to get good timings as set up, increase NTIMES.
#
#  The Script files in the subdirectories are for use by jrv.

#  The .sh files are protected as "not executable" to keep them from
#  being removed by cleanup scripts.


SHELL=/bin/sh
JR=jrc
## SR version is 10000 default; JR java.lang.OutOfMemoryError on that.
## NTIMES=10000
## NTIMES=1000
## 2003-09-14 got some java.lang.OutOfMemoryError on 1000, so drop to
NTIMES=200
NLOOPS=5


#  rerun everything from scratch

timings:  build run report


#  compute timing results and report on report.out.

report report.out: run.out
	sh report.sh >report.out

run run.out: build.out
	sh run.sh $(NTIMES) $(NLOOPS)

build build.out:
	sh build.sh $(JR)


#  clean up files

clean:
	rm -rf *.out */*.out */jrGen
