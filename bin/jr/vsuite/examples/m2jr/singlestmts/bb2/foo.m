_monitor foo {
    _var boolean free = true;
    _condvar not_busy;
    _proc void enter(int who) {
        if (!free) { if (free) _wait(not_busy)(who);
	// some extra stuff in expressions just to test parsing
	             else _wait(not_busy)((3-3)+who*1*(9-8-1)); }
        free = false;
    }
    _proc void xexit() {
        if (_empty(not_busy)) {
	  System.out.println("not_busy empty");
        }
        else {
	  System.out.println("not_busy minrank is " + _minrank(not_busy));
	}
        if (free) _print(not_busy);
        else _print(not_busy);
        free = true;
        _signal(not_busy);
        _return;
    }
}
