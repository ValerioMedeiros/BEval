package br.ufrn.forall.b2asm.beval.core;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Date;

import br.ufrn.forall.b2asm.beval.core.Report.POWD;
import br.ufrn.forall.b2asm.beval.core.Report.PoGenerated;
import br.ufrn.forall.b2asm.beval.core.StreamGobbler.Result;
import br.ufrn.forall.b2asm.beval.pos.POs;
import br.ufrn.forall.b2asm.utils.AutoDismiss;

/**
 * This class contains the control elements to call the ProB evaluator
 * 
 * @author valerio
 * 
 */

public class Control {

	Result result;
	String currentPath, executablePath;
	String actualParameters;

	String expressionName;
	String moduleName;
	String modulePath;
	String pathBModuleInBdpFolderWithoutExtension;
	String separetor;
	String componentExtension;
	String goal; //
	String hypothesis;
	boolean isWD;
	long total_time = 0;
	String [] stateAndNames;

	final int indExpressionName = 0;
	final int indModuleName = 1;
	final int indModulePath = 2;
	final int indComponentExtension = 3;
	final int indGoal = 4; //
	private int exitVal;
	private POs posManager;

	public Control() {

	}



	/**
	 * This method load config preferences the path of ProB; the time limit and others informations.
	 * 
	 */
	public void loadConfig() {

			currentPath = Control.class.getProtectionDomain().getCodeSource().getLocation().getPath().replaceAll(Installation.filenameJar, "");
			
			executablePath = GeneralPreferences.getPathProbcli();
			
			actualParameters = GeneralPreferences.getActualParameters();
			
	}


	public String getExecutablePath() {
		
		return executablePath;
		
	}

	public void setIndividualArgs(String[] args) {
		boolean startReadHypothesis = false;
		StringBuffer tmpGoal = new StringBuffer();
		StringBuffer tmpHypothesis = new StringBuffer();
		try {
			expressionName = args[indExpressionName];
			moduleName = args[indModuleName];
			modulePath = args[indModulePath];
			componentExtension = args[indComponentExtension];
			//TODO: To use the variable ${projectBdp}from AtelierB that contains the path to the bdp directory of the project.
			//pathBModuleInBdpFolderWithoutExtension =   modulePath.replace(moduleName+"."+componentExtension,"")+"bdp"+File.separator+moduleName;
			pathBModuleInBdpFolderWithoutExtension =   modulePath.replace("."+componentExtension, "");
			setIsWD(false);

		} catch (Exception e) {

			System.err.println("Error: you need specify the parameters");

		}

		int cont = indGoal;

		for (; cont < args.length; cont++) {

			if (!startReadHypothesis && !args[cont].contains("#@#"))
				tmpGoal.append(" " + args[cont]);
			else
				break;

		}
		// start the read the next element of hypothesis
		for (cont++; cont < args.length; cont++)
			tmpHypothesis.append(" " + args[cont]);

		// Remove description text on goal PO
		goal = tmpGoal.toString().replaceAll("\"(.*?)\"", "btrue");

		// Remove description tex on hypothesis PO
		hypothesis = tmpHypothesis.toString().replaceAll("\"(.*?)\"", "btrue");

	}


	@SuppressWarnings("unused")
	public void setModuleArgs(String[] args) {
		
		boolean startReadHypothesis = false;
		StringBuffer tmpGoal = new StringBuffer();
		StringBuffer tmpHypothesis = new StringBuffer();
		try {
			expressionName = args[indExpressionName];
			moduleName = args[indModuleName];
			modulePath = args[indModulePath];
			componentExtension = args[indComponentExtension];
			
			//TODO: To use the variable ${projectBdp}from AtelierB that contains the path to the bdp directory of the project.
			//pathBModuleInBdpFolderWithoutExtension =   modulePath.replace(moduleName+"."+componentExtension,"")+"bdp"+File.separator+moduleName;
			pathBModuleInBdpFolderWithoutExtension =   modulePath.replace("."+componentExtension, "");		
		} catch (Exception e) {

			System.err.println("Error: you need specify the parameters");
		}

	}
 
	public void setIsWD(boolean wd) throws Exception{
		isWD = wd;
		posManager = new POs(pathBModuleInBdpFolderWithoutExtension,isWD);
		stateAndNames = posManager.getNameAndNumberOfProofObligations();
		
	}
	

