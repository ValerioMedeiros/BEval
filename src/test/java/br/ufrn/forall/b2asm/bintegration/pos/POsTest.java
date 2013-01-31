package br.ufrn.forall.b2asm.bintegration.pos;

import static org.junit.Assert.*;

import java.io.File;
import java.io.IOException;

import org.junit.Test;

import br.ufrn.forall.b2asm.bintegration.core.Control;
import br.ufrn.forall.b2asm.bintegration.core.Report;
import br.ufrn.forall.b2asm.bintegration.core.StreamGobbler.Result;

public class POsTest {
	
	@Test
	public void test2Local() throws IOException {
		
		//runIndividual("POWER.mch");
		//runIndividual("POWER2.mch");
		runIndividual("BIT_DEFINITION.mch"); // It has errors
		//runIndividual("BYTE_DEFINITION.mch");
		//runIndividual("BV16_DEFINITION.mch");
		//runIndividual("UCHAR_DEFINITION.mch");
		//runIndividual("SCHAR_DEFINITION.mch");
		//runIndividual("USHORT_DEFINITION.mch");
		//runIndividual("SSHORT_DEFINITION.mch");
	}

	
	public void runIndividual(String filename) throws IOException {

		String current = new java.io.File(".").getCanonicalPath();

		String pathTestDirectory = current + File.separator + "src"
				+ File.separator + "test" + File.separator + "resources"
				+ File.separator + "br" + File.separator + "ufrn"
				+ File.separator + "forall" + File.separator + "b2asm"
				+ File.separator + "bintegration" + File.separator + "pos"
				+ File.separator;
		
		String pathFile = pathTestDirectory+filename;
		String pathProBcli = "/Users/valerio/Myprograms/ProB/probcli";
		String parameters =  pathFile+" -init -p BOOL_AS_PREDICATE TRUE "
				+ "-p CLPFD TRUE "
				+ "-p MAXINT 256 " //+ "-p MAXINT 65536 "
				+ "-p MININT 0 "	 //+ "-p MININT -65536 "
				+ "-p TIME_OUT 17000 ";

		System.out.println();

		POs po = new POs((pathFile.substring(0, pathFile.length()-3)+"po").replaceFirst("pos"+File.separator, "pos"+File.separator+"bdp"+File.separator));

		

		
		Report report;
			
		report = Control.callProbLogicEvaluator(pathProBcli,parameters, po);
			
		report.print(pathFile+".csv");
		

	}
	
	
}
