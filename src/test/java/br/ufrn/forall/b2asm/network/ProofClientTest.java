package br.ufrn.forall.b2asm.network;

import static org.junit.Assert.*;

import org.junit.Test;

import br.ufrn.forall.b2asm.network.client.ProofClient;
import br.ufrn.forall.b2asm.network.server.ProofServer;

public class ProofClientTest {

	@Test
	public void test() {
		
		//ProofServer serv = new ProofServer();
		
		ProofClient maintrhead = new ProofClient("(= 1 1)");
		
		System.out.print(maintrhead.proveRemotely());

		test();
		fail("Not yet implemented");
		
		
	}

}


	 
