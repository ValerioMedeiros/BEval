package br.ufrn.forall.b2asm.bintegration.core;

import java.util.ArrayList;
import java.util.List;

import br.ufrn.forall.b2asm.bintegration.core.StreamGobbler.Result;

public class Report {
	int size=0;
	List <Long> times = new ArrayList<Long>();;
	List <Result> results= new ArrayList<Result>();
	List <Result> outputsError= new ArrayList<Result>();
	List <Integer> PoNumber= new ArrayList<Integer>();
	List <String> proofStatePmiFile= new ArrayList<String>();
	
	
	void add(int numberPo,String proofStatePmiFile, Result outputError, Result result, Long time){
		this.times.add(time);
		this.results.add(result);
		this.outputsError.add(outputError);
		this.proofStatePmiFile.add(proofStatePmiFile);
		this.PoNumber.add(numberPo);
		size++;
	}
	
	public void print(String pathFile){
		StringBuffer res = new StringBuffer();
		
		for(int i=0;i<size;i++){
		
			 res.append( "\""+this.PoNumber.get(i) +"\",\""+  this.proofStatePmiFile.get(i)  +"\",\""+ this.outputsError.get(i) +"\",\""+  this.results.get(i) +"\",\""+ this.times.get(i)+"\"\n" );
			
		}
		
		Control.writeFile(pathFile, res.toString());
		
	}
	
	
	
	

}
