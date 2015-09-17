select sid from v$mystat where rownum = 1;
select rawtohex(dbms_crypto.hash(dbms_metadata.get_ddl('PACKAGE', 'MY_PKG', 'MY_USER'), 2)) hashval from dual;
select sys_context('USERENV', 'CURRENT_SCHEMA') from dual;
select app_id, c, round(ratio_to_report(c) over ()*100, 1) as selectivity
from (select APP_ID, count(*) as c from ts_pe_ps_pt_admin_apps group by APP_ID)
order by c;

JS Latch:
---------
SELECT 'Sessions waiting for JS latch: ' NAME, 
(SELECT COUNT(*) FROM gv$latch a, gv$session b 
WHERE a.inst_id =b.inst_id AND a.latch#  =b.p2 
AND a.name ='JS broadcast kill buf latch'
AND username='HWSE_ADMIN' AND b.status='ACTIVE' AND b.event ='latch free') COUNT FROM dual 
UNION ALL 
SELECT 'Active refresh sessions: ' NAME, 
(SELECT COUNT(*) FROM gv$session WHERE username='HWSE_ADMIN') COUNT FROM dual
 ORDER BY NAME;

-- unindexed foreign key constraints can cause severe problems.. query to find them
--  TM Contention Wait 
SELECT * FROM (
SELECT c.table_name, cc.column_name, cc.position column_position
FROM   user_constraints c, user_cons_columns cc
WHERE  c.constraint_name = cc.constraint_name
AND    c.constraint_type = 'R'
MINUS
SELECT i.table_name, ic.column_name, ic.column_position
FROM   user_indexes i, user_ind_columns ic
WHERE  i.index_name = ic.index_name
) ORDER BY table_name, column_position;

-- xml
select * from (
select table_name
,to_number(extractvalue(xmltype(
dbms_xmlgen.getxml(
'select /*+ parallel(e default) */ count(*) c from '||table_name|| ' e'))
,'/ROWSET/ROW/C')) count
from user_tables order by table_name
) order by count;


how to collect hwse refresh trace:
----------------------------------
alter session set statistics_level=ALL;
alter session set tracefile_identifier='HWSE_REG0116';
alter session set max_dump_file_size=UNLIMITED;
alter session set nls_date_format='MM-DD-YYYY HH24:MI:SS';
exec dbms_monitor.session_trace_enable(NULL,NULL,TRUE,TRUE);
now refresh 


PAYX SMP Reports:
select count(1) as rptcnt  from qryquery q where q.client_code = 'ADPADMIN'  
 and q.qry_mode = 'SMP'   and q.user_key in (select user_key from secuser where user_login = 'EDUK3ADMIN@ADP')  
 and q.qry_status = 90   and q.qry_active = 't'   and q.qry_ext_templateid like '%WFN2%';

Vantage std reports:
select count(1) as rptcnt  from qryquery q where q.client_code = 'ADPADMIN'  
 and q.qry_mode = 'STD'   and q.user_key in (select user_key from secuser where user_login = 'FBRESSLER@ADP')  
 and q.qry_status = 90   and q.qry_active = 't'   and q.qry_ext_templateid like 'V206%';
 
select count(1) as rptcnt  from qryquery q where q.client_code = 'ADPADMIN'  
 and q.qry_mode = 'SMP'   and q.user_key in (select user_key from secuser where user_login = 'EDUK3ADMIN@ADP')  
 and q.qry_status = 90   and q.qry_active = 't'   and q.qry_ext_templateid like 'WFN8%';
 
 
WFN std/smp REPORTS:
select q.qry_key
      ,q.qry_name
      ,q.qry_active
      ,q.qry_class
      ,q.qry_ext_templateid
      ,(select res_name from catresource where res_key = q.res_key) res_name
  from qryquery q
where q.client_code = 'ADPADMIN'
   and q.qry_mode = 'SMP'
   and q.user_key = (select user_key from secuser where user_login = 'EDUK3ADMIN@ADP')
   and q.qry_status = 90
   and q.qry_active = 't'
   and q.qry_ext_templateid like 'WFN8%'
order by 2,6,5;
