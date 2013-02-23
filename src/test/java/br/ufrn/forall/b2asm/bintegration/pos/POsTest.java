package br.ufrn.forall.b2asm.bintegration.pos;

import static org.junit.Assert.*;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.util.List;

import org.junit.Before;
import org.junit.Test;

import br.ufrn.forall.b2asm.bintegration.core.Control;
import br.ufrn.forall.b2asm.bintegration.core.Report;
import br.ufrn.forall.b2asm.bintegration.core.StreamGobbler.Result;

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
	public void test2Local() throws IOException {
		
		String pathBModule = new String(pathTestDirectory+"bdp"+File.separator+"BIT_DEFINITION.mch");
		
		POs expressionsToEvaluate = new POs((pathBModule.substring(0,
				pathBModule.length() - 3) + "po"));
		
		System.out.println( expressionsToEvaluate.getCleanProofObligationsWithLocalHypotheses(1));

	}
	
	
}
