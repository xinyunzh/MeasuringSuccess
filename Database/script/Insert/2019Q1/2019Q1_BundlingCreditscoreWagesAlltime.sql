--copy																								  
--(select * from bundledservices_all) to 'C:\Users\Leah Zhang\Desktop\database\exports\bundledservices.csv' csv header;
begin;		

CREATE TABLE BundledServices_Alltime1(
	ClientID varchar(50) primary key,
	quarter varchar(10),
	AccessIncome varchar(10),
	AccessEmployment varchar(10),
	AccessFinancialCoach varchar(10),
	BundledServices smallint);

copy BundledServices_Alltime1 from 'C:\Users\Leah Zhang\Desktop\database\BundledService_Alltime_Qiao.csv' DELIMITER  ',' csv header;

update BundledServices_Alltime1 set clientid = case
when clientid = '1.67E+11' then '1.66822E+11'
when clientid = '1.66E+11' then '1.66166E+11'
end
where clientid in ('1.67E+11','1.66E+11');
											  
CREATE TABLE BundledServices_Alltime_2019Q1(
	agency varchar(50),
	ClientID varchar(50) primary key,
	quarter varchar(10),
	AccessIncome varchar(10),
	AccessEmployment varchar(10),
	AccessFinancialCoach varchar(10),
	BundledServices smallint);
	
insert into bundledservices_alltime_2019Q1
select d.agency, ba1.*
from bundledservices_alltime1 ba1
join demographic d on d.clientid = ba1.clientid
order by clientid asc;

drop table bundledservices_alltime1;

----create table creditscore_recent to store most recent check-in creditscore------																								  
create table creditscore_recent1(
clientid varchar(50),
quarter_baseline varchar(10),
creditscore_baseline int,
quarter_checkin varchar(10),
creditscore_recent int,
date_checkin timestamp
);

copy creditscore_recent1 from 'C:\Users\Leah Zhang\Desktop\database\FinanceCreditscore_QZ.csv' DELIMITER  ',' csv header;

update creditscore_recent1 set clientid = case
when clientid = '1.67E+11' then '1.66822E+11'
when clientid = '1.66E+11' then '1.66166E+11'
end
where clientid in ('1.67E+11','1.66E+11');	

select * from creditscore_recent1 
order by clientid asc;


create table creditscore_recent_2019Q1(
agency varchar(50),
clientid varchar(50),
quarter_baseline varchar(10),
creditscore_baseline int,
quarter_checkin varchar(10),
creditscore_recent int,
date_checkin timestamp
);

insert into creditscore_recent_2019Q1
select agency, cr1.* from demographic d
join creditscore_recent1 cr1 on cr1.clientid = d.clientid
order by clientid asc;
																								  
drop table creditscore_recent1;

-------create wages recent table-----------------
																								  
create table wages_recent1(
clientid varchar(50),
quarter_baseline varchar(10),
wages_baseline numeric,
quarter_checkin varchar(10),
wages_recent numeric,
date_checkin timestamp
);

copy wages_recent1 from 'C:\Users\Leah Zhang\Desktop\database\WagesRecent.csv' DELIMITER  ',' csv header;

update wages_recent1 set clientid = case
when clientid = '1.67E+11' then '1.66822E+11'
when clientid = '1.66E+11' then '1.66166E+11'
end
where clientid in ('1.67E+11','1.66E+11');	

select * from wages_recent1 
order by clientid asc;


create table wages_recent_2019Q1(
agency varchar(50),
clientid varchar(50),
quarter_baseline varchar(10),
wages_baseline int,
quarter_checkin varchar(10),
wages_recent int,
date_checkin timestamp
);

insert into wages_recent_2019Q1
select agency, wr1.* from demographic d
join wages_recent1 wr1 on wr1.clientid = d.clientid
order by clientid asc;

drop table wages_recent1;
																								  
commit;																								  
																								  
