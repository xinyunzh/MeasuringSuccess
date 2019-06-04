create schema newcohort;
SHOW search_path;
SET search_path TO newcohort;

--create demographic table and import from csv file
create table Demographic(
Agency varchar(50),
ClientID varchar(50) primary key,
Quarter varchar(10),
Baseline_Baseline boolean,
DOB timestamp,
DOB_cat varchar(20),
Gender varchar(10),
Race varchar(50),
MaritalStatus varchar(50),
HighestEd varchar(50),
HousingType varchar(50),
HHAdults smallint,
HHChildren smallint,
CriminalBackground varchar(20),
Zipcode int,
date timestamp
);

--copy data from csv file
copy demographic from 'C:\Users\Leah Zhang\Desktop\database\newCohort\CSVs_2019Q1\demographic.csv' DELIMITER  ',' csv header;

select * from demographic;

--create a temp employment table for copy employment data 
create table temp_employment(
employmentid int,
AccessEmployment varchar(10),
EmploymentStatus varchar(50),
EmploymentStartDate timestamp,
EmploymentRetention varchar(10),
JobTrainingEnrolled varchar(10),
JobTrainingCompleted varchar(10)
);

copy temp_employment from 'C:\Users\Leah Zhang\Desktop\database\newCohort\CSVs_2019Q1\employment.csv' DELIMITER  ',' csv header;

select * from temp_employment;

--create the real table for employment
create table Employment(
EmploymentID serial primary key,
AccessEmployment varchar(10),
EmploymentStatus varchar(50),
EmploymentStartDate timestamp,     
EmploymentRetention varchar(10),
JobTrainingEnrolled varchar(10),
JobTrainingCompleted varchar(10)
);


--insert real data into employment
insert into employment (accessemployment, employmentstatus, employmentstartdate, employmentretention, jobtrainingenrolled, jobtrainingcompleted)
select accessemployment, employmentstatus, employmentstartdate, employmentretention, jobtrainingenrolled, jobtrainingcompleted from temp_employment
order by employmentid asc;

drop table temp_employment;

select * from employment;   --12 rows for employment


--create temp table for financials
create table temp_financials(
fid int,
Savings numeric,
CreditScore smallint,
Debt numeric
);

--copy data
copy temp_financials from 'C:\Users\Leah Zhang\Desktop\database\newCohort\CSVs_2019Q1\financials.csv' DELIMITER  ',' csv header;

select * from temp_financials;

--create the real table for financials
create table Financials(
FinancialsID serial primary key,
Savings numeric,
CreditScore smallint,
Debt numeric
);

--insert data
insert into financials(savings, creditscore, debt)
select savings, creditscore, debt from temp_financials
order by fid asc;

drop table temp_financials;

select * from financials;   --12 rows for financials


--create temp table for fincap
create table temp_fincap(
fincapid int,
FinCap_Budget varchar(10),
FinCap_Goals varchar(50),
FinCap_EmergencyFund varchar(10),
FinCap_AutoDeposit varchar(10),
FinCap_IncomeExpenses varchar(20),
FinCap_LateFee varchar(10)
);

copy temp_fincap from 'C:\Users\Leah Zhang\Desktop\database\newCohort\CSVs_2019Q1\fincap.csv' DELIMITER  ',' csv header;

select * from temp_fincap;

create table FinCap(
FinCapID serial primary key,
FinCap_Budget varchar(10),
FinCap_Goals varchar(50),
FinCap_EmergencyFund varchar(10),
FinCap_AutoDeposit varchar(10),
FinCap_IncomeExpenses varchar(20),
FinCap_LateFee varchar(10));
					   
insert into fincap(fincap_budget, fincap_goals, fincap_emergencyfund, fincap_autodeposit, fincap_incomeexpenses, fincap_latefee)
select fincap_budget, fincap_goals, fincap_emergencyfund, fincap_autodeposit, fincap_incomeexpenses, fincap_latefee from temp_fincap
					   order by fincapid asc;

