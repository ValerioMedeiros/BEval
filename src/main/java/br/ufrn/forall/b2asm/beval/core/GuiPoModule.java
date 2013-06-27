package br.ufrn.forall.b2asm.beval.core;

import java.awt.EventQueue;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;

import javax.sound.sampled.ReverbType;
import javax.swing.DefaultListModel;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.SwingUtilities;

import net.miginfocom.swing.MigLayout;
import br.ufrn.forall.b2asm.beval.core.Report.POWD;
import br.ufrn.forall.b2asm.beval.core.Report.PoGenerated;
import br.ufrn.forall.b2asm.beval.core.StreamGobbler.Result;
import br.ufrn.forall.b2asm.beval.pos.POs;
import br.ufrn.forall.b2asm.utils.AutoDismiss;

import javax.swing.event.ChangeListener;
import javax.swing.event.ChangeEvent;

/**
 * This class contains the graphic elements
 * 
 * @author valerio
 * 
 */

public class GuiPoModule extends JFrame {

	JFrame frame;
	final Control control;
	private final JCheckBox chckbxPoWD = new JCheckBox("W. D. P. O.");
	private final JButton btnEval = new JButton("Eval");
	private final JTextArea actualParameters = new JTextArea();
	private final JScrollPane scrollActualParameters = new JScrollPane(actualParameters);

