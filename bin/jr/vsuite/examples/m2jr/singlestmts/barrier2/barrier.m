import edu.ucdavis.jr.JR;

/* n process barrier -- awaken all waiting using _signal_all */
_monitor barrier {
  _condvar b;
  _var int cnt = 0;
  _var int limit;

  _proc void setn(int n) {
     limit = n;
     System.out.println("number of processes is " + n);
  }

  _proc void arrive(int i) {
     if (cnt == 0) {
	if (! _empty(b)) {
	  System.out.println("oops1");
	  JR.exit(1);
	}
	if (cnt == 0)
	  _signal_all(b);
        else
	  _signal_all(b);
	if (! _empty(b)) {
	  System.out.println("oops2");
	  JR.exit(1);
	  }
    }
    cnt++;
    /* split write statement so that sorted output is
     * nondeterministic.
     * (a weaker test for sure, but this is the only test
     * exercising signal_all.  other tests exercise rest of stuff.)
     */
    System.out.println("process " + i);
    System.out.println("has arrived -- total of " + cnt);
    if ( cnt < limit ) {
       _wait(b);
    }
    else {
       if (cnt != limit || _empty(b)) {
          System.out.println("oops3");
          JR.exit(1);
       }
       _signal_all(b);
	if (! _empty(b)) {
            System.out.println("oops4");
	    JR.exit(1);
	}
        cnt = 0;
    }
  }

}
