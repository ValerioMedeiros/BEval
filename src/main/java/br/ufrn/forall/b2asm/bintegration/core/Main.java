package br.ufrn.forall.b2asm.bintegration.core;

import java.awt.EventQueue;
import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;

import br.ufrn.forall.b2asm.bintegration.core.StreamGobbler.Result;

/**
 * This class just call call the ProB evaluator
 * @author valerio
 *
 */
public class Main {
	final static String version= "0.5"; 


	/**
	 * @author valerio
	 * @param args
	 */
	public static void main(String[] args) {


		if (args.length ==0 ){
			System.out.println("B integration solver version "+version);
			System.out.println("__________________________________");
			System.out.println("Installation instructions:");
			System.out.println("1 - Move the file ("+Installation.filenameJar+") to $AtelierB_Directory/AB/extensions, after update the config files");
			System.out.println("2 - For update the config files, execute #java -jar "+Installation.filenameJar+ " --install");
			System.exit(0);
		}
		
		if (args.length ==1 && args[0].contains("--install")){
			Installation.main(null);
			System.exit(0);
		}

		final Control control=  new Control();

		control.setGoalParameters(args);

		control.loadConfig();
		
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					
					GuiPoIndividual window = new GuiPoIndividual(control);
					
					window.frame.setVisible(true);
				
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
		
		
	}









}
