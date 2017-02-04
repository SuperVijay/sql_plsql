Error client not found after security sql table reload:

call ih16_sec_context_0005.set_app_context('FCAISEY_WHATIF','HR Payroll Admin MS',
    'UK0G7K91452JFOD9','UK201606060011828','IH16_EMPLOYEE_VW_0005','','','','1070',
    'en_GB','en_GB','0','1703200718800', 'CUSTOM', '',
    '07bf63b08e6c2c9241065ad64a2220c8', 'WHATIFUK');




------------------------------

Kloeckner aren’t able to report on their absence fields for some reason,
report just returns no data.  There is lots of data in iHCM as per the screen shot below.
Fields work fine in UAT environment.  Also other fields are fine in Kloeckner.


select REQ_KEY, REQ_ROWS, req_timestamp, req_title from batreq
where client_code = 'UK201511193721487' and req_timestamp > trunc(sysdate)-5
order by 1;


Absence
       0 UK201511193721487    dtc02p			     _0007		 9644
cd /adpr/ADPRPOCIHCM01/xml/17027/00717/; ls 320*
11.128.76.35

call ih16_sec_context_0007.set_app_context('RICHARD.WARD2@KLOECKNER.COM','SuperUser',
    'UK0G3MG0620NR047','UK201511193721487',
    'IH16_EMPLOYEE_VW_0007 IH16_ADJUST_ENT_VW_0007 IH16_TYPES_VW_0007 IH16_REQUEST_LOG_VW_0007',
    '','','','1070','en_GB','en_GB','0','1702700717320', 'CUSTOM', '',
    'b6e528aa299412eed9b622e8d60179d3', 'Kloeckner');

    SELECT VISUAL_LEVEL.FLD001 FLD001_1,
      VISUAL_LEVEL.FLD002 FLD002_2,
      VISUAL_LEVEL.FLD003 FLD003_3,
      VISUAL_LEVEL.FLD004 FLD004_4,
      VISUAL_LEVEL.FLD005 FLD005_5,
      VISUAL_LEVEL.FLD006 FLD006_6,
      VISUAL_LEVEL.FLD007 FLD007_7,
      VISUAL_LEVEL.FLD008 FLD008_8,
      VISUAL_LEVEL.FLD009 FLD009_9,
      VISUAL_LEVEL.FLD010 FLD010_10,
      VISUAL_LEVEL.FLD011 FLD011_11
    FROM
      (SELECT RPT_ROWNUMBER_LEVEL.FLD001 FLD001,
        RPT_ROWNUMBER_LEVEL.FLD002 FLD002,
        RPT_ROWNUMBER_LEVEL.FLD003 FLD003,
        RPT_ROWNUMBER_LEVEL.FLD004 FLD004,
        RPT_ROWNUMBER_LEVEL.FLD005 FLD005,
        RPT_ROWNUMBER_LEVEL.FLD006 FLD006,
        RPT_ROWNUMBER_LEVEL.FLD007 FLD007,
        RPT_ROWNUMBER_LEVEL.FLD008 FLD008,
        RPT_ROWNUMBER_LEVEL.FLD009 FLD009,
        SUM(
        CASE
          WHEN RPT_ROWNUMBER_LEVEL.ROWNUMBER_FLD010 = 1
          THEN RPT_ROWNUMBER_LEVEL.FLD010
          ELSE NULL
        END) FLD010,
        RPT_ROWNUMBER_LEVEL.FLD011 FLD011
      FROM
        (SELECT TABLE1.REFERENCENUMBER FLD001,
          TABLE1.FULLNAME FLD002,
          TABLE1.STATUS FLD003,
          TABLE4.STATUS FLD004,
          TABLE4.LEAVESTARTS FLD005,
          TABLE4.STARTTIME FLD006,
          TABLE4.LEAVEENDDATE FLD007,
          TABLE4.ENDALLDAY FLD008,
          TABLE4.ENDTIME FLD009,
          TABLE4.TIMEOFF FLD010,
          ROW_NUMBER() OVER (PARTITION BY TABLE1.REFERENCENUMBER,TABLE1.FULLNAME,
              TABLE1.STATUS,TABLE4.STATUS,TABLE4.LEAVESTARTS,TABLE4.STARTTIME,
              TABLE4.LEAVEENDDATE,TABLE4.ENDALLDAY,TABLE4.ENDTIME,TABLE4.LEAVE_TYPE,
              TABLE4.PEOPLE_ID,TABLE4.LEAVE_ID ORDER BY TABLE4.TIMEOFF DESC) ROWNUMBER_FLD010,
          TABLE4.LEAVE_TYPE FLD011
        FROM IH16_EMPLOYEE_VW_0007 TABLE1,
         -- IH16_ADJUST_ENT_VW_0007 TABLE2,
          --IH16_TYPES_VW_0007 TABLE3,
          IH16_REQUEST_LOG_VW_0007 TABLE4
        WHERE 1                 =1
        and TABLE1.PEOPLE_ID   =TABLE4.PEOPLE_ID
    --    AND (TABLE1.PEOPLE_ID   =TABLE2.PEOPLE_ID (+))
    --    AND (TABLE3.LEAVETYPE_ID=TABLE2.LEAVETYPE_ID (+) )
    --    AND (TABLE4.LEAVETYPEID =TABLE3.LEAVETYPE_ID )
        ) RPT_ROWNUMBER_LEVEL
      GROUP BY RPT_ROWNUMBER_LEVEL.FLD001,
        RPT_ROWNUMBER_LEVEL.FLD002,
        RPT_ROWNUMBER_LEVEL.FLD003,
        RPT_ROWNUMBER_LEVEL.FLD004,
        RPT_ROWNUMBER_LEVEL.FLD005,
        RPT_ROWNUMBER_LEVEL.FLD006,
        RPT_ROWNUMBER_LEVEL.FLD007,
        RPT_ROWNUMBER_LEVEL.FLD008,
        RPT_ROWNUMBER_LEVEL.FLD009,
        RPT_ROWNUMBER_LEVEL.FLD011
      ORDER BY FLD001
      ) VISUAL_LEVEL;




