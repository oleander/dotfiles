public class main {
    public static void main (String[] args) {
	final int n = Integer.parseInt(args[0]);
	Barrier b = new Barrier(n);
	for (int k = 0; k < n; k++) {
	    new myThread(k, b).start();
      }
    }
}
