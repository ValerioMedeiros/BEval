[BEval.jar]:https://www.dropbox.com/s/m9x8ove6dc9lf1v/BEval.jar
[here]:https://github.com/ValerioMedeiros/BEval/blob/master/doc/Instructions.md
[java]:http://java.com/en/download/index.jsp
[eclipse]:http://www.eclipse.org/downloads/
[WindowBuilder]:http://www.eclipse.org/windowbuilder/
[Maven]:http://maven.apache.org/eclipse-plugin.html
[Git]:http://www.eclipse.org/egit/
[BEval]:https://github.com/ValerioMedeiros/BEval
[ProB]:http://www.stups.uni-duesseldorf.de/ProB/index.php5/Download
[AtelierB]:http://www.atelierb.eu/en/download-atelier-b/
[Java]:http://java.com/en/download/

BEval  <img src="https://raw.github.com/ValerioMedeiros/BEval/master/b2asm.png" width="50" align="right">
============

Installation procedures for users
---------------------

* Requires: [AtelierB] `4.1`, [ProB] `1.3.6` and [Java] `1.7`
* BEval is compatible with Mac Os and Linux.

Steps:

1. Download this file [BEval.jar].

2. Move the file `BEval.jar` to $AtelierBInstallationDirectory/AB/extensions (Mac Os) or $AtelierBInstallationDirectory/extensions (Linux). In general, $AtelierBInstallationDirectory is /Application/AtelierB.app/ (Mac Os) or /opt/AtelierB (Linux).

3. In extensions directory, type it unsing the terminal:

    `java -jar BEval.jar --install`
    
4. Paste the file path of binary probcli and press enter.


### How BEval works

BEval is a tool to systematize the verification of B expressions integrated with AtelierB using different parameters with ProB.
Basically, the BEval takes a B proof obligation in  B syntax from AtelierB and submit to ProB evaluate. When the proof obligation is ''true'', it is admitted as a B rule only in its specific module, the rule is precompiled and applied in proof obligation.


### Evaluating one proof obligation with interactive prover of AtelierB:

1. Use the shortcut (`Command+D` or `CRTL+D`) to call the BEval in AtelierB`s interactive prover with a current proof obligation.

2. Load the rule created, type in interactive prover terminal `pc` to precompile the rule created.

3. Apply the rule selecting the new rule in theory list and clicking in `mp(Tac(..))` 

* Parameters are explained in [here].


### Evaluating proof obligations from a module:

1. Use the shortcut (`Command+D` or `CRTL+D`) to call the BEval with a current module selected.

2. Define the parameters to evaluate the proof obligations and click on button "Eval".

3. Wait and analyse the results in the text area.






Procedures for developers 
---------------------

* Requires: [Java] `1.7`, [Eclipse] Classic 4.2.2 and some plugins ([Git](optional), [WindowBuilder] and [Maven])
* BEval is compatible with Mac Os and Linux.

Steps to use the IDE Eclipse:

1. Download the [Eclipse] and then install your plugins ( [Git], [WindowBuilder] and [Maven]) in Eclipse.

2. Configure the Eclipse:
 * Click `Help` > `Install New Software`.
 * In field `Work with` select `All Avalable Site`.
 * Type below the name of component software to search.
 * Follow the remaining installation procedures and repeat these steps for each plugin (Git and Maven WindowBuilder) with the following software components:
    - Eclipse EGit 2.2;  Eclipse EGit Eclipse SDK 4.2; EGit Import Plug-in Support 2.2;
    - m2e - Maven Integration for Eclipse 1.3.
    - WindowBuilder Core 1.5; WindowBuilder Core Documentation 1.5; Core WindowBuilder 1.5 UI; WindowBuilder GroupLayout Support 1.5.
    
3. Configure the repository git in Eclipse:
 * Click  `Window` > `Open Perspective` > `Open` and select `Git Repository Exploring`.
 * Click `Clone a Git Repository` then in field URI paste `https://github.com/ValerioMedeiros/BEval.git` using HTTPS or `git@github.com:ValerioMedeiros/BEval.git` using SSH.
 * Follow the remaining procedures to clone a local git repository.

4. Import the project as an existing maven project.
 * Click `File` > `Import` then select `Maven` and `Existing Maven Project`.
 * Click `Next` and in the field `Root Directory` paste your git repository path, for example `/home/username/git/BEval`.
 * Follow the remaining procedures to create the maven project.



Steps to run in Eclipse and create the executable file `BEval.jar`:

1. In Eclipse, run the BEval selecting the class `Main.java` in package br.ufrn.forall.b2asm.beval.core and clicking in menu `Run` > `Run as` > `Java Application`.

2. Select the BEval project, click `File` > `Export`; select `Runnable JAR file` and click `Next` following the remaining procedures to create a runnable jar file.

5. Now enjoy it!

