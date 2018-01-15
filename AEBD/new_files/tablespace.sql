INSERT INTO "MANAGER".TABLESPACE
(NAME,USED_SIZE,FREE_SIZE,TOTAL_SIZE,TIMESTAMP)
select
   fs.tablespace_name                          "Tablespace",
   (df.totalspace - fs.freespace)              "Used MB",
   fs.freespace                                "Free MB",
   df.totalspace                               "Total MB",
   c.CURRENT_TIMESTAMP
from
   (select
      tablespace_name,
      round(sum(bytes) / 1048576) TotalSpace
   from
      dba_data_files
   group by
      tablespace_name
   ) df,
   (select
      tablespace_name,
      round(sum(bytes) / 1048576) FreeSpace
   from
      dba_free_space
   group by
      tablespace_name
   ) fs,
   (SELECT CURRENT_TIMESTAMP FROM dual) c
where
   df.tablespace_name = fs.tablespace_name;
   
   
   
select * from "MANAGER".TABLESPACE ; 