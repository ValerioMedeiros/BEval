package br.ufrn.forall.b2asm.bintegration.network;

import java.io.Serializable;

public class Requisition implements Serializable{
    
    /**
     * 
     */
    
    private static final long serialVersionUID = 2L;
    
	String provername;
	String proofobligation;
	String result;
	
	public  Requisition(){
		
	}
			
	public  Requisition(	String provername,	String proofobligation,	String result) {
		
		this.provername= provername;
		this.proofobligation = proofobligation;
		this.result = result;
		
	}
	
	public String getProvername() {
		return provername;
	}
	public void setProvername(String provername) {
		this.provername = provername;
	}
	public String getProofobligation() {
		return proofobligation;
	}
	public void setProofobligation(String proofobligation) {
		this.proofobligation = proofobligation;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	

	
}
