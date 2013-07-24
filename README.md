[BEval.jar]:https://www.dropbox.com/s/m9x8ove6dc9lf1v/BEval.jar
[here]:https://github.com/ValerioMedeiros/BEval/blob/master/doc/Instructions.md
[license]:https://github.com/ValerioMedeiros/BEval/blob/master/doc/License.md
[java]:http://java.com/en/download/index.jsp
[eclipse]:http://www.eclipse.org/downloads/
[WindowBuilder]:http://www.eclipse.org/windowbuilder/
[Maven]:http://maven.apache.org/eclipse-plugin.html
[Git]:http://www.eclipse.org/egit/
[BEval]:https://github.com/ValerioMedeiros/BEval
[ProB]:http://www.stups.uni-duesseldorf.de/ProB/index.php5/Download
[AtelierB]:http://www.atelierb.eu/en/download-atelier-b/
[Java]:http://java.com/en/download/
[GUI component BEval]:https://www.dropbox.com/s/5sq4k2ve06iw8px/F0_F1_F2_F3_and_BEvalComponent.mov

BEval  
============

Installation procedures for users
---------------------

* BEval requires: [AtelierB] `4.1`, [ProB] `1.3.6` and [Java] `1.7`.
* BEval is compatible with OS X and Linux; it has this [license].

Follow these steps:

1. Find where AtelierB is installed on your system. Let $ABDIR denote this location (usually /Application/AtelierB.app/ on OS X; /opt/AtelierB on Linux). 
2. Find where probcli (ProB Command Line Interface) is installed on your system. Let $PROBDIR denote this location.
3. If you are using Linux, EXTDIR=$ABDIR/AB/extensions. If you are using OS X, EXTDIR=$ABDIR/extensions.
4. Download file [BEval.jar] and install it in $EXTDIR.
5. Open a terminal, and issue the following command:
    `cd $EXTDIR; java -jar BEval.jar --install`
    where $EXTDIR is as defined above.
6. Paste the value of `$PROBDIR/probcli` and press enter.

### How BEval works

BEval is a tool that offers to the user the possibility to use ProB within AtelierB to evaluate proof obligations. BEval
may be used in the interactive prover (we plan to integrate it to the components window in the future).
When the proof obligation is ''true'', a rule is added to the pmm file corresponding to the B component under 
verification. The user may then use the new rule to discharge the proof obligation within AtelierB. So, even when ProB
finds that a goal is true, the proof obligation is *not* automatically discharged in AtelierB. A video demonstration about
the [GUI component BEval] is available. The actions that the user must take are described below.

### Using BEval in the interactive prover


In the interactive prover window:

1. Use the shortcut (`Command+D` or `CRTL+D`) to call BEval on the current proof obligation.

2. The following pop-up window appears, with several elements. <img src="https://raw.github.com/ValerioMedeiros/BEval/master/doc/figures/ReducedScreen.png" width="450" align="center">
    * Parameters: located on the top-left of the window, it is an editable text where the user has access to the options 
used to call ProB.
    * Main options: located on the top-middle of the window, three basic options are checkable: Kodkod indicates that
ProB may use the tool of the same name; Smt indicates that ProB to do more aggressive constraint solving; Initialise indicates that definitions
from the B component shall be loaded. 
    * Hypothesis: located on the top-right of the window, it presents hypothesis that the user may want to add to the goal.
Addition of such hypothesis shall be performed with copy-and-paste operations.
    * Goal to evaluate: is an editable text that contains the expression that will be sent to ProB.
    * Add rule: If that option is checked, whenever the goal evaluates to ''true'', a rule is generated.
    * W.D.P.O.: If that option is checked, then, whenever the goal evaluates to ''true'', the generated rule will be 
added to the `wd_pmm` file, otherwise it is added to the `pmm` file.
    * Eval: This button provokes the call to ProB on the current goal with the given list of parameters.

3. If the goal has been evaluated to ''true'' and a rule has been created, the user may use this rule to discharge the 
proof obligation in AtelierB. In the interactive prover, the command `pc` loads and compiles the manual rules.

3. Select the created rule in the theory list and click `mp(Tac(..))`.

* Parameters are explained [here].


### Using BEval in the component window

1. Use the shortcut (`Command+D` or `CRTL+D`) to call BEval on the current component.

2. The following pop-up window appears, presenting a set of proof obligations.  <img src="https://raw.github.com/ValerioMedeiros/BEval/master/doc/figures/ScreenModular.png" width="450" align="center">

3. Submit the selected elements clicking in the button `Eval`. By default, only the unproved proof obligations are selected to be submitted.

4. Apply the rules created in `pmm` file using the shortcut (`Command+U` or `CRTL+U`) to call the USER_PASS.

Procedures for developers 
---------------------

* Requires: [Java] `1.7`, [Eclipse] Classic 4.2.2 and some plugins ([Git](optional), [WindowBuilder] and [Maven])
* BEval is compatible with OS X and Linux.

Steps to use the IDE Eclipse:

1. Download [Eclipse].

2. Install the plugins [Git], [WindowBuilder] and [Maven] in Eclipse:
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
 
 * Or alternativally, use this command in terminal: `git clone git@github.com:ValerioMedeiros/BEval.git` and add an existing local Git repository.

4. Import the project as an existing maven project.
 * Click `File` > `Import` then select `Maven` and `Existing Maven Project`.
 * Click `Next` and in the field `Root Directory` paste your git repository path, for example `/home/username/git/BEval`.
 * Follow the remaining procedures to create the maven project.



Steps to run in Eclipse and create the executable file `BEval.jar`:

1. In Eclipse, run BEval by opening directory `src/main/java`, package `br.ufrn.forall.b2asm.beval.core`, class `Main.java` and right-click and select `Run` > `Run as` > `Java Application` in the menu.

2. Select the BEval project, click `File` > `Export`; select `Runnable JAR file` and click `Next` following the remaining procedures to create a runnable jar file.

5. Now enjoy it!

