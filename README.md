BIntegration
============

*How B Integration works
B Integration is a tool to systematize the verification of B expressions integrated with AtelierB using the different ways with ProB.
Basically, the B integration take a B proof obligation in  B syntax from AtelierB and submit to ProB evaluate. When the proof obligation is ''true'', it is admitted as a B rule only in its specific module, the rule is precompiled and applied  in proof obligation.

*Steps of installation 
#Move the file [[https://www.dropbox.com/s/fvdozx39xaa3h92/BIntegration.jar|BIntegration.jar]] to $AtelierBDirectory/AB/extensions
#In terminal, type: java -jar BIntegration.jar
#Past the file path of binary probcli


*To execute :
##Use the shortcut (Command+P) to call the B Integration in AtelierB`s interactive prover with a current proof obligation.



The source code will be briefly available.