drop table temp_fincap;
select * from fincap;    --12 rows for fincap

create table temp_wages(
wagesid int,
Wages1 numeric,
Hours1 numeric,
Wages2 numeric,
Hours2 numeric
);
			   
copy temp_wages from 'C:\Users\Leah Zhang\Desktop\database\newCohort\CSVs_2019Q1\wages.csv' DELIMITER  ',' csv header;			--12

select * from temp_wages;
					   
create table Wages(
WagesID serial primary key,
Wages1 numeric,
Hours1 numeric,
Wages2 numeric,
Hours2 numeric
);

insert into wages(wages1, hours1, wages2, hours2)
select wages1, hours1, wages2, hours2 from temp_wages
					   order by wagesid asc;

drop table temp_wages;
select * from wages;    --12

					   
create table temp_incomeexpenses(
IncomeExpensesID int ,
IncomeClient numeric,
IncomeHH numeric,
PublicBenefits numeric,
ExpensesHH numeric
)	;				   

copy temp_incomeexpenses from 'C:\Users\Leah Zhang\Desktop\database\newCohort\CSVs_2019Q1\incomeexpenses.csv' DELIMITER  ',' csv header;	

select * from temp_incomeexpenses;					   


create table IncomeExpenses(
IncomeExpensesID serial primary key,
IncomeClient numeric,
IncomeHH numeric,
PublicBenefits numeric,
ExpensesHH numeric);

					   
insert into incomeexpenses(incomeclient, incomehh, publicbenefits, expenseshh)
select incomeclient, incomehh, publicbenefits, expenseshh from temp_incomeexpenses
					   order by incomeexpensesid asc;   --12
					   
drop table temp_incomeexpenses;


create table temp_bundling_checkin(BundledServicesID int,
BenefitsScreening varchar(10),
BenefitsAccess varchar(10),
AgencyProvidedSupport varchar(10),
AccessIncome varchar(10),
AccessEmployment varchar(10),
AccessFinancialCoach varchar(10),
BundledServices smallint check(BundledServices>=0)
);
					   
copy temp_bundling_checkin from 'C:\Users\Leah Zhang\Desktop\database\newCohort\CSVs_2019Q1\bundledservices.csv' DELIMITER  ',' csv header;	--12
					
select * from temp_bundling_checkin;					   
					   
create table BundledServices_checkin(
BundledServicesID serial primary key,
BenefitsScreening varchar(10),
BenefitsAccess varchar(10),
AgencyProvidedSupport varchar(10),
AccessIncome varchar(10),
AccessEmployment varchar(10),
AccessFinancialCoach varchar(10),
BundledServices smallint check(BundledServices>=0));
							   
							   
insert into bundledservices_checkin(benefitsscreening, benefitsaccess, agencyprovidedsupport, accessincome, accessemployment, accessfinancialcoach,
bundledservices)
select benefitsscreening, benefitsaccess, agencyprovidedsupport, accessincome, accessemployment, accessfinancialcoach,
bundledservices from temp_bundling_checkin
							   order by bundledservicesid asc;    --12
							   
drop table temp_bundling_checkin;							   
--create temporary table for records	
						   
create table temp_records(
RecordID int,
ClientID varchar(50),
Quarter varchar(10),
Baseline_Baseline boolean,
date timestamp
);  

copy temp_records from 'C:\Users\Leah Zhang\Desktop\database\newCohort\CSVs_2019Q1\client.csv' DELIMITER  ',' csv header;					--23663		   

select * from temp_records;							   
							   
select recordid from temp_records;				--12			   
select employmentid from employment;       --12

--create table records for keeping all records we have							   
create table records(
RecordID serial primary key,
ClientID varchar(50),
Quarter varchar(10),
date timestamp,
Baseline_Baseline boolean,
employmentid int references employment(employmentid),
financialsid int references financials(financialsid),
fincapid int references fincap(fincapid),
wagesid int references wages(wagesid),
incomeexpensesid int references incomeexpenses(incomeexpensesid),
bundledservicesid int references bundledservices_checkin(bundledservicesid));