	private final JLabel lblParametersOfFile = new JLabel(
			"Parameters");
	private final JLabel lblExpressionToEvaluate = new JLabel(
			"Proof Obligations");
	private  JList list ;
	private final JCheckBox checkBoxKokod = new JCheckBox("Kodkod");
	private final JCheckBox checkBoxSmt = new JCheckBox("Smt");
	private final JCheckBox checkBoxInitialiseModule = new JCheckBox("Initialise");
	private final JCheckBox checkBoxHypothesis = new JCheckBox("Only first hypothesis");
	private final JTextArea textArea = new JTextArea();
	private PrintStream ps;
	private DefaultListModel listModel=new DefaultListModel();
	private final JLabel label = new JLabel("Results");
	private final JCheckBox ignoreHash = new JCheckBox("Ignore hash collisions");
	
	

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {

		for (String s : args)
			System.out.println(s);

		final Control control = new Control();

		control.setModuleArgs(args);

		control.loadConfig();

		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {

					GuiPoModule window = new GuiPoModule(control);
					window.frame.setVisible(true);

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});

	}

	/**
	 * Create the application.
	 */
	public GuiPoModule(Control control) {

		this.control = control;
		try {
			initialize();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * Initialize the contents of the frame.
	 * @throws Exception 
	 */
	private void initialize() throws Exception {
		
		frame = new JFrame(Installation.softwareName);
		frame.setTitle(" ("+control.getModuleName()+") "+Installation.softwareName+" - Project B2ASM ");
		frame.setLocationRelativeTo(null);
		frame.setBounds(new Rectangle(702, 439));
		frame.setLocationRelativeTo(null);// center the window
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		//TODO: Move part of this commands to Control
		// Create some items to add to the list
		control.setIsWD(chckbxPoWD.isSelected()); //TODO: Its is really needed here ?
		
		String	listData [] = control.getStateAndNameOfProofObligations();
		int indicesSelected [] = new int [listData.length];
		//Initialise
		for(int i = 0; i < indicesSelected.length; ++i)indicesSelected[i] = -1;
		
		for (int i=0; i<listData.length; i++) {
			listModel.addElement(listData[i]);
			if(!control.isProvedTheProofState(i+1)){
				indicesSelected[i]=i;
			}
		}
		
		list=new JList(listModel);
		list.setSelectedIndices(indicesSelected);

		
		frame.getContentPane().setLayout(new MigLayout("", "[-25.00][214.00,grow][122.00][195.00,grow][:215.00:200.00]", "[][][][][][31.00][-9.00][grow][grow][][][][][][26.00][grow][]"));

		frame.getContentPane().add(lblParametersOfFile, "cell 1 0");

		actualParameters.setLineWrap(true);
		actualParameters.setText(control.getCommand().toString());
		frame.getContentPane().add(scrollActualParameters, "cell 1 1 3 4,grow");

		addEventsIncheckBox();
		
		textArea.setEditable(false);
		
		//Setting the output to TextArea        
        redirectSystemStreams();
		
        //frame.getContentPane().add(ignoreHash, "cell 4 1");
        
        //frame.getContentPane().add(forgetStateSpace, "cell 4 1");
        
        frame.getContentPane().add(checkBoxKokod, "cell 4 1");
		
		frame.getContentPane().add(checkBoxSmt, "cell 4 2");
		checkBoxInitialiseModule.setSelected(true);
		
		frame.getContentPane().add(checkBoxInitialiseModule, "cell 4 3");
		checkBoxHypothesis.setSelected(true);
		
		frame.getContentPane().add(checkBoxHypothesis, "cell 4 4");

		frame.getContentPane().add(lblExpressionToEvaluate, "cell 1 5");
		
		frame.getContentPane().add(label, "cell 2 5");
		
		frame.getContentPane().add(new JScrollPane(list), "cell 1 7 1 8,grow");
		
		frame.getContentPane().add(new JScrollPane(textArea), "cell 2 7 3 8,grow");
		
		chckbxPoWD.addItemListener(new ItemListener() {
			public void itemStateChanged(ItemEvent arg0) {
				
			 
					try {
						control.setIsWD(chckbxPoWD.isSelected());
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				 
				
					// Create some items to add to the list
					String	listData [] = control.getStateAndNameOfProofObligations();
					listModel.removeAllElements();
					//Initialise
					int indicesSelected [] = new int [listData.length];
					for(int i = 0; i < indicesSelected.length; ++i)indicesSelected[i] = -1;
					for (int i=0; i<listData.length; i++) {
						listModel.addElement(listData[i]);
						if(!control.isProvedTheProofState(i+1)){
							indicesSelected[i]=i;
						}
					}
					list.setSelectedIndices(indicesSelected);
					
				 
			
			}
		});
		

		frame.getContentPane().add(chckbxPoWD,
				"cell 1 16,alignx center,aligny center");
		
		
		

		btnEval.addActionListener(new ActionListener() {

			public void actionPerformed(ActionEvent arg0) {

				Report report = new Report();
				
				int numberOftotalPOs = control.getNumberOfProofObligations();
				
				int [] selectedItens = list.getSelectedIndices();
				int countSelected=0;
				//TODO: Move this method of commands to Control class
				for (int numberPo = 1; numberPo <= numberOftotalPOs; numberPo++) {
					
					if( countSelected<selectedItens.length && selectedItens[countSelected]==numberPo-1){
						countSelected++;
						String proofObligation;
						if(checkBoxHypothesis.isSelected())
							proofObligation = control.getCleanProofObligationsWithLocalHypotheses(numberPo);
						else
							proofObligation = control.getGoalOfCleanExpandedProofObligations(numberPo);
						
						int res = control.callProbLogicEvaluator(true, false, report, numberPo , actualParameters.getText(),  proofObligation);
						
						AutoDismiss.showMessageDialog(null, "Progress "+ countSelected+"/"+selectedItens.length+"\n"
							+"The result is "+control.getResult()+"\n"
							+proofObligation  ,1000); 
						
						System.out.println("\nThe result is "+ control.getResult()+" and progress "+ countSelected+"/"+selectedItens.length+"\n");
						textArea.repaint();
						frame.validate();
						frame.repaint();
					}
				}
				control.writeUpdatedPMM();
				  
				report.print( control.pathBModuleInBdpFolderWithoutExtension+"_report.csv");
				System.out.println("A report was generated in :"+control.pathBModuleInBdpFolderWithoutExtension+"_report.csv");
			}
		});

		frame.getContentPane().add(btnEval, "cell 4 16,alignx right");
	}

	private void addEventsIncheckBox() {

		checkBoxKokod.addItemListener(new ItemListener() {
			public void itemStateChanged(ItemEvent e) {
				String parameterToConfig = new String(" -p KODKOD TRUE \n");

				if (((JCheckBox) e.getItem()).isSelected())
					actualParameters.setText(parameterToConfig
							+ actualParameters.getText().replaceAll(
									parameterToConfig, ""));
				else {
					actualParameters.setText(actualParameters.getText().replaceAll(
							parameterToConfig, ""));
				}
			}
		});

		checkBoxInitialiseModule.addItemListener(new ItemListener() {
			public void itemStateChanged(ItemEvent e) {
				String parameterToConfig = new String(control.getModulePath()
						+ " -init ");

				if (((JCheckBox) e.getItem()).isSelected())
					actualParameters.setText(parameterToConfig
							+ actualParameters.getText().replaceAll(
									parameterToConfig, ""));
				else {
					actualParameters.setText(actualParameters.getText().replaceAll(
							parameterToConfig, ""));
				}
			}
		});

		checkBoxSmt.addItemListener(new ItemListener() {
			public void itemStateChanged(ItemEvent e) {
				String parameterToConfig = new String(" -p SMT TRUE ");

				if (((JCheckBox) e.getItem()).isSelected())
					actualParameters.setText(parameterToConfig
							+ actualParameters.getText().replaceAll(
									parameterToConfig, ""));
				else {
					actualParameters.setText(actualParameters.getText().replaceAll(
							parameterToConfig, ""));
				}
			}
		});

	}
	
	private void updateTextArea(final String text) {
		  SwingUtilities.invokeLater(new Runnable() {
		    public void run() {
		      textArea.append(text);
		    }
		  });
	}
		 
	private void redirectSystemStreams() {
		  OutputStream out = new OutputStream() {
		    @Override
		    public void write(int b) throws IOException {
		      updateTextArea(String.valueOf((char) b));
		    }
		 
		    @Override
		    public void write(byte[] b, int off, int len) throws IOException {
		      updateTextArea(new String(b, off, len));
		    }
		 
		    @Override
		    public void write(byte[] b) throws IOException {
		      write(b, 0, b.length);
		    }
		  };
		 
		  System.setOut(new PrintStream(out, true));
		  System.setErr(new PrintStream(out, true));
	}


}
