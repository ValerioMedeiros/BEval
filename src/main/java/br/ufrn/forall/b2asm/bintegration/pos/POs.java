package br.ufrn.forall.b2asm.bintegration.pos;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import br.ufrn.forall.b2asm.bintegration.core.Control;

class POs {
	private String pathFile;
	private String original;
	private String [] theoriesSplittedsRead;
	private String [] posUnexpandedRead;
	private String proofListRead;
	private String formulasRead;
	private String enumerateXRead;
	private String versionRead;
	
	private String [] formulasSplitted;
	private String [] expandedHypoThesis;
	private String [] expandedGoal;
	
	
	/**
	 * This constructor parser the proof obligations 
	 * @param pathPOFile - file ".po" located in bdp
	 */
	
	POs (String pathPOFile){
		
		this.pathFile = pathPOFile;

		original = Control.readFile(pathFile);
		
		load();
		
	}
	
	void load(){

		theoriesSplittedsRead = original.split("END");
		
		for(int i=0;i<theoriesSplittedsRead.length;i++)
			if(theoriesSplittedsRead[i].contains("THEORY ProofList IS"))
				proofListRead = theoriesSplittedsRead[i];
		
		for(int i=0;i<theoriesSplittedsRead.length;i++)
			if(theoriesSplittedsRead[i].contains("THEORY Formulas IS")){
				formulasRead = theoriesSplittedsRead[i];
				formulasRead= formulasRead.replaceFirst("&\nTHEORY Formulas IS", "");
			}
		for(int i=0;i<theoriesSplittedsRead.length;i++)
			if(theoriesSplittedsRead[i].contains("THEORY EnumerateX IS"))
				enumerateXRead = theoriesSplittedsRead[i];
		
		for(int i=0;i<theoriesSplittedsRead.length;i++)
			if(theoriesSplittedsRead[i].contains("THEORY Version IS"))
				versionRead = theoriesSplittedsRead[i];
		
		loadFormulas();
		loadProofList();
		
		
	}
	
	void loadProofList(){
		
		posUnexpandedRead = proofListRead.split(";");
		//System.out.println("List "+posUnexpandedRead.length);

		expandedHypoThesis = new String [posUnexpandedRead.length];
		expandedGoal = new String [posUnexpandedRead.length];
		
		for(int count = 0; count<posUnexpandedRead.length ; count++ )
			loadEachExpandedProofObligation(count);
		
	
		
	}
	
	private void loadEachExpandedProofObligation(int count) {

		String  hypothesis = posUnexpandedRead[count].split("=>")[0];
		StringBuffer hypoStringBuffer = new StringBuffer();
		
		String  goal = posUnexpandedRead[count].split("=>")[1];
		StringBuffer goalStringBuffer = new StringBuffer();
		
		
		//get the list of formulas on hypothesis
		List<String> listHypothesis = getAllMatches(hypothesis,"[_][f]\\([0-9]*\\)");
		
		for(int i=0;i<listHypothesis.size() ;i++){
			
			if(listHypothesis.get(i)==null)break;
			
			// Remove the characters no numerics, transform to Integer, get in list of formulas and append
			hypoStringBuffer.append(formulasSplitted[Integer.parseInt(listHypothesis.get(i).replaceAll("[\\D]", ""))-1]);
			
			if(i!=listHypothesis.size()-1)hypoStringBuffer.append(" & ");
			
		}
		
		//get the list of formulas on goal
		List<String> listGoal = getAllMatches(goal,"[_][f]\\([0-9]*\\)");
		

		expandedHypoThesis[count]= hypoStringBuffer.toString();
		
		for(int i=0;i<listGoal.size() ;i++){
			
			if(listGoal.get(i)==null)break;
			
			// Remove the characters no numerics, transform to Integer, get in list of formulas and append
			goalStringBuffer.append(formulasSplitted[Integer.parseInt(listGoal.get(i).replaceAll("[\\D]", ""))-1]);
			
			if(i!=listGoal.size()-1)goalStringBuffer.append(" & ");
			
		}
		expandedGoal[count]= goalStringBuffer.toString();
		
		
	}

	 List<String> getAllMatches(String text, String regex) {
		
        List<String> matches = new ArrayList<String>();

        Matcher m = Pattern.compile("(?=(" + regex + "))").matcher(text);
        
        while(m.find()) {
        
        	matches.add(m.group(1));
        }
        return matches;
    }
	
	void loadFormulas(){
		
		formulasSplitted = formulasRead.split(";");
		//System.out.println("Formulas  "+ formulasSplitted.length);
		
		
	}
	/***
	 * This method return one proof obligation
	 * @param numberOfProofObligation  enumerating from 1 up to numbers of proof obligations
	 * @return
	 */
	String getExpandedProofObligations(int numberOfProofObligation){

		return expandedHypoThesis[numberOfProofObligation-1]+"\n => "+expandedGoal[numberOfProofObligation-1];
	}
	
	/***
	 * This method return one proof obligation without comments
	 * @param numberOfProofObligation  enumerating from 1 up to numbers of proof obligations
	 * @return
	 */
	String getCleanExpandedProofObligations(int numberOfProofObligation){
		
		return (expandedHypoThesis[numberOfProofObligation-1]+"\n => "+expandedGoal[numberOfProofObligation-1]).replaceAll("\\\"([^<]*)\\\"", "btrue");
	}
	
	/***
	 * This method return only the hypothesis without comments 
	 * @param numberOfProofObligation  enumerating from 1 up to numbers of proof obligations
	 * @return
	 */
	String getHypoThesisOfCleanExpandedProofObligations(int numberOfProofObligation){
		
		return (expandedHypoThesis[numberOfProofObligation-1]).replaceAll("\\\"([^<]*)\\\"", "btrue");
	}
	
	
	/***
	 * This method return only the goal, in other words, one proof obligation without comments and without hypothesis
	 * @param numberOfProofObligation  enumerating from 1 up to numbers of proof obligations
	 * @return
	 */
	String getGoalOfCleanExpandedProofObligations(int numberOfProofObligation){
		
		return (expandedGoal[numberOfProofObligation-1]).replaceAll("\\\"([^<]*)\\\"", "btrue");
	}
	
	
	int getNumberOfProofObligations(){
		//The size of expandedHypoThesis is equal to expandedGoal
		return expandedGoal.length;
	}
	
	
	void storeResults(){
		
	}
	
	
	
}
