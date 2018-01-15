-- DATAFILE SIZE etc etc
INSERT INTO "MANAGER".DATAFILE
(NAME_DF,NAME_TB,FILE_SIZE,USED_SIZE,FREE_SIZE,TIMESTAMP)
SELECT Substr(df.tablespace_name,1,20) "Tablespace Name",
Substr(df.file_name,1,40) "File Name",
Round(df.bytes/1024/1024,2) "Size (M)",
Round(e.used_bytes/1024/1024,2) "Used (M)",
Round(f.free_bytes/1024/1024,2) "Free (M)",
c.CURRENT_TIMESTAMP
FROM DBA_DATA_FILES DF,
(SELECT file_id,
Sum(Decode(bytes,NULL,0,bytes)) used_bytes
FROM dba_extents
GROUP by file_id) E,
(SELECT Max(bytes) free_bytes, file_id
FROM dba_free_space
GROUP BY file_id) f,
(SELECT CURRENT_TIMESTAMP FROM dual) c
WHERE e.file_id (+) = df.file_id
AND df.file_id = f.file_id (+)
ORDER BY df.tablespace_name,df.file_name;
