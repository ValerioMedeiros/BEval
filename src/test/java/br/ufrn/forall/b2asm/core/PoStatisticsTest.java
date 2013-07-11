package br.ufrn.forall.b2asm.core;
import static org.junit.Assert.fail;

import java.io.File;
import java.io.IOException;

import javax.swing.JTextArea;

import org.junit.Before;
import org.junit.Test;

import br.ufrn.forall.b2asm.beval.core.Control;
import br.ufrn.forall.b2asm.beval.core.GeneralPreferences;
import br.ufrn.forall.b2asm.beval.core.Report;
import br.ufrn.forall.b2asm.utils.AutoDismiss;


public class PoStatisticsTest {


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

		runTwoStrategies("POWER.mch");
		runTwoStrategies("POWER2.mch"); // OK full proof obligation without
										// -init -
										// Result very fast
		runTwoStrategies("BIT_DEFINITION.mch"); // OK full proof obligation
		 								// without -init - Result very fast

		runTwoStrategies("BYTE_DEFINITION.mch"); // Timeouts full proof
		// obligation without -init - Result very slow
		// Probaly, the stack of hypothesis is very larger causing problems to
		// verify

		 runTwoStrategies("BV16_DEFINITION.mch");
		 runTwoStrategies("UCHAR_DEFINITION.mch");
		 runTwoStrategies("SCHAR_DEFINITION.mch");
		 runTwoStrategies("USHORT_DEFINITION.mch");
		 runTwoStrategies("SSHORT_DEFINITION.mch");
		 runTwoStrategies("TYPES.mch");
	}
	
	public void runTwoStrategies(String filename) throws IOException{
		Report report = new Report();
		
		runIndividual(report, filename, true, false);
		runIndividual(report, filename, true, true);
		
		
	}
	
	/**
	 * This methods evaluate proof obligations of one module
	 * @param report
	 * @param filename
	 * @param onlyLocalHypotheses - when true create a proof obligation with only local hypotheses, otherwise, create a full proof obligation
	 * @param onlyLocalHypotheses - when it is false then common PO; when it is "true" represent one set of well defined POs 
	 * @throws IOException
	 */

	public void runIndividual(Report report ,String filename, boolean onlyLocalHypotheses, boolean isWDPOs)
			throws IOException {

		
		String parameters;
	
		parameters = pathTestDirectory + filename + " -init "; // With initilialization
		parameters +=  "-p SYMBOLIC TRUE "; // expands only the concepts needed
		parameters +=  
				" -p BOOL_AS_PREDICATE TRUE "
			//	+ " -p CLPFD TRUE"  // Maybe it is not usefull because the range is defined below
				+ " -p MAXINT 65536 " // + "-p MAXINT 65536 "
				+ " -p MININT -32768 " // + "-p MININT -65536 "
				+ " -p TIME_OUT 10000 ";   // 7000 = 35000ms  ; 2000 = 10000ms ; 1000 = 5000ms; 1 = 5 millisenconds; 
		
		

		Control control = new Control();
		
		
		try {
			
		
		String [] nameExtension = filename.split("[.]");
						// expressionName , moduleName, modulePath, componentExtension
		String [] args = {"empty", nameExtension[0],pathTestDirectory + filename,nameExtension[1] };
		
		control.setModuleArgs(args);
		
		control.loadConfig(); // To use specific default parameters
		
		control.setIsWD(isWDPOs);  
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//select all proof obligations
		int [] selectedItens = new int [control.getNumberOfProofObligations()];
		for(int i=0;i<control.getNumberOfProofObligations();i++) selectedItens[i]=i;
		
		//parameters = null ; // "null" defines the preferences parameters of Machine
		control.callProbLogicEval_Module(report, parameters ,  onlyLocalHypotheses, selectedItens );
		
		control.writeUpdatedPMM();
		long time = System.currentTimeMillis();
		  
		report.print( pathTestDirectory + filename+"_"+time+"_report.csv");
		System.out.println("A report was generated in :"+pathTestDirectory+filename+"_"+time+"_report.csv");
		
		
		

	}
	
	
	
}
