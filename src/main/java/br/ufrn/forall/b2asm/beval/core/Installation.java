package br.ufrn.forall.b2asm.beval.core;

import java.awt.event.WindowEvent;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.prefs.Preferences;

import javax.swing.JFrame;
import javax.swing.JOptionPane;




import javax.swing.JProgressBar;
import javax.swing.SwingUtilities;
import javax.swing.WindowConstants;

import br.ufrn.forall.b2asm.utils.Unzip;

public class Installation {

	public final static String softwareName = "BEval";
	public static String filenameJar = "BEval.jar";

	protected static String pathProbCli;
	
	protected static String defaultParameters = new String("-p BOOL_AS_PREDICATE TRUE \n"+
			  "-p CLPFD TRUE \n"+  // restrict to range of integers. 
			  "-p MAXINT 2147483647 \n"+
			  "-p MININT -2147483647 \n"+
			  "-p SYMBOLIC TRUE "+ // expands only the concepts needed"
			  "-p TIME_OUT 12000 ");

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
			"-p TIME_OUT 7000\n";*/

	protected static String bEvalGoalEtool = "<externalTool category=\"goal\"   name=\"B-Eval\" icon=\"b2asm.png\" label=\"&amp;Call BEval  \"  shortcut=\"Ctrl+D\" >\n"
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
	protected static String bEvalProofEtool = "<externalTool category=\"component\"   name=\"B-Eval\" label=\"&amp;Call BEval \"   shortcut=\"Ctrl+D\"  >\n"
			+ "<toolParameter name=\"editor\" type=\"tool\" configure=\"yes\"\n"
			+ "default=\"!currentPathExtensions!BEval.sh\"/>\n" //It is replaced using the field currentPathExtensions
			+ "<command>${editor}</command>\n"
			+ "<param>${poName}</param>\n"
			+ "<param>${componentName}</param>\n"
			+ "<param>${componentPath}</param>\n"
			+ "<param> ${componentExt}</param>\n"
			+ "<param>${poGoal}</param>\n"
			+ "<param> "+IdModule+"  ${poHypothesis}</param>\n"
			+ "</externalTool>\n";
	protected static String B2llvm_tool = "<externalTool category=\"component\"   name=\"b2llvm\" label=\"&amp;B2llvm \"   shortcut=\"Ctrl+G\"  >\n"
			+ "<toolParameter name=\"editor\" type=\"tool\" configure=\"yes\"\n"
			+ "default=\"!currentPathExtensions!BEval.sh\"/>\n" //It is replaced using the field currentPathExtensions
			+ "<command>${editor}</command>\n"
			+ "<param>-a</param>\n"
			+ "<param>-v</param>\n"
			+ "<param>-m</param>\n"
			+ "<param>comp</param>\n"
			+ "<param>${componentName}</param>\n"
			+ "<param>${componentName}.llvm</param>\n"
			+ "<param>${projectBdp}</param>\n"
			+ "<param>project.xml</param>\n"
			+ "<param>${projectTrad}</param>\n"
			+ "</externalTool>\n";
	
	protected static String bEvalSh = "#!/bin/bash\n"
			+ "export TRAILSTKSIZE=1M\n"
			+ "java -Xms1064m -Xmx1512m  -jar !currentPathExtensions!BEval.jar $@\n" 
			+ "res=$?\n" + "echo \"The numbers of arguments is  $#\"\n"
			+ "#echo \"The parameters are: $@\" #it is useful in debug mode\n"
			+ "#echo $res\n" + "exit $res\n";
	
	protected static String b2llvmSh = "#!/bin/bash\n"
			+ "export TRAILSTKSIZE=1M\n"
			+ "!currentPathExtensions! $@\n" 
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
		
		
		
		pathProbCli = new JOptionPane().showInputDialog("Please, type the destination path of binary file probcli, for example: /Users/guest/Myprograms/ProB/probcli:");
		
		GeneralPreferences.updatePathProbcli(pathProbCli);
		
		//Downloading the b2llvm
		String filename = new String("b2llvm.zip");

