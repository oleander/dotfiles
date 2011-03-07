public class Life {

	public static void main(String[] args) {
	  Direction d0 = new Direction(5);
	  System.out.println(d0);
	  Direction d2 = d0.opposite1();
	  System.out.println(d2);
	  Direction d4 = d0.opposite3();
	  System.out.println(d4);
	}
}
