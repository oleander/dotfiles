SHELL = /bin/sh

# note: order is important b/c slice produces .jr, which is then moved to .jrs.

all: basic.jrs basic.jr

basic.jrs: basic.jr.master
	slice -s -e basic.jr.master
	/bin/mv basic.jr basic.jrs

basic.jr: basic.jr.master
	slice -s basic.jr.master