--insert into records values from different tables join by row numbers														 
insert into records(clientid, quarter, date, baseline_baseline, employmentid,financialsid, fincapid, wagesid, incomeexpensesid, bundledservicesid)														 
select 	clientid, quarter, date, baseline_baseline, employmentid,financialsid, fincapid, wagesid, incomeexpensesid, bundledservicesid  from													 
(select clientid, quarter, date, baseline_baseline, row_number() over (order by recordid) r from temp_records)a
join
(select employmentid, row_number() over (order by employmentid) r from employment)b														 
on a.r=b.r
join 														 
(select financialsid, row_number() over (order by financialsid) r from financials)c
on b.r=c.r
join
(select fincapid, row_number() over (order by fincapid) r from fincap)d
on c.r=d.r														 
join 														 														 
(select wagesid, row_number() over (order by wagesid) r from wages)e
on d.r=e.r
join														 
(select incomeexpensesid, row_number() over (order by incomeexpensesid) r from incomeexpenses)f														 
on e.r=f.r
join														 
(select bundledservicesid, row_number() over (order by bundledservicesid) r from bundledservices_checkin)g															 
on f.r=g.r;														 
														 														 
drop table temp_records;
--there are two client id was slightly changed and needs to update back	in demographic table		
--update demographic table														 
--update clientid '1.67E+11' to '1.66822E+11', '1.66E+11' to '1.66166E+11'
update demographic set clientid = case
when clientid = '1.67E+11' then '1.66822E+11'
when clientid = '1.66E+11' then '1.66166E+11'
end
where clientid in ('1.67E+11','1.66E+11');														 
														 
				 
														 
CREATE TABLE checkintime_Alltime(
clientid varchar(50) primary key,
checkintime smallint);

INSERT INTO checkintime_Alltime
SELECT distinct(clientid),count(clientid)-1 as checkintime 
FROM records
GROUP BY clientid;


SELECT clientid, quarter, baseline_baseline,count(*) over (PARTITION BY clientid ORDER BY baseline_baseline DESC,quarter ASC) -1 AS checkintimeth
FROM records
ORDER BY clientid ASC,baseline_baseline DESC;										 

--------Finished basic data inserting---------------

--create different views for each topic we have combining clientid and quarterly check-in information
create view bundledservices_all as 
select r.recordid, r.clientid, r.quarter, r.date, r.baseline_baseline, bc.accessincome, bc.accessemployment, bc.accessfinancialcoach, bc.bundledservices from records r
join bundledservices_checkin bc on r.bundledservicesid=bc.bundledservicesid;

create view employment_all as
select r.recordid, r.clientid, r.quarter, r.date, r.baseline_baseline, e.accessemployment, e.employmentstatus, e.employmentstartdate, e.employmentretention, e.jobtrainingenrolled,
e.jobtrainingcompleted
from records r
join employment e on e.employmentid = r.employmentid;

create view financials_all as
select r.recordid, r.clientid, r.quarter, r.date, r.baseline_baseline, f.savings, f.creditscore, f.debt
from records r
join financials f on f.financialsid = r.financialsid;

create view fincap_all as 
select r.recordid, r.clientid, r.quarter, r.date, r.baseline_baseline, fc.fincap_budget, fc.fincap_goals, fc.fincap_emergencyfund, fc.fincap_autodeposit, fc.fincap_incomeexpenses,
fc.fincap_latefee
from records r
join fincap fc on fc.fincapid = r.fincapid;

create view incomeexpenses_all as
select r.recordid, r.clientid, r.quarter, r.date, r.baseline_baseline, i.incomeclient, i.incomehh, i.publicbenefits, i.expenseshh
from records r
join incomeexpenses i on i.incomeexpensesid = r.incomeexpensesid;


create view wages_all as
select r.recordid, r.clientid, r.quarter, r.date, r.baseline_baseline, w.wages1, w.hours1, w.wages2, w.hours2
from records r
join wages w on w.wagesid = r.wagesid;


