/* check out comments too (don't nest them) */
_monitor bounded_buffer {

    private static final int N = 4;

    _var int [] buf = new int [N];
    _var int front = 0;
    _var int rear = 0;
    _var int count = 0;

    _condvar not_full; _condvar not_empty;

    _proc void deposit(int data) {
        while (count == N) { // while (not if) to handle signal stealers in SC
	  _print(not_full); _print(not_empty);
	  _wait(not_full);
	}
        _print(not_full); _print(not_empty);
        buf[rear] = data;
        rear = (rear+1) % N;
        count++;
        if (count == 2) _signal(not_empty);
        else _signal(not_empty);
    }

    _proc int fetch() {
        while (count == 0) { // while (not if) to handle signal stealers in SC
	  if (front == 0) _print(not_full);
	  else  _print(not_full);
	  _print(not_empty);
          if (front == 0) _wait(not_empty);
          else _wait(not_empty);
	}
        _print(not_full); _print(not_empty);
        int result = buf[front];
        front = (front+1) % N;
        count--;
        if (count > 0) _signal(not_full);
        else _signal(not_full);
        _return result;
    }

}
