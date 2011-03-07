@echo off
if "%JR_HOME%"=="" goto err1
goto :cont
:err1
echo Environment variable JR_HOME must be set to the absolute
echo pathname of JR's home.
exit /B 1
:cont
setlocal
rem -- need above to keep variables local to this file
rem -- and not affect environment variables.
rem -- tempting to put an endlocal after perl command below
rem -- but that doesn't work because need perl's exit status
rem -- not endlocal's exit status.
rem -- fortunately, there's an implicit endlocal at end of each batch script.
set com=%JR_HOME%\jrv\ruf
set arglst=
:rep
shift
set arglst=%arglst% %0
if not $%1$ ==$$ goto rep
set tmp=%arglst% 
set arglst=
perl "%com%" %tmp%
