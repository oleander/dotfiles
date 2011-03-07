public class ResourceAllocatorA<E> {

  public E [] allocate(int n) {
    E [] ret = (E []) new Object[n];
    return ret;
  }
  
  private static ResourceAllocatorA<Integer> ra = new ResourceAllocatorA<Integer>();

  public static void main(String[] args) {
    Integer [] us = ra.allocate(2);
  }
}
