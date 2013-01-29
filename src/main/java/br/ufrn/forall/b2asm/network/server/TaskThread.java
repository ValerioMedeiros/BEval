package br.ufrn.forall.b2asm.network.server;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;

import br.ufrn.forall.b2asm.bintegration.network.Requisition;

public class TaskThread extends Thread {

	private Socket connection;
	private static int count=0;
	ObjectOutputStream objoutstream;
	ObjectInputStream objinstream;


	public TaskThread(Socket s) {
		connection = s;

	} 

	public void run() {


		try {

			Requisition req_received,req_answer;

			// objetos que permitem controlar fluxo de comunicação

			this.objoutstream = new ObjectOutputStream(connection.getOutputStream() );
			this.objinstream = new ObjectInputStream(connection.getInputStream() );


			System.out.println("Receiving proof obligation...");

			req_received = (Requisition) this.objinstream.readObject();


			System.out.println("The prover is working");


			req_answer = this.callprover(req_received);



			this.objoutstream.writeObject(req_answer);

			System.out.println("Answer sended!");
			
			this.connection.close();
			


		}


		catch (Exception e) {


			e.printStackTrace();
		}


	}

	protected Requisition callprover(Requisition req) {
		
		Requisition req_answer = new Requisition();
		
		StringBuffer output = new StringBuffer();
		
		String path_po_file = new String(java.lang.System.getProperty("java.io.tmpdir") + File.separator+"proof"+(count++)+".smt");


		
		
		// write the proof obligation to file
		try{

			FileWriter fstream = new FileWriter(path_po_file);
			BufferedWriter out = new BufferedWriter(fstream);
			out.write(req.getProofobligation());
			out.close();
		} catch (IOException e) {
			System.err.println("Error writing the file from proof obligation.");
		}

		
		
		// call the prover  

		try {
			String[] tmp = req.getProvername().split(" ");
			
			String [] commands = new String[ tmp.length + 1 ];
			for(int i=0;i<tmp.length;i++)
				commands[i]=tmp[i];
			commands[tmp.length]=path_po_file;
			
			
			//String[] commands = new String[]{req.getProvername().split(" "),path_po_file };
			//System.out.println("Comando executado"+req.getProvername());
			Process child = Runtime.getRuntime().exec(commands);

			// Get the input stream and read from it
			System.out.println("Waiting answer!");

			InputStream in = child.getInputStream();
			int c;

			while ((c = in.read()) != -1) {
				output.append((char)c);
			}
			in.close();



		} catch (IOException e) {
			System.err.println("Error calling the prover!");
		}


		req_answer.setResult( new String( output.toString()) ); 


		return req_answer;

	}

}
