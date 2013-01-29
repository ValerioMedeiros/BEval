package br.ufrn.forall.b2asm.network.server;

import java.net.ServerSocket;
import java.net.Socket;
import java.io.IOException;



public class ProofServer {
	
	public static void main(String[] args) {
		 new ProofServer();
		
	}
	
	public ProofServer(){

		try {

			ServerSocket s = new ServerSocket(2525);

			while (true) {

				System.out.println("Waiting clients...");

				Socket conexao = s.accept();

				System.out.println("A new client was conected!");

				Thread t = new TaskThread(conexao);

				t.start();

			}

		}

		catch (IOException e) {
			System.out.println("IOException: " + e);

		}
	}

}
