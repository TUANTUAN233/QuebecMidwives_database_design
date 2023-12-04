import java.sql.*;
import java.util.Scanner;

public class GoBabbyApp {
    public static void main ( String [ ] args ) throws SQLException
    {
      // Unique table names.  Either the user supplies a unique identifier as a command line argument, or the program makes one up.
        String tableName = "";
        int sqlCode=0;      // Variable to hold SQLCODE
        String sqlState="00000";  // Variable to hold SQLSTATE


        // Register the driver.  You must register the driver before you can use it.
        try { DriverManager.registerDriver ( new com.ibm.db2.jcc.DB2Driver() ) ; }
        catch (Exception cnfe){ System.out.println("Class not found"); }

        // This is the url you must use for DB2.
        //Note: This url may not valid now ! Check for the correct year and semester and server name.
        String url = "jdbc:db2://winter2022-comp421.cs.mcgill.ca:50000/cs421";

        //REMEMBER to remove your user id and password before submitting your code!!
        String your_userid = "";
        String your_password = "";
        //AS AN ALTERNATIVE, you can just set your password in the shell environment in the Unix (as shown below) and read it from there.
        //$  export SOCSPASSWD=yoursocspasswd 
        if(your_userid == null && (your_userid = System.getenv("SOCSUSER")) == null)
        {
          System.err.println("Error!! do not have a password to connect to the database!");
          System.exit(1);
        }
        if(your_password == null && (your_password = System.getenv("SOCSPASSWD")) == null)
        {
          System.err.println("Error!! do not have a password to connect to the database!");
          System.exit(1);
        }
        Connection con = DriverManager.getConnection (url,your_userid,your_password) ;
        Statement statement = con.createStatement ( ) ;

        //set a boolean
        boolean pracidValid = false;
        int validPracid = -1;
        while(!pracidValid){
            //enter practioner id
            System.out.println("Please enter your practitioner id [E] to exit:");
            Scanner inputID = new Scanner(System.in);
            //read the input as string
            String input1 = "";
            input1 = inputID.nextLine();
            //close the scanner
            //inputID.close();
            if(input1.equals("E")){
                System.out.println("Exit the application");
                statement.close();
                con.close();
                System.exit(0);
            }
            try{
                int pracid = Integer.parseInt(input1);
                pracidValid = findID(sqlCode, sqlState, statement, pracid);
                if(pracidValid){
                    System.out.println("ID is valid");
                    validPracid = pracid;
                    break;
                }
                System.out.println("Invalid ID,please try again");

            }
            catch(Exception e){
                System.out.println("Invalid format,please try again");
            }


        }
        System.out.println("ID:"+validPracid);

        String date = "";
        boolean dateValid = false;
        while(!dateValid){
            //enter the date
            System.out.println("Please enter the date for appointment list [E] to exit:");
            Scanner inputDate = new Scanner(System.in);
            //read the input as string
            String input2 = "";
            input2 = inputDate.nextLine();
            //close the scanner
            //inputDate.close();
            if(input2.equals("E")){
                System.out.println("Exit the application");
                statement.close();
                con.close();
                System.exit(0);
            }
            try{
                dateValid = findDate(sqlCode, sqlState, statement, validPracid, input2);
                while(dateValid){
                    System.out.println("Appointments exits on this date");
                    date = input2;
                    System.out.println("date:"+date);
                    //now move to the appo list
                    int[] appointidArray = new int [10];
                    int[] idArray = new int[10];
                    int[] nthArray = new int[10];
                    String[] nameArray = new String[10];
                    int[] cardArray = new int[10]; 
                    //display all the appo
            
                    String s = "((SELECT Appointments.appointid, Appointments.time,'B' AS property,Mothers.name,Mothers.healthid,Pregnancies.coupleid,Pregnancies.nthnum"+
                    " FROM Appointments,Pregnancies, Mothers,Couples,Midwives "+" WHERE Appointments.pracid = Midwives.pracid AND Mothers.healthid = Couples.Mhealthid AND Couples.coupleid = Pregnancies.coupleid AND "+
                    " Pregnancies.bpracid = Midwives.pracid AND Appointments.coupleid = Couples.coupleid AND Appointments.nthnum = Pregnancies.nthnum AND Appointments.date=\'" + date +"\'"+ " AND Midwives.pracid= "+ Integer.toString(validPracid)+")"+
                    " UNION " +" (SELECT Appointments.appointid, Appointments.time,'P' AS property,Mothers.name,Mothers.healthid,Pregnancies.coupleid,Pregnancies.nthnum"+
                    " FROM Appointments,Pregnancies, Mothers,Couples,Midwives "+" WHERE Appointments.pracid = Midwives.pracid AND Mothers.healthid = Couples.Mhealthid AND Couples.coupleid = Pregnancies.coupleid AND "+
                    " Pregnancies.ppracid = Midwives.pracid AND Appointments.coupleid = Couples.coupleid AND Appointments.nthnum = Pregnancies.nthnum AND Appointments.date=\'" + date +"\'"+ " AND Midwives.pracid= "+ Integer.toString(validPracid)+"))"+" ORDER BY 1";
                    try{
                    java.sql.ResultSet rs = statement.executeQuery(s);
                    int i = 0;
                    while(rs.next()){
                        i = i+1;
                        int appointid = rs.getInt("appointid");
                        java.sql.Time time = rs.getTime("time");
                    
                        String property =  rs.getString("property");
                        String name = rs.getString("name");
                        Integer healthid = rs.getInt("healthid");
                        Integer coupleid = rs.getInt("coupleid");
                        Integer nthnum = rs.getInt("nthnum");
                        System.out.println(i+":  "+time+"  "+property+"  "+name+"  "+healthid);
                        appointidArray[i] = appointid;
                        idArray[i] = coupleid;
                        nthArray[i] = nthnum;
                        nameArray[i] = name;
                        cardArray[i] = healthid;
                    }
                    }
                    catch(SQLException e){
                        sqlCode = e.getErrorCode();
                        sqlState = e.getSQLState();
                        System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
                        System.out.println(e);
                    }
                        
                    System.out.println("Enter the appointment number that you would like to work on."+
                        "[E] to exit [D] to go back to another date :");
                    
                    Scanner inputnum = new Scanner(System.in);
                    String input3 = "";
                    input3 = inputnum.nextLine();
                    if(input3.equals("E")){
                        System.out.println("Exit the application");
                        statement.close();
                        con.close();
                        System.exit(0);
                    }
                    if(input3.equals("D")){
                        dateValid = false;
                        break;
                    }
                    int choice = Integer.parseInt(input3);
                    String nameSelect = nameArray[choice];
                    int healthidSelect = cardArray[choice];
                    int coupleidSelect = idArray[choice];
                    int nthSelect = nthArray[choice];
                    int a = appointidArray[choice];
                    String appointidSelect = String.valueOf(a);
                    /*
                    System.out.println(choice);
                    System.out.println(nameSelect);
                    System.out.println(healthidSelect);
                    System.out.println(coupleidSelect);
                    System.out.println(nthSelect);
                    System.out.println(appointidSelect);
                    */
                    boolean back = false;
                    while(!back){
                        int option = promptForInput(nameSelect, healthidSelect);
                        if(option==1){
                            System.out.println("Review notes");
                            reviewNote( coupleidSelect, nthSelect, sqlCode, sqlState,statement);
                            continue;
                        }
                        if(option==2){
                            System.out.println("Review tests");
                            reviewtests( coupleidSelect, nthSelect, sqlCode, sqlState,statement);
                            continue;
                        }
                        if(option==3){
                            System.out.println("option 3");
                            addnote(sqlCode, sqlState, statement, date,appointidSelect);
                            continue;
                        }
                        if(option==4){
                            System.out.println("option 4");
                            addTest(sqlCode, sqlState, statement, date, appointidSelect);
                            continue;
                        }
                        if(option==5){
                            System.out.println("Back to list");
                            break;
                        }

                    }
                    
                        
            
                    
                }
                
            }
            catch(Exception e){
                System.out.println("Something goes wrong");
            }

        }
 




    }

