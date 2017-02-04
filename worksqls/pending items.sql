

TO DO:
time off archived changes defect: US605871
\\dc01esisilon01-fs1.es.oneadp.com\cpsfileshare\dev\ADPR\R124_CATALOGS\DEC_MR_2016\WFN11\ADPR02.012WFN11.00
2012WFn11.00.tar has that











create or replace view vijay_test_prev_emp as
select	tt.vpd_key,
	pe.oid					Oid,
		pe.StartDate			Start_Date,
		pe.EndDate				End_Date,
		null  					Duration,
		pe.Title		 		Title,
		pe.JobClass				Job_Class_Oid,
		UserField1				text1,
		UserField2				text2,
		Responsibilities	Responsibilities,
		Months					Months,
		Years					Years,
		Description				Description,
		Name					Name,
		Subclass				Sub_class,
		t.Oid					Previous_Employer_oid,
		Comments				Comments,
		tt.link_oid				Employee_oid,
		tt.link_oid   			Candidate_oid,
		 1						Active,
		'0'						Version,
		null					Modified_by_user,
		null					Modified_on,
	EXTRACT(t.prevemp,'/PrevEmployerJobs/element/Responsibilities/text()')  Responsibilities_ADPR
FROM  wfn_metadata_xml tt,
XMLTable('/entity/list/element' PASSING tt.xvalue
		COLUMNS Oid 	VARCHAR2(32 ) PATH 'Oid',
			prevemp  XMLType      PATH 'PrevEmployerJobs') t,
 XMLTable('/PrevEmployerJobs/element' PASSING t.prevemp
    columns
	oid 				VARCHAR2(50)   path  'Oid',
    StartDate			DATE	       path  'StartDate',
    EndDate				DATE	       path  'EndDate',
	Title				varchar2(255)  path	 'JobTitle',
	JobClass			varchar2(50)   path	 'JobClass',
	Responsibilities    CLOB	   path  'Responsibilities',
	Months				varchar2(16)   path	 'Months',
	Years				varchar2(16)   path	 'Years',
	Description		    Varchar2(255)  path  'Description',
	Name				Varchar2(255)  path  'Name',
	SubClass	    Varchar2(255)  path  'SubClass',
	EmployerOid			Varchar2(32)   path  'EmployerOid',
    ReasonForLeaving 	varchar2(200)  path  'ReasonForLeaving',
	LastSalary		 	varchar2(200)  path  'LastSalary',
	ReferenceDate 		varchar2(20)   path  'ReferenceDate',
	UserField1			varchar2(50)   path  'Text1',
	UserField2			varchar2(50)   path  'Text2',
	Comments			varchar2(100)  path  'Comments',
    Responsibilities_ADPR varchar2(4000)  path 'Responsibilities'
	) pe
where entity='previousEmployers';
