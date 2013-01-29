package br.ufrn.forall.b2asm.network.client;

import java.io.BufferedInputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.util.ArrayList;

import br.ufrn.forall.b2asm.bintegration.core.Installation;
import br.ufrn.forall.b2asm.bintegration.network.Requisition;


public class ProofClient  /*implements Runnable*/ {
	
	ArrayList <Thread> listofTrhead = new ArrayList<Thread>();    
	ArrayList <String> listofServer = new ArrayList<String>();
    File file = new File(Installation.class.getProtectionDomain().getCodeSource().getLocation().getPath()
			.replaceFirst("/bin","/").replaceAll(Installation.filenameJar, "")+"Servers.txt");
    FileInputStream fis = null;
    BufferedInputStream bis = null;
    DataInputStream dis = null;
    String proofobligation;
    String result;
    
	public static void main(String[] args) {
		
		ProofClient maintrhead = new ProofClient("(= 1 1)");
		
		System.out.print(maintrhead.proveRemotely());
		 
	}

	public  ProofClient(String proofobligation) {
		
		this.proofobligation = proofobligation;
		
    }

	
	public synchronized  String proveRemotely()  {
		
	    try {
	    	System.out.print(file.getAbsolutePath());
		      
	    	  fis = new FileInputStream(file);

		      // Here BufferedInputStream is added for fast reading.
		      bis = new BufferedInputStream(fis);
		      dis = new DataInputStream(bis);

		      // dis.available() returns 0 if the file does not have more lines.
		      while (dis.available() != 0) {

		      // this statement reads the line from the file, create a requisition, send this requisition to remote theorem prover and 
		      // print the answer
		      // the console.
		    	  
		    	  String[] result = dis.readLine().split("@");
		    	  
		    	  Requisition req =new Requisition( new String(result[0]),proofobligation,new String(""));

		    	  Thread t = new Conection(result[1],req, this);
		    	  //System.out.println("Path e param:"+result[0] +"host"+result[1]+"FIM");
		    	  
				  t.start();
					
				  listofTrhead.add(t);
		    	 	
		    

		      }

		      

		      // dispose all the resources after using them.
		      fis.close();
		      bis.close();
		      dis.close();

		    } catch (FileNotFoundException e) {
		      e.printStackTrace();
		    } catch (IOException e) {
		      e.printStackTrace();
		    }


		    try {
		    	
				this.wait() ;
				
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				
				e.printStackTrace();
				
				System.err.println("This program can't wait");
				
			}
		    
		    
			//System.out.println("Resultado:"+result);

		    
		return result;
		
		
		
	}
	
	
	public  synchronized void stopOthers(Object obj){
		
		int size = listofTrhead.size();
		
		for (int count = 0 ;  count < size ; count++ )
			if(listofTrhead.get(count)!= obj)				
				listofTrhead.get(count).stop();
		
		this.result = new String (((Conection) obj).req.getResult());
		
		
		
	}

	  
	 class Conection extends Thread{ 

		Socket socket;
	    ObjectOutputStream objoutstream ;
	    ObjectInputStream objinstream;
	    String hostname; 
	    Requisition req;
	    ProofClient father;
	    
	    
		
		public  Conection(String hostname, Requisition req, ProofClient father){
			this.hostname = hostname; 
		    this.req = req;
		    this.father = father;
			
		}
		
		public void run(){
			
			 Requisition req_answer=null;
			  
	        try{
	        		socket = new Socket(hostname, 2525);
	        		
	                this.objinstream = new ObjectInputStream(socket.getInputStream() );
	                this.objoutstream = new ObjectOutputStream(socket.getOutputStream() );
     
	                System.out.println("Sending the proof obligation");
	                
	                objoutstream.writeObject((Requisition) req);
	                
	                System.out.println("Waiting answer");
	                
	                req_answer = (Requisition) objinstream.readObject();
	                
	                /*System.out.println(req_answer.getProvername());
	                System.out.println(req_answer.getProofobligation());
	                System.out.println(req_answer.getResult());*/
	                
	                req_answer = new Requisition("","",req_answer.getResult() );
	        
	                req.setResult(req_answer.getResult());
	                
	                father.result = req_answer.getResult();
	                
	                synchronized(father) {father.notify(); father.stopOthers(this);  }
	                
	                
	                //System.out.println("Result"+req.getResult() );
	        }catch (Exception e) {

	        		System.err.println("Cannot call the remote prover.");
	                e.printStackTrace();
	        }
			

			
		}
	 }




}

