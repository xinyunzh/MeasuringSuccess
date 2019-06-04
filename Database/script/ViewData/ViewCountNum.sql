---FullCohort counts:
---Count baseline # for upcoming quarter
select count(*) from demographic where quarter = '2019 Q1';

---Count All baseline #
select count(*) from demographic;

---Count check-in # for upcoming quarter
select count(*) from records where quarter = '2019 Q1' and baseline_baseline is false;

---create view to store agency baseline # counts:
select agency, count(*) from demographic where quarter = '2019 Q1'
group by agency;

---create view to store agency all baseline # counts:
select agency, count(*) from demographic
group by agency;

--create view to store agency check-in # for upcoming quarter
select agency, count(r.*) from records r 
join demographic d on d.clientid = r.clientid
where r.quarter = '2019 Q1' and r.baseline_baseline is false
group by agency;