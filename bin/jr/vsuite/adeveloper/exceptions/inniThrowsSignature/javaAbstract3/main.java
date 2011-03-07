// simple use of exceptions on code that you might find within a parser.
// the code here is similar to HW2 parsing for expressions.

// define our own exception.
// it's derived from the predefined Java Exception class.
// in general, you can have anything you would in a regular class.
// here we have just a simple constructor;
// often, the class will be just empty.
class ParsingExpressionException extends Exception {
    public ParsingExpressionException(String msg){
        super(msg); // call constructor in superclass (i.e., base class);
                    // it outputs message and a bit more.
    }
}

// when an exception is thrown within a method,
// it must be caught (using a try block) within that method
// or the method must declare that it throws the exception
// because the exception is propagated up the call chain.
// in this example, we have no handler for ParsingExpressionException
// in some methods, so each of those methods must declare that
// it throws that exception.
// (the others also declare they throw it even if they don't, which is fine.)

public class main implements AA {

    public void gogo() throws Exception { System.out.println("gogo"); }


    public static void main(String [] args) throws Exception {
        System.out.println("+ main");
        parse();
        System.out.println("- main");
    }

    private static void parse() throws Exception {
        System.out.println("+ parse");
        block();
        System.out.println("- parse");
    }

    private static void block() throws Exception {
        System.out.println("+ block");
        expression();
        System.out.println("- block");
    }

    private static void expression() throws Exception {
        try {
            System.out.println("+ expression");
            simple();
            System.out.println("- expression");
        }
        // catches only ParsingExpressionException.
        // could add other catch arms for other exceptions.
        // to catch any exception can use
        //   catch(Exception e)
        // because all exceptions are derived from the Exception base class.
        catch (Exception e) {
            System.out.println("+ catch within expression");
            // show the call stack that got us here.
            e.printStackTrace();
            System.out.println("- catch within expression");
        }
    }

    private static void simple() throws Exception {
        System.out.println("+ simple");
        term();
        System.out.println("- simple");
    }

    private static void term() throws Exception {
        System.out.println("+ term");
        factor();
        System.out.println("- term");
    }

    private static void factor() throws Exception {
	//throws ParsingExpressionException {
        System.out.println("+ factor");
        // OK, we'll pretend we have an error here
        // (e.g., current token isn't `(', id, or a number)
        // so raise an exception.
	throw new ParsingExpressionException("problem parsing factor");
        // anything after a throw is not reachable
    }

}
