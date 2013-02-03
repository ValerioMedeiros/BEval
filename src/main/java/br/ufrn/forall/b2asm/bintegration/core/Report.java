package br.ufrn.forall.b2asm.bintegration.core;

import java.util.ArrayList;
import java.util.List;

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
	List <String> proofObligations = new ArrayList<String>();
	List <String> proofStatePmiFile= new ArrayList<String>();
	
/***
 * This method add an element to report
 * @param numberPo - identifier of proof obligation
 * @param parameters - parameters to calll
 * @param isKindOfWD - enum POWD {Common, WD } - it determines when the proof obligation is WD or common
 * @param pogen - enum PoGenerated {Full, OnlyGoal, SelectedHypotesesAndGoal }
 * @param proofObligation - String with a proof obligation
 * @param proofStatePmiFile - state of verification of AtelierB 
 * @param outputError - state of error output
 * @param result - state of output
 * @param time  - time spent to eval
 */
	/*numberPo,
	parameters,
	POWD.Common,
	PoGenerated.Full,
	proofObligation,ERRO
	errorGobbler.getResult(),
	resultIndividual,ERRO
	localTotalTime*/
	void add(int numberPo,String parameters, POWD isKindOfWD,PoGenerated pogen , String proofObligation,String proofStatePmiFile, Result outputError, Result result, Long time){
		this.times.add(time);
		
		this.parameters.add(parameters);
		this.isKindOfWD.add(isKindOfWD);
		this.poGenerated.add(pogen);
		this.results.add(result);
		this.outputsError.add(outputError);
		this.proofObligations.add(proofObligation);
		this.proofStatePmiFile.add(proofStatePmiFile);
		this.PoNumber.add(numberPo);
		size++;
	}
	
	public void print(String pathFile){
		StringBuffer res = new StringBuffer();
		
		for(int i=0;i<size;i++){
		
			 res.append( "\""+this.PoNumber.get(i) +"\",\""+
					this.parameters.get(i)+"\",\""+
					this.isKindOfWD.get(i)+"\",\""+
					this.poGenerated.get(i)+"\",\""+
					 this.proofObligations.get(i)+"\",\""+
					 this.proofStatePmiFile.get(i)  +"\",\""+ 
					 this.outputsError.get(i) +"\",\""+
					 this.results.get(i) +"\",\""+ 
					 this.times.get(i)+"\"\n" );
			
		}
		
		Control.writeFile(pathFile, res.toString());
		
	}
	
	
	
	

}
