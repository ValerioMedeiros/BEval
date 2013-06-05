package br.ufrn.forall.b2asm.utils;

import java.awt.Component;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JDialog;
import javax.swing.JOptionPane;
import javax.swing.Timer;
import javax.swing.UIManager;

/*
 * This class show a message box with auto dismiss.
 */
public class AutoDismiss implements Runnable, ActionListener
{
    private JDialog dialog;

    public AutoDismiss(JDialog dialog)
    {
        this.dialog = dialog;
    }

    @Override
    public void actionPerformed(ActionEvent e)
    {
        dialog.dispose();
    }    

    // EDIT: in response to comment
    static public void showMessageDialog(Component parent, Object message,int timeout) {
      // run all of this on the EDT
      final JOptionPane optionPane = new JOptionPane(message);
      String title = UIManager.getString("OptionPane.messageDialogTitle");
      //int style = styleFromMessageType(JOptionPane.INFORMATION_MESSAGE);
      final JDialog dialog = optionPane.createDialog(parent, title);
      
      //timeout default is 5000 milliseconds
      Timer timer = new Timer(timeout, new AutoDismiss(dialog));
      timer.setRepeats(false);
      timer.start();
      if (dialog.isDisplayable())
          dialog.setVisible(true);
    }

	@Override
	public void run() {
		// TODO Auto-generated method stub
		
	}
}