--drop schema public cascade;
--create schema public;

--GRANT ALL ON SCHEMA public TO postgres;
--GRANT ALL ON SCHEMA public TO public;

--First insert data  23663 rows


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
copy demographic from 'C:\Users\Leah\Desktop\database\demo.csv' DELIMITER  ',' csv header;

select * from demographic;

--create a temp employment table for copy employment data 
create temporary table temp_employment(
employmentid int,
AccessEmployment varchar(10),
EmploymentStatus varchar(50),
EmploymentStartDate varchar(50),
EmploymentRetention varchar(10),
JobTrainingEnrolled varchar(10),
JobTrainingCompleted varchar(10)
);

copy temp_employment from 'C:\Users\Leah\Desktop\database\emp2.csv' DELIMITER  ',' csv header;

--create the real table for employment
create table Employment(
EmploymentID serial primary key,
AccessEmployment varchar(10),
EmploymentStatus varchar(50),
EmploymentStartDate varchar(50),     --change date type to varchar for importing purpose
EmploymentRetention varchar(10),
JobTrainingEnrolled varchar(10),
JobTrainingCompleted varchar(10)
);

--insert real data into employment
insert into employment (accessemployment, employmentstatus, employmentstartdate, employmentretention, jobtrainingenrolled, jobtrainingcompleted)
select accessemployment, employmentstatus, employmentstartdate, employmentretention, jobtrainingenrolled, jobtrainingcompleted from temp_employment;

select * from employment;   --23663 rows for employment


--create temp table for financials
create temporary table temp_financials(
fid int,
Savings numeric,
CreditScore smallint,
Debt numeric
);

--copy data
copy temp_financials from 'C:\Users\Leah\Desktop\database\financials.csv' DELIMITER  ',' csv header;

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
select savings, creditscore, debt from temp_financials;

select * from financials;   --23663 rows for financials


--create temp table for fincap
create temporary table temp_fincap(
fincapid int,
FinCap_Budget varchar(10),
FinCap_Goals varchar(50),
FinCap_EmergencyFund varchar(10),
FinCap_AutoDeposit varchar(10),
FinCap_IncomeExpenses varchar(20),
FinCap_LateFee varchar(10)
);

copy temp_fincap from 'C:\Users\Leah\Desktop\database\fincap.csv' DELIMITER  ',' csv header;

create table FinCap(
FinCapID serial primary key,
FinCap_Budget varchar(10),
FinCap_Goals varchar(50),
FinCap_EmergencyFund varchar(10),
FinCap_AutoDeposit varchar(10),
FinCap_IncomeExpenses varchar(20),
FinCap_LateFee varchar(10));
					   
insert into fincap(fincap_budget, fincap_goals, fincap_emergencyfund, fincap_autodeposit, fincap_incomeexpenses, fincap_latefee)
select fincap_budget, fincap_goals, fincap_emergencyfund, fincap_autodeposit, fincap_incomeexpenses, fincap_latefee from temp_fincap;
					   
select * from fincap;    --23663 rows for fincap

create temporary table temp_wages(
wagesid int,
Wages1 numeric,
Hours1 numeric,
Wages2 numeric,
Hours2 numeric
);
			   
copy temp_wages from 'C:\Users\Leah\Desktop\database\wages.csv' DELIMITER  ',' csv header;			--23663
					   
create table Wages(
WagesID serial primary key,
Wages1 numeric,
Hours1 numeric,
Wages2 numeric,
Hours2 numeric
);

insert into wages(wages1, hours1, wages2, hours2)
select wages1, hours1, wages2, hours2 from temp_wages;
					   
select * from wages;    --23663

					   
create temporary table temp_incomeexpenses(
IncomeExpensesID int ,
IncomeClient numeric,
IncomeHH numeric,
PublicBenefits numeric,
ExpensesHH numeric
)	;				   

copy temp_incomeexpenses from 'C:\Users\Leah\Desktop\database\income.csv' DELIMITER  ',' csv header;	
					   
create table IncomeExpenses(
IncomeExpensesID serial primary key,
IncomeClient numeric,
IncomeHH numeric,
PublicBenefits numeric,
ExpensesHH numeric);

					   
insert into incomeexpenses(incomeclient, incomehh, publicbenefits, expenseshh)
select incomeclient, incomehh, publicbenefits, expenseshh from temp_incomeexpenses;   --23663
					   

create temporary table temp_bundling_checkin(BundledServicesID int,
BenefitsScreening varchar(10),
BenefitsAccess varchar(10),
AgencyProvidedSupport varchar(10),
AccessIncome varchar(10),
AccessEmployment varchar(10),
AccessFinancialCoach varchar(10),
BundledServices smallint check(BundledServices>=0)
);
					   
copy temp_bundling_checkin from 'C:\Users\Leah\Desktop\database\bundling.csv' DELIMITER  ',' csv header;	--23663
					   
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
bundledservices from temp_bundling_checkin;    --23663
							   
--create temporary table for records	
							   
create temporary table temp_records(
RecordID int,
ClientID varchar(50),
Quarter varchar(10),
Baseline_Baseline boolean,
date timestamp
);  

copy temp_records from 'C:\Users\Leah\Desktop\database\client.csv' DELIMITER  ',' csv header;					--23663		   

select recordid from temp_records;				--23663			   
select employmentid from employment;       --23663

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
														 														 
--there are two client id was slightly changed and needs to update back	in demographic table		
--update demographic table														 
--update clientid '1.67E+11' to '1.66822E+11', '1.66E+11' to '1.66166E+11'
update demographic set clientid = case
when clientid = '1.67E+11' then '1.66822E+11'
when clientid = '1.66E+11' then '1.66166E+11'
end
where clientid in ('1.67E+11','1.66E+11');														 
														 
--update records table														 
--update recordid=7073 whose clientid is 15DJ09011971, 2015Q3 data as baseline for that client
select * from records r														 
where clientid='15DJ09011971' ;

update records set baseline_baseline = true														 
where clientid='15DJ09011971' and quarter='2015 Q3'	;
														 
--delete the duplicate 2015Q4 checkin data whose recordid is 6447   
delete from records
where recordid=6447;			
										 
														 
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
														 