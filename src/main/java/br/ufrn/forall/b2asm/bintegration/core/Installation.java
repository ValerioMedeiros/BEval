package br.ufrn.forall.b2asm.bintegration.core;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.net.URL;
import java.util.Scanner;

public class Installation {

	public static String filenameJar = "BIntegration.jar";

	protected static String pathProbCli;

	protected static String currentPathExtensions;

	protected static String configTxt =
			"#This file contains some configurations about the calling of ProB Logic Calculator\n"+
			"#Step 1 - copy the files BIntegrationGoal.etool BIntegration.jar, BIntegration.sh, b2asm.png to $AtelierB/AB/extensions\n"+
			"#Step 2 - you must define below the path of probcli and parameters\n"+
			"#Step 3 - you must define the full path of BIntegration.jar in BIntegrationGoal.etool\n"+ 
			"/Users/valerio/Myprograms/ProB/probcli\n"+
			"-p BOOL_AS_PREDICATE TRUE\n"+
			"-p CLPFD TRUE\n"+
			"-p MAXINT 65536\n"+
			"-p MININT -65536\n"+
			"-p TIME_OUT 50000\n";

	protected static String bIntegrationGoalEtool = "<externalTool category=\"goal\"   name=\"ProB Logic Calculator\" icon=\"b2asm.png\" label=\"&amp;Call ProB Evaluator \"  shortcut=\"Ctrl+P\" >\n"
			+ "<toolParameter name=\"editor\" type=\"tool\" configure=\"yes\"\n"
			+ "default=\"/Applications/AtelierB.app/AB/extensions/BIntegration.sh\"/>\n"
			+ "<command>${editor}</command>\n"
			+ "<param>${poName}</param>\n"
			+ "<param>${componentName}</param>\n"
			+ "<param>${componentPath}</param>\n"
			+ "<param> ${componentExt}</param>\n"
			+ "<param>${poGoal}</param>\n"
			+ "<param> #@# ${poHypothesis}</param>" + "</externalTool>";

	protected static String bIntegrationProofEtool = "<externalTool category=\"po\"   name=\"ProBPO\" label=\"&amp;Call prover (B2ASM)\">\n"
			+ "<toolParameter name=\"editor\" type=\"tool\" configure=\"yes\"\n"
			+ "default=\"/Applications/AtelierB.app/AB/extensions/BIntegration.sh\"/>\n"
			+ "<command>${editor}</command>\n"
			+ "<param>${poName}</param>\n"
			+ "<param>${componentName}</param>\n"
			+ "<param>${componentPath}</param>\n"
			+ "<param> ${componentExt}</param>\n"
			+ "<param>${poGoal}</param>\n"
			+ "<param> #@# ${poHypothesis}</param>\n"
			+ "</externalTool>\n";

	protected static String bIntegrationSh = "#!/bin/bash\n"
			+ "export TRAILSTKSIZE=1M\n"
			+ "java -jar /Applications/AtelierB.app/AB/extensions/BIntegration.jar $@\n"
			+ "res=$?\n" + "echo \"The numbers of arguments is  $#\"\n"
			+ "#echo \"The parameters are: $@\" #it is useful in debug mode\n"
			+ "#echo $res\n" + "exit $res\n";

	public static void main(String[] args) {

		 currentPathExtensions = Installation.class.getProtectionDomain()
				.getCodeSource().getLocation().getPath()
				.replaceAll(Installation.filenameJar, "");

		Control.writeFile(currentPathExtensions + "BIntegration.sh",
				Installation.bIntegrationSh.replaceFirst("/Applications/AtelierB.app/AB/extensions/BIntegration.jar", currentPathExtensions+"BIntegration.jar"));
		
		Control.writeFile(currentPathExtensions + "BIntegrationProof.etool",
				Installation.bIntegrationProofEtool.replaceFirst("/Applications/AtelierB.app/AB/extensions/BIntegration.sh", currentPathExtensions+"BIntegration.sh"));
		
		Control.writeFile(currentPathExtensions + "BIntegrationGoal.etool",
				Installation.bIntegrationGoalEtool.replaceFirst("/Applications/AtelierB.app/AB/extensions/BIntegration.sh", currentPathExtensions+"BIntegration.sh"));
		
		System.out.println("Type the path of binary file probcli, for example /Users/guest/Myprograms/ProB/probcli:");
		
		Scanner keyboard = new Scanner(System.in);
		
		pathProbCli = keyboard.nextLine();
		
		//TODO: Remove the config file and use only informations stored in Preferences
		
		GeneralPreferences.updatePathProbcli(pathProbCli);
		
		Control.writeFile(currentPathExtensions + "Config.txt",
				Installation.configTxt.replaceFirst("/Users/valerio/Myprograms/ProB/probcli", pathProbCli));
		
		try {
			Runtime.getRuntime().exec("chmod +x "+currentPathExtensions + "BIntegration.sh");
		} catch (IOException e) {
			System.err.println("Error when trying to add the execution permission in BIntegration.sh");
			e.printStackTrace();
		}
		
		System.out.println("The configuration files were updated!");
	}

}
