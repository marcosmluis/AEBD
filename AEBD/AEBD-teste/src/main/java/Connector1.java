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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author sn
 */
public class Connector1  {

    
public static void main(String[] args){
 
    Connection conn1 = null;
    Connection conn2 = null;
    Connection conn3 = null;
    
    try{
    Class.forName("oracle.jdbc.OracleDriver");
    
    // METHOD #2
            String dbURL1 = "jdbc:oracle:thin:@//localhost:1521/orcl" ;
            String username = "sys as SYSDBA";
            String password = "oracle";            
            conn1 = DriverManager.getConnection(dbURL1, username, password);
            
            String dbURL2 = "jdbc:oracle:thin:@//localhost:1521/orcl" ;
            String username2 = "Manager";
            String password2 = "pass";            
            conn2 = DriverManager.getConnection(dbURL2, username2, password2);
            
            
            String dbURL3 = "jdbc:oracle:thin:@//localhost:1521/orcl12c" ;
            String username3 = "sys as SYSDBA";
            String password3 = "oracle";            
            conn1 = DriverManager.getConnection(dbURL3, username3, password3);
            
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
            if (conn3 != null) {
                System.out.println("Connected with connection #3");
            }
            else{
                System.out.println(".....") ; 
            }
            
            while(true){
            // TABELSPACES
            String tbs = "select fs.tablespace_name NAME , (df.totalspace - fs.freespace) USED_SIZE, " +
                        " fs.freespace FREE_SIZE, df.totalspace TOTAL_SIZE, c.CURRENT_TIMESTAMP TIMESTAMP "+
                   " from (select tablespace_name, round(sum(bytes) / 1048576) TotalSpace "+
                    " from dba_data_files group by tablespace_name) df, " +              
                    " (select tablespace_name, round(sum(bytes) / 1048576) FreeSpace "+
                    " from dba_free_space group by tablespace_name) fs, "+
                    " (SELECT CURRENT_TIMESTAMP FROM dual) c " + 
                    " where df.tablespace_name = fs.tablespace_name" ; 
            
            Statement stmt = conn1.createStatement();
            ResultSet resultSet = stmt.executeQuery(tbs);         
            tbs = "INSERT INTO TABLESPACE (NAME,USED_SIZE,FREE_SIZE,TOTAL_SIZE,TIMESTAMP) "
                    + "VALUES(?, ?, ?, ?, ?)" ; 
            PreparedStatement psmt = conn2.prepareStatement(tbs) ; 
            int i = 0 ; 
            while(resultSet.next()){
                System.out.println(i++);
                psmt.setString(1,resultSet.getString("NAME")) ; 
                psmt.setFloat(2,Float.parseFloat(resultSet.getString("USED_SIZE"))) ; 
                psmt.setFloat(3,Float.parseFloat(resultSet.getString("FREE_SIZE"))) ; 
                psmt.setFloat(4,Float.parseFloat(resultSet.getString("TOTAL_SIZE"))) ; 
                psmt.setTimestamp(5,resultSet.getTimestamp(5)) ; 
                psmt.executeUpdate() ; 
            }
            
            // DATAFILES
            
            String data = "SELECT Substr(df.tablespace_name,1,20) NAME_DF, " +
                            "Substr(df.file_name,1,40) NAME_TB, " +
                            "Round(df.bytes/1024/1024,2) FILE_SIZE, " +
                            "Round(e.used_bytes/1024/1024,2) USED_SIZE, " +
                            "Round(f.free_bytes/1024/1024,2) FREE_SIZE, " +
                            "c.CURRENT_TIMESTAMP TIMESTAMP, " +
                            "d.CURRENT_TIMESTAMP TIMESTAMP_FK " +
                            " FROM DBA_DATA_FILES DF, " +
                            " (SELECT file_id, " +
                            " Sum(Decode(bytes,NULL,0,bytes)) used_bytes " +
                            " FROM dba_extents " +
                            " GROUP by file_id) E, " +
                            " (SELECT Max(bytes) free_bytes, file_id " +
                            " FROM dba_free_space " +
                            " GROUP BY file_id) f, " +
                            " (SELECT CURRENT_TIMESTAMP FROM dual) c, " +
                            " (SELECT CURRENT_TIMESTAMP FROM dual) d " +
                            " WHERE e.file_id (+) = df.file_id " +
                            " AND df.file_id = f.file_id (+) " +
                            " ORDER BY df.tablespace_name,df.file_name" ; 
            resultSet = stmt.executeQuery(data);         
            data = "INSERT INTO DATAFILE (NAME_DF,NAME_TB,FILE_SIZE,USED_SIZE,FREE_SIZE,TIMESTAMP,TIMESTAMP_FK) "
                    + "VALUES(?, ?, ?, ?, ?, ?, ?)" ; 
            psmt = conn2.prepareStatement(data) ; 
            while(resultSet.next()){
                psmt.setString(1,resultSet.getString("NAME_DF")) ;
                psmt.setString(2,resultSet.getString("NAME_TB")) ;
                psmt.setFloat(3,Float.parseFloat(resultSet.getString("FILE_SIZE"))) ; 
               if(resultSet.getString("USED_SIZE") != null )
                psmt.setFloat(4,Float.parseFloat(resultSet.getString("USED_SIZE"))) ; 
               else 
                psmt.setNull(4,java.sql.Types.NUMERIC) ;    
                psmt.setFloat(5,Float.parseFloat(resultSet.getString("FREE_SIZE"))) ; 
                psmt.setTimestamp(6,resultSet.getTimestamp(6)) ; 
                psmt.setNull(7,java.sql.Types.TIMESTAMP) ; 
                psmt.executeUpdate() ; 
            }
            
            // USERS
            
            String users = "select USER_ID,USERNAME,ACCOUNT_STATUS,"+
                        "DEFAULT_TABLESPACE DEFAULT_TB,TEMPORARY_TABLESPACE TEMP_TB,CREATED,c.CURRENT_TIMESTAMP " +
                         " from dba_users, " + 
                        " (SELECT CURRENT_TIMESTAMP FROM dual) c " +
                        " where ACCOUNT_STATUS = 'OPEN' "+
                        " order by 1" ; 
            resultSet = stmt.executeQuery(users); 
            users = "INSERT INTO USERS (USER_ID,USERNAME,ACCOUNT_STATUS,DEFAULT_TB,TEMP_TB,CREATED,TIMESTAMP, TIMESTAMP_FK,TIMESTAMP_FK2) "
                    + "VALUES(?, ?, ?, ?, ?, ?, ?,? , ?)" ; 
            psmt = conn2.prepareStatement(users) ; 
           while(resultSet.next()){
                psmt.setString(1,resultSet.getString("USER_ID")) ;
                psmt.setString(2,resultSet.getString("USERNAME")) ;
                psmt.setString(3,resultSet.getString("ACCOUNT_STATUS")) ;               
                psmt.setString(4,resultSet.getString("DEFAULT_TB")) ;
                psmt.setString(5,resultSet.getString("TEMP_TB")) ;
                psmt.setDate(6,resultSet.getDate("CREATED")) ;
                psmt.setTimestamp(7,resultSet.getTimestamp(7)) ; 
                psmt.setNull(8,java.sql.Types.TIMESTAMP) ; 
                psmt.setNull(9,java.sql.Types.TIMESTAMP) ; 
                psmt.executeUpdate() ; 
            }
           
           // SESSIONS
           
           String ses = "select SID, USER# USER_ID, USERNAME, SERIAL# SERIAL ,c.CURRENT_TIMESTAMP TIMESTAMP" +
                        " from v$session, (SELECT CURRENT_TIMESTAMP FROM dual) c " + 
                        " order by 1" ;  
           resultSet = stmt.executeQuery(ses);
           ses = "INSERT INTO SESSIONS (SID,USER_ID,USERNAME,SERIAL,TIMESTAMP, TIMESTAMP_FK)"
                    + "VALUES(?, ?, ?, ?, ?, ? )" ; 
           psmt = conn2.prepareStatement(ses) ; 
           while(resultSet.next()){
                psmt.setString(1,resultSet.getString("SID")) ;
                psmt.setInt(2,Integer.parseInt(resultSet.getString("USER_ID")));
                psmt.setString(3,resultSet.getString("USERNAME")) ;
                psmt.setString(4,resultSet.getString("SERIAL")) ;
                psmt.setTimestamp(5,resultSet.getTimestamp(5)) ; 
                psmt.setNull(6,java.sql.Types.TIMESTAMP) ;
                psmt.executeUpdate() ; 
            }
           
           // IO
           
           String io = "select c.CURRENT_TIMESTAMP  TIMESTAMP ,  v1.mem FREE_MEMORY, v2.writes WRITES , v3.rrs READS" +
                        " from ( select sum(bytes)/1024 mem " +
                        " from v$sgastat where name = 'free memory') v1, " +
                        " (select SUM(VALUE) writes " +
                        " from ( select metric_name,begin_time,end_time,value " +
                        " from v$sysmetric_history " +
                        " where metric_name = 'Physical Writes Per Sec' " +
                        " order by 2 )) v2, " +
                        " (select SUM(VALUE) rrs " +
                        " from ( select metric_name,begin_time,end_time,value " +
                        " from v$sysmetric_history " +
                        " where metric_name = 'Physical Reads Per Sec' " +
                        " order by 2 )) v3 , " +
                        " (SELECT CURRENT_TIMESTAMP FROM dual) c " ; 
           resultSet = stmt.executeQuery(io);
           io = "INSERT INTO IO (TIMESTAMP , WRITES, READS , FREE_MEMORY)"
                    + "VALUES(?, ?, ?, ?)" ; ; 
           psmt = conn2.prepareStatement(io) ;
            while(resultSet.next()){
                psmt.setTimestamp(1,resultSet.getTimestamp(1)) ;            
                psmt.setFloat(2,Float.parseFloat(resultSet.getString("WRITES"))) ; 
                psmt.setFloat(3,Float.parseFloat(resultSet.getString("READS"))) ; 
                psmt.setFloat(4,Float.parseFloat(resultSet.getString("FREE_MEMORY"))) ;                 
                psmt.executeUpdate() ; 
            }
           Thread.sleep(30000);
            }
            
    }catch(ClassNotFoundException e){
        System.out.println(e) ; 
        }catch(SQLException e){
            System.out.println(e) ; 
            } catch (InterruptedException ex) {
        Logger.getLogger(Connector1.class.getName()).log(Level.SEVERE, null, ex);
    }
        



}

}