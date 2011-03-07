_monitor foo {
    _var boolean free = true;
    _condvar not_busy;
    _proc void enter() {
        if (!free) { _wait(not_busy); }
        free = false;
    }
    _proc void xexit() {
        free = true;
        _signal(not_busy);
        _return;
    }
}
