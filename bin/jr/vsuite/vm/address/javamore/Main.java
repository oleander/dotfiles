import java.net.*;

public class Main
{
    public static void main(String [] args) throws Exception
    {
	InetAddress addr = InetAddress.getLocalHost();
	// system dependent info
	System.out.println(addr);
	System.out.println(addr.getHostName());
	// system dependent, but Script checks for not equal to local.
	System.out.println(addr.getHostAddress());
    }
}
