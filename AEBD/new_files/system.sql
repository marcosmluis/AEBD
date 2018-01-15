-- TEM DE SER NA ROOT !!!
-- ORCL12

INSERT INTO "MANAGER".SYSTEM
(TIMESTAMP , WRITES, READS , FREE_MEMORY)
select c.CURRENT_TIMESTAMP,  v1.mem, v2.writes , v3.rrs
    from 
    ( select sum(bytes)/1024 mem
        from v$sgastat where name = 'free memory') v1,
    (select SUM(VALUE) writes
        from ( select metric_name,begin_time,end_time,value 
            from v$sysmetric_history 
                where metric_name = 'Physical Writes Per Sec' 
                    order by 2 )) v2,
    (select SUM(VALUE) rrs 
        from ( select metric_name,begin_time,end_time,value 
            from v$sysmetric_history 
                where metric_name = 'Physical Reads Per Sec' 
                    order by 2 )) v3 ,
    (SELECT CURRENT_TIMESTAMP FROM dual) c ;