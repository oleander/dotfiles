##	Makefile for the JR preprocessors:  ccr2jr m2jr csp2jr

# these Perl scripts share some common code
# (scanner and a few utility error and low-level code generation.)
# so, this Makefile just generates the real scripts.
# (note that they share some more fairly similar code
# but that is not as easy to factor out, so I didn't bother.)

SHELL = /bin/sh

# for each X, create
#     ../bin/X, which is used in Linux
#     ../bin/X.bat, which is used in Windows

# 2003-12-05: see note in ../cmds/Makefile
#     ../bin/X.pl, which is used in Windows

all:	ccr2jr m2jr csp2jr

ccr2jr:	    common.pl ccr2jr.pl
	cat common.pl ccr2jr.pl	>../bin/ccr2jr
	chmod +x ../bin/ccr2jr
##	cp ../bin/ccr2jr ../bin/ccr2jr.pl
	perl ../cmds/Genbat.pl ccr2jr '%JR_HOME%\bin\' "" > ../bin/ccr2jr.bat

csp2jr:	    common.pl csp2jr.pl
	cat common.pl csp2jr.pl >../bin/csp2jr
	chmod +x ../bin/csp2jr
##	cp ../bin/csp2jr ../bin/csp2jr.pl
	perl ../cmds/Genbat.pl csp2jr '%JR_HOME%\bin\' "" > ../bin/csp2jr.bat

m2jr:	    common.pl m2jr.pl
	cat common.pl m2jr.pl >../bin/m2jr
	chmod +x ../bin/m2jr
##	cp ../bin/m2jr ../bin/m2jr.pl
	perl ../cmds/Genbat.pl m2jr '%JR_HOME%\bin\' "" > ../bin/m2jr.bat
