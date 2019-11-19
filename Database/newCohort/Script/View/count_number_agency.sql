SHOW search_path;
SET search_path TO newcohort;

---FullCohort counts:
---Count baseline # for upcoming quarter
create view count_number_worksheet as
select count(*) from demographic where date = (select date from records
order by date desc
limit 1)
union all 
---Count All baseline #
select count(*) from demographic
union all
---Count check-in # for upcoming quarter
select count(*) from records where date = (select date from records
order by date desc
limit 1) and baseline_baseline is false;


create view count_number_agency_worksheet as
select s1.*, s2.quarter_baseline_count, s3.quarter_checkin_count from 
(select agency, count(*) as alltime_baseline_count from demographic
group by agency)s1
left join
(select agency, count(*) as quarter_baseline_count from demographic where date = (select date from records
order by date desc
limit 1)
group by agency)s2
on s1.agency =s2.agency
left join
(select agency, count(r.*) as quarter_checkin_count from records r 
join demographic d on d.clientid = r.clientid
where r.date = (select date from records
order by date desc
limit 1) and r.baseline_baseline is false
group by agency)s3
on s1.agency =s3.agency;