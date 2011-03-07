##	Makefile for the JR man pages.
#
#	Makes a .ps file of all the man pages.



SHELL = /bin/sh
## RAO changed 2000-11-12; probably system dependent (now Linux dependent?)
## ROFF = psroff -t
ROFF = groff -t

D = ../ps

MANS = 	ccr2jr.1 csp2jr.1 m2jr.1



$D/manpages.ps:	$(MANS)
	-if [ ! -d $D ]; then mkdir $D; fi
	$(ROFF) -man $(MANS) >$D/manpages.ps
