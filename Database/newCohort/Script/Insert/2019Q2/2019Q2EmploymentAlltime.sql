SHOW search_path;
SET search_path TO newcohort;


--create different views for each topic we have combining clientid and quarterly check-in information

create view employment_for_cal as 
select s1.*, 
s16.employmentstatus as employmentstatus_2019Q1, s16.employmentstartdate as employmentstartdate_2019Q1,
s17.employmentstatus as employmentstatus_2019Q2, s17.employmentstartdate as employmentstartdate_2019Q2
from 
(select clientid, quarter, date, baseline_baseline, employmentstatus, employmentstartdate from employment_all
where baseline_baseline is true)s1
left join 
(select clientid, employmentstatus, employmentstartdate from employment_all
where quarter ='2019 Q1' and baseline_baseline is false)s16
on s16.clientid = s1.clientid
left join 
(select clientid, employmentstatus, employmentstartdate from employment_all
where quarter ='2019 Q2' and baseline_baseline is false)s17
on s17.clientid = s1.clientid;

create view employment_alltime_view as 
select clientid, 
case
when employmentstatus_2019q2 is not null then  '2019q2'
when employmentstatus_2019q1 is not null then  '2019q1'
else 'baseline'
end as emp_quarter,
case
when employmentstatus_2019q2 is not null then  employmentstatus_2019q2
when employmentstatus_2019q1 is not null then  employmentstatus_2019q1
else employmentstatus
end as emp,
case
when employmentstatus_2019q2 is not null then  employmentstartdate_2019q2
when employmentstatus_2019q1 is not null then  employmentstartdate_2019q1
else employmentstartdate
end as emp_date
from employment_for_cal
order by clientid asc;

create view employment_month as 
select clientid, emp_quarter, emp,  emp_date,  date_part('year', age(now(),emp_date))*12+date_part('month', age(now(),emp_date)) as months
from employment_alltime_view;

																								  
create table employment_alltime_2019Q2(
clientid varchar(50) primary key,
emp_quarter varchar(50),
emp_recent varchar(50),
emp_date timestamp,
months int,
monthsbin text);
																								  
insert into 	employment_alltime_2019Q2(																							  
select clientid, emp_quarter, emp,emp_date, months, 
case 
when months >=0 and months <3 then 'Less than 3 months'	
when months >=3 and months <6 then 'More than 3 months but less than 6 months'																								  
when months >=6 and months <9 then 'More than 6 months but less than 9 months'
when months >=9 and months <12 then 'More than 9 months but less than 1 year'
when months >=12 and months <18 then 'More than 1 year but less than 1.5 years' 
when months >=18 and months <24 then 'More than 1.5 year but less than 2 years' 
when months >=24 then 'More than 2 years' 						  
end	as monthsbin																							  
from employment_month);

drop view employment_for_cal cascade;
