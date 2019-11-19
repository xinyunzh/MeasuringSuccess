--insert 2019Q3 data for new cohort
SHOW search_path;
SET search_path TO newcohort;

begin;

copy demographic from 'C:\Users\Leah Zhang\Desktop\database\newCohort\CSVs_2019Q3\demographic.csv' DELIMITER  ',' csv header;

select count(*) from demographic;    --176+100=276
commit;

create table temp_employment(
employmentid int,
AccessEmployment varchar(10),
EmploymentStatus varchar(50),
EmploymentStartDate timestamp,
EmploymentRetention varchar(10),
JobTrainingEnrolled varchar(10),
JobTrainingCompleted varchar(10)
);

copy temp_employment from 'C:\Users\Leah Zhang\Desktop\database\newCohort\CSVs_2019Q3\employment.csv' DELIMITER  ',' csv header;    --189

select count(*) from temp_employment;    ---189
--insert real data into employment
insert into employment (accessemployment, employmentstatus, employmentstartdate, employmentretention, jobtrainingenrolled, jobtrainingcompleted)
select accessemployment, employmentstatus, employmentstartdate, employmentretention, jobtrainingenrolled, jobtrainingcompleted from temp_employment
order by employmentid;

drop table temp_employment;

select * from employment;     --194+189=383

---------------------------------------financials-----------------------------------------
--create temp table for financials
create table temp_financials(
fid int,
Savings numeric,
CreditScore smallint,
Debt numeric
);

--copy data
copy temp_financials from 'C:\Users\Leah Zhang\Desktop\database\newCohort\CSVs_2019Q3\financials.csv' DELIMITER  ',' csv header;   --189

select count(*) from temp_financials;              ---189

--insert data
insert into financials(savings, creditscore, debt)
select savings, creditscore, debt from temp_financials order by fid;

drop table temp_financials;

select * from financials;   --383

----------------------------fincap--------------------------------------
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

copy temp_fincap from 'C:\Users\Leah Zhang\Desktop\database\newCohort\CSVs_2019Q3\fincap.csv' DELIMITER  ',' csv header;  --189

select * from temp_fincap;       ---189

					   
insert into fincap(fincap_budget, fincap_goals, fincap_emergencyfund, fincap_autodeposit, fincap_incomeexpenses, fincap_latefee)
select fincap_budget, fincap_goals, fincap_emergencyfund, fincap_autodeposit, fincap_incomeexpenses, fincap_latefee from temp_fincap
order by fincapid;

drop table temp_fincap;

select * from fincap;    --383

select currval('newcohort.fincap_fincapid_seq'); 

-----------------------------------wages---------------------------------------
create table temp_wages(
wagesid int,
Wages1 numeric,
Hours1 numeric,
Wages2 numeric,
Hours2 numeric
);
			   
copy temp_wages from 'C:\Users\Leah Zhang\Desktop\database\newCohort\CSVs_2019Q3\wages.csv' DELIMITER  ',' csv header;			--189
					   
select * from temp_wages;               ---189

insert into wages(wages1, hours1, wages2, hours2)
select wages1, hours1, wages2, hours2 from temp_wages order by wagesid;
					   
drop table temp_wages;

select * from wages;    --383

--accidentally inserted twice. Now to delete data and change the sequence
--delete from wages
--where wagesid>383;

--select currval('newcohort.wages_wagesid_seq');       --572
--SELECT setval('wages_wagesid_seq', 383, true); 
---------------------------------incomeexpenses--------------------------------------
create table temp_incomeexpenses(
IncomeExpensesID int ,
IncomeClient numeric,
IncomeHH numeric,
PublicBenefits numeric,
ExpensesHH numeric
)	;				   

copy temp_incomeexpenses from 'C:\Users\Leah Zhang\Desktop\database\newCohort\CSVs_2019Q3\incomeexpenses.csv' DELIMITER  ',' csv header;	--189


insert into incomeexpenses(incomeclient, incomehh, publicbenefits, expenseshh)
select incomeclient, incomehh, publicbenefits, expenseshh from temp_incomeexpenses
order by incomeexpensesid;   

drop table temp_incomeexpenses;

select count(*) from incomeexpenses;       --383


------------------------------------bundling_checkin----------------------------------
create table temp_bundling_checkin(BundledServicesID int,
BenefitsScreening varchar(10),
BenefitsAccess varchar(10),
AgencyProvidedSupport varchar(10),
AccessIncome varchar(10),
AccessEmployment varchar(10),
AccessFinancialCoach varchar(10),
BundledServices smallint check(BundledServices>=0)
);
					   
copy temp_bundling_checkin from 'C:\Users\Leah Zhang\Desktop\database\newCohort\CSVs_2019Q3\bundledservices.csv' DELIMITER  ',' csv header;	  --189
					   
							   
insert into bundledservices_checkin(benefitsscreening, benefitsaccess, agencyprovidedsupport, accessincome, accessemployment, accessfinancialcoach,
bundledservices)
select benefitsscreening, benefitsaccess, agencyprovidedsupport, accessincome, accessemployment, accessfinancialcoach,
bundledservices from temp_bundling_checkin
order by bundledservicesid;    --189

drop table temp_bundling_checkin;

select count(*) from bundledservices_checkin;      --383

------------------------------------------records----------------------------

--create table for records	
							   
create table temp_records(
RecordID int,
ClientID varchar(50),
Quarter varchar(10),
Baseline_Baseline boolean,
date timestamp
);  

copy temp_records from 'C:\Users\Leah Zhang\Desktop\database\newCohort\CSVs_2019Q3\client.csv' DELIMITER  ',' csv header;	--189	

select * from records
order by recordid desc;     --194


--insert into records values from different tables join by row numbers														 
insert into records(clientid, quarter, date, baseline_baseline, employmentid,financialsid, fincapid, wagesid, incomeexpensesid, bundledservicesid)														 
select 	clientid, quarter, date, baseline_baseline, employmentid,financialsid, fincapid, wagesid, incomeexpensesid, bundledservicesid  from													 
(select clientid, quarter, date, baseline_baseline, row_number() over (order by recordid) r from temp_records)a
join
(select employmentid, row_number() over (order by employmentid) r from employment
where employmentid >194)b														 
on a.r=b.r
join 														 
(select financialsid, row_number() over (order by financialsid) r from financials
where financialsid >194)c
on b.r=c.r
join
(select fincapid, row_number() over (order by fincapid) r from fincap
where fincapid >194)d
on c.r=d.r														 
join 														 														 
(select wagesid, row_number() over (order by wagesid) r from wages
where wagesid >194)e
on d.r=e.r
join														 
(select incomeexpensesid, row_number() over (order by incomeexpensesid) r from incomeexpenses
where incomeexpensesid >194)f														 
on e.r=f.r
join														 
(select bundledservicesid, row_number() over (order by bundledservicesid) r from bundledservices_checkin
where bundledservicesid >194)g															 
on f.r=g.r;	

DROP TABLE temp_records;

select * from records ;              --383
