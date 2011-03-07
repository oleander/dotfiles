/*****************************************************
 * jr generated file
 ****************************************************/
import edu.ucdavis.jr.*;
import edu.ucdavis.jr.jrx.*;
import java.rmi.*;
import java.io.Serializable;


public class csp_pdecl extends java.lang.Object {
    { JRinit(); }
    public // NUMBER 8
    Cap_ext_ cp;
    public String name;
    public int dims;
    public int s1;
    public int s2;
    
    public csp_pdecl(String name, int dims, // NUMBER 8
    Cap_ext_ cp, int s1, int s2) {
        // Begin Expr2
        super();
        // Begin Expr2
        this.name = name;
        // Begin Expr2
        this.dims = dims;
        // Begin Expr2
        this.cp = cp;
        // Begin Expr2
        this.s1 = s1;
        // Begin Expr2
        this.s2 = s2;
        JRprocess();
    }
    protected boolean JRcalled = false;
    protected JRcsp_pdecl jrresref;
    public Object JRgetjrresref()
    { try {return jrresref.clone(); } catch (Exception e) {/* not gonna happen */ return null; } }
    protected void JRinit() {
    	if(this.JRcalled) return;
    	jrresref = new JRcsp_pdecl();
    	this.JRcalled = true;
    }
    private boolean JRproc = false;
    private void JRprocess() {
    	if (JRproc) return;
    	JRproc = true;
    }
}
