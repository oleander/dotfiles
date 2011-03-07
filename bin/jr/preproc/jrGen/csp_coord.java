/*****************************************************
 * jr generated file
 ****************************************************/
import edu.ucdavis.jr.*;
import edu.ucdavis.jr.jrx.*;
import java.rmi.*;
import java.io.Serializable;


import java.util.ArrayList;
import edu.ucdavis.jr.JR;

public class csp_coord extends java.lang.Object {
    { JRinit(); }
    private int csp_np;
    private boolean csp_implicit;
    private Op_ext.JRProxyOp JRget_op_csp_coordinator_voidTovoid()
    {
        return op_csp_coordinator_voidTovoid;
    }
    
    public Op_ext.JRProxyOp op_csp_coordinator_voidTovoid;
    class ProcOp_voidTovoid_implcsp_coordinator extends ProcOp_ext_impl
    {
        csp_coord thisarg;
        public ProcOp_voidTovoid_implcsp_coordinator(csp_coord thisIn) throws RemoteException
        {
        thisarg = thisIn;
        }
        public java.lang.Object call(long JRtimestamp, java.lang.Object [] JRargs) throws RemoteException
        {
            jrvm.ariseAndReceive();  // from caller
            try    {
                jrvm.setTimestamp(JRtimestamp);
                thisarg.csp_coordinatorvoidTovoid(null, null, null, JRargs);
return null;
            } finally {
                jrvm.sendAndDie();    // to caller
            }
        }
        class sendThread implements Runnable
        {
            java.lang.Object [] JRargs;
            Op_ext.JRProxyOp retOp;
            Cap_ext fretOp;
            edu.ucdavis.jr.RemoteHandler handler;

            public sendThread(Op_ext.JRProxyOp retOp, edu.ucdavis.jr.RemoteHandler handler, java.lang.Object [] JRargs)
            {
                this.JRargs = JRargs;
                this.retOp = retOp;
                this.handler = handler;
            }
            public sendThread(Op_ext.JRProxyOp retOp, Cap_ext fretOp,edu.ucdavis.jr.RemoteHandler handler, java.lang.Object [] JRargs)
            {
                this.JRargs = JRargs;
                this.retOp = retOp;
                this.fretOp = fretOp;
                this.handler = handler;
            }
            public void run()
            {
                try    {
                    thisarg.csp_coordinatorvoidTovoid(this.retOp, this.fretOp, this.handler, this.JRargs);
                } catch (Exception e) {/* should be safe to ignore this exception */}
                jrvm.threadDeath();
            }
        }
        public void send(long JRtimestamp, java.lang.Object [] JRargs) throws RemoteException
        {
            this.send(JRtimestamp, null, null, null, JRargs);
        }
        public Cap_ext cosend(long JRtimestamp, java.lang.Object [] JRargs) throws RemoteException
        {
            return this.cosend(JRtimestamp, null, null, null, JRargs);
        }
        public void send(long JRtimestamp, edu.ucdavis.jr.RemoteHandler handler, java.lang.Object [] JRargs) throws RemoteException
        {
            this.send(JRtimestamp, null, handler, null, JRargs);
        }
        public Cap_ext cosend(long JRtimestamp, edu.ucdavis.jr.RemoteHandler handler, java.lang.Object [] JRargs) throws RemoteException
        {
            return this.cosend(JRtimestamp, null, handler, null, JRargs);
        }
        public void send(long JRtimestamp, Op_ext.JRProxyOp retOp, edu.ucdavis.jr.RemoteHandler handler, Exception thrown, java.lang.Object [] JRargs) throws RemoteException
        {
            jrvm.setTimestamp(JRtimestamp);
            jrvm.threadBirth();
            new Thread(new sendThread(retOp, handler, JRargs)).start();
        }
        public Cap_ext cosend(long JRtimestamp, Op_ext.JRProxyOp retOp, edu.ucdavis.jr.RemoteHandler handler, Exception thrown, java.lang.Object [] JRargs) throws RemoteException
        {
            jrvm.setTimestamp(JRtimestamp);
            jrvm.threadBirth();
            new Thread(new sendThread(null, handler, JRargs)).start();
            Op_ext.JRProxyOp myretOp = new Op_ext_.JRProxyOp(new InOp_ext_impl());
            myretOp.send(jrvm.getTimestamp(), (java.lang.Object []) null);
            return new Cap_ext_(myretOp, "void");
        }
        public Cap_ext cocall(long JRtimestamp, java.lang.Object [] JRargs) throws RemoteException
        {
            Op_ext.JRProxyOp retOp = new Op_ext_.JRProxyOp(new InOp_ext_impl(false));
            jrvm.setTimestamp(JRtimestamp);
            jrvm.threadBirth();
            new Thread(new sendThread(retOp, null, JRargs)).start();
            Cap_ext retCap = new Cap_ext_(retOp, "void");
            return retCap;
        }
        public Cap_ext cocall(long JRtimestamp, edu.ucdavis.jr.RemoteHandler handler, Cap_ext fretOp, java.lang.Object [] JRargs) throws RemoteException
        {
            Op_ext.JRProxyOp retOp = new Op_ext_.JRProxyOp(new InOp_ext_impl(false));
            jrvm.setTimestamp(JRtimestamp);
            jrvm.threadBirth();
            new Thread(new sendThread(retOp, fretOp, handler, JRargs)).start();
            Cap_ext retCap = new Cap_ext_(retOp, "void");
            return retCap;
        }
        public Recv_ext recv() throws RemoteException
        {
            /* This is an error */
            throw new jrRuntimeError("Receive invoked on an operation/operation capability associated with a method!");
        }
        public void deliverPendingMessages()
        {
            /* This is an error */
            throw new jrRuntimeError("Message delivery invoked on an operation associated with a method!");
        }
        public int length()
        {
            return 0;
        }
        public InOpIterator elements()
        {
            // This is an error
            throw new jrRuntimeError("Elements invoked on an operation / operation capability associated with a method!");
        }
        public InLock getLock()
        {
            // This is an error
            throw new jrRuntimeError("getLock invoked on an operation / operation capability associated with a method!");
        }
        public long getFirstTime()
        {
            // This is an error
            throw new jrRuntimeError("getFirstTime invoked on an operation / operation capability associated with a method!");
        }
        public boolean isRemote(String site)
        {
            // This is an error
            throw new jrRuntimeError("IsRemote invoked on an operation / operation capability associated with a method!");
        }
    }
    
