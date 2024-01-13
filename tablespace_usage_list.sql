set feed off
set lines 120 pages 1000
col tablespace_name format a20
col allocated format 9999990.99
col freespace format 9999990.99
col maxsize format 9999990.99
col pctused format 90.99
set feed off
set lines 120 pages 1000
col tablespace_name format a20
col allocated format 9999990.99
col freespace format 9999990.99
col maxsize format 9999990.99
col pctused format 90.99
set pages 500
SET MARKUP HTML ON  
spool tablespace_usage_logfile.html
SELECT df.tablespace_name "Tablespace",
totalusedspace "Used MB",
(df.totalspace - tu.totalusedspace) "Free MB",
df.totalspace "Total MB",
round(100 * ((df.totalspace - tu.totalusedspace) / df.totalspace)) "Pct. Free"
FROM (SELECT tablespace_name, round(SUM(bytes) / 1048576) TotalSpace
FROM dba_data_files
GROUP BY tablespace_name) df,
(SELECT round(SUM(bytes) / (1024 * 1024)) totalusedspace,
tablespace_name
FROM dba_segments
GROUP BY tablespace_name) tu
WHERE df.tablespace_name = tu.tablespace_name
AND round(100 * ((df.totalspace - tu.totalusedspace) / df.totalspace)) < 60;
spool off 
SET MARKUP HTML OFF
spool tablespace_usage_logfile.log
SELECT df.tablespace_name "Tablespace",
totalusedspace "Used MB",
(df.totalspace - tu.totalusedspace) "Free MB",
df.totalspace "Total MB",
round(100 * ((df.totalspace - tu.totalusedspace) / df.totalspace)) "Pct. Free"
FROM (SELECT tablespace_name, round(SUM(bytes) / 1048576) TotalSpace
FROM dba_data_files
GROUP BY tablespace_name) df,
(SELECT round(SUM(bytes) / (1024 * 1024)) totalusedspace,
tablespace_name
FROM dba_segments
GROUP BY tablespace_name) tu
WHERE df.tablespace_name = tu.tablespace_name
AND round(100 * ((df.totalspace - tu.totalusedspace) / df.totalspace)) < 60;
spool off
