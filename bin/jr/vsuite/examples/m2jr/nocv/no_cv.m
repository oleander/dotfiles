/* monitor that uses no condition variables */
_monitor no_cv {
  _var int value = 0;

  _proc void setv(int n) {
    value = n;
  }

  _proc int getv() {
    int retval = value; // return value should be local
    _return retval;
  }

}
