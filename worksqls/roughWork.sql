
with wfnsystem as (
select /*+ materialize */
distinct  vpd_key, v.organization_oid, upper(v.isi_client_id) client_code, m.db, m.schm, m.extn, m.ikey
from wfnsys.v_client_logon@dblinkcru40ptopxs01p v,
(select vpd_key, 'WFN8SCH016541' schm, '_0001' extn, 103 ikey, 'wfc81p_svc1' db from dual
union
select vpd_key, 'WFN8SCH016542' schm, '_0002' extn, 103 ikey, 'wfc81p_svc1' db from dual
union
select vpd_key, 'WFN8SCH016619' schm, '_0001' extn, 104 ikey, 'wfc82p_svc1' db from dual
union
select vpd_key, 'WFN8SCH016597' schm, '_0002' extn, 104 ikey, 'wfc82p_svc1' db from dual
union
select vpd_key, 'WFN9SCH018259' schm, '_0001' extn, 110 ikey, 'wfc88p_svc1' db from dual
union
select vpd_key, 'WFN9SCH018297' schm, '_0002' extn, 110 ikey, 'wfc88p_svc1' db from dual) m
where organization_oid in (select c from t1)
and v.instance_name = m.db )
select distinct w.client_code, bi.inst_sid, bcp.BCP_EXTENSION_VALUE, w.db, w.extn
from webrepadmin.batclientproduct@dblinkcru40ptocrw11p bcp,
     webrepadmin.batclientenvironment@dblinkcru40ptocrw11p bce,
     webrepadmin.catclient@dblinkcru40ptocrw11p c,
     webrepadmin.batinstance@dblinkcru40ptocrw11p bi,
     wfnsystem w
where bcp.client_code = bce.client_code
and bcp.client_code = c.client_code
and bcp.prd_code = bce.prd_code
and c.client_code = w.client_code
and bce.inst_key = bi.inst_key
and bcp.prd_code = 'WFN' and bcp.ver_code = 11
and (
--    lower(bi.inst_sid) != replace(w.db, '_svc1', '_adpr_svc1')
   bce.inst_key != w.ikey
  or
    bcp.BCP_EXTENSION_VALUE != w.extn
);

update batclientproduct set BCP_EXTENSION_VALUE= '_0001' where prd_code like 'WFN%' and ver_code = '11' and client_code ='CCAH1';
update batclientenvironment set inst_key = 110 where prd_code like 'WFN%' and client_code ='CCAH1';
commit;

select distinct  upper(v.isi_client_id) client_code, v.instance_name, v.schema_name
from wfnsys.v_client_logon@dblinkcru40ptopxs01p v
where upper(isi_client_id) = 'ZUMASYS';

=set head off pages 0 lines 140 timing off

