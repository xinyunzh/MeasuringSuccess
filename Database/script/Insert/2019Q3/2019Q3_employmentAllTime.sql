--create different views for each topic we have combining clientid and quarterly check-in information

create view employment_for_cal as 
select s1.*, s2.employmentstatus as employmentstatus_2015Q3, s2.employmentstartdate as employmentstartdate_2015Q3, 
s3.employmentstatus as employmentstatus_2015Q4, s3.employmentstartdate as employmentstartdate_2015Q4, 
s4.employmentstatus as employmentstatus_2016Q1, s4.employmentstartdate as employmentstartdate_2016Q1, 
s5.employmentstatus as employmentstatus_2016Q2, s5.employmentstartdate as employmentstartdate_2016Q2, 
s6.employmentstatus as employmentstatus_2016Q3, s6.employmentstartdate as employmentstartdate_2016Q3,
s7.employmentstatus as employmentstatus_2016Q4, s7.employmentstartdate as employmentstartdate_2016Q4, 
s8.employmentstatus as employmentstatus_2017Q1, s8.employmentstartdate as employmentstartdate_2017Q1, 
s9.employmentstatus as employmentstatus_2017Q2, s9.employmentstartdate as employmentstartdate_2017Q2, 
s10.employmentstatus as employmentstatus_2017Q3, s10.employmentstartdate as employmentstartdate_2017Q3, 
s11.employmentstatus as employmentstatus_2017Q4, s11.employmentstartdate as employmentstartdate_2017Q4, 
s12.employmentstatus as employmentstatus_2018Q1, s12.employmentstartdate as employmentstartdate_2018Q1, 
s13.employmentstatus as employmentstatus_2018Q2, s13.employmentstartdate as employmentstartdate_2018Q2, 
s14.employmentstatus as employmentstatus_2018Q3, s14.employmentstartdate as employmentstartdate_2018Q3, 
s15.employmentstatus as employmentstatus_2018Q4, s15.employmentstartdate as employmentstartdate_2018Q4,
s16.employmentstatus as employmentstatus_2019Q1, s16.employmentstartdate as employmentstartdate_2019Q1,
s17.employmentstatus as employmentstatus_2019Q2, s17.employmentstartdate as employmentstartdate_2019Q2,
s18.employmentstatus as employmentstatus_2019Q3, s18.employmentstartdate as employmentstartdate_2019Q3
from 
(select clientid, quarter, date, baseline_baseline, employmentstatus, employmentstartdate from employment_all
where baseline_baseline is true)s1
left join
(select clientid, employmentstatus, employmentstartdate from employment_all
where quarter = '2015 Q3' and baseline_baseline is false)s2
on s2.clientid = s1.clientid
left join
(select clientid, employmentstatus, employmentstartdate from employment_all
where quarter ='2015 Q4' and baseline_baseline is false)s3
on s3.clientid = s1.clientid
left join
(select clientid, employmentstatus, employmentstartdate from employment_all
where quarter ='2016 Q1' and baseline_baseline is false)s4
on s4.clientid = s1.clientid
left join
(select clientid, employmentstatus, employmentstartdate from employment_all
where quarter ='2016 Q2' and baseline_baseline is false)s5
on s5.clientid = s1.clientid
left join
(select clientid, employmentstatus, employmentstartdate from employment_all
where quarter ='2016 Q3' and baseline_baseline is false)s6
on s6.clientid = s1.clientid
left join
(select clientid, employmentstatus, employmentstartdate from employment_all
where quarter ='2016 Q4' and baseline_baseline is false)s7
on s7.clientid = s1.clientid
left join
(select clientid, employmentstatus, employmentstartdate from employment_all
where quarter ='2017 Q1' and baseline_baseline is false)s8
on s8.clientid = s1.clientid
left join
(select clientid, employmentstatus, employmentstartdate from employment_all
where quarter ='2017 Q2' and baseline_baseline is false)s9
on s9.clientid = s1.clientid
left join
(select clientid, employmentstatus, employmentstartdate from employment_all
where quarter ='2017 Q3' and baseline_baseline is false)s10
on s10.clientid = s1.clientid
left join
(select clientid, employmentstatus, employmentstartdate from employment_all
where quarter ='2017 Q4' and baseline_baseline is false)s11
on s11.clientid = s1.clientid
left join
(select clientid, employmentstatus, employmentstartdate from employment_all
where quarter ='2018 Q1' and baseline_baseline is false)s12
on s12.clientid = s1.clientid
left join
(select clientid, employmentstatus, employmentstartdate from employment_all
where quarter ='2018 Q2' and baseline_baseline is false)s13
on s13.clientid = s1.clientid
left join
(select clientid, employmentstatus, employmentstartdate from employment_all
where quarter ='2018 Q3' and baseline_baseline is false)s14
on s14.clientid = s1.clientid
left join
(select clientid, employmentstatus, employmentstartdate from employment_all
where quarter ='2018 Q4' and baseline_baseline is false)s15
on s15.clientid = s1.clientid
left join 
(select clientid, employmentstatus, employmentstartdate from employment_all
where quarter ='2019 Q1' and baseline_baseline is false)s16
on s16.clientid = s1.clientid
left join 
(select clientid, employmentstatus, employmentstartdate from employment_all
where quarter ='2019 Q2' and baseline_baseline is false)s17
on s17.clientid = s1.clientid
left join 
(select clientid, employmentstatus, employmentstartdate from employment_all
where quarter ='2019 Q3' and baseline_baseline is false)s18
on s18.clientid = s1.clientid;

