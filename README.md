[BIntegration.jar]:https://www.dropbox.com/s/yljtuc8csldq553/BIntegration.jar
[here]:https://github.com/ValerioMedeiros/BIntegration/blob/master/doc/Instructions.md
[java]:http://java.com/en/download/index.jsp
[eclipse]:http://www.eclipse.org/downloads/
[WindowBuilder]:http://www.eclipse.org/windowbuilder/
[Maven]:http://maven.apache.org/eclipse-plugin.html
[Git]:http://www.eclipse.org/egit/
[BIntegration]:https://github.com/ValerioMedeiros/BIntegration

BIntegration
============




Installation procedures for users
---------------------

* Requires: AtelierB `4.1`, ProB `1.3.6` and Java `1.7`
* BIntegration is compatible with Mac Os and Linux.

Steps:

1. Donwload this file [BIntegration.jar].

2. Move the file `BIntegration.jar` to $AtelierBInstallationDirectory/AB/extensions (Mac Os) or $AtelierBInstallationDirectory/extensions (Linux).

3. In terminal, type:

    `java -jar BIntegration.jar --install`
    
4. Past the file path of binary probcli and press enter.


### How B Integration works

B Integration is a tool to systematize the verification of B expressions integrated with AtelierB using the different ways with ProB.
Basically, the B integration take a B proof obligation in  B syntax from AtelierB and submit to ProB evaluate. When the proof obligation is ''true'', it is admitted as a B rule only in its specific module, the rule is precompiled and applied in proof obligation.


### Evaluating one proof obligation with interactive prover of AtelierB:

1. Use the shortcut (`Command+D` or `CRTL+D`) to call the B Integration in AtelierB`s interactive prover with a current proof obligation.

2. Load the rule created, type in interactive prover terminal `pc` to precompile the rule created.

3. Apply the rule selecting the new rule in theory list and clicking in `mp(Tac(..))` 

* Parameters are explained in [here].


### Evaluating proof obligations from a module:

1. Use the shortcut (`Command+D` or `CRTL+D`) to call the B Integration with a current module selected.

2. Define the parameters to evaluate the proof obligations and click on button "Eval".

3. Wait and analyse the results in text area.






Procedures for developers 
---------------------

* Requires: [Java] `1.7`, [Eclipse] Classic 4.2.2 and some plugins ([WindowBuilder] and [Maven])
* BIntegration is compatible with Mac Os and Linux.

Steps to use the IDE Eclipe:

1. Download the [Eclipse] and after install your plugins ( [Git], [WindowBuilder] and [Maven]) in Eclipse.

2. Configure the Eclipse:
 * Click `Help` > `Install New Software`.
 * In field `Work with` select `All Avaliable Site`.
 * Type below the name of component software to search.
 * Follow the remaining installation procedures and reapet these steps for each plugin (Git and Maven WindowBuilder) with the following software components:
    - Eclipse EGit 2.2;  Eclipse EGit Eclipse SDK 4.2; EGit Import Plug-in Support 2.2;
    - m2e - Maven Integration for Eclipse 1.3.
    - WindowBuilder Core 1.5; WindowBuilder Core Documentation 1.5; Core WindowBuilder 1.5 UI; WindowBuilder GroupLayout Support 1.5.
    
3. Configure the repository git in Eclipse:
 * Click  `Window` > `Open Perspective` > `Open` and select `Git Repository Exploring`.
 * Click `Clone a Git Repository` then in field URI past `https://github.com/ValerioMedeiros/BIntegration.git` using HTTPS or `git@github.com:ValerioMedeiros/BIntegration.git` using SSH.
 * Follow the remaining procedures to clone a local git repository.

4. Import the project as a existing maven project.
 * Click `File` > `Import` then select `Maven` after `Existing Maven Project`.
 * Click `Next` and in the field `Root Directory` past your git repository path, for example:`/home/username/git/BIntegration`.
 * Follow the remaining procedures to create the maven project.



Steps to use to run on Eclipse and create the file `BIntegration.jar`:

1. In Eclipse, run the BIntegration selecting the class `Main.java` in package br.ufrn.forall.b2asm.bintegration.core and clicking in menu `Run` > `Run as` > `Java Application`.

2. Select the BIntegration project, click `File` > `Export`, select `Runnable JAR file` and click `Next` follow the remaining procedures to create runnable jar file.

5. Now enjoy it!


