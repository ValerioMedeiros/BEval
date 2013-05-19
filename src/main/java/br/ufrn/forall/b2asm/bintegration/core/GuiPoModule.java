package br.ufrn.forall.b2asm.bintegration.core;

import java.awt.EventQueue;
import java.awt.Rectangle;

import javax.swing.JFrame;
import javax.swing.JCheckBox;
import java.awt.BorderLayout;
import javax.swing.JButton;
import net.miginfocom.swing.MigLayout;

import javax.swing.DefaultListModel;
import javax.swing.JDialog;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextPane;
import javax.swing.JTextArea;
import javax.swing.JLabel;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.event.ChangeListener;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ListSelectionListener;

import br.ufrn.forall.b2asm.bintegration.core.StreamGobbler.Result;

import java.awt.event.ItemListener;
import java.awt.event.ItemEvent;
import java.io.File;
import java.io.PrintStream;

import javax.swing.DropMode;
import javax.swing.UIManager;
import javax.swing.JTabbedPane;
import javax.swing.JList;
import javax.swing.JScrollBar;

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

		frame = new JFrame();
		frame.setTitle(Installation.softwareName+" - Project B2ASM ");
		frame.setLocationRelativeTo(null);
		frame.setBounds(new Rectangle(702, 439));
		frame.setLocationRelativeTo(null);// center the window
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		// Create some items to add to the list
		String	listData[] = control.getStateAndNameOfProofObligations();
		list = new JList (listData);
		
		
		frame.getContentPane().setLayout(
				new MigLayout("", "[-25.00][228.00,grow][122.00][195.00,grow][:215.00:200.00]", "[][][][][][31.00][-9.00][grow][grow][][][][][][26.00][grow][]"));

		frame.getContentPane().add(lblParametersOfFile, "cell 1 0");

		configFile.setLineWrap(true);
		configFile.setText(control.getCommand().toString());
		frame.getContentPane().add(scrollconfigFile, "cell 1 1 3 4,grow");

		addEventsIncheckBox();
		
		textArea.setEditable(false);
		
		//Setting the output to TextArea
        TextAreaOutputStream taos = new TextAreaOutputStream( textArea );
        ps = new PrintStream( taos );
        System.setOut( ps );
        System.setErr( ps );
			
		
		
		frame.getContentPane().add(checkBoxKokod, "cell 4 1");
		
		frame.getContentPane().add(checkBoxSmt, "cell 4 2");
		
		frame.getContentPane().add(checkBoxInitialiseModule, "cell 4 3");
		
		frame.getContentPane().add(checkBoxHypothesis, "cell 4 4");

		frame.getContentPane().add(lblExpressionToEvaluate, "cell 1 5");
		
		frame.getContentPane().add(new JScrollPane(list), "cell 1 7 1 8,grow");
		
		frame.getContentPane().add(new JScrollPane(textArea), "cell 2 7 3 8,grow");
		

		frame.getContentPane().add(chckbxPoWD,
				"cell 1 16,alignx center,aligny center");

		frame.getContentPane().add(chckbxAddRule,
				"cell 3 16,alignx center,aligny center");
		
		
		

		btnEval.addActionListener(new ActionListener() {

			public void actionPerformed(ActionEvent arg0) {

				//list = control.getListOfPOs()
				//control.callProbLogic 
				
				Report reportTmp = new Report();
							
				
				
				
				control.callProbLogicEvaluatorModule(ps, control.getExecutablePath(), configFile.getText(), true, reportTmp, control.modulePath+".out");
				
				//		control.callProbLogicEvaluatorModule(pathProBcli, parameters,
				//		pathBModule, isFullProofObligation, report, pathBModule+".out");
				
				//frame.dispose();


				/*
				  int exitVal = control.getExitVal(); 
				String info = new String( "Evaluated predicate "+control.expressionName+"\nfrom "+control.moduleName+"."+control.componentExtension+" in "+control.total_time+" milliseconds.\n");
				if (exitVal == 0 && control.getResult() == Result.FALSE) {
					JOptionPane.showMessageDialog(frame,
							info+"The predicate is false!","Result", JOptionPane.WARNING_MESSAGE);
					System.exit(0);
				} else if (exitVal == 0 && control.getResult() == Result.TRUE) {
					JOptionPane.showMessageDialog(frame,
							info+"The predicate is true!","Result", JOptionPane.INFORMATION_MESSAGE);
					System.exit(0);
				} else {
					JOptionPane.showMessageDialog(frame,
							info+"The predicate was not solved!\nCode:" + exitVal
									+ " " + control.getResult(),"Result", JOptionPane.ERROR_MESSAGE);
					System.exit(1);
				}*/
			}
		});

		frame.getContentPane().add(btnEval, "cell 4 16,alignx right");
		
		/* Seleciona somente as não provadas 
		int countUnproved=0;
		for(int i =1; i<=listData.length;i++){ 
			if(!control.isProvedTheProofState(i))
				countUnproved++;
			}
		
		int  indicesUnproved [] = new int [countUnproved];
		for(int j =0; j<listData.length;j++){ 
			if(!control.isProvedTheProofState(j))
				indicesUnproved[j] = j ;
			}
		
		list.setSelectedIndices(indicesUnproved);
		*/

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


}
