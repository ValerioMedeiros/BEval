package br.ufrn.forall.b2asm.beval.pos;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;

import br.ufrn.forall.b2asm.beval.core.Control;

public class PMM {
	String pathPMM;
	private String [] theoriesSplittedsRead;
	private String [] userPassSplittedsRead;
	private ArrayList<String> userPassList = new ArrayList<String>();
	private ArrayList<String> TheoryRuleList = new ArrayList<String>();
	
	
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
				+ "==btrue\n");

		String newRules = stringInitialFile + addedRule + finalFile;

		Control.writeFile(pathPMM, newRules);
		// close the END
	}
	
	//TODO: Create public writeUpdatedPMM
	
	private void addTheoryAndUserPassInList(String theoryRule , String userPass) {
		TheoryRuleList.add(theoryRule);
		userPassList.add(userPass);
		
	}

	private String getUserPassInList() {
		StringBuffer theoryUserPass =new StringBuffer( );
		boolean firstUserPass=false;
		
		for(int i=0;i<theoriesSplittedsRead.length;i++){
			if(theoriesSplittedsRead[i].contains("THEORY User_Pass IS")){
				theoryUserPass.append(theoriesSplittedsRead[i]) ;
				firstUserPass = !(theoriesSplittedsRead[i].contains(";"));
				firstUserPass = firstUserPass && theoriesSplittedsRead[i].length()<=25;
			}
			else if(theoriesSplittedsRead.length == i && userPassList.size()>=1){ // case there is not!
				theoryUserPass.append("THEORY User_Pass IS\n") ;
				firstUserPass=true;
			}
		}
		
		if(!firstUserPass) theoryUserPass.append(";\n");
		
		for(int i = 0; i< userPassList.size(); i++){
			
			if(userPassList.size()==i+1){// The last element
				theoryUserPass.append(userPassList.get(i));
			}else{
				theoryUserPass.append(userPassList.get(i)+";\n");
			}
		}
		theoryUserPass.append("\nEND\n");
		
		return theoryUserPass.toString(); 
	}
	
	
	
	
}
