/*****************************************************
 * jr generated file
 ****************************************************/
import edu.ucdavis.jr.*;
import edu.ucdavis.jr.jrx.*;
import java.rmi.*;
import java.io.Serializable;

public class JRjavadotlangdotObject
  implements Serializable, Cloneable
{
    static final long serialVersionUID = 0;
    public JRjavadotlangdotObject()
    {}
    boolean isNoop;
    public JRjavadotlangdotObject(boolean isNoop)
    {this.isNoop = isNoop;}
    public String toString ()
    {return isNoop?"noop":super.toString();}
    public Object clone()
	throws CloneNotSupportedException
    {
	    return super.clone();
    }
    public static Object getNoop()
    {
	    return new JRjavadotlangdotObject();
    }
}
