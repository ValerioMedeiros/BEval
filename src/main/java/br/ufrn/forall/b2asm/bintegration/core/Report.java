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
	List <String> proofStatePmiFile= new ArrayList<String>();
	
	/**
	 * This method add an elemento to report
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
	void add(int numberPo,String parameters, POWD isKindOfWD,PoGenerated pogen , String proofStatePmiFile, Result outputError, Result result, Long time){
		this.times.add(time);
		
		this.parameters.add(parameters);
		this.isKindOfWD.add(isKindOfWD);
		this.poGenerated.add(pogen);
		this.results.add(result);
		this.outputsError.add(outputError);
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
					 
					 this.proofStatePmiFile.get(i)  +"\",\""+ this.outputsError.get(i) +"\",\""+  this.results.get(i) +"\",\""+ this.times.get(i)+"\"\n" );
			
		}
		
		Control.writeFile(pathFile, res.toString());
		
	}
	
	
	
	

}
