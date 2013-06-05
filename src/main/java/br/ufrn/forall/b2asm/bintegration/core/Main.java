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
	final static String version= "0.7";
	private static boolean isModuleArgs=false; 


	/**
	 * @author valerio
	 * @param args
	 */
	public static void main(String[] args) {


		if (args.length ==0 ){
			System.out.println(Installation.softwareName+" version "+version);
			System.out.println("__________________________________");
			System.out.println("Installation instructions:");
			System.out.println("1 - Move the file ("+Installation.filenameJar+") to $AtelierB_Directory/AB/extensions, after update the config files.");
			System.out.println("2 - For update the config files,execute in terminal:\n" +
					" #java -jar "+Installation.filenameJar+ " --install");
			System.exit(0);
		}
		
		if (args.length ==1 && args[0].contains("--install")){
			Installation.main(null);
			System.exit(0);
		}

		final Control control=  new Control();

		if (contains(Installation.IdModule, args)){
			control.setModuleArgs(args);
			isModuleArgs=true;
		}
		else
			control.setIndividualArgs(args);

		control.loadConfig();
		
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					
					if(isModuleArgs){
						GuiPoModule window = new GuiPoModule(control); window.frame.setVisible(true);
					}else{
						GuiPoIndividual window = new GuiPoIndividual(control); window.frame.setVisible(true);
					}
					
				
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
		
		
	}

/**
 * This method analyze if the vector has a String.
 * @param string - 
 * @param args -  
 * @return boolean
 */
	private static boolean contains(String string, String[] args) {
		// TODO Auto-generated method stub
		for(int i=0;i<args.length;i++){
			if(args[i].contains(string)) return true;
		}
		
		return false;
	}









}
