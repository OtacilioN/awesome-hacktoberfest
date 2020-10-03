// contact class

public class Contact{
	
	static String fname,lname,dob,email,tel,mob;
	Contact(String fname,String lname,String dob,String email,String tel,String mob){
		this.fname=fname;
		this.lname=lname;
		this.dob=dob;
		this.email=email;
		this.tel=tel;
		this.mob=mob;
	}
	public static void validate(String fname,String lname,String dob,String email,String tel,String mob) throws NotValidException{
		if(fname.length()==0 || fname.length()==0 || fname.length()==0 || fname.length()==0){
			throw new NotValidException("Not valid");
		}
		else if(tel.length()==0 && mob.length()==0){
			throw new NotValidException("Either telephone or mobile number must exist");
		}
		else if(email != null){
			String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\."+ 
                    "[a-zA-Z0-9_+&*-]+)*@" + 
                    "(?:[a-zA-Z0-9-]+\\.)+[a-z" + 
                    "A-Z]{2,7}$"; 
			if(email.matches(emailRegex))
				System.out.println("Email is valid");
			else
				throw new NotValidException("Not a valid email-id");
		}
		else{
			System.out.println("Accepted");
		}
	}
	public static void main(String[] args)throws NotValidException {
		Contact c=new Contact("amit","mitra","12-12-1998","amit14mitra@gmail.com","03332561254","9854123674");
		try{
		validate(fname,lname,dob,email,tel,mob);
		}
		catch(NotValidException e){
			e.printStackTrace();
			//System.out.println("Not valid :"+e);
		}
		finally{
			System.out.println("Finally block executed");
		}
	}
	
}
//namestack which extends contact


public class Stack extends Contact{
	int size;
	String arr[];
	int top;
 
	Stack(String fname,String lname,String dob,String email,String tel,String mob,int size) {
		super(fname,lname,dob,email,tel,mob);
		this.size = size;
		this.arr = new String[size];
		this.top = -1;
	}
	private static void validate1(String pushElement) throws NotValidException {
		String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\."+ 
                "[a-zA-Z0-9_+&*-]+)*@" + 
                "(?:[a-zA-Z0-9-]+\\.)+[a-z" + 
                "A-Z]{2,7}$";
		if(pushElement.length()==0)
			throw new NotValidException("It is not valid!!!");
	}
	public void push(String pushedElement)throws NotValidException {
		try{
			validate1(pushedElement);
		}
		catch(NotValidException e){
			e.printStackTrace();
		}
		if (top != size-1) {
			top++;
			arr[top] = pushedElement;
			System.out.println("Pushed element:" + pushedElement);
		} else {
			try{
				throw new overflowException("overflow occurs!!!");
			}
			catch(overflowException e){
				e.printStackTrace();
			}
		}
	}
 
	public void pop() {
		if (top >= 0) {
			int returnedTop = top;
			top--;
			System.out.println("Popped element :" + arr[returnedTop]);
			//return arr[returnedTop];
 
		} else {
			try{
				throw new underflowException("underflow occurs!!!");
			}
			catch(underflowException e){
				e.printStackTrace();
			}
			//return -1;
		}
	}
 
	public static void main(String[] args) throws NotValidException {
		Stack s = new Stack("amit","mitra","12-12-1998","amit14mitra@gmail.com","03332561254","9854123674",10);
		Contact c=new Contact("amit","mitra","12-12-1998","amit14mitra@gmail.com","03332561254","9857463214");
		//StackCustom.pop();
		System.out.println("=================");
		s.push(c.fname);s.push(c.lname);s.push(c.dob);s.push(c.email);s.push(c.tel);s.push(c.mob);
		System.out.println("=================");
		s.pop();s.pop();s.pop();s.pop();s.pop();s.pop();
		//System.out.println(arr[top]);
	}
}

// all exception classes
public class underflowException extends Exception {
	public underflowException(String s){
		super(s);
	}
}

public class NotValidException extends Exception {
	public NotValidException(String s) {
		super(s);
	}
}

public class overflowException extends Exception {
	public overflowException(String s){
		super(s);
	}
}
