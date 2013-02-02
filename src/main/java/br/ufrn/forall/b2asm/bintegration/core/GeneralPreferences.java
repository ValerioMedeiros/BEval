/**
 * 
 */
package br.ufrn.forall.b2asm.bintegration.core;

import java.util.prefs.Preferences;

/**
 * Class for manager preferences
 * 
 * 
 */
public class GeneralPreferences {

	private static final Preferences PREFERENCES = Preferences.userRoot().node("Forall");
	
	/**
	 * 
	 */
	public GeneralPreferences() {
	}
	
	public static void updatePathProbcli(String path){
		 GeneralPreferences.PREFERENCES.put("PathProbcli", path);
	}
	
	public static String getPathProbcli(){
		 return GeneralPreferences.PREFERENCES.get("PathProbcli", null);
	}

}
