INSERT INTO "MANAGER".USERS
(USER_ID,USERNAME,ACCOUNT_STATUS,DEFAULT_TB,TEMP_TB,CREATED,TIMESTAMP)
select USER_ID,USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,TEMPORARY_TABLESPACE,CREATED,c.CURRENT_TIMESTAMP 
from dba_users,
(SELECT CURRENT_TIMESTAMP FROM dual) c
where ACCOUNT_STATUS = 'OPEN'
order by 1;

select * from "MANAGER".USERS