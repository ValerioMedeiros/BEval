package br.ufrn.forall.b2asm.bintegration.core;

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
import br.ufrn.forall.b2asm.bintegration.pos.POs;
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
	private final JCheckBox chckbxPoWD = new JCheckBox("P.O. W. D.");
	private final JButton btnEval = new JButton("Eval");
	private final JCheckBox chckbxAddRule = new JCheckBox(
			"Add rule (when predicate is true)");
	private final JTextArea configFile = new JTextArea();
	private final JScrollPane scrollconfigFile = new JScrollPane(configFile);

	private final JLabel lblParametersOfFile = new JLabel(
			"Parameters of file config");
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
	
	

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {

		for (String s : args)
			System.out.println(s);

		final Control control = new Control();

		control.setIndividualArgs(args);

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
		initialize();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		
		frame = new JFrame(Installation.softwareName);
		frame.setTitle(Installation.softwareName+" - Project B2ASM ");
		frame.setLocationRelativeTo(null);
		frame.setBounds(new Rectangle(702, 439));
		frame.setLocationRelativeTo(null);// center the window
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		// Create some items to add to the list
		String	listData [] = control.getStateAndNameOfProofObligations(false);

		for (int i=0; i<listData.length; i++) {
			listModel.addElement(listData[i]);
		}
		list=new JList(listModel);
		
		frame.getContentPane().setLayout(new MigLayout("", "[-25.00][214.00,grow][122.00][195.00,grow][:215.00:200.00]", "[][][][][][31.00][-9.00][grow][grow][][][][][][26.00][grow][]"));

		frame.getContentPane().add(lblParametersOfFile, "cell 1 0");

		configFile.setLineWrap(true);
		configFile.setText(control.getCommand().toString());
		frame.getContentPane().add(scrollconfigFile, "cell 1 1 3 4,grow");

		addEventsIncheckBox();
		
		textArea.setEditable(false);
		
		//Setting the output to TextArea        
        redirectSystemStreams();
		
		frame.getContentPane().add(checkBoxKokod, "cell 4 1");
		
		frame.getContentPane().add(checkBoxSmt, "cell 4 2");
		
		frame.getContentPane().add(checkBoxInitialiseModule, "cell 4 3");
		
		frame.getContentPane().add(checkBoxHypothesis, "cell 4 4");

		frame.getContentPane().add(lblExpressionToEvaluate, "cell 1 5");
		
		frame.getContentPane().add(new JScrollPane(list), "cell 1 7 1 8,grow");
		
		frame.getContentPane().add(new JScrollPane(textArea), "cell 2 7 3 8,grow");
		
		chckbxPoWD.addItemListener(new ItemListener() {
			public void itemStateChanged(ItemEvent arg0) {
				
				if(chckbxPoWD.isSelected()){
					// Create some items to add to the list
					String	listData [] = control.getStateAndNameOfProofObligations(true);
					listModel.removeAllElements();
					for (int i=0; i<listData.length; i++) {
						listModel.addElement(listData[i]);
					}
				}else{
					// Create some items to add to the list
					String	listData [] = control.getStateAndNameOfProofObligations(false);
					listModel.removeAllElements();
					for (int i=0; i<listData.length; i++) {
						listModel.addElement(listData[i]);
					}
				}
			
			}
		});
		

		frame.getContentPane().add(chckbxPoWD,
				"cell 1 16,alignx center,aligny center");

		frame.getContentPane().add(chckbxAddRule,
				"cell 3 16,alignx center,aligny center");
		
		
		

		btnEval.addActionListener(new ActionListener() {

			public void actionPerformed(ActionEvent arg0) {
				POs expressionsToEvaluate;
				Report reportTmp = new Report();
				
				
				
				//TODO: move this logic to Control class
				if(chckbxPoWD.isSelected()){
					
					expressionsToEvaluate = new POs((control.pathBModuleInBdpFolderWithoutExtension+"_wd"));
					
				}else{
					
					expressionsToEvaluate = new POs((control.pathBModuleInBdpFolderWithoutExtension));
					
				}
				
				int numberOftotalPOs = expressionsToEvaluate.getNumberOfProofObligations();

				StringBuffer proofObligations = new StringBuffer();
				
					for (int numberPo = 1; numberPo <= numberOftotalPOs; numberPo++) {
						
						if(!expressionsToEvaluate.isProvedTheProofState(numberPo)){
							control.callProbLogicEvaluator(false,false, configFile.getText(), expressionsToEvaluate.getCleanProofObligationsWithLocalHypotheses(numberPo));
							textArea.repaint();
							frame.validate();
							frame.repaint();
						}
					}
			}
		});

		frame.getContentPane().add(btnEval, "cell 4 16,alignx right");
	}

	private void addEventsIncheckBox() {

		checkBoxKokod.addItemListener(new ItemListener() {
			public void itemStateChanged(ItemEvent e) {
				String parameterToConfig = new String(" -p KODKOD TRUE \n");

				if (((JCheckBox) e.getItem()).isSelected())
					configFile.setText(parameterToConfig
							+ configFile.getText().replaceAll(
									parameterToConfig, ""));
				else {
					configFile.setText(configFile.getText().replaceAll(
							parameterToConfig, ""));
				}
			}
		});

		checkBoxInitialiseModule.addItemListener(new ItemListener() {
			public void itemStateChanged(ItemEvent e) {
				String parameterToConfig = new String(control.getModulePath()
						+ " -init ");

				if (((JCheckBox) e.getItem()).isSelected())
					configFile.setText(parameterToConfig
							+ configFile.getText().replaceAll(
									parameterToConfig, ""));
				else {
					configFile.setText(configFile.getText().replaceAll(
							parameterToConfig, ""));
				}
			}
		});

		checkBoxSmt.addItemListener(new ItemListener() {
			public void itemStateChanged(ItemEvent e) {
				String parameterToConfig = new String(" -p SMT TRUE ");

				if (((JCheckBox) e.getItem()).isSelected())
					configFile.setText(parameterToConfig
							+ configFile.getText().replaceAll(
									parameterToConfig, ""));
				else {
					configFile.setText(configFile.getText().replaceAll(
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
