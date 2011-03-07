/*****************************************************
 * jr generated file
 ****************************************************/
import edu.ucdavis.jr.*;
import edu.ucdavis.jr.jrx.*;
import java.rmi.*;
import java.io.Serializable;


import edu.ucdavis.jr.JR;

public class main extends java.lang.Object {
    { JRinit(); }
    
    public main() {
        // Begin Expr2
        super();
        JRprocess();
    }
    public static int num;
    public static int result = 1;
    
    public static void main(String[] args) {
        try {
            // Begin Expr2
            num = 10;
            // Begin Expr2
            System.out.println(num + "! = ");
            // Begin Expr2
            JR.registerQuiescenceAction(new Cap_ext_(JRget_op_foo_voidTovoid()));
        } catch (edu.ucdavis.jr.QuiescenceRegistrationException e) {
            // Begin Expr2
            e.printStackTrace();
        }
    }
    public static Op_ext.JRProxyOp JRget_op_foo_voidTovoid()
    {
        return op_foo_voidTovoid;
    }
    
    public static Op_ext.JRProxyOp op_foo_voidTovoid;
    ;
    static    {
        try    {
            op_foo_voidTovoid = new Op_ext_.JRProxyOp(new InOp_ext_impl());
        } catch (Exception e) { throw new jrRuntimeError(e.toString());}
    }
    
    public static Op_ext.JRProxyOp JRget_op_goo_voidTovoid()
    {
        return op_goo_voidTovoid;
    }
    
