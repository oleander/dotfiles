/* use only this form of commenting, but don't nest */
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
        _signal(not_empty);
        _return;
    }

    _proc int fetch() {
        while (count == 0) { // while (not if) to handle signal stealers in SC
	  _print(not_full); _print(not_empty);
	  _wait(not_empty);
	}
        _print(not_full); _print(not_empty);
        int result = buf[front];
        front = (front+1) % N;
        count--;
        _signal(not_full);
        _return result;
    }

}
