
ShoeCarnival:

sqlplus adpr_cruvpd/cruvpd@et220p

select username from all_users where username like '%OWNER' order by 1;

select count(1) from VI7OWNER.PRSNCMMNIDENTASSIGN WHERE COIDTXT = 'G36J29RA6M4KMMQD';
5518

select count(1) from VI7OWNER.PROJECTEDTOTAL;

select count(1) from VI7OWNER.WFCTOTAL;

select * from VI7OWNER.PROJECTEDTOTAL where employeeid = 'G3181H37FATGJR9K';

select pers_ky, clnt_ky, CLNT_ISS_EMPL_ID
from t_dim_pers where CLNT_OBJ_ID = 'G36J29RA6M4KMMQD' and PERS_OBJ_ID = 'G3181H37FATGJR9K';
22846446	 2924   108593


select count(1) from VI7OWNER.WFCTOTAL where EMPLOYEEID = '108593';


adpr_cruvpd@ET220P@1> select * from vi7owner.ITLM_PRSNCMMNIDENTASSIGN where COIDTXT = 'G36J29RA6M4KMMQD' and aoidtxt = 'G3181H37FATGJR9K';

  PERSONID COIDTXT			  AOIDTXT			 VERSIONCNT UPDATEDBYUSRACCTID UPDATEDTM
---------- ------------------------------ ------------------------------ ---------- ------------------ ---------
     35485 G36J29RA6M4KMMQD		  G3181H37FATGJR9K			  1		   -10 10-SEP-15



     select
     'CLNT_OBJ_ID'
     ||','||'PERS_KY'
     ||','||'PAYCD_KY'
     ||','||'TRANS_DAY_KY'
     ||','||'CLNT_KY'
     ||','||'PERS_OBJ_ID'
     ||','||'PRMRY_LABOR_ACCT_KY'
     ||','||'EXPCT_HRS_NBR'
     ||','||'ACTL_HRS_IN_SECND_NBR'
     ||','||'HRLY_RT'
     ||','||'COST'
     ||','||'STRT_DT_TM'
     ||','||'END_DT_TM'
     ||','||'REC_CRT_TS'
     ||','||'REC_LST_UPDT_TS'
     ||','||'REC_DATA_EXTRC_TS'
     ||','||'ETL_LOG_KY'
     ||','||'POSN_ID'
     ||','||'LABOR_ACCT_GRP_KY'
     ||','||'SRCE_SYS_TRANS_ID'
     ||','||'WORK_ASGNMT_NBR'
     ||','||'MNGR_KY'
     ||','||'CMPNY_KY'
     ||','||'WORK_LOC_KY'
     ||','||'JOB_KY'
     ||','||'HR_ORGN_KY'
     ||','||'PAY_GRP_KY'
     ||','||'PERS_PRFL_ATTR_KY'
     ||','||'PAYRL_ORGN_KY'
     ||','||'SAL_PLAN_KY'
     ||','||'WORK_ASGNMT_STUS_CD'
     ||','||'WORK_ASGNMT_STUS_DSC'
     ||','||'SCHDL_HRS_IN_SECND_NBR'
     ||','||'SCHDL_COST'
     ||','||'SCHDL_TM_ID'
     from dual;

select STARTDATETIME || ', '|| ENDDATETIME || ', '|| PAYCATID ||', '|| amount/3600
||', '|| wageamount ||', '|| moneyamount
from VI7OWNER.PROJECTEDTOTAL where employeeid = 35485
and to_date('01/21/2017', 'MM/DD/YYYY') = trunc(STARTDATETIME)
order by 1;


select STARTDTM || ', '|| ENDDTM || ', '|| PAYCODEID ||', '|| DURATIONSECSQTY/3600
||', '|| wageamt ||', '|| moneyamt
from VI7OWNER.WFCTOTAL where employeeid = 35485
and to_date('01/21/2017', 'MM/DD/YYYY') = trunc(STARTDTM)
order by 1;

select STARTDATETIME || ', '|| ENDDATETIME || ', '|| PAYCATID ||', '|| amount/3600
||', '|| wageamount ||', '|| moneyamount
from VI7OWNER.SCHEDULEDTOTAL where employeeid = 35485
and to_date('01/21/2017', 'MM/DD/YYYY') = trunc(STARTDATETIME)
order by 1;

and to_date('01/15/2017', 'MM/DD/YYYY') < STARTDATETIME
and to_date('01/23/2017', 'MM/DD/YYYY') > ENDDATETIME


select * from T_FACT_PAYRL_TM
where CLNT_OBJ_ID = 'G36J29RA6M4KMMQD' and PERS_OBJ_ID = 'G3181H37FATGJR9K'
and to_date('01/21/2017', 'MM/DD/YYYY') = trunc(STRT_DT_TM);

