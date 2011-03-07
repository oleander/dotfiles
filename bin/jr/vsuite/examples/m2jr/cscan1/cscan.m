/* CSCAN disk scheduler */
_monitor cscan {

    _condvar scan[2];
    _var int c = 0;
    _var int n = 1;
    _var int pos = -1;

    _proc void request(int cyli) {
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
