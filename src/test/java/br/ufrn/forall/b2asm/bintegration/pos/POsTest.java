package br.ufrn.forall.b2asm.bintegration.pos;
import static org.junit.Assert.*;

import java.io.File;
import java.io.IOException;

import org.junit.Test;



public class POsTest {

	@Test
	public void test() throws IOException {
		

				
		String current = new java.io.File( "." ).getCanonicalPath();
		
		String pathTestDirectory = current+File.separator+"src"+File.separator+"test"+File.separator+"resources"+File.separator+"br"+File.separator+"ufrn"+File.separator+"forall"+File.separator+"b2asm"+File.separator+"bintegration"+File.separator+"pos"+File.separator;
		
		System.out.println();
		
		POs po = new POs(pathTestDirectory+"Z80_LogAri.po");
		
		System.out.println( po.getExpandedProofObligations(1));
		
		System.out.println( po.getExpandedProofObligations(54));
		
		System.out.println( po.getCleanExpandedProofObligations(po.getNumberOfProofObligations()));
		
		if(po.getNumberOfProofObligations()!=154) 	fail("Not expanded all proof obligation");
		

		
		POs powd = new POs(pathTestDirectory+"Z80_LogAri_wd.po");
		
		System.out.println(powd.getNumberOfProofObligations());
		
		if(powd.getNumberOfProofObligations()!=493) 	fail("Not expanded all proof obligation");
		
	
	}

}