create view employment_alltime_view as 
select clientid, 
case
when employmentstatus_2019q3 is not null then  '2019q3'
when employmentstatus_2019q2 is not null then  '2019q2'
when employmentstatus_2019q1 is not null then  '2019q1'
when employmentstatus_2018q4 is not null then  '2018q4'
when employmentstatus_2018q3 is not null then  '2018q3'
when employmentstatus_2018q2 is not null then  '2018q2'
when employmentstatus_2018q1 is not null then  '2018q1'
when employmentstatus_2017q4 is not null then  '2017q4'
when employmentstatus_2017q3 is not null then  '2017q3'
when employmentstatus_2017q2 is not null then  '2017q2'
when employmentstatus_2017q1 is not null then  '2017q1'
when employmentstatus_2016q4 is not null then  '2016q4'
when employmentstatus_2016q3 is not null then  '2016q3'
when employmentstatus_2016q2 is not null then  '2016q2'
when employmentstatus_2016q1 is not null then  '2016q1'
when employmentstatus_2015q4 is not null then  '2015q4'
when employmentstatus_2015q3 is not null then  '2015q3'
else 'baseline'
end as emp_quarter,
case
when employmentstatus_2019q3 is not null then  employmentstatus_2019q3
when employmentstatus_2019q2 is not null then  employmentstatus_2019q2
when employmentstatus_2019q1 is not null then  employmentstatus_2019q1
when employmentstatus_2018q4 is not null then  employmentstatus_2018q4
when employmentstatus_2018q3 is not null then  employmentstatus_2018q3
when employmentstatus_2018q2 is not null then  employmentstatus_2018q2
when employmentstatus_2018q1 is not null then  employmentstatus_2018q1
when employmentstatus_2017q4 is not null then  employmentstatus_2017q4
when employmentstatus_2017q3 is not null then  employmentstatus_2017q3
when employmentstatus_2017q2 is not null then  employmentstatus_2017q2
when employmentstatus_2017q1 is not null then  employmentstatus_2017q1
when employmentstatus_2016q4 is not null then  employmentstatus_2016q4
when employmentstatus_2016q3 is not null then  employmentstatus_2016q3
when employmentstatus_2016q2 is not null then  employmentstatus_2016q2
when employmentstatus_2016q1 is not null then  employmentstatus_2016q1
when employmentstatus_2015q4 is not null then  employmentstatus_2015q4
when employmentstatus_2015q3 is not null then  employmentstatus_2015q3
else employmentstatus
end as emp,
case
when employmentstatus_2019q3 is not null then  employmentstartdate_2019q3
when employmentstatus_2019q2 is not null then  employmentstartdate_2019q2
when employmentstatus_2019q1 is not null then  employmentstartdate_2019q1
when employmentstatus_2018q4 is not null then  employmentstartdate_2018q4
when employmentstatus_2018q3 is not null then  employmentstartdate_2018q3
when employmentstatus_2018q2 is not null then  employmentstartdate_2018q2
when employmentstatus_2018q1 is not null then  employmentstartdate_2018q1
when employmentstatus_2017q4 is not null then  employmentstartdate_2017q4
when employmentstatus_2017q3 is not null then  employmentstartdate_2017q3
when employmentstatus_2017q2 is not null then  employmentstartdate_2017q2
when employmentstatus_2017q1 is not null then  employmentstartdate_2017q1
when employmentstatus_2016q4 is not null then  employmentstartdate_2016q4
when employmentstatus_2016q3 is not null then  employmentstartdate_2016q3
when employmentstatus_2016q2 is not null then  employmentstartdate_2016q2
when employmentstatus_2016q1 is not null then  employmentstartdate_2016q1
when employmentstatus_2015q4 is not null then  employmentstartdate_2015q4
when employmentstatus_2015q3 is not null then  employmentstartdate_2015q3
else employmentstartdate
end as emp_date
from employment_for_cal
order by clientid asc;

create view employment_month as 
select clientid, emp_quarter, emp,  emp_date,  date_part('year', age(now(),emp_date))*12+date_part('month', age(now(),emp_date)) as months
from employment_alltime_view;

																								  
create table employment_alltime_2019Q3(
clientid varchar(50) primary key,
emp_quarter varchar(50),
emp_recent varchar(50),
emp_date timestamp,
months int,
monthsbin text);
																								  
insert into 	employment_alltime_2019Q3(																							  
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