with wfnsystem as (
select /*+ materialize */
distinct  v.organization_oid, upper(v.isi_client_id) client_code, m.db, m.schm, m.extn, m.ikey
from wfnsys.v_client_logon@dblinkcru40ptopxs01p v,
(select 'WFN8SCH016541' schm, '_0001' extn, 103 ikey, 'wfc81p_svc1' db from dual
union
select 'WFN8SCH016542' schm, '_0002' extn, 103 ikey, 'wfc81p_svc1' db from dual
union
select 'WFN8SCH016619' schm, '_0001' extn, 104 ikey, 'wfc82p_svc1' db from dual
union
select 'WFN8SCH016597' schm, '_0002' extn, 104 ikey, 'wfc82p_svc1' db from dual
union
select 'WFN9SCH018259' schm, '_0001' extn, 110 ikey, 'wfc88p_svc1' db from dual
union
select 'WFN9SCH018297' schm, '_0002' extn, 110 ikey, 'wfc88p_svc1' db from dual) m
where organization_oid in (select c from t1)
and v.instance_name = m.db and v.schema_name = m.schm )
select
'update batclientproduct set BCP_EXTENSION_VALUE= ''' || w.extn || ''' where prd_code like ''WFN%'' and ver_code = ''11'' and client_code ='''
|| w.client_code || ''';'
|| chr(10) ||
'update batclientenvironment set inst_key = ' || w.ikey || ' where prd_code like ''WFN%'' and client_code =''' || w.client_code || ''';'
|| chr(10) || 'commit;'
--upper(w.client_code) client_code, w.db, w.schm, w.extn, w.ikey, bcp.BCP_EXTENSION_VALUE, bce.inst_key
from webrepadmin.batclientproduct@dblinkcru40ptocrw11p bcp,
     webrepadmin.batclientenvironment@dblinkcru40ptocrw11p bce,
     webrepadmin.catclient@dblinkcru40ptocrw11p c,
     webrepadmin.batinstance@dblinkcru40ptocrw11p bi,
     wfnsystem w
where bcp.client_code = bce.client_code
and bcp.client_code = c.client_code
and bcp.prd_code = bce.prd_code
and c.client_code = w.client_code
and bce.inst_key = bi.inst_key
--and c.client_code in ( 'ZUMASYS', 'CDTEC', 'CCAH1')
and bcp.prd_code = 'WFN' and bcp.ver_code = 11
and (
--    lower(bi.inst_sid) != replace(w.db, '_svc1', '_adpr_svc1')
   bce.inst_key = w.ikey
  or
    bcp.BCP_EXTENSION_VALUE != w.extn
) order by 1;

select 'WFN8SCH016541' schm, '_0001' extn, 103 ikey, 'wfc81p_svc1' db from dual
union
select 'WFN8SCH016542' schm, '_0002' extn, 103 ikey, 'wfc81p_svc1' db from dual
union
select 'WFN8SCH016619' schm, '_0001' extn, 104 ikey, 'wfc82p_svc1' db from dual
union
select 'WFN8SCH016597' schm, '_0002' extn, 104 ikey, 'wfc82p_svc1' db from dual
union



with wfnsystem as (
select /*+ materialize */
distinct  v.organization_oid, upper(v.isi_client_id) client_code, m.db, m.schm, m.extn, m.ikey
from wfnsys.v_client_logon@dblinkcru40ptopxs01p v,
(
select 'WFN9SCH018259' schm, '_0001' extn, 110 ikey, 'wfc88p_svc1' db from dual
union
select 'WFN9SCH018297' schm, '_0002' extn, 110 ikey, 'wfc88p_svc1' db from dual) m
where organization_oid in (select c from t1)
and v.instance_name = m.db and v.schema_name = m.schm )
select
c.client_code, w.extn, bcp.BCP_EXTENSION_VALUE, w.ikey, bce.inst_key
--upper(w.client_code) client_code, w.db, w.schm, w.extn, w.ikey,
--bcp.BCP_EXTENSION_VALUE, bce.inst_key
from webrepadmin.batclientproduct@dblinkcru40ptocrw11p bcp,
     webrepadmin.batclientenvironment@dblinkcru40ptocrw11p bce,
     webrepadmin.catclient@dblinkcru40ptocrw11p c,
     webrepadmin.batinstance@dblinkcru40ptocrw11p bi,
     wfnsystem w
where bcp.client_code = bce.client_code
and bcp.client_code = c.client_code
and bcp.prd_code = bce.prd_code
and c.client_code = w.client_code
and bce.inst_key = bi.inst_key
--and c.client_code in ( 'ZUMASYS', 'CDTEC', 'CCAH1')
and bcp.prd_code = 'WFN' and bcp.ver_code = 11
and (
--    lower(bi.inst_sid) != replace(w.db, '_svc1', '_adpr_svc1')
   bce.inst_key != w.ikey
  or
    bcp.BCP_EXTENSION_VALUE != w.extn
) order by 1;





set head off pages 0 lines 120
col client_code form a22
col extn form a8
col BCP_EXTENSION_VALUE form a8
col ikey form 9999999
col inst_key form 999999
col pod form a10


with sor as (
select
ISI_CLIENT_ID client_code, ORGANIZATION_OID, SOURCE_SCHEMA_NAME, SOURCE_REPL_INSTANCE,
'_' || REG_POD_CODE extn, NODE_CODE ikey
from adpr_client_extensions a where 1=1 -- ISI_CLIENT_ID in ( 'LTREE', 'PROPERMAN')
and PRODUCT_CODE='WFN' and product_version = 11
and exists (select 1 from curr_isi_client_load x where x.client_code=a.ISI_CLIENT_ID
and product_code = 'WFNPORTAL')
and not exists (select 1 from curr_isi_client_load x where x.client_code=a.ISI_CLIENT_ID
and product_code = 'NASPORTAL')
and not exists (select 1 from curr_isi_client_load x where x.client_code=a.ISI_CLIENT_ID
and product_code = 'HRIIPORTAL')
)
select distinct * from (
select
c.client_code, w.extn, bcp.BCP_EXTENSION_VALUE, w.ikey, bce.inst_key--, 'PILOT' pod
from webrepadmin.batclientproduct@dblinkcru40ptocrw11p bcp,
     webrepadmin.batclientenvironment@dblinkcru40ptocrw11p bce,
     webrepadmin.catclient@dblinkcru40ptocrw11p c,
     sor w
where bcp.client_code = bce.client_code
and bcp.client_code = c.client_code
and bcp.prd_code = bce.prd_code
and c.client_code = w.client_code
and bcp.prd_code = 'WFN' and bcp.ver_code = 11
and c.pod_code = 'WFN4_PROD'
and (
   bce.inst_key != w.ikey
  or
    bcp.BCP_EXTENSION_VALUE != w.extn
)
union ALL
select
c.client_code, w.extn, bcp.BCP_EXTENSION_VALUE, w.ikey, bce.inst_key--, 'MASPOD1' pod
from ADPRMASPRD01.batclientproduct@dblinkcru40ptocrw11p bcp,
     ADPRMASPRD01.batclientenvironment@dblinkcru40ptocrw11p bce,
     ADPRMASPRD01.catclient@dblinkcru40ptocrw11p c,
     sor w
where bcp.client_code = bce.client_code
and bcp.client_code = c.client_code
and bcp.prd_code = bce.prd_code
and c.client_code = w.client_code
and bcp.prd_code = 'WFN' and bcp.ver_code = 11
and c.pod_code = 'MAS_PROD1'
and (
   bce.inst_key != w.ikey
  or
    bcp.BCP_EXTENSION_VALUE != w.extn
)
union ALL
select
c.client_code, w.extn, bcp.BCP_EXTENSION_VALUE, w.ikey, bce.inst_key--, 'MASPOD2' pod
from ADPRMASPRD02.batclientproduct@dblinkcru40ptocrw12p bcp,
     ADPRMASPRD02.batclientenvironment@dblinkcru40ptocrw12p bce,
     ADPRMASPRD02.catclient@dblinkcru40ptocrw12p c,
     sor w
where bcp.client_code = bce.client_code
and bcp.client_code = c.client_code
and bcp.prd_code = bce.prd_code
and c.client_code = w.client_code
and bcp.prd_code = 'WFN' and bcp.ver_code = 11
and c.pod_code = 'MAS_PROD2'
and (
   bce.inst_key != w.ikey
  or
    bcp.BCP_EXTENSION_VALUE != w.extn
)
union ALL
select
c.client_code, w.extn, bcp.BCP_EXTENSION_VALUE, w.ikey, bce.inst_key--, 'MASPOD3' pod
from ADPRMASPRD03.batclientproduct@dblinkcru40ptocrw13p bcp,
     ADPRMASPRD03.batclientenvironment@dblinkcru40ptocrw13p bce,
     ADPRMASPRD03.catclient@dblinkcru40ptocrw13p c,
     sor w
where bcp.client_code = bce.client_code
and bcp.client_code = c.client_code
and bcp.prd_code = bce.prd_code
and c.client_code = w.client_code
and bcp.prd_code = 'WFN' and bcp.ver_code = 11
and c.pod_code = 'MAS_PROD3'
and (
   bce.inst_key != w.ikey
  or
    bcp.BCP_EXTENSION_VALUE != w.extn
)) order by 1;




select isi_client_id || ' ' || LAST_UPD
 from client_config_exclude where isi_client_id in
('LTREE', 'PROPERMAN');

PROPERMAN 24-JUN-16 08.52.31.000000 AM
LTREE     24-JUN-16 08.52.31.000000 AM









select
c.client_code, bcp.BCP_EXTENSION_VALUE, bce.inst_key
from webrepadmin.batclientproduct@dblinkcru40ptocrw11p bcp,
     webrepadmin.batclientenvironment@dblinkcru40ptocrw11p bce,
     webrepadmin.catclient@dblinkcru40ptocrw11p c,
     webrepadmin.batinstance@dblinkcru40ptocrw11p bi
where bcp.client_code = bce.client_code
and bcp.client_code = c.client_code
and bcp.prd_code = bce.prd_code
and bce.inst_key = bi.inst_key
and bcp.prd_code = 'WFN' and bcp.ver_code = 11

and c.client_code in (
    select ISI_CLIENT_ID client_code
    --, ORGANIZATION_OID, SOURCE_SCHEMA_NAME, SOURCE_REPL_INSTANCE,
    --REG_POD_CODE extn, NODE_CODE ikey
    from adpr_client_extensions where ISI_CLIENT_ID in ( 'LTREE', 'PROPERMAN')
    and PRODUCT_CODE='WFN' and product_version = 11
);


exec configure_client('LTREE', '110', 'MAS_PROD3','t', '_0002', 'WFN', '11', 'f', ' ', 'B500267812800C43', 'US');
exec configure_client('LTREE', '110', 'MAS_PROD3','t', '_0002', 'WFNEZLM', '11', 'f', ' ', 'B500267812800C43', 'US');
exec configure_client('LTREE', '110', 'MAS_PROD3','t', '_0002', 'WFNPAYX', '11', 'f', ' ', 'B500267812800C43', 'US');

update batclientenvironment set inst_key = 110 where client_code = 'LTREE' and prd_code like 'WFN%';




update batclientenvironment set inst_key = 99 where client_code = 'ELE' and prd_code like 'WFN%';
update batclientenvironment set inst_key = 48 where client_code = 'LITMAN16' and prd_code like 'WFN%';
update batclientenvironment set inst_key = 95 where client_code = 'NWI10333' and prd_code like 'WFN%';
update batclientenvironment set inst_key = 85 where client_code = 'SHELDONLAB' and prd_code like 'WFN%';





ELE		       _0002	_0002	 99	      93
LITMAN16	       _0001	_0001	 48	      94
NWI10333	       _0001	_0001	 95	      80
SHELDONLAB	       _0002	_0002	 85	     112




with sor as (
select
ISI_CLIENT_ID client_code, ORGANIZATION_OID, SOURCE_SCHEMA_NAME, SOURCE_REPL_INSTANCE,
'_' || REG_POD_CODE extn, NODE_CODE ikey
from adpr_client_extensions a where 1=1
and PRODUCT_CODE='WFN' and product_version = 11
and exists (select 1 from curr_isi_client_load x where x.client_code=a.ISI_CLIENT_ID
and product_code = 'WFNPORTAL')
)
select distinct * from (
select
c.client_code, w.extn, bcp.BCP_EXTENSION_VALUE, w.ikey, bce.inst_key--, 'PILOT' pod
from webrepadmin.batclientproduct@dblinkcru40ptocrw11p bcp,
     webrepadmin.batclientenvironment@dblinkcru40ptocrw11p bce,
     webrepadmin.catclient@dblinkcru40ptocrw11p c,
     sor w
where bcp.client_code = bce.client_code
and bcp.client_code = c.client_code
and bcp.prd_code = bce.prd_code
and c.client_code = w.client_code
and bcp.prd_code = 'WFN' and bcp.ver_code = 11
and c.pod_code = 'WFN4_PROD'
and (
   bce.inst_key != w.ikey
  or
    bcp.BCP_EXTENSION_VALUE != w.extn
)
union ALL
select
c.client_code, w.extn, bcp.BCP_EXTENSION_VALUE, w.ikey, bce.inst_key--, 'MASPOD1' pod
from ADPRMASPRD01.batclientproduct@dblinkcru40ptocrw11p bcp,
     ADPRMASPRD01.batclientenvironment@dblinkcru40ptocrw11p bce,
     ADPRMASPRD01.catclient@dblinkcru40ptocrw11p c,
     sor w
where bcp.client_code = bce.client_code
and bcp.client_code = c.client_code
and bcp.prd_code = bce.prd_code
and c.client_code = w.client_code
and bcp.prd_code = 'WFN' and bcp.ver_code = 11
and c.pod_code = 'MAS_PROD1'
and (
   bce.inst_key != w.ikey
  or
   bcp.BCP_EXTENSION_VALUE != w.extn
)
union ALL
select
c.client_code, w.extn, bcp.BCP_EXTENSION_VALUE, w.ikey, bce.inst_key--, 'MASPOD2' pod
from ADPRMASPRD02.batclientproduct@dblinkcru40ptocrw12p bcp,
     ADPRMASPRD02.batclientenvironment@dblinkcru40ptocrw12p bce,
     ADPRMASPRD02.catclient@dblinkcru40ptocrw12p c,
     sor w
where bcp.client_code = bce.client_code
and bcp.client_code = c.client_code
and bcp.prd_code = bce.prd_code
and c.client_code = w.client_code
and bcp.prd_code = 'WFN' and bcp.ver_code = 11
and c.pod_code = 'MAS_PROD2'
and (
   bce.inst_key != w.ikey
  or
    bcp.BCP_EXTENSION_VALUE != w.extn
)
union ALL
select
c.client_code, w.extn, bcp.BCP_EXTENSION_VALUE, w.ikey, bce.inst_key--, 'MASPOD3' pod
from ADPRMASPRD03.batclientproduct@dblinkcru40ptocrw13p bcp,
     ADPRMASPRD03.batclientenvironment@dblinkcru40ptocrw13p bce,
     ADPRMASPRD03.catclient@dblinkcru40ptocrw13p c,
     sor w
where bcp.client_code = bce.client_code
and bcp.client_code = c.client_code
and bcp.prd_code = bce.prd_code
and c.client_code = w.client_code
and bcp.prd_code = 'WFN' and bcp.ver_code = 11
and c.pod_code = 'MAS_PROD3'
and (
   bce.inst_key != w.ikey
  or
    bcp.BCP_EXTENSION_VALUE != w.extn
)) order by 1;






select bcp.client_code, BCP.VER_CODE
from batclientproduct bcp where prd_code = 'TMS';

and exists (select 1 from batclientproduct b
where b.client_code = bcp.client_code and b.prd_code != 'TMS')


select qq.client_code, count(1)
from qrytable q join qryquery qq on (q.qry_key = qq.qry_key)
where q.tab_code like '%@@TMS@@10' and qq.qry_active = 't'
group by qq.client_code;

and exists (select 1 from qrytable q1 where q1.tab_code not like '%@@TMS@@10'
and q.qry_key = q1.qry_key
) group by qq.client_code;


select qry_mode, qry_ext_templateid
from qryquery where qry_mode in ('SMP', 'STD') and qry_status = 90 and qry_active = 't' and client_code = 'ADPADMIN'
and qry_ext_templateid like 'ENT50%'
or qry_name like 'HWS%';


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
   and q.qry_ext_templateid like 'WFN9%'
order by 2,6,5;


select qq.client_code, count(1)
from qrytable q join qryquery qq on (q.qry_key = qq.qry_key)
where q.tab_code like '%@@TMS@@10' and qq.qry_active = 't'
group by qq.client_code;
  2    3    4

CLIENT_CODE			 COUNT(1)
------------------------------ ----------
USFMGP				       26
SCMST					2
BVTNONVANP				5
VANBVT3 				2
IACG					4
TWRGRP				       19
USFMG				       28
DYNEGYUAT				2
DJORTHOQ			       20
KRAFTEV4ID				8
DYNEGY					1
SCMS					4
DJORTHOP			       10

13 rows selected.






HRII_CUSTOM_FIELD

select distinct bi.inst_key, bi.inst_sid from batclientenvironment  bce
join batinstance bi on (bce.inst_key = bi.inst_key)
where prd_code = 'HRII';

van22d=(DESCRIPTION=(ADDRESS_LIST=(LOAD_BALANCE=yes)(FAILOVER=ON) (ADDRESS=(PROTOCOL=tcp)(HOST=cdldftaf2-scan.es.ad.adp.com)(PORT=1521))) (CONNECT_DATA=(SERVICE_NAME=van22d_svc1)))


vand02d=(DESCRIPTION=(ADDRESS_LIST=(LOAD_BALANCE=ON)(FAILOVER=ON) (ADDRESS=(PROTOCOL=tcp)(HOST= cdldfthf1-scan.es.ad.adp.com)(PORT=1521))) (CONNECT_DATA=(SERVICE_NAME=van02d_svc1)))



alter session set current_schema=ADP2HP;



select owner from all_objects where object_name = 'PS_CUST_ATTRIBUTES';


custom_cat1r
