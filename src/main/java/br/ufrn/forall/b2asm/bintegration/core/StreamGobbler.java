package br.ufrn.forall.b2asm.bintegration.core;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;


/**
 * 
 * @author Michael C. Daconta, JavaWorld.com, 12/29/00
 * @see http://www.javaworld.com/javaworld/jw-12-2000/jw-1229-traps.html?page=4 
 * The following code is public and licensed under BSD license:
 * https://code.google.com/p/jmkvpropedit/source/browse/trunk/src/com/googlecode/jmkvpropedit/StreamGobbler.java?r=329df04f655dbd35ccbeda4336a6f7e3c1669a4d
 */


public class StreamGobbler extends Thread
{
	InputStream is;
	String type;
	OutputStream os;

	public enum Result {
		INITIAL, ERROR, TIME_OUT, TRUE, FALSE, NOT_WELL_DEFINED}

	Result result= Result.INITIAL;

	StreamGobbler(InputStream is, String type)
	{
		this(is, type, null);
	}
	StreamGobbler(InputStream is, String type, OutputStream redirect)
	{
		this.is = is;
		this.type = type;
		this.os = redirect;
	}




	public void run()
	{
		try
		{
			PrintWriter pw = null;
			if (os != null)
				pw = new PrintWriter(os);

			InputStreamReader isr = new InputStreamReader(is);
			BufferedReader br = new BufferedReader(isr);
			String line=null;
			while ( (line = br.readLine()) != null)
			{
				if (pw != null)
					pw.println(line);

				if( result == Result.INITIAL){
					if (line.contains("is TRUE"))
						result= Result.TRUE;
					else if (line.contains("NOT-WELL-DEFINED"))
						result= Result.NOT_WELL_DEFINED;	
					else if (line.contains("is FALSE"))
						result= Result.FALSE;
					else if (line.contains("expecting ")){
						result= Result.ERROR;
					}
					else if (line.contains("TIME-OUT occured")){
						result= Result.TIME_OUT;
					}
					else if (line.contains("Not a valid")){
						result= Result.ERROR;
					}
				}

				System.out.println(type + ">" + line);

			}
			if (pw != null)
				pw.flush();
		} catch (IOException ioe)
		{
			ioe.printStackTrace();  
		}
	}



	public Result getResult() {
		return result;
	}
}