ACS flag mismatches:


SELECT DISTINCT B.CLIENT_CODE||','||A.ORGANIZATION_OID||','||
DECODE(A.ACTIVATION_FLAG , 1, 't','f') ||','||B.BCP_HAS_PAYX2_ACS_INTEGRATION
FROM V_CLIENT_LOGON A,
(SELECT CLIENT_CODE,CLIENT_ORGOID,PRD_CODE,BCP_HAS_PAYX2_ACS_INTEGRATION
FROM (
SELECT A.CLIENT_CODE,CLIENT_ORGOID,PRD_CODE,BCP_HAS_PAYX2_ACS_INTEGRATION FROM ADPRMASPRD01.batclientproduct@DBLINKCRU40PTOCRW11P A,
ADPRMASPRD01.catclient@DBLINKCRU40PTOCRW11P B
WHERE A.CLIENT_CODE = B.CLIENT_CODE and A.prd_code='PAYX2' AND A.VER_CODE = '185' AND B.CLIENT_ACTIVE = 't'
and not exists (select 1 from ADPRMASPRD01.batclientproduct@DBLINKCRU40PTOCRW11P x where x.client_code = b.client_code
and x.prd_code ='WFN')
and exists (select 1 from ADPRMASPRD01.secsession@DBLINKCRU40PTOCRW11P s where s.client_code = b.client_code
  and s.session_timestamp > to_date('11/01/2016', 'MM/DD/YYYY'))
UNION ALL
SELECT A.CLIENT_CODE,CLIENT_ORGOID,PRD_CODE,BCP_HAS_PAYX2_ACS_INTEGRATION FROM ADPRMASPRD02.batclientproduct@DBLINKCRU40PTOCRW12P A,
ADPRMASPRD02.catclient@DBLINKCRU40PTOCRW12P B
WHERE A.CLIENT_CODE = B.CLIENT_CODE and A.prd_code='PAYX2' AND A.VER_CODE = '185'
AND B.CLIENT_ACTIVE = 't'
and not exists (select 1 from ADPRMASPRD02.batclientproduct@DBLINKCRU40PTOCRW12P x where x.client_code = b.client_code
and x.prd_code ='WFN')
and exists (select 1 from ADPRMASPRD02.secsession@DBLINKCRU40PTOCRW12P s where s.client_code = b.client_code
  and s.session_timestamp > to_date('11/01/2016', 'MM/DD/YYYY'))
UNION ALL
SELECT A.CLIENT_CODE,CLIENT_ORGOID,PRD_CODE,BCP_HAS_PAYX2_ACS_INTEGRATION FROM ADPRMASPRD03.batclientproduct@DBLINKCRU40PTOCRW13P A,
ADPRMASPRD03.catclient@DBLINKCRU40PTOCRW13P B
WHERE A.CLIENT_CODE = B.CLIENT_CODE and A.prd_code='PAYX2' AND A.VER_CODE = '185'
AND B.CLIENT_ACTIVE = 't'
and not exists (select 1 from ADPRMASPRD03.batclientproduct@DBLINKCRU40PTOCRW13P x where x.client_code = b.client_code
and x.prd_code ='WFN')
and exists (select 1 from ADPRMASPRD03.secsession@DBLINKCRU40PTOCRW13P s where s.client_code = b.client_code
  and s.session_timestamp > to_date('11/01/2016', 'MM/DD/YYYY'))
UNION ALL
SELECT A.CLIENT_CODE,CLIENT_ORGOID,PRD_CODE,BCP_HAS_PAYX2_ACS_INTEGRATION FROM webrepadmin.batclientproduct@DBLINKCRU40PTOCRW11P A,
webrepadmin.catclient@DBLINKCRU40PTOCRW11P B
WHERE A.CLIENT_CODE = B.CLIENT_CODE and A.prd_code='PAYX2' AND A.VER_CODE = '185'
AND B.CLIENT_ACTIVE = 't'
and not exists (select 1 from webrepadmin.batclientproduct@DBLINKCRU40PTOCRW11P x where x.client_code = b.client_code
and x.prd_code ='WFN')
and exists (select 1 from webrepadmin.secsession@DBLINKCRU40PTOCRW11P s where s.client_code = b.client_code
  and s.session_timestamp > to_date('11/01/2016', 'MM/DD/YYYY'))
)) B
WHERE A.ORGANIZATION_OID = B.CLIENT_ORGOID
AND DECODE(A.ACTIVATION_FLAG,1,'t','f') <> B.BCP_HAS_PAYX2_ACS_INTEGRATION
order by 1;
