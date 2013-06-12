package br.ufrn.forall.b2asm.beval.core;

import java.awt.EventQueue;
import java.awt.Rectangle;

import javax.swing.JFrame;
import javax.swing.JCheckBox;
import java.awt.BorderLayout;
import javax.swing.JButton;
import net.miginfocom.swing.MigLayout;

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

import br.ufrn.forall.b2asm.beval.core.StreamGobbler.Result;

import java.awt.event.ItemListener;
import java.awt.event.ItemEvent;
import javax.swing.DropMode;
import javax.swing.UIManager;
import javax.swing.JTabbedPane;

/**
 * This class contains the graphic elements
 * 
 * @author valerio
 * 
 */

public class GuiPoIndividual extends JFrame {

	JFrame frame;
	final Control control;
	private final JCheckBox chckbxPoWD = new JCheckBox("P.O. W. D.");
	private final JButton btnEval = new JButton("Eval");
	private final JCheckBox chckbxAddRule = new JCheckBox(
			"Add rule (when predicate is true)");
	private final JTextArea actualParameters = new JTextArea();
	private final JScrollPane scrollActualParameters = new JScrollPane(actualParameters);

	private final JTextArea expression = new JTextArea();
	private final JScrollPane scrollExpression = new JScrollPane(expression);

	private final JLabel lblParametersOfFile = new JLabel("Parameters");
	private final JLabel lblExpressionToEvaluate = new JLabel("Goal to evaluate");
	private final JTextArea textHypothesis = new JTextArea();
	private final JScrollPane scrollHypothesis = new JScrollPane(textHypothesis);
	private final JCheckBox chckbxToAdd = new JCheckBox("Add hypothesis");
	private final JCheckBox checkBoxKokod = new JCheckBox("Kodkod");
	private final JCheckBox checkBoxSmt = new JCheckBox("Smt");
	private final JCheckBox checkBoxInitialiseModule = new JCheckBox("Initialise");

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

					GuiPoIndividual window = new GuiPoIndividual(control);
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
	public GuiPoIndividual(Control control) {

		this.control = control;
		initialize();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {

		frame = new JFrame(Installation.softwareName);
        frame.setTitle(" ("+control.getModuleName()+") "+ Installation.softwareName+" - Project B2ASM ");
		frame.setBounds(new Rectangle(702, 439));
		frame.setLocationRelativeTo(null);// center the window
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().setLayout(
				new MigLayout("", "[-25.00][228.00,grow][][grow][:215.00:200.00]", "[][][][][][31.00][-9.00][][][][][][][][26.00][grow][]"));

		frame.getContentPane().add(lblParametersOfFile, "cell 1 0");

		actualParameters.setLineWrap(true);
		actualParameters.setText(control.getCommand().toString());
		frame.getContentPane().add(scrollActualParameters, "cell 1 1 1 4,grow");

		frame.getContentPane().add(checkBoxKokod, "flowx,cell 2 1,aligny top");

		addEventsIncheckBox();

		textHypothesis.setBackground(UIManager.getColor("CheckBox.background"));
		textHypothesis.setEditable(false);
		textHypothesis.setWrapStyleWord(true);
		textHypothesis.setText(control.getHypothesis());
		textHypothesis.setLineWrap(true);

		frame.getContentPane().add(scrollHypothesis, "cell 3 1 4 4,grow");

		frame.getContentPane().add(checkBoxSmt, "cell 2 2");
		checkBoxInitialiseModule.setSelected(true);

		frame.getContentPane().add(checkBoxInitialiseModule, "cell 2 3");

		frame.getContentPane().add(lblExpressionToEvaluate, "cell 1 5");

		frame.getContentPane().add(scrollExpression, "cell 1 6 4 10,grow");
		
		expression.setWrapStyleWord(true);
		
		expression.setLineWrap(true);
		
		expression.setText(control.getGoal());

		frame.getContentPane().add(chckbxPoWD,
				"cell 1 16,alignx center,aligny center");
		chckbxAddRule.setSelected(true);

		frame.getContentPane().add(chckbxAddRule,
				"cell 3 16,alignx center,aligny center");

		btnEval.addActionListener(new ActionListener() {

			public void actionPerformed(ActionEvent arg0) {

				control.callProbLogicEvaluator(chckbxPoWD.isSelected(),
						chckbxAddRule.isSelected(), actualParameters.getText(),
						expression.getText());

				frame.dispose();

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
				}
			}
		});

		frame.getContentPane().add(btnEval, "cell 4 16,alignx right");
		chckbxToAdd.setEnabled(false);

		frame.getContentPane().add(chckbxToAdd, "cell 3 0");

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

}
