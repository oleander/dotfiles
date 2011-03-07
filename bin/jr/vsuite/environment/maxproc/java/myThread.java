public class myThread extends Thread {
    private final int i;
    private final Barrier b;
    public myThread(int i, Barrier b) {
	this.i = i;
	this.b = b;
    }
    public void run() {
	System.out.println("start "+i);
	b.barrier();
	System.out.println("end "+i);
    }
}
