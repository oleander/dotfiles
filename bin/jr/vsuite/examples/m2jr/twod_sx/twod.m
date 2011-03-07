_monitor twod {

    _condvar a[test.N][test.O];

    _proc void request(int i, int j, int h) {
	// some noise in expressions just to test parsing
	    _wait(a[i-(h-h)][j+0])(h*3/(2+1));
    }

    _proc void release() {
      for (int i = 0; i < test.N; i++) {
        for (int j = 0; j < test.O; j++) {
	// some noise in expressions just to test parsing
          _signal(a[i+(0)][j*((((1))))]);
          _return; // returns after awakening first.
        }
      }
    }
}
