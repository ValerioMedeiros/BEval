package br.ufrn.forall.b2asm.beval.pos;

import static org.junit.Assert.*;

import java.io.File;
import java.io.IOException;
import org.junit.Before;
import org.junit.Test;

import br.ufrn.forall.b2asm.beval.pos.POs;

public class POsTestHypo {
	


	private String pathTestDirectory;
	private String current;
	
	@Before
	public void setUp() throws IOException {
	current = new java.io.File(".").getCanonicalPath();

	pathTestDirectory = current + File.separator + "src"
			+ File.separator + "test" + File.separator + "resources"
			+ File.separator + "br" + File.separator + "ufrn"
			+ File.separator + "forall" + File.separator + "b2asm"
			+ File.separator + "beval" + File.separator + "pos"
			+ File.separator;
	
	/*
	PrintStream out = new PrintStream (new FileOutputStream(pathTestDirectory+"ConsoleOut.txt"));
	PrintStream outError = new PrintStream (new FileOutputStream(pathTestDirectory+"ConsoleOutError.txt"));
	System.setOut(out);
	System.setErr(outError);*/
	
	
	}
	
	
	
	@Test
	public void testePMM() throws Exception {
		
		String pathBModule = new String(pathTestDirectory+File.separator+"BIT_DEFINITION.mch");
		
		//String pathBModule = new String(pathTestDirectory+	File.separator+"TYPES.mch");
		
		POs pos = new POs((pathBModule.substring(0, pathBModule.length() - 4) ),false);
		
		System.out.println( "-----------------------------------");
		//TODO: Create or find the method to create the user pass and specific rule.
		
		//pos.addOneRuleInPMMFile(false,  "rule", "expressionName",  1000L );
		System.out.println(pos.getNameAndNumberOfProofObligations()[0]);
		System.out.println(pos.getNameAndNumberOfProofObligations()[1]);
		System.out.println(pos.getNameAndNumberOfProofObligations()[2]);
		//System.out.println("OK"+ pos.getCleanExpandedProofObligations(9));
		//System.out.println("OK"+ pos.getCleanProofObligationsWithLocalHypotheses(9));
		//assertTrue("OK", pos.getProofObligationsWithLocalHypotheses(71).contains("`Check assertion (byte_uchar: BYTE >->> UCHAR) deduction - ref 3.2, 4.2, 5.3'") && pos.getProofObligationsWithLocalHypotheses(71).contains("(ran(byte_uchar) = UCHAR)"));
		
		
	}

	
	
	
	public void testPMM() throws Exception {
		
		//String pathBModule = new String(pathTestDirectory+"bdp"+File.separator+"BIT_DEFINITION.mch");
		
		String pathBModule = new String(pathTestDirectory+	File.separator+"TYPES.mch");
		
		POs pos = new POs((pathBModule.substring(0, pathBModule.length() - 4) ),false);
		
		System.out.println( "-----------------------------------");
		//TODO: Create or find the method to create the user pass and specific rule.
		
		pos.addOneRuleInPMMFile(false,  "rule", "expressionName",  1000L );

		assertTrue("OK", pos.getProofObligationsWithLocalHypotheses(1).contains("`Check assertion (sshort_ushort = ushort_sshort~) deduction - ref 3.2, 4.2, 5.3'") && pos.getProofObligationsWithLocalHypotheses(1).contains("(sshort_ushort = ushort_sshort~)"));
		assertTrue("OK", pos.getProofObligationsWithLocalHypotheses(71).contains("`Check assertion (byte_uchar: BYTE >->> UCHAR) deduction - ref 3.2, 4.2, 5.3'") && pos.getProofObligationsWithLocalHypotheses(71).contains("(ran(byte_uchar) = UCHAR)"));
		
		
	}
	
	
}
