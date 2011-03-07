/*****************************************************
 * jr generated file
 ****************************************************/
import edu.ucdavis.jr.*;
import edu.ucdavis.jr.jrx.*;
import java.rmi.*;
import java.io.Serializable;


public class csp_rr extends java.lang.Object {
    { JRinit(); }
    public int wwith;
    public boolean io;
    public int ioty;
    public int arm;
    public int q1;
    public int q2;
    
    public csp_rr(int wwith, boolean io, int ioty, int arm, int q1, int q2) {
        // Begin Expr2
        super();
        // Begin Expr2
        this.wwith = wwith;
        // Begin Expr2
        this.io = io;
        // Begin Expr2
        this.ioty = ioty;
        // Begin Expr2
        this.arm = arm;
        // Begin Expr2
        this.q1 = q1;
        // Begin Expr2
        this.q2 = q2;
        JRprocess();
    }
    protected boolean JRcalled = false;
    protected JRcsp_rr jrresref;
    public Object JRgetjrresref()
    { try {return jrresref.clone(); } catch (Exception e) {/* not gonna happen */ return null; } }
    protected void JRinit() {
    	if(this.JRcalled) return;
    	jrresref = new JRcsp_rr();
    	this.JRcalled = true;
    }
    private boolean JRproc = false;
    private void JRprocess() {
    	if (JRproc) return;
    	JRproc = true;
    }
}
