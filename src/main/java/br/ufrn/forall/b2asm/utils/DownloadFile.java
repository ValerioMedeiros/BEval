package br.ufrn.forall.b2asm.utils;


import java.awt.event.WindowEvent;
import java.io.BufferedOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.swing.JFrame;
import javax.swing.JProgressBar;
import javax.swing.SwingUtilities;
import javax.swing.WindowConstants;

/**
 * This class just download a file from URL.
 * It is available at:http://stackoverflow.com/questions/22273045/java-getting-download-progress
 * @author slartidan and modified by valerio
 * 
 *
 */
public class DownloadFile {
	static String  [] args;
	
	public static void download(String title, String url, String filename){
		args  = new String [3];
		args[0]= title; //"Downloading the b2llvm"
		args[1]= url; //"https://github.com/ValerioMedeiros/BEval/archive/master.zip"
		args[2]= filename;//"package.zip"
		DownloadFile.main(args);
	}
	
    public static void main(String[] args) {
    	
    	//DownloadFile.args = args;
    	
        final JProgressBar jProgressBar = new JProgressBar();
        jProgressBar.setMaximum(100000);
        final JFrame frame = new JFrame();
        frame.setTitle("Download starting");
        frame.setContentPane(jProgressBar);
        frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        frame.setSize(300, 70);
        frame.setLocationRelativeTo(null);  
        frame.setVisible(true);

        Runnable updatethread = new Runnable() {
            public void run() {
                try {
                	
                	System.out.println("Dowloading from:https://github.com/ValerioMedeiros/BEval/archive/master.zip");
                	
                	 URL url = new URL("https://github.com/ValerioMedeiros/BEval/archive/master.zip");
                     HttpURLConnection httpConnection = (HttpURLConnection) (url.openConnection());
                     long completeFileSize = httpConnection.getContentLength();

                     java.io.BufferedInputStream in = new java.io.BufferedInputStream(httpConnection.getInputStream());
                     java.io.FileOutputStream fos = new java.io.FileOutputStream(
                             "package.zip");
                     java.io.BufferedOutputStream bout = new BufferedOutputStream(
                             fos, 1024);
                     byte[] data = new byte[1024];
                     long downloadedFileSize = 0;
                     int x = 0;
                     while ((x = in.read(data, 0, 1024)) >= 0) {
                         downloadedFileSize += x;

                         // calculate progress
                         final int currentProgress = (int) ((((double)downloadedFileSize) / ((double)completeFileSize)) * 100000d);

                         // update progress bar
                         SwingUtilities.invokeLater(new Runnable() {

                             @Override
                             public void run() {
                                 jProgressBar.setValue(currentProgress);
                             }
                         });

                         bout.write(data, 0, x);
                     }
                     bout.close();
                     in.close();
                     System.out.println("Download finished!");
                   //  frame.dispatchEvent(new WindowEvent(frame, WindowEvent.WINDOW_CLOSING));
                     
                 } catch (FileNotFoundException e) {
                 } catch (IOException e) {
                 }
                
            }
        };
        new Thread(updatethread).

        start();
    }

}