    public Op_ext.JRProxyOp JRget_op_csp_match_intXjavadotutildotArrayListTovoid()
    {
        return op_csp_match_intXjavadotutildotArrayListTovoid;
    }
    
    public Op_ext.JRProxyOp op_csp_match_intXjavadotutildotArrayListTovoid;
    
    public Op_ext.JRProxyOp JRget_op_csp_die_intTovoid()
    {
        return op_csp_die_intTovoid;
    }
    
    public Op_ext.JRProxyOp op_csp_die_intTovoid;
    
    public Op_ext.JRProxyOp JRget_op_csp_status_intXbooleanTovoid()
    {
        return op_csp_status_intXbooleanTovoid;
    }
    
    public Op_ext.JRProxyOp op_csp_status_intXbooleanTovoid;
    
    public Op_ext.JRProxyOp JRget_op_csp_cantmatch_intXjavadotlangdotStringTovoid()
    {
        return op_csp_cantmatch_intXjavadotlangdotStringTovoid;
    }
    
    public Op_ext.JRProxyOp op_csp_cantmatch_intXjavadotlangdotStringTovoid;
    
    public Op_ext.JRProxyOp JRget_op_csp_err_voidTovoid()
    {
        return op_csp_err_voidTovoid;
    }
    
    public Op_ext.JRProxyOp op_csp_err_voidTovoid;
    
    private ArrayList[] defer;
    private // NUMBER 8
    Cap_ext_[] csp_reply;
    private csp_pidx[] csp_pidxs;
    private ArrayList csp_pdecls;
    
    public csp_coord(int csp_np, boolean csp_implicit, // NUMBER 8
    Cap_ext_[] csp_reply, csp_pidx[] csp_pidxs, ArrayList csp_pdecls) {
        // Begin Expr2
        super();
        // Begin Expr2
        this.csp_np = csp_np;
        // Begin Expr2
        this.csp_implicit = csp_implicit;
        // Begin Expr2
        this.csp_reply = csp_reply;
        // Begin Expr2
        this.csp_pidxs = csp_pidxs;
        // Begin Expr2
        this.csp_pdecls = csp_pdecls;
        // Begin Expr2
        defer = ((ArrayList[])(new Object[csp_np]));
        JRLoop0: for (int k = 0; k < csp_np; k++) {
            // Begin Expr2
            defer[k] = new ArrayList();
        }
        // Begin Expr2
        setStringPadN();
        JRget_op_csp_coordinator_voidTovoid().send(jrvm.getTimestamp(), (edu.ucdavis.jr.RemoteHandler) null, (java.lang.Object[]) null);
        JRprocess();
    }
    private static final int ALIVE = -1;
    private static final int BLOCKED = -2;
    private static final int DEAD = -3;
    private static final String[] sstat = {"**OOPS*", "ALIVE  ", "BLOCKED", "DEAD   "};
    private static final int BAD = -4;
    private int[] status;
    private int active;
    
