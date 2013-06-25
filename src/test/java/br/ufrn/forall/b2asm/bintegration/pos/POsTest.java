package br.ufrn.forall.b2asm.bintegration.pos;

import static org.junit.Assert.*;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.util.List;

import org.junit.Before;
import org.junit.Test;

import br.ufrn.forall.b2asm.beval.core.Control;
import br.ufrn.forall.b2asm.beval.core.Report;
import br.ufrn.forall.b2asm.beval.core.StreamGobbler.Result;
import br.ufrn.forall.b2asm.beval.pos.POs;

public class POsTest {
	


	private String pathTestDirectory;
	private String current;
	
	@Before
	public void setUp() throws IOException {
	current = new java.io.File(".").getCanonicalPath();

	pathTestDirectory = current + File.separator + "src"
			+ File.separator + "test" + File.separator + "resources"
			+ File.separator + "br" + File.separator + "ufrn"
			+ File.separator + "forall" + File.separator + "b2asm"
			+ File.separator + "bintegration" + File.separator + "pos"
			+ File.separator;
	
	/*
	PrintStream out = new PrintStream (new FileOutputStream(pathTestDirectory+"ConsoleOut.txt"));
	PrintStream outError = new PrintStream (new FileOutputStream(pathTestDirectory+"ConsoleOutError.txt"));
	System.setOut(out);
	System.setErr(outError);*/
	
	
	}
	
	@Test
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
	
	@Test
	public void test2Local() throws Exception {
		

		String pathBModule = new String(pathTestDirectory+	File.separator+"Z80.mch");
		
		POs pos = new POs((pathBModule.substring(0, pathBModule.length() - 4) ),false);
		
		System.out.println( "-----------------------------------");
		//TODO: Create or find the method to create the user pass and specific rule.
		assertTrue("OK",pos.getProofObligationsWithLocalHypotheses(1).contains("({1|->id_reg_8|->[1,1,1,1,1,1,1,1]}\\/{2|->id_reg_8|->[1,1,1,1,1,1,1,1]}\\/{3|->id_reg_8|->[1,1,1,1,1,1,1,1]}\\/{4|->id_reg_8|->[1,1,1,1,1,1,1,1]}\\/{5|->id_reg_8|->[1,1,1,1,1,1,1,1]}\\/{6|->id_reg_8|->[1,1,1,1,1,1,1,1]}\\/{7|->id_reg_8|->[1,1,1,1,1,1,1,1]}\\/{8|->id_reg_8|->[1,1,1,1,1,1,1,1]}\\/{9|->id_reg_8|->[1,1,1,1,1,1,1,1]}\\/{10|->id_reg_8|->[1,1,1,1,1,1,1,1]}\\/{11|->id_reg_8|->[1,1,1,1,1,1,1,1]}\\/{12|->id_reg_8|->[1,1,1,1,1,1,1,1]}\\/{13|->id_reg_8|->[1,1,1,1,1,1,1,1]}\\/{14|->id_reg_8|->[1,1,1,1,1,1,1,1]}\\/{15|->id_reg_8|->[1,1,1,1,1,1,1,1]}\\/{16|->id_reg_8|->[1,1,1,1,1,1,1,1]}: (1..16)*{id_reg_8} +-> BYTE)"));
		//System.out.println( pos.getProofObligationsWithLocalHypotheses(1));
		assertTrue("OK",pos.getProofObligationsWithLocalHypotheses(489).contains("\"`Check that the invariant (rgs8: id_reg_8 --> BYTE) is preserved by the operation - ref 3.4'\"\n") && pos.getProofObligationsWithLocalHypotheses(489).contains("(dom(rgs8<+{aa|->value}) = (1..16)*{id_reg_8})"));	  
		
		//System.out.println( pos.getProofObligationsWithLocalHypotheses(489));

	}
	
	
}
