##	Makefile for the JR tools

SHELL = /bin/sh


# for each X, create
#     ../bin/X, which is used in Linux
#     ../bin/X.bat, which is used in Windows; it invokes perl on X
#
# 2003-12-05:
#     initial Windows versions used X.pl
#     and put .pl in the %PATHEXT% environment variable,
#     but the .bat files work nicely.
#     And we encountered an odd I/O redirection bug (we believe)
#     so, we dropped the .pl stuff (and so suffix arg to Genbat is always "").
#
#     note: keep .pl suffixes on sort.pl, etc. so as to avoid collisions
#     on UNIX and Windows with those standard tools.

all: dependencies jstuff perlutils

# don't bother with specifying dependencies on what we're making here.
# simply remaking everything is quick enough.

# file to which to output dependencies
deps = Deps
# files to include at top of each .pl file
top = U_Header.pl U_Protos.pl

dependencies:
	icont -u Makedeps.icn
	./Makedeps j*.pl u_*.pl > $(deps)

jstuff:	  jr  jrt jrrun jrc  \
          clean_jrGen  jrgo  jgo  jrgot jgot jrgox  jgox  \
          jrfindmain jfindmain

jr jrt jrrun jrc jrgo jgo jrgot jgot jrgox jgox jrfindmain jfindmain :
	cat $(top) `grep ^$@.pl $(deps)` > ../bin/$@
	chmod +x ../bin/$@
	perl Genbat.pl $@ '%JR_HOME%\bin\' "" > ../bin/$@.bat

clean_jrGen:
	cp clean_jrGen.pl ../bin/clean_jrGen
	chmod +x ../bin/clean_jrGen
	perl Genbat.pl clean_jrGen '%JR_HOME%\bin\' "" > ../bin/clean_jrGen.bat

perlutils:
	cp cmp.pl cmpNoCR.pl grep.pl lst.pl sort.pl tail.pl which.pl ../bin
