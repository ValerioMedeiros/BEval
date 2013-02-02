package br.ufrn.forall.b2asm.bintegration.pos;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import br.ufrn.forall.b2asm.bintegration.core.Control;

public class POs {
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
	private POsStatus pOsStatus;
	
	
	/**
	 * This constructor parser the proof obligations 
	 * @param pathPOFile - file ".po" located in bdp
	 */
	
	public POs (String pathPOFile){
		
		this.pathFile = pathPOFile;

		original = Control.readFile(pathFile);
		
		pOsStatus = new POsStatus(pathFile.substring(0, pathFile.length()-3)+".pmi" ); 
		
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
		
		String  goal = posUnexpandedRead[count].split("=>")[1];
		
		expandedHypoThesis[count]=getFormulaExpanded(hypothesis);
		
		expandedGoal[count]= getFormulaExpanded(goal );
		
		
	}
	
	 String getFormulaExpanded(String originalFormual){
		 	StringBuffer expandedFormula= new StringBuffer();
		 	//get the list of formulas on goal
			List<String> listGoal = getAllMatches(originalFormual,"[_][f]\\([0-9]*\\)");

			for(int i=0;i<listGoal.size() ;i++){
				
				if(listGoal.get(i)==null)break;
				
				// Remove the characters no numerics, transform to Integer, get in list of formulas and append
				expandedFormula.append(formulasSplitted[Integer.parseInt(listGoal.get(i).replaceAll("[\\D]", ""))-1]);
				
				if(i!=listGoal.size()-1)expandedFormula.append(" & ");
				
			}
			return expandedFormula.toString();
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
	 * This method return one proof obligation with B comments
	 * @param numberOfProofObligation  enumerating from 1 up to numbers of proof obligations
	 * @return 
	 */
	public String getExpandedProofObligations(int numberOfProofObligation){

		return expandedHypoThesis[numberOfProofObligation-1]+"\n => "+expandedGoal[numberOfProofObligation-1];
	}

	/***
	 * This method return one proof obligation without comments and with only local hypotheses from proof obligation
	 * @param numberOfProofObligation  enumerating from 1 up to numbers of proof obligations
	 * @return 
	 */
	public	String getCleanProofObligationsWithLocalHypotheses(int numberOfProofObligation){
		String tmp;
		//String tmp = expandedHypoThesis[numberOfProofObligation-1].replaceAll("\"(.*?)\"", "btrue");
		if(formulasSplitted[numberOfProofObligation-1].contains(","))
			 tmp = formulasSplitted[numberOfProofObligation-1].split(",")[1];
		else 
			 tmp = formulasSplitted[numberOfProofObligation-1];
			
		//String basicHypotheses =  tmp.split(",")[1]; //remove unneeded hypotheses when the concepts are loaded
		String basicHypotheses = getFormulaExpanded(tmp.replaceAll("\"(.*?)\"", "btrue"));
		
		return new String(basicHypotheses+"\n => "+expandedGoal[numberOfProofObligation-1]);
	}
	/***
	 * This method return one proof obligation without comments
	 * @param numberOfProofObligation  enumerating from 1 up to numbers of proof obligations
	 * @return
	 */
	public	String getCleanExpandedProofObligations(int numberOfProofObligation){
		
		return new String(expandedHypoThesis[numberOfProofObligation-1].replaceAll("\"(.*?)\"", "btrue")+"\n => "+expandedGoal[numberOfProofObligation-1]);
	}
	
	/***
	 * This method return only the hypothesis without comments 
	 * @param numberOfProofObligation  enumerating from 1 up to numbers of proof obligations
	 * @return
	 */
	public String getHypoThesisOfCleanExpandedProofObligations(int numberOfProofObligation){
		
		return new String((expandedHypoThesis[numberOfProofObligation-1]).replaceAll("\"(.*?)\"", "btrue"));
	}
	
	
	/***
	 * This method return only the goal, in other words, one proof obligation without comments and without hypothesis
	 * @param numberOfProofObligation  enumerating from 1 up to numbers of proof obligations
	 * @return
	 */
	public String getGoalOfCleanExpandedProofObligations(int numberOfProofObligation){
		
		return (expandedGoal[numberOfProofObligation-1]).replaceAll("\"(.*?)\"", "btrue");
	}
	
	
	public int getNumberOfProofObligations(){
		//The size of expandedHypoThesis is equal to expandedGoal
		return expandedGoal.length;
	}
	
	public boolean isProvedTheProofState(int number){
		return pOsStatus.isProvedTheProofState(number);
	}
	public String getProofState(int number){
	
		return pOsStatus.getProofState(number);
	}
	
	
	
}
