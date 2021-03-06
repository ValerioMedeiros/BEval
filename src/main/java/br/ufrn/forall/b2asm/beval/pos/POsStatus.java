package br.ufrn.forall.b2asm.beval.pos;

import br.ufrn.forall.b2asm.beval.core.Control;

 class POsStatus {
	
	private String pathFile;
	
	private String original;

	private String[] theoriesSplittedsRead, proofStateSplitted;

	private String balanceXRead;

	private String proofStateRead;

	private String methodListRead;

	private String passListRead;
	
	/**
	 * This constructor receives a file "*.pmi" from bdp.
	 * @param pathFile
	 */
	POsStatus(String pathFile){

		this.pathFile = pathFile;

		original = Control.readFile(pathFile);
		
		load();
	}

	void load(){

		theoriesSplittedsRead = original.split("END");
		
		for(int i=0;i<theoriesSplittedsRead.length;i++)
			if(theoriesSplittedsRead[i].contains("THEORY BalanceX IS"))
				balanceXRead = theoriesSplittedsRead[i];
		
		for(int i=0;i<theoriesSplittedsRead.length;i++)
			if(theoriesSplittedsRead[i].contains("THEORY ProofState IS")){
				proofStateRead = theoriesSplittedsRead[i];
				proofStateRead= proofStateRead.replaceFirst("&\nTHEORY ProofState IS", "");
			}
		for(int i=0;i<theoriesSplittedsRead.length;i++)
			if(theoriesSplittedsRead[i].contains("THEORY MethodList IS"))
				methodListRead = theoriesSplittedsRead[i];
		
		for(int i=0;i<theoriesSplittedsRead.length;i++)
			if(theoriesSplittedsRead[i].contains("THEORY PassList IS"))
				passListRead = theoriesSplittedsRead[i];
		
		loadProofState();
		
		
	}
	
	void loadProofState(){
		//JOptionPane.showMessageDialog(null, proofStateRead);
		if(proofStateRead!=null){
			proofStateSplitted = proofStateRead.replaceAll("\n", "").split(";");
		}
	}
	
	void printStates(){
		int proveds=0;
		for(int i=proofStateSplitted.length;i>0;i++){
			if(proofStateSplitted[i-1].contains("Proved"))proveds++;
			System.out.println(proofStateSplitted[i-1]);
		}
		
		System.out.println("Total:"+proofStateSplitted.length+" and Proved:"+proveds);
	}
	
	/**
	 * Returns true, when the proof obligation is evaluated true
	 * @param number enumerating from 1 up to numbers of proof obligations
	 * @return
	 */
	boolean isProvedTheProofState(int number){
		
			return proofStateSplitted[proofStateSplitted.length - number].contains( "Proved");
		
	}
	/**
	 * Returns the state
	 * @param number enumerating from 1 up to numbers of proof obligations
	 * @return
	 */
	String getProofState(int number){
		if(number >=1 & number <= proofStateSplitted.length ) 
			return proofStateSplitted[proofStateSplitted.length -number];
		else return "";
		
	}

}
