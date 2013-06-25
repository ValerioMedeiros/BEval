package br.ufrn.forall.b2asm.beval.pos;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import br.ufrn.forall.b2asm.beval.core.Control;

public class POs {
	private String pathPOFileWithoutExtension;
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
	private PMM pmm;
	private boolean isWDPO;
	
	
	/**
	 * This constructor parser the proof obligations 
	 * @param pathPOFileWithoutExtension - file ".po" located in bdp
	 */
	
	public POs (String pathPOFileWithoutExtension, boolean isWDPO) throws Exception {
		
		this.pathPOFileWithoutExtension = pathPOFileWithoutExtension;
		this.isWDPO = isWDPO;
		
		String moduleName = pathPOFileWithoutExtension.substring(pathPOFileWithoutExtension.lastIndexOf(File.separator) + 1);
		String pathProject = pathPOFileWithoutExtension.substring(0,pathPOFileWithoutExtension.lastIndexOf(File.separator));
		
		if (!isWDPO)
			original = Control.readFile(pathProject+File.separator+"bdp"+File.separator+moduleName+".po");
		else
			original = Control.readFile(pathProject+File.separator+"bdp"+File.separator+moduleName+"_wd.po");
		
		if (!isWDPO)
			pOsStatus = new POsStatus(pathProject+File.separator+"bdp"+File.separator+moduleName+".pmi" );
		else
			pOsStatus = new POsStatus(pathProject+File.separator+"bdp"+File.separator+moduleName+"_wd.pmi" );
		
		if (!isWDPO)
			pmm = new PMM(pathPOFileWithoutExtension+".pmm");
		else
			pmm = new PMM(pathPOFileWithoutExtension+"_wd.pmm");
		
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
		
		if(proofListRead!=null && proofListRead.length()>=7){
			
		posUnexpandedRead = proofListRead.split(";");
		
		//System.out.println("List "+posUnexpandedRead.length);

		expandedHypoThesis = new String [posUnexpandedRead.length];
		expandedGoal = new String [posUnexpandedRead.length];
		
			for(int count = 0; count<posUnexpandedRead.length ; count++ ){
				loadEachExpandedProofObligation(count);
			}
		
		}
		
	}
	
	private void loadEachExpandedProofObligation(int count) {

		String  hypothesis = posUnexpandedRead[count].split("=>")[0];
		
		String  goal = posUnexpandedRead[count].split("=>")[1];
		
		expandedHypoThesis[count]=getFormulaExpanded(hypothesis);
		
		expandedGoal[count]= getFormulaExpanded(goal );
		
		
	}
	
	public void addOneRuleInPMMFile(boolean poTypedWD, String rule,String expressionName, Long total_time ) {
		pmm.addWriteRuleInPMMFile(poTypedWD, rule, expressionName, total_time);
	}
	
