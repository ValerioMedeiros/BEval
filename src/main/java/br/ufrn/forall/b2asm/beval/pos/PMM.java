package br.ufrn.forall.b2asm.beval.pos;

import java.util.ArrayList;
import java.util.Date;

import br.ufrn.forall.b2asm.beval.core.Control;

public class PMM {
	String pathPMM;
	private String [] theoriesSplittedsRead;
	
	private ArrayList<String> userPassList = new ArrayList<String>();
	private ArrayList<String> theoryRuleList = new ArrayList<String>();
	
	
	public PMM (String pathPMM){
		this.pathPMM = pathPMM;	
		load();
	}

	void load(){
		
		String contentPmmFile =Control.readFile(pathPMM);
		theoriesSplittedsRead = contentPmmFile.split("END");

		
	}
	
	
	void addWriteRuleInPMMFile(boolean poTypedWD, String rule,String expressionName, Long total_time ) {
		
		final String finalFile = new String("\nEND");

		String fulltext = Control.readFile(pathPMM);

		String[] theoriesSplitted = fulltext.split("END");

		// count the number of theories
		int numberTheories;
		if (theoriesSplitted[theoriesSplitted.length - 1].contains("THEORY"))
			numberTheories = theoriesSplitted.length;
		else
			numberTheories = theoriesSplitted.length - 1;

		StringBuffer stringInitialFile = new StringBuffer();
		for (int i = 0; i < numberTheories; i++) {

			stringInitialFile.append(theoriesSplitted[i] + "END");

		}

		// if there is just one rule so add one ";" before the new rule
		String separator;
		if (theoriesSplitted[numberTheories - 1].contains("THEORY")) {
			separator = new String("\n&\n");
		}
		// else if(theoriesSplitted[numberTheories-1].contains("==") ) separator
		// = ";";
		else
			separator = "";

		String addedRule = new String(separator + "THEORY RulesProB"
				+ expressionName.replace(".", "_") + " IS \n\n"
				+ "\n\t /* Expression from " + expressionName
				+ ", it was added  in " + new Date()
				+ "\n\t  evaluated with ProB in " + total_time + " milliseconds"
				+ "\n\t  Module Path:" + pathPMM + " */" + "\n\n\t " + rule 
				+ "\n");

		String newRules = stringInitialFile + addedRule + finalFile;

		Control.writeFile(pathPMM, newRules);

	}
	

	protected void writeUpdatedPMM() {

		Control.writeFile(pathPMM, getNewUserPassInList()+ " " + getNewTheoryInList());
	}
	
	protected void addTheoryAndUserPassInList(String theoryRule , String userPass) {
		theoryRuleList.add(theoryRule);
		userPassList.add(userPass);
		
	}
	/**
	 * This method returns the theories with the "Theory added", except the User_Pass.
	 * @return String - The user pass
	 */
	private String getNewTheoryInList() {
		StringBuffer theories  = new StringBuffer( );
		
		for(int i=0;i<theoriesSplittedsRead.length;i++){
			
			if(theoriesSplittedsRead[i].contains("THEORY User_Pass IS"))
				continue;
			if(i+1 != theoriesSplittedsRead.length) //if space after the last end  
				theories.append(theoriesSplittedsRead[i]+"END\n");
			else if (theoriesSplittedsRead[i].contains("THEORY "))
				theories.append(theoriesSplittedsRead[i]+"END\n");
		}
		
		if(theoryRuleList.size()>0) theories.append(" &\n");
		
		for(int i = 0; i< theoryRuleList.size(); i++){
			
			if(theoryRuleList.size()==i+1){	// The last element
				theories.append(theoryRuleList.get(i));
			}else{
				theories.append(theoryRuleList.get(i)+"\n&\n");
			}
		}
		
		
		return theories.toString();
		
	}
	/**
	 * This method returns the theory user pass with the "user pass added".
	 * @return String - The user pass
	 */
	private String getNewUserPassInList() {
		StringBuffer theoryUserPass =new StringBuffer( );
		boolean noAddSeparetor=false;
		boolean containUserPass=false;
		
		for(int i=0;i<theoriesSplittedsRead.length;i++){
			if(theoriesSplittedsRead[i].contains("THEORY User_Pass IS")){//The first case
				theoryUserPass.append(theoriesSplittedsRead[i]) ;
				noAddSeparetor = !(theoriesSplittedsRead[i].contains(";"));
				noAddSeparetor = noAddSeparetor && theoriesSplittedsRead[i].length()<=25;
				containUserPass=true;
			}
			else if( !containUserPass && theoriesSplittedsRead.length == 1+i && userPassList.size()>=1){ // case there is not!
				theoryUserPass.append("THEORY User_Pass IS\n") ;
				noAddSeparetor=true;
			}
		}
		
		if( userPassList.size()>=1 && !noAddSeparetor) theoryUserPass.append("; \n");
		
		for(int i = 0; i< userPassList.size(); i++){
			
			if(userPassList.size()==i+1){	// The last element
				theoryUserPass.append(userPassList.get(i));
				theoryUserPass.append("\nEND\n");
			}else{
				theoryUserPass.append(userPassList.get(i)+"; \n");
			}
		}
		
		  
		
		
		
		return theoryUserPass.toString(); 
	}
	
	
	
	
}