--create a view of baseline data and the 2018 Q4 checkin data	
create view baseline_checkin as
select s1.*,s2.* from														 
(select d.*, e.accessemployment as accessemployment_baseline, e.employmentstatus as employmentstatus_baseline, e.employmentstartdate as employmentstartdate_baseline,
 e.employmentretention as employmentretention_baseline, e.jobtrainingenrolled as jobtrainingenrolled_baseline, e.jobtrainingcompleted as jobtrainingcompleted_baseline,
 f.savings as savings_baseline, f.creditscore as creditscore_baseline, f.debt as debt_baseline,
 w.wages1 as wages1_baseline, w.hours1 as hours1_baseline, w.wages2 as wages2_baseline, w.hours2 as hours2_baseline,
 i.incomeclient as incomeclient_baseline, i.incomehh as incomehh_baseline,
 i.publicbenefits as publicbenefits_baseline, i.expenseshh as expenseshh_baseline, bc.accessincome as accessincome_baseline, 
 bc.accessfinancialcoach as accessfinancialcoach_baseline, bc.bundledservices as bundledservices_baseline, fc.fincap_budget as fincap_budget_baseline, fc.fincap_goals as fincap_goals_baseline,
 fc.fincap_emergencyfund as fincap_emergencyfund_baseline, fc.fincap_autodeposit as fincap_autodeposit_baseline, fc.fincap_incomeexpenses as fincap_incomeexpenses_baseline, 
 fc.fincap_latefee as fincap_latefee_baseline
from demographic d join records r on r.clientid = d.clientid
left join employment e on e.employmentid = r.employmentid
left join financials f on f.financialsid=r.financialsid
left join fincap fc on fc.fincapid=r.fincapid														 
left join incomeexpenses i on i.incomeexpensesid=r.incomeexpensesid														 
left join bundledservices_checkin bc on bc.bundledservicesid=r.bundledservicesid	
left join wages w on w.wagesid = r.wagesid
where r.baseline_baseline is true) s1											 
left join														 
(select d.clientid as clientid_checkin,r.quarter as quarter_checkin, e.accessemployment as accessemployment_checkin, e.employmentstatus as employmentstatus_checkin, e.employmentstartdate as employmentstartdate_checkin,
 e.employmentretention as employmentretention_checkin, e.jobtrainingenrolled as jobtrainingenrolled_checkin, e.jobtrainingcompleted as jobtrainingcompleted_checkin,
 f.savings as savings_checkin, f.creditscore as creditscore_checkin, f.debt as debt_checkin, 
  w.wages1 as wages1_checkin, w.hours1 as hours1_checkin, w.wages2 as wages2_checkin, w.hours2 as hours_checkin,
 i.incomeclient as incomeclient_checkin, i.incomehh as incomehh_checkin,
 i.publicbenefits as publicbenefits_checkin, i.expenseshh as expenseshh_checkin, bc.accessincome as accessincome_checkin, 
 bc.accessfinancialcoach as accessfinancialcoach_checkin, bc.bundledservices as bundledservices_checkin, fc.fincap_budget as fincap_budget_checkin, fc.fincap_goals as fincap_goals_checkin,
 fc.fincap_emergencyfund as fincap_emergencyfund_checkin, fc.fincap_autodeposit as fincap_autodeposit_checkin, fc.fincap_incomeexpenses as fincap_incomeexpenses_checkin, 
 fc.fincap_latefee as fincap_latefee_checkin
from demographic d join records r on r.clientid = d.clientid
left join employment e on e.employmentid = r.employmentid
left join financials f on f.financialsid=r.financialsid
left join fincap fc on fc.fincapid=r.fincapid														 
left join incomeexpenses i on i.incomeexpensesid=r.incomeexpensesid														 
left join bundledservices_checkin bc on bc.bundledservicesid=r.bundledservicesid
left join wages w on w.wagesid = r.wagesid
where r.date = (select date from records
order by date desc
limit 1) and r.baseline_baseline is false) s2
on s1.clientid = s2.clientid_checkin;