--------------------------

KLOECKNER
UK201511193721487				   0007 			  16




call ih16_sec_context_0007.set_app_context('RICHARD.WARD2@KLOECKNER.COM','SuperUser',
    'UK0G3MG0620NR047','UK201511193721487','IH16_EMPLOYEE_VW_0007','','','','1070',
    'en_GB','en_GB','0','1701300713030', 'CUSTOM', '', 'fc27f119a0871314f6a62dcd8e5bf9a2', 'Kloeckner');

    SELECT VISUAL_LEVEL.FLD001 FLD001_1
    FROM
      (SELECT DISTINCT RPT_CRTL_RECORD_LEVEL.FLD001 FLD001
      FROM
        (SELECT DISTINCT RPT_ROWNUMBER_LEVEL.FLD001 FLD001
        FROM
          (SELECT TABLE1.FULLNAME FLD001 FROM IH16_EMPLOYEE_VW_0007 TABLE1 WHERE 1=1
          ) RPT_ROWNUMBER_LEVEL
        ) RPT_CRTL_RECORD_LEVEL
      ORDER BY FLD001 ASC
  ) VISUAL_LEVEL;

  SELECT count(1)
  FROM IHCM_CLIENT0007.PEOPLER629500
  WHERE SYS_CONTEXT('IH16_APP_CONTEXT_0007','ROLENAME') = 'SUPERUSER'

select  count(1) from IH16_EMPLOYEE_VW_0007;


from XPEOPLE where 1=2IH16_EMPLOYEE_VW_0007



select * from ih16_OCSYS_SECADMIN_SQL_0007;

select * from IHCM_CLIENT0007.OCSYS_SECURITYADMIN_SQL where
DATASOURCE_NAME='PEOPLE' and upper(rolename) = 'SUPERUSER' and action = 0;


select rolename, count(MANUAL_OVERRIDE_SQL)
from IHCM_CLIENT0007.OCSYS_SECURITYADMIN_SQL where 1=1
--and upper(rolename) = 'SUPERUSER'
and action = 0
and MANUAL_OVERRIDE_SQL is not null
group by rolename;