    public static boolean findID(int sqlCode,String sqlState,Statement statement,int pracid){
        boolean found = false;

        try{
            String s = "SELECT * FROM Midwives WHERE pracid=" + Integer.toString(pracid);
            java.sql.ResultSet query = statement.executeQuery(s);
            if(query.next()){
                found = true;
            }
        }
        catch(SQLException e){
            sqlCode = e.getErrorCode();
            sqlState = e.getSQLState();
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e);
        }
        return found;
    }

    public static boolean findDate(int sqlCode,String sqlState,Statement statement,int validPracid,String input2){
        boolean found = false;
        String s = "SELECT * FROM Midwives,Appointments WHERE Midwives.pracid =" + Integer.toString(validPracid) +" AND Appointments.date = \'"+ input2 +"\'";
        //System.out.println(s);
        try{
            java.sql.ResultSet query = statement.executeQuery(s);
            if(query.next()){
                found = true;
            }
        }
        catch(SQLException e){
            sqlCode = e.getErrorCode();
            sqlState = e.getSQLState();
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e);
        }
        return found;

    }
    //prompt
    public static int promptForInput(String nameSelect, int healthidSelect){
        int option = 0;
        System.out.println("For  "+nameSelect+"  "+healthidSelect);
        System.out.println(
        "1. Review notes\n\t"+
        "2. Review tests\n\t"+
        "3. Add a note\n\t"+
        "4. Prescribe a test\n\t"+
        "5. Go back to the appointments.\n\t");
        System.out.println("\nEnter your choice:");
        Scanner input = new Scanner(System.in);
        option = input.nextInt();
        return option;
    }

    public static void reviewNote(int coupleidSelect, int nthSelect,int sqlCode,String sqlState,Statement statement){
        String s = "SELECT Appointments.date, Notes.Ntime, Notes.content FROM Appointments,Notes WHERE Notes.appointid = Appointments.appointid AND Appointments.coupleid = " + Integer.toString(coupleidSelect)+ "  AND Appointments.nthnum = "+ Integer.toString(nthSelect) + " ORDER BY DATE DESC";
        try{
            java.sql.ResultSet rs = statement.executeQuery(s);
            while(rs.next()){
                java.sql.Date date = rs.getDate("date");
                java.sql.Time time = rs.getTime("Ntime");
                String content = rs.getString("content");
                System.out.println(date +"  "+time +"  "+content);
            }
        }
        catch(SQLException e){
            sqlCode = e.getErrorCode();
            sqlState = e.getSQLState();
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e);
        }

    }
    public static void reviewtests(int coupleidSelect, int nthSelect,int sqlCode,String sqlState,Statement statement){
        String s = "SELECT Appointments.date,type,result FROM Appointments,Tests WHERE Tests.appointid = Appointments.appointid AND Appointments.coupleid ="+ Integer.toString(coupleidSelect) +" AND Appointments.nthnum =" + Integer.toString(nthSelect) + " ORDER BY DATE DESC";
        try{
            java.sql.ResultSet rs = statement.executeQuery(s);
            while(rs.next()){
                java.sql.Date date = rs.getDate("date");
                String type = rs.getString("type");
                String result = rs.getString("result");
                if(result== "null"){
                    System.out.println(date+"  "+ type +"  "+ "pending");
                    return;
                }
                System.out.println(date+"  "+ type +"  "+ result);
            }
        }
        catch(SQLException e){
            sqlCode = e.getErrorCode();
            sqlState = e.getSQLState();
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e);
        }
    }

    public static void addnote(int sqlCode,String sqlState,Statement statement, String date,String appointidSelect){
        System.out.println("Please type your observation:");
        Scanner input = new Scanner(System.in);
        String note = input.nextLine();

        String s = "INSERT INTO Notes(Ntime,appointid,content) Values"+ "(now()," + appointidSelect +",'"+ note +"')";
        System.out.println(s);
        try{
            System.out.println("reach");
            statement.executeUpdate ( s) ;
            System.out.println ( "DONE" ) ;
        }
        catch(SQLException e){
          sqlCode = e.getErrorCode(); // Get SQLCODE
          sqlState = e.getSQLState(); // Get SQLSTATE
                
          System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
          System.out.println(e);
        }


    }
    public static void addTest(int sqlCode,String sqlState,Statement statement, String date,String appointidSelect){
        System.out.println("Please enter the type of test:");
        Scanner input = new Scanner(System.in);
        String testtype = input.nextLine();
        String s = "INSERT INTO Tests(testid,type,appointid) VALUES"+"(7791,'"+ testtype +"',"+ appointidSelect+")";
        System.out.println(s);
        try{
            statement.executeUpdate ( s) ;
            System.out.println ( "DONE" ) ;
        }
        catch (SQLException e){
          sqlCode = e.getErrorCode(); // Get SQLCODE
          sqlState = e.getSQLState(); // Get SQLSTATE
                
          System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
          System.out.println(e);
        }

    }

    
}