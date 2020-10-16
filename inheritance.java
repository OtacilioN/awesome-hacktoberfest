import java.util.*;

class Person {
	protected String firstName;
	protected String lastName;
	protected int idNumber;
	
	// Constructor
	Person(String firstName, String lastName, int identification){
		this.firstName = firstName;
		this.lastName = lastName;
		this.idNumber = identification;
	}
	
	// Print person data
	public void printPerson(){
		 System.out.println(
				"Name: " + lastName + ", " + firstName 
			+ 	"\nID: " + idNumber); 
	}
	 
}

class Student extends Person{
	private int[] testScores;
    private float total=0;
    private float avg;
    protected char grade;
    Student(String firstName,String lastName,int IdNumber,int [] testScores)
    {
        super(firstName,lastName,IdNumber);
        this.firstName=firstName;
        this.lastName=lastName;
        this.idNumber=IdNumber;
        this.testScores=testScores;
    }
    public char calculate(){
        for(int i=0;i<testScores.length;i++){
            total=total+testScores[i];
        }
        avg=total/testScores.length;
        if(avg<40){
            grade='T';
        }
        else if(avg<55){
            grade='D';
        }
        else if(avg<70){
            grade='P';
        }
        else if(avg<80){
            grade='A';
        }
        else if(avg<90){
            grade='E';
        }
        else if(avg<=100){
            grade='O';
        }
        return grade;
    }
}
class Solution {
	public static void main(String[] args) {
		Scanner scan = new Scanner(System.in);
		String firstName = scan.next();
		String lastName = scan.next();
		int id = scan.nextInt();
		int numScores = scan.nextInt();
		int[] testScores = new int[numScores];
		for(int i = 0; i < numScores; i++){
			testScores[i] = scan.nextInt();
		}
		scan.close();
		
		Student s = new Student(firstName, lastName, id, testScores);
		s.printPerson();
		System.out.println("Grade: " + s.calculate() );
	}
}