select dbms_metadata.get_ddl('TABLE', 'OCSYS_SECURITYADMIN_SQL') from dual;


sqlplus ihcm_client0005/ihcm_client0005@dtc02p
update OCSYS_SECURITYADMIN_SQL set MANUAL_OVERRIDE=null,
    MANUAL_OVERRIDE_SQL=null, MANUAL_OVERRIDE_NOTES=null
    where upper(rolename)  in ('SUPERUSER', 'ADPRESERVED') and action = 0;
commit;

begin
   for vw in (select * from IH16_ROW_LVL_SEC_SQL where upper(role) in ('SUPERUSER', 'ADPRESERVED'))
   loop
     GEN_CLIENT_CODE_PKG.gen_sec_view(vw.sec_name,vw.sec_sql);
   end loop;
end;
/
commit;

sqlplus ihcm_client0006/ihcm_client0006@dtc02p
update OCSYS_SECURITYADMIN_SQL set MANUAL_OVERRIDE=null,
    MANUAL_OVERRIDE_SQL=null, MANUAL_OVERRIDE_NOTES=null
    where upper(rolename)  in ('SUPERUSER', 'ADPRESERVED') and action = 0;
commit;

begin
   for vw in (select * from IH16_ROW_LVL_SEC_SQL where upper(role) in ('SUPERUSER', 'ADPRESERVED'))
   loop
     GEN_CLIENT_CODE_PKG.gen_sec_view(vw.sec_name,vw.sec_sql);
   end loop;
end;
/
commit;

sqlplus ihcm_client0007/ihcm_client0007@dtc02p
update OCSYS_SECURITYADMIN_SQL set MANUAL_OVERRIDE=null,
    MANUAL_OVERRIDE_SQL=null, MANUAL_OVERRIDE_NOTES=null
    where upper(rolename)  in ('SUPERUSER', 'ADPRESERVED') and action = 0;
commit;

begin
   for vw in (select * from IH16_ROW_LVL_SEC_SQL where upper(role) in ('SUPERUSER', 'ADPRESERVED'))
   loop
     GEN_CLIENT_CODE_PKG.gen_sec_view(vw.sec_name,vw.sec_sql);
   end loop;
end;
/
commit;




, , MANUAL_OVERRIDE_NOTES

  IH16_APP_CONTEXT_0007.APP_ASSOID = [UK0G3MG0620NR047]
  IH16_APP_CONTEXT_0007.APP_CULTURECODE = [en-GB]
  IH16_APP_CONTEXT_0007.APP_INVOCATION_TYPE = [CUSTOM]
  IH16_APP_CONTEXT_0007.APP_CLIENTID = [UK201511193721487]
  IH16_APP_CONTEXT_0007.APP_DATAMARTENTRYID = [FC27F119A0871314F6A62DCD8E5BF9A2]
  IH16_APP_CONTEXT_0007.APP_AOID = [UK0G3MG0620NR047]
  IH16_APP_CONTEXT_0007.ROLENAME = [SUPERUSER]
  IH16_APP_CONTEXT_0007.APP_USERID = [RICHARD.WARD2@KLOECKNER.COM]
  IH16_APP_CONTEXT_0007.APP_ASSORECORDID = [02B5FB52-B2F9-4202-A4D8-BCAC801ABBDC]
  IH16_APP_CONTEXT_0007.APP_ROLEID = [C43BBC46-EC96-47CB-B804-7A1C4597C48D]

  select distinct oc_user.roleid, upper(sec_admin.rolename),oc_user.culturecode,
  upper(oc_user.userid),upper(oc_user.aoid),oc_user.ASSOCIATEDRECORDID,
  upper(sec_admin.rolename)
      from ih16_oc_users_0007 oc_user , ih16_OCSYS_SECADMIN_SQL_0007 sec_admin
          where oc_user.roleid = sec_admin.roleid
            and upper(oc_user.aoid) = upper('UK0G3MG0620NR047')
            and upper(sec_admin.rolename) = upper('SuperUser') ;

            C43BBC46-EC96-47CB-B804-7A1C4597C48D
            SUPERUSER
            en-GB
            RICHARD.WARD2@KLOECKNER.COM
            UK0G3MG0620NR047
            02B5FB52-B2F9-4202-A4D8-BCAC801ABBDC
            SUPERUSER




