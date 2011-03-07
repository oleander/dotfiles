/*****************************************************
 * jr generated file
 ****************************************************/
import edu.ucdavis.jr.*;
import edu.ucdavis.jr.jrx.*;
import java.rmi.*;
import java.io.Serializable;

    public class JRRA
      extends JRjavadotlangdotObject
      implements Serializable, Cloneable
    {
	static final long serialVersionUID = 0;
	public Cap_ext_ op_server_voidTovoid;
	public Cap_ext_ JRget_op_server_voidTovoid() {
		return op_server_voidTovoid;
	}
	public void JRset_op_server_voidTovoid(Cap_ext_ op_server_voidTovoid) {
		this.op_server_voidTovoid = op_server_voidTovoid;
	}

	public Cap_ext_ op_request_Cap_javadotlangdotObjectTovoidXjavadotlangdotObjectTovoid;
	public Cap_ext_ JRget_op_request_Cap_javadotlangdotObjectTovoidXjavadotlangdotObjectTovoid() {
		return op_request_Cap_javadotlangdotObjectTovoidXjavadotlangdotObjectTovoid;
	}
	public void JRset_op_request_Cap_javadotlangdotObjectTovoidXjavadotlangdotObjectTovoid(Cap_ext_ op_request_Cap_javadotlangdotObjectTovoidXjavadotlangdotObjectTovoid) {
		this.op_request_Cap_javadotlangdotObjectTovoidXjavadotlangdotObjectTovoid = op_request_Cap_javadotlangdotObjectTovoidXjavadotlangdotObjectTovoid;
	}

	public JRRA(JRRA copy)
	{
	this.op_server_voidTovoid = copy.op_server_voidTovoid;
	this.op_request_Cap_javadotlangdotObjectTovoidXjavadotlangdotObjectTovoid = copy.op_request_Cap_javadotlangdotObjectTovoidXjavadotlangdotObjectTovoid;

	}
	public JRRA(Object ... opSig)
	{
	this.op_server_voidTovoid = new Cap_ext_((Op_ext_.JRProxyOp)opSig[0]);
	this.op_request_Cap_javadotlangdotObjectTovoidXjavadotlangdotObjectTovoid = new Cap_ext_((Op_ext_.JRProxyOp)opSig[1]);

	}
	public JRRA(boolean dummy)	{
	    super(dummy);
	this.op_server_voidTovoid = Cap_ext_.noop;
	this.op_request_Cap_javadotlangdotObjectTovoidXjavadotlangdotObjectTovoid = Cap_ext_.noop;

	}
	public Object clone()
	    throws CloneNotSupportedException
	{
	    return super.clone();
	}
	public static Object getNoop()
	{
	    return new JRRA(true);
	}
    }
