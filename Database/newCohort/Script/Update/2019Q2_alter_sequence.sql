SET search_path TO newcohort;

select * from newcohort.records;

delete from newcohort.records 
where quarter ='2019 Q2';

select last_value from records_recordid_seq;

alter sequence records_recordid_seq restart with 13;

create table temp_records(
RecordID int,
ClientID varchar(50),
Quarter varchar(10),
Baseline_Baseline boolean,
date timestamp
);  

copy temp_records from 'C:\Users\Leah Zhang\Desktop\database\newCohort\CSVs_2019Q2\client.csv' DELIMITER  ',' csv header;	--182	


--insert into records values from different tables join by row numbers														 
insert into records(clientid, quarter, date, baseline_baseline, employmentid,financialsid, fincapid, wagesid, incomeexpensesid, bundledservicesid)														 
select 	clientid, quarter, date, baseline_baseline, employmentid,financialsid, fincapid, wagesid, incomeexpensesid, bundledservicesid  from													 
(select clientid, quarter, date, baseline_baseline, row_number() over (order by recordid) r from temp_records)a
join
(select employmentid, row_number() over (order by employmentid) r from employment
where employmentid >12)b														 
on a.r=b.r
join 														 
(select financialsid, row_number() over (order by financialsid) r from financials
where financialsid >12)c
on b.r=c.r
join
(select fincapid, row_number() over (order by fincapid) r from fincap
where fincapid >12)d
on c.r=d.r														 
join 														 														 
(select wagesid, row_number() over (order by wagesid) r from wages
where wagesid >12)e
on d.r=e.r
join														 
(select incomeexpensesid, row_number() over (order by incomeexpensesid) r from incomeexpenses
where incomeexpensesid >12)f														 
on e.r=f.r
join														 
(select bundledservicesid, row_number() over (order by bundledservicesid) r from bundledservices_checkin
where bundledservicesid >12)g															 
on f.r=g.r;	

DROP TABLE temp_records;

select * from records ;               ----194=182+12------


