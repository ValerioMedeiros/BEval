package br.ufrn.forall.b2asm.bintegration.core;

import java.util.ArrayList;
import java.util.List;

import javax.swing.JOptionPane;

import br.ufrn.forall.b2asm.bintegration.core.StreamGobbler.Result;

public class Report {
	public enum POWD {Common, WD }
	public enum PoGenerated {Full, OnlyGoal, SelectedHypotesesAndGoal }
	int size=0;
	List <Long> times = new ArrayList<Long>();;
	List <Result> results= new ArrayList<Result>();
	List <Result> outputsError= new ArrayList<Result>();
	List <Integer> PoNumber= new ArrayList<Integer>();
	List <String> parameters = new ArrayList<String>();
	List <POWD> isKindOfWD = new ArrayList<POWD>();
	List <PoGenerated> poGenerated = new ArrayList <PoGenerated>();
	List <String> proofObligation= new ArrayList<String>();
	List <String> proofStatePmiFile= new ArrayList<String>();
	
	int numberOfVerifiedWithAtelierB;
	int numberOfVerifiedWithAtelierBNotAutomaticly;
	int numberOfVerifiedWithProB;
	int numberOfVerified;
	int numberOfProBErrors;
	int numberOfProBDisproved;
	
	/**
	 * This method add an element to report
	 * @param numberPo - Number identifier of PO 
	 * @param pathModule - Path of module
	 * @param parameters - Parameters to verification
	 * @param isKindOfWD - enum POWD {Common, WD }
	 * @param pogen - PoGenerated {Full, OnlyGoal, SelectedHypotesesAndGoal }
	 * @param proofStatePmiFile 
	 * @param outputError
	 * @param result
	 * @param time
	 */
	void add(int numberPo,
			String parameters,
			POWD isKindOfWD,
			PoGenerated pogen ,
			String proofObligation,
			String proofStatePmiFile,
			Result outputError,
			Result result,
			Long time){
		this.times.add(time);
		
		this.parameters.add(parameters);
		this.isKindOfWD.add(isKindOfWD);
		this.poGenerated.add(pogen);
		this.proofStatePmiFile.add(proofObligation);
		this.results.add(result);
		this.outputsError.add(outputError);
		this.proofObligation.add(proofStatePmiFile);
		this.PoNumber.add(numberPo);
		size++;
	}
	
	public void print(String pathFile){
		StringBuffer res = new StringBuffer();
		
		resetCounters();
		
		for(int i=0;i<size;i++){
		
			 res.append( "\""+this.PoNumber.get(i) +"\",\""+
					this.parameters.get(i)+"\",\""+
					this.isKindOfWD.get(i)+"\",\""+
					this.poGenerated.get(i)+"\",\""+
					this.proofStatePmiFile.get(i)+"\",\""+
					this.proofObligation.get(i)  +"\",\""+ this.outputsError.get(i) +"\",\""+  this.results.get(i) +"\",\""+ this.times.get(i)+"\"\n" );
			
			 if(this.proofStatePmiFile.get(i).contains("Proved") ) numberOfVerifiedWithAtelierB++;
				 
			 if(this.proofStatePmiFile.get(i).contains("Proved(Util)") ) numberOfVerifiedWithAtelierBNotAutomaticly++;
			 
			 if(this.proofStatePmiFile.get(i).contains("Unproved")) numberOfVerifiedWithAtelierBNotAutomaticly++;
				 
			 if(this.results.get(i) == Result.TRUE) numberOfVerifiedWithProB++;
			 
			 if(this.results.get(i) == Result.FALSE) numberOfProBDisproved++;
			 
			 if(this.results.get(i) == Result.ERROR) numberOfProBErrors++;
			 
			 
		}
		 
		res.append( "\"Number of verified with AtelierB:"+this.numberOfVerifiedWithAtelierB+"\",\""+
					"Number Of verified with A telierB not automatically:"+this.numberOfVerifiedWithAtelierBNotAutomaticly+"\",\""+
					"Number of verified with ProB automatically:"+this.numberOfVerifiedWithProB+"\",\""+
					"Number of ProB disproved:"+this.numberOfProBDisproved+"\",\""+
					"Number of ProB errors:"+this.numberOfProBErrors+"\",\"" +
					"Number of total POs:"+ this.proofObligation.size()+"\""
					+"\n" );
		
	//TODO: Create some statics to put in the report automatically
	//For example: how many were verified ? 
	//how many were verified but are not verified with atelierB


	//TODO: compare the time with krt of each proof obligation
		
		Control.writeFile(pathFile, res.toString());
		//JOptionPane.showMessageDialog(null, pathFile);
		
	}
	
	
	void resetCounters(){
		
		numberOfVerifiedWithAtelierB = 0;
		numberOfVerifiedWithAtelierBNotAutomaticly = 0;
		numberOfVerifiedWithProB = 0;
		numberOfVerified = 0;
		numberOfProBErrors = 0;
		numberOfProBDisproved = 0;
		
	}
	
	
	
	

}