	String getFormulaExpanded(String originalFormula){
	 	StringBuffer expandedFormula= new StringBuffer();
	 	//get the list of formulas on goal
		List<String> listGoal = getAllMatches(originalFormula,"[_][f]\\([0-9]*\\)");

		for(int i=0;i<listGoal.size() ;i++){
			
			if(listGoal.get(i)==null)break;
			
			// Remove the characters no numerics, transform to Integer, get in list of formulas and append
			expandedFormula.append(
					formulasSplitted[Integer.parseInt(
							listGoal.get(i)
							.replaceAll("[\\D]", ""))-1
					                 ]);
			
			if(i!=listGoal.size()-1)expandedFormula.append(" & ");
			
		}
		return expandedFormula.toString();
 	}

	
	 String getFormulaExpandedWithOnlyLocalHypothesis(String originalFormula){
		 	StringBuffer expandedFormula= new StringBuffer();
		 	//get the list of formulas on goal
			List<String> listGoal = getAllMatches(originalFormula,"[_][f]\\([0-9]*\\)");

			for(int i=listGoal.size()-1;i<listGoal.size() ;i++){
				
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

		return expandedHypoThesis[posUnexpandedRead.length -numberOfProofObligation]+"\n => "+expandedGoal[posUnexpandedRead.length - numberOfProofObligation];
	}

	/***
	 * This method return one proof obligation WITH comments and with only local hypotheses from proof obligation
	 * @param numberOfProofObligation  enumerating from 1 up to numbers of proof obligations
	 * @return 
	 */
	public	String getProofObligationsWithLocalHypotheses(int numberOfProofObligation){
		
		String tmp = this.posUnexpandedRead[posUnexpandedRead.length - numberOfProofObligation].split("=>")[0];
		 
		String basicHypotheses = getFormulaExpandedWithOnlyLocalHypothesis(tmp);
		
		return new String( basicHypotheses+"\n => "+expandedGoal[posUnexpandedRead.length - numberOfProofObligation]);
	}
	
	/***
	 * This method return one proof obligation without comments and with only local hypotheses from proof obligation
	 * @param numberOfProofObligation  enumerating from 1 up to numbers of proof obligations
	 * @return 
	 */
	public	String getCleanProofObligationsWithLocalHypotheses(int numberOfProofObligation){
		
		String tmp = this.posUnexpandedRead[posUnexpandedRead.length - numberOfProofObligation].split("=>")[0];
		 
		String basicHypotheses = getFormulaExpandedWithOnlyLocalHypothesis(tmp);
		
		return new String( "("+basicHypotheses.replaceAll("\"(.*?)\"", "btrue")+"\n => "+expandedGoal[posUnexpandedRead.length - numberOfProofObligation]+")");
	}
	/***
	 * This method return one proof obligation without comments
	 * @param numberOfProofObligation  enumerating from 1 up to numbers of proof obligations
	 * @return
	 */
	public	String getCleanExpandedProofObligations(int numberOfProofObligation){
		return new String(expandedHypoThesis[expandedHypoThesis.length - numberOfProofObligation].replaceAll("\"(.*?)\"", "btrue")+"\n => "+expandedGoal[posUnexpandedRead.length -numberOfProofObligation]);
	}
	
	/***
	 * This method return only the hypothesis without comments 
	 * @param numberOfProofObligation  enumerating from 1 up to numbers of proof obligations
	 * @return
	 */
	public String getHypoThesisOfCleanExpandedProofObligations(int numberOfProofObligation){
		
		return new String((expandedHypoThesis[expandedHypoThesis.length - numberOfProofObligation]).replaceAll("\"(.*?)\"", "btrue"));
	}
	
	
	/***
	 * This method return only the goal, in other words, one proof obligation without comments and without hypothesis
	 * @param numberOfProofObligation  enumerating from 1 up to numbers of proof obligations
	 * @return
	 */
	public String getGoalOfCleanExpandedProofObligations(int numberOfProofObligation){
		
		return (expandedGoal[expandedGoal.length - numberOfProofObligation]).replaceAll("\"(.*?)\"", "btrue");
	}
	
	
	public int getNumberOfProofObligations(){
		//The size of expandedHypoThesis is equal to expandedGoal
		return expandedGoal.length;
	}
	
	/**
	 * Returns true, when the proof obligation is evaluated true
	 * @param number enumerating from 1 up to numbers of proof obligations
	 * @return
	 */
	public boolean isProvedTheProofState(int number){
		return pOsStatus.isProvedTheProofState(number);
	}
	/**
	 * @param number enumerating from 1 up to numbers of proof obligations
	 * @return
	 */
	public String getProofState(int number){
			return pOsStatus.getProofState(number);
	}

	public String[] getStateAndNameOfProofObligations() {
		if(proofListRead==null){
			return new String[0];
		}else{
			
			String[] tmp = proofListRead.split(";");
			String[] result = new String[tmp.length];
			
			for(int i =0 ;i<result.length;i++){
				
				String namePartial = tmp[result.length - i-1].split(",")[0];
				
				/*String namePartial;
				if(tmp[result.length - i-1].indexOf(",")>0)
					namePartial = tmp[result.length - i-1].substring(tmp[result.length - i].indexOf(","));
				else
					namePartial = tmp[result.length - i-1];*/
				//System.out.println(result.length -i + " R:"+result.length+ " "+ i);
				result[i]= i+1+" - "+namePartial.substring(namePartial.lastIndexOf("&")+1) + " ("+getProofState(i+1)+" )";
			}
			
			return result;
		}
	}
	
	
	
}
