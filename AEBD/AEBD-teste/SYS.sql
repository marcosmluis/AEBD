select b.tablespace_name, tbs_size SizeMb, a.free_space FreeMb
from 
(select tablespace_name, round(sum(bytes)/1024/1024 ,2) as free_space 
from dba_free_space group by tablespace_name) a, 
(select tablespace_name, sum(bytes)/1024/1024 as tbs_size 
from dba_data_files group by tablespace_name
UNION
select tablespace_name, sum(bytes)/1024/1024 tbs_size
from dba_temp_files
group by tablespace_name ) b
where a.tablespace_name(+)=b.tablespace_name;



select
   fs.tablespace_name                          "Tablespace",
   (df.totalspace - fs.freespace)              "Used MB",
   fs.freespace                                "Free MB",
   df.totalspace                               "Total MB",
   round(100 * (fs.freespace / df.totalspace)) "Pct. Free"
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
   ) fs
where
   df.tablespace_name = fs.tablespace_name;
   
   
   
SELECT round(sum(INITIAL_EXTENT) / 1048576) TotalSpace  FROM dba_tablespaces   ;



-- TABLESPACES NAMES AND DATA
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
   
   

-- DATAFILE SIZE etc etc
SELECT Substr(df.tablespace_name,1,20) "Tablespace Name",
Substr(df.file_name,1,40) "File Name",
Round(df.bytes/1024/1024,2) "Size (M)",
Round(e.used_bytes/1024/1024,2) "Used (M)",
Round(f.free_bytes/1024/1024,2) "Free (M)",
Rpad(' '|| Rpad ('X',Round(e.used_bytes*10/df.bytes,0), 'X'),11,'-') "% Used"
FROM DBA_DATA_FILES DF,
(SELECT file_id,
Sum(Decode(bytes,NULL,0,bytes)) used_bytes
FROM dba_extents
GROUP by file_id) E,
(SELECT Max(bytes) free_bytes,
file_id
FROM dba_free_space
GROUP BY file_id) f
WHERE e.file_id (+) = df.file_id
AND df.file_id = f.file_id (+)
ORDER BY df.tablespace_name,
df.file_name;

   
   
   
   