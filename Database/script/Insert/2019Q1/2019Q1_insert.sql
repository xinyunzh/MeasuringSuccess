DROP TABLE temp_records;--copy data from csv file
copy demographic from 'C:\Users\Leah Zhang\Desktop\database\CSVs2\demographic.csv' DELIMITER  ',' csv header;

select count(*) from demographic;    ---7498=7010+488

--------------------------employment-------------------------------
create table temp_employment(
employmentid int,
AccessEmployment varchar(10),
EmploymentStatus varchar(50),
EmploymentStartDate timestamp,
EmploymentRetention varchar(10),
JobTrainingEnrolled varchar(10),
JobTrainingCompleted varchar(10)
);

copy temp_employment from 'C:\Users\Leah Zhang\Desktop\database\CSVs2\employment.csv' DELIMITER  ',' csv header;

select count(*) from temp_employment;    ---1753
--insert real data into employment
insert into employment (accessemployment, employmentstatus, employmentstartdate, employmentretention, jobtrainingenrolled, jobtrainingcompleted)
select accessemployment, employmentstatus, employmentstartdate, employmentretention, jobtrainingenrolled, jobtrainingcompleted from temp_employment
order by employmentid;

drop table temp_employment;

select * from employment;           --25416=23663+1753

---------------------------------------financials-----------------------------------------
--create temp table for financials
create table temp_financials(
fid int,
Savings numeric,
CreditScore smallint,
Debt numeric
);

--copy data
copy temp_financials from 'C:\Users\Leah Zhang\Desktop\database\CSVs2\financials.csv' DELIMITER  ',' csv header;

select count(*) from temp_financials;              ---1753

--insert data
insert into financials(savings, creditscore, debt)
select savings, creditscore, debt from temp_financials order by fid;

drop table temp_financials;

select * from financials;   --25416

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

copy temp_fincap from 'C:\Users\Leah Zhang\Desktop\database\CSVs2\fincap.csv' DELIMITER  ',' csv header;

select * from temp_fincap;       ---1753

					   
insert into fincap(fincap_budget, fincap_goals, fincap_emergencyfund, fincap_autodeposit, fincap_incomeexpenses, fincap_latefee)
select fincap_budget, fincap_goals, fincap_emergencyfund, fincap_autodeposit, fincap_incomeexpenses, fincap_latefee from temp_fincap
order by fincapid;

drop table temp_fincap;

select * from fincap;    --25416

-----------------------------------wages---------------------------------------
create table temp_wages(
wagesid int,
Wages1 numeric,
Hours1 numeric,
Wages2 numeric,
Hours2 numeric
);
			   
copy temp_wages from 'C:\Users\Leah Zhang\Desktop\database\CSVs2\wages.csv' DELIMITER  ',' csv header;			--23663
					   
select * from temp_wages;               ---1753

insert into wages(wages1, hours1, wages2, hours2)
select wages1, hours1, wages2, hours2 from temp_wages order by wagesid;
					   
drop table temp_wages;

select * from wages;    --25416


---------------------------------incomeexpenses--------------------------------------
create table temp_incomeexpenses(
IncomeExpensesID int ,
IncomeClient numeric,
IncomeHH numeric,
PublicBenefits numeric,
ExpensesHH numeric
)	;				   

copy temp_incomeexpenses from 'C:\Users\Leah Zhang\Desktop\database\CSVs2\incomeexpenses.csv' DELIMITER  ',' csv header;	
					   					   
insert into incomeexpenses(incomeclient, incomehh, publicbenefits, expenseshh)
select incomeclient, incomehh, publicbenefits, expenseshh from temp_incomeexpenses
order by incomeexpensesid;   

drop table temp_incomeexpenses;

select count(*) from incomeexpenses;                 -----25416



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
					   
copy temp_bundling_checkin from 'C:\Users\Leah Zhang\Desktop\database\CSVs2\bundledservices.csv' DELIMITER  ',' csv header;	
					   
							   
insert into bundledservices_checkin(benefitsscreening, benefitsaccess, agencyprovidedsupport, accessincome, accessemployment, accessfinancialcoach,
bundledservices)
select benefitsscreening, benefitsaccess, agencyprovidedsupport, accessincome, accessemployment, accessfinancialcoach,
bundledservices from temp_bundling_checkin
order by bundledservicesid;    --1753

drop table temp_bundling_checkin;

select count(*) from bundledservices_checkin;                ---25416

------------------------------------------records----------------------------

--create table for records	
							   
create table temp_records(
RecordID int,
ClientID varchar(50),
Quarter varchar(10),
Baseline_Baseline boolean,
date timestamp
);  

copy temp_records from 'C:\Users\Leah Zhang\Desktop\database\CSVs2\client.csv' DELIMITER  ',' csv header;	--1753	

--insert into records values from different tables join by row numbers														 
insert into records(clientid, quarter, date, baseline_baseline, employmentid,financialsid, fincapid, wagesid, incomeexpensesid, bundledservicesid)														 
select 	clientid, quarter, date, baseline_baseline, employmentid,financialsid, fincapid, wagesid, incomeexpensesid, bundledservicesid  from													 
(select clientid, quarter, date, baseline_baseline, row_number() over (order by recordid) r from temp_records)a
join
(select employmentid, row_number() over (order by employmentid) r from employment
where employmentid >23663)b														 
on a.r=b.r
join 														 
(select financialsid, row_number() over (order by financialsid) r from financials
where financialsid >23663)c
on b.r=c.r
join
(select fincapid, row_number() over (order by fincapid) r from fincap
where fincapid >23663)d
on c.r=d.r														 
join 														 														 
(select wagesid, row_number() over (order by wagesid) r from wages
where wagesid >23663)e
on d.r=e.r
join														 
(select incomeexpensesid, row_number() over (order by incomeexpensesid) r from incomeexpenses
where incomeexpensesid >23663)f														 
on e.r=f.r
join														 
(select bundledservicesid, row_number() over (order by bundledservicesid) r from bundledservices_checkin
where bundledservicesid >23663)g															 
on f.r=g.r;	

DROP TABLE temp_records;

select count(*) from records ;              ----25415------

--------------Finished inserting new data---------------------
-------------since I deleted one row recordid = 6447, total count is 25415 instead of 25416--------------