create view for_q as
select s1.*,s2.* from														 
(select d.*, e.accessemployment as accessemployment_baseline, e.employmentstatus as employmentstatus_baseline, e.employmentstartdate as employmentstartdate_baseline,
 e.employmentretention as employmentretention_baseline, e.jobtrainingenrolled as jobtrainingenrolled_baseline, e.jobtrainingcompleted as jobtrainingcompleted_baseline,
 f.savings as savings_baseline, f.creditscore as creditscore_baseline, f.debt as debt_baseline,
 w.wages1 as wages1_baseline, w.hours1 as hours1_baseline, w.wages2 as wages2_baseline, w.hours2 as hours2_baseline,
 i.incomeclient as incomeclient_baseline, i.incomehh as incomehh_baseline,
 i.publicbenefits as publicbenefits_baseline, i.expenseshh as expenseshh_baseline, bc.accessincome as accessincome_baseline, 
 bc.accessfinancialcoach as accessfinancialcoach_baseline, bc.bundledservices as bundledservices_baseline, fc.fincap_budget as fincap_budget_baseline, fc.fincap_goals as fincap_goals_baseline,
 fc.fincap_emergencyfund as fincap_emergencyfund_baseline, fc.fincap_autodeposit as fincap_autodeposit_baseline, fc.fincap_incomeexpenses as fincap_incomeexpenses_baseline, 
 fc.fincap_latefee as fincap_latefee_baseline
from demographic d join records r on r.clientid = d.clientid
left join employment e on e.employmentid = r.employmentid
left join financials f on f.financialsid=r.financialsid
left join fincap fc on fc.fincapid=r.fincapid														 
left join incomeexpenses i on i.incomeexpensesid=r.incomeexpensesid														 
left join bundledservices_checkin bc on bc.bundledservicesid=r.bundledservicesid	
left join wages w on w.wagesid = r.wagesid
where r.baseline_baseline is true) s1											 
right join														 
(select d.clientid as clientid_checkin,r.quarter as quarter_checkin, e.accessemployment as accessemployment_checkin, e.employmentstatus as employmentstatus_checkin, e.employmentstartdate as employmentstartdate_checkin,
 e.employmentretention as employmentretention_checkin, e.jobtrainingenrolled as jobtrainingenrolled_checkin, e.jobtrainingcompleted as jobtrainingcompleted_checkin,
 f.savings as savings_checkin, f.creditscore as creditscore_checkin, f.debt as debt_checkin, 
  w.wages1 as wages1_checkin, w.hours1 as hours1_checkin, w.wages2 as wages2_checkin, w.hours2 as hours2_checkin,
 i.incomeclient as incomeclient_checkin, i.incomehh as incomehh_checkin,
 i.publicbenefits as publicbenefits_checkin, i.expenseshh as expenseshh_checkin, bc.accessincome as accessincome_checkin, 
 bc.accessfinancialcoach as accessfinancialcoach_checkin, bc.bundledservices as bundledservices_checkin, fc.fincap_budget as fincap_budget_checkin, fc.fincap_goals as fincap_goals_checkin,
 fc.fincap_emergencyfund as fincap_emergencyfund_checkin, fc.fincap_autodeposit as fincap_autodeposit_checkin, fc.fincap_incomeexpenses as fincap_incomeexpenses_checkin, 
 fc.fincap_latefee as fincap_latefee_checkin
from demographic d join records r on r.clientid = d.clientid
left join employment e on e.employmentid = r.employmentid
left join financials f on f.financialsid=r.financialsid
left join fincap fc on fc.fincapid=r.fincapid														 
left join incomeexpenses i on i.incomeexpensesid=r.incomeexpensesid														 
left join bundledservices_checkin bc on bc.bundledservicesid=r.bundledservicesid
left join wages w on w.wagesid = r.wagesid
where r.date = (select date from records
order by date desc
limit 1) and r.baseline_baseline is false) s2
on s1.clientid = s2.clientid_checkin;

															  
																								  
																								  
