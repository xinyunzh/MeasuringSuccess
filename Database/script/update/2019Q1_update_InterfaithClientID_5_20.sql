--update Interfaith's duplicate check-in clientID

--find the recordId for the wrong clientID for Interfaith    
--employmentstartdate should be '2017-06-01'
select d.dob, d.gender, d.race, d.maritalstatus, r.recordid, r.clientid, r.quarter, r.date, r.baseline_baseline, e.employmentstartdate from records r 
join demographic d on d.clientid = r.clientid
join employment e on e.employmentid =r.employmentid
where r.clientid like '15011819%';
--the recordid is 24367  should be changed to 150118191

--the employmentstartdate should be '2018-12-17'
select d.dob, d.gender, d.race, d.maritalstatus, r.recordid, r.clientid, r.quarter, r.date, r.baseline_baseline, e.employmentstartdate from records r 
join demographic d on d.clientid = r.clientid
join employment e on e.employmentid =r.employmentid
where r.clientid like '15092118%';
--the recordid is 24362  should be changed to 150921181

--the employmentstartdate should be '2018-11-13'
select d.dob, d.gender, d.race, d.maritalstatus, r.recordid, r.clientid, r.quarter, r.date, r.baseline_baseline, e.employmentstartdate from records r 
join demographic d on d.clientid = r.clientid
join employment e on e.employmentid =r.employmentid
where r.clientid like '15112718%';
--the recordis is 24368  should be changed to 151127181

begin;
update records set clientid = case
when recordid = '24367' then '150118191'
when recordid = '24362' then '150921181'
when recordid = '24368' then '151127181'
end
where recordid in ('24367',
'24362',
'24368'
);
commit;



