
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
HousingType varchar(20),
HHAdults smallint,
HHChildren smallint,
CriminalBackground varchar(20),
Zipcode int,
date timestamp
);

create table records(
RecordID serial primary key,
ClientID varchar(50),
Quarter varchar(10),
Baseline_Baseline boolean
);

create table Employment(
EmploymentID serial primary key,
AccessEmployment varchar(10),
EmploymentStatus varchar(50),
EmploymentStartDate timestamp,
EmploymentRetention varchar(10),
JobTrainingEnrolled varchar(10),
JobTrainingCompleted varchar(10)
);

create table Employment_Client(
RecordID int references Client(RecordID),
EmploymentID int references Employment(EmploymentID),
primary key(RecordID, EmploymentID));

create table Financials(
FinancialsID serial primary key,
Savings numeric,
CreditScore smallint,
Debt numeric
);

create table Financials_Client(
RecordID int references Client(RecordID),
FinancialsID int references Financials(FinancialsID),
primary key(RecordID, FinancialsID));


create table FinCap(
FinCapID serial primary key,
FinCap_Budget varchar(10),
FinCap_Goals varchar(50),
FinCap_EmergencyFund varchar(10),
FinCap_AutoDeposit varchar(10),
FinCap_IncomeExpenses varchar(20),
FinCap_LateFee varchar(10));


create table FinCap_Client(
RecordID int references Client(RecordID),
FinCapID int references FinCap(FinCapID),
primary key(RecordID, FinCapID));



create table Wages(
WagesID serial primary key,
Wages1 numeric,
Hours1 numeric,
Wages2 numeric,
Hours2 numeric
);


create table Wages_Client(
RecordID int references Client(RecordID),
WagesID int references Wages(WagesID),
primary key(RecordID, WagesID));



create table IncomeExpenses(
IncomeExpensesID serial primary key,
IncomeClient numeric,
IncomeHH numeric,
PublicBenefits numeric,
ExpensesHH numeric);


create table IncomeExpenses_Client(
RecordID int references Client(RecordID),
IncomeExpensesID int references IncomeExpenses(IncomeExpensesID),
primary key(RecordID, IncomeExpensesID));


create table BundledServices_checkin(
BundledServicesID serial primary key,
BenefitsScreening varchar(10),
BenefitsAccess varchar(10),
AgencyProvidedSupport varchar(10),
AccessIncome varchar(10),
AccessEmployment varchar(10),
AccessFinancialCoach varchar(10),
BundledServices smallint check(BundledServices>=0));

create table BundledServices_checkin_client(
RecordID int references Client(RecordID),
BundledServicesID int references BundledServices_checkin(BundledServicesID),
primary key(RecordID, BundledServicesID));


create table BundledServices_Alltime(
Clientid varchar(50)  primary key,
AccessIncome varchar(10),
AccessEmployment varchar(10),
AccessFinancialCoach varchar(10),
BundledServices smallint
);


create table employment_alltime(
clientid varchar(50) primary key,
empstatus_recent_checkin varchar(50),
empdate_recent_checkin varchar(50),
months smallint,
months_bin  varchar(50));

create table checkin_time(
clientid varchar(50) primary key,
checkin_time smallint
)




-- for join baseline and checkin values
select s1.*, s2.* from 
(select d.*, e.* from demographic d 
join records c on d.clientid = c.clientid left join employment_client ec on ec.recordid = c.recordid left join employment e on e.employmentid = ec.employmentid
where c.baseline_baseline is true) s1
left join 
(select c.clientid, e.*
from employment e join records c on c.recordid = e.employmentid 
where quarter = '2018 Q4' and baseline_baseline is false) s2
on s1.clientid = s2.clientid;





-- demographic table looks fine
select * from demographic;
--need to update 15DJ09011971, to use 2015Q3 checkin data as baseline;
update demographic
set quarter = '2015 Q3'
where clientid = '15DJ09011971';

update demographic
set baseline_baseline = true
where clientid = '15DJ09011971';





insert into records(clientid, quarter, date, baseline_baseline)
select clientid, quarter, date, baseline_baseline from client;
--23663
select * from records
where clientid = '15DJ09011971';

--need to drop recordid =6447 since there are two 2015 Q4 checkins
--delete from records
--where recordid = 6447;

--update baseline to be true

--select count(*) from records;
--23662 deleted one duplicate records in records
--update records
--set baseline_baseline = true
--where recordid=7073;






