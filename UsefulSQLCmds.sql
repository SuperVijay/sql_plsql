
How to generate AWR report:
@$ORACLE_HOME/rdbms/admin/awrrpt.sql

sql monitor report:
https://oracle-base.com/articles/11g/real-time-sql-monitoring-11gr1
http://structureddata.org/2008/01/06/oracle-11g-real-time-sql-monitoring-using-dbms_sqltunereport_sql_monitor/
http://kerryosborne.oracle-guy.com/2008/10/oracle-11g-real-time-sql-monitoring/

alter system set "_sqlmon_max_planlines"=800 scope=both;

alter session set "_sqlmon_max_planlines"=20000; 
alter system flush shared_pool;
alter system flush buffer_cache;

alter session set timed_statistics=true;
alter session set statistics_level=all;
set time on timing on linesize 300 pagesize 10000
set arraysize 1000
exec dbms_Session.set_identifier('VIJAY_TEST');
select sys_context('userenv', 'instance') from dual;

truncate table SECURITY_VW_TBL_TMP;


/*+ LEADING(TABLE1) NO_MERGE(TABLE4) gather_plan_statistics */ /* fabiobressler hard parse #1 */ 
/*+ gather_plan_statistics */ 

select inst_id, sid, serial#,  sql_child_number, sql_id, prev_sql_id from gv$session
where client_identifier='VIJAY_TEST' and status='ACTIVE';


SET LONG 10000000
SET LONGCHUNKSIZE 10000000
set lines 20000
SET PAGESIZE 0
SET TRIM ON
SET TRIMSPOOL ON
SET ECHO OFF
SET FEEDBACK OFF
set serveroutput on size unlimited
SPOOL 1610381310560_extndstatsNORMafterlocalidx.html
SELECT DBMS_SQLTUNE.report_sql_monitor(
  sql_id       => '2wkx9jwjv9udn',
  type         => 'ACTIVE',
  report_level => 'ALL') AS report
FROM dual;
SPOOL OFF





select DBMS_SQLTUNE.REPORT_SQL_MONITOR(
   session_id=>sys_context('userenv','sid'),
   type         => 'ACTIVE',
   report_level=>'ALL') as report
from dual;

select count(1) from v$sql_monitor where sql_id = '8ajwr24q083h3';



select s.sql_id, s.sql_child_number
from gv$session s, gv$sql l
where s.inst_id = l.inst_id and s.sql_id = l.sql_id and s.sql_child_number=l.child_number
and UPPER(l.sql_Text) like '%VIJAY_EVENT_ELIGBLTY_VW%';

set lines 300 pagesize 0
select * from table(dbms_xplan.display_cursor('00wjjts22ggw4',0,'ALLSTATS LAST'));
set serveroutput off
select * from table(dbms_xplan.display_cursor(null,null,'ALLSTATS'));



select * from table(dbms_xplan.display_cursor('fhzq79k9pyhq5',0,'ALL'));

select * from table(dbms_xplan.display_cursor('fhzq79k9pyhq5',0,'ALLSTATS LAST'));

SELECT  * FROM
  TABLE(DBMS_XPLAN.DISPLAY_CURSOR('75chksrfa5fbt',0,'ALLSTATS LAST +PEEKED_BINDS +PROJECTION +ALIAS +PREDICATE +COST +BYTES'));


-- To get sql_id from running session:
select sid, serial#, sql_id from v$session where client_identifier='FAB' and status='ACTIVE';
fg8mqhd29z4q6

-- Get plan for a sql_id:
select * from table(dbms_xplan.display_cursor('fg8mqhd29z4q6',0,'ALLSTATS LAST')); --> fg8mqhd29z4q6_plan.txt / fg8mqhd29z4q6_plan_stats.txt

-- Get active workareas: 
col OPERATION_TYPE for a25
select operation_id, operation_type, expected_size, work_area_size, number_passes, round(tempseg_size/1024/1024/1024,2) temp_size_gb from v$sql_workarea_active where sql_id='fg8mqhd29z4q6' order by 1;

-- Check the final number_passes + temp consumed by each step
col OPERATION_TYPE for a25
col MAX_PASSES for a15
select operation_id, operation_type, last_execution as max_passes, round(max_tempseg_size/1024/1024/1024,2) max_temp_size_gb from v$sql_workarea where sql_id='fg8mqhd29z4q6';

-- Get bind variables
col NAME for a20
col DATATYPE_STRING for a20
col VALUE_STRING for a50
select name, position, datatype_string, value_string from v$sql_bind_capture where sql_id='fg8mqhd29z4q6';





select operation, target, trunc(end_time, 'MI')
from
      DBA_OPTSTAT_OPERATIONS
where target='WFN8SCH014541'
 
OPERATION                    TARGET            TRUNC(END_TIME,'MI')
---------------------------- ----------------- --------------------
gather_schema_stats          WFN8SCH014541     2016-12-10 11:38:00


https://blogs.oracle.com/optimizer/entry/gathering_optimizer_statistics_is_one


exec dbms_stats.gather_schema_stats(ownname => User, method_opt => 'FOR ALL COLUMNS SIZE 1', cascade => TRUE, degree => 40);

ALTER SYSTEM SET RESOURCE_MANAGER_PLAN = default_plan;
exec dbms_stats.set_global_prefs('CONCURRENT','TRUE');
exec dbms_stats.gather_schema_stats(ownname => 'WFN6SCH006333', estimate_percent => dbms_stats.auto_sample_size, method_opt => 'for all columns size auto', cascade => TRUE, degree => 40);
exec dbms_stats.gather_schema_stats(ownname => 'WFN6SCH006415', estimate_percent => dbms_stats.auto_sample_size, method_opt => 'for all columns size auto', cascade => TRUE, degree => 40);
exec dbms_stats.gather_schema_stats(ownname => 'WFN6SCH006941', estimate_percent => dbms_stats.auto_sample_size, method_opt => 'for all columns size auto', cascade => TRUE, degree => 40);
exec dbms_stats.gather_schema_stats(ownname => 'WFN6SCH007028', estimate_percent => dbms_stats.auto_sample_size, method_opt => 'for all columns size auto', cascade => TRUE, degree => 40);
exec dbms_stats.gather_schema_stats(ownname => 'WFN6SCH008030', estimate_percent => dbms_stats.auto_sample_size, method_opt => 'for all columns size auto', cascade => TRUE, degree => 40);
exec dbms_stats.gather_schema_stats(ownname => 'WFN6SCH008058', estimate_percent => dbms_stats.auto_sample_size, method_opt => 'for all columns size auto', cascade => TRUE, degree => 40);
exec dbms_stats.gather_schema_stats(ownname => 'WFN8SCH014541', estimate_percent => dbms_stats.auto_sample_size, method_opt => 'for all columns size auto', cascade => TRUE, degree => 40);
exec dbms_stats.gather_schema_stats(ownname => 'WFN8SCH014601', estimate_percent => dbms_stats.auto_sample_size, method_opt => 'for all columns size auto', cascade => TRUE, degree => 40);


--find out the time of the day with highest load:

select extract(hour from req_timestamp), bi.inst_sid, count(1)
from batreq br join batinstance bi on (br.inst_key = bi.inst_key)
where req_timestamp > trunc(sysdate)
and upper(bi.inst_sid) like 'WFC%'
group by extract(hour from req_timestamp), bi.inst_sid
order by 3,2,1;




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
