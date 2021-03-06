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
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.util.Date ; 

/**
 *
 * @author sn
 */
public class Connector  {
    
    
public static int get_tablespace_id(String s , Connection conn){
    int res = 0; 
    try{
    String query = " Select ID FROM TABLESPACE WHERE TABLESPACE_NAME = '"+s+"'" ; 
    Statement stmt = conn.createStatement();
    ResultSet resultSet = stmt.executeQuery(query);
    res = Integer.parseInt(resultSet.getString("ID")) ; 
    }catch(Exception e){}
    return res ; 
}    

public static String put_plicas(String s){
    String res  = '\''+s+'\'' ; 
    return res ; 
}
    
    
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
            String query2 = ""; 
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
            
            query = "SELECT  a.tablespace_name,\n" +
"    ROUND (((c.BYTES - NVL (b.BYTES, 0)) / c.BYTES) * 100,2) percentage_used,\n" +
"    c.BYTES / 1024 / 1024 space_allocated,\n" +
"    ROUND (c.BYTES / 1024 / 1024 - NVL (b.BYTES, 0) / 1024 / 1024,2) space_used,\n" +
"    ROUND (NVL (b.BYTES, 0) / 1024 / 1024, 2) space_free, \n" +
"    c.DATAFILES\n" +
"  FROM dba_tablespaces a,\n" +
"       (    SELECT   tablespace_name, \n" +
"                  SUM (BYTES) BYTES\n" +
"           FROM   dba_free_space\n" +
"       GROUP BY   tablespace_name\n" +
"       ) b,\n" +
"      (    SELECT   COUNT (1) DATAFILES, \n" +
"                  SUM (BYTES) BYTES, \n" +
"                  tablespace_name\n" +
"           FROM   dba_data_files\n" +
"       GROUP BY   tablespace_name\n" +
"    ) c\n" +
"  WHERE b.tablespace_name(+) = a.tablespace_name \n" +
"    AND c.tablespace_name(+) = a.tablespace_name\n" +
"ORDER BY NVL (((c.BYTES - NVL (b.BYTES, 0)) / c.BYTES), 0) DESC;" ; 
            resultSet = stmt.executeQuery(query);
            
            
            System.out.println("Printing Tablespaces \"TABLESPACE\" ");
            System.out.println("----------------------------------");
            
            
            int i = 1 ; 
            query = "INSERT INTO tablespace(id, tablespace_name ,status ,total_size ,used_size, timestamp) "
                    + "VALUES(?, ?, ?, ?, ?,?)" ; 
            PreparedStatement psmt = conn2.prepareStatement(query) ; 
            String name ; 
            String status ; 
            Timestamp t = null ; 
            while(resultSet.next())
            {
                //Print
                t = new Timestamp(System.currentTimeMillis()) ; 
                name = resultSet.getString("tablespace_name"); 
                status = resultSet.getString("status"); 
                //System.out.println(resultSet.getString("tablespace_name"));
                psmt.setInt(1,i++) ; 
                psmt.setString(2,name) ;
                psmt.setString(3,status) ;
                psmt.setInt(4,0) ; 
                psmt.setInt(5,0) ; 
                psmt.setTimestamp(6,t) ; 
                psmt.executeUpdate() ; 
                System.out.println(">>>>> " + psmt);
                }
            
            
            /**
            query = "SELECT * FROM V$DATAFILE_HEADER" ; 
            resultSet = stmt.executeQuery(query);
            System.out.println("Printing DATAFILE_NAME \"DATAFILE\" ");
            System.out.println("----------------------------------");
            query = "INSERT INTO datafile(id, datafile_name ,file_size ,used_size, status, tablespace , timestamp) "
                    + "VALUES(?, ?, ?, ?, ?, ?, ?)" ; 
            psmt = conn2.prepareStatement(query) ;             
            i=1 ; 
            while(resultSet.next())
            {
                //System.out.println(resultSet.getString("tablespace_name"));
                t = new Timestamp(System.currentTimeMillis()) ; 
                name = resultSet.getString("name"); 
                status = resultSet.getString("status");
                int fk_id = get_tablespace_id(resultSet.getString("tablespace_name") , conn2);
                psmt.setInt(1,i++) ; 
                psmt.setString(2,name) ;                
                psmt.setInt(3,0) ;
                psmt.setInt(4,0) ;
                psmt.setString(5,status) ;
                psmt.setInt(6,fk_id) ;
                psmt.setTimestamp(7,t) ;
                psmt.executeUpdate() ; 
                System.out.println(">>>>> " + psmt);
                }
            */
            
            /**
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
            
            
            /** 
             * possivel tablespaces getter
            SELECT  a.tablespace_name,
    ROUND (((c.BYTES - NVL (b.BYTES, 0)) / c.BYTES) * 100,2) percentage_used,
    c.BYTES / 1024 / 1024 space_allocated,
    ROUND (c.BYTES / 1024 / 1024 - NVL (b.BYTES, 0) / 1024 / 1024,2) space_used,
    ROUND (NVL (b.BYTES, 0) / 1024 / 1024, 2) space_free, 
    c.DATAFILES
  FROM dba_tablespaces a,
       (    SELECT   tablespace_name, 
                  SUM (BYTES) BYTES
           FROM   dba_free_space
       GROUP BY   tablespace_name
       ) b,
      (    SELECT   COUNT (1) DATAFILES, 
                  SUM (BYTES) BYTES, 
                  tablespace_name
           FROM   dba_data_files
       GROUP BY   tablespace_name
    ) c
  WHERE b.tablespace_name(+) = a.tablespace_name 
    AND c.tablespace_name(+) = a.tablespace_name
ORDER BY NVL (((c.BYTES - NVL (b.BYTES, 0)) / c.BYTES), 0) DESC; 
            
             */
           
            
    }catch(ClassNotFoundException e){
        System.out.println(e) ; 
        }catch(SQLException e){
            System.out.println(e) ; 
            }
        



}

}