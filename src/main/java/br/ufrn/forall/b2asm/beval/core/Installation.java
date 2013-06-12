package br.ufrn.forall.b2asm.beval.core;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.net.URL;
import java.util.Scanner;

import javax.swing.JOptionPane;

public class Installation {

	public final static String softwareName = "BEval";
	public static String filenameJar = "BEval.jar";

	protected static String pathProbCli;
	
	protected static String defaultParameters = new String("-p BOOL_AS_PREDICATE TRUE \n"+
			  "-p CLPFD TRUE \n"+
			  "-p MAXINT 65536 \n"+
			  "-p MININT -65536 \n"+
			  "-p TIME_OUT 50000 ");

	protected static String currentPathExtensions;

	/*protected static String configTxt =
			"#This file contains some configurations about the calling of ProB Logic Calculator\n"+
			"#Step 1 - copy the files BEvalGoal.etool BEval.jar, BEval.sh, b2asm.png to $AtelierB/AB/extensions\n"+
			"#Step 2 - you must define below the path of probcli and parameters\n"+
			"#Step 3 - you must define the full path of BEval.jar in BEvalGoal.etool\n"+ 
			"!pathProbCli!\n"+ //Its replaced using Input dialog getting the path
			"-p BOOL_AS_PREDICATE TRUE\n"+
			"-p CLPFD TRUE\n"+
			"-p MAXINT 65536\n"+
			"-p MININT -65536\n"+
			"-p TIME_OUT 50000\n";*/

	protected static String bEvalGoalEtool = "<externalTool category=\"goal\"   name=\"ProB Logic Calculator\" icon=\"b2asm.png\" label=\"&amp;Call B-Eval (B2ASM) \"  shortcut=\"Ctrl+D\" >\n"
			+ "<toolParameter name=\"editor\" type=\"tool\" configure=\"yes\"\n"
			+ "default=\"!currentPathExtensions!BEval.sh\"/>\n" //Its replaced using the field currentPathExtensions 
			+ "<command>${editor}</command>\n"
			+ "<param>${poName}</param>\n"
			+ "<param>${componentName}</param>\n"
			+ "<param>${componentPath}</param>\n"
			+ "<param> ${componentExt}</param>\n"
			+ "<param>${poGoal}</param>\n"
			+ "<param> #@# ${poHypothesis}</param>" + "</externalTool>";

	protected static final String IdModule = "#@Module#";
	protected static String bEvalProofEtool = "<externalTool category=\"component\"   name=\"B-Eval\" label=\"&amp;Call B-Eval (B2ASM)\"   shortcut=\"Ctrl+D\"  >\n"
			+ "<toolParameter name=\"editor\" type=\"tool\" configure=\"yes\"\n"
			+ "default=\"!currentPathExtensions!BEval.sh\"/>\n" //It is replaced using the field currentPathExtensions
			+ "<command>${editor}</command>\n"
			+ "<param>${poName}</param>\n"
			+ "<param>${componentName}</param>\n"
			+ "<param>${componentPath}</param>\n"
			+ "<param> ${componentExt}</param>\n"
			+ "<param>${poGoal}</param>\n"
			+ "<param> "+IdModule+"  Bacana${poHypothesis}</param>\n"
			+ "</externalTool>\n";

	protected static String bEvalSh = "#!/bin/bash\n"
			+ "export TRAILSTKSIZE=1M\n"
			+ "java -Xms1064m -Xmx1512m  -jar !currentPathExtensions!BEval.jar $@\n" //TODO: Update for the current path
			+ "res=$?\n" + "echo \"The numbers of arguments is  $#\"\n"
			+ "#echo \"The parameters are: $@\" #it is useful in debug mode\n"
			+ "#echo $res\n" + "exit $res\n";

	public static void main(String[] args) {

		 currentPathExtensions = Installation.class.getProtectionDomain()
				.getCodeSource().getLocation().getPath()
				.replaceAll(Installation.filenameJar, "");

		Control.writeFile(currentPathExtensions + "BEval.sh",
				Installation.bEvalSh.replaceFirst("!currentPathExtensions!BEval.jar", currentPathExtensions+"BEval.jar"));
		
		Control.writeFile(currentPathExtensions + "BEvalProof.etool",
				Installation.bEvalProofEtool.replaceFirst("!currentPathExtensions!BEval.sh", currentPathExtensions+"BEval.sh"));
		
		Control.writeFile(currentPathExtensions + "BEvalGoal.etool",
				Installation.bEvalGoalEtool.replaceFirst("!currentPathExtensions!BEval.sh", currentPathExtensions+"BEval.sh"));
		
		//System.out.println("Type the path of binary file probcli, for example /Users/guest/Myprograms/ProB/probcli:");
		
		//Scanner keyboard = new Scanner(System.in);
		
		//pathProbCli = keyboard.nextLine();
		
		pathProbCli = new JOptionPane().showInputDialog("Type the path of binary file probcli, for example /Users/guest/Myprograms/ProB/probcli:");
		
		
		
		GeneralPreferences.updatePathProbcli(pathProbCli);
		
		//Control.writeFile(currentPathExtensions + "Config.txt",
		//		Installation.configTxt.replaceFirst("!pathProbCli!", pathProbCli));
		
		try {
			Runtime.getRuntime().exec("chmod +x "+currentPathExtensions + "BEval.sh");
		} catch (IOException e) {
			System.err.println("Error when trying to add the execution permission in BEval.sh");
			e.printStackTrace();
		}
		
		System.out.println("The configuration files were updated!");
	}

}
