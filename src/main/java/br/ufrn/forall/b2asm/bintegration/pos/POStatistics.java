package br.ufrn.forall.b2asm.bintegration.pos;

import br.ufrn.forall.b2asm.bintegration.core.Control;

public class POStatistics {
	
	private String pathFile;
	
	private String original;

	private String[] theoriesSplittedsRead;

	private String balanceXRead;

	private String proofStateRead;

	private String methodListRead;

	private String passListRead;
	
	/**
	 * This constructor receives a file "*.pmi" from bdp.
	 * @param pathFile
	 */
	POStatistics(String pathFile){

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
		
	//	loadProofState();
		
		
		
	}
	
	
	

}
