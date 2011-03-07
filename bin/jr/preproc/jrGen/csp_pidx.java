/*****************************************************
 * jr generated file
 ****************************************************/
import edu.ucdavis.jr.*;
import edu.ucdavis.jr.jrx.*;
import java.rmi.*;
import java.io.Serializable;


public class csp_pidx extends java.lang.Object {
    { JRinit(); }
    public int pd;
    public int i1;
    public int i2;
    
    public csp_pidx(int pd, int i1, int i2) {
        // Begin Expr2
        super();
        // Begin Expr2
        this.pd = pd;
        // Begin Expr2
        this.i1 = i1;
        // Begin Expr2
        this.i2 = i2;
        JRprocess();
    }
    protected boolean JRcalled = false;
    protected JRcsp_pidx jrresref;
    public Object JRgetjrresref()
    { try {return jrresref.clone(); } catch (Exception e) {/* not gonna happen */ return null; } }
    protected void JRinit() {
    	if(this.JRcalled) return;
    	jrresref = new JRcsp_pidx();
    	this.JRcalled = true;
    }
    private boolean JRproc = false;
    private void JRprocess() {
    	if (JRproc) return;
    	JRproc = true;
    }
}
