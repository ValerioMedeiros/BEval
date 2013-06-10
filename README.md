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

BSD License 
---------------------

Copyright (c) 2013,  Valério Medeiros, David Deharbe

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
* Neither the name of the Federal Institute of Education Science and Technology of Rio Grande do Norte and Federal University of Rio Grande do Norte nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.




Installation procedures for users
---------------------

* Requires: AtelierB `4.1`, ProB `1.3.6` and Java `1.7`
* BIntegration is compatible with Mac Os and Linux.

Steps:

1. Download this file [BIntegration.jar].

2. Move the file `BIntegration.jar` to $AtelierBInstallationDirectory/AB/extensions (Mac Os) or $AtelierBInstallationDirectory/extensions (Linux).

3. In terminal, type:

    `java -jar BIntegration.jar --install`
    
4. Paste the file path of binary probcli and press enter.


### How B Integration works

B Integration is a tool to systematize the verification of B expressions integrated with AtelierB using different parameters with ProB.
Basically, the B integration take a B proof obligation in  B syntax from AtelierB and submit to ProB evaluate. When the proof obligation is ''true'', it is admitted as a B rule only in its specific module, the rule is precompiled and applied in proof obligation.


### Evaluating one proof obligation with interactive prover of AtelierB:

1. Use the shortcut (`Command+D` or `CRTL+D`) to call the B Integration in AtelierB`s interactive prover with a current proof obligation.

2. Load the rule created, type in interactive prover terminal `pc` to precompile the rule created.

3. Apply the rule selecting the new rule in theory list and clicking in `mp(Tac(..))` 

* Parameters are explained in [here].


### Evaluating proof obligations from a module:

1. Use the shortcut (`Command+D` or `CRTL+D`) to call the B Integration with a current module selected.

2. Define the parameters to evaluate the proof obligations and click on button "Eval".

3. Wait and analyse the results in the text area.






Procedures for developers 
---------------------

* Requires: [Java] `1.7`, [Eclipse] Classic 4.2.2 and some plugins ([Git](optional), [WindowBuilder] and [Maven])
* BIntegration is compatible with Mac Os and Linux.

Steps to use the IDE Eclipse:

1. Download the [Eclipse] and after install your plugins ( [Git], [WindowBuilder] and [Maven]) in Eclipse.

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
 * Click `Clone a Git Repository` then in field URI paste `https://github.com/ValerioMedeiros/BIntegration.git` using HTTPS or `git@github.com:ValerioMedeiros/BIntegration.git` using SSH.
 * Follow the remaining procedures to clone a local git repository.

4. Import the project as an existing maven project.
 * Click `File` > `Import` then select `Maven` after `Existing Maven Project`.
 * Click `Next` and in the field `Root Directory` paste your git repository path, for example `/home/username/git/BIntegration`.
 * Follow the remaining procedures to create the maven project.



Steps to run in Eclipse and create the executable file `BIntegration.jar`:

1. In Eclipse, run the BIntegration selecting the class `Main.java` in package br.ufrn.forall.b2asm.bintegration.core and clicking in menu `Run` > `Run as` > `Java Application`.

2. Select the BIntegration project, click `File` > `Export`; select `Runnable JAR file` and click `Next` following the remaining procedures to create a runnable jar file.

5. Now enjoy it!


