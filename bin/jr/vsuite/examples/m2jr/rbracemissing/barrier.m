/* n process barrier
 * weird behavior for SX:
 * works, but not as intended barrier; cnt increases...
 */
_monitor barrier {

  _condvar b;
  _var int cnt = 0;
  _var int limit;

  _proc void setn(int n) {
     limit = n;
     System.out.println("number of processes is " + n);


  _proc void arrive(int i) {
    cnt++;
    System.out.println("process " + i + " has arrived -- total of " + cnt);
    if (cnt < limit){
        _wait(b);
    }
    else {
        for (int j = 1; j <= limit-1; j++) {
            _signal(b);
        }
        cnt = 0;
    }
  }

}
