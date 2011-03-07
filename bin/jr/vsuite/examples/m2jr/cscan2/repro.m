_monitor repro {
    /* for reproducibility:
     * order[turn] is pid of process allowed to enter monitor next.
     * hangout[pid] is private condition variable for process pid
     * on which it waits until its turn.
     * assume we know in advance number of processes.
     */
    _var int turn = 0;
    /* output will be the same as the releases below. */
    _var int order[]={ 1, /* requests 40 */
                       1, /* releases */
                       3, /* requests 30 */
                       2, /* requests 35 */
                       1, /* requests 20 */
                       3, /* releases */
                       3, /* requests 50 */
                       2, /* releases */
                       2, /* requests 60 */
                       3, /* releases */
                       2, /* releases */
                       2, /* requests 10 */
                       3, /* requests 5 */
                       1, /* releases */
                       3, /* releases */
                       2, /* releases */
                       2, /* requests 80 */
                       2, /* releases */
                       1};/* extra to simplify termination */
                          /* 1, 2, or 3 will work. */

    _condvar hangout[4];
    /* only use hangout[1:3]
     * (this code adapted from SR code;
     * didn't feel like changing numbers above or subtracting 1 in
     * _wait and _signal below (instead I felt like writing this comment)
     */

    _proc void entry(int pid) {
        if (order[turn] != pid) _wait(hangout[pid]);
    }

    _proc void increment() {
        turn++;
        _signal(hangout[order[turn]]);
        _return;
    }

}
