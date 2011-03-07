public class Direction {
	public static final int NW = 0;
	public static final int N  = 1;
	public static final int NE = 2;
	public static final int W  = 3;
	public static final int E  = 4;
	public static final int SW = 5;
	public static final int S  = 6;
	public static final int SE = 7;
	
	public static final int TOTAL = 8;
	
	public int value;
  
  public Direction(int v) {
    value = v;
  }

	public Direction opposite1() {
		switch(value) {
			case N:
				return new Direction(S);
			case S:
				return new Direction(N);
			case E:
				return new Direction(W);
			case W:
				return new Direction(E);
			case NE:
				return new Direction(SW);
			case NW:
				return new Direction(SE);
			case SE:
				return new Direction(NW);
			case SW:
				return new Direction(NE);
		}
		return new Direction(NE);
	}

	public Direction opposite3() {
		switch(value) {
			case N:
				return new Direction(S);
			case S:
				return new Direction(N);
			case E:
				return new Direction(W);
			case W:
				return new Direction(E);
			case NE:
				return new Direction(SW);
			case NW:
				return new Direction(SE);
			case SE:
				return new Direction(NW);
			default:
				return new Direction(NE);
		}
	}
  public String toString() {
    return "dir="+value;
  }
}
