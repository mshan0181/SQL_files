select * from (
select
     session_id,
	 session_serial#,
     program,
	 module,
	 action,
     sum(decode(session_state,'WAITING',0,1)) "CPU",
     sum(decode(session_state,'WAITING',1,0)) - sum(decode(session_state,'WAITING',decode(wait_class,'User I/O',1,0),0)) "WAITING" ,
     sum(decode(session_state,'WAITING',decode(wait_class,'User I/O',1,0),0)) "IO" ,
     sum(decode(session_state,'WAITING',1,1)) "TOTAL"
from v$active_session_history 
where session_type='FOREGROUND'
group by session_id,session_serial#,module,action,program
order by sum(decode(session_state,'WAITING',1,1)) desc)
where rownum <11;
