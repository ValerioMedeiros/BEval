/**
 * 
 */
package br.ufrn.forall.b2asm.bintegration.core;

import java.util.prefs.Preferences;

import javax.swing.JOptionPane;

/**
 * Class for manager preferences
 * 
 * 
 */
public class GeneralPreferences {

	private static final Preferences PREFERENCES = Preferences.userRoot().node("Forall");
	
	/**
	 * This class contains the preferences to verification:
	 *   - Parameters probcli
	 *   - Path probcli
	 */
	public GeneralPreferences() {
	}
	
	public static void updatePathProbcli(String path){
		 GeneralPreferences.PREFERENCES.put("PathProbcli", path);
	}
	
	public static String getPathProbcli(){
		String res = GeneralPreferences.PREFERENCES.get("PathProbcli", null);
		
		if (res==null) {
			res= JOptionPane.showInputDialog("Type the path of binary probcli:", "");
			
			updatePathProbcli(res);
		}
			
		 return res; 
	}

}