		String destinationPath = System.getProperty("user.home")+File.separator+"Applications"+File.separator+"BTools"+File.separator;
		
		destinationPath = GeneralPreferences.getPathFileB2llvm(destinationPath);
		String destinationfilePath = destinationPath+filename;
		File f = new File(destinationPath);
        
        if(f.mkdir()) 
			System.out.println("- Destination directory: \""+destinationPath +"\".");
		
		int res = new JOptionPane().showConfirmDialog(null, "Would you like to download and update the b2llvm?","b2llvm" ,JOptionPane.OK_CANCEL_OPTION,	JOptionPane.WARNING_MESSAGE); 
				if (res == JOptionPane.OK_OPTION){ 
					System.out.println("Installing b2llvm:");
					//System.out.println("Checking if python is installed ..");
					
					String url = new String("https://bitbucket.org/ddeharbe/b2llvm/downloads/"+filename);
					
					URL website;
					try {
						System.out.println("- Downloading the b2llvm.");
						website = new URL(url);
						ReadableByteChannel rbc = Channels.newChannel(website.openStream());
						FileOutputStream fos = new FileOutputStream(destinationfilePath);
						fos.getChannel().transferFrom(rbc, 0, Long.MAX_VALUE);
						System.out.println("- Download finished.");
					} catch (Exception e) {
						System.err.println("Cannot download the b2llvm from:"+url);
						e.printStackTrace();
					}
					
					//Write the files 
					System.out.println("- Unzip the b2llvm.");
					Unzip z = new Unzip();
					try {
						z.unzip(destinationfilePath,destinationfilePath.replace(filename, ""));
					} catch (IOException e) {
						System.err.println("Cannot extract the b2llvm file:"+destinationfilePath);
						e.printStackTrace();
					}
					System.out.println("- Unzip finished.");
					
					
					
					
				
		
		if(!System.getProperty("os.name").toLowerCase().contains("windows")) {
			    
			try {
				Runtime.getRuntime().exec("chmod +x "+destinationPath+"b2llvm.py");
			} catch (IOException e) {
				System.err.println("Error when trying to add the execution permission in b2llvm.py");
				e.printStackTrace();
			}
		}else{
			System.out.println("The installations procedures was not tested for Windows Operating System");
		}
		
		Control.writeFile(currentPathExtensions + "b2llvm.etool",
						Installation.B2llvm_tool.replaceFirst("!currentPathExtensions!BEval.sh", destinationPath+"b2llvm.py"));
		
		Control.writeFile(currentPathExtensions + "BEvalGoal.etool",
				Installation.bEvalGoalEtool.replaceFirst("!currentPathExtensions!BEval.sh", currentPathExtensions+"BEval.sh"));
		
		
				}
		//Control.writeFile(currentPathExtensions + "b2llvm.sh",
		//		Installation.b2llvmSh.replaceFirst("!currentPathExtensions!", destinationPath+"b2llvm.py"));

		//Control.writeFile(currentPathExtensions + "Config.txt",
		//		Installation.configTxt.replaceFirst("!pathProbCli!", pathProbCli));
		
		try {
			Runtime.getRuntime().exec("chmod +x "+currentPathExtensions + "BEval.sh");
			//Runtime.getRuntime().exec("chmod +x "+currentPathExtensions + "b2llvm.sh");
		} catch (IOException e) {
			System.err.println("Error when trying to add the execution permission in BEval.sh");
			e.printStackTrace();
		}
		
		System.out.println("The configuration files were updated!");
	}
	
	
	private static String  executeCommand(String command) {
		 
		StringBuffer output = new StringBuffer();
		
		Process p;
		try {
			p = Runtime.getRuntime().exec(new String[]{"bash","-c",command});
			p.waitFor();
			BufferedReader reader = 
                            new BufferedReader(new InputStreamReader(p.getInputStream()));
 
                        String line = "";			
			while ((line = reader.readLine())!= null) {
				output.append(line + "\n");
			}
 
		} catch (Exception e) {
			e.printStackTrace();
		}
 
		return output.toString();
 
	}
	
	
	
	  


}