	public static void writeFile(String pathName, String content) {
		PrintWriter pwr;
		try {

			pwr = new PrintWriter(new FileWriter(pathName));
			pwr.print(content);
			pwr.close();

		} catch (IOException e) {
			System.err.println("Error: it is not possible create the file:"
					+ pathName);
			e.printStackTrace();
		}

	}

	public static String readFile(String pathName) {

		StringBuffer res = new StringBuffer();
		String str;

		try {
			File fileDir = new File(pathName);

			BufferedReader in = new BufferedReader(new InputStreamReader(
					new FileInputStream(fileDir), "UTF8"));

			while ((str = in.readLine()) != null) {
				res.append(str + "\n");
			}

			in.close();
		} catch (UnsupportedEncodingException e) {
			System.out.println("Unsupported Encoding " + e.getMessage());
		} catch (IOException e) {
			System.out.println("IOException " + e.getMessage());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return res.toString();
	}

	
	public int callProbLogicEval(boolean addRules, boolean poTypedWD, Report report, int numberPo,
			String parameters, String goalExpression) {

		exitVal = 0;

		try {
			Runtime rt = Runtime.getRuntime();

			String tmpPath = System.getProperty("java.io.tmpdir");
			String tmpFileName = tmpPath + File.separator + moduleName + "_"
					+ expressionName + ".goal";

			writeFile(tmpFileName, goalExpression);

			long initial_time = System.currentTimeMillis();
			
			//JOptionPane.showMessageDialog(null,goalExpression);
					
			//JOptionPane.showMessageDialog(null, this.getExecutablePath() + " "+ parameters.replace("\n", " ") + " --eval_rule_file "+ tmpFileName);
			
			Process proc = rt.exec(this.getExecutablePath() + " "
					+ parameters.replace("\n", " ") + " --eval_rule_file "
					+ tmpFileName);

			// any error message?
			StreamGobbler errorGobbler = new StreamGobbler(
					proc.getErrorStream(), "ERROR");

			// any output?
			StreamGobbler outputGobbler = new StreamGobbler(
					proc.getInputStream(), "OUTPUT"); // Can add a new parameter , System.out

			// kick them off
			errorGobbler.start();
			outputGobbler.start();

			exitVal = proc.waitFor();
			// Final time
			total_time = System.currentTimeMillis() - initial_time;

			Result res_out, res_error;
			res_out = outputGobbler.getResult();
			res_error = errorGobbler.getResult();

			//It is used to identify when the evaluation is individual
			String stateProB="";
			if(numberPo!=0)
				stateProB = posManager.getProofState(numberPo);
				
			report.add(numberPo,
					parameters,
					POWD.Common,
					PoGenerated.Full,
					goalExpression,
					stateProB,
					res_error,
					res_out,
					total_time);
			
			
			if (res_out != Result.ERROR && res_error != Result.ERROR) {
				printSuccessFullyMsg();
				result = res_out;

				if (result == Result.TRUE && addRules) {
					
					if(numberPo==0){ // It is used only in interactive prover - 
						posManager.addOneRuleInPMMFile(poTypedWD,goal+"==btrue",expressionName,total_time);
					}else{
						// This rule is used to add true rules of component
						
						String name = stateAndNames[numberPo-1];//.replaceAll(" ", "").replaceAll("\n", "").substring(stateAndNames[numberPo-1].indexOf("-")).substring(0, stateAndNames[numberPo-1].indexOf("(") );
						
						String userPass= "Operation("+name.substring(0,name.lastIndexOf("_"))+") & mp(Tac(RulesProB"	+name+"))";
								
					    String addedRule = new String(  "THEORY RulesProB"
								+ name+ " IS \n\n"
								+ "\n\t /* Expression from (" + name
								+ "), it was added  in " + new Date()
								+ "\n\t  evaluated with ProB in " + total_time + " milliseconds"
								+ "\n\t  Module Path:" + modulePath + " */" + "\n\n\t " + posManager.getProofObligationsWithLocalHypotheses(numberPo) 
								+ "\nEND\n");
						
						posManager.addTheoryAndUserPassInList(addedRule , userPass);

					}
				}

			} else {
				result = res_error;
				exitVal = 1;
			}

			System.out.println("Time spent: " + total_time);
			System.out.println("Process exit value: " + exitVal);

		} catch (Throwable t) {
			t.printStackTrace();
		}
		return exitVal;

	}

	/**
	 * This method is uded for one component and it calls several times the method to evaluate a proof obligation
	 * @param report - it contains the results of evaluations 
	 * @param parameters - it is the parameters of evaluation, when it is "null" then preferences parameter of machine are loaded. 
	 * @param onlyLocalHypotheses - evaluate with only local hypothesis or with all hypothesis
	 * @param selectedItens - it is a vector with selected proof obligations. The range index is 0..(numberOfselectedPOs-1)  and the elements 0..(numberOfTotalPOs-1) that represent the  "numberPo"  
	 * @return
	 */
	public Report callProbLogicEval_Module(Report report, String parameters, boolean onlyLocalHypotheses,int [] selectedItens ){
	
	
	int countSelected=0;
	int numberOftotalPOs = this.getNumberOfProofObligations();
	

		for (int numberPo = 1; numberPo <= numberOftotalPOs; numberPo++) {
			
			if( countSelected<selectedItens.length && selectedItens[countSelected]==numberPo-1){
				countSelected++;
				String proofObligation;
				if(onlyLocalHypotheses)
					proofObligation = this.getCleanProofObligationsWithLocalHypotheses(numberPo);
				else
					proofObligation = this.getGoalOfCleanExpandedProofObligations(numberPo);
				
				
				if(parameters == null){
					this.callProbLogicEval(true, false, report, numberPo , actualParameters,  proofObligation);
				} else{
					this.callProbLogicEval(true, false, report, numberPo , parameters,  proofObligation);
				}
				
				AutoDismiss.showMessageDialog(null, "Progress "+ countSelected+"/"+selectedItens.length+"\n"
					+"The result is "+this.getResult()+"\n"
					+proofObligation  ,700); 
				
				System.out.println("\nThe result is "+ this.getResult()+" and progress "+ countSelected+"/"+selectedItens.length+"\n");
			}
		}
		
		return report;
	}
		
	public void writeUpdatedPMM (){
		posManager.writeUpdatedPMM();
	}

	void printSuccessFullyMsg() {
		System.out.println("It was concluded successfully!");
		System.out.println("Prob checked and added the rule in:");

	}

	public Result getResult() {
		return result;
	}

	public String getCurrentPath() {
		return currentPath;
	}

	public String getCommand() {
		return actualParameters;
	}

	public String getExpressionName() {
		return expressionName;
	}

	public String getModuleName() {
		return moduleName;
	}

	public String getHypothesis() {
		return hypothesis;
	}

	public String getModulePath() {
		return modulePath;
	}

	public String getSeparetor() {
		return separetor;
	}

	public String getComponentExtension() {
		return componentExtension;
	}

	public String getGoal() {
		return goal;
	}

	public long getTotal_time() {
		return total_time;
	}

	public int getIndExpressionName() {
		return indExpressionName;
	}

	public int getIndModuleName() {
		return indModuleName;
	}

	public int getIndModulePath() {
		return indModulePath;
	}

	public int getIndComponentExtension() {
		return indComponentExtension;
	}

	public int getIndGoal() {
		return indGoal;
	}

	public int getExitVal() {
		return exitVal;
	}
	public int getNumberOfProofObligations(){
		return posManager.getNumberOfProofObligations();
	}

	public String[] getStateAndNameOfProofObligations() {
		try {
			return posManager.getStateAndNameOfProofObligations();	
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		
		
	}

	/**
	 * Returns true, when the proof obligation is evaluated true
	 * @param number enumerating from 1 up to numbers of proof obligations
	 * @return
	 */
	public boolean isProvedTheProofState(int number){
		
		return posManager.isProvedTheProofState(number);
		
	}
	/**
	 * @param number enumerating from 1 up to numbers of proof obligations
	 * @return
	 */
	
	public String getProofObligationsWithLocalHypotheses( int numberOfProofObligation){
		return posManager.getProofObligationsWithLocalHypotheses(numberOfProofObligation);
	}
	
	
	/**
	 * @param number enumerating from 1 up to numbers of proof obligations
	 * @return
	 */
	
	public String getCleanProofObligationsWithLocalHypotheses( int numberOfProofObligation){
		return posManager.getCleanProofObligationsWithLocalHypotheses(numberOfProofObligation);
	}
	
	/***
	 * This method return only the goal, in other words, one proof obligation without comments and without hypothesis
	 * @param numberOfProofObligation  enumerating from 1 up to numbers of proof obligations
	 * @return
	 */
	public String getGoalOfCleanExpandedProofObligations(int numberOfProofObligation){
		
		return posManager.getGoalOfCleanExpandedProofObligations(numberOfProofObligation);
	}

}