11.128.76.38
select max(req_key) from batreq where client_code = 'UK201511193721487';

1701300713030

OK		13-JAN-17 03.08.42.874000 PM   RICHARD.WARD2@KLOECK
					       NER.COM
Employee  List
       0 UK201511193721487    dtc02p			     _0007		 9644
cd /adpr/ADPRPOCIHCM01/xml/17013/00713/; ls 030*
lx2451.admin.ehc.adp.com/11.128.76.38,/apps/Logs/DCIPCPRD_01/listener/log/listener.10958.log

RUN 13-JAN-17 03.08.44.941007 PM
Allocating batreq to run

RUN 13-JAN-17 03.08.48.056514 PM
Running security procedures

RUN 13-JAN-17 03.08.48.079918 PM
Running table procedures

RUN 13-JAN-17 03.08.48.247601 PM
Rendering result set data

OK  13-JAN-17 03.08.48.301366 PM
Finishing Extractor

OK  13-JAN-17 03.08.48.319469 PM
Rendering report output

OK  13-JAN-17 03.08.48.445327 PM
Finished rendering report output

EMPLOYEE_DETAILS@@IHCM@@16     IH16_EMPLOYEE_VW 	      1701321831430
EMPLOYEE@@IHCM@@16	       IH16_EMPLOYEE_VW 	      1701321831430
1701364752650	13-JAN-17 03.05.56.464873 PM			  20369
ADPR_APP_VERSION	       14.01.00.064 - 12/12/2016 07:45
ANALYZE_DATA_FEATURE_AVAILABLE t
APP_RESOURCES		       1003,1006,1046,6001,1040,5001
BROWSER_INFO		       unknown/
CERT_LOGIN		       1
CLIENT_DEFAULT_LOCALE	       en_GB
HTTP_ASSOCIATEOID	       UK0G3MG0620NR047
HTTP_HOST		       mbudataclbevip-dc4.ehc.adp.com
HTTP_ISISESSIONID	       /ck0QwzhmzL7ya78zKvyQzZkNg0=
HTTP_ORGOID		       UK201511193721487
HTTP_PROFILEDN		       adpProfileID=CRTClientPrefAdmin,adpProductCode=IHCM,ou=Products,o=adp.com
HTTP_SM_AUTHTYPE	       Form
HTTP_SM_USER		       RICHARD.WARD2@KLOECKNER.COM
HTTP_SM_USERDN		       uid=uk0g3mg0620nr047,ou=people,o=customer
IS_IHCM 		       t
LOCALE			       en_GB
PHPSessionID		       MDEyZjJkYWU2ZWNlNmEwMWQxMGZiNTMzOTYwNjdlNzJmMWE3Y2JkYjQwZDNkMWRm
PRD_RESOURCES		       301
REMOTE_ID		       11.128.79.254
RENDER_STYLE		       STANDALONE_FROM_PORTAL
UAPRACTITIONER		       0
USER_AGENT		       Apache-HttpClient/4.5.1 (Java/1.8.0)
USER_FEATURES		       217,234,231,225,224,229,211,213,239,236,230,227,222,228,232,214,223,212
USER_ROLEKEYS		       1




PROCEDURE set_user_context
    (
	v_user_id      IN VARCHAR2,
	v_associateoid IN VARCHAR2,
	v_clientid     in VARCHAR2,
	v_invocation_type in varchar2,
	v_roleid in varchar2,
	v_rolename in varchar2,
	v_culturecode in varchar2,
	v_aoid in varchar2,
	v_assorecordid in varchar2,
	v_DataMartEntryID in varchar2
    ) IS
	v_context_name varchar2(100);
	-- This is a private procedure.
	-- This procedure is invoked once per session to set user_id, role
	-- This procedure also sets client information that can be seen in Oracle data dictionary.
    BEGIN
	v_context_name := 'IH16_app_context_' || '0007';

	dbms_session.set_context(v_context_name, 'app_userid', v_user_id,4000); -- sets the userid a
