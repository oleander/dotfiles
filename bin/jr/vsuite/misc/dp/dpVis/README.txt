Intructions :
=============

-- This program will not work if you have not correctly setup JR on your machine.

	jr -explicit MainFrame { vm-ip }

This is a JR program, and the user can type the command above under the same directory as this folder to translate and execute the program for the first time running. The argument(s) vm-ip is optional.

	jrrun -explicit MainFrame { vm-ip }

User can use the command above after the first time running. 


Updates :
=========
11/14/2004 minor fixes :
-- fix the mode switching problem from manual to auto
-- fix a minor bugs of not able to be hungry from think
11/08/2004 updates:
-- fix the bugs due to the last memory improvement update
-- add an additional setting option to change the display theme
-- solve the jrRunTime exception problem at op DiningPhilSolution.destroy() when user calls any setting options before any solution starts
-- add "mouse over display" for philosopher id when mouse is pointing at each philosopher
11/07/2004 updates:
-- improvement on memory usage by fixing the servant's infinite-loop processes' memory problem
-- update the figure images ( can switch back to the old one if desired by modifying DiningEnvironmentConstant.jr, comment out the code of version 2, and uncomment the code of version 1
-- notes : still have an unknown minor memory problem - memory does not release as one solution stops
10/27/2004 minor updates:
-- update the description on time constant setting
-- change the beginning number of philosophers back to 5
10/27/2004 Updates:
-- when remote frame signals "DONE" to philosopher, it will disable all button except "exit"
-- change the beginning number of philosophers to be 22
-- close all client windows when solution destroys/stops
-- dispose the frame before exit ( make sure the resources are all released )
-- pause all philosophers at the beginning, and start everyone when everyone is ready
-- add a JLabel in DiningDesktopPane to display some message on MainFrame/ClientFrame
-- add a % counter on the process of creating and initializing philosophers
-- using the new message feature to tell the user when he/her can use "hungry" and "think"
-- "hungry" and "think" in Client Window are disabled in default, and will only be enabled iff the philosopher is at the right moment and he is being manually controlled
10/20/2004 Updates:
-- show the current setting when click on setting
-- change the default number of philosopher to be 5
-- warning for invalid inputs for those setting menu items
-- limit the time constant to be smaller than 3600
-- disable the remove vm button and server & client button when the vm host list is empty
-- fixed the "Manual to Auto" bug which the philosopher does not resume on its own
-- enchance the client "Action" menu, e.g. when the user press hungry, the hungry button will dim out

10/16/2004 Updates:
- First release with all functions open
- open for testing

Unfixed known bugs :
memory leak in all Servant classes

Acknowledgement
===============
Philosopher pictures is copied from 
(javaPhil##)	javasoft.com
(buddybean_##)	http://www.trunks.in-tw.com
and thank you Angela Chan, Ingwar Wirjawan and Professor Ron Olsson for testing the program



If you find out any problems with this program, or if you have any suggestion,
please contact William Au Yeung by email : yauyeung@ucdavis.edu
Thank you!