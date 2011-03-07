SHELL = /bin/sh

# note: order is important b/c slice produces .jr, which is then moved to .jrs.

all: bankaccount.jrs bankaccount.jr \
     bankcustomer.jrs bankcustomer.jr

bankaccount.jrs: bankaccount.jr.master
	slice -s -e bankaccount.jr.master
	/bin/mv bankaccount.jr bankaccount.jrs

bankaccount.jr: bankaccount.jr.master
	slice -s bankaccount.jr.master

bankcustomer.jrs: bankcustomer.jr.master
	slice -s -e bankcustomer.jr.master
	/bin/mv bankcustomer.jr bankcustomer.jrs

bankcustomer.jr: bankcustomer.jr.master
	slice -s bankcustomer.jr.master

