/*****************************************************
 * jr generated file
 ****************************************************/
import edu.ucdavis.jr.*;
import edu.ucdavis.jr.jrx.*;
import java.rmi.*;
import java.io.Serializable;


import edu.ucdavis.jr.JR;

public class main extends java.lang.Object {
    { JRinit(); }
    
    public main() {
        // Begin Expr2
        super();
        JRprocess();
    }
    
    public static void main(String[] args) {
        // Begin Expr2
        System.out.println("Welcome to the wonderful world of JR!");
        // Begin Expr2
        JR.exit(0);
    }
    protected boolean JRcalled = false;
    protected JRmain jrresref;
    public Object JRgetjrresref()
    { try {return jrresref.clone(); } catch (Exception e) {/* not gonna happen */ return null; } }
    protected void JRinit() {
    	if(this.JRcalled) return;
    	jrresref = new JRmain();
    	this.JRcalled = true;
    }
    private boolean JRproc = false;
    private void JRprocess() {
    	if (JRproc) return;
    	JRproc = true;
    }
}
