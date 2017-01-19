
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
