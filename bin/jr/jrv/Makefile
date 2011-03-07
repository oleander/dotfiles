SHELL = /bin/sh

# for each X, create
#     ./X.bat, which is used in Windows

all:	jrv.bat  jrversion.bat  ruf.bat  vclean.bat

jrv.bat:
	perl ../cmds/Genbat.pl jrv '%JR_HOME%\jrv\' "" > ./jrv.bat

jrversion.bat:
	perl ../cmds/Genbat.pl jrversion '%JR_HOME%\jrv\' "" > ./jrversion.bat

ruf.bat:
	perl ../cmds/Genbat.pl ruf '%JR_HOME%\jrv\' "" > ./ruf.bat

vclean.bat:
	perl ../cmds/Genbat.pl vclean '%JR_HOME%\jrv\' "" > ./vclean.bat
