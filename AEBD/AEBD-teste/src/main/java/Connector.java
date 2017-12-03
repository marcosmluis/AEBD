/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.lang.String ; 

/**
 *
 * @author sn
 */
public class Connector  {
        
    
public static void main(String[] args){
 
    Connection conn1 = null;
    Connection conn2 = null;
    
    try{
    Class.forName("oracle.jdbc.OracleDriver");
    
    // METHOD #2
            String dbURL1 = "jdbc:oracle:thin:@//localhost:1521/orcl" ;
            String username = "sys as SYSDBA";
            String password = "oracle";
            
            conn1 = DriverManager.getConnection(dbURL1, username, password);
            
            String dbURL2 = "jdbc:oracle:thin:@//localhost:1521/orcl" ;
            String username2 = "Nelson";
            String password2 = "pass";
            
            conn2 = DriverManager.getConnection(dbURL2, username2, password2);
            
            if (conn1 != null) {
                System.out.println("Connected with connection #1");
            }
            else{
                System.out.println(".....") ; 
            }
            
            if (conn2 != null) {
                System.out.println("Connected with connection #2");
            }
            else{
                System.out.println(".....") ; 
            }
            
            
            String query = " Select * FROM user_tables ";
            Statement stmt = conn1.createStatement();
            ResultSet resultSet = stmt.executeQuery(query);
            /**
            System.out.println("Printing TABLE_TYPE \"TABLE\" ");
            System.out.println("----------------------------------");
            while(resultSet.next())
            {
                //Print
                System.out.println(resultSet.getString("TABLE_NAME"));
                }
            */
            
            query = "SELECT * FROM dba_tablespaces" ; 
            resultSet = stmt.executeQuery(query);
            System.out.println("Printing Tablespaces \"TABLESPACE\" ");
            System.out.println("----------------------------------");
            int i = 1 ; 
            while(resultSet.next())
            {
                //Print
                
                System.out.println(resultSet.getString("tablespace_name"));                
                }
                Statement st = conn2.createStatement() ; 
                String name = "BBBB" ; 
                String s = "INSERT INTO TABLESPACE " + "VALUES ("+ i++ +","+ name + ", 'ONLINE' , 0 , 0 ,NULL)" ; 
                System.out.println(s) ; 
                System.out.println(st.executeUpdate(s)) ;
            
            
            /**
            query = "SELECT * FROM V$DATAFILE" ; 
            resultSet = stmt.executeQuery(query);
            System.out.println("Printing DATAFILE_NAME \"DATAFILE\" ");
            System.out.println("----------------------------------");
            while(resultSet.next())
            {
                //Print
                System.out.println(resultSet.getString("NAME"));
                }
    
            query = "SELECT * FROM DBA_USERS" ; 
            resultSet = stmt.executeQuery(query);
            System.out.println("Printing USER_NAME \"USER\" ");
            System.out.println("----------------------------------");
            while(resultSet.next())
            {
                //Print
                System.out.println(resultSet.getString("USERNAME"));
                }
            
            query = "SELECT * FROM  V$SESSION" ; 
            resultSet = stmt.executeQuery(query);
            System.out.println("Printing SESSION_ID \"USER\" ");
            System.out.println("----------------------------------");
            while(resultSet.next())
            {
                //Print
                System.out.println(resultSet.getString("SID") + "   " + resultSet.getString("USERNAME") );
                }
            */
            
            
           
            
    }catch(ClassNotFoundException e){
        System.out.println(e) ; 
        }catch(SQLException e){
            System.out.println(e) ; 
            }
        



}

}