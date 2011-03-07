/*****************************************************
 * jr generated file
 ****************************************************/
import edu.ucdavis.jr.*;
import edu.ucdavis.jr.jrx.*;
import java.rmi.*;
import java.io.Serializable;

    public class JRmain
      extends JRjavadotlangdotObject
      implements Serializable, Cloneable
    {
	static final long serialVersionUID = 0;
	public Cap_ext_ op_goo_voidTovoid;
	public Cap_ext_ JRget_op_goo_voidTovoid() {
		return op_goo_voidTovoid;
	}
	public void JRset_op_goo_voidTovoid(Cap_ext_ op_goo_voidTovoid) {
		this.op_goo_voidTovoid = op_goo_voidTovoid;
	}

	public Cap_ext_ op_foo_voidTovoid;
	public Cap_ext_ JRget_op_foo_voidTovoid() {
		return op_foo_voidTovoid;
	}
	public void JRset_op_foo_voidTovoid(Cap_ext_ op_foo_voidTovoid) {
		this.op_foo_voidTovoid = op_foo_voidTovoid;
	}

	public JRmain(JRmain copy)
	{
	this.op_goo_voidTovoid = copy.op_goo_voidTovoid;
	this.op_foo_voidTovoid = copy.op_foo_voidTovoid;

	}
	public JRmain(Object ... opSig)
	{
	this.op_goo_voidTovoid = new Cap_ext_((Op_ext_.JRProxyOp)opSig[0]);
	this.op_foo_voidTovoid = new Cap_ext_((Op_ext_.JRProxyOp)opSig[1]);

	}
	public JRmain(boolean dummy)	{
	    super(dummy);
	this.op_goo_voidTovoid = Cap_ext_.noop;
	this.op_foo_voidTovoid = Cap_ext_.noop;

	}
	public Object clone()
	    throws CloneNotSupportedException
	{
	    return super.clone();
	}
	public static Object getNoop()
	{
	    return new JRmain(true);
	}
    }
