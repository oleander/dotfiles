/* interval timer using a covering condition */
_monitor timer {
  _var int tod = 0;
  _condvar check;

  _proc void delay(int interval) {
    int wake_time = tod + interval;
    while (wake_time > tod) { _wait(check); }
  }

  _proc void tick() {
    tod++;
    _signal_all(check);
  }

}