    public static Op_ext.JRProxyOp op_goo_voidTovoid;
    static class ProcOp_voidTovoid_implgoo extends ProcOp_ext_impl
    {
        public ProcOp_voidTovoid_implgoo(main thisIn) throws RemoteException
        {
        }
        public java.lang.Object call(long JRtimestamp, java.lang.Object [] JRargs) throws RemoteException
        {
            jrvm.ariseAndReceive();  // from caller
            try    {
                jrvm.setTimestamp(JRtimestamp);
                main.goovoidTovoid(null, null, null, JRargs);
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
                    main.goovoidTovoid(this.retOp, this.fretOp, this.handler, this.JRargs);
                } catch (Exception e) {/* should be safe to ignore this exception */}
                jrvm.threadDeath();
            }
        }
        public void send(long JRtimestamp, java.lang.Object [] JRargs) throws RemoteException
        {
            this.send(JRtimestamp, null, null, null, JRargs);
        }
        public void send(long JRtimestamp, edu.ucdavis.jr.RemoteHandler handler, java.lang.Object [] JRargs) throws RemoteException
        {
            this.send(JRtimestamp, null, handler, null, JRargs);
        }
        public Cap_ext cosend(long JRtimestamp, java.lang.Object [] JRargs) throws RemoteException
        {
            return this.cosend(JRtimestamp, null, null, null, JRargs);
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
    ;
    static    {
        try    {
            op_goo_voidTovoid = new Op_ext_.JRProxyOp(new ProcOp_voidTovoid_implgoo(null));
        } catch (Exception e) { throw new jrRuntimeError(e.toString());}
    }
    
    public static void goovoidTovoid(java.lang.Object [] JRargs) {
        ((Op_ext_.JRProxyOp)op_goo_voidTovoid).call(jrvm.getTimestamp(), JRargs);
    }
    private static void goovoidTovoid(Op_ext.JRProxyOp retOp, Cap_ext fretOp, edu.ucdavis.jr.RemoteHandler handler, java.lang.Object [] JRargs)
    {
        try    {
            {
                InStatObj JRInstmt0 = new InStatObj(1, false);
                JRLoop0: while (true) {
                    Op_ext.JRProxyOp op_gogo_voidTovoid = null;
                    try{
                        op_gogo_voidTovoid = new Op_ext_.JRProxyOp(new InOp_ext_impl());
                    } catch (Exception e) { throw new jrRuntimeError("Cannot initialize op"); }
                    
                    
                    // Receive
                    {
                        jrvm.sendAndDie();
                        Recv_ext recv_voidTovoid = op_gogo_voidTovoid.recv();
                        jrvm.ariseAndReceive();
                        if (recv_voidTovoid.retOp != null)
                            recv_voidTovoid.retOp.send(jrvm.getTimestamp(), (java.lang.Object[]) null);
                    }
                    // End Receive
                    
                    {
                        // Inni Statement without quantifier
                        JRInstmt0.armArray[0] = new QuantRec(new Cap_ext_(op_foo_voidTovoid, "void"), 0, 0);
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
                                        for (JRInstmt0.iter = JRInstmt0.armArray[JRInstmt0.timesArray[JRInstmt0.i].armArrayIndex].theCap.elements();
                                             JRInstmt0.iter.hasNext();)
                                        {
                                            JRtmprecv0 = (Recv_ext)JRInstmt0.iter.next();
                                            JRInstmt0.JRinit.setInvoc(JRInstmt0.j++);
                                            JRtmprecv0.setInvocation(JRInstmt0.JRinit);
                                            // extract values
                                            JRrrecv0 = JRtmprecv0;
                                            break;  // get first one
                                        }
                                        // Start of servicing
                                        if (JRrrecv0 != null)
                                        {
                                            JRInstmt0.j = (int)JRrrecv0.getInvoc();
                                            JRInstmt0.serviced = true;
                                            JRInstmt0.iter.remove(JRInstmt0.j);
                                            JRInstmt0.releaseIter();
                                            JRInstmt0.unlock();
                                            {
                                                try {
                                                    {
                                                        if (num <= 1) {
                                                            // Begin Expr2
                                                            System.out.println(result);
                                                        } else {
                                                            try {
                                                                // Begin Expr2
                                                                result *= num;
                                                                // Begin Expr2
                                                                num--;
                                                                // Begin Expr2
                                                                JR.registerQuiescenceAction(new Cap_ext_(JRget_op_foo_voidTovoid()));
                                                            } catch (edu.ucdavis.jr.QuiescenceRegistrationException e) {
                                                                // Begin Expr2
                                                                e.printStackTrace();
                                                            }
                                                        }
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
                                                            else {
                                                                // catch all
                                                                throw new jrRuntimeError("Unhandled exception: " + JRe.toString()+ " at " + jrRuntimeError.where(JRe));
                                                            }
JRrrecv0.fretOp.send(jrvm.getTimestamp(), JRrrecv0.handler, (java.lang.Object []) null);
                                                        JRrrecv0.fretOp = null;
                                                    }
                                                    else if ((JRrrecv0.handler != null) && !(JRe instanceof java.rmi.RemoteException))
                                                    {
                                                        // this should only be a send
                                                        JRrrecv0.handler.JRhandler(JRe);
                                                    }
    else {
                                                            // catch all
                                                            throw new jrRuntimeError("Unhandled exception: " + JRe.toString()+ " at " + jrRuntimeError.where(JRe));
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
            throw new jrRuntimeError("Unhandled exception: " + JRe.toString()+ " at "+ jrRuntimeError.where(JRe));
        }
    }
    static {
        try {
            op_goo_voidTovoid.send(jrvm.getTimestamp(), (java.lang.Object []) null);
        } catch (Exception JRe) { throw new jrRuntimeError(JRe.toString()); }
    };
    
    protected boolean JRcalled = false;
    protected JRmain jrresref;
    public Object JRgetjrresref()
    { try {return jrresref.clone(); } catch (Exception e) {/* not gonna happen */ return null; } }
    protected void JRinit() {
    	if(this.JRcalled) return;
    	jrresref = new JRmain(op_goo_voidTovoid, op_foo_voidTovoid);
    	this.JRcalled = true;
    }
    private boolean JRproc = false;
    private void JRprocess() {
    	if (JRproc) return;
    	JRproc = true;
    }
}