ccessing the application

	dbms_session.set_context(v_context_name, 'app_assoid', v_associateoid); --sets the associate
 oid  accessing the application

	dbms_session.set_context(v_context_name, 'app_clientid', v_clientid); --sets the orgoid  acc
essing the application

	dbms_session.set_context(v_context_name, 'app_invocation_type', v_invocation_type,4000); --
sets the invocation type accessing the application

	dbms_session.set_context(v_context_name, 'app_roleid', v_roleid,4000); -- sets the role ofth
e user accessing the application

	dbms_session.set_context(v_context_name, 'rolename', v_rolename,4000); -- sets the role ofth
e user accessing the application

	dbms_session.set_context(v_context_name, 'app_culturecode', v_culturecode,4000); -- sets the
 culturecode ofthe user accessing the application

	dbms_session.set_context(v_context_name, 'app_aoid', v_Aoid,4000); -- sets the aoid ofthe us
er accessing the application

	dbms_session.set_context(v_context_name, 'app_assorecordid', v_assorecordid,4000); -- sets t
he associate record id	ofthe user accessing the application

	dbms_session.set_context(v_context_name, 'app_datamartentryid', v_DataMartEntryID,4000); --
sets the associate record id  ofthe user accessing the application

 END set_user_context;

 PROCEDURE set_col_context
  -- setting the context to 'N' for those columns for which user does not have access
    (
	v_aoid IN VARCHAR2 ,
	v_DataMartEntryID in varchar2
    ) IS
	v_context_name varchar2(100);
	TYPE cv_type IS REF CURSOR;
	cv cv_type		  ;
	contextid varchar2(30);
	 v_sql varchar2(2000);

    BEGIN
	v_context_name := 'IH16_app_context_' || '0007';
	v_sql := 'select distinct contextid from IHCM_RESTRICTED_FLDS_0007 where upper(id) = ' ||
'''' || v_DataMartEntryID || ''''  || ' and upper(aoid) = '  || '''' || v_aoid || '''' ;

      -- dbms_output.put_line(v_sql);
       open cv for v_Sql;
	 LOOP
	    FETCH cv
		INTO contextid;
	    EXIT WHEN cv%NOTFOUND;
	 --   dbms_output.put_line(contextid);
	    dbms_session.set_context(v_context_name, contextid , 'N'); -- sets the context to 'N' of
 black listed fields

	  END LOOP;
       close cv;

 END set_col_context;


PROCEDURE set_app_context
    (
	i_userid   IN VARCHAR2,
	i_role	   IN VARCHAR2,
	i_associateoid IN VARCHAR2,
	i_clientid     IN VARCHAR2,
	i_from	   IN VARCHAR2,
	i_filter   IN VARCHAR2,
	i_param    in varchar2 ,
	i_acs_resource in varchar2 ,
	i_product_locale in varchar2,
	i_user_locale in varchar2,
	i_client_default_locale in varchar2,
	i_ua_mode_user in varchar2,
	i_request_id in varchar2,
	i_invocation_type in varchar2,
	i_external_templateid in varchar2,
	i_DataMartEntryID in varchar2,
	i_DatabaseName in varchar2
    ) IS
	TYPE cv_type IS REF CURSOR;
	cv cv_type		  ;
	v_context_name varchar2(100);
	v_roleid     VARCHAR2(50) DEFAULT NULL;
	v_rolename   VARCHAR2(50) DEFAULT NULL;
	v_culturecode  VARCHAR2(50) DEFAULT NULL;
	v_userid    VARCHAR2(50) DEFAULT NULL;
	v_aoid	    VARCHAR2(200) DEFAULT NULL;
	v_assorecordid	VARCHAR2(50) DEFAULT NULL;
	v_databasename varchar2(100) DEFAULT NULL;

    begin
      clear_user_context;

      v_context_name := 'IH16_app_context_' || '0007';

    select database_name --into v_databasename
       from IH16_CLIENT_DB_INFO_0007
       where upper(database_name) = upper('Kloeckner') ;

    if v_databasename is null then
       RAISE no_data_found;
    end if;

      select distinct oc_user.roleid, upper(sec_admin.rolename),oc_user.culturecode,
      upper(oc_user.userid),upper(oc_user.aoid),oc_user.ASSOCIATEDRECORDID
	  --into v_roleid ,v_rolename ,v_culturecode,v_userid ,v_aoid ,v_assorecordid
	 from ihcm_client0007.oc_users oc_user , ih16_OCSYS_SECADMIN_SQL_0007 sec_admin
	where oc_user.roleid = sec_admin.roleid
	  and upper(oc_user.aoid) = upper('UK0G3MG0620NR047')
	  and upper(sec_admin.rolename) = upper('SuperUser') ;
      if v_userid is null then
	  RAISE no_data_found;
       end if;

       C43BBC46-EC96-47CB-B804-7A1C4597C48D
       SUPERUSER
       en-GB
       RICHARD.WARD2@KLOECKNER.COM
       UK0G3MG0620NR047
       02B5FB52-B2F9-4202-A4D8-BCAC801ABBDC



     set_user_context(v_userid, i_associateoid ,i_clientid, i_invocation_type, v_roleid, v_rolename,
v_culturecode ,v_aoid,v_assorecordid, upper(i_DataMartEntryID) );


      /*  Following block is invoked only during login time of the user  */
    if i_invocation_type = 'LOGON' then
      delete from IHCM_RESTRICTED_FLDS_0007 where upper(id) = upper(i_DataMartEntryID) ; -- delete t
