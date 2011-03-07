/* monitor that uses no condition variables */
// test that _return in middle of code works...
_monitor no_cv {
  _var int value = 0;

  _proc void setv(int n) {
    value = n;
  }

  _proc int getv() {
    int retval = value; // return value should be local
    if (retval > 2) { // true sometimes for test.jr's invocations
      _return retval; // just so can test this _return
    }
    _return retval;   // and test this one in other cases.
  }

}
