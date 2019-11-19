--insert one more row for JFS's missing baseline clientID 1725144
select * from demographic where agency='JFS';

begin;

insert into demographic values
('JFS', '1725144','2019 Q2', true, '1963-05-09','1960-1970','Female','White','Unknown','Unknown','Owns',2,0,'Unknown',75243,'2019-04-01','99','99');


select * from employment order by employmentid desc;    ---27111
--check the sequence for different sequence functions in tables
select last_value from records_recordid_seq;
alter sequence employment_employmentid_seq restart with 27112;
alter sequence financials_financialsid_seq restart with 27112;
alter sequence fincap_fincapid_seq restart with 27112;
alter sequence wages_wagesid_seq restart with 27112;
alter sequence incomeexpenses_incomeexpensesid_seq restart with 27112;
alter sequence bundledservices_checkin_bundledservicesid_seq restart with 27112;
alter sequence records_recordid_seq restart with 27112;



insert into employment (accessemployment, employmentstatus, employmentstartdate)
values ('Yes','Employed Part Time','2015-01-01');



insert into financials(savings, creditscore, debt)
values (null,null,null);

select * from fincap;

insert into fincap(fincap_budget, fincap_goals, fincap_emergencyfund, fincap_autodeposit, fincap_incomeexpenses, fincap_latefee)
values (null,null,null,null,null,null);

select * from wages;

insert into wages(wages1, hours1, wages2, hours2)
values (8.5,20,null,null);

select * from incomeexpenses;

insert into incomeexpenses(incomeclient, incomehh, publicbenefits, expenseshh)
values (680,680,null,null);

select * from bundledservices_checkin order by bundledservicesid desc;

insert into bundledservices_checkin(benefitsscreening, benefitsaccess, agencyprovidedsupport, accessincome, accessemployment, accessfinancialcoach,
bundledservices)
values (null,null,null,0,1,0,1);

insert into records(clientid, quarter, date, baseline_baseline, employmentid,financialsid, fincapid, wagesid, incomeexpensesid, bundledservicesid)		
values ('1725144', '2019 Q2', '2019-04-01',true,27112,27112,27112,27112,27112,27112);

rollback;

select * from records where clientid = '1725144';

commit;

select * from for_q;


