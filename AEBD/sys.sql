CREATE TABLESPACE tp_tables
DATAFILE  '\u01\app\oracle\oradata\orcl12\orcl\tp_tables_01.dbf'
SIZE 100M;


CREATE TEMPORARY TABLESPACE tp_temp
TEMPFILE  '\u01\app\oracle\oradata\orcl12\orcl\tp_temp_01.dbf'
SIZE 50M 
AUTOEXTEND ON;

select * from dba_tablespaces;

CREATE USER Manager
    IDENTIFIED BY pass
    DEFAULT TABLESPACE tp_tables
    TEMPORARY TABLESPACE tp_temp;
    GRANT CONNECT TO Manager
    
select * from dba_users;

CREATE ROLE my_role1;

GRANT CREATE table, CREATE view,CREATE procedure
        TO my_role1;
        

GRANT myrole1 TO Manager;

SELECT * FROM USER_ROLE_PRIVS;

SELECT * FROM dba_sys_privs where GRANTEE = 'Manager';



GRANT CREATE table TO Manager;

GRANT CREATE view TO Manager;

GRANT CREATE procedure TO Manager;

GRANT ALTER ANY table TO  Manager;
