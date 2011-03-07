_monitor foo {
    _var boolean free = true;
    _condvar not_busy;
    _proc void enter(int who) {
        if (!free) { _wait(not_busy)(who); }
        free = false;
    }
    _proc void xexit() {
        if (_empty(not_busy)) {
	  System.out.println("not_busy empty");
        }
        else {
	  System.out.println("not_busy minrank is " + _minrank(not_busy));
	}
        _print(not_busy);
        free = true;
        _signal(not_busy);
        _return;
    }
}