select PAYCD_KY || ', ' || PAYCD_ID || ', ' ||  PAYCD_NM
 from t_dim_paycd where CLNT_OBJ_ID = 'G36J29RA6M4KMMQD'
order by 1;

 and paycd_ky = '1261839';


 select max(to_number(substr(SRCE_SYS_TRANS_ID,3))) from T_FACT_PAYRL_TM
 where CLNT_OBJ_ID = 'G36J29RA6M4KMMQD';


Updates:
-----------
update T_FACT_PAYRL_TM
    set SCHDL_HRS_IN_SECND_NBR=15300
    where CLNT_OBJ_ID = 'G36J29RA6M4KMMQD' and PERS_OBJ_ID = 'G3181H37FATGJR9K'
    and pers_ky = '25132989'
    and trans_day_ky = '20170121' and SCHDL_HRS_IN_SECND_NBR = 17100;

insert into T_FACT_PAYRL_TM
values (
'G36J29RA6M4KMMQD',
'25132989',
'1261840',  --> updated the correct pay code
'20170121',
'2924',
'G3181H37FATGJR9K',
'18003449',
'0',
'0',
'10.5',
'0',
to_date('01/21/2017', 'MM/DD/YYYY'),
to_date('01/21/2017', 'MM/DD/YYYY'),
to_date('01/20/2017', 'MM/DD/YYYY'),
'',
to_date('01/20/2017', 'MM/DD/YYYY'),
'19647180',
'',
'-2924',
's_1477268', -- to get this value: (select 's_' || max(to_number(substr(SRCE_SYS_TRANS_ID,3))) from T_FACT_PAYRL_TM where CLNT_OBJ_ID = 'G36J29RA6M4KMMQD')
'0',
'4514454',
'-2924',
'2701273',
'3351205',
'3995273',
'2407003',
'2689050',
'3749294',
'1681000',
'A',
'Active',
'1800',    --> updated the seconds to match the over time.
'49.875',
's_1427742');


rollback:

update T_FACT_PAYRL_TM
    set SCHDL_HRS_IN_SECND_NBR=17100
    where CLNT_OBJ_ID = 'G36J29RA6M4KMMQD' and PERS_OBJ_ID = 'G3181H37FATGJR9K'
    and pers_ky = '25132989'
    and trans_day_ky = '20170121' and SCHDL_HRS_IN_SECND_NBR = 15300;

delete from T_FACT_PAYRL_TM
    where CLNT_OBJ_ID = 'G36J29RA6M4KMMQD' and PERS_OBJ_ID = 'G3181H37FATGJR9K'
    and pers_ky = '25132989'
    and trans_day_ky = '20170121' and paycd_ky = 1261840
    and SCHDL_HRS_IN_SECND_NBR=1800;




WITH SCHEDLIST AS (
select employeeid, trunc(STARTDATETIME) sdate, count(1) over (partition by employeeid, trunc(STARTDATETIME)) c,
sum(amount) tottimesec, sum(wageamount) totwageamt
from VI7OWNER.SCHEDULEDTOTAL
group by employeeid, trunc(STARTDATETIME)
),
PROJLIST AS (
select employeeid, trunc(STARTDATETIME) sdate, count(1) over (partition by employeeid, trunc(STARTDATETIME)) c,
sum(amount) tottimesec, sum(wageamount) totwageamt
from VI7OWNER.PROJECTEDTOTAL
group by employeeid, trunc(STARTDATETIME)
)
select s.sdate, s.tottimesec, p.tottimesec, s.totwageamt, p.totwageamt
from SCHEDLIST s JOIN PROJLIST p on (s.employeeid = p.employeeid
    and s.sdate = p.sdate)
where (
    ((s.tottimesec != p.tottimesec) or (s.totwageamt != p.totwageamt))
    and /*s.c=1 and */p.c>1
) order by 1;







 WITH SCHEDLIST AS (
 select employeeid, PAYCATID, trunc(STARTDATETIME) sdate, amount, wageamount
 from VI7OWNER.SCHEDULEDTOTAL WHERE employeeid = 35485
 and trunc(STARTDATETIME) = to_date('01/15/2017', 'MM/DD/YYYY')
 ),
 PROJLIST AS (
 select employeeid, PAYCATID, trunc(STARTDATETIME) sdate, amount, wageamount
 from VI7OWNER.PROJECTEDTOTAL WHERE employeeid = 35485
 and trunc(STARTDATETIME) = to_date('01/15/2017', 'MM/DD/YYYY')
 )
 select s.sdate, s.tottimesec, p.tottimesec, s.totwageamt, p.totwageamt
 from SCHEDLIST s JOIN PROJLIST p on (s.employeeid = p.employeeid
     and s.sdate = p.sdate)
 where (
     ((s.tottimesec != p.tottimesec) or (s.totwageamt != p.totwageamt))
     and
     s.c=1 and p.c>1
 )
  order by 1;


  no rows selected











s
