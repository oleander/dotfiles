/*****************************************************
 * jr generated file
 ****************************************************/
import edu.ucdavis.jr.*;
import edu.ucdavis.jr.jrx.*;
import java.rmi.*;
import java.io.Serializable;

    public class JRcsp_coord
      extends JRjavadotlangdotObject
      implements Serializable, Cloneable
    {
	static final long serialVersionUID = 0;
	public Cap_ext_ op_csp_err_voidTovoid;
	public Cap_ext_ JRget_op_csp_err_voidTovoid() {
		return op_csp_err_voidTovoid;
	}
	public void JRset_op_csp_err_voidTovoid(Cap_ext_ op_csp_err_voidTovoid) {
		this.op_csp_err_voidTovoid = op_csp_err_voidTovoid;
	}

	public Cap_ext_ op_csp_cantmatch_intXjavadotlangdotStringTovoid;
	public Cap_ext_ JRget_op_csp_cantmatch_intXjavadotlangdotStringTovoid() {
		return op_csp_cantmatch_intXjavadotlangdotStringTovoid;
	}
	public void JRset_op_csp_cantmatch_intXjavadotlangdotStringTovoid(Cap_ext_ op_csp_cantmatch_intXjavadotlangdotStringTovoid) {
		this.op_csp_cantmatch_intXjavadotlangdotStringTovoid = op_csp_cantmatch_intXjavadotlangdotStringTovoid;
	}

	public Cap_ext_ op_csp_status_intXbooleanTovoid;
	public Cap_ext_ JRget_op_csp_status_intXbooleanTovoid() {
		return op_csp_status_intXbooleanTovoid;
	}
	public void JRset_op_csp_status_intXbooleanTovoid(Cap_ext_ op_csp_status_intXbooleanTovoid) {
		this.op_csp_status_intXbooleanTovoid = op_csp_status_intXbooleanTovoid;
	}

	public Cap_ext_ op_csp_die_intTovoid;
	public Cap_ext_ JRget_op_csp_die_intTovoid() {
		return op_csp_die_intTovoid;
	}
	public void JRset_op_csp_die_intTovoid(Cap_ext_ op_csp_die_intTovoid) {
		this.op_csp_die_intTovoid = op_csp_die_intTovoid;
	}

	public Cap_ext_ op_csp_match_intXjavadotutildotArrayListTovoid;
	public Cap_ext_ JRget_op_csp_match_intXjavadotutildotArrayListTovoid() {
		return op_csp_match_intXjavadotutildotArrayListTovoid;
	}
	public void JRset_op_csp_match_intXjavadotutildotArrayListTovoid(Cap_ext_ op_csp_match_intXjavadotutildotArrayListTovoid) {
		this.op_csp_match_intXjavadotutildotArrayListTovoid = op_csp_match_intXjavadotutildotArrayListTovoid;
	}

	public Cap_ext_ op_csp_coordinator_voidTovoid;
	public Cap_ext_ JRget_op_csp_coordinator_voidTovoid() {
		return op_csp_coordinator_voidTovoid;
	}
	public void JRset_op_csp_coordinator_voidTovoid(Cap_ext_ op_csp_coordinator_voidTovoid) {
		this.op_csp_coordinator_voidTovoid = op_csp_coordinator_voidTovoid;
	}

	public JRcsp_coord(JRcsp_coord copy)
	{
	this.op_csp_err_voidTovoid = copy.op_csp_err_voidTovoid;
	this.op_csp_cantmatch_intXjavadotlangdotStringTovoid = copy.op_csp_cantmatch_intXjavadotlangdotStringTovoid;
	this.op_csp_status_intXbooleanTovoid = copy.op_csp_status_intXbooleanTovoid;
	this.op_csp_die_intTovoid = copy.op_csp_die_intTovoid;
	this.op_csp_match_intXjavadotutildotArrayListTovoid = copy.op_csp_match_intXjavadotutildotArrayListTovoid;
	this.op_csp_coordinator_voidTovoid = copy.op_csp_coordinator_voidTovoid;

	}
	public JRcsp_coord(Object ... opSig)
	{
	this.op_csp_err_voidTovoid = new Cap_ext_((Op_ext_.JRProxyOp)opSig[0]);
	this.op_csp_cantmatch_intXjavadotlangdotStringTovoid = new Cap_ext_((Op_ext_.JRProxyOp)opSig[1]);
	this.op_csp_status_intXbooleanTovoid = new Cap_ext_((Op_ext_.JRProxyOp)opSig[2]);
	this.op_csp_die_intTovoid = new Cap_ext_((Op_ext_.JRProxyOp)opSig[3]);
	this.op_csp_match_intXjavadotutildotArrayListTovoid = new Cap_ext_((Op_ext_.JRProxyOp)opSig[4]);
	this.op_csp_coordinator_voidTovoid = new Cap_ext_((Op_ext_.JRProxyOp)opSig[5]);

	}
	public JRcsp_coord(boolean dummy)	{
	    super(dummy);
	this.op_csp_err_voidTovoid = Cap_ext_.noop;
	this.op_csp_cantmatch_intXjavadotlangdotStringTovoid = Cap_ext_.noop;
	this.op_csp_status_intXbooleanTovoid = Cap_ext_.noop;
	this.op_csp_die_intTovoid = Cap_ext_.noop;
	this.op_csp_match_intXjavadotutildotArrayListTovoid = Cap_ext_.noop;
	this.op_csp_coordinator_voidTovoid = Cap_ext_.noop;

	}
	public Object clone()
	    throws CloneNotSupportedException
	{
	    return super.clone();
	}
	public static Object getNoop()
	{
	    return new JRcsp_coord(true);
	}
    }
