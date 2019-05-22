--Updating data for IRC
--Need to insert clientid 160018, 160092 into demographic table as baseline data here
--Need to update clientid 160092 as a baseline data in records table
--Need to update employment data
--Need to update wage data
--Need to insert clientid 160018 into records tables as it is a new records coming

select * from demographic;

begin;
rollback;
commit;

insert into demographic
values
('IRC', '160018','2019 Q1', true, '11/30/1997', '1991-2000', 'Female', 'Other', 'Married or Domestic Partnership', 'Unknown', 'Rents', 1,0, 'Unknown','75231',
	  '2019-01-01'),
('IRC', '160092','2019 Q1', true, '08/03/1991', '1991-2000', 'Male', 'Other', 'Single', 'Unknown', 'Rents', 1,0, 'Unknown','75238', '2019-01-01');

--select * from demographic where clientid = '160018';
select d.agency, r.clientid, e.* from records r 
join demographic d on d.clientid = r.clientid
join employment e on e.employmentid = r.employmentid
where r.clientid in ('160001', '160015', '160064', '160088', '160090', '160094');

--need to update employmentid 24395, 24409, 24456, 24479, 24481, 24484, 24502
--160001 employmentid 24395 employmentstatus to 3
--160015 employmentid 24409 employmentstartdate to '2018-11-15'
--160064 employmentid 24456 employmentstatus to 3
--160088 employmentid 24479 employmentstartdate to '2016-07-11'
--160090 employmentid 24481 employmentstartdate to '2019-01-09'
--160094 employmentid 24484 employmentstartdate to '2018-09-15'


--update employmentstartdate
update employment set employmentstartdate = case
when employmentid =24409 then to_timestamp(20181115)
when employmentid =24479 then to_timestamp(20160711)
when employmentid =24481 then to_timestamp(20190109)
when employmentid =24484 then to_timestamp(20180915)
end
where employmentid in (24409,24479,24481,24484);

--update employmentstatus
update employment set employmentstatus = case
when employmentid =24395 then 'Not employed'
when employmentid =24456 then 'Not employed'
end
where employmentid in (24395,24456);

select * from records where clientid ='160092';

update records set baseline_baseline =true
where clientid = '160092';

select d.agency, r.clientid, w.* from records r 
join demographic d on d.clientid = r.clientid
join wages w on w.wagesid = r.wagesid
where r.clientid ='160060' and r.baseline_baseline is false;

--update wagesid 24516 to wages1 10.00, hours1 40

update wages
set wages1 = 10.00,
hours1 = 40
where wagesid =24516;
commit;

--insert clientid 160018 into every table
select * from employment order by employmentid desc limit 5;     --25416 is the last id
select * from records order by financialsid desc limit 5;

--employment
insert into employment (accessemployment, employmentstatus, employmentstartdate, employmentretention, jobtrainingenrolled, jobtrainingcompleted)
values('Yes', 'Employed Full Time', to_timestamp(20190327), null, null, null);                --25417

--financials
insert into financials(savings, creditscore, debt)
values(0,0,0);

--fincaps
insert into fincap(fincap_budget, fincap_goals, fincap_emergencyfund, fincap_autodeposit, fincap_incomeexpenses, fincap_latefee)
values(null, null, null, null, null, null);

--wages
insert into wages(wages1, hours1, wages2, hours2)
values(0,0,0,0);

--incomeexpenses
insert into incomeexpenses(incomeclient, incomehh, publicbenefits, expenseshh)
values(0,0,1075,483.22);

select * from bundledservices_checkin;
--bundledservices
insert into bundledservices_checkin(benefitsscreening, benefitsaccess, agencyprovidedsupport, accessincome, accessemployment, accessfinancialcoach,
bundledservices)
values('Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'No', 2);

--insert into records
insert into records(clientid, quarter, date, baseline_baseline, employmentid,financialsid, fincapid, wagesid, incomeexpensesid, bundledservicesid)														 
values('160018', '2019 Q1', '2019-01-01', true, 25417,25417,25417,25417,25417,25417)

select * from records where clientid ='160018';

select * from for_q;    --1264