he entry from the table before inserting what all columns user does not have access based on the uui
d

      insert into whitelist_gtt
      select   jt.tablename ,decode(columnname,'*','ALL',columnname) columnname
	  from ihcm_col_sec_0007 sec
	     , json_table(sec.secmsg,'$'
			   columns
			     (nested path '$.whitelist[*]'
			       columns (tablename varchar2(50)	 path '$.tableName'
					 ,nested path '$.columns[*]'
					   columns (columnname path '$')
				       )
			      )
			 )jt
	  where 1=1
	   and upper(id) = upper(i_DataMartEntryID)
	   and decode(columnname,'*','ALL',columnname) <> 'ALL';


      insert into IHCM_RESTRICTED_FLDS_0007
      with black_list as
      (
	select tcm.sql_tab_name tablename ,tcm.sql_col_name columnname
	from tab_col_map tcm where sql_tab_name in (select distinct tablename from whitelist_gtt)
	minus
	select tablename  ,columnname from whitelist_gtt
      )
       select upper(i_DataMartEntryID) ,v_aoid ,i_clientid ,tcm.l1view tablename,tcm.ora_col_name co
lumnname ,tcm.context_id,systimestamp

       from black_list bl , tab_Col_map tcm
       where trim(bl.tablename) = trim(tcm.sql_tab_name )
	 and trim(bl.columnname) = trim(tcm.sql_col_name );

       commit;
       -- dbms_output.put_line('I am inside login block');
  end if;

     set_col_context(v_aoid,upper(i_DataMartEntryID)) ;

EXCEPTION
	WHEN no_data_found THEN
	    ihcm_application_manager.log_application_error('ihcm',
							   '',
							   '0007',
							   'IH16_0007',
							   'set_app_context',
							   i_userid,
							   i_role,
							   'no userid',
							   'input error',
							   SQLCODE,
							   'User does not exist ',
							   '',
							   '',
							   NULL,
							   NULL);
	    raise_application_error(-20001,
				    'IH16_sec_context_0007set_app_context: input error: userid ' ||
				      i_userid || ' does not belong to any client');
	WHEN OTHERS THEN
	    ihcm_application_manager.log_application_error('ihcm',
							   '',
							   '0007',
							   'IH16_0007',
							   'set_app_context',
							   i_userid,
							   i_role,
							   'a',
							   'internal error',
							   SQLCODE,
							   SQLERRM,
							   '',
							   '',
							   NULL,
							   NULL);
	    raise_application_error(-20000,
				    'IH16_sec_context_0007set_app_context: internal error: ' ||
				    SQLERRM);

  END set_app_context;

END IH16_sec_context_0007;