    private void csp_coordinatorvoidTovoid(java.lang.Object [] JRargs) {
        ((Op_ext_.JRProxyOp)op_csp_coordinator_voidTovoid).call(jrvm.getTimestamp(), JRargs);
    }
    private void csp_coordinatorvoidTovoid(Op_ext.JRProxyOp retOp, Cap_ext fretOp, edu.ucdavis.jr.RemoteHandler handler, java.lang.Object [] JRargs)
    {
        try    {
            {
                InStatObj JRInstmt1 = new InStatObj(4, false);
                InStatObj JRInstmt0 = new InStatObj(1, false);
                // Begin Expr2
                status = new int[csp_np];
                JRLoop1: for (int k = 0; k < csp_np; k++) {
                    // Begin Expr2
                    status[k] = ALIVE;
                }
                // Begin Expr2
                active = csp_np;
                JRLoop9: while (active > 0) {
                    {
                        // Inni Statement without quantifier
                        JRInstmt1.armArray[0] = new QuantRec(new Cap_ext_(op_csp_match_intXjavadotutildotArrayListTovoid, "void"), 0, 0);
                        JRInstmt1.armArray[1] = new QuantRec(new Cap_ext_(op_csp_die_intTovoid, "void"), 1, 1);
                        JRInstmt1.armArray[2] = new QuantRec(new Cap_ext_(op_csp_status_intXbooleanTovoid, "void"), 2, 2);
                        JRInstmt1.armArray[3] = new QuantRec(new Cap_ext_(op_csp_cantmatch_intXjavadotlangdotStringTovoid, "void"), 3, 3);
                        JRInstmt1.lock();
                        // Equivalence Class has been created and locked
                        JRInstmt1.serviced = false;
                        _label_JRInstmt1: do
                        {
                            Invocation JRfinalInvoc1 = null;
                            // find THE invocation and service it
                            JRInstmt1.gatherAndSortTimes();
                            for (JRInstmt1.i = 0;
                                (JRInstmt1.i < JRInstmt1.N) && !JRInstmt1.serviced;
                                 JRInstmt1.i++)
                            {
                                JRInstmt1.byStrt = true;
                                JRInstmt1.releaseIter();
                                // if the op is empty
                                if (JRInstmt1.timesArray[JRInstmt1.i].time < 0) continue;
                                switch (JRInstmt1.timesArray[JRInstmt1.i].opNum)
                                {
                                    case 0:
                                    {
                                        JRInstmt1.j = 0;
                                        // Inni Arm
                                        QuantRec JRquantRec1 = (QuantRec)JRInstmt1.armArray[JRInstmt1.timesArray[JRInstmt1.i].armArrayIndex];
                                        Recv_ext JRrrecv1 = null, JRtmprecv1;
                                        int who = 0;
                                        ArrayList<csp_rr> vrr = null;
                                        for (JRInstmt1.iter = JRInstmt1.armArray[JRInstmt1.timesArray[JRInstmt1.i].armArrayIndex].theCap.elements();
                                             JRInstmt1.iter.hasNext();)
                                        {
                                            JRtmprecv1 = (Recv_ext)JRInstmt1.iter.next();
                                            JRInstmt1.JRinit.setInvoc(JRInstmt1.j++);
                                            JRtmprecv1.setInvocation(JRInstmt1.JRinit);
                                            // extract values
                                            // GetMethod 2
                                            who = ((Number) JRtmprecv1.JRargs[0]).intValue();
                                            ;
                                            vrr = (// not artificial
                                            java.util.ArrayList)JRtmprecv1.JRargs[1];
                                            if (JRget_op_csp_cantmatch_intXjavadotlangdotStringTovoid().length() == 0)
                                                JRrrecv1 = JRtmprecv1;
                                            if (JRrrecv1 != null)
                                                break;  // get first one
                                        }
                                        // Start of servicing
                                        if (JRrrecv1 != null)
                                        {
                                            JRInstmt1.j = (int)JRrrecv1.getInvoc();
                                            JRInstmt1.serviced = true;
                                            JRInstmt1.iter.remove(JRInstmt1.j);
                                            JRInstmt1.releaseIter();
                                            JRInstmt1.unlock();
                                            {
                                                try {
                                                    {
                                                        boolean some = true;
                                                        csp_rr rp;
                                                        JRLoop2: for (int k = vrr.size() - 1; k >= 0; k--) {
                                                            csp_rr r = vrr.get(k);
                                                            if (r.wwith == who) {
                                                                // Begin Expr2
                                                                System.err.println("csp2jr: process with pid " + who + " trying to " + (r.io ? "receive from" : "send to") + " itself; shutting down.");
                                                                // Begin Expr2
                                                                print_status(true);
                                                                // Begin Expr2
                                                                JR.exit(1);
                                                            }
                                                        }
                                                        if (csp_implicit) {
                                                            JRLoop3: for (int k = vrr.size() - 1; k >= 0; k--) {
                                                                csp_rr r = ((csp_rr)vrr.get(k));
                                                                if (status[r.wwith] == DEAD) {
                                                                    // Begin Expr2
                                                                    vrr.remove(k);
                                                                }
                                                            }
                                                            if (vrr.size() == 0) {
                                                                csp_reply[who].send(jrvm.getTimestamp(), (edu.ucdavis.jr.RemoteHandler) null, new java.lang.Object [] {false, BAD, 0, BAD, BAD});
                                                                // Begin Expr2
                                                                some = false;
                                                            }
                                                        }
                                                        if (some) {
                                                            boolean matched = false;
                                                            JRLoop5: for (int k = 0; k < vrr.size(); k++) {
                                                                csp_rr r = ((csp_rr)vrr.get(k));
                                                                int other = r.wwith;
                                                                if (status[other] == BLOCKED) {
                                                                    if (defer[other].size() == 0) {
                                                                        // Begin Expr2
                                                                        System.err.println("csp_coord (internal error) empty defer");
                                                                        // Begin Expr2
                                                                        JR.exit(1);
                                                                    }
                                                                    JRLoop4: for (int h = 0; h < defer[other].size(); h++) {
                                                                        csp_rr s = ((csp_rr)defer[other].get(h));
                                                                        if ((s.wwith == who) && (r.io != s.io) && (r.ioty == s.ioty)) {
                                                                            csp_reply[who].send(jrvm.getTimestamp(), (edu.ucdavis.jr.RemoteHandler) null, new java.lang.Object [] {true, other, r.arm, r.q1, r.q2});
                                                                            csp_reply[other].send(jrvm.getTimestamp(), (edu.ucdavis.jr.RemoteHandler) null, new java.lang.Object [] {true, who, s.arm, s.q1, s.q2});
                                                                            // Begin Expr2
                                                                            status[other] = ALIVE;
                                                                            // Begin Expr2
                                                                            active++;
                                                                            // Begin Expr2
                                                                            matched = true;
                                                                            { if (JRrrecv1.retOp != null)
                                                                                JRrrecv1.retOp.send(jrvm.getTimestamp(), (java.lang.Object []) null);
                                                                            break JRLoop4;}
                                                                        }
                                                                    }
                                                                    if (matched) { if (JRrrecv1.retOp != null)
                                                                        JRrrecv1.retOp.send(jrvm.getTimestamp(), (java.lang.Object []) null);
                                                                    break JRLoop5;}
                                                                }
                                                            }
                                                            if (!matched) {
                                                                // Begin Expr2
                                                                status[who] = BLOCKED;
                                                                // Begin Expr2
                                                                defer[who] = vrr;
                                                                // Begin Expr2
                                                                active--;
                                                            }
                                                        }
                                                    }
                                                } catch (Exception JRe) {
                                                    if (JRrrecv1.retOp != null && JRrrecv1.fretOp == null)
                                                    {
                                                        // forward of cocall
                                                        if ((JRrrecv1.handler != null) && !(JRe instanceof java.rmi.RemoteException))
                                                            JRrrecv1.handler.JRhandler(JRe);
                                                        else {
                                                            // give preference to propagation through the call stack
                                                            JRrrecv1.retOp.send(jrvm.getTimestamp(), JRe);
                                                            JRrrecv1.retOp = null;
                                                        }
                                                    }
                                                    else if ((JRrrecv1.retOp != null) && (JRrrecv1.fretOp != null) && !(JRe instanceof java.rmi.RemoteException))
                                                    {
                                                        // for cocall exception handling in operation invocation
                                                        if (JRrrecv1.handler != null)
                                                            JRrrecv1.handler.JRhandler(JRe);
                                                        JRrrecv1.fretOp.send(jrvm.getTimestamp(), JRrrecv1.handler, (java.lang.Object []) null);
                                                        JRrrecv1.fretOp = null;
                                                    }
                                                    else if ((JRrrecv1.handler != null) && !(JRe instanceof java.rmi.RemoteException))
                                                    {
                                                        // this should only be a send
                                                        JRrrecv1.handler.JRhandler(JRe);
                                                    }
                                                }
                                            }
                                            { if (JRrrecv1.retOp != null)
                                                JRrrecv1.retOp.send(jrvm.getTimestamp(), (java.lang.Object []) null); }
                                        }
                                        else
                                            JRInstmt1.releaseIter();
                                        // End of servicing
                                        // End InniArm
                                        break;
                                    }
                                    case 1:
                                    {
                                        JRInstmt1.j = 0;
                                        // Inni Arm
                                        QuantRec JRquantRec1 = (QuantRec)JRInstmt1.armArray[JRInstmt1.timesArray[JRInstmt1.i].armArrayIndex];
                                        Recv_ext JRrrecv1 = null, JRtmprecv1;
                                        int who = 0;
                                        for (JRInstmt1.iter = JRInstmt1.armArray[JRInstmt1.timesArray[JRInstmt1.i].armArrayIndex].theCap.elements();
                                             JRInstmt1.iter.hasNext();)
                                        {
                                            JRtmprecv1 = (Recv_ext)JRInstmt1.iter.next();
                                            JRInstmt1.JRinit.setInvoc(JRInstmt1.j++);
                                            JRtmprecv1.setInvocation(JRInstmt1.JRinit);
                                            // extract values
                                            // GetMethod 2
                                            who = ((Number) JRtmprecv1.JRargs[0]).intValue();
                                            ;
                                            if (JRget_op_csp_cantmatch_intXjavadotlangdotStringTovoid().length() == 0)
                                                JRrrecv1 = JRtmprecv1;
                                            if (JRrrecv1 != null)
                                                break;  // get first one
                                        }
                                        // Start of servicing
                                        if (JRrrecv1 != null)
                                        {
                                            JRInstmt1.j = (int)JRrrecv1.getInvoc();
                                            JRInstmt1.serviced = true;
                                            JRInstmt1.iter.remove(JRInstmt1.j);
                                            JRInstmt1.releaseIter();
                                            JRInstmt1.unlock();
                                            {
                                                try {
                                                    {
                                                        // Begin Expr2
                                                        status[who] = DEAD;
                                                        // Begin Expr2
                                                        active--;
                                                        if (csp_implicit) {
                                                            JRLoop7: for (int k = 0; k < csp_np; k++) {
                                                                if (status[k] == BLOCKED) {
                                                                    JRLoop6: for (int h = defer[k].size() - 1; h >= 0; h--) {
                                                                        csp_rr s = ((csp_rr)defer[k].get(h));
                                                                        if (s.wwith == who) {
                                                                            // Begin Expr2
                                                                            defer[k].remove(h);
                                                                        }
                                                                    }
                                                                    if (defer[k].size() == 0) {
                                                                        csp_reply[k].send(jrvm.getTimestamp(), (edu.ucdavis.jr.RemoteHandler) null, new java.lang.Object [] {false, BAD, 0, BAD, BAD});
                                                                        // Begin Expr2
                                                                        status[k] = ALIVE;
                                                                        // Begin Expr2
                                                                        active++;
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                } catch (Exception JRe) {
                                                    if (JRrrecv1.retOp != null && JRrrecv1.fretOp == null)
                                                    {
                                                        // forward of cocall
                                                        if ((JRrrecv1.handler != null) && !(JRe instanceof java.rmi.RemoteException))
                                                            JRrrecv1.handler.JRhandler(JRe);
                                                        else {
                                                            // give preference to propagation through the call stack
                                                            JRrrecv1.retOp.send(jrvm.getTimestamp(), JRe);
                                                            JRrrecv1.retOp = null;
                                                        }
                                                    }
                                                    else if ((JRrrecv1.retOp != null) && (JRrrecv1.fretOp != null) && !(JRe instanceof java.rmi.RemoteException))
                                                    {
                                                        // for cocall exception handling in operation invocation
                                                        if (JRrrecv1.handler != null)
                                                            JRrrecv1.handler.JRhandler(JRe);
                                                        JRrrecv1.fretOp.send(jrvm.getTimestamp(), JRrrecv1.handler, (java.lang.Object []) null);
                                                        JRrrecv1.fretOp = null;
                                                    }
                                                    else if ((JRrrecv1.handler != null) && !(JRe instanceof java.rmi.RemoteException))
                                                    {
                                                        // this should only be a send
                                                        JRrrecv1.handler.JRhandler(JRe);
                                                    }
                                                }
                                            }
                                            { if (JRrrecv1.retOp != null)
                                                JRrrecv1.retOp.send(jrvm.getTimestamp(), (java.lang.Object []) null); }
                                        }
                                        else
                                            JRInstmt1.releaseIter();
                                        // End of servicing
                                        // End InniArm
                                        break;
                                    }
                                    case 2:
                                    {
                                        JRInstmt1.j = 0;
                                        // Inni Arm
                                        QuantRec JRquantRec1 = (QuantRec)JRInstmt1.armArray[JRInstmt1.timesArray[JRInstmt1.i].armArrayIndex];
                                        Recv_ext JRrrecv1 = null, JRtmprecv1;
                                        int who = 0;
                                        boolean brief = false;
                                        for (JRInstmt1.iter = JRInstmt1.armArray[JRInstmt1.timesArray[JRInstmt1.i].armArrayIndex].theCap.elements();
                                             JRInstmt1.iter.hasNext();)
                                        {
                                            JRtmprecv1 = (Recv_ext)JRInstmt1.iter.next();
                                            JRInstmt1.JRinit.setInvoc(JRInstmt1.j++);
                                            JRtmprecv1.setInvocation(JRInstmt1.JRinit);
                                            // extract values
                                            // GetMethod 2
                                            who = ((Number) JRtmprecv1.JRargs[0]).intValue();
                                            ;
                                            brief = (// not artificial
                                            Boolean)JRtmprecv1.JRargs[1];
                                            if (JRget_op_csp_cantmatch_intXjavadotlangdotStringTovoid().length() == 0)
                                                JRrrecv1 = JRtmprecv1;
                                            if (JRrrecv1 != null)
                                                break;  // get first one
                                        }
                                        // Start of servicing
                                        if (JRrrecv1 != null)
                                        {
                                            JRInstmt1.j = (int)JRrrecv1.getInvoc();
                                            JRInstmt1.serviced = true;
                                            JRInstmt1.iter.remove(JRInstmt1.j);
                                            JRInstmt1.releaseIter();
                                            JRInstmt1.unlock();
                                            {
                                                try {
                                                    {
                                                        // Begin Expr2
                                                        System.err.println("csp2jr: printing status " + "on request of process with pid " + who);
                                                        // Begin Expr2
                                                        print_status(brief);
                                                    }
                                                } catch (Exception JRe) {
                                                    if (JRrrecv1.retOp != null && JRrrecv1.fretOp == null)
                                                    {
                                                        // forward of cocall
                                                        if ((JRrrecv1.handler != null) && !(JRe instanceof java.rmi.RemoteException))
                                                            JRrrecv1.handler.JRhandler(JRe);
                                                        else {
                                                            // give preference to propagation through the call stack
                                                            JRrrecv1.retOp.send(jrvm.getTimestamp(), JRe);
                                                            JRrrecv1.retOp = null;
                                                        }
                                                    }
                                                    else if ((JRrrecv1.retOp != null) && (JRrrecv1.fretOp != null) && !(JRe instanceof java.rmi.RemoteException))
                                                    {
                                                        // for cocall exception handling in operation invocation
                                                        if (JRrrecv1.handler != null)
                                                            JRrrecv1.handler.JRhandler(JRe);
                                                        JRrrecv1.fretOp.send(jrvm.getTimestamp(), JRrrecv1.handler, (java.lang.Object []) null);
                                                        JRrrecv1.fretOp = null;
                                                    }
                                                    else if ((JRrrecv1.handler != null) && !(JRe instanceof java.rmi.RemoteException))
                                                    {
                                                        // this should only be a send
                                                        JRrrecv1.handler.JRhandler(JRe);
                                                    }
                                                }
                                            }
                                            { if (JRrrecv1.retOp != null)
                                                JRrrecv1.retOp.send(jrvm.getTimestamp(), (java.lang.Object []) null); }
                                        }
                                        else
                                            JRInstmt1.releaseIter();
                                        // End of servicing
                                        // End InniArm
                                        break;
                                    }
                                    case 3:
                                    {
                                        JRInstmt1.j = 0;
                                        // Inni Arm
                                        QuantRec JRquantRec1 = (QuantRec)JRInstmt1.armArray[JRInstmt1.timesArray[JRInstmt1.i].armArrayIndex];
                                        Recv_ext JRrrecv1 = null, JRtmprecv1;
                                        int who = 0;
                                        String msg = null;
                                        for (JRInstmt1.iter = JRInstmt1.armArray[JRInstmt1.timesArray[JRInstmt1.i].armArrayIndex].theCap.elements();
                                             JRInstmt1.iter.hasNext();)
                                        {
                                            JRtmprecv1 = (Recv_ext)JRInstmt1.iter.next();
                                            JRInstmt1.JRinit.setInvoc(JRInstmt1.j++);
                                            JRtmprecv1.setInvocation(JRInstmt1.JRinit);
                                            // extract values
                                            // GetMethod 2
                                            who = ((Number) JRtmprecv1.JRargs[0]).intValue();
                                            ;
                                            msg = (// not artificial
                                            java.lang.String)JRtmprecv1.JRargs[1];
                                            JRrrecv1 = JRtmprecv1;
                                            break;  // get first one
                                        }
                                        // Start of servicing
                                        if (JRrrecv1 != null)
                                        {
                                            JRInstmt1.j = (int)JRrrecv1.getInvoc();
                                            JRInstmt1.serviced = true;
                                            JRInstmt1.iter.remove(JRInstmt1.j);
                                            JRInstmt1.releaseIter();
                                            JRInstmt1.unlock();
                                            {
                                                try {
                                                    {
                                                        JRget_op_csp_cantmatch_intXjavadotlangdotStringTovoid().send(jrvm.getTimestamp(), (edu.ucdavis.jr.RemoteHandler) null, new java.lang.Object [] {who, msg});
                                                        try {
                                                            // Begin Expr2
                                                            Thread.sleep(400);
                                                        } catch (java.lang.Exception oops) {
                                                            // Begin Expr2
                                                            System.err.println("Exception while sleeping...\n");
                                                            // Begin Expr2
                                                            oops.printStackTrace();
                                                        }
                                                        JRLoop8: while (JRget_op_csp_cantmatch_intXjavadotlangdotStringTovoid().length() > 0) {
                                                            {
                                                                // Inni Statement without quantifier
                                                                JRInstmt0.armArray[0] = new QuantRec(new Cap_ext_(op_csp_cantmatch_intXjavadotlangdotStringTovoid, "void"), 0, 0);
                                                                JRInstmt0.lock();
                                                                // Equivalence Class has been created and locked
                                                                JRInstmt0.serviced = false;
                                                                _label_JRInstmt0: do
                                                                {
                                                                    Invocation JRfinalInvoc0 = null;
                                                                    // find THE invocation and service it
                                                                    JRInstmt0.gatherAndSortTimes();
                                                                    for (JRInstmt0.i = 0;
                                                                        (JRInstmt0.i < JRInstmt0.N) && !JRInstmt0.serviced;
                                                                         JRInstmt0.i++)
                                                                    {
                                                                        JRInstmt0.byStrt = true;
                                                                        JRInstmt0.releaseIter();
                                                                        // if the op is empty
                                                                        if (JRInstmt0.timesArray[JRInstmt0.i].time < 0) continue;
                                                                        switch (JRInstmt0.timesArray[JRInstmt0.i].opNum)
                                                                        {
                                                                            case 0:
                                                                            {
                                                                                JRInstmt0.j = 0;
                                                                                // Inni Arm
                                                                                QuantRec JRquantRec0 = (QuantRec)JRInstmt0.armArray[JRInstmt0.timesArray[JRInstmt0.i].armArrayIndex];
                                                                                Recv_ext JRrrecv0 = null, JRtmprecv0;
                                                                                int wwho = 0;
                                                                                String mmsg = null;
                                                                                for (JRInstmt0.iter = JRInstmt0.armArray[JRInstmt0.timesArray[JRInstmt0.i].armArrayIndex].theCap.elements();
                                                                                     JRInstmt0.iter.hasNext();)
                                                                                {
                                                                                    JRtmprecv0 = (Recv_ext)JRInstmt0.iter.next();
                                                                                    JRInstmt0.JRinit.setInvoc(JRInstmt0.j++);
                                                                                    JRtmprecv0.setInvocation(JRInstmt0.JRinit);
                                                                                    // extract values
                                                                                    // GetMethod 2
                                                                                    wwho = ((Number) JRtmprecv0.JRargs[0]).intValue();
                                                                                    ;
                                                                                    mmsg = (// not artificial
                                                                                    java.lang.String)JRtmprecv0.JRargs[1];
                                                                                    JRInstmt0.curVal = wwho;
                                                                                    if (JRInstmt0.byStrt || (JRInstmt0.curVal < JRInstmt0.byVal))
                                                                                    {
                                                                                        JRInstmt0.byStrt = false;
                                                                                        JRInstmt0.byVal = JRInstmt0.curVal;
                                                                                        JRInstmt0.curInvoc = JRInstmt0.iter.getCurInvoc();
                                                                                        JRrrecv0 = JRtmprecv0;
                                                                                    }
                                                                                }
                                                                                // Start of servicing
                                                                                if (JRrrecv0 != null)
                                                                                {
                                                                                    JRInstmt0.serviced = true;
                                                                                    JRInstmt0.iter.remove(JRInstmt0.curInvoc);
                                                                                    // GetMethod 4
                                                                                    wwho = ((Number) JRrrecv0.JRargs[0]).intValue();
                                                                                    mmsg = (java.lang.String)JRrrecv0.JRargs[1];
                                                                                    JRInstmt0.releaseIter();
                                                                                    JRInstmt0.unlock();
                                                                                    {
                                                                                        try {
                                                                                            {
                                                                                                // Begin Expr2
                                                                                                System.err.println("csp2jr: process with id " + wwho + ": " + mmsg);
                                                                                            }
                                                                                        } catch (Exception JRe) {
                                                                                            if (JRrrecv0.retOp != null && JRrrecv0.fretOp == null)
                                                                                            {
                                                                                                // forward of cocall
                                                                                                if ((JRrrecv0.handler != null) && !(JRe instanceof java.rmi.RemoteException))
                                                                                                    JRrrecv0.handler.JRhandler(JRe);
                                                                                                else {
                                                                                                    // give preference to propagation through the call stack
                                                                                                    JRrrecv0.retOp.send(jrvm.getTimestamp(), JRe);
                                                                                                    JRrrecv0.retOp = null;
                                                                                                }
                                                                                            }
                                                                                            else if ((JRrrecv0.retOp != null) && (JRrrecv0.fretOp != null) && !(JRe instanceof java.rmi.RemoteException))
                                                                                            {
                                                                                                // for cocall exception handling in operation invocation
                                                                                                if (JRrrecv0.handler != null)
                                                                                                    JRrrecv0.handler.JRhandler(JRe);
                                                                                                JRrrecv0.fretOp.send(jrvm.getTimestamp(), JRrrecv0.handler, (java.lang.Object []) null);
                                                                                                JRrrecv0.fretOp = null;
                                                                                            }
                                                                                            else if ((JRrrecv0.handler != null) && !(JRe instanceof java.rmi.RemoteException))
                                                                                            {
                                                                                                // this should only be a send
                                                                                                JRrrecv0.handler.JRhandler(JRe);
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    { if (JRrrecv0.retOp != null)
                                                                                        JRrrecv0.retOp.send(jrvm.getTimestamp(), (java.lang.Object []) null); }
                                                                                }
                                                                                else
                                                                                    JRInstmt0.releaseIter();
                                                                                // End of servicing
                                                                                // End InniArm
                                                                                break;
                                                                            }
                                                                            
                                                                        }
                                                                    }
                                                                    if (!JRInstmt0.serviced)
                                                                    {
                                                                        // must block and loop
                                                                        JRInstmt0.waitOnLock();
                                                                    }
                                                                } while (!JRInstmt0.serviced);
                                                            }
                                                            // End Inni
                                                            
                                                        }
                                                        // Begin Expr2
                                                        print_status(true);
                                                        // Begin Expr2
                                                        JR.exit(1);
                                                    }
                                                } catch (Exception JRe) {
                                                    if (JRrrecv1.retOp != null && JRrrecv1.fretOp == null)
                                                    {
                                                        // forward of cocall
                                                        if ((JRrrecv1.handler != null) && !(JRe instanceof java.rmi.RemoteException))
                                                            JRrrecv1.handler.JRhandler(JRe);
                                                        else {
                                                            // give preference to propagation through the call stack
                                                            JRrrecv1.retOp.send(jrvm.getTimestamp(), JRe);
                                                            JRrrecv1.retOp = null;
                                                        }
                                                    }
                                                    else if ((JRrrecv1.retOp != null) && (JRrrecv1.fretOp != null) && !(JRe instanceof java.rmi.RemoteException))
                                                    {
                                                        // for cocall exception handling in operation invocation
                                                        if (JRrrecv1.handler != null)
                                                            JRrrecv1.handler.JRhandler(JRe);
                                                        JRrrecv1.fretOp.send(jrvm.getTimestamp(), JRrrecv1.handler, (java.lang.Object []) null);
                                                        JRrrecv1.fretOp = null;
                                                    }
                                                    else if ((JRrrecv1.handler != null) && !(JRe instanceof java.rmi.RemoteException))
                                                    {
                                                        // this should only be a send
                                                        JRrrecv1.handler.JRhandler(JRe);
                                                    }
                                                }
                                            }
                                            { if (JRrrecv1.retOp != null)
                                                JRrrecv1.retOp.send(jrvm.getTimestamp(), (java.lang.Object []) null); }
                                        }
                                        else
                                            JRInstmt1.releaseIter();
                                        // End of servicing
                                        // End InniArm
                                        break;
                                    }
                                    
                                }
                            }
                            if (!JRInstmt1.serviced)
                            {
                                // must block and loop
                                JRInstmt1.waitOnLock();
                            }
                        } while (!JRInstmt1.serviced);
                    }
                    // End Inni
                    
                }
                try {
                    // Begin Expr2
                    Thread.sleep(200);
                } catch (java.lang.Exception oops) {
                    // Begin Expr2
                    System.err.println("Exception while sleeping...\n");
                    // Begin Expr2
                    oops.printStackTrace();
                }
                // Begin Expr2
                System.err.println("csp2jr: all user processes have terminated or are blocked; shutting down.");
                // Begin Expr2
                print_status(true);
                // Return
                { if (retOp != null)
                    retOp.send(jrvm.getTimestamp(), (edu.ucdavis.jr.RemoteHandler) null, null);
                return ; }
                // End Return

            }
        } catch (Exception JRe)    {
            if (retOp != null && fretOp == null)
            {
        	// if it is a forward cocall with handler
        	if ((handler != null) && !(JRe instanceof java.rmi.RemoteException))
        	    handler.JRhandler(JRe);
        	else
        	    // give preference to propagation through the call stack
        	    retOp.send(jrvm.getTimestamp(), JRe);
            }
            else if ((retOp != null) && (fretOp != null) && !(JRe instanceof java.rmi.RemoteException))
            {
        	// for COSTMT exception handling in operation
        	if (handler != null)
        	    handler.JRhandler(JRe);
        	fretOp.send(jrvm.getTimestamp(), handler, (java.lang.Object []) null);
            }
            else if ((handler != null) && !(JRe instanceof java.rmi.RemoteException))
            {
        	// this should only be for a send/forward
        	handler.JRhandler(JRe);
        	// can rethrow below just to get out of this method
            }
            // rethrow the proper type of exception
            // catch all
            throw new jrRuntimeError("Unhandled exception: " + JRe.toString());
        }
    }
    
    
    private void print_status(boolean brief) {
        int blocked = 0;
        JRLoop10: for (int k = 0; k < csp_np; k++) {
            if (status[k] == BLOCKED) // Begin Expr2
            blocked++;
        }
        int dead = csp_np - active - blocked;
        // Begin Expr2
        System.err.println("csp2jr: process status: " + csp_np + " total = " + active + " alive + " + blocked + " blocked + " + dead + " dead.");
        if (brief && (blocked == csp_np || active == csp_np || dead == csp_np)) // Return
        return;
        // End Return

        JRLoop11: for (int k = 0; k < csp_np; k++) {
            csp_pdecl d = ((csp_pdecl)((csp_pdecl)csp_pdecls.get(csp_pidxs[k].pd)));
            // Begin Expr2
            System.err.print(pad4(k) + " " + sstat[-status[k]] + "  " + pad10(d.name) + " ");
            if (d.dims > 0) {
                // Begin Expr2
                System.err.print("[" + pad4(csp_pidxs[k].i1) + "]");
            }
            if (d.dims > 1) {
                // Begin Expr2
                System.err.print("[" + pad4(csp_pidxs[k].i2) + "]");
            }
            // Begin Expr2
            System.err.println();
        }
    }
    
    private String pad4(int i) {
        if (i < 0 || i >= 1000) // Return
        return ("" + i);
        // End Return

        if (i < 10) // Return
        return ("   " + i);
        // End Return

        if (i < 100) // Return
        return ("  " + i);
        // End Return

        // Return
        return (" " + i);
        // End Return

    }
    private static final int maxPad = 10;
    
    private String pad10(String s) {
        if (s.length() >= stringPad) // Return
        return (s);
        // End Return

        // Return
        return ("         ".substring(0, stringPad - s.length()) + s);
        // End Return

    }
    private static int stringPad;
    
    private void setStringPadN() {
        // Begin Expr2
        stringPad = 1;
        JRLoop12: for (int csp_p = 0; csp_p < csp_pdecls.size(); csp_p++) {
            csp_pdecl d = ((csp_pdecl)((csp_pdecl)csp_pdecls.get(csp_p)));
            if (d.name.length() > maxPad) {
                // Begin Expr2
                stringPad = maxPad;
                // Return
                return;
                // End Return

            }
            if (d.name.length() > stringPad) {
                // Begin Expr2
                stringPad = d.name.length();
            }
        }
    }
    protected boolean JRcalled = false;
    protected JRcsp_coord jrresref;
    public Object JRgetjrresref()
    { try {return jrresref.clone(); } catch (Exception e) {/* not gonna happen */ return null; } }
    protected void JRinit() {
    	if(this.JRcalled) return;
    	try {
    	op_csp_coordinator_voidTovoid = new Op_ext_.JRProxyOp(new ProcOp_voidTovoid_implcsp_coordinator(this));
    	op_csp_err_voidTovoid = 
    	  new Op_ext_.JRProxyOp(new InOp_ext_impl());
    	{
     	  long JRTotal = 0;
    	  if (JRTotal < 0) throw new jrRuntimeError("op initialized with a negative value");
    	    for (long JRiter = 0; JRiter < JRTotal; JRiter++)
    	      op_csp_err_voidTovoid.send(jrvm.getTimestamp(), (java.lang.Object []) null);
    	}
    	op_csp_cantmatch_intXjavadotlangdotStringTovoid = 
    	  new Op_ext_.JRProxyOp(new InOp_ext_impl());
    	op_csp_status_intXbooleanTovoid = 
    	  new Op_ext_.JRProxyOp(new InOp_ext_impl());
    	op_csp_die_intTovoid = 
    	  new Op_ext_.JRProxyOp(new InOp_ext_impl());
    	op_csp_match_intXjavadotutildotArrayListTovoid = 
    	  new Op_ext_.JRProxyOp(new InOp_ext_impl());
    	} catch (Exception JRe)
    	{ throw new jrRuntimeError(JRe.toString()); }
    	jrresref = new JRcsp_coord(op_csp_err_voidTovoid, op_csp_cantmatch_intXjavadotlangdotStringTovoid, op_csp_status_intXbooleanTovoid, op_csp_die_intTovoid, op_csp_match_intXjavadotutildotArrayListTovoid, op_csp_coordinator_voidTovoid);
    	this.JRcalled = true;
    }
    private boolean JRproc = false;
    private void JRprocess() {
    	if (JRproc) return;
    	JRproc = true;
    }
}
