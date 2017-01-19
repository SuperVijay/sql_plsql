
alter session set "_sqlmon_max_planlines"=20000;

show parameter STATISTICS_LEVEL 
show parameter CONTROL_MANAGEMENT_PACK_ACCESS

alter system flush shared_pool;
alter system flush buffer_cache;

select dbms_stats.create_extended_stats('WFN6SCH008030', 'T_WFN_RPTG_CHECK_HIST_DISTRB', '(VPD_KEY, COMPANY_CODE, EMPLOYEE_OID, FILE_NUMBER)')
from dual;

exec dbms_stats.gather_table_stats('WFN6SCH008030', 'T_WFN_RPTG_CHECK_HIST_DISTRB', -
estimate_percent => dbms_stats.auto_sample_size, method_opt => 'for all columns size auto', cascade => TRUE, degree => 64);

begin
        dbms_stats.drop_extended_stats (
                ownname   => 'WFN6SCH008030', 
                tabname   => 'T_WFN_RPTG_CHECK_HIST_DISTRB', 
                extension => '(VPD_KEY, COMPANY_CODE, EMPLOYEE_OID, FILE_NUMBER)'
        );
end;
/
select column_name from user_tab_cols where table_name = 'T_WFN_RPTG_CHECK_HIST_DISTRB';

select dbms_stats.create_extended_stats('WFN6SCH008030', 'X_WFN_RPTG_CHECK_HIST_DISTRB', '(VPD_KEY, COMPANY_CODE, EMPLOYEE_OID, FILE_NUMBER)')
from dual;

exec dbms_stats.gather_table_stats('WFN6SCH008030', 'X_WFN_RPTG_CHECK_HIST_DISTRB', -
estimate_percent => dbms_stats.auto_sample_size, method_opt => 'for all columns size auto', cascade => TRUE, degree => 64);

begin
        dbms_stats.drop_extended_stats (
                ownname   => 'WFN6SCH008030', 
                tabname   => 'X_WFN_RPTG_CHECK_HIST_DISTRB', 
                extension => '(VPD_KEY, COMPANY_CODE, EMPLOYEE_OID, FILE_NUMBER)'
        );
end;
/

   
select dbms_stats.create_extended_stats('ADPR_CRUVPD', 'SECURITY_VW_TBL_TMP', '(VPD_KEY, COMPANY_CODE, EMPLOYEE_OID, FILE_NUMBER)')
from dual;

exec dbms_stats.gather_table_stats('ADPR_CRUVPD', 'SECURITY_VW_TBL_TMP', -
estimate_percent => dbms_stats.auto_sample_size, method_opt => 'for all columns size auto', cascade => TRUE, degree => 64);


  CREATE GLOBAL TEMPORARY TABLE "ADPR_CRUVPD"."SECURITY_VW_TBL_TMP"
   (	"VPD_KEY" VARCHAR2(50) NOT NULL ENABLE,
	"F_PAID" NUMBER(1,0) NOT NULL ENABLE,
	"PAID" VARCHAR2(50),
	"SEC_PFID" VARCHAR2(32) NOT NULL ENABLE,
	"COMPANY_CODE" VARCHAR2(32),
	"PFID" VARCHAR2(32) NOT NULL ENABLE,
	"EMPLOYEE_OID" VARCHAR2(50),
	"POSITION_ID" NVARCHAR2(32) NOT NULL ENABLE,
	"FILE_NUMBER" VARCHAR2(9),
	"BASE_CURRENCY" VARCHAR2(35) NOT NULL ENABLE,
	"PROD_LOCALE_CODE" VARCHAR2(32) NOT NULL ENABLE
   ) ON COMMIT PRESERVE ROWS;
   

  CREATE TABLE "ADPR_CRUVPD"."SECURITY_VW_TBL_TMP"
   (	"VPD_KEY" VARCHAR2(50) NOT NULL ENABLE,
	"F_PAID" NUMBER(1,0) NOT NULL ENABLE,
	"PAID" VARCHAR2(50),
	"SEC_PFID" VARCHAR2(32) NOT NULL ENABLE,
	"COMPANY_CODE" VARCHAR2(32),
	"PFID" VARCHAR2(32) NOT NULL ENABLE,
	"EMPLOYEE_OID" VARCHAR2(50),
	"POSITION_ID" NVARCHAR2(32) NOT NULL ENABLE,
	"FILE_NUMBER" VARCHAR2(9),
	"BASE_CURRENCY" VARCHAR2(35) NOT NULL ENABLE,
	"PROD_LOCALE_CODE" VARCHAR2(32) NOT NULL ENABLE
   ) TABLESPACE DATA1;
grant select,insert,update,delete on SECURITY_VW_TBL_TMP to adpr_secusr;



select /*+ parallel(x default) */ count(1) from t_WFN_RPTG_CHECK_HIST_DISTRB x;
select /*+ parallel(x default) */ count(1) from x_WFN_RPTG_CHECK_HIST_DISTRB x;

WFN6SCH006333
WFN6SCH006415
WFN6SCH006941
WFN6SCH007028
WFN6SCH008030
WFN6SCH008058
WFN8SCH014541
WFN8SCH014601


