/* CSCAN disk scheduler problem
 * like other cscan test, but forces reproducibility.
 * tests: nested monitor calls (exclusion in first not released)
 * prioritized _wait, _minrank, _empty, _print,
 * arrays of condition variables.
 */


_monitor cscan {

    _condvar scan[2];
    _var int c = 0;
    _var int n = 1;
    _var int pos = -1;
    repro r;

    _proc void init(repro rr) {
        r = rr;
    }

    _proc void request(int cyli) {
        r.increment();
        if (pos == -1) {
	    pos = cyli;
        }
        else if (pos != -1  && cyli > pos) {
	    _wait(scan[c])(cyli);
        }
        else { // pos != -1  and cyli <= pos
 	    _wait(scan[n])(cyli);
        }
    }

    _proc void release() {
        r.increment();
        System.out.println("on release, current scan; next scan:");
        _print(scan[c]);	_print(scan[n]);
        if (!  _empty(scan[c]) ) {
	    pos =  _minrank(scan[c]);
        }
        else if ( _empty(scan[c]) && ! _empty(scan[n])) {
  	    int t = c;
	    c = n; n = t;
            pos =  _minrank(scan[c]);
        }
        else { //  _empty(scan[c])  and  _empty(scan[n])
	    pos = -1;
        }
        _signal(scan[c]);
        _return;
    }
}
