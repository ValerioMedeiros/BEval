package br.ufrn.forall.b2asm.beval.pos;

import java.io.File;
import java.io.IOException;

import javax.swing.JTextArea;

import org.junit.Before;
import org.junit.Test;

import br.ufrn.forall.b2asm.beval.core.Control;
import br.ufrn.forall.b2asm.beval.core.GeneralPreferences;
import br.ufrn.forall.b2asm.beval.core.Report;

public class ControlTest {
	
	/*TODO 
	 * Update this tests to using with MAVEN after an update
	 */

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
	}
	

	@Test
	public void test2Local() throws IOException {

		//runTwoStrategies("POWER.mch");
		//runTwoStrategies("POWER2.mch"); // OK full proof obligation without
										// -init -
										// Result very fast
		//runTwoStrategies("BIT_DEFINITION.mch"); // OK full proof obligation
		 								// without -init - Result very fast

		//runTwoStrategies("BYTE_DEFINITION.mch"); // Timeouts full proof
		// obligation without -init - Result very slow
		// Probaly, the stack of hypothesis is very larger causing problems to
		// verify

		// runTwoStrategies("BV16_DEFINITION.mch");
		// runTwoStrategies("UCHAR_DEFINITION.mch");
		// runTwoStrategies("SCHAR_DEFINITION.mch");
		// runTwoStrategies("USHORT_DEFINITION.mch");
		// runTwoStrategies("SSHORT_DEFINITION.mch");
		 runTwoStrategies("TYPES.mch");
	}
	
	public void runTwoStrategies(String filename) throws IOException{
		Report reportOnlyGoal = new Report();
		Report reportFullGoal = new Report();
		runIndividual(reportOnlyGoal, filename, false);
		//runIndividual(reportFullGoal, filename, true);
		
		reportOnlyGoal.print(pathTestDirectory + filename+ "LH_REPORT.csv");
		reportFullGoal.print(pathTestDirectory + filename+ "FG_REPORT.csv");
	}
	
	/**
	 * This methods evaluate proof obligations of one module
	 * @param report
	 * @param filename
	 * @param isFullProofObligation - when true create a full proof obligation, otherwise, create a parcial proof obligation
	 * @throws IOException
	 */

	public void runIndividual(Report report ,String filename, boolean isFullProofObligation)
			throws IOException {

		
		String pathBModule = pathTestDirectory + filename;
		//String pathProBcli = "/Users/valerio/Myprograms/ProB/probcli";
		String pathProBcli = GeneralPreferences.getPathProbcli();
		String parameters = new String();
		
		if (isFullProofObligation) { 
			parameters +=  "-p SYMBOLIC TRUE "; // expands only the concepts needed
					
		}else{
			// Only the goal
			parameters = pathBModule + " -init "; // With initilialization
		}
		
		
		parameters +=  
				" -p BOOL_AS_PREDICATE TRUE "
				+ " -p CLPFD TRUE"
				+ " -p MAXINT 65536 " // + "-p MAXINT 65536 "
				+ " -p MININT -32768 " // + "-p MININT -65536 "
				+ " -p TIME_OUT 10000 ";   // 7000 = 35000ms  ; 2000 = 10000ms ; 1000 = 5000ms; 

		

		Control control = new Control();
		JTextArea ps = new JTextArea();
		
		//control.callProbLogicEvaluatorModule(null,ps,pathProBcli, parameters, isFullProofObligation, report, pathBModule+".out",false);
		
		

	}


}
