public class Barrier {
    private final int n;
    public Barrier (int n) {
	this.n = n;
    }
    // note: uses a non-reusable barrier
    private int count = 0;
    public synchronized void barrier() {
	count++;
	if (count < n) {
	    try {
		wait();
            } catch (Exception e) {System.err.println("oops");}
	}
	else { // last one to arrive
	    try {
		notifyAll();
            } catch (Exception e) {System.err.println("oops");}
	}
    }
}
